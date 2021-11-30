--sp_getEEID 'Lithgow' -- DTP9GJ000020

select * from dbo.U_ERELABSIMP_drvTbl
where drvEEID = 'DTP9GJ000020'


select *
from EmpDed
where EedDedCode IN ('GTLC1','GTLC2','GTLC3','GTLC4','GTLC5')
and EedEEID = 'DTP9GJ000020'



select *
from EmpHDed
where EdhDedCode IN ('GTLC1','GTLC2','GTLC3','GTLC4','GTLC5')
and EdhEEID = 'DTP9GJ000020'


