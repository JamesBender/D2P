--select * from dbo.U_ESTNLSTDEX_Header;

--sp_getEEID 'Olsen' -- DOIV2Z000040
--sp_getEEID 'Connors' -- CFPLJ00000K0

select drvCiProductId,* from dbo.U_ESTNLSTDEX_drvTbl 
--where drvEEID = 'DOIV2Z000040'
where drvEEID = 'CFPLJ00000K0'


select * FROM dbo.U_dsi_BDM_ESTNLSTDEX WITH (NOLOCK) 
where BdmEEID = 'CFPLJ00000K0'

/*

select PehPerControl, PehCurHrs, CAST(LEFT(PehPerControl, 8) AS DATE), DATEADD(YEAR, -1, GETDATE()), GETDATE(), *
FROM --dbo.vw_int_PayReg WITH (NOLOCK)
   -- JOIN 
   dbo.vw_int_PEarHist WITH (NOLOCK)
--        ON PehGenNumber = PrgGenNumber
    WHERE --CAST(LEFT(PehPerControl, 8) AS DATE) BETWEEN DATEADD(YEAR, -1, GETDATE()) AND GETDATE()
	--AND 
	PehEEID = 'DOIV2Z000040'

	*/