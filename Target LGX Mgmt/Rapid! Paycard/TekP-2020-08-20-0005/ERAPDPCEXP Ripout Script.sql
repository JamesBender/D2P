SET NOCOUNT ON;
IF OBJECT_ID('U_ERAPDPCEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ERAPDPCEXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ERAPDPCEXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ERAPDPCEXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwERAPDPCEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwERAPDPCEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ERAPDPCEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ERAPDPCEXP];
GO
IF OBJECT_ID('U_ERAPDPCEXP_File') IS NOT NULL DROP TABLE [dbo].[U_ERAPDPCEXP_File];
GO
IF OBJECT_ID('U_ERAPDPCEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_ERAPDPCEXP_EEList];
GO
IF OBJECT_ID('U_ERAPDPCEXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ERAPDPCEXP_drvTbl];
GO
IF OBJECT_ID('U_ERAPDPCEXP_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ERAPDPCEXP_AuditFields];
GO
IF OBJECT_ID('U_ERAPDPCEXP_Audit') IS NOT NULL DROP TABLE [dbo].[U_ERAPDPCEXP_Audit];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ERAPDPCEXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ERAPDPCEXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ERAPDPCEXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ERAPDPCEXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ERAPDPCEXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ERAPDPCEXP','Rapid! Paycard Demo Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','ERAPDPCEXPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Card ID"','1','(''DA''=''T,'')','ERAPDPCEXPZ0','50','H','01','1',NULL,'Card ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last Name"','2','(''DA''=''T,'')','ERAPDPCEXPZ0','50','H','01','2',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Name"','3','(''DA''=''T,'')','ERAPDPCEXPZ0','50','H','01','3',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address Line 1"','4','(''DA''=''T,'')','ERAPDPCEXPZ0','50','H','01','4',NULL,'Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address Line 2"','5','(''DA''=''T,'')','ERAPDPCEXPZ0','50','H','01','5',NULL,'Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"City"','6','(''DA''=''T,'')','ERAPDPCEXPZ0','50','H','01','6',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"State"','7','(''DA''=''T,'')','ERAPDPCEXPZ0','50','H','01','7',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Zip"','8','(''DA''=''T,'')','ERAPDPCEXPZ0','50','H','01','8',NULL,'Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Birth"','9','(''DA''=''T,'')','ERAPDPCEXPZ0','50','H','01','9',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Social Security #"','10','(''DA''=''T,'')','ERAPDPCEXPZ0','50','H','01','10',NULL,'Social Security #',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Phone"','11','(''DA''=''T,'')','ERAPDPCEXPZ0','50','H','01','11',NULL,'Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee ID"','12','(''DA''=''T,'')','ERAPDPCEXPZ0','50','H','01','12',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Email Address"','13','(''DA''=''T,'')','ERAPDPCEXPZ0','50','H','01','13',NULL,'Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Location"','14','(''DA''=''T'')','ERAPDPCEXPZ0','50','H','01','14',NULL,'Work Location',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCardID"','1','(''UA''=''T,'')','ERAPDPCEXPZ0','50','D','10','1',NULL,'Card ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','2','(''UA''=''T,'')','ERAPDPCEXPZ0','50','D','10','2',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','3','(''UA''=''T,'')','ERAPDPCEXPZ0','50','D','10','3',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','4','(''UA''=''T,'')','ERAPDPCEXPZ0','50','D','10','4',NULL,'Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','5','(''UA''=''T,'')','ERAPDPCEXPZ0','50','D','10','5',NULL,'Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','6','(''UA''=''T,'')','ERAPDPCEXPZ0','50','D','10','6',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','7','(''UA''=''T,'')','ERAPDPCEXPZ0','50','D','10','7',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','8','(''UA''=''T,'')','ERAPDPCEXPZ0','50','D','10','8',NULL,'Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','9','(''UD101''=''T,'')','ERAPDPCEXPZ0','50','D','10','9',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','10','(''UA''=''T,'')','ERAPDPCEXPZ0','50','D','10','10',NULL,'Social Security #',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhone"','11','(''UA''=''T,'')','ERAPDPCEXPZ0','50','D','10','11',NULL,'Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeID"','12','(''UA''=''T,'')','ERAPDPCEXPZ0','50','D','10','12',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmailAddress"','13','(''UA''=''T,'')','ERAPDPCEXPZ0','50','D','10','13',NULL,'Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkLocation"','14','(''UA''=''T'')','ERAPDPCEXPZ0','50','D','10','14',NULL,'Work Location',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ERAPDPCEXP_20201002.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Rapid! Paycard Demo Export','202010029','EMPEXPORT','ONDEM_XOE',NULL,'ERAPDPCEXP',NULL,NULL,NULL,'202010029','Oct  2 2020 11:33AM','Oct  2 2020 11:33AM','202009011',NULL,'','','202009011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ERAPDPCEXP_20201002.txt',NULL,'','',NULL,NULL,NULL,NULL,'Rapid! Paycard Demo Expo-Test','202010029','EMPEXPORT','TEST_XOE',NULL,'ERAPDPCEXP',NULL,NULL,NULL,'202010029','Oct  2 2020 11:33AM','Oct  2 2020 11:33AM','202009011',NULL,'','','202009011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ERAPDPCEXP_20201002.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Rapid! Paycard Demo Expo-Sched','202010029','EMPEXPORT','SCH_ERAPDP',NULL,'ERAPDPCEXP',NULL,NULL,NULL,'202010029','Oct  2 2020 11:33AM','Oct  2 2020 11:33AM','202009011',NULL,'','','202009011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_ERAPDPCEXP_20201002.txt' END WHERE expFormatCode = 'ERAPDPCEXP';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ERAPDPCEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ERAPDPCEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ERAPDPCEXP','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ERAPDPCEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ERAPDPCEXP','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'ERAPDPCEXP' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ERAPDPCEXP' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_ERAPDPCEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ERAPDPCEXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ERAPDPCEXP','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ERAPDPCEXP','D10','dbo.U_ERAPDPCEXP_drvTbl',NULL);
IF OBJECT_ID('U_ERAPDPCEXP_Audit') IS NULL
CREATE TABLE [dbo].[U_ERAPDPCEXP_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audCOID] varchar(255) NOT NULL
);
IF OBJECT_ID('U_ERAPDPCEXP_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ERAPDPCEXP_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_ERAPDPCEXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ERAPDPCEXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvCardID] varchar(13) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvAddressLine1] varchar(257) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvSSN] char(11) NULL,
    [drvPhone] varchar(50) NULL,
    [drvEmployeeID] char(9) NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvWorkLocation] varchar(25) NULL
);
IF OBJECT_ID('U_ERAPDPCEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_ERAPDPCEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ERAPDPCEXP_File') IS NULL
CREATE TABLE [dbo].[U_ERAPDPCEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ERAPDPCEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Target LGX Mgmt

Created By: James Bender
Business Analyst: Lea King
Create Date: 10/02/2020
Service Request Number: TekP-2020-08-20-0005

Purpose: Rapid! Paycard Demo Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ERAPDPCEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ERAPDPCEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ERAPDPCEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ERAPDPCEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ERAPDPCEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ERAPDPCEXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ERAPDPCEXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ERAPDPCEXP', 'SCH_ERAPDP';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ERAPDPCEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ERAPDPCEXP';

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
    DELETE FROM dbo.U_ERAPDPCEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ERAPDPCEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_ERAPDPCEXP_EEList WHERE xEEID IN (SELECT DISTINCT EecEEID FROM dbo.EmpComp WITH (NOLOCK) WHERE EecEEType IN ('TES'))

        --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_ERAPDPCEXP_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ERAPDPCEXP_AuditFields;
    CREATE TABLE dbo.U_ERAPDPCEXP_AuditFields (aTableName varchar(30),aFieldName varchar(30))  
    INSERT INTO dbo.U_ERAPDPCEXP_AuditFields VALUES ('EmpDirDp','EddAcct');
    INSERT INTO dbo.U_ERAPDPCEXP_AuditFields VALUES ('EmpPers','EepNameLast');
    INSERT INTO dbo.U_ERAPDPCEXP_AuditFields VALUES ('EmpPers','EepNameFirst');
    INSERT INTO dbo.U_ERAPDPCEXP_AuditFields VALUES ('EmpPers','EepAddressLine1');
    INSERT INTO dbo.U_ERAPDPCEXP_AuditFields VALUES ('EmpPers','EepAddressLine2');
    INSERT INTO dbo.U_ERAPDPCEXP_AuditFields VALUES ('EmpPers','EepAddressCity');
    INSERT INTO dbo.U_ERAPDPCEXP_AuditFields VALUES ('EmpPers','EepAddressState');
    INSERT INTO dbo.U_ERAPDPCEXP_AuditFields VALUES ('EmpPers','EepAddressZipCode');
    INSERT INTO dbo.U_ERAPDPCEXP_AuditFields VALUES ('EmpPers','EepDateOfBirth');
    INSERT INTO dbo.U_ERAPDPCEXP_AuditFields VALUES ('EmpPers','eepSSN');
    INSERT INTO dbo.U_ERAPDPCEXP_AuditFields VALUES ('EmpPers','EepPhoneHomeNumber');
    INSERT INTO dbo.U_ERAPDPCEXP_AuditFields VALUES ('EmpComp','EecEmpNo');
    INSERT INTO dbo.U_ERAPDPCEXP_AuditFields VALUES ('EmpPers','EepAddressEMail');
    INSERT INTO dbo.U_ERAPDPCEXP_AuditFields VALUES ('EmpComp','EecLocation');
    INSERT INTO dbo.U_ERAPDPCEXP_AuditFields VALUES ('EmpDirDp','EddEEBankRoute');
    INSERT INTO dbo.U_ERAPDPCEXP_AuditFields VALUES ('EmpDirDp','EddAccountIsInactive');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ERAPDPCEXP_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ERAPDPCEXP_Audit;
    SELECT DISTINCT
        audEEID  = audKey1Value
        ,audCOID = audKey2Value
        /*,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
        ,audNewHire = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = '' AND ISNULL(audNewValue,'') = 'A' THEN 'Y' ELSE 'N' END*/
    INTO dbo.U_ERAPDPCEXP_Audit
    FROM dbo.U_ERAPDPCEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_AuditData WITH (NOLOCK) 
        ON audKey1Value = xEEID
    JOIN dbo.U_ERAPDPCEXP_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    --AND audAction <> 'DELETE'
    --AND ISNULL(audNewValue,'') <> '';

    

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ERAPDPCEXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ERAPDPCEXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ERAPDPCEXP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvCardID = '353' + SUBSTRING(EddAcct, 4, 10)
        ,drvNameLast = EepNameLast
        ,drvNameFirst = EepNameFirst
        ,drvAddressLine1 = '"' + EepAddressLine1 + '"'
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvDateOfBirth = EepDateOfBirth
        ,drvSSN = eepSSN
        ,drvPhone = EepPhoneHomeNumber
        ,drvEmployeeID = EecEmpNo
        ,drvEmailAddress = EepAddressEMail
        ,drvWorkLocation = LocDesc
    INTO dbo.U_ERAPDPCEXP_drvTbl
    FROM dbo.U_ERAPDPCEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpDirDp WITH (NOLOCK)
        ON xEEID = EddEEID
        AND xCOID = EddCOID
        AND EddEEBankRoute = '124085244'
        AND EddAccountIsInactive = 'N'
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    JOIN dbo.Company WITH (NOLOCK)
        ON xCOID = CmpCOID
    JOIN dbo.U_ERAPDPCEXP_Audit WITH (NOLOCK)
        ON audEEID = xEEID
        AND audCOID = xCOID
    WHERE EecEEType IN ('REG','INT')
        AND CmpCompanyCode = 'TARUS'
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
ALTER VIEW dbo.dsi_vwERAPDPCEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ERAPDPCEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ERAPDPCEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202009011'
       ,expStartPerControl     = '202009011'
       ,expLastEndPerControl   = '202010029'
       ,expEndPerControl       = '202010029'
WHERE expFormatCode = 'ERAPDPCEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwERAPDPCEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ERAPDPCEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort