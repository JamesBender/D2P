--sp_getEEID 'Singh' -- DM562F000020
--sp_getEEID 'Sidhu' -- DI8QX3000020
--sp_getEEID 'Mandani' -- CDWDO202T0K0
--sp_getEEID 'Dutallas' -- CDWDLT00A0K0 -- 703554   
--sp_getEEID 'Adamson' -- DJZL6L006020
--sp_getEEID 'Boufford' -- DPHGIQ000020
--sp_getEEID 'Flores' -- 'CDWDN80000K0'
--sp_getEEID 'Keeping' -- CDWDNP0000K0
--sp_getEEID 'Lamb' -- CDWDOK02A0K0

--DECLARE @EEID varchar(12) = 'DM562F000020'; -- should send all
--DECLARE @EEID varchar(12) = 'DI8QX3000020'; -- just member
--DECLARE @EEID VARCHAR(12) = 'CDWDO202T0K0'; --just member
--DECLARE @EEID VARCHAR(12) = 'CDWDLT00A0K0'; -- just member
--DECLARE @EEID VARCHAR(12) = 'DJZL6L006020'; -- all
--DECLARE @EEID VARCHAR(12) = 'DPHGIQ000020'; -- all
--DECLARE @EEID VARCHAR(12) = 'CDWDN80000K0'; -- all
--DECLARE @EEID VARCHAR(12) = 'CDWDNP0000K0'; -- just member
DECLARE @EEID VARCHAR(12) = 'CDWDOK02A0K0';

select * from dbo.U_ESUNLIF2_Member where drvEEID = @EEID

--select * from dbo.U_ESUNLIF2_Person where drvEEID = @EEID

--select * from dbo.U_ESUNLIF2_Salary where drvEEID = @EEID

--select * from dbo.U_ESUNLIF2_Address where drvEEID = @EEID

--select * from dbo.U_ESUNLIF2_Dep where drvEEID = @EEID

select * from dbo.U_ESUNLIF2_Benefit where drvEEID = @EEID



--select * from dbo.U_ESUNLIF2_Audit where audEEID = @EEID

select EedValidForExport, * from dbo.U_DSI_BDM_EmpDeductions WITH (NOLOCK) where  EedFormatCode = 'ESUNLIF2' AND EedEEID = @EEID

--select * from U_DSI_BDM_DepDeductions WITH (NOLOCK) where  DbnFormatCode LIKE 'ESUNLIF%' AND DbnEEID = @EEID

--Select EecEmplStatus, EecTermREason, * from EmpComp where EecEEID = @EEID

--select * from EmpDed where EedEEID = @EEID and EedDedCode IN ('CCDEN','CPDEN','CDENT','CSDEN','CVDEN','CDENQ','CHLHQ','CHLTH','CCHLH','CPHLH','CHLHQ','CHLTH','CSHLH','CVHLH','CCLIF','CPLIF','CSLIF','CVLIF','CLIFE','CLTD','CCLTD','CPLTD','CSLTD','CVLTD','CELTD','CCDLI','CPDLI','CSDLI','CVDLI','CDLIF')
