--sp_getEEID 'Coss' -- DQJ2LO000020
--sp_getEEID 'Meehan' -- D8XD47002020
--sp_getEEID 'Jaramillo' -- B5C3RJ03M0K0

DECLARE @EEID VARCHAR(12) = 'B5C3RJ03M0K0'

select drvHD03_InsuranceLineCode, drvAMT00_AmountQualifierCode1,drvAMT01_AmountQualifierCode1,drvAMT02_MonetaryAmount1,drvAMT00_AmountQualifierCode2,drvAMT01_AmountQualifierCode2,drvAMT02_MonetaryAmount2,drvAMT00_AmountQualifierCode3 ,drvAMT01_AmountQualifierCode3,drvAMT02_MonetaryAmount3,  * 
from dbo.U_EANTHBD834_DrvTbl_2300 
where drvEEID = @EEID
AND drvHD03_InsuranceLineCode IN ('AH')

select * from dbo.U_dsi_bdm_EANTHBD834 WITH (NOLOCK) where bdmEEID = @EEID and BdmDedCode IN ('ADD','ADDF') 

SELECT EedEEID AS AddEeid, EedCOID AS AddCOID, 
				MAX(CASE WHEN EedDedCode = 'ADD' THEN EedBenAmt END) AS AddAmt
				,MAX(CASE WHEN EedDedCode = 'ADDF' THEN EedBenAmt END) AS AddfAmt
				FROM dbo.EmpDed WITH (NOLOCK)
				WHERE EedDedCode IN ('ADD','ADDF')
				AND EedBenStatus = 'A'
				AND EedEEID = @EEID
				GROUP BY EedEEID, EedCOID