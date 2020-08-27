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
@CustomFormatCode - Replace with Format Code (i.e., EAETNABMS)
@CustomFormatName - Replace with Name of Interface (AdfFormatName) (i.e., Aetna BMS LIFE Export)
@IsWebFlag - Replace with 'Y' (Yes) or 'N' (No) for Web Interface Settings

-- File parameters
@FileExportPath - Replace with the Export Path where the file generates to (i.e., \\us.saas\e1\Public\[Client ARNum]\Exports\[Vendor]\)
@TestFilePath - Replace with the Test Path where the file generates to (i.e., \\us.saas\e1\Public\[Client ARNum]\Exports\[Vendor]\)

-- Data parameters
@DeductionCodeList - Replace with Deduction Codes in CSV format (i.e., DED1,DED2,DED3)
@ControlNumber - Replace with Control Number
@FileNamePreFix - Replace with client prefix for filename

*/
IF OBJECT_ID('dsi_vw@CustomFormatCode_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vw@CustomFormatCode_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_@CustomFormatCode') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_@CustomFormatCode];
GO
IF OBJECT_ID('U_@CustomFormatCode_File') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_File];
GO
IF OBJECT_ID('U_@CustomFormatCode_EEList') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_EEList];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl];
GO
IF OBJECT_ID('U_@CustomFormatCode_Audit') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_Audit];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = '@CustomFormatCode';
DELETE [dbo].[U_dsi_RecordSetDetails] FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode = '@CustomFormatCode';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = '@CustomFormatCode';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = '@CustomFormatCode';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = '@CustomFormatCode';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = '@CustomFormatCode';
GO

DECLARE @AdhSystemID VARCHAR(12), @FixedFormatName VARCHAR(50);
SET @AdhSystemID = LEFT('@CustomFormatCode' + REPLICATE('0',10),10) + 'Z0';
SET @FixedFormatName = LEFT('@CustomFormatName',50);

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) SELECT 'N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','@CustomFormatCode',@FixedFormatName,'N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','600','S','N',@AdhSystemID,'N','Jan  1 1900 12:00AM','C','N',NULL,'N';
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"47"','1','(''DA''=''F'')',@AdhSystemID,'2','D','10','1',NULL,'RECORD TYPE.',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','2','(''DN0''=''F'')',@AdhSystemID,'15','D','10','3',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvEnrolleeEffDate"','3','(''UD112''=''F'')',@AdhSystemID,'8','D','10','18',NULL,'EFFECTIVE DATE OF ENROLLEE RECORD',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvSSN"','4','(''UA''=''F'')',@AdhSystemID,'10','D','10','26',NULL,'ENROLLEE SSN / CERT',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvEnrolleeStatus"','5','(''UA''=''F'')',@AdhSystemID,'2','D','10','36',NULL,'ENROLLEE STATUS',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvDateOfLastHire"','6','(''UD12''=''F'')',@AdhSystemID,'6','D','10','38',NULL,'DATE OF HIRE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvDOHCentury"','7','(''UA''=''F'')',@AdhSystemID,'2','D','10','44',NULL,'DOH-CENTURY',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"0"','8','(''DA''=''F'')',@AdhSystemID,'1','D','10','46',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','9','(''SS''=''F'')',@AdhSystemID,'3','D','10','47',NULL,'PLAN NUMBER-',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvGender"','10','(''UA''=''F'')',@AdhSystemID,'1','D','10','50',NULL,'SEX',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvEnrolleeDOB"','11','(''UD112''=''F'')',@AdhSystemID,'8','D','10','51',NULL,'ENROLLEE BIRTH DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvEnrolleeName"','12','(''UA''=''F'')',@AdhSystemID,'26','D','10','59',NULL,'ENROLLEE NAME.',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','13','(''DN0''=''F'')',@AdhSystemID,'11','D','10','85',NULL,'Filler',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','14','(''DN0''=''F'')',@AdhSystemID,'6','D','10','96',NULL,'SPOUSE BIRTH DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"0"','15','(''DA''=''F'')',@AdhSystemID,'1','D','10','102',NULL,'Filler',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','16','(''SS''=''F'')',@AdhSystemID,'1','D','10','103',NULL,'ENROLLEE SMOKING STATUS',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','17','(''SS''=''F'')',@AdhSystemID,'1','D','10','104',NULL,'EOI REQUIRED FLAG',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"1"','18','(''DA''=''F'')',@AdhSystemID,'1','D','10','105',NULL,'EARNINGS TYPE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvSalary"','19','(''UN0''=''F'')',@AdhSystemID,'7','D','10','106',NULL,'EARNINGS',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvDateLastWorked"','20','(''UD112''=''F'')',@AdhSystemID,'8','D','10','113',NULL,'DATE LAST WORKED',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"00"','21','(''DA''=''F'')',@AdhSystemID,'2','D','10','121',NULL,'SPOUSE DOB-CENTURY',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','22','(''SS''=''F'')',@AdhSystemID,'1','D','10','123',NULL,'SPOUSE SMOKING STATUS',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','23','(''SS''=''F'')',@AdhSystemID,'7','D','10','124',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvAddressLine1"','24','(''UA''=''F'')',@AdhSystemID,'35','D','10','131',NULL,'MAILING ADDRESS LINE 1 -.',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvAddressLine2"','25','(''UA''=''F'')',@AdhSystemID,'35','D','10','166',NULL,'MAILING ADDRESS LINE 2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','26','(''SS''=''F'')',@AdhSystemID,'8','D','10','201',NULL,'CUSTOMER SPECIFIC',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','27','(''DN0''=''F'')',@AdhSystemID,'9','D','10','209',NULL,'TOTAL REQUESTED EE COVG (TRM3)-PENDING EOI APPROVA',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','28','(''DN0''=''F'')',@AdhSystemID,'9','D','10','218',NULL,'TOTAL REQUESTED SP COVG (TRM4) - PENDING EOI APPRO',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','29','(''DN0''=''F'')',@AdhSystemID,'9','D','10','227',NULL,'TOTAL REQUESTED CH COVG (TRM5)- PENDING EOI APPROV',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvAddressCity"','30','(''UA''=''F'')',@AdhSystemID,'21','D','10','236',NULL,'MAILING ADDRESS CITY',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvAddressState"','31','(''UA''=''F'')',@AdhSystemID,'2','D','10','257',NULL,'MAILING ADDRESS STATE.',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvAddressZipCode"','32','(''UA''=''F'')',@AdhSystemID,'9','D','10','259',NULL,'MAILING ADDRESS ZIP CODE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvSalaryOrHourly"','33','(''UA''=''F'')',@AdhSystemID,'1','D','10','268',NULL,'HOURLY/SALARY INDICATOR',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvPhoneBusinessNumber"','34','(''UA''=''F'')',@AdhSystemID,'11','D','10','269',NULL,'WORK TELEPHONE NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvPhoneHomeNumber"','35','(''UA''=''F'')',@AdhSystemID,'11','D','10','280',NULL,'HOME TELEPHONE NUMBER -',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','36','(''SS''=''F'')',@AdhSystemID,'22','D','10','291',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvCovCode1"','37','(''UA''=''F'')',@AdhSystemID,'4','D','10','313',NULL,'COVERAGE CODE(1)',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvCovEffDate1"','38','(''UA''=''F'')',@AdhSystemID,'8','D','10','317',NULL,'COVERAGE  EFFECTIVE DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvCovCtrlNo1"','39','(''UA''=''F'')',@AdhSystemID,'7','D','10','325',NULL,'CONTROL NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvSuffix1"','40','(''UA''=''F'')',@AdhSystemID,'3','D','10','332',NULL,'SUFFIX',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvAccount1"','41','(''UA''=''F'')',@AdhSystemID,'5','D','10','335',NULL,'ACCOUNT',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvCovBenAmt1"','42','(''UN0''=''F'')',@AdhSystemID,'9','D','10','340',NULL,'COVERAGE BENEFIT AMOUNT',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvCovCode2"','43','(''UA''=''F'')',@AdhSystemID,'4','D','10','349',NULL,'COVERAGE CODE(2)',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvCovEffDate2"','44','(''UA''=''F'')',@AdhSystemID,'8','D','10','353',NULL,'COVERAGE  EFFECTIVE DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvCovCtrlNo2"','45','(''UA''=''F'')',@AdhSystemID,'7','D','10','361',NULL,'CONTROL NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvSuffix2"','46','(''UA''=''F'')',@AdhSystemID,'3','D','10','368',NULL,'SUFFIX',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvAccount2"','47','(''UA''=''F'')',@AdhSystemID,'5','D','10','371',NULL,'ACCOUNT',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvCovBenAmt2"','48','(''UN0''=''F'')',@AdhSystemID,'9','D','10','376',NULL,'COVERAGE BENEFIT AMOUNT',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvCovCode3"','49','(''UA''=''F'')',@AdhSystemID,'4','D','10','385',NULL,'COVERAGE CODE(3)',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvCovEffDate3"','50','(''UA''=''F'')',@AdhSystemID,'8','D','10','389',NULL,'COVERAGE  EFFECTIVE DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvCovCtrlNo3"','51','(''UA''=''F'')',@AdhSystemID,'7','D','10','397',NULL,'CONTROL NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvSuffix3"','52','(''UA''=''F'')',@AdhSystemID,'3','D','10','404',NULL,'SUFFIX',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvAccount3"','53','(''UA''=''F'')',@AdhSystemID,'5','D','10','407',NULL,'ACCOUNT',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvCovBenAmt3"','54','(''UN0''=''F'')',@AdhSystemID,'9','D','10','412',NULL,'COVERAGE BENEFIT AMOUNT',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvCovCode4"','55','(''UA''=''F'')',@AdhSystemID,'4','D','10','421',NULL,'COVERAGE CODE(4)',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvCovEffDate4"','56','(''UA''=''F'')',@AdhSystemID,'8','D','10','425',NULL,'COVERAGE  EFFECTIVE DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvCovCtrlNo4"','57','(''UA''=''F'')',@AdhSystemID,'7','D','10','433',NULL,'CONTROL NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvSuffix4"','58','(''UA''=''F'')',@AdhSystemID,'3','D','10','440',NULL,'SUFFIX',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvAccount4"','59','(''UA''=''F'')',@AdhSystemID,'5','D','10','443',NULL,'ACCOUNT',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvCovBenAmt4"','60','(''UN0''=''F'')',@AdhSystemID,'9','D','10','448',NULL,'COVERAGE BENEFIT AMOUNT',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvCovCode5"','61','(''UA''=''F'')',@AdhSystemID,'4','D','10','457',NULL,'COVERAGE CODE(5)',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvCovEffDate5"','62','(''UA''=''F'')',@AdhSystemID,'8','D','10','461',NULL,'COVERAGE  EFFECTIVE DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvCovCtrlNo5"','63','(''UA''=''F'')',@AdhSystemID,'7','D','10','469',NULL,'CONTROL NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvSuffix5"','64','(''UA''=''F'')',@AdhSystemID,'3','D','10','476',NULL,'SUFFIX',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvAccount5"','65','(''UA''=''F'')',@AdhSystemID,'5','D','10','479',NULL,'ACCOUNT',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvCovBenAmt5"','66','(''UN0''=''F'')',@AdhSystemID,'9','D','10','484',NULL,'COVERAGE BENEFIT AMOUNT',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvCovCode6"','67','(''UA''=''F'')',@AdhSystemID,'4','D','10','493',NULL,'COVERAGE CODE(6)',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvCovEffDate6"','68','(''UA''=''F'')',@AdhSystemID,'8','D','10','497',NULL,'COVERAGE  EFFECTIVE DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvCovCtrlNo6"','69','(''UA''=''F'')',@AdhSystemID,'7','D','10','505',NULL,'CONTROL NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvSuffix6"','70','(''UA''=''F'')',@AdhSystemID,'3','D','10','512',NULL,'SUFFIX',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvAccount6"','71','(''UA''=''F'')',@AdhSystemID,'5','D','10','515',NULL,'ACCOUNT',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvCovBenAmt6"','72','(''UN0''=''F'')',@AdhSystemID,'9','D','10','520',NULL,'COVERAGE BENEFIT AMOUNT',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','73','(''SS''=''F'')',@AdhSystemID,'4','D','10','529',NULL,'COVERAGE CODE(7)',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','74','(''DN0''=''F'')',@AdhSystemID,'8','D','10','533',NULL,'COVERAGE  EFFECTIVE DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','75','(''DN0''=''F'')',@AdhSystemID,'7','D','10','541',NULL,'CONTROL NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','76','(''DN0''=''F'')',@AdhSystemID,'3','D','10','548',NULL,'SUFFIX',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','77','(''DN0''=''F'')',@AdhSystemID,'5','D','10','551',NULL,'ACCOUNT',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','78','(''DN0''=''F'')',@AdhSystemID,'9','D','10','556',NULL,'COVERAGE BENEFIT AMOUNT',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','79','(''SS''=''F'')',@AdhSystemID,'4','D','10','565',NULL,'COVERAGE CODE(8)',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','80','(''DN0''=''F'')',@AdhSystemID,'8','D','10','569',NULL,'COVERAGE  EFFECTIVE DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','81','(''DN0''=''F'')',@AdhSystemID,'7','D','10','577',NULL,'CONTROL NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','82','(''DN0''=''F'')',@AdhSystemID,'3','D','10','584',NULL,'SUFFIX',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','83','(''DN0''=''F'')',@AdhSystemID,'5','D','10','587',NULL,'ACCOUNT',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','84','(''DN0''=''F'')',@AdhSystemID,'9','D','10','592',NULL,'COVERAGE BENEFIT AMOUNT',NULL,NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','201707019','EMPEXPORT','SCHEDULED',NULL,'@CustomFormatCode',NULL,NULL,NULL,'201707019','Jul  1 2017 11:13AM','Jul  1 2017 11:13AM','201707011',NULL,'','','201707011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','201707019','EMPEXPORT','OEACTIVE',NULL,'@CustomFormatCode',NULL,NULL,NULL,'201707019','Jul  1 2017 11:13AM','Jul  1 2017 11:13AM','201707011',NULL,'','','201707011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','201707019','EMPEXPORT','OEPASSIVE',NULL,'@CustomFormatCode',NULL,NULL,NULL,'201707019','Jul  1 2017 11:13AM','Jul  1 2017 11:13AM','201707011',NULL,'','','201707011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Aetna BMS LIFE Export','201707019','EMPEXPORT','ONDEMAND','Jul  1 2017  9:25AM','@CustomFormatCode',NULL,NULL,NULL,'201707019','Jul  1 2017 12:00AM','Dec 30 1899 12:00AM','201701011',NULL,'','','201701011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Test Purposes Only','201707019','EMPEXPORT','TEST','Jul  1 2017 12:00AM','@CustomFormatCode',NULL,NULL,NULL,'201707019','Jul  1 2017 12:00AM','Dec 30 1899 12:00AM','201707011',NULL,'','','201707011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','ExportPath','V','@FileExportPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','InitialSort','C','DrvSSN');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','TestPath','V','@TestFilePath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','UDESPath','C','@FileExportPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','Upper','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','UseFileName','V','N');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D10','dbo.U_@CustomFormatCode_drvTbl',NULL);
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
    [Data] char(600) NULL
);
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

