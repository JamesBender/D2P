/**********************************************************************************

EDISQBCENM: Discovery Cobra QB Export

Date/time:     2021-09-22 03:25:35.077
Client ID:     CEN1026
FormatCode:    EDISQBCENM
Project:       Discovery Cobra QB Export
Export Type:   Web
Status:        Testing
Environment:   NWP
Server:        NW1WUP5DB02
Database:      ULTIPRO_WPCENM
Web Filename:  CEN1026_T1LIX_EEHISTORY_EDISQBCENM_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    

Git Filename and Command
-------------------
C:\GDIToolsGIT\EDISQBCENM_Deploy.sql
./AddToGit.sh -s SR-2021-00308415 -a CEN1026 -f EDISQBCENM

**********************************************************************************/

SET NOCOUNT ON;

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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EDISQBCENM'


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
WHERE FormatCode = 'EDISQBCENM'
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
WHERE ExpFormatCode = 'EDISQBCENM'


-----------
-- Drop current objects and delete configuration data
-----------

IF OBJECT_ID('dsi_vwEDISQBCENM_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEDISQBCENM_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EDISQBCENM') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EDISQBCENM];
GO
IF OBJECT_ID('U_EDISQBCENM_File') IS NOT NULL DROP TABLE [dbo].[U_EDISQBCENM_File];
GO
IF OBJECT_ID('U_EDISQBCENM_EEList') IS NOT NULL DROP TABLE [dbo].[U_EDISQBCENM_EEList];
GO
IF OBJECT_ID('U_EDISQBCENM_drvTbl_QBSUBSIDY') IS NOT NULL DROP TABLE [dbo].[U_EDISQBCENM_drvTbl_QBSUBSIDY];
GO
IF OBJECT_ID('U_EDISQBCENM_drvTbl_QBPLAN') IS NOT NULL DROP TABLE [dbo].[U_EDISQBCENM_drvTbl_QBPLAN];
GO
IF OBJECT_ID('U_EDISQBCENM_drvTbl_QBMSRI') IS NOT NULL DROP TABLE [dbo].[U_EDISQBCENM_drvTbl_QBMSRI];
GO
IF OBJECT_ID('U_EDISQBCENM_drvTbl_QBEVENT') IS NOT NULL DROP TABLE [dbo].[U_EDISQBCENM_drvTbl_QBEVENT];
GO
IF OBJECT_ID('U_EDISQBCENM_drvTbl_QBDEPPLAN') IS NOT NULL DROP TABLE [dbo].[U_EDISQBCENM_drvTbl_QBDEPPLAN];
GO
IF OBJECT_ID('U_EDISQBCENM_drvTbl_QBDEP') IS NOT NULL DROP TABLE [dbo].[U_EDISQBCENM_drvTbl_QBDEP];
GO
IF OBJECT_ID('U_EDISQBCENM_drvTbl_QB') IS NOT NULL DROP TABLE [dbo].[U_EDISQBCENM_drvTbl_QB];
GO
IF OBJECT_ID('U_dsi_BDM_EDISQBCENM') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EDISQBCENM];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EDISQBCENM';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EDISQBCENM';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EDISQBCENM';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EDISQBCENM';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EDISQBCENM';

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EDISQBCENM','Discovery Cobra QB Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','EDISQBCENMZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[VERSION]"','1','(''DA''=''Q,'')','EDISQBCENMZ0','50','H','01','1',NULL,'Version Line Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"1.1"','2','(''DA''=''Q'')','EDISQBCENMZ0','50','H','01','2',NULL,'Version Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QB]"','1','(''DA''=''Q,'')','EDISQBCENMZ0','50','D','20','1',NULL,'Record Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientName"','2','(''UA''=''Q,'')','EDISQBCENMZ0','50','D','20','2',NULL,'ClientName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientDivName"','3','(''UA''=''Q,'')','EDISQBCENMZ0','50','D','20','3',NULL,'ClientDivisionName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','4','(''SS''=''Q,'')','EDISQBCENMZ0','50','D','20','4',NULL,'Salutation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','5','(''UA''=''Q,'')','EDISQBCENMZ0','50','D','20','5',NULL,'FirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','6','(''UA''=''Q,'')','EDISQBCENMZ0','50','D','20','6',NULL,'MiddleInitial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','7','(''UA''=''Q,'')','EDISQBCENMZ0','50','D','20','7',NULL,'LastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','8','(''UA''=''Q,'')','EDISQBCENMZ0','50','D','20','8',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpNo"','9','(''UA''=''Q,'')','EDISQBCENMZ0','50','D','20','9',NULL,'IndividualID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''SS''=''Q,'')','EDISQBCENMZ0','50','D','20','10',NULL,'Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','11','(''SS''=''Q,'')','EDISQBCENMZ0','50','D','20','11',NULL,'Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','12','(''SS''=''Q,'')','EDISQBCENMZ0','50','D','20','12',NULL,'Phone2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','13','(''UA''=''Q,'')','EDISQBCENMZ0','50','D','20','13',NULL,'Address1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','14','(''UA''=''Q,'')','EDISQBCENMZ0','50','D','20','14',NULL,'Address2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','15','(''UA''=''Q,'')','EDISQBCENMZ0','50','D','20','15',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','16','(''UA''=''Q,'')','EDISQBCENMZ0','50','D','20','16',NULL,'StateOrProvince',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','17','(''UA''=''Q,'')','EDISQBCENMZ0','50','D','20','17',NULL,'PostalCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''SS''=''Q,'')','EDISQBCENMZ0','50','D','20','18',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TRUE"','19','(''DA''=''Q,'')','EDISQBCENMZ0','50','D','20','19',NULL,'PremiumAddressSameAsPrimary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','20','(''SS''=''Q,'')','EDISQBCENMZ0','50','D','20','20',NULL,'PremiumAddress1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','21','(''SS''=''Q,'')','EDISQBCENMZ0','50','D','20','21',NULL,'PremiumAddress2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','22','(''SS''=''Q,'')','EDISQBCENMZ0','50','D','20','22',NULL,'PremiumCity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','23','(''SS''=''Q,'')','EDISQBCENMZ0','50','D','20','23',NULL,'PremiumStateOrProvince',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','24','(''SS''=''Q,'')','EDISQBCENMZ0','50','D','20','24',NULL,'PremiumPostalCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','25','(''SS''=''Q,'')','EDISQBCENMZ0','50','D','20','25',NULL,'PremiumCountry',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','26','(''UA''=''Q,'')','EDISQBCENMZ0','50','D','20','26',NULL,'Sex',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','27','(''UD101''=''Q,'')','EDISQBCENMZ0','50','D','20','27',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"UNKNOWN"','28','(''DA''=''Q,'')','EDISQBCENMZ0','50','D','20','28',NULL,'TobaccoUse',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"UNKNOWN"','29','(''DA''=''Q,'')','EDISQBCENMZ0','50','D','20','29',NULL,'EmployeeType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"UNKNOWN"','30','(''DA''=''Q,'')','EDISQBCENMZ0','50','D','20','30',NULL,'EmployeePayrollType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','31','(''SS''=''Q,'')','EDISQBCENMZ0','50','D','20','31',NULL,'YearsOfService',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"COUPONBOOK"','32','(''DA''=''Q,'')','EDISQBCENMZ0','50','D','20','32',NULL,'PremiumCouponType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FALSE"','33','(''DA''=''Q,'')','EDISQBCENMZ0','50','D','20','33',NULL,'UsesHCTC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TRUE"','34','(''DA''=''Q,'')','EDISQBCENMZ0','50','D','20','34',NULL,'Active',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','35','(''SS''=''Q,'')','EDISQBCENMZ0','50','D','20','35',NULL,'AllowMemberSSO',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','36','(''SS''=''Q,'')','EDISQBCENMZ0','50','D','20','36',NULL,'BenefitGroup',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','37','(''SS''=''Q,'')','EDISQBCENMZ0','50','D','20','37',NULL,'AccountStructure',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','38','(''SS''=''Q'')','EDISQBCENMZ0','50','D','20','38',NULL,'ClientSpecificData',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBEVENT]"','1','(''DA''=''Q,'')','EDISQBCENMZ0','50','D','30','1',NULL,'Record Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEventType"','2','(''UA''=''Q,'')','EDISQBCENMZ0','50','D','30','2',NULL,'EventType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEventDate"','3','(''UD101''=''Q,'')','EDISQBCENMZ0','50','D','30','3',NULL,'EventDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrollmentDate"','4','(''UD101''=''Q,'')','EDISQBCENMZ0','50','D','30','4',NULL,'EnrollmentDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','5','(''UA''=''Q,'')','EDISQBCENMZ0','50','D','30','5',NULL,'EmployeeSSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvName"','6','(''UA''=''Q,'')','EDISQBCENMZ0','50','D','30','6',NULL,'EmployeeName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','7','(''SS''=''Q'')','EDISQBCENMZ0','50','D','30','7',NULL,'SecondEventOriginalFDOC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBPLANINITIAL]"','1','(''DA''=''Q,'')','EDISQBCENMZ0','50','D','40','1',NULL,'Record Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanName"','2','(''UA''=''Q,'')','EDISQBCENMZ0','50','D','40','2',NULL,'PlanName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageLevel"','3','(''UA''=''Q,'')','EDISQBCENMZ0','50','D','40','3',NULL,'CoverageLevel',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','4','(''SS''=''Q'')','EDISQBCENMZ0','50','D','40','4',NULL,'NumberOfUnits',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBDEPENDENT]"','1','(''DA''=''Q,'')','EDISQBCENMZ0','50','D','50','1',NULL,'Record Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','2','(''UA''=''Q,'')','EDISQBCENMZ0','50','D','50','2',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelationship"','3','(''UA''=''Q,'')','EDISQBCENMZ0','50','D','50','3',NULL,'Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','4','(''SS''=''Q,'')','EDISQBCENMZ0','50','D','50','4',NULL,'Salutation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','5','(''UA''=''Q,'')','EDISQBCENMZ0','50','D','50','5',NULL,'FirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','6','(''UA''=''Q,'')','EDISQBCENMZ0','50','D','50','6',NULL,'MiddleInitial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','7','(''UA''=''Q,'')','EDISQBCENMZ0','50','D','50','7',NULL,'LastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''SS''=''Q,'')','EDISQBCENMZ0','50','D','50','8',NULL,'Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''SS''=''Q,'')','EDISQBCENMZ0','50','D','50','9',NULL,'Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''SS''=''Q,'')','EDISQBCENMZ0','50','D','50','10',NULL,'Phone2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIsAddressSame"','11','(''UA''=''Q,'')','EDISQBCENMZ0','50','D','50','11',NULL,'AddressSameAsQB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','12','(''UA''=''Q,'')','EDISQBCENMZ0','50','D','50','12',NULL,'Address1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','13','(''UA''=''Q,'')','EDISQBCENMZ0','50','D','50','13',NULL,'Address2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','14','(''UA''=''Q,'')','EDISQBCENMZ0','50','D','50','14',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','15','(''UA''=''Q,'')','EDISQBCENMZ0','50','D','50','15',NULL,'StateOrProvince',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','16','(''UA''=''Q,'')','EDISQBCENMZ0','50','D','50','16',NULL,'PostalCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','17','(''SS''=''Q,'')','EDISQBCENMZ0','50','D','50','17',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''SS''=''Q,'')','EDISQBCENMZ0','50','D','50','18',NULL,'EnrollmentDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','19','(''UA''=''Q,'')','EDISQBCENMZ0','50','D','50','19',NULL,'Sex',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','20','(''UD101''=''Q,'')','EDISQBCENMZ0','50','D','50','20',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvISQMCO"','21','(''UA''=''Q'')','EDISQBCENMZ0','50','D','50','21',NULL,'IsQMCSO',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBDEPENDENTPLANINITIAL]"','1','(''DA''=''Q,'')','EDISQBCENMZ0','50','D','60','1',NULL,'Record Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanName"','2','(''UA''=''Q'')','EDISQBCENMZ0','50','D','60','2',NULL,'PlanName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBSUBSIDYSCHEDULE]"','1','(''DA''=''Q,'')','EDISQBCENMZ0','50','D','65','1',NULL,'Record Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvInsuranceType"','2','(''UA''=''Q,'')','EDISQBCENMZ0','50','D','65','2',NULL,'InsuranceType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubAmtType"','3','(''UA''=''Q,'')','EDISQBCENMZ0','50','D','65','3',NULL,'SubsidyAmountType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStartDate"','4','(''UA''=''Q,'')','EDISQBCENMZ0','50','D','65','4',NULL,'StartDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEndDate"','5','(''UA''=''Q,'')','EDISQBCENMZ0','50','D','65','5',NULL,'EndDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAmount"','6','(''UA''=''Q,'')','EDISQBCENMZ0','50','D','65','6',NULL,'Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubsidyType"','7','(''UA''=''Q'')','EDISQBCENMZ0','50','D','65','7',NULL,'SubsidyType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBPLANMEMBERSPECIFICRATEINITIAL]"','1','(''DA''=''Q,'')','EDISQBCENMZ0','50','D','70','1',NULL,'Record Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanName"','2','(''UA''=''Q,'')','EDISQBCENMZ0','50','D','70','2',NULL,'PlanName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRate"','3','(''UA''=''Q'')','EDISQBCENMZ0','50','D','70','3',NULL,'Rate',NULL,NULL);

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
/*08*/ DECLARE @FileName varchar(1000) = 'EDISQBCENM_20210922.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Cobra QB Export','202108311','EMPEXPORT','ONDEMAND','Sep  7 2021 10:31AM','EDISQBCENM',NULL,NULL,NULL,'202108311','Aug 31 2021 12:00AM','Aug 31 2021 12:00AM','202108011','1','','','202108011',dbo.fn_GetTimedKey(),NULL,'us3cPeCEN1026',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N',',OF23C,OZRL6,OF1U9,NXZEW,C9RHG',NULL,NULL,NULL,'Discovery QB Wkly Tue@5am','202105189','EMPEXPORT','SCHEDDCQB','Nov 14 2019 12:00AM','EDISQBCENM',NULL,NULL,NULL,'202109219','Nov 14 2019 12:00AM','Dec 30 1899 12:00AM','202109141',NULL,'','','202105111',dbo.fn_GetTimedKey(),NULL,'ULTI_WPCENM',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Test Cobra Export','202107289','EMPEXPORT','TEST','Sep  7 2021 11:02AM','EDISQBCENM',NULL,NULL,NULL,'202107289','Jul 28 2021 12:00AM','Dec 30 1899 12:00AM','202107281','1','','','202107281',dbo.fn_GetTimedKey(),NULL,'us3cPeCEN1026',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISQBCENM','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISQBCENM','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISQBCENM','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISQBCENM','SubSort2','C','drvSubSort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISQBCENM','SubSort3','C','drvSubSort3');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISQBCENM','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISQBCENM','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISQBCENM','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISQBCENM','D20','dbo.U_EDISQBCENM_drvTbl_QB WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISQBCENM','D30','dbo.U_EDISQBCENM_drvTbl_QBEVENT WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISQBCENM','D40','dbo.U_EDISQBCENM_drvTbl_QBPLAN WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISQBCENM','D50','dbo.U_EDISQBCENM_drvTbl_QBDEP WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISQBCENM','D60','dbo.U_EDISQBCENM_drvTbl_QBDEPPLAN WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISQBCENM','D65','dbo.U_EDISQBCENM_drvTbl_QBSUBSIDY WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISQBCENM','D70','dbo.U_EDISQBCENM_drvTbl_QBMSRI WITH (NOLOCK)',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EDISQBCENM
-----------

