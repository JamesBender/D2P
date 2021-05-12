DECLARE  @FormatCode        VARCHAR(10)
            ,@ExportCode        VARCHAR(10)
            ,@StartDate         DATETIME
            ,@EndDate           DATETIME
            ,@StartPerControl   VARCHAR(9)
            ,@EndPerControl     VARCHAR(9);
 
    -- Set FormatCode
    SELECT @FormatCode = 'ECCCPAYEXP';
 
    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;
 
SELECT @StartPerControl, @EndPerControl;
 
SELECT distinct xEEID, xCOID, eecpaygroup
              ,PrgPeriodStart
            ,PrgPeriodEnd
            ,CAST(PayDate as datetime)
            ,dbo.dsi_fnpadzero((ISNULL(PehCurHrs,0) *100),10,0)
                                                              --CASE WHEN PehEarnCode not in ('COOT') THEN dbo.dsi_fnpadzero((ISNULL(PehCurHrs,0) *100),10,0)
                                                              --ELSE dbo.dsi_fnpadzero((ISNULL(PehCurHrs,0) *100),10,0)
                                                              --END
            ,dbo.dsi_fnpadzero((ISNULL(PehCurAmt,0) *100),10,0) 
 
            , CASE WHEN EecPayPeriod   = 'W'  THEN '1'
                                    WHEN EecPayPeriod   = 'M'  THEN '4'
                                END
            ,CASE  WHEN PehEarnCode in ('AQPY') THEN 'B'
                                WHEN PehEarnCode in ('ANBNS') THEN 'B'
                                WHEN PehEarnCode in ('BONUS') THEN 'B'
                                WHEN PehEarnCode in ('BNUSO') THEN 'B'
                                WHEN PehEarnCode in ('BNUS1') THEN 'B'
                                WHEN PehEarnCode in ('BNUS2') THEN 'B'
                                WHEN PehEarnCode in ('BNUS3') THEN 'B'
                                WHEN PehEarnCode in ('BNUS4') THEN 'B'
                                WHEN PehEarnCode in ('BNUS5') THEN 'B'
                                WHEN PehEarnCode in ('BNUS6') THEN 'B'
                                WHEN PehEarnCode in ('BNUS7') THEN 'B'
                                WHEN PehEarnCode in ('BNUS8') THEN 'B'
                                WHEN PehEarnCode in ('BNUS9') THEN 'B'
                                WHEN PehEarnCode in ('BNSIP') THEN 'B'
                                WHEN PehEarnCode in ('OBNS') THEN 'B'
                                WHEN PehEarnCode in ('STYON') THEN 'B'
                                WHEN PehEarnCode in ('SAFE') THEN 'B'
                                WHEN PehEarnCode in ('COMM') THEN 'C'
                                WHEN PehEarnCode in ('COMM1') THEN 'C'
                                WHEN PehEarnCode in ('COMM2') THEN 'C'
                                WHEN PehEarnCode in ('SEVER') THEN 'E'
                                WHEN PehEarnCode in ('SEV') THEN 'E'
                                WHEN PehEarnCode in ('HOLF') THEN 'H'
                                WHEN PehEarnCode in ('HOL') THEN 'H'
                                WHEN PehEarnCode in ('INCV') THEN 'I'
                                WHEN PehEarnCode in ('AUTON') THEN 'M'
                                WHEN PehEarnCode in ('AUTOH') THEN 'M'
                                WHEN PehEarnCode in ('AUTO') THEN 'M'
                                WHEN PehEarnCode in ('BEREV') THEN 'M'
                                WHEN PehEarnCode in ('BERV') THEN 'M'
                                WHEN PehEarnCode in ('BDAY') THEN 'M'
                                WHEN PehEarnCode in ('BOOT') THEN 'M'
                                WHEN PehEarnCode in ('CARUG') THEN 'M'
                                WHEN PehEarnCode in ('CARUS') THEN 'M'
                                WHEN PehEarnCode in ('DEC99') THEN 'M'
                                WHEN PehEarnCode in ('1099M') THEN 'M'
                                WHEN PehEarnCode in ('DFCMP') THEN 'M'
                                WHEN PehEarnCode in ('DFCP2') THEN 'M'
                                WHEN PehEarnCode in ('DFCPY') THEN 'M'
                                WHEN PehEarnCode in ('DFCPN') THEN 'M'
                                WHEN PehEarnCode in ('DEFCM') THEN 'M'
                                WHEN PehEarnCode in ('DSBL') THEN 'M'
                                WHEN PehEarnCode in ('SERPL') THEN 'M'
                                WHEN PehEarnCode in ('GTL') THEN 'M'
                                WHEN PehEarnCode in ('GTL2') THEN 'M'
                                WHEN PehEarnCode in ('EXPAT') THEN 'M'
                                WHEN PehEarnCode in ('GTL1U') THEN 'M'
                                WHEN PehEarnCode in ('WAVER') THEN 'M'
                                WHEN PehEarnCode in ('JURY') THEN 'M'
                                WHEN PehEarnCode in ('LTIP') THEN 'M'
                                WHEN PehEarnCode in ('SERPQ') THEN 'M'
                                WHEN PehEarnCode in ('OTHER') THEN 'M'
                                WHEN PehEarnCode in ('SHARE') THEN 'M'
                                WHEN PehEarnCode in ('PHONE') THEN 'M'
                                WHEN PehEarnCode in ('RELNT') THEN 'M'
                                WHEN PehEarnCode in ('RELTE') THEN 'M'
                                WHEN PehEarnCode in ('RELOA') THEN 'M'
                                WHEN PehEarnCode in ('RELOC') THEN 'M'
                                WHEN PehEarnCode in ('RELON') THEN 'M'
                                WHEN PehEarnCode in ('RELO') THEN 'M'
                                WHEN PehEarnCode in ('SERP3') THEN 'M'
                                WHEN PehEarnCode in ('AWARD') THEN 'M'
                                WHEN PehEarnCode in ('STD') THEN 'M'
                                WHEN PehEarnCode in ('STOPE') THEN 'M'
                                WHEN PehEarnCode in ('STOEX') THEN 'M'
                                WHEN PehEarnCode in ('STOTV') THEN 'M'
                                WHEN PehEarnCode in ('STKOP') THEN 'M'
                                WHEN PehEarnCode in ('STPSN') THEN 'M'
                                WHEN PehEarnCode in ('STPSP') THEN 'M'
                                WHEN PehEarnCode in ('STISO') THEN 'M'
                                WHEN PehEarnCode in ('STKNQ') THEN 'M'
                                WHEN PehEarnCode in ('SUPER') THEN 'M'
                                WHEN PehEarnCode in ('SERP') THEN 'M'
                                WHEN PehEarnCode in ('SERP2') THEN 'M'
                                WHEN PehEarnCode in ('GROSS') THEN 'M'
                                WHEN PehEarnCode in ('GRSUP') THEN 'M'
                                WHEN PehEarnCode in ('TPSA') THEN 'M'
                                WHEN PehEarnCode in ('TPSP') THEN 'M'
                                WHEN PehEarnCode in ('TPSPF') THEN 'M'
                                WHEN PehEarnCode in ('TRUCK') THEN 'M'
                                WHEN PehEarnCode in ('EDUC') THEN 'M'
                                WHEN PehEarnCode in ('UPLFT') THEN 'M'
                                WHEN PehEarnCode in ('WAVNP') THEN 'M'
                                WHEN PehEarnCode in ('HCD') THEN 'N'
                                WHEN PehEarnCode in ('PTO') THEN 'N'
                                WHEN PehEarnCode in ('PDAY') THEN 'N'
                                WHEN PehEarnCode in ('PERS') THEN 'N'
                                WHEN PehEarnCode in ('COOT') THEN 'O'
                                WHEN PehEarnCode in ('DBL') THEN 'O'
                                WHEN PehEarnCode in ('DBLM') THEN 'O'
                                WHEN PehEarnCode in ('OT1') THEN 'O'
                                WHEN PehEarnCode in ('OT') THEN 'O'
                                WHEN PehEarnCode in ('OTM') THEN 'O'
                                WHEN PehEarnCode in ('REG') THEN 'R'
                                WHEN PehEarnCode in ('REGM') THEN 'R'
                                WHEN PehEarnCode in ('SHIFT') THEN 'R'
                                WHEN PehEarnCode in ('RETRO') THEN 'RA'
                                WHEN PehEarnCode in ('SICK') THEN 'S'
                                WHEN PehEarnCode in ('SKHC') THEN 'S'
                                WHEN PehEarnCode in ('ADVAC') THEN 'V'
                                WHEN PehEarnCode in ('VAC') THEN 'V'
                                WHEN PehEarnCode in ('VACS') THEN 'V'
                                WHEN PehEarnCode in ('VACPY') THEN 'V'
                                ELSE 'M'
                                END
            ,dbo.dsi_fnpadzero((ISNULL(PehCurAmtYTD,0) *100),10,0)
            ,dbo.dsi_fnpadzero((ISNULL(PehCurHrsYTD,0) *100),10,0)
 
