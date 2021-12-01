/**********************************************************************************

EOPTHSAEX2: Origami Export V2

Date/time:     2021-12-01 10:22:18.320
Client ID:     REF1001
FormatCode:    EOPTHSAEX2
Project:       Origami Export V2
Export Type:   Back Office
Status:        Production
Environment:   E43
Server:        E4SUP3DB01
Database:      ULTIPRO_RBUS
ExportPath:    \\us.saas\E0\data_exchange\REF1001\Exports\
TestPath:      \\us.saas\e4\Public\REF1001\Exports\Origami\

Git Filename and Command
-------------------
C:\GDIToolsGIT\EOPTHSAEX2_Deploy.sql
./AddToGit.sh -s SR-2021-00305720 -a REF1001 -f EOPTHSAEX2

**********************************************************************************/

SET NOCOUNT ON;

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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EOPTHSAEX2'


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
WHERE FormatCode = 'EOPTHSAEX2'
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
WHERE ExpFormatCode = 'EOPTHSAEX2'


-----------
-- Drop current objects and delete configuration data
-----------

IF OBJECT_ID('dsi_vwEOPTHSAEX2_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEOPTHSAEX2_Export];
GO
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EOPTHSAEX2';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EOPTHSAEX2';
IF OBJECT_ID('dsi_sp_BuildDriverTables_EOPTHSAEX2') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EOPTHSAEX2];
GO
IF OBJECT_ID('U_EOPTHSAEX2_File') IS NOT NULL DROP TABLE [dbo].[U_EOPTHSAEX2_File];
GO
IF OBJECT_ID('U_EOPTHSAEX2_EEList') IS NOT NULL DROP TABLE [dbo].[U_EOPTHSAEX2_EEList];
GO
IF OBJECT_ID('U_EOPTHSAEX2_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EOPTHSAEX2_drvTbl];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EOPTHSAEX2';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EOPTHSAEX2';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EOPTHSAEX2';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\ez2sup4db01\ultiprodata\CDONO\Exports\_EOPTHSAEX2_20210520.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Origami Export','202105199','EMPEXPORT','ONDEMAND',NULL,'EOPTHSAEX2',NULL,NULL,NULL,'202105199','May 19 2021  6:38AM','May 19 2021  6:38AM','202105191',NULL,'','','202105191',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\ez2sup4db01\ultiprodata\CDONO\Exports\_EOPTHSAEX2_20210520.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','202111309','EMPEXPORT','SCHEDULED','Nov 30 2021 11:00PM','EOPTHSAEX2',NULL,NULL,NULL,'202111309','May 19 2021  6:38AM','May 19 2021  6:38AM','202111301',NULL,'','','202111301',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\ez2sup4db01\ultiprodata\CDONO\Exports\_EOPTHSAEX2_20210719.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Test Purposes Only','202107199','EMPEXPORT','TEST','Jul 19 2021  9:17AM','EOPTHSAEX2',NULL,NULL,NULL,'202107199','Jul 19 2021 12:00AM','Dec 30 1899 12:00AM','202107191','4327','','','202107191',dbo.fn_GetTimedKey(),NULL,'ULTI_RBUS',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EOPTHSAEX2','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EOPTHSAEX2','ExportPath','V','\\us.saas\E0\data_exchange\REF1001\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EOPTHSAEX2','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EOPTHSAEX2','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EOPTHSAEX2','TestPath','V','\\us.saas\e4\Public\REF1001\Exports\Origami\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EOPTHSAEX2','UDESPath','C','\\us.saas\E0\data_exchange\REF1001\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EOPTHSAEX2','UseFileName','V','N');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EOPTHSAEX2','D10','dbo.U_EOPTHSAEX2_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EOPTHSAEX2_drvTbl
-----------

IF OBJECT_ID('U_EOPTHSAEX2_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EOPTHSAEX2_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvEmployeeNumber] char(9) NULL,
    [drvSocialSecurity] char(11) NULL,
    [drvLastName] varchar(100) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleName] varchar(50) NULL,
    [drvAddress1] varchar(255) NULL,
    [drvAddress2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvPostalCode] varchar(50) NULL,
    [drvHomePhone] varchar(50) NULL,
    [drvWorkPhone] varchar(50) NULL,
    [drvCellPhone] varchar(50) NULL,
    [drvEmail1] varchar(50) NULL,
    [drvBirthDate] datetime NULL,
    [drvMaritalStatus] varchar(1) NULL,
    [drvGender] char(1) NULL,
    [drvHireDate] datetime NULL,
    [drvEmploymentStatus] char(1) NULL,
    [drvAverageWeeklyWage] money NULL,
    [drvSalary] money NULL,
    [drvLocation] char(6) NULL,
    [drvDepartment] varchar(36) NOT NULL,
    [drvSupervisorID] varchar(256) NULL,
    [drvSupervisorName] varchar(256) NULL
);

-----------
-- Create table U_EOPTHSAEX2_EEList
-----------