IF OBJECT_ID('U_dsi_BDM_EDISQBCENM') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EDISQBCENM] (
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
-- Create table U_EDISQBCENM_drvTbl_QB
-----------

IF OBJECT_ID('U_EDISQBCENM_drvTbl_QB') IS NULL
CREATE TABLE [dbo].[U_EDISQBCENM_drvTbl_QB] (
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
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvGender] char(1) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvSubSort] varchar(23) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(208) NULL
);

-----------
-- Create table U_EDISQBCENM_drvTbl_QBDEP
-----------

IF OBJECT_ID('U_EDISQBCENM_drvTbl_QBDEP') IS NULL
CREATE TABLE [dbo].[U_EDISQBCENM_drvTbl_QBDEP] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NULL,
    [drvSSN] char(11) NOT NULL,
    [drvRelationship] varchar(15) NOT NULL,
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
    [drvSubSort] varchar(23) NULL,
    [drvSubSort2] varchar(13) NOT NULL,
    [drvSubSort3] varchar(208) NULL
);

-----------
-- Create table U_EDISQBCENM_drvTbl_QBDEPPLAN
-----------

IF OBJECT_ID('U_EDISQBCENM_drvTbl_QBDEPPLAN') IS NULL
CREATE TABLE [dbo].[U_EDISQBCENM_drvTbl_QBDEPPLAN] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NULL,
    [drvDedCode] char(5) NULL,
    [drvPlanName] varchar(50) NULL,
    [drvSubSort] varchar(23) NULL,
    [drvSubSort2] varchar(18) NULL,
    [drvSubSort3] varchar(208) NULL
);

