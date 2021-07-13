USE [ULTIPRO_WPTYL]
GO
/****** Object:  StoredProcedure [dbo].[dsi_sp_BuildDriverTables_EBASICPFSA]    Script Date: 7/13/2021 1:30:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EBASICPFSA]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: TY Lin

Created By: Inshan Singh
Business Analyst: Cheryl Petitti
Create Date: 02/01/2021
Service Request Number: TekP-2020-11-17-0002

Purpose: Basic Pacific FSA Export

Revision History
----------------
06/07/2021 by AP:
        - UPDATE statement for EffectiveDate for values < 01/01/2021.

07/08/2021 by AP:
		- Updated Election Change Date logic.
		- Updated Eligibility End Date.

07/13/2021 by AP:
		- Updated Ejh table in the join to be an outer apply to fix a duplicate issue.

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EBASICPFSA';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EBASICPFSA';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EBASICPFSA';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EBASICPFSA';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EBASICPFSA' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBASICPFSA', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBASICPFSA', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBASICPFSA', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBASICPFSA', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBASICPFSA', 'SCH_EBASIC';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EBASICPFSA';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EBASICPFSA', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@FileMinCovDate    DATETIME;

    -- Set FormatCode
    SELECT @FormatCode = 'EBASICPFSA';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@FileMinCovDate  = CONCAT(YEAR(GETDATE()), '0101')
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

	--select @startdate, @enddate

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EBASICPFSA_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EBASICPFSA_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EBASICPFSA_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EBASICPFSA_AuditFields;
    CREATE TABLE dbo.U_EBASICPFSA_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_EBASICPFSA_AuditFields VALUES ('EmpDed','EedEEGoalAmt');
    INSERT INTO dbo.U_EBASICPFSA_AuditFields VALUES ('EmpDed','EedBenStartDate');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EBASICPFSA_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EBASICPFSA_Audit;
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
        ,audNewGoalAmt = CASE WHEN audTableName = 'EmpDed' AND audFieldName = 'EedEEGoalAmt' AND CONVERT(MONEY,isnULL(audNewValue, 0.00)) <> CONVERT(MONEY,isNULL(audOldValue,0.00)) AND audOldValue IS NOT NULL THEN 'Y' ELSE 'N' END
    INTO dbo.U_EBASICPFSA_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EBASICPFSA_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    IF OBJECT_ID('U_EBASICPFSA_Audit_Final','U') IS NOT NULL
       DROP TABLE dbo.U_EBASICPFSA_Audit_Final;

    select distinct a.*, c.audnewvalue as audNewStart
    into dbo.U_EBASICPFSA_Audit_Final
    from U_EBASICPFSA_Audit a outer apply (select top 1 audnewvalue from dbo.U_EBASICPFSA_Audit b where a.audeeid = b.audeeid and a.audkey2 = b.audkey2 and audkey3 = b.audkey3 and b.audfieldname = 'eedbenstartdate' order by auddatetime desc) c --left join U_EBASICPFSA_Audit b
    --on a.audeeid = b.audeeid and a.audkey2 = b.audkey2 and a.audkey3 = b.audkey3 and b.audfieldname = 'eedbenstartdate' 
    where --a.audeeid = '7WCM4Z0010K0'
     a.audfieldname = 'eedeegoalamt'
	-- and a.audeeid = 'CR8YF0000020'
    --and a.audfieldname = 'eedeegoalamt'
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EBASICPFSA_Audit_Final ON dbo.U_EBASICPFSA_Audit_Final (audEEID,audKey2);

    --================
    -- Changes Only
    --================
    --DELETE FROM dbo.U_EBASICPFSA_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EBASICPFSA_Audit WHERE audEEID = xEEID AND audRowNo = 1);


    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'FSA19,DCA19,LPF19,LPT19' ;

    IF OBJECT_ID('U_EBASICPFSA_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EBASICPFSA_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EBASICPFSA_DedList
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
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EBASICPFSA_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EBASICPFSA_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EBASICPFSA_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvEmployerID = '4119-8043-7263'
        ,drvIndividualID = '' --eepSSN -- leave blank
        ,drvEmployeeID = EecEmpNo
        ,drvIndividualSSN = eepSSN
        ,drvLastName = EepNameLast
        ,drvFirstName = EepNameFirst
        ,drvBenefitPlanID = CASE
                                WHEN EedDedCode = 'FSA19' THEN  '1000135099'
                                WHEN EedDedCode = 'DCA19' THEN  '1000135098'
                                WHEN EedDedCode IN ('LPF19', 'LPT19') THEN '1000135100'                                
                                -- change from below based on feedback
                                --WHEN EedDedCode = 'FSA19' THEN  'MRA'
                                --WHEN EedDedCode = 'DCA19' THEN  'DCA'
                                --WHEN EedDedCode IN ('LPF19', 'LPT19') THEN 'MLP'
                            END
        --,drvEffectiveDate = CASE WHEN EedDedCode in ('FSA19', 'DCA19', 'LPF19', 'LPT19') THEN dbo.dsi_fnGetMinMaxDates('MAX',EedBenStartDate, @FileMinCovDate)  END
        
        /*The file should send an effective date that starts on the 1st of each month following the EEs eligibility*/
        ,drvEffectiveDate = CASE WHEN EedDedCode IN ('FSA19', 'DCA19', 'LPF19', 'LPT19') THEN EedBenStartDate END --dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate) END
         --CASE WHEN EedDedCode in ('FSA19', 'DCA19', 'LPF19', 'LPT19') THEN dbo.dsi_fnGetMinMaxDates('MAX'
                                                                                                                      --  ,case when DATEFROMPARTS(YEAR(EedBenStartDate),MONTH(EedBenStartDate),1) = CONVERT(DATE,EedBenStartDate,101) THEN EedBenStartDate else  DATEFROMPARTS(YEAR(EedBenStartDate),MONTH(DATEADD(M,1,EedBenStartDate)),1) end 
                                                                                                                      --  ,@FileMinCovDate)  END
        ,drvElectionChangeDate =  ISNULL(CONVERT(VARCHAR, (CASE WHEN EecDateOfOriginalHire BETWEEN @StartDate AND @EndDate THEN NULL
											WHEN Ejh.EjhReason = '100' THEN NULL
											WHEN audKey3 IN ('FSA19', 'DCA19', 'LPF19', 'LPT19') AND CAST(BdmBenStartDate AS DATE) <> CAST(YEAR(GETDATE()) AS VARCHAR) + '-01-01' AND Ejh.EjhReason <> '100' THEN NULL
                                            WHEN audKey3 in ('FSA19', 'DCA19', 'LPF19','LPT19') AND audNewGoalAmt = 'Y' AND audDateTime BETWEEN @StartDate AND @EndDate
                                                 THEN audNewStart 
                                            END), 101), '')
        --CASE WHEN audKey3 in ('FSA19', 'DCA19', 'LPF19','LPT19') AND audNewGoalAmt = 'Y' THEN EedBenStartDate END
        ,drvEligibilityEndDate = CASE WHEN EecEmplStatus = 'A' AND EedBenStatus = 'T' AND  EedDedCode IN ('FSA19', 'DCA19', 'LPF19','LPT19') THEN EedBenStopDate END 
        ,drvIndividualElectionAmount = CASE WHEN EedDedCode IN ('FSA19', 'DCA19', 'LPF19','LPT19')THEN CONVERT(VARCHAR, CONVERT(MONEY,EedEEGoalAmt)) END 
        ,drvClientElectionAmount = '' -- leave blank
        ,drvDisbursableDate = '' -- leave blank
        ,drvTakeoverOverride = '' -- leave blank
        ,drvCoverageTier = '' -- leave blank
    INTO dbo.U_EBASICPFSA_drvTbl
    FROM dbo.U_EBASICPFSA_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EBASICPFSA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = BdmEEID
        AND EedCOID = BdmCOID
        AND EedDedCode = EedDedCode
        AND EedFormatCode = @FormatCode AND EedValidForExport = 'Y'
	OUTER APPLY (SELECT TOP 1* FROM dbo.EmpHJob WITH(NOLOCK) WHERE EjhEEID = xEEID AND EjhCOID = xCOID ORDER BY EjhDateTimeCreated DESC) Ejh
    LEFT JOIN dbo.U_EBASICPFSA_Audit_Final WITH (NOLOCK)
        ON AudEEID = xEEID and audKey2 = xCOID and eeddedcode = audKey3
    --WHERE CAST(EedBenStartDate as date) >= cast(year(getdate()) as varchar) + '-01-01'
        
        ;
    ;

    -- No records should show values prior to current year 01-01
    UPDATE dbo.U_EBASICPFSA_drvTbl
    SET drvEffectiveDate = cast(year(getdate()) as varchar) + '-01-01'
    WHERE CAST(drvEffectiveDate AS DATE) < cast(year(getdate()) as varchar) + '-01-01';

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
ALTER VIEW dbo.dsi_vwEBASICPFSA_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EBASICPFSA_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EBASICPFSA%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202101251'
       ,expStartPerControl     = '202101251'
       ,expLastEndPerControl   = '202102019'
       ,expEndPerControl       = '202102019'
WHERE expFormatCode = 'EBASICPFSA';

**********************************************************************************/
