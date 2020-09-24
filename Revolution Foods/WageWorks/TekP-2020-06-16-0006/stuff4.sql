/* Qualifying Event Date is missing from some employee records. - See Nancy Mieu, Ashley Carter/dependents
I updated the field mapping with the following logic


CASE WHEN BdmRecType = 'EMP' AND EecEmplStatus = 'T' AND BdmRunID = 'QB' THEN EepDateOfCOBRAEvent
                                        WHEN BdmRecType = 'EMP' AND EecEmplStatus = 'A' AND BdmBenStatus = 'T' AND BdmRunId = 'QB' THEN EepDateOfCOBRAEvent
                                        WHEN BdmRecType = 'DEP' AND BdmBenStatus = 'T' AND BdmRunId = 'QB' THEN ConCOBRAStatusDate
                                    END
*/


select drvQuallifingEventDate, * from dbo.U_EWWCOBCMBX_drvTbl
where drvEEID IN ('8T2CRP0000Y0','AVLLF70000K0');
--where drvNameLast IN ('Mieu', 'Carter')
--where drvNameLast = 'Osman'
--where drvEEID  IN ('DCSHIL000030','DCU6UV000030','DD6UX9000030','DDCR94002030','DDK8LH000030','DE8HMT000030') -- 7


--select * from dbo.U_dsi_BDM_EWWCOBCMBX WITH (NOLOCK) where bdmEEID = '8T2CYN0010Y0'
--select * from dbo.U_dsi_BDM_EWWCOBCMBX WITH (NOLOCK) where bdmEEID IN ('8T2CRP0000Y0','AVLLF70000K0');