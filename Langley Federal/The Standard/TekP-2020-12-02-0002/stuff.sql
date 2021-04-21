select drvCiEmployeeAmtCancer, drvCiSpouseAmtCancer, * from dbo.U_ESTNLSTDEX_drvTbl
--where drvEEID = 'CFPLHS00L0K0'
where drvEEID = 'CFPLI500I0K0'



select * from dbo.U_dsi_BDM_ESTNLSTDEX WITH (NOLOCK)  where BdmEEID = 'CFPLHS00L0K0'

select * from dbo.U_dsi_BDM_ESTNLSTDEX WITH (NOLOCK)  where BdmDedCode IN ('CIC10','CIC5','CIS10','CIS5','CIE10','CIE5','CIF10','CIF5')


select * from dbo.U_dsi_BDM_ESTNLSTDEX WITH (NOLOCK)  where BdmDedCode IN ('CHSA5','CIS10','CIS5') and BdmEEID  = 'CFPLI500I0K0'

select * from EmpDed where EedEEID  = 'CFPLHS00L0K0' AND EedDedCOde = 'CHSA5'

SELECT DedDedCode, DedBenAmtMax
FROM DedCode WITH (NOLOCK)
WHERE DedDedCode IN ('CHSA5','CIS10','CIS5')

SELECT TOP 1 DedBenAmtMax FROM DedCode WITH (NOLOCK) WHERE DedDedCode IN ('CHSA5') --,'CIS10','CIS5')

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



