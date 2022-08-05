--sp_getEEID 'Hodge' -- DHMUM5079050
--sp_getEEID 'Perez'-- DHMUNI02S050

DECLARE @EEID VARCHAR(12) = 'DHMUM5079050'
--DECLARE @EEID VARCHAR(12) = 'DHMUNI02S050'

SELECT drvEECIAppCovAmount, drvSpCoverageEffectiveDate, drvChCoverageAmount, drvChCoverageEffectiveDate, * FROM dbo.U_ECIGACHEXP_drvTbl where drvEEID = @EEID

SELECT * FROM dbo.U_dsi_BDM_ECIGACHEXP WITH (NOLOCK) where BdmEEID = @EEID

SELECT * FRom Contacts where conEEID = @EEID AND ConSystemId = 'DKR99A0C2050'
        AND ConRelationship IN ('SPS','DP')


--SELECT COUNT(*) 
--FROM dbo.Contacts WITH (NOLOCK)
--WHERE --ConSystem = AND
--ConRelationship
