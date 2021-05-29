SET NOCOUNT ON;
IF OBJECT_ID('U_EOPTCBRAQ2_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EOPTCBRAQ2_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EOPTCBRAQ2_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EOPTCBRAQ2' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEOPTCBRAQ2_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEOPTCBRAQ2_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EOPTCBRAQ2') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EOPTCBRAQ2];
GO
IF OBJECT_ID('U_EOPTCBRAQ2_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EOPTCBRAQ2_PEarHist];
GO
IF OBJECT_ID('U_EOPTCBRAQ2_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EOPTCBRAQ2_PDedHist];
GO
IF OBJECT_ID('U_EOPTCBRAQ2_File') IS NOT NULL DROP TABLE [dbo].[U_EOPTCBRAQ2_File];
GO
IF OBJECT_ID('U_EOPTCBRAQ2_EEList') IS NOT NULL DROP TABLE [dbo].[U_EOPTCBRAQ2_EEList];
GO
IF OBJECT_ID('U_EOPTCBRAQ2_Edh_WorkingTable') IS NOT NULL DROP TABLE [dbo].[U_EOPTCBRAQ2_Edh_WorkingTable];
GO
IF OBJECT_ID('U_EOPTCBRAQ2_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EOPTCBRAQ2_drvTbl];
GO
IF OBJECT_ID('U_EOPTCBRAQ2_DedList') IS NOT NULL DROP TABLE [dbo].[U_EOPTCBRAQ2_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EOPTCBRAQ2') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EOPTCBRAQ2];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EOPTCBRAQ2';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EOPTCBRAQ2';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EOPTCBRAQ2';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EOPTCBRAQ2';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EOPTCBRAQ2';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EOPTCBRAQ2','Optum Cobra QB Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','8000','S','N','EOPTCBRAQ2Z0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EOPTCBRAQ2' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employer Code"','1','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','1',NULL,'Employer Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Branch Code"','2','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','2',NULL,'Branch Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Notification Date"','3','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','3',NULL,'Notification Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Social Security Number"','4','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','4',NULL,'Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last Name"','5','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','5',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Name"','6','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','6',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Middle Name"','7','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','7',NULL,'Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address"','8','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','8',NULL,'Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address 2"','9','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','9',NULL,'Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Town or City"','10','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','10',NULL,'Town or City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"State"','11','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','11',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Postal Code"','12','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','12',NULL,'Postal Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Birth"','13','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','13',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Sex"','14','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','14',NULL,'Sex',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Qualifying Event Date"','15','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','15',NULL,'Qualifying Event Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Qualifying Event"','16','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','16',NULL,'Qualifying Event',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"COBRA Begins"','17','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','17',NULL,'COBRA Begins',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Full Name"','18','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','18',NULL,'Employee Full Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee SSN"','19','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','19',NULL,'Employee SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Special"','20','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','20',NULL,'Employee Special',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Medical Plan Start Date"','21','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','21',NULL,'Medical Plan Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Medical Plan"','22','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','22',NULL,'Medical Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Medical Coverage"','23','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','23',NULL,'Medical Coverage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dental Plan"','24','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','24',NULL,'Dental Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dental Coverage"','25','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','25',NULL,'Dental Coverage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Vision Plan"','26','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','26',NULL,'Vision Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Vision Coverage"','27','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','27',NULL,'Vision Coverage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Other Plan"','28','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','28',NULL,'Other Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Other Coverage"','29','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','29',NULL,'Other Coverage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Life Plan 1"','30','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','30',NULL,'Life Plan 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Life Plan 1 Coverage"','31','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','31',NULL,'Life Plan 1 Coverage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Life Plan 1 Volume"','32','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','32',NULL,'Life Plan 1 Volume',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Life Plan 2"','33','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','33',NULL,'Life Plan 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Life 2 Coverage"','34','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','34',NULL,'Life 2 Coverage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Life 2 Volume"','35','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','35',NULL,'Life 2 Volume',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Life Plan 3"','36','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','36',NULL,'Life Plan 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Life 3 Coverage"','37','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','37',NULL,'Life 3 Coverage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Life 3 Volume"','38','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','38',NULL,'Life 3 Volume',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Life Plan 4"','39','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','39',NULL,'Life Plan 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Life 4 Coverage"','40','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','40',NULL,'Life 4 Coverage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Life 4 Volume"','41','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','41',NULL,'Life 4 Volume',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Flex Plan"','42','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','42',NULL,'Flex Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Flex Plan Coverage Level"','43','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','43',NULL,'Flex Plan Coverage Level',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Flex Healthcare Amount"','44','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','44',NULL,'Flex Healthcare Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Flex Plan End Date"','45','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','45',NULL,'Flex Plan End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 1.Dep Last Name"','46','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','46',NULL,'qDep 1.Dep Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 1.Dep First Name"','47','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','47',NULL,'qDep 1.Dep First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 1.Dep SSN"','48','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','48',NULL,'qDep 1.Dep SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 1. Gender"','49','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','49',NULL,'qDep 1. Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 1.Relationship"','50','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','50',NULL,'qDep 1.Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 1.Dep Date of Birth"','51','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','51',NULL,'qDep 1.Dep Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 1.Dep Medical"','52','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','52',NULL,'qDep 1.Dep Medical',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 1.Dep Dental"','53','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','53',NULL,'qDep 1.Dep Dental',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 1.Dep Vision"','54','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','54',NULL,'qDep 1.Dep Vision',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 1.Dep Other Plan"','55','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','55',NULL,'qDep 1.Dep Other Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 2.Dep Last Name"','58','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','58',NULL,'qDep 2.Dep Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 2.Dep First Name"','59','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','59',NULL,'qDep 2.Dep First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 2.Dep SSN"','60','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','60',NULL,'qDep 2.Dep SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 2. Gender"','61','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','61',NULL,'qDep 2. Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 2.Relationship"','62','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','62',NULL,'qDep 2.Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 2.Dep Date of Birth"','63','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','63',NULL,'qDep 2.Dep Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 2.Dep Medical"','64','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','64',NULL,'qDep 2.Dep Medical',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 2.Dep Dental"','65','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','65',NULL,'qDep 2.Dep Dental',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 2.Dep Vision"','66','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','66',NULL,'qDep 2.Dep Vision',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 2.Dep Other Plan"','67','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','67',NULL,'qDep 2.Dep Other Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 3.Dep Last Name"','70','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','70',NULL,'qDep 3.Dep Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 3.Dep First Name"','71','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','71',NULL,'qDep 3.Dep First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 3.Dep SSN"','72','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','72',NULL,'qDep 3.Dep SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 3. Gender"','73','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','73',NULL,'qDep 3. Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 3.Relationship"','74','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','74',NULL,'qDep 3.Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 3.Dep Date of Birth"','75','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','75',NULL,'qDep 3.Dep Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 3.Dep Medical"','76','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','76',NULL,'qDep 3.Dep Medical',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 3.Dep Dental"','77','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','77',NULL,'qDep 3.Dep Dental',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 3.Dep Vision"','78','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','78',NULL,'qDep 3.Dep Vision',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 3.Dep Other Plan"','79','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','79',NULL,'qDep 3.Dep Other Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 4.Dep Last Name"','82','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','82',NULL,'qDep 4.Dep Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 4.Dep First Name"','83','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','83',NULL,'qDep 4.Dep First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 4.Dep SSN"','84','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','84',NULL,'qDep 4.Dep SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 4. Gender"','85','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','85',NULL,'qDep 4. Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 4.Relationship"','86','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','86',NULL,'qDep 4.Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 4.Dep Date of Birth"','87','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','87',NULL,'qDep 4.Dep Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 4.Dep Medical"','88','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','88',NULL,'qDep 4.Dep Medical',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 4.Dep Dental"','89','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','89',NULL,'qDep 4.Dep Dental',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 4.Dep Vision"','90','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','90',NULL,'qDep 4.Dep Vision',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 4.Dep Other Plan"','91','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','91',NULL,'qDep 4.Dep Other Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 5.Dep Last Name"','94','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','94',NULL,'qDep 5.Dep Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 5.Dep First Name"','95','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','95',NULL,'qDep 5.Dep First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 5.Dep SSN"','96','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','96',NULL,'qDep 5.Dep SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 5. Gender"','97','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','97',NULL,'qDep 5. Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 5.Relationship"','98','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','98',NULL,'qDep 5.Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 5.Dep Date of Birth"','99','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','99',NULL,'qDep 5.Dep Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 5.Dep Medical"','100','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','100',NULL,'qDep 5.Dep Medical',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 5.Dep Dental"','101','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','101',NULL,'qDep 5.Dep Dental',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 5.Dep Vision"','102','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','102',NULL,'qDep 5.Dep Vision',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 5.Dep Other Plan"','103','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','103',NULL,'qDep 5.Dep Other Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 6.Dep Last Name"','106','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','106',NULL,'qDep 6.Dep Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 6.Dep First Name"','107','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','107',NULL,'qDep 6.Dep First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 6.Dep SSN"','108','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','108',NULL,'qDep 6.Dep SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 6. Gender"','109','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','109',NULL,'qDep 6. Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 6.Relationship"','110','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','110',NULL,'qDep 6.Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 6.Dep Date of Birth"','111','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','111',NULL,'qDep 6.Dep Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 6.Dep Medical"','112','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','112',NULL,'qDep 6.Dep Medical',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 6.Dep Dental"','113','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','113',NULL,'qDep 6.Dep Dental',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 6.Dep Vision"','114','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','114',NULL,'qDep 6.Dep Vision',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 6.Dep Other Plan"','115','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','115',NULL,'qDep 6.Dep Other Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 7.Dep Last Name"','118','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','118',NULL,'qDep 7.Dep Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 7.Dep First Name"','119','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','119',NULL,'qDep 7.Dep First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 7.Dep SSN"','120','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','120',NULL,'qDep 7.Dep SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 7. Gender"','121','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','121',NULL,'qDep 7. Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 7.Relationship"','122','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','122',NULL,'qDep 7.Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 7.Dep Date of Birth"','123','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','123',NULL,'qDep 7.Dep Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 7.Dep Medical"','124','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','124',NULL,'qDep 7.Dep Medical',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 7.Dep Dental"','125','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','125',NULL,'qDep 7.Dep Dental',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 7.Dep Vision"','126','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','126',NULL,'qDep 7.Dep Vision',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 7.Dep Other Plan"','127','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','127',NULL,'qDep 7.Dep Other Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 8.Dep Last Name"','130','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','130',NULL,'qDep 8.Dep Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 8.Dep First Name"','131','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','131',NULL,'qDep 8.Dep First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 8.Dep SSN"','132','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','132',NULL,'qDep 8.Dep SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 8. Gender"','133','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','133',NULL,'qDep 8. Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 8.Relationship"','134','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','134',NULL,'qDep 8.Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 8.Dep Date of Birth"','135','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','135',NULL,'qDep 8.Dep Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 8.Dep Medical"','136','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','136',NULL,'qDep 8.Dep Medical',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 8.Dep Dental"','137','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','137',NULL,'qDep 8.Dep Dental',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 8.Dep Vision"','138','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','138',NULL,'qDep 8.Dep Vision',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 8.Dep Other Plan"','139','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','139',NULL,'qDep 8.Dep Other Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 9.Dep Last Name"','142','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','142',NULL,'qDep 9.Dep Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 9.Dep First Name"','143','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','143',NULL,'qDep 9.Dep First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 9.Dep SSN"','144','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','144',NULL,'qDep 9.Dep SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 9. Gender"','145','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','145',NULL,'qDep 9. Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 9.Relationship"','146','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','146',NULL,'qDep 9.Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 9.Dep Date of Birth"','147','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','147',NULL,'qDep 9.Dep Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 9.Dep Medical"','148','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','148',NULL,'qDep 9.Dep Medical',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 9.Dep Dental"','149','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','149',NULL,'qDep 9.Dep Dental',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 9.Dep Vision"','150','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','150',NULL,'qDep 9.Dep Vision',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 9.Dep Other Plan"','151','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','151',NULL,'qDep 9.Dep Other Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 10.Dep Last Name"','154','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','154',NULL,'qDep 10.Dep Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 10.Dep First Name"','155','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','155',NULL,'qDep 10.Dep First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 10.Dep SSN"','156','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','156',NULL,'qDep 10.Dep SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 10. Gender"','157','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','157',NULL,'qDep 10. Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 10.Relationship"','158','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','158',NULL,'qDep 10.Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 10.Dep Date of Birth"','159','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','159',NULL,'qDep 10.Dep Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 10.Dep Medical"','160','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','160',NULL,'qDep 10.Dep Medical',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 10.Dep Dental"','161','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','161',NULL,'qDep 10.Dep Dental',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 10.Dep Vision"','162','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','162',NULL,'qDep 10.Dep Vision',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 10.Dep Other Plan"','163','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','162',NULL,'qDep 10.Dep Other Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 11.Dep Last Name"','166','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','166',NULL,'qDep 11.Dep Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 11.Dep First Name"','167','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','167',NULL,'qDep 11.Dep First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 11.Dep SSN"','168','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','168',NULL,'qDep 11.Dep SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 11. Gender"','169','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','169',NULL,'qDep 11. Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 11.Relationship"','170','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','170',NULL,'qDep 11.Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 11.Dep Date of Birth"','171','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','171',NULL,'qDep 11.Dep Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 11.Dep Medical"','172','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','172',NULL,'qDep 11.Dep Medical',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 11.Dep Dental"','173','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','173',NULL,'qDep 11.Dep Dental',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 11.Dep Vision"','174','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','174',NULL,'qDep 11.Dep Vision',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"qDep 11.Dep Other Plan"','175','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','175',NULL,'qDep 11.Dep Other Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse DOB"','176','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','176',NULL,'Spouse DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Special Instructions"','177','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','H','01','177',NULL,'Special Instructions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"391578274"','1','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','1',NULL,'Employer Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','2','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','2',NULL,'Branch Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNotificationDate"','3','(''UD101''=''T,'')','EOPTCBRAQ2Z0','50','D','10','3',NULL,'Notification Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','4','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','4',NULL,'Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','5','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','5',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','6','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','6',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','7','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','7',NULL,'Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','8','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','8',NULL,'Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','9','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','9',NULL,'Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','10','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','10',NULL,'Town or City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','11','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','11',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressPostalCode"','12','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','12',NULL,'Postal Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','13','(''UD101''=''T,'')','EOPTCBRAQ2Z0','50','D','10','13',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','14','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','14',NULL,'Sex',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQualifiedEventDate"','15','(''UD101''=''T,'')','EOPTCBRAQ2Z0','50','D','10','15',NULL,'Qualifying Event Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQualifyingEvent"','16','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','16',NULL,'Qualifying Event',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCobraBegins"','17','(''UD101''=''T,'')','EOPTCBRAQ2Z0','50','D','10','17',NULL,'COBRA Begins',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeFullName"','18','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','18',NULL,'Employee Full Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeSSN"','19','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','19',NULL,'Employee SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeSpecial"','20','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','20',NULL,'Employee Special',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMedicalPlanStartDate"','21','(''UD101''=''T,'')','EOPTCBRAQ2Z0','50','D','10','21',NULL,'Medical Plan Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMedicalPlan"','22','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','22',NULL,'Medical Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMedicalCoverage"','23','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','23',NULL,'Medical Coverage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalPlan"','24','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','24',NULL,'Dental Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalCoverage"','25','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','25',NULL,'Dental Coverage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVisionPlan"','26','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','26',NULL,'Vision Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVisionCoverage"','27','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','27',NULL,'Vision Coverage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','28','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','28',NULL,'Other Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','29','(''DA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','29',NULL,'Other Coverage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLifePlan1"','30','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','30',NULL,'Life Plan 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLifePlan1Coverage"','31','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','31',NULL,'Life Plan 1 Coverage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLifePlan1Volume"','32','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','32',NULL,'Life Plan 1 Volume',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLifePlan2"','33','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','33',NULL,'Life Plan 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLifePlan2Coverage"','34','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','34',NULL,'Life 2 Coverage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLife2Volume"','35','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','35',NULL,'Life 2 Volume',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLifePlan3"','36','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','36',NULL,'Life Plan 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLifePlan3Coverage"','37','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','37',NULL,'Life 3 Coverage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLife3Volume"','38','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','38',NULL,'Life 3 Volume',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLifePLan4"','39','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','39',NULL,'Life Plan 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLife4Coverage"','40','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','40',NULL,'Life 4 Coverage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLife4Volume"','41','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','41',NULL,'Life 4 Volume',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFlexPlan"','42','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','42',NULL,'Flex Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFlexCoverageLevel"','43','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','43',NULL,'Flex Plan Coverage Level',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFlexHCAmount"','44','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','44',NULL,'Flex Healthcare Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFlexPlanEndDate"','45','(''UD101''=''T,'')','EOPTCBRAQ2Z0','50','D','10','45',NULL,'Flex Plan End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep1LastName"','46','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','46',NULL,'qDep 1.Dep Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep1FirstName"','48','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','48',NULL,'qDep 1.Dep First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep1SSN"','49','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','49',NULL,'qDep 1.Dep SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep1Gender"','50','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','50',NULL,'qDep 1. Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep1Relationship"','51','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','51',NULL,'qDep 1.Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep1DateOfBirth"','52','(''UD101''=''T,'')','EOPTCBRAQ2Z0','50','D','10','52',NULL,'qDep 1.Dep Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep1Medical"','53','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','53',NULL,'qDep 1.Dep Medical',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep1Dental"','54','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','54',NULL,'qDep 1.Dep Dental',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep1Vision"','55','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','55',NULL,'qDep 1.Dep Vision',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep1OtherPlan"','56','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','56',NULL,'qDep 1.Dep Other Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep2LastName"','59','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','59',NULL,'qDep 2.Dep Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep2FirstName"','60','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','60',NULL,'qDep 2.Dep First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep2SSN"','61','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','61',NULL,'qDep 2.Dep SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep2Gender"','62','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','62',NULL,'qDep 2. Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep2Relationship"','63','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','63',NULL,'qDep 2.Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep2DateOfBirth"','64','(''UD101''=''T,'')','EOPTCBRAQ2Z0','50','D','10','64',NULL,'qDep 2.Dep Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep2Medical"','65','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','65',NULL,'qDep 2.Dep Medical',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep2Dental"','66','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','66',NULL,'qDep 2.Dep Dental',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep2Vision"','67','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','67',NULL,'qDep 2.Dep Vision',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep2OtherPlan"','68','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','68',NULL,'qDep 2.Dep Other Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep3LastName"','71','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','71',NULL,'qDep 3.Dep Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep3FirstName"','72','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','72',NULL,'qDep 3.Dep First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep3SSN"','73','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','73',NULL,'qDep 3.Dep SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep3Gender"','74','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','74',NULL,'qDep 3. Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep3Relationship"','75','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','75',NULL,'qDep 3.Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep3DateOfBirth"','76','(''UD101''=''T,'')','EOPTCBRAQ2Z0','50','D','10','76',NULL,'qDep 3.Dep Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep3Medical"','77','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','77',NULL,'qDep 3.Dep Medical',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep3Dental"','78','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','78',NULL,'qDep 3.Dep Dental',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep3Vision"','79','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','79',NULL,'qDep 3.Dep Vision',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep3OtherPlan"','80','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','80',NULL,'qDep 3.Dep Other Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep4LastName"','83','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','83',NULL,'qDep 4.Dep Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep4FirstName"','84','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','84',NULL,'qDep 4.Dep First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep4SSN"','85','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','85',NULL,'qDep 4.Dep SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep4Gender"','86','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','86',NULL,'qDep 4. Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep4Relationship"','87','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','87',NULL,'qDep 4.Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep4DateOfBirth"','88','(''UD101''=''T,'')','EOPTCBRAQ2Z0','50','D','10','88',NULL,'qDep 4.Dep Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep4Medical"','89','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','89',NULL,'qDep 4.Dep Medical',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep4Dental"','90','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','90',NULL,'qDep 4.Dep Dental',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep4Vision"','91','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','91',NULL,'qDep 4.Dep Vision',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep4OtherPlan"','92','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','92',NULL,'qDep 4.Dep Other Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep5LastName"','95','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','95',NULL,'qDep 5.Dep Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep5FirstName"','96','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','96',NULL,'qDep 5.Dep First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep5SSN"','97','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','97',NULL,'qDep 5.Dep SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep5Gender"','98','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','98',NULL,'qDep 5. Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep5Relationship"','99','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','99',NULL,'qDep 5.Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep5DateOfBirth"','100','(''UD101''=''T,'')','EOPTCBRAQ2Z0','50','D','10','100',NULL,'qDep 5.Dep Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep5Medical"','101','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','101',NULL,'qDep 5.Dep Medical',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep5Dental"','102','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','102',NULL,'qDep 5.Dep Dental',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep5Vision"','103','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','103',NULL,'qDep 5.Dep Vision',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep5OtherPlan"','104','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','104',NULL,'qDep 5.Dep Other Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep6LastName"','107','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','107',NULL,'qDep 6.Dep Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep6FirstName"','108','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','108',NULL,'qDep 6.Dep First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep6SSN"','109','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','109',NULL,'qDep 6.Dep SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep6Gender"','110','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','110',NULL,'qDep 6. Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep6Relationship"','111','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','111',NULL,'qDep 6.Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep6DateOfBirth"','112','(''UD101''=''T,'')','EOPTCBRAQ2Z0','50','D','10','112',NULL,'qDep 6.Dep Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep6Medical"','113','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','113',NULL,'qDep 6.Dep Medical',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep6Dental"','114','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','114',NULL,'qDep 6.Dep Dental',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep6Vision"','115','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','115',NULL,'qDep 6.Dep Vision',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep6OtherPlan"','116','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','116',NULL,'qDep 6.Dep Other Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep7LastName"','119','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','119',NULL,'qDep 7.Dep Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep7FirstName"','120','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','120',NULL,'qDep 7.Dep First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep7SSN"','121','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','121',NULL,'qDep 7.Dep SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep7Gender"','122','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','122',NULL,'qDep 7. Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep7Relationship"','123','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','123',NULL,'qDep 7.Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep7DateOfBirth"','124','(''UD101''=''T,'')','EOPTCBRAQ2Z0','50','D','10','124',NULL,'qDep 7.Dep Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep7Medical"','125','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','125',NULL,'qDep 7.Dep Medical',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep7Dental"','126','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','126',NULL,'qDep 7.Dep Dental',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep7Vision"','127','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','127',NULL,'qDep 7.Dep Vision',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep7OtherPlan"','128','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','128',NULL,'qDep 7.Dep Other Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep8LastName"','131','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','131',NULL,'qDep 8.Dep Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep8FirstName"','132','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','132',NULL,'qDep 8.Dep First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep8SSN"','133','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','133',NULL,'qDep 8.Dep SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep8Gender"','134','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','134',NULL,'qDep 8. Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep8Relationship"','135','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','135',NULL,'qDep 8.Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep8DateOfBirth"','136','(''UD101''=''T,'')','EOPTCBRAQ2Z0','50','D','10','136',NULL,'qDep 8.Dep Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep8Medical"','137','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','137',NULL,'qDep 8.Dep Medical',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep8Dental"','138','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','138',NULL,'qDep 8.Dep Dental',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep8Vision"','139','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','139',NULL,'qDep 8.Dep Vision',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep8OtherPlan"','140','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','140',NULL,'qDep 8.Dep Other Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep9LastName"','143','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','143',NULL,'qDep 9.Dep Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep9FirstName"','144','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','144',NULL,'qDep 9.Dep First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep9SSN"','145','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','145',NULL,'qDep 9.Dep SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep9Gender"','146','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','146',NULL,'qDep 9. Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep9Relationship"','147','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','147',NULL,'qDep 9.Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep9DateOfBirth"','148','(''UD101''=''T,'')','EOPTCBRAQ2Z0','50','D','10','148',NULL,'qDep 9.Dep Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep9Medical"','149','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','149',NULL,'qDep 9.Dep Medical',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep9Dental"','150','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','150',NULL,'qDep 9.Dep Dental',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep9Vision"','151','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','151',NULL,'qDep 9.Dep Vision',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep9OtherPlan"','152','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','152',NULL,'qDep 9.Dep Other Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep10LastName"','155','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','155',NULL,'qDep 10.Dep Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep10FirstName"','156','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','156',NULL,'qDep 10.Dep First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep10SSN"','157','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','157',NULL,'qDep 10.Dep SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep10Gender"','158','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','158',NULL,'qDep 10. Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep10Relationship"','159','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','159',NULL,'qDep 10.Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep10DateOfBirth"','160','(''UD101''=''T,'')','EOPTCBRAQ2Z0','50','D','10','160',NULL,'qDep 10.Dep Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep10Medical"','161','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','161',NULL,'qDep 10.Dep Medical',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep10Dental"','162','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','162',NULL,'qDep 10.Dep Dental',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep10Vision"','163','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','163',NULL,'qDep 10.Dep Vision',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep10OtherPlan"','164','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','164',NULL,'qDep 10.Dep Other Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep11LastName"','167','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','167',NULL,'qDep 11.Dep Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep11FirstName"','168','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','168',NULL,'qDep 11.Dep First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep11SSN"','169','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','169',NULL,'qDep 11.Dep SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep11Gender"','170','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','170',NULL,'qDep 11. Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep11Relationship"','171','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','171',NULL,'qDep 11.Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep11DateOfBirth"','172','(''UD101''=''T,'')','EOPTCBRAQ2Z0','50','D','10','172',NULL,'qDep 11.Dep Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep11Medical"','173','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','173',NULL,'qDep 11.Dep Medical',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep11Dental"','174','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','174',NULL,'qDep 11.Dep Dental',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep11Vision"','175','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','175',NULL,'qDep 11.Dep Vision',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep11OtherPlan"','176','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','176',NULL,'qDep 11.Dep Other Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseDOB"','177','(''UD101''=''T,'')','EOPTCBRAQ2Z0','50','D','10','177',NULL,'Spouse DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpecialInstructions"','178','(''UA''=''T,'')','EOPTCBRAQ2Z0','50','D','10','178',NULL,'Special Instructions',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EOPTCBRAQ2_20210528.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','202105119','EMPEXPORT','OEACTIVE','Apr 16 2020 11:06AM','EOPTCBRAQ2',NULL,NULL,NULL,'202105119','Mar 23 2020 12:40PM','Mar 23 2020 12:40PM','202105041','40','','','202105041',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Passive Open Enrollment Export','202105119','EMPEXPORT','OEPASSIVE','Apr 16 2020 11:07AM','EOPTCBRAQ2',NULL,NULL,NULL,'202105119','Mar 23 2020 12:40PM','Mar 23 2020 12:40PM','202105041','40','','','202105041',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Optum Cobra QB Export','202105119','EMPEXPORT','ONDEMAND','Apr 16 2020 11:08AM','EOPTCBRAQ2',NULL,NULL,NULL,'202105119','Mar 23 2020 12:40PM','Mar 23 2020 12:40PM','202105041','42','','','202105041',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','KD708,KD723,KD74A',NULL,NULL,NULL,'Optum COBRA QB - Tues 2pm','202105119','EMPEXPORT','SCHEDULED','Apr 16 2020 11:09AM','EOPTCBRAQ2',NULL,NULL,NULL,'202105119','Mar 23 2020 12:40PM','Mar 23 2020 12:40PM','202105041','42','','','202105041',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202105119','EMPEXPORT','TEST','May  6 2021  5:20PM','EOPTCBRAQ2',NULL,NULL,NULL,'202105119','May  7 2021 12:00AM','Dec 30 1899 12:00AM','202105041','8','','','202105041',dbo.fn_GetTimedKey(),NULL,'us3lKiCIR1003',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EOPTCBRAQ2','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EOPTCBRAQ2','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EOPTCBRAQ2','InitialSort','C','drvSort1');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EOPTCBRAQ2','SubSort','C','drvSort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EOPTCBRAQ2','SubSort2','C','drvSort3');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EOPTCBRAQ2','SubSort3','C','drvSort4');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EOPTCBRAQ2','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EOPTCBRAQ2','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EOPTCBRAQ2' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EOPTCBRAQ2' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EOPTCBRAQ2_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EOPTCBRAQ2_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EOPTCBRAQ2','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EOPTCBRAQ2','D10','dbo.U_EOPTCBRAQ2_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_EOPTCBRAQ2') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EOPTCBRAQ2] (
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
IF OBJECT_ID('U_EOPTCBRAQ2_DedList') IS NULL
CREATE TABLE [dbo].[U_EOPTCBRAQ2_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EOPTCBRAQ2_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EOPTCBRAQ2_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort1] varchar(22) NOT NULL,
    [drvSort2] varchar(51) NOT NULL,
    [drvSort3] varchar(16) NOT NULL,
    [drvSort4] varchar(23) NOT NULL,
    [drvNotificationDate] datetime NOT NULL,
    [drvSSN] varchar(13) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvAddressLine1] varchar(8000) NULL,
    [drvAddressLine2] varchar(8000) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressPostalCode] varchar(50) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvGender] char(1) NULL,
    [drvQualifiedEventDate] datetime NULL,
    [drvQualifyingEvent] varchar(4) NULL,
    [drvCobraBegins] datetime NULL,
    [drvEmployeeFullName] varchar(204) NULL,
    [drvEmployeeSSN] char(11) NULL,
    [drvEmployeeSpecial] varchar(3) NULL,
    [drvMedicalPlanStartDate] datetime NULL,
    [drvMedicalPlan] varchar(7) NULL,
    [drvMedicalCoverage] varchar(2) NULL,
    [drvDentalPlan] varchar(6) NULL,
    [drvDentalCoverage] varchar(2) NULL,
    [drvVisionPlan] varchar(8) NULL,
    [drvVisionCoverage] varchar(2) NULL,
    [drvLifePlan1] varchar(6) NULL,
    [drvLifePlan1Coverage] varchar(1) NULL,
    [drvLifePlan1Volume] nvarchar(4000) NULL,
    [drvLifePlan2] varchar(6) NULL,
    [drvLifePlan2Coverage] varchar(1) NULL,
    [drvLife2Volume] nvarchar(4000) NULL,
    [drvLifePlan3] varchar(6) NULL,
    [drvLifePlan3Coverage] varchar(1) NULL,
    [drvLife3Volume] nvarchar(4000) NULL,
    [drvLifePLan4] varchar(6) NULL,
    [drvLife4Coverage] varchar(1) NULL,
    [drvLife4Volume] nvarchar(4000) NULL,
    [drvFlexPlan] varchar(3) NULL,
    [drvFlexCoverageLevel] varchar(2) NULL,
    [drvFlexHCAmount] nvarchar(4000) NULL,
    [drvFlexPlanEndDate] datetime NULL,
    [drvDep1LastName] varchar(100) NULL,
    [drvDep1FirstName] varchar(100) NULL,
    [drvDep1SSN] varchar(13) NULL,
    [drvDep1Gender] char(1) NULL,
    [drvDep1Relationship] varchar(6) NULL,
    [drvDep1DateOfBirth] datetime NULL,
    [drvDep1Medical] varchar(7) NULL,
    [drvDep1Dental] varchar(6) NULL,
    [drvDep1Vision] varchar(8) NULL,
    [drvDep1OtherPlan] varchar(6) NULL,
    [drvDep2LastName] varchar(100) NULL,
    [drvDep2FirstName] varchar(100) NULL,
    [drvDep2SSN] varchar(13) NULL,
    [drvDep2Gender] char(1) NULL,
    [drvDep2Relationship] varchar(6) NULL,
    [drvDep2DateOfBirth] datetime NULL,
    [drvDep2Medical] varchar(7) NULL,
    [drvDep2Dental] varchar(6) NULL,
    [drvDep2Vision] varchar(8) NULL,
    [drvDep2OtherPlan] varchar(6) NULL,
    [drvDep3LastName] varchar(100) NULL,
    [drvDep3FirstName] varchar(100) NULL,
    [drvDep3SSN] varchar(13) NULL,
    [drvDep3Gender] char(1) NULL,
    [drvDep3Relationship] varchar(6) NULL,
    [drvDep3DateOfBirth] datetime NULL,
    [drvDep3Medical] varchar(7) NULL,
    [drvDep3Dental] varchar(6) NULL,
    [drvDep3Vision] varchar(8) NULL,
    [drvDep3OtherPlan] varchar(6) NULL,
    [drvDep4LastName] varchar(100) NULL,
    [drvDep4FirstName] varchar(100) NULL,
    [drvDep4SSN] varchar(13) NULL,
    [drvDep4Gender] char(1) NULL,
    [drvDep4Relationship] varchar(6) NULL,
    [drvDep4DateOfBirth] datetime NULL,
    [drvDep4Medical] varchar(7) NULL,
    [drvDep4Dental] varchar(6) NULL,
    [drvDep4Vision] varchar(8) NULL,
    [drvDep4OtherPlan] varchar(6) NULL,
    [drvDep5LastName] varchar(100) NULL,
    [drvDep5FirstName] varchar(100) NULL,
    [drvDep5SSN] varchar(13) NULL,
    [drvDep5Gender] char(1) NULL,
    [drvDep5Relationship] varchar(6) NULL,
    [drvDep5DateOfBirth] datetime NULL,
    [drvDep5Medical] varchar(7) NULL,
    [drvDep5Dental] varchar(6) NULL,
    [drvDep5Vision] varchar(8) NULL,
    [drvDep5OtherPlan] varchar(6) NULL,
    [drvDep6LastName] varchar(100) NULL,
    [drvDep6FirstName] varchar(100) NULL,
    [drvDep6SSN] varchar(13) NULL,
    [drvDep6Gender] char(1) NULL,
    [drvDep6Relationship] varchar(6) NULL,
    [drvDep6DateOfBirth] datetime NULL,
    [drvDep6Medical] varchar(7) NULL,
    [drvDep6Dental] varchar(6) NULL,
    [drvDep6Vision] varchar(8) NULL,
    [drvDep6OtherPlan] varchar(6) NULL,
    [drvDep7LastName] varchar(100) NULL,
    [drvDep7FirstName] varchar(100) NULL,
    [drvDep7SSN] varchar(13) NULL,
    [drvDep7Gender] char(1) NULL,
    [drvDep7Relationship] varchar(6) NULL,
    [drvDep7DateOfBirth] datetime NULL,
    [drvDep7Medical] varchar(7) NULL,
    [drvDep7Dental] varchar(6) NULL,
    [drvDep7Vision] varchar(8) NULL,
    [drvDep7OtherPlan] varchar(6) NULL,
    [drvDep8LastName] varchar(100) NULL,
    [drvDep8FirstName] varchar(100) NULL,
    [drvDep8SSN] varchar(13) NULL,
    [drvDep8Gender] char(1) NULL,
    [drvDep8Relationship] varchar(6) NULL,
    [drvDep8DateOfBirth] datetime NULL,
    [drvDep8Medical] varchar(7) NULL,
    [drvDep8Dental] varchar(6) NULL,
    [drvDep8Vision] varchar(8) NULL,
    [drvDep8OtherPlan] varchar(6) NULL,
    [drvDep9LastName] varchar(100) NULL,
    [drvDep9FirstName] varchar(100) NULL,
    [drvDep9SSN] varchar(13) NULL,
    [drvDep9Gender] char(1) NULL,
    [drvDep9Relationship] varchar(6) NULL,
    [drvDep9DateOfBirth] datetime NULL,
    [drvDep9Medical] varchar(7) NULL,
    [drvDep9Dental] varchar(6) NULL,
    [drvDep9Vision] varchar(8) NULL,
    [drvDep9OtherPlan] varchar(6) NULL,
    [drvDep10LastName] varchar(100) NULL,
    [drvDep10FirstName] varchar(100) NULL,
    [drvDep10SSN] varchar(13) NULL,
    [drvDep10Gender] char(1) NULL,
    [drvDep10Relationship] varchar(6) NULL,
    [drvDep10DateOfBirth] datetime NULL,
    [drvDep10Medical] varchar(7) NULL,
    [drvDep10Dental] varchar(6) NULL,
    [drvDep10Vision] varchar(8) NULL,
    [drvDep10OtherPlan] varchar(6) NULL,
    [drvDep11LastName] varchar(100) NULL,
    [drvDep11FirstName] varchar(100) NULL,
    [drvDep11SSN] varchar(13) NULL,
    [drvDep11Gender] char(1) NULL,
    [drvDep11Relationship] varchar(6) NULL,
    [drvDep11DateOfBirth] datetime NULL,
    [drvDep11Medical] varchar(7) NULL,
    [drvDep11Dental] varchar(6) NULL,
    [drvDep11Vision] varchar(8) NULL,
    [drvDep11OtherPlan] varchar(6) NULL,
    [drvSpouseDOB] datetime NULL,
    [drvSpecialInstructions] nvarchar(4000) NULL
);
IF OBJECT_ID('U_EOPTCBRAQ2_Edh_WorkingTable') IS NULL
CREATE TABLE [dbo].[U_EOPTCBRAQ2_Edh_WorkingTable] (
    [EDHEEID] char(12) NOT NULL,
    [EdhCOID] char(5) NOT NULL,
    [EdhDedCode] char(5) NOT NULL,
    [edhChangeReason] char(6) NULL,
    [EdhEffDate] datetime NULL,
    [BchIsCOBRAQualifiedEvent] char(1) NULL
);
IF OBJECT_ID('U_EOPTCBRAQ2_EEList') IS NULL
CREATE TABLE [dbo].[U_EOPTCBRAQ2_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EOPTCBRAQ2_File') IS NULL
CREATE TABLE [dbo].[U_EOPTCBRAQ2_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(max) NULL
);
IF OBJECT_ID('U_EOPTCBRAQ2_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EOPTCBRAQ2_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhSource1] numeric NULL,
    [PdhSource2] numeric NULL,
    [PdhSource3] numeric NULL,
    [PdhSource4] numeric NULL,
    [PdhSource5] numeric NULL,
    [PdhSource6] numeric NULL,
    [PdhSource7] numeric NULL,
    [PdhSource8] numeric NULL,
    [PdhSource9] numeric NULL,
    [PdhSource10] numeric NULL
);
IF OBJECT_ID('U_EOPTCBRAQ2_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EOPTCBRAQ2_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PehCurAmt] numeric NULL,
    [PehCurHrs] decimal NULL,
    [PehCurAmtYTD] money NULL,
    [PehCurHrsYTD] decimal NULL,
    [PehInclInDefComp] money NULL,
    [PehInclInDefCompHrs] decimal NULL,
    [PehInclInDefCompYTD] money NULL,
    [PehInclInDefCompHrsYTD] decimal NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EOPTCBRAQ2]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Cirrus Design Corp.

Created By: James Bender
Business Analyst: Lea King
Create Date: 03/23/2020
Service Request Number: TekP-2020-01-24-005

Purpose: Optum Cobra QB Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EOPTCBRAQ2';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EOPTCBRAQ2';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EOPTCBRAQ2';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EOPTCBRAQ2';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EOPTCBRAQ2' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EOPTCBRAQ2', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EOPTCBRAQ2', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EOPTCBRAQ2', 'OEACTIVE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EOPTCBRAQ2';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EOPTCBRAQ2', @AllObjects = 'Y', @IsWeb = 'Y'
**********************************************************************************/
BEGIN

    --==========================================
    -- Declare variables
    --==========================================
    DECLARE  @FormatCode        VARCHAR(10)
            ,@ExportCode        VARCHAR(10)
            ,@StartDate         DATETIME
            ,@EndDate           DATETIME
            ,@FileMinCovDate    DATETIME
            ,@StartPerControl   VARCHAR(9)
            ,@EndPerControl     VARCHAR(9);

    -- Set FormatCode
    SELECT @FormatCode = 'EOPTCBRAQ2';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@FileMinCovDate = '1/1/2020'
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EOPTCBRAQ2_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EOPTCBRAQ2_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_EOPTCBRAQ2_EEList
    WHERE xEEID IN (SELECT DISTINCT EecEEID FROM dbo.EmpComp WITH (NOLOCK) WHERE EecEEType IN ('TES'));

    DELETE FROM dbo.U_EOPTCBRAQ2_EEList
    WHERE xEEID IN (SELECT DISTINCT EecEEID FROM dbo.EmpComp WITH (NOLOCK) WHERE EecDedGroupCode IN ('INTGB'));

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'DEN,FSA,MHSA,MHSA2,GLIFE, GLBD, GLEXC, GLMAX,LIFEE,LIFES,LIFEC,MPPO,VIS'; --,MINT';

    IF OBJECT_ID('U_EOPTCBRAQ2_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EOPTCBRAQ2_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EOPTCBRAQ2_DedList
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
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    --INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'CobraReasonsEmp', 'BAP,D,DLS,M,NLEE,NLEDR,TOE,LEVNT1,LEVNT2,LEVNT3,LEVNT4,LEVNT5,NLED,LEFTPT,LWOB') 
    --INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'CobraReasonsDep', 'BAP,D,DLS,M,NLEE,NLEDR,TOE,LEVNT1,LEVNT2,LEVNT3,LEVNT4,LEVNT5,NLED,LEFTPT,LWOB')

    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'CobraReasonsEmp', '200,BAP,D,DLS,M,NLEE,NLEDR,TOE,LEVNT1,LEVNT2,LEVNT3,LEVNT4,LEVNT5,NLED,LEFTPT,LWOB,LEULOA') 
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'CobraReasonsDep', '200,BAP,D,DLS,M,NLEE,NLEDR,TOE,LEVNT1,LEVNT2,LEVNT3,LEVNT4,LEVNT5,NLED,LEFTPT,LWOB,LEULOA')

    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraType','4'); -- Eep/ConCobraReason first, then EdhChangeReason. Include CHGRP for elig. ben groups
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraDate','3'); -- EedBenStopDate and DbnBenStopDate, unless Eep/ConDateOfCOBRAEvent exist
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraPQBType','1'); -- If no EE or spouse, ALL children are PQB (not just oldest)
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','Y'); -- DedIsCobraCovered = 'Y'
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraReasonsDepPQB','DLS,LEVNT4,NLED,LEVNT3,D'); -- Valid dependent PQB reasons
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidCobraReasonsEmp','201,204,LEVNT3,LEVNT4,206,207,203,200'); -- Invalidate employee when Cobra Reason is a dependent PQB reason
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidTermReasonsEmp','203'); -- Invalidate employee when Cobra Reason is "Death"
   
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'ConCobraReasonPCF','DependentCOBRAReason'); -- Valid dependent PQB reasons
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CountDependents','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL,DCH,DPC,STC')
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DPC');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'RunID', 'Cobra')
    --INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'AddToPreviousRun', 'Y')
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'AddToPreviousRun', 'N')

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

    -- Remove CHGRP events as they are not used here
    DELETE dbo.U_dsi_BDM_EOPTCBRAQ2 WHERE BdmCobraReason = 'CHGRP'

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EOPTCBRAQ2_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EOPTCBRAQ2_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('401K') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('ROTH') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('MATCH') THEN PdhERCurAmt ELSE 0.00 END)        
        ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('401CU') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('401KL1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('401KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    INTO dbo.U_EOPTCBRAQ2_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EOPTCBRAQ2_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );


    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EOPTCBRAQ2_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EOPTCBRAQ2_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_EOPTCBRAQ2_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;




    IF OBJECT_ID('U_EOPTCBRAQ2_Edh_WorkingTable', 'U') IS NOT NULL
        DROP TABLE dbo.U_EOPTCBRAQ2_Edh_WorkingTable;
    SELECT EDHEEID, EdhCOID, EdhDedCode, edhChangeReason, EdhEffDate, BchIsCOBRAQualifiedEvent
    INTO dbo.U_EOPTCBRAQ2_Edh_WorkingTable
    FROM (SELECT EDHEEID, EdhCOID, EdhDedCode, edhChangeReason, EdhEffDate, BchIsCOBRAQualifiedEvent, ROW_NUMBER() OVER(PARTITION BY EdhEEID, EdhCOID, EdhDedCode ORDER BY EdhEffDate DESC) AS rn 
            FROM dbo.EmpHDed a WITH (NOLOCK)
            JOIN dbo.BenChRsn WITH (NOLOCK)
                ON EdhChangeReason = BchCode
            WHERE EdhDedCode IN ('DEN','FSA','MHSA','MHSA2','GLIFE','GLBD','GLEXC','GLMAX','LIFEE','LIFES','LIFEC','MPPO','VIS','MINT') 
--            AND edhChangeReason IN ('BAP','D','DLS','M','NLEE','NLEDR','TOE','LEVNT1','LEVNT2','LEVNT3','LEVNT4','LEVNT5')) AS T
            AND edhChangeReason IN ('200','BAP','D','DLS','M','NLEE','NLEDR','TOE','LEVNT1','LEVNT2','LEVNT3','LEVNT4','LEVNT5')) AS T
    WHERE RN = 1

    INSERT INTO dbo.U_dsi_BDM_EOPTCBRAQ2 (BdmRecType, BdmCOID, BdmEEID, BdmDepRecID, BdmSystemID, BdmRunID, BdmRelationship, BdmDedCode, BdmBenOption, BdmBenStartDate, BdmBenStopDate, BdmChangeReason, BdmCobraReason, BdmEEAmt)
    (SELECT DISTINCT 'DEP', EdhCOID, EdhEEID, ConSystemID, SystemId /*??*/, 'Cobra', ConRelationship, EdhDedCode, EdhBenOption, EdhBenStartDate, EdhBenStopDate, EdhChangeReason, EdhChangeReason, EdhEEAmt
    FROM dbo.EmpHDed WITH (NOLOCK)
        JOIN dbo.Contacts WITH (NOLOCK)
            ON EdhEEID = ConEEID
        JOIN (Select * from [dbo].[fn_MP_CustomFields_iContacts_Export] (NULL,NULL,NULL,NULL)) AS Cobra_Fields
            ON ConSystemId = SystemID
        JOIN dbo.U_EOPTCBRAQ2_DedList
            ON DedCode = EdhDedCode
    WHERE EdhEffDate BETWEEN @StartDate AND @EndDate)

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EOPTCBRAQ2_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EOPTCBRAQ2_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EOPTCBRAQ2_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = BdmDepRecID --CONVERT(varchar(12),'1') --BdmDepRecID--DELETE IF NOT USING DEPENDENT DATA
        ,drvSort1 = 'BdmCobraReason: ' + ISNULL(BdmCobraReason, 'nope')
        ,drvSort2 = 'DepDateOfCobraEvent: ' + ISNULL(CAST(DepDateOfCobraEvent AS VARCHAR), 'nope')
        ,drvSort3 = 'EecEmplStatus: ' + ISNULL(EecEmplStatus, 'nope')
        ,drvSort4 = 'BdmChangeReason: ' + ISNULL(BdmChangeReason, 'nope')
        -- standard fields above and additional driver fields below
        ,drvNotificationDate = GETDATE()
        ,drvSSN =    CASE WHEN BdmCobraReason IN ('DLS','LEVNT4','NLED','LEVNT3','D') OR EecTermReason IN ('203', 'D') THEN
                            CASE WHEN Spouse_SSN IS NOT NULL THEN Spouse_SSN ELSE DepSSN1 END
                        ELSE '"' + LEFT(eepSSN, 3) + '-' + RIGHT(LEFT(REPLACE(eepSSN, ' ', ''), 5), 2) + '-' + RIGHT(REPLACE(eepSSN, ' ', ''),4) + '"' --eepSSN
                    END
        ,drvNameLast =    CASE WHEN BdmCobraReason IN ('DLS','LEVNT4','NLED','LEVNT3','D') OR EecTermReason IN ('203', 'D') THEN
                                CASE WHEN Spouse_NameLast IS NOT NULL THEN Spouse_NameLast ELSE DepLastName1 END
                            ELSE eepNameLast 
                        END
        ,drvNameFirst =    CASE WHEN BdmCobraReason IN ('DLS','LEVNT4','NLED','LEVNT3','D') OR EecTermReason IN ('203', 'D') THEN
                                CASE WHEN Spouse_NameFirst IS NOT NULL THEN Spouse_NameFirst ELSE DepFirstName1 END
                            ELSE eepNameFirst
                        END
        ,drvNameMiddle =    LEFT(CASE WHEN BdmCobraReason IN ('DLS','LEVNT4','NLED','LEVNT3','D') OR EecTermReason IN ('203', 'D') THEN
                                    CASE WHEN Spouse_NameMiddle IS NOT NULL THEN Spouse_NameMiddle ELSE DepMiddleName1 END
                                ELSE eepNameFirst
                            END, 1)
        ,drvAddressLine1 = REPLACE(EepAddressLine1, ',', '')
        ,drvAddressLine2 = REPLACE(EepAddressLine2, ',', '')
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressPostalCode = EepAddressZipCode
        ,drvDateOfBirth =    CASE WHEN BdmCobraReason IN ('DLS','LEVNT4','NLED','LEVNT3','D') OR EecTermReason IN ('203', 'D') THEN
                                    CASE WHEN Spouse_DateOfBirth IS NOT NULL THEN Spouse_DateOfBirth ELSE DepDateOfBirth1 END
                                ELSE EepDateOfBirth 
                            END

        ,drvGender =    CASE WHEN BdmCobraReason IN ('DLS','LEVNT4','NLED','LEVNT3','D') OR EecTermReason IN ('203', 'D') THEN
                                CASE WHEN Spouse_Gender IS NOT NULL THEN Spouse_Gender ELSE DepGender1 END
                            ELSE EepGender 
                        END
                        --If edhChangeReason = NLED or LEVNT3 and conDateOfCOBRAEvent is blank, send most recent edheffdate else send conDateOfCOBRAEvent.  The file appears to be sending the audit date instead of the edheffdate.
        ,drvQualifiedEventDate =    CASE WHEN BdmCobraReason IN ('DLS','LEVNT4','D') OR EecTermReason IN ('203','D') THEN  
                                            CASE 
                                                WHEN Spouse_DateOfCobraEvent IS NOT NULL THEN Spouse_DateOfCobraEvent ELSE DepDateOfCobraEvent 
                                            END 
                                        WHEN BdmCobraReason IN ('LEVNT3','NLED') AND ISNULL(DepDateOfCobraEvent, '') = ''  THEN EdhEffDate  -- DepDateOfCobraEvent 
                                        WHEN EecEmplStatus = 'L' AND (BdmChangeReason IN ('NLEE', 'LEFTPT', 'ACALOE', 'LEULOA', 'LWOB','CHGRP') OR BdmCobraReason IN ('NLEE', 'LEFTPT', 'ACALOE', 'LEULOA', 'LWOB','CHGRP')) THEN    --'12/31/1999'
                                            (SELECT MAX(BdmBenStopDate) from dbo.U_dsi_BDM_EOPTCBRAQ2 WITH (NOLOCK) where BdmEEID = xEEID AND BdmDedCode IN ('GLIFE','GLBD','GLEXC','GLMAX'))
                                        ELSE EdhEffDate 
                                    END

        --,drvQualifiedEventDate =    CASE WHEN BdmCobraReason IN ('DLS','LEVNT4','D') OR EecTermReason IN ('203','D') THEN  
        --                                CASE WHEN Spouse_DateOfCobraEvent IS NOT NULL THEN Spouse_DateOfCobraEvent ELSE DepDateOfCobraEvent END 
        --                                WHEN BdmCobraReason IN ('LEVNT3','NLED') AND ISNULL(DepDateOfCobraEvent, '') <> ''  THEN EdhEffDate  -- DepDateOfCobraEvent 
        --                                WHEN EecEmplStatus = 'L' AND (BdmChangeReason IN ('NLEE', 'LEFTPT', 'ACALOE', 'LEULOA', 'LWOB','CHGRP') OR BdmCobraReason IN ('NLEE', 'LEFTPT', 'ACALOE', 'LEULOA', 'LWOB','CHGRP')) THEN    --'12/31/1999'
        --                                    (SELECT MAX(BdmBenStopDate) from dbo.U_dsi_BDM_EOPTCBRAQ2 WITH (NOLOCK) where BdmEEID = xEEID AND BdmDedCode IN ('GLIFE','GLBD','GLEXC','GLMAX'))
        --                                ELSE EdhEffDate 
        --                            END 
        ,drvQualifyingEvent =    '"' + CASE WHEN BchIsCOBRAQualifiedEvent = 'Y' THEN 
                                    CASE WHEN Spouse_CobraReason IN ('DLS', 'LEVNT4') OR (BdmRecType = 'DEP' AND BdmCobraReason IN ('DLS', 'LEVNT4')) AND EepAddressState <> 'MN' THEN '08' -- 'Divorce/Separation'
                                        WHEN Spouse_CobraReason IN ('DLS', 'LEVNT4') OR (BdmRecType = 'DEP' AND BdmCobraReason IN ('DLS', 'LEVNT4')) AND EepAddressState = 'MN' THEN '30' -- 'Divorce/Separation'
                                        WHEN EecEmplStatus = 'T' AND EecTermReason IN ('203', 'D') AND EepAddressState <> 'MN' THEN '04' -- 'Death'
                                        WHEN EecEmplStatus = 'T' AND EecTermReason IN ('203', 'D') AND EepAddressState = 'MN' THEN '29' -- 'Death'
                                        WHEN Spouse_CobraReason IN ('NLED', 'LEVNT3') OR (BdmRecType = 'DEP' AND BdmCobraReason IN ('NLED', 'LEVNT3')) THEN '05' -- 'Ineligible Dependent'
                                        WHEN EecEmplStatus = 'T' AND EecTermReason NOT IN ('R','202','D','203') AND EecTermType = 'V' THEN '01' -- 'Termination'
                                        WHEN (BdmChangeReason = 'R' OR EecEmplStatus = 'T') AND (EecTermReason IN ('202','R')) THEN '01' --'02' -- 'Retirement'
                                        WHEN BdmChangeReason IN ('NLEE','LEFTPT','ACALOE','LEULOA') THEN '06' -- 'Reduced Hours'
                                        WHEN eecEmplStatus = 'T' AND EecTermReason NOT IN ('R','202','D','203') and EecTermType = 'I' THEN '13' -- 'Involuntary Termination'
                                        WHEN EecEmplStatus = 'L' AND edhChangeReason = 'LWOB' THEN '07' -- 'Leave of Absence'
                                        WHEN BdmChangeReason = 'ML' THEN '12'
                                        WHEN BdmChangeReason = 'MEDIC' THEN '03'
                                        WHEN BdmChangeReason = 'DISAB' THEN '28'                                        
                                    END
                                END + '"'
        ,drvCobraBegins =    CASE WHEN BdmCobraReason IN ('DLS','LEVNT4','D') OR EecTermReason IN ('203','D') THEN 
                                            CASE WHEN Spouse_DateOfCobraEvent IS NOT NULL THEN DATEADD(MONTH, 1, Spouse_DateOfCobraEvent)-DAY(DATEADD(MONTH, 1, Spouse_DateOfCobraEvent))+1 ELSE DATEADD(MONTH, 1, DepDateOfCobraEvent)-DAY(DATEADD(MONTH, 1, DepDateOfCobraEvent))+1 END
                                        --WHEN BdmCobraReason IN ('LEVNT3','NLED') AND ISNULL(DepDateOfCobraEvent, '') <> ''  THEN DATEADD(MONTH, 1, EdhEffDate)-DAY(DATEADD(MONTH, 1, EdhEffDate))+1
                                        WHEN BdmCobraReason IN ('LEVNT3','NLED') AND ISNULL(DepDateOfCobraEvent, '') <> ''  THEN DATEADD(MONTH, 1, EdhEffDate)-DAY(DATEADD(MONTH, 1, EdhEffDate))+1
                                        WHEN EecEmplStatus = 'L' AND (BdmChangeReason IN ('NLEE', 'LEFTPT', 'ACALOE', 'LEULOA', 'LWOB') OR BdmCobraReason IN ('NLEE', 'LEFTPT', 'ACALOE', 'LEULOA', 'LWOB')) THEN --'12/31/1999'
                                            (SELECT DATEADD(MONTH, 1, MAX(BdmBenStopDate))-DAY(DATEADD(MONTH, 1, MAX(BdmBenStopDate)))+1 from dbo.U_dsi_BDM_EOPTCBRAQ2 WITH (NOLOCK) where BdmEEID = xEEID AND BdmDedCode IN ('GLIFE','GLBD','GLEXC','GLMAX'))
                                        ELSE DATEADD(MONTH, 1, EdhEffDate)-DAY(DATEADD(MONTH, 1, EdhEffDate))+1
                            END
        ,drvEmployeeFullName = CASE WHEN BdmCobraReason IN ('DLS','LEVNT4','NLED','LEVNT3','D') OR EecTermReason IN ('203', 'D') THEN '"' + EepNameLast + ', ' + EepNameFirst + '"' END
        ,drvEmployeeSSN = CASE WHEN BdmCobraReason IN ('DLS','LEVNT4','NLED','LEVNT3','D') OR EecTermReason IN ('203', 'D') THEN EepSSN END
        ,drvEmployeeSpecial = CASE WHEN BdmCobraReason IN ('DLS','LEVNT4','NLED','LEVNT3','D') OR EecTermReason IN ('203', 'D') THEN 'DEP' END        
        ,drvMedicalPlanStartDate =    CASE WHEN MPPO IS NOT NULL THEN MPPO_BdmBenStartDate
                                        WHEN MHSA IS NOT NULL THEN MHSA_BdmBenStartDate
                                        WHEN MHSA2 IS NOT NULL THEN MHSA2_BdmBenStartDate
                                        WHEN MINT IS NOT NULL THEN MINT_BdmBenStartDate 
                                    END        
        ,drvMedicalPlan =    CASE WHEN MHSA IS NOT NULL THEN 'HSA1500' 
                                WHEN MHSA2 IS NOT NULL THEN 'HSA2800' 
                                WHEN MPPO IS NOT NULL THEN 'PPO1' 
                            END
        ,drvMedicalCoverage =    CASE WHEN MPPO IS NOT NULL OR MHSA IS NOT NULL OR MHSA2 IS NOT NULL OR MINT IS NOT NULL THEN
                                    CASE WHEN MPPO_BdmBenOption = 'EE' OR MHSA_BdmBenOption = 'EE' OR MHSA2_BdmBenOption = 'EE' OR MINT_BdmBenOption = 'EE' THEN '01'
                                        WHEN MPPO_BdmBenOption = 'EEF' OR MHSA_BdmBenOption = 'EEF' OR MHSA2_BdmBenOption = 'EEF' OR MINT_BdmBenOption = 'EEF' THEN '04'
                                        WHEN MPPO_BdmBenOption = 'EEDPF' OR MHSA_BdmBenOption = 'EEDPF' OR MHSA2_BdmBenOption = 'EEDPF' OR MINT_BdmBenOption = 'EEDPF' THEN '04'
                                        WHEN MPPO_BdmBenOption = 'EES' OR MHSA_BdmBenOption = 'EES' OR MHSA2_BdmBenOption = 'EES' OR MINT_BdmBenOption = 'EES' THEN '06'
                                        WHEN MPPO_BdmBenOption = 'EEDP' OR MHSA_BdmBenOption = 'EEDP' OR MHSA2_BdmBenOption = 'EEDP' OR MINT_BdmBenOption = 'EEDP' THEN '06'
                                        WHEN MPPO_BdmBenOption = 'EEC' OR MHSA_BdmBenOption = 'EEC' OR MHSA2_BdmBenOption = 'EEC' OR MINT_BdmBenOption = 'EEC' THEN '08'
                                    END
                                END
        ,drvDentalPlan = CASE WHEN DEN IS NOT NULL THEN 'DENTAL' END 
        ,drvDentalCoverage =    CASE WHEN DEN IS NOT NULL THEN
                                    CASE WHEN DEN_BdmBenOption IN ('EE') THEN '01' 
                                        WHEN DEN_BdmBenOption IN ('EEF', 'EEDPF') THEN '04' 
                                        WHEN DEN_BdmBenOption IN ('EES', 'EEDP') THEN '06' 
                                        WHEN DEN_BdmBenOption IN ('EEC') THEN '08' 
                                    END
                                END
        ,drvVisionPlan = CASE WHEN VIS IS NOT NULL THEN 'VISION01' END
        ,drvVisionCoverage =    CASE WHEN VIS IS NOT NULL THEN
                                    CASE WHEN VIS_BdmBenOption IN ('EE') THEN '01'
                                        WHEN VIS_BdmBenOption IN ('EEF', 'EEDPF') THEN '04'
                                        WHEN VIS_BdmBenOption IN ('EES', 'EEDP') THEN '06'
                                        WHEN VIS_BdmBenOption IN ('EEC') THEN '08'
                                    END
                                END
        ,drvLifePlan1 = CASE WHEN GLIFE IS NOT NULL OR GLBD IS NOT NULL OR GLEXC IS NOT NULL OR GLMAX IS NOT NULL THEN 'LIFE01' END
        ,drvLifePlan1Coverage = CASE WHEN GLIFE IS NOT NULL OR GLBD IS NOT NULL OR GLEXC IS NOT NULL OR GLMAX IS NOT NULL THEN '1' END
        ,drvLifePlan1Volume =    CASE WHEN GLIFE IS NOT NULL OR GLBD IS NOT NULL OR GLEXC IS NOT NULL OR GLMAX IS NOT NULL THEN 
                                    (select TOP 1 FORMAT(PdhDedCalcBasisAmt, '#0.00') from dbo.pDedHist A WITH (NOLOCK) where pdhEEID = xEEID AND PdhCOID = xCOID AND pdhDedCode IN ('GLIFE', 'GLBD', 'GLEXC','GLMAX','LIFE01') order by A.PdhPerControl desc)
                                END
        ,drvLifePlan2 = CASE WHEN LIFEE IS NOT NULL THEN 'LIFE02' END
        ,drvLifePlan2Coverage = CASE WHEN LIFEE IS NOT NULL THEN '1' END
        ,drvLife2Volume =    CASE WHEN LIFEE IS NOT NULL THEN 
                                (select TOP 1 FORMAT(PdhDedCalcBasisAmt, '#0.00') from dbo.pDedHist A WITH (NOLOCK) where pdhEEID = xEEID AND PdhCOID = xCOID AND pdhDedCode IN ('LIFEE') order by A.PdhPerControl desc)
                            END
        ,drvLifePlan3 = CASE WHEN LIFES IS NOT NULL THEN 'LIFE03' END
        ,drvLifePlan3Coverage = CASE WHEN LIFES IS NOT NULL THEN '1' END
        ,drvLife3Volume =    CASE WHEN LIFES IS NOT NULL THEN
                                (select TOP 1 FORMAT(PdhDedCalcBasisAmt, '#0.00') from dbo.pDedHist A WITH (NOLOCK) where pdhEEID = xEEID AND PdhCOID = xCOID AND pdhDedCode IN ('LIFES') order by A.PdhPerControl desc)
                            END
        ,drvLifePLan4 = CASE WHEN LIFEC IS NOT NULL THEN 'LIFE04' END
        ,drvLife4Coverage = CASE WHEN LIFEC IS NOT NULL THEN '1' END
        ,drvLife4Volume =    CASE WHEN LIFEC IS NOT NULL THEN
                                (select TOP 1 FORMAT(PdhDedCalcBasisAmt, '#0.00') from dbo.pDedHist A WITH (NOLOCK) where pdhEEID = xEEID AND PdhCOID = xCOID AND pdhDedCode IN ('LIFEC') order by A.PdhPerControl desc)
                            END
        --CASE WHEN LIFEC IS NOT NULL THEN LIFEC_BdmEEAmt END
        ,drvFlexPlan = CASE WHEN FSA IS NOT NULL THEN 'FSA' /*'FURTHER FSA PLAN'*/ END
        ,drvFlexCoverageLevel = CASE WHEN FSA IS NOT NULL THEN 'FF' END
        ,drvFlexHCAmount = CASE WHEN FSA IS NOT NULL THEN FORMAT(FSA_BdmEEAmt*26/12, '#0.00') END
        ,drvFlexPlanEndDate = CASE WHEN FSA IS NOT NULL THEN DATEADD(YEAR, DATEDIFF(YEAR, 0, GETDATE()) + 1, -1) END
        ,drvDep1LastName = DepLastName1
        ,drvDep1FirstName = DepFirstName1
        ,drvDep1SSN = DepSSN1
        ,drvDep1Gender = DepGender1
        ,drvDep1Relationship = DepRelationship1
        ,drvDep1DateOfBirth = DepDateOfBirth1
        ,drvDep1Medical =    CASE WHEN DepLastName1 IS NOT NULL THEN
                                CASE WHEN MHSA IS NOT NULL THEN 'HSA1500' -- 'BCBS $1500 H S A'
                                    WHEN MHSA2 IS NOT NULL THEN 'HSA2800' -- 'BCBS $2800 H S A'
