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
@CustomFormatCode - Replace with Format Code (i.e., EXMLSENDNW)
@CustomFormatName - Replace with Name of Interface (AdfFormatName) (i.e., Send Word Now XML Demographic Export)
@IsWebFlag - Replace with 'Y' (Yes) or 'N' (No) for Web Interface Settings

-- Data Parameters
@AccountIdUserName - Replace with the Account ID Username
@AccountIdUserNameTEST - Replace with the Test Account ID Username

-- File parameters
@FileExportPath - Replace with the Export Path where the file generates to (i.e., \\us.saas\e1\Public\[Client ARNum]\Exports\[Vendor]\)
@TestFilePath - Replace with the Test Path where the file generates to (i.e., \\us.saas\e1\Public\[Client ARNum]\Exports\[Vendor]\)
@UDESFilePath - Replace with the UDES Path where the file generates to (i.e., \\us.saas\e0\data_exchange\[Client ARNum]\Exports\)

*/
SET NOCOUNT ON;
IF OBJECT_ID('dsi_vw@CustomFormatCode_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vw@CustomFormatCode_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_@CustomFormatCode') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_@CustomFormatCode];
GO
IF OBJECT_ID('dsi_sp_AfterCollect_@CustomFormatCode') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_AfterCollect_@CustomFormatCode];
GO
IF OBJECT_ID('U_@CustomFormatCode_XML') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_XML];
GO
IF OBJECT_ID('U_@CustomFormatCode_File') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_File];
GO
IF OBJECT_ID('U_@CustomFormatCode_EEList') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_EEList];
GO
IF OBJECT_ID('U_@CustomFormatCode_DrvTbl') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_DrvTbl];
GO
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = '@CustomFormatCode';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = '@CustomFormatCode';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = '@CustomFormatCode';
GO

DECLARE @AdhSystemID VARCHAR(12), @FixedFormatName VARCHAR(50);
SET @AdhSystemID = LEFT('@CustomFormatCode' + REPLICATE('0',10),10) + 'Z0';
SET @FixedFormatName = LEFT('@CustomFormatName',50);

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) SELECT 'N','C','Y','0',NULL,NULL,'N',NULL,'N',NULL,'013010','EMPEXPORT','SDF','@CustomFormatCode',@FixedFormatName,'N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_SwitchBox_v2','500','S','N',@AdhSystemID,'N',NULL,'C','N',NULL,'N';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'FileName is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Send Word Now XML Export','201707019','EMPEXPORT','ONDEMAND','Jul  1 2017  2:54PM','@CustomFormatCode',NULL,NULL,NULL,'201707019','Jul  1 2017 12:00AM','Dec 30 1899 12:00AM','201707011',NULL,'','','201707011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'FileName is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session Only','201707019','EMPEXPORT','SCHEDULED','Jul  1 2017 12:00AM','@CustomFormatCode',NULL,NULL,NULL,'201707019','Jul  1 2017 12:00AM','Dec 30 1899 12:00AM','201707011',NULL,'','','201707011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','ExportPath','V','@FileExportPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','MultFile','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','OverrideCount','V','100');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','TestPath','V','@TestFilePath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','UDESPath','V','@UDESFilePath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','UseFileName','V','N');
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
    [Data] char(500) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_AfterCollect_@CustomFormatCode]
