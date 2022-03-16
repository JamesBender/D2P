select *
FROM dbo.U_ETRANAM401_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ETRANAM401 WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
/*    JOIN dbo.U_ETRANAM401_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID*/
    JOIN dbo.U_ETRANAM401_PEarHist WITH (NOLOCK)
        ON PehEEID = xEEID
    LEFT JOIN dbo.U_ETRANAM401_Audit WITH (NOLOCK)
        ON audEEID = xEEID
        AND audFieldName = 'EecDateOfTermination'
where xEEID = 'CK0UBG000030'


select * from dbo.U_dsi_BDM_ETRANAM401 WITH (NOLOCK) where BdmEEID = 'CK0UBG000030'








select pdhPerControl, *
FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ETRANAM401_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT('202005229',4)
    AND PdhPerControl <= '202005229'
    --AND PdhPerControl BETWEEN '202005221' AND '202005229' -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
	AND pdhEEID = 'CK0UBG000030'
    --GROUP BY PdhEEID
   /* HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );*/