/*
Directions:
1) Find and replace each of the text below with the applicable information.
       E.g. Replace the text "@DeveloperName" (excluding quotes) with "John Doe"
2) Deploy this to client environment!

-- Integration parameters
@CustomerName - Replace with customer name
@DeveloperName - Replace with TC name
@IntegrationAnalystName - Replace with BA/IC name
@CreateDate - Replace with date of creation
@SRNumber - Replace with SR number
@CustomFormatCode - Replace with Format Code (i.e., ESUNLIFXML)
@CustomFormatName - Replace with Name of Interface (AdfFormatName) (i.e., SunLife Demographic Benefits XML Export)
@IsWebFlag - Replace with 'Y' (Yes) or 'N' (No) for Web Interface Settings

-- File parameters
@FileExportPath - Replace with the Export Path where the file generates to (i.e., \\us.saas\e1\Public\[Client ARNum]\Exports\Sunlife\)
@FileTestPath - Replace with the Test Path where the file generates to (i.e., \\us.saas\e1\Public\[Client ARNum]\Exports\Sunlife\)
@FileUDESPath - Replace with the UDES Path where the file generates to (i.e., \\us.saas\e0\data_exchange\[Client ARNum]\Exports\)
@FileNamePreFix - Replace with File Name Prefix (i.e., T100000)

--Data Parameters
@DedCodeList - Replace with the Deduction Code List (Ex:MED,DEN,VIS,ADD,LIFE)
@PolicyNum - Replace with the Deduction Code List (Ex: 100000)
@LocationNum - Replace with Location Number (Ex: 001)
@ClientName - Replace with the Deduction Code List (Ex:'Client Name, LLC')
@FamilyBenOption - Replace with the Deduction Code List (Ex:'FAM')
@EEOnlyBenOption - Replace with the Deduction Code List (Ex:'EE')
@SpouseRelationshipCodes - Replace with the Deduction Code List (Ex:'SPS','DP')
@ChildRelationshipCodes - Replace with the Deduction Code List (Ex:'CHL','STC')

*/
SET NOCOUNT ON;
IF OBJECT_ID('dsi_vw@CustomFormatCode_XML') IS NOT NULL DROP VIEW [dbo].[dsi_vw@CustomFormatCode_XML];
GO
IF OBJECT_ID('dsi_vw@CustomFormatCode_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vw@CustomFormatCode_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_@CustomFormatCode') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_@CustomFormatCode];
GO
IF OBJECT_ID('dsi_sp_AfterCollect_@CustomFormatCode') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_AfterCollect_@CustomFormatCode];
GO
IF OBJECT_ID('U_@CustomFormatCode_XML') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_XML];
GO
IF OBJECT_ID('U_@CustomFormatCode_States') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_States];
GO
IF OBJECT_ID('U_@CustomFormatCode_File') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_File];
GO
IF OBJECT_ID('U_@CustomFormatCode_EEList') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_EEList];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_Salary') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_Salary];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_PersonLink') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_PersonLink];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_Person') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_Person];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_Member') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_Member];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_Benefits') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_Benefits];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_Address') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_Address];
GO
IF OBJECT_ID('U_@CustomFormatCode_DrvTbl') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_DrvTbl];
GO
IF OBJECT_ID('U_@CustomFormatCode_Detail') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_Detail];
GO
IF OBJECT_ID('U_Dsi_drvTbl_@CustomFormatCode_Audit') IS NOT NULL DROP TABLE [dbo].[U_Dsi_drvTbl_@CustomFormatCode_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_@CustomFormatCode') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_@CustomFormatCode];
GO
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = '@CustomFormatCode';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = '@CustomFormatCode';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = '@CustomFormatCode';
GO

DECLARE @AdhSystemID VARCHAR(12), @FixedFormatName1 VARCHAR(50), @FixedFormatName2 VARCHAR(50);
SET @AdhSystemID = LEFT('@CustomFormatCode' + REPLICATE('0',10),10) + 'Z0';
SET @FixedFormatName1 = LEFT('@CustomFormatName',50);
SET @FixedFormatName2 = LEFT('@CustomFormatName',30);

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0',NULL,NULL,'N',NULL,'N',NULL,'013010','EMPEXPORT','SDF','@CustomFormatCode','SunLife HRIS Group Benefits XML Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_SwitchBox_v2','500','S','N',@AdhSystemID,'N',NULL,'C','N',NULL,'N');
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'On Demand Export','201709189','EMPEXPORT','ON_DEMAND','Feb 29 2016  2:54PM','@CustomFormatCode',NULL,NULL,NULL,'201709189','Feb 29 2016 12:00AM','Dec 30 1899 12:00AM','201709011','607','','','201709011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session Only','201811079','EMPEXPORT','SCHEDULED','Nov  7 2018  7:00PM','@CustomFormatCode',NULL,NULL,NULL,'201811079','Sep 18 2017 12:00AM','Dec 30 1899 12:00AM','201810311','1','','','201810311',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Test Session Only','201801311','EMPEXPORT','TEST','Mar 27 2018  2:07PM','@CustomFormatCode',NULL,NULL,NULL,'201801311','Jan 31 2018 12:00AM','Dec 30 1899 12:00AM','201801011','272','','','201801011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','ExportPath','V','@FileExportPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','MultFile','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','OverrideCount','V','0');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','TestPath','V','@FileTestPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','UDESPath','V','@FileUDESPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','UseFileName','V','N');
GO
IF ('@IsWebFlag' = 'Y')
BEGIN
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = '@CustomFormatCode' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */

