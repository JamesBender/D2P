select drvEEID, drvINS02_RelationshipCode,drvNM104_NameFirst1,  *
from dbo.U_ECHAMER834_DrvTbl
where drvNM103_NameLast1 = 'Weeber'

select drvEEID, drvINS02_RelationshipCode,drvNM104_NameFirst1,  *
from dbo.U_ECHAMER834_DrvTbl
WHERE drvEEID = 'CL6LD303Z030'

select EepNameFirst,*
from EmpPers
WHERE eepEEID = 'CL6LD303Z030'

SELECT ConNameFirst,*
from Contacts
WHERE ConEEID = 'CL6LD303Z030'

Select distinct *
from dbo.U_dsi_bdm_ECHAMER834
WHERE BdmEEID = 'CL6LD303Z030'


select *
from dbo.U_ECHAMER834_EELIST
where xeeid =  'CL6LD303Z030'

select *
from     dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
WHERE dbnformatcode = 'ECHAMER834'
and DbnEEID = 'CL6LD303Z030'

select *
from     dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
WHERE Eedformatcode = 'ECHAMER834'
and EedEEID = 'CL6LD303Z030'

--FROM JAMES:
Declare @EeID Varchar(12) = 'CL6LD303Z030'


--SELECT * 
--From dbo.U_ECHAMER834_DrvTbl
--WHERE drvEeID = 'CL6LD303Z030'

SELECT *
from U_dsi_bdm_ECHAMER834
where bdmeeid = @EeID


--SELECT *
--from depbplan
--where DbnEEID = @EeID
--AND dbnDedCode = 'Med01'

SELECt *
from empded
WHERE eedeeid = @EeID
AND EedDedCode = 'Med01'