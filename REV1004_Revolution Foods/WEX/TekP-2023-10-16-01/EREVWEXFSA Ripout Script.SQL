USE [ULTIPRO_WPREVO]
GO
/****** Object:  StoredProcedure [dbo].[dsi_sp_BuildDriverTables_EREVWEXFSA]    Script Date: 2/5/2024 2:46:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EREVWEXFSA]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Revolution Foods, Inc

Created By: Marie Waters
Business Analyst: Katherine Ricca
Create Date: 01/03/2024
Service Request Number: TekP-2023-10-16-01

Purpose: WEX FSA Combined Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2024     SR-2024-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EREVWEXFSA';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EREVWEXFSA';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EREVWEXFSA';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EREVWEXFSA';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EREVWEXFSA' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EREVWEXFSA', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EREVWEXFSA', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EREVWEXFSA', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EREVWEXFSA', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EREVWEXFSA', 'SCH_EREVWE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EREVWEXFSA';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EREVWEXFSA', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@RunDate           VARCHAR(8)
            ,@RunTime           VARCHAR(6)         
            ,@PlanYearStart     DATETIME
            ,@FileMinCovDate    DATETIME;

    -- Set FormatCode
    SELECT @FormatCode = 'EREVWEXFSA';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@RunDate         = REPLACE(CONVERT (CHAR(10),GETDATE(), 101),'/','')
        ,@RunTime         = format(getdate(),'HHmmss')
        ,@FileMinCovDate  = '01/01/2024'
        
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    
    -- Set FSA Plan Year Start
    SET @PlanYearStart = CASE WHEN MONTH(@EndDate) = 12 THEN '01/01/' + CONVERT(CHAR(4),YEAR(DATEADD(YEAR,1,@EndDate)))
                              ELSE '01/01/' + CONVERT(CHAR(4),YEAR(@EndDate))
                         END;



    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EREVWEXFSA_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EREVWEXFSA_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EREVWEXFSA_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EREVWEXFSA_AuditFields;
    CREATE TABLE dbo.U_EREVWEXFSA_AuditFields (aTableName varchar(30),aFieldName varchar(30));
     INSERT INTO dbo.U_EREVWEXFSA_AuditFields VALUES ('EmpComp','EecEmplStatus');
    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EREVWEXFSA_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EREVWEXFSA_Audit;
    SELECT 
        audEEID  = audKey1Value
        ,audKey2 = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    INTO dbo.U_EREVWEXFSA_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EREVWEXFSA_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
     --AND AudFieldName  = 'eecemplstatus' 
     --AND AudNewValue = 'T'
    AND audAction = 'UPDATE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EREVWEXFSA_Audit ON dbo.U_EREVWEXFSA_Audit (audEEID,audKey2);

    ----================
    ---- Changes Only
    ----================
    --DELETE FROM dbo.U_EREVWEXFSA_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EREVWEXFSA_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'FSAH1,FSAD1,TRC';

    IF OBJECT_ID('U_EREVWEXFSA_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EREVWEXFSA_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EREVWEXFSA_DedList
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

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EREVWEXFSA_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EREVWEXFSA_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhFSAH1    = SUM(CASE WHEN PdhDedCode IN ('FSAH1') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhFSAD1    = SUM(CASE WHEN PdhDedCode IN ('FSAD1') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhTRC      = SUM(CASE WHEN PdhDedCode IN ('TRC') THEN PdhEECurAmt ELSE 0.00 END)
        --,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('MATCH') THEN PdhERCurAmt ELSE 0.00 END)        
        --,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('401CU') THEN PdhEECurAmt ELSE 0.00 END)
        --,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
        --,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('401KL1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        --,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('401KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        --,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        --,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        --,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    INTO dbo.U_EREVWEXFSA_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EREVWEXFSA_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    and PdhDedCode IN ('FSAH1','FSAD1','TRC')
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );


    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EREVWEXFSA_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EREVWEXFSA_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        --,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        --,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        ---- YTD Payroll Amount/Hours
        --,PehCurAmtYTD           = SUM(PehCurAmt)
        --,PehCurHrsYTD           = SUM(PehCurHrs)
        ---- Current Include Deferred Comp Amount/Hours
        --,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        --,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        ---- YTD Include Deferred Comp Amount/Hours
        --,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        --,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_EREVWEXFSA_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EREVWEXFSA_drvTbl_PT
    ---------------------------------
    IF OBJECT_ID('U_EREVWEXFSA_drvTbl_PT','U') IS NOT NULL
        DROP TABLE dbo.U_EREVWEXFSA_drvTbl_PT;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = '2_' + xEEID + '_1'  --xEEID
        ,drvSubSort = '2'
        -- standard fields above and additional driver fields below
        ,drvRecordType = 'PT'
        ,drvParticipantFileImportID = eepssn
        ,drvEmployerEmployeeID = ''
        ,drvEmployeeNumber = EecEmpNo
        ,drvLastName = dbo.dsi_fnRemoveChars('!:@#$%^&*()_+=~`|\/[]{},.-',EepNameLast)
        ,drvFirstName = dbo.dsi_fnRemoveChars('!:@#$%^&*()_+=~`|\/[]{},.-',EepNameFirst)
        ,drvMiddleInitial = LEFT(EepNameMiddle,1)
        ,drvGender = CASE WHEN eepgender = 'F' then 'F' else 'M' END
        ,drvMaritalStatus = ''
        ,drvMothersMaidenDame = ''
        ,drvDateOfBirth = REPLACE(CONVERT (CHAR(10),EepDateOfBirth, 101),'/','')
        ,drvSSN = eepSSN
        ,drvAddressLine1 = dbo.dsi_fnRemoveChars('!:@#$%^&*()_+=~`|\/[]{},.-',EepAddressLine1)
        ,drvAddressLine2 = dbo.dsi_fnRemoveChars('!:@#$%^&*()_+=~`|\/[]{},.-',EepAddressLine2)
        ,drvAddressLine3 = ''
        ,drvAddressLine4 = ''
        ,drvCity = dbo.dsi_fnRemoveChars('.,/-',EepAddressCity)
        ,drvState = dbo.dsi_fnRemoveChars('.,/-',EepAddressState)
        ,drvZipCode = EepAddressZipCode
        ,drvCountry = 'US'
        ,drvHomePhone = ''--EepPhoneHomeNumber
        ,drvWorkPhone = ''--EecPhoneBusinessNumber
        ,drvWorkPhoneExtension = ''--EecPhoneBusinessNumber
        ,drvEmailAddress = EepAddressEMail
        ,drvUsername = ''
        ,drvPassword = ''
        ,drvHireDate = REPLACE(CONVERT (CHAR(10),EecDateOfLastHire, 101),'/','')
        ,drvDivision = ''
        ,drvHoursPerWeek = ''
        ,drvEmployeeClass = 'E'
        ,drvPayrollFrequency = 'Payroll'
        ,drvPayrollFrequencyEffDate = ''
        ,drvParticipantStatus = CASE WHEN eecemplstatus = 'T' THEN 'Terminated' ELSE 'Active' END
        ,drvStatusEffictiveDate = REPLACE(CONVERT (CHAR(10),CASE WHEN eecemplstatus = 'T' THEN eecdateoftermination ELSE eecdateoflasthire END, 101),'/','')
        ,drvHoldPayroilDeductions = ''
        ,drvHoldEmployerContributions = ''
        ,drvIncurServices = ''
        ,drvFinalPayrollProcessDate = REPLACE(CONVERT (CHAR(10),CASE WHEN eecemplstatus = 'T' THEN DATEADD(DAY, 30, EecDateOfTermination)END, 101),'/','')
        ,drvFinalContribProcessDate = REPLACE(CONVERT (CHAR(10),CASE WHEN eecemplstatus = 'T' THEN DATEADD(DAY, 30, EecDateOfTermination)END, 101),'/','')
        ,drvHSACustodian = ''
        ,drvMedicareBeneficiary = ''
        ,drvMedicareID = ''
        ,drvExchangeIntegrationID = ''
        ,drvReportingHierarchyLevel1 = ''
        ,drvReportingHierarchyLevel2 = ''
        ,drvReportingHierarchyLevel3 = ''
        ,drvReportingHierarchyLevel4 = ''
        ,drvCDDCitizenship = ''
        ,drvCDDCountry = ''--EepAddressCountry
        ,drvCDDEmploymentStatus = ''
        ,drvCDDEmployer = ''
        ,drvCDDJobTitle = ''
        ,drvClassEffectiveDate = ''
        ,drvIDIdentificationType = ''
        ,drvIDIdentificationNumber = ''
        ,drvIDIssuingState = ''--EepAddressState
        ,drvIDIssuer = ''
        ,drvIDIssueDate = ''
        ,drvIDExpirationDate = ''
        ,drvMobileCarrier = ''
        ,drvMobileNumber = ''
        ,drvTimeZone = ''
    INTO dbo.U_EREVWEXFSA_drvTbl_PT
    FROM dbo.U_EREVWEXFSA_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.U_dsi_BDM_EREVWEXFSA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
     LEFT JOIN dbo.U_EREVWEXFSA_PDedHist WITH (NOLOCK)
        ON PdhEEID = XEEID
     LEFT JOIN dbo.U_EREVWEXFSA_Audit WITH (NOLOCK)
        ON audEEID = xEEID 
		 AND AudFieldName  = 'eecemplstatus' 
		 AND AudNewValue = 'T'
     WHERE ((eecemplstatus <> 'T' OR (eecemplstatus = 'T' and eectermreason <> 'TRO' AND AudDateTime IS NOT NULL))
            OR (ISNULL(PdhFSAH1 , 0.00) > 0.00
                OR ISNULL(PdhFSAD1 , 0.00) > 0.00
                OR ISNULL(PdhTRC, 0.00) > 0.00)
               
                )
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EREVWEXFSA_drvTbl_EN
    ---------------------------------
    IF OBJECT_ID('U_EREVWEXFSA_drvTbl_EN','U') IS NOT NULL
        DROP TABLE dbo.U_EREVWEXFSA_drvTbl_EN;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = '2_' + xEEID + '_2'   --xEEID
        ,drvSubSort = '3'
        -- standard fields above and additional driver fields below
        ,drvRecordType = 'EN'
        ,drvParticipantFileImportID = eepssn
        ,drvPlanName = CASE WHEN Bdmdedcode = 'FSAH1' then 'Medical FSA' 
                            WHEN bdmdedcode = 'FSAD1' then 'Dependent Care FSA'
                            WHEN bdmdedcode = 'TRC'   then 'Mass Transit'
                        END
        ,drvEnrollmentEffectiveDate = REPLACE(CONVERT (CHAR(10),dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStatusDate, @PlanYearStart), 101),'/','')
        ,drvParticipantElectionAmount = CASE WHEN Bdmdedcode = 'FSAH1' then FORMAT(BdmEEGoalAmt, '0.00') 
                                             WHEN bdmdedcode = 'FSAD1' then FORMAT(BdmEEGoalAmt, '0.00')
                                             WHEN bdmdedcode = 'TRC'   then FORMAT(BdmEEGoalAmt, '0.00')
                                         END 
        ,drvEmployerContributionDevel = ''
        ,dvElectionAiountIndicator = CASE WHEn BdmDedCode = 'TRC' then 'PerMonth' END
        ,drvHDHPCoverageLevel = ''
    INTO dbo.U_EREVWEXFSA_drvTbl_EN
    FROM dbo.U_EREVWEXFSA_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EREVWEXFSA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
   LEFT  JOIN dbo.U_EREVWEXFSA_PDedHist WITH (NOLOCK)
        ON PdhEEID = XEEID
    LEFT JOIN dbo.U_EREVWEXFSA_Audit WITH (NOLOCK)
        ON audEEID = xEEID
		 AND AudFieldName  = 'eecemplstatus' 
		 AND AudNewValue = 'T'
     WHERE ((eecemplstatus <> 'T' OR (eecemplstatus = 'T' and eectermreason <> 'TRO' AND AudDateTime IS NOT NULL))
            OR (ISNULL(PdhFSAH1 , 0.00) > 0.00
                OR ISNULL(PdhFSAD1 , 0.00) > 0.00
                OR ISNULL(PdhTRC, 0.00) > 0.00)
               
                )
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EREVWEXFSA_drvTbl_CT
    ---------------------------------
    IF OBJECT_ID('U_EREVWEXFSA_drvTbl_CT','U') IS NOT NULL
        DROP TABLE dbo.U_EREVWEXFSA_drvTbl_CT;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = '2_' + xEEID + '_3'   --xEEID
        ,drvSubSort = '4'
        -- standard fields above and additional driver fields below
        ,drvRecordType = 'CT'
        ,drvParticipantFileImportID = Eepssn
        ,drvPlanName = CASE WHEN Bdmdedcode = 'FSAH1' then 'Medical FSA' 
                            WHEN bdmdedcode = 'FSAD1' then 'Dependent Care FSA'
                            WHEN bdmdedcode = 'TRC'   then 'Mass Transit'
                        END
        ,drvContributionDate = REPLACE(Convert(varchar(10) ,PrgPayDate, 101),'/','')
        ,drvContributionDescription = 'Payroll Deduction'
        ,drvContributionAmount = CASE WHEN Bdmdedcode = 'FSAH1' then FORMAT(PdhFSAH1, '0.00') 
                                      WHEN bdmdedcode = 'FSAD1' then FORMAT(PdhFSAD1, '0.00')
                                      WHEN bdmdedcode = 'TRC'   then FORMAT(PdhTRC, '0.00')
                                    END
        ,drvAmountType = 'Actual '
        ,drvTaxYear = ''
    INTO dbo.U_EREVWEXFSA_drvTbl_CT
    FROM dbo.U_EREVWEXFSA_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EREVWEXFSA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    LEFT JOIN dbo.U_EREVWEXFSA_PDedHist WITH (NOLOCK)
        ON PdhEEID = XEEID
    LEFT JOIN dbo.U_EREVWEXFSA_PEarHist WITH (NOLOCK)
        ON PehEEID = XEEID
    LEFT JOIN dbo.U_EREVWEXFSA_Audit WITH (NOLOCK)
        ON audEEID = xEEID
		 AND AudFieldName  = 'eecemplstatus' 
		 AND AudNewValue = 'T'
     WHERE ((eecemplstatus <> 'T' OR (eecemplstatus = 'T' and eectermreason <> 'TRO' AND AudDateTime IS NOT NULL))
            OR (ISNULL(PdhFSAH1 , 0.00) > 0.00
                OR ISNULL(PdhFSAD1 , 0.00) > 0.00
                OR ISNULL(PdhTRC, 0.00) > 0.00
               
                ))
    ;
     ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EREVWEXFSA_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EREVWEXFSA_Header;
    SELECT DISTINCT
         drvRecordType = 'FH'
        ,drvAdministratorCode = 'DBI'
        ,drvEmployerCode = '49663'
        ,drvSynchronizeFlag = 'N'
        ,drvSubmittedDate = @RunDate
        ,drvSubmittedTime = @RunTime
        ,drvFileVersion = '3.5'
    INTO dbo.U_EREVWEXFSA_Header
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EREVWEXFSA_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_EREVWEXFSA_Trailer;
    SELECT DISTINCT
         drvRecordType = 'FF'
        ,drvRecordCount = (SELECT COUNT(1) FROM dbo.U_EREVWEXFSA_drvTbl_PT) +
                          (SELECT COUNT(1) FROM dbo.U_EREVWEXFSA_drvTbl_EN) +
                          (SELECT COUNT(1) FROM dbo.U_EREVWEXFSA_drvTbl_CT) 
        ,drvAdministratorCode = 'DBI'
        ,drvEmployerCode = '49663'
        ,drvSubmittedDate = @RunDate
        ,drvSubmittedTime = @RunTime
    INTO dbo.U_EREVWEXFSA_Trailer
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'OE_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEREVWEXFSA_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EREVWEXFSA_File (NOLOCK)
    ORDER BY  InitialSort, SubSort,RIGHT(RecordSet,2);

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EREVWEXFSA%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202312271'
       ,expStartPerControl     = '202312271'
       ,expLastEndPerControl   = '202401039'
       ,expEndPerControl       = '202401039'
WHERE expFormatCode = 'EREVWEXFSA';

**********************************************************************************/
