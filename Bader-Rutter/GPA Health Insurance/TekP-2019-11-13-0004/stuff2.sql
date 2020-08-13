--sp_getEEID 'Guist'
--select * from dbo.U_EGPAMED834_DrvTbl where drvEEID = 'ADMYW200R0K0'

select drvEEID, drvDTP03_DateTimePeriod_348, drvDTP00_DateTime_348, * from dbo.U_EGPAMED834_DrvTbl_2300 A  where drvEEID IN ('ADMYDD0000K0','ADMYNI02S0K0','ADMYP20000K0','ADMYW200R0K0','ADMZL70000K0','B86WST0000K0') order by A.drvEEID --where drvDTP03_DateTimePeriod_348 <> '1/1/2020' --where drvEEID = 'ADMYW200R0K0'


select EepNameLast, EepNameFirst, EepEEID, * from EmpPers A where EepEEID IN ('ADMYDD0000K0','ADMYNI02S0K0','ADMYP20000K0','ADMYW200R0K0','ADMZL70000K0','B86WST0000K0') order by A.EepEEID