IF OBJECT_ID('U_EOPTHSAEX2_EEList') IS NULL
CREATE TABLE [dbo].[U_EOPTHSAEX2_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EOPTHSAEX2_File
-----------

IF OBJECT_ID('U_EOPTHSAEX2_File') IS NULL
CREATE TABLE [dbo].[U_EOPTHSAEX2_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EOPTHSAEX2]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Refresco Beverages US Inc.

Created By: Mykola Pekarskyi
Business Analyst: Josh Smith
Create Date: 05/19/2021
Service Request Number: SR-2021-00305720

Purpose: Origami Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EOPTHSAEX2';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EOPTHSAEX2';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EOPTHSAEX2';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EOPTHSAEX2';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EOPTHSAEX2' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EOPTHSAEX2', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EOPTHSAEX2', 'TEST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EOPTHSAEX2', 'SCHEDULED';

EXEC dbo._dsi_usp_ExportRipOut_v7 @FormatCode = 'EOPTHSAEX2', @AllObjects = 'Y', @IsWeb = 'N'
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
    SELECT @FormatCode = 'EOPTHSAEX2';

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
    DELETE FROM dbo.U_EOPTHSAEX2_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EOPTHSAEX2_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EOPTHSAEX2_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EOPTHSAEX2_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EOPTHSAEX2_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvEmployeeNumber = EecEmpno
        ,drvSocialSecurity = EepSSN
        ,drvLastName = EepNameLast
        ,drvFirstName = EepNameFirst
        ,drvMiddleName = EepNameMiddle
        ,drvAddress1 = EepAddressLine1
        ,drvAddress2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvPostalCode = EepAddressZipCode
        ,drvHomePhone = EepPhoneHomeNumber
        ,drvWorkPhone = EecPhoneBusinessNumber
        ,drvCellPhone = efoPhoneNumber
        ,drvEmail1 = EepAddressEMailAlternate
        ,drvBirthDate = EepDateOfBirth
        ,drvMaritalStatus = IIF(eepMaritalStatus = 'Z','',eepMaritalStatus)
        ,drvGender = EepGender
        ,drvHireDate = EecDateOfLastHire
        ,drvEmploymentStatus = EecEmplStatus
        ,drvAverageWeeklyWage = EecWeeklyPayRate
        ,drvSalary = EecAnnSalary
        ,drvLocation = EecLocation
        ,drvDepartment = CONCAT(EecOrgLvl1,'-',OrgDesc)
        ,drvSupervisorID = dbo.dsi_fnlib_GetSupervisorField('', xEEID, 'EmpNo')
        ,drvSupervisorName = dbo.dsi_fnlib_GetSupervisorField('', xEEID, 'NameFirst Last')
    INTO dbo.U_EOPTHSAEX2_drvTbl
    FROM dbo.U_EOPTHSAEX2_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN dbo.EmpMPhon WITH (NOLOCK)
        ON efoEEID = xEEID
        AND efoPhoneType = 'CEL'
    LEFT JOIN dbo.vw_int_OrgLevel WITH (NOLOCK)
        ON OrgCode = EecOrgLvl1
        AND OrgLvl = '1'
    WHERE EecEmplStatus IN ('A','L') 

    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_Origami_Refresco_Employees_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE '%TEST%' THEN 'Test_Origami_Refresco_Employees_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'Origami_Refresco_Employees_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'Origami_Refresco_Employees_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEOPTHSAEX2_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EOPTHSAEX2_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EOPTHSAEX2%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202105121'
       ,expStartPerControl     = '202105121'
       ,expLastEndPerControl   = '202105199'
       ,expEndPerControl       = '202105199'
WHERE expFormatCode = 'EOPTHSAEX2';

**********************************************************************************/
GO
CREATE   VIEW dbo.AscDefH
AS
SELECT CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdhAccrCodesUsed
           ELSE s.AdhAccrCodesUsed
       END AS AdhAccrCodesUsed,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdhAggregateAtLevel
           ELSE s.AdhAggregateAtLevel
       END AS AdhAggregateAtLevel,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdhAuditStaticFields
           ELSE s.AdhAuditStaticFields
       END AS AdhAuditStaticFields,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdhChildTable
           ELSE s.AdhChildTable
       END AS AdhChildTable,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdhClientTableList
           ELSE s.AdhClientTableList
       END AS AdhClientTableList,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdhCustomDLLFileName
           ELSE s.AdhCustomDLLFileName
       END AS AdhCustomDLLFileName,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdhDedCodesUsed
           ELSE s.AdhDedCodesUsed
       END AS AdhDedCodesUsed,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdhDelimiter
           ELSE s.AdhDelimiter
       END AS AdhDelimiter,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdhEarnCodesUsed
           ELSE s.AdhEarnCodesUsed
       END AS AdhEarnCodesUsed,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdhEEIdentifier
           ELSE s.AdhEEIdentifier
       END AS AdhEEIdentifier,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdhEndOfRecord
           ELSE s.AdhEndOfRecord
       END AS AdhEndOfRecord,
       ISNULL(i.AdhEngine, s.AdhEngine) AS AdhEngine,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdhFileFormat
           ELSE s.AdhFileFormat
       END AS AdhFileFormat,
       ISNULL(i.AdhFormatCode, s.AdhFormatCode) AS AdhFormatCode,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdhFormatName
           ELSE s.AdhFormatName
       END AS AdhFormatName,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdhFundCodesUsed
           ELSE s.AdhFundCodesUsed
       END AS AdhFundCodesUsed,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdhImportExport
           ELSE s.AdhImportExport
       END AS AdhImportExport,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdhInputFormName
           ELSE s.AdhInputFormName
       END AS AdhInputFormName,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdhIsAuditFormat
           ELSE s.AdhIsAuditFormat
       END AS AdhIsAuditFormat,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdhIsSQLExport
           ELSE s.AdhIsSQLExport
       END AS AdhIsSQLExport,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdhModifyStamp
           ELSE s.AdhModifyStamp
       END AS AdhModifyStamp,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdhOutputMediaType
           ELSE s.AdhOutputMediaType
       END AS AdhOutputMediaType,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdhRecordSize
           ELSE s.AdhRecordSize
       END AS AdhRecordSize,
       CASE WHEN i.AuditKey IS NOT NULL THEN i.AdhSortBy ELSE s.AdhSortBy END AS AdhSortBy,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdhSysFormat
           ELSE s.AdhSysFormat
       END AS AdhSysFormat,
       CASE WHEN i.AuditKey IS NOT NULL THEN i.AdhSystemID ELSE s.AdhSystemID END AS AdhSystemID,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdhTaxCodesUsed
           ELSE s.AdhTaxCodesUsed
       END AS AdhTaxCodesUsed,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdhWizardInfo
           ELSE s.AdhWizardInfo
       END AS AdhWizardInfo,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdhYearStartFixedDate
           ELSE s.AdhYearStartFixedDate
       END AS AdhYearStartFixedDate,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdhYearStartOption
           ELSE s.AdhYearStartOption
       END AS AdhYearStartOption,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdhPreProcessSQL
           ELSE s.AdhPreProcessSQL
       END AS AdhPreProcessSQL,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdhRespectZeroPayRate
           ELSE s.AdhRespectZeroPayRate
       END AS AdhRespectZeroPayRate,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdhCreateTClockBatches
           ELSE s.AdhCreateTClockBatches
       END AS AdhCreateTClockBatches,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdhThirdPartyPay
           ELSE s.AdhThirdPartyPay
       END AS AdhThirdPartyPay,
       ISNULL(i.AuditKey, s.AuditKey) AS AuditKey
FROM dbo.iAscDefH i WITH (NOLOCK)
    FULL MERGE JOIN ULTIPRO_SYSTEM.dbo.AscMastH s WITH (NOLOCK) ON i.AdhEngine = s.AdhEngine
                                                                   AND i.AdhFormatCode = s.AdhFormatCode;
GO
CREATE   VIEW dbo.AscDefF
AS
SELECT CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdfFieldNumber
           ELSE s.AdfFieldNumber
       END AS AdfFieldNumber,
       ISNULL(i.AdfHeaderSystemID, s.AdfHeaderSystemID) AS AdfHeaderSystemID,
       CASE WHEN i.AuditKey IS NOT NULL THEN i.AdfLen ELSE s.AdfLen END AS AdfLen,
       ISNULL(i.AdfRecType, s.AdfRecType) AS AdfRecType,
       ISNULL(i.AdfSetNumber, s.AdfSetNumber) AS AdfSetNumber,
       CASE WHEN i.AuditKey IS NOT NULL THEN i.AdfStartPos ELSE s.AdfStartPos END AS AdfStartPos,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdfTableName
           ELSE s.AdfTableName
       END AS AdfTableName,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdfTargetField
           ELSE s.AdfTargetField
       END AS AdfTargetField,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdfVariableName
           ELSE s.AdfVariableName
       END AS AdfVariableName,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdfVariableType
           ELSE s.AdfVariableType
       END AS AdfVariableType,
       CASE
           WHEN i.AuditKey IS NOT NULL THEN i.AdfExpression
           ELSE s.AdfExpression
       END AS AdfExpression,
       CASE WHEN i.AuditKey IS NOT NULL THEN i.AdfForCond ELSE s.AdfForCond END AS AdfForCond,
       ISNULL(i.AuditKey, s.AuditKey) AS AuditKey
FROM dbo.iAscDefF i WITH (NOLOCK)
    FULL MERGE JOIN ULTIPRO_SYSTEM.dbo.AscMastF s WITH (NOLOCK) ON i.AdfHeaderSystemID = s.AdfHeaderSystemID
                                                                   AND i.AdfRecType = s.AdfRecType
                                                                   AND i.AdfSetNumber = s.AdfSetNumber
                                                                   AND i.AdfFieldNumber = s.AdfFieldNumber;
GO
CREATE VIEW dbo.dsi_vwEOPTHSAEX2_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EOPTHSAEX2_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EOPTHSAEX2'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EOPTHSAEX2'
   AND rpoParmType = 'expSystemID'
