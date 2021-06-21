SET NOCOUNT ON;
IF OBJECT_ID('U_EADCONTR_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EADCONTR_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EADCONTR_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EADCONTR' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_fnlib_GetSupervisorField_EADCONTR') IS NOT NULL DROP FUNCTION [dbo].[dsi_fnlib_GetSupervisorField_EADCONTR];
GO
IF OBJECT_ID('dsi_vwEADCONTR_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEADCONTR_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EADCONTR') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EADCONTR];
GO
IF OBJECT_ID('U_EADCONTR_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EADCONTR_PEarHist];
GO
IF OBJECT_ID('U_EADCONTR_File') IS NOT NULL DROP TABLE [dbo].[U_EADCONTR_File];
GO
IF OBJECT_ID('U_EADCONTR_EEList') IS NOT NULL DROP TABLE [dbo].[U_EADCONTR_EEList];
GO
IF OBJECT_ID('U_EADCONTR_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EADCONTR_drvTbl];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EADCONTR';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EADCONTR';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EADCONTR';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EADCONTR';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EADCONTR';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EADCONTR','Active Directory Contractor Full File','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','EADCONTR00Z0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EADCONTR' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Number"','1','(''DA''=''T,'')','EADCONTR00Z0','50','H','01','1',NULL,'Employee Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last Name"','2','(''DA''=''T,'')','EADCONTR00Z0','50','H','01','2',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Name"','3','(''DA''=''T,'')','EADCONTR00Z0','50','H','01','3',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Preferred First Name"','4','(''DA''=''T,'')','EADCONTR00Z0','50','H','01','4',NULL,'Preferred First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Supervisor Employee Number"','5','(''DA''=''T,'')','EADCONTR00Z0','50','H','01','5',NULL,'Supervisor Employee Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Supervisor Name"','6','(''DA''=''T,'')','EADCONTR00Z0','50','H','01','6',NULL,'Supervisor Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Supervisor Email Address"','7','(''DA''=''T,'')','EADCONTR00Z0','50','H','01','7',NULL,'Supervisor Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Contract Number/Agency"','8','(''DA''=''T,'')','EADCONTR00Z0','50','H','01','8',NULL,'Contract Number/Agency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Job (Alternate)"','9','(''DA''=''T,'')','EADCONTR00Z0','50','H','01','9',NULL,'Job (Alternate)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Contract End Date"','10','(''DA''=''T,'')','EADCONTR00Z0','50','H','01','10',NULL,'Contract End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Job Code"','11','(''DA''=''T,'')','EADCONTR00Z0','50','H','01','11',NULL,'Job Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Org Level 1"','12','(''DA''=''T,'')','EADCONTR00Z0','50','H','01','12',NULL,'Org Level 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Location"','13','(''DA''=''T,'')','EADCONTR00Z0','50','H','01','13',NULL,'Location',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employment Status"','14','(''DA''=''T'')','EADCONTR00Z0','50','H','01','14',NULL,'Employment Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeNumber"','1','(''UA''=''T,'')','EADCONTR00Z0','50','D','10','1',NULL,'Employee Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastName"','2','(''UA''=''T,'')','EADCONTR00Z0','50','D','10','2',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstName"','3','(''UA''=''T,'')','EADCONTR00Z0','50','D','10','3',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPreferredFirstName"','4','(''UA''=''T,'')','EADCONTR00Z0','50','D','10','4',NULL,'Preferred First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeNumberSup"','5','(''UA''=''T,'')','EADCONTR00Z0','50','D','10','5',NULL,'Employee Number (Supervisor)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSupervisorName"','6','(''UA''=''T,'')','EADCONTR00Z0','50','D','10','6',NULL,'Supervisor Name (Last Suffix, First MI)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSupervisorEmail"','7','(''UA''=''T,'')','EADCONTR00Z0','50','D','10','7',NULL,'Supervisor Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContractNumberAgency"','8','(''UA''=''T,'')','EADCONTR00Z0','50','D','10','8',NULL,'Contract Number/Agency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobAlternate"','9','(''UA''=''T,'')','EADCONTR00Z0','50','D','10','9',NULL,'Job (Alternate)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContractEndDate"','10','(''UD101''=''T,'')','EADCONTR00Z0','50','D','10','10',NULL,'Contract End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobCode"','11','(''UA''=''T,'')','EADCONTR00Z0','50','D','10','11',NULL,'Job Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOrgLevel1"','12','(''UA''=''T,'')','EADCONTR00Z0','50','D','10','12',NULL,'Org Level 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLocation"','13','(''UA''=''T,'')','EADCONTR00Z0','50','D','10','13',NULL,'Location',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmploymentStatus"','14','(''UA''=''T'')','EADCONTR00Z0','50','D','10','14',NULL,'Employment Status',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EADCONTR_20210614.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Active Directory Contractor','202103229','EMPEXPORT','ONDEM_XOE','May 27 2021 12:28PM','EADCONTR',NULL,NULL,NULL,'202103229','Mar 22 2021  1:47AM','Mar 22 2021  1:47AM','202003151','531','','','202003151',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Directory Contrac-Sched','202103229','EMPEXPORT','SCH_EADCON',NULL,'EADCONTR',NULL,NULL,NULL,'202103229','Mar 22 2021  1:47AM','Mar 22 2021  1:47AM','202003151',NULL,'','','202003151',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Active Directory Contrac-Test','202105289','EMPEXPORT','TEST_XOE','May 28 2021 12:54PM','EADCONTR',NULL,NULL,NULL,'202105289','May 28 2021 12:00AM','Dec 30 1899 12:00AM','202003151','531','','','202003151',dbo.fn_GetTimedKey(),NULL,'us3rVaACS1003',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EADCONTR','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EADCONTR','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EADCONTR','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EADCONTR','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EADCONTR','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EADCONTR' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EADCONTR' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EADCONTR_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EADCONTR_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EADCONTR','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EADCONTR','D10','dbo.U_EADCONTR_drvTbl',NULL);
IF OBJECT_ID('U_EADCONTR_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EADCONTR_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvEmployeeNumber] char(9) NULL,
    [drvLastName] varchar(100) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvPreferredFirstName] varchar(100) NULL,
    [drvEmployeeNumberSup] varchar(256) NULL,
    [drvSupervisorName] varchar(258) NULL,
    [drvSupervisorEmail] varchar(256) NULL,
    [drvContractNumberAgency] varchar(50) NOT NULL,
    [drvJobAlternate] varchar(8000) NULL,
    [drvContractEndDate] datetime NULL,
    [drvJobCode] varchar(31) NOT NULL,
    [drvOrgLevel1] varchar(25) NULL,
    [drvLocation] varchar(25) NULL,
    [drvEmploymentStatus] char(1) NULL
);
IF OBJECT_ID('U_EADCONTR_EEList') IS NULL
CREATE TABLE [dbo].[U_EADCONTR_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EADCONTR_File') IS NULL
CREATE TABLE [dbo].[U_EADCONTR_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
IF OBJECT_ID('U_EADCONTR_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EADCONTR_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EADCONTR]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Pivot Tech

Created By: Inshan Singh
Business Analyst: Richard Vars
Create Date: 03/22/2021
Service Request Number: 

Purpose: Active Directory Contractor Full File 

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EADCONTR';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EADCONTR';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EADCONTR';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EADCONTR';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EADCONTR' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EADCONTR', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EADCONTR', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EADCONTR', 'SCH_EADCON';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EADCONTR', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EADCONTR';

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
    DELETE FROM dbo.U_EADCONTR_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EADCONTR_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EADCONTR_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EADCONTR_PEarHist;
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
    INTO dbo.U_EADCONTR_PEarHist
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
    -- DETAIL RECORD - U_EADCONTR_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EADCONTR_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EADCONTR_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvEmployeeNumber = EecEmpNo
        ,drvLastName = EepNameLast
        ,drvFirstName = EepNameFirst
        ,drvPreferredFirstName = EepNamePreferred
        ,drvEmployeeNumberSup = dbo.dsi_fnlib_GetSupervisorField_EADCONTR(EecCoID, EecEEID, 'EmpNo')     
        ,drvSupervisorName = '"'+dbo.dsi_fnlib_GetSupervisorField_EADCONTR(EecCoID, EecEEID, 'NameLast Suffix, First M') +'"'
        ,drvSupervisorEmail = dbo.dsi_fnlib_GetSupervisorField_EADCONTR(EecCoID, EecEEID, 'AddressEmail') 
        ,drvContractNumberAgency = ContractNumber
        ,drvJobAlternate = (Replace(Replace([dbo].[fn_AddDoubleQuotes](EecJobtitle),CHAR(10),''),CHAR(13),'')) --RTRIM(LTRIM(EecJobtitle))
        ,drvContractEndDate = ContractEndDate
        ,drvJobCode =  CASE WHEN jbcJobCode = 'CONTAPP' THEN 'Applied Computer Solutions Inc.'
                            WHEN jbcJobCode = 'CONTARC' THEN 'ARC Acquisition (US) Inc.'
                            WHEN jbcJobCode = 'CONTPROS' THEN 'ProSys Information Systems Inc.'
                            WHEN jbcJobCode = 'CONTPSSL' THEN 'Pivot Shared Services Limited'
                            WHEN jbcJobCode = 'CONTPTSC' THEN 'Pivot Technology Services Corp.'
                            WHEN jbcJobCode = 'CONTTER' THEN 'TeraMach Technologies Inc.'
                            WHEN jbcJobCode = 'CONTCCTR' THEN 'Computacenter'
                            else
                            'Pivot Technology Services Corp.'
                        END
        ,drvOrgLevel1 = OrgDesc
        ,drvLocation = LocDesc --LEFT(EecStateSUI,2) --EecLocation
        ,drvEmploymentStatus = EecEmplstatus
    INTO dbo.U_EADCONTR_drvTbl
    FROM dbo.U_EADCONTR_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID AND EecEETYPE <> 'TES'
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.Orglevel WITH (NOLOCK)
        ON OrgCode = EecOrgLvl1
    JOIN dbo.Company WITH (NOLOCK)
        ON cmpCoID = eecCOID
    JOIN dbo.EmploymentContracts WITH (NOLOCK)
    ON    CoID = xCOID and Eeid = xEEID
    JOIN dbo.Location with (nolock)
        ON LocCode = EecLocation
    --JOIN dbo.U_EADCONTR_PEarHist WITH (NOLOCK)
    --    ON pehEEID = xEEID --and PehCurAmtYTD <> 0.00
        WHERE cmpCompanyCode = 'ZHRON' 
        and EecMailStop = 'YES' 
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEADCONTR_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EADCONTR_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EADCONTR%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202003151'
       ,expStartPerControl     = '202003151'
       ,expLastEndPerControl   = '202103229'
       ,expEndPerControl       = '202103229'
WHERE expFormatCode = 'EADCONTR';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEADCONTR_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EADCONTR_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort
GO
CREATE FUNCTION [dbo].[dsi_fnlib_GetSupervisorField_EADCONTR] (    
@COID            VARCHAR(5),    
@EEID            VARCHAR(12),    
@FieldName       VARCHAR(32)    
)    
    
RETURNS VARCHAR(256)    
WITH EXECUTE AS CALLER    
AS    
    
/************************************************************    
    
Created By: John Transier    
Create Date: 08/16/2017    
    
Revision History    
----------------    
Update By            Date            Desc    
XXXX                 XX/XX/16        Added 1234    
    
Purpose: Pulls basic supervisor fields for an employee, e.g. name, employee number.    
             
Description    
-----------    
Pulls basic supervisor fields, e.g. name, employee number. If COID is left blank it will pull the employee's current COID.    
    
    
Commands     
--------    
SELECT     
    
EecEEID,     
EecSupervisorID,    
dbo.dsi_fnlib_GetSupervisorField('', EecEEID, 'NameLast, First')     
    
FROM dbo.EmpComp    
    
************************************************************/    
    
BEGIN    
    
-----------    
-- Declare and set variables    
-----------    
    
DECLARE @Return         VARCHAR(256)    
DECLARE @SupervisorCOID VARCHAR(5)    
DECLARE @SupervisorEEID VARCHAR(12)    
    
SET @COID      = LTRIM(RTRIM(COALESCE(@COID, '')))    
SET @EEID      = LTRIM(RTRIM(COALESCE(@EEID, '')))    
SET @FieldName = LTRIM(RTRIM(COALESCE(@FieldName, '')))    
    
IF @EEID      = '' RETURN ''    
IF @FieldName = '' RETURN ''    
    
IF @COID = '' SET @COID = dbo.dsi_fn_GetCurrentCOID(@EEID)     
    
    
-----------    
-- Set supervisor fields    
-----------    
    
SELECT     
    
@SupervisorEEID = LTRIM(RTRIM(COALESCE(EecSupervisorID, ''))),    
@SupervisorCOID = dbo.dsi_fn_GetCurrentCOID(EecSupervisorID)     
       
FROM dbo.EmpComp    
WHERE EecCOID = @COID    
  AND EecEEID = @EEID    
    
IF @SupervisorEEID = '' RETURN ''    
    
    
-----------    
-- Get supervisor data 

-----------    
    
SELECT @Return = CASE    
                    WHEN @FieldName = 'SSN'               THEN EepSSN    
                    WHEN @FieldName = 'NameFirst'         THEN EepNameFirst    
                    WHEN @FieldName = 'NameLast'          THEN EepNameLast    
                    WHEN @FieldName = 'NameMiddle'        THEN EepNameMiddle    
                    WHEN @FieldName = 'NameMiddleInit'    THEN LEFT(EepNameMiddle, 1)    
                    WHEN @FieldName = 'NameLast, First'   THEN LTRIM(RTRIM(EepNameLast)) + ', ' + LTRIM(RTRIM(EepNameFirst))    
                    WHEN @FieldName = 'NameLast, First M' THEN LTRIM(RTRIM(EepNameLast)) + ', ' + LTRIM(RTRIM(EepNameFirst)) + ' ' + COALESCE(LEFT(EepNameMiddle, 1), '')  
                    --WHEN @FieldName = 'NameLast Suffix, FM' THEN LTRIM(RTRIM(EepNameLast)) + ' ' + LTRIM(RTRIM(EepNameSuffix)) + ', ' + LTRIM(RTRIM(EepNameFirst)) + ' ' + COALESCE(LEFT(EepNameMiddle, 1), '')  
                    WHEN @FieldName = 'NameLast Suffix, First M' THEN LTRIM(RTRIM(EepNameLast)) + ' ' +  COALESCE(LTRIM(RTRIM(EepNameSuffix)), '')   + ', ' + LTRIM(RTRIM(EepNameFirst)) + ' ' + COALESCE(LEFT(EepNameMiddle, 1), '')  
                    WHEN @FieldName = 'NameFirst Last'    THEN LTRIM(RTRIM(EepNameFirst)) + ' ' + LTRIM(RTRIM(EepNameLast))    
                    WHEN @FieldName = 'NameFML'           THEN LTRIM(RTRIM(EepNameFirst)) + ' ' + LTRIM(RTRIM(COALESCE(EepNameMiddle, ''))) + ' ' + LTRIM(RTRIM(EepNameLast))    
                    WHEN @FieldName = 'AddressEMail'      THEN EepAddressEMail    
                    WHEN @FieldName = 'PhoneHomeNumber'   THEN EepPhoneHomeNumber    
                    WHEN @FieldName = 'EmpNo'             THEN EecEmpNo    
                    WHEN @FieldName = 'Status'            THEN EecEmplStatus    
                    WHEN @FieldName = 'JobDesc'           THEN JbcDesc    
                    WHEN @FieldName = 'PhoneBusinessNumber'    THEN EecPhoneBusinessNumber
                    WHEN @FieldName = 'SupervisorExt'     THEN EecPhoneBusinessExt 
                    WHEN @FieldName = 'COID'              THEN @SupervisorCOID    
     ELSE ''    
     END    
FROM EmpPers    
JOIN EmpComp WITH (NOLOCK) ON EecEEID = EepEEID AND EecCOID = @SupervisorCOID    
JOIN dbo.JobCode WITH (NOLOCK) ON JbcJobCode = EecJobCode    
WHERE EepEEID = @SupervisorEEID    
    
    
-----------    
-- Return    
-----------    
    
RETURN LTRIM(RTRIM(COALESCE(@Return, '')))    
    
END    