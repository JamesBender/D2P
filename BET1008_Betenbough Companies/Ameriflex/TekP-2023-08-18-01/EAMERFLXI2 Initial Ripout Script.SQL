/**********************************************************************************

EAMERFLXI2: Ameriflex FSA IB

FormatCode:     EAMERFLXI2
Project:        Ameriflex FSA IB
Client ID:      BET1008
Date/time:      2023-09-08 10:40:57.740
Ripout version: 7.4
Export Type:    Web
Status:         Production
Environment:    NWP
Server:         NW1WUP7DB03
Database:       ULTIPRO_WPBETB
Web Filename:   BET1008_SC6HO_EEHISTORY_EAMERFLXI2_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EAMERFLXI2_SavePath') IS NOT NULL DROP TABLE dbo.U_EAMERFLXI2_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EAMERFLXI2'


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
WHERE FormatCode = 'EAMERFLXI2'
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
WHERE ExpFormatCode = 'EAMERFLXI2'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EAMERFLXI2')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EAMERFLXI2'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EAMERFLXI2'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EAMERFLXI2'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EAMERFLXI2'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EAMERFLXI2'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EAMERFLXI2'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EAMERFLXI2'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EAMERFLXI2'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EAMERFLXI2'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEAMERFLXI2_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEAMERFLXI2_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EAMERFLXI2') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EAMERFLXI2];
GO
IF OBJECT_ID('U_EAMERFLXI2_File') IS NOT NULL DROP TABLE [dbo].[U_EAMERFLXI2_File];
GO
IF OBJECT_ID('U_EAMERFLXI2_EEList') IS NOT NULL DROP TABLE [dbo].[U_EAMERFLXI2_EEList];
GO
IF OBJECT_ID('U_EAMERFLXI2_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EAMERFLXI2_drvTbl];
GO
IF OBJECT_ID('U_EAMERFLXI2_DedList') IS NOT NULL DROP TABLE [dbo].[U_EAMERFLXI2_DedList];
GO
IF OBJECT_ID('U_EAMERFLXI2_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EAMERFLXI2_AuditFields];
GO
IF OBJECT_ID('U_EAMERFLXI2_Audit') IS NOT NULL DROP TABLE [dbo].[U_EAMERFLXI2_Audit];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EAMERFLXI2','Ameriflex FSA IB','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','480','S','N','EYYG0H000RY0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EYYG0H000RY0','2','D','10','1',NULL,'Record ID',NULL,NULL,'"drvRecordID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EYYG0H000RY0','6','D','10','3',NULL,'TPA ID',NULL,NULL,'"drvTPAID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EYYG0H000RY0','9','D','10','9',NULL,'Group Code',NULL,NULL,'"drvGroupCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EYYG0H000RY0','9','D','10','18',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EYYG0H000RY0','5','D','10','27',NULL,'Prefix',NULL,NULL,'"drvPreFix"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EYYG0H000RY0','26','D','10','32',NULL,'Last Name',NULL,NULL,'"drvNameLast"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EYYG0H000RY0','19','D','10','58',NULL,'First Name',NULL,NULL,'"drvNameFirst"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EYYG0H000RY0','1','D','10','77',NULL,'Middle Initial',NULL,NULL,'"drvNameMI"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EYYG0H000RY0','19','D','10','78',NULL,'Phone',NULL,NULL,'"drvTelephone"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EYYG0H000RY0','36','D','10','97',NULL,'Address Line 1',NULL,NULL,'"drvAddressLine1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EYYG0H000RY0','36','D','10','133',NULL,'Address Line 2',NULL,NULL,'"drvAddressLine2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EYYG0H000RY0','20','D','10','169',NULL,'City',NULL,NULL,'"drvAddressCity"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EYYG0H000RY0','2','D','10','189',NULL,'State',NULL,NULL,'"drvAddressState"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EYYG0H000RY0','9','D','10','191',NULL,'Zip',NULL,NULL,'"drvAddressZipCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EYYG0H000RY0','3','D','10','200',NULL,'Country',NULL,NULL,'"drvAddressCountry"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EYYG0H000RY0','8','D','10','203',NULL,'Date of Birth',NULL,NULL,'"drvDateofBirth"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EYYG0H000RY0','1','D','10','211',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EYYG0H000RY0','12','D','10','212',NULL,'HICN',NULL,NULL,'"drvHICN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EYYG0H000RY0','1','D','10','224',NULL,'Reimbursement Method',NULL,NULL,'"drvReimbursementMethod"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EYYG0H000RY0','50','D','10','225',NULL,'Bank Name',NULL,NULL,'"drvBankName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EYYG0H000RY0','9','D','10','275',NULL,'ABA Routing Number',NULL,NULL,'"drvABARoutingNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EYYG0H000RY0','20','D','10','284',NULL,'Bank Account Number',NULL,NULL,'"drvBankAcctNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EYYG0H000RY0','1','D','10','304',NULL,'ACH Account Type',NULL,NULL,'"drvACHAcctType"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EYYG0H000RY0','100','D','10','305',NULL,'Email',NULL,NULL,'"drvAddressEmail"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EYYG0H000RY0','20','D','10','405',NULL,'Location Code',NULL,NULL,'"drvLocationCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EYYG0H000RY0','1','D','10','425',NULL,'Employment Status',NULL,NULL,'"drvBenefitStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EYYG0H000RY0','8','D','10','426',NULL,'Eligibility Date',NULL,NULL,'"drvOriginalEnrollmentDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EYYG0H000RY0','8','D','10','434',NULL,'Benefit Termination Date',NULL,NULL,'"drvBenefitTerminationDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EYYG0H000RY0','9','D','10','442',NULL,'New SSN',NULL,NULL,'"drvNewSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EYYG0H000RY0','30','D','10','451',NULL,'Health Plan ID',NULL,NULL,'"drvHealthPlanID"','(''UA''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EAMERFLXI2_20230908.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','201801019','EMPEXPORT','OEACTIVE','Jun 29 2017 12:00AM','EAMERFLXI2',NULL,NULL,NULL,'201801019','Jun 29 2017 12:00AM','Dec 30 1899 12:00AM','201801011',NULL,NULL,NULL,'201801011',dbo.fn_GetTimedKey(),NULL,'ULTI_WPEDFT',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','201706299','EMPEXPORT','OEPASSIVE','Jun 29 2017 12:00AM','EAMERFLXI2',NULL,NULL,NULL,'201706299','Jun 29 2017 12:00AM','Dec 30 1899 12:00AM','201706291',NULL,NULL,NULL,'201706291',dbo.fn_GetTimedKey(),NULL,'ULTI_WPEDFT',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Ameriflex IB V2 File','201802029','EMPEXPORT','ONDEM_XOE','Feb  8 2018 11:15AM','EAMERFLXI2',NULL,NULL,NULL,'201802029','Feb  2 2018 12:00AM','Dec 30 1899 12:00AM','201801191','149',NULL,NULL,'201801191',dbo.fn_GetTimedKey(),NULL,'ULTI_WPEDFT',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N',NULL,NULL,NULL,NULL,'FSA IB Export','202207079','EMPEXPORT','SCH_EAMERF',NULL,'EAMERFLXI2',NULL,NULL,NULL,'202307109',NULL,NULL,'202307021',NULL,NULL,NULL,'202206301',dbo.fn_GetTimedKey(),NULL,NULL,NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Test Purposes Only','202202081','EMPEXPORT','TEST_XOE','Feb  8 2022  2:39PM','EAMERFLXI2',NULL,NULL,NULL,'202202081','Feb  8 2022 12:00AM','Dec 30 1899 12:00AM','202202011','18',NULL,NULL,'202202011',dbo.fn_GetTimedKey(),NULL,'ULTI_WPBETB',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAMERFLXI2','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAMERFLXI2','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAMERFLXI2','InitialSort','C','drvSSN');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAMERFLXI2','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAMERFLXI2','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAMERFLXI2','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EAMERFLXI2','D10','dbo.U_EAMERFLXI2_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EAMERFLXI2_Audit
-----------

IF OBJECT_ID('U_EAMERFLXI2_Audit') IS NULL
CREATE TABLE [dbo].[U_EAMERFLXI2_Audit] (
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
-- Create table U_EAMERFLXI2_AuditFields
-----------

IF OBJECT_ID('U_EAMERFLXI2_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EAMERFLXI2_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EAMERFLXI2_DedList
-----------

IF OBJECT_ID('U_EAMERFLXI2_DedList') IS NULL
CREATE TABLE [dbo].[U_EAMERFLXI2_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EAMERFLXI2_drvTbl
-----------

IF OBJECT_ID('U_EAMERFLXI2_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EAMERFLXI2_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvRecordID] varchar(2) NOT NULL,
    [drvTPAID] varchar(6) NOT NULL,
    [drvGroupCode] varchar(9) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvPreFix] varchar(1) NOT NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMI] varchar(1) NULL,
    [drvTelephone] varchar(1) NOT NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvAddressCountry] char(3) NULL,
    [drvDateofBirth] varchar(8) NULL,
    [drvGender] varchar(1) NULL,
    [drvHICN] varchar(1) NOT NULL,
    [drvReimbursementMethod] varchar(1) NOT NULL,
    [drvBankName] varchar(1) NOT NULL,
    [drvABARoutingNumber] varchar(1) NOT NULL,
    [drvBankAcctNumber] varchar(1) NOT NULL,
    [drvACHAcctType] varchar(1) NOT NULL,
    [drvAddressEmail] varchar(50) NULL,
    [drvLocationCode] varchar(20) NOT NULL,
    [drvBenefitStatus] varchar(1) NOT NULL,
    [drvOriginalEnrollmentDate] varchar(8) NULL,
    [drvBenefitTerminationDate] varchar(8) NULL,
    [drvNewSSN] nvarchar(2000) NULL,
    [drvHealthPlanID] varchar(1) NOT NULL
);

-----------
-- Create table U_EAMERFLXI2_EEList
-----------

IF OBJECT_ID('U_EAMERFLXI2_EEList') IS NULL
CREATE TABLE [dbo].[U_EAMERFLXI2_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EAMERFLXI2_File
-----------

IF OBJECT_ID('U_EAMERFLXI2_File') IS NULL
CREATE TABLE [dbo].[U_EAMERFLXI2_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(480) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EAMERFLXI2]
    @SystemID char(12)
AS
/**********************************************************************************
Client Name: Betenbough

Created By: Gaspare Simeti
Business Analyst: Gaspare Simeti
Create Date: 2/1/22
Service Request Number: 00289016

Purpose: Ameriflex IB V2

Revision History'
----------------
Update By           Date           Request Num        Desc
Marie Waters        09/08/2023       TekP-2023-08-18-01 Updated dedcode, fields and session names
XXXX                XX/XX/2017     SR-2017-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EAMERFLXI2';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EAMERFLXI2';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EAMERFLXI2';
SELECT * FROM dbo.AscExp WHERE expFormatCode = 'EAMERFLXI2';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EAMERFLXI2' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAMERFLXI2', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAMERFLXI2', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAMERFLXI2', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAMERFLXI2', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAMERFLXI2', 'SCH_EAMERF';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EAMERFLXI2';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EAMERFLXI2', @AllObjects = 'Y',@IsWeb = 'Y'
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
            ,@EndPerControl     VARCHAR(9)
            ,@PlanDate datetime
            ,@PlanYearEnd datetime;

    -- Set FormatCode
    SELECT @FormatCode = 'EAMERFLXI2';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        -- ,@PlanDate = case when DatePart(MM,@EndDate) < 2 then cast(left(convert(char(8),DateADD(year,-1,@EndDate),112),4) as char(4)) + '0101'
                    -- else cast(left(convert(char(8),@EndDate,112),4) as char(4)) + '0101' end
        -- ,@PlanYearEnd = DateADD(year,1,@PlanDate)-1

    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    PRINT 'Start Date: ' + CONVERT(VARCHAR(26),@StartDate,100);
    PRINT 'End Date:  ' + CONVERT(VARCHAR(26),@EndDate,100);

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EAMERFLXI2_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EAMERFLXI2_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EAMERFLXI2_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EAMERFLXI2_AuditFields;
    CREATE TABLE dbo.U_EAMERFLXI2_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_EAMERFLXI2_AuditFields VALUES ('EmpComp','EecEmplStatus');
    INSERT INTO dbo.U_EAMERFLXI2_AuditFields VALUES ('EmpPers','EepSSN');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EAMERFLXI2_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EAMERFLXI2_Audit;
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
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audTableName, audFieldName ORDER BY audDateTime DESC)
    INTO dbo.U_EAMERFLXI2_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EAMERFLXI2_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';



    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','HSA'); --HSAER,FSAMD, FSADC, FSALT
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES(@FormatCode,'FutureDatedStartDateDays','30')
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES(@FormatCode,'FutureDatedStopDateDays','30')    
    

    -- Required OE parameters
    IF @ExportCode LIKE '%PASSIVE'
    BEGIN
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'OEType','PASSIVE');
    END;

    IF @ExportCode LIKE '%ACTIVE'
    BEGIN
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'OEType','ACTIVE');
        INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'IncludeOEDrops', 'Y')
    END;

    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    -- Step20 Clean up eelist if needed to only include employees with deductions
            delete dbo.u_EAMERFLXI2_eelist
            from dbo.u_EAMERFLXI2_eelist a
            where not exists(select 1 from U_dsi_bdm_EmpDeductions
                            where a.xeeid = eedeeid
                            and a.xcoid = eedcoid
                            and eedformatcode = @formatcode
                            and eedvalidforexport = 'Y')

    --Clean EEs terminated more than 14 days ago
            delete dbo.u_EAMERFLXI2_EELIST
            from dbo.u_EAMERFLXI2_EELIST
            join empcomp t with (nolock) on xeeid = eeceeid and xcoid = eeccoid 
            where eecdateoftermination + 14 < getdate()

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EAMERFLXI2_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EAMERFLXI2_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EAMERFLXI2_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRecordID = 'IB'
        ,drvTPAID = 'AMF001'
        ,drvGroupCode = 'AMFBETENB'
        ,drvSSN = eepSSN
        ,drvPreFix = ''
        ,drvNameLast = EepNameLast
        ,drvNameFirst = EepNameFirst
        ,drvNameMI = substring(eepNameMiddle,1,1)
        ,drvTelephone = ''
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvAddressCountry = EepAddressCountry
        ,drvDateofBirth = CONVERT(VARCHAR(8), EepDateOfBirth, 112)
        ,drvGender = IIF(EepGender IN ('M','F'), EepGender, 'N') --12/8/20 wchong
        ,drvHICN = '~'
        ,drvReimbursementMethod = '~'
        ,drvBankName = '~'
        ,drvABARoutingNumber = '~'
        ,drvBankAcctNumber = '~'
        ,drvACHAcctType = '~'
        ,drvAddressEmail = EepAddressEMail
        ,drvLocationCode = 'Betenbough Companies'
        ,drvBenefitStatus = CASE EecEmplStatus
                                WHEN 'T' THEN 'T'
                                ELSE 'A'
                                END
        ,drvOriginalEnrollmentDate = CONVERT(VARCHAR(8),EecDateOfLastHire, 112)
        ,drvBenefitTerminationDate = CASE EecEmplStatus
                                WHEN 'T' THEN CONVERT(VARCHAR(8),eedBenStopDate, 112) ---CONVERT(varchar,EecDateOfTermination,112)
                                ELSE ''
                                END
        ,drvNewSSN = audssn.audNewValue
        ,drvHealthPlanID = ''
    INTO dbo.U_EAMERFLXI2_drvTbl
    FROM dbo.U_EAMERFLXI2_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN Company
        ON cmpcoid = xcoid
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = xEEID 
        AND EedCoID = xCoID
        AND EedFormatCode = @FormatCode 
        AND EedValidForExport = 'Y'
    LEFT JOIN (select audEEID,audFieldName,audDateTime,audOldValue,audNewValue from U_EAMERFLXI2_Audit) audssn
                ON xEEID = audssn.audEEID and audssn.audFieldName = 'EmpPers' and audssn.audOldValue IS NOT NULL
    ;

    

    --==========================================
    -- Set FileName
    --==========================================
    --IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    --BEGIN
    --    UPDATE dbo.U_dsi_Parameters
    --        SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_EAMERFLXI2_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
    --                              WHEN @ExportCode LIKE 'OE%' THEN 'OE_EAMERFLXI2_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
    --                              ELSE 'EAMERFLXI2_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
    --                         END
    --    WHERE FormatCode = @FormatCode;
    --END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEAMERFLXI2_Export AS
    SELECT TOP 20000000 Data
    FROM dbo.U_EAMERFLXI2_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EAMERFLXI2%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201706221'
       ,expStartPerControl     = '201706221'
       ,expLastEndPerControl   = '201706299'
       ,expEndPerControl       = '201706299'
WHERE expFormatCode = 'EAMERFLXI2';

**********************************************************************************/
GO
Create View dbo.dsi_vwEAMERFLXI2_Export as
                            select top 200000000 Data from dbo.U_EAMERFLXI2_File with (nolock)
                            order by substring(RecordSet,2,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EAMERFLXI2' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EAMERFLXI2'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EAMERFLXI2'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EAMERFLXI2', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EAMERFLXI2', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EAMERFLXI2', 'UseFileName', 'V', 'Y'


-- End ripout