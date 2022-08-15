sp_getEEID 'HoffNagle'

SELECT *
FROM Contacts
WHERE conEEID = 'CL6LD303Z030'

SELECT BdmStartDate,BdmBenStartDate,BdmStopDate, BdmBenStopDate,BdmBenStatus, *
FROM dbo.U_dsi_bdm_ECHAMER834
WHERE BdmStopDate is not null
or BdmBenStopDate is not null
or BdmBenStatus = 'T'
or BdmBenStatus = 'C'

SELECT *
FROM Empded
WHERE eedEEID = 'CL6LD303Z030'
AND eedDedCode IN ('MED01','MED02','MED03')

SELECT AudDateTime, AudFieldName, AudOldValue, AudNewValue,*
FROM dbo.vw_AuditData a WITH (NOLOCK) 
WHERE audKey1Value = 'CL6LA000Z030'
AND AudTableName = 'EmpDed'
Order by a.AudDateTime Desc



SELECT BdmStartDate,BdmBenStartDate,BdmStopDate, BdmBenStopDate,BdmBenStatus, *
FROM dbo.U_dsi_bdm_ECHAMER834
WHERE bdmEEID = 'CL6LD303Z030' --Weeber

SELECT BdmStartDate,BdmBenStartDate,BdmStopDate, BdmBenStopDate,BdmBenStatus, *
FROM dbo.U_dsi_bdm_ECHAMER834
WHERE bdmEEID = 'CL6LA000Z030' --Jason Lange

SELECT BdmStartDate,BdmBenStartDate,BdmStopDate, BdmBenStopDate,BdmBenStatus, *
FROM dbo.U_dsi_bdm_ECHAMER834
WHERE bdmEEID = 'CL6L8X05N030'

SELECT BdmStartDate,BdmBenStartDate,BdmStopDate, BdmBenStopDate,BdmBenStatus, *
FROM dbo.U_dsi_bdm_ECHAMER834
WHERE bdmEEID = 'CL6LA302F030'

--SELECT BdmStartDate,BdmBenStartDate,BdmStopDate, BdmBenStopDate,BdmBenStatus, *
--FROM dbo.U_dsi_bdm_ECHAMER834
--WHERE bdmEEID = 'CL6L9T009030'