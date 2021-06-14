SET NOCOUNT ON;
IF OBJECT_ID('U_EINTFULAC2_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EINTFULAC2_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EINTFULAC2_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EINTFULAC2' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_fnlib_GetSupervisorField_EINTFULAC2') IS NOT NULL DROP FUNCTION [dbo].[dsi_fnlib_GetSupervisorField_EINTFULAC2];
GO
IF OBJECT_ID('dsi_vwEINTFULAC2_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEINTFULAC2_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EINTFULAC2') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EINTFULAC2];
GO
IF OBJECT_ID('U_EINTFULAC2_File') IS NOT NULL DROP TABLE [dbo].[U_EINTFULAC2_File];
GO
IF OBJECT_ID('U_EINTFULAC2_EEList') IS NOT NULL DROP TABLE [dbo].[U_EINTFULAC2_EEList];
GO
IF OBJECT_ID('U_dsi_EINTFULAC2_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_dsi_EINTFULAC2_drvTbl];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EINTFULAC2';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EINTFULAC2';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EINTFULAC2';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EINTFULAC2';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EINTFULAC2';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0',NULL,NULL,'N',NULL,'N',NULL,'013010','EMPEXPORT','SDF','EINTFULAC2','Internal - Full File V2','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','EINTFULAC2K0','N','Apr  1 2015  5:20PM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EINTFULAC2' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last Name"','1','(''DA''=''T,'')','EINTFULAC2K0','9','H','01','1',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Name"','2','(''DA''=''T,'')','EINTFULAC2K0','10','H','01','2',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Preferred First Name"','3','(''DA''=''T,'')','EINTFULAC2K0','20','H','01','3',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Number"','4','(''DA''=''T,'')','EINTFULAC2K0','15','H','01','4',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Number (Supervisor)"','5','(''DA''=''T,'')','EINTFULAC2K0','28','H','01','5',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Supervisor Name (Last Suffix, First MI)"','6','(''DA''=''Q,'')','EINTFULAC2K0','39','H','01','6',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Supervisor Email Address"','7','(''DA''=''T,'')','EINTFULAC2K0','50','H','01','7',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Job Title"','8','(''DA''=''T,'')','EINTFULAC2K0','8','H','01','9',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Company"','9','(''DA''=''T,'')','EINTFULAC2K0','7','H','01','9',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Phone Mobile"','10','(''DA''=''Q,'')','EINTFULAC2K0','35','H','01','10',NULL,'Company',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Org Level 1 Code"','11','(''DA''=''T,'')','EINTFULAC2K0','16','H','01','11',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Location"','12','(''DA''=''T,'')','EINTFULAC2K0','8','H','01','12',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employment Status"','13','(''DA''=''T,'')','EINTFULAC2K0','17','H','01','13',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Termination Date"','14','(''DA''=''T'')','EINTFULAC2K0','17','H','01','14',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','1','(''UA''=''Q,'')','EINTFULAC2K0','35','D','02','1',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','2','(''UA''=''Q,'')','EINTFULAC2K0','35','D','02','2',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNamePreferred"','3','(''UA''=''Q,'')','EINTFULAC2K0','35','D','02','4',NULL,'Preferred First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpNo"','4','(''UA''=''T,'')','EINTFULAC2K0','35','D','02','4',NULL,'Employee Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSupEmpNo"','5','(''UA''=''T,'')','EINTFULAC2K0','35','D','02','5',NULL,'Employee Number (Supervisor)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSupNameFull"','6','(''UA''=''Q,'')','EINTFULAC2K0','70','D','02','6',NULL,'Supervisor Name (Last Suffix,',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSupEmail"','7','(''UA''=''T,'')','EINTFULAC2K0','70','D','02','7',NULL,'Supervisor Email Address,',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobTitle"','8','(''UA''=''Q,'')','EINTFULAC2K0','70','D','02','8',NULL,'Job Title',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCompany"','9','(''UA''=''Q,'')','EINTFULAC2K0','35','D','02','9',NULL,'Company',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMobileNumber"','10','(''UA''=''Q,'')','EINTFULAC2K0','35','D','02','10',NULL,'Company',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOrgLevel1Code"','11','(''UA''=''T,'')','EINTFULAC2K0','35','D','02','11',NULL,'Org Level 1 Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLocation"','12','(''UA''=''Q,'')','EINTFULAC2K0','70','D','02','12',NULL,'Location',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmplStatus"','13','(''UA''=''T,'')','EINTFULAC2K0','35','D','02','13',NULL,'Employment Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermDate"','14','(''UD101''=''T'')','EINTFULAC2K0','35','D','02','14',NULL,'Employment Status',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EINTFULAC2_20210611.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,',Q6TZY,IAGFG',NULL,NULL,NULL,'TEST FILE FOR CHANGES','201508149','EMPEXPORT','ADFILE',NULL,'EINTFULAC2',NULL,NULL,NULL,'201508149',NULL,NULL,'201508141',NULL,'','','201508141',dbo.fn_GetTimedKey(),NULL,NULL,NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'Null','N','XBOEJ,XBO8J,XBOH9,XBORR,QV6J9,Q6TZY,XBOY6,IAGFG,XMKY0,T5TDY,6B0HR,ND73A',NULL,NULL,NULL,'Export to AD File feed','201504299','EMPEXPORT','EINTFULAC2','Apr  2 2015  3:43PM','EINTFULAC2',NULL,NULL,NULL,'202103109','Apr  1 2015 12:00AM','Dec 30 1899 12:00AM','202103031','1002','','','201504291',dbo.fn_GetTimedKey(),NULL,'USGTDIMAIO',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'TEST','202105281','EMPEXPORT','TEST','May 28 2021 12:55PM','EINTFULAC2',NULL,NULL,NULL,'202105281','May 28 2021 12:00AM','Dec 30 1899 12:00AM','202105271','753','','','202105271',dbo.fn_GetTimedKey(),NULL,'us3rVaACS1003',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EINTFULAC2','CountFilter','C',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EINTFULAC2','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EINTFULAC2','ExportDescription','C','Internal - Full File - ACSA');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EINTFULAC2','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EINTFULAC2','InitialSort','C','drvNameLast');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EINTFULAC2','MaxFileLength','C','2000');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EINTFULAC2','SubSort','C','drvNameFirst');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EINTFULAC2','SystemID','V','AKFPDN0010K0');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EINTFULAC2','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EINTFULAC2','UseAudit','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EINTFULAC2','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EINTFULAC2' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EINTFULAC2' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EINTFULAC2_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EINTFULAC2_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EINTFULAC2','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EINTFULAC2','D02','dbo.U_dsi_EINTFULAC2_drvTbl',NULL);
IF OBJECT_ID('U_dsi_EINTFULAC2_drvTbl') IS NULL
CREATE TABLE [dbo].[U_dsi_EINTFULAC2_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvcoid] char(5) NULL,
    [drvdepid] varchar(30) NULL,
    [drvrectype] varchar(1) NOT NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNamePreferred] varchar(100) NULL,
    [drvEEPeeid] varchar(1) NOT NULL,
    [drvEmpNo] char(9) NULL,
    [drvSupEmpNo] varchar(256) NULL,
    [drvSupEEID] varchar(1) NOT NULL,
    [drvSupNameFull] varchar(205) NULL,
    [drvSupEmail] varchar(50) NULL,
    [drvEECudfield29] varchar(1) NOT NULL,
    [drvPlus1SupEEID] varchar(1) NOT NULL,
    [drvEECudfield01] varchar(1) NOT NULL,
    [drvJobCode] varchar(1) NOT NULL,
    [drvJobTitle] varchar(150) NULL,
    [drvCompany] char(5) NULL,
    [drvMobileNumber] varchar(50) NULL,
    [drvOrgLevel1Desc] varchar(25) NULL,
    [drvOrgLevel1Code] char(10) NULL,
    [drvLocation] varchar(25) NULL,
    [drvEmplStatus] varchar(45) NULL,
    [drvTermDate] datetime NULL
);
IF OBJECT_ID('U_EINTFULAC2_EEList') IS NULL
CREATE TABLE [dbo].[U_EINTFULAC2_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EINTFULAC2_File') IS NULL
CREATE TABLE [dbo].[U_EINTFULAC2_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(2000) NULL
);
GO
/* 
delete from dbo.U_dsi_TOC
  where tocItem = 'dsi_sp_BuildDriverTables_EINTFULAC2'
insert into dbo.U_dsi_TOC(tocItem, tocLastUpdated, tocType, tocVersion)
  select 'dsi_sp_BuildDriverTables_EINTFULAC2',getdate(),'P','V1.TD'


  SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EINTFULAC2';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EINTFULAC2';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EINTFULAC2';
SELECT * FROM dbo.AscExp WHERE expFormatCode = 'EINTFULAC2';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EINTFULAC2' ORDER BY RunID DESC;


EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EINTFULAC2', @AllObjects = 'Y', @IsWeb = 'Y'
*/

CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EINTFULAC2]
 @systemid varchar(12) = ''
AS
Begin

/*************************************************************************************************
DRIVER TABLE SP FOR:  Internal File (FULL File) - CSV
BUILT FOR: Pivot Technology Solutions (f/k/a ACS Acquisition Holdings)
ORIGINAL BUILD (V-1.0): 04/01/2015 - TDiMaio   - SF 5132257
*************************************************************************************************/

-- Collect the @Start and @End Percontrol/PayDates upfront

    /***************************
    COLLECT DATE PARAMETERS
    ****************************/
    DECLARE 
        @StartDate DATETIME,
        @EndDate DATETIME,
        @StartPerControl Char(9),
        @EndPerControl Char(9),
        @FormatCode Char(10),
        @ExportCode Char(10),
        @ExportFile char(200)
        
    --    Declare @Systemid char(12) 
    --    set @Systemid = '6DWPQL0000K0'

    SELECT 
        @StartDate = CONVERT(DATETIME, LEFT(StartPerControl, 8) ),
        @EndDate = CONVERT(DATETIME, LEFT(EndPerControl , 8)  ),
        @StartPerControl = startpercontrol,
        @EndPerControl  = endpercontrol,
        @FormatCode = rtrim(formatcode),
        @ExportCode = Exportcode,
        @Exportfile = ExportFile
    FROM dbo.U_Dsi_Parameters 
    WHERE SystemID = @SystemID


-- dedcodes
 
declare @DedList varchar(200) 
select @DedList = 'x'    --no longer used


        
-- change variables below as needed
declare @daysstopped int   
declare @useaudit char(1)
declare @includeoe char(1)

declare @showalldeds char(1)
declare @allcomp char(1)
declare @onerecperemp char(1)
declare @showstoppedoe  char(1)
declare @oetype char(1)
set @daysstopped = 15    -- set number of days if looking for only showing deds stopped within certain days
set @useaudit = 'Y'    -- Y or N  indicates if this export uses audit to determine data to pull
set @includeoe = 'N' --'Y'   -- Y or N  indicates if this export will include open enrollment
set @showalldeds = 'N' -- Y or N  indicates if this export shows stopped and active ded of same type
set @allcomp = 'Y'     -- Y or N  indicates if this export pull deds for all companies for an employee
set @onerecperemp = 'Y'  -- Y or N indicate if the export should show only one record per employee
set @showstoppedoe = 'N' -- Y or N  indicates if stopped open enrollment deductions should be shown
set @oetype = 'F'        -- P or F indicates if this export is for a passive or full(active) oe


-- clean up EELIST if needed

-- clean up list if not using all companies
if @allcomp = 'N'
begin
            delete dbo.u_EINTFULAC2_EELIST
            from dbo.u_EINTFULAC2_EELIST
            join empcomp t with (nolock) on xeeid = eeceeid and xcoid = eeccoid
            where t.eecemplstatus = 'T'
            and exists(select 1 from empcomp a where a.eeceeid = t.eeceeid
                and a.eecemplstatus <> 'T')

end



----BDM
---- replace Esssssssss with the OE session if applicable

--DELETE FROM U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode

--INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'DedCodes','x')
--IF @ExportCode <> 'Esssssssss' BEGIN
--    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'StartDateTime',@EndDate - @daysstopped)
--    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'EndDateTime',@EndDate)
--END
--IF @ExportCode = 'Esssssssss' BEGIN
--    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'StartDateTime',@StartDate)
--    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'EndDateTime',@EndDate)
--END

--INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'TermSelectionOption', 'stopdate')    --'ActiveOnly')    --'stoptdate')    --'AuditDate')

--IF @ExportCode = 'Esssssssss' BEGIN
--   INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'Passive')--'Active')
--END


--EXEC dbo.dsi_bdm_sp_PopulateDeductionsTable @FormatCode



-- Clean up eelist if only one record per employee
if @onerecperemp = 'Y'
begin
            delete dbo.u_EINTFULAC2_EELIST
            from dbo.u_EINTFULAC2_EELIST
            join empcomp t with (nolock) on xeeid = eeceeid and xcoid = eeccoid
            where t.eecemplstatus = 'T'
            and exists(select 1 from empcomp a where a.eeceeid = t.eeceeid
                and a.eecemplstatus <> 'T')

            delete dbo.u_EINTFULAC2_eelist
            from dbo.u_EINTFULAC2_eelist a
            join emppers with (nolock) on xeeid = eepeeid
            where eephomecoid <> xcoid
            and exists(select 1 from dbo.u_EINTFULAC2_eelist b where a.xeeid = b.xeeid
            having count(*) > 1)
end

--TD 4/8/15 exclude TEST employees:
delete dbo.u_EINTFULAC2_eelist
from dbo.u_EINTFULAC2_eelist
join emppers t with (nolock) on xeeid = t.eepeeid 
where t.EepNameLast like 'test%'




-- Populate Source for Employees 
if object_id('dbo.U_dsi_EINTFULAC2_drvTbl') is not null
  drop table dbo.U_dsi_EINTFULAC2_drvTbl

-- EE Detail

  select distinct
    drvEEID = xEEID, 
    drvcoid = xcoid,
    drvdepid = cast(null as varchar),
    drvrectype = 'E',
