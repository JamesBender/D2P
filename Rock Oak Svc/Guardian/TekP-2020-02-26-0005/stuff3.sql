--sp_getEEID 'Risher' -- CY0KSF000040

select ConSystemId, * from Contacts where ConEEID = 'CY0KSF000040' AND ConRelationship = 'SPS';

/*select * from EmpHDed
where EdhEEID = 'CYS88U000040'
and EdhDedCode = 'SU298'
AND EdhBenStatus = 'A'*/

select EedEEID, EedDepRecId, EedDedCode, * from EmpDedFull
where EedEEID = ' ANCY0KSF000040'
AND EedDedCode IN ('SU293')
AND EedBenStatus = 'A'

SELECT EedEEID, EedCOID, EedDepRecId
FROM dbo.EmpDedFull WITH (NOLOCK)
WHERE EedDedCode = 'SU298'
AND EedBenStatus = 'A'