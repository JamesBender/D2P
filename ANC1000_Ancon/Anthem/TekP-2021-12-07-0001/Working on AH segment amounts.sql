--sp_getEEID 'Jaramillo' -- B5C3RJ03M0K0


DECLARE @EEID VARCHAR(12) = 'B5C3RJ03M0K0'

--select * from dbo.U_EANTHBD834_DrvTbl where drvEEID = @EEID AND drvINS01_YesNoCond = 'Y'

select drvInitialSort, drvSubSort, drvAMT00_AmountQualifierCode1, drvAMT01_AmountQualifierCode1, drvAMT02_MonetaryAmount1, drvAMT00_AmountQualifierCode2, drvAMT01_AmountQualifierCode2, drvAMT02_MonetaryAmount2, drvAMT00_AmountQualifierCode3, drvAMT01_AmountQualifierCode3, drvAMT02_MonetaryAmount3
	, * from dbo.U_EANTHBD834_DrvTbl_2300 where drvEEID = @EEID and drvHD03_InsuranceLineCode = 'AH'

select BdmBenStatusDate, * from dbo.U_dsi_bdm_EANTHBD834 WITH (NOLOCK) where BdmEEID = @EEID AND BdmRecType = 'EMP' --AND BdmDedCode in ('RELI1','RELI3','RELI4')

/*
SELECT BdmEEID AS ReliEEID, BdmCOID AS ReliCOID
					,MAX(CASE WHEN BdmDedCode = 'RELI1' THEN BdmDedCode END) AS Reli1DedCode
					,MAX(CASE WHEN BdmDedCode = 'RELI3' THEN BdmDedCode END) AS Reli3DedCode
					,MAX(CASE WHEN BdmDedCode = 'RELI4' THEN BdmDedCode END) AS Reli4DedCode
					,MAX(BdmBenStatusDate) AS ReliBenStatusDate
				FROM dbo.U_dsi_bdm_EANTHBD834 WITH (NOLOCK) 
				WHERE BdmDedCode IN ('RELI1','RELI3','RELI4')
				AND BdmEEID = @EEID
				GROUP BY BdmEEID, BdmCOID
*/


SELECT EedEEID, EedCOID
	,EedDedCode, *
	/*,MAX(CASE WHEN EedDeDCode = 'RELI1' THEN EedBenAmt END) AS ReliP3Amt
	,MAX(CASE WHEN EedDeDCode = 'RELI3' THEN EedBenAmt END) AS ReliD2Amt
	,MAX(CASE WHEN EedDeDCode = 'RELI4' THEN EedBenAmt END) AS ReliC1Amt
	,MAX(CASE WHEN EedDeDCode = 'ADDF' THEN EedBenAmt END) AS ReliC1Amt
	,MAX(CASE WHEN EedDeDCode = 'RELI4' THEN EedBenAmt END) AS ReliC1Amt*/
FROM dbo.EmpDed WITH (NOLOCK)
WHERE EedDedCode IN ('RELI1','RELI3','RELI4', 'ADDF','ADD')
				AND eedEEID = @EEID
--GROUP BY EedEEID, EedCOID


