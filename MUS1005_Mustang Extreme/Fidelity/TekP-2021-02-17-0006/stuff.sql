--sp_getEEID 'Mollohan' -- CLNKCY000020

select * from dbo.U_EF401COMXP_drvTbl_11
where drvEEID = 'CLNKCY000020'

select Record11Change, audNewHire = 'Y', audReHire, audTerm, *
FROM dbo.U_EF401COMXP_Employees WITH (NOLOCK)
    LEFT JOIN dbo.U_EF401COMXP_D_Audit WITH (NOLOCK)
        ON xEEID = audEEID
    WHERE (Record11Change = 'Y' or audNewHire = 'Y' or  audReHire = 'Y')
	AND xEEID = 'CLNKCY000020'

select * from dbo.U_EF401COMXP_Audit
where audEEID = 'CLNKCY000020'