FROM dbo.U_ECCCPAYEXP_EEList WITH (NOLOCK)
       JOIN dbo.EmpComp WITH (NOLOCK)
              ON EecEEID = xEEID
              AND EecCoID = xCoID
              and (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' and EXISTS(select 1 from dbo.U_ECCCPAYEXP_Audit where  audKey1Value = xEEID AND audKey2Value = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    JOIN dbo.Company WITH (NOLOCK)
        ON CmpCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.U_ECCCPAYEXP_PEarHist WITH (NOLOCK)
        ON PehEEID  = xEEID
    LEFT JOIN dbo.Location
              on LocCode =  EecLocation
       LEFT JOIN (
                           Select eeteeid,eetcoid,EetTaxCode,CtcIDNumber
                           from (
                                         Select DISTINCT eeteeid,eetcoid,EetTaxCode, ROW_NUMBER() OVER(PARTITION BY eeteeid,eetcoid  ORDER BY AuditKey DESC) AS RowNumber from dbo.EmpTax Where eettaxcode like '%SUI%'
                           ) as A
                           JOIN dbo.TaxCode
                                  On A.EetTaxCode = CtcTaxCode
                           where A.RowNumber = 1 ) TaxInfo
              On eeteeid =  xeeid
              AND eetcoid  =  xcoid
       LEFT JOIN (
                           SELECT PgpPayGroup, LEFT(PgpPeriodControl,8) as PayDate, PgpPeriodStartDate as PrgPeriodStart, PgpPeriodEndDate PrgPeriodEnd
                           FROM dbo.PgPayPer WITH (NOLOCK)
                           WHERE PgpPeriodControl BETWEEN @StartPerControl AND @EndPerControl
                                  AND PgpPeriodType <> 'A') as Paydate
        ON Paydate.PgpPayGroup =  eecpaygroup
       where xEEID = 'CRW99B000050';
 
 
       SELECT PgpPeriodControl, PgpPeriodStartDate, * --, PgpPayGroup, LEFT(PgpPeriodControl,8) as PayDate, PgpPeriodStartDate as PrgPeriodStart, PgpPeriodEndDate PrgPeriodEnd
                           FROM dbo.PgPayPer WITH (NOLOCK)
                           WHERE PgpPeriodControl BETWEEN @StartPerControl AND @EndPerControl
                                  AND PgpPayGroup = 'GGSE'
 
                                  -- Pay every Friday