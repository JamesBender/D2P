--sp_getEEID 'Olvera' -- CMK7KQ000020
--sp_getEEID 'Simpson' -- DIVS49000020
--sp_getEEID 'Pastrana' -- CSO2CT000020
--sp_getEEID 'Abendroth' -- 


select drvUnderwritingStatsInd, * from dbo.U_EDRBMUSEXP_drvTbl
where drvRecordType = '05'
--AND drvEEID = 'CSO2CT000020'



--AND drvPlanCode IN ('0001001','
--(RIGHT(RTRIM(drvSubSort), 2) = ' 1' OR 
--RIGHT(RTRIM(drvSubSort), 2) = 'JB'
--)
--AND drvEEID = 'DIVS49000020'
--AND ISNULL(drvTerminationReasonCode, '') = ''
--order by drvInitialSort, drvSubSort
  
  
                      
--select BdmUsgField2, BdmUsgField1, BdmEEAmt, BdmDedCode, * from dbo.U_dsi_BDM_EDRBMUSEXP WITH (NOLOCK)
--where BdmEEID = 'CSO2CT000020'

--select * from dbo.U_dsi_BDM_EDRBMUSEXP WITH (NOLOCK) where BdmEEAmt is null



--select EedDedCode, EedBenAmt, EedEOIDesiredAmt, * from EmpDed where EedEEID = 'CSO2CT000020' AND EedDedCode IN ('CRILE','CRILS','CRILS','GACC ','GTLII','LIFEE','LIFES','LIFES','VIS')

/*select EedDedCode, EedValidForExport, EedEmpDedTVID, BdmUSGField1, BdmUSGField2, EedBenAmt, DedEEBenAmt, *
FROM dbo.U_dsi_bdm_EDRBMUSEXP
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = BdmEEID
        AND EedCOID = BdmCOID
        AND EedDedCode = BdmDedCode
    WHERE BdmRecType = 'EMP' AND EedFormatCode = 'EDRBMUSEXP' 
	AND EedValidForExport = 'Y' 
	AND EedEEID = 'CSO2CT000020'*/




--WHERE bdmdedcode in ('VIS') and bdmrectype = 'DEP' 
													  
--select bdmbenstatus, bdmbenstopdate, * from dbo.U_dsi_BDM_EDRBMUSEXP WITH (NOLOCK)
--where BdmEEID = 'DIVS49000020'

--select eecEmplStatus, EecDateOfTermination from EmpComp where EecEEID = 'DIVS49000020'
														   
--select  DATEADD(DAY, 1, EOMONTH('1/25/2021'))

--select top 10 * from dbo.EmpHJob WITH (NOLOCK)