SELECT 
		CASE WHEN A.BdmCobraReason IN ('200','201','202','204','205','206','207','208','209','210','LEVNT1','LEVNT2','LEVNT3','LEVNT4','LEVNT5') THEN
			CASE WHEN A.BdmRelationship = 'SPS' AND (SELECT COUNT(*) FROM dbo.U_dsi_BDM_EDISCOBQB2 B WITH (NOLOCK) WHERE A.BdmEEID = B.BdmEEID AND B.BdmRelationship IN ('CHL','DPC','STC','DCH')) = 1 THEN 'EE+CHILD'
				WHEN A.BdmRelationship = 'SPS' AND (SELECT COUNT(*) FROM dbo.U_dsi_BDM_EDISCOBQB2 B WITH (NOLOCK) WHERE A.BdmEEID = B.BdmEEID AND B.BdmRelationship IN ('CHL','DPC','STC','DCH')) > 1 THEN 'EE+CHILDREN'
				WHEN A.BdmRelationship IN ('CHL','DPC','STC','DCH') THEN 'EE+CHILDREN'
				ELSE --'EE'	
					CASE WHEN BdmBenOption = 'EE' THEN 'EE'
						WHEN BdmBenOption = 'EEF' THEN 'EE+CHILDREN'
					END
			END
		END
		,A.*
FROM dbo.U_dsi_BDM_EDISCOBQB2 A WITH (NOLOCK)
	JOIN dbo.EmpPers WITH (NOLOCK)
		ON EepEEID = A.BdmEEID
	LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = A.BdmEEID
        AND ConSystemID = A.BdmDepRecID
	WHERE BdmDedCode IN ('XOMFT','XOMPT')
	AND BdmEEID = 'CXO93D000030'



SELECT COUNT(*) FROM dbo.U_dsi_BDM_EDISCOBQB2 B WITH (NOLOCK) WHERE 'CXO93D000030' = B.BdmEEID AND B.BdmRelationship IN ('CHL','DPC','STC','DCH')

--select distinct BdmBenOption from dbo.U_dsi_BDM_EDISCOBQB2