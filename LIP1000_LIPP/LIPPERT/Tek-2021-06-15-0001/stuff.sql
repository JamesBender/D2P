-- Gajewsky

select EjhJobEffDate, EjhReason, * from EmpHJob A
where EjhEEID = 'DGI8MS01K020'
order by A. EjhJobEffDate desc

select top 10 audAction, * from dbo.vw_AuditData A WITH (NOLOCK) where audKey1Value = 'DGI8MS01K020' AND audFieldName IN ('EecEmplStatus','EecSalaryOrHourly','EecFullTimeOrPartTime','EecEEType') AND audTableName = 'EmpComp' order by A.audDateTime desc








