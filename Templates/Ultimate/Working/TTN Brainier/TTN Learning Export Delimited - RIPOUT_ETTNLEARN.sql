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
@CustomFormatCode - Replace with Format Code (i.e., ETTNLEARN)
@CustomFormatName - Replace with Name of Interface (AdfFormatName) (i.e., TTN Learning Export)
@IsWebFlag - Replace with 'Y' (Yes) or 'N' (No) for Web Interface Settings

-- File parameters
@FileExportPath - Replace with the Export Path where the Error Report generates to (i.e., \\us.saas\e1\Public\[Client ARNum]\Exports\[Vendor]\)
@FileTestPath - Replace with the Export Path where the Error Report generates to (i.e., \\us.saas\e1\Public\[Client ARNum]\Exports\[Vendor]\)
@FileUDESPath - Replace with the Export Path where the Error Report generates to (i.e., \\us.saas\e0\data_exchange\[Client ARNum]\Exports\)

NOTE: This is a Sample layout. *** YOU WILL NEED TO CONFIRM YOUR LAYOUT AND MODIFY AS NEEDED - EVERY TTN/BRAINIER FILE IS DIFFERENT***
*/
IF OBJECT_ID('dsi_vw@CustomFormatCode_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vw@CustomFormatCode_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_@CustomFormatCode') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_@CustomFormatCode];
GO
IF OBJECT_ID('U_@CustomFormatCode_Supervisors') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_Supervisors];
GO
IF OBJECT_ID('U_@CustomFormatCode_Groups') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_Groups];
GO
IF OBJECT_ID('U_@CustomFormatCode_File') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_File];
GO
IF OBJECT_ID('U_@CustomFormatCode_EEList') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_EEList];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_User') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_User];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_Groups') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_Groups];
GO
IF OBJECT_ID('U_@CustomFormatCode_Audit') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_Audit];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = '@CustomFormatCode';
DELETE [dbo].[U_dsi_RecordSetDetails] FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode = '@CustomFormatCode';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = '@CustomFormatCode';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = '@CustomFormatCode';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = '@CustomFormatCode';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = '@CustomFormatCode';
GO

DECLARE @AdhSystemID VARCHAR(12), @FixedFormatName1 VARCHAR(50), @FixedFormatName2 VARCHAR(30);
SET @AdhSystemID = LEFT('@CustomFormatCode' + REPLICATE('0',10),10) + 'Z0';
SET @FixedFormatName1 = LEFT('@CustomFormatName',50);
SET @FixedFormatName2 = LEFT('@CustomFormatName',30);

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) SELECT 'N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','@CustomFormatCode','TTN Learning Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N',@AdhSystemID,'N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'50','H','01','1',NULL,'username',NULL,NULL,'"username"','(''DA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'50','H','01','2',NULL,'firstName',NULL,NULL,'"firstName"','(''DA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'50','H','01','3',NULL,'mi',NULL,NULL,'"mi"','(''DA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'50','H','01','4',NULL,'lastName',NULL,NULL,'"lastName"','(''DA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '5',@AdhSystemID,'50','H','01','5',NULL,'email',NULL,NULL,'"email"','(''DA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '6',@AdhSystemID,'50','H','01','6',NULL,'phone',NULL,NULL,'"phone"','(''DA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '7',@AdhSystemID,'50','H','01','7',NULL,'jobTitle',NULL,NULL,'"jobTitle"','(''DA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '8',@AdhSystemID,'50','H','01','8',NULL,'expiresOn',NULL,NULL,'"expiresOn"','(''DA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '9',@AdhSystemID,'50','H','01','9',NULL,'Active',NULL,NULL,'"Active"','(''DA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '10',@AdhSystemID,'50','H','01','10',NULL,'primaryGroupCode',NULL,NULL,'"primaryGroupCode"','(''DA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '11',@AdhSystemID,'50','H','01','11',NULL,'primaryGroupName',NULL,NULL,'"primaryGroupName"','(''DA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '12',@AdhSystemID,'50','H','01','12',NULL,'primaryGroupRoleCode',NULL,NULL,'"primaryGroupRoleCode"','(''DA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '13',@AdhSystemID,'50','H','01','13',NULL,'primaryGroupRoleName',NULL,NULL,'"primaryGroupRoleName"','(''DA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '14',@AdhSystemID,'50','H','01','14',NULL,'optGroupCode1',NULL,NULL,'"optGroupCode1"','(''DA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '15',@AdhSystemID,'50','H','01','15',NULL,'optGroupName1',NULL,NULL,'"optGroupName1"','(''DA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '16',@AdhSystemID,'50','H','01','16',NULL,'optGroupRoleCode1',NULL,NULL,'"optGroupRoleCode1"','(''DA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '17',@AdhSystemID,'50','H','01','17',NULL,'optGroupRoleName1',NULL,NULL,'"optGroupRoleName1"','(''DA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '18',@AdhSystemID,'50','H','01','18',NULL,'optGroupCode2',NULL,NULL,'"optGroupCode2"','(''DA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '19',@AdhSystemID,'50','H','01','19',NULL,'optGroupName2',NULL,NULL,'"optGroupName2"','(''DA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '20',@AdhSystemID,'50','H','01','20',NULL,'optGroupRoleCode2',NULL,NULL,'"optGroupRoleCode2"','(''DA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '21',@AdhSystemID,'50','H','01','21',NULL,'optGroupRoleName2',NULL,NULL,'"optGroupRoleName2"','(''DA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '22',@AdhSystemID,'50','H','01','22',NULL,'optGroupCode3',NULL,NULL,'"optGroupCode3"','(''DA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '23',@AdhSystemID,'50','H','01','23',NULL,'optGroupName3',NULL,NULL,'"optGroupName3"','(''DA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '24',@AdhSystemID,'50','H','01','24',NULL,'optGroupRoleCode3',NULL,NULL,'"optGroupRoleCode3"','(''DA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '25',@AdhSystemID,'50','H','01','25',NULL,'optGroupRoleName3',NULL,NULL,'"optGroupRoleName3"','(''DA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '26',@AdhSystemID,'50','H','01','26',NULL,'Supervisor Name',NULL,NULL,'"Supervisor Name"','(''DA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '27',@AdhSystemID,'50','H','01','27',NULL,'Function',NULL,NULL,'"Function"','(''DA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '28',@AdhSystemID,'50','H','01','28',NULL,'Division',NULL,NULL,'"Division"','(''DA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '29',@AdhSystemID,'50','H','01','29',NULL,'Department',NULL,NULL,'"Department"','(''DA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '30',@AdhSystemID,'50','H','01','30',NULL,'Location',NULL,NULL,'"Location"','(''DA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '31',@AdhSystemID,'50','H','01','31',NULL,'JobFamily',NULL,NULL,'"JobFamily"','(''DA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '32',@AdhSystemID,'50','H','01','32',NULL,'DateofLastHire',NULL,NULL,'"DateofLastHire"','(''DA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '33',@AdhSystemID,'50','H','01','33',NULL,'DateInJob',NULL,NULL,'"DateInJob"','(''DA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '34',@AdhSystemID,'50','H','01','34',NULL,'EEID',NULL,NULL,'"EEID"','(''DA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '35',@AdhSystemID,'50','H','01','35',NULL,'Employee Number',NULL,NULL,'"Employee Number"','(''DA''=''Q'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'50','H','02','1',NULL,'groupCode',NULL,NULL,'"groupCode"','(''DA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'50','H','02','2',NULL,'groupName',NULL,NULL,'"groupName"','(''DA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'50','H','02','3',NULL,'groupStatus',NULL,NULL,'"groupStatus"','(''DA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'50','H','02','4',NULL,'groupTypeCode',NULL,NULL,'"groupTypeCode"','(''DA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '5',@AdhSystemID,'50','H','02','5',NULL,'parentGroupCode',NULL,NULL,'"parentGroupCode"','(''DA''=''Q'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'100','D','10','1',NULL,'username',NULL,NULL,'"drvusername"','(''UA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'50','D','10','2',NULL,'firstName',NULL,NULL,'"drvfirstName"','(''UA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'50','D','10','3',NULL,'mi',NULL,NULL,'"drvmi"','(''UA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'50','D','10','4',NULL,'lastName',NULL,NULL,'"drvlastName"','(''UA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '5',@AdhSystemID,'100','D','10','5',NULL,'email',NULL,NULL,'"drvemail"','(''UA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '6',@AdhSystemID,'50','D','10','6',NULL,'phone',NULL,NULL,'"drvphone"','(''UA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '7',@AdhSystemID,'100','D','10','7',NULL,'jobTitle',NULL,NULL,'"drvjobtitle"','(''UA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '8',@AdhSystemID,'50','D','10','8',NULL,'expiresOn',NULL,NULL,'""','(''SS''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '9',@AdhSystemID,'50','D','10','9',NULL,'Active',NULL,NULL,'"drvActive"','(''UA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '10',@AdhSystemID,'50','D','10','10',NULL,'primaryGroupCode',NULL,NULL,'"drvprimaryGroupCode"','(''UA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '11',@AdhSystemID,'50','D','10','11',NULL,'primaryGroupName',NULL,NULL,'"drvprimaryGroupName"','(''UA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '12',@AdhSystemID,'50','D','10','12',NULL,'primaryGroupRoleCode',NULL,NULL,'"drvprimaryGroupRoleCode"','(''UA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '13',@AdhSystemID,'50','D','10','13',NULL,'primaryGroupRoleName',NULL,NULL,'"drvprimaryGroupRoleName"','(''UA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '14',@AdhSystemID,'50','D','10','14',NULL,'optGroupCode1',NULL,NULL,'"drvoptGroupCode1"','(''UA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '15',@AdhSystemID,'50','D','10','15',NULL,'optGroupName1',NULL,NULL,'"drvoptGroupName1"','(''UA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '16',@AdhSystemID,'50','D','10','16',NULL,'optGroupRoleCode1',NULL,NULL,'"USR"','(''DA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '17',@AdhSystemID,'50','D','10','17',NULL,'optGroupRoleName1',NULL,NULL,'"User"','(''DA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '18',@AdhSystemID,'50','D','10','18',NULL,'optGroupCode2',NULL,NULL,'"drvoptGroupCode2"','(''UA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '19',@AdhSystemID,'50','D','10','19',NULL,'optGroupName2',NULL,NULL,'"drvoptGroupName2"','(''UA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '20',@AdhSystemID,'50','D','10','20',NULL,'optGroupRoleCode2',NULL,NULL,'"USR"','(''DA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '21',@AdhSystemID,'50','D','10','21',NULL,'optGroupRoleName2',NULL,NULL,'"User"','(''DA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '22',@AdhSystemID,'50','D','10','22',NULL,'optGroupCode3',NULL,NULL,'"drvoptGroupCode3"','(''UA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '23',@AdhSystemID,'50','D','10','23',NULL,'optGroupName3',NULL,NULL,'"drvoptGroupName3"','(''UA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '24',@AdhSystemID,'50','D','10','24',NULL,'optGroupRoleCode3',NULL,NULL,'"USR"','(''DA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '25',@AdhSystemID,'50','D','10','25',NULL,'optGroupRoleName3',NULL,NULL,'"User"','(''DA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '26',@AdhSystemID,'50','D','10','26',NULL,'Supervisor Name',NULL,NULL,'"drvSupervisorName"','(''UA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '27',@AdhSystemID,'50','D','10','27',NULL,'Function',NULL,NULL,'"drvFunction"','(''UA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '28',@AdhSystemID,'50','D','10','28',NULL,'Division',NULL,NULL,'"drvDivision"','(''UA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '29',@AdhSystemID,'50','D','10','29',NULL,'Department',NULL,NULL,'"drvDepartment"','(''UA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '30',@AdhSystemID,'50','D','10','30',NULL,'Location',NULL,NULL,'"drvLocation"','(''UA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '31',@AdhSystemID,'50','D','10','31',NULL,'JobFamily',NULL,NULL,'"drvJobFamily"','(''UA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '32',@AdhSystemID,'50','D','10','32',NULL,'DateofLastHire',NULL,NULL,'"drvDateofLastHire"','(''UD101''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '33',@AdhSystemID,'50','D','10','33',NULL,'DateInJob',NULL,NULL,'"drvDateInJob"','(''UD101''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '34',@AdhSystemID,'50','D','10','34',NULL,'EEID',NULL,NULL,'"drvEEID1"','(''UA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '35',@AdhSystemID,'50','D','10','35',NULL,'Employee Number',NULL,NULL,'"drvEmployeeNumber"','(''UA''=''Q'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'50','D','20','1',NULL,'groupCode',NULL,NULL,'"drvgroupCode"','(''UA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'50','D','20','2',NULL,'groupName',NULL,NULL,'"drvgroupName"','(''UA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'50','D','20','3',NULL,'groupStatus',NULL,NULL,'"drvgroupStatus"','(''UA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'50','D','20','4',NULL,'groupTypeCode',NULL,NULL,'"drvgrouptypeCode"','(''UA''=''Q,'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '5',@AdhSystemID,'50','D','20','5',NULL,'parentGroupCode',NULL,NULL,'"drvparentGroupCode"','(''UA''=''Q'')';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expCOIDList,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,'Groups File Only','201702019','EMPEXPORT','GROUPS','Feb 01 2017 12:00AM','@CustomFormatCode',NULL,NULL,NULL,'201702019','Feb 01 2017 12:00AM','Dec 30 1899 12:00AM','201702011',NULL,'','','201702011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL,NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expCOIDList,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Groups File','201702019','EMPEXPORT','SHDGROUPS','Feb 01 2017 12:00AM','@CustomFormatCode',NULL,NULL,NULL,'201702019','Feb 01 2017 12:00AM','Dec 30 1899 12:00AM','201702011',NULL,'','','201702011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL,NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expCOIDList,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled User File','201702019','EMPEXPORT','SHDUSER','Feb 01 2017 12:00AM','@CustomFormatCode',NULL,NULL,NULL,'201702019','Feb 01 2017 12:00AM','Dec 30 1899 12:00AM','201702011',NULL,'','','201702011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL,NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expCOIDList,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,'User File Only','201702019','EMPEXPORT','USER','Feb 01 2017 12:00AM','@CustomFormatCode',NULL,NULL,NULL,'201702019','Feb 01 2017 12:00AM','Dec 30 1899 12:00AM','201702011',NULL,'','','201702011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL,NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expCOIDList,expIEXSystemID) SELECT 'File Name is Auto Generated to I:\Exports\TTN\Groups\ Folder Only',NULL,NULL,NULL,NULL,NULL,NULL,'Test Groups File Only','201702019','EMPEXPORT','TESTGROUPS','Feb 01 2017 12:00AM','@CustomFormatCode',NULL,NULL,NULL,'201702019','Feb 01 2017 12:00AM','Dec 30 1899 12:00AM','201702011',NULL,'','','201702011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL,NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expCOIDList,expIEXSystemID) SELECT 'File Name is Auto Generated to I:\Exports\TTN\User\ Folder Only',NULL,NULL,NULL,NULL,NULL,NULL,'Test User File Only','201702019','EMPEXPORT','TESTUSER','Feb 01 2017 12:00AM','@CustomFormatCode',NULL,NULL,NULL,'201702019','Feb 01 2017 12:00AM','Dec 30 1899 12:00AM','201702011',NULL,'','','201702011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL,NULL;
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','ExportPath','V','@FileExportPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','TestPath','V','@FileTestPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','UDESPath','C','@FileUDESPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','UseFileName','V','N');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','USER','H','02','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','USER','D','20','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','SHDUSER','H','02','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','SHDUSER','D','20','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','GROUPS','H','01','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','GROUPS','D','10','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','SHDGROUPS','H','01','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','SHDGROUPS','D','10','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','TESTUSER','H','02','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','TESTUSER','D','20','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','TESTGROUPS','H','01','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','TESTGROUPS','D','10','Y','C');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D10','dbo.U_@CustomFormatCode_drvTbl_User',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D20','dbo.U_@CustomFormatCode_drvTbl_Groups',NULL);
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
XXX                    XX/XX/XXXX        XXX                       XXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.AscExp WHERE expFormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_RecordSetDetails WHERE FormatCode = '@CustomFormatCode'; -- Skip RecordSet By ExportCodes
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = '@CustomFormatCode' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'USER';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'GROUPS';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'TESTUSER';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'TESTGROUPS';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'SHDUSER';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'SHDGROUPS';

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
         @StartPerControl = CASE WHEN ExportCode LIKE 'SHD%' THEN CONVERT(CHAR(8),DATEADD(DAY,-1,GETDATE()),112) + '1'
                                 ELSE StartPerControl
                            END
        ,@EndPerControl   = CASE WHEN ExportCode LIKE 'SHD%' THEN CONVERT(CHAR(8),GETDATE(),112) + '9'
                                 ELSE EndPerControl
                            END
        ,@StartDate       = CASE WHEN ExportCode LIKE 'SHD%' THEN DATEADD(DAY,-1,GETDATE())
                                 ELSE CAST(LEFT(StartPerControl,8) AS DATETIME)
                            END
        ,@EndDate         = CASE WHEN ExportCode LIKE 'SHD%' THEN GETDATE()
                                 ELSE DATEADD(SS,-1,DATEADD(DD,1,LEFT(EndPerControl,8)))
                            END
        ,@FormatCode      = FormatCode
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = '@CustomFormatCode';

    PRINT 'Start Date: ' + CONVERT(VARCHAR(26),@StartDate,100);
    PRINT 'End Date:  ' + CONVERT(VARCHAR(26),@EndDate,100);

    --==========================================
    -- Audit Section
    --==========================================
    IF OBJECT_ID('U_@CustomFormatCode_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_Audit;
    SELECT
        audKey1 = audKey1Value
        ,audKey2 = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    INTO dbo.U_@CustomFormatCode_Audit
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.vw_AuditData WITH (NOLOCK)
        ON audKey1Value = xEEID
        AND audKey2Value = xCOID
        AND audTableName = 'EmpComp'
        AND audFieldName = 'EecEmplStatus'
    WHERE audDateTime BETWEEN DATEADD(DAY,-30,@EndDate) AND @EndDate
    AND audAction <> 'DELETE'
    AND ISNULL(audNewValue,'') = 'T';

    -----------------------------------------------
    -- Load OrgStatus Changes from OrgLevel Table
    -----------------------------------------------
    INSERT INTO dbo.U_@CustomFormatCode_Audit (audKey1,audKey2,audKey3,audTableName,audFieldName,audAction,audDateTime,audOldValue,audNewValue,audRowNo)
    SELECT
        audKey1 = audKey1Value
        ,audKey2 = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    FROM dbo.vw_AuditData WITH (NOLOCK)
    WHERE audDateTime BETWEEN DATEADD(DAY,-30,@EndDate) AND @EndDate
    AND audTableName = 'OrgLevel'
    AND audFieldName = 'OrgStatus'
    AND audAction <> 'DELETE'
    AND ISNULL(audOldValue,'') = 'A'
    AND ISNULL(audNewValue,'') = 'I';

    ---------------------------------------------------------------------------------------
    -- Retain Most Recent Audit Record by AudKey1, AudKey2, AudKey3 and Audit Field Name
    ---------------------------------------------------------------------------------------
    DELETE FROM dbo.U_@CustomFormatCode_Audit WHERE audRowNo > 1;

    --==========================================
    -- Clean EE List
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_@CustomFormatCode_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCoID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_@CustomFormatCode_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    -- Remove Terminated Employees NOT Found in Audit
    DELETE FROM dbo.U_@CustomFormatCode_EEList
    FROM dbo.U_@CustomFormatCode_EEList
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    WHERE EecEmplStatus = 'T'
    AND NOT EXISTS (SELECT 1 FROM dbo.U_@CustomFormatCode_Audit WHERE audKey1 = xEEID AND audFieldName = 'EecEmplStatus');

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
    AS ( -- Get All Active Employees with Level 1 and 2 Supervisor Information
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
		-- Primary Group Information must match Group information on Group File
        ,drvprimaryGroupCode = CASE WHEN Supervisor = 'Y' THEN EecEmpNo
                                    ELSE COALESCE(Supervisor1EmpNo,Supervisor2EmpNo)
                               END
        ,drvprimaryGroupName = CASE WHEN Supervisor = 'Y' THEN EmpName
									ELSE COALESCE(Supervisor1Name,Supervisor2Name)
                               END
        ,drvprimaryGroupRoleCode = CASE WHEN Supervisor = 'N' THEN 'USR'
                                        WHEN Supervisor = 'Y' AND EXISTS (SELECT 1 FROM dbo.U_ETTNUSERS_Supervisors S1 WHERE S1.Supervisor1EEID = xEEID AND Supervisor = 'Y') THEN 'ADM'
                                        ELSE 'MGR'
                                   END
        ,drvprimaryGroupRoleName = CASE WHEN Supervisor = 'N' THEN 'User'
                                        WHEN Supervisor = 'Y' AND EXISTS (SELECT 1 FROM dbo.U_ETTNUSERS_Supervisors S1 WHERE S1.Supervisor1EEID = xEEID AND Supervisor = 'Y') THEN 'Administrator'
                                        ELSE 'Manager'
                                   END
		-- Opt Group Information must match Group information on Group File
        ,drvoptGroupCode1 = EecOrgLvl3
        ,drvoptGroupName1 = ISNULL(RTRIM(EecOrgLvl3),'') + ' - ' + ISNULL(O3.OrgDesc,'')
        ,drvoptGroupCode2 = EecJobCode
        ,drvoptGroupName2 = COALESCE(NULLIF(JbcLongDesc,''),JbcDesc)
        ,drvoptGroupCode3 = EecLocation
        ,drvoptGroupName3 = LocDesc
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

    /*_____________________________________________________________________________________________________________________

        BUILD GROUPS FILE

            1.  Constant - 'Company'
            2.  Department
            3.  Division
            4.  Function
            5.  Constant - 'FUNCTION, DIVISION, DEPARTMENT'
            6.  Constant - 'JOB'
            7.  Job Family
            8.  Job Tile
            9.  Constant - 'LOCATION'
            10. Location
            11. Officer, Director, Mgr, Sup
            12. Constant - 'OFFICER, DIRECTOR, MGR, SUP'

		NOTE: The "GroupCode" must be created before it's a "ParentCode" on a subsequent record
    ______________________________________________________________________________________________________________________*/

    ----------------------------
    -- WORKING TABLE - Groups
    ----------------------------
    IF OBJECT_ID('U_@CustomFormatCode_Groups','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_Groups;
    CREATE TABLE dbo.U_@CustomFormatCode_Groups (
         GroupCode        VARCHAR(100)
        ,GroupName        VARCHAR(100)
        ,GroupStatus      VARCHAR(10)
        ,GroupTypeCode    VARCHAR(100)
        ,ParentGroupCode  VARCHAR(100)
        ,InitialSort      VARCHAR(10)
        ,SubSort          VARCHAR(10)
    );

    ----------------------------------
    -- Group 1 - Company (Constant)
    ----------------------------------
    INSERT INTO dbo.U_@CustomFormatCode_Groups (GroupCode,GroupName,GroupStatus,GroupTypeCode,ParentGroupCode,InitialSort,SubSort)
    VALUES ('[GroupCode]','[GroupName]','Active','Company',NULL,'01','1');

    ----------------------------
    -- Group 2 - Department
    ----------------------------
    INSERT INTO dbo.U_@CustomFormatCode_Groups (GroupCode,GroupName,GroupStatus,GroupTypeCode,ParentGroupCode,InitialSort,SubSort)
    SELECT DISTINCT
         GroupCode = O3.OrgCode
        ,GroupName = RTRIM(O3.OrgCode) + ' - ' + ISNULL(LTRIM(O3.OrgDesc),'')
        ,GroupStatus = CASE O3.OrgStatus
                            WHEN 'I' THEN 'Inactive'
                            ELSE 'Active'
                       END
        ,GroupTypeCode = 'Department'
        ,ParentGroupCode = RTRIM(O2.OrgCode) + ' - ' + ISNULL(LTRIM(O2.OrgReportCategory),'')
        ,InitialSort = '02'
        ,SubSort = dbo.dsi_fnPadZero(DENSE_RANK() OVER (ORDER BY O3.OrgCode),3,0)
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCoID = xCoID
    JOIN dbo.OrgLevel O3 WITH (NOLOCK)
        ON EecOrgLvl3 = O3.OrgCode
        AND O3.OrgLvl = '3'
    JOIN dbo.OrgLevel O2 WITH (NOLOCK)
        ON EecOrgLvl2 = O2.OrgCode
        AND O2.OrgLvl = '2'
    WHERE ((O3.OrgStatus = 'A')
        OR EXISTS(SELECT 1 FROM dbo.U_@CustomFormatCode_Audit WHERE audKey2 = O3.OrgCode AND audKey1 = '3')
    );

    ----------------------------
    -- Group 3 - Division
    ----------------------------
    INSERT INTO dbo.U_@CustomFormatCode_Groups (GroupCode,GroupName,GroupStatus,GroupTypeCode,ParentGroupCode,InitialSort,SubSort)
    SELECT DISTINCT
         GroupCode = RTRIM(O2.OrgCode) + ' - ' + ISNULL(LTRIM(O2.OrgReportCategory),'')
        ,GroupName = O2.OrgDesc
        ,GroupStatus = CASE O2.OrgStatus
                            WHEN 'I' THEN 'Inactive'
                            ELSE 'Active'
                       END
        ,GroupTypeCode = 'Division'
        ,ParentGroupCode = RTRIM(O1.OrgCode) + ' - ' + ISNULL(LTRIM(O1.OrgReportCategory),'')
        ,InitialSort = '03'
        ,SubSort = dbo.dsi_fnPadZero(DENSE_RANK() OVER (ORDER BY O2.OrgCode),3,0)
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCoID = xCoID
    JOIN dbo.OrgLevel O2 WITH (NOLOCK)
        ON EecOrgLvl2 = O2.OrgCode
        AND O2.OrgLvl = '2'
    JOIN dbo.OrgLevel O1 WITH (NOLOCK)
        ON EecOrgLvl1 = O1.OrgCode
        AND O1.OrgLvl = '1'
    WHERE ((O2.OrgStatus = 'A')
        OR EXISTS(SELECT 1 FROM dbo.U_@CustomFormatCode_Audit WHERE audKey2 = O2.OrgCode AND audKey1 = '2')
    );

    ----------------------------
    -- Group 4 - Function
    ----------------------------
    INSERT INTO dbo.U_@CustomFormatCode_Groups (GroupCode,GroupName,GroupStatus,GroupTypeCode,ParentGroupCode,InitialSort,SubSort)
    SELECT DISTINCT
         GroupCode = RTRIM(O1.OrgCode) + ' - ' + ISNULL(LTRIM(O1.OrgReportCategory),'')
        ,GroupName = O1.OrgDesc
        ,GroupStatus = CASE O1.OrgStatus
                            WHEN 'I' THEN 'Inactive'
                            ELSE 'Active'
                       END
        ,GroupTypeCode = 'Function'
        ,ParentGroupCode = 'FUNCTION, DIVISION, DEPARTMENT'
        ,InitialSort = '04'
        ,SubSort = dbo.dsi_fnPadZero(DENSE_RANK() OVER (ORDER BY O1.OrgCode),3,0)
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCoID = xCoID
    JOIN dbo.OrgLevel O1 WITH (NOLOCK)
        ON EecOrgLvl1 = O1.OrgCode
        AND O1.OrgLvl = '1'
    WHERE ((O1.OrgStatus = 'A')
        OR EXISTS(SELECT 1 FROM dbo.U_@CustomFormatCode_Audit WHERE audKey2 = O1.OrgCode AND audKey1 = '1')
    );

    --------------------------------------------------------
    -- Group 5 - FUNCTION, DIVISION, DEPARTMENT (Constant)
    --------------------------------------------------------
    INSERT INTO dbo.U_@CustomFormatCode_Groups (GroupCode,GroupName,GroupStatus,GroupTypeCode,ParentGroupCode,InitialSort,SubSort)
    SELECT DISTINCT
         GroupCode = 'FUNCTION, DIVISION, DEPARTMENT'
        ,GroupName = 'Function, Division, Department'
        ,GroupStatus = 'Active'
        ,GroupTypeCode = 'Function, Division, Department'
        ,ParentGroupCode = CmpCompanyCode
        ,InitialSort = '05'
        ,SubSort = dbo.dsi_fnPadZero(DENSE_RANK() OVER (ORDER BY CmpCompanyCode),3,0)
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.Company WITH (NOLOCK)
        ON CmpCOID = xCOID;

    -----------------------------
    -- Group 6 - JOB (Constant)
    -----------------------------
    INSERT INTO dbo.U_@CustomFormatCode_Groups (GroupCode,GroupName,GroupStatus,GroupTypeCode,ParentGroupCode,InitialSort,SubSort)
    SELECT DISTINCT
         GroupCode = 'JOB'
        ,GroupName = 'JOB'
        ,GroupStatus = 'Active'
        ,GroupTypeCode = 'Job'
        ,ParentGroupCode = CmpCompanyCode
        ,InitialSort = '06'
        ,SubSort = dbo.dsi_fnPadZero(DENSE_RANK() OVER (ORDER BY CmpCompanyCode),3,0)
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.Company WITH (NOLOCK)
        ON CmpCOID = xCoID;

    ---------------------------
    -- Group 7 - Job Family
    ---------------------------
    INSERT INTO dbo.U_@CustomFormatCode_Groups (GroupCode,GroupName,GroupStatus,GroupTypeCode,ParentGroupCode,InitialSort,SubSort)
    SELECT DISTINCT
         GroupCode = RTRIM(JbcJobFamily) + ' - ' + ISNULL(LTRIM(CodDesc),'')
        ,GroupName = CodDesc
        ,GroupStatus = CASE JbcStatus
                            WHEN 'I' THEN 'Inactive'
                            ELSE 'Active'
                       END
        ,GroupTypeCode = 'Job Family'
        ,ParentGroupCode = 'JOB'
        ,InitialSort = '07'
        ,SubSort = dbo.dsi_fnPadZero(DENSE_RANK() OVER (ORDER BY JbcJobFamily),3,0)
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCoID = xCoID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    LEFT JOIN dbo.Codes JOBFAMILY WITH (NOLOCK)
        ON JOBFAMILY.CodCode = JbcJobFamily
        AND JOBFAMILY.CodTable = 'JOBFAMILY';

    ---------------------------
    -- Group 8 - Job Title
    ---------------------------
    INSERT INTO dbo.U_@CustomFormatCode_Groups (GroupCode,GroupName,GroupStatus,GroupTypeCode,ParentGroupCode,InitialSort,SubSort)
    SELECT DISTINCT
         GroupCode = JbcJobCode
        ,GroupName = JbcLongDesc
        ,GroupStatus = CASE JbcStatus
                            WHEN 'I' THEN 'Inactive'
                            ELSE 'Active'
                       END
        ,GroupTypeCode = 'Job Title'
        ,ParentGroupCode = RTRIM(JbcJobFamily) + ' - ' + ISNULL(LTRIM(CodDesc),'')
        ,InitialSort = '08'
        ,SubSort = dbo.dsi_fnPadZero(DENSE_RANK() OVER (ORDER BY JbcJobCode),3,0)
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCoID = xCoID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    LEFT JOIN dbo.Codes JOBFAMILY WITH (NOLOCK)
        ON JOBFAMILY.CodCode = JbcJobFamily
        AND JOBFAMILY.CodTable = 'JOBFAMILY';

    ----------------------------------
    -- Group 9 - Location (Constant)
    ----------------------------------
    INSERT INTO dbo.U_@CustomFormatCode_Groups (GroupCode,GroupName,GroupStatus,GroupTypeCode,ParentGroupCode,InitialSort,SubSort)
    SELECT DISTINCT
         GroupCode = 'LOCATION'
        ,GroupName = 'Location'
        ,GroupStatus = 'Active'
        ,GroupTypeCode = 'Location'
        ,ParentGroupCode = CmpCompanyCode
        ,InitialSort = '09'
        ,SubSort = dbo.dsi_fnPadZero(DENSE_RANK() OVER (ORDER BY CmpCompanyCode),3,0)
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.Company WITH (NOLOCK)
        ON CmpCOID = xCoID;

    ---------------------------
    -- Group 10 - Location
    ---------------------------
    INSERT INTO dbo.U_@CustomFormatCode_Groups (GroupCode,GroupName,GroupStatus,GroupTypeCode,ParentGroupCode,InitialSort,SubSort)
    SELECT DISTINCT
         GroupCode = LocCode
        ,GroupName = LocDesc
        ,GroupStatus = 'Active'
        ,GroupTypeCode = 'Location'
        ,ParentGroupCode = 'LOCATION'
        ,InitialSort = '10'
        ,SubSort = dbo.dsi_fnPadZero(DENSE_RANK() OVER (ORDER BY LocCode),3,0)
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCoID = xCoID
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    JOIN dbo.Company WITH (NOLOCK)
        ON CmpCOID = xCoID;

    --------------------------------------------------------
    -- Group 11 - Officer, Director, Mgr, Sup (Employees)
    --------------------------------------------------------
    INSERT INTO dbo.U_@CustomFormatCode_Groups (GroupCode,GroupName,GroupStatus,GroupTypeCode,ParentGroupCode,InitialSort,SubSort)
    SELECT DISTINCT
         GroupCode = EmpEmpNo
        ,GroupName = EmpName
        ,GroupStatus = 'Active'
        ,GroupTypeCode = 'Officer, Director, Mgr, Sup'
        ,ParentGroupCode = CASE WHEN Supervisor1EmpNo = EmpEmpNo THEN 'OFFICER, DIRECTOR, MGR, SUP'
                                ELSE Supervisor1EmpNo
                           END
        ,InitialSort = '11'
        ,SubSort = dbo.dsi_fnPadZero(DENSE_RANK() OVER (ORDER BY Supervisor1EmpNo),3,0)
    FROM dbo.U_@CustomFormatCode_Supervisors S WITH (NOLOCK)
    WHERE EXISTS (SELECT 1 FROM dbo.U_@CustomFormatCode_Supervisors E WITH (NOLOCK) WHERE E.Supervisor1EmpNo = S.EmpEmpNo);

    ------------------------------------------------------
    -- Group 12 - Officer, Director, Mgr, Sup (Constant)
    ------------------------------------------------------
    INSERT INTO dbo.U_@CustomFormatCode_Groups (GroupCode,GroupName,GroupStatus,GroupTypeCode,ParentGroupCode,InitialSort,SubSort)
    SELECT DISTINCT
         GroupCode = 'OFFICER, DIRECTOR, MGR, SUP'
        ,GroupName = 'Officers, Directors, Managers, Supervisors'
        ,GroupStatus = 'Active'
        ,GroupTypeCode = 'Officer, Director, Mgr, Sup'
        ,ParentGroupCode = CmpCompanyCode
        ,InitialSort = '12'
        ,SubSort = dbo.dsi_fnPadZero(DENSE_RANK() OVER (ORDER BY CmpCompanyCode),3,0)
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.Company WITH (NOLOCK)
        ON CmpCOID = xCoID;

    ---------------------------------
    -- DETAIL RECORD - Groups File
    ---------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_Groups','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_Groups;
    SELECT DISTINCT
        drvgroupCode = GroupCode
        ,drvgroupName = GroupName
        ,drvgroupStatus = GroupStatus
        ,drvgroupTypeCode = GroupTypeCode
        ,drvparentGroupCode = ParentGroupCode
        ,drvInitialSort = InitialSort
        ,drvSubSort = SubSort
    INTO dbo.U_@CustomFormatCode_drvTbl_Groups
    FROM dbo.U_@CustomFormatCode_Groups WITH (NOLOCK);

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable('@CustomFormatCode','UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN ExportCode = 'TESTUSER' THEN 'Users\[CoCode]_TTN_USER_TEST_'
                                  WHEN ExportCode = 'TESTGROUPS' THEN 'Groups\[CoCode]_TTN_GROUPS_TEST_'
                                  WHEN ExportCode LIKE '%USER%' THEN 'Users\[CoCode]_TTN_USER_'
                                  WHEN ExportCode LIKE '%GROUPS%' THEN 'Groups\[CoCode]_TTN_GROUPS_'
                                  ELSE ''
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
    SET ExpLastStartPerControl = '201702011'
       ,ExpStartPerControl     = '201702011'
       ,ExpLastEndPerControl   = '201702019'
       ,ExpEndPerControl       = '201702019'
WHERE ExpFormatCode = '@CustomFormatCode';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vw@CustomFormatCode_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_@CustomFormatCode_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;
GO