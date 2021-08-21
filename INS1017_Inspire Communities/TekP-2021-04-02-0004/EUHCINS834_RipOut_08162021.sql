USE [ULTIPRO_WPINSPR]
GO
/****** Object:  StoredProcedure [dbo].[dsi_sp_BuildDriverTables_EUHCINS834]    Script Date: 8/16/2021 2:36:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUHCINS834]
    @systemid CHAR(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client: Inspire Communities

Created By: Andy Pineda
Business Analyst: Lea King
Create Date: 07/02/2021
Service Request Number: TekP-2021-04-02-0004

Purpose: UHC Medical 834

Revision History
----------------
07/19/2021 by AP:
        - Updated join for OrgLevel table.

08/05/2021 by AP:
		- Added new HD04 values as per spec.

08/16/2021 by AP:
		- Updated HD04 mapping to use OrgLvl2 instead of 3. Removed any unused values left in.

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EUHCINS834';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EUHCINS834';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EUHCINS834';
SELECT * FROM dbo.AscExp WHERE expFormatCode = 'EUHCINS834';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EUHCINS834' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUHCINS834', 'FULLFILE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUHCINS834', 'CHANGES';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUHCINS834', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUHCINS834', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUHCINS834', 'SCH_UHC834';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EUHCINS834';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EUHCINS834', @AllObjects = 'Y', @IsWeb = 'Y';
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
        ,@FileMinCovDate  = CAST('03/01/2021' as DATETIME)
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = 'EUHCINS834';

    --==========================================
    -- Deduction Code List
    --==========================================
    DECLARE @DedList VARCHAR(MAX);
    SET @DedList = 'UHHSA,UHPPO';

    IF OBJECT_ID('U_EUHCINS834_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EUHCINS834_DedList;
    SELECT DedCode = DedDedCode
        ,DedLongDesc
        ,DedType = DedDedType
    INTO dbo.U_EUHCINS834_DedList
    FROM dbo.dsi_BDM_fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

    --==========================================
    -- Clean EE List
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EUHCINS834_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCoID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EUHCINS834_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    -- Remove Employees that Do Not Have a Benefit Plan in Deduction Code List
    DELETE FROM dbo.U_EUHCINS834_EEList
    WHERE NOT EXISTS (SELECT 1 FROM dbo.EmpDed JOIN dbo.U_EUHCINS834_DedList ON DedCode = EedDeDCode WHERE EedEEID = xEEID);

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
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL, DPC, STC');
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
    FROM dbo.U_dsi_bdm_EUHCINS834 D
    JOIN dbo.U_dsi_bdm_EUHCINS834 E
        ON E.BdmEEID = D.BdmEEID
        AND E.BdmCOID = D.BdmCOID
        AND E.BdmDedCode = D.BdmDedCode
    WHERE D.BdmRecType = 'DEP' AND E.BdmRecType = 'EMP';

    --=====================================================
    -- Update BdmUSGField2 with EmpDedTVID for Employees
    --=====================================================
    UPDATE dbo.U_dsi_bdm_EUHCINS834
        SET BdmUSGField2 = EedEmpDedTVID
    FROM dbo.U_dsi_bdm_EUHCINS834
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = BdmEEID
        AND EedCOID = BdmCOID
        AND EedDedCode = BdmDedCode
    WHERE BdmRecType = 'EMP' AND EedFormatCode = @FormatCode AND EedValidForExport = 'Y';

    --=======================================================
    -- Update BdmUSGField2 with DepBPlanTVID for Dependents
    --=======================================================
    UPDATE dbo.U_dsi_bdm_EUHCINS834
        SET BdmUSGField2 = DbnDepBPlanTVID
    FROM dbo.U_dsi_bdm_EUHCINS834
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
        ON DbnEEID = BdmEEID
        AND DbnCOID = BdmCOID
        AND DbnDedCode = BdmDedCode
    WHERE BdmRecType = 'DEP' AND DbnFormatCode = @FormatCode AND DbnValidForExport = 'Y';

    --======================================================
    -- Update BdmUSGField1 with Benefit Amount (EedBenAmt)
    --======================================================
    UPDATE dbo.U_dsi_bdm_EUHCINS834
        SET BdmUSGField1 = CONVERT(VARCHAR(20),EedBenAmt)
    FROM dbo.U_dsi_bdm_EUHCINS834
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
    IF OBJECT_ID('U_EUHCINS834_HdrTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EUHCINS834_HdrTbl;
    SELECT DISTINCT drvISA05_SenderIDQual = '30'
        ,drvISA06_SenderID = (SELECT CmmFedTaxId FROM dbo.CompMast WITH(NOLOCK))
        ,drvISA07_ReceiverIDQual = '30'
        ,drvISA08_ReceiverID = '411289245'
        ,drvISA09_InterchangeDate = RIGHT(@RunDate,6)
        ,drvISA10_InterchangeTime = @RunTime
        ,drvISA15_UsageIndicator = CASE dbo.dsi_fnVariable(@FormatCode,'Testing') WHEN 'Y' THEN 'T' ELSE 'P' END
        ,drvGS02_SenderID = (SELECT CmmFedTaxId FROM dbo.CompMast WITH(NOLOCK))
        ,drvGS03_ReceiverID = 'CES'
        ,drvGS04_Date = @RunDate
        ,drvGS05_Time = @RunTime
        ,drvBGN03_Date = @RunDate
        ,drvBGN04_Time = @RunTime
        ,drvBGN05_TimeCode = 'ET'
        ,drvBGN06_RefID = ''
        ,drvBGN07_TransTypeCode = ''
        ,drvBGN08_ActionCode = '4'
        ,drvREF01_RefNumberQual = '38'
        ,drvREF02_RefNumberQual = 'INSPIREF'
        ,drvQTY01_QuantityQual1 = ''
        ,drvQTY02_Quantity1 = ''
        ,drvQTY01_QuantityQual2 = ''
        ,drvQTY02_Quantity2 = ''
        ,drvQTY01_QuantityQual3 = ''
        ,drvQTY02_Quantity3 = ''
        ,drvN101_EntityIDCodeSponsor1 = 'P5'
        ,drvN102_Name1 = 'INSPIRE COMMUNITIES'
        ,drvN103_IDCodeQual1 = 'FI'
        ,drvN104_IDCode1 = (SELECT CmmFedTaxId FROM dbo.CompMast WITH(NOLOCK))
        ,drvN101_EntityIDCodeSponsor2 = 'IN'
        ,drvN102_Name2 = 'UNITEDHEALTH GROUP'
        ,drvN103_IDCodeQual2 = 'FI'
        ,drvN104_IDCode2 = '411289245'
    INTO dbo.U_EUHCINS834_HdrTbl
    FROM dbo.U_EUHCINS834_EELIST WITH (NOLOCK)
    JOIN dbo.U_dsi_bdm_EUHCINS834 WITH (NOLOCK)
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
    IF OBJECT_ID('U_EUHCINS834_DrvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EUHCINS834_DrvTbl;
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
                                                CASE WHEN ConRelationship IN ('SPS'/*,'DP'*/) THEN '01'
                                                     WHEN ConRelationship = 'DP' THEN '53'
                                                     WHEN ConRelationship IN ('CHL', 'DPC', 'STC') THEN '19'
                                                     ELSE '19'
                                                END
                                     END
        ,drvINS03_MaintTypeCode = '030' --Audit or Compare
        ,drvINS04_MaintReasonCode = '' --Notification Only
        ,drvINS05_BenefitStatusCode = 'A'
        ,drvINS0601_MEDICAREPLANCODE = ''
        ,drvINS0602_EligibilityRsnCode = ''
        ,drvINS07_COBRAQualEventCode = ''
        ,drvINS08_EmploymentStatusCode = 'FT'
        -- CASE WHEN BdmRecType = 'EMP' THEN
        --                                         CASE WHEN EecEmplStatus = 'T' THEN 'TE' --Termination
        --                                              WHEN EecFullTimeOrPartTime = 'F' THEN 'FT' --Full time active employee
        --                                              WHEN EecFullTimeOrPartTime = 'P' THEN 'PT' --Part time active employee
        --                                         END
        --                                  END
        ,drvINS09_StudentStatusCode = ''
        -- CASE WHEN BdmRecType = 'DEP' THEN
        --                                         CASE WHEN ConIsStudent = 'Y' THEN 'F' END --Full-time
        --                               END
        ,drvINS10_ResponseCode = CASE WHEN ConRelationship IN ('CHL', 'DPC', 'STC') AND ConIsDisabled = 'Y' THEN 'Y' ELSE 'N' END
        /*CASE WHEN BdmRecType = 'EMP' THEN
                                        CASE WHEN EepIsDisabled = 'Y' THEN 'Y'
                                             ELSE 'N'
                                        END
                                      WHEN BdmRecType = 'DEP' THEN 
                                        CASE WHEN ConIsDisabled = 'Y' THEN 'Y'
                                             ELSE 'N'
                                        END
                                END*/
        ,drvINS11_DateTimeFormatQual = CASE WHEN ISNULL(EepDateDeceased, '') <> '' THEN 'D8' END
        ,drvINS12_DateTimePeriod = CASE WHEN ISNULL(EepDateDeceased, '') <> '' THEN CONVERT(VARCHAR(8),EepDateDeceased,112) END
        -- If drvREF01_RefNumberQual1 is Populated, then send REF Segment
        ,drvREF01_RefNumberQual1 = '1L'
        ,drvREF02_RefNumberQual1 = '0921184'
        -- If drvREF01_RefNumberQual2 is Populated, then send REF Segment
        ,drvREF01_RefNumberQual2 = ''
        ,drvREF02_RefNumberQual2 = ''
        -- If drvDTP00_DateTime1 is Populated, then send DTP Segment
        ,drvDTP00_DateTime1 = CASE WHEN EecEmplStatus = 'T' AND EecTermReason = '202' THEN 'DTP' END
        ,drvDTP01_DateTimeQualifier1 = CASE WHEN EecEmplStatus = 'T' AND EecTermReason = '202' THEN '286' END
        ,drvDTP02_DateTimeFormatQual1 = CASE WHEN EecEmplStatus = 'T' AND EecTermReason = '202' THEN 'D8' END
        ,drvDTP03_DateTimePeriod1 = ISNULL(CONVERT(VARCHAR, (CASE WHEN EecEmplStatus = 'T' AND EecTermReason ='202' THEN EecDateOfTermination END), 112), '')
        -- If drvDTP00_DateTime2 is Populated, then send DTP Segment
        ,drvDTP00_DateTime2 = 'DTP'
        ,drvDTP01_DateTimeQualifier2 = '336'
        ,drvDTP02_DateTimeFormatQual2 = 'D8'
        ,drvDTP03_DateTimePeriod2 = EecDateOfLastHire
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
        ,drvNM106_NamePrefix1 = CASE WHEN BdmRecType = 'EMP' THEN EepNamePrefix END
        ,drvNM107_NameSuffix1 = CASE WHEN BdmRecType = 'EMP' AND EepNameSuffix <> 'Z' THEN EepNameSuffix
                                     WHEN BdmRecType = 'DEP' AND ConNameSuffix <> 'Z' THEN ConNameSuffix
                                    ELSE ''
                                END
        ,drvNM108_IDCodeQualifier1 = CASE WHEN BdmRecType = 'EMP' AND ISNULL(EepSSN, '') <> '' THEN '34'
                                          WHEN BdmRecType = 'DEP' AND ISNULL(ConSSN, '') <> '' THEN '34'
                                     END
        ,drvNM109_IDCode1 = CASE WHEN BdmRecType = 'EMP' AND ISNULL(EepSSN, '') <> '' THEN EepSSN
                                 WHEN BdmRecType = 'DEP' AND ISNULL(ConSSN, '') <> '' THEN ConSSN
                            END
        ,drvPER02_Name = ''
        ,drvPER03_CommNumberQualifier = CASE WHEN BdmRecType = 'EMP' and ISNULL(EepPhoneHomeNumber,'') <> '' and ISNULL(eepAddressEMail,'') = '' THEN 'HP'
                                             WHEN BdmRecType = 'EMP' and ISNULL(EepPhoneHomeNumber,'') = '' and ISNULL(eepAddressEMail,'') <> '' THEN 'EM'
                                              WHEN BdmRecType = 'EMP' and ISNULL(EepPhoneHomeNumber,'') <> '' and ISNULL(eepAddressEMail,'') <> '' THEN 'HP'
                                             END

        ,drvPER04_CommunicationNumber = CASE WHEN BdmRecType = 'EMP' and ISNULL(EepPhoneHomeNumber,'') <> '' and ISNULL(eepAddressEMail,'') = '' THEN ISNULL(EepPhoneHomeNumber,'') 
                                              WHEN BdmRecType = 'EMP' and ISNULL(EepPhoneHomeNumber,'') = '' and ISNULL(eepAddressEMail,'') <> '' THEN ISNULL(eepAddressEMail,'')
                                              WHEN BdmRecType = 'EMP' and ISNULL(EepPhoneHomeNumber,'') <> '' and ISNULL(eepAddressEMail,'') <> '' THEN  ISNULL(EepPhoneHomeNumber,'') 

                                             END

        ,drvPER05_CommNumberQualifier = CASE WHEN BdmRecType = 'EMP' and ISNULL(eepAddressEMail,'') <> '' and   ISNULL(EepPhoneHomeNumber,'') <> '' THEN 'EM' END

        ,drvPER06_CommunicationNumber = CASE WHEN BdmRecType = 'EMP' and ISNULL(eepAddressEMail,'') <> '' and   ISNULL(EepPhoneHomeNumber,'') <> '' THEN ISNULL(eepAddressEMail,'') END

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
        ,drvDMG03_GenderCode1 = CASE WHEN BdmRecType = 'EMP' THEN EepGender
                                     WHEN BdmRecType = 'DEP' THEN ConGender
                                END
        ,drvDMG04_MaritalStatusCode1 = CASE WHEN EepMaritalStatus = 'S' THEN 'I'
                                            WHEN EepMaritalStatus = '' OR EepMaritalStatus = 'Z' THEN 'U'
                                            ELSE EepMaritalStatus END
        /*CASE WHEN BdmRecType = 'EMP' THEN
                                                CASE EepMaritalStatus WHEN 'M' THEN 'M' ELSE 'I' END
                                       END*/
        --If drvICM01_FrequencyCode is Populated, then send ICM Segment
        ,drvICM01_FrequencyCode = CASE WHEN BdmRecType = 'EMP' THEN '' END --'7'
        ,drvICM02_MonetaryAmount = CASE WHEN BdmRecType = 'EMP' THEN CONVERT(MONEY,EecAnnSalary) END
        ,drvICM03_Quantity = CASE WHEN BdmRecType = 'EMP' THEN CONVERT(MONEY,EecScheduledWorkHrs) END
        ,drvICM04_LocationID = CASE WHEN BdmRecType = 'EMP' THEN
                                        CASE WHEN YEAR(EecDateOfLastHire) = YEAR(GETDATE()) THEN CONVERT(VARCHAR(8),EecDateOfLastHire,112)
                                            ELSE CONVERT(CHAR(4),YEAR(GETDATE())) + '0101'
                                        END
                               END
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
        ,drvHLH01_HealthRelatedCode = CASE WHEN BdmRecType = 'EMP' THEN
                                                CASE EepIsSmoker
                                                     WHEN 'Y' THEN 'T' --Tobacco Use
                                                     ELSE 'N' --None
                                                END
                                           WHEN BdmRecType = 'DEP' THEN
                                                CASE ConIsSmoker
                                                     WHEN 'Y' THEN 'T' --Tobacco Use
                                                     ELSE 'N' --None
                                                END
                                      END
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
    INTO dbo.U_EUHCINS834_DrvTbl
    FROM dbo.U_EUHCINS834_EELIST WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    JOIN dbo.U_dsi_bdm_EUHCINS834 WITH (NOLOCK)
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

    -- HLT Load
    IF OBJECT_ID('U_EUHCINS834_DrvTbl_2300','U') IS NOT NULL
        DROP TABLE dbo.U_EUHCINS834_DrvTbl_2300;
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
        ,drvHD03_InsuranceLineCode = 'HLT'
        ,drvHD04_PlanCoverageDesc = CASE WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'aadmiral' THEN '00150015TT'
                                            WHEN BdmDedCode = 'UHHSA' AND LocCode = 'BLUEGR' THEN '00190019TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'acandlel' THEN '00230023TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'acandlew' THEN '00270027TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'acardrid' THEN '00310031TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'acascade' THEN '00350035TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'acimgran' THEN '00430043TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'acimhts' THEN '00390039TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'acontine' THEN '00470047TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'acountrd' THEN '00510051TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'acoweta' THEN '00590059TT'
											--WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'acoyotet' THEN '05330533TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'acvwgran' THEN '00550055TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'aelsolgr' THEN '00670067TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'asolhome' THEN '00670067TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'afishhav' THEN '05010501TT'
											--WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'afishlav' THEN '05370537TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'ageorget' THEN '05050505TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'agoasis' THEN '00710071TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'ahermita' THEN '00750075TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'ahibiscu' THEN '05090509TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'ahrivern' THEN '00790079TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'ahrivers' THEN '00830083TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'aindepen' THEN '00870087TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'ainspinc' THEN '00070007TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'ainspllc' THEN '00030003TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'ajamesto' THEN '00910091TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'aknollt' THEN '00950095TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'alakebob' THEN '05130513TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'alakewod' THEN '00990099TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'alamplit' THEN '01030103TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'alucerne' THEN '05170517TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'anormand' THEN '01110111TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'aoakcres' THEN '01150115TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'aoakgran' THEN '01190119TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'aoceanwy' THEN '01230123TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'aongreen' THEN '01270127TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'aparvill' THEN '01350135TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'apinemea' THEN '01390139TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'apinesha' THEN '01430143TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'aquail' THEN '01470147TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'aramblew' THEN '01510151TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'arobbinw' THEN '01550155TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'arolmead' THEN '01590159TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'aroselak' THEN '05210521TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'asilver' THEN '01630163TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'aspringb' THEN '01670167TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'asunnypi' THEN '05250525TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'atallpin' THEN '05290529TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'atelaval' THEN '01710171TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'avictori' THEN '01750175TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'awelling' THEN '01830183TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'awestgat' THEN '01870187TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'awhcreek' THEN '01910191TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'awillowp' THEN '01950195TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'awindsor' THEN '01990199TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'palpinev' THEN '00110011TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'pbayside' THEN '05410541TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'pbrentwo' THEN '05450545TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'pcalient' THEN '05490549TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'pcasalin' THEN '05530553TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'pcirclek' THEN '05570557TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'pcntryac' THEN '05610561TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'pcolonia' THEN '05650565TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'pfolsom' THEN '05690569TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'pgreenvi' THEN '05730573TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'plakesid' THEN '05770577TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'plakeway' THEN '05810581TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'plazyj' THEN '05850585TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'plindavi' THEN '05890589TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'pmanteca' THEN '05930593TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'pmaplewo' THEN '05970597TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'poaks' THEN '06010601TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'poceanw' THEN '06050605TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'poldplan' THEN '06090609TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'psalida' THEN '06130613TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'psantiag' THEN '06170617TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'pstvrain' THEN '06210621TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'psunflow' THEN '06250625TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'psunset' THEN '06290629TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'ptramvie' THEN '06330633TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'pturf' THEN '06370637TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rfernwood' THEN '06410641TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rmiramar' THEN '06450645TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rtwinvie' THEN '06490649TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rarbormo' THEN '02030203TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'razaleag' THEN '02070207TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rbaronmo' THEN '02110211TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rbeachvi' THEN '02150215TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rblackoa' THEN '02190219TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rbluespr' THEN '02230223TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rbramble' THEN '02270227TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rbrookfi' THEN '02310231TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rbrookva' THEN '02350235TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rcarsonv' THEN '02390239TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rcedarpa' THEN '02430243TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rcherryh' THEN '02470247TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rcindere' THEN '02510251TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rcirclel' THEN '02550255TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rcloverl' THEN '02590259TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rcountrc' THEN '02630263TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rcountrm' THEN '02670267TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rcrestvi' THEN '02710271TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rcrestwo' THEN '02750275TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rdelawar' THEN '02790279TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'relmgrov' THEN '02830283TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rfarming' THEN '02870287TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rfernwoo' THEN '02910291TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rflaming' THEN '02950295TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rforestl' THEN '02990299TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rfreedom' THEN '03030303TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rgasligh' THEN '03070307TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rglenlea' THEN '03110311TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rgoldenp' THEN '03150315TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rhawthor' THEN '03190319TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rhiddenv' THEN '03230323TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rhillcou' THEN '03270327TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rhumming' THEN '03310331TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rjackson' THEN '03350335TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rkiljord' THEN '03390339TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rkingpar' THEN '03430343TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rlacasit' THEN '03470347TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rlakevie' THEN '03510351TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rleisure' THEN '03550355TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rlilyoft' THEN '03590359TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rlondons' THEN '03630363TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rmiamimo' THEN '03670367TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rmission' THEN '03710371TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rmobilee' THEN '03750375TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rmountai' THEN '03790379TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'roldhick' THEN '03830383TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rozarkhi' THEN '03870387TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rparkvie' THEN '03910391TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rparkway' THEN '03950395TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rpinegro' THEN '03990399TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rplantat' THEN '04030403TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rpueblos' THEN '04070407TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rranchwo' THEN '04110411TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rredceda' THEN '04150415TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rredmapl' THEN '04190419TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rredwood' THEN '04230423TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rshadowm' THEN '04270427TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rshenand' THEN '04310431TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rsilverl' THEN '04350435TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rsilverm' THEN '04390439TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rsouthla' THEN '04430443TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rstonega' THEN '04470447TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rswancre' THEN '04510451TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rsweetgu' THEN '04550455TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rthemead' THEN '04590459TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rthepine' THEN '04630463TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rvalleyo' THEN '04670467TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rvalleyv' THEN '04710471TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rvillage' THEN '04750475TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rwesters' THEN '04790479TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rwesterv' THEN '04830483TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rwhiteoa' THEN '04870487TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rwhitepi' THEN '04910491TT'
                                            WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rwhittie' THEN '04950495TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'aadmiral' THEN '00130013TT'
                                            --WHEN BdmDedCode = 'UHPPO' AND LocCode = 'BLUEGR' THEN '00190019TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'acandlel' THEN '00210021TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'acandlew' THEN '00250025TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'acardrid' THEN '00290029TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'acascade' THEN '00330033TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'acimgran' THEN '00410041TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'acimhts' THEN '00370037TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'acontine' THEN '00450045TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'acountrd' THEN '00490049TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'acoweta' THEN '00570057TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'acvwgran' THEN '00530053TT'
                                            --WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'aelsolgr' THEN '00650065TT'
                                            --WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'asolhome' THEN '00670067TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'afishhav' THEN '05010501TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'ageorget' THEN '05030503TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'agoasis' THEN '00690069TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'ahermita' THEN '00730073TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'ahibiscu' THEN '05070507TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'ahrivern' THEN '00770077TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'ahrivers' THEN '00810081TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'aindepen' THEN '00850085TT'
                                            --WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'ainspinc' THEN '00050005TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'ainspllc' THEN '00010001TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'ajamesto' THEN '00890089TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'aknollt' THEN '00930093TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'alakebob' THEN '05110511TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'alakewod' THEN '00970097TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'alamplit' THEN '01010101TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'alucerne' THEN '05150515TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'anormand' THEN '01090109TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'aoakcres' THEN '01130113TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'aoakgran' THEN '01170117TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'aoceanwy' THEN '01210121TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'aongreen' THEN '01250125TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'aparvill' THEN '01330133TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'apinemea' THEN '01370137TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'apinesha' THEN '01410141TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'aquail' THEN '01450145TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'aramblew' THEN '01490149TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'arobbinw' THEN '01530153TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'arolmead' THEN '01570157TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'aroselak' THEN '05190519TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'asilver' THEN '01610161TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'aspringb' THEN '01650165TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'asunnypi' THEN '05230523TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'atallpin' THEN '05270527TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'atelaval' THEN '01690169TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'avictori' THEN '01730173TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'awelling' THEN '01810181TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'awestgat' THEN '01850185TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'awhcreek' THEN '01890189TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'awillowp' THEN '01930193TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'awindsor' THEN '01970197TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'palpinev' THEN '00090009TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'pbayside' THEN '05390539TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'pbrentwo' THEN '05430543TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'pcalient' THEN '05470547TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'pcasalin' THEN '05510551TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'pcirclek' THEN '05550555TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'pcntryac' THEN '05590559TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'pcolonia' THEN '05630563TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'pfolsom' THEN '05670567TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'pgreenvi' THEN '05710571TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'plakesid' THEN '05750575TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'plakeway' THEN '05790579TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'plazyj' THEN '05830583TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'plindavi' THEN '05870587TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'pmanteca' THEN '05910591TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'pmaplewo' THEN '05950595TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'poaks' THEN '05990599TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'poceanw' THEN '06030603TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'poldplan' THEN '06070607TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'psalida' THEN '06110611TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'psantiag' THEN '06150615TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'pstvrain' THEN '06190619TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'psunflow' THEN '06230623TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'psunset' THEN '06270627TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'ptramvie' THEN '06310631TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'pturf' THEN '06350635TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rarbormo' THEN '02040204TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'razaleag' THEN '02080208TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rbaronmo' THEN '02120212TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rbeachvi' THEN '02160216TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rblackoa' THEN '02200220TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rbluespr' THEN '02240224TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rbramble' THEN '02280228TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rbrookfi' THEN '02320232TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rbrookva' THEN '02360236TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rcarsonv' THEN '02400240TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rcedarpa' THEN '02440244TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rcherryh' THEN '02480248TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rcindere' THEN '02520252TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rcirclel' THEN '02560256TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rcloverl' THEN '02600260TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rcountrc' THEN '02640264TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rcountrm' THEN '02680268TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rcrestvi' THEN '02720272TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rcrestwo' THEN '02760276TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rdelawar' THEN '02800280TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'relmgrov' THEN '02840284TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rfarming' THEN '02880288TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rfernwoo' THEN '02920292TT'
											--WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rfernwood' THEN '06390639TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rflaming' THEN '02960296TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rforestl' THEN '03000300TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rfreedom' THEN '03040304TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rgasligh' THEN '03080308TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rglenlea' THEN '03120312TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rgoldenp' THEN '03160316TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rhawthor' THEN '03200320TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rhiddenv' THEN '03240324TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rhillcou' THEN '03280328TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rhumming' THEN '03320332TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rjackson' THEN '03360336TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rkiljord' THEN '03400340TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rkingpar' THEN '03440344TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rlacasit' THEN '03480348TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rlakevie' THEN '03520352TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rleisure' THEN '03560356TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rlilyoft' THEN '03600360TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rlondons' THEN '03640364TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rmiamimo' THEN '03680368TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rmiramar' THEN '06430643TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rmission' THEN '03720372TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rmobilee' THEN '03760376TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rmountai' THEN '03800380TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'roldhick' THEN '03840384TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rozarkhi' THEN '03880388TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rparkvie' THEN '03920392TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rparkway' THEN '03960396TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rpinegro' THEN '04000400TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rplantat' THEN '04040404TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rpueblos' THEN '04080408TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rranchwo' THEN '04120412TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rredceda' THEN '04160416TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rredmapl' THEN '04200420TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rredwood' THEN '04240424TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rshadowm' THEN '04280428TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rshenand' THEN '04320432TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rsilverl' THEN '04360436TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rsilverm' THEN '04400440TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rsouthla' THEN '04440444TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rstonega' THEN '04480448TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rswancre' THEN '04520452TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rsweetgu' THEN '04560456TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rthemead' THEN '04600460TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rthepine' THEN '04640464TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rtwinvie' THEN '06470647TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rvalleyo' THEN '04680468TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rvalleyv' THEN '04720472TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rvillage' THEN '04760476TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rwesters' THEN '04800480TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rwesterv' THEN '04840484TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rwhiteoa' THEN '04880488TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rwhitepi' THEN '04920492TT'
                                            WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rwhittie' THEN '04960496TT'
                                        END


        ,drvHD05_CoverageLevelCode = CASE WHEN BdmBenOption IN ('EE') THEN 'EMP'
                                                     WHEN BdmBenOption IN ('EES', 'EEDP') THEN 'ESP'
                                                     WHEN BdmBenOption IN ('EEC') THEN 'ECH'
                                                     WHEN BdmBenOption IN ('EEF', 'EEDPF') THEN 'FAM'
                                                END
        -- If drvDTP00_DateTime_348 Populated, then send DTP*348 Segment
        ,drvDTP00_DateTime_348 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN 'DTP' END
        ,drvDTP01_DateTimeQualifier_348 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '348' END
        ,drvDTP02_DateTimeFormatQual_348 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN 'D8' END
        ,drvDTP03_DateTimePeriod_348 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate) END
        -- If drvDTP00_DateTime_349 Populated, then send DTP*349 Segment
        ,drvDTP00_DateTime_349 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') AND BdmBenStopDate IS NOT NULL THEN 'DTP' END
        ,drvDTP01_DateTimeQualifier_349 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') AND BdmBenStopDate IS NOT NULL THEN '349' END
        ,drvDTP02_DateTimeFormatQual_349 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') AND BdmBenStopDate IS NOT NULL THEN 'D8' END
        ,drvDTP03_DateTimePeriod_349 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN BdmBenStopDate END
        -- If drvDTP00_DateTime_303 = 'DTP', then Send DTP*303 Segment
        ,drvDTP00_DateTime_303 = CASE WHEN BdmDedType IN ('MED') THEN '' END
        ,drvDTP01_DateTimeQualifier_303 = CASE WHEN BdmDedType IN ('MED') THEN '303' END
        ,drvDTP02_DateTimeFormatQual_303 = CASE WHEN BdmDedType IN ('MED') THEN 'D8' END
        ,drvDTP03_DateTimePeriod_303 = CASE WHEN BdmDedType IN ('MED') THEN dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStatusDate, @FileMinCovDate) END
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
    INTO dbo.U_EUHCINS834_DrvTbl_2300
    FROM dbo.U_EUHCINS834_EELIST WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.U_dsi_bdm_EUHCINS834 WITH (NOLOCK)
        ON BdmEEID = xEEID
        AND BdmCOID = xCOID
    JOIN dbo.Location WITH(NOLOCK)
        ON LocCode = EecLocation
    JOIN dbo.OrgLevel WITH(NOLOCK) 
      --  ON eecorglvl3 = orgcode
		ON EecOrgLvl2 = OrgCode
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID;

    -- PDG Load
    INSERT INTO U_EUHCINS834_DrvTbl_2300
    SELECT DISTINCT 
     drvHD00_HealthCoverage 
        ,drvHD01_MaintTypeCode 
        ,drvHD02_MaintReasonCode 
        ,drvHD03_InsuranceLineCode = 'PDG'
        ,drvHD04_PlanCoverageDesc 
        ,drvHD05_CoverageLevelCode 
        -- If drvDTP00_DateTime_348 Populated, then send DTP*348 Segment
        ,drvDTP00_DateTime_348 
        ,drvDTP01_DateTimeQualifier_348
        ,drvDTP02_DateTimeFormatQual_348
        ,drvDTP03_DateTimePeriod_348 
        -- If drvDTP00_DateTime_349 Populated, then send DTP*349 Segment
        ,drvDTP00_DateTime_349 
        ,drvDTP01_DateTimeQualifier_349 
        ,drvDTP02_DateTimeFormatQual_349
        ,drvDTP03_DateTimePeriod_349 
        -- If drvDTP00_DateTime_303 = 'DTP', then Send DTP*303 Segment
        ,drvDTP00_DateTime_303 
        ,drvDTP01_DateTimeQualifier_303 
        ,drvDTP02_DateTimeFormatQual_303 
        ,drvDTP03_DateTimePeriod_303 
        -- If drvREF00_RefNumberQual1 is Populated, then send REF Segment
        ,drvREF00_RefNumberQual1 = ''
        ,drvREF01_RefNumberQual1 = ''
        ,drvREF02_RefNumberQual1 = ''
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
        ,drvLS01_LoopIDCode  = ''
        ,drvLX01_AssignedNumber  = ''
        --=====================
        -- Loop 2750 RECORDS
        --=====================
        ,drvN101_EntityIDCodeSponsor  = ''
        ,drvN102_Name  = ''
        ,drvREF01_RefNumberQual = ''
        ,drvREF02_RefNumberDesc = ''
        ,drvLE01_LoopIDCode  = ''
        ---------------------------------
        ,drvEEID 
        ,drvCOID 
        ,drvDepRecID 
        ,drvSSN 
        ,drvInitialSort
        ,drvSubSort = CONVERT(CHAR(9),RTRIM(drvSSN)) + CONVERT(CHAR(12),ISNULL(drvDepRecID,''))
                      + '2'
        FROM dbo. U_EUHCINS834_DrvTbl_2300
        ;

    /**************************************************************************************************
        TRAILER RECORDS
            - SE, GE, IEA Segments
    **************************************************************************************************/
    ---------------------
    -- TRAILER RECORD
    --------------------
    IF OBJECT_ID('U_EUHCINS834_TrlTbl') IS NOT NULL
        DROP TABLE dbo.U_EUHCINS834_TrlTbl;
    SELECT DISTINCT drvSE01_SegmentCount = '9999'
    INTO dbo.U_EUHCINS834_TrlTbl;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable('EUHCINS834','UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = 'INSPR_EUHCINS834_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
        WHERE FormatCode = 'EUHCINS834';
    END;

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEUHCINS834_Export AS
    SELECT TOP 20000000 DATA FROM dbo.U_EUHCINS834_File (NOLOCK)
    ORDER BY CASE LEFT(Recordset,1) WHEN 'H' THEN 1 WHEN 'D' THEN 2 ELSE 3 END, InitialSort, SubSort, RIGHT(Recordset,2)
GO

--Check out AscDefF
SELECT * FROM dbo.AscDefFEEOnlyBenOpti
WHERE AdfHeaderSystemID LIKE 'EUHCINS834%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET ExpLastStartPerControl = '201810011'
       ,ExpStartPerControl     = '201810011'
       ,ExpLastEndPerControl   = '201810019'
       ,ExpEndPerControl       = '201810019'
WHERE ExpFormatCode = 'EUHCINS834';

**********************************************************************************/
