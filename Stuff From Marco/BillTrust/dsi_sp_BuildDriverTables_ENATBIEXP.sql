SET NOCOUNT ON;
IF OBJECT_ID('U_ENATBIEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ENATBIEXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ENATBIEXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ENATBIEXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwENATBIEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwENATBIEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ENATBIEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ENATBIEXP];
GO
IF OBJECT_ID('U_ENATBIEXP_Salary') IS NOT NULL DROP TABLE [dbo].[U_ENATBIEXP_Salary];
GO
IF OBJECT_ID('U_ENATBIEXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ENATBIEXP_PEarHist];
GO
IF OBJECT_ID('U_ENATBIEXP_PDedHist2') IS NOT NULL DROP TABLE [dbo].[U_ENATBIEXP_PDedHist2];
GO
IF OBJECT_ID('U_ENATBIEXP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ENATBIEXP_PDedHist];
GO
IF OBJECT_ID('U_ENATBIEXP_File') IS NOT NULL DROP TABLE [dbo].[U_ENATBIEXP_File];
GO
IF OBJECT_ID('U_ENATBIEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_ENATBIEXP_EEList];
GO
IF OBJECT_ID('U_ENATBIEXP_drvContrib') IS NOT NULL DROP TABLE [dbo].[U_ENATBIEXP_drvContrib];
GO
IF OBJECT_ID('U_ENATBIEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_ENATBIEXP_DedList];
GO
IF OBJECT_ID('U_ENATBIEXP_Census') IS NOT NULL DROP TABLE [dbo].[U_ENATBIEXP_Census];
GO
IF OBJECT_ID('U_ENATBIEXP_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ENATBIEXP_AuditFields];
GO
IF OBJECT_ID('U_ENATBIEXP_Audit') IS NOT NULL DROP TABLE [dbo].[U_ENATBIEXP_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_ENATBIEXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ENATBIEXP];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ENATBIEXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ENATBIEXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ENATBIEXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ENATBIEXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ENATBIEXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ENATBIEXP','NationWide 401k Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','ENATBIEXP0Z0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ENATBIEXP0Z0','50','D','10','1',NULL,'Transaction Type',NULL,NULL,'"drvTransactionType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ENATBIEXP0Z0','50','D','10','2',NULL,'Line of Business',NULL,NULL,'"drvLineofBusiness"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ENATBIEXP0Z0','50','D','10','3',NULL,'Nationwide Case Number',NULL,NULL,'"drvNationwideCaseNumber"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ENATBIEXP0Z0','50','D','10','4',NULL,'Effective Date',NULL,NULL,'"drvEffectiveDate"','(''UD112''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ENATBIEXP0Z0','50','D','10','5',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ENATBIEXP0Z0','50','D','10','6',NULL,'Last Name',NULL,NULL,'"drvLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ENATBIEXP0Z0','50','D','10','7',NULL,'First Name',NULL,NULL,'"drvFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ENATBIEXP0Z0','50','D','10','8',NULL,'Address Line 1',NULL,NULL,'"drvAddressLine1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ENATBIEXP0Z0','50','D','10','9',NULL,'Address Line 2',NULL,NULL,'"drvAddressLine2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ENATBIEXP0Z0','50','D','10','10',NULL,'Address Line 3',NULL,NULL,'"drvAddressLine3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ENATBIEXP0Z0','50','D','10','11',NULL,'Address Line 4',NULL,NULL,'"drvAddressLine4"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ENATBIEXP0Z0','50','D','10','12',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ENATBIEXP0Z0','50','D','10','13',NULL,'State',NULL,NULL,'"drvState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ENATBIEXP0Z0','50','D','10','14',NULL,'Zip',NULL,NULL,'"drvZip"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ENATBIEXP0Z0','50','D','10','15',NULL,'Zip+4',NULL,NULL,'"drvZip4"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ENATBIEXP0Z0','50','D','10','16',NULL,'Hire Date',NULL,NULL,'"drvHireDate"','(''UD112''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ENATBIEXP0Z0','50','D','10','17',NULL,'Service Termination Date',NULL,NULL,'"drvServiceTerminationDate"','(''UD112''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ENATBIEXP0Z0','50','D','10','18',NULL,'Date of Entry',NULL,NULL,'"drvDateofEntry"','(''UD112''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ENATBIEXP0Z0','50','D','10','19',NULL,'Birth Date',NULL,NULL,'"drvBirthDate"','(''UD112''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ENATBIEXP0Z0','50','D','10','20',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ENATBIEXP0Z0','50','D','10','21',NULL,'Marital Status',NULL,NULL,'"drvMaritalStatus"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ENATBIEXP0Z0','50','D','10','22',NULL,'Email Address',NULL,NULL,'"drvEmailAddress"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ENATBIEXP0Z0','50','D','10','23',NULL,'Employee ID',NULL,NULL,'"drvEmployeeID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ENATBIEXP0Z0','50','D','10','24',NULL,'Division Code',NULL,NULL,'"drvDivisionCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ENATBIEXP0Z0','50','D','10','25',NULL,'Gross Annual Salary',NULL,NULL,'"drvGrossAnnualSalary"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ENATBIEXP0Z0','50','D','10','26',NULL,'Rehire Date',NULL,NULL,'"drvRehireDate"','(''UD112''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ENATBIEXP0Z0','50','D','10','27',NULL,'Automatic Enrollment Status',NULL,NULL,'"drvAutomaticEnrollmentStatus"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ENATBIEXP0Z0','50','D','10','28',NULL,'Auto Enrollment Date',NULL,NULL,'"drvAutoEnrollmentDate"','(''UD112''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ENATBIEXP0Z0','50','D','10','29',NULL,'Pre-Tax Deferral  Percentage Election',NULL,NULL,'"drvPreTaxDeferralPerElection"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ENATBIEXP0Z0','50','D','10','30',NULL,'Roth Deferral Percentage Election',NULL,NULL,'"drvRothDeferralPerElection"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ENATBIEXP0Z0','50','D','10','31',NULL,'Pre-Tax Dollar Election',NULL,NULL,'"drvPreTaxDollarElection"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ENATBIEXP0Z0','50','D','10','32',NULL,'Roth dollar Election',NULL,NULL,'"drvRothdollarElection"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ENATBIEXP0Z0','50','D','10','33',NULL,'Phone Number',NULL,NULL,'"drvPhoneNumber"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ENATBIEXP0Z0','50','D','10','34',NULL,'Fax Number',NULL,NULL,'"drvFaxNumber"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ENATBIEXP0Z0','50','D','10','35',NULL,'Relationship to Owner',NULL,NULL,'"drvRelationshiptoOwner"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ENATBIEXP0Z0','50','D','10','36',NULL,'Related Owner SSN',NULL,NULL,'"drvRelatedOwnerSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ENATBIEXP0Z0','50','D','10','37',NULL,'Employee Type',NULL,NULL,'"drvEmployeeType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ENATBIEXP0Z0','50','D','10','38',NULL,'Date of Death',NULL,NULL,'"drvDateofDeath"','(''UD112''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ENATBIEXP0Z0','50','D','20','1',NULL,'Transaction Type',NULL,NULL,'"drvTransactionType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ENATBIEXP0Z0','50','D','20','2',NULL,'Line of Business',NULL,NULL,'"drvLineofBusiness"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ENATBIEXP0Z0','50','D','20','3',NULL,'Nationwide Case Number',NULL,NULL,'"drvNationwideCaseNumber"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ENATBIEXP0Z0','50','D','20','4',NULL,'Pay Date',NULL,NULL,'"drvPayDate"','(''UD112''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ENATBIEXP0Z0','50','D','20','5',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ENATBIEXP0Z0','50','D','20','6',NULL,'Last Name',NULL,NULL,'"drvLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ENATBIEXP0Z0','50','D','20','7',NULL,'First Name',NULL,NULL,'"drvFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ENATBIEXP0Z0','50','D','20','8',NULL,'Source Number',NULL,NULL,'"drvSourceNumber"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ENATBIEXP0Z0','50','D','20','9',NULL,'Transaction Code',NULL,NULL,'"drvTransactionCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ENATBIEXP0Z0','50','D','20','10',NULL,'Fund Symbol',NULL,NULL,'"drvFundSymbol"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ENATBIEXP0Z0','50','D','20','11',NULL,'Loan Number',NULL,NULL,'"drvAmount"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ENATBIEXP0Z0','50','D','20','12',NULL,'Amount',NULL,NULL,'"drvLoanNumber"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ENATBIEXP0Z0','50','D','30','1',NULL,'Transaction Type',NULL,NULL,'"drvTransactionType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ENATBIEXP0Z0','50','D','30','2',NULL,'Line of Business',NULL,NULL,'"drvLineofBusiness"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ENATBIEXP0Z0','50','D','30','3',NULL,'Nationwide Case Number',NULL,NULL,'"drvNationwideCaseNumber"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ENATBIEXP0Z0','50','D','30','4',NULL,'Pay Date',NULL,NULL,'"drvPayDate"','(''UD112''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ENATBIEXP0Z0','50','D','30','5',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ENATBIEXP0Z0','50','D','30','6',NULL,'Last Name',NULL,NULL,'"drvLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ENATBIEXP0Z0','50','D','30','7',NULL,'First Name',NULL,NULL,'"drvFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ENATBIEXP0Z0','50','D','30','8',NULL,'Company/Division Code',NULL,NULL,'"drvCompanyDivisionCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ENATBIEXP0Z0','50','D','30','9',NULL,'Officer',NULL,NULL,'"drvOfficer"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ENATBIEXP0Z0','50','D','30','10',NULL,'Percentage Ownership',NULL,NULL,'"drvPercentageOwnership"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ENATBIEXP0Z0','50','D','30','11',NULL,'Hours of Service',NULL,NULL,'"drvHoursofService"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ENATBIEXP0Z0','50','D','30','12',NULL,'Overtime Hours',NULL,NULL,'"drvOvertimeHours"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ENATBIEXP0Z0','50','D','30','13',NULL,'Gross Compensation',NULL,NULL,'"drvGrossCompensation"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ENATBIEXP0Z0','50','D','30','14',NULL,'Other Compensation',NULL,NULL,'"drvOtherCompensation"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ENATBIEXP0Z0','50','D','30','15',NULL,'Pre-Tax Deferral Percentage Election',NULL,NULL,'"drvPreTaxDeferralPerElection"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ENATBIEXP0Z0','50','D','30','16',NULL,'Bonus Compensation',NULL,NULL,'"drvBonusCompensation"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ENATBIEXP0Z0','50','D','30','17',NULL,'Commission Compensation',NULL,NULL,'"drvCommissionCompensation"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ENATBIEXP0Z0','50','D','30','18',NULL,'Overtime Compensation',NULL,NULL,'"drvOvertimeCompensation"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ENATBIEXP0Z0','50','D','30','19',NULL,'Additional Reimbursements',NULL,NULL,'"drvAdditionalReimbursements"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ENATBIEXP0Z0','50','D','30','20',NULL,'Section 125 Deferrals',NULL,NULL,'"drvSection125Deferrals"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ENATBIEXP0Z0','50','D','30','21',NULL,'Section 402(e)(3) Deferrals',NULL,NULL,'"drvSection402e3Deferrals"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ENATBIEXP0Z0','50','D','30','22',NULL,'Section 402(h)(1)(B) Deferrals',NULL,NULL,'"drvSection402h1BDeferrals"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ENATBIEXP0Z0','50','D','30','23',NULL,'Section 403(b) Deferrals',NULL,NULL,'"drvSection403bDeferrals"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ENATBIEXP0Z0','50','D','30','24',NULL,'Section 414(h) Deferrals',NULL,NULL,'"drvSection414hDeferrals"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ENATBIEXP0Z0','50','D','30','25',NULL,'Section 457 Deferrals',NULL,NULL,'"drvSection457Deferrals"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ENATBIEXP0Z0','50','D','30','26',NULL,'Other Deferrals',NULL,NULL,'"drvOtherDeferrals"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ENATBIEXP0Z0','50','D','30','27',NULL,'Employee Type',NULL,NULL,'"drvEmployeeType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ENATBIEXP0Z0','50','D','30','28',NULL,'Section 402A Deferrals',NULL,NULL,'"drvSection402ADeferrals"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ENATBIEXP0Z0','50','D','30','29',NULL,'Section 402A Deferral Percent',NULL,NULL,'"drvSection402ADeferralPercent"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ENATBIEXP0Z0','50','D','30','30',NULL,'Pre-Tax Deferral Dollar Election',NULL,NULL,'"drvPreTaxDeferralDollarElec"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ENATBIEXP0Z0','50','D','30','31',NULL,'Roth Deferral Percentage Election',NULL,NULL,'"drvRothDeferralPercentageElec"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ENATBIEXP0Z0','50','D','30','32',NULL,'Roth Deferral Dollar Election',NULL,NULL,'"drvRothDeferralDollarElection"','(''UA''=''T,'')');
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expCOIDList,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ENATBIEXP_20200730.txt',NULL,'','',NULL,NULL,NULL,'NationWide 401k Export','202007159','EMPEXPORT','ONDEMAND',NULL,'ENATBIEXP',NULL,NULL,NULL,'202007159','Jul 16 2020 11:38AM','Jul 16 2020 11:38AM','202007011',NULL,'','','202007011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL,NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expCOIDList,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ENATBIEXP_20200730.txt',NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','202007159','EMPEXPORT','SCH_NABT',NULL,'ENATBIEXP',NULL,NULL,NULL,'202007159','Jul 16 2020 11:38AM','Jul 16 2020 11:38AM','202007011',NULL,'','','202007011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL,NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expCOIDList,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ENATBIEXP_20200730.txt',NULL,'','',NULL,NULL,NULL,'Test Purposes Only','202007311','EMPEXPORT','TEST','Jul 30 2020 11:29AM','ENATBIEXP',NULL,NULL,NULL,'202007311','Jul 31 2020 12:00AM','Jul 31 2020 12:00AM','202007311','1585','eecPayGroup','HRBW,SAL','202007311',dbo.fn_GetTimedKey(),NULL,'us3mLaFAC1003','',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_ENATBIEXP_20200730.txt' END WHERE expFormatCode = 'ENATBIEXP';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENATBIEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENATBIEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENATBIEXP','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENATBIEXP','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENATBIEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENATBIEXP','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'ENATBIEXP' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ENATBIEXP' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_ENATBIEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ENATBIEXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENATBIEXP','D10','dbo.U_ENATBIEXP_Census',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENATBIEXP','D20','dbo.U_ENATBIEXP_drvContrib',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENATBIEXP','D30','dbo.U_ENATBIEXP_Salary',NULL);
IF OBJECT_ID('U_dsi_BDM_ENATBIEXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ENATBIEXP] (
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
IF OBJECT_ID('U_ENATBIEXP_Audit') IS NULL
CREATE TABLE [dbo].[U_ENATBIEXP_Audit] (
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
IF OBJECT_ID('U_ENATBIEXP_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ENATBIEXP_AuditFields] (
    [aTableName] varchar(128) NULL,
    [aFieldName] varchar(128) NULL
);
IF OBJECT_ID('U_ENATBIEXP_Census') IS NULL
CREATE TABLE [dbo].[U_ENATBIEXP_Census] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvTransactionType] varchar(6) NOT NULL,
    [drvLineofBusiness] varchar(1) NOT NULL,
    [drvNationwideCaseNumber] varchar(9) NOT NULL,
    [drvEffectiveDate] datetime NOT NULL,
    [drvSSN] char(11) NULL,
    [drvLastName] varchar(20) NULL,
    [drvFirstName] varchar(15) NULL,
    [drvAddressLine1] varchar(32) NULL,
    [drvAddressLine2] varchar(32) NULL,
    [drvAddressLine3] varchar(1) NOT NULL,
    [drvAddressLine4] varchar(1) NOT NULL,
    [drvCity] varchar(32) NULL,
    [drvState] varchar(255) NULL,
    [drvZip] varchar(5) NULL,
    [drvZip4] varchar(4) NULL,
    [drvHireDate] datetime NULL,
    [drvServiceTerminationDate] datetime NULL,
    [drvDateofEntry] datetime NULL,
    [drvBirthDate] datetime NULL,
    [drvGender] varchar(1) NULL,
    [drvMaritalStatus] varchar(1) NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvEmployeeID] char(9) NULL,
    [drvDivisionCode] varchar(1) NOT NULL,
    [drvGrossAnnualSalary] varchar(15) NULL,
    [drvRehireDate] datetime NULL,
    [drvAutomaticEnrollmentStatus] varchar(1) NOT NULL,
    [drvAutoEnrollmentDate] varchar(1) NOT NULL,
    [drvPreTaxDeferralPerElection] varchar(6) NULL,
    [drvRothDeferralPerElection] varchar(6) NULL,
    [drvPreTaxDollarElection] varchar(8) NULL,
    [drvRothdollarElection] varchar(8) NULL,
    [drvPhoneNumber] varchar(50) NULL,
    [drvFaxNumber] varchar(1) NOT NULL,
    [drvRelationshiptoOwner] varchar(1) NOT NULL,
    [drvRelatedOwnerSSN] varchar(1) NOT NULL,
    [drvEmployeeType] char(1) NULL,
    [drvDateofDeath] datetime NULL
);
IF OBJECT_ID('U_ENATBIEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_ENATBIEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ENATBIEXP_drvContrib') IS NULL
CREATE TABLE [dbo].[U_ENATBIEXP_drvContrib] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvTransactionType] varchar(4) NOT NULL,
    [drvLineofBusiness] varchar(1) NOT NULL,
    [drvNationwideCaseNumber] varchar(9) NOT NULL,
    [drvPayDate] datetime NULL,
    [drvSSN] char(11) NULL,
    [drvLastName] varchar(20) NULL,
    [drvFirstName] varchar(15) NULL,
    [drvSourceNumber] varchar(2) NOT NULL,
    [drvFundSymbol] varchar(1) NOT NULL,
    [drvTransactionCode] varchar(2) NOT NULL,
    [drvLoanNumber] char(25) NULL,
    [drvAmount] varchar(17) NULL
);
IF OBJECT_ID('U_ENATBIEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_ENATBIEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ENATBIEXP_File') IS NULL
CREATE TABLE [dbo].[U_ENATBIEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
IF OBJECT_ID('U_ENATBIEXP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ENATBIEXP_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhSource] varchar(5) NULL,
    [PdhAmount] money NULL
);
IF OBJECT_ID('U_ENATBIEXP_PDedHist2') IS NULL
CREATE TABLE [dbo].[U_ENATBIEXP_PDedHist2] (
    [PdhEEID2] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhSource2] numeric NULL,
    [PdhSource3] numeric NULL,
    [PdhSource21] numeric NULL
);
IF OBJECT_ID('U_ENATBIEXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ENATBIEXP_PEarHist] (
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
IF OBJECT_ID('U_ENATBIEXP_Salary') IS NULL
CREATE TABLE [dbo].[U_ENATBIEXP_Salary] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvTransactionType] varchar(6) NOT NULL,
    [drvLineofBusiness] varchar(1) NOT NULL,
    [drvNationwideCaseNumber] varchar(9) NOT NULL,
    [drvPayDate] datetime NULL,
    [drvSSN] char(11) NULL,
    [drvLastName] varchar(20) NULL,
    [drvFirstName] varchar(20) NULL,
    [drvCompanyDivisionCode] varchar(1) NOT NULL,
    [drvOfficer] varchar(1) NOT NULL,
    [drvPercentageOwnership] varchar(1) NOT NULL,
    [drvHoursofService] varchar(8) NULL,
    [drvOvertimeHours] varchar(1) NOT NULL,
    [drvGrossCompensation] varchar(10) NULL,
    [drvOtherCompensation] varchar(1) NOT NULL,
    [drvPreTaxDeferralPerElection] varchar(1) NOT NULL,
    [drvBonusCompensation] varchar(1) NOT NULL,
    [drvCommissionCompensation] varchar(1) NOT NULL,
    [drvOvertimeCompensation] varchar(1) NOT NULL,
    [drvAdditionalReimbursements] varchar(1) NOT NULL,
    [drvSection125Deferrals] varchar(1) NOT NULL,
    [drvSection402e3Deferrals] varchar(1) NOT NULL,
    [drvSection402h1BDeferrals] varchar(1) NOT NULL,
    [drvSection403bDeferrals] varchar(1) NOT NULL,
    [drvSection414hDeferrals] varchar(1) NOT NULL,
    [drvSection457Deferrals] varchar(1) NOT NULL,
    [drvOtherDeferrals] varchar(1) NOT NULL,
    [drvEmployeeType] varchar(1) NOT NULL,
    [drvSection402ADeferrals] varchar(1) NOT NULL,
    [drvSection402ADeferralPercent] varchar(1) NOT NULL,
    [drvPreTaxDeferralDollarElec] varchar(1) NOT NULL,
    [drvRothDeferralPercentageElec] varchar(1) NOT NULL,
    [drvRothDeferralDollarElection] varchar(1) NOT NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ENATBIEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: BillTrust

Created By: Marco Lagrosa
Business Analyst: Cheryl Petitti
Create Date: 07/16/2020
Service Request Number: TekP-2020-04-02-0002

Purpose: NationWide 401k Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ENATBIEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ENATBIEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ENATBIEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ENATBIEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ENATBIEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ENATBIEXP', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ENATBIEXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ENATBIEXP', 'TEST';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ENATBIEXP';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ENATBIEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ENATBIEXP';

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
    DELETE FROM dbo.U_ENATBIEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ENATBIEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '401CD,401CP,401KD,401K,ROTHD, ROTHP, RTHCD, RTHCP,401KC, 401KU, RTHUD, RTHUP, 401KL, 401L2, 401L3';

    IF OBJECT_ID('U_ENATBIEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ENATBIEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ENATBIEXP_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

     DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DedList);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS,DP');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL, CHD, STC');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP');
    --INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'EmployeeElectedRateorPct',@DedList);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');


    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    EXEC dbo.dsi_bdm_sp_CalculateBenefitAmounts @FormatCode;
    --==========================================
    -- Build Working Tables
    --==========================================


    IF OBJECT_ID('U_ENATBIEXP_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ENATBIEXP_AuditFields;
    CREATE TABLE dbo.U_ENATBIEXP_AuditFields (aTableName varchar(128),aFieldName varchar(128));
    
    -- Insert tables/fields to be audited
    INSERT INTO dbo.U_ENATBIEXP_AuditFields VALUES ('EmpComp','EecEmplStatus');    
    -- Create audit table
    IF OBJECT_ID('U_ENATBIEXP_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ENATBIEXP_Audit;
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
    INTO dbo.U_ENATBIEXP_Audit
    FROM (SELECT *
          FROM dbo.AuditRecords WITH (NOLOCK)
          WHERE adrTableName IN (SELECT aTableName FROM dbo.U_ENATBIEXP_AuditFields WITH (NOLOCK))) ADR
    JOIN (SELECT *
          FROM dbo.AuditFields WITH (NOLOCK)
          WHERE adfFieldName IN (SELECT aFieldName FROM dbo.U_ENATBIEXP_AuditFields WITH (NOLOCK))) ADF
        ON adrSystemID = adfSystemID
       AND adrKey = adfKey
    WHERE adrType IN (1,2,5,6) -- Insert/Update; remove this to include Deletes and Viewed
      AND adrProcessedDateTime BETWEEN @StartDate AND @EndDate;
    
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ENATBIEXP_Audit ON dbo.U_ENATBIEXP_Audit (audKey1Value, audKey2Value);


    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_ENATBIEXP_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ENATBIEXP_PDedHist;
   SELECT DISTINCT
         PdhEEID

        ,PdhSource     = CASE WHEN PdhDedCode IN ('401CD', '401CP', '401KD', '401K', '401KC', '401KU') THEN 'EEAMT'
                            WHEN PdhDedCode IN ('401L1','401L2','401L3','401KL') THEN 'LOAN' 

                        END

        ,PdhAmount = SUM(PdhEECurAmt)

        INTO dbo.U_ENATBIEXP_PDedHist

    FROM dbo.PDedHist WITH (NOLOCK)
    WHERE PdhPerControl BETWEEN @StartPerControl AND @EndPerControl

    AND PdhDedCode IN ('401CD', '401CP', '401KD', '401K', '401KC', '401KU','401L1','401L2','401L3','401KL')

    GROUP BY PdhEEID, CASE WHEN PdhDedCode IN ('401CD', '401CP', '401KD', '401K', '401KC', '401KU') THEN 'EEAMT'
                            WHEN PdhDedCode IN ('401L1','401L2','401L3','401KL') THEN 'LOAN' 

                        END
    HAVING (SUM(PdhEECurAmt) <> 0.00 OR SUM(PdhERCurAmt) <> 0.00)

    UNION  
    SELECT DISTINCT
         PdhEEID

        ,PdhSource     = CASE WHEN PdhDedCode IN ('401CD', '401CP', '401KD', '401K', '401KC', '401KU', 'ROTHD', 'ROTHP', 'RTHCD', 'RTHCP', 'RTHUD', 'RTHUP') THEN 'ERAMT'
                        END

        ,PdhAmount = SUM(PdhERCurAmt)


    FROM dbo.PDedHist WITH (NOLOCK)

    WHERE PdhPerControl BETWEEN @StartPerControl AND @EndPerControl

    AND PdhDedCode IN ('401CD', '401CP', '401KD', '401K', '401KC', '401KU', 'ROTHD', 'ROTHP', 'RTHCD', 'RTHCP', 'RTHUD', 'RTHUP')

    GROUP BY PdhEEID,CASE WHEN PdhDedCode IN ('401CD', '401CP', '401KD', '401K', '401KC', '401KU', 'ROTHD', 'ROTHP', 'RTHCD', 'RTHCP', 'RTHUD', 'RTHUP') THEN 'ERAMT'
                        END
    HAVING (SUM(PdhEECurAmt) <> 0.00 OR SUM(PdhERCurAmt) <> 0.00)


       UNION  
    SELECT DISTINCT
         PdhEEID

        ,PdhSource     = CASE WHEN PdhDedCode IN ('ROTHD','ROTHP', 'RTHCD', 'RTHCP', 'RTHUD', 'RTHUP') THEN 'ROTH'
                         END

        ,PdhAmount = SUM(PdhEECurAmt)


    FROM dbo.PDedHist WITH (NOLOCK)

    WHERE PdhPerControl BETWEEN @StartPerControl AND @EndPerControl

    AND PdhDedCode IN ('ROTHD','ROTHP', 'RTHCD', 'RTHCP', 'RTHUD', 'RTHUP')

    GROUP BY PdhEEID,CASE WHEN PdhDedCode IN ('ROTHD','ROTHP', 'RTHCD', 'RTHCP', 'RTHUD', 'RTHUP') THEN 'ROTH'
                        END
    HAVING (SUM(PdhEECurAmt) <> 0.00 OR SUM(PdhERCurAmt) <> 0.00);



    Delete from  dbo.U_ENATBIEXP_PDedHist where pdhAMount <=0.00


        IF OBJECT_ID('U_ENATBIEXP_PDedHist2','U') IS NOT NULL
        DROP TABLE dbo.U_ENATBIEXP_PDedHist2;
    SELECT DISTINCT
         PdhEEID as PdhEEID2
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('401CD', '401CP', '401KD', '401K', '401KC', '401KU') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource3    = SUM(CASE WHEN PdhDedCode IN ('401CD', '401CP', '401KD', '401K', '401KC', '401KU', 'ROTHD', 'ROTHP', 'RTHCD', 'RTHCP', 'RTHUD', 'RTHUP') THEN PdhERCurAmt ELSE 0.00 END)
        ,PdhSource21    = SUM(CASE WHEN PdhDedCode IN ('ROTHD', 'ROTHP', 'RTHCD', 'RTHCP', 'RTHUD', 'RTHUP') THEN PdhEECurAmt ELSE 0.00 END)        
    INTO dbo.U_ENATBIEXP_PDedHist2
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ENATBIEXP_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_ENATBIEXP_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ENATBIEXP_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_ENATBIEXP_PEarHist
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
    -- DETAIL RECORD - U_ENATBIEXP_drvContrib
    ---------------------------------
    IF OBJECT_ID('U_ENATBIEXP_drvContrib','U') IS NOT NULL
        DROP TABLE dbo.U_ENATBIEXP_drvContrib;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepSSN
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvTransactionType = 'CTRB'
        ,drvLineofBusiness = '1'
        ,drvNationwideCaseNumber = '063-86903'
        ,drvPayDate = dbo.dsi_fnGetMinMaxDates('MAX',PrgPayDate, PayDate) 
        ,drvSSN = eepSSN
        ,drvLastName = CAST(EepNameLast as varchar(20))
        ,drvFirstName = CAST(EepNameFirst as varchar(15))
        ,drvSourceNumber = CASE WHEN PdhSource = 'EEAMT' THEN '2' 
                                WHEN PdhSource = 'ERAMT' THEN '3' 
                                WHEN PdhSource = 'ROTH' THEN '21' 

                                
                ELSE '' END
        


        ,drvFundSymbol =  ''
        ,drvTransactionCode = CASE WHEN PdhSource = 'LOAN' THEN '21' ELSE '11' END
        ,drvLoanNumber = CASE WHEN PdhSource = 'LOAN' THEN EEPUDFIELD01 END
        ,drvAmount = CAST(CONVERT(DECIMAL(15,2), pdhAmount) as varchar(17))
    INTO dbo.U_ENATBIEXP_drvContrib
    FROM dbo.U_ENATBIEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
     JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
        and (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                                      and EXISTS(select 1 from dbo.U_ENATBIEXP_Audit where  audKey1Value = xEEID AND audKey2Value = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    JOIN dbo.U_ENATBIEXP_PEarHist WITH (NOLOCK)
        on peheeid = xeeid
    JOIN dbo.U_ENATBIEXP_PDedHist WITH (NOLOCK)
        on pdheeid =  xeeid
    --JOIN dbo.U_ENATBIEXP_PDedHist2 WITH (NOLOCK)
    --on PdhEEID2 = xeeid
    LEFT JOIN (SELECT PgpPayGroup, LEFT(MAX(PgpPeriodControl),8) as PayDate, MAX(PgpPeriodStartDate) PrgPeriodStart, MAX(PgpPeriodEndDate) PrgPeriodEnd 
                   FROM dbo.PgPayPer WITH (NOLOCK)
                   WHERE PgpPeriodControl BETWEEN @StartPerControl AND @EndPerControl 
                   GROUP BY PgpPayGroup) as PayDates
        on EecPaygroup = PgpPayGroup
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ENATBIEXP_Salary
    ---------------------------------
    IF OBJECT_ID('U_ENATBIEXP_Salary','U') IS NOT NULL
        DROP TABLE dbo.U_ENATBIEXP_Salary;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepSSN
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvTransactionType = 'SALARY'
        ,drvLineofBusiness = '1'
        ,drvNationwideCaseNumber = '063-86903'
        ,drvPayDate = dbo.dsi_fnGetMinMaxDates('MAX',PrgPayDate, PayDate) 
        ,drvSSN = eepSSN
        ,drvLastName = CAST(EepNameLast as varchar(20))
        ,drvFirstName = CAST(EepNameFirst as varchar(20))
        ,drvCompanyDivisionCode = ''
        ,drvOfficer = ''
        ,drvPercentageOwnership = ''
        ,drvHoursofService = CAST(CONVERT(DECIMAL(6,2),PehCurHrs) as varchar(8))
        ,drvOvertimeHours = ''
        ,drvGrossCompensation = CAST(CONVERT(DECIMAL(8,2),PehCurAmt) as varchar(10))
        ,drvOtherCompensation = ''
        ,drvPreTaxDeferralPerElection = ''
        ,drvBonusCompensation = ''
        ,drvCommissionCompensation = ''
        ,drvOvertimeCompensation = ''
        ,drvAdditionalReimbursements = ''
        ,drvSection125Deferrals = ''
        ,drvSection402e3Deferrals = ''
        ,drvSection402h1BDeferrals = ''
        ,drvSection403bDeferrals = ''
        ,drvSection414hDeferrals = ''
        ,drvSection457Deferrals = ''
        ,drvOtherDeferrals = ''
        ,drvEmployeeType = ''
        ,drvSection402ADeferrals = ''
        ,drvSection402ADeferralPercent = ''
        ,drvPreTaxDeferralDollarElec = ''
        ,drvRothDeferralPercentageElec = ''
        ,drvRothDeferralDollarElection = ''
    INTO dbo.U_ENATBIEXP_Salary
    FROM dbo.U_ENATBIEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
     JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
        and (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                                      and EXISTS(select 1 from dbo.U_ENATBIEXP_Audit where  audKey1Value = xEEID AND audKey2Value = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
   JOIN dbo.U_ENATBIEXP_PEarHist WITH (NOLOCK)
        on peheeid = xeeid
    LEFT JOIN (SELECT PgpPayGroup, LEFT(MAX(PgpPeriodControl),8) as PayDate, MAX(PgpPeriodStartDate) PrgPeriodStart, MAX(PgpPeriodEndDate) PrgPeriodEnd 
                   FROM dbo.PgPayPer WITH (NOLOCK)
                   WHERE PgpPeriodControl BETWEEN @StartPerControl AND @EndPerControl 
                   GROUP BY PgpPayGroup) as PayDates
        on EecPaygroup = PgpPayGroup
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ENATBIEXP_Census','U') IS NOT NULL
        DROP TABLE dbo.U_ENATBIEXP_Census;
    SELECT DISTINCT
        drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = eepSSN
        ,drvSubSort = ''
        ,drvTransactionType = 'CENSUS'
        ,drvLineofBusiness = '1'
        ,drvNationwideCaseNumber = '063-86903'
        ,drvEffectiveDate = GETDATE()
        ,drvSSN = eepSSN
        ,drvLastName = CAST(EepNameLast as varchar(20))
        ,drvFirstName = CAST(EepNameFirst as varchar(15)) 
        ,drvAddressLine1 = CAST(EepAddressLine1 as varchar(32))  
        ,drvAddressLine2 = CAST(EepAddressLine2 as varchar(32))   
        ,drvAddressLine3 = ''
        ,drvAddressLine4 = ''
        ,drvCity = CAST(EepAddressCity as varchar(32)) 
        ,drvState = EepAddressState
        ,drvZip = LEFT(EepAddressZipCode,5)
        ,drvZip4 = CASE WHEN LEN(EepAddressZipCode) >= 9 THEN RIGHT(EepAddressZipCode,4) END
        ,drvHireDate = Eecdateoforiginalhire
        ,drvServiceTerminationDate = CASE WHEN EecDateOfOriginalHire  <> EecDateOfLastHire  THEN (select top 1 ehcdateoftermination from emphcomp where ehcdateoftermination is not null and ehceeid = xeeid and ehccoid = xcoid  order by ehcdateoftermination desc) END 
        --If EecDateOfOriginalHire does not = EecDateOfLastHire send prior eecdateoftermination from 
        --audit tables else send eecdateoftermination - exclude any dates after today Keep terminations on the file once then drop them
        ,drvDateofEntry = EecDateOfLastHire 
        ,drvBirthDate = EepDateOfBirth
        ,drvGender = CASE WHEN EepGender in ('M','F') THEN EepGender ELSE 'U' END
        ,drvMaritalStatus = CASE WHEN eepMaritalStatus IN ('S','M','D','W') THEN eepMaritalStatus ELSE 'U' END
        ,drvEmailAddress = EepAddressEMail
        ,drvEmployeeID = EecEmpNo
        ,drvDivisionCode = ''
        ,drvGrossAnnualSalary = CAST(EecAnnSalary as varchar(15))
        ,drvRehireDate = CASE WHEN eecdateoftermination < EecDateOfLastHire then ''
                              WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN EecDateOfLastHire 
                         END
        ,drvAutomaticEnrollmentStatus = ''
        ,drvAutoEnrollmentDate = ''
        ,drvPreTaxDeferralPerElection = CASE WHEN PreTAxPerElect > 0.00 THEN CAST(CONVERT(DECIMAL(3,0),PreTAxPerElect * 100) as varchar(6))  END
        ,drvRothDeferralPerElection =  CASE WHEN ROthPerElect > 0.00 THEN  CAST(CONVERT(DECIMAL(3,0),ROthPerElect * 100) as varchar(6)) END
        ,drvPreTaxDollarElection =   CASE WHEN PreTAxElection > 0.00 and PreTAxPerElect <= 0.00 THEN CAST(CONVERT(DECIMAL(8,2),PreTAxElection) as varchar(8))  END
        ,drvRothdollarElection =   CASE WHEN RothDollarElection > 0.00 and ROthPerElect <= 0.00 THEN CAST(CONVERT(DECIMAL(8,2),RothDollarElection) as varchar(8)) END
        ,drvPhoneNumber = CASE WHEN ISNULL(EepPhoneHomeNumber,'') = '' THEN EecPhoneBusinessNumber ELSE EepPhoneHomeNumber END 
        ,drvFaxNumber = ''
        ,drvRelationshiptoOwner = ''
        ,drvRelatedOwnerSSN = ''
        ,drvEmployeeType = EecSalaryOrHourly 
        ,drvDateofDeath = EepDateDeceased
    INTO dbo.U_ENATBIEXP_Census
    FROM dbo.U_ENATBIEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
        and (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
        and EXISTS(select 1 from dbo.U_ENATBIEXP_Audit where  audKey1Value = xEEID AND audKey2Value = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    JOIN dbo.U_ENATBIEXP_PEarHist WITH (NOLOCK)
        ON peheeid = xeeid
    LEFT JOIN (Select bdmeeid,bdmcoid,
                SUM(CASE WHEN bdmdedcode in ('401K','401KC','401CP') then bdmeeCalcRateorPct ELSE 0.00 END) as PreTAxPerElect, 
                SUM(CASE WHEN bdmdedcode in ('ROTHP', 'RTHUP', 'RTHCP') then ISNULL(bdmeeCalcRateorPct,0.00)   END) as ROthPerElect,
                SUM(CASE WHEN bdmdedcode in ('401CD', '401KD', '401KU') then ISNULL(bdmeeAmt,0.00)   END) as PreTAxElection,
                SUM(CASE WHEN bdmdedcode in ('ROTHD', 'RTHUD', 'RTHCD' ) then ISNULL(bdmeeAmt,0.00)   END) as RothDollarElection
            from dbo.u_dsi_bdm_ENATBIEXP
            Group by bdmeeid,bdmcoid) as BdmConsolidated
    on bdmeeid = xeeid
    and bdmcoid = xcoid
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
ALTER VIEW dbo.dsi_vwENATBIEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ENATBIEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ENATBIEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202007011'
       ,expStartPerControl     = '202007011'
       ,expLastEndPerControl   = '202007159'
       ,expEndPerControl       = '202007159'
WHERE expFormatCode = 'ENATBIEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwENATBIEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ENATBIEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort