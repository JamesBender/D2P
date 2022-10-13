USE [ULTIPRO_NDC]
GO
/****** Object:  StoredProcedure [dbo].[dsi_sp_BuildDriverTables_ENATDUFSAC]    Script Date: 10/12/2022 5:01:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ENATDUFSAC]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: National Dentex

Created By: Roger Bynum
Business Analyst: Kim Ephram
Create Date: 08/12/2022
Service Request Number: SR-2016-00012345

Purpose: UHC FSA Combined Export

Revision History
----------------
Update By           Date           Request Num        Desc
Marie Waters      10/05/2022     TekP-2022-07-06-01   Updated code to pull dates from BDM

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ENATDUFSAC';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ENATDUFSAC';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ENATDUFSAC';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ENATDUFSAC';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ENATDUFSAC' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ENATDUFSAC', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ENATDUFSAC', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ENATDUFSAC', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ENATDUFSAC', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ENATDUFSAC', 'SCH_ENATDU';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ENATDUFSAC';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ENATDUFSAC', @AllObjects = 'Y', @IsWeb = 'Y'
**********************************************************************************/
BEGIN

    --==========================================
    -- Declare variables
    --==========================================
     DECLARE @FormatCode        VARCHAR(10)
            ,@ExportCode        VARCHAR(10)
            ,@StartDate         DATETIME
            ,@EndDate           DATETIME
            ,@StartPerControl   VARCHAR(9)
            ,@EndPerControl     VARCHAR(9)
            ,@FileMinCovDate    DATETIME;

    -- Set FormatCode
    SELECT @FormatCode = 'ENATDUFSAC';
    

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@FileMinCovDate  = case when cast(getdate() as date) < cast(cast(year(getdate()) as varchar) + '-07-01' as varchar) -- MW added to auto grab updated min coverage date based on year
                                    then CONCAT(YEAR(GETDATE()) -1, '0701') ELSE CONCAT(YEAR(GETDATE()), '0701') END
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_ENATDUFSAC_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ENATDUFSAC_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'FSAMD,FSALT,FSADP';

    IF OBJECT_ID('U_ENATDUFSAC_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ENATDUFSAC_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ENATDUFSAC_DedList
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
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'FutureDatedStartDateDays','15');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'FutureDatedStopDateDays','15');

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
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_ENATDUFSAC_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ENATDUFSAC_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts

        ,PdhFSADP        = MAX(CASE WHEN PdhDedCode IN ('FSADP') THEN 'FSADP' ELSE '' END)
        ,PdhFSALT        = MAX(CASE WHEN PdhDedCode IN ('FSALT') THEN 'FSALT' ELSE '' END)
        ,PdhFSAMD        = MAX(CASE WHEN PdhDedCode IN ('FSAMD') THEN 'FSAMD' ELSE '' END)
        ,pdhFSADPANDFSALT = '              '
        ,pdhFSAMDANDFSALT = '              '

        ,PdhEEFSADP      = SUM(CASE WHEN PdhDedCode IN ('FSADP') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhEEFSALT      = SUM(CASE WHEN PdhDedCode IN ('FSALT') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhEEFSAMD      = SUM(CASE WHEN PdhDedCode IN ('FSAMD') THEN PdhERCurAmt ELSE 0.00 END)

        ,PdhFSADPStopDate = MAX(CASE WHEN PdhDedCode IN ('FSADP') THEN ISNULL(EedBenStopDate, '') ELSE '' END)
        ,PdhSFALTStopDate = MAX(CASE WHEN PdhDedCode IN ('FSALT') THEN ISNULL(EedBenStopDate, '') ELSE '' END)
        ,PdhFSAMDStopDate = MAX(CASE WHEN PdhDedCode IN ('FSAMD') THEN ISNULL(EedBenStopDate, '') ELSE '' END)

        ,PdhFSADPGoalAmt  =  MAX(CASE WHEN PdhDedCode IN ('FSADP') THEN ISNULL(pdhEEGoalAmt, '') ELSE '' END)
        ,PdhFSALTGoalAmt =  MAX(CASE WHEN PdhDedCode IN ('FSALT') THEN ISNULL(pdhEEGoalAmt, '') ELSE '' END)
        ,PdhFSAMDGoalAmt =  MAX(CASE WHEN PdhDedCode IN ('FSAMD') THEN ISNULL(pdhEEGoalAmt, '') ELSE '' END)



    INTO dbo.U_ENATDUFSAC_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ENATDUFSAC_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    JOIN dbo.EmpDed
        ON eedEEID = PdhEEID
        AND EedCoID = PdhCoID
        AND ISNULL(EedBenStatus, 'W') IN ('A', 'T')
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00)
    ;
    UPDATE dbo.U_ENATDUFSAC_PDedHist
        SET pdhFSADPANDFSALT = 'fSADPAndFSALT'
        WHERE pdhEEID IN
        (SELECT PdhEEID 
        FROM dbo.U_ENATDUFSAC_PDedHist
        WHERE PdhFSADP = 'FSADP'
        AND PdhFSALT = 'FSALT')
    UPDATE dbo.U_ENATDUFSAC_PDedHist
        SET pdhFSAMDANDFSALT = 'FSAMDAndFSALT'
        WHERE pdhEEID IN
        (SELECT PdhEEID 
        FROM dbo.U_ENATDUFSAC_PDedHist
        WHERE PdhFSAMD = 'FSAMD'
        AND PdhFSALT = 'FSALT')
    ;

    -----------
    -- Remove terminations except in the range
    -----------

    IF OBJECT_ID('dbo.U_Dsi_drvTbl_ENATDUFSAC_Audit')     IS NOT NULL  DROP TABLE dbo.U_Dsi_drvTbl_ENATDUFSAC_Audit;

    SELECT DISTINCT

    AudKey1Value,
    AudKey2Value,
    AudKey3Value,
    AudTableName,
    AudFieldName,
    AudOldValue,
    AudNewValue,
    AudDateTime,
    AudProcessedDateTime

    INTO dbo.U_Dsi_drvTbl_ENATDUFSAC_Audit
    FROM dbo.U_ENATDUFSAC_EELIST
    JOIN dbo.vw_AuditEEdata ON AudKey1Value = xEEID
    -- Want maximum audit key in case of multiple changes
    JOIN (SELECT AudKey1Value MaxEEID, AudFieldName MaxFieldName, MAX(AudProcessedDateTime) AS MaxDateTime
          FROM dbo.vw_AuditEEdata
          WHERE AudTableName IN ('EmpComp','Contacts') 
          AND AudFieldName IN ('EecEmplStatus','ConNameFirst')
          AND AudProcessedDateTime BETWEEN @StartDate AND @EndDate
          GROUP BY AudKey1Value,AudFieldName) MaxAudit ON AudKey1Value = MaxEEID AND AudFieldName = MaxFieldName AND AudProcessedDateTime = MaxDateTime
    WHERE AudTableName IN ('EmpComp','Contacts') 
    AND AudFieldName IN ('EecEmplStatus','ConNameFirst')
    AND AudProcessedDateTime BETWEEN @StartDate AND @EndDate;

    DELETE A
    FROM dbo.U_ENATDUFSAC_EELIST A
    JOIN dbo.EmpComp WITH (NOLOCK) ON EecEEID = xEEID AND EecCOID = xCOID AND EecEmplStatus = 'T'
    WHERE NOT EXISTS (SELECT 1 FROM dbo.U_Dsi_drvTbl_ENATDUFSAC_Audit WHERE EecEEID = AudKey1Value AND EecCOID = AudKey2Value AND AudNewValue = 'T');


    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_ENATDUFSAC_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ENATDUFSAC_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_ENATDUFSAC_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;

    -----------------------------
    -- Working Table - PperNumber
    -----------------------------
    IF OBJECT_ID('U_ENATDUFSAC_PperNumber','U') IS NOT NULL
        DROP TABLE dbo.U_ENATDUFSAC_PperNumber;

    SELECT pYear + pMonthDay as pPerControl, CAST(pRowNumber AS CHAR(2)) AS pRowNumber
    INTO dbo.U_ENATDUFSAC_PperNumber
    FROM (SELECT pYear, pMonthDay, 
    (ROW_NUMBER() OVER(PARTITION BY pYear ORDER BY pMonthDay)) pRowNumber
    FROM
    (SELECT DISTINCT
     LEFT(pdhPerControl, 4) AS pYear, SUBSTRING(pdhPerControl, 5, 4) AS pMonthDay
    FROM dbo.PDedHist) p) pr

    UPDATE dbo.U_ENATDUFSAC_PperNumber SET pRowNumber = '0' + pRowNumber WHERE LEN(pRowNumber) = 1

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ENATDUFSAC_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ENATDUFSAC_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ENATDUFSAC_drvTbl;
   SELECT DISTINCT
       drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvEmployeeID = EepSSN
        ,drvMemberLastName = EepNameLast
        ,drvMemberFirstname = EepNameFirst
        ,drvMemberMiddleInitial = ISNULL(LEFT(EepNameMiddle,1), ' ')
        ,drvPermStreetAddress1 = EepAddressLine1
        ,drvPermStreetAddress2 = ISNULL(EepAddressLine2, '                              ')
        ,drvPermanentCity = EepAddressCity
        ,drvPermanentState = EepAddressState
        ,drvPermanentZipcode = Case when Right(EepAddressZipCode, 4) = 0000 then Left(EepAddressZipCode,5) ELSE EepAddressZipCode END
        ,drvMemberBirthDate = CONVERT(VARCHAR(8),EepDateOfBirth, 112)
        ,drvPlanCode =     CASE WHEN pdhFSADPANDFSALT = 'FSADPANDFSALT' THEN '5001'
                                WHEN pdhFSAMDANDFSALT = 'FSAMDANDFSALT' THEN '0001'
                                WHEN PdhFSADP = 'FSADP' THEN '0001'
                                WHEN PdhFSALT = 'FSALT' THEN '5001'
                                WHEN PdhFSAMD = 'FSAMD' THEN '0001'
                                ELSE NULL --MW changed to use null
                        END
        ,drvPlanEffectiveDate =  Convert(VARCHAR,CASE WHEN dbo.dsi_fnGetMinMaxDates('MAX', @StartDate, @FileMinCovDate) >= CAST(YEAR(@StartDate) AS CHAR(4)) + '0701' THEN  CAST(YEAR(@StartDate) AS CHAR(4)) + '0701'  --MW changed from CAST(YEAR(GETDATE()) AS CHAR(4)) + '0701' to grab correcct plan year when year changes
                                                            ELSE CAST(YEAR(BdmTVStartDate) AS CHAR(4)) + '0701' --MW BdmTVStartDate updates with Open Enrollment
                                                        END , 112)
        ,drvEnrollmentDate = Convert(VARCHAR,CASE WHEN @ExportCode NOT LIKE 'OE%' THEN dbo.dsi_fnGetMinMaxDates('MAX',MaxBenStartDate , @FileMinCovDate)  ELSE  BdmTVStartDate END , 112) --MW changed to use min file date and BdmTVStartDate updates with Open Enrollment  changed from CASE WHEN @ExportCode NOT LIKE 'OE%' THEN CAST(YEAR(GETDATE()) AS CHAR(4)) + '0701' ELSE '        ' END 
        ,drvContributionType1 = CASE WHEN @ExportCode NOT LIKE 'OE%' THEN 
                                    CASE WHEN PdhFSALT = 'FSALT' THEN 'MED' 
                                        WHEN PdhFSAMD = 'FSAMD' THEN 'MED' 
                                        WHEN PdhFSADP = 'FSADP' THEN  Null ---MT added 9/20/22
                                        ELSE NULL --MW changed to use null
                                      END
                                    ELSE NULL
                                  END
        ,drvContributionSource1 = CASE WHEN PdhFSALT = 'FSALT' THEN 'E' --CASE WHEN PdhFSADP  <> 'FSADP'  THEN  'E'  ELSE NULL  END ---MT added 9/20/22 -- Changed by MW 10/12/2022 Code was not accounting for PdhFSAMD or PdhFSALT
                                       WHEN PdhFSAMD = 'FSAMD' THEN 'E'
                                     ELSE Null  --MW changed to use null
                                    END
        ,drvContributionSign1 = CASE WHEN @ExportCode NOT LIKE 'OE%' THEN
                                     CASE WHEN pCombAmt > 0 THEN '+'
                                     WHEN pCombAmt < 0 THEN '-'
                                    ELSE NULL --MW changed to use null
                                END
                                ELSE NULL 
                            END
        ,drvContributionAmount1 = CASE WHEN @ExportCode NOT LIKE 'OE%' AND pCombAmt > 0 THEN CAST(dbo.dsi_fnPadZero(pCombAmt * 100,7,0) AS VARCHAR) ELSE NULL  END
        ,drvContributionType2 = CASE WHEN PdhFSADP = 'FSADP' THEN 'DEP' ELSE NULL END
        ,drvContributionSourceCode2 = CASE WHEN @ExportCode NOT LIKE 'OE%' AND PdhFSADP = 'FSADP' THEN 'E' ELSE NULL  END
        ,drvContributionSign2 = CASE WHEN @ExportCode NOT LIKE 'OE%' THEN
                                        CASE WHEN PdhFSADP = 'FSADP' AND PdhEEFSADP > 0 THEN '+'
                                             WHEN PdhFSADP = 'FSADP' AND PdhEEFSADP < 0 THEN '-'
                                             ELSE NULL --MW changed to use null
                                        END
                                     ELSE NULL --MW changed to use null
                                END
        ,drvContributionAmount2 = CASE WHEN @ExportCode NOT LIKE 'OE%' AND FSADP_DedCode = 'FSADP' AND FSADP_BdmEEAmt > 0 THEN  CAST(dbo.dsi_fnPadZero(FSADP_BdmEEAmt * 100,7,0) AS VARCHAR)--REPLACE(SUBSTRING(CAST(dbo.dsi_fnPadZero(PdhEEFSADP,7,0) AS VARCHAR), 1, LEN(PdhEEFSADP) - 2),'.','')
                                       ELSE NULL --MW changed to use null
                                  END
        ,drvHealthcareorLimitedTerm = CASE WHEN FSAMD_DedCode = 'FSAMD' AND FSAMD_BenStopDate IS NOT NULL THEN CONVERT(VARCHAR, FSAMD_BenStopDate, 112)  --MW changed to use BDM --PdhFSAMD = 'FSAMD' AND PdhFSAMDStopDate IS NOT NULL THEN CONVERT(VARCHAR, PdhFSAMDStopDate, 112) 
                                           WHEN FSALT_DedCode = 'FSALT' AND FSALT_BenStopDate IS NOT NULL THEN CONVERT(VARCHAR, FSALT_BenStopDate, 112)  --MW changed to use BDM --WHEN PdhFSALT = 'FSALT' AND PdhSFALTStopDate IS NOT NULL THEN CONVERT(VARCHAR, PdhSFALTStopDate, 112)       
                                           ELSE NULL --MW changed to use null
                                      END
        ,drvHealthcareorLimitedAmount = CASE WHEN FSAMD_DedCode ='FSAMD' AND FSAMD_BdmEEGoalAmt > 0 THEN CAST(dbo.dsi_fnPadZero(FSAMD_BdmEEGoalAmt * 100,7,0) AS VARCHAR) --MW changed to use BDM --WHEN PdhFSAMD = 'FSAMD' AND PdhFSAMDGoalAmt > 0 THEN CAST(dbo.dsi_fnPadZero(PdhFSAMDGoalAmt * 100,7,0) AS VARCHAR)
                                             WHEN FSALT_DedCode= 'FSALT' AND FSALT_BdmEEGoalAmt> 0 THEN CAST(dbo.dsi_fnPadZero(FSALT_BdmEEGoalAmt * 100,7,0) AS VARCHAR) --MW changed to use BDM --WHEN PdhFSALT = 'FSALT' AND pdhFSALTGoalAmt > 0 THEN CAST(dbo.dsi_fnPadZero(PdhFSALTGoalAmt * 100,7,0) AS VARCHAR)
                                             ELSE NULL  --MW changed to use null
                                        END
                                        
        ,drvHealthcareorLimitedEDate = CASE WHEN Combined_BdmDedCode = 'Combined' THEN CONVERT(VARCHAR,dbo.dsi_fnGetMinMaxDates('MAX',Combined_BenStartDate , @FileMinCovDate), 112)--MW changed to use BDM and Min File Date   --CASE WHEN PdhFSAMD = 'FSAMD' AND PdhFSAMDStopDate IS NOT NULL THEN CAST(YEAR(GETDATE()) AS CHAR(4)) + '0701' ELSE '        ' END
                                             ELSE NULL  END--MW changed to use null
        
        
        ,drvDependentCareFSATermDate = CASE WHEN FSADP_DedCode = 'FSADP' AND FSADP_BenStopDate IS NOT NULL THEN CONVERT(VARCHAR, FSADP_BenStopDate, 112) ELSE NULL  END  --MW changed to use BDM       --CASE WHEN PdhFSADP = 'FSADP' AND PdhFSADPStopDate IS NOT NULL THEN CONVERT(VARCHAR, PdhFSADPStopDate, 112) ELSE  '        ' END   
        ,drvDependentCareElecEffDate = CASE WHEN FSADP_DedCode= 'FSADP'  THEN Convert(VARCHAR,dbo.dsi_fnGetMinMaxDates('MAX', FSADP_BenStartDate  , @FileMinCovDate), 112) ELSE NULL  END--MW changed to use BDM and Min File Date --CASE WHEN PdhFSADP = 'FSADP' THEN CAST(YEAR(GETDATE()) AS CHAR(4)) + '0701' ELSE '        ' END
        ,drvDependentCareFSAElecAmount = CASE WHEN FSADP_DedCode = 'FSADP' THEN CAST(dbo.dsi_fnPadZero(FSADP_BdmEEGoalAmt * 100,7,0) AS VARCHAR) ELSE NULL END --MW changed to use BDM --CASE WHEN PdhFSADP = 'FSADP' THEN CAST(dbo.dsi_fnPadZero(PdhFSADPGoalAmt * 100,7,0) AS VARCHAR) ELSE '       ' END
    INTO dbo.U_ENATDUFSAC_drvTbl
    FROM dbo.U_ENATDUFSAC_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
  --  JOIN dbo.U_dsi_BDM_ENATDUFSAC WITH (NOLOCK)
  --      ON BdmEEID = xEEID 
  --      AND BdmCoID = xCoID
        --AND bdmEEAmt <> 0
    --JOIN dbo.Payreg WITH (NOLOCK)
        --ON PrgEEID = xEEID
        --AND prgCOID = xCOID
  --  JOIN dbo.PDedHist WITH (NOLOCK)
  --      ON pdhEEID = xEEID
        --AND PdhDedCode = BdmDedCode
    --LEFT JOIN dbo.EmpDed WITH (NOLOCK)
    --    ON EedEEID = xEEID
    --    AND EedDedCode IN ('FSAMD','FSALT','FSADP')
        --AND EedDedCode = BdmDedCode
        --AND EedCoID = xCOID
     JOIN (SELECT pdhEEID AS pEEID, 
                      PdhFSADP AS PdhFSADP, 
                      PdhFSALT AS PdhFSALT,
                      PdhFSAMD AS PdhFSAMD,
                      pdhFSADPANDFSALT AS pdhFSADPANDFSALT,
                      pdhFSAMDANDFSALT AS pdhFSAMDANDFSALT,
                      PdhEEFSALT + PdhEEFSAMD  AS pCombAmt,
                      PdhEEFSADP AS PdhEEFSADP,
                      CASE WHEN PdhFSADPStopDate <> '' THEN PdhFSADPStopDate ELSE NULL END AS PdhFSADPStopDate,
                      CASE WHEN PdhSFALTStopDate <> '' THEN PdhSFALTStopDate ELSE NULL END AS PdhSFALTStopDate,
                      CASE WHEN PdhFSAMDStopDate <> '' THEN PdhFSAMDStopDate ELSE NULL END AS PdhFSAMDStopDate,
                      PdhFSADPGoalAmt AS PdhFSADPGoalAmt,
                      PdhFSALTGoalAmt AS PdhFSALTGoalAmt,
                      PdhFSAMDGoalAmt AS PdhFSAMDGoalAmt
                FROM dbo.U_ENATDUFSAC_PDedHist) AS dPlan
        ON pEEID = xEEID
    JOIN (                                                                                                        ---MW added BDM section for correct dates
            SELECT BdmRecType, BdmEEID, BdmCOID , BdmDepRecID  
                
                ,MAX(CASE WHEN BdmDedCode = 'FSAMD' THEN BdmDedCode END) AS FSAMD_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'FSALT' THEN BdmDedCode END) AS FSALT_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'FSADP' THEN BdmDedCode END) AS FSADP_DedCode
             
                ,MAX(CASE WHEN BdmDedCode = 'FSAMD' THEN BdmBenStatus END) AS FSAMD_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'FSALT' THEN BdmBenStatus END) AS FSALT_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'FSADP' THEN BdmBenStatus END) AS FSADP_BenStatus
              
                ,MAX(CASE WHEN BdmDedCode = 'FSAMD' THEN BdmBenStartDate END) AS FSAMD_BenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'FSALT' THEN BdmBenStartDate END) AS FSALT_BenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'FSADP' THEN BdmBenStartDate END) AS FSADP_BenStartDate
             
                ,MAX(CASE WHEN BdmDedCode = 'FSAMD' THEN BdmBenStopDate END) AS FSAMD_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'FSALT' THEN BdmBenStopDate END) AS FSALT_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'FSADP' THEN BdmBenStopDate END) AS FSADP_BenStopDate
              
                ,MAX(CASE WHEN BdmDedCode = 'FSAMD' THEN BdmEEAmt END) AS FSAMD_BdmEEAmt
                ,MAX(CASE WHEN BdmDedCode = 'FSAMD' THEN BdmEEGoalAmt END) AS FSAMD_BdmEEGoalAmt
                ,MAX(CASE WHEN BdmDedCode = 'FSALT' THEN BdmEEAmt END) AS FSALT_BdmEEAmt
                ,MAX(CASE WHEN BdmDedCode = 'FSALT' THEN BdmEEGoalAmt END) AS FSALT_BdmEEGoalAmt
                ,MAX(CASE WHEN BdmDedCode = 'FSADP' THEN BdmEEAmt END) AS FSADP_BdmEEAmt
                ,MAX(CASE WHEN BdmDedCode = 'FSADP' THEN BdmEEGoalAmt END) AS FSADP_BdmEEGoalAmt
                ,MAX(CASE WHEN BdmDedCode IN ( 'FSALT','FSAMD') THEN 'Combined' END) as Combined_BdmDedCode
                ,MAX(CASE WHEN BdmDedCode IN ( 'FSALT','FSAMD') THEN BdmBenStartDate END) AS Combined_BenStartDate
                ,MAX(CASE WHEN BdmDedCode IN ( 'FSALT','FSAMD','FSADP') THEN BdmBenStartDate END) AS MaxBenStartDate
                ,MAX(CASE WHEN BdmDedCode IN ( 'FSALT','FSAMD','FSADP') THEN BdmTVStartDate END ) AS BdmTVStartDate
            FROM dbo.U_dsi_BDM_ENATDUFSAC WITH (NOLOCK)
            GROUP BY BdmRecType, BdmEEID, BdmCOID , BdmDepRecID
        ) AS DedCodes
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    
    ;
 
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    DECLARE @prgPaydate Date
    SELECT @prgPaydate = PrgPayDate FROM dbo.vw_int_PayReg WHERE  LEFT(prgPerControl,4) = LEFT(@EndPerControl,4)
                                                                        AND prgPerControl <= @EndPerControl
    IF OBJECT_ID('U_ENATDUFSAC_Header','U') IS NOT NULL
        DROP TABLE dbo.U_ENATDUFSAC_Header;
    SELECT DISTINCT
         drvDate = CASE WHEN @ExportCode LIKE 'OE%' THEN CAST(YEAR(GETDATE()) AS CHAR(4)) + '0701'
                        ELSE CONVERT(CHAR(8), @prgPaydate, 112)
                   END
        ,drvCycle = CASE WHEN @ExportCode LIKE 'OE%' THEN 'E01' 
                        ELSE 'B' + MAX(pRowNumber) -- Todo, Check for PgrPayFrequency = B 
                    END
        ,drvTypeofFeed = CASE WHEN @ExportCode LIKE 'OE%' THEN 'ENRL' ELSE 'PROD' END
    INTO dbo.U_ENATDUFSAC_Header
    FROM dbo.U_ENATDUFSAC_PEarHist WITH (NOLOCK)
    CROSS JOIN dbo.U_ENATDUFSAC_PperNumber
          WHERE LEFT(pPerControl,4) = LEFT(@EndPerControl,4)
          AND pPerControl <= @EndPerControl
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ENATDUFSAC_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_ENATDUFSAC_Trailer;
    SELECT DISTINCT
         drvRecordCount = '      '
        ,drvTotalHCAndLimitedPurpSign = ' '
        ,drvTotalHCAndLimitedPurpAmt = '          '
        ,drvTotalDeoendentCareContSign = ' '
        ,drvTotalDependentCareContAmt = '          '
        ,drvTotalHCAndLimitPurpElecAmt = '          '
        ,drvTotalDependCareElectAmt = '          '
    INTO dbo.U_ENATDUFSAC_Trailer
    ;


    DECLARE @RecordCount INT,
            @TotHCLAmt numeric,
            @TotDepCareAmt numeric,
            @TotHCLimtiPurpAmt numeric,
            @TotDepCareELecAmt numeric

    SELECT @RecordCount = COUNT(*)
           ,@TotHCLAmt = SUM(CAST(drvContributionAmount1 AS INT)) 
           ,@TotDepCareAmt = SUM(CAST(drvContributionAmount2 AS BIGINT))
           ,@TotHCLimtiPurpAmt = SUM(CAST(drvHealthcareorLimitedAmount AS BIGINT))
           ,@TotDepCareELecAmt = SUM(CAST(drvDependentCareFSAElecAmount AS BIGINT))
           FROM dbo.U_ENATDUFSAC_drvTbl


    UPDATE dbo.U_ENATDUFSAC_Trailer
    SET        drvRecordCount = dbo.dsi_fnpadzero(@RecordCount, 6, 0)
           ,drvTotalHCAndLimitedPurpSign = CASE WHEN @ExportCode NOT LIKE 'OE%' THEN CASE WHEN @TotHCLAmt > 0 THEN '+' WHEN @TotHCLAmt < 0 THEN '-' ELSE ' ' END ELSE NULL END
           ,drvTotalHCAndLimitedPurpAmt = CASE WHEN @ExportCode NOT LIKE 'OE%' THEN ISNULL(CAST(dbo.dsi_fnPadZero(@TotHCLAmt * 100,10,0) AS VARCHAR), '          ') ELSE NULL END
           ,drvTotalDeoendentCareContSign = CASE WHEN @ExportCode NOT LIKE 'OE%' THEN CASE WHEN @TotDepCareAmt  > 0 THEN '+' WHEN @TotDepCareAmt  < 0 THEN '-' ELSE ' ' END ELSE NULL END
           ,drvTotalDependentCareContAmt = CASE WHEN @ExportCode NOT LIKE 'OE%'THEN  ISNULL(CAST(dbo.dsi_fnPadZero(@TotDepCareAmt * 100,10,0) AS VARCHAR), '          ') ELSE NULL END
           ,drvTotalHCAndLimitPurpElecAmt = ISNULL(CAST(dbo.dsi_fnPadZero(@TotHCLimtiPurpAmt * 100,10,0) AS VARCHAR), '          ')
           ,drvTotalDependCareElectAmt = ISNULL(CAST(dbo.dsi_fnPadZero(@TotDepCareELecAmt * 100,10,0) AS VARCHAR), '          ')


    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE '%TEST%' THEN 'Test_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'OE_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwENATDUFSAC_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ENATDUFSAC_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'ENATDUFSAC%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202208251'
       ,expStartPerControl     = '202108251'
       ,expLastEndPerControl   = '202208319'
       ,expEndPerControl       = '202208319'
WHERE expFormatCode = 'ENATDUFSAC';

**********************************************************************************/
