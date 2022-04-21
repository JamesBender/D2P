--sp_getEEID 'Griggs' -- BRJEKH0000K0

DECLARE @EEID VARCHAR(12) = 'BRJEKH0000K0'

--select drvApp2, drvApp3, * from dbo.U_EWORKHUDEM_drvTbl where drvEEID = @EEID

--select EecSupervisorID, * from EmpComp where EecEEID = @EEID

select EecJobCode, EecEEID, * from EmpComp where EecEEID IN (select TOP 1 EecSupervisorID from EmpComp where EecEEID = @EEID)

select EepNameLast, EepNameFirst, * from EmpPers where EepEEID = 'BRJEKN02D0K0'

select JbcUDField2, * from JobCode WHERE JbcJobCode IN (select TOP 1 EecJobCode from EmpComp where EecEEID IN (select TOP 1 EecSupervisorID from EmpComp where EecEEID = @EEID))