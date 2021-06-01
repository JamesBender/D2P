DECLARE  @FormatCode        VARCHAR(10)
            ,@ExportCode        VARCHAR(10)
            ,@StartDate         DATETIME
            ,@EndDate           DATETIME
            ,@StartPerControl   VARCHAR(9)
            ,@EndPerControl     VARCHAR(9)
			,@PayGroup VARCHAR(20);

    -- Set FormatCode
    SELECT @FormatCode = 'ETRACOL401';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

select EecEmplStatus, EecDateOfTermination, PdhEmpAferTax, PdhEmpBeforeTax, PehCurHrs, PehCurAmt, PrgPeriodStart, PrgPeriodEnd ,PayDate, *
FROM dbo.U_ETRACOL401_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = dbo.dsi_BDM_fn_GetCurrentCOID(eeceeid)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
	LEFT JOIN dbo.U_ETRACOL401_PDedHist WITH (NOLOCK) -- JCB
		ON PdhEEID =  xeeid
    JOIN dbo.U_ETRACOL401_PEarHist  WITH (NOLOCK)
        ON PehEEID = xeeid
    LEFT JOIN (SELECT PgpPayGroup, CAST( LEFT(MAX(PgpPeriodControl),8) as datetime) as PayDate, MAX(PgpPeriodStartDate) PrgPeriodStart, MAX(PgpPeriodEndDate) PrgPeriodEnd 
                   FROM dbo.PgPayPer WITH (NOLOCK)
                   WHERE PgpPeriodControl BETWEEN @StartPerControl AND @EndPerControl 
                   GROUP BY PgpPayGroup) as PayGRP
        on PayGRP.PgpPayGroup =  eecpaygroup
	WHERE -- (EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND (PdhEmpAferTax > 0 OR PdhEmpBeforeTax > 0 OR PehCurHrs > 0 AND PehCurAmt > 0)))
	--AND 
	--xEEID = '5OD4DJ0000K0'
	xEEID  = 'DM5IMW000050'
    ;