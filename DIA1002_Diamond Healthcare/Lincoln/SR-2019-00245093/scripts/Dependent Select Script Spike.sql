Select c.ConEEID, e.EepNameLast, e.EepNameFirst, e.eepSSN,  c.ConRelationship, c.ConNameLast, c.ConNameFirst 
from dbo.Contacts c
	JOIN EmpPers e on e.eepEEID = c.ConEEID
where c.ConRelationship in ('DIS', 'CHL', 'DPC', 'STC') 
	and c.ConEEID = '9GPXL00000K0'
order by c.ConEEId;


Select c.ConEEID, e.EepNameLast, e.EepNameFirst, e.eepSSN,  c.ConRelationship, c.ConNameLast, c.ConNameFirst 
from dbo.Contacts c
	JOIN EmpPers e on e.eepEEID = c.ConEEID
where c.ConRelationship in ('DIS', 'CHL', 'DPC', 'STC') 
	and c.ConEEID = '9GPXL00000K0'
order by c.ConEEId
OFFSET 0 ROWS
FETCH NEXT 1 ROWS ONLY;


Select c.ConEEID, e.EepNameLast, e.EepNameFirst, e.eepSSN,  c.ConRelationship, c.ConNameLast, c.ConNameFirst 
from dbo.Contacts c
	JOIN EmpPers e on e.eepEEID = c.ConEEID
where c.ConRelationship in ('DIS', 'CHL', 'DPC', 'STC') 
	and c.ConEEID = '9GPXL00000K0'
order by c.ConEEId
OFFSET 1 ROWS
FETCH NEXT 1 ROWS ONLY;


Select c.ConEEID, e.EepNameLast, e.EepNameFirst, e.eepSSN,  c.ConRelationship, c.ConNameLast, c.ConNameFirst 
from dbo.Contacts c
	JOIN EmpPers e on e.eepEEID = c.ConEEID
where c.ConRelationship in ('DIS', 'CHL', 'DPC', 'STC') 
	and c.ConEEID = '9GPXL00000K0'
order by c.ConEEId
OFFSET 2 ROWS
FETCH NEXT 1 ROWS ONLY;

--select top 100 EepNameLast, EepNameFirst from EmpPers