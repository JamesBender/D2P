select BdmRecType, BdmDepRecId, *
FROM dbo.U_EDSICCBEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EDSICCBEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        --AND BdmRecType = 'DEP'
        AND BdmRunId = 'QB'
    LEFT JOIN dbo.Contacts C WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecId

select * from dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK) WHERE DbnFormatCode = 'EDSICCBEXP' AND DbnRunID = 'QB'


===========================

/*select BdmRecType, BdmDepRecId, *
FROM dbo.U_EDSICCBEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EDSICCBEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        --AND BdmRecType = 'DEP'
        AND BdmRunId = 'QB'
    LEFT JOIN dbo.Contacts C WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecId*/


--sp_getEEID 'Aragon'

/*
Joshua Aragon and Spouse Dependent Nicole McGahey
Joshua has deduction codes DENAD, UMPPO, VIS and they all have a benefit change reason of Termination (Benefit Change Reason Code = 200)
*/

select * from dbo.U_dsi_BDM_EDSICCBEXP WITH (NOLOCK) 
where BdmRunId = 'QB'
and BdmEEID = 'CC9EL70030K0'
--AND BdmRecType <> 'EMP'


--

select * from dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK) WHERE DbnFormatCode = 'EDSICCBEXP' AND DbnRunID = 'QB' and DbnEEID = 'CC9EL70030K0' and dbndeprecid = 'CC9EMD0090K0'

select * from dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK) WHERE EedFormatCode = 'EDSICCBEXP' AND EedRunID = 'QB' and EedEEID = 'CC9EL70030K0' --and dbndeprecid = 'CC9EMD0090K0'