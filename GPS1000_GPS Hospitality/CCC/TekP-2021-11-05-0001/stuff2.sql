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

SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE --LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    --AND PehPerControl <= @EndPerControl
	--and 
	PehEEID =  'BJZ0PW0000K0'
	AND PehEarnCode IN ('AWARD',
'BON',
'BONA',
'BONV',
'CARE2',
'BOND',
'CARES',
'BONR',
'BONS',
'BONT',
'FRGNC',
'FBPRT',
'GTL',
'HSAER',
'SEV',
'HOL',
'DRINC',
'GFTCD',
'MRNQ',
'RELOT',
'RELON',
'RELOU',
'TXGFT',
'TGFTG',
'WCRSD',
'BEREV',
'EOPTO',
'JURY',
'PTO',
'PER',
'PYPTO',
'PTOP',
'COPO',
'LITOT',
'OT',
'OTADJ',
'QP',
'LITRG',
'OVRPY',
'REG',
'SAL',
'MUPA1',
'MUPA2',
'TIPMK',
'BKPY',
'RETRO',
'DCDPY',
'DCVST',
'MDSCK',
'MISCK',
'NJSCK',
'SICK',
'TIPCA',
'VACPO',
'PYVAC',
'VAC')
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;



    REG  
SAL  
TIPCA
ATA  
RETRO
PTO  
HOL  
VAC  
BEREV
JURY 
GTL  
BOND 
PYVAC
BONR 
MDSCK
PYPTO
MISCK
OT   
PUCV 
TXGFT

