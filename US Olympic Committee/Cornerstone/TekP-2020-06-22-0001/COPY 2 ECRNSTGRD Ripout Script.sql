SET NOCOUNT ON;
IF OBJECT_ID('U_ECRNSTGRDE_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECRNSTGRDE_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ECRNSTGRDE_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ECRNSTGRDE' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwECRNSTGRDE_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECRNSTGRDE_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECRNSTGRDE') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECRNSTGRDE];
GO
IF OBJECT_ID('U_ECRNSTGRDE_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ECRNSTGRDE_PEarHist];
GO
IF OBJECT_ID('U_ECRNSTGRDE_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ECRNSTGRDE_PDedHist];
GO
IF OBJECT_ID('U_ECRNSTGRDE_File') IS NOT NULL DROP TABLE [dbo].[U_ECRNSTGRDE_File];
GO
IF OBJECT_ID('U_ECRNSTGRDE_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECRNSTGRDE_EEList];
GO
IF OBJECT_ID('U_ECRNSTGRDE_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ECRNSTGRDE_drvTbl];
GO
IF OBJECT_ID('U_ECRNSTGRDE_DedList') IS NOT NULL DROP TABLE [dbo].[U_ECRNSTGRDE_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_ECRNSTGRDE') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ECRNSTGRDE];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ECRNSTGRDE';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ECRNSTGRDE';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ECRNSTGRDE';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ECRNSTGRDE';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ECRNSTGRDE';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ECRNSTGRDE','Cornerstone Grade Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','3000','S','N','ECRNSTGRDEZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OU ID"','44','(''DA''=''T,'')','ECRNSTGRDEZ0','50','H','01','44',NULL,'OU ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OU Name"','45','(''DA''=''T,'')','ECRNSTGRDEZ0','50','H','01','45',NULL,'OU Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Parent ID"','46','(''DA''=''T,'')','ECRNSTGRDEZ0','50','H','01','46',NULL,'Parent ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Owner ID"','47','(''DA''=''T,'')','ECRNSTGRDEZ0','50','H','01','47',NULL,'Owner ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Description"','48','(''DA''=''T,'')','ECRNSTGRDEZ0','50','H','01','48',NULL,'Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Allow Reconciliation"','49','(''DA''=''T'')','ECRNSTGRDEZ0','50','H','01','49',NULL,'Allow Reconciliation',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ECRNSTGRDE_20200728.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Test Purposes Only','202007259','EMPEXPORT','TEST',NULL,'ECRNSTGRDE',NULL,NULL,NULL,'202007259','Jul 25 2020  6:37PM','Jul 25 2020  6:37PM','202007251',NULL,'','','202007251',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ECRNSTGRDE_20200728.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','202007259','EMPEXPORT','SCHEDULED',NULL,'ECRNSTGRDE',NULL,NULL,NULL,'202007259','Jul 25 2020  6:37PM','Jul 25 2020  6:37PM','202007251',NULL,'','','202007251',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ECRNSTGRDE_20200728.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202007259','EMPEXPORT','OEACTIVE',NULL,'ECRNSTGRDE',NULL,NULL,NULL,'202007259','Jul 25 2020  6:37PM','Jul 25 2020  6:37PM','202007251',NULL,'','','202007251',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ECRNSTGRDE_20200728.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202007259','EMPEXPORT','OEPASSIVE',NULL,'ECRNSTGRDE',NULL,NULL,NULL,'202007259','Jul 25 2020  6:37PM','Jul 25 2020  6:37PM','202007251',NULL,'','','202007251',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ECRNSTGRDE_20200728.txt',NULL,'','','6IYSR,V5C6H,V5C45',NULL,NULL,NULL,'Cornerstone Grade Export','202007259','EMPEXPORT','ONDEMAND','Jul 28 2020 12:00AM','ECRNSTGRDE',NULL,NULL,NULL,'202007259','Jul 25 2020 12:00AM','Dec 30 1899 12:00AM','202007251','1','','','202007251',dbo.fn_GetTimedKey(),NULL,'us3jBeUSO1001',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_ECRNSTGRDE_20200728.txt' END WHERE expFormatCode = 'ECRNSTGRDE';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECRNSTGRDE','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECRNSTGRDE','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECRNSTGRDE','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECRNSTGRDE','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECRNSTGRDE','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'ECRNSTGRDE' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ECRNSTGRDE' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_ECRNSTGRDE_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECRNSTGRDE_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECRNSTGRDE','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECRNSTGRDE','D10','dbo.U_ECRNSTGRDE_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_ECRNSTGRDE') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ECRNSTGRDE] (
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
IF OBJECT_ID('U_ECRNSTGRDE_DedList') IS NULL
CREATE TABLE [dbo].[U_ECRNSTGRDE_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ECRNSTGRDE_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ECRNSTGRDE_drvTbl] (
    [drvEEID] varchar(1) NOT NULL,
    [drvCoID] char(5) NOT NULL,
    [drvDepRecID] varchar(1) NOT NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvOuId] char(6) NULL,
    [drvOuName] char(6) NULL
);
IF OBJECT_ID('U_ECRNSTGRDE_EEList') IS NULL
CREATE TABLE [dbo].[U_ECRNSTGRDE_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ECRNSTGRDE_File') IS NULL
CREATE TABLE [dbo].[U_ECRNSTGRDE_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);
IF OBJECT_ID('U_ECRNSTGRDE_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ECRNSTGRDE_PDedHist] (
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
IF OBJECT_ID('U_ECRNSTGRDE_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ECRNSTGRDE_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECRNSTGRDE]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: US Olympic Committee

Created By: James Bender
Business Analyst: Lea King
Create Date: 07/25/2020
Service Request Number: TekP-2020-06-22-0001

Purpose: Cornerstone Grade Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECRNSTGRDE';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECRNSTGRDE';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECRNSTGRDE';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECRNSTGRDE';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECRNSTGRDE' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECRNSTGRDE', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECRNSTGRDE', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECRNSTGRDE', 'OEACTIVE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ECRNSTGRDE';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ECRNSTGRDE', @AllObjects = 'Y', @IsWeb = 'Y'
**********************************************************************************/
BEGIN

    --==========================================
    -- Declare variables
    --==========================================
   DECLARE  @FormatCode        VARCHAR(10)
            ,@ExportCode        VARCHAR(10)
           /* ,@StartDate         DATETIME
            ,@EndDate           DATETIME
            ,@StartPerControl   VARCHAR(9)
            ,@EndPerControl     VARCHAR(9)*/
            ;

    -- Set FormatCode
    SELECT @FormatCode = 'ECRNSTGRDE';

    -- Declare dates from Parameter file
    SELECT
        /* @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        , */
        @ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    
    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_ECRNSTGRDE_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECRNSTGRDE_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_ECRNSTGRDE_EEList
    WHERE xEEID IN (SELECT DISTINCT EecEEID FROM dbo.EmpComp WITH (NOLOCK) WHERE EecEEType = 'TES');




    --==========================================
    -- Create Deduction List
    --==========================================
/*    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'DED1,DED2';

    IF OBJECT_ID('U_ECRNSTGRDE_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ECRNSTGRDE_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ECRNSTGRDE_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;*/


    --==========================================
    -- BDM Section
    --==========================================
   -- DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

   /* -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','MED,DEN,VIS');
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
    END;*/


    -- Run BDM Module
    --EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ECRNSTGRDE_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ECRNSTGRDE_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECRNSTGRDE_drvTbl;
    SELECT DISTINCT
         drvEEID = '' --xEEID
        ,drvCoID = EjhCOID --xCoID
        ,drvDepRecID = '' --CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        --SELECT EecSupervisorID from EmpComp where EecEEID = 'AVYGTU0640K0'
        ,drvSort = '' --EepAddressLine2
        ,drvOuId = EjhSalaryGrade
        ,drvOuName = EjhSalaryGrade
    INTO dbo.U_ECRNSTGRDE_drvTbl
    FROM dbo.EmpHJob WITH (NOLOCK) -- dbo.U_ECRNSTGRDE_EEList WITH (NOLOCK)
    WHERE EjhCOID IN (SELECT DISTINCT xCOID FROM dbo.U_ECRNSTGRDE_EEList)
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
ALTER VIEW dbo.dsi_vwECRNSTGRDE_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECRNSTGRDE_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ECRNSTGRDE%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202007181'
       ,expStartPerControl     = '202007181'
       ,expLastEndPerControl   = '202007259'
       ,expEndPerControl       = '202007259'
WHERE expFormatCode = 'ECRNSTGRDE';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwECRNSTGRDE_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ECRNSTGRDE_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort