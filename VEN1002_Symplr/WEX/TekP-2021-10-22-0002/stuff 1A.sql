
select distinct CASE WHEN EdhChangeReason IN ('204','LEVNT4') THEN 'DIVORCELEGALSEPARATION'
                        WHEN EecEmplStatus = 'T' AND EecTermReason = '203' THEN 'DEATH'
						WHEN EecEmplStatus = 'T' AND EecTermReason NOT IN ('202','203') AND EecTermType IN ('V','R') THEN 'TERMINATION'
						WHEN EecEmplStatus = 'T' AND EecTermReason <> '203' and EecTermType IN ('I','N') THEN 'INVOLUNTARYTERMINATION'
                        WHEN EdhChangeReason = '205' THEN 'MEDICARE'
                        WHEN EdhChangeReason IN ('201','LEVNT3') THEN 'INELIGIBLEDEPENDENT'
                        WHEN EdhChangeReason = '208' OR (EecEmplStatus = 'T' AND EecTermReason = '202') THEN 'RETIREMENT'
                        WHEN EdhChangeReason IN ('203','202') THEN 'REDUCTIONINHOURS-STATUSCHANGE'
                        WHEN EdhChangeReason = '206' THEN 'REDUCTIONINHOURS-ENDOFLEAVE'
                        END
						,CASE WHEN EdhChangeReason IN ('201','210','LEVNT3','204','LEVNT4') THEN EdhEffDate ELSE EecDateOfTermination END
						,BdmBenStartDate
FROM dbo.U_EWEXCBREXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EWEXCBREXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRunId = 'QB'
		AND BdmIsPQB = 'Y'
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    LEFT JOIN (
                SELECT EdhEEID, EdhCOID, /*EdhDedCode,*/ MAX(EdhEffDate) AS EdhEffDate, MAX(EdhChangeReason) AS EdhChangeReason, MAX(BchIsCobraQualifiedEvent) AS BchIsCobraQualifiedEvent
                FROM (
                    SELECT EdhEEID, EdhCOID, EdhDedCode, EdhEffDate,edhChangeReason,  BchIsCobraQualifiedEvent, ROW_NUMBER() OVER (PARTITION by EdhEEID, EdhCOID, EdhDedCode ORDER BY EdhDateTimeCreated desc) AS RN
                    FROM dbo.EmpHDed WITH (NOLOCK)
                    JOIN dbo.BenChRsn WITH (NOLOCK)
                        ON EdhChangeReason = BchCode
                    WHERE --EdhDedCode IN ('DEN','FSA','MHSA','MHSA2','GLIFE','GLBD','GLEXC','GLMAX','LIFEE','LIFES','LIFEC','MPPO','VIS','MINT') 
                        --AND (edhChangeReason IN ('200','BAP','D','DLS','M','NLEE','NLEDR','TOE','LEVNT1','LEVNT2','LEVNT3','LEVNT4','LEVNT5','LWOB', 'NLED') OR 
                        BchIsCobraQualifiedEvent = 'Y'
                        --)
                    ) AS XX
            WHERE RN = 1
            --AND EdhEEID = 'AMWC7N0000K0'
            GROUP BY EdhEEID, EdhCoID) AS Edh
        ON EdhEEID = xEEID
        AND EdhCOID = xCOID
where xEEID = 'CTK36Y000030'

select BdmBenStartDate, * from dbo.U_dsi_BDM_EWEXCBREXP A WITH (NOLOCK) where BdmEEID = 'CTK36Y000030' AND BdmRunId = 'QB' -- 32
		AND BdmIsPQB = 'Y'
		order by A.BdmBenStartDate desc