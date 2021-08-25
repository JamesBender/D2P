SET NOCOUNT ON;
IF OBJECT_ID('U_ECERTEARN_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECERTEARN_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ECERTEARN_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ECERTEARN' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwECERTEARN_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECERTEARN_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECERTEARN') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECERTEARN];
GO
IF OBJECT_ID('U_ECERTEARN_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ECERTEARN_PEarHist];
GO
IF OBJECT_ID('U_ECERTEARN_File') IS NOT NULL DROP TABLE [dbo].[U_ECERTEARN_File];
GO
IF OBJECT_ID('U_ECERTEARN_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECERTEARN_EEList];
GO
IF OBJECT_ID('U_ECERTEARN_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ECERTEARN_drvTbl];
GO
IF OBJECT_ID('U_ECERTEARN_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ECERTEARN_AuditFields];
GO
IF OBJECT_ID('U_ECERTEARN_Audit') IS NOT NULL DROP TABLE [dbo].[U_ECERTEARN_Audit];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ECERTEARN';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ECERTEARN';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ECERTEARN';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ECERTEARN';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ECERTEARN';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ECERTEARN','Certent Earnings Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','ECERTEARN0Z0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ECERTEARN' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Equityholder Code / Participant ID"','1','(''DA''=''T,'')','ECERTEARN0Z0','50','H','01','1',NULL,'Equityholder Code / Participant ID ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Tax Year"','2','(''DA''=''T,'')','ECERTEARN0Z0','50','H','01','2',NULL,'Tax Year ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD Total Compensation"','3','(''DA''=''T,'')','ECERTEARN0Z0','50','H','01','3',NULL,'YTD Total Compensation  ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD Taxable Supplemental Compensation"','4','(''DA''=''T,'')','ECERTEARN0Z0','50','H','01','4',NULL,'YTD Taxable Supplemental Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD Social Security"','5','(''DA''=''T,'')','ECERTEARN0Z0','50','H','01','6',NULL,'YTD Social Security ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD Medicare"','6','(''DA''=''T,'')','ECERTEARN0Z0','50','H','01','7',NULL,'YTD Medicare ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD SDI"','7','(''DA''=''T,'')','ECERTEARN0Z0','50','H','01','8',NULL,'YTD SDI ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD SUI"','8','(''DA''=''T,'')','ECERTEARN0Z0','50','H','01','9',NULL,'YTD SUI ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD FLI"','9','(''DA''=''T,'')','ECERTEARN0Z0','50','H','01','10',NULL,'YTD FLI ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD WF"','10','(''DA''=''T,'')','ECERTEARN0Z0','50','H','01','11',NULL,'YTD WF ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"State Code"','11','(''DA''=''T,'')','ECERTEARN0Z0','50','H','01','12',NULL,'State Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Company Code"','12','(''DA''=''T'')','ECERTEARN0Z0','50','H','01','13',NULL,'Company Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEquityholderCodePartID"','1','(''UA''=''T,'')','ECERTEARN0Z0','50','D','10','1',NULL,'Equityholder Code / Participant ID ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTaxYear"','2','(''UA''=''T,'')','ECERTEARN0Z0','50','D','10','2',NULL,'Tax Year ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDTotalCompensation"','3','(''UA''=''T,'')','ECERTEARN0Z0','50','D','10','3',NULL,'YTD Total Compensation  ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDTaxableSupplemental"','4','(''UA''=''T,'')','ECERTEARN0Z0','50','D','10','4',NULL,'YTD Taxable Supplemental ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDSocialSecurity"','5','(''UA''=''T,'')','ECERTEARN0Z0','50','D','10','6',NULL,'YTD Social Security ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDMedicare"','6','(''UA''=''T,'')','ECERTEARN0Z0','50','D','10','7',NULL,'YTD Medicare ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDSDI"','7','(''UA''=''T,'')','ECERTEARN0Z0','50','D','10','8',NULL,'YTD SDI ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDSUI"','8','(''UA''=''T,'')','ECERTEARN0Z0','50','D','10','9',NULL,'YTD SUI ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDFLI"','9','(''UA''=''T,'')','ECERTEARN0Z0','50','D','10','10',NULL,'YTD FLI ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDWF"','10','(''UA''=''T,'')','ECERTEARN0Z0','50','D','10','11',NULL,'YTD WF ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStateCode"','11','(''UA''=''T,'')','ECERTEARN0Z0','50','D','10','12',NULL,'State Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCompanyCode"','12','(''UA''=''T'')','ECERTEARN0Z0','50','D','10','13',NULL,'Company Code',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'ECERTEARN_20210824.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Certent Earnings Export','202103029','EMPEXPORT','ONDEM_XOE',NULL,'ECERTEARN',NULL,NULL,NULL,'202103029','Mar  2 2021 12:00PM','Mar  2 2021 12:00PM','202103021',NULL,'','','202103021',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Certent Earnings Export-Sched','202103029','EMPEXPORT','SCH_ECERTE',NULL,'ECERTEARN',NULL,NULL,NULL,'202103029','Mar  2 2021 12:00PM','Mar  2 2021 12:00PM','202103021',NULL,'','','202103021',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Certent Earnings Export-Test','202108131','EMPEXPORT','TEST_XOE','Aug 16 2021  3:49PM','ECERTEARN',NULL,NULL,NULL,'202108131','Aug 13 2021 12:00AM','Aug 15 2021 12:00AM','202108131','278','','','202108131',dbo.fn_GetTimedKey(),NULL,'us3rVaCOR1027',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECERTEARN','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECERTEARN','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECERTEARN','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECERTEARN','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECERTEARN','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'ECERTEARN' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'ECERTEARN' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_ECERTEARN_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECERTEARN_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECERTEARN','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECERTEARN','D10','dbo.U_ECERTEARN_drvTbl',NULL);
IF OBJECT_ID('U_ECERTEARN_Audit') IS NULL
CREATE TABLE [dbo].[U_ECERTEARN_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audKey2] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] varchar(2000) NULL,
    [audNewValue] varchar(2000) NULL,
    [audRowNo] bigint NULL
);
IF OBJECT_ID('U_ECERTEARN_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ECERTEARN_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_ECERTEARN_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ECERTEARN_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvEquityholderCodePartID] char(9) NULL,
    [drvTaxYear] int NULL,
    [drvYTDTotalCompensation] varchar(10) NULL,
    [drvYTDTaxableSupplemental] varchar(10) NULL,
    [drvYTDSocialSecurity] varchar(10) NULL,
    [drvYTDMedicare] varchar(1) NOT NULL,
    [drvYTDSDI] varchar(1) NOT NULL,
    [drvYTDSUI] varchar(1) NOT NULL,
    [drvYTDFLI] varchar(1) NOT NULL,
    [drvYTDWF] varchar(1) NOT NULL,
    [drvStateCode] varchar(255) NULL,
    [drvCompanyCode] varchar(4) NOT NULL
);
IF OBJECT_ID('U_ECERTEARN_EEList') IS NULL
CREATE TABLE [dbo].[U_ECERTEARN_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ECERTEARN_File') IS NULL
CREATE TABLE [dbo].[U_ECERTEARN_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
IF OBJECT_ID('U_ECERTEARN_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ECERTEARN_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PehCurAmt] numeric NULL,
    [PehCurHrs] decimal NULL,
    [PthCurTaxAmt] numeric NULL,
    [PthCurTaxAmtYTD] money NULL,
    [PehCurAmtYTDSupp] numeric NULL,
    [PehCurAmtYTD] money NULL,
    [PehCurHrsYTD] decimal NULL,
    [PehInclInDefComp] money NULL,
    [PehInclInDefCompHrs] decimal NULL,
    [PehInclInDefCompYTD] money NULL,
    [PehInclInDefCompHrsYTD] decimal NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECERTEARN]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Cortland Partners, LLC

Created By: Inshan Singh
Business Analyst: Richard Vars
Create Date: 03/02/2021
Service Request Number: TekP-2020-12-09-0001

Purpose: Certent Earnings Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECERTEARN';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECERTEARN';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECERTEARN';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECERTEARN';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECERTEARN' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECERTEARN', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECERTEARN', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECERTEARN', 'SCH_ECERTE';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ECERTEARN', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ECERTEARN';

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
    DELETE FROM dbo.U_ECERTEARN_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECERTEARN_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_ECERTEARN_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ECERTEARN_AuditFields;
    CREATE TABLE dbo.U_ECERTEARN_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_ECERTEARN_AuditFields VALUES ('EmpComp','EecEmplStatus');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ECERTEARN_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ECERTEARN_Audit;
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
    INTO dbo.U_ECERTEARN_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_ECERTEARN_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ECERTEARN_Audit ON dbo.U_ECERTEARN_Audit (audEEID,audKey2);

    ----================
    ---- Changes Only
    ----================
    --DELETE FROM dbo.U_ECERTEARN_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_ECERTEARN_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_ECERTEARN_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ECERTEARN_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        ,PthCurTaxAmt            = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PthCurTaxAmt ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PthCurTaxAmtYTD        = sum(PthCurTaxAmt) 
        ,PehCurAmtYTDSupp          = sum(CASE WHEN pehEarncode IN ('BOFDW','BOMYS','BON2','BONUS','BOSPM','BOSPQ','BOSTB',
                                        'BOTEC','COMM','CUSBO','DELIQ','EQLN','PEER','QUART','REFER','RELO','SEV','SIGN','SPOT','STAYB') THEN PehCurAmt ELSE 0.00 END) 
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_ECERTEARN_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    LEFT JOIN dbo.PTaxHist WITH (NOLOCK)
        ON PehGenNumber = PthGenNumber and PthTaxCode = 'USSOCEE'
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND pehEarncode in ('ADV','ALLOW','AUTOT','BEREV','BOANN','BOFDW','BOMYS'
                        ,'BON2','BONUS','BOSPM','BOSPQ','BOSTB','BOTEC','CARE'
                        ,'CLOSE','CMDAY','COMM','CONT','COVID','CUSBO','DELIQ'
                        ,'DRAW','EQLN','EQTAX','ER','FLOAT','FTO','GIFT','HOL'
                        --,'HSAER'
                        ,'JURY','MISC','MOVE','ONCAL','ONCLL','OT','PEER'
                        ,'PRNTL','PTO','PTO83','PTOPO','QUART','REFER','REG','RELO'
                        ,'RETRO','RTO','SEV','SHIFT','SICK','SIGN','SPOT','STAYB'
                        ,'STIP','VOLUN','VOTE'
                        )

                        
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ECERTEARN_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ECERTEARN_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECERTEARN_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvEquityholderCodePartID  = EecEmpno
        ,drvTaxYear  = YEAR(GETDATE())
        ,drvYTDTotalCompensation   = CONVERT(VARCHAR(10), CONVERT(MONEY, PehCurAmtYTD))
        ,drvYTDTaxableSupplemental  = CONVERT(VARCHAR(10), CONVERT(MONEY, PehCurAmtYTDSupp))
        ,drvYTDSocialSecurity  = CONVERT(VARCHAR(10), CONVERT(MONEY, PthCurTaxAmtYTD)) 
        ,drvYTDMedicare  = '' -- leave blank
        ,drvYTDSDI  = ''  --  YTD sum PehStateSDI -- ask Richard to clarify
        ,drvYTDSUI  = ''  -- leave blank
        ,drvYTDFLI  = ''  -- leave blank
        ,drvYTDWF  = ''   -- leave blank
        ,drvStateCode = LocAddressState
        ,drvCompanyCode = 'CORT'
    INTO dbo.U_ECERTEARN_drvTbl
    FROM dbo.U_ECERTEARN_EEList WITH (NOLOCK)
    JOIN dbo.Empcomp WITH (NOLOCK)
        ON eeceeid = xEEID and EecCOID = xCOID and EecUDField21 = 'Y'
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = eecLocation
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_ECERTEARN_PEarHist WITH (NOLOCK)
        ON pehEEID = xEEID
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_CortlandPartners_Tax_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.csv'
                                  ELSE 'CortlandPartners_Tax_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.csv'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwECERTEARN_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECERTEARN_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ECERTEARN%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202102231'
       ,expStartPerControl     = '202102231'
       ,expLastEndPerControl   = '202103029'
       ,expEndPerControl       = '202103029'
WHERE expFormatCode = 'ECERTEARN';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwECERTEARN_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ECERTEARN_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort