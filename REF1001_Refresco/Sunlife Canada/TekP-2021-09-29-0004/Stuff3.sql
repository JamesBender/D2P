    DECLARE  @FormatCode        VARCHAR(10)
            ,@ExportCode        VARCHAR(10)
            ,@StartDate         DATETIME
            ,@EndDate           DATETIME
            ,@StartPerControl   VARCHAR(9)
            ,@EndPerControl     VARCHAR(9);

    -- Set FormatCode
    SELECT @FormatCode = 'ESUNLIF2';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

SELECT @StartDate AS Start_Date, @EndDate AS END_Date;

select EecEmpNo, EecEmplStatus, EecEmplStatusStartDate, *
FROM dbo.U_ESUNLIF2_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
        AND (EecEmplStatus NOT IN ('T','R') OR (EecEmplStatus IN ('T','R') AND ISNULL(EecTermReason, '') NOT IN ('TRI','TRO')
                --AND EXISTS(SELECT * FROM dbo.U_ESUNLIF2_Audit WITH (NOLOCK) WHERE AudFieldName = 'EecEmplStatus' /*and AudEEID = xEEID*/ AND ISNULL(AudNewValue, '') IN ('T','R'))
				))            --SELECT * FROM U_ESUNLIF2_AuditFields
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_DSI_BDM_EmpDeductions WITH (NOLOCK)                --SELECT DEDLONGDESC FROM U_DSI_BDM_EmpDeductions
        ON EedEEID = xEEID
        AND EedCOID = xCOID
        AND EedFormatCode = 'ESUNLIF2'
        AND EedValidForExport = 'Y'
    --JOIN dbo.U_ESUNLIF2_PolNum WITH (NOLOCK)
        --ON PEEID = xEEID
        --AND PCOID = xCOID
    LEFT JOIN dbo.EmpsWithAllStops WITH (NOLOCK)
        ON EEID = xEEID
        AND COID = xCOID
    LEFT JOIN dbo.BenChRsn WITH (NOLOCK)
        ON BchCode = EecTermReason
    LEFT JOIN dbo.U_ESUNLIF2_Audit WITH (NOLOCK)
        ON AudEEID = xEEID
        AND AudFieldName = 'EecDedGroupCode'
        AND AudDateTime = (SELECT MAX(AudDateTime) FROM dbo.U_ESUNLIF2_Audit WITH (NOLOCK) WHERE AudEEID = xEEID AND AudFieldName = 'EecDedGroupCode')

	/*LEFT JOIN (
				SELECT audEEID as RStatEEID --, AudCOID AS RStatCOID 
				FROM dbo.U_ESUNLIF2_Audit WITH (NOLOCK)
				--WHERE AudFieldName = 'EecEmplStatus' AND ISNULL(AudNewValue, '') IN ('T','R') --AND audEEID = 'CDWDN902U0K0'
				WHERE AudFieldName = 'EecEmplStatus' 
					AND ISNULL(AudNewValue, '') = 'A' 
					AND ISNULL(AudOldValue, '') = 'R'
				) AS RStat*/
		--ON RStatEEID = xEEID
    LEFT JOIN dbo.U_ESUNLIF2_OverRideDate WITH (NOLOCK)
        ON EhcEEID = xEEID
        AND EhcCOID = xCOID
    LEFT JOIN dbo.U_ESUNLIF2_New WITH (NOLOCK)
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
    LEFT JOIN dbo.U_ESUNLIF2_NewEmp WITH (NOLOCK)
        ON NewEmp = xEEID
    WHERE EXISTS(
	
					SELECT * 
					FROM dbo.EmpDed WITH (NOLOCK) 
					WHERE EedEEID = xEEID AND EedCOID = xCOID 
					--AND EedStartDate <= @EndDate AND EedStopDate IS NULL
                   AND EedDedCode IN ('CCDEN','CPDEN','CDENT','CSDEN','CVDEN','CDENQ','CHLHQ','CHLTH','CCHLH','CPHLH','CHLHQ','CHLTH','CSHLH','CVHLH','CCLIF','CPLIF','CSLIF','CVLIF','CLIFE','CLTD','CCLTD','CPLTD','CSLTD','CVLTD','CELTD','CCDLI','CPDLI','CSDLI','CVDLI','CDLIF'))
    AND 
	EecEmpNo <> '208681'
	AND 
	xEEID = 'DH7BZS000020'



	
SELECT EedStartDate, EedStopDate, * 
FROM dbo.EmpDed WITH (NOLOCK) 
WHERE EedEEID = 'DH7BZS000020' AND EedCOID = 'CMCOX' 
AND EedStartDate <= @EndDate 
--AND EedStopDate IS NULL
AND EedDedCode IN ('CCDEN','CPDEN','CDENT','CSDEN','CVDEN','CDENQ','CHLHQ','CHLTH','CCHLH','CPHLH','CHLHQ','CHLTH','CSHLH','CVHLH','CCLIF','CPLIF','CSLIF','CVLIF','CLIFE','CLTD','CCLTD','CPLTD','CSLTD','CVLTD','CELTD','CCDLI','CPDLI','CSDLI','CVDLI','CDLIF')



