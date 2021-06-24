--sp_getEEID 'Hernandez Bonilla' --

--select drvRecordType, drvEmployeeSSN, drvDependentSSN, 
select drvSalaryEffectiveDate, * 
from dbo.U_EDRBMUSEXP_drvTbl
where --drvRecordType IN ('01','05')
drvEEID = 'CLNK7D00Q020'
order by drvInitialSort, drvSubSort

--select EecDateOfLastHire from Empcomp where EecEEID = 'CLNK7D00Q020'



SELECT dbo.dsi_fnGetMinMaxDates('MIN', dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate('CLNK7D00Q020', 'JMJ6I', GETdate(),'10/1/2018'), CAST('01/01/2021' as datetime)) -- 2019-02-04 00:00:00.000

-- CAST('01/01/2021' as datetime)