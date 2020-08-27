/*
Directions:
1) Find and replace each of the text below with the applicable information.
       E.g. Replace the text "@DeveloperName" (excluding quotes) with "John Doe"
2) Deploy this to client environment!

-- Integration parameters
@CustomerName - Replace with customer name
@DeveloperName - Replace with TC name
@IntegrationAnalystName - Replace with BA/IC name
@CreateDate - Replace with date of creation
@SRNumber - Replace with SR number
@CustomFormatCode - Replace with Format Code (i.e., EEBCCOBRAQ)
@CustomFormatName - Replace with Name of Interface (AdfFormatName) (i.e., EBC Cobra QB Export)
@IsWebFlag - Replace with 'Y' (Yes) or 'N' (No) for Web Interface Settings

-- File parameters
@UDESPath - Replace with the UDES or PROD Path (J: drive)
@TestPath - Replace with the TEST Path (I: drive)

-- Data parameters
@ClientName - Replace with client name for NPM/QB tables
@ClientDivName - Replace with client div name for NPM/QB tables (note this could be a CASE statement)
@GroupID - Replace with Group ID and Customer Name (used in All filenames)
@24OR26 - Is biweekly 24 or 26 weeks? (replace with 24 or 26)
@PlanName - Replace with plan name for QBPLANINITIAL table (note this is LIKELY a CASE statement, so use this to find and skip to record in table)

NOTE: SEARCH FOR THE BELOW PARAMETERS TO SKIP TO THE RECORD IN THE TABLE INSTEAD OF FIND/REPLACE, TO ENSURE ',' FORMAT IS CORRECT
@SpousesCSV - Replace with SPS relationship codes in CSV format
@ChildrenCSV - Replace with CHL relationship codes in CSV format
@DomPartnerCSV - Replace with DP relationship codes in CSV format
@SPSRelationships - Replace with SPS relationship codes in quoted-CSV format
@DPRelationships - Replace with DP relationship codes in quoted-CSV format
@QMCORelationships - Replace with QMCSO relationship codes in quoted-CSV format
@EEBenOpts - Replace with EE only benefit options for drvCoverageLevel
@ECHBenOpts - Replace with EE+CHILDREN benefit options for drvCoverageLevel
@ESPBenOpts - Replace with EE+SPOUSE benefit options for drvCoverageLevel
@EDPBenOpts - Replace with EE+DOMESTICPARTNER benefit options for drvCoverageLevel
@EEFAMBenOpts - Replace with EE+FAMILY benefit options for drvCoverageLevel

*/
IF OBJECT_ID('dsi_vw@CustomFormatCode_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vw@CustomFormatCode_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_@CustomFormatCode') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_@CustomFormatCode];
GO
IF OBJECT_ID('U_@CustomFormatCode_File') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_File];
GO
IF OBJECT_ID('U_@CustomFormatCode_EEList') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_EEList];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_QBPLAN') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_QBPLAN];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_QBMSRI') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_QBMSRI];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_QBEVENT') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_QBEVENT];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_QBDEPPLAN') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_QBDEPPLAN];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_QBDEP') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_QBDEP];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_QB') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_QB];
GO
IF OBJECT_ID('U_dsi_BDM_@CustomFormatCode') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_@CustomFormatCode];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = '@CustomFormatCode';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = '@CustomFormatCode';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = '@CustomFormatCode';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = '@CustomFormatCode';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = '@CustomFormatCode';
GO

