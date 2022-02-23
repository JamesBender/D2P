SET NOCOUNT ON;
IF OBJECT_ID('U_ECOBRAQBEX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECOBRAQBEX_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ECOBRAQBEX_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ECOBRAQBEX' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwECOBRAQBEX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECOBRAQBEX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECOBRAQBEX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECOBRAQBEX];
GO
IF OBJECT_ID('U_ECOBRAQBEX_Header_QB') IS NOT NULL DROP TABLE [dbo].[U_ECOBRAQBEX_Header_QB];
GO
IF OBJECT_ID('U_ECOBRAQBEX_Header_NPM') IS NOT NULL DROP TABLE [dbo].[U_ECOBRAQBEX_Header_NPM];
GO
IF OBJECT_ID('U_ECOBRAQBEX_File') IS NOT NULL DROP TABLE [dbo].[U_ECOBRAQBEX_File];
GO
IF OBJECT_ID('U_ECOBRAQBEX_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECOBRAQBEX_EEList];
GO
IF OBJECT_ID('U_ECOBRAQBEX_drvTbl_QBPLANMBRSPRATE') IS NOT NULL DROP TABLE [dbo].[U_ECOBRAQBEX_drvTbl_QBPLANMBRSPRATE];
GO
IF OBJECT_ID('U_ECOBRAQBEX_drvTbl_QBPLAN') IS NOT NULL DROP TABLE [dbo].[U_ECOBRAQBEX_drvTbl_QBPLAN];
GO
IF OBJECT_ID('U_ECOBRAQBEX_drvTbl_QBEVENT') IS NOT NULL DROP TABLE [dbo].[U_ECOBRAQBEX_drvTbl_QBEVENT];
GO
IF OBJECT_ID('U_ECOBRAQBEX_drvTbl_QBDEPINIT') IS NOT NULL DROP TABLE [dbo].[U_ECOBRAQBEX_drvTbl_QBDEPINIT];
GO
IF OBJECT_ID('U_ECOBRAQBEX_drvTbl_QBDEP') IS NOT NULL DROP TABLE [dbo].[U_ECOBRAQBEX_drvTbl_QBDEP];
GO
IF OBJECT_ID('U_ECOBRAQBEX_drvTbl_QB') IS NOT NULL DROP TABLE [dbo].[U_ECOBRAQBEX_drvTbl_QB];
GO
IF OBJECT_ID('U_ECOBRAQBEX_DedList') IS NOT NULL DROP TABLE [dbo].[U_ECOBRAQBEX_DedList];
GO
IF OBJECT_ID('U_ECOBRAQBEX_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ECOBRAQBEX_AuditFields];
GO
IF OBJECT_ID('U_ECOBRAQBEX_Audit') IS NOT NULL DROP TABLE [dbo].[U_ECOBRAQBEX_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_ECOBRAQBEX') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ECOBRAQBEX];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ECOBRAQBEX';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ECOBRAQBEX';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ECOBRAQBEX';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ECOBRAQBEX';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ECOBRAQBEX';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ECOBRAQBEX','IGOE COBRA QB Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','ECOBRAQBEXZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ECOBRAQBEX' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVersionLineIdentifierQB"','1','(''UA''=''T,'')','ECOBRAQBEXZ0','50','H','02','1',NULL,'Version Line Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVersionNumberQB"','2','(''UA''=''T'')','ECOBRAQBEXZ0','50','H','02','2',NULL,'Version Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordIdentifierQB"','1','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','20','1',NULL,'Record Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientNameQB"','2','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','20','2',NULL,'ClientName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientDivisionNameQB"','3','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','20','3',NULL,'ClientDivisionName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalutationQB"','4','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','20','4',NULL,'Salutation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstNameQB"','5','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','20','5',NULL,'FirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMiddleInitialQB"','6','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','20','6',NULL,'MiddleInitial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastNameQB"','7','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','20','7',NULL,'LastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSNQB"','8','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','20','8',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIndividualIDQB"','9','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','20','9',NULL,'IndividualID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmailQB"','10','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','20','10',NULL,'Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneQB"','11','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','20','11',NULL,'Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhone2QB"','12','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','20','12',NULL,'Phone2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddress1QB"','13','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','20','13',NULL,'Address1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddress2QB"','14','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','20','14',NULL,'Address2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCityQB"','15','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','20','15',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStateOrProvinceQB"','16','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','20','16',NULL,'StateOrProvince',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPostalCodeQB"','17','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','20','17',NULL,'PostalCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountryQB"','18','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','20','18',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPremAddressSameAsPrimQB"','19','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','20','19',NULL,'PremiumAddressSameAsPrimary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPremiumAddress1QB"','20','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','20','20',NULL,'PremiumAddress1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPremiumAddress2QB"','21','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','20','21',NULL,'PremiumAddress2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPremiumCityQB"','22','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','20','22',NULL,'PremiumCity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPremiumStateOrProvinceQB"','23','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','20','23',NULL,'PremiumStateOrProvince',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPremiumPostalCodeQB"','24','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','20','24',NULL,'PremiumPostalCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPremiumCountryQB"','25','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','20','25',NULL,'PremiumCountry',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSexQB"','26','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','20','26',NULL,'Sex',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDOBQB"','27','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','20','27',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTobaccoUseQB"','28','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','20','28',NULL,'TobaccoUse',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeTypeQB"','29','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','20','29',NULL,'EmployeeType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeePayrollTypeQB"','30','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','20','30',NULL,'EmployeePayrollType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYearsOfServiceQB"','31','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','20','31',NULL,'YearsOfService',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPremiumCouponTypeQB"','32','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','20','32',NULL,'PremiumCouponType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUsesHCTCQB"','33','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','20','33',NULL,'UsesHCTC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvActiveQB"','34','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','20','34',NULL,'Active',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAllowMemberSSOQB"','35','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','20','35',NULL,'AllowMemberSSO',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitGroupQB"','36','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','20','36',NULL,'BenefitGroup',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccountStructureQB"','37','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','20','37',NULL,'AccountStructure',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientSpecificDataQB"','38','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','20','38',NULL,'ClientSpecificData',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSOIDQB"','39','(''UA''=''T'')','ECOBRAQBEXZ0','50','D','20','39',NULL,'SSOID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordIdentifierQBEv"','1','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','30','1',NULL,'Record Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEveECYCntTypeQBEv"','2','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','30','2',NULL,'EveECYCntType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEventDateQBEv"','3','(''UD101''=''T,'')','ECOBRAQBEXZ0','50','D','30','3',NULL,'EventDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrollmentDateQBEv"','4','(''UD101''=''T,'')','ECOBRAQBEXZ0','50','D','30','4',NULL,'EnrollmentDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeSSNQBEv"','5','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','30','5',NULL,'EmployeeSSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeNameQBEv"','6','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','30','6',NULL,'EmployeeName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSecondEvntOrigiFDOCQBEv"','7','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','30','7',NULL,'SecondEventOriginalFDOC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIsSecEvntAEIEligQBEv"','8','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','30','8',NULL,'SecondEventOriginalFDOC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSecEvntAEISubStartDateQBEv"','9','(''UA''=''T'')','ECOBRAQBEXZ0','50','D','30','9',NULL,'SecondEventOriginalFDOC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordIdentifierQBPL"','1','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','40','1',NULL,'Record Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanNameQBPL"','2','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','40','2',NULL,'PlanName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageLevelQBPL"','3','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','40','5',NULL,'CoverageLevel',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNumberOfUnits"','4','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','40','6',NULL,'FirstDayOfCOBRA',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordIdentifierQBPLMBR"','1','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','41','1',NULL,'FirstDayOfCOBRA',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanName"','2','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','41','2',NULL,'FirstDayOfCOBRA',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRate"','3','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','41','3',NULL,'FirstDayOfCOBRA',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordIdentifierQBDEP"','1','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','50','1',NULL,'Record Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSNQBDEP"','2','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','50','2',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelationshipQBDEP"','3','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','50','3',NULL,'Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalutationQBDEP"','4','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','50','4',NULL,'Salutation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstNameQBDEP"','5','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','50','5',NULL,'FirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMiddleInitialQBDEP"','6','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','50','6',NULL,'MiddleInitial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastNameQBDEP"','7','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','50','7',NULL,'LastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmailQBDEP"','8','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','50','8',NULL,'Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneQBDEP"','9','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','50','9',NULL,'Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhone2QBDEP"','10','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','50','10',NULL,'Phone2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressSameAsQBQBDEP"','11','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','50','11',NULL,'AddressSameAsQB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddress1QBDEP"','12','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','50','12',NULL,'Address1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddress2QBDEP"','13','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','50','13',NULL,'Address2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCityQBDEP"','14','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','50','14',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStateOrProvinceQBDEP"','15','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','50','15',NULL,'StateOrProvince',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPostalCodeQBDEP"','16','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','50','16',NULL,'PostalCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountryQBDEP"','17','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','50','17',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrollmentDateQBDEP"','18','(''UD101''=''T,'')','ECOBRAQBEXZ0','50','D','50','18',NULL,'EnrollmentDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSexQBDEP"','19','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','50','19',NULL,'Sex',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDOBQBDEP"','20','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','50','20',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIsQMCSOQBDEP"','21','(''UA''=''T'')','ECOBRAQBEXZ0','50','D','50','21',NULL,'IsQMCSO',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordIdentifierQBDEPinit"','1','(''UA''=''T,'')','ECOBRAQBEXZ0','50','D','60','1',NULL,'Record Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanNameQBDEPinit"','2','(''UA''=''T'')','ECOBRAQBEXZ0','50','D','60','2',NULL,'PlanName',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'ECOBRAQBEX_20210210.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'IGOE QB  Active Open Enr','202012029','EMPEXPORT','OEACTIVE',NULL,'ECOBRAQBEX',NULL,NULL,NULL,'202012029','Feb 27 2020  5:41AM','Feb 27 2020  5:41AM','202012021',NULL,'','','202012021',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'IGOE QB Passive Open Enr','202012029','EMPEXPORT','OEPASSIVE',NULL,'ECOBRAQBEX',NULL,NULL,NULL,'202012029','Feb 27 2020  5:41AM','Feb 27 2020  5:41AM','202012021',NULL,'','','202012021',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'IGOE COBRA QB Export','202012029','EMPEXPORT','ONDEM_XOE',NULL,'ECOBRAQBEX',NULL,NULL,NULL,'202012029','Feb 27 2020  5:41AM','Feb 27 2020  5:41AM','202012021',NULL,'','','202012021',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'IGOE COBRA QB Export - SCHED','202012029','EMPEXPORT','SCH_ECOQB',NULL,'ECOBRAQBEX',NULL,NULL,NULL,'202012029','Feb 27 2020  5:41AM','Feb 27 2020  5:41AM','202012021',NULL,'','','202012021',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'IGOE COBRA QB Export- Test','202102109','EMPEXPORT','TEST_XOE','Feb 10 2021 10:05AM','ECOBRAQBEX',NULL,NULL,NULL,'202102109','Feb 10 2021 12:00AM','Dec 30 1899 12:00AM','202011011','215','','','202011011',dbo.fn_GetTimedKey(),NULL,'us3lKiTEN1000',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOBRAQBEX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOBRAQBEX','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOBRAQBEX','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOBRAQBEX','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOBRAQBEX','SubSort2','C','drvSubSort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOBRAQBEX','SubSort3','C','drvSubSort3');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOBRAQBEX','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOBRAQBEX','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'ECOBRAQBEX' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'ECOBRAQBEX' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_ECOBRAQBEX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECOBRAQBEX_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECOBRAQBEX','H02','dbo.U_ECOBRAQBEX_Header_QB',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECOBRAQBEX','D20','dbo.U_ECOBRAQBEX_drvTbl_QB',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECOBRAQBEX','D30','dbo.U_ECOBRAQBEX_drvTbl_QBEVENT',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECOBRAQBEX','D40','dbo.U_ECOBRAQBEX_drvTbl_QBPLAN',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECOBRAQBEX','D41','dbo.U_ECOBRAQBEX_drvTbl_QBPLANMBRSPRATE',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECOBRAQBEX','D50','dbo.U_ECOBRAQBEX_drvTbl_QBDEP',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECOBRAQBEX','D60','dbo.U_ECOBRAQBEX_drvTbl_QBDEPINIT',NULL);
IF OBJECT_ID('U_dsi_BDM_ECOBRAQBEX') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ECOBRAQBEX] (
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
IF OBJECT_ID('U_ECOBRAQBEX_Audit') IS NULL
CREATE TABLE [dbo].[U_ECOBRAQBEX_Audit] (
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
IF OBJECT_ID('U_ECOBRAQBEX_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ECOBRAQBEX_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_ECOBRAQBEX_DedList') IS NULL
CREATE TABLE [dbo].[U_ECOBRAQBEX_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ECOBRAQBEX_drvTbl_QB') IS NULL
CREATE TABLE [dbo].[U_ECOBRAQBEX_drvTbl_QB] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NOT NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(208) NULL,
    [drvRecordIdentifierQB] varchar(4) NOT NULL,
    [drvClientNameQB] varchar(20) NOT NULL,
    [drvClientDivisionNameQB] varchar(13) NOT NULL,
    [drvSalutationQB] varchar(1) NOT NULL,
    [drvFirstNameQB] varchar(100) NULL,
    [drvMiddleInitialQB] varchar(1) NULL,
    [drvLastNameQB] varchar(100) NULL,
    [drvSSNQB] char(11) NULL,
    [drvIndividualIDQB] varchar(1) NOT NULL,
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
    [drvEmployeeTypeQB] varchar(3) NOT NULL,
    [drvEmployeePayrollTypeQB] varchar(7) NOT NULL,
    [drvYearsOfServiceQB] varchar(1) NOT NULL,
    [drvPremiumCouponTypeQB] varchar(10) NOT NULL,
    [drvUsesHCTCQB] varchar(1) NOT NULL,
    [drvActiveQB] varchar(4) NOT NULL,
    [drvAllowMemberSSOQB] varchar(5) NOT NULL,
    [drvBenefitGroupQB] varchar(1) NOT NULL,
    [drvAccountStructureQB] varchar(1) NOT NULL,
    [drvClientSpecificDataQB] varchar(1) NOT NULL,
    [drvSSOIDQB] varchar(1) NOT NULL
);
IF OBJECT_ID('U_ECOBRAQBEX_drvTbl_QBDEP') IS NULL
CREATE TABLE [dbo].[U_ECOBRAQBEX_drvTbl_QBDEP] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(12) NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(33) NULL,
    [drvSubSort3] varchar(208) NULL,
    [drvDepRecID] char(12) NULL,
    [drvRecordIdentifierQBDEP] varchar(13) NOT NULL,
    [drvSSNQBDEP] char(11) NULL,
    [drvRelationshipQBDEP] varchar(15) NULL,
    [drvSalutationQBDEP] varchar(1) NOT NULL,
    [drvFirstNameQBDEP] varchar(100) NULL,
    [drvMiddleInitialQBDEP] varchar(1) NULL,
    [drvLastNameQBDEP] varchar(100) NULL,
    [drvEmailQBDEP] varchar(1) NOT NULL,
    [drvPhoneQBDEP] varchar(1) NOT NULL,
    [drvPhone2QBDEP] varchar(1) NOT NULL,
    [drvAddressSameAsQBQBDEP] varchar(4) NOT NULL,
    [drvAddress1QBDEP] varchar(1) NOT NULL,
    [drvAddress2QBDEP] varchar(1) NOT NULL,
    [drvCityQBDEP] varchar(1) NOT NULL,
    [drvStateOrProvinceQBDEP] varchar(1) NOT NULL,
    [drvPostalCodeQBDEP] varchar(1) NOT NULL,
    [drvCountryQBDEP] varchar(1) NOT NULL,
    [drvEnrollmentDateQBDEP] varchar(1) NOT NULL,
    [drvSexQBDEP] char(1) NULL,
    [drvDOBQBDEP] varchar(30) NULL,
    [drvIsQMCSOQBDEP] varchar(1) NOT NULL
);
IF OBJECT_ID('U_ECOBRAQBEX_drvTbl_QBDEPINIT') IS NULL
CREATE TABLE [dbo].[U_ECOBRAQBEX_drvTbl_QBDEPINIT] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(38) NULL,
    [drvSubSort3] varchar(208) NULL,
    [drvDepRecID] char(12) NULL,
    [drvRecordIdentifierQBDEPinit] varchar(24) NOT NULL,
    [drvPlanNameQBDEPinit] varchar(47) NULL
);
IF OBJECT_ID('U_ECOBRAQBEX_drvTbl_QBEVENT') IS NULL
CREATE TABLE [dbo].[U_ECOBRAQBEX_drvTbl_QBEVENT] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(208) NULL,
    [drvDepRecID] char(12) NOT NULL,
    [drvRecordIdentifierQBEv] varchar(9) NOT NULL,
    [drvEveECYCntTypeQBEv] varchar(29) NOT NULL,
    [drvEventDateQBEv] varchar(30) NULL,
    [drvEnrollmentDateQBEv] varchar(30) NULL,
    [drvEmployeeSSNQBEv] char(11) NULL,
    [drvEmployeeNameQBEv] varchar(232) NOT NULL,
    [drvSecondEvntOrigiFDOCQBEv] varchar(1) NOT NULL,
    [drvIsSecEvntAEIEligQBEv] varchar(1) NOT NULL,
    [drvSecEvntAEISubStartDateQBEv] varchar(1) NOT NULL
);
IF OBJECT_ID('U_ECOBRAQBEX_drvTbl_QBPLAN') IS NULL
CREATE TABLE [dbo].[U_ECOBRAQBEX_drvTbl_QBPLAN] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(208) NULL,
    [drvDepRecID] char(12) NULL,
    [drvRecordIdentifierQBPL] varchar(15) NOT NULL,
    [drvPlanNameQBPL] varchar(43) NULL,
    [drvCoverageLevelQBPL] varchar(11) NULL,
    [drvNumberOfUnits] varchar(1) NOT NULL
);
IF OBJECT_ID('U_ECOBRAQBEX_drvTbl_QBPLANMBRSPRATE') IS NULL
CREATE TABLE [dbo].[U_ECOBRAQBEX_drvTbl_QBPLANMBRSPRATE] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(208) NULL,
    [drvDepRecID] char(12) NULL,
    [drvRecordIdentifierQBPLMBR] varchar(18) NOT NULL,
    [drvPlanName] varchar(13) NULL,
    [drvRate] varchar(30) NULL
);
IF OBJECT_ID('U_ECOBRAQBEX_EEList') IS NULL
CREATE TABLE [dbo].[U_ECOBRAQBEX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ECOBRAQBEX_File') IS NULL
CREATE TABLE [dbo].[U_ECOBRAQBEX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
IF OBJECT_ID('U_ECOBRAQBEX_Header_NPM') IS NULL
CREATE TABLE [dbo].[U_ECOBRAQBEX_Header_NPM] (
    [drvVersionLineIdentifierNPM] varchar(9) NOT NULL,
    [drvVersionNumberNPM] varchar(3) NOT NULL
);
IF OBJECT_ID('U_ECOBRAQBEX_Header_QB') IS NULL
CREATE TABLE [dbo].[U_ECOBRAQBEX_Header_QB] (
    [drvVersionLineIdentifierQB] varchar(9) NOT NULL,
    [drvVersionNumberQB] varchar(3) NOT NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECOBRAQBEX]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Tender Greens

Created By: Inshan Singh
Business Analyst: Lea King
Create Date: 11/30/2020
Service Request Number: TekP-2020-10-08-0004  

Purpose: Igoe Cobra QB

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECOBRAQBEX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECOBRAQBEX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECOBRAQBEX';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECOBRAQBEX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECOBRAQBEX' ORDER BY RunID DESC;

Job Ownership Scripts
---------------------
-- Set job owner to ssis_user for Production jobs
EXEC msdb..usg_set_job_owner @job_name = '', @set_owner_to_self = 0;

-- Set job owner to self, to make changes in SQL Job Scheduler. Remember to re-run the above script to change ownership to ssis_user when complete
EXEC msdb..usg_set_job_owner @job_name = '', @set_owner_to_self = 1;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECOBRAQBEX', 'OND_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECOBRAQBEX', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECOBRAQBEX', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECOBRAQBEX', 'TEST_XOE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ECOBRAQBEX';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ECOBRAQBEX', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ECOBRAQBEX';

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
    DELETE FROM dbo.U_ECOBRAQBEX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECOBRAQBEX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_ECOBRAQBEX_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ECOBRAQBEX_AuditFields;
    CREATE TABLE dbo.U_ECOBRAQBEX_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_ECOBRAQBEX_AuditFields VALUES ('EmpDed','EedBenStopDate');
    INSERT INTO dbo.U_ECOBRAQBEX_AuditFields VALUES ('EmpDed','EedDedCode');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ECOBRAQBEX_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ECOBRAQBEX_Audit;
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
    INTO dbo.U_ECOBRAQBEX_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_ECOBRAQBEX_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ECOBRAQBEX_Audit ON dbo.U_ECOBRAQBEX_Audit (audEEID,audKey2);

    --================
    -- Changes Only
    --================
    --DELETE FROM dbo.U_ECOBRAQBEX_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_ECOBRAQBEX_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'MED,HDH,MED2,MED1,FSA,LPFSA,DNTLS,HDNLS,DEN,VIS,SL1M1,SL2M1, SL3M1, SL4M1,SL1M2,SL2M2,SL3M2,SL4M2,SL1M3,SL2M3,SL3M3,SL4M3,SL1M4,SL2M4,SL3M4,SL4M4,SL1M5,SL2M5,SL3M5,SL4M5,FSA,LPFSA,DEN,DEN2,VIS';

    IF OBJECT_ID('U_ECOBRAQBEX_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ECOBRAQBEX_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ECOBRAQBEX_DedList
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


    -- COBRA parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RunID','QB');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','Y'); -- DedIsCobraCovered = 'Y'
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraType','4'); -- Eep/ConCobraReason first, then EdhChangeReason. Include CHGRP for elig. ben groups
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraDate','3'); -- EedBenStopDate and DbnBenStopDate, unless Eep/ConDateOfCOBRAEvent exists
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraPQBType','1'); -- If no EE or spouse, ALL children are PQB (not just oldest)
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraReasonsDepPQB','201,204,210,LEVNT3,LEVNT4'); -- Valid dependent PQB reasons
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidCobraReasonsEmp','201,204,210,LEVNT3,LEVNT4'); -- Invalidate employee when Cobra Reason is a dependent PQB reason
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidTermReasonsEmp','203,210'); -- Invalidate employee when Cobra Reason is "Death"
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'ConCobraReasonPCF','DependentCOBRAReason'); -- Valid dependent PQB reasons
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CountDependents','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL,DPC,STC,DCH');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    
    -- Run BDM for QB
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;


 --   --==========================================
 --   -- Insert into BDM Reason code 201 and 204
 --   --==========================================
    INSERT INTO [dbo].[U_dsi_BDM_ECOBRAQBEX]
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
            WHERE edhChangeReason in ('204') and dbnBenstatusdate between @startdate and @enddate and dbnValidForExport = 'N'
                        Group by dbnCoid,dbneeid,DbnDepRecID,DbnRelationship,DbnDateOfBirth,dbnDedcode,edhBenStopDate,edhEffDate,edhStartDate,edhStopDate,edhbenoption


INSERT INTO [dbo].[U_dsi_BDM_ECOBRAQBEX]
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
            
            WHERE edhChangeReason in ('201') and dbnBenstatusdate between @startdate and @enddate and dbnValidForExport = 'N'
            Group by dbncoid, dbneeid,DbnDepRecID,DbnRelationship,DbnDateOfBirth,dbnDedcode,edhBenStopDate,edhEffDate,edhStartDate,edhStopDate,edhbenoption


            Delete from dbo.U_dsi_BDM_ECOBRAQBEX where bdmdedcode not in (Select dedcode from U_ECOBRAQBEX_DedList)

            Update dbo.U_dsi_BDM_ECOBRAQBEX  
            set bdmNumSpouses = (select count(*) from U_dsi_BDM_ECOBRAQBEX A where A.bdmeeid = X.bdmeeid and bdmRelationship = 'SPS' and A.bdmcoid = X.bdmcoid)
            ,bdmNumChildren = (select count(*) from U_dsi_BDM_ECOBRAQBEX A where A.bdmeeid = X.bdmeeid and bdmRelationship = 'CHL' and A.bdmcoid = X.bdmcoid)
            from dbo.U_dsi_BDM_ECOBRAQBEX  X

            where BdmDedRowStatus IN ('Data Inserted for 204 Chg reason','Data Inserted for 201 Chg reason')


    --==========================================
    -- Build Driver Tables
    --==========================================
 
    ---------------------------------
    -- DETAIL RECORD - U_ECOBRAQBEX_drvTbl_QB
    ---------------------------------
    IF OBJECT_ID('U_ECOBRAQBEX_drvTbl_QB','U') IS NOT NULL
        DROP TABLE dbo.U_ECOBRAQBEX_drvTbl_QB;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID       = ISNULL(BdmDepRecID,'')

        ,drvInitialSort    = '21'
        ,drvSubSort        = CASE WHEN BdmRecType = 'EMP' THEN eepSSN
                                  ELSE ISNULL(NULLIF(ConSSN,''),eepSSN) + CONVERT(char(8),ConDateOfBirth,112)
                             END
        ,drvSubSort2       = '1'
        ,drvSubSort3       = CASE WHEN BdmRecType = 'EMP' THEN '2'
                                  ELSE CONVERT(char(8),ConDateOfBirth,112) + RTRIM(ConNameLast) + ConNameFirst
                             END
        ,drvRecordIdentifierQB = '[QB]'
        ,drvClientNameQB = 'TYP Restaurant Group'    
        ,drvClientDivisionNameQB = 'Tender Greens'
        ,drvSalutationQB = '' --blank
        ,drvFirstNameQB = CASE WHEN BdmChangeReason IN ('203','204', 'LEVNT4', '201', 'LEVNT3', '210' )  or EecTermReason IN ('203') THEN ConNameFirst 
                               ELSE EepNameFirst
                          END
        ,drvMiddleInitialQB = CASE WHEN BdmChangeReason IN ('203','204', 'LEVNT4', '201', 'LEVNT3', '210' )  or EecTermReason IN ('203') THEN LEFT(ConNameMiddle,1) 
                               ELSE LEFT(EepNameMiddle,1)
                          END
        ,drvLastNameQB =  CASE WHEN BdmChangeReason IN ('203','204', 'LEVNT4', '201', 'LEVNT3', '210' )  or EecTermReason IN ('203') THEN ConNameLast
                            ELSE EepNameLast
                          END
        ,drvSSNQB = CASE WHEN BdmChangeReason IN ('203','204', 'LEVNT4', '201', 'LEVNT3', '210' )  or EecTermReason IN ('203') THEN ConSSN
                            ELSE EepSSN
                    END
        ,drvIndividualIDQB = '' -- leave blank
        ,drvEmailQB = '' -- blank
        ,drvPhoneQB = '' -- blank
        ,drvPhone2QB = '' -- blank
        ,drvAddress1QB = EepAddressLine1 
        ,drvAddress2QB = EepAddressLine2 
        ,drvCityQB =  EepAddressCity 
        ,drvStateOrProvinceQB = EepAddressState 
        ,drvPostalCodeQB = EepAddressZipCode 
        ,drvCountryQB = ''
        ,drvPremAddressSameAsPrimQB = 'TRUE'
        ,drvPremiumAddress1QB = '' -- blank
        ,drvPremiumAddress2QB = '' -- blank
        ,drvPremiumCityQB = '' -- blank
        ,drvPremiumStateOrProvinceQB = '' -- blank
        ,drvPremiumPostalCodeQB = '' -- blank
        ,drvPremiumCountryQB = '' -- blank
        ,drvSexQB = CASE WHEN BdmChangeReason IN ('203','204', 'LEVNT4', '201', 'LEVNT3', '210' )  or EecTermReason IN ('203') THEN ConGender
                            ELSE EepGender
                    END
        ,drvDOBQB = CASE WHEN BdmChangeReason IN ('203','204', 'LEVNT4', '201', 'LEVNT3', '210' )  or EecTermReason IN ('203') THEN CONVERT(VARCHAR,ConDateOfBirth,101) 
                            ELSE CONVERT(VARCHAR,EepDateOfBirth,101) 
                    END
        ,drvTobaccoUseQB = 'Unknown' 
        ,drvEmployeeTypeQB = 'FTE'
        ,drvEmployeePayrollTypeQB = 'Unknown'
        ,drvYearsOfServiceQB = '' --blank
        ,drvPremiumCouponTypeQB = 'COUPONBOOK'
        ,drvUsesHCTCQB = '' -- blank
        ,drvActiveQB = 'TRUE'
        ,drvAllowMemberSSOQB = 'FALSE'
        ,drvBenefitGroupQB = '' --Blank
        ,drvAccountStructureQB = '' -- blank
        ,drvClientSpecificDataQB = '' -- blank
        ,drvSSOIDQB = ''--Blank
    INTO dbo.U_ECOBRAQBEX_drvTbl_QB
    FROM dbo.U_ECOBRAQBEX_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ECOBRAQBEX WITH (NOLOCK)
        ON bdmEEID = xEEID
        AND bdmCOID = xCOID 
        and bdmIsPQB = 'Y'
   LEFT JOIN dbo.CONTACTS WITH(NOLOCK)
        ON ConEEID = xEEID
       AND ConSystemID = BdmDepRecID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON eecEEID = xEEID
        AND eecCOID = xCOID



    ---------------------------------
    -- DETAIL RECORD - U_ECOBRAQBEX_drvTbl_QBEVENT
    ---------------------------------
    IF OBJECT_ID('U_ECOBRAQBEX_drvTbl_QBEVENT','U') IS NOT NULL
        DROP TABLE dbo.U_ECOBRAQBEX_drvTbl_QBEVENT;
    SELECT DISTINCT
         drvEEID = drvEEID
        ,drvCoID = drvCoID
        ,drvInitialSort    = '21'
        ,drvSubSort        = drvSubSort
        ,drvSubSort2       = '1'
        ,drvSubSort3       = drvSubSort3    
        ,drvDepRecID = drvDepRecID --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRecordIdentifierQBEv = '[QBEVENT]'
        ,drvEveECYCntTypeQBEv =  CASE WHEN EecTermReason = '202' THEN 'RETIREMENT'
                                  WHEN EecTermReason = '203' THEN 'DEATH'
                                  WHEN BdmCobraReason IN ('201','LEVNT3') or  bdmChangeReason in ('201','LEVNT3') THEN 'INELIGIBLEDEPENDENT'
                                  WHEN BdmCobraReason IN ('204','LEVNT4')  or  bdmChangeReason in ('204','LEVNT4') THEN 'DIVORCELEGALSEPARATION'
                                  WHEN BdmCobraReason = '210' or  bdmChangeReason in ('210') THEN 'DEATH'
                                  WHEN BdmCobraReason IN ('202','CHGRP') or bdmChangeReason IN ('202','CHGRP') THEN 'LOSSOFELIGIBILITY'
                                  WHEN BdmCobraReason IN ('203','202') or bdmChangeReason IN ('203','202')   THEN 'REDUCTIONINHOURSSTATUSCHANGE '
                                  WHEN BdmCobraReason = '205' or bdmChangeReason = '205' THEN 'MEDICARE'
                                  WHEN BdmCobraReason = '206' or bdmChangeReason = '205'THEN 'REDUCTIONINHOURSENDOFLEAVE'
                                  WHEN BdmCobraReason = '207' or bdmChangeReason = '205'THEN 'USERRA-REDUCTIONINHOURS'
                                  WHEN BdmCobraReason = '208' or bdmChangeReason = '205'THEN 'RETIREMENT'
                                  WHEN BdmCobraReason = '209'or bdmChangeReason = '205' THEN 'WORKSTOPPAGE'
                                  WHEN EecEmplStatus = 'T' and eectermtype  = 'I' THEN 'INVOLUNTARYTERMINATION'
                                  ELSE 'TERMINATION'
                             
                                END
        ,drvEventDateQBEv = --d.BdmDateOfCOBRAEvent 
                                CONVERT( VARCHAR 
                                    ,CASE WHEN bdmChangeReason IN ('204', 'LEVNT4', '201', 'LEVNT3') or BdmCobraReason  IN ('204', 'LEVNT4', '201', 'LEVNT3' ) THEN bdmbenstatusdate ELSE bdmdateofcobraevent END
                                    ,101
                                   )
        ,drvEnrollmentDateQBEv =  CONVERT(VARCHAR,  d.BdmBenStartDate, 101)
        
                                --CASE WHEN BdmDedType = 'MED'
        --                           THEN CONVERT(VARCHAR, dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStopDate, BdmBenStartDate) , 101) 
        --                          ELSE ''
        --                          END
        ,drvEmployeeSSNQBEv = EepSSN
        ,drvEmployeeNameQBEv =  CONCAT(EepNameFirst,' ' , EepNameLast, ' ',  EepNameSuffix) 
        ,drvSecondEvntOrigiFDOCQBEv = '' --blank
        ,drvIsSecEvntAEIEligQBEv = '' --blank
        ,drvSecEvntAEISubStartDateQBEv = '' --blank
    INTO dbo.U_ECOBRAQBEX_drvTbl_QBEVENT
    FROM dbo.U_ECOBRAQBEX_drvTbl_QB WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = drvEEID 
        AND EecCoID = drvCoID
 
    JOIN (SELECT max(BdmDateOfCOBRAEvent) BdmDateOfCOBRAEvent, 
                    BdmDepRecID,
                    BdmBenStartDate = max(BdmBenStartDate)  ,
                    BdmBenStopDate = max(BdmBenStopDate)  , 
                    bdmEEID, bdmCOID, max(bdmChangeReason) as bdmChangeReason,
                    max(bdmCobraReason) as bdmCobraReason,
                    max(bdmbenstatusdate) as bdmbenstatusdate
                FROM dbo.U_dsi_BDM_ECOBRAQBEX WITH (NOLOCK) WHERE BdmIsPQB = 'Y'  group by bdmEEID, bdmCOID,BdmDepRecID) d
        ON d.bdmEEID = drvEEID
        AND d.bdmCOID = drvCOID
        AND ISNULL(BdmDepRecID,'') = drvDepRecID
    JOIN EmpPers WITH (NOLOCK)
        ON eepEEID = drvEEID
    --JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
    --    ON EedEEID = xEEID 
    --    AND EedCoID = xCoID
    --    AND EedFormatCode = @FormatCode 
    --    AND EedValidForExport = 'Y'
    ;

    ---------------------------------
    -- DETAIL RECORD - U_ECOBRAQBEX_drvTbl_QBPLAN
    ---------------------------------
    IF OBJECT_ID('U_ECOBRAQBEX_drvTbl_QBPLAN','U') IS NOT NULL
        DROP TABLE dbo.U_ECOBRAQBEX_drvTbl_QBPLAN;
    SELECT DISTINCT
         drvEEID = drveeid
        ,drvCoID = drvcoid
        ,drvInitialSort    = '21'
        ,drvSubSort        = drvSubSort
        ,drvSubSort2       = '1'
        ,drvSubSort3       = drvSubSort3
        ,drvDepRecID = bdmdeprecid
        -- standard fields above and additional driver fields below
        ,drvRecordIdentifierQBPL = '[QBPLANINITIAL]'
        ,drvPlanNameQBPL = CASE 
                                --WHEN BdmDedCode IN ('MED') THEN 'Blue Shield of CA Access+ Full HMO Medical Plan'
                                WHEN BdmDedCode IN ('HDHP') THEN 'Blue Shield of CA Full PPO HSA Medical Plan'
                                WHEN BdmDedCode IN ('MED2') THEN 'Blue Shield of CA Full PPO Medical Plan'
                                WHEN BdmDedCode IN ('MED1') THEN 'Blue Shield of CA Savenet HMO Medical Plan'
                                WHEN BdmDedCode IN ('FSA' , 'LPFSA') THEN 'Igoe FSA Plan'
                                WHEN BdmDedCode IN ('DNTLS', 'HDNLS') THEN 'Guardian Dental Salary'
                                WHEN BdmDedCode IN ('DEN') THEN 'United Concordia PPO Dental Plan'
                                WHEN BdmDedCode IN ('VIS') THEN 'VSP PPO Vision Plan'
                                /* 2021 Plan names */
                                WHEN BdmDedCode IN ('SL1M1', 'SL2M1', 'SL3M1', 'SL4M1') THEN 'Anthem Vivity HMO'
                                WHEN BdmDedCode IN ('SL1M2', 'SL2M2', 'SL3M2', 'SL4M2') THEN 'Anthem Priority Select HMO'
                                WHEN BdmDedCode IN ('MED', 'SL1M3', 'SL2M3', 'SL3M3', 'SL4M3') THEN 'Anthem Full Network HMO'
                                WHEN BdmDedCode IN ('SL1M4', 'SL2M4', 'SL3M4', 'SL4M4') THEN 'Anthem PPO HDHP'
                                WHEN BdmDedCode IN ('SL1M5', 'SL2M5', 'SL3M5', 'SL4M5') THEN 'Anthem PPO'
                                WHEN BdmDedCode IN ('FSA', 'LPFSA') THEN 'Igoe FSA Plan'
                                WHEN BdmDedCode IN ('DEN') THEN 'United Concordia PPO Dental Plan'
                                WHEN BdmDedCode IN ('DEN2') THEN 'United Concordia HMO Dental Plan'
                                WHEN BdmDedCode IN ('VIS') THEN 'VSP PPO Vision Plan'
                            END
        ,drvCoverageLevelQBPL = CASE 
                                    
                                    WHEN BdmChangeReason IN ('204', 'LEVNT4', '201', 'LEVNT3', '210' ) 
                                    or  BdmCobraReason IN ('204', 'LEVNT4', '201', 'LEVNT3', '210' )   THEN 
                                        CASE WHEN BdmNumChildren  = 1 or BdmNumSpouses = 1 then 'EE+CHILD'
                                             WHEN BdmNumChildren  > 1 or BdmNumSpouses = 1 then 'EE+CHILDREN'
                                             ELSE 'EE'
                                        END
                                    ELSE
                                          CASE WHEN BdmBenOption IN ('EE') THEN 'EE'
                                               WHEN BdmBenOption IN ('EECC') THEN 'EE+CHILDREN'
                                               WHEN BdmBenOption IN ('EEC') THEN 'EE+CHILD'
                                               WHEN BdmBenOption IN ('EES') THEN 'EE+SPOUSE'
                                               WHEN BdmBenOption IN ('EEF') THEN 'EE+FAMILY'
                                          END
                                END
        ,drvNumberOfUnits = ''-- leave blank
    INTO dbo.U_ECOBRAQBEX_drvTbl_QBPLAN
    FROM dbo.U_ECOBRAQBEX_drvTbl_QBEVENT WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_ECOBRAQBEX WITH (NOLOCK)
        ON bdmEEID = drveeid
        AND bdmCOID = drvcoid
        AND ISNULL(BdmDepRecID,'') = drvDepRecID
    WHERE BdmIsPQB = 'Y';
    ;

    ---------------------------------
    -- DETAIL RECORD - U_ECOBRAQBEX_drvTbl_QBDEP
    ---------------------------------
    IF OBJECT_ID('U_ECOBRAQBEX_drvTbl_QBDEP','U') IS NOT NULL
        DROP TABLE dbo.U_ECOBRAQBEX_drvTbl_QBDEP;
    SELECT DISTINCT
         drvEEID = drvEEID
        ,drvCoID = drvEEID
        ,drvInitialSort = '21'
        ,drvSubSort     = drvSubSort
        ,drvSubSort2    = '2' + CASE WHEN BdmRelationship IN ('SPS','DP') THEN 'A'
                                     ELSE 'B' + RTRIM(ISNULL(ConSSN,ConNameFirst))
                                END + CONVERT(char(8),ISNULL(ConDateOfBirth,''),112) + ConSystemID
        ,drvSubSort3    = drvSubSort3
        ,drvDepRecID = BdmDepRecID
        -- standard fields above and additional driver fields below
        ,drvRecordIdentifierQBDEP = '[QBDEPENDENT]'
        ,drvSSNQBDEP = ConSSN
        ,drvRelationshipQBDEP = CASE WHEN conrelationship IN ('CHL', 'DA', 'DPC', 'STC') THEN 'CHILD'
                                WHEN conrelationship = 'SPS' THEN 'SPOUSE'
                                WHEN conrelationship = 'DP' THEN 'DOMESTICPARTNER'
                                END
        ,drvSalutationQBDEP = '' -- leave blank
        ,drvFirstNameQBDEP = ConNameFirst
        ,drvMiddleInitialQBDEP = LEFT(ConNameMiddle,1)
        ,drvLastNameQBDEP = ConNameLast
        ,drvEmailQBDEP = '' -- leave blank
        ,drvPhoneQBDEP = '' -- leave blank
        ,drvPhone2QBDEP = '' -- leave blank
        ,drvAddressSameAsQBQBDEP = 'TRUE'
                                --CASE WHEN ConAddressIsDifferent = 'N' OR ConAddressLine1 IS NULL THEN 'TRUE'
        --                              ELSE 'FALSE'
        --                         END
        ,drvAddress1QBDEP = '' -- leave blank
        ,drvAddress2QBDEP = '' -- leave blank
        ,drvCityQBDEP = '' -- leave blank
        ,drvStateOrProvinceQBDEP = '' -- leave blank
        ,drvPostalCodeQBDEP = '' -- leave blank
        ,drvCountryQBDEP = '' --leave blank
        ,drvEnrollmentDateQBDEP = '' --leave blank
        ,drvSexQBDEP = ConGender
        ,drvDOBQBDEP = CONVERT(VARCHAR,ConDateOfBirth,101)
        ,drvIsQMCSOQBDEP = ''
    INTO dbo.U_ECOBRAQBEX_drvTbl_QBDEP
    FROM dbo.U_ECOBRAQBEX_drvTbl_QB WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = drveeid
    JOIN dbo.U_dsi_BDM_ECOBRAQBEX WITH (NOLOCK)
        ON bdmeeid = drveeid 
        AND bdmcoid = drvcoid 
     JOIN dbo.CONTACTS WITH (NOLOCK)
        ON ConEEID = drveeid
        AND ConSystemID = bdmdeprecid
        And ConIsDependent = 'Y'
        WHERE bdmisPQB = 'N';
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ECOBRAQBEX_drvTbl_QBDEPINIT
    ---------------------------------
    IF OBJECT_ID('U_ECOBRAQBEX_drvTbl_QBDEPINIT','U') IS NOT NULL
        DROP TABLE dbo.U_ECOBRAQBEX_drvTbl_QBDEPINIT;
    SELECT DISTINCT
         drvEEID = drveeid
        ,drvCoID = drvcoid
               ,drvInitialSort = '21'
        ,drvSubSort     = drvSubSort
        ,drvSubSort2    = '2' + CASE WHEN BdmRelationship IN ('SPS','DP') THEN 'A'
                                     ELSE 'B' + RTRIM(ISNULL(ConSSN,ConNameFirst))
                                END + CONVERT(char(8),ISNULL(ConDateOfBirth,''),112) + ConSystemID + BdmDedCode
        ,drvSubSort3    = drvSubSort3
        ,drvDepRecID = bdmdeprecid
        -- standard fields above and additional driver fields below
        ,drvRecordIdentifierQBDEPinit = '[QBDEPENDENTPLANINITIAL]'
        ,drvPlanNameQBDEPinit = CASE 
                                WHEN BdmDedCode IN ('MED') THEN 'Blue Shield of CA Access+ Full HMO Medical Plan'
                                WHEN BdmDedCode IN ('HDHP') THEN 'Blue Shield of CA Full PPO HSA Medical Plan'
                                WHEN BdmDedCode IN ('MED2') THEN 'Blue Shield of CA Full PPO Medical Plan'
                                WHEN BdmDedCode IN ('MED1') THEN 'Blue Shield of CA Savenet HMO Medical Plan'
                                WHEN BdmDedCode IN ('FSA' , 'LPFSA') THEN 'Igoe FSA Plan'
                                WHEN BdmDedCode IN ('DNTLS', 'HDNLS') THEN 'Guardian Dental Salary'
                                WHEN BdmDedCode IN ('DEN') THEN 'United Concordia PPO Dental Plan'
                                WHEN BdmDedCode IN ('VIS') THEN 'VSP PPO Vision Plan'
                                /* 2021 Plan names */
                                WHEN BdmDedCode IN ('SL1M1', 'SL2M1', 'SL3M1', 'SL4M1') THEN 'Anthem Vivity HMO'
                                WHEN BdmDedCode IN ('SL1M2', 'SL2M2', 'SL3M2', 'SL4M2') THEN 'Anthem Priority Select HMO'
                                WHEN BdmDedCode IN ('SL1M3', 'SL2M3', 'SL3M3', 'SL4M3') THEN 'Anthem Full Network HMO'
                                WHEN BdmDedCode IN ('SL1M4', 'SL2M4', 'SL3M4', 'SL4M4') THEN 'Anthem PPO HDHP'
                                WHEN BdmDedCode IN ('SL1M5', 'SL2M5', 'SL3M5', 'SL4M5') THEN 'Anthem PPO'
                                WHEN BdmDedCode IN ('FSA', 'LPFSA') THEN 'Igoe FSA Plan'
                                WHEN BdmDedCode IN ('DEN') THEN 'United Concordia PPO Dental Plan'
                                WHEN BdmDedCode IN ('DEN2') THEN 'United Concordia HMO Dental Plan'
                                WHEN BdmDedCode IN ('VIS') THEN 'VSP PPO Vision Plan'
                            END
    INTO dbo.U_ECOBRAQBEX_drvTbl_QBDEPINIT
    FROM dbo.U_ECOBRAQBEX_drvTbl_QBPLAN WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_ECOBRAQBEX WITH (NOLOCK)
        ON bdmeeid = drveeid 
        AND bdmcoid = drvcoid    
    JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = bdmeeid
       AND ConSystemID = BdmDepRecID


        where BdmIsPQB = 'N' 
    ;

    
    -- U_ECOBRAQBEX_drvTbl_QBPLANMBRSPRATE
    ---------------------------------
    -- DETAIL RECORD - U_ECOBRAQBEX_drvTbl_QBPLANMBRSPRATE
    ---------------------------------
      IF OBJECT_ID('U_ECOBRAQBEX_drvTbl_QBPLANMBRSPRATE','U') IS NOT NULL
        DROP TABLE dbo.U_ECOBRAQBEX_drvTbl_QBPLANMBRSPRATE;
    SELECT DISTINCT
         drvEEID = drveeid
        ,drvCoID = drvcoid
        ,drvInitialSort = '21'
        ,drvSubSort     = drvSubSort
        ,drvSubSort2    = '3'
        ,drvSubSort3    = drvSubSort3
        ,drvDepRecID = drvDepRecID
        -- standard fields above and additional driver fields below
        ,drvRecordIdentifierQBPLMBR = '[QBPLANMEMBERRATE]'
        ,drvPlanName = CASE WHEN bdmdedcode IN ('FSA', 'LPFSA') THEN 'Igoe FSA Plan' END
        ,drvRate = CASE WHEN bdmdedcode IN ('FSA', 'LPFSA') THEN CONVERT(VARCHAR,BdmEEGoalAmt /12) END
 INTO dbo.U_ECOBRAQBEX_drvTbl_QBPLANMBRSPRATE
    FROM dbo.U_ECOBRAQBEX_drvTbl_QBPLAN WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = drveeid 
        AND EecCoID = drvcoid
    JOIN dbo.U_dsi_BDM_ECOBRAQBEX WITH (NOLOCK)
         ON BdmEEID = drvEEID
       AND BdmCoID = drvCoID
    JOIN EmpPers WITH (NOLOCK)
        ON eepEEID = drveeid
        WHERE BdmIsPQB = 'Y'
      AND BdmDedType = 'FSA';

    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ECOBRAQBEX_Header_QB','U') IS NOT NULL
        DROP TABLE dbo.U_ECOBRAQBEX_Header_QB;
    SELECT DISTINCT
         drvVersionLineIdentifierQB = '[VERSION]'
        ,drvVersionNumberQB = '1.1'
    INTO dbo.U_ECOBRAQBEX_Header_QB
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN  CONVERT(VARCHAR(8),GETDATE(),112) +'_HighlandsDiversified_QB_37906' + '.txt'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'OE_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE  CONVERT(VARCHAR(8),GETDATE(),112)+'_HighlandsDiversified_QB_37906' + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwECOBRAQBEX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECOBRAQBEX_File (NOLOCK)
   ORDER BY  InitialSort, SubSort , RIGHT(RecordSet,2) ;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ECOBRAQBEX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202005011'
       ,expStartPerControl     = '202005011'
       ,expLastEndPerControl   = '202005279'
       ,expEndPerControl       = '202005279'
WHERE expFormatCode = 'ECOBRAQBEX';
**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwECOBRAQBEX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECOBRAQBEX_File (NOLOCK)
   ORDER BY  InitialSort, SubSort, SubSort2, SubSort3, RecordSet;