/**********************************************************************************

EOTEMP401K: Empower 401K Export

FormatCode:     EOTEMP401K
Project:        Empower 401K Export
Client ID:      USG1000
Date/time:      2023-04-12 16:00:55.387
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EZ24
Server:         EZ2SUP4DB01
Database:       ULTIPRO_BETHB
Web Filename:   USG1000_73487_EEHISTORY_EOTEMP401K_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    \\ez2sup4db01\ultiprodata\[Name]\Exports\

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EOTEMP401K_SavePath') IS NOT NULL DROP TABLE dbo.U_EOTEMP401K_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EOTEMP401K'


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
WHERE FormatCode = 'EOTEMP401K'
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
WHERE ExpFormatCode = 'EOTEMP401K'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EOTEMP401K')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EOTEMP401K'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EOTEMP401K'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EOTEMP401K'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EOTEMP401K'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EOTEMP401K'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EOTEMP401K'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EOTEMP401K'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EOTEMP401K'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EOTEMP401K'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_sp_BuildDriverTables_EOTEMP401K') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EOTEMP401K];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EOTEMP401K','Empower 401K Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','EOTEMP401KZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EOTEMP401KZ0','13','D','10','1',NULL,'Plan Number',NULL,NULL,'"519330-01"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EOTEMP401KZ0','11','D','10','2',NULL,'Employee SSN',NULL,NULL,'"drvSSn"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EOTEMP401KZ0','20','D','10','3',NULL,'Division number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EOTEMP401KZ0','35','D','10','4',NULL,'Last Name',NULL,NULL,'"drvLastName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EOTEMP401KZ0','20','D','10','5',NULL,'First Name',NULL,NULL,'"drvFirstName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EOTEMP401KZ0','20','D','10','6',NULL,'Middle Name',NULL,NULL,'"drvMiddleName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EOTEMP401KZ0','15','D','10','7',NULL,'Name Suffix',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EOTEMP401KZ0','10','D','10','8',NULL,'Birth Date',NULL,NULL,'"drvDateofBirth"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EOTEMP401KZ0','1','D','10','9',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EOTEMP401KZ0','1','D','10','10',NULL,'Marital Status',NULL,NULL,'"drvMaritalStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EOTEMP401KZ0','35','D','10','11',NULL,'Address Line 1',NULL,NULL,'"drvAddressLine1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EOTEMP401KZ0','35','D','10','12',NULL,'Address Line 2',NULL,NULL,'"drvAddressLine2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EOTEMP401KZ0','20','D','10','13',NULL,'City',NULL,NULL,'"drvAddressCity"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EOTEMP401KZ0','2','D','10','14',NULL,'State',NULL,NULL,'"drvAddressState"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EOTEMP401KZ0','10','D','10','15',NULL,'Zip Code',NULL,NULL,'"drvAddressZipCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EOTEMP401KZ0','10','D','10','16',NULL,'Home Phone Number',NULL,NULL,'"drvHomePhoneNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EOTEMP401KZ0','10','D','10','17',NULL,'Work Phone Number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EOTEMP401KZ0','4','D','10','18',NULL,'Work Phone Ext.',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EOTEMP401KZ0','2','D','10','19',NULL,'Country Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EOTEMP401KZ0','10','D','10','20',NULL,'Hire Date',NULL,NULL,'"drvHireDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EOTEMP401KZ0','10','D','10','21',NULL,'Termination Date',NULL,NULL,'"drvTerminationDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EOTEMP401KZ0','10','D','10','22',NULL,'Re-Hire Date',NULL,NULL,'"drvReHireDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EOTEMP401KZ0','10','D','10','23',NULL,'Checkdate',NULL,NULL,'"drvCheckdate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EOTEMP401KZ0','10','D','10','24',NULL,'Pretax',NULL,NULL,'"drvPretax"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EOTEMP401KZ0','10','D','10','25',NULL,'Roth',NULL,NULL,'"drvRoth"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EOTEMP401KZ0','10','D','10','26',NULL,'Loans',NULL,NULL,'"drvLoans"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EOTEMP401KZ0','10','D','10','27',NULL,'Employer Profit Sharing',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EOTEMP401KZ0','10','D','10','28',NULL,'EMPLOYER PROFIT SHARING - MERGED GRANDFATHER PLAN',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EOTEMP401KZ0','10','D','10','29',NULL,'EMPLOYER MONEY PURCHASE- MERGED GRANDFATHER PLAN',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EOTEMP401KZ0','10','D','10','30',NULL,'Contribution Amount 7',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EOTEMP401KZ0','10','D','10','31',NULL,'Contribution Amount 8',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EOTEMP401KZ0','5','D','10','32',NULL,'YTD Hours Worked',NULL,NULL,'"drvYTDHoursWorked"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EOTEMP401KZ0','11','D','10','33',NULL,'YTD Total Compensation',NULL,NULL,'"drvYTDTotalCompensation"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EOTEMP401KZ0','11','D','10','34',NULL,'YTD Plan Compensation',NULL,NULL,'"drvYTDPlanCompensation"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EOTEMP401KZ0','11','D','10','35',NULL,'YTD Pre Entry Compensation',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EOTEMP401KZ0','1','D','10','36',NULL,'Highly Comp Employee Code',NULL,NULL,'"drvHighlyComEmp"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EOTEMP401KZ0','6','D','10','37',NULL,'Percent of Ownership',NULL,NULL,'"drvPercentofOwnership"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EOTEMP401KZ0','1','D','10','38',NULL,'Officer Determination',NULL,NULL,'"dfvOfficerDetermination"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EOTEMP401KZ0','10','D','10','39',NULL,'Participation Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EOTEMP401KZ0','1','D','10','40',NULL,'Eligibility Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EOTEMP401KZ0','1','D','10','41',NULL,'LOA Reason Code',NULL,NULL,'"drvLOAReasonCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EOTEMP401KZ0','10','D','10','42',NULL,'LOA Start Date',NULL,NULL,'"drvLOAStartDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EOTEMP401KZ0','10','D','10','43',NULL,'LOA End Date',NULL,NULL,'"drvLOAEndDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EOTEMP401KZ0','1','D','10','44',NULL,'Filler Space',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EOTEMP401KZ0','40','D','10','45',NULL,'Email Address',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EOTEMP401KZ0','17','D','10','46',NULL,'Salary Amount',NULL,NULL,'"drvSalaryAmount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EOTEMP401KZ0','2','D','10','47',NULL,'Salary Amount Qualifier',NULL,NULL,'"drvSalaryAmountQualifier"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EOTEMP401KZ0','20','D','10','48',NULL,'Termination Reason Code',NULL,NULL,'"drvTerminationReasonCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EOTEMP401KZ0','1','D','10','49',NULL,'Sarbanes Oxley Reporting Indicator',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EOTEMP401KZ0','6','D','10','50',NULL,'Filler Space',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EOTEMP401KZ0','2','D','10','51',NULL,'Federal Exemptions',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EOTEMP401KZ0','10','D','10','52',NULL,'Employer Assigned ID',NULL,NULL,'"drvEmployerAssignedID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EOTEMP401KZ0','6','D','10','53',NULL,'Compliance Status Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EOTEMP401KZ0','80','D','10','54',NULL,'Personal Email Address',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EOTEMP401KZ0','10','D','10','55',NULL,'Mobile Phone',NULL,NULL,'""','(''SS''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EOTEMP401K_20230412.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202304129','EMPEXPORT','OEACTIVE',NULL,'EOTEMP401K',NULL,NULL,NULL,'202304129','Apr 12 2023  2:49PM','Apr 12 2023  2:49PM','202304121',NULL,'','','202304121',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202304129','EMPEXPORT','OEPASSIVE',NULL,'EOTEMP401K',NULL,NULL,NULL,'202304129','Apr 12 2023  2:49PM','Apr 12 2023  2:49PM','202304121',NULL,'','','202304121',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Empower 401K Export','202304129','EMPEXPORT','ONDEM_XOE',NULL,'EOTEMP401K',NULL,NULL,NULL,'202304129','Apr 12 2023  2:49PM','Apr 12 2023  2:49PM','202304121',NULL,'','','202304121',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Empower 401K Export-Sched','202304129','EMPEXPORT','SCH_EOTEMP',NULL,'EOTEMP401K',NULL,NULL,NULL,'202304129','Apr 12 2023  2:49PM','Apr 12 2023  2:49PM','202304121',NULL,'','','202304121',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Empower 401K Export-Test','202304129','EMPEXPORT','TEST_XOE',NULL,'EOTEMP401K',NULL,NULL,NULL,'202304129','Apr 12 2023  2:49PM','Apr 12 2023  2:49PM','202304121',NULL,'','','202304121',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EOTEMP401K','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EOTEMP401K','ExportPath','V','\\ez2sup4db01\ultiprodata\[Name]\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EOTEMP401K','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EOTEMP401K','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EOTEMP401K','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EOTEMP401K','UseFileName','V','N');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EOTEMP401K','D10','dbo.U_EOTEMP401K_drvTbl',NULL);

-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- U_dsi_Translations_v3 inserts
-----------

GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EOTEMP401K]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: One Table Restaurant Brands

Created By: Marie Waters
Business Analyst: Katherine Ricca
Create Date: 04/12/2023
Service Request Number: TekP-2023-01-20-02

Purpose: Empower 401K Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EOTEMP401K';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EOTEMP401K';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EOTEMP401K';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EOTEMP401K';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EOTEMP401K' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EOTEMP401K', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EOTEMP401K', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EOTEMP401K', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EOTEMP401K', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EOTEMP401K', 'SCH_EOTEMP';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EOTEMP401K';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EOTEMP401K', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EOTEMP401K';

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
    DELETE FROM dbo.U_EOTEMP401K_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EOTEMP401K_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EOTEMP401K_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EOTEMP401K_AuditFields;
    CREATE TABLE dbo.U_EOTEMP401K_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_EOTEMP401K_AuditFields VALUES ('EmpComp','EecEmplStatus');
    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EOTEMP401K_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EOTEMP401K_Audit;
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
        ,audLOA =  CASE WHEN  audOldValue = 'L' AND audNewValue = 'A' THEN 'Y' ELSE 'N' END
        ,audTerm =  CASE WHEN  audOldValue = 'A' AND audNewValue = 'T' THEN 'Y' ELSE 'N' END
        ,audRehire =  CASE WHEN  audOldValue = 'T' AND audNewValue = 'A' THEN 'Y' ELSE 'N' END
    INTO dbo.U_EOTEMP401K_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EOTEMP401K_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EOTEMP401K_Audit ON dbo.U_EOTEMP401K_Audit (audEEID,audKey2);

    ----================
    ---- Changes Only
    ----================
    --DELETE FROM dbo.U_EOTEMP401K_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EOTEMP401K_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '401CF,401CP,401F,401P,401P,401L,401L2';

    IF OBJECT_ID('U_EOTEMP401K_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EOTEMP401K_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EOTEMP401K_DedList
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

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EOTEMP401K_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EOTEMP401K_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhPreTaxAmt     = SUM(CASE WHEN PdhDedCode IN ('401P', '401CP', '401F', '401CF') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhLoansAmt     = SUM(CASE WHEN PdhDedCode IN ('401L', '401L2') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhDedCalcBasisAmt     = SUM(CASE WHEN PdhDedCode IN ('401P', '401CP', '401F', '401CF') THEN PdhDedCalcBasisAmt ELSE 0.00 END)
    INTO dbo.U_EOTEMP401K_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EOTEMP401K_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EOTEMP401K_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EOTEMP401K_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
        ,PehCurPlanAmtYTD       = SUM(CASE WHEN PehEarnCode IN ('BRK2','BRV','FTO','HLW','HOL','HST','JUR','MBSD','MBSOT','NSOT','OBERN','PDBRK','PTO','R','REG','SCK','SHFT3','VSB','WEK','WEKOT','AZSIK','BO1','BO2','BO3','BO4','BRKOT','BYE','COM','EPBON','FBBON','OT','PAYPT') THEN PehCurAmt ELSE 0.00 END)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
        --,PehHourWorked = SUM(CASE WHEN PehEarnCode NOT IN ('DT', 'ELWC','HDL', 'ONBP', 'OT', 'REG', 'REP', 'SAL', 'SFA', 'OTR', 'DTR', 'TRAOD', 'TRAVD', 'TRAVR') THEN PehCurHrs ELSE 0.00 END)
    INTO dbo.U_EOTEMP401K_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;


    -----------------------------
    -- Working Table - PTaxHist 
    -----------------------------
    IF OBJECT_ID('U_EOTEMP401K_PTaxHist','U') IS NOT NULL
        DROP TABLE dbo.U_EOTEMP401K_PTaxHist;
    SELECT DISTINCT
         PthEEID 
        ,PthGrossAmtYTD         = SUM(PthCurGrossWages) 
        ,PthCurTaxableWages     = SUM(CASE WHEN  PthTaxCode LIKE '%USFIT%' THEN PthCurTaxableWages ELSE 0.00 END)
    INTO dbo.U_EOTEMP401K_PTaxHist
    FROM dbo.U_EOTEMP401K_EEList WITH (NOLOCK)
    JOIN dbo.PayReg WITH (NOLOCK)
        ON PrgEEID = xEEID
    JOIN dbo.PTaxHist WITH (NOLOCK)
        ON PthGenNumber = PrgGenNumber
    WHERE LEFT(PthPerControl,4) = LEFT(@EndPerControl,4)
    AND PthPerControl <= @EndPerControl  --AND PthTaxCode = 'USFUTA'
    GROUP BY PthEEID;

    
    DECLARE @CompanyCode VARCHAR(5);
    SELECT @CompanyCode =  CmmCompanyCode FROM dbo.CompMast WITH (NOLOCK)


    IF OBJECT_ID('U__EOTEMP401K_JobHistTbl', 'U') IS NOT NULL
        DROP TABLE dbo.U__EOTEMP401K_JobHistTbl;
    SELECT EjhEEID, EjhCOID, EjhIsTransfer, EjhReason
    INTO dbo.U__EOTEMP401K_JobHistTbl
    FROM dbo.EmpHJob WITH (NOLOCK)
    JOIN dbo.U_EOTEMP401K_EEList WITH (NOLOCK)
        ON EjhEEID = xEEID
        AND EjhCOID = xCOID
    WHERE EjhIsTransfer = 'Y'


    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EOTEMP401K_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EOTEMP401K_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EOTEMP401K_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvSSn = eepSSN
        ,drvLastName = EepNameLast
        ,drvFirstName = EepNameFirst
        ,drvMiddleName = LEFT(EepNameMiddle,1)
        ,drvDateofBirth = Convert(varchar,EepDateOfBirth, 101)
        ,drvGender = EepGender
        ,drvMaritalStatus = Case When ISNULL(eepMaritalStatus, '') IN ('', 'Z') Then 'S' Else eepMaritalStatus END
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvHomePhoneNumber = CASE WHEN ISNULL(CASE WHEN ISNULL(EepPhoneHomeNumber, '') =''  then efoPhoneNumber ELSE EepPhoneHomeNumber END, '') = ''
                                THEN EecPhoneBusinessNumber
                                END
        
        ,drvHireDate = Convert(varchar,EecDateOfOriginalHire, 101)
          ,drvTerminationDate =    CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination
                                    WHEN EecEmplStatus = 'A' AND EecDateOfOriginalHire <> EecDateOfLastHire THEN PtdOldValue 
                                END        
        ,drvRehireDate = CASE WHEN (SELECT COUNT(*) FROM dbo.U__EOTEMP401K_JobHistTbl WITH (NOLOCK) WHERE EjhEEID = xEEID AND EjhCOID = xCOID AND EjhIsTransfer = 'Y' AND EjhReason = '101') > 0 THEN 
                                -- Determine which is later, send that.
                                CASE WHEN EecDateOfOriginalHire > EecDateOfLastHire THEN EecDateOfOriginalHire ELSE EecDateOfLastHire END
                            WHEN  (SELECT COUNT(*) FROM dbo.U__EOTEMP401K_JobHistTbl WITH (NOLOCK) WHERE EjhEEID = xEEID AND EjhCOID = xCOID AND EjhIsTransfer = 'Y' AND EjhReason <> '101') > 0 THEN null
                            ELSE 
                                CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN EecDateOfLastHire END
                                
                        END
        ,drvCheckdate = CASE WHEN PrgPayDate IS NOT NULL THEN
                            CASE WHEN CONVERT(DATE, PayGroupDate) > PrgPayDate THEN CONVERT(DATE, PayGroupDate) ELSE PrgPayDate END
                            ELSE CONVERT(DATE, PayGroupDate)
                        END
        ,drvPreTax = FORMAT(PdhPreTaxAmt, '0.00')
        ,drvLoans = FORMAT(PdhLoansAmt, '0.00')
        ,drvYTDHoursWorked = FORMAT(PehInclInDefCompHrsYTD , '0')
        ,drvYTDTotalCompensation = FORMAT(PthCurTaxableWages, '0.00')
        ,drvYTDPlanCompensation = FORMAT(PdhDedCalcBasisAmt, '0.00')
        ,drvHighlyComEmp = CASE WHEN EecIsHighlyComp = 'Y' THEN 'Y' END
        ,drvPercentofOwnership = ''
        ,dfvOfficerDetermination = CASE WHEN EecIsKeyEmployee = 'Y' THEN 'Y' END
        ,drvLOAReasonCode = CASE WHEN  EecEmplStatus = 'L' THEN 'L' END 
        ,drvLOAStartDate = CASE WHEN  EecEmplStatus = 'L' THEN EshStatusStartDate END
        ,drvLOAEndDate = CASE WHEN ISNULL(audDateTime, '') <> '' THEN EshStatusStopDate END
        ,drvSalaryAmount = EecAnnSalary
        ,drvSalaryAmountQualifier = 'A'
        ,drvTerminationReasonCode = CASE WHEN EecEmplStatus = 'T' THEN 
                                        CASE  WHEN  EecTermReason = '203' THEN 'DE' 
                                              WHEN  EecTermReason = '202' THEN  'R' ELSE 'S' 
                                           END
                                      END
        ,drvEmployerAssignedID = EecEmpNo
    INTO dbo.U_EOTEMP401K_drvTbl
    FROM dbo.U_EOTEMP401K_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EOTEMP401K WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.EmpMPhon WITH (NOLOCK)
        ON EfoEEID = xEEID
        AND EfoPhoneType = 'CEL'
    LEFT JOIN dbo.U_EOTEMP401K_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
    LEFT JOIN dbo.U_EOTEMP401K_PEarHist WITH (NOLOCK)
        ON PehEEID = xEEID
     JOIN dbo.U_EOTEMP401K_PTaxHist WITH (NOLOCK)
        ON PthEEID = xEEID
    LEFT JOIN (
                SELECT EshEEID, EshCOID, EshStatusStartDate, EshStatusStopDate
                FROM (
                        SELECT EshEEID, EshCOID, EshStatusStartDate, EshStatusStopDate, EshEmplStatus, ROW_NUMBER() OVER (PARTITION BY EshEEID, EshCOID ORDER BY EshStatusStartDate DESC) AS RN
                        FROM dbo.EmpHStat WITH (NOLOCK) 
                        WHERE EshEmplStatus = 'L') AS LOA_Dates 
                WHERE RN = 1) AS EshDates 
        ON EshEEID = xEEID 
        AND EshCOID = xCOID
    LEFT JOIN dbo.U_EOTEMP401K_Audit WITH (NOLOCK)
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
                        AND AudKey1Value IN (SELECT DISTINCT xEEID FROM dbo.U_EOTEMP401K_EEList WITH (NOLOCK))) AS T 
                where audRowNo = 1) AS Prev_Term
        ON PtdEEID = xEEID
        AND PtdCOID = xCOID
    WHERE EecEmplStatus <> 'T' -- JCB
            OR (EecEmplStatus = 'T' AND EecDateOfTermination >= DATEADD(DAY, -90, @EndDate))                            -- Keep terms in for 90 days
            OR ISNULL(PdhEECurAmt,0.00) <> 0.00 OR ISNULL(PehCurAmt,0.00) <> 0.00 OR ISNULL(PdhERCurAmt,0.00) <> 0.00   -- Do not exclude if terms with adjustments
            OR EXISTS (SELECT 1 FROM dbo.U_EOTEMP401K_TermKeyed WHERE tkdEEID = xEEID AND tkdCOID=xCOID) 
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
ALTER VIEW dbo.dsi_vwEOTEMP401K_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EOTEMP401K_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EOTEMP401K%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202304051'
       ,expStartPerControl     = '202304051'
       ,expLastEndPerControl   = '202304129'
       ,expEndPerControl       = '202304129'
WHERE expFormatCode = 'EOTEMP401K';

**********************************************************************************/

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EOTEMP401K' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EOTEMP401K'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EOTEMP401K'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EOTEMP401K', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EOTEMP401K', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EOTEMP401K', 'UseFileName', 'V', 'Y'


-- End ripout