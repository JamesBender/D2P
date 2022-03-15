/*select * from BnfBPLan
WHERE BfpEEID = 'CYS88U000040'
AND BfpDedCode IN ('SU288','SU283')

select ConSystemID, * from Contacts where ConEEID = 'CYS88U000040'
AND ConRelationship = 'SPS'*/



/*select EepNameFirst, ConNameFirst, *
FROM dbo.U_EGDCOMB834_EELIST WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    JOIN dbo.U_dsi_bdm_EGDCOMB834 WITH (NOLOCK)
        ON BdmEEID = xEEID
        AND BdmCOID = xCOID
    LEFT JOIN dbo.TrmReasn WITH (NOLOCK)
        ON TchCode = EecTermReason
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND (ConSystemID = BdmDepRecID
				OR ConSystemID IN (SELECT distinct BfpConRecId FROM BnfBPlan WHERE BfpDedCode IN ('SU288','SU283') AND BfpStatus = 'A'))

where xEEID = 'CYS88U000040'
*/
--sp_GetEEID 'CGR06R00M040' -- Sbanotto,Kimberly
/*
select * from BnfBPLan
--WHERE BfpEEID = 'CYS88U000040'
WHERE BfpEEID = 'CGR06R00M040'
AND BfpDedCode IN ('SU288','SU283')

Select ConRelationship, ConSystemId, *
from Contacts
where ConEEID = 'CGR06R00M040'
*/

select 'DEP', BdmCOID, BdmEEID, BfpConRecID, BdmSystemId, BdmRunId, BdmDedRowStatus, ConRelationship, ConDateOfBirth, BdmDedCode, BdmDedType, BdmBenOption, BdmBenStatus, BdmBenStartDate, BdmBenStopDate, BdmBenStatusDate, BdmBenOptionDate, BdmChangeREason, BdmStartDate, BdmStopDate, BdmIsCobraCovered, BdmCobraReason, BdmDateOfCOBRAEvent, BdmIsPQB, BdmIsChildOldest, BdmUSGField1, BdmUSGField2, BdmUSGDate1, BdmUSGDate2, BdmTVStartDate, BdmSessionID, BdmEEAmt, BdmEECalcRateOrPct, BdmEEGoalAmt, BdmEEMemberOrCaseNo, BdmERAmt, BdmNumSpouses, BdmNumChildren, BdmNumDomPartners, BdmNumDPChildren
--SELECT A.*
from dbo.U_dsi_bdm_EGDCOMB834 A WITH (NOLOCK) 
JOIN BnfBPLan ON BdmEEID = BfpEEID
	AND BfpDedCode = BdmDedCode
	AND BfpStatus = 'A'
	AND BfpDedCode IN ('SU288','SU283')
JOIN Contacts
	ON BdmEEID = ConEEID
	AND ConSystemId = BfpConRecID
--where BdmEEID = 'CYS88U000040'
--AND BdmDedCode IN ('SU288','SU283')



--select top 1 * from dbo.U_dsi_bdm_EGDCOMB834 WITH (NOLOCK) 
	