Purpose: @CustomFormatName

Revision History
-----------------
Update By            Date            SF Num            Desc

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.AscExp WHERE expFormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = '@CustomFormatCode' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'TEST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'SCHEDULED';

EXEC dbo.dsi_BDM_sp_ErrorCheck '@CustomFormatCode';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = '@CustomFormatCode', @AllObjects = 'Y'
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

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = CASE WHEN ExportCode = 'SCHEDULED' THEN DATEADD(DD,-14,GETDATE())
                                 ELSE CAST(LEFT(StartPerControl,8) AS DATETIME)
                            END
        ,@EndDate         = CASE WHEN ExportCode = 'SCHEDULED' THEN GETDATE()
                                 ELSE CAST(LEFT(EndPerControl,8) AS DATETIME)
                            END
        ,@FormatCode      = FormatCode
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = '@CustomFormatCode';

    --==========================================
    -- Audit Section
    --==========================================

    -- Audit Terms
    IF OBJECT_ID('U_@CustomFormatCode_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_Audit;
    SELECT 
         audEEID = audKey1Value
        ,audCoID = audKey2Value
        ,audOldValue
        ,audNewValue
    INTO dbo.U_@CustomFormatCode_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audTableName = 'EmpComp'
    AND audFieldName = 'EecEmplStatus'
    AND audNewValue = 'T';

    --==========================================
    -- Clean EE List
    --==========================================

	-- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_@CustomFormatCode_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCoID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_@CustomFormatCode_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

	-- Remove Terminated Employees NOT Found in Audit
    DELETE FROM dbo.U_@CustomFormatCode_EEList
    WHERE NOT EXISTS (SELECT 1 FROM dbo.U_@CustomFormatCode_Audit WHERE audEEID = xEEID AND audCOID = xCOID);

    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'DedCodes','@DeductionCodeList');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'TermSelectionOption','AuditDate');

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
    EXEC dbo.dsi_bdm_sp_PopulateDeductionsTable @FormatCode;

    EXEC dbo.dsi_bdm_sp_CalculateBenefitAmounts @FormatCode;

    --==========================================
    -- Build Employee Data and the driver tables
    --==========================================

    ---------------------------------
    -- Working Table - Mappings
    ---------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_Mapping','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_Mapping;
	CREATE TABLE dbo.U_@CustomFormatCode_Mapping (
		 DedCode VARCHAR(10)
		,ShortCode VARCHAR(5)
		,CoverageCode VARCHAR(30)
		,ControlNumber VARCHAR(10)
		,Suffix VARCHAR(10)
		,Account VARCHAR(10)
	);

	INSERT INTO dbo.U_@CustomFormatCode_Mapping (DedCode,ShortCode,CoverageCode,ControlNumber,Suffix,Account) VALUES
		--TRM1 = EE Basic Term
		 ('LIFE','TRM1','TRM1 = EE Basic Term','0123456','001','00000')
		,('BLIFE','TRM1','TRM1 = EE Basic Term','0123456','001','00000')
		--ADD1 = EE Basic AD&D
		,('ADD','ADD1','ADD1 = EE Basic AD&D','0123456','001','00000')
		,('BADD','ADD1','ADD1 = EE Basic AD&D','0123456','001','00000')
		--TRM3 = EE Suppplemental Term
		,('LIFEE','TRM3','TRM3 = EE Suppplemental Term','0123456','001','00000')
		--ADD3 = EE Supplemental AD&S
		,('ADDE','ADD3','ADD3 = EE Supplemental AD&S','0123456','001','00000')
		--TRM4 = Spouse Supp. Term
		,('LIFES','TRM4','TRM4 = Spouse Supp. Term','0123456','001','00000')
		--TRM5 = Child Supplemental Term
		,('LIFEC','TRM5','TRM5 = Child Supplemental Term','0123456','001','00000');

    ---------------------------------
    -- DETAIL RECORD - U_@CustomFormatCode_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = ConSystemID
        -- standard fields above and additional driver fields below
        ,DrvEnrolleeEffDate = CASE WHEN EecEmplStatus <> 'T' THEN EecDateOfLastHire ELSE EecDateLastWorked END
        ,DrvSSN = '0' + EepSSN
        ,DrvEnrolleeStatus = CASE WHEN EecEmplStatus <> 'T' THEN '00'
                                  ELSE
									  CASE WHEN EecTermReason = '203' THEN '26'
                                           ELSE '40'
                                      END
                             END
        ,DrvDateOfLastHire = EecDateOfLastHire
        ,DrvDOHCentury = LEFT(YEAR(EecDateOfLastHire),2)
        ,DrvGender = EepGender
        ,DrvEnrolleeDOB = EepDateOfBirth
        ,DrvEnrolleeName = CASE WHEN LEN(RTRIM(EepNameLast) + ISNULL(NULLIF(' ' + NULLIF(RTRIM(EepNameSuffix),'Z'),' '),'') + ',' + RTRIM(EepNameFirst) + ISNULL(NULLIF(' ' + LEFT(EepNameMiddle,1),' '),'')) > 26
                                    THEN LEFT(EepNameLast,24) + ',' + LEFT(EepNameFirst,1)
                                ELSE RTRIM(EepNameLast) + ISNULL(NULLIF(' ' + NULLIF(RTRIM(EepNameSuffix),'Z'),' '),'') + ',' + RTRIM(EepNameFirst) + ISNULL(NULLIF(' ' + LEFT(EepNameMiddle,1),' '),'')
                           END
        ,DrvSalary = CONVERT(INT,EecAnnSalary)
        ,DrvDateLastWorked = ISNULL(CONVERT(VARCHAR(8),EecDateLastWorked,112),'00000000')
        ,DrvAddressLine1 = EepAddressLine1
        ,DrvAddressLine2 = EepAddressLine2
        ,DrvAddressCity = EepAddressCity
        ,DrvAddressState = EepAddressState
        ,DrvAddressZipCode = EepAddressZipCode
        ,DrvSalaryOrHourly = CASE EecSalaryOrHourly 
                                  WHEN 'H' THEN '1'
                                  WHEN 'S' THEN '2'
                             END
        ,DrvPhoneBusinessNumber = EecPhoneBusinessNumber
        ,DrvPhoneHomeNumber = EepPhoneHomeNumber
        --TRM1 Life Coverage
        ,DrvCovCode1 = MAX(CASE WHEN ShortCode = 'TRM1' THEN CoverageCode END)
        ,DrvCovEffDate1 = MAX(CASE WHEN ShortCode = 'TRM1' THEN ISNULL(CONVERT(VARCHAR(8),COALESCE(BdmBenStopDate,BdmBenStartDate),112),REPLICATE(0,8)) END)
        ,DrvCovCtrlNo1 = MAX(CASE WHEN ShortCode = 'TRM1' THEN ISNULL(Suffix,REPLICATE(0,3)) END)
        ,DrvSuffix1 = MAX(CASE WHEN ShortCode = 'TRM1' THEN ISNULL(Suffix,REPLICATE(0,3)) END)
        ,DrvAccount1 = MAX(CASE WHEN ShortCode = 'TRM1' THEN ISNULL(Account,REPLICATE(0,5)) END)
        ,DrvCovBenAmt1 = MAX(CASE WHEN ShortCode = 'TRM1' THEN ISNULL(BcaBenAmtCalc,REPLICATE(0,9)) END)
        --ADD1 Coverage
        ,DrvCovCode2 = MAX(CASE WHEN ShortCode = 'ADD1' THEN CoverageCode END)
        ,DrvCovEffDate2 = MAX(CASE WHEN ShortCode = 'ADD1' THEN ISNULL(CONVERT(VARCHAR(8),COALESCE(BdmBenStopDate,BdmBenStartDate),112),REPLICATE(0,8)) END)
        ,DrvCovCtrlNo2 = MAX(CASE WHEN ShortCode = 'ADD1' THEN ISNULL(Suffix,REPLICATE(0,3)) END)
        ,DrvSuffix2 = MAX(CASE WHEN ShortCode = 'ADD1' THEN ISNULL(Suffix,REPLICATE(0,3)) END)
        ,DrvAccount2 = MAX(CASE WHEN ShortCode = 'ADD1' THEN ISNULL(Account,REPLICATE(0,5)) END)
        ,DrvCovBenAmt2 = MAX(CASE WHEN ShortCode = 'ADD1' THEN ISNULL(BcaBenAmtCalc,REPLICATE(0,9)) END)
        --TRM3 Life Coverage
        ,DrvCovCode3 = MAX(CASE WHEN ShortCode = 'TRM3' THEN CoverageCode END)
        ,DrvCovEffDate3 = MAX(CASE WHEN ShortCode = 'TRM3' THEN ISNULL(CONVERT(VARCHAR(8),COALESCE(BdmBenStopDate,BdmBenStartDate),112),REPLICATE(0,8)) END)
        ,DrvCovCtrlNo3 = MAX(CASE WHEN ShortCode = 'TRM3' THEN ISNULL(Suffix,REPLICATE(0,3)) END)
        ,DrvSuffix3 = MAX(CASE WHEN ShortCode = 'TRM3' THEN ISNULL(Suffix,REPLICATE(0,3)) END)
        ,DrvAccount3 = MAX(CASE WHEN ShortCode = 'TRM3' THEN ISNULL(Account,REPLICATE(0,5)) END)
        ,DrvCovBenAmt3 = MAX(CASE WHEN ShortCode = 'TRM3' THEN ISNULL(BcaBenAmtCalc,REPLICATE(0,9)) END)
        --ADD3 Coverage
        ,DrvCovCode4 = MAX(CASE WHEN ShortCode = 'ADD3' THEN CoverageCode END)
        ,DrvCovEffDate4 = MAX(CASE WHEN ShortCode = 'ADD3' THEN ISNULL(CONVERT(VARCHAR(8),COALESCE(BdmBenStopDate,BdmBenStartDate),112),REPLICATE(0,8)) END)
        ,DrvCovCtrlNo4 = MAX(CASE WHEN ShortCode = 'ADD3' THEN ISNULL(Suffix,REPLICATE(0,3)) END)
        ,DrvSuffix4 = MAX(CASE WHEN ShortCode = 'ADD3' THEN ISNULL(Suffix,REPLICATE(0,3)) END)
        ,DrvAccount4 = MAX(CASE WHEN ShortCode = 'ADD3' THEN ISNULL(Account,REPLICATE(0,5)) END)
        ,DrvCovBenAmt4 = MAX(CASE WHEN ShortCode = 'ADD3' THEN ISNULL(BcaBenAmtCalc,REPLICATE(0,9)) END)
        --TRM4 SP Supp. Life Coverage
        ,DrvCovCode5 = MAX(CASE WHEN ShortCode = 'TRM4' THEN CoverageCode END)
        ,DrvCovEffDate5 = MAX(CASE WHEN ShortCode = 'TRM4' THEN ISNULL(CONVERT(VARCHAR(8),COALESCE(BdmBenStopDate,BdmBenStartDate),112),REPLICATE(0,8)) END)
        ,DrvCovCtrlNo5 = MAX(CASE WHEN ShortCode = 'TRM4' THEN ISNULL(Suffix,REPLICATE(0,3)) END)
        ,DrvSuffix5 = MAX(CASE WHEN ShortCode = 'TRM4' THEN ISNULL(Suffix,REPLICATE(0,3)) END)
        ,DrvAccount5 = MAX(CASE WHEN ShortCode = 'TRM4' THEN ISNULL(Account,REPLICATE(0,5)) END)
        ,DrvCovBenAmt5 = MAX(CASE WHEN ShortCode = 'TRM4' THEN ISNULL(BcaBenAmtCalc,REPLICATE(0,9)) END)
        --TRM5 CH Supp. Life Coverage - 1st Child
        ,DrvCovCode6 = MAX(CASE WHEN ShortCode = 'TRM5' THEN CoverageCode END)
        ,DrvCovEffDate6 = MAX(CASE WHEN ShortCode = 'TRM5' THEN ISNULL(CONVERT(VARCHAR(8),COALESCE(BdmBenStopDate,BdmBenStartDate),112),REPLICATE(0,8)) END)
        ,DrvCovCtrlNo6 = MAX(CASE WHEN ShortCode = 'TRM5' THEN ISNULL(ControlNumber,REPLICATE(0,7)) END)
        ,DrvSuffix6 = MAX(CASE WHEN ShortCode = 'TRM5' THEN ISNULL(Suffix,REPLICATE(0,3)) END)
        ,DrvAccount6 = MAX(CASE WHEN ShortCode = 'TRM5' THEN ISNULL(Account,REPLICATE(0,5)) END)
        ,DrvCovBenAmt6 = MAX(CASE WHEN ShortCode = 'TRM5' THEN ISNULL(BcaBenAmtCalc,REPLICATE(0,9)) END)
    INTO dbo.U_@CustomFormatCode_drvTbl
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
	LEFT JOIN dbo.U_dsi_BDM_@CustomFormatCode WITH (NOLOCK)
		ON BdmEEID = xEEID
		AND BdmCOID = xCOID
	LEFT JOIN dbo.Contacts WITH (NOLOCK)
		ON ConEEID = xEEID
		AND ConSystemID = BdmDepRecID
	LEFT JOIN dbo.U_dsi_bdm_BenCalculationAmounts WITH (NOLOCK)
		ON BcaEEID = BdmEEID
		AND BcaCoID = BdmCoID
		AND BcaFormatCode = @FormatCode
		AND BcaDedCode = BdmDedCode
		AND BcaDepRecID = ConSystemID
	LEFT JOIN dbo.U_@CustomFormatCode_Mapping WITH (NOLOCK)
		ON DedCode = BdmDedCode
	GROUP BY EecEmplStatus, EecDateOfLastHire, EecDateLastWorked, EepSSN, EecTermReason, EepGender, EepDateOfBirth, EepNameLast, EepNameSuffix, EepNameFirst, EepNameMiddle
		,EecAnnSalary, EepAddressLine1, EepAddressLine2, EepAddressCity, EepAddressState, EepAddressZipCode, EecSalaryOrHourly, EecPhoneBusinessNumber, EepPhoneHomeNumber
		,xEEID, xCOID, ConSystemID;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable('@CustomFormatCode','UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = '@FileNamePreFix' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
        WHERE FormatCode = '@CustomFormatCode';
    END;

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vw@CustomFormatCode_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_@CustomFormatCode_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE '@CustomFormatCode%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET ExpLastStartPerControl = '201707011'
       ,ExpStartPerControl     = '201707011'
       ,ExpLastEndPerControl   = '201707019'
       ,ExpEndPerControl       = '201707019'
WHERE ExpFormatCode = '@CustomFormatCode';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vw@CustomFormatCode_Export AS
	SELECT TOP 200000000 DATA FROM dbo.U_@CustomFormatCode_File WITH (NOLOCK)
	ORDER BY RIGHT(RecordSet,2),InitialSort, SubSort;
GO
