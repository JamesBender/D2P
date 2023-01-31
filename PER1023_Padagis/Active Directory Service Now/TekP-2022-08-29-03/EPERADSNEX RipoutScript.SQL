/**********************************************************************************

EPERADSNEX: Active Directory ServiceNow Export

FormatCode:     EPERADSNEX
Project:        Active Directory ServiceNow Export
Client ID:      PER1023
Date/time:      2023-01-31 17:33:53.920
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW3WUP2DB04
Database:       ULTIPRO_WPPEPHA
Web Filename:   PER1023_E2MZN_EEHISTORY_EPERADSNEX_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EPERADSNEX_SavePath') IS NOT NULL DROP TABLE dbo.U_EPERADSNEX_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EPERADSNEX'


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
WHERE FormatCode = 'EPERADSNEX'
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
WHERE ExpFormatCode = 'EPERADSNEX'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EPERADSNEX')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EPERADSNEX'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EPERADSNEX'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EPERADSNEX'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EPERADSNEX'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EPERADSNEX'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EPERADSNEX'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EPERADSNEX'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EPERADSNEX'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EPERADSNEX'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEPERADSNEX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEPERADSNEX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EPERADSNEX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EPERADSNEX];
GO
IF OBJECT_ID('U_EPERADSNEX_Header') IS NOT NULL DROP TABLE [dbo].[U_EPERADSNEX_Header];
GO
IF OBJECT_ID('U_EPERADSNEX_File') IS NOT NULL DROP TABLE [dbo].[U_EPERADSNEX_File];
GO
IF OBJECT_ID('U_EPERADSNEX_EEList') IS NOT NULL DROP TABLE [dbo].[U_EPERADSNEX_EEList];
GO
IF OBJECT_ID('U_EPERADSNEX_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EPERADSNEX_drvTbl];
GO
IF OBJECT_ID('U_EPERADSNEX_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EPERADSNEX_AuditFields];
GO
IF OBJECT_ID('U_EPERADSNEX_Audit') IS NOT NULL DROP TABLE [dbo].[U_EPERADSNEX_Audit];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EPERADSNEX','Active Directory ServiceNow Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','EPERADSNEXZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPERADSNEXZ0','50','H','01','1',NULL,'CN',NULL,NULL,'"CN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPERADSNEXZ0','50','H','01','2',NULL,'Company',NULL,NULL,'"Company"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPERADSNEXZ0','50','H','01','3',NULL,'Country',NULL,NULL,'"Country"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPERADSNEXZ0','50','H','01','4',NULL,'countryCode',NULL,NULL,'"countryCode"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPERADSNEXZ0','50','H','01','5',NULL,'Department',NULL,NULL,'"Department"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPERADSNEXZ0','50','H','01','6',NULL,'Description',NULL,NULL,'"Description"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPERADSNEXZ0','50','H','01','7',NULL,'DisplayName',NULL,NULL,'"DisplayName"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPERADSNEXZ0','50','H','01','8',NULL,'EmailAddress',NULL,NULL,'"EmailAddress"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPERADSNEXZ0','50','H','01','9',NULL,'EmployeeID',NULL,NULL,'"EmployeeID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPERADSNEXZ0','50','H','01','10',NULL,'EmployeeNumber',NULL,NULL,'"EmployeeNumber"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPERADSNEXZ0','50','H','01','11',NULL,'GivenName',NULL,NULL,'"GivenName"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EPERADSNEXZ0','50','H','01','12',NULL,'HomePhone',NULL,NULL,'"HomePhone"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EPERADSNEXZ0','50','H','01','13',NULL,'Manager',NULL,NULL,'"Manager"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EPERADSNEXZ0','50','H','01','14',NULL,'MobilePhone',NULL,NULL,'"MobilePhone"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EPERADSNEXZ0','50','H','01','15',NULL,'OfficePhone',NULL,NULL,'"OfficePhone"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EPERADSNEXZ0','50','H','01','16',NULL,'PostalCode',NULL,NULL,'"PostalCode"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EPERADSNEXZ0','50','H','01','17',NULL,'State',NULL,NULL,'"State"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EPERADSNEXZ0','50','H','01','18',NULL,'StreetAddress',NULL,NULL,'"StreetAddress"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EPERADSNEXZ0','50','H','01','19',NULL,'Title',NULL,NULL,'"Title"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EPERADSNEXZ0','50','H','01','20',NULL,'Pager',NULL,NULL,'"Pager"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPERADSNEXZ0','50','D','10','1',NULL,'CN',NULL,NULL,'"drvCN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPERADSNEXZ0','50','D','10','2',NULL,'Company',NULL,NULL,'"drvCompany"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPERADSNEXZ0','50','D','10','3',NULL,'Country',NULL,NULL,'"drvCountry"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPERADSNEXZ0','50','D','10','4',NULL,'countryCode',NULL,NULL,'"drvcountryCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPERADSNEXZ0','50','D','10','5',NULL,'Department',NULL,NULL,'"drvDepartment"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPERADSNEXZ0','50','D','10','6',NULL,'Description',NULL,NULL,'"drvDescription"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPERADSNEXZ0','50','D','10','7',NULL,'DisplayName',NULL,NULL,'"drvDisplayName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPERADSNEXZ0','50','D','10','8',NULL,'EmailAddress',NULL,NULL,'"drvEmailAddress"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPERADSNEXZ0','50','D','10','9',NULL,'EmployeeID',NULL,NULL,'"drvEmployeeID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPERADSNEXZ0','50','D','10','10',NULL,'EmployeeNumber',NULL,NULL,'"drvEmployeeNumber"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPERADSNEXZ0','50','D','10','11',NULL,'GivenName',NULL,NULL,'"drvGivenName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EPERADSNEXZ0','50','D','10','12',NULL,'HomePhone',NULL,NULL,'"drvHomePhone"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EPERADSNEXZ0','50','D','10','13',NULL,'Manager',NULL,NULL,'"drvManager"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EPERADSNEXZ0','50','D','10','14',NULL,'MobilePhone',NULL,NULL,'"drvMobilePhone"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EPERADSNEXZ0','50','D','10','15',NULL,'OfficePhone',NULL,NULL,'"drvOfficePhone"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EPERADSNEXZ0','50','D','10','16',NULL,'PostalCode',NULL,NULL,'"drvPostalCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EPERADSNEXZ0','50','D','10','17',NULL,'State',NULL,NULL,'"drvState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EPERADSNEXZ0','50','D','10','18',NULL,'StreetAddress',NULL,NULL,'"drvStreetAddress"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EPERADSNEXZ0','50','D','10','19',NULL,'Title',NULL,NULL,'"drvTitle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EPERADSNEXZ0','50','D','10','20',NULL,'Pager',NULL,NULL,'"drvPager"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EPERADSNEX_20230131.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Active Directory-FullFile','202212229','EMPEXPORT','FULLFILE','Jan 31 2023 12:00AM','EPERADSNEX',NULL,NULL,NULL,'202212229','Dec 22 2022 12:00AM','Dec 30 1899 12:00AM','202212151',NULL,'',NULL,'202212151',dbo.fn_GetTimedKey(),NULL,'us3mWaPER1023',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Directory ServiceNow Ex','202212219','EMPEXPORT','ONDEM_XOE',NULL,'EPERADSNEX',NULL,NULL,NULL,'202212219','Dec  2 2022  2:05PM','Dec  2 2022  2:05PM','202211251',NULL,'','','202211251',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Directory Service-Sched','202212219','EMPEXPORT','SCH_EPERAD',NULL,'EPERADSNEX',NULL,NULL,NULL,'202212219','Dec  2 2022  2:05PM','Dec  2 2022  2:05PM','202211251',NULL,'','','202211251',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Active Directory Service-Test','202212229','EMPEXPORT','TEST_XOE','Dec 22 2022 12:00AM','EPERADSNEX',NULL,NULL,NULL,'202212229','Dec 22 2022 12:00AM','Dec 30 1899 12:00AM','202212151',NULL,'','','202212151',dbo.fn_GetTimedKey(),NULL,'us3kEpPER1023',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPERADSNEX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPERADSNEX','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPERADSNEX','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPERADSNEX','SubSort','C','drvSubsort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPERADSNEX','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPERADSNEX','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPERADSNEX','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPERADSNEX','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPERADSNEX','D10','dbo.U_EPERADSNEX_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPERADSNEX','T90','dbo.U_EPERADSNEX_Trailer',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EPERADSNEX_Audit
-----------

IF OBJECT_ID('U_EPERADSNEX_Audit') IS NULL
CREATE TABLE [dbo].[U_EPERADSNEX_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audKey2] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] nvarchar(2000) NULL,
    [audNewValue] nvarchar(2000) NULL,
    [audChangeType] varchar(11) NOT NULL,
    [audRowNo] bigint NULL
);

-----------
-- Create table U_EPERADSNEX_AuditFields
-----------

IF OBJECT_ID('U_EPERADSNEX_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EPERADSNEX_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EPERADSNEX_drvTbl
-----------

IF OBJECT_ID('U_EPERADSNEX_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EPERADSNEX_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(9) NULL,
    [drvSubsort] varchar(1) NOT NULL,
    [drvCN] varchar(6000) NULL,
    [drvCompany] varchar(7) NOT NULL,
    [drvCountry] varchar(13) NOT NULL,
    [drvcountryCode] varchar(1) NOT NULL,
    [drvDepartment] varchar(6000) NULL,
    [drvDescription] varchar(25) NOT NULL,
    [drvDisplayName] varchar(6000) NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvEmployeeID] char(9) NULL,
    [drvEmployeeNumber] char(9) NULL,
    [drvGivenName] varchar(100) NULL,
    [drvHomePhone] varchar(50) NULL,
    [drvManager] varchar(6000) NULL,
    [drvMobilePhone] varchar(50) NULL,
    [drvOfficePhone] varchar(50) NULL,
    [drvPostalCode] varchar(50) NULL,
    [drvState] varchar(255) NULL,
    [drvStreetAddress] varchar(6000) NULL,
    [drvTitle] varchar(6000) NULL,
    [drvPager] varchar(6000) NULL
);

-----------
-- Create table U_EPERADSNEX_EEList
-----------

IF OBJECT_ID('U_EPERADSNEX_EEList') IS NULL
CREATE TABLE [dbo].[U_EPERADSNEX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EPERADSNEX_File
-----------

IF OBJECT_ID('U_EPERADSNEX_File') IS NULL
CREATE TABLE [dbo].[U_EPERADSNEX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);

-----------
-- Create table U_EPERADSNEX_Header
-----------

IF OBJECT_ID('U_EPERADSNEX_Header') IS NULL
CREATE TABLE [dbo].[U_EPERADSNEX_Header] (
    [drvCN] varchar(1) NOT NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EPERADSNEX]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Padagis US LLC

Created By: Marie Waters
Business Analyst: Kim Ephraim
Create Date: 12/02/2022
Service Request Number: TekP-2022-08-29-03

Purpose: Active Directory ServiceNow Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EPERADSNEX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EPERADSNEX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EPERADSNEX';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EPERADSNEX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EPERADSNEX' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPERADSNEX', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPERADSNEX', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPERADSNEX', 'SCH_EPERAD';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPERADSNEX', 'FULLFILE';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EPERADSNEX', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EPERADSNEX';

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
    DELETE FROM dbo.U_EPERADSNEX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EPERADSNEX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EPERADSNEX_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EPERADSNEX_AuditFields;
    CREATE TABLE dbo.U_EPERADSNEX_AuditFields (aTableName varchar(30),aFieldName varchar(30));
     INSERT INTO dbo.U_EPERADSNEX_AuditFields VALUES ('EmpComp','EecEmplStatus');
     INSERT INTO dbo.U_EPERADSNEX_AuditFields VALUES ('EmpComp','EecOrgLvl1');
     INSERT INTO dbo.U_EPERADSNEX_AuditFields VALUES ('EmpComp','EecOrgLvl2');
     INSERT INTO dbo.U_EPERADSNEX_AuditFields VALUES ('EmpComp','EecJobCode');
     INSERT INTO dbo.U_EPERADSNEX_AuditFields VALUES ('EmpPers','EepNameFirst');
     INSERT INTO dbo.U_EPERADSNEX_AuditFields VALUES ('EmpPers','EepNameLast');

     INSERT INTO dbo.U_EPERADSNEX_AuditFields VALUES ('EmpPers','EepAddressEMail');
     INSERT INTO dbo.U_EPERADSNEX_AuditFields VALUES ('EmpComp','EecPhoneBusinessNumber');
     INSERT INTO dbo.U_EPERADSNEX_AuditFields VALUES ('EmpComp','EecCOID');
     INSERT INTO dbo.U_EPERADSNEX_AuditFields VALUES ('EmpComp','EecLocation');
     INSERT INTO dbo.U_EPERADSNEX_AuditFields VALUES ('EmpComp','EecEEType'); 
     INSERT INTO dbo.U_EPERADSNEX_AuditFields VALUES ('EmpMPhon','EfoPhoneNumber');
     
    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EPERADSNEX_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EPERADSNEX_Audit;
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
        ,audChangeType = CASE WHEN audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = '' AND ISNULL(audNewValue,'') = 'A' THEN 'NewHire'
                              WHEN audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = 'T' AND ISNULL(audNewValue,'') = 'A' THEN 'Rehire'
                              WHEN audFieldName = 'EecEmplStatus' AND ISNULL(audNewValue,'') = 'T' THEN 'Term'
                              WHEN audFieldName = 'EecJobCode' AND ISNULL(audNewValue,'') <> '' THEN 'JobCode'
                              WHEN audFieldName = 'EepNameFirst' AND ISNULL(audOldValue,'') <> '' AND ISNULL(audNewValue,'') <> '' THEN 'FirstName'
                              WHEN audFieldName = 'EepNameLast' AND ISNULL(audOldValue,'') <> '' AND ISNULL(audNewValue,'') <> '' THEN 'LastName'
                              WHEN audFieldName IN ('EecEEType','EecCOID','EecLocation','EecDateOfRetirement') AND ISNULL(audNewValue,'') <> '' THEN 'Transfer'
                              WHEN audFieldName In ('EfoPhoneNumber', 'EecPhoneBusinessNumber' )  AND ISNULL(audOldValue,'') <> ISNULL(audNewValue,'') THEN 'PhoneChange'
                              ELSE ''
                        END
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    INTO dbo.U_EPERADSNEX_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EPERADSNEX_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EPERADSNEX_Audit ON dbo.U_EPERADSNEX_Audit (audEEID,audKey2);

    ----================
    ---- Changes Only
    ----================
       IF (@Exportcode NOT IN ('FULLFILE'))
    BEGIN
            -- Remove Employees with No Changes in Audit
        DELETE FROM dbo.U_EPERADSNEX_EELIST
        WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EPERADSNEX_Audit WHERE audEEID = xEEID AND audRowNo = 1);
     END;

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EPERADSNEX_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EPERADSNEX_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EPERADSNEX_drvTbl;
     SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = EecEmpNo
        ,drvSubsort = ''
        -- standard fields above and additional driver fields below
        ,drvCN = dbo.dsi_fnRemoveChars(',',Concat(Ltrim(Rtrim(EepNameFirst)), ' ' ,Ltrim(RTrim(EepNameLast))))
        ,drvCompany = 'Padagis'
        ,drvCountry = 'United States'
        ,drvcountryCode = '0'
        ,drvDepartment = dbo.dsi_fnRemoveChars(',',OL1.OrgDesc) --OrgDesc where OrgCode = EecOrgLvl1
        ,drvDescription = JbcDesc
        ,drvDisplayName = dbo.dsi_fnRemoveChars(',',dbo.dsi_fnRemoveChars(',',Concat(Ltrim(Rtrim(EepNameFirst)), ' ' ,Ltrim(RTrim(EepNameLast)))))
        ,drvEmailAddress = EepAddressEMail
        ,drvEmployeeID = EecEmpNo
        ,drvEmployeeNumber = EecEmpNo
        ,drvGivenName = EepNamePreferred
        ,drvHomePhone = EepPhoneHomeNumber
        ,drvManager = dbo.dsi_fnRemoveChars(',',dbo.dsi_fnlib_GetSupervisorField('', EecEEID, 'Namefirst')  + ' ' +  dbo.dsi_fnlib_GetSupervisorField('', EecEEID, 'NameLast'))
        ,drvMobilePhone = EfoPhoneNumber
        ,drvOfficePhone = EecPhoneBusinessNumber
        ,drvPostalCode = LocAddressZipCode --EepAddressZipCode
        ,drvState =  LocAddressState---EepAddressState
        ,drvStreetAddress = dbo.dsi_fnRemoveChars(',',LocAddressLine1+ ' ' +LocAddressLine2)
        ,drvTitle = dbo.dsi_fnRemoveChars(',',JbcDesc)
        ,drvPager = dbo.dsi_fnRemoveChars(',',Concat('PDGS','-',OL2.OrgDesc ))
    INTO dbo.U_EPERADSNEX_drvTbl
    FROM dbo.U_EPERADSNEX_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
     JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
     LEFT JOIN dbo.OrgLevel OL1 WITH (NOLOCK)
        On OL1.OrgLvl = 1
        and OL1.OrgCode = EecOrgLvl1
     LEFT JOIN dbo.OrgLevel OL2 WITH (NOLOCK)
        On OL2.OrgLvl = 2
        and OL2.OrgCode = EecOrgLvl2
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    LEFT JOIN (
                SELECT EfoEEID, EfoPhoneNumber
                FROM (
                        SELECT EfoEEID, EfoPhoneNumber, ROW_NUMBER() OVER (PARTITION BY EfoEEID ORDER BY EfoPhoneNumber) AS RN --, ORDER BY Ef
                        FROM  dbo.EmpMPhon WITH (NOLOCK)
                        WHERE EfoPhoneType = 'CEL') AS Efo
                WHERE RN = 1 ) AS EfoPhone
        ON EfoEEID = xEEID
   LEFT JOIN dbo.U_EPERADSNEX_Audit WITH (NOLOCK)
        ON audEEID = XEEID 
        AND audKey2 = XCOID
    WHERE EecEEType <> 'TES' and  (EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND AudDateTime IS NOT NULL AND AudDateTime BETWEEN  @StartDate AND @EndDate))

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
ALTER VIEW dbo.dsi_vwEPERADSNEX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EPERADSNEX_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EPERADSNEX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202211251'
       ,expStartPerControl     = '202211251'
       ,expLastEndPerControl   = '202212219'
       ,expEndPerControl       = '202212219'
WHERE expFormatCode = 'EPERADSNEX';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEPERADSNEX_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EPERADSNEX_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EPERADSNEX' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EPERADSNEX'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EPERADSNEX'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EPERADSNEX', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EPERADSNEX', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EPERADSNEX', 'UseFileName', 'V', 'Y'


-- End ripout