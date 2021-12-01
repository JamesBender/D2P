--Populate AscDefF for ESUNAMERIC
--For your reference, the adhSystemID is ESUNAMERICZ0
--Loaded AscDefF Successfully

IF OBJECT_ID('dsi_sp_BuildDriverTables_ESUNAMERIC') IS NOT NULL
    DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESUNAMERIC];
GO

CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESUNAMERIC]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: American Excelsior

Created By: Andy Pineda
Business Analyst: Lea King
Create Date: 11/30/2021
Service Request Number: TekP-2021-09-17-0002

Purpose: Sunlife Health Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ESUNAMERIC';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ESUNAMERIC';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ESUNAMERIC';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ESUNAMERIC';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ESUNAMERIC' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESUNAMERIC', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESUNAMERIC', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESUNAMERIC', 'SCH_ESUNAM';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ESUNAMERIC';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ESUNAMERIC', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ESUNAMERIC';

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
    DELETE FROM dbo.U_ESUNAMERIC_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ESUNAMERIC_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_ESUNAMERIC_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ESUNAMERIC_AuditFields;
    CREATE TABLE dbo.U_ESUNAMERIC_AuditFields (aTableName varchar(30),aFieldName varchar(30));
	-- Audit Fields
	INSERT INTO dbo.U_ESUNAMERIC_AuditFields VALUES ('EmpDed', 'EedDedCode');
	INSERT INTO dbo.U_ESUNAMERIC_AuditFields VALUES ('EmpDed', 'EedBenStatus');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ESUNAMERIC_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ESUNAMERIC_Audit;
    SELECT 
        audEEID  = audKey1Value
        ,audKey2 = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
		,audDedCodeChange = CASE WHEN audTableName = 'EmpDed' AND audFieldName = 'EedDedCode' AND ISNULL(audNewValue , '') <> '' THEN 'Y' ELSE 'N' END
		,audStatChange = CASE WHEN audTableName = 'EmpDed' AND audFieldName = 'EedBenStatus' AND ISNULL(audNewValue, '') <> '' THEN 'Y' ELSE 'N' END
    INTO dbo.U_ESUNAMERIC_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_ESUNAMERIC_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ESUNAMERIC_Audit ON dbo.U_ESUNAMERIC_Audit (audEEID,audKey2);

    --================
    -- Changes Only
    --================
    DELETE FROM dbo.U_ESUNAMERIC_EEList
    WHERE NOT EXISTS (SELECT 1 FROM dbo.U_ESUNAMERIC_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'GLIFE,SUNLA,SUNLS,SUNLC';

    IF OBJECT_ID('U_ESUNAMERIC_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ESUNAMERIC_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ESUNAMERIC_DedList
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

    -- Non-Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CalcBenOptionDate','2');
    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ESUNAMERIC_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ESUNAMERIC_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ESUNAMERIC_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvLastName = EepNameLast
        ,drvFirstName = EepNameFirst
        ,drvAdd1 = EepAddressLine1
        ,drvAdd2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZipCode = EepAddressZipCode
        ,drvHomePhone = SUBSTRING(EepPhoneHomeNumber, 1, 3) + '-' + 
                  SUBSTRING(EepPhoneHomeNumber, 4, 3) + '-' + 
                  SUBSTRING(EepPhoneHomeNumber, 7, 4)
        ,drvEmail = EepAddressEMail
        ,drvSSN = SUBSTRING(EepSSN, 1, 3)+'-'+
                    SUBSTRING(EepSSN, 4, 2)+'-'+
                    SUBSTRING(EepSSN, 6, 4) 
        ,drvEmpDOB = EepDateOfBirth
        ,drvBenEligSal = CAST(REPLACE(EecAnnSalary, '.', '') AS VARCHAR)
        ,drvEmpTermDt = ISNULL(CONVERT(VARCHAR, (CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END), 101), '')
        ,drvBenTermDt = ISNULL(CONVERT(VARCHAR, (CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination
                                WHEN EedBenStatus IN ('T', 'C') THEN EedBenStopDate END), 101), '')
        ,drvLastWorked = ISNULL(CONVERT(VARCHAR, (CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END), 101), '')
        ,drvEmpBLAmt = CAST(REPLACE(glife.EedBenAmt, '.', '') AS VARCHAR)
        ,drvEmpBADDAmt = CAST(REPLACE(glife.EedBenAmt, '.', '') AS VARCHAR)
        ,drvEmpVolLifeAmt = CAST(REPLACE(sunla.EedBenAmt, '.', '') AS VARCHAR)
        ,drvEmpVolADDAmt = CAST(REPLACE(sunla.EedBenAmt, '.', '') AS VARCHAR)
        ,drvSpoVolLifeAmt = CAST(REPLACE(sunls.EedBenAmt, '.', '') AS VARCHAR)
        ,drvSpoVolADDAmt = CAST(REPLACE(sunls.EedBenAmt, '.', '') AS VARCHAR)
        ,drvChiVolLifeAmt = CAST(REPLACE(sunlc.EedBenAmt, '.', '') AS VARCHAR)
        ,drvChiVolADDAmt = CAST(REPLACE(sunlc.EedBenAmt, '.', '') AS VARCHAR)
        ,drvStatus = CASE WHEN EecEmplStatus = 'T' AND EecTermReason <> '202' THEN 'Terminated'
                            WHEN EecEmplStatus = 'T' AND EecTermReason = '202' THEN 'Retired' ELSE 'Active' END
        ,drvHrsWorkedPerWk = '40.00'
    INTO dbo.U_ESUNAMERIC_drvTbl
    FROM dbo.U_ESUNAMERIC_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
	JOIN dbo.EmpComp WITH(NOLOCK)
		ON EecEEID = xEEID
		AND EecCOID = xCOID
	JOIN dbo.EmpDed WITH(NOLOCK)
		ON EedEEID = xEEID
		AND EecCOID = xCOID
    JOIN dbo.U_ESUNAMERIC_Audit WITH(NOLOCK)
        ON audEEID = xEEID
        AND audKey2 = xCOID
    LEFT JOIN (SELECT EedEEID, EedCOID, SUM(EedBenAmt) AS EedBenAmt
                FROM dbo.EmpDed WITH(NOLOCK)
                WHERE EedDedCode = 'GLIFE'
                GROUP BY EedEEID, EedCOID) glife ON glife.EedEEID = xEEID AND glife.EedCOID = xCOID
    LEFT JOIN (SELECT EedEEID, EedCOID, SUM(EedBenAmt) AS EedBenAmt
                FROM dbo.EmpDed WITH(NOLOCK)
                WHERE EedDedCode = 'SUNLA'
                GROUP BY EedEEID, EedCOID) sunla ON sunla.EedEEID = xEEID AND sunla.EedCOID = xCOID    
    LEFT JOIN (SELECT EedEEID, EedCOID, SUM(EedBenAmt) AS EedBenAmt
                FROM dbo.EmpDed WITH(NOLOCK)
                WHERE EedDedCode = 'SUNLS'
                GROUP BY EedEEID, EedCOID) sunls ON sunls.EedEEID = xEEID AND sunls.EedCOID = xCOID  
    LEFT JOIN (SELECT EedEEID, EedCOID, SUM(EedBenAmt) AS EedBenAmt
                FROM dbo.EmpDed WITH(NOLOCK)
                WHERE EedDedCode = 'SUNLC'
                GROUP BY EedEEID, EedCOID) sunlc ON sunlc.EedEEID = xEEID AND sunlc.EedCOID = xCOID  
    WHERE EedBenStatus IN ('T', 'C') 

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
ALTER VIEW dbo.dsi_vwESUNAMERIC_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ESUNAMERIC_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ESUNAMERIC%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202111231'
       ,expStartPerControl     = '202111231'
       ,expLastEndPerControl   = '202111309'
       ,expEndPerControl       = '202111309'
WHERE expFormatCode = 'ESUNAMERIC';

**********************************************************************************/