AS
SET NOCOUNT ON;
/**********************************************************************************
Client: @CustomerName

Created By: @DeveloperName
Integration Analyst: @IntegrationAnalystName
Create Date: @CreateDate
Service Request Number: @SRNumber

Custom BCP Statement for XML File

Revision History
----------------
Update By        Date            Request Num        Desc
XXX              XX/XX/20XX      SR-20XX-00000000   XXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.AscExp WHERE ExpFormatCode = '@CustomFormatCode';

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'SCHEDULED';
**********************************************************************************/
BEGIN

    -- Declare variables
    DECLARE @FormatCode     VARCHAR(10)
           ,@sCmd          VARCHAR(1000)
           ,@ExportPath    VARCHAR(500)
           ,@FileName      VARCHAR(100)
           ,@sXML          VARCHAR(100);

    -- Set variables
    SET @FormatCode = '@CustomFormatCode';
    SET @ExportPath = dbo.dsi_fnVariable(@FormatCode,'ExportPath');
    SET @FileName = (SELECT ExportFile FROM dbo.U_dsi_Parameters (NOLOCK) WHERE FormatCode = '@CustomFormatCode');
    SET @sXML = '<?xml version=""1.0""?>';

    --=====================================
    -- Generate XML File via Custom BCP
    --=====================================
    SELECT @sCmd = 'BCP "SELECT ''' + @sXML + ''' + CONVERT(VARCHAR(MAX),XMLOUT) FROM '+ RTRIM(DB_NAME()) + '.dbo.U_@CustomFormatCode_XML WITH (NOLOCK) " QueryOut "' + @ExportPath + @FileName +'"'
					+ ' -S"' + rtrim(@@SERVERNAME) + '" -T -c -t';

    EXEC master.dbo.xp_cmdshell @sCmd, NO_OUTPUT;

END
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_@CustomFormatCode]
    @systemid CHAR(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client: @CustomerName

Created By: @DeveloperName
Integration Analyst: @IntegrationAnalystName
Create Date: @CreateDate
Service Request Number: @SRNumber

Purpose: @CustomFormatName

Revision History
----------------
Update By            Date            Request Num                Desc
XXXX                 XX/XX/XX        SR-20XX-000XXXXX           Added 1234

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.AscExp WHERE ExpFormatCode = '@CustomFormatCode';

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'SCHEDULED';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = '@CustomFormatCode', @AllObjects = 'Y'
**********************************************************************************/
BEGIN

    --==========================================
    -- Declare variables
    --==========================================
    DECLARE  @FormatCode         VARCHAR(12)
            ,@ExportCode         VARCHAR(12)
            ,@StartDate          DATETIME
            ,@EndDate            DATETIME
            ,@StartPerControl    VARCHAR(9)
            ,@EndPerControl      VARCHAR(9)
            ,@FileName           VARCHAR(100)

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

    -- Set @FileName
    SET @FileName = 'writing_request_' + REPLACE(CONVERT(CHAR(10),GETDATE(),101),'/',SPACE(0)) + REPLACE(CONVERT(CHAR(8),GETDATE(),108),':',SPACE(0)) + '.xml'

    --==========================================
    -- Clean EE List
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_@CustomFormatCode_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_@CustomFormatCode_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    -- Remove Terminated Employees
    DELETE FROM dbo.U_@CustomFormatCode_EEList
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCoID = xCOID
        AND EecEmplStatus = 'T';

    --==========================================
    -- Build Employee Data and the driver tables
    --==========================================

    ------------------
    -- DETAIL RECORD
    ------------------
    IF object_id('U_@CustomFormatCode_DrvTbl') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_DrvTbl
    SELECT DISTINCT drvEmpNo = RTRIM(EecEmpNo)
        ,drvNameFirst = RTRIM(EepNameFirst)
        ,drvNameLast = RTRIM(EepNameLast)
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvDepartment = RTRIM(O1.OrgDesc)
        ,drvJobTitle = RTRIM(EecJobtitle)
        ,drvDivision = RTRIM(O2.OrgDesc)
        ,drvWorkPhoneBusinessCountry = CASE WHEN RTRIM(EecPhoneBusinessCountry) = 'USA' THEN '1' END
        ,drvWorkPhoneBusinessNumber = RTRIM(EecPhoneBusinessNumber)
        ,drvWorkPhoneBusinessExt = RTRIM(EecPhoneBusinessExt)
        ,drvCELPhoneCountryPrefix = RTRIM(efoPhoneCountryPrefix)
        ,drvCELPhoneNumber = RTRIM(efoPhoneNumber)
        ,drvCELPhoneExtension = RTRIM(efoPhoneExtension)
        ,drvPhoneHomeCountry = CASE WHEN RTRIM(EepPhoneHomeCountry) = 'USA' THEN '1' END
        ,drvPhoneHomeNumber = RTRIM(EepPhoneHomeNumber)
        ,drvAddressEmail = RTRIM(EepAddressEmail)
        ,drvAddressEmailAlternate = RTRIM(EepAddressEmailAlternate)
        ,drvEEID = RTRIM(xEEID)
        ,drvCOID = RTRIM(xCOID)
    INTO dbo.U_@CustomFormatCode_DrvTbl
    FROM dbo.U_@CustomFormatCode_EELIST WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCoID = xCOID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON eepEEID = xEEID
    LEFT JOIN dbo.OrgLevel O1 WITH (NOLOCK)
        ON O1.OrgCode = EecOrgLvl1
        AND O1.OrgLvl = '1'
    LEFT JOIN dbo.OrgLevel O2 WITH (NOLOCK)
        ON O2.OrgCode = EecOrgLvl2
        AND O2.OrgLvl = '2'
    LEFT JOIN ( --Get Cell Phone Number
        SELECT DISTINCT efoEEID, efoPhoneCountryPrefix, efoPhoneNumber, efoPhoneExtension
            ,RowNo = ROW_NUMBER() OVER (PARTITION BY efoEEID ORDER BY AuditKey DESC, efoPhoneNumber)
        FROM dbo.EmpMPhon WITH (NOLOCK)
        WHERE efoPhoneType = 'CEL'
    ) EmpMPhon
        ON efoEEID = xEEID
        AND RowNo = 1;

     --==========================================
    -- Build XML / Load For Custom BCP
    --==========================================

    -- Create Table for BCP Export
    IF OBJECT_ID('U_@CustomFormatCode_XML') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_XML
    CREATE TABLE dbo.U_@CustomFormatCode_XML (
        XMLOUT XML
    );

    ------------------
    -- Build XML
    ------------------
    DECLARE @XML XML, @XMLOUT VARCHAR(MAX)

    SELECT @XML = (
        /***** Root Node Name: "batchContactList" *****/
        /***** Path Node Name: "contact" *****/
        SELECT
            "@contactID" = drvEmpNo
            ,"@action" = 'AddOrModify'
            ,"contactFieldFirstName/@name" = 'FirstName'
            ,contactFieldFirstName = drvNameFirst
            ,"contactFieldLastName/@name" = 'LastName'
            ,contactFieldLastName = drvNameLast
            ,"contactFieldMiddleName/@name" = 'MiddleName'
            ,contactFieldMiddleName = drvNameMiddle
            ,"contactFieldDept/@name" = 'CustomField'
            ,"contactFieldDept/@customName" = 'Department'
            ,contactFieldDept = drvDepartment
            ,"contactFieldDivision/@name" = 'CustomField'
            ,"contactFieldDivision/@customName" = 'Division'
            ,contactFieldDivision = drvDivision
            ,"contactPointList" = (    /***** Node Name: "contactPoint" *****/
                SELECT
                    "@type" = CASE WHEN Label = 'SMS' THEN 'TextMessage'
                                   WHEN Label LIKE '%Email%' THEN 'Email'
                                   ELSE 'Voice'
                              END
                    ,"contactPointFieldLabel/@name" = 'Label'
                    ,contactPointFieldLabel = Label
                    ,"contactPointFieldCountryCode/@name" = 'CountryCode'
                    ,contactPointFieldCountryCode = CountryCode
                    ,"contactPointFieldNumber/@name" = 'Number'
                    ,contactPointFieldNumber = CASE WHEN Label = 'SMS' THEN Number + '@sms.sendwordnow.com' ELSE Number END
                    ,"contactPointFieldExtension/@name" = 'Extension'
                    ,contactPointFieldExtension = Extension
                    ,"contactPointFieldCascadeOrder/@name" = 'CascadeOrder'
                    ,contactPointFieldCascadeOrder = CascadeOrder
                    ,"contactPointFieldEmail/@name" = 'Address'
                    ,contactPointFieldEmail = EmailAddress
                    ,"contactPointFieldCarrier/@name" = 'Carrier'
                    ,contactPointFieldCarrier = CASE WHEN Label = 'SMS' AND ISNULL(Number,'') <> '' THEN 'SWN Global SMS' END
                FROM (
                    -- Cell Phone Number
                    SELECT DISTINCT drvEEID, drvEmpNo
                        ,Label = 'Cell Phone'
                        ,CountryCode = drvCELPhoneCountryPrefix
                        ,Number = drvCELPhoneNumber
                        ,Extension = drvCELPhoneExtension
                        ,CascadeOrder = '1'
                        ,EmailAddress = ''
                    FROM dbo.U_@CustomFormatCode_DrvTbl
                    WHERE ISNULL(drvCELPhoneNumber,'') <> ''

                    UNION ALL

                    -- Home Phone Number
                    SELECT DISTINCT drvEEID, drvEmpNo
                        ,Label = 'Home Phone'
                        ,CountryCode = drvPhoneHomeCountry
                        ,Number = drvPhoneHomeNumber
                        ,Extension = ''
                        ,CascadeOrder = '2'
                        ,EmailAddress = ''
                    FROM dbo.U_@CustomFormatCode_DrvTbl
                    WHERE ISNULL(drvPhoneHomeNumber,'') <> ''

                    UNION ALL

                    -- Work Phone Number
                    SELECT DISTINCT drvEEID, drvEmpNo
                        ,Label = 'Work Phone'
                        ,CountryCode = drvWorkPhoneBusinessCountry
                        ,Number = drvWorkPhoneBusinessNumber
                        ,Extension = drvWorkPhoneBusinessExt
                        ,CascadeOrder = '3'
                        ,EmailAddress = ''
                    FROM dbo.U_@CustomFormatCode_DrvTbl
                    WHERE ISNULL(drvWorkPhoneBusinessNumber,'') <> ''

                    UNION ALL

                    -- Email Address
                    SELECT DISTINCT drvEEID, drvEmpNo
                        ,Label = 'Work Email'
                        ,CountryCode = ''
                        ,Number = ''
                        ,Extension = ''
                        ,CascadeOrder = ''
                        ,EmailAddress = drvAddressEmail
                    FROM dbo.U_@CustomFormatCode_DrvTbl
                    WHERE ISNULL(drvAddressEmail,'') <> ''

                    UNION ALL

                    -- Alternate Email Address
                    SELECT DISTINCT drvEEID, drvEmpNo
                        ,Label = 'Alternate Email'
                        ,CountryCode = ''
                        ,Number = ''
                        ,Extension = ''
                        ,CascadeOrder = ''
                        ,EmailAddress = drvAddressEmailAlternate
                    FROM dbo.U_@CustomFormatCode_DrvTbl
                    WHERE ISNULL(drvAddressEmailAlternate,'') <> ''

                    UNION ALL

                    -- SMS Text Message
                    SELECT DISTINCT drvEEID, drvEmpNo
                        ,Label = 'SMS'
                        ,CountryCode = ''
                        ,Number = ISNULL(drvCELPhoneCountryPrefix,'') + drvCELPhoneNumber
                        ,Extension = ''
                        ,CascadeOrder = ''
                        ,EmailAddress = ''
                    FROM dbo.U_@CustomFormatCode_DrvTbl
                    WHERE ISNULL(drvCELPhoneNumber,'') <> ''
                ) Contacts
                WHERE Contacts.drvEEID = Employee.drvEEID
                FOR XML PATH('contactPoint'), TYPE
            )
        FROM dbo.U_@CustomFormatCode_DrvTbl Employee
        ORDER BY drvEEID
        FOR XML PATH('contact')
            ,ROOT('batchContactList')
            ,TYPE
    );

    -- Remove EMPTY Nodes
    SET @XML.modify('delete //*[not(node())]')
    SET @XML.modify('delete //*[not(node())]')

    -- Add NameSpaces
    ;WITH XMLNAMESPACES (
        'http://www.sendwordnow.com' AS xs
    )
    SELECT @XMLOUT = (
        SELECT "@version" = '1.0.2'
            ,(    /***** Node Name: "batchProcessingDirectives" *****/
                SELECT "accountID/@username" = CASE WHEN dbo.dsi_fnVariable('@CustomFormatCode','Testing') = 'Y' THEN '@AccountIdUserNameTEST' ELSE '@AccountIdUserName' END
                    ,"batchProcessingOption1/@name" = 'DeleteContactsNotInBatch'
                    ,"batchProcessingOption1/@value" = 'true'
                    ,"batchProcessingOption2/@name" = 'MergeContactsInBatch'
                    ,"batchProcessingOption2/@value" = 'true'
                    ,"batchProcessingOption3/@name" = 'BatchContinueOnContactError'
                    ,"batchProcessingOption3/@value" = 'true'
                    ,"batchProcessingOption4/@name" = 'BatchContinueOnGroupError'
                    ,"batchProcessingOption4/@value" = 'true'
                    ,"batchProcessingOption5/@name" = 'ReturnContactListWithUniqueIDs'
                    ,"batchProcessingOption5/@value" = 'true'
                FOR XML PATH('batchProcessingDirectives'), TYPE
            )
            ,@XML
        FOR XML PATH('contactBatch')
    )

    -- Fix "contactField" values
    SET @XMLOUT = (SELECT REPLACE(@XMLOUT,'contactFieldFirstName','contactField'));
    SET @XMLOUT = (SELECT REPLACE(@XMLOUT,'contactFieldLastName','contactField'));
    SET @XMLOUT = (SELECT REPLACE(@XMLOUT,'contactFieldMiddleName','contactField'));
    SET @XMLOUT = (SELECT REPLACE(@XMLOUT,'contactFieldDept','contactField'));
    SET @XMLOUT = (SELECT REPLACE(@XMLOUT,'contactFieldDivision','contactField'));

    -- Fix "contactPointFieldLabel" values
    SET @XMLOUT = (SELECT REPLACE(@XMLOUT,'contactPointFieldLabel','contactPointField'));
    SET @XMLOUT = (SELECT REPLACE(@XMLOUT,'contactPointFieldCountryCode','contactPointField'));
    SET @XMLOUT = (SELECT REPLACE(@XMLOUT,'contactPointFieldNumber','contactPointField'));
    SET @XMLOUT = (SELECT REPLACE(@XMLOUT,'contactPointFieldExtension','contactPointField'));
    SET @XMLOUT = (SELECT REPLACE(@XMLOUT,'contactPointFieldCascadeOrder','contactPointField'));
    SET @XMLOUT = (SELECT REPLACE(@XMLOUT,'contactPointFieldEmail','contactPointField'));
    SET @XMLOUT = (SELECT REPLACE(@XMLOUT,'contactPointFieldCarrier','contactPointField'));

    -- Fix Header Node: contactBatch
    SET @XMLOUT = (SELECT REPLACE(@XMLOUT,'<contactBatch xmlns:xs="http://www.sendwordnow.com" version="1.0.2">','<contactBatch xmlns="http://www.sendwordnow.com" version="1.0.2">'));

    -- Fix Header Node: batchProcessingDirectives
    SET @XMLOUT = (SELECT REPLACE(@XMLOUT,'<batchProcessingDirectives xmlns:xs="http://www.sendwordnow.com">','<batchProcessingDirectives>'));

    -- Fix "batchProcessingOption" values
    SET @XMLOUT = (SELECT REPLACE(@XMLOUT,'batchProcessingOption1','batchProcessingOption'));
    SET @XMLOUT = (SELECT REPLACE(@XMLOUT,'batchProcessingOption2','batchProcessingOption'));
    SET @XMLOUT = (SELECT REPLACE(@XMLOUT,'batchProcessingOption3','batchProcessingOption'));
    SET @XMLOUT = (SELECT REPLACE(@XMLOUT,'batchProcessingOption4','batchProcessingOption'));
    SET @XMLOUT = (SELECT REPLACE(@XMLOUT,'batchProcessingOption5','batchProcessingOption'));

    -- Load Into Custom Table for BCP Export
    INSERT INTO dbo.U_@CustomFormatCode_XML (XMLOUT)
    VALUES (@XMLOUT)

    --=====================================================
    -- Update Record Count
    --=====================================================
    UPDATE dbo.U_dsi_Configuration
    SET CfgValue = ISNULL((SELECT COUNT(*) FROM dbo.U_@CustomFormatCode_DrvTbl WITH (NOLOCK)),'0')
    WHERE FormatCode = @FormatCode AND CfgName = 'OverrideCount';

    --=====================================================
    -- Set FileName: writing_request_MMDDYYYYHHMMSS.xml
    --=====================================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
	BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = @FileName
        WHERE FormatCode = @FormatCode;
	END;

END
/**********************************************************************************
--Alter the View
ALTER VIEW dbo.dsi_vw@CustomFormatCode_Export AS
	SELECT TOP 200000000 DATA FROM dbo.U_@CustomFormatCode_File WITH (NOLOCK)
	ORDER BY SUBSTRING(RecordSet, 2, 2),InitialSort, SubSort;
GO

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID IN (SELECT AdhSystemID FROM dbo.AscDefH WHERE AdhFormatCode = '@CustomFormatCode')
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET ExpLastStartPerControl = '201812011'
       ,ExpStartPerControl     = '201812011'
       ,ExpLastEndPerControl   = '201812019'
       ,ExpEndPerControl       = '201812019'
WHERE ExpFormatCode = '@CustomFormatCode';
**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vw@CustomFormatCode_Export AS
	SELECT TOP 200000000 DATA FROM dbo.U_@CustomFormatCode_File WITH (NOLOCK)
	ORDER BY SUBSTRING(RecordSet, 2, 2),InitialSort, SubSort;
GO
