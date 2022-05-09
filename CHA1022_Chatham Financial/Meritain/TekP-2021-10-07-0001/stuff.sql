--sp_getEEID 'CL6LD303Z030' -- Weeber,Philip

DECLARE @EEID VARCHAR(12) = 'CL6LD303Z030'

--select * from dbo.U_ECHAMER834_DrvTbl where drvEEID  = @EEID

--select * from dbo.U_dsi_bdm_ECHAMER834 where bdmEEID = @EEID

--select ConSystemID, * from Contacts where ConSystemID IN (select distinct BdmDepRecId from dbo.U_dsi_bdm_ECHAMER834 where bdmEEID = @EEID)

select * from EmpDed where EedEEID = @EEID and EedDedCode = 'MED01'
select * from DepBPlan where DbnEEID = @EEID AND DbnDedCode = 'MED01'

/*
SELECT *
FROM dbo.U_ECHAMER834_EEList WITH (NOLOCK)
JOIN dbo.vw_AuditData WITH (NOLOCK) 
	ON audKey1Value = xEEID
WHERE xEEID  = @EEID
AND audDateTime BETWEEN '4/1/2022' AND '4/30/2022'
*/

--select * from dbo.U_dsi_bdm_Configuration where FormatCode = 'ECHAMER834'