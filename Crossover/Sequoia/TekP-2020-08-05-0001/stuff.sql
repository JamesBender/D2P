select drvEmployeeClass, * from dbo.U_ESEQDEMEXP_drvTbl
where drvEmployeeClass is null
--where drvSort IN ('UNVOL','VOLCH','VOLSP')

select EecDedGroupCode, EecEEID  from EmpComp where EecEEID IN (select distinct drvEEID from dbo.U_ESEQDEMEXP_drvTbl where drvEmployeeClass is null)


--select * from dbo.U_dsi_BDM_ESEQDEMEXP WITH (NOLOCK)

select * from BenProg where  CbpDedCode IN ('MEDFT','MEDPT','GTL','UNVOL','VOLSP','VOLCH','LTD','STD','DENFT','DENPT','VISFT','VISPT') order by CbpDedCode


select * from dbo.BenGrp