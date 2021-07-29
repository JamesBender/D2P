--sp_getEEID 'Krehmeyer' -- BC1T7D0000K0
--sp_getEEID 'Dunk' -- D0LTVU000020

Select drvICM04_LocationID, * from dbo.U_EGUARDE834_DrvTbl
where drvEEID = 'BC1T7D0000K0'
--where drvEEID = 'D0LTVU000020'



SELECT EjhJobEffDate, EjhCOID, EjhIsRateChange, *
FROM EmpHJob A
WHERE EjhEEID = 'BC1T7D0000K0'
	AND EjhJobEffDate < GETDATE()
Order by A.EjhJobEffDate DESC
