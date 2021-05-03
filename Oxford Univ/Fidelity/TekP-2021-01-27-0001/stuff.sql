--sp_getEEID 'Johnson' -- 5OD4G00000K0

select * from dbo.U_ETRACOL401_drvTbl
where drvEEID IN ('5OD4G00000K0')

/*
BEGIN TRAN
UPDATE dbo.AscExp 
	SET expSelectByField = '', expSelectByList = ''
WHERE expFormatCode = 'ETRACOL401';
*/




SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ETRACOL401';

--COMMIT TRAN