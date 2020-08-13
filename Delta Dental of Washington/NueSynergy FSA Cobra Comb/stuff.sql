select drvNameLast, drvNameFirst, drvEmployeeMonthPrem, drvEmployerMonthPrem, * from dbo.U_EFSACOBBIL_drvTbl_30 
where drvSort2 IN ('GADD', 'GLIFE', 'ELTD', 'LTD', 'STDB', 'LIFEC', 'SADD')
--where drvEEID = 'CDJMOM0000K0'
--A Order by A.drvEmployeeMonthPrem desc
--where drvEmployeeMonthPrem = '99'
--where drvSort2 LIKE 'LIFEE%' OR drvSort2 LIKE 'LIFES%'


--select ConRelationship, ConDateOfBirth, * from Contacts where ConEEID = '8YEXQM0001G0'
--SELECT TOP 1 RatEERateNSFemale /*LIFEE_AMT*/ FROM dbo.InsRate WITH (NOLOCK) WHERE RatDedCode IN ('LIFEE') AND DateDiff(YEAR, '12/20/1964', '1/1/2017') BETWEEN RatMinAge AND RatMaxAge ORDER BY RatEffDate DESC

--0.115 * 150000

