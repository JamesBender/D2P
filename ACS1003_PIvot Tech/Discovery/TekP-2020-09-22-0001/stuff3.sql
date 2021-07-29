--sp_getEEID 'Kowalsky' -- DTPCI5000030
--sp_getEEID 'Showers' -- C5DNHR0000K0

--select * from dbo.U_EDSQBNPMEX_EEList where xEEID = 'DTPCI5000030'

--select distinct BdmEEID from dbo.U_dsi_BDM_EDSQBNPMEX WITH (NOLOCK) where BdmRunId = 'NPM'
--where BdmEEID = 'DTPCI5000030'
--where BdmEEID = 'C5DNHR0000K0'


select DedDedCode, EedBenStatus, EedNotes, EedChangeReason, EedDedRowStatus, * from dbo.U_dsi_BDM_EmpDeductions 
where EedFormatCode = 'EDSQBNPMEX'
AND EedEEID = 'DTPCI5000030'
and EedRunID = 'NPM'

select DedDedCode, EedBenStatus, EedNotes, EedChangeReason, EedDedRowStatus, * from dbo.U_dsi_BDM_EmpDeductions 
where EedFormatCode = 'EDSQBNPMEX'
AND EedEEID = 'C5DNHR0000K0'
and EedRunID = 'NPM'

/*
select DedDedCode, EedBenStatus, EedNotes, EedChangeReason, EedDedRowStatus, * from dbo.U_dsi_BDM_EmpDeductions 
where EedFormatCode = 'EDSQBNPMEX'
AND EedEEID = 'DT3RL0000030'
and EedRunID = 'NPM'
*/