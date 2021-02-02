select * from dbo.U_EDISFHSAEX_drvTbl_CT
--where drvEEID = 'CP2Y3900V030'
--where drvEEID = 'CP2Y3600X030'
where drvEEID = 'CP2Y2V000030'

/*select BdmBenStartDate, --CASE WHEN BdmDedCode IN ('FASDC','FSA','FSALP','HSACF','HSACI','HSAF','HSAI','PARK','CMT') THEN
											CASE WHEN DATEPART(YEAR, BdmBenStartDate) <= 2021 THEN dbo.dsi_fnGetMinMaxDates('MAX', BdmBenStartDate, '1/1/2021')
												ELSE dbo.dsi_fnGetMinMaxDates('MAX', BdmBenStartDate, '1/1/' + FORMAT(DATEPART(YEAR, BdmBenStartDate), '0000'))                                                
											END
										--END 
										AS TES, * from dbo.U_dsi_BDM_EDISFHSAEX WITH (NOLOCK)
where BdmEEID = 'CP2Y2V000030'
and bdmDedCode = 'FSADC'*/

select * from dbo.U_dsi_BDM_EDISFHSAEX WITH (NOLOCK) where BdmEEID = 'CP2Y2V000030'

select * from dbo.U_EDISFHSAEX_PDedHist WITH (NOLOCK) where PdhEEID = 'CP2Y2V000030'


--sp_getEEID 'Askins'
--sp_getEEID 'Hall' -- CP2Y2V000030
--sp_getEEID 'O''Hara' -- CP2Y3600X030