SET NOCOUNT ON;
IF OBJECT_ID('U_EDISCCOBQB_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EDISCCOBQB_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EDISCCOBQB_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EDISCCOBQB' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEDISCCOBQB_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEDISCCOBQB_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EDISCCOBQB') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EDISCCOBQB];
GO
IF OBJECT_ID('U_EDISCCOBQB_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EDISCCOBQB_PEarHist];
GO
IF OBJECT_ID('U_EDISCCOBQB_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EDISCCOBQB_PDedHist];
GO
IF OBJECT_ID('U_EDISCCOBQB_Header') IS NOT NULL DROP TABLE [dbo].[U_EDISCCOBQB_Header];
GO
IF OBJECT_ID('U_EDISCCOBQB_File') IS NOT NULL DROP TABLE [dbo].[U_EDISCCOBQB_File];
GO
IF OBJECT_ID('U_EDISCCOBQB_EEList') IS NOT NULL DROP TABLE [dbo].[U_EDISCCOBQB_EEList];
GO
IF OBJECT_ID('U_EDISCCOBQB_Edh_WorkingTable') IS NOT NULL DROP TABLE [dbo].[U_EDISCCOBQB_Edh_WorkingTable];
GO
IF OBJECT_ID('U_EDISCCOBQB_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL') IS NOT NULL DROP TABLE [dbo].[U_EDISCCOBQB_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL];
GO
IF OBJECT_ID('U_EDISCCOBQB_drvTbl_QBPLANINITIAL') IS NOT NULL DROP TABLE [dbo].[U_EDISCCOBQB_drvTbl_QBPLANINITIAL];
GO
IF OBJECT_ID('U_EDISCCOBQB_drvTbl_QBPLAN') IS NOT NULL DROP TABLE [dbo].[U_EDISCCOBQB_drvTbl_QBPLAN];
GO
IF OBJECT_ID('U_EDISCCOBQB_drvTbl_QBEVENT') IS NOT NULL DROP TABLE [dbo].[U_EDISCCOBQB_drvTbl_QBEVENT];
GO
IF OBJECT_ID('U_EDISCCOBQB_drvTbl_QBDEPENDENTPLANINITIAL') IS NOT NULL DROP TABLE [dbo].[U_EDISCCOBQB_drvTbl_QBDEPENDENTPLANINITIAL];
GO
IF OBJECT_ID('U_EDISCCOBQB_drvTbl_QBDEPENDENTPLAN') IS NOT NULL DROP TABLE [dbo].[U_EDISCCOBQB_drvTbl_QBDEPENDENTPLAN];
GO
IF OBJECT_ID('U_EDISCCOBQB_drvTbl_QBDEPENDENT') IS NOT NULL DROP TABLE [dbo].[U_EDISCCOBQB_drvTbl_QBDEPENDENT];
GO
IF OBJECT_ID('U_EDISCCOBQB_drvTbl_QB') IS NOT NULL DROP TABLE [dbo].[U_EDISCCOBQB_drvTbl_QB];
GO
IF OBJECT_ID('U_EDISCCOBQB_drvTbl_NPM') IS NOT NULL DROP TABLE [dbo].[U_EDISCCOBQB_drvTbl_NPM];
GO
IF OBJECT_ID('U_EDISCCOBQB_DedList') IS NOT NULL DROP TABLE [dbo].[U_EDISCCOBQB_DedList];
GO
IF OBJECT_ID('U_EDISCCOBQB_Cobra_Reason') IS NOT NULL DROP TABLE [dbo].[U_EDISCCOBQB_Cobra_Reason];
GO
IF OBJECT_ID('U_dsi_BDM_EDISCCOBQB') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EDISCCOBQB];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EDISCCOBQB';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EDISCCOBQB';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EDISCCOBQB';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EDISCCOBQB';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EDISCCOBQB';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EDISCCOBQB','Discover COBRA Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','EDISCCOBQBZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[Version]"','1','(''DA''=''T,'')','EDISCCOBQBZ0','50','H','01','1',NULL,'Header',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVersion"','2','(''UA''=''T'')','EDISCCOBQBZ0','50','H','01','2',NULL,'Version',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QB]"','1','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','10','1',NULL,'Header',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Foxworth-Galbraith Lumber Co 36333"','2','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','10','2',NULL,'Client Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Foxworth-Galbraith Lumber Co"','3','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','10','3',NULL,'Client Division Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','4','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','10','4',NULL,'Salutation ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','5','(''UA''=''T,'')','EDISCCOBQBZ0','50','D','10','5',NULL,'First Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddleInit"','6','(''UA''=''T,'')','EDISCCOBQBZ0','50','D','10','6',NULL,'Middle Initial ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','7','(''UA''=''T,'')','EDISCCOBQBZ0','50','D','10','7',NULL,'Last Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','8','(''UA''=''T,'')','EDISCCOBQBZ0','50','D','10','8',NULL,'SSN ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','10','9',NULL,'Individual ID ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','10','10',NULL,'Email ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','11','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','10','11',NULL,'Phone ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','12','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','10','12',NULL,'Phone 2 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','13','(''UA''=''T,'')','EDISCCOBQBZ0','50','D','10','13',NULL,'Address 1 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','14','(''UA''=''T,'')','EDISCCOBQBZ0','50','D','10','14',NULL,'Address 2 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','15','(''UA''=''T,'')','EDISCCOBQBZ0','50','D','10','15',NULL,'City ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','16','(''UA''=''T,'')','EDISCCOBQBZ0','50','D','10','16',NULL,'State or Province ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','17','(''UA''=''T,'')','EDISCCOBQBZ0','50','D','10','17',NULL,'Postal Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','10','18',NULL,'Country ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"True"','19','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','10','19',NULL,'Premium Address Same As Primary ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','20','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','10','20',NULL,'Premium Address 1 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','21','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','10','21',NULL,'Premium Address 2 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','22','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','10','22',NULL,'Premium City ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','23','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','10','23',NULL,'Premium State Or Province ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','24','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','10','24',NULL,'Premium Postal Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','25','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','10','25',NULL,'Premium Country ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','26','(''UA''=''T,'')','EDISCCOBQBZ0','50','D','10','26',NULL,'Sex ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','27','(''UD101''=''T,'')','EDISCCOBQBZ0','50','D','10','27',NULL,'DOB ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTobaccoUse"','28','(''UA''=''T,'')','EDISCCOBQBZ0','50','D','10','28',NULL,'Tobacco Use ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FTE"','29','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','10','29',NULL,'Employee Type ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmplPayrollType"','30','(''UA''=''T,'')','EDISCCOBQBZ0','50','D','10','30',NULL,'Employee Payroll Type ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','31','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','10','31',NULL,'Years of Service ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPreimCouponType"','32','(''UA''=''T,'')','EDISCCOBQBZ0','50','D','10','32',NULL,'Premium Coupon Type ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','33','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','10','33',NULL,'Uses HCTC ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"True"','34','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','10','34',NULL,'Active ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"False"','35','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','10','35',NULL,'Allow Member SSO ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','36','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','10','36',NULL,'Benefit Group ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','37','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','10','37',NULL,'Account Structure ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','38','(''DA''=''T'')','EDISCCOBQBZ0','50','D','10','38',NULL,'Client Specific Data ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBEVENT]"','1','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','20','1',NULL,'Header',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEventType"','2','(''UA''=''T,'')','EDISCCOBQBZ0','50','D','20','2',NULL,'Event Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEventDate"','3','(''UD101''=''T,'')','EDISCCOBQBZ0','50','D','20','3',NULL,'Event Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrollmentDate"','4','(''UD101''=''T,'')','EDISCCOBQBZ0','50','D','20','4',NULL,'Enrollment Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','5','(''UA''=''T,'')','EDISCCOBQBZ0','50','D','20','5',NULL,'Employee SSN ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','6','(''UA''=''T,'')','EDISCCOBQBZ0','50','D','20','6',NULL,'Employee Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','7','(''DA''=''T'')','EDISCCOBQBZ0','50','D','20','7',NULL,'Second Event Original FDOC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBPLANINITIAL]"','1','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','30','1',NULL,'Header',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanName"','2','(''UA''=''T,'')','EDISCCOBQBZ0','250','D','30','2',NULL,'Plan Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageLevel"','3','(''UA''=''T,'')','EDISCCOBQBZ0','50','D','30','3',NULL,'Coverage Level ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','4','(''DA''=''T'')','EDISCCOBQBZ0','50','D','30','4',NULL,'Number Of Units ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBDEPENDENT]"','1','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','40','1',NULL,'Header',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','2','(''UA''=''T,'')','EDISCCOBQBZ0','50','D','40','2',NULL,'SSN ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelationship"','3','(''UA''=''T,'')','EDISCCOBQBZ0','50','D','40','3',NULL,'Relationship ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','4','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','40','4',NULL,'Salutation ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','5','(''UA''=''T,'')','EDISCCOBQBZ0','50','D','40','5',NULL,'First Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddleInit"','6','(''UA''=''T,'')','EDISCCOBQBZ0','50','D','40','6',NULL,'Middle Initial ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','7','(''UA''=''T,'')','EDISCCOBQBZ0','50','D','40','7',NULL,'Last Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','40','8',NULL,'Email ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','40','9',NULL,'Phone ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','40','10',NULL,'Phone 2 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"True"','11','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','40','11',NULL,'Address Same As QB ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','12','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','40','12',NULL,'Address 1 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','13','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','40','13',NULL,'Address 2 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','14','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','40','14',NULL,'City ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','15','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','40','15',NULL,'State Or Province ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','16','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','40','16',NULL,'Postal Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','17','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','40','17',NULL,'Country ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','40','18',NULL,'Enrollment Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','19','(''UA''=''T,'')','EDISCCOBQBZ0','50','D','40','19',NULL,'Sex ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','20','(''UD101''=''T,'')','EDISCCOBQBZ0','50','D','40','20',NULL,'DOB ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','21','(''DA''=''T'')','EDISCCOBQBZ0','50','D','40','21',NULL,'Is QMCSO ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBDEPENDENTPLANINITIAL]"','1','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','50','1',NULL,'Header',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanName"','2','(''UA''=''T'')','EDISCCOBQBZ0','100','D','50','2',NULL,'Plan Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[NPM]"','1','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','70','1',NULL,'Header',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','2','(''UA''=''T,'')','EDISCCOBQBZ0','50','D','70','2',NULL,'SSN ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','70','3',NULL,'Individual Identifier ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Foxworth-Galbraith Lumber Co 36333"','4','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','70','4',NULL,'Client Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Foxworth-Galbraith Lumber Co"','5','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','70','5',NULL,'Client Division Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','6','(''UA''=''T,'')','EDISCCOBQBZ0','50','D','70','6',NULL,'First Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddleInit"','7','(''UA''=''T,'')','EDISCCOBQBZ0','50','D','70','7',NULL,'Middle Initial ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','8','(''UA''=''T,'')','EDISCCOBQBZ0','50','D','70','8',NULL,'Last Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','70','9',NULL,'Salutation ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','70','10',NULL,'Email ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','11','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','70','11',NULL,'Phone ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','12','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','70','12',NULL,'Phone 2 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','13','(''UA''=''T,'')','EDISCCOBQBZ0','50','D','70','13',NULL,'Address 1 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','14','(''UA''=''T,'')','EDISCCOBQBZ0','50','D','70','14',NULL,'Address 2 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','15','(''UA''=''T,'')','EDISCCOBQBZ0','50','D','70','15',NULL,'City ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','16','(''UA''=''T,'')','EDISCCOBQBZ0','50','D','70','16',NULL,'State Or Province ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','17','(''UA''=''T,'')','EDISCCOBQBZ0','50','D','70','17',NULL,'Postal Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','70','18',NULL,'Country ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','19','(''UA''=''T,'')','EDISCCOBQBZ0','50','D','70','19',NULL,'Sex ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','20','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','70','20',NULL,'Uses Family In Address ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FALSE"','21','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','70','21',NULL,'Has Waived All Coverage ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TRUE"','22','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','70','22',NULL,'Send GR Notice ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','23','(''DA''=''T'')','EDISCCOBQBZ0','50','D','70','23',NULL,'Hire Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBPLAN]"','1','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','80','1',NULL,'Header',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanName"','2','(''UA''=''T,'')','EDISCCOBQBZ0','50','D','80','2',NULL,'Plan Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStartDate"','3','(''UD101''=''T,'')','EDISCCOBQBZ0','50','D','80','3',NULL,'Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','4','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','80','4',NULL,'End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageLevel"','5','(''UA''=''T,'')','EDISCCOBQBZ0','50','D','80','5',NULL,'Coverage Level ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','6','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','80','6',NULL,'First Day of COBRA',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','7','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','80','7',NULL,'Last Day of COBRA',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','80','8',NULL,'COBRA Duration Months',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','80','9',NULL,'Days to Elect',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','80','10',NULL,'Days to Make 1st Payment',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','11','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','80','11',NULL,'Days to Make Subsequent Payments',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','12','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','80','12',NULL,'Eletion Postmark Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','13','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','80','13',NULL,'Last Date Rates Notified',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','14','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','80','14',NULL,'Number of Units ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','15','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','80','15',NULL,'Send Plan Change Letter For Legacy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanBundleName"','16','(''UA''=''T'')','EDISCCOBQBZ0','50','D','80','16',NULL,'Plan Bundle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBDEPENDENTPLAN]"','1','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','82','1',NULL,'Header',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanName"','2','(''UA''=''T,'')','EDISCCOBQBZ0','50','D','82','2',NULL,'Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStartDate"','3','(''UD101''=''T,'')','EDISCCOBQBZ0','50','D','82','3',NULL,'Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','4','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','82','4',NULL,'End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TRUE"','5','(''DA''=''T,'')','EDISCCOBQBZ0','50','D','82','5',NULL,'Uses FDOC',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EDISCCOBQB_20200715.txt',NULL,'','','',NULL,NULL,NULL,'Discover COBRA QB Export','202007109','EMPEXPORT','ONDEMAND','Mar  3 2020 12:13PM','EDISCCOBQB',NULL,NULL,NULL,'202007109','Feb 25 2020  9:06AM','Feb 25 2020  9:06AM','202003011','589','','','200203011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EDISCCOBQB_20200715.txt',NULL,'','','IAGFG,PHWIZ',NULL,NULL,NULL,'Discovery COBRA - Mon 9pm','202007109','EMPEXPORT','SCHEDULED','Mar  3 2020 12:13PM','EDISCCOBQB',NULL,NULL,NULL,'202007139','Feb 25 2020  9:06AM','Feb 25 2020  9:06AM','202007061','589','','','200203011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EDISCCOBQB_20200715.txt',NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','202007109','EMPEXPORT','OEACTIVE','Mar  3 2020 12:11PM','EDISCCOBQB',NULL,NULL,NULL,'202007109','Feb 25 2020  9:06AM','Feb 25 2020  9:06AM','202003011','589','','','200203011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EDISCCOBQB_20200715.txt',NULL,'','','',NULL,NULL,NULL,'Passive Open Enrollment Export','202007109','EMPEXPORT','OEPASSIVE','Mar  3 2020 12:12PM','EDISCCOBQB',NULL,NULL,NULL,'202007109','Feb 25 2020  9:06AM','Feb 25 2020  9:06AM','202003011','589','','','200203011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EDISCCOBQB_20200715.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202007109','EMPEXPORT','TEST','Apr 29 2020 11:57AM','EDISCCOBQB',NULL,NULL,NULL,'202007109','Apr 29 2020 12:00AM','Dec 30 1899 12:00AM','202003011','139','','','200203011',dbo.fn_GetTimedKey(),NULL,'us3lKiFOX1002',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EDISCCOBQB_20200715.txt' END WHERE expFormatCode = 'EDISCCOBQB';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCCOBQB','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCCOBQB','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCCOBQB','InitialSort','C','drvSort1');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCCOBQB','SubSort','C','drvSort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCCOBQB','SubSort2','C','drvSort3');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCCOBQB','SubSort3','C','drvSort4');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCCOBQB','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCCOBQB','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EDISCCOBQB' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EDISCCOBQB' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EDISCCOBQB_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EDISCCOBQB_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCCOBQB','H01','dbo.U_EDISCCOBQB_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCCOBQB','D10','dbo.U_EDISCCOBQB_drvTbl_QB',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCCOBQB','D20','dbo.U_EDISCCOBQB_drvTbl_QBEVENT',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCCOBQB','D30','dbo.U_EDISCCOBQB_drvTbl_QBPLANINITIAL',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCCOBQB','D40','dbo.U_EDISCCOBQB_drvTbl_QBDEPENDENT',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCCOBQB','D50','dbo.U_EDISCCOBQB_drvTbl_QBDEPENDENTPLANINITIAL',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCCOBQB','D70','dbo.U_EDISCCOBQB_drvTbl_NPM',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCCOBQB','D80','dbo.U_EDISCCOBQB_drvTbl_QBPLAN',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCCOBQB','D82','dbo.U_EDISCCOBQB_drvTbl_QBDEPENDENTPLAN',NULL);
IF OBJECT_ID('U_dsi_BDM_EDISCCOBQB') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EDISCCOBQB] (
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
IF OBJECT_ID('U_EDISCCOBQB_Cobra_Reason') IS NULL
CREATE TABLE [dbo].[U_EDISCCOBQB_Cobra_Reason] (
    [BdcEEID] char(12) NOT NULL,
    [BdcCOID] char(5) NULL,
    [BdcCobraReason] char(6) NULL,
    [BdcBenStartDate] datetime NULL
);
IF OBJECT_ID('U_EDISCCOBQB_DedList') IS NULL
CREATE TABLE [dbo].[U_EDISCCOBQB_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EDISCCOBQB_drvTbl_NPM') IS NULL
CREATE TABLE [dbo].[U_EDISCCOBQB_drvTbl_NPM] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort1] int NOT NULL,
    [drvSort2] char(1) NULL,
    [drvSort3] varchar(1) NOT NULL,
    [drvSort4] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddleInit] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvGender] char(1) NULL
);
IF OBJECT_ID('U_EDISCCOBQB_drvTbl_QB') IS NULL
CREATE TABLE [dbo].[U_EDISCCOBQB_drvTbl_QB] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort1] char(12) NULL,
    [drvSort2] int NOT NULL,
    [drvSort3] char(6) NULL,
    [drvSort4] varchar(1) NOT NULL,
    [drvNameFirst] varchar(6000) NULL,
    [drvNameMiddleInit] varchar(1) NULL,
    [drvNameLast] varchar(6000) NULL,
    [drvSSN] char(11) NULL,
    [drvAddressLine1] varchar(6000) NULL,
    [drvAddressLine2] varchar(6000) NULL,
    [drvAddressCity] varchar(6000) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvGender] char(1) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvTobaccoUse] varchar(7) NOT NULL,
    [drvEmplPayrollType] varchar(6) NOT NULL,
    [drvPreimCouponType] varchar(10) NOT NULL
);
IF OBJECT_ID('U_EDISCCOBQB_drvTbl_QBDEPENDENT') IS NULL
CREATE TABLE [dbo].[U_EDISCCOBQB_drvTbl_QBDEPENDENT] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort1] char(12) NULL,
    [drvSort2] int NOT NULL,
    [drvSort3] char(12) NULL,
    [drvSort4] int NOT NULL,
    [drvSSN] char(11) NULL,
    [drvRelationship] varchar(15) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddleInit] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvGender] char(1) NULL,
    [drvDateOfBirth] datetime NULL
);
IF OBJECT_ID('U_EDISCCOBQB_drvTbl_QBDEPENDENTPLAN') IS NULL
CREATE TABLE [dbo].[U_EDISCCOBQB_drvTbl_QBDEPENDENTPLAN] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort1] char(12) NULL,
    [drvSort2] int NOT NULL,
    [drvSort3] char(12) NULL,
    [drvSort4] int NOT NULL,
    [drvPlanName] varchar(28) NULL,
    [drvStartDate] datetime NULL
);
IF OBJECT_ID('U_EDISCCOBQB_drvTbl_QBDEPENDENTPLANINITIAL') IS NULL
CREATE TABLE [dbo].[U_EDISCCOBQB_drvTbl_QBDEPENDENTPLANINITIAL] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort1] char(12) NULL,
    [drvSort2] int NOT NULL,
    [drvSort3] char(12) NULL,
    [drvSort4] varchar(13) NOT NULL,
    [drvPlanName] varchar(28) NULL
);
IF OBJECT_ID('U_EDISCCOBQB_drvTbl_QBEVENT') IS NULL
CREATE TABLE [dbo].[U_EDISCCOBQB_drvTbl_QBEVENT] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort1] char(12) NULL,
    [drvSort2] char(6) NOT NULL,
    [drvSort3] varchar(1) NOT NULL,
    [drvSort4] int NOT NULL,
    [drvEventType] varchar(29) NULL,
    [drvEventDate] datetime NULL,
    [drvEnrollmentDate] datetime NULL,
    [drvSSN] char(11) NULL,
    [drvNameFirst] varchar(100) NULL
);
IF OBJECT_ID('U_EDISCCOBQB_drvTbl_QBPLAN') IS NULL
CREATE TABLE [dbo].[U_EDISCCOBQB_drvTbl_QBPLAN] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort1] char(12) NULL,
    [drvSort2] int NOT NULL,
    [drvSort3] char(5) NULL,
    [drvSort4] varchar(2) NULL,
    [drvPlanName] varchar(28) NULL,
    [drvStartDate] datetime NULL,
    [drvCoverageLevel] varchar(11) NULL,
    [drvPlanBundleName] varchar(42) NULL
);
IF OBJECT_ID('U_EDISCCOBQB_drvTbl_QBPLANINITIAL') IS NULL
CREATE TABLE [dbo].[U_EDISCCOBQB_drvTbl_QBPLANINITIAL] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort1] char(12) NULL,
    [drvSort2] int NOT NULL,
    [drvSort3] char(5) NULL,
    [drvSort4] varchar(2) NOT NULL,
    [drvPlanName] varchar(12) NOT NULL,
    [drvCoverageLevel] varchar(9) NULL
);
IF OBJECT_ID('U_EDISCCOBQB_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL') IS NULL
CREATE TABLE [dbo].[U_EDISCCOBQB_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL] (
    [drvEEID] varchar(1) NOT NULL,
    [drvCoID] varchar(1) NOT NULL,
    [drvDepRecID] varchar(1) NOT NULL,
    [drvSort1] varchar(1) NOT NULL,
    [drvSort2] varchar(1) NOT NULL,
    [drvSort3] varchar(1) NOT NULL,
    [drvSort4] varchar(1) NOT NULL,
    [drvPlanName] varchar(1) NOT NULL,
    [drvRate] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EDISCCOBQB_Edh_WorkingTable') IS NULL
CREATE TABLE [dbo].[U_EDISCCOBQB_Edh_WorkingTable] (
    [EdhEEID] char(12) NOT NULL,
    [EdhCoID] char(5) NOT NULL,
    [EdhDedCode] char(5) NOT NULL,
    [EdhChangeReason] char(6) NULL,
    [EdhEffDate] datetime NULL
);
IF OBJECT_ID('U_EDISCCOBQB_EEList') IS NULL
CREATE TABLE [dbo].[U_EDISCCOBQB_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EDISCCOBQB_File') IS NULL
CREATE TABLE [dbo].[U_EDISCCOBQB_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
IF OBJECT_ID('U_EDISCCOBQB_Header') IS NULL
CREATE TABLE [dbo].[U_EDISCCOBQB_Header] (
    [drvVersion] varchar(3) NOT NULL
);
IF OBJECT_ID('U_EDISCCOBQB_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EDISCCOBQB_PDedHist] (
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
IF OBJECT_ID('U_EDISCCOBQB_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EDISCCOBQB_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EDISCCOBQB]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Foxworth Galbraith

Created By: James Bender
Business Analyst: Lea King
Create Date: 02/25/2020
Service Request Number: TekP-2020-01-24-014

Purpose: Discover COBRA QB Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EDISCCOBQB';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EDISCCOBQB';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EDISCCOBQB';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EDISCCOBQB';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EDISCCOBQB' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISCCOBQB', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISCCOBQB', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISCCOBQB', 'OEACTIVE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EDISCCOBQB';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EDISCCOBQB', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EDISCCOBQB';

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
    DELETE FROM dbo.U_EDISCCOBQB_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EDISCCOBQB_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_EDISCCOBQB_EEList WHERE xEEID IN (
        SELECT DISTINCT EecEEID FROM dbo.EmpComp WITH (NOLOCK) WHERE eecEEType IN('TES')
    );

    /*DELETE FROM dbo.U_EDISCCOBQB_EEList WHERE xEEID IN (
        SELECT DISTINCT EecEEID 
        FROM dbo.EmpComp A WITH (NOLOCK) 
        WHERE EecDateOfLastHire BETWEEN @StartDate and @EndDate 
        AND EecEmplStatus = 'A'
    );*/

    --DELETE FROM dbo.U_EDISCCOBQB_EEList WHERE xEEID NOT IN ('D622ED000030') -- JCB
    --DELETE FROM dbo.U_EDISCCOBQB_EEList WHERE xEEID NOT IN ('D624T7000030')

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'AAP,HSP,HSPT,EYE,HSE,HSTE';

    IF OBJECT_ID('U_EDISCCOBQB_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCCOBQB_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EDISCCOBQB_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================

    -- Non Cobra
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    /*INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DedList);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');*/

     -- Required parameters
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DedList); -- ?
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'StartDateTime', @StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'EndDateTime',@EndDate + 90);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'TermSelectionOption','AuditDate');
    -- NPM parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RunID','NPM');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','X'); -- DedIsCobraCovered = 'Y'
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'NewEnrolleeType','4'); -- All new enrollees where no previous plan exists
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'TableType','EMP'); -- Only include employees on NPM file

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

    -- Cobra

    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DedList);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'CobraReasonsEmp', '204,LEVNT4,205,201,LEVNT3,202,203,208,206,200,210') -- add regular term and--  200 and 210
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'CobraReasonsDep', '204,LEVNT4,205,201,LEVNT3,202,203,208,206,200,210')
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraReasonsDepPQB','204,LEVNT4,205,201,LEVNT3,202,203,208,206,200,210');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraType','4'); -- Eep/ConCobraReason first, then EdhChangeReason. Include CHGRP for elig. ben groups
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraDate','3'); -- EedBenStopDate and DbnBenStopDate, unless Eep/ConDateOfCOBRAEvent exist
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraPQBType','1'); -- If no EE or spouse, ALL children are PQB (not just oldest)
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','Y'); -- DedIsCobraCovered = 'Y'
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CountDependents','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL,STC,DAU,SON')
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'RunID', 'Cobra')
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'AddToPreviousRun', 'Y')

    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    DELETE dbo.U_dsi_BDM_EDISCCOBQB WHERE BdmDedCode IN ('HSAPA','HSASA','HSASC')




    --==========================================
    -- Build Working Tables
    --==========================================
    IF OBJECT_ID('U_EDISCCOBQB_Edh_WorkingTable','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCCOBQB_Edh_WorkingTable;
    
    SELECT EdhEEID, EdhCoID, EdhDedCode, EdhChangeReason, EdhEffDate 
    INTO dbo.U_EDISCCOBQB_Edh_WorkingTable
    FROM (
            SELECT EDHEEID, EdhCOID, EdhDedCode, edhChangeReason, EdhEffDate, ROW_NUMBER() OVER(PARTITION BY EdhEEID, EdhCOID, EdhDedCode ORDER BY EdhEffDate DESC) AS rn 
                FROM dbo.EmpHDed a WITH (NOLOCK)
                WHERE EdhDedCode IN ('AAP','HSP','HSPT','EYE','HSE','HSTE') 
                    AND edhChangeReason IN ('204', 'LEVNT4', '210', '201', '205', '200', '203', '206') ) AS T
    WHERE RN = 1
    
    IF OBJECT_ID('U_EDISCCOBQB_Cobra_Reason','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCCOBQB_Cobra_Reason;
    SELECT BdmEEID AS BdcEEID, BdmCOID as BdcCOID, MAX(BdmCobraReason) AS BdcCobraReason, MAX(BdmBenStartDate) AS BdcBenStartDate
    INTO dbo.U_EDISCCOBQB_Cobra_Reason
    FROM dbo.U_dsi_BDM_EDISCCOBQB WITH (NOLOCK)
    GROUP BY BdmEEID, BdmCOID 

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EDISCCOBQB_drvTbl_QB
    ---------------------------------
    IF OBJECT_ID('U_EDISCCOBQB_drvTbl_QB','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCCOBQB_drvTbl_QB;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort1 = xEEID
        ,drvSort2 = 1
        ,drvSort3 = BdmCobraReason--''
        ,drvSort4 = '' -- EdhChangeReason --''
        -- standard fields above and additional driver fields below
        ,drvNameFirst = dbo.dsi_fnRemoveChars('.,/-',CASE WHEN BdmCobraReason IN ('201', '204', 'LEVNT3', 'LEVNT4', '210') THEN ConNameFirst ELSE EepNameFirst END)
        ,drvNameMiddleInit = LEFT(CASE WHEN BdmCobraReason IN ('201', '204', 'LEVNT3', 'LEVNT4', '210') THEN ConNameMiddle ELSE EepNameMiddle END,1)
        ,drvNameLast = dbo.dsi_fnRemoveChars('.,/-', CASE WHEN BdmCobraReason IN ('201', '204', 'LEVNT3', 'LEVNT4', '210') THEN ConNameLast ELSE EepNameLast END)
        ,drvSSN = CASE WHEN BdmCobraReason IN ('201', '204', 'LEVNT3', 'LEVNT4', '210') THEN ConSSN ELSE eepSSN END
        ,drvAddressLine1 = dbo.dsi_fnRemoveChars('.,/-', CASE WHEN BdmCobraReason IN ('201', '204', 'LEVNT3', 'LEVNT4', '210') THEN ConAddressLine1 ELSE EepAddressLine1 END)
        ,drvAddressLine2 = dbo.dsi_fnRemoveChars('.,/-', CASE WHEN BdmCobraReason IN ('201', '204', 'LEVNT3', 'LEVNT4', '210') THEN ConAddressLine2 ELSE EepAddressLine2 END)
        ,drvAddressCity = dbo.dsi_fnRemoveChars('.,/-', CASE WHEN BdmCobraReason IN ('201', '204', 'LEVNT3', 'LEVNT4', '210') THEN ConAddressCity ELSE EepAddressCity END)
        ,drvAddressState = CASE WHEN BdmCobraReason IN ('201', '204', 'LEVNT3', 'LEVNT4', '210') THEN ConAddressState ELSE EepAddressState END
        ,drvAddressZipCode = CASE WHEN BdmCobraReason IN ('201', '204', 'LEVNT3', 'LEVNT4', '210') THEN ConAddressZipCode ELSE EepAddressZipCode END
        ,drvGender = CASE WHEN BdmCobraReason IN ('201', '204', 'LEVNT3', 'LEVNT4', '210') THEN ConGender ELSE EepGender END
        ,drvDateOfBirth = CASE WHEN BdmCobraReason IN ('201', '204', 'LEVNT3', 'LEVNT4', '210') THEN ConDateOfBirth ELSE EepDateOfBirth END
        ,drvTobaccoUse =    CASE WHEN EepIsSmoker = 'Y' THEN 'YES'
                                WHEN EepIsSmoker = 'N' THEN 'NO'
                                ELSE 'UNKNOWN'
                            END
        ,drvEmplPayrollType = CASE WHEN EecSalaryOrHourly = 'S' THEN 'SALARY' ELSE 'HOURLY' END
        ,drvPreimCouponType = 'COUPONBOOK'
    INTO dbo.U_EDISCCOBQB_drvTbl_QB
    FROM dbo.U_EDISCCOBQB_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EDISCCOBQB WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRunId = 'Cobra'
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID -- JCB
    WHERE  (  (BdmRecType = 'EMP' AND BdmCobraReason NOT IN (/*'201',*/ '204', /*'LEVNT3',*/ 'LEVNT4', '210')) -- Employee
            OR (ConRelationship IN ('SPS', 'DP') AND BdmCobraReason IN ('204', 'LEVNT4', '210'))
            OR (ConRelationship IN ('CHL','DAU','SON','STC')  And BdmCobraReason IN ('201', 'LEVNT3')))
            AND (BdmBenStartDate <= EecDateOfTermination )

        --(BdmRecType <> 'EMP' or (BdmRecType = 'EMP' and BdmCobraReason NOT IN ('201', '204', 'LEVNT3', 'LEVNT4')))
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EDISCCOBQB_drvTbl_QBEVENT
    ---------------------------------
    IF OBJECT_ID('U_EDISCCOBQB_drvTbl_QBEVENT','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCCOBQB_drvTbl_QBEVENT;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort1 = xEEID --ISNULL(BdmCobraReason, '**') + ' -- ' + ISNULL(EepCobraReason, '*')
        ,drvSort2 = ISNULL(BdcCobraReason, '**') -- 3 --BdmDedCode
        ,drvSort3 = '' --ConNameFirst
        ,drvSort4 = 1
        -- standard fields above and additional driver fields below
        ,drvEventType =    CASE WHEN (EecEmplStatus = 'T' OR BdcCobraReason = '208') AND EecTermReason = '202' THEN 'RETIREMENT'
                            WHEN EecEmplStatus = 'T' THEN --'T ** ' + ISNULL(EecEmplStatus, 'nope') + ' * ' + ISNULL(BdmCobraReason, 'nope') + ' * ' + ISNULL(EecTermReason, 'nope') + '*'
                                CASE WHEN RTRIM(LTRIM(EecTermReason)) = '203' THEN 'DEATH' --210 (is a benefit term)
                                    WHEN RTRIM(LTRIM(EecTermReason)) NOT IN ('202', '203', '200') AND RTRIM(LTRIM(EecTermType)) = 'V' THEN 'TERMINATION'    --200 (is a benefit term) 
                                    WHEN RTRIM(LTRIM(EecTermType)) IN ('I') THEN 'INVOLUNTARYTERMINATION'
                                    ELSE 'INNER'
                                END 
                            WHEN RTRIM(LTRIM(BdcCobraReason)) IN ('204', 'LEVNT4') THEN 'DIVORCELEGALSEPARATION'
                            WHEN RTRIM(LTRIM(BdcCobraReason)) IN ('205') THEN 'MEDICARE'
                            WHEN RTRIM(LTRIM(BdcCobraReason)) IN ('201', 'LEVNT3') THEN 'INELIGIBLEDEPENDENT'
                            WHEN RTRIM(LTRIM(BdcCobraReason)) IN ('203', 'LEVNT2') THEN 'REDUCTIONINHOURS-STATUSCHANGE' -- JCB
                            WHEN RTRIM(LTRIM(BdcCobraReason)) IN ('206') THEN 'REDUCTIONINHOURSENDOFLEAVE'
                        END
                        -- depends on clients platform configurable. 
        ,drvEventDate =    CASE WHEN BdcCobraReason IN ('204','LEVNT4','201','LEVNT3') THEN /*ConCobraStatusDate*/ ConDateOfCobraEvent ELSE EepDateOfCobraEvent END
        ,drvEnrollmentDate = BdcBenStartDate
        ,drvSSN = eepSSN
        ,drvNameFirst = EepNameFirst
    INTO dbo.U_EDISCCOBQB_drvTbl_QBEVENT
    FROM dbo.U_EDISCCOBQB_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_EDISCCOBQB_Cobra_Reason WITH (NOLOCK)
        ON BdcEEID = xEEID
        AND BdcCOID = xCOID
    JOIN dbo.U_dsi_BDM_EDISCCOBQB WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRunId = 'Cobra'
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
    WHERE BdmBenStartDate <= EecDateOfTermination 
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EDISCCOBQB_drvTbl_QBPLANINITIAL
    ---------------------------------
    IF OBJECT_ID('U_EDISCCOBQB_drvTbl_QBPLANINITIAL','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCCOBQB_drvTbl_QBPLANINITIAL; -- JCB
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort1 = xEEID --BdmDedCode
        ,drvSort2 = 3 --BdmBenOption
        ,drvSort3 = BdmDedCode
        ,drvSort4 = '01' --'2' + 
        /*CASE WHEN BdmDedCode = 'AAP' THEN '01'
                            WHEN BdmDedCode IN ('HSP') THEN '02'
                            WHEN BdmDedCode IN ('HSPT') THEN '03'
                            WHEN BdmDedCode = 'EYE' THEN '04'
                            WHEN BdmDedCode IN ('HSE') THEN '05'
                            WHEN BdmDedCode IN ('HSTE') THEN '06'
                        END*/
                        -- + '1'
        -- standard fields above and additional driver fields below
        ,drvPlanName = 'Magellan EAP' /*   CASE WHEN BdmDedCode = 'AAP' THEN 'Magellan EAP'
                            WHEN BdmDedCode IN ('HSP','HSPT') THEN 'BCBS TX Dental HSA'
                            WHEN BdmDedCode = 'EYE' THEN 'EyeMed Vision'
                            WHEN BdmDedCode IN ('HSE','HSTE') THEN 'BCBS TX Medical PPO Standard' -- jcb
                            --ELSE 'Ded code is ' + ISNULL(BdmDedCode, 'nope')
                        END */
        ,drvCoverageLevel =    CASE WHEN BdcCobraReason IN ('204', 'LEVNT4') THEN 
                                    CASE EdhPreviousBenOption
                                        WHEN 'EE' THEN 'EE'
                                        WHEN 'EEC' THEN 'EE+CHILD'
                                        WHEN 'EEF' THEN 'EE+FAMILY'
                                        WHEN 'EES' THEN 'EE+SPOUSE'
                                    END
                                WHEN BdcCobraReason = '210' AND dBenOption IS NOT NULL THEN 
                                    CASE dBenOption
                                        WHEN 'EE' THEN 'EE'
                                        WHEN 'EEC' THEN 'EE+CHILD'
                                        WHEN 'EEF' THEN 'EE+FAMILY'
                                        WHEN 'EES' THEN 'EE+SPOUSE'
                                    END
                                WHEN BdmDedCode = 'AAP' OR RTRIM(LTRIM(BdcCobraReason)) IN ('201', 'LEVNT3') THEN 'EE' -- jcb
                                WHEN BdmDedCode IN ('HSP','HSPT', 'EYE', 'HSE','HSTE') THEN 
                                    CASE WHEN BdmBenOption = 'EE' THEN 'EE'
                                        WHEN BdmBenOption = 'EEC' THEN 'EE+CHILD'
                                        WHEN BdmBenOption = 'EEF' THEN 'EE+FAMILY'
                                        WHEN BdmBenOption = 'EES' THEN 'EE+SPOUSE'
                                    END        
                            END
    INTO dbo.U_EDISCCOBQB_drvTbl_QBPLANINITIAL
    FROM dbo.U_EDISCCOBQB_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EDISCCOBQB WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRunId = 'Cobra'
        AND BdmDedCode = 'AAP'
    JOIN dbo.U_EDISCCOBQB_Cobra_Reason WITH (NOLOCK)
        ON BdcEEID = xEEID
        AND BdcCOID = xCOID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    LEFT JOIN (
                SELECT EdhEEID, EdhCOID, EdhDedCode, EdhBenOption AS EdhPreviousBenOption
                FROM (
                        SELECT EHD.EdhEEID, EHD.EdhCOID, EHD.EdhDedCode, EHD.EdhBenOption, ROW_NUMBER() OVER(PARTITION BY EHD.EdhEEID, EHD.EdhCOID, EHD.EdhDedCode, EHD.EdhBenOption ORDER BY EHD.EdhDateTimeCreated) as RN
                        FROM EmpHDed EHD 
                        JOIN (
                                SELECT EdhEEID AS zEEID, EdhCOID AS zCOID, EdhDedCode AS zDedCode, MAX(EdhDateTimeCreated) AS CEvent
                                FROM EmpHDed 
                                WHERE EdhChangeReason IN ('204', 'LEVNT4')
                                GROUP By EdhEEID, EdhCOID, EdhDedCode) as T
                            ON EHD.edhEEID = zEEID
                            AND EHD.EdhCoid = zCOID
                            AND EHD.EdhDedCode = zDedCode
                        WHERE EHD.EdhDateTimeCreated < CEvent) AS X
                WHERE RN = 1) AS DIV_BEN_OPT
        ON EdhEEID = xEEID
        AND EdhCOID = xCOID
    LEFT JOIN (
                SELECT dEEID, dCOID, dDedCode, dBenOption
                FROM (
                        SELECT EdhEEID AS dEEID, EdhCOID AS dCOID, EdhDedCode AS dDedCode, EdhBenOption AS dBenOption, EdhDateTimeCreated as dDateTimeCreated, ROW_NUMBER() OVER (PARTITION BY EdhEEID, EdhCOID, EdhDedCode ORDER BY EdhDateTimeCreated) as dRN
                        FROM EmpHDed A
                        WHERE EdhChangeReason = '200' 
                            AND EdhBenStatus = 'T'
                            AND EdhDedCode IN ('AAP'/*,'HSP','HSPT','EYE','HSE','HSTE'*/) ) AS T
                WHERE dRN = 1
            ) AS DEATH_BEN_OPT
        ON dEEID = xEEID
        AND dCOID = xCOID
    WHERE BdmBenStartDate <= EecDateOfTermination;
    ;    

    /*INSERT INTO dbo.U_EDISCCOBQB_drvTbl_QBPLANINITIAL (drvEEID,drvCOID,drvDepRecID,drvSort1,drvSort2,drvSort3,drvSort4,drvPlanName,drvCoverageLevel)
    SELECT DISTINCT xEEID
        ,xCOID
        ,CONVERT(VARCHAR(12), '1')
        ,xEEID
        ,3
        ,BdmDedCode
        ,--'2' + 
        '11' /*CASE WHEN BdmDedCode = 'AAP' THEN '11' -- JCB
                            WHEN BdmDedCode IN ('HSP') THEN '12'
                            WHEN BdmDedCode IN ('HSPT') THEN '13'
                            WHEN BdmDedCode = 'EYE' THEN '14'
                            WHEN BdmDedCode IN ('HSE') THEN '15'
                            WHEN BdmDedCode IN ('HSTE') THEN '16'
                        END*/
                        -- + '3'
        ,CASE WHEN BdmDedCode IN ('HSP','HSPT') THEN 'BCBS TX Medical HSA'
            WHEN BdmDedCode IN ('HSE','HSTE') THEN  'BCBS TX Dental Standard' -- 'BCBS TX Medical PPO Standard' -- jcb
        END
        ,CASE WHEN BdcCobraReason IN ('204', 'LEVNT4') THEN 
                                CASE EdhPreviousBenOption
                                    WHEN 'EE' THEN 'EE'
                                    WHEN 'EEC' THEN 'EE+CHILD'
                                    WHEN 'EEF' THEN 'EE+FAMILY'
                                    WHEN 'EES' THEN 'EE+SPOUSE'
                                END
                                WHEN BdcCobraReason = '210' AND dBenOption IS NOT NULL THEN 
                                    CASE dBenOption
                                        WHEN 'EE' THEN 'EE'
                                        WHEN 'EEC' THEN 'EE+CHILD'
                                        WHEN 'EEF' THEN 'EE+FAMILY'
                                        WHEN 'EES' THEN 'EE+SPOUSE'
                                    END
                                WHEN BdmDedCode = 'AAP' OR RTRIM(LTRIM(BdcCobraReason)) IN ('201', 'LEVNT3') THEN 'EE' -- jcb
                                WHEN BdmDedCode IN ('HSP','HSPT', 'EYE', 'HSE','HSTE') THEN 
                                    CASE WHEN BdmBenOption = 'EE' THEN 'EE'
                                        WHEN BdmBenOption = 'EEC' THEN 'EE+CHILD'
                                        WHEN BdmBenOption = 'EEF' THEN 'EE+FAMILY'
                                        WHEN BdmBenOption = 'EES' THEN 'EE+SPOUSE'
                                    END        
                            END
        /*CASE WHEN BdmDedCode IN ('HSP','HSPT', 'EYE', 'HSE','HSTE') THEN 
            CASE WHEN BdmBenOption = 'EE' OR RTRIM(LTRIM(BdcCobraReason)) IN ('201', 'LEVNT3') THEN 'EE'
                WHEN BdmBenOption = 'EEC' THEN 'EE+CHILD'
                WHEN BdmBenOption = 'EEF' THEN 'EE+FAMILY'
                WHEN BdmBenOption = 'EES' THEN 'EE+SPOUSE'
            END        
        END*/
    FROM dbo.U_EDISCCOBQB_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EDISCCOBQB WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRunId = 'Cobra'
        AND BdmDedCode = 'AAP'
    JOIN dbo.U_EDISCCOBQB_Cobra_Reason WITH (NOLOCK)
        ON BdcEEID = xEEID
        AND BdcCOID = xCOID
    LEFT JOIN (
                SELECT EdhEEID, EdhCOID, EdhDedCode, EdhBenOption AS EdhPreviousBenOption
                FROM (
                        SELECT EHD.EdhEEID, EHD.EdhCOID, EHD.EdhDedCode, EHD.EdhBenOption, ROW_NUMBER() OVER(PARTITION BY EHD.EdhEEID, EHD.EdhCOID, EHD.EdhDedCode, EHD.EdhBenOption ORDER BY EHD.EdhDateTimeCreated) as RN
                        FROM EmpHDed EHD 
                        JOIN (
                                SELECT EdhEEID AS zEEID, EdhCOID AS zCOID, EdhDedCode AS zDedCode, MAX(EdhDateTimeCreated) AS CEvent
                                FROM EmpHDed 
                                WHERE EdhChangeReason IN ('204', 'LEVNT4')
                                GROUP By EdhEEID, EdhCOID, EdhDedCode) as T
                            ON EHD.edhEEID = zEEID
                            AND EHD.EdhCoid = zCOID
                            AND EHD.EdhDedCode = zDedCode
                        WHERE EHD.EdhDateTimeCreated < CEvent) AS X
                WHERE RN = 1) AS DIV_BEN_OPT
        ON EdhEEID = xEEID
        AND EdhCOID = xCOID
    LEFT JOIN (
                SELECT dEEID, dCOID, dDedCode, dBenOption
                FROM (
                        SELECT EdhEEID AS dEEID, EdhCOID AS dCOID, EdhDedCode AS dDedCode, EdhBenOption AS dBenOption, EdhDateTimeCreated as dDateTimeCreated, ROW_NUMBER() OVER (PARTITION BY EdhEEID, EdhCOID, EdhDedCode ORDER BY EdhDateTimeCreated) as dRN
                        FROM EmpHDed A
                        WHERE EdhChangeReason = '200' 
                            AND EdhBenStatus = 'T'
                            AND EdhDedCode IN ('AAP'/*,'HSP','HSPT','EYE','HSE','HSTE'*/) ) AS T
                WHERE dRN = 1
            ) AS DEATH_BEN_OPT
        ON dEEID = xEEID
        AND dCOID = xCOID
    WHERE BdmDedCode IN ('HSP','HSPT', 'HSE','HSTE')
    ;
    */

    ---------------------------------
    -- DETAIL RECORD - U_EDISCCOBQB_drvTbl_QBPLAN
    ---------------------------------
    IF OBJECT_ID('U_EDISCCOBQB_drvTbl_QBPLAN','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCCOBQB_drvTbl_QBPLAN;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort1 = xEEID --BdmDedCode
        ,drvSort2 = 3 --BdmBenOption
        ,drvSort3 = BdmDedCode
        ,drvSort4 = CASE --WHEN BdmDedCode = 'AAP' THEN '01'
                            WHEN BdmDedCode IN ('HSP') THEN '02'
                            WHEN BdmDedCode IN ('HSPT') THEN '03'
                            WHEN BdmDedCode = 'EYE' THEN '04'
                            WHEN BdmDedCode IN ('HSE') THEN '05'
                            WHEN BdmDedCode IN ('HSTE') THEN '06'
                        END
        -- standard fields above and additional driver fields below
        ,drvPlanName =    CASE --WHEN BdmDedCode = 'AAP' THEN 'Magellan EAP'
                            WHEN BdmDedCode IN ('HSP','HSPT') THEN 'BCBS TX Dental HSA'
                            WHEN BdmDedCode IN ('HSE','HSTE') THEN 'BCBS TX Medical PPO Standard' -- jcb
                        END 
        ,drvStartDate = DATEADD(DAY, 1, BdmBenStopDate)
        ,drvCoverageLevel =    CASE WHEN BdmDedCode IN ('HSP', 'HSPT') THEN
                                    CASE WHEN BdmBenOption IN ('EE') THEN 'EE'
                                        WHEN BdmBenOption IN ('EEC') THEN 'EE+CHILD'
                                        WHEN BdmBenOption IN ('EEF') THEN 'EE+FAMILY'
                                        WHEN BdmBenOption IN ('EES') THEN 'EE+SPOUSE'
                                        ELSE 'EE+CHILDREN'                                
                                    END
                                WHEN BdmDedCode IN ('EYE') THEN
                                    CASE WHEN BdmBenOption IN ('EE') THEN 'EE'
                                        WHEN BdmBenOption IN ('EEC') THEN 'EE+CHILD'
                                        WHEN BdmBenOption IN ('EEF') THEN 'EE+FAMILY'
                                        WHEN BdmBenOption IN ('EES') THEN 'EE+SPOUSE'
                                        ELSE 'EE+CHILDREN'
                                    END
                                WHEN BdmDedCode IN ('HSE', 'HSTE') THEN 
                                    CASE WHEN BdmBenOption IN ('EE') THEN 'EE'
                                        WHEN BdmBenOption IN ('EEC') THEN 'EE+CHILD'
                                        WHEN BdmBenOption IN ('EEF') THEN 'EE+FAMILY'
                                        WHEN BdmBenOption IN ('EES') THEN 'EE+SPOUSE'
                                        ELSE 'EE+CHILDREN'
                                    END
                            END
        ,drvPlanBundleName =    CASE WHEN BdmDedCode IN ('HSP', 'HSPT') THEN 'BCBS TX Medical HSA/Dental/Vision'
                                    WHEN BdmDedCode IN ('HSE', 'HSTE') THEN 'BCBS TX Medical PPO Standard/Dental/Vision'
                                    WHEN BdmDedCode IN ('EYE') THEN 
                                        CASE WHEN (select count(*) from dbo.U_dsi_BDM_EDISCCOBQB where bdmEEID = xEEID AND bdmCOID = xCOID AND BdmDedCode IN ('HSE','HSTE')) > 0 THEN 'BCBS TX Medical PPO Standard/Dental/Vision'
                                            ELSE 'BCBS TX Medical HSA/Dental/Vision'
                                        END
                                END
    INTO dbo.U_EDISCCOBQB_drvTbl_QBPLAN
    FROM dbo.U_EDISCCOBQB_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EDISCCOBQB WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRunId = 'Cobra'
        AND BdmDedCode <> 'AAP'
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    WHERE BdmDedCode IN ('HSP','HSPT', 'HSE','HSTE')
        AND (BdmBenStartDate <= EecDateOfTermination )
    ;




    INSERT INTO dbo.U_EDISCCOBQB_drvTbl_QBPLAN(drvEEID,drvCoID,drvDepRecID,drvSort1,drvSort2,drvSort3,drvSort4,drvPlanName,drvStartDate,drvCoverageLevel,drvPlanBundleName)
    SELECT DISTINCT xEEID
        ,xCOID
        ,CONVERT(VARCHAR(12), '1')
        ,xEEID
        ,3
        ,BdmDedCode
        ,CASE --WHEN BdmDedCode = 'AAP' THEN '01'
                            WHEN BdmDedCode IN ('HSP') THEN '02'
                            WHEN BdmDedCode IN ('HSPT') THEN '03'
                            WHEN BdmDedCode = 'EYE' THEN '04'
                            WHEN BdmDedCode IN ('HSE') THEN '05'
                            WHEN BdmDedCode IN ('HSTE') THEN '06'
                        END
        ,CASE --WHEN BdmDedCode = 'AAP' THEN 'Magellan EAP'
                            WHEN BdmDedCode IN ('HSP','HSPT') THEN 'BCBS TX Medical HSA'
                            WHEN BdmDedCode = 'EYE' THEN 'EyeMed Vision'
                            WHEN BdmDedCode IN ('HSE','HSTE') THEN 'BCBS TX Dental Standard' -- jcb
                        END 
        ,DATEADD(DAY, 1, BdmBenStopDate)
        ,CASE WHEN BdmDedCode IN ('HSP', 'HSPT') THEN
                                    CASE WHEN BdmBenOption IN ('EE') THEN 'EE'
                                        WHEN BdmBenOption IN ('EEC') THEN 'EE+CHILD'
                                        WHEN BdmBenOption IN ('EEF') THEN 'EE+FAMILY'
                                        WHEN BdmBenOption IN ('EES') THEN 'EE+SPOUSE'
                                        ELSE 'EE+CHILDREN'                                
                                    END
                                WHEN BdmDedCode IN ('EYE') THEN
                                    CASE WHEN BdmBenOption IN ('EE') THEN 'EE'
                                        WHEN BdmBenOption IN ('EEC') THEN 'EE+CHILD'
                                        WHEN BdmBenOption IN ('EEF') THEN 'EE+FAMILY'
                                        WHEN BdmBenOption IN ('EES') THEN 'EE+SPOUSE'
                                        ELSE 'EE+CHILDREN'
                                    END
                                WHEN BdmDedCode IN ('HSE', 'HSTE') THEN 
                                    CASE WHEN BdmBenOption IN ('EE') THEN 'EE'
                                        WHEN BdmBenOption IN ('EEC') THEN 'EE+CHILD'
                                        WHEN BdmBenOption IN ('EEF') THEN 'EE+FAMILY'
                                        WHEN BdmBenOption IN ('EES') THEN 'EE+SPOUSE'
                                        ELSE 'EE+CHILDREN'
                                    END
                            END
        ,CASE WHEN BdmDedCode IN ('HSP', 'HSPT') THEN 'BCBS TX Medical HSA/Dental/Vision'
                                    WHEN BdmDedCode IN ('HSE', 'HSTE') THEN 'BCBS TX Medical PPO Standard/Dental/Vision'
                                    WHEN BdmDedCode IN ('EYE') THEN 
                                        CASE WHEN (select count(*) from dbo.U_dsi_BDM_EDISCCOBQB where bdmEEID = xEEID AND bdmCOID = xCOID AND BdmDedCode IN ('HSE','HSTE')) > 0 THEN 'BCBS TX Medical PPO Standard/Dental/Vision'
                                            ELSE 'BCBS TX Medical HSA/Dental/Vision'
                                        END
                                END
    FROM dbo.U_EDISCCOBQB_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EDISCCOBQB WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRunId = 'Cobra'
        AND BdmDedCode <> 'AAP'
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    WHERE BdmBenStartDate <= EecDateOfTermination
    ;








    ---------------------------------
    -- DETAIL RECORD - U_EDISCCOBQB_drvTbl_QBDEPENDENT
    ---------------------------------
    IF OBJECT_ID('U_EDISCCOBQB_drvTbl_QBDEPENDENT','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCCOBQB_drvTbl_QBDEPENDENT; -- JCB
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort1 = xEEID
        ,drvSort2 = 5
        ,drvSort3 = BdmDepRecId
        ,drvSort4 = 0
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvRelationship =    CASE WHEN ConRelationship = 'SPS' THEN 'SPOUSE'
                                WHEN ConRelationship = 'DP' THEN  'DOMESTICPARTNER'
                                WHEN ConRelationship IN ('CHL','DAU','SON','STC') THEN 'CHILD'
                            END
        ,drvNameFirst = ConNameFirst
        ,drvNameMiddleInit = LEFT(ConNameMiddle,1)
        ,drvNameLast = ConNameLast
        ,drvGender = ConGender
        ,drvDateOfBirth = ConDateOfBirth
    INTO dbo.U_EDISCCOBQB_drvTbl_QBDEPENDENT
    FROM dbo.U_EDISCCOBQB_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EDISCCOBQB WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRecType = 'DEP'
        AND BdmRunId = 'Cobra'
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    Where ((ConRelationship IN ('SPS', 'DP') AND BdmCobraReason NOT IN ('204', 'LEVNT4', '210'))  
        OR (ConRelationship IN ('CHL','DAU','SON','STC') AND BdmCobraReason NOT IN ('201', 'LEVNT3'))  )
        AND (BdmBenStartDate <= EecDateOfTermination )
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EDISCCOBQB_drvTbl_QBDEPENDENTPLANINITIAL
    ---------------------------------
    IF OBJECT_ID('U_EDISCCOBQB_drvTbl_QBDEPENDENTPLANINITIAL','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCCOBQB_drvTbl_QBDEPENDENTPLANINITIAL;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort1 = xEEID
        ,drvSort2 = 5
        ,drvSort3 = BdmDepRecId
        ,drvSort4 = ISNULL(ConRelationship, 'nope') + ' ** ' + ISNULL(BdmCobraReason, 'nope') -- 2
        -- standard fields above and additional driver fields below
        ,drvPlanName =    CASE WHEN BdmDedCode = 'AAP' THEN 'Magellan EAP'
                            WHEN BdmDedCode IN ('HSP','HSPT') THEN 'BCBS TX Dental HSA'
                            WHEN BdmDedCode = 'EYE' THEN 'EyeMed Vision'
                            WHEN BdmDedCode IN ('HSE','HSTE') THEN 'BCBS TX Medical PPO Standard'
                        END
    INTO dbo.U_EDISCCOBQB_drvTbl_QBDEPENDENTPLANINITIAL
    FROM dbo.U_EDISCCOBQB_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EDISCCOBQB WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRunId = 'Cobra'
    JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
    WHERE BdmRecType = 'Do not use this table should be empty' 
    --BdmRecType = 'DEP'
     --   AND ((ConRelationship NOT IN ('SPS', 'DP') AND BdmCobraReason NOT IN ('201', 'LEVNT3'))
       --     OR (ConRelationship IN ('SPS', 'DP') AND BdmCobraReason NOT IN ('210', '204', 'LEVNT4')))
    ;
    
    /*INSERT INTO dbo.U_EDISCCOBQB_drvTbl_QBDEPENDENTPLANINITIAL (drvEEID, drvCOID, drvDepRecId, drvSort1, drvSort2, drvSort3, drvSort4, drvPlanName)
    SELECT DISTINCT xEEID
        ,xCOID
        ,CONVERT(varchar(12), '1')
        ,xEEID
        ,5
        ,BdmDepRecId
        ,2
        ,CASE WHEN BdmDedCode IN ('HSP','HSPT') THEN 'BCBS TX Medical HSA'            
            WHEN BdmDedCode IN ('HSE','HSTE') THEN  'BCBS TX Dental Standard' -- 'BCBS TX Medical PPO' -- Standard'
        END 
    FROM dbo.U_EDISCCOBQB_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EDISCCOBQB WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRunId = 'Cobra'
    JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
    WHERE BdmDedCode IN ('HSP','HSPT', 'HSE','HSTE') and BdmRecType = 'DEP'
        AND ((ConRelationship NOT IN ('SPS', 'DP') AND BdmCobraReason NOT IN ('201', 'LEVNT3'))
            OR (ConRelationship IN ('SPS', 'DP') AND BdmCobraReason NOT IN ('210', '204', 'LEVNT4')))*/
   
    ---------------------------------
    -- DETAIL RECORD - U_EDISCCOBQB_drvTbl_QBDEPENDENTPLAN
    ---------------------------------
    IF OBJECT_ID('U_EDISCCOBQB_drvTbl_QBDEPENDENTPLAN','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCCOBQB_drvTbl_QBDEPENDENTPLAN;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort1 = xEEID
        ,drvSort2 = 5
        ,drvSort3 = BdmDepRecId
        ,drvSort4 = 1 --'' --ISNULL(ConRelationship, 'nope') + ' ** ' + ISNULL(BdmCobraReason, 'nope') -- 2
        -- standard fields above and additional driver fields below
        ,drvPlanName =    CASE WHEN BdmDedCode = 'AAP' THEN 'Magellan EAP'
                            WHEN BdmDedCode IN ('HSP','HSPT') THEN 'BCBS TX Dental HSA'
                            WHEN BdmDedCode = 'EYE' THEN 'EyeMed Vision'
                            WHEN BdmDedCode IN ('HSE','HSTE') THEN 'BCBS TX Medical PPO Standard'
                        END
        ,drvStartDate = DATEADD(DAY, 1, BdmBenStopDate)
    INTO dbo.U_EDISCCOBQB_drvTbl_QBDEPENDENTPLAN
    FROM dbo.U_EDISCCOBQB_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EDISCCOBQB WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRunId = 'Cobra'
    JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    WHERE BdmRecType = 'DEP'
        AND ((ConRelationship NOT IN ('SPS', 'DP') AND BdmCobraReason NOT IN ('201', 'LEVNT3'))
           OR (ConRelationship IN ('SPS', 'DP') AND BdmCobraReason NOT IN ('210', '204', 'LEVNT4')))
        AND (BdmBenStartDate <= EecDateOfTermination )
    ;;
    
    
    INSERT INTO dbo.U_EDISCCOBQB_drvTbl_QBDEPENDENTPLAN(drvEEID, drvCoID, drvDepRecID, drvSort1, drvSort2, drvSort3, drvSort4, drvPlanName, drvStartDate)
    SELECT DISTINCT xEEID
        ,xCOID
        ,CONVERT(varchar(12), '1')
        ,xEEID
        ,5
        ,BdmDepRecId
        ,2
        ,CASE WHEN BdmDedCode IN ('HSP','HSPT') THEN 'BCBS TX Medical HSA'            
            WHEN BdmDedCode IN ('HSE','HSTE') THEN  'BCBS TX Dental Standard' -- 'BCBS TX Medical PPO' -- Standard'
        END
        ,DATEADD(DAY, 1, BdmBenStopDate)
    FROM dbo.U_EDISCCOBQB_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EDISCCOBQB WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRunId = 'Cobra'
    JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    WHERE BdmDedCode IN ('HSP','HSPT', 'HSE','HSTE') and BdmRecType = 'DEP'
        AND ((ConRelationship NOT IN ('SPS', 'DP') AND BdmCobraReason NOT IN ('201', 'LEVNT3'))
            OR (ConRelationship IN ('SPS', 'DP') AND BdmCobraReason NOT IN ('210', '204', 'LEVNT4')))
        AND (BdmBenStartDate <= EecDateOfTermination )
    ;


    ---------------------------------
    -- DETAIL RECORD - U_EDISCCOBQB_drvTbl_NPM
    ---------------------------------
    IF OBJECT_ID('U_EDISCCOBQB_drvTbl_NPM','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCCOBQB_drvTbl_NPM;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort1 = 2
        ,drvSort2 = EecEmplStatus -- ''
        ,drvSort3 = ''
        ,drvSort4 = ''
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddleInit = LEFT(EepNameMiddle,1)
        ,drvNameLast = EepNameLast
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvGender = EepGender
    INTO dbo.U_EDISCCOBQB_drvTbl_NPM
    FROM dbo.U_EDISCCOBQB_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EepEEID = EecEEID
    JOIN dbo.U_dsi_BDM_EDISCCOBQB WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRunId <> 'Cobra'
    --WHERE BdmBenStartDate <= EecDateOfTermination
    --WHERE EecDateOfLastHire BETWEEN @StartDate AND @EndDate    
    WHERE BdmBenStartDate BETWEEN @StartDate AND @EndDate    
        --AND EecDateOfLastHire NOT BETWEEN @StartDate and @EndDate 
        --AND EecEmplStatus <> 'A'
    ;

    ---------------------------------
    -- DETAIL RECORD - U_EDISCCOBQB_drvTbl_QBDEPENDENTPLAN
    ---------------------------------
    /*IF OBJECT_ID('U_EDISCCOBQB_drvTbl_QBDEPENDENTPLAN','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCCOBQB_drvTbl_QBDEPENDENTPLAN;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort1 = xEEID
        ,drvSort2 = 5
        ,drvSort3 = BdmDepRecId
        ,drvSort4 = '' --ISNULL(ConRelationship, 'nope') + ' ** ' + ISNULL(BdmCobraReason, 'nope') -- 2
        -- standard fields above and additional driver fields below
        ,drvPlanName =    CASE WHEN BdmDedCode = 'AAP' THEN 'Magellan EAP'
                            WHEN BdmDedCode IN ('HSP','HSPT') THEN 'BCBS TX Dental HSA'
                            WHEN BdmDedCode = 'EYE' THEN 'EyeMed Vision'
                            WHEN BdmDedCode IN ('HSE','HSTE') THEN 'BCBS TX Medical PPO Standard'
                        END
        ,drvStartDate = DATEADD(DAY, 1, BdmBenStartDate)
    INTO dbo.U_EDISCCOBQB_drvTbl_QBDEPENDENTPLAN
    FROM dbo.U_EDISCCOBQB_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EDISCCOBQB WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRunId = 'Cobra'
    JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
    WHERE BdmRecType = 'DEP'
        AND ((ConRelationship NOT IN ('SPS', 'DP') AND BdmCobraReason NOT IN ('201', 'LEVNT3'))
           OR (ConRelationship IN ('SPS', 'DP') AND BdmCobraReason NOT IN ('210', '204', 'LEVNT4')))
    ;*/
    
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EDISCCOBQB_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCCOBQB_Header;
    SELECT DISTINCT
         drvVersion = '1.1'
    INTO dbo.U_EDISCCOBQB_Header
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
ALTER VIEW dbo.dsi_vwEDISCCOBQB_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EDISCCOBQB_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EDISCCOBQB%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202003011'
       ,expStartPerControl     = '200203011'
       ,expLastEndPerControl   = '202007109'
       ,expEndPerControl       = '202007109'
WHERE expFormatCode = 'EDISCCOBQB';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEDISCCOBQB_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EDISCCOBQB_File (NOLOCK)
    ORDER BY InitialSort, SubSort, SubSort2, SubSort3;