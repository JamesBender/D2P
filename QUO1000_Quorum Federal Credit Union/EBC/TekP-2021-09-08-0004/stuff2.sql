--sp_getEEID 'Fedorov' -- CH7G4V000020

--select * from dbo.U_EEBCCOBEXP_drvTbl_QB
--where drvEEID = 'CH7G4V000020'



DECLARE  @FormatCode        VARCHAR(10)
            ,@ExportCode        VARCHAR(10)
            ,@StartDate         DATETIME
            ,@EndDate           DATETIME
            ,@StartPerControl   VARCHAR(9)
            ,@EndPerControl     VARCHAR(9);

    -- Set FormatCode
    SELECT @FormatCode = 'EEBCCOBEXP';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;


SELECT EdhChangeReason, EdhStopDate, EdhDedCode, * FROM dbo.emphded WITH (NOLOCK)
    --JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
      --  ON dbneeid = edheeid 
        --AND dbnformatcode = 'EEBCCOBEXP'
		WHERe EdhEEID  = 'CH7G4V000020'
		AND edhChangeReason IN ('LEVNT4') 
		--and DbnBenstopdate BETWEEN @startdate AND @enddate 