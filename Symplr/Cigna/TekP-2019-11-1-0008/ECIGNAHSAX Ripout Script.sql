SET NOCOUNT ON;
IF OBJECT_ID('U_ECIGNAHSAX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECIGNAHSAX_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ECIGNAHSAX_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ECIGNAHSAX' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwECIGNAHSAX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECIGNAHSAX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECIGNAHSAX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECIGNAHSAX];
GO
IF OBJECT_ID('U_ECIGNAHSAX_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ECIGNAHSAX_PDedHist];
GO
IF OBJECT_ID('U_ECIGNAHSAX_Header') IS NOT NULL DROP TABLE [dbo].[U_ECIGNAHSAX_Header];
GO
IF OBJECT_ID('U_ECIGNAHSAX_File') IS NOT NULL DROP TABLE [dbo].[U_ECIGNAHSAX_File];
GO
IF OBJECT_ID('U_ECIGNAHSAX_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECIGNAHSAX_EEList];
GO
IF OBJECT_ID('U_ECIGNAHSAX_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ECIGNAHSAX_drvTbl];
GO
IF OBJECT_ID('U_ECIGNAHSAX_DedList') IS NOT NULL DROP TABLE [dbo].[U_ECIGNAHSAX_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_ECIGNAHSAX') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ECIGNAHSAX];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ECIGNAHSAX';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ECIGNAHSAX';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ECIGNAHSAX';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ECIGNAHSAX';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ECIGNAHSAX';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ECIGNAHSAX','Cigna HSA Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','ECIGNAHSAXZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"IA"','1','(''DA''=''T,'')','ECIGNAHSAXZ0','50','H','01','1',NULL,'Record ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecortCount"','2','(''UA''=''T,'')','ECIGNAHSAXZ0','50','H','01','2',NULL,'Record Count',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ymZrlS8f"','3','(''DA''=''T,'')','ECIGNAHSAXZ0','50','H','01','3',NULL,'EDI Password',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CignaHSAContributionsImport"','4','(''DA''=''T,'')','ECIGNAHSAXZ0','50','H','01','4',NULL,'Import Template Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CignaHSAContributionsResult"','5','(''DA''=''T,'')','ECIGNAHSAXZ0','50','H','01','5',NULL,'Result Template Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','6','(''DA''=''T'')','ECIGNAHSAXZ0','50','H','01','6',NULL,'Export Template Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"IH"','1','(''DA''=''T,'')','ECIGNAHSAXZ0','50','D','10','1',NULL,'Record ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"T02103"','2','(''DA''=''T,'')','ECIGNAHSAXZ0','50','D','10','2',NULL,'TPA ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CI2000059608"','3','(''DA''=''T,'')','ECIGNAHSAXZ0','50','D','10','3',NULL,'Employer ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','4','(''UA''=''T,'')','ECIGNAHSAXZ0','50','D','10','4',NULL,'Employee SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PNC"','5','(''DA''=''T,'')','ECIGNAHSAXZ0','50','D','10','5',NULL,'Account Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeDepositAmount"','6','(''UA''=''T,'')','ECIGNAHSAXZ0','50','D','10','6',NULL,'Employee Deposit Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerDepositAmount"','7','(''UA''=''T,'')','ECIGNAHSAXZ0','50','D','10','7',NULL,'Employer Deposit Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffectiveDate"','8','(''UD112''=''T,'')','ECIGNAHSAXZ0','50','D','10','8',NULL,'Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDupDespositCheck"','9','(''UA''=''T,'')','ECIGNAHSAXZ0','50','D','10','9',NULL,'Duplicate Deposit Check',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepositType"','10','(''UA''=''T,'')','ECIGNAHSAXZ0','50','D','10','10',NULL,'Deposit Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordTrackingNo"','11','(''UA''=''T'')','ECIGNAHSAXZ0','50','D','10','11',NULL,'Record Tracking Number',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ECIGNAHSAX_20200327.txt',NULL,'','','',NULL,NULL,NULL,'Cigna HSA Export','202003119','EMPEXPORT','ONDEMAND','Mar 12 2020  1:54PM','ECIGNAHSAX',NULL,NULL,NULL,'202003119','Mar 11 2020  1:09PM','Mar 11 2020  1:09PM','202002141','195','','','202002141',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ECIGNAHSAX_20200327.txt',NULL,'','','',NULL,NULL,NULL,'Scheduled Session','202003119','EMPEXPORT','SCHEDULED','Mar 12 2020  1:54PM','ECIGNAHSAX',NULL,NULL,NULL,'202003119','Mar 11 2020  1:09PM','Mar 11 2020  1:09PM','202002141','195','','','202002141',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ECIGNAHSAX_20200327.txt',NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','202003119','EMPEXPORT','OEACTIVE','Mar 12 2020  1:53PM','ECIGNAHSAX',NULL,NULL,NULL,'202003119','Mar 11 2020  1:09PM','Mar 11 2020  1:09PM','202002141','10','','','202002141',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ECIGNAHSAX_20200327.txt',NULL,'','','',NULL,NULL,NULL,'Passive Open Enrollment Export','202003119','EMPEXPORT','OEPASSIVE','Mar 12 2020  1:53PM','ECIGNAHSAX',NULL,NULL,NULL,'202003119','Mar 11 2020  1:09PM','Mar 11 2020  1:09PM','202002141','195','','','202002141',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ECIGNAHSAX_20200327.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202003139','EMPEXPORT','TEST','Mar 20 2020  5:17PM','ECIGNAHSAX',NULL,NULL,NULL,'202003139','Mar 13 2020 12:00AM','Dec 30 1899 12:00AM','202003131','190','','','202003131',dbo.fn_GetTimedKey(),NULL,'us3lKiVEN1002',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_ECIGNAHSAX_20200327.txt' END WHERE expFormatCode = 'ECIGNAHSAX';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIGNAHSAX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIGNAHSAX','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIGNAHSAX','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIGNAHSAX','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIGNAHSAX','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'ECIGNAHSAX' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ECIGNAHSAX' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_ECIGNAHSAX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECIGNAHSAX_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECIGNAHSAX','H01','dbo.U_ECIGNAHSAX_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECIGNAHSAX','D10','dbo.U_ECIGNAHSAX_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_ECIGNAHSAX') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ECIGNAHSAX] (
    [BdmRecType] varchar(3) NOT NULL,
    [BdmCOID] char(5) NULL,
    [BdmEEID] char(12) NOT NULL,
    [BdmDepRecID] char(12) NULL,
    [BdmSystemID] char(12) NULL,
    [BdmRunID] varchar(32) NULL,
    [BdmDedRowStatus] varchar(256) NULL,
    [BdmRelationship] char(3) NULL,
    [BdmDateOfBirth] datetime NULL,
    [BdmDedCode] char(5) NULL,
    [BdmDedType] varchar(32) NULL,
    [BdmBenOption] char(6) NULL,
    [BdmBenStatus] char(1) NULL,
    [BdmBenStartDate] datetime NULL,
    [BdmBenStopDate] datetime NULL,
    [BdmBenStatusDate] datetime NULL,
    [BdmBenOptionDate] datetime NULL,
    [BdmChangeReason] char(6) NULL,
    [BdmStartDate] datetime NULL,
    [BdmStopDate] datetime NULL,
    [BdmIsCobraCovered] char(1) NULL,
    [BdmCobraReason] char(6) NULL,
    [BdmDateOfCOBRAEvent] datetime NULL,
    [BdmIsPQB] char(1) NULL,
    [BdmIsChildOldest] char(1) NULL,
    [BdmUSGField1] varchar(256) NULL,
    [BdmUSGField2] varchar(256) NULL,
    [BdmUSGDate1] datetime NULL,
    [BdmUSGDate2] datetime NULL,
    [BdmTVStartDate] datetime NULL,
    [BdmSessionID] varchar(32) NULL,
    [BdmEEAmt] money NULL,
    [BdmEECalcRateOrPct] decimal NULL,
    [BdmEEGoalAmt] money NULL,
    [BdmEEMemberOrCaseNo] char(40) NULL,
    [BdmERAmt] money NULL,
    [BdmNumSpouses] int NULL,
    [BdmNumChildren] int NULL,
    [BdmNumDomPartners] int NULL,
    [BdmNumDPChildren] int NULL
);
IF OBJECT_ID('U_ECIGNAHSAX_DedList') IS NULL
CREATE TABLE [dbo].[U_ECIGNAHSAX_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ECIGNAHSAX_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ECIGNAHSAX_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(202) NULL,
    [drvSSN] varchar(11) NULL,
    [drvEmployeeDepositAmount] nvarchar(4000) NULL,
    [drvEmployerDepositAmount] varchar(4) NOT NULL,
    [drvEffectiveDate] nvarchar(4000) NULL,
    [drvDupDespositCheck] varchar(1) NOT NULL,
    [drvDepositType] varchar(1) NOT NULL,
    [drvRecordTrackingNo] varchar(11) NULL
);
IF OBJECT_ID('U_ECIGNAHSAX_EEList') IS NULL
CREATE TABLE [dbo].[U_ECIGNAHSAX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ECIGNAHSAX_File') IS NULL
CREATE TABLE [dbo].[U_ECIGNAHSAX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
IF OBJECT_ID('U_ECIGNAHSAX_Header') IS NULL
CREATE TABLE [dbo].[U_ECIGNAHSAX_Header] (
    [drvRecortCount] varchar(30) NULL
);
IF OBJECT_ID('U_ECIGNAHSAX_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ECIGNAHSAX_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhDedAmt] numeric NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECIGNAHSAX]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Symplr

Created By: James Bender
Business Analyst: Lea King
Create Date: 03/11/2020
Service Request Number: TekP-2019-11-1-0008

Purpose: Cigna HSA Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECIGNAHSAX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECIGNAHSAX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECIGNAHSAX';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECIGNAHSAX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECIGNAHSAX' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECIGNAHSAX', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECIGNAHSAX', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECIGNAHSAX', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECIGNAHSAX', 'TEST';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ECIGNAHSAX';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ECIGNAHSAX', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ECIGNAHSAX';

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
    DELETE FROM dbo.U_ECIGNAHSAX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECIGNAHSAX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_ECIGNAHSAX_EEList where xEEID IN (
        select distinct eeceeid from empcomp where eecEEType IN('TES')
    )

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'HSACF,HSACI,HSAF,HSAI';

    IF OBJECT_ID('U_ECIGNAHSAX_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ECIGNAHSAX_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ECIGNAHSAX_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DedList);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

    -- Non-Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');

    -- Required OE parameters
    IF @ExportCode LIKE '%PASSIVE'
    BEGIN
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'OEType','PASSIVE');
    END;

    IF @ExportCode LIKE '%ACTIVE'
    BEGIN
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'OEType','ACTIVE');
    END;


    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_ECIGNAHSAX_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ECIGNAHSAX_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhDedAmt     = SUM(CASE WHEN PdhDedCode IN ('HSAI', 'HSAF', 'HSACI', 'HSACF') THEN PdhEECurAmt ELSE 0.00 END)        
    INTO dbo.U_ECIGNAHSAX_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ECIGNAHSAX_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );


    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ECIGNAHSAX_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ECIGNAHSAX_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECIGNAHSAX_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = EepNameLast + ', ' + EepNameFirst
        -- standard fields above and additional driver fields below
        ,drvSSN = CASE WHEN @ExportCode = 'TEST' THEN '999999999' ELSE RTRIM(eepSSN) END
        ,drvEmployeeDepositAmount = FORMAT(PdhDedAmt, '#0.00')
        ,drvEmployerDepositAmount = '0.00'
        ,drvEffectiveDate = FORMAT(GETDATE(), 'yyyyMMdd') 
        ,drvDupDespositCheck = '1'
        ,drvDepositType = '1'
        ,drvRecordTrackingNo =  CASE WHEN @ExportCode = 'TEST' THEN '999999999' ELSE RTRIM(eepSSN) END
    INTO dbo.U_ECIGNAHSAX_drvTbl
    FROM dbo.U_ECIGNAHSAX_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ECIGNAHSAX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.U_ECIGNAHSAX_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ECIGNAHSAX_Header','U') IS NOT NULL
        DROP TABLE dbo.U_ECIGNAHSAX_Header;
    SELECT DISTINCT
         drvRecortCount = CAST((SELECT COUNT(*)+1 FROM dbo.U_ECIGNAHSAX_drvTbl WITH (NOLOCK)) AS VARCHAR)
    INTO dbo.U_ECIGNAHSAX_Header
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
ALTER VIEW dbo.dsi_vwECIGNAHSAX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECIGNAHSAX_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ECIGNAHSAX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202002141'
       ,expStartPerControl     = '202002141'
       ,expLastEndPerControl   = '202003119'
       ,expEndPerControl       = '202003119'
WHERE expFormatCode = 'ECIGNAHSAX';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwECIGNAHSAX_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ECIGNAHSAX_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort