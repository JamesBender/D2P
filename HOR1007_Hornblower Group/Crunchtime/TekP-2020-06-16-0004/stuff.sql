select EacEEID, EacAccrCode, EacAccrAllowedCurBal, EacDateAccruedThru, * 
from EmpAccr
where EacAccrCode LIKE 'SICK%'
and EacEEID IN ('ANBCFI0000K0','ANBCFV0000K0','ANBCG10000K0','ANBCG40000K0')
