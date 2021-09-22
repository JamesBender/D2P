--sp_getEEID 'Hayes' -- COPW4Q000040
--sp_getEEID 'De Silva' -- COPWJ9000040
--sp_getEEID 'Rifkin' -- COPVZT00R040
--sp_getEEID 'Pathak' -- COPWAQ025040


select drvInitialSort,drvSubSort, * from dbo.U_EGRD834EXP_DrvTbl_2300 A
--where drvEEID = 'COPW4Q000040'
--where drvEEID = 'COPWJ9000040'
--where drvEEID = 'COPVZT00R040'
where drvEEID = 'COPWAQ025040'
--where drvSubSort = '134389397CPL2WJ03B040ADDC '
--order by A.drvSubSort
--AND drvHD03_InsuranceLineCode IN ('AH','AJ')
--order by A.drvHD03_InsuranceLineCode


select * from Contacts
where ConEEID = 'COPVZT00R040'

select * from dbo.U_dsi_bdm_EGRD834EXP WITH (NOLOCK)
--where BdmEEID = 'COPW4Q000040'
where BdmEEID = 'COPVZT00R040'
--and BdmDedCode IN ('GLIFE','GLF35','BSCLF','EXBSL','GLIFE','GLF35','EXADD')

-- CPL2WJ03B040



SELECT DISTINCT ConSystemId AS ADDCConSystemId, ConEEID AS ADDCEEID, ConRelationship
FROM dbo.Contacts WITH (NOLOCK)
WHERE ConIsDependent = 'Y'                
AND ConRelationship NOT IN ('SPS','DP')
AND ConEEID = 'COPVZT00R040'



SELECT DISTINCT ConSystemId AS ADDSConSystemId, ConEEID AS ADDSEEID, ConRelationship
FROM dbo.Contacts WITH (NOLOCK)
WHERE ConIsDependent = 'Y'                
AND ConRelationship IN ('SPS','DP')
AND ConEEID = 'COPVZT00R040'




