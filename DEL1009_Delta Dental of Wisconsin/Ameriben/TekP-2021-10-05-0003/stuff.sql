--select drvREF02_RefNumberQual1, * from dbo.U_EAMBIHW834_DrvTbl --WHERE drvINS01_YesNoCond = 'Y'
--where drvREF02_RefNumberQual1 is not null


--sp_getEEID 'Mikulak' -- B6REIS0010K0

--select * from dbo.U_dsi_bdm_EAMBIHW834 WITH (NOLOCK) where BdmEEID = 'B6REIS0010K0'

--sp_getEEID 'Simcakoski' -- BMUNFB0000K0

/*
select drvFSA00_ReasonCode, drvFSA00_Coverage, drvFSA00_MaintTypeCode ,drvFSA00_AmountQualifierCode1 
        ,drvAMTFSA01_AmountQualifierCode1 
        ,drvAMTFSA02_MonetaryAmount1 
        ,drvDTP00FSA_DateTime_348 
        ,drvDTP01FSA_DateTimeQualifier_348 
        ,drvDTP02FSA_DateTimeFormatQual_348 
        ,drvDTP03FSA_DateTimePeriod_348
from dbo.U_EAMBIHW834_DrvTbl_2300
where drvEEID = 'BMUNFB0000K0'
*/


--sp_getEEID 'Jampana' -- DYLP2M000020

/*select drvInitialSort         ,drvSubSort, *
from dbo.U_EAMBIHW834_DrvTbl_2300
where drvEEID = 'DYLP2M000020'

select * from dbo.U_dsi_bdm_EAMBIHW834 WITH (NOLOCK) where BdmEEID = 'DYLP2M000020'*/

--sp_getEEID 'Pradhan' -- B6REK300V0K0

/*select drvInitialSort         ,drvSubSort, *
from dbo.U_EAMBIHW834_DrvTbl_2300
where drvEEID = 'B6REK300V0K0'*/

--sp_getEEID 'Driscoll' -- DYLQ91004020

select drvInitialSort         ,drvSubSort, *
from dbo.U_EAMBIHW834_DrvTbl_2300
where drvEEID = 'DYLQ91004020'

/*

2) I Need a little help with this one. The mapping has MM hardcoded for HD03, and it doesn't have talk about changing the DTP 348 by deduciton code. Do these two people just have a blank for HD03 and no DTP 348 segment?

6) I think this is realated to issue #2. If that gets resolved this should be OK as well.

8 & 9) Also related to #2


*/