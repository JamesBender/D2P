SET NOCOUNT ON;
IF OBJECT_ID('U_EMETPCRLIF_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EMETPCRLIF_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EMETPCRLIF_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EMETPCRLIF' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEMETPCRLIF_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEMETPCRLIF_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EMETPCRLIF') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMETPCRLIF];
GO
IF OBJECT_ID('U_EMETPCRLIF_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EMETPCRLIF_PDedHist];
GO
IF OBJECT_ID('U_EMETPCRLIF_File') IS NOT NULL DROP TABLE [dbo].[U_EMETPCRLIF_File];
GO
IF OBJECT_ID('U_EMETPCRLIF_EEList') IS NOT NULL DROP TABLE [dbo].[U_EMETPCRLIF_EEList];
GO
IF OBJECT_ID('U_EMETPCRLIF_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EMETPCRLIF_drvTbl];
GO
IF OBJECT_ID('U_EMETPCRLIF_DedList') IS NOT NULL DROP TABLE [dbo].[U_EMETPCRLIF_DedList];
GO
IF OBJECT_ID('U_EMETPCRLIF_coverage') IS NOT NULL DROP TABLE [dbo].[U_EMETPCRLIF_coverage];
GO
IF OBJECT_ID('U_EMETPCRLIF_Consolidated') IS NOT NULL DROP TABLE [dbo].[U_EMETPCRLIF_Consolidated];
GO
IF OBJECT_ID('U_EMETPCRLIF_branch') IS NOT NULL DROP TABLE [dbo].[U_EMETPCRLIF_branch];
GO
IF OBJECT_ID('U_EMETPCRLIF_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EMETPCRLIF_AuditFields];
GO
IF OBJECT_ID('U_EMETPCRLIF_Audit') IS NOT NULL DROP TABLE [dbo].[U_EMETPCRLIF_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EMETPCRLIF') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EMETPCRLIF];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EMETPCRLIF';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EMETPCRLIF';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EMETPCRLIF';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EMETPCRLIF';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EMETPCRLIF';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EMETPCRLIF','Metlife Life Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','3000','S','N','EMETPCRLIFZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EMETPCRLIF' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTransactionCode"','1','(''UA''=''F'')','EMETPCRLIFZ0','1','D','10','1',NULL,'Transaction Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustomerNumber"','2','(''UA''=''F'')','EMETPCRLIFZ0','7','D','10','2',NULL,'Customer Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeNumber"','3','(''UA''=''F'')','EMETPCRLIFZ0','11','D','10','3',NULL,'Employee Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','4','(''DA''=''F'')','EMETPCRLIFZ0','11','D','10','4',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemberSocialSecurityNumber"','5','(''UA''=''F'')','EMETPCRLIFZ0','9','D','10','5',NULL,'Member Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemberLastName"','6','(''UA''=''F'')','EMETPCRLIFZ0','20','D','10','6',NULL,'Member Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemberFirstName"','7','(''UA''=''F'')','EMETPCRLIFZ0','12','D','10','7',NULL,'Member First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemberMiddleInitial"','8','(''UA''=''F'')','EMETPCRLIFZ0','1','D','10','8',NULL,'Member Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemberDateofBirth"','9','(''UDMDY''=''F'')','EMETPCRLIFZ0','8','D','10','9',NULL,'Member Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemberMaritalStatus"','10','(''UA''=''F'')','EMETPCRLIFZ0','1','D','10','10',NULL,'Member Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemberGender"','11','(''UA''=''F'')','EMETPCRLIFZ0','1','D','10','11',NULL,'Member Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelationshipCode"','12','(''UA''=''F'')','EMETPCRLIFZ0','2','D','10','12',NULL,'Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeesDateofHire"','13','(''UDMDY''=''F'')','EMETPCRLIFZ0','8','D','10','13',NULL,'Employee''s Date of Hire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPersonnelIdentification"','14','(''UA''=''F'')','EMETPCRLIFZ0','11','D','10','14',NULL,'Personnel Identification',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeSmokerCode"','15','(''UA''=''F'')','EMETPCRLIFZ0','1','D','10','15',NULL,'Employee Smoker Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseSmokerCode"','16','(''UA''=''F'')','EMETPCRLIFZ0','1','D','10','16',NULL,'Spouse Smoker Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneNumber"','17','(''UA''=''F'')','EMETPCRLIFZ0','10','D','10','17',NULL,'Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmailAddress"','18','(''UA''=''F'')','EMETPCRLIFZ0','40','D','10','18',NULL,'Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','19','(''DA''=''F'')','EMETPCRLIFZ0','14','D','10','19',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvForeignAddressIndicator"','20','(''UA''=''F'')','EMETPCRLIFZ0','1','D','10','20',NULL,'Foreign Address Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCareofAddress"','21','(''UA''=''F'')','EMETPCRLIFZ0','32','D','10','21',NULL,'Care of Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStreetAddress"','22','(''UA''=''F'')','EMETPCRLIFZ0','32','D','10','22',NULL,'Street Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','23','(''UA''=''F'')','EMETPCRLIFZ0','21','D','10','23',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','24','(''UA''=''F'')','EMETPCRLIFZ0','2','D','10','24',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZipCode"','25','(''UA''=''F'')','EMETPCRLIFZ0','9','D','10','25',NULL,'Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageCode1"','26','(''UA''=''F'')','EMETPCRLIFZ0','2','D','10','26',NULL,'Coverage Code - 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageStartDate1"','27','(''UDMDY''=''F'')','EMETPCRLIFZ0','8','D','10','27',NULL,'Coverage Start Date - 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageStopDate1"','28','(''UDMDY''=''F'')','EMETPCRLIFZ0','8','D','10','28',NULL,'Coverage Stop Date - 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGroupNumber1"','29','(''UA''=''F'')','EMETPCRLIFZ0','7','D','10','29',NULL,'Group Number - 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubcode1"','30','(''UA''=''F'')','EMETPCRLIFZ0','4','D','10','30',NULL,'Subcode - 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBranch1"','31','(''UA''=''F'')','EMETPCRLIFZ0','4','D','10','31',NULL,'Branch - 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCode1"','32','(''UA''=''F'')','EMETPCRLIFZ0','2','D','10','32',NULL,'Plan Code - 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatusCode1"','33','(''UA''=''F'')','EMETPCRLIFZ0','1','D','10','33',NULL,'Status Code - 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMembersCoveredCode1"','34','(''UA''=''F'')','EMETPCRLIFZ0','1','D','10','34',NULL,'Members Covered Code - 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCancelReason1"','35','(''UA''=''F'')','EMETPCRLIFZ0','2','D','10','35',NULL,'Cancel Reason - 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','36','(''DA''=''F'')','EMETPCRLIFZ0','1','D','10','36',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFacilityID"','37','(''UA''=''F'')','EMETPCRLIFZ0','8','D','10','37',NULL,'Facility ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','38','(''DA''=''F'')','EMETPCRLIFZ0','15','D','10','38',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','39','(''DA''=''F'')','EMETPCRLIFZ0','2','D','10','39',NULL,'Coverage Code - 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','40','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','40',NULL,'Coverage Start Date - 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','41','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','41',NULL,'Coverage Stop Date - 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','42','(''DA''=''F'')','EMETPCRLIFZ0','7','D','10','42',NULL,'Group Number - 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','43','(''DA''=''F'')','EMETPCRLIFZ0','4','D','10','43',NULL,'Subcode - 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','44','(''DA''=''F'')','EMETPCRLIFZ0','4','D','10','44',NULL,'Branch - 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','45','(''DA''=''F'')','EMETPCRLIFZ0','2','D','10','45',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','46','(''DA''=''F'')','EMETPCRLIFZ0','1','D','10','46',NULL,'Status Code - 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','47','(''DA''=''F'')','EMETPCRLIFZ0','1','D','10','47',NULL,'Members Covered Code - 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','48','(''DA''=''F'')','EMETPCRLIFZ0','10','D','10','48',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','49','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','49',NULL,'Annual Benefit Amount - 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','50','(''DA''=''F'')','EMETPCRLIFZ0','1','D','10','50',NULL,'Salary Mode - 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','51','(''DA''=''F'')','EMETPCRLIFZ0','7','D','10','51',NULL,'Salary Amount - 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','52','(''DA''=''F'')','EMETPCRLIFZ0','2','D','10','52',NULL,'Coverage Code - 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','53','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','53',NULL,'Coverage Start Date - 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','54','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','54',NULL,'Coverage Stop Date - 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','55','(''DA''=''F'')','EMETPCRLIFZ0','7','D','10','55',NULL,'Group Number - 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','56','(''DA''=''F'')','EMETPCRLIFZ0','4','D','10','56',NULL,'Subcode - 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','57','(''DA''=''F'')','EMETPCRLIFZ0','4','D','10','57',NULL,'Branch - 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','58','(''DA''=''F'')','EMETPCRLIFZ0','2','D','10','58',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','59','(''DA''=''F'')','EMETPCRLIFZ0','1','D','10','59',NULL,'Status Code - 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','60','(''DA''=''F'')','EMETPCRLIFZ0','1','D','10','60',NULL,'Members Covered Code - 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','61','(''DA''=''F'')','EMETPCRLIFZ0','10','D','10','61',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','62','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','62',NULL,'Annual Benefit Amount - 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','63','(''DA''=''F'')','EMETPCRLIFZ0','1','D','10','63',NULL,'Salary Mode - 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','64','(''DA''=''F'')','EMETPCRLIFZ0','7','D','10','64',NULL,'Salary Amount - 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','65','(''DA''=''F'')','EMETPCRLIFZ0','2','D','10','65',NULL,'Coverage Code - 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','66','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','66',NULL,'Coverage Start Date - 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','67','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','67',NULL,'Coverage Stop Date - 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','68','(''DA''=''F'')','EMETPCRLIFZ0','7','D','10','68',NULL,'Group Number - 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','69','(''DA''=''F'')','EMETPCRLIFZ0','4','D','10','69',NULL,'Subcode - 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','70','(''DA''=''F'')','EMETPCRLIFZ0','4','D','10','70',NULL,'Branch - 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','71','(''DA''=''F'')','EMETPCRLIFZ0','2','D','10','71',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','72','(''DA''=''F'')','EMETPCRLIFZ0','1','D','10','72',NULL,'Status Code - 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','73','(''DA''=''F'')','EMETPCRLIFZ0','1','D','10','73',NULL,'Members Covered Code - 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','74','(''DA''=''F'')','EMETPCRLIFZ0','10','D','10','74',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','75','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','75',NULL,'Monthly Benefit Amount - 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','76','(''DA''=''F'')','EMETPCRLIFZ0','1','D','10','76',NULL,'Salary Mode - 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','77','(''DA''=''F'')','EMETPCRLIFZ0','7','D','10','77',NULL,'Salary Amount - 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','78','(''DA''=''F'')','EMETPCRLIFZ0','2','D','10','78',NULL,'Coverage Code - 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','79','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','79',NULL,'Coverage Start Date - 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','80','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','80',NULL,'Coverage Stop Date - 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','81','(''DA''=''F'')','EMETPCRLIFZ0','7','D','10','81',NULL,'Group Number - 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','82','(''DA''=''F'')','EMETPCRLIFZ0','4','D','10','82',NULL,'Subcode - 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','83','(''DA''=''F'')','EMETPCRLIFZ0','4','D','10','83',NULL,'Branch - 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','84','(''DA''=''F'')','EMETPCRLIFZ0','2','D','10','84',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','85','(''DA''=''F'')','EMETPCRLIFZ0','1','D','10','85',NULL,'Status Code - 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','86','(''DA''=''F'')','EMETPCRLIFZ0','1','D','10','86',NULL,'Members Covered Code - 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','87','(''DA''=''F'')','EMETPCRLIFZ0','10','D','10','87',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','88','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','88',NULL,'Weekly Benefit Amount - 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','89','(''DA''=''F'')','EMETPCRLIFZ0','1','D','10','89',NULL,'Salary Mode - 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','90','(''DA''=''F'')','EMETPCRLIFZ0','7','D','10','90',NULL,'Salary Amount - 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','91','(''DA''=''F'')','EMETPCRLIFZ0','2','D','10','91',NULL,'Coverage Code - 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','92','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','92',NULL,'Coverage Start Date - 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','93','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','93',NULL,'Coverage Stop Date - 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','94','(''DA''=''F'')','EMETPCRLIFZ0','7','D','10','94',NULL,'Group Number - 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','95','(''DA''=''F'')','EMETPCRLIFZ0','4','D','10','95',NULL,'Subcode - 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','96','(''DA''=''F'')','EMETPCRLIFZ0','4','D','10','96',NULL,'Branch - 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','97','(''DA''=''F'')','EMETPCRLIFZ0','2','D','10','97',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','98','(''DA''=''F'')','EMETPCRLIFZ0','1','D','10','98',NULL,'Status Code - 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','99','(''DA''=''F'')','EMETPCRLIFZ0','1','D','10','99',NULL,'Members Covered Code - 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','100','(''DA''=''F'')','EMETPCRLIFZ0','10','D','10','100',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','101','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','101',NULL,'Annual Benefit Amount - 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','102','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','102',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','103','(''DA''=''F'')','EMETPCRLIFZ0','2','D','10','103',NULL,'Coverage Code - 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','104','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','104',NULL,'Coverage Start Date - 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','105','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','105',NULL,'Coverage Stop Date - 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','106','(''DA''=''F'')','EMETPCRLIFZ0','7','D','10','106',NULL,'Group Number - 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','107','(''DA''=''F'')','EMETPCRLIFZ0','4','D','10','107',NULL,'Subcode - 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','108','(''DA''=''F'')','EMETPCRLIFZ0','4','D','10','108',NULL,'Branch - 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','109','(''DA''=''F'')','EMETPCRLIFZ0','2','D','10','109',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','110','(''DA''=''F'')','EMETPCRLIFZ0','1','D','10','110',NULL,'Status Code - 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','111','(''DA''=''F'')','EMETPCRLIFZ0','1','D','10','111',NULL,'Members Covered Code - 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','112','(''DA''=''F'')','EMETPCRLIFZ0','10','D','10','112',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','113','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','113',NULL,'Annual Benefit Amount - 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','114','(''DA''=''F'')','EMETPCRLIFZ0','1','D','10','114',NULL,'Salary Mode - 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','115','(''DA''=''F'')','EMETPCRLIFZ0','7','D','10','115',NULL,'Salary Amount - 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','116','(''DA''=''F'')','EMETPCRLIFZ0','2','D','10','116',NULL,'Coverage Code - 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','117','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','117',NULL,'Coverage Start Date - 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','118','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','118',NULL,'Coverage Stop Date - 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','119','(''DA''=''F'')','EMETPCRLIFZ0','7','D','10','119',NULL,'Group Number - 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','120','(''DA''=''F'')','EMETPCRLIFZ0','4','D','10','120',NULL,'Subcode - 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','121','(''DA''=''F'')','EMETPCRLIFZ0','4','D','10','121',NULL,'Branch - 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','122','(''DA''=''F'')','EMETPCRLIFZ0','2','D','10','122',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','123','(''DA''=''F'')','EMETPCRLIFZ0','1','D','10','123',NULL,'Status Code - 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','124','(''DA''=''F'')','EMETPCRLIFZ0','1','D','10','124',NULL,'Members Covered Code - 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','125','(''DA''=''F'')','EMETPCRLIFZ0','10','D','10','125',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','126','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','126',NULL,'Annual Benefit Amount - 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','127','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','127',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','128','(''DA''=''F'')','EMETPCRLIFZ0','2','D','10','128',NULL,'Coverage Code - 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','129','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','129',NULL,'Coverage Start Date - 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','130','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','130',NULL,'Coverage Stop Date - 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','131','(''DA''=''F'')','EMETPCRLIFZ0','7','D','10','131',NULL,'Group Number - 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','132','(''DA''=''F'')','EMETPCRLIFZ0','4','D','10','132',NULL,'Subcode - 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','133','(''DA''=''F'')','EMETPCRLIFZ0','4','D','10','133',NULL,'Branch - 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','134','(''DA''=''F'')','EMETPCRLIFZ0','2','D','10','134',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','135','(''DA''=''F'')','EMETPCRLIFZ0','1','D','10','135',NULL,'Status Code - 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','136','(''DA''=''F'')','EMETPCRLIFZ0','1','D','10','136',NULL,'Members Covered Code - 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','137','(''DA''=''F'')','EMETPCRLIFZ0','10','D','10','137',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','138','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','138',NULL,'Annual Benefit Amount - 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','139','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','139',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','140','(''DA''=''F'')','EMETPCRLIFZ0','2','D','10','140',NULL,'Coverage Code - 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','141','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','141',NULL,'Coverage Start Date - 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','142','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','142',NULL,'Coverage Stop Date - 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','143','(''DA''=''F'')','EMETPCRLIFZ0','7','D','10','143',NULL,'Group Number - 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','144','(''DA''=''F'')','EMETPCRLIFZ0','4','D','10','144',NULL,'Subcode - 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','145','(''DA''=''F'')','EMETPCRLIFZ0','4','D','10','145',NULL,'Branch - 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','146','(''DA''=''F'')','EMETPCRLIFZ0','2','D','10','146',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','147','(''DA''=''F'')','EMETPCRLIFZ0','1','D','10','147',NULL,'Status Code - 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','148','(''DA''=''F'')','EMETPCRLIFZ0','1','D','10','148',NULL,'Members Covered Code - 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','149','(''DA''=''F'')','EMETPCRLIFZ0','10','D','10','149',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','150','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','150',NULL,'Annual Benefit Amount - 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','151','(''DA''=''F'')','EMETPCRLIFZ0','1','D','10','151',NULL,'Salary Mode - 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','152','(''DA''=''F'')','EMETPCRLIFZ0','7','D','10','152',NULL,'Salary Amount - 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','153','(''DA''=''F'')','EMETPCRLIFZ0','2','D','10','153',NULL,'Coverage Code - 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','154','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','154',NULL,'Coverage Start Date - 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','155','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','155',NULL,'Coverage Stop Date - 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','156','(''DA''=''F'')','EMETPCRLIFZ0','7','D','10','156',NULL,'Group Number - 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','157','(''DA''=''F'')','EMETPCRLIFZ0','4','D','10','157',NULL,'Subcode - 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','158','(''DA''=''F'')','EMETPCRLIFZ0','4','D','10','158',NULL,'Branch - 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','159','(''DA''=''F'')','EMETPCRLIFZ0','2','D','10','159',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','160','(''DA''=''F'')','EMETPCRLIFZ0','1','D','10','160',NULL,'Status Code - 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','161','(''DA''=''F'')','EMETPCRLIFZ0','1','D','10','161',NULL,'Members Covered Code - 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','162','(''DA''=''F'')','EMETPCRLIFZ0','10','D','10','162',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','163','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','163',NULL,'Annual Benefit Amount - 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','164','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','164',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','165','(''DA''=''F'')','EMETPCRLIFZ0','2','D','10','165',NULL,'Coverage Code - 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','166','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','166',NULL,'Coverage Start Date - 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','167','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','167',NULL,'Coverage Stop Date - 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','168','(''DA''=''F'')','EMETPCRLIFZ0','7','D','10','168',NULL,'Group Number - 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','169','(''DA''=''F'')','EMETPCRLIFZ0','4','D','10','169',NULL,'Subcode - 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','170','(''DA''=''F'')','EMETPCRLIFZ0','4','D','10','170',NULL,'Branch - 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','171','(''DA''=''F'')','EMETPCRLIFZ0','2','D','10','171',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','172','(''DA''=''F'')','EMETPCRLIFZ0','1','D','10','172',NULL,'Status Code - 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','173','(''DA''=''F'')','EMETPCRLIFZ0','1','D','10','173',NULL,'Members Covered Code - 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','174','(''DA''=''F'')','EMETPCRLIFZ0','10','D','10','174',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','175','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','175',NULL,'Annual Benefit Amount - 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','176','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','176',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','177','(''DA''=''F'')','EMETPCRLIFZ0','2','D','10','177',NULL,'Coverage Code - 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','178','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','178',NULL,'Coverage Start Date - 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','179','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','179',NULL,'Coverage Stop Date - 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','180','(''DA''=''F'')','EMETPCRLIFZ0','7','D','10','180',NULL,'Group Number - 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','181','(''DA''=''F'')','EMETPCRLIFZ0','4','D','10','181',NULL,'Subcode - 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','182','(''DA''=''F'')','EMETPCRLIFZ0','4','D','10','182',NULL,'Branch - 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','183','(''DA''=''F'')','EMETPCRLIFZ0','2','D','10','183',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','184','(''DA''=''F'')','EMETPCRLIFZ0','1','D','10','184',NULL,'Status Code - 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','185','(''DA''=''F'')','EMETPCRLIFZ0','1','D','10','185',NULL,'Members Covered Code - 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','186','(''DA''=''F'')','EMETPCRLIFZ0','10','D','10','186',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','187','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','187',NULL,'Annual Benefit Amount - 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','188','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','188',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','189','(''DA''=''F'')','EMETPCRLIFZ0','2','D','10','189',NULL,'Coverage Code - 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','190','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','190',NULL,'Coverage Start Date - 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','191','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','191',NULL,'Coverage Stop Date - 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','192','(''DA''=''F'')','EMETPCRLIFZ0','7','D','10','192',NULL,'Group Number - 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','193','(''DA''=''F'')','EMETPCRLIFZ0','4','D','10','193',NULL,'Subcode - 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','194','(''DA''=''F'')','EMETPCRLIFZ0','4','D','10','194',NULL,'Branch - 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','195','(''DA''=''F'')','EMETPCRLIFZ0','2','D','10','195',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','196','(''DA''=''F'')','EMETPCRLIFZ0','1','D','10','196',NULL,'Status Code - 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','197','(''DA''=''F'')','EMETPCRLIFZ0','1','D','10','197',NULL,'Members Covered Code - 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','198','(''DA''=''F'')','EMETPCRLIFZ0','10','D','10','198',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','199','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','199',NULL,'Annual Benefit Amount - 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','200','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','200',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','201','(''DA''=''F'')','EMETPCRLIFZ0','2','D','10','201',NULL,'Coverage Code - 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','202','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','202',NULL,'Coverage Start Date - 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','203','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','203',NULL,'Coverage Stop Date - 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','204','(''DA''=''F'')','EMETPCRLIFZ0','7','D','10','204',NULL,'Group Number - 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','205','(''DA''=''F'')','EMETPCRLIFZ0','4','D','10','205',NULL,'Subcode - 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','206','(''DA''=''F'')','EMETPCRLIFZ0','4','D','10','206',NULL,'Branch - 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','207','(''DA''=''F'')','EMETPCRLIFZ0','2','D','10','207',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','208','(''DA''=''F'')','EMETPCRLIFZ0','1','D','10','208',NULL,'Status Code - 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','209','(''DA''=''F'')','EMETPCRLIFZ0','1','D','10','209',NULL,'Members Covered Code - 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','210','(''DA''=''F'')','EMETPCRLIFZ0','10','D','10','210',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','211','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','211',NULL,'Annual Benefit Amount - 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','212','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','212',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','213','(''DA''=''F'')','EMETPCRLIFZ0','2','D','10','213',NULL,'Coverage Code - 16',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','214','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','214',NULL,'Coverage Start Date - 16',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','215','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','215',NULL,'Coverage Stop Date - 16',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','216','(''DA''=''F'')','EMETPCRLIFZ0','7','D','10','216',NULL,'Group Number - 16',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','217','(''DA''=''F'')','EMETPCRLIFZ0','4','D','10','217',NULL,'Subcode - 16',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','218','(''DA''=''F'')','EMETPCRLIFZ0','4','D','10','218',NULL,'Branch - 16',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','219','(''DA''=''F'')','EMETPCRLIFZ0','2','D','10','219',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','220','(''DA''=''F'')','EMETPCRLIFZ0','1','D','10','220',NULL,'Status Code - 16',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','221','(''DA''=''F'')','EMETPCRLIFZ0','1','D','10','221',NULL,'Members Covered Code - 16',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','222','(''DA''=''F'')','EMETPCRLIFZ0','10','D','10','222',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','223','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','223',NULL,'Annual Benefit Amount - 16',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','224','(''DA''=''F'')','EMETPCRLIFZ0','12','D','10','224',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageCode17"','225','(''UA''=''F'')','EMETPCRLIFZ0','2','D','10','225',NULL,'Coverage Code - 17',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageStartDate17"','226','(''UDMDY''=''F'')','EMETPCRLIFZ0','8','D','10','226',NULL,'Coverage Start Date - 17',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageStopDate17"','227','(''UDMDY''=''F'')','EMETPCRLIFZ0','8','D','10','227',NULL,'Coverage Stop Date - 17',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGroupNumber17"','228','(''UA''=''F'')','EMETPCRLIFZ0','7','D','10','228',NULL,'Group Number - 17',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubCode17"','229','(''UA''=''F'')','EMETPCRLIFZ0','4','D','10','229',NULL,'Subcode - 17',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBranch17"','230','(''UA''=''F'')','EMETPCRLIFZ0','4','D','10','230',NULL,'Branch - 17',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','231','(''DA''=''F'')','EMETPCRLIFZ0','2','D','10','231',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrollmentStatus17"','232','(''UA''=''F'')','EMETPCRLIFZ0','1','D','10','232',NULL,'Status Code - 17',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMembersCoveredCode17"','233','(''UA''=''F'')','EMETPCRLIFZ0','1','D','10','233',NULL,'Members Covered Code - 17',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','234','(''DA''=''F'')','EMETPCRLIFZ0','2','D','10','234',NULL,'Cancel Reason - 17',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','235','(''DA''=''F'')','EMETPCRLIFZ0','23','D','10','235',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeStatusCode"','236','(''UA''=''F'')','EMETPCRLIFZ0','1','D','10','236',NULL,'Employee Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatusCodeEffectiveDate"','237','(''UDMDY''=''F'')','EMETPCRLIFZ0','8','D','10','237',NULL,'Status Code Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepartmentCode"','238','(''UA''=''F'')','EMETPCRLIFZ0','10','D','10','238',NULL,'Department Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGroupID"','239','(''UA''=''F'')','EMETPCRLIFZ0','10','D','10','239',NULL,'Group ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLocationID"','240','(''UA''=''F'')','EMETPCRLIFZ0','5','D','10','240',NULL,'Location ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvScheduleID"','241','(''UA''=''F'')','EMETPCRLIFZ0','10','D','10','241',NULL,'Schedule ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayFrequency"','242','(''UA''=''F'')','EMETPCRLIFZ0','2','D','10','242',NULL,'Pay Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','243','(''DA''=''F'')','EMETPCRLIFZ0','2','D','10','243',NULL,'Coverage Code - 18',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','244','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','244',NULL,'Coverage Start Date - 18',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','245','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','245',NULL,'Coverage Stop Date - 18',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','246','(''DA''=''F'')','EMETPCRLIFZ0','7','D','10','246',NULL,'Group Number - 18',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','247','(''DA''=''F'')','EMETPCRLIFZ0','4','D','10','247',NULL,'Subcode - 18',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','248','(''DA''=''F'')','EMETPCRLIFZ0','4','D','10','248',NULL,'Branch - 18',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','249','(''DA''=''F'')','EMETPCRLIFZ0','1','D','10','249',NULL,'Status Code - 18',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','250','(''DA''=''F'')','EMETPCRLIFZ0','1','D','10','250',NULL,'Members Covered Code - 18',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','251','(''DA''=''F'')','EMETPCRLIFZ0','1','D','10','251',NULL,'Enrollment Status - 18',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageCode19"','252','(''UA''=''F'')','EMETPCRLIFZ0','2','D','10','252',NULL,'Coverage Code - 19',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageStartDate19"','253','(''UDMDY''=''F'')','EMETPCRLIFZ0','8','D','10','253',NULL,'Coverage Start Date - 19',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageStopDate19"','254','(''UDMDY''=''F'')','EMETPCRLIFZ0','8','D','10','254',NULL,'Coverage Stop Date - 19',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGroupNumber19"','255','(''UA''=''F'')','EMETPCRLIFZ0','7','D','10','255',NULL,'Group Number - 19',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubcode19"','256','(''UA''=''F'')','EMETPCRLIFZ0','4','D','10','256',NULL,'Subcode - 19',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBranch19"','257','(''UA''=''F'')','EMETPCRLIFZ0','4','D','10','257',NULL,'Branch - 19',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMembersCoveredCode19"','258','(''UA''=''F'')','EMETPCRLIFZ0','1','D','10','258',NULL,'Members Covered Code - 19',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrollmentStatus19"','259','(''UA''=''F'')','EMETPCRLIFZ0','1','D','10','259',NULL,'Enrollment Status - 19',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitAmount19"','260','(''UA''=''F'')','EMETPCRLIFZ0','8','D','10','260',NULL,'Benefit Amount - 19',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVoluntaryCancellationInd19"','261','(''UA''=''F'')','EMETPCRLIFZ0','2','D','10','261',NULL,'Voluntary Cancellation Ind - 19',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTaveoverIndicator19"','262','(''UA''=''F'')','EMETPCRLIFZ0','1','D','10','262',NULL,'Taveover Indicator - 19',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','263','(''DA''=''F'')','EMETPCRLIFZ0','9','D','10','263',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageCode20"','264','(''UA''=''F'')','EMETPCRLIFZ0','2','D','10','264',NULL,'Coverage Code - 20',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageStartDate20"','265','(''UDMDY''=''F'')','EMETPCRLIFZ0','8','D','10','265',NULL,'Coverage Start Date - 20',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageStopDate20"','266','(''UDMDY''=''F'')','EMETPCRLIFZ0','8','D','10','266',NULL,'Coverage Stop Date - 20',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGroupNumber20"','267','(''UA''=''F'')','EMETPCRLIFZ0','7','D','10','267',NULL,'Group Number - 20',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubcode20"','268','(''UA''=''F'')','EMETPCRLIFZ0','4','D','10','268',NULL,'Subcode - 20',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBranch20"','269','(''UA''=''F'')','EMETPCRLIFZ0','4','D','10','269',NULL,'Branch - 20',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMembersCoveredCode20"','270','(''UA''=''F'')','EMETPCRLIFZ0','1','D','10','270',NULL,'Members Covered Code - 20',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrollmentStatus20"','271','(''UA''=''F'')','EMETPCRLIFZ0','1','D','10','271',NULL,'Enrollment Status - 20',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitAmount20"','272','(''UA''=''F'')','EMETPCRLIFZ0','8','D','10','272',NULL,'Benefit Amount - 20',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVoluntaryCancellationInd20"','273','(''UA''=''F'')','EMETPCRLIFZ0','2','D','10','273',NULL,'Voluntary Cancellation Ind - 20',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','274','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','274',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','275','(''DA''=''F'')','EMETPCRLIFZ0','2','D','10','275',NULL,'Coverage Code - 21',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','276','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','276',NULL,'Coverage Start Date - 21',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','277','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','277',NULL,'Coverage Stop Date - 21',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','278','(''DA''=''F'')','EMETPCRLIFZ0','7','D','10','278',NULL,'Group Number - 21',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','279','(''DA''=''F'')','EMETPCRLIFZ0','4','D','10','279',NULL,'Subcode - 21',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','280','(''DA''=''F'')','EMETPCRLIFZ0','4','D','10','280',NULL,'Branch - 21',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','281','(''DA''=''F'')','EMETPCRLIFZ0','1','D','10','281',NULL,'Members Covered Code - 21',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','282','(''DA''=''F'')','EMETPCRLIFZ0','1','D','10','282',NULL,'Enrollment Status - 21',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','283','(''DA''=''F'')','EMETPCRLIFZ0','3','D','10','283',NULL,'GPC Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','284','(''DA''=''F'')','EMETPCRLIFZ0','2','D','10','284',NULL,'Paypoint',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','285','(''DA''=''F'')','EMETPCRLIFZ0','3','D','10','285',NULL,'Payroll Deduction',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','286','(''DA''=''F'')','EMETPCRLIFZ0','2','D','10','286',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','287','(''DA''=''F'')','EMETPCRLIFZ0','2','D','10','287',NULL,'Coverage Code - 22',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','288','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','288',NULL,'Coverage Start Date - 22',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','289','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','289',NULL,'Coverage Stop Date - 22',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','290','(''DA''=''F'')','EMETPCRLIFZ0','7','D','10','290',NULL,'Group Number - 22',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','291','(''DA''=''F'')','EMETPCRLIFZ0','4','D','10','291',NULL,'Subcode - 22',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','292','(''DA''=''F'')','EMETPCRLIFZ0','4','D','10','292',NULL,'Branch - 22',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','293','(''DA''=''F'')','EMETPCRLIFZ0','1','D','10','293',NULL,'Members Covered Code - 22',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','294','(''DA''=''F'')','EMETPCRLIFZ0','1','D','10','294',NULL,'Enrollment Status - 22',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','295','(''DA''=''F'')','EMETPCRLIFZ0','2','D','10','295',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageCode23"','296','(''UA''=''F'')','EMETPCRLIFZ0','2','D','10','296',NULL,'Coverage Code - 23',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageStartDate23"','297','(''UDMDY''=''F'')','EMETPCRLIFZ0','8','D','10','297',NULL,'Coverage Start Date - 23',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageStopDate23"','298','(''UDMDY''=''F'')','EMETPCRLIFZ0','8','D','10','298',NULL,'Coverage Stop Date - 23',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGroupNumber23"','299','(''UA''=''F'')','EMETPCRLIFZ0','7','D','10','299',NULL,'Group Number - 23',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubcode23"','300','(''UA''=''F'')','EMETPCRLIFZ0','4','D','10','300',NULL,'Subcode - 23',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBranch23"','301','(''UA''=''F'')','EMETPCRLIFZ0','4','D','10','301',NULL,'Branch - 23',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMembersCoveredCode23"','302','(''UA''=''F'')','EMETPCRLIFZ0','1','D','10','302',NULL,'Members Covered Code - 23',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrollmentStatus23"','303','(''UA''=''F'')','EMETPCRLIFZ0','1','D','10','303',NULL,'Enrollment Status - 23',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVoluntaryCancellationInd23"','304','(''UA''=''F'')','EMETPCRLIFZ0','2','D','10','304',NULL,'Voluntary Cancellation Ind - 23',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTakeoverIndicator23"','305','(''UA''=''F'')','EMETPCRLIFZ0','1','D','10','305',NULL,'Takeover Indicator - 23',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','306','(''DA''=''F'')','EMETPCRLIFZ0','9','D','10','306',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageCode24"','307','(''UA''=''F'')','EMETPCRLIFZ0','2','D','10','307',NULL,'Coverage Code - 24',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageStartDate24"','308','(''UDMDY''=''F'')','EMETPCRLIFZ0','8','D','10','308',NULL,'Coverage Start Date - 24',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageStopDate24"','309','(''UDMDY''=''F'')','EMETPCRLIFZ0','8','D','10','309',NULL,'Coverage Stop Date - 24',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGroupNumber24"','310','(''UA''=''F'')','EMETPCRLIFZ0','7','D','10','310',NULL,'Group Number - 24',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubcode24"','311','(''UA''=''F'')','EMETPCRLIFZ0','4','D','10','311',NULL,'Subcode - 24',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBranch24"','312','(''UA''=''F'')','EMETPCRLIFZ0','4','D','10','312',NULL,'Branch - 24',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMembersCoveredCode24"','313','(''UA''=''F'')','EMETPCRLIFZ0','1','D','10','313',NULL,'Members Covered Code - 24',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrollmentStatus24"','314','(''UA''=''F'')','EMETPCRLIFZ0','1','D','10','314',NULL,'Enrollment Status - 24',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVoluntaryCancellationInd24"','315','(''UA''=''F'')','EMETPCRLIFZ0','2','D','10','315',NULL,'Voluntary Cancellation Ind - 24',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTakeoverIndicator24"','316','(''UA''=''F'')','EMETPCRLIFZ0','1','D','10','316',NULL,'Takeover Indicator - 24',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','317','(''DA''=''F'')','EMETPCRLIFZ0','9','D','10','317',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','318','(''DA''=''F'')','EMETPCRLIFZ0','2','D','10','318',NULL,'Coverage Code - 25',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','319','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','319',NULL,'Coverage Start Date - 25',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','320','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','320',NULL,'Coverage Stop Date - 25',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','321','(''DA''=''F'')','EMETPCRLIFZ0','7','D','10','321',NULL,'Group Number - 25',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','322','(''DA''=''F'')','EMETPCRLIFZ0','4','D','10','322',NULL,'Subcode - 25',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','323','(''DA''=''F'')','EMETPCRLIFZ0','4','D','10','323',NULL,'Branch - 25',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','324','(''DA''=''F'')','EMETPCRLIFZ0','1','D','10','324',NULL,'Members Covered Code - 25',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','325','(''DA''=''F'')','EMETPCRLIFZ0','1','D','10','325',NULL,'Enrollment Status - 25',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','326','(''DA''=''F'')','EMETPCRLIFZ0','10','D','10','326',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','327','(''DA''=''F'')','EMETPCRLIFZ0','95','D','10','327',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','328','(''DA''=''F'')','EMETPCRLIFZ0','2','D','10','328',NULL,'Coverage Code - 27',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','329','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','329',NULL,'Coverage Start Date - 27',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','330','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','330',NULL,'Coverage Stop Date - 27',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','331','(''DA''=''F'')','EMETPCRLIFZ0','7','D','10','331',NULL,'Group Number - 27',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','332','(''DA''=''F'')','EMETPCRLIFZ0','4','D','10','332',NULL,'Subcode - 27',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','333','(''DA''=''F'')','EMETPCRLIFZ0','4','D','10','333',NULL,'Branch - 27',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','334','(''DA''=''F'')','EMETPCRLIFZ0','1','D','10','334',NULL,'Status Code - 27',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','335','(''DA''=''F'')','EMETPCRLIFZ0','1','D','10','335',NULL,'Members Covered Code - 27',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','336','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','336',NULL,'Benefit Amount - 27',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','337','(''DA''=''F'')','EMETPCRLIFZ0','1','D','10','337',NULL,'Takeover Indicator - 27',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','338','(''DA''=''F'')','EMETPCRLIFZ0','10','D','10','338',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','339','(''DA''=''F'')','EMETPCRLIFZ0','2','D','10','339',NULL,'Coverage Code - 28',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','340','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','340',NULL,'Coverage Start Date - 28',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','341','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','341',NULL,'Coverage Stop Date - 28',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','342','(''DA''=''F'')','EMETPCRLIFZ0','7','D','10','342',NULL,'Group Number - 28',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','343','(''DA''=''F'')','EMETPCRLIFZ0','4','D','10','343',NULL,'Subcode - 28',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','344','(''DA''=''F'')','EMETPCRLIFZ0','4','D','10','344',NULL,'Branch - 28',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','345','(''DA''=''F'')','EMETPCRLIFZ0','1','D','10','345',NULL,'Members Covered Code - 28',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','346','(''DA''=''F'')','EMETPCRLIFZ0','1','D','10','346',NULL,'Enrollment Status - 28',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','347','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','347',NULL,'Benefit Amount - 28',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','348','(''DA''=''F'')','EMETPCRLIFZ0','2','D','10','348',NULL,'Voluntary Cancellation Ind - 28',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','349','(''DA''=''F'')','EMETPCRLIFZ0','1','D','10','349',NULL,'Takeover Indicator - 28',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','350','(''DA''=''F'')','EMETPCRLIFZ0','9','D','10','350',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','351','(''DA''=''F'')','EMETPCRLIFZ0','2','D','10','351',NULL,'Coverage Code - 29',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','352','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','352',NULL,'Coverage Start Date - 29',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','353','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','353',NULL,'Coverage Stop Date - 29',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','354','(''DA''=''F'')','EMETPCRLIFZ0','7','D','10','354',NULL,'Group Number - 29',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','355','(''DA''=''F'')','EMETPCRLIFZ0','4','D','10','355',NULL,'Subcode - 29',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','356','(''DA''=''F'')','EMETPCRLIFZ0','4','D','10','356',NULL,'Branch - 29',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','357','(''DA''=''F'')','EMETPCRLIFZ0','1','D','10','357',NULL,'Members Covered Code - 29',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','358','(''DA''=''F'')','EMETPCRLIFZ0','1','D','10','358',NULL,'Enrollment Status - 29',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','359','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','359',NULL,'Benefit Amount - 29',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','360','(''DA''=''F'')','EMETPCRLIFZ0','2','D','10','360',NULL,'Voluntary Cancellation Ind - 29',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','361','(''DA''=''F'')','EMETPCRLIFZ0','10','D','10','361',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','362','(''DA''=''F'')','EMETPCRLIFZ0','2','D','10','362',NULL,'Work State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','363','(''DA''=''F'')','EMETPCRLIFZ0','1','D','10','363',NULL,'Job Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','364','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','364',NULL,'Job Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','365','(''DA''=''F'')','EMETPCRLIFZ0','1','D','10','365',NULL,'Federal Marital Tax Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','366','(''DA''=''F'')','EMETPCRLIFZ0','2','D','10','366',NULL,'Number of Fed Exemptions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','367','(''DA''=''F'')','EMETPCRLIFZ0','1','D','10','367',NULL,'Work Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','368','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','368',NULL,'Work Status Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','369','(''DA''=''F'')','EMETPCRLIFZ0','9','D','10','369',NULL,'Salary Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','370','(''DA''=''F'')','EMETPCRLIFZ0','1','D','10','370',NULL,'Salary Mode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','371','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','371',NULL,'Salary Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','372','(''DA''=''F'')','EMETPCRLIFZ0','3','D','10','372',NULL,'Avg Weekly Scheduled Work Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','373','(''DA''=''F'')','EMETPCRLIFZ0','2','D','10','373',NULL,'Work Week Schedule',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','374','(''DA''=''F'')','EMETPCRLIFZ0','2','D','10','374',NULL,'Coverage Code - 30',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','375','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','375',NULL,'Coverage Start Date - 30',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','376','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','376',NULL,'Coverage Stop Date - 30',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','377','(''DA''=''F'')','EMETPCRLIFZ0','7','D','10','377',NULL,'Group Number - 30',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','378','(''DA''=''F'')','EMETPCRLIFZ0','4','D','10','378',NULL,'Subcode - 30',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','379','(''DA''=''F'')','EMETPCRLIFZ0','4','D','10','379',NULL,'Branch - 30',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','380','(''DA''=''F'')','EMETPCRLIFZ0','2','D','10','380',NULL,'Coverage Code - 31',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','381','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','381',NULL,'Coverage Start Date - 31',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','382','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','382',NULL,'Coverage Stop Date - 31',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','383','(''DA''=''F'')','EMETPCRLIFZ0','7','D','10','383',NULL,'Group Number - 31',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','384','(''DA''=''F'')','EMETPCRLIFZ0','4','D','10','384',NULL,'Subcode - 31',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','385','(''DA''=''F'')','EMETPCRLIFZ0','4','D','10','385',NULL,'Branch - 31',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','386','(''DA''=''F'')','EMETPCRLIFZ0','2','D','10','386',NULL,'Coverage Code - 32',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','387','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','387',NULL,'Coverage Start Date - 32',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','388','(''DA''=''F'')','EMETPCRLIFZ0','8','D','10','388',NULL,'Coverage Stop Date - 32',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','389','(''DA''=''F'')','EMETPCRLIFZ0','7','D','10','389',NULL,'Group Number - 32',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','390','(''DA''=''F'')','EMETPCRLIFZ0','4','D','10','390',NULL,'Subcode - 32',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','391','(''DA''=''F'')','EMETPCRLIFZ0','4','D','10','391',NULL,'Branch - 32',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EMETPCRLIF_20211004.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202102099','EMPEXPORT','OEACTIVE',NULL,'EMETPCRLIF',NULL,NULL,NULL,'202102099','Feb  9 2021  4:09PM','Feb  9 2021  4:09PM','202102091',NULL,'','','202102091',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202102099','EMPEXPORT','OEPASSIVE',NULL,'EMETPCRLIF',NULL,NULL,NULL,'202102099','Feb  9 2021  4:09PM','Feb  9 2021  4:09PM','202102091',NULL,'','','202102091',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Metlife Life Export','202102099','EMPEXPORT','ONDEMAND',NULL,'EMETPCRLIF',NULL,NULL,NULL,'202102099','Feb  9 2021  4:09PM','Feb  9 2021  4:09PM','202102091',NULL,'','','202102091',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','202102099','EMPEXPORT','SCH_METPLA',NULL,'EMETPCRLIF',NULL,NULL,NULL,'202102099','Feb  9 2021  4:09PM','Feb  9 2021  4:09PM','202102091',NULL,'','','202102091',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202109231','EMPEXPORT','TEST','Sep 23 2021 10:53AM','EMETPCRLIF',NULL,NULL,NULL,'202109231','Sep 23 2021 12:00AM','Dec 30 1899 12:00AM','202109231','697','','','202109231',dbo.fn_GetTimedKey(),NULL,'us3cPePCR1000',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMETPCRLIF','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMETPCRLIF','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMETPCRLIF','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMETPCRLIF','SubSort','C','drvSubsort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMETPCRLIF','SubSort2','C','drvSubsort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMETPCRLIF','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMETPCRLIF','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EMETPCRLIF' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EMETPCRLIF' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EMETPCRLIF_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EMETPCRLIF_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMETPCRLIF','D10','dbo.U_EMETPCRLIF_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_EMETPCRLIF') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EMETPCRLIF] (
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
IF OBJECT_ID('U_EMETPCRLIF_Audit') IS NULL
CREATE TABLE [dbo].[U_EMETPCRLIF_Audit] (
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audKey1Value] varchar(255) NOT NULL,
    [audKey2Value] varchar(255) NOT NULL,
    [audKey3Value] varchar(255) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] varchar(2000) NULL,
    [audNewValue] varchar(2000) NULL,
    [audRowNo] bigint NULL
);
IF OBJECT_ID('U_EMETPCRLIF_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EMETPCRLIF_AuditFields] (
    [aTableName] varchar(128) NULL,
    [aFieldName] varchar(128) NULL
);
IF OBJECT_ID('U_EMETPCRLIF_branch') IS NULL
CREATE TABLE [dbo].[U_EMETPCRLIF_branch] (
    [br_eeid] char(12) NOT NULL,
    [br_coid] char(5) NULL,
	br_dedcode varchar(10) NULL,
	br_contactid varchar(50) NULL,
    [br_denh] varchar(1) NOT NULL,
    [br_vish] varchar(1) NOT NULL,
    [br_denl] varchar(1) NOT NULL,
    [br_visl] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EMETPCRLIF_Consolidated') IS NULL
CREATE TABLE [dbo].[U_EMETPCRLIF_Consolidated] (
    [BdmEEID] char(12) NOT NULL,
    [BdmCOID] char(5) NULL,
    [BdmRecType] varchar(3) NOT NULL,
    [BdmDepRecId] char(12) NULL,
    [Dental_Code] char(5) NULL,
    [Dental_BdmBenOption] char(6) NULL,
    [Dental_BdmBenStartDate] datetime NULL,
    [Dental_BdmBenStopDate] datetime NULL,
    [Dental_BdmBenStatus] char(1) NULL,
    [Vision_Code] char(5) NULL,
    [VishDenh_Code] char(5) NULL,
    [VishDenl_Code] char(5) NULL,
    [VislDenh_Code] char(5) NULL,
    [VislDenl_Code] char(5) NULL,
    [Vision_BdmBenOption] char(6) NULL,
    [Vision_BdmBenStartDate] datetime NULL,
    [Vision_BdmBenStopDate] datetime NULL,
    [Vision_BdmBenStatus] char(1) NULL,
    [CritIllness_Code] char(5) NULL,
    [CritIllness_BdmBenOption] char(6) NULL,
    [CritIllness_BdmBenStartDate] datetime NULL,
    [CritIllness_BdmBenStopDate] datetime NULL,
    [CritIllness_BdmBenStatus] char(1) NULL,
    [CritIllness_BdmBenAmount] varchar(256) NULL,
    [CI_DedCode] char(5) NULL,
    [CIEC_DedCode] char(5) NULL,
    [CIEF_DedCode] char(5) NULL,
    [CIES_DedCode] char(5) NULL,
    [CritIllnessDep_Code] char(5) NULL,
    [CritIllnessDep_BdmBenOption] char(6) NULL,
    [CritIllnessDep_BdmBenStartDate] datetime NULL,
    [CritIllnessDep_BdmBenStopDate] datetime NULL,
    [CritIllnessDep_BdmBenStatus] char(1) NULL,
    [CritIllnessDep_BdmBenAmount] varchar(256) NULL,
    [GroupAccident_Code] char(5) NULL,
    [GroupAccident_BdmBenOption] char(6) NULL,
    [GroupAccident_BdmBenStartDate] datetime NULL,
    [GroupAccident_BdmBenStopDate] datetime NULL,
    [GroupAccident_BdmBenStatus] char(1) NULL,
    [GroupAccident_BdmBenAmount] varchar(256) NULL,
    [HospIndemity_Code] char(5) NULL,
    [HospIndemity_BdmBenOption] char(6) NULL,
    [HospIndemity_BdmBenStartDate] datetime NULL,
    [HospIndemity_BdmBenStopDate] datetime NULL,
    [HospIndemity_BdmBenStatus] char(1) NULL,
    [HospIndemity_BdmBenAmount] varchar(256) NULL
);
IF OBJECT_ID('U_EMETPCRLIF_coverage') IS NULL
CREATE TABLE [dbo].[U_EMETPCRLIF_coverage] (
    [bdmeeid_count] char(12) NOT NULL,
    [bdmcoid_count] char(5) NULL,
    [spouse_count] int NULL,
    [child_count] int NULL
);
IF OBJECT_ID('U_EMETPCRLIF_DedList') IS NULL
CREATE TABLE [dbo].[U_EMETPCRLIF_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EMETPCRLIF_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EMETPCRLIF_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(13) NULL,
    [drvSubsort] varchar(1) NOT NULL,
    [drvSubsort2] varchar(1) NOT NULL,
    [drvTransactionCode] varchar(1) NOT NULL,
    [drvCustomerNumber] varchar(7) NOT NULL,
    [drvEmployeeNumber] char(11) NULL,
    [drvMemberSocialSecurityNumber] char(11) NULL,
    [drvMemberLastName] varchar(100) NULL,
    [drvMemberFirstName] varchar(100) NULL,
    [drvMemberMiddleInitial] varchar(1) NULL,
    [drvMemberDateofBirth] datetime NULL,
    [drvMemberMaritalStatus] varchar(1) NULL,
    [drvMemberGender] char(1) NULL,
    [drvRelationshipCode] varchar(2) NULL,
    [drvEmployeesDateofHire] varchar(8000) NOT NULL,
    [drvPersonnelIdentification] char(9) NULL,
    [drvEmployeeSmokerCode] varchar(1) NULL,
    [drvSpouseSmokerCode] varchar(1) NULL,
    [drvPhoneNumber] varchar(50) NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvForeignAddressIndicator] varchar(1) NOT NULL,
    [drvCareofAddress] varchar(1) NOT NULL,
    [drvStreetAddress] varchar(6000) NULL,
    [drvCity] varchar(6000) NULL,
    [drvState] varchar(255) NULL,
    [drvZipCode] varchar(50) NULL,
    [drvCoverageCode1] varchar(1) NULL,
    [drvCoverageStartDate1] datetime NULL,
    [drvCoverageStopDate1] datetime NULL,
    [drvGroupNumber1] varchar(7) NULL,
    [drvSubcode1] varchar(4) NULL,
    [drvBranch1] varchar(4) NULL,
    [drvPlanCode1] varchar(1) NOT NULL,
    [drvStatusCode1] varchar(1) NULL,
    [drvMembersCoveredCode1] varchar(1) NULL,
    [drvCancelReason1] varchar(1) NOT NULL,
    [drvFacilityID] varchar(1) NOT NULL,
    [drvCoverageCode17] varchar(2) NULL,
    [drvCoverageStartDate17] datetime NULL,
    [drvCoverageStopDate17] datetime NULL,
    [drvGroupNumber17] varchar(7) NULL,
    [drvSubcode17] varchar(4) NULL,
    [drvBranch17] varchar(4) NULL,
    [drvEnrollmentStatus17] varchar(1) NULL,
    [drvMembersCoveredCode17] varchar(1) NULL,
    [drvEmployeeStatusCode] varchar(1) NOT NULL,
    [drvStatusCodeEffectiveDate] datetime NULL,
    [drvDepartmentCode] varchar(8000) NULL,
    [drvGroupID] varchar(10) NULL,
    [drvLocationID] varchar(5) NULL,
    [drvScheduleID] varchar(10) NULL,
    [drvPayFrequency] varchar(2) NULL,
    [drvCoverageCode19] varchar(2) NULL,
    [drvCoverageStartDate19] datetime NULL,
    [drvCoverageStopDate19] datetime NULL,
    [drvGroupNumber19] varchar(7) NULL,
    [drvSubcode19] varchar(4) NULL,
    [drvBranch19] varchar(4) NULL,
    [drvMembersCoveredCode19] varchar(1) NULL,
    [drvEnrollmentStatus19] varchar(1) NULL,
    [drvBenefitAmount19] varchar(24) NULL,
    [drvVoluntaryCancellationInd19] varchar(2) NULL,
    [drvTaveoverIndicator19] varchar(1) NOT NULL,
    [drvCoverageCode20] varchar(2) NULL,
    [drvCoverageStartDate20] datetime NULL,
    [drvCoverageStopDate20] datetime NULL,
    [drvGroupNumber20] varchar(7) NULL,
    [drvSubcode20] varchar(4) NULL,
    [drvBranch20] varchar(4) NULL,
    [drvMembersCoveredCode20] varchar(1) NULL,
    [drvEnrollmentStatus20] varchar(1) NULL,
    [drvBenefitAmount20] varchar(24) NULL,
    [drvVoluntaryCancellationInd20] varchar(2) NULL,
    [drvCoverageCode23] varchar(2) NULL,
    [drvCoverageStartDate23] datetime NULL,
    [drvCoverageStopDate23] datetime NULL,
    [drvGroupNumber23] varchar(7) NULL,
    [drvSubcode23] varchar(4) NULL,
    [drvBranch23] varchar(4) NULL,
    [drvMembersCoveredCode23] varchar(1) NULL,
    [drvEnrollmentStatus23] varchar(1) NULL,
    [drvVoluntaryCancellationInd23] varchar(2) NULL,
    [drvTakeoverIndicator23] varchar(1) NULL,
    [drvCoverageCode24] varchar(2) NULL,
    [drvCoverageStartDate24] datetime NULL,
    [drvCoverageStopDate24] datetime NULL,
    [drvGroupNumber24] varchar(7) NULL,
    [drvSubcode24] varchar(4) NULL,
    [drvBranch24] varchar(4) NULL,
    [drvMembersCoveredCode24] varchar(1) NULL,
    [drvEnrollmentStatus24] varchar(1) NULL,
    [drvVoluntaryCancellationInd24] varchar(2) NULL,
    [drvTakeoverIndicator24] varchar(1) NULL,
	drvB1DedCode varchar(10) NULL
);
IF OBJECT_ID('U_EMETPCRLIF_EEList') IS NULL
CREATE TABLE [dbo].[U_EMETPCRLIF_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EMETPCRLIF_File') IS NULL
CREATE TABLE [dbo].[U_EMETPCRLIF_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);
IF OBJECT_ID('U_EMETPCRLIF_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EMETPCRLIF_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhDedCalcBasisAmt] money NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMETPCRLIF]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: PCRK Holding Company

Created By: Andy Pineda
Business Analyst: Cheryl Petitti
Create Date: 09/07/2021
Service Request Number: TekP-2021-07-22-0007

Purpose: Metlife Life Export

Revision History
----------------
09/15/2021 by AP:
        - Fixed a lot of positioning errors.
        - Fixed logic for branch fields (multiple deductions codes).
        - Updated voluntary cancellation ind field logic.
        - Adjusted records that should only appear in emp record.
        - Misc. clean up.

10/04/2021 by AP:
		- Updated branch 1 logic.
		- Update branch 17 logic.
		- Updated branch table logic.
		- Fixed issues with incorrect amount for field 19.
		- Added new deduction codes for critical illness.
		- Updated mapping for new critical illness deduction codes.

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EMETPCRLIF';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EMETPCRLIF';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EMETPCRLIF';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EMETPCRLIF';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EMETPCRLIF' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMETPCRLIF', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMETPCRLIF', 'TEST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMETPCRLIF', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMETPCRLIF', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMETPCRLIF', 'SCH_METPLA';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EMETPCRLIF';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EMETPCRLIF', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@FileMinCovDate    DATETIME;

    -- Set FormatCode
    SELECT @FormatCode = 'EMETPCRLIF';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@FileMinCovDate  = CAST('04/01/2021' as DateTime)
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EMETPCRLIF_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EMETPCRLIF_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'DENH,DENL,VISH,VISL,ACC,ACCH,HOSP,HOSPH,CI,CIEC,CIEF,CIES,CI3,CIEC3,CIEF3,CIES3';

    IF OBJECT_ID('U_EMETPCRLIF_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EMETPCRLIF_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EMETPCRLIF_DedList
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

    EXEC dbo.dsi_bdm_sp_CalculateBenefitAmounts @FormatCode;


    --==========================================
    -- Build Working Tables
    --==========================================

    --Code for "terminations sent one time only". One time means sent one time during the per control range.

    --Audit Table
    IF OBJECT_ID('U_EMETPCRLIF_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EMETPCRLIF_AuditFields;
    CREATE TABLE dbo.U_EMETPCRLIF_AuditFields (aTableName varchar(128),aFieldName varchar(128));
    -- Insert tables/fields to be audited
    INSERT INTO dbo.U_EMETPCRLIF_AuditFields VALUES ('Empcomp','EecEmplStatus');    
    -- Create audit table
    IF OBJECT_ID('U_EMETPCRLIF_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EMETPCRLIF_Audit;
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
    INTO dbo.U_EMETPCRLIF_Audit
    FROM (SELECT *
          FROM dbo.AuditRecords WITH (NOLOCK)
          WHERE adrTableName IN (SELECT aTableName FROM dbo.U_EMETPCRLIF_AuditFields WITH (NOLOCK))) ADR
    JOIN (SELECT *
          FROM dbo.AuditFields WITH (NOLOCK)
          WHERE adfFieldName IN (SELECT aFieldName FROM dbo.U_EMETPCRLIF_AuditFields WITH (NOLOCK))) ADF
        ON adrSystemID = adfSystemID
       AND adrKey = adfKey
    WHERE adrType IN (1,2,5,6) -- Insert/Update; remove this to include Deletes and Viewed
      AND adrProcessedDateTime BETWEEN @StartDate AND @EndDate;
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EMETPCRLIF_Audit ON dbo.U_EMETPCRLIF_Audit (audKey1Value, audKey2Value);


    --=========================================
    -- Update BdmChangeReason For Dependents
    --=========================================
    UPDATE D
        SET D.BdmChangeReason = E.BdmChangeReason
    FROM dbo.U_dsi_bdm_EMETPCRLIF D
    JOIN dbo.U_dsi_bdm_EMETPCRLIF E
        ON E.BdmEEID = D.BdmEEID
        AND E.BdmCOID = D.BdmCOID
        AND E.BdmDedCode = D.BdmDedCode
    WHERE D.BdmRecType = 'DEP' AND E.BdmRecType = 'EMP';

    --=====================================================
    -- Update BdmUSGField2 with EmpDedTVID for Employees
    --=====================================================
    UPDATE dbo.U_dsi_bdm_EMETPCRLIF
        SET BdmUSGField2 = EedEmpDedTVID
        ,BdmUSGField1 = case when eedbenamt is not null and eedbenamt > 0 then eedbenamt else dedeebenamt end
    FROM dbo.U_dsi_bdm_EMETPCRLIF
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = BdmEEID
        AND EedCOID = BdmCOID
        AND EedDedCode = BdmDedCode
    WHERE BdmRecType = 'EMP' AND EedFormatCode = @FormatCode AND EedValidForExport = 'Y';


    --=======================================================
    -- Update BdmUSGField2 with DepBPlanTVID for Dependents
    --=======================================================
    UPDATE dbo.U_dsi_bdm_EMETPCRLIF
        SET BdmUSGField2 = DbnDepBPlanTVID
        ,BdmUSGField1 = dedeebenamt
    FROM dbo.U_dsi_bdm_EMETPCRLIF
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
        ON DbnEEID = BdmEEID
        AND DbnCOID = BdmCOID
        AND DbnDedCode = BdmDedCode
        AND DbnDepRecID = BdmDepRecID
    WHERE BdmRecType = 'DEP' AND DbnFormatCode = @FormatCode AND DbnValidForExport = 'Y';

    --======================================================
    -- Update BdmUSGField1 with Benefit Amount (EedBenAmt)
    --======================================================
   /* UPDATE dbo.U_dsi_bdm_EMETPCRLIF
        SET BdmUSGField1 = CONVERT(VARCHAR(20),EedeeBenAmt)
    FROM dbo.U_dsi_bdm_EMETPCRLIF
    JOIN dbo.EmpDedFull WITH (NOLOCK)
        ON EedEmpDedTVID = BdmUSGField2;
    */
    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EMETPCRLIF_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EMETPCRLIF_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,Max(PdhDedCalcBasisAmt) as PdhDedCalcBasisAmt
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        
    INTO dbo.U_EMETPCRLIF_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EMETPCRLIF_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );

    IF OBJECT_ID('U_EMETPCRLIF_Consolidated','U') IS NOT NULL
    DROP TABLE dbo.U_EMETPCRLIF_Consolidated;

    SELECT BdmEEID, BdmCOID, BdmRecType, BdmDepRecId 
            --Dental
            ,MAX(CASE WHEN BdmDedCode IN ('DENH', 'DENL') THEN BdmDedCode END) AS Dental_Code
            ,MAX(CASE WHEN BdmDedCode IN ('DENH', 'DENL')  THEN BdmBenOption END) AS Dental_BdmBenOption
            ,MAX(CASE WHEN BdmDedCode IN ('DENH', 'DENL')  THEN dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate) END) AS Dental_BdmBenStartDate
            ,MAX(CASE WHEN BdmDedCode IN ('DENH', 'DENL')  THEN BdmBenStopDate END) AS Dental_BdmBenStopDate
            ,MAX(CASE WHEN BdmDedCode IN ('DENH', 'DENL')  THEN BdmBenStatus END) AS Dental_BdmBenStatus
            --Basic Life
            --,MAX(CASE WHEN BdmDedCode IN ('BLFAD') THEN BdmDedCode END) AS BasicLife_Code
            --,MAX(CASE WHEN BdmDedCode IN ('BLFAD') THEN BdmBenOption END) AS BasicLife_BdmBenOption
            --,MAX(CASE WHEN BdmDedCode IN ('BLFAD') THEN dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate) END) AS BasicLife_BdmBenStartDate
            --,MAX(CASE WHEN BdmDedCode IN ('BLFAD') THEN BdmBenStopDate END) AS BasicLife_BdmBenStopDate
            --,MAX(CASE WHEN BdmDedCode IN ('BLFAD')THEN BdmBenStatus END) AS BasicLife_BdmBenStatus
              --Long Term Disability
            --,MAX(CASE WHEN BdmDedCode IN ('LTD', 'LTDX') THEN BdmDedCode END) AS LongTermDisability_Code
            --,MAX(CASE WHEN BdmDedCode IN ('LTD', 'LTDX')  THEN BdmBenOption END) AS LongTermDisability_BdmBenOption
            --,MAX(CASE WHEN BdmDedCode IN ('LTD', 'LTDX')  THEN dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate) END) AS LongTermDisability_BdmBenStartDate
            --,MAX(CASE WHEN BdmDedCode IN ('LTD', 'LTDX') THEN BdmBenStopDate END) AS LongTermDisability_BdmBenStopDate
            --,MAX(CASE WHEN BdmDedCode IN ('LTD', 'LTDX') THEN BdmBenStatus END) AS LongTermDisability_BdmBenStatus
             --Short Term Disability
            --,MAX(CASE WHEN BdmDedCode IN ('STD') THEN BdmDedCode END) AS ShortTermDisability_Code
            --,MAX(CASE WHEN BdmDedCode IN ('STD')  THEN BdmBenOption END) AS ShortTermDisability_BdmBenOption
            --,MAX(CASE WHEN BdmDedCode IN ('STD')  THEN dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate) END) AS ShortTermDisability_BdmBenStartDate
            --,MAX(CASE WHEN BdmDedCode IN ('STD') THEN BdmBenStopDate END) AS ShortTermDisability_BdmBenStopDate
            --,MAX(CASE WHEN BdmDedCode IN ('STD') THEN BdmBenStatus END) AS ShortTermDisability_BdmBenStatus

             --Supplimental Basic Life
            --,MAX(CASE WHEN BdmDedCode IN ('LIFEE') THEN BdmDedCode END) AS SupBasicLife_Code
            --,MAX(CASE WHEN BdmDedCode IN ('LIFEE')  THEN BdmBenOption END) AS SupBasicLife_BdmBenOption
            --,MAX(CASE WHEN BdmDedCode IN ('LIFEE')  THEN dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate) END) AS SupBasicLife_BdmBenStartDate
            --,MAX(CASE WHEN BdmDedCode IN ('LIFEE') THEN BdmBenStopDate END) AS SupBasicLife_BdmBenStopDate
            --,MAX(CASE WHEN BdmDedCode IN ('LIFEE') THEN BdmBenStatus END) AS SupBasicLife_BdmBenStatus
            --,MAX(CASE WHEN BdmDedCode IN ('LIFEE') THEN BdmUSGField1 END) AS SupBasicLife_BdmBenAmount
            
             --Supplimental Spouse Life
            --,MAX(CASE WHEN BdmDedCode IN ('LIFES') THEN BdmDedCode END) AS SupSpouseLife_Code
            --,MAX(CASE WHEN BdmDedCode IN ('LIFES')  THEN BdmBenOption END) AS SupSpouseLife_BdmBenOption
            --,MAX(CASE WHEN BdmDedCode IN ('LIFES')  THEN dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate) END) AS SupSpouseLife_BdmBenStartDate
            --,MAX(CASE WHEN BdmDedCode IN ('LIFES') THEN BdmBenStopDate END) AS SupSpouseLife_BdmBenStopDate
            --,MAX(CASE WHEN BdmDedCode IN ('LIFES') THEN BdmBenStatus END) AS SupSpouseLife_BdmBenStatus
            --,MAX(CASE WHEN BdmDedCode IN ('LIFES') THEN BdmUSGField1 END) AS SupSpouseLife_BdmBenAmount

              --Supplimental Children Life
            --,MAX(CASE WHEN BdmDedCode IN ('LIFEC') THEN BdmDedCode END) AS SupChildrenLife_Code
            --,MAX(CASE WHEN BdmDedCode IN ('LIFEC')  THEN BdmBenOption END) AS SupChildrenLife_BdmBenOption
            --,MAX(CASE WHEN BdmDedCode IN ('LIFEC')  THEN dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate) END) AS SupChildrenLife_BdmBenStartDate
            --,MAX(CASE WHEN BdmDedCode IN ('LIFEC') THEN BdmBenStopDate END) AS SupChildrenLife_BdmBenStopDate
            --,MAX(CASE WHEN BdmDedCode IN ('LIFEC') THEN BdmBenStatus END) AS SupChildrenLife_BdmBenStatus
            --,MAX(CASE WHEN BdmDedCode IN ('LIFEC') THEN BdmUSGField1 END) AS SupChildrenLife_BdmBenAmount

            --Supplimental Basic AD&D
            --,MAX(CASE WHEN BdmDedCode IN ('ADDE') THEN BdmDedCode END) AS SupBasicADD_Code
            --,MAX(CASE WHEN BdmDedCode IN ('ADDE')  THEN BdmBenOption END) AS SupBasicADD_BdmBenOption
            --,MAX(CASE WHEN BdmDedCode IN ('ADDE')  THEN dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate) END) AS SupBasicADD_BdmBenStartDate
            --,MAX(CASE WHEN BdmDedCode IN ('ADDE') THEN BdmBenStopDate END) AS SupBasicADD_BdmBenStopDate
            --,MAX(CASE WHEN BdmDedCode IN ('ADDE') THEN BdmBenStatus END) AS SupBasicADD_BdmBenStatus
            --,MAX(CASE WHEN BdmDedCode IN ('ADDE') THEN BdmUSGField1 END) AS SupBasicADD_BdmBenAmount

              --Supplimental Spouse AD&D
            --,MAX(CASE WHEN BdmDedCode IN ('ADDS') THEN BdmDedCode END) AS SupSpouseADD_Code
            --,MAX(CASE WHEN BdmDedCode IN ('ADDS')  THEN BdmBenOption END) AS SupSpouseADD_BdmBenOption
            --,MAX(CASE WHEN BdmDedCode IN ('ADDS')  THEN dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate) END) AS SupSpouseADD_BdmBenStartDate
            --,MAX(CASE WHEN BdmDedCode IN ('ADDS') THEN BdmBenStopDate END) AS SupSpouseADD_BdmBenStopDate
            --,MAX(CASE WHEN BdmDedCode IN ('ADDS') THEN BdmBenStatus END) AS SupSpouseADD_BdmBenStatus
            --,MAX(CASE WHEN BdmDedCode IN ('ADDS') THEN BdmUSGField1 END) AS SupSpouseADD_BdmBenAmount
            
                    --Supplimental Child AD&D
            --,MAX(CASE WHEN BdmDedCode IN ('ADDC') THEN BdmDedCode END) AS SupChildADD_Code
            --,MAX(CASE WHEN BdmDedCode IN ('ADDC')  THEN BdmBenOption END) AS SupChildADD_BdmBenOption
            --,MAX(CASE WHEN BdmDedCode IN ('ADDC')  THEN dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate) END) AS SupChildADD_BdmBenStartDate
            --,MAX(CASE WHEN BdmDedCode IN ('ADDC') THEN BdmBenStopDate END) AS SupChildADD_BdmBenStopDate
            --,MAX(CASE WHEN BdmDedCode IN ('ADDC') THEN BdmBenStatus END) AS SupChildADD_BdmBenStatus
            --,MAX(CASE WHEN BdmDedCode IN ('ADDC') THEN BdmUSGField1 END) AS SupChildADD_BdmBenAmount
           
            --Vision
            ,MAX(CASE WHEN BdmDedCode IN ('VISH', 'VISL') THEN BdmDedCode END) AS Vision_Code
            ,MAX(CASE WHEN BdmDedCode IN ('VISH', 'DENH') THEN BdmDedCode END) AS VishDenh_Code
            ,MAX(CASE WHEN BdmDedCode IN ('VISH', 'DENL') THEN BdmDedCode END) AS VishDenl_Code
            ,MAX(CASE WHEN BdmDedCode IN ('VISL', 'DENH') THEN BdmDedCode END) AS VislDenh_Code
            ,MAX(CASE WHEN BdmDedCode IN ('VISL', 'DENL') THEN BdmDedCode END) AS VislDenl_Code
            ,MAX(CASE WHEN BdmDedCode IN ('VISH', 'VISL')  THEN BdmBenOption END) AS Vision_BdmBenOption
            ,MAX(CASE WHEN BdmDedCode IN ('VISH', 'VISL')  THEN dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate) END) AS Vision_BdmBenStartDate
            ,MAX(CASE WHEN BdmDedCode IN ('VISH', 'VISL')  THEN BdmBenStopDate END) AS Vision_BdmBenStopDate
            ,MAX(CASE WHEN BdmDedCode IN ('VISH', 'VISL')  THEN BdmBenStatus END) AS Vision_BdmBenStatus
             
            --Critical Illness
            ,MAX(CASE WHEN BdmDedCode IN ('CI', 'CIEC', 'CIEF', 'CIES', 'CI3', 'CIEC3', 'CIEF3', 'CIES3') THEN BdmDedCode END) AS CritIllness_Code
            ,MAX(CASE WHEN BdmDedCode IN ('CI', 'CIEC', 'CIEF', 'CIES', 'CI3', 'CIEC3', 'CIEF3', 'CIES3')  THEN BdmBenOption END) AS CritIllness_BdmBenOption
            ,MAX(CASE WHEN BdmDedCode IN ('CI', 'CIEC', 'CIEF', 'CIES', 'CI3', 'CIEC3', 'CIEF3', 'CIES3') THEN dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate) END) AS CritIllness_BdmBenStartDate
            ,MAX(CASE WHEN BdmDedCode IN ('CI', 'CIEC', 'CIEF', 'CIES', 'CI3', 'CIEC3', 'CIEF3', 'CIES3') THEN BdmBenStopDate END) AS CritIllness_BdmBenStopDate
            ,MAX(CASE WHEN BdmDedCode IN ('CI', 'CIEC', 'CIEF', 'CIES', 'CI3', 'CIEC3', 'CIEF3', 'CIES3') THEN BdmBenStatus END) AS CritIllness_BdmBenStatus
            ,MAX(CASE WHEN BdmDedCode IN ('CI', 'CIEC', 'CIEF', 'CIES', 'CI3', 'CIEC3', 'CIEF3', 'CIES3') THEN BdmUSGField1 END) AS CritIllness_BdmBenAmount

            ,MAX(CASE WHEN BdmDedCode IN ('CI') THEN BdmDedCode END) AS CI_DedCode
            ,MAX(CASE WHEN BdmDedCode IN ('CIEC') THEN BdmDedCode END) AS CIEC_DedCode
            ,MAX(CASE WHEN BdmDedCode IN ('CIEF') THEN BdmDedCode END) AS CIEF_DedCode
            ,MAX(CASE WHEN BdmDedCode IN ('CIES') THEN BdmDedCode END) AS CIES_DedCode

                --Critical Illness Dependent
            ,MAX(CASE WHEN BdmDedCode IN ('CIEC', 'CIEF', 'CIES', 'CIEC3', 'CIEF3', 'CIES3') THEN BdmDedCode END) AS CritIllnessDep_Code
            ,MAX(CASE WHEN BdmDedCode IN ('CIEC', 'CIEF', 'CIES', 'CIEC3', 'CIEF3', 'CIES3')  THEN BdmBenOption END) AS CritIllnessDep_BdmBenOption
            ,MAX(CASE WHEN BdmDedCode IN ('CIEC', 'CIEF', 'CIES', 'CIEC3', 'CIEF3', 'CIES3') THEN dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate) END) AS CritIllnessDep_BdmBenStartDate
            ,MAX(CASE WHEN BdmDedCode IN ('CIEC', 'CIEF', 'CIES', 'CIEC3', 'CIEF3', 'CIES3') THEN BdmBenStopDate END) AS CritIllnessDep_BdmBenStopDate
            ,MAX(CASE WHEN BdmDedCode IN ('CIEC', 'CIEF', 'CIES', 'CIEC3', 'CIEF3', 'CIES3') THEN BdmBenStatus END) AS CritIllnessDep_BdmBenStatus
            ,MAX(CASE WHEN BdmDedCode IN ('CIEC', 'CIEF', 'CIES', 'CIEC3', 'CIEF3', 'CIES3') THEN BdmUSGField1  END) AS CritIllnessDep_BdmBenAmount

               --Group Accident
            ,MAX(CASE WHEN BdmDedCode IN ('ACCH', 'ACC') THEN BdmDedCode END) AS GroupAccident_Code
            ,MAX(CASE WHEN BdmDedCode IN ('ACCH', 'ACC ') THEN BdmBenOption END) AS GroupAccident_BdmBenOption
            ,MAX(CASE WHEN BdmDedCode IN ('ACCH', 'ACC') THEN dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate) END) AS GroupAccident_BdmBenStartDate
            ,MAX(CASE WHEN BdmDedCode IN ('ACCH', 'ACC') THEN BdmBenStopDate END) AS GroupAccident_BdmBenStopDate
            ,MAX(CASE WHEN BdmDedCode IN ('ACCH', 'ACC') THEN BdmBenStatus END) AS GroupAccident_BdmBenStatus
            ,MAX(CASE WHEN BdmDedCode IN ('ACCH', 'ACC') THEN BdmUSGField1 END) AS GroupAccident_BdmBenAmount


               --Hospital Indemnity
            ,MAX(CASE WHEN BdmDedCode IN ('HOSPH', 'HOSP') THEN BdmDedCode END) AS HospIndemity_Code
            ,MAX(CASE WHEN BdmDedCode IN ('HOSPH', 'HOSP') THEN BdmBenOption END) AS HospIndemity_BdmBenOption
            ,MAX(CASE WHEN BdmDedCode IN ('HOSPH', 'HOSP') THEN dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate) END) AS HospIndemity_BdmBenStartDate
            ,MAX(CASE WHEN BdmDedCode IN ('HOSPH', 'HOSP') THEN BdmBenStopDate END) AS HospIndemity_BdmBenStopDate
            ,MAX(CASE WHEN BdmDedCode IN ('HOSPH', 'HOSP')THEN BdmBenStatus END) AS HospIndemity_BdmBenStatus
            ,MAX(CASE WHEN BdmDedCode IN ('HOSPH', 'HOSP') THEN BdmUSGField1 END) AS HospIndemity_BdmBenAmount

            INTO dbo.U_EMETPCRLIF_Consolidated
            FROM dbo.U_dsi_BDM_EMETPCRLIF WITH (NOLOCK)
            GROUP BY BdmEEID, BdmCOID, BdmRecType, BdmDepRecId

        -- Create count dependent table
        IF OBJECT_ID('U_EMETPCRLIF_coverage','U') IS NOT NULL 
        DROP TABLE dbo.U_EMETPCRLIF_coverage;

        SELECT e.bdmeeid as bdmeeid_count, e.bdmcoid as bdmcoid_count, count(distinct(s.bdmdateofbirth)) as spouse_count, count(distinct(c.bdmdateofbirth)) as child_count
        into dbo.U_EMETPCRLIF_coverage 
        FROM dbo.U_dsi_BDM_EMETPCRLIF e WITH(NOLOCK) 
        left JOIN dbo.U_dsi_BDM_EMETPCRLIF s WITH(NOLOCK) ON s.bdmeeid = e.bdmeeid  and s.bdmrelationship in ('sps', 'dp', 'dpn')
        left join dbo.U_dsi_BDM_EMETPCRLIF c with(nolock) on c.bdmeeid = e.bdmeeid and c.bdmrelationship in ('chl', 'stc', 'dpc', 'ddp', 'grc')

        group by e.bdmeeid, e.bdmcoid

        -- For branch, capture multiple deduction codes
        IF OBJECT_ID('U_EMETPCRLIF_branch','U') IS NOT NULL 
        DROP TABLE dbo.U_EMETPCRLIF_branch;

        select distinct a.bdmeeid as br_eeid, a.bdmcoid as br_coid, a.bdmdedcode as br_dedcode, NULL AS br_contactid, case when b.bdmeeid is not null then '1' else '0' end as br_denh,
        case when c.bdmeeid is not null then '1' else '0' end as br_vish, case when d.bdmeeid is not null then '1' else '0' end as br_denl,
        case when e.bdmeeid is not null then '1' else '0' end as br_visl
        INTO dbo.U_EMETPCRLIF_branch
        from dbo.U_dsi_BDM_EMETPCRLIF a
        left join dbo.U_dsi_BDM_EMETPCRLIF b
        on b.bdmeeid = a.bdmeeid and b.bdmdedcode = 'denh'
        left join dbo.U_dsi_BDM_EMETPCRLIF c
        on c.bdmeeid = a.bdmeeid and c.bdmdedcode = 'vish'
        left join dbo.U_dsi_BDM_EMETPCRLIF d
        on d.bdmeeid = a.bdmeeid and d.bdmdedcode = 'denl'
        left join dbo.U_dsi_BDM_EMETPCRLIF e
        on e.bdmeeid = a.bdmeeid and e.bdmdedcode = 'visl'
		where a.bdmrectype = 'EMP'
		AND a.bdmdedcode in ('DENH', 'VISH', 'DENL', 'VISL')
		UNION ALL
		 select distinct a.bdmeeid as br_eeid, a.bdmcoid as br_coid, a.bdmdedcode as br_dedcode, con.consystemid as br_contactid, case when b.bdmeeid is not null then '1' else '0' end as br_denh,
        case when c.bdmeeid is not null then '1' else '0' end as br_vish, case when d.bdmeeid is not null then '1' else '0' end as br_denl,
        case when e.bdmeeid is not null then '1' else '0' end as br_visl
       -- INTO dbo.U_EMETPCRLIF_branch
     from dbo.U_dsi_BDM_EMETPCRLIF a
		join dbo.contacts con
		on a.bdmeeid = con.coneeid 
		and a.bdmdeprecid = con.consystemid
        left join dbo.U_dsi_BDM_EMETPCRLIF b
        on b.bdmeeid = a.bdmeeid and con.consystemid = b.bdmdeprecid and b.bdmdedcode = 'denh'-- and b.bdmrectype = 'dep'
        left join dbo.U_dsi_BDM_EMETPCRLIF c
        on c.bdmeeid = a.bdmeeid and con.consystemid = c.bdmdeprecid and c.bdmdedcode = 'vish'-- and c.bdmrectype = 'dep'
        left join dbo.U_dsi_BDM_EMETPCRLIF d
        on d.bdmeeid = a.bdmeeid and con.consystemid = d.bdmdeprecid and d.bdmdedcode = 'denl' --and d.bdmrectype = 'dep'
        left join dbo.U_dsi_BDM_EMETPCRLIF e
        on e.bdmeeid = a.bdmeeid and con.consystemid = e.bdmdeprecid and e.bdmdedcode = 'visl' --and e.bdmrectype = 'dep'
		where a.bdmdedcode IN ('DENH', 'VISH', 'DENL', 'VISL')

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EMETPCRLIF_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EMETPCRLIF_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EMETPCRLIF_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),bdmdeprecid) --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = EepSSN + ' ' + CASE WHEN BdmRecType = 'EMP' THEN '1' ELSE '2' END
        ,drvSubsort = ''
        ,drvSubsort2 = ''
        -- standard fields above and additional driver fields below
        ,drvTransactionCode = CASE WHEN BdmRecType = 'EMP' THEN 'E' ELSE 'D' END
        ,drvCustomerNumber = '5977012' 
        /*CASE WHEN BasicLife_Code is not null or SupSpouseADD_Code is not null or SupChildADD_Code is not null or SupBasicADD_Code is not null
        or LongTermDisability_Code is not null or SupBasicLife_Code  is not null or SupSpouseLife_Code  is not null or SupChildrenLife_Code  is not null 
        or Dental_Code  is not null or ShortTermDisability_Code is not null THEN '5975462' ELSE '9232840' END*/
        ,drvEmployeeNumber = EepSSN
        ,drvMemberSocialSecurityNumber = CASE WHEN BdmRecType = 'EMP' THEN  EepSSN ELSE  ConSSN END
        ,drvMemberLastName = CASE WHEN BdmRecType = 'EMP' THEN RTRIM(LTRIM(EepNameLast)) ELSE RTRIM(LTRIM(ConNameLast)) END
        ,drvMemberFirstName = CASE WHEN BdmRecType = 'EMP' THEN RTRIM(LTRIM(EepNameFirst)) ELSE RTRIM(LTRIM(ConNameFirst)) END
        ,drvMemberMiddleInitial = CASE WHEN BdmRecType = 'EMP' THEN LEFT(EepNameMiddle,1) ELSE LEFT(ConNameMiddle,1) END
        ,drvMemberDateofBirth = CASE WHEN BdmRecType = 'EMP' THEN EepDateOfBirth ELSE ConDateOfBirth END
        ,drvMemberMaritalStatus = CASE WHEN BdmRecType = 'EMP' THEN 
                                    CASE WHEN ISNULL(EepMaritalStatus, '') NOT IN ('Z', '') THEN EepMaritalStatus ELSE 'U' END
                                  END
        ,drvMemberGender = CASE WHEN BdmRecType = 'EMP' THEN EepGender ELSE ConGender END
        ,drvRelationshipCode = CASE WHEN BdmRecType = 'EMP' THEN '00'
                                    ELSE
                                        CASE WHEN ConRelationShip IN ('DMP', 'DP','SPS','SPX') THEN '01'
                                            WHEN ConRelationShip IN ('CHL', 'DPC', 'STC') THEN '02'
                                        END
                                END  
        ,drvEmployeesDateofHire = ISNULL((CASE WHEN BdmRecType = 'EMP' THEN REPLACE(CONVERT (CHAR(10), EecDateOfLastHire, 101),'/','') END), '')
        ,drvPersonnelIdentification = eecempno
        ,drvEmployeeSmokerCode = CASE WHEN BdmRecType = 'EMP' THEN 'U' END
        ,drvSpouseSmokerCode = CASE WHEN BdmRecType = 'EMP' AND spouse_count >= 1 THEN 'U' END
        ,drvPhoneNumber = CASE WHEN BdmRecType = 'EMP' THEN EepPhoneHomeNumber ELSE ConPhoneHomeNumber END
        ,drvEmailAddress = EepAddressEMail
        ,drvForeignAddressIndicator = 'D'
        ,drvCareofAddress = ''
        ,drvStreetAddress = dbo.dsi_fnRemoveChars('.,/-',EepAddressLine1 + ' ' + ISNULL(EepAddressLine2, ''))
        ,drvCity = dbo.dsi_fnRemoveChars('.,/-',EepAddressCity)
        ,drvState = EepAddressState
        ,drvZipCode = EepAddressZipCode
        ,drvCoverageCode1 = CASE WHEN Dental_Code is not null THEN 'D' END
        ,drvCoverageStartDate1 = CASE WHEN Dental_Code is not null THEN Dental_BdmBenStartDate END
        ,drvCoverageStopDate1 = CASE WHEN Dental_Code is not null THEN Dental_BdmBenStopDate END
        ,drvGroupNumber1 = CASE WHEN Dental_Code is not null THEN '5977012' END
        ,drvSubcode1 = CASE WHEN Dental_Code is not null THEN '0001' END
        ,drvBranch1 = CASE WHEN br_denh = '1' AND br_vish = '1' THEN 'H001'
                             WHEN br_denh = '1' AND br_vish = '0' AND br_visl = '0' THEN 'H001'
                                WHEN br_denl = '1' AND br_vish = '1' AND EepAddressState <> 'TX' THEN 'L002'
                                WHEN br_denl = '1' AND br_vish = '0' AND br_visl = '0' AND EepAddressState <> 'TX' THEN 'L002'
                                WHEN br_denh = '1' AND br_visl = '1' THEN 'H003'
                                WHEN br_denl = '1' AND br_visl = '1' AND EepAddressState <> 'TX' THEN 'L004'
                            END
		--CASE WHEN br_denh = '1' AND br_vish = '1' THEN 'H001'
  --                           WHEN br_denh = '1' AND br_vish = '0' THEN 'H001'
  --                              WHEN br_denl = '1' AND br_vish = '1' AND EepAddressState <> 'TX' THEN 'L002'
  --                              WHEN br_denl = '1' AND br_vish = '0' AND EepAddressState <> 'TX' THEN 'L002'
  --                              WHEN br_denh = '1' AND br_visl = '1' THEN 'H003'
  --                              WHEN br_denl = '1' AND br_visl = '1' AND EepAddressState <> 'TX' THEN 'L004'
  --                          END
        --CASE WHEN VishDenh_Code in ('VISH','DENH') THEN 'H001' 
  --                         WHEN VishDenl_Code in ('VISH','DENL') and EepAddressState <> 'TX' THEN 'L002'
  --                         WHEN VislDenh_Code in ('VISL','DENH') THEN 'H003'
  --                         WHEN VislDenl_Code in ('VISL','DENL') and EepAddressState <> 'TX' THEN 'L004'
  --                         END
        ,drvPlanCode1 = ''
        ,drvStatusCode1 = CASE WHEN Dental_Code is not null THEN 'A' END
        ,drvMembersCoveredCode1 = CASE WHEN Dental_Code is not null THEN 
                                        CASE WHEN Dental_BdmBenOption = 'EE' THEN '1'
                                             WHEN Dental_BdmBenOption = 'EEC' THEN '2'
                                             WHEN Dental_BdmBenOption IN ('EES', 'EEDP') THEN '3'
                                             WHEN Dental_BdmBenOption IN ('EEF', 'EEDPF') THEN '4'
                                        END    
                                  END
        ,drvCancelReason1 = ''
        ,drvFacilityID = ''
        --,drvCoverageCode2 = CASE WHEN BasicLife_Code IS NOT NULL THEN 'CP' END
        --,drvCoverageStartDate2 = CASE WHEN BasicLife_Code IS NOT NULL THEN BasicLife_BdmBenStartDate END
        --,drvCoverageStopDate2 = CASE WHEN BasicLife_Code IS NOT NULL THEN BasicLife_BdmBenStopDate END
        --,drvGroupNumber2 = CASE WHEN BasicLife_Code IS NOT NULL THEN '5975462' END
        --,drvSubcode2 = CASE WHEN BasicLife_Code IS NOT NULL THEN '0003' END
        --,drvBranch2 = CASE WHEN BasicLife_Code is not null and  EXISTS(Select * from dbo.U_EMETPCRLIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP' )  and EecSalaryOrHourly = 'S' THEN 'H001' 
        --                   WHEN BasicLife_Code is not null  and  EXISTS(Select * from dbo.U_EMETPCRLIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP' )  and EecSalaryOrHourly = 'H' THEN 'H003'
        --                   WHEN BasicLife_Code is not null   and  EXISTS(Select * from dbo.U_EMETPCRLIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP' )   and EecSalaryOrHourly = 'S' THEN 'L002'
        --                   WHEN BasicLife_Code is not null   and  EXISTS(Select * from dbo.U_EMETPCRLIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP'  )  and EecSalaryOrHourly = 'H' THEN 'L004'
        --                   WHEN BasicLife_Code is not null THEN  'H001'
        --                   END
        --,StatusCode2 = CASE WHEN BasicLife_Code IS NOT NULL THEN 'A' END
        --,MembersCoveredCode2 = CASE WHEN BasicLife_Code IS NOT NULL THEN '1' END
        --,AnnualBenefitAmount2 = CASE WHEN BasicLife_Code IS NOT NULL THEN dbo.dsi_fnpadzero((ISNULL((Select MAX(PdhDedCalcBasisAmt) from pdedhist where pdheeid = B.bdmeeid and pdhdedcode = 'BLFAD'),0)),8,0)  END  
        --,SalaryMode2 = CASE WHEN BasicLife_Code IS NOT NULL THEN 'A' END
        --,SalaryAmount2 = CASE WHEN BasicLife_Code IS NOT NULL THEN dbo.dsi_fnpadzero((ISNULL(eecAnnSalary,0)),7,0)END 
        --,CoverageCode3 = CASE WHEN BasicLife_Code IS NOT NULL THEN 'AD' END
        --,CoverageStartDate3 = CASE WHEN BasicLife_Code IS NOT NULL THEN BasicLife_BdmBenStartDate END
        --,CoverageStopDate3 = CASE WHEN BasicLife_Code IS NOT NULL THEN BasicLife_BdmBenStopDate END
        --,GroupNumber3 = CASE WHEN BasicLife_Code IS NOT NULL THEN '5975462' END
        --,Subcode3 = CASE WHEN BasicLife_Code IS NOT NULL THEN '0003' END
        --,Branch3 = CASE WHEN BasicLife_Code is not null and  EXISTS(Select * from dbo.U_EMETPCRLIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP' )  and EecSalaryOrHourly = 'S' THEN 'H001' 
        --                   WHEN BasicLife_Code is not null  and  EXISTS(Select * from dbo.U_EMETPCRLIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP' )  and EecSalaryOrHourly = 'H' THEN 'H003'
        --                   WHEN BasicLife_Code is not null   and  EXISTS(Select * from dbo.U_EMETPCRLIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP' )   and EecSalaryOrHourly = 'S' THEN 'L002'
        --                   WHEN BasicLife_Code is not null   and  EXISTS(Select * from dbo.U_EMETPCRLIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP'  )  and EecSalaryOrHourly = 'H' THEN 'L004'
        --                   WHEN BasicLife_Code is not null THEN  'H001'
        --                   END
        --,StatusCode3 = CASE WHEN BasicLife_Code IS NOT NULL THEN 'A' END
        --,MembersCoveredCode3 = CASE WHEN BasicLife_Code IS NOT NULL THEN '1' END
        --,AnnualBenefitAmount3 = CASE WHEN BasicLife_Code IS NOT NULL THEN dbo.dsi_fnpadzero((ISNULL((Select MAX(PdhDedCalcBasisAmt) from pdedhist where pdheeid = B.bdmeeid and pdhdedcode = 'BLFAD'),0)),8,0)  END
        --,SalaryMode3 = CASE WHEN BasicLife_Code IS NOT NULL THEN 'A' END
        --,SalaryAmount3 = CASE WHEN BasicLife_Code IS NOT NULL THEN dbo.dsi_fnpadzero((ISNULL(eecAnnSalary,0)),7,0)END
        --,CoverageCode4 = CASE WHEN LongTermDisability_Code is not null then 'LT' END
        --,CoverageStartDate4 = CASE WHEN LongTermDisability_Code is not null then LongTermDisability_BdmBenStartDate END
        --,CoverageStopDate4 = CASE WHEN LongTermDisability_Code is not null then LongTermDisability_BdmBenStopDate END
        --,GroupNumber4 = CASE WHEN LongTermDisability_Code is not null then '5975462' END
        --,Subcode4 = CASE WHEN LongTermDisability_Code is not null then '0003' END
        --,Branch4 = CASE WHEN LongTermDisability_Code is not null and  EXISTS(Select * from dbo.U_EMETPCRLIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP' )  and EecSalaryOrHourly = 'S' THEN 'H001' 
        --                   WHEN LongTermDisability_Code is not null  and  EXISTS(Select * from dbo.U_EMETPCRLIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP' )  and EecSalaryOrHourly = 'H' THEN 'H003'
        --                   WHEN LongTermDisability_Code is not null   and  EXISTS(Select * from dbo.U_EMETPCRLIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP' )   and EecSalaryOrHourly = 'S' THEN 'L002'
        --                   WHEN LongTermDisability_Code is not null   and  EXISTS(Select * from dbo.U_EMETPCRLIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP'  )  and EecSalaryOrHourly = 'H' THEN 'L004'
        --                   WHEN LongTermDisability_Code is not null THEN  'H001'
        --                   END
        --,StatusCode4 = CASE WHEN LongTermDisability_Code is not null then 'A' END
        --,MembersCoveredCode4 = CASE WHEN LongTermDisability_Code is not null then '1' END
        --,MonthlyBenefitAmount4Before = CASE WHEN LongTermDisability_Code IS NOT NULL THEN dbo.dsi_fnpadzero((ISNULL((Select MAX(PdhDedCalcBasisAmt) from pdedhist where pdheeid = B.bdmeeid and pdhdedcode IN('LTD', 'LTDX' )),0)),8,0)  END
        --,MonthlyBenefitAmount4 = CASE WHEN LongTermDisability_Code IS NOT NULL THEN dbo.dsi_fnpadzero((ISNULL(  (Select top 1 bcaBenamtCalc from u_dsi_bdm_BenCalculationAmounts where bcaformatcode = @FormatCode and  bcaeeid= B.bdmeeid and bcadedcode IN('LTD', 'LTDX' ) ) ,0)),8,0)  END

        --,SalaryMode4 = CASE WHEN LongTermDisability_Code is not null then 'A' END
        --,SalaryAmount4 = CASE WHEN LongTermDisability_Code IS NOT NULL THEN dbo.dsi_fnpadzero((ISNULL(eecAnnSalary,0)),7,0)END
        --,CoverageCode5 = CASE WHEN ShortTermDisability_Code IS NOT NULL THEN 'AS' END 
        --,CoverageStartDate5 = CASE WHEN ShortTermDisability_Code IS NOT NULL THEN ShortTermDisability_BdmBenStartDate END 
        --,CoverageStopDate5 = CASE WHEN ShortTermDisability_Code IS NOT NULL THEN ShortTermDisability_BdmBenStopDate END 
        --,GroupNumber5 = CASE WHEN ShortTermDisability_Code is not null then '0317365' END
        --,Subcode5 = CASE WHEN ShortTermDisability_Code is not null then '0005' END
        --,Branch5 = CASE WHEN ShortTermDisability_Code is not null then '0001' END
        --,StatusCode5 = CASE WHEN ShortTermDisability_Code is not null then 'A' END
        --,MembersCoveredCode5 = CASE WHEN ShortTermDisability_Code is not null then '1' END
        --,drvWeeklyBenefitAmount5Before = CASE WHEN ShortTermDisability_Code IS NOT NULL THEN dbo.dsi_fnpadzero((ISNULL((Select MAX(PdhDedCalcBasisAmt) from pdedhist where pdheeid = B.bdmeeid and pdhdedcode IN('STD')),0)),8,0)  END
        -- ,drvWeeklyBenefitAmount5 = CASE WHEN ShortTermDisability_Code IS NOT NULL THEN dbo.dsi_fnpadzero((ISNULL( CASE WHEN  (Select top 1 (eecannsalary/52) * 0.75 from dbo.empcomp  where eeceeid = B.bdmeeid) > 1500 THEN 1500 ELSE (Select top 1 (eecannsalary/52) * 0.75 from dbo.empcomp  where eeceeid = B.bdmeeid) END ,0)),8,0)  END

        --,drvSalaryMode5 = CASE WHEN ShortTermDisability_Code is not null then 'A' END
        --,drvSalaryAmount5 = CASE WHEN ShortTermDisability_Code IS NOT NULL THEN dbo.dsi_fnpadzero((ISNULL(eecAnnSalary,0)),7,0)END
        --,drvCoverageCode7 = CASE WHEN SupBasicLife_Code IS NOT NULL THEN 'OP' END
        --,drvCoverageStartDate7 = CASE WHEN SupBasicLife_Code IS NOT NULL THEN SupBasicLife_BdmBenStartDate END
        --,drvCoverageStopDate7 = CASE WHEN SupBasicLife_Code IS NOT NULL THEN SupBasicLife_BdmBenStopDate END
        --,drvGroupNumber7 = CASE WHEN SupBasicLife_Code IS NOT NULL THEN '5975462' END
        --,drvSubcode7 = CASE WHEN SupBasicLife_Code IS NOT NULL THEN '0003' END
        --,drvBranch7 = CASE WHEN SupBasicLife_Code is not null and  EXISTS(Select * from dbo.U_EMETPCRLIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP' )  and EecSalaryOrHourly = 'S' THEN 'H001' 
        --                   WHEN SupBasicLife_Code is not null  and  EXISTS(Select * from dbo.U_EMETPCRLIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP' )  and EecSalaryOrHourly = 'H' THEN 'H003'
        --                   WHEN SupBasicLife_Code is not null   and  EXISTS(Select * from dbo.U_EMETPCRLIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP' )   and EecSalaryOrHourly = 'S' THEN 'L002'
        --                   WHEN SupBasicLife_Code is not null   and  EXISTS(Select * from dbo.U_EMETPCRLIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP'  )  and EecSalaryOrHourly = 'H' THEN 'L004'
        --                   WHEN SupBasicLife_Code is not null THEN  'H001'
        --                   END
        
        --,drvStatusCode7 = CASE WHEN SupBasicLife_Code IS NOT NULL THEN 'A' END
        --,drvMembersCoveredCode7 = CASE WHEN SupBasicLife_Code IS NOT NULL THEN '1' END
        --,AnnualBenefitAmount7 = CASE WHEN SupBasicLife_Code IS NOT NULL THEN dbo.dsi_fnpadzero((ISNULL(SupBasicLife_BdmBenAmount,0)),8,0)  END
        --,SalaryMode7 = CASE WHEN SupBasicLife_Code IS NOT NULL THEN 'A' END
        --,SalaryAmount7 = CASE WHEN SupBasicLife_Code IS NOT NULL THEN dbo.dsi_fnpadzero((ISNULL(eecAnnSalary,0)),7,0) END
        --,CoverageCode8 = CASE WHEN SupSpouseLife_Code IS NOT NULL THEN 'LZ' END
        --,CoverageStartDate8 = CASE WHEN SupSpouseLife_Code IS NOT NULL THEN SupSpouseLife_BdmBenStartDate END
        --,CoverageStopDate8 = CASE WHEN SupSpouseLife_Code IS NOT NULL THEN SupSpouseLife_BdmBenStopDate END
        --,GroupNumber8 = CASE WHEN SupSpouseLife_Code IS NOT NULL THEN '5975462' END
        --,drvSubcode8 = CASE WHEN SupSpouseLife_Code IS NOT NULL THEN '0003' END
        --,drvBranch8 = CASE WHEN SupSpouseLife_Code is not null and  EXISTS(Select * from dbo.U_EMETPCRLIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP' )  and EecSalaryOrHourly = 'S' THEN 'H001' 
        --                   WHEN SupSpouseLife_Code is not null  and  EXISTS(Select * from dbo.U_EMETPCRLIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP' )  and EecSalaryOrHourly = 'H' THEN 'H003'
        --                   WHEN SupSpouseLife_Code is not null   and  EXISTS(Select * from dbo.U_EMETPCRLIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP' )   and EecSalaryOrHourly = 'S' THEN 'L002'
        --                   WHEN SupSpouseLife_Code is not null   and  EXISTS(Select * from dbo.U_EMETPCRLIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP'  )  and EecSalaryOrHourly = 'H' THEN 'L004'
        --                   WHEN SupSpouseLife_Code is not null THEN  'H001'
        --                   END
        --,StatusCode8 = CASE WHEN SupSpouseLife_Code IS NOT NULL THEN 'A' END
        --,MembersCoveredCode8 = CASE WHEN SupSpouseLife_Code IS NOT NULL THEN 'A' END
        --,AnnualBenefitAmount8 = CASE WHEN SupSpouseLife_Code IS NOT NULL THEN dbo.dsi_fnpadzero((ISNULL((Select top 1 Max(SupSpouseLife_BdmBenAmount) from dbo.U_EMETPCRLIF_Consolidated A where A.bdmeeid = B.bdmeeid and A.bdmcoid = B.bdmcoid  ),0)),8,0)  END
        --,CoverageCode9 = CASE WHEN SupChildrenLife_Code IS NOT NULL THEN 'LF' END
        --,CoverageStartDate9 =  CASE WHEN SupChildrenLife_Code IS NOT NULL THEN SupChildrenLife_BdmBenStartDate END
        --,CoverageStopDate9 =  CASE WHEN SupChildrenLife_Code IS NOT NULL THEN SupChildrenLife_BdmBenStopDate END
        --,GroupNumber9 =  CASE WHEN SupChildrenLife_Code IS NOT NULL THEN '5975462' END
        --,Subcode9 =  CASE WHEN SupChildrenLife_Code IS NOT NULL THEN '0003' END
        --,Branch9 = CASE WHEN SupChildrenLife_Code is not null and  EXISTS(Select * from dbo.U_EMETPCRLIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP' )  and EecSalaryOrHourly = 'S' THEN 'H001' 
        --                   WHEN SupChildrenLife_Code is not null  and  EXISTS(Select * from dbo.U_EMETPCRLIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP' )  and EecSalaryOrHourly = 'H' THEN 'H003'
        --                   WHEN SupChildrenLife_Code is not null   and  EXISTS(Select * from dbo.U_EMETPCRLIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP' )   and EecSalaryOrHourly = 'S' THEN 'L002'
        --                   WHEN SupChildrenLife_Code is not null   and  EXISTS(Select * from dbo.U_EMETPCRLIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP'  )  and EecSalaryOrHourly = 'H' THEN 'L004'
        --                   WHEN SupChildrenLife_Code is not null THEN  'H001'
        --                   END
        --,drvStatusCode9 = CASE WHEN SupChildrenLife_Code IS NOT NULL THEN 'A' END
        --,drvMembersCoveredCode9 = CASE WHEN SupChildrenLife_Code IS NOT NULL THEN 'C' END
        --,drvAnnualBenefitAmount9 =  CASE WHEN SupChildrenLife_Code IS NOT NULL THEN dbo.dsi_fnpadzero((ISNULL((Select top 1 Max(SupChildrenLife_BdmBenAmount) from dbo.U_EMETPCRLIF_Consolidated A where A.bdmeeid = B.bdmeeid and A.bdmcoid = B.bdmcoid  ) ,0)),8,0)   END
        --,drvCoverageCode10 = CASE WHEN SupBasicADD_Code IS NOT NULL THEN 'OD' END
        --,drvCoverageStartDate10 = CASE WHEN SupBasicADD_Code IS NOT NULL THEN SupBasicADD_BdmBenStartDate END
        --,drvCoverageStopDate10 = CASE WHEN SupBasicADD_Code IS NOT NULL THEN SupBasicADD_BdmBenStopDate END
        --,drvGroupNumber10 = CASE WHEN SupBasicADD_Code IS NOT NULL THEN '5975462' END
        --,drvSubcode10 = CASE WHEN SupBasicADD_Code IS NOT NULL THEN '0003' END
        --,drvBranch10 = CASE WHEN SupBasicADD_Code is not null and  EXISTS(Select * from dbo.U_EMETPCRLIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP' )  and EecSalaryOrHourly = 'S' THEN 'H001' 
        --                   WHEN SupBasicADD_Code is not null  and  EXISTS(Select * from dbo.U_EMETPCRLIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP' )  and EecSalaryOrHourly = 'H' THEN 'H003'
        --                   WHEN SupBasicADD_Code is not null   and  EXISTS(Select * from dbo.U_EMETPCRLIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP' )   and EecSalaryOrHourly = 'S' THEN 'L002'
        --                   WHEN SupBasicADD_Code is not null   and  EXISTS(Select * from dbo.U_EMETPCRLIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP'  )  and EecSalaryOrHourly = 'H' THEN 'L004'
        --                   WHEN SupBasicADD_Code is not null THEN  'H001'
        --                   END
        --,drvStatusCode10 = CASE WHEN SupBasicADD_Code IS NOT NULL THEN 'A' END
        --,drvMembersCoveredCode10 = CASE WHEN SupBasicADD_Code IS NOT NULL THEN '1' END
        --,drvAnnualBenefitAmount10 = CASE WHEN SupBasicADD_Code IS NOT NULL THEN dbo.dsi_fnpadzero((ISNULL((Select top 1 Max(SupBasicADD_BdmBenAmount) from dbo.U_EMETPCRLIF_Consolidated A where A.bdmeeid = B.bdmeeid and A.bdmcoid = B.bdmcoid  ) ,0)),8,0)  END
        --,drvSalaryMode10 = CASE WHEN SupBasicADD_Code IS NOT NULL THEN 'A' END
        --,drvSalaryAmount10 = CASE WHEN SupBasicADD_Code IS NOT NULL THEN dbo.dsi_fnpadzero((ISNULL(eecAnnSalary,0)),7,0) END
        --,drvCoverageCode11 = CASE WHEN SupSpouseADD_Code IS NOT NULL THEN 'AE' END
        --,drvCoverageStartDate11 = CASE WHEN SupSpouseADD_Code IS NOT NULL THEN SupSpouseADD_BdmBenStartDate END
        --,drvCoverageStopDate11 = CASE WHEN SupSpouseADD_Code IS NOT NULL THEN SupSpouseADD_BdmBenStopDate END
        --,drvGroupNumber11 = CASE WHEN SupSpouseADD_Code IS NOT NULL THEN '5975462' END
        --,drvSubcode11 = CASE WHEN SupSpouseADD_Code IS NOT NULL THEN '0003' END
        --,drvBranch11 =  CASE WHEN SupSpouseADD_Code is not null and  EXISTS(Select * from dbo.U_EMETPCRLIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP' )  and EecSalaryOrHourly = 'S' THEN 'H001' 
        --                   WHEN SupSpouseADD_Code is not null  and  EXISTS(Select * from dbo.U_EMETPCRLIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP' )  and EecSalaryOrHourly = 'H' THEN 'H003'
        --                   WHEN SupSpouseADD_Code is not null   and  EXISTS(Select * from dbo.U_EMETPCRLIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP' )   and EecSalaryOrHourly = 'S' THEN 'L002'
        --                   WHEN SupSpouseADD_Code is not null   and  EXISTS(Select * from dbo.U_EMETPCRLIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP'  )  and EecSalaryOrHourly = 'H' THEN 'L004'
        --                   WHEN SupSpouseADD_Code is not null THEN  'H001'
        --                END
        --,drvStatusCode11 = CASE WHEN SupSpouseADD_Code IS NOT NULL THEN 'A' END
        --,drvMembersCoveredCode11 = CASE WHEN SupSpouseADD_Code IS NOT NULL THEN 'A' END
        --,drvAnnualBenefitAmount11 = CASE WHEN SupSpouseADD_Code IS NOT NULL THEN dbo.dsi_fnpadzero((ISNULL((Select top 1 Max(SupSpouseADD_BdmBenAmount) from dbo.U_EMETPCRLIF_Consolidated A where A.bdmeeid = B.bdmeeid and A.bdmcoid = B.bdmcoid  ) ,0)),8,0) END
        --,drvCoverageCode12 = CASE WHEN SupChildADD_Code IS NOT NULL THEN 'AT' END
        --,drvCoverageStartDate12 = CASE WHEN SupChildADD_Code IS NOT NULL THEN SupChildADD_BdmBenStartDate END
        --,drvCoverageStopDate12 = CASE WHEN SupChildADD_Code IS NOT NULL THEN SupChildADD_BdmBenStopDate END
        --,drvGroupNumber12 = CASE WHEN SupChildADD_Code IS NOT NULL THEN '5975462' END
        --,drvSubcode12 = CASE WHEN SupChildADD_Code IS NOT NULL THEN '0003' END
        --,drvBranch12 = CASE WHEN SupChildADD_Code is not null and  EXISTS(Select * from dbo.U_EMETPCRLIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP' )  and EecSalaryOrHourly = 'S' THEN 'H001' 
        --                   WHEN SupChildADD_Code is not null  and  EXISTS(Select * from dbo.U_EMETPCRLIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP' )  and EecSalaryOrHourly = 'H' THEN 'H003'
        --                   WHEN SupChildADD_Code is not null   and  EXISTS(Select * from dbo.U_EMETPCRLIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP' )   and EecSalaryOrHourly = 'S' THEN 'L002'
        --                   WHEN SupChildADD_Code is not null   and  EXISTS(Select * from dbo.U_EMETPCRLIF_Consolidated A where A.bdmeeid =  B.bdmeeid and A.bdmcoid = B.bdmcoid and   A.Dental_Code is not null and bdmrectype ='EMP'  )  and EecSalaryOrHourly = 'H' THEN 'L004'
        --                   WHEN SupChildADD_Code is not null THEN  'H001'
        --                END
        --,drvStatusCode12 = CASE WHEN SupChildADD_Code IS NOT NULL THEN 'A' END
        --,drvMembersCoveredCode12 =  CASE WHEN SupChildADD_Code IS NOT NULL THEN 'C' END
        --,drvAnnualBenefitAmount12 = CASE WHEN SupChildADD_Code IS NOT NULL THEN dbo.dsi_fnpadzero((ISNULL((Select top 1 Max(SupChildADD_BdmBenAmount) from dbo.U_EMETPCRLIF_Consolidated A where A.bdmeeid = B.bdmeeid and A.bdmcoid = B.bdmcoid  ) ,0)),8,0) END
        --,drvEmployeeStatusCode = CASE WHEN GroupAccident_Code is not null  or  HospIndemity_Code is not null or CritIllness_Code is not null then
        --                             CASE WHEN eecemplstatus = 'T' and eectermreason ='203' THEN 'D' 
        --                                  WHEN eecemplstatus = 'T' and eectermreason ='202' THEN 'R'
        --                                  WHEN eecemplstatus = 'T' and eectermreason NOT IN('202','203') THEN 'T'
        --                                  ELSE 'A'
        --                            END

        --                        END
        --,drvStatusCodeEffectiveDate = CASE WHEN GroupAccident_Code is not null  or  HospIndemity_Code is not null or CritIllness_Code is not null then 
        --                                    CASE WHEN eecemplstatus = 'T' THEN eecdateoftermination ELSE eecdateoflasthire END 
        --                            END
        --,drvDepartmentCode = --CASE WHEN GroupAccident_Code is not null  or  HospIndemity_Code is not null or CritIllness_Code is not null then 
        --                    CASE WHEN eecOrglvl4 in ('ECHI') THEN '0025'
        --                          WHEN eecOrglvl4 in ('GCITY') THEN '0024'
        --                          WHEN eecOrglvl4 in ('HOUST') THEN '0022'
        --                          WHEN eecOrglvl4 in ('LOUDON') THEN '0026'
        --                          WHEN eecOrglvl4 in ('ADMIN', 'TRDMN') THEN '0027'
        --                          WHEN eecOrglvl4 in ('TULSA') THEN '0023'
        --                          WHEN eecOrglvl4 in ('WIND') THEN '0021'
        --                     END
        --                    --END
        --,drvGroupID = CASE WHEN (GroupAccident_Code is not null  or  HospIndemity_Code is not null or CritIllness_Code is not null) and  BdmRecType = 'EMP'  then '0009171692' END
        --,drvLocationID = CASE WHEN (GroupAccident_Code is not null  or  HospIndemity_Code is not null or CritIllness_Code is not null) and BdmRecType = 'EMP'  then '00005' END
        --,drvScheduleID = CASE WHEN (GroupAccident_Code is not null  or  HospIndemity_Code is not null or CritIllness_Code is not null) and BdmRecType = 'EMP'  then '0000031354' END
        --,drvPayFrequency = CASE WHEN (GroupAccident_Code is not null  or  HospIndemity_Code is not null or CritIllness_Code is not null) and BdmRecType = 'EMP'  then '12' END
        ,drvCoverageCode17 = CASE WHEN Vision_Code IS NOT NULL THEN 'VV' END
        ,drvCoverageStartDate17 = CASE WHEN Vision_Code IS NOT NULL THEN Vision_BdmBenStartDate END
        ,drvCoverageStopDate17 = CASE WHEN Vision_Code IS NOT NULL THEN Vision_BdmBenStopDate END
        ,drvGroupNumber17 = CASE WHEN Vision_Code IS NOT NULL  THEN '5977012' END
        ,drvSubcode17 = CASE WHEN Vision_Code IS NOT NULL THEN '0001' END
        ,drvBranch17 =  CASE WHEN br_denh = '1' AND br_vish = '1' THEN 'H001'
                             WHEN br_denh = '0' AND br_vish = '1' AND br_visl = '0' THEN 'H001'
                                WHEN br_denl = '1' AND br_vish = '1' AND EepAddressState <> 'TX' THEN 'L002'
                               -- WHEN br_denl = '1' AND br_vish = '0' AND br_visl = '0' AND EepAddressState <> 'TX' THEN 'L002'
                                WHEN br_denh = '1' AND br_visl = '1' THEN 'H003'
                                WHEN br_denl = '1' AND br_visl = '1' AND EepAddressState <> 'TX' THEN 'L004'
								WHEN br_denh = '0' AND br_vish = '0' AND br_visl = '1' AND EepAddressState <> 'TX' THEN 'L004' 
                            END
		--CASE WHEN VishDenh_Code IS NOT NULL THEN 'H001' 
  --                              WHEN VishDenl_Code IS NOT NULL AND EepAddressState <> 'TX' THEN 'L002'
  --                              WHEN VislDenh_Code IS NOT NULL THEN 'H003'
  --                              WHEN VislDenl_Code IS NOT NULL AND EepAddressState <> 'TX' THEN 'l004' END
        ,drvEnrollmentStatus17 = CASE WHEN Vision_Code IS NOT NULL THEN 'A' END
        ,drvMembersCoveredCode17 = CASE WHEN Vision_Code IS NOT NULL THEN 
                                        CASE WHEN Vision_BdmBenOption = 'EE' THEN '1'
                                                WHEN Vision_BdmBenOption = 'EEC' THEN '2'
                                                WHEN Vision_BdmBenOption IN ('EES', 'EEDP') THEN '3'
                                                WHEN Vision_BdmBenOption IN ('EEF', 'EEDPF') THEN '4'
                                            END
                                        END
              --                             CASE WHEN eecemplstatus = 'T' and eectermreason ='203' THEN 'D' 
        --                                  WHEN eecemplstatus = 'T' and eectermreason ='202' THEN 'R'
        --                                  WHEN eecemplstatus = 'T' and eectermreason NOT IN('202','203') THEN 'T'
        --                                  ELSE 'A'
        --                            END

        --                        END
          --,drvBenefitAmount17 = CASE WHEN BdmRecType = 'EMP' THEN 
    --                                CASE WHEN CRE10_DedCode IS NOT NULL THEN '00010000'
    --                                    WHEN CRE20_DedCode IS NOT NULL THEN '00020000'
    --                                    WHEN CRFM1_DedCode IS NOT NULL THEN '00010000'
    --                                    WHEN CRFM2_DedCode IS NOT NULL THEN '00020000'----------------this is the new ded code
    --                                    WHEN CRCH1_DedCode IS NOT NULL THEN '00020000'
    --                                    WHEN CRCH5_DedCode IS NOT NULL THEN '00010000'
    --                                    WHEN CRS10_DedCode IS NOT NULL THEN '00020000'
    --                                    WHEN CRS5_DedCode IS NOT NULL THEN '00010000'
    --                                END
    --                            END
        ,drvEmployeeStatusCode = CASE WHEN eecemplstatus = 'T' and eectermreason ='203' THEN 'D' 
                                          WHEN eecemplstatus = 'T' and eectermreason ='202' THEN 'R'
                                          WHEN eecemplstatus = 'T' and eectermreason NOT IN('202','203') THEN 'T'
                                          ELSE 'A'
                                    END
        ,drvStatusCodeEffectiveDate = CASE WHEN eecemplstatus = 'T' THEN eecdateoftermination ELSE eecdateoflasthire END 
        ,drvDepartmentCode = REPLACE(REPLACE(EecOrgLvl3, 'PC0', ''), 'PC', '')
        --SUBSTRING(EecOrgLvl3, PATINDEX('%[^0]%', EecOrgLvl3+'.'), LEN(EecOrgLvl3))
        --CASE WHEN GroupAccident_Code is not null  or  HospIndemity_Code is not null or CritIllness_Code is not null then 
                            --CASE WHEN eecOrglvl4 in ('ECHI') THEN '0025'
                            --      WHEN eecOrglvl4 in ('GCITY') THEN '0024'
                            --      WHEN eecOrglvl4 in ('HOUST') THEN '0022'
                            --      WHEN eecOrglvl4 in ('LOUDON') THEN '0026'
                            --      WHEN eecOrglvl4 in ('ADMIN', 'TRDMN') THEN '0027'
                            --      WHEN eecOrglvl4 in ('TULSA') THEN '0023'
                            --      WHEN eecOrglvl4 in ('WIND') THEN '0021'
                            -- END
                            --END
        ,drvGroupID = CASE WHEN (GroupAccident_Code is not null  or  HospIndemity_Code is not null or CritIllness_Code is not null) and  BdmRecType = 'EMP'  then '0009268941' END
        ,drvLocationID = CASE WHEN (GroupAccident_Code is not null  or  HospIndemity_Code is not null or CritIllness_Code is not null) and BdmRecType = 'EMP'  then '00003' END
        ,drvScheduleID = CASE WHEN (GroupAccident_Code is not null  or  HospIndemity_Code is not null or CritIllness_Code is not null) and BdmRecType = 'EMP'  then '0000031789' END
        ,drvPayFrequency = CASE WHEN (GroupAccident_Code is not null  or  HospIndemity_Code is not null or CritIllness_Code is not null) and BdmRecType = 'EMP'  then '12' END
        ,drvCoverageCode19 = CASE WHEN CritIllness_Code IS NOT NULL and BdmRecType = 'EMP' THEN 'GE' END
        ,drvCoverageStartDate19 = CASE WHEN CritIllness_Code IS NOT NULL  and BdmRecType = 'EMP' THEN CritIllness_BdmBenStartDate END
        ,drvCoverageStopDate19 = CASE WHEN CritIllness_Code IS NOT NULL and BdmRecType = 'EMP' THEN CritIllness_BdmBenStopDate END
        ,drvGroupNumber19 = CASE WHEN CritIllness_Code IS NOT NULL  and BdmRecType = 'EMP'THEN '0233823' END
        ,drvSubcode19 = CASE WHEN CritIllness_Code IS NOT NULL  and BdmRecType = 'EMP'THEN '0001' END
        ,drvBranch19 = CASE WHEN CritIllness_Code IS NOT NULL  and BdmRecType = 'EMP'THEN '0001' END
        ,drvMembersCoveredCode19 = CASE WHEN CritIllness_Code IS NOT NULL  and BdmRecType = 'EMP' THEN '1' END
        ,drvEnrollmentStatus19 = CASE WHEN CritIllness_Code IS NOT NULL  and BdmRecType = 'EMP' THEN 'P' END
        ,drvBenefitAmount19 = CASE WHEN CritIllness_Code IS NOT NULL and BdmRecType = 'EMP' THEN dbo.dsi_fnpadzero((ISNULL((Select max(CritIllness_BdmBenAmount)  from U_EMETPCRLIF_Consolidated C  where C.bdmeeid = B.bdmeeid),0)),8,0)  END
        --CASE WHEN BdmRecType = 'EMP' THEN 
  --                                  CASE WHEN CRE10_DedCode IS NOT NULL THEN '00010000'
  --                                      WHEN CRE20_DedCode IS NOT NULL THEN '00020000'
  --                                      WHEN CRFM1_DedCode IS NOT NULL THEN '00010000'
  --                                      WHEN CRFM2_DedCode IS NOT NULL THEN '00020000'----------------this is the new ded code
  --                                      WHEN CRCH1_DedCode IS NOT NULL THEN '00020000'
  --                                      WHEN CRCH5_DedCode IS NOT NULL THEN '00010000'
  --                                      WHEN CRS10_DedCode IS NOT NULL THEN '00020000'
  --                                      WHEN CRS5_DedCode IS NOT NULL THEN '00010000'
  --                                  END
  --                              END
                                /*CASE WHEN CRE10_DedCode IS NOT NULL THEN '00010000'
                                    WHEN CRE20_DedCode IS NOT NULL THEN '00020000'
                                    WHEN CRFM1_DedCode IS NOT NULL THEN '00010000'
                                    WHEN CRE20_DedCode IS NOT NULL THEN '00020000'
                                    WHEN CRCH1_DedCode IS NOT NULL THEN '00010000'
                                    WHEN CRCH5_DedCode IS NOT NULL THEN '00005000'
                                    WHEN CRS10_DedCode IS NOT NULL THEN '00010000'
                                    WHEN CRS5_DedCode IS NOT NULL THEN '00005000'
                                END*/
                                /*CASE WHEN CritIllness_Code IS NOT NULL  and BdmRecType = 'EMP' THEN 
                                    dbo.dsi_fnpadzero((ISNULL((Select max(CritIllness_BdmBenAmount) from U_EMETPCRLIF_Consolidated C  where C.bdmeeid = B.bdmeeid),0)),8,0)  
                                END*/
        ,drvVoluntaryCancellationInd19 = CASE WHEN EecEmplStatus = 'A' AND CritIllness_Code IS NOT NULL  and BdmRecType = 'EMP' and CritIllness_BdmBenStatus <> 'A' THEN 'CE' END
        ,drvTaveoverIndicator19 = ''
        --CASE WHEN CritIllness_Code IS NOT NULL  and BdmRecType = 'EMP' THEN '' END
        ,drvCoverageCode20 = CASE WHEN CritIllnessDep_Code IS NOT NULL THEN 'GD' END
        ,drvCoverageStartDate20 = CASE WHEN CritIllnessDep_Code IS NOT NULL THEN CritIllnessDep_BdmBenStartDate END
        ,drvCoverageStopDate20 = CASE WHEN CritIllnessDep_Code IS NOT NULL THEN CritIllnessDep_BdmBenStopDate END
        ,drvGroupNumber20 = CASE WHEN CritIllnessDep_Code IS NOT NULL THEN '0233823' END
        ,drvSubcode20 = CASE WHEN CritIllnessDep_Code IS NOT NULL THEN '0001' END
        ,drvBranch20 = CASE WHEN CritIllnessDep_Code IS NOT NULL THEN '0001' END
        ,drvMembersCoveredCode20 = CASE WHEN CritIllnessDep_Code IS NOT NULL THEN '4' END
        ,drvEnrollmentStatus20 = CASE WHEN CritIllnessDep_Code IS NOT NULL THEN 'P' END
        ,drvBenefitAmount20 = CASE WHEN CritIllnessDep_Code IS NOT NULL THEN dbo.dsi_fnpadzero((ISNULL((Select max(CritIllnessDep_BdmBenAmount)  from U_EMETPCRLIF_Consolidated C  where C.bdmeeid = B.bdmeeid),0)),8,0)  END
        ,drvVoluntaryCancellationInd20 = CASE WHEN EecEmplStatus = 'A' AND CritIllnessDep_Code IS NOT NULL  and CritIllnessDep_BdmBenStatus <> 'A' THEN 'CE' END
        --,drvBenefitAmount20 =    CASE WHEN CRCH1_DedCode IS NOT NULL THEN '00010000'
        --                            WHEN CRCH5_DedCode IS NOT NULL THEN '00005000'
        --                            WHEN CRS10_DedCode IS NOT NULL THEN '00010000'
        --                            WHEN CRS5_DedCode IS NOT NULL THEN '00005000'
        --                            WHEN CRFM1_DedCode IS NOT NULL THEN '00005000'
        --                            WHEN CRFM2_DedCode IS NOT NULL THEN '00010000'
        --                        END
        
                                /*CASE WHEN CRCH1_DedCode IS NOT NULL THEN '00005000'
                                    WHEN CRCH5_DedCode IS NOT NULL THEN '00002500'
                                    WHEN CRS10_DedCode IS NOT NULL THEN '00005000'
                                    WHEN CRS5_DedCode IS NOT NULL THEN '00002500'
                                    WHEN CRFM1_DedCode IS NOT NULL THEN '00005000'
                                    WHEN CRE20_DedCode IS NOT NULL THEN '00010000'
                                END*/
        
                                --CASE WHEN CritIllnessDep_Code IS NOT NULL THEN dbo.dsi_fnpadzero((ISNULL((Select max(cast(CritIllnessDep_BdmBenAmount as money) / 2 )  from U_EMETPCRLIF_Consolidated C  where C.bdmeeid = B.bdmeeid),0)),8,0)  END
        ,drvCoverageCode23 = CASE WHEN GroupAccident_Code IS  NOT NULL THEN 'AH' END
        ,drvCoverageStartDate23 = CASE WHEN GroupAccident_Code IS  NOT NULL THEN GroupAccident_BdmBenStartDate END
        ,drvCoverageStopDate23 = CASE WHEN GroupAccident_Code IS  NOT NULL THEN GroupAccident_BdmBenStopDate END
        ,drvGroupNumber23 = CASE WHEN GroupAccident_Code IS  NOT NULL THEN '0233822' END
        ,drvSubcode23 = CASE WHEN GroupAccident_Code IS  NOT NULL THEN '0001' END
        ,drvBranch23 = CASE WHEN GroupAccident_Code ='ACCH' THEN '0001' 
                            WHEN GroupAccident_Code ='ACC' THEN '0003' 
                            END
        ,drvMembersCoveredCode23 = CASE WHEN GroupAccident_Code IS  NOT NULL THEN 
                                            CASE WHEN GroupAccident_BdmBenOption in ('EE') THEN '1'
                                                 WHEN GroupAccident_BdmBenOption in ('EEC') THEN '2'
                                                 WHEN GroupAccident_BdmBenOption in ('EES', 'EEDP') THEN '3'
                                                 WHEN GroupAccident_BdmBenOption in ('EEF', 'EEDPF') THEN '4'
                                            END
                                   END
        ,drvEnrollmentStatus23 = CASE WHEN GroupAccident_Code IS  NOT NULL THEN 'P' END
        ,drvVoluntaryCancellationInd23 = CASE WHEN EecEmplStatus = 'A' AND GroupAccident_Code IS  NOT NULL and  GroupAccident_BdmBenStatus <> 'A' THEN 'CE' END
        ,drvTakeoverIndicator23 = CASE WHEN GroupAccident_Code IS  NOT NULL THEN '' END
        ,drvCoverageCode24 = CASE WHEN HospIndemity_Code IS NOT NULL THEN 'HH' END
        ,drvCoverageStartDate24 = CASE WHEN HospIndemity_Code IS NOT NULL THEN HospIndemity_BdmBenStartDate END
        ,drvCoverageStopDate24 = CASE WHEN HospIndemity_Code IS NOT NULL THEN HospIndemity_BdmBenStopDate END
        ,drvGroupNumber24 = CASE WHEN HospIndemity_Code IS NOT NULL THEN '0233823' END
        ,drvSubcode24 = CASE WHEN HospIndemity_Code IS NOT NULL THEN '0001' END
        ,drvBranch24 = CASE WHEN HospIndemity_Code IN ('HOSPH') THEN '0001' 
                            WHEN HospIndemity_Code IN ('HOSP') THEN '0003'
                        END
        ,drvMembersCoveredCode24 = CASE WHEN HospIndemity_Code IS NOT NULL THEN 
                    CASE WHEN HospIndemity_BdmBenOption in ('EE') THEN '1'
                                                 WHEN HospIndemity_BdmBenOption in ('EEC') THEN '2'
                                                 WHEN HospIndemity_BdmBenOption in ('EES', 'EEDP') THEN '3'
                                                 WHEN HospIndemity_BdmBenOption in ('EEF', 'EEDPF') THEN '4'
                                            END END
        ,drvEnrollmentStatus24 = CASE WHEN HospIndemity_Code IS NOT NULL THEN 'P' END
        ,drvVoluntaryCancellationInd24 = CASE WHEN EecEmplStatus = 'A' AND HospIndemity_Code IS NOT NULL and HospIndemity_BdmBenStatus <> 'A' THEN 'CE' END
        ,drvTakeoverIndicator24 = CASE WHEN HospIndemity_Code IS NOT NULL THEN '' END
		,drvB1DedCode = ''
    INTO dbo.U_EMETPCRLIF_drvTbl
    FROM dbo.U_EMETPCRLIF_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
        AND (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                                        and EXISTS(select 1 from dbo.U_EMETPCRLIF_Audit where  audKey1Value = xEEID AND audKey2Value = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    JOIN dbo.U_EMETPCRLIF_Consolidated AS B
        ON BdmEEID = xEEID 
        AND BdmCOID = xCOID
         LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecId
    JOIN dbo.U_EMETPCRLIF_coverage WITH(NOLOCK)
        ON bdmeeid_count = bdmeeid and bdmcoid_count = bdmcoid
    LEFT JOIN (SELECT DISTINCT br_eeid, br_contactid, br_vish, br_visl, br_denh, br_denl
				FROM dbo.U_EMETPCRLIF_branch a WITH(NOLOCK)) br on br.br_eeid = b.bdmeeid and ISNULL(br.br_contactid, '') = ISNULL(consystemid, '') 
  
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
ALTER VIEW dbo.dsi_vwEMETPCRLIF_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EMETPCRLIF_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EMETPCRLIF%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202102021'
       ,expStartPerControl     = '202102021'
       ,expLastEndPerControl   = '202102099'
       ,expEndPerControl       = '202102099'
WHERE expFormatCode = 'EMETPCRLIF';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEMETPCRLIF_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EMETPCRLIF_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort, SubSort2