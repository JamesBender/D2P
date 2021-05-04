--sp_getEEID 'Olvera' -- CMK7KQ000020
--sp_getEEID 'Simpson' -- DIVS49000020


select drvTerminationDate, * from dbo.U_EDRBMUSEXP_drvTbl
where RIGHT(RTRIM(drvSubSort), 2) = ' 1' 
AND drvEEID = 'DIVS49000020'
                                                      
													  
select bdmbenstatus, bdmbenstopdate, * from dbo.U_dsi_BDM_EDRBMUSEXP WITH (NOLOCK)
where BdmEEID = 'DIVS49000020'

select eecEmplStatus, EecDateOfTermination from EmpComp where EecEEID = 'DIVS49000020'
														   
--select  DATEADD(DAY, 1, EOMONTH('1/25/2021'))