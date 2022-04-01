SET NOCOUNT ON;
IF OBJECT_ID('U_ELIARDCONX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ELIARDCONX_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ELIARDCONX_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ELIARDCONX' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwELIARDCONX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwELIARDCONX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ELIARDCONX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ELIARDCONX];
GO
IF OBJECT_ID('U_ELIARDCONX_File') IS NOT NULL DROP TABLE [dbo].[U_ELIARDCONX_File];
GO
IF OBJECT_ID('U_ELIARDCONX_EEList') IS NOT NULL DROP TABLE [dbo].[U_ELIARDCONX_EEList];
GO
IF OBJECT_ID('U_ELIARDCONX_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ELIARDCONX_drvTbl];
GO
IF OBJECT_ID('U_ELIARDCONX_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ELIARDCONX_AuditFields];
GO
IF OBJECT_ID('U_ELIARDCONX_Audit') IS NOT NULL DROP TABLE [dbo].[U_ELIARDCONX_Audit];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ELIARDCONX';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ELIARDCONX';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ELIARDCONX';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ELIARDCONX';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ELIARDCONX';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ELIARDCONX','Egencia US Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','ELIARDCONXZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUniqueId"','1','(''UA''=''T,'')','ELIARDCONXZ0','50','D','10','1',NULL,'UniqueID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTravelersAddress"','2','(''UA''=''T,'')','ELIARDCONXZ0','50','D','10','2',NULL,'TravelersAddress',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressEmail"','3','(''UA''=''T,'')','ELIARDCONXZ0','50','D','10','3',NULL,'AddressEmail',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeStatus"','4','(''UA''=''T,'')','ELIARDCONXZ0','50','D','10','4',NULL,'EmployeeStatus',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeGender"','5','(''UA''=''T,'')','ELIARDCONXZ0','50','D','10','5',NULL,'EmployeeGender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','6','(''UA''=''T,'')','ELIARDCONXZ0','50','D','10','6',NULL,'NameLast',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','7','(''UA''=''T,'')','ELIARDCONXZ0','50','D','10','7',NULL,'NameMiddle',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','8','(''UA''=''T,'')','ELIARDCONXZ0','50','D','10','8',NULL,'NameFirst',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"General Traveler Group"','9','(''DA''=''T,'')','ELIARDCONXZ0','50','D','10','9',NULL,'TravelerGroup',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Traveler"','10','(''DA''=''T,'')','ELIARDCONXZ0','50','D','10','10',NULL,'Traveler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHighestOrgLvl"','11','(''UA''=''T,'')','ELIARDCONXZ0','50','D','10','11',NULL,'HighestOrgLvl',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustomData1"','12','(''UA''=''T,'')','ELIARDCONXZ0','50','D','10','12',NULL,'CustomData1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustomData2"','13','(''UA''=''T,'')','ELIARDCONXZ0','50','D','10','13',NULL,'CustomData2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSupervisorFullName"','14','(''UA''=''T,'')','ELIARDCONXZ0','50','D','10','14',NULL,'SupervisorFullName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DL-EgenciaNotifications@lairdconnect.com"','15','(''DA''=''T,'')','ELIARDCONXZ0','500','D','10','15',NULL,'Out of Policy NO',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSupervisorEmail"','16','(''UA''=''T,'')','ELIARDCONXZ0','50','D','10','16',NULL,'SupervisorEmail',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeNo"','17','(''UA''=''T'')','ELIARDCONXZ0','50','D','10','17',NULL,'SupervisorEmail',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ELIARDCONX_20200402.txt',NULL,'','','',NULL,NULL,NULL,'Egencia US Export','202003259','EMPEXPORT','ONDEMAND','Mar 25 2020 12:56PM','ELIARDCONX',NULL,NULL,NULL,'202003259','Mar 25 2020  7:18AM','Mar 25 2020  7:18AM','202003251','326','','','202003251',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ELIARDCONX_20200402.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202003259','EMPEXPORT','TEST','Mar 25 2020 12:58PM','ELIARDCONX',NULL,NULL,NULL,'202003259','Mar 25 2020  7:18AM','Mar 25 2020  7:18AM','202003251','326','','','202003251',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ELIARDCONX_20200402.txt',NULL,'','','',NULL,NULL,NULL,'Scheduled Session','202003259','EMPEXPORT','SCHEDULED','Mar 25 2020 12:58PM','ELIARDCONX',NULL,NULL,NULL,'202003259','Mar 25 2020  7:18AM','Mar 25 2020  7:18AM','202003251','326','','','202003251',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_ELIARDCONX_20200402.txt' END WHERE expFormatCode = 'ELIARDCONX';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELIARDCONX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELIARDCONX','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELIARDCONX','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELIARDCONX','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELIARDCONX','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'ELIARDCONX' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ELIARDCONX' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_ELIARDCONX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ELIARDCONX_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ELIARDCONX','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ELIARDCONX','D10','dbo.U_ELIARDCONX_drvTbl',NULL);
IF OBJECT_ID('U_ELIARDCONX_Audit') IS NULL
CREATE TABLE [dbo].[U_ELIARDCONX_Audit] (
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audEEID] varchar(255) NOT NULL,
    [audCOID] varchar(255) NOT NULL,
    [audKey3Value] varchar(255) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] varchar(2000) NULL,
    [audNewValue] varchar(2000) NULL,
    [audRowNo] bigint NULL
);
IF OBJECT_ID('U_ELIARDCONX_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ELIARDCONX_AuditFields] (
    [aTableName] varchar(128) NULL,
    [aFieldName] varchar(128) NULL
);
IF OBJECT_ID('U_ELIARDCONX_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ELIARDCONX_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvUniqueId] varchar(26) NULL,
    [drvTravelersAddress] varchar(50) NULL,
    [drvAddressEmail] varchar(50) NULL,
    [drvEmployeeStatus] varchar(8) NOT NULL,
    [drvEmployeeGender] varchar(3) NOT NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameMiddle] varchar(50) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvHighestOrgLvl] char(6) NULL,
    [drvCustomData1] char(6) NULL,
    [drvCustomData2] char(6) NULL,
    [drvSupervisorFullName] varchar(204) NULL,
    [drvSupervisorEmail] varchar(50) NULL,
    [drvEmployeeNo] char(9) NULL
);
IF OBJECT_ID('U_ELIARDCONX_EEList') IS NULL
CREATE TABLE [dbo].[U_ELIARDCONX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ELIARDCONX_File') IS NULL
CREATE TABLE [dbo].[U_ELIARDCONX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ELIARDCONX]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Laird Connectivity

Created By: James Bender
Business Analyst: Lea King
Create Date: 03/25/2020
Service Request Number: TekP-2020-02-11-0004

Purpose: Egencia US Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ELIARDCONX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ELIARDCONX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ELIARDCONX';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ELIARDCONX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ELIARDCONX' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELIARDCONX', 'ONDEMAND';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ELIARDCONX', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ELIARDCONX';

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
    -- Create audit tables
    --==========================================
    IF OBJECT_ID('U_ELIARDCONX_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ELIARDCONX_AuditFields;
    CREATE TABLE dbo.U_ELIARDCONX_AuditFields (aTableName varchar(128),aFieldName varchar(128));
    -- Insert tables/fields to be audited
    INSERT INTO dbo.U_ELIARDCONX_AuditFields VALUES ('empcomp','EecEmplStatus');   
    -- Create audit table
    IF OBJECT_ID('U_ELIARDCONX_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ELIARDCONX_Audit;
    SELECT
         audTableName = adrTableName
        ,audFieldName = adfFieldName
        ,audEEID = ISNULL(adrKey1,'')
        ,audCOID = ISNULL(adrKey2,'')
        ,audKey3Value = ISNULL(adrKey3,'')
        ,audDateTime  = adrProcessedDateTime
        ,audOldValue  = adfOldData
        ,audNewValue  = adfNewData
        ,audRowNo     = ROW_NUMBER() OVER(PARTITION BY adrKey1, adrKey2, adrKey3, adfFieldName ORDER BY adrRecID DESC)
    INTO dbo.U_ELIARDCONX_Audit
    FROM (SELECT *
          FROM dbo.AuditRecords WITH (NOLOCK)
          WHERE adrTableName IN (SELECT aTableName FROM dbo.U_ELIARDCONX_AuditFields WITH (NOLOCK))) ADR
    JOIN (SELECT *
          FROM dbo.AuditFields WITH (NOLOCK)
          WHERE adfFieldName IN (SELECT aFieldName FROM dbo.U_ELIARDCONX_AuditFields WITH (NOLOCK))) ADF
        ON adrSystemID = adfSystemID
       AND adrKey = adfKey
    WHERE adrType IN (1,2,5,6) -- Insert/Update; remove this to include Deletes and Viewed
      AND adrProcessedDateTime BETWEEN DATEADD(DAY, -30, @StartDate) AND @EndDate
      AND adfNewData = 'T'
      ;
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ELIARDCONX_Audit ON dbo.U_ELIARDCONX_Audit (audEEID, audCOID);







    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_ELIARDCONX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ELIARDCONX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_ELIARDCONX_EEList
    WHERE xEEID IN (SELECT DISTINCT EecEEID FROM dbo.EmpComp WITH (NOLOCK) WHERE EecLocation LIKE 'E%')

    DELETE FROM dbo.U_ELIARDCONX_EEList
    WHERE xEEID IN (SELECT DISTINCT EepEEID FROM dbo.EmpPers WITH (NOLOCK) WHERE ISNULL(EepAddressEmail, '') = '' OR EepAddressEmail = 'noemail@lairdconnect.com')

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ELIARDCONX_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ELIARDCONX_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ELIARDCONX_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvUniqueId = RTRIM(EecEmpNo) + '@lairdconnect.com'
        ,drvTravelersAddress = Employee.EepAddressEmail
        ,drvAddressEmail = Employee.EepAddressEMail
        ,drvEmployeeStatus = CASE WHEN EecEmplStatus = 'T' THEN 'Inactive' ELSE 'Active' END
        ,drvEmployeeGender = CASE WHEN Employee.EepGender = 'M' THEN 'Mr.' ELSE 'Ms.' END
        ,drvNameLast = Employee.EepNameLast
        ,drvNameMiddle = Employee.EepNameMiddle
        ,drvNameFirst = Employee.EepNameFirst
        ,drvHighestOrgLvl = EecOrgLvl4
        ,drvCustomData1 = EecOrgLvl3
        ,drvCustomData2 = EecOrgLvl1
        ,drvSupervisorFullName = ISNULL(Supervisor.EepNameLast, '') + ', ' + ISNULL(Supervisor.EepNameFirst, '') + ' ' + LEFT(ISNULL(Supervisor.EepNameMiddle, ''), 1)
        ,drvSupervisorEmail = Supervisor.EepAddressEmail
        ,drvEmployeeNo = EecEmpNo
    INTO dbo.U_ELIARDCONX_drvTbl
    FROM dbo.U_ELIARDCONX_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers Employee WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    LEFT JOIN dbo.EmpPers Supervisor WITH (NOLOCK)
        ON EecSupervisorId = Supervisor.EepEEID
    WHERE eecemplstatus <> 'T'
            OR (eecemplstatus= 'T' 
            AND eectermreason <>'TRO' 
            AND EXISTS(select 1 from dbo.U_ELIARDCONX_Audit where  audEEID = xEEID AND audCOID = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T'))
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
ALTER VIEW dbo.dsi_vwELIARDCONX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ELIARDCONX_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ELIARDCONX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202003181'
       ,expStartPerControl     = '202003181'
       ,expLastEndPerControl   = '202003259'
       ,expEndPerControl       = '202003259'
WHERE expFormatCode = 'ELIARDCONX';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwELIARDCONX_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ELIARDCONX_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort