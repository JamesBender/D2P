--select * from dbo.U_EBCBSMD834_DrvTbl;


/*select distinct ConEEID, ConSSN, ConDateOfBirth, ConNameLast, ConNameFirst, ConSystemId --, * 
from Contacts A
join dbo.U_EBCBSMD834_EELIST WITH (NOLOCK)
	on ConEEID = xEEID
where ConRelationship IN ('CHL','DCH','DPC','STC') 
order by A.ConEEID, A.ConDateOfBirth*/

Select distinct s.ConNameLast, s.ConNameFirst,  /*s.ConSystemId,*/ p.ConNameLast, p.ConNameFirst, s.ConSSN, p.ConSSN, /*p.ConsystemId,*/ s.ConDateOfBirth, p.ConDateOfBirth, s.ConEEID, p.ConEEID
FROM Contacts s, Contacts p
where /*s.ConSystemId <> p.ConSystemId AND*/ s.ConDateOfBirth = p.ConDateOfBirth AND s.ConEEID = p.ConEEID AND s.ConSSN <> p.ConSSN
order by s.ConEEID

Select distinct s.ConSystemId,  p.ConsystemId,  s.ConEEID
FROM Contacts s, Contacts p
where /*s.ConSystemId <> p.ConSystemId AND*/ s.ConDateOfBirth = p.ConDateOfBirth AND s.ConEEID = p.ConEEID AND s.ConSSN <> p.ConSSN
order by s.ConEEID


--Select ConEEID, ConSSN, ConDateOfBirth, ConNameLast, ConNameFirst, ConSystemId, ConRelationship  from Contacts where ConRelationship IN ('CHL','DCH','DPC','STC') 
--AND ConEEID = 'AHZGZ80000K0'

