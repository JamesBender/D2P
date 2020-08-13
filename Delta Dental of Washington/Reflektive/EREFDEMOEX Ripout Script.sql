SET NOCOUNT ON;
IF OBJECT_ID('U_EREFDEMOEX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EREFDEMOEX_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EREFDEMOEX_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EREFDEMOEX' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEREFDEMOEX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEREFDEMOEX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EREFDEMOEX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EREFDEMOEX];
GO
IF OBJECT_ID('U_EREFDEMOEX_File') IS NOT NULL DROP TABLE [dbo].[U_EREFDEMOEX_File];
GO
IF OBJECT_ID('U_EREFDEMOEX_EEList') IS NOT NULL DROP TABLE [dbo].[U_EREFDEMOEX_EEList];
GO
IF OBJECT_ID('U_EREFDEMOEX_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EREFDEMOEX_drvTbl];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EREFDEMOEX';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EREFDEMOEX';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EREFDEMOEX';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EREFDEMOEX';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EREFDEMOEX';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EREFDEMOEX','Reflektive Demo Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','EREFDEMOEXZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"external_uuid"','1','(''DA''=''T,'')','EREFDEMOEXZ0','50','H','01','1',NULL,'external_uuid',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"user_login"','2','(''DA''=''T,'')','EREFDEMOEXZ0','50','H','01','2',NULL,'user_login',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"user_name"','3','(''DA''=''T,'')','EREFDEMOEXZ0','50','H','01','3',NULL,'user_name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"preferred_name"','4','(''DA''=''T,'')','EREFDEMOEXZ0','50','H','01','4',NULL,'preferred_name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"manager_login"','5','(''DA''=''T,'')','EREFDEMOEXZ0','50','H','01','5',NULL,'manager_login',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"user_title"','6','(''DA''=''T,'')','EREFDEMOEXZ0','50','H','01','6',NULL,'user_title',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"user_department"','7','(''DA''=''T,'')','EREFDEMOEXZ0','50','H','01','7',NULL,'user_department',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"location"','8','(''DA''=''T,'')','EREFDEMOEXZ0','50','H','01','8',NULL,'location',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"hire_date"','9','(''DA''=''T'')','EREFDEMOEXZ0','50','H','01','9',NULL,'hire_date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvexternal_uuid"','1','(''UA''=''T,'')','EREFDEMOEXZ0','50','D','10','1',NULL,'external_uuid',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvuser_login"','2','(''UA''=''T,'')','EREFDEMOEXZ0','50','D','10','2',NULL,'user_login',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvuser_name"','3','(''UA''=''T,'')','EREFDEMOEXZ0','50','D','10','3',NULL,'user_name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvpreferred_name"','4','(''UA''=''T,'')','EREFDEMOEXZ0','50','D','10','4',NULL,'preferred_name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvmanager_login"','5','(''UA''=''T,'')','EREFDEMOEXZ0','50','D','10','5',NULL,'manager_login',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvuser_title"','6','(''UA''=''T,'')','EREFDEMOEXZ0','50','D','10','6',NULL,'user_title',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvuser_department"','7','(''UA''=''T,'')','EREFDEMOEXZ0','50','D','10','7',NULL,'user_department',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvlocation"','8','(''UA''=''T,'')','EREFDEMOEXZ0','50','D','10','8',NULL,'location',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvhire_date"','9','(''UD101''=''T'')','EREFDEMOEXZ0','50','D','10','9',NULL,'hire_date',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EREFDEMOEX_20191226.txt',NULL,'','',NULL,NULL,NULL,NULL,'Reflektive Demo Export','201912209','EMPEXPORT','ONDEMAND',NULL,'EREFDEMOEX',NULL,NULL,NULL,'201912209','Nov  8 2019  9:22AM','Nov  8 2019  9:22AM','201901011',NULL,'','','201901011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EREFDEMOEX_20191226.txt',NULL,'','',NULL,NULL,NULL,NULL,'Scheduled Session','201912209','EMPEXPORT','SCHEDULED',NULL,'EREFDEMOEX',NULL,NULL,NULL,'201912209','Nov  8 2019  9:22AM','Nov  8 2019  9:22AM','201901011',NULL,'','','201901011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EREFDEMOEX_20191226.txt',NULL,'','','IAGFG',NULL,NULL,NULL,'Test Purposes Only','201912269','EMPEXPORT','TEST','Dec 26 2019  2:07PM','EREFDEMOEX',NULL,NULL,NULL,'201912269','Dec 26 2019 12:00AM','Dec 30 1899 12:00AM','201912121','406','','','201912121',dbo.fn_GetTimedKey(),NULL,'us3lKiWAS1006',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EREFDEMOEX_20191226.txt' END WHERE expFormatCode = 'EREFDEMOEX';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EREFDEMOEX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EREFDEMOEX','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EREFDEMOEX','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EREFDEMOEX','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EREFDEMOEX' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EREFDEMOEX' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EREFDEMOEX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EREFDEMOEX_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EREFDEMOEX','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EREFDEMOEX','D10','dbo.U_EREFDEMOEX_drvTbl',NULL);
IF OBJECT_ID('U_EREFDEMOEX_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EREFDEMOEX_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvexternal_uuid] char(9) NULL,
    [drvuser_login] varchar(50) NULL,
    [drvuser_name] varchar(201) NULL,
    [drvpreferred_name] varchar(201) NULL,
    [drvmanager_login] varchar(50) NULL,
    [drvuser_title] varchar(8000) NULL,
    [drvuser_department] varchar(8000) NULL,
    [drvlocation] varchar(8) NOT NULL,
    [drvhire_date] datetime NULL
);
IF OBJECT_ID('U_EREFDEMOEX_EEList') IS NULL
CREATE TABLE [dbo].[U_EREFDEMOEX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EREFDEMOEX_File') IS NULL
CREATE TABLE [dbo].[U_EREFDEMOEX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EREFDEMOEX]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Delta Dental of Washington 

Created By: Inshan Singh
Business Analyst: Lea King
Create Date: 11/08/2019
Service Request Number: TekP-2019-10-17-0001

Purpose: Reflektive Demo Export 

Revision History
----------------
Update By           Date           Request Num             Desc
Inshan Singh       11/08/2019     TekP-2019-10-17-0001   Inital development

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EREFDEMOEX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EREFDEMOEX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EREFDEMOEX';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EREFDEMOEX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EREFDEMOEX' ORDER BY RunID DESC;

Job Ownership Scripts
---------------------
-- Set job owner to ssis_user for Production jobs
EXEC msdb..usg_set_job_owner @job_name = '', @set_owner_to_self = 0;

-- Set job owner to self, to make changes in SQL Job Scheduler. Remember to re-run the above script to change ownership to ssis_user when complete
EXEC msdb..usg_set_job_owner @job_name = '', @set_owner_to_self = 1;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EREFDEMOEX', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EREFDEMOEX', 'SCHEDULED';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EREFDEMOEX', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EREFDEMOEX';

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
    DELETE FROM dbo.U_EREFDEMOEX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EREFDEMOEX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    
    -- Clean EE list only active 
    DELETE FROM dbo.U_EREFDEMOEX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT eecEEID FROM EMPCOMP WITH (NOLOCK) WHERE eecEmplStatus = 'T');

    DELETE FROM dbo.U_EREFDEMOEX_EEList
    WHERE xEEID IN (SELECT distinct eecEEID FROM EMPCOMP WITH (NOLOCK) WHERE EecCOID = dbo.dsi_BDM_fn_GetCurrentCOID(EecEEID) AND eecEmplStatus = 'T')

    DELETE FROM dbo.U_EREFDEMOEX_EEList where xEEID IN (
        select distinct eeceeid from empcomp where eecEEType NOT IN ('REG')
    )

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EREFDEMOEX_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EREFDEMOEX_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EREFDEMOEX_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvexternal_uuid = EecEmpNo
        ,drvuser_login = eepAddressEMail
        ,drvuser_name = CASE  
                            WHEN EepNamePreferred IS NULL THEN (SELECT CONCAT(EepNameFirst, ' ', EepNameLast))
                            ELSE (SELECT CONCAT(EepNamePreferred, ' ', EepNameLast))
                        END
        ,drvpreferred_name = CASE
                                WHEN  EepNamePreferred IS NULL THEN (SELECT CONCAT(EepNameFirst, ' ', EepNameLast))
                                ELSE (SELECT CONCAT(EepNamePreferred, ' ', EepNameLast))
                             END
        ,drvmanager_login = (SELECT eepAddressEMail FROM EmpPers WITH (NOLOCK) 
                            WHERE eepEEID = (SELECT TOP 1 eecSupervisorId from empcomp WITH (NOLOCK) WHERE eecEEID = xEEID))
        ,drvuser_title =    REPLACE(jbcLongDesc, ',', ' ') /*CASE 
                            WHEN  dbo.fn_AddDoubleQuotes(PosAlternateTitle) IS NULL THEN  dbo.fn_AddDoubleQuotes(jbcDesc)
                            ELSE  dbo.fn_AddDoubleQuotes(PosAlternateTitle)
                         END*/
        ,drvuser_department =  dbo.fn_AddDoubleQuotes(OrgDesc)
        ,drvlocation = CASE  
                            WHEN EecLocation ='COL' THEN 'Colville'
                            WHEN EecLocation IN ('SEA', 'DPA')  THEN 'Seattle'
                            WHEN EecLocation IN ('SPO', 'DUT') THEN  'Spokane'
                            ELSE ''
                        END
        ,drvhire_date = EecDateOfLastHire
    INTO dbo.U_EREFDEMOEX_drvTbl
    FROM dbo.U_EREFDEMOEX_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN OrgLevel WITH (NOLOCK) 
        ON orgCode = eecOrglvl1
    JOIN EmpPers WITH (NOLOCK)
        ON eepEEID = xEEID
    LEFT JOIN dbo.Position WITH (NOLOCK)
        ON PosJobcode = EecPositionCode
    LEFT JOIN dbo.JobCode WITH (NOLOCK)
        ON EecJobCode = jbcJobCode
    WHERE EecEEType NOT IN ('SIM')
        AND eecOrglvl1 <> '999'
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
ALTER VIEW dbo.dsi_vwEREFDEMOEX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EREFDEMOEX_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EREFDEMOEX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201901011'
       ,expStartPerControl     = '201901011'
       ,expLastEndPerControl   = '201912209'
       ,expEndPerControl       = '201912209'
WHERE expFormatCode = 'EREFDEMOEX';

*/
GO
CREATE VIEW dbo.dsi_vwEREFDEMOEX_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EREFDEMOEX_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort