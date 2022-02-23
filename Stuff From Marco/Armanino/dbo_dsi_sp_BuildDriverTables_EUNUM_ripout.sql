SET NOCOUNT ON;
IF OBJECT_ID('U_EUNUMARMEX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EUNUMARMEX_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EUNUMARMEX_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EUNUMARMEX' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEUNUMARMEX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEUNUMARMEX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EUNUMARMEX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUNUMARMEX];
GO
IF OBJECT_ID('U_EUNUMARMEX_File') IS NOT NULL DROP TABLE [dbo].[U_EUNUMARMEX_File];
GO
IF OBJECT_ID('U_EUNUMARMEX_EEList') IS NOT NULL DROP TABLE [dbo].[U_EUNUMARMEX_EEList];
GO
IF OBJECT_ID('U_EUNUMARMEX_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EUNUMARMEX_drvTbl];
GO
IF OBJECT_ID('U_EUNUMARMEX_DedList') IS NOT NULL DROP TABLE [dbo].[U_EUNUMARMEX_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EUNUMARMEX') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EUNUMARMEX];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EUNUMARMEX';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EUNUMARMEX';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EUNUMARMEX';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EUNUMARMEX';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EUNUMARMEX';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EUNUMARMEX','UNUM Accident and Hospital Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','EUNUMARMEXZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EUNUMARMEX' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvpartnercaseID"','1','(''UA''=''F'')','EUNUMARMEXZ0','10','D','10','1',NULL,'PartnerCase ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrlrLogonName"','2','(''UA''=''F'')','EUNUMARMEXZ0','25','D','10','2',NULL,'Enroller User Id',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrollLogonType"','3','(''UA''=''F'')','EUNUMARMEXZ0','50','D','10','3',NULL,'Logon Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrollState"','4','(''UA''=''F'')','EUNUMARMEXZ0','2','D','10','4',NULL,'Enrollment State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProductID"','5','(''UA''=''F'')','EUNUMARMEXZ0','3','D','10','5',NULL,'Product Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drveeSSN"','6','(''UA''=''F'')','EUNUMARMEXZ0','11','D','10','6',NULL,'Employee Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drveeNumber"','7','(''UA''=''F'')','EUNUMARMEXZ0','9','D','10','7',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drveeFirstName"','8','(''UA''=''F'')','EUNUMARMEXZ0','25','D','10','8',NULL,'Employee First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drveeLastName"','9','(''UA''=''F'')','EUNUMARMEXZ0','25','D','10','9',NULL,'Employee Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drveeDOB"','10','(''UA''=''F'')','EUNUMARMEXZ0','10','D','10','10',NULL,'Employee Date Of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drveeGender"','11','(''UA''=''F'')','EUNUMARMEXZ0','1','D','10','11',NULL,'Employee Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEligibilityClass"','12','(''UA''=''F'')','EUNUMARMEXZ0','2','D','10','12',NULL,'Eligibility Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLocation"','13','(''UA''=''F'')','EUNUMARMEXZ0','50','D','10','13',NULL,'Location',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddress1"','14','(''UA''=''F'')','EUNUMARMEXZ0','50','D','10','14',NULL,'Address1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddress2"','15','(''UA''=''F'')','EUNUMARMEXZ0','50','D','10','15',NULL,'Address2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','16','(''UA''=''F'')','EUNUMARMEXZ0','50','D','10','16',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','17','(''UA''=''F'')','EUNUMARMEXZ0','2','D','10','17',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZip"','18','(''UA''=''F'')','EUNUMARMEXZ0','10','D','10','18',NULL,'Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfHire"','19','(''UA''=''F'')','EUNUMARMEXZ0','10','D','10','19',NULL,'DateOfHire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateTimestamp"','20','(''UA''=''F'')','EUNUMARMEXZ0','10','D','10','20',NULL,'Date Application signed date/time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNumberOfPayPeriods"','21','(''UA''=''F'')','EUNUMARMEXZ0','2','D','10','21',NULL,'Number of Pay Periods Per Year',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotPayPeriodPremium"','22','(''UA''=''F'')','EUNUMARMEXZ0','6','D','10','22',NULL,'Total Premium (per pay period)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSegment"','23','(''UA''=''F'')','EUNUMARMEXZ0','30','D','10','23',NULL,'Segment',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubdivision"','24','(''UA''=''F'')','EUNUMARMEXZ0','30','D','10','24',NULL,'Subdivision',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageEffectiveDate"','25','(''UA''=''F'')','EUNUMARMEXZ0','10','D','10','25',NULL,'Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvElectType"','26','(''UA''=''F'')','EUNUMARMEXZ0','1','D','10','26',NULL,'Election type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermDate"','27','(''UA''=''F'')','EUNUMARMEXZ0','10','D','10','27',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPCoverage"','28','(''UA''=''F'')','EUNUMARMEXZ0','1','D','10','28',NULL,'Spouse Coverage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCHCoverage"','29','(''UA''=''F'')','EUNUMARMEXZ0','1','D','10','29',NULL,'Child Coverage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drveeSHCB"','30','(''UA''=''F'')','EUNUMARMEXZ0','1','D','10','30',NULL,'Employee Sickness Hospital Confinement Benefit',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drveeRepModUNUMCover"','31','(''UA''=''F'')','EUNUMARMEXZ0','1','D','10','31',NULL,'Employee Replace or modify any existing Unum insur',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPFirstName"','32','(''UA''=''F'')','EUNUMARMEXZ0','25','D','10','32',NULL,'Spouse First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPLastName"','33','(''UA''=''F'')','EUNUMARMEXZ0','25','D','10','33',NULL,'Spouse Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPDOB"','34','(''UA''=''F'')','EUNUMARMEXZ0','10','D','10','34',NULL,'Spouse Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPGender"','35','(''UA''=''F'')','EUNUMARMEXZ0','1','D','10','35',NULL,'Spouse Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvInsrdFirstPrimBenFirstName"','36','(''UA''=''F'')','EUNUMARMEXZ0','50','D','10','36',NULL,'Insured First Primary Beneficiary First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvInrsdFirstPrimBenLastName"','37','(''UA''=''F'')','EUNUMARMEXZ0','50','D','10','37',NULL,'Insured First Primary Beneficiary Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvInsrdFirstPrimBenRelationship"','38','(''UA''=''F'')','EUNUMARMEXZ0','50','D','10','38',NULL,'Insured First Primary Beneficiary Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvInsrdFirstPrimBenSplit"','39','(''UA''=''F'')','EUNUMARMEXZ0','3','D','10','39',NULL,'Insured First Primary Beneficiary Split',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvInsrdSecndPrimBenFirstName"','40','(''UA''=''F'')','EUNUMARMEXZ0','50','D','10','40',NULL,'Insured Second Primary Beneficiary First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvInsrdSecndPrimBenLastName"','41','(''UA''=''F'')','EUNUMARMEXZ0','50','D','10','41',NULL,'Insured Second Primary Beneficiary Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvInsrdSecndPrimBenRelationship"','42','(''UA''=''F'')','EUNUMARMEXZ0','50','D','10','42',NULL,'Insured Second Primary Beneficiary Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvInsrdSecndPrimBenSplit"','43','(''UA''=''F'')','EUNUMARMEXZ0','3','D','10','43',NULL,'Insured Second Primary Beneficiary Split',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvInsrdThirdPrimBenFirstName"','44','(''UA''=''F'')','EUNUMARMEXZ0','50','D','10','44',NULL,'Insured Third Primary Beneficiary First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvInsrdThirdPrimBenLastName"','45','(''UA''=''F'')','EUNUMARMEXZ0','50','D','10','45',NULL,'Insured Third Primary Beneficiary Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvInsrdThirdPrimBenRelationship"','46','(''UA''=''F'')','EUNUMARMEXZ0','50','D','10','46',NULL,'Insured Third Primary Beneficiary Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvInsrdThirdPrimBenSplit"','47','(''UA''=''F'')','EUNUMARMEXZ0','3','D','10','47',NULL,'Insured Third Primary Beneficiary Split',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvInsrdFourthPrimBenFirstName"','48','(''UA''=''F'')','EUNUMARMEXZ0','50','D','10','48',NULL,'Insured Fourth Primary Beneficiary First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvInsrdFourthPrimBenLastName"','49','(''UA''=''F'')','EUNUMARMEXZ0','50','D','10','49',NULL,'Insured Fourth Primary Beneficiary Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvInsrdFourthPrimBenRelationship"','50','(''UA''=''F'')','EUNUMARMEXZ0','50','D','10','50',NULL,'Insured Fourth Primary Beneficiary Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvInsrdFourthPrimBenSplit"','51','(''UA''=''F'')','EUNUMARMEXZ0','3','D','10','51',NULL,'Insured Fourth Primary Beneficiary Split',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EUNUMARMEX_20200716.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'UNUM Accident and Hospital Exp','202007079','EMPEXPORT','ONDEMAND',NULL,'EUNUMARMEX',NULL,NULL,NULL,'202007079','Jul  7 2020 11:08AM','Jul  7 2020 11:08AM','202007071',NULL,'','','202007071',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','202007079','EMPEXPORT','SCH_UNMX',NULL,'EUNUMARMEX',NULL,NULL,NULL,'202007079','Jul  7 2020 11:08AM','Jul  7 2020 11:08AM','202007071',NULL,'','','202007071',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','',NULL,NULL,NULL,NULL,'Test Purposes Only','202007079','EMPEXPORT','TEST',NULL,'EUNUMARMEX',NULL,NULL,NULL,'202007079','Jul  7 2020 11:08AM','Jul  7 2020 11:08AM','202007071',NULL,'','','202007071',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMARMEX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMARMEX','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMARMEX','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMARMEX','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMARMEX','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EUNUMARMEX' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EUNUMARMEX' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EUNUMARMEX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EUNUMARMEX_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUNUMARMEX','D10','dbo.U_EUNUMARMEX_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_EUNUMARMEX') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EUNUMARMEX] (
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
IF OBJECT_ID('U_EUNUMARMEX_DedList') IS NULL
CREATE TABLE [dbo].[U_EUNUMARMEX_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedLongDesc] varchar(40) NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EUNUMARMEX_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EUNUMARMEX_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] char(11) NULL,
    [drvpartnercaseID] varchar(10) NOT NULL,
    [drvEnrlrLogonName] varchar(1) NOT NULL,
    [drvEnrollLogonType] varchar(1) NOT NULL,
    [drvEnrollState] varchar(255) NULL,
    [drvProductID] varchar(3) NULL,
    [drveeSSN] char(11) NULL,
    [drveeNumber] char(9) NULL,
    [drveeFirstName] varchar(100) NULL,
    [drveeLastName] varchar(100) NULL,
    [drveeDOB] datetime NULL,
    [drveeGender] char(1) NULL,
    [drvEligibilityClass] varchar(1) NOT NULL,
    [drvLocation] varchar(1) NOT NULL,
    [drvAddress1] varchar(255) NULL,
    [drvAddress2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZip] varchar(50) NULL,
    [drvDateOfHire] datetime NULL,
    [drvDateTimestamp] varchar(1) NOT NULL,
    [drvNumberOfPayPeriods] int NULL,
    [drvTotPayPeriodPremium] money NULL,
    [drvSegment] varchar(1) NOT NULL,
    [drvSubdivision] varchar(1) NOT NULL,
    [drvCoverageEffectiveDate] datetime NULL,
    [drvElectType] varchar(1) NOT NULL,
    [drvTermDate] datetime NULL,
    [drvSPCoverage] varchar(1) NULL,
    [drvCHCoverage] varchar(1) NULL,
    [drveeSHCB] varchar(1) NOT NULL,
    [drveeRepModUNUMCover] varchar(1) NOT NULL,
    [drvSPFirstName] varchar(100) NULL,
    [drvSPLastName] varchar(100) NULL,
    [drvSPDOB] datetime NULL,
    [drvSPGender] char(1) NULL,
    [drvInsrdFirstPrimBenFirstName] varchar(1) NOT NULL,
    [drvInrsdFirstPrimBenLastName] varchar(1) NOT NULL,
    [drvInsrdFirstPrimBenRelationship] varchar(1) NOT NULL,
    [drvInsrdFirstPrimBenSplit] varchar(1) NOT NULL,
    [drvInsrdSecndPrimBenFirstName] varchar(1) NOT NULL,
    [drvInsrdSecndPrimBenLastName] varchar(1) NOT NULL,
    [drvInsrdSecndPrimBenRelationship] varchar(1) NOT NULL,
    [drvInsrdSecndPrimBenSplit] varchar(1) NOT NULL,
    [drvInsrdThirdPrimBenFirstName] varchar(1) NOT NULL,
    [drvInsrdThirdPrimBenLastName] varchar(1) NOT NULL,
    [drvInsrdThirdPrimBenRelationship] varchar(1) NOT NULL,
    [drvInsrdThirdPrimBenSplit] varchar(1) NOT NULL,
    [drvInsrdFourthPrimBenFirstName] varchar(1) NOT NULL,
    [drvInsrdFourthPrimBenLastName] varchar(1) NOT NULL,
    [drvInsrdFourthPrimBenRelationship] varchar(1) NOT NULL,
    [drvInsrdFourthPrimBenSplit] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EUNUMARMEX_EEList') IS NULL
