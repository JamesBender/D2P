/**********************************************************************************

EBENPRGIE2: Benefits Prime Demographic ExportV2

FormatCode:     EBENPRGIE2
Project:        Benefits Prime Demographic ExportV2
Client ID:      SAF1006
Date/time:      2022-09-28 13:58:44.177
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    NWP
Server:         NW1WUP3DB02
Database:       ULTIPRO_WPSAFEB
Web Filename:   SAF1006_4I7VG_EEHISTORY_EBENPRGIE2_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EBENPRGIE2_SavePath') IS NOT NULL DROP TABLE dbo.U_EBENPRGIE2_SavePath


-----------
-- Create U_dsi_RipoutParms if it doesn't exist
-----------

IF OBJECT_ID('U_dsi_RipoutParms') IS NULL BEGIN

   CREATE TABLE dbo.U_dsi_RipoutParms (
   rpoFormatCode  VARCHAR(10)   NOT NULL,
   rpoParmType    VARCHAR(64)   NOT NULL,
   rpoParmValue01 VARCHAR(1024) NULL,
   rpoParmValue02 VARCHAR(1024) NULL,
   rpoParmValue03 VARCHAR(1024) NULL,
   rpoParmValue04 VARCHAR(1024) NULL,
   rpoParmValue05 VARCHAR(1024) NULL
)
END


-----------
-- Clear U_dsi_RipoutParms
-----------

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EBENPRGIE2'


-----------
-- Add paths to U_dsi_RipoutParms
-----------

INSERT INTO dbo.U_dsi_RipoutParms (rpoFormatCode, rpoParmType, rpoParmValue01, rpoParmValue02)
SELECT

FormatCode,
'Path',
CfgName,
CfgValue

FROM dbo.U_Dsi_Configuration
WHERE FormatCode = 'EBENPRGIE2'
AND CfgName LIKE '%path%'


-----------
-- Add AscExp expSystemIDs to U_dsi_RipoutParms
-----------

INSERT INTO dbo.U_dsi_RipoutParms (rpoFormatCode, rpoParmType, rpoParmValue01, rpoParmValue02) 
SELECT

ExpFormatCode,
'expSystemID',
ExpExportCode,
ExpSystemID

FROM dbo.AscExp
WHERE ExpFormatCode = 'EBENPRGIE2'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EBENPRGIE2')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EBENPRGIE2'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EBENPRGIE2'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EBENPRGIE2'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EBENPRGIE2'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EBENPRGIE2'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EBENPRGIE2'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EBENPRGIE2'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EBENPRGIE2'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EBENPRGIE2'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEBENPRGIE2_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEBENPRGIE2_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EBENPRGIE2') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EBENPRGIE2];
GO
IF OBJECT_ID('U_EBENPRGIE2_File') IS NOT NULL DROP TABLE [dbo].[U_EBENPRGIE2_File];
GO
IF OBJECT_ID('U_EBENPRGIE2_EEList') IS NOT NULL DROP TABLE [dbo].[U_EBENPRGIE2_EEList];
GO
IF OBJECT_ID('U_EBENPRGIE2_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EBENPRGIE2_drvTbl];
GO
IF OBJECT_ID('U_EBENPRGIE2_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EBENPRGIE2_AuditFields];
GO
IF OBJECT_ID('U_EBENPRGIE2_Audit') IS NOT NULL DROP TABLE [dbo].[U_EBENPRGIE2_Audit];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EBENPRGIE2','Benefits Prime Demographic ExportV2','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','EBENPRGIE2Z0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EBENPRGIE2Z0','50','H','01','1',NULL,'organization_id',NULL,NULL,'"organization_id"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EBENPRGIE2Z0','50','H','01','2',NULL,'SSN',NULL,NULL,'"SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EBENPRGIE2Z0','50','H','01','3',NULL,'current_salary_effective_on',NULL,NULL,'"current_salary_effective_on"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EBENPRGIE2Z0','50','H','01','4',NULL,'udef_5',NULL,NULL,'"udef_5"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EBENPRGIE2Z0','50','H','01','5',NULL,'business_title)',NULL,NULL,'"business_title"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EBENPRGIE2Z0','50','H','01','6',NULL,'udef_6',NULL,NULL,'"udef_6"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EBENPRGIE2Z0','50','H','01','7',NULL,'udef_7',NULL,NULL,'"udef_7"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EBENPRGIE2Z0','50','H','01','8',NULL,'udef_8',NULL,NULL,'"udef_8"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EBENPRGIE2Z0','50','D','10','1',NULL,'organization_id',NULL,NULL,'"2786818"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EBENPRGIE2Z0','50','D','10','2',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EBENPRGIE2Z0','50','D','10','3',NULL,'X -Effective Salary Date',NULL,NULL,'"drvEffectiveSalaryDate"','(''UD112''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EBENPRGIE2Z0','50','D','10','4',NULL,'X -Work Location State',NULL,NULL,'"drvWorkLocationState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EBENPRGIE2Z0','50','D','10','5',NULL,'X -Business Title (Job Description)',NULL,NULL,'"drvBusinessTitle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EBENPRGIE2Z0','50','D','10','6',NULL,'X -Previous Annual Salary (FT to PT)',NULL,NULL,'"drvPreviousAnnualSalary"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EBENPRGIE2Z0','50','D','10','7',NULL,'X -Date Last Worked',NULL,NULL,'"drvDateLastWorked"','(''UD112''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EBENPRGIE2Z0','50','D','10','8',NULL,'X -UKG Term Reason',NULL,NULL,'"drvUKGTermReason"','(''UA''=''T'')');

-----------
-- Build web filename
-----------

/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME, 1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME, 3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME, 2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME, 3) ELSE LEFT(@@SERVERNAME, 2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME, 2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME, 3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FileName varchar(1000) = 'EBENPRGIE2_20220928.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Benefits Prime Demographic Exp','202208109','EMPEXPORT','ONDEM_XOE',NULL,'EBENPRGIE2',NULL,NULL,NULL,'202208109','Aug 21 2020 12:37PM','Aug 21 2020 12:37PM','202208101',NULL,'','','202208101',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N',',CWMD1,V7CQG',NULL,NULL,NULL,'Benefits Prime Demograph-Sched','202208109','EMPEXPORT','SCH_EBENPR',NULL,'EBENPRGIE2',NULL,NULL,NULL,'202208109','Aug 21 2020 12:37PM','Aug 21 2020 12:37PM','202208101',NULL,'','','202208101',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Benefits Prime Demograph-Test','202208109','EMPEXPORT','TEST_XOE','Sep 10 2022 12:00AM','EBENPRGIE2',NULL,NULL,NULL,'202208109','Aug 10 2022 12:00AM','Dec 30 1899 12:00AM','202208101','1246','','','202208101',dbo.fn_GetTimedKey(),NULL,'us3cPeSAF1006',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBENPRGIE2','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBENPRGIE2','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBENPRGIE2','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBENPRGIE2','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBENPRGIE2','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBENPRGIE2','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBENPRGIE2','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBENPRGIE2','D10','dbo.U_EBENPRGIE2_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EBENPRGIE2_Audit
-----------

IF OBJECT_ID('U_EBENPRGIE2_Audit') IS NULL
CREATE TABLE [dbo].[U_EBENPRGIE2_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audKey2] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NULL,
    [audOldValue] nvarchar(2000) NULL,
    [audNewValue] nvarchar(2000) NULL,
    [audRowNo] bigint NULL
);

-----------
-- Create table U_EBENPRGIE2_AuditFields
-----------

IF OBJECT_ID('U_EBENPRGIE2_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EBENPRGIE2_AuditFields] (
    [aTableName] varchar(128) NULL,
    [aFieldName] varchar(128) NULL
);

-----------
-- Create table U_EBENPRGIE2_drvTbl
-----------

IF OBJECT_ID('U_EBENPRGIE2_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EBENPRGIE2_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvEffectiveSalaryDate] datetime NULL,
    [drvWorkLocationState] varchar(255) NULL,
    [drvBusinessTitle] varchar(8000) NULL,
    [drvPreviousAnnualSalary] nvarchar(4000) NULL,
    [drvDateLastWorked] datetime NULL,
    [drvUKGTermReason] varchar(27) NULL
);

-----------
-- Create table U_EBENPRGIE2_EEList
-----------

IF OBJECT_ID('U_EBENPRGIE2_EEList') IS NULL
CREATE TABLE [dbo].[U_EBENPRGIE2_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EBENPRGIE2_File
-----------

IF OBJECT_ID('U_EBENPRGIE2_File') IS NULL
CREATE TABLE [dbo].[U_EBENPRGIE2_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EBENPRGIE2]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: SAFEbuilt

Created By: James Bender
Business Analyst: Cheryl Petitti
Create Date: 08/21/2020
Service Request Number: TekP-2020-06-26-0004

Purpose: Benefits Prime Demographic ExportV2

Revision History
----------------
Update By           Date           Request Num        Desc
Marie Waters      08/01/2022     TekP-2022-07-22-02   Remove and add columns

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EBENPRGIE2';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EBENPRGIE2';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EBENPRGIE2';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EBENPRGIE2';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EBENPRGIE2' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBENPRGIE2', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBENPRGIE2', 'TEST_XOE';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EBENPRGIE2', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EBENPRGIE2';

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
    DELETE FROM dbo.U_EBENPRGIE2_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EBENPRGIE2_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --DELETE FROM dbo.U_EBENPRGIE2_EEList
    --WHERE xEEID IN (SELECT DISTINCT EecEEID from dbo.EmpComp WITH (NOLOCK) WHERE EecDedGroupCode IN ('NONE','401'));

    DELETE FROM dbo.U_EBENPRGIE2_EEList
    WHERE xEEID IN (SELECT DISTINCT EecEEID FROM dbo.EmpComp WITH (NOLOCK) WHERE eecEEType IN('TES', 'Z'));


      --Audit Table
    IF OBJECT_ID('U_EBENPRGIE2_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EBENPRGIE2_AuditFields;
    CREATE TABLE dbo.U_EBENPRGIE2_AuditFields (aTableName varchar(128),aFieldName varchar(128));
    
    -- Insert tables/fields to be audited
    INSERT INTO dbo.U_EBENPRGIE2_AuditFields VALUES ('EmpComp','EecFulltimeorParttime');  
   -- INSERT INTO dbo.U_EBENPRGIE2_AuditFields VALUES ('EmpComp','EecTermReason');
    INSERT INTO dbo.U_EBENPRGIE2_AuditFields VALUES ('EmpComp','EecEmplStatus');
             
    -- Create audit table
    IF OBJECT_ID('U_EBENPRGIE2_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EBENPRGIE2_Audit;
  SELECT *
  INTO dbo.U_EBENPRGIE2_Audit 
  FROM (SELECT 
         audEEID  = audKey1Value
        ,audKey2 = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime =max(audDateTime)
        ,audOldValue 
        ,audNewValue
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EBENPRGIE2_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    
        WHERE audDateTime BETWEEN  dateadd(D, -14, @StartDate) AND @EndDate
             AND audAction = 'Update'
             and  audFieldName = 'EecEmplStatus'
             and audNewValue In ('T')
        Group by    audKey1Value
        , audKey2Value
        ,audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime 
        ,audOldValue
        ,audNewValue) rn
        where audRowNo = 1

    Union 

    Select * from (Select   audEEID  = audKey1Value
                            ,audKey2 = audKey2Value
                            ,audKey3 = audKey3Value
                            ,audTableName2 =audTableName
                            ,audFieldName2 = audFieldName
                            ,audAction2 = audAction
                            ,audDateTime2 =audDateTime
                            ,audOldValue2 = audOldValue 
                            ,audNewValue2 =audNewValue
                            ,audRowNo2 = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
                            FROM dbo.vw_AuditData WITH (NOLOCK) 
                        JOIN dbo.U_EBENPRGIE2_AuditFields WITH (NOLOCK) 
                            ON audTableName = aTableName
                            AND audFieldName = aFieldName
                             WHERE audDateTime BETWEEN  @StartDate  AND @EndDate
                                 and audAction = 'Update'
                                and audFieldName = 'EecFullTimeOrPartTime'
                                and audOldValue  = 'F' and audNewValue = 'P'
                            Group by    audKey1Value
                            ,audKey2Value
                            ,audKey3Value
                            ,audTableName
                            ,audFieldName
                            ,audAction
                            ,audDateTime 
                            ,audOldValue
                            ,audNewValue
                            ) rn
                            where audRowNo2 = 1
                            
       
       

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EBENPRGIE2_Audit ON dbo.U_EBENPRGIE2_Audit (audEEID,audKey2);


    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EBENPRGIE2_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EBENPRGIE2_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EBENPRGIE2_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvEffectiveSalaryDate = dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(xEEID, xCOID, GETDATE(), EecDateOfLastHire)
        ,drvWorkLocationState = LocAddressState
       -- ,drvAlternativeEmail = EepAddressEMailAlternate
       -- ,drvPreferredLanguage = EecLanguageCode
        ,drvBusinessTitle = REPLACE(JbcDesc, ',', ' ') --REPLACE(EecJobtitle, ',', ' ') --
        ,drvPreviousAnnualSalary = Format(CASE WHEN ejhannsalary is not null THEN ejhannsalary  END, '0.00')
        ,drvDateLastWorked = CASE WHEN EecEmplStatus = 'T' THEN EecDateLastWorked END
        ,drvUKGTermReason =  CASE WHEN EecTermReason = '202' THEN 'Retirement/Early Retirement'
                                  WHEN EecTermReason = '203' THEN 'Death'
                                  WHEN EecTermReason = '999' THEN 'Disability'
                                  WHEN EecTermReason NOT IN ( '202', '203', '999') THEN 'Resignation/Termination'
                                END
    INTO dbo.U_EBENPRGIE2_drvTbl
    FROM dbo.U_EBENPRGIE2_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    LEFT JOIN dbo.JobCode WITH (NOLOCK)
        ON EecJobCode = jbcJobCode
    Left Join dbo.U_EBENPRGIE2_Audit  WITH (NOLOCK)
        ON audEEID = xEEID
    LEFT JOIN (SELECT  EjhEEID, EjhCOID, EjhReason, Max(EjhJobEffDate) AS MaxJobEffDate, ejhannsalary
                FROM (
                        SELECT distinct EjhEEID, EjhCOID, EjhReason, EjhJobEffDate, ejhannsalary ,ROW_NUMBER() OVER(PARTITION BY EjhEEID, EjhCOID ORDER BY EjhJobEffDate DESC) AS RN
                        FROM dbo.EmpHJob WITH (NOLOCK)
                         Join dbo.U_EBENPRGIE2_Audit  WITH (NOLOCK)
                         ON audEEID = EjhEEID
                        Where audFieldName  = 'EecFullTimeOrPartTime'
                        AND AudDateTime BETWEEN DATEADD(DAY, -14, @StartDate) AND @EndDate) AS InnerEjh
                WHERE RN = 1
                --and ejheeid = 'CF536K01O0K0'
                Group By EjhEEID, EjhCOID, EjhReason ,ejhannsalary) SAL
            ON EjhEEID = xEEID
            and EjhCOID = xCOID

    WHERE ( EecOrgLvl3 <> 'ACQ' and EecEEType NOT IN  ( 'TES', 'CON', 'Z', 'BRD') and EecDedGroupCode NOT IN  ('NONE' , '401'))
    and (EecEmplStatus <> 'T' or (  EecEmplStatus <> 'T' OR (AudNewValue = 'T'  AND AudDateTime BETWEEN DATEADD(DAY, -14, @StartDate) AND @EndDate)))
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
ALTER VIEW dbo.dsi_vwEBENPRGIE2_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EBENPRGIE2_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EBENPRGIE2%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202209151'
       ,expStartPerControl     = '202209151'
       ,expLastEndPerControl   = '202209269'
       ,expEndPerControl       = '202209269'
WHERE expFormatCode = 'EBENPRGIE2';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEBENPRGIE2_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EBENPRGIE2_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EBENPRGIE2' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EBENPRGIE2'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EBENPRGIE2'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EBENPRGIE2', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EBENPRGIE2', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EBENPRGIE2', 'UseFileName', 'V', 'Y'


-- End ripout