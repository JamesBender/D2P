--sp_GetEEID 'Bai' -- E7V7RT000030
--sp_getEEID 'Adibfar'  -- E32VCH000030
--sp_getEEID 'Daniels' -- DHOPCJ000030
--sp_getEEID 'giesing' -- CMDK4V00C030

--DECLARE @EEID VARCHAR(12) = 'E7V7RT000030'
--DECLARE @EEID VARCHAR(12) = 'E32VCH000030'
--DECLARE @EEID VARCHAR(12) = 'DHOPCJ000030'
DECLARE @EEID VARCHAR(12) = 'CMDK4V00C030'

select drvSubSort, * from dbo.U_EGDLSTD834_DrvTbl_2300 where drvEEID = @EEID

select * from dbo.U_dsi_bdm_EGDLSTD834 WITH (NOLOCK) where BdmEEID = @EEID and BdmDedCode LIKE 'LIFE%'


/*

1. None of the examples provided have LIFES coverage. 
3. The mapping document does not have this, the mapping it does provide spcifies has numeric values. Can you confirm this?

*/