CREATE TABLE [dbo].[U_EUNUMARMEX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EUNUMARMEX_File') IS NULL
CREATE TABLE [dbo].[U_EUNUMARMEX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUNUMARMEX]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Armanino LLP

Created By: Luis Lugo
Business Analyst: Richard Vars
Create Date: 07/07/2020
Service Request Number: TekP-2019-05-29-0001

Purpose: UNUM Accident and Hospital Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EUNUMARMEX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EUNUMARMEX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EUNUMARMEX';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EUNUMARMEX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EUNUMARMEX' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNUMARMEX', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNUMARMEX', 'TEST';


EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EUNUMARMEX', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EUNUMARMEX';

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
    -- Deduction Code List 
    --========================================== 
    DECLARE @DedList VARCHAR(MAX); 
    SET @DedList = 'ACC,HOSP'; 
 
    IF OBJECT_ID('U_EUNUMARMEX_DedList','U') IS NOT NULL 
        DROP TABLE dbo.U_EUNUMARMEX_DedList; 
    SELECT DedCode = DedDedCode 
        ,DedLongDesc 
        ,DedType = DedDedType 
    INTO dbo.U_EUNUMARMEX_DedList 
    FROM dbo.dsi_BDM_fn_ListToTable(@DedList) 
    JOIN dbo.DedCode WITH (NOLOCK) 
        ON DedDedCode = Item; 
 
    --========================================== 
    -- Clean EE List 
    --========================================== 
 
    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company 
    DELETE FROM dbo.U_EUNUMARMEX_EEList 
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCoID(xEEID) 
    AND xEEID IN (SELECT xEEID FROM dbo.U_EUNUMARMEX_EEList GROUP BY xEEID HAVING COUNT(1) > 1); 
 
    -- Remove Employees that Do Not Have a Benefit Plan in Deduction Code List 
    DELETE FROM dbo.U_EUNUMARMEX_EEList 
    WHERE NOT EXISTS (SELECT 1 FROM dbo.EmpDed JOIN dbo.U_EUNUMARMEX_DedList ON DedCode = EedDeDCode WHERE EedEEID = xEEID); 
 
    --========================================== 
    -- BDM Section 
    --========================================== 
    -- now set values for benefit module 
    DELETE FROM dbo.U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode; 
 
    -- Required parms 
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard'); 
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'DedCodes',@DedList); 
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'StartDateTime',@StartDate); 
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'EndDateTime',@EndDate); 
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'TermSelectionOption', 'AuditDate'); 
 
    -- Non-required parms 
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'IncludeOEDrops','Y'); 
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'OERemoveTermEmps','N'); 
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'GetChangeReason','Y'); 
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS'); 
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL,STC'); 
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP'); 
 
    --Set if OE 
    IF @ExportCode LIKE '%PASSIVE' 
    BEGIN 
         INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'PASSIVE'); 
    END; 
 
    IF @ExportCode LIKE '%ACTIVE' 
    BEGIN 
         INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'ACTIVE'); 
    END; 
 
    EXEC dbo.dsi_bdm_sp_PopulateDeductionsTable @FormatCode; 
 
    --========================================= 
    -- Update BdmChangeReason For Dependents 
    --========================================= 
    UPDATE D 
        SET D.BdmChangeReason = E.BdmChangeReason 
    FROM dbo.U_dsi_bdm_EUNUMARMEX D 
    JOIN dbo.U_dsi_bdm_EUNUMARMEX E 
        ON E.BdmEEID = D.BdmEEID 
        AND E.BdmCOID = D.BdmCOID 
        AND E.BdmDedCode = D.BdmDedCode 
    WHERE D.BdmRecType = 'DEP' AND E.BdmRecType = 'EMP'; 
 
    --===================================================== 
    -- Update BdmUSGField2 with EmpDedTVID for Employees 
    --===================================================== 
    UPDATE dbo.U_dsi_bdm_EUNUMARMEX 
        SET BdmUSGField2 = EedEmpDedTVID 
    FROM dbo.U_dsi_bdm_EUNUMARMEX 
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK) 
        ON EedEEID = BdmEEID 
        AND EedCOID = BdmCOID 
        AND EedDedCode = BdmDedCode 
    WHERE BdmRecType = 'EMP' AND EedFormatCode = @FormatCode AND EedValidForExport = 'Y'; 
 
    --======================================================= 
    -- Update BdmUSGField2 with DepBPlanTVID for Dependents 
    --======================================================= 
    UPDATE dbo.U_dsi_bdm_EUNUMARMEX 
        SET BdmUSGField2 = DbnDepBPlanTVID 
    FROM dbo.U_dsi_bdm_EUNUMARMEX 
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK) 
        ON DbnEEID = BdmEEID 
        AND DbnCOID = BdmCOID 
        AND DbnDedCode = BdmDedCode 
    WHERE BdmRecType = 'DEP' AND DbnFormatCode = @FormatCode AND DbnValidForExport = 'Y'; 
 
    
    --====================================================== 
    -- Update BdmUSGField1 with Benefit Amount (EedBenAmt) 
    --====================================================== 
    UPDATE dbo.U_dsi_bdm_EUNUMARMEX 
        SET BdmUSGField1 = CONVERT(VARCHAR(20),EedBenAmt) 
    FROM dbo.U_dsi_bdm_EUNUMARMEX 
    JOIN dbo.EmpDedFull WITH (NOLOCK) 
        ON EedEmpDedTVID = BdmUSGField2; 

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EUNUMARMEX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EUNUMARMEX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EUNUMARMEX_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EUNUMARMEX_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EUNUMARMEX_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort =  eepSSN
        ,drvpartnercaseID = 'ADP-002066'
        ,drvEnrlrLogonName = ''
        ,drvEnrollLogonType = ''
        ,drvEnrollState = EepAddressState
        ,drvProductID = CASE WHEN bdmdedcode = 'ACC' THEN '815'
                             WHEN bdmdedcode = 'HOSP' THEN '818' END
        ,drveeSSN = eepSSN
        ,drveeNumber = EecEmpNo
        ,drveeFirstName = EepNameFirst
        ,drveeLastName = EepNameLast
        ,drveeDOB = EepDateOfBirth
        ,drveeGender = EepGender
        ,drvEligibilityClass = ''
        ,drvLocation = ''
        ,drvAddress1 = EepAddressLine1
        ,drvAddress2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZip = Eepaddresszipcode
        ,drvDateOfHire = EecDateOfLastHire
        ,drvDateTimestamp = ''
        ,drvNumberOfPayPeriods = EecNumberOfPayments
        ,drvTotPayPeriodPremium = bdmEEAmt
        ,drvSegment = ''
        ,drvSubdivision = ''
        ,drvCoverageEffectiveDate = CASE WHEN bdmdedcode = 'ACC' THEN ACC_BenefitDate
                                    WHEN bdmdedcode = 'HOSP' THEN HOSP_BenefitDate END
        ,drvElectType = '' /*CASE WHEN EmpHDed = '200' THEN 'T'
                             WHEN EmpHDed = '100' THEN 'N'
                             WHEN EmpHDed = '402' THEN 'C' END
                        */
        ,drvTermDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvSPCoverage = CASE WHEN bdmdedcode = 'ACC' THEN 
                                        CASE WHEN Acc_Spouse is not null then 'Y' ELSE 'N' END
                                            
                                    WHEN bdmdedcode = 'HOSP' THEN CASE WHEN HOSP_SPOUSE is not null then 'Y' ELSE 'N' END END
        ,drvCHCoverage =  CASE WHEN bdmdedcode = 'ACC' THEN 
                                        CASE WHEN Acc_chl is not null then 'Y' ELSE 'N' END
                                            
                                    WHEN bdmdedcode = 'HOSP' THEN CASE WHEN Hosp_CHL is not null then 'Y' ELSE 'N' END END
        ,drveeSHCB = ''
        ,drveeRepModUNUMCover = ''
        ,drvSPFirstName = (Select top 1 ConNameFirst from dbo.Contacts where ConSystemId in (ACC_SPOUSE_RecId,HOSP_SPOUSE_RecId))
        ,drvSPLastName =  (Select top 1 ConNameLast from dbo.Contacts where ConSystemId in (ACC_SPOUSE_RecId,HOSP_SPOUSE_RecId))
        ,drvSPDOB =  (Select top 1 ConDateOfBirth from dbo.Contacts where ConSystemId in (ACC_SPOUSE_RecId,HOSP_SPOUSE_RecId))
        ,drvSPGender =  (Select top 1 ConGender from dbo.Contacts where ConSystemId in (ACC_SPOUSE_RecId,HOSP_SPOUSE_RecId))
        ,drvInsrdFirstPrimBenFirstName = ''
        ,drvInrsdFirstPrimBenLastName = ''
        ,drvInsrdFirstPrimBenRelationship = ''
        ,drvInsrdFirstPrimBenSplit = ''
        ,drvInsrdSecndPrimBenFirstName = ''
        ,drvInsrdSecndPrimBenLastName = ''
        ,drvInsrdSecndPrimBenRelationship = ''
        ,drvInsrdSecndPrimBenSplit = ''
        ,drvInsrdThirdPrimBenFirstName = ''
        ,drvInsrdThirdPrimBenLastName = ''
        ,drvInsrdThirdPrimBenRelationship = ''
        ,drvInsrdThirdPrimBenSplit = ''
        ,drvInsrdFourthPrimBenFirstName = ''
        ,drvInsrdFourthPrimBenLastName = ''
        ,drvInsrdFourthPrimBenRelationship = ''
        ,drvInsrdFourthPrimBenSplit = ''
    INTO dbo.U_EUNUMARMEX_drvTbl
    FROM dbo.U_EUNUMARMEX_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN (Select  bdmEEID,bdmcoid, bdmdedcode, max(bdmeeamt) as bdmeeamt
            ,ACC = MAX((CASE WHEN BDMDedCode = 'ACC' and bdmrectype  = 'EMP' then BDMDedCode END))
            ,HOSP = MAX((CASE WHEN BDMDedCode = 'HOSP' then BDMDedCode END))
            ,ACC_SPOUSE = MAX((CASE WHEN BDMDedCode = 'ACC' and bdmrectype  = 'DEP' and bdmRelationship = 'SPS' then BDMDedCode END))
            ,ACC_SPOUSE_RecId = MAX((CASE WHEN BDMDedCode = 'ACC' and bdmrectype  = 'DEP' and bdmRelationship = 'SPS' then bdmdeprecid END))
            ,ACC_CHL = MAX((CASE WHEN BDMDedCode = 'ACC' and bdmrectype  = 'DEP' and bdmRelationship = 'CHL' then BDMDedCode END))
            ,ACC_CHL_RecId = MAX((CASE WHEN BDMDedCode = 'ACC' and bdmrectype  = 'DEP' and bdmRelationship = 'CHL' then bdmdeprecid END))
             ,HOSP_SPOUSE = MAX((CASE WHEN BDMDedCode = 'HOSP' and bdmrectype  = 'DEP' and bdmRelationship = 'SPS' then BDMDedCode END))
            ,HOSP_SPOUSE_RecId = MAX((CASE WHEN BDMDedCode = 'HOSP' and bdmrectype  = 'DEP' and bdmRelationship = 'SPS' then bdmdeprecid END))
            ,HOSP_CHL = MAX((CASE WHEN BDMDedCode = 'HOSP' and bdmrectype  = 'DEP' and bdmRelationship = 'CHL' then BDMDedCode END))
            ,HOSP_CHL_RecId = MAX((CASE WHEN BDMDedCode = 'HOSP' and bdmrectype  = 'DEP' and bdmRelationship = 'CHL' then bdmdeprecid END))
            ,ACC_BenefitDate = MAX((CASE WHEN BDMDedCode = 'ACC' then  bdmbenStartDate END))
            ,HOSP_BenefitDate = MAX((CASE WHEN BDMDedCode = 'HOSP' then  bdmbenStartDate END))
            from dbo.U_dsi_BDM_EUNUMARMEX  group by bdmEEID,bdmcoid,bdmdedcode) as Consolidated
        ON BdmEEID = xEEID 
        and BdmCoid =  xcoid
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
ALTER VIEW dbo.dsi_vwEUNUMARMEX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EUNUMARMEX_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EUNUMARMEX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202006301'
       ,expStartPerControl     = '202006301'
       ,expLastEndPerControl   = '202007079'
       ,expEndPerControl       = '202007079'
WHERE expFormatCode = 'EUNUMARMEX';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEUNUMARMEX_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EUNUMARMEX_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort