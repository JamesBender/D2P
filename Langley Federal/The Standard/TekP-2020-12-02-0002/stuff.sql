select * from dbo.U_ESTNLSTDEX_drvTbl
--where drvEEID = 'CFPLHS00L0K0'

select top 10 * from dbo.vw_int_PayReg WITH (NOLOCK)
--select ConRelationship, ConNameLast, ConNameFirst, * from Contacts where ConEEID = 'CFPLHS00L0K0'


--select * from OrgLevel where OrgLvl = 3


--select CmpCOID, CmpCompanyName, * from Company



--select * from Codes
--where CodTable = 'COUNTRY'
--where CodTable like 'Eep%'

--select top 10 * from EmpMPhon


/*SELECT EjhEEID, EjhCOID, EjhFLSACategory
FROM (
		SELECT EjhEEID, EjhCOID, EjhFLSACategory, EjhJobEffDate, ROW_NUMBER() OVER (PARTITION BY EjhEEID, EjhCOID ORDER BY EjhJobEffDate DESC) AS RN
		FROM dbo.EmpHJob WITH (NOLOCK)
	) AS X
WHERE RN = 1*/


--where EjhEEID = 'CFPLHS00L0K0'



