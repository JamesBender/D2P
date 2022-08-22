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

--DECLARE @EEID VARCHAR(12) = 'CDWDMR02C0K0'
DECLARE @EEID VARCHAR(12) = 'EBCNB00BD020'

select * from dbo.U_ESUNLIFE_Member where drvEEID = @EEID
select * from dbo.U_ESUNLIFE_Person where drvEEID = @EEID
select * from dbo.U_ESUNLIFE_Salary where drvEEID = @EEID
select * from dbo.U_ESUNLIFE_Address where drvEEID = @EEID
select * from dbo.U_ESUNLIFE_Dep where drvEEID = @EEID
select * from dbo.U_ESUNLIFE_Benefit where drvEEID = @EEID

--select * from dbo.U_ESUNLIFE_EEList where xEEID = @EEID

--select * from dbo.U_ESUNLIFE_Audit where audEEID = @EEID

--SELECT * -- EedEEID AS ActEEID, EedCOID AS ActCOID, COUNT(*) AS ActiveCoverages 
--			FROM dbo.U_DSI_BDM_EmpDeductions WITH (NOLOCK) --where  EedEEID = 'CDWDO602J0K0'
--			WHERE EedFormatCode = 'ESUNLIFE'
--			AND (EedBenStatus = 'A' OR (EedBenStatus <> 'A') AND EedBenStatusDate BETWEEN @StartDate AND @EndDate)
--			AND 
			--EedEEID = @EEID

--SELECT * FROM EmpDed WHERE EedEEID = @EEID AND EedDedCode IN ('CCDEN','CPDEN','CDENT','CSDEN','CVDEN','CDENQ','CHLHQ','CHLTH','CCHLH','CPHLH','CHLHQ','CHLTH','CSHLH','CVHLH','CCLIF','CPLIF','CSLIF','CVLIF','CLIFE','CLTD','CCLTD','CPLTD','CSLTD','CVLTD','CELTD','CCDLI','CPDLI','CSDLI','CVDLI','CDLIF')

--select * from dbo.U_ESUNLIFE_EEList
--     where exists (Select 1 from dbo.EmpComp where EecEEID = xEEID and EecCoID = xCOID and EecEmplStatus IN ('T','R') And EecDateOfTermination >= @EndDate) 
--     AND Not exists (Select 1 from dbo.U_ESUNLIFE_Audit where audeeid = xeeid and audKey2 =xcoid and audfieldname = 'eecemplstatus' and isnull(audnewvalue, '') IN ('T','R'))
--	 AND xEEID = @EEID
--	 ;