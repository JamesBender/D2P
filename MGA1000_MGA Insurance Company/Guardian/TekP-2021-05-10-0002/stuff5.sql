SELECT DISTINCT BdmEEID
FROM dbo.U_dsi_bdm_EGRD834EXP WITH (NOLOCK)
WHERE BdmRecType = 'EMP'
AND BdmDedCode IN ('LIFES','ADDS','LIFEC','ADDC')
AND BdmEEID NOT IN (
					SELECT DISTINCT BdmEEID
					FROM dbo.U_dsi_bdm_EGRD834EXP WITH (NOLOCK)
					WHERE BdmRecType = 'DEP'
					AND (	(BdmRelationship IN ('SPS','DP') AND BdmDedCode IN ('LIFES','ADDS'))
							OR
							(BdmRelationship IN ('CHL') AND BdmDedCode IN ('LIFEC','ADDC'))
						)
					)

SELECT * from dbo.U_dsi_bdm_EGRD834EXP WITH (NOLOCK)
--where BdmEEID = 'COPVW1000040'
where BdmEEID = 'COPVW704D040'
--where BdmEEID = 'COPVWE02A040'
--where BdmEEID = 'COPVWG02G040'
--where BdmEEID = 'COPVWQ008040'
--where BdmEEID = 'COPVXC01F040'


