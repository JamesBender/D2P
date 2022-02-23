SET NOCOUNT ON;
IF OBJECT_ID('U_ECYCCOBRA_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECYCCOBRA_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ECYCCOBRA_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ECYCCOBRA' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwECYCCOBRA_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECYCCOBRA_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECYCCOBRA') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECYCCOBRA];
GO
IF OBJECT_ID('U_ECYCCOBRA_Header_QB') IS NOT NULL DROP TABLE [dbo].[U_ECYCCOBRA_Header_QB];
GO
IF OBJECT_ID('U_ECYCCOBRA_Header_NPM') IS NOT NULL DROP TABLE [dbo].[U_ECYCCOBRA_Header_NPM];
GO
IF OBJECT_ID('U_ECYCCOBRA_File') IS NOT NULL DROP TABLE [dbo].[U_ECYCCOBRA_File];
GO
IF OBJECT_ID('U_ECYCCOBRA_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECYCCOBRA_EEList];
GO
IF OBJECT_ID('U_ECYCCOBRA_drvTbl_QBPLAN_2') IS NOT NULL DROP TABLE [dbo].[U_ECYCCOBRA_drvTbl_QBPLAN_2];
GO
IF OBJECT_ID('U_ECYCCOBRA_drvTbl_QBPLAN') IS NOT NULL DROP TABLE [dbo].[U_ECYCCOBRA_drvTbl_QBPLAN];
GO
IF OBJECT_ID('U_ECYCCOBRA_drvTbl_QBEVENT') IS NOT NULL DROP TABLE [dbo].[U_ECYCCOBRA_drvTbl_QBEVENT];
GO
IF OBJECT_ID('U_ECYCCOBRA_drvTbl_QBDEPINIT_2') IS NOT NULL DROP TABLE [dbo].[U_ECYCCOBRA_drvTbl_QBDEPINIT_2];
GO
IF OBJECT_ID('U_ECYCCOBRA_drvTbl_QBDEPINIT') IS NOT NULL DROP TABLE [dbo].[U_ECYCCOBRA_drvTbl_QBDEPINIT];
GO
IF OBJECT_ID('U_ECYCCOBRA_drvTbl_QBDEP') IS NOT NULL DROP TABLE [dbo].[U_ECYCCOBRA_drvTbl_QBDEP];
GO
IF OBJECT_ID('U_ECYCCOBRA_drvTbl_QB') IS NOT NULL DROP TABLE [dbo].[U_ECYCCOBRA_drvTbl_QB];
GO
IF OBJECT_ID('U_ECYCCOBRA_drvTbl_NPM') IS NOT NULL DROP TABLE [dbo].[U_ECYCCOBRA_drvTbl_NPM];
GO
IF OBJECT_ID('U_ECYCCOBRA_DedList') IS NOT NULL DROP TABLE [dbo].[U_ECYCCOBRA_DedList];
GO
IF OBJECT_ID('U_ECYCCOBRA_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ECYCCOBRA_AuditFields];
GO
IF OBJECT_ID('U_ECYCCOBRA_Audit') IS NOT NULL DROP TABLE [dbo].[U_ECYCCOBRA_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_ECYCCOBRA') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ECYCCOBRA];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ECYCCOBRA';
DELETE [dbo].[U_dsi_RecordSetDetails] FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode = 'ECYCCOBRA';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ECYCCOBRA';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ECYCCOBRA';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ECYCCOBRA';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ECYCCOBRA';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ECYCCOBRA','CYC COBRA Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','ECYCCOBRA0Z0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ECYCCOBRA' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVersionLineIdentifierNPM"','1','(''UA''=''T,'')','ECYCCOBRA0Z0','50','H','01','1',NULL,'Version Line Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVersionNumberNPM"','2','(''UA''=''T'')','ECYCCOBRA0Z0','50','H','01','2',NULL,'Version Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVersionLineIdentifierQB"','1','(''UA''=''T,'')','ECYCCOBRA0Z0','50','H','02','1',NULL,'Version Line Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVersionNumberQB"','2','(''UA''=''T'')','ECYCCOBRA0Z0','50','H','02','2',NULL,'Version Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVersionLineIdentifier"','1','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','10','1',NULL,'Version Line Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','2','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','10','2',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIndividualIdentifier"','3','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','10','3',NULL,'IndividualIdentifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientName"','4','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','10','4',NULL,'ClientName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientDivisionName"','5','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','10','5',NULL,'ClientDivisionName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstName"','6','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','10','6',NULL,'FirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMiddleInitial"','7','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','10','7',NULL,'MiddleInitial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastName"','8','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','10','8',NULL,'LastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalutation"','9','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','10','9',NULL,'Salutation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmail"','10','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','10','10',NULL,'Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhone"','11','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','10','11',NULL,'Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhone2"','12','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','10','12',NULL,'Phone2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddress1"','13','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','10','13',NULL,'Address1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddress2"','14','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','10','14',NULL,'Address2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','15','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','10','15',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStateOrProvince"','16','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','10','16',NULL,'StateOrProvince',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPostalCode"','17','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','10','17',NULL,'PostalCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountry"','18','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','10','18',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSex"','19','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','10','19',NULL,'Sex',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUsesFamilyInAddress"','20','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','10','20',NULL,'UsesFamilyInAddress',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHasWaivedAllCoverage"','21','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','10','21',NULL,'HasWaivedAllCoverage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSendGRNotice"','22','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','10','22',NULL,'SendGRNotice',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHireDate"','23','(''UD101''=''T'')','ECYCCOBRA0Z0','50','D','10','23',NULL,'Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordIdentifierQB"','1','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','20','1',NULL,'Record Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientNameQB"','2','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','20','2',NULL,'ClientName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientDivisionNameQB"','3','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','20','3',NULL,'ClientDivisionName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalutationQB"','4','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','20','4',NULL,'Salutation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstNameQB"','5','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','20','5',NULL,'FirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMiddleInitialQB"','6','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','20','6',NULL,'MiddleInitial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastNameQB"','7','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','20','7',NULL,'LastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSNQB"','8','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','20','8',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIndividualIDQB"','9','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','20','9',NULL,'IndividualID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmailQB"','10','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','20','10',NULL,'Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneQB"','11','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','20','11',NULL,'Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhone2QB"','12','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','20','12',NULL,'Phone2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddress1QB"','13','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','20','13',NULL,'Address1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddress2QB"','14','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','20','14',NULL,'Address2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCityQB"','15','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','20','15',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStateOrProvinceQB"','16','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','20','16',NULL,'StateOrProvince',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPostalCodeQB"','17','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','20','17',NULL,'PostalCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountryQB"','18','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','20','18',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPremAddressSameAsPrimQB"','19','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','20','19',NULL,'PremiumAddressSameAsPrimary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPremiumAddress1QB"','20','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','20','20',NULL,'PremiumAddress1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPremiumAddress2QB"','21','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','20','21',NULL,'PremiumAddress2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPremiumCityQB"','22','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','20','22',NULL,'PremiumCity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPremiumStateOrProvinceQB"','23','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','20','23',NULL,'PremiumStateOrProvince',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPremiumPostalCodeQB"','24','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','20','24',NULL,'PremiumPostalCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPremiumCountryQB"','25','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','20','25',NULL,'PremiumCountry',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSexQB"','26','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','20','26',NULL,'Sex',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDOBQB"','27','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','20','27',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTobaccoUseQB"','28','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','20','28',NULL,'TobaccoUse',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeTypeQB"','29','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','20','29',NULL,'EmployeeType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeePayrollTypeQB"','30','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','20','30',NULL,'EmployeePayrollType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYearsOfServiceQB"','31','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','20','31',NULL,'YearsOfService',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPremiumCouponTypeQB"','32','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','20','32',NULL,'PremiumCouponType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUsesHCTCQB"','33','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','20','33',NULL,'UsesHCTC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvActiveQB"','34','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','20','34',NULL,'Active',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAllowMemberSSOQB"','35','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','20','35',NULL,'AllowMemberSSO',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitGroupQB"','36','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','20','36',NULL,'BenefitGroup',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccountStructureQB"','37','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','20','37',NULL,'AccountStructure',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientSpecificDataQB"','38','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','20','38',NULL,'ClientSpecificData',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSOIDQB"','39','(''UA''=''T'')','ECYCCOBRA0Z0','50','D','20','39',NULL,'SSOID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordIdentifierQBEv"','1','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','30','1',NULL,'Record Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEveECYCntTypeQBEv"','2','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','30','2',NULL,'EveECYCntType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEventDateQBEv"','3','(''UD101''=''T,'')','ECYCCOBRA0Z0','50','D','30','3',NULL,'EventDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrollmentDateQBEv"','4','(''UD101''=''T,'')','ECYCCOBRA0Z0','50','D','30','4',NULL,'EnrollmentDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeSSNQBEv"','5','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','30','5',NULL,'EmployeeSSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeNameQBEv"','6','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','30','6',NULL,'EmployeeName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSecondEvntOrigiFDOCQBEv"','7','(''UA''=''T'')','ECYCCOBRA0Z0','50','D','30','7',NULL,'SecondEventOriginalFDOC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordIdentifierQBPL"','1','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','40','1',NULL,'Record Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanNameQBPL"','2','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','40','2',NULL,'PlanName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStartDateQBPL"','3','(''UD101''=''T,'')','ECYCCOBRA0Z0','50','D','40','3',NULL,'StartDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEndDateQBPL"','4','(''UD101''=''T,'')','ECYCCOBRA0Z0','50','D','40','4',NULL,'EndDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageLevelQBPL"','5','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','40','5',NULL,'CoverageLevel',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstDayOfCOBRAQBPL"','6','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','40','6',NULL,'FirstDayOfCOBRA',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastDayOfCOBRAQBPL"','7','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','40','7',NULL,'LastDayOfCOBRA',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCOBRADurationMonthsQBPL"','8','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','40','8',NULL,'COBRADurationMonths',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDaysToElectQBPL"','9','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','40','9',NULL,'DaysToElect',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDaysToMake1stPaymentQBPL"','10','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','40','10',NULL,'DaysToMake1stPayment',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDaysToMakeSubPymntQBPL"','11','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','40','11',NULL,'DaysToMakeSubsequentPayments',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvElectionPostmarkDateQBPL"','12','(''UD101''=''T,'')','ECYCCOBRA0Z0','50','D','40','12',NULL,'ElectionPostmarkDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastDateRatesNotifiedQBPL"','13','(''UD101''=''T,'')','ECYCCOBRA0Z0','50','D','40','13',NULL,'LastDateRatesNotified',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNumberOfUnitsQBPL"','14','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','40','14',NULL,'NumberOfUnits',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSendPlanChLetterLegacyQBPL"','15','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','40','15',NULL,'SendPlanChangeLetterForLegacy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanBundleNameQBPL"','16','(''UA''=''T'')','ECYCCOBRA0Z0','50','D','40','16',NULL,'PlanBundleName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordIdentifierQBDEP"','1','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','50','1',NULL,'Record Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSNQBDEP"','2','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','50','2',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelationshipQBDEP"','3','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','50','3',NULL,'Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalutationQBDEP"','4','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','50','4',NULL,'Salutation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstNameQBDEP"','5','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','50','5',NULL,'FirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMiddleInitialQBDEP"','6','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','50','6',NULL,'MiddleInitial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastNameQBDEP"','7','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','50','7',NULL,'LastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmailQBDEP"','8','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','50','8',NULL,'Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneQBDEP"','9','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','50','9',NULL,'Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhone2QBDEP"','10','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','50','10',NULL,'Phone2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressSameAsQBQBDEP"','11','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','50','11',NULL,'AddressSameAsQB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddress1QBDEP"','12','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','50','12',NULL,'Address1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddress2QBDEP"','13','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','50','13',NULL,'Address2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCityQBDEP"','14','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','50','14',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStateOrProvinceQBDEP"','15','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','50','15',NULL,'StateOrProvince',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPostalCodeQBDEP"','16','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','50','16',NULL,'PostalCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountryQBDEP"','17','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','50','17',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrollmentDateQBDEP"','18','(''UD101''=''T,'')','ECYCCOBRA0Z0','50','D','50','18',NULL,'EnrollmentDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSexQBDEP"','19','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','50','19',NULL,'Sex',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDOBQBDEP"','20','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','50','20',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIsQMCSOQBDEP"','21','(''UA''=''T'')','ECYCCOBRA0Z0','50','D','50','21',NULL,'IsQMCSO',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordIdentifierQBDEPinit"','1','(''UA''=''T,'')','ECYCCOBRA0Z0','50','D','60','1',NULL,'Record Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanNameQBDEPinit"','2','(''UA''=''T'')','ECYCCOBRA0Z0','50','D','60','2',NULL,'PlanName',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'ECYCCOBRA_20210223.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','',',89C3O,88X2J',NULL,NULL,NULL,'CYC COBRA NPM Export','201703319','EMPEXPORT','NPMFILE',NULL,'ECYCCOBRA',NULL,NULL,NULL,'201703319','Feb 27 2020  5:41AM','Feb 27 2020  5:41AM','201701011',NULL,'','','201701011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','',',89C3O,88X2J',NULL,NULL,NULL,'CYC COBRA QB Export','201703319','EMPEXPORT','QBFILE',NULL,'ECYCCOBRA',NULL,NULL,NULL,'201703319','Feb 27 2020  5:41AM','Feb 27 2020  5:41AM','201701011',NULL,'','','201701011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,',89C3O,88X2J',NULL,NULL,NULL,'CYC COBRA NPM TEST','201703319','EMPEXPORT','TESTNPM',NULL,'ECYCCOBRA',NULL,NULL,NULL,'201703319','Feb 27 2020  5:41AM','Feb 27 2020  5:41AM','201701011',NULL,'','','201701011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,',89C3O,88X2J',NULL,NULL,NULL,'CYC COBRA QB TEST','201703319','EMPEXPORT','TESTQB',NULL,'ECYCCOBRA',NULL,NULL,NULL,'201703319','Feb 27 2020  5:41AM','Feb 27 2020  5:41AM','201701011',NULL,'','','201701011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECYCCOBRA','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECYCCOBRA','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECYCCOBRA','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECYCCOBRA','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECYCCOBRA','SubSort2','C','drvSubsort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECYCCOBRA','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECYCCOBRA','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'ECYCCOBRA' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'ECYCCOBRA' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_ECYCCOBRA_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECYCCOBRA_SavePath];
GO
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('ECYCCOBRA','NPMFILE','H','02','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('ECYCCOBRA','NPMFILE','D','20','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('ECYCCOBRA','NPMFILE','D','30','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('ECYCCOBRA','NPMFILE','D','40','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('ECYCCOBRA','NPMFILE','D','50','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('ECYCCOBRA','NPMFILE','D','60','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('ECYCCOBRA','TESTNPM','H','02','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('ECYCCOBRA','TESTNPM','D','20','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('ECYCCOBRA','TESTNPM','D','30','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('ECYCCOBRA','TESTNPM','D','40','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('ECYCCOBRA','TESTNPM','D','50','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('ECYCCOBRA','TESTNPM','D','60','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('ECYCCOBRA','QBFILE','H','01','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('ECYCCOBRA','QBFILE','D','10','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('ECYCCOBRA','TESTQB','H','01','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('ECYCCOBRA','TESTQB','D','10','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('ECYCCOBRA','NPMFILE','H','02','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('ECYCCOBRA','NPMFILE','D','20','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('ECYCCOBRA','NPMFILE','D','30','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('ECYCCOBRA','NPMFILE','D','40','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('ECYCCOBRA','NPMFILE','D','50','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('ECYCCOBRA','NPMFILE','D','60','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('ECYCCOBRA','TESTNPM','H','02','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('ECYCCOBRA','TESTNPM','D','20','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('ECYCCOBRA','TESTNPM','D','30','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('ECYCCOBRA','TESTNPM','D','40','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('ECYCCOBRA','TESTNPM','D','50','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('ECYCCOBRA','TESTNPM','D','60','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('ECYCCOBRA','QBFILE','H','01','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('ECYCCOBRA','QBFILE','D','10','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('ECYCCOBRA','TESTQB','H','01','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('ECYCCOBRA','TESTQB','D','10','Y','F');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECYCCOBRA','H01','dbo.U_ECYCCOBRA_Header_NPM',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECYCCOBRA','H02','dbo.U_ECYCCOBRA_Header_QB',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECYCCOBRA','D10','dbo.U_ECYCCOBRA_drvTbl_NPM',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECYCCOBRA','D20','dbo.U_ECYCCOBRA_drvTbl_QB',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECYCCOBRA','D30','dbo.U_ECYCCOBRA_drvTbl_QBEVENT',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECYCCOBRA','D40','dbo.U_ECYCCOBRA_drvTbl_QBPLAN',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECYCCOBRA','D50','dbo.U_ECYCCOBRA_drvTbl_QBDEP',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECYCCOBRA','D60','dbo.U_ECYCCOBRA_drvTbl_QBDEPINIT',NULL);
IF OBJECT_ID('U_dsi_BDM_ECYCCOBRA') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ECYCCOBRA] (
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
IF OBJECT_ID('U_ECYCCOBRA_Audit') IS NULL
CREATE TABLE [dbo].[U_ECYCCOBRA_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audKey2] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] varchar(2000) NULL,
    [audNewValue] varchar(2000) NULL,
    [audRowNo] bigint NULL
);
IF OBJECT_ID('U_ECYCCOBRA_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ECYCCOBRA_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_ECYCCOBRA_DedList') IS NULL
CREATE TABLE [dbo].[U_ECYCCOBRA_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ECYCCOBRA_drvTbl_NPM') IS NULL
CREATE TABLE [dbo].[U_ECYCCOBRA_drvTbl_NPM] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(13) NULL,
    [drvSubSort] varchar(13) NULL,
    [drvSubsort2] varchar(1) NOT NULL,
    [drvDepRecID] char(12) NULL,
    [drvVersionLineIdentifier] varchar(5) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvIndividualIdentifier] char(9) NULL,
    [drvClientName] varchar(24) NOT NULL,
    [drvClientDivisionName] nvarchar(4000) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleInitial] varchar(1) NULL,
    [drvLastName] varchar(131) NOT NULL,
    [drvSalutation] varchar(1) NOT NULL,
    [drvEmail] varchar(50) NULL,
    [drvPhone] varchar(50) NULL,
    [drvPhone2] varchar(1) NOT NULL,
    [drvAddress1] varchar(255) NULL,
    [drvAddress2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvStateOrProvince] varchar(255) NULL,
    [drvPostalCode] varchar(50) NULL,
    [drvCountry] varchar(1) NOT NULL,
    [drvSex] char(1) NULL,
    [drvUsesFamilyInAddress] varchar(5) NOT NULL,
    [drvHasWaivedAllCoverage] varchar(5) NOT NULL,
    [drvSendGRNotice] varchar(4) NOT NULL,
    [drvHireDate] varchar(30) NULL
);
IF OBJECT_ID('U_ECYCCOBRA_drvTbl_QB') IS NULL
CREATE TABLE [dbo].[U_ECYCCOBRA_drvTbl_QB] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(13) NULL,
    [drvSubSort] varchar(13) NULL,
    [drvSubsort2] varchar(1) NOT NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvRecordIdentifierQB] varchar(4) NOT NULL,
    [drvClientNameQB] varchar(24) NOT NULL,
    [drvClientDivisionNameQB] nvarchar(4000) NULL,
    [drvSalutationQB] varchar(1) NOT NULL,
    [drvFirstNameQB] varchar(100) NULL,
    [drvMiddleInitialQB] varchar(1) NULL,
    [drvLastNameQB] varchar(131) NULL,
    [drvSSNQB] char(11) NULL,
    [drvIndividualIDQB] char(9) NULL,
    [drvEmailQB] varchar(1) NOT NULL,
    [drvPhoneQB] varchar(1) NOT NULL,
    [drvPhone2QB] varchar(1) NOT NULL,
    [drvAddress1QB] varchar(255) NULL,
    [drvAddress2QB] varchar(255) NULL,
    [drvCityQB] varchar(255) NULL,
    [drvStateOrProvinceQB] varchar(255) NULL,
    [drvPostalCodeQB] varchar(50) NULL,
    [drvCountryQB] varchar(1) NOT NULL,
    [drvPremAddressSameAsPrimQB] varchar(4) NOT NULL,
    [drvPremiumAddress1QB] varchar(1) NOT NULL,
    [drvPremiumAddress2QB] varchar(1) NOT NULL,
    [drvPremiumCityQB] varchar(1) NOT NULL,
    [drvPremiumStateOrProvinceQB] varchar(1) NOT NULL,
    [drvPremiumPostalCodeQB] varchar(1) NOT NULL,
    [drvPremiumCountryQB] varchar(1) NOT NULL,
    [drvSexQB] char(1) NULL,
    [drvDOBQB] varchar(30) NULL,
    [drvTobaccoUseQB] varchar(7) NOT NULL,
    [drvEmployeeTypeQB] varchar(7) NOT NULL,
    [drvEmployeePayrollTypeQB] varchar(7) NOT NULL,
    [drvYearsOfServiceQB] varchar(1) NOT NULL,
    [drvPremiumCouponTypeQB] varchar(13) NOT NULL,
    [drvUsesHCTCQB] varchar(5) NOT NULL,
    [drvActiveQB] varchar(4) NOT NULL,
    [drvAllowMemberSSOQB] varchar(5) NOT NULL,
    [drvBenefitGroupQB] varchar(1) NOT NULL,
    [drvAccountStructureQB] varchar(30) NULL,
    [drvClientSpecificDataQB] varchar(1) NOT NULL,
    [drvSSOIDQB] varchar(1) NOT NULL
);
IF OBJECT_ID('U_ECYCCOBRA_drvTbl_QBDEP') IS NULL
CREATE TABLE [dbo].[U_ECYCCOBRA_drvTbl_QBDEP] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(13) NULL,
    [drvSubSort] varchar(13) NULL,
    [drvSubsort2] varchar(12) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvRecordIdentifierQBDEP] varchar(13) NOT NULL,
    [drvSSNQBDEP] char(11) NOT NULL,
    [drvRelationshipQBDEP] varchar(15) NULL,
    [drvSalutationQBDEP] varchar(1) NOT NULL,
    [drvFirstNameQBDEP] varchar(100) NULL,
    [drvMiddleInitialQBDEP] varchar(1) NULL,
    [drvLastNameQBDEP] varchar(131) NOT NULL,
    [drvEmailQBDEP] varchar(1) NOT NULL,
    [drvPhoneQBDEP] varchar(1) NOT NULL,
    [drvPhone2QBDEP] varchar(1) NOT NULL,
    [drvAddressSameAsQBQBDEP] varchar(5) NOT NULL,
    [drvAddress1QBDEP] varchar(255) NULL,
    [drvAddress2QBDEP] varchar(255) NULL,
    [drvCityQBDEP] varchar(255) NULL,
    [drvStateOrProvinceQBDEP] varchar(255) NULL,
    [drvPostalCodeQBDEP] varchar(50) NULL,
    [drvCountryQBDEP] varchar(1) NOT NULL,
    [drvEnrollmentDateQBDEP] varchar(1) NOT NULL,
    [drvSexQBDEP] char(1) NULL,
    [drvDOBQBDEP] varchar(30) NULL,
    [drvIsQMCSOQBDEP] varchar(1) NOT NULL
);
IF OBJECT_ID('U_ECYCCOBRA_drvTbl_QBDEPINIT') IS NULL
CREATE TABLE [dbo].[U_ECYCCOBRA_drvTbl_QBDEPINIT] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(13) NULL,
    [drvSubSort] varchar(13) NULL,
    [drvSubsort2] varchar(12) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvRecordIdentifierQBDEPinit] varchar(24) NOT NULL,
    [bdmdedtype] varchar(32) NULL,
    [drvPlanNameQBDEPinit] varchar(45) NULL,
    [drvPlanBundleNameQBPL] varchar(45) NULL
);
IF OBJECT_ID('U_ECYCCOBRA_drvTbl_QBDEPINIT_2') IS NULL
CREATE TABLE [dbo].[U_ECYCCOBRA_drvTbl_QBDEPINIT_2] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(13) NULL,
    [drvSubSort] varchar(13) NULL,
    [drvSubsort2] varchar(12) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvRecordIdentifierQBDEPinit] varchar(24) NOT NULL,
    [bdmdedtype] varchar(32) NULL,
    [drvPlanNameQBDEPinit] varchar(45) NULL,
    [drvPlanBundleNameQBPL] varchar(45) NULL
);
IF OBJECT_ID('U_ECYCCOBRA_drvTbl_QBEVENT') IS NULL
CREATE TABLE [dbo].[U_ECYCCOBRA_drvTbl_QBEVENT] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(13) NULL,
    [drvSubSort] varchar(13) NULL,
    [drvSubsort2] varchar(1) NOT NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvRecordIdentifierQBEv] varchar(9) NOT NULL,
    [drvEveECYCntTypeQBEv] varchar(29) NOT NULL,
    [drvEventDateQBEv] varchar(30) NULL,
    [drvEnrollmentDateQBEv] datetime NULL,
    [drvEmployeeSSNQBEv] char(11) NULL,
    [drvEmployeeNameQBEv] varchar(232) NOT NULL,
    [drvSecondEvntOrigiFDOCQBEv] varchar(1) NOT NULL
);
IF OBJECT_ID('U_ECYCCOBRA_drvTbl_QBPLAN') IS NULL
CREATE TABLE [dbo].[U_ECYCCOBRA_drvTbl_QBPLAN] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(13) NULL,
    [drvSubSort] varchar(13) NULL,
    [drvSubsort2] varchar(1) NOT NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvRecordIdentifierQBPL] varchar(8) NOT NULL,
    [bdmdedtype] varchar(32) NULL,
    [drvPlanNameQBPL] varchar(45) NULL,
    [drvStartDateQBPL] varchar(30) NULL,
    [drvEndDateQBPL] varchar(1) NOT NULL,
    [drvCoverageLevelQBPL] varchar(9) NOT NULL,
    [drvFirstDayOfCOBRAQBPL] varchar(1) NOT NULL,
    [drvLastDayOfCOBRAQBPL] varchar(1) NOT NULL,
    [drvCOBRADurationMonthsQBPL] varchar(1) NOT NULL,
    [drvDaysToElectQBPL] varchar(1) NOT NULL,
    [drvDaysToMake1stPaymentQBPL] varchar(1) NOT NULL,
    [drvDaysToMakeSubPymntQBPL] varchar(1) NOT NULL,
    [drvElectionPostmarkDateQBPL] varchar(1) NOT NULL,
    [drvLastDateRatesNotifiedQBPL] varchar(1) NOT NULL,
    [drvNumberOfUnitsQBPL] varchar(1) NOT NULL,
    [drvSendPlanChLetterLegacyQBPL] varchar(1) NOT NULL,
    [drvPlanBundleNameQBPL] varchar(45) NULL
);
IF OBJECT_ID('U_ECYCCOBRA_drvTbl_QBPLAN_2') IS NULL
CREATE TABLE [dbo].[U_ECYCCOBRA_drvTbl_QBPLAN_2] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(13) NULL,
    [drvSubSort] varchar(13) NULL,
    [drvSubsort2] varchar(1) NOT NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvRecordIdentifierQBPL] varchar(8) NOT NULL,
    [bdmdedtype] varchar(32) NULL,
    [drvPlanNameQBPL] varchar(45) NULL,
    [drvStartDateQBPL] varchar(30) NULL,
    [drvEndDateQBPL] varchar(1) NOT NULL,
    [drvCoverageLevelQBPL] varchar(9) NOT NULL,
    [drvFirstDayOfCOBRAQBPL] varchar(1) NOT NULL,
    [drvLastDayOfCOBRAQBPL] varchar(1) NOT NULL,
    [drvCOBRADurationMonthsQBPL] varchar(1) NOT NULL,
    [drvDaysToElectQBPL] varchar(1) NOT NULL,
    [drvDaysToMake1stPaymentQBPL] varchar(1) NOT NULL,
    [drvDaysToMakeSubPymntQBPL] varchar(1) NOT NULL,
    [drvElectionPostmarkDateQBPL] varchar(1) NOT NULL,
    [drvLastDateRatesNotifiedQBPL] varchar(1) NOT NULL,
    [drvNumberOfUnitsQBPL] varchar(1) NOT NULL,
    [drvSendPlanChLetterLegacyQBPL] varchar(1) NOT NULL,
    [drvPlanBundleNameQBPL] varchar(45) NULL
);
IF OBJECT_ID('U_ECYCCOBRA_EEList') IS NULL
CREATE TABLE [dbo].[U_ECYCCOBRA_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ECYCCOBRA_File') IS NULL
CREATE TABLE [dbo].[U_ECYCCOBRA_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
IF OBJECT_ID('U_ECYCCOBRA_Header_NPM') IS NULL
CREATE TABLE [dbo].[U_ECYCCOBRA_Header_NPM] (
    [drvVersionLineIdentifierNPM] varchar(9) NOT NULL,
    [drvVersionNumberNPM] varchar(3) NOT NULL
);
IF OBJECT_ID('U_ECYCCOBRA_Header_QB') IS NULL
CREATE TABLE [dbo].[U_ECYCCOBRA_Header_QB] (
    [drvVersionLineIdentifierQB] varchar(9) NOT NULL,
    [drvVersionNumberQB] varchar(3) NOT NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECYCCOBRA]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Auto Warehousing Co.

Created By: Inshan Singh
Business Analyst: Jackie Finn
Create Date: 02/27/2020
Service Request Number: SR-2020-00264000

Purpose: CYC COBRA Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECYCCOBRA';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECYCCOBRA';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECYCCOBRA';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECYCCOBRA';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECYCCOBRA' ORDER BY RunID DESC;

Job Ownership Scripts
---------------------
-- Set job owner to ssis_user for Production jobs
EXEC msdb..usg_set_job_owner @job_name = '', @set_owner_to_self = 0;

-- Set job owner to self, to make changes in SQL Job Scheduler. Remember to re-run the above script to change ownership to ssis_user when complete
EXEC msdb..usg_set_job_owner @job_name = '', @set_owner_to_self = 1;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECYCCOBRA', 'NPMFILE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECYCCOBRA', 'QBFILE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECYCCOBRA', 'TESTNPM';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECYCCOBRA', 'TESTQB';
EXEC dbo.dsi_BDM_sp_ErrorCheck 'ECYCCOBRA';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ECYCCOBRA', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@EndPerControl     VARCHAR(9)
            ,@FileMinCovDate    DATETIME

    -- Set FormatCode
    SELECT @FormatCode = 'ECYCCOBRA';

     -- Set Min Coverage date
    SELECT @FileMinCovDate = '01/01/2020'

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
    DELETE FROM dbo.U_ECYCCOBRA_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECYCCOBRA_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_ECYCCOBRA_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ECYCCOBRA_AuditFields;
    CREATE TABLE dbo.U_ECYCCOBRA_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_ECYCCOBRA_AuditFields VALUES ('EmpDed','EedBenStopDate');
    INSERT INTO dbo.U_ECYCCOBRA_AuditFields VALUES ('EmpDed','EedDedCode ');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ECYCCOBRA_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ECYCCOBRA_Audit;
    SELECT 
        audEEID  = audKey1Value
        ,audKey2 = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    INTO dbo.U_ECYCCOBRA_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_ECYCCOBRA_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ECYCCOBRA_Audit ON dbo.U_ECYCCOBRA_Audit (audEEID,audKey2);

    --================
    -- Changes Only
    --================
    --DELETE FROM dbo.U_ECYCCOBRA_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_ECYCCOBRA_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'MED, DEN, VIS, DRG';

    IF OBJECT_ID('U_ECYCCOBRA_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ECYCCOBRA_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ECYCCOBRA_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

    --==========================================
    -- BDM Section for NPM
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'TermSelectionOption','AuditDate');

    -- NPM parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RunID','NPM');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','A'); -- DedIsCobraCovered = 'Y'
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'NewEnrolleeType','4'); -- All new enrollees where no previous plan exists
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'TableType','EMP'); -- Only include employees on NPM file
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'GetChangeReason', 'Y')
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'NewEnrolleeDeps', '1')
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'CobraIncludeEmps', 'Y')
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'CountDependents', 'Y')
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP');


    -- Run BDM for NPM
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- BDM Section for QB
    --==========================================
    
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'TermSelectionOption','AuditDate');


    -- COBRA parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RunID','QB');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'AddToPreviousRun','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','A'); -- DedIsCobraCovered = 'Y'
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraType','4'); -- Eep/ConCobraReason first, then EdhChangeReason. Include CHGRP for elig. ben groups
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraDate','3'); -- EedBenStopDate and DbnBenStopDate, unless Eep/ConDateOfCOBRAEvent exists
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraPQBType','1'); -- If no EE or spouse, ALL children are PQB (not just oldest)
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraReasonsDepPQB','201,203,204,210,LEVNT3,LEVNT4,205'); -- Valid dependent PQB reasons
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidCobraReasonsEmp','201,203,204,LEVNT3,LEVNT4'); -- Invalidate employee when Cobra Reason is a dependent PQB reason
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidTermReasonsEmp','203'); -- Invalidate employee when Cobra Reason is "Death"
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'ConCobraReasonPCF','DependentCOBRAReason'); -- Valid dependent PQB reasons
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CountDependents','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL,DA,DPC,STC');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'GetChangeReason','Y');

    -- Run BDM for QB
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;
    


