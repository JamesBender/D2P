SET NOCOUNT ON;
IF OBJECT_ID('U_ECCICSCEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECCICSCEXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ECCICSCEXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ECCICSCEXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwECCICSCEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECCICSCEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECCICSCEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECCICSCEXP];
GO
IF OBJECT_ID('U_ECCICSCEXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ECCICSCEXP_PEarHist];
GO
IF OBJECT_ID('U_ECCICSCEXP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ECCICSCEXP_PDedHist];
GO
IF OBJECT_ID('U_ECCICSCEXP_File') IS NOT NULL DROP TABLE [dbo].[U_ECCICSCEXP_File];
GO
IF OBJECT_ID('U_ECCICSCEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECCICSCEXP_EEList];
GO
IF OBJECT_ID('U_ECCICSCEXP_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL') IS NOT NULL DROP TABLE [dbo].[U_ECCICSCEXP_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL];
GO
IF OBJECT_ID('U_ECCICSCEXP_drvTbl_QBPLANINITIAL') IS NOT NULL DROP TABLE [dbo].[U_ECCICSCEXP_drvTbl_QBPLANINITIAL];
GO
IF OBJECT_ID('U_ECCICSCEXP_drvTbl_QBPLAN2') IS NOT NULL DROP TABLE [dbo].[U_ECCICSCEXP_drvTbl_QBPLAN2];
GO
IF OBJECT_ID('U_ECCICSCEXP_drvTbl_QBPLAN') IS NOT NULL DROP TABLE [dbo].[U_ECCICSCEXP_drvTbl_QBPLAN];
GO
IF OBJECT_ID('U_ECCICSCEXP_drvTbl_QBMSRI') IS NOT NULL DROP TABLE [dbo].[U_ECCICSCEXP_drvTbl_QBMSRI];
GO
IF OBJECT_ID('U_ECCICSCEXP_drvTbl_QBEVENT') IS NOT NULL DROP TABLE [dbo].[U_ECCICSCEXP_drvTbl_QBEVENT];
GO
IF OBJECT_ID('U_ECCICSCEXP_drvTbl_QBDEPPLAN') IS NOT NULL DROP TABLE [dbo].[U_ECCICSCEXP_drvTbl_QBDEPPLAN];
GO
IF OBJECT_ID('U_ECCICSCEXP_drvTbl_QBDEPENDENTPLANINITIAL') IS NOT NULL DROP TABLE [dbo].[U_ECCICSCEXP_drvTbl_QBDEPENDENTPLANINITIAL];
GO
IF OBJECT_ID('U_ECCICSCEXP_drvTbl_QBDEPENDENT') IS NOT NULL DROP TABLE [dbo].[U_ECCICSCEXP_drvTbl_QBDEPENDENT];
GO
IF OBJECT_ID('U_ECCICSCEXP_drvTbl_QBDEP') IS NOT NULL DROP TABLE [dbo].[U_ECCICSCEXP_drvTbl_QBDEP];
GO
IF OBJECT_ID('U_ECCICSCEXP_drvTbl_QB') IS NOT NULL DROP TABLE [dbo].[U_ECCICSCEXP_drvTbl_QB];
GO
IF OBJECT_ID('U_ECCICSCEXP_drvTbl_NPM') IS NOT NULL DROP TABLE [dbo].[U_ECCICSCEXP_drvTbl_NPM];
GO
IF OBJECT_ID('U_ECCICSCEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_ECCICSCEXP_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_ECCICSCEXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ECCICSCEXP];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ECCICSCEXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ECCICSCEXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ECCICSCEXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ECCICSCEXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ECCICSCEXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ECCICSCEXP','CobraSecure QB Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','ECCICSCEXPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ECCICSCEXP' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[VERSION]"','1','(''DA''=''Q,'')','ECCICSCEXPZ0','50','H','01','1',NULL,'Version Line Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"1.1"','2','(''DA''=''Q'')','ECCICSCEXPZ0','50','H','01','2',NULL,'Version Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QB]"','1','(''DA''=''Q,'')','ECCICSCEXPZ0','50','D','10','1',NULL,'Record Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientName"','2','(''UA''=''Q,'')','ECCICSCEXPZ0','100','D','10','2',NULL,'ClientName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientDivName"','3','(''UA''=''Q,'')','ECCICSCEXPZ0','50','D','10','3',NULL,'ClientDivisionName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','4','(''SS''=''Q,'')','ECCICSCEXPZ0','50','D','10','4',NULL,'Salutation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','5','(''UA''=''Q,'')','ECCICSCEXPZ0','50','D','10','5',NULL,'FirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','6','(''UA''=''Q,'')','ECCICSCEXPZ0','50','D','10','6',NULL,'MiddleInitial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','7','(''UA''=''Q,'')','ECCICSCEXPZ0','50','D','10','7',NULL,'LastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','8','(''UA''=''Q,'')','ECCICSCEXPZ0','50','D','10','8',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpNo"','9','(''UA''=''Q,'')','ECCICSCEXPZ0','50','D','10','9',NULL,'IndividualID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmailAddress"','10','(''UA''=''Q,'')','ECCICSCEXPZ0','50','D','10','10',NULL,'Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhone"','11','(''UA''=''Q,'')','ECCICSCEXPZ0','50','D','10','11',NULL,'Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhone2"','12','(''UA''=''Q,'')','ECCICSCEXPZ0','50','D','10','12',NULL,'Phone2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','13','(''UA''=''Q,'')','ECCICSCEXPZ0','50','D','10','13',NULL,'Address1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','14','(''UA''=''Q,'')','ECCICSCEXPZ0','50','D','10','14',NULL,'Address2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','15','(''UA''=''Q,'')','ECCICSCEXPZ0','50','D','10','15',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','16','(''UA''=''Q,'')','ECCICSCEXPZ0','50','D','10','16',NULL,'StateOrProvince',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','17','(''UA''=''Q,'')','ECCICSCEXPZ0','50','D','10','17',NULL,'PostalCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''SS''=''Q,'')','ECCICSCEXPZ0','50','D','10','18',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TRUE"','19','(''DA''=''Q,'')','ECCICSCEXPZ0','50','D','10','19',NULL,'PremiumAddressSameAsPrimary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','20','(''SS''=''Q,'')','ECCICSCEXPZ0','50','D','10','20',NULL,'PremiumAddress1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','21','(''SS''=''Q,'')','ECCICSCEXPZ0','50','D','10','21',NULL,'PremiumAddress2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','22','(''SS''=''Q,'')','ECCICSCEXPZ0','50','D','10','22',NULL,'PremiumCity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','23','(''SS''=''Q,'')','ECCICSCEXPZ0','50','D','10','23',NULL,'PremiumStateOrProvince',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','24','(''SS''=''Q,'')','ECCICSCEXPZ0','50','D','10','24',NULL,'PremiumPostalCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','25','(''SS''=''Q,'')','ECCICSCEXPZ0','50','D','10','25',NULL,'PremiumCountry',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','26','(''UA''=''Q,'')','ECCICSCEXPZ0','50','D','10','26',NULL,'Sex',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','27','(''UD101''=''Q,'')','ECCICSCEXPZ0','50','D','10','27',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTobacoUse"','28','(''UA''=''Q,'')','ECCICSCEXPZ0','50','D','10','28',NULL,'Tobacco Use',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"UNKNOWN"','29','(''DA''=''Q,'')','ECCICSCEXPZ0','50','D','10','29',NULL,'EmployeeType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpPayrollType"','30','(''UA''=''Q,'')','ECCICSCEXPZ0','50','D','10','30',NULL,'EmployeePayrollType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','31','(''SS''=''Q,'')','ECCICSCEXPZ0','50','D','10','31',NULL,'YearsOfService',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"COUPONBOOK"','32','(''DA''=''Q,'')','ECCICSCEXPZ0','50','D','10','32',NULL,'PremiumCouponType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FALSE"','33','(''DA''=''Q,'')','ECCICSCEXPZ0','50','D','10','33',NULL,'UsesHCTC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TRUE"','34','(''DA''=''Q,'')','ECCICSCEXPZ0','50','D','10','34',NULL,'Active',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FALSE"','35','(''DA''=''Q,'')','ECCICSCEXPZ0','50','D','10','35',NULL,'AllowMemberSSO',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','36','(''SS''=''Q,'')','ECCICSCEXPZ0','50','D','10','36',NULL,'BenefitGroup',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','37','(''SS''=''Q,'')','ECCICSCEXPZ0','50','D','10','37',NULL,'AccountStructure',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','38','(''SS''=''Q'')','ECCICSCEXPZ0','50','D','10','38',NULL,'ClientSpecificData',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','39','(''SS''=''Q'')','ECCICSCEXPZ0','50','D','10','39',NULL,'SSOIdentifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','40','(''SS''=''Q'')','ECCICSCEXPZ0','50','D','10','40',NULL,'PlanCategory',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBEVENT]"','1','(''DA''=''Q,'')','ECCICSCEXPZ0','50','D','20','1',NULL,'Record Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEventType"','2','(''UA''=''Q,'')','ECCICSCEXPZ0','50','D','20','2',NULL,'EventType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEventDate"','3','(''UD101''=''Q,'')','ECCICSCEXPZ0','50','D','20','3',NULL,'EventDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrollmentDate"','4','(''UD101''=''Q,'')','ECCICSCEXPZ0','50','D','20','4',NULL,'EnrollmentDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','5','(''UA''=''Q,'')','ECCICSCEXPZ0','50','D','20','5',NULL,'EmployeeSSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvName"','6','(''UA''=''Q,'')','ECCICSCEXPZ0','50','D','20','6',NULL,'EmployeeName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','7','(''SS''=''Q'')','ECCICSCEXPZ0','50','D','20','7',NULL,'SecondEventOriginalFDOC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBPLANINITIAL]"','1','(''DA''=''Q,'')','ECCICSCEXPZ0','50','D','30','1',NULL,'Record Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanName"','2','(''UA''=''Q,'')','ECCICSCEXPZ0','50','D','30','2',NULL,'PlanName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageLevel"','3','(''UA''=''Q,'')','ECCICSCEXPZ0','50','D','30','3',NULL,'CoverageLevel',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','4','(''SS''=''Q'')','ECCICSCEXPZ0','50','D','30','4',NULL,'NumberOfUnits',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBDEPENDENT]"','1','(''DA''=''Q,'')','ECCICSCEXPZ0','50','D','40','1',NULL,'Record Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','2','(''UA''=''Q,'')','ECCICSCEXPZ0','50','D','40','2',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelationship"','3','(''UA''=''Q,'')','ECCICSCEXPZ0','50','D','40','3',NULL,'Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','4','(''SS''=''Q,'')','ECCICSCEXPZ0','50','D','40','4',NULL,'Salutation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','5','(''UA''=''Q,'')','ECCICSCEXPZ0','50','D','40','5',NULL,'FirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','6','(''UA''=''Q,'')','ECCICSCEXPZ0','50','D','40','6',NULL,'MiddleInitial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','7','(''UA''=''Q,'')','ECCICSCEXPZ0','50','D','40','7',NULL,'LastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''SS''=''Q,'')','ECCICSCEXPZ0','50','D','40','8',NULL,'Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''SS''=''Q,'')','ECCICSCEXPZ0','50','D','40','9',NULL,'Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''SS''=''Q,'')','ECCICSCEXPZ0','50','D','40','10',NULL,'Phone2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIsAddressSame"','11','(''UA''=''Q,'')','ECCICSCEXPZ0','50','D','40','11',NULL,'AddressSameAsQB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','12','(''UA''=''Q,'')','ECCICSCEXPZ0','50','D','40','12',NULL,'Address1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','13','(''UA''=''Q,'')','ECCICSCEXPZ0','50','D','40','13',NULL,'Address2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','14','(''UA''=''Q,'')','ECCICSCEXPZ0','50','D','40','14',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','15','(''UA''=''Q,'')','ECCICSCEXPZ0','50','D','40','15',NULL,'StateOrProvince',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','16','(''UA''=''Q,'')','ECCICSCEXPZ0','50','D','40','16',NULL,'PostalCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','17','(''SS''=''Q,'')','ECCICSCEXPZ0','50','D','40','17',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''SS''=''Q,'')','ECCICSCEXPZ0','50','D','40','18',NULL,'EnrollmentDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','19','(''UA''=''Q,'')','ECCICSCEXPZ0','50','D','40','19',NULL,'Sex',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','20','(''UD101''=''Q,'')','ECCICSCEXPZ0','50','D','40','20',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvISQMCO"','21','(''UA''=''Q'')','ECCICSCEXPZ0','50','D','40','21',NULL,'IsQMCSO',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBDEPENDENTPLANINITIAL]"','1','(''DA''=''Q,'')','ECCICSCEXPZ0','50','D','50','1',NULL,'Record Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanName"','2','(''UA''=''Q'')','ECCICSCEXPZ0','50','D','50','2',NULL,'PlanName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBPLANMEMBERSPECIFICRATEINITIAL]"','1','(''DA''=''Q,'')','ECCICSCEXPZ0','50','D','60','1',NULL,'Record Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanName"','2','(''UA''=''Q,'')','ECCICSCEXPZ0','50','D','60','2',NULL,'PlanName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRate"','3','(''UA''=''Q'')','ECCICSCEXPZ0','50','D','60','3',NULL,'Rate',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'ECCICSCEXP_20210813.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'On Demand','202011309','EMPEXPORT','ONDEMAND','Mar 23 2021 12:00AM','ECCICSCEXP',NULL,NULL,NULL,'202011309','Nov 30 2020 12:00AM','Dec 30 1899 12:00AM','201901011',NULL,'','','201901011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'Null','N','',NULL,NULL,NULL,'Schedule Session','202007109','EMPEXPORT','SCH_QBAMQ','Jul 15 2020 12:00AM','ECCICSCEXP',NULL,NULL,NULL,'202104079','Jul 10 2020 12:00AM','Dec 30 1899 12:00AM','202103311',NULL,'','','202007031',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Test /Cobra Export','202108131','EMPEXPORT','TEST','Aug 13 2021  6:44PM','ECCICSCEXP',NULL,NULL,NULL,'202108131','Aug 13 2021 12:00AM','Aug  8 2021 12:00AM','202103121','663','','','202103121',dbo.fn_GetTimedKey(),NULL,'us3mLaCLE1010',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECCICSCEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECCICSCEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECCICSCEXP','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECCICSCEXP','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECCICSCEXP','SubSort2','C','drvSubSort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECCICSCEXP','SubSort3','C','drvSubSort3');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECCICSCEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECCICSCEXP','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'ECCICSCEXP' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'ECCICSCEXP' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_ECCICSCEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECCICSCEXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECCICSCEXP','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECCICSCEXP','D10','dbo.U_ECCICSCEXP_drvTbl_QB WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECCICSCEXP','D20','dbo.U_ECCICSCEXP_drvTbl_QBEVENT WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECCICSCEXP','D30','dbo.U_ECCICSCEXP_drvTbl_QBPLAN WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECCICSCEXP','D40','dbo.U_ECCICSCEXP_drvTbl_QBDEP WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECCICSCEXP','D50','dbo.U_ECCICSCEXP_drvTbl_QBDEPPLAN WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECCICSCEXP','D60','dbo.U_ECCICSCEXP_drvTbl_QBMSRI WITH (NOLOCK)',NULL);
IF OBJECT_ID('U_dsi_BDM_ECCICSCEXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ECCICSCEXP] (
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
IF OBJECT_ID('U_ECCICSCEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_ECCICSCEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ECCICSCEXP_drvTbl_NPM') IS NULL
CREATE TABLE [dbo].[U_ECCICSCEXP_drvTbl_NPM] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvSSN] char(11) NULL,
    [drvEmpNo] varchar(1) NOT NULL,
    [drvClientName] varchar(100) NULL,
    [drvClientDivName] varchar(16) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvAddressEMail] varchar(1) NOT NULL,
    [drvPhoneHomeNumber] varchar(1) NOT NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvGender] varchar(1) NULL,
    [drvHireDate] datetime NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] char(11) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(1) NOT NULL
);
IF OBJECT_ID('U_ECCICSCEXP_drvTbl_QB') IS NULL
CREATE TABLE [dbo].[U_ECCICSCEXP_drvTbl_QB] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NOT NULL,
    [drvClientName] varchar(100) NULL,
    [drvClientDivName] varchar(50) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvSSN] char(11) NULL,
    [drvEmpNo] char(9) NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvPhone] varchar(50) NULL,
    [drvPhone2] varchar(1) NOT NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvGender] char(1) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvTobacoUse] varchar(7) NOT NULL,
    [drvEmpPayrollType] varchar(7) NOT NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(208) NULL
);
IF OBJECT_ID('U_ECCICSCEXP_drvTbl_QBDEP') IS NULL
CREATE TABLE [dbo].[U_ECCICSCEXP_drvTbl_QBDEP] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NULL,
    [drvSSN] char(11) NOT NULL,
    [drvRelationship] varchar(15) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvIsAddressSame] varchar(4) NOT NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvGender] varchar(1) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvISQMCO] varchar(5) NOT NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(33) NULL,
    [drvSubSort3] varchar(208) NULL
);
IF OBJECT_ID('U_ECCICSCEXP_drvTbl_QBDEPENDENT') IS NULL
CREATE TABLE [dbo].[U_ECCICSCEXP_drvTbl_QBDEPENDENT] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(31) NULL,
    [drvSSN] char(11) NULL,
    [drvRelationship] varchar(15) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(102) NULL,
    [drvAddressSameAsQB] varchar(5) NOT NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvSex] varchar(1) NULL,
    [drvDateOfBirth] datetime NULL
);
IF OBJECT_ID('U_ECCICSCEXP_drvTbl_QBDEPENDENTPLANINITIAL') IS NULL
CREATE TABLE [dbo].[U_ECCICSCEXP_drvTbl_QBDEPENDENTPLANINITIAL] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(31) NULL,
    [drvPlanName] varchar(32) NULL
);
IF OBJECT_ID('U_ECCICSCEXP_drvTbl_QBDEPPLAN') IS NULL
CREATE TABLE [dbo].[U_ECCICSCEXP_drvTbl_QBDEPPLAN] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NULL,
    [drvDedCode] char(5) NULL,
    [drvPlanName] varchar(50) NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(38) NULL,
    [drvSubSort3] varchar(208) NULL
);
IF OBJECT_ID('U_ECCICSCEXP_drvTbl_QBEVENT') IS NULL
CREATE TABLE [dbo].[U_ECCICSCEXP_drvTbl_QBEVENT] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NOT NULL,
    [drvEventType] varchar(30) NOT NULL,
    [drvEventDate] datetime NULL,
    [drvEnrollmentDate] datetime NULL,
    [drvSSN] char(11) NULL,
    [drvName] varchar(201) NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(208) NULL
);
IF OBJECT_ID('U_ECCICSCEXP_drvTbl_QBMSRI') IS NULL
CREATE TABLE [dbo].[U_ECCICSCEXP_drvTbl_QBMSRI] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NOT NULL,
    [drvPlanName] varchar(50) NULL,
    [drvRate] nvarchar(4000) NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(208) NULL
);
IF OBJECT_ID('U_ECCICSCEXP_drvTbl_QBPLAN') IS NULL
CREATE TABLE [dbo].[U_ECCICSCEXP_drvTbl_QBPLAN] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NOT NULL,
    [drvDedCode] char(5) NULL,
    [drvPlanName] varchar(50) NULL,
    [drvCoverageLevel] varchar(11) NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(6) NULL,
    [drvSubSort3] varchar(208) NULL
);
IF OBJECT_ID('U_ECCICSCEXP_drvTbl_QBPLAN2') IS NULL
CREATE TABLE [dbo].[U_ECCICSCEXP_drvTbl_QBPLAN2] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NOT NULL,
    [drvDedCode] char(5) NULL,
    [drvPlanName] varchar(50) NULL,
    [drvStartDate] datetime NULL,
    [drvEndDate] int NULL,
    [drvCoverageLevel] varchar(11) NULL,
    [drvPlanBundleName] varchar(50) NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(6) NULL,
    [drvSubSort3] varchar(208) NULL
);
IF OBJECT_ID('U_ECCICSCEXP_drvTbl_QBPLANINITIAL') IS NULL
CREATE TABLE [dbo].[U_ECCICSCEXP_drvTbl_QBPLANINITIAL] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(16) NULL,
    [drvPLanName] varchar(32) NULL,
    [drvCoverageLevel] varchar(11) NULL
);
IF OBJECT_ID('U_ECCICSCEXP_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL') IS NULL
CREATE TABLE [dbo].[U_ECCICSCEXP_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(16) NULL,
    [drvRecordType] varchar(33) NOT NULL,
    [drvPlanName] varchar(15) NULL,
    [drvRate] nvarchar(4000) NULL
);
IF OBJECT_ID('U_ECCICSCEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_ECCICSCEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ECCICSCEXP_File') IS NULL
CREATE TABLE [dbo].[U_ECCICSCEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
IF OBJECT_ID('U_ECCICSCEXP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ECCICSCEXP_PDedHist] (
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
IF OBJECT_ID('U_ECCICSCEXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ECCICSCEXP_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECCICSCEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Clearview Cancer Institute

Created By: Marco Lagrosa
Business Analyst: Julie Reardon
Create Date: 08/13/2021
Service Request Number: TekP-2021-05-26-0002   

Purpose: CobraSecure Cobra Export

Revision History
----------------
Update By            Date           Request Num        Desc
XXXX                 XX/XX/xxxx     SR-20XX-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECCICSCEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECCICSCEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECCICSCEXP';
SELECT * FROM dbo.AscExp WHERE expFormatCode = 'ECCICSCEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECCICSCEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECCICSCEXP', 'SCH_QBAM';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECCICSCEXP', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECCICSCEXP', 'TEST';


EXEC dbo.dsi_BDM_sp_ErrorCheck 'ECCICSCEXP';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ECCICSCEXP', @AllObjects = 'Y', @IsWeb = 'Y'

**********************************************************************************/
BEGIN
    --==========================================
    -- Declare variables
    --==========================================
    DECLARE  @FormatCode varchar(10)
            ,@ExportCode varchar(10)
            ,@StartDate  datetime
            ,@EndDate    datetime;

    -- Initialize @FormatCode
    SET @FormatCode = 'ECCICSCEXP';


    -- Declare dates from Parameter file
    SELECT
         @ExportCode = ExportCode
        ,@StartDate  = LEFT(StartPerControl,8)
        ,@EndDate    = DATEADD(SS,-1,DATEADD(DD,1,LEFT(EndPerControl,8)))
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List
    --==========================================
    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_ECCICSCEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCoID(xEEID)
      AND xEEID IN (SELECT xEEID FROM dbo.U_ECCICSCEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'DEN,FSA,FSAER,MED,MEDHD,VIS';

    IF OBJECT_ID('U_ECCICSCEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ECCICSCEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ECCICSCEXP_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

    --==========================================
    -- BDM Section for QB
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'TermSelectionOption','AuditDate');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DedList);

    -- COBRA parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RunID','QB');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','Y'); -- DedIsCobraCovered = 'Y'
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraType','4'); -- Eep/ConCobraReason first, then EdhChangeReason. Include CHGRP for elig. ben groups
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraDate','3'); -- EedBenStopDate and DbnBenStopDate, unless Eep/ConDateOfCOBRAEvent exists
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraPQBType','1'); -- If no EE or spouse, ALL children are PQB (not just oldest)
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraReasonsDepPQB','201,204,210,LEVNT3,LEVNT4'); -- Valid dependent PQB reasons
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidCobraReasonsEmp','201,204,210,LEVNT3,LEVNT4'); -- Invalidate employee when Cobra Reason is a dependent PQB reason
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidTermReasonsEmp','203'); -- Invalidate employee when Cobra Reason is "Death"
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'ConCobraReasonPCF','DependentCOBRAReason'); -- Valid dependent PQB reasons
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CountDependents','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL,DCH,DPC,STC');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');

    -- Run BDM for QB
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;


    --   --==========================================
 --   -- Insert into BDM Reason code 201 and 204
 --   --==========================================
    INSERT INTO [dbo].[U_dsi_BDM_ECCICSCEXP]
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
           ,[BdmStartDate]
           ,[BdmStopDate]
           ,[BdmIsPQB]
           ,[BdmBenOption]

    )
 Select rectype = 'DEP', dbnCoid, dbneeid, DbnDepRecID, DbnDepRecID, 'QB', 'Data Inserted for 204 Chg reason', 
            DbnRelationship, DbnDateOfBirth, dbnDedcode, (Select top 1 edhBenStartDate from emphded A where A.edhdedcode = dbnDedcode and A.edheeid =  dbneeid and A.edhcoid = dbncoid order by Auditkey asc ) as bdmBenstartDate,edhBenStopDate, edhEffDate,'204'
            ,edhStartDate, edhStopDate, CASE WHEN dbnRelationShip = 'SPS' THEN 'Y' ELSE 'N' END, edhbenoption 
            from dbo.emphded with (nolock)
            JOIN dbo.U_dsi_BDM_DepDeductions on dbneeid = edheeid and dbnformatcode = @FormatCode
            WHERE edhChangeReason in ('204') and dbnbenstopdate between @startdate and @enddate and dbnValidForExport = 'N'
                and dbnrunid  = 'QB'
                        Group by dbnCoid,dbneeid,DbnDepRecID,DbnRelationship,DbnDateOfBirth,dbnDedcode,edhBenStopDate,edhEffDate,edhStartDate,edhStopDate,edhbenoption


