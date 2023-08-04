/**********************************************************************************

ELAWUPDATE: LawLogix Update Export

FormatCode:     ELAWUPDATE
Project:        LawLogix Update Export
Client ID:      ECO1002
Date/time:      2023-08-04 08:40:23.863
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    nwp
Server:         nw1wup9db01
Database:       ULTIPRO_WPECOE
Web Filename:   ECO1002_LWZK5_EEHISTORY_ELAWUPDATE_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ELAWUPDATE_SavePath') IS NOT NULL DROP TABLE dbo.U_ELAWUPDATE_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ELAWUPDATE'


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
WHERE FormatCode = 'ELAWUPDATE'
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
WHERE ExpFormatCode = 'ELAWUPDATE'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ELAWUPDATE')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ELAWUPDATE'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ELAWUPDATE'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ELAWUPDATE'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ELAWUPDATE'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ELAWUPDATE'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ELAWUPDATE'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ELAWUPDATE'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ELAWUPDATE'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ELAWUPDATE'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwELAWUPDATE_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwELAWUPDATE_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ELAWUPDATE') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ELAWUPDATE];
GO
IF OBJECT_ID('U_ELAWUPDATE_File') IS NOT NULL DROP TABLE [dbo].[U_ELAWUPDATE_File];
GO
IF OBJECT_ID('U_ELAWUPDATE_EEList') IS NOT NULL DROP TABLE [dbo].[U_ELAWUPDATE_EEList];
GO
IF OBJECT_ID('U_ELAWUPDATE_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ELAWUPDATE_drvTbl];
GO
IF OBJECT_ID('U_ELAWUPDATE_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ELAWUPDATE_AuditFields];
GO
IF OBJECT_ID('U_ELAWUPDATE_Audit') IS NOT NULL DROP TABLE [dbo].[U_ELAWUPDATE_Audit];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ELAWUPDATE',' LawLogix Update Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','ELAWUPDATEZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ELAWUPDATEZ0','50','H','01','1',NULL,'ID.profileId',NULL,NULL,'"ID.profileId"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ELAWUPDATEZ0','50','H','01','2',NULL,'startDate',NULL,NULL,'"startDate"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ELAWUPDATEZ0','50','H','01','3',NULL,'legalEntity.name',NULL,NULL,'"legalEntity.name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ELAWUPDATEZ0','50','H','01','4',NULL,'locationId.name',NULL,NULL,'"locationId.name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ELAWUPDATEZ0','50','H','01','5',NULL,'locationId.number',NULL,NULL,'"locationId.number"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ELAWUPDATEZ0','50','H','01','6',NULL,'firstName',NULL,NULL,'"firstName"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ELAWUPDATEZ0','50','H','01','7',NULL,'lastName',NULL,NULL,'"lastName"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ELAWUPDATEZ0','50','H','01','8',NULL,'emailAddress',NULL,NULL,'"emailAddress"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ELAWUPDATEZ0','50','D','10','1',NULL,'ID.profileId',NULL,NULL,'"drvProfileID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ELAWUPDATEZ0','50','D','10','2',NULL,'startDate',NULL,NULL,'"drvStartDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ELAWUPDATEZ0','50','D','10','3',NULL,'legalEntity.name',NULL,NULL,'"drvLocationidName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ELAWUPDATEZ0','50','D','10','4',NULL,'locationId.name',NULL,NULL,'"drvLocationidNumber"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ELAWUPDATEZ0','50','D','10','5',NULL,'locationId.number',NULL,NULL,'"drvLegalentityName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ELAWUPDATEZ0','50','D','10','6',NULL,'firstName',NULL,NULL,'"drvFirstname"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ELAWUPDATEZ0','50','D','10','7',NULL,'lastName',NULL,NULL,'"drvLastname"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ELAWUPDATEZ0','50','D','10','8',NULL,'emailAddress',NULL,NULL,'"drvEmailaddress"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ELAWUPDATE_20230804.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,' LawLogix Update Export','202308029','EMPEXPORT','ONDEM_XOE',NULL,'ELAWUPDATE',NULL,NULL,NULL,'202308029','Aug  2 2023  2:29PM','Aug  2 2023  2:29PM','202307261',NULL,'','','202307261',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'LawLogix Update Export-Sched','202308029','EMPEXPORT','SCH_ELAWUP',NULL,'ELAWUPDATE',NULL,NULL,NULL,'202308029','Aug  2 2023  2:29PM','Aug  2 2023  2:29PM','202307261',NULL,'','','202307261',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'LawLogix Update Export-Test','202308029','EMPEXPORT','TEST_XOE',NULL,'ELAWUPDATE',NULL,NULL,NULL,'202308029','Aug  2 2023  2:29PM','Aug  2 2023  2:29PM','202307261',NULL,'','','202307261',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELAWUPDATE','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELAWUPDATE','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELAWUPDATE','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELAWUPDATE','NoEmpty','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELAWUPDATE','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELAWUPDATE','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELAWUPDATE','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELAWUPDATE','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ELAWUPDATE','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ELAWUPDATE','D10','dbo.U_ELAWUPDATE_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_ELAWUPDATE_Audit
-----------

IF OBJECT_ID('U_ELAWUPDATE_Audit') IS NULL
CREATE TABLE [dbo].[U_ELAWUPDATE_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audKey2] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] nvarchar(2000) NULL,
    [audNewValue] nvarchar(2000) NULL,
    [audRowNo] bigint NULL,
    [audEmailChg] nvarchar(2000) NULL,
    [audStatusChg] nvarchar(2000) NULL,
    [audLocChg] nvarchar(2000) NULL,
    [audLocDescChg] nvarchar(2000) NULL,
    [audLNameChg] nvarchar(2000) NULL,
    [audFNameChg] nvarchar(2000) NULL,
    [audHireDateChg] nvarchar(2000) NULL
);

-----------
-- Create table U_ELAWUPDATE_AuditFields
-----------

IF OBJECT_ID('U_ELAWUPDATE_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ELAWUPDATE_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_ELAWUPDATE_drvTbl
-----------

IF OBJECT_ID('U_ELAWUPDATE_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ELAWUPDATE_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(9) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvProfileID] char(9) NULL,
    [drvStartDate] varchar(30) NULL,
    [drvLocationidName] varchar(40) NULL,
    [drvLocationidNumber] nvarchar(2000) NULL,
    [drvLegalentityName] nvarchar(2000) NULL,
    [drvFirstname] nvarchar(2000) NULL,
    [drvLastname] nvarchar(2000) NULL,
    [drvEmailaddress] nvarchar(2000) NULL
);

-----------
-- Create table U_ELAWUPDATE_EEList
-----------

IF OBJECT_ID('U_ELAWUPDATE_EEList') IS NULL
CREATE TABLE [dbo].[U_ELAWUPDATE_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ELAWUPDATE_File
-----------

IF OBJECT_ID('U_ELAWUPDATE_File') IS NULL
CREATE TABLE [dbo].[U_ELAWUPDATE_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ELAWUPDATE]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: 3E Company

Created By: Marie Waters
Business Analyst: Alex Bowan
Create Date: 08/02/2023
Service Request Number: TekP-2023-07-05-03

Purpose:  LawLogix Update Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ELAWUPDATE';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ELAWUPDATE';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ELAWUPDATE';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ELAWUPDATE';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ELAWUPDATE' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELAWUPDATE', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELAWUPDATE', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELAWUPDATE', 'SCH_ELAWUP';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ELAWUPDATE', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ELAWUPDATE';

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
    DELETE FROM dbo.U_ELAWUPDATE_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ELAWUPDATE_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    
    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_ELAWUPDATE_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ELAWUPDATE_AuditFields;
    CREATE TABLE dbo.U_ELAWUPDATE_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    

    INSERT INTO dbo.U_ELAWUPDATE_AuditFields VALUES ('EmpComp','EecEmplStatus');
    INSERT INTO dbo.U_ELAWUPDATE_AuditFields VALUES ('EmpComp','EecLocation');  
    INSERT INTO dbo.U_ELAWUPDATE_AuditFields VALUES ('EmpComp','EecDateOfLastHire');  
    INSERT INTO dbo.U_ELAWUPDATE_AuditFields VALUES ('EmpPers','EepNameFirst');
    INSERT INTO dbo.U_ELAWUPDATE_AuditFields VALUES ('EmpPers','EepNameLast');
    INSERT INTO dbo.U_ELAWUPDATE_AuditFields VALUES ('EmpPers','EepAddressEMail');
    INSERT INTO dbo.U_ELAWUPDATE_AuditFields VALUES ('Location','LocDesc');


    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ELAWUPDATE_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ELAWUPDATE_Audit;
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
        ,audEmailChg = CASE WHEN audFieldName LIKE 'EepAddressEMail' AND audAction = 'UPDATE' and ISNULL(audNewValue, '') <> '' THEN audNewValue END
        ,audStatusChg = CASE WHEN audFieldName IN('EecEmplStatus') AND audAction = 'UPDATE' AND  ISNULL(audNewValue, '') <> ''  THEN audNewValue END 
        ,audLocChg = CASE WHEN audFieldName IN('EecLocation') AND audAction = 'UPDATE' and ISNULL(audNewValue, '') <> ''  THEN audNewValue END
        ,audLocDescChg = CASE WHEN audFieldName IN('LocDesc') AND audAction = 'UPDATE' and ISNULL(audNewValue, '') <> ''  THEN audNewValue END
        ,audLNameChg = CASE WHEN audFieldName IN('EepNameLast') AND audAction = 'UPDATE' and ISNULL(audNewValue, '') <> '' THEN audNewValue  END
        ,audFNameChg = CASE WHEN audFieldName IN('EepNameFirst') AND audAction = 'UPDATE' and ISNULL(audNewValue, '') <> '' THEN audNewValue  END
        ,audHireDateChg = CASE WHEN audFieldName IN('EecDateOfLastHire') AND audAction = 'UPDATE' and ISNULL(audNewValue, '') <> '' THEN audNewValue END
    INTO dbo.U_ELAWUPDATE_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_ELAWUPDATE_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ELAWUPDATE_Audit ON dbo.U_ELAWUPDATE_Audit (audEEID,audKey2);

    --================
    -- Changes Only
    --================
    DELETE FROM dbo.U_ELAWUPDATE_EEList
    WHERE NOT EXISTS (SELECT 1 FROM dbo.U_ELAWUPDATE_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ELAWUPDATE_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ELAWUPDATE_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ELAWUPDATE_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = EecEmpno
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvProfileID = EecEmpno
        ,drvStartDate = CASE WHEN audHireDateChg is not null THEN convert(varchar,audHireDateChg, 101)  ELSE convert(varchar,EecDateOfLastHire, 101) END
        ,drvLocationidName = CmpCompanyName
        ,drvLocationidNumber = CASE WHEN  audLocDescChg is not null THEN  audLocDescChg ELSE LocDesc END
        ,drvLegalentityName = CASE WHEN  audLocChg is not null THEN  audLocChg ELSE EecLocation END
        ,drvFirstname = CASE WHEN  audFNameChg is not null THEN  audFNameChg ELSE  EepNameFirst END
        ,drvLastname = CASE WHEN  audLNameChg is not null THEN  audLNameChg ELSE  EepNameLast END
        ,drvEmailaddress = CASE WHEN audEmailChg is not null THEN audEmailChg ELSE EepAddressEMail END
    INTO dbo.U_ELAWUPDATE_drvTbl
    FROM dbo.U_ELAWUPDATE_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.Company WITH (NOLOCK)
        ON CmpCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.Location   WITH (NOLOCK)
       ON LocCode = EecLocation
    LEFT JOIN dbo.U_ELAWUPDATE_Audit  WITH (NOLOCK)
        ON AudEEID = xEEID
        AND AudKey2 = xCOID

    LEFT JOIN (
                SELECT EjhEEID, EjhCOID, EjhReason, EjhJobEffDate
                FROM (
                        SELECT EjhEEID, EjhCOID,EjhReason, EjhJobEffDate, ROW_NUMBER() OVER(PARTITION BY EjhEEID, EjhCOID ORDER BY EjhJobEffDate DESC) AS RN
                        FROM dbo.EmpHJob WITH (NOLOCK)
                        JOIN dbo.EmpComp WITH (NOLOCK)
                            ON EjhEEID = EecEEID
                      and EjhJobEffDate Between @Startdate and @EndDate                       
                        ) AS InnerEjh
                WHERE RN = 1) AS Ejh
        ON EjhEEID = xEEID   
    Where EecEEType NOT IN ( 'CON',   'TES' )
    AND  EecEmplStatus <> 'T' and EjhReason NOT In ('100', '101')
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
ALTER VIEW dbo.dsi_vwELAWUPDATE_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ELAWUPDATE_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'ELAWUPDATE%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202307261'
       ,expStartPerControl     = '202307261'
       ,expLastEndPerControl   = '202308029'
       ,expEndPerControl       = '202308029'
WHERE expFormatCode = 'ELAWUPDATE';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwELAWUPDATE_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ELAWUPDATE_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ELAWUPDATE' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ELAWUPDATE'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ELAWUPDATE'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ELAWUPDATE', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ELAWUPDATE', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ELAWUPDATE', 'UseFileName', 'V', 'Y'


-- End ripout