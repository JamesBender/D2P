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
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

--select * from dbo.U_ECSB401KEX_Audit where audRowNo = 1


select *
FROM dbo.U_ECSB401KEX_EEList WITH (NOLOCK) -- 20125
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
          --and (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
          --                              and EXISTS(select 1 from dbo.U_ECSB401KEX_Audit where  audKey1Value = xEEID AND audKey2Value = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
	--==========================================
	-- update to pull in termination not captured in audit
          and eecemplstatus <> 'T' 
		  OR  (eecemplstatus = 'T' and eectermreason <> 'TRO' and EXISTS(select 1 from dbo.U_ECSB401KEX_Audit WITH (NOLOCK) where audKey1Value = xEEID AND audKey2Value = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T') )
--			OR (eecemplstatus = 'T' and eectermreason <> 'TRO' and EXISTS(SELECT 1 from U_ECSB401KEX_PDedHist where pdheeid = xeeid and (Pdh401FAmt > 0.00 or PdhRothAmt > 0.00 or Pdh401L1Amt > 0.00) )) --)
	--==========================================
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    LEFT JOIN dbo.U_dsi_BDM_ECSB401KEX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.U_ECSB401KEX_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID    
    LEFT JOIN dbo.U_ECSB401KEX_PDedHist_FY WITH (NOLOCK)
        ON PdhFyEEID = xEEID    
    LEFT JOIN dbo.U_ECSB401KEX_PEarHist WITH (NOLOCK)
        ON PehEEID = xEEID
    JOIN dbo.PayGroup WITH (NOLOCK)
        ON PgrPayGroup = EecPayGroup   
    LEFT JOIN (
                SELECT EshEEID, EshCOID, EshStatusStartDate, EshStatusStopDate
                FROM (
                        SELECT EshEEID, EshCOID, EshStatusStartDate, EshStatusStopDate, EshEmplStatus, ROW_NUMBER() OVER (PARTITION BY EshEEID, EshCOID ORDER BY EshStatusStartDate DESC) AS RN
                        FROM dbo.EmpHStat WITH (NOLOCK) 
                        WHERE EshEmplStatus = 'L'
                    ) AS LOA_Dates 
                WHERE RN = 1
            ) AS Leave_StartEnd_Date
        ON EshEEID = xEEID
        AND EshCOID = xCOID
    Join dbo.company WITH (NOLOCK) 
        on cmpcoid = xcoid
	LEFT JOIN (
            SELECT PthEEID AS SalPthEEID, PthCurGrossWages AS SalaryAmount
			--SELECT PthEEID AS SalPthEEID, SUM(PthCurTaxableWages) AS SalaryAmount
            FROM dbo.PTaxHist WITH (NOLOCK)
            WHERE PthPerControl BETWEEN @StartPerControl AND @EndPerControl
				AND PthIsTaxReconAdjustment <> 'Y'
			) AS TotalSal
                --AND PthTaxCode = 'USFIT'
            --GROUP BY PthEEID) AS TotalSal
			
        ON SalPthEEID = xEEID
	LEFT JOIN (
            SELECT PehEEID AS SalYtdPehEEID, sum(PehCurAmt) AS YtdSalaryAmount
			FROM dbo.PEarHist WITH (NOLOCK)
            WHERE PehPerControl BETWEEN CASE WHEN @EndDate < '7/1/' + CAST(DATEPART(YEAR, GETDATE()) AS VARCHAR) THEN CAST(DATEPART(YEAR, GETDATE())-1 AS VARCHAR) + '07011' ELSE CAST(DATEPART(YEAR, GETDATE()) AS VARCHAR) + '07011' END AND @EndPerControl
			GROUP BY PehEEID) AS TotalYtdSal
		ON SalYtdPehEEID = xEEID
	