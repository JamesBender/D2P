SET NOCOUNT ON;
IF OBJECT_ID('U_ETELADOC2X_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ETELADOC2X_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ETELADOC2X_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ETELADOC2X' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwETELADOC2X_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwETELADOC2X_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ETELADOC2X') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ETELADOC2X];
GO
IF OBJECT_ID('U_ETELADOC2X_File') IS NOT NULL DROP TABLE [dbo].[U_ETELADOC2X_File];
GO
IF OBJECT_ID('U_ETELADOC2X_EEList') IS NOT NULL DROP TABLE [dbo].[U_ETELADOC2X_EEList];
GO
IF OBJECT_ID('U_ETELADOC2X_D11_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ETELADOC2X_D11_drvTbl];
GO
IF OBJECT_ID('U_ETELADOC2X_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ETELADOC2X_AuditFields];
GO
IF OBJECT_ID('U_ETELADOC2X_Audit') IS NOT NULL DROP TABLE [dbo].[U_ETELADOC2X_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_ETELADOC2X') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ETELADOC2X];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ETELADOC2X';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ETELADOC2X';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ETELADOC2X';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ETELADOC2X';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ETELADOC2X';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ETELADOC2X','Teladoc Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','6000','S','N','ETELADOC2XZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ETELADOC2X' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"8028"','1','(''DA''=''T,'')','ETELADOC2XZ0','15','D','11','1',NULL,'Group ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"D11_MID_EecEmpNo"','2','(''UA''=''T,'')','ETELADOC2XZ0','40','D','11','2',NULL,'Member ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"D11_PID_EecEmpNo"','3','(''UA''=''T,'')','ETELADOC2XZ0','40','D','11','3',NULL,'Primary ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"D11_RelationshipToPrimary"','4','(''UA''=''T,'')','ETELADOC2XZ0','1','D','11','4',NULL,'Relationship To Primary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"D11_NamePrefix"','5','(''UA''=''Q,'')','ETELADOC2XZ0','10','D','11','5',NULL,'Name Prefix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"D11_EepNameFirst"','6','(''UA''=''Q,'')','ETELADOC2XZ0','25','D','11','6',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"D11_MiddleName"','7','(''UA''=''Q,'')','ETELADOC2XZ0','25','D','11','7',NULL,'Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"D11_LastName"','8','(''UA''=''Q,'')','ETELADOC2XZ0','35','D','11','8',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"D11_NameSuffix"','9','(''UA''=''Q,'')','ETELADOC2XZ0','10','D','11','9',NULL,'Name Suffix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"D11_Gender"','10','(''UA''=''T,'')','ETELADOC2XZ0','1','D','11','10',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"D11_EecLanguageCode"','11','(''UA''=''T,'')','ETELADOC2XZ0','1','D','11','11',NULL,'Language',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"D11_BirthDate"','12','(''UD120''=''T,'')','ETELADOC2XZ0','10','D','11','12',NULL,'Birth Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"D11_AddressLine1"','13','(''UA''=''Q,'')','ETELADOC2XZ0','45','D','11','13',NULL,'Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"D11_AddressLine2"','14','(''UA''=''Q,'')','ETELADOC2XZ0','45','D','11','14',NULL,'Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"D11_City"','15','(''UA''=''Q,'')','ETELADOC2XZ0','45','D','11','15',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"D11_StateAbbreviation"','16','(''UA''=''Q,'')','ETELADOC2XZ0','2','D','11','16',NULL,'State Abbreviation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"D11_Zip"','17','(''UA''=''T,'')','ETELADOC2XZ0','10','D','11','17',NULL,'Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"D11_EecPhoneHomeNumber"','18','(''UA''=''T,'')','ETELADOC2XZ0','12','D','11','18',NULL,'Home Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','19','(''SS''=''T,'')','ETELADOC2XZ0','12','D','11','19',NULL,'Cell Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"D11_EecPhoneBusinessNumber"','20','(''UA''=''T,'')','ETELADOC2XZ0','20','D','11','20',NULL,'Work Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"D11_EepAddressEMail"','21','(''UA''=''T,'')','ETELADOC2XZ0','45','D','11','21',NULL,'Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"D11_EedBenStartDate"','22','(''UD120''=''T,'')','ETELADOC2XZ0','10','D','11','22',NULL,'Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"D11_DbnBenStopDate"','23','(''UD120''=''T,'')','ETELADOC2XZ0','10','D','11','23',NULL,'Term Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','24','(''SS''=''T,'')','ETELADOC2XZ0','12','D','11','19',NULL,'Cell Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','25','(''SS''=''T,'')','ETELADOC2XZ0','12','D','11','19',NULL,'Cell Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','26','(''SS''=''T,'')','ETELADOC2XZ0','12','D','11','19',NULL,'Cell Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','27','(''SS''=''T,'')','ETELADOC2XZ0','12','D','11','19',NULL,'Cell Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','28','(''SS''=''T,'')','ETELADOC2XZ0','12','D','11','19',NULL,'Cell Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','29','(''SS''=''T,'')','ETELADOC2XZ0','12','D','11','19',NULL,'Cell Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','30','(''SS''=''T,'')','ETELADOC2XZ0','12','D','11','19',NULL,'Cell Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','31','(''SS''=''T,'')','ETELADOC2XZ0','12','D','11','19',NULL,'Cell Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','32','(''SS''=''T,'')','ETELADOC2XZ0','12','D','11','19',NULL,'Cell Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','33','(''SS''=''T,'')','ETELADOC2XZ0','12','D','11','19',NULL,'Cell Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','34','(''SS''=''T,'')','ETELADOC2XZ0','12','D','11','19',NULL,'Cell Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','35','(''SS''=''T,'')','ETELADOC2XZ0','12','D','11','19',NULL,'Cell Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','36','(''SS''=''T,'')','ETELADOC2XZ0','12','D','11','19',NULL,'Cell Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','37','(''SS''=''T,'')','ETELADOC2XZ0','12','D','11','19',NULL,'Cell Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','38','(''SS''=''T,'')','ETELADOC2XZ0','12','D','11','19',NULL,'Cell Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','39','(''SS''=''T,'')','ETELADOC2XZ0','12','D','11','19',NULL,'Cell Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','40','(''SS''=''T,'')','ETELADOC2XZ0','12','D','11','19',NULL,'Cell Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','41','(''SS''=''T,'')','ETELADOC2XZ0','12','D','11','19',NULL,'Cell Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','42','(''SS''=''T,'')','ETELADOC2XZ0','12','D','11','19',NULL,'Cell Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','43','(''SS''=''T,'')','ETELADOC2XZ0','12','D','11','19',NULL,'Cell Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','44','(''SS''=''T,'')','ETELADOC2XZ0','12','D','11','19',NULL,'Cell Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','45','(''SS''=''T'')','ETELADOC2XZ0','40','D','11','24',NULL,'Health Plan ID',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'ETELADOC2X_20210729.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,'9ZQMP,9ZRSX,28A5I,N7KJN,9ZRWQ,0YT6J,9ZS04,9ZS3H,0YT50,9ZS6V,9ZSA1',NULL,NULL,NULL,'Teladoc Export','201701019','EMPEXPORT','OEACTIVE','Jul 13 2021 12:00AM','ETELADOC2X',NULL,NULL,NULL,'201701019','Jan  1 2017 12:00AM','Dec 30 1899 12:00AM','201701011','0','','','201701011',dbo.fn_GetTimedKey(),NULL,'LDONNELL',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,'9ZQMP,9ZRSX,28A5I,N7KJN,9ZRWQ,0YT6J,9ZS04,9ZS3H,0YT50,9ZS6V,9ZSA1',NULL,NULL,NULL,'Teladoc Export','201701011','EMPEXPORT','OEPASSIVE','Jul 13 2021 12:00AM','ETELADOC2X',NULL,NULL,NULL,'201701011','Jan  1 2017 12:00AM','Dec 30 1899 12:00AM','201701011','4260','','','201701011',dbo.fn_GetTimedKey(),NULL,'LDONNELL',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,'9ZQMP,9ZRSX,28A5I,N7KJN,9ZRWQ,0YT6J,9ZS04,9ZS3H,0YT50,9ZS6V,9ZSA1',NULL,NULL,NULL,'Teladoc Export','201701011','EMPEXPORT','ONDEMAND','Jul 13 2021 12:00AM','ETELADOC2X',NULL,NULL,NULL,'201701011','Jan  1 2017 12:00AM','Dec 30 1899 12:00AM','201701011','4260','','','201701011',dbo.fn_GetTimedKey(),NULL,'LDONNELL',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,'9ZQMP,9ZRSX,28A5I,N7KJN,9ZRWQ,0YT6J,9ZS04,9ZS3H,0YT50,9ZS6V,9ZSA1',NULL,NULL,NULL,'Teladoc Export','201602199','EMPEXPORT','SCHEDULED','Jul 13 2021 12:00AM','ETELADOC2X',NULL,NULL,NULL,'201602199','Feb 19 2016 12:00AM','Dec 30 1899 12:00AM','201602191',NULL,'','','201602191',dbo.fn_GetTimedKey(),NULL,'LDONNELL',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETELADOC2X','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETELADOC2X','ExportPath','V','\\us.saas\E0\data_exchange\USI1001\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETELADOC2X','InitialSort','C','D11_MID_EecEmpNo');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETELADOC2X','IsUTF','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETELADOC2X','MultFile','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETELADOC2X','NoEmpty','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETELADOC2X','OEPath','V','\\us.saas\e4\Public\USI1001\Exports\Teladoc\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETELADOC2X','OnDemandPath','V','\\us.saas\E0\data_exchange\USI1001\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETELADOC2X','SubSort','C','D11_RelationshipToPrimary');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETELADOC2X','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETELADOC2X','Upper','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETELADOC2X','UseFileName','V','N');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'ETELADOC2X' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'ETELADOC2X' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_ETELADOC2X_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ETELADOC2X_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ETELADOC2X','D11','U_ETELADOC2X_D11_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_ETELADOC2X') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ETELADOC2X] (
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
IF OBJECT_ID('U_ETELADOC2X_Audit') IS NULL
CREATE TABLE [dbo].[U_ETELADOC2X_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audKey2] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] varchar(2000) NULL,
    [audNewValue] varchar(2000) NULL
);
IF OBJECT_ID('U_ETELADOC2X_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ETELADOC2X_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_ETELADOC2X_D11_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ETELADOC2X_D11_drvTbl] (
    [D11_MID_EecEmpNo] char(9) NULL,
    [D11_PID_EecEmpNo] char(9) NULL,
    [D11_RelationshipToPrimary] varchar(1) NOT NULL,
    [D11_NamePrefix] varchar(30) NULL,
    [D11_EepNameFirst] varchar(100) NULL,
    [D11_MiddleName] varchar(50) NULL,
    [D11_LastName] varchar(100) NULL,
    [D11_NameSuffix] varchar(30) NULL,
    [D11_Gender] char(1) NULL,
    [D11_EecLanguageCode] varchar(1) NOT NULL,
    [D11_BirthDate] datetime NULL,
    [D11_AddressLine1] varchar(255) NULL,
    [D11_AddressLine2] varchar(255) NULL,
    [D11_City] varchar(255) NULL,
    [D11_StateAbbreviation] varchar(255) NULL,
    [D11_Zip] varchar(50) NULL,
    [D11_EecPhoneHomeNumber] varchar(12) NULL,
    [D11_EecPhoneBusinessNumber] varchar(12) NULL,
    [D11_EepAddressEMail] varchar(50) NULL,
    [D11_EedBenStartDate] datetime NULL,
    [D11_DbnBenStopDate] datetime NULL,
    [drveeid] char(12) NULL,
    [drvcoid] char(5) NULL
);
IF OBJECT_ID('U_ETELADOC2X_EEList') IS NULL
CREATE TABLE [dbo].[U_ETELADOC2X_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ETELADOC2X_File') IS NULL
CREATE TABLE [dbo].[U_ETELADOC2X_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(max) NULL
);
GO
/************************************************************

Created By: Nicole Bishop
Business Analyst: Adriana Trujillo
Create Date: 11/10/2016
ChangePoint Request Number: SR-2016-00132667

Purpose: Actual Benefit Coverage Start Date as keyed into UltiPro on the EMP and DEP Record
Execute Export: dsi_sp_testswitchbox 'ETELADOC2X', 'OEPASSIVE'

Revision History
-----------------
Update By   Date   CP Num   Desc   
XXXX    XX/XX/16  12345   Added 1234

SELECT * FROM U_Dsi_Configuration WHERE FormatCode = 'ETELADOC2X'
SELECT * FROM U_Dsi_SqlClauses WHERE FormatCode = 'ETELADOC2X'
SELECT * FROM U_Dsi_Parameters WHERE FormatCode = 'ETELADOC2X'

dsi_sp_testswitchbox_v2 'ETELADOC2X', 'ONDEMAND'
dsi_sp_testswitchbox_v2 'ETELADOC2X', 'SCHEDULED'
dsi_sp_testswitchbox_v2 'ETELADOC2X', 'OEPASSIVE'
dsi_sp_testswitchbox_v2 'ETELADOC2X', 'OEACTIVE'

************************************************************/ 
CREATE                 procedure [dbo].[dsi_sp_BuildDriverTables_ETELADOC2X]
@systemid char(12)
as

Declare @Formatcode varchar(12),
 @Exportcode varchar(12),
 @StartDate datetime, 
 @EndDate datetime, 
 @StartPerControl varchar(9), 
 @EndPerControl varchar(9)

-- Declare dates from Parameter file
SELECT @StartDate = case when exportcode <> 'SCHEDULED' then cast(substring(StartPerControl,1,8) as datetime) else getdate()-7 end
 , @EndDate = case when exportcode <> 'SCHEDULED' then cast(substring(EndPerControl,1,8) as datetime) else getdate() end
 , @StartPerControl = case when exportcode <> 'SCHEDULED' then StartPerControl else convert(varchar,getdate()-7,112)+'1' end
 , @EndPerControl = case when exportcode <> 'SCHEDULED' then EndPerControl else  convert(varchar,getdate(),112)+'9' end
 , @Formatcode = Formatcode
 , @Exportcode = Exportcode
FROM dbo.U_dsi_Parameters with (nolock)
 where FormatCode = 'ETELADOC2X'

-- Clean EE List
Delete 
From dbo.U_ETELADOC2X_EEList 
Where xCOID <> dbo.dsi_fn_GetCurrentCOID(xEEID)
and xEEID in (Select xEEID From dbo.U_ETELADOC2X_EEList Group by xEEID Having Count(*) > 1);

-- BDM Code
-- now set values for benefit module
DELETE FROM dbo.U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode

-- Required parms

INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'DedCodes', 'CAD')
INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'StartDateTime',@startdate)
INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'EndDateTime',@enddate)
INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'TermSelectionOption', 'AuditDate')

-- Non-required parms
INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'CalcBenOptionDate', '2')
INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'IncludeOEDrops', 'Y')
INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'InvalidateBadDeps', 'Y')

INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'ExclFutureDatedStartDates', 'Y')
INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'ExclFutureDatedStopDates', 'Y')

INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'RelationshipsSpouse', 'SPS')
INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'RelationshipsChild', 'CHL,STC,DPC') 
INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'DedCodesDP', 'DP')

INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'BuildConsolidatedTable', 'Standard')

--Set if OE
if @exportcode like '%PASSIVE' 
BEGIN
     INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'PASSIVE')
END

if @exportcode like '%ACTIVE'
BEGIN
     INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'ACTIVE')
END

PRINT @FormatCode
EXEC dbo.dsi_bdm_sp_PopulateDeductionsTable @FormatCode

-- Get data from audit fields table.  Add fields here if auditing
if object_id('U_ETELADOC2X_AuditFields') is not null
  drop table dbo.U_ETELADOC2X_AuditFields
create table dbo.U_ETELADOC2X_AuditFields (aTableName varchar(30),aFieldName varchar(30))
insert into dbo.U_ETELADOC2X_AuditFields values ('empcomp','eecemplstatus')

-- Create audit table based on fields defined above
if object_id('U_ETELADOC2X_Audit') is not null
  drop table dbo.U_ETELADOC2X_Audit
