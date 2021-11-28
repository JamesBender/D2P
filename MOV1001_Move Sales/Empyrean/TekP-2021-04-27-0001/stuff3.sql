SELECT ActEEID, ActCOID, ActActionCode, ActActionEffDate, ActActionDesc
				FROM (
						SELECT AudEEID AS ActEEID, AudKey2 AS ActCOID, AudActionCode AS ActActionCode, audActionDesc AS ActActionDesc, AudActionEffDate AS ActActionEffDate, AudFieldName, ROW_NUMBER() OVER (PARTITION BY AudEEID, AudKey2 ORDER BY AudActionEffDate DESC) AS RN
						FROM dbo.U_EEMPYD_V3_Audit WITH (NOLOCK)
						--WHERE AudActionCode IN ('PDM11','PBIRTH','119','121','123','124','505','LTD','MAS','MFM','PADOPT','PFOSTR','PSURRO','UPBRTH','UPADPT','UPFOST','UPSURR','PERSNL','WKCOMP','PDM05','PDM610','RFL')
						--AND 
						where AudEEID = 'BRY02L00W0K0'
						and AudActionCode IS NOT NULL
						
						) AS InAct


				WHERE RN = 1 
			
select * from U_EEMPYD_V3_Mapping_Actions where actCode = '505'

SELECT  EjhReason, EjhJobEffDate, * from  EmpHJoB A where EjhEEID = 'BRY02L00W0K0'
and EjhReason in ('PDM11','PBIRTH','119','121','123','124','505','LTD','MAS','MFM','PADOPT','PFOSTR','PSURRO','UPBRTH','UPADPT','UPFOST','UPSURR','PERSNL','WKCOMP','PDM05','PDM610','RFL')
order by A.EjhJobEffDate desc

--sp_getEEID 'Hastings' -- BRY02L00W0K0

select drvActionCode 
         -- field 60                 
        ,drvActionCodeEffectiveDate 
         --field 61                                                         
        ,drvActionReasonCode 
        -- field 62                                                     
        ,drvActionReasonCodeEffectiveDate, *
from dbo.U_EEMPYD_V3_DrvTbl_D11
where drvEEID = 'BRY02L00W0K0'