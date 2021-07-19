SET NOCOUNT ON;
IF OBJECT_ID('U_EDISCOBRA_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EDISCOBRA_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EDISCOBRA_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EDISCOBRA' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEDISCOBRA_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEDISCOBRA_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EDISCOBRA') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EDISCOBRA];
GO
IF OBJECT_ID('U_EDISCOBRA_File') IS NOT NULL DROP TABLE [dbo].[U_EDISCOBRA_File];
GO
IF OBJECT_ID('U_EDISCOBRA_EEList') IS NOT NULL DROP TABLE [dbo].[U_EDISCOBRA_EEList];
GO
IF OBJECT_ID('U_EDISCOBRA_drvTbl_QBPLANINITIAL') IS NOT NULL DROP TABLE [dbo].[U_EDISCOBRA_drvTbl_QBPLANINITIAL];
GO
IF OBJECT_ID('U_EDISCOBRA_drvTbl_QBEVENT') IS NOT NULL DROP TABLE [dbo].[U_EDISCOBRA_drvTbl_QBEVENT];
GO
IF OBJECT_ID('U_EDISCOBRA_drvTbl_QBDEPENDENTPLANINITIAL') IS NOT NULL DROP TABLE [dbo].[U_EDISCOBRA_drvTbl_QBDEPENDENTPLANINITIAL];
GO
IF OBJECT_ID('U_EDISCOBRA_drvTbl_QBDEPENDENT') IS NOT NULL DROP TABLE [dbo].[U_EDISCOBRA_drvTbl_QBDEPENDENT];
GO
IF OBJECT_ID('U_EDISCOBRA_drvTbl_QB') IS NOT NULL DROP TABLE [dbo].[U_EDISCOBRA_drvTbl_QB];
GO
IF OBJECT_ID('U_EDISCOBRA_drvTbl_NPM') IS NOT NULL DROP TABLE [dbo].[U_EDISCOBRA_drvTbl_NPM];
GO
IF OBJECT_ID('U_EDISCOBRA_DedList') IS NOT NULL DROP TABLE [dbo].[U_EDISCOBRA_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EDISCOBRA') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EDISCOBRA];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EDISCOBRA';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EDISCOBRA';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EDISCOBRA';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EDISCOBRA';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EDISCOBRA';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EDISCOBRA','Discover Cobra and NPM Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','EDISCOBRAZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EDISCOBRA' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[VERSION]"','1','(''DA''=''T,'')','EDISCOBRAZ0','50','H','01','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"1.1"','2','(''DA''=''T'')','EDISCOBRAZ0','50','H','01','2',NULL,'Version',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QB]"','1','(''DA''=''T,'')','EDISCOBRAZ0','50','D','10','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mar-Bal Inc 22541"','2','(''DA''=''T,'')','EDISCOBRAZ0','50','D','10','2',NULL,'Client Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientDivisionName"','3','(''UA''=''T,'')','EDISCOBRAZ0','50','D','10','3',NULL,'Client Division Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','4','(''DA''=''T,'')','EDISCOBRAZ0','50','D','10','4',NULL,'Salutation ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','5','(''UA''=''T,'')','EDISCOBRAZ0','50','D','10','5',NULL,'First Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','6','(''UA''=''T,'')','EDISCOBRAZ0','50','D','10','6',NULL,'Middle Initial ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','7','(''UA''=''T,'')','EDISCOBRAZ0','50','D','10','7',NULL,'Last Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','8','(''UA''=''T,'')','EDISCOBRAZ0','50','D','10','8',NULL,'SSN ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''DA''=''T,'')','EDISCOBRAZ0','50','D','10','9',NULL,'Individual ID ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''DA''=''T,'')','EDISCOBRAZ0','50','D','10','10',NULL,'Email ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','11','(''DA''=''T,'')','EDISCOBRAZ0','50','D','10','11',NULL,'Phone ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','12','(''DA''=''T,'')','EDISCOBRAZ0','50','D','10','12',NULL,'Phone 2 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','13','(''UA''=''T,'')','EDISCOBRAZ0','50','D','10','13',NULL,'Address 1 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','14','(''UA''=''T,'')','EDISCOBRAZ0','50','D','10','14',NULL,'Address 2 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','15','(''UA''=''T,'')','EDISCOBRAZ0','50','D','10','15',NULL,'City ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','16','(''UA''=''T,'')','EDISCOBRAZ0','50','D','10','16',NULL,'State or Province ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','17','(''UA''=''T,'')','EDISCOBRAZ0','50','D','10','17',NULL,'Postal Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''DA''=''T,'')','EDISCOBRAZ0','50','D','10','18',NULL,'Country ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"True"','19','(''DA''=''T,'')','EDISCOBRAZ0','50','D','10','19',NULL,'Premium Address Same As Primary ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','20','(''DA''=''T,'')','EDISCOBRAZ0','50','D','10','20',NULL,'Premium Address 1 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','21','(''DA''=''T,'')','EDISCOBRAZ0','50','D','10','21',NULL,'Premium Address 2 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','22','(''DA''=''T,'')','EDISCOBRAZ0','50','D','10','22',NULL,'Premium City ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','23','(''DA''=''T,'')','EDISCOBRAZ0','50','D','10','23',NULL,'Premium State Or Province ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','24','(''DA''=''T,'')','EDISCOBRAZ0','50','D','10','24',NULL,'Premium Postal Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','25','(''DA''=''T,'')','EDISCOBRAZ0','50','D','10','25',NULL,'Premium Country ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSex"','26','(''UA''=''T,'')','EDISCOBRAZ0','50','D','10','26',NULL,'Sex ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','27','(''UD101''=''T,'')','EDISCOBRAZ0','50','D','10','27',NULL,'DOB ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"UNKNOWN"','28','(''DA''=''T,'')','EDISCOBRAZ0','50','D','10','28',NULL,'Tobacco Use ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"UNKNOWN"','29','(''DA''=''T,'')','EDISCOBRAZ0','50','D','10','29',NULL,'Employee Type ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"UNKNOWN"','30','(''DA''=''T,'')','EDISCOBRAZ0','50','D','10','30',NULL,'Employee Payroll Type ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','31','(''DA''=''T,'')','EDISCOBRAZ0','50','D','10','31',NULL,'Years of Service ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"COUPONBOOK"','32','(''DA''=''T,'')','EDISCOBRAZ0','50','D','10','32',NULL,'Premium Coupon Type ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FALSE"','33','(''DA''=''T,'')','EDISCOBRAZ0','50','D','10','33',NULL,'Uses HCTC ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TRUE"','34','(''DA''=''T,'')','EDISCOBRAZ0','50','D','10','34',NULL,'Active ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FALSE"','35','(''DA''=''T,'')','EDISCOBRAZ0','50','D','10','35',NULL,'Allow Member SSO ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','36','(''DA''=''T,'')','EDISCOBRAZ0','50','D','10','36',NULL,'Benefit Group ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','37','(''DA''=''T,'')','EDISCOBRAZ0','50','D','10','37',NULL,'Account Structure ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','38','(''DA''=''T'')','EDISCOBRAZ0','50','D','10','38',NULL,'Client Specific Data ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBEVENT]"','1','(''DA''=''T,'')','EDISCOBRAZ0','50','D','20','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEventType"','2','(''UA''=''T,'')','EDISCOBRAZ0','50','D','20','2',NULL,'Event Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEventDate"','3','(''UD101''=''T,'')','EDISCOBRAZ0','50','D','20','3',NULL,'Event Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrollmentDate"','4','(''UD101''=''T,'')','EDISCOBRAZ0','50','D','20','4',NULL,'Enrollment Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeSSN"','5','(''UA''=''T,'')','EDISCOBRAZ0','50','D','20','5',NULL,'Employee SSN ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeName"','6','(''UA''=''T,'')','EDISCOBRAZ0','50','D','20','6',NULL,'Employee Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','7','(''DA''=''T'')','EDISCOBRAZ0','50','D','20','7',NULL,'Second Event Original FDOC ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBPLANINITIAL]"','1','(''DA''=''T,'')','EDISCOBRAZ0','50','D','30','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPLanName"','2','(''UA''=''T,'')','EDISCOBRAZ0','50','D','30','2',NULL,'Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageLevel"','3','(''UA''=''T,'')','EDISCOBRAZ0','50','D','30','3',NULL,'Coverage Level',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','4','(''DA''=''T'')','EDISCOBRAZ0','50','D','30','4',NULL,'Number Of Units',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBDEPENDENT]"','1','(''DA''=''T,'')','EDISCOBRAZ0','50','D','40','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','2','(''UA''=''T,'')','EDISCOBRAZ0','50','D','40','2',NULL,'SSN ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelationship"','3','(''UA''=''T,'')','EDISCOBRAZ0','50','D','40','3',NULL,'Relationship ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','4','(''DA''=''T,'')','EDISCOBRAZ0','50','D','40','4',NULL,'Salutation ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','5','(''UA''=''T,'')','EDISCOBRAZ0','50','D','40','5',NULL,'First Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','6','(''UA''=''T,'')','EDISCOBRAZ0','50','D','40','6',NULL,'Middle Initial ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','7','(''UA''=''T,'')','EDISCOBRAZ0','50','D','40','7',NULL,'Last Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''DA''=''T,'')','EDISCOBRAZ0','50','D','40','8',NULL,'Email ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''DA''=''T,'')','EDISCOBRAZ0','50','D','40','9',NULL,'Phone ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''DA''=''T,'')','EDISCOBRAZ0','50','D','40','10',NULL,'Phone 2 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressSameAsQB"','11','(''UA''=''T,'')','EDISCOBRAZ0','50','D','40','11',NULL,'Address Same As QB ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','12','(''UA''=''T,'')','EDISCOBRAZ0','50','D','40','12',NULL,'Address 1 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','13','(''UA''=''T,'')','EDISCOBRAZ0','50','D','40','13',NULL,'Address 2 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','14','(''UA''=''T,'')','EDISCOBRAZ0','50','D','40','14',NULL,'City ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','15','(''UA''=''T,'')','EDISCOBRAZ0','50','D','40','15',NULL,'State Or Province ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','16','(''UA''=''T,'')','EDISCOBRAZ0','50','D','40','16',NULL,'Postal Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','17','(''DA''=''T,'')','EDISCOBRAZ0','50','D','40','17',NULL,'Country ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''DA''=''T,'')','EDISCOBRAZ0','50','D','40','18',NULL,'Enrollment Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSex"','19','(''UA''=''T,'')','EDISCOBRAZ0','50','D','40','19',NULL,'Sex ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','20','(''UD101''=''T,'')','EDISCOBRAZ0','50','D','40','20',NULL,'DOB ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"False"','21','(''DA''=''T'')','EDISCOBRAZ0','50','D','40','21',NULL,'Is QMCSO ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBDEPENDENTPLANINITIAL]"','1','(''DA''=''T,'')','EDISCOBRAZ0','50','D','50','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanName"','2','(''UA''=''T,'')','EDISCOBRAZ0','50','D','50','2',NULL,'Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[NPM]"','1','(''DA''=''T,'')','EDISCOBRAZ0','50','D','70','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','2','(''UA''=''T,'')','EDISCOBRAZ0','50','D','70','2',NULL,'SSN ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''DA''=''T,'')','EDISCOBRAZ0','50','D','70','3',NULL,'Individual Identifier ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mar-Bal Inc 22541"','4','(''DA''=''T,'')','EDISCOBRAZ0','50','D','70','4',NULL,'Client Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientDivisionName"','5','(''UA''=''T,'')','EDISCOBRAZ0','50','D','70','5',NULL,'Client Division Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','6','(''UA''=''T,'')','EDISCOBRAZ0','50','D','70','6',NULL,'First Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','7','(''UA''=''T,'')','EDISCOBRAZ0','50','D','70','7',NULL,'Middle Initial ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','8','(''UA''=''T,'')','EDISCOBRAZ0','50','D','70','8',NULL,'Last Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''DA''=''T,'')','EDISCOBRAZ0','50','D','70','9',NULL,'Salutation ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''DA''=''T,'')','EDISCOBRAZ0','50','D','70','10',NULL,'Email ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','11','(''DA''=''T,'')','EDISCOBRAZ0','50','D','70','11',NULL,'Phone ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','12','(''DA''=''T,'')','EDISCOBRAZ0','50','D','70','12',NULL,'Phone 2 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','13','(''UA''=''T,'')','EDISCOBRAZ0','50','D','70','13',NULL,'Address 1 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','14','(''UA''=''T,'')','EDISCOBRAZ0','50','D','70','14',NULL,'Address 2 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','15','(''UA''=''T,'')','EDISCOBRAZ0','50','D','70','15',NULL,'City ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','16','(''UA''=''T,'')','EDISCOBRAZ0','50','D','70','16',NULL,'State Or Province ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','17','(''UA''=''T,'')','EDISCOBRAZ0','50','D','70','17',NULL,'Postal Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''DA''=''T,'')','EDISCOBRAZ0','50','D','70','18',NULL,'Country ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSex"','19','(''UA''=''T,'')','EDISCOBRAZ0','50','D','70','19',NULL,'Sex ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TRUE"','20','(''DA''=''T,'')','EDISCOBRAZ0','50','D','70','20',NULL,'Uses Family In Address ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FALSE"','21','(''DA''=''T,'')','EDISCOBRAZ0','50','D','70','21',NULL,'Has Waived All Coverage ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TRUE"','22','(''DA''=''T,'')','EDISCOBRAZ0','50','D','70','22',NULL,'Send GR Notice ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHireDate"','23','(''UD101''=''T'')','EDISCOBRAZ0','50','D','70','23',NULL,'Hire Date ',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EDISCOBRA_20210713.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','202106241','EMPEXPORT','OEACTIVE','Jan  4 2021  1:02PM','EDISCOBRA',NULL,NULL,NULL,'202106241','Dec 22 2020  5:09PM','Dec 22 2020  5:09PM','202106241','302','','','202106241',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Passive Open Enrollment Export','202106241','EMPEXPORT','OEPASSIVE','Jan  4 2021  1:03PM','EDISCOBRA',NULL,NULL,NULL,'202106241','Dec 22 2020  5:09PM','Dec 22 2020  5:09PM','202106241','302','','','202106241',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Discovery Cobra Export','202106241','EMPEXPORT','ONDEM_XOE','Jan  4 2021  1:03PM','EDISCOBRA',NULL,NULL,NULL,'202106241','Dec 22 2020  5:09PM','Dec 22 2020  5:09PM','202106241','308','','','202106241',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Discovery Cobra Export-Sched','202106241','EMPEXPORT','SCH_EDISCO','Jan  4 2021  1:03PM','EDISCOBRA',NULL,NULL,NULL,'202106241','Dec 22 2020  5:09PM','Dec 22 2020  5:09PM','202106241','308','','','202106241',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Discovery Cobra Export-Test','202006241','EMPEXPORT','TEST_XOE','Jul  6 2021  8:34PM','EDISCOBRA',NULL,NULL,NULL,'202006241','Jul  7 2021 12:00AM','Dec 30 1899 12:00AM','202106241','7','','','202106241',dbo.fn_GetTimedKey(),NULL,'us3cPeMAR1020',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCOBRA','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCOBRA','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCOBRA','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCOBRA','NoEmpty','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCOBRA','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCOBRA','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EDISCOBRA' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EDISCOBRA' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EDISCOBRA_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EDISCOBRA_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCOBRA','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCOBRA','D10','dbo.U_EDISCOBRA_drvTbl_QB',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCOBRA','D20','dbo.U_EDISCOBRA_drvTbl_QBEVENT',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCOBRA','D30','dbo.U_EDISCOBRA_drvTbl_QBPLANINITIAL',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCOBRA','D40','dbo.U_EDISCOBRA_drvTbl_QBDEPENDENT',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCOBRA','D50','dbo.U_EDISCOBRA_drvTbl_QBDEPENDENTPLANINITIAL',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCOBRA','D70','dbo.U_EDISCOBRA_drvTbl_NPM',NULL);
IF OBJECT_ID('U_dsi_BDM_EDISCOBRA') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EDISCOBRA] (
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
IF OBJECT_ID('U_EDISCOBRA_DedList') IS NULL
CREATE TABLE [dbo].[U_EDISCOBRA_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EDISCOBRA_drvTbl_NPM') IS NULL
CREATE TABLE [dbo].[U_EDISCOBRA_drvTbl_NPM] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvClientDivisionName] varchar(9) NULL,
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
IF OBJECT_ID('U_EDISCOBRA_drvTbl_QB') IS NULL
CREATE TABLE [dbo].[U_EDISCOBRA_drvTbl_QB] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvSort] varchar(16) NULL,
    [drvBdmCobraReason] char(6) NULL,
    [drvClientDivisionName] varchar(9) NULL,
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
IF OBJECT_ID('U_EDISCOBRA_drvTbl_QBDEPENDENT') IS NULL
CREATE TABLE [dbo].[U_EDISCOBRA_drvTbl_QBDEPENDENT] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(31) NULL,
    [drvSSN] char(11) NULL,
    [drvRelationship] varchar(15) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(102) NULL,
    [drvAddressSameAsQB] varchar(4) NOT NULL,
    [drvAddressLine1] varchar(1) NOT NULL,
    [drvAddressLine2] varchar(1) NOT NULL,
    [drvAddressCity] varchar(1) NOT NULL,
    [drvAddressState] varchar(1) NOT NULL,
    [drvAddressZipCode] varchar(1) NOT NULL,
    [drvSex] varchar(1) NULL,
    [drvDateOfBirth] datetime NULL
);
IF OBJECT_ID('U_EDISCOBRA_drvTbl_QBDEPENDENTPLANINITIAL') IS NULL
CREATE TABLE [dbo].[U_EDISCOBRA_drvTbl_QBDEPENDENTPLANINITIAL] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(31) NULL,
    [drvPlanName] varchar(32) NULL,
    [drvCoverageLevel] varchar(11) NULL
);
IF OBJECT_ID('U_EDISCOBRA_drvTbl_QBEVENT') IS NULL
CREATE TABLE [dbo].[U_EDISCOBRA_drvTbl_QBEVENT] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvSort] varchar(16) NULL,
    [drvEventType] varchar(39) NOT NULL,
    [drvEventDate] datetime NULL,
    [drvEnrollmentDate] datetime NULL,
    [drvEmployeeSSN] char(11) NULL,
    [drvEmployeeName] varchar(203) NOT NULL
);
IF OBJECT_ID('U_EDISCOBRA_drvTbl_QBPLANINITIAL') IS NULL
CREATE TABLE [dbo].[U_EDISCOBRA_drvTbl_QBPLANINITIAL] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvSort] varchar(16) NULL,
    [drvPLanName] varchar(32) NULL,
    [drvCoverageLevel] varchar(11) NULL
);
IF OBJECT_ID('U_EDISCOBRA_EEList') IS NULL
CREATE TABLE [dbo].[U_EDISCOBRA_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EDISCOBRA_File') IS NULL
CREATE TABLE [dbo].[U_EDISCOBRA_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EDISCOBRA]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Mar-Bal

Created By: Keary McCutchen
Business Analyst: Cheryl Petitti
Create Date: 05/25/2021
Service Request Number: TekP-2021-04-08-0006

Purpose: Discovery Cobra Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EDISCOBRA';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EDISCOBRA';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EDISCOBRA';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EDISCOBRA';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EDISCOBRA' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISCOBRA', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISCOBRA', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISCOBRA', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISCOBRA', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISCOBRA', 'SCH_EDSICC';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EDISCOBRA';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EDISCOBRA', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EDISCOBRA';

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
    DELETE FROM dbo.U_EDISCOBRA_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EDISCOBRA_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_EDISCOBRA_EEList WHERE xEEID IN (
        SELECT DISTINCT EecEEID  FROM dbo.EmpComp WITH (NOLOCK) WHERE EecEEType IN ('TES')
    )

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'MBMO, MBOH, MBOHO, MBVA, MBUMO, MBUOH, MBUO, MBUVA, MHSMO, MHSOH, MHSO, MHSVA, DNBUO, DENBU, DENB, VIS, VISO';

    IF OBJECT_ID('U_EDISCOBRA_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCOBRA_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EDISCOBRA_DedList
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
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'CobraReasonsDep',  '201,204,210,LEVNT3,LEVNT4,200')
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraReasonsDepPQB','201,204,210,LEVNT3,LEVNT4'); -- 
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidCobraReasonsEmp','201,204,210,LEVNT3,LEVNT4'); --,302');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidTermReasonsEmp','203'); -- Invalidate employee when Cobra Reason is "Death".  

    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CountDependents','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'ConCobraReasonPCF','DependentCOBRAReason'); -- Valid dependent PQB reasons
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS'); -- update to the spouse relationship code
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','CH,CHL,DPC,STC'); -- update to the child relationship codes
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP'); -- update to the domestic partner relationship code
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
    -- Insert into BDM Reason code 302 AND 201
    --==========================================
    INSERT INTO [dbo].[U_dsi_BDM_EDISCOBRA]
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
        ,dbnCoID
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
        AND DbnTVStartDate BETWEEN @startdate AND @enddate 
        AND dbnValidForExport = 'N'
        AND DbnDedCode = EdhDedCode
    GROUP BY dbnCoid,dbneeid,DbnDepRecID,DbnRelationship,DbnDateOfBirth,dbnDedcode, edhBenStopDate,edhEffDate,edhStartDate,edhStopDate,edhbenoption

    --==========================================
    -- Insert into BDM Reason code 201
    --==========================================
    INSERT INTO [dbo].[U_dsi_BDM_EDISCOBRA]
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
        ,dbnCoID
        ,dbneeid
        ,DbnDepRecID
        ,DbnDepRecID
        ,'QB'
        ,'Data Inserted for 201 Chg reason'
        ,DbnRelationship
        ,DbnDateOfBirth
        ,DbnDedcode
        ,(SELECT TOP 1 edhBenStartDate FROM dbo.Emphded A WITH (NOLOCK) WHERE A.edhdedcode = dbnDedcode and A.edheeid =  dbneeid and A.edhcoid = dbncoid ORDER BY Auditkey ASC ) AS bdmBenstartDate
        ,edhBenStopDate
        ,edhEffDate
        ,'201'
        ,'201'
        ,edhStartDate
        ,edhStopDate
        ,CASE WHEN dbnRelationShip  IN ('CH','CHL','DPC','STC') THEN 'Y' ELSE 'N' END
        ,edhbenoption
    FROM dbo.emphded WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_DepDeductions 
        ON dbneeid = edheeid 
        AND dbnformatcode = @FormatCode
    WHERE edhChangeReason in ('201') 
        AND DbnTVStartDate BETWEEN @startdate AND @enddate 
        AND dbnValidForExport = 'N'
        AND DbnDedCode = EdhDedCode
        AND DbnRelationship  IN ('CH','CHL','DPC','STC')
    GROUP BY dbnCoid,dbneeid,DbnDepRecID,DbnRelationship,DbnDateOfBirth,dbnDedcode, edhBenStopDate,edhEffDate,edhStartDate,edhStopDate,edhbenoption

    --==========================================
    -- Insert into BDM Reason code 204
    --==========================================
    INSERT INTO [dbo].[U_dsi_BDM_EDISCOBRA]
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
        ,dbnCoID
        ,dbneeid
        ,DbnDepRecID
        ,DbnDepRecID
        ,'QB'
        ,'Data Inserted for 204 Chg reason'
        ,DbnRelationship
        ,DbnDateOfBirth
        ,DbnDedcode
        ,(SELECT TOP 1 edhBenStartDate FROM dbo.Emphded A WITH (NOLOCK) WHERE A.edhdedcode = dbnDedcode and A.edheeid =  dbneeid and A.edhcoid = dbncoid ORDER BY Auditkey ASC ) AS bdmBenstartDate
        ,edhBenStopDate
        ,edhEffDate
        ,'204'
        ,'204'
        ,edhStartDate
        ,edhStopDate
        ,CASE WHEN dbnRelationShip = 'SPS' THEN 'Y' ELSE 'N' END
        ,edhbenoption
    FROM dbo.emphded WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_DepDeductions 
        ON dbneeid = edheeid 
        AND dbnformatcode = @FormatCode
    WHERE edhChangeReason in ('204') 
        AND DbnTVStartDate BETWEEN @startdate AND @enddate 
        AND dbnValidForExport = 'N'
        AND DbnDedCode = EdhDedCode
    GROUP BY dbnCoid,dbneeid, DbnDepRecID,DbnRelationship,DbnDateOfBirth,dbnDedcode,edhBenStopDate,edhEffDate,edhStartDate,edhStopDate,edhbenoption


    DELETE FROM dbo.U_dsi_BDM_EDISCOBRA WHERE bdmdedcode NOT IN  (SELECT DISTINCT Dedcode FROM dbo.U_EDISCOBRA_DedList)
    
    UPDATE dbo.U_dsi_BDM_EDISCOBRA 
        SET bdmNumSpouses = (SELECT COUNT(*) FROM dbo.U_dsi_BDM_EDISCOBRA A WHERE A.bdmeeid = X.bdmeeid AND bdmRelationship = 'SPS' AND A.bdmcoid = X.bdmcoid)
            ,bdmNumChildren = (SELECT COUNT(*) FROM dbo.U_dsi_BDM_EDISCOBRA A WHERE A.bdmeeid = X.bdmeeid AND bdmRelationship = 'CHL' AND A.bdmcoid = X.bdmcoid)
    FROM dbo.U_dsi_BDM_EDISCOBRA  X
    WHERE BdmDedRowStatus IN ('Data Inserted for 302 Chg reason','Data Inserted for 201 Chg reason','Data Inserted for 204 Chg reason')

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EDISCOBRA_drvTbl_QB
    ---------------------------------
    IF OBJECT_ID('U_EDISCOBRA_drvTbl_QB','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCOBRA_drvTbl_QB;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSort = '3 ' + xEEID + ' 1'
        ,drvBdmCobraReason = BdmCobraReason
        -- standard fields above and additional driver fields below
        ,drvClientDivisionName =    CASE WHEN EecOrgLvl1 IN ('MO') THEN 'Missouri'
                                    WHEN EecOrgLvl1 IN ('OH') THEN 'Ohio'
                                    WHEN EecOrgLvl1 IN ('CORP') THEN 'Queensway'
                                    WHEN EecOrgLvl1 IN ('VA') THEN 'Virginia'
                                    WHEN EecOrgLvl1 IN ('BMC') THEN 'Altraset'
                                    WHEN EecOrgLvl1 IN ('CA') THEN 'Lattice'
                                END    
        ,drvNameFirst = CASE WHEN BdmCobraReason IN ('LEVNT3','LEVNT4','204','210','302') OR (ConRelationship IN ('CH','CHL','DPC','STC') OR (edhChangeReason = '201' AND ConDepNo = 1)) THEN ConNameFirst ELSE EepNameFirst END
        ,drvNameMiddle = CASE WHEN BdmCobraReason IN ('LEVNT3','LEVNT4','204','210','302')  OR (ConRelationship IN ('CH','CHL','DPC','STC') OR (edhChangeReason = '201' AND ConDepNo = 1)) THEN LEFT(ConNameMiddle, 1) ELSE LEFT(EepNameMiddle,1) END
        ,drvNameLast = '"' + CASE WHEN BdmCobraReason IN ('LEVNT3','LEVNT4','204','210','302') OR (ConRelationship IN ('CH','CHL','DPC','STC') OR (edhChangeReason = '201' AND ConDepNo = 1)) THEN ConNameLast ELSE EepNameLast END + '"'
        ,drvSsn = CASE WHEN BdmCobraReason IN ('LEVNT3','LEVNT4','204','210','302')  OR (ConRelationship IN ('CH','CHL','DPC','STC') OR (edhChangeReason = '201' AND ConDepNo = 1)) THEN ConSSN ELSE EepSsn END
        ,drvAddressLine1 = REPLACE(CASE WHEN BdmCobraReason IN ('LEVNT3','LEVNT4','204','210','302') OR (ConRelationship IN ('CH','CHL','DPC','STC') OR (edhChangeReason = '201' AND ConDepNo = 1)) THEN ConAddressLine1 ELSE EepAddressLine1 END, ',', '')
        ,drvAddressLine2 = REPLACE(CASE WHEN BdmCobraReason IN ('LEVNT3','LEVNT4','204','210','302')  OR (ConRelationship IN ('CH','CHL','DPC','STC') OR (edhChangeReason = '201' AND ConDepNo = 1)) THEN ConAddressLIne2 ELSE EepAddressLine2 END, ',', '')
        ,drvAddressCity = CASE WHEN BdmCobraReason IN ('LEVNT3','LEVNT4','204','210','302') OR (ConRelationship IN ('CH','CHL','DPC','STC') OR (edhChangeReason = '201' AND ConDepNo = 1)) THEN ConAddressCity ELSE EepAddressCity END
        ,drvAddressState = CASE WHEN BdmCobraReason IN ('LEVNT3','LEVNT4','204','210','302')  OR (ConRelationship IN ('CH','CHL','DPC','STC') OR (edhChangeReason = '201' AND ConDepNo = 1)) THEN ConAddressState ELSE EepAddressState END
        ,drvAddressZipCode = CASE WHEN BdmCobraReason IN ('LEVNT3','LEVNT4','204','302')  OR (ConRelationship IN ('CH','CHL','DPC','STC') OR (edhChangeReason = '201' AND ConDepNo = 1)) THEN ConAddressZipCode ELSE EepAddressZipCode END
        ,drvSex =    CASE WHEN BdmCobraReason IN ('LEVNT3','LEVNT4','204','210','302')  OR (ConRelationship IN ('CH','CHL','DPC','STC') OR (edhChangeReason = '201' AND ConDepNo = 1)) THEN 
                            CASE WHEN ConGender IN ('M','F') THEN ConGender ELSE 'U' END
                        ELSE 
                            CASE WHEN EepGender IN ('M','F') THEN EepGender ELSE 'U' END                         
                    END
        ,drvDateOfBirth = CASE WHEN BdmCobraReason IN ('LEVNT3','LEVNT4','204','210','302') OR (ConRelationship IN ('CH','CHL','DPC','STC') OR (edhChangeReason = '201' AND ConDepNo = 1)) THEN ConDateOfBirth ELSE EepDateOfBirth END 
    INTO dbo.U_EDISCOBRA_drvTbl_QB
    FROM dbo.U_EDISCOBRA_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
       AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EDISCOBRA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND (BdmCoID = xCoID OR BdmCobraReason IN ('302','201'))
        AND BdmRunId = 'QB'
    JOIN (
            SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent 
            FROM (
                    SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent, ROW_NUMBER() OVER (PARTITION by EdhEEID, EdhCOID ORDER BY EdhEffDate desc) AS RN
                    FROM dbo.EmpHDed a WITH (NOLOCK)
                    JOIN dbo.BenChRsn WITH (NOLOCK)
                        ON EdhChangeReason = BchCode
                    WHERE EdhDedCode IN ('MBMO', 'MBOH', 'MBOHO', 'MBVA', 'MBUMO', 'MBUOH', 'MBUO', 'MBUVA', 'MHSMO', 'MHSOH', 'MHSO', 'MHSVA', 'DNBUO', 'DENBU', 'DENB', 'VIS', 'VISO') 
                        AND edhChangeReason IN ('201','204','210','LEVNT3','LEVNT4','200','302')
                        AND BchIsCobraQualifiedEvent = 'Y') AS T
                         WHERE RN = 1
            ) AS ChgReason
        ON EdhEEID = xEEID
        AND EdhCOID = xCOID
    LEFT JOIN (SELECT ConEEID
                ,ConSystemID
                ,ConNameFirst
                ,ConNameMiddle
                ,ConNameLast
                ,ConRelationship
                ,ConSSN
                ,ConAddressLine1
                ,ConAddressLIne2
                ,ConAddressCity
                ,ConAddressState
                ,ConAddressZipCode
                ,ConGender 
                ,ConDateOfBirth 
                ,ConDepNo = ROW_NUMBER() OVER (PARTITION BY RTRIM(ConEEID) ORDER BY conDateOfBirth ASC) 
              FROM dbo.Contacts WITH (NOLOCK)
             WHERE ConRelationship IN ('CH','CHL','DPC','STC')
            UNION
            SELECT ConEEID
                ,ConSystemID
                ,ConNameFirst
                ,ConNameMiddle
                ,ConNameLast
                ,ConRelationship
                ,ConSSN
                ,ConAddressLine1
                ,ConAddressLIne2
                ,ConAddressCity
                ,ConAddressState
                ,ConAddressZipCode
                ,ConGender 
                ,ConDateOfBirth 
                ,ConDepNo = 0
              FROM dbo.Contacts WITH (NOLOCK)
             WHERE ConRelationship IN ('SPS','DP')
              ) DEP
            ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecId
    WHERE (BdmCobraReason <> '302' OR (BdmCobraReason = '302' AND ConRelationship IN ('SPS','DP')))
    AND  (BdmCobraReason <> '201' OR (BdmCobraReason = '201' AND ConDepNo = 1 AND ConRelationship IN  ('CH','CHL','DPC','STC')))
    AND (BdmCobraReason <> '204' OR (BdmCobraReason = '204' AND ConRelationship IN  ('SPS','DP')))
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EDISCOBRA_drvTbl_QBEVENT
    ---------------------------------
    IF OBJECT_ID('U_EDISCOBRA_drvTbl_QBEVENT','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCOBRA_drvTbl_QBEVENT;
    SELECT DISTINCT
         drvEEID = drvEEID
        ,drvCoID = drvCoID
        ,drvSort = '3 ' + drvEEID + ' 2'
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
                            WHEN EdhChangeReason IN ('LEVNT3','LEVNT4','204','210','201','302') THEN COALESCE(ConCobraStatusDate,DbnBenStopDate,edhEffDate)
                            ELSE EepDateOFCobraEvent
                        END
        --CASE WHEN EdhChangeReason IN ('LEVNT3','LEVNT4','204','210','201','302') THEN ConCobraStatusDate ELSE BdmDateOfCobraEvent END
        ,drvEnrollmentDate = CASE WHEN EdhChangeReason IN ('LEVNT3','LEVNT4','204','210','201','302') THEN /*ConBenStartDate*/ BdmBenStartDate ELSE BdmBenStartDate END
        ,drvEmployeeSSN = eepSSN
        ,drvEmployeeName = '"' + ISNULL(EepNameFirst, '') + ' ' + ISNULL(EepNameLast, '') + '"'
    INTO dbo.U_EDISCOBRA_drvTbl_QBEVENT
    FROM dbo.U_EDISCOBRA_drvTbl_QB WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = drvEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = drvEEID
        AND EecCOID = drvCOID
/*    JOIN dbo.U_dsi_BDM_EDISCOBRA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRunId = 'QB'*/
    JOIN (
            SELECT BdmEEID, BdmCOID, BdmDepRecId, MAX(BdmBenStartDate) AS BdmBenStartDate, MAX(BdmDateOfCobraEvent) AS BdmDateOfCobraEvent
            FROM dbo.U_dsi_BDM_EDISCOBRA WITH (NOLOCK)
            WHERE BdmRunId = 'QB'
            GROUP BY BdmEEID, BdmCOID, BdmDepRecId) AS BDM
        ON BdmEEID = drvEEID 
        AND BdmCoID = drvCoID
    LEFT
    JOIN (SELECT DbnEEID, DbnCOID, DbnDepRecID, MAX(DbnBenStopDate) AS DbnBenStopDate 
            FROM dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
            WHERE DbnRunId = 'QB'
            GROUP BY DbnEEID, DbnCOID, DbnDepRecID) AS DBN
        ON DbnEEID =drvEEID 
        AND DbnCOID = drvCoID
        AND DbnDepRecID = BdmDepRecId
    JOIN (
            SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent 
            FROM (
                    SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent, ROW_NUMBER() OVER (PARTITION by EdhEEID, EdhCOID ORDER BY EdhEffDate desc) AS RN
                    FROM dbo.EmpHDed a WITH (NOLOCK)
                    JOIN dbo.BenChRsn WITH (NOLOCK)
                        ON EdhChangeReason = BchCode
                    WHERE EdhDedCode IN ('MBMO', 'MBOH', 'MBOHO', 'MBVA', 'MBUMO', 'MBUOH', 'MBUO', 'MBUVA', 'MHSMO', 'MHSOH', 'MHSO', 'MHSVA', 'DNBUO', 'DENBU', 'DENB', 'VIS', 'VISO') 
                        AND edhChangeReason IN ('201','204','210','LEVNT3','LEVNT4','200')
                        AND BchIsCobraQualifiedEvent = 'Y') AS T
            WHERE RN = 1
            ) AS ChgReason
        ON EdhEEID = drvEEID
        AND EdhCOID = drvCOID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = drvEEID
        AND ConSystemID = BdmDepRecId

    ;
    ---------------------------------
    -- DETAIL RECORD - U_EDISCOBRA_drvTbl_QBPLANINITIAL
    ---------------------------------
    IF OBJECT_ID('U_EDISCOBRA_drvTbl_QBPLANINITIAL','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCOBRA_drvTbl_QBPLANINITIAL;
    SELECT DISTINCT
         drvEEID = drvEEID
        ,drvCoID = drvCoID
        ,drvSort = '3 ' + drvEEID + ' 3'
        -- standard fields above and additional driver fields below
        ,drvPLanName =    CASE WHEN BdmDedCode IN ('MBMO', 'MBOH', 'MBOHO', 'MBVA') THEN 'Cigna Medical OAP Basic HSA Plan'
                               WHEN BdmDedCode IN ('MBUMO', 'MBUOH', 'MBUO', 'MBUVA') THEN 'Cigna Medical OAP Buy Up Plan'
                               WHEN BdmDedCode IN ('MHSMO', 'MHSOH', 'MHSO', 'MHSVA') THEN 'Cigna Medical OAP Value HSA Plan'
                               WHEN BdmDedCode IN ('DNBUO', 'DENBU') THEN 'Guardian Dental High Plan'
                               WHEN BdmDedCode IN ('DENB') THEN 'Guardian Dental Low Plan'
                               WHEN BdmDedCode IN ('VIS', 'VISO') THEN 'Guardian Vision Plan'
                        END
        ,drvCoverageLevel =    CASE 
                                WHEN BdmCobraReason IN ('201') THEN 'EE'
                                WHEN BdmBenOption IN ('EE','EET') THEN 'EE'
                                WHEN BdmBenOption IN ('EEC','EECT') THEN 'EE+CHILDREN'
                                WHEN BdmBenOption IN ('EEF','EEFT') THEN 'EE+FAMILY'
                                WHEN BdmBenOption IN ('EES','EEST') THEN 'EE+SPOUSE'                                
                            END
    INTO dbo.U_EDISCOBRA_drvTbl_QBPLANINITIAL
    FROM U_EDISCOBRA_drvTbl_QB WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EDISCOBRA WITH (NOLOCK)
        ON BdmEEID = drvEEID 
        AND BdmCoID = drvCoID
    WHERE BdmRunID = 'QB'
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EDISCOBRA_drvTbl_QBDEPENDENT
    ---------------------------------
    IF OBJECT_ID('U_EDISCOBRA_drvTbl_QBDEPENDENT','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCOBRA_drvTbl_QBDEPENDENT;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '3 ' + xEEID + ' 4 ' + BdmDepRecId + ' 1'
        -- standard fields above and additional driver fields below
        ,drvSSN = ConSSN -- ConSSN
        ,drvRelationship =    CASE WHEN ConRelationship = 'SPS' THEN 'SPOUSE'
                                WHEN ConRelationship = 'DP' THEN 'DOMESTICPARTNER'
                                WHEN ConRelationship IN ('CH','CHL','DPC','STC') THEN 'CHILD'
                            END
        ,drvNameFirst = ConNameFirst
        ,drvNameMiddle = LEFT(ConNameMiddle,1)
        ,drvNameLast = '"' + ConNameLast + '"'
        ,drvAddressSameAsQB = CASE WHEN ConAddressIsDifferent = 'N' THEN 'TRUE' ELSE 'FALS' END
        ,drvAddressLine1 = ''--CASE WHEN ConAddressIsDifferent = 'NO' THEN EepAddressLine1 ELSE ConAddressLine1 END
        ,drvAddressLine2 = ''--CASE WHEN ConAddressIsDifferent = 'NO' THEN EepAddressLine2 ELSE ConAddressLine2 END
        ,drvAddressCity = ''--CASE WHEN ConAddressIsDifferent = 'NO' THEN EepAddressCity ELSE ConAddressCity END
        ,drvAddressState = ''--CASE WHEN ConAddressIsDifferent = 'NO' THEN EepAddressState ELSE ConAddressState END
        ,drvAddressZipCode = ''--CASE WHEN ConAddressIsDifferent = 'NO' THEN EepAddressZipCode ELSE ConAddressZipCode END
        ,drvSex = CASE WHEN ConGender IN ('M','F') THEN ConGender ELSE 'U' END
        ,drvDateOfBirth = ConDateOfBirth
    INTO dbo.U_EDISCOBRA_drvTbl_QBDEPENDENT
    FROM dbo.U_EDISCOBRA_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EDISCOBRA WITH (NOLOCK)
                ON BdmEEID = xEEID 
         AND (BdmCoID = xCoID OR BdmCobraReason IN ('204'))
        AND BdmRecType = 'DEP'
        AND BdmRunId = 'QB'
        AND BdmIsPQB = 'N'
        AND BdmCobraReason NOT IN ('201')
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecId
    WHERE (BdmCobraReason <> '302' OR (BdmCobraReason = '302' AND ConRelationship NOT IN ('SPS','DP')))
    ; 
    ---------------------------------
    -- DETAIL RECORD - U_EDISCOBRA_drvTbl_QBDEPENDENTPLANINITIAL
    ---------------------------------
    IF OBJECT_ID('U_EDISCOBRA_drvTbl_QBDEPENDENTPLANINITIAL','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCOBRA_drvTbl_QBDEPENDENTPLANINITIAL;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '3 ' + xEEID + ' 4 ' + BdmDepRecId + ' 2'
        -- standard fields above and additional driver fields below
        ,drvPlanName =    CASE WHEN BdmDedCode IN ('MBMO', 'MBOH', 'MBOHO', 'MBVA') THEN 'Cigna Medical OAP Basic HSA Plan'
                               WHEN BdmDedCode IN ('MBUMO', 'MBUOH', 'MBUO', 'MBUVA') THEN 'Cigna Medical OAP Buy Up Plan'
                               WHEN BdmDedCode IN ('MHSMO', 'MHSOH', 'MHSO', 'MHSVA') THEN 'Cigna Medical OAP Value HSA Plan'
                               WHEN BdmDedCode IN ('DNBUO', 'DENBU') THEN 'Guardian Dental High Plan'
                               WHEN BdmDedCode IN ('DENB') THEN 'Guardian Dental Low Plan'
                               WHEN BdmDedCode IN ('VIS', 'VISO') THEN 'Guardian Vision Plan'
                        END
        ,drvCoverageLevel =    CASE WHEN BdmBenOption IN ('EE','EET') THEN 'EE'
                                WHEN BdmBenOption IN ('EEC','EECT') THEN 'EE+CHILDREN'
                                WHEN BdmBenOption IN ('EEF','EEFT') THEN 'EE+FAMILY'
                                WHEN BdmBenOption IN ('EES','EEST') THEN 'EE+SPOUSE'                                
                            END
    INTO dbo.U_EDISCOBRA_drvTbl_QBDEPENDENTPLANINITIAL
    FROM dbo.U_EDISCOBRA_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EDISCOBRA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND (BdmCoID = xCoID OR BdmCobraReason IN ('204'))
        AND BdmRecType = 'DEP'
        AND BdmRunId = 'QB'
        AND BdmIsPQB = 'N'
        AND BdmCobraReason NOT IN ('201')
    ;
    
    ---------------------------------
    -- DETAIL RECORD - U_EDISCOBRA_drvTbl_NPM
    ---------------------------------
    IF OBJECT_ID('U_EDISCOBRA_drvTbl_NPM','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCOBRA_drvTbl_NPM;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '2'
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvClientDivisionName =    CASE WHEN EecOrgLvl1 IN ('MO') THEN 'Missouri'
                                    WHEN EecOrgLvl1 IN ('OH') THEN 'Ohio'
                                    WHEN EecOrgLvl1 IN ('CORP') THEN 'Queensway'
                                    WHEN EecOrgLvl1 IN ('VA') THEN 'Virginia'
                                    WHEN EecOrgLvl1 IN ('BMC') THEN 'Altraset'
                                    WHEN EecOrgLvl1 IN ('CA') THEN 'Lattice'
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
    INTO dbo.U_EDISCOBRA_drvTbl_NPM
    FROM dbo.U_EDISCOBRA_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EDISCOBRA WITH (NOLOCK)
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
                    WHERE EdhDedCode IN ('MBMO', 'MBOH', 'MBOHO', 'MBVA', 'MBUMO', 'MBUOH', 'MBUO', 'MBUVA', 'MHSMO', 'MHSOH', 'MHSO', 'MHSVA', 'DNBUO', 'DENBU', 'DENB', 'VIS', 'VISO') 
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
ALTER VIEW dbo.dsi_vwEDISCOBRA_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EDISCOBRA_File (NOLOCK)
    ORDER BY  InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EDISCOBRA%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202106241'
       ,expStartPerControl     = '202106241'
       ,expLastEndPerControl   = '202106241'
       ,expEndPerControl       = '202106241'
WHERE expFormatCode = 'EDISCOBRA';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEDISCOBRA_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EDISCOBRA_File (NOLOCK)
    ORDER BY  InitialSort, SubSort;