--==========================================
    -- Insert into BDM Reason code 201 and 204
 --==========================================
INSERT INTO [dbo].[U_dsi_BDM_ECYCCOBRA]
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
           ,[BdmDedType]
           ,[BdmBenOption]
           ,[BdmBenStatus]
           ,[BdmBenStartDate]
           ,[BdmBenStopDate]
           ,[BdmBenStatusDate]
           ,[BdmBenOptionDate]
           ,[BdmChangeReason]
           ,[BdmDateOfCOBRAEvent]
           ,[BdmIsPQB]
    ) 
    
Select 'DEP' as BdmRecType,
dbncoid as bdmcoid, dbneeid as bdmeeid,dbndeprecid as bdmdeprecid, 
dbndeprecid as bdmsystemid,'QB' as BdmRunId, 'OverAge  - ReInsert' as BdmDedRowStatus,
dbnRelationship as BdmRelationship, dbnDateOfBirth as BdmRelationship, deddedcode as BdmDedCode, 
deddedtype as BdmDedType, dbnBenOption as BdmBenOption, dbnBenStatus as BdmBenStatus, 
dbnbenstartdate as BdmBenStartDate,  dbnbenstopdate  as BdmBenStopDate, dbnTVStartdate as BdmBenStatusDate, dbnbenstartdate as BdmBenOptionDate,
'201' as BdmChangeReason, dbnTVStartdate as BdmDateOfCOBRAEvent, 'Y'
from u_dsi_bdm_depdeductions where  dbnformatcode = 'ECYCCOBRA' and dbnrunid = 'QB'
and dbnValidForExport = 'N'  and dedDedType IN ('DEN', 'VIS', 'MED', 'DRG') and dedDedType <> 'MMOPT'
and dbneeid in (Select distinct eedeeid from u_dsi_bdm_empdeductions where  eedformatcode = 'ECYCCOBRA' and 
eedrunid = 'QB' and DedDedType IN ('DEN', 'VIS', 'MED', 'DRG') and DedDedType <> 'MMOPT' and eedchangereason in ('201')   or eedCobraReason in ('201')
and eedValidForExport = 'N') and dbncoid is not null and dbnbenstopdate between @startdate and @enddate


INSERT INTO [dbo].[U_dsi_BDM_ECYCCOBRA]
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
           ,[BdmDedType]
           ,[BdmBenOption]
           ,[BdmBenStatus]
           ,[BdmBenStartDate]
           ,[BdmBenStopDate]
           ,[BdmBenStatusDate]
           ,[BdmBenOptionDate]
           ,[BdmChangeReason]
           ,[BdmDateOfCOBRAEvent]
           ,[BdmIsPQB]
    ) 
    
Select 'DEP' as BdmRecType,
dbncoid as bdmcoid, dbneeid as bdmeeid,dbndeprecid as bdmdeprecid, 
dbndeprecid as bdmsystemid,'QB' as BdmRunId, 'DIVORCELEGALSEPARATION  - ReInsert' as BdmDedRowStatus,
dbnRelationship as BdmRelationship, dbnDateOfBirth as BdmRelationship, deddedcode as BdmDedCode, 
deddedtype as BdmDedType, dbnBenOption as BdmBenOption, dbnBenStatus as BdmBenStatus, 
dbnbenstartdate as BdmBenStartDate, dbnbenstopdate as BdmBenStopDate, dbnTVStartdate as BdmBenStatusDate, dbnbenstartdate as BdmBenOptionDate,
'204' as BdmChangeReason, dbnbenstopdate as BdmDateOfCOBRAEvent, 'Y'
from u_dsi_bdm_depdeductions where  dbnformatcode = 'ECYCCOBRA' and dbnrunid = 'QB'
and dbnValidForExport = 'N'  and dedDedType IN ('DEN', 'VIS', 'MED', 'DRG') and dedDedType <> 'MMOPT'
and dbneeid in (Select distinct eedeeid from u_dsi_bdm_empdeductions where  eedformatcode = 'ECYCCOBRA' and 
eedrunid = 'QB' and DedDedType IN ('DEN', 'VIS', 'MED', 'DRG') and DedDedType <> 'MMOPT' and eedchangereason in ('204')   or eedCobraReason in ('204')
and eedValidForExport = 'N') and dbncoid is not null and dbnbenstopdate between @startdate and @enddate


INSERT INTO [dbo].[U_dsi_BDM_ECYCCOBRA]
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
           ,[BdmDedType]
           ,[BdmBenOption]
           ,[BdmBenStatus]
           ,[BdmBenStartDate]
           ,[BdmBenStopDate]
           ,[BdmBenStatusDate]
           ,[BdmBenOptionDate]
           ,[BdmChangeReason]
           ,[BdmDateOfCOBRAEvent]
           ,[BdmIsPQB]
    ) 
    
Select 'DEP' as BdmRecType,
dbncoid as bdmcoid, dbneeid as bdmeeid,dbndeprecid as bdmdeprecid, 
dbndeprecid as bdmsystemid,'QB' as BdmRunId, 'DEATH - ReInsert' as BdmDedRowStatus,
dbnRelationship as BdmRelationship, dbnDateOfBirth as BdmRelationship, deddedcode as BdmDedCode, 
deddedtype as BdmDedType, dbnBenOption as BdmBenOption, dbnBenStatus as BdmBenStatus, 
dbnbenstartdate as BdmBenStartDate, dbo.dsi_fnGetMinMaxDates('MAX',dbnbenstopdate, CAST('01/01/2020' as datetime)) as BdmBenStopDate, dbnTVStartdate as BdmBenStatusDate, dbnbenstartdate as BdmBenOptionDate,
'210' as BdmChangeReason, dbnbenstopdate as BdmDateOfCOBRAEvent, 'Y'
from u_dsi_bdm_depdeductions where  dbnformatcode = 'ECYCCOBRA' and dbnrunid = 'QB'
and dbnValidForExport = 'N'  and dedDedType IN ('DEN', 'VIS', 'MED', 'DRG') and dedDedType <> 'MMOPT'
and dbneeid in (Select distinct eedeeid from u_dsi_bdm_empdeductions where  eedformatcode = 'ECYCCOBRA' and 
eedrunid = 'QB' and DedDedType IN ('DEN', 'VIS', 'MED', 'DRG') and DedDedType <> 'MMOPT' and eedchangereason in ('210')  or eedCobraReason in ('210')
and eedValidForExport = 'N') and dbncoid is not null and dbnTVStartdate between @startdate and @enddate


    --==========================================
    -- Build working tables
    --==========================================

--    if object_id('U_ECYCCOBRA_stopdata') is not null
-- drop table dbo.U_ECYCCOBRA_stopdata

--Select distinct 
-- cobeeid = eedeeid,
-- cobcoid = eedcoid,
-- cobdepid = cast('' as varchar(12)),
-- cobrectype = 'E',
-- cobdedtype = deddedtype,
-- cobdedcode = eeddedcode,
-- cobbenoption = eedbenoption,
-- cobstopdate = eedbenstatusdate, --eedbenstopdate, --SB 10/14/2013 
-- cobstartdate = eedbenstartdate,
-- cobpqb = 'PQB',
-- cobrelationship = cast('' as varchar(6)),
-- cobcovlvl = cast('' as varchar(6)),
-- cobcobrareason = eedcobrareason,
-- cobeventdate = eeddateofcobraevent,
-- cobEEGoalAmt = EedEEAmt,
-- cobEEMemberCaseNo = eedeememberorcaseno,
-- cobPayeeID = eedPayeeID,
-- cobUSGField1 = CAST('' as varchar (12))
--into dbo.U_ECYCCOBRA_stopdata
--from dbo.U_dsi_bdm_EmpDeductions  
--join emppers on eedeeid = eepeeid
--join empcomp on eedeeid = eeceeid and eedcoid = eeccoid
--Where eedformatcode = @FormatCode and eedvalidforexport = 'Y'
--   and eedrunid = 'Cobra'

