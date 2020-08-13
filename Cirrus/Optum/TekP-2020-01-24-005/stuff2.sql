SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent, ROW_NUMBER() OVER (PARTITION by EdhEEID, EdhCOID ORDER BY EdhEffDate desc) AS RN
                    FROM dbo.EmpHDed a WITH (NOLOCK)
                    JOIN dbo.BenChRsn WITH (NOLOCK)
                        ON EdhChangeReason = BchCode
                    WHERE EdhDedCode IN ('DEN','FSA','MHSA','MHSA2','GLIFE','GLBD','GLEXC','GLMAX','LIFEE','LIFES','LIFEC','MPPO','VIS','MINT') 
                        AND edhChangeReason IN ('200','BAP','D','DLS','M','NLEE','NLEDR','TOE','LEVNT1','LEVNT2','LEVNT3','LEVNT4','LEVNT5','LWOB')
						--AND EdhEEID = 'CBWSFL0010K0'
						AND EdhEEID IN ('AMWDES0000K0', 'AMWDOO0000K0')




select EdhBenStopDAte, *
 FROM dbo.EmpHDed a WITH (NOLOCK)
 WHERE EdhDedCode IN ('DEN','FSA','MHSA','MHSA2','GLIFE','GLBD','GLEXC','GLMAX','LIFEE','LIFES','LIFEC','MPPO','VIS','MINT') 
                        AND edhChangeReason IN ('200','BAP','D','DLS','M','NLEE','NLEDR','TOE','LEVNT1','LEVNT2','LEVNT3','LEVNT4','LEVNT5','LWOB')
						--AND EdhEEID = 'CBWSFL0010K0'
						AND EdhEEID IN ('AMWDES0000K0', 'AMWDOO0000K0')

--select top 100 ConDateOfCobraEvent, * from Contacts where ConDateOfCobraEvent is not null and ConDateOfCobraEvent > '1/1/1970' --where ConCobraReason is not null AND ConCobraReason <> '' AND ConCobraReason <> 'Z'