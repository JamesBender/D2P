--sp_getEEID 'Prather' -- DMVFO4000040

select * from dbo.U_EARICOB_drvTbl
where drvEEID = 'DMVFO4000040'


select * from dbo.U_dsi_BDM_EARICOB WITH (NOLOCK)
--where BdmEEID  = 'DMVFO4000040'
where BdmCobraReason = '203'

