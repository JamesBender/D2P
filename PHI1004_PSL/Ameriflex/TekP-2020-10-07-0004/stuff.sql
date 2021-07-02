--sp_getEEID 'Cobbs' -- C7SOM10000K0
--sp_getEEID 'Walker' -- BBHFIQ0010K0
--sp_getEEID 'Billman' -- COCN1F0000K0


select * from dbo.U_EAMFLCOBRA_drvTbl_QB -- 10
where drvEEID = 'COCN1F0000K0'

select * from dbo.U_EAMFLCOBRA_drvTbl_QBEVENT
--where drvEEID = 'C7SOM10000K0'
--where drvEEID = 'BBHFIQ0010K0'
where drvEEID = 'COCN1F0000K0'


select * from dbo.U_dsi_BDM_EAMFLCOBRA WITH (NOLOCK)
--where BdmEEID = 'C7SOM10000K0'
--where BdmEEID = 'BBHFIQ0010K0'
where BdmEEID = 'COCN1F0000K0'



select dbnValidForExport, * from dbo.U_dsi_BDM_DepDeductions
where dbneeid = 'COCN1F0000K0' and dbnformatcode = 'EAMFLCOBRA' --AND DbnDepRecID IN ('COD4QI0000K0','COD4NY0000K0')
AND DbnRelationship = 'SPS'