-----------
-- Create table U_EDISQBCENM_drvTbl_QBEVENT
-----------

IF OBJECT_ID('U_EDISQBCENM_drvTbl_QBEVENT') IS NULL
CREATE TABLE [dbo].[U_EDISQBCENM_drvTbl_QBEVENT] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NOT NULL,
    [drvEventType] varchar(29) NOT NULL,
    [drvEventDate] datetime NULL,
    [drvEnrollmentDate] datetime NULL,
    [drvSSN] char(11) NULL,
    [drvName] varchar(201) NULL,
    [drvSubSort] varchar(23) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(208) NULL
);

-----------
-- Create table U_EDISQBCENM_drvTbl_QBMSRI
-----------

IF OBJECT_ID('U_EDISQBCENM_drvTbl_QBMSRI') IS NULL
CREATE TABLE [dbo].[U_EDISQBCENM_drvTbl_QBMSRI] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NOT NULL,
    [drvPlanName] varchar(50) NULL,
    [drvRate] money NULL,
    [drvSubSort] varchar(23) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(208) NULL
);

-----------
-- Create table U_EDISQBCENM_drvTbl_QBPLAN
-----------

IF OBJECT_ID('U_EDISQBCENM_drvTbl_QBPLAN') IS NULL
CREATE TABLE [dbo].[U_EDISQBCENM_drvTbl_QBPLAN] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NOT NULL,
    [drvDedCode] char(5) NULL,
    [drvPlanName] varchar(50) NULL,
    [drvCoverageLevel] varchar(18) NULL,
    [drvSubSort] varchar(23) NULL,
    [drvSubSort2] varchar(6) NULL,
    [drvSubSort3] varchar(208) NULL
);

