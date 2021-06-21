--sp_getEEID 'Safren' -- BYF6N40000K0
--sp_getEEID 'Carrier' -- 77N8720010K0

select drvCheckDAte, drvGrossWagesbytype, drvEmployeeYTDEarnings, drvEmployeeYTDEarnings, drvEmployeeYTDHours, drvPayType, * from dbo.U_ECCCPAYEXP_drvTbl A
where drvEEID = 'BYF6N40000K0'
--where drvEEID = '77N8720010K0'
--AND drvPayType = 'B'
order by A.drvCheckDate DESC

select * from dbo.U_ECCCPAYEXP_PEarHist
--where PehEEID = 'BYF6N40000K0'
where PehEEID = '77N8720010K0'

