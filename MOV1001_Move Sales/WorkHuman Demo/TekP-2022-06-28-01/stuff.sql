--sp_getEEID 'Foster' -- BTJ3TL01P0K0
--sp_getEEID 'Wu' -- 'DXF3IG001020'
--sp_getEEID 'Kapoor' -- EBEFJ6000020

--DECLARE @EEID VARCHAR(12) = 'BTJ3TL01P0K0'
--DECLARE @EEID VARCHAR(12) = 'DXF3IG001020'
DECLARE @EEID VARCHAR(12) = 'EBEFJ6000020'

select drvHireDt, * from dbo.U_EWORKHUDE2_drvTbl where drvEEID = @EEID

SELECT EecDateOfLastHire, EecDateOfOriginalHire, EecJobChangeReason, EecDateOfTermination from EmpComp where EecEEID = @EEID

select EjhJobEffDate, EjhEmplStatus, EjhReason, * from EmpHJOb where EjhEEID = @EEID AND EjhEmplStatus = 'T'
select EjhJobEffDate, EjhEmplStatus, EjhReason, * from EmpHJOb A where EjhEEID = @EEID --AND EjhEmplStatus = 'T' 
order by A.EjhJObEffDate DESC
