/*select drvEEID, drvCoID, drvDepRecID, drvSort, drvEventType, MAX(drvEventDate) AS drvEventDate, drvEnrollmentDate, drvEmployeeSSN, drvEmployeeName

from dbo.U_EBAPCQBEXP_drvTbl_QBEVENT
--where drvEEID = '90KOU90000K0'
GROUP BY drvEEID, drvCoID, drvDepRecID, drvSort, drvEventType, drvEnrollmentDate, drvEmployeeSSN, drvEmployeeName

-- 90KOU90000K0


select * from dbo.U_EBAPCQBEXP_drvTbl_QBEVENT;*/

--sp_getEEID 'Porto' -- 9W0C840010K0


select * from dbo.U_EBAPCQBEXP_drvTbl_QBEVENT
where drvEEID = '9W0C840010K0'

select * from dbo.U_EBAPCQBEXP_drvTbl_QBPLANINITIAL -- 22
where drvEEID = '9W0C840010K0'


--select * from dbo.U_dsi_BDM_EBAPCQBEXP WITH (NOLOCK)
--where BdmEEID = '9W0C840010K0'

--select * from dbo.U_EBAPCQBEXP_drvTbl_QBDEPENDENTPLANINITIAL -- 18
--where drvEEID = '9W0C840010K0'


/*

			CASE WHEN BdmRelationship = 'SPS' AND (SELECT COUNT(DISTINCT BdmDepRecId) FROM dbo.U_dsi_BDM_EDISCCOBEX WITH (NOLOCK) WHERE BdmRunId = 'QB' AND BdmEEID = xEEID AND BdmRecType = 'DEP' AND BdmRelationship NOT IN ('SPS','DP')) = 1 THEN 'EE+CHILD'
                                                WHEN BdmRelationship = 'SPS' AND (SELECT COUNT(DISTINCT BdmDepRecId) FROM dbo.U_dsi_BDM_EDISCCOBEX WITH (NOLOCK) WHERE BdmRunId = 'QB' AND BdmEEID = xEEID AND BdmRecType = 'DEP' AND BdmRelationship NOT IN ('SPS','DP')) > 1 THEN 'EE+CHILDREN'
                                                WHEN BdmRelationship <> 'SPS' AND (SELECT COUNT(DISTINCT BdmDepRecId) FROM dbo.U_dsi_BDM_EDISCCOBEX WITH (NOLOCK) WHERE BdmRunId = 'QB' AND BdmEEID = xEEID AND BdmRecType = 'DEP' AND BdmRelationship NOT IN ('SPS','DP')) > 1 THEN 'EE+CHILDREN'
                                                ELSE 'EE'
                                            END
											*/

