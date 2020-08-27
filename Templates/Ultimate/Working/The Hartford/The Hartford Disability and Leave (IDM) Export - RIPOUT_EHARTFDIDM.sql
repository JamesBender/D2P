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
@CustomFormatCode - Replace with Format Code (i.e., 'EHARTFDIDM')
@CustomFormatName - Replace with Name of Interface (AdfFormatName) (i.e., The Hartford Disability and Leave Export - IDM)
@IsWebFlag - Replace with 'Y' (Yes) or 'N' (No) for Web Interface Settings

-- File parameters
@FileExportPath - Replace with the Export Path where the file generates to (i.e., \\us.saas\e1\Public\[Client ARNum]\Exports\Hartford\)
@FileTestPath - Replace with the Test Path where the file generates to (i.e., \\us.saas\e1\Public\[Client ARNum]\Exports\Hartford\)
@FileUDESPath - Replace with the UDES Path where the file generates to (i.e., \\us.saas\e0\data_exchange\[Client ARNum]\Exports\)
@FileNamePrefix - Replace with prefix of filename (i.e., [FileNamePrefix]_YYYYMMDD.txt)

-- Client Specific parameters
@CustomerName - Replace with "Customer Name" in HDR Record
@FileVersionNumber - Replace with "File Version Number" in HDR Record (i.e., 002.00)
@CustomerNumber - Replace with "Customer Number" in HDR Record (i.e., 0000000)

