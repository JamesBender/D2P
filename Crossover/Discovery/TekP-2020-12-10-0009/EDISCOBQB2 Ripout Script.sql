SET NOCOUNT ON;
IF OBJECT_ID('U_EDISCOBQB2_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EDISCOBQB2_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EDISCOBQB2_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EDISCOBQB2' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEDISCOBQB2_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEDISCOBQB2_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EDISCOBQB2') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EDISCOBQB2];
GO
IF OBJECT_ID('U_EDISCOBQB2_File') IS NOT NULL DROP TABLE [dbo].[U_EDISCOBQB2_File];
GO
IF OBJECT_ID('U_EDISCOBQB2_EEList') IS NOT NULL DROP TABLE [dbo].[U_EDISCOBQB2_EEList];
GO
IF OBJECT_ID('U_EDISCOBQB2_drvTbl_QBSTATEINSERTS') IS NOT NULL DROP TABLE [dbo].[U_EDISCOBQB2_drvTbl_QBSTATEINSERTS];
GO
IF OBJECT_ID('U_EDISCOBQB2_drvTbl_QBPLANMBRSPCRATE') IS NOT NULL DROP TABLE [dbo].[U_EDISCOBQB2_drvTbl_QBPLANMBRSPCRATE];
GO
IF OBJECT_ID('U_EDISCOBQB2_drvTbl_QBPLANINITIAL') IS NOT NULL DROP TABLE [dbo].[U_EDISCOBQB2_drvTbl_QBPLANINITIAL];
GO
IF OBJECT_ID('U_EDISCOBQB2_drvTbl_QBEVENT') IS NOT NULL DROP TABLE [dbo].[U_EDISCOBQB2_drvTbl_QBEVENT];
GO
IF OBJECT_ID('U_EDISCOBQB2_drvTbl_QBDEPENDENTPLANINITIAL') IS NOT NULL DROP TABLE [dbo].[U_EDISCOBQB2_drvTbl_QBDEPENDENTPLANINITIAL];
GO
IF OBJECT_ID('U_EDISCOBQB2_drvTbl_QBDEPENDENT') IS NOT NULL DROP TABLE [dbo].[U_EDISCOBQB2_drvTbl_QBDEPENDENT];
GO
IF OBJECT_ID('U_EDISCOBQB2_drvTbl_QB') IS NOT NULL DROP TABLE [dbo].[U_EDISCOBQB2_drvTbl_QB];
GO
IF OBJECT_ID('U_EDISCOBQB2_DedList') IS NOT NULL DROP TABLE [dbo].[U_EDISCOBQB2_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EDISCOBQB2') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EDISCOBQB2];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EDISCOBQB2';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EDISCOBQB2';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EDISCOBQB2';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EDISCOBQB2';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EDISCOBQB2';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EDISCOBQB2','Discovery COBRA QB V2','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','EDISCOBQB2Z0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EDISCOBQB2' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[VERSION]"','1','(''DA''=''Q,'')','EDISCOBQB2Z0','50','H','01','1',NULL,'Version Line Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"1.1"','2','(''DA''=''Q,'')','EDISCOBQB2Z0','50','H','01','2',NULL,'Version Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordIdentifier"','1','(''UA''=''Q,'')','EDISCOBQB2Z0','4','D','10','1',NULL,'Record Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientName"','2','(''UA''=''Q,'')','EDISCOBQB2Z0','100','D','10','2',NULL,'ClientName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientDivisionName"','3','(''UA''=''Q,'')','EDISCOBQB2Z0','50','D','10','3',NULL,'ClientDivisionName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalutation"','4','(''UA''=''Q,'')','EDISCOBQB2Z0','35','D','10','4',NULL,'Salutation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstName"','5','(''UA''=''Q,'')','EDISCOBQB2Z0','50','D','10','5',NULL,'FirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMiddleInitial"','6','(''UA''=''Q,'')','EDISCOBQB2Z0','1','D','10','6',NULL,'MiddleInitial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastName"','7','(''UA''=''Q,'')','EDISCOBQB2Z0','50','D','10','7',NULL,'LastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','8','(''UA''=''Q,'')','EDISCOBQB2Z0','11','D','10','8',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIndividualID"','9','(''UA''=''Q,'')','EDISCOBQB2Z0','20','D','10','9',NULL,'IndividualID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmail"','10','(''UA''=''Q,'')','EDISCOBQB2Z0','50','D','10','10',NULL,'Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhone"','11','(''UA''=''Q,'')','EDISCOBQB2Z0','10','D','10','11',NULL,'Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhone2"','12','(''UA''=''Q,'')','EDISCOBQB2Z0','50','D','10','12',NULL,'Phone2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddress"','13','(''UA''=''Q,'')','EDISCOBQB2Z0','50','D','10','13',NULL,'Address1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddress2"','14','(''UA''=''Q,'')','EDISCOBQB2Z0','50','D','10','14',NULL,'Address2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','15','(''UA''=''Q,'')','EDISCOBQB2Z0','50','D','10','15',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStateOrProvince"','16','(''UA''=''Q,'')','EDISCOBQB2Z0','50','D','10','16',NULL,'StateOrProvince',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPostalCode"','17','(''UA''=''Q,'')','EDISCOBQB2Z0','35','D','10','17',NULL,'PostalCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountry"','18','(''UA''=''Q,'')','EDISCOBQB2Z0','50','D','10','18',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPremiumAddressSameAsPrim"','19','(''UA''=''Q,'')','EDISCOBQB2Z0','50','D','10','19',NULL,'PremiumAddressSameAsPrimary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPremiumAddress"','20','(''UA''=''Q,'')','EDISCOBQB2Z0','50','D','10','20',NULL,'PremiumAddress1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPremiumAddress2"','21','(''UA''=''Q,'')','EDISCOBQB2Z0','50','D','10','21',NULL,'PremiumAddress2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPremiumCity"','22','(''UA''=''Q,'')','EDISCOBQB2Z0','50','D','10','22',NULL,'PremiumCity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPremiumStateOrProvince"','23','(''UA''=''Q,'')','EDISCOBQB2Z0','50','D','10','23',NULL,'PremiumStateOrProvince',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPremiumPostalCode"','24','(''UA''=''Q,'')','EDISCOBQB2Z0','35','D','10','24',NULL,'PremiumPostalCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPremiumCountry"','25','(''UA''=''Q,'')','EDISCOBQB2Z0','50','D','10','25',NULL,'PremiumCountry',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSex"','26','(''UA''=''Q,'')','EDISCOBQB2Z0','1','D','10','26',NULL,'Sex',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDOB"','27','(''UD101''=''Q,'')','EDISCOBQB2Z0','10','D','10','27',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTobaccoUse"','28','(''UA''=''Q,'')','EDISCOBQB2Z0','35','D','10','28',NULL,'TobaccoUse',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeType"','29','(''UA''=''Q,'')','EDISCOBQB2Z0','35','D','10','29',NULL,'EmployeeType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeePayrollType"','30','(''UA''=''Q,'')','EDISCOBQB2Z0','35','D','10','30',NULL,'EmployeePayrollType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYearsOfService"','31','(''UA''=''Q,'')','EDISCOBQB2Z0','50','D','10','31',NULL,'YearsOfService',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPremiumCouponType"','32','(''UA''=''Q,'')','EDISCOBQB2Z0','35','D','10','32',NULL,'PremiumCouponType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUsesHCTC"','33','(''UA''=''Q,'')','EDISCOBQB2Z0','5','D','10','33',NULL,'UsesHCTC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvActive"','34','(''UA''=''Q,'')','EDISCOBQB2Z0','4','D','10','34',NULL,'Active',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAllowMemberSSO"','35','(''UA''=''Q,'')','EDISCOBQB2Z0','1','D','10','35',NULL,'AllowMemberSSO',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitGroup"','36','(''UA''=''Q,'')','EDISCOBQB2Z0','50','D','10','36',NULL,'BenefitGroup',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccountStructure"','37','(''UA''=''Q,'')','EDISCOBQB2Z0','50','D','10','37',NULL,'AccountStructure',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientSpecificData"','38','(''UA''=''Q'')','EDISCOBQB2Z0','50','D','10','38',NULL,'ClientSpecificData',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordIdentifier"','1','(''UA''=''Q,'')','EDISCOBQB2Z0','50','D','20','1',NULL,'Record Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEventType"','2','(''UA''=''Q,'')','EDISCOBQB2Z0','35','D','20','2',NULL,'EventType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEventDate"','3','(''UD101''=''Q,'')','EDISCOBQB2Z0','10','D','20','3',NULL,'EventDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrollmentDate"','4','(''UD101''=''Q,'')','EDISCOBQB2Z0','10','D','20','4',NULL,'EnrollmentDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeSSN"','5','(''UA''=''Q,'')','EDISCOBQB2Z0','9','D','20','5',NULL,'EmployeeSSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeName"','6','(''UA''=''Q,'')','EDISCOBQB2Z0','100','D','20','6',NULL,'EmployeeName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSecondEventOriginalFDOC"','7','(''UA''=''Q'')','EDISCOBQB2Z0','10','D','20','7',NULL,'SecondEventOriginalFDOC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordIdentifier"','1','(''UA''=''Q,'')','EDISCOBQB2Z0','50','D','30','1',NULL,'Record Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanName"','2','(''UA''=''Q,'')','EDISCOBQB2Z0','50','D','30','2',NULL,'PlanName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageLevel"','3','(''UA''=''Q,'')','EDISCOBQB2Z0','35','D','30','3',NULL,'CoverageLevel',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNumberOfUnits"','4','(''UA''=''Q'')','EDISCOBQB2Z0','50','D','30','4',NULL,'NumberOfUnits',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordIdentifier"','1','(''UA''=''Q,'')','EDISCOBQB2Z0','50','D','40','1',NULL,'Record Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','2','(''UA''=''Q,'')','EDISCOBQB2Z0','9','D','40','2',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelationship"','3','(''UA''=''Q,'')','EDISCOBQB2Z0','35','D','40','3',NULL,'Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalutation"','4','(''UA''=''Q,'')','EDISCOBQB2Z0','35','D','40','4',NULL,'Salutation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstName"','5','(''UA''=''Q,'')','EDISCOBQB2Z0','50','D','40','5',NULL,'FirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMiddleInitial"','6','(''UA''=''Q,'')','EDISCOBQB2Z0','1','D','40','6',NULL,'MiddleInitial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastName"','7','(''UA''=''Q,'')','EDISCOBQB2Z0','50','D','40','7',NULL,'LastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmail"','8','(''UA''=''Q,'')','EDISCOBQB2Z0','50','D','40','8',NULL,'Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhone"','9','(''UA''=''Q,'')','EDISCOBQB2Z0','50','D','40','9',NULL,'Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhone2"','10','(''UA''=''Q,'')','EDISCOBQB2Z0','50','D','40','10',NULL,'Phone2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressSameAsQB"','11','(''UA''=''Q,'')','EDISCOBQB2Z0','50','D','40','11',NULL,'AddressSameAsQB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddress"','12','(''UA''=''Q,'')','EDISCOBQB2Z0','50','D','40','12',NULL,'Address1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddress2"','13','(''UA''=''Q,'')','EDISCOBQB2Z0','50','D','40','13',NULL,'Address2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','14','(''UA''=''Q,'')','EDISCOBQB2Z0','50','D','40','14',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStateOrProvince"','15','(''UA''=''Q,'')','EDISCOBQB2Z0','50','D','40','15',NULL,'StateOrProvince',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPostalCode"','16','(''UA''=''Q,'')','EDISCOBQB2Z0','35','D','40','16',NULL,'PostalCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountry"','17','(''UA''=''Q,'')','EDISCOBQB2Z0','50','D','40','17',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrollmentDate"','18','(''UA''=''Q,'')','EDISCOBQB2Z0','10','D','40','18',NULL,'EnrollmentDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSex"','19','(''UA''=''Q,'')','EDISCOBQB2Z0','1','D','40','19',NULL,'Sex',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDOB"','20','(''UD101''=''Q,'')','EDISCOBQB2Z0','10','D','40','20',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIsQMCSO"','21','(''UA''=''Q'')','EDISCOBQB2Z0','5','D','40','21',NULL,'IsQMCSO',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordIdentifier"','1','(''UA''=''Q,'')','EDISCOBQB2Z0','50','D','50','1',NULL,'Record Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanName"','2','(''UA''=''Q'')','EDISCOBQB2Z0','50','D','50','2',NULL,'PlanName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordIdentifier"','1','(''UA''=''Q,'')','EDISCOBQB2Z0','50','D','60','1',NULL,'Record Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanName"','2','(''UA''=''Q,'')','EDISCOBQB2Z0','50','D','60','2',NULL,'PlanName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRate"','3','(''UA''=''Q'')','EDISCOBQB2Z0','50','D','60','3',NULL,'Rate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordIdentifier"','1','(''UA''=''Q,'')','EDISCOBQB2Z0','50','D','70','1',NULL,'Record Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStateSpecDocName"','2','(''UA''=''Q'')','EDISCOBQB2Z0','50','D','70','2',NULL,'State Specific Document Name',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EDISCOBQB2_20210210.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Discovery COBRA QB','202101259','EMPEXPORT','ONDEMAND','Jan  2 2020 12:00AM','EDISCOBQB2',NULL,NULL,NULL,'202101259','Jan  2 2020 12:00AM','Dec 30 1899 12:00AM','202101151',NULL,'','','202101151',dbo.fn_GetTimedKey(),NULL,'ULTI_WPCHMS',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,'SPXBO,SPXK9',NULL,NULL,NULL,'Discovery COBRA QB','202101259','EMPEXPORT','SCHEDULED',NULL,'EDISCOBQB2',NULL,NULL,NULL,'202101259','Nov  5 2019  4:57PM','Nov  5 2019  4:57PM','202101151',NULL,'','','202101151',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','SPXBO,SPXK9',NULL,NULL,NULL,'Test Purposes Only','202101259','EMPEXPORT','TEST','Jan 26 2021 11:44AM','EDISCOBQB2',NULL,NULL,NULL,'202101259','Jun 20 2020 12:00AM','Dec 30 1899 12:00AM','202101151','61','','','202101151',dbo.fn_GetTimedKey(),NULL,'ULTI_WPCHMS',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCOBQB2','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCOBQB2','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCOBQB2','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCOBQB2','SubSort2','C','drvSubSort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCOBQB2','SubSort3','C','drvSubSort3');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCOBQB2','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCOBQB2','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EDISCOBQB2' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EDISCOBQB2' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EDISCOBQB2_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EDISCOBQB2_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCOBQB2','D10','dbo.U_EDISCOBQB2_drvTbl_QB',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCOBQB2','D20','dbo.U_EDISCOBQB2_drvTbl_QBEVENT',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCOBQB2','D30','dbo.U_EDISCOBQB2_drvTbl_QBPLANINITIAL',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCOBQB2','D40','dbo.U_EDISCOBQB2_drvTbl_QBDEPENDENT',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCOBQB2','D50','dbo.U_EDISCOBQB2_drvTbl_QBDEPENDENTPLANINITIAL',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCOBQB2','D60','dbo.U_EDISCOBQB2_drvTbl_QBPLANMBRSPCRATE',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCOBQB2','D70','dbo.U_EDISCOBQB2_drvTbl_QBSTATEINSERTS',NULL);
IF OBJECT_ID('U_dsi_BDM_EDISCOBQB2') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EDISCOBQB2] (
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
IF OBJECT_ID('U_EDISCOBQB2_DedList') IS NULL
CREATE TABLE [dbo].[U_EDISCOBQB2_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EDISCOBQB2_drvTbl_QB') IS NULL
CREATE TABLE [dbo].[U_EDISCOBQB2_drvTbl_QB] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NOT NULL,
    [drvRecordIdentifier] varchar(4) NOT NULL,
    [drvClientName] varchar(46) NOT NULL,
    [drvClientDivisionName] varchar(4) NULL,
    [drvSalutation] varchar(1) NOT NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleInitial] varchar(1) NULL,
    [drvLastName] varchar(100) NULL,
    [drvSSN] char(11) NULL,
    [drvIndividualID] char(9) NULL,
    [drvEmail] varchar(1) NOT NULL,
    [drvPhone] varchar(1) NOT NULL,
    [drvPhone2] varchar(1) NOT NULL,
    [drvAddress] varchar(255) NULL,
    [drvAddress2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvStateOrProvince] varchar(255) NULL,
    [drvPostalCode] varchar(50) NULL,
    [drvCountry] varchar(1) NOT NULL,
    [drvPremiumAddressSameAsPrim] varchar(4) NOT NULL,
    [drvPremiumAddress] varchar(1) NOT NULL,
    [drvPremiumAddress2] varchar(1) NOT NULL,
    [drvPremiumCity] varchar(1) NOT NULL,
    [drvPremiumStateOrProvince] varchar(1) NOT NULL,
    [drvPremiumPostalCode] varchar(1) NOT NULL,
    [drvPremiumCountry] varchar(1) NOT NULL,
    [drvSex] char(1) NULL,
    [drvDOB] datetime NULL,
    [drvTobaccoUse] varchar(7) NOT NULL,
    [drvEmployeeType] varchar(7) NOT NULL,
    [drvEmployeePayrollType] varchar(7) NOT NULL,
    [drvYearsOfService] varchar(1) NOT NULL,
    [drvPremiumCouponType] varchar(10) NOT NULL,
    [drvUsesHCTC] varchar(5) NOT NULL,
    [drvActive] varchar(4) NOT NULL,
    [drvAllowMemberSSO] varchar(1) NOT NULL,
    [drvBenefitGroup] varchar(1) NOT NULL,
    [drvAccountStructure] varchar(1) NOT NULL,
    [drvClientSpecificData] varchar(1) NOT NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(208) NULL
);
IF OBJECT_ID('U_EDISCOBQB2_drvTbl_QBDEPENDENT') IS NULL
CREATE TABLE [dbo].[U_EDISCOBQB2_drvTbl_QBDEPENDENT] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NULL,
    [drvRecordIdentifier] varchar(13) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvRelationship] varchar(15) NULL,
    [drvSalutation] varchar(1) NOT NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleInitial] varchar(1) NULL,
    [drvLastName] varchar(100) NULL,
    [drvEmail] varchar(1) NOT NULL,
    [drvPhone] varchar(1) NOT NULL,
    [drvPhone2] varchar(1) NOT NULL,
    [drvAddressSameAsQB] varchar(5) NOT NULL,
    [drvAddress] varchar(255) NULL,
    [drvAddress2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvStateOrProvince] varchar(255) NULL,
    [drvPostalCode] varchar(50) NULL,
    [drvCountry] char(3) NULL,
    [drvEnrollmentDate] varchar(1) NOT NULL,
    [drvSex] char(1) NULL,
    [drvDOB] datetime NULL,
    [drvIsQMCSO] varchar(1) NOT NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(33) NULL,
    [drvSubSort3] varchar(208) NULL
);
IF OBJECT_ID('U_EDISCOBQB2_drvTbl_QBDEPENDENTPLANINITIAL') IS NULL
CREATE TABLE [dbo].[U_EDISCOBQB2_drvTbl_QBDEPENDENTPLANINITIAL] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NULL,
    [drvRecordIdentifier] varchar(24) NOT NULL,
    [drvPlanName] varchar(29) NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(38) NULL,
    [drvSubSort3] varchar(208) NULL
);
IF OBJECT_ID('U_EDISCOBQB2_drvTbl_QBEVENT') IS NULL
CREATE TABLE [dbo].[U_EDISCOBQB2_drvTbl_QBEVENT] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NOT NULL,
    [drvRecordIdentifier] varchar(9) NOT NULL,
    [drvEventType] varchar(29) NOT NULL,
    [drvEventDate] datetime NULL,
    [drvEnrollmentDate] datetime NULL,
    [drvEmployeeSSN] char(11) NULL,
    [drvEmployeeName] varchar(201) NULL,
    [drvSecondEventOriginalFDOC] varchar(1) NOT NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(208) NULL
);
IF OBJECT_ID('U_EDISCOBQB2_drvTbl_QBPLANINITIAL') IS NULL
CREATE TABLE [dbo].[U_EDISCOBQB2_drvTbl_QBPLANINITIAL] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NOT NULL,
    [drvDedCode] char(5) NULL,
    [drvRecordIdentifier] varchar(15) NOT NULL,
    [drvPlanName] varchar(29) NULL,
    [drvCoverageLevel] varchar(18) NULL,
    [drvNumberOfUnits] varchar(1) NOT NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(6) NULL,
    [drvSubSort3] varchar(208) NULL
);
IF OBJECT_ID('U_EDISCOBQB2_drvTbl_QBPLANMBRSPCRATE') IS NULL
CREATE TABLE [dbo].[U_EDISCOBQB2_drvTbl_QBPLANMBRSPCRATE] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NOT NULL,
    [drvRecordIdentifier] varchar(33) NOT NULL,
    [drvPlanName] varchar(29) NULL,
    [drvRate] money NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(208) NULL
);
IF OBJECT_ID('U_EDISCOBQB2_drvTbl_QBSTATEINSERTS') IS NULL
CREATE TABLE [dbo].[U_EDISCOBQB2_drvTbl_QBSTATEINSERTS] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NULL,
    [drvRecordIdentifier] varchar(16) NOT NULL,
    [drvStateSpecDocName] varchar(13) NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(208) NULL
);
IF OBJECT_ID('U_EDISCOBQB2_EEList') IS NULL
CREATE TABLE [dbo].[U_EDISCOBQB2_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EDISCOBQB2_File') IS NULL
CREATE TABLE [dbo].[U_EDISCOBQB2_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EDISCOBQB2]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Crossover Health Management Services, Inc.

Created By: Kyle Bakhshpour
Business Analyst: Nick Watkins
Create Date: 12/30/2019
Service Request Number: SR-2019-00255978

Purpose: Discovery COBRA QB

Revision History
----------------
Update By           Date           Request Num        Desc
Ozzie Vazquez        06/08/2020       SR-2020-00277104      Added XOXO,XOXO2, and XOXO3 Ded Codes and new Plan Name

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EDISCOBQB2';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EDISCOBQB2';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EDISCOBQB2';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EDISCOBQB2';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EDISCOBQB2' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISCOBQB2', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISCOBQB2', 'TEST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISCOBQB2', 'SCHEDULED';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EDISCOBQB2';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EDISCOBQB2', @AllObjects = 'Y', @IsWeb = 'Y'

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
    SELECT @FormatCode = 'EDISCOBQB2';

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
    DELETE FROM dbo.U_EDISCOBQB2_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EDISCOBQB2_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- BDM Section
    --==========================================
     ------------------
    -- QB params
    ------------------
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;
    
    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'DedCodes','MEDFT,MEDPT,FSA,FSAEV,LFAPT,LPFSA,DENFT,DENPT,VISFT,VISPT,XOXO,XOXO2,XOXO3,XOMFT,XOMPT');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'TermSelectionOption','AuditDate');


    -- COBRA parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'GetChangeReason','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraType','4'); 
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraDate','3'); 
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CountDependents','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS,DP,DPN');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL,STC,DPC,DDP,GRC');
    
    --R Lodge
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','A'); -- Use listed dedcodes where cobra covered
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraPQBType','1'); -- If no EE or spouse, ALL children are PQB (not just oldest)
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'CobraPQBMulti', '1'); 
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraReasonsDepPQB','201,204,210,LEVNT3,LEVNT4'); -- Valid dependent PQB reasons
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidCobraReasonsEmp','201,204,210,LEVNT3,LEVNT4'); -- Invalidate employee when Cobra Reason is a dependent PQB reason
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidTermReasonsEmp','203'); -- Invalidate employee when Cobra Reason is "Death"
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'ConCobraReasonPCF','DependentCOBRAReason'); -- Valid dependent PQB reasons
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CountDependents','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP,DPN');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    -- Run BDM for QB
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EDISCOBQB2_drvTbl_QB
    ---------------------------------
    IF OBJECT_ID('U_EDISCOBQB2_drvTbl_QB','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCOBQB2_drvTbl_QB;
    SELECT DISTINCT
         drvEEID = BdmEEID
        ,drvCoID = BdmCoID
        ,drvDepRecID = ISNULL(BdmDepRecID,'')
        -- standard fields above and additional driver fields below
        ,drvRecordIdentifier = '[QB]'
        ,drvClientName = 'Crossover Health Management Services Inc 35955'
        ,drvClientDivisionName = CASE
                                    WHEN CmpCompanyCode = 'CHMG' THEN 'CHMG'
                                    WHEN CmpCompanyCode = 'CHMS' THEN 'CHMS'
                                 END
        ,drvSalutation = ''
        ,drvFirstName = CASE WHEN BdmRecType = 'EMP' THEN EepNameFirst ELSE ConNameFirst END
        ,drvMiddleInitial = CASE WHEN BdmRecType = 'EMP' THEN LEFT(EepNameMiddle,1) ELSE LEFT(ConNameMiddle,1) END
        ,drvLastName = CASE WHEN BdmRecType = 'EMP' THEN EepNameLast ELSE ConNameLast END
        ,drvSSN = CASE WHEN BdmRecType = 'EMP' THEN eepSSN ELSE ConSSN END
        ,drvIndividualID = EecEmpNo
        ,drvEmail = ''
        ,drvPhone = ''
        ,drvPhone2 = ''
        ,drvAddress = CASE WHEN BdmRecType = 'EMP' THEN EepAddressLine1 ELSE ConAddressLine1 END
        ,drvAddress2 = CASE WHEN BdmRecType = 'EMP' THEN EepAddressLine2 ELSE ConAddressLine2 END
        ,drvCity = CASE WHEN BdmRecType = 'EMP' THEN EepAddressCity ELSE ConAddressCity END
        ,drvStateOrProvince = CASE WHEN BdmRecType = 'EMP' THEN EepAddressState ELSE ConAddressState END
        ,drvPostalCode = CASE WHEN BdmRecType = 'EMP' THEN EepAddressZipCode ELSE ConAddressZipCode END
        ,drvCountry = ''--CASE WHEN BdmRecType = 'EMP' THEN EepAddressCountry ELSE ConAddressCountry END
        ,drvPremiumAddressSameAsPrim = 'TRUE'
        ,drvPremiumAddress = ''
        ,drvPremiumAddress2 = ''
        ,drvPremiumCity = ''
        ,drvPremiumStateOrProvince = ''
        ,drvPremiumPostalCode = ''
        ,drvPremiumCountry = ''
        ,drvSex = CASE WHEN BdmRecType = 'EMP' THEN EepGender ELSE ConGender END
        ,drvDOB = CASE WHEN BdmRecType = 'EMP' THEN EepDateOfBirth ELSE ConDateOfBirth END
        ,drvTobaccoUse = 'UNKNOWN'
        ,drvEmployeeType = 'UNKNOWN'
        ,drvEmployeePayrollType = 'UNKNOWN'
        ,drvYearsOfService = ''
        ,drvPremiumCouponType = 'COUPONBOOK'
        ,drvUsesHCTC = 'FALSE'
        ,drvActive = 'TRUE'
        ,drvAllowMemberSSO = ''
        ,drvBenefitGroup = ''
        ,drvAccountStructure = ''
        ,drvClientSpecificData = ''
        ,drvSubSort        = CASE WHEN BdmRecType = 'EMP' THEN eepSSN
                                      ELSE ISNULL(NULLIF(ConSSN,''),eepSSN) + CONVERT(char(8),ConDateOfBirth,112)
                                 END
        ,drvSubSort2       = '1'
        ,drvSubSort3       = CASE WHEN BdmRecType = 'EMP' THEN '2'
                                      ELSE CONVERT(char(8),ConDateOfBirth,112) + RTRIM(ConNameLast) + ConNameFirst
                                 END
    INTO dbo.U_EDISCOBQB2_drvTbl_QB
    FROM dbo.U_dsi_BDM_EDISCOBQB2 WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = BdmEEID 
        AND EecCoID = BdmCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = BdmEEID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = BdmEEID
        AND ConSystemID = BdmDepRecID
    LEFT JOIN dbo.Company WITH (NOLOCK)
        ON CmpCOID = BdmCOID
    WHERE BdmIsPQB = 'Y'
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EDISCOBQB2_drvTbl_QBEVENT
    ---------------------------------
    IF OBJECT_ID('U_EDISCOBQB2_drvTbl_QBEVENT','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCOBQB2_drvTbl_QBEVENT;
    SELECT DISTINCT
         drvEEID = drvEEID
        ,drvCoID = drvCoID
        ,drvDepRecID = drvDepRecID
        -- standard fields above and additional driver fields below
        ,drvRecordIdentifier = '[QBEVENT]'
        ,drvEventType = CASE 
                                    WHEN EecTermReason = '203' THEN 'DEATH'
                                    WHEN EecTermReason = '202' THEN 'RETIREMENT'
                                    WHEN BdmCobraReason IN ('204','LEVNT4') THEN 'DIVORCELEGALSEPARATION'
                                    WHEN BdmCobraReason IN ('201','LEVNT3') THEN 'INELIGIBLEDEPENDENT'
                                    WHEN BdmCobraReason = '210' THEN 'DEATH'
                                    WHEN BdmCobraReason = '205' THEN 'MEDICARE'
                                    WHEN BdmCobraReason = '203' THEN 'REDUCTIONINHOURS-STATUSCHANGE'
                                    WHEN BdmCobraReason = '206' THEN 'REDUCTIONINHOURS-ENDOFLEAVE'
                                    WHEN BdmCobraReason = '207' THEN 'USERRA-REDUCTIONINHOURS'
                                    WHEN BdmCobraReason = '208' THEN 'RETIREMENT'
                                    WHEN BdmCobraReason = '209' THEN 'WORKSTOPPAGE'
                                    WHEN BdmCobraReason IN ('202','CHGRP') THEN 'LOSSOFELIGIBILITY'
                                    ELSE 'TERMINATION'
                        END
        ,drvEventDate = BdmDateOfCOBRAEvent
        ,drvEnrollmentDate = BdmBenStartDate
        ,drvEmployeeSSN = eepSSN
        ,drvEmployeeName = CASE WHEN BdmRecType = 'DEP' THEN RTRIM(EepNameFirst) + SPACE(1) + EepNameLast END
        ,drvSecondEventOriginalFDOC = ''
        ,drvSubSort        = drvSubSort
        ,drvSubSort2       = '1'
        ,drvSubSort3       = drvSubSort3
    INTO dbo.U_EDISCOBQB2_drvTbl_QBEVENT
    FROM dbo.U_EDISCOBQB2_drvTbl_QB WITH (NOLOCK)
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
                ,BdmBenStopDate = MAX(BdmBenStopDate)
                ,BdmBenStartDate = MIN(BdmBenStartDate)
                ,BdmDateOfCOBRAEvent = MAX(BdmDateOfCOBRAEvent)
                ,BdmUSGDate1 = MAX(BdmUSGDate1)
              FROM dbo.U_dsi_BDM_EDISCOBQB2 WITH (NOLOCK)
              WHERE BdmIsPQB = 'Y'
              GROUP BY BdmEEID, BdmCoID, BdmDepRecID, BdmRecType) BDM
         ON BdmEEID = drvEEID
         AND BdmCoID = drvCoID
         AND ISNULL(BdmDepRecID,'') = drvDepRecID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EDISCOBQB2_drvTbl_QBPLANINITIAL
    ---------------------------------
    IF OBJECT_ID('U_EDISCOBQB2_drvTbl_QBPLANINITIAL','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCOBQB2_drvTbl_QBPLANINITIAL;
    SELECT DISTINCT
         drvEEID = drvEEID
        ,drvCoID = drvCoID
        ,drvDepRecID = drvDepRecID
        -- standard fields above and additional driver fields below
        ,drvDedCode = BdmDedCode
        ,drvRecordIdentifier = '[QBPLANINITIAL]'
        ,drvPlanName = CASE
                            WHEN BdmDedCode IN ('MEDFT','MEDPT') THEN 'Aetna Medical PPO HSA 2000'
                            WHEN BdmDedCode IN ('FSA','FSAEV','LFAPT','LPFSA') THEN 'Discovery Benefits FSA'
                            WHEN BdmDedCode LIKE 'DEN%' THEN 'Guardian Dental PPO Preferred'
                            WHEN BdmDedCode LIKE 'VIS%' THEN 'Guardian Vision'
                            WHEN BdmDedCode IN ('XOXO','XOXO2','XOXO3') THEN 'Crossover Health XO4XO'
                            WHEN BdmDedCode IN ('XOMPT') THEN 'XO First PPO'
                            WHEN BdmDedCode IN ('XOMFT') THEN 'Aetna Medical XO First PPO'

                        END
        ,drvCoverageLevel = CASE WHEN BdmDedType = 'FSA' THEN 'EE'
                                 WHEN BdmRecType = 'EMP' THEN
                                      CASE WHEN BdmBenOption IN ('EE') THEN 'EE'
                                           WHEN BdmBenOption IN ('EEC') AND BdmNumChildren = 1 THEN 'EE+CHILD'
                                           WHEN BdmBenOption In ('EEC') AND BdmNumChildren > 1 THEN 'EE+CHILDREN'
                                           WHEN BdmBenOption IN ('EES') THEN 'EE+SPOUSE'
                                           WHEN BdmBenOption IN ('EEDP') THEN 'EE+DOMESTICPARTNER'
                                           WHEN BdmBenOption IN ('EEF','EEDPCH','EEDPF') THEN 'EE+FAMILY'
                                      END
                                 WHEN BdmRelationship IN ('SPS','DP','DPN') THEN
                                      CASE WHEN ISNULL(BdmNumChildren,0) = 1 THEN 'EE+CHILD'
                                           WHEN ISNULL(BdmNumChildren,0) > 1 THEN 'EE+CHILDREN'
                                           ELSE 'EE'
                                      END
                                 ELSE 'EE'
                            END
        ,drvNumberOfUnits = ''
        ,drvSubSort       = drvSubSort
        ,drvSubSort2      = '1' + BdmDedCode
        ,drvSubSort3      = drvSubSort3
    INTO dbo.U_EDISCOBQB2_drvTbl_QBPLANINITIAL
    FROM dbo.U_EDISCOBQB2_drvTbl_QBEVENT WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EDISCOBQB2 WITH (NOLOCK)
        ON BdmEEID = drvEEID 
        AND BdmCoID = drvCoID
        AND ISNULL(BdmDepRecID,'') = drvDepRecID
    WHERE BdmIsPQB = 'Y'
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EDISCOBQB2_drvTbl_QBDEPENDENT
    ---------------------------------
    IF OBJECT_ID('U_EDISCOBQB2_drvTbl_QBDEPENDENT','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCOBQB2_drvTbl_QBDEPENDENT;
    SELECT DISTINCT
         drvEEID = bdmEEID
        ,drvCoID = bdmCoID
        ,drvDepRecID = BdmDepRecID
        -- standard fields above and additional driver fields below
        ,drvRecordIdentifier = '[QBDEPENDENT]'
        ,drvSSN = conSSN
        ,drvRelationship = CASE
                                WHEN BdmRelationship = 'SPS' THEN 'SPOUSE'
                                WHEN BdmRelationship IN ('DP', 'DPN') THEN 'DOMESTICPARTNER'
                                WHEN BdmRelationship IN ('CHL', 'DDP', 'DPC', 'GRC', 'STC') THEN 'CHILD'
                           END
        ,drvSalutation = ''
        ,drvFirstName = ConNameFirst
        ,drvMiddleInitial = LEFT(ConNameMiddle,1)
        ,drvLastName = ConNameLast
        ,drvEmail = ''
        ,drvPhone = ''
        ,drvPhone2 = ''
        ,drvAddressSameAsQB = CASE WHEN ConAddressIsDifferent = 'N' OR ConAddressLine1 IS NULL THEN 'TRUE' ELSE 'FALSE' END
        ,drvAddress = ConAddressLine1
        ,drvAddress2 = ConAddressLine2
        ,drvCity = ConAddressCity
        ,drvStateOrProvince = ConAddressState
        ,drvPostalCode = ConAddressZipCode
        ,drvCountry = CASE WHEN ConAddressCountry <> 'USA' THEN ConAddressCountry END
        ,drvEnrollmentDate = ''
        ,drvSex = ConGender
        ,drvDOB = ConDateOfBirth
        ,drvIsQMCSO = ''
        ,drvSubSort        = drvSubSort
        ,drvSubSort2       = '2' + CASE WHEN BdmRelationship IN ('SPS','DP','DPN') THEN 'A'
                                            ELSE 'B' + ISNULL(ConSSN,ConNameFirst)
                                       END + CONVERT(char(8),ISNULL(ConDateOfBirth,''),112) + ConSystemID
        ,drvSubSort3       = drvSubSort3
    INTO dbo.U_EDISCOBQB2_drvTbl_QBDEPENDENT
    FROM dbo.U_EDISCOBQB2_drvTbl_QB WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EDISCOBQB2 WITH (NOLOCK)
        ON BdmEEID = drvEEID 
        AND BdmCoID = drvCoID
     JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = bdmEEID
        AND ConSystemID = BdmDepRecID
    WHERE BdmIsPQB = 'N'
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EDISCOBQB2_drvTbl_QBDEPENDENTPLANINITIAL
    ---------------------------------
    IF OBJECT_ID('U_EDISCOBQB2_drvTbl_QBDEPENDENTPLANINITIAL','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCOBQB2_drvTbl_QBDEPENDENTPLANINITIAL;
    SELECT DISTINCT
         drvEEID = BdmEEID
        ,drvCoID = BdmCoID
        ,drvDepRecID = BdmDepRecID
        -- standard fields above and additional driver fields below
        ,drvRecordIdentifier = '[QBDEPENDENTPLANINITIAL]'
        ,drvPlanName = drvPlanName
        ,drvSubSort  = drvSubSort
        ,drvSubSort2 = '2' + CASE WHEN BdmRelationship IN ('SPS','DP','DPN') THEN 'A'
                                      ELSE 'B' + RTRIM(ISNULL(ConSSN,ConNameFirst))
                                 END + CONVERT(char(8),ISNULL(ConDateOfBirth,''),112) + ConSystemID + BdmDedCode
        ,drvSubSort3 = drvSubSort3
    INTO dbo.U_EDISCOBQB2_drvTbl_QBDEPENDENTPLANINITIAL
    FROM dbo.U_EDISCOBQB2_drvTbl_QBPLANINITIAL WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EDISCOBQB2 WITH (NOLOCK)
        ON BdmEEID = drvEEID 
        AND BdmCoID = drvCoID
        AND BdmDedcode = drvDedCode
    JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = BdmEEID
        AND ConSystemID = BdmDepRecID
    WHERE BdmIsPQB = 'N'
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EDISCOBQB2_drvTbl_QBPLANMBRSPCRATE
    ---------------------------------
    IF OBJECT_ID('U_EDISCOBQB2_drvTbl_QBPLANMBRSPCRATE','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCOBQB2_drvTbl_QBPLANMBRSPCRATE;
    SELECT DISTINCT
         drvEEID = drvEEID
        ,drvCoID = drvCoID
        ,drvDepRecID = drvDepRecID
        -- standard fields above and additional driver fields below
        ,drvRecordIdentifier = '[QBPLANMEMBERSPECIFICRATEINITIAL]'
        ,drvPlanName = drvPlanName
        ,drvRate = CASE 
                        WHEN EecPayPeriod = 'M' THEN BdmEEAmt
                        WHEN EecPayPeriod = 'S' THEN BdmEEAmt*2
                        WHEN EecPayPeriod = 'B' THEN ((BdmEEAmt*24)/12)
                        WHEN EecPayPeriod = 'W' THEN ((BdmEEAmt*52)/12)
                   END
        ,drvSubSort  = drvSubSort
        ,drvSubSort2 = '3'
        ,drvSubSort3 = drvSubSort3
    INTO dbo.U_EDISCOBQB2_drvTbl_QBPLANMBRSPCRATE
    FROM dbo.U_EDISCOBQB2_drvTbl_QBPLANINITIAL WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EDISCOBQB2 WITH (NOLOCK)
            ON BdmEEID = drvEEID
           AND BdmCoID = drvCoID
           AND ISNULL(BdmDepRecID,'') = drvDepRecID
           AND BdmDedCode = drvDedCode
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = BdmEEID 
        AND EecCoID = BdmCoID
    WHERE BdmIsPQB = 'Y'
    AND BdmDedtype = 'FSA'
    ;

    -- DETAIL RECORD - U_EDISCOBQB2_drvTbl_QBSTATEINSERTS
    ---------------------------------
    IF OBJECT_ID('U_EDISCOBQB2_drvTbl_QBSTATEINSERTS','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCOBQB2_drvTbl_QBSTATEINSERTS;
    SELECT DISTINCT
         drvEEID = bdmEEID
        ,drvCoID = bdmCoID
        ,drvDepRecID = BdmDepRecID
        -- standard fields above and additional driver fields below
        ,drvRecordIdentifier = '[QBSTATEINSERTS]'
        ,drvStateSpecDocName = CASE EepAddressState
                                   WHEN 'CA' THEN 'CA-SRINSERT'
                                   WHEN 'CT' THEN 'CT-SRINSERT'
                                   WHEN 'MN' THEN 'MN-LIFEINSERT'
                                   WHEN 'OR' THEN 'OR-SRINSERT'
                                   WHEN 'TX' THEN 'TX-SRINSERT'
                                   WHEN 'NY' THEN 'NY-SR INSERT'
                                   WHEN 'IL' THEN 'IL-SRINSERT'
                                   WHEN 'RI' THEN 'RI-SRINSERT'
                                   WHEN 'GA' THEN 'GA-SRINSERT'
                                   WHEN 'VA' THEN 'VA-SRINSERT'
                               END
        ,drvSubSort        = CASE WHEN BdmRecType = 'EMP' THEN eepSSN
                                      ELSE ISNULL(NULLIF(ConSSN,''),eepSSN) + CONVERT(char(8),ConDateOfBirth,112)
                                 END
        ,drvSubSort2       = '1'
        ,drvSubSort3       = CASE WHEN BdmRecType = 'EMP' THEN '2'
                                      ELSE CONVERT(char(8),ConDateOfBirth,112) + RTRIM(ConNameLast) + ConNameFirst
                                 END
    INTO dbo.U_EDISCOBQB2_drvTbl_QBSTATEINSERTS
    FROM dbo.U_dsi_BDM_EDISCOBQB2 WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = BdmEEID
        AND EecCoID = BdmCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = BdmEEID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = BdmEEID
        AND ConSystemID = BdmDepRecID
    LEFT JOIN dbo.Company WITH (NOLOCK)
        ON CmpCOID = BdmCOID
    WHERE BdmIsPQB = 'Y'
    AND EepAddressState IN ('CA','CT','MN','OR','TX','NY','IL','RI','GA','VA')
    ;
    
END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEDISCOBQB2_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EDISCOBQB2_File (NOLOCK)
    ORDER BY CASE WHEN LEFT(RecordSet,1) = 'H' THEN 1 ELSE 2 END, InitialSort, RIGHT(RecordSet,2)

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EDISCOBQB2%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201907011'
       ,expStartPerControl     = '201907011'
       ,expLastEndPerControl   = '201911059'
       ,expEndPerControl       = '201911059'
WHERE expFormatCode = 'EDISCOBQB2';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEDISCOBQB2_Export AS
    SELECT TOP 2000000 Data
    FROM dbo.U_EDISCOBQB2_File WITH (NOLOCK)
    ORDER BY InitialSort, SubSort, SubSort2, SubSort3, RecordSet;