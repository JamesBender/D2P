--sp_getEEID 'Ballard' -- DKTX8X000050
--sp_getEEID 'Bailey' -- E403JM000050
--sp_getEEID 'Dean' -- E111DC000050
--sp_getEEID 'Sharp' -- DJVX5U000050
--sp_getEEID 'Terrell' -- E4X9ZF05Z050
--sp_getEEID 'Kokassa' -- DC4DA4000050
--sp_getEEID 'Watson' -- E4RN7F000050

--DECLARE @EEID VARCHAR(12) = 'DKTX8X000050';
--DECLARE @EEID VARCHAR(12) = 'E403JM000050';
--DECLARE @EEID VARCHAR(12) = 'E111DC000050';

DECLARE @EEID VARCHAR(12) = 'DJVX5U000050';

--DECLARE @EEID VARCHAR(12)= 'E4X9ZF05Z050'
--DECLARE @EEID VARCHAR(12) = 'DC4DA4000050'
--DECLARE @EEID VARCHAR(12) = 'E4RN7F000050';

select drvPayType, * from dbo.U_ECCCPAYEXP_drvTbl
where drvEEID = @EEID