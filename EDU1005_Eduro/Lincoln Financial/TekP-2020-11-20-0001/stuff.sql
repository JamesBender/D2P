--sp_getEEID 'Boateng' -- DMXN03001030

select drvSpouseDOB, * from dbo.U_ELINFINEXP_drvTbl
where drvEEID = 'DMXN03001030'


-- no SPS/DP record in BDM table
select * from dbo.U_dsi_BDM_ELINFINEXP WITH (NOLOCK)
where BdmEEID = 'DMXN03001030'
--where BdmDedCode = 'LIFES'