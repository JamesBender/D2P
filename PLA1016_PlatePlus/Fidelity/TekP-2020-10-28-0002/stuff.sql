--sp_getEEID 'Brooks' -- CL40MH00M020
--sp_getEEID 'Dougherty' --CL40M0019020
--sp_getEEID 'Adams' -- CL40M600F020

DECLARE @EEID VARCHAR(12);

--SELECT @EEID = 'CL40MH00M020'
--SELECT @EEID = 'CL40M0019020'
SELECT @EEID = 'CL40M600F020'

--118.85	1188E
--SELECT CONVERT(VARCHAR(13),118.85)

--select * from dbo.U_EFD401KHSA_drvTbl_01 
--where drvEEID = @EEID
;

--select * from dbo.U_EFD401KHSA_drvTbl_02D 
--where drvEEID = @EEID
--;

--select * from dbo.U_EFD401KHSA_drvTbl_02E 
--where drvEEID = @EEID
--;

--select * from dbo.U_EFD401KHSA_drvTbl_03 where drvEEID = @EEID;

--select * from dbo.U_EFD401KHSA_drvTbl_04 where drvEEID = @EEID;

--select * from dbo.U_EFD401KHSA_drvTbl_06 where drvEEID = @EEID;

--select * from dbo.U_EFD401KHSA_drvTbl_11 
--where drvEEID = @EEID
--;

--select * from dbo.U_EFD401KHSA_drvTbl_60 
--where drvEEID = @EEID
;

--select * from dbo.U_EFD401KHSA_drvTbl_61 where drvEEID = @EEID;

--select * from dbo.U_EFD401KHSA_drvTbl_EA where drvEEID = @EEID;

--select * from dbo.U_EFD401KHSA_drvTbl_HS where drvEEID = @EEID;

--select * from dbo.U_EFD401KHSA_drvTbl_19 
--where drvEEID = @EEID
--;

select * from dbo.U_EFD401KHSA_PDedHist where PdhEEID = @EEID

--select * from dbo.U_dsi_BDM_EFD401KHSA WITH (NOLOCK) where BdmEEID = @EEID

select * from dbo.U_EFD401KHSA_drvTbl_21
 where drvEEID = @EEID;