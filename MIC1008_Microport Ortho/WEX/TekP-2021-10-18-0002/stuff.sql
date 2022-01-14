--sp_getEEID 'Mendelson'

select * from dbo.U_EMICWEXFSA_PT_drvTbl
where drvEEID = 'D1ZHB8000030'


select * from dbo.U_EMICWEXFSA_EN_drvTbl
where drvEEID = 'D1ZHB8000030'

select * from dbo.U_EMICWEXFSA_CT_drvTbl
where drvEEID = 'D1ZHB8000030'


select * from dbo.U_dsi_BDM_EMICWEXFSA WITH (NOLOCK)
where BdmEEID = 'D1ZHB8000030'


