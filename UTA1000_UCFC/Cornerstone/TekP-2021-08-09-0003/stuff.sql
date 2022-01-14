--sp_getEEID 'Diaz' -- AZWTXZ00D0K0
--sp_getEEID 'Martin' -- AZWTZV02Y0K0 A
--sp_getEEID 'Wiggins' -- AZWTWK05C0K0 X
--sp_getEEID 'Bishop' -- DYRHWG000040 N


select * from dbo.U_ELMSCSVUT2_drvTbl
where drvEEID = 'AZWTXZ00D0K0'

--select * from EmpPers where EepEEID = 'AZWTXZ00D0K0'

select  CodCode, CodDesc from Codes
WHERE CodTable = 'FLSATYPE'
--where CodDesc LIKE '%Exempt%'

--select top 100 * from FLSATYPE

 SELECT EjhEEID, EjhCOID, EjhJObCode, EjhFLSACategory, EjhJobEffDate, EjhWeeklyHours
            FROM (
                    SELECT EjhEEID, EjhCOID, EjhJObCode, EjhFLSACategory, EjhJobEffDate, EjhWeeklyHours, ROW_NUMBER() OVER(PARTITION BY EjhEEID, EjhCOID ORDER BY EjhJobEffDate DESC) AS RN
                    FROM dbo.EmpHJob WITH (NOLOCK)
					where EjhEEID = 'DYRHWG000040' -- 'AZWTWK05C0K0' -- 'AZWTZV02Y0K0'
					) AS X
            WHERE RN = 1

