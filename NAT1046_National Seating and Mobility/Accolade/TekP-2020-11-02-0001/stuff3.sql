select * from dbo.U_dsi_BDM_EACCLDMOEX WITH (NOLOCK) where BdmEEID = 'C1GM0M04T0K0'

select drvCoverageTier, drvBenefitCoverageExpDate, * from dbo.U_EACCLDMOEX_drvTbl
where drvEEID = 'C1GM0M04T0K0'

select EdhDedCode, EdhBenStatusDate, EdhEffDate, EdhBenOption, EdhDateTimeCreated  from EmpHDed A WHERE EdhEEID = 'C1GM0M04T0K0' AND EdhDedCode IN ('VIS','DEN2','MED3')
AND EdhBenStatusDate <= '1/31/2021'
order by A.EdhBenStatusDate DESC, A.EdhEffDate DESC


--
--SELECT TOP 1 EdhBenOption FROM dbo.EmpHDed WITH (NOLOCK) WHERE EdhEEID = 'C1GM0M04T0K0' AND EdhDedCode = 'VIS' /*AND EdhBenStatusDate <= '1/31/2021'*/ ORDER BY EdhEffDate DESC