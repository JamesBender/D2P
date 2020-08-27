SET NOCOUNT ON;
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EXMLCOMEMP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EXMLCOMEMP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEXMLCOMEMP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEXMLCOMEMP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EXMLCOMEMP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EXMLCOMEMP];
GO
IF OBJECT_ID('U_EXMLCOMEMP_File') IS NOT NULL DROP TABLE [dbo].[U_EXMLCOMEMP_File];
GO
IF OBJECT_ID('U_EXMLCOMEMP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EXMLCOMEMP_EEList];
GO
IF OBJECT_ID('U_EXMLCOMEMP_drvTbl_StatusHistory') IS NOT NULL DROP TABLE [dbo].[U_EXMLCOMEMP_drvTbl_StatusHistory];
GO
IF OBJECT_ID('U_EXMLCOMEMP_drvTbl_Position') IS NOT NULL DROP TABLE [dbo].[U_EXMLCOMEMP_drvTbl_Position];
GO
IF OBJECT_ID('U_EXMLCOMEMP_drvTbl_Employee') IS NOT NULL DROP TABLE [dbo].[U_EXMLCOMEMP_drvTbl_Employee];
GO
IF OBJECT_ID('U_EXMLCOMEMP_drvTbl_AttributeSet') IS NOT NULL DROP TABLE [dbo].[U_EXMLCOMEMP_drvTbl_AttributeSet];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EXMLCOMEMP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EXMLCOMEMP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EXMLCOMEMP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EXMLCOMEMP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EXMLCOMEMP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCreateTClockBatches,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhRespectZeroPayRate,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhThirdPartyPay) VALUES ('N','C','Y','0','',NULL,'','N','','N','','013010','EMPEXPORT','CDE','EXMLCOMEMP','Common Employee XML Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','5000','N','S','N','EXMLCOMEMPZ0','N','Jan  1 1900 12:00AM','C','N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"<?xml version="','1','(''DA''=''T'')','EXMLCOMEMPZ0','100','H','01','1',NULL,'Envelope Header',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"1.0"','2','(''DA''=''Q'')','EXMLCOMEMPZ0','100','H','01','2',NULL,'Envelope Header',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" encoding="','3','(''DA''=''T'')','EXMLCOMEMPZ0','100','H','01','3',NULL,'Envelope Header',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"UTF-8"','4','(''DA''=''Q'')','EXMLCOMEMPZ0','100','H','01','4',NULL,'Envelope Header',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"?>"','5','(''DA''=''T'')','EXMLCOMEMPZ0','100','H','01','5',NULL,'Envelope Header',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"<EmployeeImportT xmlns="','1','(''DA''=''T'')','EXMLCOMEMPZ0','100','H','02','1',NULL,'File Header',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"http://epicor.com/EmployeeImport.xsd"','2','(''DA''=''Q>'')','EXMLCOMEMPZ0','100','H','02','2',NULL,'File Header',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"<Employee ActionType="','1','(''DA''=''T'')','EXMLCOMEMPZ0','100','D','10','1',NULL,'Parent Level: Employee (Start Loop)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvActionType"','2','(''UA''=''Q'')','EXMLCOMEMPZ0','100','D','10','2',NULL,'Employee - ActionType (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" EmployeeNumber="','3','(''DA''=''T'')','EXMLCOMEMPZ0','100','D','10','3',NULL,'Employee - EmployeeNumber',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeNumber"','4','(''UA''=''Q'')','EXMLCOMEMPZ0','100','D','10','4',NULL,'Employee - EmployeeNumber (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" EmployeeType="','5','(''DA''=''T'')','EXMLCOMEMPZ0','100','D','10','5',NULL,'Employee - Employee Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeType"','6','(''UA''=''Q>'')','EXMLCOMEMPZ0','100','D','10','6',NULL,'Employee - Employee Type (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FirstName=drvFirstName"','7','(''WA''=''T'')','EXMLCOMEMPZ0','100','D','10','7',NULL,'Employee - FirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LastName=drvLastName"','8','(''WA''=''T'')','EXMLCOMEMPZ0','100','D','10','8',NULL,'Employee - LastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ActiveStatus=drvActiveStatus"','9','(''WA''=''T'')','EXMLCOMEMPZ0','100','D','10','9',NULL,'Employee - ActiveStatus',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"StatusCode=drvStatusCode"','10','(''WA''=''T'')','EXMLCOMEMPZ0','100','D','10','10',NULL,'Employee - StatusCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DateHired=drvDateHired"','11','(''WA''=''T'')','EXMLCOMEMPZ0','100','D','10','11',NULL,'Employee - DateHired',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"UserName=drvUserName"','12','(''WA''=''T'')','EXMLCOMEMPZ0','100','D','10','12',NULL,'Employee - UserName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DomainName=drvDomainName"','13','(''WA''=''T'')','EXMLCOMEMPZ0','100','D','10','13',NULL,'Employee - DomainName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PrimaryPositionCode=drvPrimaryPosCode"','14','(''WA''=''T'')','EXMLCOMEMPZ0','100','D','10','14',NULL,'Employee - PrimaryPositionCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PrimaryLocationNumber=drvLocationNumber"','15','(''WA''=''T'')','EXMLCOMEMPZ0','100','D','10','15',NULL,'Employee - PrimaryLocationNumber',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ISPSecurityLevel=drvISPSecurityLevel"','16','(''WA''=''T'')','EXMLCOMEMPZ0','100','D','10','16',NULL,'Employee - ISPSecurityLevel',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"POSSecurityLevel=drvPOSSecurityLevel"','17','(''WA''=''T'')','EXMLCOMEMPZ0','100','D','10','17',NULL,'Employee - POSSecurityLevel',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Password=drvPassword"','18','(''WA''=''T'')','EXMLCOMEMPZ0','100','D','10','18',NULL,'Employee - Password',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accountability=drvAccountability"','19','(''WA''=''T'')','EXMLCOMEMPZ0','100','D','10','19',NULL,'Employee - Accountability',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"</Employee"','20','(''DA''=''T>'')','EXMLCOMEMPZ0','100','D','10','20',NULL,'Parent Level: Employee (End Loop)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"<StatusHistoryAssignment ActionType="','1','(''DA''=''T'')','EXMLCOMEMPZ0','100','D','20','1',NULL,'Parent Level: StatusHistoryAssignment (Start Loop)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvActionType"','2','(''UA''=''Q'')','EXMLCOMEMPZ0','100','D','20','2',NULL,'StatusHistoryAssignment - ActionType (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" EmployeeNumber="','3','(''DA''=''T'')','EXMLCOMEMPZ0','100','D','20','3',NULL,'StatusHistoryAssignment - EmployeeNumber',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeNumber"','4','(''UA''=''Q>'')','EXMLCOMEMPZ0','100','D','20','4',NULL,'StatusHistoryAssignment - EmployeeNumber (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EmploymentStatusCode=drvEmploymentStatusCode"','5','(''WA''=''T'')','EXMLCOMEMPZ0','100','D','20','5',NULL,'StatusHistoryAssignment - EmploymentStatusCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EffectiveDate=drvEffDate"','6','(''WA''=''T'')','EXMLCOMEMPZ0','100','D','20','6',NULL,'StatusHistoryAssignment - EffectiveDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ExpirationDate=drvExpirationDate"','7','(''WA''=''T'')','EXMLCOMEMPZ0','100','D','20','7',NULL,'StatusHistoryAssignment - ExpirationDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"</StatusHistoryAssignment"','8','(''DA''=''T>'')','EXMLCOMEMPZ0','100','D','20','8',NULL,'Parent Level: StatusHistoryAssignment (End Loop)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"<Position ActionType="','1','(''DA''=''T'')','EXMLCOMEMPZ0','100','D','30','1',NULL,'Parent Level: Position (Start Loop)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvActionType"','2','(''UA''=''Q'')','EXMLCOMEMPZ0','100','D','30','2',NULL,'Position - ActionType (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" EmployeeNumber="','3','(''DA''=''T'')','EXMLCOMEMPZ0','100','D','30','3',NULL,'Position - EmployeeNumber',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeNumber"','4','(''UA''=''Q>'')','EXMLCOMEMPZ0','100','D','30','4',NULL,'Position - EmployeeNumber (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PositionCode=drvPositionCode"','5','(''WA''=''T'')','EXMLCOMEMPZ0','100','D','30','5',NULL,'Position - PositionCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PrimaryPosition=drvPrimaryPosition"','6','(''WA''=''T'')','EXMLCOMEMPZ0','100','D','30','6',NULL,'Position - PrimaryPosition',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LocationNumber=drvLocationNumber"','7','(''WA''=''T'')','EXMLCOMEMPZ0','100','D','30','7',NULL,'Position - LocationNumber',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EffectiveDate=drvEffDate"','8','(''WA''=''T'')','EXMLCOMEMPZ0','100','D','30','8',NULL,'Position - EffectiveDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"</Position"','9','(''DA''=''T>'')','EXMLCOMEMPZ0','100','D','30','9',NULL,'Parent Level: Position (End Loop)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"<AttributeSet ActionType="','1','(''DA''=''T'')','EXMLCOMEMPZ0','100','D','40','1',NULL,'Parent Level: AttributeSet (Start Loop)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvActionType"','2','(''UA''=''Q'')','EXMLCOMEMPZ0','100','D','40','2',NULL,'AttributeSet - ActionType (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" EmployeeNumber="','3','(''DA''=''T'')','EXMLCOMEMPZ0','100','D','40','3',NULL,'AttributeSet - EmployeeNumber',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeNumber"','4','(''UA''=''Q>'')','EXMLCOMEMPZ0','100','D','40','4',NULL,'AttributeSet - EmployeeNumber (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Code=drvCode"','5','(''WA''=''T'')','EXMLCOMEMPZ0','100','D','40','5',NULL,'AttributeSet - Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SetCode=drvSetCode"','6','(''WA''=''T'')','EXMLCOMEMPZ0','100','D','40','6',NULL,'AttributeSet - SetCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"</AttributeSet"','7','(''DA''=''T>'')','EXMLCOMEMPZ0','100','D','40','7',NULL,'Parent Level: AttributeSet (End Loop)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"</EmployeeImportT"','1','(''DA''=''T>'')','EXMLCOMEMPZ0','100','T','90','1',NULL,'File Trailer',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EXMLCOMEMP_YYYYMMDD.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Common Employee XML Export','201707199','EMPEXPORT','ONDEMAND',NULL,'EXMLCOMEMP',NULL,NULL,NULL,'201707199','Jul 19 2017  5:16PM','Jul 19 2017  5:16PM','201707191',NULL,'','','201707191',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EXMLCOMEMP_YYYYMMDD.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Test Purposes Only','201707199','EMPEXPORT','TEST',NULL,'EXMLCOMEMP',NULL,NULL,NULL,'201707199','Jul 19 2017  5:16PM','Jul 19 2017  5:16PM','201707191',NULL,'','','201707191',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EXMLCOMEMP_YYYYMMDD.txt' END WHERE expFormatCode = 'EXMLCOMEMP';
IF LEFT(@UDENV,2) = 'NW' UPDATE dbo.AscExp SET expAscFileName = REPLACE(expAscFileName,'Exports\',SPACE(0)) WHERE expFormatCode = 'EXMLCOMEMP';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EXMLCOMEMP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EXMLCOMEMP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EXMLCOMEMP','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EXMLCOMEMP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EXMLCOMEMP','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EXMLCOMEMP' AND CfgName IN ('UseFileName','ExportPath');
IF OBJECT_ID('U_EXMLCOMEMP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EXMLCOMEMP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EXMLCOMEMP','D10','dbo.U_EXMLCOMEMP_drvTbl_Employee',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EXMLCOMEMP','D20','dbo.U_EXMLCOMEMP_drvTbl_StatusHistory',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EXMLCOMEMP','D30','dbo.U_EXMLCOMEMP_drvTbl_Position',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EXMLCOMEMP','D40','dbo.U_EXMLCOMEMP_drvTbl_AttributeSet',NULL);
IF OBJECT_ID('U_EXMLCOMEMP_drvTbl_AttributeSet') IS NULL
CREATE TABLE [dbo].[U_EXMLCOMEMP_drvTbl_AttributeSet] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(9) NULL,
    [drvActionType] varchar(1) NOT NULL,
    [drvEmployeeNumber] varchar(9) NULL,
    [drvCode] varchar(1) NOT NULL,
    [drvSetCode] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EXMLCOMEMP_drvTbl_Employee') IS NULL
CREATE TABLE [dbo].[U_EXMLCOMEMP_drvTbl_Employee] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(9) NULL,
    [drvActionType] varchar(1) NOT NULL,
    [drvEmployeeNumber] varchar(9) NULL,
    [drvEmployeeType] char(3) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvLastName] varchar(100) NULL,
    [drvActiveStatus] varchar(1) NOT NULL,
    [drvStatusCode] varchar(4) NOT NULL,
    [drvDateHired] varchar(10) NULL,
    [drvUserName] varchar(50) NULL,
    [drvDomainName] varchar(50) NULL,
    [drvPrimaryPosCode] char(8) NULL,
    [drvLocationNumber] char(6) NULL,
    [drvISPSecurityLevel] varchar(1) NOT NULL,
    [drvPOSSecurityLevel] varchar(1) NOT NULL,
    [drvPassword] varchar(8) NULL,
    [drvAccountability] varchar(4) NOT NULL
);
IF OBJECT_ID('U_EXMLCOMEMP_drvTbl_Position') IS NULL
CREATE TABLE [dbo].[U_EXMLCOMEMP_drvTbl_Position] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(9) NULL,
    [drvActionType] varchar(1) NOT NULL,
    [drvEmployeeNumber] varchar(9) NULL,
    [drvPositionCode] char(8) NULL,
    [drvPrimaryPosition] varchar(1) NULL,
    [drvLocationNumber] char(6) NULL,
    [drvEffDate] varchar(10) NULL
);
IF OBJECT_ID('U_EXMLCOMEMP_drvTbl_StatusHistory') IS NULL
CREATE TABLE [dbo].[U_EXMLCOMEMP_drvTbl_StatusHistory] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(9) NULL,
    [drvActionType] varchar(1) NOT NULL,
    [drvEmployeeNumber] varchar(9) NULL,
    [drvEmploymentStatusCode] varchar(1) NOT NULL,
    [drvEffDate] varchar(10) NULL,
    [drvExpirationDate] varchar(10) NULL
);
IF OBJECT_ID('U_EXMLCOMEMP_EEList') IS NULL
CREATE TABLE [dbo].[U_EXMLCOMEMP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EXMLCOMEMP_File') IS NULL
CREATE TABLE [dbo].[U_EXMLCOMEMP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(50) NOT NULL,
    [SubSort] varchar(50) NOT NULL,
    [SubSort2] varchar(50) NULL,
    [SubSort3] varchar(50) NULL,
    [Data] varchar(max) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EXMLCOMEMP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Z. Gallerie, LLC

Created By: Vinny Kelly
Business Analyst: Candace Harris
Create Date: 07/19/2017
Service Request Number: SR-2017-00155433

Purpose: Common Employee XML Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2017     SR-2017-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EXMLCOMEMP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EXMLCOMEMP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EXMLCOMEMP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EXMLCOMEMP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EXMLCOMEMP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EXMLCOMEMP', 'ONDEMAND';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EXMLCOMEMP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EXMLCOMEMP';

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
    DELETE FROM dbo.U_EXMLCOMEMP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EXMLCOMEMP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EXMLCOMEMP_drvTbl_Employee
    ---------------------------------
    IF OBJECT_ID('U_EXMLCOMEMP_drvTbl_Employee','U') IS NOT NULL
        DROP TABLE dbo.U_EXMLCOMEMP_drvTbl_Employee;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EecEmpNo)
        -- standard fields above and additional driver fields below
        ,drvActionType = 'R' --“R”eplace – This will either add a new employee if it does not exist or update an employee if it already exists.
        ,drvEmployeeNumber = RTRIM(EecEmpNo)
        ,drvEmployeeType = EecEEType
        ,drvFirstName = RTRIM(EepNameFirst)
        ,drvLastName = RTRIM(EepNameLast)
        ,drvActiveStatus = CASE WHEN EecEmplStatus = 'T' THEN 'N' --“N” = not active
                                ELSE 'Y' ----“Y” = active
                           END
        ,drvStatusCode = CASE WHEN EecEmplStatus = 'S' THEN 'SUSP' --“SUSP” = suspended
                              WHEN EecEmplStatus = 'T' THEN
                                CASE WHEN EecTermReason = '202' THEN 'RETD' --“RETD” = retired
                                     ELSE 'TERM' --“TERM” = terminated
                                END
                              WHEN EecEmplStatus = 'L' THEN 
                                CASE WHEN EecLeaveReason = '101' THEN 'SICK' --“SICK” = sick leave
                                     WHEN EecLeaveReason = '102' AND EepGender = 'F' THEN 'MATL' --“MATL” = maternity leave
                                     WHEN EecLeaveReason = '102' AND EepGender = 'M' THEN 'PATL' --“PATL” = paternity leave
                                     WHEN EecEEType IN ('CON','INT','STU','SUM','TMP') THEN 'TEMP' --“TEMP” = Temporary, applicable only to POS
                                     ELSE 'HIRE' --“HIRE” = hired (permanent)
                                END
                              ELSE
                                CASE WHEN EecEEType IN ('CON','INT','STU','SUM','TMP') THEN 'TEMP' --“TEMP” = Temporary, applicable only to POS
                                     ELSE 'HIRE' --“HIRE” = hired (permanent)
                                END
                        END
        ,drvDateHired = CONVERT(VARCHAR(10),EecDateOfLastHire,20)
        ,drvUserName = LEFT(eepAddressEMail,CHARINDEX('@',eepAddressEMail) - 1)
        ,drvDomainName = SUBSTRING(eepAddressEMail,CHARINDEX('@',eepAddressEMail),LEN(eepAddressEMail))
        ,drvPrimaryPosCode = EecJobCode
        ,drvLocationNumber = EecLocation
        ,drvISPSecurityLevel = '1'
        ,drvPOSSecurityLevel = '1'
        ,drvPassword = CONVERT(VARCHAR(8),EepDateOfBirth,112)
        ,drvAccountability = 'NONE' -- Valid Values: WKSTN, CASHIER, NONE, EITHER
    INTO dbo.U_EXMLCOMEMP_drvTbl_Employee
    FROM dbo.U_EXMLCOMEMP_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    ;

    ---------------------------------
    -- DETAIL RECORD - U_EXMLCOMEMP_drvTbl_StatusHistory
    ---------------------------------
    IF OBJECT_ID('U_EXMLCOMEMP_drvTbl_StatusHistory','U') IS NOT NULL
        DROP TABLE dbo.U_EXMLCOMEMP_drvTbl_StatusHistory;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EecEmpNo)
        -- standard fields above and additional driver fields below
        ,drvActionType = 'A' --Add: Adds an employee status history record in the CRDM employee status table.
        ,drvEmployeeNumber = RTRIM(EecEmpNo)
        ,drvEmploymentStatusCode = 'A'
        ,drvEffDate = CONVERT(VARCHAR(10),EecEmplStatusStartDate,20)
        ,drvExpirationDate = CONVERT(VARCHAR(10),GETDATE(),20)
    INTO dbo.U_EXMLCOMEMP_drvTbl_StatusHistory
    FROM dbo.U_EXMLCOMEMP_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID;

    ---------------------------------
    -- DETAIL RECORD - U_EXMLCOMEMP_drvTbl_Position
    ---------------------------------
    IF OBJECT_ID('U_EXMLCOMEMP_drvTbl_Position','U') IS NOT NULL
        DROP TABLE dbo.U_EXMLCOMEMP_drvTbl_Position;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EecEmpNo)
        -- standard fields above and additional driver fields below
        ,drvActionType = 'R' -- Replace: This will either assign new position to an employee or modify the employee position data.
        ,drvEmployeeNumber = RTRIM(EecEmpNo)
        ,drvPositionCode = COALESCE(EphJobCode,EecJobCode)
        ,drvPrimaryPosition = COALESCE(EphIsPrimary,'Y')
        ,drvLocationNumber = COALESCE(EphLocation,EecLocation)
        ,drvEffDate = CONVERT(VARCHAR(10),GETDATE(),20)
    INTO dbo.U_EXMLCOMEMP_drvTbl_Position
    FROM dbo.U_EXMLCOMEMP_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    LEFT JOIN dbo.EmpMPos WITH (NOLOCK)
        ON EphEEID = xEEID
        AND EphCOID = xCOID;

    ---------------------------------
    -- DETAIL RECORD - U_EXMLCOMEMP_drvTbl_AttributeSet
    ---------------------------------
    IF OBJECT_ID('U_EXMLCOMEMP_drvTbl_AttributeSet','U') IS NOT NULL
        DROP TABLE dbo.U_EXMLCOMEMP_drvTbl_AttributeSet;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EecEmpNo)
        -- standard fields above and additional driver fields below
        ,drvActionType = 'A' --Add/Delete Only
        ,drvEmployeeNumber = RTRIM(EecEmpNo)
        ,drvCode = '1'
        ,drvSetCode = '1'
    INTO dbo.U_EXMLCOMEMP_drvTbl_AttributeSet
    FROM dbo.U_EXMLCOMEMP_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
        SET ExportFile = 'EXMLCOMEMP_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.xml'
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEXMLCOMEMP_Export AS
    SELECT TOP 20000000 Data
    FROM dbo.U_EXMLCOMEMP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EXMLCOMEMP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201707121'
       ,expStartPerControl     = '201707121'
       ,expLastEndPerControl   = '201707199'
       ,expEndPerControl       = '201707199'
WHERE expFormatCode = 'EXMLCOMEMP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEXMLCOMEMP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EXMLCOMEMP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort