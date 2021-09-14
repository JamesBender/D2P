SET NOCOUNT ON;
IF OBJECT_ID('U_EDISPCRCOB_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EDISPCRCOB_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EDISPCRCOB_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EDISPCRCOB' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEDISPCRCOB_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEDISPCRCOB_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EDISPCRCOB') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EDISPCRCOB];
GO
IF OBJECT_ID('U_EDISPCRCOB_File') IS NOT NULL DROP TABLE [dbo].[U_EDISPCRCOB_File];
GO
IF OBJECT_ID('U_EDISPCRCOB_EEList') IS NOT NULL DROP TABLE [dbo].[U_EDISPCRCOB_EEList];
GO
IF OBJECT_ID('U_EDISPCRCOB_drvTbl_QBSTATEINSERT') IS NOT NULL DROP TABLE [dbo].[U_EDISPCRCOB_drvTbl_QBSTATEINSERT];
GO
IF OBJECT_ID('U_EDISPCRCOB_drvTbl_QBPLAN') IS NOT NULL DROP TABLE [dbo].[U_EDISPCRCOB_drvTbl_QBPLAN];
GO
IF OBJECT_ID('U_EDISPCRCOB_drvTbl_QBMSRI') IS NOT NULL DROP TABLE [dbo].[U_EDISPCRCOB_drvTbl_QBMSRI];
GO
IF OBJECT_ID('U_EDISPCRCOB_drvTbl_QBEVENT') IS NOT NULL DROP TABLE [dbo].[U_EDISPCRCOB_drvTbl_QBEVENT];
GO
IF OBJECT_ID('U_EDISPCRCOB_drvTbl_QBDEPPLAN') IS NOT NULL DROP TABLE [dbo].[U_EDISPCRCOB_drvTbl_QBDEPPLAN];
GO
IF OBJECT_ID('U_EDISPCRCOB_drvTbl_QBDEP') IS NOT NULL DROP TABLE [dbo].[U_EDISPCRCOB_drvTbl_QBDEP];
GO
IF OBJECT_ID('U_EDISPCRCOB_drvTbl_QB') IS NOT NULL DROP TABLE [dbo].[U_EDISPCRCOB_drvTbl_QB];
GO
IF OBJECT_ID('U_EDISPCRCOB_drvTbl_NPM') IS NOT NULL DROP TABLE [dbo].[U_EDISPCRCOB_drvTbl_NPM];
GO
IF OBJECT_ID('U_EDISPCRCOB_DepCount') IS NOT NULL DROP TABLE [dbo].[U_EDISPCRCOB_DepCount];
GO
IF OBJECT_ID('U_dsi_BDM_EDISPCRCOB') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EDISPCRCOB];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EDISPCRCOB';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EDISPCRCOB';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EDISPCRCOB';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EDISPCRCOB';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EDISPCRCOB';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EDISPCRCOB','PCRK Holding Company COBRA Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','EDISPCRCOBZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EDISPCRCOB' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[VERSION]"','1','(''DA''=''Q,'')','EDISPCRCOBZ0','50','H','01','1',NULL,'Version Line Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"1.1"','2','(''DA''=''Q'')','EDISPCRCOBZ0','50','H','01','2',NULL,'Version Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QB]"','1','(''DA''=''Q,'')','EDISPCRCOBZ0','50','D','10','1',NULL,'Record Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientName"','2','(''UA''=''Q,'')','EDISPCRCOBZ0','50','D','10','2',NULL,'ClientName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientDivName"','3','(''UA''=''Q,'')','EDISPCRCOBZ0','50','D','10','3',NULL,'ClientDivisionName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','4','(''SS''=''Q,'')','EDISPCRCOBZ0','50','D','10','4',NULL,'Salutation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','5','(''UA''=''Q,'')','EDISPCRCOBZ0','50','D','10','5',NULL,'FirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','6','(''UA''=''Q,'')','EDISPCRCOBZ0','50','D','10','6',NULL,'MiddleInitial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','7','(''UA''=''Q,'')','EDISPCRCOBZ0','50','D','10','7',NULL,'LastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','8','(''UA''=''Q,'')','EDISPCRCOBZ0','50','D','10','8',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpNo"','9','(''UA''=''Q,'')','EDISPCRCOBZ0','50','D','10','9',NULL,'IndividualID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''SS''=''Q,'')','EDISPCRCOBZ0','50','D','10','10',NULL,'Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','11','(''SS''=''Q,'')','EDISPCRCOBZ0','50','D','10','11',NULL,'Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','12','(''SS''=''Q,'')','EDISPCRCOBZ0','50','D','10','12',NULL,'Phone2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','13','(''UA''=''Q,'')','EDISPCRCOBZ0','50','D','10','13',NULL,'Address1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','14','(''UA''=''Q,'')','EDISPCRCOBZ0','50','D','10','14',NULL,'Address2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','15','(''UA''=''Q,'')','EDISPCRCOBZ0','50','D','10','15',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','16','(''UA''=''Q,'')','EDISPCRCOBZ0','50','D','10','16',NULL,'StateOrProvince',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','17','(''UA''=''Q,'')','EDISPCRCOBZ0','50','D','10','17',NULL,'PostalCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''SS''=''Q,'')','EDISPCRCOBZ0','50','D','10','18',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TRUE"','19','(''DA''=''Q,'')','EDISPCRCOBZ0','50','D','10','19',NULL,'PremiumAddressSameAsPrimary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','20','(''SS''=''Q,'')','EDISPCRCOBZ0','50','D','10','20',NULL,'PremiumAddress1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','21','(''SS''=''Q,'')','EDISPCRCOBZ0','50','D','10','21',NULL,'PremiumAddress2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','22','(''SS''=''Q,'')','EDISPCRCOBZ0','50','D','10','22',NULL,'PremiumCity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','23','(''SS''=''Q,'')','EDISPCRCOBZ0','50','D','10','23',NULL,'PremiumStateOrProvince',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','24','(''SS''=''Q,'')','EDISPCRCOBZ0','50','D','10','24',NULL,'PremiumPostalCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','25','(''SS''=''Q,'')','EDISPCRCOBZ0','50','D','10','25',NULL,'PremiumCountry',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','26','(''UA''=''Q,'')','EDISPCRCOBZ0','50','D','10','26',NULL,'Sex',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','27','(''UD101''=''Q,'')','EDISPCRCOBZ0','50','D','10','27',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"UNKNOWN"','28','(''DA''=''Q,'')','EDISPCRCOBZ0','50','D','10','28',NULL,'TobaccoUse',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"UNKNOWN"','29','(''DA''=''Q,'')','EDISPCRCOBZ0','50','D','10','29',NULL,'EmployeeType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"UNKNOWN"','30','(''DA''=''Q,'')','EDISPCRCOBZ0','50','D','10','30',NULL,'EmployeePayrollType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','31','(''SS''=''Q,'')','EDISPCRCOBZ0','50','D','10','31',NULL,'YearsOfService',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"COUPONBOOK"','32','(''DA''=''Q,'')','EDISPCRCOBZ0','50','D','10','32',NULL,'PremiumCouponType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FALSE"','33','(''DA''=''Q,'')','EDISPCRCOBZ0','50','D','10','33',NULL,'UsesHCTC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TRUE"','34','(''DA''=''Q,'')','EDISPCRCOBZ0','50','D','10','34',NULL,'Active',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FALSE"','35','(''DA''=''Q,'')','EDISPCRCOBZ0','50','D','10','35',NULL,'AllowMemberSSO',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','36','(''SS''=''Q,'')','EDISPCRCOBZ0','50','D','10','36',NULL,'BenefitGroup',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','37','(''SS''=''Q,'')','EDISPCRCOBZ0','50','D','10','37',NULL,'AccountStructure',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','38','(''SS''=''Q'')','EDISPCRCOBZ0','50','D','10','38',NULL,'ClientSpecificData',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBEVENT]"','1','(''DA''=''Q,'')','EDISPCRCOBZ0','50','D','20','1',NULL,'Record Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEventType"','2','(''UA''=''Q,'')','EDISPCRCOBZ0','50','D','20','2',NULL,'EventType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEventDate"','3','(''UD101''=''Q,'')','EDISPCRCOBZ0','50','D','20','3',NULL,'EventDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrollmentDate"','4','(''UD101''=''Q,'')','EDISPCRCOBZ0','50','D','20','4',NULL,'EnrollmentDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','5','(''UA''=''Q,'')','EDISPCRCOBZ0','50','D','20','5',NULL,'EmployeeSSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvName"','6','(''UA''=''Q,'')','EDISPCRCOBZ0','50','D','20','6',NULL,'EmployeeName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','7','(''SS''=''Q'')','EDISPCRCOBZ0','50','D','20','7',NULL,'SecondEventOriginalFDOC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBPLANINITIAL]"','1','(''DA''=''Q,'')','EDISPCRCOBZ0','50','D','30','1',NULL,'Record Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanName"','2','(''UA''=''Q,'')','EDISPCRCOBZ0','50','D','30','2',NULL,'PlanName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageLevel"','3','(''UA''=''Q,'')','EDISPCRCOBZ0','50','D','30','3',NULL,'CoverageLevel',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','4','(''SS''=''Q'')','EDISPCRCOBZ0','50','D','30','4',NULL,'NumberOfUnits',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBDEPENDENT]"','1','(''DA''=''Q,'')','EDISPCRCOBZ0','50','D','40','1',NULL,'Record Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','2','(''UA''=''Q,'')','EDISPCRCOBZ0','50','D','40','2',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelationship"','3','(''UA''=''Q,'')','EDISPCRCOBZ0','50','D','40','3',NULL,'Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','4','(''SS''=''Q,'')','EDISPCRCOBZ0','50','D','40','4',NULL,'Salutation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','5','(''UA''=''Q,'')','EDISPCRCOBZ0','50','D','40','5',NULL,'FirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','6','(''UA''=''Q,'')','EDISPCRCOBZ0','50','D','40','6',NULL,'MiddleInitial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','7','(''UA''=''Q,'')','EDISPCRCOBZ0','50','D','40','7',NULL,'LastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''SS''=''Q,'')','EDISPCRCOBZ0','50','D','40','8',NULL,'Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''SS''=''Q,'')','EDISPCRCOBZ0','50','D','40','9',NULL,'Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''SS''=''Q,'')','EDISPCRCOBZ0','50','D','40','10',NULL,'Phone2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIsAddressSame"','11','(''UA''=''Q,'')','EDISPCRCOBZ0','50','D','40','11',NULL,'AddressSameAsQB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','12','(''UA''=''Q,'')','EDISPCRCOBZ0','50','D','40','12',NULL,'Address1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','13','(''UA''=''Q,'')','EDISPCRCOBZ0','50','D','40','13',NULL,'Address2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','14','(''UA''=''Q,'')','EDISPCRCOBZ0','50','D','40','14',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','15','(''UA''=''Q,'')','EDISPCRCOBZ0','50','D','40','15',NULL,'StateOrProvince',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','16','(''UA''=''Q,'')','EDISPCRCOBZ0','50','D','40','16',NULL,'PostalCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','17','(''SS''=''Q,'')','EDISPCRCOBZ0','50','D','40','17',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''SS''=''Q,'')','EDISPCRCOBZ0','50','D','40','18',NULL,'EnrollmentDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','19','(''UA''=''Q,'')','EDISPCRCOBZ0','50','D','40','19',NULL,'Sex',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','20','(''UD101''=''Q,'')','EDISPCRCOBZ0','50','D','40','20',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvISQMCO"','21','(''UA''=''Q'')','EDISPCRCOBZ0','50','D','40','21',NULL,'IsQMCSO',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBDEPENDENTPLANINITIAL]"','1','(''DA''=''Q,'')','EDISPCRCOBZ0','50','D','50','1',NULL,'Record Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanName"','2','(''UA''=''Q'')','EDISPCRCOBZ0','50','D','50','2',NULL,'PlanName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBSTATEINSERTS]"','1','(''DA''=''Q,'')','EDISPCRCOBZ0','50','D','60','1',NULL,'Record Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStateSpecDocName"','2','(''UA''=''Q'')','EDISPCRCOBZ0','50','D','60','2',NULL,'StateSpecificDocumentName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBPLANMEMBERSPECIFICRATEINITIAL]"','1','(''DA''=''Q,'')','EDISPCRCOBZ0','50','D','70','1',NULL,'Record Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanName"','2','(''UA''=''Q,'')','EDISPCRCOBZ0','50','D','70','2',NULL,'PlanName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRate"','3','(''UA''=''Q'')','EDISPCRCOBZ0','50','D','70','3',NULL,'Rate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[NPM]"','1','(''DA''=''Q,'')','EDISPCRCOBZ0','50','D','80','1',NULL,'Version Line Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','2','(''UA''=''Q,'')','EDISPCRCOBZ0','50','D','80','2',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpNo"','3','(''UA''=''Q,'')','EDISPCRCOBZ0','50','D','80','3',NULL,'IndividualIdentifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientName"','4','(''UA''=''Q,'')','EDISPCRCOBZ0','50','D','80','4',NULL,'ClientName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientDivName"','5','(''UA''=''Q,'')','EDISPCRCOBZ0','50','D','80','5',NULL,'ClientDivisionName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','6','(''UA''=''Q,'')','EDISPCRCOBZ0','50','D','80','80',NULL,'FirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','7','(''UA''=''Q,'')','EDISPCRCOBZ0','50','D','80','7',NULL,'MiddleInitial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','8','(''UA''=''Q,'')','EDISPCRCOBZ0','50','D','80','8',NULL,'LastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''SS''=''Q,'')','EDISPCRCOBZ0','50','D','80','9',NULL,'Salutation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressEMail"','10','(''UA''=''Q,'')','EDISPCRCOBZ0','50','D','80','10',NULL,'Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneHomeNumber"','11','(''UA''=''Q,'')','EDISPCRCOBZ0','50','D','80','11',NULL,'Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','12','(''SS''=''Q,'')','EDISPCRCOBZ0','50','D','80','12',NULL,'Phone2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','13','(''UA''=''Q,'')','EDISPCRCOBZ0','50','D','80','13',NULL,'Address1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','14','(''UA''=''Q,'')','EDISPCRCOBZ0','50','D','80','14',NULL,'Address2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','15','(''UA''=''Q,'')','EDISPCRCOBZ0','50','D','80','15',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','16','(''UA''=''Q,'')','EDISPCRCOBZ0','50','D','80','16',NULL,'StateOrProvince',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','17','(''UA''=''Q,'')','EDISPCRCOBZ0','50','D','80','17',NULL,'PostalCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''SS''=''Q,'')','EDISPCRCOBZ0','50','D','80','18',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','19','(''UA''=''Q,'')','EDISPCRCOBZ0','50','D','80','19',NULL,'Sex',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TRUE"','20','(''DA''=''Q,'')','EDISPCRCOBZ0','50','D','80','20',NULL,'UsesFamilyInAddress',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FALSE"','21','(''DA''=''Q,'')','EDISPCRCOBZ0','50','D','80','21',NULL,'HasWaivedAllCoverage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TRUE"','22','(''DA''=''Q,'')','EDISPCRCOBZ0','50','D','80','22',NULL,'SendGRNotice',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHireDate"','23','(''UD101''=''Q'')','EDISPCRCOBZ0','50','D','80','23',NULL,'Hire Date',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EDISPCRCOB_20210914.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'NPM/Cobra Export','202105259','EMPEXPORT','ONDEMAND','Nov  8 2017 12:00AM','EDISPCRCOB',NULL,NULL,NULL,'202105259','Oct 30 2017 12:00AM','Dec 30 1899 12:00AM','202105111',NULL,'','','202105111',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Export','202105259','EMPEXPORT','SCH_PCRCOB',NULL,'EDISPCRCOB',NULL,NULL,NULL,'202105259','Jan 13 2016  8:53AM','Jan 13 2016  8:53AM','202105111',NULL,'','','202105111',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Test NPM/Cobra Export','202109071','EMPEXPORT','TEST','Sep  7 2021 11:28PM','EDISPCRCOB',NULL,NULL,NULL,'202109071','Sep  7 2021 12:00AM','Dec 30 1899 12:00AM','202108011','144','','','202108011',dbo.fn_GetTimedKey(),NULL,'us3cPePCR1000',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISPCRCOB','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISPCRCOB','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISPCRCOB','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISPCRCOB','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISPCRCOB','SubSort2','C','drvSubSort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISPCRCOB','SubSort3','C','drvSubSort3');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISPCRCOB','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISPCRCOB','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EDISPCRCOB' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EDISPCRCOB' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EDISPCRCOB_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EDISPCRCOB_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISPCRCOB','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISPCRCOB','D10','dbo.U_EDISPCRCOB_drvTbl_QB WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISPCRCOB','D20','dbo.U_EDISPCRCOB_drvTbl_QBEVENT WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISPCRCOB','D30','dbo.U_EDISPCRCOB_drvTbl_QBPLAN WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISPCRCOB','D40','dbo.U_EDISPCRCOB_drvTbl_QBDEP WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISPCRCOB','D50','dbo.U_EDISPCRCOB_drvTbl_QBDEPPLAN WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISPCRCOB','D60','dbo.U_EDISPCRCOB_drvTbl_QBSTATEINSERT WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISPCRCOB','D70','dbo.U_EDISPCRCOB_drvTbl_QBMSRI WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISPCRCOB','D80','dbo.U_EDISPCRCOB_drvTbl_NPM WITH (NOLOCK)',NULL);
IF OBJECT_ID('U_dsi_BDM_EDISPCRCOB') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EDISPCRCOB] (
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
IF OBJECT_ID('U_EDISPCRCOB_DepCount') IS NULL
CREATE TABLE [dbo].[U_EDISPCRCOB_DepCount] (
    [DCEEID] char(12) NOT NULL,
    [DCCOID] char(5) NULL,
    [spouse_count] int NULL,
    [child_count] int NULL
);
IF OBJECT_ID('U_EDISPCRCOB_drvTbl_NPM') IS NULL
CREATE TABLE [dbo].[U_EDISPCRCOB_drvTbl_NPM] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvSSN] char(11) NULL,
    [drvEmpNo] varchar(1) NOT NULL,
    [drvClientName] varchar(100) NULL,
    [drvClientDivName] varchar(50) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvAddressEMail] varchar(1) NOT NULL,
    [drvPhoneHomeNumber] varchar(1) NOT NULL,
    [drvAddressLine1] varchar(8000) NULL,
    [drvAddressLine2] varchar(8000) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvGender] varchar(1) NOT NULL,
    [drvHireDate] datetime NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] char(11) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EDISPCRCOB_drvTbl_QB') IS NULL
