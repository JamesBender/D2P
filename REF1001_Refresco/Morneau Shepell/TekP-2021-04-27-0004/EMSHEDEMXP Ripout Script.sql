SET NOCOUNT ON;
IF OBJECT_ID('U_EMSHEDEMXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EMSHEDEMXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EMSHEDEMXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EMSHEDEMXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEMSHEDEMXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEMSHEDEMXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EMSHEDEMXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMSHEDEMXP];
GO
IF OBJECT_ID('U_EMSHEDEMXP_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EMSHEDEMXP_Trailer];
GO
IF OBJECT_ID('U_EMSHEDEMXP_File') IS NOT NULL DROP TABLE [dbo].[U_EMSHEDEMXP_File];
GO
IF OBJECT_ID('U_EMSHEDEMXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EMSHEDEMXP_EEList];
GO
IF OBJECT_ID('U_EMSHEDEMXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EMSHEDEMXP_drvTbl];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EMSHEDEMXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EMSHEDEMXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EMSHEDEMXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EMSHEDEMXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EMSHEDEMXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EMSHEDEMXP','Morneau Shepell Demograpic Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','EMSHEDEMXPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EMSHEDEMXP' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EmployeeNo"','1','(''DA''=''T|'')','EMSHEDEMXPZ0','50','H','01','1',NULL,'EmployeeNo',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SocialNo"','2','(''DA''=''T|'')','EMSHEDEMXPZ0','50','H','01','2',NULL,'SocialNo',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FirstName"','3','(''DA''=''T|'')','EMSHEDEMXPZ0','50','H','01','3',NULL,'FirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LastName"','4','(''DA''=''T|'')','EMSHEDEMXPZ0','50','H','01','4',NULL,'LastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Gender*"','5','(''DA''=''T|'')','EMSHEDEMXPZ0','50','H','01','5',NULL,'Gender*',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BirthDate"','6','(''DA''=''T|'')','EMSHEDEMXPZ0','50','H','01','6',NULL,'BirthDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Language"','7','(''DA''=''T|'')','EMSHEDEMXPZ0','50','H','01','7',NULL,'Language',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PhoneNumber"','8','(''DA''=''T|'')','EMSHEDEMXPZ0','50','H','01','8',NULL,'PhoneNumber',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AltNumber"','9','(''DA''=''T|'')','EMSHEDEMXPZ0','50','H','01','9',NULL,'AltNumber',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WorkPhone Number"','10','(''DA''=''T|'')','EMSHEDEMXPZ0','50','H','01','10',NULL,'WorkPhone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EmployeeEmail"','11','(''DA''=''T|'')','EMSHEDEMXPZ0','50','H','01','11',NULL,'EmployeeEmail',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WorkEmail"','12','(''DA''=''T|'')','EMSHEDEMXPZ0','50','H','01','12',NULL,'WorkEmail',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WorkplaceLocation"','13','(''DA''=''T|'')','EMSHEDEMXPZ0','50','H','01','13',NULL,'WorkplaceLocation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WorkplaceLocationAddress1"','14','(''DA''=''T|'')','EMSHEDEMXPZ0','50','H','01','14',NULL,'WorkplaceLocationAddress1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WorkplaceLocationAddress2"','15','(''DA''=''T|'')','EMSHEDEMXPZ0','50','H','01','15',NULL,'WorkplaceLocationAddress2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WorkplaceLocationCity"','16','(''DA''=''T|'')','EMSHEDEMXPZ0','50','H','01','16',NULL,'WorkplaceLocationCity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WorkplaceLocationProvince"','17','(''DA''=''T|'')','EMSHEDEMXPZ0','50','H','01','17',NULL,'WorkplaceLocationProvince',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WorkplaceLocationPostal"','18','(''DA''=''T|'')','EMSHEDEMXPZ0','50','H','01','18',NULL,'WorkplaceLocationPostal',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WorkplaceLocationCountry"','19','(''DA''=''T|'')','EMSHEDEMXPZ0','50','H','01','19',NULL,'WorkplaceLocationCountry',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EmployeeAddress1"','20','(''DA''=''T|'')','EMSHEDEMXPZ0','50','H','01','20',NULL,'EmployeeAddress1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EmployeeAddress2"','21','(''DA''=''T|'')','EMSHEDEMXPZ0','50','H','01','21',NULL,'EmployeeAddress2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EmployeeCity"','22','(''DA''=''T|'')','EMSHEDEMXPZ0','50','H','01','22',NULL,'EmployeeCity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EmployeeProvince"','23','(''DA''=''T|'')','EMSHEDEMXPZ0','50','H','01','23',NULL,'EmployeeProvince',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EmployeePostal"','24','(''DA''=''T|'')','EMSHEDEMXPZ0','50','H','01','24',NULL,'EmployeePostal',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EmployeeCountry"','25','(''DA''=''T|'')','EMSHEDEMXPZ0','50','H','01','25',NULL,'EmployeeCountry',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DateofHire"','26','(''DA''=''T|'')','EMSHEDEMXPZ0','50','H','01','26',NULL,'DateofHire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EmployeeType"','27','(''DA''=''T|'')','EMSHEDEMXPZ0','50','H','01','27',NULL,'EmployeeType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EmpWageCode"','28','(''DA''=''T|'')','EMSHEDEMXPZ0','50','H','01','28',NULL,'EmpWageCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EmpWage"','29','(''DA''=''T|'')','EMSHEDEMXPZ0','50','H','01','29',NULL,'EmpWage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EmployeeUnion"','30','(''DA''=''T|'')','EMSHEDEMXPZ0','50','H','01','30',NULL,'EmployeeUnion',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"JobTitleDesc"','31','(''DA''=''T|'')','EMSHEDEMXPZ0','50','H','01','31',NULL,'JobTitleDesc',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ARNotifyEmail"','32','(''DA''=''T|'')','EMSHEDEMXPZ0','50','H','01','32',NULL,'ARNotifyEmail',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WCNotifyEmail"','33','(''DA''=''T|'')','EMSHEDEMXPZ0','50','H','01','33',NULL,'WCNotifyEmail',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WCPayrollEmail"','34','(''DA''=''T|'')','EMSHEDEMXPZ0','50','H','01','34',NULL,'WCPayrollEmail',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DMNotifyEmail"','35','(''DA''=''T|'')','EMSHEDEMXPZ0','50','H','01','35',NULL,'DMNotifyEmail',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ManagerEmployee ID"','36','(''DA''=''T|'')','EMSHEDEMXPZ0','50','H','01','36',NULL,'ManagerEmployee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ManagerFirstName"','37','(''DA''=''T|'')','EMSHEDEMXPZ0','50','H','01','37',NULL,'ManagerFirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ManagerLastName"','38','(''DA''=''T|'')','EMSHEDEMXPZ0','50','H','01','38',NULL,'ManagerLastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ManagerPhone"','39','(''DA''=''T|'')','EMSHEDEMXPZ0','50','H','01','39',NULL,'ManagerPhone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ManagerEmail"','40','(''DA''=''T'')','EMSHEDEMXPZ0','50','H','01','40',NULL,'ManagerEmail',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeNo"','1','(''UA''=''T|'')','EMSHEDEMXPZ0','50','D','10','1',NULL,'EmployeeNo',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','2','(''DA''=''T|'')','EMSHEDEMXPZ0','50','D','10','2',NULL,'SocialNo',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','3','(''UA''=''T|'')','EMSHEDEMXPZ0','50','D','10','3',NULL,'FirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','4','(''UA''=''T|'')','EMSHEDEMXPZ0','50','D','10','4',NULL,'LastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','5','(''UA''=''T|'')','EMSHEDEMXPZ0','50','D','10','5',NULL,'Gender*',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','6','(''UD112''=''T|'')','EMSHEDEMXPZ0','50','D','10','6',NULL,'BirthDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLanguage"','7','(''UA''=''T|'')','EMSHEDEMXPZ0','50','D','10','7',NULL,'Language',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneNumber"','8','(''UA''=''T|'')','EMSHEDEMXPZ0','50','D','10','8',NULL,'PhoneNumber',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAltNumber"','9','(''UA''=''T|'')','EMSHEDEMXPZ0','50','D','10','9',NULL,'AltNumber',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkPhoneNumber"','10','(''UA''=''T|'')','EMSHEDEMXPZ0','50','D','10','10',NULL,'WorkPhone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeEmail1"','11','(''UA''=''T|'')','EMSHEDEMXPZ0','50','D','10','11',NULL,'EmployeeEmail',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeEmail2"','12','(''UA''=''T|'')','EMSHEDEMXPZ0','50','D','10','12',NULL,'EmployeeEmail',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkplaceLocation"','13','(''UA''=''T|'')','EMSHEDEMXPZ0','50','D','10','13',NULL,'WorkplaceLocation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkAddressLine1"','14','(''UA''=''T|'')','EMSHEDEMXPZ0','50','D','10','14',NULL,'WorkplaceLocationAddress1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkAddressLine2"','15','(''UA''=''T|'')','EMSHEDEMXPZ0','50','D','10','15',NULL,'WorkplaceLocationAddress2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkAddressCit"','16','(''UA''=''T|'')','EMSHEDEMXPZ0','50','D','10','16',NULL,'WorkplaceLocationCity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkAddressProvince"','17','(''UA''=''T|'')','EMSHEDEMXPZ0','50','D','10','17',NULL,'WorkplaceLocationProvince',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkAddressPostal"','18','(''UA''=''T|'')','EMSHEDEMXPZ0','50','D','10','18',NULL,'WorkplaceLocationPostal',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkAddressCountry"','19','(''UA''=''T|'')','EMSHEDEMXPZ0','50','D','10','19',NULL,'WorkplaceLocationCountry',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','20','(''UA''=''T|'')','EMSHEDEMXPZ0','50','D','10','20',NULL,'EmployeeAddress1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','21','(''UA''=''T|'')','EMSHEDEMXPZ0','50','D','10','21',NULL,'EmployeeAddress2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','22','(''UA''=''T|'')','EMSHEDEMXPZ0','50','D','10','22',NULL,'EmployeeCity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressProvince"','23','(''UA''=''T|'')','EMSHEDEMXPZ0','50','D','10','23',NULL,'EmployeeProvince',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','24','(''UA''=''T|'')','EMSHEDEMXPZ0','50','D','10','24',NULL,'EmployeePostal',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCountry"','25','(''UA''=''T|'')','EMSHEDEMXPZ0','50','D','10','25',NULL,'EmployeeCountry',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfHire"','26','(''UD112''=''T|'')','EMSHEDEMXPZ0','50','D','10','26',NULL,'DateofHire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeType"','27','(''UA''=''T|'')','EMSHEDEMXPZ0','50','D','10','27',NULL,'EmployeeType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','28','(''DA''=''T|'')','EMSHEDEMXPZ0','50','D','10','28',NULL,'EmpWageCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','29','(''DA''=''T|'')','EMSHEDEMXPZ0','50','D','10','29',NULL,'EmpWage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeUnion"','30','(''UA''=''T|'')','EMSHEDEMXPZ0','50','D','10','30',NULL,'EmployeeUnion',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobTitleDesc"','31','(''UA''=''T|'')','EMSHEDEMXPZ0','50','D','10','31',NULL,'JobTitleDesc',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvARNotifyEmail"','32','(''UA''=''T|'')','EMSHEDEMXPZ0','50','D','10','32',NULL,'ARNotifyEmail',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','33','(''DA''=''T|'')','EMSHEDEMXPZ0','50','D','10','33',NULL,'WCNotifyEmail',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','34','(''DA''=''T|'')','EMSHEDEMXPZ0','50','D','10','34',NULL,'WCPayrollEmail',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDMNotifyEmail"','35','(''UA''=''T|'')','EMSHEDEMXPZ0','50','D','10','35',NULL,'DMNotifyEmail',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMangerEmployeID"','36','(''UA''=''T|'')','EMSHEDEMXPZ0','50','D','10','36',NULL,'ManagerEmployee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvManagerFirstName"','37','(''UA''=''T|'')','EMSHEDEMXPZ0','50','D','10','37',NULL,'ManagerFirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvManagerLastName"','38','(''UA''=''T|'')','EMSHEDEMXPZ0','50','D','10','38',NULL,'ManagerLastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvManagerPhone"','39','(''UA''=''T|'')','EMSHEDEMXPZ0','50','D','10','39',NULL,'ManagerPhone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvManagerEmail"','40','(''UA''=''T'')','EMSHEDEMXPZ0','50','D','10','40',NULL,'ManagerEmail',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TRL"','1','(''DA''=''T|'')','EMSHEDEMXPZ0','50','T','90','1',NULL,'TrailerTag',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRunDateOfFile"','2','(''UD112''=''T|'')','EMSHEDEMXPZ0','50','T','90','2',NULL,'Run Date of the file',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordCountTotal"','3','(''UA''=''T'')','EMSHEDEMXPZ0','50','T','90','3',NULL,'RecordCountTotal',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EMSHEDEMXP_20210715.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Morneau Shepell Demo Export','202011229','EMPEXPORT','ONDEM_XOE','Dec  3 2020 12:00AM','EMSHEDEMXP',NULL,NULL,NULL,'202011229','Nov 22 2020 12:00AM','Dec 30 1899 12:00AM','202011221',NULL,'','','202011221',dbo.fn_GetTimedKey(),NULL,'LKING16',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'Null','N',',CMCOX',NULL,NULL,NULL,'Morneau Shepell Demo-Wed 11pm','202011229','EMPEXPORT','SCH_EMSHED','Dec  3 2020 12:00AM','EMSHEDEMXP',NULL,NULL,NULL,'202107149','Nov 22 2020 12:00AM','Dec 30 1899 12:00AM','202107071',NULL,'','','202011221',dbo.fn_GetTimedKey(),NULL,'LKING16',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','CMCOX',NULL,NULL,NULL,'Morneau Shepell Demo Exp-Test','202106049','EMPEXPORT','TEST_XOE','Jun  4 2021  2:18PM','EMSHEDEMXP',NULL,NULL,NULL,'202106049','Jun  4 2021 12:00AM','Dec 30 1899 12:00AM','202105211','465','','','202105211',dbo.fn_GetTimedKey(),NULL,'LKING16',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMSHEDEMXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMSHEDEMXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMSHEDEMXP','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMSHEDEMXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMSHEDEMXP','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EMSHEDEMXP' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EMSHEDEMXP' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EMSHEDEMXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EMSHEDEMXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMSHEDEMXP','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMSHEDEMXP','D10','dbo.U_EMSHEDEMXP_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMSHEDEMXP','T90','dbo.U_EMSHEDEMXP_Trailer',NULL);
IF OBJECT_ID('U_EMSHEDEMXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EMSHEDEMXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(11) NOT NULL,
    [drvEmployeeNo] char(9) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvGender] char(1) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvLanguage] char(2) NOT NULL,
    [drvPhoneNumber] varchar(50) NULL,
    [drvAltNumber] varchar(50) NULL,
    [drvWorkPhoneNumber] varchar(50) NULL,
    [drvEmployeeEmail1] varchar(50) NULL,
    [drvEmployeeEmail2] varchar(50) NULL,
    [drvWorkplaceLocation] varchar(25) NULL,
    [drvWorkAddressLine1] varchar(255) NULL,
    [drvWorkAddressLine2] varchar(255) NULL,
    [drvWorkAddressCit] varchar(255) NULL,
    [drvWorkAddressProvince] varchar(255) NULL,
    [drvWorkAddressPostal] varchar(50) NULL,
    [drvWorkAddressCountry] varchar(3) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressProvince] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvAddressCountry] varchar(3) NULL,
    [drvDateOfHire] datetime NULL,
    [drvEmployeeType] varchar(9) NULL,
    [drvEmployeeUnion] varchar(3) NOT NULL,
    [drvJobTitleDesc] varchar(25) NOT NULL,
    [drvARNotifyEmail] varchar(41) NULL,
    [drvDMNotifyEmail] varchar(50) NULL,
    [drvMangerEmployeID] char(9) NULL,
    [drvManagerFirstName] varchar(100) NULL,
    [drvManagerLastName] varchar(100) NULL,
    [drvManagerPhone] varchar(50) NULL,
    [drvManagerEmail] varchar(50) NULL
);
IF OBJECT_ID('U_EMSHEDEMXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EMSHEDEMXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EMSHEDEMXP_File') IS NULL
CREATE TABLE [dbo].[U_EMSHEDEMXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
IF OBJECT_ID('U_EMSHEDEMXP_Trailer') IS NULL
CREATE TABLE [dbo].[U_EMSHEDEMXP_Trailer] (
    [drvRunDateOfFile] datetime NOT NULL,
    [drvRecordCountTotal] int NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMSHEDEMXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Refresco

Created By: James Bender
Business Analyst: Lea King/Richard Vars
Create Date: 11/22/2020
Service Request Number: TekP-2020-11-02-0001

Purpose: Morneau Shepell Demograpic Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EMSHEDEMXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EMSHEDEMXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EMSHEDEMXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EMSHEDEMXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EMSHEDEMXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMSHEDEMXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMSHEDEMXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMSHEDEMXP', 'SCH_EMSHED';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EMSHEDEMXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EMSHEDEMXP';

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
    DELETE FROM dbo.U_EMSHEDEMXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EMSHEDEMXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    DELETE FROM dbo.U_EMSHEDEMXP_EEList WHERE xEEID IN (
        SELECT DISTINCT EecEEID FROM dbo.EmpComp WITH (NOLOCK) WHERE EecEmplStatus NOT IN ('A','L','O','S')
    )

    DELETE FROM dbo.U_EMSHEDEMXP_EEList WHERE xEEID IN (
        SELECT DISTINCT EecEEID FROM dbo.EmpComp WITH (NOLOCK) WHERE EecEEType NOT IN ('EXE','HS','REG','SEA')
    )

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EMSHEDEMXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EMSHEDEMXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EMSHEDEMXP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ISNULL(EMPC.EecLocation, '') + ' :: ' + ISNULL(EMPC.EecSalaryOrHourly, '')
        -- standard fields above and additional driver fields below
        ,drvEmployeeNo = EMPC.EecEmpNo
        ,drvNameFirst = EMPP.EepNameFirst
        ,drvNameLast = EMPP.EepNameLast
        ,drvGender = EMPP.EepGender
        ,drvDateOfBirth = EMPP.EepDateOfBirth
        ,drvLanguage = EMPC.EecLanguageCode
        ,drvPhoneNumber = EMPP.EepPhoneHomeNumber
        ,drvAltNumber = EfoPhoneNumber
        ,drvWorkPhoneNumber = EMPC.EecPhoneBusinessNumber
        ,drvEmployeeEmail1 = EMPP.EepAddressEMailAlternate
        ,drvEmployeeEmail2 = EMPP.EepAddressEMail
        ,drvWorkplaceLocation = LocDesc
        ,drvWorkAddressLine1 = LocAddressLine1
        ,drvWorkAddressLine2 = LocAddressLine2
        ,drvWorkAddressCit = LocAddressCity
        ,drvWorkAddressProvince = LocAddressState
        ,drvWorkAddressPostal = LocAddressZipCode
        ,drvWorkAddressCountry = CASE WHEN LocAddressCountry = 'CAN' THEN 'CA' ELSE LocAddressCountry END
        ,drvAddressLine1 = EMPP.EepAddressLine1
        ,drvAddressLine2 = EMPP.EepAddressLine2
        ,drvAddressCity = EMPP.EepAddressCity
        ,drvAddressProvince = EMPP.EepAddressState
        ,drvAddressZipCode = EMPP.EepAddressZipCode
        ,drvAddressCountry = CASE WHEN EMPP.EepAddressCountry = 'CAN' THEN 'CA' ELSE EMPP.EepAddressCountry END
        ,drvDateOfHire = EMPC.EecDateOfOriginalHire
        ,drvEmployeeType =    CASE WHEN EMPC.EecEEType = 'CON' THEN 'Contract'
                                WHEN EMPC.EecEEType = 'TMP' AND EMPC.EecFullTimeOrPartTime = 'F' THEN 'Full Time'
                                WHEN EMPC.EecEEType = 'TMP' AND EMPC.EecFullTimeOrPartTime = 'P' THEN 'Part Time'
                                WHEN EMPC.EecEEType = 'REG' AND EMPC.EecSalaryOrHourly = 'S' THEN 'Salary'
                                WHEN EMPC.EecEEType = 'REG' AND EMPC.EecSalaryOrHourly = 'H' THEN 'Unionized'
                                ELSE EMPC.EecEEType
                            END
        ,drvEmployeeUnion =   -- CASE WHEN EMPC.EecSalaryOrHourly = 'H' THEN 
                                CASE WHEN EMPC.EecLocation = 'PTC' AND EMPC.EecSalaryOrHourly = 'H' THEN '144'
                                    WHEN EMPC.EecLocation = 'SUR' AND EMPC.EecSalaryOrHourly = 'H' THEN '178'
                                    WHEN EMPC.EecLocation = 'CAL' AND EMPC.EecSalaryOrHourly = 'H' THEN '14'
                                    WHEN EMPC.EecLocation = 'VIS' AND EMPC.EecSalaryOrHourly = 'H' THEN 
                                        CASE WHEN EMPC.EecSalaryOrHourly = 'H' THEN '307' ELSE '93' END
                                    ELSE '93'
                                END
                            --END
        ,drvJobTitleDesc = JbcDesc
        ,drvARNotifyEmail =    CASE WHEN EMPC.EecLocation = 'SUR' AND EMPC.EecSalaryOrHourly = 'H' THEN 'CAN-PhoneDL-SurreySickLine@refresco.com'
                                WHEN EMPC.EecLocation = 'PTC' AND EMPC.EecSalaryOrHourly = 'H' THEN 'CAN-PhoneDL-PtClaireSickLine@refresco.com'
                                WHEN EMPC.EecLocation = 'CAL' AND EMPC.EecSalaryOrHourly = 'H' THEN 'CAN-PhoneDL-CalgarySickLine@refresco.com'
                                WHEN EMPC.EecLocation = 'VIS' AND EMPC.EecSalaryOrHourly = 'H' THEN 'CAN-PhoneDL-ViscountSickLine@refresco.com'
                                WHEN EMPC.EecSalaryOrHourly = 'S' THEN 'HRAbsenceReporting.CAN@refresco.com'
                            END
        ,drvDMNotifyEmail = (SELECT TOP 1 EepAddressEmail FROM dbo.EmpPers WITH (NOLOCK)  JOIN dbo.vw_int_EmpComp WITH (NOLOCK) ON EecEEID = EepEEID WHERE Coddesc= EecempNo AND EepAddressEmail IS NOT NULL)
        ,drvMangerEmployeID = SUPC.EecEmpNo
        ,drvManagerFirstName = SUPP.EepNameFirst
        ,drvManagerLastName = SUPP.EepNameLast
        ,drvManagerPhone = SUPC.EecPhoneBusinessNumber
        ,drvManagerEmail = SUPP.EepAddressEMail
    INTO dbo.U_EMSHEDEMXP_drvTbl
    FROM dbo.U_EMSHEDEMXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp EMPC WITH (NOLOCK)
        ON EMPC.EecEEID = xEEID 
        AND EMPC.EecCoID = xCoID
    JOIN dbo.EmpPers EMPP WITH (NOLOCK)
        ON EMPP.EepEEID = xEEID
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    LEFT JOIN (
                SELECT EfoEEID, EfoPhoneNumber
                FROM (
                        SELECT EfoEEID, EfoPhoneNumber, ROW_NUMBER() OVER (PARTITION BY EfoEEID ORDER BY AuditKey DESC) AS RN
                        FROM dbo.EmpMPhon WITH (NOLOCK)
                        WHERE EfoPhoneType = 'CEL'
                        ) AS CP
                WHERE RN = 1
            ) AS Cel
        ON EfoEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EMPC.EecJobCode
    JOIN dbo.vw_int_EmpComp SUPC WITH (NOLOCK)
        ON SUPC.EecEEID = EMPC.EecSupervisorId
        --AND SUPC.EecCOID = xCOID
    JOIN dbo.EmpPers SUPP WITH (NOLOCK)
        ON SUPP.EepEEID = EMPC.EecSupervisorId
    JOIN dbo.Codes WITH (NOLOCK)
        ON EMPC.EecLocation = CodCode
        AND codtable = 'CO_HRMANAGERBYLOCATI'
    WHERE LocAddressCountry = 'CAN'
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EMSHEDEMXP_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_EMSHEDEMXP_Trailer;
    SELECT DISTINCT
         drvRunDateOfFile = GETDATE()
         ,drvRecordCountTotal = (SELECT COUNT(*) FROM dbo.U_EMSHEDEMXP_drvTbl)
    INTO dbo.U_EMSHEDEMXP_Trailer
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
ALTER VIEW dbo.dsi_vwEMSHEDEMXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EMSHEDEMXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EMSHEDEMXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202011151'
       ,expStartPerControl     = '202011151'
       ,expLastEndPerControl   = '202011229'
       ,expEndPerControl       = '202011229'
WHERE expFormatCode = 'EMSHEDEMXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEMSHEDEMXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EMSHEDEMXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort