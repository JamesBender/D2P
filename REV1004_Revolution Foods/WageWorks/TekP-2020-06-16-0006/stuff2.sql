select * from dbo.U_EWWCOBCMBX_drvTbl
--where drvActionCode > '80'


select BdmChangeReason, * from dbo.U_dsi_BDM_EWWCOBCMBX WITH (NOLOCK) where BdmRunId = 'QB' -- 323

select distinct EdhChangeReason -- EdhEEID, EdhDedCode, EdhChangeReason, EdhBenStatusDate, * 
from EmpHDed A
where EdhEEID IN (SELECT DISTINCT BdmEEID FROM dbo.U_dsi_BDM_EWWCOBCMBX WITH (NOLOCK) where BdmRunId = 'QB') AND 
EdhDedCode IN ('MEDCI','MEDCO','MEDM1','MEDM2','MEDH3','MEDM3','MEDB1','MEDB2','MDK2C','MDK1C','DHPPT','DHPPD','DHPPC','DHPPR','DHPPT','DLPPT','DLPPC','DLPPR','DLPPD','DHMOT','DHMOC','VSP')
--order by A.EdhEEID, A.EdhDedCode, A.EdhBenStatusDate desc



-- '201,204,210,LEVNT3,LEVNT4'
select EdhEEID, EdhChangeReason, EdhBenStatusDate, EecEmplStatus, EepNameLast, EepNameFirst, EepSSN, EdhDedCode, * -- EdhEEID, EdhDedCode, EdhChangeReason, EdhBenStatusDate, * 
from EmpHDed A
join EmpComp on EdhEEID = EecEEID and EdhCOID = EecCOID
join EmpPers on EepEEID = EdhEEID
join  dbo.U_EWWCOBCMBX_EEList on EdhEEID = xEEID
where EdhChangeReason IN ('201','204','210','LEVNT3','LEVNT4')
AND EdhDedCode IN ('MEDCI','MEDCO','MEDM1','MEDM2','MEDH3','MEDM3','MEDB1','MEDB2','MDK2C','MDK1C','DHPPT','DHPPD','DHPPC','DHPPR','DHPPT','DLPPT','DLPPC','DLPPR','DLPPD','DHMOT','DHMOC','VSP')
AND EdhBenStatusDate >= '1/1/2020'
order by A.EdhEEID