select audEEID, audCOID, MAX(audReHire) AS audReHire, MAX(audTerm) AS audTerm, MAX(audSalaryChange) AS audSalaryChange 
from dbo.U_EUNDENVISE_Audit WITH (NOLOCK)
where audEEID = 'CQE38B000030'
group by audEEID, audCOID


SELECT *
from dbo.U_EUNDENVISE_Audit WITH (NOLOCK)
--where audReHire = 'Y' OR audTerm = 'Y' OR audSalaryChange = 'Y'





select  drvSpouseEffectiveDate, * from dbo.U_EUNDENVISE_drvTbl


/*where drvEEID IN ('DE9UDX000030','DF3WLF000030','DF5IDZ000030','DFRZQP000030','DEE2FH000030','DESH8Y000030')

--select * from dbo.U_dsi_BDM_EUNDENVISE WITH (NOLOCK) where BdmEEID = 'DESBWG000030'

SELECT audNewValue from dbo.U_EUNDENVISE_Audit WITH (NOLOCK)
WHERE audTableName = 'EmpPers'
AND audFieldName = 'EepSSN'
AND audEEID IN ('DE9UDX000030','DF3WLF000030','DF5IDZ000030','DFRZQP000030','DEE2FH000030','DESH8Y000030')
--AND audCOID = 'NBGY8'


select * from dbo.U_EUNDENVISE_EELIST where xEEID = 'DESBWG000030'

select * from dbo.U_EUNDENVISE_Audit WITH (NOLOCK)
where audEEID IN (SELECT DISTINCT BdmEEID FROM dbo.U_dsi_BDM_EUNDENVISE)
AND audTableName = 'EmpPers'
AND audFieldName = 'EepSSN'*/