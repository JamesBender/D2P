/**********************************************************************************

ENAT401TES: NationWide 401k Census TEST

FormatCode:     ENAT401TES
Project:        NationWide 401k Census TEST
Client ID:      LEE1002
Date/time:      2021-12-16 10:31:53.840
Ripout version: 7.4
Export Type:    Web
Status:         Production
Environment:    NWP
Server:         NW1WUP1DB01
Database:       ULTIPRO_WPLEEC
Web Filename:   LEE1002_MV3A4_EEHISTORY_ENAT401TES_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ENAT401TES_SavePath') IS NOT NULL DROP TABLE dbo.U_ENAT401TES_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ENAT401TES'


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
WHERE FormatCode = 'ENAT401TES'
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
WHERE ExpFormatCode = 'ENAT401TES'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ENAT401TES')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ENAT401TES'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ENAT401TES'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ENAT401TES'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ENAT401TES'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ENAT401TES'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ENAT401TES'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ENAT401TES'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ENAT401TES'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ENAT401TES'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwENAT401TES_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwENAT401TES_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ENAT401TES') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ENAT401TES];
GO
IF OBJECT_ID('U_ENAT401TES_File') IS NOT NULL DROP TABLE [dbo].[U_ENAT401TES_File];
GO
IF OBJECT_ID('U_ENAT401TES_EEList') IS NOT NULL DROP TABLE [dbo].[U_ENAT401TES_EEList];
GO
IF OBJECT_ID('U_ENAT401TES_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ENAT401TES_AuditFields];
GO
IF OBJECT_ID('U_ENAT401TES_Audit') IS NOT NULL DROP TABLE [dbo].[U_ENAT401TES_Audit];
GO
IF OBJECT_ID('U_dsi_ENAT401TES_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_dsi_ENAT401TES_drvTbl];
GO
IF OBJECT_ID('U_dsi_ENAT401TES_DedHist') IS NOT NULL DROP TABLE [dbo].[U_dsi_ENAT401TES_DedHist];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0',NULL,NULL,'N',NULL,'N',NULL,'013010','EMPEXPORT','CDE','ENAT401TES','NationWide 401k Census TEST','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','ENAT401TESZ0','N','Dec  4 2014 10:56AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ENAT401TESZ0','6','D','01','1',NULL,'',NULL,NULL,'"drvTransType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ENAT401TESZ0','1','D','01','7',NULL,'',NULL,NULL,'"drvLineofBusiness"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ENAT401TESZ0','9','D','01','8',NULL,'',NULL,NULL,'"drvNationwideCaseNumber"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ENAT401TESZ0','8','D','01','17',NULL,NULL,NULL,NULL,'"drvEffDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ENAT401TESZ0','9','D','01','25',NULL,'',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ENAT401TESZ0','20','D','01','34',NULL,'',NULL,NULL,'"drvLname"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ENAT401TESZ0','15','D','01','54',NULL,'',NULL,NULL,'"drvFname"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ENAT401TESZ0','32','D','01','69',NULL,'',NULL,NULL,'"drvAddressLine1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ENAT401TESZ0','32','D','01','101',NULL,'',NULL,NULL,'"drvAddressLine2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ENAT401TESZ0','32','D','01','133',NULL,'',NULL,NULL,'"drvAddressLine3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ENAT401TESZ0','32','D','01','165',NULL,'',NULL,NULL,'"drvAddressLine4"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ENAT401TESZ0','32','D','01','197',NULL,'',NULL,NULL,'"drvCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ENAT401TESZ0','2','D','01','229',NULL,'',NULL,NULL,'"drvState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ENAT401TESZ0','5','D','01','231',NULL,'',NULL,NULL,'"drvZip"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ENAT401TESZ0','4','D','01','236',NULL,'',NULL,NULL,'"drvZipCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ENAT401TESZ0','8','D','01','240',NULL,'',NULL,NULL,'"drvDOH"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ENAT401TESZ0','8','D','01','248',NULL,'',NULL,NULL,'"drvDOT"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ENAT401TESZ0','8','D','01','256',NULL,'',NULL,NULL,'"drvDateofPlanEntry"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ENAT401TESZ0','8','D','01','264',NULL,'',NULL,NULL,'"drvDOB"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ENAT401TESZ0','1','D','01','272',NULL,'',NULL,NULL,'"drvGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ENAT401TESZ0','1','D','01','273',NULL,'',NULL,NULL,'"drvMaritalStatus"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ENAT401TESZ0','100','D','01','274',NULL,NULL,NULL,NULL,'"drvEmail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ENAT401TESZ0','12','D','01','374',NULL,NULL,NULL,NULL,'"drvEmployeeID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ENAT401TESZ0','20','D','01','386',NULL,NULL,NULL,NULL,'"drvDiviisonCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ENAT401TESZ0','12','D','01','406',NULL,NULL,NULL,NULL,'"drvGrossAnnualSalary"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ENAT401TESZ0','8','D','01','418',NULL,NULL,NULL,NULL,'"drvRehireDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ENAT401TESZ0','1','D','01','426',NULL,NULL,NULL,NULL,'"drvAutoEnrollmentStatus"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ENAT401TESZ0','8','D','01','427',NULL,NULL,NULL,NULL,'"drvAutoEnrollmentDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ENAT401TESZ0','6','D','01','435',NULL,NULL,NULL,NULL,'"drvPreTaxDeferral"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ENAT401TESZ0','6','D','01','441',NULL,NULL,NULL,NULL,'"drvRothDeferralPercentageElection"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ENAT401TESZ0','10','D','01','447',NULL,NULL,NULL,NULL,'"drvPreTaxDollarElection"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ENAT401TESZ0','10','D','01','457',NULL,NULL,NULL,NULL,'"drvRothDollarElection"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ENAT401TESZ0','10','D','01','467',NULL,NULL,NULL,NULL,'"drvPhoneNumber"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ENAT401TESZ0','10','D','01','477',NULL,NULL,NULL,NULL,'"drvFaxNumber"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ENAT401TESZ0','2','D','01','487',NULL,NULL,NULL,NULL,'"drvRelationshipToOwner"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ENAT401TESZ0','9','D','01','489',NULL,NULL,NULL,NULL,'"drvRelatedOwnerSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ENAT401TESZ0','1','D','01','498',NULL,NULL,NULL,NULL,'"drvEmpType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ENAT401TESZ0','8','D','01','499',NULL,NULL,NULL,NULL,'"drvDoD"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ENAT401TES_20211216.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'ACTIVE OE','201507159','EMPEXPORT','ACTIVEOE','Jul 17 2015 12:00AM','ENAT401TES',NULL,NULL,NULL,'201507159','Jul 15 2015 12:00AM','Dec 30 1899 12:00AM','201507151',NULL,'','','201507151',dbo.fn_GetTimedKey(),NULL,'ULTI_WPPIINC',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N','KZ21X',NULL,NULL,NULL,'NATIONWIDE CENSUS','201705249','EMPEXPORT','ENAT401TES','May 24 2017 12:00AM','ENAT401TES',NULL,NULL,NULL,'202110129','May 24 2017 12:00AM','Dec 30 1899 12:00AM','202110051','442','','','201705101',dbo.fn_GetTimedKey(),NULL,'ULTI_WPPIINC',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'PASSIVE OE','201505201','EMPEXPORT','PASSIVEOE','May 20 2015 12:00AM','ENAT401TES',NULL,NULL,NULL,'201505201','May 20 2015 12:00AM','Dec 30 1899 12:00AM','201505201',NULL,'','','201505201',dbo.fn_GetTimedKey(),NULL,'ULTI_WPPIINC',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'NATIONWIDE - CENSUS TEST','202112179','EMPEXPORT','TEST','Dec 15 2021  3:42PM','ENAT401TES',NULL,NULL,NULL,'202112179','Dec 17 2021 12:00AM','Dec 30 1899 12:00AM','202112031','614','','','202112031',dbo.fn_GetTimedKey(),NULL,'us3jReLEE1002',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'unlock ENAT401TES','201412049','EMPEXPORT','ZAP',NULL,'ENAT401TES',NULL,NULL,NULL,'201412049',NULL,NULL,'201409051',NULL,NULL,NULL,'201409051',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENAT401TES','CountFilter','C',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENAT401TES','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENAT401TES','ExportDescription','C','NATIONWIDE - CENSUS');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENAT401TES','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENAT401TES','InitialSort','C','drveeid');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENAT401TES','MaxFileLength','C','545');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENAT401TES','SubSort','C',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENAT401TES','SystemID','V','AECRQZ0030K0');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENAT401TES','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENAT401TES','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENAT401TES','UseAudit','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENAT401TES','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENAT401TES','D01','dbo.U_dsi_ENAT401TES_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_ENAT401TES_DedHist
-----------

IF OBJECT_ID('U_dsi_ENAT401TES_DedHist') IS NULL
CREATE TABLE [dbo].[U_dsi_ENAT401TES_DedHist] (
    [heeid] char(12) NULL,
    [hcoid] char(5) NULL,
    [hdedcode] char(5) NOT NULL,
    [pdheecalcrateorpct] decimal NULL,
    [heecalcrateorpct] decimal NULL,
    [heeamt] money NULL,
    [heramt] money NULL,
    [PdhPayDate] datetime NULL
);

-----------
-- Create table U_dsi_ENAT401TES_drvTbl
-----------

IF OBJECT_ID('U_dsi_ENAT401TES_drvTbl') IS NULL
CREATE TABLE [dbo].[U_dsi_ENAT401TES_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvcoid] char(5) NULL,
    [drvdepid] varchar(30) NULL,
    [drvrectype] varchar(1) NOT NULL,
    [drvTransType] varchar(6) NOT NULL,
    [drvLineofBusiness] varchar(1) NOT NULL,
    [drvNationwideCaseNumber] varchar(9) NOT NULL,
    [drvEffDate] char(8) NULL,
    [drvSSN] char(11) NULL,
    [drvLname] varchar(8000) NULL,
    [drvFname] varchar(8000) NULL,
    [drvAddressLine1] varchar(6000) NULL,
    [drvAddressLine2] varchar(6000) NULL,
    [drvAddressLine3] varchar(6000) NULL,
    [drvAddressLine4] varchar(6000) NULL,
    [drvCity] varchar(6000) NULL,
    [drvState] varchar(255) NULL,
    [drvZip] varchar(5) NULL,
    [drvZipCode] varchar(4) NULL,
    [drvDOH] char(8) NULL,
    [drvDOT] varchar(30) NOT NULL,
    [drvDateofPlanEntry] varchar(1) NOT NULL,
    [drvDOB] char(8) NULL,
    [drvGender] char(1) NULL,
    [drvMaritalStatus] char(1) NULL,
    [drvEmail] varchar(50) NULL,
    [drvEmployeeID] char(9) NULL,
    [drvDiviisonCode] varchar(1) NOT NULL,
    [drvGrossAnnualSalary] money NULL,
    [drvRehireDate] varchar(8) NULL,
    [drvAutoEnrollmentStatus] varchar(1) NOT NULL,
    [drvAutoEnrollmentDate] varchar(1) NOT NULL,
    [drvPreTaxDeferral] varchar(30) NULL,
    [drvRothDeferralPercentageElection] varchar(30) NULL,
    [drvPreTaxDollarElection] varchar(1) NOT NULL,
    [drvRothDollarElection] varchar(1) NOT NULL,
    [drvPhoneNumber] varchar(50) NULL,
    [drvFaxNumber] varchar(1) NOT NULL,
    [drvRelationshipToOwner] varchar(1) NOT NULL,
    [drvRelatedOwnerSSN] varchar(1) NOT NULL,
    [drvEmpType] char(1) NULL,
    [drvDoD] varchar(1) NOT NULL
);

-----------
-- Create table U_ENAT401TES_Audit
-----------

IF OBJECT_ID('U_ENAT401TES_Audit') IS NULL
CREATE TABLE [dbo].[U_ENAT401TES_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audKey2] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] varchar(2000) NULL,
    [audNewValue] varchar(2000) NULL,
    [audRowNo] bigint NULL,
    [audNewHire] varchar(1) NOT NULL,
    [audReHire] varchar(1) NOT NULL,
    [audTerm] varchar(1) NOT NULL,
    [audSalaryChange] varchar(1) NOT NULL,
    [audLastTermDate] varchar(1) NOT NULL
);

-----------
-- Create table U_ENAT401TES_AuditFields
-----------

IF OBJECT_ID('U_ENAT401TES_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ENAT401TES_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_ENAT401TES_EEList
-----------

IF OBJECT_ID('U_ENAT401TES_EEList') IS NULL
CREATE TABLE [dbo].[U_ENAT401TES_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ENAT401TES_File
-----------

IF OBJECT_ID('U_ENAT401TES_File') IS NULL
CREATE TABLE [dbo].[U_ENAT401TES_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ENAT401TES]
 @systemid varchar(12) = ''
AS
Begin

/**********************************************************************
Client Name:     Lee Contracting, Inc.
Vendor: Nationwide 401k Census File
Created By: Garret Donovan
Business Analyst: Justin Holy
Create Date: 4/23/2018
Service Request Number: LEE1002-2018-00190100-Interface File

Changes:
07/26/2021      A.Stevens        SF 22322133                 commented out logic for drvPreTaxDollarElection, drvRothDollarElection

10/12/2021 by AP:
        - Test version ENAT401TES
        - Updated logic for Service Termination Date

11/04/2021 by AP:
        - Updated pre-tax and roth deferral amounts.

12/16/2021 by AP:
		- 401KR deduction code adjusted. Removed ROTH deduction code from dedcode list.

_dsi_usp_ExportRipout 'ENAT401TES','Y' 

select * from dbo.U_dsi_Configuration where FormatCode = 'ENAT401TES' ORDER BY LEN(CfgName) DESC
select * from dbo.U_dsi_SQLClauses where FormatCode = 'ENAT401TES'
select * from dbo.U_dsi_Parameters where FormatCode = 'ENAT401TES'

select * from AscDefH where AdhFormatCode = 'ENAT401TES'
select * from AscExp where expFormatCode = 'ENAT401TES'
select * from ascdeff where AdfHeaderSystemID = 'ENAT401TESZ0' order by adfrectype, AdfSetNumber, AdfFieldNumber 
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ENAT401TES' ORDER BY RunID DESC;


DSI_SP_TESTSWITCHBOX_V2 'ENAT401TES', 'ENAT401TES'
DSI_SP_TESTSWITCHBOX_V2 'ENAT401TES', 'TEST'
DSI_SP_TESTSWITCHBOX_V2 'ENAT401TES', 'ACTIVEOE'
DSI_SP_TESTSWITCHBOX_V2 'ENAT401TES', 'PASSIVEOE'

To turn off/on TESTEDT header record: 
Update U_Dsi_Configuration set CfgValue = 'N' WHERE FormatCode = 'ENAT401TES' AND CfgName = 'TESTING'

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ENAT401TES', @AllObjects = 'Y', @IsWeb = 'Y'

**************************/

