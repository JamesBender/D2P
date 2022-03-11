--sp_getEEID  'Kamavarapu' -- BRJEZ500Q0K0

DECLARE @EEID VARCHAR(12) = 'BRJEZ500Q0K0'

select * from dbo.U_EEMPYDEMO_DrvTbl_D11
where drvEEID = @EEID


--SELECT ActEEID, ActCOID, ActActionCode, ActActionEffDate, ActActionDesc
  --              FROM (
                        SELECT AudEEID AS ActEEID, AudKey2 AS ActCOID, AudNewValue AS ActActionCode, actDesc AS ActActionDesc, audDateTime AS ActActionEffDate, ROW_NUMBER() OVER (PARTITION BY AudEEID, AudKey2 ORDER BY AudActionEffDate DESC) AS RN
                        FROM dbo.U_EEMPYDEMO_Audit_Action WITH (NOLOCK) 
                        JOIN U_EEMPYDEMO_Mapping_Actions WITH (NOLOCK)
                            ON actCode = audNewValue
                        --) AS InAct
where AudEEID = @EEID



                        SELECT EjhEEID, EjhCOID, EjhReason, EjhJobEffDate, ROW_NUMBER() OVER (PARTITION BY EjhEEID, EjhCOID ORDER BY EjhJobEffDate DESC) AS RN
                        FROM EmpHJob
                        WHERE --EjhReason IN ('100','101','400','401','800','TRI','TRO','200','201','CONV')
						--AND 
						EjhEEID= @EEID