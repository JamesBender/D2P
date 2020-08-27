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
@CustomFormatName - Replace with Name of Interface (AdfFormatName) (i.e., TTN Group File)
@IsWebFlag - Replace with 'Y' (Yes) or 'N' (No) for Web Interface Settings

-- File parameters
@FileExportPath - Replace with the Export Path where the Error Report generates to (i.e., \\us.saas\e1\Public\[Client ARNum]\Exports\[Vendor]\)

NOTE: This is a Sample layout. *** YOU WILL NEED TO CONFIRM YOUR LAYOUT AND MODIFY AS NEEDED - EVERY TTN/BRAINIER FILE IS DIFFERENT***
*/
IF OBJECT_ID('dsi_vw@CustomFormatCode_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vw@CustomFormatCode_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_@CustomFormatCode') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_@CustomFormatCode];
GO
IF OBJECT_ID('U_@CustomFormatCode_File') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_File];
GO
IF OBJECT_ID('U_@CustomFormatCode_EEList') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_EEList];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = '@CustomFormatCode';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = '@CustomFormatCode';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = '@CustomFormatCode';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = '@CustomFormatCode';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = '@CustomFormatCode';
GO

DECLARE @AdhSystemID VARCHAR(12), @FixedFormatName VARCHAR(50)
SET @AdhSystemID = LEFT('@CustomFormatCode' + REPLICATE('0',10),10) + 'Z0';
SET @FixedFormatName = LEFT('@CustomFormatName',50);

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCreateTClockBatches,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhRespectZeroPayRate,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhThirdPartyPay) SELECT 'N','C','Y','0','',NULL,'','N','','N','','013010','EMPEXPORT','CDE','@CustomFormatCode',@FixedFormatName,'N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','N','S','N',@AdhSystemID,'N','Jan  1 1900 12:00AM','C','N';
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"groupCode"','1','(''DA''=''Q,'')',@AdhSystemID,'50','H','01','1',NULL,'groupCode',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"groupName"','2','(''DA''=''Q,'')',@AdhSystemID,'50','H','01','2',NULL,'groupName',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"groupStatus"','3','(''DA''=''Q,'')',@AdhSystemID,'50','H','01','3',NULL,'groupStatus',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"groupTypeCode"','4','(''DA''=''Q,'')',@AdhSystemID,'50','H','01','4',NULL,'groupTypeCode',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"parentGroupCode"','5','(''DA''=''Q'')',@AdhSystemID,'50','H','01','5',NULL,'parentGroupCode',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvgroupCode"','1','(''UA''=''Q,'')',@AdhSystemID,'50','D','10','1',NULL,'groupCode',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvgroupName"','2','(''UA''=''Q,'')',@AdhSystemID,'50','D','10','2',NULL,'groupName',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvgroupStatus"','3','(''UA''=''Q,'')',@AdhSystemID,'50','D','10','3',NULL,'groupStatus',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvgrouptypeCode"','4','(''UA''=''Q,'')',@AdhSystemID,'50','D','10','4',NULL,'groupTypeCode',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvparentGroupCode"','5','(''UA''=''Q'')',@AdhSystemID,'50','D','10','5',NULL,'parentGroupCode',NULL,NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'TTN Groups File','201703019','EMPEXPORT','GROUPS','Mar  1 2017 12:00AM','@CustomFormatCode',NULL,NULL,NULL,'201703019','Mar  1 2017 12:00AM','Dec 30 1899 12:00AM','201703011',NULL,'','','201703011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Test TTN Groups File','201703019','EMPEXPORT','TEST','Mar  1 2017 12:00AM','@CustomFormatCode',NULL,NULL,NULL,'201703019','Mar  1 2017 12:00AM','Dec 30 1899 12:00AM','201703011',NULL,'','','201703011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','ExportPath','V','@FileExportPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','UseFileName','V','N');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D10','dbo.U_@CustomFormatCode_drvTbl_Groups',NULL);
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
    [Data] varchar(2000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_@CustomFormatCode]
    @SystemID char(12)
