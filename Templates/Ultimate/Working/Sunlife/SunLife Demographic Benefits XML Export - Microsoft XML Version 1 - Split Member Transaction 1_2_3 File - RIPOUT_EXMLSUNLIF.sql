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
@CustomFormatCode - Replace with Format Code (i.e., EXMLSUNLIF)
@CustomFormatName - Replace with Name of Interface (AdfFormatName) (i.e., SunLife Demographic Benefits XML Export)
@IsWebFlag - Replace with 'Y' (Yes) or 'N' (No) for Web Interface Settings

-- File parameters
@FileExportPath - Replace with the Export Path where the file generates to (i.e., \\us.saas\e1\Public\[Client ARNum]\Exports\Sunlife\)
@FileTestPath - Replace with the Test Path where the file generates to (i.e., \\us.saas\e1\Public\[Client ARNum]\Exports\Sunlife\)
@FileUDESPath - Replace with the UDES Path where the file generates to (i.e., \\us.saas\e0\data_exchange\[Client ARNum]\Exports\)

--Data Parameters
@DedCodeList - Replace with the Deduction Code List (Ex:MED,DEN,VIS,ADD,LIFE)
@PolicyNumber - Replace with the Sunlife Policy Number (Ex:'100000')
@MemberClientName - Replace with the Client Name in Member Record (Ex:'Client Name, LLC')
@FamilyBenOption - Replace with the Family Benefit Options List with single quotes and commas (Ex:'FAM')
@EEOnlyBenOption - Replace with the Employee Only Benefit Options List with single quotes and commas (Ex:'EE')
@SpouseRelationshipCodes - Replace with the Spouse Relationship Code List  with single quotes and commas (Ex:'SPS','DP')
@ChildRelationshipCodes - Replace with the Children Relationship Code List with single quotes and commas (Ex:'CHL','STC')

*/
SET NOCOUNT ON;
IF OBJECT_ID('dsi_vw@CustomFormatCode_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vw@CustomFormatCode_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_@CustomFormatCode') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_@CustomFormatCode];
GO
IF OBJECT_ID('dsi_sp_AfterCollect_@CustomFormatCode') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_AfterCollect_@CustomFormatCode];
GO
IF OBJECT_ID('U_@CustomFormatCode_XML') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_XML];
GO
IF OBJECT_ID('U_@CustomFormatCode_Members') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_Members];
GO
IF OBJECT_ID('U_@CustomFormatCode_File') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_File];
GO
IF OBJECT_ID('U_@CustomFormatCode_EEList') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_EEList];
GO
IF OBJECT_ID('U_@CustomFormatCode_DedCodes') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_DedCodes];
GO
IF OBJECT_ID('U_@CustomFormatCode_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_AuditFields];
GO
IF OBJECT_ID('U_@CustomFormatCode_Audit') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_@CustomFormatCode') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_@CustomFormatCode];
GO
IF OBJECT_ID('dbo.U_@CustomFormatCode_Provinces') IS NOT NULL DROP TABLE dbo.U_@CustomFormatCode_Provinces;
GO
IF OBJECT_ID('dsi_fn_@CustomFormatCode_Benefciaries','FN') IS NOT NULL DROP FUNCTION dbo.dsi_fn_@CustomFormatCode_Benefciaries;
GO
IF OBJECT_ID('dsi_fnlib_GetDedGroupCode_EffDate','FN') IS NOT NULL DROP FUNCTION dbo.dsi_fnlib_GetDedGroupCode_EffDate;
GO
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = '@CustomFormatCode';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = '@CustomFormatCode';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = '@CustomFormatCode';
GO

DECLARE @AdhSystemID VARCHAR(12), @FixedFormatName1 VARCHAR(50), @FixedFormatName2 VARCHAR(50);
SET @AdhSystemID = LEFT('@CustomFormatCode' + REPLICATE('0',10),10) + 'Z0';
SET @FixedFormatName1 = LEFT('@CustomFormatName',50);
SET @FixedFormatName2 = LEFT('@CustomFormatName',30);

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) SELECT 'N','C','Y','0',NULL,NULL,'N',NULL,'N',NULL,'013010','EMPEXPORT','CDE','@CustomFormatCode',@FixedFormatName1,'N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_SwitchBox_v2','1000','S','N',@AdhSystemID,'N',NULL,'C','N',NULL,'N';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Automated Schedule Only',CONVERT(CHAR(8),GETDATE(),112) + '9','EMPEXPORT','SCHEDULED','Oct  1 2018 12:00AM','@CustomFormatCode',NULL,NULL,NULL,CONVERT(CHAR(8),GETDATE(),112) + '9','Oct  1 2018 12:00AM','Dec 30 1899 12:00AM',CONVERT(CHAR(8),GETDATE(),112) + '1',NULL,'','',CONVERT(CHAR(8),GETDATE(),112) + '1',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'On Demand Session',CONVERT(CHAR(8),GETDATE(),112) + '9','EMPEXPORT','ONDEMAND','Oct  1 2018 12:00AM','@CustomFormatCode',NULL,NULL,NULL,CONVERT(CHAR(8),GETDATE(),112) + '9','Oct  1 2018 12:00AM','Dec 30 1899 12:00AM',CONVERT(CHAR(8),GETDATE(),112) + '1',NULL,'','',CONVERT(CHAR(8),GETDATE(),112) + '1',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Testing Purposes Only',CONVERT(CHAR(8),GETDATE(),112) + '9','EMPEXPORT','TEST','Oct  1 2018 12:00AM','@CustomFormatCode',NULL,NULL,NULL,CONVERT(CHAR(8),GETDATE(),112) + '9','Oct  1 2018 12:00AM','Dec 30 1899 12:00AM',CONVERT(CHAR(8),GETDATE(),112) + '1',NULL,'','',CONVERT(CHAR(8),GETDATE(),112) + '1',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Initial Full File for Baseline',CONVERT(CHAR(8),GETDATE(),112) + '9','EMPEXPORT','FULLFILE','Oct  1 2018 12:00AM','@CustomFormatCode',NULL,NULL,NULL,CONVERT(CHAR(8),GETDATE(),112) + '9','Oct  1 2018 12:00AM','Dec 30 1899 12:00AM',CONVERT(CHAR(8),GETDATE(),112) + '1',NULL,'','',CONVERT(CHAR(8),GETDATE(),112) + '1',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','ExportPath','V','@FileExportPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','MultFile','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','OverrideCount','V','710');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','Testing','V','N');
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
    [Data] char(1000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_AfterCollect_@CustomFormatCode]
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: @CustomerName

Created By: @DeveloperName
Create Date: @CreateDate
Service Request Number: @SRNumber

Interface Name: SunLife Demographic XML File Export

Purpose: Custom BCP Statement for XML Output

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/20XX     SR-20XX-000XXXXX   XXXXX

**********************************************************************************/
BEGIN

    --==========================================
    -- Declare variables
    --==========================================
    DECLARE @FormatCode       VARCHAR(10)
            ,@ExportCode      VARCHAR(10)
            ,@sCmd            VARCHAR(1000)
            ,@ExportPath      VARCHAR(500)
            ,@UTF8Path        VARCHAR(500)
            ,@FileName        VARCHAR(100)
            ,@sXML            VARCHAR(100)

    SET @FormatCode = '@CustomFormatCode';
    SET @ExportCode = (SELECT ExportCode FROM dbo.U_dsi_Parameters WITH (NOLOCK) WHERE FormatCode = @FormatCode);
    SET @FileName = (SELECT ExportFile FROM dbo.U_dsi_Parameters WITH (NOLOCK) WHERE FormatCode = @FormatCode);
    SET @ExportPath = CASE WHEN @ExportCode = 'TEST' OR dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN dbo.dsi_fnVariable(@FormatCode,'TestPath')
                           ELSE dbo.dsi_fnVariable(@FormatCode,'ExportPath')
                      END;

    --=====================================
    -- Generate XML File via Custom BCP
    --=====================================
    SET @sXML = '<?xml version=""1.0"" encoding=""ISO-8859-1""?>';

    SELECT @sCmd = 'BCP "SELECT ''' + @sXML + ''' + CONVERT(NVARCHAR(MAX),XMLOUT) FROM ' + RTRIM(DB_NAME()) + '.dbo.U_@CustomFormatCode_XML WITH (NOLOCK) " QUERYOUT "'
                    + @ExportPath + @FileName + '" -S"' + RTRIM(@@SERVERNAME) + '" -T -c -t -C1252' --Code Page 1252 (ISO-8859-1)

    EXEC master.dbo.xp_cmdshell @sCmd, NO_OUTPUT

END
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_@CustomFormatCode]
    @systemid CHAR(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: @CustomerName

Created By: @DeveloperName
Integration Analyst: @IntegrationAnalystName
Create Date: @CreateDate
Service Request Number: @SRNumber

Purpose: SunLife Demographic XML File Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/20XX     SR-20XX-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.AscExp WHERE expFormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = '@CustomFormatCode' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'TEST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'FULLFILE'; --Full File for 'Baseline' at Go Live
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'SCHEDULED';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = '@CustomFormatCode', @AllObjects = 'Y', @IsWeb = 'N';
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
    SELECT @FormatCode = '@CustomFormatCode';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl  = StartPerControl
        ,@EndPerControl    = EndPerControl
        ,@StartDate        = CAST(LEFT(StartPerControl,8) AS DATETIME)
        ,@EndDate          = DATEADD(SS,-1,DATEADD(DD,1,LEFT(EndPerControl,8)))
        ,@FormatCode       = FormatCode
        ,@ExportCode       = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Create Deduction Code List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '@DedCodeList';

    IF OBJECT_ID('U_@CustomFormatCode_DedCodes','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_DedCodes;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_@CustomFormatCode_DedCodes
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

    --==========================================
    -- Audit Section
    --==========================================

    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_@CustomFormatCode_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_AuditFields;
    CREATE TABLE dbo.U_@CustomFormatCode_AuditFields (aTableName VARCHAR(50), aFieldName VARCHAR(50));
    CREATE CLUSTERED INDEX CDX_U_@CustomFormatCode_AuditFields ON dbo.U_@CustomFormatCode_AuditFields (aTableName, aFieldName);
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpComp','EecEmplStatus');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpComp','EecDedGroupCode');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpComp','EecUnionLocal');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpComp','EecUnionNational');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpComp','EecEEType');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpComp','EecStateSUI');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpComp','EecCOID');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpComp','EecEEType');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpComp','EecFullTimeOrPartTime');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpComp','EecSalaryOrHourly');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpComp','EecLocation');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpComp','EecDateOfRetirement');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpComp','EecAnnSalary');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpPers','EepDateOfBirth');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpDed','EedBenStartDate');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpDed','EedStartDate')
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpDed','EedBenStopDate');;
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpDed','EedStopDate');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpDed','EedDedCode');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpDed','EedBenStatus');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpDed','EedBenOption');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('DepBPlan','DbnBenStartDate');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('DepBPlan','DbnBenStopDate');;
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('DepBPlan','DbnDedCode');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('DepBPlan','DbnBenStatus');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('Contacts','ConNameFirst');

    -------------------------------------------------------
    -- Populate audit table based on fields defined above
    -------------------------------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_Audit;
    SELECT DISTINCT
         audEEID = audKey1Value
        ,audCOID = CASE WHEN audTableName IN ('EmpComp','EmpDed') THEN audKey2Value
                        ELSE [dbo].[dsi_BDM_fn_GetCurrentCOID] (audKey1Value)
                    END
        ,audKey1 = audKey1Value
        ,audKey2 = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue = CONVERT(NVARCHAR(2000),audOldValue)
        ,audNewValue = CONVERT(NVARCHAR(2000),audNewValue)
        ,audEffectiveDate
        ,audChangeType = CASE WHEN audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = '' AND ISNULL(audNewValue,'') = 'A' THEN 'NewHire'
                              WHEN audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = 'T' AND ISNULL(audNewValue,'') = 'A' THEN 'Rehire'
                              WHEN audFieldName = 'EecEmplStatus' AND ISNULL(audNewValue,'') = 'T' THEN 'Term'
                              WHEN audFieldName = 'EecDedGroupCode' AND ISNULL(audNewValue,'NONE') = 'NONE' THEN 'Term'
                              WHEN audTableName IN ('EmpDed','DepBPlan') THEN
                                CASE WHEN ISNULL(audOldValue,'') = '' AND ISNULL(audNewValue,'') <> '' THEN 'BenefitsAdd'
                                     WHEN audFieldName IN ('EedBenStatus','DbnBenStatus') AND ISNULL(audNewValue,'') = 'T' THEN 'BenefitsTerm'
                                     WHEN audFieldName IN ('EedBenStopDate','EedStopDate','DbnBenStopDate') AND ISNULL(audNewValue,'') <> '' THEN 'BenefitsTerm'
                                     ELSE 'BenefitsChange'
                                END
                              WHEN audFieldName = 'EecDedGroupCode' AND ISNULL(audOldValue,'NONE') = 'NONE' AND ISNULL(audNewValue,'NONE') <> 'NONE' THEN 'DedGroup'
                              WHEN audFieldName IN ('EecUnionLocal','EecEEType','EecDedGroupCode','EecStateSUI','EecCOID','EecEEType','EecFullTimeOrPartTime','EecSalaryOrHourly','EecLocation','EepDateOfBirth','EecDateOfRetirement') THEN 'Transfer'
                              WHEN audFieldName = 'EecAnnSalary' AND ISNULL(audOldValue,'') <> ISNULL(audNewValue,'') THEN 'SalaryChange'
                              ELSE ''
                        END
        ,audBenStartDate = CASE WHEN audFieldName IN ('EedBenStartDate','DbnBenStartDate') THEN audNewValue END
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    INTO dbo.U_@CustomFormatCode_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK)
    JOIN dbo.U_@CustomFormatCode_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE'
    AND ((audTableName NOT IN ('EmpDed','DepBPlan'))
        OR (audTableName = 'EmpDed'
            AND EXISTS (SELECT 1 FROM dbo.DedCode WHERE DedDedCode = audKey3Value AND DedDedCode IN (SELECT DedCode FROM dbo.U_@CustomFormatCode_DedCodes))
        )
        OR (audTableName = 'DepBPlan'
            AND EXISTS (SELECT 1 FROM dbo.DedCode WHERE DedDedCode = audKey2Value AND DedDedCode IN (SELECT DedCode FROM dbo.U_@CustomFormatCode_DedCodes))
        )
    );

    --==========================================
    -- Clean EE List
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_@CustomFormatCode_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCoID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_@CustomFormatCode_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'DedCodes',@DedList);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'TermSelectionOption','AuditDate');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');

    -- Non-Required parameters
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'SkipAgeGradedRateCalcRule',@DedList); --Include Deduction Codes using Calc Rule: 'Benefit Age Graded * Rate'

    -- Run BDM for NPM
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    -- Run BCA Calc Add-On
    EXEC dbo.dsi_bdm_sp_CalculateBenefitAmounts @FormatCode;

    --===========================================
    -- Update User-Defined Fields in BDM Table
    --===========================================
    
    --Set BdmUSGDate1 with 'BenefitsApplyDate' based on MAX Value between BdmBenStartDate, BdmBenStatusDate, BdmBenStopDate
    UPDATE dbo.U_dsi_BDM_@CustomFormatCode
    SET BdmUSGDate1 = dbo.dsi_fnGetMinMaxDates('MAX',dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate,BdmBenStopDate),BdmBenStatusDate);

    -- Set BdmUSGField1 with Plan Status (Active/Termed) based on Benefit Status and Coverage Stop Date
    UPDATE dbo.U_dsi_BDM_@CustomFormatCode
    SET BdmUSGField1 = CASE WHEN (BdmBenStatus <> 'A' OR BdmBenStopDate IS NOT NULL) THEN 'Termed'
                            ELSE 'Active'
                       END;

    -- Set BdmUSGField2 with Audit Change Type Value
    UPDATE dbo.U_dsi_BDM_@CustomFormatCode
    SET BdmUSGField2 = (SELECT MAX(audChangeType) FROM dbo.U_@CustomFormatCode_Audit WHERE audEEID = BdmEEID AND audCOID = BdmCOID AND audKey3 = BdmDedCode AND audChangeType LIKE 'Benefits%');

    --==========================================
    -- Build Working Tables
    --==========================================
    -----------------------------
    -- Detail Record - All Members
    -----------------------------
    IF OBJECT_ID('U_@CustomFormatCode_Members','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_Members;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCOID
        ,drvInitialSort = LTRIM(RTRIM(EecEmpNo))
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,EepNameFirst = dbo.dsi_fnRemoveChars('=&;:<>+()_1234567890',LTRIM(RTRIM(EepNameFirst)))
        ,EepNameLast = dbo.dsi_fnRemoveChars('=&;:<>+()_1234567890',LTRIM(RTRIM(EepNameLast)))
        ,EepDateOfBirth
        ,EepAddressLine1 = dbo.dsi_fnRemoveChars('=&;:<>+#',LTRIM(RTRIM(EepAddressLine1)))
        ,EepAddressLine2 = dbo.dsi_fnRemoveChars('=&;:<>+#',LTRIM(RTRIM(EepAddressLine2)))
        ,EepAddressCity = dbo.dsi_fnRemoveChars('=&;:<>+#',LTRIM(RTRIM(EepAddressCity)))
        ,EepAddressState = dbo.dsi_fnRemoveChars('=&;:<>+#',LTRIM(RTRIM(EepAddressState)))
        ,EepAddressZipCode = CASE WHEN EepAddressCountry = 'CAN' THEN STUFF(LTRIM(RTRIM(EepAddressZipCode)),4,0,SPACE(1))
                                  ELSE LEFT(LTRIM(RTRIM(EepAddressZipCode)),5)
                             END
        ,EepAddressCountry = dbo.dsi_fnRemoveChars('=&;:<>+#',LTRIM(RTRIM(EepAddressCountry)))
        ,EepGender = dbo.dsi_fnRemoveChars('=&;:<>+#',LTRIM(RTRIM(EepGender)))
        ,EepIsSmoker = dbo.dsi_fnRemoveChars('=&;:<>+#',LTRIM(RTRIM(EepIsSmoker)))
        ,EepAddressEMail = dbo.dsi_fnRemoveChars('=&;:<>+',LTRIM(RTRIM(EepAddressEMail)))
        ,EecEmpNo = LTRIM(RTRIM(EecEmpNo))
        ,EecEmplStatus = LTRIM(RTRIM(EecEmplStatus))
        ,EecDateOfOriginalHire
        ,EecDateOfLastHire
        ,EecDateOfTermination = CASE WHEN BdmUSGField1 = 'Termed' THEN COALESCE(EecDateOfTermination,dbo.dsi_fnlib_GetDedGroupCode_EffDate(xEEID, xCOID))
                                END
        ,EecJobChangeReason = dbo.dsi_fnRemoveChars('=&;:<>+#',LTRIM(RTRIM(EecJobChangeReason)))
        ,EecStateSUI = dbo.dsi_fnRemoveChars('=&;:<>+#',LTRIM(RTRIM(EecStateSUI)))
        ,EecDedGroupCode = dbo.dsi_fnRemoveChars('=&;:<>+#',LTRIM(RTRIM(EecDedGroupCode)))
        ,EecLanguageCode = dbo.dsi_fnRemoveChars('=&;:<>+#',LTRIM(RTRIM(EecLanguageCode)))
        ,EecAnnSalary = CONVERT(DECIMAL(10,2),EecAnnSalary)
        ,EecLeaveReason = dbo.dsi_fnRemoveChars('=&;:<>+#',LTRIM(RTRIM(EecLeaveReason)))
        ,OrgGLSegment = dbo.dsi_fnRemoveChars('=&;:<>+#',LTRIM(RTRIM(O4.OrgGLSegment)))
        ,SalaryEffDate
        ,TransferEffDate
        ,EecEEType
        ,EecUnionLocal
        ,CmpCompanyCode
        ,EecFullTimeOrPartTime
        -- Audit Fields
        ,audChangeType
        ,audBenStartDate
        -- Bdm Fields
        ,BdmUSGDate1
        ,BdmUSGField1
        ,BdmUSGField2
        ,BdmActive
        -- Translations/Mappings for All Members
        ,LocationNum = '001'
        ,ClassNum = '1'
        ,PlanNum = '1'
        ,EmploymentDt = CASE WHEN ISNULL(audChangeType,'') = 'NewHire' AND EecJobChangeReason = '100' THEN EecDateOfOriginalHire END
        ,WorkResidenceCd = PrvCode
        ,Beneficiary = dbo.dsi_fn_@CustomFormatCode_Benefciaries(xEEID)
        ,StatusCd = CASE WHEN (audChangeType = 'Term' OR EecEmplStatus = 'T') THEN '3'
                    END
        ,TermReasonCd = CASE WHEN (audChangeType = 'Term' OR EecEmplStatus = 'T') THEN
                                CASE WHEN EecTermReason IN ('203','208') THEN '6' --Deceased
                                     ELSE '2' --Termination
                                END
                        END
        ,UpdateFlag = CASE WHEN EecDateOfLastHire <> EecDateOfOriginalHire AND EecHireSource = 'REHIRE' THEN 'True'
                           WHEN ISNULL(audChangeType,'') = 'DedGroup' THEN 'False'
                           ELSE 'True'
                      END
        ,ApplyDate = CASE WHEN ISNULL(audChangeType,'') = 'BenefitsAdd' THEN COALESCE((SELECT MAX(BdmBenStartDate) FROM dbo.U_dsi_BDM_@CustomFormatCode WHERE BdmEEID = xEEID AND BdmCOID = xCOID),GETDATE())
                          WHEN ISNULL(audChangeType,'') = 'Rehire' THEN COALESCE(EecDateOfLastHire,GETDATE())
                          WHEN ISNULL(audChangeType,'') = 'Term' AND ((EecEEType <> 'RET') OR (EecEEType = 'RET' AND ISNULL(BdmActive,'N') = 'Y')) THEN COALESCE(EecDateOfTermination,GETDATE())
                          WHEN TransferEffDate IS NOT NULL AND TransferEffDate BETWEEN @StartDate AND @EndDate THEN COALESCE(TransferEffDate,GETDATE())
                          ELSE GETDATE()
                    END
        ,BenefitsApplyDate = (SELECT MAX(BdmUSGDate1) FROM dbo.U_dsi_BDM_@CustomFormatCode WHERE BdmEEID = xEEID AND BdmCOID = xCOID)
        ,TransferFlg = CASE WHEN TransferEffDate IS NOT NULL AND TransferEffDate BETWEEN @StartDate AND @EndDate THEN 'True'
                            ELSE 'False'
                       END
        ,ReinstatementFlg = CASE WHEN EecDateOfLastHire <> EecDateOfOriginalHire AND EecHireSource = 'REHIRE' THEN 'True'
                                 ELSE 'False'
                            END
        --Detail Record – Person Mappings
        ,ResidenceCd = PrvCode
        ,GenderCd = CASE EepGender
                         WHEN 'M' THEN '1'
                         WHEN 'F' THEN '2'
                    END
        ,SmokerFlg = CASE WHEN EepIsSmoker = 'Y' THEN 'True'
                          ELSE 'False'
                     END
        ,DepTypeCd = CASE WHEN EXISTS (SELECT 1 FROM dbo.U_dsi_BDM_@CustomFormatCode WHERE BdmEEID = xEEID AND BdmRecType = 'DEP') THEN '3'
                          ELSE '2'
                     END
        ,LanguageCd = CASE WHEN EecLanguageCode = 'FR' THEN '2'
                           ELSE '1'
                      END
        ,StateOrProvCd = PrvCode
        ,CountryCd = CASE EepAddressCountry
                          WHEN 'CAN' THEN '1'
                          WHEN 'USA' THEN '2'
                     END
    INTO dbo.U_@CustomFormatCode_Members
    FROM dbo.U_@CustomFormatCode_EEList
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON eepEEID = xEEID
    JOIN dbo.Company WITH (NOLOCK)
        ON CmpCOID = xCOID
    JOIN (-- Get Benefits UD Field Data
        SELECT DISTINCT BdmEEID
            ,BdmCOID
            ,BdmUSGDate1 = MAX(CASE WHEN BdmRecType = 'EMP' THEN BdmUSGDate1 END)
            ,BdmUSGField1 = MAX(CASE WHEN BdmRecType = 'EMP' THEN BdmUSGField1 END)
            ,BdmUSGField2 = MAX(CASE WHEN BdmRecType = 'EMP' THEN BdmUSGField2 END)
            ,BdmActive = MAX(CASE WHEN BdmUSGField1 = 'Active' THEN 'Y' ELSE 'N' END)
        FROM dbo.U_dsi_BDM_@CustomFormatCode
        GROUP BY BdmEEID, BdmCOID
    ) BdmRecords
        ON BdmEEID = xEEID
        AND BdmCOID = xCOID
    LEFT JOIN dbo.OrgLevel O4 WITH (NOLOCK)
        ON O4.OrgCode = EecOrgLvl4
        AND O4.OrgLvl = '4'
    LEFT JOIN dbo.U_@CustomFormatCode_Provinces
        ON PrvAbbr = EepAddressState
    LEFT JOIN ( -- Salary Rate Change Date / Transfer Change Date
        SELECT DISTINCT EjhEEID
            ,SalaryEffDate = MAX(CASE WHEN EjhIsRateChange = 'Y' THEN EjhJobEffDate END)
            ,TransferEffDate = MAX(CASE WHEN EjhIsTransfer = 'Y' THEN EjhJobEffDate END)
        FROM dbo.EmpHJob
        WHERE (EjhIsRateChange = 'Y' OR EjhIsTransfer = 'Y')
        GROUP BY EjhEEID
    ) EmpHJob
        ON EjhEEID = xEEID
    LEFT JOIN (-- Get Audit Change Type and Benefit Start Date
        SELECT DISTINCT audEEID
            ,audCOID
            ,audChangeType = MAX(audChangeType)
            ,audBenStartDate = MAX(audBenStartDate)
        FROM dbo.U_@CustomFormatCode_Audit
        WHERE audRowNo = 1
        GROUP BY audEEID, audCOID
    ) AuditData
        ON audEEID = xEEID
        AND audCOID = xCOID
    WHERE ((EecEmplStatus <> 'T')
        OR ((audChangeType = 'Term' OR EecEmplStatus = 'T') AND (BdmUSGField1 IS NOT NULL AND BdmUSGField1 <> 'Active'))
    );

    --==================================
    -- Build XML / Load For Custom BCP
    --==================================

    --------------------------------
    -- Create Table for BCP Export
    --------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_XML','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_XML;
    CREATE TABLE dbo.U_@CustomFormatCode_XML (
        XMLOUT XML
    );

    ------------------
    -- Build XML
    ------------------
    DECLARE @XML XML, @XMLOUT VARCHAR(MAX);

    SELECT @XML = (
        /***** Path Node Name: "Loader" *****/
        SELECT
             "@PolicyNum"='@PolicyNumber'
            ,"@ClientName"='@MemberClientName'
            ,"@ReportLanguageCd"='1'
            ,( /***** Transaction# 1 - Employee Information - Parent Node Name: "Member" *****/
                SELECT
                     "@PolicyNum"='@PolicyNumber'
                    ,"@LocationNum"=LocationNum
                    ,"@ClassNum"=ClassNum
                    ,"@PlanNum"=PlanNum
                    ,"@CertificateNum"=CONVERT(VARCHAR(10),CONVERT(INT,EecEmpNo))
                    ,"@PayrollNum"=''
                    ,"@EmploymentDt"=CONVERT(VARCHAR(10),EmploymentDt,120)
                    ,"@WorkResidenceCd"=WorkResidenceCd
                    ,"@Beneficiary"=Beneficiary
                    ,"@AltBillSort5"=OrgGLSegment
                    ,"@AltBillSort6"=''
                    ,"@AltBillSort7"=''
                    ,"@StatusCd"=StatusCd
                    ,"@TermDt"=CONVERT(VARCHAR(10),EecDateOfTermination,120)
                    ,"@TermReasonCd"=TermReasonCd
                    ,"@UpdateFlag"=UpdateFlag
                    ,"@ApplyDate"=CONVERT(VARCHAR(10),ApplyDate,120)
                    ,"@TransferFlg"=TransferFlg
                    ,"@ReinstatementFlg"=ReinstatementFlg
                    /***** Child Node Name: "Person" of Parent Node Name: "Member" *****/
                    ,"Person/@FirstNm"=EepNameFirst
                    ,"Person/@LastNm"=EepNameLast
                    ,"Person/@BirthDt"=CONVERT(VARCHAR(10),EepDateOfBirth,120)
                    ,"Person/@ResidenceCd"=ResidenceCd
                    ,"Person/@GenderCd"=GenderCd
                    ,"Person/@SmokerFlg"=SmokerFlg
                    ,"Person/@DepTypeCd"=DepTypeCd
                    ,"Person/@LanguageCd"=LanguageCd
                    /***** Child Node Name: "Address" of Parent Node Name: "Member" *****/
                    ,"Address/@AddressTypeCd"='1'
                    ,"Address/@AddressNm"=ISNULL(EepNameFirst,'') + SPACE(1) + ISNULL(EepNameLast,'')
                    ,"Address/@StreetAddressNm"=EepAddressLine1
                    ,"Address/@SuiteNm"=EepAddressLine2
                    ,"Address/@CityNm"=EepAddressCity
                    ,"Address/@StateOrProvCd"=StateOrProvCd
                    ,"Address/@PostalNum"=EepAddressZipCode
                    ,"Address/@CountryCd"=CountryCd
                    ,"Address/@EmailAddressNm"=EepAddressEMail
                    ,( /***** Child Node Name: "PersonLink" of Parent Node Name: "Member" *****/
                        SELECT DISTINCT
                             "@PersonLinkTypeCd"=CASE WHEN ConRelationship IN (@SpouseRelationshipCodes) THEN '2'
                                                      WHEN ConRelationship IN (@ChildRelationshipCodes) THEN '3'
                                                 END
                            ,"@FirstNm"=dbo.dsi_fnRemoveChars('=&;:<>+()_1234567890',LTRIM(RTRIM(ConNameFirst)))
                            ,"@LastNm"=dbo.dsi_fnRemoveChars('=&;:<>+()_1234567890',LTRIM(RTRIM(ConNameLast)))
                            ,"@BirthDt"=CONVERT(VARCHAR(10),ConDateOfBirth,120)
                            ,"@GenderCd"=CASE ConGender
                                              WHEN 'M' THEN '1'
                                              WHEN 'F' THEN '2'
                                         END
                            ,"@SmokerFlg"=CASE ConIsSmoker
                                               WHEN 'Y' THEN 'True'
                                               WHEN 'N' THEN 'False'
                                          END
                            ,"@InSchoolFlg"=CASE WHEN ConIsStudent = 'Y' AND DATEDIFF(DAY,ConDateofBirth,GETDATE()) / 365.25 BETWEEN 21 AND 25 THEN 'True'
                                                 ELSE 'False'
                                            END
                            ,"@EffectiveDt"=CONVERT(VARCHAR(10),MIN(BdmBenStartDate),120)
                            ,"@TermDt"=MAX(CASE WHEN BdmUSGField1 = 'Termed' THEN CONVERT(VARCHAR(10),BdmBenStopDate,120) END)
                            ,"@TermReasonCd"=MAX(CASE WHEN BdmUSGField1 = 'Termed' THEN
                                                        CASE WHEN BdmChangeReason = '203' THEN '6'
                                                             ELSE '2'
                                                        END
                                             END)
                            ,"@StatusCd"=MAX(CASE WHEN BdmUSGField1 = 'Termed' THEN '3'
                                              ELSE '1'
                                         END)
                            ,"@OldFirstNm"=(SELECT dbo.dsi_fnRemoveChars('=&;:<>+()_1234567890',LTRIM(RTRIM(audOldValue))) FROM dbo.U_@CustomFormatCode_Audit WHERE audEEID = ConEEID AND audKey3 = ConSystemID AND audFieldName = 'ConNameFirst' AND audRowNo = 1)
                        FROM dbo.U_dsi_BDM_@CustomFormatCode
                        JOIN dbo.Contacts WITH (NOLOCK)
                            ON BdmDepRecID = ConSystemID
                        WHERE BdmRecType = 'DEP' AND ConEEID = E.DrvEEID
                        GROUP BY ConEEID, ConSystemID, ConRelationship, ConNameFirst, ConNameLast, ConDateOfBirth, ConGender, ConIsSmoker, ConIsStudent
                        FOR XML PATH('PersonLink'), TYPE
                    )
                FROM dbo.U_@CustomFormatCode_Members E
                FOR XML PATH('Member'), TYPE
            )
            ,( /***** Transaction# 2 - Salary Information - Parent Node Name: "Member" *****/
                SELECT
                     "@PolicyNum"='@PolicyNumber'
                    ,"@LocationNum"=LocationNum
                    ,"@ClassNum"=ClassNum
                    ,"@PlanNum"=PlanNum
                    ,"@CertificateNum"=CONVERT(VARCHAR(10),CONVERT(INT,EecEmpNo))
                    ,"@PayrollNum"=''
                    ,"@EmploymentDt"=CONVERT(VARCHAR(10),EmploymentDt,120)
                    ,"@WorkResidenceCd"=WorkResidenceCd
                    ,"@Beneficiary"=Beneficiary
                    ,"@AltBillSort5"=OrgGLSegment
                    ,"@AltBillSort6"=''
                    ,"@AltBillSort7"=''
                    ,"@UpdateFlag"='True'
                    ,"@ApplyDate"=CASE WHEN EecJobChangeReason IN ('100','101') THEN CONVERT(VARCHAR(10),EecDateOfLastHire,120)
                                       ELSE CONVERT(VARCHAR(10),COALESCE(SalaryEffDate,GETDATE()),120)
                                  END
                    ,"@TransferFlg"='False'
                    /***** Child Node Name: "Salary" of Parent Node Name: "Member" *****/
                    ,"Salary/@SalaryDescCd"='1'
                    ,"Salary/@SalaryBasisCd"='1'
                    ,"Salary/@SalaryAmt"=EecAnnSalary
                FROM dbo.U_@CustomFormatCode_Members E
                WHERE ((@ExportCode = 'FULLFILE')
                    OR (@ExportCode <> 'FULLFILE'
                        AND audChangeType IN ('SalaryChange','NewHire','Rehire') 
                        AND EecEmplStatus <> 'T'
                    )
                )
                FOR XML PATH('Member'), TYPE
            )
            ,( /***** Transaction# 3 - Benefit Information - Parent Node Name: "Member" *****/
                SELECT
                     "@PolicyNum"='@PolicyNumber'
                    ,"@LocationNum"=LocationNum
                    ,"@ClassNum"=ClassNum
                    ,"@PlanNum"=PlanNum
                    ,"@CertificateNum"=CONVERT(VARCHAR(10),CONVERT(INT,EecEmpNo))
                    ,"@PayrollNum"=''
                    ,"@EmploymentDt"=CONVERT(VARCHAR(10),EmploymentDt,120)
                    ,"@WorkResidenceCd"=WorkResidenceCd
                    ,"@Beneficiary"=Beneficiary
                    ,"@AltBillSort5"=OrgGLSegment
                    ,"@AltBillSort6"=''
                    ,"@AltBillSort7"=''
                    ,"@UpdateFlag"='True'
                    ,"@ApplyDate"=CONVERT(VARCHAR(10),BenefitsApplyDate,120)
                    ,"@TransferFlg"='False'
                    ,( /***** Child Node Name: "Benefits" of Parent Node Name: "Member" *****/
                        SELECT DISTINCT
                             "@BenefitType"=CASE WHEN BdmDedType = 'GTL' THEN '101' --Employee Life
                                                 WHEN BdmDedCode = 'DLIFE' THEN '103' --Dependent Life
                                                 WHEN BdmDedType = 'OPT' THEN '111' --Optional Employee Life
                                                 WHEN BdmDedType = 'OPS' THEN '114' --Optional Spousal Life
                                                 WHEN BdmDedType = 'OPC' THEN '115' --Optional Child Life
                                                 WHEN BdmDedType = 'ADD' THEN
                                                    CASE WHEN BdmDedCode = 'ADDOE' THEN '311' --Optional Employee AD&D
                                                         WHEN BdmDedCode = 'ADDOF' THEN '314' --Optional Spousal AD&D
                                                         WHEN BdmDedCode = 'ADDOC' THEN '315' --Optional Child AD&D
                                                         ELSE'301' --Employee AD&D
                                                    END
                                                 WHEN BdmDedType = 'STD' THEN '401' --Short Term Disability
                                                 WHEN BdmDedType = 'LTD' THEN '411' --Critical Illness / Long Term Disability
                                                 WHEN BdmDedType = 'DEN' THEN '502' --Dental
                                                 WHEN BdmDedType = 'MED' THEN '512' --Extended Health
                                                 WHEN BdmDedType = 'HSA' THEN '851' --HSA
                                                 ELSE ''
                                            END
                            ,"@FlexCodeNm"=CASE WHEN BdmDedCode IN (SELECT DedCode FROM dbo.U_@CustomFormatCode_DedCodes) AND BdmBenOption IN (@FamilyBenOption) THEN 'B'
                                                ELSE 'A'
                                           END
                            ,"@DepTypeCd"=CASE WHEN BdmDedCode = 'BDPLF' THEN '3'
                                               WHEN BdmDedCode IN ('MEDCA','DENCA') THEN
                                                    CASE WHEN BdmBenOption IN (@FamilyBenOption) THEN '3'
                                                         WHEN BdmBenOption IN (@EEOnlyBenOption) THEN '2'
                                                         ELSE '2'
                                                    END
                                          END
                            ,"@EffectiveDt"=CASE WHEN BdmUSGField2 = 'BenefitsAdd' THEN CONVERT(VARCHAR(10),BdmBenStartDate,120) END
                            ,"@LockInDt"=CASE WHEN BdmUSGField2 = 'BenefitsAdd' THEN CONVERT(VARCHAR(10),BdmBenStartDate,120) END
                            ,"@RequestedUnitsAmt"=CASE WHEN BdmDedType IN ('OPT','OPC','OPS') THEN CONVERT(INT,BcaBenAmtCalc / 10000)
                                                       ELSE 0
                                                  END
                            ,"@RequestedAmt"=COALESCE(BcaBenAmtCalc,0)
                            ,"@StatusCd"=CASE WHEN BdmUSGField1 = 'Termed' THEN '3'
                                              ELSE '1'
                                         END
                            ,"@TermReasonCd"=CASE WHEN BdmUSGField1 = 'Termed' THEN '2' END
                            ,"@TermDt"=CASE WHEN BdmUSGField1 = 'Termed' THEN CONVERT(VARCHAR(10),BdmBenStopDate,120) END
                        FROM dbo.U_dsi_BDM_@CustomFormatCode
                        LEFT JOIN dbo.U_dsi_bdm_BenCalculationAmounts
                            ON BcaEEID = BdmEEID
                            AND BcaCOID = BdmCOID
                            AND BcaDedCode = BdmDedCode
                        WHERE BdmEEID = DrvEEID
                        AND BdmRecType = 'EMP'
                        AND BdmUSGField2 IN ('BenefitsAdd','BenefitsChange','BenefitsTerm')
                        FOR XML PATH('Benefits'), TYPE
                    )
                FROM dbo.U_@CustomFormatCode_Members E
                WHERE ((@ExportCode = 'FULLFILE')
                    OR (@ExportCode <> 'FULLFILE'
                        AND BdmUSGField2 IN ('BenefitsAdd','BenefitsChange','BenefitsTerm')
                        AND EecEmplStatus <> 'T'
                    )
                )
                FOR XML PATH('Member'), TYPE
            )
        FOR XML PATH('Loader'),TYPE
    );

    -- Load Into Custom Table for BCP Export
    INSERT INTO dbo.U_@CustomFormatCode_XML (XMLOUT)
    VALUES (@XML);

    --==========================================
    -- Set Record Count
    --==========================================
    UPDATE dbo.U_dsi_Configuration
    SET CfgValue = (SELECT COUNT(*) FROM dbo.U_@CustomFormatCode_Members)
    WHERE FormatCode = '@CustomFormatCode' AND CfgName = 'OverrideCount';

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
        SET ExportFile = 'T@PolicyNumber'
                        + CONVERT(CHAR(8),GETDATE(),112) --YYYYMMDD
                        + '.xml'
        WHERE FormatCode = @FormatCode;
    END;

END
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vw@CustomFormatCode_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_@CustomFormatCode_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE '@CustomFormatCode%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET ExpLastStartPerControl = '201904011'
       ,ExpStartPerControl     = '201904011'
       ,ExpLastEndPerControl   = '201904019'
       ,ExpEndPerControl       = '201904019'
WHERE ExpFormatCode = '@CustomFormatCode';

-- Create State/Province Code Translation Table

IF OBJECT_ID('dbo.U_@CustomFormatCode_Provinces') IS NOT NULL DROP TABLE dbo.U_@CustomFormatCode_Provinces

CREATE TABLE [dbo].[U_@CustomFormatCode_Provinces](
  [PrvCode] [VARCHAR](2)   NULL,
  [PrvAbbr] [VARCHAR](2)   NULL,
  [PrvDesc] [VARCHAR](255) NULL
) ON [PRIMARY]

INSERT INTO dbo.U_@CustomFormatCode_Provinces VALUES
     ('1', 'NL', 'Newfoundland')
    ,('2', 'PE', 'Prince Edward Island')
    ,('3', 'NB', 'New Brunswick')
    ,('4', 'NS', 'Nova Scotia')
    ,('5', 'ON', 'Ontario')
    ,('6', 'QC', 'Quebec')
    ,('7', 'MB', 'Manitoba')
    ,('8', 'SK', 'Saskatchewan')
    ,('9', 'AB', 'Alberta')
    ,('10', 'BC', 'British Columbia')
    ,('11', 'NT', 'Northwest Territories')
    ,('12', 'YT', 'Yukon')
    ,('13', 'NU', 'Nunavut')
    ,('14', 'AL', 'Alabama')
    ,('15', 'AK', 'Alaska')
    ,('16', 'AZ', 'Arizona')
    ,('17', 'AR', 'Arkansas')
    ,('18', 'CA', 'California')
    ,('19', 'CO', 'Colorado')
    ,('20', 'CT', 'Connecticut')
    ,('21', 'DE', 'Delaware')
    ,('22', 'DC', 'District of Columbia')
    ,('23', 'FL', 'Florida')
    ,('24', 'GA', 'Georgia')
    ,('25', 'HI', 'Hawaii')
    ,('26', 'ID', 'Idaho')
    ,('27', 'IL', 'Illinois')
    ,('28', 'IN', 'Indiana')
    ,('29', 'IA', 'Iowa')
    ,('30', 'KS', 'Kansas')
    ,('31', 'KY', 'Kentucky')
    ,('32', 'LA', 'Louisianna')
    ,('33', 'ME', 'Maine')
    ,('34', 'MD', 'Maryland')
    ,('35', 'MA', 'Massachusetts')
    ,('36', 'MI', 'Michigan')
    ,('37', 'MN', 'Minnesota')
    ,('38', 'MS', 'Mississippi')
    ,('39', 'MO', 'Missouri')
    ,('40', 'MT', 'Montana')
    ,('41', 'NE', 'Nebraska')
    ,('42', 'NV', 'Nevada')
    ,('43', 'NH', 'New Hampshire')
    ,('44', 'NJ', 'New Jersey')
    ,('45', 'NM', 'New Mexico')
    ,('46', 'NY', 'New York')
    ,('47', 'NC', 'North Carolina')
    ,('48', 'ND', 'North Dakota')
    ,('49', 'OH', 'Ohio')
    ,('50', 'OK', 'Oklahoma')
    ,('51', 'OR', 'Oregon')
    ,('52', 'PA', 'Pennsylvania')
    ,('53', 'RI', 'Rhode Island')
    ,('54', 'SC', 'South Carolina')
    ,('55', 'SD', 'South Dakota')
    ,('56', 'TN', 'Tennessee')
    ,('57', 'TX', 'Texas')
    ,('58', 'UT', 'Utah')
    ,('59', 'VT', 'Vermont')
    ,('60', 'VA', 'Virginia')
    ,('61', 'WA', 'Washington')
    ,('62', 'WV', 'West Virginia')
    ,('63', 'WI', 'Wisconsin')
    ,('64', 'WY', 'Wyoming')
    ,('65', 'OT', 'Other')

SELECT * FROM dbo.U_@CustomFormatCode_Provinces

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vw@CustomFormatCode_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_@CustomFormatCode_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort
GO
CREATE FUNCTION [dbo].[dsi_fn_@CustomFormatCode_Benefciaries] (
    @EEID CHAR(12)
)
RETURNS VARCHAR(MAX)
AS
/************************************************************

Created By: @DeveloperName
Create Date: @CreateDate

Purpose: Returns the Beneficiary Data in Comma-Delimited Format for Sunlife XML File

Command: PRINT dbo.dsi_fn_@CustomFormatCode(xEEID)

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/20XX     SR-20XX-000XXXXX   XXXXX

************************************************************/
BEGIN

    -- Declare Variables 
    DECLARE @Beneficiaries VARCHAR(MAX)

    -- Create Comma Delimited List of Beneficiaries
    SELECT @Beneficiaries = COALESCE(@Beneficiaries+',','')
                            + LTRIM(RTRIM(ConNameFirst)) + SPACE(1) + LTRIM(RTRIM(ConNameLast)) + ','
                            + ISNULL(RELATION.CodDesc,'') + ','
                            + CONVERT(VARCHAR(10),CONVERT(MONEY,BfpPctToAlloc)) + '%'
    FROM dbo.BnfBPlan
    JOIN dbo.Contacts
        ON ConEEID = BfpEEID
        AND ConSystemID = BfpConRecID
    LEFT JOIN dbo.DedCode
        ON DedDedCode = BfpDedCode
    LEFT JOIN dbo.Codes RELATION
        ON RELATION.CodCode = ConRelationship
        AND RELATION.CodTable = 'RELATION'
    WHERE DedDedType IN ('OPT','OPC','OPS')
    AND BfpPctToAlloc > 0.00
    AND BfpEEID = @EEID;

    -- Return Beneficiaries
    RETURN @Beneficiaries;

END
GO
CREATE FUNCTION [dbo].[dsi_fnlib_GetDedGroupCode_EffDate] (
    @EEID            VARCHAR(12),
    @COID            VARCHAR(5)
)

RETURNS DATETIME
WITH EXECUTE AS CALLER
AS

/************************************************************

Created By: Lynn Manning
Create Date: 10/23/2017

Revision History
----------------
Update By            Date            Desc
XXXX                 XX/XX/16        Added 1234

Purpose: Gets the employee's deduction group code effective date
         
EXAMPLE:
SELECT EecEEID, EecCOID, dbo.dsi_fnlib_GetDedGroupCode_EffDate(EecEEID, EecCOID) 
FROM dbo.EmpComp ;


************************************************************/

BEGIN

    -----------
    -- Declare and set variables
    -----------

    DECLARE @EffDate DATETIME;

    IF @EEID = '' RETURN '';
    IF @COID = '' RETURN '';

    SELECT 
        @EffDate = OverrideDate
    -- select * 
    FROM 
        dbo.DedGroupChangeDateOverride 
    JOIN 
        dbo.EmpHComp ON systemid = ehcSystemID
    WHERE 
        ehcEEID = @EEID AND
        ehcCOID = @COID ;


    RETURN NULLIF(@EffDate, '1900-01-01 00:00:00.000');

END
GO
CREATE TABLE [dbo].[U_@CustomFormatCode_Provinces](
  [PrvCode] [VARCHAR](2)   NULL,
  [PrvAbbr] [VARCHAR](2)   NULL,
  [PrvDesc] [VARCHAR](255) NULL
) ON [PRIMARY]

INSERT INTO dbo.U_@CustomFormatCode_Provinces VALUES
     ('1', 'NL', 'Newfoundland')
    ,('2', 'PE', 'Prince Edward Island')
    ,('3', 'NB', 'New Brunswick')
    ,('4', 'NS', 'Nova Scotia')
    ,('5', 'ON', 'Ontario')
    ,('6', 'QC', 'Quebec')
    ,('7', 'MB', 'Manitoba')
    ,('8', 'SK', 'Saskatchewan')
    ,('9', 'AB', 'Alberta')
    ,('10', 'BC', 'British Columbia')
    ,('11', 'NT', 'Northwest Territories')
    ,('12', 'YT', 'Yukon')
    ,('13', 'NU', 'Nunavut')
    ,('14', 'AL', 'Alabama')
    ,('15', 'AK', 'Alaska')
    ,('16', 'AZ', 'Arizona')
    ,('17', 'AR', 'Arkansas')
    ,('18', 'CA', 'California')
    ,('19', 'CO', 'Colorado')
    ,('20', 'CT', 'Connecticut')
    ,('21', 'DE', 'Delaware')
    ,('22', 'DC', 'District of Columbia')
    ,('23', 'FL', 'Florida')
    ,('24', 'GA', 'Georgia')
    ,('25', 'HI', 'Hawaii')
    ,('26', 'ID', 'Idaho')
    ,('27', 'IL', 'Illinois')
    ,('28', 'IN', 'Indiana')
    ,('29', 'IA', 'Iowa')
    ,('30', 'KS', 'Kansas')
    ,('31', 'KY', 'Kentucky')
    ,('32', 'LA', 'Louisianna')
    ,('33', 'ME', 'Maine')
    ,('34', 'MD', 'Maryland')
    ,('35', 'MA', 'Massachusetts')
    ,('36', 'MI', 'Michigan')
    ,('37', 'MN', 'Minnesota')
    ,('38', 'MS', 'Mississippi')
    ,('39', 'MO', 'Missouri')
    ,('40', 'MT', 'Montana')
    ,('41', 'NE', 'Nebraska')
    ,('42', 'NV', 'Nevada')
    ,('43', 'NH', 'New Hampshire')
    ,('44', 'NJ', 'New Jersey')
    ,('45', 'NM', 'New Mexico')
    ,('46', 'NY', 'New York')
    ,('47', 'NC', 'North Carolina')
    ,('48', 'ND', 'North Dakota')
    ,('49', 'OH', 'Ohio')
    ,('50', 'OK', 'Oklahoma')
    ,('51', 'OR', 'Oregon')
    ,('52', 'PA', 'Pennsylvania')
    ,('53', 'RI', 'Rhode Island')
    ,('54', 'SC', 'South Carolina')
    ,('55', 'SD', 'South Dakota')
    ,('56', 'TN', 'Tennessee')
    ,('57', 'TX', 'Texas')
    ,('58', 'UT', 'Utah')
    ,('59', 'VT', 'Vermont')
    ,('60', 'VA', 'Virginia')
    ,('61', 'WA', 'Washington')
    ,('62', 'WV', 'West Virginia')
    ,('63', 'WI', 'Wisconsin')
    ,('64', 'WY', 'Wyoming')
    ,('65', 'OT', 'Other')
GO
--1.09f BCA ADD-ON
IF DB_NAME() <> 'ULTIPRO_BDM' AND OBJECT_ID('U_dsi_bdm_BenCalculationAmounts') IS NOT NULL DROP TABLE dbo.U_dsi_bdm_BenCalculationAmounts;
IF DB_NAME() <> 'ULTIPRO_BDM' AND OBJECT_ID('U_dsi_BDM_BCAConfiguration') IS NOT NULL DROP TABLE dbo.U_dsi_BDM_BCAConfiguration;
IF DB_NAME() <> 'ULTIPRO_BDM' AND OBJECT_ID('U_dsi_bdm_bcaInsRate') IS NOT NULL DROP TABLE dbo.U_dsi_bdm_bcaInsRate;
IF DB_NAME() <> 'ULTIPRO_BDM' AND OBJECT_ID('U_dsi_bdm_bcaOptRate') IS NOT NULL DROP TABLE dbo.U_dsi_bdm_bcaOptRate;
IF DB_NAME() <> 'ULTIPRO_BDM' AND OBJECT_ID('dsi_bdm_sp_CalculateBenefitAmounts') IS NOT NULL DROP PROCEDURE dbo.dsi_bdm_sp_CalculateBenefitAmounts;

CREATE TABLE [dbo].[U_dsi_bdm_bcaInsRate] (
    [BcaInsFormatCode] [varchar](10) NOT NULL
    ,[BcaInsDedcode] [varchar](10) NOT NULL
    ,[BcaInsMinAge] [decimal](16, 6) NULL
    ,[BcaInsMaxAge] [decimal](16, 6) NULL
    ,[BcaInsEERateNSFemale] [money] NULL
    ,[BcaInsEERateSMFemale] [money] NULL
    ,[BcaInsEERateNSMale] [money] NULL
    ,[BcaInsEERateSMMale] [money] NULL
    ,[BcaInsERRateNSFemale] [money] NULL
    ,[BcaInsERRateSMFemale] [money] NULL
    ,[BcaInsERRateNSMale] [money] NULL
    ,[BcaInsERRateSMMale] [money] NULL
    ,[BcaInsEffDate] [datetime] NULL
    ,[BcaInsPayFreq] [char](1) NULL
    ,[BcaInsRowNum] BIGINT
) ON [PRIMARY];
GO

CREATE TABLE [dbo].[U_dsi_bdm_bcaOptRate] (
    [BcaORFormatCode] [varchar](10) NOT NULL
    ,[BcaORDedcode] [varchar](10) NOT NULL
    ,[BcaORBenOption] [char](6) NOT NULL
    ,[BcaOREERate] [money] NULL
    ,[BcaORERRate] [money] NULL
    ,[BcaORPayFreq] [char](1) NULL
    ,[BcaORRowNum] BIGINT
) ON [PRIMARY];
GO

CREATE TABLE [dbo].[U_dsi_bdm_BenCalculationAmounts] (
    [BcaFormatCode] [varchar](10) NOT NULL
    ,[BcaCoID] [char](5) NOT NULL
    ,[BcaEEID] [char](12) NOT NULL
    ,[BcaDepRecID] [char](12) NULL
    ,[BcaRunID] [varchar](32) NULL
    ,[BcaDedCode] [char](5) NOT NULL
    ,[BcaBenAmt] [money] NULL
    ,[BcaBenAmtCalc] [money] NULL
    ,[BcaBenAmtCalcRule] [char](2) NULL
    ,[BcaBenAmtRateOrPct] [decimal](16, 6) NULL
    ,[BcaEEBenAmt] [money] NULL
    ,[BcaBenAmtPer] [char](2) NULL
    ,[BcaBenAmtMax] [money] NULL
    ,[BcaCalcRowStatus] [char](256) NULL
    ,[BcaBenAmtRoundingRule] [char](2) NULL
    ,[BcaUseCurrentAge] [char](1) NULL
    ,[BcaAgeAsOfDate] [datetime] NULL
    ,[BcaUseBenReducSched] [char](1) NULL
    ,[BcaBenReducUseCurrentAge] [char](1) NULL
    ,[BcaBenReducAgeAsOfDate] [datetime] NULL
    ,[BcaDedEECalcRateOrPct] [decimal](16, 6) NULL
    ,[BcaDedEECalcRule] [char](2) NULL
    ,[BcaDedERCalcRateOrPct] [decimal](16, 6) NULL
    ,[BcaDedERCalcRule] [char](2) NULL
    ,[BcaEEAmt] [money] NULL
    ,[BcaERAmt] [money] NULL
    ,[BcaBenOption] [char](6) NULL
) ON [PRIMARY];
GO
CREATE TABLE [dbo].[U_dsi_BDM_BCAConfiguration](
    [FormatCode] [varchar](10) NOT NULL,
    [ParmName] [varchar](255) NOT NULL,
    [ParmValue1] [varchar](max) NULL,
    [ParmValue2] [varchar](max) NULL
) ON [PRIMARY]
GO
CREATE CLUSTERED INDEX CDX_U_dsi_bdm_BenCalculationAmounts ON dbo.U_dsi_bdm_BenCalculationAmounts (BcaFormatCode,BcaEEID,BcaCoID);
CREATE NONCLUSTERED INDEX NCDX_U_dsi_bdm_BenCalculationAmounts_BcaDedCode ON dbo.U_dsi_bdm_BenCalculationAmounts (BcaDedCode);
CREATE NONCLUSTERED INDEX NCDX_U_dsi_bdm_BenCalculationAmounts_BcaDepRecID ON dbo.U_dsi_bdm_BenCalculationAmounts (BcaDepRecID);
GO

CREATE PROCEDURE [dbo].[dsi_bdm_sp_CalculateBenefitAmounts] @FormatCode VARCHAR(10)
AS
SET NOCOUNT ON;

/************************************************************

dsi_bdm_sp_CalculateBenefitAmounts

Created By: Vinny Kelly
Create Date: 07/18/2013

Purpose: Calculates benefit deduction amounts based on the parameters below.

NOTE TO SUPPORT: this stored procedure is one of a standard set of DSI procedures. Please do not make any changes
to this procedure without Going through the Data Services team. Any changes made to this procedure will be wiped out
if/when the standard DSI code is reinstalled on this database.

Revision History
----------------
Version   Update By         Date            Descr
1.01      VKelly            2013/08/07        Fixed Calculation Rule error for Expression Calculation Rule
1.02      VKelly            2014/04/30        Added Dependent Benefit Age Graded rate Option - to calculate off Dependents Date of Birth, instead of EE's Date of Birth
1.03      VKelly            2014/07/10        Added Employee Elected Rate or Pct - to calculate off of Employee Deduction code, versus Deduction Code setup table
1.04      VKelly            2014/12/22        Fixed Age Graded Rate to support Fixed plan date
1.05      VKelly            2015/10/09        Added Option to Skip Age Graded Rate portion of Calculation, but retain other parts of the rule
1.06      VKelly            2016/11/23        Added RunID to allow multiple sessions to execute from BDM, and retain the correct Benefit Amount if different between sessions.
1.07      TLeonce            2017/07/07        Add Insurance Rate Calculations (dbo.InsRate) / Add BcaEEAmt and BcaERAmt Fields to table
1.07b      VKelly            2017/07/10        Correct Insurance Rate Calculations (dbo.InsRate) for BcaEEAmt and BcaERAmt Fields to table
1.07c      VKelly            2017/10/02        Fixed Bug related to Date of Birth used for Insurance Rate calculation (Date as of, for calcuation purposes)
1.07d      VKelly            2017/10/03        Added feature to custom control Date for Insurance Rate calculation (Date as of, for calcuation purposes)
1.08      VKelly            2017/10/20        Added feature to skip Rounding Rules after calculation has been performed.
1.09      VKelly            2018/02/15        Expanded EE/ER Rate Calculation Rules to include (99, 30 & 20) - 99 = None, 30 = Benefit Amount * Rate, 20 = Flat Amount
1.09b      VKelly            2018/06/11        Fixed EE/ER Rate Calculation Rules for Flat Amount (20)
1.09c      VKelly            2018/06/13        Fixed EE/ER Rate Calculation Rules for Benefit Amount * Dependent Age Graded Rate Rule (32)
1.09d      VKelly            2018/06/15        Fixed InsRate Calculation Rules to ensure only current rate rules apply in calculation
1.09e      VKelly            2018/08/21        Fixed Age Calculation to correctly calculate EE/Dependents age, to get them in proper rate calc rule
1.09f      VKelly            2018/09/05        Removed Requirement for ValidForExport results in BDM to use BCA (to include Waived coverage in some instances)
************************************************************/
BEGIN

    --====================================================
    -- Declare variables
    --====================================================
    DECLARE @DependentBenefitAgeGradedRate VARCHAR(1);
    DECLARE @DependentAgeGradedDedCodes VARCHAR(8000);
    DECLARE @EmployeeElectedRateorPct VARCHAR(1);
    DECLARE @EmployeeElectedRateorPctDedCodes VARCHAR(8000);
    DECLARE @SkipAgeGradedRateCalcRule VARCHAR(1);
    DECLARE @SkipAgeGradedRateCalcRuleDedCodes VARCHAR(8000);
    DECLARE @SkipRoundingRuleDedCodes VARCHAR(8000);
    DECLARE @RateEffDate DATETIME;
    DECLARE @InsRateAsOfDateDedCodes VARCHAR(8000);
    DECLARE @InsRateAsOfDateDedCodes2 VARCHAR(8000);
    DECLARE @InsRateAsOfDateDedCodes3 VARCHAR(8000);
    DECLARE @InsRateAsOfDateDedCodes4 VARCHAR(8000);
    DECLARE @InsRateAsOfDateDedCodes5 VARCHAR(8000);
    DECLARE @InsRateAsOfDateValues TABLE(
        InsRateDedCode CHAR(5),
        InsRateAsOfDate DATETIME
    );

    SELECT @DependentAgeGradedDedCodes = CONVERT(VARCHAR(1024), ParmValue) FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'DependentBenefitAgeGradedRate';
    SELECT @DependentBenefitAgeGradedRate = 'Y' WHERE EXISTS (SELECT 1 FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'DependentBenefitAgeGradedRate');
    SELECT @EmployeeElectedRateorPctDedCodes = CONVERT(VARCHAR(1024), ParmValue) FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'EmployeeElectedRateorPct';
    SELECT @EmployeeElectedRateorPct = 'Y' WHERE EXISTS (SELECT 1 FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'EmployeeElectedRateorPct');
    SELECT @SkipAgeGradedRateCalcRuleDedCodes = CONVERT(VARCHAR(1024), ParmValue) FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'SkipAgeGradedRateCalcRule';
    SELECT @SkipAgeGradedRateCalcRule = 'Y' WHERE EXISTS (SELECT 1 FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'SkipAgeGradedRateCalcRule');
    SELECT @SkipRoundingRuleDedCodes = CONVERT(VARCHAR(1024), ParmValue) FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'SkipRoundingRule';
    SELECT @InsRateAsOfDateDedCodes = CONVERT(VARCHAR(1024), ParmValue1) FROM dbo.U_dsi_BDM_BCAConfiguration WHERE FormatCode = @FormatCode AND ParmName = 'InsRateAsOfDate';
    SELECT @InsRateAsOfDateDedCodes = CONVERT(VARCHAR(1024), ParmValue1) FROM dbo.U_dsi_BDM_BCAConfiguration WHERE FormatCode = @FormatCode AND ParmName = 'InsRateAsOfDate2';
    SELECT @InsRateAsOfDateDedCodes = CONVERT(VARCHAR(1024), ParmValue1) FROM dbo.U_dsi_BDM_BCAConfiguration WHERE FormatCode = @FormatCode AND ParmName = 'InsRateAsOfDate3';
    SELECT @InsRateAsOfDateDedCodes = CONVERT(VARCHAR(1024), ParmValue1) FROM dbo.U_dsi_BDM_BCAConfiguration WHERE FormatCode = @FormatCode AND ParmName = 'InsRateAsOfDate4';
    SELECT @InsRateAsOfDateDedCodes = CONVERT(VARCHAR(1024), ParmValue1) FROM dbo.U_dsi_BDM_BCAConfiguration WHERE FormatCode = @FormatCode AND ParmName = 'InsRateAsOfDate5';
    
    SET @RateEffDate = ISNULL((SELECT CONVERT(DATETIME,ParmValue) FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'RateEffDate'),GETDATE());
    
    SET @DependentAgeGradedDedCodes = dbo.dsi_BDM_fn_Trim(@DependentAgeGradedDedCodes);
    SET @EmployeeElectedRateorPctDedCodes = dbo.dsi_BDM_fn_Trim(@EmployeeElectedRateorPctDedCodes);
    SET @SkipAgeGradedRateCalcRuleDedCodes = dbo.dsi_BDM_fn_Trim(@SkipAgeGradedRateCalcRuleDedCodes);
    INSERT INTO @InsRateAsOfDateValues (InsRateDedCode, InsRateAsOfDate) 
        SELECT Item, (SELECT CONVERT(DATETIME, ParmValue2) FROM dbo.U_dsi_BDM_BCAConfiguration WHERE FormatCode = @FormatCode AND ParmName = 'InsRateAsOfDate')
        FROM dbo.dsi_BDM_fn_ListToTable(@InsRateAsOfDateDedCodes);
    INSERT INTO @InsRateAsOfDateValues (InsRateDedCode, InsRateAsOfDate) 
        SELECT Item, (SELECT CONVERT(DATETIME, ParmValue2) FROM dbo.U_dsi_BDM_BCAConfiguration WHERE FormatCode = @FormatCode AND ParmName = 'InsRateAsOfDate2')
        FROM dbo.dsi_BDM_fn_ListToTable(@InsRateAsOfDateDedCodes);
    INSERT INTO @InsRateAsOfDateValues (InsRateDedCode, InsRateAsOfDate) 
        SELECT Item, (SELECT CONVERT(DATETIME, ParmValue2) FROM dbo.U_dsi_BDM_BCAConfiguration WHERE FormatCode = @FormatCode AND ParmName = 'InsRateAsOfDate3')
        FROM dbo.dsi_BDM_fn_ListToTable(@InsRateAsOfDateDedCodes);
    INSERT INTO @InsRateAsOfDateValues (InsRateDedCode, InsRateAsOfDate) 
        SELECT Item, (SELECT CONVERT(DATETIME, ParmValue2) FROM dbo.U_dsi_BDM_BCAConfiguration WHERE FormatCode = @FormatCode AND ParmName = 'InsRateAsOfDate4')
        FROM dbo.dsi_BDM_fn_ListToTable(@InsRateAsOfDateDedCodes);
    INSERT INTO @InsRateAsOfDateValues (InsRateDedCode, InsRateAsOfDate) 
        SELECT Item, (SELECT CONVERT(DATETIME, ParmValue2) FROM dbo.U_dsi_BDM_BCAConfiguration WHERE FormatCode = @FormatCode AND ParmName = 'InsRateAsOfDate5')
        FROM dbo.dsi_BDM_fn_ListToTable(@InsRateAsOfDateDedCodes);

    --====================================================
    -- Load Deduction Codes into BDM Deduction Tables
    --====================================================
    ---------------------------------------------------------------------------------------------------------------
    --Insert Deduction Code into BDM Deduction Tables, for exclusive use as Dependent Benefit Age Graded Rate 
    ---------------------------------------------------------------------------------------------------------------
    INSERT INTO dbo.U_dsi_BDM_DeductionCodes (UdcFormatCode,UdcDedTarget,UDcDedCode,UdcDedType,UdcIsDomPartnerDed)
    SELECT UdcFormatCode = @FormatCode
        ,UdcDedTarget = 'DAG'
        ,UDcDedCode = DedDedCode
        ,UdcDedType = DedDedType
        ,UdcIsDomPartnerDed = 'N'
    FROM dbo.Dedcode
    LEFT JOIN dbo.dsi_BDM_fn_ListToTable(@DependentAgeGradedDedCodes) d
        ON d.item = DedDedCode
    WHERE (d.item IS NOT NULL)
    GROUP BY DedDedCode,DedDedType;

    ---------------------------------------------------------------------------------------------------------------
    --Insert Deduction Code into BDM Deduction Tables, for exclusive use as Employee Elected Rate 
    ---------------------------------------------------------------------------------------------------------------
    INSERT INTO dbo.U_dsi_BDM_DeductionCodes (UdcFormatCode,UdcDedTarget,UDcDedCode,UdcDedType,UdcIsDomPartnerDed)
    SELECT UdcFormatCode = @FormatCode
        ,UdcDedTarget = 'EER'
        ,UDcDedCode = DedDedCode
        ,UdcDedType = DedDedType
        ,UdcIsDomPartnerDed = 'N'
    FROM dbo.Dedcode
    LEFT JOIN dbo.dsi_BDM_fn_ListToTable(@EmployeeElectedRateorPctDedCodes) d
        ON d.item = DedDedCode
    WHERE (d.item IS NOT NULL)
    GROUP BY DedDedCode,DedDedType;

    ---------------------------------------------------------------------------------------------------------------
    --Insert Deduction Code into BDM Deduction Tables, to skip Age Graded Rate Reduction Rule
    ---------------------------------------------------------------------------------------------------------------
    INSERT INTO dbo.U_dsi_BDM_DeductionCodes (UdcFormatCode,UdcDedTarget,UDcDedCode,UdcDedType,UdcIsDomPartnerDed)
    SELECT UdcFormatCode = @FormatCode
        ,UdcDedTarget = 'AGR'
        ,UDcDedCode = DedDedCode
        ,UdcDedType = DedDedType
        ,UdcIsDomPartnerDed = 'N'
    FROM dbo.Dedcode
    LEFT JOIN dbo.dsi_BDM_fn_ListToTable(@SkipAgeGradedRateCalcRuleDedCodes) d
        ON d.item = DedDedCode
    WHERE (d.item IS NOT NULL)
    GROUP BY DedDedCode,DedDedType;
    ---------------------------------------------------------------------------------------------------------------
    --Insert Deduction Code into BDM Deduction Tables, to skip Roudning Rules
    ---------------------------------------------------------------------------------------------------------------
    INSERT INTO dbo.U_dsi_BDM_DeductionCodes (UdcFormatCode,UdcDedTarget,UDcDedCode,UdcDedType,UdcIsDomPartnerDed)
    SELECT UdcFormatCode = @FormatCode
        ,UdcDedTarget = 'SRR'
        ,UDcDedCode = DedDedCode
        ,UdcDedType = DedDedType
        ,UdcIsDomPartnerDed = 'N'
    FROM dbo.Dedcode
    LEFT JOIN dbo.dsi_BDM_fn_ListToTable(@SkipRoundingRuleDedCodes) d
        ON d.item = DedDedCode
    WHERE (d.item IS NOT NULL)
    GROUP BY DedDedCode,DedDedType;

    --========================================================
    -- Calculate Benefit Amounts based on Calculation Rules
    --========================================================

    -- Clear Calculation Amounts by Format Code
    DELETE dbo.U_dsi_bdm_BenCalculationAmounts WHERE BcaFormatCode = @FormatCode;

    INSERT INTO dbo.U_dsi_bdm_BenCalculationAmounts (BcaFormatCode,BcaCoID,BcaEEID,BcaRunID,BcaDedCode,BcaBenAmt,BcaBenOption)
    SELECT EedFormatCode
        ,EedCoid
        ,EedEEID
        ,EedRunID
        ,EedDedCode
        ,EedBenAmt
        ,EedBenOption
    FROM dbo.u_dsi_bdm_EmpDeductions
    WHERE EedFormatCode = @FormatCode;

    INSERT INTO dbo.U_dsi_bdm_BenCalculationAmounts (BcaFormatCode,BcaCoID,BcaEEID,BcaDepRecID,BcaRunID,BcaDedCode,BcaBenAmt,BcaBenOption)
    SELECT DbnFormatCode
        ,dbo.dsi_BDM_fn_GetCurrentCOID(DbnEEID)
        ,DbnEEID
        ,DbnDepRecID
        ,DbnRunID
        ,DbnDedCode
        ,DedEEBenAmt
        ,DbnBenOption
    FROM dbo.u_dsi_bdm_DepDeductions
    WHERE DbnFormatCode = @FormatCode;

    -----------------------------------------------------------------------------------
    --Update Benefit Calculations Table with Deduction Code Benefit Amount Rules:
    -----------------------------------------------------------------------------------
    UPDATE dbo.U_dsi_bdm_BenCalculationAmounts
    SET BcaBenAmtCalcRule = DedBenAmtCalcRule
        ,BcaBenAmtRateOrPct = DedBenAmtRateOrPct
        ,BcaEEBenAmt = DedEEBenAmt
        ,BcaBenAmtPer = DedBenAmtPer
        ,BcaBenAmtMax = DedBenAmtMax
        ,BcaBenAmtRoundingRule = DedBenAmtRoundingRule
        ,BcaUseCurrentAge = DedUseCurrentAge
        ,BcaAgeAsOfDate = DedAgeAsOfDate
        ,BcaUseBenReducSched = DedUseBenReducSched
        ,BcaBenReducUseCurrentAge = DedBenReducUseCurrentAge
        ,BcaBenReducAgeAsOfDate = DedBenReducAgeAsOfDate
        ,BcaDedEECalcRateOrPct = DedEECalcRateOrPct
        ,BcaDedEECalcRule = DedEECalcRule
        ,BcaDedERCalcRateOrPct = DedERCalcRateOrPct
        ,BcaDedERCalcRule = DedERCalcRule
        ,BcaEEAmt = CASE WHEN DedEECalcRule = '99' THEN 0.00 ELSE NULL END
        ,BcaERAmt = CASE WHEN DedERCalcRule = '99' THEN 0.00 ELSE NULL END
    FROM dbo.U_dsi_bdm_BenCalculationAmounts
    INNER JOIN dbo.dedcode
        ON BcaDedCode = DeddedCode
    WHERE BcaFormatCode = @FormatCode;

    -----------------------------------------------------------------------------------
    --Update Benefit Calculations Table with Employee Elected Benefit Amount Rules:
    -----------------------------------------------------------------------------------
    UPDATE dbo.U_dsi_bdm_BenCalculationAmounts
    SET BcaBenAmtRateOrPct = eedBenAmtRateorPct
    FROM dbo.U_dsi_bdm_BenCalculationAmounts
    INNER JOIN dbo.U_dsi_bdm_EmpDeductions
        ON BcaEEID = EedEEID
        AND BcaCoID = EedCoID
        AND EedFormatCode = BcaFormatCode
        AND BcaDedCode = EedDedCode
        AND EedRunID = bcaRunID
    WHERE BcaDedCode IN (SELECT Udcdedcode FROM dbo.U_dsi_BDM_DeductionCodes WHERE UdcFormatCode = @FormatCode AND UdcDedTarget = 'EER') 
        AND BcaFormatCode = @FormatCode;

    --=================================================================================
    --Update Calculated Benefit Amount for Calc Rules: '20','30','40','41','42','43'
    --=================================================================================
    UPDATE dbo.U_dsi_bdm_BenCalculationAmounts
    SET BcaBenAmtCalc = CASE WHEN BcaBenAmtCalcRule = '20' THEN 0
                             WHEN BcaBenAmtCalcRule = '30' THEN
                                CASE WHEN BcaBenAmt = 0 THEN BcaEEBenAmt
                                     ELSE BcaBenAmt
                                END
                             WHEN BcaBenAmtCalcRule = '40' THEN --'Period Pay * Pct'
                                CASE WHEN EecSalaryOrHourly = 'S' THEN
                                        CASE WHEN EecPayPeriod = 'B' THEN eecAnnSalary / 26
                                             WHEN EecPayPeriod = 'S' THEN eecAnnSalary / 24
                                             WHEN EecPayPeriod = 'M' THEN eecAnnSalary / 12
                                             WHEN EecPayPeriod = 'W' THEN eecAnnSalary / 52
                                        END
                                    WHEN EecSalaryOrHourly = 'H' THEN EecHourlyPayRate * EecScheduledWorkHrs
                                END * BcaBenAmtRateOrPct
                             WHEN BcaBenAmtCalcRule = '41' THEN --'Weekly Pay * Pct'
                                CASE WHEN EecSalaryOrHourly = 'S' THEN (eecAnnSalary / 52)
                                     WHEN EecSalaryOrHourly = 'H' AND EecPayPeriod = 'B' THEN EecHourlyPayRate * EecScheduledWorkHrs / 2
                                     WHEN EecSalaryOrHourly = 'H' AND EecPayPeriod = 'W' THEN EecHourlyPayRate * EecScheduledWorkHrs
                                     WHEN EecSalaryOrHourly = 'H' AND EecPayPeriod = 'M' THEN EecHourlyPayRate * (EecScheduledWorkHrs * 12) / 52
                                     WHEN EecSalaryOrHourly = 'H' AND EecPayPeriod = 'S' THEN EecHourlyPayRate * (EecScheduledWorkHrs * 24) / 52
                                END * BcaBenAmtRateOrPct
                             WHEN BcaBenAmtCalcRule = '42' THEN --'Monthly Pay * Pct'
                                CASE WHEN EecSalaryOrHourly = 'S' THEN (eecAnnSalary / 12)
                                     WHEN EecSalaryOrHourly = 'H' AND EecPayPeriod = 'B' THEN (EecHourlyPayRate * EecScheduledWorkHrs * 26) / 12
                                     WHEN EecSalaryOrHourly = 'H' AND EecPayPeriod = 'S' THEN (EecHourlyPayRate * EecScheduledWorkHrs * 24) / 12
                                     WHEN EecSalaryOrHourly = 'H' AND EecPayPeriod = 'W' THEN (EecHourlyPayRate * EecScheduledWorkHrs * 52) / 12
                                     WHEN EecSalaryOrHourly = 'H' AND EecPayPeriod = 'M' THEN (EecHourlyPayRate * EecScheduledWorkHrs)
                                END * BcaBenAmtRateOrPct
                             WHEN BcaBenAmtCalcRule = '43' THEN --'Ann Salary * Rate'
                                CASE WHEN EecSalaryOrHourly = 'S' THEN eecAnnSalary
                                     WHEN EecSalaryOrHourly = 'H' AND EecPayPeriod = 'B' THEN EecHourlyPayRate * EecScheduledWorkHrs * 26
                                     WHEN EecSalaryOrHourly = 'H' AND EecPayPeriod = 'S' THEN EecHourlyPayRate * EecScheduledWorkHrs * 24
                                     WHEN EecSalaryOrHourly = 'H' AND EecPayPeriod = 'W' THEN EecHourlyPayRate * EecScheduledWorkHrs * 52
                                     WHEN EecSalaryOrHourly = 'H' AND EecPayPeriod = 'M' THEN EecHourlyPayRate * EecScheduledWorkHrs * 12
                                END * BcaBenAmtRateOrPct
                        END
        ,BcaCalcRowStatus = 'Normal Calculation Rules applied'
    FROM dbo.U_dsi_bdm_BenCalculationAmounts
    INNER JOIN dbo.empcomp WITH (NOLOCK)
        ON EecEEID = bcaeeid
        AND EecCOID = bcacoid
    WHERE BcaBenAmtCalcRule IN ('20','30','40','41','42','43') 
        AND BcaFormatCode = @FormatCode;

    -----------------------------------------------------------------------------------
    --Update Calculated Amount to be no greater than DedBenAmtMax
    -----------------------------------------------------------------------------------
    UPDATE dbo.u_dsi_bdm_BenCalculationAmounts
    SET BcaBenAmtCalc = BcaBenAmtMax
        ,BcaCalcRowStatus = 'Elected Amount exceeds DedBenAmtMax reduction rule triggered'
    FROM dbo.u_dsi_bdm_BenCalculationAmounts
    WHERE BcaBenAmtCalc > BcaBenAmtMax 
        AND BcaFormatCode = @FormatCode
        AND BcaBenAmtMax <> 0.00;

    --=================================================================================
    -- Updates for Age Graded Rates - Benefit Reduction Table: dbo.BenReduc
    --=================================================================================
    -----------------------------------------------------------------------------------
    --Update Calculated Amount if Age Graded Rate Applies
    -----------------------------------------------------------------------------------
    UPDATE dbo.u_dsi_bdm_BenCalculationAmounts
    SET BcaBenAmtCalc = BcaBenAmtCalc - (BcaBenAmtCalc * RedReductionPct)
        ,BcaCalcRowStatus = 'Age Graded Rate Benefit Amount reduction rule triggered on EEs Age'
    FROM dbo.u_dsi_bdm_BenCalculationAmounts
    INNER JOIN dbo.emppers WITH (NOLOCK)
        ON Bcaeeid = EepEEID
    INNER JOIN dbo.empcomp WITH (NOLOCK)
        ON Bcaeeid = EecEEID
        AND Bcacoid = EecCOID
    INNER JOIN dbo.BenReduc WITH (NOLOCK)
        ON reddedcode = BcaDedCode
        --AND ((FLOOR(DATEDIFF(DAY, EepDateOfBirth, ISNULL(BcaBenReducAgeAsOfDate, GETDATE())) / 365.242199) >= RedMinAge)
        --    AND (FLOOR(DATEDIFF(DAY, EepDateOfBirth, ISNULL(BcaBenReducAgeAsOfDate, GETDATE())) / 365.242199) < RedMaxAge)
        --)
        AND ((DATEDIFF(hour,EepDateOfBirth,ISNULL(BcaBenReducAgeAsOfDate,GETDATE()))/8766 >= RedMinAge)
            AND (DATEDIFF(hour,EepDateOfBirth,ISNULL(BcaBenReducAgeAsOfDate,GETDATE()))/8766 < RedMaxAge)
        )
    WHERE BcaDedCode NOT IN (SELECT udcdedcode FROM dbo.U_dsi_BDM_DeductionCodes WHERE UdcFormatCode = @FormatCode AND UdcDedTarget = 'DAG')
        AND BcaDedCode NOT IN (SELECT udcdedcode FROM dbo.U_dsi_BDM_DeductionCodes WHERE UdcFormatCode = @FormatCode AND UdcDedTarget = 'AGR')
        AND EXISTS (SELECT 1 FROM dbo.BenReduc WHERE reddedcode = BcaDedCode) 
        AND BcaFormatCode = @FormatCode;

    -----------------------------------------------------------------------------------
    --Update Calculated Amount if Age Graded Rate Applies -  Dependent Age Graded Rates
    -----------------------------------------------------------------------------------
    UPDATE dbo.u_dsi_bdm_BenCalculationAmounts
    SET BcaBenAmtCalc = BcaBenAmtCalc - (BcaBenAmtCalc * RedReductionPct)
        ,BcaCalcRowStatus = 'Age Graded Rate Benefit Amount reduction rule triggered on Dependents Age'
    FROM dbo.u_dsi_bdm_BenCalculationAmounts
    INNER JOIN dbo.emppers WITH (NOLOCK)
        ON Bcaeeid = EepEEID
    INNER JOIN dbo.empcomp WITH (NOLOCK)
        ON Bcaeeid = EecEEID
        AND Bcacoid = EecCOID
    INNER JOIN dbo.Contacts WITH (NOLOCK)
        ON BcaEEID = ConEEID
        AND BcaDepRecID = ConSystemID
    INNER JOIN dbo.BenReduc WITH (NOLOCK)
        ON reddedcode = BcaDedCode
        --AND ((FLOOR(DATEDIFF(DAY, conDateOfBirth, ISNULL(BcaBenReducAgeAsOfDate, GETDATE())) / 365.242199) >= RedMinAge)
        --    AND (FLOOR(DATEDIFF(DAY, conDateOfBirth, ISNULL(BcaBenReducAgeAsOfDate, GETDATE())) / 365.242199) < RedMaxAge)
        --)
        AND ((DATEDIFF(hour,ConDateOfBirth,ISNULL(BcaBenReducAgeAsOfDate,GETDATE()))/8766 >= RedMinAge)
            AND (DATEDIFF(hour,ConDateOfBirth,ISNULL(BcaBenReducAgeAsOfDate,GETDATE()))/8766 < RedMaxAge)
        )
    WHERE BcaDedCode IN (SELECT udcdedcode FROM dbo.U_dsi_BDM_DeductionCodes WHERE UdcFormatCode = @FormatCode AND UdcDedTarget = 'DAG')
        AND BcaDedCode NOT IN (SELECT udcdedcode FROM dbo.U_dsi_BDM_DeductionCodes WHERE UdcFormatCode = @FormatCode AND UdcDedTarget = 'AGR')
        AND EXISTS (SELECT 1 FROM dbo.BenReduc WHERE reddedcode = BcaDedCode) 
        AND BcaFormatCode = @FormatCode;

    -----------------------------------------------------------------------------------
    --Update EE Age Graded Rate Amount, based on Spouse Life Amount Age Calculation:
    -----------------------------------------------------------------------------------
    UPDATE dbo.U_dsi_bdm_BenCalculationAmounts
    SET BcaBenAmtCalc = dep.BcaBenAmtCalc
        ,BcaCalcRowStatus = 'Age Graded Rate Benefit Amount reduction rule triggered on Dependents Age'
    FROM dbo.u_dsi_bdm_BenCalculationAmounts
    INNER JOIN (
        SELECT bcaeeid eeid
            ,bcacoid coid
            ,BcaDedCode dedcode
            ,BcaBenAmtCalc
        FROM dbo.u_dsi_bdm_BenCalculationAmounts
        WHERE BcaDepRecID IS NOT NULL
        AND BcaDedCode IN (SELECT udcdedcode FROM dbo.U_dsi_BDM_DeductionCodes WHERE UdcFormatCode = @FormatCode AND UdcDedTarget = 'DAG')
    ) dep
        ON dep.eeid = BcaEEID
        AND dep.coid = bcacoid
        AND dep.dedcode = BcaDedCode
    WHERE BcaDepRecID IS NULL AND BcaFormatCode = @FormatCode
    AND BcaDedCode IN (SELECT udcdedcode FROM dbo.U_dsi_BDM_DeductionCodes WHERE UdcFormatCode = @FormatCode AND UdcDedTarget = 'DAG')
    AND BcaDedCode NOT IN (SELECT udcdedcode FROM dbo.U_dsi_BDM_DeductionCodes WHERE UdcFormatCode = @FormatCode AND UdcDedTarget = 'AGR')
    AND EXISTS (SELECT 1 FROM dbo.BenReduc WHERE reddedcode = BcaDedCode);

    --=================================================================================
    --Update Calculated Amount if Rounding Rule Applies
    --=================================================================================
    UPDATE dbo.u_dsi_bdm_BenCalculationAmounts
    SET BcaBenAmtCalc = CASE WHEN BcaBenAmtRoundingRule = '10' THEN ROUND(BcaBenAmtCalc, 0) --'Normal to Nearest dollar'
                             WHEN BcaBenAmtRoundingRule = '11' THEN ROUND(BcaBenAmtCalc, - 1) --'Normal to Nearest Ten'
                             WHEN BcaBenAmtRoundingRule = '12' THEN ROUND(BcaBenAmtCalc, - 2) --'Normal to Nearest Hundred'
                             WHEN BcaBenAmtRoundingRule = '13' THEN ROUND(BcaBenAmtCalc, - 3) --'Normal to Nearest Thousand'
                             WHEN BcaBenAmtRoundingRule = '20' THEN CEILING(BcaBenAmtCalc) --'Up to Next dollar'
                             WHEN BcaBenAmtRoundingRule = '21' THEN CEILING(BcaBenAmtCalc / 10) * 10 --'Up to Next Ten'
                             WHEN BcaBenAmtRoundingRule = '22' THEN CEILING(BcaBenAmtCalc / 100) * 100 --'Up to Next Hundred'
                             WHEN BcaBenAmtRoundingRule = '23' THEN CEILING(BcaBenAmtCalc / 1000) * 1000 --'Up to Next Hundred'
                        END
        ,BcaCalcRowStatus = 'Benefit Amount Rounding Rule Applied'
    FROM dbo.u_dsi_bdm_BenCalculationAmounts
    WHERE BcaBenAmtRoundingRule <> 'Z' AND BcaFormatCode = @FormatCode
    AND BcaDedCode NOT IN (SELECT udcdedcode FROM dbo.U_dsi_BDM_DeductionCodes WHERE UdcFormatCode = @FormatCode AND UdcDedTarget = 'SRR');

    --=================================================================================
    -- Updates for Employee and Employer Amounts - Insurance Rates: dbo.InsRate
    --=================================================================================

    -- Clear Calculation Amounts by Format Code
    DELETE dbo.U_dsi_bdm_bcaInsRate WHERE BcaInsFormatCode = @FormatCode;

    INSERT INTO dbo.U_dsi_bdm_bcaInsRate (BcaInsFormatCode,bcaInsDedcode,bcaInsMinAge,bcaInsMaxAge,bcaInsEERateNSFemale,bcaInsEERateSMFemale,bcaInsEERateNSMale,bcaInsEERateSMMale,bcaInsERRateNSFemale
        ,bcaInsERRateSMFemale,bcaInsERRateNSMale,bcaInsERRateSMMale,bcaInsEffDate,bcaInsPayFreq,bcaInsRowNum)
    SELECT @FormatCode
        ,Ratdedcode
        ,RatMinAge
        ,RatMaxAge
        ,RatEERateNSFemale
        ,RatEERateSMFemale
        ,RatEERateNSMale
        ,RatEERateSMMale
        ,RatERRateNSFemale
        ,RatERRateSMFemale
        ,RatERRateNSMale
        ,RatERRateSMMale
        ,RatEffDate
        ,RatPayFreq
        ,ROW_NUMBER() OVER (PARTITION BY Ratdedcode,RatMinAge,RatPayFreq ORDER BY RatEffDate DESC) --Removed ,RatMaxAge from calc order sequence, if Rate structure ages change
    FROM dbo.InsRate
    WHERE RatDedCode IN (SELECT DISTINCT udcdedcode FROM dbo.U_dsi_BDM_DeductionCodes WHERE UdcFormatCode = @FormatCode)
    AND RatEffDate <= @RateEffDate
    GROUP BY RatDedCode
        ,RatMinAge
        ,RatMaxAge
        ,RatEERateNSFemale
        ,RatEERateSMFemale
        ,RatEERateNSMale
        ,RatEERateSMMale
        ,RatERRateNSFemale
        ,RatERRateSMFemale
        ,RatERRateNSMale
        ,RatERRateSMMale
        ,Rateffdate
        ,RatPayFreq;

    DELETE dbo.U_dsi_bdm_bcaInsRate
    FROM dbo.U_dsi_bdm_bcaInsRate
    WHERE bcaInsRowNum <> 1 AND BcaInsFormatCode = @FormatCode;

    DELETE dbo.U_dsi_bdm_bcaInsRate
    FROM dbo.U_dsi_bdm_bcaInsRate C
    INNER JOIN (SELECT bcaInsDedcode, MAX(bcaInsEffDate) Dt 
                FROM dbo.U_dsi_bdm_bcaInsRate 
                GROUP BY bcaInsDedcode) O ON O.bcaInsDedcode = C.bcaInsDedcode AND O.Dt <> C.bcaInsEffDate
    WHERE bcaInsFormatCode = @FormatCode;
        

    -----------------------------------------------------------------------------------
    --Update Calculated Amount if Age Graded Rate Applies for Insurance Rate
    -----------------------------------------------------------------------------------
    UPDATE dbo.u_dsi_bdm_BenCalculationAmounts
    SET BcaEEAmt = (CASE WHEN EepGender = 'M' AND EepIsSmoker = 'N' THEN bcaInsEERateNSMale
                         WHEN EepGender = 'M' AND EepIsSmoker = 'Y' THEN bcaInsEERateSMMale
                         WHEN EepGender = 'F' AND EepIsSmoker = 'N' THEN bcaInsEERateNSFemale
                         WHEN EepGender = 'F' AND EepIsSmoker = 'Y' THEN bcaInsEERateSMFemale
                    END) * (BcaBenAmtCalc / 1000)
        ,BcaERAmt = (CASE WHEN EepGender = 'M' AND EepIsSmoker = 'N' THEN bcaInsERRateNSMale
                          WHEN EepGender = 'M' AND EepIsSmoker = 'Y' THEN bcaInsERRateSMMale
                          WHEN EepGender = 'F' AND EepIsSmoker = 'N' THEN bcaInsERRateNSFemale
                          WHEN EepGender = 'F' AND EepIsSmoker = 'Y' THEN bcaInsERRateSMFemale
                    END) * (BcaBenAmtCalc / 1000)
    FROM dbo.u_dsi_bdm_BenCalculationAmounts
    INNER JOIN dbo.emppers WITH (NOLOCK)
        ON Bcaeeid = EepEEID
    INNER JOIN dbo.empcomp WITH (NOLOCK)
        ON Bcaeeid = EecEEID
        AND Bcacoid = EecCOID
    LEFT JOIN @InsRateAsOfDateValues E ON InsRateDedCode = BcaDedCode
    INNER JOIN dbo.U_dsi_bdm_bcaInsRate WITH (NOLOCK)
        ON bcaInsDedCode = BcaDedCode
        AND bcaInsPayFreq = EecPayPeriod
        --AND ((FLOOR(DATEDIFF(DAY, EepDateOfBirth, ISNULL(InsRateAsOfDate,ISNULL(BcaAgeAsOfDate, GETDATE()))) / 365.242199) >= bcaInsMinAge)
        --    AND (FLOOR(DATEDIFF(DAY, EepDateOfBirth, ISNULL(InsRateAsOfDate,ISNULL(BcaAgeAsOfDate, GETDATE()))) / 365.242199) < bcaInsMaxAge)
        --)
        AND ((DATEDIFF(hour,EepDateOfBirth,ISNULL(InsRateAsOfDate,ISNULL(BcaAgeAsOfDate, GETDATE())))/8766 >= bcaInsMinAge)
            AND (DATEDIFF(hour,EepDateOfBirth,ISNULL(InsRateAsOfDate,ISNULL(BcaAgeAsOfDate, GETDATE())))/8766 < bcaInsMaxAge)
        )
    WHERE EXISTS (SELECT 1 FROM dbo.U_dsi_bdm_bcaInsRate WHERE bcaInsDedCode = BcaDedCode AND BcaInsFormatCode = @FormatCode)
        AND BcaDedEECalcRule <> 32
        AND bcaFormatCode = @FormatCode;

    UPDATE dbo.u_dsi_bdm_BenCalculationAmounts
    SET BcaEEAmt = (CASE WHEN ConGender = 'M' AND ConIsSmoker = 'N' THEN bcaInsEERateNSMale
                         WHEN ConGender = 'M' AND ConIsSmoker = 'Y' THEN bcaInsEERateSMMale
                         WHEN ConGender = 'F' AND ConIsSmoker = 'N' THEN bcaInsEERateNSFemale
                         WHEN ConGender = 'F' AND ConIsSmoker = 'Y' THEN bcaInsEERateSMFemale
                    END) * (BcaBenAmtCalc / 1000)
        ,BcaERAmt = (CASE WHEN ConGender = 'M' AND ConIsSmoker = 'N' THEN bcaInsERRateNSMale
                          WHEN ConGender = 'M' AND ConIsSmoker = 'Y' THEN bcaInsERRateSMMale
                          WHEN ConGender = 'F' AND ConIsSmoker = 'N' THEN bcaInsERRateNSFemale
                          WHEN ConGender = 'F' AND ConIsSmoker = 'Y' THEN bcaInsERRateSMFemale
                    END) * (BcaBenAmtCalc / 1000)
    FROM dbo.u_dsi_bdm_BenCalculationAmounts
    INNER JOIN dbo.emppers WITH (NOLOCK)
        ON Bcaeeid = EepEEID
    INNER JOIN dbo.empcomp WITH (NOLOCK)
        ON Bcaeeid = EecEEID
        AND Bcacoid = EecCOID
    INNER JOIN dbo.Contacts WITH (NOLOCK)
        ON BcaEEID = ConEEID
        AND BcaDepRecID = ConSystemID
    LEFT JOIN @InsRateAsOfDateValues E ON InsRateDedCode = BcaDedCode
    INNER JOIN dbo.U_dsi_bdm_bcaInsRate WITH (NOLOCK)
        ON bcaInsDedCode = BcaDedCode
        AND bcaInsPayFreq = EecPayPeriod
        --AND ((FLOOR(DATEDIFF(DAY, ConDateOfBirth, ISNULL(InsRateAsOfDate,ISNULL(BcaAgeAsOfDate, GETDATE()))) / 365.242199) >= bcaInsMinAge)
        --    AND (FLOOR(DATEDIFF(DAY, ConDateOfBirth, ISNULL(InsRateAsOfDate,ISNULL(BcaAgeAsOfDate, GETDATE()))) / 365.242199) < bcaInsMaxAge)
        --)
        AND ((DATEDIFF(hour,ConDateOfBirth,ISNULL(InsRateAsOfDate,ISNULL(BcaAgeAsOfDate, GETDATE())))/8766 >= bcaInsMinAge)
            AND (DATEDIFF(hour,ConDateOfBirth,ISNULL(InsRateAsOfDate,ISNULL(BcaAgeAsOfDate, GETDATE())))/8766 < bcaInsMaxAge)
        )
    WHERE BcaDepRecID IS NOT NULL
        AND EXISTS (SELECT 1 FROM dbo.U_dsi_bdm_bcaInsRate WHERE bcaInsDedCode = BcaDedCode AND BcaInsFormatCode = @FormatCode)
        AND BcaDedEECalcRule = 32
        AND bcaFormatCode = @FormatCode;

    --Copy Dependent Calculated Premium Up to EE record:
    UPDATE dbo.U_dsi_bdm_BenCalculationAmounts
    SET BcaEEAmt = dp.BcaEEAmt,
        BcaERAmt = dp.BcaERAmt
    FROM dbo.U_dsi_bdm_BenCalculationAmounts
    JOIN (SELECT BcaEEID eeid, BcaCOID coid, BcaDedCode dedcode, BcaEEAmt, BcaERAmt
        FROM dbo.U_dsi_bdm_BenCalculationAmounts
        WHERE BcaFormatCode = @FormatCode 
            AND BcaDepRecID IS NOT NULL
            AND BcaDedEECalcRule = 32) dp on dp.eeid = bcaeeid AND dp.coid = BcaCoID AND dp.dedcode = BcaDedCode
    WHERE BcaDepRecID IS NULL 
        AND BcaFormatCode = @FormatCode;

    --=================================================================================
    -- Updates for Employee and Employer Amounts - Insurance Rates: dbo.OptRate
    --=================================================================================

    -- Clear Calculation Amounts by Format Code
    DELETE dbo.U_dsi_bdm_bcaOptRate WHERE BcaORFormatCode = @FormatCode;

    INSERT INTO dbo.U_dsi_bdm_bcaOptRate (bcaORFormatCode,bcaORDedcode,bcaORBenOption,bcaOREERate,bcaORERRate,bcaORPayFreq,bcaORRowNum)
    SELECT @FormatCode
        ,Cordedcode
        ,Corbenoption
        ,CorEERate
        ,CorERRate
        ,CorPayFreq
        ,ROW_NUMBER() OVER (PARTITION BY cordedcode,corbenoption,corpayfreq ORDER BY CorEffDate DESC)
    FROM dbo.optrate
    WHERE CorDedCode IN (SELECT DISTINCT udcdedcode FROM dbo.U_dsi_BDM_DeductionCodes WHERE UdcFormatCode = @FormatCode)
    AND CorEffDate <= @RateEffDate
    GROUP BY CorDedCode
        ,CorBenOption
        ,coreffdate
        ,CorEERate
        ,CorERRate
        ,CorPayFreq;

    DELETE dbo.U_dsi_bdm_bcaOptRate
    FROM dbo.U_dsi_bdm_bcaOptRate
    WHERE bcaORRowNum <> 1 AND bcaORFormatCode = @FormatCode;

    UPDATE dbo.u_dsi_bdm_BenCalculationAmounts
    SET BcaEEAmt = bcaOREERate
        ,BcaERAmt = bcaORERRate
    FROM dbo.u_dsi_bdm_BenCalculationAmounts
    INNER JOIN dbo.emppers WITH (NOLOCK)
        ON Bcaeeid = EepEEID
    INNER JOIN dbo.empcomp WITH (NOLOCK)
        ON Bcaeeid = EecEEID
        AND Bcacoid = EecCOID
    INNER JOIN dbo.U_dsi_bdm_bcaOptRate WITH (NOLOCK)
        ON BcaORDedCode = BcaDedCode
        AND BcaORPayFreq = EecPayPeriod
        AND BcaORBenOption = BcaBenOption
    WHERE EXISTS (SELECT 1 FROM dbo.U_dsi_bdm_bcaOptRate WHERE bcaORDedCode = BcaDedCode AND bcaORFormatCode = @FormatCode);
    
    --=================================================================================
    -- Updates for Employee and Employer Amounts - Calculation Rule = Benefit Amount * Rate
    --=================================================================================
    UPDATE dbo.u_dsi_bdm_BenCalculationAmounts
    SET BcaEEAmt = ISNULL((bcaBenAmtCalc/1000) * BcaDedEECalcRateOrPct,0.00)
    FROM dbo.u_dsi_bdm_BenCalculationAmounts
    WHERE BcaDedEECalcRule = '30' AND bcaFormatCode = @FormatCode;

    UPDATE dbo.u_dsi_bdm_BenCalculationAmounts
    SET BcaERAmt = ISNULL((bcaBenAmtCalc/1000) * BcaDedERCalcRateOrPct,0.00)
    FROM dbo.u_dsi_bdm_BenCalculationAmounts
    WHERE BcaDedERCalcRule = '30' AND bcaFormatCode = @FormatCode;

    --=================================================================================
    -- Updates for Employee and Employer Amounts - Calculation Rule = Flat Amount
    --=================================================================================
    UPDATE dbo.u_dsi_bdm_BenCalculationAmounts
    SET BcaEEAmt = CASE WHEN EecPayPeriod = 'B' THEN dedEEBiWeeklyAmt
                        WHEN EecPayPeriod = 'W' THEN dedEEWeeklyAmt
                        WHEN EecPayPeriod = 'M' THEN dedEEMonthlyAmt
                        WHEN EecPayPeriod = 'S' THEN dedEESemiMonthlyAmt
                   END
    FROM dbo.u_dsi_bdm_BenCalculationAmounts
    INNER JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = bcaeeid
        AND EecCOID = bcacoid
    INNER JOIN dbo.DedCode WITH (NOLOCK)
        ON BcaDedCode = DedDedCode
    WHERE BcaDedEECalcRule = '20' AND bcaFormatCode = @FormatCode;

    UPDATE dbo.u_dsi_bdm_BenCalculationAmounts
    SET BcaERAmt = CASE WHEN EecPayPeriod = 'B' THEN dedERBiWeeklyAmt
                        WHEN EecPayPeriod = 'W' THEN dedERWeeklyAmt
                        WHEN EecPayPeriod = 'M' THEN dedERMonthlyAmt
                        WHEN EecPayPeriod = 'S' THEN dedERSemiMonthlyAmt
                   END
    FROM dbo.u_dsi_bdm_BenCalculationAmounts
    INNER JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = bcaeeid
        AND EecCOID = bcacoid
    INNER JOIN dbo.DedCode WITH (NOLOCK)
        ON BcaDedCode = DedDedCode
    WHERE BcaDedERCalcRule = '20' AND bcaFormatCode = @FormatCode;

END;
GO