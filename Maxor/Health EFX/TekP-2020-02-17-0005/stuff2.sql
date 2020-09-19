
select * /*audTableName, audFieldName AS A, audFieldName AS B, 'aud' + RIGHT(audFieldName, LEN(audFieldName)-3) AS C*/ from dbo.U_EEFXHLDEMO_Audit where audEEID = 'CW0BIU001020' order by audTableName, audFieldName;
select EecFullTimeOrPartTime, * from EmpComp where EecEEID = 'CW0BIU001020'

/*SELECT audEEID
	,MAX(CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEEType' THEN audNewValue END) AS audEEType
	,MAX(CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' THEN audNewValue END) AS audEmplStatus
	,MAX(CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatusStartDate' THEN audNewValue END) AS audEmplStatusStartDate
	,MAX(CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmpNo' THEN audNewValue END) AS audEmpNo
	,MAX(CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecFullTimeOrPartTime' THEN audNewValue END) AS audFullTimeOrPartTime
	,MAX(CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecHourlyPayRate' THEN audNewValue END) AS audHourlyPayRate
	,MAX(CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecJobCode' THEN audNewValue END) AS audJobCode
	,MAX(CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecLocation' THEN audNewValue END) AS audLocation
	,MAX(CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecOrgLvl1' THEN audNewValue END) AS audOrgLvl1
	,MAX(CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecOrgLvl2' THEN audNewValue END) AS audOrgLvl2
	,MAX(CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecSalaryOrHourly' THEN audNewValue END) AS audSalaryOrHourly
	,MAX(CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecScheduledWorkHrs' THEN audNewValue END) AS audScheduledWorkHrs
	,MAX(CASE WHEN audTableName = 'EmpHJob' AND audFieldName = 'EjhFullTimeOrPartTime' THEN audNewValue END) AS audFullTimeOrPartTime
	,MAX(CASE WHEN audTableName = 'EmpHJob' AND audFieldName = 'EjhJobEffDate' THEN audNewValue END) AS audJobEffDate
	,MAX(CASE WHEN audTableName = 'EmpPers' AND audFieldName = 'EepAddressCity' THEN audNewValue END) AS audAddressCity
	,MAX(CASE WHEN audTableName = 'EmpPers' AND audFieldName = 'eepAddressEMail' THEN audNewValue END) AS audAddressEMail
	,MAX(CASE WHEN audTableName = 'EmpPers' AND audFieldName = 'EepAddressLine1' THEN audNewValue END) AS audAddressLine1
	,MAX(CASE WHEN audTableName = 'EmpPers' AND audFieldName = 'EepAddressState' THEN audNewValue END) AS audAddressState
	,MAX(CASE WHEN audTableName = 'EmpPers' AND audFieldName = 'EepAddressZipCode' THEN audNewValue END) AS audAddressZipCode
	,MAX(CASE WHEN audTableName = 'EmpPers' AND audFieldName = 'EepDateOfBirth' THEN audNewValue END) AS audDateOfBirth
	,MAX(CASE WHEN audTableName = 'EmpPers' AND audFieldName = 'EepNameFirst' THEN audNewValue END) AS audNameFirst
	,MAX(CASE WHEN audTableName = 'EmpPers' AND audFieldName = 'EepNameLast' THEN audNewValue END) AS audNameLast
FROM dbo.U_EEFXHLDEMO_Audit 

JOIN dbo.U_EEFXHLDEMO_EEList WITH (NOLOCK) on audEEID = xEEID
where audEEID = 'CW0BIU001020'
GROUP BY audEEID*/


--select count(*) from dbo.U_EEFXHLDEMO_Audit audEEID WHERE audEEID NOT IN (select xEEID FROM dbo.U_EEFXHLDEMO_EEList WITH (NOLOCK))

--select count(*) FROM dbo.U_EEFXHLDEMO_EEList WITH (NOLOCK) WHERE xEEID NOT IN (select audEEID from dbo.U_EEFXHLDEMO_Audit)








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
    SET expLastStartPerControl = '202003101'
       ,expStartPerControl     = '202003101'
       ,expLastEndPerControl   = '202012319'
       ,expEndPerControl       = '202012319'
WHERE expFormatCode = 'EEFXHLDEMO';







--select * from dbo.U_EEFXHLDEMO_EEList WITH (NOLOCK) where xEEID = 'CK57QX000020';

--select * from dbo.U_EEFXHLDEMO_drvTbl where drvNameLast = 'Andreev';
select * from dbo.U_EEFXHLDEMO_drvTbl where drvNameLast = 'Hunter';

--select * from dbo.U_EEFXHLDEMO_Audit where audEEID = 'CK57QX000020' order by audTableName, audFieldName;

--select EecCOID, EecEmplStatus, EecDateOfTermination, EecDateOfLastHire, EecOrgLvl1, EecOrgLvl2, * from EmpComp where EecEEID = 'CK57QX000020';
select * from EmpPers where EepEEID = 'CK57QX000020';

--select * from CompMast