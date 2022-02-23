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
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EDOENYLCON','NYLife Port and Convert','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','3000','S','N','EDOENYLCONZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EDOENYLCON' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFileHeaderIdentifier"','1','(''UA''=''F'')','EDOENYLCONZ0','2','H','01','1',NULL,'drvFileHeaderIdentifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTestIndicator"','2','(''UA''=''F'')','EDOENYLCONZ0','1','H','01','2',NULL,'drvTestIndicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFileCreationDate"','3','(''UD112''=''F'')','EDOENYLCONZ0','8','H','01','3',NULL,'drvFileCreationDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerName"','4','(''UA''=''F'')','EDOENYLCONZ0','35','H','01','4',NULL,'drvEmployerName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFiller"','5','(''UA''=''F'')','EDOENYLCONZ0','418','H','01','5',NULL,'drvFiller',NULL,NULL);

INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeLastName"','1','(''UA''=''F'')','EDOENYLCONZ0','9','D','10','1',NULL,'drvEmployeeLastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeFirstName"','2','(''UA''=''F'')','EDOENYLCONZ0','11','D','10','2',NULL,'drvEmployeeFirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeSSN"','3','(''UA''=''F'')','EDOENYLCONZ0','10','D','10','3',NULL,'drvEmployeeSSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeTerminationDate"','4','(''UD112''=''F'')','EDOENYLCONZ0','4','D','10','4',NULL,'drvEmployeeTerminationDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeMailAddress1"','5','(''UA''=''F'')','EDOENYLCONZ0','9','D','10','5',NULL,'drvEmployeeMailAddress1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeMailAddress2"','6','(''UA''=''F'')','EDOENYLCONZ0','9','D','10','6',NULL,'drvEmployeeMailAddress2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeMailCity"','7','(''UA''=''F'')','EDOENYLCONZ0','3','D','10','7',NULL,'drvEmployeeMailCity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeMailState"','8','(''UA''=''F'')','EDOENYLCONZ0','8','D','10','8',NULL,'drvEmployeeMailState',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeMailZipCode"','9','(''UA''=''F'')','EDOENYLCONZ0','10','D','10','9',NULL,'drvEmployeeMailZipCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeCountry"','10','(''UA''=''F'')','EDOENYLCONZ0','35','D','10','10',NULL,'drvEmployeeCountry',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClassCodeBasicLife"','11','(''UA''=''F'')','EDOENYLCONZ0','25','D','10','11',NULL,'drvClassCodeBasicLife',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpIssuedAmountBasicLife"','12','(''UA''=''F'')','EDOENYLCONZ0','15','D','10','12',NULL,'drvEmpIssuedAmountBasicLife',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeBasicLifeEndDate"','13','(''UD112''=''F'')','EDOENYLCONZ0','10','D','10','13',NULL,'drvEmployeeBasicLifeEndDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpsIssuedAmountBasicLife"','14','(''UA''=''F'')','EDOENYLCONZ0','10','D','10','14',NULL,'drvSpsIssuedAmountBasicLife',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseBasicLifeEndDate"','15','(''UD112''=''F'')','EDOENYLCONZ0','8','D','10','15',NULL,'drvSpouseBasicLifeEndDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChildIssuedAmountBasicLife"','16','(''UA''=''F'')','EDOENYLCONZ0','1','D','10','16',NULL,'drvChildIssuedAmountBasicLife',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChildBasicLifeEndDate"','17','(''UD112''=''F'')','EDOENYLCONZ0','1','D','10','17',NULL,'drvChildBasicLifeEndDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClassCodeBasicADD"','18','(''UA''=''F'')','EDOENYLCONZ0','4','D','10','18',NULL,'drvClassCodeBasicADD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpIssuedAmountBasicADD"','19','(''UA''=''F'')','EDOENYLCONZ0','1','D','10','19',NULL,'drvEmpIssuedAmountBasicADD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeBasicADDEndDate"','20','(''UD112''=''F'')','EDOENYLCONZ0','34','D','10','20',NULL,'drvEmployeeBasicADDEndDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpsIssuedAmountBasicADD"','21','(''UA''=''F'')','EDOENYLCONZ0','1','D','10','21',NULL,'drvSpsIssuedAmountBasicADD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseBasicADDEndDate"','22','(''UD112''=''F'')','EDOENYLCONZ0','34','D','10','22',NULL,'drvSpouseBasicADDEndDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChildIssuedAmountBasicADD"','23','(''UA''=''F'')','EDOENYLCONZ0','1','D','10','23',NULL,'drvChildIssuedAmountBasicADD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChildBasicADDEndDate"','24','(''UD112''=''F'')','EDOENYLCONZ0','34','D','10','24',NULL,'drvChildBasicADDEndDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClassCodeVoluntaryLife"','25','(''UA''=''F'')','EDOENYLCONZ0','1','D','10','25',NULL,'drvClassCodeVoluntaryLife',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpIssuedAmountVoluntaryLife"','26','(''UA''=''F'')','EDOENYLCONZ0','35','D','10','26',NULL,'drvEmpIssuedAmountVoluntaryLife',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpVoluntaryLifeEndDate"','27','(''UD112''=''F'')','EDOENYLCONZ0','35','D','10','27',NULL,'drvEmpVoluntaryLifeEndDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpsIssuedAmountVoluntaryLife"','28','(''UA''=''F'')','EDOENYLCONZ0','30','D','10','28',NULL,'drvSpsIssuedAmountVoluntaryLife',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseVoluntaryLifeEndDate"','29','(''UD112''=''F'')','EDOENYLCONZ0','2','D','10','29',NULL,'drvSpouseVoluntaryLifeEndDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChdIssuedAmountVoluntaryLife"','30','(''UA''=''F'')','EDOENYLCONZ0','10','D','10','30',NULL,'drvChdIssuedAmountVoluntaryLife',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChildVoluntaryLifeEndDate"','31','(''UD112''=''F'')','EDOENYLCONZ0','30','D','10','31',NULL,'drvChildVoluntaryLifeEndDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClassCodeVoluntaryADD"','32','(''UA''=''F'')','EDOENYLCONZ0','2','D','10','32',NULL,'drvClassCodeVoluntaryADD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpIssuedAmountVoluntaryADD"','33','(''UA''=''F'')','EDOENYLCONZ0','2','D','10','33',NULL,'drvEmpIssuedAmountVoluntaryADD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpVoluntaryADDEndDate"','34','(''UD112''=''F'')','EDOENYLCONZ0','3','D','10','34',NULL,'drvEmpVoluntaryADDEndDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpsIssuedAmountVoluntaryADD"','35','(''UA''=''F'')','EDOENYLCONZ0','1','D','10','35',NULL,'drvSpsIssuedAmountVoluntaryADD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseVoluntaryADDEndDate"','36','(''UD112''=''F'')','EDOENYLCONZ0','8','D','10','36',NULL,'drvSpouseVoluntaryADDEndDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChdIssuedAmountVoluntaryADD"','37','(''UA''=''F'')','EDOENYLCONZ0','20','D','10','37',NULL,'drvChdIssuedAmountVoluntaryADD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChildVoluntaryADDEndDate"','38','(''UD112''=''F'')','EDOENYLCONZ0','1','D','10','38',NULL,'drvChildVoluntaryADDEndDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClassCodeLTD"','39','(''UA''=''F'')','EDOENYLCONZ0','45','D','10','39',NULL,'drvClassCodeLTD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpLTDMonthlyEarnings"','40','(''UA''=''F'')','EDOENYLCONZ0','2','D','10','40',NULL,'drvEmpLTDMonthlyEarnings',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobClassification"','41','(''UA''=''F'')','EDOENYLCONZ0','2','D','10','41',NULL,'drvJobClassification',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpLTDCoverageBeginDate"','42','(''UD112''=''F'')','EDOENYLCONZ0','8','D','10','42',NULL,'drvEmpLTDCoverageBeginDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeLTDEndDate"','43','(''UD112''=''F'')','EDOENYLCONZ0','1','D','10','43',NULL,'drvEmployeeLTDEndDate',NULL,NULL);

INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotNumberofRecords"','1','(''UA''=''F'')','EDOENYLCONZ0','9','D','90','1',NULL,'drvTotNumberofRecords',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFiller"','2','(''UA''=''F'')','EDOENYLCONZ0','455','D','90','2',NULL,'drvFiller',NULL,NULL);

/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EDOENYLCON_20210903.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202107289','EMPEXPORT','OEACTIVE',NULL,'EDOENYLCON',NULL,NULL,NULL,'202107289','Jul 28 2021  7:05PM','Jul 28 2021  7:05PM','202107281',NULL,'','','202107281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202107289','EMPEXPORT','OEPASSIVE',NULL,'EDOENYLCON',NULL,NULL,NULL,'202107289','Jul 28 2021  7:05PM','Jul 28 2021  7:05PM','202107281',NULL,'','','202107281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','',NULL,NULL,NULL,NULL,'NYLife FMLA Export','202107289','EMPEXPORT','ONDEM_XOE',NULL,'EDOENYLCON',NULL,NULL,NULL,'202107289','Jul 28 2021  7:05PM','Jul 28 2021  7:05PM','202107281',NULL,'','','202107281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'NYLife FMLA Export-Sched','202107289','EMPEXPORT','SCH_EGODNY',NULL,'EDOENYLCON',NULL,NULL,NULL,'202107289','Jul 28 2021  7:05PM','Jul 28 2021  7:05PM','202107281',NULL,'','','202107281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'NYLife FMLA Export-Test','202109029','EMPEXPORT','TEST_XOE','Sep  2 2021  8:13AM','EDOENYLCON',NULL,NULL,NULL,'202109029','Sep  2 2021 12:00AM','Dec 30 1899 12:00AM','202108191','1682','','','202108191',dbo.fn_GetTimedKey(),NULL,'us3lKiGOO1026',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDOENYLCON','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDOENYLCON','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDOENYLCON','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDOENYLCON','SubSort','C','drvSubSort');
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
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvEmployeeSSN] char(11) NULL,
    [drvEmployeeIdentificationNumber] char(9) NULL,
    [drvReserved_Emp] varchar(1) NOT NULL,
    [drvEligibilityBillingLocation] varchar(1) NOT NULL,
    [drvNewYorkLifeInternalCompanyNumber] varchar(9) NOT NULL,
    [drvEmployeeGroupNumberID] varchar(9) NOT NULL,
    [drvEmployeeClassCode] varchar(1) NOT NULL,
    [drvClassChangeEffectiveDate] varchar(1) NOT NULL,
    [drvReserved_Emp2] varchar(1) NOT NULL,
    [drvEmployeeLastName] varchar(100) NULL,
    [drvEmployeeFirstName] varchar(100) NULL,
    [drvEmployeeMiddleName] varchar(50) NULL,
    [drvEmployeeNamePrefix] varchar(1) NOT NULL,
    [drvEmployeeNameSuffix] varchar(30) NULL,
    [drvEmployeeDateofBirth] datetime NULL,
    [drvEmployeeGender] char(1) NULL,
    [drvEmployeeMaritalStatus] varchar(1) NOT NULL,
    [drvEmployeesPINNumber] varchar(1) NOT NULL,
    [drvEmployeeSmokerStatus] varchar(1) NOT NULL,
    [drvEmployeeEmailAddress] varchar(1) NOT NULL,
    [drvReserved_Emp3] varchar(1) NOT NULL,
    [drvSupplementalEmailAddress1] varchar(1) NOT NULL,
    [drvEmail1Type] varchar(1) NOT NULL,
    [drvSupplementalEmailAddress2] varchar(1) NOT NULL,
    [drvEmail2Type] varchar(1) NOT NULL,
    [drvEmployeeMailAddress1] varchar(255) NULL,
    [drvEmployeeMailAddress2] varchar(255) NULL,
    [drvEmployeeMailCity] varchar(255) NULL,
    [drvEmployeeMailState] varchar(255) NULL,
    [drvEmployeeMailZipCode] varchar(50) NULL,
    [drvEmployeeCountry] varchar(2) NOT NULL,
    [drvCountryCode] varchar(2) NOT NULL,
    [drvEmployeeResidenceState] varchar(1) NOT NULL,
    [drvProvince] varchar(1) NOT NULL,
    [drvTypeofAddress] varchar(1) NOT NULL,
    [drvEffectiveDateoftheAddress] varchar(1) NOT NULL,
    [drvPhoneNumber] varchar(50) NULL,
    [drvPhoneUsagecode] varchar(1) NOT NULL,
    [drvReserved_Emp4] varchar(1) NOT NULL,
    [drvReserved_Emp5] varchar(1) NOT NULL,
    [drvEmploymentStatusCode] varchar(2) NULL,
    [drvEmployeeStatusEffectiveDate] datetime NULL,
    [drvEmployeeType] varchar(1) NOT NULL,
    [drvEmployeeDateofHire] datetime NULL,
    [drvAdjustedServiceDate] varchar(1) NOT NULL,
    [drvEmployeeWorksiteLocation] varchar(1) NOT NULL,
    [drvEmployeeAnnualSalaryforLifeBenefit] varchar(1) NOT NULL,
    [drvModeForDisabilityEarnings] varchar(1) NOT NULL,
    [drvEmployeeEarningsforDisabilityProducts] varchar(30) NULL,
    [drvLastEarningsChangeDate] varchar(1) NOT NULL,
    [drvSalariedIndicator] varchar(1) NOT NULL,
    [drvFullTimeIndicator] varchar(1) NOT NULL,
    [drvCommissionBonusIndicator] varchar(1) NOT NULL,
    [drvWorkAtHomeIndicator] varchar(1) NOT NULL,
    [drvExemptIndicator] varchar(1) NOT NULL,
    [drvNumberofHoursWorkedPerWeek] varchar(30) NULL,
    [drvTaxFilingStateCode] varchar(255) NULL,
    [drvOccupationClassificationCode] varchar(1) NOT NULL,
    [drvJobDescription] varchar(1) NOT NULL,
    [drvCompanyJobCode] varchar(1) NOT NULL,
    [drvOrganizationName] varchar(6000) NULL,
    [drvClientOrganizationCode] char(6) NULL,
    [drvClientLocationCode] varchar(1) NOT NULL,
    [drvUnionLocalNumber] varchar(1) NOT NULL,
    [drvUnionLocalName] varchar(1) NOT NULL,
    [drvUnionIndicator] varchar(1) NOT NULL,
    [drvHealthPlanType] varchar(1) NOT NULL,
    [drvHealthPlanDescription] varchar(1) NOT NULL,
    [drvAccruedSickTime] varchar(1) NOT NULL,
    [drvKeyEmployeeIndicator] varchar(1) NOT NULL,
    [drvActualAnnualHours] varchar(30) NULL,
    [drvWorkState] varchar(255) NULL,
    [drvReservedEmp_6] varchar(1) NOT NULL,
    [drvMaintenanceReasonCode] varchar(1) NOT NULL,
    [drvMaintenanceDate] varchar(1) NOT NULL,
    [drvSpouseSSN] varchar(1) NOT NULL,
    [drvSpouseLastName] varchar(1) NOT NULL,
    [drvSpouseFirstName] varchar(1) NOT NULL,
    [drvSpouseMiddleName] varchar(1) NOT NULL,
    [drvSpouseNamePrefix] varchar(1) NOT NULL,
    [drvSpouseNameSuffix] varchar(1) NOT NULL,
    [drvSpouseDateofBirth] varchar(1) NOT NULL,
    [drvSpouseGender] varchar(1) NOT NULL,
    [drvSpouseSmokerStatus] varchar(1) NOT NULL,
    [drvReserved_Emp7] varchar(1) NOT NULL,
    [drvNumberofproducts] varchar(2) NOT NULL,
    [drvCoveragecode1] varchar(4) NOT NULL,
    [drvReserved1_1] varchar(1) NOT NULL,
    [drvPolicySymbol1] varchar(4) NOT NULL,
    [drvPolicyNumber1] varchar(7) NOT NULL,
    [drvOriginalBenefitEffDate1] varchar(1) NOT NULL,
    [drvIssuedBenefitsPercent1] varchar(1) NOT NULL,
    [drvIssuedBenefitsAmount1] varchar(1) NOT NULL,
    [drvEmployeeContribPercent1] varchar(1) NOT NULL,
    [drvVoluntaryBenefitEffDate1] varchar(1) NOT NULL,
    [drvPostTaxIndicator1] varchar(1) NOT NULL,
    [drvBenefitDescription1] varchar(1) NOT NULL,
    [drvReserved1_2] varchar(1) NOT NULL,
    [drvCoveragecode2] varchar(3) NULL,
    [drvReserved2_1] varchar(1) NOT NULL,
    [drvPolicySymbol2] varchar(2) NULL,
    [drvPolicyNumber2] varchar(7) NULL,
    [drvOriginalBenefitEffDate2] datetime NULL,
    [drvIssuedBenefitsPercent2] varchar(5) NULL,
    [drvIssuedBenefitsAmount2] varchar(1) NOT NULL,
    [drvEmployeeContribPercent2] varchar(5) NULL,
    [drvVoluntaryBenefitEffDate2] varchar(1) NOT NULL,
    [drvPostTaxIndicator2] varchar(1) NULL,
    [drvBenefitDescription2] varchar(1) NOT NULL,
    [drvReserved2_2] varchar(1) NOT NULL,
    [drvCoveragecode3] varchar(3) NULL,
    [drvReserved3_1] varchar(1) NOT NULL,
    [drvPolicySymbol3] varchar(2) NULL,
    [drvPolicyNumber3] varchar(7) NULL,
    [drvOriginalBenefitEffDate3] datetime NULL,
    [drvIssuedBenefitsPercent3] varchar(5) NULL,
    [drvIssuedBenefitsAmount3] varchar(1) NOT NULL,
    [drvEmployeeContribPercent3] varchar(5) NULL,
    [drvVoluntaryBenefitEffDate3] varchar(1) NOT NULL,
    [drvPostTaxIndicator3] varchar(1) NULL,
    [drvBenefitDescription3] varchar(1) NOT NULL,
    [drvReserved3_2] varchar(1) NOT NULL,
    [drvCoveragecode4] varchar(1) NOT NULL,
    [drvReserved4_1] varchar(1) NOT NULL,
    [drvPolicySymbol4] varchar(1) NOT NULL,
    [drvPolicyNumber4] varchar(1) NOT NULL,
    [drvOriginalBenefitEffDate4] varchar(1) NOT NULL,
    [drvIssuedBenefitsPercent4] varchar(1) NOT NULL,
    [drvIssuedBenefitsAmount4] varchar(1) NOT NULL,
    [drvEmployeeContribPercent4] varchar(1) NOT NULL,
    [drvVoluntaryBenefitEffDate4] varchar(1) NOT NULL,
    [drvPostTaxIndicator4] varchar(1) NOT NULL,
    [drvBenefitDescription4] varchar(1) NOT NULL,
    [drvReserved4_2] varchar(1) NOT NULL,
    [drvNumberofProducts_2] varchar(1) NOT NULL,
    [drvProductCode] varchar(1) NOT NULL,
    [drvPolicySymbol] varchar(1) NOT NULL,
    [drvPolicyNumber] varchar(1) NOT NULL,
    [drvAssignmentIndicator] varchar(1) NOT NULL,
    [drvEmployeePreviousAmount] varchar(1) NOT NULL,
    [drvEmpPreviousSalaryMultiple] varchar(1) NOT NULL,
    [drvSpousePreviousAmount] varchar(1) NOT NULL,
    [drvChildPreviousAmount] varchar(1) NOT NULL,
    [drvEmployeeIssuedAmount] varchar(1) NOT NULL,
    [drvEmpIssuedSalaryMultiple] varchar(1) NOT NULL,
    [drvSpouseIssuedAmount] varchar(1) NOT NULL,
    [drvChildIssuedAmount] varchar(1) NOT NULL,
    [drvEmployeeAppliedAmount] varchar(1) NOT NULL,
    [drvEmpAppliedSalaryMultiple] varchar(1) NOT NULL,
    [drvSpouseAppliedAmount] varchar(1) NOT NULL,
    [drvChildAppliedAmount] varchar(1) NOT NULL,
    [drvEmployeePendingAmount] varchar(1) NOT NULL,
    [drvEmpPendingSalaryMultiple] varchar(1) NOT NULL,
    [drvSpousePendingAmount] varchar(1) NOT NULL,
    [drvChildPendingAmount] varchar(1) NOT NULL,
    [drvEmpMonthlyCashAccuFundAmt] varchar(1) NOT NULL,
    [drvSpsMonthlyCashAccFundAmt] varchar(1) NOT NULL,
    [drvEmployeeAIOIndicator] varchar(1) NOT NULL,
    [drvEmployeeADDADBIndicator] varchar(1) NOT NULL,
    [drvSpouseADDADBIndicator] varchar(1) NOT NULL,
    [drvEmployeeAPBIndicator] varchar(1) NOT NULL,
    [drvSpouseAPBIndicator] varchar(1) NOT NULL,
    [drvPAIplanoption] varchar(1) NOT NULL,
    [drvReserved] varchar(1) NOT NULL,
    [drvHWDeduction01] varchar(1) NOT NULL,
    [drvHWDeduction02] varchar(1) NOT NULL,
    [drvHWDeduction03] varchar(1) NOT NULL,
    [drvHWDeduction04] varchar(1) NOT NULL,
    [drvHWDeduction05] varchar(1) NOT NULL,
    [drvHWDeduction06] varchar(1) NOT NULL,
    [drvHWDeduction07] varchar(1) NOT NULL,
    [drvHWDeduction08] varchar(1) NOT NULL,
    [drvHWDeduction09] varchar(1) NOT NULL,
    [drvHWDeduction10] varchar(1) NOT NULL,
    [drvHWDeduction11] varchar(1) NOT NULL,
    [drvHWDeduction12] varchar(1) NOT NULL,
    [drvReserved_Emp8] varchar(1) NOT NULL,
    [drvExtendedEmpEmailAddress] varchar(50) NULL,
    [drvExtendedSuppEmailAddress2] varchar(1) NOT NULL,
    [drvExtSuppllEmailAddress1] varchar(1) NOT NULL
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
    [Data] varchar(3000) NULL
);
IF OBJECT_ID('U_EDOENYLCON_Header') IS NULL
CREATE TABLE [dbo].[U_EDOENYLCON_Header] (
    [drvFileRecordIdentifier] varchar(2) NOT NULL,
    [drvDUNSNumber] varchar(9) NOT NULL,
    [drvProductionTestIndicator] varchar(1) NULL,
    [drvFileCreationDate] datetime NOT NULL,
    [drvEmployerName] varchar(25) NOT NULL,
    [drvFileType] varchar(1) NOT NULL,
    [drvLifeAccidentFileMaintenanceReasonType] varchar(1) NOT NULL,
    [drvDisabilityFileMaintenanceReasonType] varchar(1) NOT NULL,
    [drvReserved] varchar(1) NOT NULL
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
    [drvFileRecordIdentifier] varchar(2) NOT NULL,
    [drvDUNSNumber] varchar(9) NOT NULL,
    [drvReserved] varchar(1) NOT NULL,
    [drvNumberofRecords] varchar(30) NULL,
    [drvReserved2] varchar(1) NOT NULL
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
Create Date: 09/14/2021
Service Request Number: TekP-2021-08-10-0002

Purpose: NYLife Port and Convertion

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
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDOENYLCON', 'SCH_EGODNY';

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
            ,@EndPerControl     VARCHAR(9)
            ,@Last52WeekPerControl as VARCHAR(10) ;

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


    SELECT @Last52WeekPerControl =  CONVERT(VARCHAR(12),DATEADD(week,-52, @StartDate),112) + '1'
    PRINT 'Last 52 Weeks ' + @Last52WeekPerControl
    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EDOENYLCON_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EDOENYLCON_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_EDOENYLCON_EEList
    WHERE  xEEID IN (    Select distinct eeceeid from dbo.EmpComp where eeceetype = 'TES' );

    DELETE FROM dbo.U_EDOENYLCON_EEList
    WHERE  xEEID IN (    Select distinct eeceeid from dbo.EmpComp where     eeceeid in ('BY26UH0000K0','CQ5FQX000040','BY0TF50050K0','CFS9WW0000K0','CQ5BQW000040','CHJAP4000040','CHJAC5000040'));

      DELETE FROM dbo.U_EDOENYLCON_EEList
    WHERE  xEEID IN (    Select eeceeid from dbo.EmpComp WHERE eecpaygroup = 'SCS030');
    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'GLIFE,AADD,ALFE2,ALFE3,ALFE4,ALFE5,ALFE6,LIFS1,LISF2,LISF3,LISF4,LISF5,LIFC1,ALIFC,ADDE1,EADD1,EADD2,EADD3,EADD4,EADD5,ADDS1,ADDS2,ADDS3,ADDS4,ADDS5,ADDC1';

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
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >=  @Last52WeekPerControl and PehPerControl <= @StartPerControl  and pehEarnCode in ('DT', 'HOL', 'HTR', 'JURY', 'MTGS', 'ORIEN', 'OT', 'OTTMP', 'REG', 'SOT', 'TRAIN', 'WKLRN') THEN PehCurHrs ELSE 0.00 END)
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
    WHERE  PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;

    
    --Audit Table
    IF OBJECT_ID('U_EDOENYLCONAuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EDOENYLCONAuditFields;
    CREATE TABLE dbo.U_EDOENYLCONAuditFields (aTableName varchar(128),aFieldName varchar(128));
    
    -- Insert tables/fields to be audited
    INSERT INTO dbo.U_EDOENYLCONAuditFields VALUES ('EmpComp','EecEmplStatus');    
    
    -- Create audit table
    IF OBJECT_ID('U_EDOENYLCONAudit','U') IS NOT NULL
        DROP TABLE dbo.U_EDOENYLCONAudit;
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
    INTO dbo.U_EDOENYLCONAudit
    FROM (SELECT *
          FROM dbo.AuditRecords WITH (NOLOCK)
          WHERE adrTableName IN (SELECT aTableName FROM dbo.U_EDOENYLCONAuditFields WITH (NOLOCK))) ADR
    JOIN (SELECT *
          FROM dbo.AuditFields WITH (NOLOCK)
          WHERE adfFieldName IN (SELECT aFieldName FROM dbo.U_EDOENYLCONAuditFields WITH (NOLOCK))) ADF
        ON adrSystemID = adfSystemID
       AND adrKey = adfKey
    WHERE adrType IN (1,2,5,6) -- Insert/Update; remove this to include Deletes and Viewed
      AND adrProcessedDateTime BETWEEN @StartDate AND @EndDate;
    
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EDOENYLCONAudit ON dbo.U_EDOENYLCONAudit (audKey1Value, audKey2Value);

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
        -- standard fields above and additional driver fields below
        ,drvInitialSort = eepssn
        ,drvSubSort = ''
        ,drvEmployeeSSN = eepSSN
        ,drvEmployeeIdentificationNumber = EecEmpNo
        ,drvReserved_Emp = ''
        ,drvEligibilityBillingLocation = ''
        ,drvNewYorkLifeInternalCompanyNumber = '000482065'
        ,drvEmployeeGroupNumberID = '000025699'
        ,drvEmployeeClassCode = ''
        ,drvClassChangeEffectiveDate = ''
        ,drvReserved_Emp2 = ''
        ,drvEmployeeLastName = EepNameLast
        ,drvEmployeeFirstName = EepNameFirst
        ,drvEmployeeMiddleName = EepNameMiddle
        ,drvEmployeeNamePrefix = ''
        ,drvEmployeeNameSuffix = NULLIF(EepNameSuffix,'Z')
        ,drvEmployeeDateofBirth = EepDateOfBirth
        ,drvEmployeeGender = EepGender
        ,drvEmployeeMaritalStatus =   CASE WHEN eepMaritalStatus = 'D' THEN 'D'
            WHEN eepMaritalStatus = 'M' THEN 'M'
            WHEN eepMaritalStatus = 'S' THEN 'I'
            WHEN eepMaritalStatus = 'W' THEN 'W'
            else  'K'
        END
        ,drvEmployeesPINNumber = ''
        ,drvEmployeeSmokerStatus = ''
        ,drvEmployeeEmailAddress = ''
        ,drvReserved_Emp3 = ''
        ,drvSupplementalEmailAddress1 = ''
        ,drvEmail1Type = ''
        ,drvSupplementalEmailAddress2 = ''
        ,drvEmail2Type = ''
        ,drvEmployeeMailAddress1 = EepAddressLine1
        ,drvEmployeeMailAddress2 = EepAddressLine2
        ,drvEmployeeMailCity = EepAddressCity
        ,drvEmployeeMailState = EepAddressState
        ,drvEmployeeMailZipCode = CASE WHEN LEN (EepAddressZipCode) <= 5 then EepAddressZipCode ELSE LEFT(EepAddressZipCode,5) + '-' + RIGHT(EepAddressZipCode,4) END
        ,drvEmployeeCountry = 'US'
        ,drvCountryCode = 'US'
        ,drvEmployeeResidenceState = ''
        ,drvProvince = ''
        ,drvTypeofAddress = 'R'
        ,drvEffectiveDateoftheAddress = ''
        ,drvPhoneNumber = EepPhoneHomeNumber
        ,drvPhoneUsagecode = 'R'
        ,drvReserved_Emp4 = ''
        ,drvReserved_Emp5 = ''
        ,drvEmploymentStatusCode = CASE WHEN EecEmplStatus = 'L' THEN 'L1'
                                        WHEN EecEmplStatus = 'T' THEN
                                            CASE WHEN EecTermReason = '202' THEN 'RT'
                                                 WHEN EecTermReason = '203' THEN 'DI'
                                                 WHEN EecTermReason not in  ('202','203') THEN 'TE'
                                            END
                                        ELSE 'AC'
                                   END
        ,drvEmployeeStatusEffectiveDate = CASE WHEN EecEmplStatus = 'T'  THEN EecDateOfTermination
                                            WHEN EecEmplStatus = 'L'  THEN  EecEmplStatusStartDate
                                    END
        ,drvEmployeeType = CASE WHEN EecEEType = 'REG' THEN 'P' ELSE 'T' END
        ,drvEmployeeDateofHire = eecDateofLastHire
        ,drvAdjustedServiceDate = ''
        ,drvEmployeeWorksiteLocation = ''
        ,drvEmployeeAnnualSalaryforLifeBenefit = ''
        ,drvModeForDisabilityEarnings = 'H'
        ,drvEmployeeEarningsforDisabilityProducts = CONVERT(VARCHAR,dbo.dsi_fnPadZero(EjhHourlyPayRate*100,9,0)) 
        ,drvLastEarningsChangeDate = ''
        ,drvSalariedIndicator = CASE WHEN EecSalaryOrHourly = 'S' THEN 'Y' ELSE 'N' END
        ,drvFullTimeIndicator = CASE WHEN EecFullTimeOrPartTime = 'FT' THEN 'Y' ELSE  'N' END
        ,drvCommissionBonusIndicator = ''
        ,drvWorkAtHomeIndicator = ''
        ,drvExemptIndicator = CASE WHEN JobHist.EjhFLSACategory = 'E' THEN 'Y' ELSE 'N' END
        ,drvNumberofHoursWorkedPerWeek = CONVERT(VARCHAR,dbo.dsi_fnPadZero((EecScheduledWorkHrs /2) *100 ,5,0)) 
        ,drvTaxFilingStateCode = EepAddressState
        ,drvOccupationClassificationCode = ''
        ,drvJobDescription = ''
        ,drvCompanyJobCode = ''
        ,drvOrganizationName = dbo.dsi_fnRemoveChars('.,',UPPER(cmpcompanyname))
        ,drvClientOrganizationCode = EECPAYGROUP
        ,drvClientLocationCode = ''
        ,drvUnionLocalNumber = ''
        ,drvUnionLocalName = ''
        ,drvUnionIndicator = 'N'
        ,drvHealthPlanType = ''
        ,drvHealthPlanDescription = ''
        ,drvAccruedSickTime = ''
        ,drvKeyEmployeeIndicator = ''
        --Here
        ,drvActualAnnualHours = CONVERT(VARCHAR,dbo.dsi_fnPadZero( CONVERT(DECIMAL(4,0),pehCurHrs),4,0))  
        ,drvWorkState = (Select LocAddressState from dbo.Location where LocCode = EecLocation)
        ,drvReservedEmp_6 = ''
        ,drvMaintenanceReasonCode = ''
        ,drvMaintenanceDate = ''
        ,drvSpouseSSN = ''
        ,drvSpouseLastName = ''
        ,drvSpouseFirstName = ''
        ,drvSpouseMiddleName = ''
        ,drvSpouseNamePrefix = ''
        ,drvSpouseNameSuffix = ''
        ,drvSpouseDateofBirth = ''
        ,drvSpouseGender = ''
        ,drvSpouseSmokerStatus = ''
        ,drvReserved_Emp7 = ''
        ,drvNumberofproducts = '03'
        ,drvCoveragecode1 = 'FMLA'
        ,drvReserved1_1 = ''
        ,drvPolicySymbol1 = 'FMLA'
        ,drvPolicyNumber1 = '0752802'
        ,drvOriginalBenefitEffDate1 = ''
        ,drvIssuedBenefitsPercent1 = ''
        ,drvIssuedBenefitsAmount1 = ''
        ,drvEmployeeContribPercent1 = ''
        ,drvVoluntaryBenefitEffDate1 = ''
        ,drvPostTaxIndicator1 = ''
        ,drvBenefitDescription1 = ''
        ,drvReserved1_2 = ''
        ,drvCoveragecode2 = CASE WHEN STD is not null THEN 'STD' END
        ,drvReserved2_1 = ''
        ,drvPolicySymbol2 =  CASE WHEN STD is not null THEN 'LK' END
        ,drvPolicyNumber2 =  CASE WHEN STD is not null THEN '0752802' END
        ,drvOriginalBenefitEffDate2 = CASE WHEN STD is not null THEN STD_STARTDATE END
        ,drvIssuedBenefitsPercent2 = CASE WHEN STD is not null THEN '06000' END
        ,drvIssuedBenefitsAmount2 = ''
        ,drvEmployeeContribPercent2 = CASE WHEN STD is not null THEN '00000' END
        ,drvVoluntaryBenefitEffDate2 = ''
        ,drvPostTaxIndicator2 = CASE WHEN STD is not null THEN 'N' END
        ,drvBenefitDescription2 = ''
        ,drvReserved2_2 = ''
        ,drvCoveragecode3 = CASE WHEN LTD is not null THEN 'LTD' END
        ,drvReserved3_1 = ''
        ,drvPolicySymbol3 = CASE WHEN LTD is not null THEN 'LK' END
        ,drvPolicyNumber3 = CASE WHEN LTD is not null THEN '0966503' END
        ,drvOriginalBenefitEffDate3 = CASE WHEN LTD is not null THEN LTD_STARTDATE END
        ,drvIssuedBenefitsPercent3 = CASE WHEN LTD is not null THEN '06000' END
        ,drvIssuedBenefitsAmount3 = ''
        ,drvEmployeeContribPercent3 = CASE WHEN LTD is not null THEN '00000' END
        ,drvVoluntaryBenefitEffDate3 = ''
        ,drvPostTaxIndicator3 = CASE WHEN LTD is not null THEN 'N' END
        ,drvBenefitDescription3 = ''
        ,drvReserved3_2 = ''
        ,drvCoveragecode4 = ''
        ,drvReserved4_1 = ''
        ,drvPolicySymbol4 = ''
        ,drvPolicyNumber4 = ''
        ,drvOriginalBenefitEffDate4 = ''
        ,drvIssuedBenefitsPercent4 = ''
        ,drvIssuedBenefitsAmount4 = ''
        ,drvEmployeeContribPercent4 = ''
        ,drvVoluntaryBenefitEffDate4 = ''
        ,drvPostTaxIndicator4 = ''
        ,drvBenefitDescription4 = ''
        ,drvReserved4_2 = ''
        ,drvNumberofProducts_2 = ''
        ,drvProductCode = ''
        ,drvPolicySymbol = ''
        ,drvPolicyNumber = ''
        ,drvAssignmentIndicator = ''
        ,drvEmployeePreviousAmount = ''
        ,drvEmpPreviousSalaryMultiple = ''
        ,drvSpousePreviousAmount = ''
        ,drvChildPreviousAmount = ''
        ,drvEmployeeIssuedAmount = ''
        ,drvEmpIssuedSalaryMultiple = ''
        ,drvSpouseIssuedAmount = ''
        ,drvChildIssuedAmount = ''
        ,drvEmployeeAppliedAmount = ''
        ,drvEmpAppliedSalaryMultiple = ''
        ,drvSpouseAppliedAmount = ''
        ,drvChildAppliedAmount = ''
        ,drvEmployeePendingAmount = ''
        ,drvEmpPendingSalaryMultiple = ''
        ,drvSpousePendingAmount = ''
        ,drvChildPendingAmount = ''
        ,drvEmpMonthlyCashAccuFundAmt = ''
        ,drvSpsMonthlyCashAccFundAmt = ''
        ,drvEmployeeAIOIndicator = ''
        ,drvEmployeeADDADBIndicator = ''
        ,drvSpouseADDADBIndicator = ''
        ,drvEmployeeAPBIndicator = ''
        ,drvSpouseAPBIndicator = ''
        ,drvPAIplanoption = ''
        ,drvReserved = ''
        ,drvHWDeduction01 = ''
        ,drvHWDeduction02 = ''
        ,drvHWDeduction03 = ''
        ,drvHWDeduction04 = ''
        ,drvHWDeduction05 = ''
        ,drvHWDeduction06 = ''
        ,drvHWDeduction07 = ''
        ,drvHWDeduction08 = ''
        ,drvHWDeduction09 = ''
        ,drvHWDeduction10 = ''
        ,drvHWDeduction11 = ''
        ,drvHWDeduction12 = ''
        ,drvReserved_Emp8 = ''
        ,drvExtendedEmpEmailAddress = CASE WHEN isnull(eepaddressemailalternate,'') <> '' THEN eepaddressemailalternate 
                                         WHEN isnull(EepAddressEMail,'') <> '' THEN EepAddressEMail 
                                        ELSE 'leave@goodwillky.org'
                                    END
        ,drvExtendedSuppEmailAddress2 = ''
        ,drvExtSuppllEmailAddress1 = ''
    INTO dbo.U_EDOENYLCON_drvTbl
    FROM dbo.U_EDOENYLCON_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
         and (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                                        and EXISTS(select 1 from dbo.U_EDOENYLCONAudit where  audKey1Value = xEEID AND audKey2Value = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    JOIN dbo.Company WITH (NOLOCK)
        on cmpcoid = xcoid
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    LEFT JOIN (Select  bdmEEID,bdmcoid
            ,STD = MAX((CASE WHEN bdmDedCode IN('STD') then bdmDedCode END))
            ,LTD = MAX((CASE WHEN bdmDedCode IN('LTD')   then bdmDedCode END))
            ,STD_STARTDATE = MAX((CASE WHEN bdmDedCode IN('STD')   then BdmBenStartDate END))
            ,LTD_STARTDATE = MAX((CASE WHEN bdmDedCode IN('LTD')   then BdmBenStartDate END))
            ,STD_STOPDATE = MAX((CASE WHEN bdmDedCode IN('STD')  then BdmBenStopDate END))
            ,LTD_STOPDATE = MAX((CASE WHEN bdmDedCode IN('LTD')  then BdmBenStopDate END))
            from U_dsi_BDM_EDOENYLCON WITH (NOLOCK) 
            group by bdmEEID,bdmcoid) as BdmConsolidated
        ON xEEID =  bdmEEID 
        AND XCOID = bdmCOID
    LEFT JOIN dbo.U_EDOENYLCON_PEarHist
        on PehEEID =  xeeid
    LEFT JOIN (Select * from  (
Select EjhHourlyPayRate,EjhFLSACategory,Ejheeid,ROW_NUMBER() OVER(PARTITION BY ejheeid ORDER BY auditkey DESC) as Row_Num from dbo.EmphJob WITH (NOLOCK)
) A where Row_Num = 1) as JobHist
    on JobHist.ejheeid = xeeid
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EDOENYLCON_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EDOENYLCON_Header;
    SELECT DISTINCT
         drvFileRecordIdentifier = 'HD'
        ,drvDUNSNumber = '024059438'
        ,drvProductionTestIndicator = CASE WHEN @ExportCode LIKE 'TEST%' THEN 'T' END
        ,drvFileCreationDate = GETDATE()
        ,drvEmployerName = 'Goodwill Industries of KY'
        ,drvFileType = '2'
        ,drvLifeAccidentFileMaintenanceReasonType = ''
        ,drvDisabilityFileMaintenanceReasonType = '2'
        ,drvReserved = ''
    INTO dbo.U_EDOENYLCON_Header
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EDOENYLCON_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_EDOENYLCON_Trailer;
    SELECT DISTINCT
         drvFileRecordIdentifier = 'TR'
        ,drvDUNSNumber = '024059438'
        ,drvReserved = ''
        ,drvNumberofRecords = CAST( (Select count(*) from dbo.U_EDOENYLCON_drvTbl) as varchar)
        ,drvReserved2 = ''
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
    SET expLastStartPerControl = '202107211'
       ,expStartPerControl     = '202107211'
       ,expLastEndPerControl   = '202107289'
       ,expEndPerControl       = '202107289'
WHERE expFormatCode = 'EDOENYLCON';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEDOENYLCON_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EDOENYLCON_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort