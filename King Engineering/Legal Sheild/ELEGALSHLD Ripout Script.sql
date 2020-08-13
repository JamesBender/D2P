SET NOCOUNT ON;
IF OBJECT_ID('U_ELEGALSHLD_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ELEGALSHLD_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ELEGALSHLD_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ELEGALSHLD' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwELEGALSHLD_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwELEGALSHLD_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ELEGALSHLD') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ELEGALSHLD];
GO
IF OBJECT_ID('U_ELEGALSHLD_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ELEGALSHLD_PEarHist];
GO
IF OBJECT_ID('U_ELEGALSHLD_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ELEGALSHLD_PDedHist];
GO
IF OBJECT_ID('U_ELEGALSHLD_Header') IS NOT NULL DROP TABLE [dbo].[U_ELEGALSHLD_Header];
GO
IF OBJECT_ID('U_ELEGALSHLD_File') IS NOT NULL DROP TABLE [dbo].[U_ELEGALSHLD_File];
GO
IF OBJECT_ID('U_ELEGALSHLD_EEList') IS NOT NULL DROP TABLE [dbo].[U_ELEGALSHLD_EEList];
GO
IF OBJECT_ID('U_ELEGALSHLD_DedList') IS NOT NULL DROP TABLE [dbo].[U_ELEGALSHLD_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_ELEGALSHLD') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ELEGALSHLD];
GO
IF OBJECT_ID('U_20_ELEGALSHLD_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_20_ELEGALSHLD_drvTbl];
GO
IF OBJECT_ID('U_10_ELEGALSHLD_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_10_ELEGALSHLD_drvTbl];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ELEGALSHLD';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ELEGALSHLD';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ELEGALSHLD';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ELEGALSHLD';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ELEGALSHLD';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ELEGALSHLD','Legal Shield Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','ELEGALSHLDZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"R"','1','(''DA''=''T,'')','ELEGALSHLDZ0','50','H','01','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFileDate"','2','(''UD112''=''T,'')','ELEGALSHLDZ0','50','H','01','2',NULL,'File Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTransmitterName"','3','(''UA''=''T'')','ELEGALSHLDZ0','50','H','01','3',NULL,'Transmitter Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"M"','1','(''DA''=''T,'')','ELEGALSHLDZ0','50','D','10','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMbrCovEffDte"','2','(''UD112''=''T,'')','ELEGALSHLDZ0','50','D','10','2',NULL,'Mbr Coverage Eff-Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMbrLastName"','3','(''UA''=''T,'')','ELEGALSHLDZ0','50','D','10','3',NULL,'Mbr Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMbrFirstName"','4','(''UA''=''T,'')','ELEGALSHLDZ0','50','D','10','4',NULL,'Mbr First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMbrMiddleInit"','5','(''UA''=''T,'')','ELEGALSHLDZ0','50','D','10','5',NULL,'Mbr Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMbrAddressLine1"','6','(''UA''=''T,'')','ELEGALSHLDZ0','50','D','10','6',NULL,'Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMbrAddressLine2"','7','(''UA''=''T,'')','ELEGALSHLDZ0','50','D','10','7',NULL,'Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMbrAddressLine3"','8','(''UA''=''T,'')','ELEGALSHLDZ0','50','D','10','8',NULL,'Address Line 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMbrAddressCirty"','9','(''UA''=''T,'')','ELEGALSHLDZ0','50','D','10','9',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMbrAddressState"','10','(''UA''=''T,'')','ELEGALSHLDZ0','50','D','10','10',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMbrAddressZipCode"','11','(''UA''=''T,'')','ELEGALSHLDZ0','50','D','10','11',NULL,'Postal Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMbrSsn"','12','(''UA''=''T,'')','ELEGALSHLDZ0','50','D','10','12',NULL,'Mbr Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMbrDateOfBirth"','13','(''UD112''=''T,'')','ELEGALSHLDZ0','50','D','10','13',NULL,'Mbr DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMbrHomePhone"','14','(''UA''=''T,'')','ELEGALSHLDZ0','50','D','10','14',NULL,'Mbr Home Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMbrWorkPhone"','15','(''UA''=''T,'')','ELEGALSHLDZ0','50','D','10','15',NULL,'Mbr Work Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMbrWorkPhoneExt"','16','(''UA''=''T,'')','ELEGALSHLDZ0','50','D','10','16',NULL,'Mbr Work Phone Ext.',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMbrGroupNo"','17','(''UA''=''T,'')','ELEGALSHLDZ0','50','D','10','17',NULL,'Mbr Group #',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''DA''=''T,'')','ELEGALSHLDZ0','50','D','10','18',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMbrCovCode"','19','(''UA''=''T,'')','ELEGALSHLDZ0','50','D','10','19',NULL,'Member Coverage Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpId"','20','(''UA''=''T,'')','ELEGALSHLDZ0','50','D','10','20',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','21','(''DA''=''T,'')','ELEGALSHLDZ0','50','D','10','21',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','22','(''DA''=''T,'')','ELEGALSHLDZ0','50','D','10','22',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','23','(''DA''=''T,'')','ELEGALSHLDZ0','50','D','10','23',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','24','(''DA''=''T,'')','ELEGALSHLDZ0','50','D','10','24',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','25','(''DA''=''T,'')','ELEGALSHLDZ0','50','D','10','25',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvActivityFlag"','26','(''UA''=''T,'')','ELEGALSHLDZ0','50','D','10','26',NULL,'Activity Flag',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmailAddress"','27','(''UA''=''T,'')','ELEGALSHLDZ0','50','D','10','27',NULL,'Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','28','(''DA''=''T,'')','ELEGALSHLDZ0','50','D','10','28',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMbrPayPeriod"','29','(''UA''=''T,'')','ELEGALSHLDZ0','50','D','10','29',NULL,'Member Pay Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','30','(''DA''=''T,'')','ELEGALSHLDZ0','50','D','10','30',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','31','(''DA''=''T,'')','ELEGALSHLDZ0','50','D','10','31',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','32','(''DA''=''T,'')','ELEGALSHLDZ0','50','D','10','32',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','33','(''DA''=''T,'')','ELEGALSHLDZ0','50','D','10','33',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','34','(''DA''=''T,'')','ELEGALSHLDZ0','50','D','10','34',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','35','(''DA''=''T,'')','ELEGALSHLDZ0','50','D','10','35',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','36','(''DA''=''T,'')','ELEGALSHLDZ0','50','D','10','36',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','37','(''DA''=''T,'')','ELEGALSHLDZ0','50','D','10','37',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMbrTermDate"','38','(''UD112''=''T,'')','ELEGALSHLDZ0','50','D','10','38',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMbrTermReason"','39','(''UA''=''T,'')','ELEGALSHLDZ0','50','D','10','39',NULL,'Termination Reason',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBillingDivCode"','40','(''UA''=''T'')','ELEGALSHLDZ0','50','D','10','40',NULL,'Billing Division Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"D"','1','(''DA''=''T,'')','ELEGALSHLDZ0','50','D','20','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffDate"','2','(''UD112''=''T,'')','ELEGALSHLDZ0','50','D','20','2',NULL,'Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepLastName"','3','(''UA''=''T,'')','ELEGALSHLDZ0','50','D','20','3',NULL,'Dep Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepFirstName"','4','(''UA''=''T,'')','ELEGALSHLDZ0','50','D','20','4',NULL,'Dep First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepMiddleInit"','5','(''UA''=''T,'')','ELEGALSHLDZ0','50','D','20','5',NULL,'Dep Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelInd"','6','(''UA''=''T,'')','ELEGALSHLDZ0','50','D','20','6',NULL,'Relationship Indv',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMbrSS"','7','(''UA''=''T,'')','ELEGALSHLDZ0','50','D','20','7',NULL,'Mbr Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDateOfBirth"','8','(''UD112''=''T'')','ELEGALSHLDZ0','50','D','20','8',NULL,'Dep DOB',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ELEGALSHLD_20200218.txt',NULL,'','','',NULL,NULL,NULL,'Legal Shield Export','202001019','EMPEXPORT','ONDEMAND','Dec  6 2019 10:10AM','ELEGALSHLD',NULL,NULL,NULL,'202001019','Dec  5 2019 11:48AM','Dec  5 2019 11:48AM','202001011','1','','','202001011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ELEGALSHLD_20200218.txt',NULL,'','',',7248P,724AN,724BB,7249V',NULL,NULL,NULL,'LegalShield - Fridays 5pm','202001019','EMPEXPORT','SCHEDULED','Dec  6 2019 10:11AM','ELEGALSHLD',NULL,NULL,NULL,'202002149','Dec  5 2019 11:48AM','Dec  5 2019 11:48AM','202002071','1','','','202001011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ELEGALSHLD_20200218.txt',NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','202001019','EMPEXPORT','OEACTIVE','Dec  6 2019 10:08AM','ELEGALSHLD',NULL,NULL,NULL,'202001019','Dec  5 2019 11:48AM','Dec  5 2019 11:48AM','202001011','1','','','202001011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ELEGALSHLD_20200218.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202001019','EMPEXPORT','TEST','Feb  3 2020 10:22AM','ELEGALSHLD',NULL,NULL,NULL,'202001019','Jan  1 2020 12:00AM','Dec 30 1899 12:00AM','201912131','121','','','201912131',dbo.fn_GetTimedKey(),NULL,'us3mLaKIN1006',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ELEGALSHLD_20200218.txt',NULL,'','','',NULL,NULL,NULL,'Passive Open Enrollment Export','202001319','EMPEXPORT','OEPASSIVE','Dec 24 2019  3:53PM','ELEGALSHLD',NULL,NULL,NULL,'202001319','Jan 31 2020 12:00AM','Dec 30 1899 12:00AM','202001011','121','','','202001011',dbo.fn_GetTimedKey(),NULL,'us3lKiKIN1006',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_ELEGALSHLD_20200218.txt' END WHERE expFormatCode = 'ELEGALSHLD';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELEGALSHLD','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELEGALSHLD','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELEGALSHLD','InitialSort','C','drvSort1');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELEGALSHLD','SubSort','C','drvSort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELEGALSHLD','SubSort2','C','drvSort3');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELEGALSHLD','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELEGALSHLD','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'ELEGALSHLD' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ELEGALSHLD' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_ELEGALSHLD_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ELEGALSHLD_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ELEGALSHLD','H01','dbo.U_ELEGALSHLD_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ELEGALSHLD','D10','dbo.U_10_ELEGALSHLD_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ELEGALSHLD','D20','dbo.U_20_ELEGALSHLD_drvTbl',NULL);
IF OBJECT_ID('U_10_ELEGALSHLD_drvTbl') IS NULL
CREATE TABLE [dbo].[U_10_ELEGALSHLD_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort1] varchar(12) NULL,
    [drvSort2] varchar(1) NOT NULL,
    [drvSort3] varchar(1) NOT NULL,
    [drvMbrCovEffDte] datetime NULL,
    [drvMbrLastName] varchar(100) NULL,
    [drvMbrFirstName] varchar(100) NULL,
    [drvMbrMiddleInit] varchar(1) NULL,
    [drvMbrAddressLine1] varchar(255) NULL,
    [drvMbrAddressLine2] varchar(255) NULL,
    [drvMbrAddressLine3] varchar(1) NOT NULL,
    [drvMbrAddressCirty] varchar(255) NULL,
    [drvMbrAddressState] varchar(255) NULL,
    [drvMbrAddressZipCode] varchar(50) NULL,
    [drvMbrSsn] char(11) NULL,
    [drvMbrDateOfBirth] datetime NULL,
    [drvMbrHomePhone] varchar(50) NULL,
    [drvMbrWorkPhone] varchar(50) NULL,
    [drvMbrWorkPhoneExt] varchar(50) NULL,
    [drvMbrGroupNo] varchar(6) NOT NULL,
    [drvMbrCovCode] varchar(15) NULL,
    [drvEmpId] varchar(1) NOT NULL,
    [drvActivityFlag] varchar(1) NOT NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvMbrPayPeriod] varchar(2) NULL,
    [drvMbrTermDate] varchar(1) NOT NULL,
    [drvMbrTermReason] varchar(1) NOT NULL,
    [drvBillingDivCode] varchar(1) NOT NULL
);
IF OBJECT_ID('U_20_ELEGALSHLD_drvTbl') IS NULL
CREATE TABLE [dbo].[U_20_ELEGALSHLD_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort1] varchar(12) NULL,
    [drvSort2] varchar(1) NOT NULL,
    [drvSort3] varchar(1) NOT NULL,
    [drvEffDate] datetime NULL,
    [drvDepLastName] varchar(100) NULL,
    [drvDepFirstName] varchar(100) NULL,
    [drvDepMiddleInit] varchar(1) NULL,
    [drvRelInd] varchar(2) NULL,
    [drvMbrSS] char(11) NULL,
    [drvDepDateOfBirth] datetime NULL
);
IF OBJECT_ID('U_dsi_BDM_ELEGALSHLD') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ELEGALSHLD] (
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
IF OBJECT_ID('U_ELEGALSHLD_DedList') IS NULL
CREATE TABLE [dbo].[U_ELEGALSHLD_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ELEGALSHLD_EEList') IS NULL
CREATE TABLE [dbo].[U_ELEGALSHLD_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ELEGALSHLD_File') IS NULL
CREATE TABLE [dbo].[U_ELEGALSHLD_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
IF OBJECT_ID('U_ELEGALSHLD_Header') IS NULL
CREATE TABLE [dbo].[U_ELEGALSHLD_Header] (
    [drvFileDate] nvarchar(4000) NULL,
    [drvTransmitterName] varchar(31) NULL
);
IF OBJECT_ID('U_ELEGALSHLD_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ELEGALSHLD_PDedHist] (
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
IF OBJECT_ID('U_ELEGALSHLD_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ELEGALSHLD_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ELEGALSHLD]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: King Engineering Associates

Created By: James Bender
Business Analyst: Lea King
Create Date: 12/05/2019
Service Request Number: TekP-2019-10-15-0001

Purpose: Legal Shield Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2019     SR-2019-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ELEGALSHLD';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ELEGALSHLD';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ELEGALSHLD';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ELEGALSHLD';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ELEGALSHLD' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELEGALSHLD', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELEGALSHLD', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELEGALSHLD', 'OEACTIVE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ELEGALSHLD';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ELEGALSHLD', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ELEGALSHLD';

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
    DELETE FROM dbo.U_ELEGALSHLD_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ELEGALSHLD_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'LEG,LEGID';

    IF OBJECT_ID('U_ELEGALSHLD_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ELEGALSHLD_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ELEGALSHLD_DedList
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
    IF OBJECT_ID('U_ELEGALSHLD_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ELEGALSHLD_PDedHist;
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
    INTO dbo.U_ELEGALSHLD_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ELEGALSHLD_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_ELEGALSHLD_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ELEGALSHLD_PEarHist;
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
    INTO dbo.U_ELEGALSHLD_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_10_ELEGALSHLD_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_10_ELEGALSHLD_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_10_ELEGALSHLD_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort1 = EepSSN + '1'
        ,drvSort2 = ''
        ,drvSort3 = ''
        -- standard fields above and additional driver fields below
        ,drvMbrCovEffDte = BdmBenStartDate
        ,drvMbrLastName = EepNameLast
        ,drvMbrFirstName = EepNameFirst
        ,drvMbrMiddleInit = LEFT(EepNameMiddle,1)
        ,drvMbrAddressLine1 = EepAddressLine1
        ,drvMbrAddressLine2 = EepAddressLine2
        ,drvMbrAddressLine3 = ''
        ,drvMbrAddressCirty = EepAddressCity
        ,drvMbrAddressState = EepAddressState
        ,drvMbrAddressZipCode = EepAddressZipCode
        ,drvMbrSsn = eepSSN
        ,drvMbrDateOfBirth = EepDateOfBirth
        ,drvMbrHomePhone = EepPhoneHomeNumber
        ,drvMbrWorkPhone = EecPhoneBusinessNumber
        ,drvMbrWorkPhoneExt = EecPhoneBusinessNumber
        ,drvMbrGroupNo = '139872'
        ,drvMbrCovCode =     CASE EepAddressState -- JCB
                                WHEN 'NY' THEN
                                    CASE BdmDedCode 
                                        WHEN 'LEG' THEN
                                            CASE
                                                WHEN BdmBenOption IN ('LEG', 'LEGEE') THEN 'YN'
                                                WHEN BdmBenOption IN ('IDEE') THEN 'DQ'
                                                WHEN BdmBenOption IN ('IDF') THEN 'TK'
                                                WHEN BdmBenOption IN ('LGIDF') THEN 'FN'
                                                WHEN BdmBenOption IN ('LGIDEE', 'LGIDE') THEN 'FN'
                                            END
                                        WHEN 'LEGID' THEN
                                            CASE 
                                                WHEN BdmBenOption IN ('EE') THEN 'FN'
                                                WHEN BdmBenOption IN ('EEF') THEN 'FN'
                                                WHEN BdmBenOption IN ('LEGID') THEN 'TS'
                                            END
                                    END
                                ELSE
                                    CASE BdmDedCode 
                                        WHEN 'LEG' THEN
                                            CASE
                                                WHEN BdmBenOption IN ('LEG', 'LEGEE') THEN 'FN'
                                                WHEN BdmBenOption IN ('IDEE') THEN 'DQ'
                                                WHEN BdmBenOption IN ('IDF') THEN 'TK'
                                                WHEN BdmBenOption IN ('LGIDF') THEN 'GM'
                                                WHEN BdmBenOption IN ('LGIDEE', 'LGIDE') THEN 'GK'                                                
                                            END
                                        WHEN 'LEGID' THEN
                                            CASE 
                                                WHEN BdmBenOption IN ('EE') THEN 'FN'
                                                WHEN BdmBenOption IN ('EEF') THEN 'GM'
                                                WHEN BdmBenOption IN ('LEGID') THEN 'GK'
                                            END
                                        ELSE ISNULL(BdmDedCode, 'nope') + ' :: ' + ISNULL(BdmBenOption, 'nope')
                                    END
                            END
        ,drvEmpId = ''
        ,drvActivityFlag = CASE WHEN EecEmplStatus = 'L' THEN 'L' ELSE 'A' END
        ,drvEmailAddress = EepAddressEMail
        ,drvMbrPayPeriod =    CASE PgrPayFrequency
                                WHEN 'W' THEN '52'
                                WHEN 'B' THEN '26'
                                WHEN 'S' THEN '24'
                                WHEN 'M' THEN '12'
                            END
        ,drvMbrTermDate = ''
        ,drvMbrTermReason = ''
        ,drvBillingDivCode = ''
    INTO dbo.U_10_ELEGALSHLD_drvTbl
    FROM dbo.U_ELEGALSHLD_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ELEGALSHLD WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.PayGroup WITH (NOLOCK)
        ON PgrPayGroup = EecPayGroup
    WHERE EecEEType NOT IN ('TES')
    ;
    ---------------------------------
    -- DETAIL RECORD - U_20_ELEGALSHLD_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_20_ELEGALSHLD_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_20_ELEGALSHLD_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort1 = EepSSN + '2'
        ,drvSort2 = ''
        ,drvSort3 = ''
        -- standard fields above and additional driver fields below
        ,drvEffDate = BdmBenStartDate
        ,drvDepLastName = ConNameLast
        ,drvDepFirstName = ConNameFirst
        ,drvDepMiddleInit = LEFT(ConNameMiddle,1)
        ,drvRelInd =    CASE WHEN ConRelationship IN ('SPS', 'DP') THEN 'SP'
                            WHEN ConRelationship IN ('CHL', 'DPC', 'DCH', 'STC') THEN 'DP'
                        END
        ,drvMbrSS = EepSSn
        ,drvDepDateOfBirth = ConDateOfBirth
    INTO dbo.U_20_ELEGALSHLD_drvTbl
    FROM dbo.U_ELEGALSHLD_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ELEGALSHLD WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND BdmDepRecId = ConImportID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID    
    WHERE EecEEType NOT IN ('TES')    
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ELEGALSHLD_Header','U') IS NOT NULL
        DROP TABLE dbo.U_ELEGALSHLD_Header;
    SELECT DISTINCT
         drvFileDate = FORMAT(GETDATE(), 'yyyyMMdd')
        ,drvTransmitterName = LEFT('King Engineering Associates Inc', 50)
    INTO dbo.U_ELEGALSHLD_Header
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
ALTER VIEW dbo.dsi_vwELEGALSHLD_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ELEGALSHLD_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ELEGALSHLD%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202001011'
       ,expStartPerControl     = '202001011'
       ,expLastEndPerControl   = '202001019'
       ,expEndPerControl       = '202001019'
WHERE expFormatCode = 'ELEGALSHLD';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwELEGALSHLD_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ELEGALSHLD_File (NOLOCK)
    ORDER BY CASE WHEN LEFT(RecordSet,1) = 'D' THEN 10 ELSE RIGHT(RecordSet,2) END, InitialSort