--sp_getEEID 'Bourkouli' -- C72BQK0000K0
--sp_getEEID 'Weaver' -- DUUC5Y000020

--select * from EmpComp where EecEEID = 'C72BQK0000K0'

/*select * from dbo.U_EEMPYD_V3_Audit 
where audActionCode = '800'
AND audActionEffDate IS NOT NULL*/
--AND audEEID = 'C72BQK0000K0'

SELECT drvActionCode,drvActionCodeEffectiveDate, drvActionReasonCode, drvActionReasonCodeEffectiveDate, * from dbo.U_EEMPYD_V3_DrvTbl_D11
--where drvEEID = 'C72BQK0000K0'
where drvEEID = 'DUUC5Y000020'


select * from dbo.U_EEMPYD_V3_Audit_Action
where audNewValue = 'PERSNL'
AND audRowNo = '1'
where audEEID = 'DUUC5Y000020'

SELECT * from EmpHStat where EshEEID = 'DUUC5Y000020'

select audNewValue, *
FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EEMPYD_V3_AuditFields_Action WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audAction <> 'DELETE'
	and audKey1Value = 'DUUC5Y000020'

select EjhReason, * from EmpHJob where EjhEEID = 'DUUC5Y000020'


select * from [dbo].[U_EEMPYD_V3_Mapping_Actions] A order by A.ActCode

select EecLeaveReason,* from EmpComp where EecEEID = 'DUUC5Y000020'