--                                    WHEN MINT IS NOT NULL THEN 'CIGNA INTERNATIONAL PLAN'
                                    WHEN MPPO IS NOT NULL THEN 'PPO1' -- 'BCBS TRADITIONAL PPO'
                                END
                            END
        ,drvDep1Dental = CASE WHEN DEN IS NOT NULL AND DepLastName1 IS NOT NULL THEN 'DENTAL' END
        ,drvDep1Vision = CASE WHEN VIS IS NOT NULL AND DepLastName1 IS NOT NULL THEN 'VISION01' END
        ,drvDep1OtherPlan =    CASE WHEN LIFEC IS NOT NULL AND DepLastName1 IS NOT NULL AND DepRelationship1 = 'Child' THEN 'LIFE04'
                                WHEN LIFES IS NOT NULL AND DepLastName1 IS NOT NULL AND DepRelationship1 = 'Spouse' THEN 'LIFE03'
                            END
        ,drvDep2LastName = DepLastName2
        ,drvDep2FirstName = DepFirstName2
        ,drvDep2SSN = DepSSN2
        ,drvDep2Gender = DepGender2
        ,drvDep2Relationship = DepRelationship2
        ,drvDep2DateOfBirth = DepDateOfBirth2
        ,drvDep2Medical =    CASE WHEN DepLastName2 IS NOT NULL THEN
                                CASE WHEN MHSA IS NOT NULL THEN 'HSA1500' -- 'BCBS $1500 H S A'
                                    WHEN MHSA2 IS NOT NULL THEN 'HSA2800' -- 'BCBS $2800 H S A'
                                    WHEN MPPO IS NOT NULL THEN 'PPO1' -- 'BCBS TRADITIONAL PPO'
                                END
                            END
        ,drvDep2Dental = CASE WHEN DEN IS NOT NULL AND DepLastName2 IS NOT NULL THEN 'DENTAL' END
        ,drvDep2Vision = CASE WHEN VIS IS NOT NULL AND DepLastName2 IS NOT NULL THEN 'VISION01' END
        ,drvDep2OtherPlan =    CASE WHEN LIFEC IS NOT NULL AND DepLastName2 IS NOT NULL  AND DepRelationship2 = 'Child' THEN 'LIFE04'
                                WHEN LIFES IS NOT NULL AND DepLastName2 IS NOT NULL AND DepRelationship2 = 'Spouse' THEN 'LIFE03'
                            END
        ,drvDep3LastName = DepLastName3
        ,drvDep3FirstName = DepFirstName3
        ,drvDep3SSN = DepSSN3
        ,drvDep3Gender = DepGender3
        ,drvDep3Relationship = DepRelationship3
        ,drvDep3DateOfBirth = DepDateOfBirth3
        ,drvDep3Medical =    CASE WHEN DepLastName3 IS NOT NULL THEN
                                CASE WHEN MHSA IS NOT NULL THEN 'HSA1500' -- 'BCBS $1500 H S A'
                                    WHEN MHSA2 IS NOT NULL THEN 'HSA2800' -- 'BCBS $2800 H S A'
