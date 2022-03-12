DECLARE  @FormatCode        VARCHAR(10)
            ,@ExportCode        VARCHAR(10)
            ,@StartDate         DATETIME
            ,@EndDate           DATETIME
            ,@StartPerControl   VARCHAR(9)
            ,@EndPerControl     VARCHAR(9)
			,@EEID				VARCHAR(12);

    -- Set FormatCode
    SELECT @FormatCode = 'EEBCCOBEXP';
	SELECT @EEID = 'CX1IZN001020'

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

	SELECT @STartDAte, @EndDate;

/*
select EdhDedCode, EdhChangeReason, DbnBenStopDate, *
FROM dbo.emphded WITH (NOLOCK)
        JOIN dbo.U_dsi_BDM_DepDeductions 
            ON dbneeid = edheeid 
            AND dbnformatcode = 'EEBCCOBEXP'
			AND DbnDedCode = EdhDedCOde
    WHERE edhChangeReason in ('204') 
        AND DbnBenStopDate BETWEEN @StartDate AND @EndDate
		--AND DbnDedCode IN ('DEN','DENG')
		and EdhEEID = @EEID
;
*/

select EdhDedCode, EdhChangeReason, DbnBenStopDate, *
FROM dbo.emphded WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
        ON dbneeid = edheeid 
        AND dbnformatcode = 'EEBCCOBEXP'
		AND DbnDedCode = EdhDedCOde
    WHERE edhChangeReason IN ('201') 
        and DbnBenstopdate BETWEEN @startdate AND @enddate 
		--AND DbnDedCode IN ('DEN','DENG')
		and EdhEEID = @EEID

select EdhDedCode, EdhChangeReason, DbnBenStopDate, *
FROM dbo.emphded WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
        ON dbneeid = edheeid 
        AND dbnformatcode = 'EEBCCOBEXP'
		AND DbnDedCode = EdhDedCOde
    WHERE edhChangeReason IN ('200') 
        and DbnBenstopdate BETWEEN @startdate AND @enddate 
		--AND DbnDedCode IN ('DEN','DENG')
		and EdhEEID = @EEID