CREATE TABLE [dbo].[U_EDISPCRCOB_drvTbl_QB] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NOT NULL,
    [drvClientName] varchar(100) NULL,
    [drvClientDivName] varchar(50) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvSSN] varchar(11) NULL,
    [drvEmpNo] varchar(1) NOT NULL,
    [drvAddressLine1] varchar(8000) NULL,
    [drvAddressLine2] varchar(8000) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvGender] varchar(1) NOT NULL,
    [drvDateOfBirth] datetime NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(208) NULL
);
IF OBJECT_ID('U_EDISPCRCOB_drvTbl_QBDEP') IS NULL
CREATE TABLE [dbo].[U_EDISPCRCOB_drvTbl_QBDEP] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NULL,
    [drvSSN] varchar(11) NULL,
    [drvRelationship] varchar(15) NOT NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvIsAddressSame] varchar(5) NOT NULL,
    [drvAddressLine1] varchar(1) NOT NULL,
    [drvAddressLine2] varchar(1) NOT NULL,
    [drvAddressCity] varchar(1) NOT NULL,
    [drvAddressState] varchar(1) NOT NULL,
    [drvAddressZipCode] varchar(1) NOT NULL,
    [drvGender] varchar(1) NOT NULL,
    [drvDateOfBirth] datetime NULL,
    [drvISQMCO] varchar(5) NOT NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(33) NULL,
    [drvSubSort3] varchar(208) NULL
);
IF OBJECT_ID('U_EDISPCRCOB_drvTbl_QBDEPPLAN') IS NULL
CREATE TABLE [dbo].[U_EDISPCRCOB_drvTbl_QBDEPPLAN] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NULL,
    [drvDedCode] char(5) NULL,
    [drvPlanName] varchar(33) NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(38) NULL,
    [drvSubSort3] varchar(208) NULL
);
IF OBJECT_ID('U_EDISPCRCOB_drvTbl_QBEVENT') IS NULL
CREATE TABLE [dbo].[U_EDISPCRCOB_drvTbl_QBEVENT] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NOT NULL,
    [drvEventType] varchar(29) NOT NULL,
    [drvEventDate] datetime NULL,
    [drvEnrollmentDate] datetime NULL,
    [drvSSN] varchar(11) NULL,
    [drvName] varchar(201) NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(208) NULL
);
IF OBJECT_ID('U_EDISPCRCOB_drvTbl_QBMSRI') IS NULL
CREATE TABLE [dbo].[U_EDISPCRCOB_drvTbl_QBMSRI] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NOT NULL,
    [drvPlanName] varchar(33) NULL,
    [drvRate] money NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(208) NULL
);
IF OBJECT_ID('U_EDISPCRCOB_drvTbl_QBPLAN') IS NULL
CREATE TABLE [dbo].[U_EDISPCRCOB_drvTbl_QBPLAN] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NOT NULL,
    [drvDedCode] char(5) NULL,
    [drvPlanName] varchar(33) NULL,
    [drvCoverageLevel] varchar(18) NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(6) NULL,
    [drvSubSort3] varchar(208) NULL
);
IF OBJECT_ID('U_EDISPCRCOB_drvTbl_QBSTATEINSERT') IS NULL
CREATE TABLE [dbo].[U_EDISPCRCOB_drvTbl_QBSTATEINSERT] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NOT NULL,
    [drvStateSpecDocName] varchar(13) NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(208) NULL
);
IF OBJECT_ID('U_EDISPCRCOB_EEList') IS NULL
CREATE TABLE [dbo].[U_EDISPCRCOB_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EDISPCRCOB_File') IS NULL
CREATE TABLE [dbo].[U_EDISPCRCOB_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EDISPCRCOB]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: PCRK Holding Company

Created By: Andy Pineda
Business Analyst: Cheryl Petitti
Create Date: 09/02/2021
Service Request Number: TekP-2021-07-22-0007

Purpose: PCRK Holding Company COBRA Export

Revision History
----------------
09/14/2021 by AP:
		- QB Record: Changed client division name.
		- QBPLANMEMBERSPECIFICREATEINITIAL Record: Updated rate logic.

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EDISPCRCOB';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EDISPCRCOB';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EDISPCRCOB';
SELECT * FROM dbo.AscExp WHERE expFormatCode = 'EDISPCRCOB';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EDISPCRCOB' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISPCRCOB', 'SCH_PCRCOB';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISPCRCOB', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISPCRCOB', 'TEST';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EDISPCRCOB';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EDISPCRCOB', @AllObjects = 'Y', @IsWeb = 'Y';
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
    SET @FormatCode = 'EDISPCRCOB';

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
    DELETE FROM dbo.U_EDISPCRCOB_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCoID(xEEID)
      AND xEEID IN (SELECT xEEID FROM dbo.U_EDISPCRCOB_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

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
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','X'); -- DedIsCobraCovered = 'Y'
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'NewEnrolleeType','4'); -- All new enrollees where no previous plan exists
   -- INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'TableType','EMP'); -- Only include employees on NPM file
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');

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
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS,SPX');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL, DPC, STC');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DMP, DP');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');

    -- Run BDM for QB
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    -- Dependents Count
        IF OBJECT_ID('U_EDISPCRCOB_DepCount','U') IS NOT NULL 
        DROP TABLE dbo.U_EDISPCRCOB_DepCount;

        SELECT e.bdmeeid as DCEEID, e.bdmcoid AS DCCOID, count(distinct(s.bdmdateofbirth)) as spouse_count, count(distinct(c.bdmdateofbirth)) as child_count
        into dbo.U_EDISPCRCOB_DepCount
        FROM dbo.U_dsi_BDM_EDISPCRCOB e WITH(NOLOCK) 
        left JOIN dbo.U_dsi_BDM_EDISPCRCOB s WITH(NOLOCK) ON s.bdmeeid = e.bdmeeid  and s.bdmrelationship in ('sps', 'dp', 'dpn')
        left join dbo.U_dsi_BDM_EDISPCRCOB c with(nolock) on c.bdmeeid = e.bdmeeid and c.bdmrelationship in ('chl', 'stc', 'dpc', 'ddp', 'grc')

        group by e.bdmeeid, e.bdmcoid

    ---- 203 death insert employee
    --INSERT INTO [dbo].[U_dsi_BDM_EDISPCRCOB]
    --([BdmRecType]
    --,[BdmCOID]
    --,[BdmEEID]
    --,[BdmDepRecID]
    --,[BdmSystemID]
    --,[BdmRunID]
    --,[BdmDedRowStatus]
    --,[BdmRelationship]
    --,[BdmDateOfBirth]
    --,[BdmDedCode]
    --,[BdmBenOption]
    --,[BdmBenStartDate]
    --,[BdmBenStopDate]
    --,[BdmBenStatusDate]
    --,[BdmDateOFCobraEvent]
    --,[BdmChangeReason]
    --,[BdmCobraReason]
    --,[BdmStartDate]
    --,[BdmStopDate]
    --,[BdmIsPQB]
    --)
    --SELECT DISTINCT 'EMP'
    --,EecCOID
    --,EecEEID
    --,NULL
    --,NULL
    --,'QB'
    --,'Data inserted for 203 term reason'
    --,'Emp'
    --,EepDateOfBirth
    --,DedDedCode
    --,EedBenOption
    --,EedBenStartDate
    --,EedBenStopDate
    --,EedBenStatusDate
    --,EedBenStatusDate
    --,'203'
    --,'203'
    --,EedStartDate
    --,EedStopDate
    --,'Y'
    --FROM dbo.EmpComp WITH(NOLOCK)
    --JOIN dbo.u_dsi_bdm_EmpDeductions WITH(NOLOCK)
    --ON EecEEID = EedEEID
    --AND EecCOID = EedCOID
    --JOIN dbo.EmpPers WITH(NOLOCK)
    --ON EecEEID = EepEEID
    --WHERE EedValidForExport = 'N'
    --AND EedFormatCode = 'EDISPCRCOB'
    ----AND eeceeid = 'DTCQW5000040'
    --AND EecTermReason = '203'

    INSERT INTO [dbo].[U_dsi_BDM_EDISPCRCOB]
    ([BdmRecType]
    ,[BdmCOID]
    ,[BdmEEID]
    ,[BdmDepRecID]
    ,[BdmSystemID]
    ,[BdmRunID]
    ,[BdmDedRowStatus]
    ,[BdmRelationship]
    ,[BdmDateOfBirth]
    ,[BdmDedCode]
    ,[BdmBenOption]
    ,[BdmBenStartDate]
    ,[BdmBenStopDate]
    ,[BdmBenStatusDate]
    ,[BdmDateOFCobraEvent]
    ,[BdmChangeReason]
    ,[BdmCobraReason]
    ,[BdmStartDate]
    ,[BdmStopDate]
    ,[BdmIsPQB]
    )
    SELECT DISTINCT rectype = 'DEP'
    ,EdhCoid
    ,EdhEEID
    ,DbnDepRecID
    ,DbnDepRecID
    ,'QB'
    ,'Data Inserted for 204 Chg reason'
    ,DbnRelationship
    ,DbnDateOfBirth
    ,EdhDedCode
    ,DbnBenOption
    ,EdhBenStartDate
    ,EdhBenStopDate
    ,EdhBenStatusDate
    ,EdhBenStatusDate
    ,'204'
    ,'204'
    ,EdhStartDate
    ,EdhStopDate
    ,CASE WHEN DbnRelationShip = 'SPS' THEN 'Y' ELSE 'N' END
    FROM dbo.emphded WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_DepDeductions
    ON dbneeid = edheeid
    AND dbnformatcode = 'EDISPCRCOB'
    WHERE edhChangeReason in ('204')
    AND DbnBenStopDate BETWEEN @StartDate AND @EndDate
    AND dbnValidForExport = 'N'

    -- Dependent values for 201 event
    INSERT INTO [dbo].[U_dsi_BDM_EDISPCRCOB]
    ( [BdmRecType]
    ,[BdmCOID]
    ,[BdmEEID]
    ,[BdmDepRecID]
    ,[BdmSystemID]
    ,[BdmRunID]
    ,[BdmDedRowStatus]
    ,[BdmRelationship]
    ,[BdmDateOfBirth]
    ,[BdmDedCode]
    ,[BdmBenOption]
    ,[BdmBenStartDate]
    ,[BdmBenStopDate]
    ,[BdmBenStatusDate]
    ,[BdmDateOFCobraEvent]
    ,[BdmChangeReason]
    ,[BdmCobraReason]
    ,[BdmStartDate]
    ,[BdmStopDate]
    ,[BdmIsPQB]
    )
    SELECT DISTINCT rectype = 'DEP'
    ,EdhCoid
    ,EdhEEID
    ,DbnDepRecID
    ,DbnDepRecID
    ,'QB'
    ,'Data Inserted for 201 Chg reason'
    ,DbnRelationship
    ,DbnDateOfBirth
    ,EdhDedCode
    ,DbnBenOption
    ,EdhBenStartDate
    ,EdhBenStopDate
    ,EdhBenStatusDate
    ,EdhBenStatusDate
    ,'201'
    ,'201'
    ,EdhStartDate
    ,EdhStopDate
    ,'Y'
    FROM dbo.emphded WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
    ON dbneeid = edheeid
    AND dbnformatcode = 'EDISPCRCOB'
    WHERE edhChangeReason IN ('201')
    and DbnBenstopdate BETWEEN @startdate AND @enddate
    AND dbnValidForExport = 'N'

    INSERT INTO [dbo].[U_dsi_BDM_EDISPCRCOB]
    ( [BdmRecType]
    ,[BdmCOID]
    ,[BdmEEID]
    ,[BdmDepRecID]
    ,[BdmSystemID]
    ,[BdmRunID]
    ,[BdmDedRowStatus]
    ,[BdmRelationship]
    ,[BdmDateOfBirth]
    ,[BdmDedCode]
    ,[BdmBenOption]
    ,[BdmBenStartDate]
    ,[BdmBenStopDate]
    ,[BdmBenStatusDate]
    ,[BdmDateOFCobraEvent]
    ,[BdmChangeReason]
    ,[BdmCobraReason]
    ,[BdmStartDate]
    ,[BdmStopDate]
    ,[BdmIsPQB]
    )
    SELECT DISTINCT rectype = 'DEP'
    ,EdhCoid
    ,EdhEEID
    ,DbnDepRecID
    ,DbnDepRecID
    ,'QB'
    ,'Data Inserted for 203 Chg reason'
    ,DbnRelationship
    ,DbnDateOfBirth
    ,EdhDedCode
    ,'EE' -- Takes the place of the employeee.
    ,EdhBenStartDate
    ,EdhBenStopDate
    ,EdhBenStatusDate
    ,EdhBenStatusDate
    ,'210'
    ,'210'
    ,EdhStartDate
    ,EdhStopDate
    ,'Y'
    FROM dbo.emphded WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
    ON dbneeid = edheeid
    AND dbnformatcode = 'EDISPCRCOB'
    WHERE edhChangeReason IN ('210')
    and DbnBenstopdate BETWEEN @startdate AND @enddate
    AND dbnValidForExport = 'N'

    --DELETE FROM dbo.U_dsi_BDM_EDISPCRCOB WHERE BdmDedCode not in (SELECT DedCode FROM dbo.U_EDISPCRCOB_DedList)

    ---- 203 death insert dependent
    --INSERT INTO [dbo].[U_dsi_BDM_EDISPCRCOB]
    --([BdmRecType]
    --,[BdmCOID]
    --,[BdmEEID]
    --,[BdmDepRecID]
    --,[BdmSystemID]
    --,[BdmRunID]
    --,[BdmDedRowStatus]
    --,[BdmRelationship]
    --,[BdmDateOfBirth]
    --,[BdmDedCode]
    --,[BdmBenOption]
    --,[BdmBenStartDate]
    --,[BdmBenStopDate]
    --,[BdmBenStatusDate]
    --,[BdmDateOFCobraEvent]
    --,[BdmChangeReason]
    --,[BdmCobraReason]
    --,[BdmStartDate]
    --,[BdmStopDate]
    --,[BdmIsPQB]
    --)
    --SELECT DISTINCT 'DEP'
    --,EecCOID
    --,EecEEID
    --,NULL
    --,NULL
    --,'QB'
    --,'Data inserted for 203 term reason'
    --, DbnRelationship
    --,EepDateOfBirth
    --,DedDedCode
    --,DbnBenOption
    --,DbnBenStartDate
    --,DbnBenStopDate 
    --,DbnBenStatusDate
    --,DbnBenStatusDate
    --,'203'
    --,'203'
    --,NULL
    --,NULL
    --,'Y'
    --FROM dbo.EmpComp WITH(NOLOCK)
    --JOIN dbo.u_dsi_bdm_DepDeductions WITH(NOLOCK)
    --ON EecEEID = dbnEEID
    --AND EecCOID = dbnCOID
    --JOIN dbo.EmpPers WITH(NOLOCK)
    --ON EepEEID = dbnEEID
    --WHERE DbnValidForExport = 'N'
    --AND DbnFormatCode = 'EDISPCRCOB'
    ----AND eeceeid = 'DTCQW5000040'
    --AND EecTermReason = '203'


    --==========================================
    -- Build driver tables
    --==========================================
    ------------------
    -- DETAIL RECORD - NPM Record
    ------------------
    IF OBJECT_ID('U_EDISPCRCOB_drvTbl_NPM') IS NOT NULL
        DROP TABLE dbo.U_EDISPCRCOB_drvTbl_NPM;
    SELECT DISTINCT
         drvEEID            = BdmEEID
        ,drvCoID            = BdmCoID
        ,drvSSN             = eepSSN
        ,drvEmpNo           = ''
        ,drvClientName      = CONVERT(varchar(100),'PCRK Employee Leasing Company LLC 40641')
        ,drvClientDivName   = CONVERT(varchar(50),'PCRK Employee Leasing Company LLC')
        ,drvNameFirst       = EepNameFirst
        ,drvNameMiddle      = LEFT(EepNameMiddle,1)
        ,drvNameLast        = EepNameLast
        ,drvAddressEMail    = ''
        ,drvPhoneHomeNumber = ''
        ,drvAddressLine1    = REPLACE(EepAddressLine1, ',', '')
        ,drvAddressLine2    = REPLACE(EepAddressLine2, ',', '')
        ,drvAddressCity     = EepAddressCity
        ,drvAddressState    = EepAddressState
        ,drvAddressZipCode  = EepAddressZipCode
        ,drvGender          = CASE WHEN EepGender = 'M' THEN 'M'
                                    WHEN EepGender = 'F' THEN 'F' 
                                ELSE 'U' END
        ,drvHireDate        = EecDateOfLastHire
        --ISNULL(CONVERT(VARCHAR, (CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN EecDateOfLastHire END), 101), '')
        ,drvInitialSort     = '22'
        ,drvSubSort         = eepSSN
        ,drvSubSort2        = ''
        ,drvSubSort3        = ''
    INTO dbo.U_EDISPCRCOB_drvTbl_NPM
    FROM dbo.U_dsi_BDM_EDISPCRCOB WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = BdmEEID
       AND EecCoID = BdmCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = BdmEEID
    WHERE BdmRunID = 'NPM';

    ------------------
    -- QB DETAIL RECORD
    ------------------
    IF OBJECT_ID('U_EDISPCRCOB_drvTbl_QB') IS NOT NULL
        DROP TABLE dbo.U_EDISPCRCOB_drvTbl_QB;
    SELECT DISTINCT
         drvEEID           = BdmEEID
        ,drvCoID           = BdmCoID
        ,drvDepRecID       = ISNULL(BdmDepRecID,'')
        ,drvClientName     = CONVERT(varchar(100),'PCRK Employee Leasing Company LLC 40641')
        ,drvClientDivName  = CONVERT(varchar(50),'PCRK Employee Leasing Company LLC')
        ,drvNameFirst      = CASE WHEN BdmChangeReason IN ('201', 'LEVNT3', '204', '210', 'LEVNT4') THEN ConNameFirst ELSE EepNameFirst END
        ,drvNameMiddle     = CASE WHEN BdmChangeReason IN ('201', 'LEVNT3', '204', '210', 'LEVNT4') THEN LEFT(ConNameMiddle, 1) ELSE LEFT(EepNameMiddle, 1) END
        ,drvNameLast       = CASE WHEN BdmChangeReason IN ('201', 'LEVNT3', '204', '210', 'LEVNT4') THEN ConNameLast ELSE EepNameLast END
        ,drvSSN            = CASE WHEN BdmChangeReason IN ('201', 'LEVNT3', '204', '210', 'LEVNT4') THEN SUBSTRING(ConSSN, 1, 3)+'-'+
                                                                                                                    SUBSTRING(ConSSN, 4, 2)+'-'+
                                                                                                                    SUBSTRING(ConSSN, 6, 4)  ELSE SUBSTRING(EepSSN, 1, 3)+'-'+
                                                                                                                                                    SUBSTRING(EepSSN, 4, 2)+'-'+
                                                                                                                                                    SUBSTRING(EepSSN, 6, 4)  END
        ,drvEmpNo          = ''
        ,drvAddressLine1   = CASE WHEN BdmChangeReason IN ('201', 'LEVNT3', '204', '210', 'LEVNT4') THEN REPLACE(ConAddressLine1, ',', '') ELSE REPLACE(EepAddressLine1, ',', '') END
        ,drvAddressLine2   = CASE WHEN BdmChangeReason IN ('201', 'LEVNT3', '204', '210', 'LEVNT4') THEN REPLACE(ConAddressLine2, ',', '') ELSE REPLACE(EepAddressLine2, ',', '') END
        ,drvAddressCity    = CASE WHEN BdmChangeReason IN ('201', 'LEVNT3', '204', '210', 'LEVNT4') THEN ConAddressCity ELSE EepAddressCity END
        ,drvAddressState   = CASE WHEN BdmChangeReason IN ('201', 'LEVNT3', '204', '210', 'LEVNT4') THEN ConAddressState ELSE EepAddressState END
        ,drvAddressZipCode = CASE WHEN BdmChangeReason IN ('201', 'LEVNT3', '204', '210', 'LEVNT4') THEN ConAddressZipCode ELSE EepAddressZipCode END
        ,drvGender         = CASE WHEN EepGender = 'M' OR ConGender = 'M' THEN 'M'
                                    WHEN EepGender = 'F' OR ConGender = 'F' THEN 'F' ELSE 'U' END
        ,drvDateOfBirth    = CASE WHEN BdmChangeReason IN ('201', 'LEVNT3', '204', '210', 'LEVNT4') THEN ConDateOfBirth ELSE EepDateOfBirth END
        ,drvInitialSort    = '21'
        ,drvSubSort        = CASE WHEN BdmRecType = 'EMP' THEN eepSSN
                                  ELSE ISNULL(NULLIF(ConSSN,''),eepSSN) + CONVERT(char(8),ConDateOfBirth,112)
                             END
        ,drvSubSort2       = '1'
        ,drvSubSort3       = CASE WHEN BdmRecType = 'EMP' THEN '2'
                                  ELSE CONVERT(char(8),ConDateOfBirth,112) + RTRIM(ConNameLast) + ConNameFirst
                             END
    INTO dbo.U_EDISPCRCOB_drvTbl_QB
    FROM dbo.U_dsi_BDM_EDISPCRCOB WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = BdmEEID
       AND EecCoID = BdmCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = BdmEEID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = BdmEEID
       AND ConSystemID = BdmDepRecID
    WHERE BdmRunID = 'QB'
      AND BdmIsPQB = 'Y';

    ------------------
    -- QBEVENT DETAIL RECORD
    ------------------
    IF OBJECT_ID('U_EDISPCRCOB_drvTbl_QBEVENT') IS NOT NULL
        DROP TABLE dbo.U_EDISPCRCOB_drvTbl_QBEVENT;
    SELECT DISTINCT
         drvEEID           = drvEEID
        ,drvCoID           = drvCoID
        ,drvDepRecID       = drvDepRecID
        ,drvEventType      = CASE WHEN EecEmplStatus = 'T' AND EecTermReason NOT IN ('202', '203') AND EecTermType = 'V' THEN 'TERMINATION'
                                    WHEN EecEmplStatus = 'T' AND EecTermReason NOT IN ('202', '203') AND EecTermType = '' THEN 'TERMINATION'
                                    WHEN EecEmplStatus = 'T' AND EecTermReason = '203' THEN 'DEATH'
                                    WHEN EecEmplStatus = 'T' AND EecTermReason = '202' THEN 'RETIREMENT'
                                    WHEN EecEmplStatus = 'T' AND EecTermType = 'I' THEN 'INVOLUNTARYTERMINATION'
                                    WHEN Bdmcobrareason = '208' THEN 'RETIREMENT'
                                    WHEN Bdmcobrareason = '205' THEN 'MEDICARE'
                                    WHEN Bdmcobrareason IN ('204', 'LEVNT4') THEN 'DIVORCELEGALSEPARATION'
                                    WHEN bdmcobrareason IN ('201', 'LEVNT3') THEN 'INELIGIBLEDEPENDENT'
                                    WHEN bdmcobrareason IN ('203', '202') THEN 'REDUCTIONINHOURS-STATUSCHANGE'
                                    WHEN bdmcobrareason = '206' THEN 'REDUCTIONINHOURS-ENDOFLEAVE'
                                    ELSE 'TERMINATION'
                                END
        /*CASE WHEN EecTermReason = '202' THEN 'RETIREMENT'
                                  WHEN EecTermReason = '203' THEN 'DEATH'
                                  WHEN BdmCobraReason IN ('201','LEVNT3') THEN 'INELIGIBLEDEPENDENT'
                                  WHEN BdmCobraReason IN ('204','LEVNT4') THEN 'DIVORCELEGALSEPARATION'
                                  WHEN BdmCobraReason = '210' THEN 'DEATH'
                                  WHEN BdmCobraReason IN ('202','CHGRP') THEN 'LOSSOFELIGIBILITY'
                                  WHEN BdmCobraReason = '203' THEN 'REDUCTIONINHOURS-STATUSCHANGE'
                                  WHEN BdmCobraReason = '205' THEN 'MEDICARE'
                                  WHEN BdmCobraReason = '206' THEN 'REDUCTIONINHOURS-ENDOFLEAVE'
                                  WHEN BdmCobraReason = '207' THEN 'USERRA-REDUCTIONINHOURS'
                                  WHEN BdmCobraReason = '208' THEN 'RETIREMENT'
                                  WHEN BdmCobraReason = '209' THEN 'WORKSTOPPAGE'
                                  ELSE 'TERMINATION'
                             END */
        ,drvEventDate      = CASE WHEN EecEmplStatus = 'T' AND EecTermReason NOT IN ('202', '203') THEN EecDateOfTermination
                                    WHEN EecEmplStatus = 'T' AND EecTermReason IN ('202', '203') AND BdmDateOfCOBRAEvent = '' THEN EecDateOfTermination
                                    WHEN BdmChangeReason IN ('LEVNT3', 'LEVNT4', '204', '210', '201') THEN edh.EdhEffDate 
                                ELSE BdmDateOfCOBRAEvent END
        ,drvEnrollmentDate = (SELECT MAX(BdmBenStartDate) FROM dbo.U_dsi_BDM_EDISPCRCOB a WITH(NOLOCK) WHERE a.bdmeeid = bdm.bdmeeid and a.bdmcoid = bdm.bdmcoid)
        ,drvSSN            = SUBSTRING(EepSSN, 1, 3)+'-'+
                                SUBSTRING(EepSSN, 4, 2)+'-'+
                                SUBSTRING(EepSSN, 6, 4) 
        ,drvName           = RTRIM(EepNameFirst) + ' ' + RTRIM(EepNameLast)
                            /*CASE WHEN BdmRecType = 'DEP' THEN RTRIM(EepNameFirst) + ' ' + EepNameLast
                                  ELSE ''
                             END */
        ,drvInitialSort    = '21'
        ,drvSubSort        = drvSubSort
        ,drvSubSort2       = '1'
        ,drvSubSort3       = drvSubSort3
    INTO dbo.U_EDISPCRCOB_drvTbl_QBEVENT
    FROM dbo.U_EDISPCRCOB_drvTbl_QB WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = drvEEID
       AND EecCoID = drvCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = drvEEID
    JOIN (SELECT
             BdmEEID
            ,BdmCoID
            ,BdmDedCode
            ,BdmDepRecID
            ,BdmRecType
            ,BdmChangeReason
            ,BdmCobraReason = MAX(BdmCobraReason)
            ,BdmBenStartDate = MIN(BdmBenStartDate)
            ,BdmDateOfCOBRAEvent = MAX(BdmDateOfCOBRAEvent)
            ,BdmUSGDate1 = MAX(BdmUSGDate1)
          FROM dbo.U_dsi_BDM_EDISPCRCOB WITH (NOLOCK)
          WHERE BdmRunID = 'QB'
            AND BdmIsPQB = 'Y'
          GROUP BY BdmEEID, BdmCoID, BdmDedCode, BdmDepRecID, BdmRecType, BdmChangeReason) BDM
        ON BdmEEID = drvEEID
       AND BdmCoID = drvCoID
       AND ISNULL(BdmDepRecID,'') = drvDepRecID
    OUTER APPLY (SELECT TOP 1 EdhEffDate FROM dbo.EmpHDed WITH(NOLOCK) 
    WHERE BdmDedCode = EdhDedCode and BdmCOID = EdhCOID and BdmEEID = EdhEEID ORDER BY EdhDateTimeCreated DESC) edh;

    ------------------
    -- QBPLANINITIAL DETAIL RECORD
    ------------------
    IF OBJECT_ID('U_EDISPCRCOB_drvTbl_QBPLAN') IS NOT NULL
        DROP TABLE dbo.U_EDISPCRCOB_drvTbl_QBPLAN;
    SELECT DISTINCT
         drvEEID          = drvEEID
        ,drvCoID          = drvCoID
        ,drvDepRecID      = drvDepRecID
        ,drvDedCode       = BdmDedCode
        ,drvPlanName      = CASE BdmDedCode 
                                WHEN 'DENH' THEN 'MetLife Dental High DPPO'
                                WHEN 'DENL' THEN 'MetLife Dental Low DPPO'
                                WHEN 'VISH' THEN 'MetLife Vision High PPO'
                                WHEN 'VISL' THEN 'MetLife Vision Low PPO'
                                WHEN 'MEDU4' THEN 'UHC Medical Choice Plus PPO $1000'
                                WHEN 'MEDU3' THEN 'UHC Medical Choice Plus PPO $3000'
                                WHEN 'MEDU2' THEN 'UHC Medical Choice Plus PPO $6000'
                                WHEN 'MEDU1' THEN 'UHC Medical Choice Plus PPO $7150'
                                WHEN 'FSA' THEN 'WEX FSA' END
        /*CONVERT(varchar(50),'@PlanName')*/
        ,drvCoverageLevel = CASE WHEN BdmCobraReason IN ('204', 'LEVNT4', '201', 'LEVNT3', '210') AND BdmRelationship IN ('DMP', 'DP', 'SPS', 'SPX') AND child_count = 1
                                        THEN 'EE+CHILD'
                                WHEN BdmCobraReason IN ('204', 'LEVNT4', '201', 'LEVNT3', '210') AND BdmRelationship IN ('DMP', 'DP', 'SPS', 'SPX') AND child_count > 1
                                        THEN 'EE+CHILDREN'
                                WHEN BdmCobraReason IN ('204', 'LEVNT4', '201', 'LEVNT3', '210') AND BdmRelationship IN ('DMP', 'DP', 'SPS', 'SPX') AND child_count = 0
                                        THEN 'EE'
                                WHEN BdmCobraReason NOT IN ('204', 'LEVNT4', '201', 'LEVNT3', '210') AND BdmDedCode IN ('DENH', 'DENL', 'VISH', 'VISL', 'MEDU4',
                                                    'MEDU3', 'MEDU2', 'MEDU1') AND BdmBenOption = 'EE' THEN 'EE'
                                WHEN BdmCobraReason NOT IN ('204', 'LEVNT4', '201', 'LEVNT3', '210') AND BdmDedCode IN ('DENH', 'DENL', 'VISH', 'VISL', 'MEDU4',
                                                    'MEDU3', 'MEDU2', 'MEDU1') AND child_count = 1 THEN 'EE+CHILD'
                                WHEN BdmCobraReason NOT IN ('204', 'LEVNT4', '201', 'LEVNT3', '210') AND BdmDedCode IN ('DENH', 'DENL', 'VISH', 'VISL', 'MEDU4',
                                                    'MEDU3', 'MEDU2', 'MEDU1') AND child_count > 1 THEN 'EE+CHILDREN'
                                WHEN BdmCobraReason NOT IN ('204', 'LEVNT4', '201', 'LEVNT3', '210') AND BdmDedCode IN ('DENH', 'DENL', 'VISH', 'VISL', 'MEDU4',
                                                    'MEDU3', 'MEDU2', 'MEDU1') AND BdmBenOption = 'EEDP' THEN 'EE+DOMESTICPARTNER'
                                WHEN BdmCobraReason NOT IN ('204', 'LEVNT4', '201', 'LEVNT3', '210') AND BdmDedCode IN ('DENH', 'DENL', 'VISH', 'VISL', 'MEDU4',
                                                    'MEDU3', 'MEDU2', 'MEDU1') AND BdmBenOption IN ('EEF', 'EEDPF') THEN 'EE+FAMILY'
                                WHEN BdmCobraReason NOT IN ('204', 'LEVNT4', '201', 'LEVNT3', '210') AND BdmDedCode IN ('DENH', 'DENL', 'VISH', 'VISL', 'MEDU4',
                                                    'MEDU3', 'MEDU2', 'MEDU1') AND BdmBenOption = 'EES' THEN 'EE+SPOUSE'
                                WHEN BdmDedCode = 'FSA' THEN 'EE' 
                            END

                                
        -- CASE WHEN BdmDedCode IN ('MEDHD', 'MEDPP', 'DEN', 'VIS') THEN 
        --                         CASE WHEN BdmBenOption IN ('EE', 'EEP', 'EEMD') THEN 'EE'
        --                              WHEN BdmBenOption IN ('EEC1', 'EEC1MD', 'EEC1P') THEN 'EE+CHILD'
        --                              WHEN BdmBenOption IN ('EEC', 'EECP', 'EECMD') THEN 'EE+CHILDREN'
        --                              WHEN BdmBenOption IN ('EEDP', 'EEDPP', 'EEDMMD', 'EEDPNP') THEN 'EE+DOMESTICPARTNER'
        --                              WHEN BdmBenOption IN ('EEF', 'EEFP', 'EEFMD', 'EEF0', 'EEF0MD', 'EEF0P', 'EEDPFP', 'EEDPFN', 'EEDPNC', 'EEDFMD', 'EEDPN') THEN 'EE+FAMILY'
        --                              WHEN BdmBenOption IN ('EES', 'EESP', 'EESMD', 'EES0', 'EES0MD', 'EES0P') THEN 'EE+SPOUSE'
        --                         END
        --                     END
                /*CASE WHEN BdmDedType = 'FSA' THEN 'EE'
                                 WHEN BdmRecType = 'EMP' THEN
                                      CASE WHEN BdmBenOption IN ('@EEBenOpts') THEN 'EE'
                                           WHEN BdmBenOption IN ('@ECHBenOpts') THEN 'EE+CHILDREN'
                                           WHEN BdmBenOption IN ('@ESPBenOpts') THEN 'EE+SPOUSE'
                                           WHEN BdmBenOption IN ('@EDPBenOpts') THEN 'EE+DOMESTICPARTNER'
                                           WHEN BdmBenOption IN ('@EEFAMBenOpts') THEN 'EE+FAMILY'
                                      END
                                 WHEN BdmRelationship IN ('@SPSRelationships','@DPRelationships') THEN
                                      CASE WHEN ISNULL(BdmNumChildren,0) = 1 THEN 'EE+1'
                                           WHEN ISNULL(BdmNumChildren,0) > 1 THEN 'EE+FAMILY'
                                           ELSE 'EE'
                                      END
                                 ELSE 'EE'
                            END */
        ,drvInitialSort   = '21'
        ,drvSubSort       = drvSubSort
        ,drvSubSort2      = '1' + BdmDedCode
        ,drvSubSort3      = drvSubSort3
    INTO dbo.U_EDISPCRCOB_drvTbl_QBPLAN
    FROM dbo.U_EDISPCRCOB_drvTbl_QBEVENT WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EDISPCRCOB WITH (NOLOCK)
        ON BdmEEID = drvEEID
       AND BdmCoID = drvCoID
       AND ISNULL(BdmDepRecID,'') = drvDepRecID
    JOIN dbo.U_EDISPCRCOB_DepCount WITH(NOLOCK)
        ON DCEEID = BdmEEID
        AND DCCOID = BdmCOID
    WHERE BdmRunID = 'QB'
      AND BdmIsPQB = 'Y';

    ------------------
    -- QBDEPENDENT DETAIL RECORD
    ------------------
    IF OBJECT_ID('U_EDISPCRCOB_drvTbl_QBDEP') IS NOT NULL
        DROP TABLE dbo.U_EDISPCRCOB_drvTbl_QBDEP;
    SELECT DISTINCT
         drvEEID           = BdmEEID
        ,drvCoID           = BdmCoID
        ,drvDepRecID       = BdmDepRecID
        ,drvSSN            = SUBSTRING(ConSSN, 1, 3)+'-'+
                                SUBSTRING(ConSSN, 4, 2)+'-'+
                                SUBSTRING(ConSSN, 6, 4) 
        ,drvRelationship   = CASE WHEN BdmRelationship IN ('SPS', 'SPX') THEN 'SPOUSE'
                                  WHEN BdmRelationship IN ('DP', 'DMP') THEN 'DOMESTICPARTNER'
                                  ELSE 'CHILD'
                             END
        ,drvNameFirst      = ConNameFirst
        ,drvNameMiddle     = LEFT(ConNameMiddle,1)
        ,drvNameLast       = ConNameLast
        ,drvIsAddressSame  = CASE WHEN ConAddressIsDifferent = 'N' OR ConAddressLine1 IS NULL THEN 'TRUE'
                                  ELSE 'FALSE'
                             END
        ,drvAddressLine1   = ''
        ,drvAddressLine2   = ''
        ,drvAddressCity    = ''
        ,drvAddressState   = ''
        ,drvAddressZipCode = ''
        ,drvGender         = CASE WHEN ConGender = 'M' THEN 'M' 
                                    WHEN ConGender = 'F' THEN 'F'
                                    ELSE 'U' END
        ,drvDateOfBirth    = ConDateOfBirth
        ,drvISQMCO         = CASE WHEN BdmRelationship IN ('@QMCORelationships') THEN 'TRUE'
                                  ELSE 'FALSE'
                             END
        ,drvInitialSort    = '21'
        ,drvSubSort        = drvSubSort
        ,drvSubSort2       = '2' + CASE WHEN BdmRelationship IN ('SPS', 'SPX', 'DP', 'DMP') THEN 'A'
                                        ELSE 'B' + ISNULL(ConSSN,ConNameFirst)
                                   END + CONVERT(char(8),ISNULL(ConDateOfBirth,''),112) + ConSystemID
        ,drvSubSort3       = drvSubSort3
    INTO dbo.U_EDISPCRCOB_drvTbl_QBDEP
    FROM dbo.U_EDISPCRCOB_drvTbl_QB WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EDISPCRCOB WITH (NOLOCK)
        ON BdmEEID = drvEEID
       AND BdmCoID = drvCoID
    JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = BdmEEID
       AND ConSystemID = BdmDepRecID
    WHERE BdmRunID = 'QB'
      AND BdmIsPQB = 'N';

    ------------------
    -- QBDEPENDENTPLANINITIAL DETAIL RECORD
    ------------------
    IF OBJECT_ID('U_EDISPCRCOB_drvTbl_QBDEPPLAN') IS NOT NULL
        DROP TABLE dbo.U_EDISPCRCOB_drvTbl_QBDEPPLAN;
    SELECT DISTINCT
         drvEEID        = BdmEEID
        ,drvCoID        = BdmCoID
        ,drvDepRecID    = BdmDepRecID
        ,drvDedCode     = BdmDedCode
        ,drvPlanName    = CASE BdmDedCode 
                                WHEN 'DENH' THEN 'MetLife Dental High DPPO'
                                WHEN 'DENL' THEN 'MetLife Dental Low DPPO'
                                WHEN 'VISH' THEN 'MetLife Vision High PPO'
                                WHEN 'VISL' THEN 'MetLife Vision Low PPO'
                                WHEN 'MEDU4' THEN 'UHC Medical Choice Plus PPO $1000'
                                WHEN 'MEDU3' THEN 'UHC Medical Choice Plus PPO $3000'
                                WHEN 'MEDU2' THEN 'UHC Medical Choice Plus PPO $6000'
                                WHEN 'MEDU1' THEN 'UHC Medical Choice Plus PPO $7150'
                                WHEN 'FSA' THEN 'WEX FSA' END
        ,drvInitialSort = '21'
        ,drvSubSort     = drvSubSort
        ,drvSubSort2    = '2' + CASE WHEN BdmRelationship IN ('SPS', 'SPX', 'DP', 'DMP') THEN 'A'
                                     ELSE 'B' + RTRIM(ISNULL(ConSSN,ConNameFirst))
                                END + CONVERT(char(8),ISNULL(ConDateOfBirth,''),112) + ConSystemID + BdmDedCode
        ,drvSubSort3    = drvSubSort3
    INTO dbo.U_EDISPCRCOB_drvTbl_QBDEPPLAN
    FROM dbo.U_EDISPCRCOB_drvTbl_QBPLAN WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EDISPCRCOB WITH (NOLOCK)
        ON BdmEEID = drvEEID
       AND BdmCoID = drvCoID
       AND BdmDedCode = drvDedCode
    JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = BdmEEID
       AND ConSystemID = BdmDepRecID
    WHERE BdmRunID = 'QB'
      AND BdmIsPQB = 'N';

     ------------------
    -- QBSTATEINSERTS DETAIL RECORD -- MN-CONTINSERT
    ------------------

    IF OBJECT_ID('U_EDISPCRCOB_drvTbl_QBSTATEINSERT') IS NOT NULL
        DROP TABLE dbo.U_EDISPCRCOB_drvTbl_QBSTATEINSERT;
    SELECT DISTINCT
         drvEEID        = drvEEID
        ,drvCoID        = drvCoID
        ,drvDepRecID    = drvDepRecID
        ,drvStateSpecDocName = CASE EepAddressState 
                                WHEN 'CA' THEN 'CA-SRINSERT'
                                WHEN 'CT' THEN 'CT-SRINSERT'
                                WHEN 'OR' THEN 'OR-SRINSERT'
                                WHEN 'TX' THEN 'TX-SRINSERT'
                                WHEN 'NY' THEN 'NY-SRINSERT'
                                WHEN 'IL' THEN 'IL-SRINSERT'
                                WHEN 'RI' THEN 'RI-SRINSERT'
                                WHEN 'GA' THEN 'GA-SRINSERT'
                                WHEN 'VA' THEN 'VA-SRINSERT'
                                WHEN 'MN' THEN 'MN-CONTINSERT' -- 2ND INSERT BELOW
                                END
        ,drvInitialSort = '21'
        ,drvSubSort     = drvSubSort
        ,drvSubSort2    = '4'
        ,drvSubSort3    = drvSubSort3
    INTO dbo.U_EDISPCRCOB_drvTbl_QBSTATEINSERT
    FROM dbo.U_EDISPCRCOB_drvTbl_QBPLAN WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EDISPCRCOB WITH (NOLOCK)
        ON BdmEEID = drvEEID
       AND BdmCoID = drvCoID
       AND ISNULL(BdmDepRecID,'') = drvDepRecID
       AND BdmDedCode = drvDedCode
    JOIN dbo.EmpPers WITH(NOLOCK)
    ON EepEEID = drvEEID 
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = BdmEEID
       AND EecCoID = BdmCoID
    WHERE BdmRunID = 'QB'
    AND EepAddressState IN ('CA', 'CT', 'OR', 'TX', 'NY', 'IL', 'RI', 'GA', 'VA', 'MN');

      ------------------
    -- QBSTATEINSERTS DETAIL RECORD -- MN-LIFEINSERT
    ------------------

    INSERT INTO dbo.U_EDISPCRCOB_drvTbl_QBSTATEINSERT
    SELECT DISTINCT
         drvEEID  
        ,drvCoID  
        ,drvDepRecID 
        ,drvStateSpecDocName = 'MN-LIFEINSERT'
        ,drvInitialSort 
        ,drvSubSort   
        ,drvSubSort2   
        ,drvSubSort3    
    --INTO dbo.U_EDISPCRCOB_drvTbl_QBSTATEINSERT
    FROM dbo.U_EDISPCRCOB_drvTbl_QBSTATEINSERT WITH (NOLOCK)
    JOIN dbo.EmpPers WITH(NOLOCK)
    ON EepEEID = drvEEID
    WHERE EepAddressState = 'MN'

    ------------------
    -- QBPLANMEMBERSPECIFICRATEINITIAL DETAIL RECORD
    ----------------
    IF OBJECT_ID('U_EDISPCRCOB_drvTbl_QBMSRI') IS NOT NULL
        DROP TABLE dbo.U_EDISPCRCOB_drvTbl_QBMSRI;
    SELECT DISTINCT
         drvEEID        = drvEEID
        ,drvCoID        = drvCoID
        ,drvDepRecID    = drvDepRecID
        ,drvPlanName    = drvPlanName
        ,drvRate        = BdmEEAmt
		--CASE WHEN EecPayPeriod = 'M' THEN BdmEEAmt
  --                             WHEN EecPayPeriod = 'S' THEN BdmEEAmt * 2
  --                             WHEN EecPayPeriod = 'B' THEN BdmEEAmt * 26/12
  --                             WHEN EecPayPeriod = 'W' THEN BdmEEAmt * 52/12
  --                        END
        ,drvInitialSort = '21'
        ,drvSubSort     = drvSubSort
        ,drvSubSort2    = '3'
        ,drvSubSort3    = drvSubSort3
    INTO dbo.U_EDISPCRCOB_drvTbl_QBMSRI
    FROM dbo.U_EDISPCRCOB_drvTbl_QBPLAN WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EDISPCRCOB WITH (NOLOCK)
        ON BdmEEID = drvEEID
       AND BdmCoID = drvCoID
       AND ISNULL(BdmDepRecID,'') = drvDepRecID
       AND BdmDedCode = drvDedCode
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = BdmEEID
       AND EecCoID = BdmCoID
    WHERE BdmRunID = 'QB'
      AND BdmIsPQB = 'Y'
      AND BdmDedType = 'FSA';


     --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'NWOS_EDISPCRCOB_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'NWOS_EDISPCRCOB_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'NWOS_EDISPCRCOB_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END
END;
/*
--Alter the View
ALTER VIEW dbo.dsi_vwEDISPCRCOB_Export AS
    SELECT TOP 2000000 Data
    FROM dbo.U_EDISPCRCOB_File WITH (NOLOCK)
    ORDER BY InitialSort, SubSort, SubSort2, SubSort3, RecordSet;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EDISPCRCOB%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
SET expLastStartPerControl = '201601251'
   ,expStartPerControl     = '201601251'
   ,expLastEndPerControl   = '201602039'
   ,expEndPerControl       = '201602039'
WHERE expFormatCode = 'EDISPCRCOB'
  AND expExportCode LIKE 'TEST%';
*/
SET NOCOUNT OFF;
GO
CREATE VIEW dbo.dsi_vwEDISPCRCOB_Export AS
    SELECT TOP 2000000 Data
    FROM dbo.U_EDISPCRCOB_File WITH (NOLOCK)
    ORDER BY InitialSort, SubSort, SubSort2, SubSort3, RecordSet;