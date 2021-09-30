--sp_getEEID 'Larrimore' -- BY2HL80000K0
select ConNameFirst, ConSSN, ConDateOfBirth, ConSystemId, * from Contacts where ConEEID = 'BY2HL80000K0'

select distinct * from dbo.U_dsi_BDM_EDSQBNPMEX WITH (NOLOCK)
where BdmEEID IN ('C2RGSS0000K0','BY2HL80000K0') AND BdmSystemId = 'DGGXMN000030'

select * from dbo.U_EDSQBNPMEX_drvTbl_QB where drvEEID = 'BY2HL80000K0'