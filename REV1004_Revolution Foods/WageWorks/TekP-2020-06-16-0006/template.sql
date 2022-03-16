/*
Directions:
1) Find and replace each of the text below with the applicable information from the SKINNYSPEC.
       E.g. Replace the text "James Bender" (excluding quotes) with "Chris Donovan"
2) Manually update any mapping in the tables.
3) Deploy this to client environment!

-- Integration parameters
WageWorks - Replace with customer name
James Bender - Replace with TC name
Cheryl Petitti - Replace with BA/IC name
8/28/2020 - Replace with date of creation
TekP-2020-06-16-0006 - Replace with SR number
Y - Replace with 'Y' (Yes) or 'N' (No) for Web Interface Settings

-- File parameters
NULL - Replace with the UDES or PROD Path (J: drive)
NULL - Replace with the TEST Path (I: drive)
@FileCustomerNumber - Replace with Customer Number for file

-- Data parameters
@EmployerEIN - Replace with EIN in XX-XXXXXXX format
@DivisionMapping - Replace with division, or skip to variable to input case statement
@24OR26 - Is biweekly 24 or 26 weeks? (replace with 24 or 26)

-- Plan mapping (SKIP TO THESE VARIABLES TO REPLACE WITH CASE STATEMENTS)
@MEDPlanMapping
@MEDCovMapping
@DENPlanMapping
@DENCovMapping
@VISPlanMapping
@VISCovMapping
@FSAPlanMapping

-- Relationship parameters
@SpousesCSV - Replace with SPS relationship codes in CSV format
@ChildrenCSV - Replace with CHL relationship codes in CSV format
@DomPartnerCSV - Replace with DP relationship codes in CSV format
@SPSRelationships - Replace with SPS relationship codes in quoted-CSV format
@DPRelationships - Replace with DP relationship codes in quoted-CSV format
@CHLRelationships - Replace with child (not step-children) relationship codes in quoted-CSV format
@STCRelationships - Replace with step-child relationship codes in quoted-CSV format
*/
SET NOCOUNT ON;
IF OBJECT_ID('dsi_vwEWWCOBRA_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEWWCOBRA_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EWWCOBRA') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EWWCOBRA];
GO
IF OBJECT_ID('U_EWWCOBRA_File') IS NOT NULL DROP TABLE [dbo].[U_EWWCOBRA_File];
GO
IF OBJECT_ID('U_EWWCOBRA_EEList') IS NOT NULL DROP TABLE [dbo].[U_EWWCOBRA_EEList];
GO
IF OBJECT_ID('U_EWWCOBRA_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EWWCOBRA_drvTbl];
GO
IF OBJECT_ID('U_dsi_BDM_EWWCOBRA') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EWWCOBRA];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EWWCOBRA';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EWWCOBRA';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EWWCOBRA';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EWWCOBRA';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EWWCOBRA';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EWWCOBRA','WageWorks COBRA Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1477','S','N','EWWCOBRA00Z0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerEIN"','1','(''UA''=''F'')','EWWCOBRA00Z0','20','D','10','1',NULL,'EMPLOYER_EIN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvActionCode"','2','(''UA''=''F'')','EWWCOBRA00Z0','2','D','10','21',NULL,'ACTION_CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastName"','3','(''UA''=''F'')','EWWCOBRA00Z0','20','D','10','23',NULL,'LAST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstName"','4','(''UA''=''F'')','EWWCOBRA00Z0','20','D','10','43',NULL,'FIRST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMiddleInitial"','5','(''UA''=''F'')','EWWCOBRA00Z0','1','D','10','63',NULL,'MIDDLE_INITIAL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeSSN"','6','(''UA''=''F'')','EWWCOBRA00Z0','11','D','10','64',NULL,'EMPLOYEE_SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDependentSSN"','7','(''UA''=''F'')','EWWCOBRA00Z0','11','D','10','75',NULL,'DEPENDENT_SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeNumber"','8','(''UA''=''F'')','EWWCOBRA00Z0','20','D','10','86',NULL,'EMPLOYEE_NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDivision"','9','(''UA''=''F'')','EWWCOBRA00Z0','50','D','10','106',NULL,'Division',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeClass"','10','(''UA''=''F'')','EWWCOBRA00Z0','25','D','10','156',NULL,'EMPLOYEE_CLASS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelationship"','11','(''UA''=''F'')','EWWCOBRA00Z0','1','D','10','181',NULL,'Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','12','(''UA''=''F'')','EWWCOBRA00Z0','1','D','10','182',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHireDate"','13','(''UD101''=''F'')','EWWCOBRA00Z0','10','D','10','183',NULL,'HIRE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBirthDate"','14','(''UD101''=''F'')','EWWCOBRA00Z0','10','D','10','193',NULL,'BIRTH_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddress1"','15','(''UA''=''F'')','EWWCOBRA00Z0','50','D','10','203',NULL,'ADDRESS_1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddress2"','16','(''UA''=''F'')','EWWCOBRA00Z0','50','D','10','253',NULL,'ADDRESS_2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','17','(''UA''=''F'')','EWWCOBRA00Z0','20','D','10','303',NULL,'CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','18','(''UA''=''F'')','EWWCOBRA00Z0','2','D','10','323',NULL,'STATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZip"','19','(''UA''=''F'')','EWWCOBRA00Z0','10','D','10','325',NULL,'ZIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountry"','20','(''UA''=''F'')','EWWCOBRA00Z0','10','D','10','335',NULL,'COUNTRY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','21','(''SS''=''F'')','EWWCOBRA00Z0','1','D','10','345',NULL,'FILLER_1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCobraEligible"','22','(''UA''=''F'')','EWWCOBRA00Z0','1','D','10','346',NULL,'COBRA_ELIGIBLE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPreferredLanguage"','23','(''UA''=''F'')','EWWCOBRA00Z0','2','D','10','347',NULL,'PREFERRED_LANGUAGE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneNumber"','24','(''UA''=''F'')','EWWCOBRA00Z0','12','D','10','349',NULL,'PHONE_NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressEMail"','25','(''UA''=''F'')','EWWCOBRA00Z0','100','D','10','361',NULL,'E_MAIL_ADDRESS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvInitialNotificationCOBRA"','26','(''UA''=''F'')','EWWCOBRA00Z0','1','D','10','461',NULL,'INITIAL_NOTIFICATION_COBRA',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','27','(''SS''=''F'')','EWWCOBRA00Z0','1','D','10','462',NULL,'INITIAL_NOTIFICATION_HIPAA',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWaitingStartDate"','28','(''UD101''=''F'')','EWWCOBRA00Z0','10','D','10','463',NULL,'WAITING_START_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageBeginDate"','29','(''UD101''=''F'')','EWWCOBRA00Z0','10','D','10','473',NULL,'COVERAGE_BEGIN_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','30','(''SS''=''F'')','EWWCOBRA00Z0','50','D','10','483',NULL,'FILLER_2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQualifyingEventDate"','31','(''UD101''=''F'')','EWWCOBRA00Z0','10','D','10','533',NULL,'QUALIFYING_EVENT_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastPreCobraCovered"','32','(''UD101''=''F'')','EWWCOBRA00Z0','10','D','10','543',NULL,'LAST_PRECOBRA_COVERED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQualifyingEventType"','33','(''UA''=''F'')','EWWCOBRA00Z0','2','D','10','553',NULL,'QUALIFYING_EVENT_TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','34','(''SS''=''F'')','EWWCOBRA00Z0','10','D','10','555',NULL,'ELIGIBILITY_END_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','35','(''SS''=''F'')','EWWCOBRA00Z0','10','D','10','565',NULL,'SEVERANCE_THROUGH',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','36','(''SS''=''F'')','EWWCOBRA00Z0','3','D','10','575',NULL,'SEVERANCE_PERCENT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','37','(''SS''=''F'')','EWWCOBRA00Z0','10','D','10','578',NULL,'SEVERANCE_MONTHLY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','38','(''SS''=''F'')','EWWCOBRA00Z0','10','D','10','588',NULL,'SEVERANCE_CREDIT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','39','(''SS''=''F'')','EWWCOBRA00Z0','10','D','10','598',NULL,'BILLING_START_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','40','(''SS''=''F'')','EWWCOBRA00Z0','10','D','10','608',NULL,'ELECTION_NOTICE_MAILED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','41','(''SS''=''F'')','EWWCOBRA00Z0','10','D','10','618',NULL,'HIPAA_CERTIFICATE_MAILED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','42','(''SS''=''F'')','EWWCOBRA00Z0','10','D','10','628',NULL,'ELECTION_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','43','(''SS''=''F'')','EWWCOBRA00Z0','50','D','10','638',NULL,'FILLER_3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanName1C1Med"','44','(''UA''=''F'')','EWWCOBRA00Z0','50','D','10','688',NULL,'PLAN_NAME1(MED)C1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCovCode1"','45','(''UA''=''F'')','EWWCOBRA00Z0','2','D','10','738',NULL,'PLAN_COV_CODE1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCovStart1"','46','(''UD101''=''F'')','EWWCOBRA00Z0','10','D','10','740',NULL,'PLAN_COV_START1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCovEnd1"','47','(''UD101''=''F'')','EWWCOBRA00Z0','10','D','10','750',NULL,'PLAN_COV_END1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','48','(''SS''=''F'')','EWWCOBRA00Z0','10','D','10','760',NULL,'PLAN_RATE1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','49','(''SS''=''F'')','EWWCOBRA00Z0','8','D','10','770',NULL,'EMPLOYER_ANNUAL_CONTRIBUTION1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCarrierEmpID1"','50','(''UA''=''F'')','EWWCOBRA00Z0','14','D','10','778',NULL,'CARRIER_EMPLOYEE_ID1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','51','(''SS''=''F'')','EWWCOBRA00Z0','16','D','10','792',NULL,'PLAN_FILLER1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanName2C8Den"','52','(''UA''=''F'')','EWWCOBRA00Z0','50','D','10','808',NULL,'PLAN_NAME2(DEN)C8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCovCode2"','53','(''UA''=''F'')','EWWCOBRA00Z0','2','D','10','858',NULL,'PLAN_COV_CODE2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCovStart2"','54','(''UD101''=''F'')','EWWCOBRA00Z0','10','D','10','860',NULL,'PLAN_COV_START2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCovEnd2"','55','(''UD101''=''F'')','EWWCOBRA00Z0','10','D','10','870',NULL,'PLAN_COV_END2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','56','(''SS''=''F'')','EWWCOBRA00Z0','10','D','10','880',NULL,'PLAN_RATE2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','57','(''SS''=''F'')','EWWCOBRA00Z0','8','D','10','890',NULL,'EMPLOYER_ANNUAL_CONTRIBUTION2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCarrierEmpID2"','58','(''UA''=''F'')','EWWCOBRA00Z0','14','D','10','898',NULL,'CARRIER_EMPLOYEE_ID2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','59','(''SS''=''F'')','EWWCOBRA00Z0','16','D','10','912',NULL,'PLAN_FILLER2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanName3C15Vis"','60','(''UA''=''F'')','EWWCOBRA00Z0','50','D','10','928',NULL,'PLAN_NAME3(VIS)C15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCovCode3"','61','(''UA''=''F'')','EWWCOBRA00Z0','2','D','10','978',NULL,'PLAN_COV_CODE3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCovStart3"','62','(''UD101''=''F'')','EWWCOBRA00Z0','10','D','10','980',NULL,'PLAN_COV_START3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCovEnd3"','63','(''UD101''=''F'')','EWWCOBRA00Z0','10','D','10','990',NULL,'PLAN_COV_END3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','64','(''SS''=''F'')','EWWCOBRA00Z0','10','D','10','1000',NULL,'PLAN_RATE3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','65','(''SS''=''F'')','EWWCOBRA00Z0','8','D','10','1010',NULL,'EMPLOYER_ANNUAL_CONTRIBUTION3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCarrierEmpID3"','66','(''UA''=''F'')','EWWCOBRA00Z0','14','D','10','1018',NULL,'CARRIER_EMPLOYEE_ID3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','67','(''SS''=''F'')','EWWCOBRA00Z0','16','D','10','1032',NULL,'PLAN_FILLER3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanName4FSAMed"','68','(''UA''=''F'')','EWWCOBRA00Z0','50','D','10','1048',NULL,'PLAN_NAME4(FSAMed)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCovCode4"','69','(''UA''=''F'')','EWWCOBRA00Z0','2','D','10','1098',NULL,'PLAN_COV_CODE4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCovStart4"','70','(''UD101''=''F'')','EWWCOBRA00Z0','10','D','10','1100',NULL,'PLAN_COV_START4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCovEnd4"','71','(''UD101''=''F'')','EWWCOBRA00Z0','10','D','10','1110',NULL,'PLAN_COV_END4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanRate4"','72','(''UA''=''F'')','EWWCOBRA00Z0','10','D','10','1120',NULL,'PLAN_RATE4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','73','(''SS''=''F'')','EWWCOBRA00Z0','8','D','10','1130',NULL,'EMPLOYER_ANNUAL_CONTRIBUTION4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCarrierEmpID4"','74','(''UA''=''F'')','EWWCOBRA00Z0','14','D','10','1138',NULL,'CARRIER_EMPLOYEE_ID4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','75','(''SS''=''F'')','EWWCOBRA00Z0','16','D','10','1152',NULL,'PLAN_FILLER4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','76','(''SS''=''F'')','EWWCOBRA00Z0','50','D','10','1168',NULL,'PLAN_NAME5(FSA-LimitedPurpose)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','77','(''SS''=''F'')','EWWCOBRA00Z0','2','D','10','1218',NULL,'PLAN_COV_CODE5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','78','(''SS''=''F'')','EWWCOBRA00Z0','10','D','10','1220',NULL,'PLAN_COV_START5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','79','(''SS''=''F'')','EWWCOBRA00Z0','10','D','10','1230',NULL,'PLAN_COV_END5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','80','(''SS''=''F'')','EWWCOBRA00Z0','10','D','10','1240',NULL,'PLAN_RATE5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','81','(''SS''=''F'')','EWWCOBRA00Z0','8','D','10','1250',NULL,'EMPLOYER_ANNUAL_CONTRIBUTION5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','82','(''SS''=''F'')','EWWCOBRA00Z0','14','D','10','1258',NULL,'CARRIER_EMPLOYEE_ID5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','83','(''SS''=''F'')','EWWCOBRA00Z0','16','D','10','1272',NULL,'PLAN_FILLER5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','84','(''SS''=''F'')','EWWCOBRA00Z0','10','D','10','1288',NULL,'PLAN_YEAR_START',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','85','(''SS''=''F'')','EWWCOBRA00Z0','10','D','10','1298',NULL,'ENROLLMENT_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','86','(''SS''=''F'')','EWWCOBRA00Z0','10','D','10','1308',NULL,'PAY_RUN_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','87','(''SS''=''F'')','EWWCOBRA00Z0','25','D','10','1318',NULL,'PAY_SCHEDULE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','88','(''SS''=''F'')','EWWCOBRA00Z0','1','D','10','1343',NULL,'PAYMENT_TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','89','(''SS''=''F'')','EWWCOBRA00Z0','1','D','10','1344',NULL,'ENROLLMENT_TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','90','(''SS''=''F'')','EWWCOBRA00Z0','27','D','10','1345',NULL,'FSA_FILLER1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','91','(''SS''=''F'')','EWWCOBRA00Z0','1','D','10','1372',NULL,'COMMUTER_ELGIBLE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','92','(''SS''=''F'')','EWWCOBRA00Z0','1','D','10','1373',NULL,'OPT_IN_OPT_OUT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','93','(''SS''=''F'')','EWWCOBRA00Z0','20','D','10','1374',NULL,'ACH-ROUTING',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','94','(''SS''=''F'')','EWWCOBRA00Z0','30','D','10','1394',NULL,'ACH_ACCOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','95','(''SS''=''F'')','EWWCOBRA00Z0','1','D','10','1424',NULL,'ACH_TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','96','(''SS''=''F'')','EWWCOBRA00Z0','50','D','10','1425',NULL,'ACH_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','97','(''SS''=''F'')','EWWCOBRA00Z0','2','D','10','1475',NULL,'PAYMENT_POLICY',NULL,NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('FileName Is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'WageWorks COBRA Export','201605099','EMPEXPORT','ONDEMAND','May  9 2016 12:00AM','EWWCOBRA',NULL,NULL,NULL,'201605099','May  9 2016 12:00AM','Dec 30 1899 12:00AM','201604011',NULL,NULL,NULL,'201604011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('FileName Is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','201605099','EMPEXPORT','SCHEDULED','May  9 2016 12:00AM','EWWCOBRA',NULL,NULL,NULL,'201605099','May  9 2016 12:00AM','Dec 30 1899 12:00AM','201604011',NULL,NULL,NULL,'201604011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('FileName Is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Test Purposes Only','201605099','EMPEXPORT','TEST','May  9 2016  7:20AM','EWWCOBRA',NULL,NULL,NULL,'201605099','May  9 2016 12:00AM','Dec 30 1899 12:00AM','201604011',NULL,NULL,NULL,'201604011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWWCOBRA','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWWCOBRA','ExportPath','V','NULL');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWWCOBRA','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWWCOBRA','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWWCOBRA','TestPath','V','NULL');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWWCOBRA','UDESPath','V','NULL');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWWCOBRA','UseFileName','V','N');
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EWWCOBRA','D10','dbo.U_EWWCOBRA_drvTbl WITH (NOLOCK)',NULL);
GO
DECLARE @ISWEB char(1) = 'Y';
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
IF @ISWEB = 'Y'
BEGIN
    UPDATE dbo.AscExp SET expAscFileName = '\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EWWCOBRA_YYYYMMDD.txt' WHERE expFormatCode = 'EWWCOBRA';

    UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EWWCOBRA_YYYYMMDD.txt' END WHERE expFormatCode = 'EWWCOBRA';
    IF LEFT(@UDENV,2) = 'NW' UPDATE dbo.AscExp SET expAscFileName = REPLACE(expAscFileName,'Exports\',SPACE(0)) WHERE expFormatCode = 'EWWCOBRA';

    UPDATE dbo.AscExp SET expAscFileName = REPLACE(expAscFileName,'YYYYMMDD',CONVERT(char(8),GETDATE(),112)) WHERE expFormatCode = 'EWWCOBRA';

    UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EWWCOBRA' AND CfgName IN ('UseFileName','ExportPath');
    
    DELETE FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EWWCOBRA' AND CfgName IN ('TestPath','UDESPath');
    INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EWWCOBRA' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
END
GO
IF OBJECT_ID('U_EWWCOBRA_File') IS NULL
CREATE TABLE [dbo].[U_EWWCOBRA_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(50) NOT NULL,
    [SubSort] varchar(50) NOT NULL,
    [SubSort2] varchar(50) NULL,
    [SubSort3] varchar(50) NULL,
    [Data] char(1477) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EWWCOBRA]
    @SystemID char(12)
AS
/**********************************************************************************
Client Name: WageWorks

Created By: James Bender
Business Analyst: Cheryl Petitti
Create Date: 8/28/2020
Service Request Number: TekP-2020-06-16-0006

Purpose: WageWorks COBRA Export

Revision History
----------------
Update By           Date        Request Num         Desc
XXXXXXXXXXXX        XX/XX/20XX  SR-20XX-00XXXXXX    XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EWWCOBRA';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EWWCOBRA';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EWWCOBRA';
SELECT * FROM dbo.AscExp WHERE ExpFormatCode = 'EWWCOBRA';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EWWCOBRA' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EWWCOBRA', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EWWCOBRA', 'TEST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EWWCOBRA', 'SCHEDULED';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EWWCOBRA';
**********************************************************************************/
BEGIN
    --==========================================
    -- Declare variables
    --==========================================
    DECLARE  @FormatCode varchar(12)
            ,@ExportCode varchar(12)
            ,@StartDate  datetime
            ,@EndDate    datetime
            ,@EETypeList varchar(100);

    -- Initialize @FormatCode
    SET @FormatCode = 'EWWCOBRA';

    -- Declare dates from Parameter file
    SELECT
         @StartDate  = LEFT(StartPerControl,8)
        ,@EndDate    = DATEADD(SS,-1,DATEADD(DD,1,LEFT(EndPerControl,8)))
        ,@ExportCode = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List
    --==========================================
    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EWWCOBRA_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
      AND xEEID IN (SELECT xEEID FROM dbo.U_EWWCOBRA_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- BDM Section - NPM RUN
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'TermSelectionOption','AuditDate');

    -- NPM parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RunID','NPM');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','Y'); -- Include deds where DedIsCobraCovered = 'Y'
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'NewEnrolleeType','2'); -- All new enrollees where no previous plan exists
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'NewEnrolleeIncludeEmps','Y'); -- Include employees when dependent is eligible

    -- Run BDM for NPM
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- BDM Section - COBRA RUN
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'TermSelectionOption','AuditDate');

    -- COBRA parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RunID','QB');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'AddToPreviousRun','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','Y'); -- DedIsCobraCovered = 'Y'
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraType','4'); -- Eep/ConCobraReason first, then EdhChangeReason. Include CHGRP for elig. ben groups
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraDate','3'); -- EedBenStopDate and DbnBenStopDate, unless Eep/ConDateOfCOBRAEvent exists
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraPQBType','1'); -- If no EE or spouse, ALL children are PQB (not just oldest)
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraReasonsDepPQB','201,204,205,210,LEVNT3,LEVNT4'); -- Valid dependent PQB reasons
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidCobraReasonsEmp','201,204,210,LEVNT3,LEVNT4'); -- Invalidate employee when Cobra Reason is a dependent PQB reason
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidTermReasonsEmp','203'); -- Invalidate employee when Cobra Reason is "Death"
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'ConCobraReasonPCF','DependentCOBRAReason'); -- Valid dependent PQB reasons
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CountDependents','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','@SpousesCSV');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','@ChildrenCSV');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','@DomPartnerCSV');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');

    -- Run BDM for QB
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --============================================
    -- Build Employee Data and the driver tables
    --============================================
    IF OBJECT_ID('U_EWWCOBRA_drvTbl') IS NOT NULL
        DROP TABLE dbo.U_EWWCOBRA_drvTbl;
    CREATE TABLE dbo.U_EWWCOBRA_drvTbl(
        drvEEID char(12) NULL,
        drvCoID char(5) NULL,
        drvDepRecID char(12) NULL,
        drvRecType varchar(3) NOT NULL,
        drvEmployerEIN varchar(20) NULL,
        drvActionCode varchar(2) NULL,
        drvLastName varchar(100) NULL,
        drvFirstName varchar(100) NULL,
        drvMiddleInitial varchar(1) NULL,
        drvEmployeeSSN varchar(13) NULL,
        drvDependentSSN varchar(13) NULL,
        drvEmployeeNumber char(20) NULL,
        drvDivision varchar(50) NULL,
        drvEmployeeClass varchar(25) NULL,
        drvRelationship varchar(1) NULL,
        drvGender char(1) NULL,
        drvHireDate datetime NULL,
        drvBirthDate datetime NULL,
        drvAddress1 varchar(255) NULL,
        drvAddress2 varchar(255) NULL,
        drvCity varchar(255) NULL,
        drvState varchar(255) NULL,
        drvZip varchar(51) NULL,
        drvCountry varchar(10) NULL,
        drvCobraEligible char(1) NULL,
        drvPreferredLanguage varchar(2) NULL,
        drvPhoneNumber varchar(52) NULL,
        drvAddressEMail varchar(255) NULL,
        drvInitialNotificationCOBRA char(1) NULL,
        drvWaitingStartDate datetime NULL,
        drvCoverageBeginDate datetime NULL,
        drvQualifyingEventDate datetime NULL,
        drvLastPreCobraCovered datetime NULL,
        drvQualifyingEventType varchar(2) NULL,
        drvPlanName1C1Med varchar(50) NULL,
        drvPlanCovCode1 varchar(2) NULL,
        drvPlanCovStart1 datetime NULL,
        drvPlanCovEnd1 datetime NULL,
        drvCarrierEmpID1 varchar(14) NULL,
        drvPlanName2C8Den varchar(50) NULL,
        drvPlanCovCode2 varchar(2) NULL,
        drvPlanCovStart2 datetime NULL,
        drvPlanCovEnd2 datetime NULL,
        drvCarrierEmpID2 varchar(14) NULL,
        drvPlanName3C15Vis varchar(50) NULL,
        drvPlanCovCode3 varchar(2) NULL,
        drvPlanCovStart3 datetime NULL,
        drvPlanCovEnd3 datetime NULL,
        drvCarrierEmpID3 varchar(14) NULL,
        drvPlanName4FSAMed varchar(50) NULL,
        drvPlanCovCode4 varchar(2) NULL,
        drvPlanCovStart4 datetime NULL,
        drvPlanCovEnd4 datetime NULL,
        drvPlanRate4 varchar(30) NULL,
        drvCarrierEmpID4 varchar(14) NULL,
        drvInitialSort varchar(23) NULL
    );

    ------------------
    -- Load Employee Action Code = '01'
        -- Employees who are NPM or employees when dependent only losing coverage (dependent is PQB)
    ------------------
    INSERT INTO dbo.U_EWWCOBRA_drvTbl(
        drvEEID, drvCoID, drvRecType, drvEmployerEIN, drvActionCode, drvLastName, drvFirstName, drvMiddleInitial,
        drvEmployeeSSN, drvEmployeeNumber, drvDivision, drvRelationship, drvGender, drvHireDate, drvBirthDate,
        drvAddress1, drvAddress2, drvCity, drvState, drvZip, drvCountry, drvCobraEligible, drvPreferredLanguage,
        drvPhoneNumber, drvAddressEMail, drvInitialNotificationCOBRA, drvInitialSort)
    SELECT DISTINCT
         drvEEID                     = xEEID
        ,drvCoID                     = xCoID
        ,drvRecType                  = 'EMP'
        ,drvEmployerEIN              = '@EmployerEIN'
        ,drvActionCode               = '01'
        ,drvLastName                 = EepNameLast
        ,drvFirstName                = EepNameFirst
        ,drvMiddleInitial            = LEFT(EepNameMiddle,1)
        ,drvEmployeeSSN              = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvEmployeeNumber           = EecEmpNo
        ,drvDivision                 = '@DivisionMapping'
        ,drvRelationship             = 'E'
        ,drvGender                   = EepGender
        ,drvHireDate                 = EecDateOfLastHire
        ,drvBirthDate                = EepDateOfBirth
        ,drvAddress1                 = EepAddressLine1
        ,drvAddress2                 = EepAddressLine2
        ,drvCity                     = EepAddressCity
        ,drvState                    = EepAddressState
        ,drvZip                      = CASE WHEN LEN(EepAddressZipCode) > 5 THEN STUFF(EepAddressZipCode,6,0,'-')
                                            ELSE EepAddressZipCode
                                       END
        ,drvCountry                  = NULLIF(EepAddressCountry,'USA')
        ,drvCobraEligible            = 'Y'
        ,drvPreferredLanguage        = 'EN'
        ,drvPhoneNumber              = STUFF(STUFF(EepPhoneHomeNumber,7,0,'-'),4,0,'-')
        ,drvAddressEMail             = EepAddressEMail
        ,drvInitialNotificationCOBRA = CASE WHEN BdmRunID = 'NPM' THEN 'C'
                                       END
        ,drvInitialSort              = RTRIM(EepSSN) + '01'
    FROM dbo.U_EWWCOBRA_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
       AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON eepEEID = xEEID
    JOIN (SELECT DISTINCT BdmEEID, BdmCoID, BdmRunID
          FROM dbo.U_dsi_BDM_EWWCOBRA WITH (NOLOCK)
          WHERE (BdmRunID = 'NPM' AND BdmRecType = 'EMP')
                 OR (BdmRunID = 'QB' AND BdmRecType = 'DEP' AND BdmIsPQB = 'Y')) BDM
        ON BdmEEID = xEEID
       AND BdmCoID = xCoID;

    ------------------
    -- Load Employee Action Codes 03 and 06
    -- 03 - Employee is PQB (non-death)
    -- 06 - Dependent is PQB
    ------------------
    INSERT INTO dbo.U_EWWCOBRA_drvTbl
    SELECT DISTINCT
         drvEEID                     = xEEID
        ,drvCoID                     = xCoID
        ,drvDepRecID                 = ConSystemID
        ,drvRecType                  = BdmRecType
        ,drvEmployerEIN              = '@EmployerEIN'
        ,drvActionCode               = CASE WHEN BdmRecType = 'EMP' THEN '03'
                                            WHEN BdmRecType = 'DEP' THEN '06'
                                       END
        ,drvLastName                 = CASE WHEN BdmRecType = 'EMP' THEN EepNameLast
                                            WHEN BdmRecType = 'DEP' THEN ConNameLast
                                       END
        ,drvFirstName                = CASE WHEN BdmRecType = 'EMP' THEN EepNameFirst
                                            WHEN BdmRecType = 'DEP' THEN ConNameFirst
                                       END
        ,drvMiddleInitial            = CASE WHEN BdmRecType = 'EMP' THEN LEFT(EepNameMiddle,1)
                                            WHEN BdmRecType = 'DEP' THEN LEFT(ConNameMiddle,1)
                                       END
        ,drvEmployeeSSN              = STUFF(STUFF(EepSSN,4,0,'-'),7,0,'-')
        ,drvDependentSSN             = STUFF(STUFF(ConSSN,4,0,'-'),7,0,'-')
        ,drvEmployeeNumber           = EecEmpNo
        ,drvDivision                 = '@DivisionMapping'
        ,drvEmployeeClass            = NULL
        ,drvRelationship             = CASE WHEN BdmRecType = 'EMP' THEN 'E'
                                            WHEN BdmRecType = 'DEP' THEN
                                                 CASE WHEN ConRelationship IN ('@SPSRelationships') THEN 'S'
                                                      WHEN ConRelationship IN ('@CHLRelationships') THEN 'C'
                                                      WHEN ConRelationship IN ('@STCRelationships') THEN 'Q'
                                                      WHEN ConRelationship IN ('@DPRelationships') THEN 'W'
                                                 END
                                       END
        ,drvGender                   = CASE WHEN BdmRecType = 'EMP' THEN EepGender
                                            WHEN BdmRecType = 'DEP' THEN ConGender
                                       END
        ,drvHireDate                 = EecDateOfLastHire
        ,drvBirthDate                = CASE WHEN BdmRecType = 'EMP' THEN EepDateOfBirth
                                            WHEN BdmRecType = 'DEP' THEN ConDateOfBirth
                                       END
        ,drvAddress1                 = CASE WHEN BdmRecType = 'EMP' THEN EepAddressLine1
                                            WHEN BdmRecType = 'DEP' THEN ConAddressLine1
                                       END
        ,drvAddress2                 = CASE WHEN BdmRecType = 'EMP' THEN EepAddressLine2
                                            WHEN BdmRecType = 'DEP' THEN ConAddressLine2
                                       END
        ,drvCity                     = CASE WHEN BdmRecType = 'EMP' THEN EepAddressCity
                                            WHEN BdmRecType = 'DEP' THEN ConAddressCity
                                       END
        ,drvState                    = CASE WHEN BdmRecType = 'EMP' THEN EepAddressState
                                            WHEN BdmRecType = 'DEP' THEN ConAddressState
                                       END
        ,drvZip                      = CASE WHEN BdmRecType = 'EMP' THEN
                                                 CASE WHEN LEN(EepAddressZipCode) > 5 THEN STUFF(EepAddressZipCode,6,0,'-')
                                                      ELSE EepAddressZipCode
                                                 END
                                            WHEN BdmRecType = 'DEP' THEN
                                                 CASE WHEN LEN(ConAddressZipCode) > 5 THEN STUFF(ConAddressZipCode,6,0,'-')
                                                      ELSE ConAddressZipCode
                                                 END
                                       END
        ,drvCountry                  = CASE WHEN BdmRecType = 'EMP' THEN NULLIF(EepAddressCountry,'USA')
                                            WHEN BdmRecType = 'DEP' THEN NULLIF(ConAddressCountry,'USA')
                                       END
        ,drvCobraEligible            = 'N'
        ,drvPreferredLanguage        = 'EN'
        ,drvPhoneNumber              = CASE WHEN BdmRecType = 'EMP' THEN STUFF(STUFF(EepPhoneHomeNumber,7,0,'-'),4,0,'-')
                                            WHEN BdmRecType = 'DEP' THEN STUFF(STUFF(ConPhoneHomeNumber,7,0,'-'),4,0,'-')
                                       END
        ,drvAddressEMail             = CASE WHEN BdmRecType = 'EMP' THEN EepAddressEMail
                                       END
        ,drvInitialNotificationCOBRA = NULL
        ,drvWaitingStartDate         = EecDateOfLastHire
        ,drvCoverageBeginDate        = BdmStartDate
        ,drvQualifyingEventDate      = BdmStopDate
        ,drvLastPreCobraCovered      = BdmLastStopDate
        ,drvQualifyingEventType      = CASE WHEN BdmRecType = 'EMP' THEN
                                                 CASE WHEN EecTermReason = '202' THEN '01'
                                                      WHEN BdmCobraReason = '208' THEN '01'
                                                      WHEN BdmCobraReason IN ('203','CHGRP') THEN '04'
                                                      WHEN BdmCobraReason = '209' THEN '05'
                                                      WHEN BdmCobraReason = '206' THEN '06'
                                                      WHEN BdmCobraReason = '207' THEN '07'
                                                      WHEN BdmCobraReason = '205' THEN '13'
                                                      ELSE '03'
                                                 END
                                            WHEN BdmRecType = 'DEP' THEN
                                                 CASE WHEN BdmCobraReason = '210' OR EecTermReason = '203' THEN '14'
                                                      WHEN BdmCobraReason IN ('204','LEVNT4') THEN '11'
                                                      WHEN BdmCobraReason IN ('201','LEVNT3') THEN '12'
                                                      WHEN BdmCobraReason = '205' THEN '13'
                                                 END
                                       END
        ,drvPlanName1C1Med           = CASE WHEN MedEEID IS NOT NULL THEN '@MEDPlanMapping'
                                       END
        ,drvPlanCovCode1             = CASE WHEN MedEEID IS NOT NULL THEN '@MEDCovMapping'
                                       END
        ,drvPlanCovStart1            = MedStartDate
        ,drvPlanCovEnd1              = MedStopDate
        ,drvCarrierEmpID1            = CASE WHEN MedEEID IS NOT NULL THEN EecEmpNo
                                       END
        ,drvPlanName2C8Den           = CASE WHEN DenEEID IS NOT NULL THEN '@DENPlanMapping'
                                       END
        ,drvPlanCovCode2             = CASE WHEN DenEEID IS NOT NULL THEN '@DENCovMapping'
                                       END
        ,drvPlanCovStart2            = DenStartDate
        ,drvPlanCovEnd2              = DenStopDate
        ,drvCarrierEmpID2            = CASE WHEN DenEEID IS NOT NULL THEN EecEmpNo
                                       END
        ,drvPlanName3C15Vis          = CASE WHEN VisEEID IS NOT NULL THEN '@VISPlanMapping'
                                       END
        ,drvPlanCovCode3             = CASE WHEN VisEEID IS NOT NULL THEN '@VISCovMapping'
                                       END
        ,drvPlanCovStart3            = VisStartDate
        ,drvPlanCovEnd3              = VisStopDate
        ,drvCarrierEmpID3            = CASE WHEN VisEEID IS NOT NULL THEN EecEmpNo
                                       END
        ,drvPlanName4FSAMed          = CASE WHEN FsaEEID IS NOT NULL THEN '@FSAPlanMapping'
                                       END 
        ,drvPlanCovCode4             = CASE WHEN FsaEEID IS NOT NULL THEN '98'
                                       END
        ,drvPlanCovStart4            = FsaStartDate
        ,drvPlanCovEnd4              = FsaStopDate
        ,drvPlanRate4                = CASE WHEN FsaEEID IS NOT NULL THEN
                                                 CASE WHEN EecPayPeriod = 'B' THEN CONVERT(varchar(30),CONVERT(decimal(10,2), FsaEEAmt * @24OR26 / 12))
                                                      WHEN EecPayPeriod = 'S' THEN CONVERT(varchar(30),CONVERT(decimal(10,2), FsaEEAmt * 24 / 12))
                                                      WHEN EecPayPeriod = 'M' THEN CONVERT(varchar(30),CONVERT(decimal(10,2), FsaEEAmt / 12))
                                                      WHEN EecPayPeriod = 'W' THEN CONVERT(varchar(30),CONVERT(decimal(10,2), FsaEEAmt * 52 / 12))
                                                 END
                                       END
        ,drvCarrierEmpID4            = CASE WHEN FsaEEID IS NOT NULL THEN EecEmpNo
                                       END
        ,drvInitialSort              = RTRIM(EepSSN)
                                        + CASE WHEN BdmRecType = 'EMP' THEN '03'
                                               ELSE '06'
                                          END
                                        + CASE WHEN ConRelationship IN ('@SPSRelationships','@DPRelationships') THEN '1'
                                               WHEN ConRelationship IN ('@CHLRelationships','@STCRelationships') THEN '2'
                                               ELSE ''
                                          END + ISNULL(ConSSN,'')
    FROM dbo.U_EWWCOBRA_EEList WITH (NOLOCK)
    JOIN (SELECT
               BdmEEID, BdmCoID, BdmDepRecID, BdmRecType, BdmCobraReason, BdmRelationship,
               MIN(BdmBenStartDate) BdmStartDate, MIN(BdmDateOfCOBRAEvent) BdmStopDate, MAX(BdmDateOfCOBRAEvent) BdmLastStopDate
          FROM dbo.U_dsi_BDM_EWWCOBRA WITH (NOLOCK)
          WHERE BdmRunID = 'QB'
            AND BdmIsPQB = 'Y'
          GROUP BY BdmEEID, BdmCoID, BdmDepRecID, BdmRecType, BdmCobraReason, BdmRelationship) BDM
        ON BdmEEID = xEEID
       AND BdmCoID = xCoID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = BdmEEID
       AND EecCoID = BdmCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON eepEEID = BdmEEID
    JOIN dbo.Company WITH (NOLOCK)
        ON CmpCoID = BdmCoID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = BdmEEID
       AND ConSystemID = BdmDepRecID
    LEFT JOIN (SELECT
                    MedEEID        = BdmEEID
                   ,MedCoID        = BdmCoID
                   ,MedDepRecID    = BdmDepRecID
                   ,MedDedCode     = BdmDedCode
                   ,MedBenOption   = BdmBenOption
                   ,MedNumSpouses  = BdmNumSpouses
                   ,MedNumChildren = BdmNumChildren
                   ,MedStartDate   = BdmBenStartDate
                   ,MedStopDate    = BdmDateOfCOBRAEvent
               FROM dbo.U_dsi_BDM_EWWCOBRA WITH (NOLOCK)
               WHERE BdmRunID = 'QB'
                 AND BdmDedType = 'MED') MED
        ON MedEEID = BdmEEID
       AND MedCoID = BdmCoID
       AND ISNULL(MedDepRecID,'') = ISNULL(BdmDepRecID,'')
    LEFT JOIN (SELECT
                    DenEEID        = BdmEEID
                   ,DenCoID        = BdmCoID
                   ,DenDepRecID    = BdmDepRecID
                   ,DenDedCode     = BdmDedCode
                   ,DenBenOption   = BdmBenOption
                   ,DenNumSpouses  = BdmNumSpouses
                   ,DenNumChildren = BdmNumChildren
                   ,DenStartDate   = BdmBenStartDate
                   ,DenStopDate    = BdmDateOfCOBRAEvent
               FROM dbo.U_dsi_BDM_EWWCOBRA WITH (NOLOCK)
               WHERE BdmRunID = 'QB'
                 AND BdmDedType = 'DEN') DEN
        ON DenEEID = BdmEEID
       AND DenCoID = BdmCoID
       AND ISNULL(DenDepRecID,'') = ISNULL(BdmDepRecID,'')
    LEFT JOIN (SELECT
                    VisEEID        = BdmEEID
                   ,VisCoID        = BdmCoID
                   ,VisDepRecID    = BdmDepRecID
                   ,VisDedCode     = BdmDedCode
                   ,VisBenOption   = BdmBenOption
                   ,VisNumSpouses  = BdmNumSpouses
                   ,VisNumChildren = BdmNumChildren
                   ,VisStartDate   = BdmBenStartDate
                   ,VisStopDate    = BdmDateOfCOBRAEvent
               FROM dbo.U_dsi_BDM_EWWCOBRA WITH (NOLOCK)
               WHERE BdmRunID = 'QB'
                 AND BdmDedType = 'VIS') VIS
        ON VisEEID = BdmEEID
       AND VisCoID = BdmCoID
       AND ISNULL(VisDepRecID,'') = ISNULL(BdmDepRecID,'')
    LEFT JOIN (SELECT
                    FsaEEID      = BdmEEID
                   ,FsaCoID      = BdmCoID
                   ,FsaDepRecID  = BdmDepRecID
                   ,FsaDedCode   = BdmDedCode
                   ,FsaEEAmt     = BdmEEAmt
                   ,FsaStartDate = BdmBenStartDate
                   ,FsaStopDate  = BdmDateOfCOBRAEvent
               FROM dbo.U_dsi_BDM_EWWCOBRA WITH (NOLOCK)
               WHERE BdmRunID = 'QB'
                 AND BdmDedType = 'FSA') FSA
        ON FsaEEID = BdmEEID
       AND FsaCoID = BdmCoID
       AND ISNULL(FsaDepRecID,'') = ISNULL(BdmDepRecID,'');

    ------------------
    -- Load Dependent Action Code 02
    -- 02 - Dependent for Action Codes 01, 03, or 06
    ------------------
    INSERT INTO dbo.U_EWWCOBRA_drvTbl(
        drvEEID, drvCoID, drvDepRecID, drvRecType, drvEmployerEIN, drvActionCode, drvLastName,
        drvFirstName, drvMiddleInitial, drvEmployeeSSN, drvDependentSSN, drvRelationship, drvGender,
        drvBirthDate, drvAddress1, drvAddress2, drvCity, drvState, drvZip, drvCountry, drvInitialSort)
    SELECT DISTINCT
        drvEEID           = drvEEID
        ,drvCoID          = drvCoID
        ,drvDepRecID      = ConSystemID
        ,drvRecType       = 'DEP'
        ,drvEmployerEIN   = drvEmployerEIN
        ,drvActionCode    = '02'
        ,drvLastName      = ConNameLast
        ,drvFirstName     = ConNameFirst
        ,drvMiddleInitial = LEFT(ConNameMiddle,1)
        ,drvEmployeeSSN   = drvEmployeeSSN
        ,drvDependentSSN  = STUFF(STUFF(ConSSN,4,0,'-'), 7,0,'-')
        ,drvRelationship  = CASE WHEN ConRelationship IN ('@SPSRelationships') THEN 'S'
                                 WHEN ConRelationship IN ('@DPRelationships') THEN 'W'
                                 WHEN ConRelationship IN ('@STCRelationships') THEN 'Q'
                                 ELSE 'C'
                            END
        ,drvGender        = ConGender
        ,drvBirthDate     = ConDateOfBirth
        ,drvAddress1      = CASE WHEN ConAddressIsDifferent = 'Y' THEN ConAddressLine1
                            END
        ,drvAddress2      = CASE WHEN ConAddressIsDifferent = 'Y' THEN ConAddressLine2
                            END
        ,drvCity          = CASE WHEN ConAddressIsDifferent = 'Y' THEN ConAddressCity
                            END
        ,drvState         = CASE WHEN ConAddressIsDifferent = 'Y' THEN ConAddressState
                            END
        ,drvZip           = CASE WHEN ConAddressIsDifferent = 'Y' THEN
                                      CASE WHEN LEN(ConAddressZipCode) > 5 THEN STUFF(ConAddressZipCode,6,0,'-')
                                           ELSE ConAddressZipCode
                                      END
                            END
        ,drvCountry       = CASE WHEN ConAddressIsDifferent = 'Y' THEN NULLIF(ConAddressCountry,'USA')
                            END
        ,drvInitialSort   = RTRIM(REPLACE(drvEmployeeSSN,'-','')) + '02'
                                + CASE WHEN ConRelationship IN ('@SPSRelationships','@DPRelationships') THEN '1'
                                       ELSE '2'
                                  END + ISNULL(ConSSN,'')
    FROM dbo.U_EWWCOBRA_drvTbl WITH (NOLOCK)
    JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = drvEEID
    WHERE EXISTS(SELECT 1 FROM dbo.U_dsi_BDM_EWWCOBRA WITH (NOLOCK)
                 WHERE BdmEEID = drvEEID
                   AND BdmCoID = drvCoID
                   AND BdmDepRecID = ConSystemID
                   AND BdmRecType = 'DEP'
                   AND (BdmRunID = 'NPM'
                        OR (BdmRunID = 'QB' AND BdmIsPQB = 'N')));

    ------------------
    -- Load Dependent Action Code 04
    -- 04 - Death of Covered Employee
    ------------------
    INSERT INTO dbo.U_EWWCOBRA_drvTbl(
        drvEEID, drvCoID, drvRecType, drvEmployerEIN, drvActionCode, drvLastName, drvFirstName, drvMiddleInitial,
        drvEmployeeSSN, drvEmployeeNumber, drvDivision, drvRelationship, drvGender, drvHireDate, drvBirthDate,
        drvAddress1, drvAddress2, drvCity, drvState, drvZip, drvCountry, drvPreferredLanguage, drvPhoneNumber,
        drvAddressEMail, drvWaitingStartDate, drvQualifyingEventDate, drvQualifyingEventType, drvInitialSort)
    SELECT DISTINCT
         drvEEID                = drvEEID
        ,drvCoID                = drvCoID
        ,drvRecType             = 'EMP'
        ,drvEmployerEIN         = drvEmployerEIN
        ,drvActionCode          = '04'
        ,drvLastName            = EepNameLast
        ,drvFirstName           = EepNameFirst
        ,drvMiddleInitial       = LEFT(EepNameMiddle,1)
        ,drvEmployeeSSN         = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvEmployeeNumber      = drvEmployeeNumber
        ,drvDivision            = drvDivision
        ,drvRelationship        = 'E'
        ,drvGender              = EepGender
        ,drvHireDate            = drvHireDate
        ,drvBirthDate           = EepDateOfBirth
        ,drvAddress1            = EepAddressLine1
        ,drvAddress2            = EepAddressLine2
        ,drvCity                = EepAddressCity
        ,drvState               = EepAddressState
        ,drvZip                 = CASE WHEN LEN(EepAddressZipCode) > 5 THEN STUFF(EepAddressZipCode,6,0,'-')
                                       ELSE EepAddressZipCode
                                  END
        ,drvCountry             = NULLIF(EepAddressCountry,'USA')
        ,drvPreferredLanguage   = 'EN'
        ,drvPhoneNumber         = STUFF(STUFF(EepPhoneHomeNumber,7,0,'-'),4,0,'-')
        ,drvAddressEMail        = EepAddressEMail
        ,drvWaitingStartDate    = drvWaitingStartDate
        ,drvQualifyingEventDate = drvQualifyingEventDate
        ,drvQualifyingEventType = '21'
        ,drvInitialSort         = RTRIM(EepSSN) + '04'
    FROM dbo.U_EWWCOBRA_drvTbl WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON eepEEID = drvEEID
    WHERE drvActionCode = '06'
      AND drvQualifyingEventType = '14';

    --==========================================
    -- Set FileName
    --==========================================
    UPDATE dbo.U_dsi_Parameters
    SET ExportFile = '@FileCustomerNumber_' + CONVERT(char(8),GETDATE(),112) + '_'
                     + CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' OR @ExportCode = 'TEST' THEN 'TST_'
                            ELSE ''
                       END
                     + 'COB.txt'
    WHERE FormatCode = @FormatCode;

