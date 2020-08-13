SELECT PrgEEID, PrgCOID, PrgPayDate, PrgTransactionType-- MAX(PrgPayDate) AS PayDate
			FROM dbo.PayReg WITH (NOLOCK)
			WHERE  PrgPerControl BETWEEN '202003251' AND '202003259'  -- JCB
				--AND PrgTransactionType IN ('D', 'C')
		and PrgEEID = 'B6USFK0000K0'
			--GROUP BY PrgEEID, PrgCOID

select EdhDedCode,  * from EmpHDed A
where EdhEEID = 'B250AU00A0K0'
and EdhDedCode IN ('401K','401F','401PC','401FC','ROTH2','ROTHF','RTHPC','RTHFC','4KLON','4KLN2','4KLN3','KLN')

select top 10 * from EmpDed
where EedEEID = 'B250AU00A0K0'
and EedDedCode IN ('401K','401F','401PC','401FC','ROTH2','ROTHF','RTHPC','RTHFC','4KLON','4KLN2','4KLN3','KLN')



select top 10 * from ChkDeds