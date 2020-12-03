SET NOCOUNT ON;
IF OBJECT_ID('U_EMETLDNVIS_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EMETLDNVIS_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EMETLDNVIS_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EMETLDNVIS' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEMETLDNVIS_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEMETLDNVIS_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EMETLDNVIS') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMETLDNVIS];
GO
IF OBJECT_ID('U_EMETLDNVIS_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EMETLDNVIS_PEarHist];
GO
IF OBJECT_ID('U_EMETLDNVIS_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EMETLDNVIS_PDedHist];
GO
IF OBJECT_ID('U_EMETLDNVIS_Header') IS NOT NULL DROP TABLE [dbo].[U_EMETLDNVIS_Header];
GO
IF OBJECT_ID('U_EMETLDNVIS_File') IS NOT NULL DROP TABLE [dbo].[U_EMETLDNVIS_File];
GO
IF OBJECT_ID('U_EMETLDNVIS_EEList') IS NOT NULL DROP TABLE [dbo].[U_EMETLDNVIS_EEList];
GO
IF OBJECT_ID('U_EMETLDNVIS_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EMETLDNVIS_drvTbl];
GO
IF OBJECT_ID('U_EMETLDNVIS_DedList') IS NOT NULL DROP TABLE [dbo].[U_EMETLDNVIS_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EMETLDNVIS') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EMETLDNVIS];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EMETLDNVIS';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EMETLDNVIS';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EMETLDNVIS';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EMETLDNVIS';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EMETLDNVIS';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EMETLDNVIS','MetLife Den and Vis Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','351','S','N','EMETLDNVISZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EMETLDNVIS' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"A"','1','(''DA''=''F'')','EMETLDNVISZ0','1','H','01','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0230465"','2','(''DA''=''F'')','EMETLDNVISZ0','7','H','01','2',NULL,'UIS Customer Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFileRunDate"','3','(''UDMDY''=''F'')','EMETLDNVISZ0','8','H','01','9',NULL,'Date File Created',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Financial Bankshares"','4','(''DA''=''F'')','EMETLDNVISZ0','50','H','01','17',NULL,'Employer Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Financial Bankshares"','5','(''DA''=''F'')','EMETLDNVISZ0','1','H','01','67',NULL,'Changes Only Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordType"','1','(''UA''=''F'')','EMETLDNVISZ0','1','D','10','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0230465"','2','(''DA''=''F'')','EMETLDNVISZ0','7','D','10','2',NULL,'Customer Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','3','(''UA''=''F'')','EMETLDNVISZ0','11','D','10','9',NULL,'Employee ID (typically SSN)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','4','(''DA''=''F'')','EMETLDNVISZ0','10','D','10','20',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemberSSN"','5','(''UA''=''F'')','EMETLDNVISZ0','9','D','10','30',NULL,'Member Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','6','(''UA''=''F'')','EMETLDNVISZ0','20','D','10','39',NULL,'[Employee] Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','7','(''UA''=''F'')','EMETLDNVISZ0','12','D','10','59',NULL,'[Employee] First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','8','(''UA''=''F'')','EMETLDNVISZ0','1','D','10','71',NULL,'[Employee] Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBirthDate"','9','(''UDMDY''=''F'')','EMETLDNVISZ0','8','D','10','72',NULL,'[Employee] Birth Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaricalStatus"','10','(''UA''=''F'')','EMETLDNVISZ0','1','D','10','80',NULL,'[Employee] Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSex"','11','(''UA''=''F'')','EMETLDNVISZ0','1','D','10','81',NULL,'[Employee] Sex',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelationshipCode"','12','(''UA''=''F'')','EMETLDNVISZ0','2','D','10','82',NULL,'Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeEmploymentDate"','13','(''UDMDY''=''F'')','EMETLDNVISZ0','8','D','10','84',NULL,'[Employee''s] Employment Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPersonalID"','14','(''UA''=''F'')','EMETLDNVISZ0','9','D','10','92',NULL,'Personnel ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomePhone"','15','(''UA''=''F'')','EMETLDNVISZ0','10','D','10','101',NULL,'Home Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','16','(''DA''=''F'')','EMETLDNVISZ0','56','D','10','111',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','17','(''DA''=''F'')','EMETLDNVISZ0','1','D','10','167',NULL,'Foreign Address Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','18','(''UA''=''F'')','EMETLDNVISZ0','32','D','10','168',NULL,'[Employee] Mailing Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','19','(''UA''=''F'')','EMETLDNVISZ0','32','D','10','200',NULL,'[Employee] Mailing Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','20','(''UA''=''F'')','EMETLDNVISZ0','21','D','10','232',NULL,'[Employee] Mailing Address - City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','21','(''UA''=''F'')','EMETLDNVISZ0','2','D','10','253',NULL,'[Employee] Mailing Address - State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','22','(''UA''=''F'')','EMETLDNVISZ0','9','D','10','255',NULL,'[Employee] Mailing Address - Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalCoverage"','23','(''UA''=''F'')','EMETLDNVISZ0','2','D','10','264',NULL,'Dental Coverage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalCoverageStartDate"','24','(''UDMDY''=''F'')','EMETLDNVISZ0','8','D','10','266',NULL,'Dental Coverage Start Date (Insurance Effective Da',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalCoveragteStopDate"','25','(''UDMDY''=''F'')','EMETLDNVISZ0','8','D','10','274',NULL,'Dental Coverage Stop Date (Insurance Cancel Date)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalReportNumber"','26','(''UA''=''F'')','EMETLDNVISZ0','7','D','10','282',NULL,'Dental Report Number (Group Number)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalSubCode"','27','(''UA''=''F'')','EMETLDNVISZ0','4','D','10','289',NULL,'Dental SubCode (Subdivision)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalSubPoint"','28','(''UA''=''F'')','EMETLDNVISZ0','4','D','10','293',NULL,'Dental SubPoint (Branch)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','29','(''DA''=''F'')','EMETLDNVISZ0','2','D','10','297',NULL,'Dental Plan code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalStatusCode"','30','(''UA''=''F'')','EMETLDNVISZ0','8','D','10','299',NULL,'Dental Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalMembersCovered"','31','(''UA''=''F'')','EMETLDNVISZ0','1','D','10','307',NULL,'Dental Members Covered Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','32','(''DA''=''F'')','EMETLDNVISZ0','2','D','10','308',NULL,'COBRA Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVisionCoverage"','33','(''UA''=''F'')','EMETLDNVISZ0','2','D','10','310',NULL,'Vision Coverage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVisionCoverageStartDate"','34','(''UDMDY''=''F'')','EMETLDNVISZ0','8','D','10','312',NULL,'Vision Coverage Start Date (Insurance Effective Da',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVisionCoverageStopDate"','35','(''UDMDY''=''F'')','EMETLDNVISZ0','8','D','10','320',NULL,'Vision Coverage Stop Date (Insurance Cancel Date)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVisionReportNumber"','36','(''UA''=''F'')','EMETLDNVISZ0','7','D','10','328',NULL,'Vision Report Number (Group Number)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVisionSubCode"','37','(''UA''=''F'')','EMETLDNVISZ0','4','D','10','335',NULL,'Vision SubCode (Subdivision)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVisionSubPoint"','38','(''UA''=''F'')','EMETLDNVISZ0','4','D','10','339',NULL,'Vision SubPoint (Branch)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVisionMembersCovered"','39','(''UA''=''F'')','EMETLDNVISZ0','1','D','10','343',NULL,'Vision Members Covered Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','40','(''DA''=''F'')','EMETLDNVISZ0','2','D','10','344',NULL,'Vision Cobra',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','41','(''DA''=''F'')','EMETLDNVISZ0','2','D','10','346',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','42','(''DA''=''F'')','EMETLDNVISZ0','8','D','10','348',NULL,'DHMO Facility Code',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EMETLDNVIS_20201122.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202011109','EMPEXPORT','OEACTIVE',NULL,'EMETLDNVIS',NULL,NULL,NULL,'202011109','Nov 10 2020  4:49PM','Nov 10 2020  4:49PM','202011101',NULL,'','','202011101',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202011109','EMPEXPORT','OEPASSIVE',NULL,'EMETLDNVIS',NULL,NULL,NULL,'202011109','Nov 10 2020  4:49PM','Nov 10 2020  4:49PM','202011101',NULL,'','','202011101',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'MetLife Den and Vis Export','202011109','EMPEXPORT','ONDEM_XOE',NULL,'EMETLDNVIS',NULL,NULL,NULL,'202011109','Nov 10 2020  4:49PM','Nov 10 2020  4:49PM','202011101',NULL,'','','202011101',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'MetLife Den and Vis Expo-Sched','202011109','EMPEXPORT','SCH_EMETLD',NULL,'EMETLDNVIS',NULL,NULL,NULL,'202011109','Nov 10 2020  4:49PM','Nov 10 2020  4:49PM','202011101',NULL,'','','202011101',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'MetLife Den and Vis Expo-Test','202011191','EMPEXPORT','TEST_XOE','Nov 20 2020 12:00AM','EMETLDNVIS',NULL,NULL,NULL,'202011191','Nov 19 2020 12:00AM','Dec 30 1899 12:00AM','202011051',NULL,'','','202011051',dbo.fn_GetTimedKey(),NULL,'CPETITTI11',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMETLDNVIS','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMETLDNVIS','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMETLDNVIS','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMETLDNVIS','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMETLDNVIS','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EMETLDNVIS' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EMETLDNVIS' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EMETLDNVIS_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EMETLDNVIS_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMETLDNVIS','H01','dbo.U_EMETLDNVIS_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMETLDNVIS','D10','dbo.U_EMETLDNVIS_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_EMETLDNVIS') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EMETLDNVIS] (
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
IF OBJECT_ID('U_EMETLDNVIS_DedList') IS NULL
CREATE TABLE [dbo].[U_EMETLDNVIS_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EMETLDNVIS_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EMETLDNVIS_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(14) NULL,
    [drvRecordType] varchar(1) NOT NULL,
    [drvSSN] varchar(13) NULL,
    [drvMemberSSN] char(11) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvBirthDate] datetime NULL,
    [drvMaricalStatus] varchar(1) NULL,
    [drvSex] varchar(1) NULL,
    [drvRelationshipCode] varchar(2) NULL,
    [drvEmployeeEmploymentDate] datetime NULL,
    [drvPersonalID] char(9) NULL,
    [drvHomePhone] varchar(50) NULL,
    [drvAddressLine1] varchar(8000) NULL,
    [drvAddressLine2] varchar(8000) NULL,
    [drvAddressCity] varchar(8000) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(8000) NULL,
    [drvDentalCoverage] varchar(1) NULL,
    [drvDentalCoverageStartDate] datetime NULL,
    [drvDentalCoveragteStopDate] datetime NULL,
    [drvDentalReportNumber] varchar(7) NULL,
    [drvDentalSubCode] varchar(4) NULL,
    [drvDentalSubPoint] varchar(4) NULL,
    [drvDentalStatusCode] varchar(1) NULL,
    [drvDentalMembersCovered] varchar(1) NULL,
    [drvVisionCoverage] varchar(2) NULL,
    [drvVisionCoverageStartDate] datetime NULL,
    [drvVisionCoverageStopDate] datetime NULL,
    [drvVisionReportNumber] varchar(7) NULL,
    [drvVisionSubCode] varchar(4) NULL,
    [drvVisionSubPoint] varchar(4) NULL,
    [drvVisionMembersCovered] varchar(1) NULL
);
IF OBJECT_ID('U_EMETLDNVIS_EEList') IS NULL
CREATE TABLE [dbo].[U_EMETLDNVIS_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EMETLDNVIS_File') IS NULL
CREATE TABLE [dbo].[U_EMETLDNVIS_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(351) NULL
);
IF OBJECT_ID('U_EMETLDNVIS_Header') IS NULL
CREATE TABLE [dbo].[U_EMETLDNVIS_Header] (
    [drvFileRunDate] datetime NOT NULL
);
IF OBJECT_ID('U_EMETLDNVIS_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EMETLDNVIS_PDedHist] (
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
IF OBJECT_ID('U_EMETLDNVIS_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EMETLDNVIS_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMETLDNVIS]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: First Financial Bankshares

Created By: James Bender
Business Analyst: Cheryl Petitti
Create Date: 11/10/2020
Service Request Number: TekP-2020-10-09-0001

Purpose: MetLife Den and Vis Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EMETLDNVIS';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EMETLDNVIS';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EMETLDNVIS';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EMETLDNVIS';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EMETLDNVIS' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMETLDNVIS', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMETLDNVIS', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMETLDNVIS', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMETLDNVIS', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMETLDNVIS', 'SCH_EMETLD';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EMETLDNVIS';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EMETLDNVIS', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@EndPerControl     VARCHAR(9)
            ,@FileMinCovDate    DATETIME
            ;

    -- Set FormatCode
    SELECT @FormatCode = 'EMETLDNVIS';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@FileMinCovDate    = '1/1/2021'
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EMETLDNVIS_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EMETLDNVIS_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    DELETE FROM dbo.U_EMETLDNVIS_EEList WHERE xEEID IN (
        SELECT DISTINCT EecEEID FROM dbo.EmpComp WITH (NOLOCK) WHERE EecEEType = 'TES'
    )

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'DENLP,DENHP,VISP';

    IF OBJECT_ID('U_EMETLDNVIS_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EMETLDNVIS_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EMETLDNVIS_DedList
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
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EMETLDNVIS_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EMETLDNVIS_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('401K') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('ROTH') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('MATCH') THEN PdhERCurAmt ELSE 0.00 END)        
        ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('401CU') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('401KL1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('401KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    INTO dbo.U_EMETLDNVIS_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EMETLDNVIS_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EMETLDNVIS_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EMETLDNVIS_PEarHist;
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
    INTO dbo.U_EMETLDNVIS_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EMETLDNVIS_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EMETLDNVIS_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EMETLDNVIS_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = xEEID + CASE WHEN BdmRecType = 'EMP' THEN ' 1' ELSE ' 2' END
        -- standard fields above and additional driver fields below
        ,drvRecordType = CASE WHEN BdmRecType = 'EMP' THEN 'E' ELSE 'D' END
        ,drvSSN = '00' + RTRIM(eepSSN)
        ,drvMemberSSN = CASE WHEN BdmRecType = 'EMP' THEN eepSSN ELSE ConSSN END
        ,drvNameLast = CASE WHEN BdmRecType = 'EMP' THEN EepNameLast ELSE ConNameLast END
        ,drvNameFirst = CASE WHEN BdmRecType = 'EMP' THEN EepNameFirst ELSE ConNameFirst END
        ,drvNameMiddle = CASE WHEN BdmRecType = 'EMP' THEN LEFT(EepNameMiddle,1) ELSE LEFT(ConNameMiddle,1) END
        ,drvBirthDate = CASE WHEN BdmRecType = 'EMP' THEN EepDateOfBirth ELSE ConDateOfBirth END
        ,drvMaricalStatus =    CASE WHEN BdmRecType = 'EMP' THEN
                                CASE WHEN EepMaritalStatus IN ('S','M') THEN EepMaritalStatus ELSE 'U' END
                            END
        ,drvSex =    CASE WHEN BdmRecType = 'EMP' THEN
                            CASE WHEN EepGender IN ('F','M') THEN EepGender ELSE 'U' END
                        ELSE
                            CASE WHEN ConGender IN ('F','M') THEN ConGender ELSE 'U' END
                    END
        ,drvRelationshipCode =    CASE WHEN BdmRecType = 'EMP' THEN '00'
                                    WHEN ConRelationship IN ('CHL','DCH','DPC','STC') THEN '02'
                                    WHEN ConRelationship IN ('DP','SPS') THEN '01'
                                END
        ,drvEmployeeEmploymentDate = EecDateOfLastHire
        ,drvPersonalID = EecEmpNo
        ,drvHomePhone = CASE WHEN BdmRecType = 'EMP' THEN EepPhoneHomeNumber ELSE ConPhoneHomeNumber END
        ,drvAddressLine1 = REPLACE(REPLACE(REPLACE(EepAddressLine1, ',', ''), '.', ''), '-', '')
        ,drvAddressLine2 = REPLACE(REPLACE(REPLACE(EepAddressLine2, ',', ''), '.', ''), '-', '')
        ,drvAddressCity = REPLACE(REPLACE(REPLACE(EepAddressCity, ',', ''), '.', ''), '-', '')
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = REPLACE(REPLACE(REPLACE(EepAddressZipCode, ',', ''), '.', ''), '-', '')
        ,drvDentalCoverage = CASE WHEN DENLP_DedCode IS NOT NULL OR DENHP_DedCode IS NOT NULL THEN 'D' END
        ,drvDentalCoverageStartDate =    CASE WHEN DENLP_DedCode IS NOT NULL OR DENHP_DedCode IS NOT NULL THEN
                                            dbo.dsi_fnGetMinMaxDates('MAX',
                                                CASE WHEN DENLP_DedCode IS NOT NULL THEN DENLP_StartDate
                                                    WHEN DENHP_DedCode IS NOT NULL THEN DENHP_StartDate
                                                END
                                                ,@FileMinCovDate)
                                        END
        ,drvDentalCoveragteStopDate =    CASE WHEN DENLP_DedCode IS NOT NULL OR DENHP_DedCode IS NOT NULL THEN
                                            CASE WHEN DENLP_DedCode IS NOT NULL THEN DENLP_StopDate
                                                WHEN DENHP_DedCode IS NOT NULL THEN DENHP_StopDate
                                            END
                                        END
        ,drvDentalReportNumber = CASE WHEN DENLP_DedCode IS NOT NULL OR DENHP_DedCode IS NOT NULL THEN '0230465' END
        ,drvDentalSubCode = CASE WHEN DENLP_DedCode IS NOT NULL OR DENHP_DedCode IS NOT NULL THEN '0001' END
        ,drvDentalSubPoint =    CASE WHEN DENHP_DedCode IS NOT NULL THEN '0001'
                                    WHEN DENLP_DedCode IS NOT NULL THEN '0002'
                                END
        ,drvDentalStatusCode = CASE WHEN DENLP_DedCode IS NOT NULL OR DENHP_DedCode IS NOT NULL THEN 'A' END
        ,drvDentalMembersCovered =    CASE WHEN DENLP_DedCode IS NOT NULL OR DENHP_DedCode IS NOT NULL THEN
                                        CASE WHEN DENLP_BenOption IN ('EE','OO') OR DENHP_BenOption IN ('EE','OO') THEN '1'
                                            WHEN DENLP_BenOption IN ('ES','OS') OR DENHP_BenOption IN ('ES','OS') THEN '3'
                                            WHEN DENLP_BenOption IN ('EC','OC') OR DENHP_BenOption IN ('EC','OC') THEN '2'
                                            WHEN DENLP_BenOption IN ('EF','OF') OR DENHP_BenOption IN ('EF','OF') THEN '4'
                                        END
                                    END
        ,drvVisionCoverage = CASE WHEN VISP_DedCode IS NOT NULL THEN 'VV' END
        ,drvVisionCoverageStartDate = CASE WHEN VISP_DedCode IS NOT NULL THEN VISP_StartDate END
        ,drvVisionCoverageStopDate = CASE WHEN VISP_DedCode IS NOT NULL THEN VISP_StopDate END
        ,drvVisionReportNumber = CASE WHEN VISP_DedCode IS NOT NULL THEN '0230465' END
        ,drvVisionSubCode = CASE WHEN VISP_DedCode IS NOT NULL THEN '0001' END
        ,drvVisionSubPoint = CASE WHEN VISP_DedCode IS NOT NULL THEN '0003' END
        ,drvVisionMembersCovered =  CASE WHEN VISP_DedCode IS NOT NULL AND VISP_BenOption IN ('EO','OO') THEN '1'
                                        WHEN VISP_DedCode IS NOT NULL AND VISP_BenOption IN ('ES','OS') THEN '3'
                                        WHEN VISP_DedCode IS NOT NULL AND VISP_BenOption IN ('EC','OC') THEN '2'
                                        WHEN VISP_DedCode IS NOT NULL AND VISP_BenOption IN ('EF','OF') THEN '4'
                                    END
    INTO dbo.U_EMETLDNVIS_drvTbl
    FROM dbo.U_EMETLDNVIS_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
--    JOIN dbo.U_dsi_BDM_EMETLDNVIS WITH (NOLOCK)
--        ON BdmEEID = xEEID 
--        AND BdmCoID = xCoID
    JOIN (
            SELECT BdmEEID
                ,BdmCOID
                ,BdmDepRecID
                ,MAX(BdmRecType) AS BdmRecType
                ,MAX(CASE WHEN BdmDedCode IN ('DENLP') THEN BdmDedCode END) AS DENLP_DedCode
                ,MAX(CASE WHEN BdmDedCode IN ('DENLP') THEN BdmBenStartDate END) AS DENLP_StartDate
                ,MAX(CASE WHEN BdmDedCode IN ('DENLP') THEN BdmBenStopDate END) AS DENLP_StopDate
                ,MAX(CASE WHEN BdmDedCode IN ('DENLP') THEN BdmBenOption END) AS DENLP_BenOption    
                ,MAX(CASE WHEN BdmDedCode IN ('DENHP') THEN BdmDedCode END) AS DENHP_DedCode
                ,MAX(CASE WHEN BdmDedCode IN ('DENHP') THEN BdmBenStartDate END) AS DENHP_StartDate
                ,MAX(CASE WHEN BdmDedCode IN ('DENHP') THEN BdmBenStopDate END) AS DENHP_StopDate
                ,MAX(CASE WHEN BdmDedCode IN ('DENHP') THEN BdmBenOption END) AS DENHP_BenOption
                ,MAX(CASE WHEN BdmDedCode IN ('VISP') THEN BdmDedCode END) AS VISP_DedCode
                ,MAX(CASE WHEN BdmDedCode IN ('VISP') THEN BdmBenStartDate END) AS VISP_StartDate
                ,MAX(CASE WHEN BdmDedCode IN ('VISP') THEN BdmBenStopDate END) AS VISP_StopDate
                ,MAX(CASE WHEN BdmDedCode IN ('VISP') THEN BdmBenOption END) AS VISP_BenOption
            FROM dbo.U_dsi_BDM_EMETLDNVIS WITH (NOLOCK)
            GROUP BY BdmEEID, BdmCOID, BdmDepRecID) AS Bdm
        ON BdmEEID = xEEID
        AND BdmCOID = xCOID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
    WHERE EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND EecDateOfTermination BETWEEN @StartDate AND @EndDate)
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EMETLDNVIS_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EMETLDNVIS_Header;
    SELECT DISTINCT
         drvFileRunDate = GETDATE()
    INTO dbo.U_EMETLDNVIS_Header
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
ALTER VIEW dbo.dsi_vwEMETLDNVIS_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EMETLDNVIS_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EMETLDNVIS%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202011031'
       ,expStartPerControl     = '202011031'
       ,expLastEndPerControl   = '202011109'
       ,expEndPerControl       = '202011109'
WHERE expFormatCode = 'EMETLDNVIS';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEMETLDNVIS_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EMETLDNVIS_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort