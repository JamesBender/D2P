SET NOCOUNT ON;
IF OBJECT_ID('U_ETRINAVELI_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ETRINAVELI_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ETRINAVELI_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ETRINAVELI' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwETRINAVELI_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwETRINAVELI_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ETRINAVELI') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ETRINAVELI];
GO
IF OBJECT_ID('U_ETRINAVELI_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ETRINAVELI_PEarHist];
GO
IF OBJECT_ID('U_ETRINAVELI_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ETRINAVELI_PDedHist];
GO
IF OBJECT_ID('U_ETRINAVELI_File') IS NOT NULL DROP TABLE [dbo].[U_ETRINAVELI_File];
GO
IF OBJECT_ID('U_ETRINAVELI_EEList') IS NOT NULL DROP TABLE [dbo].[U_ETRINAVELI_EEList];
GO
IF OBJECT_ID('U_ETRINAVELI_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ETRINAVELI_drvTbl];
GO
IF OBJECT_ID('U_ETRINAVELI_DedList') IS NOT NULL DROP TABLE [dbo].[U_ETRINAVELI_DedList];
GO
IF OBJECT_ID('U_ETRINAVELI_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ETRINAVELI_AuditFields];
GO
IF OBJECT_ID('U_ETRINAVELI_Audit') IS NOT NULL DROP TABLE [dbo].[U_ETRINAVELI_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_ETRINAVELI') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ETRINAVELI];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ETRINAVELI';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ETRINAVELI';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ETRINAVELI';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ETRINAVELI';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ETRINAVELI';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ETRINAVELI','Navigate Eligibility Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','ETRINAVELIZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ETRINAVELI' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"first_name"','1','(''DA''=''TT'')','ETRINAVELIZ0','50','H','01','1',NULL,'first_name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"last_name"','2','(''DA''=''TT'')','ETRINAVELIZ0','50','H','01','2',NULL,'last_name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"address_1"','3','(''DA''=''TT'')','ETRINAVELIZ0','50','H','01','3',NULL,'address_1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"address_2"','4','(''DA''=''TT'')','ETRINAVELIZ0','50','H','01','4',NULL,'address_2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"city"','5','(''DA''=''TT'')','ETRINAVELIZ0','50','H','01','5',NULL,'city',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"state"','6','(''DA''=''TT'')','ETRINAVELIZ0','50','H','01','6',NULL,'state',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"country"','7','(''DA''=''TT'')','ETRINAVELIZ0','50','H','01','7',NULL,'country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"postal_code"','8','(''DA''=''TT'')','ETRINAVELIZ0','50','H','01','8',NULL,'postal_code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"email"','9','(''DA''=''TT'')','ETRINAVELIZ0','50','H','01','9',NULL,'email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"employee_id"','10','(''DA''=''TT'')','ETRINAVELIZ0','50','H','01','10',NULL,'employee_id',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"client_id"','11','(''DA''=''TT'')','ETRINAVELIZ0','50','H','01','11',NULL,'client_id',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"division"','12','(''DA''=''TT'')','ETRINAVELIZ0','50','H','01','12',NULL,'division',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"location"','13','(''DA''=''TT'')','ETRINAVELIZ0','50','H','01','13',NULL,'location',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"position"','14','(''DA''=''TT'')','ETRINAVELIZ0','50','H','01','14',NULL,'position',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"related_employee_id"','15','(''DA''=''TT'')','ETRINAVELIZ0','50','H','01','15',NULL,'related_employee_id',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"related_relationship"','16','(''DA''=''TT'')','ETRINAVELIZ0','50','H','01','16',NULL,'related_relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"effective_date"','17','(''DA''=''TT'')','ETRINAVELIZ0','50','H','01','17',NULL,'effective_date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"termination_date"','18','(''DA''=''TT'')','ETRINAVELIZ0','50','H','01','18',NULL,'termination_date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"birthday"','19','(''DA''=''TT'')','ETRINAVELIZ0','50','H','01','19',NULL,'birthday',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"gender"','20','(''DA''=''TT'')','ETRINAVELIZ0','50','H','01','20',NULL,'gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"custom_data_1"','21','(''DA''=''TT'')','ETRINAVELIZ0','50','H','01','21',NULL,'custom_data_1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"custom_data_2"','22','(''DA''=''TT'')','ETRINAVELIZ0','50','H','01','22',NULL,'custom_data_2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"custom_data_3"','23','(''DA''=''TT'')','ETRINAVELIZ0','50','H','01','23',NULL,'custom_data_3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"custom_data_4"','24','(''DA''=''TT'')','ETRINAVELIZ0','50','H','01','24',NULL,'custom_data_4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"custom_data_5"','25','(''DA''=''TT'')','ETRINAVELIZ0','50','H','01','25',NULL,'custom_data_5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvfirstname"','1','(''UA''=''TT'')','ETRINAVELIZ0','50','D','10','1',NULL,'drvfirstname',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvlastname"','2','(''UA''=''TT'')','ETRINAVELIZ0','50','D','10','2',NULL,'drvlastname',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvaddress1"','3','(''UA''=''TT'')','ETRINAVELIZ0','50','D','10','2',NULL,'drvaddress1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvaddress2"','4','(''UA''=''TT'')','ETRINAVELIZ0','50','D','10','2',NULL,'drvaddress2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvcity"','5','(''UA''=''TT'')','ETRINAVELIZ0','50','D','10','3',NULL,'drvcity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvstate"','6','(''UA''=''TT'')','ETRINAVELIZ0','50','D','10','4',NULL,'drvemployeeid',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvcountry"','7','(''UA''=''TT'')','ETRINAVELIZ0','50','D','10','5',NULL,'drvdivision',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvpostalcode"','8','(''UA''=''TT'')','ETRINAVELIZ0','50','D','10','6',NULL,'drvpostalcode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvemail"','9','(''UA''=''TT'')','ETRINAVELIZ0','50','D','10','7',NULL,'drvemail',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvemployeeid"','10','(''UA''=''TT'')','ETRINAVELIZ0','50','D','10','8',NULL,'drvemployeeid',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvclientid"','11','(''UA''=''TT'')','ETRINAVELIZ0','50','D','10','9',NULL,'drvclientid',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvdivision"','12','(''UA''=''TT'')','ETRINAVELIZ0','50','D','10','10',NULL,'drvdivision',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvlocation"','13','(''UA''=''TT'')','ETRINAVELIZ0','50','D','10','11',NULL,'drvlocation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvposition"','14','(''UA''=''TT'')','ETRINAVELIZ0','50','D','10','12',NULL,'drvposition',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvrelatedemployeeid"','15','(''UA''=''TT'')','ETRINAVELIZ0','50','D','10','13',NULL,'drvrelatedemployeeid',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvrelatedrelationship"','16','(''UA''=''TT'')','ETRINAVELIZ0','50','D','10','14',NULL,'drvrelatedrelationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drveffectivedate"','17','(''UD101''=''TT'')','ETRINAVELIZ0','50','D','10','15',NULL,'drveffectivedate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvterminationdate"','18','(''UD101''=''TT'')','ETRINAVELIZ0','50','D','10','16',NULL,'drvterminationdate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvbirthday"','19','(''UD101''=''TT'')','ETRINAVELIZ0','50','D','10','17',NULL,'drvbirthday',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvgender"','20','(''UA''=''TT'')','ETRINAVELIZ0','50','D','10','18',NULL,'drvgender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvcustomdata1"','21','(''UA''=''TT'')','ETRINAVELIZ0','50','D','10','19',NULL,'drvcustomdata1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvcustomdata2"','22','(''UA''=''TT'')','ETRINAVELIZ0','50','D','10','20',NULL,'drvcustomdata2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvcustomdata3"','23','(''UA''=''TT'')','ETRINAVELIZ0','50','D','10','21',NULL,'drvcustomdata3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvcustomdata4"','24','(''UA''=''TT'')','ETRINAVELIZ0','50','D','10','22',NULL,'drvcustomdata4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvcustomdata5"','25','(''UA''=''TT'')','ETRINAVELIZ0','50','D','10','23',NULL,'drvcustomdata5',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'ETRINAVELI_20210728.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Ondemand','202106239','EMPEXPORT','ONDEM_XOE','Jul  2 2021 12:00AM','ETRINAVELI',NULL,NULL,NULL,'202106239','Jun 23 2021 12:00AM','Dec 30 1899 12:00AM','202106231',NULL,'','','202106231',dbo.fn_GetTimedKey(),NULL,'us3mLaTRI1027',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled','202106239','EMPEXPORT','SCH_EALIJO','Jul  2 2021 12:00AM','ETRINAVELI',NULL,NULL,NULL,'202106239','Jun 23 2021 12:00AM','Dec 30 1899 12:00AM','202106231',NULL,'','','202106231',dbo.fn_GetTimedKey(),NULL,'us3mLaTRI1027',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','9LH3F,9LHFK,9LHK3,9LHOW,9LHVN,9LHSL,9LI1X,9LHYX,9LETJ,9LEIL,9LI5M',NULL,NULL,NULL,'Navigate Test','202107271','EMPEXPORT','TEST_XOE','Jul 27 2021  8:19PM','ETRINAVELI',NULL,NULL,NULL,'202107271','Jul 27 2021 12:00AM','Dec 30 1899 12:00AM','202107131','1334','','','202107131',dbo.fn_GetTimedKey(),NULL,'CPETITTI11',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETRINAVELI','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETRINAVELI','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETRINAVELI','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETRINAVELI','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETRINAVELI','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETRINAVELI','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'ETRINAVELI' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'ETRINAVELI' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_ETRINAVELI_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ETRINAVELI_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ETRINAVELI','H01','NONE',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ETRINAVELI','D10','dbo.U_ETRINAVELI_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_ETRINAVELI') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ETRINAVELI] (
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
IF OBJECT_ID('U_ETRINAVELI_Audit') IS NULL
CREATE TABLE [dbo].[U_ETRINAVELI_Audit] (
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audKey1Value] varchar(255) NOT NULL,
    [audKey2Value] varchar(255) NOT NULL,
    [audKey3Value] varchar(255) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] varchar(2000) NULL,
    [audNewValue] varchar(2000) NULL,
    [audRowNo] bigint NULL
);
IF OBJECT_ID('U_ETRINAVELI_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ETRINAVELI_AuditFields] (
    [aTableName] varchar(128) NULL,
    [aFieldName] varchar(128) NULL
);
IF OBJECT_ID('U_ETRINAVELI_DedList') IS NULL
CREATE TABLE [dbo].[U_ETRINAVELI_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ETRINAVELI_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ETRINAVELI_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvfirstname] varchar(100) NULL,
    [drvlastname] varchar(100) NULL,
    [drvaddress1] varchar(1) NOT NULL,
    [drvaddress2] varchar(1) NOT NULL,
    [drvcity] varchar(1) NOT NULL,
    [drvstate] varchar(1) NOT NULL,
    [drvcountry] varchar(1) NOT NULL,
    [drvpostalcode] varchar(1) NOT NULL,
    [drvemail] varchar(50) NULL,
    [drvemployeeid] char(9) NULL,
    [drvclientid] varchar(1) NOT NULL,
    [drvdivision] varchar(25) NULL,
    [drvlocation] varchar(25) NULL,
    [drvposition] varchar(25) NOT NULL,
    [drvrelatedemployeeid] varchar(1) NOT NULL,
    [drvrelatedrelationship] varchar(1) NOT NULL,
    [drveffectivedate] datetime NULL,
    [drvterminationdate] datetime NULL,
    [drvbirthday] datetime NULL,
    [drvgender] varchar(6) NOT NULL,
    [drvcustomdata1] char(6) NULL,
    [drvcustomdata2] varchar(10) NULL,
    [drvcustomdata3] varchar(10) NULL,
    [drvcustomdata4] varchar(25) NULL,
    [drvcustomdata5] varchar(45) NULL
);
IF OBJECT_ID('U_ETRINAVELI_EEList') IS NULL
CREATE TABLE [dbo].[U_ETRINAVELI_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ETRINAVELI_File') IS NULL
CREATE TABLE [dbo].[U_ETRINAVELI_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
IF OBJECT_ID('U_ETRINAVELI_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ETRINAVELI_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [Pdh401K] numeric NULL,
    [Pdh401ER] numeric NULL,
    [PdhRoth] numeric NULL,
    [PdhLoan] numeric NULL
);
IF OBJECT_ID('U_ETRINAVELI_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ETRINAVELI_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ETRINAVELI]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: TRI Pointe Group

Created By: Marco Lagrosa
Business Analyst: Cheryl Petitti
Create Date: 06/30/2021
Service Request Number: TekP-2021-04-29-0007

Purpose: Navigate Eligibility Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ETRINAVELI';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ETRINAVELI';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ETRINAVELI';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ETRINAVELI';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ETRINAVELI' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETRINAVELI', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETRINAVELI', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETRINAVELI', 'SCH_EALIJO';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ETRINAVELI';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ETRINAVELI', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ETRINAVELI';

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
    DELETE FROM dbo.U_ETRINAVELI_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ETRINAVELI_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    DELETE FROM dbo.U_ETRINAVELI_EEList
    WHERE xEEID IN (SELECT eeceeid FROM dbo.EmpComp With (NOLOCK) where eeceetype = 'CON' );
    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '401F,401P,401ER,ROTFA,ROTHP,401L, 401L2,401L3';

    IF OBJECT_ID('U_ETRINAVELI_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ETRINAVELI_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ETRINAVELI_DedList
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
    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_ETRINAVELI_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ETRINAVELI_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,Pdh401K     = SUM(CASE WHEN PdhDedCode IN ('401F','401P') THEN PdhEECurAmt ELSE 0.00 END)
        ,Pdh401ER     = SUM(CASE WHEN PdhDedCode IN ('401ER') THEN PdhERCurAmt ELSE 0.00 END)
        ,PdhRoth    = SUM(CASE WHEN PdhDedCode IN ('ROTFA', 'ROTHP') THEN PdhEECurAmt ELSE 0.00 END)        
        ,PdhLoan     = SUM(CASE WHEN PdhDedCode IN ('401L', '401L2', '401L3') THEN PdhEECurAmt ELSE 0.00 END)

    INTO dbo.U_ETRINAVELI_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ETRINAVELI_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_ETRINAVELI_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ETRINAVELI_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)

    INTO dbo.U_ETRINAVELI_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;



    
    --Audit Table
    IF OBJECT_ID('U_ETRINAVELI_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ETRINAVELI_AuditFields;
    CREATE TABLE dbo.U_ETRINAVELI_AuditFields (aTableName varchar(128),aFieldName varchar(128));
    
    -- Insert tables/fields to be audited
    INSERT INTO dbo.U_ETRINAVELI_AuditFields VALUES ('EmpComp','EecEmplStatus');    
    
    -- Create audit table
    IF OBJECT_ID('U_ETRINAVELI_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ETRINAVELI_Audit;
    SELECT
         audTableName = adrTableName
        ,audFieldName = adfFieldName
        ,audKey1Value = ISNULL(adrKey1,'')
        ,audKey2Value = ISNULL(adrKey2,'')
        ,audKey3Value = ISNULL(adrKey3,'')
        ,audDateTime  = adrProcessedDateTime
        ,audOldValue  = adfOldData
        ,audNewValue  = adfNewData
        ,audRowNo     = ROW_NUMBER() OVER(PARTITION BY adrKey1, adrKey2, adrKey3, adfFieldName ORDER BY adrRecID DESC)
    INTO dbo.U_ETRINAVELI_Audit
    FROM (SELECT *
          FROM dbo.AuditRecords WITH (NOLOCK)
          WHERE adrTableName IN (SELECT aTableName FROM dbo.U_ETRINAVELI_AuditFields WITH (NOLOCK))) ADR
    JOIN (SELECT *
          FROM dbo.AuditFields WITH (NOLOCK)
          WHERE adfFieldName IN (SELECT aFieldName FROM dbo.U_ETRINAVELI_AuditFields WITH (NOLOCK))) ADF
        ON adrSystemID = adfSystemID
       AND adrKey = adfKey
    WHERE adrType IN (1,2,5,6) -- Insert/Update; remove this to include Deletes and Viewed
      AND adrProcessedDateTime BETWEEN @StartDAte AND @EndDate;
    
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ETRINAVELI_Audit ON dbo.U_ETRINAVELI_Audit (audKey1Value, audKey2Value);

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ETRINAVELI_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ETRINAVELI_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ETRINAVELI_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepSSN
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvfirstname = CASE WHEN ISNULL(EepNamePreferred,'') <> '' THEN EepNamePreferred ELSE  EepNameFirst END
        ,drvlastname =  EepNameLast
        ,drvaddress1 = ''
        ,drvaddress2 = ''
        ,drvcity = ''
        ,drvstate = ''
        ,drvcountry = ''
        ,drvpostalcode = ''
        ,drvemail = eepAddressEmail
        ,drvemployeeid = eecEmpNo
        ,drvclientid = ''
        ,drvdivision = (Select top 1 LocDesc from dbo.Location where LocCode = EecLocation) --EecOrglvl1
        ,drvlocation =  CASE WHEN EecOrgLvl1 in ('TRIASS','TRIAV') THEN 'Tri Pointe Solutions'
                             WHEN EecOrgLvl1 in ('TPG') THEN 'Home Office'
                        ELSE (Select  top 1 OrgDesc from dbo.OrgLevel WITH (NOLOCK) where OrgLvl = 1 and OrgCode  = EecOrgLvl1)  END
        ,drvposition = JbcDesc
        ,drvrelatedemployeeid = ''
        ,drvrelatedrelationship = ''
        ,drveffectivedate =        CASE WHEN NOT EXISTS(Select EjhReason from dbo.EmphJob where EjhReason <> 'TRI'  and ejheeid = xeeid) and EecDateOfLastHire <> EecDateOfOriginalHire THEN  EecDateOfLastHire ELSE EecDateOfOriginalHire END
                          
        ,drvterminationdate = CASE
                               WHEN eecEmplStatus= 'T'
                                   THEN CASE WHEN  EXISTS(Select EjhReason from dbo.EmphJob where EjhReason <> 'TRO'  and ejheeid = xeeid) THEN  eecdateoftermination  END
                            END
        ,drvbirthday =  eepDateofBirth
        ,drvgender = CASE WHEN eepGender = 'M' Then 'Male'
                          WHEN eepGender = 'F' Then 'Female'
                          ELSE 'Other'
                     END
        ,drvcustomdata1 = EecLocation --(Select  top 1 OrgDesc from dbo.OrgLevel WITH (NOLOCK) where OrgLvl = 1 and OrgCode  = EecOrgLvl1)
        ,drvcustomdata2 = EecOrgLvl1 --(Select top  1 LocDesc from dbo.Location WITH (NOLOCK) where LocCode =  eeclocation)
        ,drvcustomdata3 = EecOrgLvl2
        ,drvcustomdata4 = (Select  top 1 OrgDesc from dbo.OrgLevel WITH (NOLOCK) where OrgLvl = 2 and OrgCode  = EecOrgLvl2)
        ,drvcustomdata5 = CodDesc
    INTO dbo.U_ETRINAVELI_drvTbl
    FROM dbo.U_ETRINAVELI_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
         and (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                                        and EXISTS(select 1 from dbo.U_ETRINAVELI_Audit where  audKey1Value = xEEID AND audKey2Value = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        On JbcJobCode = eecJobCode
    JOIN (Select  CodDesc,CodCode from Codes  where CodTable = 'EMPTYPE') as EmpType
        on EmpType.CodCode =  eeceetype;
        

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
ALTER VIEW dbo.dsi_vwETRINAVELI_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ETRINAVELI_File (NOLOCK)
    ORDER BY RIGHT(RecordSeTT2), InitialSorTT SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ETRINAVELI%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202106161'
       ,expStartPerControl     = '202106161'
       ,expLastEndPerControl   = '202106239'
       ,expEndPerControl       = '202106239'
WHERE expFormatCode = 'ETRINAVELI';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwETRINAVELI_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ETRINAVELI_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort