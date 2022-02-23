SET NOCOUNT ON;
IF OBJECT_ID('U_EPFPAYRSN2_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EPFPAYRSN2_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EPFPAYRSN2_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EPFPAYRSN2' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEPFPAYRSN2_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEPFPAYRSN2_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EPFPAYRSN2') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EPFPAYRSN2];
GO
IF OBJECT_ID('U_EPFPAYRSN2_File') IS NOT NULL DROP TABLE [dbo].[U_EPFPAYRSN2_File];
GO
IF OBJECT_ID('U_EPFPAYRSN2_EEList') IS NOT NULL DROP TABLE [dbo].[U_EPFPAYRSN2_EEList];
GO
IF OBJECT_ID('U_dsi_EPFPAYRSN2_trlTbl') IS NOT NULL DROP TABLE [dbo].[U_dsi_EPFPAYRSN2_trlTbl];
GO
IF OBJECT_ID('U_dsi_EPFPAYRSN2_hdrTbl') IS NOT NULL DROP TABLE [dbo].[U_dsi_EPFPAYRSN2_hdrTbl];
GO
IF OBJECT_ID('U_dsi_EPFPAYRSN2_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_dsi_EPFPAYRSN2_drvTbl];
GO
IF OBJECT_ID('U_dsi_EPFPAYRSN2_DedHist_YTD') IS NOT NULL DROP TABLE [dbo].[U_dsi_EPFPAYRSN2_DedHist_YTD];
GO
IF OBJECT_ID('U_dsi_EPFPAYRSN2_DedHist') IS NOT NULL DROP TABLE [dbo].[U_dsi_EPFPAYRSN2_DedHist];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EPFPAYRSN2';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EPFPAYRSN2';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EPFPAYRSN2';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EPFPAYRSN2';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EPFPAYRSN2';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0',NULL,NULL,'N',NULL,'N',NULL,'013010','EMPEXPORT','SDF','EPFPAYRSN2','PayFlex FSA Payroll V2','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','C358D54FFFC2','N','Oct  9 2015 10:21AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"hdrRecordIndicator"','1','(''UA''=''F'')','C358D54FFFC2','1','H','01','1',NULL,'Record Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"hdrFormatType"','2','(''UA''=''F'')','C358D54FFFC2','1','H','01','2',NULL,'Format Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"hdrLayoutType"','3','(''UA''=''F'')','C358D54FFFC2','1','H','01','3',NULL,'Layout Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"hdrDateCreated"','4','(''UA''=''F'')','C358D54FFFC2','8','H','01','4',NULL,'Date Created',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"hdrTimeCreated"','5','(''UA''=''F'')','C358D54FFFC2','6','H','01','12',NULL,'Time Created',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"hdrEmployerID"','6','(''UA''=''F'')','C358D54FFFC2','7','H','01','18',NULL,'Employer ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"hdrEmployerName"','7','(''UA''=''F'')','C358D54FFFC2','50','H','01','25',NULL,'Employer Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"hdrMemo"','8','(''UA''=''F'')','C358D54FFFC2','25','H','01','75',NULL,'Memo',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"hdrLayoutVersion"','9','(''UA''=''F'')','C358D54FFFC2','9','H','01','100',NULL,'Layout Version',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordType"','1','(''UA''=''F'')','C358D54FFFC2','7','D','02','1',NULL,'RecordType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmprID"','2','(''UA''=''F'')','C358D54FFFC2','6','D','02','8',NULL,'EmprID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemNumber"','3','(''UA''=''F'')','C358D54FFFC2','9','D','02','14',NULL,'MemNumber',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanYearEffectiveDate"','4','(''UA''=''F'')','C358D54FFFC2','10','D','02','23',NULL,'PlanYearEffectiveDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccountType"','5','(''UA''=''F'')','C358D54FFFC2','2','D','02','33',NULL,'AccountType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepositType"','6','(''UA''=''F'')','C358D54FFFC2','1','D','02','35',NULL,'DepositType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepositDate"','7','(''UA''=''F'')','C358D54FFFC2','10','D','02','36',NULL,'DepositDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepositAmount"','8','(''UA''=''F'')','C358D54FFFC2','8','D','02','46',NULL,'DepositAmount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTaxYear"','9','(''UA''=''F'')','C358D54FFFC2','4','D','02','54',NULL,'TaxYear',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"trlRecordIndicator"','1','(''UA''=''F'')','C358D54FFFC2','1','T','03','1',NULL,'Record Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"trlRecordCount"','2','(''UA''=''F'')','C358D54FFFC2','10','T','03','2',NULL,'Record Count',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"trlTotalContributions"','3','(''UA''=''F'')','C358D54FFFC2','12','T','03','12',NULL,'Total Contributions',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EPFPAYRSN2_20200601.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'PayFlex FSA Payroll OE ACTIVE','201510099','EMPEXPORT','OEACTIVE',NULL,'EPFPAYRSN2',NULL,NULL,NULL,'201510099',NULL,NULL,'201507111',NULL,NULL,NULL,'201507111',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EPFPAYRSN2_20200601.txt',NULL,'','','Q6UBF,QJI1W',NULL,NULL,NULL,'PayFlex FSA Payroll','202004171','EMPEXPORT','EPFPAYRSN2','Apr 27 2020  8:08AM','EPFPAYRSN2',NULL,NULL,NULL,'202004171','Apr 17 2020 12:00AM','Apr 11 2020 12:00AM','202004171','123','eecPayGroup','BW','202004171',dbo.fn_GetTimedKey(),NULL,'us3lKiSUN1011',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EPFPAYRSN2_20200601.txt' END WHERE expFormatCode = 'EPFPAYRSN2';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPFPAYRSN2','CountFilter','C',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPFPAYRSN2','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPFPAYRSN2','ExportDescription','C','PayFlex FSA Payroll - SNKST V2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPFPAYRSN2','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPFPAYRSN2','InitialSort','C','drvEEID');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPFPAYRSN2','MaxFileLength','C','118');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPFPAYRSN2','SubSort','C',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPFPAYRSN2','SystemID','V','FE57613CCAE2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPFPAYRSN2','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPFPAYRSN2','UseAudit','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPFPAYRSN2','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EPFPAYRSN2' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EPFPAYRSN2' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EPFPAYRSN2_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EPFPAYRSN2_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPFPAYRSN2','H01','dbo.U_dsi_EPFPAYRSN2_hdrTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPFPAYRSN2','D02','dbo.U_dsi_EPFPAYRSN2_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPFPAYRSN2','T03','dbo.U_dsi_EPFPAYRSN2_trlTbl',NULL);
IF OBJECT_ID('U_dsi_EPFPAYRSN2_DedHist') IS NULL
CREATE TABLE [dbo].[U_dsi_EPFPAYRSN2_DedHist] (
    [heeid] char(12) NULL,
    [hcoid] char(5) NULL,
    [hdedcode] char(5) NOT NULL,
    [pdhpaydate] datetime NULL,
    [heeamt] money NULL,
    [heramt] money NULL
);
IF OBJECT_ID('U_dsi_EPFPAYRSN2_DedHist_YTD') IS NULL
CREATE TABLE [dbo].[U_dsi_EPFPAYRSN2_DedHist_YTD] (
    [heeid] char(12) NULL,
    [hcoid] char(5) NULL,
    [hdedcode] char(5) NOT NULL,
    [heeamt] money NULL,
    [heramt] money NULL,
    [paydate] datetime NULL
);
IF OBJECT_ID('U_dsi_EPFPAYRSN2_drvTbl') IS NULL
CREATE TABLE [dbo].[U_dsi_EPFPAYRSN2_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvcoid] char(5) NULL,
    [drvRecordType] varchar(7) NOT NULL,
    [drvEmprID] varchar(6) NOT NULL,
    [drvMemNumber] varchar(9) NULL,
    [dedcode] char(5) NOT NULL,
    [Dtate] datetime NULL,
    [drvPlanYearEffectiveDate] varchar(10) NULL,
    [drvAccountType] varchar(2) NOT NULL,
    [drvDepositType] varchar(1) NOT NULL,
    [drvDepositDate] varchar(10) NULL,
    [drvDepositAmount] money NULL,
    [drvTaxYear] varchar(4) NULL
);
IF OBJECT_ID('U_dsi_EPFPAYRSN2_hdrTbl') IS NULL
CREATE TABLE [dbo].[U_dsi_EPFPAYRSN2_hdrTbl] (
    [hdrRecordIndicator] varchar(1) NOT NULL,
    [hdrFormatType] varchar(1) NOT NULL,
    [hdrLayoutType] varchar(1) NOT NULL,
    [hdrDateCreated] varchar(30) NULL,
    [hdrTimeCreated] varchar(8000) NULL,
    [hdrEmployerID] varchar(6) NOT NULL,
    [hdrEmployerName] varchar(20) NOT NULL,
    [hdrMemo] varchar(1) NOT NULL,
    [hdrLayoutVersion] varchar(9) NOT NULL
);
IF OBJECT_ID('U_dsi_EPFPAYRSN2_trlTbl') IS NULL
CREATE TABLE [dbo].[U_dsi_EPFPAYRSN2_trlTbl] (
    [trlRecordIndicator] varchar(1) NOT NULL,
    [trlRecordCount] varchar(10) NULL,
    [trlTotalContributions] varchar(12) NULL
);
IF OBJECT_ID('U_EPFPAYRSN2_EEList') IS NULL
CREATE TABLE [dbo].[U_EPFPAYRSN2_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EPFPAYRSN2_File') IS NULL
CREATE TABLE [dbo].[U_EPFPAYRSN2_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(1000) NULL
);
GO
/* 
delete from dbo.U_dsi_TOC
  where tocItem = 'dsi_sp_BuildDriverTables_EPFPAYRSN2'
insert into dbo.U_dsi_TOC(tocItem, tocLastUpdated, tocType, tocVersion)
  select 'dsi_sp_BuildDriverTables_EPFPAYRSN2','02/26/2013','P','V1.HSA'
*/

CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EPFPAYRSN2]
 @systemid varchar(12) = ''
