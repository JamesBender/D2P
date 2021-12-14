SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvEmpNoSort = EecEmpNo + ' ' + FORMAT(RN, '00')        -- standard fields above and additional driver fields below
        ,drvExternalID = RTRIM(EecEmpNo) + FORMAT(RN, '00')
        ,drvNameFirst = ConNameFirst
        ,drvNameMiddle = CASE WHEN ConNameMiddle is not null THEN LEFT(ConNameMiddle,1) END
        ,drvNameLast = ConNameLast 
        ,drvDOB = ConDateOfBirth
        ,drvGender =	CASE WHEN ConGender = 'M' THEN 'M'
                        WHEN ConGender = 'F' THEN 'F'
                        ELSE 'O'
                        END
        ,drvMemberType = CASE WHEN ConRelationship IN ('CHL','STC') THEN 'Child'
                                        WHEN ConRelationship IN ('SPS') THEN 'Spouse'
                                    END
        ,drvSubscriberID = RTRIM(EecEmpNo) + '01'
        ,drvEffectiveDate =DATEADD(MONTH, DATEDIFF(MONTH, 0, bdmBenStartDate), 0)
        ,drvTermDate =  [dbo].[dsi_fnlib_GetLastofCurrMonth](BdmBenStopDate)
        ,drvMobilePhone = CASE WHEN efoPhoneType = 'CEL' THEN CONCAT('1',efoPhoneNumber) END
        ,drvHomePhone = LEFT(EepPhoneHomeNumber, 3) + '-' + RIGHT(LEFT(EepPhoneHomeNumber, 6), 3) + '-' + RIGHT(EepPhoneHomeNumber, 4)
        ,drvWorkPhone = EecPhoneBusinessNumber
        ,drvAddress1 = ConAddressLine1
        ,drvAddress2 = REPLACE(ISNULL(ConAddressLine2, ''), '  ', '') 
        ,drvCity = ConAddressCity
        ,drvState = ConAddressState
        ,drvZip = ConAddressZipCode

	FROM dbo.U_EBADUCM_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
                   And (eecemplstatus <> 'T' OR (eecemplstatus = 'T' and eectermreason <> 'TRO'
          and EXISTS (Select 1 from dbo.U_EBADUCM_Audit where audEEID = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN dbo.EmpMPhon WITH (NOLOCK)
        ON efoEEID = xEEID
    LEFT JOIN dbo.U_dsi_BDM_EBADUCM WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
JOIN (SELECT DISTINCT ConEEID, ConRelationship, ConNameFirst, ConNameLast, ConNameMiddle, ConDateOfBirth, ConGender, ConAddressLine1, ConAddressLine2, ConAddressCity, ConAddressState, ConAddressZipCode, RN
FROM (
	SELECT DISTINCT ConEEID, ConRelationship, ConNameFirst, ConNameLast, ConNameMiddle, ConDateOfBirth, ConGender, ConAddressLine1, ConAddressLine2, ConAddressCity, ConAddressState, ConAddressZipCode, 2 AS RN
	FROM dbo.Contacts WITH (NOLOCK)
	WHERE ConIsActive = 'Y'
	AND ConRelationship = 'SPS'
	UNION
	SELECT DISTINCT ConEEID, ConRelationship, ConNameFirst, ConNameLast, ConNameMiddle, ConDateOfBirth, ConGender, ConAddressLine1, ConAddressLine2, ConAddressCity, ConAddressState, ConAddressZipCode, ROW_NUMBER() OVER (PARTITION BY ConEEID ORDER By ConDateOfBirth DESC)+2 AS RN
	FROM (
		SELECT DISTINCT ConEEID, ConRelationship, ConNameFirst, ConNameLast, ConNameMiddle, ConDateOfBirth, ConGender, ConAddressLine1, ConAddressLine2, ConAddressCity, ConAddressState, ConAddressZipCode
		FROM dbo.Contacts WITH (NOLOCK)
		WHERE ConIsActive = 'Y'
		AND ConRelationship IN ('CHL','STC')) AS CHLD) AS Con
--ORDER BY Con.ConEEID, Con.RN
) AS AllCon
	ON xEEID = ConEEID



	/* ADMYCL00W0K0	IAGFG	1	010212    02	01021202	Robert	NULL	Powell
ADMYCL00W0K0	IAGFG	1	010212    02	01021202	Robert	R	Powell */