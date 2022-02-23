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
IF OBJECT_ID('U_dsi_BDM_EDISCCOBRA') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EDISCCOBRA];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EDISCCOBRA';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EDISCCOBRA';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EDISCCOBRA';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EDISCCOBRA';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EDISCCOBRA';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EDISCCOBRA','Discovery Benefits Cobra Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','EDISCCOBRAZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[VERSION]"','1','(''DA''=''Q,'')','EDISCCOBRAZ0','50','H','01','1',NULL,'Version Line Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"1.1"','2','(''DA''=''Q'')','EDISCCOBRAZ0','50','H','01','2',NULL,'Version Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QB]"','1','(''DA''=''Q,'')','EDISCCOBRAZ0','50','D','10','1',NULL,'Record Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientName"','2','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','10','2',NULL,'ClientName',NULL,NULL);
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
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTobaccoUse"','28','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','10','28',NULL,'TobaccoUse',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FTE"','29','(''DA''=''Q,'')','EDISCCOBRAZ0','50','D','10','29',NULL,'EmployeeType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpPayType"','30','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','10','30',NULL,'EmployeePayrollType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','31','(''SS''=''Q,'')','EDISCCOBRAZ0','50','D','10','31',NULL,'YearsOfService',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"COUPONBOOK"','32','(''DA''=''Q,'')','EDISCCOBRAZ0','50','D','10','32',NULL,'PremiumCouponType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','33','(''DA''=''Q,'')','EDISCCOBRAZ0','50','D','10','33',NULL,'UsesHCTC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TRUE"','34','(''DA''=''Q,'')','EDISCCOBRAZ0','50','D','10','34',NULL,'Active',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FALSE"','35','(''DA''=''Q,'')','EDISCCOBRAZ0','50','D','10','35',NULL,'AllowMemberSSO',NULL,NULL);
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
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientName"','4','(''UA''=''Q,'')','EDISCCOBRAZ0','50','D','70','4',NULL,'ClientName',NULL,NULL);
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
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EDISCCOBRA_20200327.txt',NULL,'','','',NULL,NULL,NULL,'Scheduled Export','202002249','EMPEXPORT','SCHEDULED','Feb 24 2020  2:20PM','EDISCCOBRA',NULL,NULL,NULL,'202002249','Jan 13 2016  8:53AM','Jan 13 2016  8:53AM','202002101','26','','','202002101',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EDISCCOBRA_20200327.txt',NULL,'','','',NULL,NULL,NULL,'NPM/Cobra Export','202002249','EMPEXPORT','ONDEMAND','Feb 24 2020  2:10PM','EDISCCOBRA',NULL,NULL,NULL,'202002249','Feb 24 2020 12:00AM','Dec 30 1899 12:00AM','202001011','102','','','202001011',dbo.fn_GetTimedKey(),NULL,'us3mLaRED1015',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EDISCCOBRA_20200327.txt',NULL,'','','',NULL,NULL,NULL,'Test NPM/Cobra Export','202003319','EMPEXPORT','TEST','Mar 16 2020 10:57AM','EDISCCOBRA',NULL,NULL,NULL,'202003319','Mar 31 2020 12:00AM','Dec 30 1899 12:00AM','202001011','169','','','202001011',dbo.fn_GetTimedKey(),NULL,'us3lKiRED1015',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EDISCCOBRA_20200327.txt' END WHERE expFormatCode = 'EDISCCOBRA';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCCOBRA','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCCOBRA','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCCOBRA','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCCOBRA','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCCOBRA','SubSort2','C','drvSubSort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCCOBRA','SubSort3','C','drvSubSort3');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCCOBRA','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCCOBRA','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EDISCCOBRA' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EDISCCOBRA' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EDISCCOBRA_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EDISCCOBRA_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCCOBRA','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCCOBRA','D10','dbo.U_EDISCCOBRA_drvTbl_QB WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCCOBRA','D20','dbo.U_EDISCCOBRA_drvTbl_QBEVENT WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCCOBRA','D30','dbo.U_EDISCCOBRA_drvTbl_QBPLAN WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCCOBRA','D40','dbo.U_EDISCCOBRA_drvTbl_QBDEP WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCCOBRA','D50','dbo.U_EDISCCOBRA_drvTbl_QBDEPPLAN WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCCOBRA','D60','dbo.U_EDISCCOBRA_drvTbl_QBMSRI WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCCOBRA','D70','dbo.U_EDISCCOBRA_drvTbl_NPM WITH (NOLOCK)',NULL);
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
IF OBJECT_ID('U_EDISCCOBRA_drvTbl_NPM') IS NULL
CREATE TABLE [dbo].[U_EDISCCOBRA_drvTbl_NPM] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvSSN] char(11) NULL,
    [drvEmpNo] char(9) NULL,
    [drvClientName] varchar(100) NULL,
    [drvClientDivName] varchar(50) NULL,
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
    [drvHireDate] datetime NULL,
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
    [drvClientDivName] varchar(13) NOT NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvSSN] char(11) NULL,
    [drvEmpNo] varchar(1) NOT NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvGender] char(1) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvTobaccoUse] varchar(7) NOT NULL,
    [drvEmpPayType] varchar(6) NOT NULL,
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
    [drvRelationship] varchar(15) NOT NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvIsAddressSame] varchar(4) NOT NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
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
    [drvPlanName] varchar(37) NULL,
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
    [drvEventType] varchar(28) NOT NULL,
    [drvEventDate] datetime NULL,
    [drvEnrollmentDate] datetime NULL,
    [drvSSN] char(11) NULL,
    [drvName] varchar(201) NULL,
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
    [drvPlanName] varchar(37) NULL,
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
    [drvPlanName] varchar(37) NULL,
    [drvCoverageLevel] varchar(18) NULL,
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
Client Name: Redhorse Corporation

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 02/21/2020
Service Request Number: TekP-01-08-2020-000

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
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'NewEnrolleeType','4'); -- All new enrollees where no previous plan exists
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
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraReasonsDepPQB','201,204,210,LEVNT3,LEVNT4,205'); -- Valid dependent PQB reasons
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidCobraReasonsEmp','201,204,210,LEVNT3,LEVNT4'); -- Invalidate employee when Cobra Reason is a dependent PQB reason
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidTermReasonsEmp','202'); -- Invalidate employee when Cobra Reason is "Death"
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'ConCobraReasonPCF','DependentCOBRAReason'); -- Valid dependent PQB reasons
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CountDependents','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL,DA,DPC,STC');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');

    -- Run BDM for QB
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

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
        ,drvClientName      = CONVERT(varchar(100),'Redhorse Corporation 36093')
        ,drvClientDivName   = CONVERT(varchar(50),
                              CASE WHEN bdmDedcode in ('INTDE','INTME') Then  'International'
                                  ELSE 'Domestic'
                              END)
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
        ,drvHireDate        = EecDateOfLastHire
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
    WHERE BdmRunID = 'NPM';

    ------------------
    -- QB DETAIL RECORD
    ------------------
    IF OBJECT_ID('U_EDISCCOBRA_drvTbl_QB') IS NOT NULL
        DROP TABLE dbo.U_EDISCCOBRA_drvTbl_QB;
    SELECT DISTINCT
         drvEEID           = BdmEEID
        ,drvCoID           = BdmCoID
        ,drvDepRecID       = ISNULL(BdmDepRecID,'')
        ,drvClientName     = CONVERT(varchar(100),'Redhorse Corporation 36093')
        ,drvClientDivName  = CASE WHEN bdmDedcode in ('INTDE','INTME') Then  'International'
                                  ELSE 'Domestic'
                              END
        ,drvNameFirst      = CASE WHEN BdmRecType = 'EMP' THEN EepNameFirst
                                  ELSE ConNameFirst
                             END
        ,drvNameMiddle     = CASE WHEN BdmRecType = 'EMP' THEN LEFT(ISNULL(EepNameMiddle,''),1)
                                  ELSE LEFT(ConNameMiddle,1)
                             END
        ,drvNameLast       = CASE WHEN BdmRecType = 'EMP' THEN EepNameLast
                                  ELSE ConNameLast
                             END
        ,drvSSN            = CASE WHEN BdmRecType = 'EMP' THEN eepSSN
                                  ELSE ISNULL(ConSSN,'')
                             END
        ,drvEmpNo          = ''
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
        ,drvTobaccoUse =  CASE WHEN EepIsSmoker = 'Y' THEN 'Yes'
                               WHEN EepIsSmoker = 'N' THEN 'No'
                               ELSe 'UNKNOWN'
                          END
        ,drvEmpPayType = CASE WHEN EecSalaryOrHourly = 'S' Then 'SALARY'
                              ELSE 'HOURLY'
                         END
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
      AND BdmIsPQB = 'Y';

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
                                  WHEN BdmCobraReason IN ('203','202') THEN 'REDUCTIONINHOURSSTATUSCHANGE'
                                  WHEN BdmCobraReason = '205' THEN 'MEDICARE'
                                  WHEN BdmCobraReason = '206' THEN 'REDUCTIONINHOURSENDOFLEAVE'
                                  WHEN BdmCobraReason = '207' THEN 'USERRA-REDUCTIONINHOURS'
                                  WHEN BdmCobraReason = '208' THEN 'RETIREMENT'
                                  WHEN BdmCobraReason = '209' THEN 'WORKSTOPPAGE'
                                  WHEN EecEmplStatus = 'T' and eectermtype = 'I' THEN 'INVOLUNTARYTERMINATION'
                                  ELSE 'TERMINATION'
                             END
        ,drvEventDate      = BdmDateOfCOBRAEvent
        ,drvEnrollmentDate = BdmBenStartDate
        ,drvSSN            = eepSSN
        ,drvName           =  RTRIM(EepNameFirst) + ' ' + EepNameLast
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
       AND ISNULL(BdmDepRecID,'') = drvDepRecID;

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
        ,drvPlanName      = CASE WHEN BdmDedCode in ('DENH','DENHO') THEN 'Cigna Dental DPPO High'
                                 WHEN BdmDedCode in ('DENL','DENLO') THEN 'Cigna Dental DPPO Low'
                                 WHEN BdmDedCode in ('EPO','EPOO') THEN 'Cigna Medical EPO'
                                 WHEN BdmDedCode in ('HSAR','HSAO') THEN 'Cigna Medical High Deductible OAP HSA'
                                 WHEN BdmDedCode in ('HSARL','HSALC') THEN 'Cigna Medical Low Deductible OAP HSA'
                                 WHEN BdmDedCode in ('OAP' ,'OAPO') THEN 'Cigna Medical OAP PPO'
                                 WHEN BdmDedCode in ('FSA') THEN 'DBI FSA'
                                 WHEN BdmDedCode in ('LFSA') THEN 'DBI Limited FSA'
                                 WHEN BdmDedCode in ('VIS','VISO') THEN 'VSP Vision'
                                 WHEN BdmDedCode in ('INTDE') THEN 'Aetna Dental International DPPO'
                                 WHEN BdmDedCode in ('INTME') THEN 'Aetna Medical International PPO'
                            END
        ,drvCoverageLevel = CASE WHEN BdmDedType  IN ('FSA','LFSA') THEN 'EE'
                                 WHEN BdmRecType = 'EMP' THEN
                                      CASE WHEN BdmBenOption IN ('EE') THEN 'EE'
                                           WHEN BdmBenOption IN ('EEC','EED') THEN 'EE+CHILDREN'
                                           WHEN BdmBenOption IN ('EES') THEN 'EE+SPOUSE'
                                           WHEN BdmBenOption IN ('EEDP') THEN 'EE+DOMESTICPARTNER'
                                           WHEN BdmBenOption IN ('EEF','EEDPF','EEDPC') THEN 'EE+FAMILY'
                                      END
                                 /*
                                 WHEN BdmRelationship IN ('SPS','DP') THEN
                                      CASE WHEN ISNULL(BdmNumChildren,0) = 1 THEN 'EE+1'
                                           WHEN ISNULL(BdmNumChildren,0) > 1 THEN 'EE+FAMILY'
                                           ELSE 'EE'
                                      END
                                */
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
    WHERE BdmRunID = 'QB'
      AND BdmIsPQB = 'Y';

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
                                  ELSE 'CHILD'
                             END
        ,drvNameFirst      = ConNameFirst
        ,drvNameMiddle     = LEFT(ISNULL(ConNameMiddle,''),1)
        ,drvNameLast       = ConNameLast
        ,drvIsAddressSame  = 'True'
        ,drvAddressLine1   = ConAddressLine1
        ,drvAddressLine2   = ConAddressLine2
        ,drvAddressCity    = ConAddressCity
        ,drvAddressState   = ConAddressState
        ,drvAddressZipCode = ConAddressZipCode
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
      AND BdmIsPQB = 'N';

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
        ,drvPlanName    = drvPlanName
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
    WHERE BdmRunID = 'QB'
      AND BdmIsPQB = 'N';

    ------------------
    -- QBPLANMEMBERSPECIFICRATEINITIAL DETAIL RECORD
    ------------------
    IF OBJECT_ID('U_EDISCCOBRA_drvTbl_QBMSRI') IS NOT NULL
        DROP TABLE dbo.U_EDISCCOBRA_drvTbl_QBMSRI;
    SELECT DISTINCT
         drvEEID        = drvEEID
        ,drvCoID        = drvCoID
        ,drvDepRecID    = drvDepRecID
        ,drvPlanName    = drvPlanName
        ,drvRate        = CASE WHEN BdmDedCode in ('FSA','LFSA') THEN bdmEEamt END
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
    WHERE BdmRunID = 'QB'
      AND BdmIsPQB = 'Y'
      AND BdmDedType = 'FSA';


    --==========================================
    -- Set filename
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