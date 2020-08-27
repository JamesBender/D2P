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
@CustomFormatCode - Replace with Format Code (i.e., EICIMSCORE)
@CustomFormatName - Replace with Name of Interface (AdfFormatName) (i.e., ICIMS Core Data Export )
@IsWebFlag - Replace with 'Y' (Yes) or 'N' (No) for Web Interface Settings

-- File parameters
@FileExportPath - Replace with the Export Path usually UDES Path (i.e., \\us.saas\e0\data_exchange\[Client ARNum]\Exports\)
@FileTestPath - Replace with the Test Path (i.e., \\us.saas\e1\Public\[Client ARNum]\Exports\[Vendor]\)

*/
IF OBJECT_ID('dsi_sp_BuildDriverTables_@CustomFormatCode') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_@CustomFormatCode];
GO
IF OBJECT_ID('dsi_sp_AfterCollect_@CustomFormatCode') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_AfterCollect_@CustomFormatCode];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_Loc') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_Loc];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_Job') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_Job];
GO
IF OBJECT_ID('U_@CustomFormatCode_File') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_File];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_Emp') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_Emp];
GO
IF OBJECT_ID('U_@CustomFormatCode_EEList') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_EEList];
GO
IF OBJECT_ID('U_@CustomFormatCode_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_AuditFields];
GO
IF OBJECT_ID('U_@CustomFormatCode_Audit') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_Audit];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = '@CustomFormatCode';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = '@CustomFormatCode';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = '@CustomFormatCode';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = '@CustomFormatCode';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = '@CustomFormatCode';
GO

