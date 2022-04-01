select distinct xEEID, BdmDedCode, BdmBenOption, ObOldBenOption, ObSource, BdmBenStartDate, BdmStopDate, BdmBenStatus, BdmRecType
FROM dbo.U_EIWABNKMED_EELIST WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.U_dsi_bdm_EIWABNKMED WITH (NOLOCK)
        ON BdmEEID = xEEID
        AND BdmCOID = xCOID
		--AND BdmBenStatus = 'A'
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
    /*LEFT JOIN (
                SELECT AudEEID, AudKey2 AS AudCOID, AudKey3 AS AudDedCode, AudOldValue AS OldBenOption, AudNewValue AS NewBenOption
                FROM dbo.U_EIWABNKMED_Audit
                WHERE audTableName = 'EmpDed'
                    AND audFieldName = 'EedBenOption'
                    AND audAction = 'Update'
                    AND AudRowNo = 1
                    --AND AudOldValue NOT IN ('Z')
                    --AND AudNewValue NOT IN ('Z')
            ) AS Old_Ben_Option
        ON AudEEID = xEEID
        AND AudCOID = xCOID
        AND AudDedCode = BdmDedCode*/
	LEFT JOIN dbo.U_EIWABNKMED_OldBenOptions WITH (NOLOCK)
		ON ObEEID = xEEID
		AND ObCOID = xCOID
		AND ObDedCode = BdmDedCode
	--where xEEID = 'CY331U000030' -- 
	where xEEID = 'COCIET043030'
	OR xEEID = 'CY331U000030' -- 
	--where xEEID IN ('COCIED03Z030','COCIET043030','COCIGW01I030')

--sp_getEEID 'Smits'