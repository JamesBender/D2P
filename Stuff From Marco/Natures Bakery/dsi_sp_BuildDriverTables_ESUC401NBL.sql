SET NOCOUNT ON;
IF OBJECT_ID('U_ESUC401NBL_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ESUC401NBL_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ESUC401NBL_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ESUC401NBL' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwESUC401NBL_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwESUC401NBL_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ESUC401NBL') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESUC401NBL];
GO
IF OBJECT_ID('U_ESUC401NBL_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ESUC401NBL_PEarHist];
GO
IF OBJECT_ID('U_ESUC401NBL_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ESUC401NBL_PDedHist];
GO
IF OBJECT_ID('U_ESUC401NBL_File') IS NOT NULL DROP TABLE [dbo].[U_ESUC401NBL_File];
GO
IF OBJECT_ID('U_ESUC401NBL_EEList') IS NOT NULL DROP TABLE [dbo].[U_ESUC401NBL_EEList];
GO
IF OBJECT_ID('U_ESUC401NBL_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ESUC401NBL_drvTbl];
GO
IF OBJECT_ID('U_ESUC401NBL_DedList') IS NOT NULL DROP TABLE [dbo].[U_ESUC401NBL_DedList];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ESUC401NBL';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ESUC401NBL';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ESUC401NBL';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ESUC401NBL';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ESUC401NBL';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ESUC401NBL','Securian Financial 401K File','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','ESUC401NBLZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Plan Number "','1','(''DA''=''T,'')','ESUC401NBLZ0','50','H','01','1',NULL,'Plan Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Social Security Number "','2','(''DA''=''T,'')','ESUC401NBLZ0','50','H','01','2',NULL,'Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pay Date"','3','(''DA''=''T,'')','ESUC401NBLZ0','50','H','01','3',NULL,'Pay Date (Date employees are paid)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Last Name "','4','(''DA''=''T,'')','ESUC401NBLZ0','50','H','01','4',NULL,'Employee Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee First Name "','5','(''DA''=''T,'')','ESUC401NBLZ0','50','H','01','5',NULL,'Employee First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Gender "','6','(''DA''=''T,'')','ESUC401NBLZ0','50','H','01','6',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Birth Date "','7','(''DA''=''T,'')','ESUC401NBLZ0','50','H','01','7',NULL,'Birth Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Original Hire Date "','8','(''DA''=''T,'')','ESUC401NBLZ0','50','H','01','8',NULL,'Original Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Termination Date "','9','(''DA''=''T,'')','ESUC401NBLZ0','50','H','01','9',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Rehire Date "','10','(''DA''=''T,'')','ESUC401NBLZ0','50','H','01','10',NULL,'Rehire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address 1 "','11','(''DA''=''T,'')','ESUC401NBLZ0','50','H','01','11',NULL,'Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address 2 "','12','(''DA''=''T,'')','ESUC401NBLZ0','50','H','01','12',NULL,'Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"City "','13','(''DA''=''T,'')','ESUC401NBLZ0','50','H','01','13',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"State Code "','14','(''DA''=''T,'')','ESUC401NBLZ0','50','H','01','14',NULL,'State Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Zip Code "','15','(''DA''=''T,'')','ESUC401NBLZ0','50','H','01','15',NULL,'Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Marital Status "','16','(''DA''=''T,'')','ESUC401NBLZ0','50','H','01','16',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Division "','17','(''DA''=''T,'')','ESUC401NBLZ0','50','H','01','17',NULL,'Division',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Statement LanguageIndicator  "','18','(''DA''=''T,'')','ESUC401NBLZ0','50','H','01','18',NULL,'Statement Language Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Excluded Class  "','19','(''DA''=''T,'')','ESUC401NBLZ0','50','H','01','19',NULL,'Excluded Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Excluded Class EffectiveDate "','20','(''DA''=''T,'')','ESUC401NBLZ0','50','H','01','20',NULL,'Excluded Class Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Union Member  "','21','(''DA''=''T,'')','ESUC401NBLZ0','50','H','01','21',NULL,'Union Member',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Union Member Effective Date "','22','(''DA''=''T,'')','ESUC401NBLZ0','50','H','01','22',NULL,'Union Member Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home/Cellular Phone Number "','23','(''DA''=''T,'')','ESUC401NBLZ0','50','H','01','23',NULL,'Home/Cellular Telephone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Telephone Number "','24','(''DA''=''T,'')','ESUC401NBLZ0','50','H','01','24',NULL,'Work Telephone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Email Address "','25','(''DA''=''T,'')','ESUC401NBLZ0','50','H','01','25',NULL,'Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Worksite WebAccess Indicator "','26','(''DA''=''T,'')','ESUC401NBLZ0','50','H','01','26',NULL,'Worksite Web Access Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Period Plan Compensation "','27','(''DA''=''T,'')','ESUC401NBLZ0','50','H','01','27',NULL,'Period Plan Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Period Gross Compensation "','28','(''DA''=''T,'')','ESUC401NBLZ0','50','H','01','28',NULL,'Period Gross Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Period Taxable Compensation "','29','(''DA''=''T,'')','ESUC401NBLZ0','50','H','01','29',NULL,'Period Taxable Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Period Plan Hours "','30','(''DA''=''T,'')','ESUC401NBLZ0','50','H','01','30',NULL,'Period Plan Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD Plan Compensation "','31','(''DA''=''T,'')','ESUC401NBLZ0','50','H','01','31',NULL,'YTD Plan Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD Gross Compensation "','32','(''DA''=''T,'')','ESUC401NBLZ0','50','H','01','32',NULL,'YTD Gross Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD Taxable Compensation "','33','(''DA''=''T,'')','ESUC401NBLZ0','50','H','01','33',NULL,'YTD Taxable Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD  Plan Hours "','34','(''DA''=''T,'')','ESUC401NBLZ0','50','H','01','34',NULL,'YTD  Plan Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Pre-tax Deferral Rate "','35','(''DA''=''T,'')','ESUC401NBLZ0','50','H','01','35',NULL,'EE Pre-tax Deferral Rate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Pre-tax Deferral Amount "','36','(''DA''=''T,'')','ESUC401NBLZ0','50','H','01','36',NULL,'EE Pre-tax Deferral Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Roth Deferral Rate "','37','(''DA''=''T,'')','ESUC401NBLZ0','50','H','01','37',NULL,'EE Roth(k) After-tax Deferral Rate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Roth Deferral Amount "','38','(''DA''=''T,'')','ESUC401NBLZ0','50','H','01','38',NULL,'EE Roth(k) After-tax Deferral Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ER Safe Harbor Match"','39','(''DA''=''T'')','ESUC401NBLZ0','50','H','01','39',NULL,'ER Safe Harbor Match',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanNumber"','1','(''UA''=''T,'')','ESUC401NBLZ0','50','D','10','1',NULL,'Plan Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','2','(''UA''=''T,'')','ESUC401NBLZ0','50','D','10','2',NULL,'Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayDate"','3','(''UD101''=''T,'')','ESUC401NBLZ0','50','D','10','3',NULL,'Pay Date (Date employees are paid)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeLastName"','4','(''UA''=''T,'')','ESUC401NBLZ0','50','D','10','4',NULL,'Employee Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeFirstName"','5','(''UA''=''T,'')','ESUC401NBLZ0','50','D','10','5',NULL,'Employee First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','6','(''UA''=''T,'')','ESUC401NBLZ0','50','D','10','6',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBirthDate"','7','(''UD101''=''T,'')','ESUC401NBLZ0','50','D','10','7',NULL,'Birth Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOriginalHireDate"','8','(''UD101''=''T,'')','ESUC401NBLZ0','50','D','10','8',NULL,'Original Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationDate"','9','(''UD101''=''T,'')','ESUC401NBLZ0','50','D','10','9',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRehireDate"','10','(''UD101''=''T,'')','ESUC401NBLZ0','50','D','10','10',NULL,'Rehire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddress1"','11','(''UA''=''T,'')','ESUC401NBLZ0','50','D','10','11',NULL,'Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddress2"','12','(''UA''=''T,'')','ESUC401NBLZ0','50','D','10','12',NULL,'Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','13','(''UA''=''T,'')','ESUC401NBLZ0','50','D','10','13',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStateCode"','14','(''UA''=''T,'')','ESUC401NBLZ0','50','D','10','14',NULL,'State Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZipCode"','15','(''UA''=''T,'')','ESUC401NBLZ0','50','D','10','15',NULL,'Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaritalStatus"','16','(''UA''=''T,'')','ESUC401NBLZ0','50','D','10','16',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDivision"','17','(''UA''=''T,'')','ESUC401NBLZ0','50','D','10','17',NULL,'Division',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatementLanguageInd"','18','(''UA''=''T,'')','ESUC401NBLZ0','50','D','10','18',NULL,'Statement Language Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvExcludedClass"','19','(''UA''=''T,'')','ESUC401NBLZ0','50','D','10','19',NULL,'Excluded Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvExcludedClassEffDate"','20','(''UD101''=''T,'')','ESUC401NBLZ0','50','D','10','20',NULL,'Excluded Class Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUnionMember"','21','(''UA''=''T,'')','ESUC401NBLZ0','50','D','10','21',NULL,'Union Member',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUnionMemberEffDate"','22','(''UD101''=''T,'')','ESUC401NBLZ0','50','D','10','22',NULL,'Union Member Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomeCellularPhoneNumber"','23','(''UA''=''T,'')','ESUC401NBLZ0','50','D','10','23',NULL,'Home/Cellular Telephone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkPhoneNumber"','24','(''UA''=''T,'')','ESUC401NBLZ0','50','D','10','24',NULL,'Work Telephone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmailAddress"','25','(''UA''=''T,'')','ESUC401NBLZ0','50','D','10','25',NULL,'Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorksiteWebAccInd"','26','(''UA''=''T,'')','ESUC401NBLZ0','50','D','10','26',NULL,'Worksite Web Access Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPeriodPlanComp"','27','(''UA''=''T,'')','ESUC401NBLZ0','50','D','10','27',NULL,'Period Plan Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPeriodGrossComp"','28','(''UA''=''T,'')','ESUC401NBLZ0','50','D','10','28',NULL,'Period Gross Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPeriodTaxableComp"','29','(''UA''=''T,'')','ESUC401NBLZ0','50','D','10','29',NULL,'Period Taxable Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPeriodPlanHours"','30','(''UA''=''T,'')','ESUC401NBLZ0','50','D','10','30',NULL,'Period Plan Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDPlanComp"','31','(''UA''=''T,'')','ESUC401NBLZ0','50','D','10','31',NULL,'YTD Plan Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDGrossComp"','32','(''UA''=''T,'')','ESUC401NBLZ0','50','D','10','32',NULL,'YTD Gross Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDTaxableComp"','33','(''UA''=''T,'')','ESUC401NBLZ0','50','D','10','33',NULL,'YTD Taxable Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDPlanHours"','34','(''UA''=''T,'')','ESUC401NBLZ0','50','D','10','34',NULL,'YTD  Plan Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEPretaxDeferralRate"','35','(''UA''=''T,'')','ESUC401NBLZ0','50','D','10','35',NULL,'EE Pre-tax Deferral Rate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEPretaxDeferralAmount"','36','(''UA''=''T,'')','ESUC401NBLZ0','50','D','10','36',NULL,'EE Pre-tax Deferral Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEERothkAftertaxDefRate"','37','(''UA''=''T,'')','ESUC401NBLZ0','50','D','10','37',NULL,'EE Roth(k) After-tax Deferral Rate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEERothkAftertaxDefAmount"','38','(''UA''=''T,'')','ESUC401NBLZ0','50','D','10','38',NULL,'EE Roth(k) After-tax Deferral Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvERSafeHarborMatch"','39','(''UA''=''T'')','ESUC401NBLZ0','50','D','10','39',NULL,'ER Safe Harbor Match',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ESUC401NBL_20200918.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','201901189','EMPEXPORT','SCHEDULED',NULL,'ESUC401NBL',NULL,NULL,NULL,'201901189','Mar  4 2019 12:27PM','Mar  4 2019 12:27PM','201901181',NULL,'','','201901181',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ESUC401NBL_20200918.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','201901189','EMPEXPORT','OEACTIVE',NULL,'ESUC401NBL',NULL,NULL,NULL,'201901189','Mar  4 2019 12:27PM','Mar  4 2019 12:27PM','201901181',NULL,'','','201901181',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ESUC401NBL_20200918.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','201901189','EMPEXPORT','OEPASSIVE',NULL,'ESUC401NBL',NULL,NULL,NULL,'201901189','Mar  4 2019 12:27PM','Mar  4 2019 12:27PM','201901181',NULL,'','','201901181',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ESUC401NBL_20200918.txt',NULL,'','','',NULL,NULL,NULL,'Securian Financial 401K File','201911229','EMPEXPORT','ONDEMAND','Nov 26 2019  7:14PM','ESUC401NBL',NULL,NULL,NULL,'201911229','Nov 22 2019 12:00AM','Dec 30 1899 12:00AM','201911221','486','eecPayGroup','HRNE','201911221',dbo.fn_GetTimedKey(),NULL,'ULTI_WPNBLLC',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ESUC401NBL_20200918.txt',NULL,'','','JM3C0',NULL,NULL,NULL,'Test Purposes Only','201911221','EMPEXPORT','TEST','Dec  2 2019  5:50PM','ESUC401NBL',NULL,NULL,NULL,'201911221','Nov 22 2019 12:00AM','Nov 16 2019 12:00AM','201911221','581','eecPayGroup','EXSAL,HRNE','201911221',dbo.fn_GetTimedKey(),NULL,'ULTI_WPNBLLC',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_ESUC401NBL_20200918.txt' END WHERE expFormatCode = 'ESUC401NBL';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESUC401NBL','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESUC401NBL','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESUC401NBL','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESUC401NBL','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESUC401NBL','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESUC401NBL','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'ESUC401NBL' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ESUC401NBL' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_ESUC401NBL_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ESUC401NBL_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUC401NBL','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUC401NBL','D10','dbo.U_ESUC401NBL_drvTbl',NULL);
IF OBJECT_ID('U_ESUC401NBL_DedList') IS NULL
CREATE TABLE [dbo].[U_ESUC401NBL_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ESUC401NBL_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ESUC401NBL_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvPlanNumber] varchar(6) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvPayDate] datetime NULL,
    [drvEmployeeLastName] varchar(8000) NULL,
    [drvEmployeeFirstName] varchar(8000) NULL,
    [drvGender] char(1) NULL,
    [drvBirthDate] datetime NULL,
    [drvOriginalHireDate] datetime NULL,
    [drvTerminationDate] datetime NULL,
    [drvRehireDate] datetime NULL,
    [drvAddress1] varchar(8000) NULL,
    [drvAddress2] varchar(8000) NULL,
    [drvCity] varchar(8000) NULL,
    [drvStateCode] varchar(255) NULL,
    [drvZipCode] varchar(50) NULL,
    [drvMaritalStatus] varchar(1) NULL,
    [drvDivision] varchar(1) NOT NULL,
    [drvStatementLanguageInd] varchar(1) NULL,
    [drvExcludedClass] varchar(1) NOT NULL,
    [drvExcludedClassEffDate] datetime NULL,
    [drvUnionMember] varchar(1) NOT NULL,
    [drvUnionMemberEffDate] varchar(1) NOT NULL,
    [drvHomeCellularPhoneNumber] varchar(50) NULL,
    [drvWorkPhoneNumber] varchar(50) NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvWorksiteWebAccInd] varchar(1) NOT NULL,
    [drvPeriodPlanComp] money NULL,
    [drvPeriodGrossComp] money NULL,
    [drvPeriodTaxableComp] varchar(1) NOT NULL,
    [drvPeriodPlanHours] money NULL,
    [drvYTDPlanComp] money NULL,
    [drvYTDGrossComp] money NULL,
    [drvYTDTaxableComp] varchar(1) NOT NULL,
    [drvYTDPlanHours] money NULL,
    [drvEEPretaxDeferralRate] money NULL,
    [drvEEPretaxDeferralAmount] money NULL,
    [drvEERothkAftertaxDefRate] money NULL,
    [drvEERothkAftertaxDefAmount] money NULL,
    [drvERSafeHarborMatch] money NULL
);
IF OBJECT_ID('U_ESUC401NBL_EEList') IS NULL
CREATE TABLE [dbo].[U_ESUC401NBL_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ESUC401NBL_File') IS NULL
CREATE TABLE [dbo].[U_ESUC401NBL_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
IF OBJECT_ID('U_ESUC401NBL_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ESUC401NBL_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [pdhCalcRate1] decimal NULL,
    [pdhCalcRate2] decimal NULL,
    [PdhDedCode] char(5) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhSource1] numeric NULL,
    [PdhSource2] numeric NULL,
    [PdhSource3] numeric NULL
);
IF OBJECT_ID('U_ESUC401NBL_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ESUC401NBL_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESUC401NBL]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Nature's Bakery, LLC

Created By: Parsha Antara
Business Analyst: Karol Violan
Create Date: 03/04/2019
Service Request Number: SR-2018-00222308

Purpose: Securian Financial 401K File

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2019     SR-2019-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ESUC401NBL';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ESUC401NBL';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ESUC401NBL';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ESUC401NBL';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ESUC401NBL' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESUC401NBL', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESUC401NBL', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESUC401NBL', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESUC401NBL', 'TEST';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ESUC401NBL';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ESUC401NBL', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ESUC401NBL';

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

    --Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_ESUC401NBL_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ESUC401NBL_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_ESUC401NBL_EEList
    FROM dbo.U_ESUC401NBL_EEList
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCoiD = xCoId
    WHERE EecEEType IN ('CON','TES') ;

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '401K,401CU,401M,401KR,401RC';

    IF OBJECT_ID('U_ESUC401NBL_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ESUC401NBL_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ESUC401NBL_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- Build Working Tables
    --==========================================
    
    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_ESUC401NBL_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ESUC401NBL_PDedHist;
    SELECT DISTINCT
         PdhEEID
        ,pdhCalcRate1 = CASE WHEN PdhDedCode in ('401K','401CU') THEN pdhEECalcRateOrPct*100 END
        ,pdhCalcRate2 = CASE WHEN PdhDedCode in ('401KR','401RC') THEN pdhEECalcRateOrPct*100 END 
        ,PdhDedCode
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('401K','401CU') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('401KR','401RC') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('401M') THEN PdhERCurAmt ELSE 0.00 END)        
    INTO dbo.U_ESUC401NBL_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ESUC401NBL_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID, pdhEECalcRateOrPct, PdhDedCode
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );


    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_ESUC401NBL_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ESUC401NBL_PEarHist;
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
    INTO dbo.U_ESUC401NBL_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;

    --==========================================
    -- Latest PayDate
    --==========================================
    DECLARE @LastPayDateStart AS DATETIME
    DECLARE @LastPayDateEnd AS DATETIME
    DECLARE @LatPayDate AS DATETIME
    SELECT    @LastPayDateStart = MIN(PrgPeriodStartDate)
            ,@LastPayDateEnd = MAX(PrgPeriodEndDate)
            ,@LatPayDate = MAX(PrgPayDate)
    FROM PayReg
    JOIN U_ESUC401NBL_EEList WITH (NOLOCK)
        ON PrgEEID = xEEID
    WHERE PrgDocNo NOT LIKE 'ADJ%'
    AND PrgPerControl BETWEEN @StartPerControl and @EndPerControl   


    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ESUC401NBL_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ESUC401NBL_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ESUC401NBL_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = EepSSN
        -- standard fields above and additional driver fields below
        ,drvPlanNumber = '068306'
        ,drvSSN = eepSSN
        ,drvPayDate = @LatPayDate
        ,drvEmployeeLastName = REPLACE(EepNameLast,',','')
        ,drvEmployeeFirstName = REPLACE(EepNameFirst,',','')
        ,drvGender = EepGender
        ,drvBirthDate = EepDateOfBirth
        ,drvOriginalHireDate = EecDateofOriginalHire --KV 3/19/19 Used to be EecDateOfLastHire 
        ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvRehireDate = CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN EecDateOfLastHire END --KV 3/19/19 Used to be EecDateofLastHire
        ,drvAddress1 = REPLACE(EepAddressLine1,',','')
        ,drvAddress2 = REPLACE(EepAddressLine2,',','')
        ,drvCity = REPLACE(EepAddressCity,',','')
        ,drvStateCode = EepAddressState
        ,drvZipCode = EepAddressZipCode
        ,drvMaritalStatus = CASE WHEN eepMaritalStatus = 'Z' THEN 'S' ELSE eepMaritalStatus END --KV 3/19/19 Manipulate for now until client can clean up data. 
        ,drvDivision = ''
        ,drvStatementLanguageInd = CASE EecPrefLangWebPayStmt WHEN 'EN' THEN '0' WHEN 'SP' THEN '1' END --KV 3/25/2019
        ,drvExcludedClass = CASE WHEN EecEEType <> 'REG' OR EecFullTimeOrPartTime <> 'F' THEN 'Y' ELSE 'N' END
        ,drvExcludedClassEffDate = CASE WHEN EecEEType <> 'REG' OR EecFullTimeOrPartTime <> 'F' THEN EecDateOfLastHire ELSE null END --CASE WHEN EjhFullTimeOrPartTime = 'F' THEN dbo.fn_findeffdate_emphjob('xEEID', 'fulltimeorparttime') ELSE NULL END
        ,drvUnionMember = ''
        ,drvUnionMemberEffDate = ''
        ,drvHomeCellularPhoneNumber = EepPhoneHomeNumber
        ,drvWorkPhoneNumber = EecPhoneBusinessNumber
        ,drvEmailAddress = EepAddressEMail
        ,drvWorksiteWebAccInd = ''
        ,drvPeriodPlanComp = CAST(PehInclInDefComp as money)
        ,drvPeriodGrossComp = CAST(PehCurAmt as money)
        ,drvPeriodTaxableComp = ''
        ,drvPeriodPlanHours = CAST(PehInclInDefCompHrs as money)
        ,drvYTDPlanComp = CASE WHEN LEFT(@StartPerControl,4) = '2019' OR LEFT(@EndPerControl,4) = '2019' 
                                    THEN CAST(PehInclInDefCompYTD  + ISNULL(EecUDfield10,0) as money) 
                               ELSE CAST(PehInclInDefCompYTD as money) END
        ,drvYTDGrossComp = CASE WHEN LEFT(@StartPerControl,4) = '2019' OR LEFT(@EndPerControl,4) = '2019' 
                                    THEN CAST(PehCurAmtYTD  + ISNULL(EecUDField09,0) as money) 
                               ELSE CAST(PehCurAmtYTD as money) END
        ,drvYTDTaxableComp = ''
        ,drvYTDPlanHours = CASE WHEN LEFT(@StartPerControl,4) = '2019' OR LEFT(@EndPerControl,4) = '2019' 
                                    THEN CAST(PehInclInDefCompHrsYTD + ISNULL(EecUDField11,0) as money) 
                               ELSE CAST(PehInclInDefCompHrsYTD as money) END 
        ,drvEEPretaxDeferralRate = CASE WHEN Def.PdhCalcRate1 = 0.00 THEN '99.99' ELSE CAST(Def.pdhCalcRate1 as money) END -- For EEs who contribute a flat amount default them to 99.99 per vendor . CAST(CASE WHEN PdhDedCode in ('401K','401CU') THEN pdhEECalcRateOrPct*100 END as money)
        ,drvEEPretaxDeferralAmount = CAST(Def.PdhSource1 as money) --+ isnull(Defc.PdhSource1,0) as money) --CAST(Def.PdhSource1 as money)
        ,drvEERothkAftertaxDefRate = CAST(Roth.pdhCalcRate2 as money) --CAST(CASE WHEN PdhDedCode in ('401KR','401RC') THEN pdhEECalcRateOrPct*100 END as money)
        ,drvEERothkAftertaxDefAmount = CAST(Roth.PdhSource2 as money)
        ,drvERSafeHarborMatch = CAST(Match.PdhSource3 as moneY)
    INTO dbo.U_ESUC401NBL_drvTbl
    FROM dbo.U_ESUC401NBL_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_ESUC401NBL_PEarHist WITH (NOLOCK) --To include employees with earnings for the year the file was 'join' 3/25/19
        ON PehEEID = xEEID
    LEFT JOIN dbo.U_ESUC401NBL_PDedHist Def
        ON Def.PdhEEID = xEEID
        AND Def.PdhDedCode IN ('401K','401CU') 
    --LEFT JOIN dbo.U_ESUC401NBL_PDedHist Defc
    --    ON Def.PdhEEID = xEEID
    --    AND Def.PdhDedCode IN ('401CU') --Added multiple leftjoins per contribution type KV 3/19/19
    LEFT JOIN dbo.U_ESUC401NBL_PDedHist Roth
        ON Roth.PdhEEID = xEEID
        AND Roth.PdhDedCode IN ('401KR','401RC')
    LEFT JOIN dbo.U_ESUC401NBL_PDedHist Match
        ON Match.PdhEEID = xEEID
        AND Match.PdhDedCode IN ('401M') 
    --JOIN dbo.EmpHJob WITH (NOLOCK)
    --    ON EjhEEID =xEEID
    --    AND EjhCoID = xCoiD
    --LEFT JOIN dbo.dsi_fnlib_JobHistoryTable3('EjhEEType') AS EffDate --Track Effective date changes when an EE goes from INT, CON, ENT, SUM, SEV to REG employee. 
    --    ON EffDate.EEID = xEEID
    --    AND EffDate.COID = xCOID
    --    AND OldValue IN ('INT','CON','ENT','SUM','SEV') 
    --  AND NewValue = 'REG'
    WHERE (PehEEID IS NOT NULL OR Def.PdhEEID IS NOT NULL OR Roth.PdhEEID IS NOT NULL OR Match.PdhEEID IS NOT NULL)

    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_ESUC401NBL_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'OE_ESUC401NBL_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'ESUC401NBL_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwESUC401NBL_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ESUC401NBL_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ESUC401NBL%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201901181'
       ,expStartPerControl     = '201901181'
       ,expLastEndPerControl   = '201901189'
       ,expEndPerControl       = '201901189'
WHERE expFormatCode = 'ESUC401NBL';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwESUC401NBL_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ESUC401NBL_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort