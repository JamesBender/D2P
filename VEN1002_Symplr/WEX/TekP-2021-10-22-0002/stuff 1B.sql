    DECLARE  @FormatCode        VARCHAR(10)
            ,@ExportCode        VARCHAR(10)
            ,@StartDate         DATETIME
            ,@EndDate           DATETIME
            ,@StartPerControl   VARCHAR(9)
            ,@EndPerControl     VARCHAR(9);

    -- Set FormatCode
    SELECT @FormatCode = 'EWEXCBREXP';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;


select DbnRelationship, EdhBenStatus,DbnBenStatus, *
FROM dbo.emphded WITH (NOLOCK)
        JOIN dbo.U_dsi_BDM_DepDeductions 
            ON dbneeid = edheeid 
            AND dbnformatcode = 'EWEXCBREXP'
    WHERE edhChangeReason in ('204') 
        AND DbnBenStopDate BETWEEN @StartDate AND @EndDate
        AND dbnValidForExport = 'N'
		and dbnEEID = 'CTK36Y000030'

		
		--AND EdhBenStatus  = 'A'