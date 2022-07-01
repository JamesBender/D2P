--sp_getEEID 'Antley' -- E9NNWN000040

DECLARE @EEID VARCHAR(12) = 'E9NNWN000040'

SELECT * from dbo.U_EUHCFINPRO_drvTbl where drvEEID = @EEID

select * from dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK) where EedEEID = @EEID AND EedFormatCode = 'EUHCFINPRO'

/* I need to know for Joseph Antley what fileds are missing, and what they should be*/