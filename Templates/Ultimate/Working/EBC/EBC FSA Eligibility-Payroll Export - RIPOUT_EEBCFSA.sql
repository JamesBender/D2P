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
@CustomFormatCode - Replace with Format Code (i.e., EEBCFSA)
@CustomFormatName - Replace with Name of Interface (AdfFormatName) (i.e., EBC FSA Eligibility-Payroll Export)
@IsWebFlag - Replace with 'Y' (Yes) or 'N' (No) for Web Interface Settings

-- Data parameters
@GroupID - Replace with Group ID and Customer Name (used in All filenames)
@FSADedCodes - Replace with FSA Deduction Codes

-- File parameters
@UDESPath - Replace with the UDES or PROD Path (J: drive)
@TestPath - Replace with the TEST Path (I: drive)
@FileCustomerName - Replace with Customer Name (used in All filenames)

*/
IF OBJECT_ID('dsi_vw@CustomFormatCode_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vw@CustomFormatCode_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_@CustomFormatCode') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_@CustomFormatCode];
GO
IF OBJECT_ID('U_@CustomFormatCode_File') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_File];
GO
IF OBJECT_ID('U_@CustomFormatCode_EEList') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_EEList];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_Trailer') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_Trailer];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl];
GO
IF OBJECT_ID('U_@CustomFormatCode_CurrDeds') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_CurrDeds];
GO
IF OBJECT_ID('U_@CustomFormatCode_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_AuditFields];
GO
IF OBJECT_ID('U_@CustomFormatCode_Audit') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_Audit];
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

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) SELECT 'N','C','Y','0','','N',NULL,'','N','','013010','EMPEXPORT','CDE','@CustomFormatCode',@FixedFormatName,'N','E','FORM_EMPEXPORT','N','C','AYGJ9G0000K0','D','dbo.dsi_sp_Switchbox_v2','2000','S','N',@AdhSystemID,'N','Jan  1 1900 12:00AM','C','N','','';
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"PartnerID"','1','(''DA''=''T|'')',@AdhSystemID,'14','H','01','1',NULL,'PartnerID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"InsuredID"','2','(''DA''=''T|'')',@AdhSystemID,'14','H','01','2',NULL,'InsuredID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"MemberID"','3','(''DA''=''T|'')',@AdhSystemID,'13','H','01','3',NULL,'MemberID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Relation"','4','(''DA''=''T|'')',@AdhSystemID,'13','H','01','4',NULL,'Relation',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"LastName"','5','(''DA''=''T|'')',@AdhSystemID,'13','H','01','5',NULL,'LastName',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"FirstName"','6','(''DA''=''T|'')',@AdhSystemID,'14','H','01','6',NULL,'FirstName',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"MI"','7','(''DA''=''T|'')',@AdhSystemID,'7','H','01','7',NULL,'MI',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"SSN"','8','(''DA''=''T|'')',@AdhSystemID,'8','H','01','8',NULL,'SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"GroupID"','9','(''DA''=''T|'')',@AdhSystemID,'12','H','01','9',NULL,'GroupID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"GroupName"','10','(''DA''=''T|'')',@AdhSystemID,'14','H','01','10',NULL,'GroupName',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Addr1"','11','(''DA''=''T|'')',@AdhSystemID,'10','H','01','11',NULL,'Addr1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Addr2"','12','(''DA''=''T|'')',@AdhSystemID,'10','H','01','12',NULL,'Addr2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"City"','13','(''DA''=''T|'')',@AdhSystemID,'9','H','01','13',NULL,'City',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"State"','14','(''DA''=''T|'')',@AdhSystemID,'10','H','01','14',NULL,'State',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Zip"','15','(''DA''=''T|'')',@AdhSystemID,'8','H','01','15',NULL,'Zip',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DOB"','16','(''DA''=''T|'')',@AdhSystemID,'8','H','01','16',NULL,'DOB',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DOH"','17','(''DA''=''T|'')',@AdhSystemID,'8','H','01','17',NULL,'DOH',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"PrimaryPhone"','18','(''DA''=''T|'')',@AdhSystemID,'17','H','01','18',NULL,'PrimaryPhone',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Extension"','19','(''DA''=''T|'')',@AdhSystemID,'14','H','01','19',NULL,'Extension',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"SecondaryPhone"','20','(''DA''=''T|'')',@AdhSystemID,'19','H','01','20',NULL,'SecondaryPhone',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"SecondaryExtension"','21','(''DA''=''T|'')',@AdhSystemID,'23','H','01','21',NULL,'SecondaryExtension',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"CellPhone"','22','(''DA''=''T|'')',@AdhSystemID,'14','H','01','22',NULL,'CellPhone',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Fax"','23','(''DA''=''T|'')',@AdhSystemID,'8','H','01','23',NULL,'Fax',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"WorkEmail"','24','(''DA''=''T|'')',@AdhSystemID,'14','H','01','24',NULL,'WorkEmail',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"PersonalEmail"','25','(''DA''=''T|'')',@AdhSystemID,'18','H','01','25',NULL,'PersonalEmail',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"UseWorkEmail"','26','(''DA''=''T|'')',@AdhSystemID,'17','H','01','26',NULL,'UseWorkEmail',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"EffDate"','27','(''DA''=''T|'')',@AdhSystemID,'12','H','01','27',NULL,'EffDate',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"EndDate"','28','(''DA''=''T|'')',@AdhSystemID,'12','H','01','28',NULL,'EndDate',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"PlanType"','29','(''DA''=''T|'')',@AdhSystemID,'13','H','01','29',NULL,'PlanType',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Election"','30','(''DA''=''T|'')',@AdhSystemID,'13','H','01','30',NULL,'Election',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"ERContribution"','31','(''DA''=''T|'')',@AdhSystemID,'19','H','01','31',NULL,'ERContribution',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"PayrollSchedule"','32','(''DA''=''T|'')',@AdhSystemID,'20','H','01','32',NULL,'PayrollSchedule',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Division"','33','(''DA''=''T|'')',@AdhSystemID,'13','H','01','33',NULL,'Division',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"AltID"','34','(''DA''=''T|'')',@AdhSystemID,'10','H','01','34',NULL,'AltID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Gender"','35','(''DA''=''T|'')',@AdhSystemID,'11','H','01','35',NULL,'Gender',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"HICN"','36','(''DA''=''T|'')',@AdhSystemID,'9','H','01','36',NULL,'HICN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"PayrollDate"','37','(''DA''=''T|'')',@AdhSystemID,'16','H','01','37',NULL,'PayrollDate',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"PayrollDeduction"','38','(''DA''=''T|'')',@AdhSystemID,'21','H','01','38',NULL,'PayrollDeduction',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DepositType"','39','(''DA''=''T|'')',@AdhSystemID,'16','H','01','39',NULL,'DepositType',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"QE_Date"','40','(''DA''=''T|'')',@AdhSystemID,'12','H','01','40',NULL,'QE_Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"FirstPayrollDate"','41','(''DA''=''T|'')',@AdhSystemID,'21','H','01','41',NULL,'FirstPayrollDate',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"QE_Reason"','42','(''DA''=''T|'')',@AdhSystemID,'14','H','01','42',NULL,'QE_Reason',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"LastPayrollDate"','43','(''DA''=''T'')',@AdhSystemID,'20','H','01','43',NULL,'LastPayrollDate',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Ultimate"','1','(''DA''=''T|'')',@AdhSystemID,'50','D','10','1',NULL,'PartnerID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvInsuredID"','2','(''UA''=''T|'')',@AdhSystemID,'255','D','10','2',NULL,'InsuredID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMemberID"','3','(''UA''=''T|'')',@AdhSystemID,'255','D','10','3',NULL,'MemberID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"18"','4','(''DA''=''T|'')',@AdhSystemID,'2','D','10','4',NULL,'Relation',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLastName"','5','(''UA''=''T|'')',@AdhSystemID,'50','D','10','5',NULL,'LastName',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvFirstName"','6','(''UA''=''T|'')',@AdhSystemID,'50','D','10','6',NULL,'FirstName',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMI"','7','(''UA''=''T|'')',@AdhSystemID,'50','D','10','7',NULL,'MI',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSSN"','8','(''UA''=''T|'')',@AdhSystemID,'11','D','10','8',NULL,'SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"@GroupID"','9','(''DA''=''T|'')',@AdhSystemID,'25','D','10','9',NULL,'GroupID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"@GroupID Flexible Compensation Plan"','10','(''DA''=''T|'')',@AdhSystemID,'100','D','10','10',NULL,'GroupName',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAddr1"','11','(''UA''=''T|'')',@AdhSystemID,'255','D','10','11',NULL,'Addr1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAddr2"','12','(''UA''=''T|'')',@AdhSystemID,'255','D','10','12',NULL,'Addr2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCity"','13','(''UA''=''T|'')',@AdhSystemID,'50','D','10','13',NULL,'City',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvState"','14','(''UA''=''T|'')',@AdhSystemID,'2','D','10','14',NULL,'State',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvZip"','15','(''UA''=''T|'')',@AdhSystemID,'10','D','10','15',NULL,'Zip',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDOB"','16','(''UD120''=''T|'')',@AdhSystemID,'10','D','10','16',NULL,'DOB',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDOH"','17','(''UD120''=''T|'')',@AdhSystemID,'10','D','10','17',NULL,'DOH',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPrimaryPhone"','18','(''UA''=''T|'')',@AdhSystemID,'10','D','10','18',NULL,'PrimaryPhone',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvExtension"','19','(''UA''=''T|'')',@AdhSystemID,'5','D','10','19',NULL,'Extension',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSecondaryPhone"','20','(''UA''=''T|'')',@AdhSystemID,'10','D','10','20',NULL,'SecondaryPhone',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','21','(''SS''=''T|'')',@AdhSystemID,'5','D','10','21',NULL,'SecondaryExtension',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCellPhone"','22','(''UA''=''T|'')',@AdhSystemID,'10','D','10','22',NULL,'CellPhone',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','23','(''SS''=''T|'')',@AdhSystemID,'10','D','10','23',NULL,'Fax',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvWorkEmail"','24','(''UA''=''T|'')',@AdhSystemID,'100','D','10','24',NULL,'WorkEmail',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPersonalEmail"','25','(''UA''=''T|'')',@AdhSystemID,'100','D','10','25',NULL,'PersonalEmail',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"0"','26','(''DA''=''T|'')',@AdhSystemID,'1','D','10','26',NULL,'UseWorkEmail',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEffDate"','27','(''UD120''=''T|'')',@AdhSystemID,'10','D','10','27',NULL,'EffDate',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEndDate"','28','(''UD120''=''T|'')',@AdhSystemID,'10','D','10','28',NULL,'EndDate',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPlanType"','29','(''UA''=''T|'')',@AdhSystemID,'20','D','10','29',NULL,'PlanType',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvElection"','30','(''UNT2''=''T|'')',@AdhSystemID,'15','D','10','30',NULL,'Election',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvERContribution"','31','(''UNT2''=''T|'')',@AdhSystemID,'15','D','10','31',NULL,'ERContribution',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"BW24"','32','(''DA''=''T|'')',@AdhSystemID,'50','D','10','32',NULL,'PayrollSchedule',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','33','(''SS''=''T|'')',@AdhSystemID,'50','D','10','33',NULL,'Division',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAltID"','34','(''UA''=''T|'')',@AdhSystemID,'50','D','10','34',NULL,'AltID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvGender"','35','(''UA''=''T|'')',@AdhSystemID,'1','D','10','35',NULL,'Gender',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','36','(''SS''=''T|'')',@AdhSystemID,'10','D','10','36',NULL,'HICN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPayrollDate"','37','(''UD120''=''T|'')',@AdhSystemID,'10','D','10','37',NULL,'PayrollDate',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPayrollDeduction"','38','(''UNT2''=''T|'')',@AdhSystemID,'15','D','10','38',NULL,'PayrollDeduction',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"0"','39','(''DA''=''T|'')',@AdhSystemID,'10','D','10','39',NULL,'DepositType',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','40','(''SS''=''T|'')',@AdhSystemID,'10','D','10','40',NULL,'QE_Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','41','(''SS''=''T|'')',@AdhSystemID,'10','D','10','41',NULL,'FirstPayrollDate',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','42','(''SS''=''T|'')',@AdhSystemID,'10','D','10','42',NULL,'QE_Reason',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','43','(''SS''=''T'')',@AdhSystemID,'10','D','10','43',NULL,'LastPayrollDate',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"elligibility"','1','(''DA''=''T|'')',@AdhSystemID,'17','T','90','1',NULL,'Eligibillity',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCountEligibility"','2','(''UNT0''=''T|'')',@AdhSystemID,'10','T','90','2',NULL,'Count Eligibility',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"deductions"','3','(''DA''=''T|'')',@AdhSystemID,'15','T','90','3',NULL,'Deductions',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCountDeductions"','4','(''UNT0''=''T|'')',@AdhSystemID,'10','T','90','4',NULL,'Count Deductions',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"deductionsum"','5','(''DA''=''T|'')',@AdhSystemID,'18','T','90','5',NULL,'Deduction Sum',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDeductionSum"','6','(''UNT2''=''T|)',@AdhSystemID,'15','T','90','6',NULL,'Deduction Sum Amt',NULL,NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Open Enrollment - Active','201704109','EMPEXPORT','OEACTIVE','Apr 19 2017 12:00AM','@CustomFormatCode',NULL,NULL,NULL,'201704109','Apr 10 2017 12:00AM','Dec 30 1899 12:00AM','201704031',NULL,'','','201704031',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Open Enrollment - Passive','201603119','EMPEXPORT','OEPASSIVE','Apr 19 2017 12:00AM','@CustomFormatCode',NULL,NULL,NULL,'201603119','Mar 11 2016 12:00AM','Dec 30 1899 12:00AM','201603111',NULL,'','','201603111',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Manual On-Demand File','201704199','EMPEXPORT','ONDEMAND','Apr 19 2017 12:00AM','@CustomFormatCode',NULL,NULL,NULL,'201704199','Apr 19 2017 12:00AM','Dec 30 1899 12:00AM','201704121',NULL,'','','201704121',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Testing Purposes Only','201704219','EMPEXPORT','TEST','Apr 20 2017 12:00AM','@CustomFormatCode',NULL,NULL,NULL,'201704219','Apr 21 2017 12:00AM','Dec 30 1899 12:00AM','201704081',NULL,'','','201704081',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','ExportPath','V','@UDESPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','TestPath','V','@TestPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','UDESPath','V','@UDESPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','UseFileName','V','N');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D10','U_@CustomFormatCode_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','T90','U_@CustomFormatCode_drvTbl_Trailer',NULL);
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
    -- BDM Code    
    --==========================================

    -- now set values for benefit module
    DELETE FROM dbo.U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode;

    -- Required parms
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'DedCodes','@FSADedCodes');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'StartDateTime',@startdate);
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'EndDateTime',@enddate);
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'TermSelectionOption','AuditDate');

    --Set if OE
    IF @exportcode LIKE '%PASSIVE'
    BEGIN
        INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode,'OEType','PASSIVE');
    END;

    IF @exportcode LIKE '%ACTIVE'
    BEGIN
        INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode,'OEType','ACTIVE');
    END;

    EXECUTE dbo.dsi_bdm_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Audit Code    
    --==========================================

    -- Get data from audit fields table.  Add fields here if auditing
    IF OBJECT_ID('U_@CustomFormatCode_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_AuditFields;
    CREATE TABLE dbo.U_@CustomFormatCode_AuditFields (aTableName VARCHAR(30),aFieldName VARCHAR(30));
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpDed','EedChangeReason');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_@CustomFormatCode_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_Audit;
    SELECT audKey1Value audEEID
        ,audKey2Value audKey2
        ,audKey3Value audKey3
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
    INTO dbo.U_@CustomFormatCode_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK)
    INNER JOIN dbo.U_@CustomFormatCode_AuditFields WITH (NOLOCK)
        ON audTableName = aTableName
        AND audFieldName = aFieldName
	WHERE audDateTime BETWEEN @StartDate AND @EndDate;

    --==========================================
    -- Build Employee Data and the driver tables
    --==========================================

    --------------------------------------------
    -- Working Table - Current Deduction Data
    --------------------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_CurrDeds','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_CurrDeds;
    SELECT cdEEID = PdhEEID
        ,cdCOID = PdhCOID
        ,cdDedCode = PdhDedCode
        ,cdPayDate = MAX(PdhPayDate)
        ,cdEECurAmt = SUM(ISNULL(PdhEECurAmt, 0.00))
    INTO dbo.U_@CustomFormatCode_CurrDeds
    FROM dbo.U_@CustomFormatCode_EELIST(NOLOCK)
    INNER JOIN dbo.PDedHist(NOLOCK)
        ON xEEID = PdhEEID
    WHERE PdhPerControl BETWEEN @StartPercontrol AND @EndPerControl
    AND PdhDedCode IN ('@FSADedCodes')
    GROUP BY PdhEEID
        ,PdhCOID
        ,PdhDedCode;

    --Get Pay date
    DECLARE @PayDate DATETIME;
    SET @PayDate = (SELECT TOP 1 cdPayDate FROM dbo.U_@CustomFormatCode_CurrDeds(NOLOCK));

    --------------------
    -- Detail Records
    --------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl;
    SELECT DISTINCT drvInsuredID = EepSSN
        ,drvMemberID = CONVERT(VARCHAR(9), RTRIM(EepSSN)) + '01'
        ,drvLastName = EepNameLast
        ,drvFirstName = EepNameFirst
        ,drvMI = EepNameMiddle
        ,drvSSN = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvAddr1 = EepAddressLine1
        ,drvAddr2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZip = SUBSTRING(EepAddressZipCode, 1, 5) + ISNULL('-' + NULLIF(SUBSTRING(EepAddressZipCode, 6, 4), ''), '')
        ,drvDOB = EepDateOfBirth
        ,drvDOH = EecDateOfLastHire
        ,drvPrimaryPhone = EecPhoneBusinessNumber
        ,drvExtension = EecPhoneBusinessExt
        ,drvSecondaryPhone = EepPhoneHomeNumber
        ,drvCellPhone = (SELECT TOP 1 EfoPhoneNumber FROM dbo.EmpMPhon WHERE efoPhoneType = 'CEL' AND efoEEID = xEEID)
        ,drvWorkEmail = EepAddressemail
        ,drvPersonalEmail = EepAddressEMailAlternate
        ,drvEffDate = dbo.dsi_fnGetMinMaxDates('MAX',EedBenStartDate,'01-01-' + CONVERT(VARCHAR(4),YEAR(GETDATE())))
        ,drvEndDate = dbo.dsi_fnGetMinMaxDates('MIN',EedBenStopDate,'12-31-' + CONVERT(VARCHAR(4), YEAR(GETDATE())))
        ,drvPlanType = CASE WHEN ISNULL(EedDedCode, cdDedCode) = 'FSAMD' THEN 'MED'
                            WHEN ISNULL(EedDedCode, cdDedCode) = 'FSADC' THEN 'DEP'
                            ELSE ISNULL(EedDedCode, cdDedCode)
                       END
        ,drvElection = EedEEGoalAmt
        ,drvERContribution = NULL
        ,drvAltID = EecEmpNo
        ,drvGender = EepGender
        ,drvPayrollDate = @PayDate
        ,drvPayrollDeduction = cdEECurAmt
        ,drveeid = xEEID
        ,drvcoid = xCOID
        ,drvInitialSort = EepSSN
    INTO dbo.U_@CustomFormatCode_drvTbl
    FROM dbo.U_@CustomFormatCode_EELIST WITH (NOLOCK)
    INNER JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
        AND (EecEmplStatus <> 'T'
            OR (EecEmplStatus = 'T'
                AND EecTermReason <> 'TRO'
            )
        )
    INNER JOIN dbo.EmpPers WITH (NOLOCK)
        ON Eepeeid = xEEID
    INNER JOIN dbo.U_dsi_bdm_EmpDeductions
        ON EedEEID = xEEID
        AND EedCOID = xCOID
        AND EedFormatCode = @FormatCode
        AND EedValidForExport = 'Y'
    LEFT JOIN dbo.U_@CustomFormatCode_CurrDeds(NOLOCK)
        ON cdEEID = xEEID
        AND cdCOID = xCOID
        AND EedDedCode = cdDedCode
        AND ISNULL(cdEECurAmt, 0.00) <> 0.00
    WHERE (eedvalidforexport = 'Y'
        OR ISNULL(cdEECurAmt, 0.00) <> 0.00
    );

    --------------------
    -- Trailer Records
    --------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_Trailer;
    SELECT DISTINCT drvCountEligibility = (SELECT COUNT(*) FROM dbo.U_@CustomFormatCode_drvTbl)
        ,drvCountDeductions = (SELECT COUNT(*) FROM dbo.U_@CustomFormatCode_drvTbl WHERE ISNULL(drvPayrollDeduction, 0.00) <> 0.00)
        ,drvDeductionSum = (SELECT SUM(drvPayrollDeduction) FROM dbo.U_@CustomFormatCode_drvTbl WHERE ISNULL(drvPayrollDeduction, 0.00) <> 0.00)
    INTO dbo.U_@CustomFormatCode_drvTbl_Trailer;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode, 'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
        SET ExportFile = '@GroupID_FSAEligPayroll_'
                            + CONVERT(CHAR(8), GETDATE(), 112) + '_'                 --YYYYMMDD
                            + REPLACE(CONVERT(VARCHAR(10), GETDATE(), 108), ':', '') --HHMMSS
                            + CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN '_TEST'
                                   WHEN @ExportCode = 'TEST' THEN '_TEST'
                                   ELSE ''
                            END
                            + '.txt'
        WHERE FormatCode = @FormatCode;
    END;

