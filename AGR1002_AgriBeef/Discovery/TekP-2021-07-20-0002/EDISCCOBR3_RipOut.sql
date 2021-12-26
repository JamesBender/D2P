/**********************************************************************************

EDISCCOBR3: Discovery Benefits Cobra Exp TEST

FormatCode:     EDISCCOBR3
Project:        Discovery Benefits Cobra Exp TEST
Client ID:      AGR1002
Date/time:      2021-12-22 23:25:41.760
Ripout version: 7.4
Export Type:    Back Office
Status:         Production
Environment:    N12
Server:         N1SUP2DB51
Database:       ULTIPRO_AGRI
ExportPath:    \\us.saas\n0\data_exchange\AGR1002\Exports\
TestPath:      \\us.saas\n1\Public\10691\Exports\Discovery\

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EDISCCOBR3_SavePath') IS NOT NULL DROP TABLE dbo.U_EDISCCOBR3_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EDISCCOBR3'


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
WHERE FormatCode = 'EDISCCOBR3'
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
WHERE ExpFormatCode = 'EDISCCOBR3'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EDISCCOBR3')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EDISCCOBR3'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EDISCCOBR3'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EDISCCOBR3'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EDISCCOBR3'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EDISCCOBR3'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EDISCCOBR3'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EDISCCOBR3'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EDISCCOBR3'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EDISCCOBR3'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEDISCCOBR3_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEDISCCOBR3_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EDISCCOBR3') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EDISCCOBR3];
GO
IF OBJECT_ID('U_EDISCCOBR3_File') IS NOT NULL DROP TABLE [dbo].[U_EDISCCOBR3_File];
GO
IF OBJECT_ID('U_EDISCCOBR3_EEList') IS NOT NULL DROP TABLE [dbo].[U_EDISCCOBR3_EEList];
GO
IF OBJECT_ID('U_EDISCCOBR3_drvTbl_QBPLAN') IS NOT NULL DROP TABLE [dbo].[U_EDISCCOBR3_drvTbl_QBPLAN];
GO
IF OBJECT_ID('U_EDISCCOBR3_drvTbl_QBMSRI') IS NOT NULL DROP TABLE [dbo].[U_EDISCCOBR3_drvTbl_QBMSRI];
GO
IF OBJECT_ID('U_EDISCCOBR3_drvTbl_QBEVENT') IS NOT NULL DROP TABLE [dbo].[U_EDISCCOBR3_drvTbl_QBEVENT];
GO
IF OBJECT_ID('U_EDISCCOBR3_drvTbl_QBDEPPLAN') IS NOT NULL DROP TABLE [dbo].[U_EDISCCOBR3_drvTbl_QBDEPPLAN];
GO
IF OBJECT_ID('U_EDISCCOBR3_drvTbl_QBDEP') IS NOT NULL DROP TABLE [dbo].[U_EDISCCOBR3_drvTbl_QBDEP];
GO
IF OBJECT_ID('U_EDISCCOBR3_drvTbl_QB') IS NOT NULL DROP TABLE [dbo].[U_EDISCCOBR3_drvTbl_QB];
GO
IF OBJECT_ID('U_EDISCCOBR3_drvTbl_NPM') IS NOT NULL DROP TABLE [dbo].[U_EDISCCOBR3_drvTbl_NPM];
GO
IF OBJECT_ID('U_dsi_BDM_EDISCCOBR3') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EDISCCOBR3];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EDISCCOBR3','Discovery Benefits Cobra Exp TEST','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','EDISCCOBR3Z0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EDISCCOBR3Z0','50','H','01','1',NULL,'Version Line Identifier',NULL,NULL,'"[VERSION]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EDISCCOBR3Z0','50','H','01','2',NULL,'Version Number',NULL,NULL,'"1.1"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EDISCCOBR3Z0','50','H','02','1',NULL,'Version Line Identifier',NULL,NULL,'"[VERSION]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EDISCCOBR3Z0','50','H','02','2',NULL,'Version Number',NULL,NULL,'"1.0"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EDISCCOBR3Z0','50','D','10','1',NULL,'Version Line Identifier',NULL,NULL,'"[NPM]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EDISCCOBR3Z0','50','D','10','2',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EDISCCOBR3Z0','50','D','10','3',NULL,'IndividualIdentifier',NULL,NULL,'"drvEmpNo"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EDISCCOBR3Z0','50','D','10','4',NULL,'ClientName',NULL,NULL,'"drvClientName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EDISCCOBR3Z0','50','D','10','5',NULL,'ClientDivisionName',NULL,NULL,'"drvClientDivName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EDISCCOBR3Z0','50','D','10','6',NULL,'FirstName',NULL,NULL,'"drvNameFirst"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EDISCCOBR3Z0','50','D','10','7',NULL,'MiddleInitial',NULL,NULL,'"drvNameMiddle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EDISCCOBR3Z0','50','D','10','8',NULL,'LastName',NULL,NULL,'"drvNameLast"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EDISCCOBR3Z0','50','D','10','9',NULL,'Salutation',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EDISCCOBR3Z0','50','D','10','10',NULL,'Email',NULL,NULL,'"drvAddressEMail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EDISCCOBR3Z0','50','D','10','11',NULL,'Phone',NULL,NULL,'"drvPhoneHomeNumber"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EDISCCOBR3Z0','50','D','10','12',NULL,'Phone2',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EDISCCOBR3Z0','50','D','10','13',NULL,'Address1',NULL,NULL,'"drvAddressLine1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EDISCCOBR3Z0','50','D','10','14',NULL,'Address2',NULL,NULL,'"drvAddressLine2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EDISCCOBR3Z0','50','D','10','15',NULL,'City',NULL,NULL,'"drvAddressCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EDISCCOBR3Z0','50','D','10','16',NULL,'StateOrProvince',NULL,NULL,'"drvAddressState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EDISCCOBR3Z0','50','D','10','17',NULL,'PostalCode',NULL,NULL,'"drvAddressZipCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EDISCCOBR3Z0','50','D','10','18',NULL,'Country',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EDISCCOBR3Z0','50','D','10','19',NULL,'Sex',NULL,NULL,'"drvGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EDISCCOBR3Z0','50','D','10','20',NULL,'UsesFamilyInAddress',NULL,NULL,'"T"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EDISCCOBR3Z0','50','D','10','21',NULL,'HasWaivedAllCoverage',NULL,NULL,'"F"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EDISCCOBR3Z0','50','D','10','22',NULL,'SendGRNotice',NULL,NULL,'"T"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EDISCCOBR3Z0','50','D','20','1',NULL,'Record Identifier',NULL,NULL,'"[QB]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EDISCCOBR3Z0','50','D','20','2',NULL,'ClientName',NULL,NULL,'"drvClientName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EDISCCOBR3Z0','50','D','20','3',NULL,'ClientDivisionName',NULL,NULL,'"drvClientDivName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EDISCCOBR3Z0','50','D','20','4',NULL,'Salutation',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EDISCCOBR3Z0','50','D','20','5',NULL,'FirstName',NULL,NULL,'"drvNameFirst"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EDISCCOBR3Z0','50','D','20','6',NULL,'MiddleInitial',NULL,NULL,'"drvNameMiddle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EDISCCOBR3Z0','50','D','20','7',NULL,'LastName',NULL,NULL,'"drvNameLast"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EDISCCOBR3Z0','50','D','20','8',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EDISCCOBR3Z0','50','D','20','9',NULL,'IndividualID',NULL,NULL,'"drvEmpNo"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EDISCCOBR3Z0','50','D','20','10',NULL,'Email',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EDISCCOBR3Z0','50','D','20','11',NULL,'Phone',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EDISCCOBR3Z0','50','D','20','12',NULL,'Phone2',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EDISCCOBR3Z0','50','D','20','13',NULL,'Address1',NULL,NULL,'"drvAddressLine1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EDISCCOBR3Z0','50','D','20','14',NULL,'Address2',NULL,NULL,'"drvAddressLine2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EDISCCOBR3Z0','50','D','20','15',NULL,'City',NULL,NULL,'"drvAddressCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EDISCCOBR3Z0','50','D','20','16',NULL,'StateOrProvince',NULL,NULL,'"drvAddressState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EDISCCOBR3Z0','50','D','20','17',NULL,'PostalCode',NULL,NULL,'"drvAddressZipCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EDISCCOBR3Z0','50','D','20','18',NULL,'Country',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EDISCCOBR3Z0','50','D','20','19',NULL,'PremiumAddressSameAsPrimary',NULL,NULL,'"TRUE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EDISCCOBR3Z0','50','D','20','20',NULL,'PremiumAddress1',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EDISCCOBR3Z0','50','D','20','21',NULL,'PremiumAddress2',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EDISCCOBR3Z0','50','D','20','22',NULL,'PremiumCity',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EDISCCOBR3Z0','50','D','20','23',NULL,'PremiumStateOrProvince',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EDISCCOBR3Z0','50','D','20','24',NULL,'PremiumPostalCode',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EDISCCOBR3Z0','50','D','20','25',NULL,'PremiumCountry',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EDISCCOBR3Z0','50','D','20','26',NULL,'Sex',NULL,NULL,'"drvGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EDISCCOBR3Z0','50','D','20','27',NULL,'DOB',NULL,NULL,'"drvDateOfBirth"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EDISCCOBR3Z0','50','D','20','28',NULL,'TobaccoUse',NULL,NULL,'"UNKNOWN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EDISCCOBR3Z0','50','D','20','29',NULL,'EmployeeType',NULL,NULL,'"UNKNOWN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EDISCCOBR3Z0','50','D','20','30',NULL,'EmployeePayrollType',NULL,NULL,'"UNKNOWN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EDISCCOBR3Z0','50','D','20','31',NULL,'YearsOfService',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EDISCCOBR3Z0','50','D','20','32',NULL,'PremiumCouponType',NULL,NULL,'"COUPONBOOK"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EDISCCOBR3Z0','50','D','20','33',NULL,'UsesHCTC',NULL,NULL,'"FALSE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EDISCCOBR3Z0','50','D','20','34',NULL,'Active',NULL,NULL,'"TRUE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EDISCCOBR3Z0','50','D','20','35',NULL,'AllowMemberSSO',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EDISCCOBR3Z0','50','D','20','36',NULL,'BenefitGroup',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EDISCCOBR3Z0','50','D','20','37',NULL,'AccountStructure',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EDISCCOBR3Z0','50','D','20','38',NULL,'ClientSpecificData',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EDISCCOBR3Z0','50','D','30','1',NULL,'Record Identifier',NULL,NULL,'"[QBEVENT]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EDISCCOBR3Z0','50','D','30','2',NULL,'EventType',NULL,NULL,'"drvEventType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EDISCCOBR3Z0','50','D','30','3',NULL,'EventDate',NULL,NULL,'"drvEventDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EDISCCOBR3Z0','50','D','30','4',NULL,'EnrollmentDate',NULL,NULL,'"drvEnrollmentDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EDISCCOBR3Z0','50','D','30','5',NULL,'EmployeeSSN',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EDISCCOBR3Z0','50','D','30','6',NULL,'EmployeeName',NULL,NULL,'"drvName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EDISCCOBR3Z0','50','D','30','7',NULL,'SecondEventOriginalFDOC',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EDISCCOBR3Z0','50','D','40','1',NULL,'Record Identifier',NULL,NULL,'"[QBPLANINITIAL]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EDISCCOBR3Z0','50','D','40','2',NULL,'PlanName',NULL,NULL,'"drvPlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EDISCCOBR3Z0','50','D','40','3',NULL,'CoverageLevel',NULL,NULL,'"drvCoverageLevel"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EDISCCOBR3Z0','50','D','40','4',NULL,'NumberOfUnits',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EDISCCOBR3Z0','50','D','50','1',NULL,'Record Identifier',NULL,NULL,'"[QBDEPENDENT]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EDISCCOBR3Z0','50','D','50','2',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EDISCCOBR3Z0','50','D','50','3',NULL,'Relationship',NULL,NULL,'"drvRelationship"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EDISCCOBR3Z0','50','D','50','4',NULL,'Salutation',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EDISCCOBR3Z0','50','D','50','5',NULL,'FirstName',NULL,NULL,'"drvNameFirst"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EDISCCOBR3Z0','50','D','50','6',NULL,'MiddleInitial',NULL,NULL,'"drvNameMiddle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EDISCCOBR3Z0','50','D','50','7',NULL,'LastName',NULL,NULL,'"drvNameLast"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EDISCCOBR3Z0','50','D','50','8',NULL,'Email',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EDISCCOBR3Z0','50','D','50','9',NULL,'Phone',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EDISCCOBR3Z0','50','D','50','10',NULL,'Phone2',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EDISCCOBR3Z0','50','D','50','11',NULL,'AddressSameAsQB',NULL,NULL,'"drvIsAddressSame"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EDISCCOBR3Z0','50','D','50','12',NULL,'Address1',NULL,NULL,'"drvAddressLine1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EDISCCOBR3Z0','50','D','50','13',NULL,'Address2',NULL,NULL,'"drvAddressLine2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EDISCCOBR3Z0','50','D','50','14',NULL,'City',NULL,NULL,'"drvAddressCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EDISCCOBR3Z0','50','D','50','15',NULL,'StateOrProvince',NULL,NULL,'"drvAddressState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EDISCCOBR3Z0','50','D','50','16',NULL,'PostalCode',NULL,NULL,'"drvAddressZipCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EDISCCOBR3Z0','50','D','50','17',NULL,'Country',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EDISCCOBR3Z0','50','D','50','18',NULL,'EnrollmentDate',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EDISCCOBR3Z0','50','D','50','19',NULL,'Sex',NULL,NULL,'"drvGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EDISCCOBR3Z0','50','D','50','20',NULL,'DOB',NULL,NULL,'"drvDateOfBirth"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EDISCCOBR3Z0','50','D','50','21',NULL,'IsQMCSO',NULL,NULL,'"drvISQMCO"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EDISCCOBR3Z0','50','D','60','1',NULL,'Record Identifier',NULL,NULL,'"[QBDEPENDENTPLANINITIAL]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EDISCCOBR3Z0','50','D','60','2',NULL,'PlanName',NULL,NULL,'"drvPlanName"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EDISCCOBR3Z0','50','D','70','1',NULL,'Record Identifier',NULL,NULL,'"[QBPLANMEMBERSPECIFICRATEINITIAL]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EDISCCOBR3Z0','50','D','70','2',NULL,'PlanName',NULL,NULL,'"drvPlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EDISCCOBR3Z0','50','D','70','3',NULL,'Rate',NULL,NULL,'"drvRate"','(''UA''=''T'')');

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\N1\Public\10691\Exports\Discovery\20210902_Agribeef_NPM_12805.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'New Plan Member Export','202108209','EMPEXPORT','NPMFILE','May  6 2021 12:00AM','EDISCCOBR3',NULL,NULL,NULL,'202108209','May  6 2021 12:00AM','Dec 30 1899 12:00AM','202108131','20','','','202108131',dbo.fn_GetTimedKey(),NULL,'ULTI_AGRI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\N1\Public\10691\Exports\Discovery\20210902_Agribeef_QB_12805.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Cobra Export','202108209','EMPEXPORT','QBFILE','May  6 2021 12:00AM','EDISCCOBR3',NULL,NULL,NULL,'202108209','May  6 2021 12:00AM','Dec 30 1899 12:00AM','202108131','52','','','202108131',dbo.fn_GetTimedKey(),NULL,'ULTI_AGRI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\N1\Public\10691\Exports\Discovery\TEST_20210902_Agribeef_NPM_12805.txt',NULL,NULL,NULL,'19HGP',NULL,NULL,NULL,'Test New Plan Member Export','202111041','EMPEXPORT','TESTNPM','Nov 23 2021 12:41PM','EDISCCOBR3',NULL,NULL,NULL,'202111041','Nov  4 2021 12:00AM','Dec 30 1899 12:00AM','202110011','1','','','202110011',dbo.fn_GetTimedKey(),NULL,'us3rVaAGR1002',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\N1\Public\10691\Exports\Discovery\TEST_20211222_Agribeef_QB_12805.txt',NULL,NULL,NULL,'19HGP',NULL,NULL,NULL,'Test Cobra Export','202112229','EMPEXPORT','TESTQB','Dec 22 2021  1:13PM','EDISCCOBR3',NULL,NULL,NULL,'202112229','Dec 22 2021 12:00AM','Dec 30 1899 12:00AM','202101011','16','','','202101011',dbo.fn_GetTimedKey(),NULL,'us3rVaAGR1002',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCCOBR3','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCCOBR3','ExportPath','V','\\us.saas\n0\data_exchange\AGR1002\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCCOBR3','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCCOBR3','SubSort2','C','drvSubSort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCCOBR3','SubSort3','C','drvSubSort3');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCCOBR3','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCCOBR3','TestPath','V','\\us.saas\n1\Public\10691\Exports\Discovery\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCCOBR3','UDESPath','C','\\us.saas\n0\data_exchange\AGR1002\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCCOBR3','UseFileName','V','N');

-----------
-- U_dsi_RecordSetDetails inserts
-----------

INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EDISCCOBR3','NPMFILE','H','02','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EDISCCOBR3','NPMFILE','D','20','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EDISCCOBR3','NPMFILE','D','30','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EDISCCOBR3','NPMFILE','D','40','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EDISCCOBR3','NPMFILE','D','50','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EDISCCOBR3','NPMFILE','D','60','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EDISCCOBR3','NPMFILE','D','70','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EDISCCOBR3','TESTNPM','H','02','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EDISCCOBR3','TESTNPM','D','20','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EDISCCOBR3','TESTNPM','D','30','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EDISCCOBR3','TESTNPM','D','40','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EDISCCOBR3','TESTNPM','D','50','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EDISCCOBR3','TESTNPM','D','60','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EDISCCOBR3','TESTNPM','D','70','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EDISCCOBR3','QBFILE','H','01','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EDISCCOBR3','QBFILE','D','10','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EDISCCOBR3','TESTQB','H','01','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EDISCCOBR3','TESTQB','D','10','Y','F');

-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCCOBR3','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCCOBR3','H02','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCCOBR3','D10','dbo.U_EDISCCOBR3_drvTbl_NPM WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCCOBR3','D20','dbo.U_EDISCCOBR3_drvTbl_QB WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCCOBR3','D30','dbo.U_EDISCCOBR3_drvTbl_QBEVENT WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCCOBR3','D40','dbo.U_EDISCCOBR3_drvTbl_QBPLAN WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCCOBR3','D50','dbo.U_EDISCCOBR3_drvTbl_QBDEP WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCCOBR3','D60','dbo.U_EDISCCOBR3_drvTbl_QBDEPPLAN WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCCOBR3','D70','dbo.U_EDISCCOBR3_drvTbl_QBMSRI WITH (NOLOCK)',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EDISCCOBR3
-----------

IF OBJECT_ID('U_dsi_BDM_EDISCCOBR3') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EDISCCOBR3] (
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
-- Create table U_EDISCCOBR3_drvTbl_NPM
-----------

IF OBJECT_ID('U_EDISCCOBR3_drvTbl_NPM') IS NULL
CREATE TABLE [dbo].[U_EDISCCOBR3_drvTbl_NPM] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvSSN] char(11) NULL,
    [drvEmpNo] char(9) NULL,
    [drvClientName] varchar(100) NULL,
    [drvClientDivName] varchar(50) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvAddressEMail] varchar(50) NULL,
    [drvPhoneHomeNumber] varchar(50) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvGender] char(1) NULL,
    [drvSubSort] char(11) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(1) NOT NULL
);

-----------
-- Create table U_EDISCCOBR3_drvTbl_QB
-----------

IF OBJECT_ID('U_EDISCCOBR3_drvTbl_QB') IS NULL
CREATE TABLE [dbo].[U_EDISCCOBR3_drvTbl_QB] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NOT NULL,
    [drvClientName] varchar(100) NULL,
    [drvClientDivName] varchar(50) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvSSN] char(11) NULL,
    [drvEmpNo] char(9) NULL,
    [drvAddressLine1] varchar(6000) NULL,
    [drvAddressLine2] varchar(6000) NULL,
    [drvAddressCity] varchar(6000) NULL,
    [drvAddressState] varchar(6000) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvGender] char(1) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvSubSort] char(11) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(208) NULL
);

-----------
-- Create table U_EDISCCOBR3_drvTbl_QBDEP
-----------

IF OBJECT_ID('U_EDISCCOBR3_drvTbl_QBDEP') IS NULL
CREATE TABLE [dbo].[U_EDISCCOBR3_drvTbl_QBDEP] (
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
    [drvSubSort] char(11) NULL,
    [drvSubSort2] varchar(13) NOT NULL,
    [drvSubSort3] varchar(208) NULL
);

-----------
-- Create table U_EDISCCOBR3_drvTbl_QBDEPPLAN
-----------

IF OBJECT_ID('U_EDISCCOBR3_drvTbl_QBDEPPLAN') IS NULL
CREATE TABLE [dbo].[U_EDISCCOBR3_drvTbl_QBDEPPLAN] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NULL,
    [drvDedCode] char(5) NULL,
    [drvPlanName] varchar(38) NULL,
    [drvSubSort] char(11) NULL,
    [drvSubSort2] varchar(13) NOT NULL,
    [drvSubSort3] varchar(208) NULL
);

-----------
-- Create table U_EDISCCOBR3_drvTbl_QBEVENT
-----------

IF OBJECT_ID('U_EDISCCOBR3_drvTbl_QBEVENT') IS NULL
CREATE TABLE [dbo].[U_EDISCCOBR3_drvTbl_QBEVENT] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NOT NULL,
    [drvEventType] varchar(29) NOT NULL,
    [drvEventDate] datetime NULL,
    [drvEnrollmentDate] datetime NULL,
    [drvSSN] char(11) NULL,
    [drvName] varchar(201) NULL,
    [drvSubSort] char(11) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(208) NULL
);

-----------
-- Create table U_EDISCCOBR3_drvTbl_QBMSRI
-----------

IF OBJECT_ID('U_EDISCCOBR3_drvTbl_QBMSRI') IS NULL
CREATE TABLE [dbo].[U_EDISCCOBR3_drvTbl_QBMSRI] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NOT NULL,
    [drvPlanName] varchar(38) NULL,
    [drvRate] money NULL,
    [drvSubSort] char(11) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(208) NULL
);

-----------
-- Create table U_EDISCCOBR3_drvTbl_QBPLAN
-----------

IF OBJECT_ID('U_EDISCCOBR3_drvTbl_QBPLAN') IS NULL
CREATE TABLE [dbo].[U_EDISCCOBR3_drvTbl_QBPLAN] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NOT NULL,
    [drvDedCode] char(5) NULL,
    [drvPlanName] varchar(38) NULL,
    [drvCoverageLevel] varchar(11) NULL,
    [eecpaygroup] char(6) NULL,
    [drvSubSort] char(11) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(208) NULL
);

-----------
-- Create table U_EDISCCOBR3_EEList
-----------

IF OBJECT_ID('U_EDISCCOBR3_EEList') IS NULL
CREATE TABLE [dbo].[U_EDISCCOBR3_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EDISCCOBR3_File
-----------

IF OBJECT_ID('U_EDISCCOBR3_File') IS NULL
CREATE TABLE [dbo].[U_EDISCCOBR3_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EDISCCOBR3]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Agri Beef Co.

Created By: Tanya Leonce
Business Analyst: Gail Yates
Create Date: 06/02/2016
Service Request Number: SR-2016-00121865

Purpose: Discovery Benefits Cobra Export TEST

Revision History
----------------
Update By            Date           Request Num        Desc
Sean Hawkins            12/16/2016    SR-2016-00139714    Updated for new 1/1/2017 plan names
Sean Hawkins            01/25/2017                        More updates after post-changes feedback
Kaitlyn Duesler            05/04/2021    SR-2021-00310467    Update to Plan Names

12/22/2021 by AP:
	- Changed client name and client division name for both NPM and QB records.

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EDISCCOBR3';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EDISCCOBR3';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EDISCCOBR3';
SELECT * FROM dbo.AscExp WHERE expFormatCode = 'EDISCCOBR3';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EDISCCOBR3' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISCCOBR3', 'NPMFILE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISCCOBR3', 'QBFILE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISCCOBR3', 'TESTNPM';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISCCOBR3', 'TESTQB';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EDISCCOBR3';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EDISCCOBR3', @AllObjects = 'Y', @IsWeb = 'N'
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
    SET @FormatCode = 'EDISCCOBR3';

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
    DELETE FROM dbo.U_EDISCCOBR3_EEList WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCoID(xEEID);

    IF @ExportCode LIKE '%NPM%'
    BEGIN
        --==========================================
        -- BDM Section for NPM
        --==========================================
        DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

        -- Required parameters
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'DedTypes','MED,DEN,VIS,FSA');
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'StartDateTime',@StartDate);
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'EndDateTime',@EndDate);
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'TermSelectionOption','AuditDate');

        -- NPM parameters
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RunID','NPM');
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','X'); -- DedIsCobraCovered = 'Y' for types listed above
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'NewEnrolleeType','2'); -- All new enrollees where no previous plan exists
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'TableType','EMP'); -- Only include employees on NPM file
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');

        -- Run BDM for NPM
        EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;
    END
    ELSE
    BEGIN
        --==========================================
        -- BDM Section for QB
        --==========================================
        DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

        -- Required parameters
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'DedTypes','MED,DEN,VIS,FSA');
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'DedTypesDep','MED,DEN,VIS'); -- Exclude FSA Types for deps
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'StartDateTime',@StartDate);
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'EndDateTime',@EndDate);
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'TermSelectionOption','AuditDate');

        -- COBRA parameters
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RunID','QB');
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','X'); -- DedIsCobraCovered = 'Y' for types listed above
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraType','2'); -- EdhChangeReason and ConCobraReason
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraDate','2'); -- EedBenStopDate and DbnBenStopDate
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraPQBType','1'); -- If no EE or spouse, ALL children are PQB (not just oldest)
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidCobraReasonsEmp','210'); -- Invalidate employee when Cobra Reason is "Death"
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidTermReasonsEmp','203'); -- Invalidate employee when Termination Reason is "Death"
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS');
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL,STC');
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');

        -- Run BDM for QB
        EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;
    END;

    --==========================================
    -- Build driver tables
    --==========================================
    IF @ExportCode LIKE '%NPM%'
    BEGIN
        ------------------
        -- DETAIL RECORD - NPM Record
        ------------------
        IF OBJECT_ID('U_EDISCCOBR3_drvTbl_NPM') IS NOT NULL
            DROP TABLE dbo.U_EDISCCOBR3_drvTbl_NPM;
        SELECT DISTINCT
             drvEEID            = BdmEEID
            ,drvCoID            = BdmCoID
            ,drvSSN             = eepSSN
            ,drvEmpNo           = EecEmpNo
            ,drvClientName      = CASE WHEN EecPayGroup = 'SSIF' THEN 'SSI Foods LLC 40823' ELSE 'Agribeef 12805' END
			--CONVERT(varchar(100),'Agribeef 12805')
            ,drvClientDivName   = CASE WHEN EecPayGroup = 'SSIF' THEN 'SSI Foods LLC' ELSE 'Agri Beef Co.' END
			--CONVERT(varchar(50),
   --                               CASE EecPayGroup
   --                                     WHEN 'NSTAR' THEN 'Agron Bioenergy'
   --                                     WHEN 'ABFDI' THEN 'AB Foods'
   --                                     WHEN 'ABFDW' THEN 'AB Foods'
   --                                     WHEN 'ABMGT' THEN 'Agri Beef Co.'
   --                                     WHEN 'BVFDR' THEN 'Boise Valley Feeders'
   --                                     WHEN 'MLDIV' THEN 'Moses Lake Feedyards'
   --                                     WHEN 'PNSYS' THEN 'Performix'
   --                                     WHEN 'SRCTL' THEN 'Snake River Cattle'
   --                                     WHEN 'BEEFN' THEN 'Wash Beef Non-Union'
   --                                     WHEN 'BEEFU' THEN 'Wash Beef Union'
   --                                     WHEN 'DBLRR' THEN 'Double R Ranch'
   --                                     WHEN 'DHFDR' THEN 'DH Feeders'
   --                               END)
            ,drvNameFirst       = EepNameFirst
            ,drvNameMiddle      = LEFT(EepNameMiddle,1)
            ,drvNameLast        = EepNameLast
            ,drvAddressEMail    = eepAddressEMail
            ,drvPhoneHomeNumber = EepPhoneHomeNumber
            ,drvAddressLine1    = EepAddressLine1
            ,drvAddressLine2    = EepAddressLine2
            ,drvAddressCity     = EepAddressCity
            ,drvAddressState    = EepAddressState
            ,drvAddressZipCode  = EepAddressZipCode
            ,drvGender          = EepGender
            ,drvSubSort         = eepSSN
            ,drvSubSort2        = ''
            ,drvSubSort3        = ''
        INTO dbo.U_EDISCCOBR3_drvTbl_NPM
        FROM dbo.U_dsi_BDM_EDISCCOBR3 WITH (NOLOCK)
        JOIN dbo.EmpComp WITH (NOLOCK)
            ON EecEEID = BdmEEID
            AND EecCoID = BdmCoID
        JOIN dbo.EmpPers WITH (NOLOCK)
            ON EepEEID = BdmEEID;
    END
    ELSE
    BEGIN
        ------------------
        -- QB DETAIL RECORD
        ------------------
        IF OBJECT_ID('U_EDISCCOBR3_drvTbl_QB') IS NOT NULL
            DROP TABLE dbo.U_EDISCCOBR3_drvTbl_QB;
        SELECT DISTINCT
             drvEEID           = BdmEEID
            ,drvCoID           = BdmCoID
            ,drvDepRecID       = ISNULL(BdmDepRecID,'')
            ,drvClientName     = CASE WHEN EecPayGroup = 'SSIF' THEN 'SSI Foods LLC 40823' ELSE 'Agribeef 12805' END
			--CONVERT(varchar(100),'Agribeef 12805')
            ,drvClientDivName  = CASE WHEN EecPayGroup = 'SSIF' THEN 'SSI Foods LLC' ELSE 'Agri Beef Co.' END
			--CONVERT(varchar(50),
   --                              CASE EecPayGroup
   --                                     WHEN 'NSTAR' THEN 'Agron Bioenergy'
   --                                     WHEN 'ABFDI' THEN 'AB Foods'
   --                                     WHEN 'ABFDW' THEN 'AB Foods'
   --                                     WHEN 'ABMGT' THEN 'Agri Beef Co.'
   --                                     WHEN 'BVFDR' THEN 'Boise Valley Feeders'
   --                                     WHEN 'MLDIV' THEN 'Moses Lake Feedyards'
   --                                     WHEN 'PNSYS' THEN 'Performix'
   --                                     WHEN 'SRCTL' THEN 'Snake River Cattle'
   --                                     WHEN 'BEEFN' THEN 'Wash Beef Non-Union'
   --                                     WHEN 'BEEFU' THEN 'Wash Beef Union'
   --                                     WHEN 'DBLRR' THEN 'Double R Ranch'
   --                                     WHEN 'DHFDR' THEN 'DH Feeders'
   --                              END)
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
            ,drvAddressLine1   = dbo.fn_RemoveSpecialChars(
                                 CASE WHEN BdmRecType = 'EMP' THEN EepAddressLine1
                                      ELSE ConAddressLine1
                                 END)
            ,drvAddressLine2   = dbo.fn_RemoveSpecialChars(
                                 CASE WHEN BdmRecType = 'EMP' THEN EepAddressLine2
                                      ELSE ConAddressLine2
                                 END)
            ,drvAddressCity    = dbo.fn_RemoveSpecialChars(
                                 CASE WHEN BdmRecType = 'EMP' THEN EepAddressCity
                                      ELSE ConAddressCity
                                 END)
            ,drvAddressState   = dbo.fn_RemoveSpecialChars(
                                 CASE WHEN BdmRecType = 'EMP' THEN EepAddressState
                                      ELSE ConAddressState
                                 END)
            ,drvAddressZipCode = CASE WHEN BdmRecType = 'EMP' THEN EepAddressZipCode
                                      ELSE ConAddressZipCode
                                 END
            ,drvGender         = CASE WHEN BdmRecType = 'EMP' THEN EepGender
                                      ELSE ConGender
                                 END
            ,drvDateOfBirth    = CASE WHEN BdmRecType = 'EMP' THEN EepDateOfBirth
                                      ELSE ConDateOfBirth
                                 END
            ,drvSubSort        = eepSSN
            ,drvSubSort2       = '1'
            ,drvSubSort3       = CASE WHEN BdmRecType = 'EMP' THEN '2'
                                      ELSE CONVERT(char(8),ConDateOfBirth,112) + RTRIM(ConNameLast) + ConNameFirst
                                 END
        INTO dbo.U_EDISCCOBR3_drvTbl_QB
        FROM dbo.U_dsi_BDM_EDISCCOBR3 WITH (NOLOCK)
        JOIN dbo.EmpComp WITH (NOLOCK)
            ON EecEEID = BdmEEID
            AND EecCoID = BdmCoID
        JOIN dbo.EmpPers WITH (NOLOCK)
            ON EepEEID = BdmEEID
        LEFT JOIN dbo.Contacts WITH (NOLOCK)
            ON ConEEID = BdmEEID
            AND ConSystemID = BdmDepRecID
        WHERE BdmIsPQB = 'Y';

        ------------------
        -- QBEVENT DETAIL RECORD
        ------------------
        IF OBJECT_ID('U_EDISCCOBR3_drvTbl_QBEVENT') IS NOT NULL
            DROP TABLE dbo.U_EDISCCOBR3_drvTbl_QBEVENT;
        SELECT DISTINCT
             drvEEID           = drvEEID
            ,drvCoID           = drvCoID
            ,drvDepRecID       = drvDepRecID
            ,drvEventType      = CASE WHEN BdmCobraReason IN ('201','LEVNT3') THEN 'INELIGIBLEDEPENDENT'
                                      WHEN BdmCobraReason IN ('202','CHGRP') THEN 'LOSSOFELIGIBILITY'
                                      WHEN BdmCobraReason = '203' THEN 'REDUCTIONINHOURS-STATUSCHANGE'
                                      WHEN BdmCobraReason IN ('204','LEVNT4') THEN 'DIVORCELEGALSEPARATION'
                                      WHEN BdmCobraReason = '205' THEN 'MEDICARE'
                                      WHEN BdmCobraReason = '206' THEN 'REDUCTIONINHOURS-ENDOFLEAVE'
                                      WHEN BdmCobraReason = '207' THEN 'USERRA-REDUCTIONINHOURS'
                                      WHEN BdmCobraReason = '208' THEN 'RETIREMENT'
                                      WHEN BdmCobraReason = '209' THEN 'WORKSTOPPAGE'
                                      WHEN BdmCobraReason = '210' THEN 'DEATH'
                                      WHEN EecTermReason = '202' THEN 'RETIREMENT'
                                      WHEN EecTermReason = '203' THEN 'DEATH'
                                      ELSE 'TERMINATION'
                                 END
            ,drvEventDate      = BdmBenStopDate
            ,drvEnrollmentDate = BdmBenStartDate
            ,drvSSN            = eepSSN
            ,drvName           = CASE WHEN BdmRecType = 'DEP' THEN RTRIM(EepNameFirst) + ' ' + EepNameLast
                                      ELSE ''
                                 END
            ,drvSubSort        = drvSubSort
            ,drvSubSort2       = '1'
            ,drvSubSort3       = drvSubSort3
        INTO dbo.U_EDISCCOBR3_drvTbl_QBEVENT
        FROM dbo.U_EDISCCOBR3_drvTbl_QB WITH (NOLOCK)
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
                ,BdmBenStopDate = MAX(BdmBenStopDate)
                ,BdmUSGDate1 = MAX(BdmUSGDate1)
              FROM dbo.U_dsi_BDM_EDISCCOBR3 WITH (NOLOCK)
              WHERE BdmIsPQB = 'Y'
              GROUP BY BdmEEID, BdmCoID, BdmDepRecID, BdmRecType
        ) BDM
            ON BdmEEID = drvEEID
            AND BdmCoID = drvCoID
            AND ISNULL(BdmDepRecID,'') = drvDepRecID;

        ------------------
        -- QBPLANINITIAL DETAIL RECORD
        --selecT * from U_EDISCCOBR3_drvTbl_QBPLAN
        ------------------
        IF OBJECT_ID('U_EDISCCOBR3_drvTbl_QBPLAN') IS NOT NULL
            DROP TABLE dbo.U_EDISCCOBR3_drvTbl_QBPLAN;
        SELECT DISTINCT
             drvEEID          = drvEEID
            ,drvCoID          = drvCoID
            ,drvDepRecID      = drvDepRecID
            ,drvDedCode       = BdmDedCode
            ,drvPlanName      = CASE
                -- Dental
                --WHEN BdmDedCode IN ('DENAF','DENPT','DENSH') AND EecPayGroup IN ('ABFDI','ABFDW') THEN 'Delta Dental ID AB Foods'
                --WHEN BdmDedCode IN ('DENAF','DENPT','DENSH') AND EecPayGroup IN ('ABMGT','TVGR') THEN 'Delta Dental ID Corporate'
                --WHEN BdmDedCode IN ('DENAF','DENPT','DENSH') AND EecPayGroup IN ('BVFDR') THEN 'Delta Dental ID Boise Valley Feeders'
                --WHEN BdmDedCode IN ('DENAF','DENPT','DENSH') AND EecPayGroup IN ('DBLRR') THEN 'Delta Dental ID RR Ranch'
                --WHEN BdmDedCode IN ('DENAF','DENPT','DENSH') AND EecPayGroup IN ('MLDIV') THEN 'Delta Dental ID El Oro Cattle'
                --WHEN BdmDedCode IN ('DENAF','DENPT','DENSH') AND EecPayGroup IN ('PNSYS') THEN 'Delta Dental ID Performix'
                --WHEN BdmDedCode IN ('DENAF','DENPT','DENSH') AND EecPayGroup IN ('SRCTL') THEN 'Delta Dental ID Snake River Cattle'
                --WHEN BdmDedCode IN ('DENAF','DENPT','DENSH') AND EecPayGroup IN ('BEEFN') THEN 'Delta Dental ID Washington Beef Non Union'
                --WHEN BdmDedCode IN ('UNDNP') AND EecPayGroup IN ('BEEFU') THEN 'Delta Dental ID Washington Beef Union'
                --WHEN BdmDedCode IN ('DENAF','DENPT','DENSH') AND EecPayGroup IN ('TWBF') THEN 'Delta Dental ID True West Beef'
                ---- Vision
                --WHEN BdmDedCode IN ('VSION') AND EecPayGroup IN ('ABFDI','ABFDW') THEN 'VSP Vision AB Foods'
                --WHEN BdmDedCode IN ('VSION') AND EecPayGroup IN ('ABMGT', 'TVGR') THEN 'VSP Vision Agri Beef'
                --WHEN BdmDedCode IN ('VSION') AND EecPayGroup IN ('BVFDR') THEN 'VSP Vision Boise Valley Feeders'
                --WHEN BdmDedCode IN ('VSION') AND EecPayGroup IN ('DBLRR') THEN 'VSP Vision Double R Ranch'
                --WHEN BdmDedCode IN ('VSION') AND EecPayGroup IN ('MLDIV') THEN 'VSP Vision Moses Lake Feeders'
                --WHEN BdmDedCode IN ('VSION') AND EecPayGroup IN ('PNSYS') THEN 'VSP Vision Performix'
                --WHEN BdmDedCode IN ('VSION') AND EecPayGroup IN ('SRCTL') THEN 'VSP Vision Snake River Cattle'
                --WHEN BdmDedCode IN ('VSION') AND EecPayGroup IN ('BEEFN') THEN 'VSP Vision Washington Beef Non Union'
                --WHEN BdmDedCode IN ('UVISO') AND EecPayGroup IN ('BEEFU') THEN 'VSP Vision Washington Beef Union'
                --WHEN BdmDedCode IN ('VSION') AND EecPayGroup IN ('TWBF') THEN 'VSP Vision True West Beef'
                --WHEN BdmDedCode IN ('VSNSS') AND EecPayGroup IN ('SSIF') THEN ' Vision SSI Foods'
                ----Medical (PPO)
                --WHEN BdmDedCode IN ('MEDPT', 'MEDSH', 'MEDAF') AND EecPayGroup IN ('ABFDI','ABFDW') THEN 'Regence Med AB Foods PPO'
                --WHEN BdmDedCode IN ('MEDPT', 'MEDSH', 'MEDAF') AND EecPayGroup IN ('ABMGT', 'TVGR') THEN 'Regence Med Corporate PPO'
                --WHEN BdmDedCode IN ('MEDPT') AND EecPayGroup IN ('BVFDR') THEN 'Regence Med Boise Valley Feeders PPO'
                --WHEN BdmDedCode IN ('MEDPT') AND EecPayGroup IN ('DBLRR') THEN 'Regence Med Double R Ranch PPO'
                --WHEN BdmDedCode IN ('MEDPT') AND EecPayGroup IN ('MLDIV') THEN 'Regence Med El Oro Cattle PPO'
                --WHEN BdmDedCode IN ('MEDPT') AND EecPayGroup IN ('PNSYS') THEN 'Regence Med Performix PPO'
                --WHEN BdmDedCode IN ('MEDPT') AND EecPayGroup IN ('SRCTL') THEN 'Regence Med Snake River Cattle PPO'
                --WHEN BdmDedCode IN ('MEDPT') AND EecPayGroup IN ('BEEFN') THEN 'Regence Med Washington Beef PPO'
                --WHEN BdmDedCode IN ('UNMDP') AND EecPayGroup IN ('BEEFU') THEN 'Regence Med Washington Beef Union PPO'
                --WHEN BdmDedCode IN ('MEDPT') AND EecPayGroup IN ('TWBF') THEN 'Regence Med True West Beef PPO'
                --WHEN BdmDedCode IN ('MEDSS') AND EecPayGroup IN ('SSIF') THEN 'Medical SSI Foods'
                ---- Medical (HDHP)
                --WHEN BdmDedCode IN ('MEDHD') AND EecPayGroup IN ('ABFDI','ABFDW') THEN 'Regence Med AB Foods HSA'
                --WHEN BdmDedCode IN ('MEDHD') AND EecPayGroup IN ('ABMGT', 'TVGR') THEN 'Regence Med Corporate HSA'
                --WHEN BdmDedCode IN ('MEDHD') AND EecPayGroup IN ('BVFDR') THEN 'Regence Med Boise Valley Feeders HSA'
                --WHEN BdmDedCode IN ('MEDHD') AND EecPayGroup IN ('DBLRR') THEN 'Regence Med Double R Ranch HSA'
                --WHEN BdmDedCode IN ('MEDHD') AND EecPayGroup IN ('MLDIV') THEN 'Regence Med El Oro Cattle HSA'
                --WHEN BdmDedCode IN ('MEDHD') AND EecPayGroup IN ('PNSYS') THEN 'Regence Med Performix HSA'
                --WHEN BdmDedCode IN ('MEDHD') AND EecPayGroup IN ('SRCTL') THEN 'Regence Med Snake River Cattle HSA'
                --WHEN BdmDedCode IN ('MEDHD') AND EecPayGroup IN ('BEEFN') THEN 'Regence Med Washington Beef HSA'
                --WHEN BdmDedCode IN ('MEDHD') AND EecPayGroup IN ('TWBF') THEN 'Regence Med True West Beef HSA'
                ---- FSA
                --WHEN BdmDedCode IN ('FSAMD', 'FSMUN') THEN 'Discovery Benefits Medical FSA (Event)'


                ----Added Replaced 8/26 LL
                --WHEN BdmDedCode IN ('DENPT, DENAF') AND EecPayGroup IN ('MLDIV, DHFDR') THEN 'Delta Dental ID El Oro Cattle'
                --WHEN BdmDedCode IN ('FSAMD') AND EecPayGroup IN ('MLDIV, DHFDR') THEN 'Discovery Benefits Medical FSA (Event)'
                --WHEN BdmDedCode IN ('MEDHD') AND EecPayGroup IN ('MLDIV, DHFDR') THEN 'Regence Med El Oro Cattle HSA'
                --WHEN BdmDedCode IN ('MEDPT') AND EecPayGroup IN ('MLDIV, DHFDR') THEN 'Regence Med El Oro Cattle PPO'
                --WHEN BdmDedCode IN ('VSION') AND EecPayGroup IN ('MLDIV, DHFDR') THEN 'VSP Vision Moses Lake Feeders'
                --WHEN BdmDedCode IN ('DENPT, DENAF') AND EecPayGroup IN ('TWBF') THEN 'Delta Dental ID True West Beef'
                --WHEN BdmDedCode IN ('FSAMD') AND EecPayGroup IN ('TWBF') THEN 'Discovery Benefits Medical FSA (Event)'
                --WHEN BdmDedCode IN ('MEDHD') AND EecPayGroup IN ('TWBF') THEN 'Regence Med True West Beef HSA'
                --WHEN BdmDedCode IN ('MEDPT') AND EecPayGroup IN ('TWBF') THEN 'Regence Med True West Beef PPO'
                --WHEN BdmDedCode IN ('VSION') AND EecPayGroup IN ('TWBF') THEN 'VSP Vision True West Beef'

                -- Additions
                WHEN EecPayGroup = 'SSIF' AND BdmDedCode IN ('DENPT', 'DENAF') THEN 'UHC Dental'
                WHEN EecPayGroup = 'SSIF' AND BdmDedCode IN ('MEDHD', 'MEDPT') THEN 'UHC Medical'
                WHEN EecPayGroup = 'SSIF' AND BdmDedCode IN ('VSION') THEN 'VSP Vision'
                WHEN EecPayGroup IN ('MLDIV', 'DHFDR') AND BdmDedCode IN ('DENPT', 'DENAF') THEN 'Delta Dental ID El Oro Cattle'
                WHEN EecPayGroup IN ('MLDIV', 'DHFDR') AND BdmDedCode = 'FSAMD' THEN 'Discovery Benefits Medical FSA (Event)'
                WHEN EecPayGroup IN ('MLDIV', 'DHFDR') AND BdmDedCode = 'MEDHD' THEN 'Regence Med El Oro Cattle HSA'
                WHEN EecPayGroup IN ('MLDIV', 'DHFDR') AND BdmDedCode = 'MEDPT' THEN 'Regence Med El Oro Cattle PPO'
                WHEN EecPayGroup IN ('MLDIV', 'DHFDR') AND BdmDedCode = 'VSION' THEN 'VSP Vision Moses Lake Feeders'
                WHEN EecPayGroup IN ('TWBF') AND BdmDedCode IN ('DENPT', 'DENAF') THEN 'Delta Dental ID True West Beef'
                WHEN EecPayGroup IN ('TWBF') AND BdmDedCode IN ('FSAMD') THEN 'Discovery Benefits Medical FSA (Event)'
                WHEN EecPayGroup IN ('TWBF') AND BdmDedCode IN ('MEDHD') THEN 'Regence Med True West Beef HSA'
                WHEN EecPayGroup IN ('TWBF') AND BdmDedCode IN ('MEDPT') THEN 'Regence Med True West Beef PPO'
                WHEN EecPayGroup IN ('TWBF') AND BdmDedCode IN ('VSIOB') THEN 'VSP Vision True West Beef'


                END
                

            /*5/4/21 KD replaced below with above        
            CONVERT(varchar(50),
                                CASE BdmDedCode
                                    WHEN 'DENAF' THEN 'Delta Dental Insurance (Non-Union)'
                                    WHEN 'DENPT' THEN 'Delta Dental Insurance (Non-Union)'
                                    WHEN 'DENSH' THEN 'Delta Dental Insurance (Non-Union)'
                                    WHEN 'UNDNP' THEN 'Delta Dental Insurance (Union)'
                                    WHEN 'FSAMD' THEN 'Discovery Benefits Medical FSA (Event)'
                                    WHEN 'UVISO' THEN 'VSP Vision'
                                    WHEN 'VSION' THEN 'VSP Vision'
                                    WHEN 'MEDAF' THEN 'BCBS ID Medical (Non-Union) Corporate'
                                    WHEN 'MEDAG' THEN 'BCBS ID Medical HDHP Agron Bioenergy'
                                    --WHEN 'MEDHD' THEN 'BCBS ID Medical HDHP'
                                    WHEN 'UNMDP' THEN 'BCBS ID Medical Insurance (Union)'
                                    WHEN 'MEDAS' THEN 'BCBS ID Medical HDHP Agron Bioenergy'
                                    WHEN 'MEDSH' THEN 'BCBS ID Medical (Non-Union) Corporate'
                                    WHEN 'MEDPT' THEN
                                    --select pgrpaygroup, pgrdesc,pgrchargedate from paygroup order by pgrdesc
                                        CASE EecPayGroup
                                            WHEN 'BVFDR' THEN 'Regence Medical Boise Valley Feeders PPO'--new 12/16/16 --HSA? 'BCBS ID Medical (Non-Union) Boise Valley Feeders'
                                            WHEN 'ABMGT' THEN 'Regence Medical AB Management PPO'--new 12/16/16 --'BCBS ID Medical (Non-Union) Corporate'
                                            WHEN 'MLDIV' THEN 'Regence Medical El Oro Cattle Feeders PPO'--new 12/16/16 --HSA?'BCBS ID Medical (Non-Union) Moses Lake Feedyards'
                                            WHEN 'PNSYS' THEN 'Regence Medical PerforMix HSA'--new 12/16/16 --'BCBS ID Medical (Non-Union) Performix'
                                            WHEN 'SRCTL' THEN 'Regence Medical Snake River Cattle PPO'--new 12/16/16 --HSA?'BCBS ID Medical (Non-Union) Snake River Cattle'
                                            WHEN 'ABFDI' THEN 'Regence Medical AB Foods PPO'--'AB Foods PPO'--new 12/16/16 --'BCBS ID Medical (Non-Union) AB Foods'
                                            WHEN 'ABFDW' THEN 'Regence Medical AB Foods PPO'--'AB Foods PPO'--new 12/16/16 --'BCBS ID Medical (Non-Union) AB Foods'
                                            WHEN 'BEEFN' THEN 'Washington Beef PPO'--new 12/16/16 --HSA?'BCBS ID Medical (Non-Union) Wash Beef'
                                            WHEN 'DBLRR' THEN 'Regence Medical Double R Ranch PPO'--new 12/16/16 --HSA?'BCBS ID Medical (Non-Union) Double R Ranch'
                                            WHEN 'NSTAR' THEN 'Agron HSA'--new 12/16/16
                                            WHEN 'BEEFU' THEN 'Regence Medical Washington Beef PPO'--new 12/16/16
                                        END
                                    WHEN 'MEDHD' THEN
                                        CASE EecPayGroup
                                            WHEN 'BVFDR' THEN 'Regence Medical Boise Valley Feeders PPO'--new 12/16/16 --HSA? 'BCBS ID Medical (Non-Union) Boise Valley Feeders'
                                            WHEN 'ABMGT' THEN 'Regence Medical AB Management HSA'--new 12/16/16 --'BCBS ID Medical (Non-Union) Corporate'
                                            WHEN 'MLDIV' THEN 'Regence Medical El Oro Cattle Feeders PPO'--new 12/16/16 --HSA?'BCBS ID Medical (Non-Union) Moses Lake Feedyards'
                                            WHEN 'PNSYS' THEN 'Regence Medical PerforMix HSA'--new 12/16/16 --'BCBS ID Medical (Non-Union) Performix'
                                            WHEN 'SRCTL' THEN 'Regence Medical Snake River Cattle PPO'--new 12/16/16 --HSA?'BCBS ID Medical (Non-Union) Snake River Cattle'
                                            WHEN 'ABFDI' THEN 'Regence Medical AB Foods HSA'--'AB Foods PPO'--new 12/16/16 --'BCBS ID Medical (Non-Union) AB Foods'
                                            WHEN 'ABFDW' THEN 'Regence Medical AB Foods HSA'--'AB Foods PPO'--new 12/16/16 --'BCBS ID Medical (Non-Union) AB Foods'
                                            WHEN 'BEEFN' THEN 'Washington Beef PPO'--new 12/16/16 --HSA?'BCBS ID Medical (Non-Union) Wash Beef'
                                            WHEN 'DBLRR' THEN 'Regence Medical Double R Ranch PPO'--new 12/16/16 --HSA?'BCBS ID Medical (Non-Union) Double R Ranch'
                                            WHEN 'NSTAR' THEN 'Agron HSA'--new 12/16/16
                                            WHEN 'BEEFU' THEN 'Regence Medical Washington Beef PPO'--new 12/16/16
                                        end
                                END)*/
            ,drvCoverageLevel = CASE WHEN BdmDedType = 'FSA' THEN 'EE'
                                     WHEN BdmRecType = 'EMP' THEN
                                          CASE WHEN BdmBenOption IN ('EEONLY','SHARE1') THEN 'EE'
                                               WHEN BdmBenOption IN ('EEONE','SHARE2') THEN 'EE+1'
                                               WHEN BdmBenOption IN ('EESPOU') THEN 'EE+SPOUSE'
                                               WHEN BdmBenOption IN ('EECHIL') THEN 'EE+CHILDREN'
                                               WHEN BdmBenOption IN ('FAMILY','SHARE3') THEN 'EE+FAMILY'
                                          END
                                     WHEN BdmRelationship IN ('SPS') THEN
                                          CASE WHEN NdpNumDeps = 1 THEN
                                                    CASE
                                                        WHEN BdmDedType = 'DEN' THEN 'EE+1'
                                                        WHEN BdmDedType IN ('MED','VIS') THEN 'EE+CHILDREN' 
                                                    END
                                               WHEN NdpNumDeps > 1 THEN 'EE+FAMILY'
                                               ELSE 'EE'
                                          END
                                     ELSE 'EE'
                                END
            ,eecpaygroup
            ,drvSubSort       = drvSubSort
            ,drvSubSort2      = '1'
            ,drvSubSort3      = drvSubSort3
        INTO dbo.U_EDISCCOBR3_drvTbl_QBPLAN
        FROM dbo.U_EDISCCOBR3_drvTbl_QB WITH (NOLOCK)
        JOIN dbo.EmpComp WITH (NOLOCK)
            ON EecEEID = DrvEEID
            AND EecCOID = DrvCOID
        JOIN dbo.U_dsi_BDM_EDISCCOBR3 WITH (NOLOCK)
            ON BdmEEID = drvEEID
            AND BdmCoID = drvCoID
            AND ISNULL(BdmDepRecID,'') = drvDepRecID
        LEFT JOIN (SELECT  NdpEEID    = BdmEEID
                          ,NdpNumDeps = COUNT(1)
                   FROM (SELECT DISTINCT BdmEEID, BdmDepRecID
                         FROM dbo.U_dsi_BDM_EDISCCOBR3 WITH (NOLOCK)
                         WHERE BdmIsPQB = 'N'
                   ) NDEP
                   GROUP BY BdmEEID
        ) NDP
            ON NdpEEID = BdmEEID
        WHERE BdmIsPQB = 'Y';

        -- 5/4/21 KD removed below
        --move updates for plan names 1/25/2017 per Agri Beef:
        --selecT * from U_EDISCCOBR3_drvTbl_QBPLAN
        --select pgrpaygroup, pgrdesc,pgrchargedate from paygroup order by pgrdesc
        --update dbo.U_EDISCCOBR3_drvTbl_QBPLAN
        --set drvplanname = case
        --when drvdedcode = 'MEDHD' and eecpaygroup = 'BVFDR' then 'Regence Medical Boise Valley Feeders HSA'
        --when drvdedcode in ('MEDAG','MEDAS')and eecpaygroup = 'NSTAR' then 'Regence Medical Agron HSA'
        --when drvdedcode = 'MEDHD' and eecpaygroup = 'DBLRR' then 'Regence Medical Double R Ranch HSA'
        --when drvdedcode = 'MEDHD' and eecpaygroup = 'MLDIV' then 'Regence Medical El Oro Cattle Feeders HSA'
        --when drvdedcode = 'MEDHD' and eecpaygroup = 'PNSYS' then 'Regence Medical PerforMix HSA'
        --when drvdedcode = 'MEDHD' and eecpaygroup = 'SRCTL' then 'Regence Medical Snake River Cattle HSA'
        --when drvdedcode = 'MEDHD' and eecpaygroup = 'BEEFN' then 'Regence Medical Washington Beef HSA'
        --when drvdedcode = 'UNMDP' and eecpaygroup = 'BEEFU' then 'Regence Medical Washington Beef Union PPO'
        --when drvdedcode = 'MEDPT' and eecpaygroup IN('ABFDI','ABFDW') then 'Regence Medical AB Foods PPO'
        --when drvdedcode in ('MEDPT','MEDAF','MEDSH') and eecpaygroup = 'ABMGT' then 'Regence Medical AB Management PPO'
        --when drvdedcode = 'MEDHD' and eecpaygroup = 'ABMGT' then 'Regence Medical AB Management HSA'
        --when drvdedcode = 'MEDPT' and eecpaygroup ='BVFDR' then 'Regence Medical Boise Valley Feeders PPO'
        --when drvdedcode = 'MEDPT' and eecpaygroup = 'DBLRR' then 'Regence Medical Double R Ranch PPO'
        --when drvdedcode = 'MEDPT' and eecpaygroup = 'MLDIV' then 'Regence Medical El Oro Cattle Feeders PPO'
        --when drvdedcode = 'MEDPT' and eecpaygroup = 'PNSYS' then 'Regence Medical PerforMix PPO'
        --when drvdedcode = 'MEDPT' and eecpaygroup = 'SRCTL' then 'Regence Medical Snake River Cattle PPO'
        --when drvdedcode = 'MEDPT' and eecpaygroup = 'BEEFN' then 'Regence Medical Washington Beef PPO'
        --else drvplanname
        --end

        ------------------
        -- QBDEPENDENT DETAIL RECORD
        ------------------
        IF OBJECT_ID('U_EDISCCOBR3_drvTbl_QBDEP') IS NOT NULL
            DROP TABLE dbo.U_EDISCCOBR3_drvTbl_QBDEP;
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
            ,drvIsAddressSame  = CASE WHEN ConAddressIsDifferent = 'N' THEN 'TRUE'
                                      ELSE 'FALSE'
                                 END
            ,drvAddressLine1   = ConAddressLine1
            ,drvAddressLine2   = ConAddressLine2
            ,drvAddressCity    = ConAddressCity
            ,drvAddressState   = ConAddressState
            ,drvAddressZipCode = ConAddressZipCode
            ,drvGender         = ConGender
            ,drvDateOfBirth    = ConDateOfBirth
            ,drvISQMCO         = 'FALSE'
            ,drvSubSort        = drvSubSort
            ,drvSubSort2       = '2' + CASE WHEN BdmRelationship IN ('SPS') THEN 'A'
                                            ELSE 'B' + ISNULL(ConSSN,'')
                                       END
            ,drvSubSort3       = drvSubSort3
        INTO dbo.U_EDISCCOBR3_drvTbl_QBDEP
        FROM dbo.U_EDISCCOBR3_drvTbl_QB WITH (NOLOCK)
        JOIN dbo.U_dsi_BDM_EDISCCOBR3 WITH (NOLOCK)
            ON BdmEEID = drvEEID
            AND BdmCoID = drvCoID
        JOIN dbo.Contacts WITH (NOLOCK)
            ON ConEEID = BdmEEID
            AND ConSystemID = BdmDepRecID
        WHERE BdmIsPQB = 'N';

        ------------------
        -- QBDEPENDENTPLANINITIAL DETAIL RECORD
        ------------------
        IF OBJECT_ID('U_EDISCCOBR3_drvTbl_QBDEPPLAN') IS NOT NULL
            DROP TABLE dbo.U_EDISCCOBR3_drvTbl_QBDEPPLAN;
        SELECT DISTINCT
             drvEEID     = BdmEEID
            ,drvCoID     = BdmCoID
            ,drvDepRecID = BdmDepRecID
            ,drvDedCode  = BdmDedCode
            ,drvPlanName = drvPlanName
            ,drvSubSort  = drvSubSort
            ,drvSubSort2 = '2' + CASE WHEN BdmRelationship IN ('SPS') THEN 'A'
                                      ELSE 'B' + ISNULL(ConSSN,'')
                                 END
            ,drvSubSort3 = drvSubSort3
        INTO dbo.U_EDISCCOBR3_drvTbl_QBDEPPLAN
        FROM dbo.U_EDISCCOBR3_drvTbl_QBPLAN WITH (NOLOCK)
        JOIN dbo.U_dsi_BDM_EDISCCOBR3 WITH (NOLOCK)
            ON BdmEEID = drvEEID
            AND BdmCoID = drvCoID
            AND BdmDedCode = drvDedCode
        JOIN dbo.Contacts WITH (NOLOCK)
            ON ConEEID = BdmEEID
            AND ConSystemID = BdmDepRecID
        WHERE BdmIsPQB = 'N'
        AND drvCoverageLevel <> 'EE';

        ------------------
        -- QBPLANMEMBERSPECIFICRATEINITIAL DETAIL RECORD
        ------------------
        IF OBJECT_ID('U_EDISCCOBR3_drvTbl_QBMSRI') IS NOT NULL
            DROP TABLE dbo.U_EDISCCOBR3_drvTbl_QBMSRI;
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
        INTO dbo.U_EDISCCOBR3_drvTbl_QBMSRI
        FROM dbo.U_EDISCCOBR3_drvTbl_QBPLAN WITH (NOLOCK)
        JOIN dbo.U_dsi_BDM_EDISCCOBR3 WITH (NOLOCK)
            ON BdmEEID = drvEEID
            AND BdmCoID = drvCoID
            AND ISNULL(BdmDepRecID,'') = drvDepRecID
            AND BdmDedCode = drvDedCode
        JOIN dbo.EmpComp WITH (NOLOCK)
            ON EecEEID = BdmEEID
            AND EecCoID = BdmCoID
        WHERE BdmIsPQB = 'Y'
        AND BdmDedType = 'FSA';
    END;

    --==========================================
    -- Set filename
    --==========================================
    UPDATE dbo.U_dsi_Parameters
    SET ExportFile = CASE WHEN @ExportCode = 'TESTNPM' THEN 'TEST_' + CONVERT(char(8),GETDATE(),112) + '_Agribeef_NPM_12805.txt'
                          WHEN @ExportCode = 'TESTQB' THEN 'TEST_' + CONVERT(char(8),GETDATE(),112) + '_Agribeef_QB_12805.txt'
                          WHEN @ExportCode = 'NPMFILE' THEN CONVERT(char(8),GETDATE(),112) + '_Agribeef_NPM_12805.txt'
                          WHEN @ExportCode = 'QBFILE' THEN CONVERT(char(8),GETDATE(),112) + '_Agribeef_QB_12805.txt'
                     END
    WHERE FormatCode = @FormatCode;

END;
/*
--Alter the View
ALTER VIEW dbo.dsi_vwEDISCCOBR3_Export AS
    SELECT TOP 2000000 Data
    FROM dbo.U_EDISCCOBR3_File WITH (NOLOCK)
    ORDER BY InitialSort, SubSort, SubSort2, SubSort3, RecordSet;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EDISCCOBR3%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201601251'
       ,expStartPerControl     = '201601251'
       ,expLastEndPerControl   = '201602039'
       ,expEndPerControl       = '201602039'
WHERE expFormatCode = 'EDISCCOBR3'
  AND expExportCode LIKE 'TEST%';
*/
SET NOCOUNT OFF;
GO
CREATE VIEW dbo.dsi_vwEDISCCOBR3_Export AS
    SELECT TOP 2000000 Data
    FROM dbo.U_EDISCCOBR3_File WITH (NOLOCK)
    ORDER BY InitialSort, SubSort, SubSort2, SubSort3, RecordSet;

GO


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EDISCCOBR3'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EDISCCOBR3'
   AND rpoParmType = 'expSystemID'


-- End ripout