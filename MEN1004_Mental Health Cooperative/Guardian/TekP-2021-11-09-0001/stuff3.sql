--sp_getEEID 'Haga' - CIEE
--sp_getEEID 'Westhoff' - CI
--sp_getEEID 'Kauderer' - 
--sp_getEEID 'Levan'
--sp_getEEID 'Geno'

--DECLARE @EEID VARCHAR(12) = 'CVWX9R000020'
--DECLARE @EEID VARCHAR(12) = 'D4JT19001020'
--DECLARE @EEID VARCHAR(12) = 'C39X4O0000K0'
--DECLARE @EEID VARCHAR(12) = 'CGDKMQ006020'
DECLARE @EEID VARCHAR(12) = 'E1REGE000020'

select * from dbo.U_EGRDHW834E_DrvTbl_2300
where drvEEID = @EEID


select * from dbo.U_dsi_bdm_EGRDHW834E WITH (NOLOCK)
where BdmEEID = @EEID