--                                    WHEN MINT IS NOT NULL THEN 'CIGNA INTERNATIONAL PLAN'
                                    WHEN MPPO IS NOT NULL THEN 'PPO1' -- 'BCBS TRADITIONAL PPO'
                                END
                            END
        ,drvDep3Dental = CASE WHEN DEN IS NOT NULL AND DepLastName3 IS NOT NULL THEN 'DENTAL' END
        ,drvDep3Vision = CASE WHEN VIS IS NOT NULL AND DepLastName3 IS NOT NULL THEN 'VISION01' END
        ,drvDep3OtherPlan = CASE WHEN LIFEC IS NOT NULL AND DepLastName3 IS NOT NULL  AND DepRelationship3 = 'Child' THEN 'LIFE04'
                                WHEN LIFES IS NOT NULL AND DepLastName3 IS NOT NULL AND DepRelationship3 = 'Spouse' THEN 'LIFE03'
                            END
        ,drvDep4LastName = DepLastName4
        ,drvDep4FirstName = DepFirstName4
        ,drvDep4SSN = DepSSN4
        ,drvDep4Gender = DepGender4
        ,drvDep4Relationship = DepRelationship4
        ,drvDep4DateOfBirth = DepDateOfBirth4
        ,drvDep4Medical =    CASE WHEN DepLastName4 IS NOT NULL THEN
                                CASE WHEN MHSA IS NOT NULL THEN 'HSA1500' -- 'BCBS $1500 H S A'
                                    WHEN MHSA2 IS NOT NULL THEN 'HSA2800' -- 'BCBS $2800 H S A'
                                    WHEN MPPO IS NOT NULL THEN 'PPO1' -- 'BCBS TRADITIONAL PPO'
                                END
                            END
        ,drvDep4Dental = CASE WHEN DEN IS NOT NULL AND DepLastName4 IS NOT NULL THEN 'DENTAL' END
        ,drvDep4Vision = CASE WHEN VIS IS NOT NULL AND DepLastName4 IS NOT NULL THEN 'VISION01' END
        ,drvDep4OtherPlan =    CASE WHEN LIFEC IS NOT NULL AND DepLastName4 IS NOT NULL  AND DepRelationship4 = 'Child' THEN 'LIFE04'
                                WHEN LIFES IS NOT NULL AND DepLastName4 IS NOT NULL AND DepRelationship4 = 'Spouse' THEN 'LIFE03'
                            END
        ,drvDep5LastName = DepLastName5
        ,drvDep5FirstName = DepFirstName5
        ,drvDep5SSN = DepSSN5
        ,drvDep5Gender = DepGender5
        ,drvDep5Relationship = DepRelationship5
        ,drvDep5DateOfBirth = DepDateOfBirth5
        ,drvDep5Medical =    CASE WHEN DepLastName5 IS NOT NULL THEN
                                CASE WHEN MHSA IS NOT NULL THEN 'HSA1500' -- 'BCBS $1500 H S A'
                                    WHEN MHSA2 IS NOT NULL THEN 'HSA2800' -- 'BCBS $2800 H S A'
                                    WHEN MPPO IS NOT NULL THEN 'PPO1' -- 'BCBS TRADITIONAL PPO'
                                END
                            END
        ,drvDep5Dental = CASE WHEN DEN IS NOT NULL AND DepLastName5 IS NOT NULL THEN 'DENTAL' END
        ,drvDep5Vision = CASE WHEN VIS IS NOT NULL AND DepLastName5 IS NOT NULL THEN 'VISION01' END
        ,drvDep5OtherPlan =    CASE WHEN LIFEC IS NOT NULL AND DepLastName5 IS NOT NULL  AND DepRelationship5 = 'Child' THEN 'LIFE04'
                                WHEN LIFES IS NOT NULL AND DepLastName5 IS NOT NULL AND DepRelationship5 = 'Spouse' THEN 'LIFE03'
                            END
        ,drvDep6LastName = DepLastName6
        ,drvDep6FirstName = DepFirstName6
        ,drvDep6SSN = DepSSN6
        ,drvDep6Gender = DepGender6
        ,drvDep6Relationship = DepRelationship6
        ,drvDep6DateOfBirth = DepDateOfBirth6
        ,drvDep6Medical =    CASE WHEN DepLastName6 IS NOT NULL THEN
                                CASE WHEN MHSA IS NOT NULL THEN 'HSA1500' -- 'BCBS $1500 H S A'
                                    WHEN MHSA2 IS NOT NULL THEN 'HSA2800' -- 'BCBS $2800 H S A'
                                    WHEN MPPO IS NOT NULL THEN 'PPO1' -- 'BCBS TRADITIONAL PPO'
                                END
                            END
        ,drvDep6Dental = CASE WHEN DEN IS NOT NULL AND DepLastName6 IS NOT NULL THEN 'DENTAL' END
        ,drvDep6Vision = CASE WHEN VIS IS NOT NULL AND DepLastName6 IS NOT NULL THEN 'VISION01' END
        ,drvDep6OtherPlan =    CASE WHEN LIFEC IS NOT NULL AND DepLastName6 IS NOT NULL  AND DepRelationship6 = 'Child' THEN 'LIFE04'
                                WHEN LIFES IS NOT NULL AND DepLastName6 IS NOT NULL AND DepRelationship6 = 'Spouse' THEN 'LIFE03'
                            END
        ,drvDep7LastName = DepLastName7
        ,drvDep7FirstName = DepFirstName7
        ,drvDep7SSN = DepSSN7
        ,drvDep7Gender = DepGender7
        ,drvDep7Relationship = DepRelationship7
        ,drvDep7DateOfBirth = DepDateOfBirth7
        ,drvDep7Medical =    CASE WHEN DepLastName7 IS NOT NULL THEN
                                CASE WHEN MHSA IS NOT NULL THEN 'HSA1500' -- 'BCBS $1500 H S A'
                                    WHEN MHSA2 IS NOT NULL THEN 'HSA2800' -- 'BCBS $2800 H S A'
                                    WHEN MPPO IS NOT NULL THEN 'PPO1' -- 'BCBS TRADITIONAL PPO'
                                END
                            END
        ,drvDep7Dental = CASE WHEN DEN IS NOT NULL AND DepLastName7 IS NOT NULL THEN 'DENTAL' END
        ,drvDep7Vision = CASE WHEN VIS IS NOT NULL AND DepLastName7 IS NOT NULL THEN 'VISION01' END
        ,drvDep7OtherPlan =    CASE WHEN LIFEC IS NOT NULL AND DepLastName7 IS NOT NULL  AND DepRelationship7 = 'Child' THEN 'LIFE04'
                                WHEN LIFES IS NOT NULL AND DepLastName7 IS NOT NULL AND DepRelationship7 = 'Spouse' THEN 'LIFE03'
                            END
        ,drvDep8LastName = DepLastName8
        ,drvDep8FirstName = DepFirstName8
        ,drvDep8SSN = DepSSN8
        ,drvDep8Gender = DepGender8
        ,drvDep8Relationship = DepRelationship8
        ,drvDep8DateOfBirth = DepDateOfBirth8
        ,drvDep8Medical =    CASE WHEN DepLastName8 IS NOT NULL THEN
                                CASE WHEN MHSA IS NOT NULL THEN 'HSA1500' -- 'BCBS $1500 H S A'
                                    WHEN MHSA2 IS NOT NULL THEN 'HSA2800' -- 'BCBS $2800 H S A'
                                    WHEN MPPO IS NOT NULL THEN 'PPO1' -- 'BCBS TRADITIONAL PPO'
                                END
                            END
        ,drvDep8Dental = CASE WHEN DEN IS NOT NULL AND DepLastName8 IS NOT NULL THEN 'DENTAL' END
        ,drvDep8Vision = CASE WHEN VIS IS NOT NULL AND DepLastName8 IS NOT NULL THEN 'VISION01' END
        ,drvDep8OtherPlan =    CASE WHEN LIFEC IS NOT NULL AND DepLastName8 IS NOT NULL  AND DepRelationship8 = 'Child' THEN 'LIFE04'
                                WHEN LIFES IS NOT NULL AND DepLastName8 IS NOT NULL AND DepRelationship8 = 'Spouse' THEN 'LIFE03'
                            END
        ,drvDep9LastName = DepLastName9
        ,drvDep9FirstName = DepFirstName9
        ,drvDep9SSN = DepSSN9
        ,drvDep9Gender = DepGender9
        ,drvDep9Relationship = DepRelationship9
        ,drvDep9DateOfBirth = DepDateOfBirth9
        ,drvDep9Medical =    CASE WHEN DepLastName9 IS NOT NULL THEN
                                CASE WHEN MHSA IS NOT NULL THEN 'HSA1500' -- 'BCBS $1500 H S A'
                                    WHEN MHSA2 IS NOT NULL THEN 'HSA2800' -- 'BCBS $2800 H S A'
                                    WHEN MPPO IS NOT NULL THEN 'PPO1' -- 'BCBS TRADITIONAL PPO'
                                END
                            END
        ,drvDep9Dental = CASE WHEN DEN IS NOT NULL AND DepLastName9 IS NOT NULL THEN 'DENTAL' END
        ,drvDep9Vision = CASE WHEN VIS IS NOT NULL AND DepLastName9 IS NOT NULL THEN 'VISION01' END
        ,drvDep9OtherPlan =    CASE WHEN LIFEC IS NOT NULL AND DepLastName9 IS NOT NULL  AND DepRelationship9 = 'Child' THEN 'LIFE04'
                                WHEN LIFES IS NOT NULL AND DepLastName9 IS NOT NULL AND DepRelationship9 = 'Spouse' THEN 'LIFE03'
                            END
        ,drvDep10LastName = DepLastName10
        ,drvDep10FirstName = DepFirstName10
        ,drvDep10SSN = DepSSN10
        ,drvDep10Gender = DepGender10
        ,drvDep10Relationship = DepRelationship10
        ,drvDep10DateOfBirth = DepDateOfBirth10
        ,drvDep10Medical =    CASE WHEN DepLastName10 IS NOT NULL THEN
                                CASE WHEN MHSA IS NOT NULL THEN 'HSA1500' -- 'BCBS $1500 H S A'
                                    WHEN MHSA2 IS NOT NULL THEN 'HSA2800' -- 'BCBS $2800 H S A'
                                    WHEN MPPO IS NOT NULL THEN 'PPO1' -- 'BCBS TRADITIONAL PPO'
                                END
                            END
        ,drvDep10Dental =  CASE WHEN DEN IS NOT NULL AND DepLastName10 IS NOT NULL THEN 'DENTAL' END
        ,drvDep10Vision = CASE WHEN VIS IS NOT NULL AND DepLastName10 IS NOT NULL THEN 'VISION01' END
        ,drvDep10OtherPlan = CASE WHEN LIFEC IS NOT NULL AND DepLastName10 IS NOT NULL  AND DepRelationship10 = 'Child' THEN 'LIFE04'
                                WHEN LIFES IS NOT NULL AND DepLastName10 IS NOT NULL AND DepRelationship10 = 'Spouse' THEN 'LIFE03'
                            END
        ,drvDep11LastName = DepLastName11
        ,drvDep11FirstName = DepFirstName11
        ,drvDep11SSN = DepSSN11
        ,drvDep11Gender = DepGender11
        ,drvDep11Relationship = DepRelationship11
        ,drvDep11DateOfBirth = DepDateOfBirth11
        ,drvDep11Medical =    CASE WHEN DepLastName11 IS NOT NULL THEN
                                CASE WHEN MHSA IS NOT NULL THEN 'HSA1500' -- 'BCBS $1500 H S A'
                                    WHEN MHSA2 IS NOT NULL THEN 'HSA2800' -- 'BCBS $2800 H S A'
                                    WHEN MPPO IS NOT NULL THEN 'PPO1' -- 'BCBS TRADITIONAL PPO'
                                END
                            END
        ,drvDep11Dental =  CASE WHEN DEN IS NOT NULL AND DepLastName11 IS NOT NULL THEN 'DENTAL' END
        ,drvDep11Vision = CASE WHEN VIS IS NOT NULL AND DepLastName11 IS NOT NULL THEN 'VISION01' END
        ,drvDep11OtherPlan = CASE WHEN LIFEC IS NOT NULL AND DepLastName11 IS NOT NULL  AND DepRelationship11 = 'Child' THEN 'LIFE04'
                                WHEN LIFES IS NOT NULL AND DepLastName11 IS NOT NULL AND DepRelationship11 = 'Spouse' THEN  'LIFE03'
                            END
        ,drvSpouseDOB = Spouse_DateOfBirth 
        ,drvSpecialInstructions =    CASE WHEN EepUDField03 IS NOT NULL OR EepUDField04 IS NOT NULL OR EepUDField09 IS NOT NULL THEN 
                                        CASE WHEN EepUDField03 IS NOT NULL THEN
                                            CASE WHEN MHSA IS NOT NULL THEN 'HSA1500'
                                                WHEN MHSA2 IS NOT NULL THEN 'HSA2800'
                                                WHEN MPPO IS NOT NULL THEN 'PPO1'                                            
                                            END 
                                            + '-' + ISNULL(FORMAT(EepUDfield03, '#0.00'), '') + '-' + ISNULL(EepUDField09, '') 
                                        ELSE ''
                                        END
                                        +
                                        CASE WHEN EepUDField03 IS NOT NULL AND EepUDField04 IS NOT NULL THEN '-' ELSE '' END
                                        +
                                        CASE WHEN EepUDField04 IS NOT NULL THEN 'DENT01-' + ISNULL(FORMAT(EepUDfield04, '#0.00'), '') + '-' + ISNULL(EepUDField09, '') 
                                        ELSE ''                                                        
                                        END
                                    END
    INTO dbo.U_EOPTCBRAQ2_drvTbl
    FROM dbo.U_EOPTCBRAQ2_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN (SELECT BdmEEID, BdmCOID
            ,MAX(BdmRecType) AS BdmRecType
            ,MAX(BdmCobraReason) AS BdmCobraReason
            ,MAX(BdmChangeReason) AS BdmChangeReason
            ,MAX(BdmDepRecID) AS BdmDepRecID
            ,MAX(CASE WHEN BdmDedCode = 'DEN' THEN BdmDedCode END) AS DEN
            ,MAX(CASE WHEN BdmDedCode = 'FSA' THEN BdmDedCode END) AS FSA
            ,MAX(CASE WHEN BdmDedCode = 'MHSA' THEN BdmDedCode END) AS MHSA
            ,MAX(CASE WHEN BdmDedCode = 'MHSA2' THEN BdmDedCode END) AS MHSA2
            ,MAX(CASE WHEN BdmDedCode = 'GLIFE' THEN BdmDedCode END) AS GLIFE
            ,MAX(CASE WHEN BdmDedCode = 'LIFEE' THEN BdmDedCode END) AS LIFEE
            ,MAX(CASE WHEN BdmDedCode = 'LIFES' THEN BdmDedCode END) AS LIFES
            ,MAX(CASE WHEN BdmDedCode = 'LIFEC' THEN BdmDedCode END) AS LIFEC
            ,MAX(CASE WHEN BdmDedCode = 'MPPO' THEN BdmDedCode END) AS MPPO
            ,MAX(CASE WHEN BdmDedCode = 'VIS' THEN BdmDedCode END) AS VIS
            ,MAX(CASE WHEN BdmDedCode = 'MINT' THEN BdmDedCode END) AS MINT
            ,MAX(CASE WHEN BdmDedCode = 'GLBD' THEN BdmDedCode END) AS GLBD
            ,MAX(CASE WHEN BdmDedCode = 'GLEXC' THEN BdmDedCode END) AS GLEXC
            ,MAX(CASE WHEN BdmDedCode = 'GLMAX' THEN BdmDedCode END) AS GLMAX
            ,MAX(CASE WHEN BdmDedCode = 'DEN' THEN BdmBenStartDate END) AS DEN_BdmBenStartDate
            ,MAX(CASE WHEN BdmDedCode = 'FSA' THEN BdmBenStartDate END) AS FSA_BdmBenStartDate
            ,MAX(CASE WHEN BdmDedCode = 'MHSA' THEN BdmBenStartDate END) AS MHSA_BdmBenStartDate
            ,MAX(CASE WHEN BdmDedCode = 'MHSA2' THEN BdmBenStartDate END) AS MHSA2_BdmBenStartDate
            ,MAX(CASE WHEN BdmDedCode = 'GLIFE' THEN BdmBenStartDate END) AS GLIFE_BdmBenStartDate
            ,MAX(CASE WHEN BdmDedCode = 'LIFEE' THEN BdmBenStartDate END) AS LIFEE_BdmBenStartDate
            ,MAX(CASE WHEN BdmDedCode = 'LIFES' THEN BdmBenStartDate END) AS LIFES_BdmBenStartDate
            ,MAX(CASE WHEN BdmDedCode = 'LIFEC' THEN BdmBenStartDate END) AS LIFEC_BdmBenStartDate
            ,MAX(CASE WHEN BdmDedCode = 'MPPO' THEN BdmBenStartDate END) AS MPPO_BdmBenStartDate
            ,MAX(CASE WHEN BdmDedCode = 'VIS' THEN BdmBenStartDate END) AS VIS_BdmBenStartDate
            ,MAX(CASE WHEN BdmDedCode = 'MINT' THEN BdmBenStartDate END) AS MINT_BdmBenStartDate
            ,MAX(CASE WHEN BdmDedCode = 'GLBD' THEN BdmBenStartDate END) AS GLBD_BdmBenStartDate
            ,MAX(CASE WHEN BdmDedCode = 'GLEXC' THEN BdmBenStartDate END) AS GLEXC_BdmBenStartDate
            ,MAX(CASE WHEN BdmDedCode = 'GLMAX' THEN BdmBenStartDate END) AS GLMAX_BdmBenStartDate
            ,MAX(CASE WHEN BdmDedCode = 'DEN' THEN BdmBenOption END) AS DEN_BdmBenOption
            ,MAX(CASE WHEN BdmDedCode = 'FSA' THEN BdmBenOption END) AS FSA_BdmBenOption
            ,MAX(CASE WHEN BdmDedCode = 'MHSA' THEN BdmBenOption END) AS MHSA_BdmBenOption
            ,MAX(CASE WHEN BdmDedCode = 'MHSA2' THEN BdmBenOption END) AS MHSA2_BdmBenOption
            ,MAX(CASE WHEN BdmDedCode = 'GLIFE' THEN BdmBenOption END) AS GLIFE_BdmBenOption
            ,MAX(CASE WHEN BdmDedCode = 'LIFEE' THEN BdmBenOption END) AS LIFEE_BdmBenOption
            ,MAX(CASE WHEN BdmDedCode = 'LIFES' THEN BdmBenOption END) AS LIFES_BdmBenOption
            ,MAX(CASE WHEN BdmDedCode = 'LIFEC' THEN BdmBenOption END) AS LIFEC_BdmBenOption
            ,MAX(CASE WHEN BdmDedCode = 'MPPO' THEN BdmBenOption END) AS MPPO_BdmBenOption
            ,MAX(CASE WHEN BdmDedCode = 'VIS' THEN BdmBenOption END) AS VIS_BdmBenOption
            ,MAX(CASE WHEN BdmDedCode = 'MINT' THEN BdmBenOption END) AS MINT_BdmBenOption
            ,MAX(CASE WHEN BdmDedCode = 'GLBD' THEN BdmBenOption END) AS GLBD_BdmBenOption
            ,MAX(CASE WHEN BdmDedCode = 'GLEXC' THEN BdmBenOption END) AS GLEXC_BdmBenOption
            ,MAX(CASE WHEN BdmDedCode = 'GLMAX' THEN BdmBenOption END) AS GLMAX_BdmBenOption
            ,MAX(CASE WHEN BdmDedCode = 'DEN' THEN BdmEEAmt END) AS DEN_BdmEEAmount
            ,MAX(CASE WHEN BdmDedCode = 'FSA' THEN BdmEEAmt END) AS FSA_BdmEEAmt
            ,MAX(CASE WHEN BdmDedCode = 'MHSA' THEN BdmEEAmt END) AS MHSA_BdmEEAmt
            ,MAX(CASE WHEN BdmDedCode = 'MHSA2' THEN BdmEEAmt END) AS MHSA2_BdmEEAmt
            ,MAX(CASE WHEN BdmDedCode = 'GLIFE' THEN BdmEEAmt END) AS GLIFE_BdmEEAmt
            ,MAX(CASE WHEN BdmDedCode = 'LIFEE' THEN BdmEEAmt END) AS LIFEE_BdmEEAmt
            ,MAX(CASE WHEN BdmDedCode = 'LIFES' THEN BdmEEAmt END) AS LIFES_BdmEEAmt
            ,MAX(CASE WHEN BdmDedCode = 'LIFEC' THEN BdmEEAmt END) AS LIFEC_BdmEEAmt
            ,MAX(CASE WHEN BdmDedCode = 'MPPO' THEN BdmEEAmt END) AS MPPO_BdmEEAmt
            ,MAX(CASE WHEN BdmDedCode = 'VIS' THEN BdmEEAmt END) AS VIS_BdmEEAmt
            ,MAX(CASE WHEN BdmDedCode = 'MINT' THEN BdmEEAmt END) AS MINT_BdmEEAmt
            ,MAX(CASE WHEN BdmDedCode = 'GLBD' THEN BdmEEAmt END) AS GLBD_BdmEEAmt
            ,MAX(CASE WHEN BdmDedCode = 'GLEXC' THEN BdmEEAmt END) AS GLEXC_BdmEEAmt
            ,MAX(CASE WHEN BdmDedCode = 'GLMAX' THEN BdmEEAmt END) AS GLMAX_BdmEEAmt
            FROM dbo.U_dsi_BDM_EOPTCBRAQ2 WITH (NOLOCK)
            GROUP BY BdmEEID, BdmCOID
            ) AS T
        ON BdmEEID = xEEID
        AND BdmCOID = xCOID
    LEFT JOIN (
                SELECT ConEEID
                    ,MAX(CASE WHEN Dep_Number = 1 THEN ConNameLast END) AS DepLastName1
                    ,MAX(CASE WHEN Dep_Number = 1 THEN ConNameFirst END) AS DepFirstName1
                    ,MAX(CASE WHEN Dep_Number = 1 THEN ConNameMiddle END) AS DepMiddleName1
                    ,MAX(CASE WHEN Dep_Number = 1 THEN ConRelationship END) AS DepRelationship1
                    ,MAX(CASE WHEN Dep_Number = 1 THEN '"' + LEFT(ConSSN, 3) + '-' + RIGHT(LEFT(REPLACE(ConSSN, ' ', ''), 5), 2) + '-' + RIGHT(REPLACE(ConSSN, ' ', ''),4) + '"' END) AS DepSSN1
--                    ConSSN END) AS DepSSN1
                    ,MAX(CASE WHEN Dep_Number = 1 THEN ConGender END) AS DepGender1
                    ,MAX(CASE WHEN Dep_Number = 1 THEN ConDateOfBirth END) AS DepDateOfBirth1
                    ,MAX(CASE WHEN Dep_Number = 1 THEN ConSystemId END) AS DepSystemId1
                    ,MAX(CASE WHEN Dep_Number = 1 THEN ConCobraReason END) AS DepCobraReason
                    ,MAX(CASE WHEN Dep_Number = 1 THEN ConDateOfCobraEvent END) AS DepDateOfCobraEvent
                    ,MAX(CASE WHEN Dep_Number = 2 THEN ConNameLast END) AS DepLastName2
                    ,MAX(CASE WHEN Dep_Number = 2 THEN ConNameFirst END) AS DepFirstName2
                    ,MAX(CASE WHEN Dep_Number = 2 THEN ConRelationship END) AS DepRelationship2
                    ,MAX(CASE WHEN Dep_Number = 2 THEN '"' + LEFT(ConSSN, 3) + '-' + RIGHT(LEFT(REPLACE(ConSSN, ' ', ''), 5), 2) + '-' + RIGHT(REPLACE(ConSSN, ' ', ''),4) + '"' END) AS DepSSN2
--                    ,MAX(CASE WHEN Dep_Number = 2 THEN ConSSN END) AS DepSSN2
                    ,MAX(CASE WHEN Dep_Number = 2 THEN ConGender END) AS DepGender2
                    ,MAX(CASE WHEN Dep_Number = 2 THEN ConDateOfBirth END) AS DepDateOfBirth2
                    ,MAX(CASE WHEN Dep_Number = 2 THEN ConSystemId END) AS DepSystemId2
                    ,MAX(CASE WHEN Dep_Number = 3 THEN ConNameLast END) AS DepLastName3
                    ,MAX(CASE WHEN Dep_Number = 3 THEN ConNameFirst END) AS DepFirstName3
                    ,MAX(CASE WHEN Dep_Number = 3 THEN ConRelationship END) AS DepRelationship3
                    ,MAX(CASE WHEN Dep_Number = 3 THEN '"' + LEFT(ConSSN, 3) + '-' + RIGHT(LEFT(REPLACE(ConSSN, ' ', ''), 5), 2) + '-' + RIGHT(REPLACE(ConSSN, ' ', ''),4) + '"' END) AS DepSSN3
--                    ,MAX(CASE WHEN Dep_Number = 3 THEN ConSSN END) AS DepSSN3
                    ,MAX(CASE WHEN Dep_Number = 3 THEN ConGender END) AS DepGender3
                    ,MAX(CASE WHEN Dep_Number = 3 THEN ConDateOfBirth END) AS DepDateOfBirth3
                    ,MAX(CASE WHEN Dep_Number = 3 THEN ConSystemId END) AS DepSystemId3
                    ,MAX(CASE WHEN Dep_Number = 4 THEN ConNameLast END) AS DepLastName4
                    ,MAX(CASE WHEN Dep_Number = 4 THEN ConNameFirst END) AS DepFirstName4
                    ,MAX(CASE WHEN Dep_Number = 4 THEN ConRelationship END) AS DepRelationship4
                    ,MAX(CASE WHEN Dep_Number = 4 THEN '"' + LEFT(ConSSN, 3) + '-' + RIGHT(LEFT(REPLACE(ConSSN, ' ', ''), 5), 2) + '-' + RIGHT(REPLACE(ConSSN, ' ', ''),4) + '"' END) AS DepSSN4