-- Collect the @Start and @End Percontrol/PayDates upfront

    /***************************
    COLLECT DATE PARAMETERS
    ****************************/
    DECLARE 
        @StartDate DATETIME,
        @EndDate DATETIME,
        @StartPerControl Char(9),
        @EndPerControl Char(9),
        @FormatCode Char(10),
        @ExportCode Char(10),
        @ExportFile char(200)

    --    Declare @Systemid char(12) 
    --    set @Systemid = '6DWPQL0000K0'

    SELECT 
        @StartDate = CONVERT(DATETIME, LEFT(StartPerControl, 8) ),
        @EndDate = CONVERT(DATETIME, LEFT(EndPerControl , 8)  ),
        @StartPerControl = startpercontrol,
        @EndPerControl  = endpercontrol,
        @FormatCode = rtrim(formatcode),
        @ExportCode = Exportcode,
        @Exportfile = ExportFile

    FROM dbo.U_Dsi_Parameters 
    WHERE formatcode = 'ENAT401TES'

-- change variables below as needed
declare @daysstopped int   
declare @useaudit char(1)
declare @includeoe char(1)

declare @showalldeds char(1)
declare @allcomp char(1)
declare @onerecperemp char(1)
declare @showstoppedoe  char(1)
declare @oetype char(1)
set @daysstopped = 14    -- set number of days if looking for only showing deds stopped within certain days
set @useaudit = 'Y'    -- Y or N  indicates if this export uses audit to determine data to pull
set @includeoe = 'N'   -- Y or N  indicates if this export will include open enrollment
set @showalldeds = 'N' -- Y or N  indicates if this export shows stopped and active ded of same type
set @allcomp = 'Y'     -- Y or N  indicates if this export pull deds for all companies for an employee
set @onerecperemp = 'Y'  -- Y or N indicate if the export should show only one record per employee
set @showstoppedoe = 'N' -- Y or N  indicates if stopped open enrollment deductions should be shown
set @oetype = 'F'        -- P or F indicates if this export is for a passive or full(active) oe

-- clean up EELIST if needed

-- clean up list if not using all companies
if @allcomp = 'N'
begin
            delete dbo.u_ENAT401TES_EELIST
            from dbo.u_ENAT401TES_EELIST
            join empcomp t with (nolock) on xeeid = eeceeid and xcoid = eeccoid
            where t.eecemplstatus = 'T'
            and exists(select 1 from empcomp a where a.eeceeid = t.eeceeid
                and a.eecemplstatus <> 'T')

end

--Clean Up Prior Year Terms
        delete dbo.u_ENAT401TES_EELIST
            from dbo.u_ENAT401TES_EELIST left join empcomp on xeeid = eeceeid and xcoid = eeccoid
        where eecDateofTermination is not null
            and YEAR(eecDateOfTermination) <> YEAR(getdate())

--BDM
-- replace EROT401NOE with the OE session if applicable

DELETE FROM U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode

INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'DedCodes','401CP,401K,401KR') 

IF @ExportCode not in ( 'ACTIVEOE' ,'PASSIVEOE') BEGIN
    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'StartDateTime',@StartDate)    --@EndDate - @daysstopped)    
    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'EndDateTime',@EndDate)
END

IF @ExportCode in ( 'ACTIVEOE' ,'PASSIVEOE') BEGIN
    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'StartDateTime',@StartDate)
    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'EndDateTime',@EndDate)
END

INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'TermSelectionOption', 'stopdate')    --'ActiveOnly')    --'stoptdate')    --'AuditDate')

IF @ExportCode = 'PASSIVEOE' BEGIN
   INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'Passive')    --'Active')
END

IF @ExportCode = 'ACTIVEOE' BEGIN
   INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'Active')    --'Active')
END

EXEC dbo.dsi_bdm_sp_PopulateDeductionsTable @FormatCode

--- LAstpaydate

--    left join (select eeceeid eeid, eeccoid coid, pgppaydate lastcheck
--                from empcomp
--                join pgpayper on eecpaygroup = pgppaygroup
--                where eecdateoftermination >= pgpperiodstartdate
--                and eecdateoftermination <= pgpperiodenddate) ppd on eeid = xeeid and coid = xcoid

-- Step20 Clean up eelist if needed to only include employees with deductions
--            delete dbo.u_ENAT401TES_eelist
--            from dbo.u_ENAT401TES_eelist a
--            where not exists(select 1 from U_dsi_bdm_EmpDeductions
--                            where a.xeeid = eedeeid
--                            and a.xcoid = eedcoid
--                            and eedformatcode = @formatcode
--                            and eedvalidforexport = 'Y')

-- Clean up eelist if only one record per employee
if @onerecperemp = 'Y'
begin
            delete dbo.u_ENAT401TES_EELIST
            from dbo.u_ENAT401TES_EELIST
            join empcomp t with (nolock) on xeeid = eeceeid and xcoid = eeccoid
            where t.eecemplstatus = 'T'
            and exists(select 1 from empcomp a where a.eeceeid = t.eeceeid
                and a.eecemplstatus <> 'T')

            delete dbo.u_ENAT401TES_eelist
            from dbo.u_ENAT401TES_eelist a
            join emppers with (nolock) on xeeid = eepeeid
            where eephomecoid <> xcoid
            and exists(select 1 from dbo.u_ENAT401TES_eelist b where a.xeeid = b.xeeid
            having count(*) > 1)
end

--Remove test employees from file
            delete dbo.u_ENAT401TES_eelist
            from dbo.u_ENAT401TES_eelist 
            join emppers with (nolock) on xeeid = eepeeid
            where left(eepssn,5) = '99999'

--Clean up Terms from Deductions and EEList
--        delete U_dsi_bdm_EmpDeductions
--            from U_dsi_bdm_EmpDeductions left join empcomp on eedeeid = eeceeid
--        where eedFormatCode = @FormatCode
--            and eedValidForExport = 'Y'
--            and eecDateofTermination is not null
--            and @daysstopped + eecDateofTermination < getdate()
--
--        delete dbo.u_ENAT401TES_eelist
--            from dbo.u_ENAT401TES_eelist left join empcomp on xeeid = eeceeid and xcoid = eeccoid
--        where eecDateofTermination is not null
--            and @daysstopped + eecDateofTermination < getdate()

if object_id('U_dsi_ENAT401TES_DedHist') is not null
  drop table U_dsi_ENAT401TES_DedHist

SELECT
    xEEID heeid,
    xCOID hcoid,
    pdhdedcode hdedcode,
    pdheecalcrateorpct,
    SUM(ISNULL(pdhEECalcRateOrPct,0.00)) as heecalcrateorpct,
    SUM(ISNULL(PDHEECURAMT,0.00)) AS heeamt,
    SUM(ISNULL(PDHERCURAMT,0.00)) AS heramt, PdhPayDate

    INTO dbo.U_dsi_ENAT401TES_DedHist
        from dbo.u_ENAT401TES_EELIST 
    JOIN PDEDHIST (nolock) ON xeeid = PdhEEID and xCOID = PdhCOID
        AND (PDHEECURAMT <> 0 or PDHERCURAMT <> 0)
          AND PDHDEDCODE IN ('401CP','401K','401KR')  
     --   AND PDHDEDCODE IN ('401CP','401K','ROTH')    
--        AND PDHPERCONTROL BETWEEN '20040901' and '20040924'
        AND substring(PDHPERCONTROL,1,8) BETWEEN substring(@StartPerControl,1,8) and substring(@EndPerControl,1,8)
    GROUP BY xEEID,xCOID,PdhDedCode,pdhEECalcRateOrPct, PdhPayDate

---- AUDIT FOR TERM DATE ----
  --==========================================
    -- Audit Section
    --==========================================
 --   -- Get data from audit fields table. Add fields here if auditing
 --   IF OBJECT_ID('U_ENAT401TES_AuditFields','U') IS NOT NULL
 --       DROP TABLE dbo.U_ENAT401TES_AuditFields;
 --   CREATE TABLE dbo.U_ENAT401TES_AuditFields (aTableName varchar(30),aFieldName varchar(30));
 --   INSERT INTO dbo.U_ENAT401TES_AuditFields VALUES ('EmpComp','EecAnnSalary');
 --   INSERT INTO dbo.U_ENAT401TES_AuditFields VALUES ('EmpComp','EecDateOfLastHire');
 --   INSERT INTO dbo.U_ENAT401TES_AuditFields VALUES ('EmpComp','EecDateOfOriginalHire');
 --   INSERT INTO dbo.U_ENAT401TES_AuditFields VALUES ('EmpComp','EecDateOfTermination');
 --   INSERT INTO dbo.U_ENAT401TES_AuditFields VALUES ('EmpComp','EecEmplStatus');
 --   INSERT INTO dbo.U_ENAT401TES_AuditFields VALUES ('EmpComp','EecFullTimeOrPartTime');
 --   INSERT INTO dbo.U_ENAT401TES_AuditFields VALUES ('EmpComp','EecHourlyPayRate');
 --   INSERT INTO dbo.U_ENAT401TES_AuditFields VALUES ('EmpComp','EecSalaryOrHourly');
 --   INSERT INTO dbo.U_ENAT401TES_AuditFields VALUES ('EmpComp','EecScheduledWorkHrs');
 --   INSERT INTO dbo.U_ENAT401TES_AuditFields VALUES ('EmpComp','EecTermReason');
 --   INSERT INTO dbo.U_ENAT401TES_AuditFields VALUES ('EmpDed','EedBenStartDate');
 --   INSERT INTO dbo.U_ENAT401TES_AuditFields VALUES ('EmpDed','EedBenStopDate');
 --   INSERT INTO dbo.U_ENAT401TES_AuditFields VALUES ('EmpPers','EepDateOfBirth');
 --   INSERT INTO dbo.U_ENAT401TES_AuditFields VALUES ('EmpPers','EepGender');
 --   INSERT INTO dbo.U_ENAT401TES_AuditFields VALUES ('EmpPers','EepNameFirst');
 --   INSERT INTO dbo.U_ENAT401TES_AuditFields VALUES ('EmpPers','EepNameLast');
 --   INSERT INTO dbo.U_ENAT401TES_AuditFields VALUES ('EmpPers','EepNameMiddle');
 --   INSERT INTO dbo.U_ENAT401TES_AuditFields VALUES ('EmpPers','EepNameSuffix');
 --   INSERT INTO dbo.U_ENAT401TES_AuditFields VALUES ('EmpPers','EepOldSSN');
 --   INSERT INTO dbo.U_ENAT401TES_AuditFields VALUES ('EmpPers','EepSSN');
    --INSERT INTO dbo.U_ENAT401TES_AuditFields VALUES ('EmpHJob','EjhDateTimeCreated');


 --   -- Create audit table based on fields defined above
 --   IF OBJECT_ID('U_ENAT401TES_Audit','U') IS NOT NULL
 --       DROP TABLE dbo.U_ENAT401TES_Audit;

    --SELECT *, audLastTermDate = CASE WHEN audTerm = 'Y' AND audTableName = 'EmpHJob' AND audFieldName = 'EjhDateTimeCreated' AND ISNULL(audNewValue , '') <> '' THEN 'Y' ELSE 'N' END
    --INTO dbo.U_ENAT401TES_Audit
    --FROM
    --(
 --   SELECT 
 --       audEEID  = audKey1Value
 --       ,audKey2 = audKey2Value
 --       ,audKey3 = audKey3Value
 --       ,audTableName
 --       ,audFieldName
 --       ,audAction
 --       ,audDateTime
 --       ,audOldValue
 --       ,audNewValue
 --       ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
 --       ,audNewHire = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = '' AND ISNULL(audNewValue,'') = 'A' THEN 'Y' ELSE 'N' END
 --       ,audReHire = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = 'T' AND ISNULL(audNewValue,'') = 'A' THEN 'Y' ELSE 'N' END
 --       ,audTerm = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audNewValue,'') = 'T' THEN 'Y' ELSE 'N' END
 --       ,audSalaryChange = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecAnnSalary' AND ISNULL(audNewValue,'') <> '' THEN 'Y' ELSE 'N' END
 --   FROM dbo.U_ENAT401TES_EEList WITH (NOLOCK)
 --   JOIN dbo.vw_AuditData WITH (NOLOCK) 
 --       ON audKey1Value = xEEID
 --   JOIN dbo.U_ENAT401TES_AuditFields WITH (NOLOCK) 
 --       ON audTableName = aTableName
 --       AND audFieldName = aFieldName
 --   WHERE audDateTime BETWEEN @StartDate AND @EndDate
 --   AND audAction <> 'DELETE'
 --   AND ISNULL(audNewValue,'') <> '') a;

--/****Create Table: U_ds_ENAT401TES_EarnsCUR***/

--if object_id('dbo.U_dsi_ENAT401TES_EarnsCUR') is not null
--  drop table dbo.U_dsi_ENAT401TES_EarnsCUR

--SELECT
--    xEEID eeeid,
--    xCOID ecoid,
--    SUM(ISNULL(pehCurAmt,0.00)) AS eamt,
--    SUM(ISNULL(pehCurHrs,0.00)) AS ehrs

--INTO dbo.U_dsi_ENAT401TES_EarnsCUR
--        from dbo.u_ENAT401TES_EELIST 
--    JOIN PEARHIST(nolock) ON xeeid = pehEEID and xCOID = PehCOID
--        AND substring(pehPerControl,1,8) = substring(@EndPerControl,1,8)
--        AND pehInclInDefComp = 'Y'
--    ---    and pehearncode not in ('REGSF' ,'OTSF')
--    GROUP BY xEEID,xCOID

---- YTD Plan compensation
--if object_id('U_dsi_ENAT401TES_DefCompHist') is not null
--  drop table dbo.U_dsi_ENAT401TES_DefCompHist

--SELECT
--    xEEID dceeid,
--    xCOID dccoid,
--    SUM(ISNULL(pehCurAmt,0.00)) AS dcamt
--    --SUM(ISNULL(pehCurHrs,0.00)) AS dchrs

--    INTO dbo.U_dsi_ENAT401TES_DefCompHist
--        from dbo.u_ENAT401TES_EELIST 
--    JOIN PEARHIST (nolock) ON xeeid = pehEEID and xCOID = PehCOID
--        AND substring(pehPerControl,1,4) = substring(@EndPerControl,1,4)
--        AND pehInclInDefComp = 'Y'
--        ---and pehearncode not in ('REGSF' ,'OTSF')
--    GROUP BY xEEID,xCOID

---- YTD hours
--if object_id('U_dsi_ENAT401TES_YTDHrs') is not null
--  drop table dbo.U_dsi_ENAT401TES_YTDHrs

--SELECT
--    xEEID yheeid,
--    xCOID yhcoid,
--    SUM(ISNULL(pehCurHrs,0.00)) AS yhhrs

--    INTO dbo.U_dsi_ENAT401TES_YTDHrs
--        from dbo.u_ENAT401TES_EELIST 
--    JOIN PEARHIST (nolock) ON xeeid = pehEEID and xCOID = PehCOID
--        AND substring(pehPerControl,1,4) = substring(@EndPerControl,1,4)
--        AND pehInclInDefComp = 'Y'
--    --    and pehearncode not in ('REGSF' ,'OTSF')
--    GROUP BY xEEID,xCOID

-----

---- YTD Plan compensation W2
--if object_id('U_dsi_ENAT401TES_DefCompHistW2') is not null
--  drop table dbo.U_dsi_ENAT401TES_DefCompHistW2

