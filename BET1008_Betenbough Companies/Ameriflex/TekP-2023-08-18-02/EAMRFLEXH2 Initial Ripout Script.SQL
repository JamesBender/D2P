/**********************************************************************************

EAMRFLEXH2: Ameriflex FSA IH Test

FormatCode:     EAMRFLEXH2
Project:        Ameriflex FSA IH Test
Client ID:      BET1008
Date/time:      2023-09-25 15:44:13.440
Ripout version: 7.4
Export Type:    Web
Status:         Production
Environment:    NWP
Server:         NW1WUP7DB03
Database:       ULTIPRO_WPBETB
Web Filename:   BET1008_SC6HO_EEHISTORY_EAMRFLEXH2_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EAMRFLEXH2_SavePath') IS NOT NULL DROP TABLE dbo.U_EAMRFLEXH2_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EAMRFLEXH2'


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
WHERE FormatCode = 'EAMRFLEXH2'
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
WHERE ExpFormatCode = 'EAMRFLEXH2'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EAMRFLEXH2')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EAMRFLEXH2'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EAMRFLEXH2'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EAMRFLEXH2'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EAMRFLEXH2'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EAMRFLEXH2'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EAMRFLEXH2'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EAMRFLEXH2'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EAMRFLEXH2'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EAMRFLEXH2'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEAMRFLEXH2_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEAMRFLEXH2_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EAMRFLEXH2') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EAMRFLEXH2];
GO
IF OBJECT_ID('U_EAMRFLEXH2_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EAMRFLEXH2_PDedHist];
GO
IF OBJECT_ID('U_EAMRFLEXH2_File') IS NOT NULL DROP TABLE [dbo].[U_EAMRFLEXH2_File];
GO
IF OBJECT_ID('U_EAMRFLEXH2_EEList') IS NOT NULL DROP TABLE [dbo].[U_EAMRFLEXH2_EEList];
GO
IF OBJECT_ID('U_EAMRFLEXH2_DedList') IS NOT NULL DROP TABLE [dbo].[U_EAMRFLEXH2_DedList];
GO
IF OBJECT_ID('U_EAMRFLEXH2_D10') IS NOT NULL DROP TABLE [dbo].[U_EAMRFLEXH2_D10];
GO
IF OBJECT_ID('U_EAMRFLEXH2_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EAMRFLEXH2_AuditFields];
GO
IF OBJECT_ID('U_EAMRFLEXH2_Audit') IS NOT NULL DROP TABLE [dbo].[U_EAMRFLEXH2_Audit];
GO
IF OBJECT_ID('U_dsi_EAMRFLEXH2_DedHist') IS NOT NULL DROP TABLE [dbo].[U_dsi_EAMRFLEXH2_DedHist];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EAMRFLEXH2','Ameriflex FSA IH Test','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','89','S','N','EZUCVM000RY0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EZUCVM000RY0','2','D','10','1',NULL,'Record ID',NULL,NULL,'"drvRecordID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EZUCVM000RY0','6','D','10','3',NULL,'TPA ID',NULL,NULL,'"drvTPAID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EZUCVM000RY0','9','D','10','9',NULL,'Group Code',NULL,NULL,'"drvGroupCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EZUCVM000RY0','3','D','10','18',NULL,'Account Type',NULL,NULL,'"drvAccountType"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EZUCVM000RY0','8','D','10','21',NULL,'Plan Year Start date',NULL,NULL,'"drvPlanYearStartdate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EZUCVM000RY0','8','D','10','29',NULL,'Plan Year End date',NULL,NULL,'"drvPlanYearEnddate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EZUCVM000RY0','9','D','10','37',NULL,'Social Security Number',NULL,NULL,'"drvSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EZUCVM000RY0','18','D','10','46',NULL,'Enrollee Deposit Amount',NULL,NULL,'"drvEnrolleeDepositAmount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EZUCVM000RY0','18','D','10','64',NULL,'Employer Deposit Amount',NULL,NULL,'"drvEmployerDepositAmount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EZUCVM000RY0','8','D','10','82',NULL,'Effective Date of Deduction/Deposit (Pay Date)',NULL,NULL,'"drvEffectiveDateofDeduction"','(''UD112''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EAMRFLEXH2_20230925.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Test','201708169','EMPEXPORT','OEACTIVE','Oct 14 2017 12:00AM','EAMRFLEXH2',NULL,NULL,NULL,'201708169','Aug 16 2017 12:00AM','Dec 30 1899 12:00AM','201708161',NULL,NULL,NULL,'201708161',dbo.fn_GetTimedKey(),NULL,'ULTI_WPEDFT',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Test','201708169','EMPEXPORT','OEPASSIVE','Oct 14 2017 12:00AM','EAMRFLEXH2',NULL,NULL,NULL,'201708169','Aug 16 2017 12:00AM','Dec 30 1899 12:00AM','201708161',NULL,NULL,NULL,'201708161',dbo.fn_GetTimedKey(),NULL,'ULTI_WPEDFT',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Ameriflex FSA IH Test Export','201902259','EMPEXPORT','ONDEMAND','Feb 25 2019  3:18PM','EAMRFLEXH2',NULL,NULL,NULL,'201902259','Feb 25 2019 12:00AM','Dec 30 1899 12:00AM','201902251','0',NULL,NULL,'201902251',dbo.fn_GetTimedKey(),NULL,'ULTI_WPEDFT',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Test Purposes Only','202308311','EMPEXPORT','TEST','Mar 10 2022  1:34PM','EAMRFLEXH2',NULL,NULL,NULL,'202308311','Dec  9 2021 12:00AM','Dec  4 2021 12:00AM','202308311','16',NULL,NULL,'202308311',dbo.fn_GetTimedKey(),NULL,'ULTI_WPBETB',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAMRFLEXH2','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAMRFLEXH2','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAMRFLEXH2','InitialSort','C','drvSSN');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAMRFLEXH2','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAMRFLEXH2','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAMRFLEXH2','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EAMRFLEXH2','D10','dbo.U_EAMRFLEXH2_D10',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_EAMRFLEXH2_DedHist
-----------

IF OBJECT_ID('U_dsi_EAMRFLEXH2_DedHist') IS NULL
CREATE TABLE [dbo].[U_dsi_EAMRFLEXH2_DedHist] (
    [heeid] char(12) NULL,
    [hcoid] char(5) NULL,
    [hdedcode] char(5) NOT NULL,
    [heeamt] money NULL,
    [heramt] money NULL
);

-----------
-- Create table U_EAMRFLEXH2_Audit
-----------

IF OBJECT_ID('U_EAMRFLEXH2_Audit') IS NULL
CREATE TABLE [dbo].[U_EAMRFLEXH2_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audKey2] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] varchar(2000) NULL,
    [audNewValue] varchar(2000) NULL,
    [audRowNo] bigint NULL
);

-----------
-- Create table U_EAMRFLEXH2_AuditFields
-----------

IF OBJECT_ID('U_EAMRFLEXH2_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EAMRFLEXH2_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EAMRFLEXH2_D10
-----------

IF OBJECT_ID('U_EAMRFLEXH2_D10') IS NULL
CREATE TABLE [dbo].[U_EAMRFLEXH2_D10] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvRecordID] varchar(2) NOT NULL,
    [drvTPAID] varchar(6) NOT NULL,
    [drvGroupCode] varchar(9) NOT NULL,
    [drvAccountType] varchar(3) NULL,
    [drvPlanYearStartdate] varchar(30) NULL,
    [drvPlanYearEnddate] varchar(30) NULL,
    [drvSSN] char(11) NULL,
    [drvEnrolleeDepositAmount] varchar(24) NULL,
    [drvEmployerDepositAmount] varchar(24) NULL,
    [drvEffectiveDateofDeduction] varchar(8) NULL
);

-----------
-- Create table U_EAMRFLEXH2_DedList
-----------

IF OBJECT_ID('U_EAMRFLEXH2_DedList') IS NULL
CREATE TABLE [dbo].[U_EAMRFLEXH2_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EAMRFLEXH2_EEList
-----------

IF OBJECT_ID('U_EAMRFLEXH2_EEList') IS NULL
CREATE TABLE [dbo].[U_EAMRFLEXH2_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EAMRFLEXH2_File
-----------

IF OBJECT_ID('U_EAMRFLEXH2_File') IS NULL
CREATE TABLE [dbo].[U_EAMRFLEXH2_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(89) NULL
);

-----------
-- Create table U_EAMRFLEXH2_PDedHist
-----------

IF OBJECT_ID('U_EAMRFLEXH2_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EAMRFLEXH2_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhPlan] varchar(3) NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EAMRFLEXH2]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Betenbough

Created By: Gaspare Simeti
Business Analyst: Gaspare Simeti
Create Date: 2/1/22
Service Request Number: 00289016

Purpose: Ameriflex IH Test

Revision History'
----------------
Update By           Date           Request Num        Desc
Marie Waters        09/25/2023       TekP-2023-08-18-02  Added HSA and determine the code for original file is pulling 0 records when running a percontrol ending in > 1
XXXX                XX/XX/2017     SR-2017-000XXXXX   XXXXX


SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EAMRFLEXH2';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EAMRFLEXH2';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EAMRFLEXH2';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EAMRFLEXH2';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EAMRFLEXH2' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAMRFLEXH2', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAMRFLEXH2', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAMRFLEXH2', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAMRFLEXH2', 'TEST';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EAMRFLEXH2';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EAMRFLEXH2', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@EndPerControl     VARCHAR(9)

    -- Set FormatCode
    SELECT @FormatCode = 'EAMRFLEXH2';

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
    DELETE FROM dbo.U_EAMRFLEXH2_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EAMRFLEXH2_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    ---This requires both the start and end percontrols to end in  1
    DELETE FROM dbo.U_EAMRFLEXH2_EEList WHERE RIGHT(@ENDPERCONTROL,1) > 1;

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'FSAMD,FSADC,FSALT,HSA';

    IF OBJECT_ID('U_EAMRFLEXH2_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EAMRFLEXH2_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EAMRFLEXH2_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;
        
    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EAMRFLEXH2_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EAMRFLEXH2_PDedHist;
    SELECT DISTINCT
         PdhEEID
        ,PdhPlan          = CASE
                                WHEN PdhDedCode = 'FSAMD' THEN 'FSA'
                                WHEN PdhDedCode = 'FSADC' THEN 'DCA'
                                WHEN PdhDedCode = 'FSALT' THEN 'LPF'
                                WHEN PdhDedCode LIKE 'HSA' THEN 'ABH'
                                END
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)


    INTO dbo.U_EAMRFLEXH2_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EAMRFLEXH2_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID, CASE
                                WHEN PdhDedCode = 'FSAMD' THEN 'FSA'
                                WHEN PdhDedCode = 'FSADC' THEN 'DCA'
                                WHEN PdhDedCode = 'FSALT' THEN 'LPF'
                                WHEN PdhDedCode LIKE 'HSA' THEN 'ABH'
                                END
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );




    --Get the last pay date
    declare @LastPayDate as datetime
    SELECT @LastPayDate = max(prgpaydate)  FROM IPAYREGKEYS WHERE prgdocno <> 'ADJUSTMENT'
    AND PrgPERCONTROL BETWEEN @StartPerControl and @EndPerControl
    
    --==========================================
    -- Non Standard Plan Year Date
    --==========================================    
    DECLARE @FSAPlanYearStart VARCHAR(10);
    DECLARE @FSAPlanYearEnd   VARCHAR(10);
    DECLARE @HSAPlanYearStart VARCHAR(10);
    DECLARE @HSAPlanYearEnd   VARCHAR(10);
    
    SET @FSAPlanYearStart = CAST(DATEPART(YYYY,@EndDate) as VARCHAR)+'0101' /*CASE     WHEN DATEPART(MM,@EndDate) < 7 THEN LTRIM(STR(DATEPART(YY,DATEADD(YY,-1,@EndDate)))) + '0701'
                                WHEN DATEPART(MM,@EndDate) >= 7 THEN LTRIM(STR(DATEPART(YY,DATEADD(YY,0,@EndDate)))) + '0701'
                                END;*/
                                
    SET @FSAPlanYearEnd   = CAST(DATEPART(YYYY,@EndDate) as VARCHAR)+'1231' /*CASE     WHEN DATEPART(MM,@EndDate) < 7 THEN LTRIM(STR(DATEPART(YY,DATEADD(YY,0,@EndDate)))) + '0630'
                                WHEN DATEPART(MM,@EndDate) >= 7 THEN LTRIM(STR(DATEPART(YY,DATEADD(YY,1,@EndDate)))) + '0630'
                                END; */
                                            
    SET @HSAPlanYearStart = '20230401';
                                
    SET @HSAPlanYearEnd   = '20991231';
    
    PRINT 'FSA Plan Year Start:  ' + @FSAPlanYearStart;
    PRINT 'FSA Plan Year End:  ' + @FSAPlanYearEnd;    
    PRINT 'HSA Plan Year Start:  ' + @HSAPlanYearStart;
    PRINT 'HSA Plan Year End:  ' + @HSAPlanYearEnd;    

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EAMRFLEXH2_D10
    ---------------------------------
    IF OBJECT_ID('U_EAMRFLEXH2_D10','U') IS NOT NULL
        DROP TABLE dbo.U_EAMRFLEXH2_D10;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvRecordID = 'IH'
        ,drvTPAID = 'AMF001'
        ,drvGroupCode = 'AMFBETENB'
        ,drvAccountType = PdhPlan
        ,drvPlanYearStartdate = CASE WHEN PdhPlan = 'ABH' THEN CONVERT(varchar,@HSAPlanYearStart,112) ELSE CONVERT(varchar,@FSAPlanYearStart,112) END --@FSAPlanYearStart
        ,drvPlanYearEnddate = CASE WHEN PdhPlan = 'ABH' THEN CONVERT(varchar,@HSAPlanYearEnd,112) ELSE CONVERT(varchar,@FSAPlanYearEnd,112) END --@FSAPlanYearEnd 
        ,drvSSN = EepSSN
        ,drvEnrolleeDepositAmount = dbo.dsi_fnPadZero(PdhEECurAmt,18,2)
        ,drvEmployerDepositAmount = dbo.dsi_fnPadZero(PdhERCurAmt,18,2)
        ,drvEffectiveDateofDeduction = CONVERT(varchar(8),@LastPayDate,112)
    INTO dbo.U_EAMRFLEXH2_D10
    FROM dbo.U_EAMRFLEXH2_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON xEEID = EecEEID 
        AND xCOID = EecCOID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON xEEID = EepEEID
    JOIN dbo.Company
        ON xCOID = CmpCoID
    JOIN dbo.U_EAMRFLEXH2_PDedHist
        ON PdhEEID = xEEID
        Order by EepSSN

 ;

    --==========================================
    -- Set FileName
    --==========================================
    --IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    --BEGIN
    --    UPDATE dbo.U_dsi_Parameters
    --        SET ExportFile = 'EDFT_EAMRFLEXH2_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.TXT'
    --    WHERE FormatCode = @FormatCode;
    --END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEAMRFLEXH2_Export AS
    SELECT TOP 20000000 Data
    FROM dbo.U_EAMRFLEXH2_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EAMRFLEXH2%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202308311'
       ,expStartPerControl     = '202308311'
       ,expLastEndPerControl   = '202308311'
       ,expEndPerControl       = '202308311'
WHERE expFormatCode = 'EAMRFLEXH2' and expexportcode = 'TEST';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEAMRFLEXH2_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EAMRFLEXH2_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EAMRFLEXH2' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EAMRFLEXH2'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EAMRFLEXH2'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EAMRFLEXH2', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EAMRFLEXH2', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EAMRFLEXH2', 'UseFileName', 'V', 'Y'


-- End ripout