-----------------------------------------------------
    --drvPrefix = RTRIM(eepNamePrefix), -- 5/27/2021 Remove field
    drvNameLast = rtrim(eepnamelast),
    drvNameFirst = rtrim(eepnamefirst),
    drvNamePreferred = rtrim(eepNamePreferred),
    --drvNameSuffix = RTRIM(eepNameSuffix), -- 5/27/2021 Remove field
    drvEEPeeid = '',--eepeeid,
    drvEmpNo = EecEmpNo,
    drvSupEmpNo = [dbo].[dsi_fnlib_GetSupervisorField_EINTFULAC2](xCoid, xEEID, 'EmpNo'), --super.empno,
    drvSupEEID = '',--super.seeid,--TD 4/2/15 added new column
    drvSupNameFull = --'"' + 
                        rtrim(super.lname)+', '+rtrim(super.fname)+
                  case when isnull(super.mname,'') <> '' then ' '+left(super.mname,1)+'.' else '' end --+ '"',
    ,drvSupEmail = super.sEmail,
    drvEECudfield29 = '',--EecUDField29,
    drvPlus1SupEEID = '',--p1super.eeid,--TD 4/2/15 added new column
    drvEECudfield01 = '',--eecUDField01,
    drvJobCode = '',--EecJobCode,
    drvJobTitle = EecJobtitle,--JbcDesc,
    drvCompany = cmpCompanyCode -- rtrim(CmpCompanyName)
    ,drvMobileNumber = (Select top 1 efoPhoneNumber from dbo.EmpMPhon where efoeeid = xeeid and efoPhoneType = 'CEL' and efoisPrivate = 'N')
    ,drvOrgLevel1Desc = o1.OrgDesc,
    drvOrgLevel1Code = EecOrgLvl1,
    drvLocation = LocDesc,
    drvEmplStatus = estat.descr
    ,drvTermDate = EecDateOfTermination

  into dbo.U_dsi_EINTFULAC2_drvTbl
  from dbo.u_EINTFULAC2_eelist with (nolock)
    join empPers with (nolock) on xEEID = eepEEID
    join empcomp with (nolock) on xEEID = eecEEid and xCOID = eecCOID
    join jobcode on jbcjobcode = eecjobcode
    join Company on CmpCoID = xCoID and CmpCompanyCode <> 'ZHRON'
    join location on eeclocation = LocCode
    
    left join (select eepEEID seeid, b.EecCoID sEECOID, eepSSN ssn,eepnamefirst fname, eepnamelast lname,EepNameMiddle mname, EepAddressEmail AS sEmail, empcomp.eecsupervisorid, b.eeceeid, b.eecempno empno from empcomp 
                    join empcomp b on b.eeceeid = empcomp.eecsupervisorid and b.EecEmplStatus = 'A'
                    join emppers on emppers.eepeeid = b.eeceeid) super on super.sEEID = empcomp.eecSupervisorID --and super.sEECOID = empcomp.EecCoID

    left join (select eeceeid eeid, eecempno empno from empcomp) p1super on p1super.empno = eecUDField01 --TD 4/2/15

    left join (select orgLvl, orgDesc, orgCode
        from orgLevel ) o1 on orgLvl = 1 and o1.orgCode = eecOrgLvl1

    left join (select codcode, coddesc descr from codes where codtable = 'EMPLOYEESTATUS') estat on estat.codcode = eecemplstatus

  --where EecEmplStatus in ('A','L') --only include Active and Leave employees
 where (EecEmplStatus in ('A','L') -- include 30 day terms
  or eecemplstatus in ('T') and eecTermReason <> 'TRO' and eecDateofTermination between (DATEADD( D,-30, @enddate)) and @enddate)
  and EecOrgLvl1 not in ('DSPR','SAPR') --TD 4/8/15 exclude EE's in these departments

          
-- Create Headers

-- Create Trailers


-- Set FileName  
if (dbo.dsi_fnVariable('EINTFULAC2','UseFileName') = 'N')
  update dbo.U_dsi_Parameters
    set ExportFile =  'ACSA_INT_FUL_' + convert(char(8),getdate(),112) + '.csv'
    where FormatCode = 'EINTFULAC2'




-- Remember to alter view for correct sorting
/*
 ALTER  View dbo.dsi_vwEINTFULAC2_Export as
        select top 2000000 rtrim(Data) as Data
         from dbo.U_EINTFULAC2_File with (nolock)
         order by case when substring(Recordset,1,1) = 'H' then 1 else 2 end,
            initialsort, subsort, substring(Recordset,2,2)
*/



--Used for testing
--dbo.dsi_sp_TestSwitchbox_v2 'EINTFULAC2','EINTFULAC2'
--dbo.dsi_sp_TestSwitchbox_v2 'EINTFULAC2','TEST'

-- EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EINTFULAC2', @AllObjects = 'Y', @IsWeb = 'Y'

END
GO
 CREATE  View dbo.dsi_vwEINTFULAC2_Export as
        select top 2000000 rtrim(Data) as Data
         from dbo.U_EINTFULAC2_File with (nolock)
         order by case when substring(Recordset,1,1) = 'H' then 1 else 2 end,
            initialsort, subsort, substring(Recordset,2,2)
GO
CREATE FUNCTION [dbo].[dsi_fnlib_GetSupervisorField_EINTFULAC2] (    
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