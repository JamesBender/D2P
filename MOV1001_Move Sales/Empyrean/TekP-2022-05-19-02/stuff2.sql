DECLARE @EEID VARCHAR(12) = 'EBKR7U000020'

SELECT  CASE 
            WHEN (EecEmplStatus = 'T' AND AudFieldName IN ('EjhEmplStatus', 'EecEmplStatus') AND AudNewValue = 'T') OR (AudFieldName = 'EecFullTimeOrPartTime' AND audOldValue = 'F' AND audNewValue = 'P') THEN '800 - 1'
            WHEN AudFieldName = 'EjhFullTimeOrPartTime' AND audNewValue = 'P' AND EXISTS 
                (SELECT 1 FROM dbo.U_EEMPYDEMO_Audit a2 WHERE a2.audEEID = aud.audEEID AND a2.audKey2 = aud.audKey2 AND a2.audFieldName = 'EecFullTimeOrPartTime' AND a2.audOldValue = 'F' AND a2.audNewValue = 'P') THEN '800 - 2'
            WHEN AudFieldName IN ('EjhReason', 'EecJobChangeReason') AND AudNewValue IN (SELECT ActCode FROM [dbo].[U_EEMPYDEMO_Mapping_Actions]) THEN audNewValue
            WHEN audFieldName = 'EecLeaveReason' AND audNewValue IN (SELECT ActCode FROM [dbo].[U_EEMPYDEMO_Mapping_Actions]) THEN audNewValue
            WHEN audTableName = 'EmpPers' THEN 'ADDR'
            WHEN audFieldName = 'EecStateSUI' THEN 'LOC'
        END as ActCode
		,' ' AS ColZ
		,EecEmplStatus
		,AudFieldName
		,AudNewValue
		,audOldValue
		,' ' AS Col1, Aud.*
FROM dbo.U_EEMPYDEMO_Audit Aud
    INNER JOIN dbo.vw_int_EmpComp Ec
        ON AudEEID = EecEEID
        AND AudKey2 = EecCoID
where EecEEID = @EEID
AND (CASE 
            WHEN (EecEmplStatus = 'T' AND AudFieldName IN ('EjhEmplStatus', 'EecEmplStatus') AND AudNewValue = 'T') OR (AudFieldName = 'EecFullTimeOrPartTime' AND audOldValue = 'F' AND audNewValue = 'P') THEN '800 - 1'
            WHEN AudFieldName = 'EjhFullTimeOrPartTime' AND audNewValue = 'P' AND EXISTS 
                (SELECT 1 FROM dbo.U_EEMPYDEMO_Audit a2 WHERE a2.audEEID = aud.audEEID AND a2.audKey2 = aud.audKey2 AND a2.audFieldName = 'EecFullTimeOrPartTime' AND a2.audOldValue = 'F' AND a2.audNewValue = 'P') THEN '800 - 2'
            WHEN AudFieldName IN ('EjhReason', 'EecJobChangeReason') AND AudNewValue IN (SELECT ActCode FROM [dbo].[U_EEMPYDEMO_Mapping_Actions]) THEN audNewValue
            WHEN audFieldName = 'EecLeaveReason' AND audNewValue IN (SELECT ActCode FROM [dbo].[U_EEMPYDEMO_Mapping_Actions]) THEN audNewValue
            WHEN audTableName = 'EmpPers' THEN 'ADDR'
            WHEN audFieldName = 'EecStateSUI' THEN 'LOC'
        END) LIKE '800%'

SELECT TOP 1 * FROM dbo.U_EEMPYDEMO_Audit a2 WHERE a2.audEEID = @EEID AND a2.audFieldName = 'EecFullTimeOrPartTime' AND a2.audOldValue = 'F' AND a2.audNewValue = 'P'

SELECT * FROM dbo.U_EEMPYDEMO_Audit a2 WHERE a2.audEEID = @EEID AND a2.audFieldName = 'EecFullTimeOrPartTime' --AND a2.audOldValue = 'F' AND a2.audNewValue = 'P'
