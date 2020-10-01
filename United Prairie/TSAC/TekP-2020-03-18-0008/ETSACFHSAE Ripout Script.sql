SET NOCOUNT ON;
IF OBJECT_ID('U_ETSACFHSAE_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ETSACFHSAE_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ETSACFHSAE_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ETSACFHSAE' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwETSACFHSAE_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwETSACFHSAE_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ETSACFHSAE') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ETSACFHSAE];
GO
IF OBJECT_ID('U_ETSACFHSAE_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ETSACFHSAE_SavePath];
GO
IF OBJECT_ID('U_ETSACFHSAE_File') IS NOT NULL DROP TABLE [dbo].[U_ETSACFHSAE_File];
GO
IF OBJECT_ID('U_ETSACFHSAE_EEList') IS NOT NULL DROP TABLE [dbo].[U_ETSACFHSAE_EEList];
GO
IF OBJECT_ID('U_ETSACFHSAE_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ETSACFHSAE_drvTbl];
GO
IF OBJECT_ID('U_ETSACFHSAE_DedList') IS NOT NULL DROP TABLE [dbo].[U_ETSACFHSAE_DedList];
GO
IF OBJECT_ID('U_ETSACFHSAE_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ETSACFHSAE_AuditFields];
GO
IF OBJECT_ID('U_ETSACFHSAE_Audit') IS NOT NULL DROP TABLE [dbo].[U_ETSACFHSAE_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_ETSACFHSAE') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ETSACFHSAE];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ETSACFHSAE';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ETSACFHSAE';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ETSACFHSAE';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ETSACFHSAE';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ETSACFHSAE';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ETSACFHSAE','TASC FSA/HSA Census','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','ETSACFHSAEZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Client TASC ID"','1','(''DA''=''T,'')','ETSACFHSAEZ0','50','H','01','1',NULL,'Client TASC ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Individual TASC ID"','2','(''DA''=''T,'')','ETSACFHSAEZ0','50','H','01','2',NULL,'Individual TASC ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee ID"','3','(''DA''=''T,'')','ETSACFHSAEZ0','50','H','01','3',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last Name"','4','(''DA''=''T,'')','ETSACFHSAEZ0','50','H','01','4',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Name"','5','(''DA''=''T,'')','ETSACFHSAEZ0','50','H','01','5',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Middle Name"','6','(''DA''=''T,'')','ETSACFHSAEZ0','50','H','01','6',NULL,'Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Nickname"','7','(''DA''=''T,'')','ETSACFHSAEZ0','50','H','01','7',NULL,'Nickname',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Email Address"','8','(''DA''=''T,'')','ETSACFHSAEZ0','50','H','01','8',NULL,'Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address Line 1"','9','(''DA''=''T,'')','ETSACFHSAEZ0','50','H','01','9',NULL,'Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address Line 2"','10','(''DA''=''T,'')','ETSACFHSAEZ0','50','H','01','10',NULL,'Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"City"','11','(''DA''=''T,'')','ETSACFHSAEZ0','50','H','01','11',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"State"','12','(''DA''=''T,'')','ETSACFHSAEZ0','50','H','01','12',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Zip / Postal Code"','13','(''DA''=''T,'')','ETSACFHSAEZ0','50','H','01','13',NULL,'Zip / Postal Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Zip plus four"','14','(''DA''=''T,'')','ETSACFHSAEZ0','50','H','01','14',NULL,'Zip plus four',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Country"','15','(''DA''=''T,'')','ETSACFHSAEZ0','50','H','01','15',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address Type"','16','(''DA''=''T,'')','ETSACFHSAEZ0','50','H','01','16',NULL,'Address Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Phone Number"','17','(''DA''=''T,'')','ETSACFHSAEZ0','50','H','01','17',NULL,'Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Phone Type"','18','(''DA''=''T,'')','ETSACFHSAEZ0','50','H','01','18',NULL,'Phone Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Phone Number 2"','19','(''DA''=''T,'')','ETSACFHSAEZ0','50','H','01','19',NULL,'Phone Number 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Phone Type 2"','20','(''DA''=''T,'')','ETSACFHSAEZ0','50','H','01','20',NULL,'Phone Type 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Birth"','21','(''DA''=''T,'')','ETSACFHSAEZ0','50','H','01','21',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Death"','22','(''DA''=''T,'')','ETSACFHSAEZ0','50','H','01','22',NULL,'Date of Death',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Gender"','23','(''DA''=''T,'')','ETSACFHSAEZ0','50','H','01','23',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hire Date"','24','(''DA''=''T,'')','ETSACFHSAEZ0','50','H','01','24',NULL,'Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Payroll Schedule Name"','25','(''DA''=''T,'')','ETSACFHSAEZ0','50','H','01','25',NULL,'Payroll Schedule Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Division"','26','(''DA''=''T,'')','ETSACFHSAEZ0','50','H','01','26',NULL,'Division',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Subdivision"','27','(''DA''=''T,'')','ETSACFHSAEZ0','50','H','01','27',NULL,'Subdivision',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Class"','28','(''DA''=''T,'')','ETSACFHSAEZ0','50','H','01','28',NULL,'Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employment Termination Date"','29','(''DA''=''T,'')','ETSACFHSAEZ0','50','H','01','29',NULL,'Employment Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Retired"','30','(''DA''=''T,'')','ETSACFHSAEZ0','50','H','01','30',NULL,'Retired',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LOA Start Date"','31','(''DA''=''T,'')','ETSACFHSAEZ0','50','H','01','31',NULL,'LOA Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LOA End Date"','32','(''DA''=''T,'')','ETSACFHSAEZ0','50','H','01','32',NULL,'LOA End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LOA With Benefits"','33','(''DA''=''T,'')','ETSACFHSAEZ0','50','H','01','33',NULL,'LOA With Benefits',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Health Plan Member ID"','34','(''DA''=''T,'')','ETSACFHSAEZ0','50','H','01','34',NULL,'Health Plan Member ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HDHP Start Date"','35','(''DA''=''T,'')','ETSACFHSAEZ0','50','H','01','35',NULL,'HDHP Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HDHP End Date"','36','(''DA''=''T)','ETSACFHSAEZ0','50','H','01','36',NULL,'HDHP End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"4900-0875-8130"','1','(''DA''=''T,'')','ETSACFHSAEZ0','50','D','10','1',NULL,'Client TASC ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','2','(''DA''=''T,'')','ETSACFHSAEZ0','50','D','10','2',NULL,'Individual TASC ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','3','(''UA''=''T,'')','ETSACFHSAEZ0','50','D','10','3',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','4','(''UA''=''T,'')','ETSACFHSAEZ0','50','D','10','4',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','5','(''UA''=''T,'')','ETSACFHSAEZ0','50','D','10','5',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','6','(''UA''=''T,'')','ETSACFHSAEZ0','50','D','10','6',NULL,'Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','7','(''DA''=''T,'')','ETSACFHSAEZ0','50','D','10','7',NULL,'Nickname',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressEmail"','8','(''UA''=''T,'')','ETSACFHSAEZ0','50','D','10','8',NULL,'Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','9','(''UA''=''T,'')','ETSACFHSAEZ0','50','D','10','9',NULL,'Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','10','(''UA''=''T,'')','ETSACFHSAEZ0','50','D','10','10',NULL,'Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','11','(''UA''=''T,'')','ETSACFHSAEZ0','50','D','10','11',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','12','(''UA''=''T,'')','ETSACFHSAEZ0','50','D','10','12',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','13','(''UA''=''T,'')','ETSACFHSAEZ0','50','D','10','13',NULL,'Zip / Postal Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','14','(''DA''=''T,'')','ETSACFHSAEZ0','50','D','10','14',NULL,'Zip plus four',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"US"','15','(''DA''=''T,'')','ETSACFHSAEZ0','50','D','10','15',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Primary"','16','(''DA''=''T,'')','ETSACFHSAEZ0','50','D','10','16',NULL,'Address Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneNumberHome"','17','(''UA''=''T,'')','ETSACFHSAEZ0','50','D','10','17',NULL,'Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneType"','18','(''UA''=''T,'')','ETSACFHSAEZ0','50','D','10','18',NULL,'Phone Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','19','(''DA''=''T,'')','ETSACFHSAEZ0','50','D','10','19',NULL,'Phone Number 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','20','(''DA''=''T,'')','ETSACFHSAEZ0','50','D','10','20',NULL,'Phone Type 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','21','(''UD101''=''T,'')','ETSACFHSAEZ0','50','D','10','21',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfDeath"','22','(''UD101''=''T,'')','ETSACFHSAEZ0','50','D','10','22',NULL,'Date of Death',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','23','(''UA''=''T,'')','ETSACFHSAEZ0','50','D','10','23',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHireDate"','24','(''UD101''=''T,'')','ETSACFHSAEZ0','50','D','10','24',NULL,'Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Bi-Weekly 26"','25','(''DA''=''T,'')','ETSACFHSAEZ0','50','D','10','25',NULL,'Payroll Schedule Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','26','(''DA''=''T,'')','ETSACFHSAEZ0','50','D','10','26',NULL,'Division',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','27','(''DA''=''T,'')','ETSACFHSAEZ0','50','D','10','27',NULL,'Subdivision',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','28','(''DA''=''T,'')','ETSACFHSAEZ0','50','D','10','28',NULL,'Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeTermDate"','29','(''UD101''=''T,'')','ETSACFHSAEZ0','50','D','10','29',NULL,'Employment Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRetired"','30','(''UA''=''T,'')','ETSACFHSAEZ0','50','D','10','30',NULL,'Retired',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoaStartDate"','31','(''UD101''=''T,'')','ETSACFHSAEZ0','50','D','10','31',NULL,'LOA Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoaEndDate"','32','(''UD101''=''T,'')','ETSACFHSAEZ0','50','D','10','32',NULL,'LOA End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoaWithBenefits"','33','(''UA''=''T,'')','ETSACFHSAEZ0','50','D','10','33',NULL,'LOA With Benefits',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','34','(''DA''=''T,'')','ETSACFHSAEZ0','50','D','10','34',NULL,'Health Plan Member ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','35','(''DA''=''T,'')','ETSACFHSAEZ0','50','D','10','35',NULL,'HDHP Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','36','(''DA''=''T,'')','ETSACFHSAEZ0','50','D','10','36',NULL,'HDHP End Date',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ETSACFHSAE_20200924.txt',NULL,'','','',NULL,NULL,NULL,'TASC FSA/HAS Enrollment','202006109','EMPEXPORT','ONDEMAND','Jun 11 2020 11:20AM','ETSACFHSAE',NULL,NULL,NULL,'202006109','Jun 10 2020 12:15PM','Jun 10 2020 12:15PM','202006101','140','','','202006101',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ETSACFHSAE_20200924.txt',NULL,'','','',NULL,NULL,NULL,'Scheduled Session','202006109','EMPEXPORT','SCHEDULED','Jun 11 2020 11:21AM','ETSACFHSAE',NULL,NULL,NULL,'202006109','Jun 10 2020 12:15PM','Jun 10 2020 12:15PM','202006101','140','','','202006101',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ETSACFHSAE_20200924.txt',NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','202006109','EMPEXPORT','OEACTIVE','Jun 11 2020 11:20AM','ETSACFHSAE',NULL,NULL,NULL,'202006109','Jun 10 2020 12:15PM','Jun 10 2020 12:15PM','202006101','2','','','202006101',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ETSACFHSAE_20200924.txt',NULL,'','','',NULL,NULL,NULL,'Passive Open Enrollment Export','202006109','EMPEXPORT','OEPASSIVE','Jun 11 2020 11:20AM','ETSACFHSAE',NULL,NULL,NULL,'202006109','Jun 10 2020 12:15PM','Jun 10 2020 12:15PM','202006101','139','','','202006101',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ETSACFHSAE_20200924.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202009229','EMPEXPORT','TEST','Sep 22 2020  4:08PM','ETSACFHSAE',NULL,NULL,NULL,'202009229','Sep 22 2020 12:00AM','Dec 30 1899 12:00AM','202009081','140','','','202009081',dbo.fn_GetTimedKey(),NULL,'us3lKiUNI1088',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_ETSACFHSAE_20200924.txt' END WHERE expFormatCode = 'ETSACFHSAE';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETSACFHSAE','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETSACFHSAE','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETSACFHSAE','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETSACFHSAE','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETSACFHSAE','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'ETSACFHSAE' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ETSACFHSAE' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_ETSACFHSAE_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ETSACFHSAE_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ETSACFHSAE','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ETSACFHSAE','D10','dbo.U_ETSACFHSAE_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_ETSACFHSAE') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ETSACFHSAE] (
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
IF OBJECT_ID('U_ETSACFHSAE_Audit') IS NULL
CREATE TABLE [dbo].[U_ETSACFHSAE_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audCOID] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] varchar(2000) NULL,
    [audNewValue] varchar(2000) NULL,
    [audRowNo] bigint NULL
);
IF OBJECT_ID('U_ETSACFHSAE_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ETSACFHSAE_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_ETSACFHSAE_DedList') IS NULL
CREATE TABLE [dbo].[U_ETSACFHSAE_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ETSACFHSAE_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ETSACFHSAE_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvAddressEmail] varchar(50) NULL,
    [drvAddressLine1] varchar(8000) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(5) NULL,
    [drvPhoneNumberHome] varchar(12) NULL,
    [drvPhoneType] varchar(4) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvDateOfDeath] datetime NULL,
    [drvGender] varchar(7) NOT NULL,
    [drvHireDate] datetime NULL,
    [drvEmployeeTermDate] datetime NULL,
    [drvRetired] varchar(1) NOT NULL,
    [drvLoaStartDate] datetime NULL,
    [drvLoaEndDate] datetime NULL,
    [drvLoaWithBenefits] varchar(1) NULL
);
IF OBJECT_ID('U_ETSACFHSAE_EEList') IS NULL
CREATE TABLE [dbo].[U_ETSACFHSAE_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ETSACFHSAE_File') IS NULL
CREATE TABLE [dbo].[U_ETSACFHSAE_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
IF OBJECT_ID('U_ETSACFHSAE_SavePath') IS NULL
CREATE TABLE [dbo].[U_ETSACFHSAE_SavePath] (
    [svFormatCode] char(10) NOT NULL,
    [svCfgName] varchar(32) NOT NULL,
    [svCfgValue] varchar(100) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ETSACFHSAE]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: United Prairie

Created By: James Bender
Business Analyst: Lea King
Create Date: 06/10/2020
Service Request Number: TekP-2020-03-18-0007

Purpose: TASC FSA/HAS Enrollment

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ETSACFHSAE';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ETSACFHSAE';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ETSACFHSAE';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ETSACFHSAE';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ETSACFHSAE' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETSACFHSAE', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETSACFHSAE', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETSACFHSAE', 'OEACTIVE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ETSACFHSAE';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ETSACFHSAE', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ETSACFHSAE';

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
    DELETE FROM dbo.U_ETSACFHSAE_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ETSACFHSAE_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_ETSACFHSAE_EEList
    WHERE xEEID IN (SELECT EecEEID FROM dbo.EmpComp WITH(NOLOCK) WHERE EecEEType = 'TES' );


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_ETSACFHSAE_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ETSACFHSAE_AuditFields;
    CREATE TABLE dbo.U_ETSACFHSAE_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    --INSERT INTO dbo.U_ETSACFHSAE_AuditFields VALUES ('EmpHStat','EshEmplStatus');
    INSERT INTO dbo.U_ETSACFHSAE_AuditFields VALUES ('EmpComp','EecEmplStatus');


    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ETSACFHSAE_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ETSACFHSAE_Audit;
    SELECT 
        audEEID  = audKey1Value
        ,audCOID = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    INTO dbo.U_ETSACFHSAE_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_ETSACFHSAE_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ETSACFHSAE_Audit ON dbo.U_ETSACFHSAE_Audit (audEEID,audCOID);




    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '461,450,451,452,442, 443, 444, 447, 448, 596, 597';

    IF OBJECT_ID('U_ETSACFHSAE_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ETSACFHSAE_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ETSACFHSAE_DedList
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
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ETSACFHSAE_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ETSACFHSAE_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ETSACFHSAE_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '' --EecEmplStatus + ' :: ' + ISNULL(EecTermReason, 'nope')
        -- standard fields above and additional driver fields below
        ,drvSSN = EepSSN -- LEFT(EepSSN, 3) + '-' + RIGHT(LEFT(EepSSN, 5), 2) + '-' + RIGHT(REPLACE(EepSSN, ' ', ''), 4)
        ,drvNameLast = EepNameLast
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvAddressEmail = EepAddressEMail
        ,drvAddressLine1 = REPLACE(EepAddressLine1, ',', '')
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = LEFT(EepAddressZipCode, 5)
        ,drvPhoneNumberHome = CASE WHEN ISNULL(EepPhoneHomeNumber, '') <> '' THEN LEFT(EepPhoneHomeNumber, 3) + '-' + RIGHT(LEFT(EepPhoneHomeNumber, 6), 3) + '-' + RIGHT(EepPhoneHomeNumber, 4) END
        ,drvPhoneType = CASE WHEN ISNULL(EepPhoneHomeNumber, '') <> ''  THEN 'Home' END
        ,drvDateOfBirth = EepDateOfBirth
        ,drvDateOfDeath = CASE WHEN EecTermReason = '203' THEN EecDateOfTermination END
        ,drvGender =    CASE EepGender
                            WHEN 'M' THEN 'Male'
                            WHEN 'F' THEN 'Female'
                            ELSE 'Unknown'
                        END
        ,drvHireDate = EecDateOfLastHire
        ,drvEmployeeTermDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvRetired =    CASE WHEN EecEmplStatus = 'T' AND EecTermReason = '202' THEN 'Y' 
                            WHEN EecEmplStatus = 'T' AND EecTermReason <> '202' THEN 'N'
                            ELSE ''                                                     
                        END
        ,drvLoaStartDate = CASE WHEN EecEmplStatus = 'L' THEN EecEmplStatusStartDate END
        ,drvLoaEndDate = CASE WHEN EecEmplStatus = 'A' AND audOldValue = 'L' THEN audDateTime END
        ,drvLoaWithBenefits = CASE WHEN EecEmplStatus = 'L' THEN 'Y' END
    INTO dbo.U_ETSACFHSAE_drvTbl
    FROM dbo.U_ETSACFHSAE_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ETSACFHSAE WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.U_ETSACFHSAE_Audit WITH (NOLOCK)
        ON audEEID = xEEID
        AND audCOID = xCOID
    WHERE EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND EecDateOfTermination > DATEADD(DAY, -30, @EndDate))
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
ALTER VIEW dbo.dsi_vwETSACFHSAE_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ETSACFHSAE_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ETSACFHSAE%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202001031'
       ,expStartPerControl     = '202001031'
       ,expLastEndPerControl   = '202006109'
       ,expEndPerControl       = '202006109'
WHERE expFormatCode = 'ETSACFHSAE';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwETSACFHSAE_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ETSACFHSAE_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort