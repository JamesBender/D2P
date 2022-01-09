/**********************************************************************************

EPAYFLEXEL: PayFlex Eligibility Export

FormatCode:     EPAYFLEXEL
Project:        PayFlex Eligibility Export
Client ID:      MER1024
Date/time:      2022-01-07 14:38:08.170
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    N33
Server:         N3SUP3DB04
Database:       ULTIPRO_MERCY
Web Filename:   MER1024_ZR6DH_EEHISTORY_EPAYFLEXEL_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EPAYFLEXEL_SavePath') IS NOT NULL DROP TABLE dbo.U_EPAYFLEXEL_SavePath


-----------
-- Create U_dsi_RipoutParms if it doesn't exist
-----------

IF OBJECT_ID('U_dsi_RipoutParms') IS NULL BEGIN

   CREATE TABLE dbo.U_dsi_RipoutParms (
   rpoFormatCode  VARCHAR(10)   NOT NULL,
   rpoParmType    VARCHAR(64)   NOT NULL,
   rpoParmValue01 VARCHAR(1024) NULL,
   rpoParmValue02 VARCHAR(1024) NULL,
   rpoParmValue03 VARCHAR(1024) NULL,
   rpoParmValue04 VARCHAR(1024) NULL,
   rpoParmValue05 VARCHAR(1024) NULL
)
END


-----------
-- Clear U_dsi_RipoutParms
-----------

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EPAYFLEXEL'


-----------
-- Add paths to U_dsi_RipoutParms
-----------

INSERT INTO dbo.U_dsi_RipoutParms (rpoFormatCode, rpoParmType, rpoParmValue01, rpoParmValue02)
SELECT

FormatCode,
'Path',
CfgName,
CfgValue

FROM dbo.U_Dsi_Configuration
WHERE FormatCode = 'EPAYFLEXEL'
AND CfgName LIKE '%path%'


-----------
-- Add AscExp expSystemIDs to U_dsi_RipoutParms
-----------

INSERT INTO dbo.U_dsi_RipoutParms (rpoFormatCode, rpoParmType, rpoParmValue01, rpoParmValue02) 
SELECT

ExpFormatCode,
'expSystemID',
ExpExportCode,
ExpSystemID

FROM dbo.AscExp
WHERE ExpFormatCode = 'EPAYFLEXEL'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EPAYFLEXEL')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EPAYFLEXEL'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EPAYFLEXEL'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EPAYFLEXEL'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EPAYFLEXEL'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EPAYFLEXEL'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EPAYFLEXEL'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EPAYFLEXEL'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EPAYFLEXEL'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EPAYFLEXEL'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEPAYFLEXEL_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEPAYFLEXEL_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EPAYFLEXEL') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EPAYFLEXEL];
GO
IF OBJECT_ID('U_EPAYFLEXEL_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EPAYFLEXEL_Trailer];
GO
IF OBJECT_ID('U_EPAYFLEXEL_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EPAYFLEXEL_PEarHist];
GO
IF OBJECT_ID('U_EPAYFLEXEL_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EPAYFLEXEL_PDedHist];
GO
IF OBJECT_ID('U_EPAYFLEXEL_Header') IS NOT NULL DROP TABLE [dbo].[U_EPAYFLEXEL_Header];
GO
IF OBJECT_ID('U_EPAYFLEXEL_File') IS NOT NULL DROP TABLE [dbo].[U_EPAYFLEXEL_File];
GO
IF OBJECT_ID('U_EPAYFLEXEL_EEList') IS NOT NULL DROP TABLE [dbo].[U_EPAYFLEXEL_EEList];
GO
IF OBJECT_ID('U_EPAYFLEXEL_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EPAYFLEXEL_drvTbl];
GO
IF OBJECT_ID('U_EPAYFLEXEL_DedList') IS NOT NULL DROP TABLE [dbo].[U_EPAYFLEXEL_DedList];
GO
IF OBJECT_ID('U_EPAYFLEXEL_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EPAYFLEXEL_AuditFields];
GO
IF OBJECT_ID('U_EPAYFLEXEL_Audit') IS NOT NULL DROP TABLE [dbo].[U_EPAYFLEXEL_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EPAYFLEXEL') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EPAYFLEXEL];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EPAYFLEXEL','PayFlex Eligibility Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','585','S','N','EPAYFLEXELZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPAYFLEXELZ0','1','H','01','1',NULL,'Record_Indicator',NULL,NULL,'"drvRecord_Indicator"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPAYFLEXELZ0','1','H','01','2',NULL,'Format_Type',NULL,NULL,'"drvFormat_Type"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPAYFLEXELZ0','1','H','01','3',NULL,'Layout_Type',NULL,NULL,'"drvLayout_Type"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPAYFLEXELZ0','8','H','01','4',NULL,'Date_Created',NULL,NULL,'"drvDate_Created"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPAYFLEXELZ0','6','H','01','12',NULL,'Time_Created',NULL,NULL,'"drvTime_Created"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPAYFLEXELZ0','7','H','01','18',NULL,'Employer_ID',NULL,NULL,'"drvEmployer_ID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPAYFLEXELZ0','50','H','01','25',NULL,'Employer_Name',NULL,NULL,'"drvEmployer_Name"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPAYFLEXELZ0','25','H','01','75',NULL,'Memo',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPAYFLEXELZ0','9','H','01','100',NULL,'Layout_Version',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPAYFLEXELZ0','1','H','01','109',NULL,'Online_Enrollment',NULL,NULL,'"drvOnline_Enrollment"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPAYFLEXELZ0','1','H','01','110',NULL,'Online_Commuter',NULL,NULL,'"drvOnline_Commuter"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EPAYFLEXELZ0','1','H','01','111',NULL,'Change_Only',NULL,NULL,'"drvChange_Only"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPAYFLEXELZ0','7','D','10','1',NULL,'Employer_ID',NULL,NULL,'"drvEmployer_ID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPAYFLEXELZ0','10','D','10','8',NULL,'Division',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPAYFLEXELZ0','9','D','10','18',NULL,'Member_Number',NULL,NULL,'"drvMember_Number"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPAYFLEXELZ0','9','D','10','27',NULL,'Social_Security_Number',NULL,NULL,'"drvSocial_Security_Number"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPAYFLEXELZ0','20','D','10','36',NULL,'First_Name',NULL,NULL,'"drvFirst_Name"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPAYFLEXELZ0','20','D','10','56',NULL,'Last_Name',NULL,NULL,'"drvLast_Name"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPAYFLEXELZ0','1','D','10','76',NULL,'Middle_Initial',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPAYFLEXELZ0','10','D','10','77',NULL,'Birth_Date',NULL,NULL,'"drvBirth_Date"','(''UD101''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPAYFLEXELZ0','10','D','10','87',NULL,'Hire_Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPAYFLEXELZ0','1','D','10','97',NULL,'Gender',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPAYFLEXELZ0','10','D','10','98',NULL,'Employee_Status_Date',NULL,NULL,'"drvEmployee_Status_Date"','(''UD101''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EPAYFLEXELZ0','1','D','10','108',NULL,'Employee_Status',NULL,NULL,'"drvEmployee_Status"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EPAYFLEXELZ0','50','D','10','109',NULL,'Residential_Address_Line_1',NULL,NULL,'"drvResidential_Address_Line_1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EPAYFLEXELZ0','50','D','10','159',NULL,'Residential_Address_Line_2',NULL,NULL,'"drvResidential_Address_Line_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EPAYFLEXELZ0','20','D','10','209',NULL,'Residential_City',NULL,NULL,'"drvResidential_City"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EPAYFLEXELZ0','2','D','10','229',NULL,'Residential_State',NULL,NULL,'"drvResidential_State"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EPAYFLEXELZ0','10','D','10','231',NULL,'Residential_Zip_Code',NULL,NULL,'"drvResidential_Zip_Code"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EPAYFLEXELZ0','3','D','10','241',NULL,'Residential_Country Code',NULL,NULL,'"drvResidential_CountryCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EPAYFLEXELZ0','7','D','10','244',NULL,'Control',NULL,NULL,'"drvControl"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EPAYFLEXELZ0','3','D','10','251',NULL,'Suffix',NULL,NULL,'"drvSuffix"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EPAYFLEXELZ0','3','D','10','254',NULL,'Account',NULL,NULL,'"drvAccount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EPAYFLEXELZ0','10','D','10','257',NULL,'Copay Code–Medical',NULL,NULL,'"drvCopayCodeMedical"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EPAYFLEXELZ0','10','D','10','267',NULL,'Copay Code-Dental',NULL,NULL,'"drvCopayCodeDental"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EPAYFLEXELZ0','10','D','10','277',NULL,'Copay Code-Vision',NULL,NULL,'"drvCopayCodeVision"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EPAYFLEXELZ0','10','D','10','287',NULL,'Copay Code-RX',NULL,NULL,'"drvCopayCodeRX"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EPAYFLEXELZ0','1','D','10','297',NULL,'Coverage_ Level',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EPAYFLEXELZ0','81','D','10','298',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EPAYFLEXELZ0','50','D','10','379',NULL,'Email_Address',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EPAYFLEXELZ0','10','D','10','429',NULL,'Payroll_Schedule_ID',NULL,NULL,'"drvPayroll_Schedule_ID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EPAYFLEXELZ0','17','D','10','439',NULL,'Bank_Account_Number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EPAYFLEXELZ0','17','D','10','456',NULL,'Bank_Routing_Number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EPAYFLEXELZ0','3','D','10','473',NULL,'Bank Account Type',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EPAYFLEXELZ0','15','D','10','476',NULL,'Driver_License_Number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EPAYFLEXELZ0','2','D','10','491',NULL,'Driver_License_Issue_Authority',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EPAYFLEXELZ0','10','D','10','493',NULL,'Plan_Year_Effective',NULL,NULL,'"drvPlan_Year_Effective"','(''UD101''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EPAYFLEXELZ0','2','D','10','503',NULL,'Account_Type',NULL,NULL,'"drvAccount_Type"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EPAYFLEXELZ0','10','D','10','505',NULL,'Election_Effective_Date',NULL,NULL,'"drvElection_Effective_Date"','(''UD101''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EPAYFLEXELZ0','8','D','10','515',NULL,'Annual_Deduction',NULL,NULL,'"drvAnnualDeduction"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EPAYFLEXELZ0','8','D','10','523',NULL,'Annual_Contribution',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EPAYFLEXELZ0','8','D','10','531',NULL,'Scheduled_Deduction',NULL,NULL,'"drvScheduledDeduction"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EPAYFLEXELZ0','8','D','10','539',NULL,'Scheduled_Contribution',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EPAYFLEXELZ0','1','D','10','547',NULL,'Debit_Card_Selected',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EPAYFLEXELZ0','1','D','10','548',NULL,'Auto_Pay_Dental',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EPAYFLEXELZ0','1','D','10','549',NULL,'Auto_Pay_Healthcare',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EPAYFLEXELZ0','1','D','10','550',NULL,'Auto_Pay_Vision',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EPAYFLEXELZ0','1','D','10','551',NULL,'Auto_Pay_RX',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EPAYFLEXELZ0','1','D','10','552',NULL,'FSA_First',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EPAYFLEXELZ0','10','D','10','553',NULL,'Election_Expiration_Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EPAYFLEXELZ0','10','D','10','563',NULL,'LtdFSA_Ded_Met_Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EPAYFLEXELZ0','1','D','10','573',NULL,'Commuter_Transit',NULL,NULL,'"drvCommuter_Transit"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EPAYFLEXELZ0','1','D','10','574',NULL,'Commuter_Parking',NULL,NULL,'"drvCommuter_Parking"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EPAYFLEXELZ0','1','D','10','575',NULL,'Wellness_Status',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EPAYFLEXELZ0','10','D','10','576',NULL,'Wellness_Location',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPAYFLEXELZ0','1','T','90','1',NULL,'Record_Indicator',NULL,NULL,'"drvRecord_Indicator"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPAYFLEXELZ0','10','T','90','2',NULL,'Record_Count',NULL,NULL,'"drvRecord_Count"','(''UA''=''F'')');

-----------
-- Build web filename
-----------

/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME, 1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME, 3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME, 2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME, 3) ELSE LEFT(@@SERVERNAME, 2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME, 2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME, 3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FileName varchar(1000) = 'EPAYFLEXEL_20220107.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','202104099','EMPEXPORT','OEACTIVE','Jun 30 2021  6:16PM','EPAYFLEXEL',NULL,NULL,NULL,'202104099','Apr  9 2021 12:00AM','Dec 30 1899 12:00AM','202104091','2','','','202104091',dbo.fn_GetTimedKey(),NULL,'RVAS',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202104099','EMPEXPORT','OEPASSIVE',NULL,'EPAYFLEXEL',NULL,NULL,NULL,'202104099','Apr  9 2021  7:09AM','Apr  9 2021  7:09AM','202104091',NULL,'','','202104091',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'PayFlex Eligibility Export','202104099','EMPEXPORT','ONDEM_XOE',NULL,'EPAYFLEXEL',NULL,NULL,NULL,'202104099','Apr  9 2021  7:09AM','Apr  9 2021  7:09AM','202104091',NULL,'','','202104091',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N','58879',NULL,NULL,NULL,'PayFlex Eligibility Expo-Sched','202104099','EMPEXPORT','SCH_EPAYFL',NULL,'EPAYFLEXEL',NULL,NULL,NULL,'202201069','Apr  9 2021  7:09AM','Apr  9 2021  7:09AM','202112301',NULL,'','','202104091',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'PayFlex Eligibility Expo-Test','202105059','EMPEXPORT','TEST_XOE','Jul 21 2021  3:20PM','EPAYFLEXEL',NULL,NULL,NULL,'202105059','May  5 2021 12:00AM','Dec 30 1899 12:00AM','202104011','186','','','202104011',dbo.fn_GetTimedKey(),NULL,'RVAS',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPAYFLEXEL','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPAYFLEXEL','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPAYFLEXEL','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPAYFLEXEL','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPAYFLEXEL','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPAYFLEXEL','H01','dbo.U_EPAYFLEXEL_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPAYFLEXEL','D10','dbo.U_EPAYFLEXEL_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPAYFLEXEL','T90','dbo.U_EPAYFLEXEL_Trailer',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EPAYFLEXEL
-----------

IF OBJECT_ID('U_dsi_BDM_EPAYFLEXEL') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EPAYFLEXEL] (
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

-----------
-- Create table U_EPAYFLEXEL_Audit
-----------

IF OBJECT_ID('U_EPAYFLEXEL_Audit') IS NULL
CREATE TABLE [dbo].[U_EPAYFLEXEL_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audKey2] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] nvarchar(2000) NULL,
    [audNewValue] nvarchar(2000) NULL,
    [audRowNo] bigint NULL
);

-----------
-- Create table U_EPAYFLEXEL_AuditFields
-----------

IF OBJECT_ID('U_EPAYFLEXEL_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EPAYFLEXEL_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EPAYFLEXEL_DedList
-----------

IF OBJECT_ID('U_EPAYFLEXEL_DedList') IS NULL
CREATE TABLE [dbo].[U_EPAYFLEXEL_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EPAYFLEXEL_drvTbl
-----------

IF OBJECT_ID('U_EPAYFLEXEL_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EPAYFLEXEL_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvEmployer_ID] varchar(6) NOT NULL,
    [drvMember_Number] char(11) NULL,
    [drvSocial_Security_Number] char(11) NULL,
    [drvFirst_Name] varchar(100) NULL,
    [drvLast_Name] varchar(100) NULL,
    [drvBirth_Date] datetime NULL,
    [drvEmployee_Status_Date] datetime NULL,
    [drvEmployee_Status] varchar(1) NULL,
    [drvResidential_Address_Line_1] varchar(255) NULL,
    [drvResidential_Address_Line_2] varchar(255) NULL,
    [drvResidential_City] varchar(255) NULL,
    [drvResidential_State] varchar(255) NULL,
    [drvResidential_Zip_Code] varchar(50) NULL,
    [drvResidential_CountryCode] varchar(3) NOT NULL,
    [drvControl] varchar(7) NULL,
    [drvSuffix] varchar(3) NULL,
    [drvAccount] varchar(3) NOT NULL,
    [drvCopayCodeMedical] varchar(1) NOT NULL,
    [drvCopayCodeDental] varchar(1) NOT NULL,
    [drvCopayCodeVision] varchar(1) NOT NULL,
    [drvCopayCodeRX] varchar(1) NOT NULL,
    [drvPayroll_Schedule_ID] varchar(6) NOT NULL,
    [drvPlan_Year_Effective] varchar(10) NOT NULL,
    [drvAccount_Type] varchar(2) NULL,
    [drvElection_Effective_Date] datetime NULL,
    [drvAnnualDeduction] varchar(30) NULL,
    [drvScheduledDeduction] varchar(30) NULL,
    [drvCommuter_Transit] varchar(1) NOT NULL,
    [drvCommuter_Parking] varchar(1) NOT NULL
);

-----------
-- Create table U_EPAYFLEXEL_EEList
-----------

IF OBJECT_ID('U_EPAYFLEXEL_EEList') IS NULL
CREATE TABLE [dbo].[U_EPAYFLEXEL_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EPAYFLEXEL_File
-----------

IF OBJECT_ID('U_EPAYFLEXEL_File') IS NULL
CREATE TABLE [dbo].[U_EPAYFLEXEL_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(585) NULL
);

-----------
-- Create table U_EPAYFLEXEL_Header
-----------

IF OBJECT_ID('U_EPAYFLEXEL_Header') IS NULL
CREATE TABLE [dbo].[U_EPAYFLEXEL_Header] (
    [drvRecord_Indicator] varchar(1) NOT NULL,
    [drvFormat_Type] varchar(1) NOT NULL,
    [drvLayout_Type] varchar(1) NOT NULL,
    [drvDate_Created] datetime NOT NULL,
    [drvTime_Created] varchar(8000) NULL,
    [drvEmployer_ID] varchar(6) NOT NULL,
    [drvEmployer_Name] varchar(11) NOT NULL,
    [drvOnline_Enrollment] varchar(1) NOT NULL,
    [drvOnline_Commuter] varchar(1) NOT NULL,
    [drvChange_Only] varchar(1) NOT NULL
);

-----------
-- Create table U_EPAYFLEXEL_PDedHist
-----------

IF OBJECT_ID('U_EPAYFLEXEL_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EPAYFLEXEL_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhCOID] char(5) NOT NULL,
    [PdhDedCode] char(5) NOT NULL,
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

-----------
-- Create table U_EPAYFLEXEL_PEarHist
-----------

IF OBJECT_ID('U_EPAYFLEXEL_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EPAYFLEXEL_PEarHist] (
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

-----------
-- Create table U_EPAYFLEXEL_Trailer
-----------

IF OBJECT_ID('U_EPAYFLEXEL_Trailer') IS NULL
CREATE TABLE [dbo].[U_EPAYFLEXEL_Trailer] (
    [drvRecord_Indicator] varchar(1) NOT NULL,
    [drvRecord_Count] int NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EPAYFLEXEL]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Mercy Corps

Created By: Inshan Singh
Business Analyst: Richard Vars
Create Date: 04/09/2021
Service Request Number: TekP-2020-11-18-0002

Purpose: PayFlex Eligibility Export 

Revision History
----------------
Modified By: Andy Pineda
Date: 05/12/2021
Change:
    - Member_Number change
    - Control change
    - Copay code fields space fill
    - Election effective date change
    - Annual Deduction field add
Modified By: Andy Pineda
Date: 05/18/2021
Change:
    - Added BdmEEGoalAmt to the Annual Deduction field
    - Added PdhEEAmt to the Scheduled Deduction field
    - Updated logic for Commuter Transit
    - Updated logic for Commuter Parking
    
06/21/2021 by AP:
         - Set amounts to NULL if = 0.00.

07/12/2021 by AP:
        - Updated logic for drvcontrol yet again.
        - Added HSAFC dedcode to the dedcode list (was missing).

01/07/2022 by AP:
	- Dynamic year change for drvPlan_Year_Effective.

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EPAYFLEXEL';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EPAYFLEXEL';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EPAYFLEXEL';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EPAYFLEXEL';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EPAYFLEXEL' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPAYFLEXEL', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPAYFLEXEL', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPAYFLEXEL', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPAYFLEXEL', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPAYFLEXEL', 'SCH_EPAYFL';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EPAYFLEXEL';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EPAYFLEXEL', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EPAYFLEXEL';

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
    DELETE FROM dbo.U_EPAYFLEXEL_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EPAYFLEXEL_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EPAYFLEXEL_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EPAYFLEXEL_AuditFields;
    CREATE TABLE dbo.U_EPAYFLEXEL_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_EPAYFLEXEL_AuditFields VALUES ('EmpComp','EecEmplStatus');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EPAYFLEXEL_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EPAYFLEXEL_Audit;
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
    INTO dbo.U_EPAYFLEXEL_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EPAYFLEXEL_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EPAYFLEXEL_Audit ON dbo.U_EPAYFLEXEL_Audit (audEEID,audKey2);

    --================
    -- Changes Only
    --================
    --DELETE FROM dbo.U_EPAYFLEXEL_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EPAYFLEXEL_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'DPFSA,HFSA,HFSAL,HSAEC,HSAFC,HSAEE,HSAFM,PARK1,TRANS';

    IF OBJECT_ID('U_EPAYFLEXEL_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EPAYFLEXEL_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EPAYFLEXEL_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes', @DedList);
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedTypes', 'HSA,FSA');
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
    IF OBJECT_ID('U_EPAYFLEXEL_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EPAYFLEXEL_PDedHist;
    SELECT DISTINCT
         PdhEEID
        ,PdhCOID
        ,PdhDedCode
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
    INTO dbo.U_EPAYFLEXEL_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EPAYFLEXEL_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID, PdhCOID, PdhDedCode
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );


    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EPAYFLEXEL_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EPAYFLEXEL_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_EPAYFLEXEL_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EPAYFLEXEL_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EPAYFLEXEL_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EPAYFLEXEL_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvEmployer_ID = '151240'
        ,drvMember_Number = EepSSN --EecEmpNo --EepSsn
        ,drvSocial_Security_Number = EepSsn
        ,drvFirst_Name = EepNameFirst
        ,drvLast_Name = EepNameLast
        ,drvBirth_Date = eepdateofbirth
        ,drvEmployee_Status_Date = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination else NULL END
        ,drvEmployee_Status = CASE WHEN EecEmplStatus = 'T' THEN 'T' END
        ,drvResidential_Address_Line_1 = Eepaddressline1
        ,drvResidential_Address_Line_2 = Eepaddressline2
        ,drvResidential_City = EepAddressCity
        ,drvResidential_State = EepAddressState
        ,drvResidential_Zip_Code = EepAddressZipCode
        ,drvResidential_CountryCode = 'USA'
        ,drvControl = CASE WHEN EedDedCode IN ('DPFSA', 'HFSA', 'HFSAL') THEN '0170551' 
                            WHEN EedDedCode IN ('HFSAL', 'HSAEE', 'HSAEC', 'HSAFC', 'HSAFM') THEN '0170546' END
        --CASE WHEN EedDedCode IN ('HFSAL', 'HSAEE', 'HSAEC', 'HSAFC', 'HSAFM') THEN '0170546' END
        --'0170551' --'0170546' --'0170551'
        ,drvSuffix = CASE
                        WHEN eeddedcode IN ('DPFSA', 'HFSA') THEN '010'
                        WHEN eeddedcode  IN ('HFSAL', 'HSAEE', 'HSAEC', 'HSAFC', 'HSAFM') THEN '011'
                     END
        ,drvAccount = '000'
        ,drvCopayCodeMedical = ''-- 'No'
        ,drvCopayCodeDental = ''--'No'
        ,drvCopayCodeVision = ''--'No'
        ,drvCopayCodeRX = ''--'No'
        ,drvPayroll_Schedule_ID = '169702'
        ,drvPlan_Year_Effective = CONCAT(YEAR(GETDATE()), '/01/01') -- dynamic year change
        ,drvAccount_Type = CASE
                            WHEN eeddedcode = 'DPFSA' THEN '4'
                            WHEN eeddedcode = 'HFSA' THEN '5'
                            WHEN eeddedcode = 'PARK1' THEN '7'
                            WHEN eeddedcode = 'TRAN' THEN '8' 
                            WHEN eeddedcode = 'HFSAL' THEN '11'
                            WHEN eeddedcode IN ('HFSAL', 'HSAEE', 'HSAEC', 'HSAFC', 'HSAFM') THEN '16'
                           END
        ,drvElection_Effective_Date = CASE WHEN CAST(EedBenStartDate AS DATE) > '01/01/2021' THEN EedBenStartDate ELSE '01/01/2021' END --bdmBenStartDate
        ,drvAnnualDeduction = CAST(CASE WHEN eeddedcode IN ('DPFSA', 'HFSAL', 'HFSA') THEN EedEEGoalAmt ELSE '' END AS VARCHAR)
        ,drvScheduledDeduction = CAST(CASE WHEN eeddedcode IN ('DPFSA', 'HFSAL', 'HFSA') THEN EedEEAmt ELSE '' END AS VARCHAR)
        --CASE WHEN PdhDedCode IN ('DPFSA', 'HFSAL', 'HFSA') THEN CAST(CAST(PdhEECurAmt AS DECIMAL(5,2)) AS VARCHAR) END
        ,drvCommuter_Transit = CASE WHEN eeddedcode = 'TRAN' THEN 'T' ELSE 'F' END
        ,drvCommuter_Parking = CASE WHEN eeddedcode = 'PARK1' THEN 'T' ELSE 'F' END
    INTO dbo.U_EPAYFLEXEL_drvTbl
    FROM dbo.U_EPAYFLEXEL_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID and EecCOID = xCOID AND eecEETYPE <> 'TES'
    JOIN dbo.U_dsi_bdm_EmpDeductions with(nolock)
        on eedeeid = xeeid
        and eedcoid = xcoid
        and eedvalidforexport = 'y'
        and eedformatcode = @formatcode
    --JOIN dbo.U_dsi_BDM_EPAYFLEXEL WITH (NOLOCK)
    --    ON BdmEEID = xEEID 
    --    AND BdmCoID = xCoID and bdmDedCode in ('DPFSA','HFSA','HFSAL','HSAEC','HSAEE','HSAFM','PARK1','TRANS')
  --  JOIN dbo.U_EPAYFLEXEL_PDedHist WITH(NOLOCK)
        --ON PdhEEID = xEEID
        --AND PdhCOID = xCOID
    ;

    UPDATE dbo.U_EPAYFLEXEL_drvTbl
    SET drvAnnualDeduction = NULLIF(drvAnnualDeduction, '0.00')

    UPDATE dbo.U_EPAYFLEXEL_drvTbl
    SET drvScheduledDeduction = NULLIF(drvScheduledDeduction, '0.00')
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EPAYFLEXEL_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EPAYFLEXEL_Header;
    SELECT DISTINCT
         drvRecord_Indicator = 'H'
        ,drvFormat_Type = 'F'
        ,drvLayout_Type = 'E'
        ,drvDate_Created = GETDATE()
        ,drvTime_Created = REPLACE(CONVERT(VARCHAR(8),GETDATE(),108),':','')
        ,drvEmployer_ID = '151240'
        ,drvEmployer_Name = 'Mercy Corps'
        ,drvOnline_Enrollment = 'F'
        ,drvOnline_Commuter = 'F'
        ,drvChange_Only = 'T'
    INTO dbo.U_EPAYFLEXEL_Header
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EPAYFLEXEL_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_EPAYFLEXEL_Trailer;
    SELECT DISTINCT
         drvRecord_Indicator = 'T'
        ,drvRecord_Count = (SELECT COUNT(*) FROM dbo.U_EPAYFLEXEL_drvTbl WITH (NOLOCK)) + 2
    INTO dbo.U_EPAYFLEXEL_Trailer
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_PF.PFM.169702_Eligibility_' + CONVERT(VARCHAR(8),GETDATE(),112) + '_hhmmss.txt'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'PF.PFM.169702_OE_' + CONVERT(VARCHAR(8),GETDATE(),112) + '_hhmmss.txt'
                                  ELSE 'PF.PFM.169702_Eligibility_' + CONVERT(VARCHAR(8),GETDATE(),112) + '_hhmmss.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEPAYFLEXEL_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EPAYFLEXEL_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EPAYFLEXEL%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202104021'
       ,expStartPerControl     = '202104021'
       ,expLastEndPerControl   = '202104099'
       ,expEndPerControl       = '202104099'
WHERE expFormatCode = 'EPAYFLEXEL';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEPAYFLEXEL_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EPAYFLEXEL_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EPAYFLEXEL' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EPAYFLEXEL'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EPAYFLEXEL'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EPAYFLEXEL', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EPAYFLEXEL', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EPAYFLEXEL', 'UseFileName', 'V', 'Y'


-- End ripout