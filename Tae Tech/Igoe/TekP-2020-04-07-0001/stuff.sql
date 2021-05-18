--sp_getEEID 'Brooks' -- BXSFER0000K0


--select * from dbo.U_ECOBRPOINT_drvTbl_QBEVENT
--where drvEEID = 'BXSFER0000K0'

select * from dbo.U_ECOBRPOINT_drvTbl_QBPLAN
WHERE drvDedCode = 'FSA'
--where drvEEID = 'BXSFER0000K0'


select BdmNumChildren, ISNULL(BdmNumChildren,0), ISNULL(BdmEEGoalAmt, 0.00), * from dbo.U_dsi_BDM_ECOBRPOINT WITH (NOLOCK)
--where BdmEEID = 'BXSFER0000K0'
where BdmEEID = 'BXSFDR06F0K0' AND BdmDedCode = 'FSA'


/*

UPDATE dbo.AscExp
SET expLastStartPerControl = '202101011'
   ,expStartPerControl     = '202101011'
   ,expLastEndPerControl   = '202105019'
   ,expEndPerControl       = '202105019'
WHERE expFormatCode = 'ECOBRPOINT'
  AND expExportCode LIKE 'TEST%';


SELECT * from dbo.AscExp
WHERE expFormatCode = 'ECOBRPOINT'
  AND expExportCode LIKE 'TEST%';
  
  */