--sp_getEEID 'Nieto' -- COPWJQ00A040

--select drvINS02_RelationshipCode, * from dbo.U_EGRD834EXP_DrvTbl
--where drvEEID = 'COPWJQ00A040'
--AND drvINS02_RelationshipCode = '01'


--select ConSSN, * from Contacts
--where ConEEID = 'COPWJQ00A040'


select distinct

  CASE WHEN BdmRecType = 'EMP' AND ConRelationship IS NULL THEN 'Y'
                                 ELSE 'N'
                             END            
        ,CASE WHEN BdmRecType = 'EMP' AND ConRelationship IS NULL THEN '18'
                                          ELSE
                                                CASE WHEN ConRelationship IN ('SPS') THEN '01'
                                                    WHEN ConRelationship IN ('DP') THEN '53'
                                                     WHEN ConRelationship IN ('DPC','CHL','QCH','STC') THEN '19'
                                                     ELSE '19'
                                                END
                                     END
		,ConSSn
		,LEFT(ConSSN, 3)
		,BdmRecType
		,ConRelationship
        ,CASE WHEN BdmRecType = 'EMP' AND ConRelationship IS NULL AND ISNULL(EepSSN, '') <> '' AND LEFT(EepSSN, 3) <> '999' THEN '34'
                                          WHEN BdmRecType = 'DEP' OR ConRelationship IS NOT NULL AND ISNULL(ConSSN, '') <> '' AND LEFT(ConSSN, 3) <> '999' THEN '34'
                                     END
        ,CASE WHEN BdmRecType = 'EMP' AND ConRelationship IS NULL AND ISNULL(EepSSN, '') <> '' AND LEFT (EepSSN, 3) <> '999' THEN EepSSN
                                 WHEN BdmRecType = 'DEP' OR ConRelationship IS NOT NULL AND ISNULL(ConSSN, '') <> '' AND LEFT(ConSSN, 3) <> '999' THEN ConSSN
                            END
        ,CASE WHEN BdmRecType = 'EMP' AND ConRelationship IS NULL AND ISNULL(EepPhoneHomeNumber, '') <> '' THEN 'HP'
                                            WHEN BdmRecType = 'EMP' AND ConRelationship IS NULL AND ISNULL(eepAddressEMail, '') <> '' THEN 'EM'
                                        END                                            
        ,CASE WHEN BdmRecType = 'EMP' AND ConRelationship IS NULL AND ISNULL(EepPhoneHomeNumber, '') <> '' THEN EepPhoneHomeNumber
                                            WHEN BdmRecType = 'EMP' AND ConRelationship IS NULL AND ISNULL(eepAddressEMail, '') <> '' THEN eepAddressEMail
                                        END
        ,CASE WHEN BdmRecType = 'EMP' AND ConRelationship IS NULL AND ISNULL(EepPhoneHomeNumber, '') <> '' AND ISNULL(eepAddressEMail, '') <> '' THEN 'EM' END
                                            
        ,CASE WHEN BdmRecType = 'EMP' AND ConRelationship IS NULL AND ISNULL(EepPhoneHomeNumber, '') <> '' AND ISNULL(eepAddressEMail, '') <> '' THEN eepAddressEMail END
        ,dbo.dsi_fnRemoveChars('.,/-',EepAddressLine1)
        ,dbo.dsi_fnRemoveChars('.,/-',EepAddressLine2)
        ,dbo.dsi_fnRemoveChars('.,/-',EepAddressCity)
        ,EepAddressState
        ,EepAddressZipCode
        ,CASE WHEN EepAddressCountry NOT IN ('US','USA') THEN EepAddressCountry END
        ,CASE WHEN BdmRecType = 'EMP' AND ConRelationship IS NULL THEN CONVERT(VARCHAR(8),EepDateOfBirth,112)
                                         WHEN BdmRecType = 'DEP' OR ConRelationship IS NOT NULL THEN CONVERT(VARCHAR(8),ConDateOfBirth,112)
                                    END
        ,CASE WHEN BdmRecType = 'EMP' AND ConRelationship IS NULL THEN EepGender
                                     WHEN BdmRecType = 'DEP' OR ConRelationship IS NOT NULL THEN ConGender
                                END
        , CASE WHEN BdmRecType = 'EMP' AND ConRelationship IS NULL THEN
                                                CASE WHEN EepMaritalStatus IN ('S','Z') THEN 'I'
                                                    WHEN EepMaritalStatus IS NULL THEN 'R'
                                                    ELSE EepMaritalStatus
                                                END
                                       END
        --If drvICM01_FrequencyCode is Populated, then send ICM Segment
        ,CASE WHEN BdmRecType = 'EMP' AND ConRelationship IS NULL THEN '7' END --'7'
        ,CASE WHEN BdmRecType = 'EMP' AND ConRelationship IS NULL THEN CONVERT(MONEY,EecAnnSalary) END
        ,CASE WHEN BdmRecType = 'EMP' AND ConRelationship IS NULL THEN CONVERT(MONEY,EecScheduledWorkHrs/2) END
        ,CASE WHEN BdmRecType = 'EMP' AND ConRelationship IS NULL THEN CONVERT(VARCHAR, dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(xEEID, xCOID, '1/1/2021', EecDateOfLastHire), 112) END
        ,CASE WHEN BdmRecType = 'EMP' THEN --AND ConRelationship IS NULL THEN
                                                CASE EepIsSmoker
                                                     WHEN 'Y' THEN 'T' --Tobacco Use
                                                     ELSE 'N' --None
                                                END
                                           WHEN BdmRecType = 'DEP' THEN
                                                CASE ConIsSmoker
                                                     WHEN 'Y' THEN 'T' --Tobacco Use
                                                     ELSE 'N' --None
                                                END
                                      END
        ---------------------------------
        ,xEEID
        ,xCOID
        ,ConSystemID
        ,EepSSN
        ,RTRIM(EepSSN)
        ,CONVERT(CHAR(9),RTRIM(EepSSN)) + CONVERT(CHAR(12),ISNULL(ConSystemID,''))



