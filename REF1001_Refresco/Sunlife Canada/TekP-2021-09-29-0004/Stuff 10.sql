UPDATE dbo.AscExp
    SET expLastStartPerControl = '202206301'
       ,expStartPerControl     = '202206301'
       ,expLastEndPerControl   = '202207061'
       ,expEndPerControl       = '202207061'
WHERE expFormatCode = 'ESUNLIFE'
AND ExpExportCode = 'TEST'


    DECLARE  @FormatCode        VARCHAR(10)
            ,@ExportCode        VARCHAR(10)
            ,@StartDate         DATETIME
            ,@EndDate           DATETIME
            ,@StartPerControl   VARCHAR(9)
            ,@EndPerControl     VARCHAR(9);

    -- Set FormatCode
    SELECT @FormatCode = 'ESUNLIFE';
	DECLARE @EEID VARCHAR(12) = 'CDWDMR02C0K0'

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

	SELECT @StartDate, @EndDate;

SELECT DISTINCT xEEID,xCOID,EecLocation,EecEmpNo,EecDateOfOriginalHire,EecStateSui,EecEmplStatus,EecSalaryOrHourly,EecTermReason,EdhChangeReason,EecDateOfTermination,EecEmplStatusStartDate,EshStatusStartDate,EEID,BchCode,EepAddressState,DedLongDesc,EecDedGroupCode,EecDateOfLastHire,OverrideDate,AudFieldName,AudOldValue,AudNewValue,AudDateTime,NewMem,EjhIsRateChange,EjhJobEffDate,AudEEID,EedDedCode,NewEmpDt
FROM dbo.U_ESUNLIFE_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
        AND (EecEmplStatus NOT IN ('T','R') OR (EecEmplStatus IN ('T','R') AND ISNULL(EecTermReason, '') NOT IN ('TRI','TRO')
                AND EXISTS(SELECT * FROM dbo.U_ESUNLIFE_Audit WITH (NOLOCK) WHERE AudFieldName = 'EecEmplStatus' AND ISNULL(AudNewValue, '') IN ('T','R'))))            --SELECT * FROM U_ESUNLIFE_AuditFields
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_DSI_BDM_EmpDeductions WITH (NOLOCK)                --SELECT DEDLONGDESC FROM U_DSI_BDM_EmpDeductions
        ON EedEEID = xEEID
        AND EedCOID = xCOID
        AND EedFormatCode = 'ESUNLIFE'
        --AND EedValidForExport = 'Y'
    --JOIN dbo.U_ESUNLIFE_PolNum WITH (NOLOCK)
        --ON PEEID = xEEID
        --AND PCOID = xCOID
    LEFT JOIN dbo.EmpsWithAllStops WITH (NOLOCK)
        ON EEID = xEEID
        AND COID = xCOID
    LEFT JOIN dbo.BenChRsn WITH (NOLOCK)
        ON BchCode = EecTermReason
    LEFT JOIN dbo.U_ESUNLIFE_Audit WITH (NOLOCK)
        ON AudEEID = xEEID
        AND AudFieldName = 'EecDedGroupCode'
        AND AudDateTime = (SELECT MAX(AudDateTime) FROM dbo.U_ESUNLIFE_Audit WITH (NOLOCK) WHERE AudEEID = xEEID AND AudFieldName = 'EecDedGroupCode')
    LEFT JOIN dbo.U_ESUNLIFE_OverRideDate WITH (NOLOCK)
        ON EhcEEID = xEEID
        AND EhcCOID = xCOID
    LEFT JOIN dbo.U_ESUNLIFE_New WITH (NOLOCK)
        ON NewEEID = xEEID
        AND NewDed = EedDedCode
    LEFT JOIN dbo.EmpHJob WITH (NOLOCK)
        ON EjhEEID = xEEID
        AND EjhCOID = xCOID
        AND EjhDateTimeCreated = (SELECT MAX(EjhDateTimeCreated) FROM dbo.EmpHJob WITH (NOLOCK) WHERE EjhEEID = xEEID AND EjhCOID = xCOID)
    LEFT JOIN dbo.EmpHDed WITH (NOLOCK)
        ON EdhEEID = xEEID
        AND EdhCOID = xCOID
        AND EdhDateTimeCreated = (SELECT MAX(EdhDateTimeCreated) FROM dbo.EmpHDed WITH (NOLOCK) WHERE EdhEEID = xEEID AND EdhCOID = xCOID)
    LEFT JOIN dbo.EMPHSTAT WITH (NOLOCK)
        ON EshEEID = xEEID
        AND EshIsCurrent = 'Y' 
        AND EshEmplStatus = 'R'
    LEFT JOIN dbo.U_ESUNLIFE_NewEmp WITH (NOLOCK)
        ON NewEmp = xEEID
    LEFT JOIN (
                SELECT AudEEID AS TerEEID, AudKey2 AS TerCOID, audDateTime AS TerDateTime, audOldValue AS TerOldValue, audNewValue AS TerNewValue
                FROM dbo.U_ESUNLIFE_Audit WITH (NOLOCK)
                WHERE audTableName = 'EmpComp'
                    AND audFieldName = 'EecEmplStatus'
                    AND audRowNo = 1) Ter
        ON xEEID = TerEEID
        AND xCOID = TerCOID
	LEFT JOIN (
				SELECT EedEEID AS BsEEID, EedCOID AS BsCOID
					,MAX(EedBenStopDate) AS RecentBenStopDate
				FROM dbo.U_DSI_BDM_EmpDeductions WITH (NOLOCK)
				where EedFormatCode = 'ESUNLIFE'
				AND EedBenStatus IN ('T','C')
				GROUP BY EedEEID, EedCOID) AS BenStop
		ON xEEID = BsEEID
		AND xCOID = BsCOID
	JOIN (
			SELECT EedEEID AS ActEEID, EedCOID AS ActCOID, COUNT(*) AS ActiveCoverages 
			FROM dbo.U_DSI_BDM_EmpDeductions WITH (NOLOCK) --where  EedEEID = 'CDWDO602J0K0'
			WHERE EedFormatCode = 'ESUNLIFE'
			--AND EedBenStatus = 'A' JCB Aug 2022
			AND (EedBenStatus = 'A' OR (EedBenStatus <> 'A') AND EedBenStatusDate BETWEEN @StartDate AND @EndDate)
			GROUP BY EedEEID, EedCOID) AS ActiveCgs
		ON xEEID = ActEEID
		AND xCOID = ActCOID
    WHERE --EXISTS(SELECT * FROM dbo.EmpDed WITH (NOLOCK) WHERE EedEEID = xEEID AND EedCOID = xCOID AND EedStartDate <= @EndDate AND EedStopDate IS NULL
            --        AND EedDedCode IN ('CCDEN','CPDEN','CDENT','CSDEN','CVDEN','CDENQ','CHLHQ','CHLTH','CCHLH','CPHLH','CHLHQ','CHLTH','CSHLH','CVHLH','CCLIF','CPLIF','CSLIF','CVLIF','CLIFE','CLTD','CCLTD','CPLTD','CSLTD','CVLTD','CELTD','CCDLI','CPDLI','CSDLI','CVDLI','CDLIF'))
			(
            (
                    EecEmplStatus = 'A' 
                    OR (EecEmplStatus IN ('T','R','L') AND EedBenStatus = 'A')
                    --OR (EecEmplStatus IN ('T','R','L') AND EedBenStatus = 'T' AND EedStopDate BETWEEN @StartDate AND @EndDate) JCB Aug 2022
					OR (EecEmplStatus IN ('T','R','L') AND EedBenStatus = 'T' AND ((EedStopDate BETWEEN @StartDate AND @EndDate) OR (EedBenStatusDate BETWEEN @StartDate AND @EndDate)))
                    OR (TerOldValue = 'R' AND TerNewValue = 'T' AND TerDateTime BETWEEN @StartDate AND @EndDate)
                )
    AND EecEmpNo <> '208681'
	AND EedBenStatusDate  <= @EndDate
	)
	AND xEEID = @EEID
    --GROUP BY xEEID,xCOID,EecLocation,EecEmpNo,EecDateOfOriginalHire,EecStateSui,EecEmplStatus,EecSalaryOrHourly,EecTermReason,EdhChangeReason,EecDateOfTermination,EecEmplStatusStartDate,EshStatusStartDate,EEID,BchCode,EepAddressState,DedLongDesc,EecDedGroupCode,EecDateOfLastHire,OverrideDate,AudFieldName,AudOldValue,AudNewValue,AudDateTime,NewMem,EjhIsRateChange,EjhJobEffDate,AudEEID,EedDedCode,NewEmpDt
	;
	SELECT * from dbo.U_ESUNLIFE_Audit WITH (NOLOCK) where audEEID = @EEID
	;
	SELECT EedBenStatus, EedBenStatusDate, EedDedCode -- EedEEID AS ActEEID, EedCOID AS ActCOID, COUNT(*) AS ActiveCoverages 
			FROM dbo.U_DSI_BDM_EmpDeductions WITH (NOLOCK) --where  EedEEID = 'CDWDO602J0K0'
			WHERE EedFormatCode = 'ESUNLIFE'
			--AND EedBenStatus = 'A' JCB Aug 2022
			AND (EedBenStatus = 'A' OR (EedBenStatus <> 'A') AND EedBenStatusDate BETWEEN @StartDate AND @EndDate)
			AND EedEEID = @EEID
			--GROUP BY EedEEID, EedCOID