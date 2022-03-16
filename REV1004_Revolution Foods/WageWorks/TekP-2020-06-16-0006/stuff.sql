SELECT EDHEEID, EdhCOID, EdhDedCode, edhChangeReason, EdhEffDate, BchIsCOBRAQualifiedEvent
    --INTO dbo.U_EOPTCBRAQB_Edh_WorkingTable
    FROM (SELECT EDHEEID, EdhCOID, EdhDedCode, edhChangeReason, EdhEffDate, BchIsCOBRAQualifiedEvent, ROW_NUMBER() OVER(PARTITION BY EdhEEID, EdhCOID, EdhDedCode ORDER BY EdhEffDate DESC) AS rn 
            FROM dbo.EmpHDed a WITH (NOLOCK)
            JOIN dbo.BenChRsn WITH (NOLOCK)
                ON EdhChangeReason = BchCode
            WHERE EdhDedCode IN ('MEDCI','MEDCO','MEDM1','MEDM2','MEDH3','MEDM3','MEDB1','MEDB2','MDK2C','MDK1C','DHPPT','DHPPD','DHPPC','DHPPR','DHPPT','DLPPT','DLPPC','DLPPR','DLPPD','DHMOT','DHMOC','VSP') 
				--AND edhChangeReason IN ('200','BAP','D','DLS','M','NLEE','NLEDR','TOE','LEVNT1','LEVNT2','LEVNT3','LEVNT4','LEVNT5')
				AND EdhChangeReason IN ('201','204','205','210','LEVNT3','LEVNT4')
			) AS T
    WHERE RN = 1


	select * from BenChRsn
	 where BchIsCobraQualifiedEvent = 'Y'
	 order by BchCode
	--where BchCode IN ('201','204','205','210','LEVNT3','LEVNT4')-











    select * -- drvActionCode, drvQuallifingEventDate, drvLastPreCobraCovered, * 
from dbo.U_EWWCOBCMBX_drvTbl
--where drvActionCode IN ('03a', '03b', '06')
where drvEEID = 'BQGFO70000K0'


select BdmCobraReason, BdmIsPQB, BdmChangeReason, * from dbo.U_dsi_BDM_EWWCOBCMBX WITH (NOLOCK) where BdmEEID = 'BQGFO70000K0' order by BdmDepRecID

select distinct BdmCobraReason from dbo.U_dsi_BDM_EWWCOBCMBX WITH (NOLOCK)

/*select eepDateOfCOBRAEvent, eepCOBRAStatus, eepCOBRAStatusDate, * from EmpPers where EepEEID IN (select distinct drvEEID
from dbo.U_EWWCOBCMBX_drvTbl
where drvActionCode IN ('03a', '03b', '06'))*/					