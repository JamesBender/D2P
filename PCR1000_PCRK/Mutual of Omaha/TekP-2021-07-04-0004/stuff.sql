--sp_getEEID 'Alfich' -- DNEAWQ01LRX0
--sp_getEEID 'Andre' -- DU65QU000RX0

DECLARE @EEID VARCHAR(12) = 'DNEAWQ01LRX0'
--DECLARE @EEID VARCHAR(12) = 'DU65QU000RX0'

SELECT drvTermEEProductCategory
        ,drvTermEEEffectiveDate
        ,drvTermEEEligibilityEvent 
        ,drvTermEEPlanID
        ,drvTermEEFamCoverageInd 
        ,drvTermEEApprovedAmtEffDate 
        ,drvTermEEApprovedAmt
		,* FROM dbo.U_EMOOSVAEXP_drvTbl where drvEEID = @EEID

select * from dbo.U_dsi_BDM_EMOOSVAEXP where BdmEEID = @EEID

--SELECT Top 10 AudDateTime, * from dbo.vw_AuditData A WITH (NOLOCK) where AudKey1Value = @EEID AND audTableName = 'EmpDed' and audKey3Value = 'VLIFE' order by A.AudDateTime DESC

--select * from dbo.U_EMOOSVAEXP_Audit where audEEID = @EEID

--SELECT 'EMP', audEEID, audCOID, audKey3, EedBenStopDate
--FROM dbo.U_EMOOSVAEXP_Audit 
--JOIN dbo.EmpDed 
--	ON audEEID = EedEEID
--	AND audCOID = EedCOID
--	AND audKey3 = EedDedCode
--WHERE audEEID NOT IN (SELECT BdmEEID FROM dbo.U_dsi_BDM_EMOOSVAEXP) 
--AND audRowNo = 1

--select EedEEID, EedCOID, EedDedCode, * from EmpDed where EedEEID  = @EEID and EedDedCode = 'VLIFE'