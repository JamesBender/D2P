--sp_getEEID 'Fox' -- A5M38E0010K0

select drvDepartment, * from dbo.U_ECUTRAMPEX_drvTbl
--where drvEEID = 'A5M38E0010K0'
where drvDepartment is null


select CfgAudClass, CfgAudFieldName, * from vw_dsi_CfgAuditData 
where CfgAudKey1Value = 'A5M38E0010K0'
AND CfgAudFieldName = '_BCultureAmpDepartment'


select * from dbo.U_ECUTRAMPEX_Audit
where audKey1 IN ('A5M38E0010K0','A3X3JA0110K0')

select * from [dbo].[fn_MP_CustomFields_EmpComp_Export] (null, null, null, null)
where EecEEID IN ('A5M38E0010K0','A3X3JA0110K0')