DECLARE @FormatCode        VARCHAR(10), @EndPerControl     VARCHAR(9);

    -- Set FormatCode
    SELECT @FormatCode = 'EFDSTKELIG';

    -- Declare dates from Parameter file
    SELECT
         @EndPerControl   = EndPerControl        
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

-- WALSH

SELECT DISTINCT PthEEID AS YpaEEID, PthCOID AS YpaCOID
		,SUM(PthCurTaxableWages) AS YTD2PrimaryAccumulator
	FROM dbo.PTaxHist WITH (NOLOCK)
	WHERE LEFT(PthPerControl, 4) = LEFT(@EndPerControl, 4)
		AND PthPerControl <= @EndPerControl
		AND PthTaxCode LIKE '%SIT'
		AND PthIsResidentTaxCode = 'N'
		AND PthEEID IN ('CVM000000040', 'CVM00O000040')
	GROUP BY PthEEID, PthCOID


	/*SELECT DISTINCT PthEEID, PthCOID
        ,SUM(CASE WHEN PthTaxCode = 'USMEDEE' THEN PthCurTaxableWages END) as Ytd1Accumulator
        ,SUM(CASE WHEN PthTaxCode LIKE '%SIT' THEN PthCurTaxableWages END) as Ytd2Accumulator -- ... THEN THIS
    FROM dbo.PTaxHist WITH (NOLOCK)
	JOIN dbo.TaxCode WITH (NOLOCK)
		ON PthTaxCode = CtcTaxCode
    WHERE LEFT(PthPerControl,4) = LEFT(@EndPerControl,4)
        AND PthPerControl <= @EndPerControl
		AND PthEEID IN ('CVM000000040', 'CVM00O000040')
    GROUP BY PthEEID, PthCOID*/


select pthTaxCode, PthCurTaxableWages, * 
From PTaxHist
where PthEEID = 'CVM00O000040'
and LEFT(PthPerControl,4) = LEFT(@EndPerControl,4)
        AND PthPerControl <= @EndPerControl
		--and PthTaxCode LIKE '%SIT'
		AND PthTaxCode LIKE '%FIT'

select pthTaxCode, PthCurTaxableWages, * 
From PTaxHist
where PthEEID = 'CVM00O000040'
and LEFT(PthPerControl,4) = LEFT(@EndPerControl,4)
        AND PthPerControl <= @EndPerControl
		and PthTaxCode LIKE '%SIT'
		

		--sp_getEEID 'CVM00O000040'