SET NOCOUNT ON;
IF OBJECT_ID('U_EINFOARMRX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EINFOARMRX_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EINFOARMRX_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EINFOARMRX' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEINFOARMRX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEINFOARMRX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EINFOARMRX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EINFOARMRX];
GO
IF OBJECT_ID('U_EINFOARMRX_File') IS NOT NULL DROP TABLE [dbo].[U_EINFOARMRX_File];
GO
IF OBJECT_ID('U_EINFOARMRX_EEList') IS NOT NULL DROP TABLE [dbo].[U_EINFOARMRX_EEList];
GO
IF OBJECT_ID('U_EINFOARMRX_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EINFOARMRX_drvTbl];
GO
IF OBJECT_ID('U_EINFOARMRX_DedList') IS NOT NULL DROP TABLE [dbo].[U_EINFOARMRX_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EINFOARMRX') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EINFOARMRX];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EINFOARMRX';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EINFOARMRX';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EINFOARMRX';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EINFOARMRX';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EINFOARMRX';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EINFOARMRX','Info Armor Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','EINFOARMRXZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Effective Date"','1','(''DA''=''T,'')','EINFOARMRXZ0','50','H','01','1',NULL,'Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Status"','2','(''DA''=''T,'')','EINFOARMRXZ0','50','H','01','2',NULL,'Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ClientID"','3','(''DA''=''T,'')','EINFOARMRXZ0','50','H','01','3',NULL,'ClientID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EmployeeID"','4','(''DA''=''T,'')','EINFOARMRXZ0','50','H','01','4',NULL,'EmployeeID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MemberFirstName"','5','(''DA''=''T,'')','EINFOARMRXZ0','50','H','01','5',NULL,'MemberFirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MemberMiddleName"','6','(''DA''=''T,'')','EINFOARMRXZ0','50','H','01','6',NULL,'MemberMiddleName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MemberLastName"','7','(''DA''=''T,'')','EINFOARMRXZ0','50','H','01','7',NULL,'MemberLastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MemberSSN"','8','(''DA''=''T,'')','EINFOARMRXZ0','50','H','01','8',NULL,'MemberSSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DOB_Month"','9','(''DA''=''T,'')','EINFOARMRXZ0','50','H','01','9',NULL,'DOB_Month',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DOB_Day"','10','(''DA''=''T,'')','EINFOARMRXZ0','50','H','01','10',NULL,'DOB_Day',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DOB_Year"','11','(''DA''=''T,'')','EINFOARMRXZ0','50','H','01','11',NULL,'DOB_Year',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address1"','12','(''DA''=''T,'')','EINFOARMRXZ0','50','H','01','12',NULL,'Address1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address2"','13','(''DA''=''T,'')','EINFOARMRXZ0','50','H','01','13',NULL,'Address2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"City"','14','(''DA''=''T,'')','EINFOARMRXZ0','50','H','01','14',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"State"','15','(''DA''=''T,'')','EINFOARMRXZ0','50','H','01','15',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ZipCode"','16','(''DA''=''T,'')','EINFOARMRXZ0','50','H','01','16',NULL,'ZipCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AreaCode"','17','(''DA''=''T,'')','EINFOARMRXZ0','50','H','01','17',NULL,'AreaCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HomePhone"','18','(''DA''=''T,'')','EINFOARMRXZ0','50','H','01','18',NULL,'HomePhone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Email"','19','(''DA''=''T,'')','EINFOARMRXZ0','50','H','01','19',NULL,'Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Deduction Method"','20','(''DA''=''T,'')','EINFOARMRXZ0','50','H','01','20',NULL,'Deduction Method',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Customer_Defined"','21','(''DA''=''T,'')','EINFOARMRXZ0','50','H','01','21',NULL,'Customer_Defined',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Relationship"','22','(''DA''=''T,'')','EINFOARMRXZ0','50','H','01','22',NULL,'Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Primary"','23','(''DA''=''T,'')','EINFOARMRXZ0','50','H','01','23',NULL,'Primary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FamilyID"','24','(''DA''=''T,'')','EINFOARMRXZ0','50','H','01','24',NULL,'FamilyID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"UniqueID"','25','(''DA''=''T,'')','EINFOARMRXZ0','50','H','01','25',NULL,'UniqueID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Plan_Type"','26','(''DA''=''T,'')','EINFOARMRXZ0','50','H','01','26',NULL,'Plan_Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ProductID"','27','(''DA''=''T'')','EINFOARMRXZ0','50','H','01','27',NULL,'ProductID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffectiveDate"','1','(''UD101''=''T,'')','EINFOARMRXZ0','50','D','10','1',NULL,'Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatus"','2','(''UA''=''T,'')','EINFOARMRXZ0','50','D','10','2',NULL,'Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"4643"','3','(''DA''=''T,'')','EINFOARMRXZ0','50','D','10','3',NULL,'ClientID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','4','(''UA''=''T,'')','EINFOARMRXZ0','50','D','10','4',NULL,'EmployeeID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','5','(''UA''=''T,'')','EINFOARMRXZ0','50','D','10','5',NULL,'MemberFirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','6','(''UA''=''T,'')','EINFOARMRXZ0','50','D','10','6',NULL,'MemberMiddleName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','7','(''UA''=''T,'')','EINFOARMRXZ0','50','D','10','7',NULL,'MemberLastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemberSSN"','8','(''UA''=''T,'')','EINFOARMRXZ0','50','D','10','8',NULL,'MemberSSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMonthOfBirth"','9','(''UA''=''T,'')','EINFOARMRXZ0','50','D','10','9',NULL,'DOB_Month',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDayOfBirth"','10','(''UA''=''T,'')','EINFOARMRXZ0','50','D','10','10',NULL,'DOB_Day',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYearOfBirth"','11','(''UA''=''T,'')','EINFOARMRXZ0','50','D','10','11',NULL,'DOB_Year',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','12','(''UA''=''T,'')','EINFOARMRXZ0','50','D','10','12',NULL,'Address1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','13','(''UA''=''T,'')','EINFOARMRXZ0','50','D','10','13',NULL,'Address2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','14','(''UA''=''T,'')','EINFOARMRXZ0','50','D','10','14',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','15','(''UA''=''T,'')','EINFOARMRXZ0','50','D','10','15',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','16','(''UA''=''T,'')','EINFOARMRXZ0','50','D','10','16',NULL,'ZipCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAreaCode"','17','(''UA''=''T,'')','EINFOARMRXZ0','50','D','10','17',NULL,'AreaCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneHome"','18','(''UA''=''T,'')','EINFOARMRXZ0','50','D','10','18',NULL,'HomePhone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressEmail"','19','(''UA''=''T,'')','EINFOARMRXZ0','50','D','10','19',NULL,'Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employer payroll deduction"','20','(''DA''=''T,'')','EINFOARMRXZ0','50','D','10','20',NULL,'Deduction Method',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustomerDefined"','21','(''UA''=''T,'')','EINFOARMRXZ0','50','D','10','21',NULL,'Customer_Defined',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelationship"','22','(''UA''=''T,'')','EINFOARMRXZ0','50','D','10','22',NULL,'Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPrimary"','23','(''UA''=''T,'')','EINFOARMRXZ0','50','D','10','23',NULL,'Primary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFamilyID"','24','(''UA''=''T,'')','EINFOARMRXZ0','50','D','10','24',NULL,'FamilyID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUniqueID"','25','(''UA''=''T,'')','EINFOARMRXZ0','50','D','10','25',NULL,'UniqueID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanType"','26','(''UA''=''T,'')','EINFOARMRXZ0','50','D','10','26',NULL,'Plan_Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PAP"','27','(''DA''=''T'')','EINFOARMRXZ0','50','D','10','27',NULL,'ProductID',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EINFOARMRX_20200521.txt',NULL,'','',NULL,NULL,NULL,NULL,'Info Armor Export','202006309','EMPEXPORT','ONDEMAND',NULL,'EINFOARMRX',NULL,NULL,NULL,'202006309','May 11 2020 11:54AM','May 11 2020 11:54AM','202005011',NULL,'','','202005011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EINFOARMRX_20200521.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Test Purposes Only','202006309','EMPEXPORT','TEST',NULL,'EINFOARMRX',NULL,NULL,NULL,'202006309','May 11 2020 11:54AM','May 11 2020 11:54AM','202005011',NULL,'','','202005011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EINFOARMRX_20200521.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','202006309','EMPEXPORT','SCHEDULED',NULL,'EINFOARMRX',NULL,NULL,NULL,'202006309','May 11 2020 11:54AM','May 11 2020 11:54AM','202005011',NULL,'','','202005011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EINFOARMRX_20200521.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Chnages Only file','202006309','EMPEXPORT','CHANGES',NULL,'EINFOARMRX',NULL,NULL,NULL,'202006309','May 11 2020 11:54AM','May 11 2020 11:54AM','202005011',NULL,'','','202005011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EINFOARMRX_20200521.txt',NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','202006309','EMPEXPORT','OEACTIVE','May 20 2020 10:37AM','EINFOARMRX',NULL,NULL,NULL,'202006309','Jun 30 2020 12:00AM','Dec 30 1899 12:00AM','202005011','47','','','202005011',dbo.fn_GetTimedKey(),NULL,'us3cPeTUR1007',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EINFOARMRX_20200521.txt',NULL,'','','',NULL,NULL,NULL,'Passive Open Enrollment Export','202006309','EMPEXPORT','OEPASSIVE','May 20 2020 10:38AM','EINFOARMRX',NULL,NULL,NULL,'202006309','Jun 30 2020 12:00AM','Dec 30 1899 12:00AM','202005011','47','','','202005011',dbo.fn_GetTimedKey(),NULL,'us3cPeTUR1007',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EINFOARMRX_20200521.txt' END WHERE expFormatCode = 'EINFOARMRX';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EINFOARMRX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EINFOARMRX','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EINFOARMRX','InitialSort','C','drvSorty');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EINFOARMRX','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EINFOARMRX','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EINFOARMRX' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EINFOARMRX' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EINFOARMRX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EINFOARMRX_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EINFOARMRX','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EINFOARMRX','D10','dbo.U_EINFOARMRX_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_EINFOARMRX') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EINFOARMRX] (
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
IF OBJECT_ID('U_EINFOARMRX_DedList') IS NULL
CREATE TABLE [dbo].[U_EINFOARMRX_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EINFOARMRX_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EINFOARMRX_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSorty] nvarchar(4000) NULL,
    [drvEffectiveDate] datetime NULL,
    [drvStatus] varchar(6) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(50) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvMemberSSN] char(11) NOT NULL,
    [drvMonthOfBirth] int NULL,
    [drvDayOfBirth] int NULL,
    [drvYearOfBirth] int NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvAreaCode] varchar(3) NULL,
    [drvPhoneHome] varchar(7) NULL,
    [drvAddressEmail] varchar(50) NULL,
    [drvCustomerDefined] char(6) NULL,
    [drvRelationship] varchar(1) NULL,
    [drvPrimary] varchar(1) NOT NULL,
    [drvFamilyID] char(9) NULL,
    [drvUniqueID] nvarchar(4000) NULL,
    [drvPlanType] varchar(10) NOT NULL
);
IF OBJECT_ID('U_EINFOARMRX_EEList') IS NULL
CREATE TABLE [dbo].[U_EINFOARMRX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EINFOARMRX_File') IS NULL
CREATE TABLE [dbo].[U_EINFOARMRX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EINFOARMRX]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Turning Point of Central California

Created By: James Bender
Business Analyst: Cheryl Petitti
Create Date: 05/11/2020
Service Request Number: TekP-2020-04-15-0001

Purpose: Info Armor Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EINFOARMRX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EINFOARMRX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EINFOARMRX';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EINFOARMRX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EINFOARMRX' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EINFOARMRX', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EINFOARMRX', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EINFOARMRX', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EINFOARMRX', 'CHANGES';


EXEC dbo.dsi_BDM_sp_ErrorCheck 'EINFOARMRX';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EINFOARMRX', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EINFOARMRX';

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
    DELETE FROM dbo.U_EINFOARMRX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EINFOARMRX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'IDT'; --,IDENT';

    IF OBJECT_ID('U_EINFOARMRX_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EINFOARMRX_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EINFOARMRX_DedList
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
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EINFOARMRX_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EINFOARMRX_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EINFOARMRX_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSorty = CASE WHEN BdmRecType = 'EMP' THEN RTRIM(EecEmpNo)
                            ELSE RTRIM(EecEmpNo) + FORMAT(Contact_Number, '##')
                        END
        -- standard fields above and additional driver fields below
        ,drvEffectiveDate = BdmBenStartDate
        ,drvStatus =    CASE WHEN BdmBenStartDate BETWEEN @StartDate AND @EndDate AND BdmBenStatus NOT IN ('T', 'C') THEN 'Add'
                            WHEN BdmBenStatus IN ('T', 'C') THEN 'Drop'
                            ELSE 'Change'
                        END
        ,drvSSN = eepSSN
        ,drvNameFirst = CASE WHEN BdmRecType = 'EMP' THEN EepNameFirst ELSE ConNameFirst END
        ,drvNameMiddle = CASE WHEN BdmRecType = 'EMP' THEN EepNameMiddle ELSE ConNameMiddle END
        ,drvNameLast = CASE WHEN BdmRecType = 'EMP' THEN EepNameLast ELSE ConNameLast END
        ,drvMemberSSN = CASE WHEN BdmRecType = 'EMP' THEN ISNULL(eepSSN, '000000000')
                            ELSE ISNULL(ConSSN, '000000000')
                        END
        ,drvMonthOfBirth =    CASE WHEN BdmRecType = 'EMP' THEN DATEPART(MONTH, EepDateOFBirth)
                                ELSE DATEPART(MONTH, ConDateOFBirth)
                            END
        ,drvDayOfBirth =    CASE WHEN BdmRecType = 'EMP' THEN DATEPART(DAY, EepDateOFBirth)
                                ELSE DATEPART(DAY, ConDateOFBirth)
                            END
        ,drvYearOfBirth =    CASE WHEN BdmRecType = 'EMP' THEN DATEPART(YEAR, EepDateOFBirth)
                                ELSE DATEPART(YEAR, ConDateOFBirth)
                            END
        ,drvAddressLine1 = CASE WHEN BdmRecType = 'EMP' THEN EepAddressLine1 ELSE ConAddressLine1 END
        ,drvAddressLine2 = CASE WHEN BdmRecType = 'EMP' THEN EepAddressLine2 ELSE ConAddressLine2 END
        ,drvAddressCity = CASE WHEN BdmRecType = 'EMP' THEN EepAddressCity ELSE ConAddressCity END
        ,drvAddressState = CASE WHEN BdmRecType = 'EMP' THEN EepAddressState ELSE ConAddressState END
        ,drvAddressZipCode = CASE WHEN BdmRecType = 'EMP' THEN EepAddressZipCode ELSE ConAddressZipCode END
        ,drvAreaCode = CASE WHEN BdmRecType = 'EMP' THEN LEFT(EepPhoneHomeNumber,3) ELSE LEFT(ConPhoneHomeNumber, 3) END
        ,drvPhoneHome = CASE WHEN BdmRecType = 'EMP' THEN RIGHT(EepPhoneHomeNumber,7) ELSE RIGHT(ConPhoneHomeNumber, 7) END
        ,drvAddressEmail = CASE WHEN BdmRecType = 'EMP' THEN EepAddressEMail ELSE ConEmailAddr END
        ,drvCustomerDefined = EecOrgLvl2
        ,drvRelationship =    CASE WHEN BdmRecType = 'EMP' THEN 'P'
                            ELSE
                                CASE WHEN ConRelationship = 'SPS' THEN 'S'
                                    WHEN ConRelationship IN ('CHL', 'LEG', 'STC') THEN 'C'
                                END
                            END
        ,drvPrimary = CASE WHEN BdmRecType = 'EMP' THEN 'Y' ELSE 'N' END
        ,drvFamilyID = EecEmpNo
        ,drvUniqueID =    CASE WHEN BdmRecType = 'EMP' THEN RTRIM(EecEmpNo)
                            ELSE RTRIM(EecEmpNo) + FORMAT(Contact_Number, '##')
                        END
        ,drvPlanType = CASE WHEN BdmBenOption = 'EE' THEN 'Individual' ELSE 'Family' END
    INTO dbo.U_EINFOARMRX_drvTbl
    FROM dbo.U_EINFOARMRX_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EINFOARMRX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
/*    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID*/
    LEFT JOIN (
                SELECT ConEEID, ConSystemId, ConNameFirst, ConNameLast, ConNameMiddle, ConSSN, ConDateOfBirth, ConAddressLine1, ConAddressLine2, ConAddressCity, ConAddressState, ConAddressZipCode, ConPhoneHomeNumber, ConEmailAddr, ConRelationship
                        --,CASE WHEN ConRelationship IN ('SPS') THEN 1 ELSE 2 END AS RelationshipSort        
                        ,ROW_NUMBER() OVER (PARTITION BY ConEEID ORDER BY CASE WHEN ConRelationship IN ('SPS') THEN 1 ELSE 2 END) AS Contact_Number
                FROM dbo.Contacts WITH (NOLOCK)
                WHERE ConRelationship IN ('SPS', 'CHL', 'LEG', 'STC')) AS Contacts_With_Numbers
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
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
ALTER VIEW dbo.dsi_vwEINFOARMRX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EINFOARMRX_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EINFOARMRX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202005011'
       ,expStartPerControl     = '202005011'
       ,expLastEndPerControl   = '202006309'
       ,expEndPerControl       = '202006309'
WHERE expFormatCode = 'EINFOARMRX';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEINFOARMRX_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EINFOARMRX_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort