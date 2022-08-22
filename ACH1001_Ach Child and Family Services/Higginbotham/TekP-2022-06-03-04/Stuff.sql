SELECT bdmEEID, BdmSystemID, 1 AS Number
FROM dbo.U_dsi_BDM_EAHIGGCOQB
JOIN dbo.Contacts ON bdmEEID = ConEEID
WHERE BdmDedCode IN ('MDPOS', 'MDBP', 'DEN', 'VIS', 'FSA')
AND BdmRecType = 'DEP'
AND bdmRelationship = 'SPS'


SELECT bdmEEID, BdmSystemID, 
FROM dbo.U_dsi_BDM_EAHIGGCOQB
JOIN dbo.Contacts ON bdmEEID = ConEEID
WHERE BdmDedCode IN ('MDPOS', 'MDBP', 'DEN', 'VIS', 'FSA')
AND BdmRecType = 'DEP'
AND bdmRelationship = 'CHL'
ORDER BY BdmEEID, ConDateOfBirth


SELECT DISTINCT 
bdmEEID, 
BdmSystemID,
RANK() Over (PARTITION BY bdmEEID
			ORDER BY ConDateOfBirth DESC
			) AS Child_ONumber
FROM (SELECT DISTINCT bdmEEID, BdmSystemID, ConDateOfBirth
 FROM dbo.U_dsi_BDM_EAHIGGCOQB
JOIN dbo.Contacts ON bdmEEID = ConEEID
WHERE BdmDedCode IN ('MDPOS', 'MDBP', 'DEN', 'VIS', 'FSA')
AND BdmRecType = 'DEP'
AND bdmRelationship = 'CHL'
AND ConDateOfBirth <> '1900-01-01 00:00:00.000') AS c
ORDER BY BdmEEID,Child_ONumber


SELECT DISTINCT bdmEEID, BdmSystemID, ConDateOfBirth
 FROM dbo.U_dsi_BDM_EAHIGGCOQB
JOIN dbo.Contacts ON --bdmEEID = ConEEID
	 ConSystemID = BdmSystemID
WHERE BdmDedCode IN ('MDPOS', 'MDBP', 'DEN', 'VIS', 'FSA')
AND BdmRecType = 'DEP'
AND bdmRelationship = 'CHL'
--AND ConDateOfBirth <> '1900-01-01 00:00:00.000'
ORDER BY BdmEEID, ConDateOfBirth DESC

SELECT Distinct bdmEEID, BdmSystemID, ConDateOfBirth
FROM  dbo.U_dsi_BDM_EAHIGGCOQB
JOIN dbo.Contacts ON ConSystemID = BdmDepRecID
WHERE BdmRecType = 'DEP'
AND bdmRelationship = 'CHL'

SELECT *
FROM Contacts
WHERE ConSystemID = 'CPDO2Q00D030'

SELECT *
FROM dbo.U_dsi_BDM_EAHIGGCOQB
JOIN Contacts ON ConSystemID = BdmDepRecID


SELECT DISTINCT 
bdmEEID, 
BdmSystemID,
RANK() Over (PARTITION BY bdmEEID
			ORDER BY ConDateOfBirth DESC
			) AS Child_ONumber
FROM (SELECT DISTINCT bdmEEID, BdmSystemID, ConDateOfBirth
 FROM dbo.U_dsi_BDM_EAHIGGCOQB
JOIN dbo.Contacts ON ConSystemID = BdmDepRecID
WHERE BdmDedCode IN ('MDPOS', 'MDBP', 'DEN', 'VIS', 'FSA')
AND BdmRecType = 'DEP'
AND bdmRelationship = 'CHL'
AND ConDateOfBirth <> '1900-01-01 00:00:00.000') AS c
ORDER BY BdmEEID,Child_ONumber

SELECT DISTINCT, BdmDepRecID, ConDateOfBirth
FROM dbo.U_dsi_BDM_EAHIGGCOQB
JOIN dbo.Contacts ON ConSystemID = BdmDepRecID
WHERE BdmEEID  = 'CO1JE0000030'
AND bdmRelationship = 'CHL'
ORDER BY ConDateOfBirth desc

