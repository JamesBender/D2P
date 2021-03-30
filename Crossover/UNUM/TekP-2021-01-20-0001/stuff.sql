--sp_getEEID 'Schopf' -- DKQ8QS000030
--sp_getEEID 'Gladstone' -- DLT8GW000030

select EedDedCode, EedEOIDesiredAmt, * from EmpDed 
where 
	--EedEEID = 'DKQ8QS000030' 
	EedEEID = 'DLT8GW000030'
AND EedDedCode IN ('UNVOL','VOLCH','VOLSP')

select drvBenSelAmt1, * from dbo.U_Dsi_DrvTbl_EUNMVLFCH2
--where drvEEID = 'DKQ8QS000030'
WHERE drvEEID = 'DLT8GW000030'

select DedBenAmtMax, DedDedCode, * from DedCode where DedDedCode IN ('UNVOL','VOLCH','VOLSP')