/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = '@CustomFormatCode.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
UPDATE dbo.AscExp SET expAscFileName = @FILEPATH + @FILENAME WHERE expFormatCode = '@CustomFormatCode';

/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = '@CustomFormatCode' AND CfgName = 'ExportPath' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = '@CustomFormatCode' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
/*03*/ DELETE FROM dbo.U_dsi_Configuration WHERE FormatCode = '@CustomFormatCode' AND CfgName = 'TestPath'; /* Remove Test Path for Web Exports */

END
GO
IF OBJECT_ID('U_@CustomFormatCode_EEList') IS NULL
CREATE TABLE [dbo].[U_@CustomFormatCode_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_@CustomFormatCode_File') IS NULL
CREATE TABLE [dbo].[U_@CustomFormatCode_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(500) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_AfterCollect_@CustomFormatCode]
AS
SET NOCOUNT ON;
/**********************************************************************************
Client: @CustomerName

Created By: @DeveloperName
Business Analyst: @IntegrationAnalystName
Create Date: @CreateDate
PSA Request Number: @SRNumber

Purpose: Custom BCP Statement for XML File

Revision History
----------------
Update By            Date            Request Num                Desc
XXXX                 XX/XX/XX        SR-20XX-000XXXXX           Added 1234

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.AscExp WHERE ExpFormatCode = '@CustomFormatCode';

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'ON_DEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'SCHEDULED';
**********************************************************************************/
BEGIN

    -- Declare variables
    DECLARE @FormatCode      VARCHAR(10)
            ,@sCmd           VARCHAR(1000)
            ,@ExportPath     VARCHAR(500)
            ,@FileName       VARCHAR(100)
            ,@sXML           VARCHAR(100);

    -- Set variables
    SET @FormatCode = '@CustomFormatCode';
    SET @ExportPath = dbo.dsi_fnVariable(@FormatCode,'ExportPath');
    SET @FileName = (SELECT ExportFile FROM dbo.U_dsi_Parameters (NOLOCK) WHERE FormatCode = '@CustomFormatCode');
    SET @sXML = '<?xml version=""1.0"" encoding=""ISO-8859-1"" ?>';

    --=====================================
    -- Generate XML File via Custom BCP
    --=====================================
    SELECT @sCmd = 'BCP "SELECT ''' + @sXML + ''' + CONVERT(VARCHAR(MAX),XMLOUT) FROM '+ RTRIM(DB_NAME()) + '.dbo.U_@CustomFormatCode_XML WITH (NOLOCK) " QueryOut "' + @ExportPath + @FileName +'"' +
                  ' -S"' + rtrim(@@SERVERNAME) + '" -T -c -t';

    EXEC master.dbo.xp_cmdshell @sCmd, NO_OUTPUT;

END
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_@CustomFormatCode]
    @systemid CHAR(12)
AS
/**********************************************************************************
Client: @CustomerName

Created By: @DeveloperName
Business Analyst: @IntegrationAnalystName
Create Date: @CreateDate
PSA Request Number: @SRNumber

Purpose: SunLife Demographic Benefits XML Export

Revision History
----------------
Update By            Date            Request Num                Desc
XXXX                 XX/XX/XX        SR-20XX-000XXXXX           Added 1234

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.AscExp WHERE ExpFormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_DSI_InterfaceActivityLog WHERE FormatCode = '@CustomFormatCode' ORDER BY DateTimeStamp DESC

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'ON_DEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'SCHEDULED';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'TEST';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = '@CustomFormatCode', @AllObjects = 'Y', @IsWeb = 'N';
**********************************************************************************/
BEGIN

    -----------
    -- Declare variables
    -----------

    DECLARE @FormatCode       CHAR(10)
    DECLARE @ExportCode       CHAR(10)
    DECLARE @StartDateTime    DATETIME
    DECLARE @EndDateTime      DATETIME
    DECLARE @StartPerControl  CHAR(9)
    DECLARE @EndPerControl    CHAR(9)
    DECLARE @TestingFlag      CHAR(1)

    -----------
    -- Set variables
    -----------

    SELECT

    @FormatCode      = FormatCode,
    @ExportCode      = ExportCode,
    @StartPerControl = StartPerControl,
    @EndPerControl   = EndPerControl

    FROM dbo.U_dsi_Parameters
    WHERE FormatCode = '@CustomFormatCode';

    SET @TestingFlag   = CASE WHEN @ExportCode LIKE '%TEST%' THEN 'Y' WHEN @ExportCode LIKE '%TST%' THEN 'Y' ELSE 'N' END;
    SET @StartDateTime = CONVERT(DATETIME, LEFT(@StartPerControl, 8));
    SET @EndDateTime   = CONVERT(DATETIME, LEFT(@EndPerControl, 8));
    SET @EndDateTime   = DATEADD(SECOND, -1, DATEADD(DD,1, DATEDIFF(DD, 0, @EndDateTime))); -- 11:59:59 pm

    -----------------
    -- Create Lookup Table for States
    -----------------

    IF OBJECT_ID('dbo.U_@CustomFormatCode_States')     IS NOT NULL  DROP TABLE dbo.U_@CustomFormatCode_States;

    CREATE TABLE [dbo].[U_@CustomFormatCode_States] (
        [StaAbbr] char(2) NULL,
        [StaCode] char(2) NULL,
        [StaName] varchar(50) NULL
    );

    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('AL','14','Alabama');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('AK','15','Alaska');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('AB','9','Alberta');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('AZ','16','Arizona');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('AR','17','Arkansas');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('BM','65','Bermuda');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('BC','10','British Columbia');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('CA','18','California');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('CO','19','Colorado');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('CT','20','Connecticut');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('DE','21','Delaware');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('DC','22','District of Columbia');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('FL','23','Florida');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('GA','24','Georgia');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('HI','25','Hawaii');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('ID','26','Idaho');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('IL','27','Illinois');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('IN','28','Indiana');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('IA','29','Iowa');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('KS','30','Kansas');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('KY','31','Kentucky');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('LA','32','Louisiana');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('ME','33','Maine');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('MB','7','Manitoba');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('MD','34','Maryland');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('MA','35','Massachusetts');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('MI','36','Michigan');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('MN','37','Minnesota');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('MS','38','Mississippi');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('MO','39','Missouri');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('MT','40','Montana');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('NT','11','Northwest Territories');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('NE','41','Nebraska');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('NV','42','Nevada');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('NB','3','New Brunswick');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('NH','43','New Hampshire');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('NJ','44','New Jersey');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('NM','45','New Mexico');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('NY','46','New York');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('NL','1','Newfoundland');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('NC','47','North Carolina');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('ND','48','North Dakota');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('NS','4','Nova Scotia');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('NU','13','Nunavut');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('OH','49','Ohio');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('OK','50','Oklahoma');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('ON','5','Ontario');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('OR','51','Oregon');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('','74','Other Foreign');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('PA','52','Pennsylvania');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('PE','2','Prince Edward Island');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('PR','66','Puerto Rico');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('QC','6','Quebec');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('RI','53','Rhode Island');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('SK','8','Saskatchewan');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('SC','54','South Carolina');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('SD','55','South Dakota');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('TN','56','Tennessee');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('TX','57','Texas');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('UT','58','Utah');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('VT','59','Vermont');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('VA','60','Virginia');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('WA','61','Washington');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('WV','62','West Virginia');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('WI','63','Wisconsin');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('WY','64','Wyoming');
    INSERT INTO [dbo].[U_@CustomFormatCode_States] (StaAbbr,StaCode,StaName) VALUES ('YT','12','Yukon Territory');

    -----------------
    -- Testing Only
    -----------------

     --DELETE FROM dbo.U_@CustomFormatCode_EEList WHERE xEEID NOT IN ('BS215N0200K0','')

    -- sp_geteeid 'TestEmployee'

    -----------
    -- Clean up EE List
    -----------

    DELETE A
    FROM dbo.U_@CustomFormatCode_EEList A
    WHERE A.xCOID <> dbo.dsi_fn_GetCurrentCOID(A.xEEID)  
    AND EXISTS (SELECT 1 FROM dbo.U_@CustomFormatCode_EEList B WHERE A.xEEID = B.xEEID AND A.xCOID <> B.xCOID AND B.xCOID = dbo.dsi_fn_GetCurrentCOID(B.xEEID));

    -----------
    -- Benefits Deduction Module
    -----------

    DELETE FROM dbo.U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode;

    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'DedCodes','@DedCodeList');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'StartDateTime',@StartDateTime);
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'EndDateTime',@EndDateTime);
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'TermSelectionOption','AuditDate');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'ExclFutureDatedStartDates', 'Y')
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'ExclFutureDatedStopDates', 'Y')

    EXEC dbo.dsi_bdm_sp_PopulateDeductionsTable @FormatCode;

    -- Remove employees without deductions
    DELETE A
    FROM dbo.U_@CustomFormatCode_EELIST A
    LEFT JOIN dbo.U_dsi_bdm_@CustomFormatCode WITH (NOLOCK) ON BdmEEID = xEEID AND BdmCOID = xCOID
    WHERE ISNULL(BdmEEID,'') = '';

    -----------
    -- Remove terminations except in the range
    -----------

    IF OBJECT_ID('dbo.U_Dsi_drvTbl_@CustomFormatCode_Audit')     IS NOT NULL  DROP TABLE dbo.U_Dsi_drvTbl_@CustomFormatCode_Audit;

    SELECT DISTINCT

    AudKey1Value,
    AudKey2Value,
    AudKey3Value,
    AudTableName,
    AudFieldName,
    AudOldValue,
    AudNewValue,
    AudDateTime,
    AudProcessedDateTime

    INTO dbo.U_Dsi_drvTbl_@CustomFormatCode_Audit
    FROM dbo.U_@CustomFormatCode_EELIST
    JOIN dbo.vw_AuditEEdata ON AudKey1Value = xEEID
    -- Want maximum audit key in case of multiple changes
    JOIN (SELECT AudKey1Value MaxEEID, AudFieldName MaxFieldName, MAX(AudProcessedDateTime) AS MaxDateTime
          FROM dbo.vw_AuditEEdata
          WHERE AudTableName IN ('EmpComp','Contacts') 
          AND AudFieldName IN ('EecEmplStatus','ConNameFirst')
          AND AudProcessedDateTime BETWEEN @StartDateTime AND @EndDateTime
          GROUP BY AudKey1Value,AudFieldName) MaxAudit ON AudKey1Value = MaxEEID AND AudFieldName = MaxFieldName AND AudProcessedDateTime = MaxDateTime
    WHERE AudTableName IN ('EmpComp','Contacts') 
    AND AudFieldName IN ('EecEmplStatus','ConNameFirst')
    AND AudProcessedDateTime BETWEEN @StartDateTime AND @EndDateTime;

    DELETE A
    FROM dbo.U_@CustomFormatCode_EELIST A
    JOIN dbo.EmpComp WITH (NOLOCK) ON EecEEID = xEEID AND EecCOID = xCOID AND EecEmplStatus = 'T'
    WHERE NOT EXISTS (SELECT 1 FROM dbo.U_Dsi_drvTbl_@CustomFormatCode_Audit WHERE EecEEID = AudKey1Value AND EecCOID = AudKey2Value AND AudNewValue = 'T');

    -----------
    -- Identify New/Re-Hires
    -----------

    IF object_id('U_@CustomFormatCode_Detail') IS NOT NULL DROP TABLE dbo.U_@CustomFormatCode_Detail

    SELECT DISTINCT 

     detEEID    = xEEID
    ,detCOID    = xCOID
    ,detNewHire = CASE WHEN ISNULL(AudOldValue,'') = '' AND AudNewValue = 'A' THEN 'Y' END
    ,detReHire  = CASE WHEN AudOldValue = 'T' AND AudNewValue = 'A' THEN 'Y' END
    ,detTerm    = CASE WHEN AudNewValue = 'T' THEN 'Y' END

    INTO dbo.U_@CustomFormatCode_Detail
    FROM dbo.U_@CustomFormatCode_EELIST WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK) ON EecEEID = xEEID AND EecCoID = xCOID
    LEFT JOIN dbo.U_Dsi_drvTbl_@CustomFormatCode_Audit WITH (NOLOCK) ON EecEEID = AudKey1Value AND EecCOID = AudKey2Value;

    -----------
    -- Build Member Table
    -----------

    IF object_id('U_@CustomFormatCode_drvTbl_Member') IS NOT NULL DROP TABLE dbo.U_@CustomFormatCode_drvTbl_Member;

    SELECT DISTINCT 

     EEID              = DetEEID
    ,COID              = DetCOID
    ,PolicyNum         = '@PolicyNum'
    ,LocationNum       = '@LocationNum '
    ,ClassNum          = RIGHT(RTRIM(BdmDedCode),1)
    ,PlanNum           = RIGHT(RTRIM(BdmDedCode),1)
    ,CertificateNum    = CONVERT(VARCHAR(20),CAST(EecEmpNo AS INT))
    ,EmploymentDt      = CONVERT(VARCHAR(10),EecDateOfOriginalHire,121)
    ,WorkResidenceCd   = StaCode
    ,StatusCd          = CASE detTerm WHEN 'Y' THEN '3' END
    ,TermDt            = CASE detTerm WHEN 'Y' THEN CONVERT(VARCHAR(10),EecDateOfTermination,121) END
    ,TermReasonCd      = CASE detTerm WHEN 'Y' THEN CASE EecTermReason WHEN '203' THEN '6' ELSE '2' END END
    ,UpdateFlag        = CASE WHEN detNewHire = 'Y' THEN 'False' 
                              WHEN EecDateOfOriginalHire >= @StartDateTime - 38 THEN 'False'    
                              ELSE 'True'
                         END
    ,ApplyDate         = CASE WHEN detNewHire = 'Y' THEN CONVERT(VARCHAR(10),EecDateOfOriginalHire,121)
                              WHEN detReHire = 'Y' THEN CONVERT(VARCHAR(10),EecDateOfLastHire,121)
                              WHEN detTerm = 'Y' THEN CONVERT(VARCHAR(10),EecDateOfTermination,121)
                              WHEN ISNULL(EjhJobEffDate,'') <> '' THEN CONVERT(VARCHAR(10),EjhJobEffDate,121)
                              ELSE CONVERT(VARCHAR(10),GETDATE(),121)
                         END
    ,TransferFlg      = ''
    ,ReinstatementFlag = CASE WHEN detReHire = 'Y' THEN 'True' END

    INTO dbo.U_@CustomFormatCode_drvTbl_Member
    FROM dbo.U_@CustomFormatCode_Detail WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK) ON EecEEID = DetEEID AND EecCoID = DetCOID
    JOIN dbo.EmpPers WITH (NOLOCK) ON eepEEID = DetEEID
    LEFT JOIN dbo.U_dsi_bdm_@CustomFormatCode WITH (NOLOCK) ON BdmEEID = DetEEID AND BdmCOID = DetCOID
    LEFT JOIN dbo.U_@CustomFormatCode_States WITH (NOLOCK) ON LEFT(EecStateSUI,2) = StaAbbr
    LEFT JOIN (SELECT EjhEEID,EjhCoID,MAX(EjhJobEffDate) AS EjhJobEffDate FROM dbo.EmpHJob WHERE EjhIsRateChange = 'Y' GROUP BY EjhEEID,EjhCoID) RATCHG ON RATCHG.EjhEEID = DetEEID AND RATCHG.EjhCoID = DetCoID;

    -----------
    -- Build Person Table
    -----------

    IF object_id('U_@CustomFormatCode_drvTbl_Person') IS NOT NULL DROP TABLE dbo.U_@CustomFormatCode_drvTbl_Person;

    SELECT DISTINCT 

     EEID
    ,COID
    ,FirstNm     = dbo.dsi_fnRemoveChars('()_1234567890',EepNameFirst)
    ,LastNm      = dbo.dsi_fnRemoveChars('()_1234567890',EepNameLast)
    ,BirthDt     = CONVERT(VARCHAR(10),EepDateOfBirth,121)
    ,ResidenceCd = StaCode
    ,GenderCd    = CASE EepGender WHEN 'M' THEN '1' WHEN 'F' THEN '2' END
    ,DepTypeCd   = CASE WHEN EXISTS (SELECT 1 FROM dbo.Contacts WHERE ConEEID = EEID AND ConIsDependent = 'Y' AND ConRelationship IN ('@SpouseRelationshipCodes','@ChildRelationshipCodes')) THEN '3' ELSE '2' END
    ,LanguageCd  = CASE EecLanguageCode WHEN 'EN' THEN '1' ELSE '2' END

    INTO dbo.U_@CustomFormatCode_drvTbl_Person
    FROM dbo.U_@CustomFormatCode_drvTbl_Member WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK) ON EecEEID = EEID AND EecCoID = COID
    JOIN dbo.EmpPers WITH (NOLOCK) ON eepEEID = EEID
    LEFT JOIN dbo.U_@CustomFormatCode_States WITH (NOLOCK) ON EepAddressState = StaAbbr
    WHERE ISNULL(TermDt,'') = '';

    -----------
    -- Build Salary Table
    -----------

    IF object_id('U_@CustomFormatCode_drvTbl_Salary') IS NOT NULL DROP TABLE dbo.U_@CustomFormatCode_drvTbl_Salary;

    SELECT DISTINCT 

     EEID
    ,COID
    ,SalaryDescCd    = '1'
    ,SalaryBasisCd   = '1'
    ,SalaryAmt       = CONVERT(VARCHAR(20),CAST(EecAnnSalary AS INT))
    ,HoursPerWeekAmt = ''

    INTO dbo.U_@CustomFormatCode_drvTbl_Salary
    FROM dbo.U_@CustomFormatCode_drvTbl_Member WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK) ON EecEEID = EEID AND EecCoID = COID
    WHERE ISNULL(TermDt,'') = '';

    -----------
    -- Build Address Table
    -----------

    IF object_id('U_@CustomFormatCode_drvTbl_Address') IS NOT NULL DROP TABLE dbo.U_@CustomFormatCode_drvTbl_Address;

    SELECT DISTINCT 

     EEID
    ,COID
    ,AddressTypeCd   = '1'
    ,AddressNm       = RTRIM(dbo.dsi_fnRemoveChars('()_1234567890',EepNameFirst)) + ' ' + dbo.dsi_fnRemoveChars('()_1234567890',EepNameLast)
    ,StreetAddressNm = EepAddressLine1
    ,SuiteNm         = EepAddressLine2
    ,CityNm          = EepAddressCity
    ,StateOrProvCd   = StaCode
    ,PostalNum       = LEFT(EepAddressZipCode,3) + ' ' + SUBSTRING(EepAddressZipCode,4,3)
    ,CountryCd       = CASE EepAddressCountry WHEN 'USA' THEN '2' WHEN 'CAN' THEN '1' END
    ,EmailAddressNm  = EepAddressEmail
    ,Phone1Num       = EepPhoneHomeNumber

    INTO dbo.U_@CustomFormatCode_drvTbl_Address
    FROM dbo.U_@CustomFormatCode_drvTbl_Member WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK) ON eepEEID = EEID
    LEFT JOIN dbo.U_@CustomFormatCode_States WITH (NOLOCK) ON EepAddressState = StaAbbr
    WHERE ISNULL(TermDt,'') = '';

    -----------
    -- Build PersonLink Table
    -----------

    IF object_id('U_@CustomFormatCode_drvTbl_PersonLink') IS NOT NULL DROP TABLE dbo.U_@CustomFormatCode_drvTbl_PersonLink;

    SELECT DISTINCT 

     EEID
    ,COID
    ,PersonLinkTypeCd = CASE WHEN ConRelationship IN ('@SpouseRelationshipCodes') THEN '2' ELSE '3' END
    ,FirstNm          = dbo.dsi_fnRemoveChars('()_1234567890',ConNameFirst)
    ,LastNm           = dbo.dsi_fnRemoveChars('()_1234567890',ConNameLast)
    ,BirthDt          = CONVERT(VARCHAR(10),ConDateOfBirth,121)
    ,GenderCd         = CASE ConGender WHEN 'M' THEN '1' WHEN 'F' THEN '2' END
    ,InSchoolFlg      = CASE WHEN ConIsStudent = 'Y' AND DATEDIFF(dd,ConDateOfBirth,GETDATE())/365.25 BETWEEN 21 and 26 THEN 'True' ELSE 'False' END
    ,EffectiveDt      = (SELECT CONVERT(VARCHAR(10),MIN(BdmBenStartDate),121) FROM dbo.U_dsi_bdm_@CustomFormatCode WHERE BdmDepRecID = ConSystemID)
    ,TermDt           = CASE WHEN NOT EXISTS (SELECT 1 FROM dbo.U_dsi_bdm_@CustomFormatCode WHERE ISNULL(BdmBenStopDate,'') = '' AND BdmDepRecID = ConSystemID)
                                 THEN (SELECT CONVERT(VARCHAR(10),MAX(BdmBenStopDate),121) FROM dbo.U_dsi_bdm_@CustomFormatCode WHERE BdmDepRecID = ConSystemID)
                        END
    ,TermReasonCd
    ,StatusCd         = CASE WHEN NOT EXISTS (SELECT 1 FROM dbo.U_dsi_bdm_@CustomFormatCode WHERE ISNULL(BdmBenStopDate,'') = '' AND BdmDepRecID = ConSystemID)
                                 AND EXISTS (SELECT 1 FROM dbo.U_dsi_bdm_@CustomFormatCode WHERE ISNULL(BdmBenStopDate,'') <> '' AND BdmDepRecID = ConSystemID)
                                 THEN '3'
                             ELSE '1'
                        END
    ,OldFirstNm       = (SELECT AudOldValue FROM dbo.U_Dsi_drvTbl_@CustomFormatCode_Audit WHERE ConSystemID = AudKey2Value AND AudFieldName = 'ConNameFirst')

    INTO dbo.U_@CustomFormatCode_drvTbl_PersonLink
    FROM dbo.U_@CustomFormatCode_drvTbl_Member WITH (NOLOCK)
    JOIN dbo.Contacts WITH (NOLOCK) ON ConEEID = EEID AND ConIsDependent = 'Y' AND ConRelationship IN ('@ChildRelationshipCodes','@SpouseRelationshipCodes')
    WHERE ISNULL(TermDt,'') = '';

    -----------
    -- Build Benefits Table
    -----------

    IF object_id('U_@CustomFormatCode_drvTbl_Benefits') IS NOT NULL DROP TABLE dbo.U_@CustomFormatCode_drvTbl_Benefits;

    SELECT DISTINCT 

     EEID
    ,COID
    ,BenefitType  = CASE WHEN BdmDedType = 'DEN' THEN '502'
                         WHEN BdmDedType = 'MED' THEN '512'
                    END
    ,FlexCodeNm   = 'A'
    ,DepTypeCd    = CASE WHEN BdmBenOption IN ('@FamilyBenOption') THEN '3'
                         WHEN BdmBenOption IN ('@EEOnlyBenOption') THEN '2' 
                    END
    ,EffectiveDt  = NULL
    ,StatusCd     = CASE WHEN ISNULL(BdmBenStopDate,'') <> '' THEN '3' ELSE '1' END
    ,TermReasonCd = CASE WHEN NOT EXISTS (SELECT 1 FROM dbo.U_dsi_bdm_@CustomFormatCode WHERE ISNULL(BdmBenStopDate,'') = '' AND BdmEEID = EEID AND BdmCOID = COID)
                             AND EXISTS (SELECT 1 FROM dbo.U_dsi_bdm_@CustomFormatCode WHERE ISNULL(BdmBenStopDate,'') <> '' AND BdmEEID = EEID AND BdmCOID = COID)
                             THEN '2'
                    END
    ,TermDt       = CONVERT(VARCHAR(10),BdmBenStopDate,121)

    INTO dbo.U_@CustomFormatCode_drvTbl_Benefits
    FROM dbo.U_@CustomFormatCode_drvTbl_Member WITH (NOLOCK)
    JOIN dbo.U_dsi_bdm_@CustomFormatCode WITH (NOLOCK) ON BdmEEID = EEID AND BdmCOID = COID AND BdmRecType = 'Emp'
    WHERE ISNULL(TermDt,'') = '';

    -----------------------
    -- Remove invalid punctuation and trim fields
    -----------------------

    DECLARE @SQL       NVARCHAR(4000)       
    DECLARE @FieldName NVARCHAR(100) 
    DECLARE @TableName NVARCHAR(100) 
    DECLARE @BadChars  NVARCHAR(100)  

    SET @SQL       = ''
    SET @FieldName = ''
    SET @TableName = ''
    SET @BadChars  = '=&;:<>=+#'

    DECLARE DelimCursor CURSOR FAST_FORWARD FOR

        SELECT DISTINCT COLUMN_NAME,TABLE_NAME
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME IN ('U_@CustomFormatCode_drvTbl_Member','U_@CustomFormatCode_drvTbl_Person','U_@CustomFormatCode_drvTbl_Salary',
                              'U_@CustomFormatCode_drvTbl_Address','U_@CustomFormatCode_drvTbl_PersonLink','U_@CustomFormatCode_drvTbl_Benefits')
        ORDER BY TABLE_NAME, COLUMN_NAME

    OPEN DelimCursor
    FETCH NEXT FROM DelimCursor INTO @FieldName, @TableName

    WHILE @@FETCH_STATUS <> -1

    BEGIN

        SET @SQL = 'Update ' + LTRIM(RTRIM(@TableName)) + 
                  ' SET ' + @FieldName + ' = LTRIM(RTRIM(dbo.dsi_fnRemoveChars('''+@BadChars+''','+@FieldName+')))';
        EXECUTE sp_executesql @SQL;
        SET @SQL = '';

        FETCH NEXT FROM DelimCursor INTO @FieldName, @TableName;

    END 

    CLOSE DelimCursor
    DEALLOCATE DelimCursor;

    -----------------------
    -- Build XML / Load For Custom BCP
    -----------------------

    -- Create Table for BCP Export
    IF OBJECT_ID('U_@CustomFormatCode_XML') IS NOT NULL DROP TABLE dbo.U_@CustomFormatCode_XML;

    CREATE TABLE dbo.U_@CustomFormatCode_XML (XMLOUT XML);

    DECLARE @XML    XML;
    DECLARE @XMLOUT VARCHAR(MAX);

    SELECT @XML = (SELECT * 
                   FROM dbo.dsi_vw@CustomFormatCode_XML 
                   ORDER BY [Member!1!CertificateNum] 
                   FOR XML EXPLICIT);

    -- Addd Header/Footer ("Loader") Records
    SELECT @XMLOUT = (SELECT 
                       "@PolicyNum" = '@PolicyNum'
                      ,"@ClientName" = '@ClientName'
                      ,"@ReportLanguageCd" = '1'
                      ,@XML
                     FOR XML PATH('Loader'));

    -- Load Into Custom Table for AfterCollect BCP
    INSERT INTO dbo.U_@CustomFormatCode_XML (XMLOUT)
    VALUES (@XMLOUT);

    -----------------------
    -- Update Record Count
    -----------------------
    UPDATE dbo.U_dsi_Configuration
    SET CfgValue = ISNULL((SELECT COUNT(*) FROM dbo.U_@CustomFormatCode_drvTbl_Member WITH (NOLOCK)),'0')
    WHERE FormatCode = '@CustomFormatCode' AND CfgName = 'OverrideCount';

    -----------------------
    -- Update filename
    -----------------------
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
        SET ExportFile = '@FileNamePrefix' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
        WHERE FormatCode = @FormatCode;
    END;

END
GO
CREATE VIEW dbo.dsi_vw@CustomFormatCode_Export AS
    SELECT TOP 200000000 DATA FROM dbo.U_@CustomFormatCode_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2),InitialSort;
GO
CREATE VIEW [dbo].[dsi_vw@CustomFormatCode_XML] AS

    ----------------------------------------------------
    -- Set up XML Structure and Insert Member Record
    ----------------------------------------------------

    SELECT DISTINCT

         Tag = 1
        ,Parent = NULL

        -------------------
        -- Member Record
        -------------------
        ,[Member!1!PolicyNum] = PolicyNum
        ,[Member!1!LocationNum] = LocationNum
        ,[Member!1!ClassNum] = ClassNum
        ,[Member!1!PlanNum] = PlanNum
        ,[Member!1!CertificateNum] = CertificateNum
        ,[Member!1!EmploymentDt] = EmploymentDt
        ,[Member!1!WorkResidenceCd] = WorkResidenceCd
        ,[Member!1!StatusCd] = StatusCd
        ,[Member!1!TermDt] = TermDt
        ,[Member!1!TermReasonCd] = TermReasonCd
        ,[Member!1!UpdateFlag] = UpdateFlag
        ,[Member!1!ApplyDate] = ApplyDate
        ,[Member!1!TransferFlg] = NULLIF(TransferFlg,'')
        ,[Member!1!ReinstatementFlag] = ReinstatementFlag

        -------------------
        -- Person Record
        -------------------
        ,[Person!2!FirstNm] = NULL
        ,[Person!2!LastNm] = NULL
        ,[Person!2!BirthDt] = NULL
        ,[Person!2!ResidenceCd] = NULL
        ,[Person!2!GenderCd] = NULL
        ,[Person!2!DepTypeCd] = NULL
        ,[Person!2!LanguageCd] = NULL

        -------------------
        -- Salary Record
        -------------------
        ,[Salary!3!SalaryDescCd] = NULL
        ,[Salary!3!SalaryBasisCd] = NULL
        ,[Salary!3!SalaryAmt] = NULL
        ,[Salary!3!HoursPerWeekAmt] = NULL

        -------------------
        -- Address Record
        -------------------
        ,[Address!4!AddressTypeCd] = NULL
        ,[Address!4!AddressNm] = NULL
        ,[Address!4!StreetAddressNm] = NULL
        ,[Address!4!SuiteNm] = NULL
        ,[Address!4!CityNm] = NULL
        ,[Address!4!StateOrProvCd] = NULL
        ,[Address!4!PostalNum] = NULL
        ,[Address!4!CountryCd] = NULL
        ,[Address!4!EmailAddressNm] = NULL
        ,[Address!4!Phone1Num] = NULL

        ------------------------
        -- PersonLink Record
        ------------------------
        ,[PersonLink!5!PersonLinkTypeCd] = NULL
        ,[PersonLink!5!FirstNm] = NULL
        ,[PersonLink!5!LastNm] = NULL
        ,[PersonLink!5!BirthDt] = NULL
        ,[PersonLink!5!GenderCd] = NULL
        ,[PersonLink!5!InSchoolFlg] = NULL
        ,[PersonLink!5!EffectiveDt] = NULL
        ,[PersonLink!5!TermDt] = NULL
        ,[PersonLink!5!TermReasonCd] = NULL
        ,[PersonLink!5!StatusCd] = NULL
        ,[PersonLink!5!OldFirstNm] = NULL

        ------------------------
        -- Benefits Record
        ------------------------
        ,[Benefits!6!BenefitType] = NULL
        ,[Benefits!6!FlexCodeNm] = NULL
        ,[Benefits!6!DepTypeCd] = NULL
        ,[Benefits!6!EffectiveDt] = NULL
        ,[Benefits!6!StatusCd] = NULL
        ,[Benefits!6!TermReasonCd] = NULL
        ,[Benefits!6!TermDt] = NULL

    FROM dbo.U_@CustomFormatCode_drvTbl_Member Member

    UNION ALL

    ----------------------------------------------------
    -- Insert Person Record
    ----------------------------------------------------

    SELECT DISTINCT

         Tag = 2
        ,Parent = 1
        -- Member Record
        ,NULL,NULL,NULL,NULL,CertificateNum,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL
        -- Person Record
        ,FirstNm,LastNm,BirthDt,ResidenceCd,GenderCd,DepTypeCd,LanguageCd
        -- Salary Record
        ,NULL,NULL,NULL,NULL
        -- Address Record
        ,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL
        -- PersonLink Record
        ,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL
        -- Benefits Record
        ,NULL,NULL,NULL,NULL,NULL,NULL,NULL

    FROM dbo.U_@CustomFormatCode_drvTbl_Member Member,dbo.U_@CustomFormatCode_drvTbl_Person Person
    WHERE Member.EEID = Person.EEID AND Member.COID = Person.COID

    UNION ALL

    ----------------------------------------------------
    -- Insert Salary Record
    ----------------------------------------------------

    SELECT DISTINCT

         Tag = 3
        ,Parent = 1
        -- Member Record
        ,NULL,NULL,NULL,NULL,CertificateNum,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL
        -- Person Record
        ,NULL,NULL,NULL,NULL,NULL,NULL,NULL
        -- Salary Record
        ,SalaryDescCd,SalaryBasisCd,SalaryAmt,NULLIF(HoursPerWeekAmt,'')
        -- Address Record
        ,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL
        -- PersonLink Record
        ,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL
        -- Benefits Record
        ,NULL,NULL,NULL,NULL,NULL,NULL,NULL

    FROM dbo.U_@CustomFormatCode_drvTbl_Member Member,dbo.U_@CustomFormatCode_drvTbl_Salary Salary
    WHERE Member.EEID = Salary.EEID AND Member.COID = Salary.COID

    UNION ALL

    ----------------------------------------------------
    -- Insert Address Record
    ----------------------------------------------------

    SELECT DISTINCT

         Tag = 4
        ,Parent = 1
        -- Member Record
        ,NULL,NULL,NULL,NULL,CertificateNum,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL
        -- Person Record
        ,NULL,NULL,NULL,NULL,NULL,NULL,NULL
        -- Salary Record
        ,NULL,NULL,NULL,NULL
        -- Address Record
        ,AddressTypeCd,AddressNm,StreetAddressNm,SuiteNm,CityNm,StateOrProvCd,PostalNum,CountryCd,EmailAddressNm,Phone1Num
        -- PersonLink Record
        ,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL
        -- Benefits Record
        ,NULL,NULL,NULL,NULL,NULL,NULL,NULL

    FROM dbo.U_@CustomFormatCode_drvTbl_Member Member,dbo.U_@CustomFormatCode_drvTbl_Address Address
    WHERE Member.EEID = Address.EEID AND Member.COID = Address.COID

    UNION ALL

    ----------------------------------------------------
    -- Insert PersonLink Record
    ----------------------------------------------------

    SELECT DISTINCT

         Tag = 5
        ,Parent = 1
        -- Member Record
        ,NULL,NULL,NULL,NULL,CertificateNum,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL
        -- Person Record
        ,NULL,NULL,NULL,NULL,NULL,NULL,NULL
        -- Salary Record
        ,NULL,NULL,NULL,NULL
        -- Address Record
        ,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL
        -- PersonLink Record
        ,PersonLinkTypeCd,FirstNm,LastNm,BirthDt,GenderCd,InSchoolFlg,EffectiveDt,PersonLink.TermDt,PersonLink.TermReasonCd,PersonLink.StatusCd,OldFirstNm
        -- Benefits Record
        ,NULL,NULL,NULL,NULL,NULL,NULL,NULL

    FROM dbo.U_@CustomFormatCode_drvTbl_Member Member,dbo.U_@CustomFormatCode_drvTbl_PersonLink PersonLink
    WHERE Member.EEID = PersonLink.EEID AND Member.COID = PersonLink.COID

    UNION ALL

    ----------------------------------------------------
    -- Insert Benefits Record
    ----------------------------------------------------

    SELECT DISTINCT

         Tag = 6
        ,Parent = 1
        -- Member Record
        ,NULL,NULL,NULL,NULL,CertificateNum,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL
        -- Person Record
        ,NULL,NULL,NULL,NULL,NULL,NULL,NULL
        -- Salary Record
        ,NULL,NULL,NULL,NULL
        -- Address Record
        ,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL
        -- PersonLink Record
        ,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL
        -- Benefits Record
        ,BenefitType,FlexCodeNm,DepTypeCd,EffectiveDt,Benefits.StatusCd,Benefits.TermReasonCd,Benefits.TermDt

    FROM dbo.U_@CustomFormatCode_drvTbl_Member Member,dbo.U_@CustomFormatCode_drvTbl_Benefits Benefits
    WHERE Member.EEID = Benefits.EEID AND Member.COID = Benefits.COID

GO