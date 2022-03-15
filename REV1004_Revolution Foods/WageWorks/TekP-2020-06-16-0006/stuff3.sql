select EdhEEID, EdhChangeReason, EdhBenStatusDate, EecEmplStatus, EepNameLast, EepNameFirst, EepSSN, EdhDedCode, * -- EdhEEID, EdhDedCode, EdhChangeReason, EdhBenStatusDate, * 
from EmpHDed A
join EmpComp on EdhEEID = EecEEID and EdhCOID = EecCOID
join EmpPers on EepEEID = EdhEEID
join  dbo.U_EWWCOBCMBX_EEList on EdhEEID = xEEID
where --EdhChangeReason IN ('201','204','210','LEVNT3','LEVNT4')
--AND 
EdhDedCode IN ('MEDCI','MEDCO','MEDM1','MEDM2','MEDH3','MEDM3','MEDB1','MEDB2','MDK2C','MDK1C','DHPPT','DHPPD','DHPPC','DHPPR','DHPPT','DLPPT','DLPPC','DLPPR','DLPPD','DHMOT','DHMOC','VSP')
AND EdhBenStatusDate >= '1/1/2020'
and EdhEEID IN ('CVLO6E000030', 'BXAMKL0000K0','DCSAP5001030','BN7RK70000K0','CV4XVL000030','D8VRO3000030')
order by A.EdhEEID




select * from dbo.U_EWWCOBCMBX_drvTbl where drvEEID IN ('CVLO6E000030', 'BXAMKL0000K0','DCSAP5001030','BN7RK70000K0','CV4XVL000030','D8VRO3000030')

select * FROM dbo.U_dsi_BDM_EWWCOBCMBX WITH (NOLOCK) where BdmEEID IN ('CVLO6E000030', 'BXAMKL0000K0','DCSAP5001030','BN7RK70000K0','CV4XVL000030','D8VRO3000030')
--sp_getEEID 'Harris' -- CVLO6E000030
--sp_getEEID 'Deonarine' -- BXAMKL0000K0
--sp_getEEID 'Hayden' --DCSAP5001030
--sp_getEEID 'Henriquez' --BN7RK70000K0
--sp_getEEID 'Smith' -- CV4XVL000030
--sp_getEEID 'Thomas' --D8VRO3000030



