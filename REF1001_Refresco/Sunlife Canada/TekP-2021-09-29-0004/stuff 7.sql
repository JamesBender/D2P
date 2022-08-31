--sp_getEEID 'Gonzales' -- CDWDMR02C0K0 206047
--sp_getEEID '209154' -- EBCNB00BD020

DECLARE  @FormatCode        VARCHAR(10)
            ,@StartDate         DATETIME
            ,@EndDate           DATETIME;

    -- Set FormatCode
    SELECT @FormatCode = 'ESUNLIFE';

    -- Declare dates from Parameter file
    SELECT @StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

DECLARE @EEID VARCHAR(12) = 'CDWDMR02C0K0'
--DECLARE @EEID VARCHAR(12) = 'EBCNB00BD020'

SELECT @StartDate, @EndDate; 

select * from dbo.U_ESUNLIFE_Member where drvEEID = @EEID
select * from dbo.U_ESUNLIFE_Person where drvEEID = @EEID
select * from dbo.U_ESUNLIFE_Salary where drvEEID = @EEID
select * from dbo.U_ESUNLIFE_Address where drvEEID = @EEID
select * from dbo.U_ESUNLIFE_Dep where drvEEID = @EEID
select * from dbo.U_ESUNLIFE_Benefit where drvEEID = @EEID