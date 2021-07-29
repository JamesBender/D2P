SET NOCOUNT ON;
IF OBJECT_ID('U_EDRBMUSEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EDRBMUSEXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EDRBMUSEXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EDRBMUSEXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEDRBMUSEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEDRBMUSEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EDRBMUSEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EDRBMUSEXP];
GO
IF OBJECT_ID('U_EDRBMUSEXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EDRBMUSEXP_PEarHist];
GO
IF OBJECT_ID('U_EDRBMUSEXP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EDRBMUSEXP_PDedHist];
GO
IF OBJECT_ID('U_EDRBMUSEXP_File') IS NOT NULL DROP TABLE [dbo].[U_EDRBMUSEXP_File];
GO
IF OBJECT_ID('U_EDRBMUSEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EDRBMUSEXP_EEList];
GO
IF OBJECT_ID('U_EDRBMUSEXP_drvTbl_TEMP') IS NOT NULL DROP TABLE [dbo].[U_EDRBMUSEXP_drvTbl_TEMP];
GO
IF OBJECT_ID('U_EDRBMUSEXP_drvTbl_') IS NOT NULL DROP TABLE [dbo].[U_EDRBMUSEXP_drvTbl_];
GO
IF OBJECT_ID('U_EDRBMUSEXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EDRBMUSEXP_drvTbl];
GO
IF OBJECT_ID('U_EDRBMUSEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EDRBMUSEXP_DedList];
GO
IF OBJECT_ID('U_EDRBMUSEXP_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EDRBMUSEXP_AuditFields];
GO
IF OBJECT_ID('U_EDRBMUSEXP_Audit') IS NOT NULL DROP TABLE [dbo].[U_EDRBMUSEXP_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EDRBMUSEXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EDRBMUSEXP];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EDRBMUSEXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EDRBMUSEXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EDRBMUSEXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EDRBMUSEXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EDRBMUSEXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EDRBMUSEXP','Dearborn File Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','10000','S','N','EDRBMUSEXPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EDRBMUSEXP' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordType"','1','(''UA''=''F'')','EDRBMUSEXPZ0','2','D','10','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGroupNumber"','2','(''UA''=''F'')','EDRBMUSEXPZ0','10','D','10','2',NULL,'Group Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeSSN"','3','(''UA''=''F'')','EDRBMUSEXPZ0','9','D','10','3',NULL,'Employee SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNewParticipantId"','4','(''UA''=''F'')','EDRBMUSEXPZ0','9','D','10','4',NULL,'New Participant Id',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccountNumber"','5','(''UA''=''F'')','EDRBMUSEXPZ0','5','D','10','5',NULL,'Account Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDependentSSN"','6','(''UA''=''F'')','EDRBMUSEXPZ0','9','D','10','6',NULL,'Dependent SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemberEffectiveDate"','7','(''UA''=''F'')','EDRBMUSEXPZ0','8','D','10','7',NULL,'Member Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIDNumber"','8','(''UA''=''F'')','EDRBMUSEXPZ0','12','D','10','8',NULL,'ID Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastName"','9','(''UA''=''F'')','EDRBMUSEXPZ0','20','D','10','9',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstName"','10','(''UA''=''F'')','EDRBMUSEXPZ0','17','D','10','10',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMiddleInitial"','11','(''UA''=''F'')','EDRBMUSEXPZ0','1','D','10','11',NULL,'Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','12','(''UA''=''F'')','EDRBMUSEXPZ0','30','D','10','12',NULL,'Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFiller1"','13','(''UA''=''F'')','EDRBMUSEXPZ0','10','D','10','13',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','14','(''UA''=''F'')','EDRBMUSEXPZ0','30','D','10','14',NULL,'Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFiller2"','15','(''UA''=''F'')','EDRBMUSEXPZ0','10','D','10','15',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine3"','16','(''UA''=''F'')','EDRBMUSEXPZ0','40','D','10','16',NULL,'Address Line 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','17','(''UA''=''F'')','EDRBMUSEXPZ0','20','D','10','17',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFiller3"','18','(''UA''=''F'')','EDRBMUSEXPZ0','9','D','10','18',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','19','(''UA''=''F'')','EDRBMUSEXPZ0','2','D','10','19',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZipCode"','20','(''UA''=''F'')','EDRBMUSEXPZ0','9','D','10','20',NULL,'Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelationshipCode"','21','(''UA''=''F'')','EDRBMUSEXPZ0','1','D','10','21',NULL,'Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','22','(''UA''=''F'')','EDRBMUSEXPZ0','1','D','10','22',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofBirth"','23','(''UD112''=''F'')','EDRBMUSEXPZ0','8','D','10','23',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSmokerIndicator"','24','(''UA''=''F'')','EDRBMUSEXPZ0','1','D','10','24',NULL,'Smoker Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofHire"','25','(''UA''=''F'')','EDRBMUSEXPZ0','8','D','10','25',NULL,'Date of Hire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLocationNumber"','26','(''UA''=''F'')','EDRBMUSEXPZ0','7','D','10','26',NULL,'Location Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLocationDate"','27','(''UA''=''F'')','EDRBMUSEXPZ0','8','D','10','27',NULL,'Location Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReportedSalary"','28','(''UA''=''F'')','EDRBMUSEXPZ0','11','D','10','28',NULL,'Reported Salary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryMode"','29','(''UA''=''F'')','EDRBMUSEXPZ0','1','D','10','29',NULL,'Salary Mode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryEffectiveDate"','30','(''UA''=''F'')','EDRBMUSEXPZ0','8','D','10','30',NULL,'Salary Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWeeklyHours"','31','(''UA''=''F'')','EDRBMUSEXPZ0','5','D','10','31',NULL,'Weekly Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProductId"','32','(''UA''=''F'')','EDRBMUSEXPZ0','7','D','10','32',NULL,'Product Id',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationDate"','33','(''UA''=''F'')','EDRBMUSEXPZ0','8','D','10','33',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationReasonCode"','34','(''UA''=''F'')','EDRBMUSEXPZ0','2','D','10','34',NULL,'Termination Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageOption"','35','(''UA''=''F'')','EDRBMUSEXPZ0','1','D','10','35',NULL,'Coverage Option',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCode"','36','(''UA''=''F'')','EDRBMUSEXPZ0','7','D','10','36',NULL,'Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUnits"','37','(''UA''=''F'')','EDRBMUSEXPZ0','9','D','10','37',NULL,'Units',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProductSetId"','38','(''UA''=''F'')','EDRBMUSEXPZ0','5','D','10','38',NULL,'Product Set Id',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUnderwritingStatsInd"','39','(''UA''=''F'')','EDRBMUSEXPZ0','1','D','10','39',NULL,'Underwriting Status Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvApplicationReceivedDate"','40','(''UA''=''F'')','EDRBMUSEXPZ0','8','D','10','40',NULL,'Application Received Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCertificateNumber"','41','(''UA''=''F'')','EDRBMUSEXPZ0','10','D','10','41',NULL,'Certificate Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDependentSequence"','42','(''UA''=''F'')','EDRBMUSEXPZ0','2','D','10','42',NULL,'Dependent Sequence',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvForeignAddressIndicator"','43','(''UA''=''F'')','EDRBMUSEXPZ0','1','D','10','43',NULL,'Foreign Address Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFiller4"','44','(''UA''=''F'')','EDRBMUSEXPZ0','616','D','10','44',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDelimitingCharacter"','45','(''UA''=''F'')','EDRBMUSEXPZ0','1','D','10','45',NULL,'Delimiting Character',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEndofLineCharacter"','46','(''UA''=''F'')','EDRBMUSEXPZ0','1','D','10','46',NULL,'End of Line Character',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EDRBMUSEXP_20210721.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202105219','EMPEXPORT','OEACTIVE',NULL,'EDRBMUSEXP',NULL,NULL,NULL,'202105219','Apr  9 2021 12:30PM','Apr  9 2021 12:30PM','202104021',NULL,'','','202104021',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202105219','EMPEXPORT','OEPASSIVE',NULL,'EDRBMUSEXP',NULL,NULL,NULL,'202105219','Apr  9 2021 12:30PM','Apr  9 2021 12:30PM','202104021',NULL,'','','202104021',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dearborn File Export','202105219','EMPEXPORT','ONDEM_XOE',NULL,'EDRBMUSEXP',NULL,NULL,NULL,'202105219','Apr  9 2021 12:30PM','Apr  9 2021 12:30PM','202104021',NULL,'','','202104021',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dearborn File Export-Sched','202105219','EMPEXPORT','SCH_EDRBMU',NULL,'EDRBMUSEXP',NULL,NULL,NULL,'202105219','Apr  9 2021 12:30PM','Apr  9 2021 12:30PM','202104021',NULL,'','','202104021',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Dearborn File Export-Test','202107171','EMPEXPORT','TEST_XOE','Jul 16 2021  7:00PM','EDRBMUSEXP',NULL,NULL,NULL,'202107171','Jul 17 2021 12:00AM','Dec 30 1899 12:00AM','202107161','1159','','','202107161',dbo.fn_GetTimedKey(),NULL,'us3cPeMUS1005',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDRBMUSEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDRBMUSEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDRBMUSEXP','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDRBMUSEXP','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDRBMUSEXP','SubSort2','C','drvSubSort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDRBMUSEXP','SubSort3','C','drvSubSort3');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDRBMUSEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDRBMUSEXP','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EDRBMUSEXP' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EDRBMUSEXP' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EDRBMUSEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EDRBMUSEXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDRBMUSEXP','D10','dbo.U_EDRBMUSEXP_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_EDRBMUSEXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EDRBMUSEXP] (
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
IF OBJECT_ID('U_EDRBMUSEXP_Audit') IS NULL
CREATE TABLE [dbo].[U_EDRBMUSEXP_Audit] (
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
IF OBJECT_ID('U_EDRBMUSEXP_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EDRBMUSEXP_AuditFields] (
    [aTableName] varchar(128) NULL,
    [aFieldName] varchar(128) NULL
);
IF OBJECT_ID('U_EDRBMUSEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EDRBMUSEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EDRBMUSEXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EDRBMUSEXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] char(100) NULL,
    [drvSubSort2] varchar(13) NOT NULL,
    [drvSubSort3] varchar(1) NOT NULL,
    [drvRecordType] varchar(2) NULL,
    [drvGroupNumber] varchar(7) NULL,
    [drvEmployeeSSN] varchar(11) NULL,
    [drvNewParticipantId] char(9) NULL,
    [drvAccountNumber] varchar(5) NULL,
    [drvDependentSSN] char(9) NULL,
    [drvMemberEffectiveDate] varchar(30) NULL,
    [drvIDNumber] varchar(1) NOT NULL,
    [drvLastName] varchar(100) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleInitial] varchar(1) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvFiller1] varchar(1) NOT NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvFiller2] varchar(1) NOT NULL,
    [drvAddressLine3] varchar(1) NOT NULL,
    [drvCity] varchar(255) NULL,
    [drvFiller3] varchar(1) NOT NULL,
    [drvState] varchar(255) NULL,
    [drvZipCode] varchar(50) NULL,
    [drvRelationshipCode] varchar(1) NOT NULL,
    [drvGender] varchar(1) NULL,
    [drvDateofBirth] varchar(30) NULL,
    [drvSmokerIndicator] varchar(1) NULL,
    [drvDateofHire] varchar(30) NULL,
    [drvLocationNumber] varchar(7) NULL,
    [drvLocationDate] varchar(30) NULL,
    [drvReportedSalary] varchar(30) NULL,
    [drvSalaryMode] varchar(1) NULL,
    [drvSalaryEffectiveDate] varchar(30) NULL,
    [drvWeeklyHours] char(5) NULL,
    [drvProductId] varchar(7) NULL,
    [drvTerminationDate] varchar(30) NULL,
    [drvTerminationReasonCode] varchar(2) NULL,
    [drvCoverageOption] varchar(1) NOT NULL,
    [drvPlanCode] varchar(7) NULL,
    [drvUnits] varchar(9) NOT NULL,
    [drvProductSetId] varchar(5) NULL,
    [drvUnderwritingStatsInd] varchar(1) NULL,
    [drvApplicationReceivedDate] varchar(8) NOT NULL,
    [drvCertificateNumber] varchar(10) NOT NULL,
    [drvDependentSequence] char(2) NULL,
    [drvForeignAddressIndicator] varchar(1) NOT NULL,
    [drvFiller4] varchar(1) NOT NULL,
    [drvDelimitingCharacter] varchar(1) NOT NULL,
    [drvEndofLineCharacter] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EDRBMUSEXP_drvTbl_') IS NULL
CREATE TABLE [dbo].[U_EDRBMUSEXP_drvTbl_] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] char(100) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(1) NOT NULL,
    [drvRecordType] varchar(2) NULL,
    [drvGroupNumber] varchar(7) NULL,
    [drvEmployeeSSN] char(11) NULL,
    [drvNewParticipantId] char(9) NULL,
    [drvAccountNumber] varchar(5) NOT NULL,
    [drvDependentSSN] varchar(9) NULL,
    [drvMemberEffectiveDate] varchar(30) NULL,
    [drvIDNumber] varchar(1) NOT NULL,
    [drvLastName] varchar(100) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleInitial] varchar(1) NULL,
    [drvAddressLine1] varchar(1) NOT NULL,
    [drvFiller1] varchar(1) NOT NULL,
    [drvAddressLine2] varchar(1) NOT NULL,
    [drvFiller2] varchar(1) NOT NULL,
    [drvAddressLine3] varchar(1) NOT NULL,
    [drvCity] varchar(1) NOT NULL,
    [drvFiller3] varchar(1) NOT NULL,
    [drvState] varchar(1) NOT NULL,
    [drvZipCode] varchar(1) NOT NULL,
    [drvRelationshipCode] varchar(1) NOT NULL,
    [drvGender] varchar(1) NULL,
    [drvDateofBirth] varchar(8000) NULL,
    [drvSmokerIndicator] varchar(1) NULL,
    [drvDateofHire] char(8) NULL,
    [drvLocationNumber] char(7) NULL,
    [drvLocationDate] char(8) NULL,
    [drvReportedSalary] varchar(11) NOT NULL,
    [drvSalaryMode] varchar(1) NOT NULL,
    [drvSalaryEffectiveDate] char(8) NULL,
    [drvWeeklyHours] char(5) NULL,
    [drvProductId] varchar(7) NULL,
    [drvTerminationDate] varchar(8000) NULL,
    [drvTerminationReasonCode] varchar(2) NOT NULL,
    [drvCoverageOption] varchar(1) NOT NULL,
    [drvPlanCode] varchar(1) NOT NULL,
    [drvUnits] varchar(9) NOT NULL,
    [drvProductSetId] varchar(1) NOT NULL,
    [drvUnderwritingStatsInd] varchar(1) NOT NULL,
    [drvApplicationReceivedDate] char(8) NULL,
    [drvCertificateNumber] char(10) NULL,
    [drvDependentSequence] char(2) NULL,
    [drvForeignAddressIndicator] varchar(1) NOT NULL,
    [drvFiller4] varchar(1) NOT NULL,
    [drvDelimitingCharacter] varchar(1) NOT NULL,
    [drvEndofLineCharacter] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EDRBMUSEXP_drvTbl_TEMP') IS NULL
CREATE TABLE [dbo].[U_EDRBMUSEXP_drvTbl_TEMP] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] char(100) NULL,
    [drvSubSort2] varchar(13) NOT NULL,
    [drvSubSort3] varchar(1) NOT NULL,
    [drvRecordType] varchar(2) NULL,
    [drvGroupNumber] varchar(7) NULL,
    [drvEmployeeSSN] varchar(11) NULL,
    [drvNewParticipantId] char(9) NULL,
    [drvAccountNumber] varchar(5) NULL,
    [drvDependentSSN] char(9) NULL,
    [drvMemberEffectiveDate] varchar(30) NULL,
    [drvIDNumber] varchar(1) NOT NULL,
    [drvLastName] varchar(100) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleInitial] varchar(1) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvFiller1] varchar(1) NOT NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvFiller2] varchar(1) NOT NULL,
    [drvAddressLine3] varchar(1) NOT NULL,
    [drvCity] varchar(255) NULL,
    [drvFiller3] varchar(1) NOT NULL,
    [drvState] varchar(255) NULL,
    [drvZipCode] varchar(50) NULL,
    [drvRelationshipCode] varchar(1) NOT NULL,
    [drvGender] varchar(1) NULL,
    [drvDateofBirth] varchar(30) NULL,
    [drvSmokerIndicator] varchar(1) NULL,
    [drvDateofHire] varchar(30) NULL,
    [drvLocationNumber] varchar(7) NULL,
    [drvLocationDate] varchar(30) NULL,
    [drvReportedSalary] varchar(30) NULL,
    [drvSalaryMode] varchar(1) NULL,
    [drvSalaryEffectiveDate] varchar(30) NULL,
    [drvWeeklyHours] char(5) NULL,
    [drvProductId] varchar(7) NULL,
    [drvTerminationDate] varchar(30) NULL,
    [drvTerminationReasonCode] varchar(2) NULL,
    [drvCoverageOption] varchar(1) NOT NULL,
    [drvPlanCode] varchar(7) NULL,
    [drvUnits] varchar(9) NOT NULL,
    [drvProductSetId] varchar(5) NULL,
    [drvUnderwritingStatsInd] varchar(1) NULL,
    [drvApplicationReceivedDate] varchar(8) NOT NULL,
    [drvCertificateNumber] varchar(10) NOT NULL,
    [drvDependentSequence] char(2) NULL,
    [drvForeignAddressIndicator] varchar(1) NOT NULL,
    [drvFiller4] varchar(1) NOT NULL,
    [drvDelimitingCharacter] varchar(1) NOT NULL,
    [drvEndofLineCharacter] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EDRBMUSEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EDRBMUSEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EDRBMUSEXP_File') IS NULL
