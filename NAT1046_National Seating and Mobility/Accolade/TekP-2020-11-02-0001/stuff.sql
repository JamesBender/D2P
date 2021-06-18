select * from dbo.U_EACCLDMOEX_drvTbl
where drvEEID = 'C1GLEY0360K0'



select * from EmpDed where EedEEID = 'C1GLEY0360K0' AND EedDedCode IN ('DEN1','MED1 ','VIS');

--select * from EmpHDed where EdhEEID = 'C1GLEY0360K0' AND EdhDedCode IN ('DEN1','MED1','VIS') 
--and EdhBenStatusDAte >= '1/1/2021' -- 
--order by EdhBenStatusDate desc

select ConSystemId, * from Contacts where ConEEID = 'C1GLEY0360K0' AND ConRelationship IN ('SPS','DP')



--sp_getEEID 'Ginn' -- C1GLEY0360K0

select * from dbo.U_dsi_BDM_EACCLDMOEX WITH (NOLOCK) where BdmEEID = 'C1GLEY0360K0'

select * from dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK) where DbnFormatCode = 'EACCLDMOEX' AND DbnEEID = 'C1GLEY0360K0'