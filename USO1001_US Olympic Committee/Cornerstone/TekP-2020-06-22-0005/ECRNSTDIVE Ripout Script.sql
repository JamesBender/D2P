SET NOCOUNT ON;
IF OBJECT_ID('U_ECRNSTDIVE_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECRNSTDIVE_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ECRNSTDIVE_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ECRNSTDIVE' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwECRNSTDIVE_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECRNSTDIVE_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECRNSTDIVE_G10_BKP_2020_PROD') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECRNSTDIVE_G10_BKP_2020_PROD];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECRNSTDIVE') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECRNSTDIVE];
GO
IF OBJECT_ID('U_ECRNSTDIVE_File') IS NOT NULL DROP TABLE [dbo].[U_ECRNSTDIVE_File];
GO
IF OBJECT_ID('U_ECRNSTDIVE_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECRNSTDIVE_EEList];
GO
IF OBJECT_ID('U_ECRNSTDIVE_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ECRNSTDIVE_drvTbl];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ECRNSTDIVE';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ECRNSTDIVE';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ECRNSTDIVE';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ECRNSTDIVE';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ECRNSTDIVE';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ECRNSTDIVE','Cornerstone Division Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','ECRNSTDIVEZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ECRNSTDIVE' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OU ID"','1','(''DA''=''T,'')','ECRNSTDIVEZ0','50','H','01','1',NULL,'OU ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OU Name"','2','(''DA''=''T,'')','ECRNSTDIVEZ0','50','H','01','2',NULL,'OU Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Parent ID"','3','(''DA''=''T,'')','ECRNSTDIVEZ0','50','H','01','3',NULL,'Parent ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Owner Id"','4','(''DA''=''T,'')','ECRNSTDIVEZ0','50','H','01','4',NULL,'Owner ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Description"','5','(''DA''=''T,'')','ECRNSTDIVEZ0','50','H','01','5',NULL,'Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Active"','6','(''DA''=''T,'')','ECRNSTDIVEZ0','50','H','01','6',NULL,'Active',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Allow Reconciliation"','7','(''DA''=''T'')','ECRNSTDIVEZ0','50','H','01','7',NULL,'Allow Reconciliation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOuID"','1','(''UA''=''T,'')','ECRNSTDIVEZ0','50','D','10','1',NULL,'OU ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOuName"','2','(''UA''=''T,'')','ECRNSTDIVEZ0','50','D','10','2',NULL,'OU Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvParentID"','3','(''UA''=''T,'')','ECRNSTDIVEZ0','50','D','10','3',NULL,'Parent ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','4','(''DA''=''T,'')','ECRNSTDIVEZ0','50','D','10','4',NULL,'Owner Id',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','5','(''DA''=''T,'')','ECRNSTDIVEZ0','50','D','10','5',NULL,'Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TRUE"','6','(''DA''=''T,'')','ECRNSTDIVEZ0','50','D','10','6',NULL,'Active',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TRUE"','7','(''DA''=''T'')','ECRNSTDIVEZ0','50','D','10','7',NULL,'Allow Reconciliation',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'ECRNSTDIVE_20201229.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','',NULL,NULL,NULL,NULL,'Cornerstone Division Export','202007309','EMPEXPORT','ONDEMAND',NULL,'ECRNSTDIVE',NULL,NULL,NULL,'202007309','Jul 30 2020  1:26PM','Jul 30 2020  1:26PM','202007301',NULL,'','','202007301',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,'V5C45',NULL,NULL,NULL,'Cornerstone Division-Daily 11p','202007309','EMPEXPORT','SCHEDULED',NULL,'ECRNSTDIVE',NULL,NULL,NULL,'202012289','Jul 30 2020  1:26PM','Jul 30 2020  1:26PM','202012271',NULL,'','','202007301',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202012109','EMPEXPORT','TEST','Dec 10 2020  9:20AM','ECRNSTDIVE',NULL,NULL,NULL,'202012109','Dec 10 2020 12:00AM','Dec 30 1899 12:00AM','202012081','109','','','202012081',dbo.fn_GetTimedKey(),NULL,'us3lKiUSO1001A',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECRNSTDIVE','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECRNSTDIVE','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECRNSTDIVE','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECRNSTDIVE','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECRNSTDIVE','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'ECRNSTDIVE' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'ECRNSTDIVE' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_ECRNSTDIVE_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECRNSTDIVE_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECRNSTDIVE','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECRNSTDIVE','D10','dbo.U_ECRNSTDIVE_drvTbl',NULL);
IF OBJECT_ID('U_ECRNSTDIVE_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ECRNSTDIVE_drvTbl] (
    [drvEEID] varchar(1) NOT NULL,
    [drvCoID] varchar(1) NOT NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvOuID] varchar(10) NULL,
    [drvOuName] varchar(27) NULL,
    [drvParentID] varchar(10) NULL
);
IF OBJECT_ID('U_ECRNSTDIVE_EEList') IS NULL
CREATE TABLE [dbo].[U_ECRNSTDIVE_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ECRNSTDIVE_File') IS NULL
CREATE TABLE [dbo].[U_ECRNSTDIVE_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECRNSTDIVE]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: US Olympic Committee

Created By: James Bender
Business Analyst: Lea King
Create Date: 07/30/2020
Service Request Number: TekP-2020-06-22-0005

Purpose: Cornerstone Division Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECRNSTDIVE';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECRNSTDIVE';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECRNSTDIVE';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECRNSTDIVE';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECRNSTDIVE' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECRNSTDIVE', 'ONDEMAND';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ECRNSTDIVE', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ECRNSTDIVE';

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
    DELETE FROM dbo.U_ECRNSTDIVE_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECRNSTDIVE_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ECRNSTDIVE_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ECRNSTDIVE_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECRNSTDIVE_drvTbl;
    SELECT DISTINCT
         drvEEID = '' --xEEID
        ,drvCoID = '' --xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = SrtOrgLvl
        -- standard fields above and additional driver fields below
        ,drvOuID = EecOrgLvl
        ,drvOuName = '"' + OrgDesc + '"'
        ,drvParentID = EecParentLvl
    INTO dbo.U_ECRNSTDIVE_drvTbl
    FROM ( 
            SELECT DISTINCT EecOrgLvl, EecParentLvl, OrgLvl as SrtOrgLvl
            FROM (
SELECT DISTINCT EecOrgLvl1 AS EecOrgLvl, NULL AS EecParentLvl,  'A' As OrgLvl
                        FROM dbo.vw_int_EmpComp WITH (NOLOCK) 
                        WHERE EecEmplStatus <> 'T'
                            AND  EecOrgLvl1 IS NOT NULL
                            AND REPLACE(EecOrgLvl1, ' ', '') <> ''
                            AND EecOrgLvl2 IN (
                                                SELECT DISTINCT EecOrgLvl2 
                                                FROM dbo.vw_int_EmpComp WITH (NOLOCK) 
                                                WHERE EecEmplStatus <> 'T'
                                                    AND EecOrgLvl2 IS NOT NULL
                                                    AND REPLACE(EecOrgLvl2, ' ', '') <> '')

                    UNION

                        SELECT DISTINCT EecOrgLvl2 AS EecOrgLvl, EecOrgLvl1 AS EecParentLvl, 'B' As OrgLvl
                        FROM dbo.vw_int_EmpComp WITH (NOLOCK) 
                        WHERE EecEmplStatus <> 'T'
                            AND  EecOrgLvl2 IS NOT NULL
                            AND REPLACE(EecOrgLvl2, ' ', '') <> ''
                            AND EecOrgLvl3 IN (
                                                SELECT DISTINCT EecOrgLvl3 
                                                FROM dbo.vw_int_EmpComp WITH (NOLOCK) 
                                                WHERE EecEmplStatus <> 'T'
                                                    AND EecOrgLvl3 IS NOT NULL
                                                    AND REPLACE(EecOrgLvl3, ' ', '') <> '')

                    UNION

                        SELECT DISTINCT EecOrgLvl3 AS EecOrgLvl, EecOrgLvl2 AS EecParentLvl, 'C' As OrgLvl
                        FROM dbo.vw_int_EmpComp WITH (NOLOCK) 
                        WHERE EecEmplStatus <> 'T'
                            AND EecOrgLvl3 IS NOT NULL
                            AND REPLACE(EecOrgLvl3, ' ', '') <> '') AS X 
            ) AS Y
    LEFT JOIN dbo.vw_int_OrgLevel WITH (NOLOCK)
        ON OrgCode = EecOrgLvl
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
ALTER VIEW dbo.dsi_vwECRNSTDIVE_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECRNSTDIVE_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ECRNSTDIVE%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202007231'
       ,expStartPerControl     = '202007231'
       ,expLastEndPerControl   = '202007309'
       ,expEndPerControl       = '202007309'
WHERE expFormatCode = 'ECRNSTDIVE';

**********************************************************************************/
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECRNSTDIVE]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: US Olympic Committee

Created By: James Bender
Business Analyst: Lea King
Create Date: 07/30/2020
Service Request Number: TekP-2020-06-22-0005

Purpose: Cornerstone Division Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECRNSTDIVE';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECRNSTDIVE';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECRNSTDIVE';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECRNSTDIVE';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECRNSTDIVE' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECRNSTDIVE', 'ONDEMAND';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ECRNSTDIVE', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ECRNSTDIVE';

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
    DELETE FROM dbo.U_ECRNSTDIVE_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECRNSTDIVE_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ECRNSTDIVE_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ECRNSTDIVE_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECRNSTDIVE_drvTbl;
    SELECT DISTINCT
         drvEEID = '' --xEEID
        ,drvCoID = '' --xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = SrtOrgLvl
        -- standard fields above and additional driver fields below
        ,drvOuID = EecOrgLvl
        ,drvOuName = '"' + OrgDesc + '"'
        ,drvParentID = EecParentLvl
    INTO dbo.U_ECRNSTDIVE_drvTbl
    FROM ( 
            SELECT DISTINCT EecOrgLvl, EecParentLvl, OrgLvl as SrtOrgLvl
            FROM (
SELECT DISTINCT EecOrgLvl1 AS EecOrgLvl, NULL AS EecParentLvl,  'A' As OrgLvl
                        FROM dbo.EmpComp WITH (NOLOCK) 
                        WHERE EecEmplStatus <> 'T'
                            AND  EecOrgLvl1 IS NOT NULL
                            AND REPLACE(EecOrgLvl1, ' ', '') <> ''
                            AND EecOrgLvl2 IN (
                                                SELECT DISTINCT EecOrgLvl2 
                                                FROM dbo.EmpComp WITH (NOLOCK) 
                                                WHERE EecEmplStatus <> 'T'
                                                    AND EecOrgLvl2 IS NOT NULL
                                                    AND REPLACE(EecOrgLvl2, ' ', '') <> '')

                    UNION

                        SELECT DISTINCT EecOrgLvl2 AS EecOrgLvl, EecOrgLvl1 AS EecParentLvl, 'B' As OrgLvl
                        FROM dbo.EmpComp WITH (NOLOCK) 
                        WHERE EecEmplStatus <> 'T'
                            AND  EecOrgLvl2 IS NOT NULL
                            AND REPLACE(EecOrgLvl2, ' ', '') <> ''
                            AND EecOrgLvl3 IN (
                                                SELECT DISTINCT EecOrgLvl3 
                                                FROM dbo.EmpComp WITH (NOLOCK) 
                                                WHERE EecEmplStatus <> 'T'
                                                    AND EecOrgLvl3 IS NOT NULL
                                                    AND REPLACE(EecOrgLvl3, ' ', '') <> '')

                    UNION

                        SELECT DISTINCT EecOrgLvl3 AS EecOrgLvl, EecOrgLvl2 AS EecParentLvl, 'C' As OrgLvl
                        FROM dbo.EmpComp WITH (NOLOCK) 
                        WHERE EecEmplStatus <> 'T'
                            AND EecOrgLvl3 IS NOT NULL
                            AND REPLACE(EecOrgLvl3, ' ', '') <> '') AS X 
            ) AS Y
    LEFT JOIN dbo.OrgLevel WITH (NOLOCK)
        ON OrgCode = EecOrgLvl
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
ALTER VIEW dbo.dsi_vwECRNSTDIVE_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECRNSTDIVE_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ECRNSTDIVE%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202007231'
       ,expStartPerControl     = '202007231'
       ,expLastEndPerControl   = '202007309'
       ,expEndPerControl       = '202007309'
WHERE expFormatCode = 'ECRNSTDIVE';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwECRNSTDIVE_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ECRNSTDIVE_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort