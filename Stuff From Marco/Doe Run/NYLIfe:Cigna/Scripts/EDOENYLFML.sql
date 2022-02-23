SET NOCOUNT ON;
IF OBJECT_ID('U_EDOENYLFML_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EDOENYLFML_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EDOENYLFML_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EDOENYLFML' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEDOENYLFML_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEDOENYLFML_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EDOENYLFML') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EDOENYLFML];
GO
IF OBJECT_ID('U_EDOENYLFML_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EDOENYLFML_Trailer];
GO
IF OBJECT_ID('U_EDOENYLFML_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EDOENYLFML_PEarHist];
GO
IF OBJECT_ID('U_EDOENYLFML_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EDOENYLFML_PDedHist];
GO
IF OBJECT_ID('U_EDOENYLFML_Header') IS NOT NULL DROP TABLE [dbo].[U_EDOENYLFML_Header];
GO
IF OBJECT_ID('U_EDOENYLFML_File') IS NOT NULL DROP TABLE [dbo].[U_EDOENYLFML_File];
GO
IF OBJECT_ID('U_EDOENYLFML_EEList') IS NOT NULL DROP TABLE [dbo].[U_EDOENYLFML_EEList];
GO
IF OBJECT_ID('U_EDOENYLFML_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EDOENYLFML_drvTbl];
GO
IF OBJECT_ID('U_EDOENYLFML_DedList') IS NOT NULL DROP TABLE [dbo].[U_EDOENYLFML_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EDOENYLFML') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EDOENYLFML];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EDOENYLFML';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EDOENYLFML';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EDOENYLFML';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EDOENYLFML';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EDOENYLFML';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EDOENYLFML','NYLife FMLA Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','3000','S','N','EDOENYLFMLZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EDOENYLFML' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFileRecordIdentifier"','1','(''UA''=''F'')','EDOENYLFMLZ0','2','H','01','1',NULL,'drvFileRecordIdentifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDUNSNumber"','2','(''UA''=''F'')','EDOENYLFMLZ0','15','H','01','2',NULL,'drvDUNSNumber',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProductionTestIndicator"','3','(''UA''=''F'')','EDOENYLFMLZ0','1','H','01','3',NULL,'drvProductionTestIndicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFileCreationDate"','4','(''UD112''=''F'')','EDOENYLFMLZ0','8','H','01','4',NULL,'drvFileCreationDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerName"','5','(''UA''=''F'')','EDOENYLFMLZ0','35','H','01','5',NULL,'drvEmployerName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFileType"','6','(''UA''=''F'')','EDOENYLFMLZ0','1','H','01','6',NULL,'drvFileType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLifeAccidentFileMaintenanceReasonType"','7','(''UA''=''F'')','EDOENYLFMLZ0','2','H','01','7',NULL,'drvLife&AccidentFileMaintenanceReasonType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDisabilityFileMaintenanceReasonType"','8','(''UA''=''F'')','EDOENYLFMLZ0','1','H','01','8',NULL,'drvDisabilityFileMaintenanceReasonType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReserved"','9','(''UA''=''F'')','EDOENYLFMLZ0','2935','H','01','9',NULL,'drvReserved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeSSN"','1','(''UA''=''F'')','EDOENYLFMLZ0','9','D','10','1',NULL,'drvEmployeeSSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeIdentificationNumber"','2','(''UA''=''F'')','EDOENYLFMLZ0','11','D','10','2',NULL,'drvEmployeeIdentificationNumber',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReserved_Emp"','3','(''UA''=''F'')','EDOENYLFMLZ0','10','D','10','3',NULL,'drvReserved_Emp',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEligibilityBillingLocation"','4','(''UA''=''F'')','EDOENYLFMLZ0','4','D','10','4',NULL,'drvEligibilityBillingLocation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNewYorkLifeInternalCompanyNumber"','5','(''UA''=''F'')','EDOENYLFMLZ0','9','D','10','5',NULL,'drvNewYorkLifeInternalCompanyNumber',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeGroupNumberID"','6','(''UA''=''F'')','EDOENYLFMLZ0','9','D','10','6',NULL,'drvEmployeeGroupNumberID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeClassCode"','7','(''UA''=''F'')','EDOENYLFMLZ0','3','D','10','7',NULL,'drvEmployeeClassCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClassChangeEffectiveDate"','8','(''UA''=''F'')','EDOENYLFMLZ0','8','D','10','8',NULL,'drvClassChangeEffectiveDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReserved_Emp2"','9','(''UA''=''F'')','EDOENYLFMLZ0','10','D','10','9',NULL,'drvReserved_Emp2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeLastName"','10','(''UA''=''F'')','EDOENYLFMLZ0','35','D','10','10',NULL,'drvEmployeeLastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeFirstName"','11','(''UA''=''F'')','EDOENYLFMLZ0','25','D','10','11',NULL,'drvEmployeeFirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeMiddleName"','12','(''UA''=''F'')','EDOENYLFMLZ0','15','D','10','12',NULL,'drvEmployeeMiddleName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeNamePrefix"','13','(''UA''=''F'')','EDOENYLFMLZ0','10','D','10','13',NULL,'drvEmployeeNamePrefix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeNameSuffix"','14','(''UA''=''F'')','EDOENYLFMLZ0','10','D','10','14',NULL,'drvEmployeeNameSuffix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeDateofBirth"','15','(''UD112''=''F'')','EDOENYLFMLZ0','8','D','10','15',NULL,'drvEmployeeDateofBirth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeGender"','16','(''UA''=''F'')','EDOENYLFMLZ0','1','D','10','16',NULL,'drvEmployeeGender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeMaritalStatus"','17','(''UA''=''F'')','EDOENYLFMLZ0','1','D','10','17',NULL,'drvEmployeeMaritalStatus',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeesPINNumber"','18','(''UA''=''F'')','EDOENYLFMLZ0','4','D','10','18',NULL,'drvEmployeesPINNumber',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeSmokerStatus"','19','(''UA''=''F'')','EDOENYLFMLZ0','1','D','10','19',NULL,'drvEmployeeSmokerStatus',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeEmailAddress"','20','(''UA''=''F'')','EDOENYLFMLZ0','34','D','10','20',NULL,'drvEmployeeEmailAddress',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReserved_Emp3"','21','(''UA''=''F'')','EDOENYLFMLZ0','1','D','10','21',NULL,'drvReserved_Emp3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSupplementalEmailAddress1"','22','(''UA''=''F'')','EDOENYLFMLZ0','34','D','10','22',NULL,'drvSupplementalEmailAddress1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmail1Type"','23','(''UA''=''F'')','EDOENYLFMLZ0','1','D','10','23',NULL,'drvEmail1Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSupplementalEmailAddress2"','24','(''UA''=''F'')','EDOENYLFMLZ0','34','D','10','24',NULL,'drvSupplementalEmailAddress2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmail2Type"','25','(''UA''=''F'')','EDOENYLFMLZ0','1','D','10','25',NULL,'drvEmail2Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeMailAddress1"','26','(''UA''=''F'')','EDOENYLFMLZ0','35','D','10','26',NULL,'drvEmployeeMailAddress1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeMailAddress2"','27','(''UA''=''F'')','EDOENYLFMLZ0','35','D','10','27',NULL,'drvEmployeeMailAddress2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeMailCity"','28','(''UA''=''F'')','EDOENYLFMLZ0','30','D','10','28',NULL,'drvEmployeeMailCity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeMailState"','29','(''UA''=''F'')','EDOENYLFMLZ0','2','D','10','29',NULL,'drvEmployeeMailState',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeMailZipCode"','30','(''UA''=''F'')','EDOENYLFMLZ0','10','D','10','30',NULL,'drvEmployeeMailZipCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeCountry"','31','(''UA''=''F'')','EDOENYLFMLZ0','30','D','10','31',NULL,'drvEmployeeCountry',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountryCode"','32','(''UA''=''F'')','EDOENYLFMLZ0','2','D','10','32',NULL,'drvCountryCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeResidenceState"','33','(''UA''=''F'')','EDOENYLFMLZ0','2','D','10','33',NULL,'drvEmployeeResidenceState',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProvince"','34','(''UA''=''F'')','EDOENYLFMLZ0','3','D','10','34',NULL,'drvProvince',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTypeofAddress"','35','(''UA''=''F'')','EDOENYLFMLZ0','1','D','10','35',NULL,'drvTypeofAddress',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffectiveDateoftheAddress"','36','(''UD112''=''F'')','EDOENYLFMLZ0','8','D','10','36',NULL,'drvEffectiveDateoftheAddress',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneNumber"','37','(''UA''=''F'')','EDOENYLFMLZ0','20','D','10','37',NULL,'drvPhoneNumber',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneUsagecode"','38','(''UA''=''F'')','EDOENYLFMLZ0','1','D','10','38',NULL,'drvPhoneUsagecode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReserved_Emp4"','39','(''UA''=''F'')','EDOENYLFMLZ0','45','D','10','39',NULL,'drvReserved_Emp4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReserved_Emp5"','40','(''UA''=''F'')','EDOENYLFMLZ0','2','D','10','40',NULL,'drvReserved_Emp5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmploymentStatusCode"','41','(''UA''=''F'')','EDOENYLFMLZ0','2','D','10','41',NULL,'drvEmploymentStatusCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeStatusEffectiveDate"','42','(''UD112''=''F'')','EDOENYLFMLZ0','8','D','10','42',NULL,'drvEmployeeStatusEffectiveDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeType"','43','(''UA''=''F'')','EDOENYLFMLZ0','1','D','10','43',NULL,'drvEmployeeType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeDateofHire"','44','(''UD112''=''F'')','EDOENYLFMLZ0','8','D','10','44',NULL,'drvEmployeeDateofHire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdjustedServiceDate"','45','(''UD112''=''F'')','EDOENYLFMLZ0','8','D','10','45',NULL,'drvAdjustedServiceDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeWorksiteLocation"','46','(''UA''=''F'')','EDOENYLFMLZ0','20','D','10','46',NULL,'drvEmployeeWorksiteLocation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeAnnualSalaryforLifeBenefit"','47','(''UA''=''F'')','EDOENYLFMLZ0','9','D','10','47',NULL,'drvEmployeeAnnualSalaryforLifeBenefit',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvModeForDisabilityEarnings"','48','(''UA''=''F'')','EDOENYLFMLZ0','1','D','10','48',NULL,'drvModeForDisabilityEarnings',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeEarningsforDisabilityProducts"','49','(''UA''=''F'')','EDOENYLFMLZ0','9','D','10','49',NULL,'drvEmployeeEarningsforDisabilityProducts',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastEarningsChangeDate"','50','(''UD112''=''F'')','EDOENYLFMLZ0','8','D','10','50',NULL,'drvLastEarningsChangeDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalariedIndicator"','51','(''UA''=''F'')','EDOENYLFMLZ0','1','D','10','51',NULL,'drvSalariedIndicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFullTimeIndicator"','52','(''UA''=''F'')','EDOENYLFMLZ0','1','D','10','52',NULL,'drvFullTimeIndicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCommissionBonusIndicator"','53','(''UA''=''F'')','EDOENYLFMLZ0','1','D','10','53',NULL,'drvCommissionBonusIndicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkAtHomeIndicator"','54','(''UA''=''F'')','EDOENYLFMLZ0','1','D','10','54',NULL,'drvWorkAtHomeIndicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvExemptIndicator"','55','(''UA''=''F'')','EDOENYLFMLZ0','1','D','10','55',NULL,'drvExemptIndicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNumberofHoursWorkedPerWeek"','56','(''UA''=''F'')','EDOENYLFMLZ0','5','D','10','56',NULL,'drvNumberofHoursWorkedPerWeek',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTaxFilingStateCode"','57','(''UA''=''F'')','EDOENYLFMLZ0','2','D','10','57',NULL,'drvTaxFilingStateCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOccupationClassificationCode"','58','(''UA''=''F'')','EDOENYLFMLZ0','9','D','10','58',NULL,'drvOccupationClassificationCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobDescription"','59','(''UA''=''F'')','EDOENYLFMLZ0','65','D','10','59',NULL,'drvJobDescription',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCompanyJobCode"','60','(''UA''=''F'')','EDOENYLFMLZ0','12','D','10','60',NULL,'drvCompanyJobCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOrganizationName"','61','(''UA''=''F'')','EDOENYLFMLZ0','30','D','10','61',NULL,'drvOrganizationName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientOrganizationCode"','62','(''UA''=''F'')','EDOENYLFMLZ0','15','D','10','62',NULL,'drvClientOrganizationCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientLocationCode"','63','(''UA''=''F'')','EDOENYLFMLZ0','12','D','10','63',NULL,'drvClientLocationCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUnionLocalNumber"','64','(''UA''=''F'')','EDOENYLFMLZ0','10','D','10','64',NULL,'drvUnionLocalNumber',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUnionLocalName"','65','(''UA''=''F'')','EDOENYLFMLZ0','30','D','10','65',NULL,'drvUnionLocalName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUnionIndicator"','66','(''UA''=''F'')','EDOENYLFMLZ0','1','D','10','66',NULL,'drvUnionIndicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHealthPlanType"','67','(''UA''=''F'')','EDOENYLFMLZ0','1','D','10','67',NULL,'drvHealthPlanType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHealthPlanDescription"','68','(''UA''=''F'')','EDOENYLFMLZ0','30','D','10','68',NULL,'drvHealthPlanDescription',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccruedSickTime"','69','(''UA''=''F'')','EDOENYLFMLZ0','6','D','10','69',NULL,'drvAccruedSickTime',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvKeyEmployeeIndicator"','70','(''UA''=''F'')','EDOENYLFMLZ0','1','D','10','70',NULL,'drvKeyEmployeeIndicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvActualAnnualHours"','71','(''UA''=''F'')','EDOENYLFMLZ0','4','D','10','71',NULL,'drvActualAnnualHours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkState"','72','(''UA''=''F'')','EDOENYLFMLZ0','2','D','10','72',NULL,'drvWorkState',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReservedEmp_6"','73','(''UA''=''F'')','EDOENYLFMLZ0','50','D','10','73',NULL,'drvReservedEmp_6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaintenanceReasonCode"','74','(''UA''=''F'')','EDOENYLFMLZ0','2','D','10','74',NULL,'drvMaintenanceReasonCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaintenanceDate"','75','(''UD112''=''F'')','EDOENYLFMLZ0','8','D','10','75',NULL,'drvMaintenanceDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseSSN"','76','(''UA''=''F'')','EDOENYLFMLZ0','9','D','10','76',NULL,'drvSpouseSSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseLastName"','77','(''UA''=''F'')','EDOENYLFMLZ0','35','D','10','77',NULL,'drvSpouseLastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseFirstName"','78','(''UA''=''F'')','EDOENYLFMLZ0','25','D','10','78',NULL,'drvSpouseFirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseMiddleName"','79','(''UA''=''F'')','EDOENYLFMLZ0','15','D','10','79',NULL,'drvSpouseMiddleName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseNamePrefix"','80','(''UA''=''F'')','EDOENYLFMLZ0','10','D','10','80',NULL,'drvSpouseNamePrefix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseNameSuffix"','81','(''UA''=''F'')','EDOENYLFMLZ0','10','D','10','81',NULL,'drvSpouseNameSuffix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseDateofBirth"','82','(''UD112''=''F'')','EDOENYLFMLZ0','8','D','10','82',NULL,'drvSpouseDateofBirth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseGender"','83','(''UA''=''F'')','EDOENYLFMLZ0','1','D','10','83',NULL,'drvSpouseGender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseSmokerStatus"','84','(''UA''=''F'')','EDOENYLFMLZ0','1','D','10','84',NULL,'drvSpouseSmokerStatus',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReserved_Emp7"','85','(''UA''=''F'')','EDOENYLFMLZ0','20','D','10','85',NULL,'drvReserved_Emp7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNumberofproducts"','86','(''UA''=''F'')','EDOENYLFMLZ0','2','D','10','86',NULL,'drvNumberofproducts',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoveragecode1"','87','(''UA''=''F'')','EDOENYLFMLZ0','4','D','10','87',NULL,'drvCoveragecode1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReserved1_1"','88','(''UA''=''F'')','EDOENYLFMLZ0','9','D','10','88',NULL,'drvReserved1_1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicySymbol1"','89','(''UA''=''F'')','EDOENYLFMLZ0','3','D','10','89',NULL,'drvPolicySymbol1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicyNumber1"','90','(''UA''=''F'')','EDOENYLFMLZ0','7','D','10','90',NULL,'drvPolicyNumber1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOriginalBenefitEffDate1"','91','(''UD112''=''F'')','EDOENYLFMLZ0','8','D','10','91',NULL,'drvOriginalBenefitEffectiveDate1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIssuedBenefitsPercent1"','92','(''UA''=''F'')','EDOENYLFMLZ0','5','D','10','92',NULL,'drvIssuedBenefitsPercent1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIssuedBenefitsAmount1"','93','(''UA''=''F'')','EDOENYLFMLZ0','9','D','10','93',NULL,'drvIssuedBenefitsAmount1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeContribPercent1"','94','(''UA''=''F'')','EDOENYLFMLZ0','5','D','10','94',NULL,'drvEmployeeContributionPercent1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVoluntaryBenefitEffDate1"','95','(''UD112''=''F'')','EDOENYLFMLZ0','8','D','10','95',NULL,'drvVoluntaryBenefitEffDate1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPostTaxIndicator1"','96','(''UA''=''F'')','EDOENYLFMLZ0','1','D','10','96',NULL,'drvPostTaxIndicator1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitDescription1"','97','(''UA''=''F'')','EDOENYLFMLZ0','30','D','10','97',NULL,'drvBenefitDescription1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReserved1_2"','98','(''UA''=''F'')','EDOENYLFMLZ0','30','D','10','98',NULL,'drvReserved1_2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoveragecode2"','99','(''UA''=''F'')','EDOENYLFMLZ0','4','D','10','99',NULL,'drvCoveragecode2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReserved2_1"','100','(''UA''=''F'')','EDOENYLFMLZ0','9','D','10','100',NULL,'drvReserved2_1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicySymbol2"','101','(''UA''=''F'')','EDOENYLFMLZ0','3','D','10','101',NULL,'drvPolicySymbol2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicyNumber2"','102','(''UA''=''F'')','EDOENYLFMLZ0','7','D','10','102',NULL,'drvPolicyNumber2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOriginalBenefitEffDate2"','103','(''UD112''=''F'')','EDOENYLFMLZ0','8','D','10','103',NULL,'drvOriginalBenefitEffectiveDate2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIssuedBenefitsPercent2"','104','(''UA''=''F'')','EDOENYLFMLZ0','5','D','10','104',NULL,'drvIssuedBenefitsPercent2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIssuedBenefitsAmount2"','105','(''UA''=''F'')','EDOENYLFMLZ0','9','D','10','105',NULL,'drvIssuedBenefitsAmount2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeContribPercent2"','106','(''UA''=''F'')','EDOENYLFMLZ0','5','D','10','106',NULL,'drvEmployeeContributionPercent2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVoluntaryBenefitEffDate2"','107','(''UD112''=''F'')','EDOENYLFMLZ0','8','D','10','107',NULL,'drvVoluntaryBenefitEffectiveDate2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPostTaxIndicator2"','108','(''UA''=''F'')','EDOENYLFMLZ0','1','D','10','108',NULL,'drvPostTaxIndicator2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitDescription2"','109','(''UA''=''F'')','EDOENYLFMLZ0','30','D','10','109',NULL,'drvBenefitDescription2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReserved2_2"','110','(''UA''=''F'')','EDOENYLFMLZ0','30','D','10','110',NULL,'drvReserved2_2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoveragecode3"','111','(''UA''=''F'')','EDOENYLFMLZ0','4','D','10','111',NULL,'drvCoveragecode3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReserved3_1"','112','(''UA''=''F'')','EDOENYLFMLZ0','9','D','10','112',NULL,'drvReserved3_1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicySymbol3"','113','(''UA''=''F'')','EDOENYLFMLZ0','3','D','10','113',NULL,'drvPolicySymbol3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicyNumber3"','114','(''UA''=''F'')','EDOENYLFMLZ0','7','D','10','114',NULL,'drvPolicyNumber3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOriginalBenefitEffDate3"','115','(''UD112''=''F'')','EDOENYLFMLZ0','8','D','10','115',NULL,'drvOriginalBenefitEffectiveDate3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIssuedBenefitsPercent3"','116','(''UA''=''F'')','EDOENYLFMLZ0','5','D','10','116',NULL,'drvIssuedBenefitsPercent3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIssuedBenefitsAmount3"','117','(''UA''=''F'')','EDOENYLFMLZ0','9','D','10','117',NULL,'drvIssuedBenefitsAmount3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeContribPercent3"','118','(''UA''=''F'')','EDOENYLFMLZ0','5','D','10','118',NULL,'drvEmployeeContributionPercent3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVoluntaryBenefitEffDate3"','119','(''UD112''=''F'')','EDOENYLFMLZ0','8','D','10','119',NULL,'drvVoluntaryBenefitEffectiveDate3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPostTaxIndicator3"','120','(''UA''=''F'')','EDOENYLFMLZ0','1','D','10','120',NULL,'drvPostTaxIndicator3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitDescription3"','121','(''UA''=''F'')','EDOENYLFMLZ0','30','D','10','121',NULL,'drvBenefitDescription3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReserved3_2"','122','(''UA''=''F'')','EDOENYLFMLZ0','30','D','10','122',NULL,'drvReserved3_2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoveragecode4"','123','(''UA''=''F'')','EDOENYLFMLZ0','4','D','10','123',NULL,'drvCoveragecode4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReserved4_1"','124','(''UA''=''F'')','EDOENYLFMLZ0','9','D','10','124',NULL,'drvReserved4_1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicySymbol4"','125','(''UA''=''F'')','EDOENYLFMLZ0','3','D','10','125',NULL,'drvPolicySymbol4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicyNumber4"','126','(''UA''=''F'')','EDOENYLFMLZ0','7','D','10','126',NULL,'drvPolicyNumber4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOriginalBenefitEffDate4"','127','(''UD112''=''F'')','EDOENYLFMLZ0','8','D','10','127',NULL,'drvOriginalBenefitEffectiveDate4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIssuedBenefitsPercent4"','128','(''UA''=''F'')','EDOENYLFMLZ0','5','D','10','128',NULL,'drvIssuedBenefitsPercent4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIssuedBenefitsAmount4"','129','(''UA''=''F'')','EDOENYLFMLZ0','9','D','10','129',NULL,'drvIssuedBenefitsAmount4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeContribPercent4"','130','(''UA''=''F'')','EDOENYLFMLZ0','5','D','10','130',NULL,'drvEmployeeContributionPercent4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVoluntaryBenefitEffDate4"','131','(''UD112''=''F'')','EDOENYLFMLZ0','8','D','10','131',NULL,'drvVoluntaryBenefitEffectiveDate4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPostTaxIndicator4"','132','(''UA''=''F'')','EDOENYLFMLZ0','1','D','10','132',NULL,'drvPostTaxIndicator4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitDescription4"','133','(''UA''=''F'')','EDOENYLFMLZ0','30','D','10','133',NULL,'drvBenefitDescription4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReserved4_2"','134','(''UA''=''F'')','EDOENYLFMLZ0','30','D','10','134',NULL,'drvReserved4_2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNumberofProducts_2"','135','(''UA''=''F'')','EDOENYLFMLZ0','2','D','10','135',NULL,'drvNumberofProducts_2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProductCode"','136','(''UA''=''F'')','EDOENYLFMLZ0','3','D','10','136',NULL,'drvProductCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicySymbol"','137','(''UA''=''F'')','EDOENYLFMLZ0','3','D','10','137',NULL,'drvPolicySymbol',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicyNumber"','138','(''UA''=''F'')','EDOENYLFMLZ0','6','D','10','138',NULL,'drvPolicyNumber',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAssignmentIndicator"','139','(''UA''=''F'')','EDOENYLFMLZ0','1','D','10','139',NULL,'drvAssignmentIndicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeePreviousAmount"','140','(''UA''=''F'')','EDOENYLFMLZ0','9','D','10','140',NULL,'drvEmployeePreviousAmount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpPreviousSalaryMultiple"','141','(''UA''=''F'')','EDOENYLFMLZ0','4','D','10','141',NULL,'drvEmployeePreviousSalaryMultiple',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpousePreviousAmount"','142','(''UA''=''F'')','EDOENYLFMLZ0','9','D','10','142',NULL,'drvSpousePreviousAmount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChildPreviousAmount"','143','(''UA''=''F'')','EDOENYLFMLZ0','9','D','10','143',NULL,'drvChildPreviousAmount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeIssuedAmount"','144','(''UA''=''F'')','EDOENYLFMLZ0','9','D','10','144',NULL,'drvEmployeeIssuedAmount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpIssuedSalaryMultiple"','145','(''UA''=''F'')','EDOENYLFMLZ0','4','D','10','145',NULL,'drvEmployeeIssuedSalaryMultiple',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseIssuedAmount"','146','(''UA''=''F'')','EDOENYLFMLZ0','9','D','10','146',NULL,'drvSpouseIssuedAmount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChildIssuedAmount"','147','(''UA''=''F'')','EDOENYLFMLZ0','9','D','10','147',NULL,'drvChildIssuedAmount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeAppliedAmount"','148','(''UA''=''F'')','EDOENYLFMLZ0','9','D','10','148',NULL,'drvEmployeeAppliedAmount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpAppliedSalaryMultiple"','149','(''UA''=''F'')','EDOENYLFMLZ0','4','D','10','149',NULL,'drvEmployeeAppliedSalaryMultiple',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseAppliedAmount"','150','(''UA''=''F'')','EDOENYLFMLZ0','9','D','10','150',NULL,'drvSpouseAppliedAmount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChildAppliedAmount"','151','(''UA''=''F'')','EDOENYLFMLZ0','9','D','10','151',NULL,'drvChildAppliedAmount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeePendingAmount"','152','(''UA''=''F'')','EDOENYLFMLZ0','9','D','10','152',NULL,'drvEmployeePendingAmount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpPendingSalaryMultiple"','153','(''UA''=''F'')','EDOENYLFMLZ0','4','D','10','153',NULL,'drvEmployeePendingSalaryMultiple',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpousePendingAmount"','154','(''UA''=''F'')','EDOENYLFMLZ0','9','D','10','154',NULL,'drvSpousePendingAmount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChildPendingAmount"','155','(''UA''=''F'')','EDOENYLFMLZ0','9','D','10','155',NULL,'drvChildPendingAmount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpMonthlyCashAccuFundAmt"','156','(''UA''=''F'')','EDOENYLFMLZ0','9','D','10','156',NULL,'drvEmployeeMonthlyCashAccumulationFundAmount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpsMonthlyCashAccFundAmt"','157','(''UA''=''F'')','EDOENYLFMLZ0','9','D','10','157',NULL,'drvSpouseMonthlyCashAccumulationFundAmount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeAIOIndicator"','158','(''UA''=''F'')','EDOENYLFMLZ0','1','D','10','158',NULL,'drvEmployeeAIOIndicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeADDADBIndicator"','159','(''UA''=''F'')','EDOENYLFMLZ0','1','D','10','159',NULL,'drvEmployeeADDADBIndicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseADDADBIndicator"','160','(''UA''=''F'')','EDOENYLFMLZ0','1','D','10','160',NULL,'drvSpouseADDADBIndicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeAPBIndicator"','161','(''UA''=''F'')','EDOENYLFMLZ0','1','D','10','161',NULL,'drvEmployeeAPBIndicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseAPBIndicator"','162','(''UA''=''F'')','EDOENYLFMLZ0','1','D','10','162',NULL,'drvSpouseAPBIndicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPAIplanoption"','163','(''UA''=''F'')','EDOENYLFMLZ0','1','D','10','163',NULL,'drvPAIplanoption',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReserved"','164','(''UA''=''F'')','EDOENYLFMLZ0','925','D','10','164',NULL,'drvReserved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHWDeduction01"','165','(''UA''=''F'')','EDOENYLFMLZ0','7','D','10','165',NULL,'drvHWDeduction01',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHWDeduction02"','166','(''UA''=''F'')','EDOENYLFMLZ0','7','D','10','166',NULL,'drvHWDeduction02',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHWDeduction03"','167','(''UA''=''F'')','EDOENYLFMLZ0','7','D','10','167',NULL,'drvHWDeduction03',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHWDeduction04"','168','(''UA''=''F'')','EDOENYLFMLZ0','7','D','10','168',NULL,'drvHWDeduction04',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHWDeduction05"','169','(''UA''=''F'')','EDOENYLFMLZ0','7','D','10','169',NULL,'drvHWDeduction05',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHWDeduction06"','170','(''UA''=''F'')','EDOENYLFMLZ0','7','D','10','170',NULL,'drvHWDeduction06',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHWDeduction07"','171','(''UA''=''F'')','EDOENYLFMLZ0','7','D','10','171',NULL,'drvHWDeduction07',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHWDeduction08"','172','(''UA''=''F'')','EDOENYLFMLZ0','7','D','10','172',NULL,'drvHWDeduction08',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHWDeduction09"','173','(''UA''=''F'')','EDOENYLFMLZ0','7','D','10','173',NULL,'drvHWDeduction09',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHWDeduction10"','174','(''UA''=''F'')','EDOENYLFMLZ0','7','D','10','174',NULL,'drvHWDeduction10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHWDeduction11"','175','(''UA''=''F'')','EDOENYLFMLZ0','7','D','10','175',NULL,'drvHWDeduction11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHWDeduction12"','176','(''UA''=''F'')','EDOENYLFMLZ0','7','D','10','176',NULL,'drvHWDeduction12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReserved_Emp8"','177','(''UA''=''F'')','EDOENYLFMLZ0','178','D','10','177',NULL,'drvReserved_Emp8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvExtendedEmpEmailAddress"','178','(''UA''=''F'')','EDOENYLFMLZ0','50','D','10','178',NULL,'drvExtendedEmployeeEmailAddress',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvExtendedSuppEmailAddress2"','179','(''UA''=''F'')','EDOENYLFMLZ0','50','D','10','179',NULL,'drvExtendedSupplementalEmailAddress2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvExtSuppllEmailAddress1"','180','(''UA''=''F'')','EDOENYLFMLZ0','50','D','10','180',NULL,'drvExtendedSupplementalEmailAddress1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFileRecordIdentifier"','1','(''UA''=''F'')','EDOENYLFMLZ0','2','T','90','1',NULL,'drvFileRecordIdentifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDUNSNumber"','2','(''UA''=''F'')','EDOENYLFMLZ0','15','T','90','2',NULL,'drvDUNSNumber',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReserved"','3','(''UA''=''F'')','EDOENYLFMLZ0','1','T','90','3',NULL,'drvReserved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNumberofRecords"','4','(''UA''=''F'')','EDOENYLFMLZ0','9','T','90','4',NULL,'drvNumberofRecords',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReserved2"','5','(''UA''=''F'')','EDOENYLFMLZ0','2973','T','90','5',NULL,'drvReserved',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EDOENYLFML_20210908.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202107289','EMPEXPORT','OEACTIVE',NULL,'EDOENYLFML',NULL,NULL,NULL,'202107289','Jul 28 2021  7:05PM','Jul 28 2021  7:05PM','202107281',NULL,'','','202107281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202107289','EMPEXPORT','OEPASSIVE',NULL,'EDOENYLFML',NULL,NULL,NULL,'202107289','Jul 28 2021  7:05PM','Jul 28 2021  7:05PM','202107281',NULL,'','','202107281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','',NULL,NULL,NULL,NULL,'NYLife FMLA Export','202107289','EMPEXPORT','ONDEM_XOE',NULL,'EDOENYLFML',NULL,NULL,NULL,'202107289','Jul 28 2021  7:05PM','Jul 28 2021  7:05PM','202107281',NULL,'','','202107281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'NYLife FMLA Export-Sched','202107289','EMPEXPORT','SCH_EDOENY',NULL,'EDOENYLFML',NULL,NULL,NULL,'202107289','Jul 28 2021  7:05PM','Jul 28 2021  7:05PM','202107281',NULL,'','','202107281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'NYLife FMLA Export-Test','202109081','EMPEXPORT','TEST_XOE','Sep  8 2021  3:33PM','EDOENYLFML',NULL,NULL,NULL,'202109081','Sep  8 2021 12:00AM','Dec 30 1899 12:00AM','202109011','1216','','','202109011',dbo.fn_GetTimedKey(),NULL,'us3mLaDOE1000',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDOENYLFML','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDOENYLFML','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDOENYLFML','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDOENYLFML','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDOENYLFML','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDOENYLFML','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EDOENYLFML' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EDOENYLFML' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EDOENYLFML_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EDOENYLFML_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDOENYLFML','H01','dbo.U_EDOENYLFML_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDOENYLFML','D10','dbo.U_EDOENYLFML_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDOENYLFML','T90','dbo.U_EDOENYLFML_Trailer',NULL);
IF OBJECT_ID('U_dsi_BDM_EDOENYLFML') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EDOENYLFML] (
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
IF OBJECT_ID('U_EDOENYLFML_DedList') IS NULL
CREATE TABLE [dbo].[U_EDOENYLFML_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EDOENYLFML_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EDOENYLFML_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvEmployeeSSN] char(11) NULL,
    [drvEmployeeIdentificationNumber] char(9) NULL,
    [drvReserved_Emp] varchar(1) NOT NULL,
    [drvEligibilityBillingLocation] varchar(1) NOT NULL,
    [drvNewYorkLifeInternalCompanyNumber] varchar(9) NOT NULL,
    [drvEmployeeGroupNumberID] varchar(9) NOT NULL,
    [drvEmployeeClassCode] varchar(1) NOT NULL,
    [drvClassChangeEffectiveDate] varchar(1) NOT NULL,
    [drvReserved_Emp2] varchar(1) NOT NULL,
    [drvEmployeeLastName] varchar(100) NULL,
    [drvEmployeeFirstName] varchar(100) NULL,
    [drvEmployeeMiddleName] varchar(50) NULL,
    [drvEmployeeNamePrefix] varchar(1) NOT NULL,
    [drvEmployeeNameSuffix] varchar(30) NULL,
    [drvEmployeeDateofBirth] datetime NULL,
    [drvEmployeeGender] char(1) NULL,
    [drvEmployeeMaritalStatus] varchar(1) NOT NULL,
    [drvEmployeesPINNumber] varchar(1) NOT NULL,
    [drvEmployeeSmokerStatus] varchar(1) NOT NULL,
    [drvEmployeeEmailAddress] varchar(1) NOT NULL,
    [drvReserved_Emp3] varchar(1) NOT NULL,
    [drvSupplementalEmailAddress1] varchar(1) NOT NULL,
    [drvEmail1Type] varchar(1) NOT NULL,
    [drvSupplementalEmailAddress2] varchar(256) NULL,
    [drvEmail2Type] varchar(1) NOT NULL,
    [drvEmployeeMailAddress1] varchar(255) NULL,
    [drvEmployeeMailAddress2] varchar(255) NULL,
    [drvEmployeeMailCity] varchar(255) NULL,
    [drvEmployeeMailState] varchar(255) NULL,
    [drvEmployeeMailZipCode] varchar(50) NULL,
    [drvEmployeeCountry] varchar(3) NOT NULL,
    [drvCountryCode] varchar(2) NOT NULL,
    [drvEmployeeResidenceState] varchar(1) NOT NULL,
    [drvProvince] varchar(1) NOT NULL,
    [drvTypeofAddress] varchar(1) NOT NULL,
    [drvEffectiveDateoftheAddress] varchar(1) NOT NULL,
    [drvPhoneNumber] varchar(50) NULL,
    [drvPhoneUsagecode] varchar(1) NOT NULL,
    [drvReserved_Emp4] varchar(1) NOT NULL,
    [drvReserved_Emp5] varchar(1) NOT NULL,
    [drvEmploymentStatusCode] varchar(2) NULL,
    [drvEmployeeStatusEffectiveDate] datetime NULL,
    [drvEmployeeType] varchar(1) NOT NULL,
    [drvEmployeeDateofHire] datetime NULL,
    [drvAdjustedServiceDate] varchar(1) NOT NULL,
    [drvEmployeeWorksiteLocation] varchar(1) NOT NULL,
    [drvEmployeeAnnualSalaryforLifeBenefit] varchar(1) NOT NULL,
    [drvModeForDisabilityEarnings] varchar(1) NOT NULL,
    [drvEmployeeEarningsforDisabilityProducts] varchar(30) NULL,
    [drvLastEarningsChangeDate] varchar(1) NOT NULL,
    [drvSalariedIndicator] varchar(1) NOT NULL,
    [drvFullTimeIndicator] varchar(1) NOT NULL,
    [drvCommissionBonusIndicator] varchar(1) NOT NULL,
    [drvWorkAtHomeIndicator] varchar(1) NOT NULL,
    [drvExemptIndicator] varchar(1) NOT NULL,
    [drvNumberofHoursWorkedPerWeek] varchar(30) NULL,
    [drvTaxFilingStateCode] varchar(255) NULL,
    [drvOccupationClassificationCode] varchar(1) NOT NULL,
    [drvJobDescription] varchar(1) NOT NULL,
    [drvCompanyJobCode] varchar(1) NOT NULL,
    [drvOrganizationName] varchar(25) NULL,
    [drvClientOrganizationCode] varchar(10) NULL,
    [drvClientLocationCode] varchar(1) NOT NULL,
    [drvUnionLocalNumber] varchar(1) NOT NULL,
    [drvUnionLocalName] varchar(1) NOT NULL,
    [drvUnionIndicator] varchar(1) NOT NULL,
    [drvHealthPlanType] varchar(1) NOT NULL,
    [drvHealthPlanDescription] varchar(1) NOT NULL,
    [drvAccruedSickTime] varchar(1) NOT NULL,
    [drvKeyEmployeeIndicator] varchar(1) NOT NULL,
    [drvActualAnnualHours] varchar(30) NULL,
    [drvWorkState] varchar(255) NULL,
    [drvReservedEmp_6] varchar(1) NOT NULL,
    [drvMaintenanceReasonCode] varchar(1) NOT NULL,
    [drvMaintenanceDate] varchar(1) NOT NULL,
    [drvSpouseSSN] varchar(1) NOT NULL,
    [drvSpouseLastName] varchar(1) NOT NULL,
    [drvSpouseFirstName] varchar(1) NOT NULL,
    [drvSpouseMiddleName] varchar(1) NOT NULL,
    [drvSpouseNamePrefix] varchar(1) NOT NULL,
    [drvSpouseNameSuffix] varchar(1) NOT NULL,
    [drvSpouseDateofBirth] varchar(1) NOT NULL,
    [drvSpouseGender] varchar(1) NOT NULL,
    [drvSpouseSmokerStatus] varchar(1) NOT NULL,
    [drvReserved_Emp7] varchar(1) NOT NULL,
    [drvNumberofproducts] varchar(2) NOT NULL,
    [drvCoveragecode1] varchar(4) NOT NULL,
    [drvReserved1_1] varchar(1) NOT NULL,
    [drvPolicySymbol1] varchar(4) NOT NULL,
    [drvPolicyNumber1] varchar(7) NOT NULL,
    [drvOriginalBenefitEffDate1] varchar(1) NOT NULL,
    [drvIssuedBenefitsPercent1] varchar(1) NOT NULL,
    [drvIssuedBenefitsAmount1] varchar(1) NOT NULL,
    [drvEmployeeContribPercent1] varchar(1) NOT NULL,
    [drvVoluntaryBenefitEffDate1] varchar(1) NOT NULL,
    [drvPostTaxIndicator1] varchar(1) NOT NULL,
    [drvBenefitDescription1] varchar(1) NOT NULL,
    [drvReserved1_2] varchar(1) NOT NULL,
    [drvCoveragecode2] varchar(3) NULL,
    [drvReserved2_1] varchar(1) NOT NULL,
    [drvPolicySymbol2] varchar(2) NULL,
    [drvPolicyNumber2] varchar(7) NULL,
    [drvOriginalBenefitEffDate2] datetime NULL,
    [drvIssuedBenefitsPercent2] varchar(5) NULL,
    [drvIssuedBenefitsAmount2] varchar(1) NOT NULL,
    [drvEmployeeContribPercent2] varchar(5) NULL,
    [drvVoluntaryBenefitEffDate2] varchar(1) NOT NULL,
    [drvPostTaxIndicator2] varchar(1) NULL,
    [drvBenefitDescription2] varchar(1) NOT NULL,
    [drvReserved2_2] varchar(1) NOT NULL,
    [drvCoveragecode3] varchar(3) NULL,
    [drvReserved3_1] varchar(1) NOT NULL,
    [drvPolicySymbol3] varchar(2) NULL,
    [drvPolicyNumber3] varchar(7) NULL,
    [drvOriginalBenefitEffDate3] datetime NULL,
    [drvIssuedBenefitsPercent3] varchar(5) NULL,
    [drvIssuedBenefitsAmount3] varchar(1) NOT NULL,
    [drvEmployeeContribPercent3] varchar(5) NULL,
    [drvVoluntaryBenefitEffDate3] varchar(1) NOT NULL,
    [drvPostTaxIndicator3] varchar(1) NULL,
    [drvBenefitDescription3] varchar(7) NULL,
    [drvReserved3_2] varchar(1) NOT NULL,
    [drvCoveragecode4] varchar(1) NOT NULL,
    [drvReserved4_1] varchar(1) NOT NULL,
    [drvPolicySymbol4] varchar(1) NOT NULL,
    [drvPolicyNumber4] varchar(1) NOT NULL,
    [drvOriginalBenefitEffDate4] varchar(1) NOT NULL,
    [drvIssuedBenefitsPercent4] varchar(1) NOT NULL,
    [drvIssuedBenefitsAmount4] varchar(1) NOT NULL,
    [drvEmployeeContribPercent4] varchar(1) NOT NULL,
    [drvVoluntaryBenefitEffDate4] varchar(1) NOT NULL,
    [drvPostTaxIndicator4] varchar(1) NOT NULL,
    [drvBenefitDescription4] varchar(1) NOT NULL,
    [drvReserved4_2] varchar(1) NOT NULL,
    [drvNumberofProducts_2] varchar(1) NOT NULL,
    [drvProductCode] varchar(1) NOT NULL,
    [drvPolicySymbol] varchar(1) NOT NULL,
    [drvPolicyNumber] varchar(1) NOT NULL,
    [drvAssignmentIndicator] varchar(1) NOT NULL,
    [drvEmployeePreviousAmount] varchar(1) NOT NULL,
    [drvEmpPreviousSalaryMultiple] varchar(1) NOT NULL,
    [drvSpousePreviousAmount] varchar(1) NOT NULL,
    [drvChildPreviousAmount] varchar(1) NOT NULL,
    [drvEmployeeIssuedAmount] varchar(1) NOT NULL,
    [drvEmpIssuedSalaryMultiple] varchar(1) NOT NULL,
    [drvSpouseIssuedAmount] varchar(1) NOT NULL,
    [drvChildIssuedAmount] varchar(1) NOT NULL,
    [drvEmployeeAppliedAmount] varchar(1) NOT NULL,
    [drvEmpAppliedSalaryMultiple] varchar(1) NOT NULL,
    [drvSpouseAppliedAmount] varchar(1) NOT NULL,
    [drvChildAppliedAmount] varchar(1) NOT NULL,
    [drvEmployeePendingAmount] varchar(1) NOT NULL,
    [drvEmpPendingSalaryMultiple] varchar(1) NOT NULL,
    [drvSpousePendingAmount] varchar(1) NOT NULL,
    [drvChildPendingAmount] varchar(1) NOT NULL,
    [drvEmpMonthlyCashAccuFundAmt] varchar(1) NOT NULL,
    [drvSpsMonthlyCashAccFundAmt] varchar(1) NOT NULL,
    [drvEmployeeAIOIndicator] varchar(1) NOT NULL,
    [drvEmployeeADDADBIndicator] varchar(1) NOT NULL,
    [drvSpouseADDADBIndicator] varchar(1) NOT NULL,
    [drvEmployeeAPBIndicator] varchar(1) NOT NULL,
    [drvSpouseAPBIndicator] varchar(1) NOT NULL,
    [drvPAIplanoption] varchar(1) NOT NULL,
    [drvReserved] varchar(1) NOT NULL,
    [drvHWDeduction01] varchar(1) NOT NULL,
    [drvHWDeduction02] varchar(1) NOT NULL,
    [drvHWDeduction03] varchar(1) NOT NULL,
    [drvHWDeduction04] varchar(1) NOT NULL,
    [drvHWDeduction05] varchar(1) NOT NULL,
    [drvHWDeduction06] varchar(1) NOT NULL,
    [drvHWDeduction07] varchar(1) NOT NULL,
    [drvHWDeduction08] varchar(1) NOT NULL,
    [drvHWDeduction09] varchar(1) NOT NULL,
    [drvHWDeduction10] varchar(1) NOT NULL,
    [drvHWDeduction11] varchar(1) NOT NULL,
    [drvHWDeduction12] varchar(1) NOT NULL,
    [drvReserved_Emp8] varchar(1) NOT NULL,
    [drvExtendedEmpEmailAddress] varchar(50) NULL,
    [drvExtendedSuppEmailAddress2] varchar(1) NOT NULL,
    [drvExtSuppllEmailAddress1] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EDOENYLFML_EEList') IS NULL
CREATE TABLE [dbo].[U_EDOENYLFML_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EDOENYLFML_File') IS NULL
CREATE TABLE [dbo].[U_EDOENYLFML_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);
IF OBJECT_ID('U_EDOENYLFML_Header') IS NULL
CREATE TABLE [dbo].[U_EDOENYLFML_Header] (
    [drvFileRecordIdentifier] varchar(2) NOT NULL,
    [drvDUNSNumber] varchar(9) NOT NULL,
    [drvProductionTestIndicator] varchar(1) NULL,
    [drvFileCreationDate] datetime NOT NULL,
    [drvEmployerName] varchar(19) NOT NULL,
    [drvFileType] varchar(1) NOT NULL,
    [drvLifeAccidentFileMaintenanceReasonType] varchar(1) NOT NULL,
    [drvDisabilityFileMaintenanceReasonType] varchar(1) NOT NULL,
    [drvReserved] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EDOENYLFML_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EDOENYLFML_PDedHist] (
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
IF OBJECT_ID('U_EDOENYLFML_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EDOENYLFML_PEarHist] (
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
IF OBJECT_ID('U_EDOENYLFML_Trailer') IS NULL
CREATE TABLE [dbo].[U_EDOENYLFML_Trailer] (
    [drvFileRecordIdentifier] varchar(2) NOT NULL,
    [drvDUNSNumber] varchar(9) NOT NULL,
    [drvReserved] varchar(1) NOT NULL,
    [drvNumberofRecords] varchar(30) NULL,
    [drvReserved2] varchar(1) NOT NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EDOENYLFML]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Doe Run

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 09/03/2021
Service Request Number: TekP-2021-06-21-0003

Purpose: NYLife FMLA Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EDOENYLFML';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EDOENYLFML';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EDOENYLFML';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EDOENYLFML';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EDOENYLFML' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDOENYLFML', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDOENYLFML', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDOENYLFML', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDOENYLFML', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDOENYLFML', 'SCH_EDOENY';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EDOENYLFML';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EDOENYLFML', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@Last52WeekPerControl as VARCHAR(10) ;

    -- Set FormatCode
    SELECT @FormatCode = 'EDOENYLFML';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;


    SELECT @Last52WeekPerControl =  CONVERT(VARCHAR(12),DATEADD(week,-52, @StartDate),112) + '1'
    PRINT 'Last 52 Weeks ' + @Last52WeekPerControl
    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EDOENYLFML_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EDOENYLFML_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_EDOENYLFML_EEList
    WHERE  xEEID IN (    Select distinct eeceeid from dbo.EmpComp where eeceetype = 'TES' );

    /*DELETE FROM dbo.U_EDOENYLFML_EEList
    WHERE  xEEID IN (    Select distinct eeceeid from dbo.EmpComp where     eeceeid in ('BY26UH0000K0','CQ5FQX000040','BY0TF50050K0','CFS9WW0000K0','CQ5BQW000040','CHJAP4000040','CHJAC5000040'));

      DELETE FROM dbo.U_EDOENYLFML_EEList
    WHERE  xEEID IN (    Select eeceeid from dbo.EmpComp WHERE eecpaygroup = 'SCS030');
    */
    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'STD,LTD,STDS';

    IF OBJECT_ID('U_EDOENYLFML_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EDOENYLFML_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EDOENYLFML_DedList
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
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EDOENYLFML_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EDOENYLFML_PDedHist;
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
    INTO dbo.U_EDOENYLFML_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EDOENYLFML_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EDOENYLFML_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EDOENYLFML_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >=  @Last52WeekPerControl and PehPerControl <= @StartPerControl  and pehEarnCode in ('DT', 'HOL', 'HTR', 'JURY', 'MTGS', 'ORIEN', 'OT', 'OTTMP', 'REG', 'SOT', 'TRAIN', 'WKLRN') THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_EDOENYLFML_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE  PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;

    
    --Audit Table
    IF OBJECT_ID('U_EDOENYLFMLAuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EDOENYLFMLAuditFields;
    CREATE TABLE dbo.U_EDOENYLFMLAuditFields (aTableName varchar(128),aFieldName varchar(128));
    
    -- Insert tables/fields to be audited
    INSERT INTO dbo.U_EDOENYLFMLAuditFields VALUES ('EmpComp','EecEmplStatus');    
    
    -- Create audit table
    IF OBJECT_ID('U_EDOENYLFMLAudit','U') IS NOT NULL
        DROP TABLE dbo.U_EDOENYLFMLAudit;
    SELECT
         audTableName = adrTableName
        ,audFieldName = adfFieldName
        ,audKey1Value = ISNULL(adrKey1,'')
        ,audKey2Value = ISNULL(adrKey2,'')
        ,audKey3Value = ISNULL(adrKey3,'')
        ,audDateTime  = adrProcessedDateTime
        ,audOldValue  = adfOldData
        ,audNewValue  = adfNewData
        ,audRowNo     = ROW_NUMBER() OVER(PARTITION BY adrKey1, adrKey2, adrKey3, adfFieldName ORDER BY adrRecID DESC)
    INTO dbo.U_EDOENYLFMLAudit
    FROM (SELECT *
          FROM dbo.AuditRecords WITH (NOLOCK)
          WHERE adrTableName IN (SELECT aTableName FROM dbo.U_EDOENYLFMLAuditFields WITH (NOLOCK))) ADR
    JOIN (SELECT *
          FROM dbo.AuditFields WITH (NOLOCK)
          WHERE adfFieldName IN (SELECT aFieldName FROM dbo.U_EDOENYLFMLAuditFields WITH (NOLOCK))) ADF
        ON adrSystemID = adfSystemID
       AND adrKey = adfKey
    WHERE adrType IN (1,2,5,6) -- Insert/Update; remove this to include Deletes and Viewed
      AND adrProcessedDateTime BETWEEN @StartDate AND @EndDate;
    
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EDOENYLFMLAudit ON dbo.U_EDOENYLFMLAudit (audKey1Value, audKey2Value);

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EDOENYLFML_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EDOENYLFML_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EDOENYLFML_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        -- standard fields above and additional driver fields below
        ,drvInitialSort = eepssn
        ,drvSubSort = ''
        ,drvEmployeeSSN = eepSSN
        ,drvEmployeeIdentificationNumber = EecEmpNo
        ,drvReserved_Emp = ''
        ,drvEligibilityBillingLocation = ''
        ,drvNewYorkLifeInternalCompanyNumber = '000318290'
        ,drvEmployeeGroupNumberID = '000025763'
        ,drvEmployeeClassCode = ''
        ,drvClassChangeEffectiveDate = ''
        ,drvReserved_Emp2 = ''
        ,drvEmployeeLastName = EepNameLast
        ,drvEmployeeFirstName = EepNameFirst
        ,drvEmployeeMiddleName = EepNameMiddle
        ,drvEmployeeNamePrefix = ''
        ,drvEmployeeNameSuffix = NULLIF(EepNameSuffix,'Z')
        ,drvEmployeeDateofBirth = EepDateOfBirth
        ,drvEmployeeGender = EepGender
        ,drvEmployeeMaritalStatus =   CASE WHEN eepMaritalStatus = 'D' THEN 'D'
            WHEN eepMaritalStatus = 'M' THEN 'M'
            WHEN eepMaritalStatus = 'S' THEN 'I'
            WHEN eepMaritalStatus = 'W' THEN 'W'
            else  'K'
        END
        ,drvEmployeesPINNumber = ''
        ,drvEmployeeSmokerStatus = ''
        ,drvEmployeeEmailAddress = ''
        ,drvReserved_Emp3 = ''
        ,drvSupplementalEmailAddress1 = ''
        ,drvEmail1Type = ''
        ,drvSupplementalEmailAddress2 = dbo.dsi_fnlib_GetSupervisorField('',  (Select top 1 OrgManagerId  from dbo.OrgLevel WITH (NOLOCK) Where OrgLvl = 1 and OrgCode = EecOrgLvl1), 'AddressEMail')    
        ,drvEmail2Type = '2'
        ,drvEmployeeMailAddress1 = EepAddressLine1
        ,drvEmployeeMailAddress2 = EepAddressLine2
        ,drvEmployeeMailCity = EepAddressCity
        ,drvEmployeeMailState = EepAddressState
        ,drvEmployeeMailZipCode = CASE WHEN LEN (EepAddressZipCode) <= 5 then EepAddressZipCode ELSE LEFT(EepAddressZipCode,5) + '-' + RIGHT(EepAddressZipCode,4) END
        ,drvEmployeeCountry = 'USA'
        ,drvCountryCode = 'US'
        ,drvEmployeeResidenceState = ''
        ,drvProvince = ''
        ,drvTypeofAddress = 'R'
        ,drvEffectiveDateoftheAddress = ''
        ,drvPhoneNumber = EepPhoneHomeNumber
        ,drvPhoneUsagecode = 'R'
        ,drvReserved_Emp4 = ''
        ,drvReserved_Emp5 = ''
        ,drvEmploymentStatusCode = CASE WHEN EecEmplStatus = 'L' THEN 'L1'
                                        WHEN EecEmplStatus = 'T' THEN
                                            CASE WHEN EecTermReason = '202' THEN 'RT'
                                                 WHEN EecTermReason = '203' THEN 'DI'
                                                 WHEN EecTermReason not in  ('202','203') THEN 'TE'
                                            END
                                        ELSE 'AC'
                                   END
        ,drvEmployeeStatusEffectiveDate = CASE WHEN EecEmplStatus = 'T'  THEN EecDateOfTermination
                                            WHEN EecEmplStatus = 'L'  THEN  EecEmplStatusStartDate
                                    END
        ,drvEmployeeType = CASE WHEN EecEEType = 'REG' THEN 'P' ELSE 'T' END
        ,drvEmployeeDateofHire = eecDateofLastHire
        ,drvAdjustedServiceDate = ''
        ,drvEmployeeWorksiteLocation = ''
        ,drvEmployeeAnnualSalaryforLifeBenefit = ''
        ,drvModeForDisabilityEarnings = 'A'
        ,drvEmployeeEarningsforDisabilityProducts = CASE WHEN EecAnnSalary IS NOT NULL THEN CONVERT(VARCHAR,dbo.dsi_fnPadZero(EecAnnSalary*100,9,0))  ELSE '000000000' END
        ,drvLastEarningsChangeDate = ''
        ,drvSalariedIndicator = CASE WHEN EecSalaryOrHourly = 'S' THEN 'Y' ELSE 'N' END
        ,drvFullTimeIndicator = CASE WHEN EecFullTimeOrPartTime = 'FT' THEN 'Y' ELSE  'N' END
        ,drvCommissionBonusIndicator = ''
        ,drvWorkAtHomeIndicator = ''
        ,drvExemptIndicator = CASE WHEN JobHist.EjhFLSACategory = 'E' THEN 'Y' ELSE 'N' END
        ,drvNumberofHoursWorkedPerWeek = CASE WHEN eecpayperiod = 'SW' THEN CONVERT(VARCHAR,dbo.dsi_fnPadZero((EecScheduledWorkHrs /2) *100 ,5,0)) 
                                              WHEN eecpayperiod = 'W' THEN CONVERT(VARCHAR,dbo.dsi_fnPadZero((EecScheduledWorkHrs) *100 ,5,0)) 
                                         END
        ,drvTaxFilingStateCode = EepAddressState
        ,drvOccupationClassificationCode = ''
        ,drvJobDescription = ''
        ,drvCompanyJobCode = ''
        ,drvOrganizationName = (Select top 1 OrgDesc  from dbo.OrgLevel WITH (NOLOCK) Where OrgLvl = 1 and OrgCode = EecOrgLvl1) --dbo.dsi_fnRemoveChars('.,',UPPER(cmpcompanyname))
        ,drvClientOrganizationCode = EecOrgLvl1
        ,drvClientLocationCode = ''
        ,drvUnionLocalNumber = ''
        ,drvUnionLocalName = ''
        ,drvUnionIndicator = 'N'
        ,drvHealthPlanType = ''
        ,drvHealthPlanDescription = ''
        ,drvAccruedSickTime = ''
        ,drvKeyEmployeeIndicator = CASE WHEN EecIsKeyEmployee = 'Y' THEN 'Y' ELSE 'N' END
        --Here
        ,drvActualAnnualHours = CONVERT(VARCHAR,dbo.dsi_fnPadZero( CONVERT(DECIMAL(4,0),pehCurHrs),4,0))  
        ,drvWorkState = (Select LocAddressState from dbo.Location where LocCode = EecLocation)
        ,drvReservedEmp_6 = ''
        ,drvMaintenanceReasonCode = ''
        ,drvMaintenanceDate = ''
        ,drvSpouseSSN = ''
        ,drvSpouseLastName = ''
        ,drvSpouseFirstName = ''
        ,drvSpouseMiddleName = ''
        ,drvSpouseNamePrefix = ''
        ,drvSpouseNameSuffix = ''
        ,drvSpouseDateofBirth = ''
        ,drvSpouseGender = ''
        ,drvSpouseSmokerStatus = ''
        ,drvReserved_Emp7 = ''
        ,drvNumberofproducts = '03'
        ,drvCoveragecode1 = 'FMLA'
        ,drvReserved1_1 = ''
        ,drvPolicySymbol1 = 'FMLA'
        ,drvPolicyNumber1 = '0752815'
        ,drvOriginalBenefitEffDate1 = ''
        ,drvIssuedBenefitsPercent1 = ''
        ,drvIssuedBenefitsAmount1 = ''
        ,drvEmployeeContribPercent1 = ''
        ,drvVoluntaryBenefitEffDate1 = ''
        ,drvPostTaxIndicator1 = ''
        ,drvBenefitDescription1 = CASE WHEN eecorglvl1 = 'FPI' THEN '2' ELSE '1' END
        ,drvReserved1_2 = ''
        ,drvCoveragecode2 = CASE WHEN STD is not null THEN 'STD' END
        ,drvReserved2_1 = ''
        ,drvPolicySymbol2 =  CASE WHEN STD is not null THEN 'LK' END
        ,drvPolicyNumber2 =  CASE WHEN STD is not null THEN '0752815' END
        ,drvOriginalBenefitEffDate2 = CASE WHEN STD is not null THEN STD_STARTDATE END
        ,drvIssuedBenefitsPercent2 = CASE WHEN STD is not null THEN '06000' END
        ,drvIssuedBenefitsAmount2 = ''
        ,drvEmployeeContribPercent2 = CASE WHEN STD is not null THEN '00000' END
        ,drvVoluntaryBenefitEffDate2 = ''
        ,drvPostTaxIndicator2 = CASE WHEN STD is not null THEN 'N' END
        ,drvBenefitDescription2 = ''
        ,drvReserved2_2 = ''
        ,drvCoveragecode3 = CASE WHEN LTD is not null THEN 'LTD' END
        ,drvReserved3_1 = ''
        ,drvPolicySymbol3 = CASE WHEN LTD is not null THEN 'LK' END
        ,drvPolicyNumber3 = CASE WHEN LTD is not null THEN '0966517' END
        ,drvOriginalBenefitEffDate3 = CASE WHEN LTD is not null THEN LTD_STARTDATE END
        ,drvIssuedBenefitsPercent3 = CASE WHEN LTD is not null THEN '06000' END
        ,drvIssuedBenefitsAmount3 = ''
        ,drvEmployeeContribPercent3 = CASE WHEN LTD is not null THEN '00000' END
        ,drvVoluntaryBenefitEffDate3 = ''
        ,drvPostTaxIndicator3 = CASE WHEN LTD is not null THEN 'N' END
        ,drvBenefitDescription3 = CASE WHEN LTD is not null THEN 'Class 1' END
        ,drvReserved3_2 = ''
        ,drvCoveragecode4 = ''
        ,drvReserved4_1 = ''
        ,drvPolicySymbol4 = ''
        ,drvPolicyNumber4 = ''
        ,drvOriginalBenefitEffDate4 = ''
        ,drvIssuedBenefitsPercent4 = ''
        ,drvIssuedBenefitsAmount4 = ''
        ,drvEmployeeContribPercent4 = ''
        ,drvVoluntaryBenefitEffDate4 = ''
        ,drvPostTaxIndicator4 = ''
        ,drvBenefitDescription4 = ''
        ,drvReserved4_2 = ''
        ,drvNumberofProducts_2 = ''
        ,drvProductCode = ''
        ,drvPolicySymbol = ''
        ,drvPolicyNumber = ''
        ,drvAssignmentIndicator = ''
        ,drvEmployeePreviousAmount = ''
        ,drvEmpPreviousSalaryMultiple = ''
        ,drvSpousePreviousAmount = ''
        ,drvChildPreviousAmount = ''
        ,drvEmployeeIssuedAmount = ''
        ,drvEmpIssuedSalaryMultiple = ''
        ,drvSpouseIssuedAmount = ''
        ,drvChildIssuedAmount = ''
        ,drvEmployeeAppliedAmount = ''
        ,drvEmpAppliedSalaryMultiple = ''
        ,drvSpouseAppliedAmount = ''
        ,drvChildAppliedAmount = ''
        ,drvEmployeePendingAmount = ''
        ,drvEmpPendingSalaryMultiple = ''
        ,drvSpousePendingAmount = ''
        ,drvChildPendingAmount = ''
        ,drvEmpMonthlyCashAccuFundAmt = ''
        ,drvSpsMonthlyCashAccFundAmt = ''
        ,drvEmployeeAIOIndicator = ''
        ,drvEmployeeADDADBIndicator = ''
        ,drvSpouseADDADBIndicator = ''
        ,drvEmployeeAPBIndicator = ''
        ,drvSpouseAPBIndicator = ''
        ,drvPAIplanoption = ''
        ,drvReserved = ''
        ,drvHWDeduction01 = ''
        ,drvHWDeduction02 = ''
        ,drvHWDeduction03 = ''
        ,drvHWDeduction04 = ''
        ,drvHWDeduction05 = ''
        ,drvHWDeduction06 = ''
        ,drvHWDeduction07 = ''
        ,drvHWDeduction08 = ''
        ,drvHWDeduction09 = ''
        ,drvHWDeduction10 = ''
        ,drvHWDeduction11 = ''
        ,drvHWDeduction12 = ''
        ,drvReserved_Emp8 = ''
        ,drvExtendedEmpEmailAddress = EepAddressEMail
        ,drvExtendedSuppEmailAddress2 = ''
        ,drvExtSuppllEmailAddress1 = ''
    INTO dbo.U_EDOENYLFML_drvTbl
    FROM dbo.U_EDOENYLFML_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
         and (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                                        and EXISTS(select 1 from dbo.U_EDOENYLFMLAudit where  audKey1Value = xEEID AND audKey2Value = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    JOIN dbo.Company WITH (NOLOCK)
        on cmpcoid = xcoid
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    LEFT JOIN (Select  bdmEEID,bdmcoid
            ,STD = MAX((CASE WHEN bdmDedCode IN('STD','STDS') then bdmDedCode END))
            ,LTD = MAX((CASE WHEN bdmDedCode IN('LTD')   then bdmDedCode END))
            ,STD_STARTDATE = MAX((CASE WHEN bdmDedCode IN('STD')   then BdmBenStartDate END))
            ,LTD_STARTDATE = MAX((CASE WHEN bdmDedCode IN('LTD')   then BdmBenStartDate END))
            ,STD_STOPDATE = MAX((CASE WHEN bdmDedCode IN('STD')  then BdmBenStopDate END))
            ,LTD_STOPDATE = MAX((CASE WHEN bdmDedCode IN('LTD')  then BdmBenStopDate END))
            from U_dsi_BDM_EDOENYLFML WITH (NOLOCK) 
            group by bdmEEID,bdmcoid) as BdmConsolidated
        ON xEEID =  bdmEEID 
        AND XCOID = bdmCOID
    LEFT JOIN dbo.U_EDOENYLFML_PEarHist
        on PehEEID =  xeeid
    LEFT JOIN (Select * from  (
Select EjhHourlyPayRate,EjhFLSACategory,Ejheeid,ROW_NUMBER() OVER(PARTITION BY ejheeid ORDER BY auditkey DESC) as Row_Num from dbo.EmphJob WITH (NOLOCK)
) A where Row_Num = 1) as JobHist
    on JobHist.ejheeid = xeeid
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EDOENYLFML_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EDOENYLFML_Header;
    SELECT DISTINCT
         drvFileRecordIdentifier = 'HD'
        ,drvDUNSNumber = '052028345'
        ,drvProductionTestIndicator = CASE WHEN @ExportCode LIKE 'TEST%' THEN 'T' END
        ,drvFileCreationDate = GETDATE()
        ,drvEmployerName = 'THE DOE RUN COMPANY'
        ,drvFileType = '2'
        ,drvLifeAccidentFileMaintenanceReasonType = ''
        ,drvDisabilityFileMaintenanceReasonType = '2'
        ,drvReserved = ''
    INTO dbo.U_EDOENYLFML_Header
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EDOENYLFML_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_EDOENYLFML_Trailer;
    SELECT DISTINCT
         drvFileRecordIdentifier = 'TR'
        ,drvDUNSNumber = '052028345'
        ,drvReserved = ''
        ,drvNumberofRecords = CAST( (Select count(*) from dbo.U_EDOENYLFML_drvTbl) as varchar)
        ,drvReserved2 = ''
    INTO dbo.U_EDOENYLFML_Trailer
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
ALTER VIEW dbo.dsi_vwEDOENYLFML_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EDOENYLFML_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EDOENYLFML%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202107211'
       ,expStartPerControl     = '202107211'
       ,expLastEndPerControl   = '202107289'
       ,expEndPerControl       = '202107289'
WHERE expFormatCode = 'EDOENYLFML';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEDOENYLFML_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EDOENYLFML_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort