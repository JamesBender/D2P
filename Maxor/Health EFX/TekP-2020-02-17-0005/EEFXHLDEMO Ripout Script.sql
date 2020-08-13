SET NOCOUNT ON;
IF OBJECT_ID('U_EEFXHLDEMO_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EEFXHLDEMO_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EEFXHLDEMO_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EEFXHLDEMO' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEEFXHLDEMO_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEEFXHLDEMO_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EEFXHLDEMO') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EEFXHLDEMO];
GO
IF OBJECT_ID('U_EEFXHLDEMO_File') IS NOT NULL DROP TABLE [dbo].[U_EEFXHLDEMO_File];
GO
IF OBJECT_ID('U_EEFXHLDEMO_EEList') IS NOT NULL DROP TABLE [dbo].[U_EEFXHLDEMO_EEList];
GO
IF OBJECT_ID('U_EEFXHLDEMO_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EEFXHLDEMO_drvTbl];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EEFXHLDEMO';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EEFXHLDEMO';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EEFXHLDEMO';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EEFXHLDEMO';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EEFXHLDEMO';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EEFXHLDEMO','Health EFX Demographics Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','EEFXHLDEMOZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FEIN"','1','(''DA''=''T|'')','EEFXHLDEMOZ0','50','H','01','1',NULL,'Primary FEIN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SSN"','2','(''DA''=''T|'')','EEFXHLDEMOZ0','50','H','01','2',NULL,'Employee SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMPLOYEE_ID"','3','(''DA''=''T|'')','EEFXHLDEMOZ0','50','H','01','3',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FIRST_NAME"','4','(''DA''=''T|'')','EEFXHLDEMOZ0','50','H','01','4',NULL,'Employee First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MIDDLE_NAME"','5','(''DA''=''T|'')','EEFXHLDEMOZ0','50','H','01','5',NULL,'Employee Middile Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LAST_NAME"','6','(''DA''=''T|'')','EEFXHLDEMOZ0','50','H','01','6',NULL,'Employee Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ADDRESS1"','7','(''DA''=''T|'')','EEFXHLDEMOZ0','50','H','01','7',NULL,'Mailing address for employee - Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ADDRESS2"','8','(''DA''=''T|'')','EEFXHLDEMOZ0','50','H','01','8',NULL,'Mailing address for employee - Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CITY"','9','(''DA''=''T|'')','EEFXHLDEMOZ0','50','H','01','9',NULL,'City for employee',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STATE"','10','(''DA''=''T|'')','EEFXHLDEMOZ0','50','H','01','10',NULL,'State of Residence for employee',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ZIP"','11','(''DA''=''T|'')','EEFXHLDEMOZ0','50','H','01','11',NULL,'Resident ZIP Code for employee',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DOB"','12','(''DA''=''T|'')','EEFXHLDEMOZ0','50','H','01','12',NULL,'Employee Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HIRE_DATE"','13','(''DA''=''T|'')','EEFXHLDEMOZ0','50','H','01','13',NULL,'Original Employee Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"REHIRE_DATE"','14','(''DA''=''T|'')','EEFXHLDEMOZ0','50','H','01','14',NULL,'Employee Rehire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TERM_DATE"','15','(''DA''=''T|'')','EEFXHLDEMOZ0','50','H','01','15',NULL,'Employee date of termination',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STATUS"','16','(''DA''=''T|'')','EEFXHLDEMOZ0','50','H','01','16',NULL,'Employee Work Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ELIGIBILITY_STATUS"','17','(''DA''=''T|'')','EEFXHLDEMOZ0','50','H','01','17',NULL,'Employee Position Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PAY_TYPE"','18','(''DA''=''T|'')','EEFXHLDEMOZ0','50','H','01','18',NULL,'Employee Pay Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HOURLY_RATE"','19','(''DA''=''T|'')','EEFXHLDEMOZ0','50','H','01','19',NULL,'Hourly Rate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMPLOYER"','20','(''DA''=''T|'')','EEFXHLDEMOZ0','50','H','01','20',NULL,'Employer',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LOCATION_CODE"','21','(''DA''=''T|'')','EEFXHLDEMOZ0','50','H','01','21',NULL,'Location Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STATUS_CHANGE_DATE"','22','(''DA''=''T|'')','EEFXHLDEMOZ0','50','H','01','22',NULL,'Effective date of status change',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"POSITION"','23','(''DA''=''T|'')','EEFXHLDEMOZ0','50','H','01','23',NULL,'Job/Position Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"POSITION_DESCRIPTION"','24','(''DA''=''T|'')','EEFXHLDEMOZ0','50','H','01','24',NULL,'Position Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WORK_EMAIL"','25','(''DA''=''T|'')','EEFXHLDEMOZ0','50','H','01','25',NULL,'Work email address for employee',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PHONE"','26','(''DA''=''T|'')','EEFXHLDEMOZ0','50','H','01','26',NULL,'Contact phone number for employee',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"COMPANY_CODE"','27','(''DA''=''T|'')','EEFXHLDEMOZ0','50','H','01','27',NULL,'Hierarchy Sub-Level 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"COST_CENTER"','28','(''DA''=''T|'')','EEFXHLDEMOZ0','50','H','01','28',NULL,'Hierarchy Sub-Level 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEPARTMENT"','29','(''DA''=''T|'')','EEFXHLDEMOZ0','50','H','01','29',NULL,'Hierarchy Sub-Level 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SAN_FRANCISCO"','30','(''DA''=''T|'')','EEFXHLDEMOZ0','50','H','01','30',NULL,'Healthy San Francisco Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SCHEDULED_HOURS"','31','(''DA''=''T|'')','EEFXHLDEMOZ0','50','H','01','31',NULL,'Scheduled Hours Per Week',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"COST_CENTER_DESCRIPTION"','32','(''DA''=''T|'')','EEFXHLDEMOZ0','50','H','01','32',NULL,'Cost Center Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEPARTMENT_DESCRIPTION"','33','(''DA''=''T|'')','EEFXHLDEMOZ0','50','H','01','33',NULL,'Department Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SUPERVISOR"','34','(''DA''=''T|'')','EEFXHLDEMOZ0','50','H','01','34',NULL,'Supervisor Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SUPERVISOR_ID"','35','(''DA''=''T|'')','EEFXHLDEMOZ0','50','H','01','35',NULL,'Supervisor ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SUPERVISOR_EMAIL"','36','(''DA''=''T|'')','EEFXHLDEMOZ0','50','H','01','36',NULL,'Supervisor Work Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CUSTOM_9"','37','(''DA''=''T|'')','EEFXHLDEMOZ0','50','H','01','37',NULL,'Future CustomerPlaceholder',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CUSTOM_10"','38','(''DA''=''T'')','EEFXHLDEMOZ0','50','H','01','38',NULL,'Future CustomerPlaceholder',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPrimaryFEIN"','1','(''UA''=''T|'')','EEFXHLDEMOZ0','50','D','10','1',NULL,'Primary FEIN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','2','(''UA''=''T|'')','EEFXHLDEMOZ0','50','D','10','2',NULL,'Employee SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeID"','3','(''UA''=''T|'')','EEFXHLDEMOZ0','50','D','10','3',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','4','(''UA''=''T|'')','EEFXHLDEMOZ0','50','D','10','4',NULL,'Employee First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','5','(''UA''=''T|'')','EEFXHLDEMOZ0','50','D','10','5',NULL,'Employee Middile Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','6','(''UA''=''T|'')','EEFXHLDEMOZ0','50','D','10','6',NULL,'Employee Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','7','(''UA''=''T|'')','EEFXHLDEMOZ0','50','D','10','7',NULL,'Mailing address for employee - Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','8','(''UA''=''T|'')','EEFXHLDEMOZ0','50','D','10','8',NULL,'Mailing address for employee - Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCirty"','9','(''UA''=''T|'')','EEFXHLDEMOZ0','50','D','10','9',NULL,'City for employee',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','10','(''UA''=''T|'')','EEFXHLDEMOZ0','50','D','10','10',NULL,'State of Residence for employee',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','11','(''UA''=''T|'')','EEFXHLDEMOZ0','50','D','10','11',NULL,'Resident ZIP Code for employee',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','12','(''UD112''=''T|'')','EEFXHLDEMOZ0','50','D','10','12',NULL,'Employee Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfOriginalHire"','13','(''UD112''=''T|'')','EEFXHLDEMOZ0','50','D','10','13',NULL,'Original Employee Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfReHire"','14','(''UD112''=''T|'')','EEFXHLDEMOZ0','50','D','10','14',NULL,'Employee Rehire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfTermination"','15','(''UD112''=''T|'')','EEFXHLDEMOZ0','50','D','10','15',NULL,'Employee date of termination',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmplStatus"','16','(''UA''=''T|'')','EEFXHLDEMOZ0','50','D','10','16',NULL,'Employee Work Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPositionStatus"','17','(''UA''=''T|'')','EEFXHLDEMOZ0','50','D','10','17',NULL,'Employee Position Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmplPayType"','18','(''UA''=''T|'')','EEFXHLDEMOZ0','50','D','10','18',NULL,'Employee Pay Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHourlyPayRate"','19','(''UA''=''T|'')','EEFXHLDEMOZ0','50','D','10','19',NULL,'Hourly Rate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployer"','20','(''UA''=''T|'')','EEFXHLDEMOZ0','50','D','10','20',NULL,'Employer',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLocationCode"','21','(''UA''=''T|'')','EEFXHLDEMOZ0','50','D','10','21',NULL,'Location Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffDateOfStatusChange"','22','(''UD112''=''T|'')','EEFXHLDEMOZ0','50','D','10','22',NULL,'Effective date of status change',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobCode"','23','(''UA''=''T|'')','EEFXHLDEMOZ0','50','D','10','23',NULL,'Job/Position Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPositionDescription"','24','(''UA''=''T|'')','EEFXHLDEMOZ0','50','D','10','24',NULL,'Position Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressWorkEmal"','25','(''UA''=''T|'')','EEFXHLDEMOZ0','50','D','10','25',NULL,'Work email address for employee',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneContactNo"','26','(''UA''=''T|'')','EEFXHLDEMOZ0','50','D','10','26',NULL,'Contact phone number for employee',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHiearcySubLvl1"','27','(''UA''=''T|'')','EEFXHLDEMOZ0','50','D','10','27',NULL,'Hierarchy Sub-Level 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHiearcySubLvl2"','28','(''UA''=''T|'')','EEFXHLDEMOZ0','50','D','10','28',NULL,'Hierarchy Sub-Level 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHiearcySubLvl3"','29','(''UA''=''T|'')','EEFXHLDEMOZ0','50','D','10','29',NULL,'Hierarchy Sub-Level 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHealthySFOIndicator"','30','(''UA''=''T|'')','EEFXHLDEMOZ0','50','D','10','30',NULL,'Healthy San Francisco Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvScheduledHrsPerWeek"','31','(''UA''=''T|'')','EEFXHLDEMOZ0','50','D','10','31',NULL,'Scheduled Hours Per Week',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCostCenterDescription"','32','(''UA''=''T|'')','EEFXHLDEMOZ0','50','D','10','32',NULL,'Cost Center Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepartmentDescription"','33','(''UA''=''T|'')','EEFXHLDEMOZ0','50','D','10','33',NULL,'Department Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSupervisorName"','34','(''UA''=''T|'')','EEFXHLDEMOZ0','50','D','10','34',NULL,'Supervisor Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSupervisorID"','35','(''UA''=''T|'')','EEFXHLDEMOZ0','50','D','10','35',NULL,'Supervisor ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSupervisorEmail"','36','(''UA''=''T|'')','EEFXHLDEMOZ0','50','D','10','36',NULL,'Supervisor Work Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','37','(''DA''=''T|'')','EEFXHLDEMOZ0','50','D','10','37',NULL,'Future CustomerPlaceholder',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','38','(''DA''=''T'')','EEFXHLDEMOZ0','50','D','10','38',NULL,'Future CustomerPlaceholder',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EEFXHLDEMO_20200630.txt',NULL,'','',NULL,NULL,NULL,NULL,'Health EFX Demographics Export','202003279','EMPEXPORT','ONDEMAND',NULL,'EEFXHLDEMO',NULL,NULL,NULL,'202003279','May  5 2020 10:40AM','May  5 2020 10:40AM','202003201',NULL,'','','202003201',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EEFXHLDEMO_20200630.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','202003279','EMPEXPORT','SCHEDULED',NULL,'EEFXHLDEMO',NULL,NULL,NULL,'202003279','May  5 2020 10:40AM','May  5 2020 10:40AM','202003201',NULL,'','','202003201',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EEFXHLDEMO_20200630.txt',NULL,'','','Y23F4,1KHF6,1KHLK,1KHQV,FB4R0',NULL,NULL,NULL,'Test Purposes Only','202002159','EMPEXPORT','TEST','Jun 30 2020 12:00AM','EEFXHLDEMO',NULL,NULL,NULL,'202002159','Feb 15 2020 12:00AM','Dec 30 1899 12:00AM','202002071','1015','','','202002071',dbo.fn_GetTimedKey(),NULL,'us3lKiMAX1005',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EEFXHLDEMO_20200630.txt' END WHERE expFormatCode = 'EEFXHLDEMO';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEFXHLDEMO','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEFXHLDEMO','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEFXHLDEMO','SubSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEFXHLDEMO','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEFXHLDEMO','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EEFXHLDEMO' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EEFXHLDEMO' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EEFXHLDEMO_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EEFXHLDEMO_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EEFXHLDEMO','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EEFXHLDEMO','D10','dbo.U_EEFXHLDEMO_drvTbl',NULL);
IF OBJECT_ID('U_EEFXHLDEMO_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EEFXHLDEMO_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] datetime NULL,
    [drvPrimaryFEIN] varchar(10) NULL,
    [drvSSN] char(11) NULL,
    [drvEmployeeID] char(9) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(50) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCirty] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvDateOfOriginalHire] datetime NULL,
    [drvDateOfReHire] datetime NULL,
    [drvDateOfTermination] datetime NULL,
    [drvEmplStatus] char(1) NULL,
    [drvPositionStatus] varchar(2) NOT NULL,
    [drvEmplPayType] char(1) NULL,
    [drvHourlyPayRate] nvarchar(4000) NULL,
    [drvEmployer] varchar(40) NULL,
    [drvLocationCode] char(6) NULL,
    [drvEffDateOfStatusChange] datetime NULL,
    [drvJobCode] char(8) NULL,
    [drvPositionDescription] varchar(25) NOT NULL,
    [drvAddressWorkEmal] varchar(50) NULL,
    [drvPhoneContactNo] varchar(50) NULL,
    [drvHiearcySubLvl1] varchar(5) NULL,
    [drvHiearcySubLvl2] char(6) NULL,
    [drvHiearcySubLvl3] char(6) NULL,
    [drvHealthySFOIndicator] varchar(1) NOT NULL,
    [drvScheduledHrsPerWeek] nvarchar(4000) NULL,
    [drvCostCenterDescription] varchar(25) NULL,
    [drvDepartmentDescription] varchar(25) NULL,
    [drvSupervisorName] varchar(204) NULL,
    [drvSupervisorID] char(9) NULL,
    [drvSupervisorEmail] varchar(50) NULL
);
IF OBJECT_ID('U_EEFXHLDEMO_EEList') IS NULL
CREATE TABLE [dbo].[U_EEFXHLDEMO_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EEFXHLDEMO_File') IS NULL
CREATE TABLE [dbo].[U_EEFXHLDEMO_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EEFXHLDEMO]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Maxor National Pharm

Created By: James Bender
Business Analyst: Lea King
Create Date: 05/05/2020
Service Request Number: TekP-2020-02-17-0005

Purpose: Health EFX Demographics Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EEFXHLDEMO';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EEFXHLDEMO';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EEFXHLDEMO';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EEFXHLDEMO';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EEFXHLDEMO' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEFXHLDEMO', 'ONDEMAND';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EEFXHLDEMO', @AllObjects = 'Y', @IsWeb = 'Y'
**********************************************************************************/
BEGIN

    --==========================================
    -- Declare variables
    --==========================================
    DECLARE  @FormatCode        VARCHAR(10)
            ,@ExportCode        VARCHAR(10)
            ,@StartDate         DATETIME
            ,@EndDate           DATETIME
            ,@FedTaxId            VARCHAR(9)
            ,@CompanyName        VARCHAR(40)
            ,@CompanyCode        VARCHAR(5)
            ,@StartPerControl   VARCHAR(9)
            ,@EndPerControl     VARCHAR(9);

    -- Set FormatCode
    SELECT @FormatCode = 'EEFXHLDEMO';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    SELECT TOP 1 @FedTaxID = CmmFedTaxId, @CompanyName = CmmCompanyName, @CompanyCode = CmmCompanyCode FROM dbo.CompMast WITH (NOLOCK);

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EEFXHLDEMO_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EEFXHLDEMO_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_EEFXHLDEMO_EEList
    WHERE xEEID IN (SELECT EecEEID FROM EmpComp WITH(NOLOCK) WHERE EecEEType = 'TES' );

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EEFXHLDEMO_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EEFXHLDEMO_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EEFXHLDEMO_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = EecDateOfTErmination 
        -- standard fields above and additional driver fields below
        ,drvPrimaryFEIN = LEFT(@FedTaxID, 2) + '-' + RIGHT(@FedTaxID, 7)
        ,drvSSN = eepSSN
        ,drvEmployeeID = EecEmpNo
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddle = EepNameMiddle -- LEFT(EepNameMiddle,1)
        ,drvNameLast = EepNameLast
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCirty = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvDateOfBirth = EepDateOfBirth
        ,drvDateOfOriginalHire = EecDateOfOriginalHire
        ,drvDateOfReHire = CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire AND EecDateOfLastHire < @EndDate THEN EecDateOfLastHire END
        ,drvDateOfTermination =    CASE WHEN EecEmplStatus = 'T' AND EecDateOfTermination <= @EndDate THEN EecDateOfTermination 
                                    WHEN EhcEmplStatus = 'T' AND EecDateOfTermination IS NULL THEN DATEADD(DAY, -1, EhcEmplStatusStartDate)
                                END
        ,drvEmplStatus = EhcEmplStatus -- EecEmplStatus
        ,drvPositionStatus = CASE WHEN EecEEType IN ('REG', 'PT3', 'PTG') THEN 'FT' ELSE 'PT' END
        ,drvEmplPayType = EecSalaryOrHourly
        ,drvHourlyPayRate = FORMAT(EecHourlyPayRate, '#0.00')
        ,drvEmployer = @CompanyName
        ,drvLocationCode = EecLocation
        ,drvEffDateOfStatusChange =    CASE WHEN EecFullTimeOrPartTime = 'FT' AND EjhFullTimeOrPartTime = 'P' THEN EjhJobEffDate
                                        WHEN EecFullTimeOrPartTime = 'PT' AND EjhFullTimeOrPartTime = 'F' THEN EjhJobEffDate
                                        ELSE EecEmplStatusStartDate
                                    END
        ,drvJobCode = EecJobCode
        ,drvPositionDescription = JbcDesc
        ,drvAddressWorkEmal = EepAddressEmail
        ,drvPhoneContactNo = EecPhoneBusinessNumber
        ,drvHiearcySubLvl1 = @CompanyCode
        ,drvHiearcySubLvl2 = EecOrgLvl1
        ,drvHiearcySubLvl3 = EecOrgLvl2
        ,drvHealthySFOIndicator = CASE WHEN LocAddressCity = 'San Francisco' THEN 'Y' ELSE 'N' END
        ,drvScheduledHrsPerWeek = FORMAT(EecScheduledWorkHrs, '#0.00')
        ,drvCostCenterDescription = CostCenterDesc
        ,drvDepartmentDescription = DepartmentDesc
        ,drvSupervisorName = SupervisorName
        ,drvSupervisorID = EmpSupervisorId --(SELECT TOP 1 SUP.EecEmpNo FROM dbo.EmpComp SUP WHERE SUP.EecEEID = EecSupervisorID)
        ,drvSupervisorEmail = SupervisorEmail
    INTO dbo.U_EEFXHLDEMO_drvTbl
    FROM dbo.U_EEFXHLDEMO_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.EmpHJob WITH (NOLOCK)
        ON EjhEEID = xEEID
        AND EjhCOID = xCOID
    JOIN dbo.Location WITH (NOLOCK)
        ON EecLocation = LocCode
    JOIN (
            SELECT OrgCode AS CostCenterCode, OrgDesc AS CostCenterDesc
            FROM dbo.OrgLevel WITH (NOLOCK)) AS CostCenter
        ON CostCenterCode = EecOrgLvl1
    JOIN (
            SELECT OrgCode AS DepartmentCode, OrgDesc AS DepartmentDesc
            FROM dbo.OrgLevel WITH (NOLOCK)) AS Department
        ON DepartmentCode = EecOrgLvl2
    JOIN (
            SELECT EepEEID AS SupervisorID, EepNameLast + ', ' + EepNameFirst + ' ' + ISNULL(LEFT(EepNameMiddle, 1), '') AS SupervisorName, EepAddressEmail AS SupervisorEmail
            FROM dbo.EmpPers WITH (NOLOCK)) AS Supervisors
        ON SupervisorID = EecSupervisorId
    JOIN (
            SELECT DISTINCT EecEEID AS SupEEID, EecCOID AS EmpCOID, EecEmpNo AS EmpSupervisorId
            FROM dbo.EmpComp WITH (NOLOCK)) As SupervisorId
        ON EecSupervisorID = SupEEID
    LEFT JOIN (
            SELECT EhcEEID, EhcCOID, EhcEmplStatus, EhcEmplStatusStartDate
            FROM (
                SELECT EhcEEID, EhcCOID, EhcEmplStatus, EhcEmplStatusStartDate, ROW_NUMBER() OVER (PARTITION BY EhcEEID, EhcCOID ORDER BY EhcEmplStatusStartDate DESC) AS RN
                FROM EmpHComp
                WHERE EhcEmplStatusStartDate <= DATEADD(DAY, 1, @EndDate) -- '1/31/2020'
                ) AS T
            WHERE RN = 1
                --AND EhcEEID IN ('B2CGBL04B0K0', 'D9PH8H000020')
                ) AS U
        ON EhcEEID = xEEID
        AND EhcCOID = xCOID
    WHERE --(EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND EecDateOfTermination > DATEADD(DAY, -120, @EndDate)))
        (EhcEmplStatus <> 'T' OR (EhcEmplStatus = 'T' AND EhcEmplStatusStartDate > DATEADD(DAY, -120, @EndDate)))
        AND (EecDateOfTErmination IS NULL OR EecDateOfTErmination >= '1/1/2020')
    /*    AND (EecDateOfTErmination IS NULL OR EecDateOfTermination <= @EndDate)
        AND (EecDateOfOriginalHire IS NULL OR EecDateOfOriginalHire <= @EndDate)
        AND (EecDateOfLastHire IS NULL OR EecDateOfLastHire <= @EndDate)*/
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
ALTER VIEW dbo.dsi_vwEEFXHLDEMO_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EEFXHLDEMO_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EEFXHLDEMO%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202003201'
       ,expStartPerControl     = '202003201'
       ,expLastEndPerControl   = '202003279'
       ,expEndPerControl       = '202003279'
WHERE expFormatCode = 'EEFXHLDEMO';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEEFXHLDEMO_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EEFXHLDEMO_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort