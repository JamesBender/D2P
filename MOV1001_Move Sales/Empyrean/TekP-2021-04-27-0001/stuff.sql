--sp_getEEID 'Donnelly' -- DVO0TI001020
--sp_getEEID 'Crennan' -- BVJKJ10010K0
--sp_getEEID 'Abel' -- CUMEGU000020
--sp_getEEID 'McEachern' -- BRJELH0100K0
--sp_getEEID 'Kamavarapu'
--sp_getEEID 'Burguillo'
--sp_getEEID 'Weaver' -- DUUC5Y000020



select drvActionCode, drvActionCodeEffectiveDate,drvActionReasonCode, drvActionReasonCodeEffectiveDate, * from dbo.U_EEMPYD_V3_DrvTbl_D11
--where drvEEID IN ('BRJEZ500Q0K0','DUUCI5000020')
--where drvEEID = 'BVJKJ10010K0'
--where drvEEID = 'CUMEGU000020'
--where drvEEID IN ('BRJELH0100K0','DVO0TI001020','BVJKJ10010K0','CUMEGU000020','BRJEZ500Q0K0','DUUCI5000020')
where drvEEID = 'DUUC5Y000020'



select * from dbo.U_EEMPYD_V3_Audit WITH (NOLOCK)

--select * from U_EEMPYD_V3_Mapping_Actions

--SELECT ActEEID, ActCOID, ActActionCode, ActActionEffDate
--FROM (
		SELECT AudEEID AS ActEEID, AudKey2 AS ActCOID, AudActionCode AS ActActionCode, AudActionEffDate AS ActActionEffDate, ROW_NUMBER() OVER (PARTITION BY AudEEID, AudKey2 ORDER BY AudActionEffDate DESC) AS RN
		FROM dbo.U_EEMPYD_V3_Audit WITH (NOLOCK)
		WHERE --AudActionCode IN ('PDM11','PBIRTH','119','121','123','124','LTD','MAS','MFM','PADOPT','PFOSTR','PSURRO','UPBRTH','UPADPT','UPFOST','UPSURR','PERSNL','WKCOMP','PDM05','PDM610','RFL')
		--AND 
		audEEID  = 'DUUC5Y000020'
		--) AS InAct
--WHERE RN = 1


--AND 
--audEEID = 'BRJELH0100K0'

/*


SELECT EjhEEID, EjhCOID, EjhReason, EjhJobEffDate, ROW_NUMBER() OVER (PARTITION BY EjhEEID, EjhCOID ORDER BY EjhJobEffDate DESC) AS RN
		FROM EmpHJob
		WHERE --EjhReason IN ('100','101','400','401','505','800','TRI','TRO')
		--AND 
		EjhEEID = 'BRJELH0100K0'
*/


		SELECT EjhEEID AS OEjhEEID, EjhCOID AS OEjhCOID, EjhReason AS OEjhReason, EjhJobEffDate AS OEjhJobEffDate
				FROM (
						SELECT EjhEEID, EjhCOID, EjhReason, EjhJobEffDate, ROW_NUMBER() OVER (PARTITION BY EjhEEID, EjhCOID ORDER BY EjhJobEffDate DESC) AS RN
						FROM EmpHJob
						--WHERE EjhReason IN ('100','101','400','401','800','TRI','TRO')
						) AS EjhList
				WHERE RN = 1
				AND EjhEEID = 'DUUC5Y000020'


				Select * from EmpComp where EecEEID = 'DUUC5Y000020'








/*
SELECT EjhEEID, EjhCOID, EjhReason, EjhJobEffDate
FROM (
		SELECT EjhEEID, EjhCOID, EjhReason, EjhJobEffDate, ROW_NUMBER() OVER (PARTITION BY EjhEEID, EjhCOID ORDER BY EjhJobEffDate DESC) AS RN
		FROM EmpHJob
		WHERE EjhReason IN ('100','101','400','401','800','TRI','TRO')) AS EjhList
WHERE RN = 1

*/
