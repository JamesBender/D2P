USE [ULTIPRO_WPPLAPL]
GO
/****** Object:  StoredProcedure [dbo].[dsi_sp_BuildDriverTables_EMETPLALIF]    Script Date: 6/17/2021 8:45:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMETPLALIF]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: PlatePlus

Created By: Marco Lagrosa
Business Analyst: Cheryl Petitti
Create Date: 02/09/2021
Service Request Number: TekP-2020-10-28-0004

Purpose: Metlife Life Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EMETPLALIF';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EMETPLALIF';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EMETPLALIF';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EMETPLALIF';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EMETPLALIF' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMETPLALIF', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMETPLALIF', 'TEST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMETPLALIF', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMETPLALIF', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMETPLALIF', 'SCHEDULED';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EMETPLALIF';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EMETPLALIF', @AllObjects = 'Y', @IsWeb = 'Y'
**********************************************************************************/
BEGIN

    --==========================================
    -- Declare variables
    --==========================================
    DECLARE  @FormatCode        VARCHAR(10)
            ,@ExportCode        VARCHAR(10)
            ,@StartDate         DATETIME
            ,@EndDate           DATETIME
            ,@StartPerControl   VARCHAR(9)
            ,@EndPerControl     VARCHAR(9)
            ,@FileMinCovDate    DATETIME;

    -- Set FormatCode
    SELECT @FormatCode = 'EMETPLALIF';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@FileMinCovDate  = CAST('01/01/2021' as DateTime)
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EMETPLALIF_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EMETPLALIF_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'BLFAD, ADDS, ADDC, ADDE, LTD, LTDX, LIFES, LIFEC, LIFEE, DENB, DENC, DENA, DEN, STD, ACCH, ACCL, HOSPH, HOSPL, CRE10, CRE20, CRFM1, CRFM2, CRCH1, CRCH5, CRS10, CRS5';

    IF OBJECT_ID('U_EMETPLALIF_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EMETPLALIF_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EMETPLALIF_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DedList);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

    -- Non-Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');

    -- Required OE parameters
    IF @ExportCode LIKE '%PASSIVE'
    BEGIN
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'OEType','PASSIVE');
    END;

    IF @ExportCode LIKE '%ACTIVE'
    BEGIN
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'OEType','ACTIVE');
    END;


    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

	EXEC dbo.dsi_bdm_sp_CalculateBenefitAmounts @FormatCode;


    --==========================================
    -- Build Working Tables
    --==========================================


    --=========================================
    -- Update BdmChangeReason For Dependents
    --=========================================
    UPDATE D
        SET D.BdmChangeReason = E.BdmChangeReason
    FROM dbo.U_dsi_bdm_EMETPLALIF D
    JOIN dbo.U_dsi_bdm_EMETPLALIF E
        ON E.BdmEEID = D.BdmEEID
        AND E.BdmCOID = D.BdmCOID
        AND E.BdmDedCode = D.BdmDedCode
    WHERE D.BdmRecType = 'DEP' AND E.BdmRecType = 'EMP';

    --=====================================================
    -- Update BdmUSGField2 with EmpDedTVID for Employees
    --=====================================================
    UPDATE dbo.U_dsi_bdm_EMETPLALIF
        SET BdmUSGField2 = EedEmpDedTVID
        ,BdmUSGField1 = case when eedbenamt is not null and eedbenamt > 0 then eedbenamt else dedeebenamt end
    FROM dbo.U_dsi_bdm_EMETPLALIF
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = BdmEEID
        AND EedCOID = BdmCOID
        AND EedDedCode = BdmDedCode
    WHERE BdmRecType = 'EMP' AND EedFormatCode = @FormatCode AND EedValidForExport = 'Y';


    --=======================================================
    -- Update BdmUSGField2 with DepBPlanTVID for Dependents
    --=======================================================
    UPDATE dbo.U_dsi_bdm_EMETPLALIF
        SET BdmUSGField2 = DbnDepBPlanTVID
        ,BdmUSGField1 = dedeebenamt
    FROM dbo.U_dsi_bdm_EMETPLALIF
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
        ON DbnEEID = BdmEEID
        AND DbnCOID = BdmCOID
        AND DbnDedCode = BdmDedCode
		AND DbnDepRecID = BdmDepRecID
    WHERE BdmRecType = 'DEP' AND DbnFormatCode = @FormatCode AND DbnValidForExport = 'Y';

    --======================================================
    -- Update BdmUSGField1 with Benefit Amount (EedBenAmt)
    --======================================================
   /* UPDATE dbo.U_dsi_bdm_EMETPLALIF
        SET BdmUSGField1 = CONVERT(VARCHAR(20),EedeeBenAmt)
    FROM dbo.U_dsi_bdm_EMETPLALIF
    JOIN dbo.EmpDedFull WITH (NOLOCK)
        ON EedEmpDedTVID = BdmUSGField2;
    */
    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EMETPLALIF_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EMETPLALIF_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,Max(PdhDedCalcBasisAmt) as PdhDedCalcBasisAmt
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        
    INTO dbo.U_EMETPLALIF_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EMETPLALIF_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );

    IF OBJECT_ID('U_EMETPLALIF_Consolidated','U') IS NOT NULL
    DROP TABLE dbo.U_EMETPLALIF_Consolidated;

    SELECT BdmEEID, BdmCOID, BdmRecType, BdmDepRecId 
            --Dental
            ,MAX(CASE WHEN BdmDedCode IN ('DENB', 'DENC', 'DENA', 'DEN') THEN BdmDedCode END) AS Dental_Code
            ,MAX(CASE WHEN BdmDedCode IN ('DENB', 'DENC', 'DENA', 'DEN') THEN BdmBenOption END) AS Dental_BdmBenOption
            ,MAX(CASE WHEN BdmDedCode IN ('DENB', 'DENC', 'DENA', 'DEN') THEN dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate) END) AS Dental_BdmBenStartDate
            ,MAX(CASE WHEN BdmDedCode IN ('DENB', 'DENC', 'DENA', 'DEN') THEN BdmBenStopDate END) AS Dental_BdmBenStopDate
            ,MAX(CASE WHEN BdmDedCode IN ('DENB', 'DENC', 'DENA', 'DEN') THEN BdmBenStatus END) AS Dental_BdmBenStatus
            --Basic Life
            ,MAX(CASE WHEN BdmDedCode IN ('BLFAD') THEN BdmDedCode END) AS BasicLife_Code
            ,MAX(CASE WHEN BdmDedCode IN ('BLFAD') THEN BdmBenOption END) AS BasicLife_BdmBenOption
            ,MAX(CASE WHEN BdmDedCode IN ('BLFAD') THEN dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate) END) AS BasicLife_BdmBenStartDate
            ,MAX(CASE WHEN BdmDedCode IN ('BLFAD') THEN BdmBenStopDate END) AS BasicLife_BdmBenStopDate
            ,MAX(CASE WHEN BdmDedCode IN ('BLFAD')THEN BdmBenStatus END) AS BasicLife_BdmBenStatus
              --Long Term Disability
            ,MAX(CASE WHEN BdmDedCode IN ('LTD', 'LTDX') THEN BdmDedCode END) AS LongTermDisability_Code
            ,MAX(CASE WHEN BdmDedCode IN ('LTD', 'LTDX')  THEN BdmBenOption END) AS LongTermDisability_BdmBenOption
            ,MAX(CASE WHEN BdmDedCode IN ('LTD', 'LTDX')  THEN dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate) END) AS LongTermDisability_BdmBenStartDate
            ,MAX(CASE WHEN BdmDedCode IN ('LTD', 'LTDX') THEN BdmBenStopDate END) AS LongTermDisability_BdmBenStopDate
            ,MAX(CASE WHEN BdmDedCode IN ('LTD', 'LTDX') THEN BdmBenStatus END) AS LongTermDisability_BdmBenStatus
             --Short Term Disability
            ,MAX(CASE WHEN BdmDedCode IN ('STD') THEN BdmDedCode END) AS ShortTermDisability_Code
            ,MAX(CASE WHEN BdmDedCode IN ('STD')  THEN BdmBenOption END) AS ShortTermDisability_BdmBenOption
            ,MAX(CASE WHEN BdmDedCode IN ('STD')  THEN dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate) END) AS ShortTermDisability_BdmBenStartDate
            ,MAX(CASE WHEN BdmDedCode IN ('STD') THEN BdmBenStopDate END) AS ShortTermDisability_BdmBenStopDate
            ,MAX(CASE WHEN BdmDedCode IN ('STD') THEN BdmBenStatus END) AS ShortTermDisability_BdmBenStatus

             --Supplimental Basic Life
            ,MAX(CASE WHEN BdmDedCode IN ('LIFEE') THEN BdmDedCode END) AS SupBasicLife_Code
            ,MAX(CASE WHEN BdmDedCode IN ('LIFEE')  THEN BdmBenOption END) AS SupBasicLife_BdmBenOption
            ,MAX(CASE WHEN BdmDedCode IN ('LIFEE')  THEN dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate) END) AS SupBasicLife_BdmBenStartDate
            ,MAX(CASE WHEN BdmDedCode IN ('LIFEE') THEN BdmBenStopDate END) AS SupBasicLife_BdmBenStopDate
            ,MAX(CASE WHEN BdmDedCode IN ('LIFEE') THEN BdmBenStatus END) AS SupBasicLife_BdmBenStatus
            ,MAX(CASE WHEN BdmDedCode IN ('LIFEE') THEN BdmUSGField1 END) AS SupBasicLife_BdmBenAmount
            
             --Supplimental Spouse Life
            ,MAX(CASE WHEN BdmDedCode IN ('LIFES') THEN BdmDedCode END) AS SupSpouseLife_Code
            ,MAX(CASE WHEN BdmDedCode IN ('LIFES')  THEN BdmBenOption END) AS SupSpouseLife_BdmBenOption
            ,MAX(CASE WHEN BdmDedCode IN ('LIFES')  THEN dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate) END) AS SupSpouseLife_BdmBenStartDate
            ,MAX(CASE WHEN BdmDedCode IN ('LIFES') THEN BdmBenStopDate END) AS SupSpouseLife_BdmBenStopDate
            ,MAX(CASE WHEN BdmDedCode IN ('LIFES') THEN BdmBenStatus END) AS SupSpouseLife_BdmBenStatus
            ,MAX(CASE WHEN BdmDedCode IN ('LIFES') THEN BdmUSGField1 END) AS SupSpouseLife_BdmBenAmount

              --Supplimental Children Life
            ,MAX(CASE WHEN BdmDedCode IN ('LIFEC') THEN BdmDedCode END) AS SupChildrenLife_Code
            ,MAX(CASE WHEN BdmDedCode IN ('LIFEC')  THEN BdmBenOption END) AS SupChildrenLife_BdmBenOption
            ,MAX(CASE WHEN BdmDedCode IN ('LIFEC')  THEN dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate) END) AS SupChildrenLife_BdmBenStartDate
            ,MAX(CASE WHEN BdmDedCode IN ('LIFEC') THEN BdmBenStopDate END) AS SupChildrenLife_BdmBenStopDate
            ,MAX(CASE WHEN BdmDedCode IN ('LIFEC') THEN BdmBenStatus END) AS SupChildrenLife_BdmBenStatus
            ,MAX(CASE WHEN BdmDedCode IN ('LIFEC') THEN BdmUSGField1 END) AS SupChildrenLife_BdmBenAmount

            --Supplimental Basic AD&D
            ,MAX(CASE WHEN BdmDedCode IN ('ADDE') THEN BdmDedCode END) AS SupBasicADD_Code
            ,MAX(CASE WHEN BdmDedCode IN ('ADDE')  THEN BdmBenOption END) AS SupBasicADD_BdmBenOption
            ,MAX(CASE WHEN BdmDedCode IN ('ADDE')  THEN dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate) END) AS SupBasicADD_BdmBenStartDate
            ,MAX(CASE WHEN BdmDedCode IN ('ADDE') THEN BdmBenStopDate END) AS SupBasicADD_BdmBenStopDate
            ,MAX(CASE WHEN BdmDedCode IN ('ADDE') THEN BdmBenStatus END) AS SupBasicADD_BdmBenStatus
            ,MAX(CASE WHEN BdmDedCode IN ('ADDE') THEN BdmUSGField1 END) AS SupBasicADD_BdmBenAmount

              --Supplimental Spouse AD&D
            ,MAX(CASE WHEN BdmDedCode IN ('ADDS') THEN BdmDedCode END) AS SupSpouseADD_Code
            ,MAX(CASE WHEN BdmDedCode IN ('ADDS')  THEN BdmBenOption END) AS SupSpouseADD_BdmBenOption
            ,MAX(CASE WHEN BdmDedCode IN ('ADDS')  THEN dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate) END) AS SupSpouseADD_BdmBenStartDate
            ,MAX(CASE WHEN BdmDedCode IN ('ADDS') THEN BdmBenStopDate END) AS SupSpouseADD_BdmBenStopDate
            ,MAX(CASE WHEN BdmDedCode IN ('ADDS') THEN BdmBenStatus END) AS SupSpouseADD_BdmBenStatus
            ,MAX(CASE WHEN BdmDedCode IN ('ADDS') THEN BdmUSGField1 END) AS SupSpouseADD_BdmBenAmount
            
                    --Supplimental Child AD&D
            ,MAX(CASE WHEN BdmDedCode IN ('ADDC') THEN BdmDedCode END) AS SupChildADD_Code
            ,MAX(CASE WHEN BdmDedCode IN ('ADDC')  THEN BdmBenOption END) AS SupChildADD_BdmBenOption
            ,MAX(CASE WHEN BdmDedCode IN ('ADDC')  THEN dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate) END) AS SupChildADD_BdmBenStartDate
            ,MAX(CASE WHEN BdmDedCode IN ('ADDC') THEN BdmBenStopDate END) AS SupChildADD_BdmBenStopDate
            ,MAX(CASE WHEN BdmDedCode IN ('ADDC') THEN BdmBenStatus END) AS SupChildADD_BdmBenStatus
            ,MAX(CASE WHEN BdmDedCode IN ('ADDC') THEN BdmUSGField1 END) AS SupChildADD_BdmBenAmount
            
              --Critical Illness
            ,MAX(CASE WHEN BdmDedCode IN ('CRE10', 'CRE20', 'CRFM1', 'CRFM2', 'CRCH1', 'CRCH5', 'CRS10', 'CRS5') THEN BdmDedCode END) AS CritIllness_Code
            ,MAX(CASE WHEN BdmDedCode IN ('CRE10', 'CRE20', 'CRFM1', 'CRFM2', 'CRCH1', 'CRCH5', 'CRS10', 'CRS5')  THEN BdmBenOption END) AS CritIllness_BdmBenOption
            ,MAX(CASE WHEN BdmDedCode IN ('CRE10', 'CRE20', 'CRFM1', 'CRFM2', 'CRCH1', 'CRCH5', 'CRS10', 'CRS5') THEN dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate) END) AS CritIllness_BdmBenStartDate
            ,MAX(CASE WHEN BdmDedCode IN ('CRE10', 'CRE20', 'CRFM1', 'CRFM2', 'CRCH1', 'CRCH5', 'CRS10', 'CRS5')THEN BdmBenStopDate END) AS CritIllness_BdmBenStopDate
            ,MAX(CASE WHEN BdmDedCode IN ('CRE10', 'CRE20', 'CRFM1', 'CRFM2', 'CRCH1', 'CRCH5', 'CRS10', 'CRS5') THEN BdmBenStatus END) AS CritIllness_BdmBenStatus
            ,MAX(CASE WHEN BdmDedCode IN ('CRE10', 'CRE20', 'CRFM1', 'CRFM2', 'CRCH1', 'CRCH5', 'CRS10', 'CRS5') THEN BdmUSGField1 END) AS CritIllness_BdmBenAmount

            ,MAX(CASE WHEN BdmDedCode IN ('CRE10') THEN BdmDedCode END) AS CRE10_DedCode
            ,MAX(CASE WHEN BdmDedCode IN ('CRE20') THEN BdmDedCode END) AS CRE20_DedCode
            ,MAX(CASE WHEN BdmDedCode IN ('CRFM1') THEN BdmDedCode END) AS CRFM1_DedCode
			,MAX(CASE WHEN BdmDedCode IN ('CRFM2') THEN BdmDedCode END) AS CRFM2_DedCode
            ,MAX(CASE WHEN BdmDedCode IN ('CRCH1') THEN BdmDedCode END) AS CRCH1_DedCode
            ,MAX(CASE WHEN BdmDedCode IN ('CRCH5') THEN BdmDedCode END) AS CRCH5_DedCode
            ,MAX(CASE WHEN BdmDedCode IN ('CRS10') THEN BdmDedCode END) AS CRS10_DedCode
            ,MAX(CASE WHEN BdmDedCode IN ('CRS5') THEN BdmDedCode END) AS CRS5_DedCode

                --Critical Illness Dependent
            ,MAX(CASE WHEN BdmDedCode IN ('CRCH1', 'CRCH5', 'CRS10', 'CRS5', 'CRFM1', 'CRFM2') THEN BdmDedCode END) AS CritIllnessDep_Code
            ,MAX(CASE WHEN BdmDedCode IN ('CRCH1', 'CRCH5', 'CRS10', 'CRS5', 'CRFM1', 'CRFM2')  THEN BdmBenOption END) AS CritIllnessDep_BdmBenOption
            ,MAX(CASE WHEN BdmDedCode IN ('CRCH1', 'CRCH5', 'CRS10', 'CRS5', 'CRFM1', 'CRFM2')THEN dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate) END) AS CritIllnessDep_BdmBenStartDate
            ,MAX(CASE WHEN BdmDedCode IN ('CRCH1', 'CRCH5', 'CRS10', 'CRS5', 'CRFM1', 'CRFM2')THEN BdmBenStopDate END) AS CritIllnessDep_BdmBenStopDate
            ,MAX(CASE WHEN BdmDedCode IN ('CRCH1', 'CRCH5', 'CRS10', 'CRS5', 'CRFM1', 'CRFM2') THEN BdmBenStatus END) AS CritIllnessDep_BdmBenStatus
            ,MAX(CASE WHEN BdmDedCode IN ('CRCH1', 'CRCH5', 'CRS10', 'CRS5', 'CRFM1', 'CRFM2') THEN BdmUSGField1  END) AS CritIllnessDep_BdmBenAmount

               --Group Accident
            ,MAX(CASE WHEN BdmDedCode IN ('ACCH', 'ACCL') THEN BdmDedCode END) AS GroupAccident_Code
            ,MAX(CASE WHEN BdmDedCode IN ('ACCH', 'ACCL') THEN BdmBenOption END) AS GroupAccident_BdmBenOption
            ,MAX(CASE WHEN BdmDedCode IN ('ACCH', 'ACCL') THEN dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate) END) AS GroupAccident_BdmBenStartDate
            ,MAX(CASE WHEN BdmDedCode IN ('ACCH', 'ACCL') THEN BdmBenStopDate END) AS GroupAccident_BdmBenStopDate
            ,MAX(CASE WHEN BdmDedCode IN ('ACCH', 'ACCL') THEN BdmBenStatus END) AS GroupAccident_BdmBenStatus
            ,MAX(CASE WHEN BdmDedCode IN ('ACCH', 'ACCL') THEN BdmUSGField1 END) AS GroupAccident_BdmBenAmount


               --Hospital Indemnity
            ,MAX(CASE WHEN BdmDedCode IN ('HOSPH', 'HOSPL') THEN BdmDedCode END) AS HospIndemity_Code
            ,MAX(CASE WHEN BdmDedCode IN ('HOSPH', 'HOSPL') THEN BdmBenOption END) AS HospIndemity_BdmBenOption
            ,MAX(CASE WHEN BdmDedCode IN ('HOSPH', 'HOSPL') THEN dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate) END) AS HospIndemity_BdmBenStartDate
            ,MAX(CASE WHEN BdmDedCode IN ('HOSPH', 'HOSPL') THEN BdmBenStopDate END) AS HospIndemity_BdmBenStopDate
            ,MAX(CASE WHEN BdmDedCode IN ('HOSPH', 'HOSPL')THEN BdmBenStatus END) AS HospIndemity_BdmBenStatus
            ,MAX(CASE WHEN BdmDedCode IN ('HOSPH', 'HOSPL') THEN BdmUSGField1 END) AS HospIndemity_BdmBenAmount

            INTO dbo.U_EMETPLALIF_Consolidated
            FROM dbo.U_dsi_BDM_EMETPLALIF WITH (NOLOCK)
            GROUP BY BdmEEID, BdmCOID, BdmRecType, BdmDepRecId

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EMETPLALIF_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EMETPLALIF_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EMETPLALIF_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),bdmdeprecid) --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = EepSSN + ' ' + CASE WHEN BdmRecType = 'EMP' THEN '1' ELSE '2' END
        ,drvSubsort = ''
        ,drvSubsort2 = ''
        -- standard fields above and additional driver fields below
        ,drvTransactionCode = CASE WHEN BdmRecType = 'EMP' THEN 'E' ELSE 'D' END
        ,drvCustomerNumber = '5975462' 
		/*CASE WHEN BasicLife_Code is not null or SupSpouseADD_Code is not null or SupChildADD_Code is not null or SupBasicADD_Code is not null
        or LongTermDisability_Code is not null or SupBasicLife_Code  is not null or SupSpouseLife_Code  is not null or SupChildrenLife_Code  is not null 
        or Dental_Code  is not null or ShortTermDisability_Code is not null THEN '5975462' ELSE '9232840' END*/
        ,drvEmployeeNumber = EepSSN
        ,drvMemberSocialSecurityNumber = CASE WHEN BdmRecType = 'EMP' THEN  EepSSN ELSE  ConSSN END
        ,drvMemberLastName = CASE WHEN BdmRecType = 'EMP' THEN RTRIM(LTRIM(EepNameLast)) ELSE RTRIM(LTRIM(ConNameLast)) END
        ,drvMemberFirstName = CASE WHEN BdmRecType = 'EMP' THEN RTRIM(LTRIM(EepNameFirst)) ELSE RTRIM(LTRIM(ConNameFirst)) END
        ,drvMemberMiddleInitial = CASE WHEN BdmRecType = 'EMP' THEN LEFT(EepNameMiddle,1) ELSE LEFT(ConNameMiddle,1) END
        ,drvMemberDateofBirth = CASE WHEN BdmRecType = 'EMP' THEN EepDateOfBirth ELSE ConDateOfBirth END
        ,drvMemberMaritalStatus = CASE WHEN BdmRecType = 'EMP' THEN 
									CASE WHEN ISNULL(EepMaritalStatus, '') NOT IN ('Z', '') THEN EepMaritalStatus ELSE 'U' END
								  END
        ,drvMemberGender = CASE WHEN BdmRecType = 'EMP' THEN EepGender ELSE ConGender END
        ,drvRelationshipCode = CASE WHEN BdmRecType = 'EMP' THEN '00'
                                    ELSE
                                        CASE WHEN ConRelationShip IN ('DP', 'SPS','LFP') THEN '01'
                                            WHEN ConRelationShip IN ('CH', 'CHL', 'DCH', 'DPC', 'STC', 'LDP') THEN '02'
                                        END
                                END  
        ,drvEmployeesDateofHire = EecDateOfLastHire
        ,drvPersonnelIdentification = eecempno
        ,drvEmployeeSmokerCode = CASE WHEN bdmREctype = 'EMP' THEN 
									CASE WHEN EepIsSmoker = 'Y' THEN 'S' ELSE 'N' END
								 END
        ,drvSpouseSmokerCode = CASE WHEN bdmrectype = 'DEP' and ConRelationShip IN ('DP', 'SPS','LFP') and ConIsSMoker = 'Y' THEN 'S' ELSE 'N' END
        ,drvPhoneNumber = CASE WHEN BdmRecType = 'EMP' THEN EepPhoneHomeNumber ELSE ConPhoneHomeNumber END
        ,drvEmailAddress = EepAddressEMail
        ,drvForeignAddressIndicator = 'D'
        ,drvCareofAddress = ''
        ,drvStreetAddress = dbo.dsi_fnRemoveChars('.,/-',EepAddressLine1 + ' ' + ISNULL(EepAddressLine2, ''))
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZipCode = EepAddressZipCode
        ,drvCoverageCode1 = CASE WHEN Dental_Code is not null THEN 'D' END
        ,drvCoverageStartDate1 = CASE WHEN Dental_Code is not null THEN Dental_BdmBenStartDate END
        ,drvCoverageStopDate1 = CASE WHEN Dental_Code is not null THEN Dental_BdmBenStopDate END
        ,drvGroupNumber1 = CASE WHEN Dental_Code is not null THEN '5975462' END
        ,drvSubcode1 = CASE WHEN Dental_Code is not null THEN '0003' END
        ,drvBranch1 = CASE WHEN Dental_Code in ('DENB','DENC') and EecSalaryOrHourly = 'S' THEN 'H001' 
                           WHEN Dental_Code in ('DENB','DENC') and EecSalaryOrHourly = 'H' THEN 'H003'
                           WHEN Dental_Code in ('DENA','DEN') and EecSalaryOrHourly = 'S' THEN 'L002'
                           WHEN Dental_Code in ('DENA','DEN') and EecSalaryOrHourly = 'H' THEN 'L004'
                           END
        ,drvPlanCode1 = ''
        ,drvStatusCode1 = CASE WHEN Dental_Code is not null THEN 'A' END
        ,drvMembersCoveredCode1 = CASE WHEN Dental_Code is not null THEN 
                                        CASE WHEN Dental_BdmBenOption = 'EE' THEN '1'
                                             WHEN Dental_BdmBenOption = 'EEC' THEN '2'
                                             WHEN Dental_BdmBenOption IN ('EES', 'EEDP') THEN '3'
                                             WHEN Dental_BdmBenOption IN ('EEF', 'EEDPF') THEN '4'
                                        END    
                                  END
        ,drvCancelReason1 = ''
        ,drvFacilityID = ''
        ,drvCoverageCode2 = CASE WHEN BasicLife_Code IS NOT NULL THEN 'CP' END
        ,drvCoverageStartDate2 = CASE WHEN BasicLife_Code IS NOT NULL THEN BasicLife_BdmBenStartDate END
        ,drvCoverageStopDate2 = CASE WHEN BasicLife_Code IS NOT NULL THEN BasicLife_BdmBenStopDate END
        ,drvGroupNumber2 = CASE WHEN BasicLife_Code IS NOT NULL THEN '5975462' END
        ,drvSubcode2 = CASE WHEN BasicLife_Code IS NOT NULL THEN '0003' END
        ,drvBranch2 = CASE WHEN BasicLife_Code is not null and  EXISTS(Select * from dbo.U_EMETPLALIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP' )  and EecSalaryOrHourly = 'S' THEN 'H001' 
                           WHEN BasicLife_Code is not null  and  EXISTS(Select * from dbo.U_EMETPLALIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP' )  and EecSalaryOrHourly = 'H' THEN 'H003'
                           WHEN BasicLife_Code is not null   and  EXISTS(Select * from dbo.U_EMETPLALIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP' )   and EecSalaryOrHourly = 'S' THEN 'L002'
                           WHEN BasicLife_Code is not null   and  EXISTS(Select * from dbo.U_EMETPLALIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP'  )  and EecSalaryOrHourly = 'H' THEN 'L004'
                           WHEN BasicLife_Code is not null THEN  'H001'
                           END
        ,StatusCode2 = CASE WHEN BasicLife_Code IS NOT NULL THEN 'A' END
        ,MembersCoveredCode2 = CASE WHEN BasicLife_Code IS NOT NULL THEN '1' END
        ,AnnualBenefitAmount2 = CASE WHEN BasicLife_Code IS NOT NULL THEN dbo.dsi_fnpadzero((ISNULL((Select MAX(PdhDedCalcBasisAmt) from pdedhist where pdheeid = B.bdmeeid and pdhdedcode = 'BLFAD'),0)),8,0)  END  
        ,SalaryMode2 = CASE WHEN BasicLife_Code IS NOT NULL THEN 'A' END
        ,SalaryAmount2 = CASE WHEN BasicLife_Code IS NOT NULL THEN dbo.dsi_fnpadzero((ISNULL(eecAnnSalary,0)),7,0)END 
        ,CoverageCode3 = CASE WHEN BasicLife_Code IS NOT NULL THEN 'AD' END
        ,CoverageStartDate3 = CASE WHEN BasicLife_Code IS NOT NULL THEN BasicLife_BdmBenStartDate END
        ,CoverageStopDate3 = CASE WHEN BasicLife_Code IS NOT NULL THEN BasicLife_BdmBenStopDate END
        ,GroupNumber3 = CASE WHEN BasicLife_Code IS NOT NULL THEN '5975462' END
        ,Subcode3 = CASE WHEN BasicLife_Code IS NOT NULL THEN '0003' END
        ,Branch3 = CASE WHEN BasicLife_Code is not null and  EXISTS(Select * from dbo.U_EMETPLALIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP' )  and EecSalaryOrHourly = 'S' THEN 'H001' 
                           WHEN BasicLife_Code is not null  and  EXISTS(Select * from dbo.U_EMETPLALIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP' )  and EecSalaryOrHourly = 'H' THEN 'H003'
                           WHEN BasicLife_Code is not null   and  EXISTS(Select * from dbo.U_EMETPLALIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP' )   and EecSalaryOrHourly = 'S' THEN 'L002'
                           WHEN BasicLife_Code is not null   and  EXISTS(Select * from dbo.U_EMETPLALIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP'  )  and EecSalaryOrHourly = 'H' THEN 'L004'
                           WHEN BasicLife_Code is not null THEN  'H001'
                           END
        ,StatusCode3 = CASE WHEN BasicLife_Code IS NOT NULL THEN 'A' END
        ,MembersCoveredCode3 = CASE WHEN BasicLife_Code IS NOT NULL THEN '1' END
        ,AnnualBenefitAmount3 = CASE WHEN BasicLife_Code IS NOT NULL THEN dbo.dsi_fnpadzero((ISNULL((Select MAX(PdhDedCalcBasisAmt) from pdedhist where pdheeid = B.bdmeeid and pdhdedcode = 'BLFAD'),0)),8,0)  END
        ,SalaryMode3 = CASE WHEN BasicLife_Code IS NOT NULL THEN 'A' END
        ,SalaryAmount3 = CASE WHEN BasicLife_Code IS NOT NULL THEN dbo.dsi_fnpadzero((ISNULL(eecAnnSalary,0)),7,0)END
        ,CoverageCode4 = CASE WHEN LongTermDisability_Code is not null then 'LT' END
        ,CoverageStartDate4 = CASE WHEN LongTermDisability_Code is not null then LongTermDisability_BdmBenStartDate END
        ,CoverageStopDate4 = CASE WHEN LongTermDisability_Code is not null then LongTermDisability_BdmBenStopDate END
        ,GroupNumber4 = CASE WHEN LongTermDisability_Code is not null then '5975462' END
        ,Subcode4 = CASE WHEN LongTermDisability_Code is not null then '0003' END
        ,Branch4 = CASE WHEN LongTermDisability_Code is not null and  EXISTS(Select * from dbo.U_EMETPLALIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP' )  and EecSalaryOrHourly = 'S' THEN 'H001' 
                           WHEN LongTermDisability_Code is not null  and  EXISTS(Select * from dbo.U_EMETPLALIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP' )  and EecSalaryOrHourly = 'H' THEN 'H003'
                           WHEN LongTermDisability_Code is not null   and  EXISTS(Select * from dbo.U_EMETPLALIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP' )   and EecSalaryOrHourly = 'S' THEN 'L002'
                           WHEN LongTermDisability_Code is not null   and  EXISTS(Select * from dbo.U_EMETPLALIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP'  )  and EecSalaryOrHourly = 'H' THEN 'L004'
                           WHEN LongTermDisability_Code is not null THEN  'H001'
                           END
        ,StatusCode4 = CASE WHEN LongTermDisability_Code is not null then 'A' END
        ,MembersCoveredCode4 = CASE WHEN LongTermDisability_Code is not null then '1' END
        ,MonthlyBenefitAmount4Before = CASE WHEN LongTermDisability_Code IS NOT NULL THEN dbo.dsi_fnpadzero((ISNULL((Select MAX(PdhDedCalcBasisAmt) from pdedhist where pdheeid = B.bdmeeid and pdhdedcode IN('LTD', 'LTDX' )),0)),8,0)  END
        ,MonthlyBenefitAmount4 = CASE WHEN LongTermDisability_Code IS NOT NULL THEN dbo.dsi_fnpadzero((ISNULL(  (Select top 1 bcaBenamtCalc from u_dsi_bdm_BenCalculationAmounts where bcaformatcode = @FormatCode and  bcaeeid= B.bdmeeid and bcadedcode IN('LTD', 'LTDX' ) ) ,0)),8,0)  END

		,SalaryMode4 = CASE WHEN LongTermDisability_Code is not null then 'A' END
        ,SalaryAmount4 = CASE WHEN LongTermDisability_Code IS NOT NULL THEN dbo.dsi_fnpadzero((ISNULL(eecAnnSalary,0)),7,0)END
        ,CoverageCode5 = CASE WHEN ShortTermDisability_Code IS NOT NULL THEN 'AS' END 
        ,CoverageStartDate5 = CASE WHEN ShortTermDisability_Code IS NOT NULL THEN ShortTermDisability_BdmBenStartDate END 
        ,CoverageStopDate5 = CASE WHEN ShortTermDisability_Code IS NOT NULL THEN ShortTermDisability_BdmBenStopDate END 
        ,GroupNumber5 = CASE WHEN ShortTermDisability_Code is not null then '0317365' END
        ,Subcode5 = CASE WHEN ShortTermDisability_Code is not null then '0005' END
        ,Branch5 = CASE WHEN ShortTermDisability_Code is not null then '0001' END
        ,StatusCode5 = CASE WHEN ShortTermDisability_Code is not null then 'A' END
        ,MembersCoveredCode5 = CASE WHEN ShortTermDisability_Code is not null then '1' END
        ,drvWeeklyBenefitAmount5Before = CASE WHEN ShortTermDisability_Code IS NOT NULL THEN dbo.dsi_fnpadzero((ISNULL((Select MAX(PdhDedCalcBasisAmt) from pdedhist where pdheeid = B.bdmeeid and pdhdedcode IN('STD')),0)),8,0)  END
         ,drvWeeklyBenefitAmount5 = CASE WHEN ShortTermDisability_Code IS NOT NULL THEN dbo.dsi_fnpadzero((ISNULL( CASE WHEN  (Select top 1 (eecannsalary/52) * 0.75 from dbo.empcomp  where eeceeid = B.bdmeeid) > 1500 THEN 1500 ELSE (Select top 1 (eecannsalary/52) * 0.75 from dbo.empcomp  where eeceeid = B.bdmeeid) END ,0)),8,0)  END

        ,drvSalaryMode5 = CASE WHEN ShortTermDisability_Code is not null then 'A' END
        ,drvSalaryAmount5 = CASE WHEN ShortTermDisability_Code IS NOT NULL THEN dbo.dsi_fnpadzero((ISNULL(eecAnnSalary,0)),7,0)END
        ,drvCoverageCode7 = CASE WHEN SupBasicLife_Code IS NOT NULL THEN 'OP' END
        ,drvCoverageStartDate7 = CASE WHEN SupBasicLife_Code IS NOT NULL THEN SupBasicLife_BdmBenStartDate END
        ,drvCoverageStopDate7 = CASE WHEN SupBasicLife_Code IS NOT NULL THEN SupBasicLife_BdmBenStopDate END
        ,drvGroupNumber7 = CASE WHEN SupBasicLife_Code IS NOT NULL THEN '5975462' END
        ,drvSubcode7 = CASE WHEN SupBasicLife_Code IS NOT NULL THEN '0003' END
        ,drvBranch7 = CASE WHEN SupBasicLife_Code is not null and  EXISTS(Select * from dbo.U_EMETPLALIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP' )  and EecSalaryOrHourly = 'S' THEN 'H001' 
                           WHEN SupBasicLife_Code is not null  and  EXISTS(Select * from dbo.U_EMETPLALIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP' )  and EecSalaryOrHourly = 'H' THEN 'H003'
                           WHEN SupBasicLife_Code is not null   and  EXISTS(Select * from dbo.U_EMETPLALIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP' )   and EecSalaryOrHourly = 'S' THEN 'L002'
                           WHEN SupBasicLife_Code is not null   and  EXISTS(Select * from dbo.U_EMETPLALIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP'  )  and EecSalaryOrHourly = 'H' THEN 'L004'
                           WHEN SupBasicLife_Code is not null THEN  'H001'
                           END
        
        ,drvStatusCode7 = CASE WHEN SupBasicLife_Code IS NOT NULL THEN 'A' END
        ,drvMembersCoveredCode7 = CASE WHEN SupBasicLife_Code IS NOT NULL THEN '1' END
        ,AnnualBenefitAmount7 = CASE WHEN SupBasicLife_Code IS NOT NULL THEN dbo.dsi_fnpadzero((ISNULL(SupBasicLife_BdmBenAmount,0)),8,0)  END
        ,SalaryMode7 = CASE WHEN SupBasicLife_Code IS NOT NULL THEN 'A' END
        ,SalaryAmount7 = CASE WHEN SupBasicLife_Code IS NOT NULL THEN dbo.dsi_fnpadzero((ISNULL(eecAnnSalary,0)),7,0) END
        ,CoverageCode8 = CASE WHEN SupSpouseLife_Code IS NOT NULL THEN 'LZ' END
        ,CoverageStartDate8 = CASE WHEN SupSpouseLife_Code IS NOT NULL THEN SupSpouseLife_BdmBenStartDate END
        ,CoverageStopDate8 = CASE WHEN SupSpouseLife_Code IS NOT NULL THEN SupSpouseLife_BdmBenStopDate END
        ,GroupNumber8 = CASE WHEN SupSpouseLife_Code IS NOT NULL THEN '5975462' END
        ,drvSubcode8 = CASE WHEN SupSpouseLife_Code IS NOT NULL THEN '0003' END
        ,drvBranch8 = CASE WHEN SupSpouseLife_Code is not null and  EXISTS(Select * from dbo.U_EMETPLALIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP' )  and EecSalaryOrHourly = 'S' THEN 'H001' 
                           WHEN SupSpouseLife_Code is not null  and  EXISTS(Select * from dbo.U_EMETPLALIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP' )  and EecSalaryOrHourly = 'H' THEN 'H003'
                           WHEN SupSpouseLife_Code is not null   and  EXISTS(Select * from dbo.U_EMETPLALIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP' )   and EecSalaryOrHourly = 'S' THEN 'L002'
                           WHEN SupSpouseLife_Code is not null   and  EXISTS(Select * from dbo.U_EMETPLALIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP'  )  and EecSalaryOrHourly = 'H' THEN 'L004'
                           WHEN SupSpouseLife_Code is not null THEN  'H001'
                           END
        ,StatusCode8 = CASE WHEN SupSpouseLife_Code IS NOT NULL THEN 'A' END
        ,MembersCoveredCode8 = CASE WHEN SupSpouseLife_Code IS NOT NULL THEN 'A' END
        ,AnnualBenefitAmount8 = CASE WHEN SupSpouseLife_Code IS NOT NULL THEN dbo.dsi_fnpadzero((ISNULL((Select top 1 Max(SupSpouseLife_BdmBenAmount) from dbo.U_EMETPLALIF_Consolidated A where A.bdmeeid = B.bdmeeid and A.bdmcoid = B.bdmcoid  ),0)),8,0)  END
        ,CoverageCode9 = CASE WHEN SupChildrenLife_Code IS NOT NULL THEN 'LF' END
        ,CoverageStartDate9 =  CASE WHEN SupChildrenLife_Code IS NOT NULL THEN SupChildrenLife_BdmBenStartDate END
        ,CoverageStopDate9 =  CASE WHEN SupChildrenLife_Code IS NOT NULL THEN SupChildrenLife_BdmBenStopDate END
        ,GroupNumber9 =  CASE WHEN SupChildrenLife_Code IS NOT NULL THEN '5975462' END
        ,Subcode9 =  CASE WHEN SupChildrenLife_Code IS NOT NULL THEN '0003' END
        ,Branch9 = CASE WHEN SupChildrenLife_Code is not null and  EXISTS(Select * from dbo.U_EMETPLALIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP' )  and EecSalaryOrHourly = 'S' THEN 'H001' 
                           WHEN SupChildrenLife_Code is not null  and  EXISTS(Select * from dbo.U_EMETPLALIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP' )  and EecSalaryOrHourly = 'H' THEN 'H003'
                           WHEN SupChildrenLife_Code is not null   and  EXISTS(Select * from dbo.U_EMETPLALIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP' )   and EecSalaryOrHourly = 'S' THEN 'L002'
                           WHEN SupChildrenLife_Code is not null   and  EXISTS(Select * from dbo.U_EMETPLALIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP'  )  and EecSalaryOrHourly = 'H' THEN 'L004'
                           WHEN SupChildrenLife_Code is not null THEN  'H001'
                           END
        ,drvStatusCode9 = CASE WHEN SupChildrenLife_Code IS NOT NULL THEN 'A' END
        ,drvMembersCoveredCode9 = CASE WHEN SupChildrenLife_Code IS NOT NULL THEN 'C' END
        ,drvAnnualBenefitAmount9 =  CASE WHEN SupChildrenLife_Code IS NOT NULL THEN dbo.dsi_fnpadzero((ISNULL((Select top 1 Max(SupChildrenLife_BdmBenAmount) from dbo.U_EMETPLALIF_Consolidated A where A.bdmeeid = B.bdmeeid and A.bdmcoid = B.bdmcoid  ) ,0)),8,0)   END
        ,drvCoverageCode10 = CASE WHEN SupBasicADD_Code IS NOT NULL THEN 'OD' END
        ,drvCoverageStartDate10 = CASE WHEN SupBasicADD_Code IS NOT NULL THEN SupBasicADD_BdmBenStartDate END
        ,drvCoverageStopDate10 = CASE WHEN SupBasicADD_Code IS NOT NULL THEN SupBasicADD_BdmBenStopDate END
        ,drvGroupNumber10 = CASE WHEN SupBasicADD_Code IS NOT NULL THEN '5975462' END
        ,drvSubcode10 = CASE WHEN SupBasicADD_Code IS NOT NULL THEN '0003' END
        ,drvBranch10 = CASE WHEN SupBasicADD_Code is not null and  EXISTS(Select * from dbo.U_EMETPLALIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP' )  and EecSalaryOrHourly = 'S' THEN 'H001' 
                           WHEN SupBasicADD_Code is not null  and  EXISTS(Select * from dbo.U_EMETPLALIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP' )  and EecSalaryOrHourly = 'H' THEN 'H003'
                           WHEN SupBasicADD_Code is not null   and  EXISTS(Select * from dbo.U_EMETPLALIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP' )   and EecSalaryOrHourly = 'S' THEN 'L002'
                           WHEN SupBasicADD_Code is not null   and  EXISTS(Select * from dbo.U_EMETPLALIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP'  )  and EecSalaryOrHourly = 'H' THEN 'L004'
                           WHEN SupBasicADD_Code is not null THEN  'H001'
                           END
        ,drvStatusCode10 = CASE WHEN SupBasicADD_Code IS NOT NULL THEN 'A' END
        ,drvMembersCoveredCode10 = CASE WHEN SupBasicADD_Code IS NOT NULL THEN '1' END
        ,drvAnnualBenefitAmount10 = CASE WHEN SupBasicADD_Code IS NOT NULL THEN dbo.dsi_fnpadzero((ISNULL((Select top 1 Max(SupBasicADD_BdmBenAmount) from dbo.U_EMETPLALIF_Consolidated A where A.bdmeeid = B.bdmeeid and A.bdmcoid = B.bdmcoid  ) ,0)),8,0)  END
        ,drvSalaryMode10 = CASE WHEN SupBasicADD_Code IS NOT NULL THEN 'A' END
        ,drvSalaryAmount10 = CASE WHEN SupBasicADD_Code IS NOT NULL THEN dbo.dsi_fnpadzero((ISNULL(eecAnnSalary,0)),7,0) END
        ,drvCoverageCode11 = CASE WHEN SupSpouseADD_Code IS NOT NULL THEN 'AE' END
        ,drvCoverageStartDate11 = CASE WHEN SupSpouseADD_Code IS NOT NULL THEN SupSpouseADD_BdmBenStartDate END
        ,drvCoverageStopDate11 = CASE WHEN SupSpouseADD_Code IS NOT NULL THEN SupSpouseADD_BdmBenStopDate END
        ,drvGroupNumber11 = CASE WHEN SupSpouseADD_Code IS NOT NULL THEN '5975462' END
        ,drvSubcode11 = CASE WHEN SupSpouseADD_Code IS NOT NULL THEN '0003' END
        ,drvBranch11 =  CASE WHEN SupSpouseADD_Code is not null and  EXISTS(Select * from dbo.U_EMETPLALIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP' )  and EecSalaryOrHourly = 'S' THEN 'H001' 
                           WHEN SupSpouseADD_Code is not null  and  EXISTS(Select * from dbo.U_EMETPLALIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP' )  and EecSalaryOrHourly = 'H' THEN 'H003'
                           WHEN SupSpouseADD_Code is not null   and  EXISTS(Select * from dbo.U_EMETPLALIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP' )   and EecSalaryOrHourly = 'S' THEN 'L002'
                           WHEN SupSpouseADD_Code is not null   and  EXISTS(Select * from dbo.U_EMETPLALIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP'  )  and EecSalaryOrHourly = 'H' THEN 'L004'
                           WHEN SupSpouseADD_Code is not null THEN  'H001'
                        END
        ,drvStatusCode11 = CASE WHEN SupSpouseADD_Code IS NOT NULL THEN 'A' END
        ,drvMembersCoveredCode11 = CASE WHEN SupSpouseADD_Code IS NOT NULL THEN 'A' END
        ,drvAnnualBenefitAmount11 = CASE WHEN SupSpouseADD_Code IS NOT NULL THEN dbo.dsi_fnpadzero((ISNULL((Select top 1 Max(SupSpouseADD_BdmBenAmount) from dbo.U_EMETPLALIF_Consolidated A where A.bdmeeid = B.bdmeeid and A.bdmcoid = B.bdmcoid  ) ,0)),8,0) END
        ,drvCoverageCode12 = CASE WHEN SupChildADD_Code IS NOT NULL THEN 'AT' END
        ,drvCoverageStartDate12 = CASE WHEN SupChildADD_Code IS NOT NULL THEN SupChildADD_BdmBenStartDate END
        ,drvCoverageStopDate12 = CASE WHEN SupChildADD_Code IS NOT NULL THEN SupChildADD_BdmBenStopDate END
        ,drvGroupNumber12 = CASE WHEN SupChildADD_Code IS NOT NULL THEN '5975462' END
        ,drvSubcode12 = CASE WHEN SupChildADD_Code IS NOT NULL THEN '0003' END
        ,drvBranch12 = CASE WHEN SupChildADD_Code is not null and  EXISTS(Select * from dbo.U_EMETPLALIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP' )  and EecSalaryOrHourly = 'S' THEN 'H001' 
                           WHEN SupChildADD_Code is not null  and  EXISTS(Select * from dbo.U_EMETPLALIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP' )  and EecSalaryOrHourly = 'H' THEN 'H003'
                           WHEN SupChildADD_Code is not null   and  EXISTS(Select * from dbo.U_EMETPLALIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP' )   and EecSalaryOrHourly = 'S' THEN 'L002'
                           WHEN SupChildADD_Code is not null   and  EXISTS(Select * from dbo.U_EMETPLALIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP'  )  and EecSalaryOrHourly = 'H' THEN 'L004'
                           WHEN SupChildADD_Code is not null THEN  'H001'
                        END
        ,drvStatusCode12 = CASE WHEN SupChildADD_Code IS NOT NULL THEN 'A' END
        ,drvMembersCoveredCode12 =  CASE WHEN SupChildADD_Code IS NOT NULL THEN 'C' END
        ,drvAnnualBenefitAmount12 = CASE WHEN SupChildADD_Code IS NOT NULL THEN dbo.dsi_fnpadzero((ISNULL((Select top 1 Max(SupChildADD_BdmBenAmount) from dbo.U_EMETPLALIF_Consolidated A where A.bdmeeid = B.bdmeeid and A.bdmcoid = B.bdmcoid  ) ,0)),8,0) END
        ,drvEmployeeStatusCode = CASE WHEN GroupAccident_Code is not null  or  HospIndemity_Code is not null or CritIllness_Code is not null then
									 CASE WHEN eecemplstatus = 'T' and eectermreason ='203' THEN 'D' 
										  WHEN eecemplstatus = 'T' and eectermreason ='202' THEN 'R'
										  WHEN eecemplstatus = 'T' and eectermreason NOT IN('202','203') THEN 'T'
										  ELSE 'A'
									END

								END
        ,drvStatusCodeEffectiveDate = CASE WHEN GroupAccident_Code is not null  or  HospIndemity_Code is not null or CritIllness_Code is not null then 
											CASE WHEN eecemplstatus = 'T' THEN eecdateoftermination ELSE eecdateoflasthire END 
									END
        ,drvDepartmentCode = --CASE WHEN GroupAccident_Code is not null  or  HospIndemity_Code is not null or CritIllness_Code is not null then 
							CASE WHEN eecOrglvl4 in ('ECHI') THEN '0025'
                                  WHEN eecOrglvl4 in ('GCITY') THEN '0024'
                                  WHEN eecOrglvl4 in ('HOUST') THEN '0022'
                                  WHEN eecOrglvl4 in ('LOUDON') THEN '0026'
                                  WHEN eecOrglvl4 in ('ADMIN', 'TRDMN') THEN '0027'
                                  WHEN eecOrglvl4 in ('TULSA') THEN '0023'
                                  WHEN eecOrglvl4 in ('WIND') THEN '0021'
                             END
							--END
        ,drvGroupID = CASE WHEN (GroupAccident_Code is not null  or  HospIndemity_Code is not null or CritIllness_Code is not null) and  BdmRecType = 'EMP'  then '0009171692' END
        ,drvLocationID = CASE WHEN (GroupAccident_Code is not null  or  HospIndemity_Code is not null or CritIllness_Code is not null) and BdmRecType = 'EMP'  then '00005' END
        ,drvScheduleID = CASE WHEN (GroupAccident_Code is not null  or  HospIndemity_Code is not null or CritIllness_Code is not null) and BdmRecType = 'EMP'  then '0000031354' END
        ,drvPayFrequency = CASE WHEN (GroupAccident_Code is not null  or  HospIndemity_Code is not null or CritIllness_Code is not null) and BdmRecType = 'EMP'  then '12' END

        ,drvCoverageCode19 = CASE WHEN CritIllness_Code IS NOT NULL and BdmRecType = 'EMP' THEN 'GE' END
        ,drvCoverageStartDate19 = CASE WHEN CritIllness_Code IS NOT NULL  and BdmRecType = 'EMP' THEN CritIllness_BdmBenStartDate END
        ,drvCoverageStopDate19 = CASE WHEN CritIllness_Code IS NOT NULL and BdmRecType = 'EMP' THEN CritIllness_BdmBenStopDate END
        ,drvGroupNumber19 = CASE WHEN CritIllness_Code IS NOT NULL  and BdmRecType = 'EMP'THEN '0232842' END
        ,drvSubcode19 = CASE WHEN CritIllness_Code IS NOT NULL  and BdmRecType = 'EMP'THEN '0001' END
        ,drvBranch19 = CASE WHEN CritIllness_Code IS NOT NULL  and BdmRecType = 'EMP'THEN '0001' END
        ,drvMembersCoveredCode19 = CASE WHEN CritIllness_Code IS NOT NULL  and BdmRecType = 'EMP' THEN '1' END
        ,drvEnrollmentStatus19 = CASE WHEN CritIllness_Code IS NOT NULL  and BdmRecType = 'EMP' THEN 'P' END
        ,drvBenefitAmount19 = CASE WHEN BdmRecType = 'EMP' THEN 
									CASE WHEN CRE10_DedCode IS NOT NULL THEN '00010000'
										WHEN CRE20_DedCode IS NOT NULL THEN '00020000'
										WHEN CRFM1_DedCode IS NOT NULL THEN '00010000'
										WHEN CRFM2_DedCode IS NOT NULL THEN '00020000'----------------this is the new ded code
										WHEN CRCH1_DedCode IS NOT NULL THEN '00020000'
										WHEN CRCH5_DedCode IS NOT NULL THEN '00010000'
										WHEN CRS10_DedCode IS NOT NULL THEN '00020000'
										WHEN CRS5_DedCode IS NOT NULL THEN '00010000'
									END
								END
								/*CASE WHEN CRE10_DedCode IS NOT NULL THEN '00010000'
									WHEN CRE20_DedCode IS NOT NULL THEN '00020000'
									WHEN CRFM1_DedCode IS NOT NULL THEN '00010000'
									WHEN CRE20_DedCode IS NOT NULL THEN '00020000'
									WHEN CRCH1_DedCode IS NOT NULL THEN '00010000'
									WHEN CRCH5_DedCode IS NOT NULL THEN '00005000'
									WHEN CRS10_DedCode IS NOT NULL THEN '00010000'
									WHEN CRS5_DedCode IS NOT NULL THEN '00005000'
								END*/
								/*CASE WHEN CritIllness_Code IS NOT NULL  and BdmRecType = 'EMP' THEN 
									dbo.dsi_fnpadzero((ISNULL((Select max(CritIllness_BdmBenAmount) from U_EMETPLALIF_Consolidated C  where C.bdmeeid = B.bdmeeid),0)),8,0)  
								END*/
        ,drvVoluntaryCancellationInd19 = CASE WHEN CritIllness_Code IS NOT NULL  and BdmRecType = 'EMP' and CritIllness_BdmBenStatus <> 'A' THEN 'CE' END
        ,drvTaveoverIndicator19 = CASE WHEN CritIllness_Code IS NOT NULL  and BdmRecType = 'EMP' THEN '' END
        ,drvCoverageCode20 = CASE WHEN CritIllnessDep_Code IS NOT NULL THEN 'GD' END
        ,drvCoverageStartDate20 = CASE WHEN CritIllnessDep_Code IS NOT NULL THEN CritIllnessDep_BdmBenStartDate END
        ,drvCoverageStopDate20 = CASE WHEN CritIllnessDep_Code IS NOT NULL THEN CritIllnessDep_BdmBenStopDate END
        ,drvGroupNumber20 = CASE WHEN CritIllnessDep_Code IS NOT NULL THEN '0232842' END
        ,drvSubcode20 = CASE WHEN CritIllnessDep_Code IS NOT NULL THEN '0001' END
        ,drvBranch20 = CASE WHEN CritIllnessDep_Code IS NOT NULL THEN '0001' END
        ,drvMembersCoveredCode20 = CASE WHEN CritIllnessDep_Code IS NOT NULL THEN '4' END
        ,drvEnrollmentStatus20 = CASE WHEN CritIllnessDep_Code IS NOT NULL THEN 'P' END
		,drvBenefitAmount20Before = CASE WHEN CritIllnessDep_Code IS NOT NULL THEN dbo.dsi_fnpadzero((ISNULL((Select max(CritIllnessDep_BdmBenAmount)  from U_EMETPLALIF_Consolidated C  where C.bdmeeid = B.bdmeeid),0)),8,0)  END

        ,drvBenefitAmount20 =	CASE WHEN CRCH1_DedCode IS NOT NULL THEN '00010000'
									WHEN CRCH5_DedCode IS NOT NULL THEN '00005000'
									WHEN CRS10_DedCode IS NOT NULL THEN '00010000'
									WHEN CRS5_DedCode IS NOT NULL THEN '00005000'
									WHEN CRFM1_DedCode IS NOT NULL THEN '00005000'
									WHEN CRFM2_DedCode IS NOT NULL THEN '00010000'
								END
		
								/*CASE WHEN CRCH1_DedCode IS NOT NULL THEN '00005000'
									WHEN CRCH5_DedCode IS NOT NULL THEN '00002500'
									WHEN CRS10_DedCode IS NOT NULL THEN '00005000'
									WHEN CRS5_DedCode IS NOT NULL THEN '00002500'
									WHEN CRFM1_DedCode IS NOT NULL THEN '00005000'
									WHEN CRE20_DedCode IS NOT NULL THEN '00010000'
								END*/
		
								--CASE WHEN CritIllnessDep_Code IS NOT NULL THEN dbo.dsi_fnpadzero((ISNULL((Select max(cast(CritIllnessDep_BdmBenAmount as money) / 2 )  from U_EMETPLALIF_Consolidated C  where C.bdmeeid = B.bdmeeid),0)),8,0)  END
        ,drvCoverageCode23 = CASE WHEN GroupAccident_Code IS  NOT NULL THEN 'AH' END
        ,drvCoverageStartDate23 = CASE WHEN GroupAccident_Code IS  NOT NULL THEN GroupAccident_BdmBenStartDate END
        ,drvCoverageStopDate23 = CASE WHEN GroupAccident_Code IS  NOT NULL THEN GroupAccident_BdmBenStopDate END
        ,drvGroupNumber23 = CASE WHEN GroupAccident_Code IS  NOT NULL THEN '0232840' END
        ,drvSubcode23 = CASE WHEN GroupAccident_Code IS  NOT NULL THEN '0001' END
        ,drvBranch23 = CASE WHEN GroupAccident_Code ='ACCH' THEN '0001' 
                            WHEN GroupAccident_Code ='ACCL' THEN '0003' 
                            END
        ,drvMembersCoveredCode23 = CASE WHEN GroupAccident_Code IS  NOT NULL THEN 
                                            CASE WHEN GroupAccident_BdmBenOption in ('EE') THEN '1'
                                                 WHEN GroupAccident_BdmBenOption in ('EEC') THEN '2'
                                                 WHEN GroupAccident_BdmBenOption in ('EES', 'EEDP') THEN '3'
                                                 WHEN GroupAccident_BdmBenOption in ('EEF', 'EEDPF') THEN '4'
                                            END
                                   END
        ,drvEnrollmentStatus23 = CASE WHEN GroupAccident_Code IS  NOT NULL THEN 'P' END
        ,drvVoluntaryCancellationInd23 = CASE WHEN GroupAccident_Code IS  NOT NULL and  GroupAccident_BdmBenStatus <> 'A' THEN 'CE' END
        ,drvTakeoverIndicator23 = CASE WHEN GroupAccident_Code IS  NOT NULL THEN '' END
        ,drvCoverageCode24 = CASE WHEN HospIndemity_Code IS NOT NULL THEN 'HH' END
        ,drvCoverageStartDate24 = CASE WHEN HospIndemity_Code IS NOT NULL THEN HospIndemity_BdmBenStartDate END
        ,drvCoverageStopDate24 = CASE WHEN HospIndemity_Code IS NOT NULL THEN HospIndemity_BdmBenStopDate END
        ,drvGroupNumber24 = CASE WHEN HospIndemity_Code IS NOT NULL THEN '0232841' END
        ,drvSubcode24 = CASE WHEN HospIndemity_Code IS NOT NULL THEN '0001' END
        ,drvBranch24 = CASE WHEN HospIndemity_Code IN ('HOSPH') THEN '0001' 
                            WHEN HospIndemity_Code IN ('HOSPL') THEN '0003'
                        END
        ,drvMembersCoveredCode24 = CASE WHEN HospIndemity_Code IS NOT NULL THEN 
                    CASE WHEN HospIndemity_BdmBenOption in ('EE') THEN '1'
                                                 WHEN HospIndemity_BdmBenOption in ('EEC') THEN '2'
                                                 WHEN HospIndemity_BdmBenOption in ('EES', 'EEDP') THEN '3'
                                                 WHEN HospIndemity_BdmBenOption in ('EEF', 'EEDPF') THEN '4'
                                            END END
        ,drvEnrollmentStatus24 = CASE WHEN HospIndemity_Code IS NOT NULL THEN 'P' END
        ,drvVoluntaryCancellationInd24 = CASE WHEN HospIndemity_Code IS NOT NULL and HospIndemity_BdmBenStatus <> 'A' THEN 'CE' END
        ,drvTakeoverIndicator24 = CASE WHEN HospIndemity_Code IS NOT NULL THEN '' END
    INTO dbo.U_EMETPLALIF_drvTbl
    FROM dbo.U_EMETPLALIF_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.U_EMETPLALIF_Consolidated AS B
        ON BdmEEID = xEEID 
        AND BdmCOID = xCOID
         LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecId
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE '%TEST%' THEN 'Test_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'OE_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEMETPLALIF_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EMETPLALIF_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EMETPLALIF%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202102021'
       ,expStartPerControl     = '202102021'
       ,expLastEndPerControl   = '202102099'
       ,expEndPerControl       = '202102099'
WHERE expFormatCode = 'EMETPLALIF';

**********************************************************************************/
