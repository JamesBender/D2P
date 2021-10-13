--sp_getEEID 'Chiodo' -- DOELFO000050


DECLARE  @FormatCode        VARCHAR(10)
            ,@ExportCode        VARCHAR(10)
            ,@StartDate         DATETIME
            ,@EndDate           DATETIME
            ,@StartPerControl   VARCHAR(9)
            ,@EndPerControl     VARCHAR(9)
            ,@FileName          VARCHAR(200)
            ,@RunDate           DATETIME
            ,@FileMinCovDate    DATETIME;

    -- Set FormatCode
    SELECT @FormatCode = 'EHARTFDID2';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@RunDate         = GETDATE()
        ,@FileMinCovDate  = '01/01/2021'
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

	SELECT /*CASE WHEN bdmDepRecID IS NOT NULL OR (E.EecPayGroup = 'GGSON' AND E.EecUnionLocal IN ('786','673','026','179','364','916')) THEN NULL
											WHEN bdmDepRecID IS NOT NULL AND LocAddressState IN ('NY','NJ') AND E.EecPayGroup = 'GGH' AND E.EecOrgLvl3 IN ('630','640') THEN '1' --dbo.dsi_fnGetMinMaxDates('MAX','8/1/2021',[dbo].[fn_EndOfMonth_EHARTFDID2](E.EecDateOfORiginalHire))
											WHEN bdmDepRecID IS NOT NULL AND LocAddressState IN ('NY','NJ') AND E.EecPayGroup = 'GGSOE' THEN '2' --dbo.dsi_fnGetMinMaxDates('MAX','8/1/2021',[dbo].[fn_EndOfMonth_EHARTFDID2](E.EecDateOfORiginalHire))
											WHEN bdmDepRecID IS NOT NULL AND LocAddressState IN ('NY','NJ') AND (E.EecPayGroup = 'GGSON' AND (E.EecUnionLocal IS NULL OR E.EecUnionLocal NOT IN  ('786','673','026','179','364','916'))) THEN '3' --dbo.dsi_fnGetMinMaxDates('MAX','8/1/2021',[dbo].[fn_EndOfMonth_EHARTFDID2](E.EecDateOfORiginalHire))

											-- This one
											WHEN bdmDepRecID IS NULL AND LocAddressState IN ('NY','NJ') AND E.EecEEType NOT IN ('TMP', 'INT') AND (E.EecUnionLocal IS NULL OR E.EecUnionLocal NOT IN ('786','673','026','179','364','916')) THEN '4' --dbo.dsi_fnGetMinMaxDates('MAX',@FileMinCovDate,[dbo].[fn_EndOfMonth_EHARTFDID2](E.EecDateOfORiginalHire))
										END 

									
										,CASE WHEN /*bdmDepRecID IS NULL OR*/ (E.EecPayGroup = 'GGSON' /*AND E.EecUnionLocal IN ('786','673','026','179','364','916')*/) THEN ''
											WHEN/* LocAddressState IN ('NY','NJ') AND*/ E.EecPayGroup <> 'GGSON' /*AND E.EecUnionLocal NOT IN ('786','673','026','179','364','916')*/ THEN LocAddressState
                                        ELSE ''
                                    END*/
									
									CASE WHEN bdmDedCode = 'OPLEE' THEN -- AND NOT (E.EecPayGroup = 'GGSON' AND E.EecUnionLocal IN ('786','673','026','179','364','916')) THEN
										CASE WHEN E.EecPayGroup = 'GGSON' AND E.EecUnionLocal IN ('786','673','026','179','364','916') THEN ''
										WHEN E.EecPayGroup = 'GGH' THEN
											CASE WHEN EecOrgLvl3 = '432' THEN '8'
												WHEN EecOrgLvl3 = '520' THEN '6'
												WHEN EecOrgLvl3 = '610' THEN '9'
												WHEN EecOrgLvl3 = '412' THEN '10'
												WHEN EecOrgLvl3 = '430' THEN '11'
												WHEN EecOrgLvl3 = '465' THEN '12'
												WHEN EecOrgLvl3 = '630' THEN '32'
												WHEN EecOrgLvl3 = '436' THEN '13'
												WHEN EecOrgLvl3 in ('425','440') THEN '14'
												WHEN EecOrgLvl3 = '640' THEN '28'
												WHEN EecOrgLvl3 = '510' THEN '16'
												WHEN EecOrgLvl3 = '410' THEN '15'
											END
										
										WHEN E.EecPayGroup = 'GGSON' /*AND E.EecUnionLocal NOT IN ('786','673','026','179','364','916')*/ THEN '30' -- <--- fix null check
										WHEN E.EecPayGroup = 'GGSOE' THEN '30'
										ELSE '1'
										END
									END
										
										
										,E.EecPayGroup, E.EecUnionLocal,  E.EecEEType, LocAddressState, BdmDepRecID, bdmDedCode
										
