--sp_getEEID 'Long' -- EB5N7X000040
--sp_getEEID 'Craig' -- D4XGUF000040

--DECLARE @EEID VARCHAR(12) = 'EB5N7X000040'
DECLARE @EEID VARCHAR(12) = 'D4XGUF000040'

select * from dbo.U_EEMP401KEX_drvTbl where drvEEID = @EEID

select * from dbo.U_EEMP401KEX_PEarHist WITH (NOLOCK) where PehEEID = @EEID
        
select * from  dbo.U_EEMP401KEX_PDedHist where pdhEEID = @EEID

-- 202206301
-- TEST_XOE
--select * from dbo.AscExp WHERE expFormatCode = 'EEMP401KEX';