-----------
-- Create table U_EDISQBCENM_drvTbl_QBSUBSIDY
-----------

IF OBJECT_ID('U_EDISQBCENM_drvTbl_QBSUBSIDY') IS NULL
CREATE TABLE [dbo].[U_EDISQBCENM_drvTbl_QBSUBSIDY] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NOT NULL,
    [drvInsuranceType] varchar(7) NULL,
    [drvSubAmtType] varchar(10) NOT NULL,
    [drvStartDate] varchar(30) NULL,
    [drvEndDate] varchar(30) NULL,
    [drvAmount] varchar(3) NOT NULL,
    [drvSubsidyType] varchar(8) NOT NULL,
    [drvSubSort] varchar(23) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(208) NULL
);

-----------
-- Create table U_EDISQBCENM_EEList
-----------

IF OBJECT_ID('U_EDISQBCENM_EEList') IS NULL
CREATE TABLE [dbo].[U_EDISQBCENM_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EDISQBCENM_File
-----------

IF OBJECT_ID('U_EDISQBCENM_File') IS NULL
CREATE TABLE [dbo].[U_EDISQBCENM_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EDISQBCENM]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Centerfield Media Holding Company

Created By: Ashley Schaeffer
Business Analyst: Nick Watkins
Create Date: 11/14/2019
Service Request Number: CEN1026-2019-00247232

Purpose: Discovery Benefits Cobra Export

Revision History
----------------
Update By            Date           Request Num        Desc
Shawn Nakamura       09/25/2020     SF19018221         Updated company name to Centerfield Media Holding Company 30414
Katrina Prather        04/12/2021        SR-2021-00308415   Remove codes 'EPO2S','EPO2W','EPO5S','EPO5W',SEV’ and ‘SEVW4’. Added 2 new divisions and new ded codes and plans per structure. Updated divisions w/ new locations.
Darren Collard      05/03/2021      SR-2021-00308415   Update Departments to Business, CA/NY, Remote Corporate, Savings, Remove Subsidy Rows


SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EDISQBCENM';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EDISQBCENM';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EDISQBCENM';
SELECT * FROM dbo.AscExp WHERE expFormatCode = 'EDISQBCENM';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EDISQBCENM' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISQBCENM', 'NPMFILE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISQBCENM', 'QBFILE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISQBCENM', 'TESTNPM';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISQBCENM', 'TESTQB';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EDISQBCENM';

EXEC dbo._dsi_usp_ExportRipOut_v7 @FormatCode = 'EDISQBCENM', @AllObjects = 'Y', @IsWeb = 'Y';
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
    SET @FormatCode = 'EDISQBCENM';

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
    DELETE FROM dbo.U_EDISQBCENM_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCoID(xEEID)
      AND xEEID IN (SELECT xEEID FROM dbo.U_EDISQBCENM_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


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
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','Y'); -- DedIsCobraCovered = 'Y'
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraType','2'); --Pull Cobra reasons from EepCobraReason and ConCobraReason
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraDate','3'); --Pull Cobra dates from EepDateofCobraEvent and ConDateofCobraEvent
        
        --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'ConCobraReasonPCF', '<SQL PCF Name>');  
        --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'ConDateOfCobraEventPCF', '<SQL PCF Name>');
        
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraPQBType','1'); -- If no EE or spouse, ALL children are PQB (not just oldest)
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidTermReasonsEmp','203'); -- Invalidate employee when Cobra Reason is "Death"
        INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'InvalidCobraReasonsEmp', '201,204,210,LEVNT3,LEVNT4')
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraReasonsDepPQB','201,204,210,LEVNT3,LEVNT4');

        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CountDependents','Y');
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS,DP');
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL,DPC,GRC,STC');

        INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'CobraPQBMulti', '1');

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
        ------------------
        -- QB DETAIL RECORD
        ------------------
        IF OBJECT_ID('U_EDISQBCENM_drvTbl_QB') IS NOT NULL
            DROP TABLE dbo.U_EDISQBCENM_drvTbl_QB;
        SELECT DISTINCT
             drvEEID           = BdmEEID
            ,drvCoID           = BdmCoID
            ,drvDepRecID       = ISNULL(BdmDepRecID,'')
            ,drvClientName        = CONVERT(varchar(100),'Centerfield Media Holding Company 30414')--CONVERT(varchar(100),'Centerfield 30414') --9/25/2020 SN SF19018221
            ,drvClientDivName    = CONVERT(varchar(50),
                                    case 
                                    when locImportCode = 'DCANY' THEN 'CA/NY Corporate'
                                    when locImportCode = 'DREM'  THEN 'Remote Corporate'
                                    when locImportCode = 'DBUS'  THEN 'Business'
                                    when locImportCode = 'DSAV'  THEN 'Savings'
                                    when EecLocation IN ('CALA','NYNY','CACM','CAREM') then 'CA/NY Corporate'
                                    when EecLocation IN ('MABOS','FLFL','GAREM','FLREM', 'WAREM','CTREM','TXREM''IAREM', 'COREM','IL','MDREM', 'MIREM','MONT','NCREM',
                                                         'NHREM','NJ','NVREM','ORREM','RIREM','WDCREM') then 'Remote Corporate'
                                    when EecLocation IN ('BDCCA','BDCCT','BDCIL','KYREM','MAREM','BDCNH','BDCNJ','BDCNY','BDCUT') then 'Business'
                                    when EecLocation IN ('SDCCAL','SDCNYR','SDCTXR','MEREM') then 'Savings'
                                    end)
                                    
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
            --------------------
            ,drvSubSort        = CASE WHEN BdmRecType = 'EMP' THEN 
                                            CASE
                                            WHEN eepSSN = '999999999' then CONCAT(RTRIM(eepSSN),eepEEID)
                                            ELSE RTRIM(eepSSN)
                                            END
                                      ELSE CONCAT(RTRIM(ISNULL(NULLIF(ConSSN,''),eepSSN)),ISNULL(NULLIF(conEEID,''),eepEEID))
                                        --RTRIM(ISNULL(NULLIF(ConSSN,''),eepSSN)) + CONVERT(char(8),ConDateOfBirth,112)
                                 END
            ,drvSubSort2       = '1'
            ,drvSubSort3       = CASE WHEN BdmRecType = 'EMP' THEN '2'
                                      ELSE CONVERT(char(8),ConDateOfBirth,112) + RTRIM(ConNameLast) + ConNameFirst
                                 END
        INTO dbo.U_EDISQBCENM_drvTbl_QB
        FROM dbo.U_dsi_BDM_EDISQBCENM WITH (NOLOCK)
        JOIN dbo.EmpComp WITH (NOLOCK)
            ON EecEEID = BdmEEID
           AND EecCoID = BdmCoID
        JOIN dbo.EmpPers WITH (NOLOCK)
            ON EepEEID = BdmEEID
        JOIN dbo.Location 
            ON LocCode = EecLocation
        LEFT JOIN dbo.Contacts WITH (NOLOCK)
            ON ConEEID = BdmEEID
           AND ConSystemID = BdmDepRecID
        WHERE BdmIsPQB = 'Y';

        ------------------
        -- QBEVENT DETAIL RECORD
        ------------------
        IF OBJECT_ID('U_EDISQBCENM_drvTbl_QBEVENT') IS NOT NULL
            DROP TABLE dbo.U_EDISQBCENM_drvTbl_QBEVENT;
        SELECT DISTINCT
             drvEEID           = drvEEID
            ,drvCoID           = drvCoID
            ,drvDepRecID       = drvDepRecID
            ,drvEventType      = CASE WHEN EecTermReason = '202' THEN 'RETIREMENT'
                                      WHEN EecTermReason = '203' THEN 'DEATH'
                                      WHEN BdmCobraReason IN ('201','LEVNT3') THEN 'INELIGIBLEDEPENDENT'
                                      WHEN BdmCobraReason IN ('204','LEVNT4') THEN 'DIVORCELEGALSEPARATION'
                                      WHEN BdmCobraReason = '210' THEN 'DEATH'
                                      WHEN BdmCobraReason IN ('202','CHGRP') THEN 'LOSSOFELIGIBILITY'
                                      WHEN BdmCobraReason = '203' THEN 'REDUCTIONINHOURS-STATUSCHANGE'
                                      WHEN BdmCobraReason = '205' THEN 'MEDICARE'
                                      WHEN BdmCobraReason = '206' THEN 'REDUCTIONINHOURS-ENDOFLEAVE'
                                      WHEN BdmCobraReason = '207' THEN 'USERRA-REDUCTIONINHOURS'
                                      WHEN BdmCobraReason = '208' THEN 'RETIREMENT'
                                      WHEN BdmCobraReason = '209' THEN 'WORKSTOPPAGE'
                                      ELSE 'TERMINATION'
                                 END
            ,drvEventDate      = BdmDateOfCOBRAEvent
            ,drvEnrollmentDate = BdmBenStartDate
            ,drvSSN            = eepSSN
            ,drvName           = CASE WHEN BdmRecType = 'DEP' THEN RTRIM(EepNameFirst) + ' ' + EepNameLast
                                      ELSE ''
                                 END
            ,drvSubSort        = drvSubSort
            ,drvSubSort2       = '1'
            ,drvSubSort3       = drvSubSort3
        INTO dbo.U_EDISQBCENM_drvTbl_QBEVENT
        FROM dbo.U_EDISQBCENM_drvTbl_QB WITH (NOLOCK)
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
              FROM dbo.U_dsi_BDM_EDISQBCENM WITH (NOLOCK)
              WHERE BdmIsPQB = 'Y'
              GROUP BY BdmEEID, BdmCoID, BdmDepRecID, BdmRecType) BDM
            ON BdmEEID = drvEEID
           AND BdmCoID = drvCoID
           AND ISNULL(BdmDepRecID,'') = drvDepRecID;

        ------------------
        -- QBPLANINITIAL DETAIL RECORD
        ------------------
        IF OBJECT_ID('U_EDISQBCENM_drvTbl_QBPLAN') IS NOT NULL
            DROP TABLE dbo.U_EDISQBCENM_drvTbl_QBPLAN;
        SELECT DISTINCT
             drvEEID          = drvEEID
            ,drvCoID          = drvCoID
            ,drvDepRecID      = drvDepRecID
            ,drvDedCode       = BdmDedCode
            ,drvPlanName      = CONVERT(varchar(50), case
                                    when bdmDedCode IN ('DENHE','DENHS','DENHW','SDPHW','SDPHS') then 'UHC Dental High New'
                                    when bdmDedCode IN ('DENLS','DENLW','VDELS','VDELW','SDPLW','SDPLS','DENLN','DENLS','DENLW') then 'UHC Dental Low New'
                                    when bdmDedCode IN ('HMOS','HMOW','SHMOS','SHMOW') then 'UHC Medical CA HMO'
                                --kp 4/13/21    when bdmDedCode IN ('EPO2S','EPO2W') then 'UHC Medical EPO 250'
                                --kp 4/13/21    when bdmDedCode IN ('EPO5S','EPO5W') then 'UHC Medical EPO 500'
                                    when bdmDedCode IN ('EPO7W') then 'UHC Medical EPO 750'  --KP 4/21/21
                                    when bdmDedCode IN ('PPODS','PPODW','SPP5S','SPP5W') then 'UHC Medical PPO 500'
                                    when bdmDedCode IN ('PPOZE','PPOZS','PPOZW','PPONW','PPZSF','SPPZS','SPPZW') then 'UHC Medical PPO Zero'
                                    when bdmDedCode IN ('VISS','VISSE','VVISS','VVISW','VINCW','SVW','SVS') then 'UHC Vision New'
                                    end)
            ,drvCoverageLevel = CASE WHEN BdmDedType = 'FSA' THEN 'EE'
                                     WHEN BdmRecType = 'EMP' THEN
                                          CASE WHEN BdmBenOption IN ('EE') THEN 'EE'
                                               WHEN BdmBenOption IN ('EEC') THEN 'EE+CHILDREN'
                                               WHEN BdmBenOption IN ('EES') THEN 'EE+SPOUSE'
                                               WHEN BdmBenOption IN ('EEDP') THEN 'EE+DOMESTICPARTNER'
                                               WHEN BdmBenOption IN ('EEF','EEDPF') THEN 'EE+FAMILY'
                                          END
                                     WHEN BdmRelationship IN ('SPS','DP') THEN
                                          CASE WHEN NdpNumDeps = 1 THEN 'EE+CHILD'
                                               WHEN NdpNumDeps > 1 THEN 'EE+CHILDREN'
                                               ELSE 'EE'
                                          END
                                     ELSE 'EE'
                                END
            ,drvSubSort       = drvSubSort
            ,drvSubSort2      = '1' + BdmDedCode
            ,drvSubSort3      = drvSubSort3
        INTO dbo.U_EDISQBCENM_drvTbl_QBPLAN
        FROM dbo.U_EDISQBCENM_drvTbl_QBEVENT WITH (NOLOCK)
        JOIN dbo.U_dsi_BDM_EDISQBCENM WITH (NOLOCK)
            ON BdmEEID = drvEEID
           AND BdmCoID = drvCoID
           AND ISNULL(BdmDepRecID,'') = drvDepRecID
        -- Subselect of BDM for count of deps for non-EE PQB
        LEFT JOIN (SELECT  NdpEEID    = BdmEEID
                          ,NdpDedCode = BdmDedCode
                          ,NdpNumDeps = COUNT(1)
                   FROM (SELECT DISTINCT BdmEEID, BdmDepRecID, BdmDedCode
                         FROM dbo.U_dsi_BDM_EDISQBCENM WITH (NOLOCK)
                         WHERE BdmIsPQB = 'N') NDEP
                   GROUP BY BdmEEID, BdmDedCode) NDP
            ON NdpEEID = BdmEEID
           AND NdpDedCode = BdmDedCode
        WHERE BdmIsPQB = 'Y';

        ------------------
        -- QBDEPENDENT DETAIL RECORD
        ------------------
        IF OBJECT_ID('U_EDISQBCENM_drvTbl_QBDEP') IS NOT NULL
            DROP TABLE dbo.U_EDISQBCENM_drvTbl_QBDEP;
        SELECT DISTINCT
             drvEEID           = BdmEEID
            ,drvCoID           = BdmCoID
            ,drvDepRecID       = BdmDepRecID
            ,drvSSN            = ISNULL(ConSSN,'')
            ,drvRelationship   = CASE WHEN BdmRelationship IN ('SPS') THEN 'SPOUSE'
                                      WHEN BdmRelationship IN ('DP') THEN 'DOMESTICPARTNER'
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
            ,drvISQMCO         = CASE WHEN BdmRelationship IN ('@QMCORelationships') THEN 'TRUE'
                                      ELSE 'FALSE'
                                 END
            ,drvSubSort        = drvSubSort
            ,drvSubSort2       = '2' + CASE WHEN BdmRelationship IN ('SPS','DP') THEN 'A'
                                            ELSE 'B' + ISNULL(ConSSN,'')
                                       END
            ,drvSubSort3       = drvSubSort3
        INTO dbo.U_EDISQBCENM_drvTbl_QBDEP
        FROM dbo.U_EDISQBCENM_drvTbl_QB WITH (NOLOCK)
        JOIN dbo.U_dsi_BDM_EDISQBCENM WITH (NOLOCK)
            ON BdmEEID = drvEEID
           AND BdmCoID = drvCoID
        JOIN dbo.Contacts WITH (NOLOCK)
            ON ConEEID = BdmEEID
           AND ConSystemID = BdmDepRecID
        WHERE BdmIsPQB = 'N';

        ------------------
        -- QBDEPENDENTPLANINITIAL DETAIL RECORD
        ------------------
        IF OBJECT_ID('U_EDISQBCENM_drvTbl_QBDEPPLAN') IS NOT NULL
            DROP TABLE dbo.U_EDISQBCENM_drvTbl_QBDEPPLAN;
        SELECT DISTINCT
             drvEEID     = BdmEEID
            ,drvCoID     = BdmCoID
            ,drvDepRecID = BdmDepRecID
            ,drvDedCode  = BdmDedCode
            ,drvPlanName = drvPlanName
            ,drvSubSort  = drvSubSort
            ,drvSubSort2 = '2' + CASE WHEN BdmRelationship IN ('SPS','DP') THEN 'A'
                                      ELSE 'B' + RTRIM(ISNULL(ConSSN,''))
                                 END + BdmDedCode
            ,drvSubSort3 = drvSubSort3
        INTO dbo.U_EDISQBCENM_drvTbl_QBDEPPLAN
        FROM dbo.U_EDISQBCENM_drvTbl_QBPLAN WITH (NOLOCK)
        JOIN dbo.U_dsi_BDM_EDISQBCENM WITH (NOLOCK)
            ON BdmEEID = drvEEID
           AND BdmCoID = drvCoID
           AND BdmDedCode = drvDedCode
        JOIN dbo.Contacts WITH (NOLOCK)
            ON ConEEID = BdmEEID
           AND ConSystemID = BdmDepRecID
        WHERE BdmIsPQB = 'N';

        ------------------
        -- QBSUBSIDYSCHEDULE DETAIL RECORD
        ------------------
        IF OBJECT_ID('U_EDISQBCENM_drvTbl_QBSUBSIDY') IS NOT NULL
            DROP TABLE dbo.U_EDISQBCENM_drvTbl_QBSUBSIDY;
        SELECT DISTINCT
             drvEEID     = drvEEID
            ,drvCoID     = drvCoID
            ,drvDepRecID = drvDepRecID
            --------------------------------
            ,drvInsuranceType = case
                                when bdmDedType = 'MED' then 'MEDICAL'
                                when bdmDedType = 'DEN' then 'DENTAL'
                                when bdmDedType = 'VIS' then 'VISION'
                                end
            ,drvSubAmtType = 'PERCENTAGE'
            ,drvStartDate = convert(varchar, eeeStartDate, 101)
            ,drvEndDate = convert(varchar, eeeStopDate, 101)
            ,drvAmount = '100'
            ,drvSubsidyType = 'EMPLOYER'
            --------------------------------
            ,drvSubSort  = drvSubSort
            ,drvSubSort2 = '3'
            ,drvSubSort3 = drvSubSort3
        INTO dbo.U_EDISQBCENM_drvTbl_QBSUBSIDY
        FROM dbo.U_EDISQBCENM_drvTbl_QBPLAN WITH (NOLOCK)
        JOIN dbo.U_dsi_BDM_EDISQBCENM WITH (NOLOCK)
            ON BdmEEID = drvEEID
           AND BdmCoID = drvCoID
           AND ISNULL(BdmDepRecID,'') = drvDepRecID
           AND BdmDedCode = drvDedCode
        JOIN dbo.EmpComp WITH (NOLOCK)
            ON EecEEID = BdmEEID
           AND EecCoID = BdmCoID
        JOIN dbo.EmpEarn WITH (NOLOCK)
            ON eeeEEID = bdmEEID
            and eeeCOID = bdmCOID
    --kp 4/13/21        and eeeEarnCode IN ('SEV','SEVW4')
        WHERE BdmIsPQB = 'Y'

