select drvEEID, drvStdElection, * from dbo.U_ESLIFEDISA_drvTbl where drvEEID = 'ARJ2OK0000K0'

--BdmBenStartDate

--select BdmEEID, BdmCOID, BdmDedCode, BdmBEnStartDAte from dbo.U_dsi_BDM_ESLIFEDISA WHERE BdmEEID = 'ARJ2MP0000K0'

select BdmEEID, BdmCOID
,STD_DedCode = MAX(CASE WHEN BdmDedCode = 'STD' THEN BdmDedCode END)
,STD_BenStartDate = MAX(CASE WHEN BdmDedCode = 'STD' THEN BdmBenStartDate END)
,STDC_DedCode = MAX(CASE WHEN BdmDedCode = 'STDC' THEN BdmDedCode END)
,STDBC_DedCode = MAX(CASE WHEN BdmDedCode = 'STDBC' THEN BdmDedCode END)
,STDBU_DedCode = MAX(CASE WHEN BdmDedCode = 'STDBU' THEN BdmDedCode END)
,LTD_DedCode = MAX(CASE WHEN BdmDedCode = 'LTD' THEN BdmDedCode END)
,LTD_BenStartDate = MAX(CASE WHEN BdmDedCode = 'LTD' THEN BdmBenStartDate END)
,LTDC_DedCode = MAX(CASE WHEN BdmDedCode = 'LTDC' THEN BdmDedCode END)
from dbo.U_dsi_BDM_ESLIFEDISA
WHERE BdmEEID in (select distinct drvEEID from dbo.U_ESLIFEDISA_drvTbl)
--AND BdmDedCode NOT IN ('STD')
AND BdmEEID = 'ARJ2OK0000K0'
Group by BdmEEID, BdmCOID