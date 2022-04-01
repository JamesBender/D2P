DECLARE  @FormatCode        VARCHAR(10)
            ,@ExportCode        VARCHAR(10)
            ,@StartDate         DATETIME
            ,@EndDate           DATETIME
            ,@StartPerControl   VARCHAR(9)
            ,@EndPerControl     VARCHAR(9);

    -- Set FormatCode
    SELECT @FormatCode = 'EVOYALDEXP';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

	select @StartDate, @EndDate;
	

SELECT 
        audEEID  = audKey1Value
        ,audKey2 = audKey2Value -- COID
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
        --,audNewHire = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = '' AND ISNULL(audNewValue,'') = 'A' THEN 'Y' ELSE 'N' END
    

	--select count(*)
	FROM dbo.U_EVOYALDEXP_EEList WITH (NOLOCK)
	JOIN dbo.EmpComp	
		ON xEEID = EecEEID
		AND xCOID = EecCOID
		AND EecDateOfOriginalHire <> EecDateOfLastHire 
    JOIN dbo.vw_AuditData WITH (NOLOCK) 
        ON audKey1Value = xEEID
        -- <shrug>
        AND audKey2Value = xCOID
    JOIN dbo.U_EVOYALDEXP_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime <= @EndDate
	AND audDateTime >= DATEADD(YEAR, -2, @EndDate) -- '6/1/2019' -- '1/1/2011'
	--AND audDateTime >= CAST('1/1/2011' AS DATE)
	--audDateTime BETWEEN CAST('1/1/2019' AS DATE) AND '12/31/2020' -- @EndDate
    AND audAction <> 'DELETE'
    AND ISNULL(audNewValue,'') <> '';

	-- 26742336

	--select * from dbo.vw_AuditData WITH (NOLOCK) where audDateTime BETWEEN CAST('1/1/2019' AS DATE) AND '12/31/2020' -- @EndDate
    
	