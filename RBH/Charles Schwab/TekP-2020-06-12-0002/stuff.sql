select * from dbo.U_ESEQDEMEXP_drvTbl
where drvEEID = 'CC5SJA0000K0'


/*select  EedEEID, EedCOID, EedDedCode, EedBenStopDate, * 
from EmpDed 
join dbo.U_ESEQDEMEXP_drvTbl ON EedEEID = drvEEID
where EedDedCode IN ('DENFT','GLIFE','LTD  ','MEDFT','STD  ','VISFT')
AND EedBenStatus = 'W'
AND EedBenStopDate > '9/15/2020'*/

--select top 100 * from EmpDed 
--where eedBenStatus = 'W'
--where EedEEID = 'CC5SJA0000K0'

select * from dbo.U_dsi_BDM_ESEQDEMEXP WITH (NOLOCK) 
where BdmEEID = 'CC5SJA0000K0'
--where BdmEEID = 'DFO74I000030'
--where BdmEEID = 'AU3MD500Q0K0'


--sp_getEEID 'Singh' -- CC5SJA0000K0 -- Singh,Kuljeet