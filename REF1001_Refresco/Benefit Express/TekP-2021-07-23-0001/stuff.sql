--select * from dbo.fn_MP_CustomFields_EmpPers_Export (NULL,NULL,NULL,NULL) 


--Employee_DateOfAcquisition

--select * from dbo.U_EBENEXDEM2_drvTbl
--where drvEEID = 'CDN9Q90000K0'

select EecSupervisorID, EecEmpNo, EecLocation, * from EmpComp where EecEEID = 'CDN9Q90000K0'
select EecSupervisorID, EecEmpNo, EecLocation, * from EmpComp where EecEEID = 'CDN9TP0140K0'

select EecEEID, * from EmpComp where EecEmpNo = '209053'
select * from EmpPers where EepEEID = 'CDN9TU0120K0'


/*
Eepnamefirst space Eepnamelast where EecSupervisorID = EecEEID where CodDesc FROM dbo.Codes = EecEmpNo
AND codCode FROM dbo.Codes = EecLocation
where codTable = 'CO_HRMANAGERBYLOCATI'

*/