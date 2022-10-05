--select * from dbo.U_ETRIPACT_drvTbl

--select distinct CodTable from dbo.Codes A WITH (NOLOCK) order by A.CodTable
--WHERE CodTable LIKE '%CO%' --_APPROVER'

SELECT * from [dbo].[fn_MP_CustomFields_EmpComp_Export](null, null, null, null)
where EecEEID IN ('DMISC001K050','DTGMGW000050','DZ9SBX000050','E1MLSE000050')

Select * from Codes where CodTable = 'CO_APPROVER' 