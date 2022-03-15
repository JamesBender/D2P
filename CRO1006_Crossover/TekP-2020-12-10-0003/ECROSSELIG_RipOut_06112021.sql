SET NOCOUNT ON;
IF OBJECT_ID('U_ECROSSELIG_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECROSSELIG_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ECROSSELIG_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ECROSSELIG' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwECROSSELIG_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECROSSELIG_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECROSSELIG') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECROSSELIG];
GO
IF OBJECT_ID('U_ECROSSELIG_File') IS NOT NULL DROP TABLE [dbo].[U_ECROSSELIG_File];
GO
IF OBJECT_ID('U_ECROSSELIG_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECROSSELIG_EEList];
GO
IF OBJECT_ID('U_ECROSSELIG_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ECROSSELIG_drvTbl];
GO
IF OBJECT_ID('U_ECROSSELIG_DedList') IS NOT NULL DROP TABLE [dbo].[U_ECROSSELIG_DedList];
GO
IF OBJECT_ID('U_ECROSSELIG_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ECROSSELIG_AuditFields];
GO
IF OBJECT_ID('U_ECROSSELIG_Audit') IS NOT NULL DROP TABLE [dbo].[U_ECROSSELIG_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_ECROSSELIG') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ECROSSELIG];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ECROSSELIG';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ECROSSELIG';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ECROSSELIG';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ECROSSELIG';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ECROSSELIG';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ECROSSELIG','Crossover Health Eligibility Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','ECROSSELIGZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ECROSSELIG' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Unique ID"','1','(''DA''=''T,'')','ECROSSELIGZ0','50','H','01','1',NULL,'Unique ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Name"','2','(''DA''=''T,'')','ECROSSELIGZ0','50','H','01','2',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Middle Name"','3','(''DA''=''T,'')','ECROSSELIGZ0','50','H','01','3',NULL,'Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last Name"','4','(''DA''=''T,'')','ECROSSELIGZ0','50','H','01','4',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address Line 1"','5','(''DA''=''T,'')','ECROSSELIGZ0','50','H','01','5',NULL,'Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address Line 2"','6','(''DA''=''T,'')','ECROSSELIGZ0','50','H','01','6',NULL,'Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"City"','7','(''DA''=''T,'')','ECROSSELIGZ0','50','H','01','7',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"State"','8','(''DA''=''T,'')','ECROSSELIGZ0','50','H','01','8',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Zip Code"','9','(''DA''=''T,'')','ECROSSELIGZ0','50','H','01','9',NULL,'Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Country Code"','10','(''DA''=''T,'')','ECROSSELIGZ0','50','H','01','10',NULL,'Country Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home Phone Number"','11','(''DA''=''T,'')','ECROSSELIGZ0','50','H','01','11',NULL,'Home Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Phone Number"','12','(''DA''=''T,'')','ECROSSELIGZ0','50','H','01','12',NULL,'Work Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Email Address"','13','(''DA''=''T,'')','ECROSSELIGZ0','50','H','01','13',NULL,'Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Birth Date"','14','(''DA''=''T,'')','ECROSSELIGZ0','50','H','01','14',NULL,'Birth Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Gender"','15','(''DA''=''T,'')','ECROSSELIGZ0','50','H','01','15',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Medical Group ID"','16','(''DA''=''T,'')','ECROSSELIGZ0','50','H','01','16',NULL,'Medical Group ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Subscriber ID"','17','(''DA''=''T,'')','ECROSSELIGZ0','50','H','01','17',NULL,'Subscriber ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Medical Plan"','18','(''DA''=''T,'')','ECROSSELIGZ0','50','H','01','18',NULL,'Medical Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Relationship Code"','19','(''DA''=''T,'')','ECROSSELIGZ0','50','H','01','19',NULL,'Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employment Status"','20','(''DA''=''T,'')','ECROSSELIGZ0','50','H','01','20',NULL,'Employment Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Vision Group ID"','21','(''DA''=''T,'')','ECROSSELIGZ0','50','H','01','21',NULL,'Vision Group ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Vision Plan #"','22','(''DA''=''T,'')','ECROSSELIGZ0','50','H','01','22',NULL,'Vision Plan #',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Vision Plan Effective Date"','23','(''DA''=''T,'')','ECROSSELIGZ0','50','H','01','23',NULL,'Vision Plan Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Vision Plan Termination Date"','24','(''DA''=''T,'')','ECROSSELIGZ0','50','H','01','24',NULL,'Vision Plan Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Location Code"','25','(''DA''=''T,'')','ECROSSELIGZ0','50','H','01','25',NULL,'Location Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee ID"','26','(''DA''=''T,'')','ECROSSELIGZ0','50','H','01','26',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last Hire Date"','27','(''DA''=''T,'')','ECROSSELIGZ0','50','H','01','27',NULL,'Last Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Medical Plan Effective Date"','28','(''DA''=''T,'')','ECROSSELIGZ0','50','H','01','28',NULL,'Medical Plan Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Medical Plan Termination Date"','29','(''DA''=''T,'')','ECROSSELIGZ0','50','H','01','29',NULL,'Medical Plan Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Term Employment Date"','30','(''DA''=''T,'')','ECROSSELIGZ0','50','H','01','30',NULL,'Term Employment Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SSN"','31','(''DA''=''T,'')','ECROSSELIGZ0','50','H','01','31',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Division #"','32','(''DA''=''T,'')','ECROSSELIGZ0','50','H','01','32',NULL,'Division #',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"GL Site Department Name"','33','(''DA''=''T'')','ECROSSELIGZ0','50','H','01','33',NULL,'GL Site Department Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFileID"','1','(''UA''=''T,'')','ECROSSELIGZ0','50','D','10','1',NULL,'Unique ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','2','(''UA''=''T,'')','ECROSSELIGZ0','50','D','10','2',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','3','(''UA''=''T,'')','ECROSSELIGZ0','50','D','10','3',NULL,'Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','4','(''UA''=''T,'')','ECROSSELIGZ0','50','D','10','4',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','5','(''UA''=''T,'')','ECROSSELIGZ0','50','D','10','5',NULL,'Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','6','(''UA''=''T,'')','ECROSSELIGZ0','50','D','10','6',NULL,'Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','7','(''UA''=''T,'')','ECROSSELIGZ0','50','D','10','7',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','8','(''UA''=''T,'')','ECROSSELIGZ0','50','D','10','8',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','9','(''UA''=''T,'')','ECROSSELIGZ0','50','D','10','9',NULL,'Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCountry"','10','(''UA''=''T,'')','ECROSSELIGZ0','50','D','10','10',NULL,'Country Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneHomeNo"','11','(''UA''=''T,'')','ECROSSELIGZ0','50','D','10','11',NULL,'Home Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','12','(''SS''=''T,'')','ECROSSELIGZ0','50','D','10','12',NULL,'Work Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressEmail"','13','(''UA''=''T,'')','ECROSSELIGZ0','50','D','10','13',NULL,'Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','14','(''UD112''=''T,'')','ECROSSELIGZ0','50','D','10','14',NULL,'Birth Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','15','(''UA''=''T,'')','ECROSSELIGZ0','50','D','10','15',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMedID "','16','(''UA''=''T,'')','ECROSSELIGZ0','50','D','10','16',NULL,'Medical Group ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','17','(''SS''=''T,'')','ECROSSELIGZ0','50','D','10','17',NULL,'Subscriber ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMedPlan"','18','(''UA''=''T,'')','ECROSSELIGZ0','50','D','10','18',NULL,'Medical Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelationshipCode"','19','(''UA''=''T,'')','ECROSSELIGZ0','50','D','10','19',NULL,'Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmplStatus"','20','(''UA''=''T,'')','ECROSSELIGZ0','50','D','10','20',NULL,'Employment Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVisGroup"','21','(''UA''=''T,'')','ECROSSELIGZ0','50','D','10','21',NULL,'Vision Group ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVisPlan"','22','(''UA''=''T,'')','ECROSSELIGZ0','50','D','10','22',NULL,'Vision Plan #',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVisStartDate"','23','(''UD112''=''T,'')','ECROSSELIGZ0','50','D','10','23',NULL,'Vision Plan Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVisStopDate"','24','(''UD112''=''T,'')','ECROSSELIGZ0','50','D','10','24',NULL,'Vision Plan Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLocation"','25','(''UA''=''T,'')','ECROSSELIGZ0','50','D','10','25',NULL,'Location Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpNo"','26','(''UA''=''T,'')','ECROSSELIGZ0','50','D','10','26',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','27','(''SS''=''T,'')','ECROSSELIGZ0','50','D','10','27',NULL,'Last Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMedStartDate"','28','(''UD112''=''T,'')','ECROSSELIGZ0','50','D','10','28',NULL,'Medical Plan Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMedStopDate"','29','(''UD112''=''T,'')','ECROSSELIGZ0','50','D','10','29',NULL,'Medical Plan Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofTermination"','30','(''UD112''=''T,'')','ECROSSELIGZ0','50','D','10','30',NULL,'Term Employment Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','31','(''UA''=''T,'')','ECROSSELIGZ0','50','D','10','31',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','32','(''SS''=''T,'')','ECROSSELIGZ0','50','D','10','32',NULL,'Division #',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','33','(''SS''=''T'')','ECROSSELIGZ0','50','D','10','33',NULL,'GL Site Department Name',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'ECROSSELIG_20210611.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,'SPXF3,SPXML,SPXBO,SPXK9',NULL,NULL,NULL,'Crossover Health Eligibility','202005059','EMPEXPORT','ONDEMAND',NULL,'ECROSSELIG',NULL,NULL,NULL,'202106049','Jan 28 2020 12:39PM','Jan 28 2020 12:39PM','202105271',NULL,'','','202004281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202105101','EMPEXPORT','TEST','May 10 2021 11:54AM','ECROSSELIG',NULL,NULL,NULL,'202105101','May 10 2021 12:00AM','Dec 30 1899 12:00AM','202103011','889','','','202103011',dbo.fn_GetTimedKey(),NULL,'us3rVaCRO1006',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECROSSELIG','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECROSSELIG','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECROSSELIG','InitialSort','C','drvEmpNo');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECROSSELIG','SubSort','C','drvSSN');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECROSSELIG','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECROSSELIG','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'ECROSSELIG' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'ECROSSELIG' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_ECROSSELIG_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECROSSELIG_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECROSSELIG','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECROSSELIG','D10','dbo.U_ECROSSELIG_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_ECROSSELIG') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ECROSSELIG] (
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
IF OBJECT_ID('U_ECROSSELIG_Audit') IS NULL
CREATE TABLE [dbo].[U_ECROSSELIG_Audit] (
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
IF OBJECT_ID('U_ECROSSELIG_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ECROSSELIG_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_ECROSSELIG_DedList') IS NULL
CREATE TABLE [dbo].[U_ECROSSELIG_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ECROSSELIG_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ECROSSELIG_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NULL,
    [drvFileID] char(11) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(50) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvAddressLine1] varchar(8000) NULL,
    [drvAddressLine2] varchar(8000) NULL,
    [drvAddressCity] varchar(8000) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvAddressCountry] char(3) NULL,
    [drvPhoneHomeNo] varchar(50) NULL,
    [drvAddressEmail] varchar(50) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvGender] char(1) NULL,
    [drvMedID] varchar(6) NULL,
    [drvMedPlan] varchar(11) NULL,
    [drvRelationshipCode] varchar(2) NOT NULL,
    [drvEmplStatus] varchar(1) NOT NULL,
    [drvVisGroup] varchar(6) NULL,
    [drvVisPlan] varchar(10) NULL,
    [drvVisStartDate] datetime NULL,
    [drvVisStopDate] datetime NULL,
    [drvLocation] char(6) NULL,
    [drvEmpNo] char(9) NULL,
    [drvMedStartDate] datetime NULL,
    [drvMedStopDate] datetime NULL,
    [drvDateofTermination] datetime NULL,
    [drvSSN] char(11) NULL
);
IF OBJECT_ID('U_ECROSSELIG_EEList') IS NULL
CREATE TABLE [dbo].[U_ECROSSELIG_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ECROSSELIG_File') IS NULL
CREATE TABLE [dbo].[U_ECROSSELIG_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECROSSELIG]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Crossover Health Management Services, Inc.

Created By: Kyle Bakhshpour
Business Analyst: Lauren Brown-Underwood
Create Date: 01/28/2020
Service Request Number: SR-2019-00255682

Purpose: Crossover Health Eligibility Export

Revision History
----------------
Update By           Date           Request Num        Desc
Marco Lagrosa       01/20/2021     SR-2020-000XXXXX   Updates to add XOMFT and XOMPT 

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECROSSELIG';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECROSSELIG';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECROSSELIG';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECROSSELIG';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECROSSELIG' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECROSSELIG', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECROSSELIG', 'TEST';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ECROSSELIG';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ECROSSELIG', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ECROSSELIG';

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
    DELETE FROM dbo.U_ECROSSELIG_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECROSSELIG_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Create Deduction List
    --==========================================

        


    DECLARE @DedList VARCHAR(MAX)
    --Added MML

    SET @DedList = 'MEDFT,MEDPT,VISFT,VISPT,XOXO,XOXO2,XOMPT,XOMFT';
    /*
    IF @ExportCode LIKE '%TEST' 
    BEGIN
        SET @DedList = 'MEDFT,MEDPT,VISFT,VISPT,XOXO,XOXO2,XOMPT,XOMFT';

    END
    ELSE
    BEGIN
        SET @DedList = 'MEDFT,MEDPT,VISFT,VISPT,XOXO,XOXO2';
    END
    */
    --Added MML
    IF OBJECT_ID('U_ECROSSELIG_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ECROSSELIG_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ECROSSELIG_DedList
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
    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ECROSSELIG_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ECROSSELIG_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECROSSELIG_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = ConSystemID
        -- standard fields above and additional driver fields below
        ,drvFileID = CASE
                        WHEN ALLBEN.BdmRecType = 'EMP' THEN EepSSN
                        ELSE ConSSN
                     END
        ,drvNameFirst = CASE
                            WHEN ALLBEN.BdmRecType = 'EMP' THEN EepNameFirst
                            ELSE ConNameFirst
                        END    
        ,drvNameMiddle = CASE
                            WHEN ALLBEN.BdmRecType = 'EMP' THEN EepNameMiddle
                            ELSE ConNameMiddle
                         END    
        ,drvNameLast = CASE
                          WHEN ALLBEN.BdmRecType = 'EMP' THEN EepNameLast
                          ELSE ConNameLast
                       END
        ,drvAddressLine1 = CASE
                              WHEN ALLBEN.BdmRecType = 'EMP' THEN REPLACE(EepAddressLine1, ',', '')
                              ELSE REPLACE(ConAddressLine1, ',', '')
                           END
        ,drvAddressLine2 = CASE
                              WHEN ALLBEN.BdmRecType = 'EMP' THEN REPLACE(EepAddressLine2, ',', '')
                              ELSE REPLACE(ConAddressLine2, ',', '')
                           END
        ,drvAddressCity = CASE
                             WHEN ALLBEN.BdmRecType = 'EMP' THEN REPLACE(EepAddressCity, ',', '')
                             ELSE REPLACE(ConAddressCity, ',', '')
                          END
        ,drvAddressState = CASE
                             WHEN ALLBEN.BdmRecType = 'EMP' THEN EepAddressState
                             ELSE ConAddressState
                           END
        ,drvAddressZipCode = CASE
                                WHEN ALLBEN.BdmRecType = 'EMP' THEN EepAddressZipCode
                                ELSE ConAddressZipCode
                             END
        ,drvAddressCountry = CASE
                                WHEN ALLBEN.BdmRecType = 'EMP' THEN EepAddressCountry
                                ELSE ConAddressCountry
                             END
        ,drvPhoneHomeNo = CASE
                             WHEN ALLBEN.BdmRecType = 'EMP' THEN EepPhoneHomeNumber
                             ELSE ConPhoneHomeNumber
                          END
        ,drvAddressEmail = EepAddressEMail
        ,drvDateOfBirth = CASE
                            WHEN ALLBEN.BdmRecType = 'EMP' THEN EepDateOfBirth
                            ELSE ConDateOfBirth
                          END
        ,drvGender = CASE
                        WHEN ALLBEN.BdmRecType = 'EMP' THEN EepGender
                        ELSE ConGender
                     END
        ,drvMedID = CASE
                      WHEN MED.BdmEEID IS NOT NULL THEN '143903'
                      WHEN MED2.Bdmeeid is not null then '143903'
                    END
        ,drvMedPlan = CASE
                         WHEN MED.BdmEEID IS NOT NULL THEN 'Aetna + HSA'
                         WHEN MED2.Bdmeeid is not null then 'XO First'
                          
                      END
        ,drvRelationshipCode = CASE
                                 WHEN ALLBEN.BdmRecType = 'EMP' THEN 'SE'
                                 ELSE CASE
                                        WHEN ConRelationship IN ('SPS','DP','DPN') THEN 'SP'
                                        ELSE 'CH'
                                      END
                               END
        ,drvEmplStatus = CASE
                            WHEN EecEmplStatus = 'A' THEN 'A'
                            WHEN EecEmplStatus = 'L' THEN 'L'
                            WHEN EepUDField08 = 'Y' AND ALLBEN.BdmDedCode = 'XOXO' AND EepUDField13 IS NOT NULL THEN 'C' 
                           -- ELSE 'C'
                         END
        ,drvVisGroup = CASE
                         WHEN VIS.BdmEEID IS NOT NULL THEN '566410'
                       END
        ,drvVisPlan = CASE
                         WHEN VIS.BdmEEID IS NOT NULL THEN 'VSP Choice'
                       END
        ,drvVisStartDate = CASE
                              WHEN VIS.BdmEEID IS NOT NULL THEN VIS.BdmBenStartDate
                           END
        ,drvVisStopDate = CASE
                             WHEN VIS.BdmEEID IS NOT NULL THEN VIS.BdmBenStopDate
                          END
        ,drvLocation = EecLocation
        ,drvEmpNo = EecEmpNo
        ,drvMedStartDate = CASE
                              WHEN MED.BdmEEID IS NOT NULL THEN MED.BdmBenStartDate
                           END
        ,drvMedStopDate = CASE
                              WHEN MED.BdmEEID IS NOT NULL THEN MED.BdmBenStopDate
                           END
        ,drvDateofTermination = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvSSN = CASE
                     WHEN ALLBEN.BdmRecType = 'EMP' THEN EepSSN
                     ELSE ConSSN
                  END
    INTO dbo.U_ECROSSELIG_drvTbl
    FROM dbo.U_ECROSSELIG_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
        AND EecEEType <> 'TES'
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ECROSSELIG AS ALLBEN WITH (NOLOCK) -- XOXO or XOXO2 required to be on the file 
        ON ALLBEN.BdmEEID = xEEID 
        AND ALLBEN.BdmCoID = xCoID
        AND ALLBEN.BdmDedcode IN ('XOXO','XOXO2')
    LEFT JOIN dbo.U_dsi_BDM_ECROSSELIG AS MED WITH (NOLOCK)
        ON MED.BdmEEID = xEEID 
        AND MED.BdmCoID = xCoID
        AND MED.BdmDedCode IN ('MEDFT','MEDPT')
        AND ISNULL(MED.BdmDepRecID,'') = ISNULL(ALLBEN.BdmDepRecID,'')
    --Added MML
    LEFT JOIN dbo.U_dsi_BDM_ECROSSELIG AS MED2 WITH (NOLOCK)
        ON MED2.BdmEEID = xEEID 
        AND MED2.BdmCoID = xCoID
        AND MED2.BdmDedCode IN ('XOMFT','XOMPT')
        AND ISNULL(MED2.BdmDepRecID,'') = ISNULL(ALLBEN.BdmDepRecID,'')
    --Added MML
    LEFT JOIN dbo.U_dsi_BDM_ECROSSELIG AS VIS WITH (NOLOCK)
        ON VIS.BdmEEID = xEEID 
        AND VIS.BdmCoID = xCoID
        AND VIS.BdmDedCode IN ('VISFT','VISPT')
        AND ISNULL(VIS.BdmDepRecID,'') = ISNULL(ALLBEN.BdmDepRecID,'')
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = ALLBEN.BdmDepRecID
    WHERE EepUDField07 = 'Y' AND 
    (EecEmplStatus IN ('A','L') OR 
     EecEmplStatus = 'T' AND EecDateOfTermination BETWEEN (SELECT DATEADD(mm, DATEDIFF(mm, 0, @EndDate), 0)) AND (SELECT DATEADD (dd, -1, DATEADD(mm, DATEDIFF(mm, 0, @EndDate) + 1, 0))))
    ;


    DELETE A
    FROM dbo.U_ECROSSELIG_drvTbl AS A
    JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = drvEEID
        AND ConSystemID = drvDepRecID
    WHERE drvRelationshipCode = 'CH' 
    AND dbo.mk2_ret_age(ConDateOfBirth) < 18
    ;



    Delete from dbo.U_ECROSSELIG_drvTbl where drveeid in (
        Select distinct  drvEEID from U_ECROSSELIG_drvTbl
        join EmpPers on eepEEID = drveeid 
        where drvEmplStatus = 'C'
        and EEPUDFIELD08 is null or EEPUDFIELD12 is  null)  and drvEmplStatus = 'C'

    -- DELETE cobra end < current date
    DELETE FROM dbo.U_ECROSSELIG_drvTbl where drveeid in (
        Select distinct  drvEEID from U_ECROSSELIG_drvTbl
        join EmpPers on eepEEID = drveeid 
        where drvEmplStatus = 'C'
        and cast(EEPUDFIELD12 as date) <= cast(getdate() as date))  and drvEmplStatus = 'C' 


END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwECROSSELIG_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECROSSELIG_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ECROSSELIG%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202001211'
       ,expStartPerControl     = '202001211'
       ,expLastEndPerControl   = '202001289'
       ,expEndPerControl       = '202001289'
WHERE expFormatCode = 'ECROSSELIG';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwECROSSELIG_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ECROSSELIG_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort
