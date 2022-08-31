/**********************************************************************************

EANCCALDEN: Cal Dental Health and Welfare

FormatCode:     EANCCALDEN
Project:        Cal Dental Health and Welfare
Client ID:      ANC1000
Date/time:      2022-08-26 17:56:56.060
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW3WUP4DB01
Database:       ULTIPRO_WPANCON
Web Filename:   ANC1000_8431A_EEHISTORY_EANCCALDEN_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EANCCALDEN_SavePath') IS NOT NULL DROP TABLE dbo.U_EANCCALDEN_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EANCCALDEN'


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
WHERE FormatCode = 'EANCCALDEN'
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
WHERE ExpFormatCode = 'EANCCALDEN'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EANCCALDEN')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EANCCALDEN'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EANCCALDEN'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EANCCALDEN'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EANCCALDEN'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EANCCALDEN'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EANCCALDEN'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EANCCALDEN'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EANCCALDEN'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EANCCALDEN'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEANCCALDEN_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEANCCALDEN_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EANCCALDEN') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EANCCALDEN];
GO
IF OBJECT_ID('U_EANCCALDEN_File') IS NOT NULL DROP TABLE [dbo].[U_EANCCALDEN_File];
GO
IF OBJECT_ID('U_EANCCALDEN_EEList') IS NOT NULL DROP TABLE [dbo].[U_EANCCALDEN_EEList];
GO
IF OBJECT_ID('U_EANCCALDEN_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EANCCALDEN_drvTbl];
GO
IF OBJECT_ID('U_EANCCALDEN_DedList') IS NOT NULL DROP TABLE [dbo].[U_EANCCALDEN_DedList];
GO
IF OBJECT_ID('U_EANCCALDEN_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EANCCALDEN_AuditFields];
GO
IF OBJECT_ID('U_EANCCALDEN_Audit') IS NOT NULL DROP TABLE [dbo].[U_EANCCALDEN_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EANCCALDEN') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EANCCALDEN];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EANCCALDEN','Cal Dental Health and Welfare','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','EANCCALDENZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EANCCALDENZ0','50','H','01','1',NULL,'SUBSCRIBER SSN',NULL,NULL,'"SUBSCRIBER SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EANCCALDENZ0','50','H','01','2',NULL,'PERSON SSN',NULL,NULL,'"PERSON SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EANCCALDENZ0','50','H','01','3',NULL,'RELATIONSHIP',NULL,NULL,'"RELATIONSHIP"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EANCCALDENZ0','50','H','01','4',NULL,'LAST NAME',NULL,NULL,'"LAST NAME"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EANCCALDENZ0','50','H','01','5',NULL,'FIRST NAME',NULL,NULL,'"FIRST NAME"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EANCCALDENZ0','50','H','01','6',NULL,'DATE OF BIRTH',NULL,NULL,'"DATE OF BIRTH"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EANCCALDENZ0','50','H','01','7',NULL,'GENDER',NULL,NULL,'"GENDER"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EANCCALDENZ0','50','H','01','8',NULL,'ADDRESS',NULL,NULL,'"ADDRESS"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EANCCALDENZ0','50','H','01','9',NULL,'CITY',NULL,NULL,'"CITY"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EANCCALDENZ0','50','H','01','10',NULL,'STATE',NULL,NULL,'"STATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EANCCALDENZ0','50','H','01','11',NULL,'ZIP',NULL,NULL,'"ZIP"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EANCCALDENZ0','50','H','01','12',NULL,'DATE OF HIRE',NULL,NULL,'"DATE OF HIRE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EANCCALDENZ0','50','H','01','13',NULL,'EFFECTIVE DATE',NULL,NULL,'"EFFECTIVE DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EANCCALDENZ0','50','H','01','14',NULL,'TERM DATE',NULL,NULL,'"TERM DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EANCCALDENZ0','50','H','01','15',NULL,'TIER',NULL,NULL,'"TIER"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EANCCALDENZ0','50','H','01','16',NULL,'OFFICE #',NULL,NULL,'"OFFICE #"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EANCCALDENZ0','50','H','01','17',NULL,'CODE',NULL,NULL,'"CODE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EANCCALDENZ0','50','H','01','18',NULL,'GROUP NUMBER',NULL,NULL,'"GROUP NUMBER"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EANCCALDENZ0','50','H','01','19',NULL,'PLAN',NULL,NULL,'"PLAN"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EANCCALDENZ0','50','D','10','1',NULL,'SUBSCRIBER SSN',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EANCCALDENZ0','50','D','10','2',NULL,'PERSON SSN',NULL,NULL,'"drvPERSONSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EANCCALDENZ0','50','D','10','3',NULL,'RELATIONSHIP',NULL,NULL,'"drvRELATIONSHIP"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EANCCALDENZ0','50','D','10','4',NULL,'LAST NAME',NULL,NULL,'"drvLASTNAME"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EANCCALDENZ0','50','D','10','5',NULL,'FIRST NAME',NULL,NULL,'"drvFIRSTNAME"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EANCCALDENZ0','50','D','10','6',NULL,'DATE OF BIRTH',NULL,NULL,'"drvDATEOFBIRTH"','(''UD112''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EANCCALDENZ0','50','D','10','7',NULL,'GENDER',NULL,NULL,'"drvGENDER"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EANCCALDENZ0','50','D','10','8',NULL,'ADDRESS',NULL,NULL,'"drvADDRESS"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EANCCALDENZ0','50','D','10','9',NULL,'CITY',NULL,NULL,'"drvCITY"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EANCCALDENZ0','50','D','10','10',NULL,'STATE',NULL,NULL,'"drvSTATE"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EANCCALDENZ0','50','D','10','11',NULL,'ZIP',NULL,NULL,'"drvZIP"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EANCCALDENZ0','50','D','10','12',NULL,'DATE OF HIRE',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EANCCALDENZ0','50','D','10','13',NULL,'EFFECTIVE DATE',NULL,NULL,'"drvEFFECTIVEDATE"','(''UD112''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EANCCALDENZ0','50','D','10','14',NULL,'TERM DATE',NULL,NULL,'"drvTERMDATE"','(''UD112''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EANCCALDENZ0','50','D','10','15',NULL,'TIER',NULL,NULL,'"drvTIER"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EANCCALDENZ0','50','D','10','16',NULL,'OFFICE #',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EANCCALDENZ0','50','D','10','17',NULL,'CODE',NULL,NULL,'"drvCODE"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EANCCALDENZ0','50','D','10','18',NULL,'GROUP NUMBER',NULL,NULL,'"drvGROUPNUMBER"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EANCCALDENZ0','50','D','10','19',NULL,'PLAN',NULL,NULL,'"drvPLAN"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EANCCALDEN_20220826.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202208269','EMPEXPORT','OEACTIVE',NULL,'EANCCALDEN',NULL,NULL,NULL,'202208269','Aug 26 2022  2:59PM','Aug 26 2022  2:59PM','202208011',NULL,'','','202208011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202208269','EMPEXPORT','OEPASSIVE',NULL,'EANCCALDEN',NULL,NULL,NULL,'202208269','Aug 26 2022  2:59PM','Aug 26 2022  2:59PM','202208011',NULL,'','','202208011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Cal Dental Health and Welfare','202208269','EMPEXPORT','ONDEM_XOE',NULL,'EANCCALDEN',NULL,NULL,NULL,'202208269','Aug 26 2022  2:59PM','Aug 26 2022  2:59PM','202208011',NULL,'','','202208011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Cal Dental Health and We-Sched','202208269','EMPEXPORT','SCH_EANCCA',NULL,'EANCCALDEN',NULL,NULL,NULL,'202208269','Aug 26 2022  2:59PM','Aug 26 2022  2:59PM','202208011',NULL,'','','202208011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Cal Dental Health and We-Test','202208269','EMPEXPORT','TEST_XOE',NULL,'EANCCALDEN',NULL,NULL,NULL,'202208269','Aug 26 2022  2:59PM','Aug 26 2022  2:59PM','202208011',NULL,'','','202208011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EANCCALDEN','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EANCCALDEN','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EANCCALDEN','InitialSort','C','drvEmpNoSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EANCCALDEN','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EANCCALDEN','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EANCCALDEN','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EANCCALDEN','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EANCCALDEN','D10','dbo.U_EANCCALDEN_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EANCCALDEN
-----------

IF OBJECT_ID('U_dsi_BDM_EANCCALDEN') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EANCCALDEN] (
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
-- Create table U_EANCCALDEN_Audit
-----------

IF OBJECT_ID('U_EANCCALDEN_Audit') IS NULL
CREATE TABLE [dbo].[U_EANCCALDEN_Audit] (
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
-- Create table U_EANCCALDEN_AuditFields
-----------

IF OBJECT_ID('U_EANCCALDEN_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EANCCALDEN_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EANCCALDEN_DedList
-----------

IF OBJECT_ID('U_EANCCALDEN_DedList') IS NULL
CREATE TABLE [dbo].[U_EANCCALDEN_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EANCCALDEN_drvTbl
-----------

IF OBJECT_ID('U_EANCCALDEN_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EANCCALDEN_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvEmpNoSort] char(11) NULL,
    [drvSSN] char(11) NULL,
    [drvPERSONSSN] char(11) NULL,
    [drvRELATIONSHIP] varchar(3) NULL,
    [drvLASTNAME] varchar(100) NULL,
    [drvFIRSTNAME] varchar(100) NULL,
    [drvDATEOFBIRTH] datetime NULL,
    [drvGENDER] varchar(1) NOT NULL,
    [drvADDRESS] varchar(511) NULL,
    [drvCITY] varchar(255) NULL,
    [drvSTATE] varchar(255) NULL,
    [drvZIP] varchar(50) NULL,
    [drvEFFECTIVEDATE] datetime NULL,
    [drvTERMDATE] datetime NULL,
    [drvTIER] varchar(2) NULL,
    [drvCODE] varchar(1) NOT NULL,
    [drvGROUPNUMBER] varchar(6) NULL,
    [drvPLAN] varchar(4) NOT NULL
);

-----------
-- Create table U_EANCCALDEN_EEList
-----------

IF OBJECT_ID('U_EANCCALDEN_EEList') IS NULL
CREATE TABLE [dbo].[U_EANCCALDEN_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EANCCALDEN_File
-----------

IF OBJECT_ID('U_EANCCALDEN_File') IS NULL
CREATE TABLE [dbo].[U_EANCCALDEN_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EANCCALDEN]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Ancon Marine

Created By: Marie Thomerson
Business Analyst: Cheryl Petitti
Create Date: 08/26/2022
Service Request Number: TekP-2022-06-20-01

Purpose: Cal Dental Health and Welfare

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EANCCALDEN';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EANCCALDEN';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EANCCALDEN';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EANCCALDEN';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EANCCALDEN' ORDER BY RunID DESC;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202208011'
       ,expStartPerControl     = '202208011'
       ,expLastEndPerControl   = '202208269'
       ,expEndPerControl       = '202208269'
WHERE expFormatCode = 'EANCCALDEN';

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EANCCALDEN', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EANCCALDEN', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EANCCALDEN', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EANCCALDEN', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EANCCALDEN', 'SCH_EANCCA';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EANCCALDEN';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EANCCALDEN', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EANCCALDEN';

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
    DELETE FROM dbo.U_EANCCALDEN_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EANCCALDEN_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
     --Get data from audit fields table. Add fields here if auditing

    IF OBJECT_ID('U_EANCCALDEN_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EANCCALDEN_AuditFields;
    CREATE TABLE dbo.U_EANCCALDEN_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_EANCCALDEN_AuditFields VALUES ('EmpComp','EecDateofTermination');
    --INSERT INTO dbo.U_EANCCALDEN_AuditFields VALUES ('EmpDed','EedDedCode');
    --INSERT INTO dbo.U_EANCCALDEN_AuditFields VALUES ('EmpComp','EecTermReason');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EANCCALDEN_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EANCCALDEN_Audit;
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
    INTO dbo.U_EANCCALDEN_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EANCCALDEN_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EANCCALDEN_Audit ON dbo.U_EANCCALDEN_Audit (audEEID,audKey2);

    --================
    -- Changes Only
    --================
    --DELETE FROM dbo.U_EANCCALDEN_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EANCCALDEN_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'DED1,DED2';

    IF OBJECT_ID('U_EANCCALDEN_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EANCCALDEN_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EANCCALDEN_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','ADEN1');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','StopDate');

    -- Non-Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraType','4');
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraDate','3');
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CountDependents','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DOM');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL, CHD, DPC, STC');
    
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


    Delete From dbo.U_dsi_BDM_EANCCALDEN where BdmEEID in (select Distinct EecEEID from dbo.EmpComp  WITH (NOLOCK) where EecDateofTermination < DateAdd(YY,-1,@StartDate) and EecTermReason <> 'TRO')

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EANCCALDEN_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EANCCALDEN_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EANCCALDEN_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvEmpNoSort = eepSSN
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvPERSONSSN = CASE WHEN BdmRelationship = 'Emp' Then eepSSN ELSE ConSSN END
        ,drvRELATIONSHIP = CASE WHEN BdmRelationship = 'Emp' Then 'EMP' Else
                                Case When ConRelationship = 'SPS' THEN 'SPS'
                                WHEN ConRelationship = 'DP' THEN 'DOM'
                                WHEN ConRelationship in ('CHD', 'CHL', 'DPC','STC') THEN 'DEP' 
                                END END
        ,drvLASTNAME = CASE WHEN BdmRelationship = 'Emp' Then EepNameLast Else ConNameLast END
        ,drvFIRSTNAME = CASE WHEN BdmRelationship = 'Emp' Then EepNameFirst ELSE ConNameFirst END
        ,drvDATEOFBIRTH = CASE WHEN BdmRelationship = 'Emp' Then EepDateOfBirth ELSE ConDateofBirth END
        ,drvGENDER = CASE WHEN BdmRelationship = 'Emp' Then 
                            CASE WHEN EepGender = 'M' THEN 'M' WHEN EepGender = 'F' THEN 'F' ELSE 'U' END 
                            ELSE 
                            CASE WHEN congender= 'M' THEN 'M' WHEN congender = 'F' THEN 'F' ELSE 'U' END 
                            END
        ,drvADDRESS = CASE    WHEN EepAddressLine1 is null THEN EepAddressLine2 
                            WHEN EepAddressLine2 is null THEN EepAddressLine1 
                            ELSE EepAddressLine1 + ' '+ EepAddressLine2 
                            END
        ,drvCITY = EepAddressCity
        ,drvSTATE = EepAddressState
        ,drvZIP = EepAddressZipCode
        ,drvEFFECTIVEDATE = CASE WHEN BdmBenStartDate < DATEADD(MM, 8,DATEADD(yy, DATEDIFF(yy, 0, GETDATE()), 0)) THEN DATEADD(MM, 8,DATEADD(yy, DATEDIFF(yy, 0, GETDATE()), 0)) ELSE BdmBenStartDate END
        ,drvTERMDATE = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvTIER = CASE WHEN BdmBenOption in ('EE', 'IND', 'EREE') THEN 'EE'
                        WHEN BdmBenOption in ('EES', 'EEDP', 'EREES', 'ERDP') THEN 'ES'
                        WHEN BdmBenOption in ('EEC', 'ERECC') THEN 'EC'
                        WHEN BdmBenOption in ('EEF', 'EEDPF', 'FAM', 'DGF', 'EREEF') THEN 'EF'
                        END
        ,drvCODE = CASE WHEN EecEmplStatus = 'T' THEN 'T' else 'C' END
        ,drvGROUPNUMBER = CASE    WHEN EecCoID in ('49VMT','49VPF','BQLK7') THEN '004097' 
                                WHEN EecCoID = '49VSW' THEN '004098'
                                END
        ,drvPLAN = 'DHMO'
    INTO dbo.U_EANCCALDEN_drvTbl
    FROM dbo.U_EANCCALDEN_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EANCCALDEN WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.contacts WITH (NOLOCK)
        ON ConEEID = BdmEEID 
        AND ConImportID = BdmDepRecID
        ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'SUR_Glint_TEST_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.csv'
                                  ELSE 'SUR_Glint_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.csv'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEANCCALDEN_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EANCCALDEN_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EANCCALDEN%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202208191'
       ,expStartPerControl     = '202208191'
       ,expLastEndPerControl   = '202208269'
       ,expEndPerControl       = '202208269'
WHERE expFormatCode = 'EANCCALDEN';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEANCCALDEN_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EANCCALDEN_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EANCCALDEN' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EANCCALDEN'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EANCCALDEN'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EANCCALDEN', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EANCCALDEN', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EANCCALDEN', 'UseFileName', 'V', 'Y'


-- End ripout