FROM dbo.U_EHARTFDID2_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp E WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.Company WITH (NOLOCK)
        ON CmpCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    LEFT JOIN dbo.U_dsi_bdm_EHARTFDID2  WITH (NOLOCK)
        ON bdmEEID = xEEID  
    LEFT JOIN dbo.U_dsi_BDM_EmpDeductions eed_LIF WITH (NOLOCK)
        ON eed_LIF.EedEEID = xEEID 
        AND eed_LIF.EedCoID = xCoID
        AND eed_LIF.EedFormatCode = @FormatCode 
        AND eed_LIF.EedValidForExport = 'Y'
		AND eed_LIF.EedBenStatus <> 'W'
        AND eed_LIF.eedDedCode = 'OPLEE'
        --AND eed_LIF.eedDedCode = bdmDedCode
    LEFT JOIN dbo.U_dsi_BDM_EmpDeductions eed_SPL WITH (NOLOCK)
        ON eed_SPL.EedEEID = xEEID 
        AND eed_SPL.EedCoID = xCoID
        AND eed_SPL.EedFormatCode = @FormatCode 
        AND eed_SPL.EedValidForExport = 'Y'
		AND eed_SPL.EedBenStatus <> 'W'
        AND eed_SPL.eedDedCode = 'OPLSP'
        AND eed_SPL.eedDedCode = bdmDedCode
    LEFT JOIN dbo.U_dsi_BDM_EmpDeductions eed_CH WITH (NOLOCK)
        ON eed_CH.EedEEID = xEEID 
        AND eed_CH.EedCoID = xCoID
        AND eed_CH.EedFormatCode = @FormatCode 
        AND eed_CH.EedValidForExport = 'Y'
		AND eed_CH.EedBenStatus <> 'W'
        AND eed_CH.eedDedCode = 'OPTCH'
        AND eed_CH.eedDedCode = bdmDedCode
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON conEEID = xeeid
        and ConSystemID = bdmDepRecID
		and bdmDepRecID IS NOT NULL
    LEFT JOIN dbo.U_EHARTFDID2_ISOCountryCodeMapping EA WITH (NOLOCK)
        ON EA.cCountryCode = EepAddressCountry
    LEFT JOIN dbo.U_EHARTFDID2_ISOCountryCodeMapping LA WITH (NOLOCK)
        ON LA.cCountryCode = LocAddressCountry
    LEFT JOIN dbo.U_EHARTFDID2_PEarHist WITH (NOLOCK)
        ON PehEEID = xEEID
    LEFT JOIN dbo.U_EHARTFDID2_Audit WITH (NOLOCK)
        ON audeeid = xeeid
    --LEFT JOIN dbo.EmpComp Supervisor WITH (NOLOCK)
    --    ON Supervisor.EecEEID = E.EecSupervisorID
     WHERE (
	 (E.EecEmplStatus <> 'T' OR audTerm = 'Y')
     AND (bdmDedCode IS NULL 
          OR bdmDedCode = 'OPLEE' 
          OR (bdmDedCode IN ('OPLSP','OPTCH') AND bdmDepRecID IS NOT NULL)
          OR (bdmDedCode IN ('OPLSP','OPTCH') AND bdmDepRecID IS NULL AND eed_LIF.EedEEID IS NULL) ))
		  AND xEEID = 'DOELFO000050'
    