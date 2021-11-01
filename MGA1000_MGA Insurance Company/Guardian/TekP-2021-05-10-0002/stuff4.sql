select DISTINCT xEEID, BdmDepRecID, ConNameFirst, ConSSN, BdmDedCode, ConIsDependent, ConRelationship
FROM dbo.U_EGRD834EXP_EELIST WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    JOIN dbo.U_dsi_bdm_EGRD834EXP BDM WITH (NOLOCK)
        ON BdmEEID = xEEID
        AND BdmCOID = xCOID
    LEFT JOIN dbo.TrmReasn WITH (NOLOCK)
        ON TchCode = EecTermReason
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSSN <> '000000000'
     --   AND (ConSystemID = BdmDepRecID OR (ConRelationship IN ('SPS','DP','CHL') AND BdmDedCode IN ('LIFES','ADDS','LIFEC','ADDC') AND ConIsDependent = 'Y'))
     AND (ConSystemID = BdmDepRecID)  OR (BdmRecType = 'EMP' AND
                                            (
                                                (ConRelationship IN ('SPS','DP') AND BdmDedCode IN ('LIFES','ADDS'))
                                                OR
                                                (ConRelationship IN ('CHL') AND BdmDedCode IN ('LIFEC','ADDC'))
											)
											AND ConIsDependent = 'Y'
											AND BdmEEID NOT IN  (SELECT BdmEEID FROM dbo.U_dsi_bdm_EGRD834EXP DEP WHERE Bdm.BdmRecType = 'DEP' AND Bdm.BdmEEID = DEP.BdmEEID AND ((ConRelationship IN ('SPS','DP') AND BdmDedCode IN ('LIFES','ADDS')) OR(ConRelationship IN ('CHL') AND BdmDedCode IN ('LIFEC','ADDC'))))
										)
							
	WHERE xEEID  = 'COPW00000040' --AND ConNameFirst = 'Christian'