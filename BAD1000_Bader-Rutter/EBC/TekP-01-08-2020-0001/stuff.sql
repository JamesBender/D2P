SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort1 = xEEID
        ,drvSort2 = 3
        ,drvSort3 = '' --BdmDedCode
        ,drvSort4 = 1
        -- standard fields above and additional driver fields below
        ,drvEventType = CASE WHEN EecEmplStatus = 'A' AND ConCOBRAReason IN ('204', 'LEVNT4') THEN 'DIVORCELEGALSEPARATION' 
                            WHEN EecEmplStatus = 'T' AND EecTermReason = '210' THEN 'DEATH'
                            WHEN EecEmplStatus = 'A' AND ConCOBRAReason IN ('201', 'LEVNT3') THEN 'INELIGIBLEDEPENDENT'
                            WHEN EecEmplStatus = 'A' AND EepCOBRAReason = '205' THEN 'MEDICARE'
                            WHEN EecEmplStatus = 'T' AND EecTermReason = '200' THEN 'TERMINATION'
                            WHEN EecEmplStatus = 'A' AND EepCOBRAReason = '203' THEN 'REDUCTIONINHOURS-STATUSCHANGE'
                            WHEN EecEmplStatus = 'A' AND EepCOBRAReason = '206' THEN 'REDUCTIONINHOURS-ENDOFLEAVE'
                            WHEN EecEmplStatus = 'T' AND EecTermReason NOT IN ('200', '210') THEN 'TERMINATION'
                        END
        ,drvEventDate = CASE WHEN EdhChangeReason IN ('LEVNT4', '204', '210', '201') THEN ConDateOfCOBRAEvent
                            ELSE BdmDateOfCOBRAEvent 
                        END
        ,drvEnrollmentDate = BdmBEnStartDate	
        ,drvEmployeeSsn =    CASE WHEN EdhChangeReason IN ('LEVNT4', '204', '210', '201') THEN eepSSN END
        ,drvEmployeeName =    CASE WHEN EdhChangeReason IN ('LEVNT4', '204', '210', '201') THEN EepNameFirst + ' ' + EepNameLast END
		,drvStop = '***'
		--,drvBenCode = BdmDedCode
    FROM dbo.U_EEBCOBRAQB_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.U_dsi_BDM_EEBCOBRAQB WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecId
    JOIN dbo.U_EEBCOBRAQB_Edh_WorkingTable a
        ON EdhEEID = xEEID
        AND EdhCOID = xCOID
        AND EdhDedCode = BdmDedCode
    WHERE EdhChangeReason IN ('204', 'LEVNT4', '210', '201', '205', '200', '203', '206') and xEEID = 'ADMYKY03I0K0'