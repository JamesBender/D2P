select * from dbo.U_EGUACANEXP_drvTbl
where drvEEID = 'ALKNEK00T0K0'

select ConRelationship, ConNameLast, ConNameFirst, ConSystemID, * from Contacts
where ConEEID = 'ALKNEK00T0K0'
and ConSystemId = (SELECT Top 1 BdmDepREcId FROM dbo.U_dsi_BDM_EGUACANEXP WITH (NOLOCK)
where BdmEEID = 'ALKNEK00T0K0')
AND ConRelationship IN ('SPS','DP')

select * from dbo.U_dsi_BDM_EGUACANEXP WITH (NOLOCK)
where BdmEEID = 'ALKNEK00T0K0'
--WHERE BdmDepRecId = 'ASCMIP0060K0'

--select * from EmpDed WHERE EedDedCode IN ('3721','3722')


--SELECT DATEADD(MONTH, DATEDIFF(MONTH, -1, DATEADD(DAY, 30, '2/2/2022')), 0)

--SELECT DATEADD(month, DATEDIFF(MONTH, 0, GETDATE()), 0)


--SELECT DATEADD(DAY, 1, EOMONTH(GETDATE()))