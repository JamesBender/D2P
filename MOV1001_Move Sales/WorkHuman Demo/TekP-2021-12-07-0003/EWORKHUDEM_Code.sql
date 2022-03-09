--Populate iascDefF for EWORKHUDEM
--For your reference, the adhSystemID is EWORKHUDEMZ0
--Loaded iascDefF Successfully

IF OBJECT_ID('dsi_sp_BuildDriverTables_EWORKHUDEM') IS NOT NULL
    DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EWORKHUDEM];
GO

CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EWORKHUDEM]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Move Sales, Inc.

Created By: Andy Pineda
Business Analyst: Cheryl Petitti
Create Date: 03/04/2022
Service Request Number: TekP-2021-12-07-0003

Purpose: Work Human Demo Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EWORKHUDEM';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EWORKHUDEM';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EWORKHUDEM';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EWORKHUDEM';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EWORKHUDEM' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EWORKHUDEM', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EWORKHUDEM', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EWORKHUDEM', 'SCH_EWORKH';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EWORKHUDEM';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EWORKHUDEM', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EWORKHUDEM';

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
    DELETE FROM dbo.U_EWORKHUDEM_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EWORKHUDEM_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    -- DECLARE @DedList VARCHAR(MAX)
    -- SET @DedList = 'DED1,DED2';

    -- IF OBJECT_ID('U_EWORKHUDEM_DedList','U') IS NOT NULL
    --     DROP TABLE dbo.U_EWORKHUDEM_DedList;
    -- SELECT DISTINCT
    --      DedCode = DedDedCode
    --     ,DedType = DedDedType
    -- INTO dbo.U_EWORKHUDEM_DedList
    -- FROM dbo.fn_ListToTable(@DedList)
    -- JOIN dbo.DedCode WITH (NOLOCK)
    --     ON DedDedCode = Item;


    -- --==========================================
    -- -- BDM Section
    -- --==========================================
    -- DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- -- Required parameters
    -- INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','MED,DEN,VIS');
    -- INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    -- INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    -- INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

    -- -- Non-Required parameters
    -- INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    -- INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CalcBenOptionDate','2');
    -- -- Run BDM Module
    -- EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    -- --==========================================
    -- -- Build Working Tables
    -- --==========================================

    -- -----------------------------
    -- -- Working Table - PDedHist
    -- -----------------------------
    -- IF OBJECT_ID('U_EWORKHUDEM_PDedHist','U') IS NOT NULL
    --     DROP TABLE dbo.U_EWORKHUDEM_PDedHist;
    -- SELECT DISTINCT
    --      PdhEEID
    --     -- Current Payroll Amounts
    --     ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
    --     ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
    --     -- YTD Payroll Amounts
    --     ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
    --     ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
    --     -- Categorize Payroll Amounts
    --     ,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('401K') THEN PdhEECurAmt ELSE 0.00 END)
    --     ,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('ROTH') THEN PdhEECurAmt ELSE 0.00 END)
    --     ,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('MATCH') THEN PdhERCurAmt ELSE 0.00 END)        
    --     ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('401CU') THEN PdhEECurAmt ELSE 0.00 END)
    --     ,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
    --     ,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('401KL1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --     ,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('401KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --     ,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --     ,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --     ,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    -- INTO dbo.U_EWORKHUDEM_PDedHist
    -- FROM dbo.PDedHist WITH (NOLOCK)
    -- JOIN dbo.U_EWORKHUDEM_DedList WITH (NOLOCK)
    --     ON DedCode = PdhDedCode
    -- WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    -- AND PdhPerControl <= @EndPerControl
    -- AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    -- GROUP BY PdhEEID
    -- HAVING (SUM(PdhEECurAmt) <> 0.00
    --     OR SUM(PdhERCurAmt) <> 0.00
    -- );


    -- -----------------------------
    -- -- Working Table - PEarHist
    -- -----------------------------
    -- IF OBJECT_ID('U_EWORKHUDEM_PEarHist','U') IS NOT NULL
    --     DROP TABLE dbo.U_EWORKHUDEM_PEarHist;
    -- SELECT DISTINCT
    --      PehEEID
    --     ,PrgPayDate             = MAX(PrgPayDate)
    --     -- Current Payroll Amount/Hours
    --     ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
    --     ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
    --     -- YTD Payroll Amount/Hours
    --     ,PehCurAmtYTD           = SUM(PehCurAmt)
    --     ,PehCurHrsYTD           = SUM(PehCurHrs)
    --     -- Current Include Deferred Comp Amount/Hours
    --     ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
    --     ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
    --     -- YTD Include Deferred Comp Amount/Hours
    --     ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
    --     ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    -- INTO dbo.U_EWORKHUDEM_PEarHist
    -- FROM dbo.vw_int_PayReg WITH (NOLOCK)
    -- JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
    --     ON PehGenNumber = PrgGenNumber
    -- WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    -- AND PehPerControl <= @EndPerControl
    -- GROUP BY PehEEID
    -- HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EWORKHUDEM_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EWORKHUDEM_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EWORKHUDEM_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvUniqueId = Ec.EecEmpNo
        ,drvLoginId = pers.EepAddressEmail
        ,drvFName = CASE WHEN pers.EepNamePreferred IS NOT NULL THEN pers.EepNamePreferred
                        ELSE pers.EepNameFirst END
        ,drvLName = pers.EepNameLast
        ,drvEmail = pers.EepAddressEMail
        ,drvFunc = O1.OrgDesc
        ,drvCountry = LEFT(pers.EepAddressCountry, 2) -- Cheryl follow up
        ,drvHireDt = Ec.EecDateOfSeniority
        ,drvManagerId = EC2.EecEmpNo
        ,drvAdmin = CASE Ec.EecEmpNo
                        WHEN '000116305' THEN 'Y'
                        WHEN '000604401' THEN 'Y'
                        WHEN '000606065' THEN 'Y'
                        WHEN '000606453' THEN 'Y'
                        WHEN '000608195' THEN 'Y'
                        WHEN '000604437' THEN 'Y'
                    END
        ,drvCostCent = CONCAT(O1.OrgCode, O2.OrgCode)
        ,drvLocCode = LocDesc
        ,drvJobLvl = je.JbcUDField2
        ,drvEmpType = '' -- update on server
        ,drvAlternateTitle = Ec.EecJobTitle
        ,drvApp2 = CASE WHEN je2.JbcUDField2 IN ('M4', 'M5', 'M6', 'M7', 'M8', 'M9') THEN  ''
                        ELSE Ec3.EecEmpNo END
        ,drvApp3 = CASE WHEN je2.JbcUDField2 IN ('M5', 'M6', 'M7', 'M8', 'M9') THEN  ''
                        ELSE Ec3.EecEmpNo END
        ,drvRevOrgPart = CASE WHEN Ec.EecCOID IN ('OG4IV', 'NR767') AND Ec.EecOrgLvl3 IN ('CONEXP', 'OPERAT', 'SALES') THEN 'Y' ELSE '' END
        ,drvRevOrgNom = CASE WHEN Ec.EecCOID IN ('OG4IV', 'NR767') AND Ec.EecOrgLvl3 IN ('CONEXP', 'OPERAT', 'SALES') OR je.JbcUDField2 IN 
                            ('M4', 'M5', 'M6', 'M7') THEN 'Y' ELSE '' END
    INTO dbo.U_EWORKHUDEM_drvTbl
    FROM dbo.U_EWORKHUDEM_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers pers WITH (NOLOCK)
        ON pers.EepEEID = xEEID
    JOIN dbo.EmpComp Ec WITH(NOLOCK)
        ON Ec.EecEEID = xEEID
	JOIN dbo.Location WITH(NOLOCK)
		ON LocCode = EecLocation
    JOIN dbo.JobCode je WITH (NOLOCK)
        ON je.JbcJobCode = Ec.EecJobCode
    JOIN dbo.OrgLevel O3 WITH(NOLOCK)
        ON O3.OrgCode = Ec.EecOrgLvl3
    LEFT JOIN dbo.OrgLevel O1 WITH(NOLOCK)
        ON O1.OrgCode = Ec.EecOrgLvl1
    LEFT JOIN dbo.OrgLevel O2 WITH(NOLOCK)
        ON O2.OrgCode = Ec.EecOrgLvl2
    LEFT JOIN dbo.EmpComp EC2 WITH (NOLOCK) -- supervisor  
        ON EC2.EecEEID = Ec.EecSupervisorID  
    AND Ec2.EecCOID = Ec.EecCOID  
        --AND SUP.EecEmplStatus <> 'T' 
    LEFT JOIN dbo.EmpPers pers2 WITH(NOLOCK)
        ON Ec2.EecEEID = pers2.EepEEID
    LEFT JOIN dbo.JobCode je2 -- test
        ON je2.JbcJobCode = Ec2.EecJobCode
    LEFT JOIN dbo.EmpComp EC3 WITH (NOLOCK) -- supervisor  
        ON EC3.EecEEID = Ec2.EecSupervisorID  
    AND Ec3.EecCOID = Ec2.EecCOID  
        --AND SUP.EecEmplStatus <> 'T' 
    LEFT JOIN dbo.EmpPers pers3 WITH(NOLOCK)
        ON Ec3.EecEEID = pers3.EepEEID
    LEFT JOIN dbo.JobCode je3 -- test
        ON je3.JbcJobCode = Ec3.EecJobCode
    -- JOIN dbo.U_dsi_BDM_EWORKHUDEM WITH (NOLOCK)
    --     ON BdmEEID = xEEID 
    --     AND BdmCoID = xCoID
    WHERE Ec.EecEEType <> 'CON'
    AND LocCode <> 'OFFSH' 
    AND Ec.EecEmplStatus <> 'T'
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
ALTER VIEW dbo.dsi_vwEWORKHUDEM_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EWORKHUDEM_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EWORKHUDEM%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202202251'
       ,expStartPerControl     = '202202251'
       ,expLastEndPerControl   = '202203049'
       ,expEndPerControl       = '202203049'
WHERE expFormatCode = 'EWORKHUDEM';

**********************************************************************************/
