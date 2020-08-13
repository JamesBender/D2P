SELECT EdhEEID, EdhCOID, EdhDedCode, EdhChangeReason, EdhEffDate
FROM (
		SELECT EdhEEID, EdhCOID, EdhDedCode, EdhChangeReason, EdhEffDate, ROW_NUMBER() OVER(PARTITION BY EdhEEID, EdhCOID, EdhDedCode ORDER BY EdhEffDate DESC) AS rn
		FROM dbo.EmpHDed WITH (NOLOCK) 
		WHERE  EdhDedCode IN ('MED', 'MEDP', 'MEDG', 'MEDGP')
			AND EdhChangeReason IN ('302') --, 'LEVNT1')
) AS T
WHERE rn = 1
--and EdhEEID IN ('ADMYW200R0K0', 'D3Y4FY000020', 'CLJ8R8000020', 'CQ3OPC000020', 'CQXG57000020', 'C6G9J40000K0', 'CWOVQV000020')
--and EdhDedCode = 'MEDG'
--order by T.EdhEEID

--sp_getEEID 'D104CL000020'

SELECT EdhEEID, EdhCOID, EdhDedCode, EdhChangeReason, EdhEffDate, ROW_NUMBER() OVER(PARTITION BY EdhEEID, EdhCOID, EdhDedCode ORDER BY EdhEffDate DESC) AS rn
		FROM dbo.EmpHDed WITH (NOLOCK) 
		WHERE  EdhDedCode IN ('MED', 'MEDP', 'MEDG', 'MEDGP')
			AND EdhChangeReason IN ('302') --, 'LEVNT1')
				AND EdhEEID = 'D104CL000020'





/*
select EdhEEID, EdhCOID, EdhDedCode, EdhChangeReason, EdhEffDate, ROW_NUMBER() OVER(PARTITION BY EdhEEID, EdhCOID, EdhDedCode ORDER BY EdhEffDate DESC) AS rn
from dbo.EmpHDed WITH (NOLOCK)
where EdhEEID IN ('ADMYW200R0K0', 'D3Y4FY000020', 'CLJ8R8000020', 'CQ3OPC000020', 'CQXG57000020', 'C6G9J40000K0', 'CWOVQV000020')
AND EdhDedCode = 'MEDG'

*/