AS
Begin

/*************************************************************************************************
DRIVER TABLE SP FOR:  PAYFLEX - PAYROLL FILE
BUILT FOR: Sunkist Growers, Inc.
ORIGINAL BUILD (V-1.0): 10/09/2015 - chas - SF 05722032

Updates
Justin Kurth    12/21/2017        SF#10240458        Updated drv JOIN statement to move where it joins on empded to account for deductions that still report info but recently termed.
Marco Lagrosa   04/21/2020        TekP-2020-02-10-0003        Update to add FSADC, FSAMD,HCF18 and ‘HSA’
*************************************************************************************************/

-- Collect the @Start and @End Percontrol/PayDates upfront


--Execute Export
--------------
--EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPFPAYRSN2', 'OEACTIVE';
--EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPFPAYRSN2', 'EPFPAYRSN2';
--Select * FROM U_dsi_bdm_Configuration WHERE FormatCode = 'EPFPAYRSN2';

--SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EPFPAYRSN2';
--SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EPFPAYRSN2';
--SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EPFPAYRSN2';
--SELECT * FROM dbo.AscExp WHERE expFormatCode = 'EPFPAYRSN2';
--SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EPFPAYRSN2' ORDER BY RunID DESC;
--EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EPFPAYRSN2', @AllObjects = 'Y', @IsWeb = 'Y'
 /***************************
 COLLECT DATE PARAMETERS
 ****************************/
 
 WAITFOR DELAY '00:00:30'
 
 DECLARE 
  @StartDate DATETIME,
  @EndDate DATETIME,
  @StartPerControl Char(9),
  @EndPerControl Char(9),
  @FormatCode Char(10),
  @ExportCode Char(10),
  @ExportFile char(200),
  @PlanDate DATETIME
  
 -- Declare @Systemid char(12) 
 -- set @Systemid = '6DWPQL0000K0'

 SELECT 
  @StartDate = CONVERT(DATETIME, LEFT(StartPerControl, 8) ),
  @EndDate = CONVERT(DATETIME, LEFT(EndPerControl , 8)  ),
  @StartPerControl = startpercontrol,
  @EndPerControl  = endpercontrol,
  @FormatCode = rtrim(formatcode),
  @ExportCode = Exportcode,
  @Exportfile = ExportFile,
  @PlanDate = convert(varchar(4), year(@EndDate)) + '0101'

 FROM dbo.U_Dsi_Parameters 
 WHERE SystemID = @SystemID

-- dedcodes

declare @DedList varchar(200) 
select @DedList = 'x' --no longer used

  
-- change variables below as needed
declare @daysstopped int   
declare @useaudit char(1)
declare @includeoe char(1)

declare @showalldeds char(1)
declare @allcomp char(1)
declare @onerecperemp char(1)
declare @showstoppedoe  char(1)
declare @oetype char(1)
set @daysstopped = 14 -- set number of days if looking for only showing deds stopped within certain days
set @useaudit = 'Y'    -- Y or N  indicates if this export uses audit to determine data to pull
set @includeoe = 'N'   -- Y or N  indicates if this export will include open enrollment
set @showalldeds = 'N' -- Y or N  indicates if this export shows stopped and active ded of same type
set @allcomp = 'Y'     -- Y or N  indicates if this export pull deds for all companies for an employee
set @onerecperemp = 'Y'  -- Y or N indicate if the export should show only one record per employee
set @showstoppedoe = 'N' -- Y or N  indicates if stopped open enrollment deductions should be shown
set @oetype = 'F'  -- P or F indicates if this export is for a passive or full(active) oe

-- clean up EELIST if needed

-- clean up list if not using all companies
if @allcomp = 'N'
begin
   delete dbo.u_EPFPAYRSN2_EELIST
   from dbo.u_EPFPAYRSN2_EELIST
   join empcomp t with (nolock) on xeeid = eeceeid and xcoid = eeccoid
   where t.eecemplstatus = 'T'
   and exists(select 1 from empcomp a where a.eeceeid = t.eeceeid
    and a.eecemplstatus <> 'T')

