DECLARE  @FormatCode        VARCHAR(10)
            ,@ExportCode        VARCHAR(10)
            ,@StartDate         DATETIME
            ,@EndDate           DATETIME
            ,@StartPerControl   VARCHAR(9)
            ,@EndPerControl     VARCHAR(9);

    -- Set FormatCode
    SELECT @FormatCode = 'ECUNA401QF';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

SELECT xEEID, EepNameLast, EepNameFirst, EecEmplStatus, PgrPayGroup, EecDateOfTermination, PdhEEDeferral, PdhEERoth, PdhERMatch, PdhLoanPmt1, BdmDedCode
FROM dbo.U_ECUNA401QF_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN dbo.U_dsi_BDM_ECUNA401QF WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.U_ECUNA401QF_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
    LEFT JOIN dbo.U_ECUNA401QF_PEarHist WITH (NOLOCK)
        ON PehEEID = xEEID
    LEFT JOIN (
                SELECT BdmEEID AS EdEEID, BdmCOID AS EdCOID
                    ,MAX(CASE WHEN BdmDedCode = '401M' THEN BdmBenStartDate END) AS EdBenStartDate 
                FROM dbo.U_dsi_BDM_ECUNA401QF WITH (NOLOCK)
                WHERE BdmDedCode = '401M'
                GROUP BY BdmEEID, BdmCOID ) AS ED
        ON EdEEID = xEEID
        AND EdCOID = xCOID
    LEFT JOIN (
                SELECT EshEEID, EshCOID, EshStatusStartDate, EshStatusStopDate, EshEmplStatus
                FROM (
                        SELECT EshEEID, EshCOID, EshStatusStartDate, EshStatusStopDate, EshEmplStatus, ROW_NUMBER() OVER (PARTITION BY EshEEID, EshCOID ORDER BY EshStatusStartDate DESC) AS RN
                        FROM dbo.EmpHStat WITH (NOLOCK) ) AS LoaDates
                WHERE RN = 2 AND EshEmplStatus = 'L') AS StatusChange
        ON EshEEID = xEEID
        AND EshCOID = xCOID
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	JOIN dbo.PayGroup WITH (NOLOCK)
        ON PgrPayGroup = EecPayGroup
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    WHERE ((EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND EecDateOfTermination BETWEEN DATEADD(DAY, -14 ,@EndDate) AND @EndDate))
        --AND 
		OR 
		((PdhEEDeferral <> 0.00 OR PdhEERoth <> 0.00 OR PdhERMatch <> 0.00 OR PdhLoanPmt1 <> 0.00) OR BdmDedCode IS NOT NULL))
		AND xEEID IN ('D26ZWW000020','CFCW2T0000K0','A4A4JE0010K0','9XSIZA0000K0','CH7G4V000020','9U6ZTH0010K0','CCXPKC0000K0','9U6ZW60000K0','9VWL0K0010K0','ALHZ030010K0','9YU33E0000K0','CG2UJ5000020','BXG1W40000K0','C1PZ2U0000K0','C7J0B50000K0','ARIKVQ0000K0','CM8XNJ002020')