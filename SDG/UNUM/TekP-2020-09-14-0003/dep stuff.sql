SELECT ConEEID AS DepEEID
	--,BdmDedCode AS DepDedCode
	,MAX(CASE WHEN RN = 1 THEN ConRelationship END) AS ConRelationship1
	,MAX(CASE WHEN RN = 1 THEN ConSystemId END) AS ConSystemId1
	,MAX(CASE WHEN RN = 1 THEN ConNameLast END) AS DepNameLast1
	,MAX(CASE WHEN RN = 1 THEN ConNameMiddle END) AS DepNameMiddle1
	,MAX(CASE WHEN RN = 1 THEN ConNameFirst END) AS DepNameFirst1
	,MAX(CASE WHEN RN = 1 THEN ConNameSuffix END) AS DepNameSuffix1
	,MAX(CASE WHEN RN = 1 THEN ConSSN END) AS DepNameSSN1
	,MAX(CASE WHEN RN = 1 THEN ConGender END) AS DepGender1
	,MAX(CASE WHEN RN = 1 THEN ConDateOFBirth END) AS DepDateOFBirth1
	,MAX(CASE WHEN RN = 1 THEN ConIsDisabled END) AS DepIsDisabled1
	

	,MAX(CASE WHEN RN = 2 THEN ConRelationship END) AS ConRelationship2
	,MAX(CASE WHEN RN = 2 THEN ConSystemId END) AS ConSystemId2
	,MAX(CASE WHEN RN = 2 THEN ConNameLast END) AS DepNameLast2
	,MAX(CASE WHEN RN = 2 THEN ConNameMiddle END) AS DepNameMiddle2
	,MAX(CASE WHEN RN = 2 THEN ConNameFirst END) AS DepNameFirst2
	,MAX(CASE WHEN RN = 2 THEN ConNameSuffix END) AS DepNameSuffix2
	,MAX(CASE WHEN RN = 2 THEN ConSSN END) AS DepNameSSN2
	,MAX(CASE WHEN RN = 2 THEN ConGender END) AS DepGender2
	,MAX(CASE WHEN RN = 2 THEN ConDateOFBirth END) AS DepDateOFBirth2
	,MAX(CASE WHEN RN = 2 THEN ConIsDisabled END) AS DepIsDisabled2
	

	,MAX(CASE WHEN RN = 3 THEN ConRelationship END) AS ConRelationship3
	,MAX(CASE WHEN RN = 3 THEN ConSystemId END) AS ConSystemId3
	,MAX(CASE WHEN RN = 3 THEN ConNameLast END) AS DepNameLast3
	,MAX(CASE WHEN RN = 3 THEN ConNameMiddle END) AS DepNameMiddle3
	,MAX(CASE WHEN RN = 3 THEN ConNameFirst END) AS DepNameFirst3
	,MAX(CASE WHEN RN = 3 THEN ConNameSuffix END) AS DepNameSuffix3
	,MAX(CASE WHEN RN = 3 THEN ConSSN END) AS DepNameSSN3
	,MAX(CASE WHEN RN = 3 THEN ConGender END) AS DepGender3
	,MAX(CASE WHEN RN = 3 THEN ConDateOFBirth END) AS DepDateOFBirth3
	,MAX(CASE WHEN RN = 3 THEN ConIsDisabled END) AS DepIsDisabled3
	

	,MAX(CASE WHEN RN = 4 THEN ConRelationship END) AS ConRelationship4
	,MAX(CASE WHEN RN = 4 THEN ConSystemId END) AS ConSystemId4
	,MAX(CASE WHEN RN = 4 THEN ConNameLast END) AS DepNameLast4
	,MAX(CASE WHEN RN = 4 THEN ConNameMiddle END) AS DepNameMiddle4
	,MAX(CASE WHEN RN = 4 THEN ConNameFirst END) AS DepNameFirst4
	,MAX(CASE WHEN RN = 4 THEN ConNameSuffix END) AS DepNameSuffix4
	,MAX(CASE WHEN RN = 4 THEN ConSSN END) AS DepNameSSN4
	,MAX(CASE WHEN RN = 4 THEN ConGender END) AS DepGender4
	,MAX(CASE WHEN RN = 4 THEN ConDateOFBirth END) AS DepDateOFBirth4
	,MAX(CASE WHEN RN = 4 THEN ConIsDisabled END) AS DepIsDisabled4
	

	,MAX(CASE WHEN RN = 5 THEN ConRelationship END) AS ConRelationship5
	,MAX(CASE WHEN RN = 5 THEN ConSystemId END) AS ConSystemId5
	,MAX(CASE WHEN RN = 5 THEN ConNameLast END) AS DepNameLast5
	,MAX(CASE WHEN RN = 5 THEN ConNameMiddle END) AS DepNameMiddle5
	,MAX(CASE WHEN RN = 5 THEN ConNameFirst END) AS DepNameFirst5
	,MAX(CASE WHEN RN = 5 THEN ConNameSuffix END) AS DepNameSuffix15	
	,MAX(CASE WHEN RN = 5 THEN ConSSN END) AS DepNameSSN5
	,MAX(CASE WHEN RN = 5 THEN ConGender END) AS DepGender5
	,MAX(CASE WHEN RN = 5 THEN ConDateOFBirth END) AS DepDateOFBirth5
	,MAX(CASE WHEN RN = 5 THEN ConIsDisabled END) AS DepIsDisabled5
	

	,MAX(CASE WHEN RN = 6 THEN ConRelationship END) AS ConRelationship6
	,MAX(CASE WHEN RN = 6 THEN ConSystemId END) AS ConSystemId6
	,MAX(CASE WHEN RN = 6 THEN ConNameLast END) AS DepNameLast6
	,MAX(CASE WHEN RN = 6 THEN ConNameMiddle END) AS DepNameMiddle6
	,MAX(CASE WHEN RN = 6 THEN ConNameFirst END) AS DepNameFirst6
	,MAX(CASE WHEN RN = 6 THEN ConNameSuffix END) AS DepNameSuffix6
	,MAX(CASE WHEN RN = 6 THEN ConSSN END) AS DepNameSSN6
	,MAX(CASE WHEN RN = 6 THEN ConGender END) AS DepGender6
	,MAX(CASE WHEN RN = 6 THEN ConDateOFBirth END) AS DepDateOFBirth6
	,MAX(CASE WHEN RN = 6 THEN ConIsDisabled END) AS DepIsDisabled6
	

	,MAX(CASE WHEN RN = 7 THEN ConRelationship END) AS ConRelationship7
	,MAX(CASE WHEN RN = 7 THEN ConSystemId END) AS ConSystemId7
	,MAX(CASE WHEN RN = 7 THEN ConNameLast END) AS DepNameLast7
	,MAX(CASE WHEN RN = 7 THEN ConNameMiddle END) AS DepNameMiddle7
	,MAX(CASE WHEN RN = 7 THEN ConNameFirst END) AS DepNameFirst7
	,MAX(CASE WHEN RN = 7 THEN ConNameSuffix END) AS DepNameSuffix7
	,MAX(CASE WHEN RN = 7 THEN ConSSN END) AS DepNameSSN7
	,MAX(CASE WHEN RN = 7 THEN ConGender END) AS DepGender7
	,MAX(CASE WHEN RN = 7 THEN ConDateOFBirth END) AS DepDateOFBirth7
	,MAX(CASE WHEN RN = 7 THEN ConIsDisabled END) AS DepIsDisabled7
	

	,MAX(CASE WHEN RN = 8 THEN ConRelationship END) AS ConRelationship8
	,MAX(CASE WHEN RN = 8 THEN ConSystemId END) AS ConSystemId8
	,MAX(CASE WHEN RN = 8 THEN ConNameLast END) AS DepNameLast8
	,MAX(CASE WHEN RN = 8 THEN ConNameMiddle END) AS DepNameMiddle8
	,MAX(CASE WHEN RN = 8 THEN ConNameFirst END) AS DepNameFirst8
	,MAX(CASE WHEN RN = 8 THEN ConNameSuffix END) AS DepNameSuffix8
	,MAX(CASE WHEN RN = 8 THEN ConSSN END) AS DepNameSSN8
	,MAX(CASE WHEN RN = 8 THEN ConGender END) AS DepGender8
	,MAX(CASE WHEN RN = 8 THEN ConDateOFBirth END) AS DepDateOFBirth8
	,MAX(CASE WHEN RN = 8 THEN ConIsDisabled END) AS DepIsDisabled8
	


FROM (


		SELECT ConEEID, ConRelationship, ConSystemId, ConNameLast, ConNameMiddle, ConNameFirst, ConNameSuffix, ConSSN, ConGender, ConIsDisabled, ConDateOfBirth, ROW_NUMBER() OVER (PARTITION BY ConEEID ORDER BY CASE WHEN ConRelationship IN ('SPS','DP') THEN 1 ELSE 2 END) AS RN
		FROM dbo.Contacts WITH (NOLOCK)		
		WHERE ConIsDependent = 'Y'
			AND ConRelationship IN (/*'SPS','DP',*/'CHL','DAU','DCH','DPC','SON','STC')
			--AND ConEEID = 'CQE36S000030'


) AS X
/*JOIN dbo.U_dsi_BDM_EUNDENVISE WITH (NOLOCK)
			ON ConEEID = BdmEEID
			AND ConSystemId = BdmDepRecId*/
GROUP BY ConEEID --, BdmDedCode
order by ConEEID

--select * from Contacts where ConEEID = 'CQE36S000030'
