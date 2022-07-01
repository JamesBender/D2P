DECLARE  @FormatCode        VARCHAR(10)
            ,@ExportCode        VARCHAR(10)
            ,@StartDate         DATETIME
            ,@EndDate           DATETIME
            ,@StartPerControl   VARCHAR(9)
            ,@EndPerControl     VARCHAR(9);

    -- Set FormatCode
    SELECT @FormatCode = 'EEMP401KEX';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;



select *
FROM dbo.U_EEMP401KEX_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EEMP401KEX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN (
                SELECT EjhEEID, EjhCOID
                    ,MAX(EjhJobEffDate) AS EjhJobEffDate
                FROM dbo.EmpHJob WITH (NOLOCK)
                WHERE EjhEmplStatus = 'T'
                GROUP BY EjhEEID, EjhCOID) EJH
        on EjhEEID = xEEID
        AND EjhCOID = xCOID
    JOIN dbo.U_EEMP401KEX_PEarHist WITH (NOLOCK)
        ON PehEEID = xEEID
    --JOIN dbo.U_EEMP401KEX_PDedHist WITH (NOLOCK)
       -- ON PdhEEID = xEEID
    LEFT JOIN (
                SELECT PthEEID, PthCOID 
                    ,SUM(PthCurTaxableWages) AS  PthCurTaxableWagesYTD
                FROM dbo.PTaxHist WITH (NOLOCK)
                WHERE PthTaxCode LIKE '%USFIT%'
                AND LEFT(PthPerControl,4) = LEFT(@EndPerControl,4)
                    AND PthPerControl <= @EndPerControl 
                GROUP BY PthEEID, PthCoID) PTH
        ON PthEEID = xEEID
        AND PthCOID = xCOID
    LEFT JOIN (
                SELECT EfoEEID, EfoPhoneNumber
                FROM (
                        SELECT EfoEEID, EfoPhoneNumber, ROW_NUMBER() OVER (PARTITION BY EfoEEID ORDER BY EfoPhoneNumber) AS RN --, ORDER BY Ef
                        FROM  dbo.EmpMPhon WITH (NOLOCK)
                        WHERE EfoPhoneType = 'CEL') AS Efo
                WHERE RN = 1 ) AS EfoPhone
        ON EfoEEID = xEEID
    JOIN dbo.PayGroup WITH (NOLOCK)
        ON PgrPayGroup = EecPayGroup
	WHERE xEEID = 'EB5N7X000040'
    ;


-- Ryan Long has pay on 6/17, file run on 6/15 wouldn't pick him up.
select PehPerControl, *
FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    --AND PehPerControl <= @EndPerControl
	AND PehEEID = 'EB5N7X000040'