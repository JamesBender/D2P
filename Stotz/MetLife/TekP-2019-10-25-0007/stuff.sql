        ,drvCoverageCode8 = CASE WHEN BdmRecType = 'EMP' THEN							
								CASE WHEN DSL10_Code IS NOT NULL OR DSL20_Code IS NOT NULL 
										OR DSL25_Code IS NOT NULL OR DSL50_Code IS NOT NULL 
										OR SP100_Code IS NOT NULL OR SPL10_Code IS NOT NULL 
										OR SPL20_Code IS NOT NULL OR SPL25_Code IS NOT NULL 
										OR SPL30_Code IS NOT NULL OR SPL40_Code IS NOT NULL 
										OR SPL50_Code IS NOT NULL OR SPL60_Code IS NOT NULL THEN 'LZ' 
								END
							ELSE 
								CASE WHEN Con_DSL10_BenStatus IS NOT NULL OR Con_DSL20_BenStatus IS NOT NULL OR
										Con_DSL25_BenStatus IS NOT NULL OR Con_DSL50_BenStatus IS NOT NULL OR
										Con_SP100_BenStatus IS NOT NULL OR Con_SPL10_BenStatus IS NOT NULL OR
										Con_SPL20_BenStatus IS NOT NULL OR Con_SPL25_BenStatus IS NOT NULL OR
										Con_SPL30_BenStatus IS NOT NULL OR Con_SPL40_BenStatus IS NOT NULL OR
										Con_SPL50_BenStatus IS NOT NULL OR Con_SPL60_BenStatus IS NOT NULL THEN 'LZ'
								END
							END



                            select drvCoverageCode24, * from dbo.U_EMETLIFEEX_drvTbl A 
where drvEEID = 'BNBWIG00W0K0' 
--where drvEEID = 'BNBWRT0250K0'
--where drvEEID = 'BNBWNP0000K0'
--where drvEEID = 'BNBWI80000K0'
--where drvCoverageCode24 is not null
--where drvEEID IN ('BNBWKF0160K0','BNBWKT0000K0','BNBWLF01T0K0','BNBWM001S0K0','BNBWM90000K0','BNBWNP0000K0','BNBWN20020K0','BNBWOL0210K0','BNBWPL0120K0')
order by a.drvEEID, a.drvRelationshipCode



CASE WHEN BdmRecType = 'EMP' THEN
								CASE WHEN ACCHI_Code IS NOT NULL THEN ACCHI_StartDate
									WHEN ACCLO_Code IS NOT NULL THEN ACCLO_StartDate 
								END
							ELSE
								CASE WHEN Con_ACCHI_BenStatus IS NOT NULL THEN ACCHI_StartDate
									WHEN Con_ACCLO_BenStatus IS NOT NULL THEN ACCLO_StartDate 
								END
							END