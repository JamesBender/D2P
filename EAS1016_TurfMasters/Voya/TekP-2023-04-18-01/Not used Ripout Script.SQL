/**********************************************************************************

IVOYA401K: Voya 401K Deferral and Loan Import

FormatCode:     IVOYA401K
Project:        Voya 401K Deferral and Loan Import
Client ID:      EAS1016
Date/time:      2023-08-14 15:59:28.437
Ripout version: 7.4
Export Type:    Web
Status:         Production
Environment:    EWP
Server:         EW1WUP5DB04
Database:       ULTIPRO_WPEURF
Web Filename:   EAS1016_MY9A2_EEHISTORY_IVOYA401K_ExportCode_YYYYMMDD_HHMMSS.txt
ArchivePath:   \\us.saas\ew1\Public\EAS1016\Imports\Voya\Processed
ExportPath:    
ImportPath:    \\us.saas\ew1\Public\EAS1016\Imports\Voya
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_IVOYA401K_SavePath') IS NOT NULL DROP TABLE dbo.U_IVOYA401K_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'IVOYA401K'


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
WHERE FormatCode = 'IVOYA401K'
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
WHERE ExpFormatCode = 'IVOYA401K'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'IVOYA401K')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'IVOYA401K'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'IVOYA401K'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'IVOYA401K'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'IVOYA401K'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'IVOYA401K'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'IVOYA401K'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'IVOYA401K'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'IVOYA401K'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'IVOYA401K'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwIVOYA401K_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwIVOYA401K_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_IVOYA401K') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_IVOYA401K];
GO
IF OBJECT_ID('U_IVOYA401K_File') IS NOT NULL DROP TABLE [dbo].[U_IVOYA401K_File];
GO
IF OBJECT_ID('U_IVOYA401K_EEList') IS NOT NULL DROP TABLE [dbo].[U_IVOYA401K_EEList];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N',NULL,'Y','0',NULL,NULL,'N',NULL,'N','E','013010','BENEFITIMP','SDF','IVOYA401K','Voya 401K Deferral and Loan Import','N','I','FORM_ASCIIIMPORTBENEFITS','N','N',dbo.fn_GetTimedKey(),'D',NULL,'S','N','IVOYA401K0Z1','N',NULL,'N',NULL,'N',NULL,'N');
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','IVOYA401K','Voya 401K Deferral and Loan Import','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','IVOYA401K0Z0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','IVOYA401K0Z0','50','H','01','1',NULL,'Employee Number',NULL,NULL,'"Employee Number"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','IVOYA401K0Z0','50','H','01','2',NULL,'Employee Name',NULL,NULL,'"Employee Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','IVOYA401K0Z0','50','H','01','3',NULL,'Deduction Code',NULL,NULL,'"Deduction Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','IVOYA401K0Z0','50','H','01','4',NULL,'Contribution Percent',NULL,NULL,'"Contribution Percent"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','IVOYA401K0Z0','50','H','01','5',NULL,'Contribution Amount',NULL,NULL,'"Contribution Amount "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','IVOYA401K0Z0','50','H','01','6',NULL,'Loan Payment Amount',NULL,NULL,'"Loan Payment Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','IVOYA401K0Z0','50','H','01','7',NULL,'Loan Goal Amount',NULL,NULL,'"Loan Goal Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','IVOYA401K0Z0','50','H','01','8',NULL,'Loan Type',NULL,NULL,'"Loan Type"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','IVOYA401K0Z0','50','H','01','9',NULL,'Import Type',NULL,NULL,'"Import Type"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','IVOYA401K0Z0','50','H','01','10',NULL,'Action',NULL,NULL,'"Action"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','IVOYA401K0Z0','50','H','01','11',NULL,'Error Message',NULL,NULL,'"Error Message"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','IVOYA401K0Z0','50','D','10','1',NULL,'Employee Number',NULL,NULL,'"drvEmployeeNumber"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','IVOYA401K0Z0','50','D','10','2',NULL,'Employee Name',NULL,NULL,'"drvEmployeeName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','IVOYA401K0Z0','50','D','10','3',NULL,'Deduction Code',NULL,NULL,'"drvDeductionCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','IVOYA401K0Z0','50','D','10','4',NULL,'Contribution Percent',NULL,NULL,'"drvContributionPercent"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','IVOYA401K0Z0','50','D','10','5',NULL,'Contribution Amount',NULL,NULL,'"drvContributionAmount"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','IVOYA401K0Z0','50','D','10','6',NULL,'Loan Payment Amount',NULL,NULL,'"drvLoanPaymentAmount"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','IVOYA401K0Z0','50','D','10','7',NULL,'Loan Goal Amount',NULL,NULL,'"drvLoanGoalAmount"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','IVOYA401K0Z0','50','D','10','8',NULL,'Loan Type',NULL,NULL,'"drvLoanType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','IVOYA401K0Z0','50','D','10','9',NULL,'Import Type',NULL,NULL,'"drvImportType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','IVOYA401K0Z0','50','D','10','10',NULL,'Action',NULL,NULL,'"drvAction"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','IVOYA401K0Z0','250','D','10','11',NULL,'Error',NULL,NULL,'"drvError"','(''UA''=''T'')');

-----------
-- Build web filename
-----------

/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME, 1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME, 3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME, 2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME, 3) ELSE LEFT(@@SERVERNAME, 2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME, 2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME, 3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FileName varchar(1000) = 'IVOYA401K_20230814.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'401k Deferral & Loan Import','202109099','EMPEXPORT','IMPORT','Jan  1 2019 12:00AM','IVOYA401K',NULL,NULL,NULL,'202109099','Jan  1 2019 12:00AM','Dec 30 1899 12:00AM','202109091',NULL,'','','202109091',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('IVOYA401K','ArchivePath','V','\\us.saas\ew1\Public\EAS1016\Imports\Voya\Processed');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('IVOYA401K','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('IVOYA401K','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('IVOYA401K','ImportPath','V','\\us.saas\ew1\Public\EAS1016\Imports\Voya');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('IVOYA401K','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('IVOYA401K','NoEmpty','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('IVOYA401K','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('IVOYA401K','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('IVOYA401K','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('IVOYA401K','D10','dbo.U_IVOYA401K_drvTbl WITH (NOLOCK)',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_IVOYA401K_EEList
-----------

IF OBJECT_ID('U_IVOYA401K_EEList') IS NULL
CREATE TABLE [dbo].[U_IVOYA401K_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_IVOYA401K_File
-----------

IF OBJECT_ID('U_IVOYA401K_File') IS NULL
CREATE TABLE [dbo].[U_IVOYA401K_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_IVOYA401K]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Turfmasters Brands 

Created By: Marie Waters
Business Analyst: Lea King
Create Date: 08/14/2023
Service Request Number: TekP-2023-04-18-01

Purpose: Voya 401K Import

NOTE TO SUPPORT: This is an Automated Web Import that uses the Import Tool for Validating/Posting Records

Revision History
----------------
Update By           Date            Request Num         Desc
xxx                 XX/XX/20XX      SR-20XX-XXXX        XXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'IVOYA401K';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'IVOYA401K';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'IVOYA401K';
SELECT * FROM dbo.AscExp WHERE ExpFormatCode = 'IVOYA401K';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'IVOYA401K' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'IVOYA401K', 'IMPORT';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'IVOYA401K', @AllObjects = 'Y', @IsWeb = 'Y'
**********************************************************************************/
BEGIN

    --==================================================
    -- Declare Variables
    --==================================================
    DECLARE  @FormatCode VARCHAR(10)
            ,@ImportPath VARCHAR(1000)
            ,@FileName VARCHAR(1000)
            ,@ExportCode VARCHAR(12)
            ,@EnableStandardWebImport CHAR(1);

    SET @FormatCode = 'IVOYA401K'
    SET @ExportCode = (SELECT ExportCode FROM dbo.U_dsi_Parameters (NOLOCK) WHERE FormatCode = @FormatCode);

    --Set directory and filename where import file is located
    SET @ImportPath = dbo.Dsi_fnVariable(@FormatCode,'ImportPath');
    SET @FileName = (SELECT expAscFileName FROM dbo.AscExp WHERE expFormatCode = @FormatCode AND expExportCode = @ExportCode);

    --==================================================
    -- Set FileName
    --==================================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
        SET ExportFile = 'DeferralLoanImport_' + LTRIM(RTRIM(@ExportCode)) + '_'
                            + CONVERT(CHAR(8),GETDATE(),112)                          -- YYMMDD
                            + REPLACE(CONVERT(VARCHAR(8),GETDATE(),108),':',SPACE(0)) -- HHMMss
                            + '.csv'
        WHERE FormatCode = @FormatCode;
    END;

    --==================================================
    -- Create Driver Table for Error Report
    --==================================================
    IF object_id('U_IVOYA401K_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_IVOYA401K_drvTbl;
    CREATE TABLE dbo.U_IVOYA401K_drvTbl (
        drvSurrogateKey VARCHAR(50) NULL
        ,drvEmployeeNumber VARCHAR(50) NULL
        ,drvEmployeeName VARCHAR(50) NULL
        ,drvSSN VARCHAR(50) NULL
        ,drvDeductionCode VARCHAR(50) NULL
        ,drvBenefitStatus VARCHAR(50) NULL
        ,drvBenefitStatusDate VARCHAR(50) NULL
        ,drvBenefitStartDate VARCHAR(50) NULL
        ,drvBenefitStopDate VARCHAR(50) NULL
        ,drvDeductionStartDate VARCHAR(50) NULL
        ,drvDeductionStopDate VARCHAR(50) NULL
        ,drvContributionPercent VARCHAR(50) NULL
        ,drvContributionAmount VARCHAR(50) NULL
        ,drvEmployerPercent VARCHAR(50) NULL
        ,drvEmployerAmount VARCHAR(50) NULL
        ,drvBenefitOption VARCHAR(50) NULL
        ,drvBenefitAmount VARCHAR(50) NULL
        ,drvBenefitChangeReason VARCHAR(50) NULL
        ,drvLoanNumber VARCHAR(50) NULL
        ,drvLoanPaymentAmount VARCHAR(50) NULL
        ,drvLoanGoalAmount VARCHAR(50) NULL
        ,drvLoanType VARCHAR(50) NULL
        ,drvAction VARCHAR(50) NULL
        ,drvError VARCHAR(250) NULL
        ,drvImported TINYINT DEFAULT 0 NOT NULL
        ,drvEEID VARCHAR(12) NULL
        ,drvCOID VARCHAR(5) NULL
        ,drvDedCode VARCHAR(50) NULL
        ,drvImportType VARCHAR(50) NULL
        ,drvPeriodStartDate VARCHAR(50) NULL
        ,drvPendingUpdateID CHAR(20)NULL
        ,drvInitialSort VARCHAR(50) NULL
    );

    --==================================================
    -- Benefit Import Module (BIM) - Deferral Records
    --==================================================
    BEGIN TRY
        DELETE FROM dbo.U_dsi_BIM_Configuration WHERE FormatCode = @FormatCode;

        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'RunID','DEFERRAL');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'FilePath',@ImportPath);
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'MultipleFiles','Y'); -- Sweep Folder and Import Files
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'FileName','*Deferral*'); --File Name contains "Deferral"
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2) VALUES (@FormatCode,'FileFormat','Delimited',',');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'FieldCount','20');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2) VALUES (@FormatCode,'KeyEEID','Field1','SSN');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'PayrollType','Regular'); --Regular --PayGroup --Non-Closed --Non-Opened

        -- For Web Validate Mode Only, then Copy Files.  Otherwise Archive Files
        IF (dbo.dsi_BIM_fn_GetValidateModeSetting() = 'TRUE')
        BEGIN
            INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'CopyFiles','Y');
        END
        ELSE
        BEGIN
            INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'ArchiveFiles','Y');
        END;

        EXEC dbo.dsi_BIM_sp_PopulateImportTable @FormatCode;

        ------------------------------------------------------------------------------
        -- Only Retain Deferral Records where Record ID = '2' (Deferral) in Field# 1
        ------------------------------------------------------------------------------
        DELETE FROM dbo.U_IVOYA401K_Import WHERE RunID = 'DEFERRAL' AND LTRIM(RTRIM(Field1)) <> '2' AND ISNULL(Error,'') = '';
    END TRY
    BEGIN CATCH
       -- Report SQL Error in Error Report File
       INSERT INTO dbo.U_IVOYA401K_drvTbl (drvError)
       SELECT 'Error Processing Delimited Deferral File (BIM): ' + ISNULL(ERROR_MESSAGE(),'');

       -- Stop Processing
       RETURN;
    END CATCH;

    --==================================================
    -- Benefit Import Module (BIM) - Loan Records
    --==================================================
    BEGIN TRY
        DELETE FROM dbo.U_dsi_BIM_Configuration WHERE FormatCode = @FormatCode;

        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'AddToPreviousRun','Y');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'RunID','LOAN');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'FilePath',@ImportPath);
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'MultipleFiles','Y'); -- Sweep Folder and Import Files
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'FileName','*Loans*'); --File Name contains "Loans"
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2) VALUES (@FormatCode,'FileFormat','Delimited',',');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'FieldCount','20');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2) VALUES (@FormatCode,'KeyEEID','Field1','SSN');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'PayrollType','Regular'); --Regular --PayGroup --Non-Closed --Non-Opened

        -- For Web Validate Mode Only, then Copy Files.  Otherwise Archive Files
        IF (dbo.dsi_BIM_fn_GetValidateModeSetting() = 'TRUE')
        BEGIN
            INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'CopyFiles','Y');
        END
        ELSE
        BEGIN
            INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'ArchiveFiles','Y');
        END;

        EXEC dbo.dsi_BIM_sp_PopulateImportTable @FormatCode;

        ------------------------------------------------------------------------------
        -- Only Retain Loan Records where Record ID = '3' (Loan) in Field# 1
        ------------------------------------------------------------------------------
        DELETE FROM dbo.U_IVOYA401K_Import WHERE RunID = 'LOAN' AND LTRIM(RTRIM(Field1)) <> '3' AND ISNULL(Error,'') = '';
    END TRY
    BEGIN CATCH
       -- Report SQL Error in Error Report File
       INSERT INTO dbo.U_IVOYA401K_drvTbl (drvError)
       SELECT 'Error Processing Delimited Loan File (BIM): ' + ISNULL(ERROR_MESSAGE(),'');

       -- Stop Processing
       RETURN;
    END CATCH;

    --==============================================================
    -- If Error During BIM, then Report Error and Stop Processing
    --==============================================================
    IF EXISTS (SELECT 1 FROM dbo.U_IVOYA401K_Import WHERE ISNULL(Error,'') <> '')
    BEGIN
        INSERT INTO dbo.U_IVOYA401K_drvTbl (drvError,drvImported)
        SELECT Error, 2 FROM dbo.U_IVOYA401K_Import WHERE ISNULL(Error,'') <> '';

        -- Stop Processing
        RETURN;
    END;

    --==================================================
    -- Build Driver Table - Deferrals
    --==================================================
    BEGIN TRY
        INSERT INTO dbo.U_IVOYA401K_drvTbl(drvSurrogateKey,drvEmployeeNumber,drvEmployeeName,drvSSN,drvDeductionCode,drvBenefitStatus,drvBenefitStatusDate,drvBenefitStartDate
            ,drvBenefitStopDate,drvDeductionStartDate,drvDeductionStopDate,drvContributionPercent,drvContributionAmount,drvEmployerPercent,drvEmployerAmount,drvBenefitOption
            ,drvBenefitAmount,drvBenefitChangeReason,drvAction,drvError,drvImported,drvEEID,drvCOID,drvDedCode,drvImportType,drvPeriodStartDate,drvInitialSort)
        SELECT DISTINCT
            drvSurrogateKey = RTRIM(EEID) + RTRIM(COID) + RTRIM(DedDedCode)
            ,drvEmployeeNumber = EecEmpNo
            ,drvEmployeeName = RTRIM(EepNameFirst) + SPACE(1) + RTRIM(EepNameLast)
            ,drvSSN = NULLIF(Field2,'')
            ,drvDeductionCode = NULLIF(CASE WHEN Field10 = 'Pre-Tax Defrl%' THEN 'TM401'
                                            WHEN Field10 = 'Pre-Tax'        THEN 'TM40F'              
                                            WHEN Field10 = 'ROTH %'         THEN 'TMRTH'
                                            WHEN Field10 = 'ROTH $'         THEN 'TMRTF' 
                                        END,'')
                          
                        
            ,drvBenefitStatus = ''--NULLIF(Field3,'')
            ,drvBenefitStatusDate = ''--NULLIF(Field4,'')
            ,drvBenefitStartDate = ''--NULLIF(Field5,'')
            ,drvBenefitStopDate = ''--NULLIF(Field6,'')
            ,drvDeductionStartDate = ''--NULLIF(Field7,'')
            ,drvDeductionStopDate =''-- NULLIF(Field8,'')
            ,drvContributionPercent = NULLIF(Field11,'')
            ,drvContributionAmount = NULLIF(Field12,'')
            ,drvEmployerPercent = ''--NULLIF(Field11,'')
            ,drvEmployerAmount = ''--NULLIF(Field12,'')
            ,drvBenefitOption = ''--NULLIF(Field13,'')
            ,drvBenefitAmount = ''--NULLIF(Field14,'')
            ,drvBenefitChangeReason = ''--NULLIF(Field15,'')
            ,drvAction = CASE WHEN NULLIF(Field2,'') IS NULL THEN 'REJECTED' --Missing [SSN] Value in File.
                              WHEN EEID IS NULL THEN 'REJECTED' --Unable to Match Employee in UltiPro based on [SSN] Value in File.
                              WHEN EecEmplStatus = 'T' THEN 'REJECTED' --Terminated Employee
                              WHEN DedDedCode IS NULL THEN 'REJECTED' --Deduction/Benefit Plan NOT in UltiPro Setup Tables.'
                              ELSE
                                CASE WHEN CONVERT(MONEY,Field9) = 0.00 THEN
                                        CASE WHEN EedDedCode IS NOT NULL THEN 'STOP'
                                             ELSE 'REJECTED' --No Deduction/Benefit Plan to STOP
                                        END
                                     WHEN EedDedCode IS NOT NULL THEN
                                        CASE WHEN COALESCE(EedBenStopDate,EedStopDate) IS NOT NULL THEN 'RESTART'
                                             ELSE 'CHANGE'
                                        END
                                     ELSE 'ADD'
                                END
                         END
            ,drvError = CASE WHEN NULLIF(Field2,'') IS NULL THEN 'Record Rejected: Missing [SSN] Value in File.'
                             WHEN EEID IS NULL THEN 'Record Rejected: Unable to Match Employee in UltiPro based on [SSN] Value in File.'
                             WHEN EecEmplStatus = 'T' THEN 'Record Rejected: Employee is Terminated in UltiPro - Do Not Process.'
                             WHEN DedDedCode IS NULL THEN 'Record Rejected: Deduction/Benefit Plan NOT in UltiPro Setup Tables.'
                             WHEN CONVERT(MONEY,Field12) = 0.00 AND EedDedCode IS NULL THEN 'Record Rejected: No Deduction/Benefit Plan to STOP for Employee in UltiPro.'
                        END
            ,drvImported = CASE -- 0 = Initial Load, 1 = Imported/Updated, 2 = Rejected
                                WHEN NULLIF(Field2,'') IS NULL THEN 2 --Missing [SSN] Value in File.
                                WHEN EEID IS NULL THEN 2 --Unable to Match Employee in UltiPro based on [SSN] Value in File.
                                WHEN EecEmplStatus = 'T' THEN 2 --Terminated Employee
                                WHEN DedDedCode IS NULL THEN 2 --Deduction/Benefit Plan NOT in UltiPro Setup Tables.'
                                WHEN CONVERT(MONEY,Field12) = 0.00 AND EedDedCode IS NULL THEN 2 --No Deduction/Benefit Plan to STOP
                                ELSE 0
                           END
            ,drvEEID = EEID
            ,drvCOID = COID
            ,drvDedCode = DedDedCode
            ,drvImportType = RunID
            ,drvPeriodStartDate = CONVERT(CHAR(10),PayPeriodStartDate,101)
            ,drvInitialSort = Field2
        FROM dbo.U_IVOYA401K_Import
        LEFT JOIN dbo.EmpComp WITH (NOLOCK)
            ON EecEEID = EEID
            AND EecCoID = COID
        LEFT JOIN dbo.EmpPers WITH (NOLOCK)
            ON eepEEID = EEID
        LEFT JOIN dbo.DedCode WITH (NOLOCK)
            ON DedDedCode = Field2
        LEFT JOIN dbo.EmpDed WITH (NOLOCK)
            ON EedEEID = EEID
            AND EedCoID = COID
            AND EedDedCode = DedDedCode
        WHERE RunID = 'DEFERRAL';
    END TRY
    BEGIN CATCH
       -- Report SQL Error in Error Report File
       INSERT INTO dbo.U_IVOYA401K_drvTbl (drvError)
       SELECT 'Error Processing Deferral File: ' + ISNULL(ERROR_MESSAGE(),'');

       -- Stop Processing
       RETURN;
    END CATCH;

    --==================================================
    -- Build Driver Table - Loans
    --==================================================
    BEGIN TRY
        INSERT INTO dbo.U_IVOYA401K_drvTbl(drvSurrogateKey,drvEmployeeNumber,drvEmployeeName,drvSSN,drvDeductionCode,drvDeductionStartDate,drvDeductionStopDate
            ,drvLoanNumber,drvLoanPaymentAmount,drvLoanGoalAmount,drvLoanType,drvAction,drvError,drvImported,drvEEID,drvCOID,drvDedCode,drvImportType,drvPeriodStartDate,drvInitialSort)
        SELECT DISTINCT
            drvSurrogateKey = RTRIM(EEID) + RTRIM(COID) + RTRIM(DedDedCode)
            ,drvEmployeeNumber = EecEmpNo
            ,drvEmployeeName = RTRIM(EepNameFirst) + SPACE(1) + RTRIM(EepNameLast)
            ,drvSSN = NULLIF(Field2,'')
            ,drvDeductionCode = NULLIF(Field10,'')
            ,drvDeductionStartDate = NULLIF(Field7,'')
            ,drvDeductionStopDate = NULLIF(Field8,'')
            ,drvLoanNumber = NULLIF(Field13,'')
            ,drvLoanPaymentAmount = NULLIF( Field19,'')
            ,drvLoanGoalAmount = NULLIF(Field12,'')
            ,drvLoanType = CONVERT(VARCHAR(50),Field31)
            ,drvAction = CASE WHEN NULLIF(Field2,'') IS NULL THEN 'REJECTED' --Missing [SSN] Value in File.
                              WHEN EEID IS NULL THEN 'REJECTED' --Unable to Match Employee in UltiPro based on [SSN] Value in File.
                              WHEN EecEmplStatus = 'T' THEN 'REJECTED' --Terminated Employee
                              WHEN DedDedCode IS NULL THEN 'REJECTED' --Deduction/Benefit Plan NOT in UltiPro Setup Tables.'
                              ELSE
                                CASE WHEN CONVERT(MONEY,Field19) = 0.00 THEN
                                        CASE WHEN EedDedCode IS NOT NULL THEN 'STOP'
                                             ELSE 'REJECTED' --No Deduction/Benefit Plan to STOP
                                        END
                                     WHEN EedDedCode IS NOT NULL THEN
                                        CASE WHEN COALESCE(EedBenStopDate,EedStopDate) IS NOT NULL THEN 'RESTART'
                                             ELSE 'CHANGE'
                                        END
                                     ELSE 'ADD'
                                END
                         END
            ,drvError = CASE WHEN NULLIF(Field2,'') IS NULL THEN 'Record Rejected: Missing [SSN] Value in File.'
                             WHEN EEID IS NULL THEN 'Record Rejected: Unable to Match Employee in UltiPro based on [SSN] Value in File.'
                             WHEN EecEmplStatus = 'T' THEN 'Record Rejected: Employee is Terminated in UltiPro - Do Not Process.'
                             WHEN DedDedCode IS NULL THEN 'Record Rejected: Deduction/Benefit Plan NOT in UltiPro Setup Tables.'
                             WHEN CONVERT(MONEY,Field19) = 0.00 AND EedDedCode IS NULL THEN 'Record Rejected: No Deduction/Benefit Plan to STOP for Employee in UltiPro.'
                        END
            ,drvImported = CASE -- 0 = Initial Load, 1 = Imported/Updated, 2 = Rejected
                                WHEN NULLIF(Field2,'') IS NULL THEN 2 --Missing [SSN] Value in File.
                                WHEN EEID IS NULL THEN 2 --Unable to Match Employee in UltiPro based on [SSN] Value in File.
                                WHEN EecEmplStatus = 'T' THEN 2 --Terminated Employee
                                WHEN DedDedCode IS NULL THEN 2 --Deduction/Benefit Plan NOT in UltiPro Setup Tables.'
                                WHEN CONVERT(MONEY,Field19) = 0.00 AND EedDedCode IS NULL THEN 2 --No Deduction/Benefit Plan to STOP
                                ELSE 0
                           END
            ,drvEEID = EEID
            ,drvCOID = COID
            ,drvDedCode = DedDedCode
            ,drvImportType = RunID
            ,drvPeriodStartDate = CONVERT(CHAR(10),PayPeriodStartDate,101)
            ,drvInitialSort = Field2
        FROM dbo.U_IVOYA401K_Import
        LEFT JOIN dbo.EmpComp WITH (NOLOCK)
            ON EecEEID = EEID
            AND EecCoID = COID
        LEFT JOIN dbo.EmpPers WITH (NOLOCK)
            ON eepEEID = EEID
        LEFT JOIN dbo.DedCode WITH (NOLOCK)
            ON DedDedCode = Field2
        LEFT JOIN dbo.EmpDed WITH (NOLOCK)
            ON EedEEID = EEID
            AND EedCoID = COID
            AND EedDedCode = DedDedCode
        WHERE RunID = 'LOAN';

        --=====================================================
        -- Reject Add/Restarts where Deduction Code is NULL
        --=====================================================
        UPDATE D1
        SET D1.drvError = 'Record Ignored: Recycling Deduction Code: ' + ISNULL(D1.DrvDedCode,'')
            ,drvAction = 'IGNORED'
            ,DrvImported = 2
        FROM dbo.U_IVOYA401K_drvTbl D1
        JOIN dbo.U_IVOYA401K_drvTbl D2
            ON D2.DrvEEID = D1.DrvEEID
            AND D2.DrvCOID = D1.DrvCOID
            AND D2.DrvDedCode = D1.DrvDedCode
            AND D2.drvImported = D1.drvImported
        WHERE D1.drvImported = 0 AND D1.drvAction = 'STOP' AND D2.drvAction <> 'STOP';

        --=====================================================
        -- Reject Add/Restarts where Deduction Code is NULL
        --=====================================================
        UPDATE dbo.U_IVOYA401K_drvTbl
        SET drvError = 'Record Rejected: Maximum Allowed Active Loans Exceeded.'
            ,drvAction = 'REJECTED'
            ,DrvImported = 2
        WHERE drvImported = 0 AND drvAction IN ('ADD','RESTART') AND drvDedCode IS NULL;

        --=====================================================
        -- Reject Stops/Changes where Deduction Code is NULL
        --=====================================================
        UPDATE dbo.U_IVOYA401K_drvTbl
        SET drvError = 'Record Rejected: No Active Deduction Code to STOP/CHANGE in UltiPro.'
            ,drvAction = 'REJECTED'
            ,DrvImported = 2
        WHERE drvImported = 0 AND drvAction IN ('STOP','CHANGE') AND drvDedCode IS NULL;
    END TRY
    BEGIN CATCH
       -- Report SQL Error in Error Report File
       INSERT INTO dbo.U_IVOYA401K_drvTbl (drvError)
       SELECT 'Error Processing Loan File: ' + ISNULL(ERROR_MESSAGE(),'');

       -- Stop Processing
       RETURN;
    END CATCH;

    --==================================================
    -- Update PendingUpdateID for Valid Records
    --==================================================
    UPDATE dbo.U_IVOYA401K_drvTbl
    SET drvPendingUpdateID = LEFT(@FormatCode + dbo.fn_GetTimedKey(),20)
    WHERE drvImported = 0;

    --============================================================
    -- Generate XML File for Standard Web Import for Automation
    --============================================================
    BEGIN TRY
        -----------------------------------
        -- Clear BIM Tables by FormatCode
        -----------------------------------
        DELETE FROM dbo.U_dsi_BIM_LodEDed WHERE EedFormatCode = @FormatCode;

        ---------------------------------------------------------
        -- Populate Lod Deduction Table (LodEDed) for Deferrals
        ---------------------------------------------------------
        INSERT INTO dbo.U_dsi_BIM_LodEDed (EedFormatCode,EedEEID,EedCOID,EedDedCode,EedEECalcRateOrPct,EedEEAmt,EedBenStartDate,EedStartDate,EedBenStatusDate,EedBenStopDate,EedStopDate
            ,EedBenStatus,EedBenOption,EedChangeReason,EedPendingTransType,EedPendingEffDate,EedInclInAddlChk,EedInclInManlChk,EedPendingUpdateID) --EedEECalcRule
        SELECT EedFormatCode = @FormatCode
            ,EedEEID = drvEEID
            ,EedCOID = drvCOID
            ,EedDedCode = drvDedCode
            ,EedEECalcRateOrPct = CASE -- Only Populate for Employee (EE) Non-Flat Amount Calc Rule ('20')
                                       WHEN DedEECalcRule <> '20' THEN
                                           CASE WHEN drvAction = 'STOP' THEN CONVERT(MONEY,0.00)
                                                WHEN drvAction IN ('ADD','CHANGE','RESTART') THEN CONVERT(MONEY,drvContributionPercent)
                                            END
                                  END
            ,EedEEAmt = CASE -- Only Populate for Employee (EE) Flat Amount Calc Rule ('20')
                             WHEN DedEECalcRule = '20' AND NULLIF(drvContributionAmount,'') IS NOT NULL THEN
                                CASE
                                    WHEN drvAction = 'STOP' THEN CONVERT(MONEY,0.00)
                                    ELSE CONVERT(MONEY,drvContributionAmount)
                                END
                             ELSE CONVERT(MONEY,0.00)
                        END
            ,EedBenStartDate = CASE WHEN ISNULL(DedIsBenefit,'N') = 'N' THEN NULL
                                    WHEN drvAction IN ('ADD','RESTART') THEN drvBenefitStartDate
                                    ELSE '12/30/1899'
                               END
            ,EedStartDate = CASE WHEN drvAction IN ('ADD','RESTART') THEN drvDeductionStartDate
                                 ELSE '12/30/1899'
                            END
            ,EedBenStatusDate = CASE WHEN ISNULL(DedIsBenefit,'N') = 'N' THEN NULL
                                     WHEN drvAction IN ('ADD','CHANGE','RESTART') THEN drvBenefitStatusDate
                                     ELSE '12/30/1899'
                                END
            ,EedBenStopDate = CASE WHEN ISNULL(DedIsBenefit,'N') = 'N' THEN NULL
                                   WHEN drvAction = 'STOP' THEN drvBenefitStopDate
                                   ELSE '01/01/1900'
                              END
            ,EedStopDate = CASE WHEN drvAction = 'STOP' THEN drvDeductionStopDate
                                ELSE '01/01/1900'
                           END
            ,EedBenStatus = CASE WHEN ISNULL(DedIsBenefit,'N') = 'N' THEN NULL
                                 ELSE drvBenefitStatus
                            END
            ,EedBenOption = CASE WHEN ISNULL(DedIsBenefit,'N') = 'N' THEN NULL
                                 WHEN DedEECalcRule = '21' THEN drvBenefitOption
                            END
            ,EedChangeReason = CASE WHEN drvAction = 'ADD' THEN '400'
                                    WHEN drvAction = 'STOP' THEN '401'
                                    WHEN drvAction IN ('CHANGE','RESTART') THEN '402'
                               END
            ,EedPendingTransType = CASE WHEN drvAction = 'ADD' THEN 'A'
                                        ELSE 'U'
                                   END
            ,EedPendingEffDate = CONVERT(CHAR(10),GETDATE(),101)
            ,EedInclInAddlChk = DedInclInAddlChk
            ,EedInclInManlChk = DedInclInManlChk
            ,EedPendingUpdateID = drvPendingUpdateID
            --,EedEECalcRule = DedEECalcRule    -- This may need to be set if existing records don't match Deduction/Benefit Plan Calc Rule (i.e., changing from % to Flat Amount)
        FROM dbo.U_IVOYA401K_drvTbl WITH (NOLOCK)
        JOIN dbo.DedCode WITH (NOLOCK)
            ON DedDedCode = drvDedCode
        WHERE drvImported = 0 AND drvImportType = 'DEFERRAL';

        ---------------------------------------------------------
        -- Populate Lod Deduction Table (LodEDed) for Loan File
        ---------------------------------------------------------
        INSERT INTO dbo.U_dsi_BIM_LodEDed (EedFormatCode,EedEEID,EedCOID,EedDedCode,EedEEMemberOrCaseNo,EedEEAmt,EedEEGoalAmt,EedEEGTDAmt,EedStartDate,EedStopDate
            ,EedChangeReason,EedPendingTransType,EedPendingEffDate,EedInclInAddlChk,EedInclInManlChk,EedPendingUpdateID)
        SELECT EedFormatCode = @FormatCode
            ,EedEEID = drvEEID
            ,EedCOID = drvCOID
            ,EedDedCode = drvDedCode
            ,EedEEMemberOrCaseNo = drvLoanNumber
            ,EedEEAmt = CASE -- Only Populate for Employee (EE) Flat Amount Calc Rule ('20')
                             WHEN DedEECalcRule = '20' THEN
                                CASE WHEN drvAction = 'STOP' THEN CONVERT(MONEY,0.00)
                                     WHEN drvAction IN ('ADD','CHANGE','RESTART') THEN drvLoanPaymentAmount
                                END
                        END
            ,EedEEGoalAmt = CASE -- Only Populate if Deduction Goal Rule is Setup ('Z' = <No goal>)
                                WHEN DedEEGoalRule <> 'Z' THEN CONVERT(MONEY,drvLoanGoalAmount)
                           END
            ,EedEEGTDAmt = CASE -- Only Populate if Deduction Goal Rule is Setup ('Z' = <No goal>)
                                WHEN DedEEGoalRule <> 'Z' THEN
                                    CASE WHEN drvAction = 'RESTART' THEN CONVERT(MONEY,0.00) END
                           END
            ,EedStartDate = CASE WHEN drvAction IN ('ADD','CHANGE','RESTART') THEN drvDeductionStartDate
                                 ELSE '12/30/1899'
                            END
            ,EedStopDate = CASE WHEN drvAction = 'STOP' THEN drvDeductionStopDate
                                ELSE '01/01/1900'
                           END
            ,EedChangeReason = CASE WHEN drvAction = 'ADD' THEN '400'
                                    WHEN drvAction = 'STOP' THEN '401'
                                    WHEN drvAction IN ('CHANGE','RESTART') THEN '402'
                               END
            ,EedPendingTransType = CASE WHEN drvAction = 'ADD' THEN 'A'
                                        ELSE 'U'
                                   END
            ,EedPendingEffDate = CONVERT(CHAR(10),GETDATE(),101)
            ,EedInclInAddlChk = DedInclInAddlChk
            ,EedInclInManlChk = DedInclInManlChk
            ,EedPendingUpdateID = drvPendingUpdateID
        FROM dbo.U_IVOYA401K_drvTbl WITH (NOLOCK)
        JOIN dbo.DedCode WITH (NOLOCK)
            ON DedDedCode = drvDedCode
        WHERE drvImported = 0 AND drvImportType = 'LOAN';


         --======================================================================
        -- Generate XML File for Standard Web Import to Validate/Post Records
        --======================================================================
        DECLARE @XMLFilePath VARCHAR(1000) = IIF(dbo.dsi_fnVariable(@FormatCode, 'Testing') = 'Y',dbo.dsi_fnVariable(@FormatCode, 'XmlPath'),'')
               ,@XMLArchiveFilePath VARCHAR(1000) = dbo.Dsi_fnVariable(@FormatCode,'ArchivePath');

       PRINT CONCAT('----XML FILEPATH = ',@XmlFilePath)
        
        --IF (dbo.dsi_BIM_fn_GetValidateModeSetting() = 'TRUE')
        --    EXEC dbo.dsi_BIM_sp_GenerateXML @FormatCode, 'Deductions', '', @XMLArchiveFilePath;
        --ELSE
        --    EXEC dbo.dsi_BIM_sp_GenerateXML @FormatCode, 'Deductions', @XMLFilePath, @XMLArchiveFilePath;

    --    EXEC dbo.dsi_BIM_sp_GenerateXML @FormatCode, 'Deductions', @XMLFilePath, @XMLArchiveFilePath;
    END TRY
    BEGIN CATCH
       -- Report SQL Error in Error Report File
       INSERT INTO dbo.U_IPRINC401K_drvTbl (drvError,drvImported)
       SELECT 'Error Generating XML File for Standard Web Import: ' + ISNULL(ERROR_MESSAGE(),''),2;

       -- Stop Processing
       RETURN;
    END CATCH;

    --    --============================================================
    --    -- Generate XML File for Web Import Tool
    --    --============================================================
    --    DECLARE @XMLFilePath VARCHAR(1000) = '' --dbo.Dsi_fnVariable(@FormatCode,'XMLPath')
    --        ,@XMLArchiveFilePath VARCHAR(1000) = dbo.Dsi_fnVariable(@FormatCode,'ArchivePath');

    --    EXEC dbo.dsi_BIM_sp_GenerateXML @FormatCode, 'Deductions', @XMLFilePath, @XMLArchiveFilePath;
    --END TRY
    --BEGIN CATCH
    --   -- Report SQL Error in Error Report File
    --   INSERT INTO dbo.U_IVOYA401K_drvTbl (drvError)
    --   SELECT 'Error Loading Records for Validation/Posting: ' + ISNULL(ERROR_MESSAGE(),'');

    --   -- Stop Processing
    --   RETURN;
    --END CATCH;

    --==========================
    -- Report Successful Update
    --==========================
    UPDATE dbo.U_IVOYA401K_drvTbl
        SET drvError = 'Loaded Successfully'
            ,drvImported = 1
    WHERE drvImported = 0
    AND EXISTS (SELECT * FROM dbo.U_dsi_BIM_LodEDed WHERE EedFormatCode = @FormatCode AND EedPendingUpdateID = drvPendingUpdateID);

    --===========================
    -- Reject Remaining Records
    --===========================
    UPDATE dbo.u_IVOYA401K_drvTbl
        SET drvError = 'Record Rejected'
            ,drvAction = 'REJECTED'
            ,drvImported = 2
    WHERE drvImported = 0;

END
/**********************************************************************************

--Create the View
CREATE VIEW dbo.dsi_vwIVOYA401K_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_IVOYA401K_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'IVOYA401K%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET ExpLastStartPerControl = '201901011'
       ,ExpStartPerControl     = '201901011'
       ,ExpLastEndPerControl   = '201901019'
       ,ExpEndPerControl       = '201901019'
WHERE ExpFormatCode = 'IVOYA401K';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwIVOYA401K_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_IVOYA401K_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'IVOYA401K' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'IVOYA401K'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'IVOYA401K'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'IVOYA401K', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'IVOYA401K', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'IVOYA401K', 'UseFileName', 'V', 'Y'


-- End ripout