/**********************************************************************************

EBETBWCTC2: BW HSA Distribution Export

FormatCode:     EBETBWCTC2
Project:        BW HSA Distribution Export
Client ID:      BET1008
Date/time:      2023-12-27 16:01:49.727
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    NWP
Server:         NW1WUP7DB03
Database:       ULTIPRO_WPBETB
Web Filename:   BET1008_SC6HO_EEHISTORY_EBETBWCTC2_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EBETBWCTC2_SavePath') IS NOT NULL DROP TABLE dbo.U_EBETBWCTC2_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EBETBWCTC2'


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
WHERE FormatCode = 'EBETBWCTC2'
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
WHERE ExpFormatCode = 'EBETBWCTC2'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EBETBWCTC2')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EBETBWCTC2'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EBETBWCTC2'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EBETBWCTC2'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EBETBWCTC2'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EBETBWCTC2'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EBETBWCTC2'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EBETBWCTC2'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EBETBWCTC2'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EBETBWCTC2'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEBETBWCTC2_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEBETBWCTC2_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EBETBWCTC2') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EBETBWCTC2];
GO
IF OBJECT_ID('U_EBETBWCTC2_T09') IS NOT NULL DROP TABLE [dbo].[U_EBETBWCTC2_T09];
GO
IF OBJECT_ID('U_EBETBWCTC2_H01') IS NOT NULL DROP TABLE [dbo].[U_EBETBWCTC2_H01];
GO
IF OBJECT_ID('U_EBETBWCTC2_File') IS NOT NULL DROP TABLE [dbo].[U_EBETBWCTC2_File];
GO
IF OBJECT_ID('U_EBETBWCTC2_EEList') IS NOT NULL DROP TABLE [dbo].[U_EBETBWCTC2_EEList];
GO
IF OBJECT_ID('U_EBETBWCTC2_Ded') IS NOT NULL DROP TABLE [dbo].[U_EBETBWCTC2_Ded];
GO
IF OBJECT_ID('U_EBETBWCTC2_Data') IS NOT NULL DROP TABLE [dbo].[U_EBETBWCTC2_Data];
GO
IF OBJECT_ID('U_EBETBWCTC2_D02') IS NOT NULL DROP TABLE [dbo].[U_EBETBWCTC2_D02];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0',NULL,NULL,'N',NULL,'N',NULL,'013010','EMPEXPORT','SDF','EBETBWCTC2','BW HSA Distribution Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','150','S','N','EBETBWCTC2Y0','N',NULL,'C','dbo.dsi_sp_SwitchBox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EBETBWCTC2Y0','3','H','01','1',NULL,NULL,NULL,NULL,'"drvRecord_Type_1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EBETBWCTC2Y0','8','H','01','4',NULL,NULL,NULL,NULL,'"drvCreation_Date_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EBETBWCTC2Y0','3','H','01','12',NULL,NULL,NULL,NULL,'"drvSource_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EBETBWCTC2Y0','3','H','01','15',NULL,NULL,NULL,NULL,'"drvEmployer_ID_4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EBETBWCTC2Y0','4','H','01','18',NULL,NULL,NULL,NULL,'"drvDestination_5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EBETBWCTC2Y0','9','H','01','22',NULL,NULL,NULL,NULL,'"drvFile_Control_Number_6"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EBETBWCTC2Y0','8','H','01','31',NULL,NULL,NULL,NULL,'"drvPayroll_Effective_Date_7"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EBETBWCTC2Y0','60','H','01','39',NULL,NULL,NULL,NULL,'"drvFile_Descriptor_8"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EBETBWCTC2Y0','4','H','01','99',NULL,NULL,NULL,NULL,'"drvCustomer_9"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EBETBWCTC2Y0','3','H','01','103',NULL,NULL,NULL,NULL,'"drvHealth_Provider_Code_10"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EBETBWCTC2Y0','45','H','01','106',NULL,NULL,NULL,NULL,'"drvFiller_11"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EBETBWCTC2Y0','3','D','02','1',NULL,NULL,NULL,NULL,'"drvRecord_Type_1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EBETBWCTC2Y0','25','D','02','4',NULL,NULL,NULL,NULL,'"drvPayroll_Employee_ID_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EBETBWCTC2Y0','1','D','02','29',NULL,NULL,NULL,NULL,'"drvFunding_Source_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EBETBWCTC2Y0','2','D','02','30',NULL,NULL,NULL,NULL,'"drvTransaction_Type_4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EBETBWCTC2Y0','12','D','02','32',NULL,NULL,NULL,NULL,'"drvAmount_5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EBETBWCTC2Y0','45','D','02','44',NULL,NULL,NULL,NULL,'"drvDescription_6"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EBETBWCTC2Y0','8','D','02','89',NULL,NULL,NULL,NULL,'"drvEffective_Date_7"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EBETBWCTC2Y0','54','D','02','97',NULL,NULL,NULL,NULL,'"drvFiller_8"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EBETBWCTC2Y0','3','T','09','1',NULL,NULL,NULL,NULL,'"drvRecord_Type_1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EBETBWCTC2Y0','3','T','09','4',NULL,NULL,NULL,NULL,'"drvSource_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EBETBWCTC2Y0','4','T','09','7',NULL,NULL,NULL,NULL,'"drvDestination_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EBETBWCTC2Y0','13','T','09','11',NULL,NULL,NULL,NULL,'"drvRecord_Count_4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EBETBWCTC2Y0','9','T','09','24',NULL,NULL,NULL,NULL,'"drvFile_Control_Number_5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EBETBWCTC2Y0','16','T','09','33',NULL,NULL,NULL,NULL,'"drvDebit_Total_6"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EBETBWCTC2Y0','16','T','09','49',NULL,NULL,NULL,NULL,'"drvCredit_Total_7"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EBETBWCTC2Y0','60','T','09','65',NULL,NULL,NULL,NULL,'"drvTrailer_Description_8"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EBETBWCTC2Y0','26','T','09','125',NULL,NULL,NULL,NULL,'"drvFiller_9"','(''UA''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EBETBWCTC2_20231227.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N',NULL,NULL,NULL,NULL,'Test- Wednesday Auto Run','201907269','EMPEXPORT','AUTORUN','Jul 25 2019 12:00AM','EBETBWCTC2',NULL,NULL,NULL,'202001089','Jul 26 2019 12:00AM','Jul 27 2019 12:00AM','202001011',NULL,NULL,NULL,'201907261',dbo.fn_GetTimedKey(),NULL,'ULTI_WPLCNI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Test- Create On Demand Export','202301079','EMPEXPORT','On_Demand','Jun 22 2022  1:36PM','EBETBWCTC2',NULL,NULL,NULL,'202301079','Jun 23 2022 12:00AM','Jun 18 2022 12:00AM','202301011','218',NULL,NULL,'202301011',dbo.fn_GetTimedKey(),NULL,'ULTI_WPBETB',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Test File Only','202312279','EMPEXPORT','TEST_XOE','Jul 17 2023 12:00AM','EBETBWCTC2',NULL,NULL,NULL,'202310259','Jul 17 2023 12:00AM','Dec 30 1899 12:00AM','202310011',NULL,'','','202310011',dbo.fn_GetTimedKey(),NULL,'',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBETBWCTC2','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBETBWCTC2','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBETBWCTC2','InitialSort','C','SPACE(0)');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBETBWCTC2','SubSort','C','SPACE(0)');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBETBWCTC2','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBETBWCTC2','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBETBWCTC2','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBETBWCTC2','H01','dbo.U_EBETBWCTC2_H01',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBETBWCTC2','D02','dbo.U_EBETBWCTC2_D02',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBETBWCTC2','T09','dbo.U_EBETBWCTC2_T09',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EBETBWCTC2_D02
-----------

IF OBJECT_ID('U_EBETBWCTC2_D02') IS NULL
CREATE TABLE [dbo].[U_EBETBWCTC2_D02] (
    [EEID] char(12) NULL,
    [COID] char(5) NULL,
    [DedCode] varchar(3) NULL,
    [drvRecord_Type_1] varchar(3) NOT NULL,
    [drvPayroll_Employee_ID_2] char(11) NULL,
    [drvFunding_Source_3] char(1) NULL,
    [drvTransaction_Type_4] varchar(2) NOT NULL,
    [drvAmount_5] varchar(24) NULL,
    [drvRawAmount] money NULL,
    [drvDescription_6] varchar(1) NOT NULL,
    [drvEffective_Date_7] varchar(1) NOT NULL,
    [drvFiller_8] varchar(1) NOT NULL
);

-----------
-- Create table U_EBETBWCTC2_Data
-----------

IF OBJECT_ID('U_EBETBWCTC2_Data') IS NULL
CREATE TABLE [dbo].[U_EBETBWCTC2_Data] (
    [EEID] char(12) NULL,
    [COID] char(5) NULL,
    [DedCode] varchar(3) NULL,
    [DedType] varchar(3) NULL,
    [FundingSource] char(1) NULL,
    [PerControl] char(9) NULL,
    [EEAmt] money NULL,
    [ERAmt] money NULL
);

-----------
-- Create table U_EBETBWCTC2_Ded
-----------

IF OBJECT_ID('U_EBETBWCTC2_Ded') IS NULL
CREATE TABLE [dbo].[U_EBETBWCTC2_Ded] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EBETBWCTC2_EEList
-----------

IF OBJECT_ID('U_EBETBWCTC2_EEList') IS NULL
CREATE TABLE [dbo].[U_EBETBWCTC2_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EBETBWCTC2_File
-----------

IF OBJECT_ID('U_EBETBWCTC2_File') IS NULL
CREATE TABLE [dbo].[U_EBETBWCTC2_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(150) NULL
);

-----------
-- Create table U_EBETBWCTC2_H01
-----------

IF OBJECT_ID('U_EBETBWCTC2_H01') IS NULL
CREATE TABLE [dbo].[U_EBETBWCTC2_H01] (
    [drvRecord_Type_1] varchar(3) NOT NULL,
    [drvCreation_Date_2] char(8) NULL,
    [drvSource_3] varchar(3) NOT NULL,
    [drvEmployer_ID_4] varchar(3) NOT NULL,
    [drvDestination_5] varchar(4) NOT NULL,
    [drvFile_Control_Number_6] varchar(9) NULL,
    [drvPayroll_Effective_Date_7] varchar(8) NULL,
    [drvFile_Descriptor_8] varchar(1) NOT NULL,
    [drvCustomer_9] varchar(4) NOT NULL,
    [drvHealth_Provider_Code_10] varchar(3) NOT NULL,
    [drvFiller_11] varchar(1) NOT NULL
);

-----------
-- Create table U_EBETBWCTC2_T09
-----------

IF OBJECT_ID('U_EBETBWCTC2_T09') IS NULL
CREATE TABLE [dbo].[U_EBETBWCTC2_T09] (
    [drvRecord_Type_1] varchar(3) NOT NULL,
    [drvSource_2] varchar(3) NOT NULL,
    [drvDestination_3] varchar(4) NOT NULL,
    [drvRecord_Count_4] varchar(24) NULL,
    [drvFile_Control_Number_5] varchar(9) NULL,
    [drvDebit_Total_6] varchar(16) NOT NULL,
    [drvCredit_Total_7] varchar(24) NULL,
    [drvTrailer_Description_8] varchar(1) NOT NULL,
    [drvFiller_9] varchar(1) NOT NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EBETBWCTC2]
                @SystemID CHAR(12) = NULL
AS

BEGIN
/* ------------------------------------------------------------------------------------------------------
Client Name: Betenbough

Created By: Gaspare Simeti
Business Analyst: Gaspare Simeti
Create Date: 05/16/22
Service Request Number: 00238811 and 00238823

Purpose: Benefit Wallet HSA Test

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2019     SR-2019-000XXXXX   XXXXX
Jeremy Walker        01/23/2023       SR-2022-00389514      Added code HSA
 Marie Waters        12/27/2023        TekP-2023-10-09-03        Added  EEPUDFIELD09 = '3' to where clauses


EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBETBWCTC2', 'ZAP'
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBETBWCTC2', 'On_Demand'
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBETBWCTC2', 'Scheduled' --Biweekly, Wednesday 3 AM Cycle Starts 20110429
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBETBWCTC2','TEST_XOE';



SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EBETBWCTC2';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EBETBWCTC2';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EBETBWCTC2';
SELECT * FROM dbo.AscExp WHERE expFormatCode = 'EBETBWCTC2';

SELECT top 200 * FROM dbo.U_dsi_InterfaceActivityLog where FormatCode = 'EBETBWCTC2' ORDER BY RunID DESC;

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EBETBWCTC2', @AllObjects = 'Y', @IsWeb = 'Y'

---------------------------------------------------------------------------------------------------------*/
--DECLARE @SystemID CHAR(12)
--SELECT @SystemID = systemid FROM U_DSI_Parameters WHERE formatcode = ' EBETBWCTC2'

