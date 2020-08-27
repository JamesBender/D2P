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
@CustomFormatCode - Replace with Format Code (i.e., EXMLSWNDEM)
@CustomFormatName - Replace with Name of Interface (AdfFormatName) (i.e., Send Word Now XML Demographic Export)
@IsWebFlag - Replace with 'Y' (Yes) or 'N' (No) for Web Interface Settings

-- Data Parameters
@AccountIdUserName - Replace with the Account ID Username
@AccountIdUserNameTEST - Replace with the Test Account ID Username

-- File parameters
@FileExportPath - Replace with the Export Path where the file generates to (i.e., \\us.saas\e1\Public\[Client ARNum]\Exports\[Vendor]\)
@TestFilePath - Replace with the Test Path where the file generates to (i.e., \\us.saas\e1\Public\[Client ARNum]\Exports\[Vendor]\)
@UDESFilePath - Replace with the UDES Path where the file generates to (i.e., \\us.saas\e0\data_exchange\[Client ARNum]\Exports\)

*/
SET NOCOUNT ON;
IF OBJECT_ID('dsi_vw@CustomFormatCode_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vw@CustomFormatCode_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_@CustomFormatCode') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_@CustomFormatCode];
GO
IF OBJECT_ID('U_@CustomFormatCode_Trailer') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_Trailer];
GO
IF OBJECT_ID('U_@CustomFormatCode_Header') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_Header];
GO
IF OBJECT_ID('U_@CustomFormatCode_File') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_File];
GO
IF OBJECT_ID('U_@CustomFormatCode_EEList') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_EEList];
GO
IF OBJECT_ID('U_@CustomFormatCode_ContactPointListClose') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_ContactPointListClose];
GO
IF OBJECT_ID('U_@CustomFormatCode_ContactPointList') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_ContactPointList];
GO
IF OBJECT_ID('U_@CustomFormatCode_ContactPoint') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_ContactPoint];
GO
IF OBJECT_ID('U_@CustomFormatCode_ContactClose') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_ContactClose];
GO
IF OBJECT_ID('U_@CustomFormatCode_Contact') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_Contact];
GO
IF OBJECT_ID('U_@CustomFormatCode_BatchListClose') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_BatchListClose];
GO
IF OBJECT_ID('U_@CustomFormatCode_BatchList') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_BatchList];
GO
IF OBJECT_ID('U_@CustomFormatCode_Audit') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_Audit];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = '@CustomFormatCode';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = '@CustomFormatCode';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = '@CustomFormatCode';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = '@CustomFormatCode';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = '@CustomFormatCode';
GO

DECLARE @AdhSystemID VARCHAR(12), @FixedFormatName VARCHAR(50);
SET @AdhSystemID = LEFT('@CustomFormatCode' + REPLICATE('0',10),10) + 'Z0';
SET @FixedFormatName = LEFT('@CustomFormatName',50);

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) SELECT 'N','C','Y','0',NULL,NULL,'N',NULL,'N',NULL,'013010','EMPEXPORT','CDE','@CustomFormatCode',@FixedFormatName,'N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_SwitchBox_v2','5000','S','N',@AdhSystemID,'N',NULL,'C','N',NULL,'N';
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvXMLVersion"','1','(''UA''=''T'')',@AdhSystemID,'255','H','01','1','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvContactBatch"','2','(''UA''=''T'')',@AdhSystemID,'255','H','01','256','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvBatchProcessingDirOpen"','3','(''UA''=''T'')',@AdhSystemID,'255','H','01','511','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvAccountID"','4','(''UA''=''T'')',@AdhSystemID,'255','H','01','766','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvBatchProcessingOpt01"','5','(''UA''=''T'')',@AdhSystemID,'255','H','01','1021','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvBatchProcessingOpt02"','6','(''UA''=''T'')',@AdhSystemID,'255','H','01','1276','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvBatchProcessingOpt03"','7','(''UA''=''T'')',@AdhSystemID,'255','H','01','1531','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvBatchProcessingOpt04"','8','(''UA''=''T'')',@AdhSystemID,'255','H','01','1786','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvBatchProcessingOpt05"','9','(''UA''=''T'')',@AdhSystemID,'255','H','01','2041','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvBatchProcessingOpt06"','10','(''UA''=''T'')',@AdhSystemID,'255','H','01','2296','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvBatchProcessingOpt07"','11','(''UA''=''T'')',@AdhSystemID,'255','H','01','2551','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvBatchProcessingOpt08"','12','(''UA''=''T'')',@AdhSystemID,'255','H','01','2806','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvBatchProcessingOpt09"','13','(''UA''=''T'')',@AdhSystemID,'255','H','01','3061','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvBatchProcessingOpt10"','14','(''UA''=''T'')',@AdhSystemID,'255','H','01','3316','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvBatchProcessingOpt11"','15','(''UA''=''T'')',@AdhSystemID,'255','H','01','3571','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvBatchProcessingOpt12"','16','(''UA''=''T'')',@AdhSystemID,'255','H','01','3826','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvBatchProcessingDirClose"','17','(''UA''=''T'')',@AdhSystemID,'255','H','01','4081','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvBatchContactListOpen"','1','(''UA''=''T'')',@AdhSystemID,'255','H','02','1','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvContactOpenEmpNo"','1','(''UA''=''T'')',@AdhSystemID,'100','D','10','1','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvContactFieldFirstName"','2','(''UA''=''T'')',@AdhSystemID,'200','D','10','501','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvContactFieldLastName"','3','(''UA''=''T'')',@AdhSystemID,'200','D','10','1001','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvContactFieldMidInit"','4','(''UA''=''T'')',@AdhSystemID,'200','D','10','1501','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvCustomDepartmentNo"','5','(''UA''=''T'')',@AdhSystemID,'200','D','10','4501','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvCustomDepartmentDesc"','6','(''UA''=''T'')',@AdhSystemID,'300','D','10','4501','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvCustomJobTitle"','7','(''UA''=''T'')',@AdhSystemID,'200','D','10','4501','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvContactFieldLine1"','8','(''UA''=''T'')',@AdhSystemID,'240','D','10','2001','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvContactFieldLine2"','9','(''UA''=''T'')',@AdhSystemID,'240','D','10','2501','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvContactFieldCity"','10','(''UA''=''T'')',@AdhSystemID,'200','D','10','3001','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvContactFieldState"','11','(''UA''=''T'')',@AdhSystemID,'200','D','10','3501','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvCustomLocationCode"','12','(''UA''=''T'')',@AdhSystemID,'200','D','10','4501','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvCustomLocationDesc"','13','(''UA''=''T'')',@AdhSystemID,'200','D','10','4501','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvCustomSupervisor"','14','(''UA''=''T'')',@AdhSystemID,'200','D','10','4501','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvCustomUnitNo"','15','(''UA''=''T'')',@AdhSystemID,'200','D','10','4501','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvCustomUnitDesc"','16','(''UA''=''T'')',@AdhSystemID,'200','D','10','4501','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvCustomEVACGroupLead"','17','(''UA''=''T'')',@AdhSystemID,'200','D','10','4501','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvEmployeeType"','18','(''UA''=''T'')',@AdhSystemID,'200','D','10','4501','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvTimeZone"','19','(''UA''=''T'')',@AdhSystemID,'200','D','10','4501','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvContactPointListOpen"','1','(''UA''=''T'')',@AdhSystemID,'500','D','20','1','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvContactPointOpen"','1','(''UA''=''T'')',@AdhSystemID,'500','D','25','1','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvContactPointField01"','2','(''UA''=''T'')',@AdhSystemID,'500','D','25','501','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvContactPointField02"','3','(''UA''=''T'')',@AdhSystemID,'500','D','25','1001','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvContactPointField03"','4','(''UA''=''T'')',@AdhSystemID,'500','D','25','1501','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvContactPointField04"','5','(''UA''=''T'')',@AdhSystemID,'500','D','25','2001','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvContactPointClose"','7','(''UA''=''T'')',@AdhSystemID,'500','D','25','2501','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvContactPointListClose"','1','(''UA''=''T'')',@AdhSystemID,'500','D','30','1','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvContactClose"','1','(''UA''=''T'')',@AdhSystemID,'500','D','50','1','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvBatchContactListClose"','1','(''UA''=''T'')',@AdhSystemID,'255','T','90','1','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvContactBatchClose"','1','(''UA''=''T'')',@AdhSystemID,'255','T','91','1','','',NULL,NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Test Export',CONVERT(CHAR(8),GETDATE(),112) + '1','EMPEXPORT','TEST','Dec  1 2018  2:18PM','@CustomFormatCode',NULL,NULL,NULL,CONVERT(CHAR(8),GETDATE(),112) + '1','Nov  7 2013  9:12PM','Dec 30 1899 12:00AM',CONVERT(CHAR(8),GETDATE(),112) + '1',NULL,'','',CONVERT(CHAR(8),GETDATE(),112) + '1',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Export',CONVERT(CHAR(8),GETDATE(),112) + '1','EMPEXPORT','SCHEDULED','Dec  1 2018  9:05PM','@CustomFormatCode',NULL,NULL,NULL,CONVERT(CHAR(8),GETDATE(),112) + '1','Jan 29 2014 12:00AM','Dec 30 1899 12:00AM',CONVERT(CHAR(8),GETDATE(),112) + '1',NULL,'','',CONVERT(CHAR(8),GETDATE(),112) + '1',dbo.fn_GetTimedKey(),NULL,'Scheduled_Job',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'On Demand Export',CONVERT(CHAR(8),GETDATE(),112) + '1','EMPEXPORT','ON_DEMAND','Dec  1 2018  4:14PM','@CustomFormatCode',NULL,NULL,NULL,CONVERT(CHAR(8),GETDATE(),112) + '1','Dec  1 2017 12:00AM','Dec  1 2018 12:00AM',CONVERT(CHAR(8),GETDATE(),112) + '1',NULL,'','',CONVERT(CHAR(8),GETDATE(),112) + '1',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','ExportPath','V','@FileExportPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','InitialSort','C','DrvEEID');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','SubSort','C','DrvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','TestPath','V','@TestFilePath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','UDESPath','V','@UDESFilePath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','UseFileName','V','N');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','H01','dbo.U_@CustomFormatCode_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','H02','dbo.U_@CustomFormatCode_BatchList',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D10','dbo.U_@CustomFormatCode_Contact',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D20','dbo.U_@CustomFormatCode_ContactPointList',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D25','dbo.U_@CustomFormatCode_ContactPoint',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D30','dbo.U_@CustomFormatCode_ContactPointListClose',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D50','dbo.U_@CustomFormatCode_ContactClose',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','T90','dbo.U_@CustomFormatCode_BatchListClose',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','T91','dbo.U_@CustomFormatCode_Trailer',NULL);
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
IF OBJECT_ID('U_@CustomFormatCode_EEList') IS NULL
CREATE TABLE [dbo].[U_@CustomFormatCode_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_@CustomFormatCode_File') IS NULL
CREATE TABLE [dbo].[U_@CustomFormatCode_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(max) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_@CustomFormatCode]
	@SystemID VARCHAR(15) = NULL
AS
SET NOCOUNT ON;
/**********************************************************************************
Client: @CustomerName

Created By: @DeveloperName
Integration Analyst: @IntegrationAnalystName
Create Date: @CreateDate
Service Request Number: @SRNumber

Purpose: Send Word Now XML Demographic Export

Revision History
----------------
Update By        Date            Request Num        Desc
XXX              XX/XX/20XX      SR-20XX-00000000   XXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.AscExp WHERE ExpFormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = '@CustomFormatCode' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'ON_DEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'TEST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'SCHEDULED';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = '@CustomFormatCode', @AllObjects = 'Y', @IsWeb = 'Y'
**********************************************************************************/
BEGIN

	--==========================================
	-- Declare variables
	--==========================================
	DECLARE @FormatCode VARCHAR(10)
		,@ExportCode VARCHAR(10)
		,@StartDate DATETIME
		,@EndDate DATETIME
		,@StartPerControl VARCHAR(9)
		,@EndPerControl VARCHAR(9);

	-- Declare dates from Parameter file
	SELECT @StartPerControl = StartPerControl
		,@EndPerControl = EndPerControl
		,@StartDate = CASE WHEN ExportCode = 'SCHEDULED' THEN DATEADD(DAY, - 1, GETDATE())
						   ELSE CAST(LEFT(StartPerControl, 8) AS DATETIME)
					  END
		,@EndDate = CASE WHEN ExportCode = 'SCHEDULED' THEN GETDATE()
						 ELSE DATEADD(SS, - 1, DATEADD(DD, 1, LEFT(EndPerControl, 8)))
					END
		,@FormatCode = FormatCode
		,@ExportCode = ExportCode
	FROM dbo.U_dsi_Parameters WITH (NOLOCK)
	WHERE FormatCode = '@CustomFormatCode';

	--==============
	-- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
	--=============

	-- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
	DELETE FROM dbo.U_@CustomFormatCode_EEList
	WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
	AND xEEID IN (SELECT xEEID FROM dbo.U_@CustomFormatCode_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

	-- Remove Terminated Employees
	DELETE dbo.U_@CustomFormatCode_EEList
	FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
	JOIN dbo.EmpComp WITH (NOLOCK)
		ON EecEEID = xEEID
		AND EecCOID = xCOID
	WHERE EecEmplStatus = 'T';

	-----------------------
	-- Build dbo.U_@CustomFormatCode_Header
	-----------------------
	IF OBJECT_ID('dbo.U_@CustomFormatCode_Header','U') IS NOT NULL
		DROP TABLE dbo.U_@CustomFormatCode_Header;
	SELECT DISTINCT DrvXMLVersion = '<?xml version="1.0"?>'
		,DrvContactBatch = '<contactBatch xmlns="http://www.sendwordnow.com" version="1.0.2">'
		,DrvBatchProcessingDirOpen = '<batchProcessingDirectives>'
		,DrvAccountID = CASE WHEN @ExportCode = 'TEST' THEN '<accountID username="@AccountIdUserNameTEST" />'
							 WHEN dbo.dsi_fnVariable('@CustomFormatCode', 'Testing') = 'Y' THEN '<accountID username="@AccountIdUserNameTEST" />'
							 ELSE '<accountID username="@AccountIdUserName" />'
						END
		,DrvBatchProcessingOpt01 = '<batchProcessingOption name="DeleteContactsNotInBatch" value="true" />'
		,DrvBatchProcessingOpt02 = '' -- '<batchProcessingOption name="DeleteGroupsNotInBatch" value="false" /> '
		,DrvBatchProcessingOpt03 = '' -- '<batchProcessingOption name="DeleteContactsWithoutUniqueID" value="false" /> '
		,DrvBatchProcessingOpt04 = '' -- '<batchProcessingOption name="DeleteGroupsWithContactsWithoutUniqueID" value="false" /> '
		,DrvBatchProcessingOpt05 = '<batchProcessingOption name="MergeContactsInBatch" value="true" /> '
		,DrvBatchProcessingOpt06 = '<batchProcessingOption name="BatchContinueOnContactError" value="true" /> '
		,DrvBatchProcessingOpt07 = '<batchProcessingOption name="BatchContinueOnGroupError" value="true" /> '
		,DrvBatchProcessingOpt08 = '' -- '<batchProcessingOption name="BatchFailureOnMissingModify" value="false" />'
		,DrvBatchProcessingOpt09 = '' -- '<batchProcessingOption name="BatchFailureOnMissingRemove" value="false" /> '
		,DrvBatchProcessingOpt10 = '' -- '<batchProcessingOption name="ReturnContactList" value="false" /> '
		,DrvBatchProcessingOpt11 = '' -- '<batchProcessingOption name="ReturnContactListWithUniqueIDs" value="false" />'
		,DrvBatchProcessingOpt12 = '' -- '<batchProcessingOption name="ReturnContactListWithoutUniqueIDs" value="false" /> '
		,DrvBatchProcessingDirClose = '</batchProcessingDirectives>'
	INTO dbo.U_@CustomFormatCode_Header;

	-----------------------
	-- Build dbo.U_Dsi_DrvTbl_@CustomFormatCode_BatchList
	-----------------------
	IF OBJECT_ID('dbo.U_@CustomFormatCode_BatchList','U') IS NOT NULL
		DROP TABLE dbo.U_@CustomFormatCode_BatchList;
	SELECT DISTINCT DrvBatchContactListOpen = '<batchContactList>'
	INTO dbo.U_@CustomFormatCode_BatchList;

	-----------------------
	-- Build dbo.U_@CustomFormatCode_Contact
	-----------------------
	IF OBJECT_ID('dbo.U_@CustomFormatCode_Contact','U') IS NOT NULL
		DROP TABLE dbo.U_@CustomFormatCode_Contact;
	SELECT DISTINCT DrvSubSort = '01'
		,DrvCOID = xCOID
		,DrvEEID = xEEID
		,DrvContactOpenEmpNo = '<contact contactID="' + RTRIM(ISNULL(EecEmpNo, ''))
								+ CASE WHEN EecEmplStatus <> 'T' THEN '" action="AddOrModify">'
									   ELSE '" action="Remove">'
								  END
		,DrvContactFieldFirstName = '<contactField name="FirstName">' + RTRIM(ISNULL(EepNameFirst, '')) + '</contactField>'
		,DrvContactFieldLastName = '<contactField name="LastName">' + RTRIM(ISNULL(EepNameLast, '')) + '</contactField>'
		,DrvContactFieldMidInit = '<contactField name="MiddleName">' + LEFT(ISNULL(EepNameMiddle, ''), 1) + '</contactField>'
		,DrvCustomDepartmentNo = '<contactField name="CustomField" customName="DepartmentNumber">' + RTRIM(ISNULL(OL1.OrgCode, '')) + '</contactField>'
		,DrvCustomDepartmentDesc = '<contactField name="CustomField" customName="DepartmentDescription">' + REPLACE(dbo.dsi_fnRemoveChars(',', RTRIM(ISNULL(OL1.OrgDesc, ''))), '&', '&amp;') + '</contactField>'
		,DrvCustomJobTitle = '<contactField name="CustomField" customName="Title">' + REPLACE(dbo.dsi_fnRemoveChars(',', RTRIM(ISNULL(JbcLongDesc, ''))), '&', '&amp;') + '</contactField>'
		,DrvContactFieldLine1 = '<contactField name="Address1">' + RTRIM(ISNULL(EepAddressLine1, '')) + '</contactField>'
		,DrvContactFieldLine2 = '<contactField name="Address2">' + RTRIM(ISNULL(EepAddressLine2, '')) + '</contactField>'
		,DrvContactFieldCity = '<contactField name="City">' + RTRIM(ISNULL(EepAddressCity, '')) + '</contactField>'
		,DrvContactFieldState = '<contactField name="State">' + RTRIM(ISNULL(EepAddressState, '')) + '</contactField>'
		,DrvCustomLocationCode = '<contactField name="CustomField" customName="WorkLocation">' + REPLACE(RTRIM(ISNULL(EecLocation, '')), '&', '&amp;') + '</contactField>'
		,DrvCustomLocationDesc = '<contactField name="CustomField" customName="WorkLocationName">' + REPLACE(dbo.dsi_fnRemoveChars(',', RTRIM(ISNULL(LocDesc, ''))), '&', '&amp;') + '</contactField>'
		,DrvCustomSupervisor = '<contactField name="CustomField" customName="Supervisor">' + REPLACE(dbo.dsi_fnRemoveChars(',', RTRIM(ISNULL(SuperName, ''))), '&', '&amp;') + '</contactField>'
		,DrvCustomUnitNo = '<contactField name="CustomField" customName="UnitNumber">' + RTRIM(ISNULL(OL2.OrgCode, '')) + '</contactField>'
		,DrvCustomUnitDesc = '<contactField name="CustomField" customName="UnitDescription">' + REPLACE(dbo.dsi_fnRemoveChars(',', RTRIM(ISNULL(OL2.OrgDesc, ''))), '&', '&amp;') + '</contactField>'
		,DrvCustomEVACGroupLead = CASE WHEN ISNULL(EecUDField05, '') <> '' THEN '<contactField name="CustomField" customName="EVACGroupLeadorOMEST">' + REPLACE(dbo.dsi_fnRemoveChars(',', RTRIM(ISNULL(EecUDField05, ''))), '&', '&amp;') + '</contactField>' END
		,DrvEmployeeType = '<contactField name="CustomField" customName="EmployeeType">' + RTRIM(EecEEType) + '</contactField>'
	INTO dbo.U_@CustomFormatCode_Contact
	FROM dbo.U_@CustomFormatCode_EEList
	JOIN dbo.EmpPers WITH (NOLOCK) ON EepEEID = xEEID
	JOIN dbo.EmpComp WITH (NOLOCK) ON EecEEID = xEEID
		AND EecCOID = xCOID
	JOIN dbo.Company WITH (NOLOCK) ON EecCoID = CmpCoID
	LEFT JOIN dbo.JobCode WITH (NOLOCK) ON JbcJobCode = EecJobCode
	LEFT JOIN dbo.Location WITH (NOLOCK) ON LocCode = EecLocation
	LEFT JOIN dbo.EmpMPhon a WITH (NOLOCK) ON a.EfoEEID = xEEID
		AND a.efoPhoneType = 'CEL'
		AND a.AuditKey IN (SELECT MAX(b.AuditKey) FROM dbo.EmpMPhon b WHERE b.efoeeid = xEEID AND b.efoPhoneType = 'CEL')
	LEFT JOIN dbo.OrgLevel OL1 WITH (NOLOCK) ON OL1.OrgCode = EecOrgLvl1
		AND OL1.OrgLvl = '1'
	LEFT JOIN dbo.OrgLevel OL2 WITH (NOLOCK) ON OL2.OrgCode = EecOrgLvl2
		AND OL2.OrgLvl = '2'
	LEFT JOIN (
		SELECT EepEEID supEEID
			,RTRIM(EepNameFirst) + ' ' + RTRIM(ISNULL(EepNameMiddle, '')) + ' ' + RTRIM(EepNameLast) SuperName
		FROM dbo.EmpPers
	) SupName
		ON supEEID = EecSupervisorID;

	-----------------------
	-- Build dbo.U_@CustomFormatCode_ContactPointList
	-----------------------
	IF OBJECT_ID('dbo.U_@CustomFormatCode_ContactPointList','U') IS NOT NULL
		DROP TABLE dbo.U_@CustomFormatCode_ContactPointList;
	SELECT DISTINCT DrvSubSort = '02'
		,DrvCOID
		,DrvEEID
		,DrvContactPointListOpen = '<contactPointList>'
	INTO dbo.U_@CustomFormatCode_ContactPointList
	FROM dbo.U_@CustomFormatCode_Contact;

	-----------------------
	-- Build dbo.U_@CustomFormatCode_ContactPoint
	-----------------------
	IF OBJECT_ID('dbo.U_@CustomFormatCode_ContactPoint','U') IS NOT NULL
		DROP TABLE dbo.U_@CustomFormatCode_ContactPoint;
	CREATE TABLE [dbo].[U_@CustomFormatCode_ContactPoint] (
		[DrvSubSort] [VARCHAR](255) NULL
		,[DrvCOID] [VARCHAR](6) NULL
		,[DrvEEID] [VARCHAR](20) NULL
		,[DrvContactPointOpen] [VARCHAR](255) NULL
		,[DrvContactPointField01] [VARCHAR](255) NULL
		,[DrvContactPointField02] [VARCHAR](255) NULL
		,[DrvContactPointField03] [VARCHAR](255) NULL
		,[DrvContactPointField04] [VARCHAR](255) NULL
		,[DrvContactPointClose] [VARCHAR](255) NULL
	) ON [PRIMARY];

	INSERT INTO dbo.U_@CustomFormatCode_ContactPoint
	SELECT DISTINCT DrvSubSort = '03-1'
		,DrvCOID
		,DrvEEID
		,DrvContactPointOpen = '<contactPoint type="Voice">'
		,DrvContactPointField01 = '<contactPointField name="Label">Cell Phone</contactPointField>'
		,DrvContactPointField02 = '<contactPointField name="CountryCode">1</contactPointField>'
		,DrvContactPointField03 = '<contactPointField name="Number">' + RTRIM(ISNULL(EfoPhoneNumber, '')) + '</contactPointField>'
		,DrvContactPointField04 = ''
		,DrvContactPointClose = '</contactPoint>'
	FROM dbo.U_@CustomFormatCode_Contact
	JOIN dbo.EmpMPhon a WITH (NOLOCK) ON a.EfoEEID = drvEEID
		AND a.efoPhoneType = 'CEL'
		AND a.AuditKey IN (SELECT MAX(b.AuditKey) FROM dbo.EmpMPhon b WHERE b.efoeeid = drvEEID AND b.efoPhoneType = 'CEL');

	INSERT INTO dbo.U_@CustomFormatCode_ContactPoint
	SELECT DISTINCT DrvSubSort = '03-2'
		,DrvCOID
		,DrvEEID
		,DrvContactPointOpen = '<contactPoint type="Voice">'
		,DrvContactPointField01 = '<contactPointField name="Label">Home Phone</contactPointField>'
		,DrvContactPointField02 = '<contactPointField name="CountryCode">1</contactPointField>'
		,DrvContactPointField03 = '<contactPointField name="Number">' + RTRIM(COALESCE(EepPhoneHomeNumber, a.efoPhoneNUmber)) + '</contactPointField>'
		,DrvContactPointField04 = ''
		,DrvContactPointClose = '</contactPoint>'
	FROM dbo.U_@CustomFormatCode_Contact
	LEFT JOIN dbo.EmpPers WITH (NOLOCK) ON EepEEID = DrvEEID
	LEFT JOIN dbo.EmpMPhon a WITH (NOLOCK) ON a.efoEEID = drvEEID
		AND a.efoPhoneType = 'HOM'
		AND a.AuditKey IN (SELECT MAX(b.AuditKey) FROM dbo.EmpMPhon b WHERE b.efoeeid = a.efoEEID AND b.efoPhoneType = 'HOM')
	WHERE (ISNULL(EepPhoneHomeNumber, '') <> ''
		OR ISNULL(a.efoPhoneNumber, '') <> ''
	);

	INSERT INTO dbo.U_@CustomFormatCode_ContactPoint
	SELECT DISTINCT DrvSubSort = '03-3'
		,DrvCOID
		,DrvEEID
		,DrvContactPointOpen = '<contactPoint type="Voice">'
		,DrvContactPointField01 = '<contactPointField name="Label">Work Phone</contactPointField>'
		,DrvContactPointField02 = '<contactPointField name="CountryCode">1</contactPointField>'
		,DrvContactPointField03 = '<contactPointField name="Number">' + RTRIM(COALESCE(EecPhoneBusinessNumber, EfoPhoneNumber)) + '</contactPointField>'
		,DrvContactPointField04 = ''
		,DrvContactPointClose = '</contactPoint>'
	FROM dbo.U_@CustomFormatCode_Contact
	JOIN dbo.EmpComp WITH (NOLOCK) ON EecEEID = DrvEEID
		AND EecCoID = DrvCOID
	LEFT JOIN dbo.EmpMPhon a WITH (NOLOCK) ON a.efoEEID = drvEEID
		AND a.efoPhoneType = 'WRK'
		AND a.AuditKey IN (SELECT MAX(b.AuditKey) FROM dbo.EmpMPhon b WHERE b.efoeeid = a.efoEEID AND b.efoPhoneType = 'WRK')
	WHERE (ISNULL(EecPhoneBusinessNumber, '') <> ''
		OR ISNULL(a.efoPhoneNumber, '') <> ''
	);

	INSERT INTO dbo.U_@CustomFormatCode_ContactPoint
	SELECT DISTINCT DrvSubSort = '03-4'
		,DrvCOID
		,DrvEEID
		,DrvContactPointOpen = '<contactPoint type="Voice">'
		,DrvContactPointField01 = '<contactPointField name="Label">Other Phone</contactPointField>'
		,DrvContactPointField02 = '<contactPointField name="CountryCode">1</contactPointField>'
		,DrvContactPointField03 = '<contactPointField name="Number">' + RTRIM(ISNULL(EfoPhoneNumber, '')) + '</contactPointField>'
		,DrvContactPointField04 = ''
		,DrvContactPointClose = '</contactPoint>'
	FROM dbo.U_@CustomFormatCode_Contact
	JOIN dbo.EmpMPhon a WITH (NOLOCK) ON a.EfoEEID = drvEEID
		AND a.efoPhoneType = 'OTH'
		AND a.AuditKey IN (SELECT MAX(b.AuditKey) FROM dbo.EmpMPhon b WHERE b.efoeeid = drvEEID AND b.efoPhoneType = 'OTH');

	INSERT INTO dbo.U_@CustomFormatCode_ContactPoint
	SELECT DISTINCT DrvSubSort = '03-5'
		,DrvCOID
		,DrvEEID
		,DrvContactPointOpen = '<contactPoint type="Email">'
		,DrvContactPointField01 = '<contactPointField name="Label">Work Email</contactPointField>'
		,DrvContactPointField02 = '<contactPointField name="Address">' + RTRIM(ISNULL(EepAddressEmail, '')) + '</contactPointField>'
		,DrvContactPointField03 = ''
		,DrvContactPointField04 = ''
		,DrvContactPointClose = '</contactPoint>'
	FROM dbo.U_@CustomFormatCode_Contact
	JOIN dbo.EmpPers WITH (NOLOCK) ON EepEEID = DrvEEID
	WHERE ISNULL(EepAddressEmail, '') <> '';

	INSERT INTO dbo.U_@CustomFormatCode_ContactPoint
	SELECT DISTINCT DrvSubSort = '03-6'
		,DrvCOID
		,DrvEEID
		,DrvContactPointOpen = '<contactPoint type="Email">'
		,DrvContactPointField01 = '<contactPointField name="Label">Personal Email</contactPointField>'
		,DrvContactPointField02 = '<contactPointField name="Address">' + RTRIM(ISNULL(EepAddressEmailAlternate, '')) + '</contactPointField>'
		,DrvContactPointField03 = ''
		,DrvContactPointField04 = ''
		,DrvContactPointClose = '</contactPoint>'
	FROM dbo.U_@CustomFormatCode_Contact
	JOIN dbo.EmpPers WITH (NOLOCK) ON EepEEID = DrvEEID
	WHERE ISNULL(EepAddressEmailAlternate, '') <> '';

	INSERT INTO dbo.U_@CustomFormatCode_ContactPoint
	SELECT DISTINCT DrvSubSort = '03-7'
		,DrvCOID
		,DrvEEID
		,DrvContactPointOpen = '<contactPoint type="TextMessage">'
		,DrvContactPointField01 = '<contactPointField name="Label">SMS</contactPointField>'
		,DrvContactPointField02 = '<contactPointField name="Carrier">SWN Global SMS</contactPointField>'
		,DrvContactPointField03 = '<contactPointField name="Number">1' + LTRIM(RTRIM(ISNULL(EfoPhoneNumber, ''))) + '</contactPointField>'
		,DrvContactPointField04 = ''
		,DrvContactPointClose = '</contactPoint>'
	FROM dbo.U_@CustomFormatCode_Contact
	JOIN dbo.EmpMPhon a WITH (NOLOCK) ON a.EfoEEID = drvEEID
		AND a.efoPhoneType = 'CEL'
		AND a.AuditKey IN (SELECT MAX(b.AuditKey) FROM dbo.EmpMPhon b WHERE b.efoeeid = drvEEID AND b.efoPhoneType = 'CEL');

	--==================================
	-- Add a blank HOME PHONE if the employee has no Contact Points
	--==================================
	INSERT INTO dbo.U_@CustomFormatCode_ContactPoint
	SELECT DISTINCT DrvSubSort = '03-2'
		,DrvCOID
		,DrvEEID
		,DrvContactPointOpen = '<contactPoint type="Voice">'
		,DrvContactPointField01 = '<contactPointField name="Label">Home Phone</contactPointField>'
		,DrvContactPointField02 = '<contactPointField name="CountryCode"></contactPointField>'
		,DrvContactPointField03 = '<contactPointField name="Number"></contactPointField>'
		,DrvContactPointField04 = ''
		,DrvContactPointClose = '</contactPoint>'
	FROM dbo.U_@CustomFormatCode_Contact CPL
	WHERE CPL.drvEEID + CPL.drvCOID NOT IN (SELECT PT.drvEEID + PT.drvCOID FROM dbo.U_@CustomFormatCode_ContactPoint PT WITH (NOLOCK) WHERE PT.drvEEID = CPL.drvEEID AND PT.drvCOID = CPL.drvCOID);

	-----------------------
	-- Build dbo.U_@CustomFormatCode_ContactPointListClose
	-----------------------
	IF OBJECT_ID('dbo.U_@CustomFormatCode_ContactPointListClose','U') IS NOT NULL
		DROP TABLE dbo.U_@CustomFormatCode_ContactPointListClose;
	SELECT DrvSubSort = '09'
		,DrvCOID
		,DrvEEID
		,DrvContactPointListClose = '</contactPointList>'
	INTO dbo.U_@CustomFormatCode_ContactPointListClose
	FROM dbo.U_@CustomFormatCode_ContactPointList;

	-----------------------
	-- Build dbo.U_@CustomFormatCode_ContactClose
	-----------------------
	IF OBJECT_ID('dbo.U_@CustomFormatCode_ContactClose','U') IS NOT NULL
		DROP TABLE dbo.U_@CustomFormatCode_ContactClose;
	SELECT DrvSubSort = '10'
		,DrvCOID
		,DrvEEID
		,DrvContactClose = '</contact>'
	INTO dbo.U_@CustomFormatCode_ContactClose
	FROM dbo.U_@CustomFormatCode_Contact;

	-----------------------
	-- Build dbo.U_@CustomFormatCode_BatchListClose
	-----------------------
	IF OBJECT_ID('dbo.U_@CustomFormatCode_BatchListClose','U') IS NOT NULL
		DROP TABLE dbo.U_@CustomFormatCode_BatchListClose;
	SELECT DrvBatchContactListClose = '</batchContactList>'
	INTO dbo.U_@CustomFormatCode_BatchListClose;

	-----------------------
	-- Build dbo.U_Dsi_DrvTbl_@CustomFormatCode_Trailer
	-----------------------
	IF OBJECT_ID('dbo.U_@CustomFormatCode_Trailer','U') IS NOT NULL
		DROP TABLE dbo.U_@CustomFormatCode_Trailer;
	SELECT DrvContactBatchClose = '</contactBatch>'
	INTO dbo.U_@CustomFormatCode_Trailer;

	--==================================================
    -- Set FileName
    --==================================================
	DECLARE @DateTime VARCHAR(30);
	SET @DateTime = REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR(30), GETDATE(), 120), ':', ''), '-', ''), ' ', '');

    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
		UPDATE dbo.U_dsi_Parameters
		SET ExportFile = 'writing_request_' + @DateTime + '.xml'
		WHERE FormatCode = @FormatCode;
	END;

