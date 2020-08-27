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
@CustomFormatCode - Replace with Format Code (i.e., ECOMDATENR)
@CustomFormatName - Replace with Name of Interface (AdfFormatName) (i.e., Comdata Paycard Enrollment Export)
@IsWebFlag - Replace with 'Y' (Yes) or 'N' (No) for Web Interface Settings

-- File parameters
@FileExportPath - Replace with the Export Path where the file generates to (i.e., \\us.saas\e1\Public\[Client ARNum]\Exports\Comdata\)
@FileTestPath - Replace with the Test Path where the file generates to (i.e., \\us.saas\e1\Public\[Client ARNum]\Exports\Comdata\)
@FileUDESPath - Replace with the UDES Path where the file generates to (i.e., \\us.saas\e0\data_exchange\[Client ARNum]\Exports\)

-- Client Specific parameters
@AccountNumber - Replace with the Account Number, which is usually a numeric value (i.e., 00000000)
@BusinessUnit - Replace with the Business Unit, which is usually a 4 digit number (i.e., 0003)
@IssuingProductCode - Replace with Issuing Produce Code provided by Comdata (i.e., OW1_CH_ISS)
@CardProductCode - Replace with Card Produce Code provided by Comdata (i.e., OW1_STD_SEC)

*/
IF OBJECT_ID('dsi_vw@CustomFormatCode_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vw@CustomFormatCode_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_@CustomFormatCode') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_@CustomFormatCode];
GO
IF OBJECT_ID('U_@CustomFormatCode_Trailer') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_Trailer];
GO
IF OBJECT_ID('U_@CustomFormatCode_File') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_File];
GO
IF OBJECT_ID('U_@CustomFormatCode_EmpDirDp') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_EmpDirDp];
GO
IF OBJECT_ID('U_@CustomFormatCode_EEList') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_EEList];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl];
GO
IF OBJECT_ID('U_@CustomFormatCode_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_AuditFields];
GO
IF OBJECT_ID('U_@CustomFormatCode_Audit') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_Audit];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = '@CustomFormatCode';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = '@CustomFormatCode';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = '@CustomFormatCode';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = '@CustomFormatCode';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = '@CustomFormatCode';
GO

