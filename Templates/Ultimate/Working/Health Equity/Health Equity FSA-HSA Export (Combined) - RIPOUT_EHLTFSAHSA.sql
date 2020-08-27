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
@CustomFormatCode - Replace with Format Code (i.e., @CustomFormatCode)
@CustomFormatName - Replace with Name of Interface (AdfFormatName) (i.e., Health Equity FSA and HSA Export)
@IsWebFlag - Replace with 'Y' (Yes) or 'N' (No) for Web Interface Settings

-- Export parameters
@DedCodeList - Replace with list of Deduction Codes (i.e., FSAD,FSAH,HSA,HSAER)

-- File parameters
@FileExportPath - Replace with the Export Path where the file generates to (i.e., \\us.saas\e1\Public\[Client ARNum]\Exports\HealthEquity\)
@FileTestPath - Replace with the Test Path where the file generates to (i.e., \\us.saas\e1\Public\[Client ARNum]\Exports\HealthEquity\)
@FileUDESPath - Replace with the UDES Path where the file generates to (i.e., \\us.saas\e0\data_exchange\[Client ARNum]\Exports\)

*/
IF OBJECT_ID('dsi_vw@CustomFormatCode_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vw@CustomFormatCode_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_@CustomFormatCode') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_@CustomFormatCode];
GO
IF OBJECT_ID('dsi_sp_AfterCollect_@CustomFormatCode') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_AfterCollect_@CustomFormatCode];
GO
IF OBJECT_ID('U_@CustomFormatCode_Trailer_FSA') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_Trailer_FSA];
GO
IF OBJECT_ID('U_@CustomFormatCode_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_PDedHist];
GO
IF OBJECT_ID('U_@CustomFormatCode_File') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_File];
GO
IF OBJECT_ID('U_@CustomFormatCode_EEList') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_EEList];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_HSA') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_HSA];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_FSA') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_FSA];
GO
IF OBJECT_ID('U_dsi_BDM_@CustomFormatCode') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_@CustomFormatCode];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = '@CustomFormatCode';
DELETE [dbo].[U_dsi_RecordSetDetails] FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode = '@CustomFormatCode';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = '@CustomFormatCode';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = '@CustomFormatCode';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = '@CustomFormatCode';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = '@CustomFormatCode';
GO

