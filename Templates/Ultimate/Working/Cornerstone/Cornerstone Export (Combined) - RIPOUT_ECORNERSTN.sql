/*
Directions:
1) Find and replace each of the text below with the applicable information.
       E.g. Replace the text "@DeveloperName" (excluding quotes) with "John Doe"
2) Deploy this to client environment!

-- Integration parameters
@CustomerName - Replace with customer name
@DeveloperName - Replace with TC name
@IntegrationAnalystName - Replace with BA/IC name
@CreateDate - Replace with date of creation
@SRNumber - Replace with SR number
@CustomFormatCode - Replace with Format Code (i.e., ECORNERSTN)
@CustomFormatName - Replace with Name of Interface (AdfFormatName) (i.e., Cornerstone Exports)
@IsWebFlag - Replace with 'Y' (Yes) or 'N' (No) for Web Interface Settings

-- File parameters
@FileExportPath - Replace with the Export Path (i.e., \\us.saas\e1\Public\[Client ARNum]\Exports\[Vendor]\)
@FileTestPath - Replace with the Test Path (i.e., \\us.saas\e1\Public\[Client ARNum]\Exports\[Vendor]\)
@FileUDESPath - Replace with the UDES Path (i.e., \\us.saas\e1\Public\[Client ARNum]\Exports\[Vendor]\)

*/
IF OBJECT_ID('dsi_vw@CustomFormatCode_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vw@CustomFormatCode_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_@CustomFormatCode') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_@CustomFormatCode];
GO
IF OBJECT_ID('U_@CustomFormatCode_USR') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_USR];
GO
IF OBJECT_ID('U_@CustomFormatCode_LOC') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_LOC];
GO
IF OBJECT_ID('U_@CustomFormatCode_File') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_File];
GO
IF OBJECT_ID('U_@CustomFormatCode_EEList') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_EEList];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl];
GO
IF OBJECT_ID('U_@CustomFormatCode_DPG') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_DPG];
GO
IF OBJECT_ID('U_@CustomFormatCode_CC') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_CC];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = '@CustomFormatCode';
DELETE [dbo].[U_dsi_RecordSetDetails] FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode = '@CustomFormatCode';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = '@CustomFormatCode';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = '@CustomFormatCode';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = '@CustomFormatCode';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = '@CustomFormatCode';
GO

DECLARE @AdhSystemID VARCHAR(12), @FixedFormatName VARCHAR(50);
SET @AdhSystemID = LEFT('@CustomFormatCode' + REPLICATE('0',10),10) + 'Z0';
SET @FixedFormatName = LEFT('@CustomFormatName',50);

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCreateTClockBatches,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhRespectZeroPayRate,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhThirdPartyPay) SELECT 'N','C','Y','0','',NULL,'','N','','N','','013010','EMPEXPORT','CDE','@CustomFormatCode','Cornerstone Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','6000','N','S','N',@AdhSystemID,'N','Jan  1 1900 12:00AM','C','N';
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"OU ID"','1','(''DA''=''TT'')',@AdhSystemID,'50','H','01','1',NULL,'OU ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"OU Name"','2','(''DA''=''TT'')',@AdhSystemID,'50','H','01','2',NULL,'OU Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Parent ID"','3','(''DA''=''TT'')',@AdhSystemID,'50','H','01','3',NULL,'Parent ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Owner ID"','4','(''DA''=''TT'')',@AdhSystemID,'50','H','01','4',NULL,'Owner ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Description"','5','(''DA''=''TT'')',@AdhSystemID,'50','H','01','5',NULL,'Description',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Active"','6','(''DA''=''TT'')',@AdhSystemID,'50','H','01','6',NULL,'Active',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Allow Reconciliation"','7','(''DA''=''T'')',@AdhSystemID,'50','H','01','7',NULL,'Allow Reconciliation',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"OU ID"','1','(''DA''=''TT'')',@AdhSystemID,'50','H','02','1',NULL,'OU ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"OU Name"','2','(''DA''=''TT'')',@AdhSystemID,'50','H','02','2',NULL,'OU Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Parent ID"','3','(''DA''=''TT'')',@AdhSystemID,'50','H','02','3',NULL,'Parent ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Owner ID"','4','(''DA''=''TT'')',@AdhSystemID,'50','H','02','4',NULL,'Owner ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Approver ID"','5','(''DA''=''TT'')',@AdhSystemID,'50','H','02','5',NULL,'Approver ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Description"','6','(''DA''=''TT'')',@AdhSystemID,'50','H','02','6',NULL,'Description',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Active"','7','(''DA''=''TT'')',@AdhSystemID,'50','H','02','7',NULL,'Active',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Allow Reconciliation"','8','(''DA''=''T'')',@AdhSystemID,'50','H','02','8',NULL,'Allow Reconciliation',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"OU ID"','1','(''DA''=''TT'')',@AdhSystemID,'50','H','03','1',NULL,'OU ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"OU Name"','2','(''DA''=''TT'')',@AdhSystemID,'50','H','03','2',NULL,'OU Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Parent ID"','3','(''DA''=''TT'')',@AdhSystemID,'50','H','03','3',NULL,'Parent ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Owner ID"','4','(''DA''=''TT'')',@AdhSystemID,'50','H','03','4',NULL,'Owner ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Description"','5','(''DA''=''TT'')',@AdhSystemID,'50','H','03','5',NULL,'Description',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Active"','6','(''DA''=''TT'')',@AdhSystemID,'50','H','03','6',NULL,'Active',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Allow Reconciliation"','7','(''DA''=''TT'')',@AdhSystemID,'50','H','03','7',NULL,'Allow Reconciliation',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Facility Type"','8','(''DA''=''TT'')',@AdhSystemID,'50','H','03','8',NULL,'Facility Type',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Country"','9','(''DA''=''TT'')',@AdhSystemID,'50','H','03','9',NULL,'Country',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Time Zone"','10','(''DA''=''TT'')',@AdhSystemID,'50','H','03','10',NULL,'Time Zone',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Address #1"','11','(''DA''=''TT'')',@AdhSystemID,'50','H','03','11',NULL,'Address #1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Address #2"','12','(''DA''=''TT'')',@AdhSystemID,'50','H','03','12',NULL,'Address #2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"City"','13','(''DA''=''TT'')',@AdhSystemID,'50','H','03','13',NULL,'City',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"State/Province"','14','(''DA''=''TT'')',@AdhSystemID,'50','H','03','14',NULL,'State/Province',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Postal Code"','15','(''DA''=''TT'')',@AdhSystemID,'50','H','03','15',NULL,'Postal Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Contact"','16','(''DA''=''TT'')',@AdhSystemID,'50','H','03','16',NULL,'Contact',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Phone"','17','(''DA''=''TT'')',@AdhSystemID,'50','H','03','17',NULL,'Phone',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Fax"','18','(''DA''=''TT'')',@AdhSystemID,'50','H','03','18',NULL,'Fax',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Email"','19','(''DA''=''TT'')',@AdhSystemID,'50','H','03','19',NULL,'Email',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Occupancy"','20','(''DA''=''TT'')',@AdhSystemID,'50','H','03','20',NULL,'Occupancy',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Approval Required"','21','(''DA''=''TT'')',@AdhSystemID,'50','H','03','21',NULL,'Approval Required',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"On Site"','22','(''DA''=''T'')',@AdhSystemID,'50','H','03','22',NULL,'On Site',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"User ID"','1','(''DA''=''TT'')',@AdhSystemID,'50','H','04','1',NULL,'User ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Local System ID"','2','(''DA''=''TT'')',@AdhSystemID,'50','H','04','2',NULL,'Local System ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Username"','3','(''DA''=''TT'')',@AdhSystemID,'50','H','04','3',NULL,'Username',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Active"','4','(''DA''=''TT'')',@AdhSystemID,'50','H','04','4',NULL,'Active',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Absent"','5','(''DA''=''TT'')',@AdhSystemID,'50','H','04','5',NULL,'Absent',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Allow Reconciliation"','6','(''DA''=''TT'')',@AdhSystemID,'50','H','04','6',NULL,'Allow Reconciliation',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Prefix"','7','(''DA''=''TT'')',@AdhSystemID,'50','H','04','7',NULL,'Prefix',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"First Name"','8','(''DA''=''TT'')',@AdhSystemID,'50','H','04','8',NULL,'First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Middle Name"','9','(''DA''=''TT'')',@AdhSystemID,'50','H','04','9',NULL,'Middle Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Last Name"','10','(''DA''=''TT'')',@AdhSystemID,'50','H','04','10',NULL,'Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Suffix"','11','(''DA''=''TT'')',@AdhSystemID,'50','H','04','11',NULL,'Suffix',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Email"','12','(''DA''=''TT'')',@AdhSystemID,'50','H','04','12',NULL,'Email',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Work Phone"','13','(''DA''=''TT'')',@AdhSystemID,'50','H','04','13',NULL,'Work Phone',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Home Phone"','14','(''DA''=''TT'')',@AdhSystemID,'50','H','04','14',NULL,'Home Phone',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Mobile Phone"','15','(''DA''=''TT'')',@AdhSystemID,'50','H','04','15',NULL,'Mobile Phone',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Fax"','16','(''DA''=''TT'')',@AdhSystemID,'50','H','04','16',NULL,'Fax',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Country Code"','17','(''DA''=''TT'')',@AdhSystemID,'50','H','04','17',NULL,'Country Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Line 1"','18','(''DA''=''TT'')',@AdhSystemID,'50','H','04','18',NULL,'Line 1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Line 2"','19','(''DA''=''TT'')',@AdhSystemID,'50','H','04','19',NULL,'Line 2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Mail Stop"','20','(''DA''=''TT'')',@AdhSystemID,'50','H','04','20',NULL,'Mail Stop',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"City"','21','(''DA''=''TT'')',@AdhSystemID,'50','H','04','21',NULL,'City',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"State/Province"','22','(''DA''=''TT'')',@AdhSystemID,'50','H','04','22',NULL,'State/Province',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Postal Code"','23','(''DA''=''TT'')',@AdhSystemID,'50','H','04','23',NULL,'Postal Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Division ID"','24','(''DA''=''TT'')',@AdhSystemID,'50','H','04','24',NULL,'Division ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Location ID"','25','(''DA''=''TT'')',@AdhSystemID,'50','H','04','25',NULL,'Location ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Position ID"','26','(''DA''=''TT'')',@AdhSystemID,'50','H','04','26',NULL,'Position ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Cost Center ID"','27','(''DA''=''TT'')',@AdhSystemID,'50','H','04','27',NULL,'Cost Center ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Grade ID"','28','(''DA''=''TT'')',@AdhSystemID,'50','H','04','28',NULL,'Grade ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Last Hire Date"','29','(''DA''=''TT'')',@AdhSystemID,'50','H','04','29',NULL,'Last Hire Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Original Hire Date"','30','(''DA''=''TT'')',@AdhSystemID,'50','H','04','30',NULL,'Original Hire Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Required Approvals"','31','(''DA''=''TT'')',@AdhSystemID,'50','H','04','31',NULL,'Required Approvals',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Approver ID"','32','(''DA''=''TT'')',@AdhSystemID,'50','H','04','32',NULL,'Approver ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Manager ID"','33','(''DA''=''TT'')',@AdhSystemID,'50','H','04','33',NULL,'Manager ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Gender"','34','(''DA''=''TT'')',@AdhSystemID,'50','H','04','34',NULL,'Gender',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Ethnicity"','35','(''DA''=''TT'')',@AdhSystemID,'50','H','04','35',NULL,'Ethnicity',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Language"','36','(''DA''=''TT'')',@AdhSystemID,'50','H','04','36',NULL,'Language',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Time Zone"','37','(''DA''=''TT'')',@AdhSystemID,'50','H','04','37',NULL,'Time Zone',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Compensation Currency"','38','(''DA''=''TT'')',@AdhSystemID,'50','H','04','38',NULL,'Compensation Currency',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Exempt"','39','(''DA''=''TT'')',@AdhSystemID,'50','H','04','39',NULL,'Exempt',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Status"','40','(''DA''=''TT'')',@AdhSystemID,'50','H','04','40',NULL,'Status',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Custom OU 1 ID"','41','(''DA''=''TT'')',@AdhSystemID,'50','H','04','41',NULL,'Custom OU 1 ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Custom OU 1 ID"','42','(''DA''=''TT'')',@AdhSystemID,'50','H','04','42',NULL,'Custom OU 1 ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Custom OU 3 ID"','43','(''DA''=''TT'')',@AdhSystemID,'50','H','04','43',NULL,'Custom OU 3 ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Custom OU 4 ID"','44','(''DA''=''TT'')',@AdhSystemID,'50','H','04','44',NULL,'Custom OU 4 ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Custom OU 5 ID"','45','(''DA''=''T'')',@AdhSystemID,'50','H','04','45',NULL,'Custom OU 5 ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvOUID"','1','(''UA''=''TT'')',@AdhSystemID,'50','D','10','1',NULL,'OU ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvOUName"','2','(''UA''=''TT'')',@AdhSystemID,'50','D','10','2',NULL,'OU Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvParentID"','3','(''UA''=''TT'')',@AdhSystemID,'50','D','10','3',NULL,'Parent ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvOwnerID"','4','(''UA''=''TT'')',@AdhSystemID,'50','D','10','4',NULL,'Owner ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDescription"','5','(''UA''=''TT'')',@AdhSystemID,'50','D','10','5',NULL,'Description',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvActive"','6','(''UA''=''TT'')',@AdhSystemID,'50','D','10','6',NULL,'Active',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAllowReconciliation"','7','(''UA''=''T'')',@AdhSystemID,'50','D','10','7',NULL,'Allow Reconciliation',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvOUID"','1','(''UA''=''TT'')',@AdhSystemID,'50','D','20','1',NULL,'OU ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvOUName"','2','(''UA''=''TT'')',@AdhSystemID,'50','D','20','2',NULL,'OU Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvParentID"','3','(''UA''=''TT'')',@AdhSystemID,'50','D','20','3',NULL,'Parent ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvOwnerID"','4','(''UA''=''TT'')',@AdhSystemID,'50','D','20','4',NULL,'Owner ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvApproverID"','5','(''UA''=''TT'')',@AdhSystemID,'50','D','20','5',NULL,'Approver ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDescription"','6','(''UA''=''TT'')',@AdhSystemID,'50','D','20','6',NULL,'Description',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvActive"','7','(''UA''=''TT'')',@AdhSystemID,'50','D','20','7',NULL,'Active',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAllowReconciliation"','8','(''UA''=''T'')',@AdhSystemID,'50','D','20','8',NULL,'Allow Reconciliation',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvOUID"','1','(''UA''=''TT'')',@AdhSystemID,'50','D','30','1',NULL,'OU ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvOUName"','2','(''UA''=''TT'')',@AdhSystemID,'50','D','30','2',NULL,'OU Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvParentID"','3','(''UA''=''TT'')',@AdhSystemID,'50','D','30','3',NULL,'Parent ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvOwnerID"','4','(''UA''=''TT'')',@AdhSystemID,'50','D','30','4',NULL,'Owner ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDescription"','5','(''UA''=''TT'')',@AdhSystemID,'50','D','30','5',NULL,'Description',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvActive"','6','(''UA''=''TT'')',@AdhSystemID,'50','D','30','6',NULL,'Active',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAllowReconciliation"','7','(''UA''=''TT'')',@AdhSystemID,'50','D','30','7',NULL,'Allow Reconciliation',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvFacilityType"','8','(''UA''=''TT'')',@AdhSystemID,'50','D','30','8',NULL,'Facility Type',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCountry"','9','(''UA''=''TT'')',@AdhSystemID,'50','D','30','9',NULL,'Country',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvTimeZone"','10','(''UA''=''TT'')',@AdhSystemID,'50','D','30','10',NULL,'Time Zone',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAddress1"','11','(''UA''=''TT'')',@AdhSystemID,'50','D','30','11',NULL,'Address #1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAddress2"','12','(''UA''=''TT'')',@AdhSystemID,'50','D','30','12',NULL,'Address #2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCity"','13','(''UA''=''TT'')',@AdhSystemID,'50','D','30','13',NULL,'City',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvStateProvince"','14','(''UA''=''TT'')',@AdhSystemID,'50','D','30','14',NULL,'State/Province',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPostalCode"','15','(''UA''=''TT'')',@AdhSystemID,'50','D','30','15',NULL,'Postal Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvContact"','16','(''UA''=''TT'')',@AdhSystemID,'50','D','30','16',NULL,'Contact',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPhone"','17','(''UA''=''TT'')',@AdhSystemID,'50','D','30','17',NULL,'Phone',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvFax"','18','(''UA''=''TT'')',@AdhSystemID,'50','D','30','18',NULL,'Fax',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmail"','19','(''UA''=''TT'')',@AdhSystemID,'50','D','30','19',NULL,'Email',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvOccupancy"','20','(''UA''=''TT'')',@AdhSystemID,'50','D','30','20',NULL,'Occupancy',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvApprovalRequired"','21','(''UA''=''TT'')',@AdhSystemID,'50','D','30','21',NULL,'Approval Required',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvOnSite"','22','(''UA''=''T'')',@AdhSystemID,'50','D','30','22',NULL,'On Site',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvUserId"','1','(''UA''=''TT'')',@AdhSystemID,'100','D','40','1',NULL,'# User Id',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLocalSystemID"','2','(''UA''=''TT'')',@AdhSystemID,'100','D','40','2',NULL,'Local System ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvUsername"','3','(''UA''=''TT'')',@AdhSystemID,'128','D','40','3',NULL,'Username',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvActive"','4','(''UA''=''TT'')',@AdhSystemID,'5','D','40','4',NULL,'Active',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAbsent"','5','(''UA''=''TT'')',@AdhSystemID,'5','D','40','5',NULL,'Absent',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAllowReconcile"','6','(''UA''=''TT'')',@AdhSystemID,'5','D','40','6',NULL,'AllowReconcile',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPrefix"','7','(''UA''=''TT'')',@AdhSystemID,'10','D','40','7',NULL,'Prefix',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvFirstName"','8','(''UA''=''TT'')',@AdhSystemID,'200','D','40','8',NULL,'First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMiddleName"','9','(''UA''=''TT'')',@AdhSystemID,'200','D','40','9',NULL,'Middle Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLastName"','10','(''UA''=''TT'')',@AdhSystemID,'200','D','40','10',NULL,'Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSuffix"','11','(''UA''=''TT'')',@AdhSystemID,'10','D','40','11',NULL,'Suffix',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmail"','12','(''UA''=''TT'')',@AdhSystemID,'128','D','40','12',NULL,'Email',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvWorkPhone"','13','(''UA''=''TT'')',@AdhSystemID,'30','D','40','13',NULL,'Work Phone',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvHomePhone"','14','(''UA''=''TT'')',@AdhSystemID,'30','D','40','14',NULL,'Home Phone',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMobilePhone"','15','(''UA''=''TT'')',@AdhSystemID,'30','D','40','15',NULL,'Mobile Phone',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvFax"','16','(''UA''=''TT'')',@AdhSystemID,'30','D','40','16',NULL,'Fax',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCountryCode"','17','(''UA''=''TT'')',@AdhSystemID,'5','D','40','17',NULL,'Country Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLine1"','18','(''UA''=''TT'')',@AdhSystemID,'150','D','40','18',NULL,'Line 1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLine2"','19','(''UA''=''TT'')',@AdhSystemID,'55','D','40','19',NULL,'Line 2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMailStop"','20','(''UA''=''TT'')',@AdhSystemID,'15','D','40','20',NULL,'Mail Stop',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCity"','21','(''UA''=''TT'')',@AdhSystemID,'35','D','40','21',NULL,'City',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvStateProvince"','22','(''UA''=''TT'')',@AdhSystemID,'30','D','40','22',NULL,'State/Province',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPostalCode"','23','(''UA''=''TT'')',@AdhSystemID,'20','D','40','23',NULL,'Postal Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDivisionID"','24','(''UA''=''TT'')',@AdhSystemID,'100','D','40','24',NULL,'Division ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLocationID"','25','(''UA''=''TT'')',@AdhSystemID,'100','D','40','25',NULL,'Location ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPositionID"','26','(''UA''=''TT'')',@AdhSystemID,'100','D','40','26',NULL,'Position ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCostCenterID"','27','(''UA''=''TT'')',@AdhSystemID,'100','D','40','27',NULL,'Cost Center ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvGradeID"','28','(''UA''=''TT'')',@AdhSystemID,'100','D','40','28',NULL,'Grade ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLastHireDate"','29','(''UA''=''TT'')',@AdhSystemID,'10','D','40','29',NULL,'Last Hire Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvOriginalHireDate"','30','(''UA''=''TT'')',@AdhSystemID,'10','D','40','30',NULL,'Original Hire Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvRequiredApprovals"','31','(''UA''=''TT'')',@AdhSystemID,'3','D','40','31',NULL,'Required Approvals',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvApproverID"','32','(''UA''=''TT'')',@AdhSystemID,'100','D','40','32',NULL,'Approver ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvManagerID"','33','(''UA''=''TT'')',@AdhSystemID,'100','D','40','33',NULL,'Manager ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvGender"','34','(''UA''=''TT'')',@AdhSystemID,'50','D','40','34',NULL,'Gender',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEthnicity"','35','(''UA''=''TT'')',@AdhSystemID,'50','D','40','35',NULL,'Ethnicity',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLanguage"','36','(''UA''=''TT'')',@AdhSystemID,'50','D','40','36',NULL,'Language',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvTimeZone"','37','(''UA''=''TT'')',@AdhSystemID,'50','D','40','37',NULL,'Time Zone',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCompensationCurrency"','38','(''UA''=''TT'')',@AdhSystemID,'50','D','40','38',NULL,'Compensation Currency',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvExempt"','39','(''UA''=''TT'')',@AdhSystemID,'50','D','40','39',NULL,'Exempt',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvStatus"','40','(''UA''=''TT'')',@AdhSystemID,'50','D','40','40',NULL,'Status',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCustomOU1ID"','41','(''UA''=''TT'')',@AdhSystemID,'100','D','40','41',NULL,'Custom OU 1 ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCustomOU2ID"','42','(''UA''=''TT'')',@AdhSystemID,'100','D','40','42',NULL,'Custom OU 2 ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCustomOU3ID"','43','(''UA''=''TT'')',@AdhSystemID,'100','D','40','43',NULL,'Custom OU 3 ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCustomOU4ID"','44','(''UA''=''TT'')',@AdhSystemID,'100','D','40','44',NULL,'Custom OU 4 ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCustomOU5ID"','45','(''UA''=''T'')',@AdhSystemID,'100','D','40','45',NULL,'Custom OU 5 ID',NULL,NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Cornerstone-Division','201710011','EMPEXPORT','DIVISION',NULL,'@CustomFormatCode',NULL,NULL,NULL,'201710011','Oct  1 2017  4:49PM','Oct  1 2017  4:49PM','201710011',NULL,'','','201710011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Cornerstone-Position','201710011','EMPEXPORT','POSITION',NULL,'@CustomFormatCode',NULL,NULL,NULL,'201710011','Oct  1 2017  4:49PM','Oct  1 2017  4:49PM','201710011',NULL,'','','201710011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Cornerstone-Grade','201710011','EMPEXPORT','GRADE',NULL,'@CustomFormatCode',NULL,NULL,NULL,'201710011','Oct  1 2017  4:49PM','Oct  1 2017  4:49PM','201710011',NULL,'','','201710011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Cornerstone-CostCenter','201710011','EMPEXPORT','COSTCENTER',NULL,'@CustomFormatCode',NULL,NULL,NULL,'201710011','Oct  1 2017  4:49PM','Oct  1 2017  4:49PM','201710011',NULL,'','','201710011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Cornerstone-Location','201710011','EMPEXPORT','LOCATION',NULL,'@CustomFormatCode',NULL,NULL,NULL,'201710011','Oct  1 2017  4:49PM','Oct  1 2017  4:49PM','201710011',NULL,'','','201710011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Cornerstone-User','201710011','EMPEXPORT','USER',NULL,'@CustomFormatCode',NULL,NULL,NULL,'201710011','Oct  1 2017  4:49PM','Oct  1 2017  4:49PM','201710011',NULL,'','','201710011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','ExportPath','V','@FileExportPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','SubSort','C',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','TestPath','V','@FileTestPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','UDESPath','V','@FileUDESPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','UseFileName','V','N');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','DIVISION','H','02','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','DIVISION','D','20','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','DIVISION','H','03','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','DIVISION','D','30','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','DIVISION','H','04','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','DIVISION','D','40','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','POSITION','H','02','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','POSITION','D','20','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','POSITION','H','03','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','POSITION','D','30','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','POSITION','H','04','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','POSITION','D','40','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','GRADE','H','02','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','GRADE','D','20','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','GRADE','H','03','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','GRADE','D','30','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','GRADE','H','04','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','GRADE','D','40','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','COSTCENTER','H','01','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','COSTCENTER','D','10','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','COSTCENTER','H','03','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','COSTCENTER','D','30','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','COSTCENTER','H','04','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','COSTCENTER','D','40','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','LOCATION','H','02','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','LOCATION','D','20','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','LOCATION','H','01','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','LOCATION','D','10','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','LOCATION','H','04','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','LOCATION','D','40','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','USER','H','02','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','USER','D','20','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','USER','H','03','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','USER','D','30','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','USER','H','01','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','USER','D','10','Y','C');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D10','dbo.U_@CustomFormatCode_DPG',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D20','dbo.U_@CustomFormatCode_CC',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D30','dbo.U_@CustomFormatCode_LOC',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D40','dbo.U_@CustomFormatCode_USR',NULL);
GO
IF ('@IsWebFlag' = 'Y')
BEGIN
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = '@CustomFormatCode' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */

/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = '@CustomFormatCode.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
UPDATE dbo.AscExp SET expAscFileName = @FILEPATH + @FILENAME WHERE expFormatCode = '@CustomFormatCode';

/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = '@CustomFormatCode' AND CfgName = 'ExportPath' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = '@CustomFormatCode' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
/*03*/ DELETE FROM dbo.U_dsi_Configuration WHERE FormatCode = '@CustomFormatCode' AND CfgName = 'TestPath'; /* Remove Test Path for Web Exports */

END
GO
IF OBJECT_ID('U_@CustomFormatCode_EEList') IS NULL
CREATE TABLE [dbo].[U_@CustomFormatCode_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_@CustomFormatCode_File') IS NULL
CREATE TABLE [dbo].[U_@CustomFormatCode_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(50) NOT NULL,
    [SubSort] varchar(50) NOT NULL,
    [SubSort2] varchar(50) NULL,
    [SubSort3] varchar(50) NULL,
    [Data] varchar(4000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_@CustomFormatCode]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: @CustomerName

Created By: @DeveloperName
Business Analyst: @IntegrationAnalystName
Create Date: @CreateDate
Service Request Number: @SRNumber

Purpose: @CustomFormatName

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/20XX     SR-20XX-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_RecordSetDetails WHERE FormatCode = '@CustomFormatCode'; -- Skip RecordSet by Export Code
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = '@CustomFormatCode' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'DIVISION';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'POSITION';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'GRADE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'COSTCENTER';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'LOCATION';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'USER';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = '@CustomFormatCode', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = '@CustomFormatCode';

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
    DELETE FROM dbo.U_@CustomFormatCode_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_@CustomFormatCode_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Build Driver Tables
    --==========================================

    ----------------------------------------------------------
    -- Create Driver Table for Division / Position / Grade
    ----------------------------------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_DPG','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_DPG;
    CREATE TABLE dbo.U_@CustomFormatCode_DPG (
         drvInitialSort VARCHAR(100) NULL
        ,drvOUID VARCHAR(100) NULL
        ,drvOUName VARCHAR(1000) NULL
        ,drvParentID VARCHAR(100) NULL
        ,drvOwnerID VARCHAR(100) NULL
        ,drvDescription VARCHAR(2000) NULL
        ,drvActive VARCHAR(10) NULL
        ,drvAllowReconciliation VARCHAR(10) NULL
    );

    ---------------------------------
    -- DETAIL RECORD - Division
    ---------------------------------
    INSERT INTO dbo.U_@CustomFormatCode_DPG (drvInitialSort,drvOUID,drvOUName,drvParentID,drvOwnerID,drvDescription,drvActive,drvAllowReconciliation)
    SELECT DISTINCT
        drvInitialSort = RTRIM(EecOrgLvl2)
        --standard fields above and additional driver fields below
        ,drvOUID = EecOrgLvl2
        ,drvOUName = O2.OrgDesc
        ,drvParentID = ''
        ,drvOwnerID = ''
        ,drvDescription = ''
        ,drvActive = 'True'
        ,drvAllowReconciliation = 'True'
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.OrgLevel O2 WITH (NOLOCK)
        ON O2.OrgCode = EecOrgLvl2
        AND O2.OrgLvl = '2'
    WHERE @ExportCode = 'DIVISION';

    ---------------------------------
    -- DETAIL RECORD - Position
    ---------------------------------
    INSERT INTO dbo.U_@CustomFormatCode_DPG (drvInitialSort,drvOUID,drvOUName,drvParentID,drvOwnerID,drvDescription,drvActive,drvAllowReconciliation)
    SELECT DISTINCT
            drvInitialSort = RTRIM(EecJobCode)
        -- standard fields above and additional driver fields below
        ,drvOUID = EecJobCode
        ,drvOUName = JbcDesc
        ,drvParentID = ''
        ,drvOwnerID = ''
        ,drvDescription = ''
        ,drvActive = 'True'
        ,drvAllowReconciliation = 'True'
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    WHERE @ExportCode = 'POSITION';

    ---------------------------------
    -- DETAIL RECORD - Grade
    ---------------------------------
    INSERT INTO dbo.U_@CustomFormatCode_DPG (drvInitialSort,drvOUID,drvOUName,drvParentID,drvOwnerID,drvDescription,drvActive,drvAllowReconciliation)
    SELECT DISTINCT
         drvInitialSort = RTRIM(JbcSalaryGrade)
        -- standard fields above and additional driver fields below
        ,drvOUID = JbcSalaryGrade
        ,drvOUName = SlgDesc
        ,drvParentID = ''
        ,drvOwnerID = ''
        ,drvDescription = ''
        ,drvActive = 'True'
        ,drvAllowReconciliation = 'True'
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.SalGrade WITH (NOLOCK)
        ON SlgSalgrade = JbcSalaryGrade
    WHERE @ExportCode = 'GRADE';

    ---------------------------------
    -- DETAIL RECORD - Cost Center
    ---------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_CC','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_CC;
    SELECT DISTINCT
         drvInitialSort = RTRIM(EecOrgLvl1)
        -- standard fields above and additional driver fields below
        ,drvOUID = EecOrgLvl1
        ,drvOUName = O1.OrgDesc
        ,drvParentID = ''
        ,drvOwnerID = ''
        ,drvApproverID = ''
        ,drvDescription = ''
        ,drvActive = 'True'
        ,drvAllowReconciliation = 'True'
    INTO dbo.U_@CustomFormatCode_CC
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.OrgLevel O1 WITH (NOLOCK)
        ON O1.OrgCode = EecOrgLvl1
        AND O1.OrgLvl = '1';

    ---------------------------------
    -- DETAIL RECORD - Location
    ---------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_LOC','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_LOC;
    SELECT DISTINCT
         drvInitialSort = RTRIM(LocCode)
        -- standard fields above and additional driver fields below
        ,drvOUID = LocCode
        ,drvOUName = LocName
        ,drvParentID = ''
        ,drvOwnerID = ''
        ,drvDescription = ''
        ,drvActive = 'True'
        ,drvAllowReconciliation = 'True'
        ,drvFacilityType = ''
        ,drvCountry = LocAddressCountry
        ,drvTimeZone = ''
        ,drvAddress1 = LocAddressLine1
        ,drvAddress2 = LocAddressLine2
        ,drvCity = LocAddressCity
        ,drvStateProvince = LocAddressState
        ,drvPostalCode = LocAddressZipCode
        ,drvContact = LocContact
        ,drvPhone = STUFF(STUFF(LocPhoneMainNumber,7,0,'-'),4,0,'-')
        ,drvFax = STUFF(STUFF(LocPhoneFaxNumber,7,0,'-'),4,0,'-')
        ,drvEmail = ''
        ,drvOccupancy = ''
        ,drvApprovalRequired = ''
        ,drvOnSite = ''
    INTO dbo.U_@CustomFormatCode_LOC
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation;

    ---------------------------------
    -- DETAIL RECORD - User
    ---------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_USR','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_USR;
    SELECT DISTINCT
         drvInitialSort = RTRIM(EecEmpNo)
        -- standard fields above and additional driver fields below
        ,drvUserId = EecEmpNo
        ,drvLocalSystemID = ''
        ,drvUsername = ''
        ,drvActive = CASE WHEN EecEmplStatus = 'A' THEN 'True' END
        ,drvAbsent = CASE WHEN EecEmplStatus = 'L' THEN 'True' ELSE 'False' END
        ,drvAllowReconcile = ''
        ,drvPrefix = EepNamePrefix
        ,drvFirstName = EepNameFirst
        ,drvMiddleName = LEFT(EepNameMiddle,1)
        ,drvLastName = EepNameLast
        ,drvSuffix = EepNameSuffix
        ,drvEmail = COALESCE(NULLIF(EepAddressEMail,''),EepAddressEmailAlternate)
        ,drvWorkPhone = STUFF(STUFF(EecPhoneBusinessNumber,7,0,'-'),4,0,'-')
        ,drvHomePhone = STUFF(STUFF(EepPhoneHomeNumber,7,0,'-'),4,0,'-')
        ,drvMobilePhone = STUFF(STUFF(EepPhoneHomeNumber,7,0,'-'),4,0,'-')
        ,drvFax = ''
        ,drvCountryCode = EepAddressCountry
        ,drvLine1 = EepAddressLine1
        ,drvLine2 = EepAddressLine2
        ,drvMailStop = ''
        ,drvCity = EepAddressCity
        ,drvStateProvince = EepAddressState
        ,drvPostalCode = EepAddressZipCode
        ,drvDivisionID = EecOrglvl1
        ,drvLocationID = EecLocation
        ,drvPositionID = EecJobCode
        ,drvCostCenterID = EecOrgLvl2
        ,drvGradeID = JbcSalaryGrade
        ,drvLastHireDate = EecDateOfLastHire
        ,drvOriginalHireDate = EecDateOfOriginalHire
        ,drvRequiredApprovals = ''
        ,drvApproverID = ''
        ,drvManagerID = Supervisor.SupEmpNo
        ,drvGender = EepGender
        ,drvEthnicity = ''
        ,drvLanguage = ''
        ,drvTimeZone = ''
        ,drvCompensationCurrency = ''
        ,drvExempt = ''
        ,drvStatus = ''
        ,drvCustomOU1ID = ''
        ,drvCustomOU2ID = ''
        ,drvCustomOU3ID = ''
        ,drvCustomOU4ID = ''
        ,drvCustomOU5ID = ''
    INTO dbo.U_@CustomFormatCode_USR
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    LEFT JOIN ( -- Get Supervisor Information
        SELECT DISTINCT SupEEID = EecEEID, SupEmpNo = EecEmpNo
        FROM dbo.EmpComp WITH (NOLOCK)
        WHERE EecEEID = dbo.dsi_BDM_fn_GetCurrentCOID(EecCOID)
    ) Supervisor
        ON SupEEID = EecSupervisorID;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
        SET ExportFile = LTRIM(RTRIM(@ExportCode)) + '.txt'
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vw@CustomFormatCode_Export AS
    SELECT TOP 20000000 Data
    FROM dbo.U_@CustomFormatCode_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE '@CustomFormatCode%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201710011'
       ,expStartPerControl     = '201710011'
       ,expLastEndPerControl   = '201710011'
       ,expEndPerControl       = '201710011'
WHERE expFormatCode = '@CustomFormatCode';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vw@CustomFormatCode_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_@CustomFormatCode_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort
GO