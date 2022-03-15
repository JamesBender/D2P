select drvEnrollmentType, * from dbo.U_ESEQDEMEXP_drvTbl
where drvEEID = 'AU3MD500Q0K0'
--Where drvPlanType = '"LIF"'


--select * from dbo.U_dsi_BDM_ESEQDEMEXP WITH (NOLOCK) where BdmDedCode = 'GTL'


select * from EmpDed where EedEEID = 'AU3MD500Q0K0' and EedDedCode = 'GTL'

select * from EmpDedFull where EedEEID = 'AU3MD500Q0K0' and EedDedCode = 'GTL'