DECLARE @AdhSystemID VARCHAR(12), @FixedFormatName VARCHAR(50);
SET @AdhSystemID = LEFT('@CustomFormatCode' + REPLICATE('0',10),10) + 'Z0';
SET @FixedFormatName = LEFT('@CustomFormatName',50);

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) SELECT 'N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','@CustomFormatCode',@FixedFormatName,'N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N',@AdhSystemID,'N','Jan  1 1900 12:00AM','C','N',NULL,'N';
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Account Number"','1','(''DA''=''TT'')',@AdhSystemID,'50','H','01','1',NULL,'Account Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Business Unit"','2','(''DA''=''TT'')',@AdhSystemID,'50','H','01','2',NULL,'Business Unit',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Create Cardholder"','3','(''DA''=''TT'')',@AdhSystemID,'50','H','01','3',NULL,'Create Cardholder',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Cardholder Reference Number"','4','(''DA''=''TT'')',@AdhSystemID,'50','H','01','4',NULL,'Cardholder Reference Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Card Action"','5','(''DA''=''TT'')',@AdhSystemID,'50','H','01','5',NULL,'Card Action',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Issuing Product Code"','6','(''DA''=''TT'')',@AdhSystemID,'50','H','01','6',NULL,'Issuing Product Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Card Product Code"','7','(''DA''=''TT'')',@AdhSystemID,'50','H','01','7',NULL,'Card Product Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Card Number"','8','(''DA''=''TT'')',@AdhSystemID,'50','H','01','8',NULL,'Card Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Employee ID"','9','(''DA''=''TT'')',@AdhSystemID,'50','H','01','9',NULL,'Employee ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Cardholder First Name"','10','(''DA''=''TT'')',@AdhSystemID,'50','H','01','10',NULL,'Cardholder First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Cardholder Middle Initial"','11','(''DA''=''TT'')',@AdhSystemID,'50','H','01','11',NULL,'Cardholder Middle Initial',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Cardholder Last Name"','12','(''DA''=''TT'')',@AdhSystemID,'50','H','01','12',NULL,'Cardholder Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Embossed First Name"','13','(''DA''=''TT'')',@AdhSystemID,'50','H','01','13',NULL,'Embossed First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Embossed Last Name"','14','(''DA''=''TT'')',@AdhSystemID,'50','H','01','14',NULL,'Embossed Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Shipping Address 1"','15','(''DA''=''TT'')',@AdhSystemID,'50','H','01','15',NULL,'Shipping Address 1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Shipping Address 2"','16','(''DA''=''TT'')',@AdhSystemID,'50','H','01','16',NULL,'Shipping Address 2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Shipping City"','17','(''DA''=''TT'')',@AdhSystemID,'50','H','01','17',NULL,'Shipping City',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Shipping State"','18','(''DA''=''TT'')',@AdhSystemID,'50','H','01','18',NULL,'Shipping State',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Shipping Country"','19','(''DA''=''TT'')',@AdhSystemID,'50','H','01','19',NULL,'Shipping Country',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Shipping Zip"','20','(''DA''=''TT'')',@AdhSystemID,'50','H','01','20',NULL,'Shipping Zip',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Home Phone"','21','(''DA''=''TT'')',@AdhSystemID,'50','H','01','21',NULL,'Home Phone',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Physical Address 1"','22','(''DA''=''TT'')',@AdhSystemID,'50','H','01','22',NULL,'Physical Address 1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Physical Address 2"','23','(''DA''=''TT'')',@AdhSystemID,'50','H','01','23',NULL,'Physical Address 2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Physical City"','24','(''DA''=''TT'')',@AdhSystemID,'50','H','01','24',NULL,'Physical City',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Physical County"','25','(''DA''=''TT'')',@AdhSystemID,'50','H','01','25',NULL,'Physical County',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Physical State"','26','(''DA''=''TT'')',@AdhSystemID,'50','H','01','26',NULL,'Physical State',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Physical Country"','27','(''DA''=''TT'')',@AdhSystemID,'50','H','01','27',NULL,'Physical Country',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Physical Zip"','28','(''DA''=''TT'')',@AdhSystemID,'50','H','01','28',NULL,'Physical Zip',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Mobile Phone"','29','(''DA''=''TT'')',@AdhSystemID,'50','H','01','29',NULL,'Mobile Phone',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Fax Number"','30','(''DA''=''TT'')',@AdhSystemID,'50','H','01','30',NULL,'Fax Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Work Phone"','31','(''DA''=''TT'')',@AdhSystemID,'50','H','01','31',NULL,'Work Phone',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Email Address"','32','(''DA''=''TT'')',@AdhSystemID,'50','H','01','32',NULL,'Email Address',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Country Of Origin"','33','(''DA''=''TT'')',@AdhSystemID,'50','H','01','33',NULL,'Country Of Origin',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Date Of Birth"','34','(''DA''=''TT'')',@AdhSystemID,'50','H','01','34',NULL,'Date Of Birth',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Preferred Language"','35','(''DA''=''TT'')',@AdhSystemID,'50','H','01','35',NULL,'Preferred Language',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Hire Date"','36','(''DA''=''TT'')',@AdhSystemID,'50','H','01','36',NULL,'Hire Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Termination Date"','37','(''DA''=''TT'')',@AdhSystemID,'50','H','01','37',NULL,'Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Employment Type"','38','(''DA''=''TT'')',@AdhSystemID,'50','H','01','38',NULL,'Employment Type',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Driver License Number"','39','(''DA''=''TT'')',@AdhSystemID,'50','H','01','39',NULL,'Driver License Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Drivers License State/Provision/Region"','40','(''DA''=''TT'')',@AdhSystemID,'50','H','01','40',NULL,'Driver''s License State/Provision/Region',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Cardholder ID"','41','(''DA''=''TT'')',@AdhSystemID,'50','H','01','41',NULL,'Cardholder ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Cardholder ID Issuer Country"','42','(''DA''=''TT'')',@AdhSystemID,'50','H','01','42',NULL,'Cardholder ID Issuer Country',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Generic Activation Code"','43','(''DA''=''TT'')',@AdhSystemID,'50','H','01','43',NULL,'Generic Activation Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"5th line Embossing Information"','44','(''DA''=''T'')',@AdhSystemID,'50','H','01','44',NULL,'5th line Embossing Information',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAccountNumber"','1','(''UA''=''TT'')',@AdhSystemID,'24','D','10','1',NULL,'Account Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBusinessUnit"','2','(''UA''=''TT'')',@AdhSystemID,'4','D','10','2',NULL,'Business Unit',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCreateCardholder"','3','(''UA''=''TT'')',@AdhSystemID,'1','D','10','3',NULL,'Create Cardholder',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCardholderReferenceNumber"','4','(''UA''=''TT'')',@AdhSystemID,'12','D','10','4',NULL,'Cardholder Reference Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCardAction"','5','(''UA''=''TT'')',@AdhSystemID,'1','D','10','5',NULL,'Card Action',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvIssuingProductCode"','6','(''UA''=''TT'')',@AdhSystemID,'32','D','10','6',NULL,'Issuing Product Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCardProductCode"','7','(''UA''=''TT'')',@AdhSystemID,'32','D','10','7',NULL,'Card Product Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCardNumber"','8','(''UA''=''TT'')',@AdhSystemID,'16','D','10','8',NULL,'Card Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmployeeID"','9','(''UA''=''TT'')',@AdhSystemID,'32','D','10','9',NULL,'Employee ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCardholderFirstName"','10','(''UA''=''TT'')',@AdhSystemID,'32','D','10','10',NULL,'Cardholder First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCardholderMiddleInitial"','11','(''UA''=''TT'')',@AdhSystemID,'32','D','10','11',NULL,'Cardholder Middle Initial',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCardholderLastName"','12','(''UA''=''TT'')',@AdhSystemID,'32','D','10','12',NULL,'Cardholder Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmbossedFirstName"','13','(''UA''=''TT'')',@AdhSystemID,'10','D','10','13',NULL,'Embossed First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmbossedLastName"','14','(''UA''=''TT'')',@AdhSystemID,'10','D','10','14',NULL,'Embossed Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvShippingAddress1"','15','(''UA''=''TT'')',@AdhSystemID,'60','D','10','15',NULL,'Shipping Address 1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvShippingAddress2"','16','(''UA''=''TT'')',@AdhSystemID,'60','D','10','16',NULL,'Shipping Address 2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvShippingCity"','17','(''UA''=''TT'')',@AdhSystemID,'32','D','10','17',NULL,'Shipping City',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvShippingState"','18','(''UA''=''TT'')',@AdhSystemID,'32','D','10','18',NULL,'Shipping State',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvShippingCountry"','19','(''UA''=''TT'')',@AdhSystemID,'32','D','10','19',NULL,'Shipping Country',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvShippingZip"','20','(''UA''=''TT'')',@AdhSystemID,'32','D','10','20',NULL,'Shipping Zip',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvHomePhone"','21','(''UA''=''TT'')',@AdhSystemID,'32','D','10','21',NULL,'Home Phone',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPhysicalAddress1"','22','(''UA''=''TT'')',@AdhSystemID,'60','D','10','22',NULL,'Physical Address 1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPhysicalAddress2"','23','(''UA''=''TT'')',@AdhSystemID,'60','D','10','23',NULL,'Physical Address 2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPhysicalCity"','24','(''UA''=''TT'')',@AdhSystemID,'32','D','10','24',NULL,'Physical City',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPhysicalCounty"','25','(''UA''=''TT'')',@AdhSystemID,'32','D','10','25',NULL,'Physical County',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPhysicalState"','26','(''UA''=''TT'')',@AdhSystemID,'32','D','10','26',NULL,'Physical State',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPhysicalCountry"','27','(''UA''=''TT'')',@AdhSystemID,'32','D','10','27',NULL,'Physical Country',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPhysicalZip"','28','(''UA''=''TT'')',@AdhSystemID,'32','D','10','28',NULL,'Physical Zip',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMobilePhone"','29','(''UA''=''TT'')',@AdhSystemID,'32','D','10','29',NULL,'Mobile Phone',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvFaxNumber"','30','(''UA''=''TT'')',@AdhSystemID,'32','D','10','30',NULL,'Fax Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvWorkPhone"','31','(''UA''=''TT'')',@AdhSystemID,'32','D','10','31',NULL,'Work Phone',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmailAddress"','32','(''UA''=''TT'')',@AdhSystemID,'32','D','10','32',NULL,'Email Address',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCountryOfOrigin"','33','(''UA''=''TT'')',@AdhSystemID,'32','D','10','33',NULL,'Country Of Origin',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDateOfBirth"','34','(''UD101''=''TT'')',@AdhSystemID,'10','D','10','34',NULL,'Date Of Birth',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPreferredLanguage"','35','(''UA''=''TT'')',@AdhSystemID,'32','D','10','35',NULL,'Preferred Language',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvHireDate"','36','(''UD101''=''TT'')',@AdhSystemID,'10','D','10','36',NULL,'Hire Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvTerminationDate"','37','(''UD101''=''TT'')',@AdhSystemID,'10','D','10','37',NULL,'Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmploymentType"','38','(''UA''=''TT'')',@AdhSystemID,'32','D','10','38',NULL,'Employment Type',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDriverLicenseNumber"','39','(''UA''=''TT'')',@AdhSystemID,'32','D','10','39',NULL,'Driver License Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDriversLicenseStateProvReg"','40','(''UA''=''TT'')',@AdhSystemID,'32','D','10','40',NULL,'Driver''s License State/Provision/Region',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCardholderID"','41','(''UA''=''TT'')',@AdhSystemID,'32','D','10','41',NULL,'Cardholder ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCardholderIDIssuerCountry"','42','(''UA''=''TT'')',@AdhSystemID,'32','D','10','42',NULL,'Cardholder ID Issuer Country',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvGenericActivationCode"','43','(''UA''=''TT'')',@AdhSystemID,'10','D','10','43',NULL,'Generic Activation Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drv5thlineEmbossingInfo"','44','(''UA''=''T'')',@AdhSystemID,'26','D','10','44',NULL,'5th line Embossing Information',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvTotal"','1','(''UA''=''TT'')',@AdhSystemID,'5','T','90','1',NULL,'Total',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvTotalRecords"','2','(''UA''=''T'')',@AdhSystemID,'6','T','90','2',NULL,'Total Records',NULL,NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'FileName Is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','201704059','EMPEXPORT','SCHEDULED','Apr  1 2017 12:00AM','@CustomFormatCode',NULL,NULL,NULL,'201704059','Apr  1 2017 12:00AM','Dec 30 1899 12:00AM','201704011',NULL,'','','201704011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'FileName Is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'OnDemand - Full File Only','201704019','EMPEXPORT','FULLFILE','Apr  1 2017 10:49AM','@CustomFormatCode',NULL,NULL,NULL,'201704019','Apr  1 2017 12:00AM','Dec 30 1899 12:00AM','201704011','47','','','201704011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'FileName Is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Test Purposes Only','201704019','EMPEXPORT','TEST','Apr  1 2017  8:12AM','@CustomFormatCode',NULL,NULL,NULL,'201704019','Apr  1 2017 12:00AM','Dec 30 1899 12:00AM','201704011','5','','','201704011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'FileName Is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'OnDemand - Changes Only File','201704019','EMPEXPORT','CHANGES','Apr  1 2017  8:27AM','@CustomFormatCode',NULL,NULL,NULL,'201704019','Apr  1 2017 12:00AM','Dec 30 1899 12:00AM','201704011','38','','','201704011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','ExportPath','V','@FileExportPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','NoEmpty','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','TestPath','V','@FileTestPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','UDESPath','V','@FileUDESPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','UseFileName','V','N');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D10','dbo.U_@CustomFormatCode_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','T90','dbo.U_@CustomFormatCode_Trailer',NULL);
GO
IF ('@IsWebFlag' = 'Y')
BEGIN
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = '@CustomFormatCode' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */

/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = '@CustomFormatCode.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
UPDATE dbo.AscExp SET expAscFileName = @FILEPATH + @FILENAME WHERE expFormatCode = '@CustomFormatCode';

/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = '@CustomFormatCode' AND CfgName = 'ExportPath' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = '@CustomFormatCode' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
/*03*/ DELETE FROM dbo.U_dsi_Configuration WHERE FormatCode = '@CustomFormatCode' AND CfgName = 'TestPath'; /* Remove Test Path for Web Exports */

END
GO
IF OBJECT_ID('U_@CustomFormatCode_EEList') IS NULL
CREATE TABLE [dbo].[U_@CustomFormatCode_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_@CustomFormatCode_File') IS NULL
CREATE TABLE [dbo].[U_@CustomFormatCode_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(50) NOT NULL,
    [SubSort] varchar(50) NOT NULL,
    [SubSort2] varchar(50) NULL,
    [SubSort3] varchar(50) NULL,
    [Data] varchar(2000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_@CustomFormatCode]
    @SystemID char(12)
AS
/**********************************************************************************
Client Name: @CustomerName

Created By: @DeveloperName
Business Analyst: @IntegrationAnalystName
Create Date: @CreateDate
Service Request Number: @SRNumber

Purpose: @CustomFormatName

Revision History
----------------
Update By            Date            Request Num                Desc
XXXX                 XX/XX/XX        SR-20XX-000XXXXX           Added 1234

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.AscExp WHERE ExpFormatCode = '@CustomFormatCode';

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'FULLFILE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'CHANGES';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'TEST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'SCHEDULED';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = '@CustomFormatCode', @AllObjects = 'Y'
**********************************************************************************/
BEGIN

    --==========================================
    -- Declare variables
    --==========================================
    DECLARE  @FormatCode         VARCHAR(12)
            ,@ExportCode         VARCHAR(12)
            ,@StartDate          DATETIME
            ,@EndDate            DATETIME
            ,@StartPerControl    VARCHAR(9)
            ,@EndPerControl      VARCHAR(9)

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = CASE WHEN ExportCode = 'SCHEDULED' THEN DATEADD(MINUTE,-15,GETDATE()) ELSE CAST(LEFT(StartPerControl,8) AS DATETIME) END
        ,@EndDate         = CASE WHEN ExportCode = 'SCHEDULED' THEN GETDATE() ELSE DATEADD(SS,-1,DATEADD(DD,1,LEFT(EndPerControl,8))) END
        ,@FormatCode      = FormatCode
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = '@CustomFormatCode';

    PRINT 'Start Date: ' + CONVERT(VARCHAR(26),@StartDate,100);
    PRINT 'End Date:  ' + CONVERT(VARCHAR(26),@EndDate,100);

    --==========================================
    -- Clean EE List
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_@CustomFormatCode_EEList
	WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCoID(xEEID);

    --==========================================
    -- Audit Section
    --==========================================
    IF OBJECT_ID('U_@CustomFormatCode_Audit') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_Audit;
    SELECT
         audEEID = audKey1Value
        ,audKey2 = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
    INTO dbo.U_@CustomFormatCode_Audit
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.vw_AuditData WITH (NOLOCK)
        ON audKey1Value = xEEID
        AND audDateTime BETWEEN @StartDate AND @EndDate
        AND audTableName = 'EmpDirDp'
        AND audFieldName = 'EddAcct'
        AND audAction IN ('INSERT','UPDATE')
        AND ISNULL(audNewValue,'') <> ''
    WHERE audUserName NOT LIKE '%ULTI%';

    --================
    -- Changes Only
    --================
    IF (@ExportCode <> 'FULLFILE')
    BEGIN
        DELETE FROM dbo.U_@CustomFormatCode_EEList
        WHERE NOT EXISTS (SELECT 1 FROM dbo.U_@CustomFormatCode_Audit WHERE audEEID = xEEID);
    END

    --==========================================
    -- Build Employee Data and the driver tables
    --==========================================

    -------------------------------
    -- Working Table - EmpDirDp
    -------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_EmpDirDp') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_EmpDirDp;
    SELECT DISTINCT EddEEID, EddCoID, EddDepositRule, EddAmtOrPct, EddAcct, EddAcctType, EddDdOrPrenote
    INTO dbo.U_@CustomFormatCode_EmpDirDp
    FROM dbo.EmpDirDp WITH (NOLOCK)
    WHERE EddAccountIsInactive = 'N' AND LEN(EddAcct) = 16;

    -- Initial Full File - Employees who are Active or on LOA who have part of their earnings going to paper checks:
    IF (@ExportCode = 'FULLFILE')
    BEGIN

        -- Remove Employee's with Available Balance
        DELETE FROM dbo.U_@CustomFormatCode_EmpDirDp
        FROM dbo.U_@CustomFormatCode_EmpDirDp E1
        WHERE EddDepositRule = 'A';

        DELETE FROM dbo.U_@CustomFormatCode_EmpDirDp
        FROM dbo.U_@CustomFormatCode_EmpDirDp E1
        WHERE NOT EXISTS (SELECT 1 FROM dbo.U_@CustomFormatCode_EmpDirDp E2 WHERE E2.EddEEID = E1.EddEEID AND E2.EddCoID = E1.EddCoID HAVING SUM(E2.EddAmtOrPct) = 100);

    END

    -- Ongoing Changes - Employee has a newly added paycard into the direct deposit table:
    IF (@ExportCode <> 'FULLFILE')
    BEGIN

        -- Remove Employee's with Acct Type <> 'D'
        DELETE FROM dbo.U_@CustomFormatCode_EmpDirDp
        FROM dbo.U_@CustomFormatCode_EmpDirDp WITH (NOLOCK)
        JOIN dbo.U_@CustomFormatCode_Audit WITH (NOLOCK)
            ON audEEID = EddEEID
            AND audKey2 = EddCoID
            AND audKey3 = EddAcct
            AND EddAcctType <> 'D';

    END

    ------------------
    -- DETAIL RECORD
    ------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl;
    SELECT DISTINCT
         drvAccountNumber = '@AccountNumber'
        ,drvBusinessUnit = '@BusinessUnit'
        ,drvCreateCardholder = 'C'
        ,drvCardholderReferenceNumber = ''
        ,drvCardAction = 'X'
        ,drvIssuingProductCode = '@IssuingProductCode'
        ,drvCardProductCode = '@CardProductCode'
        ,drvCardNumber = EddAcct
        ,drvEmployeeID = EecEmpNo
        ,drvCardholderFirstName = dbo.fn_RemoveSpecialChars(EepNameFirst)
        ,drvCardholderMiddleInitial = dbo.fn_RemoveSpecialChars(LEFT(EepNameMiddle,1))
        ,drvCardholderLastName = dbo.fn_RemoveSpecialChars(EepNameLast)
        ,drvEmbossedFirstName = dbo.fn_RemoveSpecialChars(EepNameFirst)
        ,drvEmbossedLastName = dbo.fn_RemoveSpecialChars(EepNameLast)
        ,drvShippingAddress1 = EepAddressLine1
        ,drvShippingAddress2 = EepAddressLine2
        ,drvShippingCity = EepAddressCity
        ,drvShippingState = dbo.fn_RemoveSpecialChars(EepAddressState)
        ,drvShippingCountry = 'USA'
        ,drvShippingZip = dbo.fn_RemoveSpecialChars(LEFT(EepAddressZipCode,5))
        ,drvHomePhone = dbo.fn_RemoveSpecialChars(EepPhoneHomeNumber)
        ,drvPhysicalAddress1 = EepAddressLine1
        ,drvPhysicalAddress2 = EepAddressLine2
        ,drvPhysicalCity = EepAddressCity
        ,drvPhysicalCounty = 'COUNTY'
        ,drvPhysicalState = dbo.fn_RemoveSpecialChars(EepAddressState)
        ,drvPhysicalCountry = 'USA'
        ,drvPhysicalZip = dbo.fn_RemoveSpecialChars(LEFT(EepAddressZipCode,5))
        ,drvMobilePhone = ''
        ,drvFaxNumber = ''
        ,drvWorkPhone = ''
        ,drvEmailAddress = ''
        ,drvCountryOfOrigin = 'USA'
        ,drvDateOfBirth = EepDateOfBirth
        ,drvPreferredLanguage = CASE WHEN EecLanguageCode = 'ES' THEN 'Spanish'
                                     ELSE 'English'
                                END
        ,drvHireDate = ''
        ,drvTerminationDate = ''
        ,drvEmploymentType = ''
        ,drvDriverLicenseNumber = ''
        ,drvDriversLicenseStateProvReg = ''
        ,drvCardholderID = EepSSN
        ,drvCardholderIDIssuerCountry = 'USA'
        ,drvGenericActivationCode = ''
        ,drv5thlineEmbossingInfo = ''
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EecEmpNo)
    INTO dbo.U_@CustomFormatCode_drvTbl
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCoID = xCOID
    JOIN dbo.Company WITH (NOLOCK)
        ON CmpCoID = xCOID
    JOIN dbo.U_@CustomFormatCode_EmpDirDp WITH (NOLOCK)
        ON EddEEID = xEEID
        AND EddCoID = xCOID
    ;

    ------------------
    -- TRAILER RECORD
    ------------------
    IF OBJECT_ID('U_@CustomFormatCode_Trailer') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_Trailer;
    SELECT DISTINCT
        drvTotal = 'TOTAL'
        ,drvTotalRecords = COUNT(*)
    INTO dbo.U_@CustomFormatCode_Trailer
    FROM dbo.U_@CustomFormatCode_drvTbl WITH (NOLOCK);

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable('@CustomFormatCode','UseFileName') = 'N')
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = '@AccountNumber.CardholderCreate_'
                                + CONVERT(CHAR(8),GETDATE(),112)                            -- YYYYMMDD
                                + REPLACE(CONVERT(VARCHAR(8),GETDATE(),108),':',SPACE(0))    -- HHMMSS
                                + '.tsv'
        WHERE FormatCode = '@CustomFormatCode';

END
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vw@CustomFormatCode_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_@CustomFormatCode_File (NOLOCK)
    ORDER BY SUBSTRING(RecordSet,2,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE '@CustomFormatCode%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET ExpLastStartPerControl = '201704011'
       ,ExpStartPerControl     = '201704011'
       ,ExpLastEndPerControl   = '201704019'
       ,ExpEndPerControl       = '201704019'
WHERE ExpFormatCode = '@CustomFormatCode';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vw@CustomFormatCode_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_@CustomFormatCode_File (NOLOCK)
    ORDER BY SUBSTRING(RecordSet,2,2), InitialSort, SubSort;
GO