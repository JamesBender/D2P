CASE WHEN BdmRecType = 'EMP' THEN
								CASE WHEN CI15C_Code IS NOT NULL THEN CI15C_StopDatee
									WHEN CI30C_Code IS NOT NULL THEN CI30C_StopDatee
									WHEN CI15F_Code IS NOT NULL THEN CI15F_StopDatee
									WHEN CI30F_Code IS NOT NULL THEN CI30F_StopDatee
									WHEN CI15S_Code IS NOT NULL THEN CI15S_StopDatee
									WHEN CI30S_Code IS NOT NULL THEN CI30S_StopDatee
								END
							ELSE
								CASE WHEN Con_CI15C_BenStatus IS NOT NULL THEN CI15C_StopDatee
									WHEN Con_CI30C_BenStatus IS NOT NULL THEN CI30C_StopDatee
									WHEN Con_CI15F_BenStatus IS NOT NULL THEN CI15F_StopDatee
									WHEN Con_CI30F_BenStatus IS NOT NULL THEN CI30F_StopDatee
									WHEN Con_CI15S_BenStatus IS NOT NULL THEN CI15S_StopDatee
									WHEN Con_CI30S_BenStatus IS NOT NULL THEN CI30S_StopDatee
								END
							END