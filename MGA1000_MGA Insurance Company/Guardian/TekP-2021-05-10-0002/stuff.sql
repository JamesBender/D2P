--select * from dbo.U_dsi_bdm_EGRD834EXP WITH (NOLOCK)
--where BdmDedCode IN ('LIFEE','LIFES','LIFEC','ADDE','ADDS','ADDC')

--select top 10 * from EmpDed WHERE EedDedCode IN ('LIFEE','LIFES','LIFEC','ADDE','ADDS','ADDC') AND EedEEID IN ('COPVW1000040','COPVW1000040','COPVW1000040','COPVW1000040','COPVW602H040','COPVWJ02I040','COPVWJ02I040','COPVWK02J040','COPVWR02A040','COPVWT005040')



-- sp_getEEID 'De Silva' -- COPWJ9000040

SELECT * from dbo.U_dsi_bdm_EGRD834EXP WITH (NOLOCK) where BdmEEID = 'COPWJ9000040'
SELECT drvInitialSort, drvSubSort, * FROM dbo.U_EGRD834EXP_DrvTbl_2300 WHERE drvEEID = 'COPWJ9000040'

SELECT ConSystemId, ConRelationship, * from Contacts where ConEEID = 'COPWJ9000040'

-- CHL -> U
-- CPL2WJ0ET040
select C.ConSystemID, BdmDedCode, ADDCConSystemId, ADDSConSystemId
FROM dbo.U_EGRD834EXP_EELIST WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.U_dsi_bdm_EGRD834EXP WITH (NOLOCK)
        ON BdmEEID = xEEID
        AND BdmCOID = xCOID
    LEFT JOIN dbo.Contacts C WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID 
	LEFT JOIN (
				SELECT DISTINCT ConSystemId AS ADDCConSystemId, ConEEID AS ADDCEEID
				FROM dbo.Contacts WITH (NOLOCK)
				WHERE ConIsDependent = 'Y'				
					AND ConRelationship NOT IN ('SPS','DP')) AS AddcDep
		ON xEEID = ADDCEEID
		AND BdmDedCode IN ('ADDC', 'LIFEC')
	LEFT JOIN (
				SELECT DISTINCT ConSystemId AS ADDSConSystemId, ConEEID AS ADDSEEID
				FROM dbo.Contacts WITH (NOLOCK)
				WHERE ConIsDependent = 'Y'				
					AND ConRelationship IN ('SPS','DP')) AS AddsDep
		ON xEEID = ADDSEEID
		AND BdmDedCode IN ('ADDS', 'LIFES')
	WHERE --BdmDedCode IN ('ADDC')
	--AND 
	xEEID = 'COPWJ9000040'
	--BdmDedCode = 'LIFEC'
		