--                    ,MAX(CASE WHEN Dep_Number = 4 THEN ConSSN END) AS DepSSN4
                    ,MAX(CASE WHEN Dep_Number = 4 THEN ConGender END) AS DepGender4
                    ,MAX(CASE WHEN Dep_Number = 4 THEN ConDateOfBirth END) AS DepDateOfBirth4
                    ,MAX(CASE WHEN Dep_Number = 4 THEN ConSystemId END) AS DepSystemId4
                    ,MAX(CASE WHEN Dep_Number = 5 THEN ConNameLast END) AS DepLastName5
                    ,MAX(CASE WHEN Dep_Number = 5 THEN ConNameFirst END) AS DepFirstName5
                    ,MAX(CASE WHEN Dep_Number = 5 THEN ConRelationship END) AS DepRelationship5
                    ,MAX(CASE WHEN Dep_Number = 5 THEN '"' + LEFT(ConSSN, 3) + '-' + RIGHT(LEFT(REPLACE(ConSSN, ' ', ''), 5), 2) + '-' + RIGHT(REPLACE(ConSSN, ' ', ''),4) + '"' END) AS DepSSN5
--                    ,MAX(CASE WHEN Dep_Number = 5 THEN ConSSN END) AS DepSSN5
                    ,MAX(CASE WHEN Dep_Number = 5 THEN ConGender END) AS DepGender5
                    ,MAX(CASE WHEN Dep_Number = 5 THEN ConDateOfBirth END) AS DepDateOfBirth5
                    ,MAX(CASE WHEN Dep_Number = 5 THEN ConSystemId END) AS DepSystemId5
                    ,MAX(CASE WHEN Dep_Number = 6 THEN ConNameLast END) AS DepLastName6
                    ,MAX(CASE WHEN Dep_Number = 6 THEN ConNameFirst END) AS DepFirstName6
                    ,MAX(CASE WHEN Dep_Number = 6 THEN ConRelationship END) AS DepRelationship6
                    ,MAX(CASE WHEN Dep_Number = 6 THEN '"' + LEFT(ConSSN, 3) + '-' + RIGHT(LEFT(REPLACE(ConSSN, ' ', ''), 5), 2) + '-' + RIGHT(REPLACE(ConSSN, ' ', ''),4) + '"' END) AS DepSSN6
