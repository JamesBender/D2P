select BdmRecType, EepNameLast, EepNameFirst, ConNameLast, ConNameFirst, BdmDedCode, *
FROM dbo.U_EATNAMD834_EELIST WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    JOIN dbo.U_dsi_bdm_EATNAMD834 WITH (NOLOCK)
        ON BdmEEID = xEEID
        AND BdmCOID = xCOID
    LEFT JOIN dbo.TrmReasn WITH (NOLOCK)
        ON TchCode = EecTermReason
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
where xEEID = '8YNYLV0010K0'

select * from dbo.U_dsi_bdm_EATNAMD834 WITH (NOLOCK) where BdmEEID = '8YNYLV0010K0'

select EedEEID, EedDedCode, * from EmpDed where EedEEID = '8YNYLV0010K0' AND EedDedCode IN ('DDMO','MHSA')

select * from EmpHDed Where EdhEEID = '8YNYLV0010K0' AND EdhDedCode IN ('MHSA')
order by EdhBenStatusDate DESC

--select ConNameLast, ConNameFirst, * from Contacts where ConEEID = '8YNYLV0010K0'