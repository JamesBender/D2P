--select top 10 * from Contacts

--sp_getEEID '038548361' -- CC7QFC0000K0

select drvSubSort, * from dbo.U_EANTLIF834_DrvTbl_2300 where drvEEID = 'CC7QFC0000K0'
select * from dbo.U_dsi_bdm_EANTLIF834 WITH (NOLOCK) where BdmEEID = 'CC7QFC0000K0' and BdmRecType = 'EMP'

--218 and 907