--                    ,MAX(CASE WHEN Dep_Number = 6 THEN ConSSN END) AS DepSSN6
                    ,MAX(CASE WHEN Dep_Number = 6 THEN ConGender END) AS DepGender6
                    ,MAX(CASE WHEN Dep_Number = 6 THEN ConDateOfBirth END) AS DepDateOfBirth6
                    ,MAX(CASE WHEN Dep_Number = 6 THEN ConSystemId END) AS DepSystemId6
                    ,MAX(CASE WHEN Dep_Number = 7 THEN ConNameLast END) AS DepLastName7
                    ,MAX(CASE WHEN Dep_Number = 7 THEN ConNameFirst END) AS DepFirstName7
                    ,MAX(CASE WHEN Dep_Number = 7 THEN ConRelationship END) AS DepRelationship7
                    ,MAX(CASE WHEN Dep_Number = 7 THEN '"' + LEFT(ConSSN, 3) + '-' + RIGHT(LEFT(REPLACE(ConSSN, ' ', ''), 5), 2) + '-' + RIGHT(REPLACE(ConSSN, ' ', ''),4) + '"' END) AS DepSSN7
--                    ,MAX(CASE WHEN Dep_Number = 7 THEN ConSSN END) AS DepSSN7
                    ,MAX(CASE WHEN Dep_Number = 7 THEN ConGender END) AS DepGender7
                    ,MAX(CASE WHEN Dep_Number = 7 THEN ConDateOfBirth END) AS DepDateOfBirth7
                    ,MAX(CASE WHEN Dep_Number = 7 THEN ConSystemId END) AS DepSystemId7
                    ,MAX(CASE WHEN Dep_Number = 8 THEN ConNameLast END) AS DepLastName8
                    ,MAX(CASE WHEN Dep_Number = 8 THEN ConNameFirst END) AS DepFirstName8
                    ,MAX(CASE WHEN Dep_Number = 8 THEN ConRelationship END) AS DepRelationship8
                    ,MAX(CASE WHEN Dep_Number = 8 THEN '"' + LEFT(ConSSN, 3) + '-' + RIGHT(LEFT(REPLACE(ConSSN, ' ', ''), 5), 2) + '-' + RIGHT(REPLACE(ConSSN, ' ', ''),4) + '"' END) AS DepSSN8
