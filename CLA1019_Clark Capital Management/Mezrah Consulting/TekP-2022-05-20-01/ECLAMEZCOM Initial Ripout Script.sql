/**********************************************************************************

ECLAMEZCOM: Mezra 401K Compensation Export

FormatCode:     ECLAMEZCOM
Project:        Mezra 401K Compensation Export
Client ID:      CLA1019
Date/time:      2022-09-30 09:29:42.183
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW2WUP4DB02
Database:       ULTIPRO_WPCCMG
Web Filename:   CLA1019_JX8KY_EEHISTORY_ECLAMEZCOM_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ECLAMEZCOM_SavePath') IS NOT NULL DROP TABLE dbo.U_ECLAMEZCOM_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ECLAMEZCOM'


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
WHERE FormatCode = 'ECLAMEZCOM'
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
WHERE ExpFormatCode = 'ECLAMEZCOM'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ECLAMEZCOM')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ECLAMEZCOM'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ECLAMEZCOM'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ECLAMEZCOM'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ECLAMEZCOM'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ECLAMEZCOM'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ECLAMEZCOM'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ECLAMEZCOM'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ECLAMEZCOM'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ECLAMEZCOM'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwECLAMEZCOM_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECLAMEZCOM_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECLAMEZCOM') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECLAMEZCOM];
GO
IF OBJECT_ID('U_ECLAMEZCOM_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ECLAMEZCOM_PEarHist];
GO
IF OBJECT_ID('U_ECLAMEZCOM_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ECLAMEZCOM_PDedHist];
GO
IF OBJECT_ID('U_ECLAMEZCOM_File') IS NOT NULL DROP TABLE [dbo].[U_ECLAMEZCOM_File];
GO
IF OBJECT_ID('U_ECLAMEZCOM_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECLAMEZCOM_EEList];
GO
IF OBJECT_ID('U_ECLAMEZCOM_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ECLAMEZCOM_drvTbl];
GO
IF OBJECT_ID('U_ECLAMEZCOM_DedList') IS NOT NULL DROP TABLE [dbo].[U_ECLAMEZCOM_DedList];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ECLAMEZCOM','Mezra 401K Compensation Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','ECLAMEZCOMZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECLAMEZCOMZ0','50','H','01','1',NULL,'Last Name',NULL,NULL,'"Last Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECLAMEZCOMZ0','50','H','01','2',NULL,'First Name',NULL,NULL,'"First Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECLAMEZCOMZ0','50','H','01','3',NULL,'SSN',NULL,NULL,'"SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECLAMEZCOMZ0','50','H','01','4',NULL,'Deferral Date',NULL,NULL,'"Deferral Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECLAMEZCOMZ0','50','H','01','5',NULL,'Deferral Type',NULL,NULL,'"Deferral Type"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECLAMEZCOMZ0','50','H','01','6',NULL,'Deferral Amount',NULL,NULL,'"Deferral Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECLAMEZCOMZ0','50','H','01','7',NULL,'Contribution Year',NULL,NULL,'"Contribution Year"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECLAMEZCOMZ0','50','H','01','8',NULL,'Current Pay Period Earnings',NULL,NULL,'"Current Pay Period Earnings"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECLAMEZCOMZ0','50','D','10','1',NULL,'Last Name',NULL,NULL,'"drvLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECLAMEZCOMZ0','50','D','10','2',NULL,'First Name',NULL,NULL,'"drvFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECLAMEZCOMZ0','50','D','10','3',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECLAMEZCOMZ0','50','D','10','4',NULL,'Deferral Date',NULL,NULL,'"drvDeferalDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECLAMEZCOMZ0','50','D','10','5',NULL,'Deferral Type',NULL,NULL,'"drvDeferalType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECLAMEZCOMZ0','50','D','10','6',NULL,'Deferral Amount',NULL,NULL,'"drvDeferalAmount"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECLAMEZCOMZ0','50','D','10','7',NULL,'Contribution Year',NULL,NULL,'"devContributionYear"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECLAMEZCOMZ0','50','D','10','8',NULL,'Current Pay Period Earnings',NULL,NULL,'"drvCurrenPayEarnings"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ECLAMEZCOM_20220930.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Mezra 401K Compensation Export','202209019','EMPEXPORT','ONDEM_XOE',NULL,'ECLAMEZCOM',NULL,NULL,NULL,'202209019','Aug 26 2022  3:19PM','Aug 26 2022  3:19PM','202207011',NULL,'','','202207011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mezra 401K Compensation -Sched','202209019','EMPEXPORT','SCH_ECLAME',NULL,'ECLAMEZCOM',NULL,NULL,NULL,'202209019','Aug 26 2022  3:19PM','Aug 26 2022  3:19PM','202207011',NULL,'','','202207011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',',5DC7X',NULL,NULL,NULL,'Mezra 401K Compensation -Test','202211059','EMPEXPORT','TEST_XOE',NULL,'ECLAMEZCOM',NULL,NULL,NULL,'202211059','Aug 26 2022  3:19PM','Aug 26 2022  3:19PM','202208281',NULL,'','','202208281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECLAMEZCOM','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECLAMEZCOM','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECLAMEZCOM','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECLAMEZCOM','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECLAMEZCOM','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECLAMEZCOM','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECLAMEZCOM','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECLAMEZCOM','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECLAMEZCOM','D10','dbo.U_ECLAMEZCOM_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_ECLAMEZCOM_DedList
-----------

IF OBJECT_ID('U_ECLAMEZCOM_DedList') IS NULL
CREATE TABLE [dbo].[U_ECLAMEZCOM_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_ECLAMEZCOM_drvTbl
-----------

IF OBJECT_ID('U_ECLAMEZCOM_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ECLAMEZCOM_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvSort] char(12) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvLastName] varchar(100) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvSSN] varchar(11) NULL,
    [drvDeferalDate] varchar(30) NULL,
    [drvDeferalType] varchar(5) NOT NULL,
    [drvDeferalAmount] varchar(20) NULL,
    [devContributionYear] char(5) NULL,
    [drvCurrenPayEarnings] varchar(20) NULL
);

-----------
-- Create table U_ECLAMEZCOM_EEList
-----------

IF OBJECT_ID('U_ECLAMEZCOM_EEList') IS NULL
CREATE TABLE [dbo].[U_ECLAMEZCOM_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ECLAMEZCOM_File
-----------

IF OBJECT_ID('U_ECLAMEZCOM_File') IS NULL
CREATE TABLE [dbo].[U_ECLAMEZCOM_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);

-----------
-- Create table U_ECLAMEZCOM_PDedHist
-----------

IF OBJECT_ID('U_ECLAMEZCOM_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ECLAMEZCOM_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhDCCalBasisAmt] numeric NULL,
    [PdhDCFLCalBasisAmt] numeric NULL,
    [PdhDCBONCalBasisAmt] numeric NULL,
    [PdhDC100CalBasisAmt] numeric NULL,
    [PdhDCCOMCalBasisAmt] numeric NULL,
    [PdhDCMIXCalBasisAmt] numeric NULL,
    [PdhEEDC] numeric NULL,
    [PdhEEDCFL] numeric NULL,
    [PdhEEDCBON] numeric NULL,
    [PdhEEDC100] numeric NULL,
    [PdhEEDCCOM] numeric NULL,
    [PdhEEDCMIX] numeric NULL,
    [PdhDC] varchar(2) NULL,
    [PdhDCBON] varchar(5) NULL,
    [PdhDC100] varchar(5) NULL,
    [PdhDCCOM] varchar(5) NULL,
    [PdhDCFL] varchar(4) NULL,
    [PdhDCMIX] varchar(5) NULL
);

-----------
-- Create table U_ECLAMEZCOM_PEarHist
-----------

IF OBJECT_ID('U_ECLAMEZCOM_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ECLAMEZCOM_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECLAMEZCOM]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Clark Capital Management Group

Created By: Roger Bynum
Business Analyst: Curlin Beck
Create Date: 08/26/2022
Service Request Number: TekP-2022-05-20-01

Purpose: Mezra 401K Compensation Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECLAMEZCOM';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECLAMEZCOM';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECLAMEZCOM';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECLAMEZCOM';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECLAMEZCOM' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECLAMEZCOM', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECLAMEZCOM', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECLAMEZCOM', 'SCH_ECLAME';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ECLAMEZCOM', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ECLAMEZCOM';

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
    DELETE FROM dbo.U_ECLAMEZCOM_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECLAMEZCOM_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'DC100,DC,DCFL,DCCOM,DCMIX,DCBON';

    IF OBJECT_ID('U_ECLAMEZCOM_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ECLAMEZCOM_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ECLAMEZCOM_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_ECLAMEZCOM_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ECLAMEZCOM_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhDCCalBasisAmt       = SUM(CASE WHEN PdhDedCode IN ('DC') THEN ISNULL(PdhDedCalcBasisAmt, 0) ELSE 0.00 END)
        ,PdhDCFLCalBasisAmt     = SUM(CASE WHEN PdhDedCode IN ('DCFL') THEN ISNULL(PdhDedCalcBasisAmt, 0) ELSE 0.00 END)
        ,PdhDCBONCalBasisAmt    = SUM(CASE WHEN PdhDedCode IN ('DCBON') THEN ISNULL(PdhDedCalcBasisAmt, 0) ELSE 0.00 END)
        ,PdhDC100CalBasisAmt    = SUM(CASE WHEN PdhDedCode IN ('DC100') THEN ISNULL(PdhDedCalcBasisAmt, 0) ELSE 0.00 END)
        ,PdhDCCOMCalBasisAmt    = SUM(CASE WHEN PdhDedCode IN ('DCCOM') THEN ISNULL(PdhDedCalcBasisAmt, 0) ELSE 0.00 END)
        ,PdhDCMIXCalBasisAmt    = SUM(CASE WHEN PdhDedCode IN ('DCMIX') THEN ISNULL(PdhDedCalcBasisAmt, 0) ELSE 0.00 END) 
        ,PdhEEDC                = SUM(CASE WHEN PdhDedCode IN ('DC') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)                                               
        ,PdhEEDCFL              = SUM(CASE WHEN PdhDedCode IN ('DCFL') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhEEDCBON             = SUM(CASE WHEN PdhDedCode IN ('DCBON') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhEEDC100             = SUM(CASE WHEN PdhDedCode IN ('DC100') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhEEDCCOM             = SUM(CASE WHEN PdhDedCode IN ('DCCOM') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhEEDCMIX             = SUM(CASE WHEN PdhDedCode IN ('DCMIX') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhDC                  = MAX(CASE WHEN PdhDedCode IN ('DC') THEN 'DC' END)                                               
        ,PdhDCBON               = MAX(CASE WHEN PdhDedCode IN ('DCBON') THEN 'DCBON' END)
        ,PdhDC100               = MAX(CASE WHEN PdhDedCode IN ('DC100') THEN 'DC100' END)
        ,PdhDCCOM               = MAX(CASE WHEN PdhDedCode IN ('DCCOM') THEN 'DCCOM' END)
        ,PdhDCFL                = MAX(CASE WHEN PdhDedCode IN ('DCFL') THEN 'DCFL' END)
        ,PdhDCMIX               = MAX(CASE WHEN PdhDedCode IN ('DCMIX') THEN 'DCMIX' END)
                                                                
    INTO dbo.U_ECLAMEZCOM_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ECLAMEZCOM_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );


    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_ECLAMEZCOM_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ECLAMEZCOM_PEarHist;
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
    INTO dbo.U_ECLAMEZCOM_PEarHist
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
    -- DETAIL RECORD - U_ECLAMEZCOM_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ECLAMEZCOM_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECLAMEZCOM_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        --,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = xEEID
        ,drvSubSort = '1'
        -- standard fields above and additional driver fields below
        ,drvLastName = EepNameLast
        ,drvFirstName = EepNameFirst
        ,drvSSN = LEFT(eepSSN, 3) + '-' + SUBSTRING(eepSSN, 4, 2) + '-' + SUBSTRING(eepSSN, 6, 4)
        ,drvDeferalDate = CONVERT(VARCHAR, PrgPayDate, 110)
        ,drvDeferalType = 'DC'
        ,drvDeferalAmount = SUBSTRING(CAST(PdhEEDC AS VARCHAR(20)), 1, LEN(CAST(PdhEEDC AS VARCHAR(20))) - 2)
        ,devContributionYear = CAST(YEAR(GETDATE()) AS CHAR(5))
        ,drvCurrenPayEarnings = CASE WHEN PdhDCCalBasisAmt <= 0 THEN SUBSTRING(CAST(PehInclInDefCompHrs AS VARCHAR(20)), 1, LEN(CAST(PehInclInDefCompHrs  AS VARCHAR(20))) - 2)
                                     ELSE  SUBSTRING(CAST(PdhDCCalBasisAmt   AS VARCHAR(20)), 1, LEN(CAST(PdhDCCalBasisAmt AS VARCHAR(20))) - 2)
                                END
    INTO dbo.U_ECLAMEZCOM_drvTbl
    FROM dbo.U_ECLAMEZCOM_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_ECLAMEZCOM_PEarHist WITH (NOLOCK)
        ON pehEEID = xEEID
    JOIN dbo.U_ECLAMEZCOM_PDedHist
        ON PdhEEID = xEEID
        AND PdhDC = 'DC'  

    UNION

    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        --,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = xEEID
        ,drvSubSort = '2'
        -- standard fields above and additional driver fields below
        ,drvLastName = EepNameLast
        ,drvFirstName = EepNameFirst
        ,drvSSN = LEFT(eepSSN, 3) + '-' + SUBSTRING(eepSSN, 4, 2) + '-' + SUBSTRING(eepSSN, 6, 4)
        ,drvDeferalDate = CONVERT(VARCHAR, PrgPayDate, 110)
        ,drvDeferalType = 'DCBON'
        ,drvDeferalAmount = SUBSTRING(CAST(PdhEEDCBON AS VARCHAR(20)), 1, LEN(CAST(PdhEEDCBON AS VARCHAR(20))) - 2)
        ,devContributionYear = CAST(YEAR(GETDATE()) AS CHAR(5))
        ,drvCurrenPayEarnings = CASE WHEN PdhDCBONCalBasisAmt <= 0 THEN SUBSTRING(CAST(PehInclInDefCompHrs AS VARCHAR(20)), 1, LEN(CAST(PehInclInDefCompHrs  AS VARCHAR(20))) - 2)
                                     ELSE  SUBSTRING(CAST(PdhDCBONCalBasisAmt   AS VARCHAR(20)), 1, LEN(CAST(PdhDCBONCalBasisAmt AS VARCHAR(20))) - 2)
                                END
    FROM dbo.U_ECLAMEZCOM_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_ECLAMEZCOM_PEarHist WITH (NOLOCK)
        ON pehEEID = xEEID
    JOIN dbo.U_ECLAMEZCOM_PDedHist
        ON PdhEEID = xEEID
        AND PdhDCBON = 'DCBON'  

    UNION

    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        --,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = xEEID
        ,drvSubSort = '3'
        -- standard fields above and additional driver fields below
        ,drvLastName = EepNameLast
        ,drvFirstName = EepNameFirst
        ,drvSSN = LEFT(eepSSN, 3) + '-' + SUBSTRING(eepSSN, 4, 2) + '-' + SUBSTRING(eepSSN, 6, 4)
        ,drvDeferalDate = CONVERT(VARCHAR, PrgPayDate, 110)
        ,drvDeferalType = 'DCFL'
        ,drvDeferalAmount = SUBSTRING(CAST(PdhEEDCFL AS VARCHAR(20)), 1, LEN(CAST(PdhEEDCFL AS VARCHAR(20))) - 2)
        ,devContributionYear = CAST(YEAR(GETDATE()) AS CHAR(5))
        ,drvCurrenPayEarnings = CASE WHEN PdhDCFLCalBasisAmt <= 0 THEN SUBSTRING(CAST(PehInclInDefCompHrs AS VARCHAR(20)), 1, LEN(CAST(PehInclInDefCompHrs  AS VARCHAR(20))) - 2)
                                     ELSE  SUBSTRING(CAST(PdhDCFLCalBasisAmt   AS VARCHAR(20)), 1, LEN(CAST(PdhDCFLCalBasisAmt AS VARCHAR(20))) - 2)
                                END
    FROM dbo.U_ECLAMEZCOM_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_ECLAMEZCOM_PEarHist WITH (NOLOCK)
        ON pehEEID = xEEID
    JOIN dbo.U_ECLAMEZCOM_PDedHist
        ON PdhEEID = xEEID
        AND PdhDCFL = 'DCFL'  

    UNION

    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        --,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = xEEID
        ,drvSubSort = '4'
        -- standard fields above and additional driver fields below
        ,drvLastName = EepNameLast
        ,drvFirstName = EepNameFirst
        ,drvSSN = LEFT(eepSSN, 3) + '-' + SUBSTRING(eepSSN, 4, 2) + '-' + SUBSTRING(eepSSN, 6, 4)
        ,drvDeferalDate = CONVERT(VARCHAR, PrgPayDate, 110)
        ,drvDeferalType = 'DC100'
        ,drvDeferalAmount = SUBSTRING(CAST(PdhEEDC100 AS VARCHAR(20)), 1, LEN(CAST(PdhEEDC100 AS VARCHAR(20))) - 2)
        ,devContributionYear = CAST(YEAR(GETDATE()) AS CHAR(5))
        ,drvCurrenPayEarnings = CASE WHEN PdhDC100CalBasisAmt <= 0 THEN SUBSTRING(CAST(PehInclInDefCompHrs AS VARCHAR(20)), 1, LEN(CAST(PehInclInDefCompHrs  AS VARCHAR(20))) - 2)
                                     ELSE  SUBSTRING(CAST(PdhDC100CalBasisAmt   AS VARCHAR(20)), 1, LEN(CAST(PdhDC100CalBasisAmt AS VARCHAR(20))) - 2)
                                END
    FROM dbo.U_ECLAMEZCOM_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_ECLAMEZCOM_PEarHist WITH (NOLOCK)
        ON pehEEID = xEEID
    JOIN dbo.U_ECLAMEZCOM_PDedHist
        ON PdhEEID = xEEID
        AND PdhDC100 = 'DC100'  

    UNION

    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        --,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = xEEID
        ,drvSubSort = '5'
        -- standard fields above and additional driver fields below
        ,drvLastName = EepNameLast
        ,drvFirstName = EepNameFirst
        ,drvSSN = LEFT(eepSSN, 3) + '-' + SUBSTRING(eepSSN, 4, 2) + '-' + SUBSTRING(eepSSN, 6, 4)
        ,drvDeferalDate = CONVERT(VARCHAR, PrgPayDate, 110)
        ,drvDeferalType = 'DCCOM'
        ,drvDeferalAmount = SUBSTRING(CAST(PdhEEDCCOM AS VARCHAR(20)), 1, LEN(CAST(PdhEEDCCOM AS VARCHAR(20))) - 2)
        ,devContributionYear = CAST(YEAR(GETDATE()) AS CHAR(5))
        ,drvCurrenPayEarnings = CASE WHEN PdhDCCOMCalBasisAmt <= 0 THEN SUBSTRING(CAST(PehInclInDefCompHrs AS VARCHAR(20)), 1, LEN(CAST(PehInclInDefCompHrs  AS VARCHAR(20))) - 2)
                                     ELSE  SUBSTRING(CAST(PdhDCCOMCalBasisAmt   AS VARCHAR(20)), 1, LEN(CAST(PdhDCCOMCalBasisAmt AS VARCHAR(20))) - 2)
                                END
    FROM dbo.U_ECLAMEZCOM_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_ECLAMEZCOM_PEarHist WITH (NOLOCK)
        ON pehEEID = xEEID
    JOIN dbo.U_ECLAMEZCOM_PDedHist
        ON PdhEEID = xEEID
        AND PdhDCCOM = 'DCCOM'  

    UNION

    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        --,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = xEEID
        ,drvSubSort = '6'
        -- standard fields above and additional driver fields below
        ,drvLastName = EepNameLast
        ,drvFirstName = EepNameFirst
        ,drvSSN = LEFT(eepSSN, 3) + '-' + SUBSTRING(eepSSN, 4, 2) + '-' + SUBSTRING(eepSSN, 6, 4)
        ,drvDeferalDate = CONVERT(VARCHAR, PrgPayDate, 110)
        ,drvDeferalType = 'DCMIX'
        ,drvDeferalAmount = SUBSTRING(CAST(PdhEEDCMIX AS VARCHAR(20)), 1, LEN(CAST(PdhEEDCMIX AS VARCHAR(20))) - 2)
        ,devContributionYear = CAST(YEAR(GETDATE()) AS CHAR(5))
        ,drvCurrenPayEarnings = CASE WHEN PdhDCMIXCalBasisAmt <= 0 THEN SUBSTRING(CAST(PehInclInDefCompHrs AS VARCHAR(20)), 1, LEN(CAST(PehInclInDefCompHrs  AS VARCHAR(20))) - 2)
                                     ELSE  SUBSTRING(CAST(PdhDCMIXCalBasisAmt   AS VARCHAR(20)), 1, LEN(CAST(PdhDCMIXCalBasisAmt AS VARCHAR(20))) - 2)
                                END
    FROM dbo.U_ECLAMEZCOM_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_ECLAMEZCOM_PEarHist WITH (NOLOCK)
        ON pehEEID = xEEID
    JOIN dbo.U_ECLAMEZCOM_PDedHist
        ON PdhEEID = xEEID
        AND PdhDCMIX = 'DCMIX'  
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
ALTER VIEW dbo.dsi_vwECLAMEZCOM_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECLAMEZCOM_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'ECLAMEZCOM%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202207011'
       ,expStartPerControl     = '202207011'
       ,expLastEndPerControl   = '202208269'
       ,expEndPerControl       = '202209019'
WHERE expFormatCode = 'ECLAMEZCOM';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwECLAMEZCOM_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ECLAMEZCOM_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ECLAMEZCOM' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ECLAMEZCOM'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ECLAMEZCOM'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECLAMEZCOM', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ECLAMEZCOM', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECLAMEZCOM', 'UseFileName', 'V', 'Y'


-- End ripout