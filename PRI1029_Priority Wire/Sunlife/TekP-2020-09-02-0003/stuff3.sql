select drvNM103_NameLast1, drvNM104_NameFirst1, drvEEID, * from dbo.U_ESUNLNC834_DrvTbl
where drvEEID = 'DILJ38001040'
--where drvNM103_NameLast1 like 'Rodriguezdiaz'

--where drvEEID = 'D0CSRK04N040'

-- sp_getEEID 'Glerum' -- D0CSRK04N040


select drvAMT02_MonetaryAmount1, * from dbo.U_ESUNLNC834_DrvTbl_2300 
--where drvHD00_HealthCoverage = 'LTD'
where drvEEID = 'D0CSVH04E040' -- V/CIB

--select * from dbo.U_ESUNLNC834_File
--where InitialSort = '003820876'
--order by InitialSort, SubSort, SubSort2, SubSort3


-- sp_getEEID 'BUTLER'
-- sp_getEEID 'Glerum' --D0CSRK04N040
-- sp_getEEID 'Huntington' -- DGDPFI000040
-- sp_getEEID 'Gill' -- D0CSVH04E040

select BdmUSGField1, * from dbo.U_dsi_bdm_ESUNLNC834 WITH (NOLOCK) where BdmEEID = 'D0CSRK04N040'
--and BdmDedCode = 'CRICH'

select EecWeeklyPayRate*2, * from EmpComp where EecEEID = 'D0CSVH04E040'