INSERT INTO [dbo].[U_dsi_BDM_ECCICSCEXP]
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
           ,[BdmStartDate]
           ,[BdmStopDate]
           ,[BdmIsPQB]
          , [BdmBenOption]

    )
    Select rectype = 'DEP', dbncoid, dbneeid, DbnDepRecID, DbnDepRecID, 'QB', 'Data Inserted for 201 Chg reason', 
            DbnRelationship, DbnDateOfBirth, dbnDedcode, (Select top 1 edhBenStartDate from emphded A where A.edhdedcode = dbnDedcode and A.edheeid =  dbneeid and A.edhcoid = dbncoid order by Auditkey asc ) as bdmBenstartDate,edhBenStopDate, edhEffDate,'201'
            ,edhStartDate, edhStopDate, 'Y',edhbenoption
            from dbo.emphded with (nolock)
            JOIN dbo.U_dsi_BDM_DepDeductions on dbneeid = edheeid and dbnformatcode = @FormatCode
           
            WHERE edhChangeReason in ('201') and dbnbenstopdate between @startdate and @enddate and dbnValidForExport = 'N'
            and dbnrunid  = 'QB'
            Group by dbncoid, dbneeid,DbnDepRecID,DbnRelationship,DbnDateOfBirth,dbnDedcode,edhBenStopDate,edhEffDate,edhStartDate,edhStopDate,edhbenoption
            ----
            /*
            INSERT INTO [dbo].[U_dsi_BDM_ECCICSCEXP]
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
           ,[BdmStartDate]
           ,[BdmStopDate]
           ,[BdmIsPQB]
          , [BdmBenOption]

    )
    
    Select rectype = 'DEP', dbncoid, dbneeid, DbnDepRecID, DbnDepRecID, 'QB', 'Data Inserted for 302 Chg reason', 
            DbnRelationship, DbnDateOfBirth, dbnDedcode, (Select top 1 edhBenStartDate from emphded A where A.edhdedcode = dbnDedcode and A.edheeid =  dbneeid and A.edhcoid = dbncoid order by Auditkey asc ) as bdmBenstartDate,edhBenStopDate, edhEffDate,'302'
            ,edhStartDate, edhStopDate, 'Y',edhbenoption
            from dbo.emphded with (nolock)
            JOIN dbo.U_dsi_BDM_DepDeductions on dbneeid = edheeid and dbnformatcode = @FormatCode
           
            WHERE edhChangeReason in ('302') and dbnbenstopdate between @startdate and @enddate and dbnValidForExport = 'N'
            and dbnrunid  = 'QB'
            Group by dbncoid, dbneeid,DbnDepRecID,DbnRelationship,DbnDateOfBirth,dbnDedcode,edhBenStopDate,edhEffDate,edhStartDate,edhStopDate,edhbenoption
    */
        
    Delete from dbo.U_dsi_BDM_ECCICSCEXP where bdmdedcode not in (Select dedcode from U_ECCICSCEXP_DedList)

    Update dbo.U_dsi_BDM_ECCICSCEXP  
    set bdmNumSpouses = (select count(*) from U_dsi_BDM_ECCICSCEXP A where A.bdmeeid = X.bdmeeid and bdmRelationship = 'SPS' and A.bdmcoid = X.bdmcoid)
    ,bdmNumChildren = (select count(*) from U_dsi_BDM_ECCICSCEXP A where A.bdmeeid = X.bdmeeid and bdmRelationship = 'CHL' and A.bdmcoid = X.bdmcoid)
    from dbo.U_dsi_BDM_ECCICSCEXP  X

    where BdmDedRowStatus IN ('Data Inserted for 204 Chg reason','Data Inserted for 201 Chg reason','Data Inserted for 302 Chg reason');


    Delete from dbo.U_dsi_BDM_ECCICSCEXP   where BdmDedRowStatus IN ('Data Inserted for 204 Chg reason','Data Inserted for 201 Chg reason','Data Inserted for 302 Chg reason') and bdmbenoption is null


    -- Build driver tables
    --==========================================
    ------------------
    -- QB DETAIL RECORD
    ------------------
    IF OBJECT_ID('U_ECCICSCEXP_drvTbl_QB') IS NOT NULL
        DROP TABLE dbo.U_ECCICSCEXP_drvTbl_QB;
    SELECT DISTINCT
         drvEEID           = BdmEEID
        ,drvCoID           = BdmCoID
        ,drvDepRecID       = ISNULL(BdmDepRecID,'')
        ,drvClientName     = CONVERT(varchar(100),'Oncology Specialties, P.C.')
        ,drvClientDivName  = CONVERT(varchar(50),'Oncology Specialties, P.C.')
        ,drvNameFirst      = EepNameFirst
        ,drvNameMiddle     = CASE WHEN BdmRecType = 'EMP' THEN LEFT(EepNameMiddle,1)
                                  ELSE LEFT(ConNameMiddle,1)
                             END
        ,drvNameLast       = CASE WHEN BdmRecType = 'EMP' THEN EepNameLast
                                  ELSE ConNameLast
                             END
        ,drvSSN            = CASE WHEN BdmRecType = 'EMP' THEN eepSSN
                                  ELSE ISNULL(ConSSN,'')
                             END
        ,drvEmpNo          = eecEmpNo
        ,drvEmailAddress   = CASE WHEN BdmRecType = 'EMP' THEN eepAddressEMailAlternate
                                  ELSE ConEmailAddr  
                             END
        ,drvPhone          = CASE WHEN BdmRecType = 'EMP' THEN EepPhoneHomeNumber
                                  ELSE ConPhoneHomeNumber  
                             END
        ,drvPhone2         = ''
        ,drvAddressLine1   = CASE WHEN BdmRecType = 'EMP' THEN EepAddressLine1
                                  WHEN ConAddressLine1 IS NULL THEN EepAddressLine1
                                  ELSE ConAddressLine1
                             END
        ,drvAddressLine2   = CASE WHEN BdmRecType = 'EMP' THEN EepAddressLine2
                                  WHEN ConAddressLine1 IS NULL THEN EepAddressLine2
                                  ELSE ConAddressLine2
                             END
        ,drvAddressCity    = CASE WHEN BdmRecType = 'EMP' THEN EepAddressCity
                                  WHEN ConAddressLine1 IS NULL THEN EepAddressCity
                                  ELSE ConAddressCity
                             END
        ,drvAddressState   = CASE WHEN BdmRecType = 'EMP' THEN EepAddressState
                                  WHEN ConAddressLine1 IS NULL THEN EepAddressState
                                  ELSE ConAddressState
                             END
        ,drvAddressZipCode = CASE WHEN BdmRecType = 'EMP' THEN EepAddressZipCode
                                  WHEN ConAddressLine1 IS NULL THEN EepAddressZipCode
                                  ELSE ConAddressZipCode
                             END
        ,drvGender         = CASE WHEN BdmRecType = 'EMP' THEN EepGender
                                  ELSE ConGender
                             END
        ,drvDateOfBirth    = CASE WHEN BdmRecType = 'EMP' THEN EepDateOfBirth
                                  ELSE ConDateOfBirth
                             END
        ,drvTobacoUse       = 'Unknown'
        ,drvEmpPayrollType =  'Unknown'
        ,drvInitialSort    = '21'
        ,drvSubSort        = CASE WHEN BdmRecType = 'EMP' THEN eepSSN
                                  ELSE ISNULL(NULLIF(ConSSN,''),eepSSN) + CONVERT(char(8),ConDateOfBirth,112)
                             END
        ,drvSubSort2       = '1'
        ,drvSubSort3       = CASE WHEN BdmRecType = 'EMP' THEN '2'
                                  ELSE CONVERT(char(8),ConDateOfBirth,112) + RTRIM(ConNameLast) + ConNameFirst
                             END
    INTO dbo.U_ECCICSCEXP_drvTbl_QB
    FROM dbo.U_dsi_BDM_ECCICSCEXP WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = BdmEEID
       AND EecCoID = BdmCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = BdmEEID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = BdmEEID
       AND ConSystemID = BdmDepRecID
    WHERE BdmRunID = 'QB'
      AND BdmIsPQB = 'Y';

    ------------------
    -- QBEVENT DETAIL RECORD
    ------------------
    IF OBJECT_ID('U_ECCICSCEXP_drvTbl_QBEVENT') IS NOT NULL
        DROP TABLE dbo.U_ECCICSCEXP_drvTbl_QBEVENT;
    SELECT DISTINCT
         drvEEID           = drvEEID
        ,drvCoID           = drvCoID
        ,drvDepRecID       = drvDepRecID
        ,drvEventType      = CASE WHEN EecTermReason = '202' THEN 'RETIREMENT'
                                  WHEN EecTermReason = '203' THEN 'DEATH'
                                  WHEN BdmCobraReason IN ('201','LEVNT3') or BdmChangereason IN ('201','LEVNT3')  THEN 'INELIGIBLEDEPENDENT'
                                  WHEN BdmCobraReason IN ('204','LEVNT4') or BdmChangereason IN ('204','LEVNT4')  THEN 'DIVORCELEGALSEPARATION'
                                  
                                  WHEN BdmCobraReason = '210' or BdmChangereason = '210' THEN 'DEATH'
                                  WHEN BdmCobraReason IN ('202','CHGRP') THEN 'LOSSOFELIGIBILITY'
                                  WHEN BdmCobraReason IN ('203','202') THEN 'REDUCTIONINHOURS-STATUSCHANGE '
                                  WHEN BdmCobraReason = '205' THEN 'MEDICARE'
                                  WHEN BdmCobraReason = '206' THEN 'REDUCTIONINHOURS-ENDOFLEAVE'
                                  --WHEN BdmCobraReason = '207' THEN 'USERRA-REDUCTIONINHOURS'
                                  WHEN BdmCobraReason = '208' THEN 'RETIREMENT'
                                  WHEN BdmCobraReason = '209' THEN 'WORKSTOPPAGE'
                                  WHEN EecEmplStatus = 'T' and eectermtype  = 'I' THEN 'INVOLUNTARYTERMINATION'
                                  ELSE 'TERMINATION'
                             END
        ,drvEventDate      = CASE WHEN BdmCobraReason in ('204','201','LEVNT3','LEVNT4','302') or BdmChangereason in ('204','201','LEVNT3','LEVNT4','302','210') THEN  BdmBenStatusDate ELSE BdmDateOfCOBRAEvent END
        ,drvEnrollmentDate = BdmBenStartDate
        ,drvSSN            = eepSSN
        ,drvName           = RTRIM(EepNameFirst) + ' ' + RTRIM(EepNameLast)
        ,drvInitialSort    = '21'
        ,drvSubSort        = drvSubSort
        ,drvSubSort2       = '1'
        ,drvSubSort3       = drvSubSort3
    INTO dbo.U_ECCICSCEXP_drvTbl_QBEVENT
    FROM dbo.U_ECCICSCEXP_drvTbl_QB WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = drvEEID
       AND EecCoID = drvCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = drvEEID
    JOIN (SELECT
             BdmEEID
            ,BdmCoID
            ,BdmDepRecID
            ,BdmRecType
            ,BdmCobraReason = MAX(BdmCobraReason)
            ,BdmChangereason = MAX(BdmChangereason)
            ,BdmBenStartDate = MIN(BdmBenStartDate)
            ,BdmDateOfCOBRAEvent = MAX(BdmDateOfCOBRAEvent)
            ,BdmUSGDate1 = MAX(BdmUSGDate1)
            ,BdmBenStatusDate = MAX(BdmBenStatusDate)
          FROM dbo.U_dsi_BDM_ECCICSCEXP WITH (NOLOCK)
          WHERE BdmRunID = 'QB'
            AND BdmIsPQB = 'Y'
          GROUP BY BdmEEID, BdmCoID, BdmDepRecID, BdmRecType) BDM
        ON BdmEEID = drvEEID
       AND BdmCoID = drvCoID
       AND ISNULL(BdmDepRecID,'') = drvDepRecID;

    ------------------
    -- QBPLAN DETAIL RECORD
    ------------------

     ------------------
    -- QBPLANINITIAL DETAIL RECORD
    ------------------
    IF OBJECT_ID('U_ECCICSCEXP_drvTbl_QBPLAN') IS NOT NULL
        DROP TABLE dbo.U_ECCICSCEXP_drvTbl_QBPLAN;
    SELECT DISTINCT
         drvEEID          = drvEEID
        ,drvCoID          = drvCoID
        ,drvDepRecID      = drvDepRecID
        ,drvDedCode       = BdmDedCode
        ,drvPlanName      = CONVERT(varchar(50),(CASE WHEN BdmDedType = 'FSA' THEN 'NBS FSA'
                            WHEN BdmDedCode = 'DEN' THEN 'GUARDIAN DENTAL'
                            WHEN BdmDedCode IN ('VIS') THEN 'GUARDIAN VISION'
                            WHEN BdmDedCode = 'MED' THEN 'BCBS OF AL HEALTH'
                            WHEN BdmDedCode = 'MEDHD' THEN 'BCBS OF AL HEALTH HSA'
                        END))
        ,drvCoverageLevel = CASE WHEN BdmDedType IN ('FSA') THEN 'EE'
        
                                WHEN BdmDedCode IN ('DEN','FSA','FSAER','MED','MEDHD','VIS') THEN
                                CASE 
                                    WHEN BdmCobraReason IN  ('201','LEVNT3','302','204','LEVNT4','302','210') or BdmChangereason IN  ('201','LEVNT3','302','204','LEVNT4','302','210') or EecTermReason = '203' THEN 'EE'
                                    WHEN  bdmbenoption  = 'EE' THEN 'EE'
                                    WHEN  bdmbenoption  = 'EEC' THEN 'EE+CHILDREN'
                                    WHEN  bdmbenoption  = 'EEF' THEN 'EE+FAMILY'

                                    
                                END
                                
                            END
        ,drvInitialSort   = '21'
        ,drvSubSort       = drvSubSort
        ,drvSubSort2      = '1' + BdmDedCode
        ,drvSubSort3      = drvSubSort3
    INTO dbo.U_ECCICSCEXP_drvTbl_QBPLAN
    FROM dbo.U_ECCICSCEXP_drvTbl_QBEVENT WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_ECCICSCEXP WITH (NOLOCK)
        ON BdmEEID = drvEEID
       AND BdmCoID = drvCoID
       AND ISNULL(BdmDepRecID,'') = drvDepRecID
    JOIN dbo.EmpPers WITH (NOLOCK) 
        on eepeeid =  drveeid
       JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = drvEEID
       AND EecCoID = drvCoID
    WHERE BdmRunID = 'QB'
      AND BdmIsPQB = 'Y'

    INSERT INTO dbo.U_ECCICSCEXP_drvTbl_QBPLAN
    SELECT DISTINCT
         drvEEID         
        ,drvCoID          
        ,drvDepRecID      
        ,drvDedCode      
        ,drvPlanName      = 'ONE MEDICAL'
        ,drvCoverageLevel 
        ,drvInitialSort   
        ,drvSubSort    
        ,drvSubSort2      
        ,drvSubSort3      
    FROM dbo.U_ECCICSCEXP_drvTbl_QBPLAN
     where drvDedCode in ('MED','MEDHD')
    ------------------
    -- QBDEPENDENT DETAIL RECORD
    ------------------
    IF OBJECT_ID('U_ECCICSCEXP_drvTbl_QBDEP') IS NOT NULL
        DROP TABLE dbo.U_ECCICSCEXP_drvTbl_QBDEP;
    SELECT DISTINCT
         drvEEID           = BdmEEID
        ,drvCoID           = BdmCoID
        ,drvDepRecID       = BdmDepRecID
        ,drvSSN            = ISNULL(ConSSN,'')
        ,drvRelationship   = CASE WHEN BdmRelationship IN ('SPS') THEN 'SPOUSE'
                                  WHEN BdmRelationship IN ('DP') THEN 'DOMESTICPARTNER'
                                  WHEN BdmRelationship IN ('CHL','DCH','DPC','STC','DAU','SON') THEN 'CHILD'
                             END
        ,drvNameFirst      = ConNameFirst
        ,drvNameMiddle     = LEFT(ConNameMiddle,1)
        ,drvNameLast       = ConNameLast
        ,drvIsAddressSame  = 'TRUE'
        ,drvAddressLine1   = CASE WHEN ConAddressIsDifferent = 'N' THEN '' ELSE ConAddressLine1 END
        ,drvAddressLine2   = CASE WHEN ConAddressIsDifferent = 'N' THEN '' ELSE ConAddressLine2 END
        ,drvAddressCity    = CASE WHEN ConAddressIsDifferent = 'N' THEN '' ELSE ConAddressCity END
        ,drvAddressState   = CASE WHEN ConAddressIsDifferent = 'N' THEN '' ELSE ConAddressState END
        ,drvAddressZipCode = CASE WHEN ConAddressIsDifferent = 'N' THEN '' ELSE ConAddressZipCode END
        ,drvGender         = CASE WHEN ConGender IN ('M','F') THEN ConGender ELSE 'U' END
        ,drvDateOfBirth    = ConDateOfBirth
        ,drvISQMCO         = 'False'
        ,drvInitialSort    = '21'
        ,drvSubSort        = drvSubSort
        ,drvSubSort2       = '2' + CASE WHEN BdmRelationship IN ('SPS','DP') THEN 'A'
                                        ELSE 'B' + ISNULL(ConSSN,ConNameFirst)
                                   END + CONVERT(char(8),ISNULL(ConDateOfBirth,''),112) + ConSystemID
        ,drvSubSort3       = drvSubSort3
    INTO dbo.U_ECCICSCEXP_drvTbl_QBDEP
    FROM dbo.U_ECCICSCEXP_drvTbl_QB WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_ECCICSCEXP WITH (NOLOCK)
        ON BdmEEID = drvEEID
       AND BdmCoID = drvCoID
    JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = BdmEEID
       AND ConSystemID = BdmDepRecID
    WHERE BdmRunID = 'QB'
      AND BdmIsPQB = 'N'


    ------------------
    -- QBDEPENDENTPLANINITIAL DETAIL RECORD
    ------------------
    IF OBJECT_ID('U_ECCICSCEXP_drvTbl_QBDEPPLAN') IS NOT NULL
        DROP TABLE dbo.U_ECCICSCEXP_drvTbl_QBDEPPLAN;
    SELECT DISTINCT
         drvEEID        = BdmEEID
        ,drvCoID        = BdmCoID
        ,drvDepRecID    = BdmDepRecID
        ,drvDedCode     = BdmDedCode
        ,drvPlanName    = CONVERT(varchar(50),(CASE WHEN BdmDedType = 'FSA' THEN 'NBS FSA'
                            WHEN BdmDedCode = 'DEN' THEN 'GUARDIAN DENTAL'
                            WHEN BdmDedCode IN ('VIS') THEN 'GUARDIAN VISION'
                            WHEN BdmDedCode = 'MED' THEN 'BCBS OF AL HEALTH'
                            WHEN BdmDedCode = 'MEDHD' THEN 'BCBS OF AL HEALTH HSA'
                        END))
        ,drvInitialSort = '21'
        ,drvSubSort     = drvSubSort
        ,drvSubSort2    = '2' + CASE WHEN BdmRelationship IN ('SPS','DP') THEN 'A'
                                     ELSE 'B' + RTRIM(ISNULL(ConSSN,ConNameFirst))
                                END + CONVERT(char(8),ISNULL(ConDateOfBirth,''),112) + ConSystemID + BdmDedCode
        ,drvSubSort3    = drvSubSort3
    INTO dbo.U_ECCICSCEXP_drvTbl_QBDEPPLAN
    FROM dbo.U_ECCICSCEXP_drvTbl_QBPLAN WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_ECCICSCEXP WITH (NOLOCK)
        ON BdmEEID = drvEEID
       AND BdmCoID = drvCoID
       AND BdmDedCode = drvDedCode
    JOIN dbo.Emppers WITH (NOLOCK)
        on EEPEEID = drveeid
    JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = BdmEEID
       AND ConSystemID = BdmDepRecID
    WHERE BdmRunID = 'QB'
      AND BdmIsPQB = 'N';
      
       INSERT INTO dbo.U_ECCICSCEXP_drvTbl_QBDEPPLAN
        SELECT DISTINCT
         drvEEID        
        ,drvCoID        
        ,drvDepRecID    
        ,drvDedCode     
        ,drvPlanName    = 'ONE MEDICAL'
        ,drvInitialSort 
        ,drvSubSort     
        ,drvSubSort2    
        ,drvSubSort3    
    FROM dbo.U_ECCICSCEXP_drvTbl_QBDEPPLAN
    where drvDedCode in ('MED','MEDHD')
    
    ------------------
    -- QBPLANMEMBERSPECIFICRATEINITIAL DETAIL RECORD
    ------------------
    IF OBJECT_ID('U_ECCICSCEXP_drvTbl_QBMSRI') IS NOT NULL
        DROP TABLE dbo.U_ECCICSCEXP_drvTbl_QBMSRI;
    SELECT DISTINCT
         drvEEID        = drvEEID
        ,drvCoID        = drvCoID
        ,drvDepRecID    = drvDepRecID
        ,drvPlanName    =  CONVERT(varchar(50),(CASE WHEN BdmDedCode IN ('FSA','FSAER') THEN 'NBS FSA'
                            
                        END))
        ,drvRate        = CASE WHEN BdmDedCode IN ('FSA','FSALP') THEN FORMAT(BdmEEAmt * 2, '#0.00') END
        ,drvInitialSort = '21'
        ,drvSubSort     = drvSubSort
        ,drvSubSort2    = '3'
        ,drvSubSort3    = drvSubSort3
    INTO dbo.U_ECCICSCEXP_drvTbl_QBMSRI
    FROM dbo.U_ECCICSCEXP_drvTbl_QBPLAN WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_ECCICSCEXP WITH (NOLOCK)
        ON BdmEEID = drvEEID
       AND BdmCoID = drvCoID
       AND ISNULL(BdmDepRecID,'') = drvDepRecID
       AND BdmDedCode = drvDedCode
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = BdmEEID
       AND EecCoID = BdmCoID
    LEFT JOIN (
        Select * from [dbo].[fn_MP_CustomFields_EmpPers_Export](null,null,null,null)
    ) A 
    on A.eeid =  drvEEID
    WHERE BdmRunID = 'QB'
      AND BdmIsPQB = 'Y'
      AND BdmDedType = 'FSA';
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
/*
--Alter the View
ALTER VIEW dbo.dsi_vwECCICSCEXP_Export AS
    SELECT TOP 2000000 Data
    FROM dbo.U_ECCICSCEXP_File WITH (NOLOCK)
    ORDER BY InitialSort, SubSort, SubSort2, SubSort3, RecordSet;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ECCICSCEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
SET expLastStartPerControl = '201601251'
   ,expStartPerControl     = '201601251'
   ,expLastEndPerControl   = '201602039'
   ,expEndPerControl       = '201602039'
WHERE expFormatCode = 'ECCICSCEXP'
  AND expExportCode LIKE 'TEST%';
*/
SET NOCOUNT OFF;
GO
CREATE VIEW dbo.dsi_vwECCICSCEXP_Export AS
    SELECT TOP 2000000 Data
    FROM dbo.U_ECCICSCEXP_File WITH (NOLOCK)
    ORDER BY InitialSort, SubSort, SubSort2, SubSort3, RecordSet;