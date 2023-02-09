/**********************************************************************************

EPWCGCOBQB: Cigna/Allegiance Cobra QB Export

FormatCode:     EPWCGCOBQB
Project:        Cigna/Allegiance Cobra QB Export
Client ID:      PRI1029
Date/time:      2023-02-08 15:43:31.583
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    NWP
Server:         NW1WUP5DB03
Database:       ULTIPRO_WPPWC
Web Filename:   PRI1029_3Y7VH_EEHISTORY_EPWCGCOBQB_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EPWCGCOBQB_SavePath') IS NOT NULL DROP TABLE dbo.U_EPWCGCOBQB_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EPWCGCOBQB'


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
WHERE FormatCode = 'EPWCGCOBQB'
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
WHERE ExpFormatCode = 'EPWCGCOBQB'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EPWCGCOBQB')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EPWCGCOBQB'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EPWCGCOBQB'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EPWCGCOBQB'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EPWCGCOBQB'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EPWCGCOBQB'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EPWCGCOBQB'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EPWCGCOBQB'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EPWCGCOBQB'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EPWCGCOBQB'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEPWCGCOBQB_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEPWCGCOBQB_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EPWCGCOBQB') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EPWCGCOBQB];
GO
IF OBJECT_ID('U_EPWCGCOBQB_QBPlanInitial_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EPWCGCOBQB_QBPlanInitial_drvTbl];
GO
IF OBJECT_ID('U_EPWCGCOBQB_QBEvent_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EPWCGCOBQB_QBEvent_drvTbl];
GO
IF OBJECT_ID('U_EPWCGCOBQB_QBDependentPlanInitial_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EPWCGCOBQB_QBDependentPlanInitial_drvTbl];
GO
IF OBJECT_ID('U_EPWCGCOBQB_QBDependent_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EPWCGCOBQB_QBDependent_drvTbl];
GO
IF OBJECT_ID('U_EPWCGCOBQB_QB_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EPWCGCOBQB_QB_drvTbl];
GO
IF OBJECT_ID('U_EPWCGCOBQB_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EPWCGCOBQB_PDedHist];
GO
IF OBJECT_ID('U_EPWCGCOBQB_File') IS NOT NULL DROP TABLE [dbo].[U_EPWCGCOBQB_File];
GO
IF OBJECT_ID('U_EPWCGCOBQB_EEList') IS NOT NULL DROP TABLE [dbo].[U_EPWCGCOBQB_EEList];
GO
IF OBJECT_ID('U_EPWCGCOBQB_DedList') IS NOT NULL DROP TABLE [dbo].[U_EPWCGCOBQB_DedList];
GO
IF OBJECT_ID('U_EPWCGCOBQB_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EPWCGCOBQB_AuditFields];
GO
IF OBJECT_ID('U_EPWCGCOBQB_Audit') IS NOT NULL DROP TABLE [dbo].[U_EPWCGCOBQB_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EPWCGCOBQB') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EPWCGCOBQB];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EPWCGCOBQB','Cigna/Allegiance Cobra QB Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','EPWCGCOBQBZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPWCGCOBQBZ0','50','H','01','1',NULL,'Version',NULL,NULL,'"[VERSION]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPWCGCOBQBZ0','50','H','01','2',NULL,'VersionNumber',NULL,NULL,'"1.2"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPWCGCOBQBZ0','50','D','10','1',NULL,'Record Type',NULL,NULL,'"[QB]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPWCGCOBQBZ0','50','D','10','2',NULL,'ClientName',NULL,NULL,'"Priority Wire & Cable Inc."','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPWCGCOBQBZ0','50','D','10','3',NULL,'ClientDivisionName',NULL,NULL,'"DrvClientDivisionName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPWCGCOBQBZ0','50','D','10','4',NULL,'Salutation',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPWCGCOBQBZ0','50','D','10','5',NULL,'FirstName',NULL,NULL,'"drvFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPWCGCOBQBZ0','50','D','10','6',NULL,'MiddleInitial',NULL,NULL,'"drvMiddleInitial"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPWCGCOBQBZ0','50','D','10','7',NULL,'LastName',NULL,NULL,'"drvLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPWCGCOBQBZ0','50','D','10','8',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPWCGCOBQBZ0','50','D','10','9',NULL,'IndividualID',NULL,NULL,'"drvIndividualID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPWCGCOBQBZ0','50','D','10','10',NULL,'Email',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPWCGCOBQBZ0','50','D','10','11',NULL,'Phone',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EPWCGCOBQBZ0','50','D','10','12',NULL,'Phone2',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EPWCGCOBQBZ0','50','D','10','13',NULL,'Address1',NULL,NULL,'"drvAddress1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EPWCGCOBQBZ0','50','D','10','14',NULL,'Address2',NULL,NULL,'"drvAddress2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EPWCGCOBQBZ0','50','D','10','15',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EPWCGCOBQBZ0','50','D','10','16',NULL,'StateOrProvince',NULL,NULL,'"drvStateorProvince"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EPWCGCOBQBZ0','50','D','10','17',NULL,'PostalCode',NULL,NULL,'"drvPostalCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EPWCGCOBQBZ0','50','D','10','18',NULL,'Country',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EPWCGCOBQBZ0','50','D','10','19',NULL,'PremiumAddressSameAsPrimary',NULL,NULL,'"TRUE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EPWCGCOBQBZ0','50','D','10','20',NULL,'PremiumAddress1',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EPWCGCOBQBZ0','50','D','10','21',NULL,'PremiumAddress2',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EPWCGCOBQBZ0','50','D','10','22',NULL,'PremiumCity',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EPWCGCOBQBZ0','50','D','10','23',NULL,'PremiumStateOrProvince',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EPWCGCOBQBZ0','50','D','10','24',NULL,'PremiumPostalCode',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EPWCGCOBQBZ0','50','D','10','25',NULL,'PremiumCountry',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EPWCGCOBQBZ0','50','D','10','26',NULL,'Sex',NULL,NULL,'"drvSex"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EPWCGCOBQBZ0','50','D','10','27',NULL,'DOB',NULL,NULL,'"drvDOB"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EPWCGCOBQBZ0','50','D','10','28',NULL,'TobaccoUse',NULL,NULL,'"UNKNOWN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EPWCGCOBQBZ0','50','D','10','29',NULL,'EmployeeType',NULL,NULL,'"UNKNOWN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EPWCGCOBQBZ0','50','D','10','30',NULL,'EmployeePayrollType',NULL,NULL,'"UNKNOWN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EPWCGCOBQBZ0','50','D','10','31',NULL,'YearsOfService',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EPWCGCOBQBZ0','50','D','10','32',NULL,'PremiumCouponType',NULL,NULL,'"COUPONBOOK"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EPWCGCOBQBZ0','50','D','10','33',NULL,'UsesHCTC',NULL,NULL,'"FALSE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EPWCGCOBQBZ0','50','D','10','34',NULL,'Active',NULL,NULL,'"TRUE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EPWCGCOBQBZ0','50','D','10','35',NULL,'AllowMemberSSO',NULL,NULL,'"TRUE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EPWCGCOBQBZ0','50','D','10','36',NULL,'BenefitGroup',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EPWCGCOBQBZ0','50','D','10','37',NULL,'AccountStructure',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EPWCGCOBQBZ0','50','D','10','38',NULL,'ClientSpecificData',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EPWCGCOBQBZ0','50','D','10','39',NULL,'SSOIdentifier',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EPWCGCOBQBZ0','50','D','10','40',NULL,'PlanCategory',NULL,NULL,'""','(''SS''=T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPWCGCOBQBZ0','50','D','20','1',NULL,'RecordType',NULL,NULL,'"[QBEVENT]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPWCGCOBQBZ0','50','D','20','2',NULL,'EventType',NULL,NULL,'"drvEventType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPWCGCOBQBZ0','50','D','20','3',NULL,'EventDate',NULL,NULL,'"drvEventDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPWCGCOBQBZ0','50','D','20','4',NULL,'EnrollmentDate',NULL,NULL,'"drvEnrollmentDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPWCGCOBQBZ0','50','D','20','5',NULL,'EmployeeSSN',NULL,NULL,'"drvEmployeeSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPWCGCOBQBZ0','50','D','20','6',NULL,'EmployeeName',NULL,NULL,'"drvEmployeeName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPWCGCOBQBZ0','50','D','20','7',NULL,'SecondEventOriginalFDOC',NULL,NULL,'""','(''SS''=T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPWCGCOBQBZ0','50','D','30','1',NULL,'RecotrdType',NULL,NULL,'"[QBPLANINITIAL]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPWCGCOBQBZ0','50','D','30','2',NULL,'PlanName',NULL,NULL,'"drvPlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPWCGCOBQBZ0','50','D','30','3',NULL,'CoverageLevel',NULL,NULL,'"drvCoverageLevel"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPWCGCOBQBZ0','50','D','30','4',NULL,'NumberOfUnit',NULL,NULL,'""','(''SS''=T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPWCGCOBQBZ0','50','D','40','1',NULL,'RecordType',NULL,NULL,'"[QBDEPENDENT]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPWCGCOBQBZ0','50','D','40','2',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPWCGCOBQBZ0','50','D','40','3',NULL,'Relationship',NULL,NULL,'"drvRelationship"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPWCGCOBQBZ0','50','D','40','4',NULL,'Salutation',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPWCGCOBQBZ0','50','D','40','5',NULL,'FirstName',NULL,NULL,'"drvFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPWCGCOBQBZ0','50','D','40','6',NULL,'MiddleInitial',NULL,NULL,'"drvMiddleInitial"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPWCGCOBQBZ0','50','D','40','7',NULL,'LastName',NULL,NULL,'"drvLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPWCGCOBQBZ0','50','D','40','8',NULL,'Email',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPWCGCOBQBZ0','50','D','40','9',NULL,'Phone',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPWCGCOBQBZ0','50','D','40','10',NULL,'Phone2',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPWCGCOBQBZ0','50','D','40','11',NULL,'AddressSameAsQB',NULL,NULL,'"TRUE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EPWCGCOBQBZ0','50','D','40','12',NULL,'Address1',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EPWCGCOBQBZ0','50','D','40','13',NULL,'Address2',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EPWCGCOBQBZ0','50','D','40','14',NULL,'City',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EPWCGCOBQBZ0','50','D','40','15',NULL,'StateOrProvince',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EPWCGCOBQBZ0','50','D','40','16',NULL,'PostalCode',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EPWCGCOBQBZ0','50','D','40','17',NULL,'Country',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EPWCGCOBQBZ0','50','D','40','18',NULL,'EnrollmentDate ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EPWCGCOBQBZ0','50','D','40','19',NULL,'Sex',NULL,NULL,'"drvSex"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EPWCGCOBQBZ0','50','D','40','20',NULL,'DOB',NULL,NULL,'"drvDOB"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EPWCGCOBQBZ0','50','D','40','21',NULL,'IsQMCSO',NULL,NULL,'"FALSE"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPWCGCOBQBZ0','50','D','50','1',NULL,'Recordtype',NULL,NULL,'"[QBDEPENDENTPLANINITIAL]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPWCGCOBQBZ0','50','D','50','2',NULL,'PlanName',NULL,NULL,'"drvPlanName"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EPWCGCOBQB_20230208.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202210209','EMPEXPORT','OEACTIVE',NULL,'EPWCGCOBQB',NULL,NULL,NULL,'202210209','Oct 20 2022 12:22PM','Oct 20 2022 12:22PM','202209011',NULL,'','','202209011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202210209','EMPEXPORT','OEPASSIVE',NULL,'EPWCGCOBQB',NULL,NULL,NULL,'202210209','Oct 20 2022 12:22PM','Oct 20 2022 12:22PM','202209011',NULL,'','','202209011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Cigna/Allegiance Cobra QB Expo','202210209','EMPEXPORT','ONDEM_XOE',NULL,'EPWCGCOBQB',NULL,NULL,NULL,'202210209','Oct 20 2022 12:22PM','Oct 20 2022 12:22PM','202209011',NULL,'','','202209011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Cigna/Allegiance Cobra Q-Sched','202210209','EMPEXPORT','SCH_EPWCGC',NULL,'EPWCGCOBQB',NULL,NULL,NULL,'202210209','Oct 20 2022 12:22PM','Oct 20 2022 12:22PM','202209011',NULL,'','','202209011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',',XRAEE,XRS43',NULL,NULL,NULL,'Allegiance Cobra QE Test','202303089','EMPEXPORT','TEST_XOE','Feb  8 2023  2:19PM','EPWCGCOBQB',NULL,NULL,NULL,'202303089','Mar  8 2023 12:00AM','Dec 30 1899 12:00AM','202212011','432','','','202212011',dbo.fn_GetTimedKey(),NULL,'us3kEpPRI1029',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPWCGCOBQB','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPWCGCOBQB','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPWCGCOBQB','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPWCGCOBQB','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPWCGCOBQB','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPWCGCOBQB','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPWCGCOBQB','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPWCGCOBQB','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPWCGCOBQB','D10','dbo.U_EPWCGCOBQB_QB_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPWCGCOBQB','D20','dbo.U_EPWCGCOBQB_QBEvent_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPWCGCOBQB','D30','dbo.U_EPWCGCOBQB_QBPlanInitial_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPWCGCOBQB','D40','dbo.U_EPWCGCOBQB_QBDependent_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPWCGCOBQB','D50','dbo.U_EPWCGCOBQB_QBDependentPlanInitial_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EPWCGCOBQB
-----------

IF OBJECT_ID('U_dsi_BDM_EPWCGCOBQB') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EPWCGCOBQB] (
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
-- Create table U_EPWCGCOBQB_Audit
-----------

IF OBJECT_ID('U_EPWCGCOBQB_Audit') IS NULL
CREATE TABLE [dbo].[U_EPWCGCOBQB_Audit] (
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
-- Create table U_EPWCGCOBQB_AuditFields
-----------

IF OBJECT_ID('U_EPWCGCOBQB_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EPWCGCOBQB_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EPWCGCOBQB_DedList
-----------

IF OBJECT_ID('U_EPWCGCOBQB_DedList') IS NULL
CREATE TABLE [dbo].[U_EPWCGCOBQB_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EPWCGCOBQB_EEList
-----------

IF OBJECT_ID('U_EPWCGCOBQB_EEList') IS NULL
CREATE TABLE [dbo].[U_EPWCGCOBQB_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EPWCGCOBQB_File
-----------

IF OBJECT_ID('U_EPWCGCOBQB_File') IS NULL
CREATE TABLE [dbo].[U_EPWCGCOBQB_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);

-----------
-- Create table U_EPWCGCOBQB_PDedHist
-----------

IF OBJECT_ID('U_EPWCGCOBQB_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EPWCGCOBQB_PDedHist] (
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
-- Create table U_EPWCGCOBQB_QB_drvTbl
-----------

IF OBJECT_ID('U_EPWCGCOBQB_QB_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EPWCGCOBQB_QB_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(16) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [DrvClientDivisionName] varchar(21) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleInitial] varchar(1) NULL,
    [drvLastName] varchar(100) NULL,
    [drvSSN] char(11) NULL,
    [drvIndividualID] char(9) NULL,
    [drvAddress1] varchar(255) NULL,
    [drvAddress2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvStateorProvince] varchar(255) NULL,
    [drvPostalCode] varchar(50) NULL,
    [drvSex] varchar(1) NULL,
    [drvDOB] datetime NULL
);

-----------
-- Create table U_EPWCGCOBQB_QBDependent_drvTbl
-----------

IF OBJECT_ID('U_EPWCGCOBQB_QBDependent_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EPWCGCOBQB_QBDependent_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(31) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvRelationship] varchar(15) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleInitial] varchar(1) NULL,
    [drvLastName] varchar(100) NULL,
    [drvSex] varchar(1) NULL,
    [drvDOB] datetime NULL
);

-----------
-- Create table U_EPWCGCOBQB_QBDependentPlanInitial_drvTbl
-----------

IF OBJECT_ID('U_EPWCGCOBQB_QBDependentPlanInitial_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EPWCGCOBQB_QBDependentPlanInitial_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(30) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvPlanName] varchar(23) NULL
);

-----------
-- Create table U_EPWCGCOBQB_QBEvent_drvTbl
-----------

IF OBJECT_ID('U_EPWCGCOBQB_QBEvent_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EPWCGCOBQB_QBEvent_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(16) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvEventType] varchar(29) NULL,
    [drvEventDate] datetime NULL,
    [drvEnrollmentDate] datetime NULL,
    [drvEmployeeSSN] char(11) NULL,
    [drvEmployeeName] varchar(201) NULL
);

-----------
-- Create table U_EPWCGCOBQB_QBPlanInitial_drvTbl
-----------

IF OBJECT_ID('U_EPWCGCOBQB_QBPlanInitial_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EPWCGCOBQB_QBPlanInitial_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(16) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvPlanName] varchar(23) NULL,
    [drvCoverageLevel] varchar(11) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EPWCGCOBQB]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Priority Wire

Created By: Roger Bynum
Business Analyst: Cheryl Petitti
Create Date: 10/20/2022
Service Request Number: SR-2016-00012345

Purpose: Cigna/Allegiance Cobra QB Export

Revision History
----------------
Update By           Date           Request Num        Desc
Marie Waters        11/10/2022   TekP-2022-07-14-08    Updated code to remove dupelicate dependents and correct header and output sort order

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EPWCGCOBQB';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EPWCGCOBQB';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EPWCGCOBQB';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EPWCGCOBQB';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EPWCGCOBQB' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPWCGCOBQB', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPWCGCOBQB', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPWCGCOBQB', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPWCGCOBQB', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPWCGCOBQB', 'SCH_EPWCGC';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EPWCGCOBQB';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EPWCGCOBQB', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EPWCGCOBQB';

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
    DELETE FROM dbo.U_EPWCGCOBQB_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EPWCGCOBQB_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EPWCGCOBQB_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EPWCGCOBQB_AuditFields;
    CREATE TABLE dbo.U_EPWCGCOBQB_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_EPWCGCOBQB_AuditFields VALUES ('EmpComp','EecEmplStatus');
    INSERT INTO dbo.U_EPWCGCOBQB_AuditFields  VALUES ('EmpComp','EecDateofTermination');
    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EPWCGCOBQB_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EPWCGCOBQB_Audit;
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
    INTO dbo.U_EPWCGCOBQB_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EPWCGCOBQB_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EPWCGCOBQB_Audit ON dbo.U_EPWCGCOBQB_Audit (audEEID,audKey2);

    --================
    -- Changes Only
    --================
    --DELETE FROM dbo.U_EPWCGCOBQB_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EPWCGCOBQB_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'MED,DEN,VIS';

    IF OBJECT_ID('U_EPWCGCOBQB_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EPWCGCOBQB_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EPWCGCOBQB_DedList
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
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','Y');

    --BDM Section
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RunID','QB');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraType','4'); -- Eep/ConCobraReason first, then EdhChangeReason. Include CHGRP for elig. ben groups – 
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraDate','3'); -- EedBenStopDate and DbnBenStopDate, unless Eep/ConDateOfCOBRAEvent exists – 
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraPQBType','1'); -- If no EE or spouse, ALL children are PQB (not just oldest) – include this line if deps are sent as QB and not the employee.  If the EE is sent as the QB even for non-EE events indicate this up above in question #3.
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraReasonsDepPQB','201,204,210,LEVNT3,LEVNT4'); -- Add valid dependent edhchangereasons
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidCobraReasonsEmp','201,204,210,LEVNT3,LEVNT4'); -- Invalidate employee when Cobra Reason is a dependent PQB reason – Add valid dependent edhchangereasons (should be same as previous line above)
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidTermReasonsEmp','203'); -- Invalidate employee when Cobra Reason is "Death".  Add the Death employment term reason (eectermreason)
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'ConCobraReasonPCF','DependentCOBRAReason'); -- Valid dependent PQB reasons – used when clients have Platform Configurable fields.  Add any other field names the client is using.
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CountDependents','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS'); -- update to the spouse relationship code
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL,DPC,STC,DIS'); -- update to the child relationship codes
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP'); -- update to the domestic partner relationship code
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard'); 



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

--====================================================
 --   -- Insert into BDM Reason code 200/203/DEA (Death)
 --            SPS or 1st child is EMP
 --=====================================================
        
             INSERT INTO [dbo].[U_dsi_BDM_EPWCGCOBQB]
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
           ,[BdmBenStatus]
           ,[BdmBenStartDate]
           ,[BdmBenStopDate]
           ,[BdmBenStatusDate]
           ,[BdmDateOFCobraEvent]
           ,[BdmChangeReason]
           ,[BdmCobraReason]
           ,[BdmStartDate]
           ,[BdmStopDate]
           ,[BdmIsPQB]
           ,[BdmIsCobraCovered]
           ,[BdmSessionID]
         --    ,[BdmNumSpouses]
            --,[BdmNumChildren]
    )
    Select Distinct rectype = 'DEP'
        ,EdhCoid
        ,EdhEEID
        ,DbnDepRecID
        ,DbnDepRecID
        ,'QB'
        ,'Data Inserted for 200/203 (Death)'
        ,DbnRelationship
        ,DbnDateOfBirth
        ,EdhDedCode
        ,DbnBenOption
        ,DbnBenStatus
        ,EdhBenStartDate
        ,DbnBenStopDate
        ,EdhBenStatusDate
        ,EecDateofTermination
        ,edhChangeReason
        ,EecTermReason
        ,EdhStartDate 
        ,EdhStopDate
        ,'Y'
        ,'Y'
        ,ROW_NUMBER() OVER (PARTITION by EdhEEID, EdhCOID, edhChangeReason, EdhDedCode ORDER BY EdhEffDate desc)
    FROM dbo.emphded WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
        ON dbneeid = edheeid 
        AND DbnCoID = EdhCoID
        AND EdhDedCode = DbnDedCode
        AND EdhBenOption = DbnBenOption
        AND dbnformatcode = 'EPWCGCOBQB'
        AND edhChangeReason IN ('210') 
        and DbnBenstopdate BETWEEN @startdate AND @enddate 
        AND dbnValidForExport = 'N'
        JOIN EmpComp WITH (NOLOCK)
        ON dbnEEID = EecEEID
        AND EecTermReason in ('203')
        AND DbnBenStatus IN  ('T')
        AND EecEmplStatus = 'T';




    ---=======================================================================
 --  Insert into BDM Reason code 204 / LEVNT4 (Divorce/Separation) 
 ----======================================================================

    INSERT INTO [dbo].[U_dsi_BDM_EPWCGCOBQB]
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
           ,[BdmBenOption]
           ,[BdmBenStatus]
           ,[BdmBenStartDate]
           ,[BdmBenStopDate]
           ,[BdmBenStatusDate]
           ,[BdmDateOFCobraEvent]
           ,[BdmChangeReason]
           ,[BdmCobraReason]
           ,[BdmStartDate]
           ,[BdmStopDate]
           ,[BdmIsPQB]
           ,[BdmIsCobraCovered]
           ,[BdmSessionID]
    )
    SELECT Distinct 
            rectype = CASE WHEN DbnRelationShip = 'SPS' THEN 'EMP' ELSE 'DEP' END
            ,EdhCoid
            ,EdhEEID
            ,DbnDepRecID
            ,DbnDepRecID
            ,'QB'
            ,'Data Inserted for 204/LEVNT4 (Divorce/Separation)'
            ,DbnRelationship
            ,DbnDateOfBirth
            ,EdhDedCode
            ,DbnBenOption
            ,DbnBenStatus
            ,EdhBenStartDate
            ,DbnBenStopDate
            ,EdhBenStatusDate
            ,EdhEffDate
            ,edhChangeReason
            ,edhChangeReason
            ,EdhStartDate
            ,DbnBenStopDate
            ,CASE WHEN DbnRelationShip = 'SPS' THEN 'Y' ELSE 'N' END
            ,'Y'
            ,ROW_NUMBER() OVER (PARTITION by EdhEEID, EdhCOID, edhChangeReason, EdhDedCode ORDER BY EdhEffDate desc)
        FROM dbo.emphded WITH (NOLOCK)
        JOIN dbo.U_dsi_BDM_DepDeductions 
            ON dbneeid = edheeid 
            AND DbnCoID = EdhCoID
            AND EdhDedCode = DbnDedCode
            AND EdhBenOption = DbnBenOption
            AND dbnformatcode = 'EPWCGCOBQB'
            WHERE edhChangeReason in ('204','LEVNT4') 
            AND DbnBenStopDate BETWEEN @StartDate AND @EndDate
            AND dbnValidForExport = 'N'
            AND DbnBenStatus IN  ('T')
            AND DbnDedCode in ('MED','DEN','VIS')
            ;
  ---========================================================================
 --   -- Insert into BDM Reason code 201 (Dependent at Max Age) - Only show EE
 -- --======================================================================

    INSERT INTO [dbo].[U_dsi_BDM_EPWCGCOBQB]
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
           ,[BdmBenStatus]
           ,[BdmBenStartDate]
           ,[BdmBenStopDate]
           ,[BdmBenStatusDate]
           ,[BdmDateOFCobraEvent]
           ,[BdmChangeReason]
           ,[BdmCobraReason]
           ,[BdmStartDate]
           ,[BdmStopDate]
           ,[BdmIsPQB]
           ,[BdmIsCobraCovered]
           ,[BdmSessionID]
    )
        Select distinct
        'DEP'
        ,EdhCoid
        ,EdhEEID
        ,DbnDepRecID
        ,DbnDepRecID
        ,'QB'
        ,'Data Inserted for 201 (Dep at Max Age Dep/Loss of elig)'
        ,'Emp'
        ,EepDateofBirth
        ,DbnDedCode
        ,DbnBenStatus
        ,DbnBenStatus
        ,EdhBenStartDate
        ,EdhBenStopDate
        ,EdhBenStatusDate
        ,EdhEffDate
        ,edhChangeReason
        ,edhChangeReason
        ,EdhStartDate
        ,EdhStopDate
        ,'Y'
        ,'Y'
         ,ROW_NUMBER() OVER (PARTITION by EdhEEID, EdhCOID, edhChangeReason, EdhDedCode ORDER BY EdhEffDate desc)
    FROM dbo.emphded WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = edheeid 
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
        ON dbneeid = edheeid 
        AND DbnCoID = EdhCoID
        AND EdhDedCode = DbnDedCode
        AND EdhBenOption = DbnBenOption
        AND dbnformatcode = 'EPWCGCOBQB'
    WHERE edhChangeReason IN ('201','LEVNT3') 
        and DbnBenstopdate BETWEEN @startdate AND @enddate 
       AND dbnValidForExport = 'N'
       AND DbnBenStatus IN  ('T')
       AND DbnDedCode in ('MED','DEN','VIS')
            ;

     DELETE FROM dbo.U_dsi_BDM_EPWCGCOBQB where bdmdedcode not in (Select dedcode from U_EPWCGCOBQB_DedList)




    ----==========================================
    ---- Build Working Tables
    ----==========================================

    -------------------------------
    ---- Working Table - PDedHist
    -------------------------------
    --IF OBJECT_ID('U_EPWCGCOBQB_PDedHist','U') IS NOT NULL
    --    DROP TABLE dbo.U_EPWCGCOBQB_PDedHist;
    --SELECT DISTINCT
    --     PdhEEID
    --    -- Current Payroll Amounts
    --    ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
    --    -- YTD Payroll Amounts
    --    ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
    --    ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
    --    -- Categorize Payroll Amounts
    --    ,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('401K') THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('ROTH') THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('MATCH') THEN PdhERCurAmt ELSE 0.00 END)        
    --    ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('401CU') THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('401KL1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --    ,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('401KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --    ,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --    ,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --    ,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --INTO dbo.U_EPWCGCOBQB_PDedHist
    --FROM dbo.PDedHist WITH (NOLOCK)
    --JOIN dbo.U_EPWCGCOBQB_DedList WITH (NOLOCK)
    --    ON DedCode = PdhDedCode
    --WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    --AND PdhPerControl <= @EndPerControl
    --AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    --GROUP BY PdhEEID
    --HAVING (SUM(PdhEECurAmt) <> 0.00
    --    OR SUM(PdhERCurAmt) <> 0.00
    --);


    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EPWCGCOBQB_QB_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EPWCGCOBQB_QB_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EPWCGCOBQB_QB_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '1 ' + xEEID + ' 1'
        ,drvSubSort = '1'
        -- standard fields above and additional driver fields below
        ,DrvClientDivisionName = CASE WHEN EecCoID = 'XRAEE' THEN 'Priority Wire & Cable' 
                                      WHEN EecCoID = 'XRS43' THEN 'Priority 1'
                                 END
        ,drvFirstName =  TRIM(eepNameFirst) 
        ,drvMiddleInitial =  LEFT(EepNameMiddle,1) 
        ,drvLastName =  TRIM(EepNameLast)
        ,drvSSN =  eepSSN 
        ,drvIndividualID = EecEmpNo
        ,drvAddress1 = EepAddressLine1
        ,drvAddress2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,drvStateorProvince = EepAddressState
        ,drvPostalCode = EepAddressZipCode
        ,drvSex =  CASE WHEN EepGender IN ('M','F') THEN EepGender  ELSE 'U' END
                
        ,drvDOB = EepDateOfBirth 
    INTO dbo.U_EPWCGCOBQB_QB_drvTbl
    FROM dbo.U_EPWCGCOBQB_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EPWCGCOBQB WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRunID = 'QB'
        and BdmIsPQB ='Y'
        AND BdmRecType = 'EMP'
        and bdmbenstatus <> 'C'
        and bdmrelationship <> 'MOM'
     JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.EmpHDed WITH (NOLOCK)
        ON edhEEID = xEEID
        AND EdhDedCode = bdmDedCode
        Where (edhChangeReason NOT IN ('LEVNT3','LEVNT4','204','210','201') or BdmCobraReason NOT IN ('LEVNT3','LEVNT4','204','210','201'))

        INSERT INTO dbo.U_EPWCGCOBQB_QB_drvTbl
        (
         drvEEID 
        ,drvCoID 
        ,drvDepRecID 
        ,drvSort 
        ,drvSubSort 
        -- standard fields above and additional driver fields below
        ,DrvClientDivisionName 
        ,drvFirstName  
        ,drvMiddleInitial  
        ,drvLastName 
        ,drvSSN 
        ,drvIndividualID 
        ,drvAddress1 
        ,drvAddress2 
        ,drvCity
        ,drvStateorProvince 
        ,drvPostalCode 
        ,drvSex                 
        ,drvDOB 
        )


        SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '1 ' + xEEID + ' 1'
        ,drvSubSort = '1'
        -- standard fields above and additional driver fields below
        ,DrvClientDivisionName = CASE WHEN EecCoID = 'XRAEE' THEN 'Priority Wire & Cable' 
                                      WHEN EecCoID = 'XRS43' THEN 'Priority 1'
                                 END
        ,drvFirstName = TRIM(conNameFirst) 
        ,drvMiddleInitial =  LEFT(ConNameMiddle,1) 
        ,drvLastName =  TRIM(ConNameLast) 
        ,drvSSN =  ConSSN 
        ,drvIndividualID = EecEmpNo
        ,drvAddress1 = ConAddressLine1
        ,drvAddress2 = ConAddressLine2
        ,drvCity = ConAddressCity
        ,drvStateorProvince = ConAddressState
        ,drvPostalCode = ConAddressZipCode
        ,drvSex =  CASE WHEN conGender IN ('M','F') THEN ConGender  ELSE 'U' END
                     
        ,drvDOB =  ConDateOfBirth
  --  INTO dbo.U_EPWCGCOBQB_QB_drvTbl
    FROM dbo.U_EPWCGCOBQB_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EPWCGCOBQB WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRunID = 'QB'
        and BdmIsPQB ='Y'
        and bdmbenstatus <> 'C'
        AND BdmRecType <> 'EMP'
        and bdmrelationship <> 'MOM'
    JOIN dbo.contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
     JOIN dbo.EmpHDed WITH (NOLOCK)
        ON edhEEID = xEEID
        AND EdhDedCode = bdmDedCode
    Where (edhChangeReason  IN ('LEVNT3','LEVNT4','204','210','201') or BdmCobraReason  IN ('LEVNT3','LEVNT4','204','210','201'))
  
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EPWCGCOBQB_QBEvent_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EPWCGCOBQB_QBEvent_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EPWCGCOBQB_QBEvent_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '1 ' + xEEID + ' 2'
        ,drvSubSort = '2'
        -- standard fields above and additional driver fields below
        ,drvEventType = CASE WHEN edhChangeReason IN ('204','LEVNT4') or BdmCobraReason IN ('204','LEVNT4') THEN 'DIVORCELEGALSEPARATION'
                             WHEN EecEmplStatus = 'T' AND EecTermReason = '203' THEN  'DEATH'   
                             WHEN edhChangeReason = '205' THEN 'MEDICARE ' 
                             WHEN edhChangeReason IN ('201','LEVNT3')or BdmCobraReason IN ('201','LEVNT3')  THEN 'INELIGIBLEDEPENDENT' 
                             WHEN (EecEmplStatus = 'T' AND EecTermReason NOT IN ('202','203')) OR eectermtype = 'V' THEN 'TERMINATION' 
                             WHEN (EecEmplStatus = 'T' AND EecTermReason NOT IN ('202','203')) OR eectermtype = 'I' THEN 'INVOLUNTARYTERMINATION'
                             WHEN edhChangeReason = '208' OR (EecEmplStatus = 'T' AND EecTermReason = '202') THEN 'RETIREMENT'
                             WHEN edhChangeReason IN ('203','202') THEN 'REDUCTIONINHOURS-STATUSCHANGE'
                             WHEN edhChangeReason = '206' THEN 'REDUCTIONINHOURS-ENDOFLEAVE'
                        END
        ,drvEventDate = CASE WHEN EecEmplStatus = 'T' AND EecTermReason NOT IN ('202','203') THEN EecDateOfTermination 
                             WHEN EecEmplStatus = 'T' AND EecTermReason IN ('202','203') AND eepDateOfCOBRAEvent IS NULL THEN EecDateOfTermination
                             WHEN edhChangeReason IN ('LEVNT3','LEVNT4','204','210','201') THEN edheffdate
                             ELSE eepDateOfCOBRAEvent 
                        END
        ,drvEnrollmentDate = BdmBenStartDate 
        ,drvEmployeeSSN = eepSSN
        ,drvEmployeeName = EepNameFirst + ' ' + EepNameLast
    INTO dbo.U_EPWCGCOBQB_QBEvent_drvTbl
    FROM dbo.U_EPWCGCOBQB_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN (
            SELECT
                 BdmEEID
                ,BdmCoID
                ,BdmCobraReason = MAX(BdmCobraReason)
                ,BdmBenStopDate = MAX(BdmBenStopDate)
                ,BdmBenStartDate = MIN(BdmBenStartDate)
                ,BdmDateOfCOBRAEvent = MAX(BdmDateOfCOBRAEvent)
              FROM dbo.U_dsi_BDM_EPWCGCOBQB WITH (NOLOCK)
              WHERE BdmRunId = 'QB'
              and BdmBenOption <> 'C'
              GROUP BY BdmEEID, BdmCoID) AS Bdm
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID        
    LEFT JOIN (
            SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent 
            FROM (
                    SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent, ROW_NUMBER() OVER (PARTITION by EdhEEID, EdhCOID ORDER BY EdhEffDate desc) AS RN
                    FROM dbo.EmpHDed a WITH (NOLOCK)
                    JOIN dbo.BenChRsn WITH (NOLOCK)
                        ON EdhChangeReason = BchCode
                    WHERE EdhDedCode IN ('MED','DEN','VIS')
                        AND edhChangeReason IN ('LEVNT3','LEVNT4','204','210','201')
                ) AS X
            WHERE RN = 1) AS Edh
        ON EdhEEID = xEEID
        AND EdhCoID = xCOID  
        
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EPWCGCOBQB_QBPlanInitial_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EPWCGCOBQB_QBPlanInitial_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EPWCGCOBQB_QBPlanInitial_drvTbl;
       SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '1 ' + xEEID + ' 3'
        ,drvSubSort = '3'
        -- standard fields above and additional driver fields below
        ,drvPlanName =   CASE WHEN BdmDedCode = 'MED' THEN 'Allegiance Medical Plan'
                              WHEN BdmDedCode = 'DEN' THEN 'Delta Dental Plan '
                              WHEN BdmDedCode = 'VIS' THEN 'SunLife Vision Plan'
                         END

       ,drvCoverageLevel =     CASE WHEN  (BdmDedCode IN ('DEN', 'MED', 'VIS') and BdmCobraReason  NOT IN ('201','302','LEVNT3','204','210','LEVNT4')) THEN 
                        
                                      CASE WHEN BdmBenOption = 'EE' THEN 'EE' 
                                           WHEN BdmBenOption IN ('EEC', 'EECH') THEN 'EE+CHILDREN'
                                           WHEN BdmBenOption IN ('EEF', 'EEDPF', 'EEF2') THEN 'EE+FAMILY'
                                           WHEN BdmBenOption IN ('EES', 'EEDP') THEN 'EE+SPOUSE'
                                         ELSE 'EE'
                                     END
                                
                            ELSE                    
                                CASE WHEN  BdmDedCode IN ('DEN') and BdmCobraReason  IN ('201','302','LEVNT3','204','210','LEVNT4') THEN
                                        CASE WHEN BdmRelationship = 'SPS' AND (SELECT COUNT(DISTINCT BdmDepRecId) FROM dbo.U_dsi_BDM_EPWCGCOBQB WITH (NOLOCK) WHERE BdmRunId = 'QB' AND BdmEEID = xEEID AND BdmRecType = 'DEP' AND BdmRelationship IN ('CHL','DPC','STC','DCH')) = 1 THEN 'EE+CHILD'
                                             WHEN BdmRelationship = 'SPS' AND (SELECT COUNT(DISTINCT BdmDepRecId) FROM dbo.U_dsi_BDM_EPWCGCOBQB WITH (NOLOCK) WHERE BdmRunId = 'QB' AND BdmEEID = xEEID AND BdmRecType = 'DEP' AND BdmRelationship IN ('CHL','DPC','STC','DCH')) > 1  THEN 'EE+CHILDREN'
                                             WHEN BdmRelationship <> 'SPS' AND (SELECT COUNT(DISTINCT BdmDepRecId) FROM dbo.U_dsi_BDM_EPWCGCOBQB WITH (NOLOCK) WHERE BdmRunId = 'QB' AND BdmEEID = xEEID AND BdmRecType = 'DEP' AND BdmRelationship IN ('CHL','DPC','STC','DCH')) > 1 THEN 'EE+CHILDREN'
                                         ELSE 'EE'
                                     END
                             ELSE
                                CASE WHEN  BdmDedCode IN ('MED', 'VIS') and BdmCobraReason  IN ('201','302','LEVNT3','204','210','LEVNT4') THEN
                                        CASE WHEN BdmRelationship = 'SPS' AND (SELECT COUNT(DISTINCT BdmDepRecId) FROM dbo.U_dsi_BDM_EPWCGCOBQB WITH (NOLOCK) WHERE BdmRunId = 'QB' AND BdmEEID = xEEID AND BdmRecType = 'DEP' AND BdmRelationship IN ('CHL','DPC','STC','DCH')) = 1  THEN 'EE+CHILDREN'
                                             WHEN BdmRelationship = 'SPS' AND (SELECT COUNT(DISTINCT BdmDepRecId) FROM dbo.U_dsi_BDM_EPWCGCOBQB WITH (NOLOCK) WHERE BdmRunId = 'QB' AND BdmEEID = xEEID AND BdmRecType = 'DEP' AND BdmRelationship IN ('CHL','DPC','STC','DCH')) > 1  THEN 'EE+CHILDREN'
                                             WHEN BdmRelationship <> 'SPS' AND (SELECT COUNT(DISTINCT BdmDepRecId) FROM dbo.U_dsi_BDM_EPWCGCOBQB WITH (NOLOCK) WHERE BdmRunId = 'QB' AND BdmEEID = xEEID AND BdmRecType = 'DEP' AND BdmRelationship IN ('CHL','DPC','STC','DCH'))> 1  THEN  'EE+CHILDREN'
                                         ELSE 'EE'                        
                                    END
                               END
                          END
                    END
                        
                        
    INTO dbo.U_EPWCGCOBQB_QBPlanInitial_drvTbl
    FROM dbo.U_EPWCGCOBQB_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.U_dsi_BDM_EPWCGCOBQB  WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRunId = 'QB'
        AND bdmrelationship <> 'MOM'
        AND BdmBenOption <> 'C'

         and bdmIsPQB = 'Y'
    LEFT JOIN (
            SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent 
            FROM (
                    SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent, ROW_NUMBER() OVER (PARTITION by EdhEEID, EdhCOID ORDER BY EdhEffDate desc) AS RN
                    FROM dbo.EmpHDed a WITH (NOLOCK)
                    JOIN dbo.BenChRsn WITH (NOLOCK)
                        ON EdhChangeReason = BchCode
                    WHERE EdhDedCode IN ('MED','DEN','VIS')
                        AND edhChangeReason IN ('LEVNT3','LEVNT4','204','210','201')
                ) AS X
            WHERE RN = 1) AS Edh
        ON EdhEEID = xEEID
        AND EdhCoID = xCOID  
    
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EPWCGCOBQB_QBDependent_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EPWCGCOBQB_QBDependent_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EPWCGCOBQB_QBDependent_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '1 ' + xEEID + ' 4 ' +  BdmDepRecID + ' 1'  
        ,drvSubSort = '4'
        -- standard fields above and additional driver fields below
        ,drvSSN = ConSSN
        ,drvRelationship = CASE WHEN  conrelationship = 'SPS' THEN 'SPOUSE'         
                                WHEN conrelationship = 'DP' THEN 'DOMESTICPARTNER'
                                WHEN conrelationship IN ('CHL','DIS','DPC','STC') THEN 'CHILD'
                           END
        ,drvFirstName = ConNameFirst
        ,drvMiddleInitial = LEFT(ConNameMiddle,1)
        ,drvLastName = ConNameLast
        ,drvSex = CASE WHEN ConGender IN ('M', 'F') THEN ConGender ELSE 'U' END
        ,drvDOB = ConDateOfBirth
    INTO dbo.U_EPWCGCOBQB_QBDependent_drvTbl
    FROM dbo.U_EPWCGCOBQB_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EPWCGCOBQB WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRunID = 'QB'
        and bdmbenstatus <> 'C'
        AND bdmrelationship <> 'MOM'
      JOIN dbo.contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
        WHERE  BdmIsPQB = 'N'
  --  JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
  --      ON DbnEEID = drvEEID 
  --      AND DbnCoID = drvCoID
  --      AND DbnDepRecID = ConSystemID
  --      --AND drvDedCode = DbnDedCode
  --      AND DbnFormatCode = @FormatCode 
  --      AND DbnValidForExport = 'Y'
  --      AND DbnBenStatus = 'A'
  --      AND DbnRelationship IN ('SP', 'DP''CHL','DIS','DPC','STC')
        --AND ConSystemID = DbnDepRecID

    ;
    ---------------------------------
    -- DETAIL RECORD - U_EPWCGCOBQB_QBDependentPlanInitial_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EPWCGCOBQB_QBDependentPlanInitial_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EPWCGCOBQB_QBDependentPlanInitial_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '1 ' + xEEID + ' 4 ' + BdmDepRecID + '2'
        ,drvSubSort = '5'
        -- standard fields above and additional driver fields below
        ,drvPlanName = CASE WHEN BdmDedCode = 'MED' THEN 'Allegiance Medical Plan' 
                            WHEN BdmDedCode = 'DEN' THEN 'Delta Dental Plan'
                            WHEN BdmDedCode = 'VIS' THEN 'SunLife Vision Plan'
                       END
    INTO dbo.U_EPWCGCOBQB_QBDependentPlanInitial_drvTbl
    FROM dbo.U_EPWCGCOBQB_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EPWCGCOBQB WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRunID = 'QB'
        AND bdmrelationship <> 'MOM'
     JOIN dbo.U_EPWCGCOBQB_QB_drvTbl WITH (NOLOCK)
        ON drvEEID = xEEID
     JOIN dbo.contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
  --  JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
  --      ON DbnEEID = drvEEID 
  --      AND DbnCoID = drvCoID
  --      AND DbnDepRecID = ConSystemID
  --      --AND drvDedCode = DbnDedCode
  --      AND DbnFormatCode = @FormatCode 
  --      AND DbnValidForExport = 'Y'
  --      AND DbnBenStatus = 'A'
  --      AND DbnRelationship IN ('SP', 'DP''CHL','DIS','DPC','STC')
        --AND ConSystemID = DbnDepRecID
        WHERE BdmRecType = 'DEP'
        AND ((ConRelationship NOT IN ('SPS', 'DP') AND BdmCobraReason NOT IN ('201', 'LEVNT3'))
            OR (ConRelationship IN ('SPS', 'DP') AND BdmCobraReason NOT IN ('210', '204', 'LEVNT4')))

    ;
    ---------------------------------
    -- DETAIL RECORD - U_EPWCGCOBQB_QBPLANMEMBERSPECIFICRATEINITIAL_drvTbl
    ---------------------------------
    --IF OBJECT_ID('U_EPWCGCOBQB_QBPLANMEMBERSPECIFICRATEINITIAL_drvTbl','U') IS NOT NULL
    --    DROP TABLE dbo.U_EPWCGCOBQB_QBPLANMEMBERSPECIFICRATEINITIAL_drvTbl;
    --SELECT DISTINCT
    --     drvEEID = xEEID
    --    ,drvCoID = xCoID
    --    ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
    --    ,drvSort = '2_' + xEEID + '_6'
    --    ,drvSubSort = ''
    --    -- standard fields above and additional driver fields below
    --    ,drvRecordType = ''
    --    ,drvPlanName = ''
    --    ,drvRate = ''
    --INTO dbo.U_EPWCGCOBQB_QBPLANMEMBERSPECIFICRATEINITIAL_drvTbl
    --FROM dbo.U_EPWCGCOBQB_EEList WITH (NOLOCK)
    --JOIN dbo.U_dsi_BDM_EPWCGCOBQB WITH (NOLOCK)
    --    ON BdmEEID = xEEID 
    --    AND BdmCoID = xCoID
    --;

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
ALTER VIEW dbo.dsi_vwEPWCGCOBQB_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EPWCGCOBQB_File (NOLOCK)
    ORDER BY  InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EPWCGCOBQB%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202209011'
       ,expStartPerControl     = '202209011'
       ,expLastEndPerControl   = '202301209'
       ,expEndPerControl       = '202301209'
WHERE expFormatCode = 'EPWCGCOBQB' and expexportcode = 'TEST_XOE';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEPWCGCOBQB_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EPWCGCOBQB_File (NOLOCK)
    ORDER BY  InitialSort, SubSort;

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EPWCGCOBQB' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EPWCGCOBQB'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EPWCGCOBQB'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EPWCGCOBQB', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EPWCGCOBQB', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EPWCGCOBQB', 'UseFileName', 'V', 'Y'


-- End ripout