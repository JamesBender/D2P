--sp_getEEID 'Noda' -- COPWKQ006040
--select EecEEID, EecEmpNo, * from EmpComp where EecEmpNo IN ('000006','000007');

sp_getEEID '167680120'

--select * from dbo.U_EGRD834EXP_DrvTbl
--where drvREF02_RefNumberQual3 = '0009'
--where drvEEID IN ('COPVW9000040','COPVWA000040')
--where drvEEID = 'COPWKQ006040'

select drvInitialSort, drvSubSort, * from dbo.U_EGRD834EXP_DrvTbl_2300
--where drvEEID = 'COPWKQ006040'
--where drvInitialSort = '158581229'
where drvEEID = 'DHXT6W000040'


select top 100 * from dbo.U_EGRD834EXP_File (NOLOCK)
where InitialSort >= '158581229'
order by InitialSort, SubSort