--  DC - 5/14/2021 - This is no longer required since Centerfield don’t offer a COBRA subsidy. If putting back in, the filter removed 
--                   for SEV/SEVW4 caused a bug due to multiple rows on the join to EmpEarn which will need to be addressed. Needs a 
--                     better way to determine COBRA subsidy start / end date.
        AND 1=0;


        ------------------
        -- QBPLANMEMBERSPECIFICRATEINITIAL DETAIL RECORD
        ------------------
        IF OBJECT_ID('U_EDISQBCENM_drvTbl_QBMSRI') IS NOT NULL
            DROP TABLE dbo.U_EDISQBCENM_drvTbl_QBMSRI;
        SELECT DISTINCT
             drvEEID     = drvEEID
            ,drvCoID     = drvCoID
            ,drvDepRecID = drvDepRecID
            ,drvPlanName = drvPlanName
            ,drvRate     = CASE WHEN EecPayPeriod = 'M' THEN BdmEEAmt
                                WHEN EecPayPeriod = 'S' THEN BdmEEAmt * 2
                                WHEN EecPayPeriod = 'B' THEN BdmEEAmt * 26/12
                                WHEN EecPayPeriod = 'W' THEN BdmEEAmt * 52/12
                           END
            ,drvSubSort  = drvSubSort
            ,drvSubSort2 = '4'
            ,drvSubSort3 = drvSubSort3
        INTO dbo.U_EDISQBCENM_drvTbl_QBMSRI
        FROM dbo.U_EDISQBCENM_drvTbl_QBPLAN WITH (NOLOCK)
        JOIN dbo.U_dsi_BDM_EDISQBCENM WITH (NOLOCK)
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
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
        SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' AND @ExportCode LIKE '%NPM%' THEN '_TEST_' + CONVERT(char(8),GETDATE(),112) + '_@FileCustomerName_NPM_@FileCustomerNumber.txt'
                              WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' AND @ExportCode LIKE '%QB%' THEN '_TEST_' + CONVERT(char(8),GETDATE(),112) + '_@FileCustomerName_QB_@FileCustomerNumber.txt'
                              WHEN @ExportCode = 'TESTNPM' THEN '_TEST_' + CONVERT(char(8),GETDATE(),112) + '_@FileCustomerName_NPM_@FileCustomerNumber.txt'
                              WHEN @ExportCode = 'TESTQB' THEN '_TEST_' + CONVERT(char(8),GETDATE(),112) + '_@FileCustomerName_QB_@FileCustomerNumber.txt'
                              WHEN @ExportCode = 'NPMFILE' THEN CONVERT(char(8),GETDATE(),112) + '_@FileCustomerName_NPM_@FileCustomerNumber.txt'
                              WHEN @ExportCode = 'QBFILE' THEN CONVERT(char(8),GETDATE(),112) + '_@FileCustomerName_QB_@FileCustomerNumber.txt'
                         END
        WHERE FormatCode = @FormatCode;
    END;
END;
/*
--Alter the View
ALTER VIEW dbo.dsi_vwEDISQBCENM_Export AS
    SELECT TOP 2000000 Data
    FROM dbo.U_EDISQBCENM_File WITH (NOLOCK)
    ORDER BY InitialSort, SubSort, SubSort2, SubSort3, RecordSet;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EDISQBCENM%'
ORDER BY AdfSetNumber, AdfFieldNumber;

SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EDISQBCENM' ORDER BY RunID DESC;

--Update Dates
UPDATE dbo.AscExp
SET expLastStartPerControl = '202104201'
    ,expStartPerControl     = '202104201'
    ,expLastEndPerControl   = '202104269'
    ,expEndPerControl       = '202104269'
 ,expAscFileName         = '\\us.saas\NW1\NW15\Downloads\V10\Exports\CENM\EmployeeHistoryExport\EDISQBCENM_TEST_' + CONVERT(varchar, GETDATE(),112) + '.txt'
--   ,expCOIDList            = ''
--   ,expSelectByField       = ''
--   ,expSelectByList        = ''
WHERE expFormatCode = 'EDISQBCENM'
  AND expExportCode LIKE 'TEST%';


EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISQBCENM', 'TEST';
  
*/
SET NOCOUNT OFF;
GO
CREATE VIEW dbo.dsi_vwEDISQBCENM_Export AS
    SELECT TOP 2000000 Data
    FROM dbo.U_EDISQBCENM_File WITH (NOLOCK)
    ORDER BY InitialSort, SubSort, SubSort2, SubSort3, RecordSet;

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EDISQBCENM' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EDISQBCENM'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EDISQBCENM'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EDISQBCENM', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EDISQBCENM', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EDISQBCENM', 'UseFileName', 'V', 'Y'