--SELECT
--    xEEID dceeid,
--    xCOID dccoid,
--    SUM(ISNULL(pehCurAmt,0.00)) AS dcamt,
--    SUM(ISNULL(pehCurHrs,0.00)) AS dchrs

--    INTO dbo.U_dsi_ENAT401TES_DefCompHistW2
--        from dbo.u_ENAT401TES_EELIST 
--    JOIN PEARHIST (nolock) ON xeeid = pehEEID and xCOID = PehCOID
--        AND substring(pehPerControl,1,4) = substring(@EndPerControl,1,4)
--        ---AND pehInclInDefComp = 'Y'
--    GROUP BY xEEID,xCOID

-- Populate Source for Employees

if object_id('U_dsi_ENAT401TES_drvTbl') is not null
  drop table dbo.U_dsi_ENAT401TES_drvTbl

-- EE Detail

  select distinct
    drvEEID = xEEID, 
    drvcoid = xcoid,
    drvdepid = cast(null as varchar),
    drvrectype = 'E',
-- standard fields above and additional driver fields below

            drvTransType = 'CENSUS',
            drvLineofBusiness  = '1', 
            drvNationwideCaseNumber  = '442-80187',
            drvEffDate  = convert(char(8),GETDATE(),112),
            drvSSN  = eepSSN,
            drvLname  = REPLACE(EepNameLast,',',''),
            drvFname  = REPLACE(EepNameFirst,',',''),
            drvAddressLine1  = dbo.dsi_fnRemoveChars('.,/',EepAddressLine1),
            drvAddressLine2  = dbo.dsi_fnRemoveChars('.,/',EepAddressLine2),
            drvAddressLine3  = dbo.dsi_fnRemoveChars('.,/',EepAddressLine3),
            drvAddressLine4  = dbo.dsi_fnRemoveChars('.,/',EepAddressLine4),
            drvCity  = dbo.dsi_fnRemoveChars('.,/',EepAddressCity),
            drvState  = EepAddressState,
            drvZip  = substring(EepAddressZipCode,1,5),
            drvZipCode  = substring(EepAddressZipCode,6,4),
            drvDOH  = convert(char(8),eecdateoforiginalhire,112),
            drvDOT  = ISNULL(CONVERT(VARCHAR, (CASE WHEN EecEmplStatus IN ('R', 'T') THEN EecDateOfTermination 
                            WHEN EecEmplStatus NOT IN ('R', 'T') AND EecDateOfOriginalHire <> EecDateOfLastHire THEN ejh.EjhJobEffDate END), 112), ''),
            --CASE
   --                         WHEN EecEmplStatus = 'T' THEN convert(char(8),eecdateoftermination,112)
   --                 END,
            drvDateofPlanEntry  = '',
            drvDOB  = convert(char(8),eepdateofbirth,112),
            drvGender  = EepGender,
            drvMaritalStatus  = eepmaritalstatus,
            drvEmail  = case when eepAddressEMail not like '%_@__%.__%' then '' else eepaddressemail end,
            drvEmployeeID  = EecEmpNo,
            drvDiviisonCode  = '',
            drvGrossAnnualSalary  = EecAnnSalary,
            drvRehireDate  = case when eecdateoforiginalhire <  eecdateoflasthire then convert(char(8),EecDateOfLastHire,112) else '' end,
            drvAutoEnrollmentStatus  = '',
            drvAutoEnrollmentDate  = '',--convert(char(8),eepdateofbirth,112),
            drvPreTaxDeferral  = CAST(CAST(CASE WHEN ptax.EedEECalcRateOrPct > '.9999' THEN '99.99' ELSE ptax.EedEECalcRateOrPct * 100 END AS DECIMAL(4,2)) AS VARCHAR),
            --convert(varchar,K.pct),--percentage
            drvRothDeferralPercentageElection  = CAST(CAST(CASE WHEN rdef.EedEECalcRateOrPct > '.9999' THEN '99.99' ELSE rdef.EedEECalcRateOrPct * 100 END AS DECIMAL(4,2)) AS VARCHAR) ,
            --convert(varchar,RF.pct), --percentage
            drvPreTaxDollarElection  = '',--convert(varchar,K.eeamt),-- dollar A.S. 07/26/21
            drvRothDollarElection  = '',--convert(varchar,RF.eeamt),--dollar A.S. 07/26/21
            drvPhoneNumber  = EepPhoneHomeNumber,
            drvFaxNumber  = '',
            drvRelationshipToOwner  = '',
            drvRelatedOwnerSSN  = '',
            drvEmpType  = EecSalaryOrHourly,
            drvDoD  = ''--convert(char(8),eepdateofbirth,112)

  into dbo.U_dsi_ENAT401TES_drvTbl
  from dbo.u_ENAT401TES_eelist with (nolock)
    join empPers with (nolock) on xEEID = eepEEID
    join empcomp with (nolock) on xEEID = eecEEid and xCOID = eecCOID 
    --left join (select eeeid, ecoid, eamt, ehrs from dbo.U_dsi_ENAT401TES_EarnsCUR) earn on earn.eeeid = xEEID and earn.ecoid = xCOID
    --left join dbo.U_dsi_ENAT401TES_DefCompHist D on D.dceeid = xeeid and D.dccoid = xcoid
    --left join dbo.U_dsi_ENAT401TES_EarnsCUR C on C.eeeid = xeeid and C.ecoid = xcoid
    --join dbo.U_dsi_ENAT401TES_DefCompHist W2 on W2.dceeid = xeeid and W2.dccoid = xcoid
    --left join dbo.U_dsi_ENAT401TES_YTDHrs YH on yh.yheeid = xEEID and yh.yhcoid = xCOID
    --left join U_dsi_ENAT401TES_DedHist dh on dh.heeid = xEEID and dh.hcoid = xCOID

