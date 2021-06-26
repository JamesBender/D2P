select Bdm.*
FROM dbo.U_EBAPCQBEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.U_dsi_BDM_EBAPCQBEXP Bdm WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    /*LEFT JOIN (
            SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, EdhBenOption, BchIsCobraQualifiedEvent 
            FROM (
                    SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, EdhBenOption, BchIsCobraQualifiedEvent, ROW_NUMBER() OVER (PARTITION by EdhEEID, EdhCOID ORDER BY EdhEffDate desc) AS RN
                    FROM dbo.EmpHDed a WITH (NOLOCK)
                    JOIN dbo.BenChRsn WITH (NOLOCK)
                        ON EdhChangeReason = BchCode
                    WHERE EdhDedCode IN ('ANPPO','APPPT','ANHD','AHPT','DEN','DENA','PTDD','DENPA','KPHMO','PTKP','FSA19','LPF19','LPT19','VSPER') 
                        AND edhChangeReason IN ('208','204','LEVNT4','205','201','302','LEVNT3', '203','202','206','200')
                ) AS X
            WHERE RN = 1) AS Edh
        ON EdhEEID = xEEID
        AND EdhCoID = xCOID*/
where xEEID = '7WCM7O0010K0'
    ;



	select * from dbo.U_dsi_BDM_EBAPCQBEXP Bdm WITH (NOLOCK) where BdmEEID = '7WCM7O0010K0'
	select * from dbo.U_dsi_BDM_EBAPCQBEXP Bdm WITH (NOLOCK) where BdmDedCode = 'ANNPO'

	select EedCobraReason, * from dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK) where EedFormatCode = 'EBAPCQBEXP' AND EedEEID = '7WCM7O0010K0'

select  EedDedCode, EedBenStopDate, * from EmpDed A where EedEEID = '7WCM7O0010K0' AND EedDedCode IN ('ANPPO','DEN','VSPER') order by A.EedDEdCode

--select * from DedCode where DedDedCode = 'ANPPO'

--select * from EmpDed where EedEEID = '7WCM7O0010K0' AND EedDedCode IN ('ANPPO','DEN','VSPER')



SELECT  EdhEEID, EdhCOID, EdhDedCode, EdhEffDate,edhChangeReason, EdhBenOption, BchIsCobraQualifiedEvent, ROW_NUMBER() OVER (PARTITION by EdhEEID, EdhCOID ORDER BY EdhEffDate desc) AS RN
                    FROM dbo.EmpHDed a WITH (NOLOCK)
                    JOIN dbo.BenChRsn WITH (NOLOCK)
                        ON EdhChangeReason = BchCode
                    WHERE EdhDedCode IN ('ANPPO','APPPT','ANHD','AHPT','DEN','DENA','PTDD','DENPA','KPHMO','PTKP','FSA19','LPF19','LPT19','VSPER') 
                        AND edhChangeReason IN ('208','204','LEVNT4','205','201','302','LEVNT3', '203','202','206','200')
						AND EdhEEID = '7WCM7O0010K0'