--insert into dbo.U_ECYCCOBRA_stopdata
--Select distinct 
-- cobeeid = dbneeid,
-- cobcoid = dbncoid,
-- cobdepid = dbndeprecid,
-- cobrectype = 'D',
-- cobdedtype = A.deddedtype,
-- cobdedcode = dbndedcode,
-- cobbenoption = dbnbenoption,
-- cobstopdate = dbnbenstopdate,
-- cobstartdate = dbnbenstartdate,
-- cobpqb = case when nullif(dbnispqb,'') = 'Y' then 'PQB' else '' end,
-- cobrelationship = conrelationship,
-- cobcovlvl = cast('' as varchar(6)),
-- cobcobrareason = concobrareason,
-- cobeventdate = dbndateofcobraevent,
-- cobEEGoalAmt = null,
-- cobEEMemberCaseNo = eedeememberorcaseno,
-- cobPayeeID = B.eedPayeeID,
-- cobUSGField1 = DbnUSGField1
--from dbo.U_dsi_bdm_DepDeductions  A
--join contacts with (nolock) on coneeid = dbneeid  and consystemid = dbndeprecid
--left join dbo.U_dsi_bdm_EmpDeductions B
--   on dbneeid = eedeeid 
--   and dbndedcode = eeddedcode 
--   and eedformatcode = @FormatCode 
--   and eedvalidforexport = 'Y'
--   and eedrunid = 'Cobra'
--Where dbnformatcode = @FormatCode and dbnvalidforexport = 'Y'
--   and dbnrunid = 'Cobra'
    

    --==========================================
    -- Build Driver Tables
    --==========================================

    IF @ExportCode LIKE '%NPM%'
    BEGIN
    ---------------------------------
    -- DETAIL RECORD - U_ECYCCOBRA_drvTbl_NPM
    ---------------------------------
    IF OBJECT_ID('U_ECYCCOBRA_drvTbl_NPM','U') IS NOT NULL
        DROP TABLE dbo.U_ECYCCOBRA_drvTbl_NPM;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = '1'+ xEEID
        ,drvSubSort = '2' + xEEID
        ,drvSubsort2 = ''
        ,drvDepRecID = BdmDepRecID --CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvVersionLineIdentifier = '[NPM]'
        ,drvSSN = eepSSN
        ,drvIndividualIdentifier = EecEmpNo
        ,drvClientName = 'Auto Warehousing Company'
        ,drvClientDivisionName = pcfEEC.Employment_BenefitPlanCode --PCF Benefit Plan Code
        ,drvFirstName = EepNameFirst 
        ,drvMiddleInitial = LEFT(EepNameMiddle,1)
        ,drvLastName =CONCAT(EepNameLast,' ', EepNameSuffix) 
        ,drvSalutation = '' --blank
        ,drvEmail = EepAddressEMail
        ,drvPhone = EepPhoneHomeNumber
        ,drvPhone2 = '' -- blank
        ,drvAddress1 = EepAddressLine1
        ,drvAddress2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,drvStateOrProvince = EepAddressState
        ,drvPostalCode = EepAddressZipCode
        ,drvCountry = '' --blank
        ,drvSex = EepGender 
        ,drvUsesFamilyInAddress = CASE WHEN  BdmBenOption = 'E1' THEN 'FALSE'  ELSE 'TRUE' END -- feedback from Syed at CYC Use False and TRUE instead of F and T
        ,drvHasWaivedAllCoverage = 'FALSE' -- feeback from SYed at CYC comma fill or set to False.
        ,drvSendGRNotice = 'TRUE'-- feeback from SYed at CYC comma fill or set to true.
        ,drvHireDate = CONVERT(VARCHAR, EecDateOfLastHire, 101)
    INTO dbo.U_ECYCCOBRA_drvTbl_NPM
    FROM dbo.U_ECYCCOBRA_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ECYCCOBRA WITH (NOLOCK)
        ON bdmEEID = xEEID 
        AND bdmCoID = xCoID and bdmBenOption is not null
    LEFT JOIN dbo.contacts with (nolock) 
        ON ConEEID = xEEID
       AND ConSystemID = BdmDepRecID
    JOIN dbo.fn_MP_CustomFields_EmpComp_Export(null,null,null,null) pcfEEC
        ON pcfEEC.EecEEId = xEEID and pcfEEC.EecCOID = xCOID
        WHERE bdmRunID = 'NPM'  and  bdmDedCode <> 'MMOPT' 
        and BdmDedType IN ('DEN', 'VIS', 'MED', 'DRG');

    --========================================
    -- Insert spouse with different address
    --========================================
        
        Delete from dbo.U_ECYCCOBRA_drvTbl_NPM where drveeid in (
            Select coneeid from contacts  with (nolock) where coneeid  in (
        Select distinct bdmeeid from dbo.U_dsi_BDM_ECYCCOBRA  with (nolock) where bdmrunid = 'NPM' and bdmrectype = 'DEP' and drvDepRecID is not null)
        and conrelationship = 'SPS' and conisdependent  = 'Y' and conaddressisdifferent  = 'N')  
        

        INSERT INTO U_ECYCCOBRA_drvTbl_NPM
        SELECT DISTINCT
                 drvEEID = drvEEID
                ,drvCoID = drvCOID
                ,drvInitialSort = '1'+ drvEEID
                ,drvSubSort = '2' + drvEEID
                ,drvSubsort2 = ''
                ,drvDepRecID = drvDepRecID --DELETE IF NOT USING DEPENDENT DATA
                -- standard fields above and additional driver fields below
                ,drvVersionLineIdentifier = '[NPM]'
                ,drvSSN = ConSSN
                ,drvIndividualIdentifier = drvIndividualIdentifier
                ,drvClientName = 'Auto Warehousing Company'
                ,drvClientDivisionName = drvClientDivisionName --PCF Benefit Plan Code
                ,drvFirstName = ConNameFirst
                ,drvMiddleInitial = LEFT(ConNameMiddle,1)
                ,drvLastName = CONCAT(ConNameLast,' ', ConNameSuffix)
                ,drvSalutation = '' --blank
                ,drvEmail = ConEmailAddr
                ,drvPhone = ConPhoneHomeNumber
                ,drvPhone2 = '' -- blank
                ,drvAddress1 = ConAddressLine1
                ,drvAddress2 = ConAddressLine2
                ,drvCity = ConAddressCity
                ,drvStateOrProvince = ConAddressState
                ,drvPostalCode = ConAddressZipCode
                ,drvCountry
                ,drvSex = ConGender 
                ,drvUsesFamilyInAddress 
                ,drvHasWaivedAllCoverage
                ,drvSendGRNotice
                ,drvHireDate
         from U_ECYCCOBRA_drvTbl_NPM  with (nolock)
         JOIN dbo.contacts with (nolock) 
        ON ConEEID = drvEEID
       AND ConSystemID = drvDepRecID where drveeid in (
        Select coneeid from contacts  with (nolock) where coneeid  in (
        Select distinct bdmeeid from U_dsi_BDM_ECYCCOBRA  with (nolock) where bdmrunid = 'NPM' and bdmrectype = 'DEP')
        and conrelationship = 'SPS' and conisdependent  = 'Y' and conaddressisdifferent  = 'Y'
        )
    
        


    END
    ELSE
    BEGIN
    ---------------------------------
    -- DETAIL RECORD - U_ECYCCOBRA_drvTbl_QB
    ---------------------------------
    IF OBJECT_ID('U_ECYCCOBRA_drvTbl_QB','U') IS NOT NULL
        DROP TABLE dbo.U_ECYCCOBRA_drvTbl_QB;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = '1'+ xEEID
        ,drvSubSort = '1' + xEEID
        ,drvSubsort2 = ''
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRecordIdentifierQB = '[QB]'
        ,drvClientNameQB = 'Auto Warehousing Company'
        ,drvClientDivisionNameQB = pcfEEC.Employment_BenefitPlanCode --PCF Benefit Plan Code
        ,drvSalutationQB = '' --blank
        ,drvFirstNameQB = CASE WHEN BdmRecType = 'EMP' THEN EepNameFirst
                               WHEN BdmRecType = 'DEP' THEN ConNameFirst
                          END
        ,drvMiddleInitialQB = CASE WHEN BdmRecType = 'EMP' THEN LEFT(EepNameMiddle,1)
                                   WHEN BdmRecType = 'DEP' THEN LEFT(ConNameMiddle,1)
                          END 
        ,drvLastNameQB = CASE WHEN BdmRecType = 'EMP' THEN CONCAT(EepNameLast,' ', EepNameSuffix)
                              WHEN BdmRecType = 'DEP' THEN CONCAT(ConNameLast,' ', ConNameSuffix)
                          END
        ,drvSSNQB = CASE WHEN BdmRecType = 'EMP' THEN EepSSN 
                         WHEN BdmRecType = 'DEP' THEN ConSSN
                     END
        ,drvIndividualIDQB = EecEmpNo
        ,drvEmailQB = '' -- blank
        ,drvPhoneQB = '' -- blank
        ,drvPhone2QB = '' -- blank
        ,drvAddress1QB = CASE WHEN BdmRecType = 'EMP' THEN EepAddressLine1 
                              WHEN BdmRecType = 'DEP' THEN ConAddressLine1
                         END 
        ,drvAddress2QB = CASE WHEN BdmRecType = 'EMP' THEN EepAddressLine2 
                              WHEN BdmRecType = 'DEP' THEN ConAddressLine2
                         END  
        ,drvCityQB = CASE WHEN BdmRecType = 'EMP' THEN EepAddressCity 
                          WHEN BdmRecType = 'DEP' THEN ConAddressCity
                         END 
        ,drvStateOrProvinceQB = CASE WHEN BdmRecType = 'EMP' THEN EepAddressState 
                                     WHEN BdmRecType = 'DEP' THEN ConAddressState
                                END 
        ,drvPostalCodeQB = CASE WHEN BdmRecType = 'EMP' THEN EepAddressZipCode 
                                WHEN BdmRecType = 'DEP' THEN ConAddressZipCode
                            END 
        ,drvCountryQB = ''
        ,drvPremAddressSameAsPrimQB = 'TRUE'
        ,drvPremiumAddress1QB = ''
        ,drvPremiumAddress2QB = ''
        ,drvPremiumCityQB = ''
        ,drvPremiumStateOrProvinceQB = ''
        ,drvPremiumPostalCodeQB = ''
        ,drvPremiumCountryQB = ''
        ,drvSexQB = CASE WHEN BdmRecType = 'EMP' THEN EepGender  
                         WHEN BdmRecType = 'DEP' THEN ConGender
                    END 
        ,drvDOBQB = CASE WHEN BdmRecType = 'EMP' THEN CONVERT(VARCHAR,EepDateOfBirth,101) 
                         WHEN BdmRecType = 'DEP' THEN CONVERT(VARCHAR,ConDateOfBirth,101) 
                    END  
        ,drvTobaccoUseQB = 'UNKNOWN'
        ,drvEmployeeTypeQB = 'UNKNOWN'
        ,drvEmployeePayrollTypeQB = 'UNKNOWN'
        ,drvYearsOfServiceQB = '' --blank
        ,drvPremiumCouponTypeQB = 'PREMIUMNOTICE'
        ,drvUsesHCTCQB = 'FALSE'
        ,drvActiveQB = 'TRUE'
        ,drvAllowMemberSSOQB = 'FALSE'
        ,drvBenefitGroupQB = '' --Blank
        ,drvAccountStructureQB = CONVERT(VARCHAR,EecDateOfLastHire,101)  -- check this if ts correct
        ,drvClientSpecificDataQB = ''--Blank
        ,drvSSOIDQB = ''--Blank
    INTO dbo.U_ECYCCOBRA_drvTbl_QB
    FROM dbo.U_ECYCCOBRA_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ECYCCOBRA WITH (NOLOCK)
        ON bdmEEID = xEEID
        AND bdmCOID = xCOID
   left JOIN dbo.CONTACTS WITH(NOLOCK)
        ON ConEEID = xEEID
       AND ConSystemID = BdmDepRecID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON eecEEID = xEEID
        AND eecCOID = xCOID
    JOIN dbo.fn_MP_CustomFields_EmpComp_Export(null,null,null,null) pcfEEC
        ON pcfEEC.EecEEId = xEEID and pcfEEC.EecCOID = xCOID
        WHERE bdmRunID = 'QB' and bdmIsPQB = 'Y' and   bdmdedType  IN ('DEN', 'VIS', 'MED', 'DRG') and bdmDedCode <> 'MMOPT'
    ;

    Delete from dbo.U_ECYCCOBRA_drvTbl_QB where drvClientDivisionNameQB is null





    ---------------------------------
    -- DETAIL RECORD - U_ECYCCOBRA_drvTbl_QBEVENT
    ---------------------------------
    IF OBJECT_ID('U_ECYCCOBRA_drvTbl_QBEVENT','U') IS NOT NULL
        DROP TABLE dbo.U_ECYCCOBRA_drvTbl_QBEVENT;
    SELECT DISTINCT
         drvEEID = drvEEID
        ,drvCoID = drvCoID
        ,drvInitialSort = '1'+ drvEEID
        ,drvSubSort = '2' + drvEEID
        ,drvSubsort2 = ''
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRecordIdentifierQBEv = '[QBEVENT]'
        ,drvEveECYCntTypeQBEv = Case
                                    WHEN BdmChangeReason IN ('204' ,'214') Then 'DIVORCELEGALSEPARATION'
                                    WHEN BdmChangeReason = '210' Then 'DEATH'
                                    WHEN BdmChangeReason = '208' Then 'RETIREMENT'
                                    WHEN BdmChangeReason = '203' Then 'REDUCTIONINHOURS-STATUSCHANGE'
                                    WHEN BdmChangeReason IN ('302','201', 'LEVNT3') Then 'INELIGIBLEDEPENDENT'

                                    WHEN EecTermReason = '202' Then 'RETIREMENT'
                                    WHEN EecTermReason = '203' Then 'DEATH'
                                    WHEN EecTermReason = '210' Then 'REDUCTIONINHOURS-ENDOFLEAVE'
                                    WHEN EecTermReason = '200 'Then 'REDUCTIONINFORCE'
                                    ELSE 'TERMINATION'
                                END
        ,drvEventDateQBEv = CONVERT(VARCHAR,   BdmDateOfCOBRAEventYEAR , 101)
        ,drvEnrollmentDateQBEv = bdmBenStartDate
                                     --CASE WHEN BdmDedType = 'MED'
                                        --then    bdmBenStartDate
          --                          --Then CONVERT(VARCHAR,(SELECT MIN(bdmBenStartDate) from dbo.U_dsi_BDM_ECYCCOBRA WITH (NOLOCK) where bdmEEID = xEEID AND bdmCOID = xCOID),101)
          --                          ELSE ''
          --                      END
        ,drvEmployeeSSNQBEv = EepSSN
        ,drvEmployeeNameQBEv = CONCAT(EepNameFirst,' ' , EepNameLast, ' ',  EepNameSuffix) -- CASE WHEN BdmRecType = 'EMP' AND BdmIsPQB <> 'Y' THEN CONCAT(EepNameFirst,' ' , EepNameLast, ' ',  EepNameSuffix) END -- TODO check this
        ,drvSecondEvntOrigiFDOCQBEv = '' --blank
    INTO dbo.U_ECYCCOBRA_drvTbl_QBEVENT
    --FROM dbo.U_ECYCCOBRA_EEList WITH (NOLOCK)
    FROM dbo.U_ECYCCOBRA_drvTbl_QB WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = drvEEID 
        AND EecCoID = drvCoID
    --JOIN dbo.U_dsi_BDM_ECYCCOBRA WITH (NOLOCK)
    --    ON bdmEEID = xEEID
    --    AND bdmCOID = xCOID and bdmDedType IN ('MED', 'DEN', 'VIS', 'DRG')
JOIN (SELECT
                 BdmEEID
                ,BdmCoID
                ,BdmDepRecID
                ,BdmRecType
                ,BdmCobraReason = MAX(BdmCobraReason)
                ,BdmBenStartDate = MIN(BdmBenStartDate)
                ,BdmDateOfCOBRAEvent = MAX(BdmDateOfCOBRAEvent)
                ,BdmUSGDate1 = MAX(BdmUSGDate1)
                ,BdmChangeReason = MAX(BdmChangeReason)
                ,BdmDateOfCOBRAEventYEAR = MAX(
                                CASE WHEN YEAR(BdmDateOfCOBRAEvent) < 2020 THEN  
                                
                                EOMONTH(CAST ( (CAST( MONTH(BdmDateOfCOBRAEvent) as varchar)  + '/'  +  CAST( DAY(BdmDateOfCOBRAEvent) as varchar) + '/2020') as datetime))
                                
                                --WHEN YEAR(BdmDateOfCOBRAEvent) < 2018 THEN  
                                
                                --EOMONTH(CAST ( (CAST( MONTH(BdmDateOfCOBRAEvent) as varchar)  + '/'  +  CAST( DAY(BdmDateOfCOBRAEvent) as varchar) + '/2019') as datetime))

                                ELSE BdmDateOfCOBRAEvent  END
                                )

              FROM dbo.U_dsi_BDM_ECYCCOBRA WITH (NOLOCK)
              WHERE BdmIsPQB = 'Y'
                AND  BdmDedcode <> 'MMOPT' AND isNULL(BdmBenStopDate, '') <> '' 
            and bdmRunID = 'QB' 
              GROUP BY BdmEEID, BdmCoID, BdmDepRecID, BdmRecType) BDM
            ON BdmEEID = drvEEID
           AND BdmCoID = drvCoID


    JOIN EmpPers WITH (NOLOCK)
        ON eepEEID = drvEEID
    --JOIN DedCode WITH (NOLOCK) ON DedDedCode = BDM.BdmDedcode
    JOIN dbo.fn_MP_CustomFields_EmpComp_Export(null,null,null,null) pcfEEC
        ON pcfEEC.EecEEId = drvEEID and pcfEEC.EecCOID = drvCOID

  --  WHERE DedDedType IN ('MED', 'DEN', 'VIS', 'DRG') AND BdmDedcode <> 'MMOPT' AND isNULL(BdmBenStopDate, '') <> '' 
        --and bdmRunID = 'QB' and bdmIsPQB = 'Y'

    ;
    ---------------------------------
    -- DETAIL RECORD - U_ECYCCOBRA_drvTbl_QBPLAN
    ---------------------------------
    IF OBJECT_ID('U_ECYCCOBRA_drvTbl_QBPLAN','U') IS NOT NULL
        DROP TABLE dbo.U_ECYCCOBRA_drvTbl_QBPLAN;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = '1'+ xEEID
        ,drvSubSort = '3' + xEEID
        ,drvSubsort2 = ''
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRecordIdentifierQBPL = '[QBPLAN]'
        ,bdmdedtype
        ,drvPlanNameQBPL = CASE -- TODO check with IA on this
                            WHEN BdmDedType = 'DEN'  THEN SUBSTRING(DENCode.CodDesc,0,CHARINDEX('and',DENCode.CodDesc)) -- AND PCF CObra Dental VISION is not null   
                            WHEN BdmDedType = 'VIS'  THEN SUBSTRING(DENCode.CodDesc,CHARINDEX('and',DENCode.CodDesc) + 4 ,len(DENCode.CodDesc)) --'PCF COBRA Dental Vision'
                            WHEN BdmDedType = 'MED'  AND BdmDedCode <> 'MMOPT' THEN  SUBSTRING(MEDCode.CodDesc,0,CHARINDEX('and',MEDCode.CodDesc)) -- and PCF COBRA Medical Rx IS NOT NULL 
                            WHEN BdmDedType = 'DRG'  THEN  SUBSTRING(MEDCode.CodDesc,CHARINDEX('and',MEDCode.CodDesc) + 4 ,len(MEDCode.CodDesc)) --and PCF COBRA Dental Vision IS NOT NULL Then pull all characters Right of the ‘AND’
                            
                           END 

                            /*CASE -- TODO check with IA on this
                            WHEN BdmDedType = 'DEN'  THEN SUBSTRING(DENCode.CodDesc,0,CHARINDEX('and',DENCode.CodDesc)) -- AND PCF CObra Dental VISION is not null   
                            WHEN BdmDedType = 'VIS'  THEN SUBSTRING(DENCode.CodDesc,0,CHARINDEX('and',DENCode.CodDesc)) --'PCF COBRA Dental Vision'
                            WHEN BdmDedType = 'MED'  AND BdmDedCode <> 'MMOPT' THEN  SUBSTRING(MEDCode.CodDesc,0,CHARINDEX('and',MEDCode.CodDesc)) -- and PCF COBRA Medical Rx IS NOT NULL 
                            WHEN BdmDedType = 'DRG'  THEN  SUBSTRING(MEDCode.CodDesc,0,CHARINDEX('and',MEDCode.CodDesc)) --and PCF COBRA Dental Vision IS NOT NULL Then pull all characters Right of the ‘AND’

                           END*/
        ,drvStartDateQBPL = CASE WHEN BdmDedType IN ('MED', 'DEN', 'VIS', 'DRG') 
                                      AND BdmDedCode  <> 'MMOPT' 
                                    THEN CONVERT(VARCHAR, DateAdd(Day,1,CASE WHEN YEAR(bdmBenStopDate) < 2020 THEN  
                                
                                EOMONTH(CAST ( (CAST( MONTH(bdmBenStopDate) as varchar)  + '/'  +  CAST( DAY(bdmBenStopDate) as varchar) + '/2020') as datetime))

                                --WHEN YEAR(bdmBenStopDate) = 2018 THEN  
                                
                                --EOMONTH(CAST ( (CAST( MONTH(bdmBenStopDate) as varchar)  + '/'  +  CAST( DAY(bdmBenStopDate) as varchar) + '/2019') as datetime))
                                
                                ELSE bdmBenStopDate  END ), 101)
                            END
        ,drvEndDateQBPL = '' -- Leave Blank
        ,drvCoverageLevelQBPL = CASE WHEN (Select count(distinct bdmdeprecid) from U_dsi_BDM_ECYCCOBRA where bdmeeid = xeeid) = 1 THEN  'EE'
                                     WHEN  (Select count(distinct bdmdeprecid) from U_dsi_BDM_ECYCCOBRA where bdmeeid = xeeid and bdmRelationShip = 'SPS') = 1 or (Select count(distinct bdmdeprecid) from U_dsi_BDM_ECYCCOBRA where bdmeeid = xeeid and bdmRelationShip = 'CHI') >= 1 THEN 'EE+FAMILY'
                                     ELSE 'EE'
                                     
                                END 
        ,drvFirstDayOfCOBRAQBPL = ''  -- Leave Blank
        ,drvLastDayOfCOBRAQBPL = ''  -- Leave Blank
        ,drvCOBRADurationMonthsQBPL = ''  -- Leave Blank
        ,drvDaysToElectQBPL = ''  -- Leave Blank
        ,drvDaysToMake1stPaymentQBPL = ''  -- Leave Blank
        ,drvDaysToMakeSubPymntQBPL = ''  -- Leave Blank
        ,drvElectionPostmarkDateQBPL = ''  -- Leave Blank
        ,drvLastDateRatesNotifiedQBPL = ''  -- Leave Blank
        ,drvNumberOfUnitsQBPL = '' -- Leave Blank
        ,drvSendPlanChLetterLegacyQBPL = 'T'
        ,drvPlanBundleNameQBPL = CASE WHEN BdmDedType IN ('MED', 'DRG') and BdmDedCode <> 'MMOPT' THEN  MEDCode.CodDesc--'PCF COBRA Medical Rx'
                                      WHEN BdmDedType IN ('DEN', 'VIS') THEN DENCode.CodDesc --'PCF COBRA Dental Vision'
                                END
    INTO dbo.U_ECYCCOBRA_drvTbl_QBPLAN
    FROM dbo.U_ECYCCOBRA_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_ECYCCOBRA WITH (NOLOCK)
        ON bdmEEID = xEEID
        AND bdmCOID = xCOID
    JOIN dbo.fn_MP_CustomFields_EmpComp_Export(null,null,null,null) pcfEEC
        ON pcfEEC.EecEEId = xEEID and pcfEEC.EecCOID = xCOID
   left JOIN CODES DENCode on codCode = pcfEEC.Employment_BenefitPlanCode and codTable = 'CO_COBRADENTALVISION'
   left JOIN CODES MEDCode on MedCode.codCode = pcfEEC.Employment_BenefitPlanCode and MedCode.codTable = 'CO_COBRAMEDICALRX'
    JOIN EmpPers WITH (NOLOCK)
        ON eepEEID = xEEID
    WHERE bdmRunID = 'QB' and bdmIsPQB = 'Y' and   bdmdedType  IN ('DEN', 'VIS', 'MED', 'DRG') and  bdmDedCode <> 'MMOPT'
    ;

    Delete from  dbo.U_ECYCCOBRA_drvTbl_QBPLAN  where drvPlanNameQBPL is null

    
    INSERT INTO dbo.U_ECYCCOBRA_drvTbl_QBPLAN
    Select  drvEEID 
            ,drvCoID 
            ,drvInitialSort 
            ,drvSubSort 
            ,drvSubsort2 
            ,drvDepRecID 
            -- standard fields above and additional driver fields below
            ,drvRecordIdentifierQBPL 
            ,'MED'
            ,drvPlanNameQBPL = SUBSTRING(drvPlanBundleNameQBPL,0,CHARINDEX('and',drvPlanBundleNameQBPL))

            ,drvStartDateQBPL 
            ,drvEndDateQBPL
            ,drvCoverageLevelQBPL 
            ,drvFirstDayOfCOBRAQBPL 
            ,drvLastDayOfCOBRAQBPL 
            ,drvCOBRADurationMonthsQBPL 
            ,drvDaysToElectQBPL 
            ,drvDaysToMake1stPaymentQBPL 
            ,drvDaysToMakeSubPymntQBPL 
            ,drvElectionPostmarkDateQBPL 
            ,drvLastDateRatesNotifiedQBPL 
            ,drvNumberOfUnitsQBPL 
            ,drvSendPlanChLetterLegacyQBPL
            ,drvPlanBundleNameQBPL
     from dbo.U_ECYCCOBRA_drvTbl_QBPLAN  where bdmdedtype  = 'DRG'



      