DECLARE @AdhSystemID VARCHAR(12), @FixedFormatName VARCHAR(50);
SET @AdhSystemID = LEFT('@CustomFormatCode' + REPLICATE('0',10),10) + 'Z0';
SET @FixedFormatName = LEFT('@CustomFormatName',50);

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) SELECT 'N','C','Y','0','','N',NULL,'','N','','013010','EMPEXPORT','CDE','@CustomFormatCode',@FixedFormatName,'N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N',@AdhSystemID,'N','Jan  1 1900 12:00AM','C','N','','';
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"[VERSION]"','1','(''DA''=''T,'')',@AdhSystemID,'25','H','01','1',NULL,'Column Header',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"1"','2','(''DA''=''T'')',@AdhSystemID,'5','H','01','2',NULL,'Version Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"[QB]"','1','(''DA''=''T,'')',@AdhSystemID,'50','D','10','1',NULL,'Record',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvClientName"','2','(''UA''=''T,'')',@AdhSystemID,'100','D','10','2',NULL,'ClientName',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvClientDivName"','3','(''UA''=''T,'')',@AdhSystemID,'50','D','10','3',NULL,'ClientDivisionName',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','4','(''SS''=''T,'')',@AdhSystemID,'35','D','10','4',NULL,'Salutation',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvNameFirst"','5','(''UA''=''T,'')',@AdhSystemID,'50','D','10','5',NULL,'FirstName',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvNameMiddle"','6','(''UA''=''T,'')',@AdhSystemID,'1','D','10','6',NULL,'MiddleInitial',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvNameLast"','7','(''UA''=''T,'')',@AdhSystemID,'50','D','10','7',NULL,'LastName',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSSN"','8','(''UA''=''T,'')',@AdhSystemID,'9','D','10','8',NULL,'SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmpNo"','9','(''UA''=''T,'')',@AdhSystemID,'50','D','10','9',NULL,'IndividualID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAddressEmail"','10','(''UA''=''T,'')',@AdhSystemID,'255','D','10','10',NULL,'Email',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvHomeNumber"','11','(''UA''=''T,'')',@AdhSystemID,'15','D','10','11',NULL,'Phone',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','12','(''SS''=''T,'')',@AdhSystemID,'15','D','10','12',NULL,'Phone2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAddressLine1"','13','(''UA''=''T,'')',@AdhSystemID,'50','D','10','13',NULL,'Address1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAddressLine2"','14','(''UA''=''T,'')',@AdhSystemID,'50','D','10','14',NULL,'Address2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAddressCity"','15','(''UA''=''T,'')',@AdhSystemID,'50','D','10','15',NULL,'City',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAddressState"','16','(''UA''=''T,'')',@AdhSystemID,'50','D','10','16',NULL,'StateOrProvince',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAddressZipCode"','17','(''UA''=''T,'')',@AdhSystemID,'35','D','10','17',NULL,'PostalCode',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAddressCountry"','18','(''UA''=''T,'')',@AdhSystemID,'50','D','10','18',NULL,'Country',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"True"','19','(''DA''=''T,'')',@AdhSystemID,'5','D','10','19',NULL,'PremiumAddressSameAsPrimary',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','20','(''SS''=''T,'')',@AdhSystemID,'50','D','10','20',NULL,'PremiumAddress1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','21','(''SS''=''T,'')',@AdhSystemID,'50','D','10','21',NULL,'PremiumAddress2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','22','(''SS''=''T,'')',@AdhSystemID,'50','D','10','22',NULL,'PremiumCity',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','23','(''SS''=''T,'')',@AdhSystemID,'50','D','10','23',NULL,'PremiumStateOrProvince',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','24','(''SS''=''T,'')',@AdhSystemID,'35','D','10','24',NULL,'PremiumPostalCode',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','25','(''SS''=''T,'')',@AdhSystemID,'50','D','10','25',NULL,'PremiumCountry',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvGender "','26','(''UA''=''T,'')',@AdhSystemID,'1','D','10','26',NULL,'Sex',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDateOfBirth"','27','(''UD101''=''T,'')',@AdhSystemID,'10','D','10','27',NULL,'DOB',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"UNKNOWN"','28','(''DA''=''T,'')',@AdhSystemID,'35','D','10','28',NULL,'TobaccoUse',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"UNKNOWN"','29','(''DA''=''T,'')',@AdhSystemID,'35','D','10','29',NULL,'EmployeeType',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"UNKNOWN"','30','(''DA''=''T,'')',@AdhSystemID,'35','D','10','30',NULL,'EmployeePayrollType',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','31','(''SS''=''T,'')',@AdhSystemID,'10','D','10','31',NULL,'YearsOfService',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"COUPONBOOK"','32','(''DA''=''T,'')',@AdhSystemID,'35','D','10','32',NULL,'PremiumCouponType',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"False"','33','(''DA''=''T,'')',@AdhSystemID,'5','D','10','33',NULL,'UsesHCTC',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"True"','34','(''DA''=''T,'')',@AdhSystemID,'5','D','10','34',NULL,'Active',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','35','(''SS''=''T,'')',@AdhSystemID,'5','D','10','35',NULL,'AllowMemberSSO',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','36','(''SS''=''T,'')',@AdhSystemID,'50','D','10','36',NULL,'BenefitGroup',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','37','(''SS''=''T,'')',@AdhSystemID,'50','D','10','37',NULL,'AccountStructure',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','38','(''SS''=''T'')',@AdhSystemID,'50','D','10','38',NULL,'ClientSpecificData',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"[QBEVENT]"','1','(''DA''=''T,'')',@AdhSystemID,'50','D','20','1',NULL,'Record',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEventType"','2','(''UA''=''T,'')',@AdhSystemID,'35','D','20','2',NULL,'EventType',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEventDate"','3','(''UD101''=''T,'')',@AdhSystemID,'10','D','20','3',NULL,'EventDate',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEnrollmentDate"','4','(''UD101''=''T,'')',@AdhSystemID,'10','D','20','4',NULL,'EnrollmentDate',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSSN"','5','(''UA''=''T,'')',@AdhSystemID,'9','D','20','5',NULL,'EmployeeSSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvName"','6','(''UA''=''T,'')',@AdhSystemID,'100','D','20','6',NULL,'EmployeeName',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','7','(''SS''=''T,'')',@AdhSystemID,'10','D','20','7',NULL,'SecondEventOriginalFDOC',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','8','(''SS''=''T,'')',@AdhSystemID,'5','D','20','8',NULL,'IsSecondEventAEIEligible',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','9','(''SS''=''T'')',@AdhSystemID,'10','D','20','9',NULL,'SecondEventAEISubsidyStartDate',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"[QBPLANINITIAL]"','1','(''DA''=''T,'')',@AdhSystemID,'50','D','30','1',NULL,'Record',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPlanName"','2','(''UA''=''T,'')',@AdhSystemID,'50','D','30','2',NULL,'PlanName',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCoverageLevel"','3','(''UA''=''T,'')',@AdhSystemID,'35','D','30','3',NULL,'CoverageLevel',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','4','(''SS''=''T'')',@AdhSystemID,'10','D','30','4',NULL,'NumberOfUnits',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"[QBDEPENDENT]"','1','(''DA''=''T,'')',@AdhSystemID,'50','D','50','1',NULL,'Record',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSSN"','2','(''UA''=''T,'')',@AdhSystemID,'9','D','50','2',NULL,'SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvRelationship"','3','(''UA''=''T,'')',@AdhSystemID,'35','D','50','3',NULL,'Relationship',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','4','(''SS''=''T,'')',@AdhSystemID,'35','D','50','4',NULL,'Salutation',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvNameFirst"','5','(''UA''=''T,'')',@AdhSystemID,'50','D','50','5',NULL,'FirstName',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvNameMiddle"','6','(''UA''=''T,'')',@AdhSystemID,'1','D','50','6',NULL,'MiddleInitial',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvNameLast"','7','(''UA''=''T,'')',@AdhSystemID,'50','D','50','7',NULL,'LastName',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmail"','8','(''UA''=''T,'')',@AdhSystemID,'255','D','50','8',NULL,'Email',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvHomeNumber"','9','(''UA''=''T,'')',@AdhSystemID,'15','D','50','9',NULL,'Phone',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','10','(''SS''=''T,'')',@AdhSystemID,'15','D','50','10',NULL,'Phone2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvIsAddressSame"','11','(''UA''=''T,'')',@AdhSystemID,'5','D','50','11',NULL,'AddressSameAsQB',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAddressLine1"','12','(''UA''=''T,'')',@AdhSystemID,'50','D','50','12',NULL,'Address1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAddressLine2"','13','(''UA''=''T,'')',@AdhSystemID,'50','D','50','13',NULL,'Address2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAddressCity"','14','(''UA''=''T,'')',@AdhSystemID,'50','D','50','14',NULL,'City',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAddressState"','15','(''UA''=''T,'')',@AdhSystemID,'50','D','50','15',NULL,'StateOrProvince',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAddressZipCode"','16','(''UA''=''T,'')',@AdhSystemID,'35','D','50','16',NULL,'PostalCode',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAddressCountry"','17','(''UA''=''T,'')',@AdhSystemID,'50','D','50','17',NULL,'Country',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','18','(''SS''=''T,'')',@AdhSystemID,'10','D','50','18',NULL,'EnrollmentDate',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvGender"','19','(''UA''=''T,'')',@AdhSystemID,'1','D','50','19',NULL,'Sex',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDateofBirth"','20','(''UD101''=''T,'')',@AdhSystemID,'10','D','50','20',NULL,'DOB',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"False"','21','(''DA''=''T,'')',@AdhSystemID,'5','D','50','21',NULL,'IsQMCSO',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"[QBDEPENDENTPLANINITIAL]"','1','(''DA''=''T,'')',@AdhSystemID,'50','D','60','1',NULL,'Record',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPlanName"','2','(''UA''=''T'')',@AdhSystemID,'50','D','60','2',NULL,'PlanName',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"[QBPLANMEMBERSPECIFICRATEINITIAL]"','1','(''DA''=''T'',)',@AdhSystemID,'50','D','70','1',NULL,'Record',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPlanName"','2','(''UA''=''T,'')',@AdhSystemID,'50','D','70','2',NULL,'PlanName',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvRate"','3','(''UA''=''T'')',@AdhSystemID,'25','D','70','3',NULL,'Rate',NULL,NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Testing Purposes Only','201710019','EMPEXPORT','TEST','Oct  1 2017 12:00AM','@CustomFormatCode',NULL,NULL,NULL,'201710019','Oct  1 2017 12:00AM','Dec 30 1899 12:00AM','201710011',NULL,'','','201710011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'EBC Cobra QB File','201710019','EMPEXPORT','ONDEMAND','Oct  1 2017 12:00AM','@CustomFormatCode',NULL,NULL,NULL,'201710019','Oct  1 2017 12:00AM','Dec 30 1899 12:00AM','201710011',NULL,'','','201710011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','ExportPath','V','@UDESPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','InitialSort','C',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','SubSort2','C','drvSubSort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','SubSort3','C','drvSubSort3');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','TestPath','V','@TestPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','UDESPath','V','@UDESPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','UseFileName','V','N');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','H10','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D10','U_@CustomFormatCode_drvTbl_QB',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D20','U_@CustomFormatCode_drvTbl_QBEVENT',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D30','U_@CustomFormatCode_drvTbl_QBPLAN',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D50','U_@CustomFormatCode_drvTbl_QBDEP',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D60','U_@CustomFormatCode_drvTbl_QBDEPPLAN',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D70','U_@CustomFormatCode_drvTbl_QBMSRI',NULL);
GO
IF ('@IsWebFlag' = 'Y')
BEGIN
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = '@CustomFormatCode' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */

/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = '@CustomFormatCode.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
UPDATE dbo.AscExp SET expAscFileName = @FILEPATH + @FILENAME WHERE expFormatCode = '@CustomFormatCode';

/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = '@CustomFormatCode' AND CfgName = 'ExportPath' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = '@CustomFormatCode' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
/*03*/ DELETE FROM dbo.U_dsi_Configuration WHERE FormatCode = '@CustomFormatCode' AND CfgName = 'TestPath'; /* Remove Test Path for Web Exports */

END
GO
IF OBJECT_ID('U_@CustomFormatCode_EEList') IS NULL
CREATE TABLE [dbo].[U_@CustomFormatCode_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_@CustomFormatCode_File') IS NULL
CREATE TABLE [dbo].[U_@CustomFormatCode_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(50) NOT NULL,
    [SubSort] varchar(50) NOT NULL,
    [SubSort2] varchar(50) NULL,
    [SubSort3] varchar(50) NULL,
    [Data] varchar(2000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_@CustomFormatCode]
    @systemid CHAR(12)
AS
/************************************************************
Client: @CustomerName

Created By: @DeveloperName
Business Analyst: @IntegrationAnalystName
Create Date: @CreateDate
Service Request Number: @SRNumber

Purpose: @CustomFormatName

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/20XX     SR-20XX-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.AscExp WHERE expFormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = '@CustomFormatCode' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'TEST';

EXEC dbo.dsi_BDM_sp_ErrorCheck '@CustomFormatCode';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = '@CustomFormatCode', @AllObjects = 'Y', @IsWeb = 'Y'
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

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl  = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = CAST(LEFT(StartPerControl,8) AS DATETIME)
        ,@EndDate         = DATEADD(SS,-1,DATEADD(DD,1,LEFT(EndPerControl,8)))
        ,@FormatCode      = FormatCode
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = '@CustomFormatCode';

    --==========================================
    -- Clean EE List
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_@CustomFormatCode_EELIST
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCoID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_@CustomFormatCode_EELIST GROUP BY xEEID HAVING COUNT(1) > 1);

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
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','Y'); -- DedIsCobraCovered = 'Y'
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraType','2'); -- EdhChangeReason and ConCobraReason
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraDate','2'); -- EedBenStopDate and DbnBenStopDate
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraPQBType','1'); -- If no EE or spouse, ALL children are PQB (not just oldest)
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidTermReasonsEmp','203'); -- Invalidate employee when Cobra Reason is "Death"
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CountDependents','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','@SpousesCSV');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','@ChildrenCSV');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','@DomPartnerCSV');

    -- Run BDM for QB
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    ----------------------------------------------
    -- Invalidate dependent PQBs where cobra reason not valid
    ----------------------------------------------
    UPDATE dbo.U_dsi_BDM_DepDeductions
    SET  DbnValidForExport = 'N'
        ,DbnDedRowStatus   = 'EE not on file and ConCOBRAReason not valid'
    FROM dbo.EmpComp WITH (NOLOCK)
    WHERE EecEEID = DbnEEID
        AND EecCoID = DbnCoID
        AND ISNULL(EecTermReason,'') <> '203'
        AND DbnCobraReason NOT IN ('201','204','210','LEVNT3','LEVNT4')
        AND DbnFormatCode = @FormatCode
        AND DbnValidForExport = 'Y'
        AND DbnRunID = 'QB'
        AND NOT EXISTS(SELECT 1 FROM dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
                        WHERE EedEEID = DbnEEID
                        AND EedCoID = DbnCoID
                        AND EedDedCode = DbnDedCode
                        AND EedFormatCode = @FormatCode
                        AND EedValidForExport = 'Y'
                        AND EedRunID = 'QB');

    -- Run BuildConsolidatedTable SP for QB run
    EXEC dbo.dsi_BDM_sp_BuildConsolidatedTable @FormatCode, 'Standard';

    --==========================================
    -- Build Employee Data and the driver tables
    --==========================================

    ------------------
    -- QB DETAIL RECORD
    ------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_QB') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_QB;
    SELECT DISTINCT
         drvEEID           = BdmEEID
        ,drvCoID           = BdmCoID
        ,drvDepRecID       = ISNULL(BdmDepRecID,'')
        ,drvClientName     = CONVERT(varchar(100),'@ClientName')
        ,drvClientDivName  = CONVERT(varchar(50),'@ClientDivName')
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
        ,drvAddressEmail   = EepAddressEmail
        ,drvHomeNumber     = EepPhoneHomeNumber
        ,drvBusinessNumber = NULL
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
        ,drvAddressCountry = CASE WHEN BdmRecType = 'EMP' AND EepAddressCountry <> 'USA' THEN EepAddressCountry
                                  WHEN ConAddressLine1 IS NULL AND ConAddressCountry <> 'USA' THEN ConAddressCountry
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
    INTO dbo.U_@CustomFormatCode_drvTbl_QB
    FROM dbo.U_dsi_BDM_@CustomFormatCode WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = BdmEEID
        AND EecCoID = BdmCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = BdmEEID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = BdmEEID
        AND ConSystemID = BdmDepRecID
    WHERE BdmIsPQB = 'Y';

    ------------------
    -- QBEVENT DETAIL RECORD
    ------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_QBEVENT') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_QBEVENT;
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
                                  WHEN BdmCobraReason = '203' THEN 'REDUCTIONINHOURS-STATUSCHANGE'
                                  WHEN BdmCobraReason = '205' THEN 'MEDICARE'
                                  WHEN BdmCobraReason = '206' THEN 'REDUCTIONINHOURS-ENDOFLEAVE'
                                  WHEN BdmCobraReason = '207' THEN 'USERRA-REDUCTIONINHOURS'
                                  WHEN BdmCobraReason = '208' THEN 'RETIREMENT'
                                  WHEN BdmCobraReason = '209' THEN 'WORKSTOPPAGE'
                                  ELSE 'TERMINATION'
                             END
        ,drvEventDate      = BdmDateOfCOBRAEvent
        ,drvEnrollmentDate = BdmBenStartDate
        ,drvSSN            = eepSSN
        ,drvName           = CASE WHEN BdmRecType = 'DEP' THEN RTRIM(EepNameFirst) + ' ' + EepNameLast
                                  ELSE ''
                             END
        ,drvSubSort        = drvSubSort
        ,drvSubSort2       = '1'
        ,drvSubSort3       = drvSubSort3
    INTO dbo.U_@CustomFormatCode_drvTbl_QBEVENT
    FROM dbo.U_@CustomFormatCode_drvTbl_QB WITH (NOLOCK)
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
            FROM dbo.U_dsi_BDM_@CustomFormatCode WITH (NOLOCK)
            WHERE BdmIsPQB = 'Y'
            GROUP BY BdmEEID, BdmCoID, BdmDepRecID, BdmRecType) BDM
        ON BdmEEID = drvEEID
        AND BdmCoID = drvCoID
        AND ISNULL(BdmDepRecID,'') = drvDepRecID;

    ------------------
    -- QBPLANINITIAL DETAIL RECORD
    ------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_QBPLAN') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_QBPLAN;
    SELECT DISTINCT
         drvEEID          = drvEEID
        ,drvCoID          = drvCoID
        ,drvDepRecID      = drvDepRecID
        ,drvDedCode       = BdmDedCode
        ,drvPlanName      = CONVERT(varchar(50),'@PlanName')
        ,drvCoverageLevel = CASE WHEN BdmDedType = 'FSA' THEN 'EE'
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
                            END
        ,drvSubSort       = drvSubSort
        ,drvSubSort2      = '1' + BdmDedCode
        ,drvSubSort3      = drvSubSort3
    INTO dbo.U_@CustomFormatCode_drvTbl_QBPLAN
    FROM dbo.U_@CustomFormatCode_drvTbl_QBEVENT WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_@CustomFormatCode WITH (NOLOCK)
        ON BdmEEID = drvEEID
        AND BdmCoID = drvCoID
        AND ISNULL(BdmDepRecID,'') = drvDepRecID
    WHERE BdmIsPQB = 'Y';

    ------------------
    -- QBDEPENDENT DETAIL RECORD
    ------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_QBDEP') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_QBDEP;
    SELECT DISTINCT
         drvEEID           = BdmEEID
        ,drvCoID           = BdmCoID
        ,drvDepRecID       = BdmDepRecID
        ,drvSSN            = ISNULL(ConSSN,'')
        ,drvRelationship   = CASE WHEN BdmRelationship IN ('@SPSRelationships') THEN 'SPOUSE'
                                  WHEN BdmRelationship IN ('@DPRelationships') THEN 'DOMESTICPARTNER'
                                  ELSE 'CHILD'
                             END
        ,drvNameFirst      = ConNameFirst
        ,drvNameMiddle     = LEFT(ConNameMiddle,1)
        ,drvNameLast       = ConNameLast
        ,drvEmail          = ConEmailAddr
        ,drvHomeNumber     = ConPhoneHomeNumber
        ,drvIsAddressSame  = CASE WHEN ConAddressIsDifferent = 'N' OR ConAddressLine1 IS NULL THEN 'TRUE'
                                  ELSE 'FALSE'
                             END
        ,drvAddressLine1   = ConAddressLine1
        ,drvAddressLine2   = ConAddressLine2
        ,drvAddressCity    = ConAddressCity
        ,drvAddressState   = ConAddressState
        ,drvAddressZipCode = ConAddressZipCode
        ,drvAddressCountry = CASE WHEN ConAddressCountry <> 'USA' THEN ConAddressCountry END
        ,drvGender         = ConGender
        ,drvDateOfBirth    = ConDateOfBirth
        ,drvSubSort        = drvSubSort
        ,drvSubSort2       = '2' + CASE WHEN BdmRelationship IN ('@SPSRelationships','@DPRelationships') THEN 'A'
                                        ELSE 'B' + ISNULL(ConSSN,'')
                                   END
        ,drvSubSort3       = drvSubSort3
    INTO dbo.U_@CustomFormatCode_drvTbl_QBDEP
    FROM dbo.U_@CustomFormatCode_drvTbl_QB WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_@CustomFormatCode WITH (NOLOCK)
        ON BdmEEID = drvEEID
        AND BdmCoID = drvCoID
    JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = BdmEEID
        AND ConSystemID = BdmDepRecID
    WHERE BdmIsPQB = 'N';

    ------------------
    -- QBDEPENDENTPLANINITIAL DETAIL RECORD
    ------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_QBDEPPLAN') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_QBDEPPLAN;
    SELECT DISTINCT
         drvEEID     = BdmEEID
        ,drvCoID     = BdmCoID
        ,drvDepRecID = BdmDepRecID
        ,drvDedCode  = BdmDedCode
        ,drvPlanName = drvPlanName
        ,drvSubSort  = drvSubSort
        ,drvSubSort2 = '2' + CASE WHEN BdmRelationship IN ('@SPSRelationships','@DPRelationships') THEN 'A'
                                  ELSE 'B' + RTRIM(ISNULL(ConSSN,''))
                             END + BdmDedCode
        ,drvSubSort3 = drvSubSort3
    INTO dbo.U_@CustomFormatCode_drvTbl_QBDEPPLAN
    FROM dbo.U_@CustomFormatCode_drvTbl_QBPLAN WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_@CustomFormatCode WITH (NOLOCK)
        ON BdmEEID = drvEEID
        AND BdmCoID = drvCoID
        AND BdmDedCode = drvDedCode
    JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = BdmEEID
        AND ConSystemID = BdmDepRecID
    WHERE BdmIsPQB = 'N';

    ------------------
    -- QBPLANMEMBERSPECIFICRATEINITIAL DETAIL RECORD
    ------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_QBMSRI') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_QBMSRI;
    SELECT DISTINCT
         drvEEID     = drvEEID
        ,drvCoID     = drvCoID
        ,drvDepRecID = drvDepRecID
        ,drvPlanName = drvPlanName
        ,drvRate     = CASE WHEN EecPayPeriod = 'M' THEN BdmEEAmt
                            WHEN EecPayPeriod = 'S' THEN BdmEEAmt * 2
                            WHEN EecPayPeriod = 'B' THEN BdmEEAmt * @24OR26 /12
                            WHEN EecPayPeriod = 'W' THEN BdmEEAmt * 52/12
                        END
        ,drvSubSort  = drvSubSort
        ,drvSubSort2 = '3'
        ,drvSubSort3 = drvSubSort3
    INTO dbo.U_@CustomFormatCode_drvTbl_QBMSRI
    FROM dbo.U_@CustomFormatCode_drvTbl_QBPLAN WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_@CustomFormatCode WITH (NOLOCK)
        ON BdmEEID = drvEEID
        AND BdmCoID = drvCoID
        AND ISNULL(BdmDepRecID,'') = drvDepRecID
        AND BdmDedCode = drvDedCode
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = BdmEEID
        AND EecCoID = BdmCoID
    WHERE BdmIsPQB = 'Y'
    AND BdmDedType = 'FSA';

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode, 'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
        SET ExportFile = '@FileCustomerName_COBRA-QB-'
                            + CASE WHEN dbo.dsi_fnVariable(@FormatCode, 'Testing') = 'Y' THEN 'TEST_'
                                   WHEN @Exportcode = 'TEST' THEN 'TEST_'
                                   ELSE ''
                            END
                            + CONVERT(CHAR(8), GETDATE(), 112)                       --YYYYMMDD
                            + REPLACE(CONVERT(VARCHAR(10), GETDATE(), 108), ':', '') --HHMMSS
                            + '.csv'
        WHERE FormatCode = @FormatCode;
    END

END
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vw@CustomFormatCode_Export AS
    SELECT TOP 2000000 Data FROM dbo.U_@CustomFormatCode_File WITH (NOLOCK)
    ORDER BY SubSort, SubSort2, SubSort3, RecordSet;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE '@CustomFormatCode%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET ExpLastStartPerControl = '201710011'
       ,ExpStartPerControl     = '201710011'
       ,ExpLastEndPerControl   = '201710019'
       ,ExpEndPerControl       = '201710019'
WHERE ExpFormatCode = '@CustomFormatCode';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vw@CustomFormatCode_Export AS
    SELECT TOP 2000000 Data FROM dbo.U_@CustomFormatCode_File WITH (NOLOCK)
    ORDER BY SubSort, SubSort2, SubSort3, RecordSet;
GO