SET NOCOUNT ON;
IF OBJECT_ID('U_EDISCCOBRA_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EDISCCOBRA_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EDISCCOBRA_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EDISCCOBRA' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEDISCCOBRA_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEDISCCOBRA_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EDISCCOBRA') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EDISCCOBRA];
GO
IF OBJECT_ID('U_EDISCCOBRA_File') IS NOT NULL DROP TABLE [dbo].[U_EDISCCOBRA_File];
GO
IF OBJECT_ID('U_EDISCCOBRA_EEList') IS NOT NULL DROP TABLE [dbo].[U_EDISCCOBRA_EEList];
GO
IF OBJECT_ID('U_EDISCCOBRA_drvTbl_QBPLAN2') IS NOT NULL DROP TABLE [dbo].[U_EDISCCOBRA_drvTbl_QBPLAN2];
GO
IF OBJECT_ID('U_EDISCCOBRA_drvTbl_QBPLAN') IS NOT NULL DROP TABLE [dbo].[U_EDISCCOBRA_drvTbl_QBPLAN];
GO
IF OBJECT_ID('U_EDISCCOBRA_drvTbl_QBMSRI') IS NOT NULL DROP TABLE [dbo].[U_EDISCCOBRA_drvTbl_QBMSRI];
GO
IF OBJECT_ID('U_EDISCCOBRA_drvTbl_QBEVENT') IS NOT NULL DROP TABLE [dbo].[U_EDISCCOBRA_drvTbl_QBEVENT];
GO
IF OBJECT_ID('U_EDISCCOBRA_drvTbl_QBDEPPLAN') IS NOT NULL DROP TABLE [dbo].[U_EDISCCOBRA_drvTbl_QBDEPPLAN];
GO
IF OBJECT_ID('U_EDISCCOBRA_drvTbl_QBDEP') IS NOT NULL DROP TABLE [dbo].[U_EDISCCOBRA_drvTbl_QBDEP];
GO
IF OBJECT_ID('U_EDISCCOBRA_drvTbl_QB') IS NOT NULL DROP TABLE [dbo].[U_EDISCCOBRA_drvTbl_QB];
GO
IF OBJECT_ID('U_EDISCCOBRA_drvTbl_NPM') IS NOT NULL DROP TABLE [dbo].[U_EDISCCOBRA_drvTbl_NPM];
GO
IF OBJECT_ID('U_EDISCCOBRA_drvSPMPLAN') IS NOT NULL DROP TABLE [dbo].[U_EDISCCOBRA_drvSPMPLAN];
GO
IF OBJECT_ID('U_EDISCCOBRA_drvSPMDEPENDENTPLAN_Temp') IS NOT NULL DROP TABLE [dbo].[U_EDISCCOBRA_drvSPMDEPENDENTPLAN_Temp];
GO
IF OBJECT_ID('U_EDISCCOBRA_drvSPMDEPENDENTPLAN') IS NOT NULL DROP TABLE [dbo].[U_EDISCCOBRA_drvSPMDEPENDENTPLAN];
GO
IF OBJECT_ID('U_EDISCCOBRA_drvSPMDEPENDENT') IS NOT NULL DROP TABLE [dbo].[U_EDISCCOBRA_drvSPMDEPENDENT];
GO
IF OBJECT_ID('U_EDISCCOBRA_drvSPM') IS NOT NULL DROP TABLE [dbo].[U_EDISCCOBRA_drvSPM];
GO
IF OBJECT_ID('U_dsi_BDM_EDISCCOBRA') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EDISCCOBRA];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EDISCCOBRA';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EDISCCOBRA';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EDISCCOBRA';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EDISCCOBRA';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EDISCCOBRA';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EDISCCOBRA','Discovery Benefits Cobra Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','EDISCCOBRAZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EDISCCOBRA' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[VERSION]"','1','(''DA''=''Q,'')','EDISCCOBRAZ0','50','H','01','1',NULL,'Version Line Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"1.2"','2','(''DA''=''Q'')','EDISCCOBRAZ0','50','H','01','2',NULL,'Version Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QB]"','1','(''DA''=''Q,'')','EDISCCOBRAZ0','50','D','10','1',NULL,'Record Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientName"','2','(''UA''=''Q,'')','EDISCCOBRAZ0','100','D','10','2',NULL,'ClientName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientDivName"','3','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','10','3',NULL,'ClientDivisionName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','4','(''SS''=''Q,'')','EDISCCOBRAZ0','50','D','10','4',NULL,'Salutation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','5','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','10','5',NULL,'FirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','6','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','10','6',NULL,'MiddleInitial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','7','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','10','7',NULL,'LastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','8','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','10','8',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpNo"','9','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','10','9',NULL,'IndividualID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''SS''=''Q,'')','EDISCCOBRAZ0','50','D','10','10',NULL,'Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','11','(''SS''=''Q,'')','EDISCCOBRAZ0','50','D','10','11',NULL,'Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','12','(''SS''=''Q,'')','EDISCCOBRAZ0','50','D','10','12',NULL,'Phone2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','13','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','10','13',NULL,'Address1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','14','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','10','14',NULL,'Address2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','15','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','10','15',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','16','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','10','16',NULL,'StateOrProvince',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','17','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','10','17',NULL,'PostalCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''SS''=''Q,'')','EDISCCOBRAZ0','50','D','10','18',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TRUE"','19','(''DA''=''Q,'')','EDISCCOBRAZ0','50','D','10','19',NULL,'PremiumAddressSameAsPrimary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','20','(''SS''=''Q,'')','EDISCCOBRAZ0','50','D','10','20',NULL,'PremiumAddress1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','21','(''SS''=''Q,'')','EDISCCOBRAZ0','50','D','10','21',NULL,'PremiumAddress2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','22','(''SS''=''Q,'')','EDISCCOBRAZ0','50','D','10','22',NULL,'PremiumCity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','23','(''SS''=''Q,'')','EDISCCOBRAZ0','50','D','10','23',NULL,'PremiumStateOrProvince',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','24','(''SS''=''Q,'')','EDISCCOBRAZ0','50','D','10','24',NULL,'PremiumPostalCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','25','(''SS''=''Q,'')','EDISCCOBRAZ0','50','D','10','25',NULL,'PremiumCountry',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','26','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','10','26',NULL,'Sex',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','27','(''UD101''=''Q,'')','EDISCCOBRAZ0','50','D','10','27',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTobacoUse"','28','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','10','28',NULL,'Tobacco Use',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FTE"','29','(''DA''=''Q,'')','EDISCCOBRAZ0','50','D','10','29',NULL,'EmployeeType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpPayrollType"','30','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','10','30',NULL,'EmployeePayrollType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','31','(''SS''=''Q,'')','EDISCCOBRAZ0','50','D','10','31',NULL,'YearsOfService',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"COUPONBOOK"','32','(''DA''=''Q,'')','EDISCCOBRAZ0','50','D','10','32',NULL,'PremiumCouponType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','33','(''DA''=''Q,'')','EDISCCOBRAZ0','50','D','10','33',NULL,'UsesHCTC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TRUE"','34','(''DA''=''Q,'')','EDISCCOBRAZ0','50','D','10','34',NULL,'Active',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FALSE"','35','(''SS''=''Q,'')','EDISCCOBRAZ0','50','D','10','35',NULL,'AllowMemberSSO',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','36','(''SS''=''Q,'')','EDISCCOBRAZ0','50','D','10','36',NULL,'BenefitGroup',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','37','(''SS''=''Q,'')','EDISCCOBRAZ0','50','D','10','37',NULL,'AccountStructure',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','38','(''SS''=''Q'')','EDISCCOBRAZ0','50','D','10','38',NULL,'ClientSpecificData',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBEVENT]"','1','(''DA''=''Q,'')','EDISCCOBRAZ0','50','D','20','1',NULL,'Record Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEventType"','2','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','20','2',NULL,'EventType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEventDate"','3','(''UD101''=''Q,'')','EDISCCOBRAZ0','50','D','20','3',NULL,'EventDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrollmentDate"','4','(''UD101''=''Q,'')','EDISCCOBRAZ0','50','D','20','4',NULL,'EnrollmentDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','5','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','20','5',NULL,'EmployeeSSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvName"','6','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','20','6',NULL,'EmployeeName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','7','(''SS''=''Q'')','EDISCCOBRAZ0','50','D','20','7',NULL,'SecondEventOriginalFDOC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBPLANINITIAL]"','1','(''DA''=''Q,'')','EDISCCOBRAZ0','50','D','30','1',NULL,'Record Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanName"','2','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','30','2',NULL,'PlanName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageLevel"','3','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','30','3',NULL,'CoverageLevel',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','4','(''SS''=''Q'')','EDISCCOBRAZ0','50','D','30','4',NULL,'NumberOfUnits',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBPLAN]"','1','(''DA''=''Q,'')','EDISCCOBRAZ0','50','D','35','1',NULL,'Record Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanName"','2','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','35','2',NULL,'PlanName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStartDate"','3','(''UD101''=''Q,'')','EDISCCOBRAZ0','50','D','35','3',NULL,'Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEndDate"','4','(''UD101''=''Q,'')','EDISCCOBRAZ0','50','D','35','4',NULL,'End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageLevel"','5','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','35','5',NULL,'CoverageLevel',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','6','(''DA''=''Q,'')','EDISCCOBRAZ0','50','D','35','6',NULL,'First Day Of COBRA',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','7','(''DA''=''Q,'')','EDISCCOBRAZ0','50','D','35','7',NULL,'Last Day Of COBRA',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''DA''=''Q,'')','EDISCCOBRAZ0','50','D','35','8',NULL,'Cobra Duration Months',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''DA''=''Q,'')','EDISCCOBRAZ0','50','D','35','9',NULL,'Days to Elect',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''DA''=''Q,'')','EDISCCOBRAZ0','50','D','35','9',NULL,'Days To Make 1st Payment',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','11','(''DA''=''Q,'')','EDISCCOBRAZ0','50','D','35','9',NULL,'Days To Make Subsequent Payments',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','12','(''DA''=''Q,'')','EDISCCOBRAZ0','50','D','35','9',NULL,'Election Postmark Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','13','(''DA''=''Q,'')','EDISCCOBRAZ0','50','D','35','9',NULL,'Last Date Rates Notified',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','14','(''DA''=''Q,'')','EDISCCOBRAZ0','50','D','35','9',NULL,'Number Of Units',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"False"','15','(''DA''=''Q,'')','EDISCCOBRAZ0','50','D','35','9',NULL,'Send Plan Change Letter For Legacy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanBundleName"','16','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','35','9',NULL,'Plan Bundle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBDEPENDENT]"','1','(''DA''=''Q,'')','EDISCCOBRAZ0','50','D','40','1',NULL,'Record Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','2','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','40','2',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelationship"','3','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','40','3',NULL,'Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','4','(''SS''=''Q,'')','EDISCCOBRAZ0','50','D','40','4',NULL,'Salutation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','5','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','40','5',NULL,'FirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','6','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','40','6',NULL,'MiddleInitial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','7','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','40','7',NULL,'LastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''SS''=''Q,'')','EDISCCOBRAZ0','50','D','40','8',NULL,'Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''SS''=''Q,'')','EDISCCOBRAZ0','50','D','40','9',NULL,'Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''SS''=''Q,'')','EDISCCOBRAZ0','50','D','40','10',NULL,'Phone2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIsAddressSame"','11','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','40','11',NULL,'AddressSameAsQB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','12','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','40','12',NULL,'Address1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','13','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','40','13',NULL,'Address2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','14','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','40','14',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','15','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','40','15',NULL,'StateOrProvince',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','16','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','40','16',NULL,'PostalCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','17','(''SS''=''Q,'')','EDISCCOBRAZ0','50','D','40','17',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''SS''=''Q,'')','EDISCCOBRAZ0','50','D','40','18',NULL,'EnrollmentDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','19','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','40','19',NULL,'Sex',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','20','(''UD101''=''Q,'')','EDISCCOBRAZ0','50','D','40','20',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvISQMCO"','21','(''UA''=''Q'')','EDISCCOBRAZ0','50','D','40','21',NULL,'IsQMCSO',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBDEPENDENTPLANINITIAL]"','1','(''DA''=''Q,'')','EDISCCOBRAZ0','50','D','50','1',NULL,'Record Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanName"','2','(''UA''=''Q'')','EDISCCOBRAZ0','50','D','50','2',NULL,'PlanName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBPLANMEMBERSPECIFICRATEINITIAL]"','1','(''DA''=''Q,'')','EDISCCOBRAZ0','50','D','60','1',NULL,'Record Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanName"','2','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','60','2',NULL,'PlanName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRate"','3','(''UA''=''Q'')','EDISCCOBRAZ0','50','D','60','3',NULL,'Rate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[NPM]"','1','(''DA''=''Q,'')','EDISCCOBRAZ0','50','D','70','1',NULL,'Version Line Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','2','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','70','2',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpNo"','3','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','70','3',NULL,'IndividualIdentifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientName"','4','(''UA''=''Q,'')','EDISCCOBRAZ0','100','D','70','4',NULL,'ClientName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientDivName"','5','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','70','5',NULL,'ClientDivisionName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','6','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','70','6',NULL,'FirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','7','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','70','7',NULL,'MiddleInitial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','8','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','70','8',NULL,'LastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''SS''=''Q,'')','EDISCCOBRAZ0','50','D','70','9',NULL,'Salutation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressEMail"','10','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','70','10',NULL,'Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneHomeNumber"','11','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','70','11',NULL,'Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','12','(''SS''=''Q,'')','EDISCCOBRAZ0','50','D','70','12',NULL,'Phone2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','13','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','70','13',NULL,'Address1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','14','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','70','14',NULL,'Address2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','15','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','70','15',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','16','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','70','16',NULL,'StateOrProvince',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','17','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','70','17',NULL,'PostalCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''SS''=''Q,'')','EDISCCOBRAZ0','50','D','70','18',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','19','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','70','19',NULL,'Sex',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','20','(''DA''=''Q,'')','EDISCCOBRAZ0','50','D','70','20',NULL,'UsesFamilyInAddress',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FALSE"','21','(''DA''=''Q,'')','EDISCCOBRAZ0','50','D','70','21',NULL,'HasWaivedAllCoverage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TRUE"','22','(''DA''=''Q,'')','EDISCCOBRAZ0','50','D','70','22',NULL,'SendGRNotice',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHireDate"','23','(''UD101''=''Q'')','EDISCCOBRAZ0','50','D','70','23',NULL,'Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[SPM]"','1','(''DA''=''Q,'')','EDISCCOBRAZ0','50','D','73','1',NULL,'Version Line Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMClientName"','2','(''UA''=''Q,'')','EDISCCOBRAZ0','100','D','73','2',NULL,'Client Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMDivisionName"','3','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','73','3',NULL,'Client Division Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMSalutation"','4','(''UA''=''Q,'')','EDISCCOBRAZ0','35','D','73','4',NULL,'Salutation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMFirstName"','5','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','73','5',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMMiddleName"','6','(''UA''=''Q,'')','EDISCCOBRAZ0','1','D','73','6',NULL,'Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMLastName"','7','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','73','7',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMSSN"','8','(''UA''=''Q,'')','EDISCCOBRAZ0','11','D','73','8',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMIndId"','9','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','73','9',NULL,'Individual ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMEmail"','10','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','73','10',NULL,'Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMPhone"','11','(''UA''=''Q,'')','EDISCCOBRAZ0','10','D','73','11',NULL,'Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMPhone2"','12','(''UA''=''Q,'')','EDISCCOBRAZ0','10','D','73','12',NULL,'Phone 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMAddressLine1"','13','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','73','13',NULL,'Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMAddressLine2"','14','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','73','14',NULL,'Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMCity"','15','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','73','15',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMStateProvince"','16','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','73','16',NULL,'State Or Province',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMPostalCode"','17','(''UA''=''Q,'')','EDISCCOBRAZ0','35','D','73','17',NULL,'Postal Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMCountry"','18','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','73','18',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMSex"','19','(''UA''=''Q,'')','EDISCCOBRAZ0','1','D','73','19',NULL,'Sex',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMDateofBirth"','20','(''UD101''=''Q,'')','EDISCCOBRAZ0','10','D','73','20',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMBillStartDate"','21','(''UD101''=''Q,'')','EDISCCOBRAZ0','10','D','73','21',NULL,'Billing Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMBillEndDate"','22','(''UD101''=''Q,'')','EDISCCOBRAZ0','10','D','73','22',NULL,'Billing End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMBillingType"','23','(''UA''=''Q,'')','EDISCCOBRAZ0','35','D','73','23',NULL,'Billing Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMBillFreq"','24','(''UA''=''Q,'')','EDISCCOBRAZ0','35','D','73','24',NULL,'Billing Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMIsCobraElig"','25','(''UA''=''Q,'')','EDISCCOBRAZ0','5','D','73','25',NULL,'Is COBRA Eligible',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMIsCobraEligAtTerm"','26','(''UA''=''Q,'')','EDISCCOBRAZ0','5','D','73','26',NULL,'Is COBRA Eligible At Termination',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMGracePeriodNrDays"','27','(''UA''=''Q,'')','EDISCCOBRAZ0','12','D','73','27',NULL,'Grace Period Nr Of Days',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMGracePrdOptType"','28','(''UA''=''Q,'')','EDISCCOBRAZ0','45','D','73','28',NULL,'SPM Grace Period Option Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMIsLegacy"','29','(''UA''=''Q,'')','EDISCCOBRAZ0','5','D','73','29',NULL,'Is Legacy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMTobaccoUse"','30','(''UA''=''Q,'')','EDISCCOBRAZ0','35','D','73','30',NULL,'Tobacco Use',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMEnrollmentDate"','31','(''UD101''=''Q,'')','EDISCCOBRAZ0','10','D','73','31',NULL,'Enrollment Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMEmpType"','32','(''UA''=''Q,'')','EDISCCOBRAZ0','35','D','73','32',NULL,'Employee Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMEmpPayType"','33','(''UA''=''Q,'')','EDISCCOBRAZ0','35','D','73','33',NULL,'Employee Payroll Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMYearsService"','34','(''UA''=''Q,'')','EDISCCOBRAZ0','12','D','73','34',NULL,'Years Of Service',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMPremCouponType"','35','(''UA''=''Q,'')','EDISCCOBRAZ0','35','D','73','35',NULL,'Premium Coupon Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMActive"','36','(''UA''=''Q,'')','EDISCCOBRAZ0','5','D','73','36',NULL,'Active',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMAllowSSO"','37','(''UA''=''Q,'')','EDISCCOBRAZ0','5','D','73','37',NULL,'Allow Member SSO',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMBenGroup"','38','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','73','38',NULL,'Benefit Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMAcctStrucure"','39','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','73','39',NULL,'Account Structure',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMClientCustData"','40','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','73','40',NULL,'Client Custom Data',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','41','(''DA''=''Q,'')','EDISCCOBRAZ0','50','D','73','41',NULL,'SSOIdentifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMEventDate"','42','(''UD101''=''Q,'')','EDISCCOBRAZ0','10','D','73','41',NULL,'Event Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMInitGracePeriodDate"','43','(''UD101''=''Q,'')','EDISCCOBRAZ0','10','D','73','42',NULL,'Initial Grace Period Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMBillingPeriodDate"','44','(''UD101''=''Q,'')','EDISCCOBRAZ0','10','D','73','43',NULL,'Billing Period Seed Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPM2ndBillingPeriodDate"','45','(''UD101''=''Q,'')','EDISCCOBRAZ0','10','D','73','44',NULL,'Second Billing Period Seed Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMPlanCategory"','46','(''UA''=''Q'')','EDISCCOBRAZ0','100','D','73','45',NULL,'Plan Category',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[SPMPLAN]"','1','(''DA''=''Q,'')','EDISCCOBRAZ0','50','D','75','1',NULL,'Version Line Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMLPlanName"','2','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','75','2',NULL,'Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMLStartDate"','3','(''UD101''=''Q,'')','EDISCCOBRAZ0','10','D','75','3',NULL,'Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMLEndDate"','4','(''UD101''=''Q,'')','EDISCCOBRAZ0','10','D','75','4',NULL,'End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMLCovLevel"','5','(''UA''=''Q,'')','EDISCCOBRAZ0','35','D','75','5',NULL,'Coverage Level',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMLFirstDay"','6','(''UD101''=''Q,'')','EDISCCOBRAZ0','10','D','75','6',NULL,'First Day Of Coverage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMLLastDay"','7','(''UD101''=''Q,'')','EDISCCOBRAZ0','10','D','75','7',NULL,'Last Day Of Coverage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMLLastDateNotified"','8','(''UD101''=''Q,'')','EDISCCOBRAZ0','10','D','75','8',NULL,'Last Date Rates Notified',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMLSendPlanChange"','9','(''UA''=''Q,'')','EDISCCOBRAZ0','5','D','75','9',NULL,'Send Plan Change Letter For Legacy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMLNumberUnits"','10','(''UA''=''Q,'')','EDISCCOBRAZ0','12','D','75','10',NULL,'Number Of Units',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMLBundleName"','11','(''UA''=''Q'')','EDISCCOBRAZ0','50','D','75','11',NULL,'Bundle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[SPMDEPENDENT]"','1','(''DA''=''Q,'')','EDISCCOBRAZ0','50','D','80','1',NULL,'Version Line Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMDSSN"','2','(''UA''=''Q,'')','EDISCCOBRAZ0','11','D','80','2',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMDRelationShip"','3','(''UA''=''Q,'')','EDISCCOBRAZ0','35','D','80','3',NULL,'Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMDSalutation"','4','(''UA''=''Q,'')','EDISCCOBRAZ0','35','D','80','4',NULL,'Salutation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMDFirstName"','5','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','80','5',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMDMiddleInitial"','6','(''UA''=''Q,'')','EDISCCOBRAZ0','1','D','80','6',NULL,'Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMDLastName"','7','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','80','7',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMDEmail"','8','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','80','8',NULL,'Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMDPhone"','9','(''UA''=''Q,'')','EDISCCOBRAZ0','10','D','80','9',NULL,'Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMDPhone2"','10','(''UA''=''Q,'')','EDISCCOBRAZ0','10','D','80','10',NULL,'Phone 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMDSameasSPM"','11','(''UA''=''Q,'')','EDISCCOBRAZ0','5','D','80','11',NULL,'Address Same As SPM',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMDAddressLine1"','12','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','80','12',NULL,'Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMDAddressLine2"','13','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','80','13',NULL,'Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMDCity"','14','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','80','14',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMDState"','15','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','80','15',NULL,'State Or Province',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMDPostalCode"','16','(''UA''=''Q,'')','EDISCCOBRAZ0','35','D','80','16',NULL,'Postal Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMDCountry"','17','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','80','17',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMDEnrollmentdate"','18','(''UD101''=''Q,'')','EDISCCOBRAZ0','10','D','80','18',NULL,'Enrollment Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMDSex"','19','(''UA''=''Q,'')','EDISCCOBRAZ0','1','D','80','19',NULL,'Sex',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMDDateOfBirth"','20','(''UD101''=''Q,'')','EDISCCOBRAZ0','10','D','80','20',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMDISQMCSO"','21','(''UA''=''Q'')','EDISCCOBRAZ0','5','D','80','21',NULL,'Is QMCSO',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[SPMDEPENDENTPLAN]"','1','(''DA''=''Q,'')','EDISCCOBRAZ0','50','D','85','1',NULL,'Version Line Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMDPPlanName"','2','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','85','2',NULL,'Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMDPStartDate"','3','(''UD101''=''Q,'')','EDISCCOBRAZ0','10','D','85','3',NULL,'Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMEndDate"','4','(''UD101''=''Q,'')','EDISCCOBRAZ0','10','D','85','4',NULL,'End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMFirstDayOfCov"','5','(''UD101''=''Q'')','EDISCCOBRAZ0','5','D','85','5',NULL,'Uses First Day Of Coverage',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EDISCCOBRA_20201222.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'NPM/Cobra Export','202002289','EMPEXPORT','ONDEMAND','Mar  2 2020  4:28PM','EDISCCOBRA',NULL,NULL,NULL,'202002289','Oct 30 2017 12:00AM','Dec 30 1899 12:00AM','202002141','3858','','','202002141',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'Null','N','V5C6H,V5C45',NULL,NULL,NULL,'Discovery COBRA - Fri 8:20a','202011139','EMPEXPORT','SCH_DISC','Nov 19 2020 12:00AM','EDISCCOBRA',NULL,NULL,NULL,'202012119','Nov 13 2020 12:00AM','Dec 30 1899 12:00AM','202012041',NULL,'','','202011061',dbo.fn_GetTimedKey(),NULL,'us3lKiUSO1001A',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,'V5C6H,V5C45',NULL,NULL,NULL,'Discovery COBRA - OLD','202002289','EMPEXPORT','SCHEDULED',NULL,'EDISCCOBRA',NULL,NULL,NULL,'202007109','Jan 13 2016  8:53AM','Jan 13 2016  8:53AM','202007031',NULL,'','','202002141',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','V5C6H,V5C45',NULL,NULL,NULL,'Test NPM/Cobra Export','202012229','EMPEXPORT','TEST','Dec 22 2020  8:54AM','EDISCCOBRA',NULL,NULL,NULL,'202012229','Dec 22 2020 12:00AM','Dec 30 1899 12:00AM','202012181','1','','','202012181',dbo.fn_GetTimedKey(),NULL,'us3lKiUSO1001A',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCCOBRA','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCCOBRA','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCCOBRA','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCCOBRA','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCCOBRA','SubSort2','C','drvSubSort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCCOBRA','SubSort3','C','drvSubSort3');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCCOBRA','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCCOBRA','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EDISCCOBRA' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EDISCCOBRA' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EDISCCOBRA_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EDISCCOBRA_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCCOBRA','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCCOBRA','D10','dbo.U_EDISCCOBRA_drvTbl_QB WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCCOBRA','D20','dbo.U_EDISCCOBRA_drvTbl_QBEVENT WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCCOBRA','D30','dbo.U_EDISCCOBRA_drvTbl_QBPLAN WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCCOBRA','D35','dbo.U_EDISCCOBRA_drvTbl_QBPLAN2 WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCCOBRA','D40','dbo.U_EDISCCOBRA_drvTbl_QBDEP WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCCOBRA','D50','dbo.U_EDISCCOBRA_drvTbl_QBDEPPLAN WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCCOBRA','D60','dbo.U_EDISCCOBRA_drvTbl_QBMSRI WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCCOBRA','D70','dbo.U_EDISCCOBRA_drvTbl_NPM WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCCOBRA','D73','dbo.U_EDISCCOBRA_drvSPM WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCCOBRA','D75','dbo.U_EDISCCOBRA_drvSPMPLAN WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCCOBRA','D80','dbo.U_EDISCCOBRA_drvSPMDEPENDENT WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCCOBRA','D85','dbo.U_EDISCCOBRA_drvSPMDEPENDENTPLAN WITH (NOLOCK)',NULL);
IF OBJECT_ID('U_dsi_BDM_EDISCCOBRA') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EDISCCOBRA] (
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
IF OBJECT_ID('U_EDISCCOBRA_drvSPM') IS NULL
CREATE TABLE [dbo].[U_EDISCCOBRA_drvSPM] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSPMClientName] varchar(58) NOT NULL,
    [drvSPMDivisionName] varchar(9) NOT NULL,
    [drvSPMSalutation] varchar(1) NOT NULL,
    [drvSPMFirstName] varchar(100) NULL,
    [drvSPMMiddleName] varchar(1) NULL,
    [drvSPMLastName] varchar(100) NULL,
    [drvSPMSSN] char(11) NULL,
    [drvSPMIndId] varchar(1) NOT NULL,
    [drvSPMEmail] varchar(1) NOT NULL,
    [drvSPMPhone] varchar(1) NOT NULL,
    [drvSPMPhone2] varchar(1) NOT NULL,
    [drvSPMAddressLine1] varchar(255) NULL,
    [drvSPMAddressLine2] varchar(255) NULL,
    [drvSPMCity] varchar(255) NULL,
    [drvSPMStateProvince] varchar(255) NULL,
    [drvSPMPostalCode] varchar(50) NULL,
    [drvSPMCountry] varchar(1) NOT NULL,
    [drvSPMSex] char(1) NULL,
    [drvSPMDateofBirth] datetime NULL,
    [drvSPMBillStartDate] datetime NULL,
    [drvSPMBillEndDate] datetime NULL,
    [drvSPMBillingType] varchar(14) NULL,
    [drvSPMBillFreq] varchar(7) NOT NULL,
    [drvSPMIsCobraElig] varchar(4) NOT NULL,
    [drvSPMIsCobraEligAtTerm] varchar(4) NOT NULL,
    [drvSPMGracePeriodNrDays] varchar(1) NOT NULL,
    [drvSPMGracePrdOptType] varchar(13) NOT NULL,
    [drvSPMIsLegacy] varchar(5) NOT NULL,
    [drvSPMTobaccoUse] varchar(7) NOT NULL,
    [drvSPMEnrollmentDate] datetime NULL,
    [drvSPMEmpType] varchar(3) NOT NULL,
    [drvSPMEmpPayType] varchar(6) NOT NULL,
    [drvSPMYearsService] varchar(1) NOT NULL,
    [drvSPMPremCouponType] varchar(10) NOT NULL,
    [drvSPMActive] varchar(4) NOT NULL,
    [drvSPMAllowSSO] varchar(5) NOT NULL,
    [drvSPMBenGroup] varchar(1) NOT NULL,
    [drvSPMAcctStrucure] varchar(1) NOT NULL,
    [drvSPMClientCustData] varchar(1) NOT NULL,
    [drvSPMEventDate] datetime NULL,
    [drvSPMInitGracePeriodDate] varchar(1) NOT NULL,
    [drvSPMBillingPeriodDate] varchar(1) NOT NULL,
    [drvSPM2ndBillingPeriodDate] varchar(1) NOT NULL,
    [drvSPMPlanCategory] varchar(1) NOT NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] char(11) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EDISCCOBRA_drvSPMDEPENDENT') IS NULL
CREATE TABLE [dbo].[U_EDISCCOBRA_drvSPMDEPENDENT] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NULL,
    [drvSPMDSSN] char(11) NULL,
    [drvSPMDRelationShip] varchar(15) NULL,
    [drvSPMDSalutation] varchar(1) NOT NULL,
    [drvSPMDFirstName] varchar(100) NULL,
    [drvSPMDMiddleInitial] varchar(1) NULL,
    [drvSPMDLastName] varchar(100) NULL,
    [drvSPMDEmail] varchar(1) NOT NULL,
    [drvSPMDPhone] varchar(1) NOT NULL,
    [drvSPMDPhone2] varchar(1) NOT NULL,
    [drvSPMDSameasSPM] varchar(4) NOT NULL,
    [drvSPMDAddressLine1] varchar(255) NULL,
    [drvSPMDAddressLine2] varchar(255) NULL,
    [drvSPMDCity] varchar(255) NULL,
    [drvSPMDState] varchar(255) NULL,
    [drvSPMDPostalCode] varchar(50) NULL,
    [drvSPMDCountry] varchar(1) NOT NULL,
    [drvSPMDEnrollmentdate] varchar(1) NOT NULL,
    [drvSPMDSex] char(1) NULL,
    [drvSPMDDateOfBirth] datetime NULL,
    [drvSPMDISQMCSO] varchar(5) NOT NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] char(11) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(208) NULL
);
IF OBJECT_ID('U_EDISCCOBRA_drvSPMDEPENDENTPLAN') IS NULL
CREATE TABLE [dbo].[U_EDISCCOBRA_drvSPMDEPENDENTPLAN] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(1) NOT NULL,
    [drvSPMDPPlanName] varchar(50) NULL,
    [drvSPMDPStartDate] datetime NULL,
    [drvSPMEndDate] datetime NULL,
    [drvSPMFirstDayOfCov] varchar(5) NOT NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] char(11) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EDISCCOBRA_drvSPMDEPENDENTPLAN_Temp') IS NULL
