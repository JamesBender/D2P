/*
Directions:
1) Find and replace each of the text below with the applicable information.
       E.g. Replace the text "Test TC" (excluding quotes) with "John Doe"
2) Deploy this to client environment!

EDISCTEST - Replace with format code, max length is 10. Start with capital E and try to make the code reflect the vendor/purpose
Test Disc File - Replace with Name of Interface (i.e. Discovery Combined Cobra/NPM Export)
Test Client - Name of client
Test TC - Name of TC
Test IA - Name of IA
5/26/2022 - Date the file is being created
123ABC - The TekP Number from Pipedrive
DEN1,DEN2,DENC1,DENC2,FSA,LMT,MED1,MED2,MED3,VIS - Replace with Deduction Code List in CSV format (i.e., DED1,DED2,DED3)
Y - If this is set to 'Y' then the deduction code list is ignored
SPS - Replace with SPS relationship codes in CSV format (i.e., SPS)
CHL,DPC,STC,CHD - Replace with CHL relationship codes in CSV format (i.e., CHL,STC)
DP - Replace with DP relationship codes in CSV format (i.e., DP)

*/


SET NOCOUNT ON;

--DECLARE @FormatCde VARCHAR(10) = 'EDISCTEST';

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EDISCTEST_SavePath') IS NOT NULL DROP TABLE dbo.U_EDISCTEST_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = '@FormatCde'


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
WHERE FormatCode = 'EDISCTEST'
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
WHERE ExpFormatCode = 'EDISCTEST'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EDISCTEST')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EDISCTEST'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EDISCTEST'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EDISCTEST'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EDISCTEST'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EDISCTEST'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EDISCTEST'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EDISCTEST'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EDISCTEST'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EDISCTEST'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEDISCTEST_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEDISCTEST_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EDISCTEST') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EDISCTEST];
GO
IF OBJECT_ID('U_EDISCTEST_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EDISCTEST_PEarHist];
GO
IF OBJECT_ID('U_EDISCTEST_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EDISCTEST_PDedHist];
GO
IF OBJECT_ID('U_EDISCTEST_File') IS NOT NULL DROP TABLE [dbo].[U_EDISCTEST_File];
GO
IF OBJECT_ID('U_EDISCTEST_EEList') IS NOT NULL DROP TABLE [dbo].[U_EDISCTEST_EEList];
GO
IF OBJECT_ID('U_EDISCTEST_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL') IS NOT NULL DROP TABLE [dbo].[U_EDISCTEST_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL];
GO
IF OBJECT_ID('U_EDISCTEST_drvTbl_QBPLANINITIAL') IS NOT NULL DROP TABLE [dbo].[U_EDISCTEST_drvTbl_QBPLANINITIAL];
GO
IF OBJECT_ID('U_EDISCTEST_drvTbl_QBEVENT') IS NOT NULL DROP TABLE [dbo].[U_EDISCTEST_drvTbl_QBEVENT];
GO
IF OBJECT_ID('U_EDISCTEST_drvTbl_QBDEPENDENTPLANINITIAL') IS NOT NULL DROP TABLE [dbo].[U_EDISCTEST_drvTbl_QBDEPENDENTPLANINITIAL];
GO
IF OBJECT_ID('U_EDISCTEST_drvTbl_QBDEPENDENT') IS NOT NULL DROP TABLE [dbo].[U_EDISCTEST_drvTbl_QBDEPENDENT];
GO
IF OBJECT_ID('U_EDISCTEST_drvTbl_QB') IS NOT NULL DROP TABLE [dbo].[U_EDISCTEST_drvTbl_QB];
GO
IF OBJECT_ID('U_EDISCTEST_drvTbl_NPM') IS NOT NULL DROP TABLE [dbo].[U_EDISCTEST_drvTbl_NPM];
GO
IF OBJECT_ID('U_EDISCTEST_DedList') IS NOT NULL DROP TABLE [dbo].[U_EDISCTEST_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EDISCTEST') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EDISCTEST];
GO

DECLARE @AdhSystemID VARCHAR(12), @FixedFormatName1 VARCHAR(50), @FixedFormatName2 VARCHAR(50);
SET @AdhSystemID = LEFT('EDISCTEST' + REPLICATE('0',10),10) + 'Z0';
SET @FixedFormatName1 = LEFT('Test Disc File',50);
SET @FixedFormatName2 = LEFT('Test Disc File',30);

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EDISCTEST',@FixedFormatName1,'N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N',@AdhSystemID,'N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1',@AdhSystemID,'50','H','01','1',NULL,'Field Header',NULL,NULL,'"[VERSION]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2',@AdhSystemID,'50','H','01','2',NULL,'Version Number',NULL,NULL,'"1.1"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1',@AdhSystemID,'50','D','10','1',NULL,'Field Header',NULL,NULL,'"[QB]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2',@AdhSystemID,'50','D','10','2',NULL,'Client Name ',NULL,NULL,'"Pivot Technology Services Corp 20436"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3',@AdhSystemID,'50','D','10','3',NULL,'Client Division Name',NULL,NULL,'"Pivot Technology Services Corp"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4',@AdhSystemID,'50','D','10','4',NULL,'Salutation ',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5',@AdhSystemID,'50','D','10','5',NULL,'First Name ',NULL,NULL,'"drvNameFirst"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6',@AdhSystemID,'50','D','10','6',NULL,'Middle Initial ',NULL,NULL,'"drvNameMiddle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7',@AdhSystemID,'50','D','10','7',NULL,'Last Name ',NULL,NULL,'"drvNameLast"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8',@AdhSystemID,'50','D','10','8',NULL,'SSN ',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9',@AdhSystemID,'50','D','10','9',NULL,'Individual ID ',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10',@AdhSystemID,'50','D','10','10',NULL,'Email ',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11',@AdhSystemID,'50','D','10','11',NULL,'Phone ',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12',@AdhSystemID,'50','D','10','12',NULL,'Phone 2 ',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13',@AdhSystemID,'50','D','10','13',NULL,'Address 1 ',NULL,NULL,'"drvAddressLine1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14',@AdhSystemID,'50','D','10','14',NULL,'Address 2 ',NULL,NULL,'"drvAddressLine2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15',@AdhSystemID,'50','D','10','15',NULL,'City ',NULL,NULL,'"drvAddressCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16',@AdhSystemID,'50','D','10','16',NULL,'State or Province ',NULL,NULL,'"drvAddressState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17',@AdhSystemID,'50','D','10','17',NULL,'Postal Code ',NULL,NULL,'"drvAddressZipCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18',@AdhSystemID,'50','D','10','18',NULL,'Country ',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19',@AdhSystemID,'50','D','10','19',NULL,'Premium Address Same As Primary ',NULL,NULL,'"True"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20',@AdhSystemID,'50','D','10','20',NULL,'Premium Address 1 ',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21',@AdhSystemID,'50','D','10','21',NULL,'Premium Address 2 ',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22',@AdhSystemID,'50','D','10','22',NULL,'Premium City ',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23',@AdhSystemID,'50','D','10','23',NULL,'Premium State Or Province ',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24',@AdhSystemID,'50','D','10','24',NULL,'Premium Postal Code ',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25',@AdhSystemID,'50','D','10','25',NULL,'Premium Country ',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26',@AdhSystemID,'50','D','10','26',NULL,'Sex ',NULL,NULL,'"drvSex"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27',@AdhSystemID,'50','D','10','27',NULL,'DOB ',NULL,NULL,'"drvDateOfBirth"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28',@AdhSystemID,'50','D','10','28',NULL,'Tobacco Use ',NULL,NULL,'"UNKNOWN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29',@AdhSystemID,'50','D','10','29',NULL,'Employee Type ',NULL,NULL,'"UNKNOWN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30',@AdhSystemID,'50','D','10','30',NULL,'Employee Payroll Type ',NULL,NULL,'"UNKNOWN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31',@AdhSystemID,'50','D','10','31',NULL,'Years of Service ',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32',@AdhSystemID,'50','D','10','32',NULL,'Premium Coupon Type ',NULL,NULL,'"COUPONBOOK"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33',@AdhSystemID,'50','D','10','33',NULL,'Uses HCTC ',NULL,NULL,'"FALSE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34',@AdhSystemID,'50','D','10','34',NULL,'Active ',NULL,NULL,'"TRUE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35',@AdhSystemID,'50','D','10','35',NULL,'Allow Member SSO ',NULL,NULL,'"FALSE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36',@AdhSystemID,'50','D','10','36',NULL,'Benefit Group ',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37',@AdhSystemID,'50','D','10','37',NULL,'Account Structure ',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38',@AdhSystemID,'50','D','10','38',NULL,'Client Specific Data ',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39',@AdhSystemID,'50','D','10','39',NULL,'Client Specific Data ',NULL,NULL,'""','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1',@AdhSystemID,'50','D','20','1',NULL,'Field Header',NULL,NULL,'"[QBEVENT]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2',@AdhSystemID,'50','D','20','2',NULL,'Event Type',NULL,NULL,'"drvEventType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3',@AdhSystemID,'50','D','20','3',NULL,'Event Date ',NULL,NULL,'"drvEventDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4',@AdhSystemID,'50','D','20','4',NULL,'Enrollment Date ',NULL,NULL,'"drvEnrollmentDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5',@AdhSystemID,'50','D','20','5',NULL,'Employee SSN ',NULL,NULL,'"drvEmployeeSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6',@AdhSystemID,'50','D','20','6',NULL,'Employee Name ',NULL,NULL,'"drvEmployeeName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7',@AdhSystemID,'50','D','20','7',NULL,'Second Event Original FDOC ',NULL,NULL,'""','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1',@AdhSystemID,'50','D','30','1',NULL,'Field Header',NULL,NULL,'"[QBPLANINITIAL]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2',@AdhSystemID,'50','D','30','2',NULL,'Plan Name ',NULL,NULL,'"drvPlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3',@AdhSystemID,'50','D','30','3',NULL,'Coverage Level ',NULL,NULL,'"drvCoverageLevel"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4',@AdhSystemID,'50','D','30','4',NULL,'Number Of Units ',NULL,NULL,'""','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1',@AdhSystemID,'50','D','40','1',NULL,'Field Header',NULL,NULL,'"[QBDEPENDENT]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2',@AdhSystemID,'50','D','40','2',NULL,'SSN ',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3',@AdhSystemID,'50','D','40','3',NULL,'Relationship ',NULL,NULL,'"drvRelationship"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4',@AdhSystemID,'50','D','40','4',NULL,'Salutation ',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5',@AdhSystemID,'50','D','40','5',NULL,'First Name ',NULL,NULL,'"drvNameFirst"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6',@AdhSystemID,'50','D','40','6',NULL,'Middle Initial ',NULL,NULL,'"drvNameMiddle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7',@AdhSystemID,'50','D','40','7',NULL,'Last Name ',NULL,NULL,'"drvNameLast"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8',@AdhSystemID,'50','D','40','8',NULL,'Email ',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9',@AdhSystemID,'50','D','40','9',NULL,'Phone ',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10',@AdhSystemID,'50','D','40','10',NULL,'Phone 2 ',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11',@AdhSystemID,'50','D','40','11',NULL,'Address Same As QB ',NULL,NULL,'"TRUE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12',@AdhSystemID,'50','D','40','12',NULL,'Address 1 ',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13',@AdhSystemID,'50','D','40','13',NULL,'Address 2 ',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14',@AdhSystemID,'50','D','40','14',NULL,'City ',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15',@AdhSystemID,'50','D','40','15',NULL,'State Or Province ',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16',@AdhSystemID,'50','D','40','16',NULL,'Postal Code ',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17',@AdhSystemID,'50','D','40','17',NULL,'Country ',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18',@AdhSystemID,'50','D','40','18',NULL,'Enrollment Date ',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19',@AdhSystemID,'50','D','40','19',NULL,'Sex ',NULL,NULL,'"drvSex"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20',@AdhSystemID,'50','D','40','20',NULL,'DOB ',NULL,NULL,'"drvDateOfBirth"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21',@AdhSystemID,'50','D','40','21',NULL,'Is QMCSO ',NULL,NULL,'"FALSE"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1',@AdhSystemID,'50','D','50','1',NULL,'Field Header',NULL,NULL,'"[QBDEPENDENTPLANINITIAL]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2',@AdhSystemID,'50','D','50','2',NULL,'Plan Name ',NULL,NULL,'"drvPlanName"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1',@AdhSystemID,'50','D','60','1',NULL,'Field Header',NULL,NULL,'"drvFieldHeader"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2',@AdhSystemID,'50','D','60','2',NULL,'Plan Name ',NULL,NULL,'"drvPlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3',@AdhSystemID,'50','D','60','3',NULL,'Rate',NULL,NULL,'"drvRate"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1',@AdhSystemID,'50','D','70','1',NULL,'Field Header',NULL,NULL,'"[NPM]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2',@AdhSystemID,'50','D','70','2',NULL,'SSN ',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3',@AdhSystemID,'50','D','70','3',NULL,'Individual Identifier ',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4',@AdhSystemID,'50','D','70','4',NULL,'Client Name ',NULL,NULL,'"Pivot Technology Services Corp 20436"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5',@AdhSystemID,'50','D','70','5',NULL,'Client Division Name',NULL,NULL,'"Pivot Technology Services Corp"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6',@AdhSystemID,'50','D','70','6',NULL,'First Name ',NULL,NULL,'"drvNameFirst"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7',@AdhSystemID,'50','D','70','7',NULL,'Middle Initial ',NULL,NULL,'"drvNameMiddle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8',@AdhSystemID,'50','D','70','8',NULL,'Last Name ',NULL,NULL,'"drvNameLast"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9',@AdhSystemID,'50','D','70','9',NULL,'Salutation ',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10',@AdhSystemID,'50','D','70','10',NULL,'Email ',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11',@AdhSystemID,'50','D','70','11',NULL,'Phone ',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12',@AdhSystemID,'50','D','70','12',NULL,'Phone 2 ',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13',@AdhSystemID,'50','D','70','13',NULL,'Address 1 ',NULL,NULL,'"drvAddressLine1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14',@AdhSystemID,'50','D','70','14',NULL,'Address 2 ',NULL,NULL,'"drvAddressLine2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15',@AdhSystemID,'50','D','70','15',NULL,'City ',NULL,NULL,'"drvAddressCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16',@AdhSystemID,'50','D','70','16',NULL,'State Or Province ',NULL,NULL,'"drvAddressState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17',@AdhSystemID,'50','D','70','17',NULL,'Postal Code ',NULL,NULL,'"drvAddressZipCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18',@AdhSystemID,'50','D','70','18',NULL,'Country ',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19',@AdhSystemID,'50','D','70','19',NULL,'Sex ',NULL,NULL,'"drvSex"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20',@AdhSystemID,'50','D','70','20',NULL,'Uses Family In Address',NULL,NULL,'"TRUE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21',@AdhSystemID,'50','D','70','21',NULL,'Has Waived All Coverage',NULL,NULL,'"FALSE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22',@AdhSystemID,'50','D','70','22',NULL,'Send GR Notice ',NULL,NULL,'"TRUE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23',@AdhSystemID,'50','D','70','23',NULL,'Hire Date ',NULL,NULL,'"drvHireDate"','(''UD101''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EDISCTEST' + '_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','202106119','EMPEXPORT','OEACTIVE','May 12 2021  2:35PM','EDISCTEST',NULL,NULL,NULL,'202106119','May 11 2021  3:59PM','May 11 2021  3:59PM','202103011','300','','','202103011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Passive Open Enrollment Export','202106119','EMPEXPORT','OEPASSIVE','May 12 2021  2:36PM','EDISCTEST',NULL,NULL,NULL,'202106119','May 11 2021  3:59PM','May 11 2021  3:59PM','202103011','300','','','202103011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Discovery QB and NPM Export','202106119','EMPEXPORT','ONDEM_XOE','May 12 2021  2:37PM','EDISCTEST',NULL,NULL,NULL,'202106119','May 11 2021  3:59PM','May 11 2021  3:59PM','202103011','300','','','202103011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N','XBO8J,XBOH9,XBOY6,XMKY0',NULL,NULL,NULL,@FixedFormatName2,'202106169','EMPEXPORT','SCH_EDSQBN','May 12 2021  2:38PM','EDISCTEST',NULL,NULL,NULL,'202112319','May 11 2021  3:59PM','May 11 2021  3:59PM','202112241','300','','','202106161',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Discovery QB and NPM Exp-Test','202110129','EMPEXPORT','TEST_XOE','Oct 12 2021  9:26AM','EDISCTEST',NULL,NULL,NULL,'202110129','Oct 12 2021 12:00AM','Dec 30 1899 12:00AM','202105011','416','','','202105011',dbo.fn_GetTimedKey(),NULL,'us3cPeACS1003',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCTEST','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCTEST','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCTEST','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCTEST','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCTEST','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCTEST','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCTEST','D10','dbo.U_EDISCTEST_drvTbl_QB',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCTEST','D20','dbo.U_EDISCTEST_drvTbl_QBEVENT',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCTEST','D30','dbo.U_EDISCTEST_drvTbl_QBPLANINITIAL',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCTEST','D40','dbo.U_EDISCTEST_drvTbl_QBDEPENDENT',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCTEST','D50','dbo.U_EDISCTEST_drvTbl_QBDEPENDENTPLANINITIAL',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCTEST','D60','dbo.U_EDISCTEST_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCTEST','D70','dbo.U_EDISCTEST_drvTbl_NPM',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EDISCTEST
-----------

IF OBJECT_ID('U_dsi_BDM_EDISCTEST') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EDISCTEST] (
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
-- Create table U_EDISCTEST_DedList
-----------

IF OBJECT_ID('U_EDISCTEST_DedList') IS NULL
CREATE TABLE [dbo].[U_EDISCTEST_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EDISCTEST_drvTbl_NPM
-----------

IF OBJECT_ID('U_EDISCTEST_drvTbl_NPM') IS NULL
CREATE TABLE [dbo].[U_EDISCTEST_drvTbl_NPM] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(14) NULL,
    [drvSSN] char(11) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvSex] varchar(1) NULL,
    [drvHireDate] datetime NULL
);

-----------
-- Create table U_EDISCTEST_drvTbl_QB
-----------

IF OBJECT_ID('U_EDISCTEST_drvTbl_QB') IS NULL
CREATE TABLE [dbo].[U_EDISCTEST_drvTbl_QB] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(16) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvSSN] char(11) NULL,
    [drvAddressLine1] varchar(8000) NULL,
    [drvAddressLine2] varchar(8000) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvSex] varchar(1) NULL,
    [drvDateOfBirth] datetime NULL
);

-----------
-- Create table U_EDISCTEST_drvTbl_QBDEPENDENT
-----------

IF OBJECT_ID('U_EDISCTEST_drvTbl_QBDEPENDENT') IS NULL
CREATE TABLE [dbo].[U_EDISCTEST_drvTbl_QBDEPENDENT] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(31) NULL,
    [drvSSN] char(11) NULL,
    [drvRelationship] varchar(15) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvSex] varchar(1) NULL,
    [drvDateOfBirth] datetime NULL
);

-----------
-- Create table U_EDISCTEST_drvTbl_QBDEPENDENTPLANINITIAL
-----------

IF OBJECT_ID('U_EDISCTEST_drvTbl_QBDEPENDENTPLANINITIAL') IS NULL
CREATE TABLE [dbo].[U_EDISCTEST_drvTbl_QBDEPENDENTPLANINITIAL] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(30) NULL,
    [drvPlanName] varchar(42) NULL
);

-----------
-- Create table U_EDISCTEST_drvTbl_QBEVENT
-----------

IF OBJECT_ID('U_EDISCTEST_drvTbl_QBEVENT') IS NULL
CREATE TABLE [dbo].[U_EDISCTEST_drvTbl_QBEVENT] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(16) NULL,
    [drvEventType] varchar(29) NULL,
    [drvEventDate] datetime NULL,
    [drvEnrollmentDate] datetime NULL,
    [drvEmployeeSSN] char(11) NULL,
    [drvEmployeeName] varchar(201) NULL
);

