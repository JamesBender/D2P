
select audTableName, audFieldName AS A, audFieldName AS B, 'aud' + RIGHT(audFieldName, LEN(audFieldName)-3) AS C from dbo.U_EEFXHLDEMO_Audit where audEEID = 'CK57QX000020' order by audTableName, audFieldName;


select audEEID
	,MAX(CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEEType' THEN audNewValue END) AS audEEType
	,MAX(CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' THEN audNewValue END) AS audEmplStatus

	EmpComp	EecEmplStatusStartDate	EecEmplStatusStartDate	audEmplStatusStartDate
EmpComp	EecEmpNo	EecEmpNo	audEmpNo
EmpComp	EecFullTimeOrPartTime	EecFullTimeOrPartTime	audFullTimeOrPartTime
EmpComp	EecHourlyPayRate	EecHourlyPayRate	audHourlyPayRate
EmpComp	EecJobCode	EecJobCode	audJobCode
EmpComp	EecLocation	EecLocation	audLocation
EmpComp	EecOrgLvl1	EecOrgLvl1	audOrgLvl1
EmpComp	EecOrgLvl2	EecOrgLvl2	audOrgLvl2
EmpComp	EecSalaryOrHourly	EecSalaryOrHourly	audSalaryOrHourly
EmpComp	EecScheduledWorkHrs	EecScheduledWorkHrs	audScheduledWorkHrs
EmpHJob	EjhFullTimeOrPartTime	EjhFullTimeOrPartTime	audFullTimeOrPartTime
EmpHJob	EjhJobEffDate	EjhJobEffDate	audJobEffDate
EmpPers	EepAddressCity	EepAddressCity	audAddressCity
EmpPers	eepAddressEMail	eepAddressEMail	audAddressEMail
EmpPers	EepAddressLine1	EepAddressLine1	audAddressLine1
EmpPers	EepAddressState	EepAddressState	audAddressState
EmpPers	EepAddressZipCode	EepAddressZipCode	audAddressZipCode
EmpPers	EepDateOfBirth	EepDateOfBirth	audDateOfBirth
EmpPers	EepNameFirst	EepNameFirst	audNameFirst
EmpPers	EepNameLast	EepNameLast	audNameLast



FROM dbo.U_EEFXHLDEMO_Audit 
where audEEID = 'CK57QX000020'
GROUP BY audEEID















--select * from dbo.U_EEFXHLDEMO_EEList WITH (NOLOCK) where xEEID = 'CK57QX000020';

--select * from dbo.U_EEFXHLDEMO_drvTbl where drvNameLast = 'Andreev';

select * from dbo.U_EEFXHLDEMO_Audit where audEEID = 'CK57QX000020' order by audTableName, audFieldName;

select EecCOID, EecEmplStatus, EecDateOfTermination, EecDateOfLastHire, EecOrgLvl1, EecOrgLvl2, * from EmpComp where EecEEID = 'CK57QX000020';












UPDATE dbo.AscExp
    SET expLastStartPerControl = '202001181'
       ,expStartPerControl     = '202001181'
       ,expLastEndPerControl   = '202001189'
       ,expEndPerControl       = '202001189'
WHERE expFormatCode = 'EEFXHLDEMO';


UPDATE dbo.AscExp
    SET expLastStartPerControl = '202001191'
       ,expStartPerControl     = '202001191'
       ,expLastEndPerControl   = '202001199'
       ,expEndPerControl       = '202001199'
WHERE expFormatCode = 'EEFXHLDEMO';


UPDATE dbo.AscExp
    SET expLastStartPerControl = '201912261'
       ,expStartPerControl     = '201912261'
       ,expLastEndPerControl   = '202001019'
       ,expEndPerControl       = '202001019'
WHERE expFormatCode = 'EEFXHLDEMO';







DECLARE @StartDate         DATETIME
            ,@EndDate           DATETIME;

SELECT @StartDate = '1/19/2020';
SELECT @EndDate = '1/25/2020';

select EecCOID, EecEmplStatus, EecDateOfTermination, EecDateOfLastHire, * from EmpComp A
where ((EecEmplStatus = 'A' AND EecDateOfLastHire < @EndDate) OR (EecEmplStatus = 'T' AND EecDateOfTermination BETWEEN @StartDate AND @EndDate))
AND EecEEID = 'CK57QX000020' 
order by A.EecDateOfLastHire desc






