USE [ULTIPRO_WPMARBA]
GO
/****** Object:  StoredProcedure [dbo].[dsi_sp_BuildDriverTables_ECIGNA834]    Script Date: 6/2/2021 12:08:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECIGNA834]
    @systemid CHAR(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client: Mar-Bel

Created By: Keary McCutchen
Business Analyst: Cheryl Petitti
Create Date: 2021-05-12
Service Request Number: SR-2021-00307379 / TekP-2021-04-08-0005

Purpose: CIGNA 834

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/20XX     SR-20XX-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECIGNA834';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECIGNA834';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECIGNA834';
SELECT * FROM dbo.AscExp WHERE expFormatCode = 'ECIGNA834';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECIGNA834' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECIGNA834', 'TEST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECIGNA834', 'FULLFILE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECIGNA834', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECIGNA834', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECIGNA834', 'SCHEDULED';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ECIGNA834';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ECIGNA834', @AllObjects = 'Y', @IsWeb = 'N';
**********************************************************************************/
BEGIN

    --==========================================
    -- Declare variables
    --==========================================
    DECLARE  @FormatCode        VARCHAR(10)
            ,@ExportCode        VARCHAR(10)
            ,@StartDate         DATETIME
            ,@EndDate           DATETIME
            ,@StartPerControl   VARCHAR(9)
            ,@EndPerControl     VARCHAR(9)
            ,@RunDate           VARCHAR(8)
            ,@RunTime           VARCHAR(4)
            ,@FileMinCovDate    DATETIME;

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl  = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = CAST(LEFT(StartPerControl,8) AS DATETIME)
        ,@EndDate         = DATEADD(SS,-1,DATEADD(DD,1,LEFT(EndPerControl,8)))
        ,@FormatCode      = FormatCode
        ,@ExportCode      = ExportCode
        ,@RunDate         = CONVERT(VARCHAR(8),GETDATE(),112)
        ,@RunTime         = REPLACE(CONVERT(VARCHAR(5), GETDATE(), 108),':',SPACE(0))
        ,@FileMinCovDate  = '20210401'
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = 'ECIGNA834';

    --==========================================
    -- Audit Code
    --==========================================
    -- Get data from audit fields table.  Add fields here if auditing
    IF OBJECT_ID('U_ECIGNA834_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ECIGNA834_AuditFields;
    
	CREATE TABLE dbo.U_ECIGNA834_AuditFields (aTableName VARCHAR(30),aFieldName VARCHAR(30));
    
	-- Employee Information
    INSERT INTO dbo.U_ECIGNA834_AuditFields VALUES ('EmpComp','EecOrgLvl1');
    INSERT INTO dbo.U_ECIGNA834_AuditFields VALUES ('EmpComp','EecLocation');
    INSERT INTO dbo.U_ECIGNA834_AuditFields VALUES ('PayGroup','PgrPayFrequency');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ECIGNA834_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ECIGNA834_Audit;
    SELECT audEEID = xEEID
        ,audCOID = xCOID
        ,audKey1 = audKey1Value
        ,audKey2 = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
        ,audEffectiveDate
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    INTO dbo.U_ECIGNA834_Audit
    FROM dbo.U_ECIGNA834_EEList WITH (NOLOCK)
    JOIN dbo.vw_AuditData WITH (NOLOCK)
        ON xEEID = audKey1Value
    JOIN dbo.U_ECIGNA834_AuditFields WITH (NOLOCK)
        ON aTableName = audTableName
        AND aFieldName = audFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND ISNULL(audNewValue, '') <> ''
	AND audAction = 'Update'
	AND ((audFieldName = 'EecOrgLvl1' AND (audOldValue IN ('CORP','OH','MO','VA','BMC','CA') or audNewValue IN ('CORP','OH','MO','VA','BMC','CA')))
		  OR (audFieldName = 'EecLocation' AND (audOldValue IN ('IL') or audNewValue IN ('IL')))
		  OR (audFieldName = 'PgrPayFrequency' AND (audOldValue IN ('B','W') or audNewValue IN ('B','W')))
		 )
	;

    --==========================================
    -- Deduction Code List
    --==========================================
    DECLARE @DedList VARCHAR(MAX);
    SET @DedList = 'MBMO, MBOH, MBOHO, MBVA, MHSMO, MHSO, MHSOH, MHSVA, MBUMO, MBUO, MBUOH, MBUVA';

    IF OBJECT_ID('U_ECIGNA834_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ECIGNA834_DedList;
    SELECT DedCode = DedDedCode
        ,DedLongDesc
        ,DedType = DedDedType
    INTO dbo.U_ECIGNA834_DedList
    FROM dbo.dsi_BDM_fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

    --==========================================
    -- Clean EE List
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_ECIGNA834_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCoID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECIGNA834_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    -- Remove Employees that Do Not Have a Benefit Plan in Deduction Code List
    DELETE FROM dbo.U_ECIGNA834_EEList
    WHERE NOT EXISTS (SELECT 1 FROM dbo.EmpDed JOIN dbo.U_ECIGNA834_DedList ON DedCode = EedDeDCode WHERE EedEEID = xEEID);

	--Remove Test Employees and Z employee types
-- Cleans EE List of Employees Where EecEmpType = TES
    DELETE FROM dbo.U_ECIGNA834_EEList 
	WHERE xEEID IN (SELECT DISTINCT EecEEID  FROM dbo.EmpComp WITH (NOLOCK) WHERE EecEEType IN ('Z'))
	   OR xEEID IN (SELECT DISTINCT EepEEID  FROM dbo.EmpPers WITH (NOLOCK) WHERE LEFT(EepSSN,3) = '999')
	;
    --==========================================
    -- BDM Section
    --==========================================
    -- now set values for benefit module
    DELETE FROM dbo.U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode;

    -- Required parms
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'DedCodes',@DedList);
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'TermSelectionOption', 'AuditDate');

    -- Non-required parms
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'IncludeOEDrops','Y');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'OERemoveTermEmps','N');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'GetChangeReason','Y');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS, DP');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsChild','CH, CHL, DIS, DPC, STC');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','@DomPartnerCSV');
	INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'FutureDatedStartDateDays', '30')
	INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'FutureDatedStopDateDays', '30')

    --Set if OE
    IF @ExportCode LIKE '%PASSIVE'
    BEGIN
         INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'PASSIVE');
    END;

    IF @ExportCode LIKE '%ACTIVE'
    BEGIN
         INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'ACTIVE');
    END;

    EXEC dbo.dsi_bdm_sp_PopulateDeductionsTable @FormatCode;

    --=========================================
    -- Update BdmChangeReason For Dependents
    --=========================================
    UPDATE D
        SET D.BdmChangeReason = E.BdmChangeReason
    FROM dbo.U_dsi_bdm_ECIGNA834 D
    JOIN dbo.U_dsi_bdm_ECIGNA834 E
        ON E.BdmEEID = D.BdmEEID
        AND E.BdmCOID = D.BdmCOID
        AND E.BdmDedCode = D.BdmDedCode
    WHERE D.BdmRecType = 'DEP' AND E.BdmRecType = 'EMP';

    --=====================================================
    -- Update BdmUSGField2 with EmpDedTVID for Employees
    --=====================================================
    UPDATE dbo.U_dsi_bdm_ECIGNA834
        SET BdmUSGField2 = EedEmpDedTVID
    FROM dbo.U_dsi_bdm_ECIGNA834
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = BdmEEID
        AND EedCOID = BdmCOID
        AND EedDedCode = BdmDedCode
    WHERE BdmRecType = 'EMP' AND EedFormatCode = @FormatCode AND EedValidForExport = 'Y';

    --=======================================================
    -- Update BdmUSGField2 with DepBPlanTVID for Dependents
    --=======================================================
    UPDATE dbo.U_dsi_bdm_ECIGNA834
        SET BdmUSGField2 = DbnDepBPlanTVID
    FROM dbo.U_dsi_bdm_ECIGNA834
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
        ON DbnEEID = BdmEEID
        AND DbnCOID = BdmCOID
        AND DbnDedCode = BdmDedCode
    WHERE BdmRecType = 'DEP' AND DbnFormatCode = @FormatCode AND DbnValidForExport = 'Y';

    --======================================================
    -- Update BdmUSGField1 with Benefit Amount (EedBenAmt)
    --======================================================
    UPDATE dbo.U_dsi_bdm_ECIGNA834
        SET BdmUSGField1 = CONVERT(VARCHAR(20),EedBenAmt)
    FROM dbo.U_dsi_bdm_ECIGNA834
    JOIN dbo.EmpDedFull WITH (NOLOCK)
        ON EedEmpDedTVID = BdmUSGField2;

    --==========================================
    -- Build Driver Tables
    --==========================================

    /**************************************************************************************************************
        HEADER RECORDS
            - ISA, GS, ST, BGN, REF, QTY Segments
            - LOOP 1000A/1000B RECORDS - N1 Segments
    ***************************************************************************************************************/

    -------------------
    -- HEADER RECORD 
    -------------------
    IF OBJECT_ID('U_ECIGNA834_HdrTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECIGNA834_HdrTbl;
    SELECT DISTINCT drvISA05_SenderIDQual = 'ZZ'
        ,drvISA06_SenderID = 'MARBELINC000834'
        ,drvISA07_ReceiverIDQual = 'ZZ'
        ,drvISA08_ReceiverID = '807050000000000'
        ,drvISA09_InterchangeDate = RIGHT(@RunDate,6)
        ,drvISA10_InterchangeTime = @RunTime
        ,drvISA15_UsageIndicator = CASE dbo.dsi_fnVariable(@FormatCode,'Testing') WHEN 'Y' THEN 'T' ELSE 'P' END
        ,drvGS02_SenderID = 'MARBELINC000834'
        ,drvGS03_ReceiverID = '807050000000000'
        ,drvGS04_Date = @RunDate
        ,drvGS05_Time = @RunTime
        ,drvBGN03_Date = @RunDate
        ,drvBGN04_Time = @RunTime
        ,drvBGN05_TimeCode = ''
        ,drvBGN06_RefID = ''
        ,drvBGN07_TransTypeCode = ''
        ,drvBGN08_ActionCode = 'RX'
        ,drvREF01_RefNumberQual = '38'
        ,drvREF02_RefNumberQual = '00632379-F'
        ,drvQTY01_QuantityQual1 = ''
        ,drvQTY02_Quantity1 = ''
        ,drvQTY01_QuantityQual2 = ''
        ,drvQTY02_Quantity2 = ''
        ,drvQTY01_QuantityQual3 = ''
        ,drvQTY02_Quantity3 = ''
        ,drvN101_EntityIDCodeSponsor1 = 'P5'
        ,drvN102_Name1 = 'Mar-Bal, Inc.'
        ,drvN103_IDCodeQual1 = 'FI'
        ,drvN104_IDCode1 = '341059601'
        ,drvN101_EntityIDCodeSponsor2 = 'IN'
        ,drvN102_Name2 = 'CIGNA'
        ,drvN103_IDCodeQual2 = 'FI'
        ,drvN104_IDCode2 = '06-0303370'
    INTO dbo.U_ECIGNA834_HdrTbl
    FROM dbo.U_ECIGNA834_EELIST WITH (NOLOCK)
    JOIN dbo.U_dsi_bdm_ECIGNA834 WITH (NOLOCK)
        ON BdmEEID = xEEID
        AND BdmCOID = xCOID;

    /**************************************************************************************************************
        DETAIL RECORDS
            -- LOOP 2000 RECORDS - INS, REF, DTP Segments
            -- LOOP 2100A RECORDS - NM1, PER, N3, N4, DMG, ICM Segments
            -- LOOP 2100B RECORDS - NM1, DMG Segments
    ***************************************************************************************************************/

    -------------------
    -- DETAIL RECORD 
    -------------------
    IF OBJECT_ID('U_ECIGNA834_DrvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECIGNA834_DrvTbl;
    SELECT DISTINCT
        --=====================
        --LOOP 2000 RECORDS
        --=====================
        drvINS01_YesNoCond = CASE BdmRecType
                                 WHEN 'EMP' THEN 'Y'
                                 ELSE 'N'
                             END
        ,drvINS02_RelationshipCode = CASE WHEN BdmRecType = 'EMP' THEN '18'
                                          ELSE
                                                CASE WHEN ConRelationship IN ('SPS, DP') THEN '01'
                                                     WHEN ConRelationship IN ('CH, CHL, DIS, DPC, STC') THEN '19'
                                                     ELSE '19'
                                                END
                                     END
        ,drvINS03_MaintTypeCode = '030' --Audit or Compare
        ,drvINS04_MaintReasonCode = 'XN' --Notification Only
        ,drvINS05_BenefitStatusCode = 'A'
        ,drvINS0601_MEDICAREPLANCODE = ''
        ,drvINS0602_EligibilityRsnCode = ''
        ,drvINS07_COBRAQualEventCode = ''
        ,drvINS08_EmploymentStatusCode = CASE WHEN BdmRecType = 'EMP' THEN
                                                CASE WHEN EecEmplStatus = 'T' THEN 'TE' --Termination
                                                     ELSE 'AC'
                                                END
                                         END
        ,drvINS09_StudentStatusCode = CASE WHEN BdmRecType = 'DEP' THEN
                                                CASE WHEN ConIsStudent = 'Y' THEN 'F' END --Full-time
                                      END
        ,drvINS10_ResponseCode = CASE WHEN BdmRecType = 'EMP' THEN
                                        CASE WHEN EepIsDisabled = 'Y' THEN 'Y'
                                             ELSE 'N'
                                        END
                                      WHEN BdmRecType = 'DEP' THEN 
                                        CASE WHEN ConIsDisabled = 'Y' THEN 'Y'
                                             ELSE 'N'
                                        END
                                END
        ,drvINS11_DateTimeFormatQual = CASE WHEN ISNULL(EepDateDeceased, '') <> '' THEN 'D8' END
        ,drvINS12_DateTimePeriod = CASE WHEN ISNULL(EepDateDeceased, '') <> '' THEN CONVERT(VARCHAR(8),EepDateDeceased,112) END
        -- If drvREF01_RefNumberQual1 is Populated, then send REF Segment
        ,drvREF01_RefNumberQual1 = CASE WHEN BdmRecType = 'EMP' THEN '1L' END
        ,drvREF02_RefNumberQual1 = CASE WHEN BdmRecType = 'EMP' THEN '00632379-F' END
        -- If drvREF01_RefNumberQual2 is Populated, then send REF Segment
        ,drvREF01_RefNumberQual2 = CASE WHEN BdmRecType = 'EMP' THEN 'DX' END
        ,drvREF02_RefNumberQual2 = CASE WHEN BdmRecType = 'EMP' THEN '0001' END
        -- If drvREF01_RefNumberQual3 is Populated, then send REF Segment
        ,drvREF01_RefNumberQual3 = CASE WHEN BdmRecType = 'EMP' THEN 'ZZ' END
        ,drvREF02_RefNumberQual3 = CASE WHEN BdmRecType = 'EMP' THEN 
										CASE WHEN EecOrgLvl1 = 'CORP' AND EecLocation <> 'IL' AND PgrPayFrequency = 'B' THEN 'A001'
											WHEN EecOrgLvl1 = 'CORP' AND EecLocation <> 'IL' AND PgrPayFrequency = 'W' THEN 'A002'
											WHEN EecOrgLvl1 = 'CORP' AND EecLocation = 'IL' AND PgrPayFrequency = 'B' THEN 'A003'
											WHEN EecOrgLvl1 = 'CORP' AND EecLocation = 'IL' AND PgrPayFrequency = 'W' THEN 'A004'
											WHEN EecOrgLvl1 = 'MO' AND PgrPayFrequency = 'B' THEN 'A005'
											WHEN EecOrgLvl1 = 'MO' AND PgrPayFrequency = 'W' THEN 'A006'
											WHEN EecOrgLvl1 = 'OH' AND PgrPayFrequency = 'B' THEN 'A007'
											WHEN EecOrgLvl1 = 'OH' AND PgrPayFrequency = 'W' THEN 'A008'
											WHEN EecOrgLvl1 = 'VA' AND PgrPayFrequency = 'B' THEN 'A009'
											WHEN EecOrgLvl1 = 'VA' AND PgrPayFrequency = 'W' THEN 'A010'
											WHEN EecOrgLvl1 = 'BMC' AND PgrPayFrequency = 'B' THEN 'A011'
											WHEN EecOrgLvl1 = 'BMC' AND PgrPayFrequency = 'W' THEN 'A012'
											WHEN EecOrgLvl1 = 'CA' AND PgrPayFrequency = 'B' THEN 'A013'
											WHEN EecOrgLvl1 = 'CA' AND PgrPayFrequency = 'W' THEN 'A014'
										END
									END
        -- If drvDTP00_DateTime1 is Populated, then send DTP Segment
        ,drvDTP00_DateTime1 =CASE WHEN BdmRecType = 'EMP' THEN  'DTP' END
        ,drvDTP01_DateTimeQualifier1 = CASE WHEN BdmRecType = 'EMP' THEN '303' END
        ,drvDTP02_DateTimeFormatQual1 = CASE WHEN BdmRecType = 'EMP' THEN 'D8' END
        ,drvDTP03_DateTimePeriod1 = CASE WHEN BdmRecType = 'EMP' THEN 
										 CONVERT(VARCHAR(8),
										 CASE WHEN (SELECT MAX(audDateTime) FROM dbo.U_ECIGNA834_Audit WITH (NOLOCK) WHERE audEEID = xEEID and audCOID = xCOID) IS NULL 
											  THEN [dbo].[dsi_fnlib_GetAnnSalary_EffDate_WithStartDate] (xEEID, xCOID, @StartDate,EecDateOfLastHire) 
									     ELSE  (SELECT MAX(audDateTime) FROM dbo.U_ECIGNA834_Audit WITH (NOLOCK) WHERE audEEID = xEEID and audCOID = xCOID) 
										 END,112)
									END
        -- If drvDTP00_DateTime2 is Populated, then send DTP Segment
        ,drvDTP00_DateTime2 = CASE WHEN BdmRecType = 'EMP' THEN 'DTP' END
        ,drvDTP01_DateTimeQualifier2 = CASE WHEN BdmRecType = 'EMP' THEN '336' END
        ,drvDTP02_DateTimeFormatQual2 = CASE WHEN BdmRecType = 'EMP' THEN 'D8' END
        ,drvDTP03_DateTimePeriod2 = CASE WHEN BdmRecType = 'EMP' THEN CONVERT(VARCHAR(8),EecDateOfLastHire,112) END
        -- If drvDTP00_DateTime3 is Populated, then send DTP Segment
        ,drvDTP00_DateTime3 = 'DTP'
        ,drvDTP01_DateTimeQualifier3 = '356'
        ,drvDTP02_DateTimeFormatQual3 = 'D8'
        ,drvDTP03_DateTimePeriod3 = CONVERT(VARCHAR(8),BdmBenStartDate,112)
        --=====================
        -- LOOP 2100A RECORDS
        --=====================
        ,drvNM103_NameLast1 = dbo.dsi_fnRemoveChars('.,/-',
                              CASE WHEN BdmRecType = 'EMP' THEN EepNameLast
                                   WHEN BdmRecType = 'DEP' THEN ConNameLast
                              END)
        ,drvNM104_NameFirst1 = dbo.dsi_fnRemoveChars('.,/-',
                               CASE WHEN BdmRecType = 'EMP' THEN EepNameFirst
                                    WHEN BdmRecType = 'DEP' THEN ConNameFirst
                               END)
        ,drvNM105_NameMiddleInitial1 = dbo.dsi_fnRemoveChars('.,/-',
                                       CASE WHEN BdmRecType = 'EMP' THEN LEFT(EepNameMiddle,1)
                                            WHEN BdmRecType = 'DEP' THEN LEFT(ConNameMiddle,1)
                                       END)
        ,drvNM106_NamePrefix1 = ''--CASE WHEN BdmRecType = 'EMP' THEN EepNamePrefix END
        ,drvNM107_NameSuffix1 = ''/* CASE WHEN BdmRecType = 'EMP' THEN EepNameSuffix
                                     WHEN BdmRecType = 'DEP' THEN ConNameSuffix
                                END */
        ,drvNM108_IDCodeQualifier1 = CASE WHEN BdmRecType = 'EMP' AND ISNULL(EepSSN, '') <> '' THEN '34'
                                          WHEN BdmRecType = 'DEP' AND ISNULL(ConSSN, '') <> '' THEN '34'
									 END
        ,drvNM109_IDCode1 = CASE WHEN BdmRecType = 'EMP' AND ISNULL(EepSSN, '') <> '' THEN EepSSN
                                 WHEN BdmRecType = 'DEP' AND ISNULL(ConSSN, '') <> '' THEN ConSSN
                            END
        ,drvPER02_Name = ''
        ,drvPER03_CommNumberQualifier = CASE WHEN BdmRecType = 'EMP' AND ISNULL(RTRIM(EepPhoneHomeNumber),'') <> '' THEN 'HP' END
        ,drvPER04_CommunicationNumber = CASE WHEN BdmRecType = 'EMP' THEN ISNULL(EepPhoneHomeNumber,'') END
        ,drvPER05_CommNumberQualifier = CASE WHEN BdmRecType = 'EMP' AND ISNULL(RTRIM(EecPhoneBusinessNumber),'') <> '' THEN 'WP' END
        ,drvPER06_CommunicationNumber = CASE WHEN BdmRecType = 'EMP' THEN ISNULL(EecPhoneBusinessNumber,'') END
        ,drvPER07_CommNumberQualifier = CASE WHEN BdmRecType = 'EMP' AND ISNULL(RTRIM(eepAddressEMail),'') <> '' THEN 'EM' END
        ,drvPER08_CommunicationNumber = CASE WHEN BdmRecType = 'EMP' THEN ISNULL(eepAddressEMail,'') END
        ,drvN301_AddressLine1 = CASE WHEN BdmRecType = 'EMP' THEN dbo.dsi_fnRemoveChars('.,/-',EepAddressLine1) END
        ,drvN302_AddressLine2 = CASE WHEN BdmRecType = 'EMP' THEN dbo.dsi_fnRemoveChars('.,/-',EepAddressLine2) END
        ,drvN401_City = CASE WHEN BdmRecType = 'EMP' THEN dbo.dsi_fnRemoveChars('.,/-',EepAddressCity) END
        ,drvN402_State = CASE WHEN BdmRecType = 'EMP' THEN EepAddressState END
        ,drvN403_Zip = CASE WHEN BdmRecType = 'EMP' THEN EepAddressZipCode END
        ,drvN404_CountryCode = CASE WHEN BdmRecType = 'EMP' THEN CASE WHEN EepAddressCountry NOT IN ('US','USA') THEN EepAddressCountry END END
        ,drvDMG02_DateTimePeriod1 = CASE WHEN BdmRecType = 'EMP' THEN CONVERT(VARCHAR(8),EepDateOfBirth,112)
                                         WHEN BdmRecType = 'DEP' THEN CONVERT(VARCHAR(8),ConDateOfBirth,112)
                                    END
        ,drvDMG03_GenderCode1 = CASE WHEN BdmRecType = 'EMP' THEN CASE WHEN EepGender IN ('M','F') THEN EepGender ELSE 'U' END
                                     WHEN BdmRecType = 'DEP' THEN CASE WHEN ConGender IN ('M','F') THEN ConGender ELSE 'U' END
                                END
        ,drvDMG04_MaritalStatusCode1 = CASE WHEN BdmRecType = 'EMP' THEN
                                                CASE EepMaritalStatus WHEN 'M' THEN 'M' ELSE 'S' END
                                       END
        --If drvICM01_FrequencyCode is Populated, then send ICM Segment
        ,drvICM01_FrequencyCode = ''--CASE WHEN BdmRecType = 'EMP' THEN '' END --'7'
        ,drvICM02_MonetaryAmount = ''--CASE WHEN BdmRecType = 'EMP' THEN CONVERT(MONEY,EecAnnSalary) END
        ,drvICM03_Quantity = ''--CASE WHEN BdmRecType = 'EMP' THEN CONVERT(MONEY,EecScheduledWorkHrs) END
        ,drvICM04_LocationID = '' /* CASE WHEN BdmRecType = 'EMP' THEN
                                        CASE WHEN YEAR(EecDateOfLastHire) = YEAR(GETDATE()) THEN CONVERT(VARCHAR(8),EecDateOfLastHire,112)
                                            ELSE CONVERT(CHAR(4),YEAR(GETDATE())) + '0101'
                                        END
                               END */
        -- If drvAMT00_AmountQualifierCode1 = 'AMT' is Populated, then Send AMT Segment
        ,drvAMT00_SegmentID1 = ''
        ,drvAMT01_AmountQualifierCode1 = ''
        ,drvAMT02_MonetaryAmount1 = ''
        -- If drvAMT00_AmountQualifierCode2 = 'AMT' is Populated, then Send AMT Segment
        ,drvAMT00_SegmentID2 = ''
        ,drvAMT01_AmountQualifierCode2 = ''
        ,drvAMT02_MonetaryAmount2 = ''
        -- If drvHLH00_SegmentID = 'HLH' is Populated, then Send HLH Segment
        ,drvHLH00_SegmentID = ''
        ,drvHLH01_HealthRelatedCode = '' /* CASE WHEN BdmRecType = 'EMP' THEN
                                                CASE EepIsSmoker
                                                     WHEN 'Y' THEN 'T' --Tobacco Use
                                                     ELSE 'N' --None
                                                END
                                           WHEN BdmRecType = 'DEP' THEN
                                                CASE ConIsSmoker
                                                     WHEN 'Y' THEN 'T' --Tobacco Use
                                                     ELSE 'N' --None
                                                END
                                      END */
        ,drvHLH02_Height = ''
        ,drvHLH03_Weight1 = ''
        ,drvHLH04_Weight2 = ''
        ,drvHLH05_Description1 = ''
        ,drvHLH06_CurrentHealthConditionCode = ''
        ,drvHLH07_Description2 = ''
        ---------------------------------
        ,drvEEID = xEEID
        ,drvCOID = xCOID
        ,drvDepRecID = ConSystemID
        ,drvSSN = EepSSN
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = CONVERT(CHAR(9),RTRIM(EepSSN)) + CONVERT(CHAR(12),ISNULL(ConSystemID,''))
    INTO dbo.U_ECIGNA834_DrvTbl
    FROM dbo.U_ECIGNA834_EELIST WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    JOIN dbo.U_dsi_bdm_ECIGNA834 WITH (NOLOCK)
        ON BdmEEID = xEEID
        AND BdmCOID = xCOID
    LEFT JOIN dbo.TrmReasn WITH (NOLOCK)
        ON TchCode = EecTermReason
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
	JOIN dbo.PayGroup WITH (NOLOCK)
		ON PgrPayGroup= EecPayGroup
	WHERE LTRIM(RTRIM(ConSSN)) <> '000000000'
		AND LTRIM(RTRIM(ConSSN)) <> '111111111'
		AND LTRIM(RTRIM(ConSSN)) <> '888888888'
		AND LEFT(LTRIM(ConSSN),3) <> '999'
		AND LEFT(LTRIM(ConSSN),3) <> '998'
		AND LTRIM(RTRIM(ConSSN)) <> '123456789'
		OR ConSSN IS NULL
		;

    /**************************************************************************************************************
        DETAIL RECORDS
            -- LOOP 2300 RECORDS - HD, DTP, AMT Segments
            -- Loop 2700 RECORDS - LX Segments
            -- Loop 2750 RECORDS - N1, REF Segments
    ***************************************************************************************************************/

    -------------------
    -- DETAIL RECORD 
    -------------------
    IF OBJECT_ID('U_ECIGNA834_DrvTbl_2300','U') IS NOT NULL
        DROP TABLE dbo.U_ECIGNA834_DrvTbl_2300;
    SELECT DISTINCT
        -- If drvHD00_HealthCoverage Populated, then send HD Segment
        drvHD00_HealthCoverage = CASE WHEN BdmDedType IN ('MED') THEN 'HD'
                                        WHEN BdmDedType IN ('DEN') THEN 'HD'
                                        WHEN BdmDedType IN ('VIS') THEN 'HD'
                                 END
        ,drvHD01_MaintTypeCode = '030' --Audit or Compare
        ,drvHD02_MaintReasonCode = CASE WHEN BdmDedType IN ('MED') THEN ''
                                           WHEN BdmDedType IN ('DEN') THEN ''
                                           WHEN BdmDedType IN ('VIS') THEN ''
                                     END
        ,drvHD03_InsuranceLineCode = CASE WHEN BdmDedType IN ('MED') THEN 'HLT'
                                           WHEN BdmDedType IN ('DEN') THEN 'DEN'
                                           WHEN BdmDedType IN ('VIS') THEN 'VIS'
                                     END
        ,drvHD04_PlanCoverageDesc = CASE WHEN BdmDedCode IN ('MBMO', 'MBOH', 'MBOHO', 'MBVA') THEN 'MHDP0038'
                                           WHEN BdmDedCode IN ('MHSMO', 'MHSO', 'MHSOH', 'MHSVA') THEN 'MHDP0071'
                                           WHEN BdmDedCode IN ('MBUMO', 'MBUO', 'MBUOH', 'MBUVA') THEN 'MOAP0041'
                                     END
        ,drvHD05_CoverageLevelCode = CASE WHEN BdmRecType = 'EMP' THEN
                                                CASE WHEN BdmBenOption IN ('EE', 'EET', 'EEBU', 'EEW') THEN 'EMP'
                                                     WHEN BdmBenOption IN ('EES', 'EESBU', 'EEST', 'EESW') THEN 'ESP'
                                                     WHEN BdmBenOption IN ('EEC', 'EECT', 'EECBU', 'EECW') THEN 'ECH'
                                                     WHEN BdmBenOption IN ('EEF', 'EEFBU', 'EEFT', 'EECW', 'EEFW') THEN 'FAM'
                                                END
                                     END
        -- If drvDTP00_DateTime_348 Populated, then send DTP*348 Segment
        ,drvDTP00_DateTime_348 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN 'DTP' END
        ,drvDTP01_DateTimeQualifier_348 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '348' END
        ,drvDTP02_DateTimeFormatQual_348 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN 'D8' END
        ,drvDTP03_DateTimePeriod_348 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN CONVERT(VARCHAR(8),dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate),112) END
        -- If drvDTP00_DateTime_349 Populated, then send DTP*349 Segment
        ,drvDTP00_DateTime_349 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') AND BdmBenStopDate IS NOT NULL THEN 'DTP' END
        ,drvDTP01_DateTimeQualifier_349 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') AND BdmBenStopDate IS NOT NULL THEN '349' END
        ,drvDTP02_DateTimeFormatQual_349 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') AND BdmBenStopDate IS NOT NULL THEN 'D8' END
        ,drvDTP03_DateTimePeriod_349 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN CONVERT(VARCHAR(8),BdmBenStopDate,112) END
        -- If drvDTP00_DateTime_303 = 'DTP', then Send DTP*303 Segment
        ,drvDTP00_DateTime_303 = CASE WHEN BdmDedType IN ('MED') THEN '' END
        ,drvDTP01_DateTimeQualifier_303 = CASE WHEN BdmDedType IN ('MED') THEN '303' END
        ,drvDTP02_DateTimeFormatQual_303 = CASE WHEN BdmDedType IN ('MED') THEN 'D8' END
        ,drvDTP03_DateTimePeriod_303 = CASE WHEN BdmDedType IN ('MED') THEN '' END --dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStatusDate, @FileMinCovDate)
        -- If drvREF00_RefNumberQual1 is Populated, then send REF Segment
        ,drvREF00_RefNumberQual1 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        ,drvREF01_RefNumberQual1 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        ,drvREF02_RefNumberQual1 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        -- If drvREF01_RefNumberQual2 is Populated, then send REF Segment
        ,drvREF00_RefNumberQual2 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        ,drvREF01_RefNumberQual2 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        ,drvREF02_RefNumberQual2 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        -- If drvAMT00_AmountQualifierCode1 is Populated, then Send AMT Segment
        ,drvAMT00_AmountQualifierCode1 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        ,drvAMT01_AmountQualifierCode1 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        ,drvAMT02_MonetaryAmount1 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        -- If drvAMT00_AmountQualifierCode2 is Populated, then Send AMT Segment
        ,drvAMT00_AmountQualifierCode2 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        ,drvAMT01_AmountQualifierCode2 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        ,drvAMT02_MonetaryAmount2 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        --=====================
        -- Loop 2700 RECORDS
        --=====================
        -- If drvLS01_LoopIDCode is Populated, then send LS Segment
        ,drvLS01_LoopIDCode = '' 
        -- If drvLX01_AssignedNumber is Populated, then send LX Segment
        ,drvLX01_AssignedNumber = ''
        --=====================
        -- Loop 2750 RECORDS
        --=====================
        -- If drvN101_EntityIDCodeSponsor is Populated, then send N1 Segment
        ,drvN101_EntityIDCodeSponsor = ''
        ,drvN102_Name = ''
        -- If drvREF01_RefNumberQual is Populated, then send REF Segment
        ,drvREF01_RefNumberQual = ''
        ,drvREF02_RefNumberDesc = CASE BdmDedType
                                       WHEN 'MED' THEN ''
                                       WHEN 'DEN' THEN ''
                                       WHEN 'VIS' THEN ''
                                  END
        -- If drvLE01_LoopIDCode is Populated, then send LE Segment
        ,drvLE01_LoopIDCode = ''
        ---------------------------------
        ,drvEEID = xEEID
        ,drvCOID = xCOID
        ,drvDepRecID = ConSystemID
        ,drvSSN = EepSSN
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = CONVERT(CHAR(9),RTRIM(EepSSN)) + CONVERT(CHAR(12),ISNULL(ConSystemID,''))
                      + CASE BdmDedType
                             WHEN 'MED' THEN '1'
                             WHEN 'DEN' THEN '2'
                             WHEN 'VIS' THEN '3'
                             ELSE '9'
                      END
    INTO dbo.U_ECIGNA834_DrvTbl_2300
    FROM dbo.U_ECIGNA834_EELIST WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.U_dsi_bdm_ECIGNA834 WITH (NOLOCK)
        ON BdmEEID = xEEID
        AND BdmCOID = xCOID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
	JOIN dbo.PayGroup WITH (NOLOCK)
		ON PgrPayGroup= EecPayGroup
	WHERE LTRIM(RTRIM(ConSSN)) <> '000000000'
		AND LTRIM(RTRIM(ConSSN)) <> '111111111'
		AND LTRIM(RTRIM(ConSSN)) <> '888888888'
		AND LEFT(LTRIM(ConSSN),3) <> '999'
		AND LEFT(LTRIM(ConSSN),3) <> '998'
		AND LTRIM(RTRIM(ConSSN)) <> '123456789'
		OR ConSSN IS NULL
		;

    /**************************************************************************************************
        TRAILER RECORDS
            - SE, GE, IEA Segments
    **************************************************************************************************/
    ---------------------
    -- TRAILER RECORD
    --------------------
    IF OBJECT_ID('U_ECIGNA834_TrlTbl') IS NOT NULL
        DROP TABLE dbo.U_ECIGNA834_TrlTbl;
    SELECT DISTINCT drvSE01_SegmentCount = '9999'
    INTO dbo.U_ECIGNA834_TrlTbl;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable('ECIGNA834','UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = 'MARBA_ECIGNA834_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
        WHERE FormatCode = 'ECIGNA834';
    END;

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwECIGNA834_Export AS
    SELECT TOP 20000000 DATA FROM dbo.U_ECIGNA834_File (NOLOCK)
    ORDER BY CASE LEFT(Recordset,1) WHEN 'H' THEN 1 WHEN 'D' THEN 2 ELSE 3 END, InitialSort, SubSort, RIGHT(Recordset,2)
GO

--Check out AscDefh
SELECT * FROM dbo.AscDefh
WHERE adhformatcode = 'ECIGNA834'

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ECIGNA834%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET ExpLastStartPerControl = '202005011'
       ,ExpStartPerControl     = '202005011'
       ,ExpLastEndPerControl   = '202005079'
       ,ExpEndPerControl       = '202005079'
WHERE ExpFormatCode = 'ECIGNA834';

**********************************************************************************/
