SELECT T.EdhEEID, T.EdhCOID, T.EdhDedCode, T.EdhBenStartDate, A.BdmBenStartDate, A.*
FROM(
select EdhEEID, EdhCOID, EdhDedCode, EdhBenStartDate, ROW_NUMBER() OVER (PARTITION BY EdhEEID, EdhCOID, EdhDedCode ORDER BY EdhBenStartDAte DESC) AS RN
from EmpHDed A 
WHERE EdhDedCode IN ('461','450','451','452','442', '443', '444', '447', '448', '596', '597')
AND EdhBenStatus = 'A'
) AS T
JOIN dbo.U_dsi_BDM_EFHSAENROL A WITH (NOLOCK)
	ON A.BdmEEID = T.EdhEEID
	AND A.BdmCOID = T.EdhCOID
	AND A.BdmDedCode = T.EdhDedCode
WHERE T.RN = 1
--where EdhEEID IN (SElect drvEEID from dbo.U_EFHSAENROL_drvTbl) order by A.EdhEEID, A.EdhDedCode