IF OBJECT_ID('U_ECYCCOBRA_drvTbl_QBPLAN_2','U') IS NOT NULL
        DROP TABLE dbo.U_ECYCCOBRA_drvTbl_QBPLAN_2;
 SELECT DISTINCT
         drvEEID 
        ,drvCoID 
        ,drvInitialSort 
        ,drvSubSort 
        ,drvSubsort2 
        ,drvDepRecID 
        -- standard fields above and additional driver fields below
        ,drvRecordIdentifierQBPL 
        ,bdmdedtype
        ,drvPlanNameQBPL 
        ,drvStartDateQBPL
        ,drvEndDateQBPL
        ,drvCoverageLevelQBPL
        ,drvFirstDayOfCOBRAQBPL 
        ,drvLastDayOfCOBRAQBPL 
        ,drvCOBRADurationMonthsQBPL 
        ,drvDaysToElectQBPL 
        ,drvDaysToMake1stPaymentQBPL 
        ,drvDaysToMakeSubPymntQBPL 
        ,drvElectionPostmarkDateQBPL
        ,drvLastDateRatesNotifiedQBPL 
        ,drvNumberOfUnitsQBPL 
        ,drvSendPlanChLetterLegacyQBPL
        ,drvPlanBundleNameQBPL 
    INTO dbo.U_ECYCCOBRA_drvTbl_QBPLAN_2
    from U_ECYCCOBRA_drvTbl_QBPLAN 

 Delete from dbo.U_ECYCCOBRA_drvTbl_QBPLAN

 INSERT INTo dbo.U_ECYCCOBRA_drvTbl_QBPLAN

 SELECT DISTINCT
         drvEEID 
        ,drvCoID 
        ,drvInitialSort 
        ,drvSubSort 
        ,drvSubsort2 
        ,drvDepRecID 
        -- standard fields above and additional driver fields below
        ,drvRecordIdentifierQBPL 
        ,bdmdedtype
        ,drvPlanNameQBPL 
        ,drvStartDateQBPL
        ,drvEndDateQBPL
        ,drvCoverageLevelQBPL
        ,drvFirstDayOfCOBRAQBPL 
        ,drvLastDayOfCOBRAQBPL 
        ,drvCOBRADurationMonthsQBPL 
        ,drvDaysToElectQBPL 
        ,drvDaysToMake1stPaymentQBPL 
        ,drvDaysToMakeSubPymntQBPL 
        ,drvElectionPostmarkDateQBPL
        ,drvLastDateRatesNotifiedQBPL 
        ,drvNumberOfUnitsQBPL 
        ,drvSendPlanChLetterLegacyQBPL
        ,drvPlanBundleNameQBPL 
    FROM dbo.U_ECYCCOBRA_drvTbl_QBPLAN_2


    ---------------------------------
    -- DETAIL RECORD - U_ECYCCOBRA_drvTbl_QBDEP
    ---------------------------------
    IF OBJECT_ID('U_ECYCCOBRA_drvTbl_QBDEP','U') IS NOT NULL
        DROP TABLE dbo.U_ECYCCOBRA_drvTbl_QBDEP;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = '1'+ xEEID
        ,drvSubSort = '4' + xEEID
        ,drvSubsort2 = RTRIM(Conssn) +'A'
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRecordIdentifierQBDEP = '[QBDEPENDENT]'
        ,drvSSNQBDEP = IsNULL(ConSSN, '')
        ,drvRelationshipQBDEP = CASE 
                                     WHEN ConRelationShip = 'SPS' THEN 'SPOUSE'
                                     WHEN ConRelationShip IN ('CHI', 'CHL', 'DIS', 'STC')   THEN 'CHILD'
                                     WHEN ConRelationShip IN ('DMP')   THEN 'DOMESTICPARTNER'
                                END
        ,drvSalutationQBDEP = ''
        ,drvFirstNameQBDEP = ConNameFirst
        ,drvMiddleInitialQBDEP = LEFT(ConNameMiddle,1)
        ,drvLastNameQBDEP = CONCAT(ConNameLast, ' ', ConNameSuffix)
        ,drvEmailQBDEP = ''--ConAddressEMail
        ,drvPhoneQBDEP = ''
        ,drvPhone2QBDEP = ''
        ,drvAddressSameAsQBQBDEP = CASE ConAddressIsDifferent
                                        WHEN 'N' THEN 'TRUE'
                                        ELSE 'FALSE'
                                    END
        ,drvAddress1QBDEP = CASE ConAddressIsDifferent
                                        WHEN 'Y' THEN ConAddressLine1
                                        ELSE ''
                                    END 
        ,drvAddress2QBDEP = CASE ConAddressIsDifferent
                                        WHEN 'Y' THEN ConAddressLine2
                                        ELSE ''
                                    END 
        ,drvCityQBDEP = CASE ConAddressIsDifferent
                                        WHEN 'Y' THEN ConAddressCity
                                        ELSE ''
                                    END 
        ,drvStateOrProvinceQBDEP = CASE ConAddressIsDifferent
                                        WHEN 'Y' THEN ConAddressState
                                        ELSE ''
                                    END 
        ,drvPostalCodeQBDEP = CASE ConAddressIsDifferent
                                        WHEN 'Y' THEN ConAddressZipCode
                                        ELSE ''
                                    END 
        ,drvCountryQBDEP = '' -- Leave Blank
        ,drvEnrollmentDateQBDEP = '' --'FALSE'
        ,drvSexQBDEP = ConGender
        ,drvDOBQBDEP = CONVERT(VARCHAR, ConDateOfBirth, 101)
        ,drvIsQMCSOQBDEP = '' -- Leave Blank
    INTO dbo.U_ECYCCOBRA_drvTbl_QBDEP
    FROM dbo.U_ECYCCOBRA_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_ECYCCOBRA WITH (NOLOCK)
        ON bdmEEID = xEEID
        AND bdmCOID = xCOID
    JOIN dbo.Contacts WITH (NOLOCK) 
    ON ConEEID = bdmeeid
       AND ConSystemID = BdmDepRecID
    JOIN dbo.fn_MP_CustomFields_EmpComp_Export(null,null,null,null) pcfEEC
        ON pcfEEC.EecEEId = xEEID and pcfEEC.EecCOID = xCOID
        WHERE bdmRunID = 'QB' and bdmIsPQB = 'N' and bdmdedType  IN ('DEN', 'VIS', 'MED', 'DRG')  and   bdmDedCode <> 'MMOPT'   ;
    ;

    Delete from dbo.U_ECYCCOBRA_drvTbl_QBDEP where drveeid not in (Select distinct drveeid from dbo.U_ECYCCOBRA_drvTbl_QB)

    ---------------------------------
    -- DETAIL RECORD - U_ECYCCOBRA_drvTbl_QBDEPINIT
    ---------------------------------
    IF OBJECT_ID('U_ECYCCOBRA_drvTbl_QBDEPINIT','U') IS NOT NULL
        DROP TABLE dbo.U_ECYCCOBRA_drvTbl_QBDEPINIT;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = '1'+ xEEID
        ,drvSubSort = '4' + xEEID
        ,drvSubsort2 =  RTRIM(Conssn) +'B'
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRecordIdentifierQBDEPinit = '[QBDEPENDENTPLANINITIAL]'
        ,bdmdedtype
        ,drvPlanNameQBDEPinit =  CASE -- TODO check with IA on this
                            WHEN BdmDedType = 'DEN'  THEN SUBSTRING(DENCode.CodDesc,0,CHARINDEX('and',DENCode.CodDesc)) -- AND PCF CObra Dental VISION is not null   
                            WHEN BdmDedType = 'VIS'  THEN SUBSTRING(DENCode.CodDesc,CHARINDEX('and',DENCode.CodDesc) + 4 ,len(DENCode.CodDesc)) --'PCF COBRA Dental Vision'
                            WHEN BdmDedType = 'MED'  AND BdmDedCode <> 'MMOPT' THEN  SUBSTRING(MEDCode.CodDesc,0,CHARINDEX('and',MEDCode.CodDesc)) -- and PCF COBRA Medical Rx IS NOT NULL 
                            WHEN BdmDedType = 'DRG'  THEN  SUBSTRING(MEDCode.CodDesc,CHARINDEX('and',MEDCode.CodDesc) + 4 ,len(MEDCode.CodDesc)) --and PCF COBRA Dental Vision IS NOT NULL Then pull all characters Right of the ‘AND’
                            
                           END 
                           /*CASE 
                                    WHEN BdmDedType = 'DEN' THEN SUBSTRING(DENCode.CodDesc,0,CHARINDEX('and',DENCode.CodDesc))  -- PCF COBRA Dental Vision IS NOT NULL Then pull all characters left of the ‘AND’ 
                                    WHEN BdmDedType = 'VIS' THEN SUBSTRING(DENCode.CodDesc,0,CHARINDEX('and',DENCode.CodDesc))  -- PCF COBRA Dental Vision IS NOT NULL  Then pull all characters right of the ‘AND’ 
                                    WHEN BdmDedType = 'MED' AND BdmDedCode <> 'MMOPT' THEN  SUBSTRING(MEDCode.CodDesc,0,CHARINDEX('and',MEDCode.CodDesc))  -- PCF COBRA Medical Rx IS NOT NULL Then pull all characters left of the A ‘AND’
                                    WHEN BdmDedType = 'DRG' THEN  SUBSTRING(MEDCode.CodDesc,0,CHARINDEX('and',MEDCode.CodDesc))   -- PCF COBRA Dental Vision IS NOT NULL Then pull all characters Right of the ‘AND’
                                END*/         
        ,drvPlanBundleNameQBPL = CASE WHEN BdmDedType IN ('MED', 'DRG') and BdmDedCode <> 'MMOPT' THEN  MEDCode.CodDesc--'PCF COBRA Medical Rx'
                                      WHEN BdmDedType IN ('DEN', 'VIS') THEN DENCode.CodDesc --'PCF COBRA Dental Vision'
                                END   
    INTO dbo.U_ECYCCOBRA_drvTbl_QBDEPINIT
    FROM dbo.U_ECYCCOBRA_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_ECYCCOBRA WITH (NOLOCK)
        ON bdmEEID = xEEID
        AND bdmCOID = xCOID
    JOIN dbo.fn_MP_CustomFields_EmpComp_Export(null,null,null,null) pcfEEC
        ON pcfEEC.EecEEId = xEEID and pcfEEC.EecCOID = xCOID
    JOIN dbo.Contacts WITH (NOLOCK) 
    ON ConEEID = xEEID
       AND ConSystemID = BdmDepRecID
   left JOIN CODES DENCode on codCode = pcfEEC.Employment_BenefitPlanCode and codTable = 'CO_COBRADENTALVISION'
   left JOIN CODES MEDCode on MedCode.codCode = pcfEEC.Employment_BenefitPlanCode and MedCode.codTable = 'CO_COBRAMEDICALRX'
        WHERE bdmRunID = 'QB' and bdmIsPQB = 'N' and   bdmdedType  IN ('DEN', 'VIS', 'MED', 'DRG')  and  bdmDedCode <> 'MMOPT'
    ;
    END

    Delete from dbo.U_ECYCCOBRA_drvTbl_QBDEPINIT  where drvPlanNameQBDEPinit is null

    INSERT INTO dbo.U_ECYCCOBRA_drvTbl_QBDEPINIT
        SELECT DISTINCT
         drvEEID 
        ,drvCoID 
        ,drvInitialSort
        ,drvSubSort
        ,drvSubsort2 
        ,drvDepRecID
        -- standard fields above and additional driver fields below
        ,drvRecordIdentifierQBDEPinit 
        ,'MED'
        ,drvPlanNameQBDEPinit = SUBSTRING(drvPlanBundleNameQBPL,0,CHARINDEX('and',drvPlanBundleNameQBPL))
        ,drvPlanBundleNameQBPL 
    FROM dbo.U_ECYCCOBRA_drvTbl_QBDEPINIT where bdmdedtype  = 'DRG'

     IF OBJECT_ID('U_ECYCCOBRA_drvTbl_QBDEPINIT_2','U') IS NOT NULL
        DROP TABLE dbo.U_ECYCCOBRA_drvTbl_QBDEPINIT_2;

    SELECT DISTINCT
         drvEEID 
        ,drvCoID 
        ,drvInitialSort 
        ,drvSubSort 
        ,drvSubsort2 
        ,drvDepRecID 
        -- standard fields above and additional driver fields below
        ,drvRecordIdentifierQBDEPinit 
        ,bdmdedtype
        ,drvPlanNameQBDEPinit 
                                  
        ,drvPlanBundleNameQBPL  
    INTO dbo.U_ECYCCOBRA_drvTbl_QBDEPINIT_2
    FROM dbo.U_ECYCCOBRA_drvTbl_QBDEPINIT
    
    Delete from dbo.U_ECYCCOBRA_drvTbl_QBDEPINIT
    
    INSERT INTO U_ECYCCOBRA_drvTbl_QBDEPINIT
    SELECT DISTINCT
         drvEEID 
        ,drvCoID 
        ,drvInitialSort 
        ,drvSubSort 
        ,drvSubsort2 
        ,drvDepRecID 
        -- standard fields above and additional driver fields below
        ,drvRecordIdentifierQBDEPinit 
        ,bdmdedtype
        ,drvPlanNameQBDEPinit 
                                  
        ,drvPlanBundleNameQBPL  
    FROM dbo.U_ECYCCOBRA_drvTbl_QBDEPINIT_2
     
    

    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
     IF @ExportCode LIKE '%NPM%'
     BEGIN
        IF OBJECT_ID('U_ECYCCOBRA_Header_NPM','U') IS NOT NULL
            DROP TABLE dbo.U_ECYCCOBRA_Header_NPM;
        SELECT DISTINCT
             drvVersionLineIdentifierNPM = '[VERSION]'
            ,drvVersionNumberNPM = '1.0'
        INTO dbo.U_ECYCCOBRA_Header_NPM
         ;
     END
     ELSE
     BEGIN
        ---------------------------------
        -- HEADER RECORD
        ---------------------------------
        IF OBJECT_ID('U_ECYCCOBRA_Header_QB','U') IS NOT NULL
            DROP TABLE dbo.U_ECYCCOBRA_Header_QB;
        SELECT DISTINCT
             drvVersionLineIdentifierQB = '[VERSION]'
            ,drvVersionNumberQB = '1.2'
        INTO dbo.U_ECYCCOBRA_Header_QB
        ;
     END
    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' AND @ExportCode LIKE '%NPM%' THEN 'test_cobra_NPM_ats_auto_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.csv'
                                  WHEN  dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' AND @ExportCode LIKE '%QB%' THEN 'test_cobra_QE_ats_auto_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.csv'
                             ELSE 
                                CASE 
                                    WHEN @ExportCode LIKE '%NPM%' THEN 'cobra_NPM_ats_auto_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.csv'
                                    WHEN @ExportCode LIKE '%QB%'  THEN 'cobra_QE_ats_auto_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.csv'
                                END
                             END
            WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwECYCCOBRA_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECYCCOBRA_File (NOLOCK)
    ORDER BY  InitialSort, RIGHT(RecordSet,2), SubSort, subsort2;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ECYCCOBRA%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201701011'
       ,expStartPerControl     = '201701011'
       ,expLastEndPerControl   = '201703319'
       ,expEndPerControl       = '201703319'
WHERE expFormatCode = 'ECYCCOBRA';



    --------JOB NAME: CYC COBRA Export (ECYCCOBRA) - Weekly, Thursday, 8:00am ET--------
    --Copy and paste this in environment to create job script

    BEGIN TRANSACTION
    DECLARE @ReturnCode INT, @JobName varchar(100), @dbName varchar(50)
    SELECT @ReturnCode = 0
    SELECT @JobName = RTRIM(REPLACE(DB_NAME(),'ULTIPRO_','')) + ' - CYC COBRA Export (ECYCCOBRA) - Weekly, Thursday, 8:00am ET'
    SELECT @dbname = RTRIM(DB_NAME())

    -- Job Params
    IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
    BEGIN
    EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

    END

    DECLARE @jobId BINARY(16)
    EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=@JobName, 
            @enabled=0,
            @notify_level_eventlog=0, 
            @notify_level_email=0, 
            @notify_level_netsend=0, 
            @notify_level_page=0, 
            @delete_level=0, 
            @description=N'No description available.', 
            @category_name=N'[Uncategorized (Local)]', 
            @job_id = @jobId OUTPUT
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

    -- Step [Run]
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

    -- Step 'Update AscExp'
    EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Update AscExp Start/End Date (ECYCCOBRA)', 
            @step_id=1, 
            @cmdexec_success_code=0, 
            @on_success_action=3, 
            @on_success_step_id=0, 
            @on_fail_action=2, 
            @on_fail_step_id=0, 
            @retry_attempts=0, 
            @retry_interval=0, 
            @os_run_priority=0, @subsystem=N'TSQL', 
            @command=N'DECLARE @StartPerControl char(9), 
        @EndPerControl char(9), 
        @RunDate datetime; 

    SELECT @StartPerControl = CONVERT(char(8),GETDATE()-7,112) + ''1''; 
    SELECT @EndPerControl = CONVERT(char(8),GETDATE()-1,112) + ''9''; 
    SELECT @RunDate = GETDATE(); 

UPDATE dbo.AscExp
SET    expStartPerControl = @StartPerControl,
    expLastStartPerControl = @StartPerControl,
    expEndPerControl = @EndPerControl,
    expLastEndPerControl = @EndPerControl,
    expExported = @RunDate
WHERE expFormatCode = ''ECYCCOBRA''
  AND expExportCode = ''SCHEDULED'';',
            @database_name=@dbName,
            @flags=0
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

    -- Step 'Run SP'
    EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Create Export File (ECYCCOBRA)', 
            @step_id=2, 
            @cmdexec_success_code=0, 
            @on_success_action=1, 
            @on_success_step_id=0, 
            @on_fail_action=2, 
            @on_fail_step_id=0, 
            @retry_attempts=0, 
            @retry_interval=0, 
            @os_run_priority=0, @subsystem=N'TSQL', 
            @command=N'EXEC dbo.dsi_sp_TestSwitchbox_v2 ''ECYCCOBRA'', ''SCHEDULED'';', 
            @database_name=@dbName, 
            @flags=0
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
    EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
    EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Weekly, Thursday, 8:00am ET',
            @enabled=1, 
            @freq_type=8, 
            @freq_interval=16,  
            @freq_subday_type=1, 
            @freq_subday_interval=0, 
            @freq_relative_interval=0,
            @freq_recurrence_factor=1,
            @active_start_date=20200227,
            @active_end_date=99991231,
            @active_start_time=080000,
            @active_end_time=235959;
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback;
    EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)';
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback;
    EXEC msdb..usg_set_job_owner @job_id = @jobId, @set_owner_to_self = 0;
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback;
    COMMIT TRANSACTION
    GOTO EndSave;
    QuitWithRollback:
        IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION;
    EndSave:

    GO
    --------END JOB SCRIPT--------
**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwECYCCOBRA_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECYCCOBRA_File (NOLOCK)
    ORDER BY  InitialSort,  SubSort, subsort2, RIGHT(RecordSet,2)