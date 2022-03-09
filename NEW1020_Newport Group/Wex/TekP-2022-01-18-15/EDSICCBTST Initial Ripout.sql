/**********************************************************************************


>>>>>> NOTE: this ripout is cloned from EDSICCBEXP


EDSICCBTST: Discovery Benefits Cobra Export

FormatCode:     EDSICCBTST
Project:        Discovery Benefits Cobra Export
Client ID:      NEW1020
Date/time:      2022-03-06 09:24:01.160
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW2WUP1DB02
Database:       ULTIPRO_WPNEWG
Web Filename:   NEW1020_CC960_EEHISTORY_EDSICCBTST_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EDSICCBTST_SavePath') IS NOT NULL DROP TABLE dbo.U_EDSICCBTST_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EDSICCBTST'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EDSICCBTST')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EDSICCBTST'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EDSICCBTST'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EDSICCBTST'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EDSICCBTST'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EDSICCBTST'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EDSICCBTST'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EDSICCBTST'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EDSICCBTST'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EDSICCBTST'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEDSICCBTST_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEDSICCBTST_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EDSICCBTST') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EDSICCBTST];
GO
IF OBJECT_ID('U_EDSICCBTST_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EDSICCBTST_PEarHist];
GO
IF OBJECT_ID('U_EDSICCBTST_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EDSICCBTST_PDedHist];
GO
IF OBJECT_ID('U_EDSICCBTST_File') IS NOT NULL DROP TABLE [dbo].[U_EDSICCBTST_File];
GO
IF OBJECT_ID('U_EDSICCBTST_EEList') IS NOT NULL DROP TABLE [dbo].[U_EDSICCBTST_EEList];
GO
IF OBJECT_ID('U_EDSICCBTST_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL') IS NOT NULL DROP TABLE [dbo].[U_EDSICCBTST_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL];
GO
IF OBJECT_ID('U_EDSICCBTST_drvTbl_QBPLANINITIAL') IS NOT NULL DROP TABLE [dbo].[U_EDSICCBTST_drvTbl_QBPLANINITIAL];
GO
IF OBJECT_ID('U_EDSICCBTST_drvTbl_QBPLAN2') IS NOT NULL DROP TABLE [dbo].[U_EDSICCBTST_drvTbl_QBPLAN2];
GO
IF OBJECT_ID('U_EDSICCBTST_drvTbl_QBPLAN') IS NOT NULL DROP TABLE [dbo].[U_EDSICCBTST_drvTbl_QBPLAN];
GO
IF OBJECT_ID('U_EDSICCBTST_drvTbl_QBMSRI') IS NOT NULL DROP TABLE [dbo].[U_EDSICCBTST_drvTbl_QBMSRI];
GO
IF OBJECT_ID('U_EDSICCBTST_drvTbl_QBEVENT') IS NOT NULL DROP TABLE [dbo].[U_EDSICCBTST_drvTbl_QBEVENT];
GO
IF OBJECT_ID('U_EDSICCBTST_drvTbl_QBDEPPLAN') IS NOT NULL DROP TABLE [dbo].[U_EDSICCBTST_drvTbl_QBDEPPLAN];
GO
IF OBJECT_ID('U_EDSICCBTST_drvTbl_QBDEPENDENTPLANINITIAL') IS NOT NULL DROP TABLE [dbo].[U_EDSICCBTST_drvTbl_QBDEPENDENTPLANINITIAL];
GO
IF OBJECT_ID('U_EDSICCBTST_drvTbl_QBDEPENDENT') IS NOT NULL DROP TABLE [dbo].[U_EDSICCBTST_drvTbl_QBDEPENDENT];
GO
IF OBJECT_ID('U_EDSICCBTST_drvTbl_QBDEP') IS NOT NULL DROP TABLE [dbo].[U_EDSICCBTST_drvTbl_QBDEP];
GO
IF OBJECT_ID('U_EDSICCBTST_drvTbl_QB') IS NOT NULL DROP TABLE [dbo].[U_EDSICCBTST_drvTbl_QB];
GO
IF OBJECT_ID('U_EDSICCBTST_drvTbl_NPM') IS NOT NULL DROP TABLE [dbo].[U_EDSICCBTST_drvTbl_NPM];
GO
IF OBJECT_ID('U_EDSICCBTST_DedList') IS NOT NULL DROP TABLE [dbo].[U_EDSICCBTST_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EDSICCBTST') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EDSICCBTST];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EDSICCBTST','Discovery Benefits Cobra Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','E6M7G1000030','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','E6M7G1000030','50','H','01','1',NULL,'Version Line Identifier',NULL,NULL,'"[VERSION]"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','E6M7G1000030','50','H','01','2',NULL,'Version Number',NULL,NULL,'"1.1"','(''DA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','E6M7G1000030','50','D','10','1',NULL,'Record Identifier',NULL,NULL,'"[QB]"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','E6M7G1000030','100','D','10','2',NULL,'ClientName',NULL,NULL,'"drvClientName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','E6M7G1000030','50','D','10','3',NULL,'ClientDivisionName',NULL,NULL,'"drvClientDivName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','E6M7G1000030','50','D','10','4',NULL,'Salutation',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','E6M7G1000030','50','D','10','5',NULL,'FirstName',NULL,NULL,'"drvNameFirst"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','E6M7G1000030','50','D','10','6',NULL,'MiddleInitial',NULL,NULL,'"drvNameMiddle"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','E6M7G1000030','50','D','10','7',NULL,'LastName',NULL,NULL,'"drvNameLast"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','E6M7G1000030','50','D','10','8',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','E6M7G1000030','50','D','10','9',NULL,'IndividualID',NULL,NULL,'"drvEmpNo"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','E6M7G1000030','50','D','10','10',NULL,'Email',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','E6M7G1000030','50','D','10','11',NULL,'Phone',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','E6M7G1000030','50','D','10','12',NULL,'Phone2',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','E6M7G1000030','50','D','10','13',NULL,'Address1',NULL,NULL,'"drvAddressLine1"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','E6M7G1000030','50','D','10','14',NULL,'Address2',NULL,NULL,'"drvAddressLine2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','E6M7G1000030','50','D','10','15',NULL,'City',NULL,NULL,'"drvAddressCity"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','E6M7G1000030','50','D','10','16',NULL,'StateOrProvince',NULL,NULL,'"drvAddressState"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','E6M7G1000030','50','D','10','17',NULL,'PostalCode',NULL,NULL,'"drvAddressZipCode"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','E6M7G1000030','50','D','10','18',NULL,'Country',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','E6M7G1000030','50','D','10','19',NULL,'PremiumAddressSameAsPrimary',NULL,NULL,'"TRUE"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','E6M7G1000030','50','D','10','20',NULL,'PremiumAddress1',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','E6M7G1000030','50','D','10','21',NULL,'PremiumAddress2',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','E6M7G1000030','50','D','10','22',NULL,'PremiumCity',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','E6M7G1000030','50','D','10','23',NULL,'PremiumStateOrProvince',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','E6M7G1000030','50','D','10','24',NULL,'PremiumPostalCode',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','E6M7G1000030','50','D','10','25',NULL,'PremiumCountry',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','E6M7G1000030','50','D','10','26',NULL,'Sex',NULL,NULL,'"drvGender"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','E6M7G1000030','50','D','10','27',NULL,'DOB',NULL,NULL,'"drvDateOfBirth"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','E6M7G1000030','50','D','10','28',NULL,'Tobacco Use',NULL,NULL,'"drvTobacoUse"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','E6M7G1000030','50','D','10','29',NULL,'EmployeeType',NULL,NULL,'"UNKNOWN"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','E6M7G1000030','50','D','10','30',NULL,'EmployeePayrollType',NULL,NULL,'"drvEmpPayrollType"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','E6M7G1000030','50','D','10','31',NULL,'YearsOfService',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','E6M7G1000030','50','D','10','32',NULL,'PremiumCouponType',NULL,NULL,'"COUPONBOOK"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','E6M7G1000030','50','D','10','33',NULL,'UsesHCTC',NULL,NULL,'"FALSE"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','E6M7G1000030','50','D','10','34',NULL,'Active',NULL,NULL,'"TRUE"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','E6M7G1000030','50','D','10','35',NULL,'AllowMemberSSO',NULL,NULL,'"FALSE"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','E6M7G1000030','50','D','10','36',NULL,'BenefitGroup',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','E6M7G1000030','50','D','10','37',NULL,'AccountStructure',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','E6M7G1000030','50','D','10','38',NULL,'ClientSpecificData',NULL,NULL,'""','(''SS''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','E6M7G1000030','50','D','20','1',NULL,'Record Identifier',NULL,NULL,'"[QBEVENT]"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','E6M7G1000030','50','D','20','2',NULL,'EventType',NULL,NULL,'"drvEventType"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','E6M7G1000030','50','D','20','3',NULL,'EventDate',NULL,NULL,'"drvEventDate"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','E6M7G1000030','50','D','20','4',NULL,'EnrollmentDate',NULL,NULL,'"drvEnrollmentDate"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','E6M7G1000030','50','D','20','5',NULL,'EmployeeSSN',NULL,NULL,'"drvSSN"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','E6M7G1000030','50','D','20','6',NULL,'EmployeeName',NULL,NULL,'"drvName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','E6M7G1000030','50','D','20','7',NULL,'SecondEventOriginalFDOC',NULL,NULL,'""','(''SS''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','E6M7G1000030','50','D','30','1',NULL,'Record Identifier',NULL,NULL,'"[QBPLANINITIAL]"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','E6M7G1000030','50','D','30','2',NULL,'PlanName',NULL,NULL,'"drvPlanName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','E6M7G1000030','50','D','30','3',NULL,'CoverageLevel',NULL,NULL,'"drvCoverageLevel"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','E6M7G1000030','50','D','30','4',NULL,'NumberOfUnits',NULL,NULL,'""','(''SS''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','E6M7G1000030','50','D','40','1',NULL,'Record Identifier',NULL,NULL,'"[QBDEPENDENT]"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','E6M7G1000030','50','D','40','2',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','E6M7G1000030','50','D','40','3',NULL,'Relationship',NULL,NULL,'"drvRelationship"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','E6M7G1000030','50','D','40','4',NULL,'Salutation',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','E6M7G1000030','50','D','40','5',NULL,'FirstName',NULL,NULL,'"drvNameFirst"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','E6M7G1000030','50','D','40','6',NULL,'MiddleInitial',NULL,NULL,'"drvNameMiddle"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','E6M7G1000030','50','D','40','7',NULL,'LastName',NULL,NULL,'"drvNameLast"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','E6M7G1000030','50','D','40','8',NULL,'Email',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','E6M7G1000030','50','D','40','9',NULL,'Phone',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','E6M7G1000030','50','D','40','10',NULL,'Phone2',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','E6M7G1000030','50','D','40','11',NULL,'AddressSameAsQB',NULL,NULL,'"drvIsAddressSame"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','E6M7G1000030','50','D','40','12',NULL,'Address1',NULL,NULL,'"drvAddressLine1"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','E6M7G1000030','50','D','40','13',NULL,'Address2',NULL,NULL,'"drvAddressLine2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','E6M7G1000030','50','D','40','14',NULL,'City',NULL,NULL,'"drvAddressCity"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','E6M7G1000030','50','D','40','15',NULL,'StateOrProvince',NULL,NULL,'"drvAddressState"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','E6M7G1000030','50','D','40','16',NULL,'PostalCode',NULL,NULL,'"drvAddressZipCode"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','E6M7G1000030','50','D','40','17',NULL,'Country',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','E6M7G1000030','50','D','40','18',NULL,'EnrollmentDate',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','E6M7G1000030','50','D','40','19',NULL,'Sex',NULL,NULL,'"drvGender"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','E6M7G1000030','50','D','40','20',NULL,'DOB',NULL,NULL,'"drvDateOfBirth"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','E6M7G1000030','50','D','40','21',NULL,'IsQMCSO',NULL,NULL,'"drvISQMCO"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','E6M7G1000030','50','D','50','1',NULL,'Record Identifier',NULL,NULL,'"[QBDEPENDENTPLANINITIAL]"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','E6M7G1000030','50','D','50','2',NULL,'PlanName',NULL,NULL,'"drvPlanName"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','E6M7G1000030','50','D','60','1',NULL,'Record Identifier',NULL,NULL,'"[QBPLANMEMBERSPECIFICRATEINITIAL]"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','E6M7G1000030','50','D','60','2',NULL,'PlanName',NULL,NULL,'"drvPlanName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','E6M7G1000030','50','D','60','3',NULL,'Rate',NULL,NULL,'"drvRate"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','E6M7G1000030','50','D','70','1',NULL,'Version Line Identifier',NULL,NULL,'"[NPM]"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','E6M7G1000030','50','D','70','2',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','E6M7G1000030','50','D','70','3',NULL,'IndividualIdentifier',NULL,NULL,'"drvEmpNo"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','E6M7G1000030','100','D','70','4',NULL,'ClientName',NULL,NULL,'"drvClientName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','E6M7G1000030','50','D','70','5',NULL,'ClientDivisionName',NULL,NULL,'"drvClientDivName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','E6M7G1000030','50','D','70','6',NULL,'FirstName',NULL,NULL,'"drvNameFirst"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','E6M7G1000030','50','D','70','7',NULL,'MiddleInitial',NULL,NULL,'"drvNameMiddle"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','E6M7G1000030','50','D','70','8',NULL,'LastName',NULL,NULL,'"drvNameLast"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','E6M7G1000030','50','D','70','9',NULL,'Salutation',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','E6M7G1000030','50','D','70','10',NULL,'Email',NULL,NULL,'"drvAddressEMail"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','E6M7G1000030','50','D','70','11',NULL,'Phone',NULL,NULL,'"drvPhoneHomeNumber"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','E6M7G1000030','50','D','70','12',NULL,'Phone2',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','E6M7G1000030','50','D','70','13',NULL,'Address1',NULL,NULL,'"drvAddressLine1"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','E6M7G1000030','50','D','70','14',NULL,'Address2',NULL,NULL,'"drvAddressLine2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','E6M7G1000030','50','D','70','15',NULL,'City',NULL,NULL,'"drvAddressCity"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','E6M7G1000030','50','D','70','16',NULL,'StateOrProvince',NULL,NULL,'"drvAddressState"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','E6M7G1000030','50','D','70','17',NULL,'PostalCode',NULL,NULL,'"drvAddressZipCode"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','E6M7G1000030','50','D','70','18',NULL,'Country',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','E6M7G1000030','50','D','70','19',NULL,'Sex',NULL,NULL,'"drvGender"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','E6M7G1000030','50','D','70','20',NULL,'UsesFamilyInAddress',NULL,NULL,'"TRUE"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','E6M7G1000030','50','D','70','21',NULL,'HasWaivedAllCoverage',NULL,NULL,'"FALSE"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','E6M7G1000030','50','D','70','22',NULL,'SendGRNotice',NULL,NULL,'"TRUE"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','E6M7G1000030','50','D','70','23',NULL,'Hire Date',NULL,NULL,'"drvHireDate"','(''UD101''=''Q'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EDSICCBTST_20220306.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'On Demand','202011309','EMPEXPORT','ONDEMAND','Mar 23 2021 12:00AM','EDSICCBTST',NULL,NULL,NULL,'202011309','Nov 30 2020 12:00AM','Dec 30 1899 12:00AM','201901011',NULL,NULL,NULL,'201901011',dbo.fn_GetTimedKey(),NULL,'us3mLaNEW1020',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N',NULL,NULL,NULL,NULL,'Schedule Session','202007109','EMPEXPORT','SCH_DISC','Jul 15 2020 12:00AM','EDSICCBTST',NULL,NULL,NULL,'202203029','Jul 10 2020 12:00AM','Dec 30 1899 12:00AM','202202231',NULL,NULL,NULL,'202007031',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Test /Cobra Export','202202181','EMPEXPORT','TEST','Feb 18 2022 12:26PM','EDSICCBTST',NULL,NULL,NULL,'202202181','Feb 18 2022 12:00AM','Dec 30 1899 12:00AM','202202011','160',NULL,NULL,'202202011',dbo.fn_GetTimedKey(),NULL,'us3cPeNEW1020',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDSICCBTST','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDSICCBTST','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDSICCBTST','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDSICCBTST','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDSICCBTST','SubSort2','C','drvSubSort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDSICCBTST','SubSort3','C','drvSubSort3');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDSICCBTST','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDSICCBTST','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDSICCBTST','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDSICCBTST','D10','dbo.U_EDSICCBTST_drvTbl_QB WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDSICCBTST','D20','dbo.U_EDSICCBTST_drvTbl_QBEVENT WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDSICCBTST','D30','dbo.U_EDSICCBTST_drvTbl_QBPLAN WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDSICCBTST','D40','dbo.U_EDSICCBTST_drvTbl_QBDEP WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDSICCBTST','D50','dbo.U_EDSICCBTST_drvTbl_QBDEPPLAN WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDSICCBTST','D60','dbo.U_EDSICCBTST_drvTbl_QBMSRI WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDSICCBTST','D70','dbo.U_EDSICCBTST_drvTbl_NPM WITH (NOLOCK)',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EDSICCBTST
-----------

IF OBJECT_ID('U_dsi_BDM_EDSICCBTST') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EDSICCBTST] (
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
-- Create table U_EDSICCBTST_DedList
-----------

IF OBJECT_ID('U_EDSICCBTST_DedList') IS NULL
CREATE TABLE [dbo].[U_EDSICCBTST_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EDSICCBTST_drvTbl_NPM
-----------

IF OBJECT_ID('U_EDSICCBTST_drvTbl_NPM') IS NULL
CREATE TABLE [dbo].[U_EDSICCBTST_drvTbl_NPM] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvSSN] char(11) NULL,
    [drvEmpNo] varchar(1) NOT NULL,
    [drvClientName] varchar(100) NULL,
    [drvClientDivName] varchar(16) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvAddressEMail] varchar(1) NOT NULL,
    [drvPhoneHomeNumber] varchar(1) NOT NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvGender] varchar(1) NULL,
    [drvHireDate] datetime NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] char(11) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(1) NOT NULL
);

-----------
-- Create table U_EDSICCBTST_drvTbl_QB
-----------

IF OBJECT_ID('U_EDSICCBTST_drvTbl_QB') IS NULL
CREATE TABLE [dbo].[U_EDSICCBTST_drvTbl_QB] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NOT NULL,
    [drvClientName] varchar(100) NULL,
    [drvClientDivName] varchar(16) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvSSN] char(11) NULL,
    [drvEmpNo] varchar(1) NOT NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvGender] char(1) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvTobacoUse] varchar(7) NOT NULL,
    [drvEmpPayrollType] varchar(7) NOT NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(208) NULL
);

-----------
-- Create table U_EDSICCBTST_drvTbl_QBDEP
-----------

IF OBJECT_ID('U_EDSICCBTST_drvTbl_QBDEP') IS NULL
CREATE TABLE [dbo].[U_EDSICCBTST_drvTbl_QBDEP] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NULL,
    [drvSSN] char(11) NOT NULL,
    [drvRelationship] varchar(15) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvIsAddressSame] varchar(5) NOT NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvGender] varchar(1) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvISQMCO] varchar(5) NOT NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(33) NULL,
    [drvSubSort3] varchar(208) NULL
);

-----------
-- Create table U_EDSICCBTST_drvTbl_QBDEPENDENT
-----------

IF OBJECT_ID('U_EDSICCBTST_drvTbl_QBDEPENDENT') IS NULL
CREATE TABLE [dbo].[U_EDSICCBTST_drvTbl_QBDEPENDENT] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(31) NULL,
    [drvSSN] char(11) NULL,
    [drvRelationship] varchar(15) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(102) NULL,
    [drvAddressSameAsQB] varchar(5) NOT NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvSex] varchar(1) NULL,
    [drvDateOfBirth] datetime NULL
);

-----------
-- Create table U_EDSICCBTST_drvTbl_QBDEPENDENTPLANINITIAL
-----------

IF OBJECT_ID('U_EDSICCBTST_drvTbl_QBDEPENDENTPLANINITIAL') IS NULL
CREATE TABLE [dbo].[U_EDSICCBTST_drvTbl_QBDEPENDENTPLANINITIAL] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(31) NULL,
    [drvPlanName] varchar(32) NULL
);

-----------
-- Create table U_EDSICCBTST_drvTbl_QBDEPPLAN
-----------

IF OBJECT_ID('U_EDSICCBTST_drvTbl_QBDEPPLAN') IS NULL
CREATE TABLE [dbo].[U_EDSICCBTST_drvTbl_QBDEPPLAN] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NULL,
    [drvDedCode] char(5) NULL,
    [drvPlanName] varchar(50) NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(38) NULL,
    [drvSubSort3] varchar(208) NULL
);

-----------
-- Create table U_EDSICCBTST_drvTbl_QBEVENT
-----------

IF OBJECT_ID('U_EDSICCBTST_drvTbl_QBEVENT') IS NULL
CREATE TABLE [dbo].[U_EDSICCBTST_drvTbl_QBEVENT] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NOT NULL,
    [drvEventType] varchar(30) NOT NULL,
    [drvEventDate] datetime NULL,
    [drvEnrollmentDate] datetime NULL,
    [drvSSN] char(11) NULL,
    [drvName] varchar(201) NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(208) NULL
);

-----------
-- Create table U_EDSICCBTST_drvTbl_QBMSRI
-----------

IF OBJECT_ID('U_EDSICCBTST_drvTbl_QBMSRI') IS NULL
CREATE TABLE [dbo].[U_EDSICCBTST_drvTbl_QBMSRI] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NOT NULL,
    [drvPlanName] varchar(50) NULL,
    [drvRate] nvarchar(4000) NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(208) NULL
);

-----------
-- Create table U_EDSICCBTST_drvTbl_QBPLAN
-----------

IF OBJECT_ID('U_EDSICCBTST_drvTbl_QBPLAN') IS NULL
CREATE TABLE [dbo].[U_EDSICCBTST_drvTbl_QBPLAN] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NOT NULL,
    [drvDedCode] char(5) NULL,
    [drvPlanName] varchar(50) NULL,
    [drvCoverageLevel] varchar(11) NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(6) NULL,
    [drvSubSort3] varchar(208) NULL
);

-----------
-- Create table U_EDSICCBTST_drvTbl_QBPLAN2
-----------

IF OBJECT_ID('U_EDSICCBTST_drvTbl_QBPLAN2') IS NULL
CREATE TABLE [dbo].[U_EDSICCBTST_drvTbl_QBPLAN2] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NOT NULL,
    [drvDedCode] char(5) NULL,
    [drvPlanName] varchar(50) NULL,
    [drvStartDate] datetime NULL,
    [drvEndDate] int NULL,
    [drvCoverageLevel] varchar(11) NULL,
    [drvPlanBundleName] varchar(50) NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(6) NULL,
    [drvSubSort3] varchar(208) NULL
);

-----------
-- Create table U_EDSICCBTST_drvTbl_QBPLANINITIAL
-----------

IF OBJECT_ID('U_EDSICCBTST_drvTbl_QBPLANINITIAL') IS NULL
CREATE TABLE [dbo].[U_EDSICCBTST_drvTbl_QBPLANINITIAL] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(16) NULL,
    [drvPLanName] varchar(32) NULL,
    [drvCoverageLevel] varchar(11) NULL
);

-----------
-- Create table U_EDSICCBTST_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL
-----------

IF OBJECT_ID('U_EDSICCBTST_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL') IS NULL
CREATE TABLE [dbo].[U_EDSICCBTST_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(16) NULL,
    [drvRecordType] varchar(33) NOT NULL,
    [drvPlanName] varchar(15) NULL,
    [drvRate] nvarchar(4000) NULL
);

-----------
-- Create table U_EDSICCBTST_EEList
-----------

IF OBJECT_ID('U_EDSICCBTST_EEList') IS NULL
CREATE TABLE [dbo].[U_EDSICCBTST_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EDSICCBTST_File
-----------

IF OBJECT_ID('U_EDSICCBTST_File') IS NULL
CREATE TABLE [dbo].[U_EDSICCBTST_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);

-----------
-- Create table U_EDSICCBTST_PDedHist
-----------

IF OBJECT_ID('U_EDSICCBTST_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EDSICCBTST_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhSource1] numeric NULL,
    [PdhSource2] numeric NULL,
    [PdhSource3] numeric NULL,
    [PdhSource4] numeric NULL,
    [PdhSource5] numeric NULL,
    [PdhSource6] numeric NULL,
    [PdhSource7] numeric NULL,
    [PdhSource8] numeric NULL,
    [PdhSource9] numeric NULL,
    [PdhSource10] numeric NULL
);

-----------
-- Create table U_EDSICCBTST_PEarHist
-----------

IF OBJECT_ID('U_EDSICCBTST_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EDSICCBTST_PEarHist] (
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
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EDSICCBTST]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: New Port Group

Created By: James Bender
Business Analyst: Lea King
Create Date: 01/24/2021
Service Request Number: TekP-2020-10-22-0003    

Purpose: Discovery Benefits Cobra Export - Combined NPM/QB

Revision History
----------------
Update By            Date           Request Num        Desc
XXXX                 XX/XX/xxxx     SR-20XX-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EDSICCBTST';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EDSICCBTST';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EDSICCBTST';
SELECT * FROM dbo.AscExp WHERE expFormatCode = 'EDSICCBTST';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EDSICCBTST' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDSICCBTST', 'SCHEDULED';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDSICCBTST', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDSICCBTST', 'TEST';


EXEC dbo.dsi_BDM_sp_ErrorCheck 'EDSICCBTST';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EDSICCBTST', @AllObjects = 'Y', @IsWeb = 'Y'

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
    SET @FormatCode = 'EDSICCBTST';


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
    DELETE FROM dbo.U_EDSICCBTST_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCoID(xEEID)
      AND xEEID IN (SELECT xEEID FROM dbo.U_EDSICCBTST_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'DENBA,DENAD,UMHDH,UMPPO,VIS,MHMO,KHDHP,FSA,FSALP,STDE';

    IF OBJECT_ID('U_EDSICCBTST_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EDSICCBTST_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EDSICCBTST_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

    --==========================================
    -- BDM Section for NPM
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DedList);

    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'TermSelectionOption','AuditDate');

    -- NPM parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RunID','NPM');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','Y'); -- DedIsCobraCovered = 'Y'
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'NewEnrolleeType','4'); -- All new enrollees where no previous plan exists
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'TableType','EMP'); -- Only include employees on NPM file

    -- Run BDM for NPM
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- BDM Section for QB
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'TermSelectionOption','AuditDate');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DedList);

    -- COBRA parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RunID','QB');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'AddToPreviousRun','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','Y'); -- DedIsCobraCovered = 'Y'
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraType','4'); -- Eep/ConCobraReason first, then EdhChangeReason. Include CHGRP for elig. ben groups
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraDate','3'); -- EedBenStopDate and DbnBenStopDate, unless Eep/ConDateOfCOBRAEvent exists
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraPQBType','1'); -- If no EE or spouse, ALL children are PQB (not just oldest)
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraReasonsDepPQB','201,204,210,LEVNT3,LEVNT4'); -- Valid dependent PQB reasons
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidCobraReasonsEmp','201,204,210,LEVNT3,LEVNT4,302'); -- Invalidate employee when Cobra Reason is a dependent PQB reason
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidTermReasonsEmp','203'); -- Invalidate employee when Cobra Reason is "Death"
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'ConCobraReasonPCF','DependentCOBRAReason'); -- Valid dependent PQB reasons
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CountDependents','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL,DAU,DPC,SON,STC');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP,DOM');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');

    -- Run BDM for QB
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;


    --   --==========================================
 --   -- Insert into BDM Reason code 201 and 204
 --   --==========================================
    INSERT INTO [dbo].[U_dsi_BDM_EDSICCBTST]
           ([BdmRecType]
           ,[BdmCOID]
           ,[BdmEEID]
           ,[BdmDepRecID]
           ,[BdmSystemID]
           ,[BdmRunID]
           ,[BdmDedRowStatus]
           ,[BdmRelationship]
           ,[BdmDateOfBirth]
           ,[BdmDedCode]
           ,[BdmBenStartDate]
           ,[BdmBenStopDate]
           ,[BdmBenStatusDate]
           ,[BdmChangeReason]
           ,[BdmStartDate]
           ,[BdmStopDate]
           ,[BdmIsPQB]
           ,[BdmBenOption]

    )
 Select rectype = 'DEP', dbnCoid, dbneeid, DbnDepRecID, DbnDepRecID, 'QB', 'Data Inserted for 204 Chg reason', 
            DbnRelationship, DbnDateOfBirth, dbnDedcode, (Select top 1 edhBenStartDate from emphded A where A.edhdedcode = dbnDedcode and A.edheeid =  dbneeid and A.edhcoid = dbncoid order by Auditkey asc ) as bdmBenstartDate,edhBenStopDate, edhEffDate,'204'
            ,edhStartDate, edhStopDate, CASE WHEN dbnRelationShip = 'SPS' THEN 'Y' ELSE 'N' END, edhbenoption 
            from dbo.emphded with (nolock)
            JOIN dbo.U_dsi_BDM_DepDeductions on dbneeid = edheeid and dbnformatcode = @FormatCode
            WHERE edhChangeReason in ('204') and dbnbenstopdate between @startdate and @enddate and dbnValidForExport = 'N'
                and dbnrunid  = 'QB'
                        Group by dbnCoid,dbneeid,DbnDepRecID,DbnRelationship,DbnDateOfBirth,dbnDedcode,edhBenStopDate,edhEffDate,edhStartDate,edhStopDate,edhbenoption


INSERT INTO [dbo].[U_dsi_BDM_EDSICCBTST]
           ([BdmRecType]
           ,[BdmCOID]
           ,[BdmEEID]
           ,[BdmDepRecID]
           ,[BdmSystemID]
           ,[BdmRunID]
           ,[BdmDedRowStatus]
           ,[BdmRelationship]
           ,[BdmDateOfBirth]
           ,[BdmDedCode]
           ,[BdmBenStartDate]
           ,[BdmBenStopDate]
           ,[BdmBenStatusDate]
           ,[BdmChangeReason]
           ,[BdmStartDate]
           ,[BdmStopDate]
           ,[BdmIsPQB]
          , [BdmBenOption]

    )
    Select rectype = 'DEP', dbncoid, dbneeid, DbnDepRecID, DbnDepRecID, 'QB', 'Data Inserted for 201 Chg reason', 
            DbnRelationship, DbnDateOfBirth, dbnDedcode, (Select top 1 edhBenStartDate from emphded A where A.edhdedcode = dbnDedcode and A.edheeid =  dbneeid and A.edhcoid = dbncoid order by Auditkey asc ) as bdmBenstartDate,edhBenStopDate, edhEffDate,'201'
            ,edhStartDate, edhStopDate, 'Y',edhbenoption
            from dbo.emphded with (nolock)
            JOIN dbo.U_dsi_BDM_DepDeductions on dbneeid = edheeid and dbnformatcode = @FormatCode
           
            WHERE edhChangeReason in ('201') and dbnbenstopdate between @startdate and @enddate and dbnValidForExport = 'N'
            and dbnrunid  = 'QB'
            Group by dbncoid, dbneeid,DbnDepRecID,DbnRelationship,DbnDateOfBirth,dbnDedcode,edhBenStopDate,edhEffDate,edhStartDate,edhStopDate,edhbenoption
            ----
            /*
            INSERT INTO [dbo].[U_dsi_BDM_EDSICCBTST]
           ([BdmRecType]
           ,[BdmCOID]
           ,[BdmEEID]
           ,[BdmDepRecID]
           ,[BdmSystemID]
           ,[BdmRunID]
           ,[BdmDedRowStatus]
           ,[BdmRelationship]
           ,[BdmDateOfBirth]
           ,[BdmDedCode]
           ,[BdmBenStartDate]
           ,[BdmBenStopDate]
           ,[BdmBenStatusDate]
           ,[BdmChangeReason]
           ,[BdmStartDate]
           ,[BdmStopDate]
           ,[BdmIsPQB]
          , [BdmBenOption]

    )
    
    Select rectype = 'DEP', dbncoid, dbneeid, DbnDepRecID, DbnDepRecID, 'QB', 'Data Inserted for 302 Chg reason', 
            DbnRelationship, DbnDateOfBirth, dbnDedcode, (Select top 1 edhBenStartDate from emphded A where A.edhdedcode = dbnDedcode and A.edheeid =  dbneeid and A.edhcoid = dbncoid order by Auditkey asc ) as bdmBenstartDate,edhBenStopDate, edhEffDate,'302'
            ,edhStartDate, edhStopDate, 'Y',edhbenoption
            from dbo.emphded with (nolock)
            JOIN dbo.U_dsi_BDM_DepDeductions on dbneeid = edheeid and dbnformatcode = @FormatCode
           
            WHERE edhChangeReason in ('302') and dbnbenstopdate between @startdate and @enddate and dbnValidForExport = 'N'
            and dbnrunid  = 'QB'
            Group by dbncoid, dbneeid,DbnDepRecID,DbnRelationship,DbnDateOfBirth,dbnDedcode,edhBenStopDate,edhEffDate,edhStartDate,edhStopDate,edhbenoption
    */
        
            Delete from dbo.U_dsi_BDM_EDSICCBTST where bdmdedcode not in (Select dedcode from U_EDSICCBTST_DedList)

            Update dbo.U_dsi_BDM_EDSICCBTST  
            set bdmNumSpouses = (select count(*) from U_dsi_BDM_EDSICCBTST A where A.bdmeeid = X.bdmeeid and bdmRelationship = 'SPS' and A.bdmcoid = X.bdmcoid)
            ,bdmNumChildren = (select count(*) from U_dsi_BDM_EDSICCBTST A where A.bdmeeid = X.bdmeeid and bdmRelationship = 'CHL' and A.bdmcoid = X.bdmcoid)
            from dbo.U_dsi_BDM_EDSICCBTST  X

            where BdmDedRowStatus IN ('Data Inserted for 204 Chg reason','Data Inserted for 201 Chg reason','Data Inserted for 302 Chg reason');


            Delete from dbo.U_dsi_BDM_EDSICCBTST   where BdmDedRowStatus IN ('Data Inserted for 204 Chg reason','Data Inserted for 201 Chg reason','Data Inserted for 302 Chg reason') and bdmbenoption is null


    -- Build driver tables
    --==========================================
    ------------------
    -- DETAIL RECORD - NPM Record
    ------------------
    IF OBJECT_ID('U_EDSICCBTST_drvTbl_NPM') IS NOT NULL
        DROP TABLE dbo.U_EDSICCBTST_drvTbl_NPM;
    SELECT DISTINCT
         drvEEID            = BdmEEID
        ,drvCoID            = BdmCoID
        ,drvSSN             = eepSSN
        ,drvEmpNo           = ''
        ,drvClientName      = CONVERT(varchar(100),'Newport Group Inc 38989')
        ,drvClientDivName   = CASE WHEN bdmcoid = 'U5P4Y' AND EepAddressState <> 'CA' THEN 'Newport Group'
                                        WHEN bdmcoid = 'U5P4Y' AND EepAddressState = 'CA' THEN 'Newport Group CA'
                                        WHEN bdmcoid = 'CXNNJ' THEN 'PAI Inc'
                                    END
        ,drvNameFirst       = EepNameFirst
        ,drvNameMiddle      = LEFT(EepNameMiddle,1)
        ,drvNameLast        = EepNameLast
        ,drvAddressEMail    = ''
        ,drvPhoneHomeNumber = ''
        ,drvAddressLine1    = EepAddressLine1
        ,drvAddressLine2    = EepAddressLine2
        ,drvAddressCity     = EepAddressCity
        ,drvAddressState    = EepAddressState
        ,drvAddressZipCode  = EepAddressZipCode
        ,drvGender          = CASE WHEN EepGender IN ('M','F') THEN EepGender ELSE 'U' END
        ,drvHireDate        = EecDateOfLastHire
        ,drvInitialSort     = '22'
        ,drvSubSort         = eepSSN
        ,drvSubSort2        = ''
        ,drvSubSort3        = ''
    INTO dbo.U_EDSICCBTST_drvTbl_NPM
    FROM dbo.U_dsi_BDM_EDSICCBTST WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = BdmEEID
       AND EecCoID = BdmCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = BdmEEID
    WHERE BdmRunID = 'NPM'

    ------------------
    -- QB DETAIL RECORD
    ------------------
    IF OBJECT_ID('U_EDSICCBTST_drvTbl_QB') IS NOT NULL
        DROP TABLE dbo.U_EDSICCBTST_drvTbl_QB;
    SELECT DISTINCT
         drvEEID           = BdmEEID
        ,drvCoID           = BdmCoID
        ,drvDepRecID       = ISNULL(BdmDepRecID,'')
        ,drvClientName     = CONVERT(varchar(100),'Newport Group Inc 38989')
        ,drvClientDivName  = CASE WHEN bdmcoid = 'U5P4Y' AND EepAddressState <> 'CA' THEN 'Newport Group'
                                        WHEN bdmcoid = 'U5P4Y' AND EepAddressState = 'CA' THEN 'Newport Group CA'
                                        WHEN bdmcoid = 'CXNNJ' THEN 'PAI Inc'
                                    END
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
        ,drvEmpNo          = ''
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
        ,drvTobacoUse       = 'UNKNOWN'
        ,drvEmpPayrollType =  'UNKNOWN'
        ,drvInitialSort    = '21'
        ,drvSubSort        = CASE WHEN BdmRecType = 'EMP' THEN eepSSN
                                  ELSE ISNULL(NULLIF(ConSSN,''),eepSSN) + CONVERT(char(8),ConDateOfBirth,112)
                             END
        ,drvSubSort2       = '1'
        ,drvSubSort3       = CASE WHEN BdmRecType = 'EMP' THEN '2'
                                  ELSE CONVERT(char(8),ConDateOfBirth,112) + RTRIM(ConNameLast) + ConNameFirst
                             END
    INTO dbo.U_EDSICCBTST_drvTbl_QB
    FROM dbo.U_dsi_BDM_EDSICCBTST WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = BdmEEID
       AND EecCoID = BdmCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = BdmEEID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = BdmEEID
       AND ConSystemID = BdmDepRecID
    WHERE BdmRunID = 'QB'
      AND BdmIsPQB = 'Y';

    ------------------
    -- QBEVENT DETAIL RECORD
    ------------------
    IF OBJECT_ID('U_EDSICCBTST_drvTbl_QBEVENT') IS NOT NULL
        DROP TABLE dbo.U_EDSICCBTST_drvTbl_QBEVENT;
    SELECT DISTINCT
         drvEEID           = drvEEID
        ,drvCoID           = drvCoID
        ,drvDepRecID       = drvDepRecID
        ,drvEventType      = CASE WHEN EecTermReason = '202' THEN 'RETIREMENT'
                                  WHEN EecTermReason = '203' THEN 'DEATH'
                                  WHEN BdmCobraReason IN ('201','LEVNT3','302') or BdmChangereason IN ('201','LEVNT3','302')  THEN 'INELIGIBLEDEPENDENT'
                                  WHEN BdmCobraReason IN ('204','LEVNT4') or BdmChangereason IN ('204','LEVNT4')  THEN 'DIVORCELEGALSEPARATION'
                                  
                                  WHEN BdmCobraReason = '210' or BdmChangereason = '210' THEN 'DEATH'
                                  WHEN BdmCobraReason IN ('202','CHGRP') THEN 'LOSSOFELIGIBILITY'
                                  WHEN BdmCobraReason IN ('203','202') THEN 'REDUCTIONINHOURS-STATUSCHANGE '
                                  WHEN BdmCobraReason = '205' THEN 'MEDICARE'
                                  WHEN BdmCobraReason = '206' THEN 'REDUCTIONINHOURS-ENDOFLEAVE'
                                  WHEN BdmCobraReason = '207' THEN 'USERRA-REDUCTIONINHOURS'
                                  WHEN BdmCobraReason = '208' THEN 'RETIREMENT'
                                  WHEN BdmCobraReason = '209' THEN 'WORKSTOPPAGE'
                                  WHEN EecEmplStatus = 'T' and eectermtype  = 'I' THEN 'INVOLUNTARYTERMINATION'
                                  ELSE 'TERMINATION'
                             END
        ,drvEventDate      = CASE WHEN BdmCobraReason in ('204','201','LEVNT3','LEVNT4','302') or BdmChangereason in ('204','201','LEVNT3','LEVNT4','302','210') THEN  BdmBenStatusDate ELSE BdmDateOfCOBRAEvent END
        ,drvEnrollmentDate = BdmBenStartDate
        ,drvSSN            = eepSSN
        ,drvName           = RTRIM(EepNameFirst) + ' ' + RTRIM(EepNameLast)
        ,drvInitialSort    = '21'
        ,drvSubSort        = drvSubSort
        ,drvSubSort2       = '1'
        ,drvSubSort3       = drvSubSort3
    INTO dbo.U_EDSICCBTST_drvTbl_QBEVENT
    FROM dbo.U_EDSICCBTST_drvTbl_QB WITH (NOLOCK)
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
            ,BdmChangereason = MAX(BdmChangereason)
            ,BdmBenStartDate = MIN(BdmBenStartDate)
            ,BdmDateOfCOBRAEvent = MAX(BdmDateOfCOBRAEvent)
            ,BdmUSGDate1 = MAX(BdmUSGDate1)
            ,BdmBenStatusDate = MAX(BdmBenStatusDate)
          FROM dbo.U_dsi_BDM_EDSICCBTST WITH (NOLOCK)
          WHERE BdmRunID = 'QB'
            AND BdmIsPQB = 'Y'
          GROUP BY BdmEEID, BdmCoID, BdmDepRecID, BdmRecType) BDM
        ON BdmEEID = drvEEID
       AND BdmCoID = drvCoID
       AND ISNULL(BdmDepRecID,'') = drvDepRecID;

    ------------------
    -- QBPLAN DETAIL RECORD
    ------------------

     ------------------
    -- QBPLANINITIAL DETAIL RECORD
    ------------------
    IF OBJECT_ID('U_EDSICCBTST_drvTbl_QBPLAN') IS NOT NULL
        DROP TABLE dbo.U_EDSICCBTST_drvTbl_QBPLAN;
    SELECT DISTINCT
         drvEEID          = drvEEID
        ,drvCoID          = drvCoID
        ,drvDepRecID      = drvDepRecID
        ,drvDedCode       = BdmDedCode
        ,drvPlanName      = CONVERT(varchar(50),(CASE WHEN BdmDedCode = 'FSA' THEN 'DBI FSA'
                            WHEN BdmDedCode = 'FSALP' THEN 'DBI Limited FSA'
                            WHEN BdmDedCode = 'STDE' THEN 'Claremont EAP Newport' --
                            WHEN BdmDedCode = 'DENBA' AND EepAddressState NOT IN ('TX','MS','LA') THEN 'MetLife Dental Basic'
                            WHEN BdmDedCode = 'DENBA' AND EepAddressState IN ('TX','MS','LA') THEN 'MetLife Dental Basic TX/MS/LA'
                            WHEN BdmDedCode = 'DENAD' AND EepAddressState NOT IN ('TX','MS','LA') THEN 'MetLife Dental Enhanced'
                            WHEN BdmDedCode = 'DENAD' AND EepAddressState IN ('TX','MS','LA') THEN 'MetLife Dental Enhanced TX/MS/LA'
                            WHEN BdmDedCode = 'UMHDH' AND EepAddressState NOT IN ('CA') THEN 'UMR/UHC Medical HDHP'
                            WHEN BdmDedCode = 'UMHDH' AND EepAddressState IN ('CA') THEN 'UMR/UHC Medical HDHP CA Only'
                            WHEN BdmDedCode = 'UMPPO' AND EepAddressState NOT IN ('CA') THEN 'UMR/UHC Medical PPO'
                            WHEN BdmDedCode = 'UMPPO' AND EepAddressState IN ('CA') THEN 'UMR/UHC Medical PPO CA Only'
                            WHEN BdmDedCode = 'VIS' THEN 'VSP Vision Newport'
                            WHEN BdmDedCode = 'MHMO' THEN 'Kaiser CA Medical DHMO'
                            WHEN BdmDedCode = 'KHDHP' THEN 'Kaiser CA Medical Newport HSA'                      
                        END))
        ,drvCoverageLevel = CASE WHEN BdmDedCode IN ('DENBA','DENAD','UMHDH','UMPPO','VIS','MHMO','KHDHP') THEN
                                CASE 
                                    WHEN BdmCobraReason IN  ('201','LEVNT3','302','204','LEVNT4','302','210') or BdmChangereason IN  ('201','LEVNT3','302','204','LEVNT4','302','210') or EecTermReason = '203' THEN 'EE'
                                    WHEN BdmBenOption = 'EE' THEN 'EE'
                                    WHEN BdmBenOption = 'EEC' THEN 'EE+CHILDREN'
                                    WHEN BdmBenOption IN ('EEF','EEDPF') THEN 'EE+FAMILY'
                                    WHEN BdmBenOption IN ('EES','EEDP') THEN 'EE+SPOUSE'
                                END
                                WHEN BdmDedCode IN ('FSA','FSALP','STDE') THEN 'EE'
                            END
        ,drvInitialSort   = '21'
        ,drvSubSort       = drvSubSort
        ,drvSubSort2      = '1' + BdmDedCode
        ,drvSubSort3      = drvSubSort3
    INTO dbo.U_EDSICCBTST_drvTbl_QBPLAN
    FROM dbo.U_EDSICCBTST_drvTbl_QBEVENT WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EDSICCBTST WITH (NOLOCK)
        ON BdmEEID = drvEEID
       AND BdmCoID = drvCoID
       AND ISNULL(BdmDepRecID,'') = drvDepRecID
    JOIN dbo.EmpPers WITH (NOLOCK) 
        on eepeeid =  drveeid
       JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = drvEEID
       AND EecCoID = drvCoID
    WHERE BdmRunID = 'QB'
      AND BdmIsPQB = 'Y'


    ------------------
    -- QBDEPENDENT DETAIL RECORD
    ------------------
    IF OBJECT_ID('U_EDSICCBTST_drvTbl_QBDEP') IS NOT NULL
        DROP TABLE dbo.U_EDSICCBTST_drvTbl_QBDEP;
    SELECT DISTINCT
         drvEEID           = BdmEEID
        ,drvCoID           = BdmCoID
        ,drvDepRecID       = BdmDepRecID
        ,drvSSN            = ISNULL(ConSSN,'')
        ,drvRelationship   = CASE WHEN BdmRelationship IN ('SPS') THEN 'SPOUSE'
                                  WHEN BdmRelationship IN ('DP','DOM') THEN 'DOMESTICPARTNER'
                                  WHEN BdmRelationship IN ('CHL','DIS','DPC','STC','DAU','SON') THEN 'CHILD'
                             END
        ,drvNameFirst      = ConNameFirst
        ,drvNameMiddle     = LEFT(ConNameMiddle,1)
        ,drvNameLast       = ConNameLast
        ,drvIsAddressSame  = CASE WHEN ConAddressIsDifferent = 'N' THEN 'TRUE' ELSE 'FALSE' END
        ,drvAddressLine1   = CASE WHEN ConAddressIsDifferent = 'N' THEN '' ELSE ConAddressLine1 END
        ,drvAddressLine2   = CASE WHEN ConAddressIsDifferent = 'N' THEN '' ELSE ConAddressLine2 END
        ,drvAddressCity    = CASE WHEN ConAddressIsDifferent = 'N' THEN '' ELSE ConAddressCity END
        ,drvAddressState   = CASE WHEN ConAddressIsDifferent = 'N' THEN '' ELSE ConAddressState END
        ,drvAddressZipCode = CASE WHEN ConAddressIsDifferent = 'N' THEN '' ELSE ConAddressZipCode END
        ,drvGender         = CASE WHEN ConGender IN ('M','F') THEN ConGender ELSE 'U' END
        ,drvDateOfBirth    = ConDateOfBirth
        ,drvISQMCO         = 'False'
        ,drvInitialSort    = '21'
        ,drvSubSort        = drvSubSort
        ,drvSubSort2       = '2' + CASE WHEN BdmRelationship IN ('SPS','DP') THEN 'A'
                                        ELSE 'B' + ISNULL(ConSSN,ConNameFirst)
                                   END + CONVERT(char(8),ISNULL(ConDateOfBirth,''),112) + ConSystemID
        ,drvSubSort3       = drvSubSort3
    INTO dbo.U_EDSICCBTST_drvTbl_QBDEP
    FROM dbo.U_EDSICCBTST_drvTbl_QB WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EDSICCBTST WITH (NOLOCK)
        ON BdmEEID = drvEEID
       AND BdmCoID = drvCoID
    JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = BdmEEID
       AND ConSystemID = BdmDepRecID
    WHERE BdmRunID = 'QB'
      AND BdmIsPQB = 'N'


    ------------------
    -- QBDEPENDENTPLANINITIAL DETAIL RECORD
    ------------------
    IF OBJECT_ID('U_EDSICCBTST_drvTbl_QBDEPPLAN') IS NOT NULL
        DROP TABLE dbo.U_EDSICCBTST_drvTbl_QBDEPPLAN;
    SELECT DISTINCT
         drvEEID        = BdmEEID
        ,drvCoID        = BdmCoID
        ,drvDepRecID    = BdmDepRecID
        ,drvDedCode     = BdmDedCode
        ,drvPlanName    = CONVERT(varchar(50),(CASE WHEN BdmDedCode = 'DENBA' AND EepAddressState NOT IN ('TX','MS','LA') THEN 'MetLife Dental Basic'
                            WHEN BdmDedCode = 'DENBA' AND EepAddressState IN ('TX','MS','LA') THEN 'MetLife Dental Basic TX/MS/LA'
                            WHEN BdmDedCode = 'DENAD' AND EepAddressState NOT IN ('TX','MS','LA') THEN 'MetLife Dental Enhanced'
                            WHEN BdmDedCode = 'DENAD' AND EepAddressState IN ('TX','MS','LA') THEN 'MetLife Dental Enhanced TX/MS/LA'
                            WHEN BdmDedCode = 'UMHDH' AND EepAddressState NOT IN ('CA') THEN 'UMR/UHC Medical HDHP'
                            WHEN BdmDedCode = 'UMHDH' AND EepAddressState IN ('CA') THEN 'UMR/UHC Medical HDHP CA Only'
                            WHEN BdmDedCode = 'UMPPO' AND EepAddressState NOT IN ('CA') THEN 'UMR/UHC Medical PPO'
                            WHEN BdmDedCode = 'UMPPO' AND EepAddressState IN ('CA') THEN 'UMR/UHC Medical PPO CA Only'
                            WHEN BdmDedCode = 'VIS' THEN 'VSP Vision Newport'
                            WHEN BdmDedCode = 'MHMO' THEN 'Kaiser CA Medical DHMO'
                            WHEN BdmDedCode = 'KHDHP' THEN 'Kaiser CA Medical Newport HSA'
                        END))
        ,drvInitialSort = '21'
        ,drvSubSort     = drvSubSort
        ,drvSubSort2    = '2' + CASE WHEN BdmRelationship IN ('SPS','DP') THEN 'A'
                                     ELSE 'B' + RTRIM(ISNULL(ConSSN,ConNameFirst))
                                END + CONVERT(char(8),ISNULL(ConDateOfBirth,''),112) + ConSystemID + BdmDedCode
        ,drvSubSort3    = drvSubSort3
    INTO dbo.U_EDSICCBTST_drvTbl_QBDEPPLAN
    FROM dbo.U_EDSICCBTST_drvTbl_QBPLAN WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EDSICCBTST WITH (NOLOCK)
        ON BdmEEID = drvEEID
       AND BdmCoID = drvCoID
       AND BdmDedCode = drvDedCode
    JOIN dbo.Emppers WITH (NOLOCK)
        on EEPEEID = drveeid
    JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = BdmEEID
       AND ConSystemID = BdmDepRecID
    WHERE BdmRunID = 'QB'
      AND BdmIsPQB = 'N';

    ------------------
    -- QBPLANMEMBERSPECIFICRATEINITIAL DETAIL RECORD
    ------------------
    IF OBJECT_ID('U_EDSICCBTST_drvTbl_QBMSRI') IS NOT NULL
        DROP TABLE dbo.U_EDSICCBTST_drvTbl_QBMSRI;
    SELECT DISTINCT
         drvEEID        = drvEEID
        ,drvCoID        = drvCoID
        ,drvDepRecID    = drvDepRecID
        ,drvPlanName    =  CONVERT(varchar(50),(CASE WHEN BdmDedCode = 'FSA' THEN 'DBI FSA'
                            WHEN BdmDedCode = 'FSALP' THEN 'DBI Limited FSA'
                        END))
        ,drvRate        = CASE WHEN BdmDedCode IN ('FSA','FSALP') THEN FORMAT(BdmEEAmt, '#0.00') END
        ,drvInitialSort = '21'
        ,drvSubSort     = drvSubSort
        ,drvSubSort2    = '3'
        ,drvSubSort3    = drvSubSort3
    INTO dbo.U_EDSICCBTST_drvTbl_QBMSRI
    FROM dbo.U_EDSICCBTST_drvTbl_QBPLAN WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EDSICCBTST WITH (NOLOCK)
        ON BdmEEID = drvEEID
       AND BdmCoID = drvCoID
       AND ISNULL(BdmDepRecID,'') = drvDepRecID
       AND BdmDedCode = drvDedCode
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = BdmEEID
       AND EecCoID = BdmCoID
    LEFT JOIN (
        Select * from [dbo].[fn_MP_CustomFields_EmpPers_Export](null,null,null,null)
    ) A 
    on A.eeid =  drvEEID
    WHERE BdmRunID = 'QB'
      AND BdmIsPQB = 'Y'
      AND BdmDedType = 'FSA';
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
/*
--Alter the View
ALTER VIEW dbo.dsi_vwEDSICCBTST_Export AS
    SELECT TOP 2000000 Data
    FROM dbo.U_EDSICCBTST_File WITH (NOLOCK)
    ORDER BY InitialSort, SubSort, SubSort2, SubSort3, RecordSet;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EDSICCBTST%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
SET expLastStartPerControl = '201601251'
   ,expStartPerControl     = '201601251'
   ,expLastEndPerControl   = '201602039'
   ,expEndPerControl       = '201602039'
WHERE expFormatCode = 'EDSICCBTST'
  AND expExportCode LIKE 'TEST%';
*/
SET NOCOUNT OFF;
GO
CREATE VIEW dbo.dsi_vwEDSICCBTST_Export AS
    SELECT TOP 2000000 Data
    FROM dbo.U_EDSICCBTST_File WITH (NOLOCK)
    ORDER BY InitialSort, SubSort, SubSort2, SubSort3, RecordSet;

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EDSICCBTST' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EDSICCBTST', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EDSICCBTST', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EDSICCBTST', 'UseFileName', 'V', 'Y'


-- End ripout