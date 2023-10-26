USE [ULTIPRO_WPBIOTC]
GO
/****** Object:  StoredProcedure [dbo].[dsi_sp_BuildDriverTables_EMILTEN834]    Script Date: 10/26/2023 2:32:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMILTEN834]
    @systemid CHAR(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client: Miltenyi

Created By: Spencer Kerch
Business Analyst: Dawn Ross
Create Date: 10/13/2023
Service Request Number: TekP-2023-08-29-06

Purpose: Miltenyi Cigna Dental 834

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/20XX     SR-20XX-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EMILTEN834';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EMILTEN834';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EMILTEN834';
SELECT * FROM dbo.AscExp WHERE expFormatCode = 'EMILTEN834';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EMILTEN834' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMILTEN834', 'ONDM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMILTEN834', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMILTEN834', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMILTEN834', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMILTEN834', 'SCH_EMILTE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EMILTEN834';

EXEC dbo._dsi_usp_ExportRipOut_V7_4 @FormatCode = 'EMILTEN834', @AllObjects = 'Y', @IsWeb = 'Y';
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
        ,@FileMinCovDate  = ''
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = 'EMILTEN834';

    --==========================================
    -- Deduction Code List
    --==========================================
    DECLARE @DedList VARCHAR(MAX);
    SET @DedList = 'DEN';

    IF OBJECT_ID('U_EMILTEN834_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EMILTEN834_DedList;
    SELECT DedCode = DedDedCode
        ,DedLongDesc
        ,DedType = DedDedType
    INTO dbo.U_EMILTEN834_DedList
    FROM dbo.dsi_BDM_fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

    --==========================================
    -- Clean EE List
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EMILTEN834_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCoID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EMILTEN834_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    IF @ExportCode LIKE 'OE%'
    BEGIN
        -- Remove Employees that Do Not Have a Benefit Plan in Deduction Code List
        DELETE FROM dbo.U_EMILTEN834_EEList
        WHERE NOT EXISTS (SELECT 1 FROM dbo.EmpDed JOIN dbo.U_EMILTEN834_DedList ON DedCode = EedDeDCode WHERE EedEEID = xEEID);
    END;

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
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL,DC,DPC,GAR,GRC,STC');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP');

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
    FROM dbo.U_dsi_bdm_EMILTEN834 D
    JOIN dbo.U_dsi_bdm_EMILTEN834 E
        ON E.BdmEEID = D.BdmEEID
        AND E.BdmCOID = D.BdmCOID
        AND E.BdmDedCode = D.BdmDedCode
    WHERE D.BdmRecType = 'DEP' AND E.BdmRecType = 'EMP';

    --=====================================================
    -- Update BdmUSGField2 with EmpDedTVID for Employees
    --=====================================================
    UPDATE dbo.U_dsi_bdm_EMILTEN834
        SET BdmUSGField2 = EedEmpDedTVID
    FROM dbo.U_dsi_bdm_EMILTEN834
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = BdmEEID
        AND EedCOID = BdmCOID
        AND EedDedCode = BdmDedCode
    WHERE BdmRecType = 'EMP' AND EedFormatCode = @FormatCode AND EedValidForExport = 'Y';

    --=======================================================
    -- Update BdmUSGField2 with DepBPlanTVID for Dependents
    --=======================================================
    UPDATE dbo.U_dsi_bdm_EMILTEN834
        SET BdmUSGField2 = DbnDepBPlanTVID
    FROM dbo.U_dsi_bdm_EMILTEN834
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
        ON DbnEEID = BdmEEID
        AND DbnCOID = BdmCOID
        AND DbnDedCode = BdmDedCode
    WHERE BdmRecType = 'DEP' AND DbnFormatCode = @FormatCode AND DbnValidForExport = 'Y';

    --======================================================
    -- Update BdmUSGField1 with Benefit Amount (EedBenAmt)
    --======================================================
    UPDATE dbo.U_dsi_bdm_EMILTEN834
        SET BdmUSGField1 = CONVERT(VARCHAR(20),EedBenAmt)
    FROM dbo.U_dsi_bdm_EMILTEN834
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
    IF OBJECT_ID('U_EMILTEN834_HdrTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EMILTEN834_HdrTbl;
    SELECT DISTINCT drvISA05_SenderIDQual = '30'
        ,drvISA06_SenderID = '680277164'
        ,drvISA07_ReceiverIDQual = '30'
        ,drvISA08_ReceiverID = '06-0303370'
        ,drvISA09_InterchangeDate = RIGHT(@RunDate,6)
        ,drvISA10_InterchangeTime = @RunTime
        ,drvISA15_UsageIndicator = CASE WHEN @ExportCode LIKE '%TEST%' THEN 'T' ELSE 'P' END
        ,drvISA16_ComponentSeprator = ':'
        ,drvGS02_SenderID = '680277164'
        ,drvGS03_ReceiverID = '06-0303370'
        ,drvGS04_Date = @RunDate
        ,drvGS05_Time = @RunTime
        ,drvBGN03_Date = @RunDate
        ,drvBGN04_Time = @RunTime
        ,drvBGN05_TimeCode = ''
        ,drvBGN06_RefID = ''
        ,drvBGN07_TransTypeCode = ''
        ,drvBGN08_ActionCode = 'RX'
        ,drvREF01_RefNumberQual = '38'
        ,drvREF02_RefNumberQual = '0636891'
        ,drvDTP00_DateTime0 = ''
        ,drvDTP01_DateTimeQualifier0 = ''
        ,drvDTP02_DateTimeFormatQual0 = ''
        ,drvDTP03_DateTimePeriod0 = ''
        ,drvDTP00_DateTime1 = ''
        ,drvDTP01_DateTimeQualifier1 = ''
        ,drvDTP02_DateTimeFormatQual1 = ''
        ,drvDTP03_DateTimePeriod1 = ''
        ,drvQTY01_QuantityQual1 = ''
        ,drvQTY02_Quantity1 = ''
        ,drvQTY01_QuantityQual2 = ''
        ,drvQTY02_Quantity2 = ''
        ,drvQTY01_QuantityQual3 = ''
        ,drvQTY02_Quantity3 = ''
        ,drvN101_EntityIDCodeSponsor1 = 'P5'
        ,drvN102_Name1 = 'Miltenyi Biotec North America'
        ,drvN103_IDCodeQual1 = 'FI'
        ,drvN104_IDCode1 = '680277164'
        ,drvN101_EntityIDCodeSponsor2 = 'IN'
        ,drvN102_Name2 = 'CIGNA'
        ,drvN103_IDCodeQual2 = 'FI'
        ,drvN104_IDCode2 = '06-0303370'
    INTO dbo.U_EMILTEN834_HdrTbl
    FROM dbo.U_EMILTEN834_EELIST WITH (NOLOCK)
    JOIN dbo.U_dsi_bdm_EMILTEN834 WITH (NOLOCK)
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
    IF OBJECT_ID('U_EMILTEN834_DrvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EMILTEN834_DrvTbl;
    SELECT DISTINCT
        --=====================
        --LOOP 2000 RECORDS
        --=====================
        drvINS01_YesNoCond = CASE BdmRecType
                                 WHEN 'EMP' THEN 'Y'
                                 ELSE 'N'
                             END
        ,drvINS02_RelationshipCode =    CASE WHEN BdmRecType = 'EMP' THEN '18'
                                        ELSE
                                            CASE WHEN ConRelationship IN (SELECT * FROM dbo.dsi_BDM_fn_ListToTable('SPS')) THEN '01'
                                            WHEN ConRelationship IN (SELECT * FROM dbo.dsi_BDM_fn_ListToTable('DP')) THEN '01'
                                            WHEN ConRelationship IN (SELECT * FROM dbo.dsi_BDM_fn_ListToTable('CHL,DC,DPC,GAR,GRC,STC')) THEN '19'
                                            ELSE '19'
                                            END
                                        END
        ,drvINS03_MaintTypeCode = '030' --Audit or Compare
        ,drvINS04_MaintReasonCode = 'XN' --Notification Only
        ,drvINS05_BenefitStatusCode = 'A'
        ,drvINS0601_MEDICAREPLANCODE = 'E'
        ,drvINS0602_EligibilityRsnCode = ''
        ,drvINS07_COBRAQualEventCode = ''
        ,drvINS08_EmploymentStatusCode = 'AC'
                                            --CASE WHEN BdmRecType = 'EMP' THEN
                                              --  CASE WHEN EecEmplStatus = 'A' THEN 'AC' --ACTIVE
                                                --     WHEN EecFullTimeOrPartTime = 'F' THEN 'FT' --Full time active employee
                                                      --RETIREE?????
                                                --END
                                         --END
        ,drvINS09_StudentStatusCode = 'F'
                                    --     CASE WHEN BdmRecType = 'DEP' THEN
                                    --             CASE WHEN ConIsStudent = 'Y' THEN 'F' ELSE 'N' END --Full-time
                                    --   END
        ,drvINS10_ResponseCode =  CASE WHEN BdmRecType = 'DEP' THEN 
                                        CASE WHEN ConIsDisabled = 'Y' THEN 'Y'
                                             ELSE 'N'
                                        END
                                END
        ,drvINS11_DateTimeFormatQual = CASE WHEN ISNULL(EepDateDeceased, '') <> '' THEN 'D8' END
        ,drvINS12_DateTimePeriod = CASE WHEN ISNULL(EepDateDeceased, '') <> '' THEN CONVERT(VARCHAR(8),EepDateDeceased,112) END
        -- If drvREF01_RefNumberQual1 is Populated, then send REF Segment
        ,drvREF01_RefNumberQual1 = ''
        ,drvREF02_RefNumberQual1 = EepSSN
        -- If drvREF01_RefNumberQual2 is Populated, then send REF Segment
        ,drvREF01_RefNumberQual2 = ''
        ,drvREF02_RefNumberQual2 = ''
        -- If drvREF01_RefNumberQual3 is Populated, then send REF Segment
        ,drvREF01_RefNumberQual3 = ''
        ,drvREF02_RefNumberQual3 = ''
        -- If drvREF01_RefNumberQual3 is Populated, then send REF Segment
        ,drvREF01_RefNumberQual4 = ''
        ,drvREF02_RefNumberQual4 = ''
        -- If drvDTP00_DateTime1 is Populated, then send DTP Segment
         ,drvDTP00_DateTime1 = 'DTP'
        ,drvDTP01_DateTimeQualifier1 = '336'
        ,drvDTP02_DateTimeFormatQual1 = 'D8'
        ,drvDTP03_DateTimePeriod1 = eecdateoflasthire
        -- If drvDTP00_DateTime2 is Populated, then send DTP Segment
        ,drvDTP00_DateTime2 = CASE WHEN BdmBenStopdate is not null then 'DTP' END
        ,drvDTP01_DateTimeQualifier2 = CASE WHEN BdmBenStopdate is not null then '357' END
        ,drvDTP02_DateTimeFormatQual2 =CASE WHEN BdmBenStopdate is not null then 'D8' END
        ,drvDTP03_DateTimePeriod2 =  BdmBenStopdate
        -- If drvDTP00_DateTime3 is Populated, then send DTP Segment
        ,drvDTP00_DateTime3 = ''
        ,drvDTP01_DateTimeQualifier3 = '337'
        ,drvDTP02_DateTimeFormatQual3 = 'D8'
        ,drvDTP03_DateTimePeriod3 = EecDateOfTermination
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
        ,drvNM106_NamePrefix1 =''
        ,drvNM107_NameSuffix1 = ''
        ,drvNM108_IDCodeQualifier1 =    CASE WHEN BdmRecType = 'EMP' AND ISNULL(EepSSN, '') <> '' THEN '34'
                                            WHEN BdmRecType = 'DEP' AND NOT (ConSSN IN ('000000000','999999999', '111111111','888888888', '123456789') OR RIGHT(ConSSN, 3) IN ('111','000','999','998')) THEN '34'
                                        END        
        ,drvNM109_IDCode1 = CASE WHEN BdmRecType = 'EMP' AND ISNULL(EepSSN, '') <> '' THEN EepSSN
                                WHEN BdmRecType = 'DEP' AND NOT (ConSSN IN ('000000000','999999999', '111111111','888888888', '123456789') OR RIGHT(ConSSN, 3) IN ('111','000','999','998')) THEN ConSSN
                            END
        ,drvPER02_Name = ''
        ,drvPER03_CommNumberQualifier = CASE WHEN BdmRecType = 'EMP' AND ISNULL(EepPhoneHomeNumber, '') <> '' THEN 'HP'
                                           
                                        END
        ,drvPER04_CommunicationNumber = CASE WHEN BdmRecType = 'EMP' AND ISNULL(EepPhoneHomeNumber, '') <> '' THEN EepPhoneHomeNumber
                                           
                                        END
        ,drvPER05_CommNumberQualifier =    CASE WHEN BdmRecType = 'EMP' AND ISNULL(EepPhoneHomeNumber, '') <> '' AND ISNULL(eepAddressEMail, '') <> '' THEN 'EM' END
        ,drvPER06_CommunicationNumber = CASE WHEN BdmRecType = 'EMP' AND ISNULL(EepPhoneHomeNumber, '') <> '' AND ISNULL(eepAddressEMail, '') <> '' THEN eepAddressEMail END
        ,drvPER07_CommNumberQualifier = '' 
        ,drvPER08_CommunicationNumber = '' 
        ,drvN301_AddressLine1 = dbo.dsi_fnRemoveChars('.,/-',EepAddressLine1)
        ,drvN302_AddressLine2 = dbo.dsi_fnRemoveChars('.,/-',EepAddressLine2)
        ,drvN401_City = dbo.dsi_fnRemoveChars('.,/-',EepAddressCity)
        ,drvN402_State = EepAddressState
        ,drvN403_Zip = EepAddressZipCode
        ,drvN404_CountryCode = CASE WHEN EepAddressCountry NOT IN ('US','USA') THEN EepAddressCountry END
        ,drvDMG02_DateTimePeriod1 = CASE WHEN BdmRecType = 'EMP' THEN CONVERT(VARCHAR(8),EepDateOfBirth,112)
                                         WHEN BdmRecType = 'DEP' THEN CONVERT(VARCHAR(8),ConDateOfBirth,112)
                                    END
        ,drvDMG03_GenderCode1 = CASE WHEN BdmRecType = 'EMP' AND EepGender IN ('M','F') THEN EepGender
                                     WHEN BdmRecType = 'DEP'  AND EepGender IN ('M','F') THEN ConGender
                                     ELSE 'U'
                                END
        ,drvDMG04_MaritalStatusCode1 = CASE WHEN EepMaritalStatus IN ('S','M') THEN EepMaritalStatus
                                        ELSE ''
                                        END
        --If drvICM01_FrequencyCode is Populated, then send ICM Segment
        ,drvICM01_FrequencyCode = ''
        ,drvICM02_MonetaryAmount =''
        ,drvICM03_Quantity = ''
        ,drvICM04_LocationID = ''
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
        ,drvHLH01_HealthRelatedCode =''
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
    INTO dbo.U_EMILTEN834_DrvTbl
    FROM dbo.U_EMILTEN834_EELIST WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    JOIN dbo.U_dsi_bdm_EMILTEN834 WITH (NOLOCK)
        ON BdmEEID = xEEID
        AND BdmCOID = xCOID
    LEFT JOIN dbo.TrmReasn WITH (NOLOCK)
        ON TchCode = EecTermReason
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID;

    /**************************************************************************************************************
        DETAIL RECORDS
            -- LOOP 2300 RECORDS - HD, DTP, AMT Segments
            -- Loop 2700 RECORDS - LX Segments
            -- Loop 2750 RECORDS - N1, REF Segments
    ***************************************************************************************************************/

    -------------------
    -- DETAIL RECORD 
    -------------------
    IF OBJECT_ID('U_EMILTEN834_DrvTbl_2300','U') IS NOT NULL
        DROP TABLE dbo.U_EMILTEN834_DrvTbl_2300;
    SELECT DISTINCT
        -- If drvHD00_HealthCoverage Populated, then send HD Segment
        drvHD00_HealthCoverage = 'HD'
        ,drvHD01_MaintTypeCode = '030' --Audit or Compare
        ,drvHD02_MaintReasonCode = ''
        ,drvHD03_InsuranceLineCode = CASE --WHEN BdmDedType IN ('MED') THEN 'HLT'
                                           WHEN BdmDedType IN ('DEN') THEN 'DEN'
                                           --WHEN BdmDedType IN ('VIS') THEN 'VIS'
                                           --ELSE '' ---good? or just den
                                     END
        ,drvHD04_PlanCoverageDesc = ''
        ,drvHD05_CoverageLevelCode = CASE WHEN BdmBenOption = 'EE' THEN 'EMP'
                                     WHEN BdmBenOption  In ('EC1DC1', 'EC1DC2', 'EC2DC1', 'EC2DC2', 'ECH2DP', 'ECHDP', 'EDPDC1', 'EDPDC2', 'EEF') THEN 'FAM'
                                     WHEN BdmBenOption in ('EC2D2','EDPCH','EDPCH2', 'EEC') THEN 'ECH'
                                     WHEN BdmBenOption in ('EEDP','EEDPF','EES') THEN 'ESP'
                                     end
                                     
        -- If drvDTP00_DateTime_348 Populated, then send DTP*348 Segment
        ,drvDTP00_DateTime_348 = 'DTP'
        ,drvDTP01_DateTimeQualifier_348 = '348'
        ,drvDTP02_DateTimeFormatQual_348 = 'D8'
        ,drvDTP03_DateTimePeriod_348 = dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate) 
        -- If drvDTP00_DateTime_349 Populated, then send DTP*349 Segment
        ,drvDTP00_DateTime_349 = CASE WHEN BdmBenStopDate IS NOT NULL THEN 'DTP' END
        ,drvDTP01_DateTimeQualifier_349 = CASE WHEN BdmBenStopDate IS NOT NULL THEN '349' END
        ,drvDTP02_DateTimeFormatQual_349 = CASE WHEN BdmBenStopDate IS NOT NULL THEN 'D8' END
        ,drvDTP03_DateTimePeriod_349 = BdmBenStopDate 
        -- If drvDTP00_DateTime_303 = 'DTP', then Send DTP*303 Segment
        ,drvDTP00_DateTime_303 = ''
        ,drvDTP01_DateTimeQualifier_303 = ''
        ,drvDTP02_DateTimeFormatQual_303 = ''
        ,drvDTP03_DateTimePeriod_303 = ''
        -- If drvREF00_RefNumberQual1 is Populated, then send REF Segment
        ,drvREF00_RefNumberQual1 = 'REF'--'1L'
        ,drvREF01_RefNumberQual1 = '1L'
        ,drvREF02_RefNumberQual1 = CASE WHEN cmpcompanycode = 'MNA1' and eepAddressState = 'LA' THEN '0636891001DPP02'
                                            WHEN cmpcompanycode =  'MNA1' and EepAddressState = 'TX' THEN '0636891001DENT'
                                            WHEN cmpcompanycode =  'MNA1' and EepAddressState not in ('LA','TX') THEN '0636891001DPP01'
											--before 1/1
											WHEN cmpcompanycode =  'MUS1' and EepAddressState = 'LA' THEN '0636891002DPP02'
                                            WHEN cmpcompanycode =  'MUS1' and EepAddressState = 'TX' THEN '0636891002DENT'
                                            WHEN cmpcompanycode =  'MUS1' and EepAddressState not in ('LA','TX') THEN '0636891002DPP01'
											--after 1/1
                                            WHEN cmpcompanycode =  'OUS1' and EepAddressState = 'LA' THEN '0636891002DPP02'
                                            WHEN cmpcompanycode =  'OUS1' and EepAddressState = 'TX' THEN '0636891002DENT'
                                            WHEN cmpcompanycode =  'OUS1' and EepAddressState not in ('LA','TX') THEN '0636891002DPP01'

                                            WHEN cmpcompanycode =  'BUS1' and EepAddressState = 'LA' THEN '0636891003DPP02'
                                            WHEN cmpcompanycode =  'BUS1' and EepAddressState = 'TX' THEN '0636891003DENT'
                                            WHEN cmpcompanycode =  'BUS1' and EepAddressState not in ('LA','TX') THEN '0636891003DPP01'
                                            WHEN cmpcompanycode =  'LUS1' and EepAddressState = 'LA' THEN '0636891004DPP02'
                                            WHEN cmpcompanycode =  'LUS1' and EepAddressState = 'TX' THEN '0636891004DENT'
                                            WHEN cmpcompanycode =  'LUS1' and EepAddressState not in ('LA','TX') THEN '0636891004DPP01'
                                        END
        -- If drvREF01_RefNumberQual2 is Populated, then send REF Segment
        ,drvREF00_RefNumberQual2 = ''
        ,drvREF01_RefNumberQual2 = ''
        ,drvREF02_RefNumberQual2 = ''
        -- If drvAMT00_AmountQualifierCode1 is Populated, then Send AMT Segment
        ,drvAMT00_AmountQualifierCode1 = ''
        ,drvAMT01_AmountQualifierCode1 = ''
        ,drvAMT02_MonetaryAmount1 = ''
        -- If drvAMT00_AmountQualifierCode2 is Populated, then Send AMT Segment
        ,drvAMT00_AmountQualifierCode2 = ''
        ,drvAMT01_AmountQualifierCode2 = ''
        ,drvAMT02_MonetaryAmount2 = ''
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
    INTO dbo.U_EMILTEN834_DrvTbl_2300
    FROM dbo.U_EMILTEN834_EELIST WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.U_dsi_bdm_EMILTEN834 WITH (NOLOCK)
        ON BdmEEID = xEEID
        AND BdmCOID = xCOID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
    LEFT JOIN dbo.Company WITH (NoLock)
		on cmpcoid = xcoid

	;

    /**************************************************************************************************
        TRAILER RECORDS
            - SE, GE, IEA Segments
    **************************************************************************************************/
    ---------------------
    -- TRAILER RECORD
    --------------------
    IF OBJECT_ID('U_EMILTEN834_TrlTbl') IS NOT NULL
        DROP TABLE dbo.U_EMILTEN834_TrlTbl;
    SELECT DISTINCT drvSE01_SegmentCount = '9999'  -- ??????? + ge? + iae?
    INTO dbo.U_EMILTEN834_TrlTbl;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable('EMILTEN834','UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = 'MIL1021_EMILTEN834_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
        WHERE FormatCode = 'EMILTEN834';
    END;

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEMILTEN834_Export AS
    SELECT TOP 20000000 DATA FROM dbo.U_EMILTEN834_File (NOLOCK)
    ORDER BY CASE LEFT(Recordset,1) WHEN 'H' THEN 1 WHEN 'D' THEN 2 ELSE 3 END, InitialSort, SubSort, RIGHT(Recordset,2)
GO

--Check out iAscDefF
SELECT * FROM dbo.iAscDefF
WHERE AdfHeaderSystemID LIKE 'EMILTEN834%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET ExpLastStartPerControl = '201810011'
       ,ExpStartPerControl     = '201810011'
       ,ExpLastEndPerControl   = '201810019'
       ,ExpEndPerControl       = '201810019'
WHERE ExpFormatCode = 'EMILTEN834';

**********************************************************************************/
