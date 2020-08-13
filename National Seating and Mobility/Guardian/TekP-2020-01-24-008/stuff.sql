--select distinct drvEEID, drvNM103_NameLast1, drvNM104_NameFirst1 from dbo.U_EGACCCI834_DrvTbl A where drvNM103_NameLast1 IN ('Wile','Clark', 'Pavlakovich', 'Gorovits','Schoen','Nasello') order by drvNM103_NameLast1

select EepEEID, EepNameLast, EepNameFirst from EmpPers where EepEEID IN ('D9JHCZ000030','D82MR8000030','D8VXPN000030','D8M4N1000030',/*'C1GLYB0060K0',*/'C1GLGJ0W70K0')

select drvInitialSort,drvSubSort, drvEEID, drvHD04_PlanCoverageDesc, drvHD02_MaintReasonCode, * 
from dbo.U_EGACCCI834_DrvTbl_2300 A
where drvEEID IN ('D9JHCZ000030','D82MR8000030','D8VXPN000030','D8M4N1000030',/*'C1GLYB0060K0',*/'C1GLGJ0W70K0')
--AND drvHD02_MaintReasonCode IN ('CECN1','CECN2','CECS1','CECS2','CEFN1','CEFN2','CEFS1','CEFS2','CEON1','CEON2','CEOS1','CEOS2','CESN1','CESN2','CESS1','CESS2') 
--AND drvHD04_PlanCoverageDesc NOT IN ('ADVANTAG')
order by A.drvInitialSort, A.drvSubSort

select EdhEEID, EdhDedCode, EdhEEBenAmt, * from EmpHDed 
where EdhEEID IN ('D9JHCZ000030','D82MR8000030','D8VXPN000030','D8M4N1000030',/*'C1GLYB0060K0',*/'C1GLGJ0W70K0') 
AND EdhDedCode  IN ('CECN1','CECN2','CECS1','CECS2','CEFN1','CEFN2','CEFS1','CEFS2','CEON1','CEON2','CEOS1','CEOS2','CESN1','CESN2','CESS1','CESS2') 
AND EdhBenStatus = 'A'
AND EdhBenStartDate >= '1/1/2020'

select distinct pdhEEID, PdhDedCode, /*pdhPerControl,*/ PdhBenAmt
from dbo.pDedHist 
where pdhEEID IN ('D9JHCZ000030','D82MR8000030','D8VXPN000030','D8M4N1000030','C1GLYB0060K0','C1GLGJ0W70K0') 
AND PdhDedCode IN ('CECN1','CECN2','CECS1','CECS2','CEFN1','CEFN2','CEFS1','CEFS2','CEON1','CEON2','CEOS1','CEOS2','CESN1','CESN2','CESS1','CESS2') 
AND LEFT(PdhPerControl, 4) = '2020'