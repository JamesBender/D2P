select drvEEBasicLifeCoverageAmount, * from dbo.U_EVOYPORTEX_drvTbl
where drvEEID = 'CP3G6F000020'

Select * from U_dsi_bdm_BenCalculationAmounts
where BcaEEID = 'CP3G6F000020'
and BcaFormatCode = 'EVOYPORTEX'
and BcaDedCode = 'USLAD'

select * from U_dsi_BDM_EmpDeductions
where EedEEID = 'CP3G6F000020'
and EedDedCode = 'USLAD'

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

select * from DedCode
where dedDedCode = 'USLAD'

select  * from dbo.vw_AuditData WITH (NOLOCK) 
where audKey1Value = 'CP3G6F000020'
AND audTableName = 'EmpDed'
--AND audFieldName LIKE '%Amt'
AND audKey3Value = 'USLAD'
order by audDateTime Desc

