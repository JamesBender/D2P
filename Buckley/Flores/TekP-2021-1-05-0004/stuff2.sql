--select * from dbo.U_EFLROCQBXP_drvTbl_Election;

--sp_getEEID 'Spencer' -- CR6MAE04P030

-- 201 is dep at max age

select * from dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK) where EedEEID = 'CR6MAE04P030' and EedFormatCode = 'EFLROCQBXP'
select * from dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK) where DbnEEID = 'CR6MAE04P030' and DbnFormatCode = 'EFLROCQBXP' and DbnDepRecId = 'CXTNOU0BU030' -- Madeline
select * from dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK) where DbnEEID = 'CR6MAE04P030' and DbnFormatCode = 'EFLROCQBXP' and DbnDepRecId <> 'CXTNOU0BU030' -- not Madeline

select * from EmpHDed Where EdhEEID = 'CR6MAE04P030' and EdhDedCode IN ('DEN','VISC','VISE')
order by EdhBenStatusDate DESC

select distinct * from dbo.U_dsi_BDM_EFLROCQBXP WITH (NOLOCK) 
where BdmEEID = 'CR6MAE04P030' 
--where BdmChangeReason IN ('201','203')


select * from dbo.U_EFLROCQBXP_drvTbl_Insured where drvEEID = 'CR6MAE04P030' 
select * from dbo.U_EFLROCQBXP_drvTbl_Dependent where drvEEID = 'CR6MAE04P030' 

--select ConSystemId, ConNameFirst, * from Contacts where ConEEID = 'CR6MAE04P030' -- CXTNOU0BU030