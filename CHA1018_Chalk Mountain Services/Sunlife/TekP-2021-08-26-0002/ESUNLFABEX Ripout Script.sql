SET NOCOUNT ON;
IF OBJECT_ID('U_ESUNLFABEX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ESUNLFABEX_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ESUNLFABEX_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ESUNLFABEX' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwESUNLFABEX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwESUNLFABEX_Export];
GO
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ESUNLFABEX';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ESUNLFABEX';
IF OBJECT_ID('dsi_sp_BuildDriverTables_ESUNLFABEX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESUNLFABEX];
GO
IF OBJECT_ID('U_ESUNLFABEX_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ESUNLFABEX_PEarHist];
GO
IF OBJECT_ID('U_ESUNLFABEX_File') IS NOT NULL DROP TABLE [dbo].[U_ESUNLFABEX_File];
GO
IF OBJECT_ID('U_ESUNLFABEX_EEList') IS NOT NULL DROP TABLE [dbo].[U_ESUNLFABEX_EEList];
GO
IF OBJECT_ID('U_ESUNLFABEX_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ESUNLFABEX_drvTbl];
GO
IF OBJECT_ID('U_ESUNLFABEX_DedList') IS NOT NULL DROP TABLE [dbo].[U_ESUNLFABEX_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_ESUNLFABEX') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ESUNLFABEX];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ESUNLFABEX';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ESUNLFABEX';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ESUNLFABEX';
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'ESUNLFABEX_20211101.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','202110049','EMPEXPORT','OEACTIVE','Oct  5 2021  5:29AM','ESUNLFABEX',NULL,NULL,NULL,'202110049','Oct  4 2021 12:50PM','Oct  4 2021 12:50PM','202110041','675','','','202110041',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Passive Open Enrollment Export','202110049','EMPEXPORT','OEPASSIVE','Oct  5 2021  5:29AM','ESUNLFABEX',NULL,NULL,NULL,'202110049','Oct  4 2021 12:50PM','Oct  4 2021 12:50PM','202110041','675','','','202110041',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Sunlife Abesnce Export','202110049','EMPEXPORT','ONDEM_XOE','Oct  5 2021  5:30AM','ESUNLFABEX',NULL,NULL,NULL,'202110049','Oct  4 2021 12:50PM','Oct  4 2021 12:50PM','202110041','675','','','202110041',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Sunlife Abesnce Export-Sched','202110049','EMPEXPORT','SCH_ESUNLF','Oct  5 2021  5:30AM','ESUNLFABEX',NULL,NULL,NULL,'202110049','Oct  4 2021 12:50PM','Oct  4 2021 12:50PM','202110041','675','','','202110041',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Sunlife Abesnce Export-Test','202110111','EMPEXPORT','TEST_XOE','Oct 22 2021 11:46AM','ESUNLFABEX',NULL,NULL,NULL,'202110111','Oct 11 2021 12:00AM','Dec 30 1899 12:00AM','202110111','689','','','202110111',dbo.fn_GetTimedKey(),NULL,'us3rVaCHA1018',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESUNLFABEX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESUNLFABEX','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESUNLFABEX','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESUNLFABEX','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESUNLFABEX','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'ESUNLFABEX' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'ESUNLFABEX' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_ESUNLFABEX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ESUNLFABEX_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLFABEX','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLFABEX','D10','dbo.U_ESUNLFABEX_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_ESUNLFABEX') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ESUNLFABEX] (
    [BdmRecType] varchar(3) NOT NULL,
    [BdmCOID] char(5) NULL,
    [BdmEEID] char(12) NOT NULL,
    [BdmDepRecID] char(12) NULL,
    [BdmSystemID] char(12) NULL,
    [BdmRunID] varchar(32) NULL,
    [BdmDedRowStatus] varchar(256) NULL,
    [BdmRelationship] char(3) NULL,
    [BdmDateOfBirth] datetime NULL,
    [BdmDedCode] char(5) NULL,
    [BdmDedType] varchar(32) NULL,
    [BdmBenOption] char(6) NULL,
    [BdmBenStatus] char(1) NULL,
    [BdmBenStartDate] datetime NULL,
    [BdmBenStopDate] datetime NULL,
    [BdmBenStatusDate] datetime NULL,
    [BdmBenOptionDate] datetime NULL,
    [BdmChangeReason] char(6) NULL,
    [BdmStartDate] datetime NULL,
    [BdmStopDate] datetime NULL,
    [BdmIsCobraCovered] char(1) NULL,
    [BdmCobraReason] char(6) NULL,
    [BdmDateOfCOBRAEvent] datetime NULL,
    [BdmIsPQB] char(1) NULL,
    [BdmIsChildOldest] char(1) NULL,
    [BdmUSGField1] varchar(256) NULL,
    [BdmUSGField2] varchar(256) NULL,
    [BdmUSGDate1] datetime NULL,
    [BdmUSGDate2] datetime NULL,
    [BdmTVStartDate] datetime NULL,
    [BdmSessionID] varchar(32) NULL,
    [BdmEEAmt] money NULL,
    [BdmEECalcRateOrPct] decimal NULL,
    [BdmEEGoalAmt] money NULL,
    [BdmEEMemberOrCaseNo] char(40) NULL,
    [BdmERAmt] money NULL,
    [BdmNumSpouses] int NULL,
    [BdmNumChildren] int NULL,
    [BdmNumDomPartners] int NULL,
    [BdmNumDPChildren] int NULL
);
IF OBJECT_ID('U_ESUNLFABEX_DedList') IS NULL
CREATE TABLE [dbo].[U_ESUNLFABEX_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ESUNLFABEX_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ESUNLFABEX_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvEmployeeId] char(9) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvGender] char(1) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvPhoneNumberHome] varchar(50) NULL,
    [drvAddressEmail] varchar(50) NULL,
    [drvEmployeeWorkState] varchar(255) NULL,
    [drvEmployeeDateOfOriginalHire] datetime NULL,
    [drvEmployeeDateOfRecentHire] datetime NULL,
    [drvEmployeeAdjustedDateOfHire] datetime NULL,
    [drvEmployeeJobTitle] varchar(25) NOT NULL,
    [drvEmploymentStatus] char(1) NULL,
    [drvFullTimePartTimeStatus] char(1) NULL,
    [drvCompensationMethod] char(1) NULL,
    [drvScheduledHoursPerWeek] varchar(2) NULL,
    [drvScheduledDaysPerWeek] varchar(1) NOT NULL,
    [drvWorkSiteName] varchar(37) NOT NULL,
    [drvEmployeeEarning] nvarchar(4000) NULL,
    [drvEarningsEffecticeDate] datetime NOT NULL,
    [drvTerminationDate] datetime NULL,
    [drvSTDEligibilityDate] datetime NULL,
    [drvSTDTerminationDate] datetime NULL,
    [drvLTDEligibilityDate] datetime NULL,
    [drvLTDTerminationDate] datetime NULL,
    [drvHoursWorkedPrev12Mo] nvarchar(4000) NULL,
    [drvReportingField1] varchar(3) NULL
);
IF OBJECT_ID('U_ESUNLFABEX_EEList') IS NULL
CREATE TABLE [dbo].[U_ESUNLFABEX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ESUNLFABEX_File') IS NULL
CREATE TABLE [dbo].[U_ESUNLFABEX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(max) NULL
);
IF OBJECT_ID('U_ESUNLFABEX_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ESUNLFABEX_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PehCurAmt] numeric NULL,
    [PehCurHrs] decimal NULL,
    [PehCurAmtYTD] money NULL,
    [PehCurHrsYTD] decimal NULL,
    [PehRolling12Mo] numeric NULL,
    [PehRolling12MoHrs] decimal NULL,
    [PehInclInDefComp] money NULL,
    [PehInclInDefCompHrs] decimal NULL,
    [PehInclInDefCompYTD] money NULL,
    [PehInclInDefCompHrsYTD] decimal NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESUNLFABEX]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Chalk Mountian Services of Texas

Created By: James Bender
Business Analyst: Richard Vars
Create Date: 10/04/2021
Service Request Number: TekP-2021-08-26-0002

Purpose: Sunlife Abesnce Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ESUNLFABEX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ESUNLFABEX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ESUNLFABEX';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ESUNLFABEX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ESUNLFABEX' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESUNLFABEX', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESUNLFABEX', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESUNLFABEX', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESUNLFABEX', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESUNLFABEX', 'SCH_ESUNLF';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ESUNLFABEX';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ESUNLFABEX', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ESUNLFABEX';

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
    DELETE FROM dbo.U_ESUNLFABEX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ESUNLFABEX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'ERSTD,STD,LTD';

    IF OBJECT_ID('U_ESUNLFABEX_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ESUNLFABEX_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ESUNLFABEX_DedList
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

    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_ESUNLFABEX_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ESUNLFABEX_PEarHist;
    SELECT DISTINCT
         PehEEID         
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
        ,PehRolling12Mo            = SUM(CASE WHEN PehEarnCode IN ('RK','RF','RLRDO','REG','RP','RSL') THEN PehCurAmt ELSE 0.00 END)
        ,PehRolling12MoHrs        =SUM(CASE WHEN ErnIsRegularPayCode = 'Y' THEN PehCurHrs ELSE 0.00 END)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_ESUNLFABEX_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    JOIN dbo.EarnCode WITH (NOLOCK)
        ON ErnEarnCode = PehEarnCode
    --WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    --AND PehPerControl <= @EndPerControl
    WHERE  PehPerControl >= FORMAT(DATEPART(YEAR,DATEADD(MONTH, -12, @EndDate)), '0000') + FORMAT(DATEPART(MONTH,@EndDate), '00') + FORMAT(DATEPART(DAY,@EndDate), '00') + '1'
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ESUNLFABEX_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ESUNLFABEX_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ESUNLFABEX_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvEmployeeId = EecEmpNo
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvNameLast = EepNameLast
        ,drvGender = CASE WHEN EepGender IN ('M','F') THEN EepGender END
        ,drvDateOfBirth = EepDateOfBirth
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvPhoneNumberHome = EepPhoneHomeNumber
        ,drvAddressEmail = EepAddressEMailAlternate
        ,drvEmployeeWorkState = LocAddressState
        ,drvEmployeeDateOfOriginalHire = EecDateOfOriginalHire
        ,drvEmployeeDateOfRecentHire = EecDateOfLastHire
        ,drvEmployeeAdjustedDateOfHire = EecDateOfSeniority
        ,drvEmployeeJobTitle = JbcDesc
        ,drvEmploymentStatus = EecEmplStatus
        ,drvFullTimePartTimeStatus = CASE WHEN EecFullTimeOrPartTime iN ('F','P') THEN EecFullTimeOrPartTime END
        ,drvCompensationMethod = EecSalaryOrHourly
        ,drvScheduledHoursPerWeek =    CASE WHEN EecJobCode IN ('LGCORD','CORDSND','SRLGCORD','YRDCORD','WELLSUPW') THEN '42'
                                        WHEN EecJobCode IN ('DRVSAND','DRVW','DRVYDMUL','TECH','TECHA','TRNDRVSD','TRNDRVWT','TIRETECH','LDTECHPM','SHOPSUP','CONMGR','SHIFTLD','SFTYSPEC') THEN '60'
                                    END
        ,drvScheduledDaysPerWeek = '5'
        ,drvWorkSiteName = 'Chalk Mountain Services Of Texas, LLC'
        ,drvEmployeeEarning = FORMAT(PehRolling12Mo, '#0.00')
        ,drvEarningsEffecticeDate = GETDATE()
        ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvSTDEligibilityDate = ERSTD_BenStartDate
        ,drvSTDTerminationDate = STD_BenStopDate
        ,drvLTDEligibilityDate = LTD_BenStartDate
        ,drvLTDTerminationDate = LTD_BenStopDate
        ,drvHoursWorkedPrev12Mo = FORMAT(PehRolling12MoHrs, '#0.00')
        ,drvReportingField1 = RIGHT(EecOrgLvl1, 3)
    INTO dbo.U_ESUNLFABEX_drvTbl
    FROM dbo.U_ESUNLFABEX_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    --JOIN dbo.U_dsi_BDM_ESUNLFABEX WITH (NOLOCK)
    LEFT JOIN (
                SELECT BdmEEID, BdmCOID
                    ,MAX(CASE WHEN BdmDedCode = 'ERSTD' THEN BdmBenStartDate END) AS ERSTD_BenStartDate
                    ,MAX(CASE WHEN BdmDedCode = 'STD' THEN BdmBenStopDate END) AS STD_BenStopDate
                    ,MAX(CASE WHEN BdmDedCode = 'LTD' THEN BdmBenStartDate END) AS LTD_BenStartDate
                    ,MAX(CASE WHEN BdmDedCode = 'LTD' THEN BdmBenStopDate END) AS LTD_BenStopDate
                FROM dbo.U_dsi_BDM_ESUNLFABEX WITH (NOLOCK)
                GROUP BY BdmEEID, BdmCOID) AS Bdm
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    LEFT JOIN dbo.U_ESUNLFABEX_PEarHist
        ON PehEEID = xEEID
    WHERE EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND DATEDIFF(DAY, EecDateOfTermination, @StartDate) <= 30)
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
ALTER VIEW dbo.dsi_vwESUNLFABEX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ESUNLFABEX_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ESUNLFABEX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202109271'
       ,expStartPerControl     = '202109271'
       ,expLastEndPerControl   = '202110049'
       ,expEndPerControl       = '202110049'
WHERE expFormatCode = 'ESUNLFABEX';

**********************************************************************************/
GO
CREATE   VIEW dbo.AscDefH
AS
SELECT CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdhAccrCodesUsed
           ELSE s.AdhAccrCodesUsed
       END AS AdhAccrCodesUsed,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdhAggregateAtLevel
           ELSE s.AdhAggregateAtLevel
       END AS AdhAggregateAtLevel,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdhAuditStaticFields
           ELSE s.AdhAuditStaticFields
       END AS AdhAuditStaticFields,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdhChildTable
           ELSE s.AdhChildTable
       END AS AdhChildTable,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdhClientTableList
           ELSE s.AdhClientTableList
       END AS AdhClientTableList,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdhCustomDLLFileName
           ELSE s.AdhCustomDLLFileName
       END AS AdhCustomDLLFileName,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdhDedCodesUsed
           ELSE s.AdhDedCodesUsed
       END AS AdhDedCodesUsed,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdhDelimiter
           ELSE s.AdhDelimiter
       END AS AdhDelimiter,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdhEarnCodesUsed
           ELSE s.AdhEarnCodesUsed
       END AS AdhEarnCodesUsed,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdhEEIdentifier
           ELSE s.AdhEEIdentifier
       END AS AdhEEIdentifier,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdhEndOfRecord
           ELSE s.AdhEndOfRecord
       END AS AdhEndOfRecord,
       ISNULL(i.AdhEngine, s.AdhEngine) AS AdhEngine,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdhFileFormat
           ELSE s.AdhFileFormat
       END AS AdhFileFormat,
       ISNULL(i.AdhFormatCode, s.AdhFormatCode) AS AdhFormatCode,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdhFormatName
           ELSE s.AdhFormatName
       END AS AdhFormatName,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdhFundCodesUsed
           ELSE s.AdhFundCodesUsed
       END AS AdhFundCodesUsed,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdhImportExport
           ELSE s.AdhImportExport
       END AS AdhImportExport,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdhInputFormName
           ELSE s.AdhInputFormName
       END AS AdhInputFormName,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdhIsAuditFormat
           ELSE s.AdhIsAuditFormat
       END AS AdhIsAuditFormat,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdhIsSQLExport
           ELSE s.AdhIsSQLExport
       END AS AdhIsSQLExport,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdhModifyStamp
           ELSE s.AdhModifyStamp
       END AS AdhModifyStamp,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdhOutputMediaType
           ELSE s.AdhOutputMediaType
       END AS AdhOutputMediaType,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdhRecordSize
           ELSE s.AdhRecordSize
       END AS AdhRecordSize,
       CASE WHEN i.AuditKey IS NOT NULL THEN i.AdhSortBy ELSE s.AdhSortBy END AS AdhSortBy,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdhSysFormat
           ELSE s.AdhSysFormat
       END AS AdhSysFormat,
       CASE WHEN i.AuditKey IS NOT NULL THEN i.AdhSystemID ELSE s.AdhSystemID END AS AdhSystemID,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdhTaxCodesUsed
           ELSE s.AdhTaxCodesUsed
       END AS AdhTaxCodesUsed,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdhWizardInfo
           ELSE s.AdhWizardInfo
       END AS AdhWizardInfo,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdhYearStartFixedDate
           ELSE s.AdhYearStartFixedDate
       END AS AdhYearStartFixedDate,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdhYearStartOption
           ELSE s.AdhYearStartOption
       END AS AdhYearStartOption,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdhPreProcessSQL
           ELSE s.AdhPreProcessSQL
       END AS AdhPreProcessSQL,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdhRespectZeroPayRate
           ELSE s.AdhRespectZeroPayRate
       END AS AdhRespectZeroPayRate,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdhCreateTClockBatches
           ELSE s.AdhCreateTClockBatches
       END AS AdhCreateTClockBatches,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdhThirdPartyPay
           ELSE s.AdhThirdPartyPay
       END AS AdhThirdPartyPay,
       ISNULL(i.AuditKey, s.AuditKey) AS AuditKey
FROM dbo.iAscDefH i WITH (NOLOCK)
    FULL MERGE JOIN ULTIPRO_SYSTEM.dbo.AscMastH s WITH (NOLOCK) ON i.AdhEngine = s.AdhEngine
                                                                   AND i.AdhFormatCode = s.AdhFormatCode;
GO
CREATE   VIEW dbo.AscDefF
AS
SELECT CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdfFieldNumber
           ELSE s.AdfFieldNumber
       END AS AdfFieldNumber,
       ISNULL(i.AdfHeaderSystemID, s.AdfHeaderSystemID) AS AdfHeaderSystemID,
       CASE WHEN i.AuditKey IS NOT NULL THEN i.AdfLen ELSE s.AdfLen END AS AdfLen,
       ISNULL(i.AdfRecType, s.AdfRecType) AS AdfRecType,
       ISNULL(i.AdfSetNumber, s.AdfSetNumber) AS AdfSetNumber,
       CASE WHEN i.AuditKey IS NOT NULL THEN i.AdfStartPos ELSE s.AdfStartPos END AS AdfStartPos,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdfTableName
           ELSE s.AdfTableName
       END AS AdfTableName,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdfTargetField
           ELSE s.AdfTargetField
       END AS AdfTargetField,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdfVariableName
           ELSE s.AdfVariableName
       END AS AdfVariableName,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdfVariableType
           ELSE s.AdfVariableType
       END AS AdfVariableType,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdfExpression
           ELSE s.AdfExpression
       END AS AdfExpression,
       CASE WHEN i.AuditKey IS NOT NULL THEN i.AdfForCond ELSE s.AdfForCond END AS AdfForCond,
       ISNULL(i.AuditKey, s.AuditKey) AS AuditKey
FROM dbo.iAscDefF i WITH (NOLOCK)
    FULL MERGE JOIN ULTIPRO_SYSTEM.dbo.AscMastF s WITH (NOLOCK) ON i.AdfHeaderSystemID = s.AdfHeaderSystemID
                                                                   AND i.AdfRecType = s.AdfRecType
                                                                   AND i.AdfSetNumber = s.AdfSetNumber
                                                                   AND i.AdfFieldNumber = s.AdfFieldNumber;
GO
CREATE VIEW dbo.dsi_vwESUNLFABEX_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ESUNLFABEX_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort