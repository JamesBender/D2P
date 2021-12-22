--sp_getEEID 'Franks-Bamberg' -- DD7050000020


select drvActionCode, * from dbo.U_EEMPYDEMO_DrvTbl_D11
where drvEEID = 'DD7050000020'

SELECT audEEID AS TermEEID, AudKey2 AS TermCOID, audActionCode AS TermActionCode, AudActionDesc AS TermActionDesc, audActionEffDate AS TermActionEffDate 
FROM dbo.U_EEMPYDEMO_Audit WITH (NOLOCK)
WHERE audActionCode = '800'
AND audActionEffDate IS NOT NULL
AND audEEID = 'DD7050000020'

SELECT ActEEID, ActCOID, ActActionCode, ActActionEffDate, ActActionDesc
                FROM (
                        SELECT AudEEID AS ActEEID, AudKey2 AS ActCOID, AudNewValue AS ActActionCode, actDesc AS ActActionDesc, audDateTime AS ActActionEffDate, ROW_NUMBER() OVER (PARTITION BY AudEEID, AudKey2 ORDER BY AudActionEffDate DESC) AS RN
                        FROM dbo.U_EEMPYDEMO_Audit_Action WITH (NOLOCK) 
                        JOIN U_EEMPYDEMO_Mapping_Actions WITH (NOLOCK)
                            ON actCode = audNewValue
                        ) AS InAct
                WHERE RN = 1
				and ActEEID = 'DD7050000020'

SELECT EjhEEID AS OEjhEEID, EjhCOID AS OEjhCOID, EjhReason AS OEjhReason, EjhJobEffDate AS OEjhJobEffDate
                FROM (
                        SELECT EjhEEID, EjhCOID, EjhReason, EjhJobEffDate, ROW_NUMBER() OVER (PARTITION BY EjhEEID, EjhCOID ORDER BY EjhJobEffDate DESC) AS RN
                        FROM EmpHJob
                        WHERE EjhReason IN ('100','101','400','401','800','TRI','TRO')) AS EjhList
                WHERE RN = 1
				AND EjhEEID = 'DD7050000020'

