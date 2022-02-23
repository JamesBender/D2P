SET NOCOUNT ON;
IF OBJECT_ID('U_EDOENYLCON_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EDOENYLCON_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EDOENYLCON_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EDOENYLCON' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEDOENYLCON_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEDOENYLCON_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EDOENYLCON') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EDOENYLCON];
GO
IF OBJECT_ID('U_EDOENYLCON_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EDOENYLCON_Trailer];
GO
IF OBJECT_ID('U_EDOENYLCON_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EDOENYLCON_PEarHist];
GO
IF OBJECT_ID('U_EDOENYLCON_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EDOENYLCON_PDedHist];
GO
IF OBJECT_ID('U_EDOENYLCON_Header') IS NOT NULL DROP TABLE [dbo].[U_EDOENYLCON_Header];
GO
IF OBJECT_ID('U_EDOENYLCON_File') IS NOT NULL DROP TABLE [dbo].[U_EDOENYLCON_File];
GO
IF OBJECT_ID('U_EDOENYLCON_EEList') IS NOT NULL DROP TABLE [dbo].[U_EDOENYLCON_EEList];
GO
IF OBJECT_ID('U_EDOENYLCON_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EDOENYLCON_drvTbl];
GO
IF OBJECT_ID('U_EDOENYLCON_DedList') IS NOT NULL DROP TABLE [dbo].[U_EDOENYLCON_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EDOENYLCON') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EDOENYLCON];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EDOENYLCON';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EDOENYLCON';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EDOENYLCON';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EDOENYLCON';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EDOENYLCON';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EDOENYLCON','NYLife Port and Convert Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','EDOENYLCONZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EDOENYLCON' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFileHeaderIdentifier"','1','(''UA''=''F'')','EDOENYLCONZ0','2','H','01','1',NULL,'drvFileHeaderIdentifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTestIndicator"','2','(''UA''=''F'')','EDOENYLCONZ0','1','H','01','2',NULL,'drvTestIndicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFileCreationDate"','3','(''UD112''=''F'')','EDOENYLCONZ0','8','H','01','3',NULL,'drvFileCreationDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerName"','4','(''UA''=''F'')','EDOENYLCONZ0','35','H','01','4',NULL,'drvEmployerName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFiller"','5','(''UA''=''F'')','EDOENYLCONZ0','418','H','01','5',NULL,'drvFiller',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeLastName"','1','(''UA''=''F'')','EDOENYLCONZ0','35','D','10','1',NULL,'drvEmployeeLastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeFirstName"','2','(''UA''=''F'')','EDOENYLCONZ0','25','D','10','2',NULL,'drvEmployeeFirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeSSN"','3','(''UA''=''F'')','EDOENYLCONZ0','9','D','10','3',NULL,'drvEmployeeSSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeTerminationDate"','4','(''UA''=''F'')','EDOENYLCONZ0','8','D','10','4',NULL,'drvEmployeeTerminationDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeMailAddress1"','5','(''UA''=''F'')','EDOENYLCONZ0','35','D','10','5',NULL,'drvEmployeeMailAddress1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeMailAddress2"','6','(''UA''=''F'')','EDOENYLCONZ0','35','D','10','6',NULL,'drvEmployeeMailAddress2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeMailCity"','7','(''UA''=''F'')','EDOENYLCONZ0','30','D','10','7',NULL,'drvEmployeeMailCity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeMailState"','8','(''UA''=''F'')','EDOENYLCONZ0','2','D','10','8',NULL,'drvEmployeeMailState',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeMailZipCode"','9','(''UA''=''F'')','EDOENYLCONZ0','10','D','10','9',NULL,'drvEmployeeMailZipCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeCountry"','10','(''UA''=''F'')','EDOENYLCONZ0','30','D','10','10',NULL,'drvEmployeeCountry',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClassCodeBasicLife"','11','(''UA''=''F'')','EDOENYLCONZ0','3','D','10','11',NULL,'drvClassCodeBasicLife',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpIssuedAmountBasicLife"','12','(''UA''=''F'')','EDOENYLCONZ0','9','D','10','12',NULL,'drvEmpIssuedAmountBasicLife',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeBasicLifeEndDate"','13','(''UA''=''F'')','EDOENYLCONZ0','8','D','10','13',NULL,'drvEmployeeBasicLifeEndDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpsIssuedAmountBasicLife"','14','(''UA''=''F'')','EDOENYLCONZ0','9','D','10','14',NULL,'drvSpsIssuedAmountBasicLife',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseBasicLifeEndDate"','15','(''UA''=''F'')','EDOENYLCONZ0','8','D','10','15',NULL,'drvSpouseBasicLifeEndDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChildIssuedAmountBasicLife"','16','(''UA''=''F'')','EDOENYLCONZ0','9','D','10','16',NULL,'drvChildIssuedAmountBasicLife',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChildBasicLifeEndDate"','17','(''UA''=''F'')','EDOENYLCONZ0','8','D','10','17',NULL,'drvChildBasicLifeEndDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClassCodeBasicADD"','18','(''UA''=''F'')','EDOENYLCONZ0','3','D','10','18',NULL,'drvClassCodeBasicADD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpIssuedAmountBasicADD"','19','(''UA''=''F'')','EDOENYLCONZ0','9','D','10','19',NULL,'drvEmpIssuedAmountBasicADD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeBasicADDEndDate"','20','(''UA''=''F'')','EDOENYLCONZ0','8','D','10','20',NULL,'drvEmployeeBasicADDEndDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseBasicADDEndDate"','21','(''UA''=''F'')','EDOENYLCONZ0','9','D','10','21',NULL,'drvSpouseBasicADDEndDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChildIssuedAmountBasicADD"','22','(''UA''=''F'')','EDOENYLCONZ0','8','D','10','22',NULL,'drvChildIssuedAmountBasicADD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChildIssuedAmountBasicADDDate"','23','(''UA''=''F'')','EDOENYLCONZ0','9','D','10','23',NULL,'drvChildIssuedAmountBasicADD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChildBasicADDEndDate"','24','(''UA''=''F'')','EDOENYLCONZ0','8','D','10','24',NULL,'drvChildBasicADDEndDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClassCodeVoluntaryLife"','25','(''UA''=''F'')','EDOENYLCONZ0','3','D','10','25',NULL,'drvClassCodeVoluntaryLife',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpIssuedAmountVoluntaryLife"','26','(''UA''=''F'')','EDOENYLCONZ0','9','D','10','26',NULL,'drvEmpIssuedAmountVoluntaryLife',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpVoluntaryLifeEndDate"','27','(''UA''=''F'')','EDOENYLCONZ0','8','D','10','27',NULL,'drvEmpVoluntaryLifeEndDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpsIssuedAmountVoluntaryLife"','28','(''UA''=''F'')','EDOENYLCONZ0','9','D','10','28',NULL,'drvSpsIssuedAmountVoluntaryLife',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseVoluntaryLifeEndDate"','29','(''UA''=''F'')','EDOENYLCONZ0','8','D','10','29',NULL,'drvSpouseVoluntaryLifeEndDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChdIssuedAmountVoluntaryLife"','30','(''UA''=''F'')','EDOENYLCONZ0','9','D','10','30',NULL,'drvChdIssuedAmountVoluntaryLife',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChildVoluntaryLifeEndDate"','31','(''UA''=''F'')','EDOENYLCONZ0','8','D','10','31',NULL,'drvChildVoluntaryLifeEndDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClassCodeVoluntaryADD"','32','(''UA''=''F'')','EDOENYLCONZ0','3','D','10','32',NULL,'drvClassCodeVoluntaryADD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpIssuedAmountVoluntaryADD"','33','(''UA''=''F'')','EDOENYLCONZ0','9','D','10','33',NULL,'drvEmpIssuedAmountVoluntaryADD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpVoluntaryADDEndDate"','34','(''UA''=''F'')','EDOENYLCONZ0','8','D','10','34',NULL,'drvEmpVoluntaryADDEndDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpsIssuedAmountVoluntaryADD"','35','(''UA''=''F'')','EDOENYLCONZ0','9','D','10','35',NULL,'drvSpsIssuedAmountVoluntaryADD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseVoluntaryADDEndDate"','36','(''UA''=''F'')','EDOENYLCONZ0','8','D','10','36',NULL,'drvSpouseVoluntaryADDEndDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChdIssuedAmountVoluntaryADD"','37','(''UA''=''F'')','EDOENYLCONZ0','9','D','10','37',NULL,'drvChdIssuedAmountVoluntaryADD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChildVoluntaryADDEndDate"','38','(''UA''=''F'')','EDOENYLCONZ0','8','D','10','38',NULL,'drvChildVoluntaryADDEndDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClassCodeLTD"','39','(''UA''=''F'')','EDOENYLCONZ0','3','D','10','39',NULL,'drvClassCodeLTD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpLTDMonthlyEarnings"','40','(''UA''=''F'')','EDOENYLCONZ0','9','D','10','40',NULL,'drvEmpLTDMonthlyEarnings',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobClassification"','41','(''UA''=''F'')','EDOENYLCONZ0','1','D','10','41',NULL,'drvJobClassification',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpLTDCoverageBeginDate"','42','(''UA''=''F'')','EDOENYLCONZ0','8','D','10','42',NULL,'drvEmpLTDCoverageBeginDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeLTDEndDate"','43','(''UA''=''F'')','EDOENYLCONZ0','8','D','10','43',NULL,'drvEmployeeLTDEndDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotNumberofRecords"','1','(''UA''=''F'')','EDOENYLCONZ0','9','T','90','1',NULL,'drvTotNumberofRecords',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFiller"','2','(''UA''=''F'')','EDOENYLCONZ0','455','T','90','2',NULL,'drvFiller',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EDOENYLCON_20210922.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202109179','EMPEXPORT','OEACTIVE',NULL,'EDOENYLCON',NULL,NULL,NULL,'202109179','Sep 17 2021  6:35PM','Sep 17 2021  6:35PM','202109171',NULL,'','','202109171',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202109179','EMPEXPORT','OEPASSIVE',NULL,'EDOENYLCON',NULL,NULL,NULL,'202109179','Sep 17 2021  6:35PM','Sep 17 2021  6:35PM','202109171',NULL,'','','202109171',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'NYLife Port and Convert File','202109179','EMPEXPORT','ONDEM_XOE',NULL,'EDOENYLCON',NULL,NULL,NULL,'202109179','Sep 17 2021  6:35PM','Sep 17 2021  6:35PM','202109171',NULL,'','','202109171',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'NYLife Port and Convert -Sched','202109179','EMPEXPORT','SCH_EDOENY',NULL,'EDOENYLCON',NULL,NULL,NULL,'202109179','Sep 17 2021  6:35PM','Sep 17 2021  6:35PM','202109171',NULL,'','','202109171',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'NYLife Port and Convert -Test','202109179','EMPEXPORT','TEST_XOE','Sep 22 2021  9:42PM','EDOENYLCON',NULL,NULL,NULL,'202109179','Sep 17 2021  6:35PM','Sep 17 2021  6:35PM','202109171','1241','','','202109171',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDOENYLCON','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDOENYLCON','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDOENYLCON','InitialSort','C','drvInitialsort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDOENYLCON','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDOENYLCON','SubSort2','C','drvSubSort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDOENYLCON','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDOENYLCON','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EDOENYLCON' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EDOENYLCON' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EDOENYLCON_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EDOENYLCON_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDOENYLCON','H01','dbo.U_EDOENYLCON_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDOENYLCON','D10','dbo.U_EDOENYLCON_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDOENYLCON','T90','dbo.U_EDOENYLCON_Trailer',NULL);
IF OBJECT_ID('U_dsi_BDM_EDOENYLCON') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EDOENYLCON] (
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
IF OBJECT_ID('U_EDOENYLCON_DedList') IS NULL
CREATE TABLE [dbo].[U_EDOENYLCON_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EDOENYLCON_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EDOENYLCON_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialsort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvEmployeeLastName] varchar(100) NULL,
    [drvEmployeeFirstName] varchar(100) NULL,
    [drvEmployeeSSN] char(11) NULL,
    [drvEmployeeTerminationDate] varchar(8) NULL,
    [drvEmployeeMailAddress1] varchar(255) NULL,
    [drvEmployeeMailAddress2] varchar(255) NULL,
    [drvEmployeeMailCity] varchar(255) NULL,
    [drvEmployeeMailState] varchar(255) NULL,
    [drvEmployeeMailZipCode] varchar(50) NULL,
    [drvEmployeeCountry] char(3) NULL,
    [drvClassCodeBasicLife] varchar(3) NULL,
    [drvEmpIssuedAmountBasicLife] varchar(24) NULL,
    [drvEmployeeBasicLifeEndDate] varchar(8) NULL,
    [drvSpsIssuedAmountBasicLife] varchar(9) NOT NULL,
    [drvSpouseBasicLifeEndDate] varchar(8) NOT NULL,
    [drvChildIssuedAmountBasicLife] varchar(9) NOT NULL,
    [drvChildBasicLifeEndDate] varchar(8) NOT NULL,
    [drvClassCodeBasicADD] varchar(3) NULL,
    [drvEmpIssuedAmountBasicADD] varchar(24) NULL,
    [drvEmployeeBasicADDEndDate] varchar(8) NULL,
    [drvSpouseBasicADDEndDate] varchar(9) NOT NULL,
    [drvChildIssuedAmountBasicADD] varchar(8) NOT NULL,
    [drvChildIssuedAmountBasicADDDate] varchar(9) NOT NULL,
    [drvChildBasicADDEndDate] varchar(9) NOT NULL,
    [drvClassCodeVoluntaryLife] varchar(3) NULL,
    [drvEmpIssuedAmountVoluntaryLife] varchar(24) NULL,
    [drvEmpVoluntaryLifeEndDate] varchar(8) NULL,
    [drvSpsIssuedAmountVoluntaryLife] varchar(24) NULL,
    [drvSpouseVoluntaryLifeEndDate] varchar(8) NULL,
    [drvChdIssuedAmountVoluntaryLife] varchar(24) NULL,
    [drvChildVoluntaryLifeEndDate] varchar(8) NULL,
    [drvClassCodeVoluntaryADD] varchar(3) NULL,
    [drvEmpIssuedAmountVoluntaryADD] varchar(24) NULL,
    [drvEmpVoluntaryADDEndDate] varchar(8) NULL,
    [drvSpsIssuedAmountVoluntaryADD] varchar(24) NULL,
    [drvSpouseVoluntaryADDEndDate] varchar(8) NULL,
    [drvChdIssuedAmountVoluntaryADD] varchar(24) NULL,
    [drvChildVoluntaryADDEndDate] varchar(8) NULL,
    [drvClassCodeLTD] varchar(3) NOT NULL,
    [drvEmpLTDMonthlyEarnings] varchar(9) NOT NULL,
    [drvJobClassification] varchar(1) NOT NULL,
    [drvEmpLTDCoverageBeginDate] varchar(8) NOT NULL,
    [drvEmployeeLTDEndDate] varchar(8) NOT NULL
);
IF OBJECT_ID('U_EDOENYLCON_EEList') IS NULL
CREATE TABLE [dbo].[U_EDOENYLCON_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EDOENYLCON_File') IS NULL
CREATE TABLE [dbo].[U_EDOENYLCON_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
IF OBJECT_ID('U_EDOENYLCON_Header') IS NULL
CREATE TABLE [dbo].[U_EDOENYLCON_Header] (
    [drvFileHeaderIdentifier] varchar(2) NOT NULL,
    [drvTestIndicator] varchar(1) NOT NULL,
    [drvFileCreationDate] datetime NOT NULL,
    [drvEmployerName] varchar(19) NOT NULL,
    [drvFiller] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EDOENYLCON_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EDOENYLCON_PDedHist] (
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
IF OBJECT_ID('U_EDOENYLCON_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EDOENYLCON_PEarHist] (
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
IF OBJECT_ID('U_EDOENYLCON_Trailer') IS NULL
CREATE TABLE [dbo].[U_EDOENYLCON_Trailer] (
    [drvTotNumberofRecords] int NULL,
    [drvFiller] varchar(1) NOT NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EDOENYLCON]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: The Doe Run Company

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 09/17/2021
Service Request Number: TekP-2021-08-10-0002

Purpose: NYLife Port and Convert Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EDOENYLCON';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EDOENYLCON';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EDOENYLCON';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EDOENYLCON';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EDOENYLCON' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDOENYLCON', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDOENYLCON', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDOENYLCON', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDOENYLCON', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDOENYLCON', 'SCH_EDOENY';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EDOENYLCON';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EDOENYLCON', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EDOENYLCON';

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
    DELETE FROM dbo.U_EDOENYLCON_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EDOENYLCON_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = ',GLIFE,AADD,ALFE2,ALFE3,ALFE4,ALFE5,ALFE6,LIFS1,LIFS2,LIFS3,LIFS4,LIFS5,LIFC1,ALIFC,ADDE1,EADD1,EADD2,EADD3,EADD4,EADD5,ADDS1,ADDS2,ADDS3,ADDS4,ADDS5,ADDC1';

    IF OBJECT_ID('U_EDOENYLCON_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EDOENYLCON_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EDOENYLCON_DedList
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

    EXEC dbo.dsi_bdm_sp_CalculateBenefitAmounts @FormatCode;


    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EDOENYLCON_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EDOENYLCON_PDedHist;
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
    INTO dbo.U_EDOENYLCON_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EDOENYLCON_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EDOENYLCON_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EDOENYLCON_PEarHist;
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
    INTO dbo.U_EDOENYLCON_PEarHist
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
    -- DETAIL RECORD - U_EDOENYLCON_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EDOENYLCON_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EDOENYLCON_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialsort = eepSSN
        ,drvSubSort = ''
        ,drvSubSort2 = ''
        -- standard fields above and additional driver fields below
        ,drvEmployeeLastName = EepNameLast
        ,drvEmployeeFirstName = EepNameFirst
        ,drvEmployeeSSN = eepSSN
        ,drvEmployeeTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN
                                         CASE WHEN EecDateOfTermination IS NOT NULL THEN Convert(CHAR(8),EecDateOfTermination,112) ELSE '00000000' END
                                END
        ,drvEmployeeMailAddress1 = EepAddressLine1
        ,drvEmployeeMailAddress2 = EepAddressLine2
        ,drvEmployeeMailCity = EepAddressCity
        ,drvEmployeeMailState = EepAddressState
        ,drvEmployeeMailZipCode = EepAddressZipCode
        ,drvEmployeeCountry = EepAddressCountry

        ,drvClassCodeBasicLife = CASE WHEN GLIFE is not null  THEN
                                        CASE WHEN EecPayGroup = 'HRMON' THEN '001'
                                             WHEN EecPayGroup <> 'HRMON' THEN '002'
                                        END
                                    ELSE '000' END
        ,drvEmpIssuedAmountBasicLife = CASE WHEN GLIFE is not null THEN  dbo.dsi_fnpadzero((ISNULL(GLIFE_AMT,0)),9,0) ELSE '000000000' END
        ,drvEmployeeBasicLifeEndDate = CASE WHEN GLIFE IS NOT NULL and GLIFE_BenStopDate IS NOT NULL THEN Convert(CHAR(8),GLIFE_BenStopDate,112) ELSE '00000000' END
        ,drvSpsIssuedAmountBasicLife = '000000000'
        ,drvSpouseBasicLifeEndDate = '00000000'
        ,drvChildIssuedAmountBasicLife = '000000000'
        ,drvChildBasicLifeEndDate = '00000000'
        ,drvClassCodeBasicADD = CASE WHEN BAD is not null  THEN
                                        CASE WHEN EecPayGroup = 'HRMON' THEN '001'
                                             WHEN EecPayGroup <> 'HRMON' THEN '002'
                                        END
                                    ELSE '000' END
        ,drvEmpIssuedAmountBasicADD = CASE WHEN BAD is not null THEN  dbo.dsi_fnpadzero((ISNULL(BAD_AMT,0)),9,0) ELSE '000000000' END
        ,drvEmployeeBasicADDEndDate = CASE WHEN BAD IS NOT NULL and BAD_BenStopDate IS NOT NULL THEN Convert(CHAR(8),BAD_BenStopDate,112) ELSE '00000000' END
        ,drvSpouseBasicADDEndDate = '000000000'
        ,drvChildIssuedAmountBasicADD = '00000000'
        ,drvChildIssuedAmountBasicADDDate = '000000000'
        ,drvChildBasicADDEndDate = '000000000'
        ,drvClassCodeVoluntaryLife =  CASE WHEN AC is not null  THEN
                                        CASE WHEN EecPayGroup = 'HRMON' THEN '001'
                                             WHEN EecPayGroup <> 'HRMON' THEN '002'
                                        END
                                    ELSE '000' END
        ,drvEmpIssuedAmountVoluntaryLife = CASE WHEN AC is not null THEN  dbo.dsi_fnpadzero((ISNULL(AC_AMT,0)),9,0) ELSE '000000000' END
        ,drvEmpVoluntaryLifeEndDate = CASE WHEN AC IS NOT NULL and AC_BenStopDate IS NOT NULL THEN Convert(CHAR(8),AC_BenStopDate,112) ELSE '00000000' END
        ,drvSpsIssuedAmountVoluntaryLife = CASE WHEN LIFS is not null THEN  dbo.dsi_fnpadzero((ISNULL(LIFS_AMT,0)),9,0) ELSE '000000000' END
        ,drvSpouseVoluntaryLifeEndDate = CASE WHEN LIFS IS NOT NULL and LIFS_BenStopDate IS NOT NULL THEN Convert(CHAR(8),LIFS_BenStopDate,112) ELSE '00000000' END
        ,drvChdIssuedAmountVoluntaryLife =  CASE WHEN LIFC is not null THEN  dbo.dsi_fnpadzero((ISNULL(LIFC_AMT,0)),9,0) ELSE '000000000' END
        ,drvChildVoluntaryLifeEndDate = CASE WHEN LIFC IS NOT NULL and LIFS_BenStopDate IS NOT NULL THEN Convert(CHAR(8),LIFC_BenStopdate,112) ELSE '00000000' END
        ,drvClassCodeVoluntaryADD = CASE WHEN ADDCCode is not null  THEN
                                        CASE WHEN EecPayGroup = 'HRMON' THEN '001'
                                             WHEN EecPayGroup <> 'HRMON' THEN '002'
                                        END
                                    ELSE '000' END
        ,drvEmpIssuedAmountVoluntaryADD = CASE WHEN ADDCCode is not null THEN  dbo.dsi_fnpadzero((ISNULL(ADDCode_AMT,0)),9,0) ELSE '000000000' END
        ,drvEmpVoluntaryADDEndDate = CASE WHEN ADDCCode IS NOT NULL and ADDCCode_BenStopDate IS NOT NULL THEN Convert(CHAR(8),ADDCCode_BenStopDate,112) ELSE '00000000' END
        ,drvSpsIssuedAmountVoluntaryADD = CASE WHEN ADDSCode is not null THEN  dbo.dsi_fnpadzero((ISNULL(ADDSCode_AMT,0)),9,0) ELSE '000000000' END
        ,drvSpouseVoluntaryADDEndDate = CASE WHEN ADDSCode IS NOT NULL and ADDSCode_BenStopDate IS NOT NULL THEN Convert(CHAR(8),ADDSCode_BenStopDate,112) ELSE '00000000' END
        ,drvChdIssuedAmountVoluntaryADD = CASE WHEN ADDCCode is not null THEN  dbo.dsi_fnpadzero((ISNULL(ADDCCode_AMT,0)),9,0) ELSE '000000000' END
        ,drvChildVoluntaryADDEndDate = CASE WHEN ADDCCode IS NOT NULL and ADDCCode_BenStopDate IS NOT NULL THEN Convert(CHAR(8),ADDCCode_BenStopDate,112) ELSE '00000000' END
        ,drvClassCodeLTD = '000'
        ,drvEmpLTDMonthlyEarnings = '000000000'
        ,drvJobClassification = '0'
        ,drvEmpLTDCoverageBeginDate = '00000000'
        ,drvEmployeeLTDEndDate = '00000000'
    INTO dbo.U_EDOENYLCON_drvTbl
    FROM dbo.U_EDOENYLCON_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN (Select 
                bdmeeid,
                bdmcoid, 
                GLIFE  = MAX( CASE WHEN bdmdedcode  = 'GLIFE' THEN 'AF' END),
                GLIFE_BenStopDate  = MAX( CASE WHEN bdmdedcode  = 'GLIFE' THEN bdmbenstopdate END),
                GLIFE_AMT = MAX(CASE WHEN Bcadedcode = 'GLIFE' THEN bcabenamtcalc END ),
                AC  = MAX( CASE WHEN bdmdedcode IN ('ALFE2', 'ALFE3', 'ALFE4', 'ALFE5' , 'ALFE6') THEN 'AC' END),
                AC_AMT = MAX(CASE WHEN Bcadedcode IN ('ALFE2', 'ALFE3', 'ALFE4', 'ALFE5' , 'ALFE6')  THEN bcabenamtcalc END ),
                AC_BenStopDate  = MAX( CASE WHEN bdmdedcode  IN ('ALFE2', 'ALFE3', 'ALFE4', 'ALFE5' , 'ALFE6') THEN bdmbenstopdate END),

                BAD  = MAX( CASE WHEN bdmdedcode IN ('AADD') THEN 'BAD' END),
                BAD_AMT = MAX(CASE WHEN Bcadedcode IN ('AADD')  THEN bcabenamtcalc END ),
                BAD_BenStopDate = MAX(CASE WHEN Bcadedcode IN ('AADD')  THEN bdmbenstopdate END ),
                ADDCode  = MAX( CASE WHEN bdmdedcode IN ('ADDE1', 'EADD1', 'EADD2', 'EADD3', 'EADD4', 'EADD5') THEN 'AD' END),
                ADDCode_AMT = MAX(CASE WHEN Bcadedcode IN ('ADDE1', 'EADD1', 'EADD2', 'EADD3', 'EADD4', 'EADD5')  THEN bcabenamtcalc END ),
                ADDCode_BenStopDate = MAX(CASE WHEN Bcadedcode IN ('ADDE1', 'EADD1', 'EADD2', 'EADD3', 'EADD4', 'EADD5')  THEN bdmbenstopdate END ),

                LIFS  = MAX( CASE WHEN bdmdedcode IN ('LIFS1', 'LIFS2', 'LIFS3', 'LIFS4', 'LIFS5') THEN 'LIFS' END),
                LIFS_AMT = MAX(CASE WHEN Bcadedcode IN ('LIFS1', 'LIFS2', 'LIFS3', 'LIFS4', 'LIFS5')  THEN bcabenamtcalc END ),
                LIFS_BenStopDate = MAX(CASE WHEN Bcadedcode IN ('LIFS1', 'LIFS2', 'LIFS3', 'LIFS4', 'LIFS5')  THEN bdmbenstopdate END ),
                LIFC  = MAX( CASE WHEN bdmdedcode IN ('LIFC1', 'ALIFC') THEN 'LIFC' END),
                LIFC_AMT = MAX(CASE WHEN Bcadedcode IN ('LIFC1', 'ALIFC')  THEN bcabenamtcalc END ),
                LIFC_BenStopdate = MAX(CASE WHEN Bcadedcode IN ('LIFC1', 'ALIFC')  THEN bdmbenstopdate END ),
                ADDSCode  = MAX( CASE WHEN bdmdedcode IN ('ADDS1', 'ADDS2', 'ADDS3', 'ADDS4', 'ADDS5') THEN 'ADDS' END),
                ADDSCode_AMT = MAX(CASE WHEN Bcadedcode IN ('ADDS1', 'ADDS2', 'ADDS3', 'ADDS4', 'ADDS5') THEN bcabenamtcalc END ),
                ADDSCode_BenStopDate = MAX(CASE WHEN Bcadedcode IN ('ADDS1', 'ADDS2', 'ADDS3', 'ADDS4', 'ADDS5') THEN bdmbenstopdate END ),
                ADDCCode  = MAX( CASE WHEN bdmdedcode IN ('ADDC1') THEN 'ADDS' END),
                ADDCCode_AMT = MAX(CASE WHEN Bcadedcode IN ('ADDC1') THEN bcabenamtcalc END ),
                ADDCCode_BenStopDate = MAX(CASE WHEN Bcadedcode IN ('ADDC1') THEN bdmbenstopdate END )
            from dbo.U_dsi_BDM_EDOENYLCON WITH (NOLOCK) LEFT JOIN dbo.U_dsi_bdm_BenCalculationAmounts WITH (NOLOCK)
            on bcaeeid = bdmeeid and bcacoid = bdmcoid and bcadedcode = bdmdedcode
            Where bcaformatcode = @FormatCode
            group by bdmeeid,bdmcoid) as bdmconsolidated
        on bdmconsolidated.bdmcoid = xcoid
        and bdmconsolidated.bdmeeid =  xeeid

    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EDOENYLCON_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EDOENYLCON_Header;
    SELECT DISTINCT
         drvFileHeaderIdentifier = 'HD'
        ,drvTestIndicator = CASE WHEN @ExportCode LIKE 'TEST%' THEN 'T' ELSE 'P' END
        ,drvFileCreationDate = GETDATE()
        ,drvEmployerName = 'THE DOE RUN COMPANY'
        ,drvFiller = ''
    INTO dbo.U_EDOENYLCON_Header
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EDOENYLCON_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_EDOENYLCON_Trailer;
    SELECT DISTINCT
         drvTotNumberofRecords = (Select count(*) from dbo.U_EDOENYLCON_drvTbl)  + 2
        ,drvFiller = ''
    INTO dbo.U_EDOENYLCON_Trailer
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
ALTER VIEW dbo.dsi_vwEDOENYLCON_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EDOENYLCON_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EDOENYLCON%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202109101'
       ,expStartPerControl     = '202109101'
       ,expLastEndPerControl   = '202109179'
       ,expEndPerControl       = '202109179'
WHERE expFormatCode = 'EDOENYLCON';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEDOENYLCON_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EDOENYLCON_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort, SubSort2