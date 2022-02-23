--eSET NOCOUNT ON 

IF OBJECT_ID('tempdb..#PayDrive') IS NOT NULL
  DROP TABLE #paydrive 

IF OBJECT_ID('tempdb..#PayDrive1') IS NOT NULL
  DROP TABLE #paydrive1

IF OBJECT_ID('tempdb..#EmpDedFull') IS NOT NULL
  DROP TABLE #EmpDedFull

IF OBJECT_ID('tempdb..#DedCodeFull') IS NOT NULL
  DROP TABLE #DedCodeFull


SELECT  CASE WHEN prkprodcode IS NULL THEN GETDATE()
             WHEN prgpaydate >= prgperiodenddate THEN prgpaydate
             ELSE prgperiodenddate
        END AS paydate,
        prggennumber,
        prgeeid,
        prgcoid,
        prgpercontrol,
        prgdocno,
		PrgCheckAddMode,
		PrgCheckAmt,
        prglocation,
        prgorglvl1,
        prgorglvl2,
        prgorglvl3,
        prgorglvl4,
        prgpaydate,
        prgpaygroup,
        prgempno,
        pdhdedcode,
        pdheecuramt,
        pdhercuramt
INTO    #paydrive
FROM    payreg
-- Join EMPCOMP WITH (NOLOCK) on IT DOES NOT MATTER JUST LEAVE THIS SILLY COMMENT FOR THE SECURITY MACRO SUBSTITUTION TO WORK
INNER JOIN dbo.ipdedhist WITH ( NOLOCK ) ON pdhgennumber = prggennumber
LEFT JOIN rbsproductkeys WITH ( NOLOCK ) ON prkprodcode = 'NETOE' 
WHERE  prgpercontrol BETWEEN '201906141' AND '201906149' 

CREATE NONCLUSTERED INDEX UDX_paydrive ON #paydrive ( PrgGenNumber ) 

CREATE NONCLUSTERED INDEX IDX_paydrive_EEIDCOIDPaydate ON #paydrive ( PrgEEID, PrgCoID, PdhDedCode )

SELECT  EedEEID,
        EedCoID,
        EedDedCode,
        EedEEGoalAmt,
        EedEEYTDAmt,
        EedERYTDAmt,
        EedStartDate,
        EedStopDate,
		EedTVStartDate,
		EedTVEndDate
INTO    #EmpDedFull
FROM    dbo.EmpDedFull
WHERE   EXISTS ( SELECT 1
                 FROM   #paydrive
                 WHERE  EedEEID = PrgEEID
                        AND EedCoID = PrgCoID
                        AND EedDedCode = PdhDedCode
                        AND paydate >= EedTVStartDate
                        AND paydate < EedTVEndDate )

CREATE NONCLUSTERED INDEX IDX_EmpDedFull_EEIDCOID ON #EmpDedFull ( EedEEID, EedCoID, EedDedCode, EedTVStartDate, EedTVEndDate )

SELECT  DedDedCode,
        DedStubDesc,
        DedTVStartDate,
        DedTVEndDate
INTO    #DedCodeFull
FROM    dbo.DedCodeFull WITH ( NOLOCK )
WHERE   EXISTS ( SELECT 1
                 FROM   #EmpDedFull
                 WHERE  DedDedCode = EedDedCode ) 

CREATE NONCLUSTERED INDEX IDX_DedCodFull ON #DedCodeFull ( DedDedCode, DedTVStartDate, DedTVEndDate ) 
INCLUDE ( DedStubDesc )

        SELECT  EedEEGoalAmt,
                EedEEYTDAmt,
                EedERYTDAmt,
                EedStartDate,
                EedStopDate,
                EedDedCode,
                PdhDedCode,
                DedDedCode,
                DedStubDesc,
                PdhEECurAmt,
                PdhERCurAmt,
                PrgCoID,
                PrgDocNo,
				PrgEEID,
                PrgCheckAddMode,
				PrgCheckAmt,
				PrgEmpNo,
                PrgGenNumber,
                PrgLocation,
                EepNameLast,
                EepNameSuffix,
                EepNameFirst,
                EepNameMiddle,
                eepSSN,
                PrgOrgLvl1,
                PrgOrgLvl2,
                PrgOrgLvl3,
                PrgOrgLvl4,
                PrgPayDate,
                PrgPayGroup,
                PrgPerControl
        INTO    #paydrive1
        FROM    #paydrive
        INNER JOIN dbo.EmpPers WITH ( NOLOCK ) ON eepEEID = PrgEEID
        INNER JOIN #EmpDedFull ON EedDedCode = PdhDedCode
                                  AND EedEEID = PrgEEID
                                  AND EedCoID = PrgCoID
								  AND paydate >= EedTVStartDate
								  AND paydate < EedTVEndDate
        INNER JOIN #DedCodeFull ON PdhDedCode = DedDedCode
                                   AND ( paydate ) >= DedTVStartDate
                                   AND ( paydate ) < DedTVEndDate
        WHERE   (
                  ( PdhEECurAmt <> 0 )
                  OR ( PdhERCurAmt <> 0 )
                )