END
/*
--Alter the View
ALTER VIEW dbo.dsi_vwEWWCOBRA_Export AS
    SELECT TOP 200000000 Data
    FROM dbo.U_EWWCOBRA_File WITH (NOLOCK)
    ORDER BY InitialSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EWWCOBRA%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
SET expLastStartPerControl = '201604071'
   ,expStartPerControl     = '201604071'
   ,expLastEndPerControl   = '201604139'
   ,expEndPerControl       = '201604139'
WHERE expFormatCode = 'EWWCOBRA'
  AND expExportCode = 'TEST';
*/
GO
CREATE VIEW dbo.dsi_vwEWWCOBRA_Export AS
    SELECT TOP 200000000 Data
    FROM dbo.U_EWWCOBRA_File WITH (NOLOCK)
    ORDER BY InitialSort;
GO
UPDATE dbo.AscExp
SET expLastStartPerControl = CONVERT(char(8),GETDATE()-14,112) + '1'
   ,expStartPerControl     = CONVERT(char(8),GETDATE()-14,112) + '1'
   ,expLastEndPerControl   = CONVERT(char(8),GETDATE(),112) + '9'
   ,expEndPerControl       = CONVERT(char(8),GETDATE(),112) + '9'
WHERE expFormatCode = 'EWWCOBRA';