AS
/**********************************************************************************
Client Name: @CustomerName

Created By: @DeveloperName
Business Analyst: @IntegrationAnalystName
Create Date: @CreateDate
Service Request Number: @SRNumber

Purpose: TTN Group file

Revision History
----------------
Update By           Date            Request Num            Desc
XXX                 XX/XX/XXXX      XXX                    XXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.AscExp WHERE expFormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = '@CustomFormatCode' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'GROUPS';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'TEST';

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

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = CAST(LEFT(StartPerControl,8) AS DATETIME)
        ,@EndDate         = DATEADD(SS,-1,DATEADD(DD,1,LEFT(EndPerControl,8)))
        ,@FormatCode      = FormatCode
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = '@CustomFormatCode';

    PRINT 'Start Date: ' + CONVERT(VARCHAR(26),@StartDate,100);
    PRINT 'End Date:  ' + CONVERT(VARCHAR(26),@EndDate,100);

    --==========================================
    -- Audit Section
    --==========================================
    IF OBJECT_ID('U_@CustomFormatCode_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_Audit;
    SELECT
        audKey1 = audKey1Value
        ,audKey2 = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    INTO dbo.U_@CustomFormatCode_Audit
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.vw_AuditData WITH (NOLOCK)
        ON audKey1Value = xEEID
        AND audKey2Value = xCOID
        AND audTableName = 'EmpComp'
        AND audFieldName = 'EecEmplStatus'
    WHERE audDateTime BETWEEN DATEADD(DAY,-30,@EndDate) AND @EndDate
    AND audAction <> 'DELETE'
    AND ISNULL(audNewValue,'') = 'T';

    -----------------------------------------------
    -- Load OrgStatus Changes from OrgLevel Table
    -----------------------------------------------
    INSERT INTO dbo.U_@CustomFormatCode_Audit (audKey1,audKey2,audKey3,audTableName,audFieldName,audAction,audDateTime,audOldValue,audNewValue,audRowNo)
    SELECT
        audKey1 = audKey1Value
        ,audKey2 = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    FROM dbo.vw_AuditData WITH (NOLOCK)
    WHERE audDateTime BETWEEN DATEADD(DAY,-30,@EndDate) AND @EndDate
    AND audTableName = 'OrgLevel'
    AND audFieldName = 'OrgStatus'
    AND audAction <> 'DELETE'
    AND ISNULL(audOldValue,'') = 'A'
    AND ISNULL(audNewValue,'') = 'I';

    ---------------------------------------------------------------------------------------
    -- Retain Most Recent Audit Record by AudKey1, AudKey2, AudKey3 and Audit Field Name
    ---------------------------------------------------------------------------------------
    DELETE FROM dbo.U_@CustomFormatCode_Audit WHERE audRowNo > 1;

    --==========================================
    -- Clean EE List
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_@CustomFormatCode_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCoID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_@CustomFormatCode_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    -- Remove Terminated Employees NOT Found in Audit
    DELETE FROM dbo.U_@CustomFormatCode_EEList
    FROM dbo.U_@CustomFormatCode_EEList
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    WHERE EecEmplStatus = 'T'
    AND NOT EXISTS (SELECT 1 FROM dbo.U_@CustomFormatCode_Audit WHERE audKey1 = xEEID AND audFieldName = 'EecEmplStatus');

    --==========================================
    -- Build Employee Data and the driver tables
    --==========================================

    /*_____________________________________________________________________________________________________________________

        BUILD USER FILE
    ______________________________________________________________________________________________________________________*/

    ---------------------------------
    -- WORKING TABLE - Supervisors
    ---------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_Supervisors','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_Supervisors;

    WITH CTE_Supervisor (EEID, COID, EmpNo, SupervisorID, EmplStatus, JobCode, Name, Supervisor)
    AS ( -- Get All Active Employees with Level 1 and 2 Supervisor Information
        SELECT EecEEID, EecCOID, EecEmpNo, EecSupervisorID, EecEmplStatus, EecJobCode
            ,Name = RTRIM(EepNameLast) + ', '  + RTRIM(COALESCE(NULLIF(EepNamePreferred,''),EepNameFirst))
            ,Supervisor = CASE WHEN EecEEID IN (SELECT EecSupervisorID FROM dbo.EmpComp WITH (NOLOCK) WHERE EecEmplStatus <> 'T') THEN 'Y' ELSE 'N' END
        FROM dbo.EmpComp WITH (NOLOCK)
        JOIN dbo.EmpPers WITH (NOLOCK)
            ON EepEEID = EecEEID
            AND EecCOID = dbo.dsi_BDM_fn_GetCurrentCoID(EecEEID)
        WHERE EecEmplStatus <> 'T'
    )
     SELECT
         EmpEEID = E.EEID
        ,EmpCOID = E.COID
        ,EmpEmpNo = E.EmpNo
        ,EmpName = E.Name
        ,EmpStatus = E.EmplStatus
        ,Supervisor = E.Supervisor
        ,Supervisor1EEID = S1.EEID
        ,Supervisor1EmpNo = S1.EmpNo
        ,Supervisor1Status = S1.EmplStatus
        ,Supervisor1Name = S1.Name
        ,Supervisor2EEID = S2.EEID
        ,Supervisor2EmpNo = S2.EmpNo
        ,Supervisor2Status = S2.EmplStatus
        ,Supervisor2Name = S2.Name
    INTO dbo.U_@CustomFormatCode_Supervisors
    FROM dbo.U_@CustomFormatCode_EEList
    JOIN CTE_Supervisor E
        ON E.EEID = xEEID
        AND E.COID = xCOID
    LEFT JOIN CTE_Supervisor S1
        ON S1.EEID = E.SupervisorID
        AND S1.COID = dbo.dsi_BDM_fn_GetCurrentCoID(S1.EEID)
    LEFT JOIN CTE_Supervisor S2
        ON S2.EEID = S1.SupervisorID
        AND S2.COID = dbo.dsi_BDM_fn_GetCurrentCoID(S2.EEID);

    /*_____________________________________________________________________________________________________________________

        BUILD GROUPS FILE

            1.  Constant - 'Company'
            2.  Department
            3.  Division
            4.  Function
            5.  Constant - 'FUNCTION, DIVISION, DEPARTMENT'
            6.  Constant - 'JOB'
            7.  Job Family
            8.  Job Tile
            9.  Constant - 'LOCATION'
            10. Location
            11. Officer, Director, Mgr, Sup
            12. Constant - 'OFFICER, DIRECTOR, MGR, SUP'

		NOTE: The "GroupCode" must be created before it's a "ParentCode" on a subsequent record
    ______________________________________________________________________________________________________________________*/

    ----------------------------
    -- WORKING TABLE - Groups
    ----------------------------
    IF OBJECT_ID('U_@CustomFormatCode_Groups','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_Groups;
    CREATE TABLE dbo.U_@CustomFormatCode_Groups (
         GroupCode        VARCHAR(100)
        ,GroupName        VARCHAR(100)
        ,GroupStatus      VARCHAR(10)
        ,GroupTypeCode    VARCHAR(100)
        ,ParentGroupCode  VARCHAR(100)
        ,InitialSort      VARCHAR(10)
        ,SubSort          VARCHAR(10)
    );

    ----------------------------------
    -- Group 1 - Company (Constant)
    ----------------------------------
    INSERT INTO dbo.U_@CustomFormatCode_Groups (GroupCode,GroupName,GroupStatus,GroupTypeCode,ParentGroupCode,InitialSort,SubSort)
    VALUES ('[GroupCode]','[GroupName]','Active','Company',NULL,'01','1');

    ----------------------------
    -- Group 2 - Department
    ----------------------------
    INSERT INTO dbo.U_@CustomFormatCode_Groups (GroupCode,GroupName,GroupStatus,GroupTypeCode,ParentGroupCode,InitialSort,SubSort)
    SELECT DISTINCT
         GroupCode = O3.OrgCode
        ,GroupName = RTRIM(O3.OrgCode) + ' - ' + ISNULL(LTRIM(O3.OrgDesc),'')
        ,GroupStatus = CASE O3.OrgStatus
                            WHEN 'I' THEN 'Inactive'
                            ELSE 'Active'
                       END
        ,GroupTypeCode = 'Department'
        ,ParentGroupCode = RTRIM(O2.OrgCode) + ' - ' + ISNULL(LTRIM(O2.OrgReportCategory),'')
        ,InitialSort = '02'
        ,SubSort = dbo.dsi_fnPadZero(DENSE_RANK() OVER (ORDER BY O3.OrgCode),3,0)
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCoID = xCoID
    JOIN dbo.OrgLevel O3 WITH (NOLOCK)
        ON EecOrgLvl3 = O3.OrgCode
        AND O3.OrgLvl = '3'
    JOIN dbo.OrgLevel O2 WITH (NOLOCK)
        ON EecOrgLvl2 = O2.OrgCode
        AND O2.OrgLvl = '2'
    WHERE ((O3.OrgStatus = 'A')
        OR EXISTS(SELECT 1 FROM dbo.U_@CustomFormatCode_Audit WHERE audKey2 = O3.OrgCode AND audKey1 = '3')
    );

    ----------------------------
    -- Group 3 - Division
    ----------------------------
    INSERT INTO dbo.U_@CustomFormatCode_Groups (GroupCode,GroupName,GroupStatus,GroupTypeCode,ParentGroupCode,InitialSort,SubSort)
    SELECT DISTINCT
         GroupCode = RTRIM(O2.OrgCode) + ' - ' + ISNULL(LTRIM(O2.OrgReportCategory),'')
        ,GroupName = O2.OrgDesc
        ,GroupStatus = CASE O2.OrgStatus
                            WHEN 'I' THEN 'Inactive'
                            ELSE 'Active'
                       END
        ,GroupTypeCode = 'Division'
        ,ParentGroupCode = RTRIM(O1.OrgCode) + ' - ' + ISNULL(LTRIM(O1.OrgReportCategory),'')
        ,InitialSort = '03'
        ,SubSort = dbo.dsi_fnPadZero(DENSE_RANK() OVER (ORDER BY O2.OrgCode),3,0)
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCoID = xCoID
    JOIN dbo.OrgLevel O2 WITH (NOLOCK)
        ON EecOrgLvl2 = O2.OrgCode
        AND O2.OrgLvl = '2'
    JOIN dbo.OrgLevel O1 WITH (NOLOCK)
        ON EecOrgLvl1 = O1.OrgCode
        AND O1.OrgLvl = '1'
    WHERE ((O2.OrgStatus = 'A')
        OR EXISTS(SELECT 1 FROM dbo.U_@CustomFormatCode_Audit WHERE audKey2 = O2.OrgCode AND audKey1 = '2')
    );

    ----------------------------
    -- Group 4 - Function
    ----------------------------
    INSERT INTO dbo.U_@CustomFormatCode_Groups (GroupCode,GroupName,GroupStatus,GroupTypeCode,ParentGroupCode,InitialSort,SubSort)
    SELECT DISTINCT
         GroupCode = RTRIM(O1.OrgCode) + ' - ' + ISNULL(LTRIM(O1.OrgReportCategory),'')
        ,GroupName = O1.OrgDesc
        ,GroupStatus = CASE O1.OrgStatus
                            WHEN 'I' THEN 'Inactive'
                            ELSE 'Active'
                       END
        ,GroupTypeCode = 'Function'
        ,ParentGroupCode = 'FUNCTION, DIVISION, DEPARTMENT'
        ,InitialSort = '04'
        ,SubSort = dbo.dsi_fnPadZero(DENSE_RANK() OVER (ORDER BY O1.OrgCode),3,0)
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCoID = xCoID
    JOIN dbo.OrgLevel O1 WITH (NOLOCK)
        ON EecOrgLvl1 = O1.OrgCode
        AND O1.OrgLvl = '1'
    WHERE ((O1.OrgStatus = 'A')
        OR EXISTS(SELECT 1 FROM dbo.U_@CustomFormatCode_Audit WHERE audKey2 = O1.OrgCode AND audKey1 = '1')
    );

    --------------------------------------------------------
    -- Group 5 - FUNCTION, DIVISION, DEPARTMENT (Constant)
    --------------------------------------------------------
    INSERT INTO dbo.U_@CustomFormatCode_Groups (GroupCode,GroupName,GroupStatus,GroupTypeCode,ParentGroupCode,InitialSort,SubSort)
    SELECT DISTINCT
         GroupCode = 'FUNCTION, DIVISION, DEPARTMENT'
        ,GroupName = 'Function, Division, Department'
        ,GroupStatus = 'Active'
        ,GroupTypeCode = 'Function, Division, Department'
        ,ParentGroupCode = CmpCompanyCode
        ,InitialSort = '05'
        ,SubSort = dbo.dsi_fnPadZero(DENSE_RANK() OVER (ORDER BY CmpCompanyCode),3,0)
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.Company WITH (NOLOCK)
        ON CmpCOID = xCOID;

    -----------------------------
    -- Group 6 - JOB (Constant)
    -----------------------------
    INSERT INTO dbo.U_@CustomFormatCode_Groups (GroupCode,GroupName,GroupStatus,GroupTypeCode,ParentGroupCode,InitialSort,SubSort)
    SELECT DISTINCT
         GroupCode = 'JOB'
        ,GroupName = 'JOB'
        ,GroupStatus = 'Active'
        ,GroupTypeCode = 'Job'
        ,ParentGroupCode = CmpCompanyCode
        ,InitialSort = '06'
        ,SubSort = dbo.dsi_fnPadZero(DENSE_RANK() OVER (ORDER BY CmpCompanyCode),3,0)
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.Company WITH (NOLOCK)
        ON CmpCOID = xCoID;

    ---------------------------
    -- Group 7 - Job Family
    ---------------------------
    INSERT INTO dbo.U_@CustomFormatCode_Groups (GroupCode,GroupName,GroupStatus,GroupTypeCode,ParentGroupCode,InitialSort,SubSort)
    SELECT DISTINCT
         GroupCode = RTRIM(JbcJobFamily) + ' - ' + ISNULL(LTRIM(CodDesc),'')
        ,GroupName = CodDesc
        ,GroupStatus = CASE JbcStatus
                            WHEN 'I' THEN 'Inactive'
                            ELSE 'Active'
                       END
        ,GroupTypeCode = 'Job Family'
        ,ParentGroupCode = 'JOB'
        ,InitialSort = '07'
        ,SubSort = dbo.dsi_fnPadZero(DENSE_RANK() OVER (ORDER BY JbcJobFamily),3,0)
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCoID = xCoID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    LEFT JOIN dbo.Codes JOBFAMILY WITH (NOLOCK)
        ON JOBFAMILY.CodCode = JbcJobFamily
        AND JOBFAMILY.CodTable = 'JOBFAMILY';

    ---------------------------
    -- Group 8 - Job Title
    ---------------------------
    INSERT INTO dbo.U_@CustomFormatCode_Groups (GroupCode,GroupName,GroupStatus,GroupTypeCode,ParentGroupCode,InitialSort,SubSort)
    SELECT DISTINCT
         GroupCode = JbcJobCode
        ,GroupName = JbcLongDesc
        ,GroupStatus = CASE JbcStatus
                            WHEN 'I' THEN 'Inactive'
                            ELSE 'Active'
                       END
        ,GroupTypeCode = 'Job Title'
        ,ParentGroupCode = RTRIM(JbcJobFamily) + ' - ' + ISNULL(LTRIM(CodDesc),'')
        ,InitialSort = '08'
        ,SubSort = dbo.dsi_fnPadZero(DENSE_RANK() OVER (ORDER BY JbcJobCode),3,0)
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCoID = xCoID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    LEFT JOIN dbo.Codes JOBFAMILY WITH (NOLOCK)
        ON JOBFAMILY.CodCode = JbcJobFamily
        AND JOBFAMILY.CodTable = 'JOBFAMILY';

    ----------------------------------
    -- Group 9 - Location (Constant)
    ----------------------------------
    INSERT INTO dbo.U_@CustomFormatCode_Groups (GroupCode,GroupName,GroupStatus,GroupTypeCode,ParentGroupCode,InitialSort,SubSort)
    SELECT DISTINCT
         GroupCode = 'LOCATION'
        ,GroupName = 'Location'
        ,GroupStatus = 'Active'
        ,GroupTypeCode = 'Location'
        ,ParentGroupCode = CmpCompanyCode
        ,InitialSort = '09'
        ,SubSort = dbo.dsi_fnPadZero(DENSE_RANK() OVER (ORDER BY CmpCompanyCode),3,0)
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.Company WITH (NOLOCK)
        ON CmpCOID = xCoID;

    ---------------------------
    -- Group 10 - Location
    ---------------------------
    INSERT INTO dbo.U_@CustomFormatCode_Groups (GroupCode,GroupName,GroupStatus,GroupTypeCode,ParentGroupCode,InitialSort,SubSort)
    SELECT DISTINCT
         GroupCode = LocCode
        ,GroupName = LocDesc
        ,GroupStatus = 'Active'
        ,GroupTypeCode = 'Location'
        ,ParentGroupCode = 'LOCATION'
        ,InitialSort = '10'
        ,SubSort = dbo.dsi_fnPadZero(DENSE_RANK() OVER (ORDER BY LocCode),3,0)
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCoID = xCoID
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    JOIN dbo.Company WITH (NOLOCK)
        ON CmpCOID = xCoID;

    --------------------------------------------------------
    -- Group 11 - Officer, Director, Mgr, Sup (Employees)
    --------------------------------------------------------
    INSERT INTO dbo.U_@CustomFormatCode_Groups (GroupCode,GroupName,GroupStatus,GroupTypeCode,ParentGroupCode,InitialSort,SubSort)
    SELECT DISTINCT
         GroupCode = EmpEmpNo
        ,GroupName = EmpName
        ,GroupStatus = 'Active'
        ,GroupTypeCode = 'Officer, Director, Mgr, Sup'
        ,ParentGroupCode = CASE WHEN Supervisor1EmpNo = EmpEmpNo THEN 'OFFICER, DIRECTOR, MGR, SUP'
                                ELSE Supervisor1EmpNo
                           END
        ,InitialSort = '11'
        ,SubSort = dbo.dsi_fnPadZero(DENSE_RANK() OVER (ORDER BY Supervisor1EmpNo),3,0)
    FROM dbo.U_@CustomFormatCode_Supervisors S WITH (NOLOCK)
    WHERE EXISTS (SELECT 1 FROM dbo.U_@CustomFormatCode_Supervisors E WITH (NOLOCK) WHERE E.Supervisor1EmpNo = S.EmpEmpNo);

    ------------------------------------------------------
    -- Group 12 - Officer, Director, Mgr, Sup (Constant)
    ------------------------------------------------------
    INSERT INTO dbo.U_@CustomFormatCode_Groups (GroupCode,GroupName,GroupStatus,GroupTypeCode,ParentGroupCode,InitialSort,SubSort)
    SELECT DISTINCT
         GroupCode = 'OFFICER, DIRECTOR, MGR, SUP'
        ,GroupName = 'Officers, Directors, Managers, Supervisors'
        ,GroupStatus = 'Active'
        ,GroupTypeCode = 'Officer, Director, Mgr, Sup'
        ,ParentGroupCode = CmpCompanyCode
        ,InitialSort = '12'
        ,SubSort = dbo.dsi_fnPadZero(DENSE_RANK() OVER (ORDER BY CmpCompanyCode),3,0)
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.Company WITH (NOLOCK)
        ON CmpCOID = xCoID;

    ---------------------------------
    -- DETAIL RECORD - Groups File
    ---------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_Groups','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_Groups;
    SELECT DISTINCT
        drvgroupCode = GroupCode
        ,drvgroupName = GroupName
        ,drvgroupStatus = GroupStatus
        ,drvgroupTypeCode = GroupTypeCode
        ,drvparentGroupCode = ParentGroupCode
        ,drvInitialSort = InitialSort
        ,drvSubSort = SubSort
    INTO dbo.U_@CustomFormatCode_drvTbl_Groups
    FROM dbo.U_@CustomFormatCode_Groups WITH (NOLOCK);

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable('@CustomFormatCode','UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN ExportCode = 'TEST' THEN '[CoCode]_TTN_GROUPS_TEST_'
                                  ELSE '[CoCode]_TTN_GROUPS_'
                             END
                             + CONVERT(VARCHAR(8),GETDATE(),112) + '.csv'
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
    SET ExpLastStartPerControl = '201703011'
       ,ExpStartPerControl     = '201703011'
       ,ExpLastEndPerControl   = '201703019'
       ,ExpEndPerControl       = '201703019'
WHERE ExpFormatCode = '@CustomFormatCode';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vw@CustomFormatCode_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_@CustomFormatCode_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;
GO