--
-- SET VARIABLES FOR FIELDS IN U_DSI_PARAMETERS
DECLARE @EndPercontrol VARCHAR(9)
        ,@ExportCode VARCHAR(10)
        ,@StartDate DATETIME
        ,@EndDate DATETIME
        ,@StartPercontrol VARCHAR(9)
        ,@FormatCode VARCHAR(10)
SELECT   @ExportCode = ExportCode
        ,@StartPercontrol = CASE WHEN @ExportCode = 'AUTORUN' THEN STR(CONVERT(CHAR(8),DATEADD(dd,+0,GETDATE()),112),8) + '1' ELSE StartPerControl END
        ,@EndPercontrol = CASE WHEN @ExportCode = 'AUTORUN' THEN STR(CONVERT(CHAR(8),DATEADD(dd,+2,GETDATE()),112),8) + '9' ELSE EndPerControl END
        ,@StartDate = CAST(LEFT(@StartPerControl,8) AS DATETIME)
        ,@EndDate = CAST(LEFT(@EndPerControl,8) AS DATETIME)
        ,@FormatCode = FormatCode
FROM    U_Dsi_Parameters WITH (NOLOCK)
WHERE   SystemID = @SystemID

PRINT @ExportCode;
PRINT @StartPerControl;
PRINT @EndPerControl;

