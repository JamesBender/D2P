SET NOCOUNT ON;
/*
Directions:
1) Find and replace each of the text below with the applicable information.
       E.g. Replace the text "@DeveloperName" (excluding quotes) with "John Doe"
2) Deploy this to client environment!

-- Integration parameters
@CustomerName - Replace with customer name
@DeveloperName - Replace with TC name
@IntegrationAnalystName - Replace with BA/IC name
@CreateDate - Replace with date of creation
@SRNumber - Replace with SR number
@IsWebFlag - Replace with 'Y' (Yes) or 'N' (No) for Web Interface Settings

-- File parameters
@FileExportPath - Replace with the Export Path where the file generates to (i.e., \\us.saas\e1\Public\[Client ARNum]\Exports\MassMutual\)
@FileTestPath - Replace with the Test Path where the file generates to (i.e., \\us.saas\e1\Public\[Client ARNum]\Exports\MassMutual\)
@FileUDESPath - Replace with the UDES Path where the file generates to (i.e., \\us.saas\e0\data_exchange\[Client ARNum]\Exports\)

--Data Parameters
@ContractNumber - Replace with the contract number from the spec (Field#3 - Master Contact Number)
@DemoFileDesc - Replace with the Demographics File Description (Field#4 - File Description)
@ContribFileDesc - Replace with the Contributions File Description (Field#4 - File Description)
@CompFileDesc - Replace with the Compensation File Description (Field#4 - File Description)
@SubSetCode - Replace with the SubSet Code information from the Spec (Field#6 NOTE: This will likely be a case statement)
@Location - Replace with the Location information from the Spec (Field#5 NOTE: This will likely be a case statement)
@DSCodes - Replace with the deduction codes mapped to DS in contribution Layout (Ex:'401K','401KC')
@ROTHCodes - Replace with the deduction codes mapped to ROTH in contribution Layout (Ex:'401KR','401RC')
@LoanCodes - Replace with the deduction codes mapped to PLAN1 OR LOAN1 in Loan Layout (Ex:'401L1','401L2')

Go thru the driver table code to update fields pertaining to your client
*/
IF OBJECT_ID('dsi_vwEMASMUTUAL_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEMASMUTUAL_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EMASMUTUAL') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMASMUTUAL];
GO
IF OBJECT_ID('U_EMASMUTUAL_PTaxHist') IS NOT NULL DROP TABLE [dbo].[U_EMASMUTUAL_PTaxHist];
GO
IF OBJECT_ID('U_EMASMUTUAL_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EMASMUTUAL_PEarHist];
GO
IF OBJECT_ID('U_EMASMUTUAL_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EMASMUTUAL_PDedHist];
GO
IF OBJECT_ID('U_EMASMUTUAL_Header') IS NOT NULL DROP TABLE [dbo].[U_EMASMUTUAL_Header];
GO
IF OBJECT_ID('U_EMASMUTUAL_HdrRecords') IS NOT NULL DROP TABLE [dbo].[U_EMASMUTUAL_HdrRecords];
GO
IF OBJECT_ID('U_EMASMUTUAL_File') IS NOT NULL DROP TABLE [dbo].[U_EMASMUTUAL_File];
GO
IF OBJECT_ID('U_EMASMUTUAL_EEList') IS NOT NULL DROP TABLE [dbo].[U_EMASMUTUAL_EEList];
GO
IF OBJECT_ID('U_EMASMUTUAL_Demo_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EMASMUTUAL_Demo_Trailer];
GO
IF OBJECT_ID('U_EMASMUTUAL_Demo_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EMASMUTUAL_Demo_drvTbl];
GO
IF OBJECT_ID('U_EMASMUTUAL_DedList') IS NOT NULL DROP TABLE [dbo].[U_EMASMUTUAL_DedList];
GO
IF OBJECT_ID('U_EMASMUTUAL_Cont_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EMASMUTUAL_Cont_Trailer];
GO
IF OBJECT_ID('U_EMASMUTUAL_Cont_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EMASMUTUAL_Cont_drvTbl];
GO
IF OBJECT_ID('U_EMASMUTUAL_Comp_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EMASMUTUAL_Comp_Trailer];
GO
IF OBJECT_ID('U_EMASMUTUAL_Comp_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EMASMUTUAL_Comp_drvTbl];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EMASMUTUAL';
DELETE [dbo].[U_dsi_RecordSetDetails] FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode = 'EMASMUTUAL';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EMASMUTUAL';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EMASMUTUAL';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EMASMUTUAL';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EMASMUTUAL';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EMASMUTUAL','Mass Mutual 401K Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','EMASMUTUALZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMASMUTUALZ0','4','H','01','1',NULL,'Record Type',NULL,NULL,'"HDR"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMASMUTUALZ0','4','H','01','5',NULL,'Record Version Number',NULL,NULL,'"0001"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EMASMUTUALZ0','6','H','01','9',NULL,'Master Contract Number',NULL,NULL,'"drvContractNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EMASMUTUALZ0','30','H','01','15',NULL,'File Description',NULL,NULL,'"drvFileDescription"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EMASMUTUALZ0','8','H','01','45',NULL,'Scheduled Transmission Date',NULL,NULL,'"drvTransmissionDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EMASMUTUALZ0','8','H','01','53',NULL,'Actual Transmission Date',NULL,NULL,'"drvActTransmissionDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EMASMUTUALZ0','4','H','01','61',NULL,'Actual Transmission Time',NULL,NULL,'"drvActTransmissionTime"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EMASMUTUALZ0','2','H','01','65',NULL,'Actual Transmission Number',NULL,NULL,'"01"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMASMUTUALZ0','4','H','20','1',NULL,'Record Type',NULL,NULL,'"HDR"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMASMUTUALZ0','4','H','20','5',NULL,'Record Version Number',NULL,NULL,'"0001"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EMASMUTUALZ0','6','H','20','9',NULL,'Master Contract Number',NULL,NULL,'"drvContractNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EMASMUTUALZ0','30','H','20','15',NULL,'File Description',NULL,NULL,'"drvFileDescription"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EMASMUTUALZ0','8','H','20','45',NULL,'Scheduled Transmission Date',NULL,NULL,'"drvTransmissionDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EMASMUTUALZ0','8','H','20','53',NULL,'Actual Transmission Date',NULL,NULL,'"drvActTransmissionDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EMASMUTUALZ0','4','H','20','61',NULL,'Actual Transmission Time',NULL,NULL,'"drvActTransmissionTime"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EMASMUTUALZ0','2','H','20','65',NULL,'Actual Transmission Number',NULL,NULL,'"01"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMASMUTUALZ0','4','H','40','1',NULL,'Record Type',NULL,NULL,'"HDR"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMASMUTUALZ0','4','H','40','5',NULL,'Record Version Number',NULL,NULL,'"0001"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EMASMUTUALZ0','6','H','40','9',NULL,'Master Contract Number',NULL,NULL,'"drvContractNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EMASMUTUALZ0','30','H','40','15',NULL,'File Description',NULL,NULL,'"drvFileDescription"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EMASMUTUALZ0','8','H','40','45',NULL,'Scheduled Transmission Date',NULL,NULL,'"drvTransmissionDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EMASMUTUALZ0','8','H','40','53',NULL,'Actual Transmission Date',NULL,NULL,'"drvActTransmissionDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EMASMUTUALZ0','4','H','40','61',NULL,'Actual Transmission Time',NULL,NULL,'"drvActTransmissionTime"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EMASMUTUALZ0','2','H','40','65',NULL,'Actual Transmission Number',NULL,NULL,'"01"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMASMUTUALZ0','4','D','10','1',NULL,'Record Type',NULL,NULL,'"DEMO"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMASMUTUALZ0','4','D','10','5',NULL,'Record Version Number',NULL,NULL,'"0001"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EMASMUTUALZ0','6','D','10','9',NULL,'Master Contract Number',NULL,NULL,'"drvContractNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EMASMUTUALZ0','12','D','10','15',NULL,'Subsidiary EIN',NULL,NULL,'"drvEIN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EMASMUTUALZ0','8','D','10','27',NULL,'Location Code',NULL,NULL,'"drvLocation"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EMASMUTUALZ0','12','D','10','35',NULL,'Subset Code',NULL,NULL,'"drvSubsetCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EMASMUTUALZ0','9','D','10','47',NULL,'Social Security Number',NULL,NULL,'"drvSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EMASMUTUALZ0','4','D','10','56',NULL,'Prefix Name',NULL,NULL,'"drvNamePrefix"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EMASMUTUALZ0','15','D','10','60',NULL,'First Name',NULL,NULL,'"drvNameFirst"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EMASMUTUALZ0','10','D','10','75',NULL,'Middle Name',NULL,NULL,'"drvNameMiddle"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EMASMUTUALZ0','20','D','10','85',NULL,'Last Name',NULL,NULL,'"drvNameLast"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EMASMUTUALZ0','8','D','10','105',NULL,'Suffix Name',NULL,NULL,'"drvNameSuffix"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EMASMUTUALZ0','35','D','10','113',NULL,'Address Line 1',NULL,NULL,'"drvAddressLine1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EMASMUTUALZ0','35','D','10','148',NULL,'Address Line 2',NULL,NULL,'"drvAddressLine2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EMASMUTUALZ0','35','D','10','183',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EMASMUTUALZ0','35','D','10','218',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EMASMUTUALZ0','2','D','10','253',NULL,'State',NULL,NULL,'"drvState"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EMASMUTUALZ0','10','D','10','255',NULL,'Zip Code',NULL,NULL,'"drvZipCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EMASMUTUALZ0','2','D','10','265',NULL,'Country',NULL,NULL,'"drvCountry"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EMASMUTUALZ0','12','D','10','267',NULL,'Telephone Number',NULL,NULL,'"drvPhoneHomeNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EMASMUTUALZ0','12','D','10','279',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EMASMUTUALZ0','35','D','10','291',NULL,'Email Address',NULL,NULL,'"drvAddressEmail"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EMASMUTUALZ0','8','D','10','326',NULL,'Birth Date',NULL,NULL,'"drvDateOfBirth"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EMASMUTUALZ0','8','D','10','334',NULL,'Hire Date',NULL,NULL,'"drvDateOfOriginalHire"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EMASMUTUALZ0','1','D','10','342',NULL,'Gender Code',NULL,NULL,'"drvGender"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EMASMUTUALZ0','2','D','10','343',NULL,'Language Code',NULL,NULL,'"EN"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EMASMUTUALZ0','1','D','10','345',NULL,'Marital Status',NULL,NULL,'"drvMaritalStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EMASMUTUALZ0','8','D','10','346',NULL,'Employment Class',NULL,NULL,'"drvEmploymentClass"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EMASMUTUALZ0','8','D','10','354',NULL,'Employment Status',NULL,NULL,'"drvEmploymentStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EMASMUTUALZ0','8','D','10','362',NULL,'Employment Status Changed Date',NULL,NULL,'"drvEmpStatusChangeDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EMASMUTUALZ0','1','D','10','370',NULL,'Key Employee Indicator',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EMASMUTUALZ0','1','D','10','371',NULL,'16B Indicator',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EMASMUTUALZ0','1','D','10','372',NULL,'Payroll Status',NULL,NULL,'"drvPayrollStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EMASMUTUALZ0','2','D','10','373',NULL,'Payroll Frequency',NULL,NULL,'"drvPayFrequency"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMASMUTUALZ0','4','D','25','1',NULL,'Record Type',NULL,NULL,'"CONT"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMASMUTUALZ0','4','D','25','5',NULL,'Record Version Number',NULL,NULL,'"0001"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EMASMUTUALZ0','6','D','25','9',NULL,'Master Contract Number',NULL,NULL,'"drvContractNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EMASMUTUALZ0','8','D','25','15',NULL,'Plan Code',NULL,NULL,'"PLAN1"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EMASMUTUALZ0','12','D','25','23',NULL,'Subsidiary EIN',NULL,NULL,'"drvEIN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EMASMUTUALZ0','9','D','25','35',NULL,'Social Security Number',NULL,NULL,'"drvSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EMASMUTUALZ0','8','D','25','44',NULL,'Payroll Date (Effective Date)',NULL,NULL,'"drvPayrollDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EMASMUTUALZ0','8','D','25','52',NULL,'Payroll Period Start Date',NULL,NULL,'"drvPeriodStart"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EMASMUTUALZ0','8','D','25','60',NULL,'Payroll Period End Date',NULL,NULL,'"drvPeriodEnd"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EMASMUTUALZ0','5','D','25','68',NULL,'Contribution Source Code',NULL,NULL,'"drvContributionSource"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EMASMUTUALZ0','12','D','25','73',NULL,'Contribution Amount',NULL,NULL,'"drvContributionAmount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMASMUTUALZ0','4','D','30','1',NULL,'Record Type',NULL,NULL,'"LNRP"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMASMUTUALZ0','4','D','30','5',NULL,'Record Version Number',NULL,NULL,'"0001"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EMASMUTUALZ0','6','D','30','9',NULL,'Master Contract Number',NULL,NULL,'"drvContractNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EMASMUTUALZ0','8','D','30','15',NULL,'Plan Code',NULL,NULL,'"PLAN1"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EMASMUTUALZ0','12','D','30','23',NULL,'Subsidiary EIN',NULL,NULL,'"drvEIN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EMASMUTUALZ0','9','D','30','35',NULL,'Social Security Number',NULL,NULL,'"drvSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EMASMUTUALZ0','8','D','30','44',NULL,'Payroll Date (Effective Date)',NULL,NULL,'"drvPayrollDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EMASMUTUALZ0','8','D','30','52',NULL,'Payroll Period End Date',NULL,NULL,'"drvPeriodEnd"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EMASMUTUALZ0','12','D','30','60',NULL,'Amount',NULL,NULL,'"drvContributionAmount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMASMUTUALZ0','4','D','45','1',NULL,'Record Type',NULL,NULL,'"COMP"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMASMUTUALZ0','4','D','45','5',NULL,'Record Version Number',NULL,NULL,'"0001"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EMASMUTUALZ0','6','D','45','9',NULL,'Master Contract Number',NULL,NULL,'"drvContractNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EMASMUTUALZ0','12','D','45','15',NULL,'Subsidiary EIN',NULL,NULL,'"drvEIN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EMASMUTUALZ0','9','D','45','27',NULL,'Social Security Number',NULL,NULL,'"drvSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EMASMUTUALZ0','8','D','45','36',NULL,'Effective Date',NULL,NULL,'"drvPayDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EMASMUTUALZ0','8','D','45','44',NULL,'Effective Start Date',NULL,NULL,'"drvEffectiveStartDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EMASMUTUALZ0','8','D','45','52',NULL,'Effective Thru Date',NULL,NULL,'"drvPeriodEndDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EMASMUTUALZ0','12','D','45','60',NULL,'Salary for Contributions',NULL,NULL,'"drvContribSalary"','(''UNP2''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EMASMUTUALZ0','12','D','45','72',NULL,'Salary for 415 Testing',NULL,NULL,'"drv415Salary"','(''UNP2''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EMASMUTUALZ0','12','D','45','84',NULL,'Salary for ADP Testing',NULL,NULL,'"drvADPSalary"','(''UNP2''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EMASMUTUALZ0','4','D','45','96',NULL,'Hours Worked',NULL,NULL,'"drvHoursWorked"','(''UN0''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMASMUTUALZ0','4','T','15','1',NULL,'Record Type',NULL,NULL,'"DMTR"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMASMUTUALZ0','4','T','15','5',NULL,'Record Version Number',NULL,NULL,'"0001"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EMASMUTUALZ0','6','T','15','9',NULL,'Master Contract Number',NULL,NULL,'"drvContractNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EMASMUTUALZ0','12','T','15','15',NULL,'Total File Records',NULL,NULL,'"drvDetailCount"','(''UN0''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMASMUTUALZ0','4','T','35','1',NULL,'Record Type',NULL,NULL,'"CNTR"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMASMUTUALZ0','4','T','35','5',NULL,'Record Version Number',NULL,NULL,'"0001"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EMASMUTUALZ0','6','T','35','9',NULL,'Master Contract Number',NULL,NULL,'"drvContractNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EMASMUTUALZ0','12','T','35','15',NULL,'Total File Records',NULL,NULL,'"drvDetailCount"','(''UN0''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EMASMUTUALZ0','12','T','35','27',NULL,'Total Contribution Records',NULL,NULL,'"drvContributionRecords"','(''UN0''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EMASMUTUALZ0','12','T','35','39',NULL,'Total Contribution Amount',NULL,NULL,'"drvContributionAmount"','(''UN0''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EMASMUTUALZ0','12','T','35','51',NULL,'Total Loan Repayment Records',NULL,NULL,'"drvLoanRecords"','(''UN0''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EMASMUTUALZ0','12','T','35','63',NULL,'Total Loan Repayment Amount',NULL,NULL,'"drvLoanAmount"','(''UN0''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMASMUTUALZ0','4','T','50','1',NULL,'Record Type',NULL,NULL,'"CPTR"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMASMUTUALZ0','4','T','50','5',NULL,'Record Version Number',NULL,NULL,'"0001"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EMASMUTUALZ0','6','T','50','9',NULL,'Master Contract Number',NULL,NULL,'"drvContractNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EMASMUTUALZ0','12','T','50','15',NULL,'Total File Records',NULL,NULL,'"drvDetailCount"','(''UN0''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EMASMUTUALZ0','12','T','50','27',NULL,'Total Salary for Compensation Records',NULL,NULL,'"drvCompRecords"','(''UN0''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EMASMUTUALZ0','12','T','50','39',NULL,'Total Salary for Contributions',NULL,NULL,'"drvSalaryContribTotal"','(''UNP2''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EMASMUTUALZ0','12','T','50','51',NULL,'Total Salary for 415 Testing',NULL,NULL,'"drv415SalaryTotal"','(''UNP2''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EMASMUTUALZ0','12','T','50','63',NULL,'Total Salary for ADP Testing',NULL,NULL,'"drvADPSalaryTotal"','(''UNP2''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EMASMUTUALZ0','12','T','50','75',NULL,'Total Hours Worked',NULL,NULL,'"drvTotalHours"','(''UN0''=''F'')');
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expCOIDList,expIEXSystemID) VALUES ('File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,'Test Compensation Export',CONVERT(CHAR(8),GETDATE(),112) + '1','EMPEXPORT','TEST_COMP','Oct  1 2018  1:58PM','EMASMUTUAL',NULL,NULL,NULL,CONVERT(CHAR(8),GETDATE(),112) + '1','Oct  1 2018 12:00AM','Dec 30 1899 12:00AM',CONVERT(CHAR(8),GETDATE(),112) + '1',NULL,'','',CONVERT(CHAR(8),GETDATE(),112) + '1',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL,NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expCOIDList,expIEXSystemID) VALUES ('File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,'Test Contribution Loans Export',CONVERT(CHAR(8),GETDATE(),112) + '1','EMPEXPORT','TEST_CONT','Oct  1 2018 12:02PM','EMASMUTUAL',NULL,NULL,NULL,CONVERT(CHAR(8),GETDATE(),112) + '1','Oct  1 2018 12:00AM','Dec 30 1899 12:00AM',CONVERT(CHAR(8),GETDATE(),112) + '1',NULL,'','',CONVERT(CHAR(8),GETDATE(),112) + '1',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL,NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expCOIDList,expIEXSystemID) VALUES ('File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,'Test Demographics Export',CONVERT(CHAR(8),GETDATE(),112) + '1','EMPEXPORT','TEST_DEMO','Oct  1 2018 12:03PM','EMASMUTUAL',NULL,NULL,NULL,CONVERT(CHAR(8),GETDATE(),112) + '1','Oct  1 2018 12:00AM','Dec 30 1899 12:00AM',CONVERT(CHAR(8),GETDATE(),112) + '1',NULL,'','',CONVERT(CHAR(8),GETDATE(),112) + '1',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL,NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expCOIDList,expIEXSystemID) VALUES ('File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,'Compensation Export',CONVERT(CHAR(8),GETDATE(),112) + '1','EMPEXPORT','COMP','Oct  1 2018 12:09PM','EMASMUTUAL',NULL,NULL,NULL,CONVERT(CHAR(8),GETDATE(),112) + '1','Sep 28 2018 12:00AM','Sep 22 2018 12:00AM',CONVERT(CHAR(8),GETDATE(),112) + '1',NULL,'','',CONVERT(CHAR(8),GETDATE(),112) + '1',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL,NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expCOIDList,expIEXSystemID) VALUES ('File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,'Contribution Loan Export',CONVERT(CHAR(8),GETDATE(),112) + '1','EMPEXPORT','CONTRIB','Oct  1 2018 12:09PM','EMASMUTUAL',NULL,NULL,NULL,CONVERT(CHAR(8),GETDATE(),112) + '1','Oct  1 2018 12:00AM','Dec 30 1899 12:00AM',CONVERT(CHAR(8),GETDATE(),112) + '1',NULL,'','',CONVERT(CHAR(8),GETDATE(),112) + '1',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL,NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expCOIDList,expIEXSystemID) VALUES ('File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,'Demographics Export',CONVERT(CHAR(8),GETDATE(),112) + '1','EMPEXPORT','DEMO','Oct  1 2018 12:10PM','EMASMUTUAL',NULL,NULL,NULL,CONVERT(CHAR(8),GETDATE(),112) + '1','Oct  1 2018 12:00AM','Dec 30 1899 12:00AM',CONVERT(CHAR(8),GETDATE(),112) + '1',NULL,'','',CONVERT(CHAR(8),GETDATE(),112) + '1',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL,NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMASMUTUAL','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMASMUTUAL','ExportPath','V','@FileExportPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMASMUTUAL','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMASMUTUAL','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMASMUTUAL','TestPath','V','@FileTestPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMASMUTUAL','UDESPath','V','@FileUDESPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMASMUTUAL','UseFileName','V','N');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','DEMO','H','20','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','DEMO','D','25','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','DEMO','D','30','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','DEMO','T','35','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','DEMO','H','40','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','DEMO','D','45','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','DEMO','T','50','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','TEST_DEMO','H','20','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','TEST_DEMO','D','25','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','TEST_DEMO','D','30','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','TEST_DEMO','T','35','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','TEST_DEMO','H','40','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','TEST_DEMO','D','45','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','TEST_DEMO','T','50','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','CONTRIB','H','01','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','CONTRIB','D','10','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','CONTRIB','T','15','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','CONTRIB','H','40','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','CONTRIB','D','45','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','CONTRIB','T','50','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','TEST_CONT','H','01','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','TEST_CONT','D','10','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','TEST_CONT','T','15','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','TEST_CONT','H','40','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','TEST_CONT','D','45','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','TEST_CONT','T','50','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','COMP','H','01','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','COMP','D','10','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','COMP','T','15','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','COMP','H','20','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','COMP','D','25','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','COMP','D','30','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','COMP','T','35','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','TEST_COMP','H','01','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','TEST_COMP','D','10','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','TEST_COMP','T','15','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','TEST_COMP','H','20','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','TEST_COMP','D','25','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','TEST_COMP','D','30','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','TEST_COMP','T','35','Y','F');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMASMUTUAL','H01','dbo.U_EMASMUTUAL_Header','drvfiletype = ''DEMO''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMASMUTUAL','H20','dbo.U_EMASMUTUAL_Header','drvfiletype = ''CONT''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMASMUTUAL','H40','dbo.U_EMASMUTUAL_Header','drvfiletype = ''COMP''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMASMUTUAL','D10','dbo.U_EMASMUTUAL_Demo_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMASMUTUAL','D25','dbo.U_EMASMUTUAL_Cont_drvTbl','drvContributionSource <> ''PLAN1''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMASMUTUAL','D30','dbo.U_EMASMUTUAL_Cont_drvTbl','drvContributionSource = ''PLAN1''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMASMUTUAL','D45','dbo.U_EMASMUTUAL_Comp_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMASMUTUAL','T15','dbo.U_EMASMUTUAL_Demo_Trailer',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMASMUTUAL','T35','dbo.U_EMASMUTUAL_Cont_Trailer',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMASMUTUAL','T50','dbo.U_EMASMUTUAL_Comp_Trailer',NULL);
GO
DECLARE @ISWEB CHAR(1) = '@IsWebFlag';
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
IF (@ISWEB = 'Y')
BEGIN
	UPDATE dbo.AscExp SET expAscFileName = '\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_@CustomFormatCode_YYYYMMDD.txt' WHERE expFormatCode = '@CustomFormatCode';

	UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_@CustomFormatCode_YYYYMMDD.txt' END WHERE expFormatCode = '@CustomFormatCode';
	IF LEFT(@UDENV,2) = 'NW' UPDATE dbo.AscExp SET expAscFileName = REPLACE(expAscFileName,'Exports\',SPACE(0)) WHERE expFormatCode = '@CustomFormatCode';

    UPDATE dbo.AscExp SET expAscFileName = REPLACE(expAscFileName,'YYYYMMDD',CONVERT(char(8),GETDATE(),112)) WHERE expFormatCode = '@CustomFormatCode';

	UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = '@CustomFormatCode' AND CfgName IN ('UseFileName','ExportPath');
	
	DELETE FROM dbo.U_dsi_Configuration WHERE FormatCode = '@CustomFormatCode' AND CfgName IN ('TestPath','UDESPath');
END
GO
IF OBJECT_ID('U_EMASMUTUAL_EEList') IS NULL
CREATE TABLE [dbo].[U_EMASMUTUAL_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EMASMUTUAL_File') IS NULL
CREATE TABLE [dbo].[U_EMASMUTUAL_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
IF OBJECT_ID('U_EMASMUTUAL_HdrRecords') IS NULL
CREATE TABLE [dbo].[U_EMASMUTUAL_HdrRecords] (
    [Header_Type] varchar(4) NOT NULL
);

GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMASMUTUAL]
	@SystemID CHAR(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: @CustomerName

Created By: @DeveloperName
Business Analyst: @IntegrationAnalystName
Create Date: @CreateDate 
Service Request Number: @SRNumber

Purpose: To send employee information to Mass Mutual for plan administration.

Revision History
----------------
Update By            Date            Request Num                Desc        


SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EMASMUTUAL';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EMASMUTUAL';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EMASMUTUAL';
SELECT * FROM dbo.AscExp WHERE expFormatCode = 'EMASMUTUAL';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EMASMUTUAL' ORDER BY DateTimeCompleted DESC;

Execute Export
--------------
--Demographics --
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMASMUTUAL', 'DEMO';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMASMUTUAL', 'TEST_DEMO';

--Compensation --
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMASMUTUAL', 'COMP';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMASMUTUAL', 'TEST_COMP';

--Contributions and Loans --
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMASMUTUAL', 'CONTRIB';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMASMUTUAL', 'TEST_CONT';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EMASMUTUAL', @AllObjects = 'Y'

**********************************************************************************/
BEGIN

    --==========================================
    -- Declare variables
    --==========================================
    DECLARE @FormatCode VARCHAR(10)
        ,@ExportCode VARCHAR(10)
        ,@StartDate DATETIME
        ,@EndDate DATETIME
        ,@StartPerControl VARCHAR(9)
        ,@EndPerControl VARCHAR(9)
		,@MasterContractNum VARCHAR(10)
        ,@TotalFileRecords INT;

    SET @Formatcode = 'EMASMUTUAL'
    
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
    DELETE FROM dbo.U_EMASMUTUAL_EEList
    WHERE xCOID <> dbo.dsi_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EMASMUTUAL_EEList GROUP BY xEEID HAVING Count(*) > 1 );
 
    --Delete Employees with invalid SSN 999999999
    DELETE dbo.U_EMASMUTUAL_EEList
    FROM dbo.U_EMASMUTUAL_EEList
    INNER JOIN dbo.EmpPers WITH (NOLOCK) ON EepEEID = xEEID
        AND EepSSN = '999999999';

    --==========================================
    -- Build Employee Data and the driver tables
    --==========================================
    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EMASMUTUAL_PDedHist') IS NOT NULL
        DROP TABLE dbo.U_EMASMUTUAL_PDedHist;

    SELECT DISTINCT
         PdhEEID
        ,PdhSource     = CASE WHEN PdhDedCode IN (@DSCodes) THEN 'DS'
                            WHEN PdhDedCode IN (@ROTHCodes) THEN 'ROTH'
                            WHEN PdhDedCode IN (@LoanCodes) THEN 'PLAN1' 
                        END
        ,PdhEECurAmt = SUM(PdhEECurAmt)
        ,PdhERCurAmt = SUM(PdhERCurAmt)
    INTO dbo.U_EMASMUTUAL_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    WHERE PdhPerControl BETWEEN @StartPerControl AND @EndPerControl
	AND PdhDedCode IN ('@DSCodes','@ROTHCodes','@LoanCodes')
    GROUP BY PdhEEID,CASE WHEN PdhDedCode IN (@DSCodes) THEN 'DS'
                            WHEN PdhDedCode IN (@ROTHCodes) THEN 'ROTH'
                            WHEN PdhDedCode IN (@LoanCodes) THEN 'PLAN1' 
                        END
    HAVING (SUM(PdhEECurAmt) <> 0.00 OR SUM(PdhERCurAmt) <> 0.00);

    ------------------------------------
    -- Working Table - PEarHist (YTD)
    ------------------------------------
    IF OBJECT_ID('U_EMASMUTUAL_PEarHist') IS NOT NULL
        DROP TABLE dbo.U_EMASMUTUAL_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PehCurAmtYTD        = SUM(PehCurAmt)
        ,PehCurHrsYTD        = SUM(PehCurHrs)
        ,Peh415TestingComp   = SUM(CASE WHEN ErnInclInMiscEarn1 = 'Y' THEN PehCurAmt END)
        ,PehInclInDefComp    = SUM(CASE WHEN ErnInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrs = SUM(CASE WHEN ErnInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_EMASMUTUAL_PEarHist
    FROM dbo.PEarHist WITH (NOLOCK)
    INNER JOIN dbo.EarnCode WITH (NOLOCK)
        ON PehEarnCode = ErnEarnCode
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl   
    GROUP BY PehEEID;

    -----------------------------
    -- Working Table - PTaxHist
    -----------------------------
    IF OBJECT_ID('U_EMASMUTUAL_PTaxHist') IS NOT NULL
        DROP TABLE dbo.U_EMASMUTUAL_PTaxHist;
    SELECT DISTINCT
         PthEEID
        ,PthGrossWagesYTD    = SUM(PthCurGrossWages)       
    INTO dbo.U_EMASMUTUAL_PTaxHist
    FROM dbo.PTaxHist WITH (NOLOCK)
    WHERE LEFT(PthPerControl,4) = LEFT(@EndPerControl,4)
    AND PthPerControl <= @EndPerControl
    AND PthTaxCode = 'USFIT'
    GROUP BY PthEEID
    HAVING SUM(PthCurGrossWages) <> 0.00;

    ---------------------------------
    -- HEADER RECORD - Multiple Headers are included in the file
    ---------------------------------
    IF OBJECT_ID('U_EMASMUTUAL_HdrRecords') IS NOT NULL
        DROP TABLE dbo.U_EMASMUTUAL_HdrRecords;
    SELECT 'DEMO' AS Header_Type --Demographics
    INTO dbo.U_EMASMUTUAL_HdrRecords
  
    UNION
    
    SELECT 'CONT' --Contribution and Loans
    
    UNION
    
    SELECT 'COMP'; --Compensation

    IF OBJECT_ID('U_EMASMUTUAL_Header') IS NOT NULL
        DROP TABLE dbo.U_EMASMUTUAL_Header;
    SELECT DISTINCT
         drvContractNumber		= @MasterContractNum
		,drvFileDescription     = CASE WHEN Header_Type = 'DEMO' THEN '@DemoFileDesc'
                                       WHEN Header_Type = 'CONT' THEN '@ContribFileDesc'
                                       WHEN Header_Type = 'COMP' THEN '@CompFileDesc'
                                  END
        ,drvTransmissionDate    = GETDATE()
        ,drvActTransmissionDate = GETDATE()
        ,drvActTransmissionTime = LEFT(REPLACE(CONVERT(VARCHAR,GETDATE(),108),':',''),4)
        ,drvFileType            = Header_Type 
    INTO dbo.U_EMASMUTUAL_Header
    FROM dbo.U_EMASMUTUAL_HdrRecords;

    ---------------------------------
    -- DETAIL RECORD - Demographics Data
    ---------------------------------
    IF @ExportCode LIKE '%DEMO' 
    BEGIN
        IF OBJECT_ID('U_EMASMUTUAL_Demo_drvTbl') IS NOT NULL
            DROP TABLE dbo.U_EMASMUTUAL_Demo_drvTbl;

        SELECT DISTINCT
             drvContractNumber		= @MasterContractNum
			,drvEIN                 = CmpFedTaxID
            ,drvLocation			= @Location
			,drvSubSetCode          = @SubSetCode
            ,drvSSN                 = EepSSN
            ,drvNameFirst           = EepNameFirst
            ,drvNamePrefix          = NULLIF(EepNamePrefix,'Z')
            ,drvNameMiddle          = LEFT(EepNameMiddle,1)
            ,drvNameLast            = EepNameLast
            ,drvNameSuffix          = NULLIF(EepNameSuffix,'Z')
            ,drvAddressLine1        = EepAddressLine1
            ,drvAddressLine2        = EepAddressLine2
            ,drvCity                = EepAddressCity
            ,drvState               = EepAddressState
            ,drvZipCode             = EepAddressZipCode
            ,drvCountry				= 'US'
			,drvPhoneHomeNumber     = ' ' -- Blank
            ,drvAddressEmail        = ' ' -- Blank
            ,drvDateOfBirth         = EepDateOfBirth
            ,drvDateOfOriginalHire  = EecDateOfOriginalHire
            ,drvGender              = EepGender
            ,drvMaritalStatus       = CASE WHEN eepMaritalStatus = 'M' THEN 'M' ELSE 'S' END
            ,drvEmploymentClass     = 'Y'
            ,drvEmploymentStatus    = CASE WHEN EecEmplStatus = 'T' THEN
                                            CASE WHEN EecTermReason = '203' THEN 'D'
                                                 WHEN EecTermReason IN ('202','213') THEN 'R'
                                                 ELSE 'T'
                                            END
                                            ELSE EecEmplStatus
                                      END
            ,drvEmpStatusChangeDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination 
                                           WHEN EecEmplStatus = 'L' THEN EecEmplStatusStartDate
                                           WHEN EecEmplStatus IN ('A','S') AND EecEmplStatusStartDate >= EecDateOfLastHire THEN EecEmplStatusStartDate
                                           WHEN EecEmplStatus IN ('A','S') AND EecDateOfOriginalHire <> EecDateOfLastHire AND (EecHireSource = 'REHIRE' OR EecJobChangeReason = '101') THEN EecDateOfLastHire
                                           ELSE EecDateOfLastHire
                                       END
            ,drvPayrollStatus        = EecFullTimeOrPartTime
            ,drvPayFrequency        = CASE WHEN EecPayPeriod = 'B' THEN '26'
                                           WHEN EecPayPeriod = 'W' THEN '52'
                                           WHEN EecPayPeriod = 'S' THEN '24'
                                           WHEN EecPayPeriod = 'M' THEN '12'
                                      END

            ,drvEEID = xEEID
            ,drvCoID = xCoID
            ,drvInitialSort = eepSSN
            ,drvFileType = 'DEMO'
            ,drvPayGroup = EecPayGroup
        INTO dbo.U_EMASMUTUAL_Demo_drvTbl
        FROM dbo.U_EMASMUTUAL_EEList WITH (NOLOCK)
        INNER JOIN dbo.EmpComp WITH (NOLOCK)
            ON EecEEID = xEEID 
            AND EecCoID = xCoID
        INNER JOIN dbo.EmpPers WITH (NOLOCK)
            ON EepEEID = xEEID
        LEFT JOIN dbo.Company WITH (NOLOCK)
            ON CmpCOID = xCOID
        ;

        --Exclude Employees whose Term Date is not in last 12 months And Doesn't have any YTD compensation or Contribution
        DELETE dbo.U_EMASMUTUAL_Demo_drvTbl
        WHERE drvEmploymentStatus IN ('T','D','R') AND drvEmpStatusChangeDate < DATEADD(MM, - 12, @EndDate)
        AND NOT EXISTS (SELECT 1 FROM dbo.U_EMASMUTUAL_PEarHist WITH (NOLOCK) WHERE PehEEID = drvEEID)
        AND NOT EXISTS (SELECT 1 FROM dbo.U_EMASMUTUAL_PDedHist WITH (NOLOCK) WHERE PdhEEID = drvEEID);

        ---------------------------------
        -- TRAILER RECORD - Demographics Data
        ---------------------------------
        IF OBJECT_ID('U_EMASMUTUAL_Demo_Trailer') IS NOT NULL
            DROP TABLE dbo.U_EMASMUTUAL_Demo_Trailer;
        SELECT DISTINCT drvDetailCount 	= COUNT(*)
				,drvContractNumber		= @MasterContractNum
        INTO dbo.U_EMASMUTUAL_Demo_Trailer
        FROM dbo.U_EMASMUTUAL_Demo_drvTbl;

        SELECT @TotalFileRecords = drvDetailCount
        FROM dbo.U_EMASMUTUAL_Demo_Trailer;

    END
    
    IF @ExportCode LIKE '%CONT%' 
    BEGIN
        ---------------------------------
        -- DETAIL RECORD - Contributions and Loans
        ---------------------------------
        IF OBJECT_ID('U_EMASMUTUAL_Cont_drvTbl') IS NOT NULL
            DROP TABLE dbo.U_EMASMUTUAL_Cont_drvTbl;
        SELECT DISTINCT
             drvContractNumber		= @MasterContractNum
			,drvEIN                 = CmpFedTaxID
            ,drvSSN                 = EepSSN             
            ,drvPayrollDate         = PrgPayDate
            ,drvPeriodStart         = PrgPeriodStart
            ,drvPeriodEnd           = PrgPeriodEnd
            ,drvContributionSource  = PdhSource
            -- Remove the 
            ,drvContributionAmount  = CASE WHEN PdhEECurAmt > 0 THEN CONVERT(VARCHAR,dbo.dsi_fnPadZero(PdhEECurAmt*100,12,0)) 
                                           ELSE '-'+CONVERT(VARCHAR,dbo.dsi_fnPadZero(PdhEECurAmt*-1*100,11,0)) 
                                      END
            ,drvEEID = xEEID
            ,drvCoID = xCOID
            ,drvInitialSort = EepSSN
            ,drvFileType = 'CONT'
        INTO dbo.U_EMASMUTUAL_Cont_drvTbl
        FROM dbo.U_EMASMUTUAL_EEList WITH (NOLOCK)
        INNER JOIN dbo.EmpComp WITH (NOLOCK)
            ON EecEEID = xEEID 
            AND EecCoID = xCoID
        INNER JOIN dbo.EmpPers WITH (NOLOCK)
            ON EepEEID = xEEID
        INNER JOIN dbo.U_EMASMUTUAL_PDedHist WITH (NOLOCK)
            ON PdhEEID = xEEID 
        LEFT JOIN dbo.Company WITH (NOLOCK)
            ON CmpCOID = xCOID
        LEFT JOIN (SELECT PgpPayGroup, LEFT(MAX(PgpPeriodControl),8) as PrgPayDate, MAX(PgpPeriodStartDate) PrgPeriodStart, MAX(PgpPeriodEndDate) PrgPeriodEnd 
                   FROM dbo.PgPayPer WITH (NOLOCK)
                   WHERE PgpPeriodControl BETWEEN @StartPerControl AND @EndPerControl 
                   AND PgpPeriodType = 'R'
                   GROUP BY PgpPayGroup
		) Prg
            ON EecPayGroup = PgpPayGroup
        ;
        ---------------------------------
        -- TRAILER RECORD - Contributions and Loans
        ---------------------------------
        IF OBJECT_ID('U_EMASMUTUAL_Cont_Trailer') IS NOT NULL
            DROP TABLE dbo.U_EMASMUTUAL_Cont_Trailer;
        SELECT DISTINCT
             drvDetailCount         = COUNT(*)
            ,drvContractNumber		= @MasterContractNum
			,drvContributionRecords = SUM(CASE WHEN drvContributionSource <> 'PLAN1' THEN 1 ELSE 0 END)
            ,drvContributionAmount  = SUM(CASE WHEN drvContributionSource <> 'PLAN1' THEN CAST(drvContributionAmount AS BIGINT) ELSE 0 END)
            ,drvLoanRecords         = SUM(CASE WHEN drvContributionSource = 'PLAN1' THEN 1 ELSE 0 END)
            ,drvLoanAmount          = SUM(CASE WHEN drvContributionSource = 'PLAN1' THEN CAST(drvContributionAmount AS BIGINT) ELSE 0 END)
        INTO dbo.U_EMASMUTUAL_Cont_Trailer
        FROM dbo.U_EMASMUTUAL_Cont_drvTbl;

        SELECT @TotalFileRecords = @TotalFileRecords + drvDetailCount
        FROM dbo.U_EMASMUTUAL_Cont_Trailer;
    END

    IF @ExportCode LIKE '%COMP'
    BEGIN
        ---------------------------------
        -- DETAIL RECORD - Compensation Record
        ---------------------------------
        IF OBJECT_ID('U_EMASMUTUAL_Comp_drvTbl') IS NOT NULL
            DROP TABLE dbo.U_EMASMUTUAL_Comp_drvTbl;
        SELECT DISTINCT
             drvContractNumber		= @MasterContractNum
			,drvEIN                 = CmpFedTaxID
            ,drvSSN                 = EepSSN
            ,drvPayDate             = PayDate
            ,drvEffectiveStartDate  = LEFT(@EndPerControl,4)+'0101'
            ,drvPeriodEndDate       = PrgPeriodEnd
            ,drvContribSalary       = PehInclInDefComp
            ,drv415Salary           = PthGrossWagesYTD
            ,drvADPSalary           = PehInclInDefComp
            ,drvHoursWorked         = PehInclInDefCompHrs
            ,drvEEID = xEEID
            ,drvCoID = xCOID
            ,drvInitialSort = EepSSN
            ,drvFileType = 'COMP'
        INTO dbo.U_EMASMUTUAL_Comp_drvTbl
        FROM dbo.U_EMASMUTUAL_EEList WITH (NOLOCK)
        INNER JOIN dbo.EmpComp WITH (NOLOCK)
            ON EecEEID = xEEID 
            AND EecCoID = xCoID
        INNER JOIN dbo.EmpPers WITH (NOLOCK)
            ON EepEEID = xEEID
        LEFT JOIN dbo.U_EMASMUTUAL_PEarHist WITH (NOLOCK)
            ON PehEEID = xEEID
        LEFT JOIN dbo.U_EMASMUTUAL_PTaxHist WITH (NOLOCK)
            ON PthEEID = xEEID
        LEFT JOIN dbo.Company WITH (NOLOCK)
            ON CmpCOID = xCOID
        LEFT JOIN (SELECT PgpPayGroup, LEFT(MAX(PgpPeriodControl),8) as PayDate, MAX(PgpPeriodStartDate) PrgPeriodStart, MAX(PgpPeriodEndDate) PrgPeriodEnd 
                   FROM dbo.PgPayPer WITH (NOLOCK)
                   WHERE PgpPeriodControl <= @EndPerControl 
                   AND PgpPeriodType = 'R'
                GROUP BY PgpPayGroup
		) Prg
            ON EecPayGroup = PgpPayGroup 
        WHERE PehEEID IS NOT NULL
        AND (PehInclInDefComp <> 0 OR PthGrossWagesYTD <> 0 OR PehInclInDefCompHrs <> 0);

        ---------------------------------
        -- TRAILER RECORD - Compensation Record
        ---------------------------------
        IF OBJECT_ID('U_EMASMUTUAL_Comp_Trailer') IS NOT NULL
            DROP TABLE dbo.U_EMASMUTUAL_Comp_Trailer;
        SELECT DISTINCT
             drvContractNumber		= @MasterContractNum
			,drvDetailCount         = COUNT(*)
            ,drvCompRecords         = COUNT(*)
            ,drvSalaryContribTotal  = SUM(drvContribSalary)
            ,drv415SalaryTotal      = SUM(drv415Salary)
            ,drvADPSalaryTotal      = SUM(drvADPSalary)
            ,drvTotalHours          = SUM(ROUND(drvhoursworked,0))
        INTO dbo.U_EMASMUTUAL_Comp_Trailer
        FROM dbo.U_EMASMUTUAL_Comp_drvTbl;
    END

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode, 'UseFileName') = 'N')
	BEGIN
        UPDATE dbo.U_dsi_Parameters
        SET ExportFile = @MasterContractNum + 
                         CASE WHEN @ExportCode LIKE '%DEMO%' THEN 'demo' 
                              WHEN @ExportCode LIKE '%CONT%' THEN 'cont' 
                              WHEN @ExportCode LIKE '%COMP%' THEN 'comp'  
                         END +
                         CASE WHEN @ExportCode LIKE 'TEST%' OR dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'test_' ELSE '_' END + 
                         CONVERT(VARCHAR,GetDate(),112) +
                         '.asc'
        WHERE FormatCode = @FormatCode;
	END;

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEMASMUTUAL_Export AS
    SELECT TOP 200000000 Data FROM dbo.U_EMASMUTUAL_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort
GO

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EMASMUTUAL%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET ExpLastStartPerControl = '201810011'
       ,ExpStartPerControl     = '201810011'
       ,ExpLastEndPerControl   = '201810019'
       ,ExpEndPerControl       = '201810019'
WHERE ExpFormatCode = 'EMASMUTUAL';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEMASMUTUAL_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EMASMUTUAL_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort
GO
