SET NOCOUNT ON;
IF OBJECT_ID('U_EPRU401K72_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EPRU401K72_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EPRU401K72_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EPRU401K72' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEPRU401K72_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEPRU401K72_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EPRU401K72') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EPRU401K72];
GO
IF OBJECT_ID('U_EPRU401K72_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EPRU401K72_Trailer];
GO
IF OBJECT_ID('U_EPRU401K72_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EPRU401K72_PEarHist];
GO
IF OBJECT_ID('U_EPRU401K72_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EPRU401K72_PDedHist];
GO
IF OBJECT_ID('U_EPRU401K72_Header') IS NOT NULL DROP TABLE [dbo].[U_EPRU401K72_Header];
GO
IF OBJECT_ID('U_EPRU401K72_File') IS NOT NULL DROP TABLE [dbo].[U_EPRU401K72_File];
GO
IF OBJECT_ID('U_EPRU401K72_EEList') IS NOT NULL DROP TABLE [dbo].[U_EPRU401K72_EEList];
GO
IF OBJECT_ID('U_EPRU401K72_drvTbl2') IS NOT NULL DROP TABLE [dbo].[U_EPRU401K72_drvTbl2];
GO
IF OBJECT_ID('U_EPRU401K72_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EPRU401K72_drvTbl];
GO
IF OBJECT_ID('U_EPRU401K72_DedList') IS NOT NULL DROP TABLE [dbo].[U_EPRU401K72_DedList];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EPRU401K72';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EPRU401K72';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EPRU401K72';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EPRU401K72';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EPRU401K72';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EPRU401K72','Prudential 401K 006772 V2','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','800','S','N','EPRU401K72Z0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EPRU401K72' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRECORDTYPE"','1','(''UA''=''F'')','EPRU401K72Z0','3','H','01','1',NULL,'RECORDTYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFILETYPE"','2','(''UA''=''F'')','EPRU401K72Z0','10','H','01','4',NULL,'FILETYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCLIENTIDENTIFIER"','3','(''UA''=''F'')','EPRU401K72Z0','10','H','01','14',NULL,'CLIENTIDENTIFIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFILECREATIONDATE"','4','(''UD112''=''F'')','EPRU401K72Z0','8','H','01','24',NULL,'FILECREATIONDATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFILECREATIONTIME"','5','(''UA''=''F'')','EPRU401K72Z0','6','H','01','32',NULL,'FILECREATIONTIME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSENDER"','6','(''UA''=''F'')','EPRU401K72Z0','1','H','01','38',NULL,'SENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFILEFORMATTYPE"','7','(''UA''=''F'')','EPRU401K72Z0','3','H','01','39',NULL,'FILEFORMATTYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''SS''=''F'')','EPRU401K72Z0','660','H','01','42',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTRANSACTIONCODE"','1','(''UA''=''F'')','EPRU401K72Z0','3','D','10','1',NULL,'TRANSACTIONCODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','2','(''SS''=''F'')','EPRU401K72Z0','2','D','10','4',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPLANNUMBER"','3','(''UA''=''F'')','EPRU401K72Z0','6','D','10','6',NULL,'PLANNUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','4','(''SS''=''F'')','EPRU401K72Z0','3','D','10','12',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPARTICIPANTID"','5','(''UA''=''F'')','EPRU401K72Z0','9','D','10','15',NULL,'PARTICIPANTID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','6','(''SS''=''F'')','EPRU401K72Z0','11','D','10','24',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFULLPARTTIMEINDICATOR"','7','(''UA''=''F'')','EPRU401K72Z0','1','D','10','35',NULL,'FULLPARTTIMEINDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINVESTMENT1"','8','(''UA''=''F'')','EPRU401K72Z0','2','D','10','36',NULL,'INVESTMENT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSOURCE1"','9','(''UA''=''F'')','EPRU401K72Z0','1','D','10','38',NULL,'SOURCE1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCONTRIBUTIONAMOUNT1"','10','(''UNPN''=''F'')','EPRU401K72Z0','9','D','10','39',NULL,'CONTRIBUTIONAMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINVESTMENT2"','11','(''UA''=''F'')','EPRU401K72Z0','2','D','10','48',NULL,'INVESTMENT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSOURCE2"','12','(''UA''=''F'')','EPRU401K72Z0','1','D','10','50',NULL,'SOURCE2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCONTRIBUTIONAMOUNT2"','13','(''UNPN''=''F'')','EPRU401K72Z0','9','D','10','51',NULL,'CONTRIBUTIONAMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINVESTMENT3"','14','(''UA''=''F'')','EPRU401K72Z0','2','D','10','60',NULL,'INVESTMENT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSOURCE3"','15','(''UA''=''F'')','EPRU401K72Z0','1','D','10','62',NULL,'SOURCE3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCONTRIBUTIONAMOUNT3"','16','(''UNPN''=''F'')','EPRU401K72Z0','9','D','10','63',NULL,'CONTRIBUTIONAMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINVESTMENT4"','17','(''UA''=''F'')','EPRU401K72Z0','2','D','10','72',NULL,'INVESTMENT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSOURCE4"','18','(''UA''=''F'')','EPRU401K72Z0','1','D','10','74',NULL,'SOURCE4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCONTRIBUTIONAMOUNT4"','19','(''UNPN''=''F'')','EPRU401K72Z0','9','D','10','75',NULL,'CONTRIBUTIONAMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINVESTMENT5"','20','(''UA''=''F'')','EPRU401K72Z0','2','D','10','84',NULL,'INVESTMENT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSOURCE5"','21','(''UA''=''F'')','EPRU401K72Z0','1','D','10','86',NULL,'SOURCE5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCONTRIBUTIONAMOUNT5"','22','(''UNPN''=''F'')','EPRU401K72Z0','9','D','10','87',NULL,'CONTRIBUTIONAMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINVESTMENT6"','23','(''UA''=''F'')','EPRU401K72Z0','2','D','10','96',NULL,'INVESTMENT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSOURCE6"','24','(''UA''=''F'')','EPRU401K72Z0','1','D','10','98',NULL,'SOURCE6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCONTRIBUTIONAMOUNT6"','25','(''UNPN''=''F'')','EPRU401K72Z0','9','D','10','99',NULL,'CONTRIBUTIONAMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPAYPERIODENDDATE"','26','(''UD112''=''F'')','EPRU401K72Z0','8','D','10','108',NULL,'PAYPERIODENDDATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINSIDERTRADER"','27','(''UA''=''F'')','EPRU401K72Z0','1','D','10','116',NULL,'INSIDERTRADER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSUBPLANNUMBER"','28','(''UA''=''F'')','EPRU401K72Z0','4','D','10','117',NULL,'SUBPLANNUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNAME"','29','(''UA''=''F'')','EPRU401K72Z0','30','D','10','121',NULL,'NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvADDRESS1"','30','(''UA''=''F'')','EPRU401K72Z0','30','D','10','151',NULL,'ADDRESS1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvADDRESS2"','31','(''UA''=''F'')','EPRU401K72Z0','30','D','10','181',NULL,'ADDRESS2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCITY"','32','(''UA''=''F'')','EPRU401K72Z0','18','D','10','211',NULL,'CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSTATE"','33','(''UA''=''F'')','EPRU401K72Z0','2','D','10','229',NULL,'STATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZIPCODE"','34','(''UA''=''F'')','EPRU401K72Z0','9','D','10','231',NULL,'ZIPCODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDATEOFBIRTH"','35','(''UD112''=''F'')','EPRU401K72Z0','8','D','10','240',NULL,'DATEOFBIRTH',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvORIGINALDATEOFHIRE"','36','(''UD112''=''F'')','EPRU401K72Z0','8','D','10','248',NULL,'ORIGINALDATEOFHIRE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvADJUSTEDHIREDATE"','37','(''UD112''=''F'')','EPRU401K72Z0','8','D','10','256',NULL,'ADJUSTEDHIREDATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMARITALSTATUS"','38','(''UA''=''F'')','EPRU401K72Z0','1','D','10','264',NULL,'MARITALSTATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGENDERCODE"','39','(''UA''=''F'')','EPRU401K72Z0','1','D','10','265',NULL,'GENDERCODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEMPLOYEESTATUS"','40','(''UA''=''F'')','EPRU401K72Z0','2','D','10','266',NULL,'EMPLOYEESTATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEMPLOYEESTATUSDATE"','41','(''UD112''=''F'')','EPRU401K72Z0','8','D','10','268',NULL,'EMPLOYEESTATUSDATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPAYROLLFREQUENCY"','42','(''UA''=''F'')','EPRU401K72Z0','1','D','10','276',NULL,'PAYROLLFREQUENCY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','43','(''SS''=''F'')','EPRU401K72Z0','8','D','10','277',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDHOURSOFSERVICE"','44','(''UA''=''F'')','EPRU401K72Z0','6','D','10','285',NULL,'YTDHOURSOFSERVICE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCURRENTPAYPERIODHOURS"','45','(''UA''=''F'')','EPRU401K72Z0','6','D','10','291',NULL,'CURRENTPAYPERIODHOURS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','46','(''SS''=''F'')','EPRU401K72Z0','15','D','10','297',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCURELIGGROSSPAYS1"','47','(''UA''=''F'')','EPRU401K72Z0','15','D','10','312',NULL,'CURRENTELIGIBLEGROSSPAYSOURCE1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCURRENTPAYPERIODW2PAY"','48','(''UA''=''F'')','EPRU401K72Z0','11','D','10','327',NULL,'CURRENTPAYPERIODW2PAY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvANNIVERSARYDATE"','49','(''UD112''=''F'')','EPRU401K72Z0','8','D','10','338',NULL,'ANNIVERSARYDATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvANNIVERSARYHOURS"','50','(''UA''=''F'')','EPRU401K72Z0','6','D','10','346',NULL,'ANNIVERSARYHOURS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCHECKDATE"','51','(''UD112''=''F'')','EPRU401K72Z0','8','D','10','352',NULL,'CHECKDATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEMPLOYEEIDCODE"','52','(''UA''=''F'')','EPRU401K72Z0','13','D','10','360',NULL,'EMPLOYEEIDCODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDIVSUB"','53','(''UA''=''F'')','EPRU401K72Z0','4','D','10','373',NULL,'DIVSUB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEMPLOYERLOCATIONCODE"','54','(''UA''=''F'')','EPRU401K72Z0','10','D','10','377',NULL,'EMPLOYERLOCATIONCODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLOCATIONEFFECTIVEDATE"','55','(''UD112''=''F'')','EPRU401K72Z0','8','D','10','387',NULL,'LOCATIONEFFECTIVEDATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGROUPINDICATOR"','56','(''UA''=''F'')','EPRU401K72Z0','1','D','10','395',NULL,'GROUPINDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNEVERELIGIBLE"','57','(''UA''=''F'')','EPRU401K72Z0','10','D','10','396',NULL,'NEVERELIGIBLE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvELIGTOPARTINEESOURCES"','58','(''UA''=''F'')','EPRU401K72Z0','5','D','10','406',NULL,'ELIGIBLETOPARTICIPATEINEESOURCES',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvELIGTOPARTINERSOURCES"','59','(''UA''=''F'')','EPRU401K72Z0','5','D','10','411',NULL,'ELIGIBLETOPARTICIPATEINERSOURCES',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvELIGIBILITYDATE"','60','(''UD112''=''F'')','EPRU401K72Z0','8','D','10','416',NULL,'ELIGIBILITYDATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAUTOENROLLDECLINEINDICATOR"','61','(''UA''=''F'')','EPRU401K72Z0','1','D','10','424',NULL,'AUTOENROLLMENTDECLINEINDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDEFERRALRATEFORSOURCE1"','62','(''UA''=''F'')','EPRU401K72Z0','5','D','10','425',NULL,'DEFERRALRATEFORSOURCE1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','63','(''SS''=''F'')','EPRU401K72Z0','15','D','10','430',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCASHBONUS"','64','(''UA''=''F'')','EPRU401K72Z0','11','D','10','445',NULL,'CASHBONUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHCEINDICATOR"','65','(''UA''=''F'')','EPRU401K72Z0','1','D','10','456',NULL,'HCEINDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUNIONEMPLOYEE"','66','(''UA''=''F'')','EPRU401K72Z0','1','D','10','457',NULL,'UNIONEMPLOYEE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMARKETSALARY"','67','(''UA''=''F'')','EPRU401K72Z0','11','D','10','458',NULL,'MARKETSALARY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREHIREDATE"','68','(''UA''=''F'')','EPRU401K72Z0','8','D','10','469',NULL,'REHIREDATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCURPPGROSSPAY415HCE414COM"','69','(''UNPN''=''F'')','EPRU401K72Z0','15','D','10','477',NULL,'CURPPGROSSPAY415HCE414COMPENSATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','70','(''SS''=''F'')','EPRU401K72Z0','1','D','10','492',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDEFERRALPLANLIMITCOMP"','71','(''UNPN''=''F'')','EPRU401K72Z0','15','D','10','493',NULL,'DEFERRALPLANLIMITCOMPENSATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','72','(''SS''=''F'')','EPRU401K72Z0','1','D','10','508',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCURRENTELIGGROSSPAYSOURCE2"','73','(''UNPN''=''F'')','EPRU401K72Z0','15','D','10','509',NULL,'CURRENTELIGIBLEGROSSPAYSOURCE2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','74','(''SS''=''F'')','EPRU401K72Z0','1','D','10','524',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvADPCOMPENSATION"','75','(''UNPN''=''F'')','EPRU401K72Z0','15','D','10','525',NULL,'ADPCOMPENSATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','76','(''SS''=''F'')','EPRU401K72Z0','1','D','10','540',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCURRENTELIGGROSSPAYSOURCE3"','77','(''UNPN''=''F'')','EPRU401K72Z0','15','D','10','541',NULL,'CURRENTELIGIBLEGROSSPAYSOURCE3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','78','(''SS''=''F'')','EPRU401K72Z0','1','D','10','556',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvERMATCHCOMPENSATION"','79','(''UNPN''=''F'')','EPRU401K72Z0','15','D','10','557',NULL,'ERMATCHCOMPENSATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','80','(''SS''=''F'')','EPRU401K72Z0','1','D','10','572',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvACPCOMPENSATION"','81','(''UNPN''=''F'')','EPRU401K72Z0','11','D','10','573',NULL,'ACPCOMPENSATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','82','(''SS''=''F'')','EPRU401K72Z0','1','D','10','584',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEXCLUDEDCOMPENSATION"','83','(''UA''=''F'')','EPRU401K72Z0','11','D','10','585',NULL,'EXCLUDEDCOMPENSATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','84','(''SS''=''F'')','EPRU401K72Z0','1','D','10','596',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTOPHEAVY401aCOMPENSATION"','85','(''UNPN''=''F'')','EPRU401K72Z0','11','D','10','597',NULL,'TOPHEAVY401aCOMPENSATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','86','(''SS''=''F'')','EPRU401K72Z0','1','D','10','608',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEPOSTTAXCOMPENSATION"','87','(''UA''=''F'')','EPRU401K72Z0','11','D','10','609',NULL,'EEPOSTTAXCOMPENSATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','88','(''SS''=''F'')','EPRU401K72Z0','1','D','10','620',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSUBSTATUS"','89','(''UA''=''F'')','EPRU401K72Z0','2','D','10','621',NULL,'SUBSTATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','90','(''SS''=''F'')','EPRU401K72Z0','1','D','10','623',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSUBSTATUSDATE"','91','(''UD112''=''F'')','EPRU401K72Z0','8','D','10','624',NULL,'SUBSTATUSDATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPARTICIPANTSEMAILADDRESS"','92','(''UA''=''F'')','EPRU401K72Z0','40','D','10','632',NULL,'PARTICIPANTSEMAILADDRESS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','93','(''SS''=''F'')','EPRU401K72Z0','30','D','10','672',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWORKPHONE"','94','(''UA''=''F'')','EPRU401K72Z0','10','D','10','712',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHOMEPHONE"','95','(''UA''=''F'')','EPRU401K72Z0','10','D','10','722',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCELLPHONE"','96','(''UA''=''F'')','EPRU401K72Z0','10','D','10','732',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTRANSACTIONCODE"','1','(''UA''=''F'')','EPRU401K72Z0','3','D','20','1',NULL,'TRANSACTIONCODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','2','(''SS''=''F'')','EPRU401K72Z0','2','D','20','4',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPLANNUMBER"','3','(''UA''=''F'')','EPRU401K72Z0','6','D','20','6',NULL,'PLANNUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','4','(''SS''=''F'')','EPRU401K72Z0','3','D','20','12',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPARTICIPANTID"','5','(''UA''=''F'')','EPRU401K72Z0','9','D','20','15',NULL,'PARTICIPANTID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','6','(''SS''=''F'')','EPRU401K72Z0','7','D','20','24',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLOANNUMBER"','7','(''UA''=''F'')','EPRU401K72Z0','3','D','20','31',NULL,'LOANNUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''SS''=''F'')','EPRU401K72Z0','1','D','20','34',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLOANREPAYMENTAMOUNT"','9','(''UNPN''=''F'')','EPRU401K72Z0','9','D','20','35',NULL,'LOANREPAYMENTAMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''SS''=''F'')','EPRU401K72Z0','37','D','20','44',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSUBPLANNUMBER"','11','(''UA''=''F'')','EPRU401K72Z0','4','D','20','81',NULL,'SUBPLANNUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','12','(''SS''=''F'')','EPRU401K72Z0','617','D','20','85',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRECORDTYPE"','1','(''UA''=''F'')','EPRU401K72Z0','3','T','90','1',NULL,'RECORDTYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFILETYPE"','2','(''UA''=''F'')','EPRU401K72Z0','10','T','90','4',NULL,'FILETYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCLIENTIDENTIFIER"','3','(''UA''=''F'')','EPRU401K72Z0','10','T','90','14',NULL,'CLIENTIDENTIFIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFILECREATIONDATE"','4','(''UD112''=''F'')','EPRU401K72Z0','8','T','90','24',NULL,'FILECREATIONDATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFILECREATIONTIME"','5','(''UA''=''F'')','EPRU401K72Z0','6','T','90','32',NULL,'FILECREATIONTIME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDETAILRECORDCOUNT"','6','(''UA''=''F'')','EPRU401K72Z0','9','T','90','38',NULL,'DETAILRECORDCOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','7','(''SS''=''F'')','EPRU401K72Z0','1','T','90','47',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTOTALCONTRIBUTIONAMOUNT"','8','(''UNPN''=''F'')','EPRU401K72Z0','11','T','90','48',NULL,'TOTALCONTRIBUTIONAMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''SS''=''F'')','EPRU401K72Z0','1','T','90','59',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLOANREPAYMENTAMOUNT"','10','(''UNPN''=''F'')','EPRU401K72Z0','11','T','90','60',NULL,'LOANREPAYMENTAMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','11','(''SS''=''F'')','EPRU401K72Z0','631','T','90','71',NULL,'FILLER',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EPRU401K72_20200811.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Prudential 401K','202001249','EMPEXPORT','ONDEMAND','Feb 11 2020  4:49PM','EPRU401K72',NULL,NULL,NULL,'202001249','Jan 24 2020 12:00AM','Dec 30 1899 12:00AM','202001241','551','eecPayGroup','ICMWK,WEEKLY','202001241',dbo.fn_GetTimedKey(),NULL,'ULTI_WPWHLR',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Prudential 401K','202001249','EMPEXPORT','SCH_PR72E','Feb 11 2020  4:49PM','EPRU401K72',NULL,NULL,NULL,'202001249','Jan 24 2020 12:00AM','Dec 30 1899 12:00AM','202001241','551','eecPayGroup','ICMWK,WEEKLY','202001241',dbo.fn_GetTimedKey(),NULL,'ULTI_WPWHLR',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Prudential 401K','202007241','EMPEXPORT','TEST','Jul 28 2020  4:05PM','EPRU401K72',NULL,NULL,NULL,'202007241','Jul 24 2020 12:00AM','Jul 18 2020 12:00AM','202007241','485','eecPayGroup','ICMWK,WEEKLY','202007241',dbo.fn_GetTimedKey(),NULL,'us3rVaWHE1001',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRU401K72','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRU401K72','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRU401K72','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRU401K72','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EPRU401K72' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EPRU401K72' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EPRU401K72_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EPRU401K72_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRU401K72','H01','dbo.U_EPRU401K72_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRU401K72','D10','dbo.U_EPRU401K72_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRU401K72','D20','dbo.U_EPRU401K72_drvTbl2',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRU401K72','T90','dbo.U_EPRU401K72_Trailer',NULL);
IF OBJECT_ID('U_EPRU401K72_DedList') IS NULL
CREATE TABLE [dbo].[U_EPRU401K72_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EPRU401K72_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EPRU401K72_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvTRANSACTIONCODE] varchar(3) NOT NULL,
    [drvPLANNUMBER] varchar(6) NOT NULL,
    [drvPARTICIPANTID] char(11) NULL,
    [drvFULLPARTTIMEINDICATOR] varchar(1) NOT NULL,
    [drvINVESTMENT1] varchar(2) NOT NULL,
    [drvSOURCE1] varchar(1) NULL,
    [drvCONTRIBUTIONAMOUNT1] numeric NULL,
    [drvINVESTMENT2] varchar(2) NOT NULL,
    [drvSOURCE2] varchar(1) NULL,
    [drvCONTRIBUTIONAMOUNT2] numeric NULL,
    [drvINVESTMENT3] varchar(2) NOT NULL,
    [drvSOURCE3] varchar(1) NULL,
    [drvCONTRIBUTIONAMOUNT3] numeric NULL,
    [drvINVESTMENT4] varchar(2) NOT NULL,
    [drvSOURCE4] varchar(1) NOT NULL,
    [drvCONTRIBUTIONAMOUNT4] numeric NULL,
    [drvINVESTMENT5] varchar(1) NOT NULL,
    [drvSOURCE5] varchar(1) NOT NULL,
    [drvCONTRIBUTIONAMOUNT5] varchar(1) NOT NULL,
    [drvINVESTMENT6] varchar(1) NOT NULL,
    [drvSOURCE6] varchar(1) NOT NULL,
    [drvCONTRIBUTIONAMOUNT6] varchar(1) NOT NULL,
    [drvPAYPERIODENDDATE] datetime NULL,
    [drvINSIDERTRADER] varchar(1) NOT NULL,
    [drvSUBPLANNUMBER] varchar(4) NULL,
    [drvNAME] varchar(204) NULL,
    [drvADDRESS1] varchar(255) NULL,
    [drvADDRESS2] varchar(255) NULL,
    [drvCITY] varchar(255) NULL,
    [drvSTATE] varchar(255) NULL,
    [drvZIPCODE] varchar(50) NULL,
    [drvDATEOFBIRTH] datetime NULL,
    [drvORIGINALDATEOFHIRE] datetime NULL,
    [drvADJUSTEDHIREDATE] varchar(1) NOT NULL,
    [drvMARITALSTATUS] varchar(1) NOT NULL,
    [drvGENDERCODE] varchar(1) NOT NULL,
    [drvEMPLOYEESTATUSPrevious] varchar(2) NULL,
    [drvEMPLOYEESTATUS] varchar(2) NULL,
    [drvEMPLOYEESTATUSDATE] varchar(1) NOT NULL,
    [drvPAYROLLFREQUENCY] varchar(1) NOT NULL,
    [drvYTDHOURSOFSERVICE] varchar(6) NOT NULL,
    [drvCURRENTPAYPERIODHOURS] char(20) NULL,
    [drvCURELIGGROSSPAYS1] varchar(1) NOT NULL,
    [drvCURRENTPAYPERIODW2PAY] varchar(1) NOT NULL,
    [drvANNIVERSARYDATE] varchar(1) NOT NULL,
    [drvANNIVERSARYHOURS] varchar(1) NOT NULL,
    [drvCHECKDATE] datetime NULL,
    [drvEMPLOYEEIDCODE] char(11) NULL,
    [drvDIVSUB] varchar(1) NOT NULL,
    [drvEMPLOYERLOCATIONCODE] varchar(1) NOT NULL,
    [drvLOCATIONEFFECTIVEDATE] varchar(1) NOT NULL,
    [drvGROUPINDICATOR] varchar(1) NOT NULL,
    [drvNEVERELIGIBLE] varchar(1) NOT NULL,
    [drvELIGTOPARTINEESOURCES] varchar(1) NOT NULL,
    [drvELIGTOPARTINERSOURCES] varchar(1) NOT NULL,
    [drvELIGIBILITYDATE] varchar(1) NOT NULL,
    [drvAUTOENROLLDECLINEINDICATOR] varchar(1) NOT NULL,
    [drvDEFERRALRATEFORSOURCE1] varchar(1) NOT NULL,
    [drvCASHBONUS] varchar(1) NOT NULL,
    [drvHCEINDICATOR] varchar(1) NOT NULL,
    [drvUNIONEMPLOYEE] varchar(1) NOT NULL,
    [drvMARKETSALARY] varchar(1) NOT NULL,
    [drvREHIREDATE] varchar(1) NOT NULL,
    [drvCURPPGROSSPAY415HCE414COM] varchar(1) NOT NULL,
    [drvDEFERRALPLANLIMITCOMP] varchar(1) NOT NULL,
    [drvCURRENTELIGGROSSPAYSOURCE2] varchar(1) NOT NULL,
    [drvADPCOMPENSATION] varchar(1) NOT NULL,
    [drvCURRENTELIGGROSSPAYSOURCE3] varchar(1) NOT NULL,
    [drvERMATCHCOMPENSATION] varchar(1) NOT NULL,
    [drvACPCOMPENSATION] varchar(1) NOT NULL,
    [drvEXCLUDEDCOMPENSATION] varchar(1) NOT NULL,
    [drvTOPHEAVY401aCOMPENSATION] varchar(1) NOT NULL,
    [drvEEPOSTTAXCOMPENSATION] varchar(1) NOT NULL,
    [drvSUBSTATUS] varchar(1) NOT NULL,
    [drvSUBSTATUSDATE] varchar(1) NOT NULL,
    [drvPARTICIPANTSEMAILADDRESS] varchar(50) NULL,
    [drvWORKPHONE] varchar(50) NULL,
    [drvHOMEPHONE] varchar(50) NULL,
    [drvCELLPHONE] varchar(50) NULL
);
IF OBJECT_ID('U_EPRU401K72_drvTbl2') IS NULL
CREATE TABLE [dbo].[U_EPRU401K72_drvTbl2] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvTRANSACTIONCODE] varchar(3) NOT NULL,
    [drvPLANNUMBER] varchar(6) NOT NULL,
    [drvPARTICIPANTID] char(11) NULL,
    [drvLOANNUMBER] varchar(1) NOT NULL,
    [drvLOANREPAYMENTAMOUNT] numeric NULL,
    [drvSUBPLANNUMBER] varchar(6) NULL
);
IF OBJECT_ID('U_EPRU401K72_EEList') IS NULL
CREATE TABLE [dbo].[U_EPRU401K72_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EPRU401K72_File') IS NULL
CREATE TABLE [dbo].[U_EPRU401K72_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(800) NULL
);
IF OBJECT_ID('U_EPRU401K72_Header') IS NULL
CREATE TABLE [dbo].[U_EPRU401K72_Header] (
    [drvRECORDTYPE] varchar(3) NOT NULL,
    [drvFILETYPE] varchar(8) NOT NULL,
    [drvCLIENTIDENTIFIER] varchar(6) NOT NULL,
    [drvFILECREATIONDATE] datetime NOT NULL,
    [drvFILECREATIONTIME] varchar(8000) NULL,
    [drvSENDER] varchar(1) NOT NULL,
    [drvFILEFORMATTYPE] varchar(3) NOT NULL
);
IF OBJECT_ID('U_EPRU401K72_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EPRU401K72_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhSourceOld1] numeric NULL,
    [PdhSource1] numeric NULL,
    [PdhSource2] numeric NULL,
    [PdhSource3] numeric NULL,
    [PdhSource4] numeric NULL,
    [PdhSource5] numeric NULL,
    [PdhSource6] numeric NOT NULL
);
IF OBJECT_ID('U_EPRU401K72_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EPRU401K72_PEarHist] (
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
IF OBJECT_ID('U_EPRU401K72_Trailer') IS NULL
CREATE TABLE [dbo].[U_EPRU401K72_Trailer] (
    [drvRECORDTYPE] varchar(3) NOT NULL,
    [drvFILETYPE] varchar(8) NOT NULL,
    [drvCLIENTIDENTIFIER] varchar(6) NOT NULL,
    [drvFILECREATIONDATE] datetime NOT NULL,
    [drvFILECREATIONTIME] varchar(8000) NULL,
    [drvDETAILRECORDCOUNT] int NULL,
    [drvTOTALCONTRIBUTIONAMOUNT] numeric NULL,
    [drvLOANREPAYMENTAMOUNT] numeric NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EPRU401K72]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Wheeler Machinery Co.

Created By: Marco Lagrosa
Business Analyst: Richard Vars
Create Date: 07/07/2020
Service Request Number: TekP-2020-03-16-0005


Purpose: Prudential 401K (006772) V2

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EPRU401K72', @AllObjects = 'Y', @IsWeb = 'Y'

select * from dbo.U_dsi_Configuration where FormatCode = 'EPRU401K72' ORDER BY LEN(CfgName) DESC
select * from dbo.U_dsi_SQLClauses where FormatCode = 'EPRU401K72'
select * from dbo.U_dsi_Parameters where FormatCode = 'EPRU401K72'

select * from AscDefH where AdhFormatCode = 'EPRU401K72'
select * from AscExp where expFormatCode = 'EPRU401K72'
select * from ascdeff where AdfHeaderSystemID = 'EPRU401K72Z0' order by adfrectype, AdfSetNumber, AdfFieldNumber 
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EPRU401K72';

DSI_SP_TESTSWITCHBOX_V2 'EPRU401K72', 'EPRU401K72'
DSI_SP_TESTSWITCHBOX_V2 'EPRU401K72', 'TEST'
DSI_SP_TESTSWITCHBOX_V2 'EPRU401K72', 'ACTIVEOE'
DSI_SP_TESTSWITCHBOX_V2 'EPRU401K72', 'PASSIVEOE'

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EPRU401K72';

To turn off/on TESTEDT header record: 
Update U_Dsi_Configuration set CfgValue = 'N' WHERE FormatCode = 'EPRU401K72' AND CfgName = 'TESTING'
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
            ,@FileCreationDate    DATETIME 

    -- Set FormatCode
    SELECT @FormatCode = 'EPRU401K72';

    --        BETWEEN @StartPerControl and @EndPerControl

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@FileCreationDate = GetDate()
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EPRU401K72_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EPRU401K72_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'U401,U401P,UCUPP,UCUPF,4ERMU,U401R,UCUPR,UPRSH,U40AT';

    IF OBJECT_ID('U_EPRU401K72_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EPRU401K72_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EPRU401K72_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

    --==========================================
    -- BDM Section
    --==========================================
    --DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = 'EPRU401K72';

    ---- Required parameters
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','U401F,U401P,4ERMU,U401R,U401L,UPRSH,UCUPP,UCUPR');
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

    ---- Required OE parameters
    --IF @ExportCode LIKE '%PASSIVE'
    --BEGIN
    --    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'OEType','PASSIVE');
    --END;

    --IF @ExportCode LIKE '%ACTIVE'
    --BEGIN
    --    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'OEType','ACTIVE');
    --END;

    ---- Run BDM Module
    --EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EPRU401K72_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EPRU401K72_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhSourceOld1     = SUM(CASE WHEN PdhDedCode IN ('U401F','U401P','UCUPP','UCUPF')  THEN PdhEECurAmt ELSE 0.00 END) --ELECTIVE DEFERRALS 
        ,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('U401F','U401P','UCUPP','UCUPF') or PdhIsDefComp = 'Y'  THEN PdhEECurAmt ELSE 0.00 END) --ELECTIVE DEFERRALS 

        ,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('4ERMU') THEN PdhERCurAmt ELSE 0.00 END) --FIXED ER MATCH
        ,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('U401R','UCUPR') THEN PdhEECurAmt ELSE 0.00 END) --ROTH 401K    
        ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('UPRSH') THEN PdhERCurAmt ELSE 0.00 END) -- DISCRETIONARY PROFIT SHARING 
        ,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('U40AT') THEN PdhEECurAmt ELSE 0.00 END) --After Tax
        ,PdhSource6     = 0.00
        --,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('401KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        --,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        --,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        --,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
                --    U401F,U401P,4ERMU,U401R,U401L
    INTO dbo.U_EPRU401K72_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EPRU401K72_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE PdhPerControl between @startpercontrol and @endpercontrol    --<= @EndPerControl
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) > 0.00
       OR SUM(PdhERCurAmt) > 0.00
    );

    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EPRU401K72_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EPRU401K72_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
        ---- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        ---- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_EPRU401K72_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
   AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) > 0.00;
        
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EPRU401K72_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EPRU401K72_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EPRU401K72_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvTRANSACTIONCODE = '114'
        ,drvPLANNUMBER = '006772'
        ,drvPARTICIPANTID = EepSSN
        ,drvFULLPARTTIMEINDICATOR = 
                    Case
                        When EecFullTimeOrPartTime = 'F' then '1'
                        else '2'
                    End
        ,drvINVESTMENT1 = '**'
        ,drvSOURCE1 = CASE WHEN ISNULL(PdhSource1,'0.0000') <> '0.0000' THEN 'A' END
        ,drvCONTRIBUTIONAMOUNT1 = CASE WHEN PdhSource1  = '0.0000' THEN NULL ELSE PdhSource1 END
        ,drvINVESTMENT2 = '**'
        ,drvSOURCE2 = CASE WHEN ISNULL(PdhSource3,'0.0000') <> '0.0000' THEN 'J' END
        ,drvCONTRIBUTIONAMOUNT2 = PdhSource3
        ,drvINVESTMENT3 = '**'
        ,drvSOURCE3 = CASE WHEN ISNULL(PdhSource1,'0.0000') <>  '0.0000' THEN  'P' END
        ,drvCONTRIBUTIONAMOUNT3 = CASE WHEN PdhSource2  = '0.0000' THEN NULL ELSE PdhSource2 END
        ,drvINVESTMENT4 = '**'
        ,drvSOURCE4 = '1'
        ,drvCONTRIBUTIONAMOUNT4 = PdhSource4
        ,drvINVESTMENT5 = '' 
        ,drvSOURCE5 = ''
        ,drvCONTRIBUTIONAMOUNT5 = ''
        ,drvINVESTMENT6 = '' 
        ,drvSOURCE6 = ''
        ,drvCONTRIBUTIONAMOUNT6 = ''
        ,drvPAYPERIODENDDATE = pdenddt
        ,drvINSIDERTRADER = ''
        ,drvSUBPLANNUMBER = case when eeccoid = 'ROW0O' and eecpaygroup  = 'WEEKLY' then '0002' --WMC
                                 when eeccoid = 'ZAZ7Y' and eecpaygroup  = 'ICMWK'  then '0003' --ICM
                                 end 
        ,drvNAME = rtrim(EepNameLast + ', ' + EepNameFirst + ' ' + isnull(Left(EepNameMiddle,1),''))
        ,drvADDRESS1 = EepAddressLine1
        ,drvADDRESS2 = EepAddressLine2
        ,drvCITY = EepAddressCity
        ,drvSTATE = EepAddressState
        ,drvZIPCODE = EepAddressZipCode
        ,drvDATEOFBIRTH = EepDateOfBirth
        ,drvORIGINALDATEOFHIRE = EecDateOfOriginalHire
        ,drvADJUSTEDHIREDATE = ''
                                
        ,drvMARITALSTATUS = 
                Case
                    When eepMaritalStatus = 'S' then '1'
                    When eepMaritalStatus = 'M' then '2'
                    else '0'
                End
        ,drvGENDERCODE = 
                Case
                    When eepgender = 'M' then '1'
                    else '2'
                End
        ,drvEMPLOYEESTATUSPrevious = 
                Case
                    When EecEmplStatus IN ('A') then '00'
                    When EecEmplStatus = 'T' then '32'
                End
            ,drvEMPLOYEESTATUS = 
                Case
                    When EecEmplStatus IN ('A','L') then '00'
                    When EecEmplStatus = 'T' then '32'
                End
        ,drvEMPLOYEESTATUSDATE = ''
        ,drvPAYROLLFREQUENCY = CASE WHEN eecpaygroup  = 'WEEKLY' THEN '7' ELSE '6' END
        ,drvYTDHOURSOFSERVICE = '000000'
        ,drvCURRENTPAYPERIODHOURS =convert(char(20),convert(numeric(12,0),isnull(PehInclInDefCompHrs * 100,0)))    -- 
        ,drvCURELIGGROSSPAYS1 = ''
        ,drvCURRENTPAYPERIODW2PAY = ''
        ,drvANNIVERSARYDATE = ''
        ,drvANNIVERSARYHOURS = ''
        ,drvCHECKDATE = paydt
        ,drvEMPLOYEEIDCODE = EepSSN 
        ,drvDIVSUB = ''
        ,drvEMPLOYERLOCATIONCODE = ''
        ,drvLOCATIONEFFECTIVEDATE = ''
        ,drvGROUPINDICATOR = ''
        ,drvNEVERELIGIBLE = ''
        ,drvELIGTOPARTINEESOURCES = ''
        ,drvELIGTOPARTINERSOURCES = ''
        ,drvELIGIBILITYDATE = ''
        ,drvAUTOENROLLDECLINEINDICATOR = ''
        ,drvDEFERRALRATEFORSOURCE1 = ''
        ,drvCASHBONUS = ''
        ,drvHCEINDICATOR = ''
        ,drvUNIONEMPLOYEE = ''
        ,drvMARKETSALARY = ''
        ,drvREHIREDATE = ''
        ,drvCURPPGROSSPAY415HCE414COM = ''
        ,drvDEFERRALPLANLIMITCOMP = ''
        ,drvCURRENTELIGGROSSPAYSOURCE2 = '' 
        ,drvADPCOMPENSATION = ''
        ,drvCURRENTELIGGROSSPAYSOURCE3 = ''  
        ,drvERMATCHCOMPENSATION = ''
        ,drvACPCOMPENSATION = ''
        ,drvEXCLUDEDCOMPENSATION = ''     
        ,drvTOPHEAVY401aCOMPENSATION = ''
        ,drvEEPOSTTAXCOMPENSATION = ''
        ,drvSUBSTATUS = '' 
        ,drvSUBSTATUSDATE = ''
        ,drvPARTICIPANTSEMAILADDRESS = EepAddressEMail
        ,drvWORKPHONE = EecPhoneBusinessNumber
        ,drvHOMEPHONE = EepPhoneHomeNumber
        ,drvCELLPHONE = (Select top 1 efoPhoneNumber from dbo.EmpMPhon where efoPhoneType = 'CEL' and efoeeid = xeeid)
    INTO dbo.U_EPRU401K72_drvTbl
    FROM dbo.U_EPRU401K72_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    Join dbo.U_EPRU401K72_PEarHist WITH (NOLOCK)
        ON PehEEID = xEEID

    Left Join dbo.U_EPRU401K72_PDedHist WITH (NOLOCK)
        on PdhEEID = xEEID
    left join(SELECT MAX(PgpPayDate) paydt, MAX(PGPPERIODSTARTDATE) pdstdt,MAX(PGPPERIODENDDATE) pdenddt        --    PgPayPer.pdenddt
            FROM         PgPayPer
            WHERE     PgpPeriodControl between @startpercontrol and @endpercontrol) AS period on 1 = 1 
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EPRU401K72_drvTbl2
    ---------------------------------
    IF OBJECT_ID('U_EPRU401K72_drvTbl2','U') IS NOT NULL
        DROP TABLE dbo.U_EPRU401K72_drvTbl2;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvTRANSACTIONCODE = '385'
        ,drvPLANNUMBER = '006772'
        ,drvPARTICIPANTID = EepSSN
        ,drvLOANNUMBER = '' --Removed
        ,drvLOANREPAYMENTAMOUNT = PdhSource5
        ,drvSUBPLANNUMBER = Case when eeccoid = 'ROW0O' and eecpaygroup  = 'WEEKLY' then '000002' --WMC
                                 when eeccoid = 'ZAZ7Y' and eecpaygroup  = 'ICMWK'  then '000003' --ICM
                                 end                            
    INTO dbo.U_EPRU401K72_drvTbl2
    FROM dbo.U_EPRU401K72_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo. EmpComp WITH (NOLOCK) ON EecEEID = xEEID and EecCOID = xCOID
    Join dbo.U_EPRU401K72_PDedHist WITH (NOLOCK)
        on PdhEEID = xEEID
        and PdhSource6 > 0
    --JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
    --    ON EedEEID = xEEID 
    --    AND EedCoID = xCoID
    --    AND EedFormatCode = @FormatCode 
    --    AND EedValidForExport = 'Y'
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EPRU401K72_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EPRU401K72_Header;
    SELECT DISTINCT
         drvRECORDTYPE = '001'
        ,drvFILETYPE = 'COMBINED'
        ,drvCLIENTIDENTIFIER = '006772'
        ,drvFILECREATIONDATE = GETDATE()
        --,drvFILECREATIONTIME = Replace(convert(varchar(10), GETDATE(), 108),':','')    --convert(varchar(10), GETDATE(), 108) --JR Old Logic
        ,drvFILECREATIONTIME = Replace(convert(varchar(10), @FileCreationDate, 108),':','')
        ,drvSENDER = 'P'
        ,drvFILEFORMATTYPE = 'V01'
    INTO dbo.U_EPRU401K72_Header
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EPRU401K72_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_EPRU401K72_Trailer;
    SELECT DISTINCT
         drvRECORDTYPE = '999'
        ,drvFILETYPE = 'COMBINED'
        ,drvCLIENTIDENTIFIER = '006772'
        ,drvFILECREATIONDATE = GETDATE()
        --,drvFILECREATIONTIME = Replace(convert(varchar(10), GETDATE(), 108),':','')    --convert(varchar(10), GETDATE(), 108) --JR Old Logic
        ,drvFILECREATIONTIME = Replace(convert(varchar(10), @FileCreationDate, 108),':','')
        ,drvDETAILRECORDCOUNT =  (select count(*) from dbo.U_EPRU401K72_drvTbl ) +  (select count(*) from dbo.U_EPRU401K72_drvTbl2 )
        ,drvTOTALCONTRIBUTIONAMOUNT = (select sum(drvCONTRIBUTIONAMOUNT1) + sum(drvCONTRIBUTIONAMOUNT2) + sum(drvCONTRIBUTIONAMOUNT3) + sum(drvCONTRIBUTIONAMOUNT4) from dbo.U_EPRU401K72_drvTbl) 
        ,drvLOANREPAYMENTAMOUNT = (select sum(drvLOANREPAYMENTAMOUNT)  from dbo.U_EPRU401K72_drvTbl2) 
    INTO dbo.U_EPRU401K72_Trailer
    ;

    --==========================================
    -- Set FileName
    --==========================================
    --IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    --BEGIN
    --    UPDATE dbo.U_dsi_Parameters
    --        SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
    --                              WHEN @ExportCode LIKE 'OE%' THEN 'OE_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
    --                              ELSE 'Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
    --                         END
    --    WHERE FormatCode = @FormatCode;
    --END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEPRU401K72_Export AS
    SELECT TOP 20000000 Data
    FROM dbo.U_EPRU401K72_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EPRU401K72%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201709211'
       ,expStartPerControl     = '201709211'
       ,expLastEndPerControl   = '201709289'
       ,expEndPerControl       = '201709289'
WHERE expFormatCode = 'EPRU401K72';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEPRU401K72_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EPRU401K72_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort