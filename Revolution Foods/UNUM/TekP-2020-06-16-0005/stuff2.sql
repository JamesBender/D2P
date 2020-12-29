-- Report term if in date range of file, ADDE/C should be included, but aren’t. Can’t have a spouse/child w/o employee

select drvBenefitID4, drvBenefitID5, drvBenefitID6,* from dbo.U_EUNUMLAEXP_drvTbl
--where drvNameLast IN ('Callis','Lomeli')
where drvEEID IN ('96HXAX0010K0','BSO8F40000K0','CTRHQX000030')

--sp_getEEID 'Roddey'

-- 202009171
-- 202010019

select * from dbo.U_dsi_BDM_EUNUMLAEXP WITH (NOLOCK)
where BdmEEID IN ('96HXAX0010K0') --,'BSO8F40000K0')

/*
select EedDedCode, * from EmpDed
where EedDedCode IN ('ADDS','ADDE','ADDC')
AND EedEEID = '96HXAX0010K0'


select EdhDedCode, * from EmpHDed
where EdhEEID = '96HXAX0010K0'
AND EdhDedCode	IN ('ADDS','ADDE','ADDC')
order by EdhDateTimeCreated DESC
*/



--select * from dbo.U_EUNUMLAEXP_DedList
