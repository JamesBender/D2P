/**********************************************************************************

EVENCOBBEN: Cobra Participant

FormatCode:     EVENCOBBEN
Project:        Cobra Participant
Client ID:      USG1000
Date/time:      2022-03-25 09:36:51.630
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EZ24
Server:         EZ2SUP4DB01
Database:       ULTIPRO_LUIGI
Web Filename:   USG1000_79690_EEHISTORY_EVENCOBBEN_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    \\NZ1SUP1DB03\ultiprodata\[Name]\Exports\

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EVENCOBBEN_SavePath') IS NOT NULL DROP TABLE dbo.U_EVENCOBBEN_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EVENCOBBEN'


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
WHERE FormatCode = 'EVENCOBBEN'
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
WHERE ExpFormatCode = 'EVENCOBBEN'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EVENCOBBEN')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EVENCOBBEN'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EVENCOBBEN'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EVENCOBBEN'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EVENCOBBEN'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EVENCOBBEN'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EVENCOBBEN'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EVENCOBBEN'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EVENCOBBEN'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EVENCOBBEN'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_sp_BuildDriverTables_EVENCOBBEN') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EVENCOBBEN];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EVENCOBBEN','Cobra Participant','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','EVENCOBBENZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EVENCOBBENZ0','1','H','01','1',NULL,'Header Flag',NULL,NULL,'"H"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EVENCOBBENZ0','16','H','01','2',NULL,'Client ID',NULL,NULL,'"UHCUSS912084730"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EVENCOBBENZ0','5','H','01','18',NULL,'Record Length',NULL,NULL,'"drvRecLength"','(''UNT0''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EVENCOBBENZ0','8','H','01','23',NULL,'Date of File',NULL,NULL,'"drvCurrentDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EVENCOBBENZ0','6','H','01','31',NULL,'Time of File',NULL,NULL,'"drvCurrentTime"','(''UDHMS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EVENCOBBENZ0','20','H','01','37',NULL,'Contact Name',NULL,NULL,'"Michael Seeber"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EVENCOBBENZ0','10','H','01','57',NULL,'Contact Phone',NULL,NULL,'"615-428-5089"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EVENCOBBENZ0','1','H','01','67',NULL,'Test/Production File',NULL,NULL,'"drvTestorProd"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EVENCOBBENZ0','4','H','01','68',NULL,'Version Number',NULL,NULL,'"drvVersionNum"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EVENCOBBENZ0','4','H','01','72',NULL,'Release Number',NULL,NULL,'"drvReleaseNum"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EVENCOBBENZ0','2','H','01','76',NULL,'Product Type',NULL,NULL,'"CB"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EVENCOBBENZ0','3','H','01','78',NULL,'File Type',NULL,NULL,'"COV"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EVENCOBBENZ0','9','D','10','1',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EVENCOBBENZ0','8','D','10','10',NULL,'Plan',NULL,NULL,'"drvCarrierID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EVENCOBBENZ0','2','D','10','18',NULL,'Tier',NULL,NULL,'"drvCoverageCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EVENCOBBENZ0','2','D','10','20',NULL,'Blank',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EVENCOBBENZ0','12','D','10','20',NULL,'Premium',NULL,NULL,'"drvPremium"','(''UNT0''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EVENCOBBENZ0','1','T','90','1',NULL,'Trailer Flag',NULL,NULL,'"T"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EVENCOBBENZ0','16','T','90','2',NULL,'Client ID',NULL,NULL,'"UHCUSS912084730"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EVENCOBBENZ0','5','T','90','18',NULL,'Record Length',NULL,NULL,'"drvRecLength"','(''UNT0''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EVENCOBBENZ0','8','T','90','23',NULL,'Date of File',NULL,NULL,'"drvCurrentDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EVENCOBBENZ0','6','T','90','31',NULL,'Time of File',NULL,NULL,'"drvCurrentTime"','(''UDHMS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EVENCOBBENZ0','20','T','90','37',NULL,'Contact Name',NULL,NULL,'"Michael Seeber "','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EVENCOBBENZ0','10','T','90','57',NULL,'Contact Phone',NULL,NULL,'"615-428-5089"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EVENCOBBENZ0','9','T','90','67',NULL,'Records',NULL,NULL,'"drvRecCount"','(''UNT0''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EVENCOBBEN_20220325.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Cobra Participant','202203259','EMPEXPORT','ONDEM_XOE',NULL,'EVENCOBBEN',NULL,NULL,NULL,'202203259','Mar 25 2022  9:35AM','Mar 25 2022  9:35AM','202203251',NULL,'','','202203251',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Cobra Participant-Sched','202203259','EMPEXPORT','SCH_EVENCO',NULL,'EVENCOBBEN',NULL,NULL,NULL,'202203259','Mar 25 2022  9:35AM','Mar 25 2022  9:35AM','202203251',NULL,'','','202203251',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Cobra Participant-Test','202203259','EMPEXPORT','TEST_XOE',NULL,'EVENCOBBEN',NULL,NULL,NULL,'202203259','Mar 25 2022  9:35AM','Mar 25 2022  9:35AM','202203251',NULL,'','','202203251',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVENCOBBEN','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVENCOBBEN','ExportPath','V','\\NZ1SUP1DB03\ultiprodata\[Name]\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVENCOBBEN','InitialSort','C','drvEmpNoSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVENCOBBEN','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVENCOBBEN','UseFileName','V','N');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EVENCOBBEN','H01','dbo.U_EVENCOBBEN_HDR_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EVENCOBBEN','D10','dbo.U_EVENCOBBEN_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EVENCOBBEN','T90','dbo.U_EVENCOBBEN_TR_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- U_dsi_Translations_v3 inserts
-----------

GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EVENCOBBEN]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Venafi

Created By: Marie Thomerson
Business Analyst: Lea King
Create Date: 03/25/2022
Service Request Number: TekP-2021-10-28-0003

Purpose: Cobra Participant

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EVENCOBBEN';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EVENCOBBEN';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EVENCOBBEN';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EVENCOBBEN';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EVENCOBBEN' ORDER BY RunID DESC;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202002231'
       ,expStartPerControl     = '202002231'
       ,expLastEndPerControl   = '202203029'
       ,expEndPerControl       = '202203029'
WHERE expFormatCode = 'EVENCOBBEN';

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EVENCOBBEN', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EVENCOBBEN', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EVENCOBBEN', 'SCH_EVENCO';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EVENCOBBEN';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EVENCOBBEN', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EVENCOBBEN';

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
    DELETE FROM dbo.U_EVENCOBBEN_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EVENCOBBEN_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EVENCOBBEN_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EVENCOBBEN_AuditFields;
    CREATE TABLE dbo.U_EVENCOBBEN_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_EVENCOBBEN_AuditFields VALUES ('EmpComp','EecDateofTermination');
    INSERT INTO dbo.U_EVENCOBBEN_AuditFields VALUES ('EmpComp','EecDateofTermination');
    INSERT INTO dbo.U_EVENCOBBEN_AuditFields VALUES ('EmpComp','EecEmplStatus');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EVENCOBBEN_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EVENCOBBEN_Audit;
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
    INTO dbo.U_EVENCOBBEN_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EVENCOBBEN_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN dateadd(D, -30, @EndDate) AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EVENCOBBEN_Audit ON dbo.U_EVENCOBBEN_Audit (audEEID,audKey2);

    --================
    -- Changes Only
    --================
    --DELETE FROM dbo.U_EVENCOBBEN_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EVENCOBBEN_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'MED1,MED2,MED3,MED4,FSA,DEN,FSAL,MED5,VIS';

    IF OBJECT_ID('U_EVENCOBBEN_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EVENCOBBEN_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EVENCOBBEN_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','MED1,MED2,MED3,MED4,FSA,DEN,FSAL,MED5,VIS');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

    -- Non-Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraType','4');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraDate','3');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CountDependents','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL, DPC,STC,DIS');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP');
    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

	    -- COBRA parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RunID','QB');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'AddToPreviousRun','Y');  -- only used for NPM/QB combined files
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','Y'); -- DedIsCobraCovered = 'Y'
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraPQBType','1'); -- If no EE or spouse, ALL children are PQB (not just oldest) – include this line if deps are sent as QB and not the employee.  If the EE is sent as the QB even for non-EE events indicate this up above in question #6.
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraReasonsDepPQB','201,204,210,302,LEVNT3,LEVNT4'); -- Add valid dependent edhchangereasons
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidCobraReasonsEmp','201,204,210,302,LEVNT3,LEVNT4'); -- Invalidate employee when Cobra Reason is a dependent PQB reason – Add valid dependent edhchangereasons (should be same as previous line above)
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidTermReasonsEmp','210'); -- Invalidate employee when Cobra Reason is "Death".  Add the Death employment term reason (eectermreason)
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'ConCobraReasonPCF','DependentCOBRAReason'); -- Valid dependent PQB reasons – used when clients have Platform Configurable fields.  Add any other field names the client is using.

       ---========================================================================
 --   -- Insert into BDM Reason code 201 (Dependent at Max Age) - Only show EE
 --   --======================================================================

    INSERT INTO [dbo].[U_dsi_BDM_EVENCOBBEN]
    (    [BdmRecType]
           ,[BdmCOID]
           ,[BdmEEID]
           ,[BdmDepRecID]
           ,[BdmSystemID]
           ,[BdmRunID]
           ,[BdmDedRowStatus]
           ,[BdmRelationship]
           ,[BdmDateOfBirth]
           ,[BdmDedCode]
           ,[BdmBenOption]
           ,[BdmBenStatus]
           ,[BdmBenStartDate]
           ,[BdmBenStopDate]
           ,[BdmBenStatusDate]
           ,[BdmDateOFCobraEvent]
           ,[BdmChangeReason]
           ,[BdmCobraReason]
           ,[BdmStartDate]
           ,[BdmStopDate]
           ,[BdmIsPQB]
            ,[BdmIsCobraCovered]
            ,[BdmEEAmt]
    )
    Select distinct
        'EMP'
        ,EdhCoid
        ,EdhEEID
        ,DbnDepRecID
        ,DbnDepRecID
        ,'QB'
        ,'Data Inserted for 201 (Dep at Max Age Dep/Loss of elig)'
        ,'Emp'
        ,EepDateofBirth
        ,'EE'
        ,DbnBenStatus
        ,DbnBenStatus
        ,EdhBenStartDate
        ,EdhBenStopDate
        ,EdhBenStatusDate
        ,EdhEffDate
        ,edhChangeReason
        ,edhChangeReason
        ,EdhStartDate
        ,EdhStopDate
        ,'Y'
        ,'Y'
        ,edheeamt
    FROM dbo.emphded WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = edheeid 
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
        ON dbneeid = edheeid 
        AND DbnCoID = EdhCoID
        AND EdhDedCode = DbnDedCode
        AND EdhBenOption = DbnBenOption
        AND dbnformatcode = 'EVENCOBBEN'
    WHERE edhChangeReason IN ('201','LEVNT3') 
        and DbnBenstopdate BETWEEN @startdate AND @enddate 
        AND dbnValidForExport = 'N'
            AND DbnBenStatus = 'T'

--    ========================================================================
 --  Insert into BDM Reason code 204 / LEVNT4 (Divorce/Separation) 
 --  ======================================================================
    INSERT INTO [dbo].[U_dsi_BDM_EVENCOBBEN]
           ([BdmRecType]
           ,[BdmCOID]
           ,[BdmEEID]
           ,[BdmDepRecID]
           ,[BdmSystemID]
           ,[BdmRunID]
           ,[BdmDedRowStatus]
           ,[BdmRelationship]
           ,[BdmDateOfBirth]
           ,[BdmDedCode]
           ,[BdmBenOption]
           ,[BdmBenStatus]
           ,[BdmBenStartDate]
           ,[BdmBenStopDate]
           ,[BdmBenStatusDate]
           ,[BdmDateOFCobraEvent]
           ,[BdmChangeReason]
           ,[BdmCobraReason]
           ,[BdmStartDate]
           ,[BdmStopDate]
           ,[BdmIsPQB]
            ,[BdmIsCobraCovered]
            ,[BdmEEAmt]
    )
    SELECT Distinct rectype = 'DEP'
        ,EdhCoid
        ,EdhEEID
        ,DbnDepRecID
        ,DbnDepRecID
        ,'QB'
        ,'Data Inserted for 204/LEVNT4 (Divorce/Separation)'
        ,DbnRelationship
        ,DbnDateOfBirth
        ,EdhDedCode
        ,DbnBenOption
        ,DbnBenStatus
        ,EdhBenStartDate
        --,EdhBenStopDate
        ,DbnBenStopDate
        ,EdhBenStatusDate
        ,EdhEffDate
        ,edhChangeReason
        ,edhChangeReason
        ,EdhStartDate
        ,EdhStopDate
        ,CASE WHEN DbnRelationShip = 'SPS' THEN 'Y' ELSE 'N' END
        ,'Y'
        ,edheeamt
    FROM dbo.emphded WITH (NOLOCK)
        JOIN dbo.U_dsi_BDM_DepDeductions 
            ON dbneeid = edheeid 
            AND DbnCoID = EdhCoID
            AND EdhDedCode = DbnDedCode
            AND EdhBenOption = DbnBenOption
            AND dbnformatcode = 'EVENCOBBEN'
    WHERE edhChangeReason in ('204','LEVNT4') 
        AND DbnRelationShip = 'SPS'
        AND DbnBenStopDate BETWEEN @StartDate AND @EndDate
        AND dbnValidForExport = 'N'

--  --====================================================
 --   Insert into BDM Reason code 302 (Remove Dependent)
 --   --==================================================
    INSERT INTO [dbo].[U_dsi_BDM_EVENCOBBEN]
    (    [BdmRecType]
           ,[BdmCOID]
           ,[BdmEEID]
           ,[BdmDepRecID]
           ,[BdmSystemID]
           ,[BdmRunID]
           ,[BdmDedRowStatus]
           ,[BdmRelationship]
           ,[BdmDateOfBirth]
           ,[BdmDedCode]
           ,[BdmBenOption]
           ,[BdmBenStatus]
           ,[BdmBenStartDate]
           ,[BdmBenStopDate]
           ,[BdmBenStatusDate]
           ,[BdmDateOFCobraEvent]
           ,[BdmChangeReason]
           ,[BdmCobraReason]
           ,[BdmStartDate]
           ,[BdmStopDate]
           ,[BdmIsPQB]
            ,[BdmIsCobraCovered]
            ,[BdmEEAmt] 
    )
    Select Distinct rectype = 'EMP'
        ,EdhCoid
        ,EdhEEID
        ,DbnDepRecID
        ,DbnDepRecID
        ,'QB'
        ,'Data Inserted for 302 (Remove Dependent)'
        ,DbnRelationship
        ,DbnDateOfBirth
        ,EdhDedCode
        ,DbnBenOption
        ,DbnBenStatus
        ,EdhBenStartDate
        ,DbnBenStopDate
        ,edhEffDate
        ,edhEffDate
        ,edhChangeReason
        ,'302'
        ,EdhStartDate
        ,EdhStopDate
        ,'Y'
        ,'Y'
        ,edheeamt
    FROM dbo.emphded WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
        ON dbneeid = edheeid 
        AND DbnCoID = EdhCoID
        AND EdhDedCode = DbnDedCode
        AND EdhBenOption = DbnBenOption
        AND dbnformatcode = 'EVENCOBBEN'
    WHERE edhChangeReason IN ('302') 
        and DbnBenstopdate BETWEEN @startdate AND @enddate 
        AND dbnValidForExport = 'N'
        AND DbnBenStatus = 'T'

  Delete from dbo.U_dsi_BDM_EVENCOBBEN where bdmdedcode not in (Select dedcode from U_EVENCOBBEN_DedList)
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EVENCOBBEN_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EVENCOBBEN_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EVENCOBBEN_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvEmpNoSort = EecEmpNo
        -- standard fields above and additional driver fields below
        ,drvSSN = CASE WHEN BdmChangeReason in ('201', '210', '302', 'LEVNT3', '204', 'LEVNT4') THEN conSSN ELSE eepSSN END
        ,drvCarrierID = CASE    WHEN BdmDedCode in ('MED1') THEN 'UHC 1000 DED CH+'
                                WHEN BdmDedCode in ('MED3') THEN 'UHC 2000 DED HDHP CH+'
                                WHEN BdmDedCode in ('MED2') THEN 'UHC 1000 PPO DED'
                                WHEN BdmDedCode in ('MED4') THEN 'UHC 2000 DED PPO HDHP'
                                WHEN BdmDedCode in ('FSA') THEN 'UHC FSA'
                                WHEN BdmDedCode in ('DEN') THEN 'CIGNA DENTAL DPPO'
                                WHEN BdmDedCode in ('FSAL') THEN 'UHC LIMITED FSA'
                                WHEN BdmDedCode in ('MED5') THEN 'KAISER PERM HMO CA ONLY'
                                WHEN BdmDedCode in ('VIS') THEN 'CIGNA VISION SOLUTION'
                        END 
        ,drvCoverageCode = CASE WHEN BdmBenOption in ('EE') THEN 'Participant Only' 
                                WHEN BdmBenOption in ('EEC') THEN 'Participant + Children' 
                                WHEN BdmBenOption in ('EED') THEN 'Participant + One' 
                                WHEN BdmBenOption in ('EEF', 'EEDPF') THEN 'Participant + Family' 
                                WHEN BdmBenOption in ('EES', 'EEDP') THEN 'Participant + Spouse' 
                                ELSE 'Flexible Spending Acct' 
                            END  
        ,drvPremium = CASE WHEN BdmDedCode in ('FSA', 'FSAL') THEN BdmEEAmt END
    INTO dbo.U_EVENCOBBEN_drvTbl
    FROM dbo.U_EVENCOBBEN_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
              --And (eecemplstatus <> 'T' OR (eecemplstatus = 'T' and eectermreason <> 'TRO'
        --                          and EXISTS (Select 1 from dbo.U_EVENCOBBEN_Audit where audEEID = xEEID and audKey2 = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EVENCOBBEN WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EVENCOBBEN_HDR_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EVENCOBBEN_HDR_drvTbl;
    SELECT DISTINCT
         drvRecLength = '33'
        ,drvCurrentDate =  GETDATE()
        ,drvCurrentTime =  GETDATE()
        ,drvTestorProd =  CASE WHEN @ExportCode LIKE '%TEST%' THEN 'T' ELSE 'P' END
        ,drvVersionNum = '0001'
        ,drvReleaseNum = '0008'
    INTO dbo.U_EVENCOBBEN_HDR_drvTbl
    FROM dbo.U_EVENCOBBEN_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EVENCOBBEN WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EVENCOBBEN_TR_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EVENCOBBEN_TR_drvTbl;
    SELECT DISTINCT
         drvRecLength = '33'
        ,drvCurrentDate =  GETDATE()
        ,drvCurrentTime =  GETDATE()
        ,drvRecCount =  (SELECT COUNT(*) FROM dbo.U_EVENCOBBEN_drvTbl WITH (NOLOCK))
    INTO dbo.U_EVENCOBBEN_TR_drvTbl
    FROM dbo.U_EVENCOBBEN_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EVENCOBBEN WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN '' + CONVERT(VARCHAR(8),GETDATE(),112) + '_CB_PAR_UHCUSS912084730.txt'
                                  ELSE '' + CONVERT(VARCHAR(8),GETDATE(),112) + '_CB_PAR_UHCUSS912084730.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEVENCOBBEN_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EVENCOBBEN_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EVENCOBBEN%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202203181'
       ,expStartPerControl     = '202203181'
       ,expLastEndPerControl   = '202203259'
       ,expEndPerControl       = '202203259'
WHERE expFormatCode = 'EVENCOBBEN';

**********************************************************************************/

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EVENCOBBEN' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EVENCOBBEN'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EVENCOBBEN'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EVENCOBBEN', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EVENCOBBEN', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EVENCOBBEN', 'UseFileName', 'V', 'Y'


-- End ripout