/* ---------------------------------------------------------------------------------------------------
    Load Date variables. Set Start and End to Beginning and End of day.
------------------------------------------------------------------------------------------------------*/
SET @StartDate = CONVERT(CHAR(8),@StartDate,112)
SET @EndDATE = DATEADD(ss,-1,DATEADD(dd,+1,CONVERT(CHAR(8),@EndDate,112)))

DECLARE @ExportDate DATETIME
SET @ExportDate = GETDATE()

DECLARE @ExportTime CHAR(8)
SET @ExportTime = CONVERT(CHAR(8),@ExportDate,14)  --hh:mm:ss  zero filled

DECLARE @ExpireDate DATETIME
SET @ExpireDate = DATEADD(dd,-14,@ExportDate)

DECLARE @ExportFile VARCHAR(200)
SET @ExportFile = 
    'Laird_Mellon_Dist_Export_'
    + REPLACE(CONVERT(CHAR(8),@ExportDate,1),'/','')

/* --------------------------------------------------------------------------------------------------------
    Load benefit plan data included in this export into _Ded table.
----------------------------------------------------------------------------------------------------------- */
DECLARE @DedList VARCHAR(MAX)
SET @DedList = 'HSAI,HSAF,HSAIC,HSAFC,HSA'

IF  EXISTS(    SELECT * FROM Sys.Objects 
            WHERE Object_Id = Object_Id(N'[dbo].[U_EBETBWCTC2_Ded]') 
                  AND Type = 'u'    )
    DROP TABLE dbo.U_EBETBWCTC2_Ded

