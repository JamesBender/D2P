--sp_getEEID 'Thomas' -- BK2R9500G0K0
--sp_getEEID 'Bornstein' -- BK2RD300P0K0
--sp_getEEID 'Gutierrez' -- BK2RMF0000K0
--sp_getEEID 'Prather' -- DMVFO4000040

select drvLastPreCobraCovered, drvQuallifingEventDate, * from dbo.U_EARICOB_drvTbl
where drvEEID = 'DMVFO4000040' -- 'BK2RMF0000K0' -- 'BK2RD300P0K0' -- 'BK2R9500G0K0'



/*
select ConNameFirst, ConNameLast, ConRelationship, ConCobraStatusDate, * from Contacts 
where ConEEID = 'DMVFO4000040'

select * from dbo.U_dsi_BDM_EARICOB WITH (NOLOCK)
where BdmEEID = 'DMVFO4000040' and BdmRecType = 'DEP'
*/

