SET NOCOUNT ON;
IF OBJECT_ID('U_EDSICCBEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EDSICCBEXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EDSICCBEXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EDSICCBEXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEDSICCBEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEDSICCBEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EDSICCBEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EDSICCBEXP];
GO
IF OBJECT_ID('U_EDSICCBEXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EDSICCBEXP_PEarHist];
GO
IF OBJECT_ID('U_EDSICCBEXP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EDSICCBEXP_PDedHist];
GO
IF OBJECT_ID('U_EDSICCBEXP_File') IS NOT NULL DROP TABLE [dbo].[U_EDSICCBEXP_File];
GO
IF OBJECT_ID('U_EDSICCBEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EDSICCBEXP_EEList];
GO
IF OBJECT_ID('U_EDSICCBEXP_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL') IS NOT NULL DROP TABLE [dbo].[U_EDSICCBEXP_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL];
GO
IF OBJECT_ID('U_EDSICCBEXP_drvTbl_QBPLANINITIAL') IS NOT NULL DROP TABLE [dbo].[U_EDSICCBEXP_drvTbl_QBPLANINITIAL];
GO
IF OBJECT_ID('U_EDSICCBEXP_drvTbl_QBEVENT') IS NOT NULL DROP TABLE [dbo].[U_EDSICCBEXP_drvTbl_QBEVENT];
GO
IF OBJECT_ID('U_EDSICCBEXP_drvTbl_QBDEPENDENTPLANINITIAL') IS NOT NULL DROP TABLE [dbo].[U_EDSICCBEXP_drvTbl_QBDEPENDENTPLANINITIAL];
GO
IF OBJECT_ID('U_EDSICCBEXP_drvTbl_QBDEPENDENT') IS NOT NULL DROP TABLE [dbo].[U_EDSICCBEXP_drvTbl_QBDEPENDENT];
GO
IF OBJECT_ID('U_EDSICCBEXP_drvTbl_QB') IS NOT NULL DROP TABLE [dbo].[U_EDSICCBEXP_drvTbl_QB];
GO
IF OBJECT_ID('U_EDSICCBEXP_drvTbl_NPM') IS NOT NULL DROP TABLE [dbo].[U_EDSICCBEXP_drvTbl_NPM];
GO
IF OBJECT_ID('U_EDSICCBEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EDSICCBEXP_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EDSICCBEXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EDSICCBEXP];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EDSICCBEXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EDSICCBEXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EDSICCBEXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EDSICCBEXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EDSICCBEXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EDSICCBEXP','Discover Cobra and NPM Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','EDSICCBEXPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EDSICCBEXP' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[VERSION]"','1','(''DA''=''T,'')','EDSICCBEXPZ0','50','H','01','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"1.1"','2','(''DA''=''T'')','EDSICCBEXPZ0','50','H','01','2',NULL,'Version',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QB]"','1','(''DA''=''T,'')','EDSICCBEXPZ0','50','D','10','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Newport Group Inc 38989"','2','(''DA''=''T,'')','EDSICCBEXPZ0','50','D','10','2',NULL,'Client Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientDivisionName"','3','(''UA''=''T,'')','EDSICCBEXPZ0','50','D','10','3',NULL,'Client Division Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','4','(''DA''=''T,'')','EDSICCBEXPZ0','50','D','10','4',NULL,'Salutation ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','5','(''UA''=''T,'')','EDSICCBEXPZ0','50','D','10','5',NULL,'First Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','6','(''UA''=''T,'')','EDSICCBEXPZ0','50','D','10','6',NULL,'Middle Initial ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','7','(''UA''=''T,'')','EDSICCBEXPZ0','50','D','10','7',NULL,'Last Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','8','(''UA''=''T,'')','EDSICCBEXPZ0','50','D','10','8',NULL,'SSN ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''DA''=''T,'')','EDSICCBEXPZ0','50','D','10','9',NULL,'Individual ID ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''DA''=''T,'')','EDSICCBEXPZ0','50','D','10','10',NULL,'Email ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','11','(''DA''=''T,'')','EDSICCBEXPZ0','50','D','10','11',NULL,'Phone ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','12','(''DA''=''T,'')','EDSICCBEXPZ0','50','D','10','12',NULL,'Phone 2 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','13','(''UA''=''T,'')','EDSICCBEXPZ0','50','D','10','13',NULL,'Address 1 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','14','(''UA''=''T,'')','EDSICCBEXPZ0','50','D','10','14',NULL,'Address 2 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','15','(''UA''=''T,'')','EDSICCBEXPZ0','50','D','10','15',NULL,'City ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','16','(''UA''=''T,'')','EDSICCBEXPZ0','50','D','10','16',NULL,'State or Province ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','17','(''UA''=''T,'')','EDSICCBEXPZ0','50','D','10','17',NULL,'Postal Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''DA''=''T,'')','EDSICCBEXPZ0','50','D','10','18',NULL,'Country ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"True"','19','(''DA''=''T,'')','EDSICCBEXPZ0','50','D','10','19',NULL,'Premium Address Same As Primary ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','20','(''DA''=''T,'')','EDSICCBEXPZ0','50','D','10','20',NULL,'Premium Address 1 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','21','(''DA''=''T,'')','EDSICCBEXPZ0','50','D','10','21',NULL,'Premium Address 2 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','22','(''DA''=''T,'')','EDSICCBEXPZ0','50','D','10','22',NULL,'Premium City ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','23','(''DA''=''T,'')','EDSICCBEXPZ0','50','D','10','23',NULL,'Premium State Or Province ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','24','(''DA''=''T,'')','EDSICCBEXPZ0','50','D','10','24',NULL,'Premium Postal Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','25','(''DA''=''T,'')','EDSICCBEXPZ0','50','D','10','25',NULL,'Premium Country ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSex"','26','(''UA''=''T,'')','EDSICCBEXPZ0','50','D','10','26',NULL,'Sex ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','27','(''UD101''=''T,'')','EDSICCBEXPZ0','50','D','10','27',NULL,'DOB ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"UNKNOWN"','28','(''DA''=''T,'')','EDSICCBEXPZ0','50','D','10','28',NULL,'Tobacco Use ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"UNKNOWN"','29','(''DA''=''T,'')','EDSICCBEXPZ0','50','D','10','29',NULL,'Employee Type ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"UNKNOWN"','30','(''DA''=''T,'')','EDSICCBEXPZ0','50','D','10','30',NULL,'Employee Payroll Type ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','31','(''DA''=''T,'')','EDSICCBEXPZ0','50','D','10','31',NULL,'Years of Service ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"COUPONBOOK"','32','(''DA''=''T,'')','EDSICCBEXPZ0','50','D','10','32',NULL,'Premium Coupon Type ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FALSE"','33','(''DA''=''T,'')','EDSICCBEXPZ0','50','D','10','33',NULL,'Uses HCTC ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TRUE"','34','(''DA''=''T,'')','EDSICCBEXPZ0','50','D','10','34',NULL,'Active ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FALSE"','35','(''DA''=''T,'')','EDSICCBEXPZ0','50','D','10','35',NULL,'Allow Member SSO ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','36','(''DA''=''T,'')','EDSICCBEXPZ0','50','D','10','36',NULL,'Benefit Group ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','37','(''DA''=''T,'')','EDSICCBEXPZ0','50','D','10','37',NULL,'Account Structure ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','38','(''DA''=''T'')','EDSICCBEXPZ0','50','D','10','38',NULL,'Client Specific Data ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBEVENT]"','1','(''DA''=''T,'')','EDSICCBEXPZ0','50','D','20','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEventType"','2','(''UA''=''T,'')','EDSICCBEXPZ0','50','D','20','2',NULL,'Event Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEventDate"','3','(''UD101''=''T,'')','EDSICCBEXPZ0','50','D','20','3',NULL,'Event Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrollmentDate"','4','(''UD101''=''T,'')','EDSICCBEXPZ0','50','D','20','4',NULL,'Enrollment Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeSSN"','5','(''UA''=''T,'')','EDSICCBEXPZ0','50','D','20','5',NULL,'Employee SSN ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeName"','6','(''UA''=''T,'')','EDSICCBEXPZ0','50','D','20','6',NULL,'Employee Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','7','(''DA''=''T'')','EDSICCBEXPZ0','50','D','20','7',NULL,'Second Event Original FDOC ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBPLANINITIAL]"','1','(''DA''=''T,'')','EDSICCBEXPZ0','50','D','30','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPLanName"','2','(''UA''=''T,'')','EDSICCBEXPZ0','50','D','30','2',NULL,'Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageLevel"','3','(''UA''=''T,'')','EDSICCBEXPZ0','50','D','30','3',NULL,'Coverage Level',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','4','(''DA''=''T'')','EDSICCBEXPZ0','50','D','30','4',NULL,'Number Of Units',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBDEPENDENT]"','1','(''DA''=''T,'')','EDSICCBEXPZ0','50','D','40','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','2','(''UA''=''T,'')','EDSICCBEXPZ0','50','D','40','2',NULL,'SSN ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelationship"','3','(''UA''=''T,'')','EDSICCBEXPZ0','50','D','40','3',NULL,'Relationship ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','4','(''DA''=''T,'')','EDSICCBEXPZ0','50','D','40','4',NULL,'Salutation ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','5','(''UA''=''T,'')','EDSICCBEXPZ0','50','D','40','5',NULL,'First Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','6','(''UA''=''T,'')','EDSICCBEXPZ0','50','D','40','6',NULL,'Middle Initial ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','7','(''UA''=''T,'')','EDSICCBEXPZ0','50','D','40','7',NULL,'Last Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''DA''=''T,'')','EDSICCBEXPZ0','50','D','40','8',NULL,'Email ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''DA''=''T,'')','EDSICCBEXPZ0','50','D','40','9',NULL,'Phone ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''DA''=''T,'')','EDSICCBEXPZ0','50','D','40','10',NULL,'Phone 2 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressSameAsQB"','11','(''UA''=''T,'')','EDSICCBEXPZ0','50','D','40','11',NULL,'Address Same As QB ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','12','(''UA''=''T,'')','EDSICCBEXPZ0','50','D','40','12',NULL,'Address 1 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','13','(''UA''=''T,'')','EDSICCBEXPZ0','50','D','40','13',NULL,'Address 2 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','14','(''UA''=''T,'')','EDSICCBEXPZ0','50','D','40','14',NULL,'City ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','15','(''UA''=''T,'')','EDSICCBEXPZ0','50','D','40','15',NULL,'State Or Province ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','16','(''UA''=''T,'')','EDSICCBEXPZ0','50','D','40','16',NULL,'Postal Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','17','(''DA''=''T,'')','EDSICCBEXPZ0','50','D','40','17',NULL,'Country ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''DA''=''T,'')','EDSICCBEXPZ0','50','D','40','18',NULL,'Enrollment Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSex"','19','(''UA''=''T,'')','EDSICCBEXPZ0','50','D','40','19',NULL,'Sex ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','20','(''UD101''=''T,'')','EDSICCBEXPZ0','50','D','40','20',NULL,'DOB ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"False"','21','(''DA''=''T'')','EDSICCBEXPZ0','50','D','40','21',NULL,'Is QMCSO ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBDEPENDENTPLANINITIAL]"','1','(''DA''=''T,'')','EDSICCBEXPZ0','50','D','50','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanName"','2','(''UA''=''T,'')','EDSICCBEXPZ0','50','D','50','2',NULL,'Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordType"','1','(''UA''=''T,'')','EDSICCBEXPZ0','50','D','60','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanName"','2','(''UA''=''T,'')','EDSICCBEXPZ0','50','D','60','2',NULL,'Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRate"','3','(''UA''=''T,'')','EDSICCBEXPZ0','50','D','60','3',NULL,'Rate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[NPM]"','1','(''DA''=''T,'')','EDSICCBEXPZ0','50','D','70','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','2','(''UA''=''T,'')','EDSICCBEXPZ0','50','D','70','2',NULL,'SSN ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''DA''=''T,'')','EDSICCBEXPZ0','50','D','70','3',NULL,'Individual Identifier ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Newport Group Inc 38989"','4','(''DA''=''T,'')','EDSICCBEXPZ0','50','D','70','4',NULL,'Client Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientDivisionName"','5','(''UA''=''T,'')','EDSICCBEXPZ0','50','D','70','5',NULL,'Client Division Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','6','(''UA''=''T,'')','EDSICCBEXPZ0','50','D','70','6',NULL,'First Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','7','(''UA''=''T,'')','EDSICCBEXPZ0','50','D','70','7',NULL,'Middle Initial ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','8','(''UA''=''T,'')','EDSICCBEXPZ0','50','D','70','8',NULL,'Last Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''DA''=''T,'')','EDSICCBEXPZ0','50','D','70','9',NULL,'Salutation ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''DA''=''T,'')','EDSICCBEXPZ0','50','D','70','10',NULL,'Email ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','11','(''DA''=''T,'')','EDSICCBEXPZ0','50','D','70','11',NULL,'Phone ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','12','(''DA''=''T,'')','EDSICCBEXPZ0','50','D','70','12',NULL,'Phone 2 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','13','(''UA''=''T,'')','EDSICCBEXPZ0','50','D','70','13',NULL,'Address 1 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','14','(''UA''=''T,'')','EDSICCBEXPZ0','50','D','70','14',NULL,'Address 2 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','15','(''UA''=''T,'')','EDSICCBEXPZ0','50','D','70','15',NULL,'City ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','16','(''UA''=''T,'')','EDSICCBEXPZ0','50','D','70','16',NULL,'State Or Province ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','17','(''UA''=''T,'')','EDSICCBEXPZ0','50','D','70','17',NULL,'Postal Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''DA''=''T,'')','EDSICCBEXPZ0','50','D','70','18',NULL,'Country ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSex"','19','(''UA''=''T,'')','EDSICCBEXPZ0','50','D','70','19',NULL,'Sex ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TRUE"','20','(''DA''=''T,'')','EDSICCBEXPZ0','50','D','70','20',NULL,'Uses Family In Address ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FALSE"','21','(''DA''=''T,'')','EDSICCBEXPZ0','50','D','70','21',NULL,'Has Waived All Coverage ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TRUE"','22','(''DA''=''T,'')','EDSICCBEXPZ0','50','D','70','22',NULL,'Send GR Notice ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHireDate"','23','(''UD101''=''T'')','EDSICCBEXPZ0','50','D','70','23',NULL,'Hire Date ',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EDSICCBEXP_20210317.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202102019','EMPEXPORT','OEACTIVE',NULL,'EDSICCBEXP',NULL,NULL,NULL,'202102019','Jan 24 2021  1:23PM','Jan 24 2021  1:23PM','202012011',NULL,'','','202012011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202102019','EMPEXPORT','OEPASSIVE',NULL,'EDSICCBEXP',NULL,NULL,NULL,'202102019','Jan 24 2021  1:23PM','Jan 24 2021  1:23PM','202012011',NULL,'','','202012011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Discover Cobra and NPM Export','202102019','EMPEXPORT','ONDEM_XOE',NULL,'EDSICCBEXP',NULL,NULL,NULL,'202102019','Jan 24 2021  1:23PM','Jan 24 2021  1:23PM','202012011',NULL,'','','202012011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Discover Cobra and NPM E-Sched','202102019','EMPEXPORT','SCH_EDSICC',NULL,'EDSICCBEXP',NULL,NULL,NULL,'202102019','Jan 24 2021  1:23PM','Jan 24 2021  1:23PM','202012011',NULL,'','','202012011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Discover Cobra and NPM E-Test','202102019','EMPEXPORT','TEST_XOE','Mar  9 2021  4:05PM','EDSICCBEXP',NULL,NULL,NULL,'202102019','Jan  1 2021 12:00AM','Dec 30 1899 12:00AM','202012011','163','','','202012011',dbo.fn_GetTimedKey(),NULL,'us3mLaNEW1020',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDSICCBEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDSICCBEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDSICCBEXP','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDSICCBEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDSICCBEXP','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EDSICCBEXP' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EDSICCBEXP' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EDSICCBEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EDSICCBEXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDSICCBEXP','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDSICCBEXP','D10','dbo.U_EDSICCBEXP_drvTbl_QB',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDSICCBEXP','D20','dbo.U_EDSICCBEXP_drvTbl_QBEVENT',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDSICCBEXP','D30','dbo.U_EDSICCBEXP_drvTbl_QBPLANINITIAL',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDSICCBEXP','D40','dbo.U_EDSICCBEXP_drvTbl_QBDEPENDENT',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDSICCBEXP','D50','dbo.U_EDSICCBEXP_drvTbl_QBDEPENDENTPLANINITIAL',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDSICCBEXP','D60','dbo.U_EDSICCBEXP_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDSICCBEXP','D70','dbo.U_EDSICCBEXP_drvTbl_NPM',NULL);
IF OBJECT_ID('U_dsi_BDM_EDSICCBEXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EDSICCBEXP] (
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
IF OBJECT_ID('U_EDSICCBEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EDSICCBEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EDSICCBEXP_drvTbl_NPM') IS NULL
CREATE TABLE [dbo].[U_EDSICCBEXP_drvTbl_NPM] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvClientDivisionName] varchar(16) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(102) NULL,
    [drvAddressLine1] varchar(257) NULL,
    [drvAddressLine2] varchar(257) NOT NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvSex] varchar(1) NULL,
    [drvHireDate] datetime NULL
);
IF OBJECT_ID('U_EDSICCBEXP_drvTbl_QB') IS NULL
CREATE TABLE [dbo].[U_EDSICCBEXP_drvTbl_QB] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(16) NULL,
    [drvClientDivisionName] varchar(16) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(102) NULL,
    [drvSsn] char(11) NULL,
    [drvAddressLine1] varchar(8000) NULL,
    [drvAddressLine2] varchar(8000) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvSex] varchar(1) NULL,
    [drvDateOfBirth] datetime NULL
);
IF OBJECT_ID('U_EDSICCBEXP_drvTbl_QBDEPENDENT') IS NULL
CREATE TABLE [dbo].[U_EDSICCBEXP_drvTbl_QBDEPENDENT] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(31) NULL,
    [drvSSN] char(6) NULL,
    [drvRelationship] varchar(15) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(102) NULL,
    [drvAddressSameAsQB] varchar(4) NOT NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvSex] varchar(1) NULL,
    [drvDateOfBirth] datetime NULL
);
IF OBJECT_ID('U_EDSICCBEXP_drvTbl_QBDEPENDENTPLANINITIAL') IS NULL
CREATE TABLE [dbo].[U_EDSICCBEXP_drvTbl_QBDEPENDENTPLANINITIAL] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(31) NULL,
    [drvPlanName] varchar(32) NULL
);
IF OBJECT_ID('U_EDSICCBEXP_drvTbl_QBEVENT') IS NULL
CREATE TABLE [dbo].[U_EDSICCBEXP_drvTbl_QBEVENT] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(16) NULL,
    [drvEventType] varchar(39) NOT NULL,
    [drvEventDate] datetime NULL,
    [drvEnrollmentDate] datetime NULL,
    [drvEmployeeSSN] char(11) NULL,
    [drvEmployeeName] varchar(203) NOT NULL
);
IF OBJECT_ID('U_EDSICCBEXP_drvTbl_QBPLANINITIAL') IS NULL
CREATE TABLE [dbo].[U_EDSICCBEXP_drvTbl_QBPLANINITIAL] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(16) NULL,
    [drvPLanName] varchar(32) NULL,
    [drvCoverageLevel] varchar(11) NULL
);
IF OBJECT_ID('U_EDSICCBEXP_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL') IS NULL
CREATE TABLE [dbo].[U_EDSICCBEXP_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(16) NULL,
    [drvRecordType] varchar(33) NOT NULL,
    [drvPlanName] varchar(15) NULL,
    [drvRate] nvarchar(4000) NULL
);
IF OBJECT_ID('U_EDSICCBEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EDSICCBEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EDSICCBEXP_File') IS NULL
CREATE TABLE [dbo].[U_EDSICCBEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
IF OBJECT_ID('U_EDSICCBEXP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EDSICCBEXP_PDedHist] (
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
IF OBJECT_ID('U_EDSICCBEXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EDSICCBEXP_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EDSICCBEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Newport Group

Created By: James Bender
Business Analyst: Cheryl Petitti
Create Date: 01/24/2021
Service Request Number: TekP-2020-10-22-0003

Purpose: Discover Cobra and NPM Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EDSICCBEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EDSICCBEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EDSICCBEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EDSICCBEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EDSICCBEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDSICCBEXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDSICCBEXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDSICCBEXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDSICCBEXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDSICCBEXP', 'SCH_EDSICC';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EDSICCBEXP';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EDSICCBEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EDSICCBEXP';

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
    DELETE FROM dbo.U_EDSICCBEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EDSICCBEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_EDSICCBEXP_EEList WHERE xEEID IN (
        SELECT DISTINCT EecEEID  FROM dbo.EmpComp WITH (NOLOCK) WHERE EecEEType IN ('TES')
    )

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'DENBA,DENAD,UMHDH,UMPPO,VIS,MHMO,KHDHP,FSA,FSALP,STDE';
    --SET @DedList = 'DENBA,DENAD,UMHDH,UMPPO,VIS,MHMO,KHDHP,FSA,FSALP,STDE,FSADC';

    IF OBJECT_ID('U_EDSICCBEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EDSICCBEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EDSICCBEXP_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

     -- Non Cobra
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DedList);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'TermSelectionOption','AuditDate');
    -- NPM parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RunID','NPM');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','X'); -- DedIsCobraCovered = 'Y'
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'NewEnrolleeType','4'); -- All new enrollees where no previous plan exists
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'TableType','EMP'); -- Only include employees on NPM file

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
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','X'); -- DedIsCobraCovered = 'Y'
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraType','4'); -- Eep/ConCobraReason first, then BdmCobraReason. Include CHGRP for elig. ben groups – 
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraDate','3'); -- EedBenStopDate and DbnBenStopDate, unless Eep/ConDateOfCOBRAEvent exists – 
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraPQBType','1'); -- If no EE or spouse, ALL children are PQB (not just oldest) – 
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'AddToPreviousRun', 'Y')

    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'CobraReasonsEmp', '201,204,210,LEVNT3,LEVNT4,200') -- add regular term and--  200 and 210
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'CobraReasonsDep', '201,204,210,LEVNT3,LEVNT4,200')
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraReasonsDepPQB','201,204,210,LEVNT3,LEVNT4,302'); -- 
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidCobraReasonsEmp','201,204,210,LEVNT3,LEVNT4'); --,302'); -- Invalidate employee when Cobra Reason is a dependent PQB reason – 
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidTermReasonsEmp','203'); -- Invalidate employee when Cobra Reason is "Death".  
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CountDependents','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'ConCobraReasonPCF','DependentCOBRAReason'); -- Valid dependent PQB reasons
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS'); -- update to the spouse relationship code
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL,DAU,DPC,SON,STC'); -- update to the child relationship codes
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP,DOM'); -- update to the domestic partner relationship code
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard'); -- same for all files
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
    -- Insert into BDM Reason code 201 and 204
    --==========================================
    INSERT INTO [dbo].[U_dsi_BDM_EDSICCBEXP]
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
        ,[BdmBenStartDate]
        ,[BdmBenStopDate]
        ,[BdmBenStatusDate]
        ,[BdmChangeReason]
        ,[BdmCobraReason]
        ,[BdmStartDate]
        ,[BdmStopDate]
        ,[BdmIsPQB]
        ,[BdmBenOption])
    SELECT /*rectype =*/ 'DEP'
        ,dbnCoid
        ,dbneeid
        ,DbnDepRecID
        ,DbnDepRecID
        ,'QB'
        ,'Data Inserted for 302 Chg reason'
        ,DbnRelationship
        ,DbnDateOfBirth
        ,DbnDedcode
        ,(SELECT TOP 1 edhBenStartDate FROM dbo.Emphded A WITH (NOLOCK) WHERE A.edhdedcode = dbnDedcode and A.edheeid =  dbneeid and A.edhcoid = dbncoid ORDER BY Auditkey ASC ) AS bdmBenstartDate
        ,edhBenStopDate
        ,edhEffDate
        ,'302'
        ,'302'
        ,edhStartDate
        ,edhStopDate
        ,CASE WHEN dbnRelationShip = 'SPS' THEN 'Y' ELSE 'N' END
        ,edhbenoption
    FROM dbo.emphded WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_DepDeductions 
        ON dbneeid = edheeid 
        AND dbnformatcode = @FormatCode
    WHERE edhChangeReason in ('302') 
        AND dbnBenstatusdate BETWEEN @startdate AND @enddate 
        AND dbnValidForExport = 'N'
        AND DbnDedCode = EdhDedCode
    GROUP BY dbnCoid,dbneeid,DbnDepRecID,DbnRelationship,DbnDateOfBirth,dbnDedcode,edhBenStopDate,edhEffDate,edhStartDate,edhStopDate,edhbenoption

    DELETE FROM dbo.U_dsi_BDM_EDSICCBEXP WHERE bdmdedcode NOT IN  (SELECT DISTINCT Dedcode FROM dbo.U_EDSICCBEXP_DedList)
    
    UPDATE dbo.U_dsi_BDM_EDSICCBEXP 
        SET bdmNumSpouses = (SELECT COUNT(*) FROM dbo.U_dsi_BDM_EDSICCBEXP A WHERE A.bdmeeid = X.bdmeeid AND bdmRelationship = 'SPS' AND A.bdmcoid = X.bdmcoid)
            ,bdmNumChildren = (SELECT COUNT(*) FROM dbo.U_dsi_BDM_EDSICCBEXP A WHERE A.bdmeeid = X.bdmeeid AND bdmRelationship = 'CHL' AND A.bdmcoid = X.bdmcoid)
    FROM dbo.U_dsi_BDM_EDSICCBEXP  X
    WHERE BdmDedRowStatus IN ('Data Inserted for 302 Chg reason') --,'Data Inserted for 201 Chg reason')

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EDSICCBEXP_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EDSICCBEXP_PDedHist;
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
    INTO dbo.U_EDSICCBEXP_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EDSICCBEXP_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EDSICCBEXP_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EDSICCBEXP_PEarHist;
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
    INTO dbo.U_EDSICCBEXP_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EDSICCBEXP_drvTbl_QB
    ---------------------------------
    IF OBJECT_ID('U_EDSICCBEXP_drvTbl_QB','U') IS NOT NULL
        DROP TABLE dbo.U_EDSICCBEXP_drvTbl_QB;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '3 ' + xEEID + ' 1'
        -- standard fields above and additional driver fields below
        ,drvClientDivisionName =    CASE WHEN xCOID = 'U5P4Y' AND EepAddressState <> 'CA' THEN 'Newport Group'
                                        WHEN xCOID = 'U5P4Y' AND EepAddressState = 'CA' THEN 'Newport Group CA'
                                        WHEN xCOID = 'CXNNJ' THEN 'PAI Inc'
                                    END
        ,drvNameFirst = CASE WHEN BdmCobraReason IN ('LEVNT3','LEVNT4','204','210','201','302') THEN ConNameFirst ELSE EepNameFirst END
        ,drvNameMiddle = CASE WHEN BdmCobraReason IN ('LEVNT3','LEVNT4','204','210','201','302') THEN LEFT(ConNameMiddle, 1) ELSE LEFT(EepNameMiddle,1) END
        ,drvNameLast = '"' + CASE WHEN BdmCobraReason IN ('LEVNT3','LEVNT4','204','210','201','302') THEN ConNameLast ELSE EepNameLast END + '"'
        ,drvSsn = CASE WHEN BdmCobraReason IN ('LEVNT3','LEVNT4','204','210','201','302') THEN ConSSN ELSE EepSsn END
        ,drvAddressLine1 = REPLACE(CASE WHEN BdmCobraReason IN ('LEVNT3','LEVNT4','204','210','201','302') THEN ConAddressLine1 ELSE EepAddressLine1 END, ',', '')
        ,drvAddressLine2 = REPLACE(CASE WHEN BdmCobraReason IN ('LEVNT3','LEVNT4','204','210','201','302') THEN ConAddressLIne2 ELSE EepAddressLine2 END, ',', '')
        ,drvAddressCity = CASE WHEN BdmCobraReason IN ('LEVNT3','LEVNT4','204','210','201','302') THEN ConAddressCity ELSE EepAddressCity END
        ,drvAddressState = CASE WHEN BdmCobraReason IN ('LEVNT3','LEVNT4','204','210','201','302') THEN ConAddressState ELSE EepAddressState END
        ,drvAddressZipCode = CASE WHEN BdmCobraReason IN ('LEVNT3','LEVNT4','204','210','201','302') THEN ConAddressZipCode ELSE EepAddressZipCode END
        ,drvSex =    CASE WHEN BdmCobraReason IN ('LEVNT3','LEVNT4','204','210','201','302') THEN 
                            CASE WHEN ConGender IN ('M','F') THEN ConGender ELSE 'U' END
                        ELSE 
                            CASE WHEN EepGender IN ('M','F') THEN EepGender ELSE 'U' END                         
                    END
        ,drvDateOfBirth = CASE WHEN BdmCobraReason IN ('LEVNT3','LEVNT4','204','210','201','302') THEN ConDateOfBirth ELSE EepDateOfBirth END
    INTO dbo.U_EDSICCBEXP_drvTbl_QB
    FROM dbo.U_EDSICCBEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EDSICCBEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND (BdmCoID = xCoID OR BdmCobraReason = '302')
        AND BdmRunId = 'QB'
        --AND BdmCobraReason <> '302' OR (BdmCobraReason = '302' AND ConRelationship IN ('SPS','DP'))
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecId
    JOIN (
            SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent 
            FROM (
                    SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent, ROW_NUMBER() OVER (PARTITION by EdhEEID, EdhCOID ORDER BY EdhEffDate desc) AS RN
                    FROM dbo.EmpHDed a WITH (NOLOCK)
                    JOIN dbo.BenChRsn WITH (NOLOCK)
                        ON EdhChangeReason = BchCode
                    WHERE EdhDedCode IN ('DENBA','DENAD','UMHDH','UMPPO','VIS','MHMO','KHDHP','FSA','FSALP','STDE') 
                        AND edhChangeReason IN ('201','204','210','LEVNT3','LEVNT4','200','302')
                        AND BchIsCobraQualifiedEvent = 'Y') AS T
            ) AS ChgReason
        ON EdhEEID = xEEID
        AND EdhCOID = xCOID
    WHERE BdmCobraReason <> '302' OR (BdmCobraReason = '302' AND ConRelationship IN ('SPS','DP'))
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EDSICCBEXP_drvTbl_QBEVENT
    ---------------------------------
    IF OBJECT_ID('U_EDSICCBEXP_drvTbl_QBEVENT','U') IS NOT NULL
        DROP TABLE dbo.U_EDSICCBEXP_drvTbl_QBEVENT;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '3 ' + xEEID + ' 2'
        -- standard fields above and additional driver fields below
        ,drvEventType =    CASE WHEN EecEmplStatus = 'T' AND EecTermReason NOT IN ('202','203') AND EecTermType = 'V' THEN 'TERMINATION'
                            WHEN EecEmplStatus = 'T' AND EecTermReason = '203' THEN 'DEATH'
                            WHEN EecEmplStatus = 'T' AND EecTermReason = '202' THEN 'RETIREMENT'
                            WHEN EecEmplStatus = 'T' AND EecTermType = 'I' THEN 'INVOLUNTARYTERMINATION'
                            WHEN EdhChangeReason = '208' THEN 'RETIREMENT'
                            WHEN EdhChangeReason IN ('204','LEVNT4') THEN 'DIVORCELEGALSEPARATION'
                            WHEN EdhChangeReason IN ('205') THEN 'MEDICARE'
                            WHEN EdhChangeReason IN ('201','302 ','LEVNT3') THEN 'INELIGIBLEDEPENDENT'
                            WHEN EdhChangeReason IN ('203','202') THEN 'REDUCTIONINHOURS-STATUSCHANGE'
                            WHEN EdhChangeReason IN ('206') THEN 'REDUCTIONINHOURS-ENDOFLEAVE'
                            ELSE 'chg reason: ' + ISNULL(EdhChangeReason, '') + ' : term reason:' + ISNULL(EecTermReason, '')
                        END
        ,drvEventDate =    CASE WHEN eecEmplStatus = 'T' AND EecTermReason NOT IN ('202','203') THEN EecDateOfTermination
                            WHEN EecEmplStatus = 'T' AND EecTermReason IN ('202','203') AND BdmDateOfCobraEvent IS NOT NULL THEN BdmDateOfCobraEvent
                            WHEN EecEmplStatus = 'T' AND EecTermReason IN ('202','203') AND BdmDateOfCobraEvent IS NULL THEN EecDateOfTermination
                            WHEN EdhChangeReason IN ('LEVNT3','LEVNT4','204','210','201','302') THEN ConCobraStatusDate
                            ELSE EepDateOFCobraEvent
                        END
        --CASE WHEN EdhChangeReason IN ('LEVNT3','LEVNT4','204','210','201','302') THEN ConCobraStatusDate ELSE BdmDateOfCobraEvent END
        ,drvEnrollmentDate = CASE WHEN EdhChangeReason IN ('LEVNT3','LEVNT4','204','210','201','302') THEN /*ConBenStartDate*/ BdmBenStartDate ELSE BdmBenStartDate END
        ,drvEmployeeSSN = eepSSN
        ,drvEmployeeName = '"' + ISNULL(EepNameFirst, '') + ' ' + ISNULL(EepNameLast, '') + '"'
    INTO dbo.U_EDSICCBEXP_drvTbl_QBEVENT
    FROM dbo.U_EDSICCBEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
/*    JOIN dbo.U_dsi_BDM_EDSICCBEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRunId = 'QB'*/
    JOIN (
            SELECT BdmEEID, BdmCOID, BdmDepRecId, MAX(BdmBenStartDate) AS BdmBenStartDate, MAX(BdmDateOfCobraEvent) AS BdmDateOfCobraEvent
            FROM dbo.U_dsi_BDM_EDSICCBEXP WITH (NOLOCK)
            WHERE BdmRunId = 'QB'
            GROUP BY BdmEEID, BdmCOID, BdmDepRecId) AS BDM
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN (
            SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent 
            FROM (
                    SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent, ROW_NUMBER() OVER (PARTITION by EdhEEID, EdhCOID ORDER BY EdhEffDate desc) AS RN
                    FROM dbo.EmpHDed a WITH (NOLOCK)
                    JOIN dbo.BenChRsn WITH (NOLOCK)
                        ON EdhChangeReason = BchCode
                    WHERE EdhDedCode IN ('DENBA','DENAD','UMHDH','UMPPO','VIS','MHMO','KHDHP','FSA','FSALP','STDE') 
                        AND edhChangeReason IN ('201','204','210','LEVNT3','LEVNT4','200')
                        AND BchIsCobraQualifiedEvent = 'Y') AS T
            WHERE RN = 1
            ) AS ChgReason
        ON EdhEEID = xEEID
        AND EdhCOID = xCOID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecId
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EDSICCBEXP_drvTbl_QBPLANINITIAL
    ---------------------------------
    IF OBJECT_ID('U_EDSICCBEXP_drvTbl_QBPLANINITIAL','U') IS NOT NULL
        DROP TABLE dbo.U_EDSICCBEXP_drvTbl_QBPLANINITIAL;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '3 ' + xEEID + ' 3'
        -- standard fields above and additional driver fields below
        ,drvPLanName =    CASE WHEN BdmDedCode = 'FSA' THEN 'DBI FSA'
                            WHEN BdmDedCode = 'FSALP' THEN 'DBI Limited FSA'
                            WHEN BdmDedCode = 'STDE' THEN 'Claremont EAP Newport' --
                            WHEN BdmDedCode = 'DENBA' AND EepAddressState NOT IN ('TX','MS','LA') THEN 'MetLife Dental Basic'
                            WHEN BdmDedCode = 'DENBA' AND EepAddressState IN ('TX','MS','LA') THEN 'MetLife Dental Basic TX/MS/LA'
                            WHEN BdmDedCode = 'DENAD' AND EepAddressState NOT IN ('TX','MS','LA') THEN 'MetLife Dental Enhanced'
                            WHEN BdmDedCode = 'DENAD' AND EepAddressState IN ('TX','MS','LA') THEN 'MetLife Dental Enhanced TX/MS/LA'
                            WHEN BdmDedCode = 'UMHDH' AND EepAddressState NOT IN ('CA') THEN 'UMR/UHC Medical HDHP'
                            WHEN BdmDedCode = 'UMHDH' AND EepAddressState IN ('CA') THEN 'UMR/UHC Medical HDHP CA Only'
                            WHEN BdmDedCode = 'UMPPO' AND EepAddressState NOT IN ('CA') THEN 'UMR/UHC Medical PPO'
                            WHEN BdmDedCode = 'UMPPO' AND EepAddressState IN ('CA') THEN 'UMR/UHC Medical PPO CA Only'
                            WHEN BdmDedCode = 'VIS' THEN 'VSP Vision Newport'
                            WHEN BdmDedCode = 'MHMO' THEN 'Kaiser CA Medical DHMO'
                            WHEN BdmDedCode = 'MHMO' THEN 'Kaiser CA Medical Newport HSA'                            
                        END
        ,drvCoverageLevel =    CASE WHEN BdmDedCode IN ('DENBA','DENAD','UMHDH','UMPPO','VIS','MHMO','KHDHP') THEN
                                CASE WHEN BdmBenOption = 'EE' THEN 'EE'
                                    WHEN BdmBenOption = 'EEC' THEN 'EE+CHILDREN'
                                    WHEN BdmBenOption IN ('EEF','EEDPF') THEN 'EE+FAMILY'
                                    WHEN BdmBenOption IN ('EES','EEDP') THEN 'EE+SPOUSE'
                                END
                                WHEN BdmDedCode IN ('FSA','FSALP','STDE') THEN 'EE'
                            END
    INTO dbo.U_EDSICCBEXP_drvTbl_QBPLANINITIAL
    FROM dbo.U_EDSICCBEXP_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EDSICCBEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRunId = 'QB'
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EDSICCBEXP_drvTbl_QBDEPENDENT
    ---------------------------------
    IF OBJECT_ID('U_EDSICCBEXP_drvTbl_QBDEPENDENT','U') IS NOT NULL
        DROP TABLE dbo.U_EDSICCBEXP_drvTbl_QBDEPENDENT;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '3 ' + xEEID + ' 4 ' + BdmDepRecId + ' 1'
        -- standard fields above and additional driver fields below
        ,drvSSN = BdmCobraReason -- ConSSN
        ,drvRelationship =    CASE WHEN ConRelationship = 'SPS' THEN 'SPOUSE'
                                WHEN ConRelationship = 'DP' THEN 'DOMESTICPARTNER'
                                WHEN ConRelationship IN ('CHL','DIS','DPC','STC') THEN 'CHILD'
                            END
        ,drvNameFirst = ConNameFirst
        ,drvNameMiddle = LEFT(ConNameMiddle,1)
        ,drvNameLast = '"' + ConNameLast + '"'
        ,drvAddressSameAsQB = CASE WHEN ConAddressIsDifferent = 'NO' THEN 'TRUE' ELSE 'FALS' END
        ,drvAddressLine1 = CASE WHEN ConAddressIsDifferent = 'NO' THEN EepAddressLine1 ELSE ConAddressLine1 END
        ,drvAddressLine2 = CASE WHEN ConAddressIsDifferent = 'NO' THEN EepAddressLine2 ELSE ConAddressLine2 END
        ,drvAddressCity = CASE WHEN ConAddressIsDifferent = 'NO' THEN EepAddressCity ELSE ConAddressCity END
        ,drvAddressState = CASE WHEN ConAddressIsDifferent = 'NO' THEN EepAddressState ELSE ConAddressState END
        ,drvAddressZipCode = CASE WHEN ConAddressIsDifferent = 'NO' THEN EepAddressZipCode ELSE ConAddressZipCode END
        ,drvSex = CASE WHEN ConGender IN ('M','F') THEN ConGender ELSE 'U' END
        ,drvDateOfBirth = ConDateOfBirth
    INTO dbo.U_EDSICCBEXP_drvTbl_QBDEPENDENT
    FROM dbo.U_EDSICCBEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EDSICCBEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRecType = 'DEP'
        AND BdmRunId = 'QB'
        --AND BdmCobraReason <> '302'
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecId
    WHERE BdmCobraReason <> '302' OR (BdmCobraReason = '302' AND ConRelationship NOT IN ('SPS','DP'))
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EDSICCBEXP_drvTbl_QBDEPENDENTPLANINITIAL
    ---------------------------------
    IF OBJECT_ID('U_EDSICCBEXP_drvTbl_QBDEPENDENTPLANINITIAL','U') IS NOT NULL
        DROP TABLE dbo.U_EDSICCBEXP_drvTbl_QBDEPENDENTPLANINITIAL;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '3 ' + xEEID + ' 4 ' + BdmDepRecId + ' 2'
        -- standard fields above and additional driver fields below
        ,drvPlanName =    CASE WHEN BdmDedCode = 'DNBA' AND EepAddressState NOT IN ('TX','MS','LA') THEN 'MetLife Dental Basic'
                            WHEN BdmDedCode = 'DNBA' AND EepAddressState IN ('TX','MS','LA') THEN 'MetLife Dental Basic TX/MS/LA'
                            WHEN BdmDedCode = 'DENAD' AND EepAddressState NOT IN ('TX','MS','LA') THEN 'MetLife Dental Enhanced'
                            WHEN BdmDedCode = 'DENAD' AND EepAddressState IN ('TX','MS','LA') THEN 'MetLife Dental Enhanced TX/MS/LA'
                            WHEN BdmDedCode = 'UMHDH' AND EepAddressState NOT IN ('CA') THEN 'UMR/UHC Medical HDHP'
                            WHEN BdmDedCode = 'UMHDH' AND EepAddressState IN ('CA') THEN 'UMR/UHC Medical HDHP CA Only'
                            WHEN BdmDedCode = 'UMPPO' AND EepAddressState NOT IN ('CA') THEN 'UMR/UHC Medical PPO'
                            WHEN BdmDedCode = 'UMPPO' AND EepAddressState IN ('CA') THEN 'UMR/UHC Medical PPO CA Only'
                            WHEN BdmDedCode = 'VIS' THEN 'VSP Vision Newport'
                            WHEN BdmDedCode = 'MHMO' THEN 'Kaiser CA Medical DHMO'
                            WHEN BdmDedCode = 'KHDHP' THEN 'Kaiser CA Medical Newport HSA'
                        END
    INTO dbo.U_EDSICCBEXP_drvTbl_QBDEPENDENTPLANINITIAL
    FROM dbo.U_EDSICCBEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EDSICCBEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRecType = 'DEP'
        AND BdmRunId = 'QB'
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EDSICCBEXP_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL
    ---------------------------------
    IF OBJECT_ID('U_EDSICCBEXP_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL','U') IS NOT NULL
        DROP TABLE dbo.U_EDSICCBEXP_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '3 ' + xEEID + ' 5'
        -- standard fields above and additional driver fields below
        ,drvRecordType = '[QBPLANMEMBERSPECIFICRATEINITIAL]'
        ,drvPlanName =    CASE WHEN BdmDedCode = 'FSA' THEN 'DBI FSA'
                            WHEN BdmDedCode = 'FSALP' THEN 'DBI Limited FSA'
                        END
        ,drvRate = CASE WHEN BdmDedCode IN ('FSA','FSALP') THEN FORMAT(BdmEEAmt, '#0.00') END
    INTO dbo.U_EDSICCBEXP_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL
    FROM dbo.U_EDSICCBEXP_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EDSICCBEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRunId = 'QB'
        AND BdmDedCode IN ('FSA','FSALP')
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EDSICCBEXP_drvTbl_NPM
    ---------------------------------
    IF OBJECT_ID('U_EDSICCBEXP_drvTbl_NPM','U') IS NOT NULL
        DROP TABLE dbo.U_EDSICCBEXP_drvTbl_NPM;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '2'
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvClientDivisionName =    CASE WHEN xCOID = 'U5P4Y' AND EepAddressState <> 'CA' THEN 'Newport Group'
                                        WHEN xCOID = 'U5P4Y' AND EepAddressState = 'CA' THEN 'Newport Group CA'
                                        WHEN xCOID = 'CXNNJ' THEN 'PAI Inc'
                                    END
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvNameLast = '"' + EepNameLast + '"'
        ,drvAddressLine1 = '"' + EepAddressLine1 + '"'
        ,drvAddressLine2 = '"' + ISNULL(EepAddressLine2, '') + '"'
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvSex = CASE WHEN EepGender IN ('M','F') THEN EepGender ELSE 'U' END
        ,drvHireDate = EecDateOfLastHire
    INTO dbo.U_EDSICCBEXP_drvTbl_NPM
    FROM dbo.U_EDSICCBEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EDSICCBEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRunId = 'NPM'
    JOIN (
            SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent 
            FROM (
                    SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent, ROW_NUMBER() OVER (PARTITION by EdhEEID, EdhCOID ORDER BY EdhEffDate desc) AS RN
                    FROM dbo.EmpHDed a WITH (NOLOCK)
                    JOIN dbo.BenChRsn WITH (NOLOCK)
                        ON EdhChangeReason = BchCode
                    WHERE EdhDedCode IN ('DENBA','DENAD','UMHDH','UMPPO','VIS','MHMO','KHDHP','FSA','FSALP','STDE') 
                ) AS T 
            WHERE RN = 1) AS X
        ON EdhEEID = xEEID
        AND EdhCOID = xCOID
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
ALTER VIEW dbo.dsi_vwEDSICCBEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EDSICCBEXP_File (NOLOCK)
    ORDER BY  InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EDSICCBEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202012011'
       ,expStartPerControl     = '202012011'
       ,expLastEndPerControl   = '202102019'
       ,expEndPerControl       = '202102019'
WHERE expFormatCode = 'EDSICCBEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEDSICCBEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EDSICCBEXP_File (NOLOCK)
    ORDER BY  InitialSort, SubSort;