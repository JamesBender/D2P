SET NOCOUNT ON;
IF OBJECT_ID('U_ETASHOFQBF_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ETASHOFQBF_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ETASHOFQBF_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ETASHOFQBF' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwETASHOFQBF_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwETASHOFQBF_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ETASHOFQBF') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ETASHOFQBF];
GO
IF OBJECT_ID('U_ETASHOFQBF_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ETASHOFQBF_PEarHist];
GO
IF OBJECT_ID('U_ETASHOFQBF_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ETASHOFQBF_PDedHist];
GO
IF OBJECT_ID('U_ETASHOFQBF_File') IS NOT NULL DROP TABLE [dbo].[U_ETASHOFQBF_File];
GO
IF OBJECT_ID('U_ETASHOFQBF_EEList') IS NOT NULL DROP TABLE [dbo].[U_ETASHOFQBF_EEList];
GO
IF OBJECT_ID('U_ETASHOFQBF_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ETASHOFQBF_drvTbl];
GO
IF OBJECT_ID('U_ETASHOFQBF_DedList') IS NOT NULL DROP TABLE [dbo].[U_ETASHOFQBF_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_ETASHOFQBF') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ETASHOFQBF];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ETASHOFQBF';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ETASHOFQBF';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ETASHOFQBF';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ETASHOFQBF';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ETASHOFQBF';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ETASHOFQBF','TASC Cobra Term  Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','3000','S','N','ETASHOFQBFZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MyTASC Client ID"','1','(''DA''=''T,'')','ETASHOFQBFZ0','50','H','01','1',NULL,'MyTASC Client ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CSA ID"','2','(''DA''=''T,'')','ETASHOFQBFZ0','50','H','01','2',NULL,'CSA ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"QBSSN"','3','(''DA''=''T,'')','ETASHOFQBFZ0','50','H','01','3',NULL,'QBSSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LastName"','4','(''DA''=''T,'')','ETASHOFQBFZ0','50','H','01','4',NULL,'LastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FirstName"','5','(''DA''=''T,'')','ETASHOFQBFZ0','50','H','01','5',NULL,'FirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MiddleInit"','6','(''DA''=''T,'')','ETASHOFQBFZ0','50','H','01','6',NULL,'MiddleInit',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Addr1"','7','(''DA''=''T,'')','ETASHOFQBFZ0','50','H','01','7',NULL,'Addr1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Addr2"','8','(''DA''=''T,'')','ETASHOFQBFZ0','50','H','01','8',NULL,'Addr2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Addr3"','9','(''DA''=''T,'')','ETASHOFQBFZ0','50','H','01','9',NULL,'Addr3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"City"','10','(''DA''=''T,'')','ETASHOFQBFZ0','50','H','01','10',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"State"','11','(''DA''=''T,'')','ETASHOFQBFZ0','50','H','01','11',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Zip"','12','(''DA''=''T,'')','ETASHOFQBFZ0','50','H','01','12',NULL,'Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Country"','13','(''DA''=''T,'')','ETASHOFQBFZ0','50','H','01','13',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AreaCode"','14','(''DA''=''T,'')','ETASHOFQBFZ0','50','H','01','14',NULL,'AreaCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HomePhone"','15','(''DA''=''T,'')','ETASHOFQBFZ0','50','H','01','15',NULL,'HomePhone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"International Phone"','16','(''DA''=''T,'')','ETASHOFQBFZ0','50','H','01','16',NULL,'International Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Gender"','17','(''DA''=''T,'')','ETASHOFQBFZ0','50','H','01','17',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DateofBirth"','18','(''DA''=''T,'')','ETASHOFQBFZ0','50','H','01','18',NULL,'DateofBirth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Smoker"','19','(''DA''=''T,'')','ETASHOFQBFZ0','50','H','01','19',NULL,'Smoker',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SpouseSmoker"','20','(''DA''=''T,'')','ETASHOFQBFZ0','50','H','01','20',NULL,'SpouseSmoker',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SpouseDateOfBirth"','21','(''DA''=''T,'')','ETASHOFQBFZ0','50','H','01','21',NULL,'SpouseDateOfBirth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"QBRelationshipCode"','22','(''DA''=''T,'')','ETASHOFQBFZ0','50','H','01','22',NULL,'QBRelationshipCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EmpSSN"','23','(''DA''=''T,'')','ETASHOFQBFZ0','50','H','01','23',NULL,'EmpSSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EmpLastName"','24','(''DA''=''T,'')','ETASHOFQBFZ0','50','H','01','24',NULL,'EmpLastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EmpFirstName"','25','(''DA''=''T,'')','ETASHOFQBFZ0','50','H','01','25',NULL,'EmpFirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EmpMiddleInit"','26','(''DA''=''T,'')','ETASHOFQBFZ0','50','H','01','26',NULL,'EmpMiddleInit',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EmpHireDate"','27','(''DA''=''T,'')','ETASHOFQBFZ0','50','H','01','27',NULL,'EmpHireDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EmpNumber"','28','(''DA''=''T,'')','ETASHOFQBFZ0','50','H','01','28',NULL,'EmpNumber',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EmpSalary"','29','(''DA''=''T,'')','ETASHOFQBFZ0','50','H','01','29',NULL,'EmpSalary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"QualEventDate"','30','(''DA''=''T,'')','ETASHOFQBFZ0','50','H','01','30',NULL,'QualEventDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"QualEventCode"','31','(''DA''=''T,'')','ETASHOFQBFZ0','50','H','01','31',NULL,'QualEventCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PlanNameCode"','32','(''DA''=''T,'')','ETASHOFQBFZ0','50','H','01','32',NULL,'PlanNameCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"QBTypeCode"','33','(''DA''=''T,'')','ETASHOFQBFZ0','50','H','01','33',NULL,'QBTypeCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CoverageLevelCode"','34','(''DA''=''T,'')','ETASHOFQBFZ0','50','H','01','34',NULL,'CoverageLevelCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CoverageBeginDate"','35','(''DA''=''T,'')','ETASHOFQBFZ0','50','H','01','35',NULL,'CoverageBeginDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CoverageEndDate"','36','(''DA''=''T,'')','ETASHOFQBFZ0','50','H','01','36',NULL,'CoverageEndDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LossOfCoverageDate"','37','(''DA''=''T,'')','ETASHOFQBFZ0','50','H','01','37',NULL,'LossOfCoverageDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LifeVolume"','38','(''DA''=''T,'')','ETASHOFQBFZ0','50','H','01','38',NULL,'LifeVolume',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PremiumAmt"','39','(''DA''=''T,'')','ETASHOFQBFZ0','50','H','01','39',NULL,'PremiumAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PremiumOverrideFlg"','40','(''DA''=''T,'')','ETASHOFQBFZ0','50','H','01','40',NULL,'PremiumOverrideFlg',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ClientDefYN"','41','(''DA''=''T,'')','ETASHOFQBFZ0','50','H','01','41',NULL,'ClientDefYN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ClientDefRange1"','42','(''DA''=''T,'')','ETASHOFQBFZ0','50','H','01','42',NULL,'ClientDefRange1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ClientDefRange2"','43','(''DA''=''T,'')','ETASHOFQBFZ0','50','H','01','43',NULL,'ClientDefRange2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FSAElectionAmt"','44','(''DA''=''T,'')','ETASHOFQBFZ0','50','H','01','44',NULL,'FSAElectionAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FSAYTDCont"','45','(''DA''=''T,'')','ETASHOFQBFZ0','50','H','01','45',NULL,'FSAYTDCont',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FSAYTDClaimPaid"','46','(''DA''=''T,'')','ETASHOFQBFZ0','50','H','01','46',NULL,'FSAYTDClaimPaid',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PensionAccNbr"','47','(''DA''=''T,'')','ETASHOFQBFZ0','50','H','01','47',NULL,'PensionAccNbr',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PensionAmt"','48','(''DA''=''T,'')','ETASHOFQBFZ0','50','H','01','48',NULL,'PensionAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PensionEffectiveDate"','49','(''DA''=''T,'')','ETASHOFQBFZ0','50','H','01','49',NULL,'PensionEffectiveDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WorkState"','50','(''DA''=''T,'')','ETASHOFQBFZ0','50','H','01','50',NULL,'WorkState',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SeveranceAmt"','51','(''DA''=''T,'')','ETASHOFQBFZ0','50','H','01','51',NULL,'SeveranceAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SeveranceStartDate"','52','(''DA''=''T,'')','ETASHOFQBFZ0','50','H','01','52',NULL,'SeveranceStartDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SeveranceEndDate"','53','(''DA''=''T'')','ETASHOFQBFZ0','50','H','01','53',NULL,'SeveranceEndDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMyTASCClientID"','1','(''UA''=''T,'')','ETASHOFQBFZ0','50','D','10','1',NULL,'MyTASC Client ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCSAID"','2','(''UA''=''T,'')','ETASHOFQBFZ0','50','D','10','2',NULL,'CSA ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQBSSN"','3','(''UA''=''T,'')','ETASHOFQBFZ0','50','D','10','3',NULL,'QBSSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastName"','4','(''UA''=''T,'')','ETASHOFQBFZ0','50','D','10','4',NULL,'LastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstName"','5','(''UA''=''T,'')','ETASHOFQBFZ0','50','D','10','5',NULL,'FirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMiddleInit"','6','(''UA''=''T,'')','ETASHOFQBFZ0','50','D','10','6',NULL,'MiddleInit',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddr1"','7','(''UA''=''T,'')','ETASHOFQBFZ0','50','D','10','7',NULL,'Addr1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddr2"','8','(''UA''=''T,'')','ETASHOFQBFZ0','50','D','10','8',NULL,'Addr2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddr3"','9','(''UA''=''T,'')','ETASHOFQBFZ0','50','D','10','9',NULL,'Addr3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','10','(''UA''=''T,'')','ETASHOFQBFZ0','50','D','10','10',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','11','(''UA''=''T,'')','ETASHOFQBFZ0','50','D','10','11',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZip"','12','(''UA''=''T,'')','ETASHOFQBFZ0','50','D','10','12',NULL,'Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountry"','13','(''UA''=''T,'')','ETASHOFQBFZ0','50','D','10','13',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAreaCode"','14','(''UA''=''T,'')','ETASHOFQBFZ0','50','D','10','14',NULL,'AreaCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomePhone"','15','(''UA''=''T,'')','ETASHOFQBFZ0','50','D','10','15',NULL,'HomePhone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvInternationalPhone"','16','(''UA''=''T,'')','ETASHOFQBFZ0','50','D','10','16',NULL,'International Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','17','(''UA''=''T,'')','ETASHOFQBFZ0','50','D','10','17',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofBirth"','18','(''UDMDY''=''T,'')','ETASHOFQBFZ0','50','D','10','18',NULL,'DateofBirth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSmoker"','19','(''UA''=''T,'')','ETASHOFQBFZ0','50','D','10','19',NULL,'Smoker',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseSmoker"','20','(''UA''=''T,'')','ETASHOFQBFZ0','50','D','10','20',NULL,'SpouseSmoker',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseDateOfBirth"','21','(''UDMDY''=''T,'')','ETASHOFQBFZ0','50','D','10','21',NULL,'SpouseDateOfBirth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQBRelationshipCode"','22','(''UA''=''T,'')','ETASHOFQBFZ0','50','D','10','22',NULL,'QBRelationshipCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpSSN"','23','(''UA''=''T,'')','ETASHOFQBFZ0','50','D','10','23',NULL,'EmpSSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpLastName"','24','(''UA''=''T,'')','ETASHOFQBFZ0','50','D','10','24',NULL,'EmpLastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpFirstName"','25','(''UA''=''T,'')','ETASHOFQBFZ0','50','D','10','25',NULL,'EmpFirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpMiddleInit"','26','(''UA''=''T,'')','ETASHOFQBFZ0','50','D','10','26',NULL,'EmpMiddleInit',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpHireDate"','27','(''UDMDY''=''T,'')','ETASHOFQBFZ0','50','D','10','27',NULL,'EmpHireDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpNumber"','28','(''UA''=''T,'')','ETASHOFQBFZ0','50','D','10','28',NULL,'EmpNumber',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpSalary"','29','(''UA''=''T,'')','ETASHOFQBFZ0','50','D','10','29',NULL,'EmpSalary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQualEventDate"','30','(''UDMDY''=''T,'')','ETASHOFQBFZ0','50','D','10','30',NULL,'QualEventDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQualEventCode"','31','(''UA''=''T,'')','ETASHOFQBFZ0','50','D','10','31',NULL,'QualEventCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanNameCode"','32','(''UA''=''T,'')','ETASHOFQBFZ0','50','D','10','32',NULL,'PlanNameCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQBTypeCode"','33','(''UA''=''T,'')','ETASHOFQBFZ0','50','D','10','33',NULL,'QBTypeCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageLevelCode"','34','(''UA''=''T,'')','ETASHOFQBFZ0','50','D','10','34',NULL,'CoverageLevelCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageBeginDate"','35','(''UDMDY''=''T,'')','ETASHOFQBFZ0','50','D','10','35',NULL,'CoverageBeginDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageEndDate"','36','(''UDMDY''=''T,'')','ETASHOFQBFZ0','50','D','10','36',NULL,'CoverageEndDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLossOfCoverageDate"','37','(''UDMDY''=''T,'')','ETASHOFQBFZ0','50','D','10','37',NULL,'LossOfCoverageDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLifeVolume"','38','(''UA''=''T,'')','ETASHOFQBFZ0','50','D','10','38',NULL,'LifeVolume',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPremiumAmt"','39','(''UA''=''T,'')','ETASHOFQBFZ0','50','D','10','39',NULL,'PremiumAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPremiumOverrideFlg"','40','(''UA''=''T,'')','ETASHOFQBFZ0','50','D','10','40',NULL,'PremiumOverrideFlg',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientDefYN"','41','(''UA''=''T,'')','ETASHOFQBFZ0','50','D','10','41',NULL,'ClientDefYN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientDefRange1"','42','(''UA''=''T,'')','ETASHOFQBFZ0','50','D','10','42',NULL,'ClientDefRange1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientDefRange2"','43','(''UA''=''T,'')','ETASHOFQBFZ0','50','D','10','43',NULL,'ClientDefRange2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFSAElectionAmt"','44','(''UA''=''T,'')','ETASHOFQBFZ0','50','D','10','44',NULL,'FSAElectionAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFSAYTDCont"','45','(''UA''=''T,'')','ETASHOFQBFZ0','50','D','10','45',NULL,'FSAYTDCont',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFSAYTDClaimPaid"','46','(''UA''=''T,'')','ETASHOFQBFZ0','50','D','10','46',NULL,'FSAYTDClaimPaid',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPensionAccNbr"','47','(''UA''=''T,'')','ETASHOFQBFZ0','50','D','10','47',NULL,'PensionAccNbr',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPensionAmt"','48','(''UA''=''T,'')','ETASHOFQBFZ0','50','D','10','48',NULL,'PensionAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPensionEffectiveDate"','49','(''UDMDY''=''T,'')','ETASHOFQBFZ0','50','D','10','49',NULL,'PensionEffectiveDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkState"','50','(''UA''=''T,'')','ETASHOFQBFZ0','50','D','10','50',NULL,'WorkState',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSeveranceAmt"','51','(''UA''=''T,'')','ETASHOFQBFZ0','50','D','10','51',NULL,'SeveranceAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSeveranceStartDate"','52','(''UDMDY''=''T,'')','ETASHOFQBFZ0','50','D','10','52',NULL,'SeveranceStartDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSeveranceEndDate"','53','(''UDMDY''=''T'')','ETASHOFQBFZ0','50','D','10','53',NULL,'SeveranceEndDate',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ETASHOFQBF_20200902.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'TASC Cobra Term  Export','202007209','EMPEXPORT','ONDEMAND',NULL,'ETASHOFQBF',NULL,NULL,NULL,'202007209','Jul 20 2020  4:49PM','Jul 20 2020  4:49PM','202007201',NULL,'','','202007201',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ETASHOFQBF_20200902.txt',NULL,'Null','N',',OFPDO',NULL,NULL,NULL,'Scheduled Session','202008059','EMPEXPORT','SCH_TACB',NULL,'ETASHOFQBF',NULL,NULL,NULL,'202008319','Jul 20 2020  4:49PM','Jul 20 2020  4:49PM','202008241',NULL,'','','202008051',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ETASHOFQBF_20200902.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202007209','EMPEXPORT','OEACTIVE',NULL,'ETASHOFQBF',NULL,NULL,NULL,'202007209','Jul 20 2020  4:49PM','Jul 20 2020  4:49PM','202007201',NULL,'','','202007201',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ETASHOFQBF_20200902.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202007209','EMPEXPORT','OEPASSIVE',NULL,'ETASHOFQBF',NULL,NULL,NULL,'202007209','Jul 20 2020  4:49PM','Jul 20 2020  4:49PM','202007201',NULL,'','','202007201',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ETASHOFQBF_20200902.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202008031','EMPEXPORT','TEST','Aug  5 2020  9:49AM','ETASHOFQBF',NULL,NULL,NULL,'202008031','Aug  3 2020 12:00AM','Dec 30 1899 12:00AM','202007211','35','','','202007211',dbo.fn_GetTimedKey(),NULL,'us3cPeHOF1002',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_ETASHOFQBF_20200902.txt' END WHERE expFormatCode = 'ETASHOFQBF';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETASHOFQBF','drvInitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETASHOFQBF','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETASHOFQBF','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETASHOFQBF','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETASHOFQBF','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'ETASHOFQBF' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ETASHOFQBF' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_ETASHOFQBF_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ETASHOFQBF_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ETASHOFQBF','H01','NONE',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ETASHOFQBF','D10','dbo.U_ETASHOFQBF_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_ETASHOFQBF') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ETASHOFQBF] (
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
IF OBJECT_ID('U_ETASHOFQBF_DedList') IS NULL
CREATE TABLE [dbo].[U_ETASHOFQBF_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ETASHOFQBF_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ETASHOFQBF_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvMyTASCClientID] varchar(14) NOT NULL,
    [drvCSAID] varchar(5) NOT NULL,
    [drvQBSSN] char(11) NULL,
    [drvLastName] varchar(100) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleInit] varchar(1) NULL,
    [drvAddr1] nvarchar(258) NULL,
    [drvAddr2] nvarchar(258) NULL,
    [drvAddr3] varchar(1) NOT NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZip] varchar(50) NULL,
    [drvCountry] char(3) NULL,
    [drvAreaCode] varchar(3) NULL,
    [drvHomePhone] varchar(7) NULL,
    [drvInternationalPhone] varchar(1) NOT NULL,
    [drvGender] char(1) NULL,
    [drvDateofBirth] datetime NULL,
    [drvSmoker] varchar(1) NOT NULL,
    [drvSpouseSmoker] varchar(1) NOT NULL,
    [drvSpouseDateOfBirth] datetime NULL,
    [drvQBRelationshipCode] varchar(8) NULL,
    [drvEmpSSN] char(11) NULL,
    [drvEmpLastName] varchar(100) NULL,
    [drvEmpFirstName] varchar(100) NULL,
    [drvEmpMiddleInit] varchar(1) NULL,
    [drvEmpHireDate] datetime NULL,
    [drvEmpNumber] char(9) NULL,
    [drvEmpSalary] varchar(8000) NULL,
    [drvQualEventDate] datetime NULL,
    [drvQualEventCode] varchar(6) NULL,
    [drvPlanNameCode] varchar(7) NULL,
    [drvQBTypeCode] varchar(5) NOT NULL,
    [drvCoverageLevelCode] varchar(9) NULL,
    [drvCoverageBeginDate] datetime NULL,
    [drvCoverageEndDate] varchar(1) NOT NULL,
    [drvLossOfCoverageDate] datetime NULL,
    [drvLifeVolume] varchar(1) NOT NULL,
    [drvPremiumAmt] varchar(1) NOT NULL,
    [drvPremiumOverrideFlg] varchar(1) NOT NULL,
    [drvClientDefYN] varchar(1) NOT NULL,
    [drvClientDefRange1] varchar(1) NOT NULL,
    [drvClientDefRange2] varchar(1) NOT NULL,
    [drvFSAElectionAmt] varchar(8000) NULL,
    [drvFSAYTDCont] varchar(8000) NULL,
    [drvFSAYTDClaimPaid] varchar(1) NOT NULL,
    [drvPensionAccNbr] varchar(1) NOT NULL,
    [drvPensionAmt] varchar(1) NOT NULL,
    [drvPensionEffectiveDate] varchar(1) NOT NULL,
    [drvWorkState] varchar(1) NOT NULL,
    [drvSeveranceAmt] varchar(1) NOT NULL,
    [drvSeveranceStartDate] varchar(1) NOT NULL,
    [drvSeveranceEndDate] varchar(1) NOT NULL,
    [drvdedcode] char(5) NULL
);
IF OBJECT_ID('U_ETASHOFQBF_EEList') IS NULL
CREATE TABLE [dbo].[U_ETASHOFQBF_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ETASHOFQBF_File') IS NULL
CREATE TABLE [dbo].[U_ETASHOFQBF_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);
IF OBJECT_ID('U_ETASHOFQBF_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ETASHOFQBF_PDedHist] (
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
IF OBJECT_ID('U_ETASHOFQBF_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ETASHOFQBF_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ETASHOFQBF]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Hoffmaster Group, Inc

Created By: Marco Lagrosa
Business Analyst: Cheryl Petitti
Create Date: 07/20/2020
Service Request Number: TekP-2019-06-29-0004

Purpose: TASC Cobra Term  Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ETASHOFQBF';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ETASHOFQBF';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ETASHOFQBF';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ETASHOFQBF';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ETASHOFQBF' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETASHOFQBF', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETASHOFQBF', 'TEST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETASHOFQBF', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETASHOFQBF', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETASHOFQBF', 'SCHEDULED';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ETASHOFQBF';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ETASHOFQBF', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ETASHOFQBF';

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
    DELETE FROM dbo.U_ETASHOFQBF_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ETASHOFQBF_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'FSALD, FSA, DEN, DENOC, DENOK, MOKH, MRHSA, MRPPO, MOKP, VIS, MHH, MOCH, MCCH, MCVH, MHP, MCCP, MCVP';

    IF OBJECT_ID('U_ETASHOFQBF_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ETASHOFQBF_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ETASHOFQBF_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DedList);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

    -- Non-Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'CobraPQBMulti', '1')
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'GetChangeReason','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CountDependents','Y');
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','X'); -- DedIsCobraCovered = 'Y'
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'CobraReasonsEmp', '208,210,200 ,201 ,202 ,203 ,204 ,205 ,206 ,207 ,209 ,LEVNT1,LEVNT2,LEVNT3,LEVNT4,LEVNT5,CHGSTA')
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'CobraReasonsDep', '208,210,200 ,201 ,202 ,203 ,204 ,205 ,206 ,207 ,209 ,LEVNT1,LEVNT2,LEVNT3,LEVNT4,LEVNT5,CHGSTA')
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraType','4'); -- Eep/ConCobraReason first, then EdhChangeReason. Include CHGRP for elig. ben groups
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraDate','3'); -- EedBenStopDate and DbnBenStopDate, unless Eep/ConDateOfCOBRAEvent exists
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraPQBType','1'); -- If no EE or spouse, ALL children are PQB (not just oldest)
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraReasonsDepPQB','201,204,210,LEVNT3,LEVNT4'); -- Valid dependent PQB reasons
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidCobraReasonsEmp','201,204,210,LEVNT3,LEVNT4'); -- Invalidate employee when Cobra Reason is a dependent PQB reason
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidTermReasonsEmp','203'); -- Invalidate employee when Cobra Reason is "Death"
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'ConCobraReasonPCF','DependentCOBRAReason'); -- Valid dependent PQB reasons
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CountDependents','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL,DPC,STC,DCH');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP');

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
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_ETASHOFQBF_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ETASHOFQBF_PDedHist;
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
    INTO dbo.U_ETASHOFQBF_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ETASHOFQBF_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    and PdhDedcode IN ('FSA','FSALD')
    --AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );


    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_ETASHOFQBF_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ETASHOFQBF_PEarHist;
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
    INTO dbo.U_ETASHOFQBF_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ETASHOFQBF_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ETASHOFQBF_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ETASHOFQBF_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = bdmdeprecid--DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvInitialSort  = eepSSN
        ,drvMyTASCClientID = '4319-5964-5807'
        ,drvCSAID = '43483'
        ,drvQBSSN = CASE WHEN bdmrectype = 'EMP' THEN eepSSN ELSE ConSSN END
        ,drvLastName = CASE WHEN bdmrectype = 'EMP' THEN EepNameLast ELSE conNameLast END
        ,drvFirstName = CASE WHEN bdmrectype = 'EMP' THEN  EepNameFirst ELSE ConNameFirst END
        ,drvMiddleInit = CASE WHEN bdmrectype = 'EMP' THEN  LEFT(ISNULL(EepNameMiddle,''),1) ELSE LEFT(ISNULL(ConNameMiddle,''),1) END
        ,drvAddr1 = QuoteName(CASE WHEN bdmrectype = 'EMP' THEN  EepAddressLine1 ELSE ConAddressLine1 End,'"')
        ,drvAddr2 = QuoteName(CASE WHEN bdmrectype = 'EMP' THEN  EepAddressLine2 ELSE ConAddressLine2 End,'"')
        ,drvAddr3 = ''
        ,drvCity = CASE WHEN bdmrectype = 'EMP' THEN  EepAddressCity ELSE ConAddressCity END
        ,drvState =  CASE WHEN bdmrectype = 'EMP' THEN  EepAddressState ELSE ConAddressState END
        ,drvZip = CASE WHEN bdmrectype = 'EMP' THEN   EepAddressZipCode ELSE COnAddressZipCode END
        ,drvCountry = CASE WHEN bdmrectype = 'EMP' THEN EepAddressCountry ELSE ConAddressCountry END
        ,drvAreaCode = CASE WHEN bdmrectype = 'EMP' THEN  Substring(EepPhoneHomeNumber,1,3)
                            ELSE    Substring(ConPhoneHomeNumber,1,3)
                        END
        ,drvHomePhone = CASE WHEN bdmrectype = 'EMP' THEN  Substring(EepPhoneHomeNumber,4,7)
                            ELSE    Substring(ConPhoneHomeNumber,4,7)
                        END
        ,drvInternationalPhone = ''
        ,drvGender = CASE WHEN bdmrectype = 'EMP'  THEN EepGender ELSE COnGender END
        ,drvDateofBirth = CASE WHEN bdmrectype = 'EMP'  THEN  EepDateOfBirth ELSE ConDateOfBirth END
        ,drvSmoker = ''
        ,drvSpouseSmoker = ''
        ,drvSpouseDateOfBirth = CASE WHEN bdmRelationship = 'SPS' THEN ConDateOfBirth END
        ,drvQBRelationshipCode = CASE WHEN BdmRecType = 'EMP' THEN 'SELF'
                                        ELSE
                                            CASE WHEN BdmRelationShip = 'SPS' THEN 'SPOUSE'
                                                 WHEN BdmRelationShip = 'DP' THEN 'DOMPART'
                                                 WHEN BdmRelationShip IN ('CHL','STC')  THEN 'CHILD'
                                                 WHEN BdmRelationShip = 'DPC' THEN 'DOMCH'
                                                 WHEN BdmRelationShip = 'DSC' THEN 'HANDICAP'

                                            END
                                END

        ,drvEmpSSN = eepSSN
        ,drvEmpLastName = EepNameLast
        ,drvEmpFirstName = EepNameFirst
        ,drvEmpMiddleInit = LEFT(EepNameMiddle,1)
        ,drvEmpHireDate = EecDateOfLastHire
        ,drvEmpNumber = EecEmpNo
        ,drvEmpSalary = REPLACE(CAST(EecAnnSalary as varchar(12)),'.','')
        ,drvQualEventDate = CASE WHEN bdmChangeReason IN ('LEVNT4', '204', '210', '201') THEN bdmBenStatusDate 
                            else  bdmDateOfCobraEvent
                            END
        ,drvQualEventCode = CASE WHEN bdmChangeReason IN ('204', 'LEVNT4') or bdmCobraReason IN ('204', 'LEVNT4')  THEN  'DIV' 
                                 WHEN (bdmChangeReason  = '208' or bdmCobraReason = '208')  or (EecEmplStatus = 'T' and RTRIM(EecTermReason) IN('202','NORET')) THEN 'RETIRE'
                                 WHEN EecEmplStatus = 'T' and EecTermReason  = '203' THEN 'DEATH' 
                                 WHEN bdmChangeReason IN('201' , 'LEVNT3') or bdmCobraReason IN('201' , 'LEVNT3')  THEN 'CLOSS'
                                 WHEN  EecEmplStatus = 'T'  and EecTermReason  not in ('202' , '203') THEN  'TERM'
                                 WHEN bdmChangeReason IN( '203', '202') or bdmCobraReason IN( '203', '202') THEN  'REDUCE'
                            END
        ,drvPlanNameCode = CASE
                                        WHEN  BdmDedcode IN ('DEN', 'DENOC', 'DENOK') THEN 'DDD'
                                WHEN  BdmDedcode IN ('MOKH', 'MRHSA') THEN 'MUCHSAH'
                                WHEN  BdmDedcode IN ('MRPPO', 'MOKP') THEN 'MUPPOH'
                                WHEN  BdmDedcode IN ('MHH', 'MOCH', 'MCCH', 'MCVH') THEN 'MHUSA'
                                WHEN  BdmDedcode IN ('MHP', 'MCCP', 'MCVP') THEN 'MUPPO'
                                WHEN  BdmDedcode IN ('VIS') THEN 'VISUP'

                                WHEN  BdmDedcode IN ('FSA', 'FSALD') THEN 'UFSA'
                            END 

        ,drvQBTypeCode = 'COBRA'
        ,drvCoverageLevelCode = CASE WHEN BdmBenOption = 'EE' THEN 'SINGLE'
                                    WHEN  BdmBenOption IN('EES', 'EEDP', 'EEC', 'EE1') THEN 'SINGLE+1'
                                    WHEN BdmBenOption IN('EEF', 'EEDPF', 'EE2', 'EECH') THEN 'FAMILY'
                                    WHEN  bdmDedCode IN ('FSA', 'FSALD') THEN  'COMPOSITE'
                                END
        ,drvCoverageBeginDate = CASE WHEN BdmCobraReason IN ('LEVNT4', '204', '210', '201') THEN DateAdd(day,1,bdmBenStatusDate)
                            else  DateAdd(day,1,bdmDateOfCobraEvent)
                            END
        ,drvCoverageEndDate = ''
        ,drvLossOfCoverageDate = CASE WHEN EecEmplStatus = 'T' THEN eecdateoftermination ELSE bdmbenstopdate END
        ,drvLifeVolume = ''
        ,drvPremiumAmt = ''
        ,drvPremiumOverrideFlg = ''
        ,drvClientDefYN = ''
        ,drvClientDefRange1 = ''
        ,drvClientDefRange2 = ''
        ,drvFSAElectionAmt = CASE WHEN BdmDedcode IN('FSA', 'FSALD') THEN REPLACE(CAST(bdmEEGoalAmt as varchar(12)),'.','')END
        ,drvFSAYTDCont =  CASE WHEN BdmDedcode IN('FSA', 'FSALD') THEN  REPLACE(CAST(PdhEECurAmtYTD as varchar(12)),'.','') END
        ,drvFSAYTDClaimPaid = ''
        ,drvPensionAccNbr = ''
        ,drvPensionAmt = ''
        ,drvPensionEffectiveDate = ''
        ,drvWorkState = ''
        ,drvSeveranceAmt = ''
        ,drvSeveranceStartDate = ''
        ,drvSeveranceEndDate = ''
        ,drvdedcode = BdmDedcode
    INTO dbo.U_ETASHOFQBF_drvTbl
    FROM dbo.U_ETASHOFQBF_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ETASHOFQBF WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
    ON ConEEID = xEEID
    AND ConSystemID = BdmDepRecID
    LEFT JOIN dbo.U_ETASHOFQBF_PDedHist WITH (NOLOCK)
    on pdheeid = xeeid
    --WHERE bdmIsPQB = 'Y'
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE '%TEST%' THEN 'Test_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'OE_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwETASHOFQBF_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ETASHOFQBF_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ETASHOFQBF%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202007131'
       ,expStartPerControl     = '202007131'
       ,expLastEndPerControl   = '202007209'
       ,expEndPerControl       = '202007209'
WHERE expFormatCode = 'ETASHOFQBF';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwETASHOFQBF_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ETASHOFQBF_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort