/**********************************************************************************

EREFMM401K: Mass Mutual 401K Payroll Interface

FormatCode:     EREFMM401K
Project:        Mass Mutual 401K Payroll Interface
Client ID:      REF1001
Date/time:      2022-08-25 13:03:00.993
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    E43
Server:         E4SUP3DB01
Database:       ULTIPRO_RBUS
Web Filename:   REF1001_XAC7C_EEHISTORY_EREFMM401K_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EREFMM401K_SavePath') IS NOT NULL DROP TABLE dbo.U_EREFMM401K_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EREFMM401K'


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
WHERE FormatCode = 'EREFMM401K'
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
WHERE ExpFormatCode = 'EREFMM401K'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EREFMM401K')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EREFMM401K'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EREFMM401K'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EREFMM401K'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EREFMM401K'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EREFMM401K'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EREFMM401K'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EREFMM401K'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EREFMM401K'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EREFMM401K'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEREFMM401K_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEREFMM401K_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EREFMM401K') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EREFMM401K];
GO
IF OBJECT_ID('U_EREFMM401K_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EREFMM401K_PEarHist];
GO
IF OBJECT_ID('U_EREFMM401K_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EREFMM401K_PDedHist];
GO
IF OBJECT_ID('U_EREFMM401K_I_Header') IS NOT NULL DROP TABLE [dbo].[U_EREFMM401K_I_Header];
GO
IF OBJECT_ID('U_EREFMM401K_File') IS NOT NULL DROP TABLE [dbo].[U_EREFMM401K_File];
GO
IF OBJECT_ID('U_EREFMM401K_EEList') IS NOT NULL DROP TABLE [dbo].[U_EREFMM401K_EEList];
GO
IF OBJECT_ID('U_EREFMM401K_DedList') IS NOT NULL DROP TABLE [dbo].[U_EREFMM401K_DedList];
GO
IF OBJECT_ID('U_EREFMM401K_D_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EREFMM401K_D_drvTbl];
GO
IF OBJECT_ID('U_EREFMM401K_C_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EREFMM401K_C_drvTbl];
GO
IF OBJECT_ID('U_EREFMM401K_B_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EREFMM401K_B_drvTbl];
GO
IF OBJECT_ID('U_EREFMM401K_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EREFMM401K_AuditFields];
GO
IF OBJECT_ID('U_EREFMM401K_Audit') IS NOT NULL DROP TABLE [dbo].[U_EREFMM401K_Audit];
GO
IF OBJECT_ID('U_EREFMM401K_A_Header') IS NOT NULL DROP TABLE [dbo].[U_EREFMM401K_A_Header];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EREFMM401K','Mass Mutual 401K Payroll Interface','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','EREFMM401KZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EREFMM401KZ0','1','H','01','1',NULL,'Type',NULL,NULL,'"I"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EREFMM401KZ0','2','H','01','2',NULL,'File ID Code',NULL,NULL,'"drvFileIDCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EREFMM401KZ0','22','H','01','3',NULL,'File Desc',NULL,NULL,'"401K CONTS/CENSUS UPDT"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EREFMM401KZ0','1','H','02','1',NULL,'Type',NULL,NULL,'"A"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EREFMM401KZ0','4','H','02','2',NULL,'Company Code',NULL,NULL,'"drvCompanyCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EREFMM401KZ0','25','H','02','3',NULL,'Company Name',NULL,NULL,'"drvCompanyName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EREFMM401KZ0','8','H','02','4',NULL,'Paydate',NULL,NULL,'"drvPayDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EREFMM401KZ0','8','H','02','5',NULL,'Covers_From',NULL,NULL,'"drvCoversFrom"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EREFMM401KZ0','8','H','02','6',NULL,'Covers_To',NULL,NULL,'"drvCoversTo"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EREFMM401KZ0','1','D','10','1',NULL,'Type',NULL,NULL,'"B"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EREFMM401KZ0','2','D','10','2',NULL,'Category',NULL,NULL,'"drvCategory"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EREFMM401KZ0','12','D','10','3',NULL,'Amount',NULL,NULL,'"drvAmount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EREFMM401KZ0','1','D','20','1',NULL,'Type',NULL,NULL,'"C"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EREFMM401KZ0','9','D','20','2',NULL,'Soc Sec Number',NULL,NULL,'"drvSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EREFMM401KZ0','2','D','20','3',NULL,'Category',NULL,NULL,'"drvCategory"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EREFMM401KZ0','12','D','20','4',NULL,'Amount',NULL,NULL,'"drvAmount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EREFMM401KZ0','1','D','30','1',NULL,'Type',NULL,NULL,'"D"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EREFMM401KZ0','9','D','30','2',NULL,'Soc Sec Number',NULL,NULL,'"drvSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EREFMM401KZ0','20','D','30','3',NULL,'Last Name',NULL,NULL,'"drvNameLast"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EREFMM401KZ0','20','D','30','4',NULL,'First Name',NULL,NULL,'"drvNameFirst"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EREFMM401KZ0','8','D','30','5',NULL,'Birth Date',NULL,NULL,'"drvBirthDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EREFMM401KZ0','8','D','30','6',NULL,'Hire Date',NULL,NULL,'"drvHireDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EREFMM401KZ0','8','D','30','7',NULL,'Status Date',NULL,NULL,'"drvStatusDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EREFMM401KZ0','11','D','30','8',NULL,'Status',NULL,NULL,'"drvStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EREFMM401KZ0','50','D','30','9',NULL,'Address 1',NULL,NULL,'"drvAddress1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EREFMM401KZ0','50','D','30','10',NULL,'Address 2',NULL,NULL,'"drvAddress2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EREFMM401KZ0','25','D','30','11',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EREFMM401KZ0','2','D','30','12',NULL,'State',NULL,NULL,'"drvState"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EREFMM401KZ0','9','D','30','13',NULL,'Zip Code',NULL,NULL,'"drvZipCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EREFMM401KZ0','10','D','30','14',NULL,'Marital Status',NULL,NULL,'"drvMaritalStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EREFMM401KZ0','10','D','30','15',NULL,'Phone',NULL,NULL,'"drvPhone"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EREFMM401KZ0','50','D','30','16',NULL,'Email',NULL,NULL,'"drvEmail"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EREFMM401KZ0','1','T','90','1',NULL,'Type',NULL,NULL,'"Z"','(''DA''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EREFMM401K_20220825.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mass Mutual 401K Payroll Inter','202205269','EMPEXPORT','ONDEM_XOE',NULL,'EREFMM401K',NULL,NULL,NULL,'202205269','Apr 26 2022  1:19PM','Apr 26 2022  1:19PM','202204191',NULL,'','','202204191',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N',',DAJ4C,DCQJ1,DAJ8D,CIUJE,CMCOX,CITIX',NULL,NULL,NULL,'Mass Mut 401K Pay-Thurs 7am','202205269','EMPEXPORT','SCH_EREFMM',NULL,'EREFMM401K',NULL,NULL,NULL,'202208259','Apr 26 2022  1:19PM','Apr 26 2022  1:19PM','202208191',NULL,'','','202204191',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Mass Mutual 401K Payroll-Test','202208259','EMPEXPORT','TEST_XOE','Aug 25 2022 12:00AM','EREFMM401K',NULL,NULL,NULL,'202208259','Aug 25 2022 12:00AM','Dec 30 1899 12:00AM','202208191','289','','','202208191',dbo.fn_GetTimedKey(),NULL,'us3mWaREF1001',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EREFMM401K','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EREFMM401K','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EREFMM401K','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EREFMM401K','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EREFMM401K','SubSort2','C','drvSubsort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EREFMM401K','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EREFMM401K','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EREFMM401K','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EREFMM401K','H01','dbo.U_EREFMM401K_I_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EREFMM401K','H02','dbo.U_EREFMM401K_A_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EREFMM401K','D10','dbo.U_EREFMM401K_B_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EREFMM401K','D20','dbo.U_EREFMM401K_C_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EREFMM401K','D30','dbo.U_EREFMM401K_D_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EREFMM401K','T90','None',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EREFMM401K_A_Header
-----------

IF OBJECT_ID('U_EREFMM401K_A_Header') IS NULL
CREATE TABLE [dbo].[U_EREFMM401K_A_Header] (
    [drvCompanyCode] varchar(4) NOT NULL,
    [drvCompanyName] varchar(8) NOT NULL,
    [drvPayDate] varchar(9) NULL,
    [drvCoversFrom] varchar(9) NULL,
    [drvCoversTo] varchar(9) NULL
);

-----------
-- Create table U_EREFMM401K_Audit
-----------

IF OBJECT_ID('U_EREFMM401K_Audit') IS NULL
CREATE TABLE [dbo].[U_EREFMM401K_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audKey2] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] nvarchar(2000) NULL,
    [audNewValue] nvarchar(2000) NULL,
    [audRowNo] bigint NULL,
    [audNewHire] varchar(1) NOT NULL,
    [audTermintation] varchar(1) NOT NULL,
    [audBenefitChange] varchar(1) NOT NULL
);

-----------
-- Create table U_EREFMM401K_AuditFields
-----------

IF OBJECT_ID('U_EREFMM401K_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EREFMM401K_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EREFMM401K_B_drvTbl
-----------

IF OBJECT_ID('U_EREFMM401K_B_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EREFMM401K_B_drvTbl] (
    [drvSort] varchar(2) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvSubsort2] varchar(1) NOT NULL,
    [drvCategory] varchar(2) NULL,
    [drvAmount] varchar(21) NULL
);

-----------
-- Create table U_EREFMM401K_C_drvTbl
-----------

IF OBJECT_ID('U_EREFMM401K_C_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EREFMM401K_C_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvSort] char(11) NULL,
    [drvSubSort] varchar(2) NULL,
    [drvSubsort2] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvCategory] varchar(2) NULL,
    [drvAmount] varchar(21) NULL
);

-----------
-- Create table U_EREFMM401K_D_drvTbl
-----------

IF OBJECT_ID('U_EREFMM401K_D_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EREFMM401K_D_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvSubsort2] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvBirthDate] datetime NULL,
    [drvHireDate] datetime NULL,
    [drvStatusDate] datetime NULL,
    [drvStatus] varchar(11) NOT NULL,
    [drvAddress1] varchar(255) NULL,
    [drvAddress2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZipCode] varchar(50) NULL,
    [drvMaritalStatus] varchar(7) NOT NULL,
    [drvPhone] varchar(50) NULL,
    [drvEmail] varchar(50) NULL
);

-----------
-- Create table U_EREFMM401K_DedList
-----------

IF OBJECT_ID('U_EREFMM401K_DedList') IS NULL
CREATE TABLE [dbo].[U_EREFMM401K_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EREFMM401K_EEList
-----------

IF OBJECT_ID('U_EREFMM401K_EEList') IS NULL
CREATE TABLE [dbo].[U_EREFMM401K_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EREFMM401K_File
-----------

IF OBJECT_ID('U_EREFMM401K_File') IS NULL
CREATE TABLE [dbo].[U_EREFMM401K_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);

-----------
-- Create table U_EREFMM401K_I_Header
-----------

IF OBJECT_ID('U_EREFMM401K_I_Header') IS NULL
CREATE TABLE [dbo].[U_EREFMM401K_I_Header] (
    [drvFileIDCode] varchar(2) NOT NULL
);

-----------
-- Create table U_EREFMM401K_PDedHist
-----------

IF OBJECT_ID('U_EREFMM401K_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EREFMM401K_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhCategoryCode] varchar(2) NULL,
    [PdhEECurAmt] numeric NULL
);

-----------
-- Create table U_EREFMM401K_PEarHist
-----------

IF OBJECT_ID('U_EREFMM401K_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EREFMM401K_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PehCurAmt] numeric NULL,
    [PehCurHrs] decimal NULL,
    [PehCurAmtYTD] money NULL,
    [PehCurHrsYTD] decimal NULL,
    [PehInclInDefComp] numeric NULL,
    [PehInclInDefCompHrs] decimal NULL,
    [PehInclInDefCompYTD] numeric NULL,
    [PehInclInDefCompHrsYTD] decimal NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EREFMM401K]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Refresco

Created By: Marie Waters
Business Analyst: Lea King
Create Date: 04/26/2022
Service Request Number: TekP-2022-02-09-01

Purpose: Mass Mutual 401K Payroll Interface

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EREFMM401K';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EREFMM401K';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EREFMM401K';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EREFMM401K';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EREFMM401K' ORDER BY RunID DESC;

UPDATE dbo.AscExp
    SET expLastStartPerControl = '202204191'
       ,expStartPerControl     = '202204191'
       ,expLastEndPerControl   = '202205269'
       ,expEndPerControl       = '202205269'
WHERE expFormatCode = 'EREFMM401K';

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EREFMM401K', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EREFMM401K', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EREFMM401K', 'SCH_EREFMM';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EREFMM401K', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EREFMM401K';

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
    DELETE FROM dbo.U_EREFMM401K_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EREFMM401K_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EREFMM401K_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EREFMM401K_AuditFields;
    CREATE TABLE dbo.U_EREFMM401K_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    
    INSERT INTO dbo.U_EREFMM401K_AuditFields VALUES ('EmpPers','EepAddressLine1');
    INSERT INTO dbo.U_EREFMM401K_AuditFields VALUES ('EmpPers','EepAddressLine2');
    INSERT INTO dbo.U_EREFMM401K_AuditFields VALUES ('EmpPers','EepAddressCity');
    INSERT INTO dbo.U_EREFMM401K_AuditFields VALUES ('EmpPers','EepAddressState');
    INSERT INTO dbo.U_EREFMM401K_AuditFields VALUES ('EmpPers','EepAddressZipCode');
    INSERT INTO dbo.U_EREFMM401K_AuditFields VALUES ('EmpPers','EepAddressCountry');
    INSERT INTO dbo.U_EREFMM401K_AuditFields VALUES ('EmpPers','EepNameFirst');
    INSERT INTO dbo.U_EREFMM401K_AuditFields VALUES ('EmpPers','EepNameLast');
    INSERT INTO dbo.U_EREFMM401K_AuditFields VALUES ('EmpPers','EepNameMiddle');
    INSERT INTO dbo.U_EREFMM401K_AuditFields VALUES ('EmpDed', 'EedBenStartDate');
    INSERT INTO dbo.U_EREFMM401K_AuditFields VALUES ('EmpComp','EecEmplStatus');
    INSERT INTO dbo.U_EREFMM401K_AuditFields VALUES ('EmpPers','EepSSN');
    INSERT INTO dbo.U_EREFMM401K_AuditFields VALUES ('EmpPers','EepGender');
    INSERT INTO dbo.U_EREFMM401K_AuditFields VALUES ('EmpPers','EepDateOfBirth');
    INSERT INTO dbo.U_EREFMM401K_AuditFields VALUES ('EmpPers','EepIsDisabled');
    INSERT INTO dbo.U_EREFMM401K_AuditFields VALUES ('EmpPers','EepMaritalStatus');
    INSERT INTO dbo.U_EREFMM401K_AuditFields VALUES ('EmpPers','EepPhoneHomeHumber');
    INSERT INTO dbo.U_EREFMM401K_AuditFields VALUES ('EmpComp','EecPhoneBusinessNumber')
    INSERT INTO dbo.U_EREFMM401K_AuditFields VALUES ('EmpComp','EecDateOfLastHire');
    INSERT INTO dbo.U_EREFMM401K_AuditFields VALUES ('EmpComp','EecDateOfTermination');
    INSERT INTO dbo.U_EREFMM401K_AuditFields VALUES ('EmpComp','EecEmplStatusStartDate');
    INSERT INTO dbo.U_EREFMM401K_AuditFields VALUES ('EmpPers','eepAddressEMail');
    INSERT INTO dbo.U_EREFMM401K_AuditFields VALUES ('EmpPers','eepAddressEMailAlternate');


    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EREFMM401K_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EREFMM401K_Audit;
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
        ,audNewHire = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = '' AND ISNULL(audNewValue,'') = 'A' THEN 'Y' ELSE 'N' END
        ,audTermintation = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audNewValue,'') = 'T' THEN 'Y' ELSE 'N' END
        ,audBenefitChange = CASE WHEN audTableName = 'EmpDedFull' AND audFieldName = 'EedBenStartDate' AND ISNULL(audOldValue, '') <> ISNULL(audNewValue, '') THEN 'Y' ELSE 'N' END
    INTO dbo.U_EREFMM401K_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EREFMM401K_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN DATEADD(DAY,-14,@StartDate) AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EREFMM401K_Audit ON dbo.U_EREFMM401K_Audit (audEEID,audKey2);

    --================
    -- Changes Only
    --================
    --DELETE FROM dbo.U_EREFMM401K_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EREFMM401K_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '401KP,4CU2,401KA,4CU3,401PM,ROTH2,RCU2,P4L1,P4L2,P4L3';

    IF OBJECT_ID('U_EREFMM401K_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EREFMM401K_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EREFMM401K_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON  DedDedCode = Item;

    --==========================================
    -- Build Working Tables
    --==========================================
            
        --Code    Category    eeddedcode
        --"01"    Employee      401KP or 4CU2
        --"02"    Matching      401PM
        --"05"    After_tax     401KA or 4CU3
        --"09"    Loan          P4L1, P4L2 or P4L3
        --"10"    Roth          ROTH2 or RCU2
        
    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EREFMM401K_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EREFMM401K_PDedHist;
    SELECT DISTINCT
         PdhEEID
        ,PdhCategoryCode = Case WHEN PdhDedCode IN ('401KP','4CU2') THEN '01'
                                WHEN PdhDedCode IN ('401KA','4CU3') THEN '05'
                                WHEN PdhDedCode IN ('P4L1','P4L2','P4L3') THEN '09'
                                WHEN PdhDedCode IN ('ROTH2','RCU2') THEN '10'
                                END
        -- Current Payroll Amounts
        ,PdhEECurAmt        = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
    INTO dbo.U_EREFMM401K_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EREFMM401K_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    -- LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    --      AND PdhPerControl <= @EndPerControl
    --      AND 
    WHERE      PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID, Case WHEN PdhDedCode IN ('401KP','4CU2') THEN '01'
                                WHEN PdhDedCode IN ('401KA','4CU3') THEN '05'
                                WHEN PdhDedCode IN ('P4L1','P4L2','P4L3') THEN '09'
                                WHEN PdhDedCode IN ('ROTH2','RCU2') THEN '10'
                                END
    HAVING  SUM(PdhEECurAmt) <> 0.00 

    Union all
        SELECT DISTINCT
         PdhEEID
        ,PdhCategoryCode = Case WHEN PdhDedCode IN ('401PM') THEN '02'END
        -- Current Payroll Amounts
        ,PdhEECurAmt        = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
   
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EREFMM401K_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    -- LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    --      AND PdhPerControl <= @EndPerControl
    --      AND 
    WHERE      PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID, Case WHEN PdhDedCode IN ('401PM') THEN '02'END
    HAVING  SUM(PdhERCurAmt) <> 0.00 
   ;


    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EREFMM401K_B_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EREFMM401K_B_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EREFMM401K_B_drvTbl;
    SELECT DISTINCT
       --  drvEEID = xEEID
       -- ,drvCoID = xCoID
       -- ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
         drvSort = PdhCategoryCode
        ,drvSubSort = ''
        ,drvSubsort2 = ''
        -- standard fields above and additional driver fields below
        ,drvCategory = PdhCategoryCode
        ,drvAmount =  substring('000000000',1,12-len(cast(Cast(sum(PdhEECurAmt) as Decimal(12,2)) as varchar(12)))) + cast(Cast(sum(PdhEECurAmt) as Decimal(12,2)) as varchar(12))
    INTO dbo.U_EREFMM401K_B_drvTbl
    FROM dbo.U_EREFMM401K_EEList WITH (NOLOCK)
    JOIN dbo.U_EREFMM401K_PDedHist WITH (NOLOCK)
        ON  PdhEEID = xEEID
    Group by PdhCategoryCode
    Having  SUM(PdhEECurAmt) <> 0.00 
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EREFMM401K_C_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EREFMM401K_C_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EREFMM401K_C_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
      --  ,drvCoID = xCoID
       -- ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = eepSSN
        ,drvSubSort = PdhCategoryCode
        ,drvSubsort2 = ''
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvCategory = PdhCategoryCode
        ,drvAmount = substring('000000000',1,12-len(cast(Cast(sum(PdhEECurAmt) as Decimal(12,2)) as varchar(12)))) + cast(Cast(sum(PdhEECurAmt) as Decimal(12,2)) as varchar(12))
    INTO dbo.U_EREFMM401K_C_drvTbl
    FROM dbo.U_EREFMM401K_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_EREFMM401K_PDedHist WITH (NOLOCK)
        ON xEEID = PdhEEID
    Group By xEEID,  eepSSN, PdhCategoryCode
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EREFMM401K_D_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EREFMM401K_D_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EREFMM401K_D_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        --,drvCoID = xCoID
      --  ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = eepSSN
        ,drvSubSort = ''
        ,drvSubsort2 = ''
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvNameLast = EepNameLast
        ,drvNameFirst = EepNameFirst
        ,drvBirthDate = EepDateOfBirth
        ,drvHireDate = EecDateOfLastHire
        ,drvStatusDate = EecEmplStatusStartDate
        ,drvStatus = CASE WHEN EecEmplStatus = 'L' THEN 'Leave of Ab'
                          WHEN EecEmplStatus = 'T' and eectermreason = '203' THEN 'Deceased'
                          WHEN EecEmplStatus = 'T' and eectermreason <> '203' THEN 'Terminated'
                          ELSE 'Active'
                        END
        ,drvAddress1 = EepAddressLine1
        ,drvAddress2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZipCode = EepAddressZipCode
        ,drvMaritalStatus = CASE WHEN (eepmaritalstatus <> 'S' or eepmaritalstatus <> 'M') THEN 'Unknown'
                                 ELSE 
                                    Case WHEN eepmaritalstatus = 'M' THEN 'Married' ELSE 'Single' 
                                        END 
                                END

        ,drvPhone = CASE WHEN (eepAddressEMail IS NULL or eepphonehomenumber <> ' ' ) THEN eepphonehomenumber ELSE EecPhoneBusinessNumber  END
        ,drvEmail = CASE WHEN (eepAddressEMail IS NULL or eepAddressEMail <> ' ' )  THEN eepAddressEMail else eepAddressEMailAlternate END
    INTO dbo.U_EREFMM401K_D_drvTbl
    FROM dbo.U_EREFMM401K_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_EREFMM401K_Audit WITH (NOLOCK)
        ON audEEID = xEEID
        AND audKey2 = xCOID
    JOIN dbo.U_EREFMM401K_PDedHist WITH (NOLOCK)
        ON xEEID = PdhEEID
        
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EREFMM401K_I_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EREFMM401K_I_Header;
    SELECT DISTINCT
         drvFileIDCode =  CASE WHEN @ExportCode LIKE '%TEST%' THEN 'X3' ELSE '03' END
    INTO dbo.U_EREFMM401K_I_Header
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EREFMM401K_A_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EREFMM401K_A_Header;
      SELECT DISTINCT
         drvCompanyCode = '0242'
        ,drvCompanyName = 'Refresco'
        ,drvPayDate = @EndPerControl --MAX(PrgPayDate)
        ,drvCoversFrom = @StartPerControl --Max(prgperiodstartdate)
        ,drvCoversTo = @EndPerControl --Max(prgperiodenddate)
    INTO dbo.U_EREFMM401K_A_Header
    FROM dbo.Payreg WITH (NOLOCK)
    --Where PrgPayDate = @StartDate

    
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
ALTER VIEW dbo.dsi_vwEREFMM401K_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EREFMM401K_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EREFMM401K%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202204191'
       ,expStartPerControl     = '202204191'
       ,expLastEndPerControl   = '202205269'
       ,expEndPerControl       = '202205269'
WHERE expFormatCode = 'EREFMM401K';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEREFMM401K_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EREFMM401K_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort, SubSort2

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EREFMM401K' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EREFMM401K'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EREFMM401K'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EREFMM401K', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EREFMM401K', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EREFMM401K', 'UseFileName', 'V', 'Y'


-- End ripout