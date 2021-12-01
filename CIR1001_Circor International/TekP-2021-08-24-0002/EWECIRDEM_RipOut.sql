USE [ULTIPRO_CIRCO]
GO
/****** Object:  StoredProcedure [dbo].[dsi_sp_BuildDriverTables_EWECIRDEM]    Script Date: 12/1/2021 4:57:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EWECIRDEM]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Circor International

Created By: Andy Pineda
Business Analyst: Lea King
Create Date: 10/08/2021
Service Request Number: TekP-2021-08-24-0002

Purpose: Web Benefits Demo Export

Revision History
----------------
10/20/2021 by AP:
    - Wrapped SSN, Company Name, Job Title in quotes.
    - Removed commas from address1 and address2.
    - Updated department, hr rep, salary grade and work site output.
    - Benefit seniority date and manager id fields added.
    - Cleaned up logic for Case ID and Eligibility status.

11/02/2021 by AP:
    - Fixed duplicate SSN issue (problem with orgs not filtering on orglevel number).
    - Set zip to first 5 digits.
    - Termination reason updated with new values.
    - Manager and Manager ID issue fixed (sometimes manager is not in the same company id as employee).
    - Removed commas from company name.
    - HR Rep updated.
    - Manager name formatting updated.
    - Added original hire date to output and fixed missing header values.
    - 90 day terms removed from file.
    - Case ID updated.
    - Only REG or INC employees.

11/10/2021 by AP:
    - Renamed a few header columns.
    - Adjusted logic for ACA Employment Classification and Termination Reason.
    - Added 5 new fields at end of file (fields 37-41).

11/23/2021 by AP:
	- Added paygroup code + '-' + pay group description.
	- Fixed WHERE clause logic of driver table.
	- Fixed eligibility status.

12/01/2021 by AP:
	- Updated employment classification logic.
	- Updated worksite field.
	- Job level logic might need to revisited as some employees are showing with BLANK EjhSalaryGrade.

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EWECIRDEM';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EWECIRDEM';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EWECIRDEM';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EWECIRDEM';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EWECIRDEM' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EWECIRDEM', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EWECIRDEM', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EWECIRDEM', 'SCH_EWECIR';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EWECIRDEM';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EWECIRDEM', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@EndPerControl     VARCHAR(9);

    -- Set FormatCode
    SELECT @FormatCode = 'EWECIRDEM';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EWECIRDEM_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EWECIRDEM_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    --DECLARE @DedList VARCHAR(MAX)
    --SET @DedList = 'DED1,DED2';

    --IF OBJECT_ID('U_EWECIRDEM_DedList','U') IS NOT NULL
    --    DROP TABLE dbo.U_EWECIRDEM_DedList;
    --SELECT DISTINCT
    --     DedCode = DedDedCode
    --    ,DedType = DedDedType
    --INTO dbo.U_EWECIRDEM_DedList
    --FROM dbo.fn_ListToTable(@DedList)
    --JOIN dbo.DedCode WITH (NOLOCK)
    --    ON DedDedCode = Item;


    ----==========================================
    ---- BDM Section
    ----==========================================
    --DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    ---- Required parameters
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','MED,DEN,VIS');
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

    ---- Non-Required parameters
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CalcBenOptionDate','2');
    ---- Run BDM Module
    --EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    --IF OBJECT_ID('U_EWECIRDEM_PDedHist','U') IS NOT NULL
    --    DROP TABLE dbo.U_EWECIRDEM_PDedHist;
    --SELECT DISTINCT
    --     PdhEEID
    --    -- Current Payroll Amounts
    --    ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
    --    -- YTD Payroll Amounts
    --    ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
    --    ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
    --    -- Categorize Payroll Amounts
    --    ,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('401K') THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('ROTH') THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('MATCH') THEN PdhERCurAmt ELSE 0.00 END)        
    --    ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('401CU') THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('401KL1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --    ,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('401KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --    ,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --    ,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --    ,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --INTO dbo.U_EWECIRDEM_PDedHist
    --FROM dbo.PDedHist WITH (NOLOCK)
    --JOIN dbo.U_EWECIRDEM_DedList WITH (NOLOCK)
    --    ON DedCode = PdhDedCode
    --WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    --AND PdhPerControl <= @EndPerControl
    --AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    --GROUP BY PdhEEID
    --HAVING (SUM(PdhEECurAmt) <> 0.00
    --    OR SUM(PdhERCurAmt) <> 0.00
    --);

    -------------------------------
    ---- Working Table - PEarHist
    -------------------------------
    IF OBJECT_ID('U_EWECIRDEM_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EWECIRDEM_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PehCOID
        ,PrgPayDate             = MAX(PrgPayDate)
        ,PgrPayFrequency        = MAX(PgrPayFrequency)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_EWECIRDEM_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    JOIN dbo.PayGroup WITH(NOLOCK)
        ON PrgPayGroup = PgrPayGroup
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID, PehCOID
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EWECIRDEM_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EWECIRDEM_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EWECIRDEM_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvSSN = pers.EepSSN
        ,drvEmpId = Ec.EecEmpNo
        ,drvCaseId = CASE WHEN Ec.EecDedGroupCode = 'CORC2' THEN '06'
                            WHEN Ec.EecDedGroupCode = 'CORE2' THEN '05'
                            WHEN Ec.EecEEType = 'INC' OR Ec.EecFullTimeOrPartTime = 'P' THEN '07'
                            WHEN Ec.EecPayGroup IN ('CIR20', 'CIR25') THEN '04'
                            WHEN EjhSalaryGrade IN ('L1', 'L2', 'L3', 'P1') AND pers.EepAddressState = 'CA' THEN '08'
                            WHEN EjhSalaryGrade IN ('L1', 'L2', 'L3', 'P1') AND pers.EepAddressState <> 'CA' THEN '02'
                            WHEN EjhSalaryGrade NOT IN ('L1', 'L2', 'L3', 'P1') AND pers.EepAddressState = 'CA' THEN '01'
                            WHEN EjhSalaryGrade NOT IN ('L1', 'L2', 'L3', 'P1') AND pers.EepAddressState <> 'CA' THEN '03'
                             END
        --Ec.EecDedGroupCode
        ,drvIndPayroll = CASE WHEN Ec.EecPayPeriod = 'B' THEN 'Bi-Weekly'
                                WHEN Ec.EecPayPeriod = 'M' THEN 'Monthly'
                                WHEN Ec.EecPayPeriod = 'W' THEN 'Weekly' END 
        --CASE WHEN PgrPayFrequency = 'B' THEN 'Bi-Weekly'
  --                              WHEN PgrPayFrequency = 'M' THEN 'Monthly'
  --                              WHEN PgrPayFrequency = 'W' THEN 'Weekly' END
        ,drvEligStatus = CASE WHEN Ec.EecEmplStatus = 'T' THEN 'Inactive'
                                WHEN Ec.EecFullTimeOrPartTime = 'P' THEN 'Ineligible'
                                WHEN Ec.EecDedGroupCode IN ('NONE', 'NOELI') THEN 'Ineligible'
                                WHEN Ec.EecEEType IN ('CTP', 'INC') AND pers.EepAddressCountry = 'USA' THEN 'Ineligible'
                                ELSE 'Active' END
        ,drvDOB = pers.EepDateOfBirth
        ,drvFName = pers.EepNameFirst
        ,drvLName = pers.EepNameLast
        ,drvMI = pers.EepNameMiddle
        ,drvGender = pers.EepGender
        ,drvMaritalStatus = CASE WHEN pers.EepMaritalStatus = 'C' THEN 'DP'
                                    WHEN pers.EepMaritalStatus = 'Z' THEN ''
                                    ELSE pers.EepMaritalStatus END 
        ,drvAddress = REPLACE(pers.EepAddressLine1, ',', '')
        ,drvAddress2 = REPLACE(pers.EepAddressLine2, ',', '')
        ,drvCity = pers.EepAddressCity
        ,drvState = pers.EepAddressState
        ,drvZip = LEFT(pers.EepAddressZipCode, 5)
        ,drvHomePh = pers.EepPhoneHomeNumber
        ,drvMobilePh = EfoPhoneNumber
        ,drvEmail = pers.EepAddressEMail
        ,drvWorkPh = Ec.EecPhoneBusinessNumber
        ,drvSalary = CAST(CAST(CASE WHEN EjhOtherRate3 <> '' THEN (EjhOtherRate3 * 2080) + Ec.EecAnnSalary
                            ELSE Ec.EecAnnSalary END AS DECIMAL(11,2)) AS VARCHAR)
        ,drvDOH = Ec.EecDateOfLastHire
        ,drvACAEmpClass = CASE WHEN Ec.EecEEType = 'R' THEN 'Retiree'
                                WHEN Ec.EecDedGroupCode IN ('NONE', 'NOELI') THEN 'Ineligible'
                                WHEN Ec.EecEEType IN ('CTP', 'INC') AND pers.EepAddressCountry = 'US' THEN 'Ineligible'
								WHEN Ec.EecFullTimeOrPartTime = 'P' THEN 'Ineligible'
                                ELSE 'Full-Time' END
        ,drvTermDate = ISNULL(CONVERT(VARCHAR, (CASE WHEN Ec.EecEmplStatus = 'T' THEN Ec.EecDateOfTermination END), 101), '')
        ,drvTermReason = CASE WHEN Ec.EecEmplStatus = 'T' THEN 
                            CASE WHEN Ec.EecTermReason = '203' THEN 'Death of Employee'
                                    WHEN EjhReason = '401' AND Ec.EecDateOfTermination BETWEEN @StartDate AND @EndDate THEN 'Reduction in Hours'
                                    WHEN Ec.EecTermReason <> '203' AND Ec.EecTermType = 'I' THEN 'Termination: Involuntary'
                                    WHEN Ec.EecTermType = 'V' THEN 'Termination: Voluntary' 
                                    WHEN Ec.EecTermType IN ('I', 'N') THEN 'Termination: Involuntary' ELSE '' END
                                END
        ,drvAltEmail = pers.EepAddressEmailAlternate
        ,drvJobTitle = JbcDesc
        ,drvDept = LTRIM(RTRIM(Ec.EecOrgLvl2)) + ' ' + '-' + ' ' + O2.OrgDesc
        ,drvManager = LTRIM(RTRIM(pers2.EepNameLast)) + ' ' + LTRIM(RTRIM(pers2.EepNameFirst)) + ' ' + ISNULL(LTRIM(RTRIM(LEFT(pers2.EepNameMiddle, 1))), '')
        --pers2.EepNameFirst + ' ' + pers2.EepNameLast
        ,drvHRRep = LTRIM(RTRIM(O4.OrgDesc))
        ,drvCompName = REPLACE(CmpCompanyName, ',', '')
        ,drvSalaryGrade = LTRIM(RTRIM(EjhSalaryGrade)) + ' ' + '-' + ' ' + SlgDesc
        ,drvWorkSite = O1.OrgDesc
		--LTRIM(RTRIM(Ec.EecOrgLvl1)) + ' ' + '-' + ' ' + O1.OrgDesc
        ,drvBenSenDate = ISNULL(CONVERT(VARCHAR, Ec.EecDateOfSeniority, 101), '')
        ,drvManagerId = Ec2.EecEmpNo
        ,drvOrigHireDate = ISNULL(CONVERT(VARCHAR, Ec.EecDateOfOriginalHire, 101), '')
        ,drvSuffix = CASE WHEN pers.EepNameSuffix = 'Z' THEN '' ELSE pers.EepNameSuffix END
        ,drvUnion = CASE WHEN Ec.EecUnionLocal <> '' THEN Ec.EecUnionLocal
                            WHEN Ec.EecUnionNational <> '' THEN Ec.EecUnionNational END
        ,drvEthnicity = CodDesc
        ,drvPayGroupCode = LTRIM(RTRIM(PgrPayGroup)) + ' - ' + REPLACE(LTRIM(RTRIM(PgrDesc)), ',', '') 
        ,drvSalaryOrHourly = Ec.EecSalaryOrHourly
    INTO dbo.U_EWECIRDEM_drvTbl
    FROM dbo.U_EWECIRDEM_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp Ec WITH (NOLOCK)
        ON Ec.EecEEID = xEEID 
        AND Ec.EecCoID = xCoID
    JOIN dbo.EmpPers pers WITH (NOLOCK)
        ON pers.EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = Ec.EecJobCode
    JOIN dbo.Company WITH(NOLOCK)
        ON xCOID = CmpCOID
    JOIN dbo.U_EWECIRDEM_PEarHist WITH(NOLOCK)
        ON PehEEID = xEEID
        AND PehCOID = xCOID
    OUTER APPLY (SELECT TOP 1* FROM dbo.EmpHJob WITH(NOLOCK) WHERE EjhEEID = xEEID AND EjhCOID = xCOID ORDER BY EjhDateTimeCreated DESC) Ejh
    --JOIN dbo.U_dsi_BDM_EWECIRDEM WITH (NOLOCK)
    --    ON BdmEEID = xEEID 
    --    AND BdmCoID = xCoID
    LEFT JOIN (SELECT TOP 1 EfoEEID, EfoPhoneNumber FROM dbo.EmpMPhon WITH(NOLOCK) WHERE efoPhoneType = 'CEL') as M on M.EfoEEID = xEEID
    LEFT JOIN dbo.EmpComp EC2 WITH (NOLOCK) -- supervisor  
    ON EC2.EecEEID = Ec.EecSupervisorID  
  --  AND Ec2.EecCOID = Ec.EecCOID  
        --AND SUP.EecEmplStatus <> 'T' 
    LEFT JOIN dbo.EmpPers pers2 WITH(NOLOCK)
    ON Ec2.EecEEID = pers2.EepEEID
    LEFT JOIN dbo.OrgLevel O1 WITH(NOLOCK)
    ON O1.OrgCode = Ec.EecOrgLvl1
    AND O1.OrgLvl = '1'
    LEFT JOIN dbo.OrgLevel O2 WITH(NOLOCK)
    ON O2.OrgCode = Ec.EecOrgLvl2
    AND O2.OrgLvl = '2'
    LEFT JOIN dbo.OrgLevel O4 WITH(NOLOCK)
    ON O4.OrgCode = Ec.EecOrgLvl4
    AND O4.OrgLvl = '4'
    Left JOIN dbo.SalGrade    
    ON slgsalgrade=jbcsalarygrade
    LEFT JOIN dbo.Codes WITH(NOLOCK)
    ON CodCode = pers.EepEthnicId
    AND CodTable = 'ETHNICCODE'
    LEFT JOIN dbo.PayGroup WITH(NOLOCK)
    ON PgrPayGroup = Ec.EecPayGroup
    WHERE (Ec.EecDateOfTermination IS NULL OR CAST(Ec.EecDateOfTermination AS DATE) >= DATEADD(day, -90, CAST(GETDATE() AS DATE)))
    AND Ec.EecEEType IN ('REG', 'INC', 'CTP')
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.csv'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'OE_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.csv'
                                  ELSE 'Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.csv'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEWECIRDEM_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EWECIRDEM_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EWECIRDEM%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202110011'
       ,expStartPerControl     = '202110011'
       ,expLastEndPerControl   = '202110089'
       ,expEndPerControl       = '202110089'
WHERE expFormatCode = 'EWECIRDEM';

**********************************************************************************/
