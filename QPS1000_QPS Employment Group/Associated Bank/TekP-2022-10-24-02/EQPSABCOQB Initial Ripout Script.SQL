/**********************************************************************************

EQPSABCOQB: Associated Bank COBRA QB

FormatCode:     EQPSABCOQB
Project:        Associated Bank COBRA QB
Client ID:      QPS1000
Date/time:      2023-02-22 10:33:10.180
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    NWP
Server:         NW1WUP3DB03
Database:       ULTIPRO_WPQPS
Web Filename:   QPS1000_6TRXF_EEHISTORY_EQPSABCOQB_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EQPSABCOQB_SavePath') IS NOT NULL DROP TABLE dbo.U_EQPSABCOQB_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EQPSABCOQB'


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
WHERE FormatCode = 'EQPSABCOQB'
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
WHERE ExpFormatCode = 'EQPSABCOQB'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EQPSABCOQB')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EQPSABCOQB'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EQPSABCOQB'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EQPSABCOQB'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EQPSABCOQB'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EQPSABCOQB'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EQPSABCOQB'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EQPSABCOQB'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EQPSABCOQB'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EQPSABCOQB'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEQPSABCOQB_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEQPSABCOQB_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EQPSABCOQB') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EQPSABCOQB];
GO
IF OBJECT_ID('U_EQPSABCOQB_File') IS NOT NULL DROP TABLE [dbo].[U_EQPSABCOQB_File];
GO
IF OBJECT_ID('U_EQPSABCOQB_EEList') IS NOT NULL DROP TABLE [dbo].[U_EQPSABCOQB_EEList];
GO
IF OBJECT_ID('U_EQPSABCOQB_drvTbl_QBPLANINSERT') IS NOT NULL DROP TABLE [dbo].[U_EQPSABCOQB_drvTbl_QBPLANINSERT];
GO
IF OBJECT_ID('U_EQPSABCOQB_drvTbl_QBINSERT') IS NOT NULL DROP TABLE [dbo].[U_EQPSABCOQB_drvTbl_QBINSERT];
GO
IF OBJECT_ID('U_EQPSABCOQB_drvTbl_QBDEPENDENTPLANINSERT') IS NOT NULL DROP TABLE [dbo].[U_EQPSABCOQB_drvTbl_QBDEPENDENTPLANINSERT];
GO
IF OBJECT_ID('U_EQPSABCOQB_drvTbl_QBDEPENDENTINSERT') IS NOT NULL DROP TABLE [dbo].[U_EQPSABCOQB_drvTbl_QBDEPENDENTINSERT];
GO
IF OBJECT_ID('U_EQPSABCOQB_DedList') IS NOT NULL DROP TABLE [dbo].[U_EQPSABCOQB_DedList];
GO
IF OBJECT_ID('U_EQPSABCOQB_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EQPSABCOQB_AuditFields];
GO
IF OBJECT_ID('U_EQPSABCOQB_Audit') IS NOT NULL DROP TABLE [dbo].[U_EQPSABCOQB_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EQPSABCOQB') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EQPSABCOQB];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EQPSABCOQB','Associated Bank COBRA QB','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','3000','S','N','EQPSABCOQBZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EQPSABCOQBZ0','50','H','01','1',NULL,'RecordType',NULL,NULL,'"[VERSION]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EQPSABCOQBZ0','50','H','01','2',NULL,'Version',NULL,NULL,'"2.0"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EQPSABCOQBZ0','50','D','10','1',NULL,'RecordType',NULL,NULL,'"[QBINSERT] "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EQPSABCOQBZ0','50','D','10','2',NULL,'ClientName',NULL,NULL,'"drvClientName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EQPSABCOQBZ0','50','D','10','3',NULL,'ClientDivisionName',NULL,NULL,'"drvClientDivisionName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EQPSABCOQBZ0','50','D','10','4',NULL,'Salutation',NULL,NULL,'"drvSalutation"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EQPSABCOQBZ0','50','D','10','5',NULL,'FirstName',NULL,NULL,'"drvFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EQPSABCOQBZ0','50','D','10','6',NULL,'MiddleInitial',NULL,NULL,'"drvMiddleInitial"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EQPSABCOQBZ0','50','D','10','7',NULL,'LastName',NULL,NULL,'"drvLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EQPSABCOQBZ0','50','D','10','8',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EQPSABCOQBZ0','50','D','10','9',NULL,'MemberIdentifier',NULL,NULL,'"drvMemberID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EQPSABCOQBZ0','50','D','10','10',NULL,'Email',NULL,NULL,'"drvEmail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EQPSABCOQBZ0','50','D','10','11',NULL,'Phone',NULL,NULL,'"drvPhone"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EQPSABCOQBZ0','50','D','10','12',NULL,'Phone2',NULL,NULL,'"drvPhone2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EQPSABCOQBZ0','50','D','10','13',NULL,'Address1',NULL,NULL,'"drvAddress1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EQPSABCOQBZ0','50','D','10','14',NULL,'Address2',NULL,NULL,'"drvAddress2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EQPSABCOQBZ0','50','D','10','15',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EQPSABCOQBZ0','50','D','10','16',NULL,'StateorProvince',NULL,NULL,'"drvStateorProvince"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EQPSABCOQBZ0','50','D','10','17',NULL,'PostalCode',NULL,NULL,'"drvPostalCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EQPSABCOQBZ0','50','D','10','18',NULL,'Country',NULL,NULL,'"drvCountry"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EQPSABCOQBZ0','50','D','10','19',NULL,'Sex',NULL,NULL,'"drvSex"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EQPSABCOQBZ0','50','D','10','20',NULL,'DOB',NULL,NULL,'"drvDOB"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EQPSABCOQBZ0','50','D','10','21',NULL,'TobaccoUse',NULL,NULL,'"drvTobaccoUse"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EQPSABCOQBZ0','50','D','10','22',NULL,'EmployeeType',NULL,NULL,'"drvEmployeeType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EQPSABCOQBZ0','50','D','10','23',NULL,'EmployeePayrollType',NULL,NULL,'"drvEmployeePayrollType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EQPSABCOQBZ0','50','D','10','24',NULL,'PremiumCouponType',NULL,NULL,'"drvPremiumCouponType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EQPSABCOQBZ0','50','D','10','25',NULL,'Active',NULL,NULL,'"drvActive"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EQPSABCOQBZ0','50','D','10','26',NULL,'EventType',NULL,NULL,'"drvEventType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EQPSABCOQBZ0','50','D','10','27',NULL,'QualifyingEventDate',NULL,NULL,'"drvQualifyingEventDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EQPSABCOQBZ0','50','D','10','28',NULL,'EnrollmentDate',NULL,NULL,'"drvEnrollmentDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EQPSABCOQBZ0','50','D','10','29',NULL,'IsLegacy',NULL,NULL,'"drvIsLegacy"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EQPSABCOQBZ0','50','D','10','30',NULL,'SecondEventOriginalFDOC',NULL,NULL,'"drvSecEventOrigFDOC"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EQPSABCOQBZ0','50','D','10','31',NULL,'SpecificRightsNotificationPrintedDate',NULL,NULL,'"drvSpecRightsNotePrintDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EQPSABCOQBZ0','50','D','10','32',NULL,'PostmarkDateofElection',NULL,NULL,'"drvPostmarkDateofElection"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EQPSABCOQBZ0','50','D','10','33',NULL,'IsPaidThroughLastDayofCOBRA',NULL,NULL,'"drvIsPaidThroLastDayofCOBRA"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EQPSABCOQBZ0','50','D','10','34',NULL,'NextPremiumOwedMonth',NULL,NULL,'"drvNextPremiumOwedMonth"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EQPSABCOQBZ0','50','D','10','35',NULL,'NextPremiumOwedYear',NULL,NULL,'"drvNextPremiumOwedYear"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EQPSABCOQBZ0','50','D','10','36',NULL,'IsDisabilityApproved',NULL,NULL,'"drvIsDisabilityApproved"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EQPSABCOQBZ0','50','D','10','37',NULL,'DisabilityExtensionPostmarkDate',NULL,NULL,'"drvDisabilityPostMarkDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EQPSABCOQBZ0','50','D','10','38',NULL,'DisabilityExtensionDIsabledDate',NULL,NULL,'"drvDisabilityExtensionDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EQPSABCOQBZ0','50','D','10','39',NULL,'EmployeeName',NULL,NULL,'"drvEmployeeName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EQPSABCOQBZ0','50','D','10','40',NULL,'EmployeeSSN',NULL,NULL,'"drvEmployeeSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EQPSABCOQBZ0','50','D','10','41',NULL,'IsSecondEvent',NULL,NULL,'"drvIsSecondEvent"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EQPSABCOQBZ0','50','D','10','42',NULL,'SendTakeoverLetter',NULL,NULL,'"drvSendTakeoverLetter"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EQPSABCOQBZ0','50','D','10','43',NULL,'IsConversionLetterSent',NULL,NULL,'"drvIsConversionLetterSent"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EQPSABCOQBZ0','50','D','20','1',NULL,'RecordType',NULL,NULL,'"[QBPLANINSERT] "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EQPSABCOQBZ0','50','D','20','2',NULL,'ClientName',NULL,NULL,'"drvClientName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EQPSABCOQBZ0','50','D','20','3',NULL,'oSSN',NULL,NULL,'"drvoSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EQPSABCOQBZ0','50','D','20','4',NULL,'oQualifyingEventDate',NULL,NULL,'"drvoQualifyingEventDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EQPSABCOQBZ0','50','D','20','5',NULL,'PlanName',NULL,NULL,'"drvPlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EQPSABCOQBZ0','51','D','20','6',NULL,'StartDate',NULL,NULL,'"drvStartDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EQPSABCOQBZ0','52','D','20','7',NULL,'CoverageLevel',NULL,NULL,'"drvCoverageLevel"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EQPSABCOQBZ0','53','D','30','1',NULL,'RecordType',NULL,NULL,'"[QBDEPENDENTINSERT] "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EQPSABCOQBZ0','54','D','30','2',NULL,'ClientName',NULL,NULL,'"drvClientName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EQPSABCOQBZ0','55','D','30','3',NULL,'oSSN',NULL,NULL,'"drvoSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EQPSABCOQBZ0','56','D','30','4',NULL,'oQualifyingEventDate',NULL,NULL,'"drvoQualifyingEventDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EQPSABCOQBZ0','57','D','30','5',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EQPSABCOQBZ0','58','D','30','6',NULL,'DependentRelationship',NULL,NULL,'"dnDependentRelationship"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EQPSABCOQBZ0','59','D','30','7',NULL,'Salutation',NULL,NULL,'"drvSalutation"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EQPSABCOQBZ0','60','D','30','8',NULL,'FirstName',NULL,NULL,'"drvFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EQPSABCOQBZ0','61','D','30','9',NULL,'MiddleInitial',NULL,NULL,'"drvMiddleInitial"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EQPSABCOQBZ0','62','D','30','10',NULL,'LastName',NULL,NULL,'"drvLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EQPSABCOQBZ0','63','D','30','11',NULL,'Email',NULL,NULL,'"drvEmail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EQPSABCOQBZ0','64','D','30','12',NULL,'Phone',NULL,NULL,'"drvPhone"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EQPSABCOQBZ0','65','D','30','13',NULL,'Phone2',NULL,NULL,'"drvPhone2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EQPSABCOQBZ0','66','D','30','14',NULL,'AddressSameAsEntity',NULL,NULL,'"drvAddressSameAsEntity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EQPSABCOQBZ0','67','D','30','15',NULL,'Address1',NULL,NULL,'"drvAddress1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EQPSABCOQBZ0','68','D','30','16',NULL,'Address2',NULL,NULL,'"drvAddress2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EQPSABCOQBZ0','69','D','30','17',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EQPSABCOQBZ0','70','D','30','18',NULL,'StateorProvince',NULL,NULL,'"dnStateorProvince"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EQPSABCOQBZ0','71','D','30','19',NULL,'PostalCode',NULL,NULL,'"drvPostalCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EQPSABCOQBZ0','72','D','30','20',NULL,'Country',NULL,NULL,'"drvCountry"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EQPSABCOQBZ0','73','D','30','21',NULL,'EnrollmentDate',NULL,NULL,'"drvEnrollmentDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EQPSABCOQBZ0','74','D','30','22',NULL,'Sex',NULL,NULL,'"drvSex"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EQPSABCOQBZ0','75','D','30','23',NULL,'DOB',NULL,NULL,'"drvDOB"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EQPSABCOQBZ0','76','D','30','24',NULL,'IsQMCSO',NULL,NULL,'"drvIsQMCSO"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EQPSABCOQBZ0','77','D','30','25',NULL,'StartDate',NULL,NULL,'"drvStartDate"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EQPSABCOQBZ0','78','D','40','1',NULL,'RecordType',NULL,NULL,'"[QBDEPENDENTPLANINSERT] "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EQPSABCOQBZ0','79','D','40','2',NULL,'ClientName',NULL,NULL,'"drvClientName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EQPSABCOQBZ0','80','D','40','3',NULL,'oSSN',NULL,NULL,'"drvoSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EQPSABCOQBZ0','81','D','40','4',NULL,'oQualifyingEventDate',NULL,NULL,'"drvoQualifyingEventDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EQPSABCOQBZ0','82','D','40','5',NULL,'DependentRelationship',NULL,NULL,'"dnDependentRelationship"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EQPSABCOQBZ0','83','D','40','6',NULL,'oDependentFirstName',NULL,NULL,'"drvoDependentFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EQPSABCOQBZ0','84','D','40','7',NULL,'oDependentLastName',NULL,NULL,'"drvoDependentLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EQPSABCOQBZ0','85','D','40','8',NULL,'oDependentSSN',NULL,NULL,'"drvoDependentSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EQPSABCOQBZ0','86','D','40','9',NULL,'PlanName',NULL,NULL,'"drvPlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EQPSABCOQBZ0','87','D','40','10',NULL,'StartDate',NULL,NULL,'"drvStartDate"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EQPSABCOQB_20230222.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Associated Bank COBRA QB','202302219','EMPEXPORT','ONDEM_XOE',NULL,'EQPSABCOQB',NULL,NULL,NULL,'202302219','Feb 21 2023  9:32AM','Feb 21 2023  9:32AM','202301011',NULL,'','','202301011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Associated Bank COBRA QB-Sched','202302219','EMPEXPORT','SCH_EQPSAB',NULL,'EQPSABCOQB',NULL,NULL,NULL,'202302219','Feb 21 2023  9:32AM','Feb 21 2023  9:32AM','202301011',NULL,'','','202301011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Associated Bank COBRA QB-Test','202302219','EMPEXPORT','TEST_XOE',NULL,'EQPSABCOQB',NULL,NULL,NULL,'202302219','Feb 21 2023  9:32AM','Feb 21 2023  9:32AM','202301011',NULL,'','','202301011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EQPSABCOQB','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EQPSABCOQB','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EQPSABCOQB','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EQPSABCOQB','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EQPSABCOQB','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EQPSABCOQB','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EQPSABCOQB','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EQPSABCOQB','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EQPSABCOQB','D10','dbo.U_EQPSABCOQB_drvTbl_QBINSERT',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EQPSABCOQB','D20','dbo.U_EQPSABCOQB_drvTbl_QBPLANINSERT',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EQPSABCOQB','D30','dbo.U_EQPSABCOQB_drvTbl_QBDEPENDENTINSERT',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EQPSABCOQB','D40','dbo.U_EQPSABCOQB_drvTbl_QBDEPENDENTPLANINSERT',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EQPSABCOQB
-----------

IF OBJECT_ID('U_dsi_BDM_EQPSABCOQB') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EQPSABCOQB] (
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
-- Create table U_EQPSABCOQB_Audit
-----------

IF OBJECT_ID('U_EQPSABCOQB_Audit') IS NULL
CREATE TABLE [dbo].[U_EQPSABCOQB_Audit] (
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
-- Create table U_EQPSABCOQB_AuditFields
-----------

IF OBJECT_ID('U_EQPSABCOQB_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EQPSABCOQB_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EQPSABCOQB_DedList
-----------

IF OBJECT_ID('U_EQPSABCOQB_DedList') IS NULL
CREATE TABLE [dbo].[U_EQPSABCOQB_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EQPSABCOQB_drvTbl_QBDEPENDENTINSERT
-----------

IF OBJECT_ID('U_EQPSABCOQB_drvTbl_QBDEPENDENTINSERT') IS NULL
CREATE TABLE [dbo].[U_EQPSABCOQB_drvTbl_QBDEPENDENTINSERT] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(26) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvClientName] varchar(24) NOT NULL,
    [drvoSSN] char(11) NULL,
    [drvoQualifyingEventDate] varchar(30) NULL,
    [drvSSN] char(11) NULL,
    [dnDependentRelationship] varchar(15) NULL,
    [drvSalutation] varchar(1) NOT NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleInitial] varchar(1) NULL,
    [drvLastName] varchar(100) NULL,
    [drvEmail] varchar(1) NOT NULL,
    [drvPhone] varchar(50) NULL,
    [drvPhone2] varchar(1) NOT NULL,
    [drvAddressSameAsEntity] varchar(1) NOT NULL,
    [drvAddress1] varchar(255) NULL,
    [drvAddress2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [dnStateorProvince] varchar(255) NULL,
    [drvPostalCode] varchar(50) NULL,
    [drvCountry] varchar(1) NOT NULL,
    [drvEnrollmentDate] varchar(30) NULL,
    [drvSex] char(1) NULL,
    [drvDOB] varchar(30) NULL,
    [drvIsQMCSO] varchar(30) NULL,
    [drvStartDate] varchar(1) NOT NULL
);

-----------
-- Create table U_EQPSABCOQB_drvTbl_QBDEPENDENTPLANINSERT
-----------

IF OBJECT_ID('U_EQPSABCOQB_drvTbl_QBDEPENDENTPLANINSERT') IS NULL
CREATE TABLE [dbo].[U_EQPSABCOQB_drvTbl_QBDEPENDENTPLANINSERT] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(26) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvClientName] varchar(24) NOT NULL,
    [drvoSSN] char(11) NULL,
    [drvoQualifyingEventDate] varchar(30) NULL,
    [dnDependentRelationship] varchar(15) NULL,
    [drvoDependentFirstName] varchar(100) NULL,
    [drvoDependentLastName] varchar(100) NULL,
    [drvoDependentSSN] char(11) NULL,
    [drvPlanName] varchar(21) NULL,
    [drvStartDate] varchar(30) NULL
);

-----------
-- Create table U_EQPSABCOQB_drvTbl_QBINSERT
-----------

IF OBJECT_ID('U_EQPSABCOQB_drvTbl_QBINSERT') IS NULL
CREATE TABLE [dbo].[U_EQPSABCOQB_drvTbl_QBINSERT] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(14) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvClientName] varchar(25) NOT NULL,
    [drvClientDivisionName] varchar(25) NOT NULL,
    [drvSalutation] varchar(1) NOT NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleInitial] varchar(1) NULL,
    [drvLastName] varchar(100) NULL,
    [drvSSN] char(11) NULL,
    [drvMemberID] char(9) NULL,
    [drvEmail] varchar(1) NOT NULL,
    [drvPhone] varchar(1) NOT NULL,
    [drvPhone2] varchar(1) NOT NULL,
    [drvAddress1] varchar(255) NULL,
    [drvAddress2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvStateorProvince] varchar(255) NULL,
    [drvPostalCode] varchar(50) NULL,
    [drvCountry] varchar(1) NOT NULL,
    [drvSex] varchar(100) NULL,
    [drvDOB] varchar(30) NULL,
    [drvTobaccoUse] varchar(7) NOT NULL,
    [drvEmployeeType] varchar(3) NOT NULL,
    [drvEmployeePayrollType] varchar(9) NOT NULL,
    [drvPremiumCouponType] varchar(10) NOT NULL,
    [drvActive] varchar(1) NOT NULL,
    [drvEventType] varchar(29) NULL,
    [drvQualifyingEventDate] varchar(30) NULL,
    [drvEnrollmentDate] varchar(30) NULL,
    [drvIsLegacy] varchar(1) NOT NULL,
    [drvSecEventOrigFDOC] varchar(1) NOT NULL,
    [drvSpecRightsNotePrintDate] varchar(1) NOT NULL,
    [drvPostmarkDateofElection] varchar(1) NOT NULL,
    [drvIsPaidThroLastDayofCOBRA] varchar(1) NOT NULL,
    [drvNextPremiumOwedMonth] varchar(1) NOT NULL,
    [drvNextPremiumOwedYear] varchar(1) NOT NULL,
    [drvIsDisabilityApproved] varchar(1) NOT NULL,
    [drvDisabilityPostMarkDate] varchar(1) NOT NULL,
    [drvDisabilityExtensionDate] varchar(1) NOT NULL,
    [drvEmployeeName] varchar(201) NULL,
    [drvEmployeeSSN] char(11) NULL,
    [drvIsSecondEvent] varchar(1) NOT NULL,
    [drvSendTakeoverLetter] varchar(1) NOT NULL,
    [drvIsConversionLetterSent] varchar(1) NOT NULL
);

-----------
-- Create table U_EQPSABCOQB_drvTbl_QBPLANINSERT
-----------

IF OBJECT_ID('U_EQPSABCOQB_drvTbl_QBPLANINSERT') IS NULL
CREATE TABLE [dbo].[U_EQPSABCOQB_drvTbl_QBPLANINSERT] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(14) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvClientName] varchar(24) NOT NULL,
    [drvoSSN] char(11) NULL,
    [drvoQualifyingEventDate] varchar(30) NULL,
    [drvPlanName] varchar(21) NULL,
    [drvStartDate] varchar(30) NULL,
    [drvCoverageLevel] varchar(11) NULL
);

-----------
-- Create table U_EQPSABCOQB_EEList
-----------

IF OBJECT_ID('U_EQPSABCOQB_EEList') IS NULL
CREATE TABLE [dbo].[U_EQPSABCOQB_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EQPSABCOQB_File
-----------

IF OBJECT_ID('U_EQPSABCOQB_File') IS NULL
CREATE TABLE [dbo].[U_EQPSABCOQB_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EQPSABCOQB]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: QPS Employment

Created By: Marie Waters
Business Analyst: Lea King
Create Date: 02/21/2023
Service Request Number: TekP-2022-10-24-02

Purpose: Associated Bank COBRA QB

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EQPSABCOQB';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EQPSABCOQB';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EQPSABCOQB';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EQPSABCOQB';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EQPSABCOQB' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EQPSABCOQB', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EQPSABCOQB', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EQPSABCOQB', 'SCH_EQPSAB';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EQPSABCOQB';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EQPSABCOQB', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EQPSABCOQB';

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
    DELETE FROM dbo.U_EQPSABCOQB_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EQPSABCOQB_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EQPSABCOQB_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EQPSABCOQB_AuditFields;
    CREATE TABLE dbo.U_EQPSABCOQB_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EQPSABCOQB_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EQPSABCOQB_Audit;
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
    INTO dbo.U_EQPSABCOQB_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EQPSABCOQB_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EQPSABCOQB_Audit ON dbo.U_EQPSABCOQB_Audit (audEEID,audKey2);

    ----================
    ---- Changes Only
    ----================
    --DELETE FROM dbo.U_EQPSABCOQB_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EQPSABCOQB_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'DENB,DENBX,DENH,DENHX,HEAL,HEAL2,HEALS,HEAS2,HEASX,PTDNB,PTDNH,PTHS2,PTHT2,PTHTH,PTHTS,VIS,VISX';

    IF OBJECT_ID('U_EQPSABCOQB_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EQPSABCOQB_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EQPSABCOQB_DedList
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

    -- COBRA parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RunID','QB');
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'AddToPreviousRun','Y');  - only used for NPM/QB combined files
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','Y'); -- DedIsCobraCovered = 'Y'
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraType','4'); -- Eep/ConCobraReason first, then EdhChangeReason. Include CHGRP for elig. ben groups – 
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraDate','3'); -- EedBenStopDate and DbnBenStopDate, unless Eep/ConDateOfCOBRAEvent exists – 
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraPQBType','1'); -- If no EE or spouse, ALL children are PQB (not just oldest) – include this line if deps are sent as QB and not the employee.  
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraReasonsDepPQB','201,204,210,LEVNT3,LEVNT4'); -- Add valid dependent edhchangereasons
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidCobraReasonsEmp','201,204,210,LEVNT3,LEVNT4'); -- Invalidate employee when Cobra Reason is a dependent PQB reason – Add valid dependent edhchangereasons (should be same as previous line above)


    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidTermReasonsEmp','203'); -- Invalidate employee when Cobra Reason is "Death".  Add the Death employment term reason (eectermreason)
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'ConCobraReasonPCF','DependentCOBRAReason'); -- Valid dependent PQB reasons – used when clients have Platform Configurable fields.  Add any other field names the client is using.
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CountDependents','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS'); -- update to the spouse relationship code
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild', 'CHL,DPC,STC,DCH,LEG'); -- update to the child relationship codes
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP'); -- update to the domestic partner relationship code


    ---- Required OE parameters
    --IF @ExportCode LIKE '%PASSIVE'
    --BEGIN
    --    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'OEType','PASSIVE');
    --END;

    --IF @ExportCode LIKE '%ACTIVE'
    --BEGIN
    --    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'OEType','ACTIVE');
    --END;


    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;
    
    --====================================================
 --   -- Insert into BDM Reason code 200/203/DEA (Death)
 --            SPS or 1st child is EMP
 --=====================================================
        
        INSERT INTO [dbo].[U_dsi_BDM_EQPSABCOQB]
        (    [BdmRecType]
           ,[BdmCOID]
           ,[BdmEEID]
           ,[BdmDepRecID]
           ,[BdmSystemID]
           ,[BdmRunID]
           ,[BdmDedRowStatus]
           ,[BdmRelationship]
           ,[BdmDateOfBirth]
           ,[BdmDedCode]
           ,[BdmBenOption]
           ,[BdmBenStatus]
           ,[BdmBenStartDate]
           ,[BdmBenStopDate]
           ,[BdmBenStatusDate]
           ,[BdmDateOFCobraEvent]
           ,[BdmChangeReason]
           ,[BdmCobraReason]
           ,[BdmStartDate]
           ,[BdmStopDate]
           ,[BdmIsPQB]
           ,[BdmIsCobraCovered]
           ,[BdmSessionID]
        )
        Select Distinct 
            rectype =  'DEP' 
            ,EdhCoid
            ,EdhEEID
            ,consystemID
            ,consystemID
            ,'QB'
            ,'Data Inserted for 200/203 (Death)'
            ,ConRelationship
            ,ConDateOfBirth
            ,EdhDedCode
            ,EdhBenOption
            ,EdhBenStatus
            ,dbnbenstartdate
            ,dbnbenstopdate
            ,dbnBenStatusDate
            ,EecDateofTermination
            ,''
            ,dbncobrareason 
            ,dbnbenstartdate
            ,dbnbenstopdate
            ,'Y'
            ,'Y'
            ,'Y'
         
            FROM dbo.emphded WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
        ON dbneeid = edheeid
        AND DbnCoID = EdhCoID
        AND EdhDedCode = DbnDedCode
        AND EdhBenOption = DbnBenOption
        AND dbnformatcode = 'EQPSABCOQB'
       JOIN EmpComp WITH (NOLOCK)
        ON dbnEEID = EecEEID
         JOIN dbo.contacts WITH (NOLOCK)
            ON ConEEID = edheeid 
     Where  dbncobrareason = '210'
        AND EecTermReason in ('203', '200')
        AND edhbenstatus = 'A'
        and edhbenoption <> 'EE'
        and EecEEType <> 'EE'
   
        Order by dbo.EmpHDed.EdhEEID, dbo.EmpHDed.EdhDedCode, dbo.contacts.ConRelationship desc

 ---=======================================================================
 --  Insert into BDM Reason code 204 / LEVNT4 (Divorce/Separation) 
 ----======================================================================

    INSERT INTO [dbo].[U_dsi_BDM_EQPSABCOQB]
           ([BdmRecType]
           ,[BdmCOID]
           ,[BdmEEID]
           ,[BdmDepRecID]
           ,[BdmSystemID]
           ,[BdmRunID]
           ,[BdmDedRowStatus]
           ,[BdmRelationship]
           ,[BdmDateOfBirth]
           ,[BdmDedCode]
           ,[BdmBenOption]
           ,[BdmBenStatus]
           ,[BdmBenStartDate]
           ,[BdmBenStopDate]
           ,[BdmBenStatusDate]
           ,[BdmDateOFCobraEvent]
           ,[BdmChangeReason]
           ,[BdmCobraReason]
           ,[BdmStartDate]
           ,[BdmStopDate]
           ,[BdmIsPQB]
           ,[BdmIsCobraCovered]
           ,[BdmSessionID]
    )
    SELECT Distinct 
            rectype = CASE WHEN DbnRelationShip = 'SPS' THEN 'EMP' ELSE 'DEP' END
            ,EdhCoid
            ,EdhEEID
            ,DbnDepRecID
            ,DbnDepRecID
            ,'QB'
            ,'Data Inserted for 204/LEVNT4 (Divorce/Separation)'
            ,DbnRelationship
            ,DbnDateOfBirth
            ,EdhDedCode
            ,DbnBenOption
            ,DbnBenStatus
            ,EdhBenStartDate
            ,DbnBenStopDate
            ,EdhBenStatusDate
            ,EdhEffDate
            ,edhChangeReason
            ,edhChangeReason
            ,EdhStartDate
            ,EdhStopDate
            ,CASE WHEN DbnRelationShip = 'SPS' THEN 'Y' ELSE 'N' END
            ,'Y'
            ,ROW_NUMBER() OVER (PARTITION by EdhEEID, EdhCOID, edhChangeReason, EdhDedCode ORDER BY EdhEffDate desc)
        FROM dbo.emphded WITH (NOLOCK)
        JOIN dbo.U_dsi_BDM_DepDeductions 
            ON dbneeid = edheeid 
            AND DbnCoID = EdhCoID
            AND EdhDedCode = DbnDedCode
            AND EdhBenOption = DbnBenOption
            AND dbnformatcode = 'EQPSABCOQB'
            WHERE edhChangeReason in ('204', 'LEVNT4') 
            AND DbnBenStopDate BETWEEN @StartDate AND @EndDate
            AND dbnValidForExport = 'N'
            AND DbnDedCode IN ('DENB', 'DENBX', 'PTDNB','DENH', 'DENHX', 'PTDNH','HEAL', 'HEAL2', 'HEALF', 'HEALS', 'HEAS2', 'HEASX', 'PTHS2', 'PTHT2', 'PTHTH', 'PTHTS','VIS', 'VISX')
            ;
  ---========================================================================
 --   -- Insert into BDM Reason code 201 (Dependent at Max Age) - Only show EE
 -- --======================================================================

    INSERT INTO [dbo].[U_dsi_BDM_EQPSABCOQB]
    (    [BdmRecType]
           ,[BdmCOID]
           ,[BdmEEID]
           ,[BdmDepRecID]
           ,[BdmSystemID]
           ,[BdmRunID]
           ,[BdmDedRowStatus]
           ,[BdmRelationship]
           ,[BdmDateOfBirth]
           ,[BdmDedCode]
           ,[BdmBenOption]
           ,[BdmBenStatus]
           ,[BdmBenStartDate]
           ,[BdmBenStopDate]
           ,[BdmBenStatusDate]
           ,[BdmDateOFCobraEvent]
           ,[BdmChangeReason]
           ,[BdmCobraReason]
           ,[BdmStartDate]
           ,[BdmStopDate]
           ,[BdmIsPQB]
           ,[BdmIsCobraCovered]
           ,[BdmSessionID]
    )
        Select distinct
        'DEP'
        ,EdhCoid
        ,EdhEEID
        ,DbnDepRecID
        ,DbnDepRecID
        ,'QB'
        ,'Data Inserted for 201 (Dep at Max Age Dep/Loss of elig)'
        ,'Emp'
        ,EepDateofBirth
        ,DbnDedCode
        ,DbnBenStatus
        ,DbnBenStatus
        ,EdhBenStartDate
        ,EdhBenStopDate
        ,EdhBenStatusDate
        ,EdhEffDate
        ,edhChangeReason
        ,edhChangeReason
        ,EdhStartDate
        ,EdhStopDate
        ,'Y'
        ,'Y'
         ,ROW_NUMBER() OVER (PARTITION by EdhEEID, EdhCOID, edhChangeReason, EdhDedCode ORDER BY EdhEffDate desc)
    FROM dbo.emphded WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = edheeid 
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
        ON dbneeid = edheeid 
        AND DbnCoID = EdhCoID
        AND EdhDedCode = DbnDedCode
        AND EdhBenOption = DbnBenOption
        AND dbnformatcode = 'EQPSABCOQB'
    WHERE edhChangeReason IN ( '201', 'LEVNT3') 
        and DbnBenstopdate BETWEEN @startdate AND @enddate 
       AND dbnValidForExport = 'N'
       AND DbnBenStatus = 'T'
    AND DbnDedCode IN ('DENB', 'DENBX', 'PTDNB','DENH', 'DENHX', 'PTDNH','HEAL', 'HEAL2', 'HEALF', 'HEALS', 'HEAS2', 'HEASX', 'PTHS2', 'PTHT2', 'PTHTH', 'PTHTS','VIS', 'VISX')
    ;


     DELETE FROM dbo.U_dsi_BDM_EQPSABCOQB where bdmdedcode not in (Select dedcode from U_EQPSABCOQB_DedList)



    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EQPSABCOQB_drvTbl_QBINSERT
    ---------------------------------
    IF OBJECT_ID('U_EQPSABCOQB_drvTbl_QBINSERT','U') IS NOT NULL
        DROP TABLE dbo.U_EQPSABCOQB_drvTbl_QBINSERT;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = '1' + xEEID + '1'
        ,drvSubSort = '1'
        -- standard fields above and additional driver fields below
        ,drvClientName = 'QPS Employment Group Inc '
        ,drvClientDivisionName = 'QPS Employment Group Inc '
        ,drvSalutation = ''
        ,drvFirstName = CASE WHEN BdmChangeReason IN ( '201', 'LEVNT3', '204', 'LEVNT4', '210') THEN ConNameFirst else  EepNameFirst END
        ,drvMiddleInitial = CASE WHEN BdmChangeReason IN ( '201', 'LEVNT3', '204', 'LEVNT4', '210') THEN LEFT(ConNameMiddle,1) else  LEFT(EepNameMiddle,1) END
        ,drvLastName = CASE WHEN BdmChangeReason IN ( '201', 'LEVNT3', '204', 'LEVNT4', '210') THEN ConNameLast else  EepNameLast END
        ,drvSSN = eepSSN
        ,drvMemberID = eecempno
        ,drvEmail = ''
        ,drvPhone = ''
        ,drvPhone2 = ''
        ,drvAddress1 = EepAddressLine1
        ,drvAddress2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,drvStateorProvince = EepAddressState
        ,drvPostalCode = EepAddressZipCode
        ,drvCountry = ''
        ,drvSex = CASE WHEN BdmChangeReason IN ( '201', 'LEVNT3', '204', 'LEVNT4', '210') THEN ConNameFirst else  EepNameFirst END
        ,drvDOB = CASE WHEN BdmChangeReason IN ( '201', 'LEVNT3', '204', 'LEVNT4', '210') THEN CONVERT(VARCHAR,ConDateOfBirth,101) else  CONVERT(VARCHAR,EepDateOfBirth,101) END 
        ,drvTobaccoUse = CASE WHEN BdmRecType = 'Emp' and EepIsSmoker = 'Y' THEN  'YES'
                              WHEN BdmRecType = 'Emp' and EepIsSmoker = 'N' THEN 'NO' 
                              ELSE 'UNKNOWN' 
                             END
        ,drvEmployeeType = 'FTE'
        ,drvEmployeePayrollType = CASE WHEN EecSalaryOrHourly = 'S' THEN 'EXEMPT' else  'NONEXEMPT' END
        ,drvPremiumCouponType = 'COUPONBOOK'
        ,drvActive = 'T'
        ---Include all where BchIsCOBRAQualifiedEvent = Y
        ,drvEventType = CASE WHEN BdmChangeReason IN ( '204', 'LEVNT4' ) THEN 'DIVORCELEGALSEPARATION' 
                            WHEN EecEmplStatus = 'T' and EecTermReason  = '203' THEN 'DEATH' 
                            WHEN EecEmplStatus = 'T' and EecTermReason = '202' THEN 'RETIREMENT' 
                            WHEN BdmChangeReason = '205' THEN 'MEDICARE'
                            WHEN BdmChangeReason IN ( '201', 'LEVNT3' ) THEN 'INELIGIBLEDEPENDENT'
                            WHEN EecEmplStatus = 'T'  and EecTermReason  NOT IN ( '202' , '203') and eectermtype  = 'V' THEN 'TERMINATION' 
                            WHEN BdmChangeReason NOT In ( '107' , '203') THEN  'REDUCTIONINHOURS-STATUSCHANGE' 
                            WHEN EecEmplStatus = 'T' and (EecTermReason = 208 or BdmChangeReason = '209') THEN 'REDUCTIONINFORCE'
                            WHEN EecEmplStatus = 'T' and EecTermReason  NOT IN ( '202' , '203') and eectermtype = 'I' THEN 'INVOLUNTARYTERMINATION'
                        END
        ,drvQualifyingEventDate = CASE WHEN BdmChangeReason IN ( '201', 'LEVNT3', '204', 'LEVNT4', '210') THEN CONVERT(VARCHAR,EdhEffDate, 101) else  CONVERT(VARCHAR,EecDateofTermination, 101) END
        ,drvEnrollmentDate = CONVERT(VARCHAR,BdmBenStartdate, 101)
        ,drvIsLegacy = ''
        ,drvSecEventOrigFDOC = ''
        ,drvSpecRightsNotePrintDate = ''
        ,drvPostmarkDateofElection = ''
        ,drvIsPaidThroLastDayofCOBRA = ''
        ,drvNextPremiumOwedMonth = ''
        ,drvNextPremiumOwedYear = ''
        ,drvIsDisabilityApproved = ''
        ,drvDisabilityPostMarkDate = ''
        ,drvDisabilityExtensionDate = ''
        ,drvEmployeeName = eepnamefirst + ' ' + eepnamelast
        ,drvEmployeeSSN = eepSSN
        ,drvIsSecondEvent = ''
        ,drvSendTakeoverLetter = ''
        ,drvIsConversionLetterSent = ''
    INTO dbo.U_EQPSABCOQB_drvTbl_QBINSERT
    FROM dbo.U_EQPSABCOQB_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EQPSABCOQB WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND bdmRunID = 'QB'
        AND BdmIsPQB ='Y'
    Left JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = bdmEEID
        AND ConSystemID = BdmDepRecID
    LEFT JOIN (
            SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent 
            FROM (
                    SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent, ROW_NUMBER() OVER (PARTITION by EdhEEID, EdhCOID ORDER BY EdhEffDate desc) AS RN
                    FROM dbo.EmpHDed a WITH (NOLOCK)
                    JOIN dbo.BenChRsn WITH (NOLOCK)
                        ON EdhChangeReason = BchCode
                    WHERE EdhDedCode IN ('DENB', 'DENBX', 'PTDNB','DENH', 'DENHX', 'PTDNH','HEAL', 'HEAL2', 'HEALF', 'HEALS', 'HEAS2', 'HEASX', 'PTHS2', 'PTHT2', 'PTHTH', 'PTHTS','VIS', 'VISX')
                        AND edhChangeReason IN ( '201', 'LEVNT3', '204', 'LEVNT4', '210')
                ) AS X
            WHERE RN = 1) AS Edh
        ON EdhEEID = xEEID
        AND EdhCoID = xCOID 
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EQPSABCOQB_drvTbl_QBPLANINSERT
    ---------------------------------
    IF OBJECT_ID('U_EQPSABCOQB_drvTbl_QBPLANINSERT','U') IS NOT NULL
        DROP TABLE dbo.U_EQPSABCOQB_drvTbl_QBPLANINSERT;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = '1' + xEEID + '2'
        ,drvSubSort = '2'
        -- standard fields above and additional driver fields below
        ,drvClientName = 'QPS Employment Group Inc'
        ,drvoSSN = eepSSN
        ,drvoQualifyingEventDate = CASE WHEN BdmChangeReason IN ( '201', 'LEVNT3', '204', 'LEVNT4', '210') THEN CONVERT(VARCHAR,EdhEffDate, 101) else  CONVERT(VARCHAR,EecDateofTermination, 101) END
        ,drvPlanName = CASE WHEN Bdmdedcode IN ( 'DENB', 'DENBX', 'PTDNB') THEN 'Dental Base Plan'
                            WHEN Bdmdedcode IN ('DENH', 'DENHX', 'PTDNH') THEN 'Dental High Plan'
                            WHEN Bdmdedcode IN ( 'HEAL', 'HEAL2', 'HEALF', 'HEALS', 'HEAS2', 'HEASX', 'PTHS2', 'PTHT2', 'PTHTH', 'PTHTS' ) THEN 'Blue Access PPO $2000'
                            WHEN Bdmdedcode IN ( 'VIS', 'VISX' ) THEN  'Blue View Vision'
                        END
        ,drvStartDate = CONVERT(VARCHAR,DateAdd(d, 1, Bdmbenstopdate),101)
        ,drvCoverageLevel =   CASE WHEN BdmChangeReason IN ( '201', 'LEVNT3', '204', 'LEVNT4', '210') THEN
                                        CASE WHEN BdmRelationship = 'SPS' AND (SELECT COUNT(DISTINCT BdmDepRecId) FROM dbo.U_dsi_BDM_EQPSABCOQB WITH (NOLOCK) WHERE BdmRunId = 'QB' AND BdmEEID = xEEID AND BdmRecType = 'DEP' AND BdmRelationship IN ('CHL','DPC','STC','DCH','LEG')) = 1 THEN 'EE+CHILD'
                                             WHEN BdmRelationship = 'SPS' AND (SELECT COUNT(DISTINCT BdmDepRecId) FROM dbo.U_dsi_BDM_EQPSABCOQB WITH (NOLOCK) WHERE BdmRunId = 'QB' AND BdmEEID = xEEID AND BdmRecType = 'DEP' AND BdmRelationship IN ('CHL','DPC','STC','DCH','LEG')) > 1  THEN 'EE+CHILDREN'
                                             WHEN BdmRelationship <> 'SPS' AND (SELECT COUNT(DISTINCT BdmDepRecId) FROM dbo.U_dsi_BDM_EQPSABCOQB WITH (NOLOCK) WHERE BdmRunId = 'QB' AND BdmEEID = xEEID AND BdmRecType = 'DEP' AND BdmRelationship IN ('CHL','DPC','STC','DCH','LEG')) > 1 THEN 'EE+CHILDREN'
                                         ELSE 'EE'
                                         END
                                        
                                     WHEN BdmChangeReason NOT IN ( '201', 'LEVNT3', '204', 'LEVNT4', '210') THEN
                                      CASE WHEN BdmBenOption = 'EE' THEN 'EE' 
                                           WHEN BdmBenOption IN ('EEC') THEN 'EE+CHILDREN'
                                           WHEN BdmBenOption IN ('EEF', 'EEDPF') THEN 'EE+FAMILY'
                                           WHEN BdmBenOption IN ('EES', 'EEDP') THEN 'EE+SPOUSE'
                                         ELSE 'EE'
                                        END
                                    END

    INTO dbo.U_EQPSABCOQB_drvTbl_QBPLANINSERT
    FROM dbo.U_EQPSABCOQB_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
       ON EepEEID = xEEID
     JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.U_dsi_BDM_EQPSABCOQB WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND bdmRunID = 'QB'
        AND BdmIsPQB ='Y'
    --JOIN dbo.Contacts WITH (NOLOCK)
 --       ON ConEEID = bdmEEID
 --       AND ConSystemID = BdmDepRecID
    LEFT JOIN (
            SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent 
            FROM (
                    SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent, ROW_NUMBER() OVER (PARTITION by EdhEEID, EdhCOID ORDER BY EdhEffDate desc) AS RN
                    FROM dbo.EmpHDed a WITH (NOLOCK)
                    JOIN dbo.BenChRsn WITH (NOLOCK)
                        ON EdhChangeReason = BchCode
                    WHERE EdhDedCode IN ('DENB', 'DENBX', 'PTDNB','DENH', 'DENHX', 'PTDNH','HEAL', 'HEAL2', 'HEALF', 'HEALS', 'HEAS2', 'HEASX', 'PTHS2', 'PTHT2', 'PTHTH', 'PTHTS','VIS', 'VISX')
                        AND edhChangeReason IN ( '201', 'LEVNT3', '204', 'LEVNT4', '210')
                ) AS X
            WHERE RN = 1) AS Edh
        ON EdhEEID = xEEID
        AND EdhCoID = xCOID 
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EQPSABCOQB_drvTbl_QBDEPENDENTINSERT
    ---------------------------------
    IF OBJECT_ID('U_EQPSABCOQB_drvTbl_QBDEPENDENTINSERT','U') IS NOT NULL
        DROP TABLE dbo.U_EQPSABCOQB_drvTbl_QBDEPENDENTINSERT;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = '1' + xEEID +  BdmDepRecID + CASE WHEN conrelationship IN ( 'CHL','DPC','STC', 'DCH' , 'LEG') then'2' else '1' END   

        ,drvSubSort = '3'
        -- standard fields above and additional driver fields below
        ,drvClientName = 'QPS Employment Group Inc'
        ,drvoSSN = eepSSN
        ,drvoQualifyingEventDate = CASE WHEN BdmChangeReason IN ( '201', 'LEVNT3', '204', 'LEVNT4', '210') THEN CONVERT(VARCHAR,EdhEffDate, 101) else  CONVERT(VARCHAR,EecDateofTermination, 101) END
        ,drvSSN = ConSSN
        ,dnDependentRelationship = CASE WHEN conrelationship IN ( 'CHL','DPC','STC', 'DCH' , 'LEG') then 'CHILD'
                                        WHEN  conrelationship = 'SPS' then 'SPOUSE'
                                        WHEN conrelationship = 'DP' then 'DOMESTICPARTNER'
                                    END
        ,drvSalutation = ''
        ,drvFirstName = ConNameFirst
        ,drvMiddleInitial = LEFT(ConNameMiddle,1)
        ,drvLastName = ConNameLast
        ,drvEmail = ''
        ,drvPhone = eepphonehomenumber
        ,drvPhone2 = ''
        ,drvAddressSameAsEntity = 'T'
        ,drvAddress1 = EepAddressLine1
        ,drvAddress2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,dnStateorProvince = EepAddressState
        ,drvPostalCode = EepAddressZipCode
        ,drvCountry = ''
        ,drvEnrollmentDate = CONVERT(VARCHAR,BdmBenStartDate,101)
        ,drvSex = ConGender
        ,drvDOB = CONVERT(VARCHAR,ConDateOfBirth,101)
        ,drvIsQMCSO = CONVERT(VARCHAR,DateAdd(d, 1, Bdmbenstopdate),101)
        ,drvStartDate = ''
    INTO dbo.U_EQPSABCOQB_drvTbl_QBDEPENDENTINSERT
    FROM dbo.U_EQPSABCOQB_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EQPSABCOQB WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND bdmRunID = 'QB'
        AND BdmIsPQB ='N'
        AND BdmRecType = 'DEP'
    JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = bdmEEID
        AND ConSystemID = BdmDepRecID
      LEFT JOIN (
            SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent 
            FROM (
                    SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent, ROW_NUMBER() OVER (PARTITION by EdhEEID, EdhCOID ORDER BY EdhEffDate desc) AS RN
                    FROM dbo.EmpHDed a WITH (NOLOCK)
                    JOIN dbo.BenChRsn WITH (NOLOCK)
                        ON EdhChangeReason = BchCode
                    WHERE EdhDedCode IN ('DENB', 'DENBX', 'PTDNB','DENH', 'DENHX', 'PTDNH','HEAL', 'HEAL2', 'HEALF', 'HEALS', 'HEAS2', 'HEASX', 'PTHS2', 'PTHT2', 'PTHTH', 'PTHTS','VIS', 'VISX')
                        AND edhChangeReason IN ( '201', 'LEVNT3', '204', 'LEVNT4', '210')
                ) AS X
            WHERE RN = 1) AS Edh
        ON EdhEEID = xEEID
        AND EdhCoID = xCOID 
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EQPSABCOQB_drvTbl_QBDEPENDENTPLANINSERT 
    ---------------------------------
    IF OBJECT_ID('U_EQPSABCOQB_drvTbl_QBDEPENDENTPLANINSERT ','U') IS NOT NULL
        DROP TABLE dbo.U_EQPSABCOQB_drvTbl_QBDEPENDENTPLANINSERT ;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort =   '1' + xEEID + BdmDepRecID + CASE WHEN conrelationship IN ( 'CHL','DPC','STC', 'DCH' , 'LEG') then'2' else '1' END  
        ,drvSubSort = '4'
        -- standard fields above and additional driver fields below
        ,drvClientName = 'QPS Employment Group Inc'
        ,drvoSSN = eepSSN
        ,drvoQualifyingEventDate = CASE WHEN BdmChangeReason IN ( '201', 'LEVNT3', '204', 'LEVNT4', '210') THEN CONVERT(VARCHAR,EdhEffDate, 101) else  CONVERT(VARCHAR,EecDateofTermination, 101) END
        ,dnDependentRelationship = CASE WHEN conrelationship IN ( 'CHL','DPC','STC', 'DCH' , 'LEG') then 'CHILD'
                                        WHEN conrelationship = 'SPS' then 'SPOUSE'
                                        WHEN conrelationship = 'DP' then 'DOMESTICPARTNER'
                                    END
        ,drvoDependentFirstName = ConNameFirst
        ,drvoDependentLastName = ConNameLast
        ,drvoDependentSSN = ConSSN
        ,drvPlanName = CASE WHEN Bdmdedcode IN ( 'DENB', 'DENBX', 'PTDNB') THEN 'Dental Base Plan'
                            WHEN Bdmdedcode IN ('DENH', 'DENHX', 'PTDNH') THEN 'Dental High Plan'
                            WHEN Bdmdedcode IN ( 'HEAL', 'HEAL2', 'HEALF', 'HEALS', 'HEAS2', 'HEASX', 'PTHS2', 'PTHT2', 'PTHTH', 'PTHTS' ) THEN 'Blue Access PPO $2000'
                            WHEN Bdmdedcode IN ( 'VIS', 'VISX' ) THEN  'Blue View Vision'
                        END
        ,drvStartDate = CONVERT(VARCHAR,DateAdd(d, 1, Bdmbenstopdate),101)
    INTO dbo.U_EQPSABCOQB_drvTbl_QBDEPENDENTPLANINSERT 
    FROM dbo.U_EQPSABCOQB_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EQPSABCOQB WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND bdmRunID = 'QB'
        AND BdmIsPQB ='N'
        AND BdmRecType = 'DEP'
    JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = bdmEEID
        AND ConSystemID = BdmDepRecID
     LEFT JOIN (
            SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent 
            FROM (
                    SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent, ROW_NUMBER() OVER (PARTITION by EdhEEID, EdhCOID ORDER BY EdhEffDate desc) AS RN
                    FROM dbo.EmpHDed a WITH (NOLOCK)
                    JOIN dbo.BenChRsn WITH (NOLOCK)
                        ON EdhChangeReason = BchCode
                    WHERE EdhDedCode IN ('DENB', 'DENBX', 'PTDNB','DENH', 'DENHX', 'PTDNH','HEAL', 'HEAL2', 'HEALF', 'HEALS', 'HEAS2', 'HEASX', 'PTHS2', 'PTHT2', 'PTHTH', 'PTHTS','VIS', 'VISX')
                        AND edhChangeReason IN ( '201', 'LEVNT3', '204', 'LEVNT4', '210')
                ) AS X
            WHERE RN = 1) AS Edh
        ON EdhEEID = xEEID
        AND EdhCoID = xCOID 
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
ALTER VIEW dbo.dsi_vwEQPSABCOQB_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EQPSABCOQB_File (NOLOCK)
    ORDER BY  InitialSort, SubSort,RIGHT(RecordSet,2);

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EQPSABCOQB%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202301011'
       ,expStartPerControl     = '202301011'
       ,expLastEndPerControl   = '202302219'
       ,expEndPerControl       = '202302219'
WHERE expFormatCode = 'EQPSABCOQB';

**********************************************************************************/
GO
--Alter the View
CREATE VIEW dbo.dsi_vwEQPSABCOQB_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EQPSABCOQB_File (NOLOCK)
    ORDER BY  InitialSort, SubSort,RIGHT(RecordSet,2);

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EQPSABCOQB' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EQPSABCOQB'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EQPSABCOQB'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EQPSABCOQB', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EQPSABCOQB', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EQPSABCOQB', 'UseFileName', 'V', 'Y'


-- End ripout