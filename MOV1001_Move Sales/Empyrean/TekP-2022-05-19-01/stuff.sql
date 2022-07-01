--sp_getEEID 'Montano' -- DFOFX9000020

DECLARE @EEID varchar(12) = 'DFOFX9000020'

select drvInitialSort, drvActionCode                
        ,drvActionCodeEffectiveDate 
        ,drvActionReasonCode                                            
        ,drvActionReasonCodeEffectiveDate, * from dbo.U_EEMPYDEM2_DrvTbl_D11
where drvEEID = @EEID



select 
	A.EshEEID, A.EshCOID, A.EshEmplStatus, A.EshStatusStartDate, A.EshStatusStopDate, ROW_NUMBER() OVER(PARTITION BY A.EshEEID, A.EshCOID ORDER BY A.EshStatusStartDate DESC) AS RN
	from EmpHStat A 
	JOIN (
		SELECT EshEEID, EshCOID, MAX(EshStatusStartDate) AS MaxStartDate
		FROM EmpHStat
		GROUP BY EshEEID, EshCOID
	) B
		ON A.EshEEID = B.EshEEID
		AND A.EshCOID = B.EshCOID
	where EshStatusStartDate < B.MaxStartDate
	AND	A.EshEEID = @EEID AND A.EshCOID ='OG4IV'
order by A.EshStatusStartDate desc
