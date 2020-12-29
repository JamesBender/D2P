SET NOCOUNT ON;
IF OBJECT_ID('U_EMEDICAVM2_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EMEDICAVM2_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EMEDICAVM2_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EMEDICAVM2' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEMEDICAVM2_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEMEDICAVM2_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EMEDICAVM2') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMEDICAVM2];
GO
IF OBJECT_ID('U_EMEDICAVM2_File') IS NOT NULL DROP TABLE [dbo].[U_EMEDICAVM2_File];
GO
IF OBJECT_ID('U_EMEDICAVM2_EEList') IS NOT NULL DROP TABLE [dbo].[U_EMEDICAVM2_EEList];
GO
IF OBJECT_ID('U_EMEDICAVM2_drvTblH01') IS NOT NULL DROP TABLE [dbo].[U_EMEDICAVM2_drvTblH01];
GO
IF OBJECT_ID('U_EMEDICAVM2_drvTblD10') IS NOT NULL DROP TABLE [dbo].[U_EMEDICAVM2_drvTblD10];
GO
IF OBJECT_ID('U_EMEDICAVM2_DedList') IS NOT NULL DROP TABLE [dbo].[U_EMEDICAVM2_DedList];
GO
IF OBJECT_ID('U_EMEDICAVM2_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EMEDICAVM2_AuditFields];
GO
IF OBJECT_ID('U_EMEDICAVM2_Audit') IS NOT NULL DROP TABLE [dbo].[U_EMEDICAVM2_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EMEDICAVM2') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EMEDICAVM2];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EMEDICAVM2';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EMEDICAVM2';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EMEDICAVM2';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EMEDICAVM2';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EMEDICAVM2';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EMEDICAVM2','Medica Enrollment Export 2','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','EMEDICAVM2Z0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EMEDICAVM2' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','1','(''SS''=''F'')','EMEDICAVM2Z0','19','H','01','1',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHeaderCount"','2','(''UN00''=''F'')','EMEDICAVM2Z0','8','H','01','20',NULL,'Record Count',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"|"','3','(''DA''=''F'')','EMEDICAVM2Z0','1','H','01','28',NULL,'Pipe',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"1.20"','1','(''DA''=''F'')','EMEDICAVM2Z0','5','D','10','1',NULL,'Version Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VOAMF"','2','(''DA''=''F'')','EMEDICAVM2Z0','8','D','10','6',NULL,'Submission Group ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''SS''=''F'')','EMEDICAVM2Z0','12','D','10','14',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelationshipCode"','4','(''UA''=''F'')','EMEDICAVM2Z0','2','D','10','26',NULL,'Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeID"','5','(''UA''=''F'')','EMEDICAVM2Z0','11','D','10','28',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','6','(''SS''=''F'')','EMEDICAVM2Z0','4','D','10','39',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemberSocialSecurityNumber"','7','(''UA''=''F'')','EMEDICAVM2Z0','11','D','10','43',NULL,'Member Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''SS''=''F'')','EMEDICAVM2Z0','35','D','10','54',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmploymentDate"','9','(''UD112''=''F'')','EMEDICAVM2Z0','8','D','10','89',NULL,'Employment Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''SS''=''F'')','EMEDICAVM2Z0','12','D','10','97',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemberLastName"','11','(''UA''=''F'')','EMEDICAVM2Z0','20','D','10','109',NULL,'Member Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemberFirstName"','12','(''UA''=''F'')','EMEDICAVM2Z0','12','D','10','129',NULL,'Member First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','13','(''SS''=''F'')','EMEDICAVM2Z0','8','D','10','141',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemberMiddleInitial"','14','(''UA''=''F'')','EMEDICAVM2Z0','1','D','10','149',NULL,'Member Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','15','(''SS''=''F'')','EMEDICAVM2Z0','19','D','10','150',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemberBirthDate"','16','(''UD112''=''F'')','EMEDICAVM2Z0','8','D','10','169',NULL,'Member Birth Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','17','(''SS''=''F'')','EMEDICAVM2Z0','12','D','10','177',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemberGender"','18','(''UA''=''F'')','EMEDICAVM2Z0','1','D','10','189',NULL,'Member Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemberMaritalStatus"','19','(''UA''=''F'')','EMEDICAVM2Z0','1','D','10','190',NULL,'Member Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','20','(''SS''=''F'')','EMEDICAVM2Z0','24','D','10','191',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPermanentStreetAddress1"','21','(''UA''=''F'')','EMEDICAVM2Z0','32','D','10','215',NULL,'Permanent Street Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPermanentStreetAddress2"','22','(''UA''=''F'')','EMEDICAVM2Z0','32','D','10','247',NULL,'Permanent Street Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPermanentCity"','23','(''UA''=''F'')','EMEDICAVM2Z0','20','D','10','279',NULL,'Permanent City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPermanentState"','24','(''UA''=''F'')','EMEDICAVM2Z0','2','D','10','299',NULL,'Permanent State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPermanentZIPCode"','25','(''UA''=''F'')','EMEDICAVM2Z0','15','D','10','301',NULL,'Permanent ZIP Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPermanentCountryCode"','26','(''UA''=''F'')','EMEDICAVM2Z0','2','D','10','316',NULL,'Permanent Country Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','27','(''SS''=''F'')','EMEDICAVM2Z0','1','D','10','318',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmailAddress"','28','(''UA''=''F'')','EMEDICAVM2Z0','50','D','10','319',NULL,'Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','29','(''SS''=''F'')','EMEDICAVM2Z0','44','D','10','369',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkPhoneNumber"','30','(''UA''=''F'')','EMEDICAVM2Z0','10','D','10','413',NULL,'Work Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomePhoneNumber"','31','(''UA''=''F'')','EMEDICAVM2Z0','10','D','10','423',NULL,'Home Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDeathDate"','32','(''UD112''=''F'')','EMEDICAVM2Z0','8','D','10','433',NULL,'Death Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','33','(''SS''=''F'')','EMEDICAVM2Z0','69','D','10','441',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepartmentNumber"','34','(''UA''=''F'')','EMEDICAVM2Z0','12','D','10','510',NULL,'Department Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubDepartmentNbr"','35','(''UA''=''F'')','EMEDICAVM2Z0','8','D','10','522',NULL,'Sub-Department Nbr',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRetirementDate"','36','(''UD112''=''F'')','EMEDICAVM2Z0','8','D','10','530',NULL,'Retirement Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','37','(''SS''=''F'')','EMEDICAVM2Z0','8','D','10','538',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPrimaryCareClinic"','38','(''UA''=''F'')','EMEDICAVM2Z0','11','D','10','546',NULL,'Primary Care Clinic',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','39','(''SS''=''F'')','EMEDICAVM2Z0','199','D','10','557',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MM"','40','(''DA''=''F'')','EMEDICAVM2Z0','3','D','10','756',NULL,'Coverage 1 Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverage1CoverageStartDate"','41','(''UD112''=''F'')','EMEDICAVM2Z0','8','D','10','759',NULL,'Coverage 1 Coverage Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','42','(''SS''=''F'')','EMEDICAVM2Z0','12','D','10','767',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverage1CoverageEndDate"','43','(''UD112''=''F'')','EMEDICAVM2Z0','8','D','10','779',NULL,'Coverage 1 Coverage End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','44','(''SS''=''F'')','EMEDICAVM2Z0','42','D','10','787',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverage1GroupNumber"','45','(''UA''=''F'')','EMEDICAVM2Z0','7','D','10','829',NULL,'Coverage 1 Group Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','46','(''SS''=''F'')','EMEDICAVM2Z0','3','D','10','836',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MTK"','47','(''DA''=''F'')','EMEDICAVM2Z0','4','D','10','839',NULL,'Coverage 2 Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','48','(''SS''=''F'')','EMEDICAVM2Z0','76','D','10','843',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverage1Code"','49','(''UA''=''F'')','EMEDICAVM2Z0','3','D','10','919',NULL,'Coverage 1 Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','50','(''SS''=''F'')','EMEDICAVM2Z0','57','D','10','922',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdultDependentFlag"','51','(''UA''=''F'')','EMEDICAVM2Z0','1','D','10','979',NULL,'Adult Dependent Flag',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','52','(''SS''=''F'')','EMEDICAVM2Z0','1','D','10','980',NULL,'FILLER',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EMEDICAVM2_20201215.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','',NULL,NULL,NULL,NULL,'Medica OE Active','202001279','EMPEXPORT','OEACTIVE',NULL,'EMEDICAVM2',NULL,NULL,NULL,'202001279','Jan 27 2020  5:48PM','Jan 27 2020  5:48PM','202001271',NULL,'','','202001271',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','',NULL,NULL,NULL,NULL,'Medica OE Passive','202001279','EMPEXPORT','OEPASSIVE',NULL,'EMEDICAVM2',NULL,NULL,NULL,'202001279','Jan 27 2020  5:48PM','Jan 27 2020  5:48PM','202001271',NULL,'','','202001271',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','',NULL,NULL,NULL,NULL,'Medica OnDemand','202001279','EMPEXPORT','ONDEM_XOE',NULL,'EMEDICAVM2',NULL,NULL,NULL,'202001279','Jan 27 2020  5:48PM','Jan 27 2020  5:48PM','202001271',NULL,'','','202001271',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','',NULL,NULL,NULL,NULL,'Medica Test','202001279','EMPEXPORT','ONTEST_XOE',NULL,'EMEDICAVM2',NULL,NULL,NULL,'202001279','Jan 27 2020  5:48PM','Jan 27 2020  5:48PM','202001271',NULL,'','','202001271',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'Null','N','IAGFG,2SN84',NULL,NULL,NULL,'Medica Scheduled','202001279','EMPEXPORT','SCHMEDCVM',NULL,'EMEDICAVM2',NULL,NULL,NULL,'202012099','Jan 27 2020  5:48PM','Jan 27 2020  5:48PM','202012021',NULL,'','','202001271',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMEDICAVM2','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMEDICAVM2','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMEDICAVM2','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMEDICAVM2','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMEDICAVM2','SubSort2','C','drvSubSort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMEDICAVM2','SubSort3','C','drvSubSort3');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMEDICAVM2','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMEDICAVM2','Upper','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMEDICAVM2','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EMEDICAVM2' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EMEDICAVM2' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EMEDICAVM2_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EMEDICAVM2_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMEDICAVM2','H01','dbo.U_EMEDICAVM2_drvTblH01',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMEDICAVM2','D10','dbo.U_EMEDICAVM2_drvTblD10',NULL);
IF OBJECT_ID('U_EMEDICAVM2_File') IS NULL
CREATE TABLE [dbo].[U_EMEDICAVM2_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(1000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMEDICAVM2]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Volunteers of America Minnesota

Created By: Brian Jones
Business Analyst: Brian Jones
Create Date: 01/27/2020
Service Request Number: 

Purpose: Medica Enrollment Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EMEDICAVM2';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EMEDICAVM2';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EMEDICAVM2';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EMEDICAVM2';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EMEDICAVM2' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMEDICAVM2', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMEDICAVM2', 'ONTEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMEDICAVM2', 'SCHMEDCVM';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMEDICAVM2', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMEDICAVM2', 'OEACTIVE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EMEDICAVM2';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EMEDICAVM2', @AllObjects = 'N', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EMEDICAVM2';

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
    DELETE FROM dbo.U_EMEDICAVM2_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EMEDICAVM2_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EMEDICAVM2_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EMEDICAVM2_AuditFields;
    CREATE TABLE dbo.U_EMEDICAVM2_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_EMEDICAVM2_AuditFields VALUES ('EmpComp','EecDateOfTermination');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EMEDICAVM2_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EMEDICAVM2_Audit;
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
    INTO dbo.U_EMEDICAVM2_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EMEDICAVM2_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EMEDICAVM2_Audit ON dbo.U_EMEDICAVM2_Audit (audEEID,audKey2);

    --================
    -- Changes Only
    --================
    --DELETE FROM dbo.U_EMEDICAVM2_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EMEDICAVM2_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'PP45L,PP45G,HD45G,HD45L';

    IF OBJECT_ID('U_EMEDICAVM2_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EMEDICAVM2_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EMEDICAVM2_DedList
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
    EXEC dbo.dsi_bdm_sp_BuildConsolidatedTable 'EMEDICAVM2', 'Standard';
    --select * FROM dbo.U_dsi_BDM_EMEDICAVM2


    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EMEDICAVM2_drvTblD10
    ---------------------------------
    IF OBJECT_ID('U_EMEDICAVM2_drvTblD10','U') IS NOT NULL
        DROP TABLE dbo.U_EMEDICAVM2_drvTblD10;

--Employee
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = EepSSN
        ,drvSubSort = '1'
        ,drvSubSort2 = ''
        ,drvSubSort3 = ''
        -- standard fields above and additional driver fields below
        ,drvRelationshipCode = '18'
        ,drvEmployeeID = '00'+EepSSN
        ,drvMemberSocialSecurityNumber = '00'+EepSSN
        ,drvEmploymentDate = EecDateOfLastHire 
        ,drvMemberLastName = EepNameLast
        ,drvMemberFirstName = EepNameFirst
        ,drvMemberMiddleInitial = LEFT(EepNameMiddle,1)
        ,drvMemberBirthDate = EepDateOfBirth
        ,drvMemberGender = EepGender
        ,drvMemberMaritalStatus = EepMaritalStatus 
        ,drvPermanentStreetAddress1 = EepAddressLine1
        ,drvPermanentStreetAddress2 = EepAddressLine2
        ,drvPermanentCity = EepAddressCity
        ,drvPermanentState = EepAddressState
        ,drvPermanentZIPCode = EepAddressZipCode
        ,drvPermanentCountryCode = EepAddressCountry
        ,drvEmailAddress = EepAddressEMail
        ,drvWorkPhoneNumber = EecPhoneBusinessNumber
        ,drvHomePhoneNumber = EepPhoneHomeNumber
        ,drvDeathDate = CASE WHEN EecEmplStatus = 'T' and EecTermReason = '203' THEN EecDateOfTermination END
        ,drvDepartmentNumber = 'TBD'
        ,drvSubDepartmentNbr = 'TBD'
        ,drvRetirementDate = NULL 
        ,drvPrimaryCareClinic = ''
        ,drvCoverage1CoverageStartDate = BdmBenStartDate 
        ,drvCoverage1CoverageEndDate = BdmBenStopDate 
        ,drvCoverage1GroupNumber = CASE WHEN BdmDedCode IN ('PP45G','PP45L') THEN '37787' 
                                        WHEN BdmDedCode IN ('HD45L','HD45G') THEN '37788' END
        ,drvCoverage1Code = CASE WHEN BdmBenOption = 'EE' THEN '01' 
                                 WHEN BdmBenOption IN ('EE1','EE2') THEN '02' 
                                 WHEN BdmBenOption = 'EEF' THEN '04' END 
        ,drvAdultDependentFlag = 'A'
    INTO dbo.U_EMEDICAVM2_drvTblD10
    FROM dbo.U_EMEDICAVM2_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EMEDICAVM2 WITH (NOLOCK)        -- Select distinct bdmbenoption from U_dsi_BDM_EMEDICAVM2
        ON BdmEEID = xEEID 
        AND BdmCoID = xCOID
        AND BdmRecType = 'Emp'
    WHERE (EecEmplStatus <> 'T' or exists (Select 1 from dbo.U_EMEDICAVM2_Audit where xEEID = AudEEID and AudFieldName = 'EecDateOfTermination'))    
    AND EepNameLast <> 'Test'

    UNION 
    
--Dependent
  SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = EepSSN
        ,drvSubSort = CASE WHEN BdmRelationship = 'SPS' THEN '2' 
                            WHEN BdmRelationship = 'DP' THEN '2' 
                            ELSE '3'
                        END
        ,drvSubSort2 = ''
        ,drvSubSort3 = ''
        -- standard fields above and additional driver fields below
        ,drvRelationshipCode = CASE WHEN BdmRelationship = 'SPS' THEN '01' 
                                    WHEN BdmRelationship = 'CHL' THEN '19' 
                                    WHEN BdmRelationship = 'DP' THEN '53' END
        ,drvEmployeeID = '00'+ EepSSN
        ,drvMemberSocialSecurityNumber = '00' + ConSSN
        ,drvEmploymentDate = EecDateOfLastHire
        ,drvMemberLastName = ConNameLast
        ,drvMemberFirstName = ConNameFirst
        ,drvMemberMiddleInitial = LEFT(ConNameMiddle,1)
        ,drvMemberBirthDate = ConDateOfBirth
        ,drvMemberGender = ConGender
        ,drvMemberMaritalStatus = CASE WHEN BdmRelationship IN ('SPS','DP') THEN 'M'
                                    ELSE 'S' END
        ,drvPermanentStreetAddress1 = ConAddressLine1
        ,drvPermanentStreetAddress2 = ConAddressLine2
        ,drvPermanentCity = ConAddressCity
        ,drvPermanentState = ConAddressState
        ,drvPermanentZIPCode = ConAddressZipCode
        ,drvPermanentCountryCode = ConAddressCountry
        ,drvEmailAddress = ConEmailAddr   
        ,drvWorkPhoneNumber = EecPhoneBusinessNumber
        ,drvHomePhoneNumber = ConPhoneHomeNumber
        ,drvDeathDate = NULL
        ,drvDepartmentNumber = 'TBD'
        ,drvSubDepartmentNbr = 'TBD'
        ,drvRetirementDate = NULL
        ,drvPrimaryCareClinic = ''
        ,drvCoverage1CoverageStartDate = BdmBenStartDate
        ,drvCoverage1CoverageEndDate = BdmBenStopDate 
        ,drvCoverage1GroupNumber = CASE WHEN BdmDedCode IN ('PP45G','PP45L') THEN '37787' 
                                        WHEN BdmDedCode IN ('HD45L','HD45G') THEN '37788' END
        ,drvCoverage1Code = CASE WHEN BdmBenOption = 'EE' THEN '01' -- is this needed? would dependents be covered under employee only
                                 WHEN BdmBenOption IN ('EE1','EE2') THEN '02' 
                                 WHEN BdmBenOption = 'EEF' THEN '04' END
        ,drvAdultDependentFlag = CASE WHEN ConRelationship in ('SPS','DP') THEN 'A' ELSE 'D' END
    FROM dbo.U_EMEDICAVM2_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EMEDICAVM2 WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCOID
        AND BdmRecType = 'Dep'
    JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
    WHERE (EecEmplStatus <> 'T' or exists (Select 1 from dbo.U_EMEDICAVM2_Audit where xEEID = AudEEID and AudFieldName = 'EecDateOfTermination'))    
    AND EepNameLast <> 'Test'
        ;

    ---------------------------------
    -- Header RECORD - U_EMEDICAVM2_drvTblH01
    ---------------------------------
    IF OBJECT_ID('U_EMEDICAVM2_drvTblH01','U') IS NOT NULL
        DROP TABLE dbo.U_EMEDICAVM2_drvTblH01;

    SELECT 
         drvHeaderCount = count(1)
    INTO dbo.U_EMEDICAVM2_drvTblH01
    FROM dbo.U_EMEDICAVM2_drvTblD10

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = 'filename'
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEMEDICAVM2_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EMEDICAVM2_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EMEDICAVM2%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202001201'
       ,expStartPerControl     = '202001201'
       ,expLastEndPerControl   = '202001279'
       ,expEndPerControl       = '202001279'
WHERE expFormatCode = 'EMEDICAVM2';


**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEMEDICAVM2_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EMEDICAVM2_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort, SubSort2, SubSort3