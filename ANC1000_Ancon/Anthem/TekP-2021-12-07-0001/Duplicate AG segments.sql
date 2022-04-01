-- Duplicate AG segments:
--sp_getEEID 'Jaramillo' -- B5C3RJ03M0K0

DECLARE @EEID VARCHAR(12) = 'B5C3RJ03M0K0'

select * from dbo.U_EANTHBD834_DrvTbl_2300 WHERE drvEEID = @EEID and drvHD03_InsuranceLineCode = 'AG'


select BdmBenStatusDate, 
	CASE WHEN BdmDedCode = 'ADD' THEN 'P3'
											--WHEN BdmDedCode = 'ADDF' AND ConRelationship IN ('SPS','DP') THEN 'D2'
											--WHEN BdmDedCode = 'ADDF' AND ConRelationship IN ('CHD','CHL','DPC','STC') THEN 'C1'
											WHEN BdmDedCode = 'RELI1' THEN 'P3'
											WHEN BdmDedCode = 'RELI3' THEN 'D2'
											WHEN BdmDedCode = 'RELI4' THEN 'C1'
											END
, BdmEEAmt, * FROM dbo.U_dsi_bdm_EANTHBD834 WITH (NOLOCK) where BdmEEID = @EEID AND BdmDedCode IN ('RELI1','RELI3','RELI4')

/*
SELECT BdmEEID AS ReliEEID, BdmCOID AS ReliCOID
	,MAX(CASE WHEN BdmDedCode = 'RELI1' THEN BdmDedCode END) AS Reli1DedCode
	,MAX(CASE WHEN BdmDedCode = 'RELI3' THEN BdmDedCode END) AS Reli3DedCode
	,MAX(CASE WHEN BdmDedCode = 'RELI4' THEN BdmDedCode END) AS Reli4DedCode
FROM dbo.U_dsi_bdm_EANTHBD834 WITH (NOLOCK) 
WHERE BdmDedCode IN ('RELI1','RELI3','RELI4')
GROUP BY BdmEEID, BdmCOID
*/