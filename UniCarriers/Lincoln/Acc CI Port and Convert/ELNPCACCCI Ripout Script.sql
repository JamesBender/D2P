SET NOCOUNT ON;
IF OBJECT_ID('U_ELNPCACCCI_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ELNPCACCCI_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ELNPCACCCI_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ELNPCACCCI' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwELNPCACCCI_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwELNPCACCCI_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ELNPCACCCI') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ELNPCACCCI];
GO
IF OBJECT_ID('U_ELNPCACCCI_File') IS NOT NULL DROP TABLE [dbo].[U_ELNPCACCCI_File];
GO
IF OBJECT_ID('U_ELNPCACCCI_EEList') IS NOT NULL DROP TABLE [dbo].[U_ELNPCACCCI_EEList];
GO
IF OBJECT_ID('U_ELNPCACCCI_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ELNPCACCCI_drvTbl];
GO
IF OBJECT_ID('U_ELNPCACCCI_DedList') IS NOT NULL DROP TABLE [dbo].[U_ELNPCACCCI_DedList];
GO
IF OBJECT_ID('U_ELNPCACCCI_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ELNPCACCCI_AuditFields];
GO
IF OBJECT_ID('U_ELNPCACCCI_Audit') IS NOT NULL DROP TABLE [dbo].[U_ELNPCACCCI_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_ELNPCACCCI') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ELNPCACCCI];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ELNPCACCCI';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ELNPCACCCI';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ELNPCACCCI';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ELNPCACCCI';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ELNPCACCCI';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ELNPCACCCI','Lincoln Port Acc\CI','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','ELNPCACCCIZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Termination Date"','1','(''DA''=''T,'')','ELNPCACCCIZ0','50','H','01','1',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Termination Reason"','2','(''DA''=''T,'')','ELNPCACCCIZ0','50','H','01','2',NULL,'Termination Reason',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Emp. First Name"','3','(''DA''=''T,'')','ELNPCACCCIZ0','50','H','01','3',NULL,'Emp. First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Emp. Last Name"','4','(''DA''=''T,'')','ELNPCACCCIZ0','50','H','01','4',NULL,'Emp. Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Emp. Middle Initial"','5','(''DA''=''T,'')','ELNPCACCCIZ0','50','H','01','5',NULL,'Emp. Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Emp. SSN"','6','(''DA''=''T,'')','ELNPCACCCIZ0','50','H','01','6',NULL,'Emp. SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Emp. Gender"','7','(''DA''=''T,'')','ELNPCACCCIZ0','50','H','01','7',NULL,'Emp. Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Emp. DOB"','8','(''DA''=''T,'')','ELNPCACCCIZ0','50','H','01','8',NULL,'Emp. DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Occupation"','9','(''DA''=''T,'')','ELNPCACCCIZ0','50','H','01','9',NULL,'Occupation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hrs Per Week"','10','(''DA''=''T,'')','ELNPCACCCIZ0','50','H','01','10',NULL,'Hrs Per Week',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Emp. Addr 1"','11','(''DA''=''T,'')','ELNPCACCCIZ0','50','H','01','11',NULL,'Emp. Addr 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Emp. City"','12','(''DA''=''T,'')','ELNPCACCCIZ0','50','H','01','12',NULL,'Emp. City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Emp. State"','13','(''DA''=''T,'')','ELNPCACCCIZ0','50','H','01','13',NULL,'Emp. State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Emp. Zip Code"','14','(''DA''=''T,'')','ELNPCACCCIZ0','50','H','01','14',NULL,'Emp. Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home Phone"','15','(''DA''=''T,'')','ELNPCACCCIZ0','50','H','01','15',NULL,'Home Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Phone"','16','(''DA''=''T,'')','ELNPCACCCIZ0','50','H','01','16',NULL,'Work Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Phone Ext"','17','(''DA''=''T,'')','ELNPCACCCIZ0','50','H','01','17',NULL,'Work Phone Ext',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Hire"','18','(''DA''=''T,'')','ELNPCACCCIZ0','50','H','01','18',NULL,'Date of Hire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Emp Work State"','19','(''DA''=''T,'')','ELNPCACCCIZ0','50','H','01','19',NULL,'Emp Work State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Marital Status"','20','(''DA''=''T,'')','ELNPCACCCIZ0','50','H','01','20',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Rehire Date"','21','(''DA''=''T,'')','ELNPCACCCIZ0','50','H','01','21',NULL,'Rehire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Email Address"','22','(''DA''=''T,'')','ELNPCACCCIZ0','50','H','01','22',NULL,'Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CI Original Eff Date"','23','(''DA''=''T,'')','ELNPCACCCIZ0','50','H','01','23',NULL,'CI Original Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CI Eff Date with Lincoln Financial"','24','(''DA''=''T,'')','ELNPCACCCIZ0','50','H','01','24',NULL,'CI Eff Date with Lincoln Financial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CI Plan Code"','25','(''DA''=''T,'')','ELNPCACCCIZ0','50','H','01','25',NULL,'CI Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CI Class Code"','26','(''DA''=''T,'')','ELNPCACCCIZ0','50','H','01','26',NULL,'CI Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CI Cvg Amount Employee"','27','(''DA''=''T,'')','ELNPCACCCIZ0','50','H','01','27',NULL,'CI Cvg Amount Employee',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CI Cvg Amount Spouse"','28','(''DA''=''T,'')','ELNPCACCCIZ0','50','H','01','28',NULL,'CI Cvg Amount Spouse',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CI Cvg Amount Child"','29','(''DA''=''T,'')','ELNPCACCCIZ0','50','H','01','29',NULL,'CI Cvg Amount Child',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ACC Class Code"','30','(''DA''=''T,'')','ELNPCACCCIZ0','50','H','01','30',NULL,'ACC Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ACC Cvgs"','31','(''DA''=''T,'')','ELNPCACCCIZ0','50','H','01','31',NULL,'ACC Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Claim Location Number"','32','(''DA''=''T,'')','ELNPCACCCIZ0','50','H','01','32',NULL,'Claim Location Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Claim Location Name"','33','(''DA''=''T,'')','ELNPCACCCIZ0','50','H','01','33',NULL,'Claim Location Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Billing Location Number"','34','(''DA''=''T,'')','ELNPCACCCIZ0','50','H','01','34',NULL,'Billing Location Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Billing Location Name"','35','(''DA''=''T'')','ELNPCACCCIZ0','50','H','01','35',NULL,'Billing Location Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationDate"','1','(''UD101''=''T,'')','ELNPCACCCIZ0','50','D','10','1',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationReason"','2','(''UA''=''T,'')','ELNPCACCCIZ0','50','D','10','2',NULL,'Termination Reason',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','3','(''UA''=''T,'')','ELNPCACCCIZ0','50','D','10','3',NULL,'Emp. First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','4','(''UA''=''T,'')','ELNPCACCCIZ0','50','D','10','4',NULL,'Emp. Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddleInit"','5','(''UA''=''T,'')','ELNPCACCCIZ0','50','D','10','5',NULL,'Emp. Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpSsn"','6','(''UA''=''T,'')','ELNPCACCCIZ0','50','D','10','6',NULL,'Emp. SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpGender"','7','(''UA''=''T,'')','ELNPCACCCIZ0','50','D','10','7',NULL,'Emp. Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpDateOfBirth"','8','(''UD101''=''T,'')','ELNPCACCCIZ0','50','D','10','8',NULL,'Emp. DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOccupation"','9','(''UA''=''T,'')','ELNPCACCCIZ0','50','D','10','9',NULL,'Occupation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHoursPerWeek"','10','(''UA''=''T,'')','ELNPCACCCIZ0','50','D','10','10',NULL,'Hrs Per Week',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','11','(''UA''=''T,'')','ELNPCACCCIZ0','50','D','10','11',NULL,'Emp. Addr 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','12','(''UA''=''T,'')','ELNPCACCCIZ0','50','D','10','12',NULL,'Emp. City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','13','(''UA''=''T,'')','ELNPCACCCIZ0','50','D','10','13',NULL,'Emp. State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddresZip"','14','(''UA''=''T,'')','ELNPCACCCIZ0','50','D','10','14',NULL,'Emp. Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneHome"','15','(''UA''=''T,'')','ELNPCACCCIZ0','50','D','10','15',NULL,'Home Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneWork"','16','(''UA''=''T,'')','ELNPCACCCIZ0','50','D','10','16',NULL,'Work Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneWorkExt"','17','(''UA''=''T,'')','ELNPCACCCIZ0','50','D','10','17',NULL,'Work Phone Ext',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpDateOfHire"','18','(''UD101''=''T,'')','ELNPCACCCIZ0','50','D','10','18',NULL,'Date of Hire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpWorkState"','19','(''UA''=''T,'')','ELNPCACCCIZ0','50','D','10','19',NULL,'Emp Work State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpMaritalStatus"','20','(''UA''=''T,'')','ELNPCACCCIZ0','50','D','10','20',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfRehire"','21','(''UD101''=''T,'')','ELNPCACCCIZ0','50','D','10','21',NULL,'Rehire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmailAddress"','22','(''UA''=''T,'')','ELNPCACCCIZ0','50','D','10','22',NULL,'Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCiOrigEffDate"','23','(''UD101''=''T,'')','ELNPCACCCIZ0','50','D','10','23',NULL,'CI Original Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCiEffDateWithLinFin"','24','(''UD101''=''T,'')','ELNPCACCCIZ0','50','D','10','24',NULL,'CI Eff Date with Lincoln Financial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCiPlanCode"','25','(''UA''=''T,'')','ELNPCACCCIZ0','50','D','10','25',NULL,'CI Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCiClassCode"','26','(''UA''=''T,'')','ELNPCACCCIZ0','50','D','10','26',NULL,'CI Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCiCvgAmountEmp"','27','(''UA''=''T,'')','ELNPCACCCIZ0','50','D','10','27',NULL,'CI Cvg Amount Employee',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCiCvgAmountSps"','28','(''UA''=''T,'')','ELNPCACCCIZ0','50','D','10','28',NULL,'CI Cvg Amount Spouse',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCiCvgAmountDep"','29','(''UA''=''T,'')','ELNPCACCCIZ0','50','D','10','29',NULL,'CI Cvg Amount Child',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccClassCode"','30','(''UA''=''T,'')','ELNPCACCCIZ0','50','D','10','30',NULL,'ACC Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccCvgs"','31','(''UA''=''T,'')','ELNPCACCCIZ0','50','D','10','31',NULL,'ACC Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClaimLocNumber"','32','(''UA''=''T,'')','ELNPCACCCIZ0','50','D','10','32',NULL,'Claim Location Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClaimLocName"','33','(''UA''=''T,'')','ELNPCACCCIZ0','50','D','10','33',NULL,'Claim Location Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBillingLocNumber"','34','(''UA''=''T,'')','ELNPCACCCIZ0','50','D','10','34',NULL,'Billing Location Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBillingLocName"','35','(''UA''=''T,'')','ELNPCACCCIZ0','50','D','10','35',NULL,'Billing Location Name',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ELNPCACCCI_20200207.txt',NULL,'','',NULL,NULL,NULL,NULL,'Lincoln Port Acc\CI','202012319','EMPEXPORT','ONDEMAND',NULL,'ELNPCACCCI',NULL,NULL,NULL,'202012319','Dec 29 2019 12:34PM','Dec 29 2019 12:34PM','201701011',NULL,'','','201701011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ELNPCACCCI_20200207.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','202012319','EMPEXPORT','SCHEDULED',NULL,'ELNPCACCCI',NULL,NULL,NULL,'202012319','Dec 29 2019 12:34PM','Dec 29 2019 12:34PM','201701011',NULL,'','','201701011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ELNPCACCCI_20200207.txt',NULL,'','',NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202012319','EMPEXPORT','OEACTIVE',NULL,'ELNPCACCCI',NULL,NULL,NULL,'202012319','Dec 29 2019 12:34PM','Dec 29 2019 12:34PM','201701011',NULL,'','','201701011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ELNPCACCCI_20200207.txt',NULL,'','',NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202012319','EMPEXPORT','OEPASSIVE',NULL,'ELNPCACCCI',NULL,NULL,NULL,'202012319','Dec 29 2019 12:34PM','Dec 29 2019 12:34PM','201701011',NULL,'','','201701011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ELNPCACCCI_20200207.txt',NULL,'','','IAGFG',NULL,NULL,NULL,'Test Purposes Only','202002049','EMPEXPORT','TEST','Feb  4 2020  5:29PM','ELNPCACCCI',NULL,NULL,NULL,'202002049','Feb  4 2020 12:00AM','Dec 30 1899 12:00AM','201701011','20','','','201701011',dbo.fn_GetTimedKey(),NULL,'us3lKiNIS1000',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_ELNPCACCCI_20200207.txt' END WHERE expFormatCode = 'ELNPCACCCI';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELNPCACCCI','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELNPCACCCI','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELNPCACCCI','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELNPCACCCI','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELNPCACCCI','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'ELNPCACCCI' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ELNPCACCCI' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_ELNPCACCCI_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ELNPCACCCI_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ELNPCACCCI','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ELNPCACCCI','D10','dbo.U_ELNPCACCCI_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_ELNPCACCCI') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ELNPCACCCI] (
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
IF OBJECT_ID('U_ELNPCACCCI_Audit') IS NULL
CREATE TABLE [dbo].[U_ELNPCACCCI_Audit] (
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
IF OBJECT_ID('U_ELNPCACCCI_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ELNPCACCCI_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_ELNPCACCCI_DedList') IS NULL
CREATE TABLE [dbo].[U_ELNPCACCCI_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ELNPCACCCI_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ELNPCACCCI_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] char(1) NULL,
    [drvTerminationDate] datetime NULL,
    [drvTerminationReason] varchar(21) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameMiddleInit] varchar(1) NULL,
    [drvEmpSsn] char(11) NULL,
    [drvEmpGender] char(1) NULL,
    [drvEmpDateOfBirth] datetime NULL,
    [drvOccupation] varchar(8000) NULL,
    [drvHoursPerWeek] int NOT NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddresZip] varchar(50) NULL,
    [drvPhoneHome] varchar(12) NULL,
    [drvPhoneWork] varchar(12) NULL,
    [drvPhoneWorkExt] varchar(1) NOT NULL,
    [drvEmpDateOfHire] datetime NULL,
    [drvEmpWorkState] varchar(255) NULL,
    [drvEmpMaritalStatus] char(1) NULL,
    [drvDateOfRehire] datetime NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvCiOrigEffDate] nvarchar(4000) NULL,
    [drvCiEffDateWithLinFin] datetime NULL,
    [drvCiPlanCode] varchar(1) NULL,
    [drvCiClassCode] varchar(1) NULL,
    [drvCiCvgAmountEmp] money NULL,
    [drvCiCvgAmountSps] money NULL,
    [drvCiCvgAmountDep] money NULL,
    [drvAccClassCode] varchar(1) NULL,
    [drvAccCvgs] varchar(6) NULL,
    [drvClaimLocNumber] varchar(1) NOT NULL,
    [drvClaimLocName] varchar(31) NOT NULL,
    [drvBillingLocNumber] varchar(13) NOT NULL,
    [drvBillingLocName] varchar(32) NOT NULL
);
IF OBJECT_ID('U_ELNPCACCCI_EEList') IS NULL
CREATE TABLE [dbo].[U_ELNPCACCCI_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ELNPCACCCI_File') IS NULL
CREATE TABLE [dbo].[U_ELNPCACCCI_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ELNPCACCCI]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: UniCarriers

Created By: James Bender
Business Analyst: Lea King
Create Date: 12/29/2019
Service Request Number: TekP-2019-11-20-0001

Purpose: Lincoln Port Acc\CI

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2019     SR-2019-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ELNPCACCCI';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ELNPCACCCI';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ELNPCACCCI';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ELNPCACCCI';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ELNPCACCCI' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELNPCACCCI', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELNPCACCCI', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELNPCACCCI', 'OEACTIVE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ELNPCACCCI';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ELNPCACCCI', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ELNPCACCCI';

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
    DELETE FROM dbo.U_ELNPCACCCI_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ELNPCACCCI_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_ELNPCACCCI_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ELNPCACCCI_AuditFields;
    CREATE TABLE dbo.U_ELNPCACCCI_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_ELNPCACCCI_AuditFields VALUES ('EmpDed','EedBenOption');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ELNPCACCCI_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ELNPCACCCI_Audit;
    SELECT 
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
    INTO dbo.U_ELNPCACCCI_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_ELNPCACCCI_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ELNPCACCCI_Audit ON dbo.U_ELNPCACCCI_Audit (audEEID,audKey2);

    --================
    -- Changes Only
    --================
    --DELETE FROM dbo.U_ELNPCACCCI_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_ELNPCACCCI_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '286,287,288,289';

    IF OBJECT_ID('U_ELNPCACCCI_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ELNPCACCCI_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ELNPCACCCI_DedList
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
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'UseDedStopDate','Y');

    --
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL,DPC,STC');

    -- Non-Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'TermsOnly','Y'); -- ABC

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

    UPDATE dbo.U_dsi_bdm_ELNPCACCCI
        SET BdmUSGField1 = CONVERT(VARCHAR(20),EedBenAmt)
    FROM dbo.U_dsi_bdm_ELNPCACCCI
    JOIN dbo.EmpDedFull WITH (NOLOCK)
        ON EedEmpDedTVID = BdmUSGField2;

    --==========================================
    -- Build Working Tables
    --==========================================

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ELNPCACCCI_drvTbl
    
    IF OBJECT_ID('U_ELNPCACCCI_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ELNPCACCCI_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = (SELECT TOP 1 EjhFullTimeOrPartTime FROM EmpHJob a WHERE EjhEEID = xEEID AND EjhDateTimeCreated = (SELECT TOP 1 EjhDateTimeCreated FROM EmpHJob a WHERE EjhEEID = xEEID ORDER BY a.EjhDateTimeCreated DESC) ORDER BY a.EjhEEID, a.EjhDateTimeCreated DESC)
        -- standard fields above and additional driver fields below
        ,drvTerminationDate = BdmBenStopDate 
        ,drvTerminationReason = CASE WHEN EecEmplStatus = 'T' AND EecTermReason = '203' THEN 'Deceased'
                                    WHEN EecEmplStatus = 'T' and EecTermReason <> '203' THEN 'Termination'
                                    WHEN EecEmplStatus <> 'T'
                                        AND (SELECT TOP 1 dbnBenStatus FROM DepBPlan WHERE dbnDedCode IN ('286', '287', '288', '289') AND dbnEEID = xEEID ORDER BY DbnBenStatusDate) = 'T'
                                        AND (SELECT TOP 1 EdhChangeReason from EmpHDed a WHERE EdhEEID = xEEID AND EdhCOID = xCOID and EdhEffDate in (SELECT MAX(EdhEffDate) FROM EmpHDed WHERE EdhEEID = xEEID)) IN ('201', '302', 'LEVNT3') THEN 'Dependent Eligibility'                                    
                                    WHEN EecEmplStatus <> 'T'
                                        AND (SELECT TOP 1 dbnBenStatus FROM DepBPlan WHERE dbnDedCode IN ('286', '287', '288', '289') AND dbnEEID = xEEID ORDER BY DbnBenStatusDate) = 'T'
                                        AND (SELECT TOP 1 EdhChangeReason from EmpHDed a WHERE EdhEEID = xEEID AND EdhCOID = xCOID and EdhEffDate in (SELECT MAX(EdhEffDate) FROM EmpHDed WHERE EdhEEID = xEEID)) <> '201' THEN 'Other'                                    
                                END
        ,drvNameFirst = EepNameFirst
        ,drvNameLast = EepNameLast
        ,drvNameMiddleInit = LEFT(EepNameMiddle,1)
        ,drvEmpSsn = eepSSN
        ,drvEmpGender = EepGender
        ,drvEmpDateOfBirth = EepDateOfBirth
        ,drvOccupation = REPLACE(jbcDesc, ',', '')
        ,drvHoursPerWeek = 40
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddresZip = EepAddressZipCode
        ,drvPhoneHome = CASE WHEN ISNULL(EepPhoneHomeNumber, '') <> '' THEN LEFT(EepPhoneHomeNumber,3) + '-' + RIGHT(LEFT(EepPhoneHomeNumber, 6), 3) + '-' + RIGHT(EepPhoneHomeNumber, 4) END
        ,drvPhoneWork = CASE WHEN ISNULL(EecPhoneBusinessNumber, '') <> '' THEN LEFT(EecPhoneBusinessNumber,3) + '-' + RIGHT(LEFT(EecPhoneBusinessNumber, 6), 3) + '-' + RIGHT(EecPhoneBusinessNumber, 4) END
        ,drvPhoneWorkExt = ''
        ,drvEmpDateOfHire = CASE WHEN (SELECT TOP 1 EjhFullTimeOrPartTime FROM EmpHJob a WHERE EjhEEID = xEEID AND EjhDateTimeCreated = (SELECT TOP 1 EjhDateTimeCreated FROM EmpHJob a WHERE EjhEEID = xEEID ORDER BY a.EjhDateTimeCreated DESC) ORDER BY a.EjhEEID, a.EjhDateTimeCreated DESC) = 'P'
                                AND EecFullTimeOrPartTime = 'F' THEN (SELECT audDateTime FROM dbo.U_ELNPCACCCI_Audit WHERE audEEID = xEEID AND audRowNo = 1)
                                ELSE EecDateOfOriginalHire
                            END
        ,drvEmpWorkState = LocAddressState
        ,drvEmpMaritalStatus = eepMaritalStatus
        ,drvDateOfRehire = CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN EecDateOfLastHire END
        ,drvEmailAddress = EepAddressEMail
        ,drvCiOrigEffDate = CASE WHEN DedCode_287 IS NOT NULL OR DedCode_288 IS NOT NULL OR DedCode_289 IS NOT NULL THEN (SELECT FORMAT(MIN(EdhEffDate), 'MM/dd/yyyy') FROM EmpHDed WHERE EdhDedCode IN ('287', '288', '289') AND EdhEEID = xEEID AND EdhCOID = xCOID) END
        ,drvCiEffDateWithLinFin = CASE WHEN DedCode_287 IS NOT NULL OR DedCode_288 IS NOT NULL OR DedCode_289 IS NOT NULL THEN BdmBenStartDate END
        ,drvCiPlanCode = CASE WHEN DedCode_287 IS NOT NULL OR DedCode_288 IS NOT NULL OR DedCode_289 IS NOT NULL THEN '1' END
        ,drvCiClassCode = CASE WHEN DedCode_287 IS NOT NULL OR DedCode_288 IS NOT NULL OR DedCode_289 IS NOT NULL THEN '1' END
        ,drvCiCvgAmountEmp = CASE WHEN DedCode_287 IS NOT NULL THEN B_287_AMT END
        ,drvCiCvgAmountSps = CASE WHEN DedCode_289 IS NOT NULL  THEN B_289_AMT END
        ,drvCiCvgAmountDep = CASE WHEN DedCode_288 IS NOT NULL  THEN B_288_AMT END
        ,drvAccClassCode = CASE WHEN DedCode_286 IS NOT NULL  THEN '1' END
        ,drvAccCvgs =    CASE WHEN DedCode_286 IS NOT NULL AND BenOption_286 IN ('EES', 'EEDP') THEN 'EE+SP' 
                            WHEN DedCode_286 IS NOT NULL AND BenOption_286 IN ('EEC') THEN 'EE+CH'
                            WHEN DedCode_286 IS NOT NULL AND BenOption_286 IN ('EEF', 'EEDPF') THEN 'EE+FAM' 
                            WHEN DedCode_286 IS NOT NULL AND BenOption_286 IN ('EE') THEN 'EE'
                        END
        ,drvClaimLocNumber = ''
        ,drvClaimLocName = 'Uncarriers Americas Corporation'
        ,drvBillingLocNumber = 'B000000000330'
        ,drvBillingLocName = 'UniCarriers Americas Corporation'
    INTO dbo.U_ELNPCACCCI_drvTbl
    FROM dbo.U_ELNPCACCCI_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN (    SELECT BdmEEID, BdmCOID
                ,MAX(CASE WHEN BdmDedCode ='286' THEN '286' END) AS DedCode_286
                ,MAX(CASE WHEN BdmDedCode ='286' THEN BdmBenOption END) AS BenOption_286
                ,MAX(CASE WHEN BdmDedCode ='287' THEN '287' END) AS DedCode_287
                ,MAX(CASE WHEN BdmDedCode ='288' THEN '288' END) AS DedCode_288
                ,MAX(CASE WHEN BdmDedCode ='289' THEN '289' END) AS DedCode_289
                ,MAX(CASE WHEN BdmDedCode IN ('286', '287', '288','289') THEN BdmBenStopDate END) AS BdmBenStopDate
                ,MAX(CASE WHEN BdmDedCode IN ('286', '287', '288','289') THEN BdmBenStartDate END) AS BdmBenStartDate
            FROM dbo.U_dsi_BDM_ELNPCACCCI WITH (NOLOCK)
            GROUP BY BdmEEID, BdmCOID) as Bdm_Consolidated
        ON BdmEEID = xEEID
        AND BdmCOID = xCOID

    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    JOIN (    SELECT EedEEID
                ,B_287_AMT = MAX(CASE WHEN EedDedCode = '287' THEN EedBenAmt ELSE NUll END)
                ,B_288_AMT = MAX(CASE WHEN EedDedCode = '288' THEN EedBenAmt ELSE NUll END)
                ,B_289_AMT = MAX(CASE WHEN EedDedCode = '289' THEN EedBenAmt ELSE NUll END)
            FROM dbo.EmpDed WITH (NOLOCK)
            Group By EedEEID) AS EmpDed_Amounts
        ON EedEEID = xEEID
    LEFT JOIN (
                SELECT EdhEEID, EdhCoID, EdhDedCode, EdhChangeReason
                FROM (
                        SELECT EdhEEID
                            ,EdhCoID
                            ,EdhDedCode
                            ,EdhChangeReason
                            ,row_number() OVER (PARTITION BY EdhEEID, EdhCoID, EdhDedCode ORDER BY EdhEffDate DESC) AS RN
                    FROM EmpHDed
                    WHERE EdhDedCode IN ('286', '287', '288', '289')) AS T
            WHERE RN = 1 ) AS Change_Reasons
        ON EdhEEId = xEEID
        AND EdhCoId = xCOID
        --AND EdhDedCode = BdmDedCode
    WHERE EdhChangeReason <> 'OE'
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
ALTER VIEW dbo.dsi_vwELNPCACCCI_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ELNPCACCCI_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ELNPCACCCI%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201701011'
       ,expStartPerControl     = '201701011'
       ,expLastEndPerControl   = '202012319'
       ,expEndPerControl       = '202012319'
WHERE expFormatCode = 'ELNPCACCCI';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwELNPCACCCI_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ELNPCACCCI_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort