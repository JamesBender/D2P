/**********************************************************************************

ECENTOPHSA: Optum HSA Enrollment Export

FormatCode:     ECENTOPHSA
Project:        Optum HSA Enrollment Export
Client ID:      CEN1026
Date/time:      2022-10-06 16:16:10.870
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    NWP
Server:         NW1WUP5DB02
Database:       ULTIPRO_WPCENM
Web Filename:   CEN1026_T1LIX_EEHISTORY_ECENTOPHSA_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ECENTOPHSA_SavePath') IS NOT NULL DROP TABLE dbo.U_ECENTOPHSA_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ECENTOPHSA'


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
WHERE FormatCode = 'ECENTOPHSA'
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
WHERE ExpFormatCode = 'ECENTOPHSA'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ECENTOPHSA')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ECENTOPHSA'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ECENTOPHSA'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ECENTOPHSA'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ECENTOPHSA'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ECENTOPHSA'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ECENTOPHSA'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ECENTOPHSA'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ECENTOPHSA'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ECENTOPHSA'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwECENTOPHSA_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECENTOPHSA_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECENTOPHSA') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECENTOPHSA];
GO
IF OBJECT_ID('U_ECENTOPHSA_Trailer') IS NOT NULL DROP TABLE [dbo].[U_ECENTOPHSA_Trailer];
GO
IF OBJECT_ID('U_ECENTOPHSA_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ECENTOPHSA_PEarHist];
GO
IF OBJECT_ID('U_ECENTOPHSA_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ECENTOPHSA_PDedHist];
GO
IF OBJECT_ID('U_ECENTOPHSA_Header') IS NOT NULL DROP TABLE [dbo].[U_ECENTOPHSA_Header];
GO
IF OBJECT_ID('U_ECENTOPHSA_File') IS NOT NULL DROP TABLE [dbo].[U_ECENTOPHSA_File];
GO
IF OBJECT_ID('U_ECENTOPHSA_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECENTOPHSA_EEList];
GO
IF OBJECT_ID('U_ECENTOPHSA_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ECENTOPHSA_drvTbl];
GO
IF OBJECT_ID('U_ECENTOPHSA_DedList') IS NOT NULL DROP TABLE [dbo].[U_ECENTOPHSA_DedList];
GO
IF OBJECT_ID('U_ECENTOPHSA_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ECENTOPHSA_AuditFields];
GO
IF OBJECT_ID('U_ECENTOPHSA_Audit') IS NOT NULL DROP TABLE [dbo].[U_ECENTOPHSA_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_ECENTOPHSA') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ECENTOPHSA];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ECENTOPHSA','Optum HSA Enrollment Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','ECENTOPHSAZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECENTOPHSAZ0','1','H','01','1',NULL,'Record Type ',NULL,NULL,'"drvRecordType "','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECENTOPHSAZ0','40','H','01','2',NULL,'Payer Name ',NULL,NULL,'"drvPayerName "','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECENTOPHSAZ0','40','H','01','3',NULL,'Employer Group Name ',NULL,NULL,'"drvEmployerGroupName "','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECENTOPHSAZ0','8','H','01','4',NULL,'Posting Date ',NULL,NULL,'"drvPostingDate "','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECENTOPHSAZ0','5111','H','01','5',NULL,'Filler ',NULL,NULL,'"drvFillerh"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECENTOPHSAZ0','1','D','10','1',NULL,'Record Type ',NULL,NULL,'"drvRecordType "','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECENTOPHSAZ0','9','D','10','2',NULL,'Employer Number/Group Number ',NULL,NULL,'"drvEmployerNumberGroupNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECENTOPHSAZ0','1','D','10','3',NULL,'Status Field ',NULL,NULL,'"drvStatusField "','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECENTOPHSAZ0','9','D','10','4',NULL,'Social Security Number  ',NULL,NULL,'"drvSocialSecurityNumber  "','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECENTOPHSAZ0','18','D','10','5',NULL,'Employee First Name ',NULL,NULL,'"drvEmployeeFirstName "','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECENTOPHSAZ0','1','D','10','6',NULL,'Employee Middle Initial ',NULL,NULL,'"drvEmployeeMiddleInitial "','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECENTOPHSAZ0','18','D','10','7',NULL,'Employee Last Name ',NULL,NULL,'"drvEmployeeLastName "','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECENTOPHSAZ0','30','D','10','8',NULL,'Street Address 1 ',NULL,NULL,'"drvStreetAddress1 "','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECENTOPHSAZ0','20','D','10','9',NULL,'Street Address 2 ',NULL,NULL,'"drvStreetAddress2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECENTOPHSAZ0','22','D','10','10',NULL,'City ',NULL,NULL,'"drvCity "','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECENTOPHSAZ0','2','D','10','11',NULL,'State ',NULL,NULL,'"drvState "','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECENTOPHSAZ0','9','D','10','12',NULL,'Zip Code + Four ',NULL,NULL,'"drvZipCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECENTOPHSAZ0','8','D','10','13',NULL,'Date of Birth ',NULL,NULL,'"drvDateofBirth "','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECENTOPHSAZ0','10','D','10','14',NULL,'Personal Phone Number ',NULL,NULL,'"drvPersonalPhoneNumber "','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECENTOPHSAZ0','10','D','10','15',NULL,'Business Phone Number ',NULL,NULL,'"drvBusinessPhoneNumber "','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECENTOPHSAZ0','60','D','10','16',NULL,'e-Mail Address ',NULL,NULL,'"drvEMailAddress "','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECENTOPHSAZ0','11','D','10','17',NULL,'Employee ID ',NULL,NULL,'"drvEmployeeID "','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ECENTOPHSAZ0','6','D','10','18',NULL,'Filler ',NULL,NULL,'"drvFiller1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ECENTOPHSAZ0','1','D','10','19',NULL,'Coverage Type ',NULL,NULL,'"drvCoverageType "','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ECENTOPHSAZ0','8','D','10','20',NULL,'HDHP Start Date ',NULL,NULL,'"drvHDHPStartDate "','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ECENTOPHSAZ0','8','D','10','21',NULL,'Termination Date ',NULL,NULL,'"drvTerminationDate "','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ECENTOPHSAZ0','1','D','10','22',NULL,'HSA Affirmation ',NULL,NULL,'"drvHSAAffirmation "','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ECENTOPHSAZ0','30','D','10','23',NULL,'Mailing Address 1 ',NULL,NULL,'"drvMailingAddress1 "','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ECENTOPHSAZ0','20','D','10','24',NULL,'Mailing Address 2 ',NULL,NULL,'"drvMailingAddress2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ECENTOPHSAZ0','22','D','10','25',NULL,'Mailing City ',NULL,NULL,'"drvMailingCity "','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ECENTOPHSAZ0','2','D','10','26',NULL,'Mailing State ',NULL,NULL,'"drvMailingState "','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ECENTOPHSAZ0','9','D','10','27',NULL,'Mailing Zip Code + Four ',NULL,NULL,'"drvMailingZipCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ECENTOPHSAZ0','209','D','10','28',NULL,'Filler ',NULL,NULL,'"drvFiller2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ECENTOPHSAZ0','1','D','10','29',NULL,'Wet Signature Ind ',NULL,NULL,'"drvWetSignatureInd "','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ECENTOPHSAZ0','1','D','10','30',NULL,'E Signature Ind  ',NULL,NULL,'"drvESignatureInd  "','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ECENTOPHSAZ0','10','D','10','31',NULL,'Verification ID ',NULL,NULL,'"drvVerificationID "','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ECENTOPHSAZ0','9','D','10','32',NULL,'Division Code ',NULL,NULL,'"drvDivisionCode "','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ECENTOPHSAZ0','17','D','10','33',NULL,'Filler ',NULL,NULL,'"drvFiller3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ECENTOPHSAZ0','7','D','10','34',NULL,'Filler ',NULL,NULL,'"drvFiller4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECENTOPHSAZ0','1','T','90','1',NULL,'Record Type ',NULL,NULL,'"drvRecordType "','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECENTOPHSAZ0','7','T','90','2',NULL,'Number of Accounts ',NULL,NULL,'"drvNumberofAccounts "','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECENTOPHSAZ0','592','T','90','3',NULL,'Filler ',NULL,NULL,'"drvFillert"','(''UA''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ECENTOPHSA_20221006.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202210069','EMPEXPORT','OEACTIVE',NULL,'ECENTOPHSA',NULL,NULL,NULL,'202210069','Oct  6 2022  1:25PM','Oct  6 2022  1:25PM','202209291',NULL,'','','202209291',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202210069','EMPEXPORT','OEPASSIVE',NULL,'ECENTOPHSA',NULL,NULL,NULL,'202210069','Oct  6 2022  1:25PM','Oct  6 2022  1:25PM','202209291',NULL,'','','202209291',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Optum HSA Enrollment Export','202210069','EMPEXPORT','ONDEM_XOE',NULL,'ECENTOPHSA',NULL,NULL,NULL,'202210069','Oct  6 2022  1:25PM','Oct  6 2022  1:25PM','202209291',NULL,'','','202209291',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Optum HSA Enrollment Exp-Sched','202210069','EMPEXPORT','SCH_ECENTO',NULL,'ECENTOPHSA',NULL,NULL,NULL,'202210069','Oct  6 2022  1:25PM','Oct  6 2022  1:25PM','202209291',NULL,'','','202209291',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Optum HSA Enrollment Exp-Test','202210069','EMPEXPORT','TEST_XOE',NULL,'ECENTOPHSA',NULL,NULL,NULL,'202210069','Oct  6 2022  1:25PM','Oct  6 2022  1:25PM','202209291',NULL,'','','202209291',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECENTOPHSA','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECENTOPHSA','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECENTOPHSA','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECENTOPHSA','SubSort','C','drvSubsort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECENTOPHSA','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECENTOPHSA','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECENTOPHSA','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECENTOPHSA','H01','dbo.U_ECENTOPHSA_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECENTOPHSA','D10','dbo.U_ECENTOPHSA_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECENTOPHSA','T90','dbo.U_ECENTOPHSA_Trailer',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_ECENTOPHSA
-----------

IF OBJECT_ID('U_dsi_BDM_ECENTOPHSA') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ECENTOPHSA] (
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
-- Create table U_ECENTOPHSA_Audit
-----------

IF OBJECT_ID('U_ECENTOPHSA_Audit') IS NULL
CREATE TABLE [dbo].[U_ECENTOPHSA_Audit] (
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
-- Create table U_ECENTOPHSA_AuditFields
-----------

IF OBJECT_ID('U_ECENTOPHSA_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ECENTOPHSA_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_ECENTOPHSA_DedList
-----------

IF OBJECT_ID('U_ECENTOPHSA_DedList') IS NULL
CREATE TABLE [dbo].[U_ECENTOPHSA_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_ECENTOPHSA_drvTbl
-----------

IF OBJECT_ID('U_ECENTOPHSA_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ECENTOPHSA_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubsort] varchar(1) NOT NULL,
    [drvRecordType] varchar(1) NOT NULL,
    [drvEmployerNumberGroupNumber] varchar(6) NOT NULL,
    [drvStatusField] varchar(1) NOT NULL,
    [drvSocialSecurityNumber] char(11) NULL,
    [drvEmployeeFirstName] varchar(100) NULL,
    [drvEmployeeMiddleInitial] varchar(1) NULL,
    [drvEmployeeLastName] varchar(100) NULL,
    [drvStreetAddress1] varchar(255) NULL,
    [drvStreetAddress2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZipCode] varchar(50) NULL,
    [drvDateofBirth] varchar(8) NULL,
    [drvPersonalPhoneNumber] varchar(50) NULL,
    [drvBusinessPhoneNumber] varchar(50) NULL,
    [drvEMailAddress] varchar(50) NULL,
    [drvEmployeeID] char(9) NULL,
    [drvFiller1] varchar(1) NOT NULL,
    [drvCoverageType] varchar(1) NULL,
    [drvHDHPStartDate] varchar(1) NOT NULL,
    [drvTerminationDate] varchar(1) NOT NULL,
    [drvHSAAffirmation] varchar(1) NOT NULL,
    [drvMailingAddress1] varchar(1) NOT NULL,
    [drvMailingAddress2] varchar(1) NOT NULL,
    [drvMailingCity] varchar(1) NOT NULL,
    [drvMailingState] varchar(1) NOT NULL,
    [drvMailingZipCode] varchar(1) NOT NULL,
    [drvFiller2] varchar(1) NOT NULL,
    [drvWetSignatureInd] varchar(1) NOT NULL,
    [drvESignatureInd] varchar(1) NOT NULL,
    [drvVerificationID] varchar(1) NOT NULL,
    [drvDivisionCode] varchar(1) NOT NULL,
    [drvFiller3] varchar(1) NOT NULL,
    [drvFiller4] varchar(1) NOT NULL
);

-----------
-- Create table U_ECENTOPHSA_EEList
-----------

IF OBJECT_ID('U_ECENTOPHSA_EEList') IS NULL
CREATE TABLE [dbo].[U_ECENTOPHSA_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ECENTOPHSA_File
-----------

IF OBJECT_ID('U_ECENTOPHSA_File') IS NULL
CREATE TABLE [dbo].[U_ECENTOPHSA_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);

-----------
-- Create table U_ECENTOPHSA_Header
-----------

IF OBJECT_ID('U_ECENTOPHSA_Header') IS NULL
CREATE TABLE [dbo].[U_ECENTOPHSA_Header] (
    [drvRecordType] varchar(1) NOT NULL,
    [drvPayerName] varchar(3) NOT NULL,
    [drvEmployerGroupName] varchar(16) NOT NULL,
    [drvPostingDate] varchar(8) NULL,
    [drvFillerh] varchar(1) NOT NULL
);

-----------
-- Create table U_ECENTOPHSA_PDedHist
-----------

IF OBJECT_ID('U_ECENTOPHSA_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ECENTOPHSA_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhSource1] numeric NULL,
    [PdhSource2] numeric NULL,
    [PdhSource3] numeric NULL,
    [PdhSource4] numeric NULL,
    [PdhSource5] numeric NULL
);

-----------
-- Create table U_ECENTOPHSA_PEarHist
-----------

IF OBJECT_ID('U_ECENTOPHSA_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ECENTOPHSA_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PehCurAmt] numeric NULL,
    [PehCurHrs] decimal NULL,
    [PehCurAmtYTD] money NULL,
    [PehCurHrsYTD] decimal NULL,
    [PehInclInDefComp] money NULL,
    [PehInclInDefCompHrs] decimal NULL,
    [PehInclInDefCompYTD] money NULL,
    [PehInclInDefCompHrsYTD] decimal NULL
);

-----------
-- Create table U_ECENTOPHSA_Trailer
-----------

IF OBJECT_ID('U_ECENTOPHSA_Trailer') IS NULL
CREATE TABLE [dbo].[U_ECENTOPHSA_Trailer] (
    [drvRecordType] varchar(1) NOT NULL,
    [drvNumberofAccounts] int NULL,
    [drvFillert] varchar(1) NOT NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECENTOPHSA]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Centerfield Media

Created By: Marie Waters
Business Analyst: Lea King
Create Date: 10/06/2022
Service Request Number: TekP-2022-09-06-02

Purpose: Optum HSA Enrollment Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECENTOPHSA';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECENTOPHSA';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECENTOPHSA';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECENTOPHSA';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECENTOPHSA' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECENTOPHSA', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECENTOPHSA', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECENTOPHSA', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECENTOPHSA', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECENTOPHSA', 'SCH_ECENTO';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ECENTOPHSA';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ECENTOPHSA', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ECENTOPHSA';

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
    DELETE FROM dbo.U_ECENTOPHSA_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECENTOPHSA_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_ECENTOPHSA_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ECENTOPHSA_AuditFields;
    CREATE TABLE dbo.U_ECENTOPHSA_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_ECENTOPHSA_AuditFields VALUES ('EmpComp','EecDateofTermination');
    INSERT INTO dbo.U_ECENTOPHSA_AuditFields VALUES ('EmpComp','EecEmplStatus');
   
    INSERT INTO dbo.U_ECENTOPHSA_AuditFields VALUES ('EmpDed','eedDedCode');
    INSERT INTO dbo.U_ECENTOPHSA_AuditFields VALUES ('EmpComp','EecEmpNo');
    
    INSERT INTO dbo.U_ECENTOPHSA_AuditFields VALUES ('EmpPers','EepDateOfBirth');
    INSERT INTO dbo.U_ECENTOPHSA_AuditFields VALUES ('EmpPers','EepGender');
    INSERT INTO dbo.U_ECENTOPHSA_AuditFields VALUES ('EmpPers','EepNameFirst');
    INSERT INTO dbo.U_ECENTOPHSA_AuditFields VALUES ('EmpPers','EepNameLast');
    INSERT INTO dbo.U_ECENTOPHSA_AuditFields VALUES ('EmpPers','EepNameMiddle');
    INSERT INTO dbo.U_ECENTOPHSA_AuditFields VALUES ('EmpPers','EepOldSSN');
    INSERT INTO dbo.U_ECENTOPHSA_AuditFields VALUES ('EmpPers','EepSSN');
    INSERT INTO dbo.U_ECENTOPHSA_AuditFields VALUES ('EmpPers','eepphonehomenumber');
    INSERT INTO dbo.U_ECENTOPHSA_AuditFields VALUES ('EmpPers','EepAddressEMail');
    INSERT INTO dbo.U_ECENTOPHSA_AuditFields VALUES ('EmpComp','EecPhoneBusinessNumber');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ECENTOPHSA_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ECENTOPHSA_Audit;
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
        --,audInsert = CASE WHEN  ISNULL(audOldValue,'') = ''  And   audNewValue is not null AND audAction = 'Insert' THEN 'Y' ELSE 'N' END
       -- ,audUpdate = CASE WHEN  audOldValue <> audNewValue AND audAction = 'UPDATE' THEN 'Y' ELSE 'N' END
    INTO dbo.U_ECENTOPHSA_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_ECENTOPHSA_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ECENTOPHSA_Audit ON dbo.U_ECENTOPHSA_Audit (audEEID,audKey2);

    --================
    -- Changes Only
    --================
    DELETE FROM dbo.U_ECENTOPHSA_EEList
    WHERE NOT EXISTS (SELECT 1 FROM dbo.U_ECENTOPHSA_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'HSACF,HSACI,HSAF,HSAI,HSASA,HSASF,HSASS';

    IF OBJECT_ID('U_ECENTOPHSA_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ECENTOPHSA_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ECENTOPHSA_DedList
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

    ----==========================================
    ---- Build Working Tables
    ----==========================================

    -------------------------------
    ---- Working Table - PDedHist
    -------------------------------
    --IF OBJECT_ID('U_ECENTOPHSA_PDedHist','U') IS NOT NULL
    --    DROP TABLE dbo.U_ECENTOPHSA_PDedHist;
    --SELECT DISTINCT
    --     PdhEEID
    --    -- Current Payroll Amounts
    --    ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
    --    -- YTD Payroll Amounts
    --    ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
    --    ,PdhERCurAmtYTD = SUM(PdhERCurAmt)

    --    -- Categorize Payroll Amounts
    --    ,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('HSACF') THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('HSAF') THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('HSAI') THEN PdhEECurAmt ELSE 0.00 END)        
    --    ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('HSASF') THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('HSASS') THEN PdhEECurAmt ELSE 0.00 END)
  
    --INTO dbo.U_ECENTOPHSA_PDedHist
    --FROM dbo.PDedHist WITH (NOLOCK)
    --JOIN dbo.U_ECENTOPHSA_DedList WITH (NOLOCK)
    --    ON DedCode = PdhDedCode
    --WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    --AND PdhPerControl <= @EndPerControl
    --AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    --GROUP BY PdhEEID
    --HAVING (SUM(PdhEECurAmt) <> 0.00
    --    OR SUM(PdhERCurAmt) <> 0.00
    --);


    -------------------------------
    ---- Working Table - PEarHist
    -------------------------------
    --IF OBJECT_ID('U_ECENTOPHSA_PEarHist','U') IS NOT NULL
    --    DROP TABLE dbo.U_ECENTOPHSA_PEarHist;
    --SELECT DISTINCT
    --     PehEEID
    --    ,PrgPayDate             = MAX(PrgPayDate)
    --    -- Current Payroll Amount/Hours
    --    ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
    --    ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
    --    -- YTD Payroll Amount/Hours
    --    ,PehCurAmtYTD           = SUM(PehCurAmt)
    --    ,PehCurHrsYTD           = SUM(PehCurHrs)
    --    -- Current Include Deferred Comp Amount/Hours
    --    ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
    --    ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
    --    -- YTD Include Deferred Comp Amount/Hours
    --    ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
    --    ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    --INTO dbo.U_ECENTOPHSA_PEarHist
    --FROM dbo.vw_int_PayReg WITH (NOLOCK)
    --JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
    --    ON PehGenNumber = PrgGenNumber
    --WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    --AND PehPerControl <= @EndPerControl
    --GROUP BY PehEEID
    --HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ECENTOPHSA_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ECENTOPHSA_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECENTOPHSA_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubsort = ''
        -- standard fields above and additional driver fields below
        ,drvRecordType  = 'B'
        ,drvEmployerNumberGroupNumber = '915032'
        ,drvStatusField  = CASE WHEN eecemplstatus = 'T' THEN  '3' else  '1' END
        ,drvSocialSecurityNumber   = EepSSN
        ,drvEmployeeFirstName  = EepNameFirst
        ,drvEmployeeMiddleInitial  = LEFT(EepNameMiddle,1)
        ,drvEmployeeLastName  = EepNameLast
        ,drvStreetAddress1  = EepAddressLine1
        ,drvStreetAddress2 = EepAddressLine2
        ,drvCity  = EepAddressCity
        ,drvState  = EepAddressState
        ,drvZipCode = Case when Len(EepAddressZipCode) = 9 THEN EepAddressZipCode 
						WHEN Len(EepAddressZipCode) = 5 THEN EepAddressZipCode + '0000' END
        ,drvDateofBirth  = CONVERT(VARCHAR(8),EepDateOfBirth, 112)
        ,drvPersonalPhoneNumber  = eepphonehomenumber
        ,drvBusinessPhoneNumber  = EecPhoneBusinessNumber
        ,drvEMailAddress  = EepAddressEMail
        ,drvEmployeeID  = EecEmpNo
        ,drvFiller1 = ''
        ,drvCoverageType  = CASE WHEN bdmdedcode IN( 'HSACF', 'HSAF', 'HSASF', 'HSASS') THEN 'F'
                                 WHEN bdmdedcode IN ( 'HSACI', 'HSAI', 'HSASA') THEN  'I' END

        ,drvHDHPStartDate  = ''
        ,drvTerminationDate  = ''
        ,drvHSAAffirmation  = 'N'
        ,drvMailingAddress1  = ''
        ,drvMailingAddress2 = ''
        ,drvMailingCity  = ''
        ,drvMailingState  = ''
        ,drvMailingZipCode = ''
        ,drvFiller2 = ''
        ,drvWetSignatureInd  = 'Y'
        ,drvESignatureInd   = 'N'
        ,drvVerificationID  = ''
        ,drvDivisionCode  = ''
        ,drvFiller3 = ''
        ,drvFiller4 = ''
    INTO dbo.U_ECENTOPHSA_drvTbl
    FROM dbo.U_ECENTOPHSA_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ECENTOPHSA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
     LEFT JOIN dbo.U_ECENTOPHSA_Audit WITH (NOLOCK)
        ON audEEID = xEEID
        Where eecEEtype <> 'TES' 
        AND  (EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND EecDateofTermination  BETWEEN  @StartDate AND @EndDate))
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ECENTOPHSA_Header','U') IS NOT NULL
        DROP TABLE dbo.U_ECENTOPHSA_Header;
    SELECT DISTINCT
         drvRecordType  = 'A'
        ,drvPayerName  = 'UKG'
        ,drvEmployerGroupName  = 'CENTERFIELDMEDIA'
        ,drvPostingDate  = CONVERT(VARCHAR(8),GetDate(), 112)
        ,drvFillerh = ''
    INTO dbo.U_ECENTOPHSA_Header
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ECENTOPHSA_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_ECENTOPHSA_Trailer;
    SELECT DISTINCT
         drvRecordType  = 'Z'
        ,drvNumberofAccounts  = (SELECT COUNT(*) FROM dbo.U_ECENTOPHSA_drvTbl WITH (NOLOCK))
        ,drvFillert = ''
    INTO dbo.U_ECENTOPHSA_Trailer
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
ALTER VIEW dbo.dsi_vwECENTOPHSA_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECENTOPHSA_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'ECENTOPHSA%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202209291'
       ,expStartPerControl     = '202209291'
       ,expLastEndPerControl   = '202210069'
       ,expEndPerControl       = '202210069'
WHERE expFormatCode = 'ECENTOPHSA';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwECENTOPHSA_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ECENTOPHSA_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ECENTOPHSA' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ECENTOPHSA'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ECENTOPHSA'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECENTOPHSA', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ECENTOPHSA', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECENTOPHSA', 'UseFileName', 'V', 'Y'


-- End ripout