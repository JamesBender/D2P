--sp_getEEID 'Darby' -- DH2TAL000020

--sp_getEEID 'Stevenson' -- DH2RZX000020

--sp_getEEID 'Cowhick' -- DIAFV9000020

--select * from dbo.U_EPRINC4012_D10
select * from dbo.U_EPRINC4012_D10
--where drvEEID = 'DH2TAL000020'
--where drvEEID = 'DH2RZX000020'
where drvEEID = 'DIAFV9000020'


--WHERE drvSSN IN ('999999999','123456789','111119999') OR LEFT(drvSSN, 3) IN ('999','123','111')



--select EecEmplStatus, EecPayGroup, * from EmpComp where EecEEID = 'DH2TAL000020'

--sp_help AscExp 



DECLARE @PayGroupList VARCHAR(255);

SELECT @PayGroupList = RTRIM(ExpSelectByList)
FROM dbo.AscExp 
WHERE expFormatCode = 'EPRINC4012'
	AND ExpExportCode = 'ONDEM_XOE'
	AND ExpSelectbyField = 'EecPayGroup'

SELECT @PayGroupList

SELECT * FROM dbo.dsi_BDM_fn_ListToTable(@PayGroupList)

SELECT top 100 *
FROM dbo.EmpComp WITH (NOLOCK)
WHERE EecPayGroup IN (SELECT * FROM dbo.dsi_BDM_fn_ListToTable(@PayGroupList))
	AND EecEmplStatus <> 'T'
	AND EecEEID =  'DH2TAL000020'