end

--BDM
-- replace ECOLFSAPOE with the OE session if applicable

DELETE FROM U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode

--INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'DedCodes','FSA, FSADC')
--INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'DedCodes','DCARE,HCARE,LSFSA,HSAEC,HSAEE,HSAEF,HSAFC')
INSERT INTO U_dsi_bdm_Configuration VALUES 
(@FormatCode, 'DedCodes','DCARE, HCARE, LSFS1, LSFS2, LSFS3, LSFS4, HSAER, HSAE1, HSAE2, HSAE3, HSAE4, HSAF1, HSAF2, HSAF3, HSAF4, HSEC1, HSEC2, HSEC3, HSEC4, HSFC1, HSFC2, HSFC3, HSFC4, FSADC ,FSAMD,HCF18,HSA    ')

IF @ExportCode NOT LIKE 'OE%' BEGIN
 INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'StartDateTime',@StartDate) --@EndDate - @daysstopped)
 INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'EndDateTime',@EndDate)
END
IF @ExportCode = 'OEACTIVE' BEGIN
 INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'StartDateTime',@StartDate)
 INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'EndDateTime',@EndDate)
END

IF @ExportCode = 'OEPASSIVE' BEGIN
 INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'StartDateTime',@StartDate)
 INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'EndDateTime',@EndDate)
END

INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'TermSelectionOption', 'AuditDate') --'ActiveOnly') --'stoptdate') --'AuditDate')

IF @ExportCode = 'OEACTIVE' BEGIN
   INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'Active') --'Active')
END

IF @ExportCode = 'OEPASSIVE' BEGIN
   INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'Passive') --'Active')
END
EXEC dbo.dsi_bdm_sp_PopulateDeductionsTable @FormatCode

--select * from U_dsi_bdm_EmpDeductions where eedformatcode = 'EPFPAYRSN2'

-- Build deduction history

if object_id('dbo.U_dsi_EPFPAYRSN2_DedHist') is not null
  drop table dbo.U_dsi_EPFPAYRSN2_DedHist

SELECT
 xEEID heeid,
 xCOID hcoid,
 pdhdedcode hdedcode,pdhpaydate,
 SUM(ISNULL(PDHEECURAMT,0.00)) AS heeamt,
 SUM(ISNULL(PDHERCURAMT,0.00)) AS heramt

 INTO dbo.U_dsi_EPFPAYRSN2_DedHist
  from dbo.u_EPFPAYRSN2_EELIST 
 JOIN PDEDHIST (nolock) ON xeeid = PdhEEID and xCOID = PdhCOID
  AND (PDHEECURAMT <> 0 or PDHERCURAMT <> 0)
  --AND PDHDEDCODE IN ('DCARE','HCARE','LSFSA','HSAEC','HSAEE','HSAEF','HSAFC')
  AND PDHDEDCODE IN ('DCARE','HCARE','LSFS1','LSFS2','LSFS3','LSFS4','HSAER','HSAE1','HSAE2','HSAE3','HSAE4','HSAF1','HSAF2','HSAF3','HSAF4','HSEC1','HSEC2','HSEC3','HSEC4','HSFC1','HSFC2','HSFC3','HSFC4','FSADC' ,'FSAMD','HCF18','HSA')
  AND substring(PDHPERCONTROL,1,8) BETWEEN substring(@StartPerControl,1,8) and substring(@EndPerControl,1,8)
 GROUP BY xEEID,xCOID,PdhDedCode,pdhpaydate

-- Build deduction history

if object_id('dbo.U_dsi_EPFPAYRSN2_DedHist_YTD') is not null
  drop table dbo.U_dsi_EPFPAYRSN2_DedHist_YTD

SELECT
 xEEID heeid,
 xCOID hcoid,
 pdhdedcode hdedcode,
 SUM(ISNULL(PDHEECURAMT,0.00)) AS heeamt,
 SUM(ISNULL(PDHERCURAMT,0.00)) AS heramt, pdhpaydate paydate

 INTO dbo.U_dsi_EPFPAYRSN2_DedHist_YTD
 -- select *
  from dbo.u_EPFPAYRSN2_EELIST 
 JOIN PDEDHIST (nolock) ON xeeid = PdhEEID and xCOID = PdhCOID
  AND (PDHEECURAMT <> 0 or PDHERCURAMT <> 0)
  --AND PDHDEDCODE IN ('DCARE','HCARE','LSFSA','HSAEC','HSAEE','HSAEF','HSAFC')
  AND PDHDEDCODE IN ('DCARE','HCARE','LSFS1','LSFS2','LSFS3','LSFS4','HSAER','HSAE1','HSAE2','HSAE3','HSAE4','HSAF1','HSAF2','HSAF3','HSAF4','HSEC1','HSEC2','HSEC3','HSEC4','HSFC1','HSFC2','HSFC3','HSFC4')
  --AND PDHPERCONTROL BETWEEN @StartPerControl and @EndPerControl
 and substring(@StartPerControl,1,4) = substring(@EndPerControl,1,4) 

 GROUP BY xEEID,xCOID,PdhDedCode, pdhpaydate

-- select * from dbo.U_dsi_EPFPAYRSN2_DedHist_YTD

---- Step20 Clean up eelist if needed to only include employees with deductions
--   delete dbo.u_EPFPAYRSN2_eelist
--   from dbo.u_EPFPAYRSN2_eelist a
--   where not exists(select 1 from U_dsi_bdm_EmpDeductions
--       where a.xeeid = eedeeid
--       and a.xcoid = eedcoid
--       and eedformatcode = @formatcode
--       and eedvalidforexport = 'Y')

