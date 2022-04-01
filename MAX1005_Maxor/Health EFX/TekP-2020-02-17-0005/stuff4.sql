select * from dbo.U_EEFXHLDEMO_drvTbl -- 970
where drvEEID IN ('CXPU53002020','BY482V0000K0', 'B2CGBL04B0K0')


select * from dbo.U_EEFXHLDEMO_Audit 
where audEEID = 'CXPU53002020' -- 'BY482V0000K0'
and audTableName = 'EmpComp' and audFieldName = 'EecEmplStatus'


--select distinct audEEID from dbo.U_EEFXHLDEMO_Audit -- 5447
--select distinct drvEEID from dbo.U_EEFXHLDEMO_drvTbl -- 895

--select * from dbo.U_EEFXHLDEMO_drvTbl where drvEEID NOT IN (select distinct audEEID from dbo.U_EEFXHLDEMO_Audit where audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus')

--select EecDateOfLastHire, * from EmpComp where EecEEID = 'BY482V0000K0' -- 2020-04-27 00:00:00.000
--sp_getEEID 'Rosete Vega' -- BY482V0000K0
-- sp_getEEID 'Harris' -- B2CGBL04B0K0
--sp_getEEID 'Barnes' -- CXPU53002020

