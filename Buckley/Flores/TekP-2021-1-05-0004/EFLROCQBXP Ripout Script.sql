SET NOCOUNT ON;
IF OBJECT_ID('U_EFLROCQBXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EFLROCQBXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EFLROCQBXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EFLROCQBXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEFLROCQBXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEFLROCQBXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EFLROCQBXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EFLROCQBXP];
GO
IF OBJECT_ID('U_EFLROCQBXP_File') IS NOT NULL DROP TABLE [dbo].[U_EFLROCQBXP_File];
GO
IF OBJECT_ID('U_EFLROCQBXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EFLROCQBXP_EEList];
GO
IF OBJECT_ID('U_EFLROCQBXP_drvTbl_Insured') IS NOT NULL DROP TABLE [dbo].[U_EFLROCQBXP_drvTbl_Insured];
GO
IF OBJECT_ID('U_EFLROCQBXP_drvTbl_Election') IS NOT NULL DROP TABLE [dbo].[U_EFLROCQBXP_drvTbl_Election];
GO
IF OBJECT_ID('U_EFLROCQBXP_drvTbl_Dependent') IS NOT NULL DROP TABLE [dbo].[U_EFLROCQBXP_drvTbl_Dependent];
GO
IF OBJECT_ID('U_EFLROCQBXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EFLROCQBXP_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EFLROCQBXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EFLROCQBXP];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EFLROCQBXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EFLROCQBXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EFLROCQBXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EFLROCQBXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EFLROCQBXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EFLROCQBXP','Flores Cobra QB Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','EFLROCQBXPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EFLROCQBXP' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"1"','1','(''DA''=''T|'')','EFLROCQBXPZ0','50','D','10','1',NULL,'Insured Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeIdNumber"','2','(''UA''=''T|'')','EFLROCQBXPZ0','50','D','10','2',NULL,'Employee ID Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','3','(''UA''=''T|'')','EFLROCQBXPZ0','50','D','10','3',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','4','(''UA''=''T|'')','EFLROCQBXPZ0','50','D','10','4',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','5','(''UA''=''T|'')','EFLROCQBXPZ0','50','D','10','5',NULL,'Street Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','6','(''UA''=''T|'')','EFLROCQBXPZ0','50','D','10','6',NULL,'Street Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','7','(''UA''=''T|'')','EFLROCQBXPZ0','50','D','10','7',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','8','(''UA''=''T|'')','EFLROCQBXPZ0','50','D','10','8',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','9','(''UA''=''T|'')','EFLROCQBXPZ0','50','D','10','9',NULL,'Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneNumber"','10','(''UA''=''T|'')','EFLROCQBXPZ0','50','D','10','10',NULL,'Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmailAddress"','11','(''UA''=''T|'')','EFLROCQBXPZ0','50','D','10','11',NULL,'Email address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','12','(''UD101''=''T|'')','EFLROCQBXPZ0','50','D','10','12',NULL,'Birth date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','13','(''DA''=''T|'')','EFLROCQBXPZ0','50','D','10','13',NULL,'State of employment',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTypeOfEvent"','14','(''UA''=''T|'')','EFLROCQBXPZ0','50','D','10','14',NULL,'Type of Event',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfEvent"','15','(''UD101''=''T|'')','EFLROCQBXPZ0','50','D','10','15',NULL,'Date of Event',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','16','(''DA''=''T|'')','EFLROCQBXPZ0','50','D','10','16',NULL,'Date Premiums Paid Through',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','17','(''DA''=''T|'')','EFLROCQBXPZ0','50','D','10','17',NULL,'Location',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','18','(''UA''=''T'')','EFLROCQBXPZ0','50','D','10','18',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"2"','1','(''DA''=''T|'')','EFLROCQBXPZ0','50','D','20','1',NULL,'Insured Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeIdNumber"','2','(''UA''=''T|'')','EFLROCQBXPZ0','50','D','20','2',NULL,'Employee ID Number of the Insured',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDependentNumber"','3','(''UA''=''T|'')','EFLROCQBXPZ0','50','D','20','3',NULL,'Dependent Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepNameFirst"','4','(''UA''=''T|'')','EFLROCQBXPZ0','50','D','20','4',NULL,'Dependent First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepNameLast"','5','(''UA''=''T|'')','EFLROCQBXPZ0','50','D','20','5',NULL,'Dependent Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelationToInsured"','6','(''UA''=''T|'')','EFLROCQBXPZ0','50','D','20','6',NULL,'Relation to Insured',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','7','(''UD101''=''T|'')','EFLROCQBXPZ0','50','D','20','7',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','8','(''UA''=''T'')','EFLROCQBXPZ0','50','D','20','8',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"3"','1','(''UA''=''T|'')','EFLROCQBXPZ0','50','D','30','1',NULL,'Insured Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeIdNumber"','2','(''UA''=''T|'')','EFLROCQBXPZ0','50','D','30','2',NULL,'Employee ID Number of the Insured',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDependentNumber"','3','(''UA''=''T|'')','EFLROCQBXPZ0','50','D','30','3',NULL,'Dependent Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCodeEnrolledIn"','4','(''UA''=''T|'')','EFLROCQBXPZ0','50','D','30','4',NULL,'Plan Code Enrolled In',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''DA''=''T'')','EFLROCQBXPZ0','50','D','30','5',NULL,'Monthly Premium',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EFLROCQBXP_20210315.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202103319','EMPEXPORT','OEACTIVE',NULL,'EFLROCQBXP',NULL,NULL,NULL,'202103319','Feb 16 2021  5:13PM','Feb 16 2021  5:13PM','201901011',NULL,'','','201901011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202103319','EMPEXPORT','OEPASSIVE',NULL,'EFLROCQBXP',NULL,NULL,NULL,'202103319','Feb 16 2021  5:13PM','Feb 16 2021  5:13PM','201901011',NULL,'','','201901011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Flores Cobra QB Export','202103319','EMPEXPORT','ONDEM_XOE',NULL,'EFLROCQBXP',NULL,NULL,NULL,'202103319','Feb 16 2021  5:13PM','Feb 16 2021  5:13PM','201901011',NULL,'','','201901011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Flores Cobra QB Export-Sched','202103319','EMPEXPORT','SCH_EFLROC',NULL,'EFLROCQBXP',NULL,NULL,NULL,'202103319','Feb 16 2021  5:13PM','Feb 16 2021  5:13PM','201901011',NULL,'','','201901011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Flores Cobra QB Export-Test','202103319','EMPEXPORT','TEST_XOE','Feb 24 2021  6:21PM','EFLROCQBXP',NULL,NULL,NULL,'202103319','Oct 31 2020 12:00AM','Dec 30 1899 12:00AM','201901011','3','','','201901011',dbo.fn_GetTimedKey(),NULL,'us3lKiBUC1006',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFLROCQBXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFLROCQBXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFLROCQBXP','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFLROCQBXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFLROCQBXP','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EFLROCQBXP' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EFLROCQBXP' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EFLROCQBXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EFLROCQBXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFLROCQBXP','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFLROCQBXP','D10','dbo.U_EFLROCQBXP_drvTbl_Insured',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFLROCQBXP','D20','dbo.U_EFLROCQBXP_drvTbl_Dependent',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFLROCQBXP','D30','dbo.U_EFLROCQBXP_drvTbl_Election',NULL);
IF OBJECT_ID('U_dsi_BDM_EFLROCQBXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EFLROCQBXP] (
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
IF OBJECT_ID('U_EFLROCQBXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EFLROCQBXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EFLROCQBXP_drvTbl_Dependent') IS NULL
CREATE TABLE [dbo].[U_EFLROCQBXP_drvTbl_Dependent] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(45) NULL,
    [drvEmployeeIdNumber] char(11) NULL,
    [drvDependentNumber] bigint NULL,
    [drvDepNameFirst] varchar(100) NULL,
    [drvDepNameLast] varchar(100) NULL,
    [drvRelationToInsured] varchar(1) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvGender] char(1) NULL
);
IF OBJECT_ID('U_EFLROCQBXP_drvTbl_Election') IS NULL
CREATE TABLE [dbo].[U_EFLROCQBXP_drvTbl_Election] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(45) NULL,
    [drvEmployeeIdNumber] char(11) NULL,
    [drvDependentNumber] bigint NOT NULL,
    [drvPlanCodeEnrolledIn] varchar(4) NULL
);
IF OBJECT_ID('U_EFLROCQBXP_drvTbl_Insured') IS NULL
CREATE TABLE [dbo].[U_EFLROCQBXP_drvTbl_Insured] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(14) NULL,
    [drvEmployeeIdNumber] char(11) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvPhoneNumber] varchar(50) NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvTypeOfEvent] varchar(2) NULL,
    [drvDateOfEvent] datetime NULL,
    [drvGender] char(1) NULL
);
IF OBJECT_ID('U_EFLROCQBXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EFLROCQBXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EFLROCQBXP_File') IS NULL
CREATE TABLE [dbo].[U_EFLROCQBXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EFLROCQBXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Buckley LLP

Created By: James Bender
Business Analyst: Lea King
Create Date: 02/16/2021
Service Request Number: TekP-2021-1-05-0004

Purpose: Flores Cobra QB Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EFLROCQBXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EFLROCQBXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EFLROCQBXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EFLROCQBXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EFLROCQBXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFLROCQBXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFLROCQBXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFLROCQBXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFLROCQBXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFLROCQBXP', 'SCH_EFLROC';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EFLROCQBXP';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EFLROCQBXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EFLROCQBXP';

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
    DELETE FROM dbo.U_EFLROCQBXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EFLROCQBXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'DED1,DED2';

    IF OBJECT_ID('U_EFLROCQBXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EFLROCQBXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EFLROCQBXP_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','MED,DEN,VIS');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

    -- COBRA parameters
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RunID','QB');
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'AddToPreviousRun','N');  -- only used for NPM/QB combined files
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','Y'); -- DedIsCobraCovered = 'Y'
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraType','4'); -- Eep/ConCobraReason first, then EdhChangeReason. Include CHGRP for elig. ben groups – 
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraDate','3'); -- EedBenStopDate and DbnBenStopDate, unless Eep/ConDateOfCOBRAEvent exists – 
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraPQBType','1'); -- If no EE or spouse, ALL children are PQB (not just oldest) – include this line if deps are sent as QB and not the employee.  If the EE is sent as the QB even for non-EE events indicate this up above in question #8.
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraReasonsDepPQB','201,204,210,LEVNT3,LEVNT4'); -- Add valid dependent edhchangereasons
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidCobraReasonsEmp','201,204,210,LEVNT3,LEVNT4'); -- Invalidate employee when Cobra Reason is a dependent PQB reason – Add valid dependent edhchangereasons (should be same as previous line above)


    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidTermReasonsEmp','203'); -- Invalidate employee when Cobra Reason is "Death".  Add the Death employment term reason (eectermreason)
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'ConCobraReasonPCF','DependentCOBRAReason'); -- Valid dependent PQB reasons – used when clients have Platform Configurable fields.  Add any other field names the client is using.
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CountDependents','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS'); -- update to the spouse relationship code
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL,DPC,STC'); -- update to the child relationship codes
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP'); -- update to the domestic partner relationship code

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



    -- Insert into BDM Reason code 201 and 204
    --==========================================
    INSERT INTO [dbo].[U_dsi_BDM_EFLROCQBXP]
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
           ,[BdmBenStartDate]
           ,[BdmBenStopDate]
           ,[BdmBenStatusDate]
           ,[BdmChangeReason]
           ,[BdmStartDate]
           ,[BdmStopDate]
           ,[BdmIsPQB] 
    )
    SELECT RecType = 'DEP'
            ,EdhCoid
            ,EdhEEID
            ,DbnDepRecID
            ,DbnDepRecID
            ,'QB'
            ,'Data Inserted for 204 Chg reason'
            ,DbnRelationship
            ,DbnDateOfBirth
            ,EdhDedCode
            ,EdhBenStartDate
            ,EdhDateTimeCreated
            ,EdhBenStatusDate
            ,'204'
            ,EdhStartDate
            ,EdhStopDate
            ,CASE WHEN dbnRelationShip = 'SPS' THEN 'Y' ELSE 'N' END
    FROM dbo.EmpHDed WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_DepDeductions 
        ON DbnEEID = EdhEEID 
        AND DbnFormatCode = @FormatCode
    WHERE EdhChangeReason in ('204') 
        --AND EdhBenstatusDate BETWEEN @StartDate AND @EndDate 
        AND EdhBenStartDate BETWEEN @StartDate AND @EndDate 
        AND DbnValidForExport = 'N'

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EFLROCQBXP_drvTbl_Insured
    ---------------------------------
    IF OBJECT_ID('U_EFLROCQBXP_drvTbl_Insured','U') IS NOT NULL
        DROP TABLE dbo.U_EFLROCQBXP_drvTbl_Insured;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = xEEID + ' 1'
        -- standard fields above and additional driver fields below
        ,drvEmployeeIdNumber = EepSSN
        ,drvNameLast = EepNameLast
        ,drvNameFirst = EepNameFirst
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvPhoneNumber = EepPhoneHOmeNumber
        ,drvEmailAddress = EepAddressEMail
        ,drvDateOfBirth = EepDateOfBirth
        ,drvTypeOfEvent =    CASE WHEN BdmCobraReason IN ('204','LEVNT4') THEN '4'
                                WHEN EecEmplStatus = 'T' AND EecTermReason = '203' THEN '3'
                                WHEN BdmCobraReason IN ('205') THEN '6'
                                WHEN BdmCobraReason IN ('201','LEVNT3') THEN '5'
                                WHEN EecEmplStatus = 'T' AND EecTermType = 'V' THEN '1'
                                WHEN BdmCobraReason IN ('203','202','206') THEN '2'
                                WHEN EecEmplStatus = 'T' AND EecTErmReason <> '203' AND EecTermType = 'I' THEN '10'
                            END
        ,drvDateOfEvent = (SELECT MAX(DOE.BdmBenStopDate) FROM dbo.U_dsi_BDM_EFLROCQBXP DOE WITH (NOLOCK) WHERE DOE.BdmEEID = BDM.BdmEEID AND DOE.BdmCOID = BDM.BdmCOID AND DOE.BdmIsPQB = 'Y')
        --BdmBenStopDate -- CASE WHEN BdmCobraReason IN ('204','LEVNT4','201','LEVNT3') THEN 
        ,drvGender = EepGender
    INTO dbo.U_EFLROCQBXP_drvTbl_Insured
    FROM dbo.U_EFLROCQBXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EFLROCQBXP BDM WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmIsPQB = 'Y'
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EFLROCQBXP_drvTbl_Dependent
    ---------------------------------
    IF OBJECT_ID('U_EFLROCQBXP_drvTbl_Dependent','U') IS NOT NULL
        DROP TABLE dbo.U_EFLROCQBXP_drvTbl_Dependent;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = xEEID + ' 2 ' + CAST(RN AS VARCHAR)
        -- standard fields above and additional driver fields below
        ,drvEmployeeIdNumber = EepSSN
        ,drvDependentNumber = RN
        ,drvDepNameFirst = ConNameFirst
        ,drvDepNameLast = ConNameLast
        ,drvRelationToInsured =    CASE WHEN BdmRelationship IN ('SPS','DP') THEN 'S' 
                                    WHEN BdmRelationship IN ('CHL','DPC','STC') THEN 'C'
                                END
        ,drvDateOfBirth = ConDateOfBirth
        ,drvGender = EepGender
    INTO dbo.U_EFLROCQBXP_drvTbl_Dependent
    FROM dbo.U_EFLROCQBXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    --JOIN dbo.U_dsi_BDM_EFLROCQBXP WITH (NOLOCK)
    JOIN (
            SELECT BdmEEID, BdmCOID, BdmRecType, BdmRelationship, BdmDepRecId,  ROW_NUMBER() OVER (PARTITION BY BdmEEID, BdmCOID ORDER BY CASE WHEN BdmRelationship IN ('SPS','DP') THEN 1 ELSE 2 END, CDOB) AS RN
            FROM (
                    SELECT DISTINCT BdmEEID, BdmCOID, BdmRecType, BdmRelationship, Con.ConDateOfBirth AS CDOB, BdmDepRecId
                    FROM dbo.U_dsi_BDM_EFLROCQBXP WITH (NOLOCK)
                    JOIN dbo.Contacts Con WITH (NOLOCK)
                        ON ConEEID = BdmEEID
                        AND ConSystemID = BdmDepRecID
                    WHERE BdmRecType = 'DEP') AS A) AS Bdm
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        --AND BdmRecType = 'DEP'
    JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EFLROCQBXP_drvTbl_Election
    ---------------------------------
    IF OBJECT_ID('U_EFLROCQBXP_drvTbl_Election','U') IS NOT NULL
        DROP TABLE dbo.U_EFLROCQBXP_drvTbl_Election;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = xEEID + ' 3 ' + CAST(RN AS VARCHAR)
        -- standard fields above and additional driver fields below
        ,drvEmployeeIdNumber = EepSSN
        ,drvDependentNumber = ISNULL(RN, '0')
        ,drvPlanCodeEnrolledIn =    CASE WHEN BdmDedCode IN ('MED1','MEDP') AND BdmBenOption IN ('EE','T1EE','T2EE','T3EE','T4EE','T5EE','T6EE','TPEE') THEN '3010'
                                        WHEN BdmDedCode IN ('MED1','MEDP') AND BdmBenOption IN ('EES','T1ES','T2ES','T3ES','T4ES','T5ES','T6ES') THEN '3011'
                                        WHEN BdmDedCode IN ('MED1','MEDP') AND BdmBenOption IN ('EEC','T1EC','T2EC','T3EC','T4EC','T5EC','T6EC','TPEC') THEN '3012'
                                        WHEN BdmDedCode IN ('MED1','MEDP') AND BdmBenOption IN ('EEF','T1EF','T2EF','T3EF','T4EF','T5EF','T6EF') THEN '3013'
                                        WHEN BdmDedCode IN ('DEN','DENP') AND BdmBenOption IN ('EE','T1EE','T2EE','T3EE','T4EE','T5EE','T6EE','TPEE') THEN '4020'
                                        WHEN BdmDedCode IN ('DEN','DENP') AND BdmBenOption IN ('EES','T1ES','T2ES','T3ES','T4ES','T5ES','T6ES') THEN '4021'
                                        WHEN BdmDedCode IN ('DEN','DENP') AND BdmBenOption IN ('EEC','T1EC','T2EC','T3EC','T4EC','T5EC','T6EC','TPEC') THEN '4022'
                                        WHEN BdmDedCode IN ('DEN','DENP') AND BdmBenOption IN ('EEF','T1EF','T2EF','T3EF','T4EF','T5EF','T6EF') THEN '4023'
                                        WHEN BdmDedCode IN ('VISC','VISCP') AND BdmBenOption IN ('EE','T1EE','T2EE','T3EE','T4EE','T5EE','T6EE','TPEE') THEN '5030'
                                        WHEN BdmDedCode IN ('VISC','VISCP') AND BdmBenOption IN ('EES','T1ES','T2ES','T3ES','T4ES','T5ES','T6ES') THEN '5031'
                                        WHEN BdmDedCode IN ('VISC','VISCP') AND BdmBenOption IN ('EEC','T1EC','T2EC','T3EC','T4EC','T5EC','T6EC','TPEC') THEN '5032'
                                        WHEN BdmDedCode IN ('VISC','VISCP') AND BdmBenOption IN ('EEF','T1EF','T2EF','T3EF','T4EF','T5EF','T6EF') THEN '5033'
                                        WHEN BdmDedCode IN ('VISE','VISEP') AND BdmBenOption IN ('EE','T1EE','T2EE','T3EE','T4EE','T5EE','T6EE','TPEE') THEN '6040'
                                        WHEN BdmDedCode IN ('VISE','VISEP') AND BdmBenOption IN ('EES','T1ES','T2ES','T3ES','T4ES','T5ES','T6ES') THEN '6041'
                                        WHEN BdmDedCode IN ('VISE','VISEP') AND BdmBenOption IN ('EEC','T1EC','T2EC','T3EC','T4EC','T5EC','T6EC','TPEC') THEN '6042'
                                        WHEN BdmDedCode IN ('VISE','VISEP') AND BdmBenOption IN ('EEF','T1EF','T2EF','T3EF','T4EF','T5EF','T6EF') THEN '6043'
                                        WHEN BdmDedCode IN ('FSA','LFSA') THEN '7000'
                                    END                                        
    INTO dbo.U_EFLROCQBXP_drvTbl_Election
    FROM dbo.U_EFLROCQBXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    --JOIN dbo.U_dsi_BDM_EFLROCQBXP WITH (NOLOCK)
    LEFT JOIN (
            SELECT BdmEEID AS RBdmEEID, BdmCOID AS RBdmCOID,  BdmDepRecId AS RBdmDepRecId,  ROW_NUMBER() OVER (PARTITION BY BdmEEID, BdmCOID ORDER BY CASE WHEN BdmRelationship IN ('SPS','DP') THEN 1 ELSE 2 END, CDOB) AS RN
            FROM (
                    SELECT DISTINCT BdmEEID, BdmCOID, BdmRecType, BdmRelationship, Con.ConDateOfBirth AS CDOB, BdmDepRecId
                    FROM dbo.U_dsi_BDM_EFLROCQBXP WITH (NOLOCK)
                    JOIN dbo.Contacts Con WITH (NOLOCK)
                        ON ConEEID = BdmEEID
                        AND ConSystemID = BdmDepRecID
                    WHERE BdmRecType = 'DEP') AS A) AS Bdm
        ON RBdmEEID = xEEID 
        AND RBdmCoID = xCoID
    JOIN dbo.U_dsi_BDM_EFLROCQBXP WITH (NOLOCK)
        ON BdmEEID = xEEID
        AND BdmCOID = xCOID
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
ALTER VIEW dbo.dsi_vwEFLROCQBXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EFLROCQBXP_File (NOLOCK)
    ORDER BY InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EFLROCQBXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201901011'
       ,expStartPerControl     = '201901011'
       ,expLastEndPerControl   = '202103319'
       ,expEndPerControl       = '202103319'
WHERE expFormatCode = 'EFLROCQBXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEFLROCQBXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EFLROCQBXP_File (NOLOCK)
    ORDER BY InitialSort, SubSort;