CREATE TABLE [dbo].[U_EDISCCOBRA_drvSPMDEPENDENTPLAN_Temp] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvSPMDPPlanName] varchar(50) NULL,
    [drvSPMDPStartDate] datetime NULL,
    [drvSPMEndDate] datetime NULL,
    [drvSPMFirstDayOfCov] varchar(4) NOT NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] char(11) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EDISCCOBRA_drvSPMPLAN') IS NULL
CREATE TABLE [dbo].[U_EDISCCOBRA_drvSPMPLAN] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NULL,
    [drvSPMLPlanName] varchar(50) NULL,
    [drvSPMLStartDate] datetime NULL,
    [drvSPMLEndDate] varchar(1) NOT NULL,
    [drvSPMLCovLevel] varchar(9) NULL,
    [drvSPMLFirstDay] varchar(1) NOT NULL,
    [drvSPMLLastDay] varchar(1) NOT NULL,
    [drvSPMLLastDateNotified] varchar(1) NOT NULL,
    [drvSPMLSendPlanChange] varchar(5) NOT NULL,
    [drvSPMLNumberUnits] varchar(1) NOT NULL,
    [drvSPMLBundleName] varchar(29) NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] char(11) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EDISCCOBRA_drvTbl_NPM') IS NULL
CREATE TABLE [dbo].[U_EDISCCOBRA_drvTbl_NPM] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvSSN] char(11) NULL,
    [drvEmpNo] char(9) NULL,
    [drvClientName] varchar(100) NULL,
    [drvClientDivName] varchar(9) NOT NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvAddressEMail] varchar(1) NOT NULL,
    [drvPhoneHomeNumber] varchar(1) NOT NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvGender] char(1) NULL,
    [drvHireDate] varchar(1) NOT NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] char(11) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EDISCCOBRA_drvTbl_QB') IS NULL
CREATE TABLE [dbo].[U_EDISCCOBRA_drvTbl_QB] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NOT NULL,
    [drvClientName] varchar(100) NULL,
    [drvClientDivName] varchar(9) NOT NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvSSN] char(11) NULL,
    [drvEmpNo] char(9) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvGender] char(1) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvTobacoUse] varchar(7) NOT NULL,
    [drvEmpPayrollType] varchar(6) NOT NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(208) NULL
);
IF OBJECT_ID('U_EDISCCOBRA_drvTbl_QBDEP') IS NULL
CREATE TABLE [dbo].[U_EDISCCOBRA_drvTbl_QBDEP] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NULL,
    [drvSSN] char(11) NOT NULL,
    [drvRelationship] varchar(15) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvIsAddressSame] varchar(4) NOT NULL,
    [drvAddressLine1] varchar(1) NOT NULL,
    [drvAddressLine2] varchar(1) NOT NULL,
    [drvAddressCity] varchar(1) NOT NULL,
    [drvAddressState] varchar(1) NOT NULL,
    [drvAddressZipCode] varchar(1) NOT NULL,
    [drvGender] char(1) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvISQMCO] varchar(5) NOT NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(33) NULL,
    [drvSubSort3] varchar(208) NULL
);
IF OBJECT_ID('U_EDISCCOBRA_drvTbl_QBDEPPLAN') IS NULL
CREATE TABLE [dbo].[U_EDISCCOBRA_drvTbl_QBDEPPLAN] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NULL,
    [drvDedCode] char(5) NULL,
    [drvPlanName] varchar(50) NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(38) NULL,
    [drvSubSort3] varchar(208) NULL
);
IF OBJECT_ID('U_EDISCCOBRA_drvTbl_QBEVENT') IS NULL
CREATE TABLE [dbo].[U_EDISCCOBRA_drvTbl_QBEVENT] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NOT NULL,
    [drvEventType] varchar(29) NOT NULL,
    [drvEventDate] datetime NULL,
    [drvEnrollmentDate] datetime NULL,
    [drvSSN] char(11) NULL,
    [drvName] varchar(100) NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(208) NULL
);
IF OBJECT_ID('U_EDISCCOBRA_drvTbl_QBMSRI') IS NULL
CREATE TABLE [dbo].[U_EDISCCOBRA_drvTbl_QBMSRI] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NOT NULL,
    [drvPlanName] varchar(50) NULL,
    [drvRate] money NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(208) NULL
);
IF OBJECT_ID('U_EDISCCOBRA_drvTbl_QBPLAN') IS NULL
CREATE TABLE [dbo].[U_EDISCCOBRA_drvTbl_QBPLAN] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NOT NULL,
    [drvDedCode] char(5) NULL,
    [drvPlanName] varchar(50) NULL,
    [drvCoverageLevel] varchar(9) NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(6) NULL,
    [drvSubSort3] varchar(208) NULL
);
IF OBJECT_ID('U_EDISCCOBRA_drvTbl_QBPLAN2') IS NULL
CREATE TABLE [dbo].[U_EDISCCOBRA_drvTbl_QBPLAN2] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NOT NULL,
    [drvDedCode] char(5) NULL,
    [drvPlanName] varchar(50) NULL,
    [drvStartDate] datetime NULL,
    [drvEndDate] int NULL,
    [drvCoverageLevel] varchar(11) NULL,
    [drvPlanBundleName] varchar(50) NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(6) NULL,
    [drvSubSort3] varchar(208) NULL
);
IF OBJECT_ID('U_EDISCCOBRA_EEList') IS NULL
CREATE TABLE [dbo].[U_EDISCCOBRA_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EDISCCOBRA_File') IS NULL
CREATE TABLE [dbo].[U_EDISCCOBRA_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EDISCCOBRA]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: US Olympic Committee

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 02/27/2020
Service Request Number: TekP-2019-11-19-0001

Purpose: Discovery Benefits Cobra Export - Combined NPM/QB

Revision History
----------------
Update By            Date           Request Num        Desc
XXXX                 XX/XX/xxxx     SR-20XX-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EDISCCOBRA';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EDISCCOBRA';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EDISCCOBRA';
SELECT * FROM dbo.AscExp WHERE expFormatCode = 'EDISCCOBRA';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EDISCCOBRA' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISCCOBRA', 'SCHEDULED';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISCCOBRA', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISCCOBRA', 'TEST';


EXEC dbo.dsi_BDM_sp_ErrorCheck 'EDISCCOBRA';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EDISCCOBRA', @AllObjects = 'Y', @IsWeb = 'Y'

**********************************************************************************/
BEGIN
    --==========================================
    -- Declare variables
    --==========================================
    DECLARE  @FormatCode varchar(10)
            ,@ExportCode varchar(10)
            ,@StartDate  datetime
            ,@EndDate    datetime;

    -- Initialize @FormatCode
    SET @FormatCode = 'EDISCCOBRA';

    -- Declare dates from Parameter file
    SELECT
         @ExportCode = ExportCode
        ,@StartDate  = LEFT(StartPerControl,8)
        ,@EndDate    = DATEADD(SS,-1,DATEADD(DD,1,LEFT(EndPerControl,8)))
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List
    --==========================================
    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EDISCCOBRA_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCoID(xEEID)
      AND xEEID IN (SELECT xEEID FROM dbo.U_EDISCCOBRA_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- BDM Section for NPM
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'TermSelectionOption','AuditDate');

    -- NPM parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RunID','NPM');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','Y'); -- DedIsCobraCovered = 'Y'
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'NewEnrolleeType','2'); -- All new enrollees where no previous plan exists
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'TableType','EMP'); -- Only include employees on NPM file

    -- Run BDM for NPM
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- BDM Section for QB
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'TermSelectionOption','AuditDate');

    -- COBRA parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RunID','QB');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'AddToPreviousRun','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','Y'); -- DedIsCobraCovered = 'Y'
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraType','4'); -- Eep/ConCobraReason first, then EdhChangeReason. Include CHGRP for elig. ben groups
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraDate','3'); -- EedBenStopDate and DbnBenStopDate, unless Eep/ConDateOfCOBRAEvent exists
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraPQBType','1'); -- If no EE or spouse, ALL children are PQB (not just oldest)
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraReasonsDepPQB','201,204,210,LEVNT3,LEVNT4'); -- Valid dependent PQB reasons
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidCobraReasonsEmp','201,204,210,LEVNT3,LEVNT4'); -- Invalidate employee when Cobra Reason is a dependent PQB reason
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidTermReasonsEmp','203'); -- Invalidate employee when Cobra Reason is "Death"
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'ConCobraReasonPCF','DependentCOBRAReason'); -- Valid dependent PQB reasons
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CountDependents','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL,DPC,STC,DCH');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');

    -- Run BDM for QB
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;


    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'TermSelectionOption','AuditDate');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'DedCodes','EAHIM');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RunID','SPM');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'AddToPreviousRun','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL,DPC,STC,DCH');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');

    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    Delete from dbo.U_dsi_BDM_EDISCCOBRA where bdmRunID  = 'SPM' and bdmbenstatusdate < @StartDate 


    --==========================================
    -- Build driver tables
    --==========================================
    ------------------
    -- DETAIL RECORD - NPM Record
    ------------------
    IF OBJECT_ID('U_EDISCCOBRA_drvTbl_NPM') IS NOT NULL
        DROP TABLE dbo.U_EDISCCOBRA_drvTbl_NPM;
    SELECT DISTINCT
         drvEEID            = BdmEEID
        ,drvCoID            = BdmCoID
        ,drvSSN             = eepSSN
        ,drvEmpNo           = EecEmpNo
        ,drvClientName      = CONVERT(varchar(100),'United States Olympic & Paralympic Committee (USOPC) 35566')
        ,drvClientDivName   = CASE WHEN eeccoid in ('EAHI') and eecorglvl1  = 'PARA' THEN 'EAHI PARA' 
                                  WHEN eeccoid in ('EAHI') and eecorglvl1  <> 'PARA' THEN 'EAHI'
                                  ELSE 'USOPC'
                             END
        ,drvNameFirst       = EepNameFirst
        ,drvNameMiddle      = LEFT(EepNameMiddle,1)
        ,drvNameLast        = EepNameLast
        ,drvAddressEMail    = ''
        ,drvPhoneHomeNumber = ''
        ,drvAddressLine1    = EepAddressLine1
        ,drvAddressLine2    = EepAddressLine2
        ,drvAddressCity     = EepAddressCity
        ,drvAddressState    = EepAddressState
        ,drvAddressZipCode  = EepAddressZipCode
        ,drvGender          = EepGender
        ,drvHireDate        = ''
        ,drvInitialSort     = '22'
        ,drvSubSort         = eepSSN
        ,drvSubSort2        = ''
        ,drvSubSort3        = ''
    INTO dbo.U_EDISCCOBRA_drvTbl_NPM
    FROM dbo.U_dsi_BDM_EDISCCOBRA WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = BdmEEID
       AND EecCoID = BdmCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = BdmEEID
    WHERE BdmRunID = 'NPM'
    and bdmcoid in ('V5C45') ;

    ------------------
    -- QB DETAIL RECORD
    ------------------
    IF OBJECT_ID('U_EDISCCOBRA_drvTbl_QB') IS NOT NULL
        DROP TABLE dbo.U_EDISCCOBRA_drvTbl_QB;
    SELECT DISTINCT
         drvEEID           = BdmEEID
        ,drvCoID           = BdmCoID
        ,drvDepRecID       = ISNULL(BdmDepRecID,'')
        ,drvClientName     = CONVERT(varchar(100),'United States Olympic & Paralympic Committee (USOPC) 35566 ')
        ,drvClientDivName  = CASE WHEN eeccoid in ('EAHI') and eecorglvl1  = 'PARA' THEN 'EAHI PARA' 
                                  WHEN eeccoid in ('EAHI') and eecorglvl1  <> 'PARA' THEN 'EAHI'
                                  ELSE 'USOPC'
                             END
        ,drvNameFirst      = CASE WHEN BdmRecType = 'EMP' THEN EepNameFirst
                                  ELSE ConNameFirst
                             END
        ,drvNameMiddle     = CASE WHEN BdmRecType = 'EMP' THEN LEFT(EepNameMiddle,1)
                                  ELSE LEFT(ConNameMiddle,1)
                             END
        ,drvNameLast       = CASE WHEN BdmRecType = 'EMP' THEN EepNameLast
                                  ELSE ConNameLast
                             END
        ,drvSSN            = CASE WHEN BdmRecType = 'EMP' THEN eepSSN
                                  ELSE ISNULL(ConSSN,'')
                             END
        ,drvEmpNo          = EecEmpNo
        ,drvAddressLine1   = CASE WHEN BdmRecType = 'EMP' THEN EepAddressLine1
                                  WHEN ConAddressLine1 IS NULL THEN EepAddressLine1
                                  ELSE ConAddressLine1
                             END
        ,drvAddressLine2   = CASE WHEN BdmRecType = 'EMP' THEN EepAddressLine2
                                  WHEN ConAddressLine1 IS NULL THEN EepAddressLine2
                                  ELSE ConAddressLine2
                             END
        ,drvAddressCity    = CASE WHEN BdmRecType = 'EMP' THEN EepAddressCity
                                  WHEN ConAddressLine1 IS NULL THEN EepAddressCity
                                  ELSE ConAddressCity
                             END
        ,drvAddressState   = CASE WHEN BdmRecType = 'EMP' THEN EepAddressState
                                  WHEN ConAddressLine1 IS NULL THEN EepAddressState
                                  ELSE ConAddressState
                             END
        ,drvAddressZipCode = CASE WHEN BdmRecType = 'EMP' THEN EepAddressZipCode
                                  WHEN ConAddressLine1 IS NULL THEN EepAddressZipCode
                                  ELSE ConAddressZipCode
                             END
        ,drvGender         = CASE WHEN BdmRecType = 'EMP' THEN EepGender
                                  ELSE ConGender
                             END
        ,drvDateOfBirth    = CASE WHEN BdmRecType = 'EMP' THEN EepDateOfBirth
                                  ELSE ConDateOfBirth
                             END
        ,drvTobacoUse       = CASE WHEN EepIsSmoker = 'Y' THEN 'YES' 
                                   WHEN EepIsSmoker = 'N' THEN 'NO'
                                  ELSE 'UNKNOWN'
                              END 
        ,drvEmpPayrollType =  CASE WHEN EecSalaryOrHourly = 'S' THEN 'SALARY' ELSE 'HOURLY' END
        ,drvInitialSort    = '21'
        ,drvSubSort        = CASE WHEN BdmRecType = 'EMP' THEN eepSSN
                                  ELSE ISNULL(NULLIF(ConSSN,''),eepSSN) + CONVERT(char(8),ConDateOfBirth,112)
                             END
        ,drvSubSort2       = '1'
        ,drvSubSort3       = CASE WHEN BdmRecType = 'EMP' THEN '2'
                                  ELSE CONVERT(char(8),ConDateOfBirth,112) + RTRIM(ConNameLast) + ConNameFirst
                             END
    INTO dbo.U_EDISCCOBRA_drvTbl_QB
    FROM dbo.U_dsi_BDM_EDISCCOBRA WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = BdmEEID
       AND EecCoID = BdmCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = BdmEEID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = BdmEEID
       AND ConSystemID = BdmDepRecID
    WHERE BdmRunID = 'QB'
      AND BdmIsPQB = 'Y'
      and bdmcoid in ('V5C45') ;

    ------------------
    -- QBEVENT DETAIL RECORD
    ------------------
    IF OBJECT_ID('U_EDISCCOBRA_drvTbl_QBEVENT') IS NOT NULL
        DROP TABLE dbo.U_EDISCCOBRA_drvTbl_QBEVENT;
    SELECT DISTINCT
         drvEEID           = drvEEID
        ,drvCoID           = drvCoID
        ,drvDepRecID       = drvDepRecID
        ,drvEventType      = CASE WHEN EecTermReason = '202' THEN 'RETIREMENT'
                                  WHEN EecTermReason = '203' THEN 'DEATH'
                                  WHEN BdmCobraReason IN ('201','LEVNT3') THEN 'INELIGIBLEDEPENDENT'
                                  WHEN BdmCobraReason IN ('204','LEVNT4') THEN 'DIVORCELEGALSEPARATION'
                                  WHEN BdmCobraReason = '210' THEN 'DEATH'
                                  WHEN BdmCobraReason IN ('202','CHGRP') THEN 'LOSSOFELIGIBILITY'
                                  WHEN BdmCobraReason IN ('203','202') THEN 'REDUCTIONINHOURSSTATUSCHANGE '
                                  WHEN BdmCobraReason = '205' THEN 'MEDICARE'
                                  WHEN BdmCobraReason = '206' THEN 'REDUCTIONINHOURSENDOFLEAVE'
                                  WHEN BdmCobraReason = '207' THEN 'USERRA-REDUCTIONINHOURS'
                                  WHEN BdmCobraReason = '208' THEN 'RETIREMENT'
                                  WHEN BdmCobraReason = '209' THEN 'WORKSTOPPAGE'
                                  WHEN EecEmplStatus = 'T' and eectermtype  = 'I' THEN 'INVOLUNTARYTERMINATION'
                                  ELSE 'TERMINATION'
                             END
        ,drvEventDate      = CASE WHEN BdmCobraReason in ('204','201','LEVNT3','LEVNT4') THEN  BdmDateOfCOBRAEvent ELSE BdmDateOfCOBRAEvent END
        ,drvEnrollmentDate = BdmBenStartDate
        ,drvSSN            = eepSSN
        ,drvName           = CASE WHEN BdmRecType = 'DEP' THEN RTRIM(EepNameFirst)
                                  ELSE ''
                             END
        ,drvInitialSort    = '21'
        ,drvSubSort        = drvSubSort
        ,drvSubSort2       = '1'
        ,drvSubSort3       = drvSubSort3
    INTO dbo.U_EDISCCOBRA_drvTbl_QBEVENT
    FROM dbo.U_EDISCCOBRA_drvTbl_QB WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = drvEEID
       AND EecCoID = drvCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = drvEEID
    JOIN (SELECT
             BdmEEID
            ,BdmCoID
            ,BdmDepRecID
            ,BdmRecType
            ,BdmCobraReason = MAX(BdmCobraReason)
            ,BdmBenStartDate = MIN(BdmBenStartDate)
            ,BdmDateOfCOBRAEvent = MAX(BdmDateOfCOBRAEvent)
            ,BdmUSGDate1 = MAX(BdmUSGDate1)
          FROM dbo.U_dsi_BDM_EDISCCOBRA WITH (NOLOCK)
          WHERE BdmRunID = 'QB'
            AND BdmIsPQB = 'Y'
          GROUP BY BdmEEID, BdmCoID, BdmDepRecID, BdmRecType) BDM
        ON BdmEEID = drvEEID
       AND BdmCoID = drvCoID
       AND ISNULL(BdmDepRecID,'') = drvDepRecID
       and bdmcoid in ('V5C45') ;

    ------------------
    -- QBPLAN DETAIL RECORD
    ------------------
    IF OBJECT_ID('U_EDISCCOBRA_drvTbl_QBPLAN2') IS NOT NULL
        DROP TABLE dbo.U_EDISCCOBRA_drvTbl_QBPLAN2;
    SELECT DISTINCT
         drvEEID          = drvEEID
        ,drvCoID          = drvCoID
        ,drvDepRecID      = drvDepRecID
        ,drvDedCode       = BdmDedCode
        ,drvPlanName      = CONVERT(varchar(50),(CASE WHEN BdmDedCode in ('EAP')    THEN 'ComPsych EAP' 
                                 WHEN BdmDedCode in ('FSAL', 'FSALW', 'FSA', 'FSAW', 'HFSA')    THEN 'DBI FSA' 
                                 WHEN BdmDedCode in ('DEN')    THEN 'United Concordia Dental Flex' 
                                 WHEN BdmDedCode in ('VIS', 'VIS1')    THEN 'VSP Vision' 
                                 WHEN BdmDedCode in ('MDSW', 'MDSB')    THEN 'Highmark Medical Stars PPO' 
                                 WHEN BdmDedCode in ('MDHDW', 'MDHD')    THEN 'Highmark Medical Stripes HDHP' 
                            END))
        ,drvStartDate =  DateAdd(Day,1,bdmbenstopdate)
        ,drvEndDate = null

        ,drvCoverageLevel =  CASE  WHEN BdmDedCode in ('MDSW', 'MDSB', 'MDHDW' ,'MDHD')    THEN 
                                        CASE WHEN BdmBenOption in ('EE','EEW') THEN 'EE'
                                             WHEN BdmBenOption in ('EEC'  ,'EECW') THEN 'EE+CHILD'
                                             WHEN BdmBenOption in ('EECH'  ,'EECHW') THEN 'EE+CHILDREN'
                                             WHEN BdmBenOption in ('EEF', 'EEFW', 'EEDPF', 'EDPFW') THEN 'EE+FAMILY'
                                             
                                             WHEN BdmBenOption in ('EEDP', 'EDPW', 'EES', 'EESW') THEN 'EE+SPOUSE'
                                        END
                             END
        ,drvPlanBundleName = CONVERT(varchar(50),(CASE 
                                 WHEN BdmDedCode in ('MDSW', 'MDSB')    THEN 'Highmark Medical Stars PPO/ESI Rx' 
                                 WHEN BdmDedCode in ('MDHDW', 'MDHD')    THEN 'Highmark Medical Stripes HDHP/ESI Rx' 
                            END))
        ,drvInitialSort   = '21'
        ,drvSubSort       = drvSubSort
        ,drvSubSort2      = '1' + BdmDedCode
        ,drvSubSort3      = drvSubSort3
    INTO dbo.U_EDISCCOBRA_drvTbl_QBPLAN2
    FROM dbo.U_EDISCCOBRA_drvTbl_QBEVENT WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EDISCCOBRA WITH (NOLOCK)
        ON BdmEEID = drvEEID
       AND BdmCoID = drvCoID
       AND ISNULL(BdmDepRecID,'') = drvDepRecID
    LEFT JOIN (
        Select * from [dbo].[fn_MP_CustomFields_EmpPers_Export](null,null,null,null)
    ) A 
    on A.eeid =  drvEEID
    WHERE BdmRunID = 'QB'
      AND BdmIsPQB = 'Y' and bdmcoid in ('V5C45') 
      and BdmDedCode in ('MDSW', 'MDSB', 'MDHDW' ,'MDHD');



    --Section to add for RX
    INSERT INTO U_EDISCCOBRA_drvTbl_QBPLAN2
    SELECT DISTINCT
             drvEEID         
            ,drvCoID         
            ,drvDepRecID      
            ,drvDedCode       
            ,drvPlanName  = CASE WHEN drvPlanName in ('Highmark Medical Stripes HDHP') THEN 'Express Scripts Inc Stripes HDHP Rx'
                                 WHEN drvPlanName in ('Highmark Medical Stars PPO') THEN 'Express Scripts Inc Stars PPO Rx'
                            END 
            ,drvStartDate
            ,drvEndDate
            ,drvCoverageLevel 
            ,drvPlanBundleName
            ,drvInitialSort  
            ,drvSubSort       
            ,drvSubSort2      
            ,drvSubSort3
    FROM dbo.U_EDISCCOBRA_drvTbl_QBPLAN2
            WHERE drvPlanName in ('Highmark Medical Stars PPO','Highmark Medical Stripes HDHP')


     ------------------
    -- QBPLANINITIAL DETAIL RECORD
    ------------------
    IF OBJECT_ID('U_EDISCCOBRA_drvTbl_QBPLAN') IS NOT NULL
        DROP TABLE dbo.U_EDISCCOBRA_drvTbl_QBPLAN;
    SELECT DISTINCT
         drvEEID          = drvEEID
        ,drvCoID          = drvCoID
        ,drvDepRecID      = drvDepRecID
        ,drvDedCode       = BdmDedCode
        ,drvPlanName      = CONVERT(varchar(50),(CASE WHEN BdmDedCode in ('EAP')    THEN 'ComPsych EAP' 
                                 WHEN BdmDedCode in ('FSAL', 'FSALW', 'FSA', 'FSAW', 'HFSA')    THEN 'DBI FSA' 
                                 WHEN BdmDedCode in ('DEN')    THEN 'United Concordia Dental Flex' 
                                 WHEN BdmDedCode in ('VIS', 'VIS1')    THEN 'VSP Vision' 
                                 WHEN BdmDedCode in ('MDSW', 'MDSB')    THEN 'Highmark Medical Stars PPO' 
                                 WHEN BdmDedCode in ('MDHDW', 'MDHD')    THEN 'Highmark Medical Stripes HDHP' 
                            END))
        ,drvCoverageLevel = CASE WHEN BdmDedType in( 'FSA','OT1','EAP') THEN 'EE'
                                 WHEN BdmRecType = 'EMP' THEN
                                      CASE WHEN BdmBenOption IN ('ATH','EE','EEW') THEN 'EE'
                                           WHEN BdmDedCode in ('DEN','VIS','VIS1') and BdmBenOption in ('EEC', 'EES','EEDP') THEN 'EE+1'
                                           WHEN BdmDedCode in ('DEN') and BdmBenOption in ('EECH', 'EEF' , 'EEDPF') THEN 'EE+2'
                                           WHEN BdmBenOption IN ('ATHC','EEC','EECW') THEN 'EE+CHILD'
                                           WHEN BdmBenOption IN ('ATHS','EEDP', 'EDPW', 'EES', 'EESW') THEN 'EE+SPOUSE'
                                           --WHEN BdmBenOption IN ('@EDPBenOpts') THEN 'EE+DOMESTICPARTNER'
                                           WHEN BdmBenOption IN ('ATHF','EECH','EEF','EEDPF','EECHW', 'EEFW', 'EDPFW') THEN 'EE+FAMILY'
                                      END
                                 WHEN BdmRelationship IN ('SPS','DP') THEN
                                      CASE WHEN ISNULL(BdmNumChildren,0) = 1 THEN 'EE+1'
                                           WHEN ISNULL(BdmNumChildren,0) > 1 THEN 'EE+2'
                                           ELSE 'EE'
                                      END
                                 ELSE 'EE'
                            END
        ,drvInitialSort   = '21'
        ,drvSubSort       = drvSubSort
        ,drvSubSort2      = '1' + BdmDedCode
        ,drvSubSort3      = drvSubSort3
    INTO dbo.U_EDISCCOBRA_drvTbl_QBPLAN
    FROM dbo.U_EDISCCOBRA_drvTbl_QBEVENT WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EDISCCOBRA WITH (NOLOCK)
        ON BdmEEID = drvEEID
       AND BdmCoID = drvCoID
       AND ISNULL(BdmDepRecID,'') = drvDepRecID
    LEFT JOIN (
        Select * from [dbo].[fn_MP_CustomFields_EmpPers_Export](null,null,null,null)
    ) A 
    on A.eeid =  drvEEID
    WHERE BdmRunID = 'QB'
      AND BdmIsPQB = 'Y' and bdmcoid in ('V5C45') and bdmdedcode in ('EAP', 'FSAL', 'FSALW', 'FSA', 'FSAW', 'HFSA', 'DEN', 'VIS' ,'VIS1');
    ------------------
    -- QBDEPENDENT DETAIL RECORD
    ------------------
    IF OBJECT_ID('U_EDISCCOBRA_drvTbl_QBDEP') IS NOT NULL
        DROP TABLE dbo.U_EDISCCOBRA_drvTbl_QBDEP;
    SELECT DISTINCT
         drvEEID           = BdmEEID
        ,drvCoID           = BdmCoID
        ,drvDepRecID       = BdmDepRecID
        ,drvSSN            = ISNULL(ConSSN,'')
        ,drvRelationship   = CASE WHEN BdmRelationship IN ('SPS') THEN 'SPOUSE'
                                  WHEN BdmRelationship IN ('DP') THEN 'DOMESTICPARTNER'
                                  WHEN BdmRelationship IN ('CHL','DCH','DPC','STC') THEN 'CHILD'
                             END
        ,drvNameFirst      = ConNameFirst
        ,drvNameMiddle     = LEFT(ConNameMiddle,1)
        ,drvNameLast       = ConNameLast
        ,drvIsAddressSame  = 'True'
        ,drvAddressLine1   = ''
        ,drvAddressLine2   = ''
        ,drvAddressCity    = ''
        ,drvAddressState   = ''
        ,drvAddressZipCode = ''
        ,drvGender         = ConGender
        ,drvDateOfBirth    = ConDateOfBirth
        ,drvISQMCO         = 'False'
        ,drvInitialSort    = '21'
        ,drvSubSort        = drvSubSort
        ,drvSubSort2       = '2' + CASE WHEN BdmRelationship IN ('SPS','DP') THEN 'A'
                                        ELSE 'B' + ISNULL(ConSSN,ConNameFirst)
                                   END + CONVERT(char(8),ISNULL(ConDateOfBirth,''),112) + ConSystemID
        ,drvSubSort3       = drvSubSort3
    INTO dbo.U_EDISCCOBRA_drvTbl_QBDEP
    FROM dbo.U_EDISCCOBRA_drvTbl_QB WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EDISCCOBRA WITH (NOLOCK)
        ON BdmEEID = drvEEID
       AND BdmCoID = drvCoID
    JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = BdmEEID
       AND ConSystemID = BdmDepRecID
    WHERE BdmRunID = 'QB'
      AND BdmIsPQB = 'N'
      AND bdmcoid in ('V5C45');

    ------------------
    -- QBDEPENDENTPLANINITIAL DETAIL RECORD
    ------------------
    IF OBJECT_ID('U_EDISCCOBRA_drvTbl_QBDEPPLAN') IS NOT NULL
        DROP TABLE dbo.U_EDISCCOBRA_drvTbl_QBDEPPLAN;
    SELECT DISTINCT
         drvEEID        = BdmEEID
        ,drvCoID        = BdmCoID
        ,drvDepRecID    = BdmDepRecID
        ,drvDedCode     = BdmDedCode
        ,drvPlanName    = CONVERT(varchar(50),(CASE WHEN BdmDedCode in ('EAP')    THEN 'ComPsych EAP' 
                                 WHEN BdmDedCode in ('FSAL', 'FSALW', 'FSA', 'FSAW', 'HFSA')    THEN 'DBI FSA' 
                                 WHEN BdmDedCode in ('DEN')    THEN 'United Concordia Dental Flex' 
                                 WHEN BdmDedCode in ('VIS', 'VIS1')    THEN 'VSP Vision' 
                                 WHEN BdmDedCode in ('MDSW', 'MDSB')    THEN 'Highmark Medical Stars PPO' 
                                 WHEN BdmDedCode in ('MDHDW', 'MDHD')    THEN 'Highmark Medical Stripes HDHP' 
                            END))
        ,drvInitialSort = '21'
        ,drvSubSort     = drvSubSort
        ,drvSubSort2    = '2' + CASE WHEN BdmRelationship IN ('SPS','DP') THEN 'A'
                                     ELSE 'B' + RTRIM(ISNULL(ConSSN,ConNameFirst))
                                END + CONVERT(char(8),ISNULL(ConDateOfBirth,''),112) + ConSystemID + BdmDedCode
        ,drvSubSort3    = drvSubSort3
    INTO dbo.U_EDISCCOBRA_drvTbl_QBDEPPLAN
    FROM dbo.U_EDISCCOBRA_drvTbl_QBPLAN WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EDISCCOBRA WITH (NOLOCK)
        ON BdmEEID = drvEEID
       AND BdmCoID = drvCoID
       AND BdmDedCode = drvDedCode
    JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = BdmEEID
       AND ConSystemID = BdmDepRecID
    LEFT JOIN (
        Select * from [dbo].[fn_MP_CustomFields_EmpPers_Export](null,null,null,null)
    ) A 
    on A.eeid =  drvEEID
    WHERE BdmRunID = 'QB'
      AND BdmIsPQB = 'N'
      AND bdmcoid in ('V5C45')
      ;


   --Section to add for RX
    INSERT INTO U_EDISCCOBRA_drvTbl_QBDEPPLAN
    SELECT DISTINCT
         drvEEID       
        ,drvCoID       
        ,drvDepRecID    
        ,drvDedCode     
        ,drvPlanName    =  CASE WHEN drvPlanName in ('Highmark Medical Stripes HDHP') THEN 'Express Scripts Inc Stripes HDHP Rx'
                                 WHEN drvPlanName in ('Highmark Medical Stars PPO') THEN 'Express Scripts Inc Stars PPO Rx'
                            END 
        ,drvInitialSort 
        ,drvSubSort     
        ,drvSubSort2   
        ,drvSubSort3   
        FROM U_EDISCCOBRA_drvTbl_QBDEPPLAN
        WHERE drvPlanName in ('Highmark Medical Stars PPO','Highmark Medical Stripes HDHP')

    ------------------
    -- QBPLANMEMBERSPECIFICRATEINITIAL DETAIL RECORD
    ------------------
    IF OBJECT_ID('U_EDISCCOBRA_drvTbl_QBMSRI') IS NOT NULL
        DROP TABLE dbo.U_EDISCCOBRA_drvTbl_QBMSRI;
    SELECT DISTINCT
         drvEEID        = drvEEID
        ,drvCoID        = drvCoID
        ,drvDepRecID    = drvDepRecID
        ,drvPlanName    =  CONVERT(varchar(50),(CASE WHEN BdmDedCode in ('EAP')    THEN 'ComPsych EAP' 
                                 WHEN BdmDedCode in ('FSAL', 'FSALW', 'FSA', 'FSAW', 'HFSA')    THEN 'DBI FSA' 
                                 WHEN BdmDedCode in ('DEN')    THEN 'United Concordia Dental Flex' 
                                 WHEN BdmDedCode in ('VIS', 'VIS1')    THEN 'VSP Vision' 
                                 WHEN BdmDedCode in ('MDSW', 'MDSB')    THEN 'Highmark Medical Stars PPO' 
                                 WHEN BdmDedCode in ('MDHDW', 'MDHD')    THEN 'Highmark Medical Stripes HDHP' 
                            END))
        ,drvRate        = CASE WHEN BDmDedcode in ('FSAL','FSALW','FSA','FSAW','HFSA ') THEN BdmEEAmt END
        ,drvInitialSort = '21'
        ,drvSubSort     = drvSubSort
        ,drvSubSort2    = '3'
        ,drvSubSort3    = drvSubSort3
    INTO dbo.U_EDISCCOBRA_drvTbl_QBMSRI
    FROM dbo.U_EDISCCOBRA_drvTbl_QBPLAN WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EDISCCOBRA WITH (NOLOCK)
        ON BdmEEID = drvEEID
       AND BdmCoID = drvCoID
       AND ISNULL(BdmDepRecID,'') = drvDepRecID
       AND BdmDedCode = drvDedCode
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = BdmEEID
       AND EecCoID = BdmCoID
    LEFT JOIN (
        Select * from [dbo].[fn_MP_CustomFields_EmpPers_Export](null,null,null,null)
    ) A 
    on A.eeid =  drvEEID
    WHERE BdmRunID = 'QB'
      AND BdmIsPQB = 'Y'
      AND BdmDedType = 'FSA';

 ---------------------------------
    -- DETAIL RECORD - U_EDISCCOBRA_drvSPM
    --[SPM]
    ---------------------------------
    IF OBJECT_ID('U_EDISCCOBRA_drvSPM','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCCOBRA_drvSPM;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvSPMClientName = 'United States Olympic & Paralympic Committee (USOPC) 35566'
        ,drvSPMDivisionName =  CASE WHEN eeccoid in ('V5C6H') and Employee_AthleteType  = 'PARA' THEN 'EAHI PARA' 
                                  ELSE 'EAHI'
                             END
        ,drvSPMSalutation = ''
        ,drvSPMFirstName = EepNameFirst
        ,drvSPMMiddleName = LEFT(EepNameMiddle,1)
        ,drvSPMLastName = EepNameLast
        ,drvSPMSSN = eepSSN
        ,drvSPMIndId = ''
        ,drvSPMEmail = ''
        ,drvSPMPhone = ''
        ,drvSPMPhone2 = ''
        ,drvSPMAddressLine1 = EepAddressLine1
        ,drvSPMAddressLine2 = EepAddressLine2
        ,drvSPMCity = EepAddressCity
        ,drvSPMStateProvince = EepAddressState
        ,drvSPMPostalCode = EepAddressZipCode
        ,drvSPMCountry = ''
        ,drvSPMSex = EepGender
        ,drvSPMDateofBirth = EepDateOfBirth
        ,drvSPMBillStartDate = CASE WHEN EecEmplStatus  = 'L' THEN DateAdd(Day,1,EecEmplStatusStartDate ) ELSE  DateAdd(Day,1,bdmBenStopDate )  END
        ,drvSPMBillEndDate = CASE WHEN EecEmplStatus  = 'L' THEN (select Max(EshStatusStopDate) from EmpHStat where esheeid = xeeid) END
        ,drvSPMBillingType = CASE WHEN EecEmplStatus = 'L' THEN 'LEAVEOFABSENCE' 
                                  WHEN EecEmplStatus = 'T' THEN 'PREMIUMPAY' 
                                END
        ,drvSPMBillFreq = 'MONTHLY'
        ,drvSPMIsCobraElig = 'True'
        ,drvSPMIsCobraEligAtTerm = 'True'
        ,drvSPMGracePeriodNrDays = ''
        ,drvSPMGracePrdOptType = 'CLIENTDEFAULT'
        ,drvSPMIsLegacy = 'FALSE'
        ,drvSPMTobaccoUse = 'UNKNOWN'
        ,drvSPMEnrollmentDate = (select Min(BdmBenStartDate) from U_dsi_BDM_EDISCCOBRA where bdmRunId = 'SPM' and bdmeeid = xeeid and bdmcoid = xcoid)
        ,drvSPMEmpType = 'FTE'
        ,drvSPMEmpPayType = CASE WHEN EecSalaryOrHourly  = 'S' THEN 'SALARY' ELSE 'HOURLY' END
        ,drvSPMYearsService = ''
        ,drvSPMPremCouponType = 'COUPONBOOK'
        ,drvSPMActive = 'True'
        ,drvSPMAllowSSO = 'False'
        ,drvSPMBenGroup = ''
        ,drvSPMAcctStrucure = ''
        ,drvSPMClientCustData = ''
        ,drvSPMEventDate = CASE WHEN EecEmplStatus  = 'L' THEN DateAdd(Day,1,EecEmplStatusStartDate ) 
                                WHEN EecEmplStatus  = 'T' THEN DateAdd(Day,1,eecdateoftermination )
                                END
        ,drvSPMInitGracePeriodDate = ''
        ,drvSPMBillingPeriodDate = ''
        ,drvSPM2ndBillingPeriodDate = ''
        ,drvSPMPlanCategory = ''
        ,drvInitialSort     = '23'
        ,drvSubSort         = eepSSN
        ,drvSubSort2        = '1'
        ,drvSubSort3        = ''
    INTO dbo.U_EDISCCOBRA_drvSPM
    FROM dbo.U_EDISCCOBRA_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
       And eecemplstatus IN( 'L','T')
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
         LEFT JOIN  (
            Select * from [dbo].[fn_MP_CustomFields_EmpPers_Export](null,null,null,null)
    ) A 
     on A.eeid =  xeeid
    JOIN dbo.U_dsi_BDM_EDISCCOBRA WITH (NOLOCK)
        ON bdmEEID = xEEID 
        AND BdmCOID = xCoID
     WHERE  BdmRunID = 'SPM'
     AND BdmCOID in ('V5C6H')
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EDISCCOBRA_drvSPMPLAN
    --[SPMPLAN]
    ---------------------------------
    IF OBJECT_ID('U_EDISCCOBRA_drvSPMPLAN','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCCOBRA_drvSPMPLAN;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = bdmdeprecid --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvSPMLPlanName = CONVERT(VARCHAR(50),CASE WHEN BdmDedCode in ('EAHIM') and Employee_AthleteType not in ('PARA')  THEN  'Direct Bill Highmark Medical EAHI'
                                WHEN BdmDedCode in ('EAHIM') and Employee_AthleteType in ('PARA') THEN  'Direct Bill Highmark Medical EAHI PARA'
                                    END)
                            
        ,drvSPMLStartDate = CASE WHEN eecEmplStatus = 'L' THEN DateAdd(Day,1,EecEmplStatusStartDate) 
                                 WHEN eecEmplStatus = 'T' THEN DateAdd(Day,1,BdmBenStopDate) 
                            END
        ,drvSPMLEndDate = ''
        ,drvSPMLCovLevel = CASE WHEN BdmDedType = 'FSA' THEN 'EE'
                                 WHEN BdmBenOption IN ('ATH') THEN 'EE'
                                           WHEN BdmBenOption IN ('ATHC') THEN 'EE+CHILD'
                                           WHEN BdmBenOption IN ('ATHS') THEN 'EE+SPOUSE'
                                           WHEN BdmBenOption IN ('ATHF') THEN 'EE+FAMILY'
                            END
                        
        ,drvSPMLFirstDay = ''
        ,drvSPMLLastDay = ''
        ,drvSPMLLastDateNotified = ''
        ,drvSPMLSendPlanChange = 'False'
        ,drvSPMLNumberUnits = ''
        ,drvSPMLBundleName = CASE WHEN BdmDedCode in ('EAHIM') and BdmCoid in ('V5C6H') THEN
                                    CASE WHEN BdmBenOption in ('ATH','ATHC','ATHF','ATHS') and Employee_AthleteType not in ('PARA')  THEN  'Highmark EAHI Med/ESI Rx'
                                         WHEN BdmBenOption in ('ATH','ATHC','ATHF','ATHS') and Employee_AthleteType in ('PARA') THEN  'Highmark EAHI PARA Med/ESI Rx'
                                    END
                            END
        ,drvInitialSort     = '23'
        ,drvSubSort         = eepSSN
        ,drvSubSort2        = '2'
        ,drvSubSort3        = ''
    INTO dbo.U_EDISCCOBRA_drvSPMPLAN
    FROM dbo.U_EDISCCOBRA_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
           And eecemplstatus IN( 'L','T')
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN  (
            Select * from [dbo].[fn_MP_CustomFields_EmpPers_Export](null,null,null,null)
    ) A 
    on A.eeid =  xeeid
    JOIN dbo.U_dsi_BDM_EDISCCOBRA WITH (NOLOCK)
        ON bdmEEID = xEEID 
        AND BdmCOID = xCoID
     WHERE  BdmRunID = 'SPM'
          AND BdmCOID in ('V5C6H')
         and bdmrectype = 'EMP'
    ;

    --Duplicate record for RX
    INSERT INTO U_EDISCCOBRA_drvSPMPLAN
    SELECT DISTINCT
         drvEEID 
        ,drvCoID
        ,drvDepRecID 
        -- standard fields above and additional driver fields below
        ,drvSPMLPlanName  = CASE WHEN drvSPMLPlanName IN ('Direct Bill Highmark Medical EAHI') THEN 'Direct Bill ESI EAHI Continuance Rx'
                                 WHEN drvSPMLPlanName IN ('Direct Bill Highmark Medical EAHI PARA') THEN 'Direct Bill ESI EAHI PARA Continuance Rx'
                            END
        ,drvSPMLStartDate 
        ,drvSPMLEndDate 
        ,drvSPMLCovLevel 
                
        ,drvSPMLFirstDay 
        ,drvSPMLLastDay 
        ,drvSPMLLastDateNotified
        ,drvSPMLSendPlanChange 
        ,drvSPMLNumberUnits 
        ,drvSPMLBundleName 
        ,drvInitialSort     
        ,drvSubSort         
        ,drvSubSort2       
        ,drvSubSort3     
    FROM dbo.U_EDISCCOBRA_drvSPMPLAN
    WHERE drvSPMLPlanName IN ('Direct Bill Highmark Medical EAHI','Direct Bill Highmark Medical EAHI PARA')

    ---------------------------------
    -- DETAIL RECORD - U_EDISCCOBRA_drvSPMDEPENDENT
    ---------------------------------
    IF OBJECT_ID('U_EDISCCOBRA_drvSPMDEPENDENT','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCCOBRA_drvSPMDEPENDENT;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = BdmDepRecID --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvSPMDSSN = conssn
        ,drvSPMDRelationShip = CASE WHEN conrelationship  IN ('CHL', 'DCH', 'DPC' , 'STC' ) THEN 'CHILD'
                                   WHEN conrelationship  IN ('SPS' ) THEN 'SPOUSE'
                                WHEN conrelationship  IN ('DP' ) THEN 'DOMESTICPARTNER'
                               END
        ,drvSPMDSalutation = ''
        ,drvSPMDFirstName = ConNameFirst
        ,drvSPMDMiddleInitial = LEFT(ISNULL(ConNameMiddle,''),1)
        ,drvSPMDLastName = ConNameLast
        ,drvSPMDEmail = ''
        ,drvSPMDPhone = ''
        ,drvSPMDPhone2 = ''
        ,drvSPMDSameasSPM = 'True'
        ,drvSPMDAddressLine1 = EepAddressLine1
        ,drvSPMDAddressLine2 = EepAddressLine2
        ,drvSPMDCity = EepAddressCity
        ,drvSPMDState = EepAddressState
        ,drvSPMDPostalCode = EepAddressZipCode
        ,drvSPMDCountry = ''
        ,drvSPMDEnrollmentdate = ''
        ,drvSPMDSex = congender
        ,drvSPMDDateOfBirth = ConDateOfBirth
        ,drvSPMDISQMCSO = 'False'
        ,drvInitialSort     = '23'
        ,drvSubSort        = eepSSN
        ,drvSubSort2       = '3'
        ,drvSubSort3       = CASE WHEN BdmRecType = 'EMP' THEN '2'
                                  ELSE CONVERT(char(8),ConDateOfBirth,112) + RTRIM(ConNameLast) + ConNameFirst
                            END
    INTO dbo.U_EDISCCOBRA_drvSPMDEPENDENT
    FROM dbo.U_EDISCCOBRA_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
           And eecemplstatus IN( 'L','T')

    JOIN dbo.U_dsi_BDM_EDISCCOBRA WITH (NOLOCK)
        ON bdmEEID = xEEID 
        AND BdmCOID = xCoID
        JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = bdmEEID
       AND ConSystemID = BdmDepRecID
     WHERE  BdmRunID = 'SPM' 
    AND BdmCOID in ('V5C6H')
    ;


    ---------------------------------
    -- DETAIL RECORD - U_EDISCCOBRA_drvSPMDEPENDENTPLAN
    ---------------------------------
    IF OBJECT_ID('U_EDISCCOBRA_drvSPMDEPENDENTPLAN','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCCOBRA_drvSPMDEPENDENTPLAN;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = ''
        -- standard fields above and additional driver fields below
        ,drvSPMDPPlanName = CONVERT(VARCHAR(50),CASE WHEN BdmDedCode in ('EAHIM') THEN  'Direct Bill Highmark Medical EAHI'
                                WHEN BdmDedCode in ('EAHIM') and Employee_AthleteType in ('PARA') THEN  'Direct Bill Highmark Medical EAHI PARA'
                                    END)
        ,drvSPMDPStartDate = BdmBenStartDate
        ,drvSPMEndDate = BdmBenStopDate
        ,drvSPMFirstDayOfCov = CASE WHEN BdmBenStartDate = (Select top 1 BdmBenStartDate from U_dsi_BDM_EDISCCOBRA where bdmeeid  = xeeid and bdmcoid = xcoid and bdmrectype = 'EMP') THEN 'TRUE' ELSE 'FALSE' END
        ,drvInitialSort     = '23'
        ,drvSubSort         = eepSSN
        ,drvSubSort2        = '4'
        ,drvSubSort3        = ''
    INTO dbo.U_EDISCCOBRA_drvSPMDEPENDENTPLAN
    FROM dbo.U_EDISCCOBRA_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
          And eecemplstatus IN( 'L','T')
LEFT JOIN  (
            Select * from [dbo].[fn_MP_CustomFields_EmpPers_Export](null,null,null,null)
    ) A on A.eeid =  xeeid

    JOIN (Select bdmdedcode,Max(BdmBenStartDate) as BdmBenStartDate , Max(BdmBenStopDate) as BdmBenStopDate,bdmeeid,bdmcoid from  dbo.U_dsi_BDM_EDISCCOBRA WITH (NOLOCK)      WHERE  BdmRunID = 'SPM' 
          AND BdmCOID in ('V5C6H')
        and bdmrectype = 'DEP' Group by  bdmdedcode,bdmeeid,bdmcoid ) bdmConsolidated
        ON bdmEEID = xEEID 
        AND BdmCOID = xCoID



    ;

    --Add new record for RX
        INSERT INTO U_EDISCCOBRA_drvSPMDEPENDENTPLAN
 SELECT DISTINCT
         drvEEID 
        ,drvCoID 
        ,drvDepRecID
        -- standard fields above and additional driver fields below
        ,drvSPMDPPlanName  = CASE WHEN drvSPMDPPlanName in ('Direct Bill Highmark Medical EAHI PARA') THEN 'Direct Bill ESI EAHI PARA Continuance Rx'
                                  WHEN drvSPMDPPlanName in ('Direct Bill Highmark Medical EAHI') THEN 'Direct Bill ESI EAHI Continuance Rx'
                            END 
        ,drvSPMDPStartDate
        ,drvSPMEndDate 
        ,drvSPMFirstDayOfCov 
        ,drvInitialSort     
        ,drvSubSort      
        ,drvSubSort2       
        ,drvSubSort3        

    FROM U_EDISCCOBRA_drvSPMDEPENDENTPLAN 
    WHERE drvSPMDPPlanName IN ('Direct Bill Highmark Medical EAHI','Direct Bill Highmark Medical EAHI PARA')


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
/*
--Alter the View
ALTER VIEW dbo.dsi_vwEDISCCOBRA_Export AS
    SELECT TOP 2000000 Data
    FROM dbo.U_EDISCCOBRA_File WITH (NOLOCK)
    ORDER BY InitialSort, SubSort, SubSort2, SubSort3, RecordSet;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EDISCCOBRA%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
SET expLastStartPerControl = '201601251'
   ,expStartPerControl     = '201601251'
   ,expLastEndPerControl   = '201602039'
   ,expEndPerControl       = '201602039'
WHERE expFormatCode = 'EDISCCOBRA'
  AND expExportCode LIKE 'TEST%';
*/
SET NOCOUNT OFF;
GO
CREATE VIEW dbo.dsi_vwEDISCCOBRA_Export AS
    SELECT TOP 2000000 Data
    FROM dbo.U_EDISCCOBRA_File WITH (NOLOCK)
    ORDER BY InitialSort, SubSort, SubSort2, SubSort3, RecordSet;