--sp_getEEID 'McMillion' --8YEYRX0021G0 -- 574644791  

select * from dbo.U_ENUEDDFSAX_drvTbl where drvEEID = '8YEYRX0021G0'

select * from dbo.U_ENUEDDFSAX_PDedHist where pdhEEID = '8YEYRX0021G0'
select * from dbo.U_ENUEDDFSAX_PEarHist where pehEEID = '8YEYRX0021G0'
select * from dbo.U_dsi_BDM_ENUEDDFSAX where BdmEEID = '8YEYRX0021G0'



select * from dbo.U_ENUEDDFSAX_EEList where xEEID = '8YEYRX0021G0'

select pdhPerControl, pdhDedCode, PdhEECurAmt, * from PDedHist a 
where pdhEEID = '8YEYRX0021G0' 
and LEFT(pdhPerControl, 4) = '2019' 
and pdhPerControl between '201911221' AND '201911229'
and PdhDedCode IN ('FSA4', 'FSAHC', 'FSAI', 'FSAL', 'FSANM', 'FSAO', 'FSAU')
order by a.PdhPerControl desc

select * from EmpDedFull where EedEEID = '8YEYRX0021G0'
