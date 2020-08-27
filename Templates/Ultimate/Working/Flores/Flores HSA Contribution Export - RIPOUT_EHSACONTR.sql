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
@CustomFormatCode - Replace with Format Code (i.e., EHSACONTR)
@CustomFormatName - Replace with Name of Interface (AdfFormatName) (i.e., Flores HSA Contribution Export)
@IsWebFlag - Replace with 'Y' (Yes) or 'N' (No) for Web Interface Settings

-- Export parameters
@DedCodeList - Replace with list of Deduction Codes (i.e., HSA,HSAF,HSACA,HSACF)
@EarnCodeList - Replace with list of Earning Codes (i.e., HSAER)

-- File parameters
@ClientSpecificFileName - Replace with File Name specific to client (i.e., 10000000HSC.csv)
@FileExportPath - Replace with the Export Path where the file generates to (i.e., \\us.saas\e1\Public\[Client ARNum]\Exports\Flores\)
@FileTestPath - Replace with the Test Path where the file generates to (i.e., \\us.saas\e1\Public\[Client ARNum]\Exports\Flores\)
@FileUDESPath - Replace with the UDES Path where the file generates to (i.e., \\us.saas\e0\data_exchange\[Client ARNum]\Exports\)

*/
IF OBJECT_ID('dsi_vw@CustomFormatCode_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vw@CustomFormatCode_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_@CustomFormatCode') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_@CustomFormatCode];
GO
IF OBJECT_ID('U_@CustomFormatCode_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_PEarHist];
GO
IF OBJECT_ID('U_@CustomFormatCode_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_PDedHist];
GO
IF OBJECT_ID('U_@CustomFormatCode_File') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_File];
GO
IF OBJECT_ID('U_@CustomFormatCode_EEList') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_EEList];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl];
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

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) SELECT 'N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','@CustomFormatCode',@FixedFormatName,'N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N',@AdhSystemID,'N','Jan  1 1900 12:00AM','C','N',NULL,'N';
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Employee ID Number"','1','(''DA''=''T,'')',@AdhSystemID,'50','H','01','1',NULL,'Employee ID Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Last Name"','2','(''DA''=''T,'')',@AdhSystemID,'50','H','01','2',NULL,'Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"First Name"','3','(''DA''=''T,'')',@AdhSystemID,'50','H','01','3',NULL,'First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Contribution Date"','4','(''DA''=''T,'')',@AdhSystemID,'50','H','01','4',NULL,'Contribution Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Employer Standard Contribution"','5','(''DA''=''T,'')',@AdhSystemID,'50','H','01','5',NULL,'Employer Standard Contribution',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Employer Special Contribution"','6','(''DA''=''T,'')',@AdhSystemID,'50','H','01','6',NULL,'Employer Special Contribution',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Employee Standard Contribution"','7','(''DA''=''T,'')',@AdhSystemID,'50','H','01','7',NULL,'Employee Standard Contribution',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Employee Special Contribution"','8','(''DA''=''T,'')',@AdhSystemID,'50','H','01','8',NULL,'Employee Special Contribution',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"E-Mail Address"','9','(''DA''=''T,'')',@AdhSystemID,'50','H','01','9',NULL,'E-Mail Address',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Location"','10','(''DA''=''T'')',@AdhSystemID,'50','H','01','10',NULL,'Location',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSSN"','1','(''UA''=''T,'')',@AdhSystemID,'50','D','10','1',NULL,'Employee ID Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvNameLast"','2','(''UA''=''T,'')',@AdhSystemID,'50','D','10','2',NULL,'Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvNameFirst"','3','(''DA''=''T'')',@AdhSystemID,'50','D','10','3',NULL,'First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPayDate"','4','(''UD120''=''T,'')',@AdhSystemID,'50','D','10','4',NULL,'Contribution Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvERStandardContrib"','5','(''UNT2''=''T,'')',@AdhSystemID,'50','D','10','5',NULL,'Employer Standard Contribution',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvERSpecialContrib"','6','(''UNT2''=''T,'')',@AdhSystemID,'50','D','10','6',NULL,'Employer Special Contribution',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEEStandardContrib"','7','(''UNT2''=''T,'')',@AdhSystemID,'50','D','10','7',NULL,'Employee Standard Contribution',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','8','(''SS''=''T,'')',@AdhSystemID,'50','D','10','8',NULL,'Employee Special Contribution',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmail"','9','(''UA''=''T,'')',@AdhSystemID,'50','D','10','9',NULL,'E-Mail Address',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLocation"','10','(''UA''=''T'')',@AdhSystemID,'50','D','10','10',NULL,'Location',NULL,NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Flores HSA Contribution Export','201802019','EMPEXPORT','ONDEMAND',NULL,'@CustomFormatCode',NULL,NULL,NULL,'201802019','Feb  1 2018  9:31AM','Feb  1 2018  9:31AM','201802011',NULL,'','','201802011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','201802019','EMPEXPORT','SCHEDULED',NULL,'@CustomFormatCode',NULL,NULL,NULL,'201802019','Feb  1 2018  9:31AM','Feb  1 2018  9:31AM','201802011',NULL,'','','201802011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Test Purposes Only','201802019','EMPEXPORT','TEST','Feb  1 2018  2:30PM','@CustomFormatCode',NULL,NULL,NULL,'201802019','Feb  1 2018 12:00AM','Dec 30 1899 12:00AM','201802011',NULL,'','','201802011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','ExportPath','V','@FileExportPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','InitialSort','C','LEFT(drvNameLast,20)');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','SubSort','C','LEFT(drvNameFirst,20)');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','TestPath','V','@FileTestPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','UDESPath','C','@FileUDESPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','UseFileName','V','N');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D10','dbo.U_@CustomFormatCode_drvTbl',NULL);
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
    [Data] varchar(1000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_@CustomFormatCode]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: @CustomerName

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
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'SCHEDULED';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = '@CustomFormatCode', @AllObjects = 'Y'
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
    SELECT @FormatCode = '@CustomFormatCode';

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
    DELETE FROM dbo.U_@CustomFormatCode_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_@CustomFormatCode_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Build Working Tables
    --==========================================
    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_@CustomFormatCode_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_PDedHist;
    SELECT DISTINCT
         PdhEEID
        ,PdhPayDate = MAX(PdhPayDate)
        ,PdhEECurAmt = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
    INTO dbo.U_@CustomFormatCode_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    WHERE PdhPerControl BETWEEN @StartPerControl AND @EndPerControl
	AND PdhDedCode IN ('@DedCodeList')
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00);

    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_@CustomFormatCode_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PehPayDate = MAX(PehPayDate)
        ,PehCurAmt = SUM(CASE WHEN PehPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PehCurAmt ELSE 0.00 END)
    INTO dbo.U_@CustomFormatCode_PEarHist
    FROM dbo.PEarHist WITH (NOLOCK)
    WHERE PehPerControl BETWEEN @StartPerControl AND @EndPerControl
	AND PehEarnCode IN ('@EarnCodeList')
    GROUP BY PehEEID
    HAVING (SUM(PehCurAmt) <> 0.00);

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_@CustomFormatCode_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvNameLast = EepNameLast
        ,drvNameFirst = EepNameFirst
        ,drvPayDate = COALESCE(PdhPayDate, PehPayDate)
        ,drvERStandardContrib = COALESCE(PehCurAmt,0.00)
        ,drvERSpecialContrib = COALESCE(PehCurAmt,0.00)
        ,drvEEStandardContrib = COALESCE(PdhEECurAmt,0.00)
        ,drvEmail = EepAddressEMailAlternate
        ,drvLocation = CmpCompanyCode
    INTO dbo.U_@CustomFormatCode_drvTbl
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.Company WITH (NOLOCK)
        ON CmpCoID = xCoID
    LEFT JOIN dbo.U_@CustomFormatCode_PDedHist
        ON PdhEEID = xEEID
    LEFT JOIN dbo.U_@CustomFormatCode_PEarHist
        ON peheeid = xEEID
    WHERE PdhEEID IS NOT NULL OR PehEEID IS NOT NULL;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'TEST_@ClientSpecificFileName'
                                  WHEN @ExportCode LIKE '%TEST%' THEN 'TEST_@ClientSpecificFileName'
                                  ELSE '@ClientSpecificFileName'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vw@CustomFormatCode_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_@CustomFormatCode_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE '@CustomFormatCode%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201802011'
       ,expStartPerControl     = '201802011'
       ,expLastEndPerControl   = '201802019'
       ,expEndPerControl       = '201802019'
WHERE expFormatCode = '@CustomFormatCode';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vw@CustomFormatCode_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_@CustomFormatCode_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort
GO