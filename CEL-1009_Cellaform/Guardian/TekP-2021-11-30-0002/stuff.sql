--sp_getEEID 'Beckham' -- DIJVKK000020
--sp_getEEID 'Boswell' -- E58N6T000020
--sp_getEEID 'Wood' -- DN86E5007020

--DECLARE @EEID VARCHAR(12) = 'DIJVKK000020'
--DECLARE @EEID VARCHAR(12) = 'E58N6T000020'
DECLARE @EEID VARCHAR(12) = 'DN86E5007020'

select * from dbo.U_EGUARDN834_DrvTbl_2300 where drvEEID = @EEID

select * from dbo.U_dsi_bdm_EGUARDN834 WITH (NOLOCK) where BdmDedCode = 'LIFES' --where BdmEEID = @EEID

SELECT EedEEID, EedCOID, EedDedCode, *
                        --,MAX(CASE WHEN EedDedCode = 'LIFEE' THEN EedBenAmt END) AS LIFEE_Amt
                        --,MAX(CASE WHEN EedDedCode = 'LIFEC' THEN EedBenAmt END) AS LIFEC_Amt
                        --,MAX(CASE WHEN EedDedCode = 'LIFES' THEN EedBenAmt END) AS LIFES_Amt
                    FROM dbo.EmpDed WITH (NOLOCK)
                    WHERE EedDedCode IN ('LIFEE','LIFEC','LIFES')
					and EedEEID = @EEID
                    --GROUP BY EedEEID, EedCOID


					--select * from EmpDed where EedDedCode = 'LIFEC' AND EedBenAmt <> 0.00 and EedBenStatus = 'A'

					select * from DEdCode where DedDedCode = 'LIFEC'