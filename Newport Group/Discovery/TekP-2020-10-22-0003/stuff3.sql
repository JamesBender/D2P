select * from dbo.U_dsi_BDM_EDSICCBEXP WITH (NOLOCK)
where BdmRunId = 'QB'
and BdmEEID = 'DIWZDT000030'

sp_getEEID 'DIWZDT000030'

select * from dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK) WHERE EedEEID = 'DIWZDT000030' and EedFormatCode = 'EDSICCBEXP'

select * from dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK) WHERE DbnEEID = 'DIWZDT000030' and DbnFormatCode = 'EDSICCBEXP'

--select top 10 * from EmpHDed where EdhChangeReason IN ('302') AND EdhBenStatusDate >= '1/1/2021' -- DIWZDT000030 -- DENBA