--sp_getEEID 10030 -- CQSGFA001040

DECLARE @EEID VARCHAR(12) = 'CQSGFA001040'
DECLARE @EndPerControl VARCHAR(9) = '202204219'

--SELECT drvYTDMedicare, * from dbo.U_EPENCERTAX_drvTbl where drvEEID = @EEID

SELECT PthEEID, PthCOID ,SUM(PthCurTaxAmt) AS PthMedicareYTD
FROM dbo.PTaxHist WITH (NOLOCK)
WHERE LEFT(PthPerControl,4) = LEFT(@EndPerControl,4)
    AND PthPerControl <= @EndPerControl
--	AND PthEEID = @EEID
	AND PthTaxCode = 'USMEDEE'
GROUP BY PthEEID, PthCOID