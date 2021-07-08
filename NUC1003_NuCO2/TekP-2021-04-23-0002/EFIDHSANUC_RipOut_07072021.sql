SET NOCOUNT ON;
IF OBJECT_ID('U_EFIDHSANUC_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EFIDHSANUC_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EFIDHSANUC_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EFIDHSANUC' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEFIDHSANUC_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEFIDHSANUC_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EFIDHSANUC') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EFIDHSANUC];
GO
IF OBJECT_ID('U_EFIDHSANUC_PEHist') IS NOT NULL DROP TABLE [dbo].[U_EFIDHSANUC_PEHist];
GO
IF OBJECT_ID('U_EFIDHSANUC_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EFIDHSANUC_PEarHist];
GO
IF OBJECT_ID('U_EFIDHSANUC_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EFIDHSANUC_PDedHist];
GO
IF OBJECT_ID('U_EFIDHSANUC_File') IS NOT NULL DROP TABLE [dbo].[U_EFIDHSANUC_File];
GO
IF OBJECT_ID('U_EFIDHSANUC_Employees') IS NOT NULL DROP TABLE [dbo].[U_EFIDHSANUC_Employees];
GO
IF OBJECT_ID('U_EFIDHSANUC_EEList') IS NOT NULL DROP TABLE [dbo].[U_EFIDHSANUC_EEList];
GO
IF OBJECT_ID('U_EFIDHSANUC_drvTbl_19H') IS NOT NULL DROP TABLE [dbo].[U_EFIDHSANUC_drvTbl_19H];
GO
IF OBJECT_ID('U_EFIDHSANUC_DedList') IS NOT NULL DROP TABLE [dbo].[U_EFIDHSANUC_DedList];
GO
IF OBJECT_ID('U_EFIDHSANUC_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EFIDHSANUC_AuditFields];
GO
IF OBJECT_ID('U_EFIDHSANUC_Audit') IS NOT NULL DROP TABLE [dbo].[U_EFIDHSANUC_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EFIDHSANUC') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EFIDHSANUC];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EFIDHSANUC';
DELETE [dbo].[U_dsi_RecordSetDetails] FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode = 'EFIDHSANUC';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EFIDHSANUC';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EFIDHSANUC';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EFIDHSANUC';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EFIDHSANUC';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EFIDHSANUC','Fidelity HSA Payroll Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','80','S','N','EFIDHSANUCZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EFIDHSANUC' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TESTEDT"','1','(''DA''=''F'')','EFIDHSANUCZ0','7','H','01','1',NULL,'TEST FILE IDENTIFIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','2','(''SS''=''F'')','EFIDHSANUCZ0','73','H','01','8',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPLANNUMBER"','1','(''UA''=''F'')','EFIDHSANUCZ0','5','D','65','1',NULL,'PLAN NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBATCHGROUPID"','2','(''UA''=''F'')','EFIDHSANUCZ0','4','D','65','6',NULL,'BATCH GROUP ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''SS''=''F'')','EFIDHSANUCZ0','3','D','65','10',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSOCIALSECURITYNUMBER"','4','(''UA''=''F'')','EFIDHSANUCZ0','11','D','65','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''SS''=''F'')','EFIDHSANUCZ0','1','D','65','24',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"00000"','6','(''DA''=''F'')','EFIDHSANUCZ0','5','D','65','25',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"19"','7','(''DA''=''F'')','EFIDHSANUCZ0','2','D','65','30',NULL,'RECORD IDENTIFIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''SS''=''F'')','EFIDHSANUCZ0','4','D','65','32',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"220"','9','(''DA''=''F'')','EFIDHSANUCZ0','3','D','65','36',NULL,'TRANSACTION CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''SS''=''F'')','EFIDHSANUCZ0','2','D','65','39',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSOURCE"','11','(''UA''=''F'')','EFIDHSANUCZ0','2','D','65','41',NULL,'SOURCE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"01"','12','(''DA''=''F'')','EFIDHSANUCZ0','2','D','65','43',NULL,'ITEM NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','13','(''SS''=''F'')','EFIDHSANUCZ0','1','D','65','45',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMOUNT"','14','(''UA''=''F'')','EFIDHSANUCZ0','13','D','65','46',NULL,'AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','15','(''SS''=''F'')','EFIDHSANUCZ0','4','D','65','59',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTAXYEAR"','16','(''UA''=''F'')','EFIDHSANUCZ0','4','D','65','63',NULL,'FISCAL YEAR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','17','(''SS''=''F'')','EFIDHSANUCZ0','1','D','65','67',NULL,'ADJUSTMENT REASON',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCHECKDATE"','18','(''UD112''=''F'')','EFIDHSANUCZ0','8','D','65','68',NULL,'ORIGINAL PAY DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','19','(''SS''=''F'')','EFIDHSANUCZ0','5','D','65','76',NULL,'RESERVED',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EFIDHSANUC_20210707.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Fidelity HSA Part Exp - OD','202002019','EMPEXPORT','ONDEMAND','Jan  7 2021 12:50PM','EFIDHSANUC',NULL,NULL,NULL,'202002019','Feb  1 2020 12:00AM','Dec 30 1899 12:00AM','201701011','510','','','201701011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Fidelity 401K Part Exp - SCH','202003241','EMPEXPORT','SCH_FIDNUC','Jun  5 2020  4:44PM','EFIDHSANUC',NULL,NULL,NULL,'202003241','Mar 24 2020 12:00AM','Dec 30 1899 12:00AM','201701011','455','','','201701011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','GQ166,IAGFG',NULL,NULL,NULL,'Fidelity 401K Part Exp - TEST','202107099','EMPEXPORT','TEST','Jul  7 2021  5:13PM','EFIDHSANUC',NULL,NULL,NULL,'202107099','Jul  9 2021 12:00AM','Dec 30 1899 12:00AM','202107091','1','eecPayGroup','ALLBW,DEF,MGMT','202107091',dbo.fn_GetTimedKey(),NULL,'us3lKiNUC1003',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFIDHSANUC','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFIDHSANUC','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFIDHSANUC','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFIDHSANUC','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFIDHSANUC','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFIDHSANUC','Upper','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFIDHSANUC','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EFIDHSANUC' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EFIDHSANUC' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EFIDHSANUC_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EFIDHSANUC_SavePath];
GO
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EFIDHSANUC','ONDEMAND','H','01','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EFIDHSANUC','','D','50','Y','C');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDHSANUC','D65','dbo.U_EFIDHSANUC_drvTbl_19H',NULL);
IF OBJECT_ID('U_dsi_BDM_EFIDHSANUC') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EFIDHSANUC] (
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
IF OBJECT_ID('U_EFIDHSANUC_Audit') IS NULL
CREATE TABLE [dbo].[U_EFIDHSANUC_Audit] (
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
IF OBJECT_ID('U_EFIDHSANUC_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EFIDHSANUC_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_EFIDHSANUC_DedList') IS NULL
CREATE TABLE [dbo].[U_EFIDHSANUC_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedLongDesc] varchar(40) NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EFIDHSANUC_drvTbl_19H') IS NULL
CREATE TABLE [dbo].[U_EFIDHSANUC_drvTbl_19H] (
    [drvPLANNUMBER] varchar(5) NOT NULL,
    [drvBATCHGROUPID] varchar(1) NOT NULL,
    [drvSOCIALSECURITYNUMBER] varchar(13) NULL,
    [drvSOURCE] varchar(2) NULL,
    [drvAMOUNT] varchar(12) NULL,
    [drvTAXYEAR] int NULL,
    [drvCHECKDATE] datetime NULL,
    [drvEEID] char(12) NOT NULL,
    [drvInitialSort] varchar(11) NULL,
    [drvSubSort] varchar(3) NOT NULL
);
IF OBJECT_ID('U_EFIDHSANUC_EEList') IS NULL
CREATE TABLE [dbo].[U_EFIDHSANUC_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EFIDHSANUC_Employees') IS NULL
CREATE TABLE [dbo].[U_EFIDHSANUC_Employees] (
    [xEEID] char(12) NULL,
    [xCOID] char(5) NULL,
    [EepSSN] char(11) NULL,
    [EepNameFirst] varchar(100) NULL,
    [EepNameMiddle] varchar(50) NULL,
    [EepNameLast] varchar(100) NULL,
    [EepNameSuffix] varchar(30) NULL,
    [EepGender] char(1) NULL,
    [EepDateOfBirth] datetime NULL,
    [EepMaritalStatus] char(1) NULL,
    [EepAddressLine1] varchar(255) NULL,
    [EepAddressLine2] varchar(255) NULL,
    [EepAddressLine3] varchar(255) NULL,
    [EepAddressCity] varchar(255) NULL,
    [EepAddressState] varchar(255) NULL,
    [EepAddressZipCode] varchar(50) NULL,
    [EepAddressCountry] char(3) NULL,
    [EecEmpNo] char(9) NULL,
    [EecEmplStatus] char(1) NULL,
    [EecDateOfOriginalHire] datetime NULL,
    [EecDateOfLastHire] datetime NULL,
    [EecDateOfTermination] datetime NULL,
    [EecDateOfRetirement] datetime NULL,
    [EecLocation] char(6) NULL,
    [EecFullTimeOrPartTime] char(1) NULL,
    [EecPayPeriod] char(1) NULL,
    [EecUnionLocal] char(12) NULL,
    [EecOrgLvl1] varchar(10) NULL,
    [EecOrgLvl2] varchar(10) NULL,
    [OrgLvl2Desc] varchar(25) NULL,
    [Record01Change] varchar(1) NULL,
    [Record02DChange] varchar(1) NULL,
    [Record02EChange] varchar(1) NULL,
    [Record03Change] varchar(1) NULL,
    [Record04Change] varchar(1) NULL,
    [Record05Change] varchar(1) NULL,
    [Record06Change] varchar(1) NULL,
    [Record11Change] varchar(1) NULL,
    [Record36Change] varchar(1) NULL,
    [Record60Change] varchar(1) NULL,
    [Record61Change] varchar(1) NULL,
    [audNewHire] varchar(1) NULL,
    [audReHire] varchar(1) NULL,
    [audTerm] varchar(1) NULL,
    [audSalaryChange] varchar(1) NULL,
    [EecDateOfSeniority] datetime NULL,
    [EecAnnSalary] money NULL,
    [EecTermReason] char(6) NULL,
    [EecEmplStatusStartDate] datetime NULL,
    [emailAddress] varchar(1) NULL,
    [eepAddressEMail] varchar(50) NULL,
    [EecLeaveReason] char(6) NULL
);
IF OBJECT_ID('U_EFIDHSANUC_File') IS NULL
CREATE TABLE [dbo].[U_EFIDHSANUC_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(80) NULL
);
IF OBJECT_ID('U_EFIDHSANUC_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EFIDHSANUC_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhCOID] char(5) NOT NULL,
    [PdhSource] varchar(6) NULL,
    [PdhEECurAmt] money NULL,
    [PdhERCurAmt] money NULL,
    [PlanNo] varchar(5) NOT NULL
);
IF OBJECT_ID('U_EFIDHSANUC_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EFIDHSANUC_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PrgPeriodStartDate] datetime NULL,
    [PrgPeriodEndDate] datetime NULL,
    [PehCurAmt] numeric NULL,
    [PehCurHrs] decimal NULL,
    [PehCurAmtYTD] money NULL,
    [PehCurHrsYTD] decimal NULL,
    [PehInclInDefComp] money NULL,
    [PehInclInDefCompHrs] decimal NULL,
    [PehInclInDefCompYTD] money NULL,
    [PehInclInDefCompHrsYTD] decimal NULL
);
IF OBJECT_ID('U_EFIDHSANUC_PEHist') IS NULL
CREATE TABLE [dbo].[U_EFIDHSANUC_PEHist] (
    [PehEEID] char(12) NOT NULL,
    [PehCOID] char(5) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PehCurAmt] numeric NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EFIDHSANUC]
    @SystemID char(12)
AS
/**********************************************************************************
Client Name: NuCO2 Supply

Created By: Andy Pineda
Business Analyst: Lea King
Create Date: 06/01/2021
Service Request Number: TekP-2021-04-23-0002

Purpose: Fidelity HSA Payroll Export

Revision History
----------------
07/07/2021 by AP:
		- Removed DELETE statement for employees as this file does not use audit.
		- Fixed PEarHist percontrol date range.

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EFIDHSANUC';

SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EFIDHSANUC';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EFIDHSANUC';
SELECT * FROM dbo.U_dsi_RecordSetDetails WHERE FormatCode = 'EFIDHSANUC'; -- Skip RecordSets by ExportCode
SELECT * FROM dbo.AscExp WHERE expFormatCode = 'EFIDHSANUC';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EFIDHSANUC' ORDER BY RunID DESC;
BEGIN TRAN
UPDATE  dbo.U_dsi_Configuration set cfgValue = null WHERE FormatCode = 'EFIDHSANUC' and cfgname = 'ExportPath';
COMMIT
UPDATE U_dsi_Configuration set cfgvalue = null where  FormatCode = 'EFIDHSANUC' and cfgname = 'ExportPath'
Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFIDHSANUC', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFIDHSANUC', 'TEST';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EFIDHSANUC', @AllObjects = 'Y', @IsWeb = 'Y'
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
    WHERE FormatCode = 'EFIDHSANUC';

    PRINT 'Start Date: ' + CONVERT(VARCHAR(26),@StartDate,100);
    PRINT 'End Date:  ' + CONVERT(VARCHAR(26),@EndDate,100);

    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EFIDHSANUC_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDHSANUC_AuditFields;
    CREATE TABLE dbo.U_EFIDHSANUC_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_EFIDHSANUC_AuditFields VALUES ('EmpComp','EecDateOfLastHire');
    INSERT INTO dbo.U_EFIDHSANUC_AuditFields VALUES ('EmpComp','EecDateOfOriginalHire');
    INSERT INTO dbo.U_EFIDHSANUC_AuditFields VALUES ('EmpComp','EecDateOfRetirement');
    INSERT INTO dbo.U_EFIDHSANUC_AuditFields VALUES ('EmpComp','EecDateOfTermination');
    INSERT INTO dbo.U_EFIDHSANUC_AuditFields VALUES ('EmpComp','EecEmplStatus');
    INSERT INTO dbo.U_EFIDHSANUC_AuditFields VALUES ('EmpComp','EecEmpNo');
    INSERT INTO dbo.U_EFIDHSANUC_AuditFields VALUES ('EmpComp','EecFullTimeOrPartTime');
    INSERT INTO dbo.U_EFIDHSANUC_AuditFields VALUES ('EmpComp','EecLocation');
    INSERT INTO dbo.U_EFIDHSANUC_AuditFields VALUES ('EmpComp','EecOrgLvl1');
    INSERT INTO dbo.U_EFIDHSANUC_AuditFields VALUES ('EmpComp','EecOrgLvl2');
    INSERT INTO dbo.U_EFIDHSANUC_AuditFields VALUES ('EmpComp','EecPayPeriod');
    INSERT INTO dbo.U_EFIDHSANUC_AuditFields VALUES ('EmpComp','EecUnionLocal');
    INSERT INTO dbo.U_EFIDHSANUC_AuditFields VALUES ('EmpPers','EepAddressCity');
    INSERT INTO dbo.U_EFIDHSANUC_AuditFields VALUES ('EmpPers','EepAddressCountry');
    INSERT INTO dbo.U_EFIDHSANUC_AuditFields VALUES ('EmpPers','EepAddressLine1');
    INSERT INTO dbo.U_EFIDHSANUC_AuditFields VALUES ('EmpPers','EepAddressLine2');
    INSERT INTO dbo.U_EFIDHSANUC_AuditFields VALUES ('EmpPers','EepAddressState');
    INSERT INTO dbo.U_EFIDHSANUC_AuditFields VALUES ('EmpPers','EepAddressZipCode');
    INSERT INTO dbo.U_EFIDHSANUC_AuditFields VALUES ('EmpPers','EepDateOfBirth');
    INSERT INTO dbo.U_EFIDHSANUC_AuditFields VALUES ('EmpPers','EepGender');
    INSERT INTO dbo.U_EFIDHSANUC_AuditFields VALUES ('EmpPers','EepMaritalStatus');
    INSERT INTO dbo.U_EFIDHSANUC_AuditFields VALUES ('EmpPers','EepNameFirst');
    INSERT INTO dbo.U_EFIDHSANUC_AuditFields VALUES ('EmpPers','EepNameLast');
    INSERT INTO dbo.U_EFIDHSANUC_AuditFields VALUES ('EmpPers','EepNameMiddle');
    INSERT INTO dbo.U_EFIDHSANUC_AuditFields VALUES ('EmpPers','EepSSN');
    INSERT INTO dbo.U_EFIDHSANUC_AuditFields VALUES ('EmpPers','EepEmailAddress');

    INSERT INTO dbo.U_EFIDHSANUC_AuditFields VALUES ('OrgLevel','OrgDesc');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EFIDHSANUC_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDHSANUC_Audit;
    SELECT DISTINCT
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
    INTO dbo.U_EFIDHSANUC_Audit
    FROM dbo.U_EFIDHSANUC_EEList WITH (NOLOCK)
    JOIN dbo.vw_AuditData WITH (NOLOCK) 
        ON audKey1Value = xEEID
    JOIN dbo.U_EFIDHSANUC_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @EndDate -30 AND @EndDate
    AND audAction <> 'DELETE'
    AND ISNULL(audNewValue,'') <> '';

    --=====================================================================================
    -- Retain Most Recent Audit Record by AudKey1, AudKey2, AudKey3 and Audit Field Name
    --=====================================================================================
    DELETE FROM dbo.U_EFIDHSANUC_Audit WHERE audRowNo > 1;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EFIDHSANUC_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCoID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EFIDHSANUC_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    -- Changes Only
    --DELETE FROM dbo.U_EFIDHSANUC_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EFIDHSANUC_Audit WHERE audEEID = xEEID);
    

    DECLARE @DedList VARCHAR(MAX);
    SET @DedList = 'HSAI, HSAF, HSAER, HSA2E, HSACU';

    IF OBJECT_ID('U_EFIDHSANUC_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDHSANUC_DedList;
    SELECT DedCode = DedDedCode
        ,DedLongDesc
        ,DedType = DedDedType
    INTO dbo.U_EFIDHSANUC_DedList
    FROM dbo.dsi_BDM_fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

        --==========================================
    -- BDM Section
    --==========================================
    -- now set values for benefit module
    DELETE FROM dbo.U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode;

    -- Required parms
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'DedCodes',@DedList);
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'TermSelectionOption', 'AuditDate');

    -- Non-required parms
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'IncludeOEDrops','Y');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'OERemoveTermEmps','N');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'GetChangeReason','Y');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS,DP');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL,DIS,STC');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','');


    
    EXEC dbo.dsi_bdm_sp_PopulateDeductionsTable @FormatCode;
    --==========================================
    -- Build Employee Data and the driver tables
    --==========================================

    ---------------------------
   -- Working Table - PDedHist
    ---------------------------
    IF OBJECT_ID('U_EFIDHSANUC_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDHSANUC_PDedHist;
     SELECT DISTINCT
         PdhEEID
        ,PdhCOID
        ,PdhSource = CASE WHEN PdhDedCode IN ('HSAI', 'HSAF') THEN 'HSAEMP' --HSA EMPLOYEE
                          WHEN PdhDedCode IN ('HSAER', 'HSA2E') THEN 'HSAEML' -- HSA EMPLOYER
                          WHEN PdhDedCode IN ('HSACU') THEN 'HSACAT' -- HSA CATCH UP
                     END
        ,PdhEECurAmt = SUM(PdhEECurAmt)
        ,PdhERCurAmt = SUM(PdhERCurAmt)
        ,PlanNo =  '77254'
    INTO dbo.U_EFIDHSANUC_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    WHERE PdhPerControl BETWEEN @StartPerControl AND @EndPerControl AND 
    PdhDedCode IN ('HSAI', 'HSAF','HSAER','HSA2E', 'HSACU')
    GROUP BY PdhEEID
        ,PdhCOID
        ,CASE WHEN PdhDedCode IN ('HSAI', 'HSAF') THEN 'HSAEMP' --HSA EMPLOYEE
                          WHEN PdhDedCode IN ('HSAER', 'HSA2E') THEN 'HSAEML' -- HSA EMPLOYER
                          WHEN PdhDedCode IN ('HSACU') THEN 'HSACAT' -- HSA CATCH UP
                     END
    HAVING (SUM(PdhEECurAmt) <> 0.00 or SUM(PdhERCurAmt) <> 0.00);

     -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EFIDHSANUC_PEHist','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDHSANUC_PEHist;
    SELECT DISTINCT
         PehEEID
        ,PehCOID
        ,PrgPayDate          = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt           = CAST(SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END) AS NUMERIC(12,2))
    INTO dbo.U_EFIDHSANUC_PEHist
    FROM dbo.U_EFIDHSANUC_EEList WITH (NOLOCK)
    JOIN dbo.PayReg WITH (NOLOCK)
        ON PrgEEID = xEEID
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE PehPerControl BETWEEN @StartPerControl AND @EndPerControl
    GROUP BY PehEEID, PehCOID
    HAVING SUM(PehCurAmt) <> 0.00;

    -------------------------------
    -- Working Table - Employees
    -------------------------------
    --IF OBJECT_ID('U_EFIDHSANUC_Employees','U') IS NOT NULL
    --    DROP TABLE dbo.U_EFIDHSANUC_Employees;
    --SELECT xEEID
    --    ,xCOID
    --    ,EepSSN
    --    ,EepNameFirst
    --    ,EepNameMiddle
    --    ,EepNameLast
    --    ,EepNameSuffix
    --    ,EepGender
    --    ,EepDateOfBirth
    --    ,EepMaritalStatus
    --    ,EepAddressLine1
    --    ,EepAddressLine2
    --    ,EepAddressLine3
    --    ,EepAddressCity
    --    ,EepAddressState
    --    ,EepAddressZipCode
    --    ,EepAddressCountry
    --    ,EecEmpNo
    --    ,EecEmplStatus
    --    ,EecDateOfOriginalHire
    --    ,EecDateOfLastHire
    --    ,EecDateOfTermination
    --    ,EecDateOfRetirement
    --    ,EecLocation
    --    ,EecFullTimeOrPartTime
    --    ,EecPayPeriod
    --    ,EecUnionLocal
    --    ,EecOrgLvl1
    --    ,EecOrgLvl2
    --    ,OrgLvl2Desc = O2.OrgDesc
    --    ,Record01Change
    --    ,Record02DChange
    --    ,Record02EChange
    --    ,Record03Change
    --    ,Record04Change
    --    ,Record05Change
    --    ,Record06Change
    --    ,Record11Change
    --    ,Record36Change
    --    ,Record60Change
    --    ,Record61Change
    --    ,audNewHire
    --    ,audReHire
    --    ,audTerm
    --    ,audSalaryChange
    --    ,EecDateOfSeniority
    --    ,EecAnnSalary
    --    ,EecTermReason 
    --    ,EecEmplStatusStartDate
    --    ,emailAddress
    --    ,eepAddressEMail
    --    ,EecLeaveReason
    --INTO dbo.U_EFIDHSANUC_Employees
    --FROM dbo.U_EFIDHSANUC_EEList
    --JOIN dbo.EmpPers WITH (NOLOCK)
    --    ON EepEEID = xEEID
    --JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
    --    ON EecEEID = xEEID
    --    AND EecCOID = xCOID
    --LEFT JOIN dbo.vw_int_OrgLevel O2 WITH (NOLOCK)
    --    ON O2.OrgCode = EecOrgLvl2
    --    AND O2.OrgLvl = '2'
    --LEFT JOIN (
    --    -- Get Record Set Changes based on Audit Fields
    --    SELECT audEEID
    --        ,Record01Change = MAX(CASE WHEN audFieldName IN ('EepNameFirst','EepNameLast','EepNameMiddle','EepGender','EepNameSuffix', 'EepMaritalStatus') THEN 'Y' ELSE 'N' END)
    --        ,Record02DChange = MAX(CASE WHEN audFieldName IN ('EecDateOfOriginalHire','EepDateOfBirth','EecDateOfTermination') THEN 'Y' ELSE 'N' END)
    --        ,Record02EChange = MAX(CASE WHEN audFieldName IN ('EecEmpNo') THEN 'Y' ELSE 'N' END)
    --        ,Record03Change = MAX(CASE WHEN audFieldName IN ('EepAddressLine1','EepAddressLine2','EepAddressLine3') THEN 'Y' ELSE 'N' END)
    --        ,Record04Change = MAX(CASE WHEN audFieldName IN ('EepAddressCity','EepAddressState','EepAddressZipCode') THEN 'Y' ELSE 'N' END)
    --        ,Record05Change = MAX(CASE WHEN audFieldName IN ('EepAddressCountry') THEN 'Y' ELSE 'N' END)
    --        ,Record06Change = MAX(CASE WHEN audFieldName IN ('OrgDesc') THEN 'Y' ELSE 'N' END)
    --        ,Record11Change = MAX(CASE WHEN audFieldName IN ('EecEmplStatus') THEN 'Y' ELSE 'N' END)
    --        ,Record36Change = MAX(CASE WHEN audFieldName IN ('EecOrglvl2') THEN 'Y' ELSE 'N' END)
    --        ,Record60Change = MAX(CASE WHEN audFieldName IN ('EecFullTimeOrPartTime','EecOrgLvl1','EecOrgLvl2','EecLocation','EecUnionLocal','EecPayPeriod') THEN 'Y' ELSE 'N' END)
    --        ,Record61Change = MAX(CASE WHEN audFieldName IN ('EecDateOfLastHire','EecDateOfRetirement') THEN 'Y' ELSE 'N' END)
    --        ,audNewHire = max(CASE WHEN  audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = '' AND ISNULL(audNewValue,'') = 'A' THEN 'Y' ELSE 'N' END)
    --        ,audReHire = max(CASE WHEN  audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = 'T' AND ISNULL(audNewValue,'') = 'A' THEN 'Y' ELSE 'N' END)
    --        ,audTerm = MAX(CASE WHEN  audFieldName = 'EecEmplStatus' AND ISNULL(audNewValue,'') = 'T' THEN 'Y' ELSE 'N' END)
    --        ,audSalaryChange = max(CASE  WHEN  audFieldName = 'EecAnnSalary' AND ISNULL(audNewValue,'') <> '' THEN 'Y' ELSE 'N' END)
    --        ,emailAddress = max(CASE  WHEN  audFieldName = 'EepEmailAddress' AND ISNULL(audNewValue,'') <> '' THEN 'Y' ELSE 'N' END)

    --    FROM dbo.U_EFIDHSANUC_Audit
    --    GROUP BY audEEID
    --) AuditRecords
    --    ON audEEID = xEEID
    --    WHERE EecEEType NOT IN ('CON', 'TES', 'Z');
    --    Delete from U_EFIDHSANUC_Employees where xeeid not in ( Select xeeid from U_EFIDHSANUC_Employees  where Record60Change = 'Y' or Record61Change = 'Y' or emailAddress = 'Y')

    -- ---------------------------------
    -- -- DETAIL RECORD - U_EFIDHSANUC_drvTbl_19H
    -- ---------------------------------
    IF OBJECT_ID('U_EFIDHSANUC_drvTbl_19H','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDHSANUC_drvTbl_19H;
    SELECT DISTINCT
        drvPLANNUMBER = '91529'
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvSOURCE = CASE WHEN PdhSource IN ('HSAEMP') THEN '01' --HSA EMPLOYEE
                          WHEN PdhSource IN ('HSACAT') THEN '02' --HSA CATCH UP
                          WHEN PdhSource IN ('HSAEML') THEN '03' --HSA EMPLOYER
                     END
        ,drvAMOUNT = CASE WHEN PdhEECurAmt <> 0.00 THEN CONVERT(VARCHAR(12),PdhEECurAmt)
                            END
        ,drvTAXYEAR = YEAR(GETDATE())
        ,drvCHECKDATE = PrgPayDate
        ,drvEEID = PdhEEID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '19H'
    INTO dbo.U_EFIDHSANUC_drvTbl_19H
    FROM dbo.U_EFIDHSANUC_EEList WITH(NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_EFIDHSANUC_PDedHist WITH (NOLOCK)
    ON PdhEEID = xEEID
    AND PdhCOID = xCOID
    JOIN dbo.U_EFIDHSANUC_PEHist WITH(NOLOCK)
        ON PehEEID = xEEID
        AND PehCOID = xCOID
    
        
    Update U_EFIDHSANUC_drvTbl_19H set drvAmount  =  CONCAT(LEFT(REPLACE(drvAmount,'.',''),(LEN( REPLACE(drvAmount,'.','')) -1)),CASE WHEN RIGHT(drvAmount,1) = '1' THEN 'A'
         WHEN RIGHT(drvAmount,1) = '2' THEN 'B'
         WHEN RIGHT(drvAmount,1) = '3' THEN 'C'
         WHEN RIGHT(drvAmount,1) = '4' THEN 'D'
         WHEN RIGHT(drvAmount,1) = '5' THEN 'E'
         WHEN RIGHT(drvAmount,1) = '6' THEN 'F'
         WHEN RIGHT(drvAmount,1) = '7' THEN 'G'
         WHEN RIGHT(drvAmount,1) = '8' THEN 'H'
         WHEN RIGHT(drvAmount,1) = '9' THEN 'I'
         WHEN RIGHT(drvAmount,1) = '0' THEN '{'

    END) 
    
     ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable('EFIDHSANUC','UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable('EFIDHSANUC','Testing') = 'Y' THEN 'TEST_NUCOZ_EFIDHSANUC_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'NUCOZ_EFIDHSANUC_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = 'EFIDHSANUC';
    END;

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEFIDHSANUC_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EFIDHSANUC_File (NOLOCK)
    ORDER BY CASE WHEN LEFT(RecordSet,1) = 'D' THEN 10 ELSE RIGHT(RecordSet,2) END, InitialSort, SubSort;
GO

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EFIDHSANUC%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET ExpLastStartPerControl = '201702011'
       ,ExpStartPerControl     = '201702011'
       ,ExpLastEndPerControl   = '201702019'
       ,ExpEndPerControl       = '201702019'
WHERE ExpFormatCode = 'EFIDHSANUC';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEFIDHSANUC_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EFIDHSANUC_File (NOLOCK)
    ORDER BY CASE WHEN LEFT(RecordSet,1) = 'D' THEN 10 ELSE RIGHT(RecordSet,2) END, InitialSort, SubSort;