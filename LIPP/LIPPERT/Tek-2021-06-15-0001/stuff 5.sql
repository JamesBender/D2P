--sp_getEEID 'Christensen' -- DGI2ZJ000020
--sp_getEEID 'Larson' -- DGI2ZM00I020
--sp_getEEID 'Haakenson' -- DGI2ZP00Y020
--sp_getEEID 'Dice' -- DGI35V00S020
--sp_getEEID 'Dolan' -- DGI7WG000020

select drvhrstatusDate, * from dbo.U_EAV3_drvTbl
--where drvEEID = 'DGI2ZJ000020'
--where drvEEID = 'DGI2ZM00I020'
--where drvEEID = 'DGI2ZP00Y020'
--where drvEEID = 'DGI35V00S020'
where drvEEID = 'DGI7WG000020'