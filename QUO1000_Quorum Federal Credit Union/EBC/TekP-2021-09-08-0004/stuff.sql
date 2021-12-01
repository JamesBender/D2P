--sp_getEEID 'Lee' -- ALHZ030010K0

--select * from dbo.U_EEBCCOBEXP_drvTbl_QBEVENT;



-- Jake Lee, why doesn't he have HRA coming over?
select * from dbo.U_EEBCCOBEXP_drvTbl_QB
where drvEEID = 'ALHZ030010K0'
select * from dbo.U_EEBCCOBEXP_drvTbl_QBPLANINITIAL
where drvEEID = 'ALHZ030010K0'


select * from dbo.U_dsi_BDM_EEBCCOBEXP WITH (NOLOCK)
where BdmEEID = 'ALHZ030010K0'
--where BdmDedCode = 'HRA'

select EedDedCode, * from EmpDed where EedEEID = 'ALHZ030010K0' AND EedDedCode IN ('FSA','HRA')

/*
select * from EmpHDed where EdhEEID = 'ALHZ030010K0' AND EdhDedCode IN ('FSA','HRA') order by EdhBenStatusDate Desc


select * from dbo.U_dsi_BDM_DepDeductions where dbnformatcode = 'EEBCCOBEXP' AND DbnEEID = 'ALHZ030010K0'

select * from dbo.U_dsi_BDM_EmpDeductions  where EedFormatCode = 'EEBCCOBEXP' AND EedEEID = 'ALHZ030010K0'

*/


--sp_getEEID 'DiBuono' -- 9U6ZU60000K0
--select * from dbo.U_EEBCCOBEXP_drvTbl_QBDEPENDENT;



--sp_getEEID 'Pathak' -- CG2UJ5000020
--sp_getEEID 'McKay' -- DCW157000020

--select * from dbo.U_EEBCCOBEXP_drvTbl_QBDEPENDENT
--where drvEEID = 'CG2UJ5000020'
--where drvEEID = 'DCW157000020'

--select * from dbo.U_EEBCCOBEXP_drvTbl_QBDEPENDENTPLANINITIAL
--where drvEEID = 'CG2UJ5000020'
--where drvEEID = 'DCW157000020'

