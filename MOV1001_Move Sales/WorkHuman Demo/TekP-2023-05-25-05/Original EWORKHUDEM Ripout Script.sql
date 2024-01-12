/**********************************************************************************

EWORKHUDEM: Work Human Demo Export

FormatCode:     EWORKHUDEM
Project:        Work Human Demo Export
Client ID:      MOV1001
Date/time:      2024-01-11 09:55:34.787
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    N33
Server:         N3SUP3DB01
Database:       ULTIPRO_MVS
Web Filename:   MOV1001_M3D41_EEHISTORY_EWORKHUDEM_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EWORKHUDEM_SavePath') IS NOT NULL DROP TABLE dbo.U_EWORKHUDEM_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EWORKHUDEM'


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
WHERE FormatCode = 'EWORKHUDEM'
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
WHERE ExpFormatCode = 'EWORKHUDEM'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EWORKHUDEM')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EWORKHUDEM'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EWORKHUDEM'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EWORKHUDEM'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EWORKHUDEM'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EWORKHUDEM'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EWORKHUDEM'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EWORKHUDEM'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EWORKHUDEM'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EWORKHUDEM'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEWORKHUDEM_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEWORKHUDEM_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EWORKHUDEM') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EWORKHUDEM];
GO
IF OBJECT_ID('U_EWORKHUDEM_File') IS NOT NULL DROP TABLE [dbo].[U_EWORKHUDEM_File];
GO
IF OBJECT_ID('U_EWORKHUDEM_EEList') IS NOT NULL DROP TABLE [dbo].[U_EWORKHUDEM_EEList];
GO
IF OBJECT_ID('U_EWORKHUDEM_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EWORKHUDEM_drvTbl];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EWORKHUDEM','Work Human Demo Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','EWORKHUDEMZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EWORKHUDEMZ0','50','H','01','1',NULL,'Unique ID',NULL,NULL,'"Unique ID"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EWORKHUDEMZ0','50','H','01','2',NULL,'Login ID',NULL,NULL,'"Login ID"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EWORKHUDEMZ0','50','H','01','3',NULL,'First Name',NULL,NULL,'"First Name"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EWORKHUDEMZ0','50','H','01','4',NULL,'Last Name',NULL,NULL,'"Last Name"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EWORKHUDEMZ0','50','H','01','5',NULL,'Email',NULL,NULL,'"Email"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EWORKHUDEMZ0','50','H','01','6',NULL,'Function',NULL,NULL,'"Function"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EWORKHUDEMZ0','50','H','01','7',NULL,'Country',NULL,NULL,'"Country"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EWORKHUDEMZ0','50','H','01','8',NULL,'Hire Date',NULL,NULL,'"Hire Date"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EWORKHUDEMZ0','50','H','01','9',NULL,'Manager ID',NULL,NULL,'"Manager ID"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EWORKHUDEMZ0','50','H','01','10',NULL,'Admin',NULL,NULL,'"Admin"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EWORKHUDEMZ0','50','H','01','11',NULL,'Cost Center',NULL,NULL,'"Cost Center"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EWORKHUDEMZ0','50','H','01','12',NULL,'Location Code',NULL,NULL,'"Location Code"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EWORKHUDEMZ0','50','H','01','13',NULL,'Job Level',NULL,NULL,'"Job Level"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EWORKHUDEMZ0','50','H','01','14',NULL,'Employment Type',NULL,NULL,'"Employment Type"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EWORKHUDEMZ0','50','H','01','15',NULL,'Alternate Title',NULL,NULL,'"Alternate Title"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EWORKHUDEMZ0','50','H','01','16',NULL,'Approver 2',NULL,NULL,'"Approver 2"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EWORKHUDEMZ0','50','H','01','17',NULL,'Approver 3',NULL,NULL,'"Approver 3"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EWORKHUDEMZ0','50','H','01','18',NULL,'Revenue Org Participants',NULL,NULL,'"Revenue Org Participants"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EWORKHUDEMZ0','50','H','01','19',NULL,'Revenue Org Nominators',NULL,NULL,'"Revenue Org Nominators"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EWORKHUDEMZ0','50','H','01','20',NULL,'Pay Group',NULL,NULL,'"Pay Group"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EWORKHUDEMZ0','50','H','01','21',NULL,'HRBP',NULL,NULL,'"HRBP"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EWORKHUDEMZ0','50','H','01','22',NULL,'Gender',NULL,NULL,'"Gender"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EWORKHUDEMZ0','50','D','10','1',NULL,'Unique ID',NULL,NULL,'"drvUniqueId"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EWORKHUDEMZ0','50','D','10','2',NULL,'Login ID',NULL,NULL,'"drvLoginId"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EWORKHUDEMZ0','50','D','10','3',NULL,'First Name',NULL,NULL,'"drvFName"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EWORKHUDEMZ0','50','D','10','4',NULL,'Last Name',NULL,NULL,'"drvLName"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EWORKHUDEMZ0','50','D','10','5',NULL,'Email',NULL,NULL,'"drvEmail"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EWORKHUDEMZ0','50','D','10','6',NULL,'Function',NULL,NULL,'"drvFunc"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EWORKHUDEMZ0','50','D','10','7',NULL,'Country',NULL,NULL,'"drvCountry"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EWORKHUDEMZ0','50','D','10','8',NULL,'Hire Date',NULL,NULL,'"drvHireDt"','(''UD101''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EWORKHUDEMZ0','50','D','10','9',NULL,'Manager ID',NULL,NULL,'"drvManagerId"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EWORKHUDEMZ0','50','D','10','10',NULL,'Admin',NULL,NULL,'"drvAdmin"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EWORKHUDEMZ0','50','D','10','11',NULL,'Cost Center',NULL,NULL,'"drvCostCent"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EWORKHUDEMZ0','50','D','10','12',NULL,'Location Code',NULL,NULL,'"drvLocCode"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EWORKHUDEMZ0','50','D','10','13',NULL,'Job Level',NULL,NULL,'"drvJobLvl"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EWORKHUDEMZ0','50','D','10','14',NULL,'Employment Type',NULL,NULL,'"drvEmpType"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EWORKHUDEMZ0','50','D','10','15',NULL,'Alternate Title',NULL,NULL,'"drvAlternateTitle"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EWORKHUDEMZ0','50','D','10','16',NULL,'Approver 2',NULL,NULL,'"drvApp2"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EWORKHUDEMZ0','50','D','10','17',NULL,'Approver 3',NULL,NULL,'"drvApp3"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EWORKHUDEMZ0','50','D','10','18',NULL,'Revenue Org Participants',NULL,NULL,'"drvRevOrgPart"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EWORKHUDEMZ0','50','D','10','19',NULL,'Revenue Org Nominators',NULL,NULL,'"drvRevOrgNom"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EWORKHUDEMZ0','50','D','10','20',NULL,'Pay Group Description',NULL,NULL,'"drvPayGroupDesc"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EWORKHUDEMZ0','50','D','10','21',NULL,'HRBP',NULL,NULL,'"drvHBRP"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EWORKHUDEMZ0','50','D','10','22',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EWORKHUDEM_20240111.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Work Human Demo Export','202306219','EMPEXPORT','ONDEM_XOE','Jun 21 2023  3:04PM','EWORKHUDEM',NULL,NULL,NULL,'202306219','Jun 21 2023 12:00AM','Dec 30 1899 12:00AM','202306141','1875','','','202306141',dbo.fn_GetTimedKey(),NULL,'us3kEpMOV1001',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N','PPEYL,PJ6ZD,OG4IV,NR767,R4GFV',NULL,NULL,NULL,'Work Human Demo Export-Sched','202203049','EMPEXPORT','SCH_EWORKH',NULL,'EWORKHUDEM',NULL,NULL,NULL,'202401109','Mar  4 2022  2:32PM','Mar  4 2022  2:32PM','202401031',NULL,'','','202203041',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Work Human Demo Export-Test','202207111','EMPEXPORT','TEST_XOE','Jul 25 2022  9:16AM','EWORKHUDEM',NULL,NULL,NULL,'202207111','Jul 11 2022 12:00AM','Dec 30 1899 12:00AM','202207111','2286','','','202207111',dbo.fn_GetTimedKey(),NULL,'US3CPEMOV1001',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWORKHUDEM','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWORKHUDEM','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWORKHUDEM','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWORKHUDEM','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWORKHUDEM','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EWORKHUDEM','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EWORKHUDEM','D10','dbo.U_EWORKHUDEM_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EWORKHUDEM_drvTbl
-----------

IF OBJECT_ID('U_EWORKHUDEM_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EWORKHUDEM_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvUniqueId] varchar(9) NULL,
    [drvLoginId] varchar(50) NULL,
    [drvFName] varchar(100) NULL,
    [drvLName] varchar(100) NULL,
    [drvEmail] varchar(50) NULL,
    [drvFunc] varchar(25) NULL,
    [drvCountry] varchar(2) NULL,
    [drvHireDt] datetime NULL,
    [drvManagerId] varchar(30) NULL,
    [drvAdmin] varchar(1) NULL,
    [drvCostCent] varchar(20) NOT NULL,
    [drvLocCode] varchar(25) NULL,
    [drvJobLvl] char(10) NULL,
    [drvEmpType] varchar(45) NULL,
    [drvAlternateTitle] varchar(25) NOT NULL,
    [drvApp2] varchar(9) NULL,
    [drvApp3] varchar(9) NULL,
    [drvRevOrgPart] varchar(1) NOT NULL,
    [drvRevOrgNom] varchar(1) NOT NULL,
    [drvPayGroupDesc] varchar(25) NULL,
    [drvHBRP] varchar(6) NULL,
    [drvGender] char(1) NULL
);

-----------
-- Create table U_EWORKHUDEM_EEList
-----------

IF OBJECT_ID('U_EWORKHUDEM_EEList') IS NULL
CREATE TABLE [dbo].[U_EWORKHUDEM_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EWORKHUDEM_File
-----------

IF OBJECT_ID('U_EWORKHUDEM_File') IS NULL
CREATE TABLE [dbo].[U_EWORKHUDEM_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EWORKHUDEM]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Move Sales, Inc.

Created By: Andy Pineda
Business Analyst: Cheryl Petitti
Create Date: 03/04/2022
Service Request Number: TekP-2021-12-07-0003

Purpose: Work Human Demo Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EWORKHUDEM';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EWORKHUDEM';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EWORKHUDEM';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EWORKHUDEM';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EWORKHUDEM' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EWORKHUDEM', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EWORKHUDEM', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EWORKHUDEM', 'SCH_EWORKH';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EWORKHUDEM';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EWORKHUDEM', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EWORKHUDEM';

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
    DELETE FROM dbo.U_EWORKHUDEM_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EWORKHUDEM_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_EWORKHUDEM_EEList WHERE xEEID IN (
        SELECT DISTINCT EecEEID FROM dbo.EmpComp WHERE (EecEEType = 'CON' AND EecLocation = 'OFFSH') OR (EecEEType = 'CON' AND EecOrgLvl3 = 'CONEXP')
    );


    --==========================================
    -- Create Deduction List
    --==========================================
    -- DECLARE @DedList VARCHAR(MAX)
    -- SET @DedList = 'DED1,DED2';

    -- IF OBJECT_ID('U_EWORKHUDEM_DedList','U') IS NOT NULL
    --     DROP TABLE dbo.U_EWORKHUDEM_DedList;
    -- SELECT DISTINCT
    --      DedCode = DedDedCode
    --     ,DedType = DedDedType
    -- INTO dbo.U_EWORKHUDEM_DedList
    -- FROM dbo.fn_ListToTable(@DedList)
    -- JOIN dbo.DedCode WITH (NOLOCK)
    --     ON DedDedCode = Item;


    -- --==========================================
    -- -- BDM Section
    -- --==========================================
    -- DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- -- Required parameters
    -- INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','MED,DEN,VIS');
    -- INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    -- INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    -- INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

    -- -- Non-Required parameters
    -- INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    -- INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CalcBenOptionDate','2');
    -- -- Run BDM Module
    -- EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    -- --==========================================
    -- -- Build Working Tables
    -- --==========================================

    -- -----------------------------
    -- -- Working Table - PDedHist
    -- -----------------------------
    -- IF OBJECT_ID('U_EWORKHUDEM_PDedHist','U') IS NOT NULL
    --     DROP TABLE dbo.U_EWORKHUDEM_PDedHist;
    -- SELECT DISTINCT
    --      PdhEEID
    --     -- Current Payroll Amounts
    --     ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
    --     ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
    --     -- YTD Payroll Amounts
    --     ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
    --     ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
    --     -- Categorize Payroll Amounts
    --     ,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('401K') THEN PdhEECurAmt ELSE 0.00 END)
    --     ,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('ROTH') THEN PdhEECurAmt ELSE 0.00 END)
    --     ,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('MATCH') THEN PdhERCurAmt ELSE 0.00 END)        
    --     ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('401CU') THEN PdhEECurAmt ELSE 0.00 END)
    --     ,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
    --     ,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('401KL1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --     ,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('401KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --     ,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --     ,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --     ,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    -- INTO dbo.U_EWORKHUDEM_PDedHist
    -- FROM dbo.PDedHist WITH (NOLOCK)
    -- JOIN dbo.U_EWORKHUDEM_DedList WITH (NOLOCK)
    --     ON DedCode = PdhDedCode
    -- WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    -- AND PdhPerControl <= @EndPerControl
    -- AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    -- GROUP BY PdhEEID
    -- HAVING (SUM(PdhEECurAmt) <> 0.00
    --     OR SUM(PdhERCurAmt) <> 0.00
    -- );


    -- -----------------------------
    -- -- Working Table - PEarHist
    -- -----------------------------
    -- IF OBJECT_ID('U_EWORKHUDEM_PEarHist','U') IS NOT NULL
    --     DROP TABLE dbo.U_EWORKHUDEM_PEarHist;
    -- SELECT DISTINCT
    --      PehEEID
    --     ,PrgPayDate             = MAX(PrgPayDate)
    --     -- Current Payroll Amount/Hours
    --     ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
    --     ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
    --     -- YTD Payroll Amount/Hours
    --     ,PehCurAmtYTD           = SUM(PehCurAmt)
    --     ,PehCurHrsYTD           = SUM(PehCurHrs)
    --     -- Current Include Deferred Comp Amount/Hours
    --     ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
    --     ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
    --     -- YTD Include Deferred Comp Amount/Hours
    --     ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
    --     ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    -- INTO dbo.U_EWORKHUDEM_PEarHist
    -- FROM dbo.vw_int_PayReg WITH (NOLOCK)
    -- JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
    --     ON PehGenNumber = PrgGenNumber
    -- WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    -- AND PehPerControl <= @EndPerControl
    -- GROUP BY PehEEID
    -- HAVING SUM(PehCurAmt) <> 0.00;

    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EWORKHUDE2_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EWORKHUDE2_AuditFields;
    CREATE TABLE dbo.U_EWORKHUDE2_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_EWORKHUDE2_AuditFields VALUES ('EmpComp','EecTermREason');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EWORKHUDE2_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EWORKHUDE2_Audit;
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
    INTO dbo.U_EWORKHUDE2_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EWORKHUDE2_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE --audDateTime BETWEEN @StartDate AND @EndDate
    --AND 
    audAction <> 'DELETE';

    DELETE dbo.U_EWORKHUDE2_Audit WHERE audRowNo <> 1
    DELETE dbo.U_EWORKHUDE2_Audit WHERE audOldValue <> '215' or audOldValue IS NULL
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EWORKHUDE2_Audit ON dbo.U_EWORKHUDE2_Audit (audEEID,audKey2);


    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EWORKHUDEM_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EWORKHUDEM_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EWORKHUDEM_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvUniqueId = SUBSTRING(Ec.EecEmpNo, PATINDEX('%[^0]%', Ec.EecEmpNo+'.'), LEN(Ec.EecEmpNo))
        --Ec.EecEmpNo
        ,drvLoginId =  pers.EepAddressEmail
        ,drvFName = CASE WHEN pers.EepNamePreferred <> '' THEN pers.EepNamePreferred
                        ELSE pers.EepNameFirst END
        ,drvLName = pers.EepNameLast
        ,drvEmail = pers.EepAddressEMail
        ,drvFunc = O3.OrgDesc
        --O1.OrgDesc
        ,drvCountry = LEFT(pers.EepAddressCountry, 2) -- Cheryl follow up
        ,drvHireDt =    CASE WHEN EC.EecDateOfLastHire <> EC.EecDateOfOriginalHire AND audOldValue = '215' THEN EC.EecDateOfLastHire                        
                        WHEN EC.EecDateOfLastHire <> EC.EecDateOfOriginalHire /*AND EC.EecJobChangeReason = '101'*/ AND DATEDIFF(YEAR, EC.EecDateOfOriginalHire,EC.EecDateOfLastHire) >= 5 THEN EC.EecDateOfLastHire
                        WHEN EC.EecDateOfLastHire <> EC.EecDateOfOriginalHire /*AND EC.EecJobChangeReason = '101'*/ AND DATEDIFF(YEAR, EC.EecDateOfOriginalHire,EC.EecDateOfLastHire) < 5 THEN EC.EecDateOfOriginalHire
                        WHEN EC.EecDateOfLastHire <> EC.EecDateOfOriginalHire THEN EC.EecDateOfLastHire
                        ELSE EC.EecDateOfOriginalHire
                        END
                        --CASE WHEN EC.EecDateOfLastHire <> EC.EecDateOfOriginalHire AND audOldValue = '215' THEN EC.EecDateOfLastHire                        
      --                  WHEN EC.EecDateOfLastHire <> EC.EecDateOfOriginalHire /*AND EC.EecJobChangeReason = '101'*/ AND DATEDIFF(YEAR, EjhJobEffDate,EC.EecDateOfLastHire) >= 5 THEN EC.EecDateOfLastHire
      --                  WHEN EC.EecDateOfLastHire <> EC.EecDateOfOriginalHire /*AND EC.EecJobChangeReason = '101'*/ AND DATEDIFF(YEAR, EjhJobEffDate,EC.EecDateOfLastHire) < 5 THEN EC.EecDateOfOriginalHire
      --                  WHEN EC.EecDateOfLastHire <> EC.EecDateOfOriginalHire THEN EC.EecDateOfLastHire
      --                  ELSE EC.EecDateOfOriginalHire
      --                  END
        ,drvManagerId = CAST(CAST(
                                    CASE WHEN Ec.EecEEType = 'POI' AND Ec.EecJobCode = 'UEX1010I' THEN Ec.EecEmpNo 
                                    ELSE EC2.EecEmpNo 
                                    END AS INTEGER) AS VARCHAR)
        ,drvAdmin = CASE Ec.EecEmpNo
                        WHEN '000116305' THEN 'Y'
                        WHEN '000604401' THEN 'Y'
                        WHEN '000606065' THEN 'Y'
                        WHEN '000606453' THEN 'Y'
                        WHEN '000608195' THEN 'Y'
                        WHEN '000604437' THEN 'Y'
                    END
        ,drvCostCent = CONCAT(LTRIM(RTRIM(O1.OrgCode)), LTRIM(RTRIM(O2.OrgCode)))
        ,drvLocCode = LocDesc
        ,drvJobLvl = je.JbcUDField2
        ,drvEmpType = EmpType.CodDesc -- Ec.EecEEType
        ,drvAlternateTitle = je.JbcDesc
        --Ec.EecJobTitle
        ,drvApp2 =    CASE WHEN je2.JbcUDField2 IN ('M4', 'M5', 'M6', 'M7', 'M8', 'M9') THEN '' -- SUBSTRING(EC2.EecEmpNo, PATINDEX('%[^0]%', EC2.EecEmpNo+'.'), LEN(EC2.EecEmpNo))
                    WHEN Je3.JbcUDField2 IN ('M4', 'M5', 'M6', 'M7', 'M8', 'M9') THEN SUBSTRING(EC3.EecEmpNo, PATINDEX('%[^0]%', EC3.EecEmpNo+'.'), LEN(EC3.EecEmpNo))
                    WHEN jeSupervisor4.JbcUDField2 IN ('M4', 'M5', 'M6', 'M7', 'M8', 'M9') THEN  SUBSTRING(ECSupervisor4.EecEmpNo, PATINDEX('%[^0]%', ECSupervisor4.EecEmpNo+'.'), LEN(ECSupervisor4.EecEmpNo))
                    WHEN jeSupervisor5.JbcUDField2 IN ('M4', 'M5', 'M6', 'M7', 'M8', 'M9') THEN  SUBSTRING(ECSupervisor5.EecEmpNo, PATINDEX('%[^0]%', ECSupervisor5.EecEmpNo+'.'), LEN(ECSupervisor5.EecEmpNo))
                    --ECSupervisor4.EecEEID
                    --ELSE '??'
        --                ELSE SUBSTRING(Ec3.EecEmpNo, PATINDEX('%[^0]%', Ec3.EecEmpNo+'.'), LEN(Ec3.EecEmpNo))
                            
                         END
        ,drvApp3 =    CASE WHEN je2.JbcUDField2 IN ('M5', 'M6', 'M7', 'M8', 'M9') THEN '' -- SUBSTRING(EC2.EecEmpNo, PATINDEX('%[^0]%', EC2.EecEmpNo+'.'), LEN(EC2.EecEmpNo))
                    WHEN Je3.JbcUDField2 IN ('M5', 'M6', 'M7', 'M8', 'M9') THEN SUBSTRING(EC3.EecEmpNo, PATINDEX('%[^0]%', EC3.EecEmpNo+'.'), LEN(EC3.EecEmpNo))
                    WHEN jeSupervisor4.JbcUDField2 IN ('M5', 'M6', 'M7', 'M8', 'M9') THEN  SUBSTRING(ECSupervisor4.EecEmpNo, PATINDEX('%[^0]%', ECSupervisor4.EecEmpNo+'.'), LEN(ECSupervisor4.EecEmpNo))
                    WHEN jeSupervisor5.JbcUDField2 IN ('M5', 'M6', 'M7', 'M8', 'M9') THEN  SUBSTRING(ECSupervisor5.EecEmpNo, PATINDEX('%[^0]%', ECSupervisor5.EecEmpNo+'.'), LEN(ECSupervisor5.EecEmpNo))
                    --ECSupervisor4.EecEEID
                    --ELSE ECSupervisor5.EecSupervisorID -- jeSupervisor6.JbcUDField2
        --                ELSE SUBSTRING(Ec3.EecEmpNo, PATINDEX('%[^0]%', Ec3.EecEmpNo+'.'), LEN(Ec3.EecEmpNo))
                            
                         END
        --jeSupervisor4.JbcUDField2 /* CASE WHEN je2.JbcUDField2 IN ('M5', 'M6', 'M7', 'M8', 'M9') THEN  ''
                        --ELSE SUBSTRING(Ec3.EecEmpNo, PATINDEX('%[^0]%', Ec3.EecEmpNo+'.'), LEN(Ec3.EecEmpNo))
                        --END */
        -- Revenue Org Participants
        ,drvRevOrgPart = CASE WHEN Ec.EecEEType = 'REG' AND  Ec.EecOrgLvl3 IN ('CONEXP', 'OPERAT', 'SALES')  THEN 'Y' ELSE '' END
        ,drvRevOrgNom = CASE WHEN Ec.EecEEType = 'REG' AND Ec.EecOrgLvl3 IN ('CONEXP', 'OPERAT', 'SALES') AND je.JbcUDField2 IN ('M4', 'M5', 'M6', 'M7') THEN 'Y' ELSE '' END
        ,drvPayGroupDesc = PayGroup.PgrDesc
        ,drvHBRP =    CASE WHEN EC.EecOrgLvl3 IN ('BUSOPR','MARKT','CUSTCR','FINACT','LEGAL') THEN '608304'
                    WHEN EC.EecOrgLvl3 IN ('PRODCT','TECH') THEN '603878'
                    WHEN EC.EecOrgLvl3 IN ('CONEXP') THEN '606000'
                    WHEN EC.EecOrgLvl3 IN ('SALES','OPERAT') THEN '606221'
                    WHEN EC.EecOrgLvl3 IN ('HRFAC','CSUITE') THEN '603972'
                    END
        ,drvGender =    CASE WHEN pers.EepGender IN ('M','F') THEN pers.EepGender END
    INTO dbo.U_EWORKHUDEM_drvTbl
    FROM dbo.U_EWORKHUDEM_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers pers WITH (NOLOCK)
        ON pers.EepEEID = xEEID
    JOIN dbo.EmpComp Ec WITH(NOLOCK)
        ON Ec.EecEEID = xEEID
        --AND Ec.EecEEType <> 'CON'
        AND Ec.EecEmplStatus <> 'T'
    JOIN dbo.Location WITH(NOLOCK)
        ON LocCode = EecLocation
        --AND LocCode <> 'OFFSH'
    JOIN dbo.JobCode je WITH (NOLOCK)
        ON je.JbcJobCode = Ec.EecJobCode
    JOIN dbo.OrgLevel O3 WITH(NOLOCK)
        ON O3.OrgCode = Ec.EecOrgLvl3
    LEFT JOIN dbo.OrgLevel O1 WITH(NOLOCK)
        ON O1.OrgCode = Ec.EecOrgLvl1
    LEFT JOIN dbo.OrgLevel O2 WITH(NOLOCK)
        ON O2.OrgCode = Ec.EecOrgLvl2
    LEFT JOIN dbo.EmpComp EC2 WITH (NOLOCK) -- supervisor  
        ON EC2.EecEEID = Ec.EecSupervisorID  
        AND EC2.EecEmplStatus <> 'T'
  --  AND Ec2.EecCOID = Ec.EecCOID  
        --AND SUP.EecEmplStatus <> 'T' 
    LEFT JOIN dbo.EmpPers pers2 WITH(NOLOCK)
        ON Ec2.EecEEID = pers2.EepEEID
    LEFT JOIN dbo.JobCode je2 -- test
        ON je2.JbcJobCode = Ec2.EecJobCode
    LEFT JOIN dbo.EmpComp EC3 WITH (NOLOCK) -- supervisor  
        ON EC3.EecEEID = Ec2.EecSupervisorID  
        AND EC3.EecEmplStatus <> 'T'

    LEFT JOIN dbo.EmpComp ECSupervisor4 WITH (NOLOCK) -- supervisor  
        ON ECSupervisor4.EecEEID = Ec3.EecSupervisorID  
        AND ECSupervisor4.EecEmplStatus <> 'T'
    LEFT JOIN dbo.JobCode jeSupervisor4 -- test
        ON jeSupervisor4.JbcJobCode = ECSupervisor4.EecJobCode

    LEFT JOIN dbo.EmpComp ECSupervisor5 WITH (NOLOCK) -- supervisor  
        ON ECSupervisor5.EecEEID = ECSupervisor4.EecSupervisorID  
        AND ECSupervisor5.EecEmplStatus <> 'T'
    LEFT JOIN dbo.JobCode jeSupervisor5 -- test
        ON jeSupervisor5.JbcJobCode = ECSupervisor5.EecJobCode

    LEFT JOIN dbo.EmpComp ECSupervisor6 WITH (NOLOCK) -- supervisor  
        ON ECSupervisor6.EecEEID = ECSupervisor5.EecSupervisorID  
        AND ECSupervisor6.EecEmplStatus <> 'T'
    LEFT JOIN dbo.JobCode jeSupervisor6 -- test
        ON jeSupervisor6.JbcJobCode = ECSupervisor6.EecJobCode


    AND Ec3.EecCOID = Ec2.EecCOID  
        --AND SUP.EecEmplStatus <> 'T' 
    LEFT JOIN dbo.EmpPers pers3 WITH(NOLOCK)
        ON Ec3.EecEEID = pers3.EepEEID
    LEFT JOIN dbo.JobCode je3 -- test
        ON je3.JbcJobCode = Ec3.EecJobCode
    JOIN dbo.Codes AS EmpType WITH (NOLOCK)
        ON Ec.EecEEType = EmpType.CodCode
        AND EmpType.CodTable = 'EmpType'
    JOIN dbo.PayGroup AS PayGroup WITH (NOLOCK)
        ON Ec.EecPayGroup = PayGroup.PgrPayGroup      
    LEFT JOIN dbo.EmpHJob 
        ON EjhEEID = xEEID
        --AND EjhEEID = xCOID
        AND EjhEmplStatus = 'T'
    -- JOIN dbo.U_dsi_BDM_EWORKHUDEM WITH (NOLOCK)
    --     ON BdmEEID = xEEID 
    --     AND BdmCoID = xCoID
    --WHERE Ec.EecEEType <> 'CON'
    --AND LocCode <> 'OFFSH' 
    --AND Ec.EecEmplStatus <> 'T'
    LEFT JOIN dbo.U_EWORKHUDE2_Audit WITH (NOLOCK)
            ON audEEID = xEEID
            AND audKey2 = xCOID
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
ALTER VIEW dbo.dsi_vwEWORKHUDEM_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EWORKHUDEM_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EWORKHUDEM%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202202251'
       ,expStartPerControl     = '202202251'
       ,expLastEndPerControl   = '202203049'
       ,expEndPerControl       = '202203049'
WHERE expFormatCode = 'EWORKHUDEM';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEWORKHUDEM_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EWORKHUDEM_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EWORKHUDEM' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EWORKHUDEM'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EWORKHUDEM'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EWORKHUDEM', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EWORKHUDEM', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EWORKHUDEM', 'UseFileName', 'V', 'Y'


-- End ripout