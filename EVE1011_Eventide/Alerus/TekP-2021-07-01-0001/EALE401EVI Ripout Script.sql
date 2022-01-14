/**********************************************************************************

EALE401EVI: Alerus 401K

FormatCode:     EALE401EVI
Project:        Alerus 401K
Client ID:      EVE1011
Date/time:      2022-01-05 05:26:43.783
Ripout version: 7.4
Export Type:    Web
Status:         Production
Environment:    NWP
Server:         NW1WUP6DB01
Database:       ULTIPRO_WPEVIT
Web Filename:   EVE1011_AU3Q7_EEHISTORY_EALE401EVI_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EALE401EVI_SavePath') IS NOT NULL DROP TABLE dbo.U_EALE401EVI_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EALE401EVI'


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
WHERE FormatCode = 'EALE401EVI'
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
WHERE ExpFormatCode = 'EALE401EVI'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EALE401EVI')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EALE401EVI'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EALE401EVI'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EALE401EVI'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EALE401EVI'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EALE401EVI'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EALE401EVI'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EALE401EVI'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EALE401EVI'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EALE401EVI'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEALE401EVI_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEALE401EVI_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EALE401EVI') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EALE401EVI];
GO
IF OBJECT_ID('U_EALE401EVI_uditFields') IS NOT NULL DROP TABLE [dbo].[U_EALE401EVI_uditFields];
GO
IF OBJECT_ID('U_EALE401EVI_udit') IS NOT NULL DROP TABLE [dbo].[U_EALE401EVI_udit];
GO
IF OBJECT_ID('U_EALE401EVI_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EALE401EVI_PEarHist];
GO
IF OBJECT_ID('U_EALE401EVI_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EALE401EVI_PDedHist];
GO
IF OBJECT_ID('U_EALE401EVI_File') IS NOT NULL DROP TABLE [dbo].[U_EALE401EVI_File];
GO
IF OBJECT_ID('U_EALE401EVI_EEList') IS NOT NULL DROP TABLE [dbo].[U_EALE401EVI_EEList];
GO
IF OBJECT_ID('U_EALE401EVI_drvTrlTbl') IS NOT NULL DROP TABLE [dbo].[U_EALE401EVI_drvTrlTbl];
GO
IF OBJECT_ID('U_EALE401EVI_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EALE401EVI_drvTbl];
GO
IF OBJECT_ID('U_EALE401EVI_DedList') IS NOT NULL DROP TABLE [dbo].[U_EALE401EVI_DedList];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EALE401EVI','Alerus 401K','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','EALE401EVIZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EALE401EVIZ0','50','D','10','1',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EALE401EVIZ0','30','D','10','2',NULL,'Name',NULL,NULL,'"drvName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EALE401EVIZ0','40','D','10','3',NULL,'AddressLine1',NULL,NULL,'"drvAddressLine1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EALE401EVIZ0','40','D','10','4',NULL,'AddressLine2',NULL,NULL,'"drvAddressLine2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EALE401EVIZ0','50','D','10','5',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EALE401EVIZ0','50','D','10','6',NULL,'State',NULL,NULL,'"drvState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EALE401EVIZ0','50','D','10','7',NULL,'Zipcode',NULL,NULL,'"drvZipcode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EALE401EVIZ0','50','D','10','8',NULL,'Division',NULL,NULL,'"drvDivision"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EALE401EVIZ0','50','D','10','9',NULL,'Date of Birth',NULL,NULL,'"drvDateofBirth"','(''UD112''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EALE401EVIZ0','50','D','10','10',NULL,'Date of Original Hire',NULL,NULL,'"drvDateofOriginalHire"','(''UD112''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EALE401EVIZ0','50','D','10','11',NULL,'Eligiblity Date',NULL,NULL,'"drvEligiblityDate"','(''UD112''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EALE401EVIZ0','50','D','10','12',NULL,'Date of Last Hire',NULL,NULL,'"drvDateofLastHire"','(''UD112''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EALE401EVIZ0','50','D','10','13',NULL,'Date of Termination',NULL,NULL,'"drvDateofTermination"','(''UD112''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EALE401EVIZ0','50','D','10','14',NULL,'YTDHours',NULL,NULL,'"drvYTDHours"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EALE401EVIZ0','50','D','10','15',NULL,'YTDGrossComp',NULL,NULL,'"drvYTDGrossComp"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EALE401EVIZ0','50','D','10','16',NULL,'YTDExcludComp',NULL,NULL,'"drvYTDExcludComp"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EALE401EVIZ0','50','D','10','17',NULL,'EE Deferral',NULL,NULL,'"drvEEDeferral"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EALE401EVIZ0','50','D','10','18',NULL,'EE Roth Deferral',NULL,NULL,'"drvEERothDeferral"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EALE401EVIZ0','50','D','10','19',NULL,'ER Match',NULL,NULL,'"drvERMatch"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EALE401EVIZ0','50','D','10','20',NULL,'ER Discretionary',NULL,NULL,'"drvERDiscretionary"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EALE401EVIZ0','50','D','10','21',NULL,'ERAfterTaxDeferral',NULL,NULL,'"drvERAfterTaxDeferral"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EALE401EVIZ0','50','D','10','22',NULL,'Profit Sharing',NULL,NULL,'"drvProfitSharing"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EALE401EVIZ0','50','D','10','23',NULL,'Safe Harbor',NULL,NULL,'"drvSafeHarbor"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EALE401EVIZ0','50','D','10','24',NULL,'Pension',NULL,NULL,'"drvPension"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EALE401EVIZ0','50','D','10','25',NULL,'Loan Payment',NULL,NULL,'"drvLoanPayment"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EALE401EVIZ0','50','D','10','26',NULL,'Payroll Freq',NULL,NULL,'"drvPayrollFreq"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EALE401EVIZ0','50','D','10','27',NULL,NULL,NULL,NULL,'"drvEmpType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EALE401EVIZ0','50','D','10','28',NULL,NULL,NULL,NULL,'"drvSalary"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EALE401EVIZ0','50','D','10','29',NULL,'Email',NULL,NULL,'"drvEmail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EALE401EVIZ0','50','D','10','30',NULL,'Alternate Email',NULL,NULL,'"drvEMailAlternate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EALE401EVIZ0','50','D','10','31',NULL,'Phone',NULL,NULL,'"drvPhone"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EALE401EVIZ0','50','D','20','1',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EALE401EVIZ0','50','D','20','2',NULL,'Name',NULL,NULL,'"drvName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EALE401EVIZ0','50','D','20','3',NULL,'Loan Number',NULL,NULL,'"drvLoanNumber"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EALE401EVIZ0','50','D','20','4',NULL,'Loan Payment Amt',NULL,NULL,'"drvLoanPaymentAmt"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EALE401EVIZ0','50','D','20','5',NULL,'Division',NULL,NULL,'"drvDivision"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EALE401EVIZ0','50','D','20','6',NULL,'Payroll Freq',NULL,NULL,'"drvPayrollFreq"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EALE401EVIZ0','1','T','99','1',NULL,'Filler',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EALE401EVIZ0','12','T','99','2',NULL,'PayDate',NULL,NULL,'"drvPaydate"','(''UD112''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EALE401EVIZ0','10','T','99','3',NULL,'Filler',NULL,NULL,'"CAPI"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EALE401EVIZ0','1','T','99','4',NULL,'Filler',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EALE401EVIZ0','1','T','99','5',NULL,'Filler',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EALE401EVIZ0','1','T','99','6',NULL,'Filler',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EALE401EVIZ0','1','T','99','7',NULL,'Filler',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EALE401EVIZ0','1','T','99','8',NULL,'Filler',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EALE401EVIZ0','1','T','99','9',NULL,'Filler',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EALE401EVIZ0','1','T','99','10',NULL,'Filler',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EALE401EVIZ0','1','T','99','11',NULL,'Filler',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EALE401EVIZ0','1','T','99','12',NULL,'Filler',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EALE401EVIZ0','1','T','99','13',NULL,'Filler',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EALE401EVIZ0','1','T','99','14',NULL,'Filler',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EALE401EVIZ0','1','T','99','15',NULL,'Filler',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EALE401EVIZ0','1','T','99','16',NULL,'Filler',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EALE401EVIZ0','25','T','99','17',NULL,'Filler',NULL,NULL,'"drvEEDeferralTot"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EALE401EVIZ0','25','T','99','18',NULL,'EE Deferral Tot',NULL,NULL,'"drvEERothDeferralTot"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EALE401EVIZ0','25','T','99','19',NULL,'EE Roth Deferral Tot',NULL,NULL,'"drvERMatchTot"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EALE401EVIZ0','25','T','99','20',NULL,'ER Match Tot',NULL,NULL,'"drvERDiscretionaryTot"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EALE401EVIZ0','25','T','99','21',NULL,'ER Discretionary Tot',NULL,NULL,'"drvERAfterTaxDeferralTot"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EALE401EVIZ0','25','T','99','22',NULL,'ERAfterTaxDeferral Tot',NULL,NULL,'"drvProfitSharingTot"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EALE401EVIZ0','25','T','99','23',NULL,'Profit Sharing Tot',NULL,NULL,'"drvSafeHarborTot"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EALE401EVIZ0','25','T','99','24',NULL,'Safe Harbor Tot',NULL,NULL,'"drvPensionTot"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EALE401EVIZ0','25','T','99','25',NULL,'Pension Tot',NULL,NULL,'"drvLoanPaymentTot"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EALE401EVIZ0','25','T','99','26',NULL,'Loan Payment Tot',NULL,NULL,'""','(''SS''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EALE401EVI_20220105.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Alerus 401k','202106309','EMPEXPORT','ONDEMAND','Apr 16 2019 12:00AM','EALE401EVI',NULL,NULL,NULL,'202106309','Apr 16 2019 12:00AM','Dec 30 1899 12:00AM','202106011',NULL,'','','202106011',dbo.fn_GetTimedKey(),NULL,'ULTI_WPRSIEH',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Scheduled Session','202106309','EMPEXPORT','SCHEDULED','Mar 15 2021 10:13AM','EALE401EVI',NULL,NULL,NULL,'202106309','Mar 12 2021 12:00AM','Mar  6 2021 12:00AM','202106011','332','','','202106011',dbo.fn_GetTimedKey(),NULL,'ULTI_WPEVIT',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','D8SIS',NULL,NULL,NULL,'Test Purposes Only','202112311','EMPEXPORT','TEST','Dec 20 2021  2:28PM','EALE401EVI',NULL,NULL,NULL,'202112311','Dec 31 2021 12:00AM','Dec 25 2021 12:00AM','202112011','1167','','','202112011',dbo.fn_GetTimedKey(),NULL,'us3rVaEVE1011',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EALE401EVI','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EALE401EVI','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EALE401EVI','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EALE401EVI','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EALE401EVI','D10','dbo.U_EALE401EVI_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EALE401EVI','D20','dbo.U_EALE401EVI_drvLoanTbl','IGNORE');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EALE401EVI','T99','dbo.U_EALE401EVI_drvTrlTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EALE401EVI_DedList
-----------

IF OBJECT_ID('U_EALE401EVI_DedList') IS NULL
CREATE TABLE [dbo].[U_EALE401EVI_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EALE401EVI_drvTbl
-----------

IF OBJECT_ID('U_EALE401EVI_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EALE401EVI_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSSN] char(11) NULL,
    [drvName] varchar(204) NULL,
    [drvAddressLine1] varchar(6000) NULL,
    [drvAddressLine2] varchar(6000) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZipcode] varchar(50) NULL,
    [drvDivision] char(6) NULL,
    [drvDateofBirth] varchar(30) NULL,
    [drvDateofOriginalHire] varchar(30) NULL,
    [drvEligiblityDate] varchar(1) NOT NULL,
    [drvDateofLastHire] varchar(30) NULL,
    [drvDateofTermination] varchar(30) NULL,
    [drvYTDHours] varchar(30) NULL,
    [drvYTDGrossComp] varchar(30) NULL,
    [drvYTDExcludComp] varchar(30) NULL,
    [drvEEDeferral] varchar(30) NULL,
    [drvEERothDeferral] varchar(30) NULL,
    [drvERMatch] varchar(30) NULL,
    [drvERDiscretionary] varchar(30) NULL,
    [drvERAfterTaxDeferral] numeric NOT NULL,
    [drvProfitSharing] numeric NOT NULL,
    [drvSafeHarbor] numeric NOT NULL,
    [drvPension] numeric NOT NULL,
    [drvLoanPayment] varchar(30) NULL,
    [drvPayrollFreq] varchar(1) NULL,
    [drvEmpType] varchar(1) NULL,
    [drvSalary] money NULL,
    [drvEmail] varchar(50) NULL,
    [drvEMailAlternate] varchar(50) NULL,
    [drvPhone] varchar(50) NULL
);

-----------
-- Create table U_EALE401EVI_drvTrlTbl
-----------

IF OBJECT_ID('U_EALE401EVI_drvTrlTbl') IS NULL
CREATE TABLE [dbo].[U_EALE401EVI_drvTrlTbl] (
    [drvPaydate] datetime NULL,
    [drvEEDeferralTot] money NULL,
    [drvEERothDeferralTot] money NULL,
    [drvERMatchTot] money NULL,
    [drvERDiscretionaryTot] varchar(1) NOT NULL,
    [drvERAfterTaxDeferralTot] numeric NOT NULL,
    [drvProfitSharingTot] numeric NOT NULL,
    [drvSafeHarborTot] numeric NOT NULL,
    [drvPensionTot] numeric NOT NULL,
    [drvLoanPaymentTot] money NULL
);

-----------
-- Create table U_EALE401EVI_EEList
-----------

IF OBJECT_ID('U_EALE401EVI_EEList') IS NULL
CREATE TABLE [dbo].[U_EALE401EVI_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EALE401EVI_File
-----------

IF OBJECT_ID('U_EALE401EVI_File') IS NULL
CREATE TABLE [dbo].[U_EALE401EVI_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);

-----------
-- Create table U_EALE401EVI_PDedHist
-----------

IF OBJECT_ID('U_EALE401EVI_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EALE401EVI_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhSource1] numeric NULL,
    [PdhSource2] numeric NULL,
    [PdhSource3] numeric NULL,
    [PdhSource4] numeric NULL,
    [PdhSource5] numeric NULL
);

-----------
-- Create table U_EALE401EVI_PEarHist
-----------

IF OBJECT_ID('U_EALE401EVI_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EALE401EVI_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PehCurAmt] numeric NULL,
    [PehCurHrs] decimal NULL,
    [PehCurAmtYTD] money NULL,
    [PehCurHrsYTD] decimal NULL,
    [PehInclInDefComp] money NULL,
    [PehInclInDefCompHrs] decimal NULL,
    [PehInclInDefCompYTD] money NULL,
    [PehInclInDefCompHrsYTD] decimal NULL,
    [PehIncl415CompYTD] money NULL,
    [PehIncl415CompHrsYTD] decimal NULL
);

-----------
-- Create table U_EALE401EVI_udit
-----------

IF OBJECT_ID('U_EALE401EVI_udit') IS NULL
CREATE TABLE [dbo].[U_EALE401EVI_udit] (
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audKey1Value] varchar(255) NOT NULL,
    [audKey2Value] varchar(255) NOT NULL,
    [audKey3Value] varchar(255) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] nvarchar(2000) NULL,
    [audNewValue] nvarchar(2000) NULL,
    [audRowNo] bigint NULL
);

-----------
-- Create table U_EALE401EVI_uditFields
-----------

IF OBJECT_ID('U_EALE401EVI_uditFields') IS NULL
CREATE TABLE [dbo].[U_EALE401EVI_uditFields] (
    [aTableName] varchar(128) NULL,
    [aFieldName] varchar(128) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EALE401EVI]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: EVIT

Created By: Hyma Akkiraju
Business Analyst: Stanley Uzoka
Create Date: 1/8/2021
Service Request Number: EVE1011-2020-00293128-Interface File - Launch - Alerus (401K/403b)

Purpose: Alerus 401k

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2019     SR-2019-000XXXXX   XXXXX
Chelsea Bartholomew    06/12/2020       SF18064229          Corrected defect in date of last hire field that would stop it populating accurately for non-terminated employees
Luis Lugo               07/20/2021      TekP-2021-07-01-0001  All employees are included now

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EALE401EVI';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EALE401EVI';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EALE401EVI';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EALE401EVI';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EALE401EVI' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EALE401EVI', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EALE401EVI', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EALE401EVI', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EALE401EVI', 'TEST';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EALE401EVI';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EALE401EVI', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EALE401EVI';

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
    DELETE FROM dbo.U_EALE401EVI_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EALE401EVI_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --DELETING Test EE's
        DELETE EL 
          FROM dbo.U_EALE401EVI_EEList EL
          JOIN empcomp ON xEEID = eecEEID and eecCOID = xCOID
          JOIN emppers ON xEEID = eepEEID
         WHERE eecEEType = 'TES' 
            OR eepNameLast  LIKE '%test%' 
            OR eepNameFirst LIKE '%test%'
            OR eepNameLast  LIKE '%scenario%' 
            OR eepNameFirst LIKE '%scenario%'
            OR eepNameFirst LIKE '%employee%';

-----CmpCompanyCode = 'CAPI'
--    DELETE FROM dbo.U_EALE401EVI_EEList
--    WHERE xCoID <> 'B9VXH'


    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '403BD,403BR,MATCH,LOANS';

    IF OBJECT_ID('U_EALE401EVI_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EALE401EVI_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EALE401EVI_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    
    --Audit Table
    IF OBJECT_ID('U_EALE401EVI_uditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EALE401EVI_uditFields;
    CREATE TABLE dbo.U_EALE401EVI_uditFields (aTableName varchar(128),aFieldName varchar(128));
    
    -- Insert tables/fields to be audited
    INSERT INTO dbo.U_EALE401EVI_uditFields VALUES ('EmpComp','EecEmplStatus');    
    
    -- Create audit table
    IF OBJECT_ID('U_EALE401EVI_udit','U') IS NOT NULL
        DROP TABLE dbo.U_EALE401EVI_udit;
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
    INTO dbo.U_EALE401EVI_udit
    FROM (SELECT *
          FROM dbo.AuditRecords WITH (NOLOCK)
          WHERE adrTableName IN (SELECT aTableName FROM dbo.U_EALE401EVI_uditFields WITH (NOLOCK))) ADR
    JOIN (SELECT *
          FROM dbo.AuditFields WITH (NOLOCK)
          WHERE adfFieldName IN (SELECT aFieldName FROM dbo.U_EALE401EVI_uditFields WITH (NOLOCK))) ADF
        ON adrSystemID = adfSystemID
       AND adrKey = adfKey
    WHERE adrType IN (1,2,5,6) -- Insert/Update; remove this to include Deletes and Viewed
      AND adrProcessedDateTime BETWEEN CAST('01/01/' + CAST(YEAR(GETDATE()) as varchar) as datetime) AND CAST('12/31/' + CAST(YEAR(GETDATE()) as varchar) as datetime);
    
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EALE401EVI_udit ON dbo.U_EALE401EVI_udit (audKey1Value, audKey2Value);

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EALE401EVI_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EALE401EVI_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('403BD') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('403BR') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('MATCH') THEN PdhERCurAmt ELSE 0.00 END)
        ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('X') THEN PdhERCurAmt ELSE 0.00 END)                
        ,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('LOANS') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        --select * FROM dbo.U_EALE401EVI_PDedHist
    INTO dbo.U_EALE401EVI_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EALE401EVI_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) > 0.00
        OR SUM(PdhERCurAmt) > 0.00
    );


    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EALE401EVI_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EALE401EVI_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl AND PehEarnCode IN ('MRPB','BEREA','ESDI','GCALL','H15','JURY','OVS','PTO','PTOSE','REG') THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
        ,PehIncl415CompYTD    = SUM(CASE WHEN PehInclInDefComp <> 'Y' THEN PehCurAmt END)
        ,PehIncl415CompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs <> 'Y' THEN PehCurHrs END)
    INTO dbo.U_EALE401EVI_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) > 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EALE401EVI_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EALE401EVI_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EALE401EVI_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvName = eepNameLast + ', '+eepNameFirst + IIF(ISNULL(eepNameMiddle,'') <> '',' ' + LEFT(eepNameMiddle,1),'')
        ,drvAddressLine1 = UPPER(dbo.dsi_fnRemoveChars(',',EmpPers.EepAddressLine1)) 
        ,drvAddressLine2 = UPPER(dbo.dsi_fnRemoveChars(',',EmpPers.EepAddressLine2))
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZipcode = EepAddressZipCode
        ,drvDivision = Eeclocation
        ,drvDateofBirth =  convert(varchar, EepDateOfBirth, 112) 
        ,drvDateofOriginalHire = convert(varchar, EecDateOfOriginalHire, 112) 
        ,drvEligiblityDate = ''--convert(varchar, EecDateOfOriginalHire, 112) 
        --,drvDateofLastHire = CASE WHEN EecEmplStatus = 'T' and EecDateOfLastHire > EecDateOfTermination then EecDateOfLastHire end
        ,drvDateofLastHire = CASE WHEN EecDateOfLastHire > EecDateOfOriginalHire then convert(varchar, EecDateOfLastHire, 112)  end --CAB18064229 
        ,drvDateofTermination = CASE WHEN EecEmplStatus = 'T' THEN convert(varchar, EecDateOfTermination, 112)  END
        ,drvYTDHours = CONVERT(VARCHAR,CAST(PehCurHrs AS MONEY))
        ,drvYTDGrossComp = CONVERT(VARCHAR,PehCurAmt)
        ,drvYTDExcludComp = CONVERT(VARCHAR,ISNULL(PehIncl415CompYTD,0))  --N      
        ,drvEEDeferral = CONVERT(VARCHAR,CAST(ISNULL(PdhSource1,0) AS MONEY))--403BD'
        ,drvEERothDeferral = CONVERT(VARCHAR,CAST(ISNULL(PdhSource2,0) AS MONEY))--'403BR'
        ,drvERMatch = CONVERT(VARCHAR,CAST(ISNULL(PdhSource3,0) AS MONEY))        --'MATHC'
        ,drvERDiscretionary = CONVERT(VARCHAR,CAST(ISNULL(PdhSource4,0) AS MONEY))
        ,drvERAfterTaxDeferral = 0.00
        ,drvProfitSharing = 0.00
        ,drvSafeHarbor = 0.00
        ,drvPension = 0.00
        ,drvLoanPayment = CONVERT(VARCHAR,CAST(ISNULL(PdhSource5,0) AS MONEY))--LOANS
        ,drvPayrollFreq = CASE eecPayPeriod
                              WHEN 'B' THEN '6'
                              WHEN 'W' THEN '7'
                              WHEN 'S' THEN '5'
                              WHEN 'M' THEN '4'
                           END
        ,drvEmpType= case When EecIsSeasonalWorker = 'Y'  then '3'
                                Else Case EecEEType
                                When 'SUM' then '3'
                                When 'CON' then '4'
                                When 'STU' then '7'
                                Else Case EecFullTimeOrPartTime
                                When 'F' then '1'
                                When 'P' then '2' end end end
        ,drvSalary = Cast(EecAnnSalary as money)
        ,drvEmail = eepAddressEmail
        ,drvEMailAlternate = eepAddressEMailAlternate
        ,drvPhone = MPhon.efoPhoneNumber

    INTO dbo.U_EALE401EVI_drvTbl
    FROM dbo.U_EALE401EVI_EEList WITH (NOLOCK)

    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
        and (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                                        and EXISTS(select 1 from dbo.U_EALE401EVI_udit where  audKey1Value = xEEID AND audKey2Value = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
        AND EepHomeCoID = xCoID --TW SF 17414586 

    LEFT JOIN (SELECT efoEEID, efoPhoneNumber
          FROM dbo.EmpMPhon WITH (NOLOCK)
          GROUP BY efoEEID,efoPhoneNumber) AS MPhon
          ON MPhon.efoEEID = xEEID

    LEFT JOIN dbo.U_EALE401EVI_PEarHist WITH (NOLOCK)
        ON pehEEID = xEEID
        AND PrgPayDate > '1/1/2021'

    LEFT JOIN dbo.U_EALE401EVI_PDedHist WITH (NOLOCK)
        ON pdhEEID = xEEID
        WHERE (
                EecEmplStatus <> 'T' 
                OR (EecEmplStatus = 'T' 
                        AND EecDateOfTermination BETWEEN DATEADD(YEAR, DATEDIFF(YEAR, 0, GETDATE()), 0) -- 1/1 of current year 
                            AND DATEADD(YEAR, DATEDIFF(YEAR, 0, GETDATE()) + 1, -1) -- 12/31 of current year    
            ))

    

   ;

    --select * from dbo.U_EALE401EVI_drvTbl
        ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EALE401EVI_drvTrlTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EALE401EVI_drvTrlTbl;
    SELECT DISTINCT
        drvPaydate = @EndDate
        ,drvEEDeferralTot = (SELECT SUM(CAST(drvEEDeferral AS MONEY)) FROM dbo.U_EALE401EVI_drvTbl)
        ,drvEERothDeferralTot = (SELECT SUM(CAST(drvEERothDeferral AS MONEY)) FROM dbo.U_EALE401EVI_drvTbl)
        ,drvERMatchTot = (SELECT SUM(CAST(drvERMatch AS MONEY)) FROM dbo.U_EALE401EVI_drvTbl)
        ,drvERDiscretionaryTot = ''--(SELECT SUM(CAST(drvERDiscretionary AS MONEY)) FROM dbo.U_EALE401EVI_drvTbl)
        ,drvERAfterTaxDeferralTot = 0.00
        ,drvProfitSharingTot = 0.00
        ,drvSafeHarborTot = 0.00
        ,drvPensionTot = 0.00
        ,drvLoanPaymentTot = (SELECT SUM(CAST(drvLoanPayment AS MONEY)) FROM dbo.U_EALE401EVI_drvTbl)
    INTO dbo.U_EALE401EVI_drvTrlTbl


    ;




    --select * FROM dbo.U_EALE401EVI_drvTbl where drveeid = 'CGJ2DW04O040'
    --SP_GETEEID 'adams'
    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_EALE401EVI_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.csv'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'OE_EALE401EVI_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.csv'
                                  ELSE 'EALE401EVI_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.csv'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEALE401EVI_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EALE401EVI_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EALE401EVI%'
ORDER BY AdfSetNumber, AdfFieldNumber;


--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202106011'
       ,expStartPerControl     = '202106011'
       ,expLastEndPerControl   = '202106309'
       ,expEndPerControl       = '202106309'
WHERE expFormatCode = 'EALE401EVI';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEALE401EVI_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EALE401EVI_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EALE401EVI' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EALE401EVI'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EALE401EVI'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EALE401EVI', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EALE401EVI', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EALE401EVI', 'UseFileName', 'V', 'Y'


-- End ripout