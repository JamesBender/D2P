--sp_getEEID 'Neely' --8YNYJ50010K0
--sp_getEEID 'Cain' -- 91YDSA0030K0
--sp_getEEID 'Moreno' --9IB7QV0010K0
--sp_getEEID 'Moore' -- 9WCT5H0010K0

--select * from dbo.U_EDSQBNPMEX_drvTbl_QBDEPENDENTPLANINITIAL
--where drvEEID = '9WCT5H0010K0'
--where drvEEID IN ('8YNYJ50010K0','91YDSA0030K0','9IB7QV0010K0')

--select distinct BdmEEID, BdmCobraReason, BdmBenOption from dbo.U_dsi_BDM_EDSQBNPMEX WITH (NOLOCK)
--where BdmEEID IN ('8YNYJ50010K0','91YDSA0030K0','9IB7QV0010K0')

--sp_getEEID 'Lockwood' -- 8YNZ1B0010K0
--sp_getEEID 'Smith' -- CS0FGP000030
--sp_getEEID 'Tonkyro' -- DNOTQF000030

select * from dbo.U_EDSQBNPMEX_drvTbl_NPM
where drvEEID IN ('8YNZ1B0010K0','CS0FGP000030','DNOTQF000030')

select * from dbo.U_dsi_BDM_EDSQBNPMEX WITH (NOLOCK)
where BdmEEID IN ('8YNZ1B0010K0','CS0FGP000030','DNOTQF000030')

