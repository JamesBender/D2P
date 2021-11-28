--select drvhrstatusDate, * from dbo.U_EAV3_drvTbl;

--sp_getEEID 'Schinella' -- DIED8K000020
--sp_getEEID 'Clark'
--sp_getEEID 'Wathke' -- DUZT9V000020
--sp_getEEID 'Benehoule' -- DPJTIK000020 -- NOT i EE
--sp_getEEID 'Gajewsky' -- DGI8MS01K020
--sp_getEEID 'Lopez' -- DB5C1C00O020
--sp_getEEID 'Samaniego' -- DGI8XS015020

/*

SELECT audEEID AS hsdEEID, audKey2 AS HsdCOID, audFieldName AS hsdFieldName, CASE WHEN audFieldName = 'EecEmplStatus' THEN EecEmplStatusStartDate END, audSystemId
FROM dbo.U_EAV3_StatusDate_Audit
JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = audEEID 
        AND EecCoID = audKey2
LEFT JOIN dbo.EmpHJob WITH (NOLOCK)
	ON audSystemId = EjhSystemId
--WHERE audEEID = 'DIED8K000020'
--WHERE audEEID = 'DJU48K000020'
--WHERE audEEID = 'DUZT9V000020'
--WHERE audEEID = 'DPJTIK000020'
--WHERE audEEID = 'DGI8MS01K020'
--WHERE audEEID = 'DB5C1C00O020'
WHERE audEEID = 'DGI8XS015020'

*/

--EXEC fn_findeffdate_emphjob 'DGI8XS015020', 'EjhFullTimeOrPartTime'

--select EecFullTimeOrPartTime,  * from EmpComp where EecEEID = 'DGI8XS015020'

		select EjhJobEffDate, EjhReason, EjhSystemID, EjhFullTimeOrPartTime, EjhIntegrationEffDate, EjhSalaryOrHourly, * from EmpHJob A
		--where EjhEEID = 'DIED8K000020' -- 'DB5AKC000020'
		--where EjhEEID = 'DPJTIK000020'
		--where EjhEEID = 'DGI8MS01K020'
		--WHERE EjhEEID = 'DGI8XS015020'
		where EjhEEID = 'DGI8MS01K020'
		order by A. EjhJobEffDate desc

--SELECT EecEmplStatusStartDate, EecCOID, * From EmpComp where EecEEID = 'DPJTIK000020'

--select top 100 audAction, audFieldName, audDAteTime, audSystemId, '' as filler, * from dbo.vw_AuditData A WITH (NOLOCK) where audKey1Value = 'DGI8XS015020' and audTableName in ('EmpComp','EmpHJob') --AND audFieldName IN ('EecEmplStatus','EecSalaryOrHourly','EecFullTimeOrPartTime','EecEEType','EjhFullTimeOrPartTime') AND audTableName = 'EmpComp'

 --order by A.audDateTime desc

 --select * from dbo.U_EAV3_Audit where audEEID = 'DGI8XS015020'

