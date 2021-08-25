--sp_getEEID 'Grenier' -- 9Z4USB0010K0

select drvRehireDate, * from dbo.U_ETRACOL401_drvTbl 
where drvEEID = '9Z4USB0010K0'

select EecEmplStatus, EecCOID, EecDateOfOriginalHire, EecDateOfLastHire, * from EmpComp
where EecEEID = '9Z4USB0010K0'


SELECT EjhEEID, EjhCOID, EjhReason, EjhJobEffDate
                FROM (
                        SELECT EjhEEID, EjhCOID, EjhReason, EjhJobEffDate, ROW_NUMBER() OVER(PARTITION BY EjhEEID, EjhCOID ORDER BY EjhJobEffDate DESC) AS RN
                        FROM dbo.EmpHJob WITH (NOLOCK)) AS InnerEjh
                WHERE RN = 1) AS Ejh