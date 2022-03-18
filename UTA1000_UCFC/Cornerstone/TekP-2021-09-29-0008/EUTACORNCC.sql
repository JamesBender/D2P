/**********************************************************************************

EUTACORNCC: Cornerstone Cost Center

FormatCode:     EUTACORNCC
Project:        Cornerstone Cost Center
Client ID:      UTA1000
Date/time:      2022-03-18 11:01:29.507
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW3WUP3DB03
Database:       ULTIPRO_WPUTCFC
Web Filename:   UTA1000_E52D4_EEHISTORY_EUTACORNCC_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EUTACORNCC_SavePath') IS NOT NULL DROP TABLE dbo.U_EUTACORNCC_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EUTACORNCC'


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
WHERE FormatCode = 'EUTACORNCC'
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
WHERE ExpFormatCode = 'EUTACORNCC'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EUTACORNCC')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EUTACORNCC'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EUTACORNCC'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EUTACORNCC'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EUTACORNCC'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EUTACORNCC'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EUTACORNCC'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EUTACORNCC'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EUTACORNCC'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EUTACORNCC'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEUTACORNCC_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEUTACORNCC_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EUTACORNCC') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUTACORNCC];
GO
IF OBJECT_ID('U_EUTACORNCC_File') IS NOT NULL DROP TABLE [dbo].[U_EUTACORNCC_File];
GO
IF OBJECT_ID('U_EUTACORNCC_EEList') IS NOT NULL DROP TABLE [dbo].[U_EUTACORNCC_EEList];
GO
IF OBJECT_ID('U_EUTACORNCC_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EUTACORNCC_drvTbl];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EUTACORNCC','Cornerstone Cost Center','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','EUTACORNCCZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EUTACORNCCZ0','50','H','01','1',NULL,'OU ID',NULL,NULL,'"OU ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EUTACORNCCZ0','50','H','01','2',NULL,'OU Name',NULL,NULL,'"OU Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EUTACORNCCZ0','50','H','01','3',NULL,'Active',NULL,NULL,'"Active"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EUTACORNCCZ0','50','H','01','4',NULL,'Allow Reconciliation',NULL,NULL,'"Allow Reconciliation"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EUTACORNCCZ0','50','H','01','5',NULL,'Parent ID',NULL,NULL,'"Parent ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EUTACORNCCZ0','50','H','01','6',NULL,'Owner ID',NULL,NULL,'"Owner ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EUTACORNCCZ0','50','H','01','7',NULL,'Description',NULL,NULL,'"Description"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EUTACORNCCZ0','50','H','01','8',NULL,'Approver ID',NULL,NULL,'"Approver ID"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EUTACORNCCZ0','50','D','10','1',NULL,'OU ID',NULL,NULL,'"drvOUID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EUTACORNCCZ0','50','D','10','2',NULL,'OU Name',NULL,NULL,'"drvOUName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EUTACORNCCZ0','50','D','10','3',NULL,'Active',NULL,NULL,'"TRUE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EUTACORNCCZ0','50','D','10','4',NULL,'Allow Reconciliation',NULL,NULL,'"TRUE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EUTACORNCCZ0','50','D','10','5',NULL,'Parent ID',NULL,NULL,'"drvParentID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EUTACORNCCZ0','50','D','10','6',NULL,'Owner ID',NULL,NULL,'"drvOwnerID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EUTACORNCCZ0','50','D','10','7',NULL,'Description',NULL,NULL,'"drvDescription"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EUTACORNCCZ0','50','D','10','8',NULL,'Approver ID',NULL,NULL,'"drvApproverID"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EUTACORNCC_20220318.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,',XAH9W',NULL,NULL,NULL,'Cornerstone Cost Center','202203079','EMPEXPORT','ONDEM_XOE',NULL,'EUTACORNCC',NULL,NULL,NULL,'202203079','Mar  7 2022  9:24AM','Mar  7 2022  9:24AM','202203071',NULL,'','','202203071',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Cornerstone Cost Center-Sched','202203079','EMPEXPORT','SCH_EUTACO',NULL,'EUTACORNCC',NULL,NULL,NULL,'202203079','Mar  7 2022  9:24AM','Mar  7 2022  9:24AM','202203071',NULL,'','','202203071',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Cornerstone Cost Center-Test','202203079','EMPEXPORT','TEST_XOE',NULL,'EUTACORNCC',NULL,NULL,NULL,'202203079','Mar  7 2022  9:24AM','Mar  7 2022  9:24AM','202203071',NULL,'','','202203071',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUTACORNCC','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUTACORNCC','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUTACORNCC','InitialSort','C','drvEmpNoSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUTACORNCC','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUTACORNCC','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUTACORNCC','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUTACORNCC','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUTACORNCC','D10','dbo.U_EUTACORNCC_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EUTACORNCC_drvTbl
-----------

IF OBJECT_ID('U_EUTACORNCC_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EUTACORNCC_drvTbl] (
    [drvEmpNoSort] char(10) NOT NULL,
    [drvOUID] char(10) NOT NULL,
    [drvOUName] varchar(25) NULL,
    [drvParentID] varchar(1) NOT NULL,
    [drvOwnerID] varchar(1) NOT NULL,
    [drvDescription] varchar(1) NOT NULL,
    [drvApproverID] varchar(1) NOT NULL
);

-----------
-- Create table U_EUTACORNCC_EEList
-----------

IF OBJECT_ID('U_EUTACORNCC_EEList') IS NULL
CREATE TABLE [dbo].[U_EUTACORNCC_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EUTACORNCC_File
-----------

IF OBJECT_ID('U_EUTACORNCC_File') IS NULL
CREATE TABLE [dbo].[U_EUTACORNCC_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUTACORNCC]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Utah Community Federal Credit

Created By: Marie Thomerson
Business Analyst: Richard Vars
Create Date: 03/07/2022
Service Request Number: TekP-2021-09-29-0008

Purpose: Cornerstone Cost Center

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EUTACORNCC';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EUTACORNCC';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EUTACORNCC';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EUTACORNCC';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EUTACORNCC' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUTACORNCC', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUTACORNCC', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUTACORNCC', 'SCH_EUTACO';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EUTACORNCC', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EUTACORNCC';

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
    --DELETE FROM dbo.U_EUTACORNCC_EEList
    --WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    --AND xEEID IN (SELECT xEEID FROM dbo.U_EUTACORNCC_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EUTACORNCC_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EUTACORNCC_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EUTACORNCC_drvTbl;
    SELECT DISTINCT
        -- drvEEID = xEEID
        --,drvCoID = xCoID
        --,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DA
        drvEmpNoSort = OrgCode
        -- standard fields above and additional driver fields below
        ,drvOUID = OrgCode
        ,drvOUName = orgDesc
        ,drvParentID = ''
        ,drvOwnerID = ''
        ,drvDescription = ''
        ,drvApproverID = ''
    INTO dbo.U_EUTACORNCC_drvTbl
    --FROM dbo.U_EUTACORNCC_EEList WITH (NOLOCK)
    --JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
    --    ON EecEEID = xEEID 
    --    AND EecCoID = xCoID
    FROM dbo.vwOrgLevel2 WITH (NOLOCK)
        --ON OrgCode = EecOrgLvl2
        --WHERE OrgLvl = '2'
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN '' + CONVERT(VARCHAR(8),GETDATE(),112) + '_Test_CostCenter.txt.pgp'
                                  ELSE '' + CONVERT(VARCHAR(8),GETDATE(),112) + '_CostCenter.txt.pgp'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEUTACORNCC_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EUTACORNCC_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EUTACORNCC%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202202281'
       ,expStartPerControl     = '202202281'
       ,expLastEndPerControl   = '202203079'
       ,expEndPerControl       = '202203079'
WHERE expFormatCode = 'EUTACORNCC';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEUTACORNCC_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EUTACORNCC_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EUTACORNCC' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EUTACORNCC'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EUTACORNCC'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EUTACORNCC', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EUTACORNCC', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EUTACORNCC', 'UseFileName', 'V', 'Y'


-- End ripout