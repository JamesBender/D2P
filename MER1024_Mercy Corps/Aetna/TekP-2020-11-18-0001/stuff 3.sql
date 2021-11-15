SELECT LEFT(CodCode, 2) AS CovState, RIGHT(RTRIM(CodCode), 4) AS CovCode, CodDesc AS CovCoverage
FROM Codes A WITH (NOLOCK)
WHERE CodTable = 'CO_MCAETNASTATES'
--AND LEFT(RIGHT(RTRIM(CodCode), 4), 3) NOT IN ('DEN','VIS','HSA')
order by LEFT(A.CodCode, 2), RIGHT(RTRIM(A.CodCode), 4)