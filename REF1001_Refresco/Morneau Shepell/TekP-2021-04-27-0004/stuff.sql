--select * from dbo.U_EMRSDEMOEX_drvTbl;

SELECT Sup.EecEmpNo, Sup.EecLocation, SUP.*
FROM dbo.EmpComp Sup WITH (NOLOCK)
JOIN dbo.EmpComp Emp WITH (NOLOCK)
	ON Sup.EecEEID = Emp.EecSupervisorID
--select EecEEID, EecSupervisorID, EecEmpNo from EmpComp
where Emp.EecEEID = 'CDN9Q90000K0'




select top 100 * from dbo.Codes
WHERE CodTable = 'CO_HRMANAGERBYLOCATI'
--and CodDesc = '226999   '
AND CodCode = 'GREER '