FROM dbo.U_EGRD834EXP_EELIST WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    JOIN dbo.U_dsi_bdm_EGRD834EXP BDM WITH (NOLOCK)
        ON BdmEEID = xEEID
        AND BdmCOID = xCOID
    LEFT JOIN dbo.TrmReasn WITH (NOLOCK)
        ON TchCode = EecTermReason
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSSN <> '000000000'
		AND ((ConSystemID = BdmDepRecID) )/*  OR (BdmRecType = 'EMP' AND
                                            (
                                                (ConRelationship IN ('SPS','DP') AND BdmDedCode IN ('LIFES','ADDS'))
                                                OR
                                                (ConRelationship IN ('CHL') AND BdmDedCode IN ('LIFEC','ADDC'))
											)
											AND ConIsDependent = 'Y'
											AND xEEID IN (SELECT DISTINCT BdmEEID
															FROM dbo.U_dsi_bdm_EGRD834EXP WITH (NOLOCK)
															WHERE BdmRecType = 'EMP'
															AND BdmDedCode IN ('LIFES','ADDS','LIFEC','ADDC')
															AND BdmEEID NOT IN (
																				SELECT DISTINCT BdmEEID
																				FROM dbo.U_dsi_bdm_EGRD834EXP WITH (NOLOCK)
																				WHERE BdmRecType = 'DEP'
																				AND (	(BdmRelationship IN ('SPS','DP') AND BdmDedCode IN ('LIFES','ADDS'))
																						OR
																						(BdmRelationship IN ('CHL') AND BdmDedCode IN ('LIFEC','ADDC'))
																					)
																				)
															)
											
										))*/
		where xEEID = 'COPWJQ00A040'
		;


		select DISTINCT ConSSN, ConRelationship, BdmDepRecId from Contacts
			join dbo.U_dsi_bdm_EGRD834EXP A
			ON ConEEID = BdmEEID
			AND ConSSN <> '000000000'
			AND ((ConSystemID = BdmDepRecID) )
		where BdmEEID = 'COPWJQ00A040'

		SELECT DISTINCT BdmEEID
			JOIN Contacts
				ON ConEEID = BdmEEID
			AND ConSSN <> '000000000'
		BdmRecType = 'EMP' AND
                                            BdmRecType = 'EMP' AND
                                            (
                                                (ConRelationship IN ('SPS','DP') AND BdmDedCode IN ('LIFES','ADDS'))
                                                OR
                                                (ConRelationship IN ('CHL') AND BdmDedCode IN ('LIFEC','ADDC'))
											)
											AND ConIsDependent = 'Y'
											AND xEEID IN (SELECT DISTINCT BdmEEID
															FROM dbo.U_dsi_bdm_EGRD834EXP WITH (NOLOCK)
															WHERE BdmRecType = 'EMP'
															AND BdmDedCode IN ('LIFES','ADDS','LIFEC','ADDC')
															AND BdmEEID NOT IN (
																				SELECT DISTINCT BdmEEID
																				FROM dbo.U_dsi_bdm_EGRD834EXP WITH (NOLOCK)
																				WHERE BdmRecType = 'DEP'
																				AND (	(BdmRelationship IN ('SPS','DP') AND BdmDedCode IN ('LIFES','ADDS'))
																						OR
																						(BdmRelationship IN ('CHL') AND BdmDedCode IN ('LIFEC','ADDC'))
																					)
																				)
															)
											
										)
																					AND BdmEEID = 'COPWJQ00A040'




select DISTINCT ConSSN, ConRelationship, BdmDepRecId from Contacts
			join dbo.U_dsi_bdm_EGRD834EXP A
			ON ConEEID = BdmEEID
where BdmRecType = 'EMP' AND
                                            (
                                                (ConRelationship IN ('SPS','DP') AND BdmDedCode IN ('LIFES','ADDS'))
                                                OR
                                                (ConRelationship IN ('CHL') AND BdmDedCode IN ('LIFEC','ADDC'))
											)
											AND ConIsDependent = 'Y'
											AND BdmEEID IN ('COPWJQ00A040')