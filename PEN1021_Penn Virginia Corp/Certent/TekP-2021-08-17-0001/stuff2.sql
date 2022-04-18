    DECLARE  @FormatCode        VARCHAR(10)
            ,@ExportCode        VARCHAR(10)
            ,@StartDate         DATETIME
            ,@EndDate           DATETIME
            ,@StartPerControl   VARCHAR(9)
            ,@EndPerControl     VARCHAR(9);

    -- Set FormatCode
    SELECT @FormatCode = 'EPENCERTAX';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

	SELECT @EndPerControl;

SELECT SUM(PehCurAmt) AS PehCurAmtYTD, SUM(PthCurSuppTaxableWages) AS PthCurSuppTaxableWages
FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    LEFT JOIN dbo.PTaxHist WITH (NOLOCK)
        ON PehGenNumber = PthGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
AND PehPerControl <= @EndPerControl
AND PehPerControl > @EndPerControl
AND PehEEID = 'CQSGFA001040'