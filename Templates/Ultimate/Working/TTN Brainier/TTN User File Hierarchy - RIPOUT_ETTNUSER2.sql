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
@CustomFormatCode - Replace with Format Code (i.e., ETTNUSERS)
@CustomFormatName - Replace with Name of Interface (AdfFormatName) (i.e., TTN Users File)
@IsWebFlag - Replace with 'Y' (Yes) or 'N' (No) for Web Interface Settings

-- File parameters
@FileExportPath - Replace with the Export Path where the Error Report generates to (i.e., \\us.saas\e1\Public\[Client ARNum]\Exports\[Vendor]\)

NOTE: This is a Sample layout. *** YOU WILL NEED TO CONFIRM YOUR LAYOUT AND MODIFY AS NEEDED - EVERY TTN/BRAINIER FILE IS DIFFERENT***
*/
IF OBJECT_ID('dsi_vw@CustomFormatCode_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vw@CustomFormatCode_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_@CustomFormatCode') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_@CustomFormatCode];
GO
IF OBJECT_ID('U_@CustomFormatCode_Supervisors') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_Supervisors];
GO
IF OBJECT_ID('U_@CustomFormatCode_File') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_File];
GO
IF OBJECT_ID('U_@CustomFormatCode_EEList') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_EEList];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_User') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_User];
GO
IF OBJECT_ID('U_@CustomFormatCode_Audit') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_Audit];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = '@CustomFormatCode';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = '@CustomFormatCode';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = '@CustomFormatCode';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = '@CustomFormatCode';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = '@CustomFormatCode';
GO

