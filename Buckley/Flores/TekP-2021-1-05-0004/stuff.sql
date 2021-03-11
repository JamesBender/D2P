-- Having trouble seeing a "divorce" on Marshall's data

--sp_getEEID 'Marshall'--CR6M9H02U030

select * from  dbo.U_dsi_BDM_EFLROCQBXP BDM WITH (NOLOCK) where BdmEEID = 'CR6M9H02U030'

select distinct EdhChangeReason from EmpHDed where EdhEEID = 'CR6M9H02U030'


select ConRelationship, ConNameLast, ConNameFirst, ConCobraReason, ConDAteOFCobraEvent, ConSystemId, * from contacts where ConEEID = 'CR6M9H02U030' --and ConRelationship IN ('SPS','DP')


--select * from dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK) where EedEEID = 'CR6M9H02U030' AND EedFormatCode = 'EFLROCQBXP'

select * from dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK) where DbnEEID = 'CR6M9H02U030' AND DbnFormatCode = 'EFLROCQBXP'



/*

EdhChangeReason
      
100   
200   
204   
400   
900   
CHGRP 
CONV  
OE    

*/