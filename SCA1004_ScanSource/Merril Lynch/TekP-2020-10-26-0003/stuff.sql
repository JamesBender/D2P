--select * from EmpINtl
--where EinUDField01 = '002000270'

--sp_getEEID 'DMJXLK00A030'



--select top 10 EetEEID,  LEFT(EetTaxCode, 2), EetTaxCode, EetIsEmpCompTaxCode, * from EmpTax
--where EetTaxCode LIKE '%SUI%'


select * from dbo.U_EMLEQESPEX_drvTbl_IBSH01
--where drvTinType = 'C'


select top 10 * from EmpTax
where EetTaxCode IN ('USSOCEE','USMEDEE')

select top 10 PthCurTaxAmt, PThIsPercentOfFit, PthWagePercentAmt, * from PTaxHist
where pthTaxCode LIKE '%FIT%'

select distinct PthWagePercentAmt from PTaxHist where pthTaxCode LIKE '%FIT%'

--select distinct CmpCompanyCode from Company -- Component Company

select top 10 * from TaxCode where CtcTaxcode LIKE '%FIT%'