--sp_getEEID 'Griggs' -- BRJEKH0000K0

DECLARE @EEID VARCHAR(12) = 'BRJEKH0000K0'

--select drvApp2, drvApp3, * from dbo.U_EWORKHUDEM_drvTbl where drvEEID = @EEID

--select EecSupervisorID, * from EmpComp where EecEEID = @EEID

select EecJobCode, EecEEID, * from EmpComp where EecEEID IN (select TOP 1 EecSupervisorID from EmpComp where EecEEID = @EEID)

select EepNameLast, EepNameFirst, * from EmpPers where EepEEID = 'BRJEKN02D0K0'

select EecSupervisorID, * from EmpComp where EecEEID = 'BRJEKN02D0K0'

select EepNameLast, EepNameFirst, * from EmpPers where EepEEID = 'BRJERZ0000K0'


select EepNameLast, EepNameFirst, * from EmpPers where EepEEID = 'BRJERZ0000K0'


select JbcUDField2, * from JobCode WHERE JbcJobCode IN (select TOP 1 EecJobCode from EmpComp where EecEEID IN (select TOP 1 EecSupervisorID from EmpComp where EecEEID = @EEID))


select EepNameLast, EepNameFirst, * from EmpPers where EepEEID = 'BRJERZ0000K0'
select JbcUDField2, * from JobCode WHERE JbcJobCode IN (select TOP 1 EecJobCode from EmpComp where EecEEID IN (select TOP 1 EecSupervisorID from EmpComp where EecEEID = 'BRJERZ0000K0'))

/*
2 - Tricia - M6

3 - Kristin Pudwill - M7

*/


--sp_getEEID 'Pudwill' -- BRJEJR0090K0
select EepNameLast, EepNameFirst, * from EmpPers where EepEEID = 'BRJEJR0090K0'
SELECT eecJObcode From EmpComp where EecEEID = 'BRJEJR0090K0'
select JbcUDField2, * from JobCode WHERE JbcJobCode = '20AC652F' -- IN (select TOP 1 EecJobCode from EmpComp where EecEEID IN (select TOP 1 EecSupervisorID from EmpComp where EecEEID = 'BRJEJR0090K0'))


--sp_getEEID 'Wilson' -- BRJEZV00Q0K0
--sp_getEEID 'Charbonneau' -- BRJERZ0000K0


SELECT EepNameLast, EepNameFirst, EecJobCode, JbcUDField2
FROM EmpPers
JOIN EmpComp
	ON EepEEID = EecEEID
JOIN JobCode 
	ON EecJobCode = JbcJobCode
WHERE EepEEID IN ('BRJEJR0090K0','BRJEZV00Q0K0','BRJERZ0000K0')

