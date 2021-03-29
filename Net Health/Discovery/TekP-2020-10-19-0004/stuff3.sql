--sp_getEEID 'test'

-- CPUGB0000040 - 203/Death/chg reason 210
-- B9Y58Q0000K0 - 201/inelligible dep

select * from dbo.U_dsi_BDM_EDISCCOBEX WITH (NOLOCK)
where BdmRunId = 'QB'
AND BdmEEID = 'B9Y58Q0000K0' -- IN ('CPUGB0000040','B9Y58Q0000K0')
--AND BdmEEID  IN ('CPUGB0000040','B9Y58Q0000K0')

select * from dbo.U_EDISCCOBEX_drvTbl_QB
--where drvEEID = 'CPUGB0000040'
where drvEEID = 'B9Y58Q0000K0'

select * from BenChRsn where BchCode IN ('201','402')

select * from EmpHDed
Where EdhEEID = 'B9Y58Q0000K0'
order by EdhBenStatusDate DESC


select * from dbo.U_dsi_BDM_DepDeductions WHere dbnformatcode = 'EDISCCOBEX' and DbnEEID = 'B9Y58Q0000K0'

select * from dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK) where eedFormatCode= 'EDISCCOBEX' and EedEEID = 'B9Y58Q0000K0'