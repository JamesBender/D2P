/*
Directions:
1) Find and replace each of the text below with the applicable information.
       E.g. Replace the text "@DeveloperName" (excluding quotes) with "John Doe"
2) Deploy this to client environment!

-- Integration parameters
@CustomerName - Replace with customer name
@DeveloperName - Replace with TC name
@IntegrationAnalystName - Replace with BA/IC name
@CreateDate - Replace with date of creation
@SRNumber - Replace with SR number
@CustomFormatCode - Replace with Format Code (i.e., EUNUM20)
@CustomFormatName - Replace with Name of Interface (AdfFormatName) (i.e., UNUM Export)
@IsWebFlag - Replace with 'Y' (Yes) or 'N' (No) for Web Interface Settings

-- Export parameters
@ClientName - Replace with Client Name in Header Record
@DedCodeList - Replace with list of Deduction Codes (i.e., @CustomFormatName)

-- File parameters
@FileExportPath - Replace with the Export Path where the file generates to (i.e., \\us.saas\e1\Public\[Client ARNum]\Exports\UNUM\)
@FileTestPath - Replace with the Test Path where the file generates to (i.e., \\us.saas\e1\Public\[Client ARNum]\Exports\UNUM\)
@FileUDESPath - Replace with the UDES Path where the file generates to (i.e., \\us.saas\e0\data_exchange\[Client ARNum]\Exports\)
@CompanyCode - Replace with Company Code in File Name

*/
IF OBJECT_ID('dsi_vw@CustomFormatName_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vw@CustomFormatName_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_@CustomFormatName') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_@CustomFormatName];
GO
IF OBJECT_ID('U_@CustomFormatName_File') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatName_File];
GO
IF OBJECT_ID('U_@CustomFormatName_EEList') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatName_EEList];
GO
IF OBJECT_ID('U_@CustomFormatName_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatName_drvTbl];
GO
IF OBJECT_ID('U_@CustomFormatName_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatName_AuditFields];
GO
IF OBJECT_ID('U_@CustomFormatName_Audit') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatName_Audit];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = '@CustomFormatName';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = '@CustomFormatName';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = '@CustomFormatName';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = '@CustomFormatName';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = '@CustomFormatName';
GO

DECLARE @AdhSystemID VARCHAR(12), @FixedFormatName1 VARCHAR(50), @FixedFormatName2 VARCHAR(50);
SET @AdhSystemID = LEFT('@CustomFormatCode' + REPLICATE('0',10),10) + 'Z0';
SET @FixedFormatName1 = LEFT('@CustomFormatName',50);
SET @FixedFormatName2 = LEFT('@CustomFormatName',30);

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCreateTClockBatches,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhRespectZeroPayRate,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhThirdPartyPay) SELECT 'N','C','Y','0','',NULL,'','N','','N','','013010','EMPEXPORT','CDE','@CustomFormatCode',@FixedFormatName1,'N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','4000','N','S','N',@AdhSystemID,'N','Jan  1 1900 12:00AM','C','N';
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"eEnroll2"','1','(''DA''=''T,'')',@AdhSystemID,'50','H','01','1',NULL,'eEnroll2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"POLICY"','2','(''DA''=''T,'')',@AdhSystemID,'50','H','01','2',NULL,'POLICY',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DIVISION"','3','(''DA''=''T,'')',@AdhSystemID,'50','H','01','3',NULL,'DIVISION',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"MEMBER ID"','4','(''DA''=''T,'')',@AdhSystemID,'50','H','01','4',NULL,'MEMBER ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"PRI DIV"','5','(''DA''=''T,'')',@AdhSystemID,'50','H','01','5',NULL,'PRI DIV',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DOH"','6','(''DA''=''T,'')',@AdhSystemID,'50','H','01','6',NULL,'DOH',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"SALARY"','7','(''DA''=''T,'')',@AdhSystemID,'50','H','01','7',NULL,'SALARY',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"SALARY MODE"','8','(''DA''=''T,'')',@AdhSystemID,'50','H','01','8',NULL,'SALARY MODE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"HOURS"','9','(''DA''=''T,'')',@AdhSystemID,'50','H','01','9',NULL,'HOURS',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"TERM DATE"','10','(''DA''=''T,'')',@AdhSystemID,'50','H','01','10',NULL,'TERM DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"TERM REASON"','11','(''DA''=''T,'')',@AdhSystemID,'50','H','01','11',NULL,'TERM REASON',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"NEW MEMBER ID"','12','(''DA''=''T,'')',@AdhSystemID,'50','H','01','12',NULL,'NEW MEMBER ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"FIRST NAME"','13','(''DA''=''T,'')',@AdhSystemID,'50','H','01','13',NULL,'FIRST NAME',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"MIDDLE NAME"','14','(''DA''=''T,'')',@AdhSystemID,'50','H','01','14',NULL,'MIDDLE NAME',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"LAST NAME"','15','(''DA''=''T,'')',@AdhSystemID,'50','H','01','15',NULL,'LAST NAME',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"SUFFIX"','16','(''DA''=''T,'')',@AdhSystemID,'50','H','01','16',NULL,'SUFFIX',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"GENDER"','17','(''DA''=''T,'')',@AdhSystemID,'50','H','01','17',NULL,'GENDER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DOB"','18','(''DA''=''T,'')',@AdhSystemID,'50','H','01','18',NULL,'DOB',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"CLASS"','19','(''DA''=''T,'')',@AdhSystemID,'50','H','01','19',NULL,'CLASS',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"EFFECTIVE DATE"','20','(''DA''=''T,'')',@AdhSystemID,'50','H','01','20',NULL,'EFFECTIVE DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"ADD TYPE"','21','(''DA''=''T'')',@AdhSystemID,'50','H','01','21',NULL,'ADD TYPE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drveEnroll2"','1','(''UA''=''T,'')',@AdhSystemID,'50','D','10','1',NULL,'eEnroll2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPOLICY"','2','(''UA''=''T,'')',@AdhSystemID,'50','D','10','2',NULL,'POLICY',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDIVISION"','3','(''UA''=''T,'')',@AdhSystemID,'50','D','10','3',NULL,'DIVISION',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMEMBERID"','4','(''UA''=''T,'')',@AdhSystemID,'50','D','10','4',NULL,'MEMBER ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPRIDIV"','5','(''UA''=''T,'')',@AdhSystemID,'50','D','10','5',NULL,'PRI DIV',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDOH"','6','(''UA''=''T,'')',@AdhSystemID,'50','D','10','6',NULL,'DOH',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSALARY"','7','(''UNT2''=''T,'')',@AdhSystemID,'50','D','10','7',NULL,'SALARY',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSALARYMODE"','8','(''UA''=''T,'')',@AdhSystemID,'50','D','10','8',NULL,'SALARY MODE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvHOURS"','9','(''UNT2''=''T,'')',@AdhSystemID,'50','D','10','9',NULL,'HOURS',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvTERMDATE"','10','(''UD101''=''T,'')',@AdhSystemID,'50','D','10','10',NULL,'TERM DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvTERMREASON"','11','(''UA''=''T,'')',@AdhSystemID,'50','D','10','11',NULL,'TERM REASON',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvNEWMEMBERID"','12','(''UA''=''T,'')',@AdhSystemID,'50','D','10','12',NULL,'NEW MEMBER ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvFIRSTNAME"','13','(''UA''=''T,'')',@AdhSystemID,'50','D','10','13',NULL,'FIRST NAME',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMIDDLENAME"','14','(''UA''=''T,'')',@AdhSystemID,'50','D','10','14',NULL,'MIDDLE NAME',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLASTNAME"','15','(''UA''=''T,'')',@AdhSystemID,'50','D','10','15',NULL,'LAST NAME',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSUFFIX"','16','(''UA''=''T,'')',@AdhSystemID,'50','D','10','16',NULL,'SUFFIX',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvGENDER"','17','(''UA''=''T,'')',@AdhSystemID,'50','D','10','17',NULL,'GENDER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDOB"','18','(''UA''=''T,'')',@AdhSystemID,'50','D','10','18',NULL,'DOB',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCLASS"','19','(''UA''=''T,'')',@AdhSystemID,'50','D','10','19',NULL,'CLASS',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEFFECTIVEDATE"','20','(''UD101''=''T,'')',@AdhSystemID,'50','D','10','20',NULL,'EFFECTIVE DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvADDTYPE"','21','(''UA''=''T'')',@AdhSystemID,'50','D','10','21',NULL,'ADD TYPE',NULL,NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,@FixedFormatName2,CONVERT(CHAR(8),GETDATE(),112) + '9','EMPEXPORT','ONDEMAND',NULL,'@CustomFormatCode',NULL,NULL,NULL,CONVERT(CHAR(8),GETDATE(),112) + '9',NULL,NULL,CONVERT(CHAR(8),GETDATE(),112) + '1',NULL,'','',CONVERT(CHAR(8),GETDATE(),112) + '1',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export',CONVERT(CHAR(8),GETDATE(),112) + '9','EMPEXPORT','OEACTIVE',NULL,'@CustomFormatCode',NULL,NULL,NULL,CONVERT(CHAR(8),GETDATE(),112) + '9',NULL,NULL,CONVERT(CHAR(8),GETDATE(),112) + '1',NULL,'','',CONVERT(CHAR(8),GETDATE(),112) + '1',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export',CONVERT(CHAR(8),GETDATE(),112) + '9','EMPEXPORT','OEPASSIVE',NULL,'@CustomFormatCode',NULL,NULL,NULL,CONVERT(CHAR(8),GETDATE(),112) + '9',NULL,NULL,CONVERT(CHAR(8),GETDATE(),112) + '1',NULL,'','',CONVERT(CHAR(8),GETDATE(),112) + '1',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Test Purposes Only',CONVERT(CHAR(8),GETDATE(),112) + '9','EMPEXPORT','TEST',NULL,'@CustomFormatCode',NULL,NULL,NULL,CONVERT(CHAR(8),GETDATE(),112) + '9',NULL,NULL,CONVERT(CHAR(8),GETDATE(),112) + '1',NULL,'','',CONVERT(CHAR(8),GETDATE(),112) + '1',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session Only',CONVERT(CHAR(8),GETDATE(),112) + '9','EMPEXPORT','SCHEDULED',NULL,'@CustomFormatCode',NULL,NULL,NULL,CONVERT(CHAR(8),GETDATE(),112) + '9',NULL,NULL,CONVERT(CHAR(8),GETDATE(),112) + '1',NULL,'','',CONVERT(CHAR(8),GETDATE(),112) + '1',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','ExportPath','V','@FileExportPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','UseFileName','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','TestPath','V','@FileTestPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','UDESPath','V','@FileUDESPath');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D10','dbo.U_@CustomFormatCode_drvTbl',NULL);
GO
IF ('@IsWebFlag' = 'Y')
BEGIN
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = '@CustomFormatCode' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */

/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = '@CustomFormatCode.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
UPDATE dbo.AscExp SET expAscFileName = @FILEPATH + @FILENAME WHERE expFormatCode = '@CustomFormatCode';

/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = '@CustomFormatCode' AND CfgName = 'ExportPath' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = '@CustomFormatCode' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
/*03*/ DELETE FROM dbo.U_dsi_Configuration WHERE FormatCode = '@CustomFormatCode' AND CfgName = 'TestPath'; /* Remove Test Path for Web Exports */

END
GO
IF OBJECT_ID('U_@CustomFormatName_EEList') IS NULL
CREATE TABLE [dbo].[U_@CustomFormatName_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_@CustomFormatName_File') IS NULL
CREATE TABLE [dbo].[U_@CustomFormatName_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(50) NOT NULL,
    [SubSort] varchar(50) NOT NULL,
    [SubSort2] varchar(50) NULL,
    [SubSort3] varchar(50) NULL,
    [Data] varchar(2000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_@CustomFormatName]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: @CustomerName

Created By: @DeveloperName
Business Analyst: @IntegrationAnalystName
Create Date: @CreateDate
Service Request Number: @SRNumber

Purpose: @CustomFormatName

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/20XX     SR-20XX-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.AscExp WHERE expFormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = '@CustomFormatCode' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'TEST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'SCHEDULED';

EXEC dbo.dsi_BDM_sp_ErrorCheck '@CustomFormatCode';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = '@CustomFormatCode', @AllObjects = 'Y', @IsWeb = '@IsWebFlag';
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

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = CAST(LEFT(StartPerControl,8) AS DATETIME)
        ,@EndDate         = DATEADD(SS,-1,DATEADD(DD,1,LEFT(EndPerControl,8)))
        ,@FormatCode      = FormatCode
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = '@CustomFormatName';

    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_@CustomFormatName_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatName_AuditFields;
    CREATE TABLE dbo.U_@CustomFormatName_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_@CustomFormatName_AuditFields VALUES ('EmpComp','EecAnnSalary');
    INSERT INTO dbo.U_@CustomFormatName_AuditFields VALUES ('EmpComp','EecDateOfLastHire');
    INSERT INTO dbo.U_@CustomFormatName_AuditFields VALUES ('EmpComp','EecDateOfOriginalHire');
    INSERT INTO dbo.U_@CustomFormatName_AuditFields VALUES ('EmpComp','EecDateOfTermination');
    INSERT INTO dbo.U_@CustomFormatName_AuditFields VALUES ('EmpComp','EecEmplStatus');
    INSERT INTO dbo.U_@CustomFormatName_AuditFields VALUES ('EmpComp','EecFullTimeOrPartTime');
    INSERT INTO dbo.U_@CustomFormatName_AuditFields VALUES ('EmpComp','EecHourlyPayRate');
    INSERT INTO dbo.U_@CustomFormatName_AuditFields VALUES ('EmpComp','EecSalaryOrHourly');
    INSERT INTO dbo.U_@CustomFormatName_AuditFields VALUES ('EmpComp','EecScheduledWorkHrs');
    INSERT INTO dbo.U_@CustomFormatName_AuditFields VALUES ('EmpComp','EecTermReason');
    INSERT INTO dbo.U_@CustomFormatName_AuditFields VALUES ('EmpDed','EedBenStartDate');
    INSERT INTO dbo.U_@CustomFormatName_AuditFields VALUES ('EmpDed','EedBenStopDate');
    INSERT INTO dbo.U_@CustomFormatName_AuditFields VALUES ('EmpPers','EepDateOfBirth');
    INSERT INTO dbo.U_@CustomFormatName_AuditFields VALUES ('EmpPers','EepGender');
    INSERT INTO dbo.U_@CustomFormatName_AuditFields VALUES ('EmpPers','EepNameFirst');
    INSERT INTO dbo.U_@CustomFormatName_AuditFields VALUES ('EmpPers','EepNameLast');
    INSERT INTO dbo.U_@CustomFormatName_AuditFields VALUES ('EmpPers','EepNameMiddle');
    INSERT INTO dbo.U_@CustomFormatName_AuditFields VALUES ('EmpPers','EepNameSuffix');
    INSERT INTO dbo.U_@CustomFormatName_AuditFields VALUES ('EmpPers','EepOldSSN');
    INSERT INTO dbo.U_@CustomFormatName_AuditFields VALUES ('EmpPers','EepSSN');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_@CustomFormatName_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatName_Audit;
    SELECT 
        audEEID  = audKey1Value
        ,audKey2 = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
        ,audNewHire = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = '' AND ISNULL(audNewValue,'') = 'A' THEN 'Y' ELSE 'N' END
        ,audReHire = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = 'T' AND ISNULL(audNewValue,'') = 'A' THEN 'Y' ELSE 'N' END
        ,audTerm = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audNewValue,'') = 'T' THEN 'Y' ELSE 'N' END
        ,audSalaryChange = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecAnnSalary' AND ISNULL(audNewValue,'') <> '' THEN 'Y' ELSE 'N' END
    INTO dbo.U_@CustomFormatName_Audit
    FROM dbo.U_@CustomFormatName_EEList WITH (NOLOCK)
    JOIN dbo.vw_AuditData WITH (NOLOCK) 
        ON audKey1Value = xEEID
    JOIN dbo.U_@CustomFormatName_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE'
    AND ISNULL(audNewValue,'') <> '';

    --==========================================
    -- Clean EE List 
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_@CustomFormatName_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCoID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_@CustomFormatName_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    -- Changes Only
    IF (@ExportCode NOT LIKE 'OE%')
    BEGIN
        DELETE FROM dbo.U_@CustomFormatName_EEList
        WHERE NOT EXISTS (SELECT 1 FROM dbo.U_@CustomFormatName_Audit WHERE audEEID = xEEID AND audRowNo = 1);
    END;

    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','<ENTER DEDCODE(S)>');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

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
    EXEC dbo.dsi_bdm_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Employee Data and the driver tables
    --==========================================

    ---------------------------------
    -- DETAIL RECORD - U_@CustomFormatName_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_@CustomFormatName_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatName_drvTbl;
    SELECT DISTINCT
        drveEnroll2 = ''
        ,drvPOLICY = '000000'
        ,drvDIVISION = '0001'
        ,drvMEMBERID = CASE WHEN ISNULL(EepOldSSN,'') <> '' THEN EepOldSSN ELSE EepSSN END
        ,drvPRIDIV = ''
        ,drvDOH = REPLACE(CONVERT(VARCHAR(10),EedBenStartDate,101),'/',SPACE(0))
        ,drvSALARY = CASE WHEN EecSalaryOrHourly = 'H' THEN EecHourlyPayRate
                          ELSE EecAnnSalary
                     END
        ,drvSALARYMODE = CASE WHEN EecSalaryOrHourly = 'H' THEN 'H' --Hourly
                              ELSE 'A' --Annual
                         END
        ,drvHOURS = CASE EecPayPeriod
                         WHEN 'B' THEN EecScheduledWorkHrs / 2
                         WHEN 'S' THEN (EecScheduledWorkHrs*24) / 52
                         WHEN 'M' THEN (EecScheduledWorkHrs*12) / 52
                         ELSE EecScheduledWorkHrs
                    END
        ,drvTERMDATE = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvTERMREASON = CASE WHEN EecEmplStatus = 'T' THEN
                                CASE EecTermReason
                                     WHEN '202' THEN 'RT'
                                     WHEN '203' THEN 'DT'
                                     ELSE 'TE'
                                END
                              WHEN EedBenStopDate IS NOT NULL THEN 'IN'
                         END
        ,drvNEWMEMBERID = CASE WHEN ISNULL(EepOldSSN,'') <> '' THEN EepSSN END
        ,drvFIRSTNAME = EepNameFirst
        ,drvMIDDLENAME = LEFT(EepNameMiddle,1)
        ,drvLASTNAME = EepNameLast
        ,drvSUFFIX = NULLIF(EepNameSuffix,'Z')
        ,drvGENDER = EepGender
        ,drvDOB = EepDateOfBirth
        ,drvCLASS = '0001'
        ,drvEFFECTIVEDATE = CASE WHEN audReHire = 'Y' THEN EecDateOfLastHire
                                 WHEN audTerm = 'Y' THEN EecDateOfTermination
                                 WHEN audSalaryChange = 'Y' THEN EjhJobEffDate
                                 ELSE EedBenStartDate
                            END
        ,drvADDTYPE = 'O'
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = ''
    INTO dbo.U_@CustomFormatName_drvTbl
    FROM dbo.U_@CustomFormatName_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_bdm_EmpDeductions WITH (NOLOCK)
        ON EedEEID = xEEID 
        AND EedCoID = xCoID
        AND EedFormatCode = @FormatCode 
        AND EedValidForExport = 'Y'
    LEFT JOIN (
        -- Get NewHire, ReHire, Terms from Audit
        SELECT audEEID
            ,audNewHire = MAX(audNewHire)
            ,audReHire = MAX(audReHire)
            ,audTerm = MAX(audTerm)
            ,audSalaryChange = MAX(audSalaryChange)
        FROM dbo.U_@CustomFormatName_Audit
        WHERE audRowNo = 1
        AND (audNewHire = 'Y'
            OR audReHire = 'Y'
            OR audTerm = 'Y'
            OR audSalaryChange = 'Y'
        )
        GROUP BY audEEID
    ) AuditRecords
        ON audEEID = xEEID
    LEFT JOIN (
        -- Get Most Recent Salary Change Date
        SELECT EjhEEID, EjhCOID
            ,EjhJobEffDate = MAX(EjhJobEffDate)
        FROM dbo.EmpHJob
        WHERE EjhIsRateChange = 'Y'
        GROUP BY EjhEEID, EjhCOID
    ) EmpHJob
        ON EjhEEID = xEEID
        AND EjhCOID = xCOID;

    -------------------------
    -- Update Record Count
    -------------------------
    UPDATE dbo.U_@CustomFormatName_drvTbl SET drveEnroll2 = (SELECT COUNT(*) FROM dbo.U_@CustomFormatName_drvTbl);

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable('@CustomFormatName','UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable('@CustomFormatName','Testing') = 'Y' THEN 'TEST_@CompanyCode_UNUM_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE '[CoCode]_UNUM_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = '@CustomFormatName';
    END;

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vw@CustomFormatName_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_@CustomFormatName_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE '@CustomFormatName%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET ExpLastStartPerControl = '202005051'
       ,ExpStartPerControl     = '202005051'
       ,ExpLastEndPerControl   = '202005059'
       ,ExpEndPerControl       = '202005059'
WHERE ExpFormatCode = '@CustomFormatName';

-- Remove Prior Division (Field "PRI DIV")
SELECT * FROM dbo.AscDefF JOIN dbo.AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = '@CustomFormatName' AND AdfFieldNumber = '5'
DELETE FROM dbo.AscDefF JOIN dbo.AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = '@CustomFormatName' AND AdfFieldNumber = '5'

-- Add Prior Division (Field "PRI DIV")
DECLARE @AdhSystemID VARCHAR(50);
SET @AdhSystemID = (SELECT AdhSystemID FROM dbo.AscDefH WHERE AdhFormatCode = '@CustomFormatName');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"PRI DIV"','5','(''DA''=''T,'')',@AdhSystemID,'50','H','01','5',NULL,'PRI DIV',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPRIDIV"','5','(''UA''=''T,'')',@AdhSystemID,'50','D','10','5',NULL,'PRI DIV',NULL,NULL;
SELECT * FROM dbo.AscDefF JOIN dbo.AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = '@CustomFormatName' AND AdfFieldNumber = '5'

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vw@CustomFormatName_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_@CustomFormatName_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort
GO