-- Clean up eelist if only one record per employee
if @onerecperemp = 'Y'
begin
   delete dbo.u_EPFPAYRSN2_EELIST
   from dbo.u_EPFPAYRSN2_EELIST
   join empcomp t with (nolock) on xeeid = eeceeid and xcoid = eeccoid
   where t.eecemplstatus = 'T'
   and exists(select 1 from empcomp a where a.eeceeid = t.eeceeid
    and a.eecemplstatus <> 'T')

   delete dbo.u_EPFPAYRSN2_eelist
   from dbo.u_EPFPAYRSN2_eelist a
   join emppers with (nolock) on xeeid = eepeeid
   where eephomecoid <> xcoid
   and exists(select 1 from dbo.u_EPFPAYRSN2_eelist b where a.xeeid = b.xeeid
   having count(*) > 1)
end

-- Populate Source for Employees

if object_id('U_dsi_EPFPAYRSN2_drvTbl') is not null
  drop table dbo.U_dsi_EPFPAYRSN2_drvTbl

-- EE Detail

  select distinct
 drvEEID = xEEID, 
 drvcoid = xcoid,
-- standard fields above and additional driver fields below

 drvRecordType = 'DEPOSIT',
 drvEmprID = '123346', 
 drvMemNumber = right('000000000' + ltrim(rtrim(eecempno)),9),    --eepssn,
 --drvPlanYearEffectiveDate= convert(varchar(10),eedbenstartdate,101),
 dh.dedcode,
 Dtate = @PlanDate,
 drvPlanYearEffectiveDate= case 
                                when dh.dedcode in ('FSADC','FSAMD','HCF18','HSA') THEN convert(varchar(10),@PlanDate,101) 
                                when dh.dedcode not in ('FSADC','FSAMD','HCF18','HSA') and ISNULL(eedBenStartDate,'01/01/1900') < @PlanDate then convert(varchar(10),@PlanDate,101) 
                                when dh.dedcode not in ('FSADC','FSAMD','HCF18','HSA') then convert(varchar(10),eedBenStartDate,101) end,
 drvAccountType= case 
     when dh.dedcode in ('HCARE','FSAMD','HCF18') then '5' 
     when dh.dedcode  in ('DCARE','FSADC') then '4' 
     when dh.dedcode IN ('LSFSA','LSFS1','LSFS2','LSFS3','LSFS4') then '11' 
     when dh.dedcode IN ('HSA','HSAEC','HSAEE','HSAEF','HSAFC','HSAER','HSAE1','HSAE2','HSAE3','HSAE4','HSAF1','HSAF2','HSAF3','HSAF4','HSEC1','HSEC2','HSEC3','HSEC4','HSFC1','HSFC2','HSFC3','HSFC4') then '16' 
     else '' 
     end, 
 drvDepositType = case when dh.dedcode = 'HSAER' then '2' else '1' end,
 drvDepositDate = convert(varchar(10),dh.paydate,101),
 drvDepositAmount = dh.eeamt,
 drvTaxYear = case when dh.dedcode in ('FSADC','FSAMD','HCF18','HSA') THEN convert(varchar(4), year(@EndDate)) ELSE  '' END -- Need Tax Year ???

--select * from empded

  into dbo.U_dsi_EPFPAYRSN2_drvTbl
  from dbo.u_EPFPAYRSN2_eelist with (nolock)
 join empPers with (nolock) on xEEID = eepEEID
 join empcomp with (nolock) on xEEID = eecEEid and xCOID = eecCOID
 
   join (select  heeid eeid, hcoid coid, hdedcode dedcode, heeamt eeamt, heramt eramt ,pdhpaydate paydate
       from dbo.U_dsi_EPFPAYRSN2_DedHist) dh on dh.eeid = xEEID and dh.coid = xCOID 
   left  JOIN dbo.U_dsi_bdm_EmpDeductions ON EedFormatCode = @FormatCode
   AND EedValidForExport = 'Y' AND EedCOID = xCOID AND EedEEID = xEEID and dh.dedcode = eeddedcode