DECLARE @AdhSystemID VARCHAR(12), @FixedFormatName VARCHAR(50);
SET @AdhSystemID = LEFT('@CustomFormatCode' + REPLICATE('0',10),10) + 'Z0';
SET @FixedFormatName = LEFT('@CustomFormatName',50);

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) SELECT 'N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','@CustomFormatCode',@FixedFormatName,'N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N',@AdhSystemID,'N','Jan  1 1900 12:00AM','C','N',NULL,'N';
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"username"','1','(''DA''=''Q,'')',@AdhSystemID,'50','H','01','1',NULL,'username',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"firstName"','2','(''DA''=''Q,'')',@AdhSystemID,'50','H','01','2',NULL,'firstName',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"mi"','3','(''DA''=''Q,'')',@AdhSystemID,'50','H','01','3',NULL,'mi',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"lastName"','4','(''DA''=''Q,'')',@AdhSystemID,'50','H','01','4',NULL,'lastName',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"email"','5','(''DA''=''Q,'')',@AdhSystemID,'50','H','01','5',NULL,'email',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"phone"','6','(''DA''=''Q,'')',@AdhSystemID,'50','H','01','6',NULL,'phone',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"jobTitle"','7','(''DA''=''Q,'')',@AdhSystemID,'50','H','01','7',NULL,'jobTitle',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"expiresOn"','8','(''DA''=''Q,'')',@AdhSystemID,'50','H','01','8',NULL,'expiresOn',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Active"','9','(''DA''=''Q,'')',@AdhSystemID,'50','H','01','9',NULL,'Active',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"primaryGroupCode"','10','(''DA''=''Q,'')',@AdhSystemID,'50','H','01','10',NULL,'primaryGroupCode',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"primaryGroupName"','11','(''DA''=''Q,'')',@AdhSystemID,'50','H','01','11',NULL,'primaryGroupName',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"primaryGroupRoleCode"','12','(''DA''=''Q,'')',@AdhSystemID,'50','H','01','12',NULL,'primaryGroupRoleCode',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"primaryGroupRoleName"','13','(''DA''=''Q,'')',@AdhSystemID,'50','H','01','13',NULL,'primaryGroupRoleName',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"optGroupCode1"','14','(''DA''=''Q,'')',@AdhSystemID,'50','H','01','14',NULL,'optGroupCode1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"optGroupName1"','15','(''DA''=''Q,'')',@AdhSystemID,'50','H','01','15',NULL,'optGroupName1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"optGroupRoleCode1"','16','(''DA''=''Q,'')',@AdhSystemID,'50','H','01','16',NULL,'optGroupRoleCode1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"optGroupRoleName1"','17','(''DA''=''Q,'')',@AdhSystemID,'50','H','01','17',NULL,'optGroupRoleName1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"optGroupCode2"','18','(''DA''=''Q,'')',@AdhSystemID,'50','H','01','18',NULL,'optGroupCode2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"optGroupName2"','19','(''DA''=''Q,'')',@AdhSystemID,'50','H','01','19',NULL,'optGroupName2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"optGroupRoleCode2"','20','(''DA''=''Q,'')',@AdhSystemID,'50','H','01','20',NULL,'optGroupRoleCode2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"optGroupRoleName2"','21','(''DA''=''Q,'')',@AdhSystemID,'50','H','01','21',NULL,'optGroupRoleName2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"optGroupCode3"','22','(''DA''=''Q,'')',@AdhSystemID,'50','H','01','22',NULL,'optGroupCode3',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"optGroupName3"','23','(''DA''=''Q,'')',@AdhSystemID,'50','H','01','23',NULL,'optGroupName3',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"optGroupRoleCode3"','24','(''DA''=''Q,'')',@AdhSystemID,'50','H','01','24',NULL,'optGroupRoleCode3',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"optGroupRoleName3"','25','(''DA''=''Q,'')',@AdhSystemID,'50','H','01','25',NULL,'optGroupRoleName3',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Supervisor Name"','26','(''DA''=''Q,'')',@AdhSystemID,'50','H','01','26',NULL,'Supervisor Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Function"','27','(''DA''=''Q,'')',@AdhSystemID,'50','H','01','27',NULL,'Function',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Division"','28','(''DA''=''Q,'')',@AdhSystemID,'50','H','01','28',NULL,'Division',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Department"','29','(''DA''=''Q,'')',@AdhSystemID,'50','H','01','29',NULL,'Department',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Location"','30','(''DA''=''Q,'')',@AdhSystemID,'50','H','01','30',NULL,'Location',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"JobFamily"','31','(''DA''=''Q,'')',@AdhSystemID,'50','H','01','31',NULL,'JobFamily',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DateofLastHire"','32','(''DA''=''Q,'')',@AdhSystemID,'50','H','01','32',NULL,'DateofLastHire',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DateInJob"','33','(''DA''=''Q,'')',@AdhSystemID,'50','H','01','33',NULL,'DateInJob',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"EEID"','34','(''DA''=''Q,'')',@AdhSystemID,'50','H','01','34',NULL,'EEID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Employee Number"','35','(''DA''=''Q'')',@AdhSystemID,'50','H','01','35',NULL,'Employee Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvusername"','1','(''UA''=''Q,'')',@AdhSystemID,'100','D','10','1',NULL,'username',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvfirstName"','2','(''UA''=''Q,'')',@AdhSystemID,'50','D','10','2',NULL,'firstName',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvmi"','3','(''UA''=''Q,'')',@AdhSystemID,'50','D','10','3',NULL,'mi',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvlastName"','4','(''UA''=''Q,'')',@AdhSystemID,'50','D','10','4',NULL,'lastName',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvemail"','5','(''UA''=''Q,'')',@AdhSystemID,'100','D','10','5',NULL,'email',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvphone"','6','(''UA''=''Q,'')',@AdhSystemID,'50','D','10','6',NULL,'phone',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvjobtitle"','7','(''UA''=''Q,'')',@AdhSystemID,'100','D','10','7',NULL,'jobTitle',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','8','(''SS''=''Q,'')',@AdhSystemID,'50','D','10','8',NULL,'expiresOn',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvActive"','9','(''UA''=''Q,'')',@AdhSystemID,'50','D','10','9',NULL,'Active',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvprimaryGroupCode"','10','(''UA''=''Q,'')',@AdhSystemID,'50','D','10','10',NULL,'primaryGroupCode',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvprimaryGroupName"','11','(''UA''=''Q,'')',@AdhSystemID,'50','D','10','11',NULL,'primaryGroupName',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvprimaryGroupRoleCode"','12','(''UA''=''Q,'')',@AdhSystemID,'50','D','10','12',NULL,'primaryGroupRoleCode',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvprimaryGroupRoleName"','13','(''UA''=''Q,'')',@AdhSystemID,'50','D','10','13',NULL,'primaryGroupRoleName',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvoptGroupCode1"','14','(''UA''=''Q,'')',@AdhSystemID,'50','D','10','14',NULL,'optGroupCode1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvoptGroupName1"','15','(''UA''=''Q,'')',@AdhSystemID,'50','D','10','15',NULL,'optGroupName1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"USR"','16','(''DA''=''Q,'')',@AdhSystemID,'50','D','10','16',NULL,'optGroupRoleCode1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"User"','17','(''DA''=''Q,'')',@AdhSystemID,'50','D','10','17',NULL,'optGroupRoleName1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvoptGroupCode2"','18','(''UA''=''Q,'')',@AdhSystemID,'50','D','10','18',NULL,'optGroupCode2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvoptGroupName2"','19','(''UA''=''Q,'')',@AdhSystemID,'50','D','10','19',NULL,'optGroupName2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"USR"','20','(''DA''=''Q,'')',@AdhSystemID,'50','D','10','20',NULL,'optGroupRoleCode2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"User"','21','(''DA''=''Q,'')',@AdhSystemID,'50','D','10','21',NULL,'optGroupRoleName2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvoptGroupCode3"','22','(''UA''=''Q,'')',@AdhSystemID,'50','D','10','22',NULL,'optGroupCode3',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvoptGroupName3"','23','(''UA''=''Q,'')',@AdhSystemID,'50','D','10','23',NULL,'optGroupName3',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"USR"','24','(''DA''=''Q,'')',@AdhSystemID,'50','D','10','24',NULL,'optGroupRoleCode3',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"User"','25','(''DA''=''Q,'')',@AdhSystemID,'50','D','10','25',NULL,'optGroupRoleName3',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSupervisorName"','26','(''UA''=''Q,'')',@AdhSystemID,'50','D','10','26',NULL,'Supervisor Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvFunction"','27','(''UA''=''Q,'')',@AdhSystemID,'50','D','10','27',NULL,'Function',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDivision"','28','(''UA''=''Q,'')',@AdhSystemID,'50','D','10','28',NULL,'Division',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDepartment"','29','(''UA''=''Q,'')',@AdhSystemID,'50','D','10','29',NULL,'Department',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLocation"','30','(''UA''=''Q,'')',@AdhSystemID,'50','D','10','30',NULL,'Location',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvJobFamily"','31','(''UA''=''Q,'')',@AdhSystemID,'50','D','10','31',NULL,'JobFamily',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDateofLastHire"','32','(''UD101''=''Q,'')',@AdhSystemID,'50','D','10','32',NULL,'DateofLastHire',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDateInJob"','33','(''UD101''=''Q,'')',@AdhSystemID,'50','D','10','33',NULL,'DateInJob',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEEID1"','34','(''UA''=''Q,'')',@AdhSystemID,'50','D','10','34',NULL,'EEID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmployeeNumber"','35','(''UA''=''Q'')',@AdhSystemID,'50','D','10','35',NULL,'Employee Number',NULL,NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,'','',NULL,NULL,NULL,NULL,'Test TTN User File','201703019','EMPEXPORT','TEST','Mar  1 2017 12:00AM','@CustomFormatCode',NULL,NULL,NULL,'201703019','Mar  1 2017 12:00AM','Dec 30 1899 12:00AM','201703011',NULL,'','','201703011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,'','','',NULL,NULL,NULL,'TTN User File','201704189','EMPEXPORT','USER','Apr 18 2017 12:40PM','@CustomFormatCode',NULL,NULL,NULL,'201704189','Apr 18 2017 12:00AM','Dec 30 1899 12:00AM','201704181',NULL,'','','201704181',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','ExportPath','V','@FileExportPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','UseFileName','V','N');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D10','dbo.U_@CustomFormatCode_drvTbl_User',NULL);
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
    [Data] varchar(2000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_@CustomFormatCode]
    @SystemID char(12)
AS
/**********************************************************************************
Client Name: @CustomerName

Created By: @DeveloperName
Business Analyst: @IntegrationAnalystName
Create Date: @CreateDate
Service Request Number: @SRNumber

Purpose: @CustomFormatName

Revision History
----------------
Update By           Date            Request Num            Desc
XXX                 XX/XX/XXXX      XXX                    XXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.AscExp WHERE expFormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = '@CustomFormatCode' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'USER';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'TEST';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = '@CustomFormatCode', @AllObjects = 'Y'
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
    WHERE FormatCode = '@CustomFormatCode';

    PRINT 'Start Date: ' + CONVERT(VARCHAR(26),@StartDate,100);
    PRINT 'End Date:  ' + CONVERT(VARCHAR(26),@EndDate,100);

    --==========================================
    -- Clean EE List
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_@CustomFormatCode_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCoID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_@CustomFormatCode_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    -- Remove Terminated Employees
    DELETE FROM dbo.U_@CustomFormatCode_EEList
    FROM dbo.U_@CustomFormatCode_EEList
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    WHERE EecEmplStatus = 'T';

    --==========================================
    -- Build Employee Data and the driver tables
    --==========================================

    /*_____________________________________________________________________________________________________________________

        BUILD USER FILE
    ______________________________________________________________________________________________________________________*/

    ---------------------------------
    -- WORKING TABLE - Supervisors
    ---------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_Supervisors','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_Supervisors;

    WITH CTE_Supervisor (EEID, COID, EmpNo, SupervisorID, EmplStatus, JobCode, Name, Supervisor)
    AS ( -- Get All Employees with Active Supervisor 1 and Supervisor 2 Information
        SELECT EecEEID, EecCOID, EecEmpNo, EecSupervisorID, EecEmplStatus, EecJobCode
            ,Name = RTRIM(EepNameLast) + ', '  + RTRIM(COALESCE(NULLIF(EepNamePreferred,''),EepNameFirst))
            ,Supervisor = CASE WHEN EecEEID IN (SELECT EecSupervisorID FROM dbo.EmpComp WITH (NOLOCK) WHERE EecEmplStatus <> 'T') THEN 'Y' ELSE 'N' END
        FROM dbo.EmpComp WITH (NOLOCK)
        JOIN dbo.EmpPers WITH (NOLOCK)
            ON EepEEID = EecEEID
            AND EecCOID = dbo.dsi_BDM_fn_GetCurrentCoID(EecEEID)
        WHERE EecEmplStatus <> 'T'
    )
     SELECT
         EmpEEID = E.EEID
        ,EmpCOID = E.COID
        ,EmpEmpNo = E.EmpNo
        ,EmpName = E.Name
        ,EmpStatus = E.EmplStatus
        ,Supervisor = E.Supervisor
        ,Supervisor1EEID = S1.EEID
        ,Supervisor1EmpNo = S1.EmpNo
        ,Supervisor1Status = S1.EmplStatus
        ,Supervisor1Name = S1.Name
        ,Supervisor2EEID = S2.EEID
        ,Supervisor2EmpNo = S2.EmpNo
        ,Supervisor2Status = S2.EmplStatus
        ,Supervisor2Name = S2.Name
    INTO dbo.U_@CustomFormatCode_Supervisors
    FROM dbo.U_@CustomFormatCode_EEList
    JOIN CTE_Supervisor E
        ON E.EEID = xEEID
        AND E.COID = xCOID
    LEFT JOIN CTE_Supervisor S1
        ON S1.EEID = E.SupervisorID
        AND S1.COID = dbo.dsi_BDM_fn_GetCurrentCoID(S1.EEID)
    LEFT JOIN CTE_Supervisor S2
        ON S2.EEID = S1.SupervisorID
        AND S2.COID = dbo.dsi_BDM_fn_GetCurrentCoID(S2.EEID);

    ---------------------------------
    -- DETAIL RECORD - User File
    ---------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_User','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_User;
    SELECT DISTINCT
        drvusername = RTRIM(EecEmpNo)
        ,drvfirstName = COALESCE(NULLIF(EepNamePreferred,''),EepNameFirst)
        ,drvmi = LEFT(EepNameMiddle,1)
        ,drvlastName = EepNameLast
        ,drvemail = EepAddressEMail
        ,drvphone = EecPhoneBusinessNumber
        ,drvjobTitle = JbcLongDesc
        ,drvActive = CASE EecEmplStatus
                          WHEN 'T' THEN 'Inactive'
                          ELSE 'Active'
                     END
        ,drvprimaryGroupCode = CASE WHEN Supervisor = 'Y' THEN EecEmpNo
                                    ELSE COALESCE(Supervisor1EmpNo,Supervisor2EmpNo)
                               END
        ,drvprimaryGroupName = CASE WHEN Supervisor = 'Y' THEN EmpName
                                    ELSE COALESCE(Supervisor1Name,Supervisor2Name)
                               END
        ,drvprimaryGroupRoleCode = CASE WHEN Supervisor = 'N' THEN 'USR'
                                        WHEN Supervisor = 'Y' AND EXISTS (SELECT 1 FROM dbo.U_@CustomFormatCode_Supervisors S1 WHERE S1.Supervisor1EEID = xEEID AND Supervisor = 'Y') THEN 'ADM'
                                        ELSE 'MGR'
                                   END
        ,drvprimaryGroupRoleName = CASE WHEN Supervisor = 'N' THEN 'User'
                                        WHEN Supervisor = 'Y' AND EXISTS (SELECT 1 FROM dbo.U_@CustomFormatCode_Supervisors S1 WHERE S1.Supervisor1EEID = xEEID AND Supervisor = 'Y') THEN 'Administrator'
                                        ELSE 'Manager'
                                   END
        ,drvoptGroupCode1 = JbcJobFamily
        ,drvoptGroupName1 = JOBFAMILY.CodDesc
        ,drvoptGroupCode2 = RTRIM(O2.OrgCode) + ISNULL(LTRIM(O3.OrgCode),'') + ISNULL(LTRIM(JbcJobFamily),'XX')
        ,drvoptGroupName2 = ISNULL(RTRIM(O2.OrgDesc),'') + '/' + ISNULL(LTRIM(O3.OrgDesc),'') + '/' + ISNULL(LTRIM(JbcJobFamily),'')
        ,drvoptGroupCode3 = CASE JbcIsSupervisor
                                 WHEN 'Y' THEN 'MGR'
                                 ELSE 'NONMGR'
                            END
        ,drvoptGroupName3 = CASE JbcIsSupervisor
                                 WHEN 'Y' THEN 'Manager'
                                 ELSE 'Non-Manager'
                            END
        ,drvSupervisorName = Supervisor1Name
        ,drvFunction = ISNULL(RTRIM(O1.OrgDesc),'') + ' - ' + ISNULL(O1.OrgReportCategory ,'')
        ,drvDivision = ISNULL(RTRIM(O2.OrgDesc),'') + ' - ' + ISNULL(O2.OrgReportCategory ,'')
        ,drvDepartment = ISNULL(RTRIM(EecOrgLvl3),'') + ' - ' + ISNULL(O3.OrgDesc,'')
        ,drvLocation = LocDesc
        ,drvJobFamily = JOBFAMILY.CodDesc
        ,drvDateofLastHire = EecDateOfLastHire
        ,drvDateInJob = EecDateInJob
        ,drvEEID1 = xEEID
        ,drvEmployeeNumber = EecEmpNo
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepNameLast) + RTRIM(EepNameFirst)
        ,drvSubSort = ''
    INTO dbo.U_@CustomFormatCode_drvTbl_User
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    LEFT JOIN dbo.U_@CustomFormatCode_Supervisors WITH (NOLOCK)
        ON EmpEEID = xEEID
        AND EmpCOID = xCOID
    LEFT JOIN dbo.OrgLevel O1 WITH (NOLOCK)
        ON O1.OrgCode = EecOrglvl1
        AND O1.OrgLvl = '1'
    LEFT JOIN dbo.OrgLevel O2 WITH (NOLOCK)
        ON O2.OrgCode = EecOrglvl2
        AND O2.OrgLvl = '2'
    LEFT JOIN dbo.OrgLevel O3 WITH (NOLOCK)
        ON O3.OrgCode = EecOrglvl3
        AND O3.OrgLvl = '3'
    LEFT JOIN dbo.Codes JOBFAMILY WITH (NOLOCK)
        ON JOBFAMILY.CodCode = JbcJobFamily
        AND JOBFAMILY.CodTable = 'JOBFAMILY';

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable('@CustomFormatCode','UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN ExportCode LIKE '%TEST%' THEN '@CustomerName_TTN_USER_TEST_'
                                  ELSE '@CustomerName_TTN_USER_'
                             END
                             + CONVERT(VARCHAR(8),GETDATE(),112) + '.csv'
        WHERE FormatCode = '@CustomFormatCode';
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vw@CustomFormatCode_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_@CustomFormatCode_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE '@CustomFormatCode%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET ExpLastStartPerControl = '201703011'
       ,ExpStartPerControl     = '201703011'
       ,ExpLastEndPerControl   = '201703019'
       ,ExpEndPerControl       = '201703019'
WHERE ExpFormatCode = '@CustomFormatCode';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vw@CustomFormatCode_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_@CustomFormatCode_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;