/**********************************************************************************

ECLOHSACON: Optum HSA Contribution Export

FormatCode:     ECLOHSACON
Project:        Optum HSA Contribution Export
Client ID:      EDU1002
Date/time:      2022-07-27 12:28:05.553
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    E15
Server:         E1SUP5DB03
Database:       ULTIPRO_ESA
Web Filename:   EDU1002_99956_EEHISTORY_ECLOHSACON_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ECLOHSACON_SavePath') IS NOT NULL DROP TABLE dbo.U_ECLOHSACON_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ECLOHSACON'


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
WHERE FormatCode = 'ECLOHSACON'
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
WHERE ExpFormatCode = 'ECLOHSACON'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ECLOHSACON')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ECLOHSACON'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ECLOHSACON'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ECLOHSACON'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ECLOHSACON'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ECLOHSACON'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ECLOHSACON'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ECLOHSACON'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ECLOHSACON'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ECLOHSACON'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwECLOHSACON_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECLOHSACON_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECLOHSACON') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECLOHSACON];
GO
IF OBJECT_ID('U_ECLOHSACON_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ECLOHSACON_PDedHist];
GO
IF OBJECT_ID('U_ECLOHSACON_File') IS NOT NULL DROP TABLE [dbo].[U_ECLOHSACON_File];
GO
IF OBJECT_ID('U_ECLOHSACON_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECLOHSACON_EEList];
GO
IF OBJECT_ID('U_ECLOHSACON_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ECLOHSACON_drvTbl];
GO
IF OBJECT_ID('U_ECLOHSACON_DedList') IS NOT NULL DROP TABLE [dbo].[U_ECLOHSACON_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_ECLOHSACON') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ECLOHSACON];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ECLOHSACON','Optum HSA Contribution Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','ECLOHSACONZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECLOHSACONZ0','50','H','01','1',NULL,'Transaction Type',NULL,NULL,'"Transaction Type"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECLOHSACONZ0','50','H','01','2',NULL,'Account Number',NULL,NULL,'"Account Number"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECLOHSACONZ0','50','H','01','3',NULL,'Credit Amount',NULL,NULL,'"Credit Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECLOHSACONZ0','50','H','01','4',NULL,'Contribution Type',NULL,NULL,'"Contribution Type"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECLOHSACONZ0','50','H','01','5',NULL,'Social Security Number',NULL,NULL,'"Social Security Number"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECLOHSACONZ0','50','D','10','1',NULL,'Transaction Type',NULL,NULL,'"Contribution"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECLOHSACONZ0','50','D','10','2',NULL,'Account Number',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECLOHSACONZ0','50','D','10','3',NULL,'Credit Amount',NULL,NULL,'"drvCreditAmount"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECLOHSACONZ0','50','D','10','4',NULL,'Contribution Type',NULL,NULL,'"drvContributionType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECLOHSACONZ0','50','D','10','5',NULL,'Social Security Number',NULL,NULL,'"drvSocialSecurityNumber"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ECLOHSACON_20220727.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Optum HSA Contribution Export','202206219','EMPEXPORT','ONDEM_XOE',NULL,'ECLOHSACON',NULL,NULL,NULL,'202206219','Jun 21 2022  4:29PM','Jun 21 2022  4:29PM','202206211',NULL,'','','202206211',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Optum HSA Contribution E-Sched','202206219','EMPEXPORT','SCH_ECLOHS',NULL,'ECLOHSACON',NULL,NULL,NULL,'202206219','Jun 21 2022  4:29PM','Jun 21 2022  4:29PM','202206211',NULL,'','','202206211',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Optum HSA Contribution E-Test','202207011','EMPEXPORT','TEST_XOE','Jul 22 2022 12:00AM','ECLOHSACON',NULL,NULL,NULL,'202207011','Jul  1 2022 12:00AM','Jun 25 2022 12:00AM','202207011',NULL,'eecPayGroup','ACE,CLIK,CORP,EAP,EDALTE,FLESA,GROW,OESADM,OES,PAYB,RAY,ROSSIE,SCI,SCEAST,WORK,WORKRP','202207011',dbo.fn_GetTimedKey(),NULL,'us3cPeEDU1002',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECLOHSACON','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECLOHSACON','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECLOHSACON','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECLOHSACON','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECLOHSACON','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECLOHSACON','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECLOHSACON','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECLOHSACON','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECLOHSACON','D10','dbo.U_ECLOHSACON_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_ECLOHSACON
-----------

IF OBJECT_ID('U_dsi_BDM_ECLOHSACON') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ECLOHSACON] (
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

-----------
-- Create table U_ECLOHSACON_DedList
-----------

IF OBJECT_ID('U_ECLOHSACON_DedList') IS NULL
CREATE TABLE [dbo].[U_ECLOHSACON_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_ECLOHSACON_drvTbl
-----------

IF OBJECT_ID('U_ECLOHSACON_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ECLOHSACON_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvSort] char(12) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvCreditAmount] varchar(8000) NULL,
    [drvContributionType] varchar(34) NOT NULL,
    [drvSocialSecurityNumber] varchar(11) NULL
);

-----------
-- Create table U_ECLOHSACON_EEList
-----------

IF OBJECT_ID('U_ECLOHSACON_EEList') IS NULL
CREATE TABLE [dbo].[U_ECLOHSACON_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ECLOHSACON_File
-----------

IF OBJECT_ID('U_ECLOHSACON_File') IS NULL
CREATE TABLE [dbo].[U_ECLOHSACON_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);

-----------
-- Create table U_ECLOHSACON_PDedHist
-----------

IF OBJECT_ID('U_ECLOHSACON_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ECLOHSACON_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECLOHSACON]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: ChanceLight

Created By: Roger Bynum
Business Analyst: Cheryl Petitti
Create Date: 06/21/2022
Service Request Number: TekP-2022-04-14-01

Purpose: Optum HSA Contribution Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECLOHSACON';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECLOHSACON';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECLOHSACON';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, 
ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECLOHSACON';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECLOHSACON' ORDER BY RunID DESC;
Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECLOHSACON', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECLOHSACON', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECLOHSACON', 'SCH_ECLOHS';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ECLOHSACON';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ECLOHSACON', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ECLOHSACON';

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
    DELETE FROM dbo.U_ECLOHSACON_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECLOHSACON_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'HSADE, HSAEE, HSDCU, HSECU, HSAUP';

    IF OBJECT_ID('U_ECLOHSACON_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ECLOHSACON_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ECLOHSACON_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DedList) ;
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

    -- Non-Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'FutureDatedStartDateDays','30');
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'FutureDatedStopDateDays','30');
    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_ECLOHSACON_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ECLOHSACON_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        --,PdhEEHSADE     = SUM(CASE WHEN PdhDedCode IN ('HSADE') THEN PdhEECurAmt ELSE 0.00 END)
        --,PdhEEHSAEE     = SUM(CASE WHEN PdhDedCode IN ('HSAEE') THEN PdhEECurAmt ELSE 0.00 END)
        --,PdhEEHSDCU     = SUM(CASE WHEN PdhDedCode IN ('HSDCU') THEN PdhERCurAmt ELSE 0.00 END)        
        --,PdhEEHSECU     = SUM(CASE WHEN PdhDedCode IN ('HSECU') THEN PdhEECurAmt ELSE 0.00 END)
        --,PdhEEHSAUP     = SUM(CASE WHEN PdhDedCode IN ('HSAUP') THEN PdhEECurAmt ELSE 0.00 END)
        --,PdhERHSADE     = SUM(CASE WHEN PdhDedCode IN ('HSADE') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        --,PdhERHSAEE     = SUM(CASE WHEN PdhDedCode IN ('HSAEE') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        --,PdhERHSDCU     = SUM(CASE WHEN PdhDedCode IN ('HSDCU') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        --,PdhERHSECU     = SUM(CASE WHEN PdhDedCode IN ('HSECU') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        --,PdhERHSAUP     = SUM(CASE WHEN PdhDedCode IN ('HSAUP') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    INTO dbo.U_ECLOHSACON_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ECLOHSACON_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
 --   AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );


    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ECLOHSACON_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ECLOHSACON_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECLOHSACON_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSort = xEEID
        ,drvSubSort = '1'
        -- standard fields above and additional driver fields below
        ,drvCreditAmount = REPLACE(bdmEEAmt, '.' ,'') --'"' + REPLACE(SUBSTRING(bdmEEAmt,1, LEN(bdmEEAmt) -2), '.' ,'') + '00"'
        ,drvContributionType = 'Current Year Employee Contribution'
        ,drvSocialSecurityNumber = TRIM(EepSSN) 
    INTO dbo.U_ECLOHSACON_drvTbl
    FROM dbo.U_ECLOHSACON_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON eepEEID = xEEID
    JOIN (SELECT bdmEEID as BdmEEID,
            bdmCOID AS bdmCOID, 
            'Y' AS bdmEECode,
            CAST(SUM (bdmEEAmt)AS VARCHAR) AS bdmEEAmt
            from dbo.U_dsi_BDM_ECLOHSACON WITH (NOLOCK)
            WHERE bdmDedcode IN ('HSADE', 'HSAEE', 'HSDCU', 'HSECU')
            AND bdmEEAmt > 0
            GROUP BY bdmEEID, bdmCOID) AS BdmFlattenedEE
        ON BdmEEID = xEEID
            
    ;
    INSERT INTO dbo.U_ECLOHSACON_drvTbl
     (drvEEID
    ,drvCoID
    ,drvSort
    ,drvSubSort
    -- standard fields above
    ,drvCreditAmount
    ,drvContributionType
    ,drvSocialSecurityNumber)

    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSort = xEEID
        ,drvSubSort = '2'
        -- standard fields above and additional driver fields below
        ,drvCreditAmount = REPLACE(LEFT(PdhERCurAmt, (LEN(pdhERCUrAmt) - 2)), '.', '')  
        ,drvContributionType = 'Current Year Employer Contribution'
        ,drvSocialSecurityNumber = TRIM(EepSSN) 
    FROM dbo.U_ECLOHSACON_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON eepEEID = xEEID
    JOIN dbo.U_ECLOHSACON_PDedHist WITH (NOLOCK)
        ON pdhEEID = xEEID
    JOIN dbo.U_ECLOHSACON_drvTbl d on xEEID = d.drvEEID
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
ALTER VIEW dbo.dsi_vwECLOHSACON_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECLOHSACON_File (NOLOCK)
    ORDER BY InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'ECLOHSACON%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202206141'
       ,expStartPerControl     = '202206141'
       ,expLastEndPerControl   = '202206219'
       ,expEndPerControl       = '202206219'
WHERE expFormatCode = 'ECLOHSACON';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwECLOHSACON_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECLOHSACON_File (NOLOCK)
    ORDER BY InitialSort, SubSort;

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ECLOHSACON' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ECLOHSACON'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ECLOHSACON'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECLOHSACON', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ECLOHSACON', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECLOHSACON', 'UseFileName', 'V', 'Y'


-- End ripout