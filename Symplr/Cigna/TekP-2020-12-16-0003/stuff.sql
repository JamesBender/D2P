select * from dbo.U_ECIGVOLLEX_drvTbl
where drvEEID IN ('CQ3SY5000030','BYVVK80000K0','BYSCWV0000K0')

--sp_getEEID 'Clements' -- CQ3SY5000030
--sp_getEEID 'Fox' -- BYVVK80000K0
--sp_getEEID 'Kelley' -- BYSCWV0000K0


select * from dbo.U_dsi_BDM_ECIGVOLLEX WITH (NOLOCK) 
--where BdmEEID IN ('CQ3SY5000030','BYVVK80000K0','BYSCWV0000K0')
where BdmEEID IN ('CQ3SY5000030') 
--where BdmEEID IN ('BYVVK80000K0') --,'BYSCWV0000K0')



select * from EmpDed 
where EedEEID = 'CQ3SY5000030' AND EedDedCode = 'LIFES'

