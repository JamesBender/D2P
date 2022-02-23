SET NOCOUNT ON;
IF OBJECT_ID('U_EHRTSLFEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EHRTSLFEXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EHRTSLFEXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EHRTSLFEXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEHRTSLFEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEHRTSLFEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EHRTSLFEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EHRTSLFEXP];
GO
IF OBJECT_ID('U_EHRTSLFEXP_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EHRTSLFEXP_Trailer];
GO
IF OBJECT_ID('U_EHRTSLFEXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EHRTSLFEXP_PEarHist];
GO
IF OBJECT_ID('U_EHRTSLFEXP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EHRTSLFEXP_PDedHist];
GO
IF OBJECT_ID('U_EHRTSLFEXP_Header') IS NOT NULL DROP TABLE [dbo].[U_EHRTSLFEXP_Header];
GO
IF OBJECT_ID('U_EHRTSLFEXP_File') IS NOT NULL DROP TABLE [dbo].[U_EHRTSLFEXP_File];
GO
IF OBJECT_ID('U_EHRTSLFEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EHRTSLFEXP_EEList];
GO
IF OBJECT_ID('U_EHRTSLFEXP_drvTblPII') IS NOT NULL DROP TABLE [dbo].[U_EHRTSLFEXP_drvTblPII];
GO
IF OBJECT_ID('U_EHRTSLFEXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EHRTSLFEXP_drvTbl];
GO
IF OBJECT_ID('U_EHRTSLFEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EHRTSLFEXP_DedList];
GO
IF OBJECT_ID('U_EHRTSLFEXP_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EHRTSLFEXP_AuditFields];
GO
IF OBJECT_ID('U_EHRTSLFEXP_Audit') IS NOT NULL DROP TABLE [dbo].[U_EHRTSLFEXP_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EHRTSLFEXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EHRTSLFEXP];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EHRTSLFEXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EHRTSLFEXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EHRTSLFEXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EHRTSLFEXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EHRTSLFEXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EHRTSLFEXP','Hartford LTD STD and FMLA Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','46000','S','N','EHRTSLFEXPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"~HDR~"','1','(''DA''=''T|'')','EHRTSLFEXPZ0','50','H','01','1',NULL,'Section code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"1"','2','(''DA''=''T|'')','EHRTSLFEXPZ0','50','H','01','2',NULL,'Customer Count',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFileName"','3','(''UA''=''T|'')','EHRTSLFEXPZ0','50','H','01','3',NULL,'File Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateFileCreated"','4','(''UA''=''T|'')','EHRTSLFEXPZ0','50','H','01','4',NULL,'Date File Created',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustomerName"','5','(''UA''=''T|'')','EHRTSLFEXPZ0','50','H','01','5',NULL,'Customer Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFileVersion"','6','(''UA''=''T|'')','EHRTSLFEXPZ0','50','H','01','6',NULL,'File Version Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"~PII~"','1','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','1',NULL,'Section code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustomerNumber"','2','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','2',NULL,'Customer Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTransactionCode"','3','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','3',NULL,'Transaction Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','4','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','4',NULL,'Employee SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeId"','5','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','5',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','6','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','6',NULL,'Member SSN/Member ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelationshipCode"','7','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','7',NULL,'Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastName"','8','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','8',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstName"','9','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','9',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMiddleName"','10','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','10',NULL,'Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNamePrefix"','11','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','11',NULL,'Name Prefix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','12','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','12',NULL,'Name Suffix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBirthDate"','13','(''UD112''=''T|'')','EHRTSLFEXPZ0','50','D','10','13',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMarialStatus"','14','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','14',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','15','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','15',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','16','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','16',NULL,'Smoker Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"~BNK~"','17','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','17',NULL,'Section Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','18',NULL,'Bank ABA Routing Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','19','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','19',NULL,'Bank Account Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','20','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','20',NULL,'Bank Account Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"~ECI~"','21','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','21',NULL,'Section Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','22','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','22',NULL,'Member Mailing Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','23','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','23',NULL,'Member Mailing Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','24','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','24',NULL,'Member Mailing Address City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','25','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','25',NULL,'Member Mailing Address State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdressZipCode"','26','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','26',NULL,'Member Mailing Address Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountryCode"','27','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','27',NULL,'Member Mailing Address Country Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProvinceCode"','28','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','28',NULL,'Member Mailing Address Province Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProvinceName"','29','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','29',NULL,'Member Mailing Address Province Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpHomePhone"','30','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','30',NULL,'Employee Home Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','31','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','31',NULL,'Employee Cell Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','32','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','32',NULL,'Employee Personal E-mail Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmailAddress"','33','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','33',NULL,'Employee Work E-mail Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkStateCode"','34','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','34',NULL,'Employee Work State Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','35','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','35',NULL,'Employee Work Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','36','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','36',NULL,'Employee Work Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','37','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','37',NULL,'Employee Work Address City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','38','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','38',NULL,'Employee Work Address State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeZipCode"','39','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','39',NULL,'Employee Work Address Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeCountryCode"','40','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','40',NULL,'Employee Work Address Country Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','41','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','41',NULL,'Employee Work Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"~ERC~"','42','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','42',NULL,'Section Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','43','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','43',NULL,'Supervisor Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','44','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','44',NULL,'Supervisor First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSuperVisorId"','45','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','45',NULL,'Supervisor ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','46','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','46',NULL,'Supervisor Work Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','47','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','47',NULL,'Supervisor Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','48','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','48',NULL,'HR Manager Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','49','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','49',NULL,'HR Manager First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','50','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','50',NULL,'HR Manager ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','51','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','51',NULL,'HR Manager Work Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','52','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','52',NULL,'HR Manager Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','53','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','53',NULL,'ER Contact Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','54','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','54',NULL,'ER Contact First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','55','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','55',NULL,'ER ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','56','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','56',NULL,'ER Contact Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"~EMI~"','57','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','57',NULL,'Section Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeStatus"','58','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','58',NULL,'Employee Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeStatusDate"','59','(''UD112''=''T|'')','EHRTSLFEXPZ0','50','D','10','59',NULL,'Employee Status Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeServiceDate"','60','(''UD112''=''T|'')','EHRTSLFEXPZ0','50','D','10','60',NULL,'Employee Service Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeRehireDate"','61','(''UD112''=''T|'')','EHRTSLFEXPZ0','50','D','10','61',NULL,'Rehire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOriginalHireDate"','62','(''UD112''=''T|'')','EHRTSLFEXPZ0','50','D','10','62',NULL,'Original Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationReasonCode"','63','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','63',NULL,'Employee Termination Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationReasonDesc"','64','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','64',NULL,'Employee Termination Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','65','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','65',NULL,'Last Day Worked',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"dvEmploymentType"','66','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','66',NULL,'Employment Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','67','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','67',NULL,'Exempt/Non-Exempt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvScheduledHours"','68','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','68',NULL,'Scheduled Hours Per Week',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitSalaryAmount"','69','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','69',NULL,'Benefit Salary Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryBasis"','70','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','70',NULL,'Salary Basis',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','71','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','71',NULL,'Additional Salary Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','72','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','72',NULL,'Additional Salary/Wage Basis',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryEffectiveDate"','73','(''UD112''=''T|'')','EHRTSLFEXPZ0','50','D','10','73',NULL,'Salary Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','74','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','74',NULL,'Commission Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','75','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','75',NULL,'Bonus',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','76','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','76',NULL,'Payroll Basis',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','77','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','77',NULL,'Pay Grade Level',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','78','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','78',NULL,'Pay Period Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','79','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','79',NULL,'Pay Period Begin Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','80','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','80',NULL,'Pay Period End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobTitle"','81','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','81',NULL,'Job Title',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','82','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','82',NULL,'Job Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','83','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','83',NULL,'Payroll Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','84','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','84',NULL,'Company Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','85','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','85',NULL,'Department Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','86','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','86',NULL,'Division Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','87','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','87',NULL,'Location Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','88','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','88',NULL,'Region Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','89','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','89',NULL,'Account Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','90','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','90',NULL,'Union Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','91','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','91',NULL,'Union Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','92','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','92',NULL,'Medical Carrier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','93','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','93',NULL,'Mental Health Carrier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"~CSF~"','94','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','94',NULL,'Section Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastEightEarning"','95','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','95',NULL,'Client-Specific Field #1 Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastFourWeekPayroll"','96','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','96',NULL,'Client-Specific Field #1 Value',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEHolidaySchedule"','97','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','97',NULL,'Client-Specific Field #2 Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientFiend2Value"','98','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','98',NULL,'Client-Specific Field #2 Value',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BUSINESS UNIT"','99','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','99',NULL,'Client-Specific Field #3 Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOrgLevelDesc1"','100','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','100',NULL,'Client-Specific Field #3 Value',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','101','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','101',NULL,'Client-Specific Field# 4 Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','102','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','102',NULL,'Client-Specific Field #4 Value',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','103','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','103',NULL,'Client-Specific Field #5 Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','104','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','104',NULL,'Client-Specific Field #5 Value',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','105','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','105',NULL,'Client-Specific Field #6 Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','106','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','106',NULL,'Client-Specific Field #6 Value',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','107','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','107',NULL,'Client-Specific Field #7 Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','108','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','108',NULL,'Client-Specific Field #7 Value',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','109','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','109',NULL,'Client-Specific Field #8 Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','110','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','110',NULL,'Client-Specific Field #8 Value',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"~NST~"','111','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','111',NULL,'Section Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNSTEffectiveDate"','112','(''UD112''=''T|'')','EHRTSLFEXPZ0','50','D','10','112',NULL,'Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNSTBenStopDate"','113','(''UD112''=''T|'')','EHRTSLFEXPZ0','50','D','10','113',NULL,'Coverage Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','114','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','114',NULL,'STD Covered Salary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNSTCoveragePlanOption"','115','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','115',NULL,'STD Coverage Plan Option',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','116','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','116',NULL,'STD Requested Coverage Plan Option',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNSTPlanSummary"','117','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','117',NULL,'Plan Summary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNSTEmployeeGroupId"','118','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','118',NULL,'Employee Group ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNSTEmployeeeClassCode"','119','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','119',NULL,'Employee Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"~NSB~"','120','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','120',NULL,'Section Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','121','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','121',NULL,'Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','122','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','122',NULL,'Coverage Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','123','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','123',NULL,'STD Covered Salary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','124','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','124',NULL,'STD Coverage Plan Option',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','125','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','125',NULL,'STD Requested Coverage Plan Option',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','126','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','126',NULL,'Plan Summary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','127','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','127',NULL,'Employee Group ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','128','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','128',NULL,'Employee Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"~STA~"','129','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','129',NULL,'Section Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSTACoverageEffectiveDate"','130','(''UD112''=''T|'')','EHRTSLFEXPZ0','50','D','10','130',NULL,'Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSTACoverageTerminationDate"','131','(''UD112''=''T|'')','EHRTSLFEXPZ0','50','D','10','131',NULL,'Coverage Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSTAPlanCoverageOption"','132','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','132',NULL,'Statutory Coverage Plan Option',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','133','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','133',NULL,'Statutory Requested Coverage Plan Option',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSTAPlanSummary"','134','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','134',NULL,'Plan Summary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSTAEmployeeGroupId"','135','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','135',NULL,'Employee Group ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSTAEmployeeClassCode"','136','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','136',NULL,'Employee Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"~PFL~"','137','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','137',NULL,'Section Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','138','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','138',NULL,'State PFL Enrolled',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','139','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','139',NULL,'Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','140','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','140',NULL,'Coverage Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','141','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','141',NULL,'Plan Summary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','142','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','142',NULL,'Employee Group ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','143','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','143',NULL,'Employee Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"~FLX~"','144','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','144',NULL,'Section Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','145','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','145',NULL,'Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','146','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','146',NULL,'Coverage Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','147','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','147',NULL,'DisabilityFLEX Benefit Commencement Period - Day I',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','148','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','148',NULL,'DisabilityFLEX Benefit Commencement Period - Day S',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','149','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','149',NULL,'DisabilityFLEX Benefit Duration',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','150','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','150',NULL,'DisabilityFLEX Benefit Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','151','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','151',NULL,'Plan Summary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','152','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','152',NULL,'Employee Group ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','153','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','153',NULL,'Employee Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"~LTD~"','154','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','154',NULL,'Section Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLTDCoverageEffectiveDate"','155','(''UD112''=''T|'')','EHRTSLFEXPZ0','50','D','10','155',NULL,'Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLTDCoverageTerminationDate"','156','(''UD112''=''T|'')','EHRTSLFEXPZ0','50','D','10','156',NULL,'Coverage Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','157','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','157',NULL,'Coverage Termination Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','158','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','158',NULL,'Coverage Termination Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','159','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','159',NULL,'LTD Covered Salary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLTDCoveragePlanOption"','160','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','160',NULL,'LTD Coverage Plan Option',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','161','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','161',NULL,'LTD Requested Coverage Plan Option',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLTDPlanSummary"','162','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','162',NULL,'Plan Summary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLTDEmployeeGroupId"','163','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','163',NULL,'Employee Group ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLTDEmployeeClassCode"','164','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','164',NULL,'Employee Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"~LDB~"','165','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','165',NULL,'Section Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','166','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','166',NULL,'Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','167','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','167',NULL,'Coverage Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','168','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','168',NULL,'Coverage Termination Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','169','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','169',NULL,'Coverage Termination Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','170','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','170',NULL,'LTD Covered Salary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','171','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','171',NULL,'LTD Coverage Plan Option',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','172','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','172',NULL,'LTD Requested Coverage Plan Option',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','173','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','173',NULL,'Plan Summary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','174','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','174',NULL,'Employee Group ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','175','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','175',NULL,'Employee Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"~RPL~"','176','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','176',NULL,'Section Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Appriss"','177','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','177',NULL,'Reporting Level 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReportingLevel1"','178','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','178',NULL,'Reporting Level 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','179','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','179',NULL,'Reporting Level 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','180','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','180',NULL,'Reporting Level 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','181','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','181',NULL,'Reporting Level 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','182','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','182',NULL,'Reporting Level 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','183','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','183',NULL,'Reporting Level 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','184','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','184',NULL,'Reporting Level 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','185','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','185',NULL,'Reporting Level 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','186','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','186',NULL,'Reporting Level 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','187','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','187',NULL,'Reporting Level 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','188','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','188',NULL,'Reporting Level 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"~BLF~"','189','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','189',NULL,'Basic Life Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBLFEffectiveDate"','190','(''UD112''=''T|'')','EHRTSLFEXPZ0','50','D','10','190',NULL,'Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvBLFTerminationDate""','191','(''UD112''=''T|'')','EHRTSLFEXPZ0','50','D','10','191',NULL,'Coverage Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','192','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','192',NULL,'Coverage Termination Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','193','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','193',NULL,'Coverage Termination Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','194','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','194',NULL,'Basic Life Multiple of Salary Face Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBLFAmount"','195','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','195',NULL,'Basic Life Face Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','196','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','196',NULL,'Basic Life Multiple of Salary Requested Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','197','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','197',NULL,'Basic Life Requested Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBLFGroupId"','198','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','198',NULL,'Employee Group ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBLFClassCode"','199','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','199',NULL,'Employee Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"~BAD~"','200','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','200',NULL,'Section Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBADEffectiveDate"','201','(''UD112''=''T|'')','EHRTSLFEXPZ0','50','D','10','201',NULL,'Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBADTerminationDate"','202','(''UD112''=''T|'')','EHRTSLFEXPZ0','50','D','10','202',NULL,'Coverage Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','203','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','203',NULL,'Coverage Termination Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','204','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','204',NULL,'Coverage Termination Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBADAmount"','205','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','205',NULL,'Basic AD&D Face Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','206','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','206',NULL,'Basic AD&D Requested Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBADGroupId"','207','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','207',NULL,'Employee Group ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBADClassCode"','208','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','208',NULL,'Employee Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"~LIF~"','209','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','209',NULL,'Section Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLIFEffectiveDate"','210','(''UD112''=''T|'')','EHRTSLFEXPZ0','50','D','10','210',NULL,'Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLIFTerminationDate"','211','(''UD112''=''T|'')','EHRTSLFEXPZ0','50','D','10','211',NULL,'Coverage Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','212','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','212',NULL,'Coverage Termination Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','213','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','213',NULL,'Coverage Termination Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','214','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','214',NULL,'Supplemental Life Multiple of Salary Face Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLIFAmount"','215','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','215',NULL,'Supplemental Life Face Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','216','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','216',NULL,'Supplemental Life  Multiple of Salary Requested Am',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLIFSuppLifeAmt"','217','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','217',NULL,'Supplemental Life Requested Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLIFGroupId"','218','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','218',NULL,'Employee Group ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLIFClassCode"','219','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','219',NULL,'Employee Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"~ADD~"','220','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','220',NULL,'Section Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvADDEffectiveDate"','221','(''UD112''=''T|'')','EHRTSLFEXPZ0','50','D','10','221',NULL,'Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvADDTerminationDate"','222','(''UD112''=''T|'')','EHRTSLFEXPZ0','50','D','10','222',NULL,'Coverage Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','223','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','223',NULL,'Coverage Termination Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','224','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','224',NULL,'Coverage Termination Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','225','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','225',NULL,'Supplemental AD&D Multiple of Salary Face Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvADDAmount"','226','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','226',NULL,'Supplemental AD&D Face Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','227','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','227',NULL,'Supplemental AD&D Multiple of Salary Requested Amo',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddSuppReqAmt"','228','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','228',NULL,'Supplemental AD&D Requested Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvADDGroupId"','229','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','229',NULL,'Employee Group ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvADDClassCode"','230','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','230',NULL,'Employee Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"~BSD~"','231','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','231',NULL,'Section Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','232','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','232',NULL,'Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','233','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','233',NULL,'Coverage Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','234','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','234',NULL,'Coverage Termination Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','235','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','235',NULL,'Coverage Termination Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','236','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','236',NULL,'AD&D Multiple of Salary Face Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','237','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','237',NULL,'AD&D Face Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','238','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','238',NULL,'AD&D Multiple of Salary Requested Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','239','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','239',NULL,'AD&D Requested Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','240','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','240',NULL,'Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','241','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','241',NULL,'Employee Group ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','242','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','242',NULL,'Employee Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"~SSA~"','243','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','243',NULL,'Section Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','244','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','244',NULL,'Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','245','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','245',NULL,'Coverage Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','246','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','246',NULL,'Coverage Termination Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','247','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','247',NULL,'Coverage Termination Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','248','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','248',NULL,'Supplemental AD&D Multiple of Salary Face Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','249','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','249',NULL,'Supplemental AD&D Face Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','250','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','250',NULL,'Supplemental AD&D Multiple of Salary Requested Amo',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','251','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','251',NULL,'Supplemental AD&D Requested Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','252','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','252',NULL,'Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','253','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','253',NULL,'Employee Group ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','254','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','254',NULL,'Employee Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"~BSL~"','255','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','255',NULL,'Section Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','256','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','256',NULL,'Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','257','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','257',NULL,'Coverage Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','258','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','258',NULL,'Coverage Termination Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','259','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','259',NULL,'Coverage Termination Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','260','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','260',NULL,'Spouse Basic Life Face Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','261','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','261',NULL,'Spouse Basic Life Requested Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','262','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','262',NULL,'Employee Group ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','263','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','263',NULL,'Employee Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"~SPL~"','264','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','264',NULL,'Section Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPLEffectiveDate"','265','(''UD112''=''T|'')','EHRTSLFEXPZ0','50','D','10','265',NULL,'Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPLTerminationDate"','266','(''UD112''=''T|'')','EHRTSLFEXPZ0','50','D','10','266',NULL,'Coverage Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','267','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','267',NULL,'Coverage Termination Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','268','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','268',NULL,'Coverage Termination Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPLAmount"','269','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','269',NULL,'Spouse Supplemental Life Face Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPLReqAmount"','270','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','270',NULL,'Spouse Supplemental Life Requested Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPLGroupId"','271','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','271',NULL,'Employee Group ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPLClassCode"','272','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','272',NULL,'Employee Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"~BDL~"','273','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','273',NULL,'Section Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','274','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','274',NULL,'Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','275','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','275',NULL,'Coverage Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','276','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','276',NULL,'Coverage Termination Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','277','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','277',NULL,'Coverage Termination Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','278','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','278',NULL,'Dependent/Child Basic Life Face Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','279','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','279',NULL,'Dependent/Child Basic Life Requested Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','280','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','280',NULL,'Employee Group ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','281','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','281',NULL,'Employee Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"~DPL~"','282','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','282',NULL,'Section Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDPLEffectiveDate"','283','(''UD112''=''T|'')','EHRTSLFEXPZ0','50','D','10','283',NULL,'Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDPLTerminationDate"','284','(''UD112''=''T|'')','EHRTSLFEXPZ0','50','D','10','284',NULL,'Coverage Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','285','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','285',NULL,'Coverage Termination Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','286','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','286',NULL,'Coverage Termination Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDPLAmount"','287','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','287',NULL,'Dependent/Child Supplemental Life Face Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','288','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','288',NULL,'Dependent/Child Supplemental Life Requested Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDPLGroupId"','289','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','289',NULL,'Employee Group ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDPLClassCode"','290','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','290',NULL,'Employee Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"~BSA~"','291','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','291',NULL,'Section Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','292','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','292',NULL,'Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','293','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','293',NULL,'Coverage Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','294','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','294',NULL,'Coverage Termination Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','295','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','295',NULL,'Coverage Termination Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','296','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','296',NULL,'Spouse Basic AD&D Face Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','297','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','297',NULL,'Spouse Basic AD&D Requested Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','298','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','298',NULL,'Employee Group ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','299','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','299',NULL,'Employee Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"~SAD~"','300','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','300',NULL,'Section Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','301','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','301',NULL,'Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','302','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','302',NULL,'Coverage Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','303','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','303',NULL,'Coverage Termination Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','304','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','304',NULL,'Coverage Termination Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','305','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','305',NULL,'Spouse Supplemental AD&D Face Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','306','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','306',NULL,'Spouse Supplemental AD&D Requested Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','307','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','307',NULL,'Employee Group ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','308','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','308',NULL,'Employee Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"~BDA~"','309','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','309',NULL,'Section Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','310','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','310',NULL,'Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','311','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','311',NULL,'Coverage Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','312','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','312',NULL,'Coverage Termination Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','313','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','313',NULL,'Coverage Termination Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','314','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','314',NULL,'Dependent/Child Basic AD&D Face Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','315','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','315',NULL,'Dependent/Child Basic AD&D Requested Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','316','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','316',NULL,'Employee Group ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','317','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','317',NULL,'Employee Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"~DCA~"','318','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','318',NULL,'Section Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','319','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','319',NULL,'Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','320','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','320',NULL,'Coverage Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','321','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','321',NULL,'Coverage Termination Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','322','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','322',NULL,'Coverage Termination Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','323','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','323',NULL,'Dependent/Child Supplemental AD&D Face Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','324','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','324',NULL,'Dependent/Child Supplemental AD&D Requested Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','325','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','325',NULL,'Employee Group ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','326','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','326',NULL,'Employee Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"~VCI~"','327','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','327',NULL,'Section Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','328','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','328',NULL,'Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','329','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','329',NULL,'Coverage Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','330','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','330',NULL,'Coverage Termination Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','331','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','331',NULL,'Coverage Termination Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','332','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','332',NULL,'CI Benefit Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','333','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','333',NULL,'Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','334','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','334',NULL,'Plan Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','335','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','335',NULL,'Employee Group ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','336','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','336',NULL,'Employee Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"~CIB~"','337','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','337',NULL,'Section Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','338','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','338',NULL,'Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','339','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','339',NULL,'Coverage Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','340','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','340',NULL,'Coverage Termination Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','341','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','341',NULL,'Coverage Termination Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','342','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','342',NULL,'CI Buy-up Benefit Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','343','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','343',NULL,'Buy-Up Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','344','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','344',NULL,'Plan Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','345','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','345',NULL,'Employee Group ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','346','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','346',NULL,'Employee Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"~VAC~"','347','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','347',NULL,'Section Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','348','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','348',NULL,'Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','349','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','349',NULL,'Coverage Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','350','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','350',NULL,'Coverage Termination Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','351','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','351',NULL,'Coverage Termination Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','352','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','352',NULL,'Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','353','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','353',NULL,'Plan Option',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','354','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','354',NULL,'Plan Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','355','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','355',NULL,'Employee Group ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','356','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','356',NULL,'Employee Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" ~HIP~"','357','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','357',NULL,'Section Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','358','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','358',NULL,'Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','359','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','359',NULL,'Coverage Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','360','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','360',NULL,'Coverage Termination Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','361','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','361',NULL,'Coverage Termination Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','362','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','362',NULL,'Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','363','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','363',NULL,'Plan Option',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','364','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','364',NULL,'Plan Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','365','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','365',NULL,'Employee Group ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','366','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','366',NULL,'Employee Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"~LMS~"','367','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','367',NULL,'Section Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLeaveMangementIndicator"','368','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','368',NULL,'Leave Management Services Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','369','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','369',NULL,'Employee Covered by FML 50/75 Rule',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','370','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','370',NULL,'Key Employee Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','371','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','371',NULL,'Forced Eligibility',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','372','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','372',NULL,'Leave Management Option',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLast12MonthsHours"','373','(''UA''=''T|'')','EHRTSLFEXPZ0','50','D','10','373',NULL,'Last 12 Months Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','374','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','374',NULL,'Last 12 Months Paid Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','375','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','375',NULL,'Actual Hours Worked',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','376','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','376',NULL,'Usage Time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','377','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','377',NULL,'Regulation Period Basis',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFileGerationDate"','378','(''UD112''=''T|'')','EHRTSLFEXPZ0','50','D','10','378',NULL,'Cumulative Hours End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"52"','379','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','379',NULL,'Cumulative Hours Number of Weeks',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','380','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','380',NULL,'Sick Leave Hours Remaining',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','381','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','381',NULL,'Vacation Hours Remaining',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','382','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','382',NULL,'Work Schedule Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','383','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','383',NULL,'Work Schedule From Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','384','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','384',NULL,'Work schedule -  Hours Monday',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','385','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','385',NULL,'Work Schedule - Hours Tuesday',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','386','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','386',NULL,'Work Schedule -  Hours Wednesday',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','387','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','387',NULL,'Work Schedule -  Hours Thursday',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','388','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','388',NULL,'Work Schedule - Hours Friday',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','389','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','389',NULL,'Work Schedule -  Hours Saturday',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','390','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','390',NULL,'Work Schedule -  Hours Sunday',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','391','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','391',NULL,'Number of Days in Repeating Work Schedule',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','392','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','392',NULL,'Repeating Schedule - Day 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','393','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','393',NULL,'Repeating Schedule - Day 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','394','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','394',NULL,'Repeating Schedule - Day 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','395','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','395',NULL,'Repeating Schedule - Day 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','396','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','396',NULL,'Repeating Schedule - Day 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','397','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','397',NULL,'Repeating Schedule - Day 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','398','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','398',NULL,'Repeating Schedule - Day 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','399','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','399',NULL,'Repeating Schedule - Day 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','400','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','400',NULL,'Repeating Schedule - Day 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','401','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','401',NULL,'Repeating Schedule - Day 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','402','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','402',NULL,'Repeating Schedule - Day 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','403','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','403',NULL,'Repeating Schedule - Day 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','404','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','404',NULL,'Repeating Schedule - Day 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','405','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','405',NULL,'Repeating Schedule - Day 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','406','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','406',NULL,'Repeating Schedule - Day 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','407','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','407',NULL,'Repeating Schedule - Day 16',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','408','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','408',NULL,'Repeating Schedule - Day 17',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','409','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','409',NULL,'Repeating Schedule - Day 18',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','410','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','410',NULL,'Repeating Schedule - Day 19',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','411','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','411',NULL,'Repeating Schedule - Day 20',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','412','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','412',NULL,'Repeating Schedule - Day 21',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','413','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','413',NULL,'Repeating Schedule - Day 22',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','414','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','414',NULL,'Repeating Schedule - Day 23',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','415','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','415',NULL,'Repeating Schedule - Day 24',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','416','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','416',NULL,'Repeating Schedule - Day 25',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','417','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','417',NULL,'Repeating Schedule - Day 26',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','418','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','418',NULL,'Repeating Schedule - Day 27',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','419','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','419',NULL,'Repeating Schedule - Day 28',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','420','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','420',NULL,'Repeating Schedule - Day 29',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','421','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','421',NULL,'Repeating Schedule - Day 30',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','422','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','422',NULL,'Repeating Schedule - Day 31',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','423','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','423',NULL,'Repeating Schedule - Day 32',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','424','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','424',NULL,'Repeating Schedule - Day 33',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','425','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','425',NULL,'Repeating Schedule - Day 34',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','426','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','426',NULL,'Repeating Schedule - Day 35',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','427','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','427',NULL,'Repeating Schedule - Day 36',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','428','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','428',NULL,'Repeating Schedule - Day 37',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','429','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','429',NULL,'Repeating Schedule - Day 38',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','430','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','430',NULL,'Repeating Schedule - Day 39',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','431','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','431',NULL,'Repeating Schedule - Day 40',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','432','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','432',NULL,'Repeating Schedule - Day 41',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','433','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','433',NULL,'Repeating Schedule - Day 42',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','434','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','434',NULL,'Repeating Schedule - Day 43',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','435','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','435',NULL,'Repeating Schedule - Day 44',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','436','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','436',NULL,'Repeating Schedule - Day 45',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','437','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','437',NULL,'Repeating Schedule - Day 46',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','438','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','438',NULL,'Repeating Schedule - Day 47',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','439','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','439',NULL,'Repeating Schedule - Day 48',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','440','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','440',NULL,'Repeating Schedule - Day 49',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','441','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','441',NULL,'Repeating Schedule - Day 50',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','442','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','442',NULL,'Repeating Schedule - Day 51',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','443','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','443',NULL,'Repeating Schedule - Day 52',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','444','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','444',NULL,'Repeating Schedule - Day 53',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','445','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','445',NULL,'Repeating Schedule - Day 54',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','446','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','446',NULL,'Repeating Schedule - Day 55',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','447','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','447',NULL,'Repeating Schedule - Day 56',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','448','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','448',NULL,'Repeating Schedule - Day 57',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','449','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','449',NULL,'Repeating Schedule - Day 58',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','450','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','450',NULL,'Repeating Schedule - Day 59',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','451','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','451',NULL,'Repeating Schedule - Day 60',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','452','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','452',NULL,'Flight Crew',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','453','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','453',NULL,'FMLA Radius',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"~ROL~"','454','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','454',NULL,'Section Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','455','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','455',NULL,'Reporting Level 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','456','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','456',NULL,'Reporting Level 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','457','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','457',NULL,'Reporting Level 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','458','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','458',NULL,'Reporting Level 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','459','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','459',NULL,'Reporting Level 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','460','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','460',NULL,'Reporting Level 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','461','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','461',NULL,'Reporting Level 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','462','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','462',NULL,'Reporting Level 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','463','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','463',NULL,'Reporting Level 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','464','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','464',NULL,'Reporting Level 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','465','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','465',NULL,'Reporting Level 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','466','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','466',NULL,'Reporting Level 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" ~BEN~"','467','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','467',NULL,'Section Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','468','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','468',NULL,'Beneficiary Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','469','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','469',NULL,'Beneficiary First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','470','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','470',NULL,'Beneficiary SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','471','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','471',NULL,'Trust/Charity Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','472','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','472',NULL,'Tax Identification Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','473','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','473',NULL,'Beneficiary Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','474','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','474',NULL,'Beneficiary Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','475','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','475',NULL,'Beneficiary Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','476','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','476',NULL,'Beneficiary City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','477','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','477',NULL,'Beneficiary State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','478','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','478',NULL,'Beneficiary Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','479','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','479',NULL,'Beneficiary Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','480','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','480',NULL,'Beneficiary Plan Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','481','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','481',NULL,'Beneficiary Percent Allocation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','482','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','482',NULL,'Beneficiary Type Primary or Contingent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','483','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','483',NULL,'Beneficiary Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','484','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','484',NULL,'Beneficiary Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','485','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','485',NULL,'Beneficiary First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','486','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','486',NULL,'Beneficiary SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','487','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','487',NULL,'Trust/Charity Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','488','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','488',NULL,'Tax Identification Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','489','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','489',NULL,'Beneficiary Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','490','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','490',NULL,'Beneficiary Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','491','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','491',NULL,'Beneficiary Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','492','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','492',NULL,'Beneficiary City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','493','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','493',NULL,'Beneficiary State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','494','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','494',NULL,'Beneficiary Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','495','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','495',NULL,'Beneficiary Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','496','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','496',NULL,'Beneficiary Plan Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','497','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','497',NULL,'Beneficiary Percent Allocation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','498','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','498',NULL,'Beneficiary Primary or Contingent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','499','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','499',NULL,'Beneficiary Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','500','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','500',NULL,'Beneficiary Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','501','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','501',NULL,'Beneficiary First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','502','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','502',NULL,'Beneficiary SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','503','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','503',NULL,'Trust/Charity Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','504','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','504',NULL,'Tax Identification Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','505','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','505',NULL,'Beneficiary Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','506','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','506',NULL,'Beneficiary Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','507','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','507',NULL,'Beneficiary Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','508','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','508',NULL,'Beneficiary City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','509','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','509',NULL,'Beneficiary State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','510','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','510',NULL,'Beneficiary Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','511','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','511',NULL,'Beneficiary Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','512','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','512',NULL,'Beneficiary Plan Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','513','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','513',NULL,'Beneficiary Percent Allocation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','514','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','514',NULL,'Beneficiary Primary or Contingent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','515','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','515',NULL,'Beneficiary Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','516','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','516',NULL,'Beneficiary Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','517','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','517',NULL,'Beneficiary First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','518','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','518',NULL,'Beneficiary SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','519','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','519',NULL,'Trust/Charity Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','520','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','520',NULL,'Tax Identification Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','521','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','521',NULL,'Beneficiary Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','522','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','522',NULL,'Beneficiary Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','523','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','523',NULL,'Beneficiary Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','524','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','524',NULL,'Beneficiary City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','525','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','525',NULL,'Beneficiary State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','526','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','526',NULL,'Beneficiary Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','527','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','527',NULL,'Beneficiary Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','528','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','528',NULL,'Beneficiary Plan Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','529','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','529',NULL,'Beneficiary Percent Allocation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','530','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','530',NULL,'Beneficiary Primary or Contingent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','531','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','531',NULL,'Beneficiary Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','532','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','532',NULL,'Beneficiary Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','533','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','533',NULL,'Beneficiary First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','534','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','534',NULL,'Beneficiary SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','535','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','535',NULL,'Trust/Charity Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','536','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','536',NULL,'Tax Identification Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','537','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','537',NULL,'Beneficiary Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','538','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','538',NULL,'Beneficiary Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','539','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','539',NULL,'Beneficiary Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','540','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','540',NULL,'Beneficiary City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','541','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','541',NULL,'Beneficiary State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','542','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','542',NULL,'Beneficiary Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','543','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','543',NULL,'Beneficiary Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','544','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','544',NULL,'Beneficiary Plan Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','545','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','545',NULL,'Beneficiary Percent Allocation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','546','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','546',NULL,'Beneficiary Primary or Contingent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','547','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','547',NULL,'Beneficiary Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','548','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','548',NULL,'Beneficiary Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','549','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','549',NULL,'Beneficiary First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','550','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','550',NULL,'Beneficiary SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','551','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','551',NULL,'Trust/Charity Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','552','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','552',NULL,'Tax Identification Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','553','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','553',NULL,'Beneficiary Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','554','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','554',NULL,'Beneficiary Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','555','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','555',NULL,'Beneficiary Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','556','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','556',NULL,'Beneficiary City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','557','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','557',NULL,'Beneficiary State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','558','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','558',NULL,'Beneficiary Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','559','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','559',NULL,'Beneficiary Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','560','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','560',NULL,'Beneficiary Plan Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','561','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','561',NULL,'Beneficiary Percent Allocation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','562','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','562',NULL,'Beneficiary Primary or Contingent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','563','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','563',NULL,'Beneficiary Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','564','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','564',NULL,'Beneficiary Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','565','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','565',NULL,'Beneficiary First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','566','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','566',NULL,'Beneficiary SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','567','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','567',NULL,'Trust/Charity Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','568','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','568',NULL,'Tax Identification Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','569','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','569',NULL,'Beneficiary Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','570','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','570',NULL,'Beneficiary Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','571','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','571',NULL,'Beneficiary Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','572','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','572',NULL,'Beneficiary City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','573','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','573',NULL,'Beneficiary State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','574','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','574',NULL,'Beneficiary Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','575','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','575',NULL,'Beneficiary Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','576','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','576',NULL,'Beneficiary Plan Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','577','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','577',NULL,'Beneficiary Percent Allocation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','578','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','578',NULL,'Beneficiary Primary or Contingent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','579','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','579',NULL,'Beneficiary Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','580','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','580',NULL,'Beneficiary Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','581','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','581',NULL,'Beneficiary First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','582','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','582',NULL,'Beneficiary SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','583','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','583',NULL,'Trust/Charity Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','584','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','584',NULL,'Tax Identification Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','585','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','585',NULL,'Beneficiary Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','586','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','586',NULL,'Beneficiary Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','587','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','587',NULL,'Beneficiary Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','588','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','588',NULL,'Beneficiary City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','589','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','589',NULL,'Beneficiary State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','590','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','590',NULL,'Beneficiary Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','591','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','591',NULL,'Beneficiary Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','592','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','592',NULL,'Beneficiary Plan Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','593','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','593',NULL,'Beneficiary Percent Allocation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','594','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','594',NULL,'Beneficiary Primary or Contingent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','595','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','595',NULL,'Beneficiary Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','596','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','596',NULL,'Beneficiary Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','597','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','597',NULL,'Beneficiary First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','598','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','598',NULL,'Beneficiary SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','599','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','599',NULL,'Trust/Charity Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','600','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','600',NULL,'Tax Identification Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','601','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','601',NULL,'Beneficiary Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','602','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','602',NULL,'Beneficiary Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','603','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','603',NULL,'Beneficiary Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','604','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','604',NULL,'Beneficiary City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','605','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','605',NULL,'Beneficiary State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','606','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','606',NULL,'Beneficiary Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','607','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','607',NULL,'Beneficiary Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','608','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','608',NULL,'Beneficiary Plan Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','609','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','609',NULL,'Beneficiary Percent Allocation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','610','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','610',NULL,'Beneficiary Primary or Contingent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','611','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','611',NULL,'Beneficiary Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','612','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','612',NULL,'Beneficiary Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','613','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','613',NULL,'Beneficiary First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','614','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','614',NULL,'Beneficiary SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','615','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','615',NULL,'Trust/Charity Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','616','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','616',NULL,'Tax Identification Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','617','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','617',NULL,'Beneficiary Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','618','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','618',NULL,'Beneficiary Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','619','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','619',NULL,'Beneficiary Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','620','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','620',NULL,'Beneficiary City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','621','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','621',NULL,'Beneficiary State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','622','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','622',NULL,'Beneficiary Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','623','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','623',NULL,'Beneficiary Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','624','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','624',NULL,'Beneficiary Plan Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','625','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','625',NULL,'Beneficiary Percent Allocation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','626','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','626',NULL,'Beneficiary Primary or Contingent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','627','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','627',NULL,'Beneficiary Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','628','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','628',NULL,'Beneficiary Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','629','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','629',NULL,'Beneficiary First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','630','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','630',NULL,'Beneficiary SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','631','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','631',NULL,'Trust/Charity Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','632','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','632',NULL,'Tax Identification Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','633','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','633',NULL,'Beneficiary Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','634','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','634',NULL,'Beneficiary Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','635','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','635',NULL,'Beneficiary Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','636','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','636',NULL,'Beneficiary City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','637','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','637',NULL,'Beneficiary State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','638','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','638',NULL,'Beneficiary Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','639','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','639',NULL,'Beneficiary Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','640','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','640',NULL,'Beneficiary Plan Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','641','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','641',NULL,'Beneficiary Percent Allocation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','642','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','642',NULL,'Beneficiary Primary or Contingent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','643','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','643',NULL,'Beneficiary Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','644','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','644',NULL,'Beneficiary Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','645','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','645',NULL,'Beneficiary First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','646','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','646',NULL,'Beneficiary SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','647','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','647',NULL,'Trust/Charity Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','648','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','648',NULL,'Tax Identification Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','649','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','649',NULL,'Beneficiary Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','650','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','650',NULL,'Beneficiary Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','651','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','651',NULL,'Beneficiary Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','652','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','652',NULL,'Beneficiary City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','653','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','653',NULL,'Beneficiary State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','654','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','654',NULL,'Beneficiary Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','655','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','655',NULL,'Beneficiary Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','656','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','656',NULL,'Beneficiary Plan Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','657','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','657',NULL,'Beneficiary Percent Allocation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','658','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','658',NULL,'Beneficiary Primary or Contingent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','659','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','659',NULL,'Beneficiary Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','660','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','660',NULL,'Beneficiary Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','661','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','661',NULL,'Beneficiary First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','662','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','662',NULL,'Beneficiary SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','663','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','663',NULL,'Trust/Charity Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','664','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','664',NULL,'Tax Identification Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','665','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','665',NULL,'Beneficiary Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','666','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','666',NULL,'Beneficiary Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','667','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','667',NULL,'Beneficiary Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','668','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','668',NULL,'Beneficiary City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','669','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','669',NULL,'Beneficiary State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','670','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','670',NULL,'Beneficiary Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','671','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','671',NULL,'Beneficiary Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','672','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','672',NULL,'Beneficiary Plan Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','673','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','673',NULL,'Beneficiary Percent Allocation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','674','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','674',NULL,'Beneficiary Primary or Contingent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','675','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','675',NULL,'Beneficiary Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','676','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','676',NULL,'Beneficiary Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','677','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','677',NULL,'Beneficiary First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','678','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','678',NULL,'Beneficiary SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','679','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','679',NULL,'Trust/Charity Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','680','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','680',NULL,'Tax Identification Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','681','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','681',NULL,'Beneficiary Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','682','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','682',NULL,'Beneficiary Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','683','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','683',NULL,'Beneficiary Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','684','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','684',NULL,'Beneficiary City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','685','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','685',NULL,'Beneficiary State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','686','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','686',NULL,'Beneficiary Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','687','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','687',NULL,'Beneficiary Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','688','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','688',NULL,'Beneficiary Plan Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','689','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','689',NULL,'Beneficiary Percent Allocation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','690','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','690',NULL,'Beneficiary Primary or Contingent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','691','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','691',NULL,'Beneficiary Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','692','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','692',NULL,'Beneficiary Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','693','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','693',NULL,'Beneficiary First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','694','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','694',NULL,'Beneficiary SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','695','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','695',NULL,'Trust/Charity Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','696','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','696',NULL,'Tax Identification Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','697','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','697',NULL,'Beneficiary Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','698','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','698',NULL,'Beneficiary Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','699','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','699',NULL,'Beneficiary Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','700','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','700',NULL,'Beneficiary City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','701','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','701',NULL,'Beneficiary State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','702','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','702',NULL,'Beneficiary Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','703','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','703',NULL,'Beneficiary Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','704','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','704',NULL,'Beneficiary Plan Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','705','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','705',NULL,'Beneficiary Percent Allocation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','706','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','706',NULL,'Beneficiary Primary or Contingent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','707','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','707',NULL,'Beneficiary Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','708','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','708',NULL,'Beneficiary Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','709','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','709',NULL,'Beneficiary First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','710','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','710',NULL,'Beneficiary SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','711','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','711',NULL,'Trust/Charity Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','712','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','712',NULL,'Tax Identification Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','713','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','713',NULL,'Beneficiary Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','714','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','714',NULL,'Beneficiary Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','715','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','715',NULL,'Beneficiary Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','716','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','716',NULL,'Beneficiary City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','717','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','717',NULL,'Beneficiary State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','718','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','718',NULL,'Beneficiary Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','719','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','719',NULL,'Beneficiary Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','720','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','720',NULL,'Beneficiary Plan Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','721','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','721',NULL,'Beneficiary Percent Allocation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','722','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','722',NULL,'Beneficiary Primary or Contingent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','723','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','723',NULL,'Beneficiary Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','724','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','724',NULL,'Beneficiary Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','725','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','725',NULL,'Beneficiary First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','726','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','726',NULL,'Beneficiary SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','727','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','727',NULL,'Trust/Charity Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','728','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','728',NULL,'Tax Identification Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','729','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','729',NULL,'Beneficiary Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','730','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','730',NULL,'Beneficiary Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','731','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','731',NULL,'Beneficiary Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','732','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','732',NULL,'Beneficiary City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','733','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','733',NULL,'Beneficiary State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','734','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','734',NULL,'Beneficiary Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','735','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','735',NULL,'Beneficiary Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','736','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','736',NULL,'Beneficiary Plan Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','737','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','737',NULL,'Beneficiary Percent Allocation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','738','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','738',NULL,'Beneficiary Primary or Contingent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','739','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','739',NULL,'Beneficiary Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','740','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','740',NULL,'Beneficiary Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','741','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','741',NULL,'Beneficiary First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','742','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','742',NULL,'Beneficiary SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','743','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','743',NULL,'Trust/Charity Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','744','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','744',NULL,'Tax Identification Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','745','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','745',NULL,'Beneficiary Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','746','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','746',NULL,'Beneficiary Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','747','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','747',NULL,'Beneficiary Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','748','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','748',NULL,'Beneficiary City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','749','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','749',NULL,'Beneficiary State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','750','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','750',NULL,'Beneficiary Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','751','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','751',NULL,'Beneficiary Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','752','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','752',NULL,'Beneficiary Plan Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','753','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','753',NULL,'Beneficiary Percent Allocation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','754','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','754',NULL,'Beneficiary Primary or Contingent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','755','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','755',NULL,'Beneficiary Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','756','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','756',NULL,'Beneficiary Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','757','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','757',NULL,'Beneficiary First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','758','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','758',NULL,'Beneficiary SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','759','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','759',NULL,'Trust/Charity Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','760','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','760',NULL,'Tax Identification Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','761','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','761',NULL,'Beneficiary Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','762','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','762',NULL,'Beneficiary Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','763','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','763',NULL,'Beneficiary Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','764','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','764',NULL,'Beneficiary City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','765','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','765',NULL,'Beneficiary State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','766','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','766',NULL,'Beneficiary Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','767','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','767',NULL,'Beneficiary Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','768','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','768',NULL,'Beneficiary Plan Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','769','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','769',NULL,'Beneficiary Percent Allocation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','770','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','770',NULL,'Beneficiary Primary or Contingent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','771','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','771',NULL,'Beneficiary Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','772','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','772',NULL,'Beneficiary Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','773','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','773',NULL,'Beneficiary First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','774','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','774',NULL,'Beneficiary SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','775','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','775',NULL,'Trust/Charity Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','776','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','776',NULL,'Tax Identification Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','777','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','777',NULL,'Beneficiary Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','778','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','778',NULL,'Beneficiary Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','779','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','779',NULL,'Beneficiary Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','780','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','780',NULL,'Beneficiary City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','781','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','781',NULL,'Beneficiary State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','782','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','782',NULL,'Beneficiary Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','783','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','783',NULL,'Beneficiary Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','784','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','784',NULL,'Beneficiary Plan Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','785','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','785',NULL,'Beneficiary Percent Allocation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','786','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','786',NULL,'Beneficiary Primary or Contingent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','787','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','787',NULL,'Beneficiary Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"~DED~"','788','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','788',NULL,'Section Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','789','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','789',NULL,'Benefit Deduct Type 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','790','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','790',NULL,'Benefit Deduct Amt 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','791','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','791',NULL,'Benefit Deduct Eff Date 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','792','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','792',NULL,'Benefit Deduct End Date1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','793','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','793',NULL,'Benefit Deduct Pre/Post 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','794','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','794',NULL,'Benefit Deduct Basis 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','795','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','795',NULL,'Benefit Deduct Order 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','796','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','796',NULL,'Benefit Deduct Type 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','797','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','797',NULL,'Benefit Deduct Amt 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','798','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','798',NULL,'Benefit Deduct Eff Date 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','799','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','799',NULL,'Benefit Deduct End Date 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','800','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','800',NULL,'Benefit Deduct Pre/Post 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','801','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','801',NULL,'Benefit Deduct Basis 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','802','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','802',NULL,'Benefit Deduct Order 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','803','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','803',NULL,'Benefit Deduct Type 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','804','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','804',NULL,'Benefit Deduct Amt 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','805','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','805',NULL,'Benefit Deduct Eff Date 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','806','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','806',NULL,'Benefit Deduct End Date3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','807','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','807',NULL,'Benefit Deduct Pre/Post 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','808','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','808',NULL,'Benefit Deduct Basis 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','809','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','809',NULL,'Benefit Deduct Order 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','810','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','810',NULL,'Benefit Deduct Type 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','811','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','811',NULL,'Benefit Deduct Amt 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','812','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','812',NULL,'Benefit Deduct Eff Date 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','813','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','813',NULL,'Benefit Deduct End Date 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','814','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','814',NULL,'Benefit Deduct Pre/Post 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','815','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','815',NULL,'Benefit Deduct Basis 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','816','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','816',NULL,'Benefit Deduct Order 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','817','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','817',NULL,'Benefit Deduct Type 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','818','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','818',NULL,'Benefit Deduct Amt 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','819','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','819',NULL,'Benefit Deduct Eff Date 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','820','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','820',NULL,'Benefit Deduct End Date 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','821','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','821',NULL,'Benefit Deduct Pre/Post 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','822','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','822',NULL,'Benefit Deduct Basis 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','823','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','823',NULL,'Benefit Deduct Order 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','824','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','824',NULL,'Benefit Deduct Type 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','825','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','825',NULL,'Benefit Deduct Amt 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','826','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','826',NULL,'Benefit Deduct Eff Date 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','827','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','827',NULL,'Benefit Deduct End Date 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','828','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','828',NULL,'Benefit Deduct Pre/Post 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','829','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','829',NULL,'Benefit Deduct Basis 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','830','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','830',NULL,'Benefit Deduct Order 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','831','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','831',NULL,'Benefit Deduct Type 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','832','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','832',NULL,'Benefit Deduct Amt 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','833','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','833',NULL,'Benefit Deduct Eff Date 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','834','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','834',NULL,'Benefit Deduct End Date 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','835','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','835',NULL,'Benefit Deduct Pre/Post 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','836','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','836',NULL,'Benefit Deduct Basis 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','837','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','837',NULL,'Benefit Deduct Order 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','838','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','838',NULL,'Benefit Deduct Type 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','839','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','839',NULL,'Benefit Deduct Amt 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','840','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','840',NULL,'Benefit Deduct Eff Date 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','841','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','841',NULL,'Benefit Deduct End Date 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','842','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','842',NULL,'Benefit Deduct Pre/Post 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','843','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','843',NULL,'Benefit Deduct Basis 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','844','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','844',NULL,'Benefit Deduct Order 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','845','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','845',NULL,'Benefit Deduct Type 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','846','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','846',NULL,'Benefit Deduct Amt 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','847','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','847',NULL,'Benefit Deduct Eff Date 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','848','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','848',NULL,'Benefit Deduct End Date 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','849','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','849',NULL,'Benefit Deduct Pre/Post 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','850','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','850',NULL,'Benefit Deduct Basis 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','851','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','851',NULL,'Benefit Deduct Order 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','852','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','852',NULL,'Benefit Deduct Type 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','853','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','853',NULL,'Benefit Deduct Amt 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','854','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','854',NULL,'Benefit Deduct Eff Date 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','855','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','855',NULL,'Benefit Deduct End Date 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','856','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','856',NULL,'Benefit Deduct Pre/Post 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','857','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','857',NULL,'Benefit Deduct Basis 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','858','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','858',NULL,'Benefit Deduct Order 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','859','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','859',NULL,'Benefit Deduct Type 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','860','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','860',NULL,'Benefit Deduct Amt 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','861','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','861',NULL,'Benefit Deduct Eff Date 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','862','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','862',NULL,'Benefit Deduct End Date 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','863','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','863',NULL,'Benefit Deduct Pre/Post 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','864','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','864',NULL,'Benefit Deduct Basis 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','865','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','865',NULL,'Benefit Deduct Order 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','866','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','866',NULL,'Benefit Deduct Type 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','867','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','867',NULL,'Benefit Deduct Amt 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','868','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','868',NULL,'Benefit Deduct Eff Date 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','869','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','869',NULL,'Benefit Deduct End Date 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','870','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','870',NULL,'Benefit Deduct Pre/Post 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','871','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','871',NULL,'Benefit Deduct Basis 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','872','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','872',NULL,'Benefit Deduct Order 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','873','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','873',NULL,'Benefit Deduct Type 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','874','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','874',NULL,'Benefit Deduct Amt 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','875','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','875',NULL,'Benefit Deduct Eff Date 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','876','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','876',NULL,'Benefit Deduct End Date 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','877','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','877',NULL,'Benefit Deduct Pre/Post 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','878','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','878',NULL,'Benefit Deduct Basis 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','879','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','879',NULL,'Benefit Deduct Order 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','880','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','880',NULL,'Benefit Deduct Type 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','881','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','881',NULL,'Benefit Deduct Amt 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','882','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','882',NULL,'Benefit Deduct Eff Date 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','883','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','883',NULL,'Benefit Deduct End Date 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','884','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','884',NULL,'Benefit Deduct Pre/Post 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','885','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','885',NULL,'Benefit Deduct Basis 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','886','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','886',NULL,'Benefit Deduct Order 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','887','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','887',NULL,'Benefit Deduct Type 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','888','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','888',NULL,'Benefit Deduct Amt 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','889','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','889',NULL,'Benefit Deduct Eff Date 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','890','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','890',NULL,'Benefit Deduct End Date 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','891','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','891',NULL,'Benefit Deduct Pre/Post 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','892','(''DA''=''T|'')','EHRTSLFEXPZ0','50','D','10','892',NULL,'Benefit Deduct Basis 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','893','(''DA''=''T'')','EHRTSLFEXPZ0','50','D','10','893',NULL,'Benefit Deduct Order 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"~FTR~"','1','(''DA''=''T|'')','EHRTSLFEXPZ0','50','T','90','1',NULL,'Section Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordCount"','2','(''UA''=''T'')','EHRTSLFEXPZ0','50','T','90','2',NULL,'Record Count',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EHRTSLFEXP_20200207.txt',NULL,NULL,NULL,',IAGFG,HTEZ2,S9JHB,KFUDU,ZVN7G,A97O7,TJFST,ZVPSX',NULL,NULL,NULL,'Hartford LTD STD FMLA-ONDEMAND','201910159','EMPEXPORT','ONDEMAND',NULL,'EHRTSLFEXP',NULL,NULL,NULL,'201910159','Oct 15 2019  5:41PM','Oct 15 2019  5:41PM','201910151',NULL,'','','201910151',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EHRTSLFEXP_20200207.txt',NULL,'Null','N','IAGFG,HTEZ2,S9JHB,KFUDU,ZVN7G,A97O7,TJFST,ZVPSX',NULL,NULL,NULL,'Hartford LTDSTDFMLA - Fri 5am','201910159','EMPEXPORT','HRTS_SCHED',NULL,'EHRTSLFEXP',NULL,NULL,NULL,'202002079','Oct 15 2019  5:41PM','Oct 15 2019  5:41PM','202001311',NULL,'','','201910151',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EHRTSLFEXP_20200207.txt',NULL,'','','IAGFG,HTEZ2,S9JHB,KFUDU,ZVN7G,A97O7,TJFST,ZVPSX',NULL,NULL,NULL,'Test Purposes Only','202001179','EMPEXPORT','TEST','Jan 17 2020  9:55AM','EHRTSLFEXP',NULL,NULL,NULL,'202001179','Jan 17 2020 12:00AM','Dec 30 1899 12:00AM','202001101','1210','','','202001101',dbo.fn_GetTimedKey(),NULL,'us3lKiAPP1004',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EHRTSLFEXP_20200207.txt' END WHERE expFormatCode = 'EHRTSLFEXP';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHRTSLFEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHRTSLFEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHRTSLFEXP','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHRTSLFEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHRTSLFEXP','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EHRTSLFEXP' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EHRTSLFEXP' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EHRTSLFEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EHRTSLFEXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EHRTSLFEXP','H01','dbo.U_EHRTSLFEXP_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EHRTSLFEXP','D10','dbo.U_EHRTSLFEXP_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EHRTSLFEXP','T90','dbo.U_EHRTSLFEXP_Trailer',NULL);
IF OBJECT_ID('U_dsi_BDM_EHRTSLFEXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EHRTSLFEXP] (
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
IF OBJECT_ID('U_EHRTSLFEXP_Audit') IS NULL
CREATE TABLE [dbo].[U_EHRTSLFEXP_Audit] (
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
IF OBJECT_ID('U_EHRTSLFEXP_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EHRTSLFEXP_AuditFields] (
    [aTableName] varchar(128) NULL,
    [aFieldName] varchar(128) NULL
);
IF OBJECT_ID('U_EHRTSLFEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EHRTSLFEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EHRTSLFEXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EHRTSLFEXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvCustomerNumber] varchar(7) NOT NULL,
    [drvTransactionCode] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvEmployeeId] char(9) NULL,
    [drvRelationshipCode] varchar(2) NULL,
    [drvLastName] varchar(6000) NULL,
    [drvFirstName] varchar(6000) NULL,
    [drvMiddleName] varchar(6000) NULL,
    [drvNamePrefix] varchar(30) NULL,
    [drvBirthDate] datetime NULL,
    [drvMarialStatus] varchar(1) NULL,
    [drvGender] char(1) NULL,
    [drvAddressLine1] varchar(6000) NULL,
    [drvAddressLine2] varchar(6000) NULL,
    [drvAddressCity] varchar(6000) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAdressZipCode] varchar(50) NULL,
    [drvCountryCode] varchar(3) NOT NULL,
    [drvProvinceCode] varchar(1) NOT NULL,
    [drvProvinceName] varchar(1) NOT NULL,
    [drvEmpHomePhone] varchar(50) NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvWorkStateCode] varchar(255) NULL,
    [drvEmployeeZipCode] varchar(1) NOT NULL,
    [drvEmployeeCountryCode] varchar(3) NOT NULL,
    [drvSuperVisorId] varchar(256) NULL,
    [drvEmployeeStatusDate] datetime NULL,
    [drvEmployeeStatus] varchar(1) NOT NULL,
    [drvEmployeeServiceDate] datetime NULL,
    [drvEmployeeRehireDate] datetime NULL,
    [drvOriginalHireDate] datetime NULL,
    [drvTerminationReasonCode] varchar(1) NOT NULL,
    [drvTerminationReasonDesc] varchar(1) NOT NULL,
    [dvEmploymentType] varchar(2) NOT NULL,
    [drvScheduledHours] varchar(8000) NULL,
    [drvBenefitSalaryAmount] varchar(6000) NULL,
    [drvSalaryBasis] varchar(1) NOT NULL,
    [drvSalaryEffectiveDate] datetime NULL,
    [drvJobTitle] varchar(8000) NULL,
    [drvLastEightEarning] varchar(21) NOT NULL,
    [drvLastFourWeekPayroll] varchar(12) NULL,
    [drvEEHolidaySchedule] varchar(25) NOT NULL,
    [drvClientFiend2Value] varchar(9) NULL,
    [drvOrgLevelDesc1] varchar(25) NULL,
    [drvNSTEffectiveDate] datetime NULL,
    [drvNSTBenStopDate] datetime NULL,
    [drvNSTCoveragePlanOption] varchar(3) NULL,
    [drvNSTPlanSummary] varchar(3) NULL,
    [drvNSTEmployeeGroupId] varchar(2) NULL,
    [drvNSTEmployeeeClassCode] varchar(1) NULL,
    [drvSTACoverageEffectiveDate] datetime NULL,
    [drvSTACoverageTerminationDate] datetime NULL,
    [drvSTAPlanCoverageOption] varchar(2) NULL,
    [drvSTAPlanSummary] varchar(3) NULL,
    [drvSTAEmployeeGroupId] varchar(2) NULL,
    [drvSTAEmployeeClassCode] varchar(1) NULL,
    [drvLTDCoverageEffectiveDate] datetime NULL,
    [drvLTDCoverageTerminationDate] datetime NULL,
    [drvLTDCoveragePlanOption] varchar(2) NULL,
    [drvLTDPlanSummary] varchar(3) NULL,
    [drvLTDEmployeeGroupId] varchar(2) NULL,
    [drvLTDEmployeeClassCode] varchar(1) NULL,
    [drvReportingLevel1] varchar(6) NULL,
    [drvBLFEffectiveDate] datetime NULL,
    [drvBLFTerminationDate] datetime NULL,
    [drvBLFAmount] varchar(12) NULL,
    [drvBLFGroupId] varchar(2) NULL,
    [drvBLFClassCode] varchar(1) NULL,
    [drvBADEffectiveDate] datetime NULL,
    [drvBADTerminationDate] datetime NULL,
    [drvBADAmount] varchar(12) NULL,
    [drvBADGroupId] varchar(2) NULL,
    [drvBADClassCode] varchar(1) NULL,
    [drvLIFEffectiveDate] datetime NULL,
    [drvLIFTerminationDate] datetime NULL,
    [drvLIFAmount] varchar(12) NULL,
    [drvLIFSuppLifeAmt] varchar(12) NULL,
    [drvLIFGroupId] varchar(2) NULL,
    [drvLIFClassCode] varchar(1) NULL,
    [drvADDEffectiveDate] datetime NULL,
    [drvADDTerminationDate] datetime NULL,
    [drvADDAmount] varchar(12) NULL,
    [drvAddSuppReqAmt] varchar(12) NULL,
    [drvADDGroupId] varchar(2) NULL,
    [drvADDClassCode] varchar(1) NULL,
    [drvSPLEffectiveDate] datetime NULL,
    [drvSPLTerminationDate] datetime NULL,
    [drvSPLAmount] varchar(12) NULL,
    [drvSPLReqAmount] varchar(12) NULL,
    [drvSPLGroupId] varchar(2) NULL,
    [drvSPLClassCode] varchar(1) NULL,
    [drvDPLEffectiveDate] datetime NULL,
    [drvDPLTerminationDate] datetime NULL,
    [drvDPLAmount] varchar(12) NULL,
    [drvDPLGroupId] varchar(2) NULL,
    [drvDPLClassCode] varchar(1) NULL,
    [drvLeaveMangementIndicator] varchar(1) NOT NULL,
    [drvLast12MonthsHours] varchar(6000) NULL,
    [drvFileGerationDate] varchar(8) NULL
);
IF OBJECT_ID('U_EHRTSLFEXP_drvTblPII') IS NULL
CREATE TABLE [dbo].[U_EHRTSLFEXP_drvTblPII] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] char(11) NULL,
    [drvCustomerNumber] varchar(7) NOT NULL,
    [drvTransactionCode] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvEmployeeId] char(9) NULL,
    [drvRelationShipCode] varchar(1) NOT NULL,
    [drvLastName] varchar(6000) NULL,
    [drvFirstName] varchar(6000) NULL,
    [drvMiddleName] varchar(1) NULL,
    [drvNamePrefix] varchar(30) NULL,
    [drvBirthDate] datetime NULL,
    [drvMarialStatus] varchar(1) NULL,
    [drvGender] char(1) NULL
);
IF OBJECT_ID('U_EHRTSLFEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EHRTSLFEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EHRTSLFEXP_File') IS NULL
CREATE TABLE [dbo].[U_EHRTSLFEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(max) NULL
);
IF OBJECT_ID('U_EHRTSLFEXP_Header') IS NULL
CREATE TABLE [dbo].[U_EHRTSLFEXP_Header] (
    [drvFileName] varchar(50) NULL,
    [drvDateFileCreated] nvarchar(4000) NULL,
    [drvCustomerName] varchar(7) NOT NULL,
    [drvFileVersion] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EHRTSLFEXP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EHRTSLFEXP_PDedHist] (
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
IF OBJECT_ID('U_EHRTSLFEXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EHRTSLFEXP_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PehCurAmt] numeric NULL,
    [PehCurAmtOthers] numeric NULL,
    [PehCurHrs] decimal NULL,
    [PehCurAmtYTD] money NULL,
    [PehCurHrsYTD] decimal NULL,
    [PehInclInDefComp] money NULL,
    [PehInclInDefCompHrs] decimal NULL,
    [PehInclInDefCompYTD] money NULL,
    [PehInclInDefCompHrsYTD] decimal NULL
);
IF OBJECT_ID('U_EHRTSLFEXP_Trailer') IS NULL
CREATE TABLE [dbo].[U_EHRTSLFEXP_Trailer] (
    [drvRecordCount] varchar(50) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EHRTSLFEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Appriss

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 10/15/2019
Service Request Number: 

Purpose: Hartford LTD STD and FMLA Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2019     SR-2019-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EHRTSLFEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EHRTSLFEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EHRTSLFEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EHRTSLFEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EHRTSLFEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHRTSLFEXP', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHRTSLFEXP', 'TEST';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EHRTSLFEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@RunDate           VARCHAR(8)
            ,@RunTime           VARCHAR(4)
            ,@FileName          VARCHAR(50)
            ,@Last8WeekPerControl VARCHAR(10)
            ,@Last52WeekPerControl VARCHAR(10);

    -- Set FormatCode
    SELECT @FormatCode = 'EHRTSLFEXP';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@RunDate         = CONVERT(VARCHAR(8),GETDATE(),112)
        ,@RunTime         = CONVERT(VARCHAR(5), GETDATE(), 108)
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    SELECT @Last8WeekPerControl =  CONVERT(VARCHAR(12),DATEADD(week,-8, @StartDate),112) + '1'
    SELECT @Last52WeekPerControl =  CONVERT(VARCHAR(12),DATEADD(week,-52, @StartDate),112) + '1'


    PRINT 'Last 8 Weeks ' + @Last8WeekPerControl

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EHRTSLFEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EHRTSLFEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_EHRTSLFEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID NOT IN (SELECT eeceeid FROM dbo.empcomp where eeceetype  in  ('REG','INT'));

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'STD,LTD,LIFES,GLIFE,LIFEC,LIFEE,SALCO';

    IF OBJECT_ID('U_EHRTSLFEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EHRTSLFEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EHRTSLFEXP_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'DedCodes',@DedList); 
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'StartDateTime',@StartDate); 
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'EndDateTime',@EndDate); 
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'TermSelectionOption', 'AuditDate'); 


    EXEC dbo.dsi_bdm_sp_PopulateDeductionsTable @FormatCode; 

     --=====================================================
    -- Update BdmUSGField2 with EmpDedTVID for Employees
    --=====================================================
    UPDATE dbo.U_dsi_bdm_EHRTSLFEXP
        SET BdmUSGField2 = EedEmpDedTVID
    FROM dbo.U_dsi_bdm_EHRTSLFEXP
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = BdmEEID
        AND EedCOID = BdmCOID
        AND EedDedCode = BdmDedCode
    WHERE BdmRecType = 'EMP' AND EedFormatCode = @FormatCode AND EedValidForExport = 'Y';

    --=======================================================
    -- Update BdmUSGField2 with DepBPlanTVID for Dependents
    --=======================================================
    UPDATE dbo.U_dsi_bdm_EHRTSLFEXP
        SET BdmUSGField2 = DbnDepBPlanTVID
    FROM dbo.U_dsi_bdm_EHRTSLFEXP
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
        ON DbnEEID = BdmEEID
        AND DbnCOID = BdmCOID
        AND DbnDedCode = BdmDedCode
    WHERE BdmRecType = 'DEP' AND DbnFormatCode = @FormatCode AND DbnValidForExport = 'Y';

    --======================================================
    -- Update BdmUSGField1 with Benefit Amount (EedBenAmt)
    --======================================================
    UPDATE dbo.U_dsi_bdm_EHRTSLFEXP
        SET BdmUSGField1 = CONVERT(VARCHAR(20),EedBenAmt)
    FROM dbo.U_dsi_bdm_EHRTSLFEXP
    JOIN dbo.EmpDedFull WITH (NOLOCK)
        ON EedEmpDedTVID = BdmUSGField2;

    
    Select @FileName =  'APRISS_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'

    IF @ExportCode LIKE '%TEST' or @ExportCode LIKE '%HRTS_SCHED'
    BEGIN
         Select @FileName =  'TEST_APRISS_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
    END;


    IF OBJECT_ID('U_EHRTSLFEXP_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EHRTSLFEXP_AuditFields;
    CREATE TABLE dbo.U_EHRTSLFEXP_AuditFields (aTableName varchar(128),aFieldName varchar(128));
    
    -- Insert tables/fields to be audited
    INSERT INTO dbo.U_EHRTSLFEXP_AuditFields VALUES ('empcomp','eecemplstatus');    
    
    -- Create audit table
    IF OBJECT_ID('U_EHRTSLFEXP_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EHRTSLFEXP_Audit;
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
    INTO dbo.U_EHRTSLFEXP_Audit
    FROM (SELECT *
          FROM dbo.AuditRecords WITH (NOLOCK)
          WHERE adrTableName IN (SELECT aTableName FROM dbo.U_EHRTSLFEXP_AuditFields WITH (NOLOCK))) ADR
    JOIN (SELECT *
          FROM dbo.AuditFields WITH (NOLOCK)
          WHERE adfFieldName IN (SELECT aFieldName FROM dbo.U_EHRTSLFEXP_AuditFields WITH (NOLOCK))) ADF
        ON adrSystemID = adfSystemID
       AND adrKey = adfKey
    WHERE adrType IN (1,2,5,6) -- Insert/Update; remove this to include Deletes and Viewed
      AND adrProcessedDateTime BETWEEN @StartDate AND @EndDate;
    
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EHRTSLFEXP_Audit ON dbo.U_EHRTSLFEXP_Audit (audKey1Value, audKey2Value);

    --==========================================
    -- Build Working Tables
    --==========================================


    -----------------------------
    -- Working Table - PEarHist
    -----------------------------

    
    IF OBJECT_ID('U_EHRTSLFEXP_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EHRTSLFEXP_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >=  @Last8WeekPerControl and PehPerControl <= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
                                                                                                                                                        --HOL, HOLWK, OOL, OOJ, PERED, PTO, REG, SHFT2, SHFT3, SIC, VAC
        ,PehCurAmtOthers        = SUM(CASE WHEN (PehPerControl >=  @Last8WeekPerControl and PehPerControl <= @StartPerControl) and PehEarnCode IN ('HOL', 'HOLWK', 'OOL', 'OOJ', 'PERED', 'PTO','REG', 'SHFT2', 'SHFT3', 'SIC', 'VAC') THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(CASE WHEN (PehPerControl >=  @Last52WeekPerControl and PehPerControl <= @StartPerControl) and  PehEarnCode NOT IN ('HOL', 'HOLWK', 'PTO', 'SIC' , 'VAC') THEN PehCurHrs ELSE 0.00 END)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_EHRTSLFEXP_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE  PehPerControl <= @StartPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EHRTSLFEXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EHRTSLFEXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EHRTSLFEXP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = eepSSN
        ,drvSubSort  =  Case WHEN BdmRecType = 'EMP' or BdmRecType is null THEN '1' ELSE '2' END
        ,drvCustomerNumber = '1481871'
        ,drvTransactionCode = Case WHEN BdmRecType = 'EMP' or BdmRecType is null THEN 'E' ELSE 'D' END
        ,drvSSN = eepSSN
        ,drvEmployeeId = EecEmpNo
        ,drvRelationshipCode = CASE WHEN BdmRecType = 'DEP' THEN 
                                    CASE WHEN LIFEC IS NOT NULL and ConRelationship in ('CHL', 'STC' ,'DPC') THEN 'CH' 
                                        WHEN LIFES IS NOT NULL and ConRelationship in ('SPS'  ,'DP') THEN 'SP' 
                                        ELSE ''
                                    END
                                    WHEN BdmRecType IS NULL  THEN ''
                               END
        ,drvLastName = dbo.dsi_fnRemoveChars('.,/-',
                              CASE WHEN BdmRecType = 'EMP' THEN EepNameLast
                                   WHEN BdmRecType = 'DEP' THEN ConNameLast
                                   ELSE EepNameLast
                              END)
        ,drvFirstName = dbo.dsi_fnRemoveChars('.,/-',
                               CASE WHEN BdmRecType = 'EMP' THEN EepNameFirst
                                    WHEN BdmRecType = 'DEP' THEN ConNameFirst
                                    ELSE EepNameFirst
                               END)
        ,drvMiddleName = dbo.dsi_fnRemoveChars('.,/-',
                                       CASE WHEN BdmRecType = 'EMP' THEN LEFT(EepNameMiddle,1)
                                            WHEN BdmRecType = 'DEP' THEN LEFT(ConNameMiddle,1)
                                            ELSE LEFT(EepNameMiddle,1)
                                       END)
        ,drvNamePrefix = NULLIF(EepNamePrefix,'Z')
        ,drvBirthDate = CASE WHEN BdmRecType = 'EMP' THEN EepDateOfBirth
                                   WHEN BdmRecType = 'DEP' THEN ConDateOfBirth
                                   ELSE EepDateOfBirth
                              END
        ,drvMarialStatus = CASE WHEN eepMaritalStatus  = 'Z' THEN 'U'
                                WHEN eepMaritalStatus  = 'S' THEN 'I'
                                ELSE eepMaritalStatus
                           END
        ,drvGender = EepGender
        ,drvAddressLine1 = dbo.dsi_fnRemoveChars('.,/-',EepAddressLine1)
        ,drvAddressLine2 = dbo.dsi_fnRemoveChars('.,/-',EepAddressLine2)
        ,drvAddressCity = dbo.dsi_fnRemoveChars('.,/-',EepAddressCity)
        ,drvAddressState = EepAddressState
        ,drvAdressZipCode = EepAddressZipCode
        ,drvCountryCode = '840'
        ,drvProvinceCode = ''
        ,drvProvinceName = ''
        ,drvEmpHomePhone = eepphonehomenumber
        ,drvEmailAddress = EepAddressEMail
        ,drvWorkStateCode = (Select Top 1 LocAddressState from Location where LocCode in (EEcLocation)) --EecSITWorkInStateCode
        ,drvEmployeeZipCode = ''
        ,drvEmployeeCountryCode = '840'
        ,drvSuperVisorId =  dbo.dsi_fnlib_GetSupervisorField('', eeceeid, 'EmpNo') 
        ,drvEmployeeStatusDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination ELSE EecDateOfLastHire END
        ,drvEmployeeStatus =  CASE WHEN EecEmplStatus = 'T' THEN 'T'
                                   WHEN EecEmplStatus = 'L' THEN 'L'
                                    ELSE 'A' END
        ,drvEmployeeServiceDate = EEcDateOfBenefitSeniority
        ,drvEmployeeRehireDate = EecDateOfLastHire
        ,drvOriginalHireDate = EecDateOfOriginalHire
        ,drvTerminationReasonCode = ''
        ,drvTerminationReasonDesc = ''
        ,dvEmploymentType = CASE WHEN EecFullTimeOrPartTime = 'P' THEN 'PT' ELSE 'FT' END
        ,drvScheduledHours = REPLACE( (CAST(CONVERT(DECIMAL(10,2),EecScheduledWorkHrs / 2 ) as varchar(12))),'.','')
        ,drvBenefitSalaryAmount =  dbo.dsi_fnRemoveChars('.,',CAST(EecAnnSalary as varchar(12)))
        ,drvSalaryBasis = 'A'
        ,drvSalaryEffectiveDate = dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(EecEEID, EecCOID, '01/01/2010',EecDateOfLastHire)
        ,drvJobTitle = REPLACE(REPLACE((SELECT Top 1JbcDesc FROM JobCode where JbcJobCode = EecJobCode), CHAR(13), ''), CHAR(10), '')
        ,drvLastEightEarning = 'LAST 8 WEEKS EARNINGS'
        ,drvLastFourWeekPayroll =  CAST(CONVERT(DECIMAL(10,2),PehCurAmtOthers) as varchar(12))
        ,drvEEHolidaySchedule = 'FEDERAL CALENDAR EMPLOYEE' --To be set to PahAccrOption
        ,drvClientFiend2Value = CASE WHEN eecorglvl2 = '470' Then '8 HOL FED' END --Set to blank
        ,drvOrgLevelDesc1 = (Select Top 1 Orgdesc from OrgLevel where OrgLvl  =  1 and OrgCode = eecorglvl1)
        ,drvNSTEffectiveDate = CASE WHEN STD = 'STD' THEN STD_BenefitDate END
        ,drvNSTBenStopDate = CASE WHEN STD = 'STD' THEN STD_BenefitStopDate END
        ,drvNSTCoveragePlanOption = CASE WHEN STD = 'STD' THEN
                            CASE WHEN EecSalaryOrHourly = 'H' THEN '60' ELSE  '100' End
                            END 
        ,drvNSTPlanSummary = CASE WHEN STD = 'STD' THEN
                                CASE WHEN EecSalaryOrHourly = 'H'   THEN '1A1' ELSE  '2A1' End
                            END
        /*if EedDedCode = STD and EecSalaryOrHourly = H and EecCoID = TJFST send 10
        if EedDedCode = STD and EecSalaryOrHourly = H and EecCoID = A97O7 send 12
        if EedDedCode = STD and EecSalaryOrHourly = H and EecCoID <> TJFST or A97O7 send 7

        if EedDedCode = STD and EecSalaryOrHourly = S and EecCoID = TJFST send 11
        if EedDedCode = STD and EecSalaryOrHourly = S and EecCoID = A97O7 send 13
        if EedDedCode = STD and EecSalaryOrHourly = S and EecCoID <> TJFST or A97O7 send 9
        */
        ,drvNSTEmployeeGroupId = CASE --WHEN (GLIFE IS NOT NULL OR LTD IS NOT NULL) and EecCOID = 'TJFST' THEN '10'
                                      WHEN STD IS NOT NULL and EecSalaryOrHourly = 'H' and EecCOID = 'TJFST' THEN '10'
                                      --WHEN (GLIFE IS NOT NULL OR LTD IS NOT NULL) and EecCOID = 'A97O7' THEN '12'
                                      WHEN STD IS NOT NULL and EecSalaryOrHourly = 'H' and EecCOID = 'A97O7' THEN '12'
                                      WHEN STD IS NOT NULL and EecSalaryOrHourly = 'H' and EecCOID NOT IN ( 'TJFST','A97O7') THEN '7'
                                      WHEN STD IS NOT NULL and EecSalaryOrHourly = 'S' and EecCOID = 'TJFST' THEN '11'
                                      WHEN STD IS NOT NULL and EecSalaryOrHourly = 'S' and EecCOID = 'A97O7' THEN '13'
                                      WHEN STD IS NOT NULL and EecSalaryOrHourly = 'S' and EecCOID NOT IN ( 'TJFST','A97O7') THEN '9'
                                 END
        ,drvNSTEmployeeeClassCode = CASE WHEN STD IS NOT NULL THEN '1' END
        ,drvSTACoverageEffectiveDate = CASE WHEN STD = 'STD' AND (Select Top 1 LocAddressState from Location where LocCode in (EEcLocation)) IN ('HI','NY') THEN STD_BenefitDate END
        ,drvSTACoverageTerminationDate = CASE WHEN STD = 'STD' AND (Select Top 1 LocAddressState from Location where LocCode in (EEcLocation)) IN ('HI','NY') THEN STD_BenefitStopDate END
        ,drvSTAPlanCoverageOption = CASE WHEN STD = 'STD' AND (Select Top 1 LocAddressState from Location where LocCode in (EEcLocation)) = 'HI' THEN 'HI'
                                    WHEN STD = 'STD' AND (Select Top 1 LocAddressState from Location where LocCode in (EEcLocation)) = 'NY' THEN 'NY'
                                     END

        ,drvSTAPlanSummary = CASE WHEN STD IS NOT NULL and (Select Top 1 LocAddressState from Location where LocCode in (EEcLocation)) = 'HI'  THEN '4C1'
                                   WHEN STD IS NOT NULL and (Select Top 1 LocAddressState from Location where LocCode in (EEcLocation)) = 'NY'  THEN '3C1'
                                 END
        /* 
        if EedDedCode = STD and EecCoID <> A97O7 and LocAddressState in eeclocation = NY send 15
if EedDedCode = STD and EecCoID = A97O7 and LocAddressState in eeclocation = NY send 16
if EedDedCode = STD and EecCoID <> HTEZ2 and LocAddressState in eeclocation = HI send 17
if EedDedCode = STD and EecCoID = HTEZ2 and LocAddressState in eeclocation = HI send 18
*/
        ,drvSTAEmployeeGroupId = CASE WHEN STD IS NOT NULL and (Select Top 1 LocAddressState from Location where LocCode in (EEcLocation)) IN ('NY') and EecCOID NOT IN ('A97O7') THEN '15'
                                      WHEN STD IS NOT NULL and (Select Top 1 LocAddressState from Location where LocCode in (EEcLocation)) IN ('NY') and EecCOID  IN ('A97O7') THEN '16'
                                      WHEN STD IS NOT NULL and (Select Top 1 LocAddressState from Location where LocCode in (EEcLocation)) IN ('HI') and EecCOID  NOT IN ('HTEZ2') THEN '17'
                                      WHEN STD IS NOT NULL and (Select Top 1 LocAddressState from Location where LocCode in (EEcLocation)) IN ('HI') and EecCOID   IN ('HTEZ2') THEN '18'
                                END
        ,drvSTAEmployeeClassCode = CASE WHEN STD = 'STD' AND (Select Top 1 LocAddressState from Location where LocCode in (EEcLocation)) IN ('HI','NY') THEN '1' END
        ,drvLTDCoverageEffectiveDate = CASE WHEN LTD = 'LTD' THEN LTD_BenefitDate END
        ,drvLTDCoverageTerminationDate = CASE WHEN LTD = 'LTD' THEN LTD_BenefitStopDate END
        ,drvLTDCoveragePlanOption =  CASE WHEN LTD = 'LTD' THEN '60' END
        ,drvLTDPlanSummary = CASE WHEN LTD IS NOT NULL THEN 
                                  CASE WHEN  (Select Top 1 jbceeogroup from JobCode where JbcJobCode  in (EecJobCode) ) IN ('11','10X') THEN '1B1'
                                  WHEN  (Select Top 1 jbceeogroup from JobCode where JbcJobCode  in (EecJobCode) ) IN ( '12', '21', '22', '23' , '4') THEN '1B2'
                                  ELSE  '1B3'
                                END
                             END
        ,drvLTDEmployeeGroupId = CASE WHEN LTD IS NOT NULL and EecCoID = 'TJFST' THEN '10'
                              WHEN LTD IS NOT NULL and EecCoID = 'A97O7' THEN '12'
                              WHEN LTD IS NOT NULL THEN '7'
                         END
        ,drvLTDEmployeeClassCode = CASE WHEN LTD IS NOT NULL THEN 
                                    CASE WHEN  (Select Top 1 jbceeogroup from JobCode where JbcJobCode  in (EecJobCode) ) = '11' THEN '1'
                                      WHEN  (Select Top 1 jbceeogroup from JobCode where JbcJobCode  in (EecJobCode) ) IN ( '12', '21', '22', '23' , '4') THEN '2'
                                      ELSE  '3'
                                END
                             END
        ,drvReportingLevel1 =  eecorglvl2
        ,drvBLFEffectiveDate = CASE WHEN GLIFE IS NOT NULL and BdmRecType = 'EMP' THEN GLIFE_BenefitDate END
        ,drvBLFTerminationDate = CASE WHEN GLIFE IS NOT NULL and BdmRecType = 'EMP' THEN GLIFE_BenefitStopDate END
        ,drvBLFAmount =  CASE WHEN GLIFE IS NOT NULL and BdmRecType = 'EMP' THEN CAST(CONVERT(DECIMAL(12,0), CASE WHEN GLIFE_BenAmt <= 0 THEN ( (select Top 1 PdhDedCalcBasisAmt from pdedhist where pdheeid = xeeid and pdhcoid = xcoid and pdhdedcode = 'GLIFE')) ELSE GLIFE_BenAmt END) as VARCHAR(12)) END
        ,drvBLFGroupId = CASE WHEN GLIFE IS NOT NULL and EecCoID = 'TJFST' THEN '10'
                              WHEN GLIFE IS NOT NULL and EecCoID = 'A97O7' THEN '12'
                              WHEN GLIFE IS NOT NULL THEN '7'
                         END
        ,drvBLFClassCode = CASE WHEN GLIFE IS NOT NULL and BdmRecType = 'EMP' THEN '1' END
        ,drvBADEffectiveDate = CASE WHEN GLIFE IS NOT NULL and BdmRecType = 'EMP' THEN GLIFE_BenefitDate END
        ,drvBADTerminationDate = CASE WHEN GLIFE IS NOT NULL and BdmRecType = 'EMP' THEN GLIFE_BenefitStopDate END
        ,drvBADAmount = CASE WHEN GLIFE IS NOT NULL and BdmRecType = 'EMP' THEN CAST(CONVERT(DECIMAL(12,0),CASE WHEN GLIFE_BenAmt <= 0 THEN ((select Top 1 PdhDedCalcBasisAmt from pdedhist where pdheeid = xeeid and pdhcoid = xcoid and pdhdedcode = 'GLIFE')) ELSE GLIFE_BenAmt END) as VARCHAR(12)) END
        ,drvBADGroupId = CASE WHEN GLIFE IS NOT NULL and EecCoID = 'TJFST' THEN '10'
                              WHEN GLIFE IS NOT NULL and EecCoID = 'A97O7' THEN '12'
                              WHEN GLIFE IS NOT NULL THEN '7'
                         END
        ,drvBADClassCode = CASE WHEN GLIFE IS NOT NULL THEN '1' END
        ,drvLIFEffectiveDate = CASE WHEN LIFEE IS NOT NULL and BdmRecType = 'EMP' THEN LIFEE_BenefitDate END
        ,drvLIFTerminationDate = CASE WHEN LIFEE IS NOT NULL and BdmRecType = 'EMP' THEN LIFEE_BenefitStopDate END
        ,drvLIFAmount  = CASE WHEN LIFEE IS NOT NULL and BdmRecType = 'EMP' THEN CAST(CONVERT(DECIMAL(12,0),LIFEE_BenAmt) as VARCHAR(12)) END
        ,drvLIFSuppLifeAmt  = CASE WHEN LIFEE IS NOT NULL and BdmRecType = 'EMP' THEN CAST( CONVERT(DECIMAL(12,0),
        CASE WHEN (select top 1 EedEOIDesiredAmt from empded where  eedeeid = xeeid  and eedcoid =  xcoid and eeddedcode = 'LIFEE') <= 0 THEN 
            (select top 1 EdhEEBenAmt from EMpHDed where edheeid = xeeid and edhcoid = xcoid and edhdedcode  = 'LIFEE' and edheebenamt > 0 order by edheffdate desc)
            ELSE (select top 1 EedEOIDesiredAmt from empded where  eedeeid = xeeid  and eedcoid =  xcoid and eeddedcode = 'LIFEE')
        END
        ) as varchar(12)) END
        ,drvLIFGroupId = CASE WHEN LIFEE IS NOT NULL and EecCoID = 'TJFST' THEN '10'
                              WHEN LIFEE IS NOT NULL and EecCoID = 'A97O7' THEN '12'
                              WHEN LIFEE IS NOT NULL THEN '7'
                         END
        ,drvLIFClassCode = CASE WHEN LIFEE IS NOT NULL and BdmRecType = 'EMP' THEN '1' END
        ,drvADDEffectiveDate = CASE WHEN LIFEE IS NOT NULL and BdmRecType = 'EMP' THEN LIFEE_BenefitDate END
        ,drvADDTerminationDate = CASE WHEN LIFEE IS NOT NULL and BdmRecType = 'EMP' THEN LIFEE_BenefitStopDate END
        ,drvADDAmount  = CASE WHEN LIFEE IS NOT NULL and BdmRecType = 'EMP' THEN CAST(CONVERT(DECIMAL(12,0),LIFEE_BenAmt) as VARCHAR(12)) END
        ,drvAddSuppReqAmt =  CASE WHEN LIFEE IS NOT NULL and BdmRecType = 'EMP' THEN CAST( CONVERT(DECIMAL(12,0),
        CASE WHEN (select top 1 EedEOIDesiredAmt from empded where  eedeeid = xeeid  and eedcoid =  xcoid and eeddedcode = 'LIFEE') <= 0 THEN 
            (select top 1 EdhEEBenAmt from EMpHDed where edheeid = xeeid and edhcoid = xcoid and edhdedcode  = 'LIFEE' and edheebenamt > 0 order by edheffdate desc)
            ELSE (select top 1 EedEOIDesiredAmt from empded where  eedeeid = xeeid  and eedcoid =  xcoid and eeddedcode = 'LIFEE')
        END
        ) as varchar(12)) END
        ,drvADDGroupId = CASE WHEN LIFEE IS NOT NULL and EecCoID = 'TJFST' THEN '10'
                              WHEN LIFEE IS NOT NULL and EecCoID = 'A97O7' THEN '12'
                              WHEN LIFEE IS NOT NULL THEN '7'
                         END
        ,drvADDClassCode = CASE WHEN LIFEE IS NOT NULL and BdmRecType = 'DEP' THEN '1' END
        ,drvSPLEffectiveDate = CASE WHEN LIFES IS NOT NULL and BdmRecType = 'EMP' THEN LIFES_BenefitDate END
        ,drvSPLTerminationDate = CASE WHEN LIFES IS NOT NULL and BdmRecType = 'EMP' THEN LIFES_BenefitStopDate END
        ,drvSPLAmount  = CASE WHEN LIFES IS NOT NULL and BdmRecType = 'EMP' THEN  CAST( (CONVERT(DECIMAL(12,0),(CAST( (select TOP 1 BdmUSGField1 from U_dsi_BDM_EHRTSLFEXP A  where A.bdmeeid = xeeid and bdmDedcode = 'LIFES' and bdmrectype = 'EMP') as MONEY)))) as varchar(12)) END
        ,drvSPLReqAmount = CASE WHEN LIFES IS NOT NULL and BdmRecType = 'EMP' THEN CAST( CONVERT(DECIMAL(12,0),
        CASE WHEN (select top 1 EedEOIDesiredAmt from empded where  eedeeid = xeeid  and eedcoid =  xcoid and eeddedcode = 'LIFES') <= 0 THEN 
            (select top 1 EdhEEBenAmt from EMpHDed where edheeid = xeeid and edhcoid = xcoid and edhdedcode  = 'LIFES'  and edheebenamt > 0 order by edheffdate desc)
            ELSE (select top 1 EedEOIDesiredAmt from empded where  eedeeid = xeeid  and eedcoid =  xcoid and eeddedcode = 'LIFES')
        END
        ) as varchar(12)) END
        ,drvSPLGroupId = CASE WHEN LIFES IS NOT NULL and EecCoID = 'TJFST' AND BdmRecType = 'EMP' THEN '10'
                              WHEN LIFES IS NOT NULL and EecCoID = 'A97O7' AND BdmRecType = 'EMP' THEN '12'
                              WHEN LIFES IS NOT NULL AND BdmRecType = 'EMP' THEN '7'
                         END
        ,drvSPLClassCode = CASE WHEN LIFES IS NOT NULL and BdmRecType = 'EMP' THEN '1' END
        ,drvDPLEffectiveDate = CASE WHEN LIFEC IS NOT NULL and BdmRecType = 'DEP' THEN LIFEC_BenefitDate END
        ,drvDPLTerminationDate = CASE WHEN LIFEC IS NOT NULL and BdmRecType = 'DEP' THEN LIFEC_BenefitStopDate END
        ,drvDPLAmount  = CASE WHEN LIFEC IS NOT NULL and BdmRecType = 'DEP' THEN CAST( (CONVERT(DECIMAL(12,0),(CAST( (select TOP 1 BdmUSGField1 from U_dsi_BDM_EHRTSLFEXP A  where A.bdmeeid = xeeid and bdmDedcode = 'LIFEC' and bdmrectype = 'EMP') as MONEY)))) as varchar(12)) END
        ,drvDPLGroupId = CASE WHEN LIFEC IS NOT NULL and EecCoID = 'TJFST'  AND BdmRecType = 'DEP' THEN '10'
                              WHEN LIFEC IS NOT NULL and EecCoID = 'A97O7' AND BdmRecType = 'DEP' THEN '12'
                              WHEN LIFEC IS NOT NULL AND BdmRecType = 'DEP' THEN '7'
                         END
        ,drvDPLClassCode = CASE WHEN LIFEC IS NOT NULL and BdmRecType = 'DEP' THEN '1' END

        ,drvLeaveMangementIndicator = 'Y'
        ,drvLast12MonthsHours = dbo.dsi_fnRemoveChars('.,',CAST(cast(PehCurHrsYTD as decimal(10,2)) as varchar(10)) )
        ,drvFileGerationDate = @RunDate
    INTO dbo.U_EHRTSLFEXP_drvTbl
    FROM dbo.U_EHRTSLFEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
            and (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                                      and EXISTS(select 1 from dbo.U_EHRTSLFEXP_Audit where  audKey1Value = xEEID AND audKey2Value = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    LEFT JOIN  (select  bdmEEID,bdmcoid,bdmrectype,bdmdeprecid
            ,LTD = MAX((CASE WHEN bdmDedCode = 'LTD' then bdmDedCode END))
            ,STD = MAX((CASE WHEN bdmDedCode IN ('STD','SALCO') then 'STD' END))
            ,LIFES = MAX((CASE WHEN bdmDedCode = 'LIFES' then bdmDedCode END))
            ,LIFEC = MAX((CASE WHEN bdmDedCode = 'LIFEC' then bdmDedCode END))
            ,GLIFE = MAX((CASE WHEN bdmDedCode = 'GLIFE' then bdmDedCode END))
            ,LIFEE = MAX((CASE WHEN bdmDedCode = 'LIFEE' then bdmDedCode END))
            ,LTD_BenefitDate = MAX((CASE WHEN bdmDedCode = 'LTD' then  bdmBenStartDate END))
            ,STD_BenefitDate = MAX((CASE WHEN bdmDedCode  IN ('STD','SALCO') then  bdmBenStartDate END))
            ,GLIFE_BenefitDate = MAX((CASE WHEN bdmDedCode = 'GLIFE' then  bdmBenStartDate END))
            ,LIFEE_BenefitDate = MAX((CASE WHEN bdmDedCode = 'LIFEE' then  bdmBenStartDate END))
            ,LIFES_BenefitDate = MAX((CASE WHEN bdmDedCode = 'LIFES' then  bdmBenStartDate END))
            ,LIFEC_BenefitDate = MAX((CASE WHEN bdmDedCode = 'LIFEC' then  bdmBenStartDate END))
            ,LTD_BenefitStopDate = MAX((CASE WHEN bdmDedCode = 'LTD' then  bdmBenStopDate END))
            ,STD_BenefitStopDate = MAX((CASE WHEN bdmDedCode  IN ('STD','SALCO') then  bdmBenStopDate END))
            ,GLIFE_BenefitStopDate = MAX((CASE WHEN bdmDedCode = 'GLIFE' then  bdmBenStopDate END))
            ,LIFEE_BenefitStopDate = MAX((CASE WHEN bdmDedCode = 'LIFEE' then  bdmBenStopDate END))
            ,LIFES_BenefitStopDate = MAX((CASE WHEN bdmDedCode = 'LIFES' then  bdmBenStopDate END))
            ,LIFEC_BenefitStopDate = MAX((CASE WHEN bdmDedCode = 'LIFEC' then  bdmBenStopDate END))
            ,GLIFE_BenAmt = MAX((CASE WHEN bdmDedCode = 'GLIFE' then  CAST(BdmUSGField1 as MONEY) END))
            ,LIFEE_BenAmt = MAX((CASE WHEN bdmDedCode = 'LIFEE' then  CAST(BdmUSGField1 as MONEY) END))
            ,LIFES_BenAmt = MAX((CASE WHEN bdmDedCode = 'LIFES' then  CAST(BdmUSGField1 as MONEY) END))
            ,LIFEC_BenAmt = MAX((CASE WHEN bdmDedCode = 'LIFEC' then  CAST(BdmUSGField1 as MONEY) END))
            from U_dsi_BDM_EHRTSLFEXP group by bdmEEID,bdmcoid,bdmrectype,bdmdeprecid ) as ConsolidatedBDM
        ON bdmEEID = xEEID 
        AND bdmCoID = xCoID
    LEFT JOIN dbo.U_EHRTSLFEXP_PEarHist 
     ON PehEEID = xEEID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID;
    ;


    Delete from U_EHRTSLFEXP_drvTbl where drveeid not in (
        SELECT eeceeid FROM dbo.empcomp where eeceetype in  ('REG','INT')
    );

    Delete from U_EHRTSLFEXP_drvTbl where drvEmployeeId = '001111';

    Update U_EHRTSLFEXP_drvTbl  set  drvDPLAmount =   CAST( (CONVERT(DECIMAL(12,0),(CAST( (select DedEEBenAmt from dedcode where deddedcode = 'LIFEC' ) as MONEY)))) as varchar(12)) where  drvDPLEffectiveDate is not null and ISNULL(drvDPLAmount,'0') = '0'  and drvTransactionCode = 'D'
    Update U_EHRTSLFEXP_drvTbl set  drvBLFAmount  = '50000'  where drvBLFEffectiveDate is not null and drvBLFAmount is null
    Update U_EHRTSLFEXP_drvTbl set  drvBADAmount  = '50000'  where drvBADEffectiveDate is not null and drvBADAmount is null
    Update U_EHRTSLFEXP_drvTbl set drvLIFSuppLifeAmt = drvLIFAmount  where drvLIFEffectiveDate is not null and drvLIFSuppLifeAmt is null or drvLIFSuppLifeAmt = 0
    Update U_EHRTSLFEXP_drvTbl set  drvAddSuppReqAmt = drvADDAmount  where drvADDEffectiveDate is not null and drvAddSuppReqAmt is null or drvAddSuppReqAmt = 0
     Update U_EHRTSLFEXP_drvTbl set  drvSPLReqAmount = drvSPLAmount  where drvSPLEffectiveDate is not null and drvSPLReqAmount is null or drvSPLReqAmount = 0 
     

    --Update U_EHRTSLFEXP_drvTbl set  drvLastFourWeekPayroll = '$'  + drvLastFourWeekPayroll  where drvLastFourWeekPayroll is not null 
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EHRTSLFEXP_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EHRTSLFEXP_Header;
    SELECT DISTINCT
         drvFileName = @Filename
        ,drvDateFileCreated =  Format(GetDate(), 'yyyyMMdd hh:mm:ss tt')
        ,drvCustomerName = 'APPRISS'
        ,drvFileVersion = '2'
    INTO dbo.U_EHRTSLFEXP_Header
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EHRTSLFEXP_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_EHRTSLFEXP_Trailer;
    SELECT DISTINCT
         drvRecordCount = CAST( (Select count(*) from dbo.U_EHRTSLFEXP_drvTbl (NOLOCK) ) AS VARCHAR(50))
    INTO dbo.U_EHRTSLFEXP_Trailer
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
ALTER VIEW dbo.dsi_vwEHRTSLFEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EHRTSLFEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EHRTSLFEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201910081'
       ,expStartPerControl     = '201910081'
       ,expLastEndPerControl   = '201910159'
       ,expEndPerControl       = '201910159'
WHERE expFormatCode = 'EHRTSLFEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEHRTSLFEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EHRTSLFEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort