/**********************************************************************************

EIVBRFSAEN: Benefit Resource FSA Enrollment

FormatCode:     EIVBRFSAEN
Project:        Benefit Resource FSA Enrollment
Client ID:      IVO1000
Date/time:      2023-02-22 12:22:39.110
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW2WUP4DB01
Database:       ULTIPRO_WPIVOCL
Web Filename:   IVO1000_C068D_EEHISTORY_EIVBRFSAEN_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EIVBRFSAEN_SavePath') IS NOT NULL DROP TABLE dbo.U_EIVBRFSAEN_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EIVBRFSAEN'


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
WHERE FormatCode = 'EIVBRFSAEN'
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
WHERE ExpFormatCode = 'EIVBRFSAEN'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EIVBRFSAEN')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EIVBRFSAEN'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EIVBRFSAEN'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EIVBRFSAEN'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EIVBRFSAEN'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EIVBRFSAEN'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EIVBRFSAEN'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EIVBRFSAEN'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EIVBRFSAEN'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EIVBRFSAEN'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEIVBRFSAEN_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEIVBRFSAEN_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EIVBRFSAEN') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EIVBRFSAEN];
GO
IF OBJECT_ID('U_EIVBRFSAEN_File') IS NOT NULL DROP TABLE [dbo].[U_EIVBRFSAEN_File];
GO
IF OBJECT_ID('U_EIVBRFSAEN_EEList') IS NOT NULL DROP TABLE [dbo].[U_EIVBRFSAEN_EEList];
GO
IF OBJECT_ID('U_EIVBRFSAEN_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EIVBRFSAEN_drvTbl];
GO
IF OBJECT_ID('U_EIVBRFSAEN_DedList') IS NOT NULL DROP TABLE [dbo].[U_EIVBRFSAEN_DedList];
GO
IF OBJECT_ID('U_EIVBRFSAEN_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EIVBRFSAEN_AuditFields];
GO
IF OBJECT_ID('U_EIVBRFSAEN_Audit') IS NOT NULL DROP TABLE [dbo].[U_EIVBRFSAEN_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EIVBRFSAEN') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EIVBRFSAEN];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EIVBRFSAEN','Benefit Resource FSA Enrollment','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','EIVBRFSAENZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EIVBRFSAENZ0','50','H','01','1',NULL,'Employer ID',NULL,NULL,'"Employer ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EIVBRFSAENZ0','50','H','01','2',NULL,'Member ID',NULL,NULL,'"Member ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EIVBRFSAENZ0','50','H','01','3',NULL,'SSN',NULL,NULL,'"SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EIVBRFSAENZ0','50','H','01','4',NULL,'Other ID',NULL,NULL,'"Other ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EIVBRFSAENZ0','50','H','01','5',NULL,'Gender',NULL,NULL,'"Gender"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EIVBRFSAENZ0','50','H','01','6',NULL,'Last Name',NULL,NULL,'"Last Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EIVBRFSAENZ0','50','H','01','7',NULL,'First Name',NULL,NULL,'"First Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EIVBRFSAENZ0','50','H','01','8',NULL,'Middle Initial',NULL,NULL,'"Middle Initial"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EIVBRFSAENZ0','50','H','01','9',NULL,'Address Line 1',NULL,NULL,'"Address Line 1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EIVBRFSAENZ0','50','H','01','10',NULL,'Address Line 2',NULL,NULL,'"Address Line 2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EIVBRFSAENZ0','50','H','01','11',NULL,'City',NULL,NULL,'"City"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EIVBRFSAENZ0','50','H','01','12',NULL,'State',NULL,NULL,'"State"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EIVBRFSAENZ0','50','H','01','13',NULL,'ZIP',NULL,NULL,'"ZIP"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EIVBRFSAENZ0','50','H','01','14',NULL,'Phone',NULL,NULL,'"Phone"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EIVBRFSAENZ0','50','H','01','15',NULL,'Email Address',NULL,NULL,'"Email Address"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EIVBRFSAENZ0','50','H','01','16',NULL,'Date of Birth',NULL,NULL,'"Date of Birth"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EIVBRFSAENZ0','50','H','01','17',NULL,'Date of Hire',NULL,NULL,'"Date of Hire"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EIVBRFSAENZ0','50','H','01','18',NULL,'Employment Termination Date',NULL,NULL,'"Employment Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EIVBRFSAENZ0','50','H','01','19',NULL,'Employee Status',NULL,NULL,'"Employee Status"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EIVBRFSAENZ0','50','H','01','20',NULL,'Funding Frequency',NULL,NULL,'"Funding Frequency"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EIVBRFSAENZ0','50','H','01','21',NULL,'Insurance Code',NULL,NULL,'"Insurance Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EIVBRFSAENZ0','50','H','01','22',NULL,'Insurance Eff Date',NULL,NULL,'"Insurance Eff Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EIVBRFSAENZ0','50','H','01','23',NULL,'Account Type',NULL,NULL,'"Account Type"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EIVBRFSAENZ0','50','H','01','24',NULL,'Election Eff Date',NULL,NULL,'"Election Eff Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EIVBRFSAENZ0','50','H','01','25',NULL,'Election End Date',NULL,NULL,'"Election End Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EIVBRFSAENZ0','50','H','01','26',NULL,'Per Period Deduction',NULL,NULL,'"Per Period Deduction"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EIVBRFSAENZ0','50','H','01','27',NULL,'Full Election',NULL,NULL,'"Full Election"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EIVBRFSAENZ0','50','H','01','28',NULL,'User Defined 1',NULL,NULL,'"User Defined 1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EIVBRFSAENZ0','50','H','01','29',NULL,'User Defined 2',NULL,NULL,'"User Defined 2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EIVBRFSAENZ0','50','H','01','30',NULL,'SSO Value',NULL,NULL,'"SSO Value"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EIVBRFSAENZ0','50','H','01','31',NULL,'Coverage Code',NULL,NULL,'"Coverage Code"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EIVBRFSAENZ0','50','D','10','1',NULL,'Employer ID',NULL,NULL,'"drvEmployerID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EIVBRFSAENZ0','50','D','10','2',NULL,'Member ID',NULL,NULL,'"drvMemberID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EIVBRFSAENZ0','50','D','10','3',NULL,'SSN',NULL,NULL,'"drvSSNSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EIVBRFSAENZ0','50','D','10','4',NULL,'Other ID',NULL,NULL,'"drvOtherID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EIVBRFSAENZ0','50','D','10','5',NULL,'Gender',NULL,NULL,'"drvGenderGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EIVBRFSAENZ0','50','D','10','6',NULL,'Last Name',NULL,NULL,'"drvLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EIVBRFSAENZ0','50','D','10','7',NULL,'First Name',NULL,NULL,'"drvFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EIVBRFSAENZ0','50','D','10','8',NULL,'Middle Initial',NULL,NULL,'"drvMiddleInitial"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EIVBRFSAENZ0','50','D','10','9',NULL,'Address Line 1',NULL,NULL,'"drvAddressLine1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EIVBRFSAENZ0','50','D','10','10',NULL,'Address Line 2',NULL,NULL,'"drvAddressLine2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EIVBRFSAENZ0','50','D','10','11',NULL,'City',NULL,NULL,'"drvCityCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EIVBRFSAENZ0','50','D','10','12',NULL,'State',NULL,NULL,'"drvStateState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EIVBRFSAENZ0','50','D','10','13',NULL,'ZIP',NULL,NULL,'"drvZIPZIP"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EIVBRFSAENZ0','50','D','10','14',NULL,'Phone',NULL,NULL,'"drvPhonePhone"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EIVBRFSAENZ0','50','D','10','15',NULL,'Email Address',NULL,NULL,'"drvEmailAddress"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EIVBRFSAENZ0','50','D','10','16',NULL,'Date of Birth',NULL,NULL,'"drvDateBirth"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EIVBRFSAENZ0','50','D','10','17',NULL,'Date of Hire',NULL,NULL,'"drvDateHire"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EIVBRFSAENZ0','50','D','10','18',NULL,'Employment Termination Date',NULL,NULL,'"drvEmploymentDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EIVBRFSAENZ0','50','D','10','19',NULL,'Employee Status',NULL,NULL,'"drvEmployeeStatus"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EIVBRFSAENZ0','51','D','10','20',NULL,'Funding Frequency',NULL,NULL,'"drvFundingFrequency"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EIVBRFSAENZ0','52','D','10','21',NULL,'Insurance Code',NULL,NULL,'"drvInsuranceCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EIVBRFSAENZ0','53','D','10','22',NULL,'Insurance Eff Date',NULL,NULL,'"drvInsuranceDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EIVBRFSAENZ0','54','D','10','23',NULL,'Account Type',NULL,NULL,'"drvAccountType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EIVBRFSAENZ0','55','D','10','24',NULL,'Election Eff Date',NULL,NULL,'"drvElectionEffDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EIVBRFSAENZ0','56','D','10','25',NULL,'Election End Date',NULL,NULL,'"drvElectionEndDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EIVBRFSAENZ0','57','D','10','26',NULL,'Per Period Deduction',NULL,NULL,'"drvPerDeduction"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EIVBRFSAENZ0','58','D','10','27',NULL,'Full Election',NULL,NULL,'"drvFullElection"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EIVBRFSAENZ0','59','D','10','28',NULL,'User Defined 1',NULL,NULL,'"drvUserDefined1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EIVBRFSAENZ0','60','D','10','29',NULL,'User Defined 2',NULL,NULL,'"drvUserDefined2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EIVBRFSAENZ0','61','D','10','30',NULL,'SSO Value',NULL,NULL,'"drvSSOValue"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EIVBRFSAENZ0','62','D','10','31',NULL,'Coverage Code',NULL,NULL,'"drvCoverageCode"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EIVBRFSAEN_20230222.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202302209','EMPEXPORT','OEACTIVE',NULL,'EIVBRFSAEN',NULL,NULL,NULL,'202302209','Feb 20 2023  5:42PM','Feb 20 2023  5:42PM','202302011',NULL,'','','202302011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202302209','EMPEXPORT','OEPASSIVE',NULL,'EIVBRFSAEN',NULL,NULL,NULL,'202302209','Feb 20 2023  5:42PM','Feb 20 2023  5:42PM','202302011',NULL,'','','202302011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Benefit Resource FSA Enrollmen','202302209','EMPEXPORT','ONDEM_XOE',NULL,'EIVBRFSAEN',NULL,NULL,NULL,'202302209','Feb 20 2023  5:42PM','Feb 20 2023  5:42PM','202302011',NULL,'','','202302011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Benefit Resource FSA Enr-Sched','202302209','EMPEXPORT','SCH_EIVBRF',NULL,'EIVBRFSAEN',NULL,NULL,NULL,'202302209','Feb 20 2023  5:42PM','Feb 20 2023  5:42PM','202302011',NULL,'','','202302011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Benefit Resource FSA Enr-Test','202302209','EMPEXPORT','TEST_XOE',NULL,'EIVBRFSAEN',NULL,NULL,NULL,'202302209','Feb 20 2023  5:42PM','Feb 20 2023  5:42PM','202302011',NULL,'','','202302011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIVBRFSAEN','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIVBRFSAEN','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIVBRFSAEN','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIVBRFSAEN','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIVBRFSAEN','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIVBRFSAEN','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIVBRFSAEN','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIVBRFSAEN','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIVBRFSAEN','D10','dbo.U_EIVBRFSAEN_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EIVBRFSAEN
-----------

IF OBJECT_ID('U_dsi_BDM_EIVBRFSAEN') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EIVBRFSAEN] (
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
-- Create table U_EIVBRFSAEN_Audit
-----------

IF OBJECT_ID('U_EIVBRFSAEN_Audit') IS NULL
CREATE TABLE [dbo].[U_EIVBRFSAEN_Audit] (
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
-- Create table U_EIVBRFSAEN_AuditFields
-----------

IF OBJECT_ID('U_EIVBRFSAEN_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EIVBRFSAEN_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EIVBRFSAEN_DedList
-----------

IF OBJECT_ID('U_EIVBRFSAEN_DedList') IS NULL
CREATE TABLE [dbo].[U_EIVBRFSAEN_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EIVBRFSAEN_drvTbl
-----------

IF OBJECT_ID('U_EIVBRFSAEN_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EIVBRFSAEN_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvEmployerID] char(9) NULL,
    [drvMemberID] varchar(13) NULL,
    [drvSSNSSN] varchar(13) NULL,
    [drvOtherID] varchar(1) NOT NULL,
    [drvGenderGender] char(1) NULL,
    [drvLastName] varchar(100) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleInitial] varchar(1) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvCityCity] varchar(255) NULL,
    [drvStateState] varchar(255) NULL,
    [drvZIPZIP] varchar(50) NULL,
    [drvPhonePhone] varchar(50) NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvDateBirth] varchar(8) NULL,
    [drvDateHire] varchar(8) NULL,
    [drvEmploymentDate] varchar(8) NULL,
    [drvEmployeeStatus] varchar(2) NOT NULL,
    [drvFundingFrequency] varchar(2) NULL,
    [drvInsuranceCode] varchar(6) NOT NULL,
    [drvInsuranceDate] varchar(8) NULL,
    [drvAccountType] varchar(1) NOT NULL,
    [drvElectionEffDate] varchar(8) NULL,
    [drvElectionEndDate] varchar(8) NULL,
    [drvPerDeduction] money NULL,
    [drvFullElection] money NULL,
    [drvUserDefined1] varchar(1) NOT NULL,
    [drvUserDefined2] varchar(1) NOT NULL,
    [drvSSOValue] varchar(1) NOT NULL,
    [drvCoverageCode] varchar(1) NOT NULL
);

-----------
-- Create table U_EIVBRFSAEN_EEList
-----------

IF OBJECT_ID('U_EIVBRFSAEN_EEList') IS NULL
CREATE TABLE [dbo].[U_EIVBRFSAEN_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EIVBRFSAEN_File
-----------

IF OBJECT_ID('U_EIVBRFSAEN_File') IS NULL
CREATE TABLE [dbo].[U_EIVBRFSAEN_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EIVBRFSAEN]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Ivoclar Vivadent

Created By: Marie Waters
Business Analyst: Lea King
Create Date: 02/20/2023
Service Request Number: TekP-2022-10-04-06

Purpose: Benefit Resource FSA Enrollment

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EIVBRFSAEN';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EIVBRFSAEN';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EIVBRFSAEN';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EIVBRFSAEN';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EIVBRFSAEN' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIVBRFSAEN', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIVBRFSAEN', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIVBRFSAEN', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIVBRFSAEN', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIVBRFSAEN', 'SCH_EIVBRF';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EIVBRFSAEN';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EIVBRFSAEN', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EIVBRFSAEN';

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
    DELETE FROM dbo.U_EIVBRFSAEN_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EIVBRFSAEN_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EIVBRFSAEN_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EIVBRFSAEN_AuditFields;
    CREATE TABLE dbo.U_EIVBRFSAEN_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EIVBRFSAEN_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EIVBRFSAEN_Audit;
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
    INTO dbo.U_EIVBRFSAEN_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EIVBRFSAEN_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EIVBRFSAEN_Audit ON dbo.U_EIVBRFSAEN_Audit (audEEID,audKey2);

    ----================
    ---- Changes Only
    ----================
    --DELETE FROM dbo.U_EIVBRFSAEN_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EIVBRFSAEN_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'FSA,FSADC,FSADW,FSAW,HSA1,HSA10,HSA11,HSA12,HSA13,HSA14,HSA15,HSA16,HSA17,HSA18,HSA19,HSA1W,HSA2,HSA20,HSA21,HSA22,HSA23,HSA24,HSA2W,HSA3,HSA3W,HSA4,HSA4W,HSA5,HSA5W,HSA6,HSA6W,HSA7,HSA7W,HSA8,HSA8W,HSA9';

    IF OBJECT_ID('U_EIVBRFSAEN_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EIVBRFSAEN_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EIVBRFSAEN_DedList
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
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EIVBRFSAEN_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EIVBRFSAEN_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EIVBRFSAEN_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvEmployerID = CmpFedTaxID
        ,drvMemberID = '"' + LTrim(RTrim(Eepssn))  + '"'
        ,drvSSNSSN = '"' + LTrim(RTrim(Eepssn)) + '"'
        ,drvOtherID = ''
        ,drvGenderGender = EepGender
        ,drvLastName = EepNameLast
        ,drvFirstName = EepNameFirst
        ,drvMiddleInitial = LEFT(EepNameMiddle,1)
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvCityCity = EepAddressCity
        ,drvStateState = EepAddressState
        ,drvZIPZIP = Eepaddresszipcode
        ,drvPhonePhone = Eepphonehomenumber
        ,drvEmailAddress = EepAddressEMail
        ,drvDateBirth = CONVERT(VARCHAR(8), eepdateofbirth, 112)
        ,drvDateHire = CONVERT(VARCHAR(8), Eecdateoflasthire, 112)
        ,drvEmploymentDate = CASE WHEN eecemplstatus = 'T' then CONVERT(VARCHAR(8), eecdateoftermination, 112)  
                                    WHEN  eecemplstatus <> 'T' and Bdmbenstopdate is not null and BdmChangeReason = '203' then CONVERT(VARCHAR(8), EjhJobEffDate, 112)
                                    END

        ,drvEmployeeStatus = CASE WHEN eecemplstatus = 'T' then 'NE' 
                                    WHEN  eecemplstatus <> 'T' and Bdmbenstopdate is not null and BdmChangeReason = '203' then 'NE' else 'FT'
                                    END
        ,drvFundingFrequency = CASE         
                                    WHEN BdmDedCode  = 'FSA' and eecpaygroup IN ('USBW' , 'SBBW')then 'B1' 
                                    WHEN BdmDedCode  = 'FSA' and eecpaygroup = 'IVMI' then 'W1'
                                    WHEN BdmDedCode  = 'FSADC' and eecpaygroup IN ('USBW' , 'SBBW')then 'B1'  
                                    WHEN BdmDedCode  = 'FSADC' and eecpaygroup = 'IVMI' then 'W1'
                                    WHEN BdmDedCode  = 'FSADW' and eecpaygroup IN ('USBW' , 'SBBW')then 'B1'  
                                    WHEN BdmDedCode  = 'FSADW' and eecpaygroup = 'IVMI' then 'W1'
                                    WHEN BdmDedCode  = 'FSAW' and eecpaygroup IN ('USBW' , 'SBBW')then 'B1'  
                                    WHEN BdmDedCode  = 'FSAW' and eecpaygroup = 'IVMI' then 'W1'
                                    WHEN BdmDedCode  = 'HSA1' and eecpaygroup IN ('USBW' , 'SBBW')then 'B2' 
                                    WHEN BdmDedCode  = 'HSA1' and eecpaygroup = 'IVMI' then 'W2'
                                    WHEN BdmDedCode  = 'HSA10' and eecpaygroup IN ('USBW' , 'SBBW')then 'B2' 
                                    WHEN BdmDedCode  = 'HSA10' and eecpaygroup = 'IVMI' then 'W2'
                                    WHEN BdmDedCode  = 'HSA11' and eecpaygroup IN ('USBW' , 'SBBW')then 'B2' 
                                    WHEN BdmDedCode  = 'HSA11' and eecpaygroup = 'IVMI' then 'W2'
                                    WHEN BdmDedCode  = 'HSA12' and eecpaygroup IN ('USBW' , 'SBBW')then 'B2' 
                                    WHEN BdmDedCode  = 'HSA12' and eecpaygroup = 'IVMI' then 'W2'
                                    WHEN BdmDedCode  = 'HSA13' and eecpaygroup IN ('USBW' , 'SBBW')then 'B2' 
                                    WHEN BdmDedCode  = 'HSA13' and eecpaygroup = 'IVMI' then 'W2'
                                    WHEN BdmDedCode  = 'HSA14' and eecpaygroup IN ('USBW' , 'SBBW')then 'B2' 
                                    WHEN BdmDedCode  = 'HSA14' and eecpaygroup = 'IVMI' then 'W2'
                                    WHEN BdmDedCode  = 'HSA15' and eecpaygroup IN ('USBW' , 'SBBW')then 'B2' 
                                    WHEN BdmDedCode  = 'HSA15' and eecpaygroup = 'IVMI' then 'W2'
                                    WHEN BdmDedCode  = 'HSA16' and eecpaygroup IN ('USBW' , 'SBBW')then 'B2' 
                                    WHEN BdmDedCode  = 'HSA16' and eecpaygroup = 'IVMI' then 'W2'
                                    WHEN BdmDedCode  = 'HSA17' and eecpaygroup IN ('USBW' , 'SBBW')then 'B2' 
                                    WHEN BdmDedCode  = 'HSA17' and eecpaygroup = 'IVMI' then 'W2'
                                    WHEN BdmDedCode  = 'HSA18' and eecpaygroup IN ('USBW' , 'SBBW')then 'B2' 
                                    WHEN BdmDedCode  = 'HSA18' and eecpaygroup = 'IVMI' then 'W2'
                                    WHEN BdmDedCode  = 'HSA19' and eecpaygroup IN ('USBW' , 'SBBW')then 'B2' 
                                    WHEN BdmDedCode  = 'HSA19' and eecpaygroup = 'IVMI' then 'W2'
                                    WHEN BdmDedCode  = 'HSA1W' and eecpaygroup IN ('USBW' , 'SBBW')then 'B2' 
                                    WHEN BdmDedCode  = 'HSA1W' and eecpaygroup = 'IVMI' then 'W2'
                                    WHEN BdmDedCode  = 'HSA2' and eecpaygroup IN ('USBW' , 'SBBW')then 'B2' 
                                    WHEN BdmDedCode  = 'HSA2' and eecpaygroup = 'IVMI' then 'W2'

                                    WHEN BdmDedCode  = 'HSA20' and eecpaygroup IN ('USBW' , 'SBBW')then 'B2' 
                                    WHEN BdmDedCode  = 'HSA20' and eecpaygroup = 'IVMI' then 'W2'
                                    WHEN BdmDedCode  = 'HSA21' and eecpaygroup IN ('USBW' , 'SBBW')then 'B2' 
                                    WHEN BdmDedCode  = 'HSA21' and eecpaygroup = 'IVMI' then 'W2'
                                    WHEN BdmDedCode  = 'HSA22' and eecpaygroup IN ('USBW' , 'SBBW')then 'B2' 
                                    WHEN BdmDedCode  = 'HSA22' and eecpaygroup = 'IVMI' then 'W2'
                                    WHEN BdmDedCode  = 'HSA23' and eecpaygroup IN ('USBW' , 'SBBW')then 'B2' 
                                    WHEN BdmDedCode  = 'HSA23' and eecpaygroup = 'IVMI' then 'W2'
                                    WHEN BdmDedCode  = 'HSA24' and eecpaygroup IN ('USBW' , 'SBBW')then 'B2' 
                                    WHEN BdmDedCode  = 'HSA24' and eecpaygroup = 'IVMI' then 'W2'
                                    WHEN BdmDedCode  = 'HSA2W' and eecpaygroup IN ('USBW' , 'SBBW')then 'B2' 
                                    WHEN BdmDedCode  = 'HSA2W' and eecpaygroup = 'IVMI' then 'W2'
                                    WHEN BdmDedCode  = 'HSA3' and eecpaygroup IN ('USBW' , 'SBBW')then 'B2' 
                                    WHEN BdmDedCode  = 'HSA3' and eecpaygroup = 'IVMI' then 'W2'
                                    WHEN BdmDedCode  = 'HSA3W' and eecpaygroup IN ('USBW' , 'SBBW')then 'B2' 
                                    WHEN BdmDedCode  = 'HSA3W' and eecpaygroup = 'IVMI' then 'W2'
                                    WHEN BdmDedCode  = 'HSA4' and eecpaygroup IN ('USBW' , 'SBBW')then 'B2' 
                                    WHEN BdmDedCode  = 'HSA4' and eecpaygroup = 'IVMI' then 'W2'
                                    WHEN BdmDedCode  = 'HSA4W' and eecpaygroup IN ('USBW' , 'SBBW')then 'B2' 
                                    WHEN BdmDedCode  = 'HSA4W' and eecpaygroup = 'IVMI' then 'W2'
                                    WHEN BdmDedCode  = 'HSA5' and eecpaygroup IN ('USBW' , 'SBBW')then 'B2' 
                                    WHEN BdmDedCode  = 'HSA5' and eecpaygroup = 'IVMI' then 'W2'
                                    WHEN BdmDedCode  = 'HSA5W' and eecpaygroup IN ('USBW' , 'SBBW')then 'B2' 
                                    WHEN BdmDedCode  = 'HSA5W' and eecpaygroup = 'IVMI' then 'W2'
                                    WHEN BdmDedCode  = 'HSA6' and eecpaygroup IN ('USBW' , 'SBBW')then 'B2' 
                                    WHEN BdmDedCode  = 'HSA6' and eecpaygroup = 'IVMI' then 'W2'
                                    WHEN BdmDedCode  = 'HSA6W' and eecpaygroup IN ('USBW' , 'SBBW')then 'B2' 
                                    WHEN BdmDedCode  = 'HSA6W' and eecpaygroup = 'IVMI' then 'W2'
                                    WHEN BdmDedCode  = 'HSA7' and eecpaygroup IN ('USBW' , 'SBBW')then 'B2' 
                                    WHEN BdmDedCode  = 'HSA7' and eecpaygroup = 'IVMI' then 'W2'
                                    WHEN BdmDedCode  = 'HSA7W' and eecpaygroup IN ('USBW' , 'SBBW')then 'B2' 
                                    WHEN BdmDedCode  = 'HSA7W' and eecpaygroup = 'IVMI' then 'W2'
                                    WHEN BdmDedCode  = 'HSA8' and eecpaygroup IN ('USBW' , 'SBBW')then 'B2' 
                                    WHEN BdmDedCode  = 'HSA8' and eecpaygroup = 'IVMI' then 'W2'
                                    WHEN BdmDedCode  = 'HSA8W' and eecpaygroup IN ('USBW' , 'SBBW')then 'B2' 
                                    WHEN BdmDedCode  = 'HSA8W' and eecpaygroup = 'IVMI' then 'W2'
                                    WHEN BdmDedCode  = 'HSA9' and eecpaygroup IN ('USBW' , 'SBBW')then 'B2' 
                                    WHEN BdmDedCode  = 'HSA9' and eecpaygroup = 'IVMI' then 'W2'

                                    END

        ,drvInsuranceCode = 'MED000'
        ,drvInsuranceDate = CONVERT(VARCHAR(8), Bdmbenstartdate,112)
        ,drvAccountType = ''
        ,drvElectionEffDate = CONVERT(VARCHAR(8), Bdmbenstartdate,112)
        ,drvElectionEndDate = CONVERT(VARCHAR(8),Bdmbenstopdate, 112)
        ,drvPerDeduction = BdmEEAmt
        ,drvFullElection = BdmEEGoalAmt
        ,drvUserDefined1 = ''
        ,drvUserDefined2 = ''
        ,drvSSOValue = ''
        ,drvCoverageCode = ''
    INTO dbo.U_EIVBRFSAEN_drvTbl
    FROM dbo.U_EIVBRFSAEN_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
     JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.U_dsi_BDM_EIVBRFSAEN WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
     LEFT JOIN (
                SELECT EfoEEID, EfoPhoneNumber
                FROM (
                        SELECT EfoEEID, EfoPhoneNumber, ROW_NUMBER() OVER (PARTITION BY EfoEEID ORDER BY EfoPhoneNumber) AS RN --, ORDER BY Ef
                        FROM  dbo.EmpMPhon WITH (NOLOCK)
                        WHERE EfoPhoneType = 'CEL') AS Efo
                WHERE RN = 1 ) AS EfoPhone
        ON EfoEEID = xEEID
        LEFT JOIN (SELECT ejhEEID, ejhCOID, MAX(EjhJobEffDate) as EjhJobEffDate
                    FROM vw_int_EmpHJob  WITH (NOLOCK)
                    WHERE EjhIsRateChange = 'Y'
                    GROUP BY ejhEEID, ejhCOID) EJH
        ON EJH.ejhEEID = xEEID
        AND EJH.ejhCOID = xCOID
     JOIN dbo.Company WITH (NOLOCK)
        ON cmpCOID = XCOID
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
ALTER VIEW dbo.dsi_vwEIVBRFSAEN_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EIVBRFSAEN_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EIVBRFSAEN%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202302131'
       ,expStartPerControl     = '202302131'
       ,expLastEndPerControl   = '202302209'
       ,expEndPerControl       = '202302209'
WHERE expFormatCode = 'EIVBRFSAEN';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEIVBRFSAEN_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EIVBRFSAEN_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EIVBRFSAEN' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EIVBRFSAEN'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EIVBRFSAEN'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EIVBRFSAEN', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EIVBRFSAEN', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EIVBRFSAEN', 'UseFileName', 'V', 'Y'


-- End ripout