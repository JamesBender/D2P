SET NOCOUNT ON;
IF OBJECT_ID('U_EHLTHYOU_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EHLTHYOU_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EHLTHYOU_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EHLTHYOU' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEHLTHYOU_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEHLTHYOU_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EHLTHYOU') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EHLTHYOU];
GO
IF OBJECT_ID('U_EHLTHYOU_File') IS NOT NULL DROP TABLE [dbo].[U_EHLTHYOU_File];
GO
IF OBJECT_ID('U_EHLTHYOU_EEList') IS NOT NULL DROP TABLE [dbo].[U_EHLTHYOU_EEList];
GO
IF OBJECT_ID('U_EHLTHYOU_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EHLTHYOU_drvTbl];
GO
IF OBJECT_ID('U_EHLTHYOU_DedList') IS NOT NULL DROP TABLE [dbo].[U_EHLTHYOU_DedList];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EHLTHYOU';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EHLTHYOU';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EHLTHYOU';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EHLTHYOU';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EHLTHYOU';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EHLTHYOU','HealthiestYou','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','EHLTHYOU00Z0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EHLTHYOU' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HY3065"','1','(''DA''=''T,'')','EHLTHYOU00Z0','64','D','10','1',NULL,'Group Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','2','(''SS''=''T,'')','EHLTHYOU00Z0','32','D','10','2',NULL,'SubGroup ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','3','(''UA''=''T,'')','EHLTHYOU00Z0','15','D','10','3',NULL,'Member ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','4','(''UA''=''T,'')','EHLTHYOU00Z0','25','D','10','4',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','5','(''UA''=''T,'')','EHLTHYOU00Z0','1','D','10','5',NULL,'Middle Init',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','6','(''UA''=''T,'')','EHLTHYOU00Z0','25','D','10','6',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','7','(''UA''=''T,'')','EHLTHYOU00Z0','40','D','10','7',NULL,'Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2 "','8','(''UA''=''T,'')','EHLTHYOU00Z0','40','D','10','8',NULL,'Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity "','9','(''UA''=''T,'')','EHLTHYOU00Z0','30','D','10','9',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState "','10','(''UA''=''T,'')','EHLTHYOU00Z0','2','D','10','10',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode "','11','(''UA''=''T,'')','EHLTHYOU00Z0','10','D','10','11',NULL,'Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneHomeNumber "','12','(''UA''=''T,'')','EHLTHYOU00Z0','20','D','10','12',NULL,'Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressEMail"','13','(''UA''=''T,'')','EHLTHYOU00Z0','50','D','10','13',NULL,'Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelationship"','14','(''UA''=''T,'')','EHLTHYOU00Z0','1','D','10','14',NULL,'Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','15','(''UD101''=''T,'')','EHLTHYOU00Z0','10','D','10','15',NULL,'Birth Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','16','(''UA''=''T,'')','EHLTHYOU00Z0','1','D','10','16',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenStartDate"','17','(''UD101''=''T,'')','EHLTHYOU00Z0','10','D','10','17',NULL,'Coverage Eff',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenTermDate"','18','(''UD101''=''T,'')','EHLTHYOU00Z0','10','D','10','18',NULL,'Coverage Term',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"1"','19','(''DA''=''T,'')','EHLTHYOU00Z0','1','D','10','19',NULL,'Demographics',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUserField"','20','(''UA''=''T'')','EHLTHYOU00Z0','50','D','10','20',NULL,'User requested Fields',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EHLTHYOU_20210519.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'HealthiestYou','202104279','EMPEXPORT','ONDEM_XOE',NULL,'EHLTHYOU',NULL,NULL,NULL,'202104279','Apr 27 2021  9:35AM','Apr 27 2021  9:35AM','202104271',NULL,'','','202104271',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'HealthiestYou-Sched','202104279','EMPEXPORT','SCH_EHLTHY',NULL,'EHLTHYOU',NULL,NULL,NULL,'202104279','Apr 27 2021  9:35AM','Apr 27 2021  9:35AM','202104271',NULL,'','','202104271',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'HealthiestYou-Test','202105181','EMPEXPORT','TEST_XOE','May 18 2021  6:45PM','EHLTHYOU',NULL,NULL,NULL,'202105181','May 18 2021 12:00AM','Dec 30 1899 12:00AM','202105041','348','','','202105041',dbo.fn_GetTimedKey(),NULL,'us3cPeTOP1004',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHLTHYOU','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHLTHYOU','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHLTHYOU','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHLTHYOU','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHLTHYOU','SubSort2','C','drvSubSort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHLTHYOU','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHLTHYOU','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EHLTHYOU' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EHLTHYOU' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EHLTHYOU_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EHLTHYOU_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EHLTHYOU','D10','dbo.U_EHLTHYOU_drvTbl',NULL);
IF OBJECT_ID('U_EHLTHYOU_DedList') IS NULL
CREATE TABLE [dbo].[U_EHLTHYOU_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EHLTHYOU_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EHLTHYOU_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] char(9) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSSN] varchar(11) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvPhoneHomeNumber] varchar(50) NULL,
    [drvAddressEMail] varchar(50) NULL,
    [drvRelationship] varchar(1) NOT NULL,
    [drvDateOfBirth] datetime NULL,
    [drvGender] char(1) NULL,
    [drvBenStartDate] datetime NULL,
    [drvBenTermDate] datetime NULL,
    [drvUserField] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EHLTHYOU_EEList') IS NULL
CREATE TABLE [dbo].[U_EHLTHYOU_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EHLTHYOU_File') IS NULL
CREATE TABLE [dbo].[U_EHLTHYOU_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EHLTHYOU]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Toptal, LLC  

Created By: Keary McCutchen
Business Analyst: Cheryl Petitti
Create Date: 04/27/2021
Service Request Number: SR-2021-00308762

Purpose: HealthiestYou

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EHLTHYOU';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EHLTHYOU';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EHLTHYOU';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EHLTHYOU';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EHLTHYOU' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHLTHYOU', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHLTHYOU', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHLTHYOU', 'SCH_EHLTHY';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EHLTHYOU';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EHLTHYOU', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EHLTHYOU';

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
    DELETE FROM dbo.U_EHLTHYOU_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EHLTHYOU_EEList GROUP BY xEEID HAVING COUNT(1) > 1);
    
    -- Cleans EE List of Employees Where EecEmpType = TES
    DELETE FROM dbo.U_EDISCCOBRA_EEList WHERE xEEID IN (
        SELECT DISTINCT EecEEID  FROM dbo.EmpComp WITH (NOLOCK) WHERE EecEEType IN ('TES')
    )
    OR xEEID IN (
        SELECT DISTINCT EepEEID  FROM dbo.EmpPers WITH (NOLOCK) WHERE LEFT(EepSSN,3) = '999'
    )

     
    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'MDHSA, MDPPO';

    IF OBJECT_ID('U_EHLTHYOU_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EHLTHYOU_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EHLTHYOU_DedList
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
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'ExclFutureDatedStopDates', 'Y')

    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EHLTHYOU_drvTbl
    -- Add Employee Records
    ---------------------------------
    IF OBJECT_ID('U_EHLTHYOU_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EHLTHYOU_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = EecEmpNo
        ,drvSubSort = '0'
        ,drvSubSort2 = ''
        -- standard fields above and additional driver fields below
        ,drvSSN =  SUBSTRING(EepSSN, 1, 3) + '-' + SUBSTRING(EepSSN, 4, 2) + '-' + SUBSTRING(EepSSN, 6,4) 
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvNameLast = EepNameLast
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvPhoneHomeNumber = EepPhoneHomeNumber
        ,drvAddressEMail = EepAddressEMail
        ,drvRelationship = 'E'
        ,drvDateOfBirth = EepDateOfBirth
        ,drvGender = EepGender
        ,drvBenStartDate = EedBenStartDate
        ,drvBenTermDate = EedBenStopDate
        ,drvUserField = ''
    INTO dbo.U_EHLTHYOU_drvTbl
    FROM dbo.U_EHLTHYOU_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = xEEID 
        AND EedCoID = xCoID
        AND EedFormatCode = @FormatCode 
        AND EedValidForExport = 'Y'
    ;

    ---------------------------------
    -- Add Dependent Records
    ---------------------------------
    INSERT INTO dbo.U_EHLTHYOU_drvTbl
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12), ConSystemID) --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = EecEmpNo
        ,drvSubSort = CASE WHEN ConRelationship IN ('DP','SPS','SO') THEN '1' ELSE '2' END
        ,drvSubSort2 = ''
        -- standard fields above and additional driver fields below
        ,drvSSN =  SUBSTRING(ConSSN, 1, 3) + '-' + SUBSTRING(ConSSN, 4, 2) + '-' + SUBSTRING(ConSSN, 6,4) 
        ,drvNameFirst = ConNameFirst
        ,drvNameMiddle = LEFT(ConNameMiddle,1)
        ,drvNameLast = ConNameLast
        ,drvAddressLine1 = ConAddressLine1
        ,drvAddressLine2 = ConAddressLine2
        ,drvAddressCity = ConAddressCity
        ,drvAddressState = ConAddressState
        ,drvAddressZipCode = ConAddressZipCode
        ,drvPhoneHomeNumber = ConPhoneHomeNumber
        ,drvAddressEMail = EepAddressEMail
        ,drvRelationship = CASE WHEN ConRelationship IN ('SPS','DP','SO') THEN 'S' 
                                WHEN ConRelationship IN ('CHD','CHL','D') THEN 'D'
                            ELSE ''
                            END
        ,drvDateOfBirth = ConDateOfBirth
        ,drvGender = CASE WHEN ConGender IN ('M','F') THEN ConGender ELSE 'U' END
        ,drvBenStartDate = DbnBenStartDate
        ,drvBenTermDate = DbnBenStopDate
        ,drvUserField = ''
    FROM dbo.U_EHLTHYOU_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
        ON DbnDepRecID = ConSystemID
        AND DbnFormatCode = @FormatCode 
        AND DbnValidForExport = 'Y'
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'TEST_HY3065_STANDARD2_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.csv'
                                  ELSE 'HY3065_STANDARD2_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.csv'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEHLTHYOU_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EHLTHYOU_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EHLTHYOU%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202104011'
       ,expStartPerControl     = '202104011'
       ,expLastEndPerControl   = '202104279'
       ,expEndPerControl       = '202104279'
WHERE expFormatCode = 'EHLTHYOU';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEHLTHYOU_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EHLTHYOU_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort, SubSort2