SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EEMPXMLALT_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EEMPXMLALT' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEEMPXMLALT_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEEMPXMLALT_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EEMPXMLALT') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EEMPXMLALT];
GO
IF OBJECT_ID('U_EEMPXMLALT_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EEMPXMLALT_Trailer];
GO
IF OBJECT_ID('U_EEMPXMLALT_Header') IS NOT NULL DROP TABLE [dbo].[U_EEMPXMLALT_Header];
GO
IF OBJECT_ID('U_EEMPXMLALT_File') IS NOT NULL DROP TABLE [dbo].[U_EEMPXMLALT_File];
GO
IF OBJECT_ID('U_EEMPXMLALT_EEList') IS NOT NULL DROP TABLE [dbo].[U_EEMPXMLALT_EEList];
GO
IF OBJECT_ID('U_EEMPXMLALT_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EEMPXMLALT_drvTbl];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EEMPXMLALT';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EEMPXMLALT';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EEMPXMLALT';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EEMPXMLALT';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EEMPXMLALT';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT',NULL,'EEMPXMLALT','eEmphasys XML Export','N','E','FORM_EMPEXPORT','N','C','BM6LQI0000K0','D','dbo.dsi_sp_Switchbox_v2','8000','S','N','EEMPXMLALTZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHeader01"','1','(''UA''=''T'')','EEMPXMLALTZ0','250','H','01','1',NULL,'xmlVer',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHeader02"','2','(''UA''=''T'')','EEMPXMLALTZ0','250','H','01','2',NULL,'EMPLOYEES',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDetails"','1','(''UA''=''T'')','EEMPXMLALTZ0','250','D','10','1',NULL,'DETAILS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMPLOYEE_ID=drvEmpID"','2','(''WA''=''T'')','EEMPXMLALTZ0','250','D','10','2',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMPLOYEE_NAME=drvEmpName"','3','(''WA''=''T'')','EEMPXMLALTZ0','250','D','10','3',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SEARCH_KEY=drvSearchKey"','4','(''WA''=''T'')','EEMPXMLALTZ0','250','D','10','4',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEPARTMENT=drvDept"','5','(''WA''=''T'')','EEMPXMLALTZ0','250','D','10','5',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"COST_COMP_LAB=drvCostCompLab"','6','(''WA''=''T'')','EEMPXMLALTZ0','250','D','10','6',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HOURLY_RATE=drvHrlyRate"','7','(''WA''=''T'')','EEMPXMLALTZ0','250','D','10','7',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DATE_BIRTH=drvDateBirth"','8','(''WA''=''T'')','EEMPXMLALTZ0','250','D','10','8',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"GENDER=drvGender"','9','(''WA''=''T'')','EEMPXMLALTZ0','250','D','10','9',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CIVIL_STATUS=drvCivilStatus"','10','(''WA''=''T'')','EEMPXMLALTZ0','250','D','10','10',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TELEPHONE_1=drvTelephone1"','11','(''WA''=''T'')','EEMPXMLALTZ0','250','D','10','11',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TELEPHONE_2=drvTelephone2"','12','(''WA''=''T'')','EEMPXMLALTZ0','250','D','10','12',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FAX=drvFax"','13','(''WA''=''T'')','EEMPXMLALTZ0','250','D','10','13',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMAIL=drvEmail"','14','(''WA''=''T'')','EEMPXMLALTZ0','250','D','10','14',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMPLOYMENT_HRS=drvEmpHours"','15','(''WA''=''T'')','EEMPXMLALTZ0','250','D','10','15',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FIRST_DATE_EMPLOYMENT=drv1D"','16','(''WA''=''T'')','EEMPXMLALTZ0','250','D','10','16',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LAST_DATE_EMPLOYMENT=drvLD"','17','(''WA''=''T'')','EEMPXMLALTZ0','250','D','10','17',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LAST_LAYOFF_DATE=drvLastDate"','18','(''WA''=''T'')','EEMPXMLALTZ0','250','D','10','18',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"RE-HIRE_DATE=drvRehireDate"','19','(''WA''=''T'')','EEMPXMLALTZ0','250','D','10','19',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PAY_FREQUENCY=drvPayFreq"','20','(''WA''=''T'')','EEMPXMLALTZ0','250','D','10','20',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AGG-BANK_TIME=drvAggBankTime"','21','(''WA''=''T'')','EEMPXMLALTZ0','250','D','10','21',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PREM_CODE_1=drvPremCode1"','22','(''WA''=''T'')','EEMPXMLALTZ0','250','D','10','22',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PREM_CODE_2=drvPremCode2"','23','(''WA''=''T'')','EEMPXMLALTZ0','250','D','10','23',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PREM_CODE_3=drvPremCode3"','24','(''WA''=''T'')','EEMPXMLALTZ0','250','D','10','24',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PREM_CODE_4=drvPremCode4"','25','(''WA''=''T'')','EEMPXMLALTZ0','250','D','10','25',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PREM_CODE_5=drvPremCode5"','26','(''WA''=''T'')','EEMPXMLALTZ0','250','D','10','26',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SERVICE_CENTER=drvSvcCenter"','27','(''WA''=''T'')','EEMPXMLALTZ0','250','D','10','27',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LABOUR_CODE_COST=drvLCCost"','28','(''WA''=''T'')','EEMPXMLALTZ0','250','D','10','28',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LABOUR_CODE_SELL=drvLCSell"','29','(''WA''=''T'')','EEMPXMLALTZ0','250','D','10','29',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TECH_COST=drvTechCost"','30','(''WA''=''T'')','EEMPXMLALTZ0','250','D','10','30',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDetailsEnd"','31','(''UA''=''T'')','EEMPXMLALTZ0','250','D','10','31',NULL,'DETAILS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTrailer01"','1','(''UA''=''T'')','EEMPXMLALTZ0','250','T','90','1',NULL,'EMPLOYEES',NULL,NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\EW3\EW34\Downloads\V10\Exports\ALTA\EmployeeHistoryExport\ALTA_EEMPXMLALT_20170404.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'eEmphasys XML Export','201704049','EMPEXPORT','ONDEMAND',NULL,'EEMPXMLALT',NULL,NULL,NULL,'201704049','Apr  4 2017 12:39PM','Apr  4 2017 12:39PM','201704041',NULL,'','','201704041','BM6LQI0010K0',NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\EW3\EW34\Downloads\V10\Exports\ALTA\EmployeeHistoryExport\ALTA_EEMPXMLALT_20170404.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Test Purposes Only','201704049','EMPEXPORT','TEST',NULL,'EEMPXMLALT',NULL,NULL,NULL,'201704049','Apr  4 2017 12:39PM','Apr  4 2017 12:39PM','201704041',NULL,'','','201704041','BM6LQI0020K0',NULL,'ULTI',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEMPXMLALT','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEMPXMLALT','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEMPXMLALT','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEMPXMLALT','UseFileName','V','Y');
GO
UPDATE dbo.U_dsi_Configuration SET CfgValue = svCfgValue FROM dbo.U_EEMPXMLALT_SavePath WHERE CfgName = svCfgName AND FormatCode = svFormatCode;
IF OBJECT_ID('U_EEMPXMLALT_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EEMPXMLALT_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EEMPXMLALT','H01','dbo.U_EEMPXMLALT_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EEMPXMLALT','D10','dbo.U_EEMPXMLALT_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EEMPXMLALT','T90','dbo.U_EEMPXMLALT_Trailer',NULL);
IF OBJECT_ID('U_EEMPXMLALT_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EEMPXMLALT_drvTbl] (
    [drvDetails] varchar(9) NOT NULL,
    [drvEmpID] char(9) NULL,
    [drvEmpName] varchar(201) NULL,
    [drvSearchKey] varchar(100) NULL,
    [drvDept] varchar(3) NOT NULL,
    [drvCostCompLab] varchar(1) NOT NULL,
    [drvHrlyRate] varchar(1) NOT NULL,
    [drvDateBirth] varchar(30) NULL,
    [drvGender] varchar(1) NULL,
    [drvCivilStatus] varchar(1) NOT NULL,
    [drvTelephone1] varchar(1) NOT NULL,
    [drvTelephone2] varchar(1) NOT NULL,
    [drvFax] varchar(1) NOT NULL,
    [drvEmail] varchar(50) NULL,
    [drvEmpHours] int NULL,
    [drv1D] varchar(30) NULL,
    [drvLD] varchar(30) NULL,
    [drvLastDate] varchar(1) NOT NULL,
    [drvRehireDate] varchar(30) NULL,
    [drvPayFreq] varchar(1) NULL,
    [drvAggBankTime] varchar(4) NOT NULL,
    [drvPremCode1] varchar(1) NOT NULL,
    [drvPremCode2] varchar(1) NOT NULL,
    [drvPremCode3] varchar(1) NOT NULL,
    [drvPremCode4] varchar(1) NOT NULL,
    [drvPremCode5] varchar(1) NOT NULL,
    [drvSvcCenter] varchar(3) NOT NULL,
    [drvLCCost] varchar(1) NOT NULL,
    [drvLCSell] varchar(1) NOT NULL,
    [drvTechCost] varchar(5) NOT NULL,
    [drvDetailsEnd] varchar(10) NOT NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL
);
IF OBJECT_ID('U_EEMPXMLALT_EEList') IS NULL
CREATE TABLE [dbo].[U_EEMPXMLALT_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EEMPXMLALT_File') IS NULL
CREATE TABLE [dbo].[U_EEMPXMLALT_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(50) NOT NULL,
    [SubSort] varchar(50) NOT NULL,
    [SubSort2] varchar(50) NULL,
    [SubSort3] varchar(50) NULL,
    [Data] varchar(8000) NULL
);
IF OBJECT_ID('U_EEMPXMLALT_Header') IS NULL
CREATE TABLE [dbo].[U_EEMPXMLALT_Header] (
    [drvHeader01] varchar(67) NOT NULL,
    [drvHeader02] varchar(11) NOT NULL
);
IF OBJECT_ID('U_EEMPXMLALT_Trailer') IS NULL
CREATE TABLE [dbo].[U_EEMPXMLALT_Trailer] (
    [drvTrailer01] varchar(12) NOT NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EEMPXMLALT]
    @SystemID char(12)
AS
/**********************************************************************************
Client Name: Alta Equipment Company

Created By: Willie Chong
Business Analyst: Garret Donovan
Create Date: 04/04/2017
Service Request Number: PSA ALT1004-2017-00148432

Purpose: eEmphasys XML Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2017     SR-2017-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EEMPXMLALT';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EEMPXMLALT';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EEMPXMLALT';
SELECT * FROM dbo.AscExp WHERE expFormatCode = 'EEMPXMLALT';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EEMPXMLALT' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEMPXMLALT', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEMPXMLALT', 'TEST';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EEMPXMLALT', @AllObjects = 'Y'
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

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = CAST(LEFT(StartPerControl,8) AS DATETIME)
        ,@EndDate         = DATEADD(SS,-1,DATEADD(DD,1,LEFT(EndPerControl,8)))
        ,@FormatCode      = FormatCode
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = 'EEMPXMLALT';

    PRINT 'Start Date: ' + CONVERT(VARCHAR(26),@StartDate,100);
    PRINT 'End Date:  ' + CONVERT(VARCHAR(26),@EndDate,100);

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EEMPXMLALT_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCoID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EEMPXMLALT_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Build Employee Data and the driver tables
    --==========================================
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EEMPXMLALT_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EEMPXMLALT_Header;
    SELECT DISTINCT
        drvHeader01 = '<?xml version = "1.0" encoding = "ISO-88591-1" standalone = "no" ?>'
        ,drvHeader02 = '<EMPLOYEES>'
    INTO dbo.U_EEMPXMLALT_Header
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EEMPXMLALT_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EEMPXMLALT_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EEMPXMLALT_drvTbl;
    SELECT DISTINCT
        drvDetails = '<DETAILS>'
        ,drvEmpID = EecEmpNo
        ,drvEmpName = Upper(RTRIM(EepNameFirst) + ' ' + RTRIM(EepNameLast))
        ,drvSearchKey = Upper(EepNameLast)
        ,drvDept = 'tbd' --Orglvl2ImportCode + Orglvl1Code?
        ,drvCostCompLab = ''
        ,drvHrlyRate = ''
        ,drvDateBirth = CONVERT(varchar,EepDateOfBirth,112)
        ,drvGender = CASE EepGender WHEN 'M' THEN '1' WHEN 'F' THEN '2' END
        ,drvCivilStatus = CASE EepMaritalStatus WHEN 'S' THEN '1' WHEN 'M' THEN '2' WHEN 'D' THEN '3' ELSE '4' END
        ,drvTelephone1 = ''
        ,drvTelephone2 = ''
        ,drvFax = ''
        ,drvEmail = EepAddressEmail
        ,drvEmpHours = CASE WHEN EecPayPeriod = 'W' THEN cast(EecScheduledWorkHrs as smallint)
                            WHEN EecPayPeriod = 'B' THEN cast(EecScheduledWorkHrs as smallint)/2
                            WHEN EecPayPeriod = 'S' THEN cast(EecScheduledWorkHrs as smallint)/2
                            WHEN EecPayPeriod = 'M' THEN cast(EecScheduledWorkHrs as smallint)/4
                            END
        ,drv1D = CONVERT(varchar,EecDateOfOriginalHire,112)
        ,drvLD = CASE WHEN EecEmplStatus = 'T' THEN CONVERT(varchar,EecDateOfTermination,112) ELSE NULL END
        ,drvLastDate = ''
        ,drvRehireDate = CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN CONVERT(varchar,EecDateOfLastHire,112) ELSE NULL END
        ,drvPayFreq = CASE EecPayPeriod
                            WHEN 'D' THEN '1'
                            WHEN 'W' THEN '2'
                            WHEN 'S' THEN '3'
                            WHEN 'M' THEN '4'
                            WHEN 'B' THEN '5'
                            END
        ,drvAggBankTime = '0.00'
        ,drvPremCode1 = ''
        ,drvPremCode2 = ''
        ,drvPremCode3 = ''
        ,drvPremCode4 = ''
        ,drvPremCode5 = ''
        ,drvSvcCenter = 'tbd' --will be provided
        ,drvLCCost = ''
        ,drvLCSell = ''
        ,drvTechCost = '12.34'
        ,drvDetailsEnd = '</DETAILS>'
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA 
    INTO dbo.U_EEMPXMLALT_drvTbl
    FROM dbo.U_EEMPXMLALT_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EEMPXMLALT_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_EEMPXMLALT_Trailer;
    SELECT DISTINCT
        drvTrailer01 = '</EMPLOYEES>'
    INTO dbo.U_EEMPXMLALT_Trailer
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable('EEMPXMLALT','UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable('EEMPXMLALT','Testing') = 'Y' THEN 'Test_EEMPXMLALT_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'OE_EEMPXMLALT_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'EEMPXMLALT_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = 'EEMPXMLALT';
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEEMPXMLALT_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EEMPXMLALT_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EEMPXMLALT%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET ExpLastStartPerControl = '201703281'
       ,ExpStartPerControl     = '201703281'
       ,ExpLastEndPerControl   = '201704049'
       ,ExpEndPerControl       = '201704049'
WHERE ExpFormatCode = 'EEMPXMLALT';

**********************************************************************************/
GO
Create View dbo.dsi_vwEEMPXMLALT_Export as
                            select top 200000000 Data from dbo.U_EEMPXMLALT_File with (nolock)
                            order by substring(RecordSet,2,2), InitialSort