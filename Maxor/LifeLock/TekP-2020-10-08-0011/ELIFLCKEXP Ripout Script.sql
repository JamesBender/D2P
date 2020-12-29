SET NOCOUNT ON;
IF OBJECT_ID('U_ELIFLCKEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ELIFLCKEXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ELIFLCKEXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ELIFLCKEXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwELIFLCKEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwELIFLCKEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ELIFLCKEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ELIFLCKEXP];
GO
IF OBJECT_ID('U_ELIFLCKEXP_File') IS NOT NULL DROP TABLE [dbo].[U_ELIFLCKEXP_File];
GO
IF OBJECT_ID('U_ELIFLCKEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_ELIFLCKEXP_EEList];
GO
IF OBJECT_ID('U_ELIFLCKEXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ELIFLCKEXP_drvTbl];
GO
IF OBJECT_ID('U_ELIFLCKEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_ELIFLCKEXP_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_ELIFLCKEXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ELIFLCKEXP];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ELIFLCKEXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ELIFLCKEXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ELIFLCKEXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ELIFLCKEXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ELIFLCKEXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ELIFLCKEXP','LifeLock Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','ELIFLCKEXPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ELIFLCKEXP' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FirstName"','1','(''DA''=''T,'')','ELIFLCKEXPZ0','50','H','01','1',NULL,'FirstName ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MiddleInitial"','2','(''DA''=''T,'')','ELIFLCKEXPZ0','50','H','01','2',NULL,'MiddleInitial ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LastName"','3','(''DA''=''T,'')','ELIFLCKEXPZ0','50','H','01','3',NULL,'LastName ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PostName"','4','(''DA''=''T,'')','ELIFLCKEXPZ0','50','H','01','4',NULL,'PostName ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SubscriberID"','5','(''DA''=''T,'')','ELIFLCKEXPZ0','50','H','01','5',NULL,'SubscriberID ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Relation"','6','(''DA''=''T,'')','ELIFLCKEXPZ0','50','H','01','6',NULL,'Relation ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MemberSSN"','7','(''DA''=''T,'')','ELIFLCKEXPZ0','50','H','01','7',NULL,'MemberSSN ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address1"','8','(''DA''=''T,'')','ELIFLCKEXPZ0','50','H','01','8',NULL,'Address1 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address2"','9','(''DA''=''T,'')','ELIFLCKEXPZ0','50','H','01','9',NULL,'Address2 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"City"','10','(''DA''=''T,'')','ELIFLCKEXPZ0','50','H','01','10',NULL,'City ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"State"','11','(''DA''=''T,'')','ELIFLCKEXPZ0','50','H','01','11',NULL,'State ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Zip"','12','(''DA''=''T,'')','ELIFLCKEXPZ0','50','H','01','12',NULL,'Zip ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Plus4"','13','(''DA''=''T,'')','ELIFLCKEXPZ0','50','H','01','13',NULL,'Plus4 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HomePhone"','14','(''DA''=''T,'')','ELIFLCKEXPZ0','50','H','01','14',NULL,'HomePhone ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WorkPhone"','15','(''DA''=''T,'')','ELIFLCKEXPZ0','50','H','01','15',NULL,'WorkPhone ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Coverage"','16','(''DA''=''T,'')','ELIFLCKEXPZ0','50','H','01','16',NULL,'Coverage ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"GroupCode"','17','(''DA''=''T,'')','ELIFLCKEXPZ0','50','H','01','17',NULL,'GroupCode ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Location"','18','(''DA''=''T,'')','ELIFLCKEXPZ0','50','H','01','18',NULL,'Location ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TerminationDate"','19','(''DA''=''T,'')','ELIFLCKEXPZ0','50','H','01','19',NULL,'TerminationDate ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EffectiveDate"','20','(''DA''=''T,'')','ELIFLCKEXPZ0','50','H','01','20',NULL,'EffectiveDate ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DateOfBirth"','21','(''DA''=''T,'')','ELIFLCKEXPZ0','50','H','01','21',NULL,'DateOfBirth ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Plan"','22','(''DA''=''T,'')','ELIFLCKEXPZ0','50','H','01','22',NULL,'Plan ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PayFrequency"','23','(''DA''=''T,'')','ELIFLCKEXPZ0','50','H','01','23',NULL,'PayFrequency ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Cost"','24','(''DA''=''T,'')','ELIFLCKEXPZ0','50','H','01','24',NULL,'Cost ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Gender"','25','(''DA''=''T,'')','ELIFLCKEXPZ0','50','H','01','25',NULL,'Gender ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Email"','26','(''DA''=''T'')','ELIFLCKEXPZ0','50','H','01','26',NULL,'Email ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','1','(''UA''=''T,'')','ELIFLCKEXPZ0','50','D','10','1',NULL,'FirstName ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','2','(''UA''=''T,'')','ELIFLCKEXPZ0','50','D','10','2',NULL,'MiddleInitial ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','3','(''UA''=''T,'')','ELIFLCKEXPZ0','50','D','10','3',NULL,'LastName ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','4','(''DA''=''T,'')','ELIFLCKEXPZ0','50','D','10','4',NULL,'PostName ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubscriberID"','5','(''UA''=''T,'')','ELIFLCKEXPZ0','50','D','10','5',NULL,'SubscriberID ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelation"','6','(''UA''=''T,'')','ELIFLCKEXPZ0','50','D','10','6',NULL,'Relation ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','7','(''UA''=''T,'')','ELIFLCKEXPZ0','50','D','10','7',NULL,'MemberSSN ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','8','(''UA''=''T,'')','ELIFLCKEXPZ0','50','D','10','8',NULL,'Address1 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','9','(''UA''=''T,'')','ELIFLCKEXPZ0','50','D','10','9',NULL,'Address2 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','10','(''UA''=''T,'')','ELIFLCKEXPZ0','50','D','10','10',NULL,'City ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','11','(''UA''=''T,'')','ELIFLCKEXPZ0','50','D','10','11',NULL,'State ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','12','(''UA''=''T,'')','ELIFLCKEXPZ0','50','D','10','12',NULL,'Zip ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','13','(''DA''=''T,'')','ELIFLCKEXPZ0','50','D','10','13',NULL,'Plus4 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomePHone"','14','(''UA''=''T,'')','ELIFLCKEXPZ0','50','D','10','14',NULL,'HomePhone ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','15','(''DA''=''T,'')','ELIFLCKEXPZ0','50','D','10','15',NULL,'WorkPhone ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverage"','16','(''UA''=''T,'')','ELIFLCKEXPZ0','50','D','10','16',NULL,'Coverage ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"E0009347"','17','(''DA''=''T,'')','ELIFLCKEXPZ0','50','D','10','17',NULL,'GroupCode ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''DA''=''T,'')','ELIFLCKEXPZ0','50','D','10','18',NULL,'Location ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationDate"','19','(''UDMDY''=''T,'')','ELIFLCKEXPZ0','50','D','10','19',NULL,'TerminationDate ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffectiveDate"','20','(''UDMDY''=''T,'')','ELIFLCKEXPZ0','50','D','10','20',NULL,'EffectiveDate ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','21','(''UDMDY''=''T,'')','ELIFLCKEXPZ0','50','D','10','21',NULL,'DateOfBirth ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlan"','22','(''UA''=''T,'')','ELIFLCKEXPZ0','50','D','10','22',NULL,'Plan ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','23','(''DA''=''T,'')','ELIFLCKEXPZ0','50','D','10','23',NULL,'PayFrequency ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','24','(''DA''=''T,'')','ELIFLCKEXPZ0','50','D','10','24',NULL,'Cost ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','25','(''UA''=''T,'')','ELIFLCKEXPZ0','50','D','10','25',NULL,'Gender ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmail"','26','(''UA''=''T'')','ELIFLCKEXPZ0','50','D','10','26',NULL,'Email ',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'ELIFLCKEXP_20201206.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','',NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202101109','EMPEXPORT','OEACTIVE',NULL,'ELIFLCKEXP',NULL,NULL,NULL,'202101109','Dec  6 2020  3:24PM','Dec  6 2020  3:24PM','202011291',NULL,'','','202011291',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','',NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202101109','EMPEXPORT','OEPASSIVE',NULL,'ELIFLCKEXP',NULL,NULL,NULL,'202101109','Dec  6 2020  3:24PM','Dec  6 2020  3:24PM','202011291',NULL,'','','202011291',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'LifeLIfe Export','202101109','EMPEXPORT','ONDEM_XOE',NULL,'ELIFLCKEXP',NULL,NULL,NULL,'202101109','Dec  6 2020  3:24PM','Dec  6 2020  3:24PM','202011291',NULL,'','','202011291',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'LifeLIfe Export-Sched','202101109','EMPEXPORT','SCH_ELIFLC',NULL,'ELIFLCKEXP',NULL,NULL,NULL,'202101109','Dec  6 2020  3:24PM','Dec  6 2020  3:24PM','202011291',NULL,'','','202011291',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','',NULL,NULL,NULL,NULL,'LifeLIfe Export-Test','202101109','EMPEXPORT','TEST_XOE',NULL,'ELIFLCKEXP',NULL,NULL,NULL,'202101109','Dec  6 2020  3:24PM','Dec  6 2020  3:24PM','202011291',NULL,'','','202011291',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELIFLCKEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELIFLCKEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELIFLCKEXP','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELIFLCKEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELIFLCKEXP','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'ELIFLCKEXP' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'ELIFLCKEXP' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_ELIFLCKEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ELIFLCKEXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ELIFLCKEXP','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ELIFLCKEXP','D10','dbo.U_ELIFLCKEXP_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_ELIFLCKEXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ELIFLCKEXP] (
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
IF OBJECT_ID('U_ELIFLCKEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_ELIFLCKEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ELIFLCKEXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ELIFLCKEXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(14) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(8000) NULL,
    [drvSubscriberID] varchar(6) NULL,
    [drvRelation] varchar(1) NULL,
    [drvSSN] varchar(13) NULL,
    [drvAddressLine1] varchar(8000) NULL,
    [drvAddressLine2] varchar(8000) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(5) NULL,
    [drvHomePHone] varchar(50) NULL,
    [drvCoverage] varchar(2) NULL,
    [drvTerminationDate] datetime NULL,
    [drvEffectiveDate] datetime NULL,
    [drvDateOfBirth] datetime NULL,
    [drvPlan] varchar(4) NULL,
    [drvGender] char(1) NULL,
    [drvEmail] varchar(50) NULL
);
IF OBJECT_ID('U_ELIFLCKEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_ELIFLCKEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ELIFLCKEXP_File') IS NULL
CREATE TABLE [dbo].[U_ELIFLCKEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ELIFLCKEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Maxor

Created By: James Bender
Business Analyst: Lea King
Create Date: 12/06/2020
Service Request Number: TekP-2020-10-08-0011

Purpose: LifeLIfe Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ELIFLCKEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ELIFLCKEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ELIFLCKEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ELIFLCKEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ELIFLCKEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELIFLCKEXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELIFLCKEXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELIFLCKEXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELIFLCKEXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELIFLCKEXP', 'SCH_ELIFLC';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ELIFLCKEXP';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ELIFLCKEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ELIFLCKEXP';

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
    DELETE FROM dbo.U_ELIFLCKEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ELIFLCKEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_ELIFLCKEXP_EEList WHERE xEEID IN (
        SELECT DISTINCT EecEEID from dbo.EmpComp WITH (NOLOCK) WHERE EecEEType = 'TES'
    )

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'IDTHF';

    IF OBJECT_ID('U_ELIFLCKEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ELIFLCKEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ELIFLCKEXP_DedList
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
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ELIFLCKEXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ELIFLCKEXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ELIFLCKEXP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = xEEID + CASE WHEN BdmRecType = 'EMP' THEN ' 1' ELSE ' 2' END
        -- standard fields above and additional driver fields below
        ,drvNameFirst = CASE WHEN BdmRecType = 'EMP' THEN EepNameFirst ELSE ConNameFirst END
        ,drvNameMiddle = CASE WHEN BdmRecType = 'EMP' THEN LEFT(EepNameMiddle,1) ELSE LEFT(ConNameMiddle,1) END
        ,drvNameLast = REPLACE(CASE WHEN BdmRecType = 'EMP' THEN EepNameLast ELSE ConNameLast END, ',', '')
        ,drvSubscriberID =  '00' + CHAR(65 + (CAST(LEFT(RIGHT(RTRIM(EecEmpNo), 4),1) AS INT))) +
            CHAR(65 + (CAST(LEFT(RIGHT(RTRIM(EecEmpNo), 3),1) AS INT))) +
            CHAR(65 + (CAST(LEFT(RIGHT(RTRIM(EecEmpNo), 2),1) AS INT))) +
            CHAR(65 + (CAST(RIGHT(RTRIM(EecEmpNo), 1) AS INT)))
        ,drvRelation =    CASE WHEN BdmRecType = 'EMP' THEN 'E'
                            WHEN ConRelationship IN ('SPS','DP') THEN 'S'
                            WHEN ConRelationship IN ('CHL','DPC','STC') THEN 'C'
                        END
        ,drvSSN = '"' + RTRIM(CASE WHEN BdmRecType = 'EMP' THEN eepSSN ELSE ConSSN END) + '"'
        ,drvAddressLine1 = REPLACE(EepAddressLine1, ',', '')
        ,drvAddressLine2 = REPLACE(EepAddressLine2, ',', '')
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = LEFT(EepAddressZipCode, 5)
        ,drvHomePHone = EepPhoneHomeNumber
        ,drvCoverage =    CASE WHEN BdmBenOption IN ('IDTBEE', 'IDTBPE') THEN 'EO'
                            WHEN BdmBenOption IN ('IDTBEF','IDTBPF') THEN 'ED'
                        END
        ,drvTerminationDate = CASE WHEN BdmBenStatus = 'T' THEN BdmBenStopDate END
        ,drvEffectiveDate = BdmBenStartDate
        ,drvDateOfBirth = CASE WHEN BdmRecType = 'Emp' THEN EepDateOfBirth ELSE ConDateOfBirth END
        ,drvPlan =    CASE WHEN BdmBenOption IN ('IDTBEE', 'IDTBPE') THEN 'ESSN'
                        WHEN BdmBenOption IN ('IDTBEF','IDTBPF') THEN 'PREM'
                    END
        ,drvGender = CASE WHEN BdmRecType = 'Emp' THEN EepGender ELSE ConGender END
        ,drvEmail = CASE WHEN ISNULL(EepAddressEmailAlternate, '')  <> '' THEN EepAddressEmailAlternate ELSE EepAddressEMail END
    INTO dbo.U_ELIFLCKEXP_drvTbl
    FROM dbo.U_ELIFLCKEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ELIFLCKEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
    WHERE EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND EecDateOfTermination BETWEEN DATEADD(DAY,-30,@EndDate) AND @EndDate)
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
ALTER VIEW dbo.dsi_vwELIFLCKEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ELIFLCKEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ELIFLCKEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202011291'
       ,expStartPerControl     = '202011291'
       ,expLastEndPerControl   = '202101109'
       ,expEndPerControl       = '202101109'
WHERE expFormatCode = 'ELIFLCKEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwELIFLCKEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ELIFLCKEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort