--sp_getEEID 'Bunning' -- DIWT1J002040
--sp_getEEID 'Davis' -- CKCP2F000040

--DECLARE @EEID VARCHAR(12) = 'DIWT1J002040'
DECLARE @EEID VARCHAR(12) = 'CKCP2F000040'

select * from dbo.U_dsi_BDM_EDISNORCOB WITH (NOLOCK) where BdmEEID = @EEID

select EdhChangeReason, EdhEffDate, * from EmpHDed A where EdhEEID = @EEID order by A.EdhEffDate DESc