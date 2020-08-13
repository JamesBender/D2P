DECLARE  @FormatCode        VARCHAR(10)
            ,@EndPerControl     VARCHAR(9)
			,@StartPerControl     VARCHAR(9)
            ;
   
    -- Set FormatCode
    SELECT @FormatCode = 'ELINFINEXP';

    -- Declare dates from Parameter file
    SELECT @EndPerControl   = EndPerControl
		,@StartPerControl = StartPerControl
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

	--SELECT @EndPerControl;

SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhVlifeEE     = SUM(CASE WHEN PdhDedCode IN ('VLIFE') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhVlifeCalcBasisCurAmt    = SUM(CASE WHEN PdhDedCode IN ('VLIFE') THEN PdhDedCalcBasisAmt ELSE 0.00 END)   
        ,PdhBlifeAmt = MAX(CASE WHEN PdhDedCode IN ('BLIFE') THEN PdhDedCalcBasisAmt ELSE 0.00 END)   
        ,PdhStdAmt = MAX(CASE WHEN PdhDedCode IN ('STD') THEN PdhDedCalcBasisAmt ELSE 0.00 END)  
        ,PdhLtdAmt = MAX(CASE WHEN PdhDedCode IN ('LTD') THEN PdhDedCalcBasisAmt ELSE 0.00 END)   
        ,VSAD = MAX(CASE WHEN PdhDedCode IN ('VLIFE') THEN PdhBenAmt ELSE 0.00 END) 
		,VSLI = MAX(CASE WHEN PdhDedCode IN ('VLIFS') THEN PdhBenAmt ELSE 0.00 END) 
		,PdhVlifcAmt = MAX(CASE WHEN PdhDedCode IN ('VLIFC') THEN PdhBenAmt ELSE 0.00 END) 
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ELINFINEXP_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
	AND PdhEEID IN ('CV72L6001020','CY2KEK000020','D0DW85000020', '9GPY600000K0','9GPXYO0020K0')
    --AND PdhPerControl <= @EndPerControl
    --AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );

	select PdhEEID, PdhCOID, PdhDedCode, PdhBenAmt, PdhPerControl FROM dbo.PDedHist WITH (NOLOCK)
	Where PdhEEID IN ('CV72L6001020','CY2KEK000020','D0DW85000020') --, '9GPY600000K0','9GPXYO0020K0')
--	AND PdhDedCode IN ('VLIFE', 'VLIFS')
	AND LEFT(PdhPerControl, 4) = '2020'



	select top 100 EedEEID, EedCOID, EedDedCode, EedBenAmt, EedBenStartDAte, EedStartDate, * 
	from EmpDedFull WITH (NOLOCK)
	where EedEEID IN ('CV72L6001020','CY2KEK000020','D0DW85000020', '9GPY600000K0','9GPXYO0020K0') AND EedDedCode IN ('VLIFE', 'VLIFS') AND EedBenStartDate >= '1/1/2020'


	--SELECT PdhEEID, PdhCOID


	-- Spivey,Joshua
	-- sp_getEEID '9GPY600000K0' 


	-- Ross,Geoffrey
	-- sp_GetEEID '9GPXYO0020K0'