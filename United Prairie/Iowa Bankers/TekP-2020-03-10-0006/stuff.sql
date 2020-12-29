SELECT drvEEID, drvDTP03_DateTimePeriod_348, drvDTP03_DateTimePeriod_349, * 
from dbo.U_EIWABNKMED_DrvTbl_2300
--where drvEEID = 'COCIET043030'
where drvEEID = 'CY331U000030'
--where drvDTP03_DateTimePeriod_349 = '1/1/1900'




SELECT * from dbo.U_EIWABNKMED_OldBenOptions
where ObEEID IN (/*'COCIET043030',*/'CY331U000030')

--sp_getEEID 'Schlagel' -- COCIET043030
--sp_getEEID 'Madsen' -- CY331U000030

select * from dbo.U_dsi_bdm_EIWABNKMED WITH (NOLOCK) 
--where BdmEEID = 'COCIET043030'	
where BdmEEID = 'CY331U000030'

--select * from dbo.U_dsi_bdm_Configuration
--where FormatCode = 'EIWABNKMED'

--select top 10 * from EmpHDed where EdhEEID = 'COCIET043030'	and EdhDedCode = '429'

--select top 10 * from EmpDed--









