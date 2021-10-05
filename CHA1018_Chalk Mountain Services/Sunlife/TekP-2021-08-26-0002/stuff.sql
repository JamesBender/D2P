select drvScheduledHoursPerWeek, * from dbo.U_ESUNLFABEX_drvTbl





/*SELECT BdmEEID, BdmCOID
	,MAX(CASE WHEN BdmDedCode = 'ERSTD' THEN BdmBenStartDate END) AS ERSTD_BenStartDate
	,MAX(CASE WHEN BdmDedCode = 'STD' THEN BdmBenStopDate END) AS STD_BenStopDate
	,MAX(CASE WHEN BdmDedCode = 'LTD' THEN BdmBenStartDate END) AS LTD_BenStartDate
	,MAX(CASE WHEN BdmDedCode = 'LTD' THEN BdmBenStopDate END) AS LTD_BenStopDate
FROM dbo.U_dsi_BDM_ESUNLFABEX WITH (NOLOCK)
GROUP BY BdmEEID, BdmCOID
*/