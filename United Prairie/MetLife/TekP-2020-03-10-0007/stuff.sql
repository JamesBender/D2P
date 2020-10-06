select * from dbo.U_EMETLIFEXP_drvTbl
WHERE drvNameLast IN ('Kuntz','Eggink')


select EedDedCode, * from EmpDed
where eedEEID IN ('DFAV5Z000030','DFNTS4000030')
AND EedDedCode IN ('417','422')

select * from EmpDedFull
where eedEEID IN ('DFAV5Z000030','DFNTS4000030')
AND EedDedCode IN ('417','422')


