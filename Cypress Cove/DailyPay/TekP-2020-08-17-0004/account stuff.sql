select * from dbo.U_EDLYPAYEXP_drvTbl 
--where drvNameLast IN ('Lux','Dodson','Camel','Raurau','Metelus','Fuller')


--select distinct PrhEEID, prhCOID, PrhACCT from dbo.PDirHist WITH (NOLOCK) where PrhEEID ='AQAEHA0070K0'

--select PrhEEID, prhCOID, PrhACCT,  * from dbo.PDirHist A WITH (NOLOCK) where PrhEEID ='AQAEHA0070K0'


select EddAcct, * from EmpDirdp where EddEEID IN ('AQHYZ003C0K0','AQHYZM00R0K0','AQHZ020000K0')