END
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vw@CustomFormatCode_Export AS
    SELECT TOP 200000000 DATA FROM dbo.U_@CustomFormatCode_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2),InitialSort,SubSort;

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
CREATE VIEW [dbo].[dsi_vw@CustomFormatCode_Export] AS
    SELECT TOP 200000000 DATA FROM dbo.U_@CustomFormatCode_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2),InitialSort,SubSort;
GO
IF OBJECT_ID('dsi_fnGetMinMaxDates') IS NOT NULL
	DROP FUNCTION dbo.dsi_fnGetMinMaxDates
GO

CREATE FUNCTION [dbo].[dsi_fnGetMinMaxDates] 
(
@Type  VARCHAR(3), 
@Date1 DATETIME,
@Date2 DATETIME
)
RETURNS DATETIME
WITH EXECUTE AS CALLER
AS
 
/************************************************************
 
Created By: Erin Hidalgo & John Transier
Create Date: 08-25-08
 
Purpose: Returns the minimum or maximum of two input dates
 
Command: PRINT dbo.dsi_fnGetMinMaxDates('MIN', GETDATE(), GETDATE() +1 )
 
NOTE TO SUPPORT: this function is one of a standard set of USI functions. Please do not make any changes
to this function without going through the USI team. Any changes made to this function will be wiped out
if/when the standard USI code is reinstalled on this database.
 
Revision History
----------------
Update By         Date          CP Num         Descr
xxxxxxxxxxxxxxxx  xx/xx/xxxxx   CS-xxxx-xxxxx  xxxxxxxx
 
************************************************************/
 
BEGIN
 
IF @Date1 IS NULL AND @Date2 IS NULL RETURN NULL
IF @Date1 IS NULL                    RETURN @Date2
IF @Date2 IS NULL                    RETURN @Date1
IF @Date1 = @Date2                   RETURN @Date1  
 
RETURN CASE 
          WHEN @Type = 'MIN' AND @Date1 < @Date2 THEN @Date1 
          WHEN @Type = 'MIN' AND @Date1 > @Date2 THEN @Date2 
          WHEN @Type = 'MAX' AND @Date1 > @Date2 THEN @Date1 
          WHEN @Type = 'MAX' AND @Date1 < @Date2 THEN @Date2 
       END
 
RETURN NULL
 
END
GO