SET NOCOUNT ON;
IF OBJECT_ID('U_EAMFLCOBRA_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EAMFLCOBRA_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EAMFLCOBRA_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EAMFLCOBRA' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEAMFLCOBRA_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEAMFLCOBRA_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EAMFLCOBRA') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EAMFLCOBRA];
GO
IF OBJECT_ID('U_EAMFLCOBRA_File') IS NOT NULL DROP TABLE [dbo].[U_EAMFLCOBRA_File];
GO
IF OBJECT_ID('U_EAMFLCOBRA_EEList') IS NOT NULL DROP TABLE [dbo].[U_EAMFLCOBRA_EEList];
GO
IF OBJECT_ID('U_EAMFLCOBRA_drvTbl_QBPLAN') IS NOT NULL DROP TABLE [dbo].[U_EAMFLCOBRA_drvTbl_QBPLAN];
GO
IF OBJECT_ID('U_EAMFLCOBRA_drvTbl_QBEVENT') IS NOT NULL DROP TABLE [dbo].[U_EAMFLCOBRA_drvTbl_QBEVENT];
GO
IF OBJECT_ID('U_EAMFLCOBRA_drvTbl_QBDEPPLAN') IS NOT NULL DROP TABLE [dbo].[U_EAMFLCOBRA_drvTbl_QBDEPPLAN];
GO
IF OBJECT_ID('U_EAMFLCOBRA_drvTbl_QBDEP') IS NOT NULL DROP TABLE [dbo].[U_EAMFLCOBRA_drvTbl_QBDEP];
GO
IF OBJECT_ID('U_EAMFLCOBRA_drvTbl_QB') IS NOT NULL DROP TABLE [dbo].[U_EAMFLCOBRA_drvTbl_QB];
GO
IF OBJECT_ID('U_EAMFLCOBRA_DedList') IS NOT NULL DROP TABLE [dbo].[U_EAMFLCOBRA_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EAMFLCOBRA') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EAMFLCOBRA];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EAMFLCOBRA';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EAMFLCOBRA';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EAMFLCOBRA';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EAMFLCOBRA';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EAMFLCOBRA';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EAMFLCOBRA','Ameriflex Benefits Cobra Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','EAMFLCOBRAZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EAMFLCOBRA' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[VERSION]"','1','(''DA''=''T,'')','EAMFLCOBRAZ0','50','H','01','1',NULL,'Version Line Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"1.1"','2','(''DA''=''T'')','EAMFLCOBRAZ0','50','H','01','2',NULL,'Version Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QB]"','1','(''DA''=''T,'')','EAMFLCOBRAZ0','50','D','20','1',NULL,'Record Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientName"','2','(''UA''=''T,'')','EAMFLCOBRAZ0','50','D','20','2',NULL,'ClientName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientDivName"','3','(''UA''=''T,'')','EAMFLCOBRAZ0','50','D','20','3',NULL,'ClientDivisionName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','4','(''SS''=''T,'')','EAMFLCOBRAZ0','50','D','20','4',NULL,'Salutation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','5','(''UA''=''T,'')','EAMFLCOBRAZ0','50','D','20','5',NULL,'FirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','6','(''UA''=''T,'')','EAMFLCOBRAZ0','50','D','20','6',NULL,'MiddleInitial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','7','(''UA''=''T,'')','EAMFLCOBRAZ0','50','D','20','7',NULL,'LastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','8','(''UA''=''T,'')','EAMFLCOBRAZ0','50','D','20','8',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpNo"','9','(''UA''=''T,'')','EAMFLCOBRAZ0','50','D','20','9',NULL,'IndividualID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''SS''=''T,'')','EAMFLCOBRAZ0','50','D','20','10',NULL,'Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','11','(''SS''=''T,'')','EAMFLCOBRAZ0','50','D','20','11',NULL,'Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','12','(''SS''=''T,'')','EAMFLCOBRAZ0','50','D','20','12',NULL,'Phone2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','13','(''UA''=''T,'')','EAMFLCOBRAZ0','50','D','20','13',NULL,'Address1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','14','(''UA''=''T,'')','EAMFLCOBRAZ0','50','D','20','14',NULL,'Address2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','15','(''UA''=''T,'')','EAMFLCOBRAZ0','50','D','20','15',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','16','(''UA''=''T,'')','EAMFLCOBRAZ0','50','D','20','16',NULL,'StateOrProvince',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','17','(''UA''=''T,'')','EAMFLCOBRAZ0','50','D','20','17',NULL,'PostalCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''SS''=''T,'')','EAMFLCOBRAZ0','50','D','20','18',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TRUE"','19','(''DA''=''T,'')','EAMFLCOBRAZ0','50','D','20','19',NULL,'PremiumAddressSameAsPrimary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','20','(''SS''=''T,'')','EAMFLCOBRAZ0','50','D','20','20',NULL,'PremiumAddress1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','21','(''SS''=''T,'')','EAMFLCOBRAZ0','50','D','20','21',NULL,'PremiumAddress2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','22','(''SS''=''T,'')','EAMFLCOBRAZ0','50','D','20','22',NULL,'PremiumCity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','23','(''SS''=''T,'')','EAMFLCOBRAZ0','50','D','20','23',NULL,'PremiumStateOrProvince',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','24','(''SS''=''T,'')','EAMFLCOBRAZ0','50','D','20','24',NULL,'PremiumPostalCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','25','(''SS''=''T,'')','EAMFLCOBRAZ0','50','D','20','25',NULL,'PremiumCountry',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','26','(''UA''=''T,'')','EAMFLCOBRAZ0','50','D','20','26',NULL,'Sex',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','27','(''UD101''=''T,'')','EAMFLCOBRAZ0','50','D','20','27',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"UNKNOWN"','28','(''DA''=''T,'')','EAMFLCOBRAZ0','50','D','20','28',NULL,'TobaccoUse',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FTE"','29','(''DA''=''T,'')','EAMFLCOBRAZ0','50','D','20','29',NULL,'EmployeeType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"UNKNOWN"','30','(''DA''=''T,'')','EAMFLCOBRAZ0','50','D','20','30',NULL,'EmployeePayrollType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','31','(''SS''=''T,'')','EAMFLCOBRAZ0','50','D','20','31',NULL,'YearsOfService',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"COUPONBOOK"','32','(''DA''=''T,'')','EAMFLCOBRAZ0','50','D','20','32',NULL,'PremiumCouponType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','33','(''DA''=''T,'')','EAMFLCOBRAZ0','50','D','20','33',NULL,'UsesHCTC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TRUE"','34','(''DA''=''T,'')','EAMFLCOBRAZ0','50','D','20','34',NULL,'Active',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','35','(''SS''=''T,'')','EAMFLCOBRAZ0','50','D','20','35',NULL,'AllowMemberSSO',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','36','(''SS''=''T,'')','EAMFLCOBRAZ0','50','D','20','36',NULL,'BenefitGroup',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','37','(''SS''=''T,'')','EAMFLCOBRAZ0','50','D','20','37',NULL,'AccountStructure',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','38','(''SS''=''T'')','EAMFLCOBRAZ0','50','D','20','38',NULL,'ClientSpecificData',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBEVENT]"','1','(''DA''=''T,'')','EAMFLCOBRAZ0','50','D','30','1',NULL,'Record Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEventType"','2','(''UA''=''T,'')','EAMFLCOBRAZ0','50','D','30','2',NULL,'EventType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEventDate"','3','(''UD101''=''T,'')','EAMFLCOBRAZ0','50','D','30','3',NULL,'EventDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrollmentDate"','4','(''UD101''=''T,'')','EAMFLCOBRAZ0','50','D','30','4',NULL,'EnrollmentDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','5','(''UA''=''T,'')','EAMFLCOBRAZ0','50','D','30','5',NULL,'EmployeeSSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvName"','6','(''UA''=''T,'')','EAMFLCOBRAZ0','50','D','30','6',NULL,'EmployeeName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','7','(''SS''=''T'')','EAMFLCOBRAZ0','50','D','30','7',NULL,'SecondEventOriginalFDOC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBPLAN]"','1','(''DA''=''T,'')','EAMFLCOBRAZ0','50','D','40','1',NULL,'Record Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanName"','2','(''UA''=''T,'')','EAMFLCOBRAZ0','50','D','40','2',NULL,'PlanName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStartDate"','3','(''UD101''=''T,'')','EAMFLCOBRAZ0','50','D','40','3',NULL,'StartDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','4','(''SS''=''T,'')','EAMFLCOBRAZ0','50','D','40','4',NULL,'EndDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageLevel"','5','(''UA''=''T,'')','EAMFLCOBRAZ0','50','D','40','5',NULL,'CoverageLevel',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','6','(''SS''=''T,'')','EAMFLCOBRAZ0','50','D','40','6',NULL,'FirstDayOfCOBRA',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','7','(''SS''=''T,'')','EAMFLCOBRAZ0','50','D','40','7',NULL,'LastDayOfCOBRA',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''SS''=''T,'')','EAMFLCOBRAZ0','50','D','40','8',NULL,'COBRADurationMonths',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''SS''=''T,'')','EAMFLCOBRAZ0','50','D','40','9',NULL,'DaysToElect',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''SS''=''T,'')','EAMFLCOBRAZ0','50','D','40','10',NULL,'DaysToMake1stPayment',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','11','(''SS''=''T,'')','EAMFLCOBRAZ0','50','D','40','11',NULL,'DaysToMakeSubsequentPayments',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','12','(''SS''=''T,'')','EAMFLCOBRAZ0','50','D','40','12',NULL,'ElectionPostmarkDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','13','(''SS''=''T,'')','EAMFLCOBRAZ0','50','D','40','13',NULL,'LastDateRatesNotified',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','14','(''SS''=''T,'')','EAMFLCOBRAZ0','50','D','40','14',NULL,'NumberOfUnits',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FALSE"','15','(''DA''=''T,'')','EAMFLCOBRAZ0','50','D','40','15',NULL,'SendPlanChangeLetterForLegacy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBundleName"','16','(''UA''=''T'')','EAMFLCOBRAZ0','50','D','40','16',NULL,'PlanBundleName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBDEPENDENT]"','1','(''DA''=''T,'')','EAMFLCOBRAZ0','50','D','50','1',NULL,'Record Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','2','(''UA''=''T,'')','EAMFLCOBRAZ0','50','D','50','2',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelationship"','3','(''UA''=''T,'')','EAMFLCOBRAZ0','50','D','50','3',NULL,'Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','4','(''SS''=''T,'')','EAMFLCOBRAZ0','50','D','50','4',NULL,'Salutation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','5','(''UA''=''T,'')','EAMFLCOBRAZ0','50','D','50','5',NULL,'FirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','6','(''UA''=''T,'')','EAMFLCOBRAZ0','50','D','50','6',NULL,'MiddleInitial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','7','(''UA''=''T,'')','EAMFLCOBRAZ0','50','D','50','7',NULL,'LastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''SS''=''T,'')','EAMFLCOBRAZ0','50','D','50','8',NULL,'Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''SS''=''T,'')','EAMFLCOBRAZ0','50','D','50','9',NULL,'Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''SS''=''T,'')','EAMFLCOBRAZ0','50','D','50','10',NULL,'Phone2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIsAddressSame"','11','(''UA''=''T,'')','EAMFLCOBRAZ0','50','D','50','11',NULL,'AddressSameAsQB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','12','(''UA''=''T,'')','EAMFLCOBRAZ0','50','D','50','12',NULL,'Address1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','13','(''UA''=''T,'')','EAMFLCOBRAZ0','50','D','50','13',NULL,'Address2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','14','(''UA''=''T,'')','EAMFLCOBRAZ0','50','D','50','14',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','15','(''UA''=''T,'')','EAMFLCOBRAZ0','50','D','50','15',NULL,'StateOrProvince',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','16','(''UA''=''T,'')','EAMFLCOBRAZ0','50','D','50','16',NULL,'PostalCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','17','(''SS''=''T,'')','EAMFLCOBRAZ0','50','D','50','17',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''SS''=''T,'')','EAMFLCOBRAZ0','50','D','50','18',NULL,'EnrollmentDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','19','(''UA''=''T,'')','EAMFLCOBRAZ0','50','D','50','19',NULL,'Sex',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','20','(''UD101''=''T,'')','EAMFLCOBRAZ0','50','D','50','20',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvISQMCO"','21','(''UA''=''T'')','EAMFLCOBRAZ0','50','D','50','21',NULL,'IsQMCSO',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBDEPENDENTPLAN]"','1','(''DA''=''T,'')','EAMFLCOBRAZ0','50','D','60','1',NULL,'Record Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanName"','2','(''UA''=''T,'')','EAMFLCOBRAZ0','50','D','60','2',NULL,'PlanName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStartDate"','3','(''UD101''=''T,'')','EAMFLCOBRAZ0','50','D','60','3',NULL,'StartDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','4','(''SS''=''T,'')','EAMFLCOBRAZ0','50','D','60','4',NULL,'EndDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TRUE"','5','(''DA''=''T'')','EAMFLCOBRAZ0','50','D','60','5',NULL,'UsesFDOC',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EAMFLCOBRA_20210702.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','KU74I,455X6,455QO,455V4,455LJ,454X8,455BC,454NU,45461,9551F,4554E,455IC,455YU,455T2',NULL,NULL,NULL,'Cobra QB Export Tuesday 12noon','202102269','EMPEXPORT','QBFILE','Jan 28 2021 12:00AM','EAMFLCOBRA',NULL,NULL,NULL,'202106299','Jan 28 2021 12:00AM','Dec 30 1899 12:00AM','202106221',NULL,'','','202102221',dbo.fn_GetTimedKey(),NULL,NULL,NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','',NULL,NULL,NULL,NULL,'Test Cobra QB Export','202106299','EMPEXPORT','TESTQB','Jun 30 2021 10:52AM','EAMFLCOBRA',NULL,NULL,NULL,'202106299','Jun  8 2021 12:00AM','Dec 30 1899 12:00AM','202106221','16','','','202106221',dbo.fn_GetTimedKey(),NULL,'LKING15',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAMFLCOBRA','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAMFLCOBRA','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAMFLCOBRA','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAMFLCOBRA','SubSort2','C','drvSubSort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAMFLCOBRA','SubSort3','C','drvSubSort3');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAMFLCOBRA','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAMFLCOBRA','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EAMFLCOBRA' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EAMFLCOBRA' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EAMFLCOBRA_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EAMFLCOBRA_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EAMFLCOBRA','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EAMFLCOBRA','D20','dbo.U_EAMFLCOBRA_drvTbl_QB WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EAMFLCOBRA','D30','dbo.U_EAMFLCOBRA_drvTbl_QBEVENT WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EAMFLCOBRA','D40','dbo.U_EAMFLCOBRA_drvTbl_QBPLAN WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EAMFLCOBRA','D50','dbo.U_EAMFLCOBRA_drvTbl_QBDEP WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EAMFLCOBRA','D60','dbo.U_EAMFLCOBRA_drvTbl_QBDEPPLAN WITH (NOLOCK)',NULL);
IF OBJECT_ID('U_dsi_BDM_EAMFLCOBRA') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EAMFLCOBRA] (
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
IF OBJECT_ID('U_EAMFLCOBRA_DedList') IS NULL
CREATE TABLE [dbo].[U_EAMFLCOBRA_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EAMFLCOBRA_drvTbl_QB') IS NULL
CREATE TABLE [dbo].[U_EAMFLCOBRA_drvTbl_QB] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NOT NULL,
    [drvClientName] varchar(100) NULL,
    [drvClientDivName] char(5) NULL,
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
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(208) NULL
);
IF OBJECT_ID('U_EAMFLCOBRA_drvTbl_QBDEP') IS NULL
CREATE TABLE [dbo].[U_EAMFLCOBRA_drvTbl_QBDEP] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NULL,
    [drvSSN] char(11) NOT NULL,
    [drvRelationship] varchar(6) NULL,
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
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(33) NULL,
    [drvSubSort3] varchar(208) NULL
);
IF OBJECT_ID('U_EAMFLCOBRA_drvTbl_QBDEPPLAN') IS NULL
CREATE TABLE [dbo].[U_EAMFLCOBRA_drvTbl_QBDEPPLAN] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NULL,
    [drvDedCode] char(5) NULL,
    [drvPlanName] varchar(38) NULL,
    [drvStartDate] datetime NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(38) NULL,
    [drvSubSort3] varchar(208) NULL
);
IF OBJECT_ID('U_EAMFLCOBRA_drvTbl_QBEVENT') IS NULL
CREATE TABLE [dbo].[U_EAMFLCOBRA_drvTbl_QBEVENT] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NOT NULL,
    [drvEventType] varchar(29) NULL,
    [drvEventDate] datetime NULL,
    [drvEnrollmentDate] datetime NULL,
    [drvSSN] char(11) NULL,
    [drvName] varchar(201) NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(208) NULL
);
IF OBJECT_ID('U_EAMFLCOBRA_drvTbl_QBPLAN') IS NULL
CREATE TABLE [dbo].[U_EAMFLCOBRA_drvTbl_QBPLAN] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NOT NULL,
    [drvDedCode] char(5) NULL,
    [drvPlanName] varchar(38) NULL,
    [drvStartDate] datetime NULL,
    [drvCoverageLevel] varchar(11) NULL,
    [drvBundleName] varchar(1) NOT NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(6) NULL,
    [drvSubSort3] varchar(208) NULL
);
IF OBJECT_ID('U_EAMFLCOBRA_EEList') IS NULL
CREATE TABLE [dbo].[U_EAMFLCOBRA_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EAMFLCOBRA_File') IS NULL
CREATE TABLE [dbo].[U_EAMFLCOBRA_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EAMFLCOBRA]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Presbyterian Senior Living

Created By: Inshan Singh
Business Analyst: Lea King
Create Date: 01/20/2021
Service Request Number: TekP-2020-10-07-0004 

Purpose: Ameriflex Benefits Cobra Export

Revision History
----------------
Update By            Date           Request Num        Desc
XXXX                 XX/XX/xxxx     SR-20XX-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EAMFLCOBRA';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EAMFLCOBRA';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EAMFLCOBRA';
SELECT * FROM dbo.AscExp WHERE expFormatCode = 'EAMFLCOBRA';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EAMFLCOBRA' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAMFLCOBRA', 'QBFILE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAMFLCOBRA', 'TESTQB';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EAMFLCOBRA';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EAMFLCOBRA', @AllObjects = 'Y', @IsWeb = 'Y';
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
    SET @FormatCode = 'EAMFLCOBRA';

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
    DELETE FROM dbo.U_EAMFLCOBRA_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCoID(xEEID)
      AND xEEID IN (SELECT xEEID FROM dbo.U_EAMFLCOBRA_EEList GROUP BY xEEID HAVING COUNT(1) > 1);



    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'DENT2, DENT1, VIS'  ;

    IF OBJECT_ID('U_EAMFLCOBRA_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EAMFLCOBRA_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EAMFLCOBRA_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;



        --==========================================
        -- BDM Section for QB
        --==========================================
        DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

        -- Required parameters
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'StartDateTime',@StartDate);
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'EndDateTime',@EndDate);
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'TermSelectionOption','AuditDate');

        -- COBRA parameters
        --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RunID','QB');
        --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','Y'); -- DedIsCobraCovered = 'Y'
        --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraType','4'); -- Eep/ConCobraReason first, then EdhChangeReason. Include CHGRP for elig. ben groups
        --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraDate','3'); -- EedBenStopDate and DbnBenStopDate, unless Eep/ConDateOfCOBRAEvent exists
        --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraPQBType','1'); -- If no EE or spouse, ALL children are PQB (not just oldest)
        --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraReasonsDepPQB','201,204,210,LEVNT3,LEVNT4'); -- Valid dependent PQB reasons
        --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidCobraReasonsEmp','201,204,210,LEVNT3,LEVNT4'); -- Invalidate employee when Cobra Reason is a dependent PQB reason
        --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidTermReasonsEmp','203'); -- Invalidate employee when Cobra Reason is "Death"
        --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'ConCobraReasonPCF','DependentCOBRAReason'); -- Valid dependent PQB reasons
        --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CountDependents','Y');
        --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS');
        --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL,FTS,STC');
        --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP');
        --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');


         -- COBRA parameters
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RunID','QB');
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','Y'); -- DedIsCobraCovered = 'Y'
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraType','4'); -- Eep/ConCobraReason first, then EdhChangeReason. Include CHGRP for elig. ben groups
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraDate','3'); -- EedBenStopDate and DbnBenStopDate, unless Eep/ConDateOfCOBRAEvent exists
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraPQBType','1'); -- If no EE or spouse, ALL children are PQB (not just oldest)
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraReasonsDepPQB','201,204,210,LEVNT3,LEVNT4'); -- Valid dependent PQB reasons
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidCobraReasonsEmp','201,204,210,LEVNT3,LEVNT4'); -- Invalidate employee when Cobra Reason is a dependent PQB reason
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidTermReasonsEmp','203,210'); -- Invalidate employee when Cobra Reason is "Death"
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'ConCobraReasonPCF','DependentCOBRAReason'); -- Valid dependent PQB reasons
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CountDependents','Y');
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS');
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL,DPC,STC,DCH,FTS');
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP');
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
        INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'GetChangeReason', 'Y')

        -- Run BDM for QB
        EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;


--==========================================
 -- Insert into BDM Reason code 201 and 204
 --==========================================
    INSERT INTO [dbo].[U_dsi_BDM_EAMFLCOBRA]
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
           ,[BdmBenStartDate]
           ,[BdmBenStopDate]
           ,[BdmBenStatusDate]
           ,[BdmChangeReason]
           ,[BdmStartDate]
           ,[BdmStopDate]
           ,[BdmIsPQB]

    )
 Select rectype = 'DEP', EdhCoid, EdhEEID, DbnDepRecID, DbnDepRecID, 'QB', 'Data Inserted for 204 Chg reason', 
            DbnRelationship, DbnDateOfBirth, EdhDedCode, edhBenStartDate,EdhDateTimeCreated, edhBenStatusDate,'204'
            ,edhStartDate, edhStopDate, CASE WHEN dbnRelationShip = 'SPS' THEN 'Y' ELSE 'N' END
            from dbo.emphded with (nolock)
            JOIN dbo.U_dsi_BDM_DepDeductions on dbneeid = edheeid and dbnformatcode = @formatcode AND EdhDedCode = DbnDedCode
            WHERE edhChangeReason in ('204') and DbnBenStatusDate between @startdate and @enddate and dbnValidForExport = 'N'

    
INSERT INTO [dbo].[U_dsi_BDM_EAMFLCOBRA]
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
           ,[BdmBenStartDate]
           ,[BdmBenStopDate]
           ,[BdmBenStatusDate]
           ,[BdmChangeReason]
           ,[BdmStartDate]
           ,[BdmStopDate]
           ,[BdmIsPQB]

    )
 Select rectype = 'DEP', EdhCoid, EdhEEID, DbnDepRecID, DbnDepRecID, 'QB', 'Data Inserted for 201 Chg reason', 
            DbnRelationship, DbnDateOfBirth, EdhDedCode, edhBenStartDate,EdhDateTimeCreated, edhBenStatusDate,'201'
            ,edhStartDate, edhStopDate, 'Y'
            from dbo.emphded with (nolock)
            JOIN dbo.U_dsi_BDM_DepDeductions on dbneeid = edheeid and dbnformatcode = @formatcode AND EdhDedCode = DbnDedCode
            WHERE edhChangeReason in ('201') and DbnBenStatusDate between @startdate and @enddate and dbnValidForExport = 'Y' -- 'N'
    


  INSERT INTO [dbo].[U_dsi_BDM_EAMFLCOBRA]
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
           ,[BdmBenStartDate]
           ,[BdmBenStopDate]
           ,[BdmBenStatusDate]
           ,[BdmChangeReason]
           ,[BdmStartDate]
           ,[BdmStopDate]
           ,[BdmIsPQB]

    )
 Select rectype = 'DEP', EdhCoid, EdhEEID, DbnDepRecID, DbnDepRecID, 'QB', 'Data Inserted for 210 Chg reason', 
            DbnRelationship, DbnDateOfBirth, EdhDedCode, edhBenStartDate,EdhDateTimeCreated, edhBenStatusDate,'210'
            ,edhStartDate, edhStopDate, CASE WHEN dbnRelationShip = 'SPS' THEN 'Y' ELSE 'N' END
            from dbo.emphded with (nolock)
            JOIN dbo.U_dsi_BDM_DepDeductions on dbneeid = edheeid and dbnformatcode = @formatcode AND EdhDedCode = DbnDedCode
            WHERE edhChangeReason in ('210') and DbnBenStatusDate between @startdate and @enddate and dbnValidForExport = 'N'





 Delete from dbo.U_dsi_BDM_EAMFLCOBRA where bdmdedcode not in (Select dedcode from U_EAMFLCOBRA_DedList)
 --Delete from U_dsi_BDM_EAMFLCOBRA where bdmrelationship = 'Z'


    Update dbo.U_dsi_BDM_EAMFLCOBRA 
        set bdmNumSpouses = (
                                select count(distinct BdmDepRecID) 
                                from U_dsi_BDM_EAMFLCOBRA A 
                                where A.bdmeeid = X.bdmeeid 
                                    and bdmRelationship = 'SPS' 
                                    and A.bdmcoid = X.bdmcoid),
            bdmNumChildren = (
                                select count(distinct BdmDepRecID) 
                                from U_dsi_BDM_EAMFLCOBRA A 
                                where A.bdmeeid = X.bdmeeid 
                                    and bdmRelationship = 'CHL' 
                                    and A.bdmcoid = X.bdmcoid)
        from dbo.U_dsi_BDM_EAMFLCOBRA X 
        where BdmDedRowStatus IN ('Data Inserted for 204 Chg reason','Data Inserted for 201 Chg reason','Data Inserted for 210 Chg reason')


     DELETE dbo.U_dsi_BDM_EAMFLCOBRA 
     WHERE BdmCobraReason = 'CHGRP';

    --==========================================
    -- Build driver tables
    --==========================================
  
        ------------------
        -- QB DETAIL RECORD
        ------------------
        IF OBJECT_ID('U_EAMFLCOBRA_drvTbl_QB') IS NOT NULL
            DROP TABLE dbo.U_EAMFLCOBRA_drvTbl_QB;
        SELECT DISTINCT
             drvEEID           = BdmEEID
            ,drvCoID           = BdmCoID
            ,drvDepRecID       = ISNULL(BdmDepRecID,'')
            ,drvClientName     = CONVERT(varchar(100),'Presbyterian Senior Living - Div 01')
            ,drvClientDivName  = cmpCompanyCode
                                    --CASE
         --                               WHEN cmpCompanyCode = 'CA' THEN 'Division 4 Cathedral Village'
         --                               WHEN cmpCompanyCode = 'LHOME' THEN 'Presbyterian Senior Living Div 21'
         --                               WHEN cmpCompanyCode = 'LIFE' THEN 'Presbyterian Senior Living Div 17'
         --                               WHEN cmpCompanyCode = 'PHPH' THEN 'Presbyterian Senior Living - Div 09'
         --                               WHEN cmpCompanyCode = 'PRESH' THEN 'Presbyterian Senior Living – Div 01'
         --                               WHEN cmpCompanyCode = 'PSL' THEN 'Presbyterian Senior Living – Div 07'
         --                               WHEN cmpCompanyCode = 'GMRC' THEN 'Presbyterian Senior Living – Div 02'
         --                               WHEN cmpCompanyCode = 'QV' THEN 'Presbyterian Senior Living - Div 16'
                                    --    ELSE cmpCompanyCode
         --                           END
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
            ,drvSubSort        = CASE WHEN BdmRecType = 'EMP' THEN eepSSN
                                      ELSE ISNULL(NULLIF(ConSSN,''),eepSSN) + CONVERT(char(8),ConDateOfBirth,112)
                                 END
            ,drvSubSort2       = '1'
            ,drvSubSort3       = CASE WHEN BdmRecType = 'EMP' THEN '2'
                                      ELSE CONVERT(char(8),ConDateOfBirth,112) + RTRIM(ConNameLast) + ConNameFirst
                                 END
        INTO dbo.U_EAMFLCOBRA_drvTbl_QB
        FROM dbo.U_dsi_BDM_EAMFLCOBRA WITH (NOLOCK)
        JOIN dbo.EmpComp WITH (NOLOCK)
            ON EecEEID = BdmEEID
           AND EecCoID = BdmCoID
        JOIN dbo.EmpPers WITH (NOLOCK)
            ON EepEEID = BdmEEID
        JOIN dbo.Company with (nolock)
            On cmpCOID = bdmCOID
        LEFT JOIN dbo.Contacts WITH (NOLOCK)
            ON ConEEID = BdmEEID
           AND ConSystemID = BdmDepRecID
        WHERE BdmIsPQB = 'Y' 
        --and bdmChangeREason <> 'COB' and EecDateofTermination is not null
        ;

        ------------------
        -- QBEVENT DETAIL RECORD
        ------------------
        IF OBJECT_ID('U_EAMFLCOBRA_drvTbl_QBEVENT') IS NOT NULL
            DROP TABLE dbo.U_EAMFLCOBRA_drvTbl_QBEVENT;
        SELECT DISTINCT
             drvEEID           = drvEEID
            ,drvCoID           = drvCoID
            ,drvDepRecID       = drvDepRecID
            --f edhChangeReason = 204, LEVNT4, 201, LEVNT3 or 210 send dbnbenstopdate else send eedbenstopdate

            ,drvEventType      = CASE   WHEN EecEmplStatus = 'T' and EecTermReason NOT IN ('203') and Eectermtype = 'I' THEN 'INVOLUNTARYTERMINATION'
                                        WHEN EecEmplStatus = 'T'  and EecTermReason NOT IN ('202','203') and Eectermtype = 'V' THEN 'TERMINATION' 
                                        WHEN EecEmplStatus = 'T' and EecTermReason  = '203' OR BdmCobraReason = '210' THEN 'DEATH'
                                        WHEN EecEmplStatus = 'T' and EecTermReason = '202' or BdmCobraReason = '208' THEN 'RETIREMENT'
                                        WHEN BdmChangeReason = 'COB' or bdmCobraReason = 'COB' THEN 'TERMINATION'
                                        WHEN BdmCobraReason IN ('204', 'LEVNT4' ) or BdmChangeReason IN ('204', 'LEVNT4') THEN 'DIVORCELEGALSEPARATION'
                                        WHEN BdmCobraReason IN ('201', 'LEVNT3') or BdmChangeReason IN ('201', 'LEVNT3') THEN 'INELIGIBLEDEPENDENT'
                                        WHEN BdmCobraReason = '205' or BdmChangeReason = '205'THEN 'MEDICARE'
                                        WHEN BdmChangeReason = 'STAT'  or bdmCobraReason =  'STAT' THEN 'REDUCTIONINHOURS-STATUSCHANGE'
                                        WHEN BdmCobraReason IN ('203','202') THEN 'REDUCTIONINHOURS-STATUSCHANGE' 
                                        WHEN BdmCobraReason = '206' THEN 'REDUCTIONINHOURTHENOFLEAVE'
                                   END
            --,drvEventDate      = CASE WHEN BdmCobraReason IN ('204', 'LEVNT4', '201', 'LEVNT3', '210') or BdmChangeReason IN ('204', 'LEVNT4', '201', 'LEVNT3', '210') THEN BdmBenStopDate else BdmDateOfCOBRAEvent END 
            ,drvEventDate      = BdmBenStopDate --CASE WHEN BdmCobraReason IN ('204', 'LEVNT4', '201', 'LEVNT3', '210') or BdmChangeReason IN ('204', 'LEVNT4', '201', 'LEVNT3', '210') THEN BdmBenStopDate else BdmBenStatusDate END 
            ,drvEnrollmentDate = eecdateoforiginalhire --BdmBenStartDate
            ,drvSSN            = eepSSN
            ,drvName           = CASE WHEN BdmRecType = 'DEP' THEN RTRIM(EepNameFirst) + ' ' + EepNameLast
                                      ELSE ''
                                 END
            ,drvSubSort        = drvSubSort
            ,drvSubSort2       = '1'
            ,drvSubSort3       = drvSubSort3
        INTO dbo.U_EAMFLCOBRA_drvTbl_QBEVENT
        FROM dbo.U_EAMFLCOBRA_drvTbl_QB WITH (NOLOCK)
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
                ,BdmChangeReason = MAX(BdmChangeReason)
                ,BdmCobraReason = MAX(BdmCobraReason)
                ,BdmBenStartDate = MIN(BdmBenStartDate)
                ,BdmBenStatusDate = MAX(BdmBenStatusDate)
                ,BdmBenStopDate = MAX(BdmBenStopDate)
                ,BdmDateOfCOBRAEvent = MAX(BdmDateOfCOBRAEvent)
                ,BdmUSGDate1 = MAX(BdmUSGDate1)
              FROM dbo.U_dsi_BDM_EAMFLCOBRA WITH (NOLOCK)
              WHERE BdmIsPQB = 'Y'
              GROUP BY BdmEEID, BdmCoID, BdmDepRecID, BdmRecType) BDM
            ON BdmEEID = drvEEID
           AND BdmCoID = drvCoID
           AND ISNULL(BdmDepRecID,'') = drvDepRecID;

        ------------------
        -- QBPLAN DETAIL RECORD
        ------------------
        IF OBJECT_ID('U_EAMFLCOBRA_drvTbl_QBPLAN') IS NOT NULL
            DROP TABLE dbo.U_EAMFLCOBRA_drvTbl_QBPLAN;
        SELECT DISTINCT
             drvEEID          = drvEEID
            ,drvCoID          = drvCoID
            ,drvDepRecID      = drvDepRecID
            ,drvDedCode       = BdmDedCode
            ,drvPlanName      = CASE
                                    WHEN BdmDedCode = 'DENT1' THEN 'Delta Dental Standard PPO Event' 
                                    WHEN BdmDedCode = 'DENT2' THEN 'Delta Dental Alternate PPO buyup Event'
                                    WHEN BdmDedCode = 'VIS' THEN 'PHI Davis Vision Event'
                                END
            ,drvStartDate     = DATEADD(M,DATEDIFF(M,0,drvEventDate)+1,0)
            ,drvCoverageLevel = CASE 
                                      WHEN BdmChangeReason IN ('204', 'LEVNT4','210' )
                                        or BdmCobraReason IN ('204', 'LEVNT4', '210' ) THEN
                                        CASE WHEN BdmNumChildren = 1 or BdmNumSpouses = 1 then 'EE+CHILD'
                                        WHEN BdmNumChildren > 1 or BdmNumSpouses = 1 then 'EE+CHILDREN'
                                        ELSE 'EE'
                                        END
                                      WHEN BdmChangeReason IN ( '201', 'LEVNT3' )
                                        or BdmCobraReason IN ('201', 'LEVNT3' ) THEN 'EE'
                                     WHEN BdmBenOption IN ('EE', 'BRIECV', 'HIPPEF', 'HIPPEE') THEN 'EE' 
                                     WHEN BdmBenOption IN ('EE3', 'HIPPES', 'HIPPSP','FAMHIP') THEN 'EE+SPOUSE'
                                     WHEN BdmBenOption IN ('EE1', 'HIPPE1','HIPPC1') THEN  'EE+CHILD'
                                     WHEN BdmBenOption IN ('EE2','HIPCS','HIPP2C','HIPPFC','HIPPEC') THEN  'EE+CHILDREN'
                                     WHEN BdmBenOption IN ('FAMILY', 'HIPFAM', 'HIPPE2', 'HIPPE3','HIPPFA','HIPPFM') THEN 'EE+FAMILY'
                                END
            ,drvBundleName    = ''
            ,drvSubSort       = drvSubSort
            ,drvSubSort2      = '1' + BdmDedCode
            ,drvSubSort3      = drvSubSort3
        INTO dbo.U_EAMFLCOBRA_drvTbl_QBPLAN
        FROM dbo.U_EAMFLCOBRA_drvTbl_QBEVENT WITH (NOLOCK)
        JOIN dbo.U_dsi_BDM_EAMFLCOBRA WITH (NOLOCK)
            ON BdmEEID = drvEEID
           AND BdmCoID = drvCoID
           AND ISNULL(BdmDepRecID,'') = drvDepRecID
        --LEFT JOIN dbo.EmpHDed with (nolock)
        --    ON Edheeid = drvEEID and EdhDateTimeCreated between @StartDate and @EndDate and EdhDedCode = BdmDedCode
        WHERE BdmIsPQB = 'Y' --and bdmDedType <> 'MED';

        ---- Insert second row for Pharmacy Bundle
        --INSERT INTO dbo.U_EAMFLCOBRA_drvTbl_QBPLAN
        --SELECT DISTINCT
        --     drvEEID          = drvEEID
        --    ,drvCoID          = drvCoID
        --    ,drvDepRecID      = drvDepRecID
        --    ,drvDedCode       = drvDedCode
        --    ,drvPlanName      = CONVERT(varchar(50),'@AddlPlanName')
        --    ,drvStartDate     = drvStartDate
        --    ,drvCoverageLevel = drvCoverageLevel
        --    ,drvBundleName    = drvBundleName
        --    ,drvSubSort       = drvSubSort
        --    ,drvSubSort2      = drvSubSort2
        --    ,drvSubSort3      = drvSubSort3
        --FROM dbo.U_EAMFLCOBRA_drvTbl_QBPLAN WITH (NOLOCK)
        --WHERE drvBundleName IS NOT NULL;

        ------------------
        -- QBDEPENDENT DETAIL RECORD
        ------------------
        IF OBJECT_ID('U_EAMFLCOBRA_drvTbl_QBDEP') IS NOT NULL
            DROP TABLE dbo.U_EAMFLCOBRA_drvTbl_QBDEP;
        SELECT DISTINCT
             drvEEID           = BdmEEID
            ,drvCoID           = BdmCoID
            ,drvDepRecID       = BdmDepRecID
            ,drvSSN            = ISNULL(ConSSN,'')
            ,drvRelationship   = CASE WHEN BdmRelationship IN ('SPS') THEN 'SPOUSE'
                                      WHEN BdmRelationship IN ('CHL','FTS','STC') THEN 'CHILD'
                                      --ELSE 'CHILD'
                                 END
            ,drvNameFirst      = ConNameFirst
            ,drvNameMiddle     = LEFT(ConNameMiddle,1)
            ,drvNameLast       = ConNameLast
            ,drvIsAddressSame  = 'TRUE'
            ,drvAddressLine1   = '' -- leave blank
            ,drvAddressLine2   = '' -- leave blank
            ,drvAddressCity    = '' -- leave blank
            ,drvAddressState   = '' -- leave blank
            ,drvAddressZipCode = '' -- leave blank
            ,drvGender         = ConGender
            ,drvDateOfBirth    = ConDateOfBirth
            ,drvISQMCO         = 'FALSE'
            ,drvSubSort        = drvSubSort
            ,drvSubSort2       = '2' + CASE WHEN BdmRelationship IN ('SPS','CHL','FTS','STC') THEN 'A'
                                            ELSE 'B' + ISNULL(ConSSN,ConNameFirst)
                                       END + CONVERT(char(8),ISNULL(ConDateOfBirth,''),112) + ConSystemID
            ,drvSubSort3       = drvSubSort3
        INTO dbo.U_EAMFLCOBRA_drvTbl_QBDEP
        FROM dbo.U_EAMFLCOBRA_drvTbl_QB WITH (NOLOCK)
        JOIN dbo.U_dsi_BDM_EAMFLCOBRA WITH (NOLOCK)
            ON BdmEEID = drvEEID
           AND BdmCoID = drvCoID
        JOIN dbo.Contacts WITH (NOLOCK)
            ON ConEEID = BdmEEID
           AND ConSystemID = BdmDepRecID
        WHERE BdmIsPQB = 'N' --and bdmDedType <> 'MED';

        ------------------
        -- QBDEPENDENTPLAN DETAIL RECORD
        ------------------
        IF OBJECT_ID('U_EAMFLCOBRA_drvTbl_QBDEPPLAN') IS NOT NULL
            DROP TABLE dbo.U_EAMFLCOBRA_drvTbl_QBDEPPLAN;
        SELECT DISTINCT
             drvEEID      = BdmEEID
            ,drvCoID      = BdmCoID
            ,drvDepRecID  = BdmDepRecID
            ,drvDedCode   = BdmDedCode
            ,drvPlanName  = drvPlanName
            ,drvStartDate = drvStartDate
            ,drvSubSort   = drvSubSort
            ,drvSubSort2  = '2' + CASE WHEN BdmRelationship IN ('SPS','CHL','FTS','STC') THEN 'A'
                                       ELSE 'B' + RTRIM(ISNULL(ConSSN,ConNameFirst))
                                  END + CONVERT(char(8),ISNULL(ConDateOfBirth,''),112) + ConSystemID + BdmDedCode
            ,drvSubSort3  = drvSubSort3
        INTO dbo.U_EAMFLCOBRA_drvTbl_QBDEPPLAN
        FROM dbo.U_EAMFLCOBRA_drvTbl_QBPLAN WITH (NOLOCK)
        JOIN dbo.U_dsi_BDM_EAMFLCOBRA WITH (NOLOCK)
            ON BdmEEID = drvEEID
           AND BdmCoID = drvCoID
           AND BdmDedCode = drvDedCode
        JOIN dbo.Contacts WITH (NOLOCK)
            ON ConEEID = BdmEEID
           AND ConSystemID = BdmDepRecID
        WHERE BdmIsPQB = 'N';

        ------------------
        -- QBPLANMEMBERSPECIFICRATE DETAIL RECORD
        ------------------
        --IF OBJECT_ID('U_EAMFLCOBRA_drvTbl_QBMSRI') IS NOT NULL
        --    DROP TABLE dbo.U_EAMFLCOBRA_drvTbl_QBMSRI;
        --SELECT DISTINCT
        --     drvEEID      = drvEEID
        --    ,drvCoID      = drvCoID
        --    ,drvDepRecID  = drvDepRecID
        --    ,drvPlanName  = drvPlanName
        --    ,drvStartDate = drvStartDate
        --    ,drvRate      = CASE WHEN EecPayPeriod = 'M' THEN BdmEEAmt
        --                         WHEN EecPayPeriod = 'S' THEN BdmEEAmt * 2
        --                         WHEN EecPayPeriod = 'B' THEN BdmEEAmt * 26/12
        --                         WHEN EecPayPeriod = 'W' THEN BdmEEAmt * 52/12
        --                    END
        --    ,drvSubSort   = drvSubSort
        --    ,drvSubSort2  = '3'
        --    ,drvSubSort3  = drvSubSort3
        --INTO dbo.U_EAMFLCOBRA_drvTbl_QBMSRI
        --FROM dbo.U_EAMFLCOBRA_drvTbl_QBPLAN WITH (NOLOCK)
        --JOIN dbo.U_dsi_BDM_EAMFLCOBRA WITH (NOLOCK)
        --    ON BdmEEID = drvEEID
        --   AND BdmCoID = drvCoID
        --   AND ISNULL(BdmDepRecID,'') = drvDepRecID
        --   AND BdmDedCode = drvDedCode
        --JOIN dbo.EmpComp WITH (NOLOCK)
        --    ON EecEEID = BdmEEID
        --   AND EecCoID = BdmCoID
        --WHERE BdmIsPQB = 'Y'
        --  AND BdmDedType = 'FSA';


    --==========================================
    -- Set filename
    --==========================================
    DECLARE @YYYYMMDD varchar(14);
    SET @YYYYMMDD = CONVERT(char(8),GETDATE(),112);
  

    --IF dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' OR LEFT(@ExportCode, 4) = 'TEST' BEGIN
    --    SET @YYYYMMDD = 'TEST_' + @YYYYMMDD;
    --END
     IF (dbo.dsi_fnVariable('EAMFLCOBRA','UseFileName') = 'N')
     BEGIN
        UPDATE dbo.U_dsi_Parameters
        SET ExportFile = CASE
                              WHEN @ExportCode LIKE '%QB%'  THEN @YYYYMMDD + '_'+ @FormatCode +'_QB_.txt'
                              ELSE ''
                         END
        WHERE FormatCode = @FormatCode;
     END

END;
/*
--Alter the View
ALTER VIEW dbo.dsi_vwEAMFLCOBRA_Export AS
    SELECT TOP 2000000 Data
    FROM dbo.U_EAMFLCOBRA_File WITH (NOLOCK)
    ORDER BY InitialSort, SubSort, SubSort2, SubSort3, RecordSet;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EAMFLCOBRA%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202106221'
       ,expStartPerControl     = '202106221'
       ,expLastEndPerControl   = '202106299'
       ,expEndPerControl       = '202106299'
WHERE expFormatCode = 'EAMFLCOBRA'
  AND expExportCode LIKE '%TEST%';
*/ --202003011 09:15:48.333
--2020-04-01 00:00:00.000
SET NOCOUNT OFF;
GO
CREATE VIEW dbo.dsi_vwEAMFLCOBRA_Export AS
    SELECT TOP 2000000 Data
    FROM dbo.U_EAMFLCOBRA_File WITH (NOLOCK)
    ORDER BY InitialSort, SubSort, SubSort2, SubSort3, RecordSet;