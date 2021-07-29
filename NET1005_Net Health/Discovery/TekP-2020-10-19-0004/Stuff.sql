--select * from dbo.U_EDISCCOBEX_drvTbl_NPM; -- 226

--select * from U_dsi_bdm_EmpDeductions where eedFormatCode = 'EDISCCOBEX' AND EedRunID = 'NPM'
--order by EedEEID


SELECT COUNT(DISTINCT BdmDepRecId) FROM dbo.U_dsi_BDM_EDISCCOBEX WITH (NOLOCK) WHERE BdmRunId = 'QB' AND BdmEEID = xEEID AND BdmRecType = 'DEP' AND BdmRelationship NOT IN ('SPS','DP')



--select * from dbo.U_EDISCCOBEX_drvTbl_QBEvent
select * from dbo.U_EDISCCOBEX_drvTbl_QBPLANINITIAL
where drvEEID IN ('B6FRPE0040K0','BP3V0I0000K0')

--'B6FRPE0040K0','BP3V0I0000K0'


select * from dbo.U_dsi_BDM_EDISCCOBEX WITH (NOLOCK)
--where BdmEEID IN ('B6FRPE0040K0') --,'BP3V0I0000K0')
where BdmEEID IN ('BP3V0I0000K0')


