   DECLARE  @FormatCode        VARCHAR(10)
            ,@ExportCode        VARCHAR(10)
            ,@StartDate         DATETIME
            ,@EndDate           DATETIME
            ,@StartPerControl   VARCHAR(9)
            ,@EndPerControl     VARCHAR(9);
    -- Set FormatCode
    SELECT @FormatCode = 'EWAGEWREXP';
    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;


SELECT 'EMP'
	,EedCOID
	,EedEEID
	,NULL
	,NULL
	,''
	,''
	,'Emp'
	,EepDateOfBirth
	,Eeddedcode
	,'FSA'
	,NULL
	,EedBenStatus
	,EedBenStartDate
	,EedBenStopDate
	,EedBenStatusDate
	,EedBenOptionDate
	,EedChangeReason
	,EedStartDate
	,EedStopDate
	,'N'
	,EedCobraReason
	,EedDateOfCobraEvent
	,EedISPQB
	,NULL
	,EedUSGField1
	,EedUSGField2
    ,EedUSGDate1
	,EedUSGDate2
	,EedTVSTartDate
	,''
	,EedEEAmt
	,EedEECalcRateOrPct
	,EedEEGoalAmt
	,NULL
	,EedERAmt
	,EedNumSpouses
	,EedNumChildren
	,EedNumDomPartners
	,EedNumDPChildren
FROM dbo.u_dsi_bdm_empdeductions WITH (NOLOCK)
JOIN EmpPers 
	ON EedEEID = EepEEID
WHERE EedFormatCode = 'EWAGEWREXP' 
	AND EedValidForExport = 'N' 
	AND EedBenStatus = 'T'
	AND EedBenStatusDate BETWEEN @StartDate AND @EndDate


select top 10 * from dbo.U_dsi_BDM_EWAGEWREXP


--select distinct BdmDedType from dbo.U_dsi_BDM_EWAGEWREXP