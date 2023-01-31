/**********************************************************************************

ELHMFSAHSA: HealthEquity HSA Payroll Export

FormatCode:     ELHMFSAHSA
Project:        HealthEquity HSA Payroll Export
Client ID:      LAR1002
Date/time:      2023-01-25 16:41:08.163
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    N35
Server:         N3SUP5DB01
Database:       ULTIPRO_LARM
Web Filename:   LAR1002_HG5V3_EEHISTORY_ELHMFSAHSA_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ELHMFSAHSA_SavePath') IS NOT NULL DROP TABLE dbo.U_ELHMFSAHSA_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ELHMFSAHSA'


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
WHERE FormatCode = 'ELHMFSAHSA'
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
WHERE ExpFormatCode = 'ELHMFSAHSA'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ELHMFSAHSA')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ELHMFSAHSA'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ELHMFSAHSA'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ELHMFSAHSA'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ELHMFSAHSA'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ELHMFSAHSA'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ELHMFSAHSA'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ELHMFSAHSA'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ELHMFSAHSA'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ELHMFSAHSA'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwELHMFSAHSA_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwELHMFSAHSA_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ELHMFSAHSA') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ELHMFSAHSA];
GO
IF OBJECT_ID('U_ELHMFSAHSA_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ELHMFSAHSA_PEarHist];
GO
IF OBJECT_ID('U_ELHMFSAHSA_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ELHMFSAHSA_PDedHist];
GO
IF OBJECT_ID('U_ELHMFSAHSA_File') IS NOT NULL DROP TABLE [dbo].[U_ELHMFSAHSA_File];
GO
IF OBJECT_ID('U_ELHMFSAHSA_EEList') IS NOT NULL DROP TABLE [dbo].[U_ELHMFSAHSA_EEList];
GO
IF OBJECT_ID('U_ELHMFSAHSA_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ELHMFSAHSA_drvTbl];
GO
IF OBJECT_ID('U_ELHMFSAHSA_DedList') IS NOT NULL DROP TABLE [dbo].[U_ELHMFSAHSA_DedList];
GO
IF OBJECT_ID('U_ELHMFSAHSA_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ELHMFSAHSA_AuditFields];
GO
IF OBJECT_ID('U_ELHMFSAHSA_Audit') IS NOT NULL DROP TABLE [dbo].[U_ELHMFSAHSA_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_ELHMFSAHSA') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ELHMFSAHSA];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ELHMFSAHSA','HealthEquity HSA Payroll Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','ELHMFSAHSAZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ELHMFSAHSAZ0','50','D','10','1',NULL,'Record Type',NULL,NULL,'"FND"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ELHMFSAHSAZ0','50','D','10','2',NULL,'Group ID',NULL,NULL,'"64058"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ELHMFSAHSAZ0','50','D','10','3',NULL,'Participant or Employee ID',NULL,NULL,'"drvParticipantorEmployeeID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ELHMFSAHSAZ0','50','D','10','4',NULL,'Unique ID',NULL,NULL,'"drvUniqueID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ELHMFSAHSAZ0','50','D','10','5',NULL,'Last Name',NULL,NULL,'"drvLastName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ELHMFSAHSAZ0','50','D','10','6',NULL,'First Name',NULL,NULL,'"drvFirstName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ELHMFSAHSAZ0','50','D','10','7',NULL,'Plan Code',NULL,NULL,'"drvPlanCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ELHMFSAHSAZ0','50','D','10','8',NULL,'Pre-Tax Payroll Deduction',NULL,NULL,'"drvPreTaxPayrollDeduction"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ELHMFSAHSAZ0','50','D','10','9',NULL,'Post-Tax Payroll Deduction',NULL,NULL,'"drvPostTaxPayrollDeduction"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ELHMFSAHSAZ0','50','D','10','10',NULL,'Other Post-Tax Participant Contribution',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ELHMFSAHSAZ0','50','D','10','11',NULL,'Pre-Tax Program Sponsor Contribution (Applies towa',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ELHMFSAHSAZ0','50','D','10','12',NULL,'Post-Tax Program Sponsor Contribution (Applies tow',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ELHMFSAHSAZ0','50','D','10','13',NULL,'Pre-Tax Program Sponsor Contribution (Additional B',NULL,NULL,'"drvPreTaxProgramSponContrib"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ELHMFSAHSAZ0','50','D','10','14',NULL,'Post-Tax Program Sponsor Contribution (Additional',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ELHMFSAHSAZ0','50','D','10','15',NULL,'Funding Date',NULL,NULL,'"drvFundingDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ELHMFSAHSAZ0','50','D','10','16',NULL,'Pre-Tax Program Sponsor Interest',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ELHMFSAHSAZ0','50','D','10','17',NULL,'Post-Tax Program Sponsor Interest',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ELHMFSAHSAZ0','50','D','10','18',NULL,'Balance Transfer From Account',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ELHMFSAHSAZ0','50','D','10','19',NULL,'Balance Transfer Percentage',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ELHMFSAHSAZ0','50','D','10','20',NULL,'Balance Transfer Max Amount',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ELHMFSAHSAZ0','50','D','10','21',NULL,'Custom Contribution Description',NULL,NULL,'""','(''SS''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ELHMFSAHSA_20230125.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202301199','EMPEXPORT','OEACTIVE',NULL,'ELHMFSAHSA',NULL,NULL,NULL,'202301199','Jan 19 2023  8:01AM','Jan 19 2023  8:01AM','202301011',NULL,'','','202301011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202301199','EMPEXPORT','OEPASSIVE',NULL,'ELHMFSAHSA',NULL,NULL,NULL,'202301199','Jan 19 2023  8:01AM','Jan 19 2023  8:01AM','202301011',NULL,'','','202301011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'HealthEquity HSA Payroll Expor','202301199','EMPEXPORT','ONDEM_XOE',NULL,'ELHMFSAHSA',NULL,NULL,NULL,'202301199','Jan 19 2023  8:01AM','Jan 19 2023  8:01AM','202301011',NULL,'','','202301011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'HealthEquity HSA Payroll-Sched','202301199','EMPEXPORT','SCH_ELHMFS',NULL,'ELHMFSAHSA',NULL,NULL,NULL,'202301199','Jan 19 2023  8:01AM','Jan 19 2023  8:01AM','202301011',NULL,'','','202301011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',',GUX0K,GJKFU,GJKM5,B3CUB,B3CPR,B3CW8,AZPEM,B3DJD,AZWE8,INEXS,B3FF0,B3D9I,AZOQ2,AZOUC,AZOWO,AZOYS,AZP42,AZP6Q,B3CNL,AZP9A,B3EYC,B3FBA,AZPH6,AZPJ1,AZPRC,AZPMS,B3EBW,AZPYQ,B3E9R,AZQ0S,AZQ2N,AZQ4P,AZQ7R,B3D03,AZW52,AZW7R,AZW9P,B3CS8,B3CYB,B3D1Z,B3D44,B3D5X,B3D7U,B3DB6,B3ESW,B3DL6,B3E7O,B3EDU,B3EFT,B3EHU,B3ELB,B3ENC,B3EP8,B3ER7,B3EWL,AZPP3,AZTMC,B3F06,B3F8X,B3FID,B3FK0,B3FLQ,B3G84,B3GAB,B3HAH,B3HCE,B3HEF,B3HFZ,B3HHN,B3FGI,B3DGX,B3DCY,B3DEU,AZTPR,B3EJI,B3EUR,B3FD5,GSYM8,B3GGN',NULL,NULL,NULL,'HealthEquity HSA Payroll-Test','202301259','EMPEXPORT','TEST_XOE','Jan 25 2023 12:00AM','ELHMFSAHSA',NULL,NULL,NULL,'202301259','Jan 25 2023 12:00AM','Dec 30 1899 12:00AM','202301011',NULL,'eecPayGroup','DHC,DRE,LRE,MEG,MFO,MLR,MMC,MPM,PFS,SLB,SSC','202301011',dbo.fn_GetTimedKey(),NULL,'us3mWaLAR1002',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELHMFSAHSA','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELHMFSAHSA','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELHMFSAHSA','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELHMFSAHSA','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELHMFSAHSA','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELHMFSAHSA','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELHMFSAHSA','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ELHMFSAHSA','D10','dbo.U_ELHMFSAHSA_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_ELHMFSAHSA
-----------

IF OBJECT_ID('U_dsi_BDM_ELHMFSAHSA') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ELHMFSAHSA] (
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
-- Create table U_ELHMFSAHSA_Audit
-----------

IF OBJECT_ID('U_ELHMFSAHSA_Audit') IS NULL
CREATE TABLE [dbo].[U_ELHMFSAHSA_Audit] (
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
-- Create table U_ELHMFSAHSA_AuditFields
-----------

IF OBJECT_ID('U_ELHMFSAHSA_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ELHMFSAHSA_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_ELHMFSAHSA_DedList
-----------

IF OBJECT_ID('U_ELHMFSAHSA_DedList') IS NULL
CREATE TABLE [dbo].[U_ELHMFSAHSA_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_ELHMFSAHSA_drvTbl
-----------

IF OBJECT_ID('U_ELHMFSAHSA_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ELHMFSAHSA_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(9) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvParticipantorEmployeeID] char(9) NULL,
    [drvUniqueID] char(11) NULL,
    [drvLastName] varchar(8000) NULL,
    [drvFirstName] varchar(8000) NULL,
    [drvPlanCode] varchar(35) NULL,
    [drvPreTaxPayrollDeduction] nvarchar(4000) NULL,
    [drvPostTaxPayrollDeduction] nvarchar(4000) NULL,
    [drvPreTaxProgramSponContrib] nvarchar(4000) NULL,
    [drvFundingDate] varchar(30) NULL
);

-----------
-- Create table U_ELHMFSAHSA_EEList
-----------

IF OBJECT_ID('U_ELHMFSAHSA_EEList') IS NULL
CREATE TABLE [dbo].[U_ELHMFSAHSA_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ELHMFSAHSA_File
-----------

IF OBJECT_ID('U_ELHMFSAHSA_File') IS NULL
CREATE TABLE [dbo].[U_ELHMFSAHSA_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);

-----------
-- Create table U_ELHMFSAHSA_PDedHist
-----------

IF OBJECT_ID('U_ELHMFSAHSA_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ELHMFSAHSA_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhFSAMD] numeric NULL,
    [PdhFSADC] numeric NULL,
    [PdhHSA] numeric NULL,
    [PdhHSAER] numeric NULL,
    [PdhTSAMT] numeric NULL,
    [PdhTSAM2] numeric NULL
);

-----------
-- Create table U_ELHMFSAHSA_PEarHist
-----------

IF OBJECT_ID('U_ELHMFSAHSA_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ELHMFSAHSA_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ELHMFSAHSA]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Larry H Miller

Created By: Marie Waters
Business Analyst: Katherine Ricca
Create Date: 01/19/2023
Service Request Number: TekP-2022-10-31-02 

Purpose: HealthEquity HSA Payroll Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ELHMFSAHSA';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ELHMFSAHSA';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ELHMFSAHSA';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ELHMFSAHSA';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ELHMFSAHSA' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELHMFSAHSA', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELHMFSAHSA', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELHMFSAHSA', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELHMFSAHSA', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELHMFSAHSA', 'SCH_ELHMFS';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ELHMFSAHSA';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ELHMFSAHSA', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ELHMFSAHSA';

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
    DELETE FROM dbo.U_ELHMFSAHSA_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ELHMFSAHSA_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_ELHMFSAHSA_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ELHMFSAHSA_AuditFields;
    CREATE TABLE dbo.U_ELHMFSAHSA_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_ELHMFSAHSA_AuditFields VALUES ('EmpComp','EecDateofTermination');
    INSERT INTO dbo.U_ELHMFSAHSA_AuditFields VALUES ('EmpComp','EecEmplStatus');
    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ELHMFSAHSA_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ELHMFSAHSA_Audit;
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
    INTO dbo.U_ELHMFSAHSA_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_ELHMFSAHSA_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ELHMFSAHSA_Audit ON dbo.U_ELHMFSAHSA_Audit (audEEID,audKey2);

    ----================
    ---- Changes Only
    ----================
    --DELETE FROM dbo.U_ELHMFSAHSA_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_ELHMFSAHSA_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'FSAMD,FSADC,HSA,HSAER,TSAM2,TSAMT';

    IF OBJECT_ID('U_ELHMFSAHSA_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ELHMFSAHSA_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ELHMFSAHSA_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DedList);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

    -- Non-Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');

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

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_ELHMFSAHSA_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ELHMFSAHSA_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt     = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt     = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        ,PdhFSAMD        = SUM(CASE WHEN PdhDedCode IN ('FSAMD') AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt  ELSE 0.00 END)
        ,PdhFSADC        = SUM(CASE WHEN PdhDedCode IN ('FSADC') AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt  ELSE 0.00 END)
        ,PdhHSA          = SUM(CASE WHEN PdhDedCode IN ('HSA') AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt  ELSE 0.00 END)  
        ,PdhHSAER        = SUM(CASE WHEN PdhDedCode IN ('HSAER') AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt  ELSE 0.00 END)  
        ,PdhTSAMT        = SUM(CASE WHEN PdhDedCode IN ('TSAMT') AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhTSAM2        = SUM(CASE WHEN PdhDedCode IN ('TSAM2') AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        
    INTO dbo.U_ELHMFSAHSA_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ELHMFSAHSA_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_ELHMFSAHSA_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ELHMFSAHSA_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        --,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        --,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        ---- YTD Payroll Amount/Hours
        --,PehCurAmtYTD           = SUM(PehCurAmt)
        --,PehCurHrsYTD           = SUM(PehCurHrs)
        ---- Current Include Deferred Comp Amount/Hours
        --,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        --,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        ---- YTD Include Deferred Comp Amount/Hours
        --,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        --,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_ELHMFSAHSA_PEarHist
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
    ---------------------------------
    -- DETAIL RECORD - U_ELHMFSAHSA_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ELHMFSAHSA_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ELHMFSAHSA_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eecempno
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvParticipantorEmployeeID = EecEmpNo
        ,drvUniqueID = eepSSN
        ,drvLastName = REPLACE(EepNameLast, ',', '')
        ,drvFirstName = REPLACE(EepNameFirst, ',', '')
        ,drvPlanCode = CASE WHEN HSADedCode IS NOT NULL THEN 'HSA'
                            --WHEN Bdmdedcode IN ('HSAER') THEN 'HSAER'
                            WHEN FSAMDDedCode IS NOT NULL THEN 'HCFSA' + Cast(YEAR(GETDATE())as varchar)
                            WHEN FSADCDedCode IS NOT NULL THEN 'DCFSA' + Cast(YEAR(GETDATE())as varchar)
                            WHEN TRANSITDedCode  IS NOT NULL THEN 'Mass Transit'
                         END

        ,drvPreTaxPayrollDeduction = CASE WHEN FSAMDDedCode IS NOT NULL THEN FORMAT(PdhFSAMD, '#0.00')
                                          WHEN FSADCDedCode IS NOT NULL THEN FORMAT(PdhFSADC, '#0.00')
                                          WHEN HSADedCode IS NOT NULL and PdhHSA > 0.00 THEN FORMAT(PdhHSA, '#0.00') 
                                          WHEN TSAMTDedCode IS NOT NULL THEN FORMAT(PdhTSAMT, '#0.00')
                                        END
        ,drvPostTaxPayrollDeduction = CASE WHEN TSAM2DedCode IS NOT NULL and  FORMAT(PdhTSAM2, '#0.00') <> '0.00' THEN FORMAT(PdhTSAM2, '#0.00') END
        ,drvPreTaxProgramSponContrib = CASE WHEN HSADedCode IS NOT NULL and  PdhHSAER <> 0.00 THEN FORMaT(PdhHSAER,'0.00') END
        ,drvFundingDate = CONVERT(VARCHAR,DATEADD(day, -2,PrgPayDate ) ,101)
   INTO dbo.U_ELHMFSAHSA_drvTbl
    FROM dbo.U_ELHMFSAHSA_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN (Select BdmEEID, BdmCOID
                , MAX(Case WHEN Bdmdedcode IN ('HSA', 'HSAER') THEN  Bdmdedcode END) HSADedCode
                , MAX(Case WHEN Bdmdedcode IN ('FSAMD') THEN  Bdmdedcode END) FSAMDDedCode
                , MAX(Case WHEN Bdmdedcode IN ('FSADC') THEN  Bdmdedcode END) FSADCDedCode
                , MAX(Case WHEN Bdmdedcode IN ('TSAMT') THEN  Bdmdedcode END) TSAMTDedCode
                , MAX(Case WHEN Bdmdedcode IN ('TSAM2') THEN  Bdmdedcode END) TSAM2DedCode
                , MAX(Case WHEN Bdmdedcode IN ('TSAMT', 'TSAM2') THEN  Bdmdedcode END) TRANSITDedCode
                FROM dbo.U_dsi_BDM_ELHMFSAHSA WITH (NOLOCK)
                WHERE BdmDedCode IN ('FSAMD','FSADC','HSA','HSAER','TSAM2','TSAMT')
                Group by BdmEEID, BdmCOID ,Bdmdedcode
            ) BDM
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
     JOIN dbo.U_ELHMFSAHSA_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
    JOIN dbo.U_ELHMFSAHSA_PEarHist
        ON PehEEID = xEEID
    LEFT JOIN dbo.U_ELHMFSAHSA_Audit WITH (NOLOCK)
        ON audEEID = xEEID
    WHERE EecEEtype <> 'TES' 
        AND (EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' and ((FORMAT(PdhHSAER,'0.00') <> '0.00' or FORMAT(PdhFSAMD,'0.00') <> '0.00' or FORMAT(PdhFSADC,'0.00') <> '0.00' or FORMAT(PdhHSA,'0.00') <> '0.00' or FORMAT(PdhTSAMT,'0.00') <> '0.00' or FORMAT(PdhTSAM2,'0.00') <> '0.00') or audFieldName = 'EecDateOfTermination' and audDateTime  BETWEEN  @StartDate AND @EndDate)))

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
ALTER VIEW dbo.dsi_vwELHMFSAHSA_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ELHMFSAHSA_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'ELHMFSAHSA%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202301011'
       ,expStartPerControl     = '202301011'
       ,expLastEndPerControl   = '202301199'
       ,expEndPerControl       = '202301199'
WHERE expFormatCode = 'ELHMFSAHSA';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwELHMFSAHSA_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ELHMFSAHSA_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ELHMFSAHSA' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ELHMFSAHSA'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ELHMFSAHSA'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ELHMFSAHSA', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ELHMFSAHSA', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ELHMFSAHSA', 'UseFileName', 'V', 'Y'


-- End ripout