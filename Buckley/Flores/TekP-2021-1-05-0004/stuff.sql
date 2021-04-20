--sp_getEEID 'Spencer' -- CR6MAE04P030
--sp_getEEID 'Tamayo' -- CR6MBW048030
--sp_getEEID 'Long' -- CR6M8O039030

DECLARE @EEID VARCHAR (12);
SELECT @EEID = 'CR6MAE04P030';

select * from dbo.U_EFLROCQBXP_drvTbl_Insured
--where drvEEID = 'CR6MAE04P030'
where drvEEID = @EEID

select * from dbo.U_EFLROCQBXP_drvTbl_Dependent
where drvEEID = @EEID

select * from dbo.U_EFLROCQBXP_drvTbl_Election
where drvEEID = @EEID


--select * from dbo.U_dsi_BDM_EFLROCQBXP WITH (NOLOCK) 
--where BdmEEID = @EEID


/*SELECT * FROM dbo.U_dsi_BDM_EFLROCQBXP DOE WITH (NOLOCK) 
WHERE DOE.BdmEEID = 'CR6MAE04P030'*/
--AND DOE.BdmCOID = BDM.BdmCOID AND DOE.BdmIsPQB = 'Y'



/*select * from dbo.U_dsi_BDM_DepDeductions
where DbnEEID = 'CR6MAE04P030'*/