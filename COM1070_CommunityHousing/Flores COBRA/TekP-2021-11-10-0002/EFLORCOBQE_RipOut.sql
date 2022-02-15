/**********************************************************************************

EFLORCOBQE: Flores COBRA Export

FormatCode:     EFLORCOBQE
Project:        Flores COBRA Export
Client ID:      COM1070
Date/time:      2022-02-14 18:07:27.717
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW4WUP5DB01
Database:       ULTIPRO_WPCHPCO
Web Filename:   COM1070_K7VUJ_EEHISTORY_EFLORCOBQE_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EFLORCOBQE_SavePath') IS NOT NULL DROP TABLE dbo.U_EFLORCOBQE_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EFLORCOBQE'


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
WHERE FormatCode = 'EFLORCOBQE'
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
WHERE ExpFormatCode = 'EFLORCOBQE'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EFLORCOBQE')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EFLORCOBQE'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EFLORCOBQE'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EFLORCOBQE'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EFLORCOBQE'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EFLORCOBQE'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EFLORCOBQE'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EFLORCOBQE'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EFLORCOBQE'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EFLORCOBQE'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEFLORCOBQE_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEFLORCOBQE_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EFLORCOBQE') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EFLORCOBQE];
GO
IF OBJECT_ID('U_EFLORCOBQE_File') IS NOT NULL DROP TABLE [dbo].[U_EFLORCOBQE_File];
GO
IF OBJECT_ID('U_EFLORCOBQE_EEList') IS NOT NULL DROP TABLE [dbo].[U_EFLORCOBQE_EEList];
GO
IF OBJECT_ID('U_EFLORCOBQE_drvInsured') IS NOT NULL DROP TABLE [dbo].[U_EFLORCOBQE_drvInsured];
GO
IF OBJECT_ID('U_EFLORCOBQE_drvElection') IS NOT NULL DROP TABLE [dbo].[U_EFLORCOBQE_drvElection];
GO
IF OBJECT_ID('U_EFLORCOBQE_drvDependent') IS NOT NULL DROP TABLE [dbo].[U_EFLORCOBQE_drvDependent];
GO
IF OBJECT_ID('U_EFLORCOBQE_coverage') IS NOT NULL DROP TABLE [dbo].[U_EFLORCOBQE_coverage];
GO
IF OBJECT_ID('U_dsi_BDM_EFLORCOBQE') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EFLORCOBQE];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EFLORCOBQE','Flores COBRA Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','EFLORCOBQEZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EFLORCOBQEZ0','50','D','10','1',NULL,'Insured Identifier',NULL,NULL,'"drv10InsuredIdent"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EFLORCOBQEZ0','50','D','10','2',NULL,'Employee ID Number',NULL,NULL,'"drv10EmpIdNum"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EFLORCOBQEZ0','50','D','10','3',NULL,'Last Name',NULL,NULL,'"drv10LName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EFLORCOBQEZ0','50','D','10','4',NULL,'First Name',NULL,NULL,'"drv10FName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EFLORCOBQEZ0','50','D','10','5',NULL,'Street Address Line 1',NULL,NULL,'"drv10Add1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EFLORCOBQEZ0','50','D','10','6',NULL,'Street Address Line 2',NULL,NULL,'"drv10Add2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EFLORCOBQEZ0','50','D','10','7',NULL,'City',NULL,NULL,'"drv10City"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EFLORCOBQEZ0','50','D','10','8',NULL,'State',NULL,NULL,'"drv10State"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EFLORCOBQEZ0','50','D','10','9',NULL,'Zip',NULL,NULL,'"drv10Zip"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EFLORCOBQEZ0','50','D','10','10',NULL,'Phone Number',NULL,NULL,'"drv10Phone"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EFLORCOBQEZ0','50','D','10','11',NULL,'Email Address',NULL,NULL,'"drv10Email"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EFLORCOBQEZ0','50','D','10','12',NULL,'Birth Date',NULL,NULL,'"drv10DOB"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EFLORCOBQEZ0','50','D','10','13',NULL,'State of Employment',NULL,NULL,'"drv10StateOfEmploy"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EFLORCOBQEZ0','50','D','10','14',NULL,'Type of Event',NULL,NULL,'"drv10TypeOfEvent"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EFLORCOBQEZ0','50','D','10','15',NULL,'Date of Event',NULL,NULL,'"drv10DtOfEvent"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EFLORCOBQEZ0','50','D','10','16',NULL,'Date Premiums Paid Through',NULL,NULL,'"drv10DtPremPaidThrough"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EFLORCOBQEZ0','50','D','10','17',NULL,'Location',NULL,NULL,'"drv10Loc"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EFLORCOBQEZ0','50','D','10','18',NULL,'Gender',NULL,NULL,'"drv10Gender"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EFLORCOBQEZ0','50','D','20','1',NULL,'Dependent Identifier',NULL,NULL,'"drv20DepIdent"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EFLORCOBQEZ0','50','D','20','2',NULL,'Employee ID Number of the Insured',NULL,NULL,'"drv20EmpIdNumOfIns"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EFLORCOBQEZ0','50','D','20','3',NULL,'Dependent Number',NULL,NULL,'"drv20DepNum"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EFLORCOBQEZ0','50','D','20','4',NULL,'Dependent First Name',NULL,NULL,'"drv20DepFName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EFLORCOBQEZ0','50','D','20','5',NULL,'Dependent Last Name',NULL,NULL,'"drv20DepLName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EFLORCOBQEZ0','50','D','20','6',NULL,'Relation to Insured',NULL,NULL,'"drv20RelToIns"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EFLORCOBQEZ0','50','D','20','7',NULL,'Date of Birth',NULL,NULL,'"drv20DOB"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EFLORCOBQEZ0','50','D','20','8',NULL,'Gender',NULL,NULL,'"drv20Gender"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EFLORCOBQEZ0','50','D','30','1',NULL,'Election Identifier',NULL,NULL,'"drv30ElectIdent"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EFLORCOBQEZ0','50','D','30','2',NULL,'Employee ID Number of the Insured',NULL,NULL,'"drv30EmpIdNumOfIns"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EFLORCOBQEZ0','50','D','30','3',NULL,'Dependent Number',NULL,NULL,'"drv30DepNum"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EFLORCOBQEZ0','50','D','30','4',NULL,'Plan Code Enrolled In',NULL,NULL,'"drv30PlanCodeEnrolledIn"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EFLORCOBQEZ0','50','D','30','5',NULL,'Monthly Premium',NULL,NULL,'"drv30MonthlyPrem"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EFLORCOBQE_20220214.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Flores COBRA Export','202202099','EMPEXPORT','ONDEM_XOE',NULL,'EFLORCOBQE',NULL,NULL,NULL,'202202099','Feb  9 2022 10:22PM','Feb  9 2022 10:22PM','202202091',NULL,'','','202202091',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Flores COBRA Export-Sched','202202099','EMPEXPORT','SCH_EFLORC',NULL,'EFLORCOBQE',NULL,NULL,NULL,'202202099','Feb  9 2022 10:22PM','Feb  9 2022 10:22PM','202202091',NULL,'','','202202091',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Flores COBRA Export-Test','202202099','EMPEXPORT','TEST_XOE',NULL,'EFLORCOBQE',NULL,NULL,NULL,'202202099','Feb  9 2022 10:22PM','Feb  9 2022 10:22PM','202202091',NULL,'','','202202091',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFLORCOBQE','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFLORCOBQE','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFLORCOBQE','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFLORCOBQE','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFLORCOBQE','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFLORCOBQE','D10','dbo.U_EFLORCOBQE_drvInsured',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFLORCOBQE','D20','dbo.U_EFLORCOBQE_drvDependent',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFLORCOBQE','D30','dbo.U_EFLORCOBQE_drvElection',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EFLORCOBQE
-----------

IF OBJECT_ID('U_dsi_BDM_EFLORCOBQE') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EFLORCOBQE] (
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
-- Create table U_EFLORCOBQE_coverage
-----------

IF OBJECT_ID('U_EFLORCOBQE_coverage') IS NULL
CREATE TABLE [dbo].[U_EFLORCOBQE_coverage] (
    [bdmeeid_count] char(12) NOT NULL,
    [bdmcoid_count] char(5) NULL,
    [spouse_count] int NULL,
    [child_count] int NULL
);

-----------
-- Create table U_EFLORCOBQE_drvDependent
-----------

IF OBJECT_ID('U_EFLORCOBQE_drvDependent') IS NULL
CREATE TABLE [dbo].[U_EFLORCOBQE_drvDependent] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drv20DepIdent] varchar(1) NOT NULL,
    [drv20EmpIdNumOfIns] char(11) NULL,
    [drv20DepNum] bigint NULL,
    [drv20DepFName] varchar(100) NULL,
    [drv20DepLName] varchar(100) NULL,
    [drv20RelToIns] varchar(1) NULL,
    [drv20DOB] datetime NULL,
    [drv20Gender] char(1) NULL,
	drv20BdmDepRecId varchar(50) NULL,
    [drvInitialSort] int NULL,
    [drvSubSort] varchar(1) NOT NULL
);

-----------
-- Create table U_EFLORCOBQE_drvElection
-----------

IF OBJECT_ID('U_EFLORCOBQE_drvElection') IS NULL
CREATE TABLE [dbo].[U_EFLORCOBQE_drvElection] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drv30ElectIdent] varchar(1) NOT NULL,
    [drv30EmpIdNumOfIns] char(11) NULL,
    [drv30DepNum] bigint NULL,
    [drv30PlanCodeEnrolledIn] varchar(4) NULL,
    [drv30MonthlyPrem] varchar(1) NOT NULL,
    [drvInitialSort] int NULL,
    [drvSubSort] varchar(1) NOT NULL
);

-----------
-- Create table U_EFLORCOBQE_drvInsured
-----------

IF OBJECT_ID('U_EFLORCOBQE_drvInsured') IS NULL
CREATE TABLE [dbo].[U_EFLORCOBQE_drvInsured] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drv10InsuredIdent] varchar(1) NOT NULL,
    [drv10EmpIdNum] char(11) NULL,
    [drv10LName] varchar(100) NULL,
    [drv10FName] varchar(100) NULL,
    [drv10Add1] varchar(255) NULL,
    [drv10Add2] varchar(255) NULL,
    [drv10City] varchar(255) NULL,
    [drv10State] varchar(255) NULL,
    [drv10Zip] varchar(50) NULL,
    [drv10Phone] varchar(50) NULL,
    [drv10Email] varchar(50) NULL,
    [drv10DOB] datetime NULL,
    [drv10StateOfEmploy] varchar(1) NOT NULL,
    [drv10TypeOfEvent] varchar(2) NULL,
    [drv10DtOfEvent] varchar(30) NOT NULL,
    [drv10DtPremPaidThrough] varchar(1) NOT NULL,
    [drv10Loc] varchar(1) NOT NULL,
    [drv10Gender] char(1) NULL,
    [drvInitialSort] int NULL,
    [drvSubSort] varchar(1) NOT NULL
);

-----------
-- Create table U_EFLORCOBQE_EEList
-----------

IF OBJECT_ID('U_EFLORCOBQE_EEList') IS NULL
CREATE TABLE [dbo].[U_EFLORCOBQE_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EFLORCOBQE_File
-----------

IF OBJECT_ID('U_EFLORCOBQE_File') IS NULL
CREATE TABLE [dbo].[U_EFLORCOBQE_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EFLORCOBQE]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Community Housing

Created By: Andy Pineda
Business Analyst: Lea King
Create Date: 02/09/2022
Service Request Number: TekP-2021-11-10-0002

Purpose: Flores COBRA Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EFLORCOBQE';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EFLORCOBQE';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EFLORCOBQE';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EFLORCOBQE';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EFLORCOBQE' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFLORCOBQE', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFLORCOBQE', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFLORCOBQE', 'SCH_EFLORC';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EFLORCOBQE';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EFLORCOBQE', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EFLORCOBQE';

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
    DELETE FROM dbo.U_EFLORCOBQE_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EFLORCOBQE_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    -- DECLARE @DedList VARCHAR(MAX)
    -- SET @DedList = 'MED1, MED2, MED, DEN, VIS';

    -- IF OBJECT_ID('U_EFLORCOBQE_DedList','U') IS NOT NULL
    --     DROP TABLE dbo.U_EFLORCOBQE_DedList;
    -- SELECT DISTINCT
    --      DedCode = DedDedCode
    --     ,DedType = DedDedType
    -- INTO dbo.U_EFLORCOBQE_DedList
    -- FROM dbo.fn_ListToTable(@DedList)
    -- JOIN dbo.DedCode WITH (NOLOCK)
    --     ON DedDedCode = Item;


   --==========================================
    -- BDM Section for QB
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'TermSelectionOption','AuditDate');

    -- COBRA parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RunID','QB');
   -- INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'AddToPreviousRun','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','Y'); -- DedIsCobraCovered = 'Y'
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraType','4'); -- Eep/ConCobraReason first, then EdhChangeReason. Include CHGRP for elig. ben groups
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraDate','3'); -- EedBenStopDate and DbnBenStopDate, unless Eep/ConDateOfCOBRAEvent exists
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraPQBType','1'); -- If no EE or spouse, ALL children are PQB (not just oldest)
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraReasonsDepPQB','201,204,210,LEVNT3,LEVNT4'); -- Valid dependent PQB reasons
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidCobraReasonsEmp','201,204,210,LEVNT3,LEVNT4'); -- Invalidate employee when Cobra Reason is a dependent PQB reason
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidTermReasonsEmp','203'); -- Invalidate employee when Cobra Reason is "Death"
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'ConCobraReasonPCF','DependentCOBRAReason'); -- Valid dependent PQB reasons
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CountDependents','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL, DPC, STC');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');

    -- Run BDM for QB
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Working Tables
    --==========================================

    -- Create count dependent table
   -- IF OBJECT_ID('U_EFLORCOBQE_coverage','U') IS NOT NULL 
   -- DROP TABLE dbo.U_EFLORCOBQE_coverage;

   -- SELECT e.bdmeeid as bdmeeid_count, e.bdmcoid as bdmcoid_count, s.bdmdateofbirth, count(distinct(s.bdmdateofbirth)) as spouse_count, '0' AS child_count--, count(distinct(c.bdmdateofbirth)) as child_count
   -- into dbo.U_EFLORCOBQE_coverage 
   -- FROM dbo.U_dsi_BDM_EFLORCOBQE e WITH(NOLOCK) 
   -- left JOIN dbo.U_dsi_BDM_EFLORCOBQE s WITH(NOLOCK) ON s.bdmeeid = e.bdmeeid  and s.bdmrelationship in ('sps', 'dp', 'dpn')
   -- --left join dbo.U_dsi_BDM_EFLORCOBQE c with(nolock) on c.bdmeeid = e.bdmeeid and c.bdmrelationship in ('chl', 'stc', 'dpc', 'ddp', 'grc')

   -- group by e.bdmeeid, e.bdmcoid, s.bdmdateofbirth

   -- UNION

   -- SELECT e.bdmeeid as bdmeeid_count, e.bdmcoid as bdmcoid_count, c.bdmdateofbirth, 0 as spouse_count /*count(distinct(s.bdmdateofbirth)) as spouse_count,*/ ,  count(distinct(c.bdmdateofbirth)) as child_count
   ---- into dbo.U_EFLORCOBQE_coverage 
   -- FROM dbo.U_dsi_BDM_EFLORCOBQE e WITH(NOLOCK) 
   -- --left JOIN dbo.U_dsi_BDM_EFLORCOBQE s WITH(NOLOCK) ON s.bdmeeid = e.bdmeeid  and s.bdmrelationship in ('sps', 'dp', 'dpn')
   -- left join dbo.U_dsi_BDM_EFLORCOBQE c with(nolock) on c.bdmeeid = e.bdmeeid and c.bdmrelationship in ('chl', 'stc', 'dpc', 'ddp', 'grc')

   -- group by e.bdmeeid, e.bdmcoid, c.bdmdateofbirth
    
   --order by e.bdmeeid, c.bdmdateofbirth

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EFLORCOBQE_drvInsured
    ---------------------------------
    IF OBJECT_ID('U_EFLORCOBQE_drvInsured','U') IS NOT NULL
        DROP TABLE dbo.U_EFLORCOBQE_drvInsured;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drv10InsuredIdent = '1'
        ,drv10EmpIdNum = EepSSN
        ,drv10LName = CASE WHEN BdmChangeReason IN ('204', 'LEVNT4', '201', 'LEVNT3', '210') OR EecTermReason = '203' then ConNameLast ELSE EepNameLast END
        ,drv10FName = CASE WHEN BdmChangeReason IN ('204', 'LEVNT4', '201', 'LEVNT3', '210') OR EecTermReason = '203' then ConNameFirst ELSE EepNameFirst END
        ,drv10Add1 = EepAddressLine1
        ,drv10Add2 = EepAddressLine2
        ,drv10City = EepAddressCity
        ,drv10State = EepAddressState
        ,drv10Zip = EepAddressZipCode
        ,drv10Phone = EepPhoneHomeNumber
        ,drv10Email = EepAddressEMail
        ,drv10DOB = CASE WHEN BdmChangeReason IN ('204', 'LEVNT4', '201', 'LEVNT3', '210') OR EecTermReason = '203' then ConDateOfBirth ELSE EepDateOfBirth END
        ,drv10StateOfEmploy = ''
        ,drv10TypeOfEvent = CASE WHEN BdmChangeReason IN ('204', 'LEVNT4') THEN '4'
                                WHEN EecEmplStatus = 'T' AND EecTermReason = '203' THEN '3'
                                WHEN BdmChangeReason = '205' THEN '6'
                                WHEN BdmChangeReason IN ('201', 'LEVNT3') THEN '5'
                                WHEN EecEmplStatus = 'T' AND EecTermType = 'V' THEN '1'
                                WHEN BdmChangeReason IN ('202', '203') THEN '2'
                                WHEN EecEmplStatus = 'T' AND EecTermReason <> '203' AND EecTermType = 'I' THEN '10' END
        ,drv10DtOfEvent = ISNULL(CONVERT(VARCHAR, BdmBenStopDate, 101), '')
        ,drv10DtPremPaidThrough = ''
        ,drv10Loc = ''
        ,drv10Gender = EepGender
        ,drvInitialSort = 1 + LTRIM(RTRIM(EepSSN))
        ,drvSubSort = '1'
    INTO dbo.U_EFLORCOBQE_drvInsured
    FROM dbo.U_EFLORCOBQE_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH(NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.U_dsi_BDM_EFLORCOBQE WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.Contacts WITH(NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemId = BdmDepRecId
    WHERE BdmRunID = 'QB'
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EFLORCOBQE_drvDependent
    ---------------------------------
    IF OBJECT_ID('U_EFLORCOBQE_drvDependent','U') IS NOT NULL
        DROP TABLE dbo.U_EFLORCOBQE_drvDependent;

	SELECT drvEEID,
			drvCOID,
			drvDepRecID,
			drv20DepIdent,
			drv20EmpIdNumOfIns,
			ROW_NUMBER() OVER(PARTITION BY drvEEID, drv20RelToIns ORDER BY drv20DOB) AS drv20DepNum,
			drv20DepFName,
			drv20DepLName,
			drv20RelToIns,
			drv20DOB,
			drv20Gender,
			drv20BdmDepRecId,
			drvInitialSort,
			drvSubSort
	INTO dbo.U_EFLORCOBQE_drvDependent
	FROM
	(
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drv20DepIdent = '2'
        ,drv20EmpIdNumOfIns = EepSSN
        ,drv20DepNum = ''--ROW_NUMBER() OVER(PARTITION BY BdmEEID ORDER BY BdmDateOfBirth)
        ,drv20DepFName = ConNameFirst
        ,drv20DepLName = ConNameLast
        ,drv20RelToIns = CASE WHEN BdmRelationship IN ('SPS', 'DP') THEN 'S'
                                WHEN BdmRelationship IN ('CHL', 'DCH', 'DPC', 'STC') THEN 'C' END 
        ,drv20DOB = ConDateOfBirth
        ,drv20Gender = ConGender
		,drv20BdmDepRecId = BdmDepRecId
        ,drvInitialSort = 1 + LTRIM(RTRIM(EepSSN))
        ,drvSubSort = '2'
   -- INTO dbo.U_EFLORCOBQE_drvDependent
    FROM dbo.U_EFLORCOBQE_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EFLORCOBQE WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.Contacts WITH(NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemId = BdmDepRecId
    WHERE BdmRunID = 'QB'
	AND BdmRecType = 'DEP') a
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EFLORCOBQE_drvElection
    ---------------------------------
    IF OBJECT_ID('U_EFLORCOBQE_drvElection','U') IS NOT NULL
        DROP TABLE dbo.U_EFLORCOBQE_drvElection;

    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drv30ElectIdent = '3'
        ,drv30EmpIdNumOfIns = EepSSN
        ,drv30DepNum = dep.drv20DepNum --CASE WHEN BdmRecType = 'DEP' THEN ROW_NUMBER() OVER(PARTITION BY BdmEEID ORDER BY BdmRelationship, BdmDateOfBirth) END
        ,drv30PlanCodeEnrolledIn = CASE WHEN BdmDedCode = 'MEDLO' THEN
                                        CASE WHEN BdmBenOption = 'EE' THEN '4010'
                                                WHEN BdmBenOption IN ('EES', 'EEDP', 'EEDOP') THEN '4011'
                                                WHEN BdmBenOption IN ('EEC', 'EECHD', 'EECN', 'EECHIL') THEN '4012'
                                                WHEN BdmBenOption IN ('EEF', 'EEDPF') THEN '4013'
                                            END
                                        WHEN BdmDedCode = 'HDHP' THEN
                                        CASE WHEN BdmBenOption = 'EE' THEN '7040'
                                                WHEN BdmBenOption IN ('EES', 'EEDP', 'EEDOP') THEN '7041'
                                                WHEN BdmBenOption IN ('EEC', 'EECHD', 'EECN', 'EECHIL') THEN '7042'
                                                WHEN BdmBenOption IN ('EEF', 'EEDPF') THEN '7043'
                                            END
                                        WHEN BdmDedCode = 'MEDHI' THEN
                                        CASE WHEN BdmBenOption = 'EE' THEN '9060'
                                                WHEN BdmBenOption IN ('EES', 'EEDP', 'EEDOP') THEN '9061'
                                                WHEN BdmBenOption IN ('EEC', 'EECHD', 'EECN', 'EECHIL') THEN '9062'
                                                WHEN BdmBenOption IN ('EEF', 'EEDPF') THEN '9063'
                                            END
                                        WHEN BdmDedCode = 'DENLO' THEN
                                        CASE WHEN BdmBenOption = 'EE' THEN '5020'
                                                WHEN BdmBenOption IN ('EES', 'EEDP', 'EEDOP') THEN '5021'
                                                WHEN BdmBenOption IN ('EEC', 'EECHD', 'EECN', 'EECHIL') THEN '5022'
                                                WHEN BdmBenOption IN ('EEF', 'EEDPF') THEN '5023'
                                            END
                                        WHEN BdmDedCode = 'DENHI' THEN
                                        CASE WHEN BdmBenOption = 'EE' THEN '6030'
                                                WHEN BdmBenOption IN ('EES', 'EEDP', 'EEDOP') THEN '6031'
                                                WHEN BdmBenOption IN ('EEC', 'EECHD', 'EECN', 'EECHIL') THEN '6032'
                                                WHEN BdmBenOption IN ('EEF', 'EEDPF') THEN '6033'
                                            END
                                        WHEN BdmDedCode = 'VISION' THEN
                                        CASE WHEN BdmBenOption = 'EE' THEN '8050'
                                                WHEN BdmBenOption IN ('EES', 'EEDP', 'EEDOP') THEN '8051'
                                                WHEN BdmBenOption IN ('EEC', 'EECHD', 'EECN', 'EECHIL') THEN '8052'
                                                WHEN BdmBenOption IN ('EEF', 'EEDPF') THEN '8053'
                                            END
                                    END
        ,drv30MonthlyPrem = ''
		,drv30RelToIns = CASE WHEN BdmRelationship IN ('SPS', 'DP') THEN 'S'
                                WHEN BdmRelationship IN ('CHL', 'DCH', 'DPC', 'STC') THEN 'C' END 
        ,drvInitialSort = 1 + LTRIM(RTRIM(EepSSN))
        ,drvSubSort = '3'
    INTO dbo.U_EFLORCOBQE_drvElection
    FROM dbo.U_EFLORCOBQE_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH(NOLOCK)
        ON xEEID = EepEEID
    JOIN dbo.U_dsi_BDM_EFLORCOBQE WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
	LEFT JOIN dbo.U_EFLORCOBQE_drvDependent dep WITH(NOLOCK)
		ON dep.drveeid = bdmeeid
		and dep.drvcoid = bdmcoid
		and dep.drv20BdmDepRecId = bdmdeprecid
    WHERE BdmRunID = 'QB'

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
ALTER VIEW dbo.dsi_vwEFLORCOBQE_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EFLORCOBQE_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EFLORCOBQE%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202202021'
       ,expStartPerControl     = '202202021'
       ,expLastEndPerControl   = '202202099'
       ,expEndPerControl       = '202202099'
WHERE expFormatCode = 'EFLORCOBQE';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEFLORCOBQE_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EFLORCOBQE_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EFLORCOBQE' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EFLORCOBQE'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EFLORCOBQE'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EFLORCOBQE', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EFLORCOBQE', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EFLORCOBQE', 'UseFileName', 'V', 'Y'


-- End ripout