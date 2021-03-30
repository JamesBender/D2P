select * from dbo.U_dsi_BDM_EBVLADDEXP WITH (NOLOCK)
where BdmEEID = 'CR6LWP03A030'
AND BdmDedCode NOT IN ('VLE','VLS','VLC','VADD')

--VLE, VLS, VLC, VADD, 
select * from dbo.U_EBVLADDEXP_drvTbl
where drvEEID = 'CR6LWP03A030'

--select * from dbo.U_EBVLADDEXP_Audit

SELECT * FROM (
SELECT BdmEEID, BdmCOID
	,MAX(CASE WHEN BdmDedCode = 'GTL1' THEN BdmDedCode END) AS GTL1_DedCode
	,MAX(CASE WHEN BdmDedCode = 'GTL2' THEN BdmDedCode END) AS GTL2_DedCode
	,MAX(CASE WHEN BdmDedCode = 'GTL3' THEN BdmDedCode END) AS GTL3_DedCode
	,MAX(CASE WHEN BdmDedCode = 'GTL4' THEN BdmDedCode END) AS GTL4_DedCode
	,MAX(CASE WHEN BdmDedCode = 'GTLP' THEN BdmDedCode END) AS GTLP_DedCode
	,MAX(CASE WHEN BdmDedCode = 'LTD10' THEN BdmDedCode END) AS LTD10_DedCode
	,MAX(CASE WHEN BdmDedCode = 'LTD20' THEN BdmDedCode END) AS LTD20_DedCode
	,MAX(CASE WHEN BdmDedCode = 'LTDP' THEN BdmDedCode END) AS LTDP_DedCode
	,NULL AS VLE_DedCode
	,NULL AS VLS_DedCode
	,NULL AS VLX_DedCode
	,NULL AS VADD_DedCode
FROM dbo.U_dsi_BDM_EBVLADDEXP WITH (NOLOCK)
GROUP BY BdmEEID, BdmCOID
UNION
SELECT BdmEEID, BdmCOID
	,NULL AS GTL1_DedCode
	,NULL AS GTL2_DedCode
	,NULL AS GTL3_DedCode
	,NULL AS GTL4_DedCode
	,NULL AS GTLP_DedCode
	,NULL AS LTD10_DedCode
	,NULL AS LTD20_DedCode
	,NULL AS LTDP_DedCode
	,MAX(CASE WHEN BdmDedCode = 'VLE' THEN BdmDedCode END) AS VLE_DedCode
	,MAX(CASE WHEN BdmDedCode = 'VLS' THEN BdmDedCode END) AS VLS_DedCode
	,MAX(CASE WHEN BdmDedCode = 'VLC' THEN BdmDedCode END) AS VLX_DedCode
	,MAX(CASE WHEN BdmDedCode = 'VADD' THEN BdmDedCode END) AS VADD_DedCode
FROM dbo.U_dsi_BDM_EBVLADDEXP WITH (NOLOCK)
GROUP BY BdmEEID, BdmCOID) AS X
WHERE BdmEEID = 'CR6LWP03A030'





/*SELECT EjhEEID, EjhCOID, EjhJobEffDate, EjhAnnSalary -- EjhEEID, EjhCOID, EjhJObCode, EjhFLSACategory, EjhJobEffDate, EjhWeeklyHours
            FROM (
                    SELECT EjhEEID, EjhCOID, EjhJobEffDate, EjhAnnSalary, ROW_NUMBER() OVER(PARTITION BY EjhEEID, EjhCOID ORDER BY EjhJobEffDate DESC) AS RN
                    FROM dbo.EmpHJob WITH (NOLOCK)
				) AS X
            WHERE RN = 1


select top 100 * from EmpHJob*/

/*
SELECT EjhEEID, EjhCOID, EjhJobEffDate, EjhAnnSalary, EjhFullTimeOrPartTime -- EjhEEID, EjhCOID, EjhJObCode, EjhFLSACategory, EjhJobEffDate, EjhWeeklyHours
				FROM (
						SELECT EjhEEID, EjhCOID, EjhJobEffDate, EjhAnnSalary, EjhFullTimeOrPartTime, ROW_NUMBER() OVER(PARTITION BY EjhEEID, EjhCOID ORDER BY EjhJobEffDate DESC) AS RN
						FROM dbo.EmpHJob WITH (NOLOCK)
					) AS X
				WHERE RN = 1*/