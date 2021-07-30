    DECLARE  @FormatCode        VARCHAR(10)
            ,@ExportCode        VARCHAR(10)
            ,@StartDate         DATETIME
            ,@EndDate           DATETIME
            ,@StartPerControl   VARCHAR(9)
            ,@EndPerControl     VARCHAR(9);

    -- Set FormatCode
    SELECT @FormatCode = 'ECSB401KEX';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         =  DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

	--SELECT @EndDate AS EndDate;

select drvPayPerTestingComp, drvYTDPlanTestComp , drvYTDPlanTotalComp, * from dbo.U_ECSB401KEX_drvTbl
where drvEEID = 'C2RAJN0000K0'

SELECT PthEEID AS SalPthEEID, PthPerControl, PthCurTaxableWages --SUM(PthCurTaxableWages) AS SalaryAmount
            FROM dbo.PTaxHist WITH (NOLOCK)
            --WHERE PthPerControl BETWEEN @StartPerControl AND @EndPerControl
			WHERE PthPerControl BETWEEN CASE WHEN @EndDate < '7/1/' + CAST(DATEPART(YEAR, GETDATE()) AS VARCHAR) THEN CAST(DATEPART(YEAR, GETDATE())-1 AS VARCHAR) + '07011' ELSE CAST(DATEPART(YEAR, GETDATE()) AS VARCHAR) + '07011' END AND @EndPerControl
                AND 
				PthTaxCode = 'USFIT'
				AND PthEEID = 'C2RAJN0000K0'



				--SELECT CAST(DATEPART(YEAR, GETDATE()) AS VARCHAR) + '07011'
				--SELECT CASE WHEN DATEPART(YEAR, GETDATE()) > DATEPART(YEAR, @EndDate) THEN '1' ELSE '2' END -- CAST(DATEPART(YEAR, @EndDate) AS VARCHAR) + '07011'
--				SELECT CASE WHEN @EndDate < '7/1/' + CAST(DATEPART(YEAR, GETDATE()) AS VARCHAR) THEN CAST(DATEPART(YEAR, GETDATE())-1 AS VARCHAR) + '07011' ELSE CAST(DATEPART(YEAR, GETDATE()) AS VARCHAR) + '07011' END

				--CASE WHEN DATEPART(YEAR, @EndDate) 