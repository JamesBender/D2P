    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = PgpPayGroup -- LEFT(CAST(PehCurHrsYTD AS VARCHAR), LEN(CAST(PehCurHrsYTD AS VARCHAR)) - 7)
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvDivisionNumber = CASE WHEN EecSalaryOrHourly = 'S' THEN 'D1' ELSE 'D2' END
        ,drvNameLast = EepNameLast
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddle = EepNameMiddle
        ,drvDateOfBirth = EepDateOfBirth
        ,drvGender = EepGender
        ,drvMaritalStatus = CASE WHEN ISNULL(eepMaritalStatus, '') = ''  OR EepMaritalStatus = 'Z' THEN 'S' ELSE eepMaritalStatus END
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvPhoneHomeNumber = EepPhoneHomeNumber
        ,drvPhoneWorkNumber = EecPhoneBusinessNumber
        ,drvHireDate = EecDateOfOriginalHire
        ,drvTerminationDate =	CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination 
									WHEN EecEmplStatus = 'A' AND EecDateOfOriginalHire <> EecDateOfLastHire THEN PtdOldValue --EshStatusStopDate-- PreviousTermDate
								END
        ,drvRehireDate = CASE WHEN EecDateOfLastHire <> EecDateOfOriginalHire THEN  EecDateOfLastHire END
        ,drvCheckDate = CASE WHEN PrgPayDate IS NOT NULL THEN
                            CASE WHEN CONVERT(DATE, PayGroupDate) > PrgPayDate THEN CONVERT(DATE, PayGroupDate) ELSE PrgPayDate END
                            ELSE CONVERT(DATE, PayGroupDate)
                        END
        ,drvPreTax = RIGHT(SPACE(10) + FORMAT(PdhPreTax, '#0.00'), 10)
        ,drvSafeHarborMatch = RIGHT(SPACE(10) + FORMAT(PdhSafeHarborMatch, '#0.00'), 10)
        ,drvLoans = RIGHT(SPACE(10) + FORMAT(PdhLoans, '#0.00'), 10)
        ,drvRoth = RIGHT(SPACE(10) + FORMAT(PdhRoth, '#0.00'), 10)
        ,drvHoursWorked = RIGHT(SPACE(5) + LEFT(CAST(PehCurHrsYTD AS VARCHAR), LEN(CAST(PehCurHrsYTD AS VARCHAR)) - 7), 5)
        ,drvYtdTotalCompensation = RIGHT(SPACE(11) + FORMAT(PehCurAmtYTD, '#0.00'), 11)
        ,drvYtdPlanCompensation = RIGHT(SPACE(11) + FORMAT(PehCurAmtYTD, '#0.00'), 11)
        ,drvWorkEmailAddress = EepAddressEMail
        ,drvSalaryAmount = RIGHT(SPACE(17) + FORMAT(EecAnnSalary, '#0.00'), 17)
        ,drvTermReasonCode =	CASE WHEN EecEmplStatus = 'T' AND EecTermReason = '203' THEN 'DE' 
									WHEN EecEmplStatus = 'T' AND EecTermReason = '202' THEN 'R'
									WHEN EecEmplStatus = 'T' AND EecTermReason NOT IN ('202','203') THEN 'S'  
								END
        ,drvEmpAssignedId = EecEmpNo

FROM dbo.U_EEMPOW401K_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN dbo.U_dsi_BDM_EEMPOW401K WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
	JOIN dbo.U_EEMPOW401K_PEarHist WITH (NOLOCK)
		ON PehEEID = xEEID
	LEFT JOIN dbo.U_EEMPOW401K_PDedHist WITH (NOLOCK)
		ON PdhEEID = xEEID
	JOIN (
			SELECT PrgEEID, PrgCOID, PrgPerControl, PrgPayGroup
			FROM dbo.PayReg WITH (NOLOCK)
			WHERE PrgPerControl BETWEEN '202005221' AND '202005229'
		) AS Peg_Reg
		ON PrgEEID = xEEID
		AND PrgCOID = xCOID 
	LEFT JOIN (
                SELECT audEEID AS PtdEEID, audKey2 as PtdCOID, audOldValue AS PtdOldValue
                FROM (
                    SELECT   audEEID = audKey1Value 
                            ,audKey2 = audKey2Value
                            ,audKey3 = audKey3Value
                            ,audTableName
                            ,audFieldName
                            ,audAction
                            ,audDateTime
                            ,audOldValue
                            ,audNewValue
                            ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    
                        FROM dbo.vw_AuditData WITH (NOLOCK)
                        WHERE 
                        audTableName = 'EmpComp'
                        AND audFieldName = 'EecDateOfTermination'
                        AND AudKey1Value IN (SELECT DISTINCT xEEID FROM dbo.U_EEMPOW401K_EEList WITH (NOLOCK))) AS T 
                where audRowNo = 1) AS Prev_Term
        ON PtdEEID = xEEID
        AND PtdCOID = xCOID
	JOIN (
            SELECT PgpPayGroup, LEFT(MAX(PgpPeriodControl),8) as PayGroupDate, MAX(PgpPeriodStartDate) PrgPeriodStart, MAX(PgpPeriodEndDate) PrgPeriodEnd 
                   FROM dbo.PgPayPer WITH (NOLOCK)
                   WHERE PgpPeriodControl BETWEEN '202005221' AND '202005229'
                   AND PgpPeriodType = 'R'
                   GROUP BY PgpPayGroup
                   ) AS Pay_Group_Dates
        --ON EecPayGroup = PgpPayGroup
		ON PrgPayGroup = PgpPayGroup
	Where (EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND EecDateOfTermination >= DATEADD(DAY, -30, '5/22/2020')))
		--AND PrgPayGroup IN (select SelectValue from U_dsi_SelectByList_v2 WHERE slvFormatCode = 'EEMPOW401K')
		and xEEID = 'CEN29Z0000K0'
    ;