--select * from dbo.U_dsi_EPFPAYRSN2_drvTbl

-- Create Headers
if object_id('U_dsi_EPFPAYRSN2_hdrTbl') is not null
  drop table dbo.U_dsi_EPFPAYRSN2_hdrTbl

select
 hdrRecordIndicator = 'H',
 hdrFormatType = 'F',
 hdrLayoutType = 'D',
 hdrDateCreated = convert(varchar, GETDATE(),112),
 hdrTimeCreated = replace(convert(varchar, GETDATE(),108),':',''),
 hdrEmployerID = '123346',
 hdrEmployerName = 'Sunkist Growers, Inc',
 hdrMemo = '',
 hdrLayoutVersion = 'v20150601'--,
 --hdrOnlineEnrollment = 'T',
 --hdrOnlineCommuter = 'F',
 --hdrChangeOnly = 'F'

into dbo.U_dsi_EPFPAYRSN2_hdrTbl

-- Create Trailers
if object_id('U_dsi_EPFPAYRSN2_trlTbl') is not null
  drop table dbo.U_dsi_EPFPAYRSN2_trlTbl

select
 trlRecordIndicator = 'T',
 -- include hdr and trl record
 trlRecordCount = RIGHT('0000000000' + convert(varchar, COUNT(*)+2),10), 
 trlTotalContributions = RIGHT('000000000000' + isnull(convert(varchar, sum(drvDepositAmount)),'0.00'),12)

into dbo.U_dsi_EPFPAYRSN2_trlTbl
from dbo.U_dsi_EPFPAYRSN2_drvTbl

-- Set FileName  
if (dbo.dsi_fnVariable('EPFPAYRSN2','UseFileName') = 'N')
  update dbo.U_dsi_Parameters
 set ExportFile =  'EPFPAYRSN2_' + convert(char(8),getdate(),112) + '.txt'
 where FormatCode = 'EPFPAYRSN2'

-- Remember to alter view for correct sorting
/*
 ALTER  View dbo.dsi_vwEPFPAYRSN2_Export as
        select top 2000000 Data from dbo.U_EPFPAYRSN2_File with (nolock)
         order by case when substring(Recordset,1,1) = 'D' then 1 else 2 end,
   initialsort, subsort, substring(Recordset,2,2)

--variable length files 

ALTER  View dbo.dsi_vwEPFPAYRSN2_Export as
        select top 2000000 left(data,(len(data))) as data
        from dbo.U_EPFPAYRSN2_File with (nolock)
         order by substring(Recordset,2,2), initialsort, subsort
         
         
--variable length files but with fixed length detail records ending with spaces (do not truncate them)

ALTER  View dbo.dsi_vwEPFPAYRSN2_Export as  
        select top 2000000 case when left(data,1) not in ('H','T') then left(data,(57)) else left(data,(len(data))) end as data  
  from dbo.U_EPFPAYRSN2_File with (nolock)  
         order by substring(Recordset,2,2), initialsort, subsort
            
*/

/*
select distinct pdhpercontrol 
from pdedhist 
where pdhdedcode in ('DCARE','HCARE','LSFSA','HSAEC','HSAEE','HSAEF','HSAFC') 
order by 1 desc
*/

--Used for testing
--dbo.dsi_sp_TestSwitchbox 'EPFPAYRSN2','EPFPAYRSN2'
--dbo.dsi_sp_TestSwitchbox_v2 'EPFPAYRSN2','TEST'
--dbo.dsi_sp_TestSwitchbox 'EPFPAYRSN2','zap'

END
GO
CREATE  View dbo.dsi_vwEPFPAYRSN2_Export as  
        select top 2000000 case when left(data,1) not in ('H','T') then left(data,(57)) else left(data,(len(data))) end as data  
  from dbo.U_EPFPAYRSN2_File with (nolock)  
         order by substring(Recordset,2,2), initialsort, subsort