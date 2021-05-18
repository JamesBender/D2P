SET NOCOUNT ON;
IF OBJECT_ID('U_EBAPCQBEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EBAPCQBEXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EBAPCQBEXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EBAPCQBEXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEBAPCQBEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEBAPCQBEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EBAPCQBEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EBAPCQBEXP];
GO
IF OBJECT_ID('U_EBAPCQBEXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EBAPCQBEXP_PEarHist];
GO
IF OBJECT_ID('U_EBAPCQBEXP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EBAPCQBEXP_PDedHist];
GO
IF OBJECT_ID('U_EBAPCQBEXP_File') IS NOT NULL DROP TABLE [dbo].[U_EBAPCQBEXP_File];
GO
IF OBJECT_ID('U_EBAPCQBEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EBAPCQBEXP_EEList];
GO
IF OBJECT_ID('U_EBAPCQBEXP_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL') IS NOT NULL DROP TABLE [dbo].[U_EBAPCQBEXP_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL];
GO
IF OBJECT_ID('U_EBAPCQBEXP_drvTbl_QBPLANINITIAL') IS NOT NULL DROP TABLE [dbo].[U_EBAPCQBEXP_drvTbl_QBPLANINITIAL];
GO
IF OBJECT_ID('U_EBAPCQBEXP_drvTbl_QBEVENT_WORKING') IS NOT NULL DROP TABLE [dbo].[U_EBAPCQBEXP_drvTbl_QBEVENT_WORKING];
GO
IF OBJECT_ID('U_EBAPCQBEXP_drvTbl_QBEVENT') IS NOT NULL DROP TABLE [dbo].[U_EBAPCQBEXP_drvTbl_QBEVENT];
GO
IF OBJECT_ID('U_EBAPCQBEXP_drvTbl_QBDEPENDENTPLANINITIAL') IS NOT NULL DROP TABLE [dbo].[U_EBAPCQBEXP_drvTbl_QBDEPENDENTPLANINITIAL];
GO
IF OBJECT_ID('U_EBAPCQBEXP_drvTbl_QBDEPENDENT') IS NOT NULL DROP TABLE [dbo].[U_EBAPCQBEXP_drvTbl_QBDEPENDENT];
GO
IF OBJECT_ID('U_EBAPCQBEXP_drvTbl_QB') IS NOT NULL DROP TABLE [dbo].[U_EBAPCQBEXP_drvTbl_QB];
GO
IF OBJECT_ID('U_EBAPCQBEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EBAPCQBEXP_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EBAPCQBEXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EBAPCQBEXP];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EBAPCQBEXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EBAPCQBEXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EBAPCQBEXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EBAPCQBEXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EBAPCQBEXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EBAPCQBEXP','Basic Pacific QB File Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','EBAPCQBEXPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EBAPCQBEXP' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[VERSION]"','1','(''DA''=''T,'')','EBAPCQBEXPZ0','50','H','01','1',NULL,'Record Header',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"1.1"','2','(''DA''=''T'')','EBAPCQBEXPZ0','50','H','01','2',NULL,'Version Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QB]"','1','(''DA''=''T,'')','EBAPCQBEXPZ0','50','D','10','1',NULL,'Record Header',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"T.Y. Lin International"','2','(''DA''=''T,'')','EBAPCQBEXPZ0','50','D','10','2',NULL,'ClientName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"T.Y. Lin International"','3','(''DA''=''T,'')','EBAPCQBEXPZ0','50','D','10','3',NULL,'ClientDivisionName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','4','(''DA''=''T,'')','EBAPCQBEXPZ0','50','D','10','4',NULL,'Salutation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','5','(''UA''=''T,'')','EBAPCQBEXPZ0','50','D','10','5',NULL,'FirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','6','(''UA''=''T,'')','EBAPCQBEXPZ0','50','D','10','6',NULL,'MiddleInitial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','7','(''UA''=''T,'')','EBAPCQBEXPZ0','50','D','10','7',NULL,'LastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','8','(''UA''=''T,'')','EBAPCQBEXPZ0','50','D','10','8',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''DA''=''T,'')','EBAPCQBEXPZ0','50','D','10','9',NULL,'IndividualID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''DA''=''T,'')','EBAPCQBEXPZ0','50','D','10','10',NULL,'Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','11','(''DA''=''T,'')','EBAPCQBEXPZ0','50','D','10','11',NULL,'Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','12','(''DA''=''T,'')','EBAPCQBEXPZ0','50','D','10','12',NULL,'Phone2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','13','(''UA''=''T,'')','EBAPCQBEXPZ0','50','D','10','13',NULL,'Address1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','14','(''UA''=''T,'')','EBAPCQBEXPZ0','50','D','10','14',NULL,'Address2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','15','(''UA''=''T,'')','EBAPCQBEXPZ0','50','D','10','15',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','16','(''UA''=''T,'')','EBAPCQBEXPZ0','50','D','10','16',NULL,'StateOrProvince',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','17','(''UA''=''T,'')','EBAPCQBEXPZ0','50','D','10','17',NULL,'PostalCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''DA''=''T,'')','EBAPCQBEXPZ0','50','D','10','18',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TRUE"','19','(''DA''=''T,'')','EBAPCQBEXPZ0','50','D','10','19',NULL,'PremiumAddressSameAsPrimary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','20','(''DA''=''T,'')','EBAPCQBEXPZ0','50','D','10','20',NULL,'PremiumAddress1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','21','(''DA''=''T,'')','EBAPCQBEXPZ0','50','D','10','21',NULL,'PremiumAddress2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','22','(''DA''=''T,'')','EBAPCQBEXPZ0','50','D','10','22',NULL,'PremiumCity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','23','(''DA''=''T,'')','EBAPCQBEXPZ0','50','D','10','23',NULL,'PremiumStateOrProvince',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','24','(''DA''=''T,'')','EBAPCQBEXPZ0','50','D','10','24',NULL,'PremiumPostalCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','25','(''DA''=''T,'')','EBAPCQBEXPZ0','50','D','10','25',NULL,'PremiumCountry',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSex"','26','(''UA''=''T,'')','EBAPCQBEXPZ0','50','D','10','26',NULL,'Sex',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','27','(''UD101''=''T,'')','EBAPCQBEXPZ0','50','D','10','27',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"UNKNOWN"','28','(''DA''=''T,'')','EBAPCQBEXPZ0','50','D','10','28',NULL,'TobaccoUse',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"UNKNOWN"','29','(''DA''=''T,'')','EBAPCQBEXPZ0','50','D','10','29',NULL,'EmployeeType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"UNKNOWN"','30','(''DA''=''T,'')','EBAPCQBEXPZ0','50','D','10','30',NULL,'EmployeePayrollType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','31','(''DA''=''T,'')','EBAPCQBEXPZ0','50','D','10','31',NULL,'YearsOfService',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"COUPONBOOK"','32','(''DA''=''T,'')','EBAPCQBEXPZ0','50','D','10','32',NULL,'PremiumCouponType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FALSE"','33','(''DA''=''T,'')','EBAPCQBEXPZ0','50','D','10','33',NULL,'UsesHCTC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TRUE"','34','(''DA''=''T,'')','EBAPCQBEXPZ0','50','D','10','34',NULL,'Active',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FALSE"','35','(''DA''=''T,'')','EBAPCQBEXPZ0','50','D','10','35',NULL,'AllowMemberSSO',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','36','(''DA''=''T,'')','EBAPCQBEXPZ0','50','D','10','36',NULL,'BenefitGroup',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','37','(''DA''=''T,'')','EBAPCQBEXPZ0','50','D','10','37',NULL,'AccountStructure',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','38','(''DA''=''T'')','EBAPCQBEXPZ0','50','D','10','38',NULL,'ClientSpecificData',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBEVENT]"','1','(''DA''=''T,'')','EBAPCQBEXPZ0','50','D','20','1',NULL,'Record Header',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEventType"','2','(''UA''=''T,'')','EBAPCQBEXPZ0','50','D','20','2',NULL,'EventType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEventDate"','3','(''UD101''=''T,'')','EBAPCQBEXPZ0','50','D','20','3',NULL,'EventDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrollmentDate"','4','(''UD101''=''T,'')','EBAPCQBEXPZ0','50','D','20','4',NULL,'EnrollmentDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeSSN"','5','(''UA''=''T,'')','EBAPCQBEXPZ0','50','D','20','5',NULL,'EmployeeSSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeName"','6','(''UA''=''T,'')','EBAPCQBEXPZ0','50','D','20','6',NULL,'EmployeeName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','7','(''DA''=''T'')','EBAPCQBEXPZ0','50','D','20','7',NULL,'SecondEventOrgiinal IFDOC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBPLANINITIAL]"','1','(''DA''=''T,'')','EBAPCQBEXPZ0','50','D','30','1',NULL,'Record Header',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanName"','2','(''UA''=''T,'')','EBAPCQBEXPZ0','50','D','30','2',NULL,'PlanName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageLevel"','3','(''UA''=''T,'')','EBAPCQBEXPZ0','50','D','30','3',NULL,'CoverageLevel',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','4','(''DA''=''T'')','EBAPCQBEXPZ0','50','D','30','4',NULL,'NumberOfUnits',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBDEPENDENT]"','1','(''DA''=''T,'')','EBAPCQBEXPZ0','50','D','40','1',NULL,'Record Header',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','2','(''UA''=''T,'')','EBAPCQBEXPZ0','50','D','40','2',NULL,'SSN ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelationship"','3','(''UA''=''T,'')','EBAPCQBEXPZ0','50','D','40','3',NULL,'Relationship ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','4','(''DA''=''T,'')','EBAPCQBEXPZ0','50','D','40','4',NULL,'Salutation ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','5','(''UA''=''T,'')','EBAPCQBEXPZ0','50','D','40','5',NULL,'FirstName ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','6','(''UA''=''T,'')','EBAPCQBEXPZ0','50','D','40','6',NULL,'MiddleInitial ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','7','(''UA''=''T,'')','EBAPCQBEXPZ0','50','D','40','7',NULL,'LastName ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''DA''=''T,'')','EBAPCQBEXPZ0','50','D','40','8',NULL,'Email ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''DA''=''T,'')','EBAPCQBEXPZ0','50','D','40','9',NULL,'Phone ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''DA''=''T,'')','EBAPCQBEXPZ0','50','D','40','10',NULL,'Phone2 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressSameAsQB"','11','(''UA''=''T,'')','EBAPCQBEXPZ0','50','D','40','11',NULL,'AddressSameAsQB ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','12','(''UA''=''T,'')','EBAPCQBEXPZ0','50','D','40','12',NULL,'Address1 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','13','(''UA''=''T,'')','EBAPCQBEXPZ0','50','D','40','13',NULL,'Address2 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','14','(''UA''=''T,'')','EBAPCQBEXPZ0','50','D','40','14',NULL,'City ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','15','(''UA''=''T,'')','EBAPCQBEXPZ0','50','D','40','15',NULL,'StateOrProvince ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','16','(''UA''=''T,'')','EBAPCQBEXPZ0','50','D','40','16',NULL,'PostalCode ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','17','(''DA''=''T,'')','EBAPCQBEXPZ0','50','D','40','17',NULL,'Country ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''DA''=''T,'')','EBAPCQBEXPZ0','50','D','40','18',NULL,'EnrollmentDate ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSex"','19','(''UA''=''T,'')','EBAPCQBEXPZ0','50','D','40','19',NULL,'Sex ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','20','(''UD101''=''T,'')','EBAPCQBEXPZ0','50','D','40','20',NULL,'DOB ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"False"','21','(''DA''=''T'')','EBAPCQBEXPZ0','50','D','40','21',NULL,'IsQMCSO ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBDEPENDENTPLANINITIAL] "','1','(''DA''=''T,'')','EBAPCQBEXPZ0','50','D','50','1',NULL,'Record Header',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanName"','2','(''UA''=''T'')','EBAPCQBEXPZ0','50','D','50','2',NULL,'PlanName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBPLANMEMBERSPECIFICRATEINITIAL]"','1','(''DA''=''T,'')','EBAPCQBEXPZ0','50','D','60','1',NULL,'Record Header',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanName"','2','(''UA''=''T,'')','EBAPCQBEXPZ0','50','D','60','2',NULL,'PlanName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRate"','3','(''UA''=''T'')','EBAPCQBEXPZ0','50','D','60','3',NULL,'Rate',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EBAPCQBEXP_20210510.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','202104139','EMPEXPORT','OEACTIVE','Apr 13 2021  1:52PM','EBAPCQBEXP',NULL,NULL,NULL,'202104139','Apr 13 2021 10:23AM','Apr 13 2021 10:23AM','202101011','152','','','202101011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Passive Open Enrollment Export','202104139','EMPEXPORT','OEPASSIVE','Apr 13 2021  1:53PM','EBAPCQBEXP',NULL,NULL,NULL,'202104139','Apr 13 2021 10:23AM','Apr 13 2021 10:23AM','202101011','152','','','202101011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Basic Pacific QB File Export','202104139','EMPEXPORT','ONDEM_XOE','Apr 13 2021  1:53PM','EBAPCQBEXP',NULL,NULL,NULL,'202104139','Apr 13 2021 10:23AM','Apr 13 2021 10:23AM','202101011','159','','','202101011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Basic Pacific QB File Ex-Sched','202104139','EMPEXPORT','SCH_EBAPCQ','Apr 13 2021  1:53PM','EBAPCQBEXP',NULL,NULL,NULL,'202104139','Apr 13 2021 10:23AM','Apr 13 2021 10:23AM','202101011','159','','','202101011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Basic Pacific QB File Ex-Test','202104299','EMPEXPORT','TEST_XOE','May  7 2021 10:25AM','EBAPCQBEXP',NULL,NULL,NULL,'202104299','Apr 29 2021 12:00AM','Dec 30 1899 12:00AM','202103011','62','','','202103011',dbo.fn_GetTimedKey(),NULL,'us3cPeTYL1001',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBAPCQBEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBAPCQBEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBAPCQBEXP','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBAPCQBEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBAPCQBEXP','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EBAPCQBEXP' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EBAPCQBEXP' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EBAPCQBEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EBAPCQBEXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBAPCQBEXP','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBAPCQBEXP','D10','dbo.U_EBAPCQBEXP_drvTbl_QB',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBAPCQBEXP','D20','dbo.U_EBAPCQBEXP_drvTbl_QBEVENT',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBAPCQBEXP','D30','dbo.U_EBAPCQBEXP_drvTbl_QBPLANINITIAL',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBAPCQBEXP','D40','dbo.U_EBAPCQBEXP_drvTbl_QBDEPENDENT',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBAPCQBEXP','D50','dbo.U_EBAPCQBEXP_drvTbl_QBDEPENDENTPLANINITIAL',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBAPCQBEXP','D60','dbo.U_EBAPCQBEXP_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL',NULL);
IF OBJECT_ID('U_dsi_BDM_EBAPCQBEXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EBAPCQBEXP] (
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
IF OBJECT_ID('U_EBAPCQBEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EBAPCQBEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EBAPCQBEXP_drvTbl_QB') IS NULL
CREATE TABLE [dbo].[U_EBAPCQBEXP_drvTbl_QB] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(14) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvSSN] char(11) NULL,
    [drvAddressLine1] varchar(257) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvSex] varchar(1) NOT NULL,
    [drvDateOfBirth] datetime NULL
);
IF OBJECT_ID('U_EBAPCQBEXP_drvTbl_QBDEPENDENT') IS NULL
CREATE TABLE [dbo].[U_EBAPCQBEXP_drvTbl_QBDEPENDENT] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(27) NULL,
    [drvSSN] char(11) NULL,
    [drvRelationship] varchar(15) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvAddressSameAsQB] varchar(4) NOT NULL,
    [drvAddressLine1] varchar(1) NOT NULL,
    [drvAddressLine2] varchar(1) NOT NULL,
    [drvAddressCity] varchar(1) NOT NULL,
    [drvAddressState] varchar(1) NOT NULL,
    [drvAddressZipCode] varchar(1) NOT NULL,
    [drvSex] char(1) NULL,
    [drvDateOfBirth] datetime NULL
);
IF OBJECT_ID('U_EBAPCQBEXP_drvTbl_QBDEPENDENTPLANINITIAL') IS NULL
CREATE TABLE [dbo].[U_EBAPCQBEXP_drvTbl_QBDEPENDENTPLANINITIAL] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(33) NULL,
    [drvPlanName] varchar(32) NULL
);
IF OBJECT_ID('U_EBAPCQBEXP_drvTbl_QBEVENT') IS NULL
CREATE TABLE [dbo].[U_EBAPCQBEXP_drvTbl_QBEVENT] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(14) NULL,
    [drvEventType] varchar(29) NULL,
    [drvEventDate] datetime NULL,
    [drvEnrollmentDate] datetime NULL,
    [drvEmployeeSSN] char(11) NULL,
    [drvEmployeeName] varchar(201) NULL
);
IF OBJECT_ID('U_EBAPCQBEXP_drvTbl_QBEVENT_WORKING') IS NULL
CREATE TABLE [dbo].[U_EBAPCQBEXP_drvTbl_QBEVENT_WORKING] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(14) NULL,
    [drvEventType] varchar(29) NULL,
    [drvEventDate] datetime NULL,
    [drvEnrollmentDate] datetime NULL,
    [drvEmployeeSSN] char(11) NULL,
    [drvEmployeeName] varchar(201) NULL
);
IF OBJECT_ID('U_EBAPCQBEXP_drvTbl_QBPLANINITIAL') IS NULL
CREATE TABLE [dbo].[U_EBAPCQBEXP_drvTbl_QBPLANINITIAL] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(14) NULL,
    [drvPlanName] varchar(45) NULL,
    [drvCoverageLevel] varchar(11) NULL
);
IF OBJECT_ID('U_EBAPCQBEXP_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL') IS NULL
CREATE TABLE [dbo].[U_EBAPCQBEXP_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(14) NULL,
    [drvPlanName] varchar(45) NULL,
    [drvRate] nvarchar(4000) NULL
);
IF OBJECT_ID('U_EBAPCQBEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EBAPCQBEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EBAPCQBEXP_File') IS NULL
CREATE TABLE [dbo].[U_EBAPCQBEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
IF OBJECT_ID('U_EBAPCQBEXP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EBAPCQBEXP_PDedHist] (
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
IF OBJECT_ID('U_EBAPCQBEXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EBAPCQBEXP_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EBAPCQBEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: TY Lin

Created By: James Bender
Business Analyst: Cheryl Petitti
Create Date: 04/13/2021
Service Request Number: TekP-2021-01-12-0001

Purpose: Basic Pacific QB File Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EBAPCQBEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EBAPCQBEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EBAPCQBEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EBAPCQBEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EBAPCQBEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBAPCQBEXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBAPCQBEXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBAPCQBEXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBAPCQBEXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBAPCQBEXP', 'SCH_EBAPCQ';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EBAPCQBEXP';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EBAPCQBEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EBAPCQBEXP';

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
    DELETE FROM dbo.U_EBAPCQBEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EBAPCQBEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'ANPPO,APPPT,ANHD,AHPT,DEN,DENA,PTDD,DENPA,KPHMO,PTKP,FSA19,LPF19,LPT19,VSPER';

    IF OBJECT_ID('U_EBAPCQBEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EBAPCQBEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EBAPCQBEXP_DedList
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

    -- COBRA parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RunID','QB');

    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','Y'); -- DedIsCobraCovered = 'Y'
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraType','4'); -- 4 Eep/ConCobraReason first, then EdhChangeReason. Include CHGRP for elig. ben groups – 
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraDate','3'); -- EedBenStopDate and DbnBenStopDate, unless Eep/ConDateOfCOBRAEvent exists – 
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraPQBType','1'); -- If no EE or spouse, ALL children are PQB (not just oldest) – 
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraReasonsDepPQB','201,204,210,LEVNT3,LEVNT4'); -- 
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidCobraReasonsEmp','201,204,210,LEVNT3,LEVNT4'); -- Invalidate employee when Cobra Reason is a dependent PQB reason – 
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidTermReasonsEmp','203'); -- Invalidate employee when Cobra Reason is "Death".  
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CountDependents','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS'); -- update to the spouse relationship code
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL,DIS, DPC, STC'); -- update to the child relationship codes
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP'); -- update to the domestic partner relationship code
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard'); -- same for all files

    
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


    ---==========================================
 --   -- Insert into BDM Reason code 201 and 204
 --   --==========================================
    INSERT INTO [dbo].[U_dsi_BDM_EBAPCQBEXP]
           ([BdmRecType]
           ,[BdmCOID]
           ,[BdmEEID]
           ,[BdmDepRecID]
           ,[BdmSystemID]
           ,[BdmRunID]
           ,[BdmDedRowStatus]
           ,[BdmRelationship]
           ,[BdmDateOfBirth]
           ,[BdmDedCode]
           ,[BdmBenOption]
           ,[BdmBenStartDate]
           ,[BdmBenStopDate]
           ,[BdmBenStatusDate]
           ,[BdmDateOFCobraEvent]
           ,[BdmChangeReason]
           ,[BdmCobraReason]
           ,[BdmStartDate]
           ,[BdmStopDate]
           ,[BdmIsPQB]
    )
    SELECT rectype = 'DEP'
        ,EdhCoid
        ,EdhEEID
        ,DbnDepRecID
        ,DbnDepRecID
        ,'QB'
        ,'Data Inserted for 204 Chg reason'
        ,DbnRelationship
        ,DbnDateOfBirth
        ,EdhDedCode
        ,DbnBenOption
        ,EdhBenStartDate
        ,EdhBenStopDate
        ,EdhBenStatusDate
        ,EdhBenStatusDate
        ,'204'
        ,'204'
        ,EdhStartDate
        ,EdhStopDate
        ,CASE WHEN DbnRelationShip = 'SPS' THEN 'Y' ELSE 'N' END
    FROM dbo.emphded WITH (NOLOCK)
        JOIN dbo.U_dsi_BDM_DepDeductions 
            ON dbneeid = edheeid 
            AND dbnformatcode = 'EBAPCQBEXP'
    WHERE edhChangeReason in ('204') 
        AND DbnBenStopDate BETWEEN @StartDate AND @EndDate
        AND dbnValidForExport = 'N'

    INSERT INTO [dbo].[U_dsi_BDM_EBAPCQBEXP]
    (    [BdmRecType]
           ,[BdmCOID]
           ,[BdmEEID]
           ,[BdmDepRecID]
           ,[BdmSystemID]
           ,[BdmRunID]
           ,[BdmDedRowStatus]
           ,[BdmRelationship]
           ,[BdmDateOfBirth]
           ,[BdmDedCode]
           ,[BdmBenOption]
           ,[BdmBenStartDate]
           ,[BdmBenStopDate]
           ,[BdmBenStatusDate]
           ,[BdmDateOFCobraEvent]
           ,[BdmChangeReason]
           ,[BdmCobraReason]
           ,[BdmStartDate]
           ,[BdmStopDate]
           ,[BdmIsPQB]
    )
    Select rectype = 'DEP'
        ,EdhCoid
        ,EdhEEID
        ,DbnDepRecID
        ,DbnDepRecID
        ,'QB'
        ,'Data Inserted for 201 Chg reason'
        ,DbnRelationship
        ,DbnDateOfBirth
        ,EdhDedCode
        ,DbnBenOption
        ,EdhBenStartDate
        ,EdhBenStopDate
        ,EdhBenStatusDate
        ,EdhBenStatusDate
        ,'201'
        ,'201'
        ,EdhStartDate
        ,EdhStopDate
        ,'Y'
    FROM dbo.emphded WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
        ON dbneeid = edheeid 
        AND dbnformatcode = 'EBAPCQBEXP'
    WHERE edhChangeReason IN ('201') 
        and DbnBenstopdate BETWEEN @startdate AND @enddate 
        AND dbnValidForExport = 'N'

    Delete from dbo.U_dsi_BDM_EBAPCQBEXP where bdmdedcode not in (Select dedcode from U_EBAPCQBEXP_DedList)

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EBAPCQBEXP_drvTbl_QB
    ---------------------------------
    IF OBJECT_ID('U_EBAPCQBEXP_drvTbl_QB','U') IS NOT NULL
        DROP TABLE dbo.U_EBAPCQBEXP_drvTbl_QB;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = xEEID + ' 1'
        -- standard fields above and additional driver fields below
        ,drvNameFirst = CASE WHEN BdmCobraReason IN ('LEVNT3','LEVNT4','204','210','201','302') THEN ConNameFirst ELSE EepNameFirst END
        ,drvNameMiddle = CASE WHEN BdmCobraReason IN ('LEVNT3','LEVNT4','204','210','201','302') THEN LEFT(ConNameMiddle,1) ELSE LEFT(EepNameMiddle,1) END
        ,drvNameLast = CASE WHEN BdmCobraReason IN ('LEVNT3','LEVNT4','204','210','201','302') THEN ConNameLast ELSE EepNameLast END
        ,drvSSN = CASE WHEN BdmCobraReason IN ('LEVNT3','LEVNT4','204','210','201','302') THEN ConSSN ELSE EepSSN END
        ,drvAddressLine1 = '"' + CASE WHEN BdmCobraReason IN ('LEVNT3','LEVNT4','204','210','201','302') THEN ConAddressLine1 ELSE EepAddressLine1 END + '"'
        ,drvAddressLine2 = CASE WHEN BdmCobraReason IN ('LEVNT3','LEVNT4','204','210','201','302') THEN ConAddressLine2 ELSE EepAddressLine2 END
        ,drvAddressCity = CASE WHEN BdmCobraReason IN ('LEVNT3','LEVNT4','204','210','201','302') THEN ConAddressCity ELSE EepAddressCity END
        ,drvAddressState = CASE WHEN BdmCobraReason IN ('LEVNT3','LEVNT4','204','210','201','302') THEN ConAddressState ELSE EepAddressState END
        ,drvAddressZipCode = CASE WHEN BdmCobraReason IN ('LEVNT3','LEVNT4','204','210','201','302') THEN ConAddressZipCode ELSE EepAddressZipCode END
        ,drvSex = CASE WHEN BdmCobraReason IN ('LEVNT3','LEVNT4','204','210','201','302') THEN 
                        CASE WHEN ConGender = 'M' THEN 'M' ELSE 'F'END
                    ELSE
                        CASE WHEN EepGender = 'M' THEN 'M' ELSE 'F'END
                    END 
        ,drvDateOfBirth = CASE WHEN BdmCobraReason IN ('LEVNT3','LEVNT4','204','210','201','302') THEN ConDateOfBirth ELSE EepDateOfBirth END
    INTO dbo.U_EBAPCQBEXP_drvTbl_QB
    FROM dbo.U_EBAPCQBEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EBAPCQBEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EBAPCQBEXP_drvTbl_QBEVENT
    ---------------------------------
    IF OBJECT_ID('U_EBAPCQBEXP_drvTbl_QBEVENT_WORKING','U') IS NOT NULL
        DROP TABLE dbo.U_EBAPCQBEXP_drvTbl_QBEVENT_WORKING;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = xEEID + ' 2'
        -- standard fields above and additional driver fields below
        ,drvEventType =    CASE WHEN EecEmplStatus = 'T' AND EecTermReason NOT IN ('202','203') AND EecTermType = 'V' THEN 'TERMINATION'
                            WHEN EecEmplStatus = 'T' AND EecTermReason IN ('203') THEN 'DEATH'
                            WHEN EecEmplStatus = 'T' AND EecTermReason IN ('202') THEN 'RETIREMENT'
                            WHEN EecEmplStatus = 'T' AND EecTermType = 'I' THEN 'INVOLUNTARYTERMINATION'
                            WHEN BchIsCOBRAQualifiedEvent = 'Y' THEN 
                                CASE WHEN EdhChangeReason = '208' THEN 'RETIREMENT'
                                    WHEN EdhChangeReason IN ('204','LEVNT4') THEN 'DIVORCELEGALSEPARATION'
                                    WHEN EdhChangeReason = '205' THEN 'MEDICARE'
                                    WHEN EdhChangeReason IN ('201','302','LEVNT3') THEN 'INELIGIBLEDEPENDENT'
                                    WHEN EdhChangeReason IN ('203','202') THEN 'REDUCTIONINHOURS-STATUSCHANGE'
                                    WHEN EdhChangeReason = '206' THEN 'REDUCTIONINHOURS-ENDOFLEAVE'
                                END
                            ELSE 'TERMINATION'
                        END
        ,drvEventDate =    CASE WHEN EecEmplStatus = 'T' AND EecTermReason NOT IN ('202','203') THEN EecDateOfTermination
                            WHEN EecEmplStatus = 'T' AND EecTermReason IN ('202','203') THEN 
                                --CASE WHEN ISNULL(BdmDateOfCOBRAEvent, '') = '' THEN EecDateOfTermination ELSE BdmDateOfCOBRAEvent END
                                CASE WHEN ISNULL(BdmDateOfCOBRAEvent, '') <> '' AND BdmDateOfCobraEvent > EecDateOfTermination THEN BdmDateOfCobraEvent ELSE EecDateOfTermination END -- ELSE BdmDateOfCOBRAEvent END
                            WHEN EdhChangeReason IN ('LEVNT3','LEVNT4','204','210','201','302') THEN EdhEffDate
                            ELSE BdmDateOfCOBRAEvent
                        END
        ,drvEnrollmentDate = MostRecentBdmStartDate 
        ,drvEmployeeSSN = EepSSN
        ,drvEmployeeName = EepNameFirst + ' ' + EepNameLast
    INTO dbo.U_EBAPCQBEXP_drvTbl_QBEVENT_WORKING
    FROM dbo.U_EBAPCQBEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EBAPCQBEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID 
    LEFT JOIN (
            SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent 
            FROM (
                    SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent, ROW_NUMBER() OVER (PARTITION by EdhEEID, EdhCOID ORDER BY EdhEffDate desc) AS RN
                    FROM dbo.EmpHDed a WITH (NOLOCK)
                    JOIN dbo.BenChRsn WITH (NOLOCK)
                        ON EdhChangeReason = BchCode
                    WHERE EdhDedCode IN ('ANPPO','APPPT','ANHD','AHPT','DEN','DENA','PTDD','DENPA','KPHMO','PTKP','FSA19','LPF19','LPT19','VSPER') 
                        AND edhChangeReason IN ('208','204','LEVNT4','205','201','302','LEVNT3', '203','202','206','200')
                ) AS X
            WHERE RN = 1) AS Edh
        ON EdhEEID = xEEID
        AND EdhCoID = xCOID  
    JOIN (
            SELECT BdmEEID AS MRBdmEEID
                ,BdmCOID AS MRBdmCOID
                ,MAX(BdmBenStartDate) AS MostRecentBdmStartDate 
            FROM dbo.U_dsi_BDM_EBAPCQBEXP WITH (NOLOCK)
            GROUP BY BdmEEID, BdmCOID ) AS MRBdm
        ON MRBdmEEID = xEEID
        AND MRBdmCOID = xCOID
    ;

    -- If an employee has an FSA coverage it will sometimes have a differnt Cobra Events date. 
    -- The client doesn't want an event for FSA UNLESS it's the only coverage type. We determined the 
    -- easiet thing was to write both records with both dates to the QBEvent table if the employee
    -- has different dates, and then only take the latest date, which is what this does.
    IF OBJECT_ID('U_EBAPCQBEXP_drvTbl_QBEVENT','U') IS NOT NULL
        DROP TABLE dbo.U_EBAPCQBEXP_drvTbl_QBEVENT;
    SELECT drvEEID
        ,drvCoID
        ,drvDepRecID
        ,drvSort
        ,drvEventType
        ,MAX(drvEventDate) AS drvEventDate
        ,drvEnrollmentDate
        ,drvEmployeeSSN
        ,drvEmployeeName
    INTO dbo.U_EBAPCQBEXP_drvTbl_QBEVENT
    FROM dbo.U_EBAPCQBEXP_drvTbl_QBEVENT_WORKING
    GROUP BY drvEEID, drvCoID, drvDepRecID, drvSort, drvEventType, drvEnrollmentDate, drvEmployeeSSN, drvEmployeeName;



    ---------------------------------
    -- DETAIL RECORD - U_EBAPCQBEXP_drvTbl_QBPLANINITIAL
    ---------------------------------
    IF OBJECT_ID('U_EBAPCQBEXP_drvTbl_QBPLANINITIAL','U') IS NOT NULL
        DROP TABLE dbo.U_EBAPCQBEXP_drvTbl_QBPLANINITIAL;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = xEEID + ' 3'
        -- standard fields above and additional driver fields below
        ,drvPlanName =    CASE WHEN BdmDedCode IN ('ANPPO','APPPT') THEN 'Anthem Classic PPO 250'
                            WHEN BdmDedCode IN ('ANHD','AHPT') THEN 'Anthem PPO HSA -H 2500/2800/5000'
                            WHEN BdmDedCode IN ('DEN','DENA','PTDD','DENPA') THEN 'Delta Dental PPO'
                            WHEN BdmDedCode IN ('KPHMO','PTKP') AND EecLocation IN ('SFCA','OAKCA','SACCA','SJCA','SRCA') THEN 'Kaiser HMO (NoCal)'
                            WHEN BdmDedCode IN ('KPHMO','PTKP') AND EecLocation IN ('RSCA','SDCA','LAXCA','OCCA','LACA','ONTCA') THEN 'Kaiser HMO (SoCal)'
                            WHEN BdmDedCode IN ('VSPER') THEN 'VSP Vision PPO'
                            WHEN BdmDedCode IN ('FSA19') THEN 'T.Y. Lin International Flexible Benefits Plan'
                            WHEN BdmDedCode IN ('LPF19','LPT19') THEN 'T.Y. Lin International Limited Use FSA'
                        END
        ,drvCoverageLevel =    CASE WHEN BdmDedCode IN ('VSPER','ANPPO','APPPT','ANHD','AHPT','DEN','DENA','PTDD','DENPA','KPHMO','PTKP') THEN
                                CASE WHEN EdhChangeReason NOT IN ('204','LEVNT4','201','LEVNT3','210') THEN
                                    CASE WHEN BdmBenOption = 'EE' OR (BdmBenOption IS NULL AND EdhBenOption = 'EE') THEN 'EE'
                                        WHEN BdmBenOption = 'EEC' OR (BdmBenOption IS NULL AND EdhBenOption = 'EEC') THEN 'EE+CHILDREN'
                                        WHEN BdmBenOption IN ('EEF','EEDPF') OR (BdmBenOption IS NULL AND EdhBenOption IN ('EEF','EEDPF')) THEN 'EE+FAMILY'
                                        WHEN BdmBenOption IN ('EES','EEDP') OR (BdmBenOption IS NULL AND EdhBenOption IN ('EES','EEDP')) THEN 'EE+SPOUSE'
                                    END
                                ELSE
                                    CASE WHEN BdmRelationship = 'SPS' AND (SELECT COUNT(DISTINCT BdmDepRecId) FROM dbo.U_dsi_BDM_EBAPCQBEXP WITH (NOLOCK) WHERE BdmRunId = 'QB' AND BdmEEID = xEEID AND BdmRecType = 'DEP' AND BdmRelationship IN ('CHL','DPC','STC','DCH')) = 1 THEN 'EE+CHILD'
                                        WHEN BdmRelationship = 'SPS' AND (SELECT COUNT(DISTINCT BdmDepRecId) FROM dbo.U_dsi_BDM_EBAPCQBEXP WITH (NOLOCK) WHERE BdmRunId = 'QB' AND BdmEEID = xEEID AND BdmRecType = 'DEP' AND BdmRelationship IN ('CHL','DPC','STC','DCH')) > 1 THEN 'EE+CHILDREN'
                                        WHEN BdmRelationship <> 'SPS' AND (SELECT COUNT(DISTINCT BdmDepRecId) FROM dbo.U_dsi_BDM_EBAPCQBEXP WITH (NOLOCK) WHERE BdmRunId = 'QB' AND BdmEEID = xEEID AND BdmRecType = 'DEP' AND BdmRelationship IN ('CHL','DPC','STC','DCH')) > 1 THEN 'EE+CHILDREN'
                                        ELSE 'EE'
                                    END
                                END
                            WHEN BdmDedCode IN ('FSA19','LPF19','LPT19') THEN 'EE'
                            END
    INTO dbo.U_EBAPCQBEXP_drvTbl_QBPLANINITIAL
    FROM dbo.U_EBAPCQBEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.U_dsi_BDM_EBAPCQBEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID    
    LEFT JOIN (
            SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, EdhBenOption, BchIsCobraQualifiedEvent 
            FROM (
                    SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, EdhBenOption, BchIsCobraQualifiedEvent, ROW_NUMBER() OVER (PARTITION by EdhEEID, EdhCOID ORDER BY EdhEffDate desc) AS RN
                    FROM dbo.EmpHDed a WITH (NOLOCK)
                    JOIN dbo.BenChRsn WITH (NOLOCK)
                        ON EdhChangeReason = BchCode
                    WHERE EdhDedCode IN ('ANPPO','APPPT','ANHD','AHPT','DEN','DENA','PTDD','DENPA','KPHMO','PTKP','FSA19','LPF19','LPT19','VSPER') 
                        AND edhChangeReason IN ('208','204','LEVNT4','205','201','302','LEVNT3', '203','202','206','200')
                ) AS X
            WHERE RN = 1) AS Edh
        ON EdhEEID = xEEID
        AND EdhCoID = xCOID 
    ;

    --DELETE FROM dbo.U_EBAPCQBEXP_drvTbl_QBPLANINITIAL WHERE drvCoverageLevel IS NULL;
    ---------------------------------
    -- DETAIL RECORD - U_EBAPCQBEXP_drvTbl_QBDEPENDENT
    ---------------------------------
    IF OBJECT_ID('U_EBAPCQBEXP_drvTbl_QBDEPENDENT','U') IS NOT NULL
        DROP TABLE dbo.U_EBAPCQBEXP_drvTbl_QBDEPENDENT;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = xEEID + ' 4 ' + ConSystemID
        -- standard fields above and additional driver fields below
        ,drvSSN = ConSSN
        ,drvRelationship =    CASE WHEN ConRelationship = 'SPS' THEN 'SPOUSE'
                                WHEN ConRelationship = 'DP' THEN 'DOMESTICPARTNER'
                                WHEN ConRelationship IN ('CHL','CLN','DHC','STC') THEN 'CHILD'
                            END
        ,drvNameFirst = ConNameFirst
        ,drvNameMiddle = LEFT(ConNameMiddle,1)
        ,drvNameLast = ConNameLast
        ,drvAddressSameAsQB = 'TRUE' -- CASE WHEN ConAddressIsDifferent = 'N' THEN 'FALSE' ELSE 'TRUE' END
        ,drvAddressLine1 = '' -- '"' + CASE WHEN ConAddressIsDifferent = 'N' THEN ConAddressLine1 END + '"'
        ,drvAddressLine2 = '' --CASE WHEN ConAddressIsDifferent = 'N' THEN ConAddressLine2 END
        ,drvAddressCity = '' --CASE WHEN ConAddressIsDifferent = 'N' THEN ConAddressCity END
        ,drvAddressState = '' --CASE WHEN ConAddressIsDifferent = 'N' THEN ConAddressState END
        ,drvAddressZipCode = '' --CASE WHEN ConAddressIsDifferent = 'N' THEN ConAddressZipCode END
        ,drvSex = CASE WHEN ConGender IN ('M','F') THEN ConGender END
        ,drvDateOfBirth = ConDateOfBirth
    INTO dbo.U_EBAPCQBEXP_drvTbl_QBDEPENDENT
    FROM dbo.U_EBAPCQBEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EBAPCQBEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
    LEFT JOIN (
            SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent 
            FROM (
                    SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent, ROW_NUMBER() OVER (PARTITION by EdhEEID, EdhCOID ORDER BY EdhEffDate desc) AS RN
                    FROM dbo.EmpHDed a WITH (NOLOCK)
                    JOIN dbo.BenChRsn WITH (NOLOCK)
                        ON EdhChangeReason = BchCode
                    WHERE EdhDedCode IN ('ANPPO','APPPT','ANHD','AHPT','DEN','DENA','PTDD','DENPA','KPHMO','PTKP','FSA19','LPF19','LPT19','VSPER') 
                        AND edhChangeReason IN ('208','204','LEVNT4','205','201','302','LEVNT3', '203','202','206','200')
                ) AS X
            WHERE RN = 1) AS Edh
        ON EdhEEID = xEEID
        AND EdhCoID = xCOID  
    WHERE EdhChangeReason NOT IN ('201','302','LEVNT3')
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EBAPCQBEXP_drvTbl_QBDEPENDENTPLANINITIAL
    ---------------------------------
    IF OBJECT_ID('U_EBAPCQBEXP_drvTbl_QBDEPENDENTPLANINITIAL','U') IS NOT NULL
        DROP TABLE dbo.U_EBAPCQBEXP_drvTbl_QBDEPENDENTPLANINITIAL;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = xEEID + ' 4 ' + ConSystemID + ' ' + BdmDedcode
        -- standard fields above and additional driver fields below
        ,drvPlanName =    CASE WHEN BdmDedCode IN ('ANPPO','APPPT') THEN 'Anthem Classic PPO 250'
                            WHEN BdmDedCode IN ('ANHD','AHPT') THEN 'Anthem PPO HSA -H 2500/2800/5000'
                            WHEN BdmDedCode IN ('DEN','DENA','PTDD','DENPA') THEN 'Delta Dental PPO'
                            WHEN BdmDedCode IN ('KPHMO','PTKP') AND EecLocation IN ('SFCA','OAKCA','SACCA','SJCA','SRCA') THEN 'Kaiser HMO (NoCal)'
                            WHEN BdmDedCode IN ('KPHMO','PTKP') AND EecLocation IN ('RSCA','SDCA','LAXCA','OCCA','LACA','ONTCA') THEN 'Kaiser HMO (SoCal)'
                            WHEN BdmDedCode IN ('VSPER') THEN 'VSP Vision PPO'
                        END
    INTO dbo.U_EBAPCQBEXP_drvTbl_QBDEPENDENTPLANINITIAL
    FROM dbo.U_EBAPCQBEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.U_dsi_BDM_EBAPCQBEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
    LEFT JOIN (
            SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent 
            FROM (
                    SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent, ROW_NUMBER() OVER (PARTITION by EdhEEID, EdhCOID ORDER BY EdhEffDate desc) AS RN
                    FROM dbo.EmpHDed a WITH (NOLOCK)
                    JOIN dbo.BenChRsn WITH (NOLOCK)
                        ON EdhChangeReason = BchCode
                    WHERE EdhDedCode IN ('ANPPO','APPPT','ANHD','AHPT','DEN','DENA','PTDD','DENPA','KPHMO','PTKP','FSA19','LPF19','LPT19','VSPER') 
                        AND edhChangeReason IN ('208','204','LEVNT4','205','201','302','LEVNT3', '203','202','206','200')
                ) AS X
            WHERE RN = 1) AS Edh
        ON EdhEEID = xEEID
        AND EdhCoID = xCOID 
    WHERE EdhChangeReason NOT IN ('201','302','LEVNT3') -- Do not send for 'INELIGIBLEDEPENDENT'
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EBAPCQBEXP_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL
    ---------------------------------
    IF OBJECT_ID('U_EBAPCQBEXP_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL','U') IS NOT NULL
        DROP TABLE dbo.U_EBAPCQBEXP_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = xEEID + ' 5'
        -- standard fields above and additional driver fields below
        ,drvPlanName =    CASE WHEN BdmDedCode IN ('FSA19') THEN 'T.Y. Lin International Flexible Benefits Plan'
                            WHEN BdmDedCode IN ('LPF19','LPT19') THEN '.Y. Lin International Limited Use FSA'
                        END
        ,drvRate = CASE WHEN BdmDedCode IN ('FSA19','LPF19','LPT19') THEN FORMAT(BdmEEAmt, '#0.00') END
    INTO dbo.U_EBAPCQBEXP_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL
    FROM dbo.U_EBAPCQBEXP_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EBAPCQBEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmDedCode IN ('FSA19','LPF19','LPT19')
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
ALTER VIEW dbo.dsi_vwEBAPCQBEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EBAPCQBEXP_File (NOLOCK)
    ORDER BY InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EBAPCQBEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202101011'
       ,expStartPerControl     = '202101011'
       ,expLastEndPerControl   = '202104139'
       ,expEndPerControl       = '202104139'
WHERE expFormatCode = 'EBAPCQBEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEBAPCQBEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EBAPCQBEXP_File (NOLOCK)
    ORDER BY InitialSort, SubSort;