/**********************************************************************************

ECALLTHEFT: Allstate ID Theft Protection

FormatCode:     ECALLTHEFT
Project:        Allstate ID Theft Protection
Client ID:      CIS1000
Date/time:      2024-01-30 13:25:30.523
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW3WUP3DB03
Database:       ULTIPRO_WPCISIN
Web Filename:   CIS1000_35B05_EEHISTORY_ECALLTHEFT_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ECALLTHEFT_SavePath') IS NOT NULL DROP TABLE dbo.U_ECALLTHEFT_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ECALLTHEFT'


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
WHERE FormatCode = 'ECALLTHEFT'
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
WHERE ExpFormatCode = 'ECALLTHEFT'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ECALLTHEFT')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ECALLTHEFT'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ECALLTHEFT'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ECALLTHEFT'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ECALLTHEFT'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ECALLTHEFT'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ECALLTHEFT'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ECALLTHEFT'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ECALLTHEFT'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ECALLTHEFT'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwECALLTHEFT_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECALLTHEFT_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECALLTHEFT') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECALLTHEFT];
GO
IF OBJECT_ID('U_ECALLTHEFT_File') IS NOT NULL DROP TABLE [dbo].[U_ECALLTHEFT_File];
GO
IF OBJECT_ID('U_ECALLTHEFT_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECALLTHEFT_EEList];
GO
IF OBJECT_ID('U_ECALLTHEFT_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ECALLTHEFT_drvTbl];
GO
IF OBJECT_ID('U_ECALLTHEFT_DedList') IS NOT NULL DROP TABLE [dbo].[U_ECALLTHEFT_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_ECALLTHEFT') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ECALLTHEFT];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ECALLTHEFT','Allstate ID Theft Protection','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','ECALLTHEFTZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECALLTHEFTZ0','50','H','01','1',NULL,'Effective Date',NULL,NULL,'"Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECALLTHEFTZ0','50','H','01','2',NULL,'Status',NULL,NULL,'"Status"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECALLTHEFTZ0','50','H','01','3',NULL,'ClientID',NULL,NULL,'"ClientID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECALLTHEFTZ0','50','H','01','4',NULL,'EmployeeID',NULL,NULL,'"EmployeeID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECALLTHEFTZ0','50','H','01','5',NULL,'MemberFirstName',NULL,NULL,'"MemberFirstName"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECALLTHEFTZ0','50','H','01','6',NULL,'MemberMiddleName',NULL,NULL,'"MemberMiddleName"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECALLTHEFTZ0','50','H','01','7',NULL,'MemberLastName',NULL,NULL,'"MemberLastName"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECALLTHEFTZ0','50','H','01','8',NULL,'MemberSSN',NULL,NULL,'"MemberSSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECALLTHEFTZ0','50','H','01','9',NULL,'DOB_Month',NULL,NULL,'"DOB_Month"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECALLTHEFTZ0','50','H','01','10',NULL,'DOB_Day',NULL,NULL,'"DOB_Day"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECALLTHEFTZ0','50','H','01','11',NULL,'DOB_Year',NULL,NULL,'"DOB_Year"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECALLTHEFTZ0','50','H','01','12',NULL,'Address1',NULL,NULL,'"Address1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECALLTHEFTZ0','50','H','01','13',NULL,'Address2',NULL,NULL,'"Address2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECALLTHEFTZ0','50','H','01','14',NULL,'City',NULL,NULL,'"City"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECALLTHEFTZ0','50','H','01','15',NULL,'State',NULL,NULL,'"State"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECALLTHEFTZ0','50','H','01','16',NULL,'ZipCode',NULL,NULL,'"ZipCode"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECALLTHEFTZ0','50','H','01','17',NULL,'AreaCode',NULL,NULL,'"AreaCode"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ECALLTHEFTZ0','50','H','01','18',NULL,'HomePhone',NULL,NULL,'"HomePhone"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ECALLTHEFTZ0','50','H','01','19',NULL,'Email',NULL,NULL,'"Email"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ECALLTHEFTZ0','50','H','01','20',NULL,'Deduction Method',NULL,NULL,'"Deduction Method"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ECALLTHEFTZ0','50','H','01','21',NULL,'Customer_Defined',NULL,NULL,'"Customer_Defined"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ECALLTHEFTZ0','50','H','01','22',NULL,'Relationship',NULL,NULL,'"Relationship"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ECALLTHEFTZ0','50','H','01','23',NULL,'Primary',NULL,NULL,'"Primary"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ECALLTHEFTZ0','50','H','01','24',NULL,'FamilyID',NULL,NULL,'"FamilyID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ECALLTHEFTZ0','50','H','01','25',NULL,'UniqueID',NULL,NULL,'"UniqueID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ECALLTHEFTZ0','50','H','01','26',NULL,'Plan_Type',NULL,NULL,'"Plan_Type"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ECALLTHEFTZ0','50','H','01','27',NULL,'ProductID',NULL,NULL,'"ProductID"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECALLTHEFTZ0','50','D','10','1',NULL,'Effective Date',NULL,NULL,'"drvEffectiveDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECALLTHEFTZ0','50','D','10','2',NULL,'Status',NULL,NULL,'"drvStatus"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECALLTHEFTZ0','50','D','10','3',NULL,'ClientID',NULL,NULL,'"drvClientID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECALLTHEFTZ0','50','D','10','4',NULL,'EmployeeID',NULL,NULL,'"drvEmployeeID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECALLTHEFTZ0','50','D','10','5',NULL,'MemberFirstName',NULL,NULL,'"drvMemberFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECALLTHEFTZ0','50','D','10','6',NULL,'MemberMiddleName',NULL,NULL,'"drvMemberMiddleName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECALLTHEFTZ0','50','D','10','7',NULL,'MemberLastName',NULL,NULL,'"drvMemberLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECALLTHEFTZ0','50','D','10','8',NULL,'MemberSSN',NULL,NULL,'"drvMemberSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECALLTHEFTZ0','50','D','10','9',NULL,'DOB_Month',NULL,NULL,'"drvDOBMonth"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECALLTHEFTZ0','50','D','10','10',NULL,'DOB_Day',NULL,NULL,'"drvDOBDay"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECALLTHEFTZ0','50','D','10','11',NULL,'DOB_Year',NULL,NULL,'"drvDOBYear"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECALLTHEFTZ0','50','D','10','12',NULL,'Address1',NULL,NULL,'"drvAddress1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECALLTHEFTZ0','50','D','10','13',NULL,'Address2',NULL,NULL,'"drvAddress2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECALLTHEFTZ0','50','D','10','14',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECALLTHEFTZ0','50','D','10','15',NULL,'State',NULL,NULL,'"drvState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECALLTHEFTZ0','50','D','10','16',NULL,'ZipCode',NULL,NULL,'"drvZipCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECALLTHEFTZ0','50','D','10','17',NULL,'AreaCode',NULL,NULL,'"drvAreaCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ECALLTHEFTZ0','50','D','10','18',NULL,'HomePhone',NULL,NULL,'"drvHomePhone"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ECALLTHEFTZ0','50','D','10','19',NULL,'Email',NULL,NULL,'"drvEmail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ECALLTHEFTZ0','50','D','10','20',NULL,'Deduction Method',NULL,NULL,'"drvDeductionMethod"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ECALLTHEFTZ0','50','D','10','21',NULL,'Customer_Defined',NULL,NULL,'"drvCustomerDefined"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ECALLTHEFTZ0','50','D','10','22',NULL,'Relationship',NULL,NULL,'"drvRelationship"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ECALLTHEFTZ0','50','D','10','23',NULL,'Primary',NULL,NULL,'"drvPrimary"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ECALLTHEFTZ0','51','D','10','24',NULL,'FamilyID',NULL,NULL,'"drvFamilyID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ECALLTHEFTZ0','52','D','10','25',NULL,'UniqueID',NULL,NULL,'"drvUniqueID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ECALLTHEFTZ0','53','D','10','26',NULL,'Plan_Type',NULL,NULL,'"drvPlanType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ECALLTHEFTZ0','54','D','10','27',NULL,'ProductID',NULL,NULL,'"drvProductID"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ECALLTHEFT_20240130.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,',OEXEV,UVGMB,S9YG4,S9YM6,39NL5,UVGSI',NULL,NULL,NULL,'Allstate IDT Active OE','202309279','EMPEXPORT','OEACTIVE',NULL,'ECALLTHEFT',NULL,NULL,NULL,'202309279','Sep 27 2023  7:42AM','Sep 27 2023  7:42AM','202309271',NULL,'','','202309271',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,',OEXEV,UVGMB,S9YG4,S9YM6,39NL5,UVGSI',NULL,NULL,NULL,'Allstate IDT Passive OE','202309279','EMPEXPORT','OEPASSIVE',NULL,'ECALLTHEFT',NULL,NULL,NULL,'202309279','Sep 27 2023  7:42AM','Sep 27 2023  7:42AM','202309271',NULL,'','','202309271',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,',OEXEV,UVGMB,S9YG4,S9YM6,39NL5,UVGSI',NULL,NULL,NULL,'Allstate IDT ONDEMAND','202309279','EMPEXPORT','ONDEM_XOE',NULL,'ECALLTHEFT',NULL,NULL,NULL,'202309279','Sep 27 2023  7:42AM','Sep 27 2023  7:42AM','202309271',NULL,'','','202309271',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N','S476H,S9YQN,S47FA,S4OGG,S4OPO,S4OAW,0WU9L,OEXEV,8GMQC,6CX8K,8GN9Z,SH2FJ,SH6KQ,S9HSN,CI2OR,UX1ZQ,UX2XE,EXPWW,UX2G6,CI2ZG,4M6C7,UX21T,S9HVQ,PQKHG,6HVZD,UX1XV,N0H25,UVGMB,S9HJO,JN4Q8,S9YG4,S9HP8,L7LMB,L7M02,L5S7V,L7M7A,L5RY2,S9YM6,UX1WB,UVGPV,UVGRE,YSFFV,IJHRA,DYI26,DYI71,7DF2L,4N71R,5BUUZ,5BU4Y,5BUIG,5BU96,39NL5,B0P0N,B0P2A,DYHW7,B1442,B0OJO,K0OXU,B0OXY,B0OTL,B0OV7,B0OQH,4M67O,B0OIN,B0OAK,B0O7F,B0OHI,B0O4G,S48H7,S4OKN,7V7P7,UVGSI',NULL,NULL,NULL,'Allstate IDT - Fridays 12:10am','202309279','EMPEXPORT','SCH_ECALLT',NULL,'ECALLTHEFT',NULL,NULL,NULL,'202401269','Sep 27 2023  7:42AM','Sep 27 2023  7:42AM','202401191',NULL,'','','202309271',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','OEXEV,UVGMB,S9YG4,S9YM6,39NL5,UVGSI',NULL,NULL,NULL,'Allstate IDT Test','202310119','EMPEXPORT','TEST_XOE','Oct 11 2023  9:11AM','ECALLTHEFT',NULL,NULL,NULL,'202310119','Oct 11 2023 12:00AM','Dec 30 1899 12:00AM','202310041','281','','','202310041',dbo.fn_GetTimedKey(),NULL,'us3kEpCIS1000',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECALLTHEFT','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECALLTHEFT','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECALLTHEFT','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECALLTHEFT','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECALLTHEFT','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECALLTHEFT','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECALLTHEFT','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECALLTHEFT','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECALLTHEFT','D10','dbo.U_ECALLTHEFT_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_ECALLTHEFT
-----------

IF OBJECT_ID('U_dsi_BDM_ECALLTHEFT') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ECALLTHEFT] (
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
-- Create table U_ECALLTHEFT_DedList
-----------

IF OBJECT_ID('U_ECALLTHEFT_DedList') IS NULL
CREATE TABLE [dbo].[U_ECALLTHEFT_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_ECALLTHEFT_drvTbl
-----------

IF OBJECT_ID('U_ECALLTHEFT_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ECALLTHEFT_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] nvarchar(4000) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvEffectiveDate] varchar(30) NULL,
    [drvStatus] varchar(4) NOT NULL,
    [drvClientID] varchar(4) NOT NULL,
    [drvEmployeeID] char(9) NULL,
    [drvMemberFirstName] varchar(100) NULL,
    [drvMemberMiddleName] varchar(1) NULL,
    [drvMemberLastName] varchar(100) NULL,
    [drvMemberSSN] char(11) NULL,
    [drvDOBMonth] int NULL,
    [drvDOBDay] int NULL,
    [drvDOBYear] int NULL,
    [drvAddress1] varchar(6000) NULL,
    [drvAddress2] varchar(6000) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZipCode] varchar(50) NULL,
    [drvAreaCode] varchar(3) NULL,
    [drvHomePhone] varchar(7) NULL,
    [drvEmail] varchar(50) NULL,
    [drvDeductionMethod] varchar(26) NOT NULL,
    [drvCustomerDefined] varchar(1) NOT NULL,
    [drvRelationship] varchar(1) NULL,
    [drvPrimary] varchar(1) NULL,
    [drvFamilyID] nvarchar(4000) NULL,
    [drvUniqueID] nvarchar(4000) NULL,
    [drvPlanType] varchar(10) NOT NULL,
    [drvProductID] varchar(3) NOT NULL
);

-----------
-- Create table U_ECALLTHEFT_EEList
-----------

IF OBJECT_ID('U_ECALLTHEFT_EEList') IS NULL
CREATE TABLE [dbo].[U_ECALLTHEFT_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ECALLTHEFT_File
-----------

IF OBJECT_ID('U_ECALLTHEFT_File') IS NULL
CREATE TABLE [dbo].[U_ECALLTHEFT_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECALLTHEFT]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Cision US, Inc

Created By: Marie Waters
Business Analyst: Kim Ephraim
Create Date: 09/27/2023
Service Request Number: TekP-2023-07-24-02

Purpose: Allstate ID Theft Protection

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECALLTHEFT';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECALLTHEFT';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECALLTHEFT';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECALLTHEFT';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECALLTHEFT' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECALLTHEFT', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECALLTHEFT', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECALLTHEFT', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECALLTHEFT', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECALLTHEFT', 'SCH_ECALLT';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ECALLTHEFT';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ECALLTHEFT', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ECALLTHEFT';

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
    DELETE FROM dbo.U_ECALLTHEFT_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECALLTHEFT_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'IDTFT';

    IF OBJECT_ID('U_ECALLTHEFT_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ECALLTHEFT_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ECALLTHEFT_DedList
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

     --INSERT INTO [dbo].[U_dsi_BDM_ECALLTHEFT]
  --         ([BdmRecType]
  --         ,[BdmCOID]
  --         ,[BdmEEID]
  --         ,[BdmDepRecID]
  --         ,[BdmRelationship]
  --         ,[BdmDateOfBirth]
  --         ,[BdmDedCode]
        --   ,[BdmDedType]
  --         ,[BdmBenOption]
        --   ,[BdmBenStatus]
  --         ,[BdmBenStartDate]
  --         ,[BdmBenStopDate]
  --         ,[BdmBenStatusDate]
  --         ,[BdmDateOFCobraEvent]
  --         ,[BdmChangeReason]
  --         ,[BdmCobraReason]
  --         ,[BdmStartDate]
  --         ,[BdmStopDate]
  --         ,[BdmIsPQB]
  --  )
  --  SELECT [BdmRecType] = 'DEP'     
  --         ,[BdmCOID]
  --         ,[BdmEEID]
  --         ,LTRIM(RTrim(ConSystemID))
  --         ,Ltrim(RTrim(ConRelationship))
  --         ,[BdmDateOfBirth]
  --         ,[BdmDedCode]
        --   ,[BdmDedType]
  --         ,[BdmBenOption]
        --   ,[BdmBenStatus]
  --         ,[BdmBenStartDate]
  --         ,[BdmBenStopDate]
  --         ,[BdmBenStatusDate]
  --         ,[BdmDateOFCobraEvent]
  --         ,[BdmChangeReason]
  --         ,[BdmCobraReason]
  --         ,[BdmStartDate]
  --         ,[BdmStopDate]
  --         ,[BdmIsPQB]
  --   FROM  dbo.U_dsi_BDM_ECALLTHEFT WITH (NOLOCK)
        --JOIN dbo.Contacts WITH (NOLOCK)
        -- ON Bdmeeid = Coneeid
  --       Where Conrelationship IN  ('SPS','DP','CHL','DIS','DPC','GRC','STC')
  --       and conisdependent = 'Y'
        -- And ConSystemID NOT IN (Select DISTINCT a. BdmDepRecID FROM dbo.U_dsi_BDM_ECALLTHEFT a WITH (NOLOCK) where a.BdmDepRecID is not null )
        -- ;

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ECALLTHEFT_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ECALLTHEFT_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECALLTHEFT_drvTbl;
  SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = CASE WHEN BdmRecType = 'EMP' THEN ConCat(RTRIM(EecEmpNo),'0') ELSE ConCat(RTRIM(EecEmpNo) , RN) END
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvEffectiveDate = Convert(varchar,BdmBenStartDate, 101)
        ,drvStatus = CASE WHEN BdmBenstatus IN ('C', 'T') Then 'DROP' ELSE 'ADD' END
        ,drvClientID = '6464'
        ,drvEmployeeID = CASE WHEN BdmRecType IN ('EMP','DEP') THEN EecEmpNo  END    --ELSE '0000000000'
        ,drvMemberFirstName = CASE WHEN BdmRecType = 'EMP' THEN EepNameFirst ELSE ConNameFirst END
        ,drvMemberMiddleName = CASE WHEN BdmRecType = 'EMP' THEN LEFT(EepNameMiddle,1) ELSE LEFT(ConNameMiddle,1) END
        ,drvMemberLastName = CASE WHEN BdmRecType = 'EMP' THEN EepNameLast ELSE ConNameLast END
        ,drvMemberSSN = CASE WHEN BdmRecType = 'EMP' THEN eepSSN 
                            WHEN BdmRecType = 'DEP' THEN ConSSN END
                             --WHEN ConSSN is null THEN '0000000000' 
                             --WHEN ConSSN = 1 THEN '0000000000' 
                             -- ELSE ConSSN END
        ,drvDOBMonth = CASE WHEN BdmRecType = 'EMP' THEN Month(EepDateOfBirth) ELSE  Month(ConDateOfBirth) END
        ,drvDOBDay = CASE WHEN BdmRecType = 'EMP' THEN Day(EepDateOfBirth) ELSE  Day(ConDateOfBirth) END
        ,drvDOBYear = CASE WHEN BdmRecType = 'EMP' THEN Year(EepDateOfBirth) ELSE  Year(ConDateOfBirth) END
        ,drvAddress1 = CASE WHEN BdmRecType = 'EMP' THEN dbo.dsi_fnRemoveChars(',',EepAddressLine1) ELSE dbo.dsi_fnRemoveChars(',',ConAddressLine1)  END 
        ,drvAddress2 = CASE WHEN BdmRecType = 'EMP' THEN dbo.dsi_fnRemoveChars(',',EepAddressLine2) ELSE dbo.dsi_fnRemoveChars(',',ConAddressLine2)  END 
        ,drvCity = CASE WHEN BdmRecType = 'EMP' THEN EepAddressCity ELSE ConAddressCity END 
        ,drvState = CASE WHEN BdmRecType = 'EMP' THEN EepAddressState ELSE ConAddressState END 
        ,drvZipCode = CASE WHEN BdmRecType = 'EMP' THEN EepAddressZipCode ELSE ConAddressZipCode  END 
        ,drvAreaCode = CASE WHEN EepPhoneHomeNumber is null then '000' ELSE LEFT(EepPhoneHomeNumber,3) END
        ,drvHomePhone = CASE WHEN EepPhoneHomeNumber is null then '0000000' ELSE RIGHT(EepPhoneHomeNumber,7) END
        ,drvEmail = CASE WHEN ISNULL( EepAddressEMail, '') <>  '' THEN EepAddressEMail Else 'email@infoarmor.com' END
        ,drvDeductionMethod = CASE WHEN BDMDedcode is not null THEN 'Employer Payroll Deduction' ELSE  '' END
        ,drvCustomerDefined = ''
        ,drvRelationship = CASE WHEN BdmRecType = 'DEP' AND BdmRelationship IN ('SPS','DP') THEN 'S'
                                WHEN BdmRecType = 'DEP' AND BdmRelationship IN ('CHL','DIS','DPC','GRC','STC') THEN 'C'
                                WHEN BdmRecType = 'EMP' THEN 'P'
                            END
            
        ,drvPrimary = CASE WHEN BdmRecType = 'DEP' THEN 'N'  --AND BdmRelationship IN ('SPS','DP','CHL','DIS','DPC','GRC','STC') THEN 'N'
                           WHEN BdmRecType = 'EMP' THEN 'Y'
                       END
        ,drvFamilyID = CASE WHEN BdmRecType = 'EMP' THEN EecEmpNo ELSE ConCat(RTRIM(EecEmpNo) , RN)  END   --EecEmpNo  
                             
        ,drvUniqueID = CASE WHEN BdmRecType = 'EMP'  THEN  EecEmpNo ELSE ConCat(RTRIM(EecEmpNo) , RN) END 
                        --    WHEN BdmRecType = 'DEP'  THEN  (SELECT top 1 EecEmpNo  FROm dbo.vw_int_EmpComp Where Eeceeid = BdmEEID) + RN
                        --    ELSE   '0000000000'
                        --END
        ,drvPlanType = CASE WHEN BdmBenOption IN ('EEF','EEDPF') THEN 'Family'
                            ELSE 'Individual'
                          END
                        --CASE WHEN BdmDedcode is not null and ( (SELECT COUNT(*) FROM dbo.Contacts Con WITH (NOLOCK) WHERE Con.ConEEID = xEEID and Conrelationship IN  ('SPS','DP','CHL','DIS','DPC','GRC','STC')and conisdependent = 'Y') = '0')THEN 'Individual'
      --                      WHEN BdmBenOption IN ('EEF','EEDPF') or (  (SELECT COUNT(*) FROM dbo.Contacts Con WITH (NOLOCK) WHERE Con.ConEEID = xEEID and Conrelationship IN  ('SPS','DP','CHL','DIS','DPC','GRC','STC')and conisdependent = 'Y') >= '1')  THEN 'Family'
      --                     ELSE ''
                        --   END

        ,drvProductID = 'PAP'
    INTO dbo.U_ECALLTHEFT_drvTbl
    FROM dbo.U_ECALLTHEFT_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ECALLTHEFT WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN (  SELECT DISTINCT ConEEID, ConSystemID, ConRelationship, ConNameFirst, ConNameLast, ConNameMiddle, ConDateOfBirth, ConGender, ConAddressLine1, ConAddressLine2, ConAddressCity, ConAddressState, ConAddressZipCode, ConSSN, RN 
                FROM ( 
                        SELECT DISTINCT ConEEID, ConSystemID, ConRelationship, ConNameFirst, ConNameLast, ConNameMiddle, ConDateOfBirth, ConGender, ConAddressLine1, ConAddressLine2, ConAddressCity, ConAddressState, ConAddressZipCode, ConSSN,   FORMAT(ROW_NUMBER() OVER (PARTITION BY ConEEID ORDER By ConDateOfBirth Asc), '00') AS RN 
                        FROM dbo.Contacts WITH (NOLOCK) 
                        Where Conrelationship IN  ('SPS','DP','CHL','DIS','DPC','GRC','STC')
                            and conisdependent = 'Y'
                       
                        
                    ) AS Con 
        ) CONS
         ON ConEEID = BdmEEID
        AND ISNULL(ConSystemID, '') = ISNULL(BdmDepRecID, '')
      WHERE EecEmplStatus IN ('A', 'L')
        --WHERE EecEEType = 'REG' AND EecEmplStatus IN ('A', 'L')
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
ALTER VIEW dbo.dsi_vwECALLTHEFT_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECALLTHEFT_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'ECALLTHEFT%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202309201'
       ,expStartPerControl     = '202309201'
       ,expLastEndPerControl   = '202309279'
       ,expEndPerControl       = '202309279'
WHERE expFormatCode = 'ECALLTHEFT';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwECALLTHEFT_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ECALLTHEFT_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ECALLTHEFT' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ECALLTHEFT'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ECALLTHEFT'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECALLTHEFT', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ECALLTHEFT', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECALLTHEFT', 'UseFileName', 'V', 'Y'


-- End ripout