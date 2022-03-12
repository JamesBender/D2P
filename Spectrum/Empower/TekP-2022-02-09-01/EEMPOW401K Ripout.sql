/**********************************************************************************

EEMPOW401K: Empower 401k Export

FormatCode:     EEMPOW401K
Project:        Empower 401k Export
Client ID:      SPE1014
Date/time:      2022-03-12 05:08:17.450
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW3WUP4DB01
Database:       ULTIPRO_WPRTIRE
Web Filename:   SPE1014_71B83_EEHISTORY_EEMPOW401K_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EEMPOW401K_SavePath') IS NOT NULL DROP TABLE dbo.U_EEMPOW401K_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EEMPOW401K'


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
WHERE FormatCode = 'EEMPOW401K'
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
WHERE ExpFormatCode = 'EEMPOW401K'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EEMPOW401K')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EEMPOW401K'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EEMPOW401K'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EEMPOW401K'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EEMPOW401K'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EEMPOW401K'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EEMPOW401K'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EEMPOW401K'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EEMPOW401K'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EEMPOW401K'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEEMPOW401K_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEEMPOW401K_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EEMPOW401K') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EEMPOW401K];
GO
IF OBJECT_ID('U_EEMPOW401K_TermKeyed') IS NOT NULL DROP TABLE [dbo].[U_EEMPOW401K_TermKeyed];
GO
IF OBJECT_ID('U_EEMPOW401K_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EEMPOW401K_PEarHist];
GO
IF OBJECT_ID('U_EEMPOW401K_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EEMPOW401K_PDedHist];
GO
IF OBJECT_ID('U_EEMPOW401K_File') IS NOT NULL DROP TABLE [dbo].[U_EEMPOW401K_File];
GO
IF OBJECT_ID('U_EEMPOW401K_EEList') IS NOT NULL DROP TABLE [dbo].[U_EEMPOW401K_EEList];
GO
IF OBJECT_ID('U_EEMPOW401K_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EEMPOW401K_drvTbl];
GO
IF OBJECT_ID('U_EEMPOW401K_DedList') IS NOT NULL DROP TABLE [dbo].[U_EEMPOW401K_DedList];
GO
IF OBJECT_ID('U_EEMPOW401K_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EEMPOW401K_AuditFields];
GO
IF OBJECT_ID('U_EEMPOW401K_Audit') IS NOT NULL DROP TABLE [dbo].[U_EEMPOW401K_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EEMPOW401K') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EEMPOW401K];
GO
IF OBJECT_ID('U__EEMPOW401K_JobHistTbl') IS NOT NULL DROP TABLE [dbo].[U__EEMPOW401K_JobHistTbl];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EEMPOW401K','Empower 401k Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','EEMPOW401KZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EEMPOW401KZ0','13','D','10','1',NULL,'Plan Number',NULL,NULL,'"509383-01"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EEMPOW401KZ0','11','D','10','14',NULL,'Employee SSN',NULL,NULL,'"drvSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EEMPOW401KZ0','20','D','10','25',NULL,'Division number',NULL,NULL,'"drvDivisionNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EEMPOW401KZ0','35','D','10','45',NULL,'Last Name',NULL,NULL,'"drvNameLast"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EEMPOW401KZ0','20','D','10','80',NULL,'First Name',NULL,NULL,'"drvNameFirst"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EEMPOW401KZ0','20','D','10','100',NULL,'Middle Name',NULL,NULL,'"drvNameMiddle"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EEMPOW401KZ0','15','D','10','120',NULL,'Name Suffix',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EEMPOW401KZ0','10','D','10','135',NULL,'Birth Date',NULL,NULL,'"drvDateOfBirth"','(''UD101''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EEMPOW401KZ0','1','D','10','145',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EEMPOW401KZ0','1','D','10','146',NULL,'Marital Status',NULL,NULL,'"drvMaritalStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EEMPOW401KZ0','35','D','10','147',NULL,'Address Line 1',NULL,NULL,'"drvAddressLine1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EEMPOW401KZ0','35','D','10','182',NULL,'Address Line 2',NULL,NULL,'"drvAddressLin2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EEMPOW401KZ0','20','D','10','217',NULL,'City',NULL,NULL,'"drvAddressCity"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EEMPOW401KZ0','2','D','10','237',NULL,'State',NULL,NULL,'"drvAddressState"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EEMPOW401KZ0','10','D','10','239',NULL,'Zip Code',NULL,NULL,'"drvAddressZipCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EEMPOW401KZ0','10','D','10','249',NULL,'Home Phone Number',NULL,NULL,'"drvPhoneHomeNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EEMPOW401KZ0','10','D','10','259',NULL,'Work Phone Number',NULL,NULL,'"drvPhoneBusinessNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EEMPOW401KZ0','4','D','10','269',NULL,'Work Phone Ext.',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EEMPOW401KZ0','2','D','10','273',NULL,'Country Code',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EEMPOW401KZ0','10','D','10','275',NULL,'Hire Date',NULL,NULL,'"drvHireDate"','(''UD101''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EEMPOW401KZ0','10','D','10','285',NULL,'Termination Date',NULL,NULL,'"drvTerminationDate"','(''UD101''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EEMPOW401KZ0','10','D','10','295',NULL,'Re-Hire Date',NULL,NULL,'"drvRehireDate"','(''UD101''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EEMPOW401KZ0','10','D','10','305',NULL,'Checkdate',NULL,NULL,'"drvCheckDate"','(''UD101''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EEMPOW401KZ0','10','D','10','315',NULL,'Pre-tax',NULL,NULL,'"drvPreTax"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EEMPOW401KZ0','10','D','10','325',NULL,'Match',NULL,NULL,'"drvMatch"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EEMPOW401KZ0','10','D','10','335',NULL,'Loans',NULL,NULL,'"drvLoans"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EEMPOW401KZ0','10','D','10','345',NULL,'Roth',NULL,NULL,'"drvRoth"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EEMPOW401KZ0','10','D','10','355',NULL,'Contribution Amount 5',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EEMPOW401KZ0','10','D','10','365',NULL,'Contribution Amount 6',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EEMPOW401KZ0','10','D','10','375',NULL,'Contribution Amount 7',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EEMPOW401KZ0','10','D','10','385',NULL,'Contribution Amount 8',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EEMPOW401KZ0','5','D','10','395',NULL,'Hours Worked',NULL,NULL,'"drvHoursWorked"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EEMPOW401KZ0','11','D','10','400',NULL,'YTD Total Compensation',NULL,NULL,'"drvYTDTotalComp"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EEMPOW401KZ0','11','D','10','411',NULL,'YTD Plan Compensation',NULL,NULL,'"drvYTDPlanComp"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EEMPOW401KZ0','11','D','10','422',NULL,'YTD Pre Entry Compensation',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EEMPOW401KZ0','1','D','10','433',NULL,'Highly Comp Employee Code',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EEMPOW401KZ0','6','D','10','434',NULL,'Percent of Ownership',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EEMPOW401KZ0','1','D','10','440',NULL,'Officer Determination',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EEMPOW401KZ0','10','D','10','441',NULL,'Participation Date',NULL,NULL,'"drvParticipationDate"','(''UD101''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EEMPOW401KZ0','1','D','10','451',NULL,'Eligibility Code',NULL,NULL,'"Y"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EEMPOW401KZ0','1','D','10','452',NULL,'LOA Reason Code',NULL,NULL,'"drvLoaReasonCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EEMPOW401KZ0','10','D','10','453',NULL,'LOA Start Date',NULL,NULL,'"drvLoaStartDate"','(''UD101''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EEMPOW401KZ0','10','D','10','463',NULL,'LOA End Date',NULL,NULL,'"drvLoaEndDate"','(''UD101''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EEMPOW401KZ0','1','D','10','473',NULL,'Officer Determination',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EEMPOW401KZ0','40','D','10','474',NULL,'Work Email Address',NULL,NULL,'"drvWorkEmailAddress"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EEMPOW401KZ0','17','D','10','515',NULL,'Salary Amount',NULL,NULL,'"drvSalaryAmount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EEMPOW401KZ0','2','D','10','531',NULL,'Salary Amount Qualifier',NULL,NULL,'"A"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EEMPOW401KZ0','20','D','10','533',NULL,'Termination Reason Code',NULL,NULL,'"drvTermReasonCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EEMPOW401KZ0','1','D','10','553',NULL,'Sarbanes Oxley Reporting Indicator',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EEMPOW401KZ0','6','D','10','554',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EEMPOW401KZ0','2','D','10','560',NULL,'Federal Exemptions',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EEMPOW401KZ0','10','D','10','562',NULL,'Employer Assigned ID',NULL,NULL,'"drvEmplAssignedId"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EEMPOW401KZ0','6','D','10','572',NULL,'Compliance Status Code',NULL,NULL,'"drvComplianceStatusCode"','(''UA''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EEMPOW401K_20220312.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','202202251','EMPEXPORT','OEACTIVE','Feb 24 2022  3:13PM','EEMPOW401K',NULL,NULL,NULL,'202202251','Feb 25 2022 12:00AM','Feb 15 2022 12:00AM','202202251','2446','eecPayGroup','SRMIL,SRMNM,SRCAZ,SRCCO,SRCIL,SRCIN,SRCKS,SRCMAZ,SRCMCO,SRCMO,SRCNM,SRCOH,SRCOPS,SRCOR,SRCTX','202202251',dbo.fn_GetTimedKey(),NULL,'ULTI_WPRTIRE',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202004249','EMPEXPORT','OEPASSIVE',NULL,'EEMPOW401K',NULL,NULL,NULL,'202004249','Apr  1 2020 10:38AM','Apr  1 2020 10:38AM','202004241',NULL,'','','202004241',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','ZLXKO,ZLXEN,ZLXIY,ZLXFP,ZLX6Z,ZLXAY,6PJW1,6PK5J,ZLXGT,ZLXBY,ZLX92,ZLXCU,ZLXDO,ZLX9U,ZLXLO,ZLXJX,0YDGF,ZLXHP,7RV7K',NULL,NULL,NULL,'Empower 401k Export','202202251','EMPEXPORT','ONDEMAND','Feb 24 2022  3:16PM','EEMPOW401K',NULL,NULL,NULL,'202202251','Feb 25 2022 12:00AM','Feb 15 2022 12:00AM','202202251','2446','eecPayGroup','SRMIL,SRMNM,SRCAZ,SRCCO,SRCIL,SRCIN,SRCKS,SRCMAZ,SRCMCO,SRCMO,SRCNM,SRCOH,SRCOPS,SRCOR,SRCTX','202202251',dbo.fn_GetTimedKey(),NULL,'ULTI_WPRTIRE',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','202004249','EMPEXPORT','SCHEDULED',NULL,'EEMPOW401K',NULL,NULL,NULL,'202004249','Apr  1 2020 10:38AM','Apr  1 2020 10:38AM','202004241',NULL,'','','202004241',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','ZLXEN,ZLXFP,ZLX6Z,ZLXAY,6PJW1,6PK5J,ZLXGT,ZLXBY,ZLX92,ZLXCU,ZLXDO,ZLX9U,ZLXLO,ZLXJX,0YDGF,ZLXHP,7RV7K',NULL,NULL,NULL,'Test Purposes Only','202203101','EMPEXPORT','TEST','Feb 28 2022 12:00AM','EEMPOW401K',NULL,NULL,NULL,'202203101','Feb 10 2022 12:00AM','Jan 31 2022 12:00AM','202203101','2808','',NULL,'202203101',dbo.fn_GetTimedKey(),NULL,'us3lKiSPE1014A',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEMPOW401K','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEMPOW401K','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEMPOW401K','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEMPOW401K','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEMPOW401K','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EEMPOW401K','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EEMPOW401K','D10','dbo.U_EEMPOW401K_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U__EEMPOW401K_JobHistTbl
-----------

IF OBJECT_ID('U__EEMPOW401K_JobHistTbl') IS NULL
CREATE TABLE [dbo].[U__EEMPOW401K_JobHistTbl] (
    [EjhEEID] char(12) NOT NULL,
    [EjhCOID] char(5) NOT NULL,
    [EjhIsTransfer] char(1) NULL,
    [EjhReason] char(6) NOT NULL
);

-----------
-- Create table U_dsi_BDM_EEMPOW401K
-----------

IF OBJECT_ID('U_dsi_BDM_EEMPOW401K') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EEMPOW401K] (
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
-- Create table U_EEMPOW401K_Audit
-----------

IF OBJECT_ID('U_EEMPOW401K_Audit') IS NULL
CREATE TABLE [dbo].[U_EEMPOW401K_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audCOID] varchar(255) NOT NULL,
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
-- Create table U_EEMPOW401K_AuditFields
-----------

IF OBJECT_ID('U_EEMPOW401K_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EEMPOW401K_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EEMPOW401K_DedList
-----------

IF OBJECT_ID('U_EEMPOW401K_DedList') IS NULL
CREATE TABLE [dbo].[U_EEMPOW401K_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EEMPOW401K_drvTbl
-----------

IF OBJECT_ID('U_EEMPOW401K_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EEMPOW401K_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] int NULL,
    [drvSSN] char(11) NULL,
    [drvDivisionNumber] char(5) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(50) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvGender] char(1) NULL,
    [drvMaritalStatus] varchar(1) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLin2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvPhoneHomeNumber] varchar(50) NULL,
    [drvPhoneBusinessNumber] varchar(50) NULL,
    [drvHireDate] datetime NULL,
    [drvTerminationDate] datetime NULL,
    [drvRehireDate] datetime NULL,
    [drvCheckDate] datetime NULL,
    [drvPreTax] nvarchar(4000) NULL,
    [drvMatch] nvarchar(4000) NULL,
    [drvLoans] nvarchar(4000) NULL,
    [drvRoth] nvarchar(4000) NULL,
    [drvHoursWorked] nvarchar(4000) NULL,
    [drvYTDTotalComp] nvarchar(4000) NULL,
    [drvYTDPlanComp] nvarchar(4000) NULL,
    [drvParticipationDate] datetime NULL,
    [drvLoaReasonCode] varchar(1) NULL,
    [drvLoaStartDate] datetime NULL,
    [drvLoaEndDate] datetime NULL,
    [drvWorkEmailAddress] varchar(50) NULL,
    [drvSalaryAmount] money NULL,
    [drvTermReasonCode] varchar(1) NULL,
    [drvEmplAssignedId] char(9) NULL,
    [drvComplianceStatusCode] varchar(1) NULL
);

-----------
-- Create table U_EEMPOW401K_EEList
-----------

IF OBJECT_ID('U_EEMPOW401K_EEList') IS NULL
CREATE TABLE [dbo].[U_EEMPOW401K_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EEMPOW401K_File
-----------

IF OBJECT_ID('U_EEMPOW401K_File') IS NULL
CREATE TABLE [dbo].[U_EEMPOW401K_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(1000) NULL
);

-----------
-- Create table U_EEMPOW401K_PDedHist
-----------

IF OBJECT_ID('U_EEMPOW401K_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EEMPOW401K_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhPreTaxAmt] numeric NULL,
    [PdhMatchAmt] numeric NULL,
    [PdhLoansAmt] numeric NULL,
    [PdhRothAmt] numeric NULL
);

-----------
-- Create table U_EEMPOW401K_PEarHist
-----------

IF OBJECT_ID('U_EEMPOW401K_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EEMPOW401K_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PehCurAmt] numeric NULL,
    [PehCurHrs] decimal NULL,
    [PehCurAmtYTD] money NULL,
    [PehCurPlanAmtYTD] numeric NULL,
    [PehCurHrsYTD] decimal NULL,
    [PehInclInDefComp] money NULL,
    [PehInclInDefCompHrs] decimal NULL,
    [PehInclInDefCompYTD] money NULL,
    [PehInclInDefCompHrsYTD] decimal NULL,
    [PehHourWorked] decimal NULL
);

-----------
-- Create table U_EEMPOW401K_TermKeyed
-----------

IF OBJECT_ID('U_EEMPOW401K_TermKeyed') IS NULL
CREATE TABLE [dbo].[U_EEMPOW401K_TermKeyed] (
    [tkdEEID] varchar(30) NULL,
    [tkdCOID] varchar(30) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EEMPOW401K]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Spectrum Retirement Community

Created By: James Bender
Business Analyst: Lea King
Create Date: 04/01/2020
Service Request Number: TekP-2020-01-31-001

Purpose: Empower 401k Export

Revision History
----------------
Update By           Date           Request Num                Desc
Inshan Singh       02/25/2021      TekP-2021-01-27-0004        Update company code and fix issue for supplemental percontrol sequence not producing file
Darren Collard       02/27/2022      TekP-2022-02-09-01       Update Term Logic, and YTD Comp
Darren Collard     03/12/2022      TekP-2022-02-09-01       Include Terms keyed in last 30 days      

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EEMPOW401K';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EEMPOW401K';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EEMPOW401K';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EEMPOW401K';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EEMPOW401K' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEMPOW401K', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEMPOW401K', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEMPOW401K', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEMPOW401K', 'TEST';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EEMPOW401K';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EEMPOW401K', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EEMPOW401K';

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
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EEMPOW401K_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EEMPOW401K_AuditFields;
    CREATE TABLE dbo.U_EEMPOW401K_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_EEMPOW401K_AuditFields VALUES ('EmpComp','EecEmplStatus');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EEMPOW401K_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EEMPOW401K_Audit;
    SELECT 
        audEEID  = audKey1Value
        ,audCOID = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    INTO dbo.U_EEMPOW401K_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EEMPOW401K_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE (audDateTime BETWEEN @StartDate AND @EndDate AND audOldValue = 'L' AND audNewValue = 'A' AND audAction <> 'DELETE') --Back from LOA

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EEMPOW401K_Audit ON dbo.U_EEMPOW401K_Audit (audEEID,audCOID);


    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EEMPOW401K_EEList
    WHERE xCoID <> dbo.dsi_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EEMPOW401K_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_EEMPOW401K_EEList 
    WHERE xEEID IN (
        SELECT DISTINCT EecEEID from EmpComp where eecEEType IN('CON','REG')
    );

    DELETE FROM dbo.U_EEMPOW401K_EEList 
    WHERE xEEID IN (
        SELECT DISTINCT EepEEID from EmpPers WHERE EepSSN IN ('999999999')
    );

    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EEMPOW401K_TermKeyed','U') IS NOT NULL
        DROP TABLE dbo.U_EEMPOW401K_TermKeyed;
    CREATE TABLE dbo.U_EEMPOW401K_TermKeyed (tkdEEID varchar(30), tkdCOID varchar(30));


    --===================================================
    -- Identify Terms keyed in past 30 days
    -- NOTE: this is much faster that using audit table
    --===================================================
    INSERT INTO dbo.U_EEMPOW401K_TermKeyed 
    SELECT tkdEEID = xEEID, 
           tkdCOID = xCOID
    FROM [dbo].[U_EEMPOW401K_EEList]
    WHERE EXISTS (SELECT 1 
                  FROM dbo.vw_AuditData 
                  WHERE audKey1Value = xEEID 
                    AND audDateTime BETWEEN DateAdd(DAY, -30, @EndDate) AND @EndDate 
                    AND audNewValue = 'T' 
                    AND audAction <> 'DELETE' 
                    AND audTableName='Empcomp' 
                    AND audFieldName='EecEmplStatus')

    CREATE CLUSTERED INDEX CDX_U_EEMPOW401K_TermsKeyed ON dbo.U_EEMPOW401K_TermKeyed (tkdEEID,tkdCOID);



    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '401K,401F,401PC,401FC,ROTH2,ROTHF,RTHPC,RTHFC,4KLON,4KLN2,4KLN3,KLN,MATCH';

    IF OBJECT_ID('U_EEMPOW401K_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EEMPOW401K_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EEMPOW401K_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

/*
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
*/

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EEMPOW401K_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EEMPOW401K_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhPreTaxAmt     = SUM(CASE WHEN PdhDedCode IN ('401K', '401F', '401PC', '401FC') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhMatchAmt     = SUM(CASE WHEN PdhDedCode IN ('401K', '401F', '401PC', '401FC', 'ROTH2', 'ROTHF', 'RTHPC', 'RTHFC', 'MATCH') THEN PdhERCurAmt ELSE 0.00 END)
        ,PdhLoansAmt     = SUM(CASE WHEN PdhDedCode IN ('4KLON', '4KLN2', '4KLN3', 'KLN') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhRothAmt     = SUM(CASE WHEN PdhDedCode IN ('ROTH2', 'ROTHF','RTHPC','RTHFC') THEN PdhEECurAmt ELSE 0.00 END)
    INTO dbo.U_EEMPOW401K_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EEMPOW401K_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EEMPOW401K_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EEMPOW401K_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt) -- SUM(CASE WHEN PehEarnCode NOT IN ('MBSD', 'MBSOT', 'NSOT', 'SHFT3', 'WEK') THEN PehCurAmt ELSE 0.00 END)
        --,PehCurAmtYTD           =  SUM(CASE WHEN PehEarnCode NOT IN ('MBSD', 'MBSOT', 'NSOT', 'SHFT3', 'WEK') THEN PehCurAmt ELSE 0.00 END)
        ,PehCurPlanAmtYTD       = SUM(CASE WHEN PehEarnCode IN ('BRK2','BRV','FTO','HLW','HOL','HST','JUR','MBSD','MBSOT','NSOT','OBERN','PDBRK','PTO','R','REG','SCK','SHFT3','VSB','WEK','WEKOT','AZSIK','BO1','BO2','BO3','BO4','BRKOT','BYE','COM','EPBON','FBBON','OT','PAYPT') THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
        -- Start here
        ,PehHourWorked = SUM(CASE WHEN PehEarnCode NOT IN ('MBSD', 'MBSOT', 'NSOT', 'SHFT3', 'WEK') THEN PehCurHrs ELSE 0.00 END)        
    INTO dbo.U_EEMPOW401K_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;

    DECLARE @CompanyCode VARCHAR(5);
    SELECT @CompanyCode =  CmmCompanyCode FROM dbo.CompMast WITH (NOLOCK)


    IF OBJECT_ID('U__EEMPOW401K_JobHistTbl', 'U') IS NOT NULL
        DROP TABLE dbo.U__EEMPOW401K_JobHistTbl;
    SELECT EjhEEID, EjhCOID, EjhIsTransfer, EjhReason
    INTO dbo.U__EEMPOW401K_JobHistTbl
    FROM dbo.EmpHJob WITH (NOLOCK)
    JOIN dbo.U_EEMPOW401K_EEList WITH (NOLOCK)
        ON EjhEEID = xEEID
        AND EjhCOID = xCOID
    WHERE EjhIsTransfer = 'Y'


    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EEMPOW401K_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EEMPOW401K_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EEMPOW401K_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = CHECKSUM(eepSSN) --CONVERT(DATE, PayGroupDate) --EecPayGroup + ' ' + CAST(PayGroupDate AS VARCHAR) + ' ' + FORMAT(PrgPayDate, 'MM/dd/yyyy')
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvDivisionNumber = CmpCompanyCode
                            --CASE CmpCompanyCode
                            --    WHEN 'SRCMA' THEN 'SRMAZ'
                            --    WHEN 'SRCMC' THEN 'SRMCO'
                            --    ELSE CmpCompanyCode
                            --END
                            /*CASE CmpCompanyCode
                                    WHEN 'SRMIL' THEN 'D1'
                                    WHEN 'SRC' THEN 'D16'
                                    WHEN 'SRCNY' THEN 'D18'
                                    WHEN 'SRCOH' THEN 'D2'
                                    WHEN 'SRCMA' THEN 'D3'
                                    WHEN 'SRCMC' THEN 'D4'
                                    WHEN 'SRMNM' THEN 'D5'
                                    WHEN 'SRCAZ' THEN 'D6'
                                    WHEN 'SRCCO' THEN 'D7'
                                    WHEN 'SRCIL' THEN 'D8'
                                    WHEN 'SRCIN' THEN 'D9'
                                    WHEN 'SRCKS' THEN 'D10'
                                    WHEN 'SRCMI' THEN 'D17'
                                    WHEN 'SRCMO' THEN 'D11'
                                    WHEN 'SRCOR' THEN 'D13'
                                    WHEN 'SRCTX' THEN 'D14'
                                END*/
        ,drvNameLast = EepNameLast
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddle = EepNameMiddle
        ,drvDateOfBirth = EepDateOfBirth
        ,drvGender = EepGender
        ,drvMaritalStatus = CASE WHEN ISNULL(eepMaritalStatus, '') <> '' THEN EepMaritalStatus ELSE '' END
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLin2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvPhoneHomeNumber = EepPhoneHomeNumber
        ,drvPhoneBusinessNumber = EecPhoneBusinessNumber
        ,drvHireDate = EecDateOfOriginalHire
        ,drvTerminationDate =    CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination
                                    WHEN EecEmplStatus = 'A' AND EecDateOfOriginalHire <> EecDateOfLastHire THEN PtdOldValue 
                                END        
        ,drvRehireDate = CASE WHEN (SELECT COUNT(*) FROM dbo.U__EEMPOW401K_JobHistTbl WITH (NOLOCK) WHERE EjhEEID = xEEID AND EjhCOID = xCOID AND EjhIsTransfer = 'Y' AND EjhReason = '101') > 0 THEN 
                                -- Determine which is later, send that.
                                CASE WHEN EecDateOfOriginalHire > EecDateOfLastHire THEN EecDateOfOriginalHire ELSE EecDateOfLastHire END
                            WHEN  (SELECT COUNT(*) FROM dbo.U__EEMPOW401K_JobHistTbl WITH (NOLOCK) WHERE EjhEEID = xEEID AND EjhCOID = xCOID AND EjhIsTransfer = 'Y' AND EjhReason <> '101') > 0 THEN null
                            ELSE 
                                CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN EecDateOfLastHire END
                                
                        END
        --CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN EecDateOfLastHire END
        




        ,drvCheckDate =    CASE WHEN PrgPayDate IS NOT NULL THEN
                            CASE WHEN CONVERT(DATE, PayGroupDate) > PrgPayDate THEN CONVERT(DATE, PayGroupDate) ELSE PrgPayDate END
                            ELSE CONVERT(DATE, PayGroupDate)
                        END
        
        /*CASE WHEN PayDate IS NOT NULL THEN PayDate -- jcb
                            WHEN PayDate IS NULL THEN PayGroupDate
                            WHEN PayDate IS NOT NULL AND PayDate > PayGroupDate THEN PayDate
                            WHEN PayDate IS NOT NULL AND PayDate < PayGroupDate THEN PayGroupDate
                        END-- CASE WHEN PdhPreTaxAmt IS NOT NULL OR PdhRothAmt IS NOT NULL THEN PayDate END --PgrPayDate
                        */







        ,drvPreTax = FORMAT(PdhPreTaxAmt, '0.00')
        ,drvMatch = FORMAT(PdhMatchAmt, '0.00')
        ,drvLoans = FORMAT(PdhLoansAmt, '0.00')
        ,drvRoth = FORMAT(PdhRothAmt, '0.00')
        ,drvHoursWorked = FORMAT(PehHourWorked, '0')
        ,drvYTDTotalComp = FORMAT(PehCurAmtYTD, '0.00')
        ,drvYTDPlanComp = FORMAT(PehInclInDefCompYTD, '0.00')
        ,drvParticipationDate = EepUDField05
        ,drvLoaReasonCode = CASE WHEN ISNULL(audDateTime, '') <> '' OR  EecEmplStatus = 'L' THEN 'L' END -- JCB
        ,drvLoaStartDate = CASE WHEN ISNULL(audDateTime, '') <> '' OR EecEmplStatus = 'L' THEN EshStatusStartDate END
        ,drvLoaEndDate = CASE WHEN ISNULL(audDateTime, '') <> '' THEN EshStatusStopDate END
        ,drvWorkEmailAddress = CASE WHEN ISNULL(EepAddressEMail, '') <> '' THEN EepAddressEMail ELSE EepAddressEmailAlternate END
        ,drvSalaryAmount = EecAnnSalary
        ,drvTermReasonCode = CASE WHEN EecEmplStatus = 'T' THEN 'L' /*EecTermReason*/ END
        ,drvEmplAssignedId = EecEmpNo
        ,drvComplianceStatusCode =    CASE WHEN EecEmplStatus = 'T' AND EecTermReason = '203' THEN 'D'
                                        WHEN EecEmplStatus = 'T' AND EecTermReason = '202' THEN 'R'
                                    END
    INTO dbo.U_EEMPOW401K_drvTbl
    FROM dbo.U_EEMPOW401K_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    /*LEFT JOIN dbo.U_dsi_BDM_EEMPOW401K WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID*/
    /*JOIN dbo.PayGroup WITH (NOLOCK)
        ON PgrPayGroup = EecPayGroup*/
    LEFT JOIN dbo.U_EEMPOW401K_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
    LEFT JOIN dbo.U_EEMPOW401K_PEarHist WITH (NOLOCK)
        ON PehEEID = xEEID
    LEFT JOIN (
                SELECT EshEEID, EshCOID, EshStatusStartDate, EshStatusStopDate
                FROM (
                        SELECT EshEEID, EshCOID, EshStatusStartDate, EshStatusStopDate, EshEmplStatus, ROW_NUMBER() OVER (PARTITION BY EshEEID, EshCOID ORDER BY EshStatusStartDate DESC) AS RN
                        FROM dbo.EmpHStat WITH (NOLOCK) 
                        WHERE EshEmplStatus = 'L') AS LOA_Dates 
                WHERE RN = 1) AS EshDates 
        ON EshEEID = xEEID 
        AND EshCOID = xCOID
    LEFT JOIN dbo.U_EEMPOW401K_Audit WITH (NOLOCK)
        ON audEEID = xEEID
        AND audCOID = xCOID
    JOIN dbo.Company WITH (NOLOCK)
        ON EecCoId = CmpCoId
    JOIN (


            SELECT PgpPayGroup, LEFT(MAX(PgpPeriodControl),8) as PayGroupDate, MAX(PgpPeriodStartDate) PrgPeriodStart, MAX(PgpPeriodEndDate) PrgPeriodEnd 
                   FROM dbo.PgPayPer WITH (NOLOCK)
                   WHERE PgpPeriodControl BETWEEN @StartPerControl AND @EndPerControl 
                   AND PgpPeriodType IN ('R','S')
                   GROUP BY PgpPayGroup
                   
                   
                   
                   ) AS Pay_Group_Dates
        ON EecPayGroup = PgpPayGroup
    left JOIN (



            SELECT PrgEEID, PrgCOID, MAX(PrgPayDate) AS PayDate
            FROM dbo.PayReg WITH (NOLOCK)
            WHERE  PrgPerControl BETWEEN @StartPerControl AND @EndPerControl  -- JCB
                AND PrgTransactionType IN ('D', 'C')
            GROUP BY PrgEEID, PrgCOID) AS PAY_DATES

        ON PrgEEID = xEEID
        AND PrgCOID = xCOID
    LEFT JOIN (
                SELECT audEEID AS PtdEEID, audKey2 as PtdCOID, audOldValue AS PtdOldValue
                FROM (
                    SELECT   audEEID = audKey1Value 
                            ,audKey2 = audKey2Value
                            ,audKey3 = audKey3Value
                            ,audTableName
                            ,audFieldName
                            ,audAction
                            ,audDateTime
                            ,audOldValue
                            ,audNewValue
                            ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    
                        FROM dbo.vw_AuditData WITH (NOLOCK)
                        WHERE 
                        audTableName = 'EmpComp'
                        AND audFieldName = 'EecDateOfTermination'
                        AND AudKey1Value IN (SELECT DISTINCT xEEID FROM dbo.U_EEMPOW401K_EEList WITH (NOLOCK))) AS T 
                where audRowNo = 1) AS Prev_Term
        ON PtdEEID = xEEID
        AND PtdCOID = xCOID
    WHERE EecEmplStatus <> 'T' -- JCB
            OR (EecEmplStatus = 'T' AND EecDateOfTermination >= DATEADD(DAY, -90, @EndDate))                            -- Keep terms in for 90 days
            OR ISNULL(PdhEECurAmt,0.00) <> 0.00 OR ISNULL(PehCurAmt,0.00) <> 0.00 OR ISNULL(PdhERCurAmt,0.00) <> 0.00   -- Do not exclude if terms with adjustments
            OR EXISTS (SELECT 1 FROM dbo.U_EEMPOW401K_TermKeyed WHERE tkdEEID = xEEID AND tkdCOID=xCOID)                -- Term keyed in past 30 days

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
ALTER VIEW dbo.dsi_vwEEMPOW401K_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EEMPOW401K_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EEMPOW401K%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202203101'
       ,expStartPerControl     = '202203101'
       ,expLastEndPerControl   = '202203101'
       ,expEndPerControl       = '202203101'
       ,expAscFileName         = CONCAT('\\us.saas\EW3\EW34\Downloads\V10\Exports\RTIRE\EmployeeHistoryExport\'
                                        ,RTRIM(expFormatCode),'_',RTRIM(expExportCode),'_',CONVERT(varchar, GETDATE(),112),'.txt')
WHERE expFormatCode = 'EEMPOW401K' and expExportcode LIKE '%TEST%';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEEMPOW401K_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EEMPOW401K_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EEMPOW401K' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EEMPOW401K'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EEMPOW401K'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EEMPOW401K', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EEMPOW401K', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EEMPOW401K', 'UseFileName', 'V', 'Y'


-- End ripout