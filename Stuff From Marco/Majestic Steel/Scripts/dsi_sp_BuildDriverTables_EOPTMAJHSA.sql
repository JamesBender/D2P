SET NOCOUNT ON;
IF OBJECT_ID('U_EOPTMAJHSA_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EOPTMAJHSA_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EOPTMAJHSA_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EOPTMAJHSA' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEOPTMAJHSA_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEOPTMAJHSA_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EOPTMAJHSA') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EOPTMAJHSA];
GO
IF OBJECT_ID('U_EOPTMAJHSA_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EOPTMAJHSA_Trailer];
GO
IF OBJECT_ID('U_EOPTMAJHSA_Header') IS NOT NULL DROP TABLE [dbo].[U_EOPTMAJHSA_Header];
GO
IF OBJECT_ID('U_EOPTMAJHSA_File') IS NOT NULL DROP TABLE [dbo].[U_EOPTMAJHSA_File];
GO
IF OBJECT_ID('U_EOPTMAJHSA_EEList') IS NOT NULL DROP TABLE [dbo].[U_EOPTMAJHSA_EEList];
GO
IF OBJECT_ID('U_EOPTMAJHSA_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EOPTMAJHSA_drvTbl];
GO
IF OBJECT_ID('U_EOPTMAJHSA_DedList') IS NOT NULL DROP TABLE [dbo].[U_EOPTMAJHSA_DedList];
GO
IF OBJECT_ID('U_EOPTMAJHSA_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EOPTMAJHSA_AuditFields];
GO
IF OBJECT_ID('U_EOPTMAJHSA_Audit') IS NOT NULL DROP TABLE [dbo].[U_EOPTMAJHSA_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EOPTMAJHSA') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EOPTMAJHSA];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EOPTMAJHSA';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EOPTMAJHSA';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EOPTMAJHSA';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EOPTMAJHSA';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EOPTMAJHSA';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EOPTMAJHSA','Optum HSA Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','EOPTMAJHSAZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EOPTMAJHSA' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordType"','1','(''UA''=''F'')','EOPTMAJHSAZ0','1','H','01','1',NULL,'drvRecordType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayerName"','2','(''UA''=''F'')','EOPTMAJHSAZ0','40','H','01','2',NULL,'drvPayerName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerGroupName"','3','(''UA''=''F'')','EOPTMAJHSAZ0','40','H','01','3',NULL,'drvEmployerGroupName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPostingDate"','4','(''UD112''=''F'')','EOPTMAJHSAZ0','8','H','01','4',NULL,'drvPostingDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''DA''=''F'')','EOPTMAJHSAZ0','511','H','01','5',NULL,'drvFiller',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordType"','1','(''UA''=''F'')','EOPTMAJHSAZ0','1','D','10','1',NULL,'drvRecordType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerNumberGroupNumber"','2','(''UA''=''F'')','EOPTMAJHSAZ0','9','D','10','2',NULL,'drvEmployerNumberGroupNumber',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatusField"','3','(''UA''=''F'')','EOPTMAJHSAZ0','1','D','10','3',NULL,'drvStatusField',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSocialSecurityNumber"','4','(''UA''=''F'')','EOPTMAJHSAZ0','9','D','10','4',NULL,'drvSocialSecurityNumber',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeFirstName"','5','(''UA''=''F'')','EOPTMAJHSAZ0','18','D','10','5',NULL,'drvEmployeeFirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeMiddleInitial"','6','(''UA''=''F'')','EOPTMAJHSAZ0','1','D','10','6',NULL,'drvEmployeeMiddleInitial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeLastName"','7','(''UA''=''F'')','EOPTMAJHSAZ0','18','D','10','7',NULL,'drvEmployeeLastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStreetAddress1"','8','(''UA''=''F'')','EOPTMAJHSAZ0','30','D','10','8',NULL,'drvStreetAddress1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStreetAddress2"','9','(''UA''=''F'')','EOPTMAJHSAZ0','20','D','10','9',NULL,'drvStreetAddress2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','10','(''UA''=''F'')','EOPTMAJHSAZ0','22','D','10','10',NULL,'drvCity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','11','(''UA''=''F'')','EOPTMAJHSAZ0','2','D','10','11',NULL,'drvState',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZipCodeFour"','12','(''UA''=''F'')','EOPTMAJHSAZ0','9','D','10','12',NULL,'drvZipCodeFour',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofBirth"','13','(''UD112''=''F'')','EOPTMAJHSAZ0','8','D','10','13',NULL,'drvDateofBirth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPersonalPhoneNumber"','14','(''UA''=''F'')','EOPTMAJHSAZ0','10','D','10','14',NULL,'drvPersonalPhoneNumber',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBusinessPhoneNumber"','15','(''UA''=''F'')','EOPTMAJHSAZ0','10','D','10','15',NULL,'drvBusinessPhoneNumber',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drveMailAddress"','16','(''UA''=''F'')','EOPTMAJHSAZ0','60','D','10','16',NULL,'drveMailAddress',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeID"','17','(''UA''=''F'')','EOPTMAJHSAZ0','11','D','10','17',NULL,'drvEmployeeID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''DA''=''F'')','EOPTMAJHSAZ0','6','D','10','18',NULL,'drvFiller',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageType"','19','(''UA''=''F'')','EOPTMAJHSAZ0','1','D','10','19',NULL,'drvCoverageType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHDHPStartDate"','20','(''UD112''=''F'')','EOPTMAJHSAZ0','8','D','10','20',NULL,'drvHDHPStartDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationDate"','21','(''UD112''=''F'')','EOPTMAJHSAZ0','8','D','10','21',NULL,'drvTerminationDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHSAAffirmation"','22','(''UA''=''F'')','EOPTMAJHSAZ0','1','D','10','22',NULL,'drvHSAAffirmation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMailingAddress1"','23','(''UA''=''F'')','EOPTMAJHSAZ0','30','D','10','23',NULL,'drvMailingAddress1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMailingAddress2"','24','(''UA''=''F'')','EOPTMAJHSAZ0','20','D','10','24',NULL,'drvMailingAddress2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMailingCity"','25','(''UA''=''F'')','EOPTMAJHSAZ0','22','D','10','25',NULL,'drvMailingCity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMailingState"','26','(''UA''=''F'')','EOPTMAJHSAZ0','2','D','10','26',NULL,'drvMailingState',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMailingZipCodeFour"','27','(''UA''=''F'')','EOPTMAJHSAZ0','9','D','10','27',NULL,'drvMailingZipCodeFour',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','28','(''DA''=''F'')','EOPTMAJHSAZ0','209','D','10','28',NULL,'drvFiller1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWetSignatureInd"','29','(''UA''=''F'')','EOPTMAJHSAZ0','1','D','10','29',NULL,'drvWetSignatureInd',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvESignatureInd"','30','(''UA''=''F'')','EOPTMAJHSAZ0','1','D','10','30',NULL,'drvESignatureInd',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVerificationID"','31','(''UA''=''F'')','EOPTMAJHSAZ0','10','D','10','31',NULL,'drvVerificationID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDivisionCode"','32','(''UA''=''F'')','EOPTMAJHSAZ0','9','D','10','32',NULL,'drvDivisionCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','33','(''DA''=''F'')','EOPTMAJHSAZ0','17','D','10','33',NULL,'drvFiller2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','34','(''DA''=''F'')','EOPTMAJHSAZ0','7','D','10','34',NULL,'drvFiller3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordType"','1','(''UA''=''F'')','EOPTMAJHSAZ0','1','T','90','1',NULL,'drvRecordType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNumberofAccounts"','2','(''UA''=''F'')','EOPTMAJHSAZ0','7','T','90','2',NULL,'drvNumberofAccounts',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''DA''=''F'')','EOPTMAJHSAZ0','592','T','90','3',NULL,'drvFiller4',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EOPTMAJHSA_20210625.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Full File','202106159','EMPEXPORT','FULLFILE','Jun 15 2021 11:18PM','EOPTMAJHSA',NULL,NULL,NULL,'202106159','Jun 15 2021 12:00AM','Dec 30 1899 12:00AM','202105011','153','','','202105011',dbo.fn_GetTimedKey(),NULL,'us3cPeMAJ1001',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202106099','EMPEXPORT','OEACTIVE',NULL,'EOPTMAJHSA',NULL,NULL,NULL,'202106099','Jun  9 2021  5:01PM','Jun  9 2021  5:01PM','202106091',NULL,'','','202106091',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202106099','EMPEXPORT','OEPASSIVE',NULL,'EOPTMAJHSA',NULL,NULL,NULL,'202106099','Jun  9 2021  5:01PM','Jun  9 2021  5:01PM','202106091',NULL,'','','202106091',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Optum HSA Export','202106099','EMPEXPORT','ONDEM_XOE',NULL,'EOPTMAJHSA',NULL,NULL,NULL,'202106099','Jun  9 2021  5:01PM','Jun  9 2021  5:01PM','202106091',NULL,'','','202106091',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Optum HSA Export-Sched','202106099','EMPEXPORT','SCH_EOPTMA',NULL,'EOPTMAJHSA',NULL,NULL,NULL,'202106099','Jun  9 2021  5:01PM','Jun  9 2021  5:01PM','202106091',NULL,'','','202106091',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Optum HSA Export-Test','202106231','EMPEXPORT','TEST_XOE','Jun 23 2021  6:17PM','EOPTMAJHSA',NULL,NULL,NULL,'202106231','Jun 23 2021 12:00AM','Dec 30 1899 12:00AM','202104011','29','','','202104011',dbo.fn_GetTimedKey(),NULL,'us3cPeMAJ1001',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EOPTMAJHSA','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EOPTMAJHSA','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EOPTMAJHSA','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EOPTMAJHSA','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EOPTMAJHSA' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EOPTMAJHSA' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EOPTMAJHSA_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EOPTMAJHSA_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EOPTMAJHSA','H01','dbo.U_EOPTMAJHSA_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EOPTMAJHSA','D10','dbo.U_EOPTMAJHSA_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EOPTMAJHSA','T90','dbo.U_EOPTMAJHSA_Trailer',NULL);
IF OBJECT_ID('U_dsi_BDM_EOPTMAJHSA') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EOPTMAJHSA] (
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
IF OBJECT_ID('U_EOPTMAJHSA_Audit') IS NULL
CREATE TABLE [dbo].[U_EOPTMAJHSA_Audit] (
    [audEEID] char(12) NULL,
    [audCOID] char(5) NULL,
    [audKey1] varchar(255) NOT NULL,
    [audKey2] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] varchar(2000) NULL,
    [audNewValue] varchar(2000) NULL,
    [audEffectiveDate] smalldatetime NULL,
    [audRowNo] bigint NULL,
    [audDedChange] varchar(1) NOT NULL,
    [audBenOptionChange] varchar(1) NOT NULL,
    [audSSNChange] varchar(1) NOT NULL,
    [audNameChange] varchar(1) NOT NULL,
    [audDemoChange] varchar(1) NOT NULL,
    [audAddrChange] varchar(1) NOT NULL,
    [audNewlyEnroll] varchar(1) NOT NULL,
    [audReEnroll] varchar(1) NOT NULL,
    [audTermPlan] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EOPTMAJHSA_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EOPTMAJHSA_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_EOPTMAJHSA_DedList') IS NULL
CREATE TABLE [dbo].[U_EOPTMAJHSA_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EOPTMAJHSA_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EOPTMAJHSA_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
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
    [drvZipCodeFour] varchar(8000) NULL,
    [drvDateofBirth] datetime NULL,
    [drvPersonalPhoneNumber] varchar(50) NULL,
    [drvBusinessPhoneNumber] varchar(50) NULL,
    [drveMailAddress] varchar(50) NULL,
    [drvEmployeeID] char(9) NULL,
    [drvCoverageType] varchar(1) NULL,
    [drvHDHPStartDate] varchar(1) NOT NULL,
    [drvTerminationDate] varchar(1) NOT NULL,
    [drvHSAAffirmation] varchar(1) NOT NULL,
    [drvMailingAddress1] varchar(1) NOT NULL,
    [drvMailingAddress2] varchar(1) NOT NULL,
    [drvMailingCity] varchar(1) NOT NULL,
    [drvMailingState] varchar(1) NOT NULL,
    [drvMailingZipCodeFour] varchar(1) NOT NULL,
    [drvWetSignatureInd] varchar(1) NOT NULL,
    [drvESignatureInd] varchar(1) NOT NULL,
    [drvVerificationID] varchar(1) NOT NULL,
    [drvDivisionCode] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EOPTMAJHSA_EEList') IS NULL
CREATE TABLE [dbo].[U_EOPTMAJHSA_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EOPTMAJHSA_File') IS NULL
CREATE TABLE [dbo].[U_EOPTMAJHSA_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
IF OBJECT_ID('U_EOPTMAJHSA_Header') IS NULL
CREATE TABLE [dbo].[U_EOPTMAJHSA_Header] (
    [drvRecordType] varchar(1) NOT NULL,
    [drvPayerName] varchar(11) NOT NULL,
    [drvEmployerGroupName] varchar(22) NOT NULL,
    [drvPostingDate] datetime NOT NULL
);
IF OBJECT_ID('U_EOPTMAJHSA_Trailer') IS NULL
CREATE TABLE [dbo].[U_EOPTMAJHSA_Trailer] (
    [drvRecordType] varchar(1) NOT NULL,
    [drvNumberofAccounts] varchar(24) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EOPTMAJHSA]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Majestic Steel

Created By: Marco Lagrosa
Business Analyst: Cheryl Petitti
Create Date: 06/09/2021
Service Request Number: TekP-2021-04-09-0003

Purpose: Optum HSA Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EOPTMAJHSA';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EOPTMAJHSA';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EOPTMAJHSA';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EOPTMAJHSA';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EOPTMAJHSA' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EOPTMAJHSA', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EOPTMAJHSA', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EOPTMAJHSA', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EOPTMAJHSA', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EOPTMAJHSA', 'SCH_EOPTMA';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EOPTMAJHSA';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EOPTMAJHSA', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EOPTMAJHSA';

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
    DELETE FROM dbo.U_EOPTMAJHSA_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EOPTMAJHSA_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'HSACF,HSACI,HSAF,HSAI';

    IF OBJECT_ID('U_EOPTMAJHSA_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EOPTMAJHSA_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EOPTMAJHSA_DedList
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
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');

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
    -- Build Working Tables
    --==========================================
    --==========================================
    -- Audit Code
    --==========================================

    -- Get data from audit fields table.  Add fields here if auditing
    IF OBJECT_ID('U_EOPTMAJHSA_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EOPTMAJHSA_AuditFields;
    CREATE TABLE dbo.U_EOPTMAJHSA_AuditFields (aTableName VARCHAR(30),aFieldName VARCHAR(30));
    -- Employee Information

    INSERT INTO dbo.U_EOPTMAJHSA_AuditFields VALUES ('EmpPers','EepNameLast');
    INSERT INTO dbo.U_EOPTMAJHSA_AuditFields VALUES ('EmpPers','EepNameMiddle');
    INSERT INTO dbo.U_EOPTMAJHSA_AuditFields VALUES ('EmpPers','EepNamePrefix');
    INSERT INTO dbo.U_EOPTMAJHSA_AuditFields VALUES ('EmpPers','EepNameSuffix');
    INSERT INTO dbo.U_EOPTMAJHSA_AuditFields VALUES ('EmpPers','EepAddressLine1');
    INSERT INTO dbo.U_EOPTMAJHSA_AuditFields VALUES ('EmpPers','EepAddressLine2');
    INSERT INTO dbo.U_EOPTMAJHSA_AuditFields VALUES ('EmpPers','EepAddressCity');
    INSERT INTO dbo.U_EOPTMAJHSA_AuditFields VALUES ('EmpPers','EepAddressState');
    INSERT INTO dbo.U_EOPTMAJHSA_AuditFields VALUES ('EmpPers','EepAddressZipCode');
    INSERT INTO dbo.U_EOPTMAJHSA_AuditFields VALUES ('EmpPers','EepAddressCountry');
    INSERT INTO dbo.U_EOPTMAJHSA_AuditFields VALUES ('EmpComp','EecDateOfLastHire');
    INSERT INTO dbo.U_EOPTMAJHSA_AuditFields VALUES ('EmpComp','EecDateOfTermination');
    -- Employee Deduction/Benefit Information
    INSERT INTO dbo.U_EOPTMAJHSA_AuditFields VALUES ('EmpDed','EedDedCode');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EOPTMAJHSA_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EOPTMAJHSA_Audit;
    SELECT audEEID = xEEID
        ,audCOID = xCOID
        ,audKey1 = audKey1Value
        ,audKey2 = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
        ,audEffectiveDate
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
        ,audDedChange = CASE WHEN audTableName IN ('EmpDed','DepBPlan','DedCode') and audOldValue  IN('HSACF','HSACI','HSAF','HSAI') and audNewValue  IN('HSACF','HSACI','HSAF','HSAI') THEN 'Y'
                             ELSE 'N'
                        END
        ,audBenOptionChange = CASE WHEN audFieldName IN ('EedBenOption') THEN 'Y'
                                   ELSE 'N'
                              END
        ,audSSNChange = CASE WHEN audFieldName IN ('EepSSN','ConSSN') THEN 'Y'
                              ELSE 'N'
                        END
        ,audNameChange = CASE WHEN audTableName IN ('EmpPers','Contacts') AND audFieldName LIKE '%Name%' THEN 'Y'
                              WHEN audTableName IN ('EmpPers') AND audFieldName LIKE '%Prefix%' THEN 'Y'
                              WHEN audTableName IN ('EmpPers','Contacts') AND audFieldName LIKE '%Suffix%' THEN 'Y'
                              ELSE 'N'
                         END
        ,audDemoChange = CASE WHEN audFieldName IN ('EepGender','EepDateOfBirth','EepMaritalStatus','ConGender','ConDateOfBirth','ConRelationship') THEN 'Y'
                              ELSE 'N'
                         END
        ,audAddrChange = CASE WHEN audTableName IN ('EmpPers','Contacts') AND audFieldName LIKE '%Address%' THEN 'Y'
                              ELSE 'N'
                         END
        ,audNewlyEnroll = CASE WHEN audFieldName IN ('EedBenStatus','DbnBenStatus') AND ISNULL(audOldValue,'') = '' AND audNewValue = 'A' THEN 'Y'
                               ELSE 'N'
                          END
        ,audReEnroll = CASE WHEN audFieldName IN ('EedBenStatus','DbnBenStatus') AND ISNULL(audOldValue,'') NOT IN ('A','') AND audNewValue = 'A' THEN 'Y'
                            WHEN audFieldName IN ('EedBenStartDate','DbnBenStartDate') AND ISNULL(audOldValue,'') <> '' AND ISNULL(audNewValue,'') <> '' THEN 'Y'
                            ELSE 'N'
                       END
        ,audTermPlan = CASE WHEN audFieldName IN ('EedBenStatus','DbnBenStatus') AND audOldValue = 'A' AND ISNULL(audNewValue,'') NOT IN ('A','') THEN 'Y'
                            WHEN audFieldName IN ('EedBenStopDate','DbnBenStopDate') AND ISNULL(audNewValue,'') <> '' THEN 'Y'
                            ELSE 'N'
                       END
    INTO dbo.U_EOPTMAJHSA_Audit
    FROM dbo.U_EOPTMAJHSA_EEList WITH (NOLOCK)
    JOIN dbo.vw_AuditData WITH (NOLOCK)
        ON xEEID = audKey1Value
    JOIN dbo.U_EOPTMAJHSA_AuditFields WITH (NOLOCK)
        ON aTableName = audTableName
        AND aFieldName = audFieldName
    LEFT JOIN dbo.DepBPlan WITH (NOLOCK)
        ON DbnEEID = xEEID
        AND DbnDedCode = audKey2Value
        AND DbnSystemID = audKey3Value
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND ISNULL(audNewValue, '') <> ''
    AND ((audTableName NOT IN ('EmpDed','DepBPlan'))
        OR (audTableName = 'EmpDed' AND audKey3Value IN (SELECT DedCode FROM dbo.U_EOPTMAJHSA_DedList))
        OR (audTableName = 'DepBPlan' AND audKey2Value IN (SELECT DedCode FROM dbo.U_EOPTMAJHSA_DedList))
    );

     IF (@Exportcode NOT IN ('FULLFILE','OEACTIVE','OEPASSIVE'))
    BEGIN
        -- Remove Employees with No Changes in Audit
        DELETE FROM dbo.U_EOPTMAJHSA_EELIST
        WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EOPTMAJHSA_Audit WHERE audEEID = xEEID AND audRowNo = 1);
    END;

     --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EOPTMAJHSA_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EOPTMAJHSA_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EOPTMAJHSA_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRecordType = 'B'
        ,drvEmployerNumberGroupNumber = '705724'
        ,drvStatusField = CASE WHEN EecEmplStatus = 'T' THEN '3' ELSE '2' END
        ,drvSocialSecurityNumber = eepSSN
        ,drvEmployeeFirstName = EepNameFirst
        ,drvEmployeeMiddleInitial = LEFT(Isnull(EepNameMiddle,''),1)
        ,drvEmployeeLastName = EepNameLast
        ,drvStreetAddress1 = EepAddressLine1
        ,drvStreetAddress2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZipCodeFour =  EepaddresszipCode + Replicate('0',9 - Len(EepaddresszipCode))
        ,drvDateofBirth = EepDateOfBirth
        ,drvPersonalPhoneNumber = eepPhonehomeNumber
        ,drvBusinessPhoneNumber = EecPhoneBusinessNumber
        ,drveMailAddress = EepAddressEMail
        ,drvEmployeeID = EecEmpNo
        ,drvCoverageType = CASE WHEN Bdmdedcode IN ('HSACF', 'HSAF') THEN 'F'
                                WHEN Bdmdedcode IN ('HSACI', 'HSAI ') THEN 'I'
                           END
        ,drvHDHPStartDate = ''
        ,drvTerminationDate = ''
        ,drvHSAAffirmation = 'N'
        ,drvMailingAddress1 = ''
        ,drvMailingAddress2 = ''
        ,drvMailingCity = ''
        ,drvMailingState = ''
        ,drvMailingZipCodeFour = ''
        ,drvWetSignatureInd = 'Y'
        ,drvESignatureInd = 'N'
        ,drvVerificationID = ''
        ,drvDivisionCode = ''
    INTO dbo.U_EOPTMAJHSA_drvTbl
    FROM dbo.U_EOPTMAJHSA_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EOPTMAJHSA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EOPTMAJHSA_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EOPTMAJHSA_Header;
    SELECT DISTINCT
         drvRecordType = 'A'
        ,drvPayerName = 'TekPartners'
        ,drvEmployerGroupName = 'MAJESTIC STEEL USA INC'
        ,drvPostingDate = GETDATE()
    INTO dbo.U_EOPTMAJHSA_Header
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EOPTMAJHSA_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_EOPTMAJHSA_Trailer;
    SELECT DISTINCT
         drvRecordType = 'Z'
        ,drvNumberofAccounts = dbo.dsi_fnpadzero((ISNULL((Select count(*) from dbo.U_EOPTMAJHSA_drvTbl),0)),7,0) 
    INTO dbo.U_EOPTMAJHSA_Trailer
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
ALTER VIEW dbo.dsi_vwEOPTMAJHSA_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EOPTMAJHSA_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EOPTMAJHSA%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202106021'
       ,expStartPerControl     = '202106021'
       ,expLastEndPerControl   = '202106099'
       ,expEndPerControl       = '202106099'
WHERE expFormatCode = 'EOPTMAJHSA';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEOPTMAJHSA_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EOPTMAJHSA_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort