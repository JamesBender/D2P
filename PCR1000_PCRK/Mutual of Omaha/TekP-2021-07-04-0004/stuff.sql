--sp_getEEID 'Crenshaw' -- DNEAQT01DRX0

DECLARE @EEID VARCHAR(12) = 'DNEAQT01DRX0'

--SELECT * FROM dbo.U_EMOOSVAEXP_drvTbl WHERE drvEEID = @EEID

--SELECT * FROM dbo.U_dsi_BDM_EMOOSVAEXP WITH (NOLOCK) WHERE BdmEEID = @EEID

--SELECT * FROM dbo.U_EMOOSVAEXP_Audit WHERE audEEID = @EEID

--SELECT * FROM EmpDed WHERE EedEEID = @EEID AND EedDedCode = 'VLIFE'

--IF OBJECT_ID('#JCbAudTemp','U') IS NOT NULL
        DROP TABLE dbo.#JCbAudTemp

SELECT  audEEID  = audKey1Value
				,audCOID = audKey2Value
				,audKey3 = audKey3Value
				,audTableName
				,audFieldName
				,audAction
				,audDateTime
				,audOldValue 
				,audNewValue
		INTO #JCbAudTemp
		from dbo.vw_AuditData WITH (NOLOCK) 
		JOIN dbo.U_EMOOSVAEXP_AuditFields WITH (NOLOCK) 
				ON audTableName = aTableName
				AND audFieldName = aFieldName
		WHERE audKey1Value = @EEID
		AND audAction <> 'DELETE'

SELECT * from #JCbAudTemp


SELECT  audEEID 
        ,audCOID
        ,audKey3
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,AudOldValue
        ,AudNewValue
		,audRowNo = ROW_NUMBER() OVER (PARTITION BY audEEID, audCOID, audKey3, audFieldName ORDER BY audDateTime DESC)
FROM #JCbAudTemp
WHERE AudNewValue = 'T' 
--AND audOldValue = 'W'