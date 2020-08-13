select * from dbo.U_ELINFINEXP_drvTbl where drvEEID = 'D3ZW1U000020'

select EdhDedCode, edhEffDAte, edhBenStatus, * from EmpHDed where /*edhBenStatus = 'A' and*/ edhEEId = 'D3ZW1U000020' AND EdhDedCode IN ('BLIFE', 'DEN1', 'DEN2', 'LTD', 'STD', 'VIS', 'VLIFC', 'VLIFE', 'VLIFS')

select BdmBenStartDate, * from dbo.U_dsi_BDM_ELINFINEXP where BdmEEID= 'D3ZW1U000020' and BdmDedCode IN ('BLIFE', 'DEN1', 'DEN2', 'LTD', 'STD', 'VIS', 'VLIFC', 'VLIFE', 'VLIFS')