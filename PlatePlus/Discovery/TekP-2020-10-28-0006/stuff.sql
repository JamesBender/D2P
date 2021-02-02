select * from dbo.U_EDISCOBREX_drvTbl_QBPLANINITIAL;

--sp_getEEID 'CVV8ZN000020'
--sp_getEEID 'CL40N600P020'


select * from dbo.U_dsi_BDM_EDISCOBREX WITH (NOLOCK) where BdmRunID = 'QB'

select * from dbo.U_dsi_BDM_Configuration where FormatCode = 'EDISCOBREX'


