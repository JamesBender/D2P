/**********************************************************************************

ECYCCBNPM: Connect Your Care COBRA NPM Export

FormatCode:     ECYCCBNPM
Project:        Connect Your Care COBRA NPM Export
Client ID:      MGP1000
Date/time:      2022-01-20 12:45:05.390
Ripout version: 7.4
Export Type:    Web
Status:         Production
Environment:    EWP
Server:         EW4WUP3DB01
Database:       ULTIPRO_WPMGPI
Web Filename:   MGP1000_BLF99_EEHISTORY_ECYCCBNPM_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ECYCCBNPM_SavePath') IS NOT NULL DROP TABLE dbo.U_ECYCCBNPM_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ECYCCBNPM'


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
WHERE FormatCode = 'ECYCCBNPM'
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
WHERE ExpFormatCode = 'ECYCCBNPM'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ECYCCBNPM')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ECYCCBNPM'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ECYCCBNPM'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ECYCCBNPM'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ECYCCBNPM'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ECYCCBNPM'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ECYCCBNPM'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ECYCCBNPM'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ECYCCBNPM'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ECYCCBNPM'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwECYCCBNPM_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECYCCBNPM_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECYCCBNPM') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECYCCBNPM];
GO
IF OBJECT_ID('U_ECYCCBNPM_File') IS NOT NULL DROP TABLE [dbo].[U_ECYCCBNPM_File];
GO
IF OBJECT_ID('U_ECYCCBNPM_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECYCCBNPM_EEList];
GO
IF OBJECT_ID('U_ECYCCBNPM_drvTbl_NPM') IS NOT NULL DROP TABLE [dbo].[U_ECYCCBNPM_drvTbl_NPM];
GO
IF OBJECT_ID('U_dsi_BDM_ECYCCBNPM') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ECYCCBNPM];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ECYCCBNPM','Connect Your Care COBRA NPM Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','ECYCCBNPMZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECYCCBNPMZ0','50','H','01','1',NULL,'Version Line Identifier',NULL,NULL,'"[VERSION]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECYCCBNPMZ0','50','H','01','2',NULL,'Version Number',NULL,NULL,'"1.1"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECYCCBNPMZ0','50','D','10','1',NULL,'Version Line Identifier',NULL,NULL,'"[NPM]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECYCCBNPMZ0','50','D','10','2',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECYCCBNPMZ0','50','D','10','3',NULL,'IndividualIdentifier',NULL,NULL,'"drvEmpNo"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECYCCBNPMZ0','50','D','10','4',NULL,'ClientName',NULL,NULL,'"drvClientName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECYCCBNPMZ0','50','D','10','5',NULL,'ClientDivisionName',NULL,NULL,'"drvClientDivName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECYCCBNPMZ0','50','D','10','6',NULL,'FirstName',NULL,NULL,'"drvNameFirst"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECYCCBNPMZ0','50','D','10','7',NULL,'MiddleInitial',NULL,NULL,'"drvNameMiddle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECYCCBNPMZ0','50','D','10','8',NULL,'LastName',NULL,NULL,'"drvNameLast"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECYCCBNPMZ0','50','D','10','9',NULL,'Salutation',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECYCCBNPMZ0','50','D','10','10',NULL,'Email',NULL,NULL,'"drvAddressEMail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECYCCBNPMZ0','50','D','10','11',NULL,'Phone',NULL,NULL,'"drvPhoneHomeNumber"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECYCCBNPMZ0','50','D','10','12',NULL,'Phone2',NULL,NULL,'"drvPhoneWorkNumber"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECYCCBNPMZ0','50','D','10','13',NULL,'Address1',NULL,NULL,'"drvAddressLine1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECYCCBNPMZ0','50','D','10','14',NULL,'Address2',NULL,NULL,'"drvAddressLine2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECYCCBNPMZ0','50','D','10','15',NULL,'City',NULL,NULL,'"drvAddressCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECYCCBNPMZ0','50','D','10','16',NULL,'StateOrProvince',NULL,NULL,'"drvAddressState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECYCCBNPMZ0','50','D','10','17',NULL,'PostalCode',NULL,NULL,'"drvAddressZipCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ECYCCBNPMZ0','50','D','10','18',NULL,'Country',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ECYCCBNPMZ0','50','D','10','19',NULL,'Sex',NULL,NULL,'"drvGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ECYCCBNPMZ0','50','D','10','20',NULL,'UsesFamilyInAddress',NULL,NULL,'"drvUsesFamilyInAddress"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ECYCCBNPMZ0','50','D','10','21',NULL,'HasWaivedAllCoverage',NULL,NULL,'"F"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ECYCCBNPMZ0','50','D','10','22',NULL,'SendGRNotice',NULL,NULL,'"T"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ECYCCBNPMZ0','50','D','10','23',NULL,'Hire Date',NULL,NULL,'"drvHireDate"','(''UD101''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ECYCCBNPM_20220120.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'CYC Cobra NPM OnDemand','202010149','EMPEXPORT','ONDEM_XOE',NULL,'ECYCCBNPM',NULL,NULL,NULL,'202010149','Jan 13 2016  8:53AM','Jan 13 2016  8:53AM','202001011',NULL,'','','202001011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N',',M0UP1,M0U4Y',NULL,NULL,NULL,'CYC Cobra NPM Scheduled','202004229','EMPEXPORT','SCH_ECYCCB',NULL,'ECYCCBNPM',NULL,NULL,NULL,'202201149','Jan 13 2016  8:53AM','Jan 13 2016  8:53AM','202201071',NULL,'','','202001011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECYCCBNPM','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECYCCBNPM','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECYCCBNPM','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECYCCBNPM','SubSort2','C','drvSubSort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECYCCBNPM','SubSort3','C','drvSubSort3');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECYCCBNPM','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECYCCBNPM','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECYCCBNPM','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECYCCBNPM','D10','dbo.U_ECYCCBNPM_drvTbl_NPM WITH (NOLOCK)',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_ECYCCBNPM
-----------

IF OBJECT_ID('U_dsi_BDM_ECYCCBNPM') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ECYCCBNPM] (
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
-- Create table U_ECYCCBNPM_drvTbl_NPM
-----------

IF OBJECT_ID('U_ECYCCBNPM_drvTbl_NPM') IS NULL
CREATE TABLE [dbo].[U_ECYCCBNPM_drvTbl_NPM] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvSubSort] char(11) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvEmpNo] char(9) NULL,
    [drvClientName] varchar(20) NOT NULL,
    [drvClientDivName] varchar(33) NULL,
    [drvNameFirst] varchar(8000) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(8000) NULL,
    [drvAddressEMail] varchar(50) NULL,
    [drvPhoneHomeNumber] varchar(50) NULL,
    [drvPhoneWorkNumber] varchar(50) NULL,
    [drvAddressLine1] varchar(8000) NULL,
    [drvAddressLine2] varchar(8000) NULL,
    [drvAddressCity] varchar(8000) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvGender] char(1) NOT NULL,
    [drvUsesFamilyInAddress] varchar(5) NOT NULL,
    [drvHireDate] datetime NULL
);

-----------
-- Create table U_ECYCCBNPM_EEList
-----------

IF OBJECT_ID('U_ECYCCBNPM_EEList') IS NULL
CREATE TABLE [dbo].[U_ECYCCBNPM_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ECYCCBNPM_File
-----------

IF OBJECT_ID('U_ECYCCBNPM_File') IS NULL
CREATE TABLE [dbo].[U_ECYCCBNPM_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECYCCBNPM]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: MGPI Processing

Created By: Carrie McDowell
Business Analyst: Van Amundson
Create Date: 10/27/2020
Service Request Number: N/A-Partner Direct   ***WEB***

Purpose: Connect Your Care COBRA NPM Export

Revision History
----------------
Update By            Date           Request Num        Desc
XXXX                 XX/XX/xxxx     SR-20XX-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECYCCBNPM';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECYCCBNPM';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECYCCBNPM';
SELECT expformatcode, expexportcode, expascfilename, expstartpercontrol, expendpercontrol,* FROM dbo.AscExp WHERE ExpFormatCode = 'ECYCCBNPM';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECYCCBNPM' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECYCCBNPM', 'ONDEM_XOE';  
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECYCCBNPM', 'SCH_ECYCCB';

--Update Testing flag in U_DSI_Configuration for Production
---------------------------------------------------
UPDATE dbo.U_DSI_Configuration SET cfgvalue = 'N' WHERE formatcode = 'ECYCCBNPM' AND cfgname = 'Testing';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ECYCCBNPM';

EXEC dbo._dsi_usp_ExportRipOut_v7 @FormatCode = 'ECYCCBNPM', @AllObjects = 'Y', @IsWeb = 'Y';

**********************************************************************************/
BEGIN
    --==========================================
    -- Declare variables
    --==========================================
    DECLARE  @FormatCode varchar(10)
            ,@ExportCode varchar(10)
            ,@StartDate  datetime
            ,@EndDate    datetime;

    -- Initialize @FormatCode
    SET @FormatCode = 'ECYCCBNPM';

    -- Declare dates from Parameter file
    SELECT
         @ExportCode = ExportCode
        ,@StartDate  = LEFT(StartPerControl,8)
        ,@EndDate    = DATEADD(SS,-1,DATEADD(DD,1,LEFT(EndPerControl,8)))
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List
    --==========================================
    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_ECYCCBNPM_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCoID(xEEID)
      AND xEEID IN (SELECT xEEID FROM dbo.U_ECYCCBNPM_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


        --==========================================
        -- BDM Section for NPM
        --==========================================
        DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

        -- Required parameters
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'StartDateTime',@StartDate);
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'EndDateTime',@EndDate);
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'TermSelectionOption','AuditDate');

        -- NPM parameters
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RunID','NPM');
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','Y'); -- DedIsCobraCovered = 'Y'
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'NewEnrolleeType','2'); -- All new enrollees where no previous plan exists
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'TableType','EMP'); -- Only include employees on NPM file
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');

        -- Run BDM for NPM
        EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable_V2 @FormatCode;

        -- select distinct bdmbenoption, bdmrelationship from dbo.U_dsi_bdm_ECYCCBNPM order by 1
        -- select distinct bnocode, bnodescription from benopt
    --==========================================
    -- Build driver tables
    --==========================================

    ------------------
    -- DETAIL RECORD - NPM Record
    ------------------
    IF OBJECT_ID('U_ECYCCBNPM_drvTbl_NPM') IS NOT NULL
        DROP TABLE dbo.U_ECYCCBNPM_drvTbl_NPM;
    SELECT DISTINCT
         drvEEID            = BdmEEID
        ,drvCoID            = BdmCoID
        ,drvSubSort         = eepSSN
        ,drvSubSort2        = ''
        ,drvSubSort3        = ''
        -- standard fields above and additional driver fields below
        ,drvSSN             = eepSSN
        ,drvEmpNo           = EecEmpNo
        ,drvClientName      = 'MGP Ingredients, Inc'
        ,drvClientDivName   = CASE WHEN CmpCompanyCode = 'ATMGP' THEN 'Atchison KS'
                                   WHEN CmpCompanyCode = 'LBMGP' THEN 'Lawrenceburg IN'
                                   ELSE CmpAddressCity + ',' + CmpAddressState
                                END
        ,drvNameFirst       = REPLACE(eepnamefirst,',',' ')
        ,drvNameMiddle      = LEFT(EepNameMiddle,1)
        ,drvNameLast        = REPLACE(eepnamelast,',',' ')
        ,drvAddressEMail    = eepAddressEMail
        ,drvPhoneHomeNumber = EepPhoneHomeNumber
        ,drvPhoneWorkNumber = EecPhoneBusinessNumber
        ,drvAddressLine1    = REPLACE(EepAddressLine1,',',' ')
        ,drvAddressLine2    = REPLACE(EepAddressLine2,',',' ')
        ,drvAddressCity     = REPLACE(EepAddressCity,',',' ')
        ,drvAddressState    = EepAddressState
        ,drvAddressZipCode  = EepAddressZipCode
        ,drvGender          = ISNULL(eepgender,'U')
        ,drvUsesFamilyInAddress =  CASE WHEN BdmEEID1 IS NOT NULL THEN 'TRUE' ELSE 'FALSE' END
        ,drvHireDate        = EecDateOfLastHire
    INTO dbo.U_ECYCCBNPM_drvTbl_NPM -- Select * from dbo.U_ECYCCBNPM_drvTbl_NPM
    FROM dbo.U_ECYCCBNPM_EELIST WITH (NOLOCK) 
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ECYCCBNPM WITH (NOLOCK)        --SELECT distinct BdmBenOption FROM dbo.U_dsi_BDM_ECYCCBNPM WITH (NOLOCK)
        ON BdmEEID = xEEID
        AND bdmCoID = xCOID
    JOIN dbo.Company WITH (NOLOCK)
        ON CmpCOID = xCOID 
    LEFT JOIN dbo.EmpDed WITH (NOLOCK)
        ON EedEEID = xEEID
    LEFT JOIN (SELECT BdmEEID1 = BdmEEID, BdmCOID1 = BdmCOID, BdmDedCode, BdmBenOption FROM dbo.U_dsi_BDM_ECYCCBNPM WITH (NOLOCK)        --SELECT distinct BdmBenOption FROM dbo.U_dsi_BDM_ECYCCBNPM WITH (NOLOCK)
                    WHERE BdmBenOption NOT IN ('EETF','EE')
    ) tmpTbl1
        ON BdmEEID1 = xEEID
        AND BdmCOID1 = xCOID
    ;
 -- sp_geteeid 'Pickman' -- 'DIE7ZF000020'
 -- sp_geteeid 'Jeradechachai' -- 'DI6S82007020'

    --==========================================
    -- Set filename
    --==========================================
    --IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    --BEGIN
    --    UPDATE dbo.U_dsi_Parameters
    --    SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' AND @ExportCode LIKE '%NPM%' THEN '_TEST_' + CONVERT(char(8),GETDATE(),112) + '_@FileCustomerName_NPM_@FileCustomerNumber.txt'
    --                          WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' AND @ExportCode LIKE '%QB%' THEN '_TEST_' + CONVERT(char(8),GETDATE(),112) + '_@FileCustomerName_QB_@FileCustomerNumber.txt'
    --                          WHEN @ExportCode = 'TESTNPM' THEN '_TEST_' + CONVERT(char(8),GETDATE(),112) + '_@FileCustomerName_NPM_@FileCustomerNumber.txt'
    --                          WHEN @ExportCode = 'TESTQB' THEN '_TEST_' + CONVERT(char(8),GETDATE(),112) + '_@FileCustomerName_QB_@FileCustomerNumber.txt'
    --                          WHEN @ExportCode = 'NPMFILE' THEN CONVERT(char(8),GETDATE(),112) + '_@FileCustomerName_NPM_@FileCustomerNumber.txt'
    --                          WHEN @ExportCode = 'QBFILE' THEN CONVERT(char(8),GETDATE(),112) + '_@FileCustomerName_QB_@FileCustomerNumber.txt'
    --                     END
    --    WHERE FormatCode = @FormatCode;
    --END;
END;
/***************************************************************************************

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECYCCBNPM';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECYCCBNPM';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECYCCBNPM';
SELECT expformatcode, expexportcode, expascfilename, expstartpercontrol, expendpercontrol,* FROM dbo.AscExp WHERE ExpFormatCode = 'ECYCCBNPM';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECYCCBNPM' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECYCCBNPM', 'ONDEM_XOE';  
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECYCCBNPM', 'SCH_ECYCCB';

--Update Testing flag in U_DSI_Configuration for Production
---------------------------------------------------
UPDATE dbo.U_DSI_Configuration SET cfgvalue = 'N' WHERE formatcode = 'ECYCCBNPM' AND cfgname = 'Testing';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ECYCCBNPM';

EXEC dbo._dsi_usp_ExportRipOut_v6 @FormatCode = 'ECYCCBNPM', @AllObjects = 'Y', @IsWeb = 'Y';

--Alter the View
ALTER VIEW dbo.dsi_vwECYCCBNPM_Export AS
    SELECT TOP 2000000 Data
    FROM dbo.U_ECYCCBNPM_File WITH (NOLOCK)
    ORDER BY InitialSort, SubSort, SubSort2, SubSort3, RecordSet;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ECYCCBNPM%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202001011'
       ,expStartPerControl     = '202001011'
       ,expLastEndPerControl   = '202010149'
       ,expEndPerControl       = '202010149'
WHERE expFormatCode = 'ECYCCBNPM' and expexportcode = 'OND_XOE';

***************************************************************************************/
SET NOCOUNT OFF;
GO
CREATE VIEW dbo.dsi_vwECYCCBNPM_Export AS
    SELECT TOP 2000000 Data
    FROM dbo.U_ECYCCBNPM_File WITH (NOLOCK)
    ORDER BY InitialSort, SubSort, SubSort2, SubSort3, RecordSet;

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ECYCCBNPM' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ECYCCBNPM'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ECYCCBNPM'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECYCCBNPM', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ECYCCBNPM', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECYCCBNPM', 'UseFileName', 'V', 'Y'


-- End ripout