--                    ,MAX(CASE WHEN Dep_Number = 8 THEN ConSSN END) AS DepSSN8
                    ,MAX(CASE WHEN Dep_Number = 8 THEN ConGender END) AS DepGender8
                    ,MAX(CASE WHEN Dep_Number = 8 THEN ConDateOfBirth END) AS DepDateOfBirth8
                    ,MAX(CASE WHEN Dep_Number = 8 THEN ConSystemId END) AS DepSystemId8
                    ,MAX(CASE WHEN Dep_Number = 9 THEN ConNameLast END) AS DepLastName9
                    ,MAX(CASE WHEN Dep_Number = 9 THEN ConNameFirst END) AS DepFirstName9
                    ,MAX(CASE WHEN Dep_Number = 9 THEN ConRelationship END) AS DepRelationship9
                    ,MAX(CASE WHEN Dep_Number = 9 THEN '"' + LEFT(ConSSN, 3) + '-' + RIGHT(LEFT(REPLACE(ConSSN, ' ', ''), 5), 2) + '-' + RIGHT(REPLACE(ConSSN, ' ', ''),4) + '"' END) AS DepSSN9
--                    ,MAX(CASE WHEN Dep_Number = 9 THEN ConSSN END) AS DepSSN9
                    ,MAX(CASE WHEN Dep_Number = 9 THEN ConGender END) AS DepGender9
                    ,MAX(CASE WHEN Dep_Number = 9 THEN ConDateOfBirth END) AS DepDateOfBirth9
                    ,MAX(CASE WHEN Dep_Number = 9 THEN ConSystemId END) AS DepSystemId9
                    ,MAX(CASE WHEN Dep_Number = 10 THEN ConNameLast END) AS DepLastName10
                    ,MAX(CASE WHEN Dep_Number = 10 THEN ConNameFirst END) AS DepFirstName10
                    ,MAX(CASE WHEN Dep_Number = 10 THEN ConRelationship END) AS DepRelationship10
                    ,MAX(CASE WHEN Dep_Number = 10 THEN '"' + LEFT(ConSSN, 3) + '-' + RIGHT(LEFT(REPLACE(ConSSN, ' ', ''), 5), 2) + '-' + RIGHT(REPLACE(ConSSN, ' ', ''),4) + '"' END) AS DepSSN10
