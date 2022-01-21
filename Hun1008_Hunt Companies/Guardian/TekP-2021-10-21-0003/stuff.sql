SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvNameFirst = EepNameFirst
        ,drvNameLast = EepNameLast
        ,drvAddressEmail = EepAddressEMail
        ,drvDateOfBirth = EepDateOfBirth
        ,drvSSN = eepSSN
        ,drvEmployeeID = EecEmpNo
        ,drvPhoneHomNumber = EepPhoneHomeNumber
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressCountry = EepAddressCountry
        ,drvAddressZipCode = EepAddressZipCode
        ,drvSexAssignedAtBirth = CASE WHEN EepGender IN ('M','F') THEN EepGender ELSE 'U' END
        ,drvSpouseNameFirst = ConNameFirst
        ,drvSpouseNameLast = ConNameLast
        ,drvSpouseEmail = ConEmailAddr
        ,drvSpouseSSN = ConSSN
        ,drvSpouseSexAssignedAtBirth = CASE WHEN ConGender IN ('M','F') THEN ConGender ELSE 'U' END
        ,drvSpouseDateOfBirth = ConDateOfBirth
/*        ,drvPreimumAmount = BdmEEAmt
        ,drvPermiumIndicator =	CASE WHEN EecPayGroup IN ('AILLC','MIWHI') THEN 'M'
								WHEN EecPayGroup IN ('BANK','CAZCR','CGLFM','CGLMS','HBC2','HBROK','HCBS','HCM','HCP','HCSS','HDG','HFLY','HMHSS','NR') THEN 'B'
								END
        ,drvPermiumEffectiveDate = dbo.dsi_fnGetMinMaxDates('MAX',DATEADD(MONTH, DATEDIFF(MONTH, -1, DATEADD(DAY, 30, BdmBenStartDate)), 0), '1/1/2022')
        ,drvMemberStatus =	CASE EecEmplStatus
								WHEN 'A' THEN 'A'
								WHEN 'L' THEN 'L'
								WHEN 'T' THEN 'T'
								ELSE 'C'
							END
        ,drvDateOfChange =	CASE WHEN DATEPART(DAY, EecEmplStatusStartDate) BETWEEN 1 AND 14 AND EecEmplStatus IN ('A','T','L') THEN DATEADD(month, DATEDIFF(MONTH, 0, GETDATE()), 0)
							ELSE DATEADD(DAY, 1, EOMONTH(GETDATE()))
							END*/
    FROM dbo.U_EGUACANEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
--    JOIN dbo.U_dsi_BDM_EGUACANEXP WITH (NOLOCK)
--        ON BdmEEID = xEEID 
--        AND BdmCoID = xCoID
	LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = 'D91053000030' -- BdmDepRecID
		AND ConRelationship IN ('SPS','DP')
	WHERE xEEID = 'ALKNEK00T0K0'
    ;