SELECT DISTINCT
b.bdmEEID, b.BdmDepRecID, 'Child' AS RElationahhip,
	RANK() OVER 
	(PARTITION BY b.bdmEEID ORDER BY MAX(c.ConDateOfBirth) DESC) AS RANK 
FROM dbo.U_dsi_BDM_EAHIGGCOQB AS b
JOIN dbo.Contacts  AS c ON ConSystemID = BdmDepRecID
WHERE b.bdmRelationship = 'CHL' --AND BdmEEID  = 'CO1JDB01V030'
--AND ConDateOfBirth <> '1900-01-01 00:00:00.000'
GROUP BY bdmEEID, b.BdmDepRecID
ORDER BY BdmEEID

CREATE TABLE dbo.EAHIGGCOQB_Dependents
(EEID VARCHAR (20) NOT NULL
,SystemID VARCHAR(20) NOT NULL
, Relationship VARCHAR(20) NOT NULL
,Rank INT NOT NULL
)

INSERT INTO dbo.EAHIGGCOQB_Dependents 
(EEID
,SystemID
,Relationship
,Rank)
SELECT bdmEEID, BdmSystemID, 'SPOUSE', 1 
FROM dbo.U_dsi_BDM_EAHIGGCOQB
JOIN dbo.Contacts ON bdmEEID = ConEEID
WHERE BdmDedCode IN ('MDPOS', 'MDBP', 'DEN', 'VIS', 'FSA')
AND BdmRecType = 'DEP'
AND bdmRelationship = 'SPS'

INSERT INTO dbo.EAHIGGCOQB_Dependents 
(EEID
,SystemID
,Relationship
,Rank)
SELECT DISTINCT
b.bdmEEID, b.BdmDepRecID, 'Child' AS RElationahhip,
	RANK() OVER 
	(PARTITION BY b.bdmEEID ORDER BY MAX(c.ConDateOfBirth) DESC) AS RANK 
FROM dbo.U_dsi_BDM_EAHIGGCOQB AS b
JOIN dbo.Contacts  AS c ON ConSystemID = BdmDepRecID
WHERE b.bdmRelationship = 'CHL' --AND BdmEEID  = 'CO1JDB01V030'
--AND ConDateOfBirth <> '1900-01-01 00:00:00.000'
GROUP BY bdmEEID, b.BdmDepRecID
ORDER BY BdmEEID

UPDATE dbo.EAHIGGCOQB_Dependents 
SET Rank = Rank + 1
WHERE Relationship = 'CHILD'

SELECT *
FROM dbo.EAHIGGCOQB_Dependents
order by EEID, Rank
DROP TABLE dbo.EAHIGGCOQB_Dependents


SELECT i.ProductID, p.Name, i.LocationID, i.Quantity  
    ,RANK() OVER   
    (PARTITION BY i.LocationID ORDER BY i.Quantity DESC) AS Rank  
FROM Production.ProductInventory AS i   
INNER JOIN Production.Product AS p   
    ON i.ProductID = p.ProductID  
WHERE i.LocationID BETWEEN 3 AND 4  
ORDER BY i.LocationID;  
GO  

SELECT DISTINCT
bdmEEID, .BdmDepRecID,-- c.ConDateOfBirth,
	RANK() OVER 
	(PARTITION BY b.bdmEEID ORDER BY MAX(c.ConDateOfBirth) DESC) AS RANK 
FROM (SELECT DISTINCT  dbo.U_dsi_BDM_EAHIGGCOQB AS b
JOIN dbo.Contacts  AS c ON ConSystemID = BdmDepRecID
WHERE b.bdmRelationship = 'CHL' AND BdmEEID  = 'CO1JDB01V030'
AND ConDateOfBirth <> '1900-01-01 00:00:00.000') bc
GROUP BY bdmEEID, b.BdmDepRecID
ORDER BY BdmEEID



select *
from Contacts WHERE ConSystemID = 'CPDO2O09J030'





