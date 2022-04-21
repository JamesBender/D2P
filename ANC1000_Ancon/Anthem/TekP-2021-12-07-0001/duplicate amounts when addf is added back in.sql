--sp_getEEID 'Jaramillo' -- B5C3RJ03M0K0

DECLARE @EEID VARCHAR(12) = 'B5C3RJ03M0K0'

select drvSubSort, drvAMT00_AmountQualifierCode1,drvAMT01_AmountQualifierCode1,drvAMT02_MonetaryAmount1,drvAMT00_AmountQualifierCode2,drvAMT01_AmountQualifierCode2,drvAMT02_MonetaryAmount2,drvAMT00_AmountQualifierCode3,drvAMT01_AmountQualifierCode3,drvAMT02_MonetaryAmount3
FROM dbo.U_EANTHBD834_DrvTbl_2300
WHERE drvEEID = @EEID


SELECT EedEEID, EedCOID
                    ,MAX(CASE WHEN EedDeDCode = 'RELI1' THEN EedBenAmt END) AS P3Amt
                    ,MAX(CASE WHEN EedDeDCode = 'RELI3' THEN EedBenAmt END) AS D2Amt
                    ,MAX(CASE WHEN EedDeDCode = 'RELI4' THEN EedBenAmt END) AS C1Amt
                    --,MAX(CASE WHEN EedDeDCode = 'ADD' THEN EedBenAmt END) AS ADDAmt
                FROM dbo.EmpDed WITH (NOLOCK)
                WHERE EedDedCode IN ('RELI1','RELI3','RELI4','ADD')
				AND EedEEID = @EEID
                AND EedBenStatus = 'A'
                                --AND eedEEID = @EEID
                GROUP BY EedEEID, EedCOID

SELECT EedEEID AS AddEeid, EedCOID AS AddCOID, MAX(EedBenAmt) AS AddAmt
                FROM dbo.EmpDed WITH (NOLOCK)
                WHERE EedDedCode IN ('ADD','ADDF')
                AND EedBenStatus = 'A'
				AND EedEEID = @EEID
                GROUP BY EedEEID, EedCOID