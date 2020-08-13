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
    SELECT @FormatCode = 'ESTANDLDAM';

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
    DELETE FROM dbo.U_ESTANDLDAM_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ESTANDLDAM_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'GLIFD,GLIFE,LTDER,STD,LIFEC,LIFEE,LIFES';

    IF OBJECT_ID('U_ESTANDLDAM_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ESTANDLDAM_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ESTANDLDAM_DedList
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
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_ESTANDLDAM_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ESTANDLDAM_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('401K') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('ROTH') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('MATCH') THEN PdhERCurAmt ELSE 0.00 END)        
        ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('401CU') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('401KL1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('401KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    INTO dbo.U_ESTANDLDAM_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ESTANDLDAM_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );


    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_ESTANDLDAM_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ESTANDLDAM_PEarHist;
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
    INTO dbo.U_ESTANDLDAM_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ESTANDLDAM_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ESTANDLDAM_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ESTANDLDAM_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvOrgIdCode = '10149966'
        ,drvSsn = eepSSN
        ,drvEmpNo = EecEmpNo
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvNameLast = EepNameLast
        ,drvDateOfBirth = EepDateOfBirth
        ,drvDateOfDeath =	CASE WHEN EecEmplStatus = 'T' AND EecTermREason = '203' THEN EecDateOfTermination
								WHEN ISNULL(EepDateDeceased, '') <> '' THEN EepDateDeceased
							END
        ,drvGender = CASE WHEN ISNULL(EepGender, '') <> '' THEN EepGender ELSE 'U' END
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvAddressCountry = EepAddressCountry
        ,drvNonWorkPhone = EepPhoneHomeNumber
        ,drvCurrentHireDate = EecDateOfLastHire
        ,drvEmpTermDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvWorkState = LocAddressState 
        ,drvJobTitle = JbcDesc
        ,drvEmployStatus = (Select top 1 CodDesc from Codes WHERE CODTABLE = 'EMPLOYEESTATUS' AND CodCode = EecEmplStatus)
        ,drvSchedWorkHours = CAST(EecScheduledWorkHrs AS VARCHAR)
        ,drvSchedWorkHoursFreq = (SELECT TOP 1 CodDesc FROM Codes WHERE CODTABLE = 'PAYFREQ' AND CodCode = PgrPayFrequency)
        ,drvEmployeePayType =	CASE EecSalaryOrHourly
									WHEN 'H' THEN 'Hourly'
									WHEN 'S' THEN 'Salary'
								END
        ,drvFullOrPartTime =	CASE EecFullTimeOrPartTime
									WHEN 'F' THEN 'Full Time'
									WHEN 'P' THEN 'Part Time'
								END
        ,drvEmploymentType =	CASE EecEEType
									WHEN 'TMP' THEN 'Temporary'
									WHEN 'SNL' THEN 'Seasonal'
									ELSE 'Regular'
								END
        ,drvWorkEmailAddress = EepAddressEMail -- STOP
        ,drvEmployerLocationCode = ''
        ,drvEmployerLocationName = ''
        ,drvEarningCat1 = ''
        ,drvEarningType1 = ''
        ,drvEarningsAmt1 = ''
        ,drvEarningsAmtExp1 = ''
        ,drvEarningsEffDate1 = ''
        ,drvHrsWorkLast12Mon = ''
        ,drvHrsWorkLast12MonThruDate = ''
        ,drvManagerEmployeeID = EecEmpNo
        ,drvFutureUser = ''
        ,drvHrContactRecipient = ''
        ,drvHrContactEmail = EepAddressEMail
        ,drvStd1Policy = ''
        ,drvStd1Plan = ''
        ,drvStd1Product = ''
        ,drvStd1EffectiveDate = ''
        ,drvStd1TerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvLtd1Policy = ''
        ,drvLtd1Plan = ''
        ,drvLtd1Product = ''
        ,drvLtd1EffectiveDate = ''
        ,drvLtd1TerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvBasicLifePolicy = ''
        ,drvBasicLifePlan = ''
        ,drvBasicLifeProduct = ''
        ,drvBasicLifeEffectiveDate = ''
        ,drvBasicLifeTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvAdditionalLifePolicy = ''
        ,drvAdditionalLifePlan = ''
        ,drvAdditionalLifeProduct = ''
        ,drvAdditionalLifeEffDate = ''
        ,drvAdditionalLifeTermDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvSpouseLifePolicy = ''
        ,drvSpouseLifePlan = ''
        ,drvSpouseLifeProduct = ''
        ,drvSpouseLifeEffectiveDate = ''
        ,drvSpouseLifeTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvOthLif1Policy = ''
        ,drvOthLif1Plan = ''
        ,drvOthLif1Product = ''
        ,drvOthLif1EffectiveDate = ''
        ,drvOthLif1TerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
    INTO dbo.U_ESTANDLDAM_drvTbl
    FROM dbo.U_ESTANDLDAM_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.U_dsi_BDM_ESTANDLDAM WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
	JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
	JOIN dbo.PayGroup WITH (NOLOCK)
        ON PgrPayGroup = EecPayGroup
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
ALTER VIEW dbo.dsi_vwESTANDLDAM_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ESTANDLDAM_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ESTANDLDAM%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201912231'
       ,expStartPerControl     = '201912231'
       ,expLastEndPerControl   = '201912309'
       ,expEndPerControl       = '201912309'
WHERE expFormatCode = 'ESTANDLDAM';

**********************************************************************************/
