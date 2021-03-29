--sp_getEEID 'Aaron' -- CFNJCB0000K0

select top 100 * from dbo.fn_MP_CustomFields_EmpComp_Export (NULL, NULL, NULL, NULL) Where EecEEID = 'CFNJCB0000K0'


--select top 100 * from dbo.fn_MP_CustomFields_EmpHJob_Export (NULL, NULL, NULL, NULL) Where EjhSystemId = 'CFNJCB0000K0'

select top 100 * from dbo.fn_MP_CustomFields_EmpPers_Export (NULL, NULL, NULL, NULL) Where EEID = 'CFNJCB0000K0'


--select top 100 * from dbo.fn_MP_CustomFields_vwOrgLevel1_Export (NULL, NULL, NULL, NULL) Where EEID = 'CFNJCB0000K0'


select * from EmpPers where EepEEID = 'CFNJCB0000K0'