CREATE TABLE [dbo].[U_EDRBMUSEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(max) NULL
);
IF OBJECT_ID('U_EDRBMUSEXP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EDRBMUSEXP_PDedHist] (
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
IF OBJECT_ID('U_EDRBMUSEXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EDRBMUSEXP_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EDRBMUSEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Mustang Extreme Environmental Services, LLC

Created By: Marco Lagrosa
Business Analyst: Cheryl Petitti
Create Date: 04/09/2021
Service Request Number: TekP-2021-02-17-0003

Purpose: Dearborn File Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EDRBMUSEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EDRBMUSEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EDRBMUSEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EDRBMUSEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EDRBMUSEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDRBMUSEXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDRBMUSEXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDRBMUSEXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDRBMUSEXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDRBMUSEXP', 'SCH_EDRBMU';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EDRBMUSEXP';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EDRBMUSEXP', @AllObjects = 'Y', @IsWeb = 'Y'
**********************************************************************************/
BEGIN

    --==========================================
    -- Declare variables
    --==========================================
    DECLARE  @FormatCode        VARCHAR(10)
            ,@ExportCode        VARCHAR(10)
            ,@StartDate         DATETIME
            ,@EndDate           DATETIME
            ,@FileMinCovDate    DATETIME
            ,@StartPerControl   VARCHAR(9)
            ,@EndPerControl     VARCHAR(9);

    -- Set FormatCode
    SELECT @FormatCode = 'EDRBMUSEXP';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@FileMinCovDate = CAST('01/01/2021' as datetime)
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EDRBMUSEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EDRBMUSEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'GACC, GLIFE, GTLII, LIFEE, LIFEC, LIFES, CRILE, CRILC, CRILS, VIS';

    IF OBJECT_ID('U_EDRBMUSEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EDRBMUSEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EDRBMUSEXP_DedList
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
    -- Non-required parms 
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'IncludeOEDrops','Y'); 
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'OERemoveTermEmps','N'); 
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'GetChangeReason','Y'); 
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS'); 
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL,STC'); 
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP'); 
 

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
    EXEC dbo.dsi_bdm_sp_CalculateBenefitAmounts @FormatCode


    --=========================================
    -- Update BdmChangeReason For Dependents
    --=========================================
    UPDATE D
        SET D.BdmChangeReason = E.BdmChangeReason
    FROM dbo.U_dsi_bdm_EDRBMUSEXP D
    JOIN dbo.U_dsi_bdm_EDRBMUSEXP E
        ON E.BdmEEID = D.BdmEEID
        AND E.BdmCOID = D.BdmCOID
        AND E.BdmDedCode = D.BdmDedCode
    WHERE D.BdmRecType = 'DEP' AND E.BdmRecType = 'EMP';


    --=====================================================
    -- Update BdmUSGField2 with EmpDedTVID for Employees
    --=====================================================
    UPDATE dbo.U_dsi_bdm_EDRBMUSEXP
        SET /*BdmUSGField2*/ BdmEEAmt = DedEEBenAmt -- EedEmpDedTVID
    FROM dbo.U_dsi_bdm_EDRBMUSEXP
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = BdmEEID
        AND EedCOID = BdmCOID
        AND EedDedCode = BdmDedCode
    WHERE --BdmRecType = 'EMP' AND 
        EedFormatCode = @FormatCode AND EedValidForExport = 'Y';
/*
    --=======================================================
    -- Update BdmUSGField2 with DepBPlanTVID for Dependents
    --=======================================================
    UPDATE dbo.U_dsi_bdm_EDRBMUSEXP
        SET BdmUSGField2 = DedEEBenAmt DbnDepBPlanTVID
    FROM dbo.U_dsi_bdm_EDRBMUSEXP
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
        ON DbnEEID = BdmEEID
        AND DbnCOID = BdmCOID
        AND DbnDedCode = BdmDedCode
    WHERE BdmRecType = 'DEP' AND DbnFormatCode = @FormatCode AND DbnValidForExport = 'Y';
*/
    --======================================================
    -- Update BdmUSGField1 with Benefit Amount (EedBenAmt)
    --======================================================
    UPDATE dbo.U_dsi_bdm_EDRBMUSEXP
        SET BdmUSGField1 = CONVERT(VARCHAR(20),EedBenAmt)
    FROM dbo.U_dsi_bdm_EDRBMUSEXP
    JOIN dbo.EmpDedFull WITH (NOLOCK)
        ON EedEEID = BdmEEID
       AND EedCOID = BdmCOID
       AND EedDedCode = BdmDedCode;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EDRBMUSEXP_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EDRBMUSEXP_PDedHist;
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
    INTO dbo.U_EDRBMUSEXP_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EDRBMUSEXP_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EDRBMUSEXP_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EDRBMUSEXP_PEarHist;
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
    INTO dbo.U_EDRBMUSEXP_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;


    
    --Audit Table
    IF OBJECT_ID('U_EDRBMUSEXP_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EDRBMUSEXP_AuditFields;
    CREATE TABLE dbo.U_EDRBMUSEXP_AuditFields (aTableName varchar(128),aFieldName varchar(128));
    
    -- Insert tables/fields to be audited
    INSERT INTO dbo.U_EDRBMUSEXP_AuditFields VALUES ('EmpComp','EecOrgLvl1');    
    
    -- Create audit table
    IF OBJECT_ID('U_EDRBMUSEXP_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EDRBMUSEXP_Audit;
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
    INTO dbo.U_EDRBMUSEXP_Audit
    FROM (SELECT *
          FROM dbo.AuditRecords WITH (NOLOCK)
          WHERE adrTableName IN (SELECT aTableName FROM dbo.U_EDRBMUSEXP_AuditFields WITH (NOLOCK))) ADR
    JOIN (SELECT *
          FROM dbo.AuditFields WITH (NOLOCK)
          WHERE adfFieldName IN (SELECT aFieldName FROM dbo.U_EDRBMUSEXP_AuditFields WITH (NOLOCK))) ADF
        ON adrSystemID = adfSystemID
       AND adrKey = adfKey
    WHERE adrType IN (1,2,5,6) -- Insert/Update; remove this to include Deletes and Viewed
      AND adrProcessedDateTime BETWEEN @StartDate  AND @EndDate;
    
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EDRBMUSEXP_Audit ON dbo.U_EDRBMUSEXP_Audit (audKey1Value, audKey2Value);

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EDRBMUSEXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EDRBMUSEXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EDRBMUSEXP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),bdmdeprecid) --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepSSN
        ,drvSubSort = CONVERT(CHAR(100),  CONVERT(CHAR(9),RTRIM(EepSSN)) + CONVERT(CHAR(12),ISNULL(ConSystemID,''))  + CASE WHEN bdmrectype = 'EMP' and bdmdedcode in ('GACC', 'GLIFE', 'GTLII', 'LIFEE', 'LIFEC', 'CRILE', 'CRILC', 'VIS') THEN '1'
                              WHEN bdmrectype = 'DEP' and bdmrelationship = 'SPS' and bdmdedcode in ('LIFES','CRILS') THEN '2'
                         END  ) 
        ,drvSubSort2 = '             ' --BdmDedCode
        ,drvSubSort3 = ''
        -- standard fields above and additional driver fields below
        ,drvRecordType = CASE WHEN bdmrectype = 'EMP' and bdmdedcode in ('GACC', 'GLIFE', 'GTLII', 'LIFEE', 'LIFEC', 'CRILE', 'CRILC', 'VIS') THEN '01'
                              WHEN bdmrectype = 'DEP' and bdmrelationship = 'SPS' and bdmdedcode in ('LIFES','CRILS') THEN '01'
                         END
        ,drvGroupNumber = CASE WHEN bdmrectype = 'EMP' and bdmdedcode in ('GACC', 'GLIFE', 'GTLII', 'LIFEE', 'LIFEC', 'CRILE', 'CRILC', 'VIS') THEN 'F026358'
                              WHEN bdmrectype = 'DEP' and bdmrelationship = 'SPS' and bdmdedcode in ('LIFES','CRILS') THEN 'F026358'
                         END
        ,drvEmployeeSSN = CASE WHEN bdmrectype = 'EMP' and bdmdedcode in ('GACC', 'GLIFE', 'GTLII', 'LIFEE', 'LIFEC', 'CRILE', 'CRILC', 'VIS') THEN eepSSN
                              WHEN bdmrectype = 'DEP' and bdmrelationship = 'SPS' and bdmdedcode in ('LIFES','CRILS') THEN '0000' + RIGHT(RTRIM(EepSSN), 5) -- Conssn
                         END 
        ,drvNewParticipantId = CONVERT(CHAR(9),'000000000')
        ,drvAccountNumber = CASE WHEN bdmrectype = 'EMP' and bdmdedcode in ('GACC', 'GLIFE', 'GTLII', 'LIFEE', 'LIFEC', 'CRILE', 'CRILC', 'VIS') THEN '00001'
                              WHEN bdmrectype = 'DEP' and bdmrelationship = 'SPS' and bdmdedcode in ('LIFES','CRILS') THEN '00001'
                         END
        ,drvDependentSSN = CONVERT(CHAR(9),'000000000')

        
        ,drvMemberEffectiveDate =   --replace(
                                    convert(varchar, 
                                                CASE WHEN bdmrectype = 'EMP' and bdmdedcode in ('GLIFE', 'GTLII' ) THEN dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate)
                                                    WHEN bdmrectype = 'DEP' and bdmrelationship = 'SPS' and bdmdedcode in ('LIFES','CRILS') THEN dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate)
                                                END, 112) --,'-','')
        ,drvIDNumber = ''
        ,drvLastName = CASE WHEN bdmrectype = 'EMP' and bdmdedcode in ('GACC', 'GLIFE', 'GTLII', 'LIFEE', 'LIFEC', 'CRILE', 'CRILC', 'VIS') THEN EepNameLast
                              WHEN bdmrectype = 'DEP' and bdmrelationship = 'SPS' and bdmdedcode in ('LIFES','CRILS') THEN ConNameLast
                         END 
        ,drvFirstName =  CASE WHEN bdmrectype = 'EMP' and bdmdedcode in ('GACC', 'GLIFE', 'GTLII', 'LIFEE', 'LIFEC', 'CRILE', 'CRILC', 'VIS') THEN EepNameFirst
                              WHEN bdmrectype = 'DEP' and bdmrelationship = 'SPS' and bdmdedcode in ('LIFES','CRILS') THEN ConNameFirst
                         END 
        ,drvMiddleInitial = CASE WHEN bdmrectype = 'EMP' and bdmdedcode in ('GACC', 'GLIFE', 'GTLII', 'LIFEE', 'LIFEC', 'CRILE', 'CRILC', 'VIS') THEN LEFT(Isnull(EepNameMiddle,''),1)
                              WHEN bdmrectype = 'DEP' and bdmrelationship = 'SPS' and bdmdedcode in ('LIFES','CRILS') THEN LEFT(Isnull(ConNameMiddle,''),1)
                         END   
        ,drvAddressLine1 = CASE WHEN bdmrectype = 'EMP' and bdmdedcode in ('GACC', 'GLIFE', 'GTLII', 'LIFEE', 'LIFEC', 'CRILE', 'CRILC', 'VIS') THEN EepAddressLine1
                              WHEN bdmrectype = 'DEP' and bdmrelationship = 'SPS' and bdmdedcode in ('LIFES','CRILS') THEN ConAddressLine1
                         END  
        ,drvFiller1 = ''
        ,drvAddressLine2 =  CASE WHEN bdmrectype = 'EMP' and bdmdedcode in ('GACC', 'GLIFE', 'GTLII', 'LIFEE', 'LIFEC', 'CRILE', 'CRILC', 'VIS') THEN EepAddressLine2
                              WHEN bdmrectype = 'DEP' and bdmrelationship = 'SPS' and bdmdedcode in ('LIFES','CRILS') THEN ConAddressLine2
                         END  
        ,drvFiller2 = ''
        ,drvAddressLine3 = ''
        ,drvCity = CASE WHEN bdmrectype = 'EMP' and bdmdedcode in ('GACC', 'GLIFE', 'GTLII', 'LIFEE', 'LIFEC', 'CRILE', 'CRILC', 'VIS') THEN EepAddressCity
                              WHEN bdmrectype = 'DEP' and bdmrelationship = 'SPS' and bdmdedcode in ('LIFES','CRILS') THEN ConAddressCity
                         END   
        ,drvFiller3 = ''
        ,drvState = CASE WHEN bdmrectype = 'EMP' and bdmdedcode in ('GACC', 'GLIFE', 'GTLII', 'LIFEE', 'LIFEC', 'CRILE', 'CRILC', 'VIS') THEN EepAddressState
                              WHEN bdmrectype = 'DEP' and bdmrelationship = 'SPS' and bdmdedcode in ('LIFES','CRILS') THEN ConAddressState
                         END  
        ,drvZipCode = CASE WHEN bdmrectype = 'EMP' and bdmdedcode in ('GACC', 'GLIFE', 'GTLII', 'LIFEE', 'LIFEC', 'CRILE', 'CRILC', 'VIS') THEN EepAddressZipCode
                              WHEN bdmrectype = 'DEP' and bdmrelationship = 'SPS' and bdmdedcode in ('LIFES','CRILS') THEN ConAddressZipCode
                         END 
        ,drvRelationshipCode = ''
        ,drvGender = CASE WHEN bdmrectype = 'EMP' and bdmdedcode in ('GACC', 'GLIFE', 'GTLII', 'LIFEE', 'LIFEC', 'CRILE', 'CRILC', 'VIS') THEN 
                                    CASE WHEN EepGender = 'M' THEN 'M'
                                         WHEN EepGender = 'F' THEN 'F'
                                    END
                              WHEN bdmrectype = 'DEP' and bdmrelationship = 'SPS' and bdmdedcode in ('LIFES','CRILS') THEN 
                                CASE WHEN ConGender = 'M' THEN 'M'
                                         WHEN ConGender = 'F' THEN 'F'
                                    END
                         END 
        ,drvDateofBirth = --replace(
                            convert(varchar, CASE WHEN bdmrectype = 'EMP' and bdmdedcode in ('GACC', 'GLIFE', 'GTLII', 'LIFEE', 'LIFEC', 'CRILE', 'CRILC', 'VIS') THEN EepDateOfBirth
                              WHEN bdmrectype = 'DEP' and bdmrelationship = 'SPS' and bdmdedcode in ('LIFES','CRILS') THEN ConDateOfBirth
                         END , 112) --,'-','')
        ,drvSmokerIndicator = CASE WHEN bdmrectype = 'EMP' and bdmdedcode in ('GACC', 'GLIFE', 'GTLII', 'LIFEE', 'LIFEC', 'CRILE', 'CRILC', 'VIS') THEN 
                                    CASE WHEN EepIsSmoker  = 'N' THEN 'N'
                                    END
                              WHEN bdmrectype = 'DEP' and bdmrelationship = 'SPS' and bdmdedcode in ('LIFES','CRILS') THEN 
                                CASE WHEN ConIsSmoker  = 'N' THEN 'N'
                                    END
                         END 
        ,drvDateofHire = --replace(
                            convert(varchar, CASE WHEN bdmrectype = 'EMP' and bdmdedcode in ('GACC', 'GLIFE', 'GTLII', 'LIFEE', 'LIFEC', 'CRILE', 'CRILC', 'VIS') THEN dbo.dsi_fnGetMinMaxDates('MAX',EecDateOfLastHire , @FileMinCovDate)
                              WHEN bdmrectype = 'DEP' and bdmrelationship = 'SPS' and bdmdedcode in ('LIFES','CRILS') THEN dbo.dsi_fnGetMinMaxDates('MAX',EecDateOfLastHire , @FileMinCovDate)
                         END, 112) -- ,'-','')
        ,drvLocationNumber = CASE WHEN bdmrectype = 'EMP' and bdmdedcode in ('GACC', 'GLIFE', 'GTLII', 'LIFEE', 'LIFEC', 'CRILE', 'CRILC', 'VIS') THEN 

                                CASE WHEN  EecOrgLvl1 = 'NEOK' THEN '0000001'
                                     WHEN EecOrgLvl1 = 'NEWV' THEN '0000002'
                                     WHEN EecOrgLvl1 = 'OHCORP' THEN '0000003'
                                     WHEN EecOrgLvl1 = 'SWCAOR' THEN '0000004'
                                     WHEN EecOrgLvl1 = 'SWSTX' THEN '0000005'
                                     WHEN EecOrgLvl1 = 'SWWAR' THEN '0000006'
                                     WHEN EecOrgLvl1 = 'SWWTX' THEN '0000007'
                                Else '0000000' END


                              WHEN bdmrectype = 'DEP' and bdmrelationship = 'SPS' and bdmdedcode in ('LIFES','CRILS') THEN 

                              CASE WHEN  EecOrgLvl1 = 'NEOK' THEN '0000001'
                                     WHEN EecOrgLvl1 = 'NEWV' THEN '0000002'
                                     WHEN EecOrgLvl1 = 'OHCORP' THEN '0000003'
                                     WHEN EecOrgLvl1 = 'SWCAOR' THEN '0000004'
                                     WHEN EecOrgLvl1 = 'SWSTX' THEN '0000005'
                                     WHEN EecOrgLvl1 = 'SWWAR' THEN '0000006'
                                     WHEN EecOrgLvl1 = 'SWWTX' THEN '0000007'
                                Else '0000000' END

                         END

                         ---If those deduction code and there are changes on the orglevel1 send the changedate
                         -- otherwise send the drvMemberEffectiveDate

        ,drvLocationDate = --replace(
            convert(varchar, 
            ( CASE WHEN bdmrectype = 'EMP' THEN
                    CASE WHEN bdmdedcode in ('GACC', 'GLIFE', 'GTLII', 'LIFEE', 'LIFEC', 'CRILE', 'CRILC', 'VIS') 
                          AND EXISTS (SELECT 1 
                                          FROM dbo.U_EDRBMUSEXP_Audit 
                                        WHERE audOldValue <> audNewValue 
                                           AND audOldValue is not null 
                                          AND audKey1Value = xeeid 
                                          AND audkey2Value = xcoid) 
                         THEN dbo.dsi_fnGetMinMaxDates('MAX', (Select top 1 audDateTime 
                                                                     from dbo.U_EDRBMUSEXP_Audit 
                                                                    where audOldValue <> audNewValue 
                                                                      and audOldValue is not null 
                                                                      and audKey1Value = xeeid 
                                                                      and audkey2Value = xcoid) , @FileMinCovDate)
                         ELSE
                            dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate)
                          END
                  WHEN bdmrectype = 'DEP' and bdmrelationship = 'SPS' THEN
                   CASE WHEN bdmdedcode in ('LIFES','CRILS') 
                         and exists (Select MAX(audDateTime) 
                                       from dbo.U_EDRBMUSEXP_Audit 
                                      where audOldValue <> audNewValue 
                                        and audOldValue is not null 
                                        and audKey1Value = xeeid 
                                        and audkey2Value = xcoid) 
                        THEN dbo.dsi_fnGetMinMaxDates('MAX', (Select top 1 audDateTime 
                                                                from dbo.U_EDRBMUSEXP_Audit 
                                                               where audOldValue <> audNewValue 
                                                                 and audOldValue is not null 
                                                                 and audKey1Value = xeeid 
                                                                 and audkey2Value = xcoid) , @FileMinCovDate)
                        ELSE
                            dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate)
                     END                  
                  END )
        , 112) --,'-','')

        ,drvReportedSalary = CASE WHEN bdmrectype = 'EMP' and bdmdedcode in ('GACC', 'GLIFE', 'GTLII', 'LIFEE', 'LIFEC', 'CRILE', 'CRILC', 'VIS') THEN CONVERT(VARCHAR,dbo.dsi_fnPadZero(EecAnnSalary*100,11,0))  
                              WHEN bdmrectype = 'DEP' and bdmrelationship = 'SPS' and bdmdedcode in ('LIFES','CRILS') THEN CONVERT(VARCHAR,dbo.dsi_fnPadZero(EecAnnSalary*100,11,0)) 
                         END
        ,drvSalaryMode = CASE WHEN bdmrectype = 'EMP' and bdmdedcode in ('GACC', 'GLIFE', 'GTLII', 'LIFEE', 'LIFEC', 'CRILE', 'CRILC', 'VIS') THEN 'A'  
                              WHEN bdmrectype = 'DEP' and bdmrelationship = 'SPS' and bdmdedcode in ('LIFES','CRILS') THEN 'A'
                         END

        ,drvSalaryEffectiveDate = --replace(
        convert(varchar, 
                        --DATEADD(DAY, 1, 
                        dbo.dsi_fnGetMinMaxDates('MAX', EOMONTH(
                                                    CASE WHEN bdmrectype = 'EMP' and bdmdedcode in ('GACC', 'GLIFE', 'GTLII', 'LIFEE', 'LIFEC', 'CRILE', 'CRILC', 'VIS') THEN   
                                --dbo.dsi_fnGetMinMaxDates('MAX', dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(EecEEID, EecCOID, GETdate(),EecDateOfLastHire)   , @FileMinCovDate)                           
                                                                --dbo.dsi_fnGetMinMaxDates('MAX', 
                                                                dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(EecEEID, EecCOID, GETdate(),EecDateOfLastHire)  
                                                                -- , @FileMinCovDate)                           

                                                        WHEN bdmrectype = 'DEP' and bdmrelationship = 'SPS' and bdmdedcode in ('LIFES','CRILS') THEN 
                                                                --dbo.dsi_fnGetMinMaxDates('MAX', 
                                                                dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(EecEEID, EecCOID, GETdate(),EecDateOfLastHire) 
                                                                --  , @FileMinCovDate)    
                                --dbo.dsi_fnGetMinMaxDates('MIN', dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(EecEEID, EecCOID, GETdate(),EecDateOfLastHire)   , @FileMinCovDate)    
                                
                                                    END), @FileMinCovDate)                           
                                                    --)
                         , 112) -- ,'-','')
        ,drvWeeklyHours = CONVERT(CHAR(5),'00000')
        ,drvProductId =  SPACE(7)
        ,drvTerminationDate = --replace(
        convert(varchar, 
                            CASE WHEN bdmrectype = 'EMP' and bdmdedcode in ('GACC', 'GLIFE', 'GTLII', 'LIFEE', 'LIFEC', 'CRILE', 'CRILC', 'VIS') THEN                                 
                                CASE WHEN eecEmplStatus = 'A' and bdmbenstatus = 'T' Then bdmbenstopdate 
                                    WHEN EecEmplStatus = 'T' THEN EecDateOfTermination    
                                    --ELSE '0000000'
                                END
                                WHEN bdmrectype = 'DEP' and bdmrelationship = 'SPS' and bdmdedcode in ('LIFES','CRILS') THEN 
                                    CASE WHEN eecEmplStatus = 'A' and bdmbenstatus = 'T' Then bdmbenstopdate 
                                    --ELSE '0000000'
                                    END
                                --ELSE '0000000'
                                END, 112) -- ,'-','')

        ,drvTerminationReasonCode =  CASE WHEN bdmrectype = 'EMP' and bdmdedcode in ('GACC', 'GLIFE', 'GTLII', 'LIFEE', 'LIFEC', 'CRILE', 'CRILC', 'VIS') THEN 
                                        CASE WHEN eecEmplStatus = 'T'  THEN '32'
                                             WHEN eecEmplStatus = 'T' and eecTermReason ='203'  THEN '22'
                                             WHEN eecEmplStatus = 'A' and bdmbenstatus = 'T' THEN '13'
                                             ELSE '00'
                                        END
                                    WHEN bdmrectype = 'DEP' and bdmrelationship = 'SPS' and bdmdedcode in ('LIFES','CRILS') THEN 
                                        CASE WHEN bdmbenstatus = 'T' Then '12' ELSE '00' end
                                    END
        ,drvCoverageOption = ''
        ,drvPlanCode = SPACE(7)
        ,drvUnits = '000000000' --  CONVERT(char(9),'00000000')
        ,drvProductSetId = SPACE(5)
        ,drvUnderwritingStatsInd = SPACE(1)
        ,drvApplicationReceivedDate = '00000000' --  CONVERT(char(8),'0000000')
        ,drvCertificateNumber = '0000000000' -- CONVERT(char(10),'000000000')
        ,drvDependentSequence = CONVERT(char(2),'00')
        ,drvForeignAddressIndicator = ''
        ,drvFiller4 = ''
        ,drvDelimitingCharacter = ''
        ,drvEndofLineCharacter = '*'
    INTO dbo.U_EDRBMUSEXP_drvTbl
    FROM dbo.U_EDRBMUSEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EDRBMUSEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoid = xCoID
    LEFT JOIN dbo.Contacts WITH (NOLOCK) 
        ON ConEEID = xEEID 
        AND ConSystemID = BdmDepRecID
        
    WHERE ( bdmdedcode in ('GACC', 'GLIFE', 'GTLII', 'LIFEE', 'LIFEC', 'CRILE', 'CRILC', 'VIS') and bdmrectype ='EMP') or (bdmdedcode in ('LIFES','CRILS') and bdmrelationship = 'SPS' )

    UPDATE dbo.U_EDRBMUSEXP_drvTbl
        SET drvTerminationDate = '00000000'
        WHERE ISNULL(drvTerminationDate, '') = '';
--CHECK TO MAKE SURE SALARY DATE IS NOT LESS THAN MEMBER EFFECTIVE DATE
    UPDATE dbo.U_EDRBMUSEXP_drvTbl
        SET drvSalaryEffectiveDate = drvMemberEffectiveDate
        WHERE drvSalaryEffectiveDate < drvMemberEffectiveDate;
    
    --CLEAR DUPLICATE RECORDS
    DELETE FROM dbo.U_EDRBMUSEXP_drvTbl WHERE drvMemberEffectiveDate IS NULL 
            AND drvEEID IN (SELECT drvEEID FROM (SELECT * FROM (SELECT drveeid, drvcoid, drvdeprecid, CNT=count(*) FROM U_EDRBMUSEXP_drvTbl GROUP BY drvEEID, drvCOID, drvDepRecID HAVING COUNT(*) > 1) TBL) TBL2)

    ---02 Record
 INSERT INTO dbo.U_EDRBMUSEXP_drvTbl
 SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),bdmdeprecid) --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepSSN
        ,drvSubSort = CONVERT(CHAR(100),  CONVERT(CHAR(9),RTRIM(EepSSN)) + CONVERT(CHAR(12),ISNULL('',''))   + '2' )
        ,drvSubSort2 = ''
        ,drvSubSort3 = ''
        -- standard fields above and additional driver fields below
        ,drvRecordType = CASE WHEN bdmdedcode in ('VIS') THEN '02' END 
        ,drvGroupNumber =CASE WHEN bdmdedcode in ('VIS') THEN 'F026358' END
        ,drvEmployeeSSN = CASE WHEN bdmdedcode in ('VIS') THEN Eepssn END 
                         
        ,drvNewParticipantId = CONVERT(CHAR(9),'000000000')
        ,drvAccountNumber = '00001'
        ,drvDependentSSN = '0000' + RIGHT(RTRIM(EepSSN), 5) -- Conssn conSSN

        
        ,drvMemberEffectiveDate =  CONVERT(VARCHAR, dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate), 112)
        ,drvIDNumber = ''
        ,drvLastName = CASE WHEN bdmdedcode in ('VIS') THEN ConNameLast END 
        ,drvFirstName =  CASE WHEN bdmdedcode in ('VIS') THEN ConNameFirst END 
        ,drvMiddleInitial =  CASE WHEN bdmdedcode in ('VIS') THEN LEFT(Isnull(ConNameMiddle,''),1) END   
        ,drvAddressLine1 = ''
        ,drvFiller1 = ''
        ,drvAddressLine2 =  ''
        ,drvFiller2 = ''
        ,drvAddressLine3 = ''
        ,drvCity = ''
        ,drvFiller3 = ''
        ,drvState = ''
        ,drvZipCode = ''
        ,drvRelationshipCode = CASE WHEN ConRelationship  in ('DP','SPS') THEN 'S' ELSE 'C' END
        ,drvGender = CASE WHEN bdmdedcode in ('VIS') THEN 
                            CASE WHEN ConGender = 'M' THEN 'M'
                                         WHEN ConGender = 'F' THEN 'F'
                        END 
                    END  
        ,drvDateofBirth =  replace(convert(varchar, CASE WHEN bdmdedcode in ('VIS') THEN ConDateOfBirth END , 112) ,'-','')
        ,drvSmokerIndicator = CASE WHEN bdmrectype = 'EMP' and bdmdedcode in ('GACC', 'GLIFE', 'GTLII', 'LIFEE', 'LIFEC', 'CRILE', 'CRILC', 'VIS') THEN 
                                    CASE WHEN EepIsSmoker  = 'N' THEN 'N'
                                    END
                              WHEN bdmrectype = 'DEP' and bdmrelationship = 'SPS' and bdmdedcode in ('LIFES','CRILS') THEN 
                                CASE WHEN ConIsSmoker  = 'N' THEN 'N'
                                    END
                         END 
        ,drvDateofHire = CONVERT(CHAR(8),'00000000')
        ,drvLocationNumber = CONVERT(CHAR(7),'0000000')
        ,drvLocationDate = CONVERT(CHAR(8),'00000000')

        ,drvReportedSalary = '00000000000' -- CONVERT(CHAR(11),'0000000000')
        ,drvSalaryMode = ''
        ,drvSalaryEffectiveDate =CONVERT(CHAR(8),'00000000')
        ,drvWeeklyHours = CONVERT(CHAR(5),'00000')
        ,drvProductId =  SPACE(7)
        ,drvTerminationDate =  replace( 
                                        CASE WHEN bdmdedcode in ('VIS') and bdmBenStatus ='T' THEN convert(varchar, BdmBenStopDate, 112)
                                        ELSE CONVERT(CHAR(8),'00000000') 
                                        END ,'-','')
        
                        

        ,drvTerminationReasonCode =  CASE WHEN bdmdedcode in ('VIS') and bdmBenStatus ='T' THEN '12'
                                          --WHEN bdmdedcode in ('VIS') and bdmBenStatus ='A' THEN '13'
                                          ELSE '00'
                             END 
        ,drvCoverageOption = ''
        ,drvPlanCode = ''
        ,drvUnits = '000000000' -- CONVERT(CHAR(9),'00000000')
        ,drvProductSetId = ''
        ,drvUnderwritingStatsInd = ''
        ,drvApplicationReceivedDate = CONVERT(CHAR(8),'00000000')
        ,drvCertificateNumber = CONVERT(CHAR(10),'0000000000')
        ,drvDependentSequence = CONVERT(CHAR(2),'00')
        ,drvForeignAddressIndicator = ''
        ,drvFiller4 = ''
        ,drvDelimitingCharacter = ''
        ,drvEndofLineCharacter = '*'
    FROM dbo.U_EDRBMUSEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EDRBMUSEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoid = xCoID
    LEFT JOIN dbo.Contacts WITH (NOLOCK) 
        ON ConEEID = xEEID 
        AND ConSystemID = BdmDepRecID
        -- select * from EmpDed where EedEEID ='CMK29G000020' and EedDedCode = 'VIS'
    JOIN dbo.EmpDed WITH (NOLOCK)
        ON EedEEID = xEEID
        AND EedCOID = xCOID
        AND EedDedCode = 'VIS'
    WHERE (bdmdedcode in ('VIS') and bdmrectype = 'DEP' )

    
    --05 Record
    INSERT INTO dbo.U_EDRBMUSEXP_drvTbl
     SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),bdmdeprecid) --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepSSN
        ,drvSubSort = CONVERT(CHAR(100), ( CONVERT(CHAR(9),RTRIM(EepSSN)) + CONVERT(CHAR(12),ISNULL(ConSystemID,'')) + CASE WHEN bdmrectype = 'EMP'  THEN 
                            CASE WHEN bdmdedcode in ('GACC') THEN '41'
                                 WHEN bdmdedcode in ('GLIFE','GTLII') THEN '42'
                                 WHEN bdmdedcode in ('LIFEE') THEN '43'
                                 WHEN bdmdedcode in ('LIFEC') THEN '44'
                                 WHEN bdmdedcode in ('CRILE') THEN '45'
                                 WHEN bdmdedcode in ('CRILC') THEN '46'
                                 WHEN bdmdedcode in ('VIS') THEN '47'
                            END
                              WHEN bdmrectype = 'DEP' and bdmrelationship = 'SPS' and bdmdedcode in ('LIFES') THEN '50'
                              WHEN bdmrectype = 'DEP' and bdmrelationship = 'SPS' and bdmdedcode in ('CRILS ') THEN '51'    
                         END )) 
        ,drvSubSort2 = BdmDedCode
        ,drvSubSort3 = ''
        -- standard fields above and additional driver fields below
        ,drvRecordType = '05' 
        ,drvGroupNumber = 'F026358'
        ,drvEmployeeSSN =  CASE WHEN bdmrectype = 'EMP' and bdmdedcode in ('GACC', 'GLIFE', 'GTLII', 'LIFEE', 'LIFEC', 'CRILE', 'CRILC', 'VIS') THEN eepSSN
                              WHEN bdmrectype = 'DEP' and bdmrelationship = 'SPS' and bdmdedcode in ('LIFES','CRILS') THEN '0000' + RIGHT(RTRIM(EepSSN), 5) -- ConssnConssn
                         END
                         
        ,drvNewParticipantId = '000000000' -- CONVERT(CHAR(9),'00000000')
        ,drvAccountNumber = '00001'
        ,drvDependentSSN = '000000000' -- CONVERT(CHAR(9),'00000000')
        ,drvMemberEffectiveDate =   replace(convert(varchar, CASE WHEN bdmrectype = 'EMP' and bdmdedcode in ('GACC', 'GLIFE', 'GTLII', 'LIFEE', 'LIFEC', 'CRILE', 'CRILC', 'VIS') THEN convert(varchar, dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate), 112) 
                              WHEN bdmrectype = 'DEP' and bdmrelationship = 'SPS' and bdmdedcode in ('LIFES','CRILS') THEN convert(varchar, dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate), 112) 
                         END, 110) ,'-','')
        ,drvIDNumber = ''
        ,drvLastName = ''
        ,drvFirstName =  ''
        ,drvMiddleInitial =  '' 
        ,drvAddressLine1 = ''
        ,drvFiller1 = ''
        ,drvAddressLine2 =  ''
        ,drvFiller2 = ''
        ,drvAddressLine3 = ''
        ,drvCity = ''
        ,drvFiller3 = ''
        ,drvState = ''
        ,drvZipCode = ''
        ,drvRelationshipCode = ''
        ,drvGender = ''
        ,drvDateofBirth = CONVERT(CHAR(8),'00000000')
        ,drvSmokerIndicator = ''
        ,drvDateofHire = CONVERT(CHAR(8),'00000000')
        ,drvLocationNumber = CONVERT(CHAR(7),'0000000')
        ,drvLocationDate = CONVERT(CHAR(8),'00000000')

        ,drvReportedSalary = '00000000000' -- CONVERT(CHAR(11),'0000000000')
        ,drvSalaryMode = ''
        ,drvSalaryEffectiveDate = CONVERT(CHAR(8),'00000000')
        ,drvWeeklyHours = CONVERT(CHAR(5),'00000')
        ,drvProductId = CASE WHEN bdmrectype = 'EMP'  THEN 
                            CASE WHEN bdmdedcode in ('GACC') THEN 'ACCIV'
                                 WHEN bdmdedcode in ('GLIFE','GTLII') THEN 'LIFE'
                                 WHEN bdmdedcode in ('LIFEE') THEN 'LIFSUP1'
                                 WHEN bdmdedcode in ('LIFEC') THEN 'DEPSUPC'
                                 WHEN bdmdedcode in ('CRILE') THEN 'CRITVE'
                                 WHEN bdmdedcode in ('CRILC') THEN 'CRITVC'
                                 WHEN bdmdedcode in ('VIS') THEN 'VISB'
                            END
                              WHEN bdmrectype = 'DEP' and bdmrelationship = 'SPS' and bdmdedcode in ('LIFES') THEN 'DEPSUPS'
                              WHEN bdmrectype = 'DEP' and bdmrelationship = 'SPS' and bdmdedcode in ('CRILS ') THEN 'CRITVS'    
                         END

        ,drvTerminationDate =  --replace(
                                 CASE WHEN bdmrectype = 'EMP' and bdmdedcode in ('GACC', 'GLIFE', 'GTLII', 'LIFEE', 'LIFEC', 'CRILE', 'CRILC', 'VIS') THEN 
                                        CASE WHEN eecEmplStatus = 'A' and bdmbenstatus = 'T' Then convert(varchar, bdmstopdate , 112)
                                             WHEN eecEmplStatus = 'T' THEN convert(varchar,eecdateoftermination, 112)
                                             ELSE '00000000'
                                        end
                        
                              WHEN bdmrectype = 'DEP' and bdmrelationship = 'SPS' and bdmdedcode in ('LIFES','CRILS') THEN 
                                        CASE WHEN eecEmplStatus = 'A' and bdmbenstatus = 'T' Then convert(varchar,bdmstopdate , 112)
                                             WHEN eecEmplStatus = 'T' THEN convert(varchar,eecdateoftermination, 112)
                                             ELSE '00000000'
                                        END
                                ELSE '00000000'
                                END --, 112) --,'-','')
                    
                        

        ,drvTerminationReasonCode =  CASE WHEN bdmrectype = 'EMP' and bdmdedcode in ('GACC', 'GLIFE', 'GTLII', 'LIFEE', 'LIFEC', 'CRILE', 'CRILC', 'VIS') THEN 
                                        CASE WHEN eecEmplStatus = 'T'  THEN '32'
                                             WHEN eecEmplStatus = 'T' and eecTermReason ='203'  THEN '22'
                                             WHEN eecEmplStatus = 'A' and bdmbenstatus = 'T' THEN '13'
                                             ELSE '00'
                                        END
                        
                              WHEN bdmrectype = 'DEP' and bdmrelationship = 'SPS' and bdmdedcode in ('LIFES','CRILS') THEN 
                                        CASE WHEN bdmbenstatus = 'T' Then '12' ELSE '00' end
                                END 
        ,drvCoverageOption = CASE WHEN bdmrectype = 'EMP' and bdmdedcode IN('GACC','VIS') THEN
                                    CASE WHEN Bdmbenoption  = 'EE' THEN 'E'
                                         WHEN Bdmbenoption  IN ('EES','EEDP') THEN 'S'
                                         WHEN Bdmbenoption  IN ('EEC ') THEN 'C'
                                         WHEN Bdmbenoption  IN ('EEF','EEDPF ') THEN 'F'
                                         WHEN Bdmbenoption  IN ('EES','EEDP') THEN 'S'
                                    END
                                ELSE ''
                            END
        ,drvPlanCode = CASE WHEN Bdmdedcode = 'GACC' THEN '0008201'
                            -- EecFullTimeOrPartTime,EecSalaryOrHourly
                            WHEN Bdmdedcode IN ('GLIFE', 'GTLII') and EecFullTimeOrPartTime  = 'F' and eecsalaryOrHourly = 'S'  THEN '0001001'
                            WHEN Bdmdedcode IN ('GLIFE', 'GTLII') and EecFullTimeOrPartTime  = 'F' and eecsalaryOrHourly = 'H'  THEN '0001002'
                            WHEN Bdmdedcode IN ('LIFEE') THEN '0001101'
                            WHEN Bdmdedcode IN ('LIFEC') THEN '0001301'
                            WHEN Bdmdedcode IN ('CRILE') THEN '0001501'
                            WHEN Bdmdedcode IN ('CRILC') THEN '0001503'
                            WHEN Bdmdedcode IN ('VIS') THEN '0009108'
                            WHEN Bdmdedcode IN ('LIFES') THEN '0001201'
                            WHEN Bdmdedcode IN ('CRILS') THEN '0001502'
                            ELSE ''
                        END

        ,drvUnits = CASE WHEN BdmRecType = 'EMP' THEN
                            CASE 
                            WHEN Bdmdedcode = 'GACC' THEN '000000100'
                            --WHEN Bdmdedcode IN ('GLIFE', 'GTLII')  THEN  CONVERT(VARCHAR,dbo.dsi_fnPadZero((BdmUsgField2 /1000)*100,9,0))  
                            WHEN Bdmdedcode IN ('GLIFE')  THEN  CONVERT(VARCHAR,dbo.dsi_fnPadZero((CASE WHEN BcaBenAmtCalc = 0.00 THEN CAST(BdmEEAmt AS MONEY) ELSE BcaBenAmtCalc END /1000)*100,9,0))  
                            WHEN Bdmdedcode IN ('GTLII') THEN CONVERT(VARCHAR,dbo.dsi_fnPadZero((CAST(CASE WHEN BdmUSGField1 = '0.00' THEN BdmEEAmt ELSE BdmUSGField1 END AS MONEY) /1000)*100,9,0))  
                            WHEN Bdmdedcode IN ('LIFEE') THEN CONVERT(VARCHAR,dbo.dsi_fnPadZero((CAST(CASE WHEN BdmUSGField1 = '0.00' THEN BdmEEAmt ELSE BdmUSGField1 END AS MONEY)  /1000)*100,9,0))  
                            WHEN Bdmdedcode IN ('LIFEC') THEN CONVERT(VARCHAR,dbo.dsi_fnPadZero((CAST(CASE WHEN BdmUSGField1 = '0.00' THEN BdmEEAmt ELSE BdmUSGField1 END AS MONEY)  /1000)*100,9,0))  
                            WHEN Bdmdedcode IN ('CRILE') THEN CONVERT(VARCHAR,dbo.dsi_fnPadZero((CAST(CASE WHEN BdmUSGField1 = '0.00' THEN BdmEEAmt ELSE BdmUSGField1 END AS MONEY)  /1000)*100,9,0))  
                            WHEN Bdmdedcode IN ('CRILC') THEN CONVERT(VARCHAR,dbo.dsi_fnPadZero((CAST(CASE WHEN BdmUSGField1 = '0.00' THEN BdmEEAmt ELSE BdmUSGField1 END AS MONEY)  /1000)*100,9,0))  
                            WHEN Bdmdedcode IN ('VIS') THEN '000000100'
                            ELSE ''
                            END
                        ELSE
                            CASE
                            WHEN Bdmdedcode IN ('LIFES') THEN CONVERT(VARCHAR,dbo.dsi_fnPadZero((CAST(BdmUSGField1 AS MONEY)  /1000)*100,9,0))  
                            WHEN Bdmdedcode IN ('CRILS') THEN CONVERT(VARCHAR,dbo.dsi_fnPadZero((CAST(BdmUSGField1 AS MONEY)  /1000)*100,9,0))  
                            ELSE ''
                            END
                        END
        ,drvProductSetId = CASE WHEN bdmrectype = 'EMP' and bdmdedcode in ('GACC', 'GLIFE', 'GTLII', 'LIFEE', 'LIFEC', 'CRILE', 'CRILC', 'VIS') THEN
                                CASE    WHEN EecFullTimeOrPartTime  = 'F' and eecsalaryOrHourly = 'S'  THEN '1'
                                        WHEN EecFullTimeOrPartTime  = 'F' and eecsalaryOrHourly = 'H'  THEN '2'
                                END
                                WHEN bdmrectype = 'DEP' and bdmrelationship = 'SPS' and bdmdedcode in ('LIFES','CRILS') THEN '3'
                            END
        ,drvUnderwritingStatsInd =    CASE WHEN BdmRecType = 'EMP' AND BdmDedCode IN ('LIFEE', 'LIFEC', 'CRILE', 'CRILC') THEN
                                        CASE WHEN EedEOIDesiredAmt <= BdmEEAmt OR EedEOIDesiredAmt IS NULL THEN '0' ELSE '2' END
                                    WHEN BdmRelationship IN ('SPS','DP') AND BdmDedCode IN ('CRILS', 'LIFES') THEN
                                        CASE WHEN EedEOIDesiredAmt <= BdmEEAmt OR EedEOIDesiredAmt IS NULL THEN '0' ELSE '2' END
                                    ELSE '0'
                                    END
        
                                    /*CASE WHEN bdmdedcode = 'LIFEE' THEN
                                         CASE WHEN BdmUsgField2 = 0 THEN '0' ELSE '2'  END
                                       WHEN bdmdedcode = 'LIFES' THEN
                                        CASE WHEN BdmUsgField2 = 0 THEN '0' ELSE '2'  END
                                        ELSE ''
                                   END*/
        ,drvApplicationReceivedDate = CONVERT(char(8),'00000000')
        ,drvCertificateNumber = CONVERT(char(10),'0000000000')
        ,drvDependentSequence = CONVERT(char(8),'00')
        ,drvForeignAddressIndicator = ''
        ,drvFiller4 = ''
        ,drvDelimitingCharacter = ''
        ,drvEndofLineCharacter = '*'
    FROM dbo.U_EDRBMUSEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EDRBMUSEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoid = xCoID
    LEFT JOIN dbo.Contacts WITH (NOLOCK) 
        ON ConEEID = xEEID 
        AND ConSystemID = BdmDepRecID
    JOIN dbo.EmpDed WITH (NOLOCK)
        ON EedEEID = xEEID
        AND EedCOID = xCOID
        AND EedDedCode = BdmDedCode
    JOIN dbo.u_dsi_Bdm_BenCalculationAmounts WITH (NOLOCK)
        ON BcaEEID = xEEID
        AND BcaCOID = xCOID
        AND BcaDedCode = BdmDedCode
        AND BcaFormatCode = 'EDRBMUSEXP'
    --select top 10 BcaBenAmtCalc, BcaDedCode, BcaCOID,* from dbo.u_dsi_Bdm_BenCalculationAmounts WHERE BcaFormatCode = 'EDRBMUSEXP' AND BcaEEID = 'CLNKCB000020'
    WHERE ( bdmdedcode in ('GACC', 'GLIFE', 'GTLII', 'LIFEE', 'LIFEC', 'CRILE', 'CRILC', 'VIS') and bdmrectype ='EMP') or (bdmdedcode in ('LIFES','CRILS') and bdmrelationship = 'SPS' )

    

    --05 for ADD
    INSERT INTO dbo.U_EDRBMUSEXP_drvTbl
         SELECT DISTINCT
         drvEEID 
        ,drvCoID 
        ,drvDepRecID 
        ,drvInitialSort 
        ,drvSubSort =   CONVERT(CHAR(100), ( CONVERT(CHAR(9),RTRIM(drvInitialSort)) + CONVERT(CHAR(12),ISNULL(drvDepRecID,'')) + CASE WHEN drvProductId = 'LIFE' THEN '61'
                             WHEN drvProductId = 'LIFSUP1' THEN '62'
                             WHEN drvProductId = 'DEPSUPC' THEN '63'
                              WHEN drvProductId = 'DEPSUPS' THEN '64'
                        END )) 
                        
        ,drvSubSort2 = ''
        ,drvSubSort3 = ''
        -- standard fields above and additional driver fields below
        ,drvRecordType = '05' 
        ,drvGroupNumber = 'F026358'
        ,drvEmployeeSSN
                
        ,drvNewParticipantId 
        ,drvAccountNumber 
        ,drvDependentSSN 
        ,drvMemberEffectiveDate
        ,drvIDNumber = ''
        ,drvLastName = ''
        ,drvFirstName =  ''
        ,drvMiddleInitial =  '' 
        ,drvAddressLine1 = ''
        ,drvFiller1 = ''
        ,drvAddressLine2 =  ''
        ,drvFiller2 = ''
        ,drvAddressLine3 = ''
        ,drvCity = ''
        ,drvFiller3 = ''
        ,drvState = ''
        ,drvZipCode = ''
        ,drvRelationshipCode = ''
        ,drvGender = ''

        ,drvDateofBirth = CONVERT(CHAR(8),'00000000')
        ,drvSmokerIndicator = ''
        ,drvDateofHire = CONVERT(CHAR(8),'00000000')
        ,drvLocationNumber = CONVERT(CHAR(7),'0000000')
        ,drvLocationDate = CONVERT(CHAR(8),'00000000')

        ,drvReportedSalary = '00000000000' -- CONVERT(CHAR(11),'0000000000')
        ,drvSalaryMode = ''
        ,drvSalaryEffectiveDate = CONVERT(CHAR(8),'00000000')
        ,drvWeeklyHours = CONVERT(CHAR(5),'00000')
        
        ,drvProductId = CASE WHEN drvProductId = 'LIFE' THEN 'ADD'
                             WHEN drvProductId = 'LIFSUP1' THEN 'ADDSUP1'
                             WHEN drvProductId = 'DEPSUPC' THEN 'ADDSUPC'
                              WHEN drvProductId = 'DEPSUPS' THEN 'ADDSUPS'
                        END
        ,drvTerminationDate
                    
                        

        ,drvTerminationReasonCode
        ,drvCoverageOption
        ,drvPlanCode = CASE WHEN drvProductId = 'LIFE' and EecFullTimeOrPartTime  = 'F' and eecsalaryOrHourly = 'S'  THEN '0002001'
                            WHEN drvProductId = 'LIFE' and EecFullTimeOrPartTime  = 'F' and eecsalaryOrHourly = 'H'  THEN '0002002'
                             WHEN drvProductId = 'LIFSUP1' THEN '0002101'
                             WHEN drvProductId = 'DEPSUPC' THEN '0002301'
                              WHEN drvProductId = 'DEPSUPS' THEN '0002201'
                        END

        ,drvUnits
        ,drvProductSetId 
        ,drvUnderwritingStatsInd 
        ,drvApplicationReceivedDate 
        ,drvCertificateNumber 
        ,drvDependentSequence 
        ,drvForeignAddressIndicator 
        ,drvFiller4 
        ,drvDelimitingCharacter
        ,drvEndofLineCharacter 
    FROM dbo.U_EDRBMUSEXP_drvTbl WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
      ON EecEEID = drvEEID
     AND EecCoID = drvCoID
    WHERE  drvProductId IN('LIFE' , 'LIFSUP1', 'DEPSUPC', 'DEPSUPS')
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
ALTER VIEW dbo.dsi_vwEDRBMUSEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EDRBMUSEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EDRBMUSEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202104021'
       ,expStartPerControl     = '202104021'
       ,expLastEndPerControl   = '202105219'
       ,expEndPerControl       = '202105219'
WHERE expFormatCode = 'EDRBMUSEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEDRBMUSEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EDRBMUSEXP_File (NOLOCK)
    ORDER BY  InitialSort, SubSort; 