DECLARE @AdhSystemID VARCHAR(12), @FixedFormatName1 VARCHAR(50), @FixedFormatName2 VARCHAR(50);
SET @AdhSystemID = LEFT(@CustomFormatCode + REPLICATE('0',10),10) + 'Z0';
SET @FixedFormatName1 = LEFT('@CustomFormatName',50);
SET @FixedFormatName2 = LEFT('@CustomFormatName',30);

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCreateTClockBatches,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhRespectZeroPayRate,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhThirdPartyPay) SELECT 'N','C','Y','0','',NULL,'','N','','N','','013010','EMPEXPORT','CDE','@CustomFormatCode',@FixedFormatName1,'N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','N','S','N',@AdhSystemID,'N','Jan  1 1900 12:00AM','C','N';
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"D"','1','(''DA''=''T|'')',@AdhSystemID,'50','D','10','1',NULL,'Deduction',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSSN"','2','(''UA''=''T|'')',@AdhSystemID,'50','D','10','2',NULL,'SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','3','(''SS''=''T|'')',@AdhSystemID,'50','D','10','3',NULL,'InsuredExternalObjectId',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDeductionEffectiveDate"','4','(''UD112''=''T|'')',@AdhSystemID,'50','D','10','4',NULL,'DeductionEffectiveDate',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"EE"','5','(''DA''=''T|'')',@AdhSystemID,'50','D','10','5',NULL,'SourceType',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAmount"','6','(''UA''=''T|'')',@AdhSystemID,'50','D','10','6',NULL,'Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMemberFirstName"','7','(''UA''=''T|'')',@AdhSystemID,'50','D','10','7',NULL,'MemberFirstName',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMemberLastName"','8','(''UA''=''T|'')',@AdhSystemID,'50','D','10','8',NULL,'MemberLastName',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAccountType"','9','(''UA''=''T'')',@AdhSystemID,'50','D','10','9',NULL,'AccountType',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMemberSSN"','1','(''UA''=''T|'')',@AdhSystemID,'50','D','20','1',NULL,'MemberSSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDepositDate"','2','(''UD112''=''T|'')',@AdhSystemID,'50','D','20','2',NULL,'DepositDate',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvContributionType"','3','(''UA''=''T|'')',@AdhSystemID,'50','D','20','3',NULL,'ContributionType',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAmount"','4','(''UA''=''T|'')',@AdhSystemID,'50','D','20','4',NULL,'Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMemberFirstName"','5','(''UA''=''T|'')',@AdhSystemID,'50','D','20','5',NULL,'MemberFirstName',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMemberLastName"','6','(''UA''=''T|'')',@AdhSystemID,'50','D','20','6',NULL,'MemberLastName',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','7','(''SS''=''T'')',@AdhSystemID,'50','D','20','7',NULL,'EmployerId',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"T"','1','(''DA''=''T|'')',@AdhSystemID,'50','T','90','1',NULL,'RecordType',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvRecordCount"','2','(''UA''=''T|'')',@AdhSystemID,'50','T','90','2',NULL,'RecordCount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvFileDate"','3','(''UD112''=''T'')',@AdhSystemID,'50','T','90','3',NULL,'FileDate',NULL,NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,@FixedFormatName2,'201702019','EMPEXPORT','ONDEMAND',NULL,'@CustomFormatCode',NULL,NULL,NULL,'201702019','Feb 01 2017  1:48PM','Feb 01 2017  1:48PM','201702011',NULL,'','','201702011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','201702019','EMPEXPORT','SCHEDULED',NULL,'@CustomFormatCode',NULL,NULL,NULL,'201702019','Feb 01 2017  1:48PM','Feb 01 2017  1:48PM','201702011',NULL,'','','201702011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','201702019','EMPEXPORT','OEACTIVE',NULL,'@CustomFormatCode',NULL,NULL,NULL,'201702019','Feb 01 2017  1:48PM','Feb 01 2017  1:48PM','201702011',NULL,'','','201702011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','201702019','EMPEXPORT','OEPASSIVE',NULL,'@CustomFormatCode',NULL,NULL,NULL,'201702019','Feb 01 2017  1:48PM','Feb 01 2017  1:48PM','201702011',NULL,'','','201702011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Test Purposes Only','201702019','EMPEXPORT','TEST',NULL,'@CustomFormatCode',NULL,NULL,NULL,'201702019','Feb 01 2017  1:48PM','Feb 01 2017  1:48PM','201702011',NULL,'','','201702011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','ExportPath','V','@FileExportPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','TestPath','V','@FileTestPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','UDESPath','C','@FileUDESPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','UseFileName','V','N');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D10','dbo.U_@CustomFormatCode_drvTbl_FSA',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D20','dbo.U_@CustomFormatCode_drvTbl_HSA',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','T90','dbo.U_@CustomFormatCode_Trailer_FSA',NULL);
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
CREATE PROCEDURE [dbo].[dsi_sp_AfterCollect_@CustomFormatCode]
AS
/************************************************************
Client: @ClientName

Created By: @DeveloperName
Create Date: @CreateDate

Purpose: GENERATE MULTIPLE FILES WITH CUSTOM BCP STATEMENT

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/20XX     SR-20XX-000XXXXX   XXXXX

SELECT * FROM dbo.U_Dsi_Configuration WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_Dsi_SqlClauses WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_Dsi_Parameters WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.AscExp WHERE ExpFormatCode = '@CustomFormatCode';

dsi_sp_testswitchbox_v2 '@CustomFormatCode', 'ONDEMAND';
dsi_sp_testswitchbox_v2 '@CustomFormatCode', 'TEST';
************************************************************/
BEGIN

    --==========================================
    -- Declare variables
    --==========================================
    DECLARE @FormatCode      VARCHAR(10)
        ,@ExportCode         VARCHAR(10)
        ,@ExportPath         VARCHAR(500)
        ,@dbName             VARCHAR(50)
        ,@NoEmpty            CHAR(1)
        ,@sCmd               VARCHAR(1000)
        ,@QueryInfo          VARCHAR(1000)
        ,@RowCount           INT;

    -- Set variables
    SET @FormatCode = '@CustomFormatCode';

    SELECT @ExportCode = ExportCode
       ,@ExportPath = CASE WHEN @ExportCode LIKE '%TEST%' THEN dbo.dsi_fnVariable(FormatCode,'TestPath')
                           ELSE dbo.dsi_fnVariable(FormatCode,'ExportPath') -- If using Switchbox UTF8 Converter, then use UTF8Path instead of ExportPath
                      END
       ,@dbName     = RTRIM(DB_NAME())
       ,@NoEmpty    = dbo.dsi_fnVariable(FormatCode,'NoEmpty')
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    -- =================================================
    -- Define Filenames By Header & Detail ID in File
    -- =================================================

    DECLARE @FilesOut AS TABLE
    (
        RowID                INT IDENTITY(1,1)
        ,RecordSetGroup      VARCHAR(100)
        ,CustomFileName      VARCHAR(1000)
    );

    INSERT INTO @FilesOut (RecordSetGroup, CustomFileName)
    SELECT RecordSetGroup = 'D10,T90'
        ,CustomFileName = CASE WHEN @ExportCode = 'TEST' THEN 'TEST_' ELSE '' END + 'DED_US_@ClientName.' + CONVERT(VARCHAR(8),GETDATE(),112) + REPLACE(CONVERT(VARCHAR(8),GETDATE(),108),':','') + '.txt'
    UNION ALL
    SELECT RecordSetGroup = 'D20'
        ,CustomFileName = CASE WHEN @ExportCode = 'TEST' THEN 'TEST_' ELSE '' END + 'CONT_US_@ClientName.' + CONVERT(VARCHAR(8),GETDATE(),112) + REPLACE(CONVERT(VARCHAR(8),GETDATE(),108),':','') + '.txt'

    SET @RowCount = (SELECT COUNT(*) FROM @FilesOut);

    -- ==================================================    
    -- Generate Multiple Files via Custom BCP statement:
    -- ==================================================    
    -- Declare variables
    DECLARE  @RecordSetGroup  VARCHAR(100)
        ,@FileName            VARCHAR(100)
        ,@LoopCount           INT;

    SET @LoopCount = 1;

    -- Begin Process of Exporting Multiple Files
    WHILE @LoopCount <= @RowCount
    BEGIN

    -- Set FileName to Export Based On Record Set Group (Header,Detail,Trailer Records)
    SELECT 
         @RecordSetGroup = RecordSetGroup
        ,@FileName = CustomFileName
    FROM @FilesOut
    WHERE RowID = @LoopCount;

    -- Set Query To Be Exported
    SET @QueryInfo = '"SELECT TOP 2000000 Data FROM '+ RTRIM(DB_NAME()) + '.dbo.U_' + @FormatCode + '_File WITH (NOLOCK) '
                        + 'WHERE RECORDSET IN (''' + REPLACE(@RecordSetGroup,',',''',''') + ''') '
                        + 'ORDER BY RIGHT(RECORDSET,2), InitialSort, SubSort"';

    -- Set Custom BCP Statement
    SELECT @sCmd = 'BCP ' + @QueryInfo + ' QUERYOUT "' + @ExportPath + @FileName +'" -S"' + RTRIM(@@SERVERNAME) + '" -T -c';
    PRINT 'Custom BCP For File# ' + CONVERT(VARCHAR(2),@LoopCount) + ': ' + ISNULL(@FileName,'');
    PRINT 'Custom BCP Statement: ' + ISNULL(@sCmd,'');

    -- Get Record Count
    DECLARE @RecordCnt INT, @Query NVARCHAR(1000);
    SET @Query = N'SELECT @RecordCount = COUNT(*) FROM '+ RTRIM(DB_NAME()) + '.dbo.U_' + @FormatCode + '_File WITH (NOLOCK) WHERE RECORDSET IN (''' + REPLACE(@RecordSetGroup,',',''',''') + ''')';
    EXECUTE master.dbo.sp_executesql @Query, N'@RecordCount INT OUTPUT',  @RecordCount = @RecordCnt OUTPUT;

    IF @RecordCnt = 0 AND @NoEmpty = 'Y'
    BEGIN
        PRINT 'There are no records in the file, so no file will be created.'
    END ELSE BEGIN
        -- Output File
        EXEC master.dbo.xp_cmdshell @sCmd, NO_OUTPUT;
    END;

    -- Get Next FileName
    SET @LoopCount = @LoopCount + 1;

    END;

END;
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_@CustomFormatCode]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: @ClientName

Created By: @DeveloperName
Business Analyst: @IntegrationAnalystName
Create Date: @CreateDate
Service Request Number/Case: @SRNumber

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
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'SCHEDULED';

EXEC dbo.dsi_BDM_sp_ErrorCheck '@CustomFormatCode';

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
            ,@EndPerControl     VARCHAR(9)
            ,@RunDate           DATETIME;

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = CAST(LEFT(StartPerControl,8) AS DATETIME)
        ,@EndDate         = DATEADD(SS,-1,DATEADD(DD,1,LEFT(EndPerControl,8)))
        ,@FormatCode      = FormatCode
        ,@ExportCode      = ExportCode
        ,@RunDate         = GETDATE()
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = '@CustomFormatCode';

    --==========================================
    -- Working Table - PDedHist
    --==========================================
    IF OBJECT_ID('U_@CustomFormatCode_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_PDedHist;
    SELECT DISTINCT
         PdhEEID
        ,PdhDedCode
        ,PdhPayDate = MAX(PdhPayDate)
        ,PdhEECurAmt = SUM(PdhEECurAmt)
    INTO dbo.U_@CustomFormatCode_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhDedCode IN ('@DedCodeList')
    GROUP BY PdhEEID, PdhDedCode
    HAVING (SUM(PdhEECurAmt) <> 0.00);

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_@CustomFormatCode_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCoID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_@CustomFormatCode_EEList GROUP BY xEEID HAVING COUNT(1) > 1)
    AND NOT EXISTS (SELECT 1 FROM dbo.U_@CustomFormatCode_PDedHist WHERE PdhEEID = xEEID);

    -- Remove Employees without Payroll Amounts for FSA/HSA
    DELETE FROM dbo.U_@CustomFormatCode_EEList
    WHERE NOT EXISTS (SELECT 1 FROM dbo.U_@CustomFormatCode_PDedHist WHERE PdhEEID = xEEID);

    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','@DedCodeList');
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
    END;

    -- Run BDM Module
    EXEC dbo.dsi_bdm_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Employee Data and the driver tables
    --==========================================

    ---------------------------------
    -- DETAIL RECORD - U_@CustomFormatCode_drvTbl_FSA
    ---------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_FSA','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_FSA;
    SELECT DISTINCT
        drvSSN = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvDeductionEffectiveDate = BdmBenStartDate
        ,drvAmount = PdhEECurAmt
        ,drvMemberFirstName = EepNameFirst
        ,drvMemberLastName = EepNameLast
        ,drvAccountType = CASE PdhDedCode 
                                WHEN '<ENTER FSA DEPENDENT CARE DEDCODE>' THEN 'DCRA'
                                WHEN '<ENTER FSA HEALTH CARE DEDCODE>' THEN 'HCRA'
                          END
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
    INTO dbo.U_@CustomFormatCode_drvTbl_FSA
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_@CustomFormatCode_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
    JOIN dbo.U_dsi_BDM_@CustomFormatCode WITH (NOLOCK)
        ON BdmEEID = xEEID
        AND BdmCOID = xCOID
        AND BdmDedCode = PdhDedCode
    WHERE PdhDedCode IN ('<ENTER FSA DEDUCTION CODES>');

    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_Trailer_FSA','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_Trailer_FSA;
    SELECT DISTINCT
        drvRecordCount = COUNT(*) + 1
        ,drvFileDate = @RunDate
    INTO dbo.U_@CustomFormatCode_Trailer_FSA
    FROM dbo.U_@CustomFormatCode_drvTbl_FSA;

    ---------------------------------
    -- DETAIL RECORD - U_@CustomFormatCode_drvTbl_HSA
    ---------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_HSA','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_HSA;
    SELECT DISTINCT
        drvMemberSSN = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvDepositDate = PdhPayDate
        ,drvContributionType = CASE PdhDedCode
                                    WHEN '<ER DEDCODE>' THEN 'ER'
                                    ELSE 'EE'
                               END
        ,drvAmount = PdhEECurAmt
        ,drvMemberFirstName = EepNameFirst
        ,drvMemberLastName = EepNameLast
        ,drvEEID = xEEID
        ,drvInitialSort = RTRIM(EepSSN)
    INTO dbo.U_@CustomFormatCode_drvTbl_HSA
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_@CustomFormatCode_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
    WHERE PdhDedCode IN ('<ENTER HSA DEDUCTION CODES>');

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable('@CustomFormatCode','UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
        SET ExportFile = 'AFTERCOLLECT.txt'
        WHERE FormatCode = '@CustomFormatCode';
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
    SET ExpLastStartPerControl = '201702011'
       ,ExpStartPerControl     = '201702011'
       ,ExpLastEndPerControl   = '201702019'
       ,ExpEndPerControl       = '201702019'
WHERE ExpFormatCode = '@CustomFormatCode';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vw@CustomFormatCode_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_@CustomFormatCode_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort
GO