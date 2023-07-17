/**********************************************************************************

EAGRFLQB: Flores COBRA QB

FormatCode:     EAGRFLQB
Project:        Flores COBRA QB
Client ID:      AGR1003
Date/time:      2023-07-17 14:15:29.547
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW4WUP6DB02
Database:       ULTIPRO_WPARGI
Web Filename:   AGR1003_WU4E0_EEHISTORY_EAGRFLQB_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EAGRFLQB_SavePath') IS NOT NULL DROP TABLE dbo.U_EAGRFLQB_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EAGRFLQB'


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
WHERE FormatCode = 'EAGRFLQB'
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
WHERE ExpFormatCode = 'EAGRFLQB'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EAGRFLQB')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EAGRFLQB'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EAGRFLQB'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EAGRFLQB'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EAGRFLQB'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EAGRFLQB'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EAGRFLQB'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EAGRFLQB'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EAGRFLQB'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EAGRFLQB'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEAGRFLQB_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEAGRFLQB_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EAGRFLQB') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EAGRFLQB];
GO
IF OBJECT_ID('U_EAGRFLQB_File') IS NOT NULL DROP TABLE [dbo].[U_EAGRFLQB_File];
GO
IF OBJECT_ID('U_EAGRFLQB_ELEC_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EAGRFLQB_ELEC_drvTbl];
GO
IF OBJECT_ID('U_EAGRFLQB_EEList') IS NOT NULL DROP TABLE [dbo].[U_EAGRFLQB_EEList];
GO
IF OBJECT_ID('U_EAGRFLQB_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EAGRFLQB_drvTbl];
GO
IF OBJECT_ID('U_EAGRFLQB_DEP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EAGRFLQB_DEP_drvTbl];
GO
IF OBJECT_ID('U_EAGRFLQB_DedList') IS NOT NULL DROP TABLE [dbo].[U_EAGRFLQB_DedList];
GO
IF OBJECT_ID('U_EAGRFLQB_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EAGRFLQB_AuditFields];
GO
IF OBJECT_ID('U_EAGRFLQB_Audit') IS NOT NULL DROP TABLE [dbo].[U_EAGRFLQB_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EAGRFLQB') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EAGRFLQB];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EAGRFLQB','Flores COBRA QB','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','EAGRFLQB00Z0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EAGRFLQB00Z0','1','D','10','1',NULL,'Insured Identifier',NULL,NULL,'"1"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EAGRFLQB00Z0','9','D','10','2',NULL,'Employee ID Number',NULL,NULL,'"drvSSN"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EAGRFLQB00Z0','25','D','10','3',NULL,'Last Name',NULL,NULL,'"drvLastName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EAGRFLQB00Z0','15','D','10','4',NULL,'First Name',NULL,NULL,'"drvFirstName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EAGRFLQB00Z0','30','D','10','5',NULL,'Street Address Line 1',NULL,NULL,'"drvAddressLine1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EAGRFLQB00Z0','30','D','10','6',NULL,'Street Address Line 2',NULL,NULL,'"drvAddressLine2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EAGRFLQB00Z0','20','D','10','7',NULL,'City',NULL,NULL,'"drvAddressCity"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EAGRFLQB00Z0','2','D','10','8',NULL,'State',NULL,NULL,'"drvAddressState"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EAGRFLQB00Z0','10','D','10','9',NULL,'Zip',NULL,NULL,'"drvAddressZip"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EAGRFLQB00Z0','13','D','10','10',NULL,'Phone Number',NULL,NULL,'"drvPhoneNumber"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EAGRFLQB00Z0','50','D','10','11',NULL,'Email address',NULL,NULL,'"drvEmailaddress"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EAGRFLQB00Z0','10','D','10','12',NULL,'Birth date',NULL,NULL,'"drvBirthdate"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EAGRFLQB00Z0','2','D','10','13',NULL,'State of employment',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EAGRFLQB00Z0','2','D','10','14',NULL,'Type of Event',NULL,NULL,'"drvTypeofEvent"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EAGRFLQB00Z0','10','D','10','15',NULL,'Date of Event',NULL,NULL,'"drvDateofEvent"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EAGRFLQB00Z0','10','D','10','16',NULL,'Date Premiums Paid Through',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EAGRFLQB00Z0','10','D','10','17',NULL,'Location',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EAGRFLQB00Z0','1','D','10','18',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EAGRFLQB00Z0','1','D','20','19',NULL,'Dependent Identifier',NULL,NULL,'"drvDependentIdentifier"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EAGRFLQB00Z0','9','D','20','20',NULL,'Employee ID Number of the Insured',NULL,NULL,'"drvSSN2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EAGRFLQB00Z0','1','D','20','21',NULL,'Dependent Number',NULL,NULL,'"drvDependentNumber"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EAGRFLQB00Z0','15','D','20','22',NULL,'Dependent First Name',NULL,NULL,'"drvDependentFirstName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EAGRFLQB00Z0','25','D','20','23',NULL,'Dependent Last Name',NULL,NULL,'"drvDependentLastName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EAGRFLQB00Z0','1','D','20','24',NULL,'Relation to Insured',NULL,NULL,'"drvRelationtoInsured"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EAGRFLQB00Z0','10','D','20','25',NULL,'Date of Birth',NULL,NULL,'"drvDateofBirth"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EAGRFLQB00Z0','1','D','20','26',NULL,'Gender',NULL,NULL,'"drvConGender"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EAGRFLQB00Z0','1','D','30','27',NULL,'Election Identifier',NULL,NULL,'"3"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EAGRFLQB00Z0','9','D','30','28',NULL,'Employee ID Number of the Insured',NULL,NULL,'"drvSSN3"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EAGRFLQB00Z0','1','D','30','29',NULL,'Dependent Number',NULL,NULL,'"drvDependentNumber2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EAGRFLQB00Z0','6','D','30','30',NULL,'Plan Code Enrolled In',NULL,NULL,'"drvPlanCodeEnrolledIn"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EAGRFLQB00Z0','7','D','30','31',NULL,'Monthly Premium',NULL,NULL,'"drvMonthlyPremium"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EAGRFLQB_20230717.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Flores COBRA QB','202303179','EMPEXPORT','ONDEM_XOE',NULL,'EAGRFLQB',NULL,NULL,NULL,'202303179','Feb 17 2023  9:37AM','Feb 17 2023  9:37AM','202101011',NULL,'','','202101011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N','WY8V4',NULL,NULL,NULL,'FloresCOBRA QB Genec Wed 1110P','206402299','EMPEXPORT','SCH_EAGRF2',NULL,'EAGRFLQB',NULL,NULL,NULL,'202307129','Feb 17 2023  9:37AM','Feb 17 2023  9:37AM','202307051',NULL,'eecPaygroup','GNHRLY,GNSLRY','202101011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,'WY9ZA',NULL,NULL,NULL,'FloresCOBRA QB AgRel Wed 1120P','206403319','EMPEXPORT','SCH_EAGRFL',NULL,'EAGRFLQB',NULL,NULL,NULL,'202307129','Feb 17 2023  9:37AM','Feb 17 2023  9:37AM','202307051',NULL,'eecPaygroup','USHRLY,USSLRY','202101011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','WY9ZA,WY8V4',NULL,NULL,NULL,'Flores COBRA QB-Test','202307169','EMPEXPORT','TEST_XOE',NULL,'EAGRFLQB',NULL,NULL,NULL,'202307169','Feb 17 2023  9:37AM','Feb 17 2023  9:37AM','202301011',NULL,'','','202301011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAGRFLQB','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAGRFLQB','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAGRFLQB','InitialSort','C','drvEmpNoSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAGRFLQB','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAGRFLQB','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAGRFLQB','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EAGRFLQB','D10','dbo.U_EAGRFLQB_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EAGRFLQB','D20','dbo.U_EAGRFLQB_DEP_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EAGRFLQB','D30','dbo.U_EAGRFLQB_ELEC_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EAGRFLQB
-----------

IF OBJECT_ID('U_dsi_BDM_EAGRFLQB') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EAGRFLQB] (
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
-- Create table U_EAGRFLQB_Audit
-----------

IF OBJECT_ID('U_EAGRFLQB_Audit') IS NULL
CREATE TABLE [dbo].[U_EAGRFLQB_Audit] (
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
-- Create table U_EAGRFLQB_AuditFields
-----------

IF OBJECT_ID('U_EAGRFLQB_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EAGRFLQB_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EAGRFLQB_DedList
-----------

IF OBJECT_ID('U_EAGRFLQB_DedList') IS NULL
CREATE TABLE [dbo].[U_EAGRFLQB_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EAGRFLQB_DEP_drvTbl
-----------

IF OBJECT_ID('U_EAGRFLQB_DEP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EAGRFLQB_DEP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvEmpNoSort] char(11) NULL,
    [BdmChangeReason] char(6) NULL,
    [EecTermReason] char(6) NULL,
    [BdmCobraReason] char(6) NULL,
    [drvDependentIdentifier] bigint NULL,
    [drvSSN2] char(11) NULL,
    [drvDependentNumber] int NULL,
    [drvDependentFirstName] varchar(100) NULL,
    [drvDependentLastName] varchar(100) NULL,
    [drvRelationtoInsured] varchar(1) NULL,
    [drvDateofBirth] datetime NULL,
    [drvConGender] char(1) NULL
);

-----------
-- Create table U_EAGRFLQB_drvTbl
-----------

IF OBJECT_ID('U_EAGRFLQB_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EAGRFLQB_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvEmpNoSort] char(11) NULL,
    [drvSSN] char(11) NULL,
    [drvLastName] varchar(100) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZip] varchar(50) NULL,
    [drvPhoneNumber] varchar(50) NULL,
    [drvEmailaddress] varchar(50) NULL,
    [drvBirthdate] datetime NULL,
    [drvTypeofEvent] varchar(2) NULL,
    [drvDateofEvent] datetime NULL,
    [drvGender] char(1) NULL
);

-----------
-- Create table U_EAGRFLQB_EEList
-----------

IF OBJECT_ID('U_EAGRFLQB_EEList') IS NULL
CREATE TABLE [dbo].[U_EAGRFLQB_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EAGRFLQB_ELEC_drvTbl
-----------

IF OBJECT_ID('U_EAGRFLQB_ELEC_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EAGRFLQB_ELEC_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvEmpNoSort] char(11) NULL,
    [drvSubSort] varchar(16) NOT NULL,
    [drvSSN3] char(11) NULL,
    [drvDependentNumber2] int NULL,
    [drvPlanCodeEnrolledIn] varchar(4) NULL,
    [drvMonthlyPremium] varchar(1) NOT NULL
);

-----------
-- Create table U_EAGRFLQB_File
-----------

IF OBJECT_ID('U_EAGRFLQB_File') IS NULL
CREATE TABLE [dbo].[U_EAGRFLQB_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EAGRFLQB]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: AgReliant Genetics LLC

Created By: Marie Thomerson
Business Analyst: Katherine Ricca
Create Date: 02/17/2023
Service Request Number: TekP-2022-12-01-01

Purpose: Flores COBRA QB

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX
Marie Waters        04/26/2023        TekP-2022-12-01-01 Made updates to use max dates, coonsolidated the case statements 
Marie Waters        07/17/2023        TekP-2022-12-01-01 Made updates the dep sorting and changed contact join RN

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EAGRFLQB';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EAGRFLQB';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EAGRFLQB';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EAGRFLQB';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EAGRFLQB' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAGRFLQB', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAGRFLQB', 'TEST_XOE';
---EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAGRFLQB', 'OEPASSIVE';
---EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAGRFLQB', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAGRFLQB', 'SCH_EAGRFL';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAGRFLQB', 'SCH_EAGRF2';

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202301011'
       ,expStartPerControl     = '202301011'
       ,expLastEndPerControl   = '202304169'
       ,expEndPerControl       = '202304169'
WHERE expFormatCode = 'EAGRFLQB';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EAGRFLQB';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EAGRFLQB', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EAGRFLQB';

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
    DELETE FROM dbo.U_EAGRFLQB_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EAGRFLQB_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EAGRFLQB_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EAGRFLQB_AuditFields;
    CREATE TABLE dbo.U_EAGRFLQB_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    --INSERT INTO dbo.U_EAGRFLQB_AuditFields VALUES ('EmpComp','EecDateofTermination');
    INSERT INTO dbo.U_EAGRFLQB_AuditFields VALUES ('EmpComp','EecEmplStatus');
    --INSERT INTO dbo.U_EAGRFLQB_AuditFields VALUES ('EmpComp','EecTermReason');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EAGRFLQB_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EAGRFLQB_Audit;
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
    INTO dbo.U_EAGRFLQB_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EAGRFLQB_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EAGRFLQB_Audit ON dbo.U_EAGRFLQB_Audit (audEEID,audKey2);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'FSA,FSAI,GDEN,GFSA,GFSA,GMED,GVIS,PRVIS,UDENA,UDENP,UDENP,UMEDA,UMEDP,UVISA,UVISP';

    IF OBJECT_ID('U_EAGRFLQB_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EAGRFLQB_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EAGRFLQB_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','FSA,FSAI,GDEN,GFSA,GFSA,GMED,GVIS,PRVIS,UDENA,UDENP,UDENP,UMEDA,UMEDP,UVISA,UVISP');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

    -- Non-Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RunID','QB');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraType','4');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraDate','3');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CountDependents','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL, DPC, DCH, STC');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraReasonsDepPQB','201,204,210,LEVNT3,LEVNT4');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidCobraReasonsEmp','201,204,210,LEVNT3,LEVNT4');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidTermReasonsEmp','203');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'ConCobraReasonPCF','DependentCOBRAReason');

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
    
    EXEC dbo.dsi_bdm_sp_CalculateBenefitAmounts @FormatCode;

    --================================
    -- Update BdmEEAmt with BcaEEAmt
    --================================

    UPDATE dbo.U_dsi_BDM_EAGRFLQB
    SET BdmEEAmt = BcaEEAmt+BCAERAmt
    from dbo.u_dsi_bdm_BenCalculationAmounts
    JOIN dbo.U_dsi_bdm_EmpDeductions WITH (NOLOCK)
    on eedeeid = bcaeeid AND eedcoid = bcacoid
    AND eedFormatCode = bcaFormatCode AND eeddedcode = bcadedcode
    AND BcaDepRecID IS NULL
    AND eedFormatCode = 'EAGRFLQB' AND eedvalidforexport = 'Y'
    JOIN dbo.U_dsi_BDM_EAGRFLQB WITH (NOLOCK)
    ON eeddedcode = BdmDedCode
    AND BdmEEID = eedeeid
    AND BdmCoID = eedcoid ;

  ---==========================================
 --   -- Insert into BDM Reason code 201 and 204
 --   --==========================================
    INSERT INTO [dbo].[U_dsi_BDM_EAGRFLQB]
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
        AND dbnformatcode = 'EAGRFLQB'

    INSERT INTO [dbo].[U_dsi_BDM_EAGRFLQB]
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
        AND dbnformatcode = 'EAGRFLQB'

    Delete from dbo.U_dsi_BDM_EAGRFLQB where bdmdedcode not in (Select dedcode from U_EAGRFLQB_DedList)





    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EAGRFLQB_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EAGRFLQB_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EAGRFLQB_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvEmpNoSort = eepSSN
        -- standard fields above and additional driver fields below
        ,drvSSN = CASE      WHEN  (BdmChangeReason in ('204', 'LEVNT4', '201', 'LEVNT3', '210') or BdmCobraReason in ('204', 'LEVNT4', '201', 'LEVNT3', '210')) THEN ConSSN
                           -- WHEN BdmCobraReason in ('204', 'LEVNT4', '201', 'LEVNT3', '210') THEN ConSSN
                            WHEN EecTermReason  = '203'  THEN ConSSN
                            ELSE eepssn END
        ,drvLastName = CASE    WHEN  (BdmChangeReason in ('204', 'LEVNT4', '201', 'LEVNT3', '210') or BdmCobraReason in ('204', 'LEVNT4', '201', 'LEVNT3', '210')) THEN connamelast
                               -- WHEN BdmCobraReason in ('204', 'LEVNT4', '201', 'LEVNT3', '210') THEN connamelast
                                WHEN EecTermReason  = '203' THEN connamelast 
                                else EepNameLast END
        ,drvFirstName = CASE    WHEN  (BdmChangeReason in ('204', 'LEVNT4', '201', 'LEVNT3', '210') or BdmCobraReason in ('204', 'LEVNT4', '201', 'LEVNT3', '210'))THEN connamefirst 
                                --WHEN BdmCobraReason in ('204', 'LEVNT4', '201', 'LEVNT3', '210') THEN connamefirst 
                                WHEN EecTermReason  = '203' THEN connamefirst 
                                else Eepnamefirst END
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZip = EepaddresszipCode
        ,drvPhoneNumber = eepphonehomenumber
        ,drvEmailaddress = Eepaddressemailalternate
        ,drvBirthdate = CASE    WHEN  (BdmChangeReason in ('204', 'LEVNT4', '201', 'LEVNT3', '210') or BdmCobraReason in ('204', 'LEVNT4', '201', 'LEVNT3', '210'))THEN condateofbirth
                               -- WHEN BdmCobraReason in ('204', 'LEVNT4', '201', 'LEVNT3', '210') THEN condateofbirth
                                WHEN EecTermReason  = '203' THEN condateofbirth ELSE EepDateOfBirth END
        ,drvTypeofEvent = CASE    WHEN (BdmChangeReason in ('204','LEVNT4') or BdmCobraReason in ('204','LEVNT4'))THEN '4'
                               -- WHEN BdmCobraReason in ('204','LEVNT4') THEN '4'
                                WHEN EecEmplStatus = 'T' and EecTermReason  = '203' THEN '3'
                                WHEN BdmChangeReason = '205' THEN '6'
                               -- WHEN BdmChangeReason = '210' THEN '3'
                                WHEN (BdmCobraReason = '210' or BdmChangeReason = '210') THEN '3'
                                WHEN (BdmChangeReason in ('201','LEVNT3') or BdmCobraReason in ('201','LEVNT3'))THEN '5'
                                WHEN BdmCobraReason = '205' THEN '6'
                               -- WHEN BdmCobraReason in ('201','LEVNT3') THEN '5'
                                WHEN EecEmplStatus = 'T'  and eectermtype  = 'V' THEN '1'
                                WHEN (BdmCobraReason in ('202','203') or BdmChangeReason in ('202','203')) THEN '2'
                                --WHEN BdmChangeReason in ('202','203') THEN '2' 
                                WHEN EecEmplStatus = 'T' and EecTermReason  <> '203' AND eectermtype = 'I' THEN '10' END
        ,drvDateofEvent = Bdmbenstopdate --CASE    WHEN BdmChangeReason in ('204', 'LEVNT4', '201', 'LEVNT3', '210') THEN Bdmbenstopdate
        ,drvGender = CASE    WHEN (BdmChangeReason in ('204', 'LEVNT4', '201', 'LEVNT3', '210') or BdmCobraReason in ('204', 'LEVNT4', '201', 'LEVNT3', '210')) THEN congender 
                           -- WHEN BdmCobraReason in ('204', 'LEVNT4', '201', 'LEVNT3', '210') THEN congender 
                            WHEN EecTermReason  = '203' THEN congender else eepgender END
    INTO dbo.U_EAGRFLQB_drvTbl
    FROM dbo.U_EAGRFLQB_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
         
     JOIN (SELECT
                 BdmEEID
                ,BdmCoID
                ,BdmDepRecID
                ,BdmRecType
                ,BdmChangeReason = MAX(BdmChangeReason)
                ,BdmCobraReason = MAX(BdmCobraReason)
                ,BdmBenStartDate = MIN(BdmBenStartDate)
                ,BdmBenStopDate = MAX(BdmBenStopDate)
                ,BdmDateOfCOBRAEvent = MAX(BdmDateOfCOBRAEvent)
                FROM dbo.U_dsi_BDM_EAGRFLQB WITH (NOLOCK)
                Where BdmRunId = 'QB'
                    AND BdmIsPQB = 'Y'
                 GROUP BY BdmEEID, BdmCoID, BdmDepRecID, BdmRecType) BDM
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID     
        LEFT JOIN (
            SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent 
            FROM (
                    SELECT EdhEEID, EdhCOID, EdhEffDate,MAX(edhChangeReason) as edhChangeReason, MAX(BchIsCobraQualifiedEvent) as BchIsCobraQualifiedEvent , ROW_NUMBER() OVER (PARTITION by EdhEEID, EdhCOID ORDER BY EdhEffDate desc) AS RN
                    FROM dbo.EmpHDed a WITH (NOLOCK)
                    JOIN dbo.BenChRsn WITH (NOLOCK)
                        ON EdhChangeReason = BchCode
                    WHERE EdhDedCode IN (@DedList) 
                        AND edhChangeReason IN ('210','204','LEVNT4','205','201','302','LEVNT3', '203','201','204','200')
                        Group by EdhEEID, EdhCOID, EdhEffDate
                ) AS X
            WHERE RN = 1) AS Edh
        ON EdhEEID = xEEID
        AND EdhCoID = xCOID  
       LEFT JOIN (
            --SELECT DISTINCT ConEEID, ConSSN, ConSystemID, ConNameFirst, ConNameLast, ConRelationship, ConDateOfBirth, ConGender, ConIsDependent, dbo.usi_fn_GetDependentAge(ConSystemID, GETDATE()) as Age, RN  
            --        FROM ( SELECT DISTINCT ConEEID, ConSSN, ConSystemID, ConNameFirst, ConNameLast, ConRelationship, ConDateOfBirth, ConGender, ConIsDependent, dbo.usi_fn_GetDependentAge(ConSystemID, GETDATE()) as Age, +1 AS RN 
            --        FROM dbo.Contacts WITH (NOLOCK) 
            --        WHERE ConIsActive = 'Y' AND ConRelationship in ( 'SPS' ,'DP')
            --    UNION 
            --SELECT DISTINCT ConEEID, ConSSN, ConSystemID, ConNameFirst, ConNameLast, ConRelationship, ConDateOfBirth, ConGender, ConIsDependent, [dbo].[usi_fn_GetDependentAge](ConSystemID, GETDATE()) as Age, ROW_NUMBER() OVER (PARTITION BY ConEEID ORDER By ConDateOfBirth ASC)+1  AS RN 
            --        FROM ( SELECT DISTINCT ConEEID, ConSSN, ConSystemID, ConNameFirst, ConNameLast, ConRelationship, ConDateOfBirth, ConGender, ConIsDependent
            --        FROM dbo.Contacts WITH (NOLOCK) 
            --        WHERE ConIsActive = 'Y' AND ConRelationship IN ('CHL','STC','DCH','DPC')
  --SELECT DISTINCT ConEEID, ConSSN, ConSystemID, ConNameFirst, ConNameLast, ConRelationship, ConDateOfBirth, ConGender, ConIsDependent, dbo.usi_fn_GetDependentAge(ConSystemID, GETDATE()) as Age, RN  
            --        FROM ( SELECT DISTINCT ConEEID, ConSSN, ConSystemID, ConNameFirst, ConNameLast, ConRelationship, ConDateOfBirth, ConGender, ConIsDependent, dbo.usi_fn_GetDependentAge(ConSystemID, GETDATE()) as Age, +1 AS RN 
            --        FROM dbo.Contacts WITH (NOLOCK) 
            --        WHERE ConIsActive = 'Y' AND ConRelationship in ( 'SPS' ,'DP')
            --    UNION 
            --SELECT DISTINCT ConEEID, ConSSN, ConSystemID, ConNameFirst, ConNameLast, ConRelationship, ConDateOfBirth, ConGender, ConIsDependent, [dbo].[usi_fn_GetDependentAge](ConSystemID, GETDATE()) as Age, ROW_NUMBER() OVER (PARTITION BY ConEEID ORDER By ConDateOfBirth ASC)+1  AS RN 
            --        FROM ( SELECT DISTINCT ConEEID, ConSSN, ConSystemID, ConNameFirst, ConNameLast, ConRelationship, ConDateOfBirth, ConGender, ConIsDependent
            --        FROM dbo.Contacts WITH (NOLOCK) 
            --        WHERE ConIsActive = 'Y' AND ConRelationship IN ('CHL','STC','DCH','DPC') AND ConIsDependent = 'Y'
               
                 SELECT DISTINCT ConEEID, ConSSN, ConSystemID, ConNameFirst, ConNameLast, ConRelationship, ConDateOfBirth, ConGender, ConIsDependent, dbo.usi_fn_GetDependentAge(ConSystemID, GETDATE()) as Age, RN  
                    FROM (            
                    
                    SELECT DISTINCT ConEEID, ConSSN, ConSystemID, ConNameFirst, ConNameLast, ConRelationship, ConDateOfBirth, ConGender, ConIsDependent, dbo.usi_fn_GetDependentAge(ConSystemID, GETDATE()) as Age, +1 AS RN 
                    FROM dbo.Contacts WITH (NOLOCK) 
                    JOIN dbo.U_dsi_BDM_EAGRFLQB iBdm  WITH (NOLOCK) 
                                    ON iBdm.BdmEEID = ConEEID
                                    AND iBdm.BdmDepRecID = ConSystemId
                                    AND iBdm.BdmRunId = 'QB'
                                    AND iBdm.BdmRecType = 'DEP'
                 WHERE  ConRelationship in ( 'SPS' ,'DP')
                UNION 
            SELECT DISTINCT ConEEID, ConSSN, ConSystemID, ConNameFirst, ConNameLast, ConRelationship, ConDateOfBirth, ConGender, ConIsDependent, [dbo].[usi_fn_GetDependentAge](ConSystemID, GETDATE()) as Age, ROW_NUMBER() OVER (PARTITION BY ConEEID ORDER By ConDateOfBirth ASC) AS RN 
                    FROM ( SELECT DISTINCT ConEEID, ConSSN, ConSystemID, ConNameFirst, ConNameLast, ConRelationship, ConDateOfBirth, ConGender, ConIsDependent
                    FROM dbo.Contacts WITH (NOLOCK) 
                    JOIN dbo.U_dsi_BDM_EAGRFLQB iBdm  WITH (NOLOCK) 
                                    ON iBdm.BdmEEID = ConEEID
                                    AND iBdm.BdmDepRecID = ConSystemId
                                    AND iBdm.BdmRunId = 'QB'
                                    AND iBdm.BdmRecType = 'DEP'
                 WHERE  ConRelationship IN ('CHL','STC','DCH','DPC') 
                ) AS CHLD
            ) AS Con
        ) CON
         ON ConEEID = BdmEEID
        AND ConSystemID = BdmDepRecID
    ;

       ---------------------------------
    -- DETAIL RECORD - U_EAGRFLQB_DEP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EAGRFLQB_DEP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EAGRFLQB_DEP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvEmpNoSort = eepSSN
        ,BdmChangeReason
        ,EecTermReason
        ,BdmCobraReason
        ,drvDependentIdentifier = CASE WHEN BdmChangeReason in ('204', 'LEVNT4', '201', 'LEVNT3')  then CON.RN END
        ,drvSSN2 = CASE WHEN BdmChangeReason in ('204', 'LEVNT4', '201', 'LEVNT3')  then CON.ConSSN 
                        WHEN bdmCobraReason  in ('210') AND Spouse.conSSN  is not null THEN Spouse.conSSN 
                        WHEN bdmCobraReason  in ('210') AND Spouse.conSSN  is null THEN Con.conSSN 
                        WHEN EecTermReason  = '203'  then Con.ConSSN
                        else eepssn END
        ,drvDependentNumber = CASE WHEN bdmCobraReason  in ('210') THEN  CAST( RN as INt) -1 ELSE  FORMAT(RN,'0') END -- MW updated 7/17/2023
        --CASE WHEN BdmREcType = 'EMP' THEN 0 ELSE FORMAT(RN,'0') END
        --CASE WHEN bdmrectype = 'EMP' THEN 0  
  --                                  ELSE CASE WHEN BdmChangeReason in ('204', 'LEVNT4', '201', 'LEVNT3', '210')  then 0 
  --                                  --WHEN BdmCobraReason in ('204', 'LEVNT4', '201', 'LEVNT3', '210') AND RN = 1 then 0 
  --                                  WHEN EecTermReason  = '203'  then 0
  --                                  else FORMAT(RN,'0') END END
        ,drvDependentFirstName = CON.ConNameFirst
        ,drvDependentLastName = CON.ConNameLast
        ,drvRelationtoInsured = CASE    WHEN CON.conrelationship in ('SPS','DP') THEN 'S'
                                        WHEN CON.conrelationship in ('CHL', 'DCH', 'DPC', 'STC') THEN 'C' END
        ,drvDateofBirth = CON.ConDateOfBirth
        ,drvConGender = CON.ConGender
    INTO dbo.U_EAGRFLQB_DEP_drvTbl
    FROM dbo.U_EAGRFLQB_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
        --AND xEEID = 'DU7T7C000030'
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN (SELECT
                 BdmEEID
                ,BdmCoID
                ,BdmDepRecID
                ,BdmRecType
                ,BdmIsPQB 
                ,BdmChangeReason = MAX(BdmChangeReason)
                ,BdmCobraReason = MAX(BdmCobraReason)
                ,BdmBenStartDate = MIN(BdmBenStartDate)
                ,BdmBenStopDate = MAX(BdmBenStopDate)
                ,BdmDateOfCOBRAEvent = MAX(BdmDateOfCOBRAEvent)
                FROM dbo.U_dsi_BDM_EAGRFLQB WITH (NOLOCK)
                Where BdmRunId = 'QB'
                    AND BdmIsPQB = 'N'
                 GROUP BY BdmEEID, BdmCoID, BdmDepRecID, BdmRecType, BdmIsPQB ) BDM
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID     
    JOIN (
            --SELECT DISTINCT ConEEID, ConSSN, ConSystemID, ConNameFirst, ConNameLast, ConRelationship, ConDateOfBirth, ConGender, ConIsDependent, dbo.usi_fn_GetDependentAge(ConSystemID, GETDATE()) as Age, RN  
            --        FROM ( SELECT DISTINCT ConEEID, ConSSN, ConSystemID, ConNameFirst, ConNameLast, ConRelationship, ConDateOfBirth, ConGender, ConIsDependent, dbo.usi_fn_GetDependentAge(ConSystemID, GETDATE()) as Age, +1 AS RN 
            --        FROM dbo.Contacts WITH (NOLOCK) 
            --        WHERE ConIsActive = 'Y' AND ConRelationship in ('SPS' ,'DP')
            --    UNION 
            --SELECT DISTINCT ConEEID, ConSSN, ConSystemID, ConNameFirst, ConNameLast, ConRelationship, ConDateOfBirth, ConGender, ConIsDependent, [dbo].[usi_fn_GetDependentAge](ConSystemID, GETDATE()) as Age, ROW_NUMBER() OVER (PARTITION BY ConEEID ORDER By ConDateOfBirth ASC)+1  AS RN 
            --        FROM ( SELECT DISTINCT ConEEID, ConSSN, ConSystemID, ConNameFirst, ConNameLast, ConRelationship, ConDateOfBirth, ConGender, ConIsDependent
            --        FROM dbo.Contacts WITH (NOLOCK) 
            --        WHERE ConIsActive = 'Y' AND ConRelationship IN ('CHL','STC','DCH','DPC') AND ConIsDependent = 'Y'
            --    
          
                 SELECT DISTINCT ConEEID, ConSSN, ConSystemID, ConNameFirst, ConNameLast, ConRelationship, ConDateOfBirth, ConGender, ConIsDependent, dbo.usi_fn_GetDependentAge(ConSystemID, GETDATE()) as Age, RN  
                    FROM (
                    -- MW coomented out 7/17/2023
                    --SELECT DISTINCT ConEEID, ConSSN, ConSystemID, ConNameFirst, ConNameLast, ConRelationship, ConDateOfBirth, ConGender, ConIsDependent, dbo.usi_fn_GetDependentAge(ConSystemID, GETDATE()) as Age, +1 AS RN 
     --               FROM dbo.Contacts WITH (NOLOCK) 
                    --JOIN dbo.U_dsi_BDM_EAGRFLQB iBdm  WITH (NOLOCK) 
     --                               ON iBdm.BdmEEID = ConEEID
     --                               AND iBdm.BdmDepRecID = ConSystemId
     --                               AND iBdm.BdmRunId = 'QB'
     --                               AND iBdm.BdmRecType = 'DEP'
     --            WHERE  ConRelationship in ( 'SPS' ,'DP')
     --           UNION 
           SELECT DISTINCT ConEEID, ConSSN, ConSystemID, ConNameFirst, ConNameLast, ConRelationship, ConDateOfBirth, ConGender, ConIsDependent, [dbo].[usi_fn_GetDependentAge](ConSystemID, GETDATE()) as Age, ROW_NUMBER() OVER (PARTITION BY ConEEID ORDER By ConDateOfBirth ASC) AS RN 
                    FROM ( SELECT DISTINCT ConEEID, ConSSN, ConSystemID, ConNameFirst, ConNameLast, ConRelationship, ConDateOfBirth, ConGender, ConIsDependent
                    FROM dbo.Contacts WITH (NOLOCK) 
                    JOIN dbo.U_dsi_BDM_EAGRFLQB iBdm  WITH (NOLOCK) 
                                    ON iBdm.BdmEEID = ConEEID
                                    AND iBdm.BdmDepRecID = ConSystemId
                                    AND iBdm.BdmRunId = 'QB'
                                    AND iBdm.BdmRecType = 'DEP'
                 WHERE  ConRelationship IN ('CHL','STC','DCH','DPC', 'SPS' ,'DP') AND ConIsDependent = 'Y'-- MW added  'SPS' ,'DP') AND ConIsDependent = 'Y' 7/17/2023
                ) AS CHLD
            ) AS Con
        ) CON
         ON ConEEID = BdmEEID
        AND ConSystemID = BdmDepRecID
    LEFT JOIN dbo.contacts Spouse WITH (NOLOCK)
        ON Spouse.ConEEID = CON.ConEEID
        AND Spouse.ConRelationship in ( 'SPS' ,'DP')
 
    ;

    ---------------------------------
    -- DETAIL RECORD - U_EAGRFLQB_ELEC_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EAGRFLQB_ELEC_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EAGRFLQB_ELEC_drvTbl;
   SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvEmpNoSort = eepSSN
        ,drvSubSort = concat(CASE WHEN BdmDedCode in ('UMEDP','GMED') and BdmBenOption = 'EE' THEN '4010'
                                      WHEN BdmDedCode in ('UMEDP') and BdmBenOption IN ('EES','EEDP') THEN '4011'
                                      WHEN BdmDedCode in ('GMED') and BdmBenOption in ('EES','EEDP','EE1C') THEN '4011'
                                      WHEN BdmDedCode in ('UMEDP') and BdmBenOption = 'EEC' THEN '4012'
                                      WHEN BdmDedCode in ('GMED') and BdmBenOption IN ('EEF','EEDPF') THEN '4012'
                                      WHEN BdmDedCode in ('UMEDP') and BdmBenOption IN ('EEF','EEDPF') THEN '4013'                                     
                                      WHEN BdmDedCode in ('UDENP') and BdmBenOption = 'EE' THEN  '5015'
                                      WHEN BdmDedCode in ('GDEN') and BdmBenOption = 'EE' THEN  '7021' 
                                      WHEN BdmDedCode in ('UDENP') and BdmBenOption in ('EES','EEDP') THEN  '5016'
                                      WHEN BdmDedCode in ('GDEN') and BdmBenOption in ('EES','EEDP','EE1C') THEN  '7022' 
                                      WHEN BdmDedCode in ('UDENP') and BdmBenOption in ('EEC') THEN  '5017'
                                      WHEN BdmDedCode in ('UDENP') and BdmBenOption in ('EEF','EEDPF') THEN  '5018'
                                      WHEN BdmDedCode in ('GDEN') and BdmBenOption in ('EEF','EEDPF') THEN  '7023'
                                      WHEN BdmDedCode in ('UVISP') and BdmBenOption = 'EE' THEN  '6020'  
                                      WHEN BdmDedCode in ('GVIS') and BdmBenOption = 'EE' THEN  '6015'  
                                      WHEN BdmDedCode in ('UVISP') and BdmBenOption in ('EES','EEDP') THEN  '6021'
                                      WHEN BdmDedCode in ('UVISP') and BdmBenOption in ('EEC') THEN  '6022'  
                                      WHEN BdmDedCode in ('GVIS') and BdmBenOption in ('EES','EEDP','EE1C') THEN  '6016' 
                                      WHEN BdmDedCode in ('UVISP') and BdmBenOption in ('EEF','EEDPF') THEN  '6023'
                                      WHEN BdmDedCode in ('GVIS') and BdmBenOption in ('EEF','EEDPF') THEN  '6017'
                                      WHEN BdmDedCode in ('FSAI') THEN '8000' 
                                      WHEN BdmDedCode in ('FSA') THEN '7000'
                                      WHEN BdmDedCode in ('GFSA') THEN '5000'
                                 END ,  CASE WHEN BdmIsPQB = 'Y' THEN 0 ELSE FORMAT(RN,'0') END)
        ,drvSSN3 =  CASE WHEN  (BdmChangeReason in ('204', 'LEVNT4', '201', 'LEVNT3', '210') or BdmCobraReason in ('204', 'LEVNT4', '201', 'LEVNT3', '210'))  and   BdmIsPQB = 'Y'   then CON.ConSSN 
                                    WHEN (bdmCobraReason  in ('210') or bdmCobraReason  in ('210')) AND Spouse.conSSN  is not null THEN Spouse.conSSN 
                                    --WHEN bdmCobraReason  in ('210') AND Spouse.conSSN  is null THEN Con.conSSN 
                                    WHEN EecTermReason  = '203'  then Con.ConSSN
                                    else eepssn END
                                    
        ,drvDependentNumber2 = CASE WHEN BDMRECTYPE =  'EMP' THEN 0   WHEN bdmCobraReason  in ('210') THEN  CAST( RN as INt) -1 ELSE  FORMAT(RN,'0') END -- MW updated 7/17/2023
        --CASE WHEN BdmIsPQB = 'Y' THEN 0 ELSE FORMAT(RN,'0') END
        --CASE WHEN BdmChangeReason in ('204', 'LEVNT4', '201', 'LEVNT3', '210') AND RN = 1 then 0 
  --                                  WHEN BdmCobraReason in ('204', 'LEVNT4', '201', 'LEVNT3', '210') AND RN = 1 then 0 
  --                                  WHEN EecTermReason  = '203' AND RN = 1 then 0
  --                                  else FORMAT(RN,'0') END
        ,drvPlanCodeEnrolledIn =
                            CASE WHEN BdmDedCode in ('UMEDP','GMED') and BdmBenOption = 'EE' THEN '4010'
                                    WHEN BdmDedCode in ('UMEDP','GMED') and (BdmChangeReason in ('204', 'LEVNT4', '201', 'LEVNT3') or BdmCobraReason in ('204', 'LEVNT4', '201', 'LEVNT3'))  and   BdmIsPQB = 'Y' then '4010'
                                      WHEN BdmDedCode in ('UMEDP') and BdmBenOption IN ('EES','EEDP') THEN '4011'
                                      WHEN BdmDedCode in ('GMED') and BdmBenOption in ('EES','EEDP','EE1C') THEN '4011'
                                      WHEN BdmDedCode in ('UMEDP') and BdmBenOption = 'EEC' THEN '4012'
                                      WHEN BdmDedCode in ('GMED') and BdmBenOption IN ('EEF','EEDPF') THEN '4012'
                                      WHEN BdmDedCode in ('UMEDP') and BdmBenOption IN ('EEF','EEDPF') THEN '4013'                                     
                                      WHEN BdmDedCode in ('UDENP') and BdmBenOption = 'EE' THEN  '5015'
                                      WHEN BdmDedCode in ('UDENP') and (BdmChangeReason in ('204', 'LEVNT4', '201', 'LEVNT3') or BdmCobraReason in ('204', 'LEVNT4', '201', 'LEVNT3'))  and   BdmIsPQB = 'Y' then '5015'
                                      WHEN BdmDedCode in ('GDEN') and BdmBenOption = 'EE' THEN  '7021' 
                                      WHEN BdmDedCode in ('GDEN') and (BdmChangeReason in ('204', 'LEVNT4', '201', 'LEVNT3') or BdmCobraReason in ('204', 'LEVNT4', '201', 'LEVNT3'))  and   BdmIsPQB = 'Y' then '7021'
                                      WHEN BdmDedCode in ('UDENP') and BdmBenOption in ('EES','EEDP') THEN  '5016'
                                      WHEN BdmDedCode in ('GDEN') and BdmBenOption in ('EES','EEDP','EE1C') THEN  '7022' 
                                      WHEN BdmDedCode in ('UDENP') and BdmBenOption in ('EEC') THEN  '5017'
                                      WHEN BdmDedCode in ('UDENP') and BdmBenOption in ('EEF','EEDPF') THEN  '5018'
                                      WHEN BdmDedCode in ('GDEN') and BdmBenOption in ('EEF','EEDPF') THEN  '7023'
                                      WHEN BdmDedCode in ('UVISP') and BdmBenOption = 'EE' THEN  '6020'
                                      WHEN BdmDedCode in ('UVISP') and (BdmChangeReason in ('204', 'LEVNT4', '201', 'LEVNT3') or BdmCobraReason in ('204', 'LEVNT4', '201', 'LEVNT3'))  and   BdmIsPQB = 'Y' then '6020'
                                      WHEN BdmDedCode in ('GVIS') and BdmBenOption = 'EE' THEN  '6015'
                                      WHEN BdmDedCode in ('GVIS') and (BdmChangeReason in ('204', 'LEVNT4', '201', 'LEVNT3') or BdmCobraReason in ('204', 'LEVNT4', '201', 'LEVNT3'))  and   BdmIsPQB = 'Y' then '6015'
                                      WHEN BdmDedCode in ('UVISP') and BdmBenOption in ('EES','EEDP') THEN  '6021'
                                      WHEN BdmDedCode in ('UVISP') and BdmBenOption in ('EEC') THEN  '6022'  
                                      WHEN BdmDedCode in ('GVIS') and BdmBenOption in ('EES','EEDP','EE1C') THEN  '6016' 
                                      WHEN BdmDedCode in ('UVISP') and BdmBenOption in ('EEF','EEDPF') THEN  '6023'
                                      WHEN BdmDedCode in ('GVIS') and BdmBenOption in ('EEF','EEDPF') THEN  '6017'
                                      WHEN BdmDedCode in ('FSAI') THEN '8000' 
                                      WHEN BdmDedCode in ('FSA') THEN '7000'
                                      WHEN BdmDedCode in ('GFSA') THEN '5000'
                                 END
        ,drvMonthlyPremium = '' ---'0.00'
    INTO dbo.U_EAGRFLQB_ELEC_drvTbl
       FROM dbo.U_EAGRFLQB_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.U_dsi_BDM_EAGRFLQB WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
 LEFT    JOIN (
            --SELECT DISTINCT ConEEID, ConSSN, ConSystemID, ConNameFirst, ConNameLast, ConRelationship, ConDateOfBirth, ConGender, ConIsDependent, dbo.usi_fn_GetDependentAge(ConSystemID, GETDATE()) as Age, RN  
            --        FROM ( SELECT DISTINCT ConEEID, ConSSN, ConSystemID, ConNameFirst, ConNameLast, ConRelationship, ConDateOfBirth, ConGender, ConIsDependent, dbo.usi_fn_GetDependentAge(ConSystemID, GETDATE()) as Age, +1 AS RN 
            --        FROM dbo.Contacts WITH (NOLOCK) 
            --        WHERE ConIsActive = 'Y' AND ConRelationship in ( 'SPS' ,'DP')
            --    UNION 
            --SELECT DISTINCT ConEEID, ConSSN, ConSystemID, ConNameFirst, ConNameLast, ConRelationship, ConDateOfBirth, ConGender, ConIsDependent, [dbo].[usi_fn_GetDependentAge](ConSystemID, GETDATE()) as Age, ROW_NUMBER() OVER (PARTITION BY ConEEID ORDER By ConDateOfBirth ASC)+1  AS RN 
            --        FROM ( SELECT DISTINCT ConEEID, ConSSN, ConSystemID, ConNameFirst, ConNameLast, ConRelationship, ConDateOfBirth, ConGender, ConIsDependent
            --        FROM dbo.Contacts WITH (NOLOCK) 
            --        WHERE ConIsActive = 'Y' AND ConRelationship IN ('CHL','STC','DCH','DPC') AND ConIsDependent = 'Y'
               
                 
                 SELECT DISTINCT ConEEID, ConSSN, ConSystemID, ConNameFirst, ConNameLast, ConRelationship, ConDateOfBirth, ConGender, ConIsDependent, dbo.usi_fn_GetDependentAge(ConSystemID, GETDATE()) as Age,  RN  
                    FROM (
                    --MW commented out 7/17/2023
                    --SELECT DISTINCT ConEEID, ConSSN, ConSystemID, ConNameFirst, ConNameLast, ConRelationship, ConDateOfBirth, ConGender, ConIsDependent, dbo.usi_fn_GetDependentAge(ConSystemID, GETDATE()) as Age, +1 AS RN 
     --               FROM dbo.Contacts WITH (NOLOCK) 
                    --JOIN dbo.U_dsi_BDM_EAGRFLQB iBdm  WITH (NOLOCK) 
     --                               ON iBdm.BdmEEID = ConEEID
     --                               AND iBdm.BdmDepRecID = ConSystemId
     --                               AND iBdm.BdmRunId = 'QB'
     --                               AND iBdm.BdmRecType = 'DEP'
     --            WHERE  ConRelationship in ( 'SPS' ,'DP') AND ConIsDependent = 'Y'
     --           UNION 
            SELECT DISTINCT ConEEID, ConSSN, ConSystemID, ConNameFirst, ConNameLast, ConRelationship, ConDateOfBirth, ConGender, ConIsDependent, [dbo].[usi_fn_GetDependentAge](ConSystemID, GETDATE()) as Age, ROW_NUMBER() OVER (PARTITION BY ConEEID ORDER By ConDateOfBirth ASC) AS RN 
                    FROM ( SELECT DISTINCT ConEEID, ConSSN, ConSystemID, ConNameFirst, ConNameLast, ConRelationship, ConDateOfBirth, ConGender, ConIsDependent
                    FROM dbo.Contacts WITH (NOLOCK) 
                    JOIN dbo.U_dsi_BDM_EAGRFLQB iBdm  WITH (NOLOCK) 
                                    ON iBdm.BdmEEID = ConEEID
                                    AND iBdm.BdmDepRecID = ConSystemId
                                    AND iBdm.BdmRunId = 'QB'
                                    AND iBdm.BdmRecType = 'DEP'
                 WHERE  ConRelationship IN ('CHL','STC','DCH','DPC', 'SPS' ,'DP') AND ConIsDependent = 'Y'--MW add 'SPS' ,'DP') AND ConIsDependent = 'Y'- 7/17/2023
                ) AS CHLD
            ) AS Con
        ) CON
         ON ConEEID = BdmEEID
        AND ConSystemID = BdmDepRecID
    LEFT JOIN dbo.contacts Spouse WITH (NOLOCK)
        ON Spouse.ConEEID = CON.ConEEID
        AND Spouse.ConRelationship in ( 'SPS' ,'DP')

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
ALTER VIEW dbo.dsi_vwEAGRFLQB_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EAGRFLQB_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EAGRFLQB%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202301101'
       ,expStartPerControl     = '202301101'
       ,expLastEndPerControl   = '202303179'
       ,expEndPerControl       = '202303179'
WHERE expFormatCode = 'EAGRFLQB';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEAGRFLQB_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EAGRFLQB_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EAGRFLQB' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EAGRFLQB'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EAGRFLQB'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EAGRFLQB', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EAGRFLQB', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EAGRFLQB', 'UseFileName', 'V', 'Y'


-- End ripout