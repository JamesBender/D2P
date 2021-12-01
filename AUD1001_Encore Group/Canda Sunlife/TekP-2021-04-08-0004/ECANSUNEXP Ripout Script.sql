SET NOCOUNT ON;
IF OBJECT_ID('U_ECANSUNEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECANSUNEXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ECANSUNEXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ECANSUNEXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwECANSUNEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECANSUNEXP_Export];
GO
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ECANSUNEXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ECANSUNEXP';
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECANSUNEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECANSUNEXP];
GO
IF OBJECT_ID('U_ECANSUNEXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ECANSUNEXP_PEarHist];
GO
IF OBJECT_ID('U_ECANSUNEXP_Loader') IS NOT NULL DROP TABLE [dbo].[U_ECANSUNEXP_Loader];
GO
IF OBJECT_ID('U_ECANSUNEXP_File') IS NOT NULL DROP TABLE [dbo].[U_ECANSUNEXP_File];
GO
IF OBJECT_ID('U_ECANSUNEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECANSUNEXP_EEList];
GO
IF OBJECT_ID('U_ECANSUNEXP_drvTbl_Salary') IS NOT NULL DROP TABLE [dbo].[U_ECANSUNEXP_drvTbl_Salary];
GO
IF OBJECT_ID('U_ECANSUNEXP_drvTbl_PersonLink') IS NOT NULL DROP TABLE [dbo].[U_ECANSUNEXP_drvTbl_PersonLink];
GO
IF OBJECT_ID('U_ECANSUNEXP_drvTbl_Person') IS NOT NULL DROP TABLE [dbo].[U_ECANSUNEXP_drvTbl_Person];
GO
IF OBJECT_ID('U_ECANSUNEXP_drvTbl_Member') IS NOT NULL DROP TABLE [dbo].[U_ECANSUNEXP_drvTbl_Member];
GO
IF OBJECT_ID('U_ECANSUNEXP_drvTbl_Benefits') IS NOT NULL DROP TABLE [dbo].[U_ECANSUNEXP_drvTbl_Benefits];
GO
IF OBJECT_ID('U_ECANSUNEXP_drvTbl_Address') IS NOT NULL DROP TABLE [dbo].[U_ECANSUNEXP_drvTbl_Address];
GO
IF OBJECT_ID('U_ECANSUNEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_ECANSUNEXP_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_ECANSUNEXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ECANSUNEXP];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ECANSUNEXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ECANSUNEXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ECANSUNEXP';
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'ECANSUNEXP_20211129.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202111299','EMPEXPORT','OEACTIVE',NULL,'ECANSUNEXP',NULL,NULL,NULL,'202111299','Aug  5 2021 11:14AM','Aug  5 2021 11:14AM','202110011',NULL,'','','202110011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202111299','EMPEXPORT','OEPASSIVE',NULL,'ECANSUNEXP',NULL,NULL,NULL,'202111299','Aug  5 2021 11:14AM','Aug  5 2021 11:14AM','202110011',NULL,'','','202110011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Canada Sunlife XML Export','202111299','EMPEXPORT','ONDEM_XOE',NULL,'ECANSUNEXP',NULL,NULL,NULL,'202111299','Aug  5 2021 11:14AM','Aug  5 2021 11:14AM','202110011',NULL,'','','202110011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Canada Sunlife XML Expor-Sched','202111299','EMPEXPORT','SCH_ECANSU',NULL,'ECANSUNEXP',NULL,NULL,NULL,'202111299','Aug  5 2021 11:14AM','Aug  5 2021 11:14AM','202110011',NULL,'','','202110011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','',NULL,NULL,NULL,NULL,'Canada Sunlife XML Expor-Test','202111299','EMPEXPORT','TEST_XOE','Oct 28 2021  8:54AM','ECANSUNEXP',NULL,NULL,NULL,'202111299','Oct 28 2021 12:00AM','Dec 30 1899 12:00AM','202110011','9382','','','202110011',dbo.fn_GetTimedKey(),NULL,'us3lKiAUD1001',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECANSUNEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECANSUNEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECANSUNEXP','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECANSUNEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECANSUNEXP','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECANSUNEXP','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'ECANSUNEXP' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'ECANSUNEXP' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_ECANSUNEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECANSUNEXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECANSUNEXP','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECANSUNEXP','H02','dbo.U_ECANSUNEXP_Loader',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECANSUNEXP','D10','dbo.U_ECANSUNEXP_drvTbl_Member',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECANSUNEXP','D20','dbo.U_ECANSUNEXP_drvTbl_Person',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECANSUNEXP','D30','dbo.U_ECANSUNEXP_drvTbl_Salary',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECANSUNEXP','D40','dbo.U_ECANSUNEXP_drvTbl_Address',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECANSUNEXP','D50','dbo.U_ECANSUNEXP_drvTbl_PersonLink',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECANSUNEXP','D60','dbo.U_ECANSUNEXP_drvTbl_Benefits',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECANSUNEXP','D70','dbo.U_ECANSUNEXP_drvTbl_Member',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECANSUNEXP','T90','None',NULL);
IF OBJECT_ID('U_dsi_BDM_ECANSUNEXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ECANSUNEXP] (
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
IF OBJECT_ID('U_ECANSUNEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_ECANSUNEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ECANSUNEXP_drvTbl_Address') IS NULL
CREATE TABLE [dbo].[U_ECANSUNEXP_drvTbl_Address] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] char(12) NULL,
    [drvAddressTypeCd] varchar(1) NOT NULL,
    [drvAddressNm] varchar(201) NULL,
    [drvStreetAddressNm] varchar(510) NULL,
    [drvSuiteNm] varchar(1) NOT NULL,
    [drvCityNm] varchar(255) NULL,
    [drvStateOrProvCd] varchar(2) NULL,
    [drvPostalNum] varchar(50) NULL,
    [drvCountryCd] varchar(1) NOT NULL
);
IF OBJECT_ID('U_ECANSUNEXP_drvTbl_Benefits') IS NULL
CREATE TABLE [dbo].[U_ECANSUNEXP_drvTbl_Benefits] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] char(12) NULL,
    [drvBenefitType] varchar(3) NULL,
    [drvFlexCodeNm] varchar(1) NOT NULL,
    [drvDepTypeCd] varchar(1) NOT NULL,
    [drvEffectiveDt] varchar(10) NULL,
    [drvStatusCd] varchar(1) NOT NULL,
    [drvTermReasnonCdHeader] varchar(14) NULL,
    [drvTermReasonCd] varchar(3) NULL,
    [drvTermDt] varchar(10) NULL
);
IF OBJECT_ID('U_ECANSUNEXP_drvTbl_Member') IS NULL
CREATE TABLE [dbo].[U_ECANSUNEXP_drvTbl_Member] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] char(12) NULL,
    [drvPolicyNum] varchar(6) NOT NULL,
    [drvLocationNum] varchar(3) NULL,
    [drvClassNum] varchar(3) NULL,
    [drvPlanNm] varchar(3) NULL,
    [drvCertificateNum] char(10) NULL,
    [drvPayrollNum] varchar(1) NOT NULL,
    [drvEmploymentDt] varchar(10) NULL,
    [drvWorkResidenceCd] varchar(2) NULL,
    [drvBeneficiary] varchar(1) NOT NULL,
    [drvStatusCd] varchar(1) NOT NULL,
    [drvTermDt] varchar(10) NULL,
    [drvTermReasnonCdHeader] varchar(14) NULL,
    [drvTermReasonCd] varchar(3) NULL,
    [drvUpdateFlag] varchar(5) NOT NULL,
    [drvApplyDate] varchar(10) NULL,
    [drvTransferFlg] varchar(8) NOT NULL,
    [drvReinstatementFlg] varchar(4) NOT NULL
);
IF OBJECT_ID('U_ECANSUNEXP_drvTbl_Person') IS NULL
CREATE TABLE [dbo].[U_ECANSUNEXP_drvTbl_Person] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] char(12) NULL,
    [drvFirstNm] varchar(100) NULL,
    [drvLastNm] varchar(100) NULL,
    [drvBirthDt] varchar(10) NULL,
    [drvResidenceCd] varchar(2) NULL,
    [drvGenderCd] varchar(1) NOT NULL,
    [drvSmokerFlg] varchar(5) NOT NULL,
    [drvDepTypeCd] varchar(1) NOT NULL,
    [drvLanguageCd] varchar(1) NOT NULL
);
IF OBJECT_ID('U_ECANSUNEXP_drvTbl_PersonLink') IS NULL
CREATE TABLE [dbo].[U_ECANSUNEXP_drvTbl_PersonLink] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] char(12) NULL,
    [drvPersonLinkTypeCd] varchar(1) NULL,
    [drvFirstNm] varchar(100) NULL,
    [drvLastNm] varchar(100) NULL,
    [drvBirthDt] varchar(10) NULL,
    [drvGenderCd] char(1) NULL,
    [drvSmokerFlg] varchar(5) NOT NULL,
    [drvInSchoolFlg] varchar(1) NOT NULL,
    [drvEffectiveDt] varchar(1) NOT NULL,
    [drvTermDt] datetime NULL,
    [drvTermReasnonCdHeader] varchar(14) NULL,
    [drvTermReasonCd] varchar(1) NULL,
    [drvStatusCd] varchar(1) NOT NULL,
    [drvOldFirstNm] varchar(1) NOT NULL
);
IF OBJECT_ID('U_ECANSUNEXP_drvTbl_Salary') IS NULL
CREATE TABLE [dbo].[U_ECANSUNEXP_drvTbl_Salary] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] char(12) NULL,
    [drvSalaryDescCd] varchar(1) NOT NULL,
    [drvSalaryBasisCd] varchar(1) NOT NULL,
    [drvSalaryAmt] nvarchar(4000) NULL,
    [drvEffectiveDt] varchar(10) NULL
);
IF OBJECT_ID('U_ECANSUNEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_ECANSUNEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ECANSUNEXP_File') IS NULL
CREATE TABLE [dbo].[U_ECANSUNEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
IF OBJECT_ID('U_ECANSUNEXP_Loader') IS NULL
CREATE TABLE [dbo].[U_ECANSUNEXP_Loader] (
    [drvPolicyNum] varchar(6) NOT NULL,
    [drvClientName] varchar(36) NOT NULL,
    [drvReportLanguageCd] varchar(1) NOT NULL
);
IF OBJECT_ID('U_ECANSUNEXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ECANSUNEXP_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PehCurAmt] numeric NULL,
    [PehCurHrs] decimal NULL,
    [PehCurAmtYTD] money NULL,
    [PehCurHrsYTD] decimal NULL,
    [PehInclInDefComp] money NULL,
    [PehInclInDefCompHrs] decimal NULL,
    [PehInclInDefCompYTD] money NULL,
    [PehInclInDefCompHrsYTD] decimal NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECANSUNEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Encore Group

Created By: James Bender
Business Analyst: Lea King
Create Date: 08/05/2021
Service Request Number: TekP-2021-04-08-0004

Purpose: Canada Sunlife XML Export

\\us.saas\N2\N21\AUD1001\Exports

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECANSUNEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECANSUNEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECANSUNEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECANSUNEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECANSUNEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECANSUNEXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECANSUNEXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECANSUNEXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECANSUNEXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECANSUNEXP', 'SCH_ECANSU';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ECANSUNEXP';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ECANSUNEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ECANSUNEXP';

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
    DELETE FROM dbo.U_ECANSUNEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECANSUNEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_ECANSUNEXP_EEList WHERE xCOID IN (
        SELECT DISTINCT CmpCOID FROM dbo.Company WITH (NOLOCK) WHERE CmpCompanyCode NOT IN ('PSCA','ENCA','FMAV')
    )

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'CEXSL,CDPL,COPLF,CADD,CXADD,CXADP,CSTD,CLTD,CDENT,CMED';

    IF OBJECT_ID('U_ECANSUNEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ECANSUNEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ECANSUNEXP_DedList
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
    IF OBJECT_ID('U_ECANSUNEXP_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ECANSUNEXP_PEarHist;
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
    INTO dbo.U_ECANSUNEXP_PEarHist
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
    -- DETAIL RECORD - U_ECANSUNEXP_drvTbl_Member
    ---------------------------------
    IF OBJECT_ID('U_ECANSUNEXP_drvTbl_Member','U') IS NOT NULL
        DROP TABLE dbo.U_ECANSUNEXP_drvTbl_Member;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = xEEID
        -- standard fields above and additional driver fields below
        ,drvPolicyNum = '103932'
        ,drvLocationNum =    CASE WHEN CmpCompanyCode = 'PSCA' THEN '001'
                                WHEN CmpCompanyCode = 'ENCA' THEN '002'
                                WHEN CmpCompanyCode = 'FMAV' THEN '003'
                            END
        ,drvClassNum =    CASE WHEN CmpCompanyCode = 'PSCA' AND EecDedGroupCode = 'CHRLY' AND EepAddressState <> 'QC' THEN 'A1'
                            WHEN CmpCompanyCode = 'PSCA' AND EecDedGroupCode = 'CHRLY' AND EepAddressState = 'QC' THEN 'AQ1'
                            WHEN CmpCompanyCode = 'PSCA' AND EecDedGroupCode = 'CSAL' AND EepAddressState <> 'QC' THEN 'B1'
                            WHEN CmpCompanyCode = 'PSCA' AND EecDedGroupCode = 'CSAL' AND EepAddressState = 'QC' THEN 'BQ1'
                            WHEN CmpCompanyCode = 'ENCA' AND EecDedGroupCode = 'CHRLY' AND EepAddressState <> 'QC' THEN 'A2'
                            WHEN CmpCompanyCode = 'ENCA' AND EecDedGroupCode = 'CHRLY' AND EepAddressState = 'QC' THEN 'AQ2'
                            WHEN CmpCompanyCode = 'ENCA' AND EecDedGroupCode = 'CSAL' AND EepAddressState <> 'QC' THEN 'B2'
                            WHEN CmpCompanyCode = 'ENCA' AND EecDedGroupCode = 'CSAL' AND EepAddressState = 'QC' THEN 'BQ2'
                            WHEN CmpCompanyCode = 'ENCA' AND EecDedGroupCode = 'UCAN' AND EepAddressState = 'QC' THEN 'UQ2'
                            WHEN CmpCompanyCode = 'FMAV' AND EecDedGroupCode = 'CHRLY' AND EepAddressState <> 'QC' THEN 'A3'
                            WHEN CmpCompanyCode = 'FMAV' AND EecDedGroupCode = 'CHRLY' AND EepAddressState = 'QC' THEN 'AQ3'
                            WHEN CmpCompanyCode = 'FMAV' AND EecDedGroupCode = 'CSAL' AND EepAddressState <> 'QC' THEN 'B3'
                            WHEN CmpCompanyCode = 'FMAV' AND EecDedGroupCode = 'CSAL' AND EepAddressState = 'QC' THEN 'BQ3'
                        END
        ,drvPlanNm =    CASE WHEN CmpCompanyCode = 'PSCA' AND EecDedGroupCode = 'CHRLY' AND EepAddressState <> 'QC' THEN 'A1'
                            WHEN CmpCompanyCode = 'PSCA' AND EecDedGroupCode = 'CHRLY' AND  EepAddressState = 'QC' THEN 'AQ1'
                            WHEN CmpCompanyCode = 'PSCA' AND EecDedGroupCode = 'CSAL' AND EepAddressState <> 'QC' THEN 'B1'
                            WHEN CmpCompanyCode = 'PSCA' AND EecDedGroupCode = 'CSAL' AND EepAddressState = 'QC' THEN 'BQ1'
                            WHEN CmpCompanyCode = 'ENCA' AND EecDedGroupCode = 'CHRLY' AND EepAddressState <> 'QC' THEN 'A2'
                            WHEN CmpCompanyCode = 'ENCA' AND EecDedGroupCode = 'CHRLY' AND EepAddressState = 'QC' THEN 'AQ2'
                            WHEN CmpCompanyCode = 'ENCA' AND EecDedGroupCode = 'CSAL' AND EepAddressState <> 'QC' THEN 'B2'
                            WHEN CmpCompanyCode = 'ENCA' AND EecDedGroupCode = 'CSAL' AND EepAddressState = 'QC' THEN 'BQ2'
                            WHEN CmpCompanyCode = 'ENCA' AND EecDedGroupCode = 'UCAN' AND EepAddressState = 'QC' THEN 'UQ2'
                            WHEN CmpCompanyCode = 'FMAV' AND EecDedGroupCode = 'CHRLY' AND EepAddressState <> 'QC' THEN 'A3'
                            WHEN CmpCompanyCode = 'FMAV' AND EecDedGroupCode = 'CHRLY' AND EepAddressState = 'QC' THEN 'AQ3'
                            WHEN CmpCompanyCode = 'FMAV' AND EecDedGroupCode = 'CSAL' AND EepAddressState <> 'QC' THEN 'B3'
                            WHEN CmpCompanyCode = 'FMAV' AND EecDedGroupCode = 'CSAL' AND EepAddressState = 'QC' THEN 'BQ3'
                        END
        ,drvCertificateNum = EecUdField01 -- 'TBD' -- select * from dbo.fn_MP_CustomFields_EmpComp_Export (NULL,NULL,NULL,NULL)
        ,drvPayrollNum = ''
        ,drvEmploymentDt =    CASE WHEN EecDateOfLastHire BETWEEN @StartDate AND @EndDate THEN CONVERT(VARCHAR(10),EecDateOfLastHire, 126) END
        ,drvWorkResidenceCd =    CASE LocAddressState
                                    WHEN 'NL' THEN '1'
                                    WHEN 'PE' THEN '2'
                                    WHEN 'NB' THEN '3'
                                    WHEN 'NS' THEN '4'
                                    WHEN 'ON' THEN '5'
                                    WHEN 'QC' THEN '6'
                                    WHEN 'MB' THEN '7'
                                    WHEN 'SK' THEN '8'
                                    WHEN 'AB' THEN '9'
                                    WHEN 'BC' THEN '10'
                                END
        ,drvBeneficiary = ''
        ,drvStatusCd = CASE WHEN EecEmplStatus = 'T' THEN '3' ELSE '1' END
        ,drvTermDt = CONVERT(VARCHAR(10),EecDateOfTermination, 126)
        ,drvTermReasnonCdHeader = CASE WHEN EecEmplStatus = 'T' AND EecTermReason = '203' THEN ' TermReasonCd=' 
                                WHEN EecEmplStatus = 'T' AND EecTermReason <> '203' THEN ' TermReasonCd=' 
                            END
        ,drvTermReasonCd =    CASE WHEN EecEmplStatus = 'T' AND EecTermReason = '203' THEN '"6"' 
                                WHEN EecEmplStatus = 'T' AND EecTermReason <> '203' THEN '"2"'
                            END
        ,drvUpdateFlag = CASE WHEN EecDateOfLastHire BETWEEN @StartDate AND @EndDate THEN 'False' ELSE 'True' END
        ,drvApplyDate =    CONVERT(VARCHAR(10),
                                
                                CASE WHEN EjhReason = 'TRI' THEN 
                                        CASE WHEN EjhJobEffDate > DATEADD(YEAR, -1, GETDATE()) THEN EjhJobEffDate ELSE DATEADD(YEAR, 1, GETDATE()) END
                                    WHEN EecDateOfLastHire BETWEEN @StartDate AND @EndDate THEN 
                                        CASE WHEN EecDateOfLastHire > DATEADD(YEAR, -1, GETDATE()) THEN EecDateOfLastHire ELSE DATEADD(YEAR, 1, GETDATE()) END
                                    WHEN EecEmplStatus = 'T' THEN 
                                        CASE WHEN EecDateOfTermination > DATEADD(YEAR, -1, GETDATE()) THEN EecDateOfTermination ELSE DATEADD(YEAR, 1, GETDATE()) END
                                    ELSE 
                                        CASE WHEN dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(xEEID, xCOID, GETDATE(), EecDateOfLastHire) > DATEADD(YEAR, -1, GETDATE()) THEN dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(xEEID, xCOID, GETDATE(), EecDateOfLastHire) ELSE GETDATE() END--DATEADD(YEAR, 1, GETDATE()) END
                                END
                                , 126)
        ,drvTransferFlg = 'Implicit'
        ,drvReinstatementFlg = 'True' --CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN 'True' ELSE 'False' END
    INTO dbo.U_ECANSUNEXP_drvTbl_Member
    FROM dbo.U_ECANSUNEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ECANSUNEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.Company WITH (NOLOCK)
        ON CmpCOID = xCOID
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    LEFT JOIN (
                SELECT EjhEEID, EjhCOID, EjhReason, EjhJobEffDate
                FROM (
                        SELECT EjhEEID, EjhCOID, EjhReason, EjhJobEffDate, ROW_NUMBER() OVER(PARTITION BY EjhEEID, EjhCOID ORDER BY EjhJobEffDate DESC) AS RN
                        FROM dbo.EmpHJob WITH (NOLOCK)) AS InnerEjh
                WHERE RN = 1) AS Ejh
        ON EjhEEID = xEEID
        AND EjhCOID = xCOID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ECANSUNEXP_drvTbl_Person
    ---------------------------------
    IF OBJECT_ID('U_ECANSUNEXP_drvTbl_Person','U') IS NOT NULL
        DROP TABLE dbo.U_ECANSUNEXP_drvTbl_Person;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort =  xEEID
        -- standard fields above and additional driver fields below
        ,drvFirstNm = EepNameFirst
        ,drvLastNm = EepNameLast
        ,drvBirthDt = CONVERT(VARCHAR(10),EepDateOfBirth, 126)
        ,drvResidenceCd = CASE LocAddressState
                            WHEN 'NL' THEN '1'
                            WHEN 'PE' THEN '2'
                            WHEN 'NB' THEN '3'
                            WHEN 'NS' THEN '4'
                            WHEN 'ON' THEN '5'
                            WHEN 'QC' THEN '6'
                            WHEN 'MB' THEN '7'
                            WHEN 'SK' THEN '8'
                            WHEN 'AB' THEN '9'
                            WHEN 'BC' THEN '10'
                        END
        ,drvGenderCd = CASE WHEN EepGender = 'M' THEN '1' ELSE '2' END
        ,drvSmokerFlg = CASE WHEN EepIsSmoker = 'Y' THEN 'True' ELSE 'False' END
        ,drvDepTypeCd =    CASE WHEN DepTypeEEID IS NOT NULL THEN '3' ELSE '2' END
                        --CASE WHEN BdmDedCode IN ('CDENT','CMED') AND BdmBenOption IN ('FAMILY','FAMON','FAMQC') THEN '3' ELSE '2' END
        ,drvLanguageCd =    CASE WHEN EecLanguageCode = 'FR' THEN '2' ELSE '1' END                                
    INTO dbo.U_ECANSUNEXP_drvTbl_Person
    FROM dbo.U_ECANSUNEXP_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_ECANSUNEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID    
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    LEFT JOIN (
                SELECT DISTINCT BdmEEID AS DepTypeEEID, BdmCOID AS DepTypeCOID
                FROM dbo.U_dsi_BDM_ECANSUNEXP WITH (NOLOCK)
                WHERE BdmDedCode IN ('CDENT','CMED') AND BdmBenOption IN ('FAMILY','FAMON','FAMQC')) AS DepType
        ON DepTypeEEID = xEEID
        AND DepTypeCOID = xCOID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ECANSUNEXP_drvTbl_Salary
    ---------------------------------
    IF OBJECT_ID('U_ECANSUNEXP_drvTbl_Salary','U') IS NOT NULL
        DROP TABLE dbo.U_ECANSUNEXP_drvTbl_Salary;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = xEEID
        -- standard fields above and additional driver fields below
        ,drvSalaryDescCd = '1'
        ,drvSalaryBasisCd = CASE WHEN EecSalaryOrHourly = 'S' THEN '1' ELSE '5' END
        ,drvSalaryAmt = FORMAT(EecAnnSalary, '#0.00')
                        --FORMAT(CASE WHEN EecSalaryOrHourly = 'S' THEN EecAnnSalary ELSE EecHourlyPayRate END, '#0.00')
        /*,drvHoursPerWeekAmt =    FORMAT(CASE WHEN EecSalaryOrHourly = 'H' AND PgrPayFrequency IN ('B','S') THEN PehCurHrs/2
                                    WHEN EecSalaryOrHourly = 'H' AND PgrPayFrequency IN ('W') THEN PehCurHrs
                                END, '#0.00')*/
        ,drvEffectiveDt = CONVERT(VARCHAR(10), dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(xEEID, xCOID, @EndDate, EecDateOfLastHire), 126)
    INTO dbo.U_ECANSUNEXP_drvTbl_Salary
    FROM dbo.U_ECANSUNEXP_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_ECANSUNEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.PayGroup WITH (NOLOCK)
        ON PgrPayGroup = EecPayGroup
    JOIN dbo.U_ECANSUNEXP_PEarHist
        ON PehEEID = xEEID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ECANSUNEXP_drvTbl_Address
    ---------------------------------
    IF OBJECT_ID('U_ECANSUNEXP_drvTbl_Address','U') IS NOT NULL
        DROP TABLE dbo.U_ECANSUNEXP_drvTbl_Address;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = xEEID
        -- standard fields above and additional driver fields below
        ,drvAddressTypeCd = '1'
        ,drvAddressNm = EepNameFirst + ' ' + EepNameLast
        ,drvStreetAddressNm = EepAddressLine1 + ISNULL(EepAddressLine2, '')
        ,drvSuiteNm = ''
        ,drvCityNm = EepAddressCity
        ,drvStateOrProvCd = CASE EepAddressState
                            WHEN 'NL' THEN '1'
                            WHEN 'PE' THEN '2'
                            WHEN 'NB' THEN '3'
                            WHEN 'NS' THEN '4'
                            WHEN 'ON' THEN '5'
                            WHEN 'QC' THEN '6'
                            WHEN 'MB' THEN '7'
                            WHEN 'SK' THEN '8'
                            WHEN 'AB' THEN '9'
                            WHEN 'BC' THEN '10'
                        END        
        ,drvPostalNum =    CASE WHEN EepAddressCountry = 'CAN' THEN LEFT(EepAddressZipCode, 3) + ' ' + RIGHT(RTRIM(EepAddressZipCode), 3)  ELSE EepAddressZipCode END
        ,drvCountryCd = '1'
    INTO dbo.U_ECANSUNEXP_drvTbl_Address
    FROM dbo.U_ECANSUNEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ECANSUNEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ECANSUNEXP_drvTbl_PersonLink
    ---------------------------------
    IF OBJECT_ID('U_ECANSUNEXP_drvTbl_PersonLink','U') IS NOT NULL
        DROP TABLE dbo.U_ECANSUNEXP_drvTbl_PersonLink;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = xEEID
        -- standard fields above and additional driver fields below
        ,drvPersonLinkTypeCd =    CASE WHEN ConRelationship IN ('CVL','DOM','SPS') THEN '2'
                                    WHEN ConRelationship IN ('CHL','STC') THEN '3'
                                END
        ,drvFirstNm = ConNameFirst
        ,drvLastNm = ConNameLast
        ,drvBirthDt = CONVERT(VARCHAR(10), ConDateOfBirth, 126)
        ,drvGenderCd = ConGender
        ,drvSmokerFlg = CASE WHEN ConIsSmoker = 'Y' THEN 'True' ELSE 'False' END
        ,drvInSchoolFlg = ''
        ,drvEffectiveDt = ''
        ,drvTermDt = CASE WHEN EecEmplStatus = 'T' THEN BdmBenStopDate END
        ,drvTermReasnonCdHeader = CASE WHEN EecEmplStatus = 'T' THEN ' TermReasonCd='  END
        ,drvTermReasonCd = CASE WHEN EecEmplStatus = 'T' THEN '2' END
        ,drvStatusCd = CASE WHEN EecEmplStatus = 'T' THEN '3' ELSE '1' END
        ,drvOldFirstNm = ''
    INTO dbo.U_ECANSUNEXP_drvTbl_PersonLink
    FROM dbo.U_ECANSUNEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.U_dsi_BDM_ECANSUNEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ECANSUNEXP_drvTbl_Benefits
    ---------------------------------
    IF OBJECT_ID('U_ECANSUNEXP_drvTbl_Benefits','U') IS NOT NULL
        DROP TABLE dbo.U_ECANSUNEXP_drvTbl_Benefits;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = xEEID
        -- standard fields above and additional driver fields below
        ,drvBenefitType =    CASE WHEN BdmDedCode = 'CEXSL' THEN '101'
                                WHEN BdmDedCode = 'CDPL' THEN '103'
                                WHEN BdmDedCode = 'COPLF' THEN '111'
                                WHEN BdmDedCode IN ('CADD','CXADD','CXADP') THEN '301'
                                WHEN BdmDedCode = 'CDENT' THEN '502'
                                WHEN BdmDedCode = 'CSTD' THEN '401'
                                WHEN BdmDedCode = 'CLTD' THEN '411'
                                WHEN BdmDedCode = 'CMED' THEN '512'
                            END
        ,drvFlexCodeNm = 'A'
        ,drvDepTypeCd =    CASE WHEN BdmDedCode = 'CDPL' THEN '3'
                            WHEN BdmDedCode IN ('CDENT','CMED') AND BdmBenOption IN ('FAMILY','FAMON','FAMQC') THEN '3'
                            WHEN BdmDedCode IN ('CDENT','CMED') AND BdmBenOption IN ('EEON','EEONLY','EEQC') THEN '2'
                            ELSE '1'
                        END
        ,drvEffectiveDt = CONVERT(VARCHAR(10), BdmBenStartDate, 126)
--        ,drvRequestedUnitsAmt = FORMAT(BdmEEAmt, '#0.00')
--        ,drvRequestedAmt = ''
        ,drvStatusCd = CASE WHEN BdmBenStatus <> 'A' THEN '3' ELSE '1' END
        ,drvTermReasnonCdHeader =    CASE WHEN EecEmplStatus = 'T' THEN 
                                        CASE WHEN BdmBenStatus <> 'A' THEN ' TermReasonCd='  END
                                    END
        ,drvTermReasonCd =  CASE WHEN EecEmplStatus = 'T' THEN 
                                CASE WHEN BdmBenStatus <> 'A' THEN '"1"' END
                            END
        ,drvTermDt = CONVERT(VARCHAR(10), BdmBenStopDate, 126)
    INTO dbo.U_ECANSUNEXP_drvTbl_Benefits
    FROM dbo.U_ECANSUNEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.U_dsi_BDM_ECANSUNEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    WHERE EecEmplStatus <> 'T'
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ECANSUNEXP_Loader','U') IS NOT NULL
        DROP TABLE dbo.U_ECANSUNEXP_Loader;
    SELECT DISTINCT
         drvPolicyNum = '103932'
        ,drvClientName = 'Audio Visual Services (Canada) Corp.'
        ,drvReportLanguageCd = '1'
    INTO dbo.U_ECANSUNEXP_Loader
    FROM dbo.U_ECANSUNEXP_EEList WITH (NOLOCK)
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
ALTER VIEW dbo.dsi_vwECANSUNEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECANSUNEXP_File (NOLOCK)
    ORDER BY CASE LEFT(RecordSet,1) WHEN 'D' THEN 10 ELSE RIGHT(RecordSet,2) END, InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ECANSUNEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202107291'
       ,expStartPerControl     = '202107291'
       ,expLastEndPerControl   = '202108059'
       ,expEndPerControl       = '202108059'
WHERE expFormatCode = 'ECANSUNEXP';

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
CREATE VIEW dbo.dsi_vwECANSUNEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECANSUNEXP_File (NOLOCK)
    ORDER BY CASE LEFT(RecordSet,1) WHEN 'D' THEN 10 ELSE RIGHT(RecordSet,2) END, InitialSort, RecordSet, SubSort;