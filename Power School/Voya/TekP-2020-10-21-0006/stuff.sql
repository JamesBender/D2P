select drvEEBasicLifeCoverageAmount, * from dbo.U_EVOYPORTEX_drvTbl
where drvEEID = 'CP3G6F000020'



select * from dbo.U_dsi_BDM_EVOYPORTEX WITH (NOLOCK)
where bdmEEID = 'CP3G6F000020'
and bdmdedcode = 'USLAD'
--JOIN dbo.U_EVOYPORTEX_drvTbl on BdmEEID = drvEEID


select * from  dbo.EmpDed WITH (NOLOCK)
where EedEEID = 'CP3G6F000020'
AND EedDedCode = 'USLAD'

select top 10 * from EmpHDed
where EdhEEID = 'CP3G6F000020'
AND EdhDedCode = 'USLAD'



