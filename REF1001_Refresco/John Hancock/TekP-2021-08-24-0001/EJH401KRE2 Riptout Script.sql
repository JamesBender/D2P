/**********************************************************************************

EJH401KRE2: John Hancock 401K Export

Date/time:     2021-10-05 10:40:25.013
Client ID:     REF1001
FormatCode:    EJH401KRE2
Project:       John Hancock 401K Export
Export Type:   Back Office
Status:        Production
Environment:   E43
Server:        E4SUP3DB01
Database:      ULTIPRO_RBUS
ExportPath:    \\us.saas\E0\data_exchange\REF1001\Exports\
OnDemandPath:  \\us.saas\E0\data_exchange\REF1001\Exports\
TestPath:      \\us.saas\e4\Public\REF1001\Exports\JohnHancock\

Git Filename and Command
-------------------
C:\GDIToolsGIT\EJH401KRE2_Deploy.sql
./AddToGit.sh -s SR-2018-00210432 -a REF1001 -f EJH401KRE2

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Create U_dsi_RipoutParms if it doesn't exist
-----------

IF OBJECT_ID('U_dsi_RipoutParms') IS NULL BEGIN

   CREATE TABLE dbo.U_dsi_RipoutParms (
   rpoFormatCode  VARCHAR(10)   NOT NULL,
   rpoParmType    VARCHAR(64)   NOT NULL,
   rpoParmValue01 VARCHAR(1024) NULL,
   rpoParmValue02 VARCHAR(1024) NULL,
   rpoParmValue03 VARCHAR(1024) NULL,
   rpoParmValue04 VARCHAR(1024) NULL,
   rpoParmValue05 VARCHAR(1024) NULL
)
END


-----------
-- Clear U_dsi_RipoutParms
-----------

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EJH401KRE2'


-----------
-- Add paths to U_dsi_RipoutParms
-----------

INSERT INTO dbo.U_dsi_RipoutParms (rpoFormatCode, rpoParmType, rpoParmValue01, rpoParmValue02)
SELECT

FormatCode,
'Path',
CfgName,
CfgValue

FROM dbo.U_Dsi_Configuration
WHERE FormatCode = 'EJH401KRE2'
AND CfgName LIKE '%path%'


-----------
-- Add AscExp expSystemIDs to U_dsi_RipoutParms
-----------

INSERT INTO dbo.U_dsi_RipoutParms (rpoFormatCode, rpoParmType, rpoParmValue01, rpoParmValue02) 
SELECT

ExpFormatCode,
'expSystemID',
ExpExportCode,
ExpSystemID

FROM dbo.AscExp
WHERE ExpFormatCode = 'EJH401KRE2'


-----------
-- Drop current objects and delete configuration data
-----------

IF OBJECT_ID('dsi_vwEJH401KRE2_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEJH401KRE2_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EJH401KRE2') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EJH401KRE2];
GO
IF OBJECT_ID('U_EJH401KRE2_TrailerTbl') IS NOT NULL DROP TABLE [dbo].[U_EJH401KRE2_TrailerTbl];
GO
IF OBJECT_ID('U_EJH401KRE2_TrailerTbl') IS NOT NULL DROP TABLE [dbo].[U_EJH401KRE2_TrailerTbl];
GO
IF OBJECT_ID('U_EJH401KRE2_PTaxHist') IS NOT NULL DROP TABLE [dbo].[U_EJH401KRE2_PTaxHist];
GO
IF OBJECT_ID('U_EJH401KRE2_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EJH401KRE2_PEarHist];
GO
IF OBJECT_ID('U_EJH401KRE2_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EJH401KRE2_PDedHist];
GO
IF OBJECT_ID('U_EJH401KRE2_File') IS NOT NULL DROP TABLE [dbo].[U_EJH401KRE2_File];
GO
IF OBJECT_ID('U_EJH401KRE2_EEList') IS NOT NULL DROP TABLE [dbo].[U_EJH401KRE2_EEList];
GO
IF OBJECT_ID('U_EJH401KRE2_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EJH401KRE2_drvTbl];
GO
IF OBJECT_ID('U_EJH401KRE2_DedList') IS NOT NULL DROP TABLE [dbo].[U_EJH401KRE2_DedList];
GO
IF OBJECT_ID('U_EJH401KRE2_CompYTD') IS NOT NULL DROP TABLE [dbo].[U_EJH401KRE2_CompYTD];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EJH401KRE2';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EJH401KRE2';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EJH401KRE2';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EJH401KRE2';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EJH401KRE2';

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EJH401KRE2','John Hancock 401K Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','3000','S','N','EJH401KRE2Z0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanNum"','1','(''UA''=''T,'')','EJH401KRE2Z0','6','D','10','1',NULL,'Plan Alias',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDivision"','2','(''UA''=''T,'')','EJH401KRE2Z0','30','D','10','2',NULL,'Division',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','3','(''UA''=''T,'')','EJH401KRE2Z0','9','D','10','3',NULL,'Social Security #',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvName"','4','(''UA''=''T,'')','EJH401KRE2Z0','150','D','10','4',NULL,'Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','5','(''UA''=''T,'')','EJH401KRE2Z0','30','D','10','5',NULL,'Address #1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','6','(''UA''=''T,'')','EJH401KRE2Z0','30','D','10','6',NULL,'Address #2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','7','(''UA''=''T,'')','EJH401KRE2Z0','30','D','10','7',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','8','(''UA''=''T,'')','EJH401KRE2Z0','2','D','10','8',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressProvince"','9','(''UA''=''T,'')','EJH401KRE2Z0','30','D','10','9',NULL,'Province',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCountry"','10','(''UA''=''T,'')','EJH401KRE2Z0','30','D','10','10',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZip"','11','(''UA''=''T,'')','EJH401KRE2Z0','15','D','10','11',NULL,'Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','12','(''UDMDY''=''T,'')','EJH401KRE2Z0','8','D','10','12',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfOriginalHire"','13','(''UDMDY''=''T,'')','EJH401KRE2Z0','8','D','10','13',NULL,'Original Date of Hire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfTermination"','14','(''UDMDY''=''T,'')','EJH401KRE2Z0','8','D','10','14',NULL,'Date of Termination',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfLastHire"','15','(''UDMDY''=''T,'')','EJH401KRE2Z0','8','D','10','15',NULL,'Date of Rehire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvExcludCode"','16','(''UA''=''T,'')','EJH401KRE2Z0','1','D','10','16',NULL,'Excludable Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHourlySalary"','17','(''UA''=''T,'')','EJH401KRE2Z0','1','D','10','17',NULL,'Hourly/Salary Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatus"','18','(''UA''=''T,'')','EJH401KRE2Z0','4','D','10','18',NULL,'Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','19','(''UA''=''T,'')','EJH401KRE2Z0','1','D','10','19',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollFreq"','20','(''UA''=''T,'')','EJH401KRE2Z0','6','D','10','20',NULL,'Payroll frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLanguage"','21','(''UA''=''T,'')','EJH401KRE2Z0','1','D','10','21',NULL,'Language',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkEmail"','22','(''UA''=''T,'')','EJH401KRE2Z0','30','D','10','22',NULL,'Employees Corporate Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkPhone"','23','(''UA''=''T,'')','EJH401KRE2Z0','10','D','10','23',NULL,'Emplouees Corporate Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotPlanYTDGrossComp"','24','(''UNT2''=''T,'')','EJH401KRE2Z0','16','D','10','24',NULL,'Total plan YTD gross compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPTDGrossComp"','25','(''UNT2''=''T,'')','EJH401KRE2Z0','16','D','10','25',NULL,'Total PTD gross compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotPlanYTDPlanComp"','26','(''UNT2''=''T,'')','EJH401KRE2Z0','16','D','10','26',NULL,'Total plan YTD plan compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotPTDPlanComp"','27','(''UNT2''=''T,'')','EJH401KRE2Z0','16','D','10','27',NULL,'Total PTD plan compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotMngedAcctAnnualComp"','28','(''UNT2''=''T,'')','EJH401KRE2Z0','16','D','10','28',NULL,'Total Managed Account Annualized comp',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotPTD401KContrib"','29','(''UNT2''=''T,'')','EJH401KRE2Z0','16','D','10','29',NULL,'Total PTD 401(k) contributions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotPTDMatchContrib"','30','(''UNT2''=''T,'')','EJH401KRE2Z0','16','D','10','30',NULL,'Total PTD match contributions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotPTDProfShrContrib"','31','(''UNT2''=''T,'')','EJH401KRE2Z0','16','D','10','31',NULL,'Total PTD profit sharing contributions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotPTDCatchUpContrib"','32','(''UNT2''=''T,'')','EJH401KRE2Z0','16','D','10','32',NULL,'Total PTD catch-up contributions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotPTDRothContrib"','33','(''UNT2''=''T,'')','EJH401KRE2Z0','16','D','10','33',NULL,'Total PTD Roth 401(k) contributions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotPTDRothCUContrib"','34','(''UNT2''=''T,'')','EJH401KRE2Z0','16','D','10','34',NULL,'Total PTD Roth catch up contributions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotPTDLoanRepaySum"','35','(''UNT2''=''T,'')','EJH401KRE2Z0','16','D','10','35',NULL,'Total PTD loan repayments sum',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDHours"','36','(''UNT2''=''T,'')','EJH401KRE2Z0','8','D','10','36',NULL,'Hours, YTD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDefPretax"','37','(''UNT2''=''T,'')','EJH401KRE2Z0','1','D','10','37',NULL,'Deferral %, Pre-tax',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDefPretaxAddl"','38','(''UDMDY''=''T,'')','EJH401KRE2Z0','8','D','10','38',NULL,'Deferral %, Pre-tax, Addl',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDefRoth"','39','(''UNT2''=''T,'')','EJH401KRE2Z0','30','D','10','39',NULL,'Deferral %, Roth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDefRothCU"','40','(''UNT2''=''T,'')','EJH401KRE2Z0','8','D','10','40',NULL,'Deferral %, Roth Catchup',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerBaseMatch"','41','(''UNT2''=''T,'')','EJH401KRE2Z0','10','D','10','41',NULL,'Employer Base Match',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotPlanYTDProfitShrComp"','42','(''UNT2''=''T,'')','EJH401KRE2Z0','16','D','10','42',NULL,'Eligible Plan Compensation YTD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUnionCode"','43','(''UA''=''T,'')','EJH401KRE2Z0','1','D','10','43',NULL,'Union Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotYTDMatchComp"','44','(''UNT2''=''T,'')','EJH401KRE2Z0','16','D','10','44',NULL,'Total YTD match compensation',NULL,NULL);

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File Name is Auto Generated',NULL,'','','DAJ4C,DCQJ1,DAJ8D,CIUJE,CITIX',NULL,NULL,NULL,'John Hancock 401K Export','201902281','EMPEXPORT','ONDEMAND','Feb 28 2019 12:51PM','EJH401KRE2',NULL,NULL,NULL,'201902281','Feb 28 2019 12:00AM','Mar  2 2019 12:00AM','201902281','3125','','','201902281',dbo.fn_GetTimedKey(),NULL,'ULTI_RBUS',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File Name is  Auto Generated',NULL,NULL,NULL,'DAJ4C,DCQJ1,DAJ8D,CIUJE,CITIX',NULL,NULL,NULL,'Scheduled Export','202109301','EMPEXPORT','SCHEDULED','Sep 30 2021  6:15AM','EJH401KRE2',NULL,NULL,NULL,'202109301','Oct  8 2018 12:00AM','Dec 30 1899 12:00AM','202109232',NULL,'','','202109232',dbo.fn_GetTimedKey(),NULL,'ULTI_RBUS',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File Name is Auto Generated',NULL,NULL,NULL,'DAJ4C,DCQJ1,DAJ8D,CIUJE,CITIX',NULL,NULL,NULL,'For Testing JH 401K','202109231','EMPEXPORT','TEST','Sep 28 2021 12:00AM','EJH401KRE2',NULL,NULL,NULL,'202109231','Sep 23 2021 12:00AM','Sep 25 2021 12:00AM','202109162','4250','','','202109162',dbo.fn_GetTimedKey(),NULL,'ULTI_RBUS',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EJH401KRE2','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EJH401KRE2','ExportPath','V','\\us.saas\E0\data_exchange\REF1001\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EJH401KRE2','OnDemandPath','V','\\us.saas\E0\data_exchange\REF1001\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EJH401KRE2','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EJH401KRE2','TestPath','V','\\us.saas\e4\Public\REF1001\Exports\JohnHancock\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EJH401KRE2','UDESPath','C','\\us.saas\E0\data_exchange\REF1001\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EJH401KRE2','UseFileName','V','N');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EJH401KRE2','D10','dbo.U_EJH401KRE2_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EJH401KRE2_CompYTD
-----------

IF OBJECT_ID('U_EJH401KRE2_CompYTD') IS NULL
CREATE TABLE [dbo].[U_EJH401KRE2_CompYTD] (
    [YTDEeID] char(12) NOT NULL,
    [YTDCurInclInDefCompAmt] numeric NULL
);

-----------
-- Create table U_EJH401KRE2_DedList
-----------

IF OBJECT_ID('U_EJH401KRE2_DedList') IS NULL
CREATE TABLE [dbo].[U_EJH401KRE2_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EJH401KRE2_drvTbl
-----------

IF OBJECT_ID('U_EJH401KRE2_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EJH401KRE2_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvPlanNum] varchar(6) NOT NULL,
    [drvDivision] varchar(3) NULL,
    [drvSSN] char(11) NULL,
    [drvName] varchar(203) NULL,
    [drvAddressLine1] varchar(8000) NULL,
    [drvAddressLine2] varchar(8000) NULL,
    [drvAddressCity] varchar(8000) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressProvince] varchar(1) NOT NULL,
    [drvAddressCountry] char(3) NULL,
    [drvAddressZip] varchar(50) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvDateOfOriginalHire] datetime NULL,
    [drvDateOfTermination] datetime NULL,
    [drvDateOfLastHire] datetime NULL,
    [drvExcludCode] varchar(1) NOT NULL,
    [drvHourlySalary] char(1) NULL,
    [drvStatus] varchar(1) NOT NULL,
    [drvGender] char(1) NULL,
    [drvPayrollFreq] char(1) NULL,
    [drvLanguage] varchar(1) NOT NULL,
    [drvWorkEmail] varchar(50) NULL,
    [drvWorkPhone] varchar(50) NULL,
    [drvTotPlanYTDGrossComp] money NOT NULL,
    [drvPTDGrossComp] numeric NOT NULL,
    [drvTotPlanYTDPlanComp] numeric NOT NULL,
    [drvTotPTDPlanComp] numeric NOT NULL,
    [drvTotMngedAcctAnnualComp] money NULL,
    [drvTotPTD401KContrib] numeric NOT NULL,
    [drvTotPTDMatchContrib] numeric NOT NULL,
    [drvTotPTDProfShrContrib] numeric NOT NULL,
    [drvTotPTDCatchUpContrib] numeric NOT NULL,
    [drvTotPTDRothContrib] numeric NOT NULL,
    [drvTotPTDRothCUContrib] numeric NOT NULL,
    [drvTotPTDLoanRepaySum] numeric NOT NULL,
    [drvYTDHours] decimal NOT NULL,
    [drvDefPretax] varchar(1) NOT NULL,
    [drvDefPretaxAddl] varchar(1) NOT NULL,
    [drvDefRoth] varchar(1) NOT NULL,
    [drvDefRothCU] varchar(1) NOT NULL,
    [drvEmployerBaseMatch] varchar(1) NOT NULL,
    [drvTotPlanYTDProfitShrComp] numeric NOT NULL,
    [drvUnionCode] varchar(1) NOT NULL,
    [drvTotYTDMatchComp] numeric NOT NULL,
    [drvInitialSort] char(11) NULL
);

-----------
-- Create table U_EJH401KRE2_EEList
-----------

IF OBJECT_ID('U_EJH401KRE2_EEList') IS NULL
CREATE TABLE [dbo].[U_EJH401KRE2_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EJH401KRE2_File
-----------

IF OBJECT_ID('U_EJH401KRE2_File') IS NULL
CREATE TABLE [dbo].[U_EJH401KRE2_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);

-----------
-- Create table U_EJH401KRE2_PDedHist
-----------

IF OBJECT_ID('U_EJH401KRE2_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EJH401KRE2_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt401KCP] numeric NULL,
    [PdhEECurAmtMatchCP] numeric NULL,
    [PdhEECurAmtPShareCP] numeric NULL,
    [PdhEECurAmtPtaxCUCP] numeric NULL,
    [PdhEECurAmtRothCP] numeric NULL,
    [PdhEECurAmtRothCUCP] numeric NULL,
    [PdhEECurAmtLoanCP] numeric NULL,
    [PdhEECurAmt401K] numeric NULL,
    [PdhEECurAmtMatch] numeric NULL,
    [PdhEECurAmtPShare] numeric NULL,
    [PdhEECurAmtPtaxCU] numeric NULL,
    [PdhEECurAmtRoth] numeric NULL,
    [PdhEECurAmtRothCU] numeric NULL,
    [PdhEECurAmtLoan] numeric NULL
);

-----------
-- Create table U_EJH401KRE2_PEarHist
-----------

IF OBJECT_ID('U_EJH401KRE2_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EJH401KRE2_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PehCurAmt] numeric NULL,
    [PehCurInclInDefCompAmt] numeric NULL,
    [PehCurHrsYTD] decimal NULL,
    [PehInclInDefComp] numeric NULL
);

-----------
-- Create table U_EJH401KRE2_PTaxHist
-----------

IF OBJECT_ID('U_EJH401KRE2_PTaxHist') IS NULL
CREATE TABLE [dbo].[U_EJH401KRE2_PTaxHist] (
    [PthEEID] char(12) NOT NULL,
    [PthGrossAmt] money NULL,
    [PthGrossAmtCP] numeric NULL
);

-----------
-- Create table U_EJH401KRE2_TrailerTbl
-----------

IF OBJECT_ID('U_EJH401KRE2_TrailerTbl') IS NULL
CREATE TABLE [dbo].[U_EJH401KRE2_TrailerTbl] (
    [drvPlanNumT] varchar(1) NOT NULL,
    [drvPlanNumT] varchar(1) NOT NULL,
    [drvDivisionT] varchar(1) NOT NULL,
    [drvDivisionT] varchar(1) NOT NULL,
    [drvSSNT] varchar(1) NOT NULL,
    [drvSSNT] varchar(1) NOT NULL,
    [drvNameT] varchar(1) NOT NULL,
    [drvNameT] varchar(1) NOT NULL,
    [drvAddressLine1T] varchar(1) NOT NULL,
    [drvAddressLine1T] varchar(1) NOT NULL,
    [drvAddressLine2T] varchar(1) NOT NULL,
    [drvAddressLine2T] varchar(1) NOT NULL,
    [drvAddressCityT] varchar(1) NOT NULL,
    [drvAddressCityT] varchar(1) NOT NULL,
    [drvAddressStateT] varchar(1) NOT NULL,
    [drvAddressStateT] varchar(1) NOT NULL,
    [drvAddressProvinceT] varchar(1) NOT NULL,
    [drvAddressProvinceT] varchar(1) NOT NULL,
    [drvAddressCountryT] varchar(1) NOT NULL,
    [drvAddressCountryT] varchar(1) NOT NULL,
    [drvAddressZipT] varchar(1) NOT NULL,
    [drvAddressZipT] varchar(1) NOT NULL,
    [drvDateOfBirthT] varchar(1) NOT NULL,
    [drvDateOfBirthT] varchar(1) NOT NULL,
    [drvDateOfOriginalHireT] varchar(1) NOT NULL,
    [drvDateOfOriginalHireT] varchar(1) NOT NULL,
    [drvDateOfTerminationT] varchar(1) NOT NULL,
    [drvDateOfTerminationT] varchar(1) NOT NULL,
    [drvDateOfLastHireT] varchar(1) NOT NULL,
    [drvDateOfLastHireT] varchar(1) NOT NULL,
    [drvExcludCodeT] varchar(1) NOT NULL,
    [drvExcludCodeT] varchar(1) NOT NULL,
    [drvHourlySalaryT] varchar(1) NOT NULL,
    [drvHourlySalaryT] varchar(1) NOT NULL,
    [drvStatusT] varchar(1) NOT NULL,
    [drvStatusT] varchar(1) NOT NULL,
    [drvGenderT] varchar(1) NOT NULL,
    [drvGenderT] varchar(1) NOT NULL,
    [drvPayrollFreqT] varchar(1) NOT NULL,
    [drvPayrollFreqT] varchar(1) NOT NULL,
    [drvLanguageT] varchar(1) NOT NULL,
    [drvLanguageT] varchar(1) NOT NULL,
    [drvWorkEmailT] varchar(1) NOT NULL,
    [drvWorkEmailT] varchar(1) NOT NULL,
    [drvWorkPhoneT] varchar(1) NOT NULL,
    [drvWorkPhoneT] varchar(1) NOT NULL,
    [drvTotPlanYTDGrossCompT] money NULL,
    [drvTotPlanYTDGrossCompT] money NULL,
    [drvPTDGrossCompT] numeric NULL,
    [drvPTDGrossCompT] numeric NULL,
    [drvTotPlanYTDPlanCompT] money NULL,
    [drvTotPlanYTDPlanCompT] money NULL,
    [drvTotPTDPlanCompT] numeric NULL,
    [drvTotPTDPlanCompT] numeric NULL,
    [drvTotMngedAcctAnnualCompT] varchar(1) NOT NULL,
    [drvTotMngedAcctAnnualCompT] varchar(1) NOT NULL,
    [drvTotPTD401KContribT] numeric NULL,
    [drvTotPTD401KContribT] numeric NULL,
    [drvTotPTDMatchContribT] numeric NULL,
    [drvTotPTDMatchContribT] numeric NULL,
    [drvTotPTDProfShrContribT] numeric NULL,
    [drvTotPTDProfShrContribT] numeric NULL,
    [drvTotPTDCatchUpContribT] numeric NULL,
    [drvTotPTDCatchUpContribT] numeric NULL,
    [drvTotPTDRothContribT] numeric NULL,
    [drvTotPTDRothContribT] numeric NULL,
    [drvTotPTDRothCUContribT] numeric NULL,
    [drvTotPTDRothCUContribT] numeric NULL,
    [drvTotPTDLoanRepaySumT] numeric NULL,
    [drvTotPTDLoanRepaySumT] numeric NULL,
    [drvYTDHoursT] varchar(1) NOT NULL,
    [drvYTDHoursT] varchar(1) NOT NULL,
    [drvDefPretaxT] varchar(1) NOT NULL,
    [drvDefPretaxT] varchar(1) NOT NULL,
    [drvDefPretaxAddlT] varchar(1) NOT NULL,
    [drvDefPretaxAddlT] varchar(1) NOT NULL,
    [drvDefRothT] varchar(1) NOT NULL,
    [drvDefRothT] varchar(1) NOT NULL,
    [drvDefRothCUT] varchar(1) NOT NULL,
    [drvDefRothCUT] varchar(1) NOT NULL,
    [drvEmployerBaseMatchT] varchar(1) NOT NULL,
    [drvEmployerBaseMatchT] varchar(1) NOT NULL,
    [drvTotPlanYTDProfitShrCompT] numeric NULL,
    [drvTotPlanYTDProfitShrCompT] numeric NULL,
    [drvUnionCodeT] varchar(1) NOT NULL,
    [drvUnionCodeT] varchar(1) NOT NULL,
    [drvTotYTDMatchCompT] money NULL,
    [drvTotYTDMatchCompT] money NULL
);

-----------
-- Create table U_EJH401KRE2_TrailerTbl
-----------

IF OBJECT_ID('U_EJH401KRE2_TrailerTbl') IS NULL
CREATE TABLE [dbo].[U_EJH401KRE2_TrailerTbl] (
    [drvPlanNumT] varchar(1) NOT NULL,
    [drvPlanNumT] varchar(1) NOT NULL,
    [drvDivisionT] varchar(1) NOT NULL,
    [drvDivisionT] varchar(1) NOT NULL,
    [drvSSNT] varchar(1) NOT NULL,
    [drvSSNT] varchar(1) NOT NULL,
    [drvNameT] varchar(1) NOT NULL,
    [drvNameT] varchar(1) NOT NULL,
    [drvAddressLine1T] varchar(1) NOT NULL,
    [drvAddressLine1T] varchar(1) NOT NULL,
    [drvAddressLine2T] varchar(1) NOT NULL,
    [drvAddressLine2T] varchar(1) NOT NULL,
    [drvAddressCityT] varchar(1) NOT NULL,
    [drvAddressCityT] varchar(1) NOT NULL,
    [drvAddressStateT] varchar(1) NOT NULL,
    [drvAddressStateT] varchar(1) NOT NULL,
    [drvAddressProvinceT] varchar(1) NOT NULL,
    [drvAddressProvinceT] varchar(1) NOT NULL,
    [drvAddressCountryT] varchar(1) NOT NULL,
    [drvAddressCountryT] varchar(1) NOT NULL,
    [drvAddressZipT] varchar(1) NOT NULL,
    [drvAddressZipT] varchar(1) NOT NULL,
    [drvDateOfBirthT] varchar(1) NOT NULL,
    [drvDateOfBirthT] varchar(1) NOT NULL,
    [drvDateOfOriginalHireT] varchar(1) NOT NULL,
    [drvDateOfOriginalHireT] varchar(1) NOT NULL,
    [drvDateOfTerminationT] varchar(1) NOT NULL,
    [drvDateOfTerminationT] varchar(1) NOT NULL,
    [drvDateOfLastHireT] varchar(1) NOT NULL,
    [drvDateOfLastHireT] varchar(1) NOT NULL,
    [drvExcludCodeT] varchar(1) NOT NULL,
    [drvExcludCodeT] varchar(1) NOT NULL,
    [drvHourlySalaryT] varchar(1) NOT NULL,
    [drvHourlySalaryT] varchar(1) NOT NULL,
    [drvStatusT] varchar(1) NOT NULL,
    [drvStatusT] varchar(1) NOT NULL,
    [drvGenderT] varchar(1) NOT NULL,
    [drvGenderT] varchar(1) NOT NULL,
    [drvPayrollFreqT] varchar(1) NOT NULL,
    [drvPayrollFreqT] varchar(1) NOT NULL,
    [drvLanguageT] varchar(1) NOT NULL,
    [drvLanguageT] varchar(1) NOT NULL,
    [drvWorkEmailT] varchar(1) NOT NULL,
    [drvWorkEmailT] varchar(1) NOT NULL,
    [drvWorkPhoneT] varchar(1) NOT NULL,
    [drvWorkPhoneT] varchar(1) NOT NULL,
    [drvTotPlanYTDGrossCompT] money NULL,
    [drvTotPlanYTDGrossCompT] money NULL,
    [drvPTDGrossCompT] numeric NULL,
    [drvPTDGrossCompT] numeric NULL,
    [drvTotPlanYTDPlanCompT] money NULL,
    [drvTotPlanYTDPlanCompT] money NULL,
    [drvTotPTDPlanCompT] numeric NULL,
    [drvTotPTDPlanCompT] numeric NULL,
    [drvTotMngedAcctAnnualCompT] varchar(1) NOT NULL,
    [drvTotMngedAcctAnnualCompT] varchar(1) NOT NULL,
    [drvTotPTD401KContribT] numeric NULL,
    [drvTotPTD401KContribT] numeric NULL,
    [drvTotPTDMatchContribT] numeric NULL,
    [drvTotPTDMatchContribT] numeric NULL,
    [drvTotPTDProfShrContribT] numeric NULL,
    [drvTotPTDProfShrContribT] numeric NULL,
    [drvTotPTDCatchUpContribT] numeric NULL,
    [drvTotPTDCatchUpContribT] numeric NULL,
    [drvTotPTDRothContribT] numeric NULL,
    [drvTotPTDRothContribT] numeric NULL,
    [drvTotPTDRothCUContribT] numeric NULL,
    [drvTotPTDRothCUContribT] numeric NULL,
    [drvTotPTDLoanRepaySumT] numeric NULL,
    [drvTotPTDLoanRepaySumT] numeric NULL,
    [drvYTDHoursT] varchar(1) NOT NULL,
    [drvYTDHoursT] varchar(1) NOT NULL,
    [drvDefPretaxT] varchar(1) NOT NULL,
    [drvDefPretaxT] varchar(1) NOT NULL,
    [drvDefPretaxAddlT] varchar(1) NOT NULL,
    [drvDefPretaxAddlT] varchar(1) NOT NULL,
    [drvDefRothT] varchar(1) NOT NULL,
    [drvDefRothT] varchar(1) NOT NULL,
    [drvDefRothCUT] varchar(1) NOT NULL,
    [drvDefRothCUT] varchar(1) NOT NULL,
    [drvEmployerBaseMatchT] varchar(1) NOT NULL,
    [drvEmployerBaseMatchT] varchar(1) NOT NULL,
    [drvTotPlanYTDProfitShrCompT] numeric NULL,
    [drvTotPlanYTDProfitShrCompT] numeric NULL,
    [drvUnionCodeT] varchar(1) NOT NULL,
    [drvUnionCodeT] varchar(1) NOT NULL,
    [drvTotYTDMatchCompT] money NULL,
    [drvTotYTDMatchCompT] money NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EJH401KRE2]
    @SystemID char(12)
AS
/**********************************************************************************
Client Name: Refresco

Created By: Alexei Burgoa
Business Analyst: Emily Gaddy
Create Date: 10/11/2018
Service Request Number: SR-2018-00210432

Purpose: John Hancock 401K Export

Revision History
----------------
Update By           Date           Request Num        Desc
Bryan Heid          04/07/2020     SR-2020-00264686   Adjust calculations for YTD plan comp, period plan comp, YTD Eligible comp and match comp calculations
Rishabh Verma        08/25/2021       SR-2021-00324083   Updated DrvUnionCode Fields and drvName Field


SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EJH401KRE2';
SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EJH401KRE2';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EJH401KRE2';
SELECT * FROM dbo.AscExp WHERE expFormatCode = 'EJH401KRE2';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EJH401KRE2' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EJH401KRE2', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EJH401KRE2', 'SCHEDULED';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EJH401KRE2', 'TEST';


EXEC dbo._dsi_usp_ExportRipOut_v7 @FormatCode = 'EJH401KRE2', @AllObjects = 'Y' , @IsWeb = 'N'
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
    SELECT @FormatCode = 'EJH401KRE2';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    PRINT 'Start Date: ' + CONVERT(VARCHAR(26),@StartDate,100);
    PRINT 'End Date:  ' + CONVERT(VARCHAR(26),@EndDate,100);

    DECLARE @PlanYearStart DATETIME;
    
    SET @PlanYearStart = DATEADD(yy, DATEDIFF(yy, 0, @EndDate), 0);

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EJH401KRE2_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EJH401KRE2_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --All employees, regardless of plan eligibility and employment status, should be included in the file.  Do not exclude terminated employees until the Plan Year has expired.
    --DELETE FROM dbo.U_EJH401KRE2_EEList
    --WHERE xEEID IN
    --(SELECT EecEEID FROM EmpComp WHERE EecEmplStatus = 'T' AND EecDateOfTermination < DATEADD(yy, DATEDIFF(yy, 0, GETDATE()), 0));

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '401K,401K1,4CU1,4CU,401KM,401SB,SBPSM,4L1,4L2,ROTH,ROTH1,RCU,RCU1';

    IF OBJECT_ID('U_EJH401KRE2_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EJH401KRE2_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EJH401KRE2_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EJH401KRE2_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EJH401KRE2_PDedHist;
    SELECT DISTINCT
         PdhEEID
        --,PdhPerControl = LEFT(PdhPerControl,8)
        -- Current Payroll Amounts
        --,PdhEECurAmt = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        --,PdhERCurAmt = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        ,PdhEECurAmt401KCP = SUM(CASE WHEN PdhDedCode IN ('401K','401K1') AND  PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhEECurAmtMatchCP = SUM(CASE WHEN PdhDedCode NOT IN ('SBPSM') AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN ISNULL(PdhERCurAmt, 0) ELSE 0.00 END)
        ,PdhEECurAmtPShareCP = SUM(CASE WHEN PdhDedCode IN ('SBPSM') AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN ISNULL(PdhERCurAmt, 0) ELSE 0.00 END)
        ,PdhEECurAmtPtaxCUCP = SUM(CASE WHEN PdhDedCode IN ('4CU','4CU1') AND  PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhEECurAmtRothCP = SUM(CASE WHEN PdhDedCode IN ('ROTH','ROTH1') AND  PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhEECurAmtRothCUCP = SUM(CASE WHEN PdhDedCode IN ('RCU','RCU1') AND  PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhEECurAmtLoanCP = SUM(CASE WHEN PdhDedCode IN ('4L1','4L2') AND  PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        -- YTD Payroll Amounts
        --,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        --,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhEECurAmt401K = SUM(CASE WHEN PdhDedCode IN ('401K','401K1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhEECurAmtMatch = SUM(CASE WHEN PdhDedCode IN ('401KM','SBPSM') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhEECurAmtPShare = SUM(CASE WHEN PdhDedCode IN ('SNPSM') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhEECurAmtPtaxCU = SUM(CASE WHEN PdhDedCode IN ('4CU','4CU1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhEECurAmtRoth = SUM(CASE WHEN PdhDedCode IN ('ROTH','ROTH1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhEECurAmtRothCU = SUM(CASE WHEN PdhDedCode IN ('RCU','RCU1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhEECurAmtLoan = SUM(CASE WHEN PdhDedCode IN ('4L1','4L2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    INTO dbo.U_EJH401KRE2_PDedHist
    FROM dbo.U_EJH401KRE2_EEList WITH (NOLOCK)
    JOIN dbo.PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
    JOIN dbo.U_EJH401KRE2_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    GROUP BY PdhEEID--, LEFT(PdhPerControl,8)
    --HAVING (SUM(PdhEECurAmt) <> 0.00
    --    OR SUM(PdhERCurAmt) <> 0.00
    ;

    -----------------------------PehCurInclInDefCompAmt
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EJH401KRE2_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EJH401KRE2_PEarHist;
    SELECT DISTINCT
         PehEEID
        --,PrgPayDate          = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt           = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        --,PehCurHrs         = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        -- Current Deferred Payroll Amount/Hours
        ,PehCurInclInDefCompAmt           = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN
                                                     CASE WHEN (PehPayGroup='SANBE' AND EecSalaryOrHourly='H' AND ISNULL(EecUnionLocal,'') = '682') OR 
                                                     (PehPayGroup='STLOU' AND EecSalaryOrHourly='H' AND ISNULL(EecUnionLocal,'') = '688')
                                                          THEN CASE WHEN PehEarnCode IN ('REG','REGDL') THEN PehCurAmt 
                                                          ELSE 0.00 END 
                                                     WHEN PehInclInDefComp = 'Y' THEN PehCurAmt
                                                     ELSE 0.00 END
                                                ELSE 0.00 END)
        --,PehCurInclInDefCompHrs           = SUM(CASE WHEN PehPerControl >= @StartPerControl AND PehInclInDefComp = 'Y' THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        --,PehCurAmtYTD        = SUM(PehCurAmt)
        ,PehCurHrsYTD        = SUM(CASE WHEN PehExclInTotalHours = 'N' THEN PehCurHrs END)  --Updated 2/6 to include PehExclInTotalHours
        -- Include Deferred Comp Amount/Hours
        ,PehInclInDefComp    = SUM(CASE WHEN (PehPayGroup='SANBE' AND EecSalaryOrHourly='H' AND ISNULL(EecUnionLocal,'') = '682') OR 
                                             (PehPayGroup='STLOU' AND EecSalaryOrHourly='H' AND ISNULL(EecUnionLocal,'') = '688')
                                        THEN CASE WHEN PehEarnCode IN ('REG','REGDL') THEN PehCurAmt 
                                        ELSE 0.00 END 
                               WHEN PehInclInDefComp = 'Y' THEN PehCurAmt
                               ELSE 0.00 
                               END)
        --,PehInclInDefCompHrs = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_EJH401KRE2_PEarHist
    FROM dbo.U_EJH401KRE2_EEList WITH (NOLOCK)
    JOIN dbo.PayReg WITH (NOLOCK)
        ON PrgEEID = xEEID
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    LEFT JOIN dbo.EmpComp ON EecEEID = xEEID AND EecCOID = xCOID AND EecPayGroup = PehPayGroup
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID;
--    HAVING SUM(PehCurAmt) <> 0.00;



        -----------------------------
    -- Working Table - PTaxHist 
    -----------------------------
    IF OBJECT_ID('U_EJH401KRE2_PTaxHist','U') IS NOT NULL
        DROP TABLE dbo.U_EJH401KRE2_PTaxHist;
    SELECT DISTINCT
         PthEEID 
        ,PthGrossAmt           = SUM(PthCurGrossWages) 
        ,PthGrossAmtCP           = SUM(CASE WHEN PthPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PthCurGrossWages ELSE 0.00 END)
    INTO dbo.U_EJH401KRE2_PTaxHist
    FROM dbo.U_EJH401KRE2_EEList WITH (NOLOCK)
    JOIN dbo.PayReg WITH (NOLOCK)
        ON PrgEEID = xEEID
    JOIN dbo.PTaxHist WITH (NOLOCK)
        ON PthGenNumber = PrgGenNumber
    WHERE LEFT(PthPerControl,4) = LEFT(@EndPerControl,4)
    AND PthPerControl <= @EndPerControl AND PthTaxCode = 'USFUTA'
    GROUP BY PthEEID;
   -- HAVING SUM(PehCurAmt) <> 0.00;




   -----------------------------
-- Working Table - CompensationYTD
-----------------------------
IF OBJECT_ID('U_EJH401KRE2_CompYTD','U') IS NOT NULL
    DROP TABLE dbo.U_EJH401KRE2_CompYTD;
SELECT DISTINCT
     YTDEeID = PehEEID
    ,YTDCurInclInDefCompAmt = SUM(CASE WHEN (PehPayGroup='SANBE' AND EecSalaryOrHourly='H' AND ISNULL(EecUnionLocal,'') = '682') OR 
                                               (PehPayGroup='STLOU' AND EecSalaryOrHourly='H' AND ISNULL(EecUnionLocal,'') = '688') THEN 
                                               CASE WHEN PehPerControl BETWEEN CONVERT(CHAR(8), dbo.dsi_fnGetMinMaxDates('MAX',@PlanYearStart, EedBenStartDate),112) + '1' AND @EndPerControl THEN 
                                                    CASE WHEN PehEarnCode IN ('REG','REGDL') THEN PehCurAmt 
                                                    ELSE 0.00 
                                                    END
                                               ELSE 0.00
                                               END
                                       WHEN PehPerControl BETWEEN CONVERT(CHAR(8), dbo.dsi_fnGetMinMaxDates('MAX',@PlanYearStart, EecDateOfOriginalHire),112) + '1' AND @EndPerControl THEN            
                                            CASE WHEN ErnInclInDefComp = 'Y' THEN PehCurAmt
                                            ELSE 0.00 
                                            END
                                  ELSE 0.00 
                                  END)
INTO dbo.U_EJH401KRE2_CompYTD
FROM dbo.U_EJH401KRE2_EEList WITH (NOLOCK)
JOIN dbo.EmpComp WITH (NOLOCK)
    ON EecEEID = xEEID
    AND EecCOID = xCOID
JOIN dbo.PEarHist WITH (NOLOCK)
    ON PehEeid = xEeid
JOIN dbo.EarnCode WITH (NOLOCK)
    ON ErnEarncode = PehEarnCode
    AND (ErnInclInDefComp = 'Y' OR ErnEarnCode IN ('REG','REGDL'))
LEFT JOIN (SELECT EedEeid,EedCoid,min(EedBenStartDate) EedBenstartDate 
        FROM dbo.EmpDed WITH (NOLOCK) 
        JOIN dbo.U_EJH401KRE2_DedList WITH (NOLOCK)
          ON DedCode = EedDedCode
    GROUP BY EedEeid,EedCoid) eed 
    ON EedEeid = xEeid
    AND EedCoid = xCoid
WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
AND PehPerControl <= @EndPerControl
GROUP BY PehEEID
;
 --  ---------------------------
 --    Working Table - CompensationYTD
 --   ---------------------------
 --   IF OBJECT_ID('U_EJH401KRE2_CompYTD','U') IS NOT NULL
 --       DROP TABLE dbo.U_EJH401KRE2_CompYTD;
 --   SELECT DISTINCT
 --        YTDEeID  = PehEeid
 --       ,YTDCurInclInDefCompAmt    =  SUM(CASE WHEN CONVERT(VARCHAR(8), PehPerControl) BETWEEN  dbo.dsi_fnGetMinMaxDates('MAX',Eedbenstartdate, EecDateofBenefitSeniority) AND @EndDate THEN PehCurAmt ELSE 0.00 END)  --SUM(CASE WHEN PehInclInDefComp = 'Y' AND CONVERT(Varchar( 8 ), PehPerControl) BETWEEN CONVERT(VARCHAR, MAX (eecDateOfBenefitSeniority),112) AND CONVERT(VARCHAR , @EndDate, 112) THEN PehCurAmt ELSE 0.00 END)
 --   INTO dbo.U_EJH401KRE2_CompYTD
 --   FROM dbo.U_EJH401KRE2_EEList WITH (NOLOCK)
 --   JOIN dbo.EmpComp WITH (NOLOCK)
 --       ON EecEEID = xEEID
    --    AND EecCOID = xCOID
 --   JOIN dbo.PEarHist WITH (NOLOCK)
 --       ON PehEeid = xEeid
    --JOIN dbo.EarnCode WITH (NOLOCK)
    --    ON ErnEarncode = PehEarnCode
    --    AND ErnInclInDefComp = 'Y'
    --JOIN dbo.EmpDed WITH (NOLOCK) 
    --    ON EedEeid = xEeid
    --    AND EedCoid = xCoid
 --   WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
 --   AND PehPerControl <= @EndPerControl
 --   GROUP BY PehEeid


    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EJH401KRE2_drvTbl
    ---------------------------------

    IF OBJECT_ID('U_EJH401KRE2_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EJH401KRE2_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        -- standard fields above and additional driver fields below
        ,drvPlanNum = 'CO45SL'
        ,drvDivision = CASE WHEN EecUnionLocal NOT IN ('830','Y','N') THEN SUBSTRING(EecUnionLocal,1,3) ELSE 'REF' END
  --      ,drvPayrollCompCode = 'CAOF'
        ,drvSSN = eepSSN
        ,drvName = '"' + RTRIM(EepNameLast) + ',' + RTRIM(EepNameFirst) + '"' -- RTRIM(EepNameLast)  +',' + RTRIM(EepNameFirst)   -- Updated buy Rishabh Verma SR-2021-00324083
        ,drvAddressLine1 = REPLACE(EepAddressLine1,',','')
        ,drvAddressLine2 = REPLACE(EepAddressLine2,',','')
        ,drvAddressCity = REPLACE(EepAddressCity,',','')
        ,drvAddressState = EepAddressState
        ,drvAddressProvince = ''
        ,drvAddressCountry = EepAddressCountry -- CASE EepAddressCountry WHEN 'USA' THEN 'US' ELSE '' END --client confirmed US only emps
        ,drvAddressZip = EepAddressZipCode
        ,drvDateOfBirth = EepDateOfBirth
        ,drvDateOfOriginalHire = EecDateOfOriginalHire
        ,drvDateOfTermination = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
-- 20200327
        ,drvDateOfLastHire =     CASE WHEN EecDateOfLastHire <> EecDateofOriginalHire AND EecJoBChangeReason ='101' THEN ISNULL(EecDateofLastHire,'')  END
        
        --CASE WHEN EecDateOfLastHire <> EecDateofOriginalHire THEN 
  --                                                              CASE WHEN EecJoBChangeReason IN ('101','102') THEN EecDateofLastHire ELSE '' END
  --                                       END
        ,drvExcludCode = CASE WHEN EecEEType NOT IN ( 'REG', 'EXE','HS') OR EecDedGroupCode IN ('CNCDU') THEN 'X' ELSE '' END
        ,drvHourlySalary = EecSalaryOrHourly
        ,drvStatus = CASE WHEN EecEmplStatus = 'A' THEN 'A'
-- 20200327
                          WHEN EecEmplStatus = 'S' THEN 'A'
                          WHEN EecEmplStatus = 'L' THEN 'L'
                          WHEN EecEmplStatus = 'T' AND EecTermReason = '203' THEN 'D'
                          ELSE 'T' END 
        ,drvGender = EepGender
        ,drvPayrollFreq = EecPayPeriod
        ,drvLanguage =''-- EepLanguage
        ,drvWorkEmail = EepAddressEMail
        ,drvWorkPhone = EepPhoneHomeNumber 
        ,drvTotPlanYTDGrossComp = ISNULL(PthGrossAmt,0)  --ISNULL(PehCurAmtYTD,0)
        ,drvPTDGrossComp = ISNULL(PthGrossAmtCP,0)  --ISNULL(PehCurAmt,0)
        ,drvTotPlanYTDPlanComp = ISNULL(PehInclInDefComp ,0)--ISNULL(PehCurAmtYTD,0) --ISNULL(PehInclInDefComp,0)
        ,drvTotPTDPlanComp = ISNULL(PehCurInclInDefCompAmt,0) -- ISNULL(PehCurInclInDefCompAmt,0)
        ,drvTotMngedAcctAnnualComp = EecAnnSalary
        ,drvTotPTD401KContrib = ISNULL(PdhEECurAmt401KCP,0)
        ,drvTotPTDMatchContrib = ISNULL(PdhEECurAmtMatchCP,0)
        ,drvTotPTDProfShrContrib = ISNULL(PdhEECurAmtPshareCP,0)
        ,drvTotPTDCatchUpContrib = ISNULL(PdhEECurAmtPtaxCUCP,0)
        ,drvTotPTDRothContrib = ISNULL(PdhEECurAmtRothCP,0)
        ,drvTotPTDRothCUContrib = ISNULL(PdhEECurAmtRothCUCP,0)
        ,drvTotPTDLoanRepaySum = ISNULL(PdhEECurAmtLoanCP,0)
        ,drvYTDHours = ISNULL(PehCurHrsYTD,0)
        ,drvDefPretax = ''
        ,drvDefPretaxAddl = ''
        ,drvDefRoth = ''
        ,drvDefRothCU = ''
        ,drvEmployerBaseMatch = ''
        ,drvTotPlanYTDProfitShrComp = ISNULL(YTDCurInclInDefCompAmt ,0)
        ,drvUnionCode = Case WHEN ISNULL(EecUnionLocal, 'N') <> 'N'  THEN 'U'         --Updated buy Rishabh Verma SR-2021-00324083
                              WHEN EecUnionLocal <> 'N' THEN 'U'
                              ELSE '' END
        
        
        /*CASE
                             WHEN ISNULL(EecUnionNational,'N') <> 'N' THEN 'U' 
                             WHEN ISNULL(EecUnionLocal, 'N') <> 'N'  THEN 'U'
                             WHEN EecUnionLocal <> 'N' THEN 'U'
                             WHEN EecUnionNational <> 'N' THEN 'U'  ELSE '' END */ 

        ,drvTotYTDMatchComp = ISNULL(PehInclInDefComp,0) 
        ,drvInitialSort = EepSSN 
    INTO dbo.U_EJH401KRE2_drvTbl
    FROM dbo.U_EJH401KRE2_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_EJH401KRE2_PEarHist
        ON PehEEID = xEEID
    JOIN dbo.U_EJH401KRE2_PTaxHist WITH (NOLOCK)
        ON PthEEID = xeeId
    JOIN dbo.U_EJH401KRE2_CompYTD WITH (NOLOCK)
        ON YTDEeid = xeeid
    LEFT JOIN U_EJH401KRE2_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
    ;


      ---------------------------------
  --  -- TRAILER RECORD
  --  ---------------------------------
  --  IF OBJECT_ID('U_EJH401KRE2_TrailerTbl','U') IS NOT NULL
  --      DROP TABLE dbo.U_EJH401KRE2_TrailerTbl;
  --  SELECT DISTINCT
  --      drvPlanNumT = ''
  --      ,drvDivisionT = ''
  ----      ,drvPayrollCompCode = 'CAOF'
  --      ,drvSSNT = ''
  --      ,drvNameT = ''
  --      ,drvAddressLine1T = ''
  --      ,drvAddressLine2T = ''
  --      ,drvAddressCityT = ''
  --      ,drvAddressStateT = ''
  --      ,drvAddressProvinceT = ''
  --      ,drvAddressCountryT ='' -- CASE EepAddressCountry WHEN 'USA' THEN 'US' ELSE '' END --client confirmed US only emps
  --      ,drvAddressZipT = ''
  --      ,drvDateOfBirthT = ''
  --      ,drvDateOfOriginalHireT = ''
  --      ,drvDateOfTerminationT = ''
  --      ,drvDateOfLastHireT =     ''
  --      ,drvExcludCodeT = ''
  --      ,drvHourlySalaryT =''
  --      ,drvStatusT =''
  --      ,drvGenderT = ''
  --      ,drvPayrollFreqT = ''
  --      ,drvLanguageT =''
  --      ,drvWorkEmailT = ''
  --      ,drvWorkPhoneT = ''
  --      ,drvTotPlanYTDGrossCompT = (Select sum (drvTotPlanYTDGrossComp) from dbo.U_EJH401KRE2_drvTbl)
  --      ,drvPTDGrossCompT = (Select sum (drvPTDGrossComp) from dbo.U_EJH401KRE2_drvTbl)
  --      ,drvTotPlanYTDPlanCompT = (Select sum( drvTotPlanYTDPlanComp) from dbo.U_EJH401KRE2_drvTbl)
  --      ,drvTotPTDPlanCompT = (Select sum( drvTotPTDPlanComp) from dbo.U_EJH401KRE2_drvTbl)
  --      ,drvTotMngedAcctAnnualCompT =''
  --      ,drvTotPTD401KContribT =(Select sum( drvTotPTD401KContrib) from dbo.U_EJH401KRE2_drvTbl)
  --      ,drvTotPTDMatchContribT = (Select sum( drvTotPTDMatchContrib) from dbo.U_EJH401KRE2_drvTbl)
  --      ,drvTotPTDProfShrContribT = (Select sum( drvTotPTDProfShrContrib) from dbo.U_EJH401KRE2_drvTbl)
  --      ,drvTotPTDCatchUpContribT = (Select sum(drvTotPTDCatchUpContrib) from dbo.U_EJH401KRE2_drvTbl)
  --      ,drvTotPTDRothContribT = (Select sum( drvTotPTDRothContrib) from dbo.U_EJH401KRE2_drvTbl)
  --      ,drvTotPTDRothCUContribT = (Select sum( drvTotPTDRothCUContrib) from dbo.U_EJH401KRE2_drvTbl)
  --      ,drvTotPTDLoanRepaySumT = (Select sum( drvTotPTDLoanRepaySum) from dbo.U_EJH401KRE2_drvTbl)
  --      ,drvYTDHoursT = ''
  --      ,drvDefPretaxT = ''
  --      ,drvDefPretaxAddlT = ''
  --      ,drvDefRothT = ''
  --      ,drvDefRothCUT = ''
  --      ,drvEmployerBaseMatchT = ''
  --      ,drvTotPlanYTDProfitShrCompT = (Select sum( drvTotPlanYTDProfitShrComp) from dbo.U_EJH401KRE2_drvTbl)
  --      ,drvUnionCodeT = ''
  --      ,drvTotYTDMatchCompT = (Select sum(drvTotYTDMatchComp) from dbo.U_EJH401KRE2_drvTbl)
  --  INTO dbo.U_EJH401KRE2_TrailerTbl
--    FROM (SELECT COUNT(*) dtlcount FROM U_EBENWLTENR_FSAdrvTbl) cnt
  --  WHERE @EXPORTCODE LIKE '%FSA%'
    ;


    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'CO45SL_' +  SUBSTRING(@EndPercontrol,5,4) + SUBSTRING(@EndPercontrol,1,4)+ '_Test.csv'
                                  WHEN @ExportCode like '%test%' THEN 'CO45SL_' +  SUBSTRING(@EndPercontrol,5,4) + SUBSTRING(@EndPercontrol,1,4)+ '_Test.csv'
                                  ELSE 'CO45SL_' +  SUBSTRING(@EndPercontrol,5,4) + SUBSTRING(@EndPercontrol,1,4) + '.csv'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEJH401KRE2_Export AS
    SELECT TOP 20000000 Data
    FROM dbo.U_EJH401KRE2_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EJH401KRE2%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201708041'
       ,expStartPerControl     = '201708041'
       ,expLastEndPerControl   = '201708049'
       ,expEndPerControl       = '201708049'
WHERE expFormatCode = 'EJH401KRE2';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEJH401KRE2_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EJH401KRE2_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EJH401KRE2'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EJH401KRE2'
   AND rpoParmType = 'expSystemID'
