/**********************************************************************************

EDISCOBQB: Discovery Benefits Cobra

FormatCode:     EDISCOBQB
Project:        Discovery Benefits Cobra
Client ID:      EDK1000
Date/time:      2021-11-02 23:27:32.197
Ripout version: 7.4
Export Type:    Web
Status:         Production
Environment:    EWP
Server:         EW4WUP3DB02
Database:       ULTIPRO_WPEDK
Web Filename:   EDK1000_4RCLS_EEHISTORY_EDISCOBQB_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EDISCOBQB_SavePath') IS NOT NULL DROP TABLE dbo.U_EDISCOBQB_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EDISCOBQB'


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
WHERE FormatCode = 'EDISCOBQB'
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
WHERE ExpFormatCode = 'EDISCOBQB'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EDISCOBQB')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EDISCOBQB'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EDISCOBQB'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EDISCOBQB'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EDISCOBQB'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EDISCOBQB'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EDISCOBQB'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EDISCOBQB'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EDISCOBQB'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EDISCOBQB'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEDISCOBQB_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEDISCOBQB_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EDISCOBQB') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EDISCOBQB];
GO
IF OBJECT_ID('U_EDISCOBQB_File') IS NOT NULL DROP TABLE [dbo].[U_EDISCOBQB_File];
GO
IF OBJECT_ID('U_EDISCOBQB_EEList') IS NOT NULL DROP TABLE [dbo].[U_EDISCOBQB_EEList];
GO
IF OBJECT_ID('U_EDISCOBQB_drvTbl_QBPLAN') IS NOT NULL DROP TABLE [dbo].[U_EDISCOBQB_drvTbl_QBPLAN];
GO
IF OBJECT_ID('U_EDISCOBQB_drvTbl_QBMSRI') IS NOT NULL DROP TABLE [dbo].[U_EDISCOBQB_drvTbl_QBMSRI];
GO
IF OBJECT_ID('U_EDISCOBQB_drvTbl_QBEVENT') IS NOT NULL DROP TABLE [dbo].[U_EDISCOBQB_drvTbl_QBEVENT];
GO
IF OBJECT_ID('U_EDISCOBQB_drvTbl_QBDEPPLAN') IS NOT NULL DROP TABLE [dbo].[U_EDISCOBQB_drvTbl_QBDEPPLAN];
GO
IF OBJECT_ID('U_EDISCOBQB_drvTbl_QBDEP') IS NOT NULL DROP TABLE [dbo].[U_EDISCOBQB_drvTbl_QBDEP];
GO
IF OBJECT_ID('U_EDISCOBQB_drvTbl_QB') IS NOT NULL DROP TABLE [dbo].[U_EDISCOBQB_drvTbl_QB];
GO
IF OBJECT_ID('U_dsi_BDM_EDISCOBQB') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EDISCOBQB];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EDISCOBQB','Discovery Benefits Cobra','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','EDISCOBQBZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EDISCOBQBZ0','50','H','02','1',NULL,'Version Line Identifier',NULL,NULL,'"[VERSION]"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EDISCOBQBZ0','50','H','02','2',NULL,'Version Number',NULL,NULL,'"1.1"','(''DA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EDISCOBQBZ0','50','D','20','1',NULL,'Record Identifier',NULL,NULL,'"[QB]"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EDISCOBQBZ0','50','D','20','2',NULL,'ClientName',NULL,NULL,'"drvClientName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EDISCOBQBZ0','50','D','20','3',NULL,'ClientDivisionName',NULL,NULL,'"drvClientDivName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EDISCOBQBZ0','50','D','20','4',NULL,'Salutation',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EDISCOBQBZ0','50','D','20','5',NULL,'FirstName',NULL,NULL,'"drvNameFirst"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EDISCOBQBZ0','50','D','20','6',NULL,'MiddleInitial',NULL,NULL,'"drvNameMiddle"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EDISCOBQBZ0','50','D','20','7',NULL,'LastName',NULL,NULL,'"drvNameLast"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EDISCOBQBZ0','50','D','20','8',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EDISCOBQBZ0','50','D','20','9',NULL,'IndividualID',NULL,NULL,'"drvEmpNo"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EDISCOBQBZ0','50','D','20','10',NULL,'Email',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EDISCOBQBZ0','50','D','20','11',NULL,'Phone',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EDISCOBQBZ0','50','D','20','12',NULL,'Phone2',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EDISCOBQBZ0','50','D','20','13',NULL,'Address1',NULL,NULL,'"drvAddressLine1"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EDISCOBQBZ0','50','D','20','14',NULL,'Address2',NULL,NULL,'"drvAddressLine2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EDISCOBQBZ0','50','D','20','15',NULL,'City',NULL,NULL,'"drvAddressCity"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EDISCOBQBZ0','50','D','20','16',NULL,'StateOrProvince',NULL,NULL,'"drvAddressState"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EDISCOBQBZ0','50','D','20','17',NULL,'PostalCode',NULL,NULL,'"drvAddressZipCode"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EDISCOBQBZ0','50','D','20','18',NULL,'Country',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EDISCOBQBZ0','50','D','20','19',NULL,'PremiumAddressSameAsPrimary',NULL,NULL,'"True"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EDISCOBQBZ0','50','D','20','20',NULL,'PremiumAddress1',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EDISCOBQBZ0','50','D','20','21',NULL,'PremiumAddress2',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EDISCOBQBZ0','50','D','20','22',NULL,'PremiumCity',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EDISCOBQBZ0','50','D','20','23',NULL,'PremiumStateOrProvince',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EDISCOBQBZ0','50','D','20','24',NULL,'PremiumPostalCode',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EDISCOBQBZ0','50','D','20','25',NULL,'PremiumCountry',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EDISCOBQBZ0','50','D','20','26',NULL,'Sex',NULL,NULL,'"drvGender"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EDISCOBQBZ0','50','D','20','27',NULL,'DOB',NULL,NULL,'"drvDateOfBirth"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EDISCOBQBZ0','50','D','20','28',NULL,'TobaccoUse',NULL,NULL,'"UNKNOWN"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EDISCOBQBZ0','50','D','20','29',NULL,'EmployeeType',NULL,NULL,'"UNKNOWN"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EDISCOBQBZ0','50','D','20','30',NULL,'EmployeePayrollType',NULL,NULL,'"UNKNOWN"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EDISCOBQBZ0','50','D','20','31',NULL,'YearsOfService',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EDISCOBQBZ0','50','D','20','32',NULL,'PremiumCouponType',NULL,NULL,'"COUPONBOOK"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EDISCOBQBZ0','50','D','20','33',NULL,'UsesHCTC',NULL,NULL,'"False"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EDISCOBQBZ0','50','D','20','34',NULL,'Active',NULL,NULL,'"True"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EDISCOBQBZ0','50','D','20','35',NULL,'AllowMemberSSO',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EDISCOBQBZ0','50','D','20','36',NULL,'BenefitGroup',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EDISCOBQBZ0','50','D','20','37',NULL,'AccountStructure',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EDISCOBQBZ0','50','D','20','38',NULL,'ClientSpecificData',NULL,NULL,'""','(''SS''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EDISCOBQBZ0','50','D','30','1',NULL,'Record Identifier',NULL,NULL,'"[QBEVENT]"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EDISCOBQBZ0','50','D','30','2',NULL,'EventType',NULL,NULL,'"drvEventType"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EDISCOBQBZ0','50','D','30','3',NULL,'EventDate',NULL,NULL,'"drvEventDate"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EDISCOBQBZ0','50','D','30','4',NULL,'EnrollmentDate',NULL,NULL,'"drvEnrollmentDate"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EDISCOBQBZ0','50','D','30','5',NULL,'EmployeeSSN',NULL,NULL,'"drvSSN"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EDISCOBQBZ0','50','D','30','6',NULL,'EmployeeName',NULL,NULL,'"drvName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EDISCOBQBZ0','50','D','30','7',NULL,'SecondEventOriginalFDOC',NULL,NULL,'""','(''SS''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EDISCOBQBZ0','50','D','40','1',NULL,'Record Identifier',NULL,NULL,'"[QBPLANINITIAL]"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EDISCOBQBZ0','50','D','40','2',NULL,'PlanName',NULL,NULL,'"drvPlanName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EDISCOBQBZ0','50','D','40','3',NULL,'CoverageLevel',NULL,NULL,'"drvCoverageLevel"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EDISCOBQBZ0','50','D','40','4',NULL,'NumberOfUnits',NULL,NULL,'""','(''SS''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EDISCOBQBZ0','50','D','50','1',NULL,'Record Identifier',NULL,NULL,'"[QBDEPENDENT]"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EDISCOBQBZ0','50','D','50','2',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EDISCOBQBZ0','50','D','50','3',NULL,'Relationship',NULL,NULL,'"drvRelationship"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EDISCOBQBZ0','50','D','50','4',NULL,'Salutation',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EDISCOBQBZ0','50','D','50','5',NULL,'FirstName',NULL,NULL,'"drvNameFirst"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EDISCOBQBZ0','50','D','50','6',NULL,'MiddleInitial',NULL,NULL,'"drvNameMiddle"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EDISCOBQBZ0','50','D','50','7',NULL,'LastName',NULL,NULL,'"drvNameLast"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EDISCOBQBZ0','50','D','50','8',NULL,'Email',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EDISCOBQBZ0','50','D','50','9',NULL,'Phone',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EDISCOBQBZ0','50','D','50','10',NULL,'Phone2',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EDISCOBQBZ0','50','D','50','11',NULL,'AddressSameAsQB',NULL,NULL,'"drvIsAddressSame"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EDISCOBQBZ0','50','D','50','12',NULL,'Address1',NULL,NULL,'"drvAddressLine1"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EDISCOBQBZ0','50','D','50','13',NULL,'Address2',NULL,NULL,'"drvAddressLine2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EDISCOBQBZ0','50','D','50','14',NULL,'City',NULL,NULL,'"drvAddressCity"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EDISCOBQBZ0','50','D','50','15',NULL,'StateOrProvince',NULL,NULL,'"drvAddressState"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EDISCOBQBZ0','50','D','50','16',NULL,'PostalCode',NULL,NULL,'"drvAddressZipCode"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EDISCOBQBZ0','50','D','50','17',NULL,'Country',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EDISCOBQBZ0','50','D','50','18',NULL,'EnrollmentDate',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EDISCOBQBZ0','50','D','50','19',NULL,'Sex',NULL,NULL,'"drvGender"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EDISCOBQBZ0','50','D','50','20',NULL,'DOB',NULL,NULL,'"drvDateOfBirth"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EDISCOBQBZ0','50','D','50','21',NULL,'IsQMCSO',NULL,NULL,'"drvISQMCO"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EDISCOBQBZ0','50','D','60','1',NULL,'Record Identifier',NULL,NULL,'"[QBDEPENDENTPLANINITIAL]"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EDISCOBQBZ0','50','D','60','2',NULL,'PlanName',NULL,NULL,'"drvPlanName"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EDISCOBQBZ0','50','D','70','1',NULL,'Record Identifier',NULL,NULL,'"[QBPLANMEMBERSPECIFICRATEINITIAL]"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EDISCOBQBZ0','50','D','70','2',NULL,'PlanName',NULL,NULL,'"drvPlanName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EDISCOBQBZ0','50','D','70','3',NULL,'Rate',NULL,NULL,'"drvRate"','(''UA''=''Q'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EDISCOBQB_20211102.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'COBRA QB - On Demand','202101269','EMPEXPORT','ONDMDQBOE','Apr  7 2020  9:50AM','EDISCOBQB',NULL,NULL,NULL,'202101269','Feb 28 2020 12:00AM','Dec 30 1899 12:00AM','202101011',NULL,'','','202101011',dbo.fn_GetTimedKey(),NULL,'ULTI_WPBOWMN',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N',',KOZWN',NULL,NULL,NULL,'COBRA QB - Scheduled','202101269','EMPEXPORT','SCHEDQB','Feb  5 2019  9:00AM','EDISCOBQB',NULL,NULL,NULL,'202109229','Jan 13 2016  8:53AM','Jan 13 2016  8:53AM','202109151',NULL,'','','202101011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'COBRA QB - Test','202110279','EMPEXPORT','TESTQBOE','Oct 27 2021  5:37PM','EDISCOBQB',NULL,NULL,NULL,'202110279','Oct 27 2021 12:00AM','Dec 30 1899 12:00AM','202110011','29','','','202110011',dbo.fn_GetTimedKey(),NULL,'us3rVaEDK1000',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCOBQB','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCOBQB','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCOBQB','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCOBQB','SubSort2','C','drvSubSort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCOBQB','SubSort3','C','drvSubSort3');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCOBQB','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCOBQB','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCOBQB','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCOBQB','H02','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCOBQB','D20','dbo.U_EDISCOBQB_drvTbl_QB WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCOBQB','D30','dbo.U_EDISCOBQB_drvTbl_QBEVENT WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCOBQB','D40','dbo.U_EDISCOBQB_drvTbl_QBPLAN WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCOBQB','D50','dbo.U_EDISCOBQB_drvTbl_QBDEP WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCOBQB','D60','dbo.U_EDISCOBQB_drvTbl_QBDEPPLAN WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCOBQB','D70','dbo.U_EDISCOBQB_drvTbl_QBMSRI WITH (NOLOCK)',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EDISCOBQB
-----------

IF OBJECT_ID('U_dsi_BDM_EDISCOBQB') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EDISCOBQB] (
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
-- Create table U_EDISCOBQB_drvTbl_QB
-----------

IF OBJECT_ID('U_EDISCOBQB_drvTbl_QB') IS NULL
CREATE TABLE [dbo].[U_EDISCOBQB_drvTbl_QB] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NOT NULL,
    [drvClientName] varchar(100) NULL,
    [drvClientDivName] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvSSN] char(11) NULL,
    [drvEmpNo] char(9) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvGender] char(1) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(208) NULL
);

-----------
-- Create table U_EDISCOBQB_drvTbl_QBDEP
-----------

IF OBJECT_ID('U_EDISCOBQB_drvTbl_QBDEP') IS NULL
CREATE TABLE [dbo].[U_EDISCOBQB_drvTbl_QBDEP] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NULL,
    [drvSSN] char(11) NOT NULL,
    [drvRelationship] varchar(6) NOT NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvIsAddressSame] varchar(5) NOT NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvGender] char(1) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvISQMCO] varchar(5) NOT NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(102) NULL,
    [drvSubSort3] varchar(208) NULL
);

-----------
-- Create table U_EDISCOBQB_drvTbl_QBDEPPLAN
-----------

IF OBJECT_ID('U_EDISCOBQB_drvTbl_QBDEPPLAN') IS NULL
CREATE TABLE [dbo].[U_EDISCOBQB_drvTbl_QBDEPPLAN] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NULL,
    [drvDedCode] char(5) NULL,
    [drvPlanName] varchar(32) NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(107) NULL,
    [drvSubSort3] varchar(208) NULL
);

-----------
-- Create table U_EDISCOBQB_drvTbl_QBEVENT
-----------

IF OBJECT_ID('U_EDISCOBQB_drvTbl_QBEVENT') IS NULL
CREATE TABLE [dbo].[U_EDISCOBQB_drvTbl_QBEVENT] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NOT NULL,
    [drvEventType] varchar(29) NOT NULL,
    [drvEventDate] datetime NULL,
    [drvEnrollmentDate] datetime NULL,
    [drvSSN] char(11) NULL,
    [drvName] varchar(201) NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(208) NULL
);

-----------
-- Create table U_EDISCOBQB_drvTbl_QBMSRI
-----------

IF OBJECT_ID('U_EDISCOBQB_drvTbl_QBMSRI') IS NULL
CREATE TABLE [dbo].[U_EDISCOBQB_drvTbl_QBMSRI] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NOT NULL,
    [drvPlanName] varchar(32) NULL,
    [drvRate] money NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(208) NULL
);

-----------
-- Create table U_EDISCOBQB_drvTbl_QBPLAN
-----------

IF OBJECT_ID('U_EDISCOBQB_drvTbl_QBPLAN') IS NULL
CREATE TABLE [dbo].[U_EDISCOBQB_drvTbl_QBPLAN] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NOT NULL,
    [drvDedCode] char(5) NULL,
    [drvPlanName] varchar(32) NULL,
    [drvCoverageLevel] varchar(18) NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(6) NULL,
    [drvSubSort3] varchar(208) NULL
);

-----------
-- Create table U_EDISCOBQB_EEList
-----------

IF OBJECT_ID('U_EDISCOBQB_EEList') IS NULL
CREATE TABLE [dbo].[U_EDISCOBQB_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EDISCOBQB_File
-----------

IF OBJECT_ID('U_EDISCOBQB_File') IS NULL
CREATE TABLE [dbo].[U_EDISCOBQB_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EDISCOBQB]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name:  EDKEY, INC.

Created By: Dave Smith
Create Date: 10/27/2020
Service Request Number: 

Purpose: Discovery Benefits Cobra Export QB

Revision History
----------------
09/22/2021 by AP:
        - Added new plan name and modified the output for FSA.

09/29/2021 by AP:
        - Removed M224 and M220 plans.


SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EDISCOBQB';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EDISCOBQB';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EDISCOBQB';
SELECT * FROM dbo.AscExp WHERE expFormatCode = 'EDISCOBQB';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EDISCOBQB' ORDER BY RunID DESC;


select deddedcode, dedlongdesc, dedeeviewplandesc, * from dedcode where deddedtype in ('MED','DEN','VIS','FSA') order by deddedtype, 2


Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISCOBQB', 'ONDMDQBOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISCOBQB', 'SCHEDQB';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISCOBQB', 'TESTQBOE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EDISCOBQB';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EDISCOBQB', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SET @FormatCode = 'EDISCOBQB';

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
    DELETE FROM dbo.U_EDISCOBQB_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCoID(xEEID)
      AND xEEID IN (SELECT xEEID FROM dbo.U_EDISCOBQB_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- BDM Section for QB
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'TermSelectionOption','AuditDate');

    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');

    -- COBRA parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RunID','QB');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','Y'); -- DedIsCobraCovered = 'Y'
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'ConCobraReasonPCF','CobraTerminationReason'); 
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'ConDateOfCobraEventPCF','COBRAEventDate'); 
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraType','1'); 
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraDate','3'); 
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraPQBType','1'); -- If no EE or spouse, ALL children are PQB (not just oldest)
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidTermReasonsEmp','203'); -- Invalidate employee when Cobra Reason is "Death"
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CountDependents','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL,STC,CHC,DPC');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP');

    -- Run BDM for QB
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    ----------------------------------------------
    -- Invalidate dependent PQBs where cobra reason not valid
    ----------------------------------------------
    UPDATE dbo.U_dsi_BDM_DepDeductions
    SET  DbnValidForExport = 'N'
        ,DbnDedRowStatus   = 'EE not on file and ConCOBRAReason not valid'
    FROM dbo.EmpComp WITH (NOLOCK)
    WHERE EecEEID = DbnEEID
        AND EecCoID = DbnCoID
        AND ISNULL(EecTermReason,'') <> '203'
        AND DbnCobraReason NOT IN ('201','204','210','LEVNT3','LEVNT4')
        AND DbnFormatCode = @FormatCode
        AND DbnValidForExport = 'Y'
        AND DbnRunID = 'QB'
        AND NOT EXISTS(SELECT 1 FROM dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
                        WHERE EedEEID = DbnEEID
                        AND EedCoID = DbnCoID
                        AND EedDedCode = DbnDedCode
                        AND EedFormatCode = @FormatCode
                        AND EedValidForExport = 'Y'
                        AND EedRunID = 'QB');
                           
    -- Run BuildConsolidatedTable SP for QB run
    EXEC dbo.dsi_BDM_sp_BuildConsolidatedTable @FormatCode, 'Standard';

    --==========================================
    -- Build driver tables
    --==========================================
    -- E. Lee. 12/11/2017. If employee term reason is Death (203), and there's a spouse, make spouse the PQB.
    UPDATE Spouse
    SET BdmDedRowStatus = BdmDedRowStatus + ' orig ben opt: ' + BdmBenOption + ' changed due to deceased emp.', BdmIsPQB = 'Y', BdmNumSpouses = 0, BdmNumDomPartners = 0, BdmBenOption = (CASE WHEN BdmBenOption IN ('FAM','FAMW','EEDPF') THEN 'EECH' ELSE 'EE' END)
    FROM dbo.U_dsi_BDM_EDISCOBQB Spouse WITH (NOLOCK)
    WHERE BdmRelationship IN ('SPS') AND EXISTS(SELECT 1 FROM dbo.U_dsi_BDM_EDISCOBQB Emp WITH (NOLOCK)
        JOIN dbo.EmpComp WITH (NOLOCK) ON EecEEID = BdmEEID AND EecCoID = BdmCOID
        WHERE Emp.BdmEEID = Spouse.BdmEEID AND Emp.BdmRecType = 'EMP' AND EecTermReason = '203')

    -- Update their children's Ben Option to EECH.
    UPDATE Children
    SET BdmDedRowStatus = BdmDedRowStatus + ' orig ben opt: ' + BdmBenOption + ' changed due to deceased emp.', BdmNumSpouses = 0, BdmNumDomPartners = 0, BdmBenOption = 'EECH'
    FROM dbo.U_dsi_BDM_EDISCOBQB Children WITH (NOLOCK)
    WHERE BdmIsPQB = 'N' AND BdmRelationship IN ('CHL','STC') AND BdmBenOption IN ('FAM','FAMW','EEDPF')
        AND EXISTS(SELECT 1 FROM dbo.U_dsi_BDM_EDISCOBQB Emp WITH (NOLOCK)
        JOIN dbo.EmpComp WITH (NOLOCK) ON EecEEID = BdmEEID AND EecCoID = BdmCOID
        WHERE Emp.BdmEEID = Children.BdmEEID AND Emp.BdmRecType = 'EMP' AND EecTermReason = '203')

    -- If deceased employee only had children, make all children PQBs.
    UPDATE Children
    SET BdmDedRowStatus = BdmDedRowStatus + ' orig ben opt: ' + BdmBenOption + ' changed due to deceased emp.', BdmIsPQB = 'Y', BdmBenOption = 'EE'
    FROM dbo.U_dsi_BDM_EDISCOBQB Children WITH (NOLOCK)
    WHERE BdmRelationship IN ('CHL','STC') AND BdmBenOption IN ('EECH','EECHW') AND EXISTS(SELECT 1 FROM dbo.U_dsi_BDM_EDISCOBQB Emp WITH (NOLOCK)
        JOIN dbo.EmpComp WITH (NOLOCK) ON EecEEID = BdmEEID AND EecCoID = BdmCOID
        WHERE Emp.BdmEEID = Children.BdmEEID AND Emp.BdmRecType = 'EMP' AND EecTermReason = '203') AND BdmDedRowStatus NOT LIKE '%deceased emp%'

    -- Finally delete the employees with term reason 203.
    DELETE Emp
    FROM dbo.U_dsi_BDM_EDISCOBQB Emp WITH (NOLOCK)
    WHERE Emp.BdmRecType = 'EMP'
        AND EXISTS(SELECT 1 FROM dbo.EmpComp WITH (NOLOCK) WHERE EecEEID = BdmEEID AND EecCoID = BdmCOID AND EecTermReason = '203')

    ------------------
    -- QB DETAIL RECORD
    ------------------
    IF OBJECT_ID('U_EDISCOBQB_drvTbl_QB') IS NOT NULL
        DROP TABLE dbo.U_EDISCOBQB_drvTbl_QB;
    SELECT DISTINCT
            drvEEID           = BdmEEID
        ,drvCoID           = BdmCoID
        ,drvDepRecID       = ISNULL(BdmDepRecID,'')
        ,drvClientName     = CONVERT(varchar(100),'EdKey Inc 38148')
        ,drvClientDivName  = CONVERT(varchar(100),'EdKey Inc')
        ,drvNameFirst      = CASE WHEN BdmRecType = 'EMP' THEN EepNameFirst
                                    ELSE ConNameFirst
                                END
        ,drvNameMiddle     = CASE WHEN BdmRecType = 'EMP' THEN LEFT(EepNameMiddle,1)
                                    ELSE LEFT(ConNameMiddle,1)
                                END
        ,drvNameLast       = CASE WHEN BdmRecType = 'EMP' THEN EepNameLast
                                    ELSE ConNameLast
                                END
        ,drvSSN            = CASE WHEN BdmRecType = 'EMP' THEN eepSSN
                                    ELSE ISNULL(ConSSN,'')
                                END
        ,drvEmpNo          = EecEmpNo
        ,drvAddressLine1   = CASE WHEN BdmRecType = 'EMP' THEN EepAddressLine1
                                    WHEN ConAddressLine1 IS NULL THEN EepAddressLine1
                                    ELSE ConAddressLine1
                                END
        ,drvAddressLine2   = CASE WHEN BdmRecType = 'EMP' THEN EepAddressLine2
                                    WHEN ConAddressLine1 IS NULL THEN EepAddressLine2
                                    ELSE ConAddressLine2
                                END
        ,drvAddressCity    = CASE WHEN BdmRecType = 'EMP' THEN EepAddressCity
                                    WHEN ConAddressLine1 IS NULL THEN EepAddressCity
                                    ELSE ConAddressCity
                                END
        ,drvAddressState   = CASE WHEN BdmRecType = 'EMP' THEN EepAddressState
                                    WHEN ConAddressLine1 IS NULL THEN EepAddressState
                                    ELSE ConAddressState
                                END
        ,drvAddressZipCode = CASE WHEN BdmRecType = 'EMP' THEN EepAddressZipCode
                                    WHEN ConAddressLine1 IS NULL THEN EepAddressZipCode
                                    ELSE ConAddressZipCode
                                END
        ,drvGender         = CASE WHEN BdmRecType = 'EMP' THEN EepGender
                                    ELSE ConGender
                                END
        ,drvDateOfBirth    = CASE WHEN BdmRecType = 'EMP' THEN EepDateOfBirth
                                    ELSE ConDateOfBirth
                                END
        ,drvSubSort        = CASE WHEN BdmRecType = 'EMP' THEN eepSSN
                                    ELSE ISNULL(NULLIF(ConSSN,''),eepSSN) + CONVERT(char(8),ConDateOfBirth,112)
                                END
        ,drvSubSort2       = '1'
        ,drvSubSort3       = CASE WHEN BdmRecType = 'EMP' THEN '2'
                                    ELSE CONVERT(char(8),ConDateOfBirth,112) + RTRIM(ConNameLast) + ConNameFirst
                                END
    INTO dbo.U_EDISCOBQB_drvTbl_QB
    FROM dbo.U_dsi_BDM_EDISCOBQB WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = BdmEEID
        AND EecCoID = BdmCoID
    JOIN dbo.Company 
        ON CmpCoID = EecCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = BdmEEID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = BdmEEID
        AND ConSystemID = BdmDepRecID
    WHERE BdmIsPQB = 'Y';

    ------------------
    -- QBEVENT DETAIL RECORD
    ------------------
    IF OBJECT_ID('U_EDISCOBQB_drvTbl_QBEVENT') IS NOT NULL
        DROP TABLE dbo.U_EDISCOBQB_drvTbl_QBEVENT;
    SELECT DISTINCT
            drvEEID           = drvEEID
        ,drvCoID           = drvCoID
        ,drvDepRecID       = drvDepRecID
        ,drvEventType      = CASE WHEN EecTermReason = '105' THEN 'DIVORCELEGALSEPARATION'
                                    WHEN EecTermReason = '200' THEN 'TERMINATION'
                                    WHEN BdmCobraReason IN ('201') THEN 'INELIGIBLEDEPENDENT'
                                    WHEN BdmCobraReason IN ('202') THEN 'REDUCTIONINHOURS-STATUSCHANGE'
                                    WHEN BdmCobraReason = '203' THEN 'REDUCTIONINHOURS-STATUSCHANGE'
                                    WHEN BdmCobraReason IN ('204') THEN 'DIVORCELEGALSEPARATION'
                                    WHEN BdmCobraReason = '205' THEN 'MEDICARE'
                                    WHEN BdmCobraReason = '206' THEN 'REDUCTIONINHOURS-ENDOFLEAVE'
                                    WHEN BdmCobraReason = '208' THEN 'RETIREMENT'
                                    WHEN BdmCobraReason = '210' THEN 'DEATH'
                                    WHEN BdmCobraReason = '300' THEN 'DEATH'
                                    WHEN BdmCobraReason IN ('302') THEN 'INELIGIBLEDEPENDENT'
                                    WHEN BdmCobraReason IN ('LEVNT3') THEN 'INELIGIBLEDEPENDENT'
                                    ELSE 'TERMINATION'
                                END
        ,drvEventDate      = BdmDateOfCOBRAEvent
        ,drvEnrollmentDate = BdmBenStartDate
        ,drvSSN            = eepSSN
        ,drvName           = RTRIM(EepNameFirst) + ' ' + EepNameLast
        ,drvSubSort        = drvSubSort
        ,drvSubSort2       = '1'
        ,drvSubSort3       = drvSubSort3
    INTO dbo.U_EDISCOBQB_drvTbl_QBEVENT
    FROM dbo.U_EDISCOBQB_drvTbl_QB WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = drvEEID
        AND EecCoID = drvCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = drvEEID
    JOIN (SELECT
                BdmEEID
            ,BdmCoID
            ,BdmDepRecID
            ,BdmRecType
            ,BdmCobraReason = MAX(BdmCobraReason)
            ,BdmBenStartDate = MIN(BdmBenStartDate)
            ,BdmDateOfCOBRAEvent = MAX(BdmDateOfCOBRAEvent)
            ,BdmUSGDate1 = MAX(BdmUSGDate1)
            FROM dbo.U_dsi_BDM_EDISCOBQB WITH (NOLOCK)
            WHERE BdmIsPQB = 'Y'
            GROUP BY BdmEEID, BdmCoID, BdmDepRecID, BdmRecType) BDM
        ON BdmEEID = drvEEID
        AND BdmCoID = drvCoID
        AND ISNULL(BdmDepRecID,'') = drvDepRecID;

    ------------------
    -- QBPLANINITIAL DETAIL RECORD
    ------------------
    IF OBJECT_ID('U_EDISCOBQB_drvTbl_QBPLAN') IS NOT NULL
        DROP TABLE dbo.U_EDISCOBQB_drvTbl_QBPLAN;
    SELECT DISTINCT
            drvEEID          = drvEEID
        ,drvCoID          = drvCoID
        ,drvDepRecID      = drvDepRecID
        ,drvDedCode       = BdmDedCode
        ,drvPlanName      = CASE
                                WHEN BdmDedCode IN ('M124','M120') AND YEAR(BdmDateOfCOBRAEvent) <= 2020 THEN 'BCBS AZ Medical 19/20 Plan 1'
                             --   WHEN BdmDedCode IN ('M224','M220') AND YEAR(BdmDateOfCOBRAEvent) <= 2020 THEN 'BCBS AZ Medical 19/20 Plan 2'
                                WHEN BdmDedCode IN ('M324','M320') AND YEAR(BdmDateOfCOBRAEvent) <= 2020 THEN 'BCBS AZ Medical 19/20 Plan 3'
                                WHEN BdmDedCode IN ('DH24','DH20') AND YEAR(BdmDateOfCOBRAEvent) <= 2020 THEN 'Cigna Dental 19/20 DHMO'
                                WHEN BdmDedCode IN ('DP24','DP20') AND YEAR(BdmDateOfCOBRAEvent) <= 2020 THEN 'Cigna Dental 19/20 PPO'
                                WHEN BdmDedCode IN ('VIS24','VIS20') AND YEAR(BdmDateOfCOBRAEvent) <= 2020 THEN 'Premier Access Vision 19/20'

                                WHEN BdmDedCode IN ('M124','M120') THEN 'BCBS AZ Medical PPO 2500 Plan 1'
                                WHEN BdmDedCode IN ('M224','M220') THEN 'BCBS AZ Medical PPO 1500 Plan 2'
                                WHEN BdmDedCode IN ('M324','M320') THEN 'BCBS AZ Medical HSA 2800 Plan 3'
                                WHEN BdmDedCode IN ('DH24','DH20','D124','D120') THEN 'Cigna Dental DHMO'
                                WHEN BdmDedCode IN ('DP24','DP20','D224','D220') THEN 'Cigna Dental DPPO'
                                WHEN BdmDedCode IN ('VIS24','VIS20') THEN 'Premier Access Vision'
                                WHEN BdmDedCode IN ('FSA') THEN 'Wex FSA' -- changed on 09/22/21
                                WHEN BdmDedCode IN ('M420', 'M424') THEN 'BCBS AZ Med Alliance 5000 Plan 2' -- new plan added 09/22/21
                               -- WHEN BdmDedCode IN ('FSA') THEN 'DBI FSA'
                                ELSE BdmDedCode
                            END
        ,drvCoverageLevel = CASE WHEN BdmDedType = 'FSA' THEN 'EE'
                                    WHEN BdmRecType = 'EMP' AND BdmDedType = 'MED' THEN
                                        CASE WHEN BdmBenOption IN ('EE') THEN 'EE'
                                            WHEN BdmBenOption IN ('EEC') THEN 'EE+CHILD'--(CASE WHEN ISNULL(BdmNumChildren,0) + ISNULL(BdmNumDPChildren,0) = 1 THEN 'EE+CHILD' ELSE 'EE+CHILDREN' END)
                                            WHEN BdmBenOption IN ('EECHRN') THEN 'EE+CHILDREN'--(CASE WHEN ISNULL(BdmNumChildren,0) + ISNULL(BdmNumDPChildren,0) = 1 THEN 'EE+CHILD' ELSE 'EE+CHILDREN' END)
                                            WHEN BdmBenOption IN ('EES','EEDP') THEN (CASE WHEN ISNULL(BdmNumDomPartners,0) = 1 THEN 'EE+DOMESTICPARTNER' ELSE 'EE+SPOUSE' END)
                                            WHEN BdmBenOption IN ('EEF','EEDPF') THEN 'EE+FAMILY'
                                        END
                                    WHEN BdmRecType = 'EMP' AND BdmDedType = 'DEN' THEN
                                        CASE WHEN BdmBenOption IN ('EE') THEN 'EE'
                                            WHEN BdmBenOption IN ('EEC','EECHRN') THEN 'EE+CHILDREN'--(CASE WHEN ISNULL(BdmNumChildren,0) + ISNULL(BdmNumDPChildren,0) = 1 THEN 'EE+CHILD' ELSE 'EE+CHILDREN' END)
                                            WHEN BdmBenOption IN ('EES','EEDP') THEN (CASE WHEN ISNULL(BdmNumDomPartners,0) = 1 THEN 'EE+DOMESTICPARTNER' ELSE 'EE+SPOUSE' END)
                                            WHEN BdmBenOption IN ('EEF','EEDPF') THEN 'EE+FAMILY'
                                        END
                                    WHEN BdmRecType = 'EMP' AND BdmDedType = 'VIS' THEN
                                        CASE WHEN BdmBenOption IN ('EE') THEN 'EE'
                                            WHEN BdmBenOption IN ('EEC','EECHRN') THEN 'EE+CHILDREN'--(CASE WHEN ISNULL(BdmNumChildren,0) + ISNULL(BdmNumDPChildren,0) = 1 THEN 'EE+CHILD' ELSE 'EE+CHILDREN' END)
                                            ELSE 'EE+FAMILY'
                                        END
                                    WHEN BdmRelationship IN ('SPS') THEN
                                        CASE WHEN BdmBenOption IN ('EEC','EECHRN') THEN 'EE+CHILDREN'--(CASE WHEN ISNULL(BdmNumChildren,0) + ISNULL(BdmNumDPChildren,0) = 1 THEN 'EE+CHILD' ELSE 'EE+CHILDREN' END)
                                            ELSE 'EE'
                                        END
                                    ELSE 'EE'
                            END
        ,drvSubSort       = drvSubSort
        ,drvSubSort2      = '1' + BdmDedCode
        ,drvSubSort3      = drvSubSort3
    INTO dbo.U_EDISCOBQB_drvTbl_QBPLAN
    FROM dbo.U_EDISCOBQB_drvTbl_QBEVENT WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EDISCOBQB WITH (NOLOCK)
        ON BdmEEID = drvEEID
        AND BdmCoID = drvCoID
        AND ISNULL(BdmDepRecID,'') = drvDepRecID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = drvEEID
    JOIN dbo.Company WITH (NOLOCK)
        ON BdmCoID = CmpCoID
    WHERE BdmIsPQB = 'Y';

    ------------------
    -- QBDEPENDENT DETAIL RECORD
    ------------------
    IF OBJECT_ID('U_EDISCOBQB_drvTbl_QBDEP') IS NOT NULL
        DROP TABLE dbo.U_EDISCOBQB_drvTbl_QBDEP;
    SELECT DISTINCT
            drvEEID           = BdmEEID
        ,drvCoID           = BdmCoID
        ,drvDepRecID       = BdmDepRecID
        ,drvSSN            = ISNULL(ConSSN,'')
        ,drvRelationship   = CASE WHEN BdmRelationship IN ('SPS') THEN 'SPOUSE'
                                    ELSE 'CHILD'
                                END
        ,drvNameFirst      = ConNameFirst
        ,drvNameMiddle     = LEFT(ConNameMiddle,1)
        ,drvNameLast       = ConNameLast
        ,drvIsAddressSame  = CASE WHEN ConAddressIsDifferent = 'N' OR ConAddressLine1 IS NULL THEN 'TRUE'
                                    ELSE 'FALSE'
                                END
        ,drvAddressLine1   = ConAddressLine1
        ,drvAddressLine2   = ConAddressLine2
        ,drvAddressCity    = ConAddressCity
        ,drvAddressState   = ConAddressState
        ,drvAddressZipCode = ConAddressZipCode
        ,drvGender         = ConGender
        ,drvDateOfBirth    = ConDateOfBirth
        ,drvISQMCO         = CASE WHEN BdmRelationship IN ('COD') THEN 'TRUE'
                                    ELSE 'FALSE'
                                END
        ,drvSubSort        = drvSubSort
        ,drvSubSort2       = '2' + CASE WHEN BdmRelationship IN ('SPS') THEN 'A'
                                        ELSE 'B' + RTRIM(IIF(ISNULL(ConSSN,'000000000') IN ('000000000','999999999'),ConNameFirst,ConSSN))
                                    END
        ,drvSubSort3       = drvSubSort3
    INTO dbo.U_EDISCOBQB_drvTbl_QBDEP
    FROM dbo.U_EDISCOBQB_drvTbl_QB WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EDISCOBQB WITH (NOLOCK)
        ON BdmEEID = drvEEID
        AND BdmCoID = drvCoID
    JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = BdmEEID
        AND ConSystemID = BdmDepRecID
    WHERE BdmIsPQB = 'N';

    ------------------
    -- QBDEPENDENTPLANINITIAL DETAIL RECORD
    ------------------
    IF OBJECT_ID('U_EDISCOBQB_drvTbl_QBDEPPLAN') IS NOT NULL
        DROP TABLE dbo.U_EDISCOBQB_drvTbl_QBDEPPLAN;
    SELECT DISTINCT
            drvEEID     = BdmEEID
        ,drvCoID     = BdmCoID
        ,drvDepRecID = BdmDepRecID
        ,drvDedCode  = BdmDedCode
        ,drvPlanName = drvPlanName
        ,drvSubSort  = drvSubSort
        ,drvSubSort2 = '2' + CASE WHEN BdmRelationship IN ('SPS') THEN 'A'
                                    ELSE 'B' + RTRIM(IIF(ISNULL(ConSSN,'000000000') IN ('000000000','999999999'),ConNameFirst,ConSSN))
                                END + BdmDedCode
        ,drvSubSort3 = drvSubSort3
    INTO dbo.U_EDISCOBQB_drvTbl_QBDEPPLAN
    FROM dbo.U_EDISCOBQB_drvTbl_QBPLAN WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EDISCOBQB WITH (NOLOCK)
        ON BdmEEID = drvEEID
        AND BdmCoID = drvCoID
        AND BdmDedCode = drvDedCode
    JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = BdmEEID
        AND ConSystemID = BdmDepRecID
    WHERE BdmIsPQB = 'N';

    ------------------
    -- QBPLANMEMBERSPECIFICRATEINITIAL DETAIL RECORD
    ------------------
    IF OBJECT_ID('U_EDISCOBQB_drvTbl_QBMSRI') IS NOT NULL
        DROP TABLE dbo.U_EDISCOBQB_drvTbl_QBMSRI;
    SELECT DISTINCT
            drvEEID     = drvEEID
        ,drvCoID     = drvCoID
        ,drvDepRecID = drvDepRecID
        ,drvPlanName = drvPlanName
        ,drvRate     = CASE WHEN EecPayPeriod = 'M' THEN BdmEEAmt
                            WHEN EecPayPeriod = 'S' THEN BdmEEAmt * 2
                            WHEN EecPayPeriod = 'B' THEN BdmEEAmt * 24/12
                            WHEN EecPayPeriod = 'W' THEN BdmEEAmt * 52/12
                        END
        ,drvSubSort  = drvSubSort
        ,drvSubSort2 = '3'
        ,drvSubSort3 = drvSubSort3
    INTO dbo.U_EDISCOBQB_drvTbl_QBMSRI
    FROM dbo.U_EDISCOBQB_drvTbl_QBPLAN WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EDISCOBQB WITH (NOLOCK)
        ON BdmEEID = drvEEID
        AND BdmCoID = drvCoID
        AND ISNULL(BdmDepRecID,'') = drvDepRecID
        AND BdmDedCode = drvDedCode
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = BdmEEID
        AND EecCoID = BdmCoID
    WHERE BdmIsPQB = 'Y'
        AND BdmDedType = 'FSA';

    --==========================================
    -- Set filename
    --==========================================
    IF (dbo.dsi_fnVariable('EDISCOBQB','UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
        SET ExportFile = CASE 
                              WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' AND @ExportCode LIKE '%QB%' THEN '_TEST_' + CONVERT(char(8),GETDATE(),112) + '_EDKEY_QB_38148.txt'--_' + REPLACE(CONVERT(VARCHAR,GETDATE(),108),':','') + '
                              WHEN @ExportCode = 'TESTQBOE' THEN '_TEST_' + CONVERT(char(8),GETDATE(),112) + '_EDKEY_QB_38148.txt'--_' + REPLACE(CONVERT(VARCHAR,GETDATE(),108),':','') + '
                              WHEN @ExportCode IN ('ONDMDQBOE','SCHEDQB') THEN CONVERT(char(8),GETDATE(),112) + '_EDKEY_QB_38148.txt'--_' + REPLACE(CONVERT(VARCHAR,GETDATE(),108),':','') + '
                         END
        WHERE FormatCode = @FormatCode;
    END
END;
/*
--Alter the View
ALTER VIEW dbo.dsi_vwEDISCOBQB_Export AS
    SELECT TOP 2000000 Data
    FROM dbo.U_EDISCOBQB_File WITH (NOLOCK)
    ORDER BY InitialSort, SubSort, SubSort2, SubSort3, RecordSet;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EDISCOBQB%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
SET expLastStartPerControl = '202101011'
   ,expStartPerControl     = '202101011'
   ,expLastEndPerControl   = '202102289'
   ,expEndPerControl       = '202102289'
WHERE expFormatCode = 'EDISCOBQB'
  AND expExportCode LIKE 'TEST%';
*/
SET NOCOUNT OFF;
GO
CREATE VIEW dbo.dsi_vwEDISCOBQB_Export AS
    SELECT TOP 2000000 Data
    FROM dbo.U_EDISCOBQB_File WITH (NOLOCK)
    ORDER BY InitialSort, SubSort, SubSort2, SubSort3, RecordSet;

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EDISCOBQB' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EDISCOBQB'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EDISCOBQB'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EDISCOBQB', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EDISCOBQB', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EDISCOBQB', 'UseFileName', 'V', 'Y'


-- End ripout