--('401CF','401CP','401F','401P','401M','401RF','401RP','40CFR','40CPR' ,'401L','401L2')    

--401K Contribution    
    left join(select heeid eeid, hcoid coid, pdheecalcrateorpct, sum(heeamt) eeamt, sum(heramt) eramt, sum(heecalcrateorpct) pct
        from dbo.U_dsi_ENAT401TES_DedHist
        where hdedcode in ('401K','401CP')
        group by heeid, hcoid, pdheecalcrateorpct) K on K.eeid = xEEID and K.coid = xCOID



--Roth
    left join(select heeid eeid, hcoid coid, PdhEECalcRateOrPct, sum(heeamt) eeamt, sum(heramt) eramt, sum(heecalcrateorpct) pct
        from dbo.U_dsi_ENAT401TES_DedHist
        where hdedcode in ('401KR')
        group by heeid, hcoid, PdhEECalcRateOrPct) RF on RF.eeid = xEEID and RF.coid = xCOID
    left join (select EjhEEID, EjhCOID, MAX(EjhJobEffDate) AS EjhJobEffDate
                from dbo.EmpHJob WITH(NOLOCK)
                where ejhemplstatus = 't'
                GROUP BY EjhEEID, EjhCOID) ejh on ejh.ejheeid = xeeid and ejh.ejhcoid = xcoid

    LEFT JOIN (SELECT EedEEID, EedCOID, SUM(EedEECalcRateOrPct) AS EedEECalcRateOrPct
                FROM dbo.U_dsi_bdm_EmpDeductions WITH(NOLOCK)
                WHERE EedDedCode IN ('401CP', '401K')
                AND EedFormatCode = @FormatCode
                AND EedValidForExport = 'Y'
                GROUP BY EedEEID, EedCOID) ptax ON ptax.EedEEID = xEEID AND ptax.EedCOID = xCOID

    LEFT JOIN (SELECT EedEEID, EedCOID, SUM(EedEECalcRateOrPct) AS EedEECalcRateOrPct
                FROM dbo.U_dsi_bdm_EmpDeductions WITH(NOLOCK)
                WHERE EedDedCode IN ('401KR')
                AND EedFormatCode = @FormatCode
                AND EedValidForExport = 'Y'
                GROUP BY EedEEID, EedCOID) rdef ON rdef.EedEEID = xEEID AND rdef.EedCOID = xCOID


    --LEFT JOIN (SELECT audEEID, audKey2 AS audCOID, MAX(audDateTime) AS audDateTime
    --            FROM dbo.U_ENAT401TES_Audit
    --            WHERE audTerm = 'Y'
    --            GROUP BY audEEID, audKey2) aud ON aud.audEEID = xEEID AND aud.audCOID = xCOID

----Roth catch up
--    left join(select heeid eeid, hcoid coid, sum(heeamt) eeamt, sum(heramt) eramt, sum(heecalcrateorpct) pct
--        from dbo.U_dsi_ENAT401TES_DedHist
--        where hdedcode in ('XXXXX')
--        group by heeid, hcoid) RP on RP.eeid = xEEID and RP.coid = xCOID


 ---Set FileName  
if (dbo.dsi_fnVariable('ENAT401TES','UseFileName') = 'N')
  update dbo.U_dsi_Parameters
    set ExportFile =  'ENAT401TES' + convert(char(8),getdate(),112) + '.txt'
    where FormatCode = 'ENAT401TES'

--select distinct eecishighlycomp from empcomp

-- Remember to alter view for correct sorting
/*
 ALTER  View dbo.dsi_vwENAT401TES_Export as
       select top 2000000 left(data,(len(data))) as data from dbo.U_ENAT401TES_File with (nolock)
         order by case when substring(Recordset,1,1) = 'H' then 1 else 2 end,
            initialsort, subsort, substring(Recordset,2,2)
*/

--Used for testing
--dbo.dsi_sp_TestSwitchbox 'ENAT401TES','ENAT401TES'
--dbo.dsi_sp_TestSwitchbox_v2 'ENAT401TES','TEST'
--dbo.dsi_sp_TestSwitchbox 'ENAT401TES','zap'

END

--select * from pdedhist
--select * from empded
GO
Create View dbo.dsi_vwENAT401TES_Export as
                            select top 200000000 Data from dbo.U_ENAT401TES_File with (nolock)
                            order by substring(RecordSet,2,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ENAT401TES' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ENAT401TES'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ENAT401TES'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ENAT401TES', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ENAT401TES', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ENAT401TES', 'UseFileName', 'V', 'Y'


-- End ripout