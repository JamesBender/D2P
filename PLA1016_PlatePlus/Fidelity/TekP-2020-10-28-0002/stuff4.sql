--sp_getEEID 'Brown' -- CYJK8E000020

select * from dbo.U_EFD401KHSA_drvTbl_11
where drvEEID = 'CYJK8E000020'


--select * from dbo.U_EFD401KHSA_Employees WITH (NOLOCK)
--where xEEID = 'CYJK8E000020'

select EecDateOfOriginalHire, EecDateOfLastHire, EecEmplStatus, * from EmpComp
where EecEEID = 'CYJK8E000020'

--select * from U_dsi_BDM_EFD401KHSA
--where bdmEEID = 'CYJK8E000020'



--select * from dbo.U_dsi_BDM_EmpDeductions  WITH (NOLOCK)     
--WHERE EedFormatCode = 'EFD401KHSA'
--AND EedEEID = 'CYJK8E000020'

