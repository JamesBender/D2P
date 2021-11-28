--sp_getEEID 'Alston' -- DDAO08000040
--sp_getEEID 'Herraiz' -- DDANSF000040
--sp_getEEID 'Alston' -- DDAO08000040
--sp_getEEID 'Grisler' -- DDAOBN000040


select * from dbo.U_EABGCBREXP_drvTbl_QB
where drvEEID = 'DDANSF000040'

--select * from dbo.U_EABGCBREXP_drvTbl_QBEVENT
--select * from dbo.U_EABGCBREXP_drvTbl_QBPLANINITIAl
--where drvEEID = 'DDAOBN000040'
--where drvEEID = 'DDANSF000040'
--where drvEEID = 'DDAO08000040'

select * from dbo.U_dsi_BDM_EABGCBREXP WITH (NOLOCK)
where BdmEEID = 'DDANSF000040'

--select ConSystemID, * from Contacts
--where ConEEID = 'DDANSF000040'

select top 10 *
from dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
WHERE dbnFormatCode = 'EABGCBREXP'
AND DbnEEID = 'DDANSF000040'


--select * from dbo.U_dsi_BDM_EABGCBREXP WITH (NOLOCK)
--where BdmEEID = 'DDAOBN000040'


/*

select EdhEEID, EdhCOID, EdhDedCode, * --MAX(EdhEffDate) AS EdhEffDate 
from EmpHDed
WHERE EdhEEID = 'DDAOBN000040' AND 
EdhDedcode IN ('VIS','DEN') -- IN ('FSA','MPOS','MPPO','MHMO','DEN','VIS','EAP')
AND EdhChangeReason IN ('LEVNT3','LEVNT4','204','210','201')
GROUP BY EdhEEID, EdhCOID, EdhDedCode


select * from dbo.U_dsi_BDM_EABGCBREXP WITH (NOLOCK)
where BdmEEID = 'DDANSF000040'

select top 10 *
from dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
WHERE dbnFormatCode = 'EABGCBREXP'
AND DbnEEID = 'DDANSF000040'
*/
