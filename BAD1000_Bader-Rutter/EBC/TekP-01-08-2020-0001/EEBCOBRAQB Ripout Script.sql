SET NOCOUNT ON;
IF OBJECT_ID('U_EEBCOBRAQB_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EEBCOBRAQB_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EEBCOBRAQB_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EEBCOBRAQB' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEEBCOBRAQB_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEEBCOBRAQB_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EEBCOBRAQB') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EEBCOBRAQB];
GO
IF OBJECT_ID('U_EEBCOBRAQB_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EEBCOBRAQB_PEarHist];
GO
IF OBJECT_ID('U_EEBCOBRAQB_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EEBCOBRAQB_PDedHist];
GO
IF OBJECT_ID('U_EEBCOBRAQB_File') IS NOT NULL DROP TABLE [dbo].[U_EEBCOBRAQB_File];
GO
IF OBJECT_ID('U_EEBCOBRAQB_EEList') IS NOT NULL DROP TABLE [dbo].[U_EEBCOBRAQB_EEList];
GO
IF OBJECT_ID('U_EEBCOBRAQB_Edh_WorkingTable') IS NOT NULL DROP TABLE [dbo].[U_EEBCOBRAQB_Edh_WorkingTable];
GO
IF OBJECT_ID('U_EEBCOBRAQB_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL') IS NOT NULL DROP TABLE [dbo].[U_EEBCOBRAQB_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL];
GO
IF OBJECT_ID('U_EEBCOBRAQB_drvTbl_QBPLANINITIAL') IS NOT NULL DROP TABLE [dbo].[U_EEBCOBRAQB_drvTbl_QBPLANINITIAL];
GO
IF OBJECT_ID('U_EEBCOBRAQB_drvTbl_QBEVENT') IS NOT NULL DROP TABLE [dbo].[U_EEBCOBRAQB_drvTbl_QBEVENT];
GO
IF OBJECT_ID('U_EEBCOBRAQB_drvTbl_QBDEPENDENTPLANINITIAL') IS NOT NULL DROP TABLE [dbo].[U_EEBCOBRAQB_drvTbl_QBDEPENDENTPLANINITIAL];
GO
IF OBJECT_ID('U_EEBCOBRAQB_drvTbl_QBDEPENDENT') IS NOT NULL DROP TABLE [dbo].[U_EEBCOBRAQB_drvTbl_QBDEPENDENT];
GO
IF OBJECT_ID('U_EEBCOBRAQB_drvTbl_QB') IS NOT NULL DROP TABLE [dbo].[U_EEBCOBRAQB_drvTbl_QB];
GO
IF OBJECT_ID('U_EEBCOBRAQB_DedList') IS NOT NULL DROP TABLE [dbo].[U_EEBCOBRAQB_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EEBCOBRAQB') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EEBCOBRAQB];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EEBCOBRAQB';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EEBCOBRAQB';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EEBCOBRAQB';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EEBCOBRAQB';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EEBCOBRAQB';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EEBCOBRAQB','EBC Cobra QB Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','EEBCOBRAQBZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[VERSION]"','1','(''DA''=''T,'')','EEBCOBRAQBZ0','50','H','01','1',NULL,'VersionIndicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"1.1"','2','(''DA''=''T'')','EEBCOBRAQBZ0','50','H','01','2',NULL,'VersionNumber',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QB]"','1','(''DA''=''T,'')','EEBCOBRAQBZ0','50','D','10','1',NULL,'QB Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientName"','2','(''UA''=''T,'')','EEBCOBRAQBZ0','50','D','10','2',NULL,'ClientName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientDivisionName"','3','(''UA''=''T,'')','EEBCOBRAQBZ0','50','D','10','3',NULL,'ClientDivisionName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','4','(''DA''=''T,'')','EEBCOBRAQBZ0','50','D','10','4',NULL,'Salutation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','5','(''UA''=''T,'')','EEBCOBRAQBZ0','50','D','10','5',NULL,'FirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMIddleInit"','6','(''UA''=''T,'')','EEBCOBRAQBZ0','50','D','10','6',NULL,'MiddleInitial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','7','(''UA''=''T,'')','EEBCOBRAQBZ0','50','D','10','7',NULL,'LastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSsn"','8','(''UA''=''T,'')','EEBCOBRAQBZ0','50','D','10','8',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIndividualId"','9','(''UA''=''T,'')','EEBCOBRAQBZ0','50','D','10','9',NULL,'IndividualID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmail"','10','(''UA''=''T,'')','EEBCOBRAQBZ0','50','D','10','10',NULL,'Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhone"','11','(''UA''=''T,'')','EEBCOBRAQBZ0','50','D','10','11',NULL,'Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','12','(''DA''=''T,'')','EEBCOBRAQBZ0','50','D','10','12',NULL,'Phone2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','13','(''UA''=''T,'')','EEBCOBRAQBZ0','50','D','10','13',NULL,'Address1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','14','(''UA''=''T,'')','EEBCOBRAQBZ0','50','D','10','14',NULL,'Address2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','15','(''UA''=''T,'')','EEBCOBRAQBZ0','50','D','10','15',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','16','(''UA''=''T,'')','EEBCOBRAQBZ0','50','D','10','16',NULL,'StateOrProvince',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','17','(''UA''=''T,'')','EEBCOBRAQBZ0','50','D','10','17',NULL,'PostalCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''DA''=''T,'')','EEBCOBRAQBZ0','50','D','10','18',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TRUE"','19','(''DA''=''T,'')','EEBCOBRAQBZ0','50','D','10','19',NULL,'PremiumAddressSameAsPrimary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','20','(''DA''=''T,'')','EEBCOBRAQBZ0','50','D','10','20',NULL,'PremiumAddress1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','21','(''DA''=''T,'')','EEBCOBRAQBZ0','50','D','10','21',NULL,'PremiumAddress2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','22','(''DA''=''T,'')','EEBCOBRAQBZ0','50','D','10','22',NULL,'PremiumCity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','23','(''DA''=''T,'')','EEBCOBRAQBZ0','50','D','10','23',NULL,'PremiumStateOrProvince',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','24','(''DA''=''T,'')','EEBCOBRAQBZ0','50','D','10','24',NULL,'PremiumPostalCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','25','(''DA''=''T,'')','EEBCOBRAQBZ0','50','D','10','25',NULL,'PremiumCountry',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','26','(''UA''=''T,'')','EEBCOBRAQBZ0','50','D','10','26',NULL,'Sex',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','27','(''UD101''=''T,'')','EEBCOBRAQBZ0','50','D','10','27',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"UNKNOWN"','28','(''DA''=''T,'')','EEBCOBRAQBZ0','50','D','10','28',NULL,'TobaccoUse',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"UNKNOWN"','29','(''DA''=''T,'')','EEBCOBRAQBZ0','50','D','10','29',NULL,'EmployeeType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"UNKNOWN"','30','(''DA''=''T,'')','EEBCOBRAQBZ0','50','D','10','30',NULL,'EmployeePayrollType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','31','(''DA''=''T,'')','EEBCOBRAQBZ0','50','D','10','31',NULL,'YearsOfService',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"COUPONBOOK"','32','(''DA''=''T,'')','EEBCOBRAQBZ0','50','D','10','32',NULL,'PremiumCouponType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FALSE"','33','(''DA''=''T,'')','EEBCOBRAQBZ0','50','D','10','33',NULL,'UsesHCTC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TRUE"','34','(''DA''=''T,'')','EEBCOBRAQBZ0','50','D','10','34',NULL,'Active',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FALSE"','35','(''DA''=''T,'')','EEBCOBRAQBZ0','50','D','10','35',NULL,'AllowMemberSSO',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','36','(''DA''=''T,'')','EEBCOBRAQBZ0','50','D','10','36',NULL,'BenefitGroup',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','37','(''DA''=''T,'')','EEBCOBRAQBZ0','50','D','10','37',NULL,'AccountStructure',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','38','(''DA''=''T'')','EEBCOBRAQBZ0','50','D','10','38',NULL,'ClientSpecificData',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBEVENT]"','1','(''DA''=''T,'')','EEBCOBRAQBZ0','50','D','20','1',NULL,'QB Event Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEventType"','2','(''UA''=''T,'')','EEBCOBRAQBZ0','50','D','20','2',NULL,'EventType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEventDate"','3','(''UD101''=''T,'')','EEBCOBRAQBZ0','50','D','20','3',NULL,'EventDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrollmentDate"','4','(''UD101''=''T,'')','EEBCOBRAQBZ0','50','D','20','4',NULL,'EnrollmentDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeSsn"','5','(''UA''=''T,'')','EEBCOBRAQBZ0','50','D','20','5',NULL,'EmployeeSSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeName"','6','(''UA''=''T,'')','EEBCOBRAQBZ0','50','D','20','6',NULL,'EmployeeName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','7','(''DA''=''T'')','EEBCOBRAQBZ0','50','D','20','7',NULL,'SecondEventOriginalFDOC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBPLANINITIAL]"','1','(''DA''=''T,'')','EEBCOBRAQBZ0','50','D','30','1',NULL,'QBPAININITIAL Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanName"','2','(''UA''=''T,'')','EEBCOBRAQBZ0','50','D','30','2',NULL,'PlanName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageLevel"','3','(''UA''=''T,'')','EEBCOBRAQBZ0','50','D','30','3',NULL,'CoverageLevel',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','4','(''DA''=''T'')','EEBCOBRAQBZ0','50','D','30','4',NULL,'NumberOfUnits',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBDEPENDENT]"','1','(''DA''=''T,'')','EEBCOBRAQBZ0','50','D','40','1',NULL,'QBDEPENDENT Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSsn"','2','(''UA''=''T,'')','EEBCOBRAQBZ0','50','D','40','2',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelationship"','3','(''UA''=''T,'')','EEBCOBRAQBZ0','50','D','40','3',NULL,'Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','4','(''DA''=''T,'')','EEBCOBRAQBZ0','50','D','40','4',NULL,'Salutation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','5','(''UA''=''T,'')','EEBCOBRAQBZ0','50','D','40','5',NULL,'FirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddleInit"','6','(''UA''=''T,'')','EEBCOBRAQBZ0','50','D','40','6',NULL,'MiddleInitial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','7','(''UA''=''T,'')','EEBCOBRAQBZ0','50','D','40','7',NULL,'LastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''DA''=''T,'')','EEBCOBRAQBZ0','50','D','40','8',NULL,'Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''DA''=''T,'')','EEBCOBRAQBZ0','50','D','40','9',NULL,'Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''DA''=''T,'')','EEBCOBRAQBZ0','50','D','40','10',NULL,'Phone2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressSameAsQB"','11','(''UA''=''T,'')','EEBCOBRAQBZ0','50','D','40','11',NULL,'AddressSameAsQB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','12','(''UA''=''T,'')','EEBCOBRAQBZ0','50','D','40','12',NULL,'Address1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','13','(''UA''=''T,'')','EEBCOBRAQBZ0','50','D','40','13',NULL,'Address2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','14','(''UA''=''T,'')','EEBCOBRAQBZ0','50','D','40','14',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','15','(''UA''=''T,'')','EEBCOBRAQBZ0','50','D','40','15',NULL,'StateOrProvince',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','16','(''UA''=''T,'')','EEBCOBRAQBZ0','50','D','40','16',NULL,'PostalCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','17','(''DA''=''T,'')','EEBCOBRAQBZ0','50','D','40','17',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''DA''=''T,'')','EEBCOBRAQBZ0','50','D','40','18',NULL,'EnrollmentDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','19','(''UA''=''T,'')','EEBCOBRAQBZ0','50','D','40','19',NULL,'Sex',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','20','(''UD101''=''T,'')','EEBCOBRAQBZ0','50','D','40','20',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FALSE"','21','(''DA''=''T'')','EEBCOBRAQBZ0','50','D','40','21',NULL,'IsQMCSO',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBDEPENDENTPLANINITIAL]"','1','(''DA''=''T,'')','EEBCOBRAQBZ0','50','D','50','1',NULL,'QBDEPENDENTPLANINITIAL Ind',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanName"','2','(''UA''=''T'')','EEBCOBRAQBZ0','50','D','50','2',NULL,'PLanName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBPLANMEMBERSPECIFICRATEINITIAL]"','1','(''DA''=''T,'')','EEBCOBRAQBZ0','50','D','60','1',NULL,'Record Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanName"','2','(''UA''=''T,'')','EEBCOBRAQBZ0','50','D','60','2',NULL,'PlanName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRate"','3','(''UA''=''T'')','EEBCOBRAQBZ0','50','D','60','3',NULL,'Rate',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EEBCOBRAQB_20200406.txt',NULL,'','','',NULL,NULL,NULL,'EBC Cobra QB Export','202003269','EMPEXPORT','ONDEMAND','Jan 17 2020  9:11AM','EEBCOBRAQB',NULL,NULL,NULL,'202003269','Jan 14 2020 11:52AM','Jan 14 2020 11:52AM','201901011','447','','','201901011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EEBCOBRAQB_20200406.txt',NULL,'','','',NULL,NULL,NULL,'Scheduled Session','202003269','EMPEXPORT','SCHEDULED','Jan 17 2020  9:11AM','EEBCOBRAQB',NULL,NULL,NULL,'202003269','Jan 14 2020 11:52AM','Jan 14 2020 11:52AM','201901011','447','','','201901011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EEBCOBRAQB_20200406.txt',NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','202003269','EMPEXPORT','OEACTIVE','Jan 17 2020  9:10AM','EEBCOBRAQB',NULL,NULL,NULL,'202003269','Jan 14 2020 11:52AM','Jan 14 2020 11:52AM','201901011','447','','','201901011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EEBCOBRAQB_20200406.txt',NULL,'','','',NULL,NULL,NULL,'Passive Open Enrollment Export','202003269','EMPEXPORT','OEPASSIVE','Jan 17 2020  9:10AM','EEBCOBRAQB',NULL,NULL,NULL,'202003269','Jan 14 2020 11:52AM','Jan 14 2020 11:52AM','201901011','447','','','201901011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EEBCOBRAQB_20200406.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202004069','EMPEXPORT','TEST','Apr  6 2020  9:29AM','EEBCOBRAQB',NULL,NULL,NULL,'202004069','Apr  6 2020 12:00AM','Dec 30 1899 12:00AM','202003251','21','','','202003251',dbo.fn_GetTimedKey(),NULL,'us3cPeBAD1000A',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EEBCOBRAQB_20200406.txt' END WHERE expFormatCode = 'EEBCOBRAQB';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEBCOBRAQB','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEBCOBRAQB','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEBCOBRAQB','InitialSort','C','drvSort1');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEBCOBRAQB','SubSort','C','drvSort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEBCOBRAQB','SubSort2','C','drvSort3');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEBCOBRAQB','SubSort3','C','drvSort4');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEBCOBRAQB','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEBCOBRAQB','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EEBCOBRAQB' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EEBCOBRAQB' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EEBCOBRAQB_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EEBCOBRAQB_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EEBCOBRAQB','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EEBCOBRAQB','D10','dbo.U_EEBCOBRAQB_drvTbl_QB',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EEBCOBRAQB','D20','dbo.U_EEBCOBRAQB_drvTbl_QBEVENT',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EEBCOBRAQB','D30','dbo.U_EEBCOBRAQB_drvTbl_QBPLANINITIAL',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EEBCOBRAQB','D40','dbo.U_EEBCOBRAQB_drvTbl_QBDEPENDENT',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EEBCOBRAQB','D50','dbo.U_EEBCOBRAQB_drvTbl_QBDEPENDENTPLANINITIAL',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EEBCOBRAQB','D60','dbo.U_EEBCOBRAQB_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL',NULL);
IF OBJECT_ID('U_dsi_BDM_EEBCOBRAQB') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EEBCOBRAQB] (
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
IF OBJECT_ID('U_EEBCOBRAQB_DedList') IS NULL
CREATE TABLE [dbo].[U_EEBCOBRAQB_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EEBCOBRAQB_drvTbl_QB') IS NULL
CREATE TABLE [dbo].[U_EEBCOBRAQB_drvTbl_QB] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort1] char(12) NULL,
    [drvSort2] int NOT NULL,
    [drvSort3] varchar(1) NOT NULL,
    [drvSort4] varchar(1) NOT NULL,
    [drvClientName] varchar(32) NOT NULL,
    [drvClientDivisionName] varchar(32) NOT NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMIddleInit] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvSsn] char(11) NULL,
    [drvIndividualId] char(9) NULL,
    [drvEmail] varchar(50) NULL,
    [drvPhone] varchar(50) NULL,
    [drvAddressLine1] varchar(257) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvGender] char(1) NULL,
    [drvDateOfBirth] datetime NULL
);
IF OBJECT_ID('U_EEBCOBRAQB_drvTbl_QBDEPENDENT') IS NULL
CREATE TABLE [dbo].[U_EEBCOBRAQB_drvTbl_QBDEPENDENT] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort1] char(12) NULL,
    [drvSort2] int NOT NULL,
    [drvSort3] char(12) NULL,
    [drvSort4] int NOT NULL,
    [drvSsn] char(11) NULL,
    [drvRelationship] varchar(15) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddleInit] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvAddressSameAsQB] varchar(5) NOT NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvGender] char(1) NULL,
    [drvDateOfBirth] datetime NULL
);
IF OBJECT_ID('U_EEBCOBRAQB_drvTbl_QBDEPENDENTPLANINITIAL') IS NULL
CREATE TABLE [dbo].[U_EEBCOBRAQB_drvTbl_QBDEPENDENTPLANINITIAL] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort1] char(12) NULL,
    [drvSort2] int NOT NULL,
    [drvSort3] char(12) NULL,
    [drvSort4] int NOT NULL,
    [drvPlanName] varchar(22) NULL
);
IF OBJECT_ID('U_EEBCOBRAQB_drvTbl_QBEVENT') IS NULL
CREATE TABLE [dbo].[U_EEBCOBRAQB_drvTbl_QBEVENT] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort1] char(12) NULL,
    [drvSort2] int NOT NULL,
    [drvSort3] varchar(1) NOT NULL,
    [drvSort4] int NOT NULL,
    [drvEventType] varchar(29) NOT NULL,
    [drvEventDate] datetime NULL,
    [drvEnrollmentDate] datetime NULL,
    [drvEmployeeSsn] char(11) NULL,
    [drvEmployeeName] varchar(201) NULL
);
IF OBJECT_ID('U_EEBCOBRAQB_drvTbl_QBPLANINITIAL') IS NULL
CREATE TABLE [dbo].[U_EEBCOBRAQB_drvTbl_QBPLANINITIAL] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort1] char(12) NULL,
    [drvSort2] int NOT NULL,
    [drvSort3] char(5) NULL,
    [drvSort4] int NOT NULL,
    [drvPlanName] varchar(22) NULL,
    [drvCoverageLevel] varchar(11) NULL
);
IF OBJECT_ID('U_EEBCOBRAQB_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL') IS NULL
CREATE TABLE [dbo].[U_EEBCOBRAQB_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort1] char(12) NULL,
    [drvSort2] int NOT NULL,
    [drvSort3] varchar(3) NOT NULL,
    [drvSort4] int NOT NULL,
    [drvPlanName] varchar(7) NOT NULL,
    [drvRate] nvarchar(4000) NULL
);
IF OBJECT_ID('U_EEBCOBRAQB_Edh_WorkingTable') IS NULL
CREATE TABLE [dbo].[U_EEBCOBRAQB_Edh_WorkingTable] (
    [EdhEEID] char(12) NOT NULL,
    [EdhCoID] char(5) NOT NULL,
    [EdhDedCode] char(5) NOT NULL,
    [EdhChangeReason] char(6) NULL,
    [EdhEffDate] datetime NULL
);
IF OBJECT_ID('U_EEBCOBRAQB_EEList') IS NULL
CREATE TABLE [dbo].[U_EEBCOBRAQB_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EEBCOBRAQB_File') IS NULL
CREATE TABLE [dbo].[U_EEBCOBRAQB_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
IF OBJECT_ID('U_EEBCOBRAQB_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EEBCOBRAQB_PDedHist] (
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
IF OBJECT_ID('U_EEBCOBRAQB_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EEBCOBRAQB_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EEBCOBRAQB]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Bader-Rutter

Created By: James Bender
Business Analyst: Cheryl Petitti
Create Date: 01/14/2020
Service Request Number: TekP-01-08-2020-0001

Purpose: EBC Cobra QB Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EEBCOBRAQB';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EEBCOBRAQB';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EEBCOBRAQB';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EEBCOBRAQB';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EEBCOBRAQB' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEBCOBRAQB', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEBCOBRAQB', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEBCOBRAQB', 'OEACTIVE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EEBCOBRAQB';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EEBCOBRAQB', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EEBCOBRAQB';

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
    DELETE FROM dbo.U_EEBCOBRAQB_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EEBCOBRAQB_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'DEN,DENP,FSA,MEDG,MEDGP,MED,MEDP,VIS,VISP';

    IF OBJECT_ID('U_EEBCOBRAQB_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EEBCOBRAQB_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EEBCOBRAQB_DedList
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
    --EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode; 
    
    -- Run BDM for Cobra
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DedList);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'CobraReasonsEmp', '204,LEVNT4,210,201,205,200,203,206') 
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'CobraReasonsDep', '204,LEVNT4,210,201,205,200,203,206')
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraType','4'); -- Eep/ConCobraReason first, then EdhChangeReason. Include CHGRP for elig. ben groups
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraDate','3'); -- EedBenStopDate and DbnBenStopDate, unless Eep/ConDateOfCOBRAEvent exist
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraPQBType','1'); -- If no EE or spouse, ALL children are PQB (not just oldest)
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','Y'); -- DedIsCobraCovered = 'Y'
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraReasonsDepPQB','201,204,LEVNT4,206,203,200'); -- Valid dependent PQB reasons
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidCobraReasonsEmp','201,204,LEVNT3,LEVNT4,206,207,203,200'); -- Invalidate employee when Cobra Reason is a dependent PQB reason
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidTermReasonsEmp','203'); -- Invalidate employee when Cobra Reason is "Death"
   
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'ConCobraReasonPCF','DependentCOBRAReason'); -- Valid dependent PQB reasons
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CountDependents','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL,STC,DPC')
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'RunID', 'Cobra')
    --INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'AddToPreviousRun', 'Y')
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'AddToPreviousRun', 'N')

    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EEBCOBRAQB_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EEBCOBRAQB_PDedHist;
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
    INTO dbo.U_EEBCOBRAQB_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EEBCOBRAQB_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EEBCOBRAQB_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EEBCOBRAQB_PEarHist;
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
    INTO dbo.U_EEBCOBRAQB_PEarHist
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
    DECLARE @JcbDedCodes TABLE (DedCode VARCHAR(5));

    INSERT INTO @JcbDedCodes VALUES ('DEN'),('DENP'),('FSA'),('MEDG'),('MEDGP'),('MED'),('MEDP'),('VIS'),('VISP');

    IF OBJECT_ID('U_EEBCOBRAQB_Edh_WorkingTable','U') IS NOT NULL
        DROP TABLE dbo.U_EEBCOBRAQB_Edh_WorkingTable;
    SELECT EdhEEID, EdhCoID, EdhDedCode, EdhChangeReason, EdhEffDate
    INTO dbo.U_EEBCOBRAQB_Edh_WorkingTable
    FROM    (
                SELECT EDHEEID, EdhCOID, EdhDedCode, edhChangeReason, EdhEffDate, ROW_NUMBER() OVER(PARTITION BY EdhEEID, EdhCOID, EdhDedCode ORDER BY EdhEffDate DESC) AS rn 
                FROM dbo.EmpHDed a WITH (NOLOCK)
                WHERE EdhDedCode IN ('DEN','DENP','FSA','MEDG','MEDGP','MED','MEDP','VIS','VISP') 
                    AND edhChangeReason IN ('204', 'LEVNT4', '210', '201', '205', '200', '203', '206')
            ) AS T
    WHERE rn = 1;

        

    ---------------------------------
    -- DETAIL RECORD - U_EEBCOBRAQB_drvTbl_QB
    ---------------------------------
    IF OBJECT_ID('U_EEBCOBRAQB_drvTbl_QB','U') IS NOT NULL
        DROP TABLE dbo.U_EEBCOBRAQB_drvTbl_QB;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort1 = xEEID --'' --EdhChangeReason 
        ,drvSort2 = 1
        ,drvSort3 = '' --BdmRecType
        ,drvSort4 = '' --ConRelationship + ' -- ' + BdmCobraReason
        -- standard fields above and additional driver fields below
        ,drvClientName = '"Bader Rutter & Associates, Inc"' 
        ,drvClientDivisionName = '"Bader Rutter & Associates, Inc"'
        ,drvNameFirst = CASE WHEN EdhChangeReason IN ('LEVNT4', '204', '210', '201') THEN ConNameFirst ELSE EepNameFirst END
        ,drvNameMIddleInit = CASE WHEN EdhChangeReason IN ('LEVNT4', '204', '210', '201') THEN LEFT(EepNameMiddle, 1) ELSE LEFT(EepNameMiddle,1) END
        ,drvNameLast = CASE WHEN EdhChangeReason IN ('LEVNT4', '204', '210', '201') THEN ConNameLast ELSE EepNameLast END
        ,drvSsn = CASE WHEN EdhChangeReason IN ('LEVNT4', '204', '210', '201') THEN ConSSN ELSE EepSsn END
        ,drvIndividualId = EecEmpNo
        ,drvEmail = CASE WHEN EdhChangeReason IN ('LEVNT4', '204', '210', '201') THEN ConEmailAddr ELSE EepAddressEMail END
        ,drvPhone = CASE WHEN EdhChangeReason IN ('LEVNT4', '204', '210', '201') THEN ConPhoneHomeNumber ELSE EepPhoneHomeNumber END
        ,drvAddressLine1 = '"' + CASE WHEN EdhChangeReason IN ('LEVNT4', '204', '210', '201') THEN ConAddressLine1 ELSE EepAddressLine1 END + '"'
        ,drvAddressLine2 = CASE WHEN EdhChangeReason IN ('LEVNT4', '204', '210', '201') THEN ConAddressLine2 ELSE EepAddressLine2 END
        ,drvAddressCity = CASE WHEN EdhChangeReason IN ('LEVNT4', '204', '210', '201') THEN ConAddressCity ELSE EepAddressCity END
        ,drvAddressState = CASE WHEN EdhChangeReason IN ('LEVNT4', '204', '210', '201') THEN ConAddressState ELSE EepAddressState END
        ,drvAddressZipCode = CASE WHEN EdhChangeReason IN ('LEVNT4', '204', '210', '201') THEN ConAddressZipCode ELSE EepAddressZipCode END
        ,drvGender = CASE WHEN EdhChangeReason IN ('LEVNT4', '204', '210', '201') THEN ConGender ELSE EepGender END
        ,drvDateOfBirth = CASE WHEN EdhChangeReason IN ('LEVNT4', '204', '210', '201') THEN ConDateOfBirth ELSE EepDateOfBirth END
    INTO dbo.U_EEBCOBRAQB_drvTbl_QB
    FROM dbo.U_EEBCOBRAQB_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EEBCOBRAQB WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
--        AND BdmRecType = 'EMP'
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.U_EEBCOBRAQB_Edh_WorkingTable
        ON EdhEEID = xEEID
        AND EdhCOID = xCOID
        AND EdhDedCode = BdmDedCode
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecId
    WHERE (BdmRecType = 'EMP' AND BdmCobraReason NOT IN ('210'))
        OR (ConRelationship IN ('SPS') AND BdmCobraReason IN ('210'))
    ;

    ---------------------------------
    -- DETAIL RECORD - U_EEBCOBRAQB_drvTbl_QBEVENT
    ---------------------------------
    IF OBJECT_ID('U_EEBCOBRAQB_drvTbl_QBEVENT','U') IS NOT NULL
        DROP TABLE dbo.U_EEBCOBRAQB_drvTbl_QBEVENT;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort1 = xEEID
        ,drvSort2 = 3
        ,drvSort3 = '' --BdmDedCode
        ,drvSort4 = 1 --ISNULL(BdmCobraReason, 'nope') + ' -- ' + ISNULL(ConCobraReason, 'nope') -- 1
        -- standard fields above and additional driver fields below
        ,drvEventType = CASE WHEN EecEmplStatus <> 'T' AND ConCOBRAReason IN ('204', 'LEVNT4') THEN 'DIVORCELEGALSEPARATION' 
                            WHEN EecEmplStatus = 'T' AND BdmCobraReason /*EecTermReason*/ = '210' THEN 'DEATH'
                            WHEN EecEmplStatus <> 'T' AND ConCOBRAReason IN ('201', 'LEVNT3') THEN 'INELIGIBLEDEPENDENT'
                            WHEN EecEmplStatus <> 'T' AND EepCOBRAReason = '205' THEN 'MEDICARE'
                            WHEN EecEmplStatus = 'T' AND EecTermReason = '200' THEN 'TERMINATION'
                            WHEN EecEmplStatus <> 'T' AND EepCOBRAReason = '203' THEN 'REDUCTIONINHOURS-STATUSCHANGE'
                            WHEN EecEmplStatus <> 'T' AND EepCOBRAReason = '206' THEN 'REDUCTIONINHOURS-ENDOFLEAVE'
                            WHEN EecEmplStatus = 'T' AND EecTermReason NOT IN ('200', '210') THEN 'TERMINATION'
                            ELSE 'TERMINATION'
                        END
        ,drvEventDate = CASE WHEN EdhChangeReason IN ('LEVNT4', '204', '201') THEN ConDateOfCOBRAEvent
                            WHEN  BdmCobraReason IN ('210') THEN  EepDateOfCOBRAEvent
                            ELSE BdmDateOfCOBRAEvent -- EepDateOfCOBRAEvent
                        END
        ,drvEnrollmentDate = BdmBenStartDate
        ,drvEmployeeSsn = eepSSN --CASE WHEN EdhChangeReason IN ('LEVNT4', '204', '210', '201') THEN eepSSN END
        ,drvEmployeeName = EepNameFirst + ' ' + EepNameLast -- CASE WHEN EdhChangeReason IN ('LEVNT4', '204', '210', '201') THEN EepNameFirst + ' ' + EepNameLast END
    INTO dbo.U_EEBCOBRAQB_drvTbl_QBEVENT
    FROM dbo.U_EEBCOBRAQB_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    --JOIN dbo.U_dsi_BDM_EEBCOBRAQB WITH (NOLOCK)
    --    ON BdmEEID = xEEID 
    --    AND BdmCoID = xCoID
    JOIN (
        SELECT BdmEEID, BdmCOID, BdmBenStartDate, BdmDateOfCOBRAEvent, BdmDepRecId, BdmDedCode, BdmCobraReason
        FROM (
            SELECT BdmEEID, BdmCOID, BdmBenStartDate, BdmRecType, BdmDedType, BdmDedCode, BdmDateOfCOBRAEvent, BdmCobraReason, BdmDepRecId
                ,ROW_NUMBER() OVER(PARTITION BY BdmEEID, BdmCOID ORDER BY 
                                                                        CASE WHEN BdmDedType = 'MED' THEN 1
                                                                            WHEN BdmDedType = 'DEN' THEN 2
                                                                            WHEN BdmDedType = 'VIS' THEN 3
                                                                            ELSE 4
                                                                        END, 
                                                                    BdmRecType DESC) AS RN
            FROM dbo.U_dsi_BDM_EEBCOBRAQB WITH (NOLOCK)) AS T
            WHERE RN = 1) AS BDM_Consolidated
        ON BdmEEID = xEEID
        AND BdmCOID = xCOID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecId
        --AND a.EdhChangeReason IN ('204', 'LEVNT4', '210', '201')
    JOIN dbo.U_EEBCOBRAQB_Edh_WorkingTable a
        ON EdhEEID = xEEID
        AND EdhCOID = xCOID
        AND EdhDedCode = BdmDedCode
    --WHERE EdhChangeReason IN ('204', 'LEVNT4', '210', '201', '205', '200', '203', '206')
    ;

    ---------------------------------
    -- DETAIL RECORD - U_EEBCOBRAQB_drvTbl_QBPLANINITIAL
    ---------------------------------
    IF OBJECT_ID('U_EEBCOBRAQB_drvTbl_QBPLANINITIAL','U') IS NOT NULL
        DROP TABLE dbo.U_EEBCOBRAQB_drvTbl_QBPLANINITIAL;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort1 = xEEID
        ,drvSort2 = 3
        ,drvSort3 = BdmDedCode
        ,drvSort4 = 2
        -- standard fields above and additional driver fields below
        ,drvPlanName =    CASE WHEN EdhChangeReason IN ('LEVNT4', '204', '210', '201') AND BdmDedCode IN ('DEN', 'DENP') THEN 'DELTA DENTAL'
                            WHEN EdhChangeReason IN ('LEVNT4', '204', '210', '201') AND BdmDedCode IN ('MEDG', 'MEDGP') THEN 'GPA HEALTH HDHP'
                            WHEN EdhChangeReason IN ('LEVNT4', '204', '210', '201') AND BdmDedCode IN ('MED', 'MEDP') THEN 'GPA HEALTH TRADITIONAL'
                            WHEN EdhChangeReason IN ('LEVNT4', '204', '210', '201') AND BdmDedCode IN ('VIS', 'VISP') THEN 'VSP VISION'
                            WHEN EdhChangeReason NOT IN ('LEVNT4', '204', '210', '201') AND BdmDedCode IN ('DEN', 'DENP') THEN 'DELTA DENTAL'
                            WHEN EdhChangeReason NOT IN ('LEVNT4', '204', '210', '201') AND BdmDedCode IN ('FSA') THEN 'EBC FSA'
                            WHEN EdhChangeReason NOT IN ('LEVNT4', '204', '210', '201') AND BdmDedCode IN ('MEDG', 'MEDGP') THEN 'GPA HEALTH HDHP'
                            WHEN EdhChangeReason NOT IN ('LEVNT4', '204', '210', '201') AND BdmDedCode IN ('MED', 'MEDP') THEN 'GPA HEALTH TRADITIONAL'
                            WHEN EdhChangeReason NOT IN ('LEVNT4', '204', '210', '201') AND BdmDedCode IN ('VIS', 'VISP') THEN 'VSP VISION'
                        END
        ,drvCoverageLevel =    CASE WHEN EdhChangeReason IN ('LEVNT4', '204', '210', '201') THEN 'EE' -- JCB
                               -- WHEN EdhChangeReason IN ('210') AND (SELECT COUNT(*) FROM dbo.Contacts WITH (NOLOCK) WHERE ConEEID = xEEID) > 1 THEN 'EE+FAMILY'
                                ELSE
                                    CASE WHEN BdmDedCode IN ('DEN', 'DENP') and BdmBenOption IN ('EE') THEN 'EE'
                                        WHEN BdmDedCode IN ('DEN', 'DENP') and BdmBenOption IN ('EEF', 'EEDPF', 'EESC', 'EEC2') THEN 'EE+FAMILY'
                                        WHEN BdmDedCode IN ('DEN', 'DENP') and BdmBenOption IN ('EES', 'EEC') THEN 'EE+1'
                                        WHEN BdmDedCode IN ('FSA') THEN 'EE' --and BdmBenOption IN ('EE') THEN 'EE'
                                        --WHEN BdmDedCode IN ('FSA') and BdmBenOption IN ('EEF', 'EEDPF', 'EESC') THEN 'EE+FAMILY'
                                        WHEN BdmDedCode IN ('MEDG', 'MEDGP', 'MED', 'MEDP') and BdmBenOption IN ('EE') THEN 'EE'
                                        WHEN BdmDedCode IN ('MEDG', 'MEDGP', 'MED', 'MEDP') and BdmBenOption IN ('EES', 'EEDP') THEN 'EE+SPOUSE'
                                        WHEN BdmDedCode IN ('MEDG', 'MEDGP', 'MED', 'MEDP') and BdmBenOption IN ('EEC', 'EEC2') THEN 'EE+CHILDREN'
                                        WHEN BdmDedCode IN ('MEDG', 'MEDGP', 'MED', 'MEDP') and BdmBenOption IN ('EEF', 'EEDPF', 'EESC') THEN 'EE+FAMILY'
                                        WHEN BdmDedCode IN ('VIS', 'VISP') and BdmBenOption IN ('EE') THEN 'EE'
                                        WHEN BdmDedCode IN ('VIS', 'VISP') and BdmBenOption IN ('EEC2') THEN 'EE+CHILDREN'
                                        WHEN BdmDedCode IN ('VIS', 'VISP') and BdmBenOption IN ('EEF', 'EEDPF', 'EESC') THEN 'EE+FAMILY'
                                        WHEN BdmDedCode IN ('VIS', 'VISP') and BdmBenOption IN ('EES', 'EEC') THEN 'EE+1'
                                    END
                            END
    INTO dbo.U_EEBCOBRAQB_drvTbl_QBPLANINITIAL
    FROM dbo.U_EEBCOBRAQB_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EEBCOBRAQB WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.U_EEBCOBRAQB_Edh_WorkingTable
        ON EdhEEID = xEEID
        AND EdhCOID = xCOID
        AND EdhDedCode = BdmDedCode
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EEBCOBRAQB_drvTbl_QBDEPENDENT
    ---------------------------------
    IF OBJECT_ID('U_EEBCOBRAQB_drvTbl_QBDEPENDENT','U') IS NOT NULL
        DROP TABLE dbo.U_EEBCOBRAQB_drvTbl_QBDEPENDENT;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort1 = xEEID
        ,drvSort2 = 5
        ,drvSort3 = BdmDepRecId
        ,drvSort4 = 1
        -- standard fields above and additional driver fields below
        ,drvSsn = ConSSN
        ,drvRelationship =    CASE WHEN ConRelationship = 'SPS' THEN 'SPOUSE'
                                WHEN ConRelationship = 'DP' THEN 'DOMESTICPARTNER'
                                WHEN ConRelationship IN ('CHL', 'DPC', 'STC') THEN 'CHILD'
                            END
        ,drvNameFirst = ConNameFirst
        ,drvNameMiddleInit = LEFT(ConNameMiddle,1)
        ,drvNameLast = ConNameLast
        ,drvAddressSameAsQB =    CASE WHEN ConAddressIsDifferent = 'N' THEN 'TRUE' ELSE 'FALSE' END
        ,drvAddressLine1 =    CASE WHEN ConAddressIsDifferent = 'Y' THEN ConAddressLine1 END
        ,drvAddressLine2 = CASE WHEN ConAddressIsDifferent = 'Y' THEN ConAddressLine2 END
        ,drvAddressCity = CASE WHEN ConAddressIsDifferent = 'Y' THEN ConAddressCity END
        ,drvAddressState = CASE WHEN ConAddressIsDifferent = 'Y' THEN ConAddressState END
        ,drvAddressZipCode = CASE WHEN ConAddressIsDifferent = 'Y' THEN ConAddressZipCode END
        ,drvGender = ConGender
        ,drvDateOfBirth = ConDateOfBirth
    INTO dbo.U_EEBCOBRAQB_drvTbl_QBDEPENDENT
    FROM dbo.U_EEBCOBRAQB_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EEBCOBRAQB WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecId
    JOIN dbo.U_EEBCOBRAQB_Edh_WorkingTable
        ON EdhEEID = xEEID
        AND EdhCOID = xCOID
        AND EdhDedCode = BdmDedCode
    WHERE EdhChangeReason NOT IN ('LEVNT4', '204', '201', '210') -- exclude 210 (Death of Employee) 
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EEBCOBRAQB_drvTbl_QBDEPENDENTPLANINITIAL
    ---------------------------------
    IF OBJECT_ID('U_EEBCOBRAQB_drvTbl_QBDEPENDENTPLANINITIAL','U') IS NOT NULL
        DROP TABLE dbo.U_EEBCOBRAQB_drvTbl_QBDEPENDENTPLANINITIAL; -- JCB
    SELECT --DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort1 = xEEID
        ,drvSort2 = 5
        ,drvSort3 = BdmDepRecId
        ,drvSort4 = 2
        -- standard fields above and additional driver fields below
        ,drvPlanName =    CASE WHEN BdmDedCode IN ('DEN', 'DENP') THEN 'DELTA DENTAL'
                            WHEN BdmDedCode IN ('FSA') THEN 'EBC FSA'
                            WHEN BdmDedCode IN ('MEDG', 'MEDGP') THEN 'GPA HEALTH HDHP'
                            WHEN BdmDedCode IN ('MED', 'MEDP') THEN 'GPA HEALTH TRADITIONAL'
                            WHEN BdmDedCode IN ('VIS', 'VISP') THEN 'VSP VISION'
                        END 
    INTO dbo.U_EEBCOBRAQB_drvTbl_QBDEPENDENTPLANINITIAL
    FROM dbo.U_EEBCOBRAQB_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EEBCOBRAQB WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRecType <> 'EMP'
    JOIN dbo.U_EEBCOBRAQB_Edh_WorkingTable
        ON EdhEEID = xEEID
        AND EdhCOID = xCOID
        AND EdhDedCode = BdmDedCode
    WHERE EdhChangeReason NOT IN ('LEVNT4', '204', '201', '210')  -- don't send if there are no dependents, if this is a dependent code, they are sent in the QB record
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EEBCOBRAQB_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL
    ---------------------------------
    IF OBJECT_ID('U_EEBCOBRAQB_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL','U') IS NOT NULL
        DROP TABLE dbo.U_EEBCOBRAQB_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL; -- JCB
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort1 = xEEID
        ,drvSort2 = 3
        ,drvSort3 = 'FSA'
        ,drvSort4 = 3
        -- standard fields above and additional driver fields below
        ,drvPlanName = 'EBC FSA'
        ,drvRate =    FORMAT(BdmEEAmt*2, '#0.00')
    INTO dbo.U_EEBCOBRAQB_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL
    FROM dbo.U_EEBCOBRAQB_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EEBCOBRAQB WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmDedCode = 'FSA'
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
ALTER VIEW dbo.dsi_vwEEBCOBRAQB_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EEBCOBRAQB_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EEBCOBRAQB%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201901011'
       ,expStartPerControl     = '201901011'
       ,expLastEndPerControl   = '202003269'
       ,expEndPerControl       = '202003269'
WHERE expFormatCode = 'EEBCOBRAQB';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEEBCOBRAQB_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EEBCOBRAQB_File (NOLOCK)
    ORDER BY  InitialSort, SubSort, SubSort2, SubSort3;