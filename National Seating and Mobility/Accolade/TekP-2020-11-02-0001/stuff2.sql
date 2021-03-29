/*
An example is Darryl Hosmanek.  Child Brittney was termed eff 1/31/21, but the file is sending EE only instead of EE+Children that was on the record at the time of the term.
*/

/*
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202012011'
       ,expStartPerControl     = '202012011'
       ,expLastEndPerControl   = '202102199'
       ,expEndPerControl       = '202102199'
WHERE expFormatCode = 'EACCLDMOEX';	
*/

--sp_getEEID 'Hosmanek' -- C1GM0M04T0K0 - 10024

select drvCoverageTier, drvBenefitCoverageExpDate, * from dbo.U_EACCLDMOEX_drvTbl
where drvEEID = 'C1GM0M04T0K0'
--where drvSort LIKE '397865694%'

select * from dbo.U_dsi_BDM_EACCLDMOEX WITH (NOLOCK) where BdmEEID = 'C1GM0M04T0K0'


--select * from EmpDed where EedEEID = 'C1GM0M04T0K0' AND EedDedCode IN ('DEN1','DEN2','MED1','MED2','MED3','VIS','MED4','MED5')

select * from  dbo.U_EACCLDMOEX_Audit -- 2021-02-16 18:07:59.077
where audEEID = 'C1GM0M04T0K0'




select drvCoverageTier, drvBenefitCoverageExpDate, * from dbo.U_EACCLDMOEX_drvTbl
where drvEEID = 'C1GM0M04T0K0'

select EdhDedCode, EdhBenStatusDate, EdhEffDate, EdhBenOption, EdhDateTimeCreated  from EmpHDed A WHERE EdhEEID = 'C1GM0M04T0K0' AND EdhDedCode IN ('VIS','DEN2','MED3')
AND EdhBenStatusDate <= '1/31/2021'
order by A.EdhBenStatusDate DESC, A.EdhEffDate DESC