SELECT DedDedCode DedCode, DedDedType DedType

INTO dbo.U_EBETBWCTC2_Ded

FROM dbo.DedCode DED WITH (NOLOCK)

WHERE 
    DedDedCode IN(SELECT item FROM dbo.fn_ListToTable(@DedList))
 
/* --------------------------------------------------------------------------------------------------------
    Create empty _Data Table
----------------------------------------------------------------------------------------------------------- */
IF  EXISTS(    SELECT * FROM Sys.Objects 
            WHERE Object_Id = Object_Id(N'[dbo].[U_EBETBWCTC2_Data]') 
                  AND Type = 'u'    )
    DROP TABLE dbo.U_EBETBWCTC2_Data

SELECT TOP 0
    EEID = EE.xEEID
    ,COID = EE.xCOID
    ,DedCode = MAX(CASE EED.EedDedCode
                    WHEN 'HSA' THEN 'HSA'
                    --WHEN 'HSAI' THEN 'HSAI'
                    --WHEN 'HSAIC' THEN 'HSAI' --catchup contribs
                    --WHEN 'HSAF' THEN 'HSAF'
                    --WHEN 'HSAFC' THEN 'HSAF' --catchup contribs
                    --WHEN 'HSAER' THEN 'HSAER' --added 7/15/19 wc
                    END)
    ,DedType = MAX('HSA')--MAX(Ded.DedType)   
    ,FundingSource = CAST(NULL AS CHAR(1))
    ,PerControl = CAST(NULL AS CHAR(9))
    ,EEAmt = SUM(EED.EedEEAmt)
    ,ERAmt = SUM(EED.EedERAmt)
    
