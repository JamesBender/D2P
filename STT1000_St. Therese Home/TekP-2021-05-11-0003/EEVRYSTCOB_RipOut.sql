USE [ULTIPRO_WPSTTH]
GO
/****** Object:  StoredProcedure [dbo].[dsi_sp_BuildDriverTables_EEVRYSTCOB]    Script Date: 8/31/2021 12:17:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EEVRYSTCOB]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: St. Therese Home

Created By: Andy Pineda
Business Analyst: Cheryl Petitti
Create Date: 07/15/2021
Service Request Number: TekP-2021-05-11-0003

Purpose: Everything Benefits COBRA

Revision History
----------------
07/21/2021 by AP:
        - Per request removed audit from use in the file.

07/23/2021 by AP:
        - Removed audit table from emp and spouse (error left from before).
        - Work Phone and Home Phone dashes showing when there is no number has been fixed.
        - Set JobCode to BLANK.
        - Fixed suffix with Z for dependents.
        - Updated plan name value and added the prior existing plan name fields to benefit policy number 1.
        - Added employment term reason to child dependent records.

07/27/2021 by AP:
        - Updated ' - - ' for contact phone numbers.
        - Added "Employee Assistance Program" to benefit type when plan name = "Employee Assistance Program".
        - Fixede Coverage Level logic.

08/17/2021 by AP:
        - Updated field benefit type and benefit plan name (corrected "Assistance").
        - Added logic to the Benefit Base Coverage Amount field (only for VOYA values).
        - Added logic to Benefit Number Deductions Per Year field (only for VOYA values).

08/25/2021 by AP:
        - Updated logic for >= 100000 and >= 50000 for Ben Bas Coverage Amount.

08/30/2021 by AP:
		- Set 0.00's to NULL for Base Coverage Amt.

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EEVRYSTCOB';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EEVRYSTCOB';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EEVRYSTCOB';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EEVRYSTCOB';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EEVRYSTCOB' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEVRYSTCOB', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEVRYSTCOB', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEVRYSTCOB', 'SCH_EEVRYS';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EEVRYSTCOB';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EEVRYSTCOB', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EEVRYSTCOB';

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
    DELETE FROM dbo.U_EEVRYSTCOB_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EEVRYSTCOB_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'MDP1,MDP2,MDP3,PTDEN,VVIS,FCHI,FMED,BLD,BLEE,LIFEC,LIFEE,LIFES';

    IF OBJECT_ID('U_EEVRYSTCOB_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EEVRYSTCOB_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EEVRYSTCOB_DedList
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
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CalcBenOptionDate','2');
    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Working Tables
    --==========================================

    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    --IF OBJECT_ID('U_EEVRYSTCOB_AuditFields','U') IS NOT NULL
    --    DROP TABLE dbo.U_EEVRYSTCOB_AuditFields;
    --CREATE TABLE dbo.U_EEVRYSTCOB_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    --INSERT INTO dbo.U_EEVRYSTCOB_AuditFields VALUES ('EmpComp','EecAnnSalary');
    --INSERT INTO dbo.U_EEVRYSTCOB_AuditFields VALUES ('EmpComp','EecDateOfLastHire');
    --INSERT INTO dbo.U_EEVRYSTCOB_AuditFields VALUES ('EmpComp','EecDateOfOriginalHire');
    --INSERT INTO dbo.U_EEVRYSTCOB_AuditFields VALUES ('EmpComp','EecDateOfTermination');
    --INSERT INTO dbo.U_EEVRYSTCOB_AuditFields VALUES ('EmpComp','EecEmplStatus');
    --INSERT INTO dbo.U_EEVRYSTCOB_AuditFields VALUES ('EmpComp','EecFullTimeOrPartTime');
    --INSERT INTO dbo.U_EEVRYSTCOB_AuditFields VALUES ('EmpComp','EecHourlyPayRate');
    --INSERT INTO dbo.U_EEVRYSTCOB_AuditFields VALUES ('EmpComp','EecSalaryOrHourly');
    --INSERT INTO dbo.U_EEVRYSTCOB_AuditFields VALUES ('EmpComp','EecScheduledWorkHrs');
    --INSERT INTO dbo.U_EEVRYSTCOB_AuditFields VALUES ('EmpComp','EecTermReason');
    --INSERT INTO dbo.U_EEVRYSTCOB_AuditFields VALUES ('EmpDed','EedBenStartDate');
    --INSERT INTO dbo.U_EEVRYSTCOB_AuditFields VALUES ('EmpDed','EedBenStopDate');
    --INSERT INTO dbo.U_EEVRYSTCOB_AuditFields VALUES ('EmpPers','EepDateOfBirth');
    --INSERT INTO dbo.U_EEVRYSTCOB_AuditFields VALUES ('EmpPers','EepGender');
    --INSERT INTO dbo.U_EEVRYSTCOB_AuditFields VALUES ('EmpPers','EepNameFirst');
    --INSERT INTO dbo.U_EEVRYSTCOB_AuditFields VALUES ('EmpPers','EepNameLast');
    --INSERT INTO dbo.U_EEVRYSTCOB_AuditFields VALUES ('EmpPers','EepNameMiddle');
    --INSERT INTO dbo.U_EEVRYSTCOB_AuditFields VALUES ('EmpPers','EepNameSuffix');
    --INSERT INTO dbo.U_EEVRYSTCOB_AuditFields VALUES ('EmpPers','EepOldSSN');
    --INSERT INTO dbo.U_EEVRYSTCOB_AuditFields VALUES ('EmpPers','EepSSN');

    ---- Create audit table based on fields defined above
    --IF OBJECT_ID('U_EEVRYSTCOB_Audit','U') IS NOT NULL
    --    DROP TABLE dbo.U_EEVRYSTCOB_Audit;
    --SELECT 
    --    audEEID  = audKey1Value
    --    ,audKey2 = audKey2Value
    --    ,audKey3 = audKey3Value
    --    ,audTableName
    --    ,audFieldName
    --    ,audAction
    --    ,audDateTime
    --    ,audOldValue
    --    ,audNewValue
    --    ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    --    ,audNewHire = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = '' AND ISNULL(audNewValue,'') = 'A' THEN 'Y' ELSE 'N' END
    --    ,audReHire = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = 'T' AND ISNULL(audNewValue,'') = 'A' THEN 'Y' ELSE 'N' END
    --    ,audTerm = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audNewValue,'') = 'T' THEN 'Y' ELSE 'N' END
    --    ,audSalaryChange = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecAnnSalary' AND ISNULL(audNewValue,'') <> '' THEN 'Y' ELSE 'N' END
    --INTO dbo.U_EEVRYSTCOB_Audit
    --FROM dbo.U_EEVRYSTCOB_EEList WITH (NOLOCK)
    --JOIN dbo.vw_AuditData WITH (NOLOCK) 
    --    ON audKey1Value = xEEID
    --JOIN dbo.U_EEVRYSTCOB_AuditFields WITH (NOLOCK) 
    --    ON audTableName = aTableName
    --    AND audFieldName = aFieldName
    --WHERE audDateTime BETWEEN @StartDate AND @EndDate
    --AND audAction <> 'DELETE'
    --AND ISNULL(audNewValue,'') <> '';
 
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EEVRYSTCOB_drvTbl
    ---------------------------------
   IF OBJECT_ID('U_EEVRYSTCOB_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EEVRYSTCOB_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRecType = 'S'
        ,drvReltoEmp = CAST('Self' AS VARCHAR(10))
        ,drvOrgSysId = EecOrgLvl1
        ,drvOrgName = OrgDesc 
        ,drvOrgEIN = ''
        ,drvEmpSysId = EecEmpNo
        ,drvEmpUser = EepNameFirst + '.' + EepNameLast
        ,drvEmpSSN = SUBSTRING(EepSSN, 1, 3)+'-'+
                     SUBSTRING(EepSSN, 4, 2)+'-'+
                     SUBSTRING(EepSSN, 6, 4) 
        ,drvEmpNum = EecEmpNo
        ,drvEmpFName = EepNameFirst
        ,drvEmpLName = EepNameLast
        ,drvEmpMName = EepNameMiddle
        ,drvEmpSuffi = EepNameSuffix
        ,drvEmpPrefi = ''
        ,drvEmpDOB = LEFT(CONVERT(VARCHAR, EepDateOfBirth, 126), 10) -- yyyy-mm-dd format
        ,drvEmpDOD = LEFT(CONVERT(VARCHAR, EepDateDeceased, 126), 10)
        ,drvEmpEmail = EepAddressEMail
        ,drvEmpAdd1 = REPLACE(EepAddressLine1, ',', '')
        ,drvEmpAdd2 = REPLACE(EepAddressLine2, ',', '')
        ,drvEmpAdd3 = ''
        ,drvEmpCity = EepAddressCity
        ,drvEmpCount = ''
        ,drvEmpState = EepAddressState
        ,drvEmpZip = EepAddressZipCode
        ,drvEmpHPh = CASE WHEN EepPhoneHomeNumber IS NOT NULL THEN SUBSTRING(EepPhoneHomeNumber, 1, 3) + '-' + 
                     SUBSTRING(EepPhoneHomeNumber, 4, 3) + '-' + 
                     SUBSTRING(EepPhoneHomeNumber, 7, 4) ELSE '' END
        ,drvEmpWPh = CASE WHEN EecPhoneBusinessNumber <> '' THEN SUBSTRING(EecPhoneBusinessNumber, 1, 3) + '-' + 
                     SUBSTRING(EecPhoneBusinessNumber, 4, 3) + '-' + 
                     SUBSTRING(EecPhoneBusinessNumber, 7, 4) ELSE '' END
        ,drvEmpGen = CASE WHEN EepGender = 'M' THEN 'M' 
                            WHEN EepGender = 'F' THEN 'F' ELSE 'U' END
        ,drvEmpMarit = CASE EepMaritalStatus
                            WHEN 'S' THEN 'Single'
                            WHEN 'D' THEN 'Divorced'
                            WHEN 'M' THEN 'Married'
                            WHEN 'W' THEN 'Widowed' ELSE '' END
        ,drvEmpDtMar = ''
        ,drvEmpRace = ''
        ,drvEmpCitiz = ''
        ,drvEmpHandi = ''
        ,drvEmpHospi = ''
        ,drvEmpSmoke = CASE WHEN EepIsSmoker = 'Y' THEN 'Yes' ELSE 'No' END
        ,drvEmpLangu = ''
        ,drvEmptDtSt = LEFT(CONVERT(VARCHAR, EecDateOfLastHire, 126), 10)
        ,drvEmptDtTerm = LEFT(ISNULL(CONVERT(VARCHAR, EecDateOfTermination, 126), ''), 10)
        ,drvEmptTermReason = TchDesc -- TscDesc WHERE TrmReasn = EecTermReason (send the description) 
        --CASE WHEN EecEmplStatus = 'T' THEN EecTermReason END
        ,drvEmptDtHire = ''
        ,drvEmptDtOrigHire = LEFT(CONVERT(VARCHAR, EecDateOfOriginalHire, 126), 10)
        ,drvEmptDtBenEligh = ''
        ,drvEmptDtRet = ''
        ,drvEmptNum = ''
        ,drvEmptStat = CASE EecEmplStatus
                            WHEN 'A' THEN 'Active'
                            WHEN 'T' THEN 'Terminated'
                            WHEN 'L' THEN 'LOA' END
        ,drvEmptType = ''
        ,drvEmptFull = ''
        ,drvEmptExStat = ''
        ,drvEmptRegion = ''
        ,drvEmptDiv = ''
        ,drvEmptDep = ''
        ,drvEmptLoc = ''
        ,drvEmptJobTitle = ''
        ,drvEmptJobCode = ''
        ,drvEmptPerc = ''
        ,drvEmptIsCorpOf = ''
        ,drvEmptIsKeyEmp = ''
        ,drvEmptIsHighComp = ''
        ,drvEmptUnion = ''
        ,drvEmptMedElig = ''
        ,drvEmptCompAnnAmt = ''
        ,drvEmpCompNumPay = ''
        ,drvEmpCompHrlyRate = ''
        ,drvEmptCompEffFrom = ''
        ,drvEmptWeeklyHrs = ''
        ,drvConSysId = ''
        ,drvConSSN = CAST('' as varchar(50))
        ,drvConFName = CAST('' as varchar(50))
        ,drvConLName = CAST('' as varchar(50))
        ,drvConMName = CAST('' as varchar(50))
        ,drvConNameSuff = CAST('' as varchar(50))
        ,drvConNamePref = ''
        ,drvConDOB = CAST('' as varchar(50))
        ,drvConDOD = ''
        ,drvConEmail = ''
        ,drvConAddr1 = ''
        ,drvConAddr2 = ''
        ,drvConAddr3 = ''
        ,drvConAddCity = ''
        ,drvConAddCounty = ''
        ,drvConAddState = ''
        ,drvConAddZip = ''
        ,drvConHPh = CAST('' as varchar(50))
        ,drvConWPh = ''
        ,drvConGen = CAST('' as varchar(50))
        ,drvConMaritalStat = ''
        ,drvConRace = ''
        ,drvConCitiz = ''
        ,drvConHandi = ''
        ,drvConHospi = ''
        ,drvConSmoke = ''
        ,drvConLangu = ''
        ,drvConIRSQual = ''
        ,drvConFullTimeStuddent = ''
        ,drvBenCarName = CAST(CASE WHEN EedDedCode IN ('MDP1', 'MDP2', 'MDP3') THEN 'PreferredOne'
                                WHEN EedDedCode = 'PTDEN' THEN 'HealthPartners'
                                WHEN EedDedCode = 'VVIS' THEN 'EyeMed Vision Care'
                                WHEN EedDedCode IN ('FCHI', 'FMED') THEN 'OptumHealth'
                                 WHEN EedDedCode IN ('BLD', 'BLEE') THEN 'Voya'
                              --  WHEN EedDedCode IN ('BLD', 'BLEE') THEN 'Vital WorkLife' 
                                WHEN EedDedCode IN ('LIFEC', 'LIFEE', 'LIFES') THEN 'Voya' END AS VARCHAR(50))
        ,drvBenCarEIN = ''
        ,drvBenType = CAST(CASE WHEN EedDedCode IN ('MDP1', 'MDP2', 'MDP3') THEN 'Medical'
                                WHEN EedDedCode = 'PTDEN' THEN 'Dental'
                                WHEN EedDedCode = 'VVIS' THEN 'Vision'
                                WHEN EedDedCode IN ('FCHI', 'FMED') THEN 'Flexible Spending Account'
                             --   WHEN EedDedCode IN ('BLD', 'BLEE') THEN 'Employee Assistance Program' 
                                WHEN EedDedCode IN ('BLD', 'BLEE') THEN 'Basic Employee Life' 
                                WHEN EedDedCode IN ('LIFEC', 'LIFEE', 'LIFES') THEN 'Voluntary Life' END AS VARCHAR(50))
        ,drvBenPlanName = CAST(CASE WHEN EedDedCode = 'MDP1' THEN 'Medical Copay Plan 1'
                                WHEN EedDedCode = 'MDP2' THEN 'Medical HSA Plan 2'
                                WHEN EedDedCode = 'MDP3' THEN 'Medical HD HSA Plan 3'
                                WHEN EedDedCode = 'PTDEN' THEN 'Dental Insurance PreTax'
                                WHEN EedDedCode = 'VVIS' THEN 'Vision'
                                WHEN EedDedCode = 'FCHI' THEN 'Flex Child Care'
                                WHEN EedDedCode = 'FMED' THEN 'Flex Medical'
                                WHEN EedDedcode = 'BLD' THEN 'Basic Life Directors'
                                WHEN EedDedCode = 'BLEE' THEN 'Basic Life EE Only'
                                WHEN EedDedCode = 'LIFEC' THEN 'Supplemental Life - Child'
                                WHEN EedDedCode = 'LIFEE' THEN 'Supplemental Life - Employee'
                                WHEN EedDedCode = 'LIFES' THEN 'Supplemental Life - Spouse' END AS VARCHAR(50))
        ,drvBenPolNum1 = CAST(CASE WHEN EedDedCode IN ('MDP1', 'MDP2', 'MDP3') THEN 'PKA20366'
                                WHEN EedDedCode = 'PTDEN' THEN '19096'
                                WHEN EedDedCode = 'VVIS' THEN '9894049'
                                WHEN EedDedCode IN ('FCHI', 'FMED') THEN '775992'
                                WHEN EedDedCode IN ('BLD', 'BLEE') THEN '290319' 
                                WHEN EedDedCode IN ('LIFEC', 'LIFEE', 'LIFES') THEN '363707' END AS VARCHAR(50))
        ,drvBenPolNum2 = ''
        ,drvBenPolNum3 = ''
        ,drvBenPolNum4 = ''
        ,drvBenPolNum5 = ''
        ,drvBenEffFrom = LEFT(CONVERT(VARCHAR, EedBenStartDate, 126), 10)
        ,drvBenEffLastDt = LEFT(ISNULL(CONVERT(VARCHAR, EedBenStopDate, 126), ''), 10)
        ,drvBenOrigEffFrom = ''
        ,drvBenCovLevel = CASE WHEN EedDedCode IN ('BLD', 'BLEE', 'FCHI', 'FMED', 'LIFEE') THEN 'EMP'
                                WHEN EedDedCode = 'LIFES' THEN 'ESP'
                                WHEN EedDedCode = 'LIFEC' THEN 'ECH'
                                WHEN EedDedCode = 'PTDEN' AND EedBenOption = 'EE1' AND ConRelationship = 'SPS' THEN 'ESP'
                                WHEN EedDedCode = 'PTDEN' AND EedBenOption = 'EE1' AND ConRelationship IN ('CHL', 'STC') THEN 'ECH'
                                WHEN EedBenOption = 'EE' THEN 'EMP'
                                WHEN EedBenOption IN ('EES', 'EEDP') THEN 'ESP'
                                WHEN EedBenOption IN ('EEF', 'EEDPF') THEN 'FAM'
                                WHEN EedBenOption IN ('EEC', 'EECH') THEN 'ECH' END
        ,drvBenIsWaived = ''
        ,drvBenBaseCovAmt =     CAST(CAST(CASE WHEN EedDedCode IN ('LIFEE', 'LIFES', 'LIFEC') THEN EedBenAmt
                                    WHEN EedDedCode = 'BLD' AND EecAnnSalary < 100000 THEN ROUND(EecAnnSalary, 0)
                                    WHEN EedDedCode = 'BLD' AND EecAnnSalary >= 100000 THEN '100000'
                                    WHEN EedDedCode = 'BLEE' AND EecAnnSalary < 50000 THEN ROUND(EecAnnSalary, 0)
                                    WHEN EedDedCode = 'BLEE' AND EecAnnSalary >= 50000 THEN '50000'
                                    WHEN EedDedCode IN ('FCHI', 'FMED') THEN ROUND(EedEEGoalAmt, 0) ELSE '' END AS DECIMAL(10,2)) AS VARCHAR)
        ,drvBenAppCovAmt = ''
        ,drvBenReqCovAmt = ''
        ,drvBenEmpPrem = ''
        ,drvBenEmployerPrem = ''
        ,drvBenNumDedPerYear = CASE WHEN EedDedCode IN ('FCHI', 'FMED') THEN 26 END
        ,drvBenSalary = ''
        ,drvBenMedOfficeNum = ''
        ,drvBenMedOfficeProvName = ''
        ,drvBenMedOfficeProvAdd = ''
        ,drvBenPercent = ''
        ,drvInitialSort = '1' + EepSSN
        ,drvSubSort = '1'
    INTO dbo.U_EEVRYSTCOB_drvTbl
    FROM dbo.U_EEVRYSTCOB_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.u_dsi_bdm_EmpDeductions WITH(NOLOCK)
        ON EedEEID = xEEID
        AND EedCOID = xCOID
        AND EedFormatCode = @FormatCode
        AND EedValidForExport = 'Y'
    JOIN dbo.OrgLevel WITH(NOLOCK)
        ON OrgCode = EecOrgLvl1
    --JOIN dbo.U_EEVRYSTCOB_Audit 
    --    ON audEEID = xEEID
    --    AND audKey2 = xCOID
     LEFT JOIN dbo.u_dsi_bdm_DepDeductions WITH(NOLOCK)
        ON DbnEEID = xEEID
        AND DbnCOID = xCOID
        AND DbnFormatCode = @FormatCode
        AND DbnValidForExport = 'Y'
     LEFT JOIN dbo.TrmReasn WITH (NOLOCK)  
        ON EecTermReason =   TchCode 
     LEFT JOIN dbo.Contacts WITH(NOLOCK)
        ON ConEEID = EedEEID
        AND DbnDepRecID = ConSystemID
    WHERE --audNewHire = 'Y' OR audTerm = 'Y'
     EecEEType NOT IN ('AG', 'CON', 'INT', 'SUM', 'Z')

    INSERT INTO dbo.U_EEVRYSTCOB_drvTbl
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRecType = 'S'
        ,drvReltoEmp = CAST('Self' AS VARCHAR(10))
        ,drvOrgSysId = EecOrgLvl1
        ,drvOrgName = OrgDesc 
        ,drvOrgEIN = ''
        ,drvEmpSysId = EecEmpNo
        ,drvEmpUser = EepNameFirst + '.' + EepNameLast
        ,drvEmpSSN = SUBSTRING(EepSSN, 1, 3)+'-'+
                     SUBSTRING(EepSSN, 4, 2)+'-'+
                     SUBSTRING(EepSSN, 6, 4) 
        ,drvEmpNum = EecEmpNo
        ,drvEmpFName = EepNameFirst
        ,drvEmpLName = EepNameLast
        ,drvEmpMName = EepNameMiddle
        ,drvEmpSuffi = EepNameSuffix
        ,drvEmpPrefi = ''
        ,drvEmpDOB = LEFT(CONVERT(VARCHAR, EepDateOfBirth, 126), 10) -- yyyy-mm-dd format
        ,drvEmpDOD = LEFT(CONVERT(VARCHAR, EepDateDeceased, 126), 10)
        ,drvEmpEmail = EepAddressEMail
        ,drvEmpAdd1 = REPLACE(EepAddressLine1, ',', '')
        ,drvEmpAdd2 = REPLACE(EepAddressLine2, ',', '')
        ,drvEmpAdd3 = ''
        ,drvEmpCity = EepAddressCity
        ,drvEmpCount = ''
        ,drvEmpState = EepAddressState
        ,drvEmpZip = EepAddressZipCode
        ,drvEmpHPh = CASE WHEN EepPhoneHomeNumber IS NOT NULL THEN SUBSTRING(EepPhoneHomeNumber, 1, 3) + '-' + 
                     SUBSTRING(EepPhoneHomeNumber, 4, 3) + '-' + 
                     SUBSTRING(EepPhoneHomeNumber, 7, 4) ELSE '' END
        ,drvEmpWPh = CASE WHEN EecPhoneBusinessNumber <> '' THEN SUBSTRING(EecPhoneBusinessNumber, 1, 3) + '-' + 
                     SUBSTRING(EecPhoneBusinessNumber, 4, 3) + '-' + 
                     SUBSTRING(EecPhoneBusinessNumber, 7, 4) ELSE '' END
        ,drvEmpGen = CASE WHEN EepGender = 'M' THEN 'M' 
                            WHEN EepGender = 'F' THEN 'F' ELSE 'U' END
        ,drvEmpMarit = CASE EepMaritalStatus
                            WHEN 'S' THEN 'Single'
                            WHEN 'D' THEN 'Divorced'
                            WHEN 'M' THEN 'Married'
                            WHEN 'W' THEN 'Widowed' ELSE '' END
        ,drvEmpDtMar = ''
        ,drvEmpRace = ''
        ,drvEmpCitiz = ''
        ,drvEmpHandi = ''
        ,drvEmpHospi = ''
        ,drvEmpSmoke = CASE WHEN EepIsSmoker = 'Y' THEN 'Yes' ELSE 'No' END
        ,drvEmpLangu = ''
        ,drvEmptDtSt = LEFT(CONVERT(VARCHAR, EecDateOfLastHire, 126), 10)
        ,drvEmptDtTerm = LEFT(ISNULL(CONVERT(VARCHAR, EecDateOfTermination, 126), ''), 10)
        ,drvEmptTermReason = TchDesc -- TscDesc WHERE TrmReasn = EecTermReason (send the description) 
        --CASE WHEN EecEmplStatus = 'T' THEN EecTermReason END
        ,drvEmptDtHire = ''
        ,drvEmptDtOrigHire = LEFT(CONVERT(VARCHAR, EecDateOfOriginalHire, 126), 10)
        ,drvEmptDtBenEligh = ''
        ,drvEmptDtRet = ''
        ,drvEmptNum = ''
        ,drvEmptStat = CASE EecEmplStatus
                            WHEN 'A' THEN 'Active'
                            WHEN 'T' THEN 'Terminated'
                            WHEN 'L' THEN 'LOA' END
        ,drvEmptType = ''
        ,drvEmptFull = ''
        ,drvEmptExStat = ''
        ,drvEmptRegion = ''
        ,drvEmptDiv = ''
        ,drvEmptDep = ''
        ,drvEmptLoc = ''
        ,drvEmptJobTitle = ''
        ,drvEmptJobCode = ''
        ,drvEmptPerc = ''
        ,drvEmptIsCorpOf = ''
        ,drvEmptIsKeyEmp = ''
        ,drvEmptIsHighComp = ''
        ,drvEmptUnion = ''
        ,drvEmptMedElig = ''
        ,drvEmptCompAnnAmt = ''
        ,drvEmpCompNumPay = ''
        ,drvEmpCompHrlyRate = ''
        ,drvEmptCompEffFrom = ''
        ,drvEmptWeeklyHrs = ''
        ,drvConSysId = ''
        ,drvConSSN = CAST('' as varchar(50))
        ,drvConFName = CAST('' as varchar(50))
        ,drvConLName = CAST('' as varchar(50))
        ,drvConMName = CAST('' as varchar(50))
        ,drvConNameSuff = CAST('' as varchar(50))
        ,drvConNamePref = ''
        ,drvConDOB = CAST('' as varchar(50))
        ,drvConDOD = ''
        ,drvConEmail = ''
        ,drvConAddr1 = ''
        ,drvConAddr2 = ''
        ,drvConAddr3 = ''
        ,drvConAddCity = ''
        ,drvConAddCounty = ''
        ,drvConAddState = ''
        ,drvConAddZip = ''
        ,drvConHPh = CAST('' as varchar(50))
        ,drvConWPh = ''
        ,drvConGen = CAST('' as varchar(50))
        ,drvConMaritalStat = ''
        ,drvConRace = ''
        ,drvConCitiz = ''
        ,drvConHandi = ''
        ,drvConHospi = ''
        ,drvConSmoke = ''
        ,drvConLangu = ''
        ,drvConIRSQual = ''
        ,drvConFullTimeStuddent = ''
        ,drvBenCarName = 'Vital WorkLife' 
        ,drvBenCarEIN = ''
        ,drvBenType = 'Employee Assistance Program' 
 
        ,drvBenPlanName = 'Employee Assistance Program'
        ,drvBenPolNum1 = '290319' 
        ,drvBenPolNum2 = ''
        ,drvBenPolNum3 = ''
        ,drvBenPolNum4 = ''
        ,drvBenPolNum5 = ''
        ,drvBenEffFrom = LEFT(CONVERT(VARCHAR, EedBenStartDate, 126), 10)
        ,drvBenEffLastDt = LEFT(ISNULL(CONVERT(VARCHAR, EedBenStopDate, 126), ''), 10)
        ,drvBenOrigEffFrom = ''
        ,drvBenCovLevel = CASE WHEN EedDedCode IN ('BLD', 'BLEE', 'FCHI', 'FMED', 'LIFEE') THEN 'EMP'
                                WHEN EedDedCode = 'LIFES' THEN 'ESP'
                                WHEN EedDedCode = 'LIFEC' THEN 'ECH'
                                WHEN EedDedCode = 'PTDEN' AND EedBenOption = 'EE1' AND ConRelationship = 'SPS' THEN 'ESP'
                                WHEN EedDedCode = 'PTDEN' AND EedBenOption = 'EE1' AND ConRelationship IN ('CHL', 'STC') THEN 'ECH'
                                WHEN EedBenOption = 'EE' THEN 'EMP'
                                WHEN EedBenOption IN ('EES', 'EEDP') THEN 'ESP'
                                WHEN EedBenOption IN ('EEF', 'EEDPF') THEN 'FAM'
                                WHEN EedBenOption IN ('EEC', 'EECH') THEN 'ECH' END
        ,drvBenIsWaived = ''
        ,drvBenBaseCovAmt = CASE WHEN EedDedCode IN ('LIFEE', 'LIFES', 'LIFEC') THEN EedBenAmt
                                END
        ,drvBenAppCovAmt = ''
        ,drvBenReqCovAmt = ''
        ,drvBenEmpPrem = ''
        ,drvBenEmployerPrem = ''
        ,drvBenNumDedPerYear = ''
        ,drvBenSalary = ''
        ,drvBenMedOfficeNum = ''
        ,drvBenMedOfficeProvName = ''
        ,drvBenMedOfficeProvAdd = ''
        ,drvBenPercent = ''
        ,drvInitialSort = '1' + EepSSN
        ,drvSubSort = '1'
   -- INTO dbo.U_EEVRYSTCOB_drvTbl
    FROM dbo.U_EEVRYSTCOB_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.u_dsi_bdm_EmpDeductions WITH(NOLOCK)
        ON EedEEID = xEEID
        AND EedCOID = xCOID
        AND EedFormatCode = @FormatCode
        AND EedValidForExport = 'Y'
    JOIN dbo.OrgLevel WITH(NOLOCK)
        ON OrgCode = EecOrgLvl1
    --JOIN dbo.U_EEVRYSTCOB_Audit 
    --    ON audEEID = xEEID
    --    AND audKey2 = xCOID
     LEFT JOIN dbo.u_dsi_bdm_DepDeductions WITH(NOLOCK)
        ON DbnEEID = xEEID
        AND DbnCOID = xCOID
        AND DbnFormatCode = @FormatCode
        AND DbnValidForExport = 'Y'
     LEFT JOIN dbo.TrmReasn WITH (NOLOCK)  
        ON EecTermReason =   TchCode 
     LEFT JOIN dbo.Contacts WITH(NOLOCK)
        ON ConEEID = EedEEID
        AND DbnDepRecID = ConSystemID
    WHERE --audNewHire = 'Y' OR audTerm = 'Y'
     EecEEType NOT IN ('AG', 'CON', 'INT', 'SUM', 'Z')
     AND EedDedCode IN ('BLD', 'BLEE')
    
-- Spouse Record
    INSERT INTO dbo.U_EEVRYSTCOB_drvTbl
     SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRecType = 'D'
        ,drvReltoEmp = 'Spouse'
        ,drvOrgSysId = EecOrgLvl1
        ,drvOrgName = OrgDesc 
        ,drvOrgEIN = ''
        ,drvEmpSysId = EecEmpNo
        ,drvEmpUser = EepNameFirst + '.' + EepNameLast
        ,drvEmpSSN = SUBSTRING(EepSSN, 1, 3)+'-'+
                     SUBSTRING(EepSSN, 4, 2)+'-'+
                     SUBSTRING(EepSSN, 6, 4) 
        ,drvEmpNum = EecEmpNo
        ,drvEmpFName = EepNameFirst
        ,drvEmpLName = EepNameLast
        ,drvEmpMName = EepNameMiddle
        ,drvEmpSuffi = EepNameSuffix
        ,drvEmpPrefi = ''
        ,drvEmpDOB = LEFT(CONVERT(VARCHAR, EepDateOfBirth, 126), 10) -- yyyy-mm-dd format
        ,drvEmpDOD = LEFT(CONVERT(VARCHAR, EepDateDeceased, 126),10) 
        ,drvEmpEmail = EepAddressEMail
        ,drvEmpAdd1 = REPLACE(EepAddressLine1, ',', '')
        ,drvEmpAdd2 = REPLACE(EepAddressLine2, ',', '')
        ,drvEmpAdd3 = ''
        ,drvEmpCity = EepAddressCity
        ,drvEmpCount = ''
        ,drvEmpState = EepAddressState
        ,drvEmpZip = EepAddressZipCode
        ,drvEmpHPh = CASE WHEN EepPhoneHomeNumber IS NOT NULL THEN SUBSTRING(EepPhoneHomeNumber, 1, 3) + '-' + 
                     SUBSTRING(EepPhoneHomeNumber, 4, 3) + '-' + 
                     SUBSTRING(EepPhoneHomeNumber, 7, 4) ELSE '' END
        ,drvEmpWPh = CASE WHEN EecPhoneBusinessNumber <> '' THEN SUBSTRING(EecPhoneBusinessNumber, 1, 3) + '-' + 
                     SUBSTRING(EecPhoneBusinessNumber, 4, 3) + '-' + 
                     SUBSTRING(EecPhoneBusinessNumber, 7, 4) ELSE '' END
        ,drvEmpGen = CASE WHEN EepGender = 'M' THEN 'M' 
                            WHEN EepGender = 'F' THEN 'F' ELSE 'U' END
        ,drvEmpMarit = CASE EepMaritalStatus
                            WHEN 'S' THEN 'Single'
                            WHEN 'D' THEN 'Divorced'
                            WHEN 'M' THEN 'Married'
                            WHEN 'W' THEN 'Widowed' ELSE '' END
        ,drvEmpDtMar = ''
        ,drvEmpRace = ''
        ,drvEmpCitiz = ''
        ,drvEmpHandi = ''
        ,drvEmpHospi = ''
        ,drvEmpSmoke = CASE WHEN EepIsSmoker = 'Y' THEN 'Yes' ELSE 'No' END
        ,drvEmpLangu = ''
        ,drvEmptDtSt = LEFT(CONVERT(VARCHAR, EecDateOfLastHire, 126), 10)
        ,drvEmptDtTerm = LEFT(ISNULL(CONVERT(VARCHAR, EecDateOfTermination, 126), ''), 10)
        ,drvEmptTermReason = TchDesc -- TscDesc WHERE TrmReasn = EecTermReason (send the description) 
        --CASE WHEN EecEmplStatus = 'T' THEN EecTermReason END
        ,drvEmptDtHire = ''
        ,drvEmptDtOrigHire = LEFT(CONVERT(VARCHAR, EecDateOfOriginalHire, 126), 10)
        ,drvEmptDtBenEligh = ''
        ,drvEmptDtRet = ''
        ,drvEmptNum = ''
        ,drvEmptStat = CASE EecEmplStatus
                            WHEN 'A' THEN 'Active'
                            WHEN 'T' THEN 'Terminated'
                            WHEN 'L' THEN 'LOA' END
        ,drvEmptType = ''
        ,drvEmptFull = ''
        ,drvEmptExStat = ''
        ,drvEmptRegion = ''
        ,drvEmptDiv = ''
        ,drvEmptDep = ''
        ,drvEmptLoc = ''
        ,drvEmptJobTitle = ''
        ,drvEmptJobCode = ''
        ,drvEmptPerc = ''
        ,drvEmptIsCorpOf = ''
        ,drvEmptIsKeyEmp = ''
        ,drvEmptIsHighComp = ''
        ,drvEmptUnion = ''
        ,drvEmptMedElig = ''
        ,drvEmptCompAnnAmt = ''
        ,drvEmpCompNumPay = ''
        ,drvEmpCompHrlyRate = ''
        ,drvEmptCompEffFrom = ''
        ,drvEmptWeeklyHrs = ''
        ,drvConSysId = ''
        ,drvConSSN = SUBSTRING(ConSSN, 1, 3)+'-'+
                     SUBSTRING(ConSSN, 4, 2)+'-'+
                     SUBSTRING(ConSSN, 6, 4) 
        ,drvConFName = ConNameFirst
        ,drvConLName = ConNameLast
        ,drvConMName = ConNameMiddle
        ,drvConNameSuff = CASE WHEN ConNameSuffix <> 'Z' THEN ConNameSuffix ELSE '' END
        ,drvConNamePref = ''
        ,drvConDOB = LEFT(CONVERT(VARCHAR, ConDateOfBirth, 126), 10)
        ,drvConDOD = ''
        ,drvConEmail = ''
        ,drvConAddr1 = ''
        ,drvConAddr2 = ''
        ,drvConAddr3 = ''
        ,drvConAddCity = ''
        ,drvConAddCounty = ''
        ,drvConAddState = ''
        ,drvConAddZip = ''
        ,drvConHPh = CASE WHEN ConPhoneHomeNumber IS NOT NULL OR ConPhoneHomeNumber <> '' THEN SUBSTRING(ConPhoneHomeNumber, 1, 3) + '-' + 
                     SUBSTRING(ConPhoneHomeNumber, 4, 3) + '-' + 
                     SUBSTRING(ConPhoneHomeNumber, 7, 4) ELSE '' END
        ,drvConWPh = ''
        ,drvConGen = CASE WHEN ConGender = 'F' THEN 'F'
                            WHEN ConGender = 'M' THEN 'M'
                            ELSE 'U' END
        ,drvConMaritalStat = ''
        ,drvConRace = ''
        ,drvConCitiz = ''
        ,drvConHandi = ''
        ,drvConHospi = ''
        ,drvConSmoke = ''
        ,drvConLangu = ''
        ,drvConIRSQual = ''
        ,drvConFullTimeStuddent = ''
        ,drvBenCarName = CASE WHEN DbnDedCode IN ('MDP1', 'MDP2', 'MDP3') THEN 'PreferredOne'
                                WHEN DbnDedCode = 'PTDEN' THEN 'HealthPartners'
                                WHEN DbnDedCode = 'VVIS' THEN 'EyeMed Vision Care'
                                WHEN DbnDedCode IN ('FCHI', 'FMED') THEN 'OptumHealth'
                                 WHEN DbnDedCode IN ('BLD', 'BLEE') THEN 'Voya'
                                WHEN DbnDedCode IN ('BLD', 'BLEE') THEN 'Vital WorkLife' 
                                WHEN DbnDedCode IN ('LIFEC', 'LIFEE', 'LIFES') THEN 'Voya' END
        ,drvBenCarEIN = ''
        ,drvBenType = CASE WHEN DbnDedCode IN ('MDP1', 'MDP2', 'MDP3') THEN 'Medical'
                                WHEN DbnDedCode = 'PTDEN' THEN 'Dental'
                                WHEN DbnDedCode = 'VVIS' THEN 'Vision'
                                WHEN DbnDedCode IN ('FCHI', 'FMED') THEN 'Flexible Spending Account'
                                WHEN DbnDedCode IN ('BLD', 'BLEE') THEN 'Employee Assistance Program' 
                                WHEN DbnDedCode IN ('BLD', 'BLEE') THEN 'Basic Employee Life' 
                                WHEN DbnDedCode IN ('LIFEC', 'LIFEE', 'LIFES') THEN 'Voluntary Life' END
        ,drvBenPlanName = CASE WHEN DbnDedCode = 'MDP1' THEN 'Medical Copay Plan 1'
                                WHEN DbnDedCode = 'MDP2' THEN 'Medical HSA Plan 2'
                                WHEN DbnDedCode = 'MDP3' THEN 'Medical HD HSA Plan 3'
                                WHEN DbnDedCode = 'PTDEN' THEN 'Dental Insurance PreTax'
                                WHEN DbnDedCode = 'VVIS' THEN 'Vision'
                                --WHEN DbnDedCode = 'FCHI' THEN 'Flex Child Care'
                                --WHEN DbnDedCode = 'FMED' THEN 'Flex Medical'
                                --WHEN DbnDedCode = 'BLD' THEN 'Basic Life Directors'
                                --WHEN DbnDedCode = 'BLEE' THEN 'Basic Life EE Only'
                                WHEN DbnDedCode = 'LIFEC' THEN 'Supplemental Life - Child'
                                --WHEN DbnDedCode = 'LIFEE' THEN 'Supplemental ife - Employee'
                                WHEN DbnDedCode = 'LIFES' THEN 'Supplemental Life - Spouse' END
        ,drvBenPolNum1 = CASE WHEN DbnDedCode IN ('MDP1', 'MDP2', 'MDP3') THEN 'PKA20366'
                                WHEN DbnDedCode = 'PTDEN' THEN '19096'
                                WHEN DbnDedCode = 'VVIS' THEN '9894049'
                               -- WHEN DbnDedCode IN ('FCHI', 'FMED') THEN '775992'
                               -- WHEN DbnDedCode IN ('BLD', 'BLEE') THEN '290319' 
                                WHEN DbnDedCode IN ('LIFEC', 'LIFEE', 'LIFES') THEN '363707' END
        ,drvBenPolNum2 = ''
        ,drvBenPolNum3 = ''
        ,drvBenPolNum4 = ''
        ,drvBenPolNum5 = ''
        ,drvBenEffFrom = LEFT(CONVERT(VARCHAR, DbnBenStartDate, 126), 10)
        ,drvBenEffLastDt = LEFT(ISNULL(CONVERT(VARCHAR, DbnBenStopDate, 126), ''), 10)
        ,drvBenOrigEffFrom = ''
        ,drvBenCovLevel = CASE WHEN DbnDedCode IN ('BLD', 'BLEE', 'FCHI', 'FMED', 'LIFEE') THEN 'EMP'
                                WHEN DbnDedCode = 'LIFES' THEN 'ESP'
                                WHEN DbnDedCode = 'LIFEC' THEN 'ECH'
                                WHEN DbnDedCode = 'PTDEN' AND DbnBenOption = 'EE1' AND ConRelationship = 'SPS' THEN 'ESP'
                                WHEN DbnDedCode = 'PTDEN' AND DbnBenOption = 'EE1' AND ConRelationship IN ('CHL', 'STC') THEN 'ECH'
                                WHEN DbnBenOption = 'EE' THEN 'EMP'
                                WHEN DbnBenOption IN ('EES', 'EEDP') THEN 'ESP'
                                WHEN DbnBenOption IN ('EEF', 'EEDPF') THEN 'FAM'
                                WHEN DbnBenOption IN ('EEC', 'EECH') THEN 'ECH' END
        ,drvBenIsWaived = ''
        ,drvBenBaseCovAmt = ''
        ,drvBenAppCovAmt = ''
        ,drvBenReqCovAmt = ''
        ,drvBenEmpPrem = ''
        ,drvBenEmployerPrem = ''
        ,drvBenNumDedPerYear = ''
        ,drvBenSalary = ''
        ,drvBenMedOfficeNum = ''
        ,drvBenMedOfficeProvName = ''
        ,drvBenMedOfficeProvAdd = ''
        ,drvBenPercent = ''
        ,drvInitialSort = '1' + EepSSN
        ,drvSubSort = '2'
    FROM dbo.U_EEVRYSTCOB_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.u_dsi_bdm_DepDeductions WITH(NOLOCK)
        ON DbnEEID = xEEID
        AND DbnCOID = xCOID
        AND DbnFormatCode = @FormatCode
        AND DbnValidForExport = 'Y'
    JOIN dbo.Contacts WITH(NOLOCK)
        ON ConEEID = DbnEEID
        AND ConSystemID = DbnDepRecId
    JOIN dbo.OrgLevel WITH(NOLOCK)
        ON OrgCode = EecOrgLvl1
    --JOIN dbo.U_EEVRYSTCOB_Audit 
    --    ON audEEID = xEEID
    --    AND audKey2 = xCOID
     LEFT JOIN dbo.TrmReasn WITH (NOLOCK)  
        ON EecTermReason =   TchCode 
    WHERE --audNewHire = 'Y' OR audTerm = 'Y'
        DbnRelationship = 'SPS'
    AND EecEEType NOT IN ('AG', 'CON', 'INT', 'SUM', 'Z')
    ;

---- Child Record
    INSERT INTO dbo.U_EEVRYSTCOB_drvTbl
     SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRecType = 'D'
        ,drvReltoEmp = 'Child'
        ,drvOrgSysId = EecOrgLvl1
        ,drvOrgName = OrgDesc 
        ,drvOrgEIN = ''
        ,drvEmpSysId = EecEmpNo
        ,drvEmpUser = EepNameFirst + '.' + EepNameLast
        ,drvEmpSSN = SUBSTRING(EepSSN, 1, 3)+'-'+
                     SUBSTRING(EepSSN, 4, 2)+'-'+
                     SUBSTRING(EepSSN, 6, 4) 
        ,drvEmpNum = EecEmpNo
        ,drvEmpFName = EepNameFirst
        ,drvEmpLName = EepNameLast
        ,drvEmpMName = EepNameMiddle
        ,drvEmpSuffi = EepNameSuffix
        ,drvEmpPrefi = ''
        ,drvEmpDOB = LEFT(CONVERT(VARCHAR, EepDateOfBirth, 126), 10) -- yyyy-mm-dd format
        ,drvEmpDOD = LEFT(CONVERT(VARCHAR, EepDateDeceased, 126), 10)
        ,drvEmpEmail = EepAddressEMail
        ,drvEmpAdd1 = REPLACE(EepAddressLine1, ',', '')
        ,drvEmpAdd2 = REPLACE(EepAddressLine2, ',', '')
        ,drvEmpAdd3 = ''
        ,drvEmpCity = EepAddressCity
        ,drvEmpCount = ''
        ,drvEmpState = EepAddressState
        ,drvEmpZip = EepAddressZipCode
        ,drvEmpHPh = CASE WHEN EepPhoneHomeNumber IS NOT NULL THEN SUBSTRING(EepPhoneHomeNumber, 1, 3) + '-' + 
                     SUBSTRING(EepPhoneHomeNumber, 4, 3) + '-' + 
                     SUBSTRING(EepPhoneHomeNumber, 7, 4) ELSE '' END
        ,drvEmpWPh = CASE WHEN EecPhoneBusinessNumber <> '' THEN SUBSTRING(EecPhoneBusinessNumber, 1, 3) + '-' + 
                     SUBSTRING(EecPhoneBusinessNumber, 4, 3) + '-' + 
                     SUBSTRING(EecPhoneBusinessNumber, 7, 4) ELSE '' END
        ,drvEmpGen = CASE WHEN EepGender = 'M' THEN 'M' 
                            WHEN EepGender = 'F' THEN 'F' ELSE 'U' END
        ,drvEmpMarit = CASE EepMaritalStatus
                            WHEN 'S' THEN 'Single'
                            WHEN 'D' THEN 'Divorced'
                            WHEN 'M' THEN 'Married'
                            WHEN 'W' THEN 'Widowed' ELSE '' END
        ,drvEmpDtMar = ''
        ,drvEmpRace = ''
        ,drvEmpCitiz = ''
        ,drvEmpHandi = ''
        ,drvEmpHospi = ''
        ,drvEmpSmoke = CASE WHEN EepIsSmoker = 'Y' THEN 'Yes' ELSE 'No' END
        ,drvEmpLangu = ''
        ,drvEmptDtSt = LEFT(CONVERT(VARCHAR, EecDateOfLastHire, 126), 10)
        ,drvEmptDtTerm = LEFT(ISNULL(CONVERT(VARCHAR, EecDateOfTermination, 126), ''), 10)
        ,drvEmptTermReason = TchDesc -- TscDesc WHERE TrmReasn = EecTermReason (send the description) 
        --CASE WHEN EecEmplStatus = 'T' THEN EecTermReason END
        ,drvEmptDtHire = ''
        ,drvEmptDtOrigHire = LEFT(CONVERT(VARCHAR, EecDateOfOriginalHire, 126), 10)
        ,drvEmptDtBenEligh = ''
        ,drvEmptDtRet = ''
        ,drvEmptNum = ''
        ,drvEmptStat = CASE EecEmplStatus
                            WHEN 'A' THEN 'Active'
                            WHEN 'T' THEN 'Terminated'
                            WHEN 'L' THEN 'LOA' END
        ,drvEmptType = ''
        ,drvEmptFull = ''
        ,drvEmptExStat = ''
        ,drvEmptRegion = ''
        ,drvEmptDiv = ''
        ,drvEmptDep = ''
        ,drvEmptLoc = ''
        ,drvEmptJobTitle = ''
        ,drvEmptJobCode = ''
        ,drvEmptPerc = ''
        ,drvEmptIsCorpOf = ''
        ,drvEmptIsKeyEmp = ''
        ,drvEmptIsHighComp = ''
        ,drvEmptUnion = ''
        ,drvEmptMedElig = ''
        ,drvEmptCompAnnAmt = ''
        ,drvEmpCompNumPay = ''
        ,drvEmpCompHrlyRate = ''
        ,drvEmptCompEffFrom = ''
        ,drvEmptWeeklyHrs = ''
        ,drvConSysId = ''
        ,drvConSSN = SUBSTRING(ConSSN, 1, 3)+'-'+
                     SUBSTRING(ConSSN, 4, 2)+'-'+
                     SUBSTRING(ConSSN, 6, 4) 
        ,drvConFName = ConNameFirst
        ,drvConLName = ConNameLast
        ,drvConMName = ConNameMiddle
        ,drvConNameSuff = CASE WHEN ConNameSuffix <> 'Z' THEN ConNameSuffix ELSE '' END
        ,drvConNamePref = ''
        ,drvConDOB = LEFT(CONVERT(VARCHAR, ConDateOfBirth, 126), 10)
        ,drvConDOD = ''
        ,drvConEmail = ''
        ,drvConAddr1 = ''
        ,drvConAddr2 = ''
        ,drvConAddr3 = ''
        ,drvConAddCity = ''
        ,drvConAddCounty = ''
        ,drvConAddState = ''
        ,drvConAddZip = ''
        ,drvConHPh = CASE WHEN ConPhoneHomeNumber IS NOT NULL OR ConPhoneHomeNumber <> '' THEN SUBSTRING(ConPhoneHomeNumber, 1, 3) + '-' + 
                     SUBSTRING(ConPhoneHomeNumber, 4, 3) + '-' + 
                     SUBSTRING(ConPhoneHomeNumber, 7, 4) ELSE '' END
        ,drvConWPh = ''
        ,drvConGen = CASE WHEN ConGender = 'F' THEN 'F'
                            WHEN ConGender = 'M' THEN 'M'
                            ELSE 'U' END
        ,drvConMaritalStat = ''
        ,drvConRace = ''
        ,drvConCitiz = ''
        ,drvConHandi = ''
        ,drvConHospi = ''
        ,drvConSmoke = ''
        ,drvConLangu = ''
        ,drvConIRSQual = ''
        ,drvConFullTimeStuddent = ''
        ,drvBenCarName = CASE WHEN DbnDedCode IN ('MDP1', 'MDP2', 'MDP3') THEN 'PreferredOne'
                                WHEN DbnDedCode = 'PTDEN' THEN 'HealthPartners'
                                WHEN DbnDedCode = 'VVIS' THEN 'EyeMed Vision Care'
                                WHEN DbnDedCode IN ('FCHI', 'FMED') THEN 'OptumHealth'
                                 WHEN DbnDedCode IN ('BLD', 'BLEE') THEN 'Voya'
                                WHEN DbnDedCode IN ('BLD', 'BLEE') THEN 'Vital WorkLife' 
                                WHEN DbnDedCode IN ('LIFEC', 'LIFEE', 'LIFES') THEN 'Voya' END
        ,drvBenCarEIN = ''
        ,drvBenType = CASE WHEN DbnDedCode IN ('MDP1', 'MDP2', 'MDP3') THEN 'Medical'
                                WHEN DbnDedCode = 'PTDEN' THEN 'Dental'
                                WHEN DbnDedCode = 'VVIS' THEN 'Vision'
                                WHEN DbnDedCode IN ('FCHI', 'FMED') THEN 'Flexible Spending Account'
                                WHEN DbnDedCode IN ('BLD', 'BLEE') THEN 'Employee Assistance Program' 
                                WHEN DbnDedCode IN ('BLD', 'BLEE') THEN 'Basic Employee Life' 
                                WHEN DbnDedCode IN ('LIFEC', 'LIFEE', 'LIFES') THEN 'Voluntary Life' END
        ,drvBenPlanName = CASE WHEN DbnDedCode = 'MDP1' THEN 'Medical Copay Plan 1'
                                WHEN DbnDedCode = 'MDP2' THEN 'Medical HSA Plan 2'
                                WHEN DbnDedCode = 'MDP3' THEN 'Medical HD HSA Plan 3'
                                WHEN DbnDedCode = 'PTDEN' THEN 'Dental Insurance PreTax'
                                WHEN DbnDedCode = 'VVIS' THEN 'Vision'
                                --WHEN DbnDedCode = 'FCHI' THEN 'Flex Child Care'
                                --WHEN DbnDedCode = 'FMED' THEN 'Flex Medical'
                                --WHEN DbnDedCode = 'BLD' THEN 'Basic Life Directors'
                                --WHEN DbnDedCode = 'BLEE' THEN 'Basic Life EE Only'
                                WHEN DbnDedCode = 'LIFEC' THEN 'Supplemental Life - Child'
                                --WHEN DbnDedCode = 'LIFEE' THEN 'Supplemental ife - Employee'
                                WHEN DbnDedCode = 'LIFES' THEN 'Supplemental Life - Spouse' END
        ,drvBenPolNum1 = CASE WHEN DbnDedCode IN ('MDP1', 'MDP2', 'MDP3') THEN 'PKA20366'
                                WHEN DbnDedCode = 'PTDEN' THEN '19096'
                                WHEN DbnDedCode = 'VVIS' THEN '9894049'
                             --   WHEN DbnDedCode IN ('FCHI', 'FMED') THEN '775992'
                             --   WHEN DbnDedCode IN ('BLD', 'BLEE') THEN '290319' 
                                WHEN DbnDedCode IN ('LIFEC', 'LIFEE', 'LIFES') THEN '363707' END
        ,drvBenPolNum2 = ''
        ,drvBenPolNum3 = ''
        ,drvBenPolNum4 = ''
        ,drvBenPolNum5 = ''
        ,drvBenEffFrom = LEFT(CONVERT(VARCHAR, DbnBenStartDate, 126), 10)
        ,drvBenEffLastDt = LEFT(ISNULL(CONVERT(VARCHAR, DbnBenStopDate, 126), ''), 10)
        ,drvBenOrigEffFrom = ''
        ,drvBenCovLevel = CASE WHEN DbnDedCode IN ('BLD', 'BLEE', 'FCHI', 'FMED', 'LIFEE') THEN 'EMP'
                                WHEN DbnDedCode = 'LIFES' THEN 'ESP'
                                WHEN DbnDedCode = 'LIFEC' THEN 'ECH'
                                WHEN DbnDedCode = 'PTDEN' AND DbnBenOption = 'EE1' AND ConRelationship = 'SPS' THEN 'ESP'
                                WHEN DbnDedCode = 'PTDEN' AND DbnBenOption = 'EE1' AND ConRelationship IN ('CHL', 'STC') THEN 'ECH'
                                WHEN DbnBenOption = 'EE' THEN 'EMP'
                                WHEN DbnBenOption IN ('EES', 'EEDP') THEN 'ESP'
                                WHEN DbnBenOption IN ('EEF', 'EEDPF') THEN 'FAM'
                                WHEN DbnBenOption IN ('EEC', 'EECH') THEN 'ECH' END
        ,drvBenIsWaived = ''
        ,drvBenBaseCovAmt = ''
        ,drvBenAppCovAmt = ''
        ,drvBenReqCovAmt = ''
        ,drvBenEmpPrem = ''
        ,drvBenEmployerPrem = ''
        ,drvBenNumDedPerYear = ''
        ,drvBenSalary = ''
        ,drvBenMedOfficeNum = ''
        ,drvBenMedOfficeProvName = ''
        ,drvBenMedOfficeProvAdd = ''
        ,drvBenPercent = ''
        ,drvInitialSort = '1' + EepSSN
        ,drvSubSort = '3'
    FROM dbo.U_EEVRYSTCOB_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.u_dsi_bdm_DepDeductions WITH(NOLOCK)
        ON DbnEEID = xEEID
        AND DbnCOID = xCOID
        AND DbnFormatCode = @FormatCode
        AND DbnValidForExport = 'Y'
    JOIN dbo.Contacts WITH(NOLOCK)
        ON ConEEID = DbnEEID
        AND ConSystemID = DbnDepRecId
    JOIN dbo.OrgLevel WITH(NOLOCK)
        ON OrgCode = EecOrgLvl1
    --JOIN dbo.U_EEVRYSTCOB_Audit 
    --    ON audEEID = xEEID
    --    AND audKey2 = xCOID
       LEFT JOIN dbo.TrmReasn WITH (NOLOCK)  
        ON EecTermReason =   TchCode 
    WHERE --audNewHire = 'Y' OR audTerm = 'Y'
     DbnRelationship IN ('CHL', 'STC')
     AND EecEEType NOT IN ('AG', 'CON', 'INT', 'SUM', 'Z')
    ;

    UPDATE dbo.U_EEVRYSTCOB_drvTbl
    SET drvConHPh = ''
    WHERE drvConHPh = '   -   -    '

	UPDATE U_EEVRYSTCOB_drvTbl
	SET drvBenBaseCovAmt = NULL
	WHERE drvbenbasecovamt = '0.00'

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
ALTER VIEW dbo.dsi_vwEEVRYSTCOB_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EEVRYSTCOB_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EEVRYSTCOB%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202107081'
       ,expStartPerControl     = '202107081'
       ,expLastEndPerControl   = '202107159'
       ,expEndPerControl       = '202107159'
WHERE expFormatCode = 'EEVRYSTCOB';

**********************************************************************************/
