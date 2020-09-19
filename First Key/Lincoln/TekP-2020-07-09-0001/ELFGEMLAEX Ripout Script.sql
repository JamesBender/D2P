SET NOCOUNT ON;
IF OBJECT_ID('U_ELFGEMLAEX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ELFGEMLAEX_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ELFGEMLAEX_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ELFGEMLAEX' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwELFGEMLAEX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwELFGEMLAEX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ELFGEMLAEX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ELFGEMLAEX];
GO
IF OBJECT_ID('U_ELFGEMLAEX_TotalMonthsRaw') IS NOT NULL DROP TABLE [dbo].[U_ELFGEMLAEX_TotalMonthsRaw];
GO
IF OBJECT_ID('U_ELFGEMLAEX_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ELFGEMLAEX_PEarHist];
GO
IF OBJECT_ID('U_ELFGEMLAEX_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ELFGEMLAEX_PDedHist];
GO
IF OBJECT_ID('U_ELFGEMLAEX_Header') IS NOT NULL DROP TABLE [dbo].[U_ELFGEMLAEX_Header];
GO
IF OBJECT_ID('U_ELFGEMLAEX_File') IS NOT NULL DROP TABLE [dbo].[U_ELFGEMLAEX_File];
GO
IF OBJECT_ID('U_ELFGEMLAEX_EEList') IS NOT NULL DROP TABLE [dbo].[U_ELFGEMLAEX_EEList];
GO
IF OBJECT_ID('U_ELFGEMLAEX_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ELFGEMLAEX_drvTbl];
GO
IF OBJECT_ID('U_ELFGEMLAEX_DedList') IS NOT NULL DROP TABLE [dbo].[U_ELFGEMLAEX_DedList];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ELFGEMLAEX';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ELFGEMLAEX';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ELFGEMLAEX';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ELFGEMLAEX';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ELFGEMLAEX';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','ELFGEMLAEX','Lincoln FMLA Supp Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','808','S','N','ELFGEMLAEXZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"09-LF0188"','1','(''DA''=''F'')','ELFGEMLAEXZ0','9','H','01','1',NULL,'Customer ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNumberOfDetailRecs"','2','(''UA''=''F'')','ELFGEMLAEXZ0','7','H','01','10',NULL,'Number of detailed records',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCreationDate"','3','(''UD112''=''F'')','ELFGEMLAEXZ0','8','H','01','17',NULL,'File Create Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','4','(''DA''=''F'')','ELFGEMLAEXZ0','784','H','01','25',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"F"','1','(''DA''=''F'')','ELFGEMLAEXZ0','1','D','10','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','2','(''UA''=''F'')','ELFGEMLAEXZ0','11','D','10','2',NULL,'Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeId"','3','(''UA''=''F'')','ELFGEMLAEXZ0','11','D','10','13',NULL,'Employee Identification',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','4','(''UA''=''F'')','ELFGEMLAEXZ0','35','D','10','24',NULL,'First Name Employee',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','5','(''UA''=''F'')','ELFGEMLAEXZ0','35','D','10','59',NULL,'Last Name Employee',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','6','(''UA''=''F'')','ELFGEMLAEXZ0','1','D','10','94',NULL,'Employee Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameSuffix"','7','(''UA''=''F'')','ELFGEMLAEXZ0','5','D','10','95',NULL,'Employee Name Suffix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','8','(''UA''=''F'')','ELFGEMLAEXZ0','30','D','10','100',NULL,'Employee Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','9','(''UA''=''F'')','ELFGEMLAEXZ0','30','D','10','130',NULL,'Employee Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','10','(''UA''=''F'')','ELFGEMLAEXZ0','20','D','10','160',NULL,'Employee Address City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','11','(''UA''=''F'')','ELFGEMLAEXZ0','2','D','10','180',NULL,'Employee Address State Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZip"','12','(''UA''=''F'')','ELFGEMLAEXZ0','9','D','10','182',NULL,'Employee Address Postal Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','13','(''UD112''=''F'')','ELFGEMLAEXZ0','8','D','10','191',NULL,'Employee Birth Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','14','(''UA''=''F'')','ELFGEMLAEXZ0','1','D','10','199',NULL,'Employee Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfOriginalHire"','15','(''UD112''=''F'')','ELFGEMLAEXZ0','8','D','10','200',NULL,'Original Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfLastHire"','16','(''UD112''=''F'')','ELFGEMLAEXZ0','8','D','10','208',NULL,'Latest Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeStatus"','17','(''UA''=''F'')','ELFGEMLAEXZ0','1','D','10','216',NULL,'Employment Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfTermination"','18','(''UD112''=''F'')','ELFGEMLAEXZ0','8','D','10','217',NULL,'Date of Termination',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmploymentType"','19','(''UA''=''F'')','ELFGEMLAEXZ0','1','D','10','225',NULL,'Employment Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeState"','20','(''UA''=''F'')','ELFGEMLAEXZ0','2','D','10','226',NULL,'Employment State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0000"','21','(''DA''=''F'')','ELFGEMLAEXZ0','4','D','10','228',NULL,'Disability Subsidiary Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"00000000"','22','(''DA''=''F'')','ELFGEMLAEXZ0','8','D','10','232',NULL,'Disability Location Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEligAmountDuration"','23','(''UA''=''F'')','ELFGEMLAEXZ0','11','D','10','240',NULL,'Eligibility Amount Duration',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvServiceAmount"','24','(''UA''=''F'')','ELFGEMLAEXZ0','12','D','10','251',NULL,'Service Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','25','(''DA''=''F'')','ELFGEMLAEXZ0','1','D','10','263',NULL,'Non-eligible Location indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHoursWorkedMon"','26','(''UA''=''F'')','ELFGEMLAEXZ0','9','D','10','264',NULL,'Hours Worked Per Day- Monday',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHoursWorkedTues"','27','(''UA''=''F'')','ELFGEMLAEXZ0','9','D','10','273',NULL,'Hours Worked Per Day- Tuesday',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHoursWorkedWed"','28','(''UA''=''F'')','ELFGEMLAEXZ0','9','D','10','282',NULL,'Hours Worked Per Day- Wednesday',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHoursWorkedThurs"','29','(''UA''=''F'')','ELFGEMLAEXZ0','9','D','10','291',NULL,'Hours Worked Per Day- Thursday',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHoursWorkedFri"','30','(''UA''=''F'')','ELFGEMLAEXZ0','9','D','10','300',NULL,'Hours Worked Per Day- Friday',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"      0.0"','31','(''DA''=''F'')','ELFGEMLAEXZ0','9','D','10','309',NULL,'Hours Worked Per Day- Saturday',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"      0.0"','32','(''DA''=''F'')','ELFGEMLAEXZ0','9','D','10','318',NULL,'Hours Worked Per Day- Sunday',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','33','(''DA''=''F'')','ELFGEMLAEXZ0','1','D','10','327',NULL,'Key Employee indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','34','(''DA''=''F'')','ELFGEMLAEXZ0','1','D','10','328',NULL,'Union Employee indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','35','(''DA''=''F'')','ELFGEMLAEXZ0','1','D','10','329',NULL,'Exempt Employee indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','36','(''DA''=''F'')','ELFGEMLAEXZ0','11','D','10','330',NULL,'Co-worker Spouse SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"dvDisabilityConNameFirst"','37','(''UA''=''F'')','ELFGEMLAEXZ0','35','D','10','341',NULL,'Disability Contact First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"dvDisabilityConNameLast"','38','(''UA''=''F'')','ELFGEMLAEXZ0','35','D','10','376',NULL,'Disability Contact Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"dvDisabilityConEmailAddress"','39','(''UA''=''F'')','ELFGEMLAEXZ0','100','D','10','411',NULL,'Disability Contact Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','40','(''DA''=''F'')','ELFGEMLAEXZ0','80','D','10','511',NULL,'Employee Custom Data Element 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','41','(''DA''=''F'')','ELFGEMLAEXZ0','80','D','10','591',NULL,'Employee Custom Data Element 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','42','(''DA''=''F'')','ELFGEMLAEXZ0','35','D','10','671',NULL,'Employee Custom Data Element 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','43','(''DA''=''F'')','ELFGEMLAEXZ0','35','D','10','706',NULL,'Employee Custom Data Element 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','44','(''DA''=''F'')','ELFGEMLAEXZ0','20','D','10','741',NULL,'Employee Custom Data 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','45','(''DA''=''F'')','ELFGEMLAEXZ0','20','D','10','761',NULL,'Employee Custom Data 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','46','(''DA''=''F'')','ELFGEMLAEXZ0','20','D','10','781',NULL,'Employee Custom Data 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateCreated"','47','(''UD112''=''F'')','ELFGEMLAEXZ0','8','D','10','801',NULL,'Date Created',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ELFGEMLAEX_20200918.txt',NULL,'','','',NULL,NULL,NULL,'Lincoln FMLA Supp Export','202008179','EMPEXPORT','ONDEM_XOE','Aug 19 2020  5:40PM','ELFGEMLAEX',NULL,NULL,NULL,'202008179','Aug 17 2020 12:25PM','Aug 17 2020 12:25PM','202008171','958','','','202008171',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ELFGEMLAEX_20200918.txt',NULL,'','','',NULL,NULL,NULL,'Lincoln FMLA Supp Export-Sched','202008179','EMPEXPORT','SCH_ELFGEM','Aug 19 2020  5:40PM','ELFGEMLAEX',NULL,NULL,NULL,'202008179','Aug 17 2020 12:25PM','Aug 17 2020 12:25PM','202008171','958','','','202008171',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ELFGEMLAEX_20200918.txt',NULL,'','','',NULL,NULL,NULL,'Lincoln FMLA Supp Export-Test','202008259','EMPEXPORT','TEST_XOE','Aug 25 2020 11:57AM','ELFGEMLAEX',NULL,NULL,NULL,'202008259','Aug 25 2020 12:00AM','Dec 30 1899 12:00AM','202008251','958','','','202008251',dbo.fn_GetTimedKey(),NULL,'us3rVaFIR1053',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_ELFGEMLAEX_20200918.txt' END WHERE expFormatCode = 'ELFGEMLAEX';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELFGEMLAEX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELFGEMLAEX','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELFGEMLAEX','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELFGEMLAEX','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELFGEMLAEX','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'ELFGEMLAEX' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ELFGEMLAEX' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_ELFGEMLAEX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ELFGEMLAEX_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ELFGEMLAEX','H01','dbo.U_ELFGEMLAEX_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ELFGEMLAEX','D10','dbo.U_ELFGEMLAEX_drvTbl',NULL);
IF OBJECT_ID('U_ELFGEMLAEX_DedList') IS NULL
CREATE TABLE [dbo].[U_ELFGEMLAEX_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ELFGEMLAEX_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ELFGEMLAEX_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvSSN] varchar(13) NULL,
    [drvEmployeId] char(9) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameSuffix] varchar(30) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZip] varchar(50) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvGender] varchar(1) NULL,
    [drvDateOfOriginalHire] datetime NULL,
    [drvDateOfLastHire] datetime NULL,
    [drvEmployeeStatus] varchar(1) NOT NULL,
    [drvDateOfTermination] datetime NULL,
    [drvEmploymentType] varchar(1) NOT NULL,
    [drvEmployeeState] varchar(255) NULL,
    [drvEligAmountDuration] nvarchar(11) NULL,
    [drvServiceAmount] nvarchar(12) NULL,
    [drvHoursWorkedMon] nvarchar(9) NULL,
    [drvHoursWorkedTues] nvarchar(9) NULL,
    [drvHoursWorkedWed] nvarchar(9) NULL,
    [drvHoursWorkedThurs] nvarchar(9) NULL,
    [drvHoursWorkedFri] nvarchar(9) NULL,
    [dvDisabilityConNameFirst] varchar(7) NOT NULL,
    [dvDisabilityConNameLast] varchar(5) NOT NULL,
    [dvDisabilityConEmailAddress] varchar(24) NOT NULL,
    [drvDateCreated] datetime NOT NULL
);
IF OBJECT_ID('U_ELFGEMLAEX_EEList') IS NULL
CREATE TABLE [dbo].[U_ELFGEMLAEX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ELFGEMLAEX_File') IS NULL
CREATE TABLE [dbo].[U_ELFGEMLAEX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(810) NULL
);
IF OBJECT_ID('U_ELFGEMLAEX_Header') IS NULL
CREATE TABLE [dbo].[U_ELFGEMLAEX_Header] (
    [drvNumberOfDetailRecs] nvarchar(7) NULL,
    [drvCreationDate] datetime NOT NULL
);
IF OBJECT_ID('U_ELFGEMLAEX_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ELFGEMLAEX_PDedHist] (
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
IF OBJECT_ID('U_ELFGEMLAEX_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ELFGEMLAEX_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PehCurAmt] numeric NULL,
    [PehCurHrs] decimal NULL,
    [PehCurAmtYTD] money NULL,
    [PehCurHrsYTD] decimal NULL,
    [PehEligibilityAmountDuration] decimal NULL,
    [PehInclInDefComp] money NULL,
    [PehInclInDefCompHrs] decimal NULL,
    [PehInclInDefCompYTD] money NULL,
    [PehInclInDefCompHrsYTD] decimal NULL
);
IF OBJECT_ID('U_ELFGEMLAEX_TotalMonthsRaw') IS NULL
CREATE TABLE [dbo].[U_ELFGEMLAEX_TotalMonthsRaw] (
    [PayDateEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ELFGEMLAEX]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: First Key

Created By: James Bender
Business Analyst: Richard Vars
Create Date: 08/17/2020
Service Request Number: TekP-2020-07-09-0001

Purpose: Lincoln FMLA Supp Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ELFGEMLAEX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ELFGEMLAEX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ELFGEMLAEX';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ELFGEMLAEX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ELFGEMLAEX' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELFGEMLAEX', 'ONDEM_XOE';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ELFGEMLAEX', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ELFGEMLAEX';

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
    DELETE FROM dbo.U_ELFGEMLAEX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ELFGEMLAEX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'DED1,DED2';

    IF OBJECT_ID('U_ELFGEMLAEX_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ELFGEMLAEX_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ELFGEMLAEX_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_ELFGEMLAEX_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ELFGEMLAEX_PDedHist;
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
    INTO dbo.U_ELFGEMLAEX_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ELFGEMLAEX_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_ELFGEMLAEX_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ELFGEMLAEX_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        --,PrgPayDate             = PrgPayDate
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
        ,PehEligibilityAmountDuration = SUM(CASE WHEN PehIsRegularPayCode = 'Y' OR PehIsOvertime = 'Y' OR ErnIsProductiveTime = 'Y' THEN PehCurHrs ELSE 0.00 END)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_ELFGEMLAEX_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    JOIN dbo.EarnCode WITH (NOLOCK)
        ON ErnEarnCode = PehEarnCode
    WHERE --LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    --AND 
    --PehPerControl <= @EndPerControl
    LEFT(PehPerControl, 8) BETWEEN DATEADD(YEAR, -1, @ENDDATE) and @ENDDATE
    GROUP BY PehEEID --, PrgPayDate
    HAVING SUM(PehCurAmt) <> 0.00;



    /*IF OBJECT_ID('U_ELFGEMLAEX_TotalMonthsRaw','U') IS NOT NULL
        DROP TABLE dbo.U_ELFGEMLAEX_TotalMonthsRaw
    SELECT DISTINCT
         PehEEID AS PayDateEEID
        ,CAST(DATEPART(YEAR, PrgPayDate) AS VARCHAR) + CAST(DATEPART(MONTH, PrgPayDate) AS VARCHAR) AS PayDates --MAX(PrgPayDate)
        INTO dbo.U_ELFGEMLAEX_TotalMonthsRaw
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist A WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    Order by A.PehEEID;*/

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ELFGEMLAEX_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ELFGEMLAEX_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ELFGEMLAEX_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN + '  '
        ,drvEmployeId = EecEmpNo
        ,drvNameFirst = EepNameFirst
        ,drvNameLast = EepNameLast
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvNameSuffix = NULLIF(EepNameSuffix,'Z')
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZip = EepAddressZipCode
        ,drvDateOfBirth = EepDateOfBirth
        ,drvGender =    CASE WHEN EepGender = 'M' THEN 'M'
                            WHEN EepGender = 'F' THEN 'F'
                        END
        ,drvDateOfOriginalHire = EecDateOfOriginalHire
        ,drvDateOfLastHire = EecDateOfLastHire
        ,drvEmployeeStatus = CASE WHEN EecEmplStatus IN ('T', 'R') THEN 'T' ELSE 'A' END
        ,drvDateOfTermination = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvEmploymentType = CASE WHEN EecFullTimeOrPartTime = 'F' THEN '1' ELSE '2' END
        ,drvEmployeeState = LocAddressState
        ,drvEligAmountDuration = RIGHT(SPACE(11) + FORMAT(PehEligibilityAmountDuration, '#0.00'), 11)
        ,drvServiceAmount = RIGHT(SPACE(12) + FORMAT(DATEDIFF(MONTH, EecDateOfLastHire, GETDATE()), '#0'), 12)
        ,drvHoursWorkedMon = RIGHT(SPACE(9) + FORMAT(EecScheduledAnnualHrs/52/5, '#0'), 9)
        ,drvHoursWorkedTues = RIGHT(SPACE(9) + FORMAT(EecScheduledAnnualHrs/52/5, '#0'), 9)
        ,drvHoursWorkedWed = RIGHT(SPACE(9) + FORMAT(EecScheduledAnnualHrs/52/5, '#0'), 9)
        ,drvHoursWorkedThurs = RIGHT(SPACE(9) + FORMAT(EecScheduledAnnualHrs/52/5, '#0'), 9)
        ,drvHoursWorkedFri = RIGHT(SPACE(9) + FORMAT(EecScheduledAnnualHrs/52/5, '#0'), 9)
        ,dvDisabilityConNameFirst = 'Daniese'
        ,dvDisabilityConNameLast = 'Adams'
        ,dvDisabilityConEmailAddress = 'dadams@firstkeyhomes.com'
        ,drvDateCreated = GETDATE()
    INTO dbo.U_ELFGEMLAEX_drvTbl
    FROM dbo.U_ELFGEMLAEX_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.Location WITH (NOLOCK)
        ON EecLocation = LocCode
    JOIN dbo.U_ELFGEMLAEX_PEarHist WITH (NOLOCK)
        ON PehEEID = xEEID
    /*JOIN (
            SELECT PayDateEEID, COUNT(PayDates) AS MONTHS
            FROM dbo.U_ELFGEMLAEX_TotalMonthsRaw
            GROUP BY PayDateEEID
--Order by PayDateEEID
        ) AS Months
        ON PayDateEEID = xEEID*/
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ELFGEMLAEX_Header','U') IS NOT NULL
        DROP TABLE dbo.U_ELFGEMLAEX_Header;
    SELECT DISTINCT
         drvNumberOfDetailRecs = RIGHT(SPACE(7) + FORMAT((SELECT COUNT(*) FROM dbo.U_ELFGEMLAEX_drvTbl WITH (NOLOCK)), '#0'), 7)
        ,drvCreationDate = GETDATE()        
    INTO dbo.U_ELFGEMLAEX_Header
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
ALTER VIEW dbo.dsi_vwELFGEMLAEX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ELFGEMLAEX_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ELFGEMLAEX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202008101'
       ,expStartPerControl     = '202008101'
       ,expLastEndPerControl   = '202008179'
       ,expEndPerControl       = '202008179'
WHERE expFormatCode = 'ELFGEMLAEX';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwELFGEMLAEX_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ELFGEMLAEX_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort