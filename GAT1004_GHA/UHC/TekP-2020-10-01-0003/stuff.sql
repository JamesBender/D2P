--sp_getEEID 'Zhou' -- CZX8IY00G040
--sp_getEEID 'Ramos' -- CKIC1Y000040
--sp_getEEID 'Souksavath' -- CG2S7I00D040
--sp_getEEID 'Dennis' -- CG2S4U000040

--select * from dbo.U_EUHCMDV834_DrvTbl 
--where drvEEID = 'CZX8IY00G040'

select drvDTP00_DateTime_349, drvDTP03_DateTimePeriod_349, * from dbo.U_EUHCMDV834_DrvTbl_2300
--where drvEEID = 'CKIC1Y000040'
--where drvEEID = 'CG2S7I00D040'
--where drvDTP00_DateTime_349 is not null
where drvEEID = 'CG2S4U000040'



select * from dbo.U_dsi_bdm_EUHCMDV834 WITH (NOLOCK)
--where BdmEEID = 'CZX8IY00G040'
--where BdmEEID = 'CKIC1Y000040'
where BdmEEID = 'CG2S4U000040'