END;
/**********************************************************************************
--Alter the View
ALTER VIEW dbo.dsi_vw@CustomFormatCode_Export AS
	SELECT TOP 2000000 DATA FROM dbo.U_@CustomFormatCode_File WITH (NOLOCK)
	ORDER BY CASE recordset
				  WHEN 'H01' THEN 1
				  WHEN 'H02' THEN 2
				  WHEN 'T90' THEN 4
				  WHEN 'T91' THEN 5
				  ELSE 3
			END
		,InitialSort
		,SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID IN (SELECT AdhSystemID FROM dbo.AscDefH WHERE AdhFormatCode = '@CustomFormatCode')
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET ExpLastStartPerControl = '201812011'
       ,ExpStartPerControl     = '201812011'
       ,ExpLastEndPerControl   = '201812019'
       ,ExpEndPerControl       = '201812019'
WHERE ExpFormatCode = '@CustomFormatCode';
**********************************************************************************/
GO
CREATE VIEW [dbo].[dsi_vw@CustomFormatCode_Export] AS
	SELECT TOP 2000000 DATA FROM dbo.U_@CustomFormatCode_File WITH (NOLOCK)
	ORDER BY CASE recordset
				  WHEN 'H01' THEN 1
				  WHEN 'H02' THEN 2
				  WHEN 'T90' THEN 4
				  WHEN 'T91' THEN 5
				  ELSE 3
			END
		,InitialSort
		,SubSort;
GO