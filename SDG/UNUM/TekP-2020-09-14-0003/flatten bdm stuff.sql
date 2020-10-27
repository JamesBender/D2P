--select * from dbo.U_EUNDENVISE_drvTbl 


select BdmEEID, BdmCOID
	,MAX(CASE WHEN BdmDedCode = 'DEN' THEN BdmDedCode END) AS Den_DedCode
	--,MAX(CASE WHEN BdmDedCode = 'DEN' THEN BdmDepRecId END) AS Den_DepRecId
	,MAX(CASE WHEN BdmDedCode = 'VIS' THEN BdmDedCode END) AS Vis_DedCode
	--,MAX(CASE WHEN BdmDedCode = 'VIS' THEN BdmDepRecId END) AS Vis_DepRecId
from dbo.U_dsi_BDM_EUNDENVISE WITH (NOLOCK) 
where BdmEEID = 'CQE3LW000030'
group by BdmEEID, BdmCOID




select * from dbo.U_dsi_BDM_EUNDENVISE WITH (NOLOCK) 
where BdmEEID = 'CQE3LW000030'