CREATE NONCLUSTERED INDEX IDX_PayDrive1
ON #paydrive1 ([PrgCoID])
INCLUDE ([EedEEGoalAmt],[EedEEYTDAmt],[EedERYTDAmt],[EedStartDate],[EedStopDate],[PdhDedCode],[DedDedCode],[DedStubDesc],[PdhEECurAmt],[PdhERCurAmt],[PrgDocNo],[PrgCheckAddMode],[PrgCheckAmt],[PrgEEID],[PrgEmpNo],[PrgGenNumber],[PrgLocation],[EepNameLast],[EepNameSuffix],[EepNameFirst],[EepNameMiddle],[eepSSN],[PrgOrgLvl1],[PrgOrgLvl2],[PrgOrgLvl3],[PrgOrgLvl4],[PrgPayDate],[PrgPayGroup],[PrgPerControl])

CREATE NONCLUSTERED INDEX IDX_PayDrive1_EEIDCOID
ON #paydrive1 ([PrgCoID],[PrgEEID])
INCLUDE ([EedEEGoalAmt],[EedEEYTDAmt],[EedERYTDAmt],[EedStartDate],[EedStopDate],[PdhDedCode],[DedDedCode],[DedStubDesc],[PdhEECurAmt],[PdhERCurAmt],[PrgDocNo],[PrgCheckAddMode],[PrgCheckAmt],[PrgEmpNo],[PrgGenNumber],[PrgLocation],[EepNameLast],[EepNameSuffix],[EepNameFirst],[EepNameMiddle],[eepSSN],[PrgOrgLvl1],[PrgOrgLvl2],[PrgOrgLvl3],[PrgOrgLvl4],[PrgPayDate],[PrgPayGroup],[PrgPerControl])

SELECT  CmpCompanyName,
        CmpCompanyName + PrgCoID,
        EecEEID,
        EecCoID,
        EedEEGoalAmt,
        EedEEYTDAmt,
        EedERYTDAmt,
        EedStartDate,
        EedStopDate,
        PdhDedCode,
        DedDedCode + ' - ' + DedStubDesc AS dedstubdesc,
        PdhEECurAmt,
        PdhERCurAmt,
        PrgCoID,
        PrgDocNo,
		PrgCheckAddMode,
		PrgCheckAmt,
		PrgEEID,
        PrgEmpNo,
        PrgGenNumber,
        PrgLocation,
        EepNameLast,
        EepNameSuffix,
        EepNameFirst,
        EepNameMiddle,
        eepSSN,
        PrgOrgLvl1,
        PrgOrgLvl2,
        PrgOrgLvl3,
        PrgOrgLvl4,
        PrgPayDate,
        PrgPayGroup,
        PrgPerControl,
        RTRIM(EepNameLast) + RTRIM(EepNameFirst) + RTRIM(COALESCE(EepNameMiddle, '')) + PrgCoID + PrgEEID AS employee, 
		group1 = CASE 
					WHEN Coalesce(Rtrim('No Group1'), '') = '' THEN 
					'Not Specified' 
					ELSE 'No Group1' 
					END, 
		group2 = CASE 
					WHEN Coalesce(Rtrim('No Group2'), '') = '' THEN 
					'Not Specified' 
					ELSE 'No Group2' 
					END, 
		group3 = CASE 
					WHEN Coalesce(Rtrim('No Group3'), '') = '' THEN 
					'Not Specified' 
					ELSE 'No Group3' 
					END, 
		group4 = CASE 
					WHEN Coalesce(Rtrim('No Group4'), '') = '' THEN 
					'Not Specified' 
					ELSE 'No Group4' 
					END, 
		group5 = CASE 
					WHEN Coalesce(Rtrim('No Group5'), '') = '' THEN 
					'Not Specified' 
					ELSE 'No Group5' 
					END, 
		group6 = CASE 
					WHEN Coalesce(Rtrim('No Group6'), '') = '' THEN 
					'Not Specified' 
					ELSE 'No Group6' 
					END 
FROM    #paydrive1 p
INNER JOIN dbo.Company WITH ( NOLOCK ) ON p.PrgCoID = CmpCoID
INNER JOIN EmpComp WITH ( NOLOCK ) ON EecEEID = p.PrgEEID
                                      AND EecCoID = p.PrgCoID			
WHERE cmpCoID in (SELECT cmpCOID FROM Company (NOLOCK))                   
		--AND pdhDedCode IN ('401CF', '401KM', '401CP', '401F', '401L', '401L2', '401P', 'PRTHF', 'PRTHP', 'P401F', 'P401P', 'RTHCF', 'RTHCP', 'ROTHF', 'ROTHP')         
ORDER BY     
        p.PrgPayDate DESC,
        p.PdhDedCode;