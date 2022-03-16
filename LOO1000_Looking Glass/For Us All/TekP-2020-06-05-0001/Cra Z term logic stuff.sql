select adrKey1, adrProcessedDateTime, adfOldData, adfNewData, *
FROM (SELECT *
          FROM dbo.AuditRecords WITH (NOLOCK)
          WHERE adrTableName IN (SELECT aTableName FROM dbo.U_EFUALOK401_AuditFields WITH (NOLOCK))) ADR
    JOIN (SELECT *
          FROM dbo.AuditFields WITH (NOLOCK)
          WHERE adfFieldName IN (SELECT aFieldName FROM dbo.U_EFUALOK401_AuditFields WITH (NOLOCK))) ADF
        ON adrSystemID = adfSystemID
       AND adrKey = adfKey
where adrKey1 IN ('CY4IFT000020','BO74OC0170K0') --,'BO74P301X0K0','C6G0TN0000K0')
AND adrProcessedDateTime < '1/1/2020'


--select min(adrProcessedDateTime) from auditRecords

--sp_getEEID 'Warren'

select * from AuditRecords where adrKey1 = 'BO74OC0170K0' and adrTableName = 'EmpComp'



DAte of Last Hire				Run Dates					Date of Term(+30)	Current Status
1/1/2018						1/1/2020- 1/31/2020				9/1/2020		T -> A
2/15/2020						""								9/1/2020		T -> not inlcuded
2/15/2020 (rehire)												1/1/2020		T -> T
""								3/1...							1/1/2020        A -> A