-----------
-- Create table U_EDISCTEST_drvTbl_QBPLANINITIAL
-----------

IF OBJECT_ID('U_EDISCTEST_drvTbl_QBPLANINITIAL') IS NULL
CREATE TABLE [dbo].[U_EDISCTEST_drvTbl_QBPLANINITIAL] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(16) NULL,
    [drvPlanName] varchar(42) NULL,
    [drvCoverageLevel] varchar(18) NULL
);

-----------
-- Create table U_EDISCTEST_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL
-----------

IF OBJECT_ID('U_EDISCTEST_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL') IS NULL
CREATE TABLE [dbo].[U_EDISCTEST_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(16) NULL,
    [drvFieldHeader] varchar(33) NOT NULL,
    [drvPlanName] varchar(7) NULL,
    [drvRate] nvarchar(4000) NULL
);

-----------
-- Create table U_EDISCTEST_EEList
-----------

IF OBJECT_ID('U_EDISCTEST_EEList') IS NULL
CREATE TABLE [dbo].[U_EDISCTEST_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EDISCTEST_File
-----------

IF OBJECT_ID('U_EDISCTEST_File') IS NULL
CREATE TABLE [dbo].[U_EDISCTEST_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);

-----------
-- Create table U_EDISCTEST_PDedHist
-----------

IF OBJECT_ID('U_EDISCTEST_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EDISCTEST_PDedHist] (
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

-----------
-- Create table U_EDISCTEST_PEarHist
-----------

IF OBJECT_ID('U_EDISCTEST_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EDISCTEST_PEarHist] (
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
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EDISCTEST]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Test Client

Created By: Test TC
Business Analyst: Test IA
Create Date: 5/26/2022
Service Request Number: 123ABC

Purpose: @FixedFormatName1

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EDISCTEST';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EDISCTEST';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EDISCTEST';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EDISCTEST';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EDISCTEST' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISCTEST', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISCTEST', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISCTEST', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISCTEST', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISCTEST', 'SCH_EDSQBN';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EDISCTEST';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EDISCTEST', @AllObjects = 'Y', @IsWeb = 'Y'
**********************************************************************************/
BEGIN

    --==========================================
    -- Declare variables
    --==========================================
    DECLARE  @FormatCde        VARCHAR(10)
            ,@ExportCode        VARCHAR(10)
            ,@StartDate         DATETIME
            ,@EndDate           DATETIME
            ,@StartPerControl   VARCHAR(9)
            ,@EndPerControl     VARCHAR(9);

    -- Set FormatCode
    SELECT @FormatCde = 'EDISCTEST';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCde;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EDISCTEST_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EDISCTEST_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'DEN1,DEN2,DENC1,DENC2,FSA,LMT,MED1,MED2,MED3,VIS';

    IF OBJECT_ID('U_EDISCTEST_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCTEST_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EDISCTEST_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCde;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCde,'DedCodes',@DedList);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCde,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCde,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCde,'TermSelectionOption','AuditDate');

    -- Non-Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCde,'BuildConsolidatedTable','Standard');

    -- COBRA parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCde,'RunID','QB');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCde,'UseCobraCoveredDeds','Y'); -- DedIsCobraCovered = 'Y'
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCde,'CobraType','4'); -- Eep/ConCobraReason first, then EdhChangeReason. Include CHGRP for elig. ben groups – 
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCde,'CobraDate','3'); -- EedBenStopDate and DbnBenStopDate, unless Eep/ConDateOfCOBRAEvent exists – 
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCde,'CobraPQBType','1'); -- If no EE or spouse, ALL children are PQB (not just oldest) – include this line if deps are sent as QB and not the employee.  
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCde,'CobraReasonsDepPQB','201,204,210,LEVNT3,LEVNT4'); -- Add valid dependent edhchangereasons
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCde,'InvalidCobraReasonsEmp','201,204,210,LEVNT3,LEVNT4'); -- Invalidate employee when Cobra Reason is a dependent PQB reason – Add valid dependent edhchangereasons (should be same as previous line above)


    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCde,'InvalidTermReasonsEmp','203'); -- Invalidate employee when Cobra Reason is "Death".  Add the Death employment term reason (eectermreason)
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCde,'ConCobraReasonPCF','DependentCOBRAReason'); -- Valid dependent PQB reasons – used when clients have Platform Configurable fields.  Add any other field names the client is using.
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCde,'CountDependents','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCde,'RelationshipsSpouse','SPS'); -- update to the spouse relationship code
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCde,'RelationshipsChild', 'CHL,DPC,STC,CHD'); -- update to the child relationship codes
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCde,'RelationshipsDomPartner','DP'); -- update to the domestic partner relationship code


    -- Required OE parameters
    IF @ExportCode LIKE '%PASSIVE'
    BEGIN
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCde,'OEType','PASSIVE');
    END;

    IF @ExportCode LIKE '%ACTIVE'
    BEGIN
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCde,'OEType','ACTIVE');
    END;


    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCde;

    
    --==========================================
    --NPM Section
    --==========================================

    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCde;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCde,'DedCodes',@DedList);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCde,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCde,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCde,'TermSelectionOption','AuditDate');

    -- NPM parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCde,'RunID','NPM');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCde,'AddToPreviousRun','Y');  -- only used for NPM/QB combined files
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCde,'UseCobraCoveredDeds','Y'); -- DedIsCobraCovered = 'Y'
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCde,'NewEnrolleeType','4'); -- All new enrollees where no previous plan exists
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCde, 'GetChangeReason', 'Y')

    -- Non-Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCde,'BuildConsolidatedTable','Standard');

    -- Required OE parameters
    IF @ExportCode LIKE '%PASSIVE'
    BEGIN
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCde,'OEType','PASSIVE');
    END;

    IF @ExportCode LIKE '%ACTIVE'
    BEGIN
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCde,'OEType','ACTIVE');
    END;


    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCde;



    ---==========================================
 --   -- Insert into BDM Reason code 201 and 204
 --   --==========================================
    INSERT INTO [dbo].[U_dsi_BDM_EDISCTEST]
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
           ,[BdmBenStartDate]
           ,[BdmBenStopDate]
           ,[BdmBenStatusDate]
           ,[BdmDateOFCobraEvent]
           ,[BdmChangeReason]
           ,[BdmCobraReason]
           ,[BdmStartDate]
           ,[BdmStopDate]
           ,[BdmIsPQB]
    )
    Select rectype = 'DEP'
        ,DbnCoid
        ,DbnEEID
        ,DbnDepRecID
        ,DbnDepRecID
        ,'QB'
        ,'Data Inserted for 204 Chg reason'
        ,DbnRelationship
        ,DbnDateOfBirth
        ,DbnDedCode
        ,DbnBenOption
        ,DbnBenStartDate
        ,DbnBenStopDate
        ,DbnBenStatusDate
        ,DbnBenStatusDate
        ,'204'
        ,'204'
        ,DbnBenStartDate
        ,DbnBenStopDate
        ,'Y'
    FROM dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
	JOIN dbo.emphded WITH (NOLOCK)
        ON dbneeid = edheeid 
    WHERE edhChangeReason IN ('204') 
        and DbnBenstopdate BETWEEN @startdate AND @enddate 
        AND dbnValidForExport = 'N'
		AND dbnformatcode = 'EDISCTEST'

    INSERT INTO [dbo].[U_dsi_BDM_EDISCTEST]
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
           ,[BdmBenStartDate]
           ,[BdmBenStopDate]
           ,[BdmBenStatusDate]
           ,[BdmDateOFCobraEvent]
           ,[BdmChangeReason]
           ,[BdmCobraReason]
           ,[BdmStartDate]
           ,[BdmStopDate]
           ,[BdmIsPQB]
    )
    Select rectype = 'DEP'
        ,DbnCoid
        ,DbnEEID
        ,DbnDepRecID
        ,DbnDepRecID
        ,'QB'
        ,'Data Inserted for 201 Chg reason'
        ,DbnRelationship
        ,DbnDateOfBirth
        ,DbnDedCode
        ,DbnBenOption
        ,DbnBenStartDate
        ,DbnBenStopDate
        ,DbnBenStatusDate
        ,DbnBenStatusDate
        ,'201'
        ,'201'
        ,DbnBenStartDate
        ,DbnBenStopDate
        ,'Y'
    FROM dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
	JOIN dbo.emphded WITH (NOLOCK)
        ON dbneeid = edheeid 
    WHERE edhChangeReason IN ('201') 
        and DbnBenstopdate BETWEEN @startdate AND @enddate 
        AND dbnValidForExport = 'N'
		AND dbnformatcode = 'EDISCTEST'

    Delete from dbo.U_dsi_BDM_EDISCTEST where bdmdedcode not in (Select dedcode from U_EDISCTEST_DedList)

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EDISCTEST_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCTEST_PDedHist;
    SELECT DISTINCT
         PdhEEID
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
    INTO dbo.U_EDISCTEST_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EDISCTEST_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EDISCTEST_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCTEST_PEarHist;
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
    INTO dbo.U_EDISCTEST_PEarHist
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

    DELETE dbo.U_dsi_BDM_EDISCTEST 
    WHERE BdmRunId = 'QB'
        AND BdmBenStatus = 'C'
    ---------------------------------
    -- DETAIL RECORD - U_EDISCTEST_drvTbl_QB
    ---------------------------------
    IF OBJECT_ID('U_EDISCTEST_drvTbl_QB','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCTEST_drvTbl_QB;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '1 ' + xEEID + ' 1'
        -- standard fields above and additional driver fields below
        ,drvNameFirst = CASE WHEN EdhChangeReason IN ('201','302','LEVNT4','204','210','LEVNT3') OR BdmCobraReason IN ('210') THEN ConNameFirst ELSE EepNameFirst END
        ,drvNameMiddle = CASE WHEN EdhChangeReason IN ('201','302','LEVNT4','204','210','LEVNT3') THEN LEFT(ConNameMiddle,1) ELSE LEFT(EepNameMiddle,1) END
        ,drvNameLast = CASE WHEN EdhChangeReason IN ('201','302','LEVNT4','204','210','LEVNT3') THEN ConNameLast ELSE EepNameLast END
        ,drvSSN = CASE WHEN EdhChangeReason IN ('201','302','LEVNT4','204','210','LEVNT3') THEN ConSSN ELSE eepSSN END
        ,drvAddressLine1 = REPLACE(CASE WHEN EdhChangeReason IN ('201','302','LEVNT4','204','210','LEVNT3') THEN ConAddressLine1 ELSE EepAddressLine1 END, ',', '')
        ,drvAddressLine2 = REPLACE(CASE WHEN EdhChangeReason IN ('201','302','LEVNT4','204','210','LEVNT3') THEN ConAddressLine2 ELSE EepAddressLine2 END, ',','')
        ,drvAddressCity = CASE WHEN EdhChangeReason IN ('201','302','LEVNT4','204','210','LEVNT3') THEN ConAddressCity ELSE EepAddressCity END
        ,drvAddressState = CASE WHEN EdhChangeReason IN ('201','302','LEVNT4','204','210','LEVNT3') THEN ConAddressState ELSE EepAddressState END
        ,drvAddressZipCode = CASE WHEN EdhChangeReason IN ('201','302','LEVNT4','204','210','LEVNT3') THEN ConAddressZipCode ELSE EepAddressZipCode END
        ,drvSex =    CASE WHEN EdhChangeReason IN ('201','302','LEVNT4','204','210','LEVNT3') THEN 
                        CASE WHEN ConGender IN ('M','F') THEN ConGender ELSE 'U' END
                    ELSE CASE WHEN EepGender IN ('M','F') THEN EepGender ELSE 'U' END
                    END
        ,drvDateOfBirth = CASE WHEN EdhChangeReason IN ('201','302','LEVNT4','204','210','LEVNT3') THEN ConDateOfBirth ELSE EepDateOfBirth END
    INTO dbo.U_EDISCTEST_drvTbl_QB
    FROM dbo.U_EDISCTEST_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EDISCTEST WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRunId = 'QB'
        AND BdmIsPQB = 'Y'
        --AND BdmBenStatus <> 'C'
    LEFT JOIN (
            SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent 
            FROM (
                    SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent, ROW_NUMBER() OVER (PARTITION by EdhEEID, EdhCOID ORDER BY EdhEffDate desc) AS RN
                    FROM dbo.EmpHDed a WITH (NOLOCK)
                    JOIN dbo.BenChRsn WITH (NOLOCK)
                        ON EdhChangeReason = BchCode
                    WHERE EdhDedCode IN ('DPPO','DDMO','MEPO','MHSA','MPPO','VIS','FSA') 
                        AND edhChangeReason IN ('208','204','LEVNT4','205','201','302','LEVNT3', '203','202','206','200')
                ) AS X
            WHERE RN = 1) AS Edh
        ON EdhEEID = xEEID
        AND EdhCoID = xCOID  
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecId
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EDISCTEST_drvTbl_QBEVENT
    ---------------------------------
    IF OBJECT_ID('U_EDISCTEST_drvTbl_QBEVENT','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCTEST_drvTbl_QBEVENT;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '1 ' + xEEID + ' 2'
        -- standard fields above and additional driver fields below
        ,drvEventType =    CASE WHEN EecEmplStatus = 'T' AND EecTermReason NOT IN ('202','203') AND EecTermType = 'V' THEN 'TERMINATION'
                            WHEN EecEmplStatus ='T' AND EecTermReason = '203' THEN 'DEATH'
                            WHEN EecEmplStatus = 'T' AND EecTermReason = '202' THEN 'RETIREMENT'
                            WHEN EecEmplStatus = 'T' AND EecTermType = 'I' THEN 'INVOLUNTARYTERMINATION'
                            WHEN EdhChangeReason = '208' THEN 'RETIREMENT'
                            WHEN EdhChangeReason = '205' THEN 'MEDICARE'
                            WHEN EdhChangeReason IN ('204','LEVNT4') THEN 'DIVORCELEGALSEPARATION'
                            WHEN EdhChangeReason IN ('201','302','LEVNT3') THEN 'INELIGIBLEDEPENDENT'
                            WHEN EdhChangeReason IN ('203','202') THEN 'REDUCTIONINHOURS-STATUSCHANGE'
                            WHEN EdhChangeReason = '206' THEN 'REDUCTIONINHOURS-ENDOFLEAVE'
                        END
        ,drvEventDate =    CASE WHEN EecEmplStatus = 'T' AND EecTermReason NOT IN ('202','203') THEN EecDateOfTermination
                            WHEN EecEmplStatus = 'T' AND EecTermReason IN ('202','203') AND ISNULL(EepDateOfCOBRAEvent, '') = '' THEN EecDateOfTermination
                            WHEN EdhChangeReason IN ('LEVNT3','LEVNT4','204','210','201','302') THEN EdhEffDate
                            ELSE EepDateOfCOBRAEvent
                        END
        ,drvEnrollmentDate = BdmBenStartDate 
        ,drvEmployeeSSN = eepSSN
        ,drvEmployeeName = EepNameFirst + ' ' + EepNameLast
    INTO dbo.U_EDISCTEST_drvTbl_QBEVENT
    FROM dbo.U_EDISCTEST_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN (
            SELECT
                 BdmEEID
                ,BdmCoID
                ,BdmCobraReason = MAX(BdmCobraReason)
                ,BdmBenStopDate = MAX(BdmBenStopDate)
                ,BdmBenStartDate = MIN(BdmBenStartDate)
                ,BdmDateOfCOBRAEvent = MAX(BdmDateOfCOBRAEvent)
              FROM dbo.U_dsi_BDM_EDISCTEST WITH (NOLOCK)
              WHERE BdmRunId = 'QB'
              GROUP BY BdmEEID, BdmCoID) AS Bdm
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID        
    LEFT JOIN (
            SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent 
            FROM (
                    SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent, ROW_NUMBER() OVER (PARTITION by EdhEEID, EdhCOID ORDER BY EdhEffDate desc) AS RN
                    FROM dbo.EmpHDed a WITH (NOLOCK)
                    JOIN dbo.BenChRsn WITH (NOLOCK)
                        ON EdhChangeReason = BchCode
                    WHERE EdhDedCode IN ('DPPO','DDMO','MEPO','MHSA','MPPO','VIS','FSA') 
                        AND edhChangeReason IN ('208','204','LEVNT4','205','201','302','LEVNT3', '203','202','206','200')
                ) AS X
            WHERE RN = 1) AS Edh
        ON EdhEEID = xEEID
        AND EdhCoID = xCOID  
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EDISCTEST_drvTbl_QBPLANINITIAL
    ---------------------------------
    IF OBJECT_ID('U_EDISCTEST_drvTbl_QBPLANINITIAL','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCTEST_drvTbl_QBPLANINITIAL;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '1 ' + xEEID + ' 3'
        -- standard fields above and additional driver fields below
        ,drvPlanName =    CASE WHEN BdmDedCode = 'DPPO' THEN 'Aetna Dental PPO PTSC'
                            WHEN BdmDedCode = 'DDMO' AND EepAddressState IN ('CA','AZ','NJ','NC','TX','GA') THEN 'Aetna Dental PTSC DMO LE CA AZ NJ NC TX GA'
                            WHEN BdmDedCode = 'DDMO' AND EepAddressState NOT IN ('CA','AZ','NJ','NC','TX','GA') THEN 'Aetna Dental PTSC DMO NLE'
                            WHEN BdmDedCode = 'MEPO' THEN 'Aetna Medical EPO PTSC'
                            WHEN BdmDedCode = 'MHSA' THEN 'Aetna Medical HDHP PTSC'
                            WHEN BdmDedCode = 'MPPO' THEN 'Aetna Medical PPO PTSC'
                            WHEN BdmDedCode = 'VIS' THEN 'EyeMed Vision Care'
                            WHEN BdmDedCode = 'FSA' THEN 'DBI FSA'
                        END
        ,drvCoverageLevel = CASE WHEN A.BdmCobraReason IN ('210') THEN
                                CASE WHEN A.BdmRelationship IN ('SPS','DP') AND (SELECT COUNT(*) FROM dbo.U_dsi_BDM_EDISCTEST B WITH (NOLOCK) WHERE A.BdmEEID = B.BdmEEID AND B.BdmRelationship IN ('CH','CHL','DPC','STC','DCH')) > 0 THEN 'EE+CHILDREN'
                                    WHEN A.BdmRelationship IN ('CH','CHL','DPC','STC','DCH') THEN 'EE+CHILDREN'
                                    ELSE 'EE'
                                END
                            ELSE
                                CASE WHEN EdhChangeReason IN ('204','LEVNT4','201','302','LEVNT3') OR (EecEmplStatus ='T' AND EecTermReason = '203') THEN 'EE'
                                    WHEN BdmDedCode = 'FSA' THEN 'EE'
                                    WHEN BdmBenOption = 'EE' THEN 'EE'
                                    WHEN BdmBenOption = 'EEC' THEN 'EE+CHILDREN'
                                    WHEN BdmBenOption = 'EDP' THEN 'EE+DOMESTICPARTNER'
                                    WHEN BdmBenOption IN ('EEF','EEDPF') THEN 'EE+FAMILY'
                                    WHEN BdmBenOption = 'EES' THEN 'EE+SPOUSE'
                                END
                            END
        
        /*CASE WHEN EdhChangeReason IN ('204','LEVNT4','201','302','LEVNT3') OR (EecEmplStatus ='T' AND EecTermReason = '203') THEN 'EE'
                                WHEN BdmDedCode = 'FSA' THEN 'EE'
                                WHEN BdmBenOption = 'EE' THEN 'EE'
                                WHEN BdmBenOption = 'EEC' THEN 'EE+CHILDREN'
                                WHEN BdmBenOption = 'EDP' THEN 'EE+DOMESTICPARTNER'
                                WHEN BdmBenOption IN ('EEF','EEDPF') THEN 'EE+FAMILY'
                                WHEN BdmBenOption = 'EES' THEN 'EE+SPOUSE'
                            END*/
    INTO dbo.U_EDISCTEST_drvTbl_QBPLANINITIAL
    FROM dbo.U_EDISCTEST_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.U_dsi_BDM_EDISCTEST A WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRunId = 'QB'
    LEFT JOIN (
            SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent 
            FROM (
                    SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent, ROW_NUMBER() OVER (PARTITION by EdhEEID, EdhCOID ORDER BY EdhEffDate desc) AS RN
                    FROM dbo.EmpHDed a WITH (NOLOCK)
                    JOIN dbo.BenChRsn WITH (NOLOCK)
                        ON EdhChangeReason = BchCode
                    WHERE EdhDedCode IN ('DPPO','DDMO','MEPO','MHSA','MPPO','VIS','FSA') 
                        AND edhChangeReason IN ('208','204','LEVNT4','205','201','302','LEVNT3', '203','202','206','200')
                ) AS X
            WHERE RN = 1) AS Edh
        ON EdhEEID = xEEID
        AND EdhCoID = xCOID  
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EDISCTEST_drvTbl_QBDEPENDENT
    ---------------------------------
    IF OBJECT_ID('U_EDISCTEST_drvTbl_QBDEPENDENT','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCTEST_drvTbl_QBDEPENDENT;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '1 ' + xEEID + ' 4 ' +  + BdmDepRecID + ' 1'
        -- standard fields above and additional driver fields below
        ,drvSSN = ConSSN
        ,drvRelationship =    CASE WHEN ConRelationship IN ('CHL','DCH','DPC','STC') THEN 'CHILD'
                                WHEN ConRelationship = 'SPS' THEN 'SPOUSE'
                                WHEN ConRelationship = 'DP' THEN 'DOMESTICPARTNER'
                            END
        ,drvNameFirst = ConNameFirst
        ,drvNameMiddle = LEFT(ConNameMiddle,1)
        ,drvNameLast = ConNameLast
        ,drvSex = CASE WHEN ConGender IN ('M','F') THEN ConGender ELSE 'U' END
        ,drvDateOfBirth = ConDateOfBirth
    INTO dbo.U_EDISCTEST_drvTbl_QBDEPENDENT
    FROM dbo.U_EDISCTEST_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EDISCTEST WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRunId = 'QB'
JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = bdmEEID
        AND ConSystemID = BdmDepRecID
    WHERE BdmIsPQB = 'N'
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EDISCTEST_drvTbl_QBDEPENDENTPLANINITIAL
    ---------------------------------
    IF OBJECT_ID('U_EDISCTEST_drvTbl_QBDEPENDENTPLANINITIAL','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCTEST_drvTbl_QBDEPENDENTPLANINITIAL;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '1 ' + xEEID + ' 4 ' + BdmDepRecID + '2'
        -- standard fields above and additional driver fields below
        ,drvPlanName =    CASE WHEN BdmDedCode = 'DPPO' THEN 'Aetna Dental PPO PTSC'
                            WHEN BdmDedCode = 'DDMO' AND EepAddressState IN ('CA','AZ','NJ','NC','TX','GA') THEN 'Aetna Dental PTSC DMO LE CA AZ NJ NC TX GA'
                            WHEN BdmDedCode = 'DDMO' AND EepAddressState NOT IN ('CA','AZ','NJ','NC','TX','GA') THEN 'Aetna Dental PTSC DMO NLE'
                            WHEN BdmDedCode = 'MEPO' THEN 'Aetna Medical EPO PTSC'
                            WHEN BdmDedCode = 'MHSA' THEN 'Aetna Medical HDHP PTSC'
                            WHEN BdmDedCode = 'MPPO' THEN 'Aetna Medical PPO PTSC'
                            WHEN BdmDedCode = 'VIS' THEN 'EyeMed Vision Care'
                        END
    INTO dbo.U_EDISCTEST_drvTbl_QBDEPENDENTPLANINITIAL
    FROM dbo.U_EDISCTEST_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EDISCTEST WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRunId = 'QB'
        AND BdmDedCode NOT IN ('FSA')
    JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
    WHERE BdmRecType = 'DEP'
        AND ((ConRelationship NOT IN ('SPS', 'DP') AND BdmCobraReason NOT IN ('201', 'LEVNT3'))
            OR (ConRelationship IN ('SPS', 'DP') AND BdmCobraReason NOT IN ('210', '204', 'LEVNT4')))
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EDISCTEST_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL
    ---------------------------------
    IF OBJECT_ID('U_EDISCTEST_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCTEST_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '1 ' + xEEID + ' 6'
        -- standard fields above and additional driver fields below
        ,drvFieldHeader = '[QBPLANMEMBERSPECIFICRATEINITIAL]'
        ,drvPlanName = CASE WHEN BdmDedCode = 'FSA' THEN 'DBI FSA' END
        ,drvRate =FORMAT(CASE WHEN BdmDedCode = 'FSA' THEN BdmEEAmt END, '#0.00')
    INTO dbo.U_EDISCTEST_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL
    FROM dbo.U_EDISCTEST_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EDISCTEST WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRunId = 'QB'
        AND BdmDedCode IN ('FSA')
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EDISCTEST_drvTbl_NPM
    ---------------------------------
    IF OBJECT_ID('U_EDISCTEST_drvTbl_NPM','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCTEST_drvTbl_NPM;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '2 ' + xEEID 
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvNameLast = EepNameLast
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvSex = CASE WHEN EepGender IN ('M','F') THEN EepGender ELSE 'U' END
        ,drvHireDate = EecDateOfLastHire
    INTO dbo.U_EDISCTEST_drvTbl_NPM
    FROM dbo.U_EDISCTEST_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EDISCTEST WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRunId = 'NPM'
        AND BdmRelationship IN ('Emp','SPS','DP')
    --WHERE BdmBenStartDate BETWEEN @StartDate AND @EndDate    
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCde,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCde,'Testing') = 'Y' THEN 'Test_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'OE_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = @FormatCde;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEDISCTEST_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EDISCTEST_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EDISCTEST%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202106291'
       ,expStartPerControl     = '202106291'
       ,expLastEndPerControl   = '202107309'
       ,expEndPerControl       = '202107309'
WHERE expFormatCode = 'EDISCTEST'
AND ExpExportCode = 'TEST_XOE'
;

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEDISCTEST_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EDISCTEST_File (NOLOCK)
    ORDER BY  InitialSort, SubSort;

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EDISCTEST' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EDISCTEST'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EDISCTEST'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EDISCTEST', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EDISCTEST', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EDISCTEST', 'UseFileName', 'V', 'Y'


-- End ripout