DECLARE  @FormatCode        VARCHAR(10)
            ,@StartDate         DATETIME
            ,@EndDate           DATETIME;

    -- Set FormatCode
    SELECT @FormatCode = 'EEFXHLDEMO';

    -- Declare dates from Parameter file
    SELECT @StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

	SELECT @StartDate AS StartDate, @EndDate AS EndDate;

select drvEmplPayType, drvEmployer, drvPositionStatus, * from dbo.U_EEFXHLDEMO_drvTbl where drvNameLast = 'Andreev';

select EecEmplStatus, EecDateOfLastHire, EecDateOfTermination, * from EmpComp where EecEEID = 'CK57QX000020';

select EecEmplStatus, EecDateOfLastHire, EecDateOfTermination, * from EmpComp where EecEEID = 'CK57QX000020'
AND ((EecEmplStatus = 'A' AND (EecDateOfLastHire <= @StartDate OR EecDateOfLastHire BETWEEN @StartDate AND @EndDate)) OR (EecEmplStatus = 'T' AND (EecDateOfTermination BETWEEN @StartDate AND @EndDate OR EecDateOfTermination >= @EndDate)))


--select drvEmplPayType, drvEmployer, drvPositionStatus, * from dbo.U_EEFXHLDEMO_drvTbl where drvNameLast = 'Hunter'


--select top 10 EecSalaryOrHourly, * from EmpComp

--select * from dbo.U_EEFXHLDEMO_Audit where audEEID = 'CW0BIU001020' and audTableName = 'EmpComp'

--2020-04-07 15:02:35.320