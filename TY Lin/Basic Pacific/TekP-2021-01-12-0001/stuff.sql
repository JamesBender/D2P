select * from dbo.U_EBAPCQBEXP_drvTbl_QBEVENT;

--sp_getEEID 'Elwood' -- 8OMZ6U0001D0

-- D5OPN5000020

--select EecEmplStatus, * from EmpComp where EecEEID = 'D5OPN5000020'


/*SELECT BdmEEID AS MRBdmEEID
	,BdmCOID AS MRBdmCOID
	,MAX(BdmBenStartDate) AS MostRecentBdmStartDate 
FROM dbo.U_dsi_BDM_EBAPCQBEXP WITH (NOLOCK)
GROUP BY BdmEEID, BdmCOID
where BdmEEID = '8OMZ6U0001D0'*/

--select top 100 * from dbo.U_dsi_bdm_DepDeductions
--where dbnFormatCode = 'EBAPCQBEXP'


           
		   