SELECT audKey1Value audEEID, audKey2Value audKey2, audKey3Value audKey3,
 audTableName, audFieldName, audAction, audDateTime, audOldValue, audNewValue
  INTO dbo.U_ETELADOC2X_Audit
  FROM dbo.U_ETELADOC2X_EEList with (nolock)
  JOIN dbo.U_ETELADOC2X_AuditFields with (nolock) on 1 = 1
  JOIN dbo.vw_AuditData with (nolock) on xEEID = audKey1Value
 and audDateTime between @StartDate and @EndDate
 and audTableName = aTableName and audFieldName = aFieldName

-----------Build Drive Tables 
if object_id('U_ETELADOC2X_D11_drvTbl') is not null
 drop table dbo.U_ETELADOC2X_D11_drvTbl
select distinct 
  D11_MID_EecEmpNo        =EecEmpNo 
 ,D11_PID_EecEmpNo        =EecEmpNo 
 ,D11_RelationshipToPrimary='0'
 ,D11_NamePrefix        =EepNamePrefix
 ,D11_EepNameFirst        =EepNameFirst
 ,D11_MiddleName        =EepNameMiddle
 ,D11_LastName            =EepNameLast
 ,D11_NameSuffix        =EepNameSuffix
 ,D11_Gender            =EepGender
 ,D11_EecLanguageCode    =CASE WHEN EecLanguageCode = 'EN' THEN 'E' ELSE 'S' END 
 ,D11_BirthDate            =EepDateOfBirth
 ,D11_AddressLine1        =EepAddressLine1
 ,D11_AddressLine2        =EepAddressLine2
 ,D11_City                =EepAddressCity
 ,D11_StateAbbreviation    =EepAddressState
 ,D11_Zip                =EepAddressZipCode
 ,D11_EecPhoneHomeNumber=LEFT(LTRIM(RTRIM(EepPhoneHomeNumber)),3)
                                     + '-'
                                     + SUBSTRING(LTRIM(RTRIM(EepPhoneHomeNumber)),4,3)
                                     + '-'
                                     + RIGHT(LTRIM(RTRIM(EepPhoneHomeNumber)),4)
 ,D11_EecPhoneBusinessNumber=LEFT(LTRIM(RTRIM(EecPhoneBusinessNumber)),3)
                                        + '-'
                                        + SUBSTRING(LTRIM(RTRIM(EecPhoneBusinessNumber)),4,3)
                                        + '-'
                                        + RIGHT(LTRIM(RTRIM(EecPhoneBusinessNumber)),4)
 ,D11_EepAddressEMail        =EepAddressEMail
 ,D11_EedBenStartDate        =EedBenStartDate
 ,D11_DbnBenStopDate        =EedBenStopDate 
 ,drveeid                    =xeeid
 ,drvcoid                    =xcoid

into dbo.U_ETELADOC2X_D11_drvTbl

FROM dbo.U_ETELADOC2X_EELIST  with (nolock)
JOIN    EmpComp with (nolock)
   on xeeid = EecEEID  
   and xcoid = EecCoID 
JOIN   EmpPers with (nolock)
   ON  eepEEID = xEEID
join  dbo.U_dsi_bdm_EmpDeductions 
 on xeeid = eedeeid 
 and xcoid = eedcoid
where eedformatcode = @formatcode 
 and eedvalidforexport = 'Y'

-- Set FileName
if (dbo.dsi_fnVariable('ETELADOC2X','UseFileName') = 'N')
  update dbo.U_dsi_Parameters
     set ExportFile = 'USIINSURANCE_TELADOC_' + convert(char(8), GetDate(), 112) + '.csv'
   where FormatCode = 'ETELADOC2X'

/*
dsi_sp_testswitchbox_v2 'ETELADOC2X', 'ONDEMAND'
dsi_sp_testswitchbox_v2 'ETELADOC2X', 'SCHEDULED'
dsi_sp_testswitchbox_v2 'ETELADOC2X', 'OEPASSIVE'
dsi_sp_testswitchbox_v2 'ETELADOC2X', 'OEACTIVE'

--Alter the View
 ALTER  View dbo.dsi_vwETELADOC2X_Export as
         select top 20000000 Data from dbo.U_ETELADOC2X_File with (nolock)
         order by substring(RecordSet,2,2), InitialSort, subsort

--Testing
exec sp_geteeid ' '
select * from U_ETELADOC2X_D11_drvTbl where d11_lastname = 'collins'
select * from U_ETELADOC2X_drvTbl where drveeid =''
select * from U_ETELADOC2X_file

--Check out ascdeff
select * from ascdeff
where adfheadersystemid like '%ETELADOC2X%'
order by adfsetnumber, adffieldnumber

--Update Dates
update ascexp
 set explaststartpercontrol ='201303011'
  , expstartpercontrol ='201303011'
  , explastendpercontrol ='201303309'
  , expendpercontrol  ='201303309'
where ExpFormatCode ='ETELADOC2X'

select * from u_dsi_configuration where formatcode = 'ETELADOC2X'
select * from u_dsi_parameters where formatcode ='ETELADOC2X'
select * from u_dsi_sqlclauses where formatcode = 'ETELADOC2X'
*/
GO
Create View dbo.dsi_vwETELADOC2X_Export as
       select top 200000000 Data from dbo.U_ETELADOC2X_File with (nolock)
       order by substring(RecordSet,2,2), InitialSort