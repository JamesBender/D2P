-- Last item; person has a different BDM Cobra date for FSA

--select * from dbo.U_EDISCCOBEX_drvTbl_NPM;

--sp_getEEID 'Reed' -- BP3V0I0000K0 -- Reed,Douglas

--select * from dbo.U_EDISCCOBEX_drvTbl_QB where drvEEID = 'BP3V0I0000K0'
--select * from dbo.U_EDISCCOBEX_drvTbl_QBDEPENDENT where drvEEID = 'BP3V0I0000K0'

/*select * from dbo.U_dsi_BDM_EDISCCOBEX WITH (NOLOCK) where BdmRunId = 'QB'  -- 209
--AND BdmRelationship IS NOT NULL OR (BdmRelationship <> 'SPS' AND BdmCobraReason = '204')
AND NOT (BdmCobraReason = '204' and BdmRelationship NOT IN ('SPS','DP'))
and BdmEEID = 'BP3V0I0000K0' */


--sp_getEEID 'Fratello' -- DJOKCJ000040

select * from dbo.U_dsi_BDM_EDISCCOBEX WITH (NOLOCK) where BdmRunId = 'QB' 
AND BdmEEID = 'DJOKCJ000040'

select * from dbo.U_EDISCCOBEX_drvTbl_QB where drvEEID = 'DJOKCJ000040'
select * from dbo.U_EDISCCOBEX_drvTbl_QBEVENT where drvEEID = 'DJOKCJ000040'



SELECT EDHEEID, EdhCOID, EdhDedCode, edhChangeReason, EdhEffDate
                FROM (
                        SELECT EDHEEID, EdhCOID, EdhDedCode, edhChangeReason, EdhEffDate, ROW_NUMBER() OVER(PARTITION BY EdhEEID, EdhCOID, EdhDedCode ORDER BY EdhEffDate DESC) AS rn 
                        FROM dbo.EmpHDed a WITH (NOLOCK)
                        WHERE EdhDedCode IN ('DENT','EYE','FSAL','FSA','MEDG','MEDP','MEDS') 
							and EdhEEID = 'DJOKCJ000040'
                            AND edhChangeReason IN ('204','LEVNT4','201','302','LEVNT3')) AS ED
                WHERE RN = 1
