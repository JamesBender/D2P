--sp_getEEID 'Hosmanek' -- C1GM0M04T0K0

select drvCoverageTier, * from dbo.U_EACCLDMOEX_drvTbl
--where drvEEID = 'C1GM0M04T0K0'
where drvSort LIKE '397865694%'


--select * from EmpDed where EedEEID = 'C1GM0M04T0K0' AND EedDedCode IN ('DEN1','DEN2','MED1','MED2','MED3','VIS','MED4','MED5')

select * from  dbo.U_EACCLDMOEX_Audit -- 2021-02-16 18:07:59.077
where audEEID = 'C1GM0M04T0K0'