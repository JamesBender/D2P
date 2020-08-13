DECLARE  @FormatCode        VARCHAR(10), @EndPerControl     VARCHAR(9);

SELECT @FormatCode = 'EFDSTKELIG';

SELECT @EndPerControl   = EndPerControl
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;


--SELECT *
SELECT DISTINCT PthEEID, PthCOID
        ,SUM(CASE WHEN PthTaxCode = 'USMEDEE' THEN PthCurTaxableWages END) as Ytd1Accumulator
        ,SUM(CASE WHEN PthTaxCode LIKE '%SIT' THEN PthCurTaxableWages END) as Ytd2Accumulator -- JCB
		,SUM(CASE WHEN PthTaxCode LIKE 'NYSIT' THEN PthCurTaxableWages END) as Ytd2AAccumulator -- JCB
		,SUM(CASE WHEN PthTaxCode LIKE 'NJSIT' THEN PthCurTaxableWages END) as Ytd2BAccumulator -- JCB
FROM dbo.PTaxHist WITH (NOLOCK)
	JOIN dbo.TaxCode WITH (NOLOCK)
		ON PthTaxCode = CtcTaxCode
    WHERE LEFT(PthPerControl,4) = LEFT(@EndPerControl,4)
        AND PthPerControl <= @EndPerControl
		AND PthEEID = 'BJ3RYQ0000K0'
    GROUP BY PthEEID, PthCOID

SELECT count( distinct PthTaxCode)
from dbo.PTaxHist WITH (NOLOCK)
where PthEEID = 'BJ3RYQ0000K0'
AND PthTaxCode LIKE '%SIT'

--select PthPerControl, PthTaxCode, PthCurTaxableWages, * from dbo.PTaxHist where PthEEID = 'BJ3RYQ0000K0' and PthTaxCode LIKE '%SIT'