DECLARE @AdhSystemID VARCHAR(12), @FixedFormatName1 VARCHAR(50), @FixedFormatName2 VARCHAR(30);
SET @AdhSystemID = LEFT('@CustomFormatCode' + REPLICATE('0',10),10) + 'Z0';
SET @FixedFormatName1 = LEFT('@CustomFormatName',50);
SET @FixedFormatName2 = LEFT('@CustomFormatName',30);

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) SELECT 'N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','@CustomFormatCode',@FixedFormatName1,'N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N',@AdhSystemID,'N','Jan  1 1900 12:00AM','C','N',NULL,'N';
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"systemID"','1','(''DA''=''Q,'')',@AdhSystemID,'50','H','01','1',NULL,'systemID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"externalID"','2','(''DA''=''Q,'')',@AdhSystemID,'50','H','01','2',NULL,'externalID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"folder"','3','(''DA''=''Q,'')',@AdhSystemID,'50','H','01','3',NULL,'folder',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"firstName"','4','(''DA''=''Q,'')',@AdhSystemID,'50','H','01','4',NULL,'firstName',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"middleName"','5','(''DA''=''Q,'')',@AdhSystemID,'50','H','01','5',NULL,'middleName',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"lastName"','6','(''DA''=''Q,'')',@AdhSystemID,'50','H','01','6',NULL,'lastName',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"email"','7','(''DA''=''Q,'')',@AdhSystemID,'50','H','01','7',NULL,'email',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"loginGroup"','8','(''DA''=''Q,'')',@AdhSystemID,'50','H','01','8',NULL,'loginGroup',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"isemployeerole"','9','(''DA''=''Q,'')',@AdhSystemID,'50','H','01','9',NULL,'isemployeerole',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"iscandidaterole"','10','(''DA''=''Q,'')',@AdhSystemID,'50','H','01','10',NULL,'iscandidaterole',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"ismanagerrole"','11','(''DA''=''Q,'')',@AdhSystemID,'50','H','01','11',NULL,'ismanagerrole',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"empsupervisorexternalid"','12','(''DA''=''Q,'')',@AdhSystemID,'50','H','01','12',NULL,'empsupervisorexternalid',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"workphone"','13','(''DA''=''Q,'')',@AdhSystemID,'50','H','01','13',NULL,'workphone',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"emphiredate"','14','(''DA''=''Q,'')',@AdhSystemID,'50','H','01','14',NULL,'emphiredate',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"empstartdate"','15','(''DA''=''Q,'')',@AdhSystemID,'50','H','01','15',NULL,'empstartdate',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"empenddate"','16','(''DA''=''Q,'')',@AdhSystemID,'50','H','01','16',NULL,'empenddate',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"empjobtitle"','17','(''DA''=''Q,'')',@AdhSystemID,'50','H','01','17',NULL,'empjobtitle',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"rcf2003"','18','(''DA''=''Q'')',@AdhSystemID,'50','H','01','18',NULL,'rcf2003',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"externalid"','1','(''DA''=''Q,'')',@AdhSystemID,'50','H','02','1',NULL,'externalid',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"jobtitle"','2','(''DA''=''Q,'')',@AdhSystemID,'50','H','02','2',NULL,'jobtitle',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"jobnumber"','3','(''DA''=''Q,'')',@AdhSystemID,'50','H','02','3',NULL,'jobnumber',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"folder"','4','(''DA''=''Q,'')',@AdhSystemID,'50','H','02','4',NULL,'folder',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"eeocategorylevel1"','5','(''DA''=''Q,'')',@AdhSystemID,'50','H','02','5',NULL,'eeocategorylevel1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"qualifications"','6','(''DA''=''Q,'')',@AdhSystemID,'50','H','02','6',NULL,'qualifications',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"responsibilities"','7','(''DA''=''Q,'')',@AdhSystemID,'50','H','02','7',NULL,'responsibilities',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"overview"','8','(''DA''=''Q,'')',@AdhSystemID,'50','H','02','8',NULL,'overview',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"jobtype"','9','(''DA''=''Q,'')',@AdhSystemID,'50','H','02','9',NULL,'jobtype',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"positiontype"','10','(''DA''=''Q,'')',@AdhSystemID,'50','H','02','10',NULL,'positiontype',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"salarymin"','11','(''DA''=''Q,'')',@AdhSystemID,'50','H','02','11',NULL,'salarymin',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"salarymincurrency"','12','(''DA''=''Q,'')',@AdhSystemID,'50','H','02','12',NULL,'salarymincurrency',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"salarymintype"','13','(''DA''=''Q,'')',@AdhSystemID,'50','H','02','13',NULL,'salarymintype',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"salarymax"','14','(''DA''=''Q,'')',@AdhSystemID,'50','H','02','14',NULL,'salarymax',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"salarymaxcurrency"','15','(''DA''=''Q,'')',@AdhSystemID,'50','H','02','15',NULL,'salarymaxcurrency',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"salarymaxtype"','16','(''DA''=''Q'')',@AdhSystemID,'50','H','02','16',NULL,'salarymaxtype',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Externalid"','1','(''DA''=''Q,'')',@AdhSystemID,'50','H','03','1',NULL,'Externalid',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Firstname"','2','(''DA''=''Q,'')',@AdhSystemID,'50','H','03','2',NULL,'Firstname',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"folder"','3','(''DA''=''Q,'')',@AdhSystemID,'50','H','03','3',NULL,'folder',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"street"','4','(''DA''=''Q,'')',@AdhSystemID,'50','H','03','4',NULL,'street',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"street2"','5','(''DA''=''Q,'')',@AdhSystemID,'50','H','03','5',NULL,'street2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"city"','6','(''DA''=''Q,'')',@AdhSystemID,'50','H','03','6',NULL,'city',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"state"','7','(''DA''=''Q,'')',@AdhSystemID,'50','H','03','7',NULL,'state',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"zip"','8','(''DA''=''Q,'')',@AdhSystemID,'50','H','03','8',NULL,'zip',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"country"','9','(''DA''=''Q,'')',@AdhSystemID,'50','H','03','9',NULL,'country',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"addressid"','10','(''DA''=''Q'')',@AdhSystemID,'50','H','03','10',NULL,'addressid',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Externalid"','1','(''DA''=''Q,'')',@AdhSystemID,'50','H','04','1',NULL,'Externalid',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Firstname"','2','(''DA''=''Q,'')',@AdhSystemID,'50','H','04','2',NULL,'Firstname',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"folder"','3','(''DA''=''Q,'')',@AdhSystemID,'50','H','04','3',NULL,'folder',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Rcf2018"','4','(''DA''=''Q,'')',@AdhSystemID,'50','H','04','4',NULL,'Rcf2018',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Rcf2019"','5','(''DA''=''Q'')',@AdhSystemID,'50','H','04','5',NULL,'Rcf2019',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSystemID"','1','(''UA''=''Q,'')',@AdhSystemID,'50','D','10','1',NULL,'systemID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvExternalid"','2','(''UA''=''Q,'')',@AdhSystemID,'50','D','10','2',NULL,'externalID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvFolder"','3','(''UA''=''Q,'')',@AdhSystemID,'50','D','10','3',NULL,'folder',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvNameFirst"','4','(''UA''=''Q,'')',@AdhSystemID,'50','D','10','4',NULL,'firstName',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvNameMiddle"','5','(''UA''=''Q,'')',@AdhSystemID,'50','D','10','5',NULL,'middleName',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvNameLast"','6','(''UA''=''Q,'')',@AdhSystemID,'50','D','10','6',NULL,'lastName',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAddressEmail "','7','(''UA''=''Q,'')',@AdhSystemID,'50','D','10','7',NULL,'email',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLoginGroup"','8','(''UA''=''Q,'')',@AdhSystemID,'50','D','10','8',NULL,'loginGroup',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"1"','9','(''DA''=''Q,'')',@AdhSystemID,'50','D','10','9',NULL,'isemployeerole',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"1"','10','(''DA''=''Q,'')',@AdhSystemID,'50','D','10','10',NULL,'iscandidaterole',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvIsmanagerrole"','11','(''UA''=''Q,'')',@AdhSystemID,'50','D','10','11',NULL,'ismanagerrole',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvsupervisorId"','12','(''UA''=''Q,'')',@AdhSystemID,'50','D','10','12',NULL,'empsupervisorexternalid',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPhoneBusinessNumber"','13','(''UA''=''Q,'')',@AdhSystemID,'50','D','10','13',NULL,'workphone',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDateofLastHire"','14','(''UD101''=''Q,'')',@AdhSystemID,'50','D','10','14',NULL,'emphiredate',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmpStartDate"','15','(''UD101''=''Q,'')',@AdhSystemID,'50','D','10','15',NULL,'empstartdate',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDateofTermination"','16','(''UD101''=''Q,'')',@AdhSystemID,'50','D','10','16',NULL,'empenddate',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmpjobtitle"','17','(''UA''=''Q,'')',@AdhSystemID,'50','D','10','17',NULL,'empjobtitle',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvRCF2003"','18','(''UA''=''Q'')',@AdhSystemID,'50','D','10','18',NULL,'rcf2003',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvExternalid"','1','(''UA''=''Q,'')',@AdhSystemID,'50','D','20','1',NULL,'externalid',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvJobTitle"','2','(''UA''=''Q,'')',@AdhSystemID,'50','D','20','2',NULL,'jobtitle',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvJobCode"','3','(''UA''=''Q,'')',@AdhSystemID,'50','D','20','3',NULL,'jobnumber',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvFolder"','4','(''UA''=''Q,'')',@AdhSystemID,'50','D','20','4',NULL,'folder',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEeoCategoryLevel1"','5','(''UA''=''Q,'')',@AdhSystemID,'50','D','20','5',NULL,'eeocategorylevel1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','6','(''SS''=''Q,'')',@AdhSystemID,'50','D','20','6',NULL,'qualifications',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','7','(''SS''=''Q,'')',@AdhSystemID,'50','D','20','7',NULL,'responsibilities',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','8','(''SS''=''Q,'')',@AdhSystemID,'50','D','20','8',NULL,'overview',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvJobType"','9','(''UA''=''Q,'')',@AdhSystemID,'50','D','20','9',NULL,'jobtype',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPositionType"','10','(''UA''=''Q,'')',@AdhSystemID,'50','D','20','10',NULL,'positiontype',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','11','(''SS''=''Q,'')',@AdhSystemID,'50','D','20','11',NULL,'salarymin',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','12','(''SS''=''Q,'')',@AdhSystemID,'50','D','20','12',NULL,'salarymincurrency',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','13','(''SS''=''Q,'')',@AdhSystemID,'50','D','20','13',NULL,'salarymintype',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','14','(''SS''=''Q,'')',@AdhSystemID,'50','D','20','14',NULL,'salarymax',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','15','(''SS''=''Q,'')',@AdhSystemID,'50','D','20','15',NULL,'salarymaxcurrency',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','16','(''SS''=''Q'')',@AdhSystemID,'50','D','20','16',NULL,'salarymaxtype',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvExternalid"','1','(''UA''=''Q,'')',@AdhSystemID,'50','D','30','1',NULL,'Externalid',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDesc"','2','(''UA''=''Q,'')',@AdhSystemID,'50','D','30','2',NULL,'Firstname',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvFolder"','3','(''UA''=''Q,'')',@AdhSystemID,'50','D','30','3',NULL,'folder',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAddressLine1"','4','(''UA''=''Q,'')',@AdhSystemID,'50','D','30','4',NULL,'street',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAddressLine2"','5','(''UA''=''Q,'')',@AdhSystemID,'50','D','30','5',NULL,'street2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAddressCity"','6','(''UA''=''Q,'')',@AdhSystemID,'50','D','30','6',NULL,'city',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAddressState"','7','(''UA''=''Q,'')',@AdhSystemID,'50','D','30','7',NULL,'state',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAddressZipCode"','8','(''UA''=''Q,'')',@AdhSystemID,'50','D','30','8',NULL,'zip',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAddresscountry"','9','(''UA''=''Q,'')',@AdhSystemID,'50','D','30','9',NULL,'country',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','10','(''SS''=''Q'')',@AdhSystemID,'50','D','30','10',NULL,'addressid',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvExternalid"','1','(''UA''=''Q,'')',@AdhSystemID,'50','D','40','1',NULL,'Externalid',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDesc"','2','(''UA''=''Q,'')',@AdhSystemID,'50','D','40','2',NULL,'Firstname',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvFolder"','3','(''UA''=''Q,'')',@AdhSystemID,'50','D','40','3',NULL,'folder',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvRcf2018"','4','(''UA''=''Q,'')',@AdhSystemID,'50','D','40','4',NULL,'Rcf2018',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvRcf2019"','5','(''UA''=''Q'')',@AdhSystemID,'50','D','40','5',NULL,'Rcf2019',NULL,NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,@FixedFormatName2,CONVERT(CHAR(8),GETDATE(),112) + '9','EMPEXPORT','ONDEMAND',NULL,'@CustomFormatCode',NULL,NULL,NULL,CONVERT(CHAR(8),GETDATE(),112) + '9',NULL,NULL,'201608011',NULL,'','',CONVERT(CHAR(8),GETDATE(),112) + '1',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session',CONVERT(CHAR(8),GETDATE(),112) + '9','EMPEXPORT','SCHEDULED',NULL,'@CustomFormatCode',NULL,NULL,NULL,CONVERT(CHAR(8),GETDATE(),112) + '9',NULL,NULL,'201608011',NULL,'','',CONVERT(CHAR(8),GETDATE(),112) + '1',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Test Purposes Only',CONVERT(CHAR(8),GETDATE(),112) + '9','EMPEXPORT','TEST',NULL,'@CustomFormatCode',NULL,NULL,NULL,CONVERT(CHAR(8),GETDATE(),112) + '9',NULL,NULL,'201608011',NULL,'','',CONVERT(CHAR(8),GETDATE(),112) + '1',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Initial Full File Only',CONVERT(CHAR(8),GETDATE(),112) + '9','EMPEXPORT','FULLFILE',NULL,'@CustomFormatCode',NULL,NULL,NULL,CONVERT(CHAR(8),GETDATE(),112) + '9',NULL,NULL,'201608011',NULL,'','',CONVERT(CHAR(8),GETDATE(),112) + '1',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','ExportPath','V','@FileExportPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','MultFile','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','TestPath','V','@FileTestPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','UDESPath','C','@FileExportPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','UseFileName','V','N');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','H01','NONE',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','H02','NONE',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','H03','NONE',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','H04','NONE',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D10','dbo.U_@CustomFormatCode_drvTbl_Emp',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D20','dbo.U_@CustomFormatCode_drvTbl_Job',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D30','dbo.U_@CustomFormatCode_drvTbl_Loc',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D40','dbo.U_@CustomFormatCode_drvTbl_Org',NULL);
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
CREATE PROCEDURE [dbo].[dsi_sp_AfterCollect_@CustomFormatCode]
AS
/************************************************************
Client Name: @CustomerName

Created By: @DeveloperName
Business Analyst: @IntegrationAnalystName
Create Date: @CreateDate
Service Request Number: @SRNumber

Purpose: GENERATE MULTIPLE FILES WITH CUSTOM BCP STATEMENT

PRODUCTION FILENAMES:
    employees_YYYYMMDD_HHMMSS.csv
    jobs_YYYYMMDD_HHMMSS.csv
    locations_YYYYMMDD_HHMMSS.csv
    orgs_YYYYMMDD_HHMMSS.csv

TEST FILENAMES:
    TEST_employees_YYYYMMDD_HHMMSS.csv
    TEST_jobs_YYYYMMDD_HHMMSS.csv
    TEST_locations_YYYYMMDD_HHMMSS.csv
    TEST_orgs_YYYYMMDD_HHMMSS.csv

Revision History
----------------
Update By            Date            Request Num                Desc        
XXXX                 XX/XX/XX        SR-20XX-000XXXXX           Added 1234

************************************************************/
BEGIN

    --==========================================
    -- Declare variables
    --==========================================
    DECLARE @FormatCode      VARCHAR(10)
        ,@ExportCode         VARCHAR(10)
        ,@ExportPath         VARCHAR(500)
        ,@dbName             VARCHAR(50)
        ,@NoEmpty            CHAR(1)
        ,@sCmd               VARCHAR(1000)
        ,@QueryInfo          VARCHAR(1000)
        ,@RowCount           INT;

    -- Set variables
    SET @FormatCode = '@CustomFormatCode';

    SELECT @ExportCode = ExportCode
       ,@ExportPath = CASE WHEN @ExportCode LIKE '%TEST%' THEN dbo.dsi_fnVariable(FormatCode,'TestPath')
                           ELSE dbo.dsi_fnVariable(FormatCode,'ExportPath')
                      END
       ,@dbName     = RTRIM(DB_NAME())
       ,@NoEmpty    = dbo.dsi_fnVariable(FormatCode,'NoEmpty')
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    -- =================================================
    -- Define Filenames By Header & Detail ID in File
    -- =================================================
    DECLARE @FilesOut AS TABLE
    (
        RowID                INT IDENTITY(1,1)
        ,RecordSetGroup      VARCHAR(100)
        ,CustomFileName      VARCHAR(1000)
    );

    -- Employee File
    INSERT INTO @FilesOut (RecordSetGroup, CustomFileName)
    SELECT RecordSetGroup = 'H01,D10'
        ,CustomFileName = CASE WHEN @ExportCode = 'TEST' OR dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'TEST_'
                               ELSE ''
                          END
                          + 'employees_' + CONVERT(VARCHAR,GETDATE(),112) + '_' + REPLACE(CONVERT(VARCHAR,GETDATE(),108),':','') + '.csv"'

    -- Job File
    INSERT INTO @FilesOut (RecordSetGroup, CustomFileName)
    SELECT RecordSetGroup = 'H02,D20'
        ,CustomFileName = CASE WHEN @ExportCode = 'TEST' OR dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'TEST_'
                               ELSE ''
                          END
                          + 'jobs_' + CONVERT(VARCHAR,GETDATE(),112) + '_' + REPLACE(CONVERT(VARCHAR,GETDATE(),108),':','') + '.csv"'

    -- Location File
    INSERT INTO @FilesOut (RecordSetGroup, CustomFileName)
    SELECT RecordSetGroup = 'H03,D30'
        ,CustomFileName = CASE WHEN @ExportCode = 'TEST' OR dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'TEST_'
                               ELSE ''
                          END
                          + 'locations_' + CONVERT(VARCHAR,GETDATE(),112) + '_' + REPLACE(CONVERT(VARCHAR,GETDATE(),108),':','') + '.csv"'

    -- OrgLevel File
    INSERT INTO @FilesOut (RecordSetGroup, CustomFileName)
    SELECT RecordSetGroup = 'H04,D40'
        ,CustomFileName = CASE WHEN @ExportCode = 'TEST' OR dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'TEST_'
                               ELSE ''
                          END
                          + 'orgs_' + CONVERT(VARCHAR,GETDATE(),112) + '_' + REPLACE(CONVERT(VARCHAR,GETDATE(),108),':','') + '.csv"'

    SET @RowCount = (SELECT COUNT(*) FROM @FilesOut);

    -- ==================================================
    -- Generate Multiple Files via Custom BCP statement:
    -- ==================================================
    -- Declare variables
    DECLARE  @RecordSetGroup  VARCHAR(100)
        ,@FileName            VARCHAR(100)
        ,@LoopCount           INT;

    SET @LoopCount = 1;

    -- Begin Process of Exporting Multiple Files
    WHILE @LoopCount <= @RowCount
    BEGIN

        -- Set FileName to Export Based On Record Set Group (Header,Detail,Trailer Records)
        SELECT
             @RecordSetGroup = RecordSetGroup
            ,@FileName = CustomFileName
        FROM @FilesOut
        WHERE RowID = @LoopCount;

        -- Set Query To Be Exported
        SET @QueryInfo = '"SELECT TOP 2000000 Data FROM '+ RTRIM(DB_NAME()) + '.dbo.U_' + @FormatCode + '_File (NOLOCK) '
                            + 'WHERE RECORDSET IN (''' + REPLACE(@RecordSetGroup,',',''',''') + ''') '
                            +'ORDER BY RIGHT(RECORDSET,2), InitialSort, SubSort"';

        -- Set Custom BCP Statement
        SELECT @sCmd = 'BCP ' + @QueryInfo + ' QUERYOUT "' + @ExportPath + @FileName +'"' + ' -S"' + RTRIM(@@SERVERNAME) + '" -T -c';

        -- Get Record Count
        DECLARE @RecordCnt INT, @Query NVARCHAR(1000);
        SET @Query = N'SELECT @RecordCount = COUNT(*) FROM '+ RTRIM(DB_NAME()) + '.dbo.U_' + @FormatCode + '_File (NOLOCK) WHERE RECORDSET IN (''' + REPLACE(@RecordSetGroup,',',''',''') + ''')';
        EXECUTE master.dbo.sp_executesql @Query, N'@RecordCount INT OUTPUT',  @RecordCount = @RecordCnt OUTPUT;

        IF @RecordCnt = 0 AND @NoEmpty = 'Y'
        BEGIN
            PRINT 'There are no records in the file, so no file will be created.'
        END
        ELSE
        BEGIN
            -- Output File
            EXEC master.dbo.xp_cmdshell @sCmd, NO_OUTPUT;
        END;

        -- Get Next FileName
        SET @LoopCount = @LoopCount + 1;

    END;

END;
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_@CustomFormatCode]
    @SystemID CHAR(12)
AS
/**********************************************************************************
Client Name: @CustomerName

Created By: @DeveloperName
Business Analyst: @IntegrationAnalystName
Create Date: @CreateDate
Service Request Number: @SRNumber

Purpose: To provide UltiPro core data to iCims for Employee, Job and Location data

Revision History
----------------
Update By            Date            Request Num                Desc        
XXXX                 XX/XX/XX        SR-20XX-000XXXXX           XXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.AscExp WHERE expFormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = '@CustomFormatCode' ORDER BY DateTimeCompleted DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'TEST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'SCHEDULED';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'FULLFILE';

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

    --==========================================
    -- Audit Section
    --==========================================

    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_@CustomFormatCode_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_AuditFields;
    CREATE TABLE dbo.U_@CustomFormatCode_AuditFields (aTableName VARCHAR(30),aFieldName VARCHAR(30));

    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpComp','EecEmpNo');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpPers','EepNameFirst');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpPers','EepNameMiddle');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpPers','EepNameLast');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpPers','EepAddressEmail');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpComp','EecSupervisorID');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpComp','EecPhoneBusinessNumber');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpComp','EecDateofLastHire');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpComp','EecDateofTermination');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpComp','EecJobCode');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpComp','EecEmplStatus');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('JobCode','JbcJobCode');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('JobCode','JbcDesc');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('JobCode','JbcStatus');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('JobCode','JbcEEOCategory');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('JobCode','JbcFLSAType');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('Location','LocCode');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('Location','LocDesc');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('Location','LocIsInactive');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('Location','LocAddressLine1');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('Location','LocAddressLine2');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('Location','LocAddressCity');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('Location','LocAddressState');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('Location','LocAddressZipCode');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('Location','LocAddressCountry');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('OrgLevel','OrgCode');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('OrgLevel','OrgDesc');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_@CustomFormatCode_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_Audit;
    SELECT audKey1 = audKey1Value
        ,audKey2 = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
    INTO dbo.U_@CustomFormatCode_Audit
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.U_@CustomFormatCode_AuditFields WITH (NOLOCK)
        ON 1 = 1
    JOIN dbo.vw_AuditData WITH (NOLOCK)
        ON audKey1Value = xEEID
        AND audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
        AND audAction <> 'DELETE'
        AND audTableName LIKE 'EMP%'
        AND ISNULL(audNewValue, '') <> ''
        AND ISNULL(audNewValue, '') <> ISNULL(audOldValue, '');

    ---------------------------------------
    -- Load JobCode, Location, OrgLevel
    ---------------------------------------
    INSERT INTO dbo.U_@CustomFormatCode_Audit (audKey1, audKey2, audKey3, audTableName, audFieldName, audAction, audDateTime, audOldValue, audNewValue)
    SELECT audKey1 = audKey1Value
        ,audKey2 = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
    FROM dbo.U_@CustomFormatCode_AuditFields WITH (NOLOCK)
    JOIN dbo.vw_AuditData WITH (NOLOCK)
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
        AND audAction <> 'DELETE'
        AND audTableName NOT LIKE 'EMP%'
        AND ISNULL(audNewValue, '') <> ''
        AND ISNULL(audNewValue, '') <> ISNULL(audOldValue, '');

    --==========================================
    -- Clean EE List
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_@CustomFormatCode_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCoID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_@CustomFormatCode_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    -- Changes Only
    IF (@ExportCode <> 'FULLFILE')
    BEGIN
        DELETE FROM dbo.U_@CustomFormatCode_EEList
        WHERE NOT EXISTS (SELECT 1 FROM dbo.U_@CustomFormatCode_Audit WHERE audKey1 = xEEID AND audTableName LIKE 'EMP%');
    END;
    ELSE --If FULLFILE, Delete Terms not entered in the audit
    BEGIN
        DELETE dbo.U_@CustomFormatCode_EEList
        FROM dbo.U_@CustomFormatCode_EEList
        INNER JOIN dbo.EmpComp WITH (NOLOCK)
            ON EecEEID = xEEID
            AND EecCoID = xCOID
        WHERE EecEmplStatus = 'T'
        AND NOT EXISTS (SELECT 1 FROM dbo.U_@CustomFormatCode_Audit WHERE audKey1 = xEEID AND audKey2 = xCOID AND audFieldName = 'EecEmplStatus' AND audNewValue = 'T');
    END;

    --==========================================
    -- Build Employee Data and the driver tables
    --==========================================

    ---------------------------------
    -- DETAIL RECORD - U_@CustomFormatCode_drvTbl_Emp
    ---------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_Emp','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_Emp;
    SELECT DISTINCT
         drvSystemID = Emp.EecUDField03 --This is the iCIMS System ID, which needs to be stored in UltiPro
        ,drvExternalid = Emp.EecEmpNo
        ,drvFolder = CASE WHEN Emp.EecEmplStatus = 'T' THEN 'Emp:Former Employee'
                          WHEN Emp.EecEmplStatus <> 'T' AND EXISTS (SELECT 1 FROM dbo.EmpComp WITH (NOLOCK) WHERE EecSupervisorID = Emp.EecEEID) THEN 'HM:Active'
                          ELSE 'Emp:Current Employee'
                     END
        ,drvNameFirst = RTRIM(EepNameFirst)
        ,drvNameMiddle = RTRIM(EepNameMiddle)
        ,drvNameLast = RTRIM(EepNameLast)
        ,drvAddressEmail = RTRIM(EepAddressEMail)
        ,drvLoginGroup = CASE WHEN Emp.EecEmplStatus = 'T' THEN '***'
                              WHEN Emp.EecEmplStatus <> 'T' AND EXISTS (SELECT 1 FROM dbo.EmpComp WITH (NOLOCK) WHERE EecSupervisorID = Emp.EecEEID) THEN 'Hiring Manager'
                         END
        ,drvIsmanagerrole = CASE WHEN Emp.EecEmplStatus <> 'T' AND EXISTS (SELECT 1 FROM dbo.EmpComp WITH (NOLOCK) WHERE EecSupervisorID = Emp.EecEEID) THEN '1' END
        ,drvsupervisorId = Sup.EecEmpno
        ,drvPhoneBusinessNumber = Emp.EecPhoneBusinessNumber
        ,drvDateofLastHire = Emp.EecDateOfLastHire
        ,drvEmpStartDate = Emp.EecDateOfLastHire
        ,drvDateofTermination = Emp.EecDateOfTermination
        ,drvEmpjobtitle = RTRIM(JbcJobCode) + ' - ' + ISNULL(RTRIM(JbcDesc), '')
        ,drvRCF2003 = RTRIM(EepNamePreferred)
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(Emp.EecEmpNo)
    INTO dbo.U_@CustomFormatCode_drvTbl_Emp
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    INNER JOIN dbo.EmpComp Emp WITH (NOLOCK)
        ON Emp.EecEEID = xEEID
        AND Emp.EecCoID = xCoID
    INNER JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN dbo.EmpComp Sup WITH (NOLOCK)
        ON Sup.EecEEID = Emp.EecSupervisorID
        AND Sup.EecCoID = dbo.dsi_fn_GetCurrentCOID(Sup.EecEEID)
    LEFT JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = Emp.EecJobCode;

    ---------------------------------
    -- DETAIL RECORD - U_@CustomFormatCode_drvTbl_Job
    ---------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_Job','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_Job;
    SELECT DISTINCT
         drvExternalid = JbcJobCode
        ,drvJobTitle = JbcDesc
        ,drvJobCode = JbcJobCode
        ,drvFolder = CASE WHEN JbcStatus = 'A' THEN 'Active Job Template'
                          ELSE 'Inactive Job Template'
                     END
        ,drvEeoCategoryLevel1 = CASE JbcEEOCategory
                                     WHEN '1.1' THEN 'Executive/Senior Level Officials and Managers'
                                     WHEN '1.2' THEN 'First/Mid-Level Officials and Managers'
                                     WHEN '2' THEN 'Professionals'
                                     WHEN '3' THEN 'Technicians'
                                     WHEN '4' THEN 'Sales Workers'
                                     WHEN '5' THEN 'Administrative Support Workers'
                                     WHEN '6' THEN 'Craft Workers'
                                     WHEN '7' THEN 'Operatives'
                                     WHEN '8' THEN 'Laborers and Helpers'
                                     WHEN '9' THEN 'Service Workers'
                                END
        ,drvJobType = CASE WHEN JbcFLSAType = 'E' THEN 'Exempt'
                           ELSE 'Non-Exempt'
                      END
        ,drvPositionType = SPACE(10)
        ,drvInitialSort = RTRIM(JbcJobCode)
    INTO dbo.U_@CustomFormatCode_drvTbl_Job
    FROM dbo.JobCode WITH (NOLOCK)
    LEFT JOIN dbo.U_@CustomFormatCode_Audit WITH (NOLOCK)
        ON AudKey1 = JbcJobCode
        AND AudTableName = 'JobCode'
    WHERE @ExportCode = 'FULLFILE'
        OR (@ExportCode <> 'FULLFILE' AND audKey1 IS NOT NULL);

    ---------------------------------
    -- DETAIL RECORD - U_@CustomFormatCode_drvTbl_Loc
    ---------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_Loc') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_Loc;
    SELECT DISTINCT
         drvExternalid = LocCode
        ,drvDesc = LocDesc
        ,drvFolder = CASE WHEN LocIsInactive = 'Y' THEN 'Inactive Location'
                          ELSE 'Active Location'
                     END
        ,drvAddressLine1 = LocAddressLine1
        ,drvAddressLine2 = LocAddressLine2
        ,drvAddressCity = LocAddressCity
        ,drvAddressState = LocAddressState
        ,drvAddressZipCode = LocAddressZipCode
        ,drvAddresscountry = LocAddressCountry
        ,drvInitialSort = RTRIM(LocCode)
    INTO dbo.U_@CustomFormatCode_drvTbl_Loc
    FROM dbo.Location WITH (NOLOCK)
    LEFT JOIN dbo.U_@CustomFormatCode_Audit WITH (NOLOCK)
        ON AudKey1 = LocCode
        AND AudTableName = 'Location'
    WHERE @ExportCode = 'FULLFILE'
        OR (@ExportCode <> 'FULLFILE' AND audKey1 IS NOT NULL);

    ---------------------------------
    -- DETAIL RECORD - U_@CustomFormatCode_drvTbl_Org
    ---------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_Org','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_Org;
    SELECT DISTINCT
         drvExternalid = OrgCode
        ,drvDesc = OrgDesc
        ,drvFolder = CASE WHEN OrgStatus = 'A' THEN 'Active Department'
                          ELSE 'Inactive Department'
                     END
        ,drvRcf2018 = CASE WHEN Orglvl = '1' THEN OrgReportCategory END
        ,drvRcf2019 = CASE WHEN Orglvl = '3' THEN OrgReportCategory END
        ,drvInitialSort = RTRIM(OrgCode)
    INTO dbo.U_@CustomFormatCode_drvTbl_Loc
    FROM dbo.OrgLevel WITH (NOLOCK)
    LEFT JOIN dbo.U_@CustomFormatCode_Audit WITH (NOLOCK)
        ON AudKey1 = OrgCode
        AND AudTableName = 'OrgLevel'
    WHERE OrgLvl IN ('1','3')
        AND @ExportCode = 'FULLFILE'
        OR (@ExportCode <> 'FULLFILE' AND audKey1 IS NOT NULL);

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable('@CustomFormatCode', 'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
        SET ExportFile = 'AFTERCOLLECT.txt'
        WHERE FormatCode = '@CustomFormatCode';
     END;

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vw@CustomFormatCode_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_@CustomFormatCode_File (NOLOCK)
    ORDER BY CASE WHEN LEFT(RecordSet,1) = 'D' THEN '10' ELSE RIGHT(RecordSet,2) END, InitialSort, SubSort;
GO

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE '@CustomFormatCode%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202005011'
       ,expStartPerControl     = '202005011'
       ,expLastEndPerControl   = '202005019'
       ,expEndPerControl       = '202005019'
WHERE expFormatCode = '@CustomFormatCode';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vw@CustomFormatCode_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_@CustomFormatCode_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;
GO