--                    ,MAX(CASE WHEN Dep_Number = 10 THEN ConSSN END) AS DepSSN10
                    ,MAX(CASE WHEN Dep_Number = 10 THEN ConGender END) AS DepGender10
                    ,MAX(CASE WHEN Dep_Number = 10 THEN ConDateOfBirth END) AS DepDateOfBirth10
                    ,MAX(CASE WHEN Dep_Number = 10 THEN ConSystemId END) AS DepSystemId10
                    ,MAX(CASE WHEN Dep_Number = 11 THEN ConNameLast END) AS DepLastName11
                    ,MAX(CASE WHEN Dep_Number = 11 THEN ConNameFirst END) AS DepFirstName11
                    ,MAX(CASE WHEN Dep_Number = 11 THEN ConRelationship END) AS DepRelationship11
                    ,MAX(CASE WHEN Dep_Number = 11 THEN '"' + LEFT(ConSSN, 3) + '-' + RIGHT(LEFT(REPLACE(ConSSN, ' ', ''), 5), 2) + '-' + RIGHT(REPLACE(ConSSN, ' ', ''),4) + '"' END) AS DepSSN11
--                    ,MAX(CASE WHEN Dep_Number = 11 THEN ConSSN END) AS DepSSN11
                    ,MAX(CASE WHEN Dep_Number = 11 THEN ConGender END) AS DepGender11
                    ,MAX(CASE WHEN Dep_Number = 11 THEN ConDateOfBirth END) AS DepDateOfBirth11
                    ,MAX(CASE WHEN Dep_Number = 11 THEN ConSystemId END) AS DepSystemId11
                FROM ( 
                SELECT ConEEID, ConNameLast, ConNameFirst, ConNameMiddle, ConSSN, /*CASE WHEN*/ ConRelationship /*IN ('SPS', 'DPC') THEN 'Spouse' ELSE 'Child' END*/ AS ConRelationship, ConGender, ConDateOfBirth, ConSystemId, ConCobraReason, ConDateOfCobraEvent, 
                        ROW_NUMBER() OVER (PARTITION BY ConEEID ORDER BY CASE WHEN ConCobraReason IN ('DLS', 'NLED', 'LEVNT3') THEN 1 ELSE 2 END) AS Dep_Number
                        FROM (
                            SELECT DISTINCT ConEEID, ConNameLast, ConNameFirst, ConNameMiddle, ConSSN, CASE WHEN ConRelationship IN ('SPS', 'DPC') THEN 'Spouse' ELSE 'Child' END AS ConRelationship, ConGender, ConDateOfBirth, ConSystemId, ConCobraReason, ConDateOfCobraEvent
                            FROM dbo.Contacts WITH (NOLOCK)
                                JOIN dbo.U_dsi_BDM_EOPTCBRAQ2 WITH (NOLOCK)
                                    ON ConEEID = BdmEEID
                                    AND ConSystemID = BdmDepRecId
                            WHERE ConRelationship IN ('SPS', 'DPC', 'CHL', 'DCH', 'DPC', 'STC')
                        ) AS INNER_Contacts
                        ) AS Flattened_Contacts
                        GROUP By ConEEID) AS H
            ON ConEEID = xEEID
    LEFT JOIN (
                SELECT ConEEID AS Spouse_EEID
                    ,ConNameLast AS Spouse_NameLast
                    ,ConNameFirst AS Spouse_NameFirst
                    ,ConNameMiddle AS Spouse_NameMiddle
                    ,ConDateOfBirth AS Spouse_DateOfBirth
                    ,ConSSN AS Spouse_SSN
                    ,ConGender AS Spouse_Gender 
                    ,ConCobraStatusDate AS Spouse_CobraStatusDate
                    ,ConCOBRAReason AS Spouse_CobraReason
                    ,ConDateOfCOBRAEvent AS Spouse_DateOfCobraEvent
                    ,ConSystemID AS Spouse_SystemID
                FROM dbo.Contacts WITH (NOLOCK)
                WHERE ConRelationship IN ('SPS', 'DPC')
                    AND ConSystemID IN (SELECT DISTINCT BdmDepRecId FROM dbo.U_dsi_BDM_EOPTCBRAQ2 WITH (NOLOCK))
                ) AS A
        ON Spouse_EEID = xEEID
    JOIN (
            SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent 
            FROM (
                    SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent, ROW_NUMBER() OVER (PARTITION by EdhEEID, EdhCOID ORDER BY EdhEffDate desc) AS RN
                    FROM dbo.EmpHDed a WITH (NOLOCK)
                    JOIN dbo.BenChRsn WITH (NOLOCK)
                        ON EdhChangeReason = BchCode
                    WHERE EdhDedCode IN ('DEN','FSA','MHSA','MHSA2','GLIFE','GLBD','GLEXC','GLMAX','LIFEE','LIFES','LIFEC','MPPO','VIS','MINT') 
                        --AND edhChangeReason IN ('200','BAP','D','DLS','M','NLEE','NLEDR','TOE','LEVNT1','LEVNT2','LEVNT3','LEVNT4','LEVNT5','LWOB')
                        AND edhChangeReason IN ('200','BAP','D','DLS','M','NLEE','NLEDR','TOE','LEVNT1','LEVNT2','LEVNT3','LEVNT4','LEVNT5','LWOB', 'NLED')
                ) AS T 
            WHERE RN = 1) AS X
        ON EdhEEID = xEEID
        AND EdhCOID = xCOID
    WHERE BchIsCOBRAQualifiedEvent = 'Y' --AND NOT (EecEmplStatus = 'A' AND EecEmplStatusStartDate > EdhEffDate)    
    ;


    DELETE dbo.U_EOPTCBRAQ2_drvTbl WHERE drvQualifyingEvent IS NULL;


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
ALTER VIEW dbo.dsi_vwEOPTCBRAQ2_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EOPTCBRAQ2_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EOPTCBRAQ2%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202006011'
       ,expStartPerControl     = '202006011'
       ,expLastEndPerControl   = '202007309'
       ,expEndPerControl       = '202007309'
WHERE expFormatCode = 'EOPTCBRAQ2';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEOPTCBRAQ2_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EOPTCBRAQ2_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort, SubSort2, SubSort3