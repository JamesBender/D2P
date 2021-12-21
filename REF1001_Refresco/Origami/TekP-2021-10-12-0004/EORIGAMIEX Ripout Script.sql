/**********************************************************************************

EORIGAMIEX: Origami Export

FormatCode:     EORIGAMIEX
Project:        Origami Export
Client ID:      REF1001
Date/time:      2021-12-20 19:49:48.960
Ripout version: 7.4
Export Type:    Back Office
Status:         Production
Environment:    E43
Server:         E4SUP3DB01
Database:       ULTIPRO_RBUS
ExportPath:    \\us.saas\E0\data_exchange\REF1001\Exports\
TestPath:      \\us.saas\e4\Public\REF1001\Exports\Origami\

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EORIGAMIEX_SavePath') IS NOT NULL DROP TABLE dbo.U_EORIGAMIEX_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EORIGAMIEX'


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
WHERE FormatCode = 'EORIGAMIEX'
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
WHERE ExpFormatCode = 'EORIGAMIEX'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EORIGAMIEX')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EORIGAMIEX'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EORIGAMIEX'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EORIGAMIEX'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EORIGAMIEX'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EORIGAMIEX'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EORIGAMIEX'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EORIGAMIEX'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EORIGAMIEX'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EORIGAMIEX'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEORIGAMIEX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEORIGAMIEX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EORIGAMIEX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EORIGAMIEX];
GO
IF OBJECT_ID('U_EORIGAMIEX_File') IS NOT NULL DROP TABLE [dbo].[U_EORIGAMIEX_File];
GO
IF OBJECT_ID('U_EORIGAMIEX_EEList') IS NOT NULL DROP TABLE [dbo].[U_EORIGAMIEX_EEList];
GO
IF OBJECT_ID('U_EORIGAMIEX_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EORIGAMIEX_drvTbl];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EORIGAMIEX','Origami Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','EORIGAMIEXZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EORIGAMIEXZ0','50','H','01','1',NULL,'EmployeeNumber',NULL,NULL,'"EmployeeNumber"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EORIGAMIEXZ0','50','H','01','2',NULL,'SocialSecurity',NULL,NULL,'"SocialSecurity"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EORIGAMIEXZ0','50','H','01','3',NULL,'LastName',NULL,NULL,'"LastName"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EORIGAMIEXZ0','50','H','01','4',NULL,'FirstName',NULL,NULL,'"FirstName"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EORIGAMIEXZ0','50','H','01','5',NULL,'MiddleName',NULL,NULL,'"MiddleName"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EORIGAMIEXZ0','50','H','01','6',NULL,'Address1',NULL,NULL,'"Address1"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EORIGAMIEXZ0','50','H','01','7',NULL,'Address2',NULL,NULL,'"Address2"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EORIGAMIEXZ0','50','H','01','8',NULL,'City',NULL,NULL,'"City"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EORIGAMIEXZ0','50','H','01','9',NULL,'State',NULL,NULL,'"State"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EORIGAMIEXZ0','50','H','01','10',NULL,'PostalCode',NULL,NULL,'"PostalCode"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EORIGAMIEXZ0','50','H','01','11',NULL,'HomePhone',NULL,NULL,'"HomePhone"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EORIGAMIEXZ0','50','H','01','12',NULL,'WorkPhone',NULL,NULL,'"WorkPhone"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EORIGAMIEXZ0','50','H','01','13',NULL,'CellPhone',NULL,NULL,'"CellPhone"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EORIGAMIEXZ0','50','H','01','14',NULL,'Email1',NULL,NULL,'"Email1"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EORIGAMIEXZ0','50','H','01','15',NULL,'Email2',NULL,NULL,'"Email2"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EORIGAMIEXZ0','50','H','01','16',NULL,'BirthDate',NULL,NULL,'"BirthDate"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EORIGAMIEXZ0','50','H','01','17',NULL,'MaritalStatus',NULL,NULL,'"MaritalStatus"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EORIGAMIEXZ0','50','H','01','18',NULL,'Gender',NULL,NULL,'"Gender"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EORIGAMIEXZ0','50','H','01','19',NULL,'HireDate',NULL,NULL,'"HireDate"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EORIGAMIEXZ0','50','H','01','20',NULL,'EmploymentStatus',NULL,NULL,'"EmploymentStatus"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EORIGAMIEXZ0','50','H','01','21',NULL,'AverageWeeklyWage',NULL,NULL,'"AverageWeeklyWage"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EORIGAMIEXZ0','50','H','01','22',NULL,'Salary',NULL,NULL,'"Salary"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EORIGAMIEXZ0','50','H','01','23',NULL,'Location',NULL,NULL,'"Location"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EORIGAMIEXZ0','50','H','01','24',NULL,'Department',NULL,NULL,'"Department"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EORIGAMIEXZ0','50','H','01','25',NULL,'Supervisor ID',NULL,NULL,'"Supervisor ID"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EORIGAMIEXZ0','50','H','01','26',NULL,'Supervisor Name',NULL,NULL,'"Supervisor Name"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EORIGAMIEXZ0','50','D','10','1',NULL,'EmployeeNumber',NULL,NULL,'"drvEmployeeNumber"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EORIGAMIEXZ0','50','D','10','2',NULL,'SocialSecurity',NULL,NULL,'"drvSocialSecurity"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EORIGAMIEXZ0','50','D','10','3',NULL,'LastName',NULL,NULL,'"drvLastName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EORIGAMIEXZ0','50','D','10','4',NULL,'FirstName',NULL,NULL,'"drvFirstName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EORIGAMIEXZ0','50','D','10','5',NULL,'MiddleName',NULL,NULL,'"drvMiddleName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EORIGAMIEXZ0','50','D','10','6',NULL,'Address1',NULL,NULL,'"drvAddress1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EORIGAMIEXZ0','50','D','10','7',NULL,'Address2',NULL,NULL,'"drvAddress2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EORIGAMIEXZ0','50','D','10','8',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EORIGAMIEXZ0','50','D','10','9',NULL,'State',NULL,NULL,'"drvState"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EORIGAMIEXZ0','50','D','10','10',NULL,'PostalCode',NULL,NULL,'"drvPostalCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EORIGAMIEXZ0','50','D','10','11',NULL,'HomePhone',NULL,NULL,'"drvHomePhone"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EORIGAMIEXZ0','50','D','10','12',NULL,'WorkPhone',NULL,NULL,'"drvWorkPhone"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EORIGAMIEXZ0','50','D','10','13',NULL,'CellPhone',NULL,NULL,'"drvCellPhone"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EORIGAMIEXZ0','50','D','10','14',NULL,'Email1',NULL,NULL,'"drvEmail1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EORIGAMIEXZ0','50','D','10','15',NULL,'Email2',NULL,NULL,'"drvEmail2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EORIGAMIEXZ0','50','D','10','16',NULL,'BirthDate',NULL,NULL,'"drvBirthDate"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EORIGAMIEXZ0','50','D','10','17',NULL,'MaritalStatus',NULL,NULL,'"drvMaritalStatus"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EORIGAMIEXZ0','50','D','10','18',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EORIGAMIEXZ0','50','D','10','19',NULL,'HireDate',NULL,NULL,'"drvHireDate"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EORIGAMIEXZ0','50','D','10','20',NULL,'EmploymentStatus',NULL,NULL,'"drvEmploymentStatus"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EORIGAMIEXZ0','50','D','10','21',NULL,'AverageWeeklyWage',NULL,NULL,'"drvAverageWeeklyWage"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EORIGAMIEXZ0','50','D','10','22',NULL,'Salary',NULL,NULL,'"drvSalary"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EORIGAMIEXZ0','50','D','10','23',NULL,'Location',NULL,NULL,'"drvLocation"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EORIGAMIEXZ0','50','D','10','24',NULL,'Department',NULL,NULL,'"drvDepartment"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EORIGAMIEXZ0','50','D','10','25',NULL,'Supervisor ID',NULL,NULL,'"drvSupervisorID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EORIGAMIEXZ0','50','D','10','26',NULL,'Supervisor Name',NULL,NULL,'"drvSupervisorName"','(''UA''=''T'')');

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\ez2sup4db01\ultiprodata\CDONO\Exports\_EOPTHSAEXP_20210520.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Origami Export','202105199','EMPEXPORT','ONDEMAND',NULL,'EORIGAMIEX',NULL,NULL,NULL,'202105199','May 19 2021  6:38AM','May 19 2021  6:38AM','202105191',NULL,'','','202105191',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\ez2sup4db01\ultiprodata\CDONO\Exports\_EOPTHSAEXP_20210520.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','202112199','EMPEXPORT','SCHEDULED','Dec 19 2021 11:00PM','EORIGAMIEX',NULL,NULL,NULL,'202112199','May 19 2021  6:38AM','May 19 2021  6:38AM','202112191',NULL,'','','202112191',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\ez2sup4db01\ultiprodata\CDONO\Exports\_EOPTHSAEXP_20210719.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Test Purposes Only','202107199','EMPEXPORT','TEST','Dec  1 2021 12:32PM','EORIGAMIEX',NULL,NULL,NULL,'202107199','Jul 19 2021 12:00AM','Dec 30 1899 12:00AM','202107191','4471','','','202107191',dbo.fn_GetTimedKey(),NULL,'ULTI_RBUS',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EORIGAMIEX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EORIGAMIEX','ExportPath','V','\\us.saas\E0\data_exchange\REF1001\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EORIGAMIEX','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EORIGAMIEX','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EORIGAMIEX','TestPath','V','\\us.saas\e4\Public\REF1001\Exports\Origami\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EORIGAMIEX','UDESPath','C','\\us.saas\E0\data_exchange\REF1001\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EORIGAMIEX','UseFileName','V','N');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EORIGAMIEX','D10','dbo.U_EORIGAMIEX_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EORIGAMIEX_drvTbl
-----------

IF OBJECT_ID('U_EORIGAMIEX_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EORIGAMIEX_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvEmployeeNumber] char(9) NULL,
    [drvSocialSecurity] char(11) NULL,
    [drvLastName] varchar(100) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleName] varchar(50) NULL,
    [drvAddress1] varchar(255) NULL,
    [drvAddress2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvPostalCode] varchar(50) NULL,
    [drvHomePhone] varchar(50) NULL,
    [drvWorkPhone] varchar(50) NULL,
    [drvCellPhone] varchar(50) NULL,
    [drvEmail1] varchar(50) NULL,
    [drvEmail2] varchar(50) NULL,
    [drvBirthDate] datetime NULL,
    [drvMaritalStatus] varchar(1) NULL,
    [drvGender] char(1) NULL,
    [drvHireDate] datetime NULL,
    [drvEmploymentStatus] char(1) NULL,
    [drvAverageWeeklyWage] money NULL,
    [drvSalary] money NULL,
    [drvLocation] char(6) NULL,
    [drvDepartment] varchar(36) NOT NULL,
    [drvSupervisorID] varchar(256) NULL,
    [drvSupervisorName] varchar(256) NULL
);

-----------
-- Create table U_EORIGAMIEX_EEList
-----------

IF OBJECT_ID('U_EORIGAMIEX_EEList') IS NULL
CREATE TABLE [dbo].[U_EORIGAMIEX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EORIGAMIEX_File
-----------

IF OBJECT_ID('U_EORIGAMIEX_File') IS NULL
CREATE TABLE [dbo].[U_EORIGAMIEX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EORIGAMIEX]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Refresco Beverages US Inc.

Created By: Mykola Pekarskyi
Business Analyst: Josh Smith
Create Date: 05/19/2021
Service Request Number: SR-2021-00305720

Purpose: Origami Export

Revision History
----------------
Update By           Date           Request Num        Desc
Darren Collard        12/8/2021       TekP-2021-10-12-0004  Add additional email 

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EORIGAMIEX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EORIGAMIEX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EORIGAMIEX';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EORIGAMIEX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EORIGAMIEX' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EORIGAMIEX', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EORIGAMIEX', 'TEST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EORIGAMIEX', 'SCHEDULED';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EORIGAMIEX', @AllObjects = 'Y', @IsWeb = 'N'
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
    SELECT @FormatCode = 'EORIGAMIEX';

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
    DELETE FROM dbo.U_EORIGAMIEX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EORIGAMIEX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EORIGAMIEX_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EORIGAMIEX_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EORIGAMIEX_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvEmployeeNumber = EecEmpno
        ,drvSocialSecurity = EepSSN
        ,drvLastName = EepNameLast
        ,drvFirstName = EepNameFirst
        ,drvMiddleName = EepNameMiddle
        ,drvAddress1 = EepAddressLine1
        ,drvAddress2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvPostalCode = EepAddressZipCode
        ,drvHomePhone = EepPhoneHomeNumber
        ,drvWorkPhone = EecPhoneBusinessNumber
        ,drvCellPhone = efoPhoneNumber
        ,drvEmail1 = EepAddressEMail
        ,drvEmail2 = EepAddressEMailAlternate
        ,drvBirthDate = EepDateOfBirth
        ,drvMaritalStatus = IIF(eepMaritalStatus = 'Z','',eepMaritalStatus)
        ,drvGender = EepGender
        ,drvHireDate = EecDateOfLastHire
        ,drvEmploymentStatus = EecEmplStatus
        ,drvAverageWeeklyWage = EecWeeklyPayRate
        ,drvSalary = EecAnnSalary
        ,drvLocation = EecLocation
        ,drvDepartment = CONCAT(EecOrgLvl1,'-',OrgDesc)
        ,drvSupervisorID = dbo.dsi_fnlib_GetSupervisorField('', xEEID, 'EmpNo')
        ,drvSupervisorName = dbo.dsi_fnlib_GetSupervisorField('', xEEID, 'NameFirst Last')
    INTO dbo.U_EORIGAMIEX_drvTbl
    FROM dbo.U_EORIGAMIEX_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN dbo.EmpMPhon WITH (NOLOCK)
        ON efoEEID = xEEID
        AND efoPhoneType = 'CEL'
    LEFT JOIN dbo.vw_int_OrgLevel WITH (NOLOCK)
        ON OrgCode = EecOrgLvl1
        AND OrgLvl = '1'
    WHERE EecEmplStatus IN ('A','L') 

    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_Origami_Refresco_Employees_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE '%TEST%' THEN 'Test_Origami_Refresco_Employees_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'Origami_Refresco_Employees_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'Origami_Refresco_Employees_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEORIGAMIEX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EORIGAMIEX_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EORIGAMIEX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202105121'
       ,expStartPerControl     = '202105121'
       ,expLastEndPerControl   = '202105199'
       ,expEndPerControl       = '202105199'
WHERE expFormatCode = 'EORIGAMIEX';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEORIGAMIEX_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EORIGAMIEX_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EORIGAMIEX'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EORIGAMIEX'
   AND rpoParmType = 'expSystemID'


-- End ripout