*/
SET NOCOUNT ON;
IF OBJECT_ID('dsi_fnlib_GetAnnSalary_EffDate') IS NOT NULL DROP FUNCTION [dbo].[dsi_fnlib_GetAnnSalary_EffDate];
GO
IF OBJECT_ID('dsi_vw@CustomFormatCode_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vw@CustomFormatCode_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_@CustomFormatCode') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_@CustomFormatCode];
GO
IF OBJECT_ID('U_@CustomFormatCode_Trailer') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_Trailer];
GO
IF OBJECT_ID('U_@CustomFormatCode_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_PEarHist];
GO
IF OBJECT_ID('U_@CustomFormatCode_ISOCountryCodeMapping') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping];
GO
IF OBJECT_ID('U_@CustomFormatCode_Header') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_Header];
GO
IF OBJECT_ID('U_@CustomFormatCode_File') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_File];
GO
IF OBJECT_ID('U_@CustomFormatCode_EEList') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_EEList];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl];
GO
IF OBJECT_ID('U_@CustomFormatCode_DedList') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_DedList];
GO
IF OBJECT_ID('U_@CustomFormatCode_Audit') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_@CustomFormatCode') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_@CustomFormatCode];
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

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) SELECT 'N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','@CustomFormatCode',@FixedFormatName,'N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','11566','S','N',@AdhSystemID,'N','Jan  1 1900 12:00AM','C','N',NULL,'N';
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"~HDR~"','1','(''DA''=''F'')',@AdhSystemID,'5','H','01','1',NULL,'Section code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDetailCount"','2','(''UA''=''F'')',@AdhSystemID,'3','H','01','2',NULL,'Customer Count',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvFileName"','3','(''UA''=''F'')',@AdhSystemID,'30','H','01','3',NULL,'File Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvRunDate"','4','(''UD112''=''F'')',@AdhSystemID,'20','H','01','4',NULL,'Date File Created',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"@Customer Name"','5','(''DA''=''F'')',@AdhSystemID,'20','H','01','5',NULL,'Customer Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"@FileVersionNumber"','6','(''DA''=''F'')',@AdhSystemID,'6','H','01','6',NULL,'File Version Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"~PII~"','1','(''DA''=''F'')',@AdhSystemID,'5','D','10','1',NULL,'Section code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"@CustomerNumber"','2','(''DA''=''F'')',@AdhSystemID,'10','D','10','2',NULL,'Customer Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"E"','3','(''DA''=''F'')',@AdhSystemID,'1','D','10','3',NULL,'Transaction Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmployeeSSN"','4','(''UA''=''F'')',@AdhSystemID,'9','D','10','4',NULL,'Employee SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmployeeID"','5','(''UA''=''F'')',@AdhSystemID,'15','D','10','5',NULL,'Employee ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMemberSSNMemberID"','6','(''UA''=''F'')',@AdhSystemID,'9','D','10','6',NULL,'Member SSN/Member ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','7','(''SS''=''F'')',@AdhSystemID,'2','D','10','7',NULL,'Relationship Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLastName"','8','(''UA''=''F'')',@AdhSystemID,'30','D','10','8',NULL,'Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvFirstName"','9','(''UA''=''F'')',@AdhSystemID,'30','D','10','9',NULL,'First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMiddleInitial"','10','(''UA''=''F'')',@AdhSystemID,'1','D','10','10',NULL,'Middle Initial',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvNamePrefix"','11','(''UA''=''F'')',@AdhSystemID,'10','D','10','11',NULL,'Name Prefix',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvNameSuffix"','12','(''UA''=''F'')',@AdhSystemID,'10','D','10','12',NULL,'Name Suffix',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDateofBirth"','13','(''UD112''=''F'')',@AdhSystemID,'8','D','10','13',NULL,'Date of Birth',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','14','(''SS''=''F'')',@AdhSystemID,'1','D','10','14',NULL,'Marital Status',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvGender"','15','(''UA''=''F'')',@AdhSystemID,'1','D','10','15',NULL,'Gender',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','16','(''SS''=''F'')',@AdhSystemID,'1','D','10','16',NULL,'Smoker Status',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"~BNK~"','17','(''DA''=''F'')',@AdhSystemID,'5','D','10','17',NULL,'Section Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','18','(''SS''=''F'')',@AdhSystemID,'20','D','10','18',NULL,'Bank ABA Routing Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','19','(''SS''=''F'')',@AdhSystemID,'40','D','10','19',NULL,'Bank Account Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','20','(''SS''=''F'')',@AdhSystemID,'1','D','10','20',NULL,'Bank Account Type',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"~ECI~"','21','(''DA''=''F'')',@AdhSystemID,'5','D','10','21',NULL,'Section Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMemberMailingAddress1"','22','(''UA''=''F'')',@AdhSystemID,'40','D','10','22',NULL,'Member Mailing Address 1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMemberMailingAddress2"','23','(''UA''=''F'')',@AdhSystemID,'40','D','10','23',NULL,'Member Mailing Address 2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMemberMailingAddressCity"','24','(''UA''=''F'')',@AdhSystemID,'30','D','10','24',NULL,'Member Mailing Address City',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMemberMailingAddressState"','25','(''UA''=''F'')',@AdhSystemID,'2','D','10','25',NULL,'Member Mailing Address State',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMemberMailingAddrZipCode"','26','(''UA''=''F'')',@AdhSystemID,'10','D','10','26',NULL,'Member Mailing Address Zip Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMemberMailingAddrCountry"','27','(''UA''=''F'')',@AdhSystemID,'3','D','10','27',NULL,'Member Mailing Address Country Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMemberMailingAddrProvince"','28','(''UA''=''F'')',@AdhSystemID,'2','D','10','28',NULL,'Member Mailing Address Province Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','29','(''SS''=''F'')',@AdhSystemID,'30','D','10','29',NULL,'Member Mailing Address Province Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmployeeHomePhone"','30','(''UA''=''F'')',@AdhSystemID,'10','D','10','30',NULL,'Employee Home Phone',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','31','(''SS''=''F'')',@AdhSystemID,'10','D','10','31',NULL,'Employee Cell Phone',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','32','(''SS''=''F'')',@AdhSystemID,'50','D','10','32',NULL,'Employee Personal E-mail Address',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmployeeWorkEmailAddress"','33','(''UA''=''F'')',@AdhSystemID,'50','D','10','33',NULL,'Employee Work E-mail Address',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmployeeWorkStateCode"','34','(''UA''=''F'')',@AdhSystemID,'2','D','10','34',NULL,'Employee Work State Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','35','(''SS''=''F'')',@AdhSystemID,'40','D','10','35',NULL,'Employee Work Address 1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','36','(''SS''=''F'')',@AdhSystemID,'40','D','10','36',NULL,'Employee Work Address 2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','37','(''SS''=''F'')',@AdhSystemID,'30','D','10','37',NULL,'Employee Work Address City',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','38','(''SS''=''F'')',@AdhSystemID,'2','D','10','38',NULL,'Employee Work Address State',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','39','(''SS''=''F'')',@AdhSystemID,'10','D','10','39',NULL,'Employee Work Address Zip Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmployeeWorkAddressCountry"','40','(''UA''=''F'')',@AdhSystemID,'3','D','10','40',NULL,'Employee Work Address Country Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmployeeWorkPhone"','41','(''UA''=''F'')',@AdhSystemID,'10','D','10','41',NULL,'Employee Work Phone',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"~ERC~"','42','(''DA''=''F'')',@AdhSystemID,'5','D','10','42',NULL,'Section Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','43','(''SS''=''F'')',@AdhSystemID,'30','D','10','43',NULL,'Supervisor Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','44','(''SS''=''F'')',@AdhSystemID,'30','D','10','44',NULL,'Supervisor First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSupervisorID"','45','(''UA''=''F'')',@AdhSystemID,'20','D','10','45',NULL,'Supervisor ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','46','(''SS''=''F'')',@AdhSystemID,'10','D','10','46',NULL,'Supervisor Work Phone Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','47','(''SS''=''F'')',@AdhSystemID,'50','D','10','47',NULL,'Supervisor Email Address',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','48','(''SS''=''F'')',@AdhSystemID,'30','D','10','48',NULL,'HR Manager Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','49','(''SS''=''F'')',@AdhSystemID,'30','D','10','49',NULL,'HR Manager First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvHRManagerID"','50','(''UA''=''F'')',@AdhSystemID,'20','D','10','50',NULL,'HR Manager ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','51','(''SS''=''F'')',@AdhSystemID,'10','D','10','51',NULL,'HR Manager Work Phone Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','52','(''SS''=''F'')',@AdhSystemID,'50','D','10','52',NULL,'HR Manager Email Address',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','53','(''SS''=''F'')',@AdhSystemID,'30','D','10','53',NULL,'ER Contact Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','54','(''SS''=''F'')',@AdhSystemID,'30','D','10','54',NULL,'ER Contact First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','55','(''SS''=''F'')',@AdhSystemID,'20','D','10','55',NULL,'ER ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','56','(''SS''=''F'')',@AdhSystemID,'50','D','10','56',NULL,'ER Contact Email Address',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"~EMI~"','57','(''DA''=''F'')',@AdhSystemID,'5','D','10','57',NULL,'Section Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmployeeStatusCode"','58','(''UA''=''F'')',@AdhSystemID,'1','D','10','58',NULL,'Employee Status Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmployeeStatusEffDate"','59','(''UD112''=''F'')',@AdhSystemID,'8','D','10','59',NULL,'Employee Status Effective Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmployeeServiceDate"','60','(''UD112''=''F'')',@AdhSystemID,'8','D','10','60',NULL,'Employee Service Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvRehireDate"','61','(''UD112''=''F'')',@AdhSystemID,'8','D','10','61',NULL,'Rehire Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvOriginalHireDate"','62','(''UD112''=''F'')',@AdhSystemID,'8','D','10','62',NULL,'Original Hire Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','63','(''SS''=''F'')',@AdhSystemID,'10','D','10','63',NULL,'Employee Termination Reason Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','64','(''SS''=''F'')',@AdhSystemID,'35','D','10','64',NULL,'Employee Termination Description',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','65','(''SS''=''F'')',@AdhSystemID,'8','D','10','65',NULL,'Last Day Worked',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmploymentType"','66','(''UA''=''F'')',@AdhSystemID,'2','D','10','66',NULL,'Employment Type',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvExemptNonExempt"','67','(''UA''=''F'')',@AdhSystemID,'1','D','10','67',NULL,'Exempt/Non-Exempt',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvScheduledHoursPerWeek"','68','(''UA''=''F'')',@AdhSystemID,'4','D','10','68',NULL,'Scheduled Hours Per Week',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBenefitSalaryAmount"','69','(''UA''=''F'')',@AdhSystemID,'9','D','10','69',NULL,'Benefit Salary Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Annual"','70','(''DA''=''F'')',@AdhSystemID,'1','D','10','70',NULL,'Salary Basis',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','71','(''SS''=''F'')',@AdhSystemID,'12','D','10','71',NULL,'Additional Salary Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','72','(''SS''=''F'')',@AdhSystemID,'2','D','10','72',NULL,'Additional Salary/Wage Basis',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSalaryEffectiveDate"','73','(''UD112''=''F'')',@AdhSystemID,'8','D','10','73',NULL,'Salary Effective Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','74','(''SS''=''F'')',@AdhSystemID,'9','D','10','74',NULL,'Commission Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','75','(''SS''=''F'')',@AdhSystemID,'9','D','10','75',NULL,'Bonus',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPayrollBasis"','76','(''UA''=''F'')',@AdhSystemID,'1','D','10','76',NULL,'Payroll Basis',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPayGradeLevel"','77','(''UA''=''F'')',@AdhSystemID,'4','D','10','77',NULL,'Pay Grade Level',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','78','(''SS''=''F'')',@AdhSystemID,'2','D','10','78',NULL,'Pay Period Frequency',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','79','(''SS''=''F'')',@AdhSystemID,'8','D','10','79',NULL,'Pay Period Begin Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','80','(''SS''=''F'')',@AdhSystemID,'8','D','10','80',NULL,'Pay Period End Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvJobTitle"','81','(''UA''=''F'')',@AdhSystemID,'25','D','10','81',NULL,'Job Title',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','82','(''SS''=''F'')',@AdhSystemID,'1','D','10','82',NULL,'Job Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','83','(''SS''=''F'')',@AdhSystemID,'10','D','10','83',NULL,'Payroll Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCompanyCode"','84','(''UA''=''F'')',@AdhSystemID,'10','D','10','84',NULL,'Company Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','85','(''SS''=''F'')',@AdhSystemID,'10','D','10','85',NULL,'Department Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','86','(''SS''=''F'')',@AdhSystemID,'10','D','10','86',NULL,'Division Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','87','(''SS''=''F'')',@AdhSystemID,'10','D','10','87',NULL,'Location Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','88','(''SS''=''F'')',@AdhSystemID,'10','D','10','88',NULL,'Region Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','89','(''SS''=''F'')',@AdhSystemID,'10','D','10','89',NULL,'Account Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvUnionIndicator"','90','(''UA''=''F'')',@AdhSystemID,'1','D','10','90',NULL,'Union Indicator',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvUnionName"','91','(''UA''=''F'')',@AdhSystemID,'10','D','10','91',NULL,'Union Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','92','(''SS''=''F'')',@AdhSystemID,'30','D','10','92',NULL,'Medical Carrier',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','93','(''SS''=''F'')',@AdhSystemID,'30','D','10','93',NULL,'Mental Health Carrier',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"~CSF~"','94','(''DA''=''F'')',@AdhSystemID,'5','D','10','94',NULL,'Section Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvClientSpecificField1Name"','95','(''UA''=''F'')',@AdhSystemID,'30','D','10','95',NULL,'Client-Specific Field #1 Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvClientSpecificField1Value"','96','(''UA''=''F'')',@AdhSystemID,'30','D','10','96',NULL,'Client-Specific Field #1 Value',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvClientSpecificField2Name"','97','(''UA''=''F'')',@AdhSystemID,'30','D','10','97',NULL,'Client-Specific Field #2 Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvClientSpecificField2Value"','98','(''UA''=''F'')',@AdhSystemID,'30','D','10','98',NULL,'Client-Specific Field #2 Value',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvClientSpecificField3Name"','99','(''UA''=''F'')',@AdhSystemID,'30','D','10','99',NULL,'Client-Specific Field #3 Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvClientSpecificField3Value"','100','(''UA''=''F'')',@AdhSystemID,'30','D','10','100',NULL,'Client-Specific Field #3 Value',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvClientSpecificField4Name"','101','(''UA''=''F'')',@AdhSystemID,'30','D','10','101',NULL,'Client-Specific Field#4 Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvClientSpecificField4Value"','102','(''UA''=''F'')',@AdhSystemID,'30','D','10','102',NULL,'Client-Specific Field #4 Value',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvClientSpecificField5Name"','103','(''UA''=''F'')',@AdhSystemID,'30','D','10','103',NULL,'Client-Specific Field #5 Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvClientSpecificField5Value"','104','(''UA''=''F'')',@AdhSystemID,'30','D','10','104',NULL,'Client-Specific Field #5 Value',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvClientSpecificField6Name"','105','(''UA''=''F'')',@AdhSystemID,'30','D','10','105',NULL,'Client-Specific Field #6 Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvClientSpecificField6Value"','106','(''UA''=''F'')',@AdhSystemID,'30','D','10','106',NULL,'Client-Specific Field #6 Value',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvClientSpecificField7Name"','107','(''UA''=''F'')',@AdhSystemID,'30','D','10','107',NULL,'Client-Specific Field #7 Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvClientSpecificField7Value"','108','(''UA''=''F'')',@AdhSystemID,'30','D','10','108',NULL,'Client-Specific Field #7 Value',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvClientSpecificField8Name"','109','(''UA''=''F'')',@AdhSystemID,'30','D','10','109',NULL,'Client-Specific Field #8 Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvClientSpecificField8Value"','110','(''UA''=''F'')',@AdhSystemID,'30','D','10','110',NULL,'Client-Specific Field #8 Value',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"~NST~"','111','(''DA''=''F'')',@AdhSystemID,'5','D','10','111',NULL,'Section Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvNSTCoverageEffectiveDate"','112','(''UD112''=''F'')',@AdhSystemID,'8','D','10','112',NULL,'Coverage Effective Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvNSTCoverageTerminationDate"','113','(''UD112''=''F'')',@AdhSystemID,'8','D','10','113',NULL,'Coverage Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','114','(''SS''=''F'')',@AdhSystemID,'9','D','10','114',NULL,'STD Covered Salary',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','115','(''SS''=''F'')',@AdhSystemID,'5','D','10','115',NULL,'STD Coverage Plan Option',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','116','(''SS''=''F'')',@AdhSystemID,'5','D','10','116',NULL,'STD Requested Coverage Plan Option',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvNSTPlanSummary"','117','(''UA''=''F'')',@AdhSystemID,'7','D','10','117',NULL,'Plan Summary',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvNSTEmployeeGroupID"','118','(''UA''=''F'')',@AdhSystemID,'5','D','10','118',NULL,'Employee Group ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','119','(''SS''=''F'')',@AdhSystemID,'3','D','10','119',NULL,'Employee Class Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"~NSB~"','120','(''DA''=''F'')',@AdhSystemID,'5','D','10','120',NULL,'Section Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','121','(''SS''=''F'')',@AdhSystemID,'8','D','10','121',NULL,'Coverage Effective Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','122','(''SS''=''F'')',@AdhSystemID,'8','D','10','122',NULL,'Coverage Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','123','(''SS''=''F'')',@AdhSystemID,'9','D','10','123',NULL,'STD Covered Salary',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','124','(''SS''=''F'')',@AdhSystemID,'5','D','10','124',NULL,'STD Coverage Plan Option',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','125','(''SS''=''F'')',@AdhSystemID,'5','D','10','125',NULL,'STD Requested Coverage Plan Option',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','126','(''SS''=''F'')',@AdhSystemID,'7','D','10','126',NULL,'Plan Summary',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','127','(''SS''=''F'')',@AdhSystemID,'5','D','10','127',NULL,'Employee Group ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','128','(''SS''=''F'')',@AdhSystemID,'3','D','10','128',NULL,'Employee Class Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"~STA~"','129','(''DA''=''F'')',@AdhSystemID,'5','D','10','129',NULL,'Section Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','130','(''SS''=''F'')',@AdhSystemID,'8','D','10','130',NULL,'Coverage Effective Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','131','(''SS''=''F'')',@AdhSystemID,'8','D','10','131',NULL,'Coverage Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','132','(''SS''=''F'')',@AdhSystemID,'5','D','10','132',NULL,'Statutory Coverage Plan Option',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','133','(''SS''=''F'')',@AdhSystemID,'5','D','10','133',NULL,'Statutory Requested Coverage Plan Option',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','134','(''SS''=''F'')',@AdhSystemID,'7','D','10','134',NULL,'Plan Summary',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','135','(''SS''=''F'')',@AdhSystemID,'5','D','10','135',NULL,'Employee Group ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','136','(''SS''=''F'')',@AdhSystemID,'3','D','10','136',NULL,'Employee Class Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"~PFL~"','137','(''DA''=''F'')',@AdhSystemID,'5','D','10','137',NULL,'Section Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','138','(''SS''=''F'')',@AdhSystemID,'2','D','10','138',NULL,'State PFL Enrolled',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','139','(''SS''=''F'')',@AdhSystemID,'8','D','10','139',NULL,'Coverage Effective Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','140','(''SS''=''F'')',@AdhSystemID,'8','D','10','140',NULL,'Coverage Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','141','(''SS''=''F'')',@AdhSystemID,'7','D','10','141',NULL,'Plan Summary',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','142','(''SS''=''F'')',@AdhSystemID,'5','D','10','142',NULL,'Employee Group ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','143','(''SS''=''F'')',@AdhSystemID,'3','D','10','143',NULL,'Employee Class Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"~FLX~"','144','(''DA''=''F'')',@AdhSystemID,'5','D','10','144',NULL,'Section Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','145','(''SS''=''F'')',@AdhSystemID,'8','D','10','145',NULL,'Coverage Effective Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','146','(''SS''=''F'')',@AdhSystemID,'8','D','10','146',NULL,'Coverage Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','147','(''SS''=''F'')',@AdhSystemID,'3','D','10','147',NULL,'DisabilityFLEX Benefit Commencement Period - Day I',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','148','(''SS''=''F'')',@AdhSystemID,'3','D','10','148',NULL,'DisabilityFLEX Benefit Commencement Period - Day S',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','149','(''SS''=''F'')',@AdhSystemID,'3','D','10','149',NULL,'DisabilityFLEX Benefit Duration',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','150','(''SS''=''F'')',@AdhSystemID,'6','D','10','150',NULL,'DisabilityFLEX Benefit Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','151','(''SS''=''F'')',@AdhSystemID,'7','D','10','151',NULL,'Plan Summary',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','152','(''SS''=''F'')',@AdhSystemID,'5','D','10','152',NULL,'Employee Group ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','153','(''SS''=''F'')',@AdhSystemID,'3','D','10','153',NULL,'Employee Class Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"~LTD~"','154','(''DA''=''F'')',@AdhSystemID,'5','D','10','154',NULL,'Section Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLTDCoverageEffectiveDate"','155','(''UD112''=''F'')',@AdhSystemID,'8','D','10','155',NULL,'Coverage Effective Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLTDCoverageTerminationDate"','156','(''UD112''=''F'')',@AdhSystemID,'8','D','10','156',NULL,'Coverage Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','157','(''SS''=''F'')',@AdhSystemID,'10','D','10','157',NULL,'Coverage Termination Reason Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','158','(''SS''=''F'')',@AdhSystemID,'35','D','10','158',NULL,'Coverage Termination Description',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','159','(''SS''=''F'')',@AdhSystemID,'9','D','10','159',NULL,'LTD Covered Salary',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','160','(''SS''=''F'')',@AdhSystemID,'5','D','10','160',NULL,'LTD Coverage Plan Option',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','161','(''SS''=''F'')',@AdhSystemID,'5','D','10','161',NULL,'LTD Requested Coverage Plan Option',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLTDPlanSummary"','162','(''UA''=''F'')',@AdhSystemID,'7','D','10','162',NULL,'Plan Summary',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLTDEmployeeGroupID"','163','(''UA''=''F'')',@AdhSystemID,'5','D','10','163',NULL,'Employee Group ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','164','(''SS''=''F'')',@AdhSystemID,'3','D','10','164',NULL,'Employee Class Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"~LDB~"','165','(''DA''=''F'')',@AdhSystemID,'5','D','10','165',NULL,'Section Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','166','(''SS''=''F'')',@AdhSystemID,'8','D','10','166',NULL,'Coverage Effective Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','167','(''SS''=''F'')',@AdhSystemID,'8','D','10','167',NULL,'Coverage Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','168','(''SS''=''F'')',@AdhSystemID,'10','D','10','168',NULL,'Coverage Termination Reason Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','169','(''SS''=''F'')',@AdhSystemID,'35','D','10','169',NULL,'Coverage Termination Description',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','170','(''SS''=''F'')',@AdhSystemID,'9','D','10','170',NULL,'LTD Covered Salary',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','171','(''SS''=''F'')',@AdhSystemID,'5','D','10','171',NULL,'LTD Coverage Plan Option',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','172','(''SS''=''F'')',@AdhSystemID,'5','D','10','172',NULL,'LTD Requested Coverage Plan Option',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','173','(''SS''=''F'')',@AdhSystemID,'7','D','10','173',NULL,'Plan Summary',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','174','(''SS''=''F'')',@AdhSystemID,'5','D','10','174',NULL,'Employee Group ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','175','(''SS''=''F'')',@AdhSystemID,'3','D','10','175',NULL,'Employee Class Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"~RPL~"','176','(''DA''=''F'')',@AdhSystemID,'5','D','10','176',NULL,'Section Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvReportingLevel1"','177','(''UA''=''F'')',@AdhSystemID,'20','D','10','177',NULL,'Reporting Level 1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvReportingLevel2"','178','(''UA''=''F'')',@AdhSystemID,'20','D','10','178',NULL,'Reporting Level 2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvReportingLevel3"','179','(''UA''=''F'')',@AdhSystemID,'20','D','10','179',NULL,'Reporting Level 3',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvReportingLevel4"','180','(''UA''=''F'')',@AdhSystemID,'20','D','10','180',NULL,'Reporting Level 4',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvReportingLevel5"','181','(''UA''=''F'')',@AdhSystemID,'20','D','10','181',NULL,'Reporting Level 5',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvReportingLevel6"','182','(''UA''=''F'')',@AdhSystemID,'20','D','10','182',NULL,'Reporting Level 6',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvReportingLevel7"','183','(''UA''=''F'')',@AdhSystemID,'20','D','10','183',NULL,'Reporting Level 7',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvReportingLevel8"','184','(''UA''=''F'')',@AdhSystemID,'20','D','10','184',NULL,'Reporting Level 8',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvReportingLevel9"','185','(''UA''=''F'')',@AdhSystemID,'20','D','10','185',NULL,'Reporting Level 9',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvReportingLevel10"','186','(''UA''=''F'')',@AdhSystemID,'20','D','10','186',NULL,'Reporting Level 10',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvReportingLevel11"','187','(''UA''=''F'')',@AdhSystemID,'20','D','10','187',NULL,'Reporting Level 11',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvReportingLevel12"','188','(''UA''=''F'')',@AdhSystemID,'20','D','10','188',NULL,'Reporting Level 12',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"~BLF~"','189','(''DA''=''F'')',@AdhSystemID,'5','D','10','189',NULL,'Basic Life Plan',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','190','(''SS''=''F'')',@AdhSystemID,'8','D','10','190',NULL,'Coverage Effective Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','191','(''SS''=''F'')',@AdhSystemID,'8','D','10','191',NULL,'Coverage Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','192','(''SS''=''F'')',@AdhSystemID,'10','D','10','192',NULL,'Coverage Termination Reason Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','193','(''SS''=''F'')',@AdhSystemID,'35','D','10','193',NULL,'Coverage Termination Description',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','194','(''SS''=''F'')',@AdhSystemID,'3','D','10','194',NULL,'Basic Life Multiple of Salary Face Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','195','(''SS''=''F'')',@AdhSystemID,'11','D','10','195',NULL,'Basic Life Face Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','196','(''SS''=''F'')',@AdhSystemID,'3','D','10','196',NULL,'Basic Life Multiple of Salary Requested Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','197','(''SS''=''F'')',@AdhSystemID,'11','D','10','197',NULL,'Basic Life Requested Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','198','(''SS''=''F'')',@AdhSystemID,'5','D','10','198',NULL,'Employee Group ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','199','(''SS''=''F'')',@AdhSystemID,'3','D','10','199',NULL,'Employee Class Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"~BAD~"','200','(''DA''=''F'')',@AdhSystemID,'5','D','10','200',NULL,'Section Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','201','(''SS''=''F'')',@AdhSystemID,'8','D','10','201',NULL,'Coverage Effective Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','202','(''SS''=''F'')',@AdhSystemID,'8','D','10','202',NULL,'Coverage Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','203','(''SS''=''F'')',@AdhSystemID,'10','D','10','203',NULL,'Coverage Termination Reason Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','204','(''SS''=''F'')',@AdhSystemID,'35','D','10','204',NULL,'Coverage Termination Description',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','205','(''SS''=''F'')',@AdhSystemID,'11','D','10','205',NULL,'Basic AD&D Face Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','206','(''SS''=''F'')',@AdhSystemID,'11','D','10','206',NULL,'Basic AD&D Requested Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','207','(''SS''=''F'')',@AdhSystemID,'5','D','10','207',NULL,'Employee Group ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','208','(''SS''=''F'')',@AdhSystemID,'3','D','10','208',NULL,'Employee Class Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"~LIF~"','209','(''DA''=''F'')',@AdhSystemID,'5','D','10','209',NULL,'Section Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','210','(''SS''=''F'')',@AdhSystemID,'8','D','10','210',NULL,'Coverage Effective Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','211','(''SS''=''F'')',@AdhSystemID,'8','D','10','211',NULL,'Coverage Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','212','(''SS''=''F'')',@AdhSystemID,'10','D','10','212',NULL,'Coverage Termination Reason Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','213','(''SS''=''F'')',@AdhSystemID,'35','D','10','213',NULL,'Coverage Termination Description',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','214','(''SS''=''F'')',@AdhSystemID,'3','D','10','214',NULL,'Supplemental Life Multiple of Salary Face Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','215','(''SS''=''F'')',@AdhSystemID,'11','D','10','215',NULL,'Supplemental Life Face Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','216','(''SS''=''F'')',@AdhSystemID,'3','D','10','216',NULL,'Supplemental Life  Multiple of Salary Requested Am',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','217','(''SS''=''F'')',@AdhSystemID,'11','D','10','217',NULL,'Supplemental Life Requested Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','218','(''SS''=''F'')',@AdhSystemID,'5','D','10','218',NULL,'Employee Group ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','219','(''SS''=''F'')',@AdhSystemID,'3','D','10','219',NULL,'Employee Class Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"~ADD~"','220','(''DA''=''F'')',@AdhSystemID,'5','D','10','220',NULL,'Section Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','221','(''SS''=''F'')',@AdhSystemID,'8','D','10','221',NULL,'Coverage Effective Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','222','(''SS''=''F'')',@AdhSystemID,'8','D','10','222',NULL,'Coverage Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','223','(''SS''=''F'')',@AdhSystemID,'10','D','10','223',NULL,'Coverage Termination Reason Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','224','(''SS''=''F'')',@AdhSystemID,'35','D','10','224',NULL,'Coverage Termination Description',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','225','(''SS''=''F'')',@AdhSystemID,'3','D','10','225',NULL,'Supplemental AD&D Multiple of Salary Face Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','226','(''SS''=''F'')',@AdhSystemID,'11','D','10','226',NULL,'Supplemental AD&D Face Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','227','(''SS''=''F'')',@AdhSystemID,'3','D','10','227',NULL,'Supplemental AD&D Multiple of Salary Requested Amo',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','228','(''SS''=''F'')',@AdhSystemID,'11','D','10','228',NULL,'Supplemental AD&D Requested Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','229','(''SS''=''F'')',@AdhSystemID,'5','D','10','229',NULL,'Employee Group ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','230','(''SS''=''F'')',@AdhSystemID,'3','D','10','230',NULL,'Employee Class Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"~BSD~"','231','(''DA''=''F'')',@AdhSystemID,'5','D','10','231',NULL,'Section Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','232','(''SS''=''F'')',@AdhSystemID,'8','D','10','232',NULL,'Coverage Effective Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','233','(''SS''=''F'')',@AdhSystemID,'8','D','10','233',NULL,'Coverage Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','234','(''SS''=''F'')',@AdhSystemID,'10','D','10','234',NULL,'Coverage Termination Reason Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','235','(''SS''=''F'')',@AdhSystemID,'35','D','10','235',NULL,'Coverage Termination Description',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','236','(''SS''=''F'')',@AdhSystemID,'3','D','10','236',NULL,'AD&D Multiple of Salary Face Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','237','(''SS''=''F'')',@AdhSystemID,'11','D','10','237',NULL,'AD&D Face Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','238','(''SS''=''F'')',@AdhSystemID,'3','D','10','238',NULL,'AD&D Multiple of Salary Requested Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','239','(''SS''=''F'')',@AdhSystemID,'11','D','10','239',NULL,'AD&D Requested Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','240','(''SS''=''F'')',@AdhSystemID,'1','D','10','240',NULL,'Coverage Tier',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','241','(''SS''=''F'')',@AdhSystemID,'5','D','10','241',NULL,'Employee Group ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','242','(''SS''=''F'')',@AdhSystemID,'3','D','10','242',NULL,'Employee Class',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"~SSA~"','243','(''DA''=''F'')',@AdhSystemID,'5','D','10','243',NULL,'Section Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','244','(''SS''=''F'')',@AdhSystemID,'8','D','10','244',NULL,'Coverage Effective Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','245','(''SS''=''F'')',@AdhSystemID,'8','D','10','245',NULL,'Coverage Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','246','(''SS''=''F'')',@AdhSystemID,'10','D','10','246',NULL,'Coverage Termination Reason Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','247','(''SS''=''F'')',@AdhSystemID,'35','D','10','247',NULL,'Coverage Termination Description',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','248','(''SS''=''F'')',@AdhSystemID,'3','D','10','248',NULL,'Supplemental AD&D Multiple of Salary Face Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','249','(''SS''=''F'')',@AdhSystemID,'11','D','10','249',NULL,'Supplemental AD&D Face Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','250','(''SS''=''F'')',@AdhSystemID,'3','D','10','250',NULL,'Supplemental AD&D Multiple of Salary Requested Amo',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','251','(''SS''=''F'')',@AdhSystemID,'11','D','10','251',NULL,'Supplemental AD&D Requested Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','252','(''SS''=''F'')',@AdhSystemID,'1','D','10','252',NULL,'Coverage Tier',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','253','(''SS''=''F'')',@AdhSystemID,'5','D','10','253',NULL,'Employee Group ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','254','(''SS''=''F'')',@AdhSystemID,'3','D','10','254',NULL,'Employee Class',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"~BSL~"','255','(''DA''=''F'')',@AdhSystemID,'5','D','10','255',NULL,'Section Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','256','(''SS''=''F'')',@AdhSystemID,'8','D','10','256',NULL,'Coverage Effective Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','257','(''SS''=''F'')',@AdhSystemID,'8','D','10','257',NULL,'Coverage Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','258','(''SS''=''F'')',@AdhSystemID,'10','D','10','258',NULL,'Coverage Termination Reason Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','259','(''SS''=''F'')',@AdhSystemID,'35','D','10','259',NULL,'Coverage Termination Description',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','260','(''SS''=''F'')',@AdhSystemID,'11','D','10','260',NULL,'Spouse Basic Life Face Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','261','(''SS''=''F'')',@AdhSystemID,'11','D','10','261',NULL,'Spouse Basic Life Requested Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','262','(''SS''=''F'')',@AdhSystemID,'5','D','10','262',NULL,'Employee Group ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','263','(''SS''=''F'')',@AdhSystemID,'3','D','10','263',NULL,'Employee Class',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"~SPL~"','264','(''DA''=''F'')',@AdhSystemID,'5','D','10','264',NULL,'Section Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','265','(''SS''=''F'')',@AdhSystemID,'8','D','10','265',NULL,'Coverage Effective Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','266','(''SS''=''F'')',@AdhSystemID,'8','D','10','266',NULL,'Coverage Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','267','(''SS''=''F'')',@AdhSystemID,'10','D','10','267',NULL,'Coverage Termination Reason Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','268','(''SS''=''F'')',@AdhSystemID,'35','D','10','268',NULL,'Coverage Termination Description',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','269','(''SS''=''F'')',@AdhSystemID,'11','D','10','269',NULL,'Spouse Supplemental Life Face Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','270','(''SS''=''F'')',@AdhSystemID,'11','D','10','270',NULL,'Spouse Supplemental Life Requested Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','271','(''SS''=''F'')',@AdhSystemID,'5','D','10','271',NULL,'Employee Group ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','272','(''SS''=''F'')',@AdhSystemID,'3','D','10','272',NULL,'Employee Class',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"~BDL~"','273','(''DA''=''F'')',@AdhSystemID,'5','D','10','273',NULL,'Section Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','274','(''SS''=''F'')',@AdhSystemID,'8','D','10','274',NULL,'Coverage Effective Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','275','(''SS''=''F'')',@AdhSystemID,'8','D','10','275',NULL,'Coverage Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','276','(''SS''=''F'')',@AdhSystemID,'10','D','10','276',NULL,'Coverage Termination Reason Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','277','(''SS''=''F'')',@AdhSystemID,'35','D','10','277',NULL,'Coverage Termination Description',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','278','(''SS''=''F'')',@AdhSystemID,'11','D','10','278',NULL,'Dependent/Child Basic Life Face Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','279','(''SS''=''F'')',@AdhSystemID,'11','D','10','279',NULL,'Dependent/Child Basic Life Requested Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','280','(''SS''=''F'')',@AdhSystemID,'5','D','10','280',NULL,'Employee Group ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','281','(''SS''=''F'')',@AdhSystemID,'3','D','10','281',NULL,'Employee Class',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"~DPL~"','282','(''DA''=''F'')',@AdhSystemID,'5','D','10','282',NULL,'Section Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','283','(''SS''=''F'')',@AdhSystemID,'8','D','10','283',NULL,'Coverage Effective Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','284','(''SS''=''F'')',@AdhSystemID,'8','D','10','284',NULL,'Coverage Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','285','(''SS''=''F'')',@AdhSystemID,'10','D','10','285',NULL,'Coverage Termination Reason Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','286','(''SS''=''F'')',@AdhSystemID,'35','D','10','286',NULL,'Coverage Termination Description',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','287','(''SS''=''F'')',@AdhSystemID,'11','D','10','287',NULL,'Dependent/Child Supplemental Life Face Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','288','(''SS''=''F'')',@AdhSystemID,'11','D','10','288',NULL,'Dependent/Child Supplemental Life Requested Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','289','(''SS''=''F'')',@AdhSystemID,'5','D','10','289',NULL,'Employee Group ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','290','(''SS''=''F'')',@AdhSystemID,'3','D','10','290',NULL,'Employee Class',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"~BSA~"','291','(''DA''=''F'')',@AdhSystemID,'5','D','10','291',NULL,'Section Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','292','(''SS''=''F'')',@AdhSystemID,'8','D','10','292',NULL,'Coverage Effective Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','293','(''SS''=''F'')',@AdhSystemID,'8','D','10','293',NULL,'Coverage Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','294','(''SS''=''F'')',@AdhSystemID,'10','D','10','294',NULL,'Coverage Termination Reason Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','295','(''SS''=''F'')',@AdhSystemID,'35','D','10','295',NULL,'Coverage Termination Description',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','296','(''SS''=''F'')',@AdhSystemID,'11','D','10','296',NULL,'Spouse Basic AD&D Face Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','297','(''SS''=''F'')',@AdhSystemID,'11','D','10','297',NULL,'Spouse Basic AD&D Requested Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','298','(''SS''=''F'')',@AdhSystemID,'5','D','10','298',NULL,'Employee Group ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','299','(''SS''=''F'')',@AdhSystemID,'3','D','10','299',NULL,'Employee Class',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"~SAD~"','300','(''DA''=''F'')',@AdhSystemID,'5','D','10','300',NULL,'Section Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','301','(''SS''=''F'')',@AdhSystemID,'8','D','10','301',NULL,'Coverage Effective Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','302','(''SS''=''F'')',@AdhSystemID,'8','D','10','302',NULL,'Coverage Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','303','(''SS''=''F'')',@AdhSystemID,'10','D','10','303',NULL,'Coverage Termination Reason Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','304','(''SS''=''F'')',@AdhSystemID,'35','D','10','304',NULL,'Coverage Termination Description',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','305','(''SS''=''F'')',@AdhSystemID,'11','D','10','305',NULL,'Spouse Supplemental AD&D Face Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','306','(''SS''=''F'')',@AdhSystemID,'11','D','10','306',NULL,'Spouse Supplemental AD&D Requested Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','307','(''SS''=''F'')',@AdhSystemID,'5','D','10','307',NULL,'Employee Group ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','308','(''SS''=''F'')',@AdhSystemID,'3','D','10','308',NULL,'Employee Class',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"~BDA~"','309','(''DA''=''F'')',@AdhSystemID,'5','D','10','309',NULL,'Section Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','310','(''SS''=''F'')',@AdhSystemID,'8','D','10','310',NULL,'Coverage Effective Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','311','(''SS''=''F'')',@AdhSystemID,'8','D','10','311',NULL,'Coverage Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','312','(''SS''=''F'')',@AdhSystemID,'10','D','10','312',NULL,'Coverage Termination Reason Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','313','(''SS''=''F'')',@AdhSystemID,'35','D','10','313',NULL,'Coverage Termination Description',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','314','(''SS''=''F'')',@AdhSystemID,'11','D','10','314',NULL,'Dependent/Child Basic AD&D Face Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','315','(''SS''=''F'')',@AdhSystemID,'11','D','10','315',NULL,'Dependent/Child Basic AD&D Requested Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','316','(''SS''=''F'')',@AdhSystemID,'5','D','10','316',NULL,'Employee Group ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','317','(''SS''=''F'')',@AdhSystemID,'3','D','10','317',NULL,'Employee Class',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"~DCA~"','318','(''DA''=''F'')',@AdhSystemID,'5','D','10','318',NULL,'Section Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','319','(''SS''=''F'')',@AdhSystemID,'8','D','10','319',NULL,'Coverage Effective Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','320','(''SS''=''F'')',@AdhSystemID,'8','D','10','320',NULL,'Coverage Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','321','(''SS''=''F'')',@AdhSystemID,'10','D','10','321',NULL,'Coverage Termination Reason Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','322','(''SS''=''F'')',@AdhSystemID,'35','D','10','322',NULL,'Coverage Termination Description',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','323','(''SS''=''F'')',@AdhSystemID,'11','D','10','323',NULL,'Dependent/Child Supplemental AD&D Face Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','324','(''SS''=''F'')',@AdhSystemID,'11','D','10','324',NULL,'Dependent/Child Supplemental AD&D Requested Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','325','(''SS''=''F'')',@AdhSystemID,'5','D','10','325',NULL,'Employee Group ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','326','(''SS''=''F'')',@AdhSystemID,'3','D','10','326',NULL,'Employee Class',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"~VCI~"','327','(''DA''=''F'')',@AdhSystemID,'5','D','10','327',NULL,'Section Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','328','(''SS''=''F'')',@AdhSystemID,'8','D','10','328',NULL,'Coverage Effective Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','329','(''SS''=''F'')',@AdhSystemID,'8','D','10','329',NULL,'Coverage Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','330','(''SS''=''F'')',@AdhSystemID,'10','D','10','330',NULL,'Coverage Termination Reason Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','331','(''SS''=''F'')',@AdhSystemID,'35','D','10','331',NULL,'Coverage Termination Description',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','332','(''SS''=''F'')',@AdhSystemID,'11','D','10','332',NULL,'CI Benefit Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','333','(''SS''=''F'')',@AdhSystemID,'1','D','10','333',NULL,'Coverage Tier',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','334','(''SS''=''F'')',@AdhSystemID,'3','D','10','334',NULL,'Plan Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','335','(''SS''=''F'')',@AdhSystemID,'5','D','10','335',NULL,'Employee Group ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','336','(''SS''=''F'')',@AdhSystemID,'3','D','10','336',NULL,'Employee Class',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"~CIB~"','337','(''DA''=''F'')',@AdhSystemID,'5','D','10','337',NULL,'Section Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','338','(''SS''=''F'')',@AdhSystemID,'8','D','10','338',NULL,'Coverage Effective Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','339','(''SS''=''F'')',@AdhSystemID,'8','D','10','339',NULL,'Coverage Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','340','(''SS''=''F'')',@AdhSystemID,'10','D','10','340',NULL,'Coverage Termination Reason Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','341','(''SS''=''F'')',@AdhSystemID,'35','D','10','341',NULL,'Coverage Termination Description',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','342','(''SS''=''F'')',@AdhSystemID,'11','D','10','342',NULL,'CI Buy-up Benefit Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','343','(''SS''=''F'')',@AdhSystemID,'1','D','10','343',NULL,'Buy-Up Coverage Tier',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','344','(''SS''=''F'')',@AdhSystemID,'3','D','10','344',NULL,'Plan Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','345','(''SS''=''F'')',@AdhSystemID,'5','D','10','345',NULL,'Employee Group ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','346','(''SS''=''F'')',@AdhSystemID,'3','D','10','346',NULL,'Employee Class',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"~VAC~"','347','(''DA''=''F'')',@AdhSystemID,'5','D','10','347',NULL,'Section Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','348','(''SS''=''F'')',@AdhSystemID,'8','D','10','348',NULL,'Coverage Effective Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','349','(''SS''=''F'')',@AdhSystemID,'8','D','10','349',NULL,'Coverage Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','350','(''SS''=''F'')',@AdhSystemID,'10','D','10','350',NULL,'Coverage Termination Reason Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','351','(''SS''=''F'')',@AdhSystemID,'35','D','10','351',NULL,'Coverage Termination Description',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','352','(''SS''=''F'')',@AdhSystemID,'1','D','10','352',NULL,'Coverage Tier',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','353','(''SS''=''F'')',@AdhSystemID,'50','D','10','353',NULL,'Plan Option',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','354','(''SS''=''F'')',@AdhSystemID,'3','D','10','354',NULL,'Plan Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','355','(''SS''=''F'')',@AdhSystemID,'5','D','10','355',NULL,'Employee Group ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','356','(''SS''=''F'')',@AdhSystemID,'3','D','10','356',NULL,'Employee Class',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"~HIP~"','357','(''DA''=''F'')',@AdhSystemID,'5','D','10','357',NULL,'Section Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','358','(''SS''=''F'')',@AdhSystemID,'8','D','10','358',NULL,'Coverage Effective Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','359','(''SS''=''F'')',@AdhSystemID,'8','D','10','359',NULL,'Coverage Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','360','(''SS''=''F'')',@AdhSystemID,'10','D','10','360',NULL,'Coverage Termination Reason Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','361','(''SS''=''F'')',@AdhSystemID,'35','D','10','361',NULL,'Coverage Termination Description',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','362','(''SS''=''F'')',@AdhSystemID,'1','D','10','362',NULL,'Coverage Tier',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','363','(''SS''=''F'')',@AdhSystemID,'50','D','10','363',NULL,'Plan Option',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','364','(''SS''=''F'')',@AdhSystemID,'3','D','10','364',NULL,'Plan Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','365','(''SS''=''F'')',@AdhSystemID,'5','D','10','365',NULL,'Employee Group ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','366','(''SS''=''F'')',@AdhSystemID,'3','D','10','366',NULL,'Employee Class',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"~LMS~"','367','(''DA''=''F'')',@AdhSystemID,'5','D','10','367',NULL,'Section Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Y"','368','(''DA''=''F'')',@AdhSystemID,'1','D','10','368',NULL,'Leave Management Services Indicator',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','369','(''SS''=''F'')',@AdhSystemID,'1','D','10','369',NULL,'Employee Covered by FML 50/75 Rule',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','370','(''SS''=''F'')',@AdhSystemID,'1','D','10','370',NULL,'Key Employee Indicator',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','371','(''SS''=''F'')',@AdhSystemID,'1','D','10','371',NULL,'Forced Eligibility',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','372','(''SS''=''F'')',@AdhSystemID,'5','D','10','372',NULL,'Leave Management Option',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLast12MonthsHours"','373','(''UA''=''F'')',@AdhSystemID,'6','D','10','373',NULL,'Last 12 Months Hours',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','374','(''SS''=''F'')',@AdhSystemID,'6','D','10','374',NULL,'Last 12 Months Paid Hours',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','375','(''SS''=''F'')',@AdhSystemID,'7','D','10','375',NULL,'Actual Hours Worked',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','376','(''SS''=''F'')',@AdhSystemID,'4','D','10','376',NULL,'Usage Time',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','377','(''SS''=''F'')',@AdhSystemID,'4','D','10','377',NULL,'Regulation Period Basis',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCumulativeHoursEndDate"','378','(''UD112''=''F'')',@AdhSystemID,'8','D','10','378',NULL,'Cumulative Hours End Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCumulativeHoursNumOfWeeks"','379','(''UA''=''F'')',@AdhSystemID,'2','D','10','379',NULL,'Cumulative Hours Number of Weeks',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','380','(''SS''=''F'')',@AdhSystemID,'4','D','10','380',NULL,'Sick Leave Hours Remaining',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','381','(''SS''=''F'')',@AdhSystemID,'4','D','10','381',NULL,'Vacation Hours Remaining',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','382','(''SS''=''F'')',@AdhSystemID,'3','D','10','382',NULL,'Work Schedule Type',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','383','(''SS''=''F'')',@AdhSystemID,'8','D','10','383',NULL,'Work Schedule From Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','384','(''SS''=''F'')',@AdhSystemID,'4','D','10','384',NULL,'Work schedule - Hours Monday',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','385','(''SS''=''F'')',@AdhSystemID,'4','D','10','385',NULL,'Work Schedule - Hours Tuesday',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','386','(''SS''=''F'')',@AdhSystemID,'4','D','10','386',NULL,'Work Schedule - Hours Wednesday',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','387','(''SS''=''F'')',@AdhSystemID,'4','D','10','387',NULL,'Work Schedule - Hours Thursday',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','388','(''SS''=''F'')',@AdhSystemID,'4','D','10','388',NULL,'Work Schedule - Hours Friday',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','389','(''SS''=''F'')',@AdhSystemID,'4','D','10','389',NULL,'Work Schedule - Hours Saturday',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','390','(''SS''=''F'')',@AdhSystemID,'4','D','10','390',NULL,'Work Schedule - Hours Sunday',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','391','(''SS''=''F'')',@AdhSystemID,'4','D','10','391',NULL,'Number of Days in Repeating Work Schedule',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','392','(''SS''=''F'')',@AdhSystemID,'4','D','10','392',NULL,'Repeating Schedule - Day 1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','393','(''SS''=''F'')',@AdhSystemID,'4','D','10','393',NULL,'Repeating Schedule - Day 2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','394','(''SS''=''F'')',@AdhSystemID,'4','D','10','394',NULL,'Repeating Schedule - Day 3',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','395','(''SS''=''F'')',@AdhSystemID,'4','D','10','395',NULL,'Repeating Schedule - Day 4',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','396','(''SS''=''F'')',@AdhSystemID,'4','D','10','396',NULL,'Repeating Schedule - Day 5',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','397','(''SS''=''F'')',@AdhSystemID,'4','D','10','397',NULL,'Repeating Schedule - Day 6',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','398','(''SS''=''F'')',@AdhSystemID,'4','D','10','398',NULL,'Repeating Schedule - Day 7',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','399','(''SS''=''F'')',@AdhSystemID,'4','D','10','399',NULL,'Repeating Schedule - Day 8',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','400','(''SS''=''F'')',@AdhSystemID,'4','D','10','400',NULL,'Repeating Schedule - Day 9',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','401','(''SS''=''F'')',@AdhSystemID,'4','D','10','401',NULL,'Repeating Schedule - Day 10',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','402','(''SS''=''F'')',@AdhSystemID,'4','D','10','402',NULL,'Repeating Schedule - Day 11',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','403','(''SS''=''F'')',@AdhSystemID,'4','D','10','403',NULL,'Repeating Schedule - Day 12',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','404','(''SS''=''F'')',@AdhSystemID,'4','D','10','404',NULL,'Repeating Schedule - Day 13',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','405','(''SS''=''F'')',@AdhSystemID,'4','D','10','405',NULL,'Repeating Schedule - Day 14',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','406','(''SS''=''F'')',@AdhSystemID,'4','D','10','406',NULL,'Repeating Schedule - Day 15',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','407','(''SS''=''F'')',@AdhSystemID,'4','D','10','407',NULL,'Repeating Schedule - Day 16',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','408','(''SS''=''F'')',@AdhSystemID,'4','D','10','408',NULL,'Repeating Schedule - Day 17',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','409','(''SS''=''F'')',@AdhSystemID,'4','D','10','409',NULL,'Repeating Schedule - Day 18',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','410','(''SS''=''F'')',@AdhSystemID,'4','D','10','410',NULL,'Repeating Schedule - Day 19',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','411','(''SS''=''F'')',@AdhSystemID,'4','D','10','411',NULL,'Repeating Schedule - Day 20',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','412','(''SS''=''F'')',@AdhSystemID,'4','D','10','412',NULL,'Repeating Schedule - Day 21',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','413','(''SS''=''F'')',@AdhSystemID,'4','D','10','413',NULL,'Repeating Schedule - Day 22',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','414','(''SS''=''F'')',@AdhSystemID,'4','D','10','414',NULL,'Repeating Schedule - Day 23',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','415','(''SS''=''F'')',@AdhSystemID,'4','D','10','415',NULL,'Repeating Schedule - Day 24',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','416','(''SS''=''F'')',@AdhSystemID,'4','D','10','416',NULL,'Repeating Schedule - Day 25',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','417','(''SS''=''F'')',@AdhSystemID,'4','D','10','417',NULL,'Repeating Schedule - Day 26',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','418','(''SS''=''F'')',@AdhSystemID,'4','D','10','418',NULL,'Repeating Schedule - Day 27',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','419','(''SS''=''F'')',@AdhSystemID,'4','D','10','419',NULL,'Repeating Schedule - Day 28',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','420','(''SS''=''F'')',@AdhSystemID,'4','D','10','420',NULL,'Repeating Schedule - Day 29',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','421','(''SS''=''F'')',@AdhSystemID,'4','D','10','421',NULL,'Repeating Schedule - Day 30',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','422','(''SS''=''F'')',@AdhSystemID,'4','D','10','422',NULL,'Repeating Schedule - Day 31',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','423','(''SS''=''F'')',@AdhSystemID,'4','D','10','423',NULL,'Repeating Schedule - Day 32',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','424','(''SS''=''F'')',@AdhSystemID,'4','D','10','424',NULL,'Repeating Schedule - Day 33',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','425','(''SS''=''F'')',@AdhSystemID,'4','D','10','425',NULL,'Repeating Schedule - Day 34',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','426','(''SS''=''F'')',@AdhSystemID,'4','D','10','426',NULL,'Repeating Schedule - Day 35',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','427','(''SS''=''F'')',@AdhSystemID,'4','D','10','427',NULL,'Repeating Schedule - Day 36',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','428','(''SS''=''F'')',@AdhSystemID,'4','D','10','428',NULL,'Repeating Schedule - Day 37',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','429','(''SS''=''F'')',@AdhSystemID,'4','D','10','429',NULL,'Repeating Schedule - Day 38',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','430','(''SS''=''F'')',@AdhSystemID,'4','D','10','430',NULL,'Repeating Schedule - Day 39',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','431','(''SS''=''F'')',@AdhSystemID,'4','D','10','431',NULL,'Repeating Schedule - Day 40',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','432','(''SS''=''F'')',@AdhSystemID,'4','D','10','432',NULL,'Repeating Schedule - Day 41',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','433','(''SS''=''F'')',@AdhSystemID,'4','D','10','433',NULL,'Repeating Schedule - Day 42',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','434','(''SS''=''F'')',@AdhSystemID,'4','D','10','434',NULL,'Repeating Schedule - Day 43',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','435','(''SS''=''F'')',@AdhSystemID,'4','D','10','435',NULL,'Repeating Schedule - Day 44',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','436','(''SS''=''F'')',@AdhSystemID,'4','D','10','436',NULL,'Repeating Schedule - Day 45',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','437','(''SS''=''F'')',@AdhSystemID,'4','D','10','437',NULL,'Repeating Schedule - Day 46',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','438','(''SS''=''F'')',@AdhSystemID,'4','D','10','438',NULL,'Repeating Schedule - Day 47',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','439','(''SS''=''F'')',@AdhSystemID,'4','D','10','439',NULL,'Repeating Schedule - Day 48',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','440','(''SS''=''F'')',@AdhSystemID,'4','D','10','440',NULL,'Repeating Schedule - Day 49',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','441','(''SS''=''F'')',@AdhSystemID,'4','D','10','441',NULL,'Repeating Schedule - Day 50',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','442','(''SS''=''F'')',@AdhSystemID,'4','D','10','442',NULL,'Repeating Schedule - Day 51',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','443','(''SS''=''F'')',@AdhSystemID,'4','D','10','443',NULL,'Repeating Schedule - Day 52',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','444','(''SS''=''F'')',@AdhSystemID,'4','D','10','444',NULL,'Repeating Schedule - Day 53',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','445','(''SS''=''F'')',@AdhSystemID,'4','D','10','445',NULL,'Repeating Schedule - Day 54',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','446','(''SS''=''F'')',@AdhSystemID,'4','D','10','446',NULL,'Repeating Schedule - Day 55',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','447','(''SS''=''F'')',@AdhSystemID,'4','D','10','447',NULL,'Repeating Schedule - Day 56',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','448','(''SS''=''F'')',@AdhSystemID,'4','D','10','448',NULL,'Repeating Schedule - Day 57',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','449','(''SS''=''F'')',@AdhSystemID,'4','D','10','449',NULL,'Repeating Schedule - Day 58',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','450','(''SS''=''F'')',@AdhSystemID,'4','D','10','450',NULL,'Repeating Schedule - Day 59',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','451','(''SS''=''F'')',@AdhSystemID,'4','D','10','451',NULL,'Repeating Schedule - Day 60',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','452','(''SS''=''F'')',@AdhSystemID,'2','D','10','452',NULL,'Flight Crew',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','453','(''SS''=''F'')',@AdhSystemID,'1','D','10','453',NULL,'FMLA Radius',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"~ROL~"','454','(''DA''=''F'')',@AdhSystemID,'5','D','10','454',NULL,'Section Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','455','(''SS''=''F'')',@AdhSystemID,'50','D','10','455',NULL,'Reporting Level 1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','456','(''SS''=''F'')',@AdhSystemID,'50','D','10','456',NULL,'Reporting Level 2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','457','(''SS''=''F'')',@AdhSystemID,'50','D','10','457',NULL,'Reporting Level 3',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','458','(''SS''=''F'')',@AdhSystemID,'50','D','10','458',NULL,'Reporting Level 4',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','459','(''SS''=''F'')',@AdhSystemID,'50','D','10','459',NULL,'Reporting Level 5',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','460','(''SS''=''F'')',@AdhSystemID,'50','D','10','460',NULL,'Reporting Level 6',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','461','(''SS''=''F'')',@AdhSystemID,'50','D','10','461',NULL,'Reporting Level 7',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','462','(''SS''=''F'')',@AdhSystemID,'50','D','10','462',NULL,'Reporting Level 8',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','463','(''SS''=''F'')',@AdhSystemID,'50','D','10','463',NULL,'Reporting Level 9',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','464','(''SS''=''F'')',@AdhSystemID,'50','D','10','464',NULL,'Reporting Level 10',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','465','(''SS''=''F'')',@AdhSystemID,'50','D','10','465',NULL,'Reporting Level 11',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','466','(''SS''=''F'')',@AdhSystemID,'50','D','10','466',NULL,'Reporting Level 12',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"~BEN~"','467','(''DA''=''F'')',@AdhSystemID,'5','D','10','467',NULL,'Section Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','468','(''SS''=''F'')',@AdhSystemID,'30','D','10','468',NULL,'Beneficiary Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','469','(''SS''=''F'')',@AdhSystemID,'30','D','10','469',NULL,'Beneficiary First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','470','(''SS''=''F'')',@AdhSystemID,'9','D','10','470',NULL,'Beneficiary SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','471','(''SS''=''F'')',@AdhSystemID,'60','D','10','471',NULL,'Trust/Charity Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','472','(''SS''=''F'')',@AdhSystemID,'9','D','10','472',NULL,'Tax Identification Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','473','(''SS''=''F'')',@AdhSystemID,'8','D','10','473',NULL,'Beneficiary Date of Birth',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','474','(''SS''=''F'')',@AdhSystemID,'40','D','10','474',NULL,'Beneficiary Address Line 1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','475','(''SS''=''F'')',@AdhSystemID,'40','D','10','475',NULL,'Beneficiary Address Line 2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','476','(''SS''=''F'')',@AdhSystemID,'30','D','10','476',NULL,'Beneficiary City',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','477','(''SS''=''F'')',@AdhSystemID,'2','D','10','477',NULL,'Beneficiary State',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','478','(''SS''=''F'')',@AdhSystemID,'10','D','10','478',NULL,'Beneficiary Zip Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','479','(''SS''=''F'')',@AdhSystemID,'2','D','10','479',NULL,'Beneficiary Relationship',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','480','(''SS''=''F'')',@AdhSystemID,'3','D','10','480',NULL,'Beneficiary Plan Type Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','481','(''SS''=''F'')',@AdhSystemID,'3','D','10','481',NULL,'Beneficiary Percent Allocation',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','482','(''SS''=''F'')',@AdhSystemID,'1','D','10','482',NULL,'Beneficiary Type Primary or Contingent',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','483','(''SS''=''F'')',@AdhSystemID,'8','D','10','483',NULL,'Beneficiary Effective Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','484','(''SS''=''F'')',@AdhSystemID,'30','D','10','484',NULL,'Beneficiary Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','485','(''SS''=''F'')',@AdhSystemID,'30','D','10','485',NULL,'Beneficiary First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','486','(''SS''=''F'')',@AdhSystemID,'9','D','10','486',NULL,'Beneficiary SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','487','(''SS''=''F'')',@AdhSystemID,'60','D','10','487',NULL,'Trust/Charity Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','488','(''SS''=''F'')',@AdhSystemID,'9','D','10','488',NULL,'Tax Identification Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','489','(''SS''=''F'')',@AdhSystemID,'8','D','10','489',NULL,'Beneficiary Date of Birth',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','490','(''SS''=''F'')',@AdhSystemID,'40','D','10','490',NULL,'Beneficiary Address Line 1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','491','(''SS''=''F'')',@AdhSystemID,'40','D','10','491',NULL,'Beneficiary Address Line 2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','492','(''SS''=''F'')',@AdhSystemID,'30','D','10','492',NULL,'Beneficiary City',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','493','(''SS''=''F'')',@AdhSystemID,'2','D','10','493',NULL,'Beneficiary State',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','494','(''SS''=''F'')',@AdhSystemID,'10','D','10','494',NULL,'Beneficiary Zip Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','495','(''SS''=''F'')',@AdhSystemID,'2','D','10','495',NULL,'Beneficiary Relationship',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','496','(''SS''=''F'')',@AdhSystemID,'3','D','10','496',NULL,'Beneficiary Plan Type Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','497','(''SS''=''F'')',@AdhSystemID,'3','D','10','497',NULL,'Beneficiary Percent Allocation',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','498','(''SS''=''F'')',@AdhSystemID,'1','D','10','498',NULL,'Beneficiary Primary or Contingent',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','499','(''SS''=''F'')',@AdhSystemID,'8','D','10','499',NULL,'Beneficiary Effective Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','500','(''SS''=''F'')',@AdhSystemID,'30','D','10','500',NULL,'Beneficiary Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','501','(''SS''=''F'')',@AdhSystemID,'30','D','10','501',NULL,'Beneficiary First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','502','(''SS''=''F'')',@AdhSystemID,'9','D','10','502',NULL,'Beneficiary SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','503','(''SS''=''F'')',@AdhSystemID,'60','D','10','503',NULL,'Trust/Charity Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','504','(''SS''=''F'')',@AdhSystemID,'9','D','10','504',NULL,'Tax Identification Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','505','(''SS''=''F'')',@AdhSystemID,'8','D','10','505',NULL,'Beneficiary Date of Birth',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','506','(''SS''=''F'')',@AdhSystemID,'40','D','10','506',NULL,'Beneficiary Address Line 1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','507','(''SS''=''F'')',@AdhSystemID,'40','D','10','507',NULL,'Beneficiary Address Line 2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','508','(''SS''=''F'')',@AdhSystemID,'30','D','10','508',NULL,'Beneficiary City',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','509','(''SS''=''F'')',@AdhSystemID,'2','D','10','509',NULL,'Beneficiary State',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','510','(''SS''=''F'')',@AdhSystemID,'10','D','10','510',NULL,'Beneficiary Zip Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','511','(''SS''=''F'')',@AdhSystemID,'2','D','10','511',NULL,'Beneficiary Relationship',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','512','(''SS''=''F'')',@AdhSystemID,'3','D','10','512',NULL,'Beneficiary Plan Type Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','513','(''SS''=''F'')',@AdhSystemID,'3','D','10','513',NULL,'Beneficiary Percent Allocation',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','514','(''SS''=''F'')',@AdhSystemID,'1','D','10','514',NULL,'Beneficiary Primary or Contingent',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','515','(''SS''=''F'')',@AdhSystemID,'8','D','10','515',NULL,'Beneficiary Effective Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','516','(''SS''=''F'')',@AdhSystemID,'30','D','10','516',NULL,'Beneficiary Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','517','(''SS''=''F'')',@AdhSystemID,'30','D','10','517',NULL,'Beneficiary First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','518','(''SS''=''F'')',@AdhSystemID,'9','D','10','518',NULL,'Beneficiary SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','519','(''SS''=''F'')',@AdhSystemID,'60','D','10','519',NULL,'Trust/Charity Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','520','(''SS''=''F'')',@AdhSystemID,'9','D','10','520',NULL,'Tax Identification Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','521','(''SS''=''F'')',@AdhSystemID,'8','D','10','521',NULL,'Beneficiary Date of Birth',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','522','(''SS''=''F'')',@AdhSystemID,'40','D','10','522',NULL,'Beneficiary Address Line 1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','523','(''SS''=''F'')',@AdhSystemID,'40','D','10','523',NULL,'Beneficiary Address Line 2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','524','(''SS''=''F'')',@AdhSystemID,'30','D','10','524',NULL,'Beneficiary City',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','525','(''SS''=''F'')',@AdhSystemID,'2','D','10','525',NULL,'Beneficiary State',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','526','(''SS''=''F'')',@AdhSystemID,'10','D','10','526',NULL,'Beneficiary Zip Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','527','(''SS''=''F'')',@AdhSystemID,'2','D','10','527',NULL,'Beneficiary Relationship',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','528','(''SS''=''F'')',@AdhSystemID,'3','D','10','528',NULL,'Beneficiary Plan Type Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','529','(''SS''=''F'')',@AdhSystemID,'3','D','10','529',NULL,'Beneficiary Percent Allocation',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','530','(''SS''=''F'')',@AdhSystemID,'1','D','10','530',NULL,'Beneficiary Primary or Contingent',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','531','(''SS''=''F'')',@AdhSystemID,'8','D','10','531',NULL,'Beneficiary Effective Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','532','(''SS''=''F'')',@AdhSystemID,'30','D','10','532',NULL,'Beneficiary Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','533','(''SS''=''F'')',@AdhSystemID,'30','D','10','533',NULL,'Beneficiary First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','534','(''SS''=''F'')',@AdhSystemID,'9','D','10','534',NULL,'Beneficiary SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','535','(''SS''=''F'')',@AdhSystemID,'60','D','10','535',NULL,'Trust/Charity Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','536','(''SS''=''F'')',@AdhSystemID,'9','D','10','536',NULL,'Tax Identification Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','537','(''SS''=''F'')',@AdhSystemID,'8','D','10','537',NULL,'Beneficiary Date of Birth',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','538','(''SS''=''F'')',@AdhSystemID,'40','D','10','538',NULL,'Beneficiary Address Line 1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','539','(''SS''=''F'')',@AdhSystemID,'40','D','10','539',NULL,'Beneficiary Address Line 2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','540','(''SS''=''F'')',@AdhSystemID,'30','D','10','540',NULL,'Beneficiary City',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','541','(''SS''=''F'')',@AdhSystemID,'2','D','10','541',NULL,'Beneficiary State',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','542','(''SS''=''F'')',@AdhSystemID,'10','D','10','542',NULL,'Beneficiary Zip Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','543','(''SS''=''F'')',@AdhSystemID,'2','D','10','543',NULL,'Beneficiary Relationship',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','544','(''SS''=''F'')',@AdhSystemID,'3','D','10','544',NULL,'Beneficiary Plan Type Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','545','(''SS''=''F'')',@AdhSystemID,'3','D','10','545',NULL,'Beneficiary Percent Allocation',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','546','(''SS''=''F'')',@AdhSystemID,'1','D','10','546',NULL,'Beneficiary Primary or Contingent',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','547','(''SS''=''F'')',@AdhSystemID,'8','D','10','547',NULL,'Beneficiary Effective Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','548','(''SS''=''F'')',@AdhSystemID,'30','D','10','548',NULL,'Beneficiary Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','549','(''SS''=''F'')',@AdhSystemID,'30','D','10','549',NULL,'Beneficiary First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','550','(''SS''=''F'')',@AdhSystemID,'9','D','10','550',NULL,'Beneficiary SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','551','(''SS''=''F'')',@AdhSystemID,'60','D','10','551',NULL,'Trust/Charity Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','552','(''SS''=''F'')',@AdhSystemID,'9','D','10','552',NULL,'Tax Identification Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','553','(''SS''=''F'')',@AdhSystemID,'8','D','10','553',NULL,'Beneficiary Date of Birth',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','554','(''SS''=''F'')',@AdhSystemID,'40','D','10','554',NULL,'Beneficiary Address Line 1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','555','(''SS''=''F'')',@AdhSystemID,'40','D','10','555',NULL,'Beneficiary Address Line 2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','556','(''SS''=''F'')',@AdhSystemID,'30','D','10','556',NULL,'Beneficiary City',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','557','(''SS''=''F'')',@AdhSystemID,'2','D','10','557',NULL,'Beneficiary State',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','558','(''SS''=''F'')',@AdhSystemID,'10','D','10','558',NULL,'Beneficiary Zip Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','559','(''SS''=''F'')',@AdhSystemID,'2','D','10','559',NULL,'Beneficiary Relationship',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','560','(''SS''=''F'')',@AdhSystemID,'3','D','10','560',NULL,'Beneficiary Plan Type Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','561','(''SS''=''F'')',@AdhSystemID,'3','D','10','561',NULL,'Beneficiary Percent Allocation',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','562','(''SS''=''F'')',@AdhSystemID,'1','D','10','562',NULL,'Beneficiary Primary or Contingent',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','563','(''SS''=''F'')',@AdhSystemID,'8','D','10','563',NULL,'Beneficiary Effective Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','564','(''SS''=''F'')',@AdhSystemID,'30','D','10','564',NULL,'Beneficiary Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','565','(''SS''=''F'')',@AdhSystemID,'30','D','10','565',NULL,'Beneficiary First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','566','(''SS''=''F'')',@AdhSystemID,'9','D','10','566',NULL,'Beneficiary SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','567','(''SS''=''F'')',@AdhSystemID,'60','D','10','567',NULL,'Trust/Charity Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','568','(''SS''=''F'')',@AdhSystemID,'9','D','10','568',NULL,'Tax Identification Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','569','(''SS''=''F'')',@AdhSystemID,'8','D','10','569',NULL,'Beneficiary Date of Birth',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','570','(''SS''=''F'')',@AdhSystemID,'40','D','10','570',NULL,'Beneficiary Address Line 1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','571','(''SS''=''F'')',@AdhSystemID,'40','D','10','571',NULL,'Beneficiary Address Line 2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','572','(''SS''=''F'')',@AdhSystemID,'30','D','10','572',NULL,'Beneficiary City',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','573','(''SS''=''F'')',@AdhSystemID,'2','D','10','573',NULL,'Beneficiary State',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','574','(''SS''=''F'')',@AdhSystemID,'10','D','10','574',NULL,'Beneficiary Zip Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','575','(''SS''=''F'')',@AdhSystemID,'2','D','10','575',NULL,'Beneficiary Relationship',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','576','(''SS''=''F'')',@AdhSystemID,'3','D','10','576',NULL,'Beneficiary Plan Type Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','577','(''SS''=''F'')',@AdhSystemID,'3','D','10','577',NULL,'Beneficiary Percent Allocation',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','578','(''SS''=''F'')',@AdhSystemID,'1','D','10','578',NULL,'Beneficiary Primary or Contingent',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','579','(''SS''=''F'')',@AdhSystemID,'8','D','10','579',NULL,'Beneficiary Effective Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','580','(''SS''=''F'')',@AdhSystemID,'30','D','10','580',NULL,'Beneficiary Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','581','(''SS''=''F'')',@AdhSystemID,'30','D','10','581',NULL,'Beneficiary First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','582','(''SS''=''F'')',@AdhSystemID,'9','D','10','582',NULL,'Beneficiary SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','583','(''SS''=''F'')',@AdhSystemID,'60','D','10','583',NULL,'Trust/Charity Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','584','(''SS''=''F'')',@AdhSystemID,'9','D','10','584',NULL,'Tax Identification Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','585','(''SS''=''F'')',@AdhSystemID,'8','D','10','585',NULL,'Beneficiary Date of Birth',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','586','(''SS''=''F'')',@AdhSystemID,'40','D','10','586',NULL,'Beneficiary Address Line 1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','587','(''SS''=''F'')',@AdhSystemID,'40','D','10','587',NULL,'Beneficiary Address Line 2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','588','(''SS''=''F'')',@AdhSystemID,'30','D','10','588',NULL,'Beneficiary City',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','589','(''SS''=''F'')',@AdhSystemID,'2','D','10','589',NULL,'Beneficiary State',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','590','(''SS''=''F'')',@AdhSystemID,'10','D','10','590',NULL,'Beneficiary Zip Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','591','(''SS''=''F'')',@AdhSystemID,'2','D','10','591',NULL,'Beneficiary Relationship',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','592','(''SS''=''F'')',@AdhSystemID,'3','D','10','592',NULL,'Beneficiary Plan Type Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','593','(''SS''=''F'')',@AdhSystemID,'3','D','10','593',NULL,'Beneficiary Percent Allocation',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','594','(''SS''=''F'')',@AdhSystemID,'1','D','10','594',NULL,'Beneficiary Primary or Contingent',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','595','(''SS''=''F'')',@AdhSystemID,'8','D','10','595',NULL,'Beneficiary Effective Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','596','(''SS''=''F'')',@AdhSystemID,'30','D','10','596',NULL,'Beneficiary Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','597','(''SS''=''F'')',@AdhSystemID,'30','D','10','597',NULL,'Beneficiary First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','598','(''SS''=''F'')',@AdhSystemID,'9','D','10','598',NULL,'Beneficiary SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','599','(''SS''=''F'')',@AdhSystemID,'60','D','10','599',NULL,'Trust/Charity Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','600','(''SS''=''F'')',@AdhSystemID,'9','D','10','600',NULL,'Tax Identification Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','601','(''SS''=''F'')',@AdhSystemID,'8','D','10','601',NULL,'Beneficiary Date of Birth',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','1','(''SS''=''F'')',@AdhSystemID,'40','D','20','1',NULL,'Beneficiary Address Line 1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','2','(''SS''=''F'')',@AdhSystemID,'40','D','20','2',NULL,'Beneficiary Address Line 2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','3','(''SS''=''F'')',@AdhSystemID,'30','D','20','3',NULL,'Beneficiary City',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','4','(''SS''=''F'')',@AdhSystemID,'2','D','20','4',NULL,'Beneficiary State',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','5','(''SS''=''F'')',@AdhSystemID,'10','D','20','5',NULL,'Beneficiary Zip Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','6','(''SS''=''F'')',@AdhSystemID,'2','D','20','6',NULL,'Beneficiary Relationship',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','7','(''SS''=''F'')',@AdhSystemID,'3','D','20','7',NULL,'Beneficiary Plan Type Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','8','(''SS''=''F'')',@AdhSystemID,'3','D','20','8',NULL,'Beneficiary Percent Allocation',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','9','(''SS''=''F'')',@AdhSystemID,'1','D','20','9',NULL,'Beneficiary Primary or Contingent',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','10','(''SS''=''F'')',@AdhSystemID,'8','D','20','10',NULL,'Beneficiary Effective Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','11','(''SS''=''F'')',@AdhSystemID,'30','D','20','11',NULL,'Beneficiary Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','12','(''SS''=''F'')',@AdhSystemID,'30','D','20','12',NULL,'Beneficiary First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','13','(''SS''=''F'')',@AdhSystemID,'9','D','20','13',NULL,'Beneficiary SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','14','(''SS''=''F'')',@AdhSystemID,'60','D','20','14',NULL,'Trust/Charity Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','15','(''SS''=''F'')',@AdhSystemID,'9','D','20','15',NULL,'Tax Identification Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','16','(''SS''=''F'')',@AdhSystemID,'8','D','20','16',NULL,'Beneficiary Date of Birth',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','17','(''SS''=''F'')',@AdhSystemID,'40','D','20','17',NULL,'Beneficiary Address Line 1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','18','(''SS''=''F'')',@AdhSystemID,'40','D','20','18',NULL,'Beneficiary Address Line 2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','19','(''SS''=''F'')',@AdhSystemID,'30','D','20','19',NULL,'Beneficiary City',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','20','(''SS''=''F'')',@AdhSystemID,'2','D','20','20',NULL,'Beneficiary State',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','21','(''SS''=''F'')',@AdhSystemID,'10','D','20','21',NULL,'Beneficiary Zip Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','22','(''SS''=''F'')',@AdhSystemID,'2','D','20','22',NULL,'Beneficiary Relationship',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','23','(''SS''=''F'')',@AdhSystemID,'3','D','20','23',NULL,'Beneficiary Plan Type Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','24','(''SS''=''F'')',@AdhSystemID,'3','D','20','24',NULL,'Beneficiary Percent Allocation',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','25','(''SS''=''F'')',@AdhSystemID,'1','D','20','25',NULL,'Beneficiary Primary or Contingent',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','26','(''SS''=''F'')',@AdhSystemID,'8','D','20','26',NULL,'Beneficiary Effective Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','27','(''SS''=''F'')',@AdhSystemID,'30','D','20','27',NULL,'Beneficiary Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','28','(''SS''=''F'')',@AdhSystemID,'30','D','20','28',NULL,'Beneficiary First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','29','(''SS''=''F'')',@AdhSystemID,'9','D','20','29',NULL,'Beneficiary SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','30','(''SS''=''F'')',@AdhSystemID,'60','D','20','30',NULL,'Trust/Charity Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','31','(''SS''=''F'')',@AdhSystemID,'9','D','20','31',NULL,'Tax Identification Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','32','(''SS''=''F'')',@AdhSystemID,'8','D','20','32',NULL,'Beneficiary Date of Birth',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','33','(''SS''=''F'')',@AdhSystemID,'40','D','20','33',NULL,'Beneficiary Address Line 1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','34','(''SS''=''F'')',@AdhSystemID,'40','D','20','34',NULL,'Beneficiary Address Line 2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','35','(''SS''=''F'')',@AdhSystemID,'30','D','20','35',NULL,'Beneficiary City',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','36','(''SS''=''F'')',@AdhSystemID,'2','D','20','36',NULL,'Beneficiary State',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','37','(''SS''=''F'')',@AdhSystemID,'10','D','20','37',NULL,'Beneficiary Zip Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','38','(''SS''=''F'')',@AdhSystemID,'2','D','20','38',NULL,'Beneficiary Relationship',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','39','(''SS''=''F'')',@AdhSystemID,'3','D','20','39',NULL,'Beneficiary Plan Type Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','40','(''SS''=''F'')',@AdhSystemID,'3','D','20','40',NULL,'Beneficiary Percent Allocation',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','41','(''SS''=''F'')',@AdhSystemID,'1','D','20','41',NULL,'Beneficiary Primary or Contingent',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','42','(''SS''=''F'')',@AdhSystemID,'8','D','20','42',NULL,'Beneficiary Effective Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','43','(''SS''=''F'')',@AdhSystemID,'30','D','20','43',NULL,'Beneficiary Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','44','(''SS''=''F'')',@AdhSystemID,'30','D','20','44',NULL,'Beneficiary First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','45','(''SS''=''F'')',@AdhSystemID,'9','D','20','45',NULL,'Beneficiary SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','46','(''SS''=''F'')',@AdhSystemID,'60','D','20','46',NULL,'Trust/Charity Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','47','(''SS''=''F'')',@AdhSystemID,'9','D','20','47',NULL,'Tax Identification Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','48','(''SS''=''F'')',@AdhSystemID,'8','D','20','48',NULL,'Beneficiary Date of Birth',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','49','(''SS''=''F'')',@AdhSystemID,'40','D','20','49',NULL,'Beneficiary Address Line 1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','50','(''SS''=''F'')',@AdhSystemID,'40','D','20','50',NULL,'Beneficiary Address Line 2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','51','(''SS''=''F'')',@AdhSystemID,'30','D','20','51',NULL,'Beneficiary City',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','52','(''SS''=''F'')',@AdhSystemID,'2','D','20','52',NULL,'Beneficiary State',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','53','(''SS''=''F'')',@AdhSystemID,'10','D','20','53',NULL,'Beneficiary Zip Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','54','(''SS''=''F'')',@AdhSystemID,'2','D','20','54',NULL,'Beneficiary Relationship',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','55','(''SS''=''F'')',@AdhSystemID,'3','D','20','55',NULL,'Beneficiary Plan Type Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','56','(''SS''=''F'')',@AdhSystemID,'3','D','20','56',NULL,'Beneficiary Percent Allocation',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','57','(''SS''=''F'')',@AdhSystemID,'1','D','20','57',NULL,'Beneficiary Primary or Contingent',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','58','(''SS''=''F'')',@AdhSystemID,'8','D','20','58',NULL,'Beneficiary Effective Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','59','(''SS''=''F'')',@AdhSystemID,'30','D','20','59',NULL,'Beneficiary Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','60','(''SS''=''F'')',@AdhSystemID,'30','D','20','60',NULL,'Beneficiary First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','61','(''SS''=''F'')',@AdhSystemID,'9','D','20','61',NULL,'Beneficiary SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','62','(''SS''=''F'')',@AdhSystemID,'60','D','20','62',NULL,'Trust/Charity Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','63','(''SS''=''F'')',@AdhSystemID,'9','D','20','63',NULL,'Tax Identification Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','64','(''SS''=''F'')',@AdhSystemID,'8','D','20','64',NULL,'Beneficiary Date of Birth',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','65','(''SS''=''F'')',@AdhSystemID,'40','D','20','65',NULL,'Beneficiary Address Line 1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','66','(''SS''=''F'')',@AdhSystemID,'40','D','20','66',NULL,'Beneficiary Address Line 2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','67','(''SS''=''F'')',@AdhSystemID,'30','D','20','67',NULL,'Beneficiary City',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','68','(''SS''=''F'')',@AdhSystemID,'2','D','20','68',NULL,'Beneficiary State',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','69','(''SS''=''F'')',@AdhSystemID,'10','D','20','69',NULL,'Beneficiary Zip Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','70','(''SS''=''F'')',@AdhSystemID,'2','D','20','70',NULL,'Beneficiary Relationship',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','71','(''SS''=''F'')',@AdhSystemID,'3','D','20','71',NULL,'Beneficiary Plan Type Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','72','(''SS''=''F'')',@AdhSystemID,'3','D','20','72',NULL,'Beneficiary Percent Allocation',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','73','(''SS''=''F'')',@AdhSystemID,'1','D','20','73',NULL,'Beneficiary Primary or Contingent',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','74','(''SS''=''F'')',@AdhSystemID,'8','D','20','74',NULL,'Beneficiary Effective Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','75','(''SS''=''F'')',@AdhSystemID,'30','D','20','75',NULL,'Beneficiary Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','76','(''SS''=''F'')',@AdhSystemID,'30','D','20','76',NULL,'Beneficiary First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','77','(''SS''=''F'')',@AdhSystemID,'9','D','20','77',NULL,'Beneficiary SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','78','(''SS''=''F'')',@AdhSystemID,'60','D','20','78',NULL,'Trust/Charity Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','79','(''SS''=''F'')',@AdhSystemID,'9','D','20','79',NULL,'Tax Identification Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','80','(''SS''=''F'')',@AdhSystemID,'8','D','20','80',NULL,'Beneficiary Date of Birth',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','81','(''SS''=''F'')',@AdhSystemID,'40','D','20','81',NULL,'Beneficiary Address Line 1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','82','(''SS''=''F'')',@AdhSystemID,'40','D','20','82',NULL,'Beneficiary Address Line 2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','83','(''SS''=''F'')',@AdhSystemID,'30','D','20','83',NULL,'Beneficiary City',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','84','(''SS''=''F'')',@AdhSystemID,'2','D','20','84',NULL,'Beneficiary State',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','85','(''SS''=''F'')',@AdhSystemID,'10','D','20','85',NULL,'Beneficiary Zip Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','86','(''SS''=''F'')',@AdhSystemID,'2','D','20','86',NULL,'Beneficiary Relationship',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','87','(''SS''=''F'')',@AdhSystemID,'3','D','20','87',NULL,'Beneficiary Plan Type Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','88','(''SS''=''F'')',@AdhSystemID,'3','D','20','88',NULL,'Beneficiary Percent Allocation',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','89','(''SS''=''F'')',@AdhSystemID,'1','D','20','89',NULL,'Beneficiary Primary or Contingent',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','90','(''SS''=''F'')',@AdhSystemID,'8','D','20','90',NULL,'Beneficiary Effective Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','91','(''SS''=''F'')',@AdhSystemID,'30','D','20','91',NULL,'Beneficiary Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','92','(''SS''=''F'')',@AdhSystemID,'30','D','20','92',NULL,'Beneficiary First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','93','(''SS''=''F'')',@AdhSystemID,'9','D','20','93',NULL,'Beneficiary SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','94','(''SS''=''F'')',@AdhSystemID,'60','D','20','94',NULL,'Trust/Charity Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','95','(''SS''=''F'')',@AdhSystemID,'9','D','20','95',NULL,'Tax Identification Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','96','(''SS''=''F'')',@AdhSystemID,'8','D','20','96',NULL,'Beneficiary Date of Birth',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','97','(''SS''=''F'')',@AdhSystemID,'40','D','20','97',NULL,'Beneficiary Address Line 1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','98','(''SS''=''F'')',@AdhSystemID,'40','D','20','98',NULL,'Beneficiary Address Line 2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','99','(''SS''=''F'')',@AdhSystemID,'30','D','20','99',NULL,'Beneficiary City',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','100','(''SS''=''F'')',@AdhSystemID,'2','D','20','100',NULL,'Beneficiary State',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','101','(''SS''=''F'')',@AdhSystemID,'10','D','20','101',NULL,'Beneficiary Zip Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','102','(''SS''=''F'')',@AdhSystemID,'2','D','20','102',NULL,'Beneficiary Relationship',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','103','(''SS''=''F'')',@AdhSystemID,'3','D','20','103',NULL,'Beneficiary Plan Type Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','104','(''SS''=''F'')',@AdhSystemID,'3','D','20','104',NULL,'Beneficiary Percent Allocation',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','105','(''SS''=''F'')',@AdhSystemID,'1','D','20','105',NULL,'Beneficiary Primary or Contingent',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','106','(''SS''=''F'')',@AdhSystemID,'8','D','20','106',NULL,'Beneficiary Effective Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','107','(''SS''=''F'')',@AdhSystemID,'30','D','20','107',NULL,'Beneficiary Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','108','(''SS''=''F'')',@AdhSystemID,'30','D','20','108',NULL,'Beneficiary First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','109','(''SS''=''F'')',@AdhSystemID,'9','D','20','109',NULL,'Beneficiary SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','110','(''SS''=''F'')',@AdhSystemID,'60','D','20','110',NULL,'Trust/Charity Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','111','(''SS''=''F'')',@AdhSystemID,'9','D','20','111',NULL,'Tax Identification Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','112','(''SS''=''F'')',@AdhSystemID,'8','D','20','112',NULL,'Beneficiary Date of Birth',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','113','(''SS''=''F'')',@AdhSystemID,'40','D','20','113',NULL,'Beneficiary Address Line 1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','114','(''SS''=''F'')',@AdhSystemID,'40','D','20','114',NULL,'Beneficiary Address Line 2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','115','(''SS''=''F'')',@AdhSystemID,'30','D','20','115',NULL,'Beneficiary City',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','116','(''SS''=''F'')',@AdhSystemID,'2','D','20','116',NULL,'Beneficiary State',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','117','(''SS''=''F'')',@AdhSystemID,'10','D','20','117',NULL,'Beneficiary Zip Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','118','(''SS''=''F'')',@AdhSystemID,'2','D','20','118',NULL,'Beneficiary Relationship',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','119','(''SS''=''F'')',@AdhSystemID,'3','D','20','119',NULL,'Beneficiary Plan Type Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','120','(''SS''=''F'')',@AdhSystemID,'3','D','20','120',NULL,'Beneficiary Percent Allocation',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','121','(''SS''=''F'')',@AdhSystemID,'1','D','20','121',NULL,'Beneficiary Primary or Contingent',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','122','(''SS''=''F'')',@AdhSystemID,'8','D','20','122',NULL,'Beneficiary Effective Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','123','(''SS''=''F'')',@AdhSystemID,'30','D','20','123',NULL,'Beneficiary Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','124','(''SS''=''F'')',@AdhSystemID,'30','D','20','124',NULL,'Beneficiary First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','125','(''SS''=''F'')',@AdhSystemID,'9','D','20','125',NULL,'Beneficiary SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','126','(''SS''=''F'')',@AdhSystemID,'60','D','20','126',NULL,'Trust/Charity Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','127','(''SS''=''F'')',@AdhSystemID,'9','D','20','127',NULL,'Tax Identification Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','128','(''SS''=''F'')',@AdhSystemID,'8','D','20','128',NULL,'Beneficiary Date of Birth',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','129','(''SS''=''F'')',@AdhSystemID,'40','D','20','129',NULL,'Beneficiary Address Line 1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','130','(''SS''=''F'')',@AdhSystemID,'40','D','20','130',NULL,'Beneficiary Address Line 2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','131','(''SS''=''F'')',@AdhSystemID,'30','D','20','131',NULL,'Beneficiary City',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','132','(''SS''=''F'')',@AdhSystemID,'2','D','20','132',NULL,'Beneficiary State',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','133','(''SS''=''F'')',@AdhSystemID,'10','D','20','133',NULL,'Beneficiary Zip Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','134','(''SS''=''F'')',@AdhSystemID,'2','D','20','134',NULL,'Beneficiary Relationship',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','135','(''SS''=''F'')',@AdhSystemID,'3','D','20','135',NULL,'Beneficiary Plan Type Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','136','(''SS''=''F'')',@AdhSystemID,'3','D','20','136',NULL,'Beneficiary Percent Allocation',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','137','(''SS''=''F'')',@AdhSystemID,'1','D','20','137',NULL,'Beneficiary Primary or Contingent',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','138','(''SS''=''F'')',@AdhSystemID,'8','D','20','138',NULL,'Beneficiary Effective Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','139','(''SS''=''F'')',@AdhSystemID,'30','D','20','139',NULL,'Beneficiary Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','140','(''SS''=''F'')',@AdhSystemID,'30','D','20','140',NULL,'Beneficiary First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','141','(''SS''=''F'')',@AdhSystemID,'9','D','20','141',NULL,'Beneficiary SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','142','(''SS''=''F'')',@AdhSystemID,'60','D','20','142',NULL,'Trust/Charity Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','143','(''SS''=''F'')',@AdhSystemID,'9','D','20','143',NULL,'Tax Identification Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','144','(''SS''=''F'')',@AdhSystemID,'8','D','20','144',NULL,'Beneficiary Date of Birth',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','145','(''SS''=''F'')',@AdhSystemID,'40','D','20','145',NULL,'Beneficiary Address Line 1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','146','(''SS''=''F'')',@AdhSystemID,'40','D','20','146',NULL,'Beneficiary Address Line 2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','147','(''SS''=''F'')',@AdhSystemID,'30','D','20','147',NULL,'Beneficiary City',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','148','(''SS''=''F'')',@AdhSystemID,'2','D','20','148',NULL,'Beneficiary State',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','149','(''SS''=''F'')',@AdhSystemID,'10','D','20','149',NULL,'Beneficiary Zip Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','150','(''SS''=''F'')',@AdhSystemID,'2','D','20','150',NULL,'Beneficiary Relationship',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','151','(''SS''=''F'')',@AdhSystemID,'3','D','20','151',NULL,'Beneficiary Plan Type Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','152','(''SS''=''F'')',@AdhSystemID,'3','D','20','152',NULL,'Beneficiary Percent Allocation',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','153','(''SS''=''F'')',@AdhSystemID,'1','D','20','153',NULL,'Beneficiary Primary or Contingent',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','154','(''SS''=''F'')',@AdhSystemID,'8','D','20','154',NULL,'Beneficiary Effective Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','155','(''SS''=''F'')',@AdhSystemID,'30','D','20','155',NULL,'Beneficiary Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','156','(''SS''=''F'')',@AdhSystemID,'30','D','20','156',NULL,'Beneficiary First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','157','(''SS''=''F'')',@AdhSystemID,'9','D','20','157',NULL,'Beneficiary SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','158','(''SS''=''F'')',@AdhSystemID,'60','D','20','158',NULL,'Trust/Charity Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','159','(''SS''=''F'')',@AdhSystemID,'9','D','20','159',NULL,'Tax Identification Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','160','(''SS''=''F'')',@AdhSystemID,'8','D','20','160',NULL,'Beneficiary Date of Birth',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','161','(''SS''=''F'')',@AdhSystemID,'40','D','20','161',NULL,'Beneficiary Address Line 1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','162','(''SS''=''F'')',@AdhSystemID,'40','D','20','162',NULL,'Beneficiary Address Line 2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','163','(''SS''=''F'')',@AdhSystemID,'30','D','20','163',NULL,'Beneficiary City',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','164','(''SS''=''F'')',@AdhSystemID,'2','D','20','164',NULL,'Beneficiary State',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','165','(''SS''=''F'')',@AdhSystemID,'10','D','20','165',NULL,'Beneficiary Zip Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','166','(''SS''=''F'')',@AdhSystemID,'2','D','20','166',NULL,'Beneficiary Relationship',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','167','(''SS''=''F'')',@AdhSystemID,'3','D','20','167',NULL,'Beneficiary Plan Type Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','168','(''SS''=''F'')',@AdhSystemID,'3','D','20','168',NULL,'Beneficiary Percent Allocation',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','169','(''SS''=''F'')',@AdhSystemID,'1','D','20','169',NULL,'Beneficiary Primary or Contingent',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','170','(''SS''=''F'')',@AdhSystemID,'8','D','20','170',NULL,'Beneficiary Effective Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','171','(''SS''=''F'')',@AdhSystemID,'30','D','20','171',NULL,'Beneficiary Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','172','(''SS''=''F'')',@AdhSystemID,'30','D','20','172',NULL,'Beneficiary First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','173','(''SS''=''F'')',@AdhSystemID,'9','D','20','173',NULL,'Beneficiary SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','174','(''SS''=''F'')',@AdhSystemID,'60','D','20','174',NULL,'Trust/Charity Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','175','(''SS''=''F'')',@AdhSystemID,'9','D','20','175',NULL,'Tax Identification Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','176','(''SS''=''F'')',@AdhSystemID,'8','D','20','176',NULL,'Beneficiary Date of Birth',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','177','(''SS''=''F'')',@AdhSystemID,'40','D','20','177',NULL,'Beneficiary Address Line 1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','178','(''SS''=''F'')',@AdhSystemID,'40','D','20','178',NULL,'Beneficiary Address Line 2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','179','(''SS''=''F'')',@AdhSystemID,'30','D','20','179',NULL,'Beneficiary City',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','180','(''SS''=''F'')',@AdhSystemID,'2','D','20','180',NULL,'Beneficiary State',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','181','(''SS''=''F'')',@AdhSystemID,'10','D','20','181',NULL,'Beneficiary Zip Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','182','(''SS''=''F'')',@AdhSystemID,'2','D','20','182',NULL,'Beneficiary Relationship',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','183','(''SS''=''F'')',@AdhSystemID,'3','D','20','183',NULL,'Beneficiary Plan Type Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','184','(''SS''=''F'')',@AdhSystemID,'3','D','20','184',NULL,'Beneficiary Percent Allocation',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','185','(''SS''=''F'')',@AdhSystemID,'1','D','20','185',NULL,'Beneficiary Primary or Contingent',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','186','(''SS''=''F'')',@AdhSystemID,'8','D','20','186',NULL,'Beneficiary Effective Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"~DED~"','187','(''DA''=''F'')',@AdhSystemID,'5','D','20','187',NULL,'Section Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','188','(''SS''=''F'')',@AdhSystemID,'10','D','20','188',NULL,'Benefit Deduct Type 1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','189','(''SS''=''F'')',@AdhSystemID,'6','D','20','189',NULL,'Benefit Deduct Amt 1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','190','(''SS''=''F'')',@AdhSystemID,'8','D','20','190',NULL,'Benefit Deduct Eff Date 1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','191','(''SS''=''F'')',@AdhSystemID,'8','D','20','191',NULL,'Benefit Deduct End Date1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','192','(''SS''=''F'')',@AdhSystemID,'1','D','20','192',NULL,'Benefit Deduct Pre/Post 1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','193','(''SS''=''F'')',@AdhSystemID,'1','D','20','193',NULL,'Benefit Deduct Basis 1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','194','(''SS''=''F'')',@AdhSystemID,'2','D','20','194',NULL,'Benefit Deduct Order 1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','195','(''SS''=''F'')',@AdhSystemID,'10','D','20','195',NULL,'Benefit Deduct Type 2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','196','(''SS''=''F'')',@AdhSystemID,'6','D','20','196',NULL,'Benefit Deduct Amt 2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','197','(''SS''=''F'')',@AdhSystemID,'8','D','20','197',NULL,'Benefit Deduct Eff Date 2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','198','(''SS''=''F'')',@AdhSystemID,'8','D','20','198',NULL,'Benefit Deduct End Date 2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','199','(''SS''=''F'')',@AdhSystemID,'1','D','20','199',NULL,'Benefit Deduct Pre/Post 2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','200','(''SS''=''F'')',@AdhSystemID,'1','D','20','200',NULL,'Benefit Deduct Basis 2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','201','(''SS''=''F'')',@AdhSystemID,'2','D','20','201',NULL,'Benefit Deduct Order 2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','202','(''SS''=''F'')',@AdhSystemID,'10','D','20','202',NULL,'Benefit Deduct Type 3',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','203','(''SS''=''F'')',@AdhSystemID,'6','D','20','203',NULL,'Benefit Deduct Amt 3',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','204','(''SS''=''F'')',@AdhSystemID,'8','D','20','204',NULL,'Benefit Deduct Eff Date 3',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','205','(''SS''=''F'')',@AdhSystemID,'8','D','20','205',NULL,'Benefit Deduct End Date3',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','206','(''SS''=''F'')',@AdhSystemID,'1','D','20','206',NULL,'Benefit Deduct Pre/Post 3',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','207','(''SS''=''F'')',@AdhSystemID,'1','D','20','207',NULL,'Benefit Deduct Basis 3',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','208','(''SS''=''F'')',@AdhSystemID,'2','D','20','208',NULL,'Benefit Deduct Order 3',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','209','(''SS''=''F'')',@AdhSystemID,'10','D','20','209',NULL,'Benefit Deduct Type 4',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','210','(''SS''=''F'')',@AdhSystemID,'6','D','20','210',NULL,'Benefit Deduct Amt 4',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','211','(''SS''=''F'')',@AdhSystemID,'8','D','20','211',NULL,'Benefit Deduct Eff Date 4',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','212','(''SS''=''F'')',@AdhSystemID,'8','D','20','212',NULL,'Benefit Deduct End Date 4',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','213','(''SS''=''F'')',@AdhSystemID,'1','D','20','213',NULL,'Benefit Deduct Pre/Post 4',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','214','(''SS''=''F'')',@AdhSystemID,'1','D','20','214',NULL,'Benefit Deduct Basis 4',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','215','(''SS''=''F'')',@AdhSystemID,'2','D','20','215',NULL,'Benefit Deduct Order 4',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','216','(''SS''=''F'')',@AdhSystemID,'10','D','20','216',NULL,'Benefit Deduct Type 5',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','217','(''SS''=''F'')',@AdhSystemID,'6','D','20','217',NULL,'Benefit Deduct Amt 5',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','218','(''SS''=''F'')',@AdhSystemID,'8','D','20','218',NULL,'Benefit Deduct Eff Date 5',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','219','(''SS''=''F'')',@AdhSystemID,'8','D','20','219',NULL,'Benefit Deduct End Date 5',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','220','(''SS''=''F'')',@AdhSystemID,'1','D','20','220',NULL,'Benefit Deduct Pre/Post 5',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','221','(''SS''=''F'')',@AdhSystemID,'1','D','20','221',NULL,'Benefit Deduct Basis 5',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','222','(''SS''=''F'')',@AdhSystemID,'2','D','20','222',NULL,'Benefit Deduct Order 5',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','223','(''SS''=''F'')',@AdhSystemID,'10','D','20','223',NULL,'Benefit Deduct Type 6',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','224','(''SS''=''F'')',@AdhSystemID,'6','D','20','224',NULL,'Benefit Deduct Amt 6',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','225','(''SS''=''F'')',@AdhSystemID,'8','D','20','225',NULL,'Benefit Deduct Eff Date 6',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','226','(''SS''=''F'')',@AdhSystemID,'8','D','20','226',NULL,'Benefit Deduct End Date 6',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','227','(''SS''=''F'')',@AdhSystemID,'1','D','20','227',NULL,'Benefit Deduct Pre/Post 6',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','228','(''SS''=''F'')',@AdhSystemID,'1','D','20','228',NULL,'Benefit Deduct Basis 6',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','229','(''SS''=''F'')',@AdhSystemID,'2','D','20','229',NULL,'Benefit Deduct Order 6',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','230','(''SS''=''F'')',@AdhSystemID,'10','D','20','230',NULL,'Benefit Deduct Type 7',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','231','(''SS''=''F'')',@AdhSystemID,'6','D','20','231',NULL,'Benefit Deduct Amt 7',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','232','(''SS''=''F'')',@AdhSystemID,'8','D','20','232',NULL,'Benefit Deduct Eff Date 7',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','233','(''SS''=''F'')',@AdhSystemID,'8','D','20','233',NULL,'Benefit Deduct End Date 7',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','234','(''SS''=''F'')',@AdhSystemID,'1','D','20','234',NULL,'Benefit Deduct Pre/Post 7',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','235','(''SS''=''F'')',@AdhSystemID,'1','D','20','235',NULL,'Benefit Deduct Basis 7',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','236','(''SS''=''F'')',@AdhSystemID,'2','D','20','236',NULL,'Benefit Deduct Order 7',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','237','(''SS''=''F'')',@AdhSystemID,'10','D','20','237',NULL,'Benefit Deduct Type 8',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','238','(''SS''=''F'')',@AdhSystemID,'6','D','20','238',NULL,'Benefit Deduct Amt 8',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','239','(''SS''=''F'')',@AdhSystemID,'8','D','20','239',NULL,'Benefit Deduct Eff Date 8',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','240','(''SS''=''F'')',@AdhSystemID,'8','D','20','240',NULL,'Benefit Deduct End Date 8',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','241','(''SS''=''F'')',@AdhSystemID,'1','D','20','241',NULL,'Benefit Deduct Pre/Post 8',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','242','(''SS''=''F'')',@AdhSystemID,'1','D','20','242',NULL,'Benefit Deduct Basis 8',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','243','(''SS''=''F'')',@AdhSystemID,'2','D','20','243',NULL,'Benefit Deduct Order 8',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','244','(''SS''=''F'')',@AdhSystemID,'10','D','20','244',NULL,'Benefit Deduct Type 9',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','245','(''SS''=''F'')',@AdhSystemID,'6','D','20','245',NULL,'Benefit Deduct Amt 9',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','246','(''SS''=''F'')',@AdhSystemID,'8','D','20','246',NULL,'Benefit Deduct Eff Date 9',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','247','(''SS''=''F'')',@AdhSystemID,'8','D','20','247',NULL,'Benefit Deduct End Date 9',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','248','(''SS''=''F'')',@AdhSystemID,'1','D','20','248',NULL,'Benefit Deduct Pre/Post 9',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','249','(''SS''=''F'')',@AdhSystemID,'1','D','20','249',NULL,'Benefit Deduct Basis 9',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','250','(''SS''=''F'')',@AdhSystemID,'2','D','20','250',NULL,'Benefit Deduct Order 9',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','251','(''SS''=''F'')',@AdhSystemID,'10','D','20','251',NULL,'Benefit Deduct Type 10',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','252','(''SS''=''F'')',@AdhSystemID,'6','D','20','252',NULL,'Benefit Deduct Amt 10',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','253','(''SS''=''F'')',@AdhSystemID,'8','D','20','253',NULL,'Benefit Deduct Eff Date 10',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','254','(''SS''=''F'')',@AdhSystemID,'8','D','20','254',NULL,'Benefit Deduct End Date 10',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','255','(''SS''=''F'')',@AdhSystemID,'1','D','20','255',NULL,'Benefit Deduct Pre/Post 10',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','256','(''SS''=''F'')',@AdhSystemID,'1','D','20','256',NULL,'Benefit Deduct Basis 10',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','257','(''SS''=''F'')',@AdhSystemID,'2','D','20','257',NULL,'Benefit Deduct Order 10',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','258','(''SS''=''F'')',@AdhSystemID,'10','D','20','258',NULL,'Benefit Deduct Type 11',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','259','(''SS''=''F'')',@AdhSystemID,'6','D','20','259',NULL,'Benefit Deduct Amt 11',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','260','(''SS''=''F'')',@AdhSystemID,'8','D','20','260',NULL,'Benefit Deduct Eff Date 11',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','261','(''SS''=''F'')',@AdhSystemID,'8','D','20','261',NULL,'Benefit Deduct End Date 11',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','262','(''SS''=''F'')',@AdhSystemID,'1','D','20','262',NULL,'Benefit Deduct Pre/Post 11',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','263','(''SS''=''F'')',@AdhSystemID,'1','D','20','263',NULL,'Benefit Deduct Basis 11',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','264','(''SS''=''F'')',@AdhSystemID,'2','D','20','264',NULL,'Benefit Deduct Order 11',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','265','(''SS''=''F'')',@AdhSystemID,'10','D','20','265',NULL,'Benefit Deduct Type 12',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','266','(''SS''=''F'')',@AdhSystemID,'6','D','20','266',NULL,'Benefit Deduct Amt 12',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','267','(''SS''=''F'')',@AdhSystemID,'8','D','20','267',NULL,'Benefit Deduct Eff Date 12',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','268','(''SS''=''F'')',@AdhSystemID,'8','D','20','268',NULL,'Benefit Deduct End Date 12',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','269','(''SS''=''F'')',@AdhSystemID,'1','D','20','269',NULL,'Benefit Deduct Pre/Post 12',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','270','(''SS''=''F'')',@AdhSystemID,'1','D','20','270',NULL,'Benefit Deduct Basis 12',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','271','(''SS''=''F'')',@AdhSystemID,'2','D','20','271',NULL,'Benefit Deduct Order 12',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','272','(''SS''=''F'')',@AdhSystemID,'10','D','20','272',NULL,'Benefit Deduct Type 13',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','273','(''SS''=''F'')',@AdhSystemID,'6','D','20','273',NULL,'Benefit Deduct Amt 13',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','274','(''SS''=''F'')',@AdhSystemID,'8','D','20','274',NULL,'Benefit Deduct Eff Date 13',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','275','(''SS''=''F'')',@AdhSystemID,'8','D','20','275',NULL,'Benefit Deduct End Date 13',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','276','(''SS''=''F'')',@AdhSystemID,'1','D','20','276',NULL,'Benefit Deduct Pre/Post 13',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','277','(''SS''=''F'')',@AdhSystemID,'1','D','20','277',NULL,'Benefit Deduct Basis 13',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','278','(''SS''=''F'')',@AdhSystemID,'2','D','20','278',NULL,'Benefit Deduct Order 13',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','279','(''SS''=''F'')',@AdhSystemID,'10','D','20','279',NULL,'Benefit Deduct Type 14',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','280','(''SS''=''F'')',@AdhSystemID,'6','D','20','280',NULL,'Benefit Deduct Amt 14',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','281','(''SS''=''F'')',@AdhSystemID,'8','D','20','281',NULL,'Benefit Deduct Eff Date 14',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','282','(''SS''=''F'')',@AdhSystemID,'8','D','20','282',NULL,'Benefit Deduct End Date 14',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','283','(''SS''=''F'')',@AdhSystemID,'1','D','20','283',NULL,'Benefit Deduct Pre/Post 14',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','284','(''SS''=''F'')',@AdhSystemID,'1','D','20','284',NULL,'Benefit Deduct Basis 14',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','285','(''SS''=''F'')',@AdhSystemID,'2','D','20','285',NULL,'Benefit Deduct Order 14',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','286','(''SS''=''F'')',@AdhSystemID,'10','D','20','286',NULL,'Benefit Deduct Type 15',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','287','(''SS''=''F'')',@AdhSystemID,'6','D','20','287',NULL,'Benefit Deduct Amt 15',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','288','(''SS''=''F'')',@AdhSystemID,'8','D','20','288',NULL,'Benefit Deduct Eff Date 15',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','289','(''SS''=''F'')',@AdhSystemID,'8','D','20','289',NULL,'Benefit Deduct End Date 15',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','290','(''SS''=''F'')',@AdhSystemID,'1','D','20','290',NULL,'Benefit Deduct Pre/Post 15',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','291','(''SS''=''F'')',@AdhSystemID,'1','D','20','291',NULL,'Benefit Deduct Basis 15',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','292','(''SS''=''F'')',@AdhSystemID,'2','D','20','292',NULL,'Benefit Deduct Order 15',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"~FTR~"','1','(''DA''=''F'')',@AdhSystemID,'5','T','90','1',NULL,'Section Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvRecordCount"','2','(''UA''=''F'')',@AdhSystemID,'7','T','90','2',NULL,'Record Count',NULL,NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export',CONVERT(CHAR(8),GETDATE(),112) + '9','EMPEXPORT','OEACTIVE',NULL,'@CustomFormatCode',NULL,NULL,NULL,CONVERT(CHAR(8),GETDATE(),112) + '9',NULL,'Dec 30 1899 12:00AM',CONVERT(CHAR(8),GETDATE(),112) + '1',NULL,'','',CONVERT(CHAR(8),GETDATE(),112) + '1',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session',CONVERT(CHAR(8),GETDATE(),112) + '9','EMPEXPORT','SCHHARTIDM',NULL,'@CustomFormatCode',NULL,NULL,NULL,CONVERT(CHAR(8),GETDATE(),112) + '9',NULL,'Dec 30 1899 12:00AM',CONVERT(CHAR(8),GETDATE(),112) + '1',NULL,'','',CONVERT(CHAR(8),GETDATE(),112) + '1',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export',CONVERT(CHAR(8),GETDATE(),112) + '9','EMPEXPORT','OEPASSIVE',NULL,'@CustomFormatCode',NULL,NULL,NULL,CONVERT(CHAR(8),GETDATE(),112) + '9',NULL,'Dec 30 1899 12:00AM',CONVERT(CHAR(8),GETDATE(),112) + '1',NULL,'','',CONVERT(CHAR(8),GETDATE(),112) + '1',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Test Purposes Only',CONVERT(CHAR(8),GETDATE(),112) + '9','EMPEXPORT','TEST',NULL,'@CustomFormatCode',NULL,NULL,NULL,CONVERT(CHAR(8),GETDATE(),112) + '9',NULL,'Dec 30 1899 12:00AM',CONVERT(CHAR(8),GETDATE(),112) + '1',NULL,'','',CONVERT(CHAR(8),GETDATE(),112) + '1',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'The Hartford Disability Leave',CONVERT(CHAR(8),GETDATE(),112) + '9','EMPEXPORT','ONDEMAND',NULL,'@CustomFormatCode',NULL,NULL,NULL,CONVERT(CHAR(8),GETDATE(),112) + '9',NULL,'Dec 30 1899 12:00AM',CONVERT(CHAR(8),GETDATE(),112) + '1',NULL,'','',CONVERT(CHAR(8),GETDATE(),112) + '1',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','ExportPath','V','@FileExportPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','OverrideCount','V','0');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','TestPath','V','@FileTestPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','UDESPath','V','@FileUDESPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','UseFileName','V','N');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','H01','dbo.U_@CustomFormatCode_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D10','dbo.U_@CustomFormatCode_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D20','dbo.U_@CustomFormatCode_drvTbl',NULL);
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
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(max) NULL
);
IF OBJECT_ID('U_@CustomFormatCode_ISOCountryCodeMapping') IS NULL
CREATE TABLE [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (
    [cCountryCode] varchar(10) NULL,
    [cCountryName] varchar(200) NULL,
    [cISO3166Value] varchar(10) NULL
);
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('AFG','Afghanistan','004');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('ALA','Aland Islands','248');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('ALB','Albania','008');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('DZA','Algeria','012');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('ASM','American Samoa','016');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('AND','Andorra','020');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('AGO','Angola','024');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('AIA','Anguilla','660');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('ATA','Antarctica','010');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('ATG','Antigua and Barbuda','028');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('ARG','Argentina','032');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('ARM','Armenia','051');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('ABW','Aruba','533');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('AUS','Australia','036');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('AUT','Austria','040');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('AZE','Azerbaijan','031');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('BHS','Bahamas','044');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('BHR','Bahrain','048');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('BGD','Bangladesh','050');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('BRB','Barbados','052');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('BLR','Belarus','112');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('BEL','Belgium','056');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('BLZ','Belize','084');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('BEN','Benin','204');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('BMU','Bermuda','060');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('BTN','Bhutan','064');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('BOL','Bolivia','068');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('BES','Bonaire, Sint Eustatius and Saba','535');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('BIH','Bosnia and Herzegovina','070');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('BWA','Botswana','072');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('BVT','Bouvet Island','074');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('BRA','Brazil','076');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('VGB','Virgin Islands (British)','092');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('BRN','Brunei Darussalam','096');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('BGR','Bulgaria','100');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('BFA','Burkina Faso','854');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('BDI','Burundi','108');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('KHM','Cambodia','116');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('CMR','Cameroon','120');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('CAN','Canada','124');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('CPV','Cape Verde','132');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('CYM','Cayman Islands','136');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('CAF','Central African Republic','140');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('TCD','Chad','148');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('CHL','Chile','152');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('CHN','China','156');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('CXR','Christmas Island','162');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('CCK','Cocos (Keeling) Islands','166');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('COL','Colombia','170');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('COM','Comoros','174');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('COG','Congo','178');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('COK','Cook Islands','184');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('CRI','Costa Rica','188');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('CIV','Cote dIvoire','384');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('HRV','Croatia','191');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('CUB','Cuba','192');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('CUW','Curacao','531');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('CYP','Cyprus','196');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('CZE','Czech Republic','203');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('DNK','Denmark','208');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('DJI','Djibouti','262');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('DMA','Dominica','212');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('DOM','Dominican Republic','214');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('ECU','Ecuador','218');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('EGY','Egypt','818');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('SLV','El Salvador','222');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('GNQ','Equatorial Guinea','226');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('ERI','Eritrea','232');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('EST','Estonia','233');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('ETH','Ethiopia','231');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('FRO','Faroe Islands','234');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('FLK','Falkland Islands (Malvinas)','238');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('FJI','Fiji','242');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('FIN','Finland','246');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('FRA','France','250');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('PYF','French Guiana','254');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('GUF','French Polynesia','258');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('ATF','French Southern Territories','260');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('GAB','Gabon','266');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('GMB','Gambia','270');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('GEO','Georgia','268');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('DEU','Germany','276');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('GHA','Ghana','288');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('GIB','Gibraltar','292');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('GRC','Greece','300');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('GRL','Greenland','304');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('GRD','Grenada','308');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('GLP','Guadeloupe','312');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('GUM','Guam','316');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('GTM','Guatemala','320');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('GGY','Guernsey','831');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('GIN','Guinea','324');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('GNB','Guinea-Bissau','624');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('GUY','Guyana','328');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('HTI','Haiti','332');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('HMD','Heard Island and McDonald Islands','334');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('VAT','Holy See (Vatican City State)','336');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('HND','Honduras','340');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('HKG','Hong Kong','344');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('HUN','Hungary','348');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('ISL','Iceland','352');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('IND','India','356');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('IDN','Indonesia','360');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('IRN','Iran (Islamic Republic of)','364');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('IRQ','Iraq','368');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('IRL','Ireland','372');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('IMN','Isle of Man','833');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('ISR','Israel','376');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('ITA','Italy','380');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('JAM','Jamaica','388');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('JPN','Japan','392');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('JER','Jersey','832');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('JOR','Jordan','400');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('KAZ','Kazakhstan','398');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('KEN','Kenya','404');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('KIR','Kiribati','296');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('KWT','Kuwait','414');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('KGZ','Kyrgyzstan','417');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('LAO','Lao Peoples Democratic Republic','418');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('LVA','Latvia','428');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('LBN','Lebanon','422');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('LSO','Lesotho','426');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('LBR','Liberia','430');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('LBY','Libya','434');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('LIE','Liechtenstein','438');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('LTU','Lithuania','440');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('LUX','Luxembourg','442');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('MAC','Macao','446');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('MDG','Madagascar','450');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('MWI','Malawi','454');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('MYS','Malaysia','458');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('MDV','Maldives','462');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('MLI','Mali','466');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('MLT','Malta','470');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('MHL','Marshall Islands','584');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('MTQ','Martinique','474');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('MRT','Mauritania','478');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('MUS','Mauritius','480');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('MYT','Mayotte','175');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('MEX','Mexico','484');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('FSM','Micronesia (Federated States of)','583');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('MCO','Monaco','492');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('MNG','Mongolia','496');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('MNE','Montenegro','499');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('MSR','Montserrat','500');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('MAR','Morocco','504');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('MOZ','Mozambique','508');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('MMR','Myanmar','104');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('NAM','Namibia','516');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('NRU','Nauru','520');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('NPL','Nepal','524');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('NLD','Netherlands','528');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('NCL','New Caledonia','540');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('NZL','New Zealand','554');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('NIC','Nicaragua','558');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('NER','Niger','562');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('NGA','Nigeria','566');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('NIU','Niue','570');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('NFK','Norfolk Island','574');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('MNP','Northern Mariana Islands','580');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('NOR','Norway','578');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('OMN','Oman','512');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('PAK','Pakistan','586');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('PLW','Palau','585');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('PSE','Palestine, State of','275');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('PAN','Panama','591');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('PNG','Papua New Guinea','598');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('PRY','Paraguay','600');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('PER','Peru','604');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('PHL','Philippines','608');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('PCN','Pitcairn','612');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('POL','Poland','616');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('PRT','Portugal','620');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('PRI','Puerto Rico','630');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('QAT','Qatar','634');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('REU','Reunion','638');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('ROU','Romania','642');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('RUS','Russian Federation','643');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('RWA','Rwanda','646');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('BLM','Saint Barthelemy','652');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('SHN','Saint Helena, Ascension and Tristan da Cunha','654');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('KNA','Saint Kitts and Nevis','659');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('LCA','Saint Lucia','662');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('MAF','Saint Martin (French part)','663');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('SPM','Saint Pierre and Miquelon','666');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('VCT','Saint Vincent and the Grenadines','670');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('WSM','Samoa','882');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('SMR','San Marino','674');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('STP','Sao Tome and Principe','678');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('SAU','Saudi Arabia','682');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('SEN','Senegal','686');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('SRB','Serbia','688');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('SYC','Seychelles','690');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('SLE','Sierra Leone','694');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('SGP','Singapore','702');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('SXM','Sint Maarten (Dutch part)','534');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('SVK','Slovakia','703');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('SVN','Slovenia','705');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('SLB','Solomon Islands','090');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('SOM','Somalia','706');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('ZAF','South Africa','710');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('SGS','South Georgia and the South Sandwich Islands','239');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('SSD','South Sudan','728');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('ESP','Spain','724');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('LKA','Sri Lanka','144');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('SDN','Sudan','729');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('SUR','Suriname','740');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('SJM','Svalbard and Jan Mayen','744');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('SWZ','Swaziland','748');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('SWE','Sweden','752');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('CHE','Switzerland','756');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('SYR','Syrian Arab Republic','760');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('TWN','Taiwan, Province of China[a]','158');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('TJK','Tajikistan','762');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('THA','Thailand','764');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('TLS','Timor-Leste','626');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('TGO','Togo','768');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('TKL','Tokelau','772');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('TON','Tonga','776');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('TTO','Trinidad and Tobago','780');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('TUN','Tunisia','788');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('TUR','Turkey','792');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('TKM','Turkmenistan','795');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('TCA','Turks and Caicos Islands','796');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('TUV','Tuvalu','798');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('UGA','Uganda','800');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('UKR','Ukraine','804');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('ARE','United Arab Emirates','784');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('GBR','United Kingdom of Great Britain and Northern Ireland','826');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('USA','United States of America','840');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('VIR','Virgin Islands (U.S.)','850');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('URY','Uruguay','858');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('UMI','United States Minor Outlying Islands','581');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('UZB','Uzbekistan','860');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('VUT','Vanuatu','548');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('VEN','Venezuela','862');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('VNM','Viet Nam','704');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('WLF','Wallis and Futuna','876');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('ESH','Western Sahara','732');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('YEM','Yemen','887');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('ZMB','Zambia','894');
INSERT INTO [dbo].[U_@CustomFormatCode_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('ZWE','Zimbabwe','716');
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_@CustomFormatCode]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: @CustomerName

Created By: @DeveloperName
Business Analyst: @IntegrationAnalystName
Create Date: @CreateDate
Service Request Number: @SRNumber

Purpose: The Hartford Disability and Leave Export (IDM)

NOTE TO SUPPORT: Custom Mapping Table used for ISO 3166 Country Code Translations
    -- Table Name: U_@CustomFormatCode_ISOCountryCodeMapping
    -- Full Insert Statement in Comments Section at Bottom of Code

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = '@CustomFormatCode';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = '@CustomFormatCode' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'TEST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'SCHHARTIDM'; --Scheduled Session Only

EXEC dbo.dsi_BDM_sp_ErrorCheck '@CustomFormatCode';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = '@CustomFormatCode', @AllObjects = 'Y', @IsWeb = 'N'
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
            ,@FileName          VARCHAR(200)
            ,@RunDate           DATETIME
            ,@FileMinCovDate    DATETIME;

    -- Set FormatCode
    SELECT @FormatCode = '@CustomFormatCode';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@RunDate         = GETDATE()
        ,@FileMinCovDate  = '01/01/2020'
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Set @FileName Value
    --==========================================
    SET @FileName = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_@FileNamePrefix_' + CONVERT(VARCHAR(8),@RunDate,112) + '.txt'
                         WHEN @ExportCode = 'TEST' THEN 'Test_@FileNamePrefix_' + CONVERT(VARCHAR(8),@RunDate,112) + '.txt'
                         ELSE '@FileNamePrefix_' + CONVERT(VARCHAR(8),@RunDate,112) + '.txt'
                    END;

    --==========================================
    -- Audit Section
    --==========================================
    IF OBJECT_ID('U_@CustomFormatCode_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_Audit;
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
        ,audTerm = CASE WHEN audFieldName = 'EecEmplStatus' AND ISNULL(audNewValue,'') = 'T' THEN 'Y' ELSE 'N' END
        ,audFMLAChange = CASE WHEN audFieldName = 'EecEEType' AND ISNULL(audOldValue,'') NOT IN ('','EXE') AND ISNULL(audNewValue,'') IN ('EXE') THEN 'Y'
                              ELSE 'N'
                         END
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    INTO dbo.U_@CustomFormatCode_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audTableName = 'EmpComp'
    AND audFieldName IN ('EecEmplStatus','EecEEType','EecDedGroupCode')
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_@CustomFormatCode_Audit ON dbo.U_@CustomFormatCode_Audit (audEEID,audKey2);

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Remove Terminated Employees NOT Found in Audit
    DELETE FROM dbo.U_@CustomFormatCode_EEList
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    WHERE EecEmplStatus = 'T'
    AND NOT EXISTS (SELECT 1 FROM dbo.U_@CustomFormatCode_Audit WHERE audEEID = xEEID AND audKey2 = xCOID AND audTerm = 'Y' AND audRowNo = 1);

    -- Remove Employees where Employment Type NOT In: 'EXE'
    DELETE FROM dbo.U_@CustomFormatCode_EEList
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    WHERE EecEEType IN ('EXE')
    AND NOT EXISTS (SELECT 1 FROM dbo.U_@CustomFormatCode_Audit WHERE audEEID = xEEID AND audKey2 = xCOID AND audFMLAChange = 'Y' AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    IF OBJECT_ID('U_@CustomFormatCode_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_@CustomFormatCode_DedList
    FROM dbo.DedCode WITH (NOLOCK)
    WHERE DedDedType IN ('MED','LTD','STD');

    -- Build Deduction Code List and store in @DedList Variable
    DECLARE @DedList VARCHAR(MAX)
    SELECT @DedList = COALESCE(@DedList+',','') + LTRIM(RTRIM(DedCode))
    FROM dbo.U_@CustomFormatCode_DedList;

    --=================================================
    -- Working Table - PEarHist
    --=================================================
    IF OBJECT_ID('U_@CustomFormatCode_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate          = MAX(PrgPayDate)
        ,PrgPeriodEndDate    = MAX(PrgPeriodEndDate)
        ,PehCurHrs           = SUM(PehCurHrs)
    INTO dbo.U_@CustomFormatCode_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE PehPerControl BETWEEN CONVERT(CHAR(8),DATEADD(MONTH,-12,@RunDate),112) + '1' AND CONVERT(CHAR(8),@RunDate,112) + '9'
    AND PehInclInPensionAccum = 'Y'
    GROUP BY PehEEID
    HAVING SUM(PehCurHrs) > 0.00;

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
    --INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'AllowMultiDedType','Y');
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
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_@CustomFormatCode_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvFMLAEligibility = MAX(CASE WHEN (E.EecEmplStatus = 'A') OR (audTerm = 'Y' OR audFMLAChange = 'Y') THEN 'Y' END)
        ,drvSTDEligibility = MAX(CASE WHEN DedDedType = 'STD' THEN 'Y' END)
        ,drvLTDEligibility = MAX(CASE WHEN DedDedType = 'LTD' THEN 'Y' END)
        -- standard fields above and additional driver fields below
        --START - Section Code= "~PII~"
        ,drvEmployeeSSN = EepSSN
        ,drvEmployeeID = E.EecEmpNo
        ,drvMemberSSNMemberID = EepSSN
        ,drvLastName = EepNameLast
        ,drvFirstName = EepNameFirst
        ,drvMiddleInitial = LEFT(EepNameMiddle,1)
        ,drvNamePrefix = NULLIF(EepNamePrefix,'Z')
        ,drvNameSuffix = NULLIF(EepNameSuffix,'Z')
        ,drvDateofBirth = EepDateOfBirth
        ,drvGender = CASE WHEN EepGender NOT IN ('M','F') THEN 'U'
                          ELSE EepGender
                     END
        --END - Section Code= "~PII~"
        --START - Section Code= "~ECI~"
        ,drvMemberMailingAddress1 = dbo.dsi_fnRemoveChars(',.-"',UPPER(EepAddressLine1))
        ,drvMemberMailingAddress2 = dbo.dsi_fnRemoveChars(',.-"',UPPER(
                                    CASE WHEN EepAddressCountry IN ('CAN','USA') THEN EepAddressLine2
                                         ELSE ISNULL(NULLIF(RTRIM(EepAddressLine2) + SPACE(1),''),'') + ISNULL(LTRIM(RTRIM(EepAddressCity)),'') + SPACE(1) + ISNULL(LTRIM(RTRIM(EepAddressZipCode)),'')
                                    END))
        ,drvMemberMailingAddressCity = CASE WHEN EepAddressCountry IN ('CAN','USA') THEN EepAddressCity
                                            ELSE EepAddressCountry
                                       END
        ,drvMemberMailingAddressState = UPPER(CASE WHEN EepAddressCountry IN ('CAN','USA') THEN EepAddressState END)
        ,drvMemberMailingAddrZipCode = UPPER(CASE WHEN EepAddressCountry IN ('CAN','USA') THEN EepAddressZipCode END)
        ,drvMemberMailingAddrCountry = EA.cISO3166Value
        ,drvMemberMailingAddrProvince = ''
        ,drvEmployeeHomePhone = EepPhoneHomeNumber
        ,drvEmployeeWorkEmailAddress = EepAddressEMail
        ,drvEmployeeWorkStateCode = LocAddressState
        ,drvEmployeeWorkAddressCountry = LA.cISO3166Value
        ,drvEmployeeWorkPhone = E.EecPhoneBusinessNumber
        --END - Section Code= "~ECI~"
        --START - Section Code= "~ERC~"
        ,drvSupervisorID = Supervisor.EecEmpNo
        ,drvHRManagerID = ''
        --END - Section Code= "~ERC~"
        --START - Section Code= "~EMI~"
        ,drvEmployeeStatusCode = CASE WHEN E.EecEmplStatus = 'T' THEN
                                          CASE WHEN E.EecTermReason = '203' THEN 'D'
                                               ELSE 'T'
                                          END
                                      WHEN MAX(audFMLAChange) = 'Y' THEN 'T'
                                 END
        ,drvEmployeeStatusEffDate = CASE WHEN E.EecEmplStatus = 'T' OR E.EecEEType = 'EXE' THEN E.EecEmplStatusStartDate
                                         WHEN MAX(audFMLAChange) = 'Y' THEN @RunDate
                                    END
        ,drvEmployeeServiceDate = E.EecDateofSeniority
        ,drvRehireDate = E.EecDateOfLastHire
        ,drvOriginalHireDate = E.EecDateOfOriginalHire
        ,drvEmploymentType = E.EecFullTimeOrPartTime
        ,drvExemptNonExempt = JbcFLSAType
        ,drvScheduledHoursPerWeek = dbo.dsi_fnPadZero(E.EecScheduledWorkHrs * 100,4,0)
        ,drvBenefitSalaryAmount = dbo.dsi_fnPadZero(E.EecAnnSalary * 100,9,0)
        ,drvSalaryEffectiveDate = dbo.dsi_fnlib_GetAnnSalary_EffDate(xEEID,xCOID,E.EecDateOfLastHire)
        ,drvPayrollBasis = E.EecSalaryOrHourly
        ,drvPayGradeLevel = JbcSalaryGrade
        ,drvJobTitle = LEFT(LTRIM(JbcDesc),25)
        ,drvCompanyCode = CmpCompanyCode
        ,drvUnionIndicator = CASE WHEN NULLIF(NULLIF(E.EecUnionLocal,''),'Z') IS NOT NULL THEN 'Y'
                                  ELSE 'N'
                             END
        ,drvUnionName = CASE WHEN NULLIF(NULLIF(E.EecUnionLocal,''),'Z') IS NOT NULL THEN E.EecUnionLocal
                             ELSE 'NU'
                        END
        --END - Section Code= "~EMI~"
        --START - Section Code= "~CSF~"
        ,drvClientSpecificField1Name = ''
        ,drvClientSpecificField1Value = ''
        ,drvClientSpecificField2Name = ''
        ,drvClientSpecificField2Value = ''
        ,drvClientSpecificField3Name = ''
        ,drvClientSpecificField3Value = ''
        ,drvClientSpecificField4Name = ''
        ,drvClientSpecificField4Value = ''
        ,drvClientSpecificField5Name = ''
        ,drvClientSpecificField5Value = ''
        ,drvClientSpecificField6Name = ''
        ,drvClientSpecificField6Value = ''
        ,drvClientSpecificField7Name = ''
        ,drvClientSpecificField7Value = ''
        ,drvClientSpecificField8Name = ''
        ,drvClientSpecificField8Value = ''
        --END - Section Code= "~CSF~"
        --START - Section Code= "~NST~" (STD Plans)
        ,drvNSTCoverageEffectiveDate = MAX(CASE WHEN DedDedType = 'STD' THEN dbo.dsi_fnGetMinMaxDates('MAX',@FileMinCovDate,EedBenStartDate) END)
        ,drvNSTCoverageTerminationDate = MAX(CASE WHEN DedDedType = 'STD' AND EedBenStopDate IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX',@FileMinCovDate,EedBenStopDate) END)
        ,drvNSTPlanSummary = MAX(CASE WHEN DedDedType = 'STD' THEN '' --INSERT CASE STATEMENT HERE
                             END)
        ,drvNSTEmployeeGroupID = MAX(CASE WHEN DedDedType = 'STD' THEN '' --INSERT CASE STATEMENT HERE
                                 END)
        --END - Section Code= "~NST~" (STD Plans)
        --START - Section Code= "~LTD~"
        ,drvLTDCoverageEffectiveDate = MAX(CASE WHEN DedDedType = 'LTD' THEN dbo.dsi_fnGetMinMaxDates('MAX',@FileMinCovDate,EedBenStartDate) END)
        ,drvLTDCoverageTerminationDate = MAX(CASE WHEN DedDedType = 'LTD' AND EedBenStopDate IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX',@FileMinCovDate,EedBenStopDate) END)
        ,drvLTDPlanSummary = MAX(CASE WHEN DedDedType = 'LTD' THEN '' --INSERT CASE STATEMENT HERE
                             END)
        ,drvLTDEmployeeGroupID = MAX(CASE WHEN DedDedType = 'LTD' THEN '' --INSERT CASE STATEMENT HERE
                                 END)
        --END - Section Code= "~LTD~"
        --START - Section Code= "~RPL~"
        ,drvReportingLevel1 = ''
        ,drvReportingLevel2 = ''
        ,drvReportingLevel3 = ''
        ,drvReportingLevel4 = ''
        ,drvReportingLevel5 = ''
        ,drvReportingLevel6 = ''
        ,drvReportingLevel7 = ''
        ,drvReportingLevel8 = ''
        ,drvReportingLevel9 = ''
        ,drvReportingLevel10 = ''
        ,drvReportingLevel11 = ''
        ,drvReportingLevel12 = ''
        --END - Section Code= "~RPL~"
        ,drvLast12MonthsHours = dbo.dsi_fnPadZero(ISNULL(CONVERT(MONEY,PehCurHrs),0.00) * 100,6,0)
        ,drvCumulativeHoursEndDate = COALESCE(PrgPeriodEndDate,@EndDate)
        ,drvCumulativeHoursNumOfWeeks = CASE WHEN PrgPayDate IS NULL THEN '1'
                                             WHEN E.EecDateOfSeniority < DATEADD(MONTH,-12,@EndDate) THEN '52'
                                             WHEN DATEDIFF(WEEK,E.EecDateOfSeniority,PrgPeriodEndDate) < 1 THEN '1'
                                             ELSE DATEDIFF(WEEK,E.EecDateOfSeniority,PrgPeriodEndDate)
                                        END
    INTO dbo.U_@CustomFormatCode_drvTbl
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp E WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.Company WITH (NOLOCK)
        ON CmpCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    LEFT JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = xEEID 
        AND EedCoID = xCoID
        AND EedFormatCode = @FormatCode 
        AND EedValidForExport = 'Y'
    LEFT JOIN dbo.JobPhyRq WITH (NOLOCK)
        ON JprJobCode = EecJobCode
    LEFT JOIN dbo.U_@CustomFormatCode_ISOCountryCodeMapping EA WITH (NOLOCK)
        ON EA.cCountryCode = EepAddressCountry
    LEFT JOIN dbo.U_@CustomFormatCode_ISOCountryCodeMapping LA WITH (NOLOCK)
        ON LA.cCountryCode = LocAddressCountry
    LEFT JOIN dbo.U_@CustomFormatCode_PEarHist WITH (NOLOCK)
        ON PehEEID = xEEID
    LEFT JOIN dbo.EmpComp Supervisor WITH (NOLOCK)
        ON Supervisor.EecEEID = E.EecSupervisorID
    LEFT JOIN (--Get Audit Data
        SELECT DISTINCT audEEID
            ,audTerm = MAX(audTerm)
            ,audFMLAChange = MAX(audFMLAChange)
        FROM dbo.U_@CustomFormatCode_Audit WITH (NOLOCK)
        GROUP BY audEEID, audKey2
    ) AuditData
        ON audEEID = xEEID
    WHERE (
        --FMLA Eligibility
        ((E.EecEmplStatus <> 'T')
            OR (audTerm = 'Y' OR audFMLAChange = 'Y')
        )

        --STD Eligibility
        OR (DedDedType = 'STD')

        --LTD Eligibility
        OR (DedDedType = 'LTD')
    )
    GROUP BY xEEID,xCoID,EepSSN,E.EecEmpNo,EepNameLast,EepNameFirst,EepNameMiddle,EepNamePrefix,EepNameSuffix,EepDateOfBirth,EepGender
        ,EepAddressLine1,EepAddressLine2,EepAddressCity,EepAddressState,EepAddressZipCode,EepAddressCountry,EA.cISO3166Value,EepPhoneHomeNumber
        ,EepAddressEMail,CmpCompanyCode,LocAddressState,LA.cISO3166Value,E.EecPhoneBusinessNumber,Supervisor.EecEmpNo,E.EecEmplStatus,E.EecTermReason
        ,E.EecEEType,E.EecDateOfTermination,E.EecDateofSeniority,E.EecDateOfLastHire,E.EecDateOfOriginalHire,E.EecFullTimeOrPartTime,JbcFLSAType
        ,E.EecScheduledWorkHrs,E.EecSalaryOrHourly,JbcSalaryGrade,JbcDesc,E.EecUnionLocal,E.EecJobCode,PehCurHrs,E.EecAnnSalary,PrgPeriodEndDate
        ,E.EecDateOfLastHire,PrgPayDate,E.EecEmplStatusStartDate;

    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_Header','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_Header;
    SELECT DISTINCT
         drvDetailCount = COUNT(DISTINCT drvEmployeeSSN)
        ,drvFileName = @FileName
        ,drvRunDate = @RunDate
    INTO dbo.U_@CustomFormatCode_Header
    FROM dbo.U_@CustomFormatCode_drvTbl;

    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_Trailer;
    SELECT DISTINCT
         drvRecordCount = COUNT(*)
    INTO dbo.U_@CustomFormatCode_Trailer
    FROM dbo.U_@CustomFormatCode_drvTbl;

    --===============================================================
    -- Override Record Count - Large File Driver Table Duplicated
    --===============================================================
    DECLARE @RecordCount INT;
    SET @RecordCount = (SELECT COUNT(*) FROM dbo.U_@CustomFormatCode_drvTbl) + 2;

    EXEC dbo.dsi_sp_UpdateConfig @FormatCode, 'OverrideCount','V', @RecordCount;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
        SET ExportFile = @FileName
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vw@CustomFormatCode_Export AS
    SELECT TOP 20000000 Data = D10.Data + ISNULL(D20.Data,'')
    FROM dbo.U_@CustomFormatCode_File (NOLOCK) D10
    LEFT JOIN dbo.U_@CustomFormatCode_File (NOLOCK) D20
        ON D10.InitialSort = D20.InitialSort
        AND D10.SubSort = D20.SubSort
        AND D20.RecordSet = 'D20'
    WHERE D10.RecordSet <> 'D20'
    ORDER BY RIGHT(D10.RecordSet,2), D10.InitialSort, D10.SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE '@CustomFormatCode%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202007011'
       ,expStartPerControl     = '202007011'
       ,expLastEndPerControl   = '202007019'
       ,expEndPerControl       = '202007019'
WHERE expFormatCode = '@CustomFormatCode';

--=================================================
-- Create ISO 3166 Mappings based on Country Name
--=================================================
IF OBJECT_ID('U_@CustomFormatCode_ISOCountryCodeMapping','U') IS NOT NULL
    DROP TABLE dbo.U_@CustomFormatCode_ISOCountryCodeMapping;
CREATE TABLE dbo.U_@CustomFormatCode_ISOCountryCodeMapping (
     cCountryCode VARCHAR(10)
    ,cCountryName VARCHAR(200)
    ,cISO3166Value VARCHAR(10)
);

INSERT INTO dbo.U_@CustomFormatCode_ISOCountryCodeMapping (cCountryCode,cCountryName,cISO3166Value) VALUES
     ('AFG', 'Afghanistan', '004')
    ,('ALA', 'Aland Islands', '248')
    ,('ALB', 'Albania', '008')
    ,('DZA', 'Algeria', '012')
    ,('ASM', 'American Samoa', '016')
    ,('AND', 'Andorra', '020')
    ,('AGO', 'Angola', '024')
    ,('AIA', 'Anguilla', '660')
    ,('ATA', 'Antarctica', '010')
    ,('ATG', 'Antigua and Barbuda', '028')
    ,('ARG', 'Argentina', '032')
    ,('ARM', 'Armenia', '051')
    ,('ABW', 'Aruba', '533')
    ,('AUS', 'Australia', '036')
    ,('AUT', 'Austria', '040')
    ,('AZE', 'Azerbaijan', '031')
    ,('BHS', 'Bahamas', '044')
    ,('BHR', 'Bahrain', '048')
    ,('BGD', 'Bangladesh', '050')
    ,('BRB', 'Barbados', '052')
    ,('BLR', 'Belarus', '112')
    ,('BEL', 'Belgium', '056')
    ,('BLZ', 'Belize', '084')
    ,('BEN', 'Benin', '204')
    ,('BMU', 'Bermuda', '060')
    ,('BTN', 'Bhutan', '064')
    ,('BOL', 'Bolivia', '068')
    ,('BES', 'Bonaire, Sint Eustatius and Saba', '535')
    ,('BIH', 'Bosnia and Herzegovina', '070')
    ,('BWA', 'Botswana', '072')
    ,('BVT', 'Bouvet Island', '074')
    ,('BRA', 'Brazil', '076')
    ,('VGB', 'Virgin Islands (British)', '092')
    ,('BRN', 'Brunei Darussalam', '096')
    ,('BGR', 'Bulgaria', '100')
    ,('BFA', 'Burkina Faso', '854')
    ,('BDI', 'Burundi', '108')
    ,('KHM', 'Cambodia', '116')
    ,('CMR', 'Cameroon', '120')
    ,('CAN', 'Canada', '124')
    ,('CPV', 'Cape Verde', '132')
    ,('CYM', 'Cayman Islands', '136')
    ,('CAF', 'Central African Republic', '140')
    ,('TCD', 'Chad', '148')
    ,('CHL', 'Chile', '152')
    ,('CHN', 'China', '156')
    ,('CXR', 'Christmas Island', '162')
    ,('CCK', 'Cocos (Keeling) Islands', '166')
    ,('COL', 'Colombia', '170')
    ,('COM', 'Comoros', '174')
    ,('COG', 'Congo', '178')
    ,('COK', 'Cook Islands', '184')
    ,('CRI', 'Costa Rica', '188')
    ,('CIV', 'Cote dIvoire', '384')
    ,('HRV', 'Croatia', '191')
    ,('CUB', 'Cuba', '192')
    ,('CUW', 'Curacao', '531')
    ,('CYP', 'Cyprus', '196')
    ,('CZE', 'Czech Republic', '203')
    ,('DNK', 'Denmark', '208')
    ,('DJI', 'Djibouti', '262')
    ,('DMA', 'Dominica', '212')
    ,('DOM', 'Dominican Republic', '214')
    ,('ECU', 'Ecuador', '218')
    ,('EGY', 'Egypt', '818')
    ,('SLV', 'El Salvador', '222')
    ,('GNQ', 'Equatorial Guinea', '226')
    ,('ERI', 'Eritrea', '232')
    ,('EST', 'Estonia', '233')
    ,('ETH', 'Ethiopia', '231')
    ,('FRO', 'Faroe Islands', '234')
    ,('FLK', 'Falkland Islands (Malvinas)', '238')
    ,('FJI', 'Fiji', '242')
    ,('FIN', 'Finland', '246')
    ,('FRA', 'France', '250')
    ,('PYF', 'French Guiana', '254')
    ,('GUF', 'French Polynesia', '258')
    ,('ATF', 'French Southern Territories', '260')
    ,('GAB', 'Gabon', '266')
    ,('GMB', 'Gambia', '270')
    ,('GEO', 'Georgia', '268')
    ,('DEU', 'Germany', '276')
    ,('GHA', 'Ghana', '288')
    ,('GIB', 'Gibraltar', '292')
    ,('GRC', 'Greece', '300')
    ,('GRL', 'Greenland', '304')
    ,('GRD', 'Grenada', '308')
    ,('GLP', 'Guadeloupe', '312')
    ,('GUM', 'Guam', '316')
    ,('GTM', 'Guatemala', '320')
    ,('GGY', 'Guernsey', '831')
    ,('GIN', 'Guinea', '324')
    ,('GNB', 'Guinea-Bissau', '624')
    ,('GUY', 'Guyana', '328')
    ,('HTI', 'Haiti', '332')
    ,('HMD', 'Heard Island and McDonald Islands', '334')
    ,('VAT', 'Holy See (Vatican City State)', '336')
    ,('HND', 'Honduras', '340')
    ,('HKG', 'Hong Kong', '344')
    ,('HUN', 'Hungary', '348')
    ,('ISL', 'Iceland', '352')
    ,('IND', 'India', '356')
    ,('IDN', 'Indonesia', '360')
    ,('IRN', 'Iran (Islamic Republic of)', '364')
    ,('IRQ', 'Iraq', '368')
    ,('IRL', 'Ireland', '372')
    ,('IMN', 'Isle of Man', '833')
    ,('ISR', 'Israel', '376')
    ,('ITA', 'Italy', '380')
    ,('JAM', 'Jamaica', '388')
    ,('JPN', 'Japan', '392')
    ,('JER', 'Jersey', '832')
    ,('JOR', 'Jordan', '400')
    ,('KAZ', 'Kazakhstan', '398')
    ,('KEN', 'Kenya', '404')
    ,('KIR', 'Kiribati', '296')
    ,('KWT', 'Kuwait', '414')
    ,('KGZ', 'Kyrgyzstan', '417')
    ,('LAO', 'Lao Peoples Democratic Republic', '418')
    ,('LVA', 'Latvia', '428')
    ,('LBN', 'Lebanon', '422')
    ,('LSO', 'Lesotho', '426')
    ,('LBR', 'Liberia', '430')
    ,('LBY', 'Libya', '434')
    ,('LIE', 'Liechtenstein', '438')
    ,('LTU', 'Lithuania', '440')
    ,('LUX', 'Luxembourg', '442')
    ,('MAC', 'Macao', '446')
    ,('MDG', 'Madagascar', '450')
    ,('MWI', 'Malawi', '454')
    ,('MYS', 'Malaysia', '458')
    ,('MDV', 'Maldives', '462')
    ,('MLI', 'Mali', '466')
    ,('MLT', 'Malta', '470')
    ,('MHL', 'Marshall Islands', '584')
    ,('MTQ', 'Martinique', '474')
    ,('MRT', 'Mauritania', '478')
    ,('MUS', 'Mauritius', '480')
    ,('MYT', 'Mayotte', '175')
    ,('MEX', 'Mexico', '484')
    ,('FSM', 'Micronesia (Federated States of)', '583')
    ,('MCO', 'Monaco', '492')
    ,('MNG', 'Mongolia', '496')
    ,('MNE', 'Montenegro', '499')
    ,('MSR', 'Montserrat', '500')
    ,('MAR', 'Morocco', '504')
    ,('MOZ', 'Mozambique', '508')
    ,('MMR', 'Myanmar', '104')
    ,('NAM', 'Namibia', '516')
    ,('NRU', 'Nauru', '520')
    ,('NPL', 'Nepal', '524')
    ,('NLD', 'Netherlands', '528')
    ,('NCL', 'New Caledonia', '540')
    ,('NZL', 'New Zealand', '554')
    ,('NIC', 'Nicaragua', '558')
    ,('NER', 'Niger', '562')
    ,('NGA', 'Nigeria', '566')
    ,('NIU', 'Niue', '570')
    ,('NFK', 'Norfolk Island', '574')
    ,('MNP', 'Northern Mariana Islands', '580')
    ,('NOR', 'Norway', '578')
    ,('OMN', 'Oman', '512')
    ,('PAK', 'Pakistan', '586')
    ,('PLW', 'Palau', '585')
    ,('PSE', 'Palestine, State of', '275')
    ,('PAN', 'Panama', '591')
    ,('PNG', 'Papua New Guinea', '598')
    ,('PRY', 'Paraguay', '600')
    ,('PER', 'Peru', '604')
    ,('PHL', 'Philippines', '608')
    ,('PCN', 'Pitcairn', '612')
    ,('POL', 'Poland', '616')
    ,('PRT', 'Portugal', '620')
    ,('PRI', 'Puerto Rico', '630')
    ,('QAT', 'Qatar', '634')
    ,('REU', 'Reunion', '638')
    ,('ROU', 'Romania', '642')
    ,('RUS', 'Russian Federation', '643')
    ,('RWA', 'Rwanda', '646')
    ,('BLM', 'Saint Barthelemy', '652')
    ,('SHN', 'Saint Helena, Ascension and Tristan da Cunha', '654')
    ,('KNA', 'Saint Kitts and Nevis', '659')
    ,('LCA', 'Saint Lucia', '662')
    ,('MAF', 'Saint Martin (French part)', '663')
    ,('SPM', 'Saint Pierre and Miquelon', '666')
    ,('VCT', 'Saint Vincent and the Grenadines', '670')
    ,('WSM', 'Samoa', '882')
    ,('SMR', 'San Marino', '674')
    ,('STP', 'Sao Tome and Principe', '678')
    ,('SAU', 'Saudi Arabia', '682')
    ,('SEN', 'Senegal', '686')
    ,('SRB', 'Serbia', '688')
    ,('SYC', 'Seychelles', '690')
    ,('SLE', 'Sierra Leone', '694')
    ,('SGP', 'Singapore', '702')
    ,('SXM', 'Sint Maarten (Dutch part)', '534')
    ,('SVK', 'Slovakia', '703')
    ,('SVN', 'Slovenia', '705')
    ,('SLB', 'Solomon Islands', '090')
    ,('SOM', 'Somalia', '706')
    ,('ZAF', 'South Africa', '710')
    ,('SGS', 'South Georgia and the South Sandwich Islands', '239')
    ,('SSD', 'South Sudan', '728')
    ,('ESP', 'Spain', '724')
    ,('LKA', 'Sri Lanka', '144')
    ,('SDN', 'Sudan', '729')
    ,('SUR', 'Suriname', '740')
    ,('SJM', 'Svalbard and Jan Mayen', '744')
    ,('SWZ', 'Swaziland', '748')
    ,('SWE', 'Sweden', '752')
    ,('CHE', 'Switzerland', '756')
    ,('SYR', 'Syrian Arab Republic', '760')
    ,('TWN', 'Taiwan, Province of China[a]', '158')
    ,('TJK', 'Tajikistan', '762')
    ,('THA', 'Thailand', '764')
    ,('TLS', 'Timor-Leste', '626')
    ,('TGO', 'Togo', '768')
    ,('TKL', 'Tokelau', '772')
    ,('TON', 'Tonga', '776')
    ,('TTO', 'Trinidad and Tobago', '780')
    ,('TUN', 'Tunisia', '788')
    ,('TUR', 'Turkey', '792')
    ,('TKM', 'Turkmenistan', '795')
    ,('TCA', 'Turks and Caicos Islands', '796')
    ,('TUV', 'Tuvalu', '798')
    ,('UGA', 'Uganda', '800')
    ,('UKR', 'Ukraine', '804')
    ,('ARE', 'United Arab Emirates', '784')
    ,('GBR', 'United Kingdom of Great Britain and Northern Ireland', '826')
    ,('USA', 'United States of America', '840')
    ,('VIR', 'Virgin Islands (U.S.)', '850')
    ,('URY', 'Uruguay', '858')
    ,('UMI', 'United States Minor Outlying Islands', '581')
    ,('UZB', 'Uzbekistan', '860')
    ,('VUT', 'Vanuatu', '548')
    ,('VEN', 'Venezuela', '862')
    ,('VNM', 'Viet Nam', '704')
    ,('WLF', 'Wallis and Futuna', '876')
    ,('ESH', 'Western Sahara', '732')
    ,('YEM', 'Yemen', '887')
    ,('ZMB', 'Zambia', '894')
    ,('ZWE', 'Zimbabwe', '716');

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vw@CustomFormatCode_Export AS
    SELECT TOP 20000000 Data = D10.Data + ISNULL(D20.Data,'')
    FROM dbo.U_@CustomFormatCode_File (NOLOCK) D10
    LEFT JOIN dbo.U_@CustomFormatCode_File (NOLOCK) D20
        ON D10.InitialSort = D20.InitialSort
        AND D10.SubSort = D20.SubSort
        AND D20.RecordSet = 'D20'
    WHERE D10.RecordSet <> 'D20'
    ORDER BY RIGHT(D10.RecordSet,2), D10.InitialSort, D10.SubSort;
GO
CREATE FUNCTION [dbo].[dsi_fnlib_GetAnnSalary_EffDate] (
    @EEID            VARCHAR(12),
    @COID            VARCHAR(5),
    @DefaultDate     DATETIME
)

RETURNS DATETIME
WITH EXECUTE AS CALLER
AS

/************************************************************

Created By: Megan Cummings
Create Date: 11/28/2017

Revision History
----------------
Update By            Date            Desc
XXXX                 XX/XX/16        Added 1234

Purpose: Gets the employee's annual salary effective date, if COID is left blank it will scan all rows for that employee.
         
EXAMPLE:
SELECT EecEEID, EecCOID, EecAnnSalary, dbo.dsi_fnlib_GetAnnSalary_EffDate(EecEEID, EecCOID, EecDateOfLastHire) 
FROM dbo.EmpComp ;


************************************************************/

BEGIN

    -----------
    -- Declare and set variables
    -----------

    DECLARE @EffDate DATETIME;

    SET @EEID = LTRIM(RTRIM(COALESCE(@EEID, '')))
    SET @COID = LTRIM(RTRIM(COALESCE(@COID, '')))

    IF @EEID = '' RETURN NULL;


    -----------
    -- Find Rate Change Eff Date from Job History
    -----------

   SELECT @EffDate = MAX(EjhJobEffDate)
     FROM dbo.EmpHJob 
    WHERE EjhEEID = @EEID 
      AND EjhCOID = CASE WHEN @COID <> '' THEN @COID ELSE EjhCOID END
      AND EjhIsRateChange = 'Y';


    -----------
    -- Default if no date found in range
    -----------

    RETURN COALESCE(@EffDate, @DefaultDate)

END
GO