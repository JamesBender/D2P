SET NOCOUNT ON;
IF OBJECT_ID('U_ETASCCBRNH_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ETASCCBRNH_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ETASCCBRNH_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ETASCCBRNH' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwETASCCBRNH_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwETASCCBRNH_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ETASCCBRNH') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ETASCCBRNH];
GO
IF OBJECT_ID('U_ETASCCBRNH_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ETASCCBRNH_PEarHist];
GO
IF OBJECT_ID('U_ETASCCBRNH_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ETASCCBRNH_PDedHist];
GO
IF OBJECT_ID('U_ETASCCBRNH_File') IS NOT NULL DROP TABLE [dbo].[U_ETASCCBRNH_File];
GO
IF OBJECT_ID('U_ETASCCBRNH_EEList') IS NOT NULL DROP TABLE [dbo].[U_ETASCCBRNH_EEList];
GO
IF OBJECT_ID('U_ETASCCBRNH_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ETASCCBRNH_drvTbl];
GO
IF OBJECT_ID('U_ETASCCBRNH_DedList') IS NOT NULL DROP TABLE [dbo].[U_ETASCCBRNH_DedList];
GO
IF OBJECT_ID('U_ETASCCBRNH_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ETASCCBRNH_AuditFields];
GO
IF OBJECT_ID('U_ETASCCBRNH_Audit') IS NOT NULL DROP TABLE [dbo].[U_ETASCCBRNH_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_ETASCCBRNH') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ETASCCBRNH];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ETASCCBRNH';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ETASCCBRNH';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ETASCCBRNH';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ETASCCBRNH';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ETASCCBRNH';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ETASCCBRNH','TASC Cobra NH Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','ETASCCBRNHZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MyTASC Client ID"','1','(''DA''=''T,'')','ETASCCBRNHZ0','50','H','01','1',NULL,'MyTASC Client ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CSA ID"','2','(''DA''=''T,'')','ETASCCBRNHZ0','50','H','01','2',NULL,'CSA ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SSN"','3','(''DA''=''T,'')','ETASCCBRNHZ0','50','H','01','3',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LastName"','4','(''DA''=''T,'')','ETASCCBRNHZ0','50','H','01','4',NULL,'LastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FirstName"','5','(''DA''=''T,'')','ETASCCBRNHZ0','50','H','01','5',NULL,'FirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MiddleInit"','6','(''DA''=''T,'')','ETASCCBRNHZ0','50','H','01','6',NULL,'MiddleInit',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Addr1"','7','(''DA''=''T,'')','ETASCCBRNHZ0','50','H','01','7',NULL,'Addr1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Addr2"','8','(''DA''=''T,'')','ETASCCBRNHZ0','50','H','01','8',NULL,'Addr2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Addr3"','9','(''DA''=''T,'')','ETASCCBRNHZ0','50','H','01','9',NULL,'Addr3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"City"','10','(''DA''=''T,'')','ETASCCBRNHZ0','50','H','01','10',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"State"','11','(''DA''=''T,'')','ETASCCBRNHZ0','50','H','01','11',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Zip"','12','(''DA''=''T,'')','ETASCCBRNHZ0','50','H','01','12',NULL,'Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Country"','13','(''DA''=''T,'')','ETASCCBRNHZ0','50','H','01','13',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AreaCode"','14','(''DA''=''T,'')','ETASCCBRNHZ0','50','H','01','14',NULL,'AreaCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HomePhone"','15','(''DA''=''T,'')','ETASCCBRNHZ0','50','H','01','15',NULL,'HomePhone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Gender"','16','(''DA''=''T,'')','ETASCCBRNHZ0','50','H','01','16',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DateofBirth"','17','(''DA''=''T,'')','ETASCCBRNHZ0','50','H','01','17',NULL,'DateofBirth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"QBRelationshipCode"','18','(''DA''=''T,'')','ETASCCBRNHZ0','50','H','01','18',NULL,'QBRelationshipCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EmpSSN"','19','(''DA''=''T,'')','ETASCCBRNHZ0','50','H','01','19',NULL,'EmpSSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EmpLastName"','20','(''DA''=''T,'')','ETASCCBRNHZ0','50','H','01','20',NULL,'EmpLastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EmpFirstName"','21','(''DA''=''T,'')','ETASCCBRNHZ0','50','H','01','21',NULL,'EmpFirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EmpMiddleInit"','22','(''DA''=''T,'')','ETASCCBRNHZ0','50','H','01','22',NULL,'EmpMiddleInit',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EmpHireDate"','23','(''DA''=''T'')','ETASCCBRNHZ0','50','H','01','23',NULL,'EmpHireDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"4319-5964-5807"','1','(''DA''=''T,'')','ETASCCBRNHZ0','50','D','10','1',NULL,'MyTASC Client ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"43483"','2','(''DA''=''T,'')','ETASCCBRNHZ0','50','D','10','2',NULL,'CSA ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvParticipantSSN"','3','(''UA''=''T,'')','ETASCCBRNHZ0','50','D','10','3',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvParticipantNameLast"','4','(''UA''=''T,'')','ETASCCBRNHZ0','50','D','10','4',NULL,'LastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvParticipantNameFirst"','5','(''UA''=''T,'')','ETASCCBRNHZ0','50','D','10','5',NULL,'FirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvParticipantMiddleInitial"','6','(''UA''=''T,'')','ETASCCBRNHZ0','50','D','10','6',NULL,'MiddleInit',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvParticipantAddressLine1"','7','(''UA''=''T,'')','ETASCCBRNHZ0','50','D','10','7',NULL,'Addr1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvParticipantAddressLine2"','8','(''UA''=''T,'')','ETASCCBRNHZ0','50','D','10','8',NULL,'Addr2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''DA''=''T,'')','ETASCCBRNHZ0','50','D','10','9',NULL,'Addr3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvParticipantAddressCity"','10','(''UA''=''T,'')','ETASCCBRNHZ0','50','D','10','10',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvParticipantAddressState"','11','(''UA''=''T,'')','ETASCCBRNHZ0','50','D','10','11',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvParticipantAddressZip"','12','(''UA''=''T,'')','ETASCCBRNHZ0','50','D','10','12',NULL,'Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvParticipantCountry"','13','(''UA''=''T,'')','ETASCCBRNHZ0','50','D','10','13',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvParticipantAreaCode"','14','(''UA''=''T,'')','ETASCCBRNHZ0','50','D','10','14',NULL,'AreaCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartPhoneNumberHome"','15','(''UA''=''T,'')','ETASCCBRNHZ0','50','D','10','15',NULL,'HomePhone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvParticipantGender"','16','(''UA''=''T,'')','ETASCCBRNHZ0','50','D','10','16',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvParticipantDateOfBirth"','17','(''UDMDY''=''T,'')','ETASCCBRNHZ0','50','D','10','17',NULL,'DateofBirth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartRelationshipCode"','18','(''UA''=''T,'')','ETASCCBRNHZ0','50','D','10','18',NULL,'QBRelationshipCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','19','(''UA''=''T,'')','ETASCCBRNHZ0','50','D','10','19',NULL,'EmpSSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','20','(''UA''=''T,'')','ETASCCBRNHZ0','50','D','10','20',NULL,'EmpLastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','21','(''UA''=''T,'')','ETASCCBRNHZ0','50','D','10','21',NULL,'EmpFirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','22','(''UA''=''T,'')','ETASCCBRNHZ0','50','D','10','22',NULL,'EmpMiddleInit',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpHireDate"','23','(''UDMDY''=''T'')','ETASCCBRNHZ0','50','D','10','23',NULL,'EmpHireDate',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ETASCCBRNH_20200724.txt',NULL,'','','',NULL,NULL,NULL,'TASC Cobra NH Export','202007239','EMPEXPORT','ONDEMAND','Jul 23 2020  1:46PM','ETASCCBRNH',NULL,NULL,NULL,'202007239','Jul 20 2020  5:41PM','Jul 20 2020  5:41PM','202007011','2373','','','202007011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ETASCCBRNH_20200724.txt',NULL,'','','',NULL,NULL,NULL,'Scheduled Session','202007239','EMPEXPORT','SCHEDULED','Jul 23 2020  1:48PM','ETASCCBRNH',NULL,NULL,NULL,'202007239','Jul 20 2020  5:41PM','Jul 20 2020  5:41PM','202007011','2373','','','202007011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ETASCCBRNH_20200724.txt',NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','202007239','EMPEXPORT','OEACTIVE','Jul 23 2020  1:41PM','ETASCCBRNH',NULL,NULL,NULL,'202007239','Jul 20 2020  5:41PM','Jul 20 2020  5:41PM','202007011','2256','','','202007011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ETASCCBRNH_20200724.txt',NULL,'','','',NULL,NULL,NULL,'Passive Open Enrollment Export','202007239','EMPEXPORT','OEPASSIVE','Jul 23 2020  1:43PM','ETASCCBRNH',NULL,NULL,NULL,'202007239','Jul 20 2020  5:41PM','Jul 20 2020  5:41PM','202007011','2260','','','202007011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ETASCCBRNH_20200724.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202007239','EMPEXPORT','TEST','Jul 23 2020  3:20PM','ETASCCBRNH',NULL,NULL,NULL,'202007239','Jul 23 2020 12:00AM','Dec 30 1899 12:00AM','202007011','1994','','','202007011',dbo.fn_GetTimedKey(),NULL,'us3cPeHOF1002',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_ETASCCBRNH_20200724.txt' END WHERE expFormatCode = 'ETASCCBRNH';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETASCCBRNH','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETASCCBRNH','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETASCCBRNH','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETASCCBRNH','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETASCCBRNH','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'ETASCCBRNH' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ETASCCBRNH' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_ETASCCBRNH_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ETASCCBRNH_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ETASCCBRNH','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ETASCCBRNH','D10','dbo.U_ETASCCBRNH_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_ETASCCBRNH') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ETASCCBRNH] (
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
IF OBJECT_ID('U_ETASCCBRNH_Audit') IS NULL
CREATE TABLE [dbo].[U_ETASCCBRNH_Audit] (
    [audEEID] char(12) NULL,
    [audCOID] char(5) NULL,
    [audConSystemID] varchar(255) NULL,
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
IF OBJECT_ID('U_ETASCCBRNH_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ETASCCBRNH_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_ETASCCBRNH_DedList') IS NULL
CREATE TABLE [dbo].[U_ETASCCBRNH_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ETASCCBRNH_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ETASCCBRNH_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(14) NULL,
    [drvParticipantSSN] char(11) NULL,
    [drvParticipantNameLast] varchar(100) NULL,
    [drvParticipantNameFirst] varchar(100) NULL,
    [drvParticipantMiddleInitial] varchar(1) NULL,
    [drvParticipantAddressLine1] varchar(257) NULL,
    [drvParticipantAddressLine2] varchar(255) NULL,
    [drvParticipantAddressCity] varchar(255) NULL,
    [drvParticipantAddressState] varchar(255) NULL,
    [drvParticipantAddressZip] varchar(50) NULL,
    [drvParticipantCountry] char(3) NULL,
    [drvParticipantAreaCode] varchar(3) NULL,
    [drvPartPhoneNumberHome] varchar(7) NULL,
    [drvParticipantGender] char(1) NULL,
    [drvParticipantDateOfBirth] datetime NULL,
    [drvPartRelationshipCode] varchar(8) NULL,
    [drvSSN] char(11) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvEmpHireDate] datetime NULL
);
IF OBJECT_ID('U_ETASCCBRNH_EEList') IS NULL
CREATE TABLE [dbo].[U_ETASCCBRNH_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ETASCCBRNH_File') IS NULL
CREATE TABLE [dbo].[U_ETASCCBRNH_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
IF OBJECT_ID('U_ETASCCBRNH_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ETASCCBRNH_PDedHist] (
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
IF OBJECT_ID('U_ETASCCBRNH_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ETASCCBRNH_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ETASCCBRNH]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Hoffmaster Group

Created By: James Bender
Business Analyst: Cheryl Petitti
Create Date: 07/20/2020
Service Request Number: TekP-2019-06-29-0003

Purpose: TASC Cobra NH Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ETASCCBRNH';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ETASCCBRNH';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ETASCCBRNH';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ETASCCBRNH';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ETASCCBRNH' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETASCCBRNH', 'TEST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETASCCBRNH', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETASCCBRNH', 'OEACTIVE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ETASCCBRNH';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ETASCCBRNH', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ETASCCBRNH';

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
    -- Audit Code
    --==========================================
    -- Get data from audit fields table.  Add fields here if auditing
    IF OBJECT_ID('U_ETASCCBRNH_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ETASCCBRNH_AuditFields;
    CREATE TABLE dbo.U_ETASCCBRNH_AuditFields (aTableName VARCHAR(30),aFieldName VARCHAR(30));
    -- Employee Information
    INSERT INTO dbo.U_ETASCCBRNH_AuditFields VALUES ('EmpPers','EepSSN');
    INSERT INTO dbo.U_ETASCCBRNH_AuditFields VALUES ('EmpPers','EepNameFirst');
    INSERT INTO dbo.U_ETASCCBRNH_AuditFields VALUES ('EmpPers','EepNameLast');
    INSERT INTO dbo.U_ETASCCBRNH_AuditFields VALUES ('EmpPers','EepNameMiddle');
    INSERT INTO dbo.U_ETASCCBRNH_AuditFields VALUES ('EmpPers','EepNamePrefix');
    INSERT INTO dbo.U_ETASCCBRNH_AuditFields VALUES ('EmpPers','EepNameSuffix');
    INSERT INTO dbo.U_ETASCCBRNH_AuditFields VALUES ('EmpPers','EepAddressLine1');
    INSERT INTO dbo.U_ETASCCBRNH_AuditFields VALUES ('EmpPers','EepAddressLine2');
    INSERT INTO dbo.U_ETASCCBRNH_AuditFields VALUES ('EmpPers','EepAddressCity');
    INSERT INTO dbo.U_ETASCCBRNH_AuditFields VALUES ('EmpPers','EepAddressState');
    INSERT INTO dbo.U_ETASCCBRNH_AuditFields VALUES ('EmpPers','EepAddressZipCode');
    INSERT INTO dbo.U_ETASCCBRNH_AuditFields VALUES ('EmpPers','EepAddressCountry');
    INSERT INTO dbo.U_ETASCCBRNH_AuditFields VALUES ('EmpPers','EepGender');
    INSERT INTO dbo.U_ETASCCBRNH_AuditFields VALUES ('EmpPers','EepDateOfBirth');
    INSERT INTO dbo.U_ETASCCBRNH_AuditFields VALUES ('EmpPers','EepIsDisabled');
    INSERT INTO dbo.U_ETASCCBRNH_AuditFields VALUES ('EmpPers','EepMaritalStatus');
    INSERT INTO dbo.U_ETASCCBRNH_AuditFields VALUES ('EmpPers','EepPhoneHomeHumber');
    INSERT INTO dbo.U_ETASCCBRNH_AuditFields VALUES ('EmpComp','EecDateOfLastHire');
    INSERT INTO dbo.U_ETASCCBRNH_AuditFields VALUES ('EmpComp','EecDateOfTermination');
    -- Dependent Information
    INSERT INTO dbo.U_ETASCCBRNH_AuditFields VALUES ('Contacts','ConSSN');
    INSERT INTO dbo.U_ETASCCBRNH_AuditFields VALUES ('Contacts','ConNameFirst');
    INSERT INTO dbo.U_ETASCCBRNH_AuditFields VALUES ('Contacts','ConNameLast');
    INSERT INTO dbo.U_ETASCCBRNH_AuditFields VALUES ('Contacts','ConNameMiddle');
    INSERT INTO dbo.U_ETASCCBRNH_AuditFields VALUES ('Contacts','ConNameSuffix');
    INSERT INTO dbo.U_ETASCCBRNH_AuditFields VALUES ('Contacts','ConDateOfBirth');
    INSERT INTO dbo.U_ETASCCBRNH_AuditFields VALUES ('Contacts','ConIsDisabled');
    INSERT INTO dbo.U_ETASCCBRNH_AuditFields VALUES ('Contacts','ConRelationship');
    INSERT INTO dbo.U_ETASCCBRNH_AuditFields VALUES ('Contacts','ConAddressLine1');
    INSERT INTO dbo.U_ETASCCBRNH_AuditFields VALUES ('Contacts','ConAddressLine2');
    INSERT INTO dbo.U_ETASCCBRNH_AuditFields VALUES ('Contacts','ConAddressCity');
    INSERT INTO dbo.U_ETASCCBRNH_AuditFields VALUES ('Contacts','ConAddressState');
    INSERT INTO dbo.U_ETASCCBRNH_AuditFields VALUES ('Contacts','ConAddressZipCode');
    INSERT INTO dbo.U_ETASCCBRNH_AuditFields VALUES ('Contacts','ConAddressCountry');
    -- Employee Deduction/Benefit Information
    INSERT INTO dbo.U_ETASCCBRNH_AuditFields VALUES ('EmpDed','EedDedCode');
    INSERT INTO dbo.U_ETASCCBRNH_AuditFields VALUES ('EmpDed','EedBenStatus');
    INSERT INTO dbo.U_ETASCCBRNH_AuditFields VALUES ('EmpDed','EedBenOption');
    INSERT INTO dbo.U_ETASCCBRNH_AuditFields VALUES ('EmpDed','EedBenStartDate');
    INSERT INTO dbo.U_ETASCCBRNH_AuditFields VALUES ('EmpDed','EedBenStopDate');
    -- Dependent Deduction/Benefit Information
    INSERT INTO dbo.U_ETASCCBRNH_AuditFields VALUES ('DepBPlan','DbnDedCode');
    INSERT INTO dbo.U_ETASCCBRNH_AuditFields VALUES ('DepBPlan','DbnBenStatus');
    INSERT INTO dbo.U_ETASCCBRNH_AuditFields VALUES ('DepBPlan','DbnBenStartDate');
    INSERT INTO dbo.U_ETASCCBRNH_AuditFields VALUES ('DepBPlan','DbnBenStopDate');
    -- Deduction/Benefit Information
    --INSERT INTO dbo.U_ETASCCBRNH_AuditFields VALUES ('DedCode','DedBenAmt');
    --INSERT INTO dbo.U_ETASCCBRNH_AuditFields VALUES ('DedCode','DedBenAmtRateOrPct');
    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ETASCCBRNH_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ETASCCBRNH_Audit;
    SELECT audEEID = xEEID
        ,audCOID = xCOID
        ,audConSystemID =  CASE WHEN audTableName = 'Contacts' THEN audKey3Value
                                WHEN audTableName = 'DepBPlan' THEN DbnDepRecID
                           END
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
        ,audDedChange = CASE WHEN audTableName IN ('EmpDed','DepBPlan','DedCode') THEN 'Y'
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
    INTO dbo.U_ETASCCBRNH_Audit
    FROM dbo.U_ETASCCBRNH_EEList WITH (NOLOCK)
    JOIN dbo.vw_AuditData WITH (NOLOCK)
        ON xEEID = audKey1Value
    JOIN dbo.U_ETASCCBRNH_AuditFields WITH (NOLOCK)
        ON aTableName = audTableName
        AND aFieldName = audFieldName
    LEFT JOIN dbo.DepBPlan WITH (NOLOCK)
        ON DbnEEID = xEEID
        AND DbnDedCode = audKey2Value
        AND DbnSystemID = audKey3Value
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND ISNULL(audNewValue, '') <> ''
    AND ((audTableName NOT IN ('EmpDed','DepBPlan'))
        OR (audTableName = 'EmpDed' AND audKey3Value IN (SELECT DedCode FROM dbo.U_ETASCCBRNH_DedList))
        OR (audTableName = 'DepBPlan' AND audKey2Value IN (SELECT DedCode FROM dbo.U_ETASCCBRNH_DedList))
    );

    --================
    -- Changes Only
    --================
    IF (@Exportcode NOT IN ('FULLFILE','OEACTIVE','OEPASSIVE'))
    BEGIN
        -- Remove Employees with No Changes in Audit
        DELETE FROM dbo.U_ETASCCBRNH_EELIST
        WHERE NOT EXISTS (SELECT 1 FROM dbo.U_ETASCCBRNH_Audit WHERE audEEID = xEEID AND audRowNo = 1);
    END;




















    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_ETASCCBRNH_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ETASCCBRNH_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'FSALD,FSA,DEN,DENOC,DENOK,MOKH,MRHSA,MRPPO,MOKP,VIS,MHH,MOCH,MCCH,MCVH,MHP,MCCP,MCVP';

    IF OBJECT_ID('U_ETASCCBRNH_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ETASCCBRNH_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ETASCCBRNH_DedList
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

    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RunID','BDM');

    -- NPM parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RunID','NPM');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','X'); -- DedIsCobraCovered = 'Y'
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'NewEnrolleeType','4'); -- All new enrollees where no previous plan exists
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'TableType','EMP'); -- Only include employees on NPM file*/

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
    IF OBJECT_ID('U_ETASCCBRNH_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ETASCCBRNH_PDedHist;
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
    INTO dbo.U_ETASCCBRNH_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ETASCCBRNH_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_ETASCCBRNH_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ETASCCBRNH_PEarHist;
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
    INTO dbo.U_ETASCCBRNH_PEarHist
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
    -- DETAIL RECORD - U_ETASCCBRNH_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ETASCCBRNH_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ETASCCBRNH_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = xEEID + CASE WHEN BdmRecType = 'EMP' THEN + ' 1' ELSE ' 2' END
        -- standard fields above and additional driver fields below
        ,drvParticipantSSN = CASE WHEN BdmRecType = 'EMP' THEN eepSSN ELSE ConSSN END
        ,drvParticipantNameLast = CASE WHEN BdmRecType = 'EMP' THEN EepNameLast ELSE ConNameLast END
        ,drvParticipantNameFirst = CASE WHEN BdmRecType = 'EMP' THEN EepNameFirst ELSE ConNameFirst END
        ,drvParticipantMiddleInitial = CASE WHEN BdmRecType = 'EMP' THEN LEFT(EepNameMiddle,1) ELSE LEFT(ConNameMiddle, 1) END
        ,drvParticipantAddressLine1 = '"' + CASE WHEN BdmRecType = 'EMP' THEN EepAddressLine1 ELSE ConAddressLine1 END + '"'
        ,drvParticipantAddressLine2 = CASE WHEN BdmRecType = 'EMP' THEN EepAddressLine2 ELSE ConAddressLine2 END
        ,drvParticipantAddressCity = CASE WHEN BdmRecType = 'EMP' THEN EepAddressCity ELSE ConAddressCity END
        ,drvParticipantAddressState = CASE WHEN BdmRecType = 'EMP' THEN EepAddressState ELSE ConAddressState END
        ,drvParticipantAddressZip = CASE WHEN BdmRecType = 'EMP' THEN EepAddressZipCode ELSE ConAddressZipCode END
        ,drvParticipantCountry = CASE WHEN BdmRecType = 'EMP' THEN EepAddressCountry ELSE ConAddressCountry END
        ,drvParticipantAreaCode = CASE WHEN BdmRecType = 'EMP' THEN LEFT(EepPhoneHomeNumber, 3) ELSE LEFT(ConPhoneHomeNumber, 3) END
        ,drvPartPhoneNumberHome = CASE WHEN BdmRecType = 'EMP' THEN RIGHT(REPLACE(EepPhoneHomeNumber, ' ', ''), 7) ELSE RIGHT(REPLACE(ConPhoneHomeNumber, ' ', ''), 7) END
        ,drvParticipantGender = CASE WHEN BdmRecType = 'EMP' THEN EepGender ELSE ConGender END
        ,drvParticipantDateOfBirth = CASE WHEN BdmRecType = 'EMP' THEN EepDateOfBirth ELSE ConDateOfBirth END
        ,drvPartRelationshipCode =    CASE WHEN BdmRecType = 'EMP' THEN 'SELF'
                                        ELSE
                                            CASE WHEN ConRelationship = 'SPS' THEN 'SPOUSE'
                                                WHEN ConRelationship = 'DP' THEN 'DOMPART'
                                                WHEN ConRelationship IN ('CHL','STC') THEN 'CHILD'
                                                WHEN ConRelationship = 'DPC' THEN 'DOMCH'
                                                WHEN ConRelationship = 'DSC' THEN 'HANDICAP'
                                            END
                                    END
        ,drvSSN = eepSSN
        ,drvNameLast = EepNameLast
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvEmpHireDate = EecDateOfLastHire
    INTO dbo.U_ETASCCBRNH_drvTbl
    FROM dbo.U_ETASCCBRNH_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ETASCCBRNH WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemId = BdmDepRecID
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
ALTER VIEW dbo.dsi_vwETASCCBRNH_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ETASCCBRNH_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ETASCCBRNH%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202001011'
       ,expStartPerControl     = '202001011'
       ,expLastEndPerControl   = '202007209'
       ,expEndPerControl       = '202007209'
WHERE expFormatCode = 'ETASCCBRNH';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwETASCCBRNH_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ETASCCBRNH_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort