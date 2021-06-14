USE [ULTIPRO_WPMEES]
GO
/****** Object:  StoredProcedure [dbo].[dsi_sp_BuildDriverTables_EF401COMXP]    Script Date: 6/11/2021 11:04:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EF401COMXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Mustang Extreme

Created By: James Bender
Business Analyst: Cheryl Petitti
Create Date: 05/25/2021
Service Request Number: TekP-2021-02-17-0006

Purpose: Fidelity Combined 401k Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX
select * from ascdefh where adhformatcode = 'ef401comxp'
SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EF401COMXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EF401COMXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EF401COMXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EF401COMXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EF401COMXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EF401COMXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EF401COMXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EF401COMXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EF401COMXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EF401COMXP', 'SCH_EF401C';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EF401COMXP';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EF401COMXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EF401COMXP';

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
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EF401COMXP_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EF401COMXP_AuditFields;
    CREATE TABLE dbo.U_EF401COMXP_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_EF401COMXP_AuditFields VALUES ('EmpComp','EecDateOfLastHire');
    INSERT INTO dbo.U_EF401COMXP_AuditFields VALUES ('EmpComp','EecDateOfOriginalHire');
    INSERT INTO dbo.U_EF401COMXP_AuditFields VALUES ('EmpComp','EecDateOfRetirement');
    INSERT INTO dbo.U_EF401COMXP_AuditFields VALUES ('EmpComp','EecDateOfTermination');
    INSERT INTO dbo.U_EF401COMXP_AuditFields VALUES ('EmpComp','EecEmplStatus');
    INSERT INTO dbo.U_EF401COMXP_AuditFields VALUES ('EmpComp','EecEmpNo');
    INSERT INTO dbo.U_EF401COMXP_AuditFields VALUES ('EmpComp','EecFullTimeOrPartTime');
    INSERT INTO dbo.U_EF401COMXP_AuditFields VALUES ('EmpComp','EecLocation');
    INSERT INTO dbo.U_EF401COMXP_AuditFields VALUES ('EmpComp','EecOrgLvl1');
    INSERT INTO dbo.U_EF401COMXP_AuditFields VALUES ('EmpComp','EecOrgLvl2');
    INSERT INTO dbo.U_EF401COMXP_AuditFields VALUES ('EmpComp','EecPayPeriod');
    INSERT INTO dbo.U_EF401COMXP_AuditFields VALUES ('EmpComp','EecUnionLocal');
    INSERT INTO dbo.U_EF401COMXP_AuditFields VALUES ('EmpPers','EepAddressCity');
    INSERT INTO dbo.U_EF401COMXP_AuditFields VALUES ('EmpPers','EepAddressCountry');
    INSERT INTO dbo.U_EF401COMXP_AuditFields VALUES ('EmpPers','EepAddressLine1');
    INSERT INTO dbo.U_EF401COMXP_AuditFields VALUES ('EmpPers','EepAddressLine2');
    INSERT INTO dbo.U_EF401COMXP_AuditFields VALUES ('EmpPers','EepAddressState');
    INSERT INTO dbo.U_EF401COMXP_AuditFields VALUES ('EmpPers','EepAddressZipCode');
    INSERT INTO dbo.U_EF401COMXP_AuditFields VALUES ('EmpPers','EepDateOfBirth');
    INSERT INTO dbo.U_EF401COMXP_AuditFields VALUES ('EmpPers','EepGender');
    INSERT INTO dbo.U_EF401COMXP_AuditFields VALUES ('EmpPers','EepMaritalStatus');
    INSERT INTO dbo.U_EF401COMXP_AuditFields VALUES ('EmpPers','EepNameFirst');
    INSERT INTO dbo.U_EF401COMXP_AuditFields VALUES ('EmpPers','EepNameLast');
    INSERT INTO dbo.U_EF401COMXP_AuditFields VALUES ('EmpPers','EepNameMiddle');
    INSERT INTO dbo.U_EF401COMXP_AuditFields VALUES ('EmpPers','EepSSN');
    INSERT INTO dbo.U_EF401COMXP_AuditFields VALUES ('EmpPers','EepEmailAddress');
	INSERT INTO dbo.U_EF401COMXP_AuditFields VALUES ('EmpPers','EepAddressEMailAlternate');

    INSERT INTO dbo.U_EF401COMXP_AuditFields VALUES ('OrgLevel','OrgDesc');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EF401COMXP_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EF401COMXP_Audit;
    SELECT DISTINCT
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
    INTO dbo.U_EF401COMXP_Audit
    FROM dbo.U_EF401COMXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_AuditData WITH (NOLOCK) 
        ON audKey1Value = xEEID
    JOIN dbo.U_EF401COMXP_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @EndDate -30 AND @EndDate
    AND audAction <> 'DELETE'
    AND ISNULL(audNewValue,'') <> '';

    --=====================================================================================
    -- Retain Most Recent Audit Record by AudKey1, AudKey2, AudKey3 and Audit Field Name
    --=====================================================================================
    DELETE FROM dbo.U_EF401COMXP_Audit WHERE audRowNo > 1;

	-- Find when/if IsDisability flag was flipped
    IF OBJECT_ID('U_EF401COMXP_D_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EF401COMXP_D_AuditFields;
    CREATE TABLE dbo.U_EF401COMXP_D_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_EF401COMXP_D_AuditFields VALUES ('EmpPers','EepIsDisabled');
    
    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EF401COMXP_D_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EF401COMXP_D_Audit;
    SELECT DISTINCT
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
    INTO dbo.U_EF401COMXP_D_Audit
    FROM dbo.U_EF401COMXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_AuditData WITH (NOLOCK) 
        ON audKey1Value = xEEID
    JOIN dbo.U_EF401COMXP_D_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE --audDateTime BETWEEN @EndDate -30 AND @EndDate
    --AND 
	audAction <> 'DELETE'
	AND audNewValue = 'Y'
    --AND ISNULL(audNewValue,'') <> '';

    --=====================================================================================
    -- Retain Most Recent Audit Record by AudKey1, AudKey2, AudKey3 and Audit Field Name
    --=====================================================================================
    DELETE FROM dbo.U_EF401COMXP_D_Audit WHERE audRowNo > 1;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EF401COMXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EF401COMXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '401F,401FE,401P,401PE,401RF,4KRFE,401RP, 4KRPE,401ER';

    IF OBJECT_ID('U_EF401COMXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EF401COMXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EF401COMXP_DedList
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
    IF OBJECT_ID('U_EF401COMXP_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EF401COMXP_PDedHist;
    SELECT DISTINCT
         PdhEEID
		 ,PdhSource =	CASE WHEN PdhDedCode IN ('401F','401FE','401P','401PE') THEN '01'
							WHEN PdhDedCode IN ('401RF','4KRFE','401RP','4KRPE') THEN '02'
							WHEN PdhDedCode IN ('401ER') THEN '03'
						END
		,PdhERAmt = SUM(PdhERCurAmt)
		,PdhEEAmt = SUM(PdhEECurAmt)
    INTO dbo.U_EF401COMXP_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EF401COMXP_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID, 
		CASE WHEN PdhDedCode IN ('401F','401FE','401P','401PE') THEN '01'
			WHEN PdhDedCode IN ('401RF','4KRFE','401RP','4KRPE') THEN '02'
			WHEN PdhDedCode IN ('401ER') THEN '03'
		END
    HAVING (SUM(PdhEECurAmt) <> 0.00 OR 
		SUM(PdhERCurAmt) <> 0.00)
    ;


	-------------------------------
    -- Working Table - Employees
    -------------------------------
    IF OBJECT_ID('U_EF401COMXP_Employees','U') IS NOT NULL
        DROP TABLE dbo.U_EF401COMXP_Employees;
    SELECT xEEID
        ,xCOID
        ,EepSSN
        ,EepNameFirst
        ,EepNameMiddle
        ,EepNameLast
        ,EepGender
        ,EepDateOfBirth
        ,EepMaritalStatus
        ,EepAddressLine1
        ,EepAddressLine2
        ,EepAddressLine3
        ,EepAddressCity
        ,EepAddressState
        ,EepAddressZipCode
        ,EepAddressCountry
        ,EecEmpNo
        ,EecEmplStatus
        ,EecDateOfOriginalHire
        ,EecDateOfLastHire
        ,EecDateOfTermination
        ,EecDateOfRetirement
        ,EecLocation
        ,EecFullTimeOrPartTime
        ,EecPayPeriod
        ,EecUnionLocal
        ,EecOrgLvl1
        ,EecOrgLvl2
        ,OrgLvl2Desc = O2.OrgDesc
        ,Record01Change
        ,Record02DChange
        ,Record02EChange
        ,Record03Change
        ,Record04Change
        ,Record05Change
        ,Record06Change
        ,Record11Change
        ,Record36Change
        ,Record60Change
        ,Record61Change
        ,audNewHire
        ,audReHire
        ,audTerm
        ,audSalaryChange
        ,EecDateOfSeniority
        ,EecAnnSalary
        ,EecTermReason 
        ,EecEmplStatusStartDate
        ,emailAddress
        ,eepAddressEMail = CASE WHEN ISNULL(RTRIM(eepAddressEMail),'') = '' THEN eepAddressEMailAlternate ELSE EepAddressEmail END
		,EecLeaveReason
		,EepIsDisabled
		,EecPayGroup		
    INTO dbo.U_EF401COMXP_Employees
    FROM dbo.U_EF401COMXP_EEList
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    LEFT JOIN dbo.OrgLevel O2 WITH (NOLOCK)
        ON O2.OrgCode = EecOrgLvl2
        AND O2.OrgLvl = '2'
    LEFT JOIN (
        -- Get Record Set Changes based on Audit Fields
        SELECT audEEID
            ,Record01Change = MAX(CASE WHEN audFieldName IN ('EepNameFirst','EepNameLast','EepNameMiddle','EepGender','EepMaritalStatus') THEN 'Y' ELSE 'N' END)
            ,Record02DChange = MAX(CASE WHEN audFieldName IN ('EecDateOfOriginalHire','EepDateOfBirth','EecDateOfTermination') THEN 'Y' ELSE 'N' END)
            ,Record02EChange = MAX(CASE WHEN audFieldName IN ('EecEmpNo') THEN 'Y' ELSE 'N' END)
            ,Record03Change = MAX(CASE WHEN audFieldName IN ('EepAddressLine1','EepAddressLine2','EepAddressLine3') THEN 'Y' ELSE 'N' END)
            ,Record04Change = MAX(CASE WHEN audFieldName IN ('EepAddressCity','EepAddressState','EepAddressZipCode') THEN 'Y' ELSE 'N' END)
            ,Record05Change = MAX(CASE WHEN audFieldName IN ('EepAddressCountry') THEN 'Y' ELSE 'N' END)
            ,Record06Change = MAX(CASE WHEN audFieldName IN ('OrgDesc') THEN 'Y' ELSE 'N' END)
            ,Record11Change = MAX(CASE WHEN audFieldName IN ('EecEmplStatus') THEN 'Y' ELSE 'N' END)
            ,Record36Change = MAX(CASE WHEN audFieldName IN ('EecOrglvl2') THEN 'Y' ELSE 'N' END)
            ,Record60Change = MAX(CASE WHEN audFieldName IN ('EecFullTimeOrPartTime','EecOrgLvl1','EecOrgLvl2','EecLocation','EecUnionLocal','EecPayPeriod') THEN 'Y' ELSE 'N' END)
            ,Record61Change = MAX(CASE WHEN audFieldName IN ('EecDateOfLastHire','EecDateOfRetirement') THEN 'Y' ELSE 'N' END)
            ,audNewHire = max(CASE WHEN  audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = '' AND ISNULL(audNewValue,'') = 'A' THEN 'Y' ELSE 'N' END)
            ,audReHire = max(CASE WHEN  audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = 'T' AND ISNULL(audNewValue,'') = 'A' THEN 'Y' ELSE 'N' END)
            ,audTerm = MAX(CASE WHEN  audFieldName = 'EecEmplStatus' AND ISNULL(audNewValue,'') = 'T' THEN 'Y' ELSE 'N' END)
            ,audSalaryChange = max(CASE  WHEN  audFieldName = 'EecAnnSalary' AND ISNULL(audNewValue,'') <> '' THEN 'Y' ELSE 'N' END)
            ,emailAddress = max(CASE  WHEN  audFieldName IN ('eepAddressEMailAlternate' , 'EepEmailAddress') AND ISNULL(audNewValue,'') <> '' THEN 'Y' ELSE 'N' END)
        FROM dbo.U_EF401COMXP_Audit
        GROUP BY audEEID
    ) AuditRecords
        ON audEEID = xEEID;

    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EF401COMXP_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EF401COMXP_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
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
    INTO dbo.U_EF401COMXP_PEarHist
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
    -- DETAIL RECORD - U_EF401COMXP_drvTbl_01
    ---------------------------------
    IF OBJECT_ID('U_EF401COMXP_drvTbl_01','U') IS NOT NULL
        DROP TABLE dbo.U_EF401COMXP_drvTbl_01;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '2 ' + EepSSN + ' 01'
        -- standard fields above and additional driver fields below
        ,drvPlanNumber = '91777'
        ,drvSSN = LEFT(eepSSN, 3) + '-' + RIGHT(LEFT(EepSSN, 5), 2) + '-' + RIGHT(RTRIM(EepSSN), 4)
        ,drvNameLast = EepNameLast
        ,drvNameMiddle = EepNameFirst + ' ' + CASE WHEN EepNameMiddle IS NOT NULL THEN LEFT(EepNameMiddle,1) ELSE '' END
        ,drvMaritalStatus =	CASE WHEN eepMaritalStatus IN ('S','D','W') THEN 'S'
								WHEN EepMaritalStatus = 'M' THEN 'M'
							END
        ,drvGender = CASE WHEN EepGender IN ('M','F') THEN EepGender END
    INTO dbo.U_EF401COMXP_drvTbl_01
	FROM dbo.U_EF401COMXP_Employees WITH (NOLOCK)
    WHERE Record01Change = 'Y' or audNewHire = 'Y' or  audReHire = 'Y';
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EF401COMXP_drvTbl_02D
    ---------------------------------
    IF OBJECT_ID('U_EF401COMXP_drvTbl_02D','U') IS NOT NULL
        DROP TABLE dbo.U_EF401COMXP_drvTbl_02D;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '2 ' + EepSSN + ' 02D'
        -- standard fields above and additional driver fields below
        ,drvPlanNumber = '91777'
        ,drvSSN = LEFT(eepSSN, 3) + '-' + RIGHT(LEFT(EepSSN, 5), 2) + '-' + RIGHT(RTRIM(EepSSN), 4)
        ,drvHireDate = EecDateOfOriginalHire
        ,drvVestingDate = CASE WHEN EecEmplStatus = 'A' AND EecDateOfOriginalHire BETWEEN @StartDAte AND @EndDate THEN EecDateOfOriginalHire END
        ,drvDateOfBirth = EepDateOfBirth
        ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN FORMAT(EecDateOfTermination, 'MMddyyyy') END
        ,drvDateSwitch = CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN '5' END
    INTO dbo.U_EF401COMXP_drvTbl_02D
	FROM dbo.U_EF401COMXP_Employees WITH (NOLOCK)
    WHERE Record01Change = 'Y' or audNewHire = 'Y' or  audReHire = 'Y';
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EF401COMXP_drvTbl_02E
    ---------------------------------
    IF OBJECT_ID('U_EF401COMXP_drvTbl_02E','U') IS NOT NULL
        DROP TABLE dbo.U_EF401COMXP_drvTbl_02E;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '2 ' + EepSSN + ' 02E'
        -- standard fields above and additional driver fields below
        ,drvPlanNumber = '91777'
        ,drvSSN = LEFT(eepSSN, 3) + '-' + RIGHT(LEFT(EepSSN, 5), 2) + '-' + RIGHT(RTRIM(EepSSN), 4)
        ,drvEmployeeNumber = EecEmpNo
    INTO dbo.U_EF401COMXP_drvTbl_02E
	FROM dbo.U_EF401COMXP_Employees WITH (NOLOCK)
    WHERE Record02EChange = 'Y'  or audNewHire = 'Y' or  audReHire = 'Y';
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EF401COMXP_drvTbl_03
    ---------------------------------
    IF OBJECT_ID('U_EF401COMXP_drvTbl_03','U') IS NOT NULL
        DROP TABLE dbo.U_EF401COMXP_drvTbl_03;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '2 ' + EepSSN + ' 03'
        -- standard fields above and additional driver fields below
        ,drvPlanNumber = '91777'
        ,drvSSN = LEFT(eepSSN, 3) + '-' + RIGHT(LEFT(EepSSN, 5), 2) + '-' + RIGHT(RTRIM(EepSSN), 4)
        ,drvAddressLineNumber = LineNumber
        ,drvAddress = EepAddress
    INTO dbo.U_EF401COMXP_drvTbl_03
	FROM (
        -- Address Line 1
        SELECT xEEID, xCOID, EepSSN, EepAddressLine1 AS EepAddress, '01' AS LineNumber, Record03Change, audNewHire,audReHire FROM dbo.U_EF401COMXP_Employees

        UNION ALL

        -- Address Line 2
        SELECT xEEID, xCOID, EepSSN, EepAddressLine2 AS EepAddress, '02' AS LineNumber, Record03Change, audNewHire,audReHire FROM dbo.U_EF401COMXP_Employees

        UNION ALL

        -- Address Line 3
        SELECT xEEID, xCOID, EepSSN, EepAddressLine3 AS EepAddress, '03' AS LineNumber, Record03Change, audNewHire,audReHire  FROM dbo.U_EF401COMXP_Employees
    ) Employee
    WHERE Record03Change = 'Y'  or audNewHire = 'Y' or  audReHire = 'Y';    
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EF401COMXP_drvTbl_04
    ---------------------------------
    IF OBJECT_ID('U_EF401COMXP_drvTbl_04','U') IS NOT NULL
        DROP TABLE dbo.U_EF401COMXP_drvTbl_04;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '2 ' + EepSSN + ' 04'
        -- standard fields above and additional driver fields below
        ,drvPlanNumber = '91777'
        ,drvSSN = LEFT(eepSSN, 3) + '-' + RIGHT(LEFT(EepSSN, 5), 2) + '-' + RIGHT(RTRIM(EepSSN), 4)
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = LEFT(EepAddressZipCode,5)
        ,drvAddressZipPlus4 = SUBSTRING(EepAddressZipCode,6,4)
    INTO dbo.U_EF401COMXP_drvTbl_04
	FROM dbo.U_EF401COMXP_Employees WITH (NOLOCK)
    WHERE Record04Change = 'Y'  or audNewHire = 'Y' or  audReHire = 'Y';
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EF401COMXP_drvTbl_11
    ---------------------------------
    IF OBJECT_ID('U_EF401COMXP_drvTbl_11','U') IS NOT NULL
        DROP TABLE dbo.U_EF401COMXP_drvTbl_11;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '2 ' + EepSSN + ' 11'
        -- standard fields above and additional driver fields below
        ,drvPlanNumber = '91777'
        ,drvSSN = LEFT(eepSSN, 3) + '-' + RIGHT(LEFT(EepSSN, 5), 2) + '-' + RIGHT(RTRIM(EepSSN), 4)
        ,drvStatusCode =	CASE WHEN EecEmplStatus = 'A' AND (SELECT TOP 1 EshEmplStatus FROM dbo.EmpHStat WHERE EshEEID = xEEID order by EshDateTimeChanged DESC) = 'L' THEN 'A'
								WHEN EecDateOfOriginalHire  <> EecDateOfLastHire THEN 'E'
								WHEN EecEmplStatus = 'L' THEN 'L'
								WHEN audNewHire = 'Y' THEN 'N'
								WHEN EepIsDisabled = 'T' THEN 'P'
								WHEN EecEmplStatus = 'L' and EecLeaveReason = '300' THEN 'W' 
								WHEN EecEmplStatus = 'T' and EecTermReason IN ('202') THEN 'R'
								WHEN EecEmplStatus = 'T' and EecTermReason not in ('202','203') THEN 'T'								
							END
        ,drvStatusDateChange =	CASE WHEN EecEmplStatus = 'A' AND (SELECT TOP 1 EshEmplStatus FROM dbo.EmpHStat WHERE EshEEID = xEEID order by EshDateTimeChanged DESC) = 'L' THEN (SELECT TOP 1 EshStatusStopDate FROM dbo.EmpHStat WITH (NOLOCK) WHERE EshEEID = xEEID ORDER BY EshDateTimeChanged DESC)
									WHEN EecDateOfOriginalHire  <> EecDateOfLastHire THEN EecDateOfLastHire
									WHEN EecEmplStatus = 'L' THEN EecEmplStatusStartDate
									WHEN audNewHire = 'Y' THEN EecDateOfOriginalHire
									WHEN EepIsDisabled = 'T' THEN audDateTime
									WHEN EecEmplStatus = 'L' and EecLeaveReason = '300' THEN EecEmplStatusStartDate 
									WHEN EecEmplStatus = 'T' and EecTermReason IN ('202') THEN EecDateOfTermination
									WHEN EecEmplStatus = 'T' and EecTermReason not in ('202','203') THEN EecDateOfTermination					
								END
    INTO dbo.U_EF401COMXP_drvTbl_11
	FROM dbo.U_EF401COMXP_Employees WITH (NOLOCK)
	LEFT JOIN dbo.U_EF401COMXP_D_Audit WITH (NOLOCK)
		ON xEEID = audEEID
    WHERE Record11Change = 'Y' or audNewHire = 'Y' or  audReHire = 'Y';
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EF401COMXP_drvTbl_60
    ---------------------------------
    IF OBJECT_ID('U_EF401COMXP_drvTbl_60','U') IS NOT NULL
        DROP TABLE dbo.U_EF401COMXP_drvTbl_60;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '2 ' + EepSSN + ' 60'
        -- standard fields above and additional driver fields below
        ,drvPlanNumber = '91777'
        ,drvSSN = LEFT(eepSSN, 3) + '-' + RIGHT(LEFT(EepSSN, 5), 2) + '-' + RIGHT(RTRIM(EepSSN), 4)
        ,drvParticipantClass = CASE WHEN EecFullTimeOrPartTime IN ('F','P') THEN EecFullTimeOrPartTime END
        ,drvParticipantPmtFreq =	CASE WHEN PgrPayFrequency = 'S' THEN '2'
										WHEN PgrPayFrequency = 'B' THEN 'B'
									END
    INTO dbo.U_EF401COMXP_drvTbl_60
	FROM dbo.U_EF401COMXP_Employees WITH (NOLOCK)
	JOIN dbo.PayGroup WITH (NOLOCK)
        ON PgrPayGroup = EecPayGroup
	WHERE Record60Change = 'Y' or audNewHire = 'Y' or  audReHire = 'Y'
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EF401COMXP_drvTbl_61
    ---------------------------------
    IF OBJECT_ID('U_EF401COMXP_drvTbl_61','U') IS NOT NULL
        DROP TABLE dbo.U_EF401COMXP_drvTbl_61;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '2 ' + EepSSN + ' 61'
        -- standard fields above and additional driver fields below
        ,drvPlanNumber = '91777'
        ,drvSSN = LEFT(eepSSN, 3) + '-' + RIGHT(LEFT(EepSSN, 5), 2) + '-' + RIGHT(RTRIM(EepSSN), 4)
        ,drvAdjustedDateOfHire = CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN EecDateOfLastHire END
    INTO dbo.U_EF401COMXP_drvTbl_61
	FROM dbo.U_EF401COMXP_Employees WITH (NOLOCK)
	WHERE audReHire = 'Y'
    ;

    ---------------------------------
    -- DETAIL RECORD - U_EF401COMXP_drvTbl_EA
    ---------------------------------
    IF OBJECT_ID('U_EF401COMXP_drvTbl_EA','U') IS NOT NULL
        DROP TABLE dbo.U_EF401COMXP_drvTbl_EA;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '2 ' + EepSSN + ' EA'
        -- standard fields above and additional driver fields below
        ,drvPlanNumber = '91777'
        ,drvSSN = LEFT(eepSSN, 3) + '-' + RIGHT(LEFT(EepSSN, 5), 2) + '-' + RIGHT(RTRIM(EepSSN), 4)
        ,drvEmailSeqNumber = LineNumber
        ,drvAddressEmail = EepAddressEmail
    INTO dbo.U_EF401COMXP_drvTbl_EA
	FROM ( -- Email 1
        SELECT xEEID, xCOID, EepSSN, SUBSTRING(EepAddressEmail, 1, 35) AS EepAddressEmail, '1' AS LineNumber, emailAddress, audNewHire,audReHire FROM dbo.U_EF401COMXP_Employees
        UNION ALL
        -- Email 2
        SELECT xEEID, xCOID, EepSSN, SUBSTRING(EepAddressEmail, 36, 35) AS EepAddressEmail, '2' AS LineNumber, emailAddress, audNewHire,audReHire FROM dbo.U_EF401COMXP_Employees WHERE LEN(RTRIM(EepAddressEmail)) > 35
        --UNION ALL
        ---- Email 3
        --SELECT xEEID, xCOID, EepSSN, SUBSTRING(EepAddressEmail, 71, 88)  AS EepAddressEmail, '3' AS LineNumber, emailAddress, audNewHire,audReHire  FROM dbo.U_EF401COMXP_Employees
        )
        Employee
    WHERE emailAddress = 'Y'  or audNewHire = 'Y' or  audReHire = 'Y';
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EF401COMXP_drvTbl_19
    ---------------------------------
    IF OBJECT_ID('U_EF401COMXP_drvTbl_19','U') IS NOT NULL
        DROP TABLE dbo.U_EF401COMXP_drvTbl_19;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '2 ' + EepSSN + ' 19'
        -- standard fields above and additional driver fields below
        ,drvPlanNumber = '91777'
        ,drvSSN = LEFT(eepSSN, 3) + '-' + RIGHT(LEFT(EepSSN, 5), 2) + '-' + RIGHT(RTRIM(EepSSN), 4)
        ,drvSource = PdhSource
        ,drvAmount = CONVERT(VARCHAR(13), 
						CASE WHEN PdhSource = '03' THEN 
							CASE WHEN PdhERAmt <> 0.00 THEN PdhERAmt END
							ELSE CASE WHEN PdhEEAmt <> 0.00 THEN PdhEEAmt END
						END)
    INTO dbo.U_EF401COMXP_drvTbl_19
	FROM dbo.U_EF401COMXP_PDedHist WITH (NOLOCK)
    LEFT JOIN (
				SELECT xEEID,xCOID  
				FROM dbo.U_EF401COMXP_Employees WITH (NOLOCK)
				WHERE   audNewHire = 'Y' or  audReHire = 'Y') HIRE_REHIRE
		ON HIRE_REHIRE.xEEID = PdhEEID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = PdhEEID
	;

	UPDATE U_EF401COMXP_drvTbl_19 SET drvAmount = CONVERT(VARCHAR,dbo.dsi_fnPadZero((CAST(drvAmount AS MONEY))*100,13,0)) 
        
    UPDATE U_EF401COMXP_drvTbl_19 set drvAmount = CONCAT(LEFT(REPLACE(drvAmount,'.',''),(LEN( REPLACE(drvAmount,'.','')) -1)),CASE WHEN RIGHT(drvAmount,1) = '1' THEN 'A'
         WHEN RIGHT(drvAmount,1) = '2' THEN 'B'
         WHEN RIGHT(drvAmount,1) = '3' THEN 'C'
         WHEN RIGHT(drvAmount,1) = '4' THEN 'D'
         WHEN RIGHT(drvAmount,1) = '5' THEN 'E'
         WHEN RIGHT(drvAmount,1) = '6' THEN 'F'
         WHEN RIGHT(drvAmount,1) = '7' THEN 'G'
         WHEN RIGHT(drvAmount,1) = '8' THEN 'H'
         WHEN RIGHT(drvAmount,1) = '9' THEN 'I'
         WHEN RIGHT(drvAmount,1) = '0' THEN '{'
    END)
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EF401COMXP_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EF401COMXP_Header;
    SELECT DISTINCT
         drvTestFileIndentifier = CASE WHEN @ExportCode LIKE '%TEST%' THEN 'TESTEDT' END
    INTO dbo.U_EF401COMXP_Header
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
ALTER VIEW dbo.dsi_vwEF401COMXP_Export AS
    SELECT TOP 20000000 Data,* FROM dbo.U_EF401COMXP_File (NOLOCK)
    ORDER BY  InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EF401COMXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201601181'
       ,expStartPerControl     = '201601181'
       ,expLastEndPerControl   = '202105259'
       ,expEndPerControl       = '202105259'
WHERE expFormatCode = 'EF401COMXP';

**********************************************************************************/