INTO dbo.U_EBETBWCTC2_Data

FROM dbo.U_EBETBWCTC2_EEList EE

    JOIN dbo.U_EBETBWCTC2_Ded DED WITH (NOLOCK)
        ON 1=1

    JOIN dbo.EmpDed EED WITH (NOLOCK)
        ON EE.xEEID = EED.EedEEID AND EE.xCOID = EED.EedCOID
            AND DED.DedCode = EED.EedDedCode
    
GROUP BY
    EE.xEEID
    ,EE.xCOID
    ,EED.EedDedCode

/* --------------------------------------------------------------------------------------------------------
    Load Qualified Employees Perm Plans into _Data table.

    A record should be on the file if any of the deduction codes is in the list below:
    
    Deduction Code    Description
    HSACU    Health Savings Account Catch Up -- NOT USED
    HSAFM/HSAFC    Health Savings Account - Family
    HSASF/HSASC    Health Savings Account - Self
    
    AND 

    Contributions for employee > 0 or contributions for employer > 0
    
    Defined as:
    PdhDedCode in (‘HSACU’,’HSAFM’,’HSASF’) and (PDhEECurAmt > 0 or PDhEECurAmt > 0)
----------------------------------------------------------------------------------------------------------- */

INSERT INTO dbo.U_EBETBWCTC2_Data
SELECT
    EEID = EE.xEEID
    ,COID = EE.xCOID
    ,DedCode = MAX(CASE PDH.PdhDedCode
                    WHEN 'HSA' THEN 'HSA'
                    --WHEN 'HSAI' THEN 'HSAI'
                    --WHEN 'HSAIC' THEN 'HSAI' --catchup contribs
                    --WHEN 'HSAF' THEN 'HSAF'
                    --WHEN 'HSAFC' THEN 'HSAF' --catchup contribs
                    --WHEN 'HSAER' THEN 'HSAER' --added 7/15/19 wc
                    END)
    ,DedType = MAX('HSA') --MAX(Ded.DedType)
    ,FundingSource = '1'
    ,PerControl = MAX(PDH.PdhPerControl)
    ,EEAmt = SUM(ABS(ISNULL(PDH.PdhEECurAmt,0)))
    ,ERAmt = 0
    
FROM dbo.U_EBETBWCTC2_EEList EE

    JOIN dbo.U_EBETBWCTC2_Ded DED WITH (NOLOCK)
        ON 1=1

    JOIN dbo.EmpComp EEC WITH (NOLOCK)
        ON EE.xEEID = EEC.EecEEID AND EE.xCOID = EEC.EecCOID

    JOIN dbo.PDedHist PDH WITH (NOLOCK)
        ON EE.xEEID = PDH.PdhEEID AND EE.xCOID = PDH.PdhCOID
            AND Ded.DedCode = PDH.PdhDedCode
    JOIN dbo.EmpPers WITH (NOLOCK) -- MW Added 12/27/2023
        ON EepEEID = EE.xEEID
WHERE 
    (ABS(PDH.PdhEECurAmt) > 0) AND PDH.PdhDedCode = 'HSA'
    AND PDH.PdhPerControl BETWEEN @StartPerControl AND @EndPerControl
    AND EEPUDFIELD09 = '3'-- MW Added 12/27/2023
GROUP BY
    EE.xEEID
    ,EE.xCOID

INSERT INTO dbo.U_EBETBWCTC2_Data -- select * from dbo.U_EBETBWCTC2_Data order by EEID
SELECT
    EEID = EE.xEEID
    ,COID = EE.xCOID
    ,DedCode = 'HSA'/*MAX(CASE PDH.PdhDedCode
                    WHEN 'HSAI' THEN 'HSAI'
                    WHEN 'HSAIC' THEN 'HSAI' --catchup contribs
                    WHEN 'HSAF' THEN 'HSAF'
                    WHEN 'HSAFC' THEN 'HSAF' --catchup contribs
                    WHEN 'HSAER' THEN 'HSAER' --added 7/15/19 wc
                    END)*/
    ,DedType = MAX('HSA') --MAX(Ded.DedType)
    ,FundingSource = '2'
    ,PerControl = MAX(PDH.PdhPerControl)
    ,EEAmt = 0
    ,ERAmt = SUM(ABS(ISNULL(PDH.PdhERCurAmt,0))) --7/15/19 adjusted for HSAER 
    
FROM dbo.U_EBETBWCTC2_EEList EE

    JOIN dbo.U_EBETBWCTC2_Ded DED WITH (NOLOCK)
        ON 1=1

    JOIN dbo.EmpComp EEC WITH (NOLOCK)
        ON EE.xEEID = EEC.EecEEID AND EE.xCOID = EEC.EecCOID

    JOIN dbo.PDedHist PDH WITH (NOLOCK)
        ON EE.xEEID = PDH.PdhEEID AND EE.xCOID = PDH.PdhCOID
            AND Ded.DedCode = PDH.PdhDedCode
    JOIN dbo.EmpPers WITH (NOLOCK) -- MW Added 12/27/2023
        ON EepEEID = EE.xEEID
WHERE 
    (ABS(PDH.PdhERCurAmt) > 0) AND PDH.PdhDedCode = 'HSA'
    AND PDH.PdhPerControl BETWEEN @StartPerControl AND @EndPerControl
    AND EEPUDFIELD09 = '3' -- MW Added 12/27/2023
GROUP BY
    EE.xEEID
    ,EE.xCOID
    
/* ---------------------------------------------------------------------------------------------------
    Load Header into U_EBETBWCTC2_H01.
------------------------------------------------------------------------------------------------------*/
IF  EXISTS ( SELECT * FROM sys.objects 
             WHERE object_id = OBJECT_ID(N'[dbo].[U_EBETBWCTC2_H01]') 
             AND TYPE = 'U'    )
    DROP TABLE dbo.U_EBETBWCTC2_H01

SELECT 

    drvRecord_Type_1 = '00Q' 
    ,drvCreation_Date_2 = CONVERT(CHAR(8),@ExportDate,112)
    ,drvSource_3 = '6RR' 
    ,drvEmployer_ID_4 = '6RR' 
    ,drvDestination_5 = '0MEL' 
    ,drvFile_Control_Number_6 = REPLICATE('0',9) 
    ,drvPayroll_Effective_Date_7 = LEFT(Data.PerControl,8)
    ,drvFile_Descriptor_8 = '' 
    ,drvCustomer_9 = '9500' 
    ,drvHealth_Provider_Code_10 = '003' 
    ,drvFiller_11 = ''         

INTO dbo.U_EBETBWCTC2_H01

FROM 
    (    SELECT MAX(PerControl) PerControl
        FROM dbo.U_EBETBWCTC2_Data
        GROUP BY PerControl) Data
    
/* ---------------------------------------------------------------------------------------------------
    Load Employee into U_EBETBWCTC2_D02.
------------------------------------------------------------------------------------------------------*/
IF  EXISTS ( SELECT * FROM sys.objects 
             WHERE object_id = OBJECT_ID(N'[dbo].[U_EBETBWCTC2_D02]') 
             AND TYPE = 'U'    )
    DROP TABLE dbo.U_EBETBWCTC2_D02 -- select eepnamefirst, eepnamelast, drvRawAmount from dbo.U_EBETBWCTC2_D02 join EmpPers on Eepeeid = eeid

SELECT 
    EEID = Data.EEID
    ,COID = Data.COID
    ,DedCode = Data.DedCode

    ,drvRecord_Type_1 = '03D'
    ,drvPayroll_Employee_ID_2 = EEP.EepSSN
    ,drvFunding_Source_3 = Data.FundingSource
    ,drvTransaction_Type_4 = 'CR'
    ,drvAmount_5 = 
        CASE 
            WHEN Data.FundingSource = '1' THEN dbo.dsi_fnPadZero(Data.EEAmt,12,2)    
            ELSE dbo.dsi_fnPadZero(Data.ERAmt,12,2)
        END
    ,drvRawAmount = CASE 
            WHEN Data.FundingSource = '1' THEN Data.EEAmt   
            ELSE Data.ERAmt
        END
    ,drvDescription_6 = ''
    ,drvEffective_Date_7 = ''
    ,drvFiller_8 = ''

INTO dbo.U_EBETBWCTC2_D02

FROM dbo.U_EBETBWCTC2_Data Data -- select * from dbo.U_EBETBWCTC2_Data order by EEID

    JOIN dbo.EmpPers EEP WITH (NOLOCK)
        ON Data.EEID = EEP.EepEEID
        --AND Data.COID = EEP.EepHomeCOID
    JOIN dbo.EmpComp EEC WITH (NOLOCK)
        ON Data.EEID = EEC.EecEEID
        AND Data.COID = EEC.EecCOID
    WHERE EEC.Eecudfield05 IS NULL
        -- select eecudfield05, * from EmpComp
        AND EEPUDFIELD09 = '3' -- MW Added 12/27/2023
ORDER BY 
    EEP.EepSSN
    ,Data.FundingSource

/*---------------------------------------------------------------------------------------------------
    Load Trailer into U_EBETBWCTC2_T09.
------------------------------------------------------------------------------------------------------*/
IF EXISTS(SELECT * FROM sys.objects
        WHERE object_id=OBJECT_ID(N'[dbo].[U_EBETBWCTC2_T09]')
            AND TYPE='U'    )
    DROP TABLE dbo.U_EBETBWCTC2_T09

SELECT
    drvRecord_Type_1 = '99T'
    ,drvSource_2 = '6RR'
    ,drvDestination_3 = '0MEL'
    ,drvRecord_Count_4 = (SELECT dbo.dsi_fnPadZero(COUNT(*),13,0) FROM dbo.U_EBETBWCTC2_D02)
    ,drvFile_Control_Number_5 = REPLICATE('0',9)
    ,drvDebit_Total_6 = '0000000000000.00'
    ,drvCredit_Total_7 = (SELECT dbo.dsi_fnPadZero(SUM(drvRawAmount),16,2) FROM dbo.U_EBETBWCTC2_D02)
    ,drvTrailer_Description_8 = ''
    ,drvFiller_9 = ''

INTO dbo.U_EBETBWCTC2_T09
    
/* ---------------------------------------------------------------------------------------------------
  Force Filename.
------------------------------------------------------------------------------------------------------*/
--UPDATE dbo.U_Dsi_Parameters
--SET ExportFile = @ExportFile
--WHERE FormatCode = @FormatCode


END
GO
Create View dbo.dsi_vwEBETBWCTC2_Export as
        select top 2000000 Data from dbo.U_EBETBWCTC2_File with (nolock)
        order by substring(RecordSet,2,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EBETBWCTC2' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EBETBWCTC2'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EBETBWCTC2'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EBETBWCTC2', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EBETBWCTC2', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EBETBWCTC2', 'UseFileName', 'V', 'Y'


-- End ripout