USE [ULTIPRO_WPTKG]
GO
/****** Object:  StoredProcedure [dbo].[dsi_sp_BuildDriverTables_EANTHLNDEX]    Script Date: 6/25/2021 2:16:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EANTHLNDEX]
    @systemid CHAR(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client: Kleingers

Created By: James Bender
Business Analyst: Richard Vars
Create Date: 8/4/2020
Service Request Number: TekP-2020-07-13-0001

Purpose: Anthem Life & Disability 834

Revision History
----------------
06/25/2021 by AP:
		- Updated the B9 field to use the BdmUSGField1 value as this seems to be the correct value for VLIFE, VLIFS or VLIFC dedcodes
		  as per BA ticket update.

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EANTHLNDEX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EANTHLNDEX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EANTHLNDEX';
SELECT * FROM dbo.AscExp WHERE expFormatCode = 'EANTHLNDEX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EANTHLNDEX' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EANTHLNDEX', 'FULLFILE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EANTHLNDEX', 'CHANGES';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EANTHLNDEX', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EANTHLNDEX', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EANTHLNDEX', 'SCHEDULED';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EANTHLNDEX';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EANTHLNDEX', @AllObjects = 'Y', @IsWeb = 'Y';
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
        ,@FileMinCovDate  = '1/1/2020'
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = 'EANTHLNDEX';

    --==========================================
    -- Deduction Code List
    --==========================================
    DECLARE @DedList VARCHAR(MAX);
    SET @DedList = 'GTLIF,EDLIF,VLIFE,VLIFES,VLIFC,ERSTD,ERLTD';

    IF OBJECT_ID('U_EANTHLNDEX_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EANTHLNDEX_DedList;
    SELECT DedCode = DedDedCode
        ,DedLongDesc
        ,DedType = DedDedType
    INTO dbo.U_EANTHLNDEX_DedList
    FROM dbo.dsi_BDM_fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

    --==========================================
    -- Clean EE List
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EANTHLNDEX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCoID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EANTHLNDEX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    -- Remove Employees that Do Not Have a Benefit Plan in Deduction Code List
    DELETE FROM dbo.U_EANTHLNDEX_EEList
    WHERE NOT EXISTS (SELECT 1 FROM dbo.EmpDed JOIN dbo.U_EANTHLNDEX_DedList ON DedCode = EedDeDCode WHERE EedEEID = xEEID);

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
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','@DomPartnerCSV');

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

    DELETE dbo.U_dsi_bdm_EANTHLNDEX WHERE BdmRecType = 'DEP';

    --=========================================
    -- Update BdmChangeReason For Dependents
    --=========================================
    UPDATE D
        SET D.BdmChangeReason = E.BdmChangeReason
    FROM dbo.U_dsi_bdm_EANTHLNDEX D
    JOIN dbo.U_dsi_bdm_EANTHLNDEX E
        ON E.BdmEEID = D.BdmEEID
        AND E.BdmCOID = D.BdmCOID
        AND E.BdmDedCode = D.BdmDedCode
    WHERE D.BdmRecType = 'DEP' AND E.BdmRecType = 'EMP';

    --=====================================================
    -- Update BdmUSGField2 with EmpDedTVID for Employees
    --=====================================================
    UPDATE dbo.U_dsi_bdm_EANTHLNDEX
        SET BdmUSGField2 = EedEmpDedTVID
    FROM dbo.U_dsi_bdm_EANTHLNDEX
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = BdmEEID
        AND EedCOID = BdmCOID
        AND EedDedCode = BdmDedCode
    WHERE BdmRecType = 'EMP' AND EedFormatCode = @FormatCode AND EedValidForExport = 'Y';

    --=======================================================
    -- Update BdmUSGField2 with DepBPlanTVID for Dependents
    --=======================================================
    UPDATE dbo.U_dsi_bdm_EANTHLNDEX
        SET BdmUSGField2 = DbnDepBPlanTVID
    FROM dbo.U_dsi_bdm_EANTHLNDEX
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
        ON DbnEEID = BdmEEID
        AND DbnCOID = BdmCOID
        AND DbnDedCode = BdmDedCode
    WHERE BdmRecType = 'DEP' AND DbnFormatCode = @FormatCode AND DbnValidForExport = 'Y';

    --======================================================
    -- Update BdmUSGField1 with Benefit Amount (EedBenAmt)
    --======================================================
    UPDATE dbo.U_dsi_bdm_EANTHLNDEX
        SET BdmUSGField1 = CONVERT(VARCHAR(20),EedBenAmt)
    FROM dbo.U_dsi_bdm_EANTHLNDEX
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
    IF OBJECT_ID('U_EANTHLNDEX_HdrTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EANTHLNDEX_HdrTbl;
    SELECT DISTINCT drvISA05_SenderIDQual = 'ZZ'
        ,drvISA06_SenderID = 'MW53978E'
        ,drvISA07_ReceiverIDQual = 'ZZ'
        ,drvISA08_ReceiverID = 'COMPASS'
        ,drvISA09_InterchangeDate = RIGHT(@RunDate,6)
        ,drvISA10_InterchangeTime = @RunTime
        ,drvISA15_UsageIndicator = 'T' --CASE dbo.dsi_fnVariable(@FormatCode,'Testing') WHEN 'Y' THEN 'T' ELSE 'P' END
        ,drvGS02_SenderID = 'MW53978E'
        ,drvGS03_ReceiverID = 'COMPASS'
        ,drvGS04_Date = @RunDate
        ,drvGS05_Time = @RunTime
        ,drvBGN03_Date = @RunDate
        ,drvBGN04_Time = @RunTime
        ,drvBGN05_TimeCode = 'ES'
        ,drvBGN06_RefID = ''
        ,drvBGN07_TransTypeCode = ''
        ,drvBGN08_ActionCode = 'RX'
        ,drvREF01_RefNumberQual = '38'
        ,drvREF02_RefNumberQual = 'CM10000069'
        ,drvQTY01_QuantityQual1 = 'TO'
        ,drvQTY02_Quantity1 = '9999'
        ,drvQTY01_QuantityQual2 = ''
        ,drvQTY02_Quantity2 = ''
        ,drvQTY01_QuantityQual3 = ''
        ,drvQTY02_Quantity3 = ''
        ,drvN101_EntityIDCodeSponsor1 = 'P5'
        ,drvN102_Name1 = ''
        ,drvN103_IDCodeQual1 = 'FI'
        ,drvN104_IDCode1 = (SELECT TOP 1 CmmFedTaxId FROM dbo.CompMast WITH (NOLOCK))
        ,drvN101_EntityIDCodeSponsor2 = 'IN'
        ,drvN102_Name2 = 'ANTHEMBLUE CROSS'
        ,drvN103_IDCodeQual2 = 'FI'
        ,drvN104_IDCode2 = '953760001'
    INTO dbo.U_EANTHLNDEX_HdrTbl 
    FROM dbo.U_EANTHLNDEX_EELIST WITH (NOLOCK)
    JOIN dbo.U_dsi_bdm_EANTHLNDEX WITH (NOLOCK)
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
    IF OBJECT_ID('U_EANTHLNDEX_DrvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EANTHLNDEX_DrvTbl;
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
                                                CASE WHEN ConRelationship IN ('SPS','@DomPartnerCSV') THEN '01'
                                                     WHEN ConRelationship IN ('CHL') THEN '19'
                                                     ELSE '19'
                                                END
                                     END
        ,drvINS03_MaintTypeCode = '030' --Audit or Compare
        ,drvINS04_MaintReasonCode = 'XN' --Notification Only
        ,drvINS05_BenefitStatusCode = 'A'
        ,drvINS0601_MEDICAREPLANCODE = ''
        ,drvINS0602_EligibilityRsnCode = ''
        ,drvINS07_COBRAQualEventCode = ''
        ,drvINS08_EmploymentStatusCode = 'AC' /*CASE WHEN BdmRecType = 'EMP' THEN
                                                CASE WHEN EecEmplStatus = 'T' THEN 'TE' --Termination
                                                     WHEN EecFullTimeOrPartTime = 'F' THEN 'FT' --Full time active employee
                                                     WHEN EecFullTimeOrPartTime = 'P' THEN 'PT' --Part time active employee
                                                END
                                         END*/
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
        ,drvREF01_RefNumberQual1 = '1L'
        ,drvREF02_RefNumberQual1 = 'CM100000690000'
        -- If drvREF01_RefNumberQual2 is Populated, then send REF Segment
        ,drvREF01_RefNumberQual2 = 'ZZ'
        ,drvREF02_RefNumberQual2 = 'THE KLEINGERS GROUP'
        -- If drvDTP00_DateTime1 is Populated, then send DTP Segment
        ,drvDTP00_DateTime1 = 'DTP'
        ,drvDTP01_DateTimeQualifier1 = '336'
        ,drvDTP02_DateTimeFormatQual1 = 'D8'
        ,drvDTP03_DateTimePeriod1 = EecDateOfLastHire
        -- If drvDTP00_DateTime2 is Populated, then send DTP Segment
        ,drvDTP00_DateTime2 = ''
        ,drvDTP01_DateTimeQualifier2 = ''
        ,drvDTP02_DateTimeFormatQual2 = ''
        ,drvDTP03_DateTimePeriod2 = ''
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
        ,drvNM107_NameSuffix1 = CASE WHEN EepNameSuffix <> 'Z' THEN EepNameSuffix END /*CASE WHEN BdmRecType = 'EMP' THEN EepNameSuffix
                                     WHEN BdmRecType = 'DEP' THEN ConNameSuffix
                                END*/
        ,drvNM108_IDCodeQualifier1 = CASE WHEN BdmRecType = 'EMP' AND ISNULL(EepSSN, '') <> '' THEN '34'
                                          WHEN BdmRecType = 'DEP' AND ISNULL(ConSSN, '') <> '' THEN '34'
                                     END
        ,drvNM109_IDCode1 = CASE WHEN BdmRecType = 'EMP' AND ISNULL(EepSSN, '') <> '' THEN EepSSN
                                 WHEN BdmRecType = 'DEP' AND ISNULL(ConSSN, '') <> '' THEN ConSSN
                            END
        ,drvPER02_Name = ''
        ,drvPER03_CommNumberQualifier = '' --CASE WHEN BdmRecType = 'EMP' AND ISNULL(EepPhoneHomeNumber,'') <> '' THEN 'HP' END
        ,drvPER04_CommunicationNumber = '' --CASE WHEN BdmRecType = 'EMP' THEN ISNULL(EepPhoneHomeNumber,'') END
        ,drvPER05_CommNumberQualifier = '' --CASE WHEN BdmRecType = 'EMP' AND EepPhoneHomeNumber IS NULL AND ISNULL(EfoPhoneNumber,'') <> '' THEN 'CP' END
		--CASE WHEN BdmRecType = 'EMP' AND ISNULL(EecPhoneBusinessNumber,'') <> '' THEN 'WP' END
        ,drvPER06_CommunicationNumber = '' --CASE WHEN BdmRecType = 'EMP' AND EepPhoneHomeNumber IS NULL THEN ISNULL(EecPhoneBusinessNumber,'') END
        ,drvPER07_CommNumberQualifier = '' --CASE WHEN BdmRecType = 'EMP' AND ISNULL(eepAddressEMail,'') <> '' THEN 'EM' END
        ,drvPER08_CommunicationNumber = '' --CASE WHEN BdmRecType = 'EMP' THEN ISNULL(eepAddressEMail,'') END

        ,drvPER09_CommNumberQualifier = '' --CASE WHEN BdmRecType = 'EMP' AND ISNULL(EfoPhoneNumber,'') <> '' THEN 'CP' END
        ,drvPER10_CommunicationNumber = '' --CASE WHEN BdmRecType = 'EMP' THEN ISNULL(EfoPhoneNumber,'') END


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
        ,drvDMG04_MaritalStatusCode1 =	CASE WHEN EepMaritalStatus = 'S' THEN 'I' 
											WHEN EepMaritalStatus = 'Z' THEN 'R' 
											ELSE EepMaritalStatus 
										END 
        --If drvICM01_FrequencyCode is Populated, then send ICM Segment
        ,drvICM01_FrequencyCode = CASE WHEN BdmRecType = 'EMP' THEN '7' END --'7'
        ,drvICM02_MonetaryAmount = CASE WHEN BdmRecType = 'EMP' THEN CONVERT(MONEY,EecAnnSalary) END
        ,drvICM03_Quantity = CASE WHEN BdmRecType = 'EMP' THEN CONVERT(MONEY,(EecScheduledWorkHrs/2)) END
        ,drvICM04_LocationID = '' /*CASE WHEN BdmRecType = 'EMP' THEN
                                        CASE WHEN YEAR(EecDateOfLastHire) = YEAR(GETDATE()) THEN CONVERT(VARCHAR(8),EecDateOfLastHire,112)
                                            ELSE CONVERT(CHAR(4),YEAR(GETDATE())) + '0101'
                                        END
                               END*/
        -- If drvAMT00_AmountQualifierCode1 = 'AMT' is Populated, then Send AMT Segment
        ,drvAMT00_SegmentID1 = '' --CASE WHEN BdmDedCode IN ('VLIFE','VLIFC','VLIFS') THEN 'AMT' END --CASE WHEN VLIFC_DedCode IS NOT NULL THEN 'AMT' END
        ,drvAMT01_AmountQualifierCode1 = 'P3'
        ,drvAMT02_MonetaryAmount1 = '' --CASE WHEN BdmDedCode IN ('VLIFE','VLIFC','VLIFS') THEN BdmUSGField1 END
			-- CASE WHEN VLIFC_DedCode IS NOT NULL THEN /*EedEOIDesiredAmt*/ VLIFE_EOIDesiredAmt  END --EedEOIDesiredAmt
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
    INTO dbo.U_EANTHLNDEX_DrvTbl
    FROM dbo.U_EANTHLNDEX_EELIST WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    JOIN dbo.U_dsi_bdm_EANTHLNDEX WITH (NOLOCK)
        ON BdmEEID = xEEID
        AND BdmCOID = xCOID
    LEFT JOIN dbo.TrmReasn WITH (NOLOCK)
        ON TchCode = EecTermReason
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
	LEFT JOIN (
                SELECT EfoEEID, EfoPhoneNumber
                FROM (
                        SELECT EfoEEID, EfoPhoneNumber, ROW_NUMBER() OVER (PARTITION BY EfoEEID ORDER BY AuditKey DESC) AS RN
                        FROM dbo.EmpMPhon WITH (NOLOCK)
                        WHERE EfoPhoneType = 'CEL'
                        ) AS CP
                WHERE RN = 1
            ) AS Cel
        ON EfoEEID = xEEID	
	/*LEFT JOIN (
			SELECT EedEEID, EedCOID, EedEOIDesiredAmt AS VLIFE_EOIDesiredAmt 
			FROM dbo.EmpDed WITH (NOLOCK)
			WHERE EedDedCode = 'VLIFE') AS X
		ON EedEEID = xEEID
		AND EedCOID = xCOID*/
/*	JOIN dbo.EmpDed WITH (NOLOCK)
		ON EedEEID = xEEID
		AND EedCOID = xCOID
		AND EedDedCode = BdmDedCode*/
	/*JOIN (
			SELECT BdmEEID AS VCEEID
				,BdmCOID AS VCCOID
				,MAX(CASE WHEN BdmDedCode = 'VLIFC' THEN BdmDedCode END) AS VLIFC_DedCode
			FROM dbo.U_dsi_bdm_EANTHLNDEX WITH (NOLOCK) 
--			where BdmEEID = 'D25CRW000030'
			GROUP BY BdmEEID, BdmCOID) AS VLIFCDed
		ON VCEEID = xEEID
		AND VCCOID = xCOID*/
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
    IF OBJECT_ID('U_EANTHLNDEX_DrvTbl_2300','U') IS NOT NULL
        DROP TABLE dbo.U_EANTHLNDEX_DrvTbl_2300;
    SELECT DISTINCT
        -- If drvHD00_HealthCoverage Populated, then send HD Segment
        drvHD00_HealthCoverage = 'HD' /*CASE WHEN BdmDedType IN ('MED') THEN 'HD'
                                        WHEN BdmDedType IN ('DEN') THEN 'HD'
                                        WHEN BdmDedType IN ('VIS') THEN 'HD'
                                 END*/
        ,drvHD01_MaintTypeCode = '030' --Audit or Compare
        ,drvHD02_MaintReasonCode = CASE WHEN BdmDedType IN ('MED') THEN ''
                                           WHEN BdmDedType IN ('DEN') THEN ''
                                           WHEN BdmDedType IN ('VIS') THEN ''
                                     END
        ,drvHD03_InsuranceLineCode = 'LTD      ' /*	CASE WHEN BdmDedCode IN ('GTLIF','EDLIF','VLIF','VLIFS','VLIFC') THEN 'FAC      '
											WHEN BdmDedCode IN ('ERLTD') THEN 'LTD      '
											WHEN BdmDedCode IN ('ERSTD') THEN 'STD      '
										END*/
		
										/*CASE WHEN BdmDedCode = 'ERSTD' THEN 'STD-SAL'
											WHEN BdmDedCode = 'GTLIF' THEN 'Life-Flat'
											WHEN BdmDedCode = 'EDLIF' THEN 'Dep Fam'
											WHEN BdmDedCode = 'VLIF' THEN 'SUPP LIFE-Flat'
											WHEN BdmDedCode = 'VLIFS' THEN 'DEP Spouse'
											WHEN BdmDedCode = 'VLIFC' THEN 'DEP Child'
											WHEN BdmDedCode = 'ERLTD' THEN 'LTD'
										END*/
		
									--'LTD' /*  CASE WHEN BdmDedCode IN ('ERSTD') THEN 'STD'
                                            --WHEN BdmDedCode IN ('GTLIF','EDLIF','VLIF','VLIFS','VLIFC') THEN 'AG'
--                                            WHEN BdmDedCode IN ('ERLTD')  THEN 'LTD'
  --                                      END */
                                    /*CASE WHEN BdmDedType IN ('MED') THEN 'HLT'
                                           WHEN BdmDedType IN ('DEN') THEN 'DEN'
                                           WHEN BdmDedType IN ('VIS') THEN 'VIS'
                                     END*/
        ,drvHD04_PlanCoverageDesc =	'01' /*CASE WHEN BdmDedCode = 'GTLIF' THEN 'Life-Flat'
										WHEN BdmDedCode = 'EDLIF' THEN 'Dep Fam'
										WHEN BdmDedCode = 'VLIF' THEN 'SUPP LIFE-Flat'
										WHEN BdmDedCode = 'VLIFS' THEN 'DEP Spouse'
										WHEN BdmDedCode = 'VLIFC' THEN 'DEP Child'
										WHEN BdmDedCode = 'ERLTD' THEN 'LTD'
										WHEN BdmDedCode = 'ERSTD' THEN 'STD-SAL'
									END*/
										--'01' 
									/*CASE WHEN BdmDedType IN ('MED') THEN ''
                                           WHEN BdmDedType IN ('DEN') THEN ''
                                           WHEN BdmDedType IN ('VIS') THEN ''
                                     END*/
        ,drvHD05_CoverageLevelCode = 'EMP' /*CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN
                                                CASE WHEN BdmBenOption IN ('@EEBenOpts') THEN 'EMP'
                                                     WHEN BdmBenOption IN ('@ESPBenOpts') THEN 'ESP'
                                                     WHEN BdmBenOption IN ('@ECHBenOpts') THEN 'ECH'
                                                     WHEN BdmBenOption IN ('@EEFAMBenOpts') THEN 'FAM'
                                                END
                                     END*/
        -- If drvDTP00_DateTime_348 Populated, then send DTP*348 Segment
        ,drvDTP00_DateTime_348 = 'DTP' 
        ,drvDTP01_DateTimeQualifier_348 = '348' 
        ,drvDTP02_DateTimeFormatQual_348 = 'D8' 
        ,drvDTP03_DateTimePeriod_348 = dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate) 
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
        ,drvREF00_RefNumberQual1 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN 'REF' END
        ,drvREF01_RefNumberQual1 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '1L' END
        ,drvREF02_RefNumberQual1 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN 'CM10000069' END
        -- If drvREF01_RefNumberQual2 is Populated, then send REF Segment
        ,drvREF00_RefNumberQual2 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        ,drvREF01_RefNumberQual2 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        ,drvREF02_RefNumberQual2 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        -- If drvAMT00_AmountQualifierCode1 is Populated, then Send AMT Segment
        ,drvAMT00_AmountQualifierCode1 = CASE WHEN BdmDedCode IN ('VLIFE', 'VLIFC', 'VLIFS') THEN 'AMT' END
		--CASE WHEN VLIFC_DedCode IS NOT NULL THEN 'AMT' END
        ,drvAMT01_AmountQualifierCode1 = CASE WHEN BdmDedCode IN ('VLIFE', 'VLIFC', 'VLIFS') THEN 'P3' END
		--'P3'
        ,drvAMT02_MonetaryAmount1 = CASE WHEN BdmDedCode IN ('VLIFE', 'VLIFC', 'VLIFS') THEN BdmUSGField1 END --CASE WHEN VLIFC_DedCode IS NOT NULL THEN /*EedEOIDesiredAmt*/ VLIFC_EOIDesiredAmt  END --EedEOIDesiredAmt
        -- If drvAMT00_AmountQualifierCode2 is Populated, then Send AMT Segment
        ,drvAMT00_AmountQualifierCode2 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        ,drvAMT01_AmountQualifierCode2 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        ,drvAMT02_MonetaryAmount2 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        ,drvIDC00_Code = 'IDC'
        ,drvIDC01_PlanCoverageDescription =	CASE WHEN BdmDedCode = 'ERSTD' THEN 'STD-SAL'
												WHEN BdmDedCode = 'ERLIF' THEN 'Life-Flat'
												WHEN BdmDedCode = 'EDLIF' THEN 'Dep Fam'
												WHEN BdmDedCode = 'VLIFE' THEN 'SUPP Life-Flat'
												WHEN BdmDedCode = 'VLIFS' THEN 'Dep Spouse'
												WHEN BdmDedCode = 'VLIFC' THEN 'Dep Child'
												WHEN BdmDedCode = 'ERLTD' THEN 'LTD'
												WHEN BdmDedCode = 'ERLIF' THEN 'AD&D-Flat'
											END
		 /*CASE WHEN BdmDedCode IN ('ERSTD') THEN 'STD-SAL'
                                                WHEN BdmDedCode IN ('GTLIF') THEN 'Life-Flat'
                                                WHEN BdmDedCode IN ('EDLIF') THEN 'Dep Fam'
                                                WHEN BdmDedCode IN ('VLIF') THEN 'SUPP Life-Flat'
                                                WHEN BdmDedCode IN ('VLIFS') THEN 'Dep Spouse'
                                                WHEN BdmDedCode IN ('VLIFC') THEN 'Dep Child'
                                                WHEN BdmDedCode IN ('ERLTD') THEN 'LTD'
                                            END*/
                                            /*CASE WHEN BdmDedCode IN ('ERSTD') THEN 'STD'
                                                WHEN BdmDedCode IN ('GTLIF','EDLIF','VLIF','VLIFS','VLIFC') THEN 'AG'
                                                WHEN BdmDedCode IN ('ERLTD') THEN 'LTD'
                                            END*/
        ,drvIDC02_IdentificationCardTypeCode = 'H'
        --=====================
        -- Loop 2700 RECORDS 
        --=================== ==
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
                      + BdmDedCode /*CASE BdmDedType
                             WHEN 'MED' THEN '1'
                             WHEN 'DEN' THEN '2'
                             WHEN 'VIS' THEN '3'
                             ELSE '9'
                      END*/
    INTO dbo.U_EANTHLNDEX_DrvTbl_2300
    FROM dbo.U_EANTHLNDEX_EELIST WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.U_dsi_bdm_EANTHLNDEX WITH (NOLOCK)
        ON BdmEEID = xEEID
        AND BdmCOID = xCOID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
	LEFT JOIN (
			SELECT EedEEID, EedCOID, EedEOIDesiredAmt AS VLIFC_EOIDesiredAmt 
			FROM dbo.EmpDed WITH (NOLOCK)
			WHERE EedDedCode = 'VLIFC') AS X
			ON EedEEID = xEEID
		AND EedCOID = xCOID
	JOIN (
			SELECT BdmEEID AS VCEEID
				,BdmCOID AS VCCOID
				,MAX(CASE WHEN BdmDedCode = 'VLIFC' THEN BdmDedCode END) AS VLIFC_DedCode
				FROM dbo.U_dsi_bdm_EANTHLNDEX WITH (NOLOCK) 
--			where BdmEEID = 'D25CRW000030'
			GROUP BY BdmEEID, BdmCOID) AS VLIFCDed
		ON VCEEID = xEEID
		AND VCCOID = xCOID
	;



/*	INSERT INTO dbo.U_EANTHLNDEX_DrvTbl_2300
	SELECT DISTINCT 
		drvHD00_HealthCoverage = 'HD'
        ,drvHD01_MaintTypeCode = '030' --Audit or Compare
        ,drvHD02_MaintReasonCode = ''
        ,drvHD03_InsuranceLineCode = 'AD&D-Flat'
        ,drvHD04_PlanCoverageDesc = '01'
        ,drvHD05_CoverageLevelCode = 'EMP' 
        -- If drvDTP00_DateTime_348 Populated, then send DTP*348 Segment
        ,drvDTP00_DateTime_348 = '' 
        ,drvDTP01_DateTimeQualifier_348 
        ,drvDTP02_DateTimeFormatQual_348 
        ,drvDTP03_DateTimePeriod_348 
        -- If drvDTP00_DateTime_349 Populated, then send DTP*349 Segment
        ,drvDTP00_DateTime_349 = ''
        ,drvDTP01_DateTimeQualifier_349 
        ,drvDTP02_DateTimeFormatQual_349
        ,drvDTP03_DateTimePeriod_349 
        -- If drvDTP00_DateTime_303 = 'DTP', then Send DTP*303 Segment
        ,drvDTP00_DateTime_303 = ''
        ,drvDTP01_DateTimeQualifier_303 
        ,drvDTP02_DateTimeFormatQual_303
        ,drvDTP03_DateTimePeriod_303 
        -- If drvREF00_RefNumberQual1 is Populated, then send REF Segment
        ,drvREF00_RefNumberQual1 = ''
        ,drvREF01_RefNumberQual1 
        ,drvREF02_RefNumberQual1 
        -- If drvREF01_RefNumberQual2 is Populated, then send REF Segment
        ,drvREF00_RefNumberQual2 = ''
        ,drvREF01_RefNumberQual2 
        ,drvREF02_RefNumberQual2 
        -- If drvAMT00_AmountQualifierCode1 is Populated, then Send AMT Segment
        ,drvAMT00_AmountQualifierCode1 = ''
        ,drvAMT01_AmountQualifierCode1 
        ,drvAMT02_MonetaryAmount1 
        -- If drvAMT00_AmountQualifierCode2 is Populated, then Send AMT Segment
        ,drvAMT00_AmountQualifierCode2 = ''
        ,drvAMT01_AmountQualifierCode2 
        ,drvAMT02_MonetaryAmount2 
        ,drvIDC00_Code = ''
        ,drvIDC01_PlanCoverageDescription 
        ,drvIDC02_IdentificationCardTypeCode 
        --=====================
        -- Loop 2700 RECORDS 
        --=================== ==
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
        ,drvREF02_RefNumberDesc 
        -- If drvLE01_LoopIDCode is Populated, then send LE Segment
        ,drvLE01_LoopIDCode = ''
        ---------------------------------
        ,drvEEID 
        ,drvCOID 
        ,drvDepRecID = ConSystemID
        ,drvSSN 
        ,drvInitialSort --= RTRIM(EepSSN)
        ,drvSubSort 
	FROM dbo.U_EANTHLNDEX_DrvTbl_2300
	JOIN dbo.U_dsi_bdm_EANTHLNDEX WITH (NOLOCK)
        ON BdmEEID = drvEEID
        AND BdmCOID = drvCOID
	LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = drvEEID
        AND ConSystemID = BdmDepRecID
	WHERE BdmDedCode = 'ERLTD';
	*/




    /**************************************************************************************************
        TRAILER RECORDS
            - SE, GE, IEA Segments
    **************************************************************************************************/

    DECLARE @SEGMENTCOUNT AS INT;

    SELECT @SEGMENTCOUNT = (SELECT COUNT(*) FROM dbo.U_EANTHLNDEX_DrvTbl_2300) + (SELECT COUNT(*) FROM dbo.U_EANTHLNDEX_DrvTbl)
    ---------------------
    -- TRAILER RECORD
    --------------------
    IF OBJECT_ID('U_EANTHLNDEX_TrlTbl') IS NOT NULL
        DROP TABLE dbo.U_EANTHLNDEX_TrlTbl;
    SELECT DISTINCT drvSE01_SegmentCount = '9999' -- FORMAT(@SEGMENTCOUNT, '#') -- '9999'
    INTO dbo.U_EANTHLNDEX_TrlTbl;

    UPDATE dbo.U_EANTHLNDEX_HdrTbl SET drvQTY02_Quantity1 = FORMAT(@SEGMENTCOUNT, '#');

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable('EANTHLNDEX','UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = 'KLE1001_EANTHLNDEX_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
        WHERE FormatCode = 'EANTHLNDEX';
    END;

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEANTHLNDEX_Export AS
    SELECT TOP 20000000 DATA FROM dbo.U_EANTHLNDEX_File (NOLOCK)
    ORDER BY CASE LEFT(Recordset,1) WHEN 'H' THEN 1 WHEN 'D' THEN 2 ELSE 3 END, InitialSort, SubSort, RIGHT(Recordset,2)
GO

--Check out AscDefF
SELECT * FROM dbo.AscDef
WHERE AdfHeaderSystemID LIKE 'EANTHLNDEX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET ExpLastStartPerControl = '201810011'
       ,ExpStartPerControl     = '201810011'
       ,ExpLastEndPerControl   = '201810019'
       ,ExpEndPerControl       = '201810019'
WHERE ExpFormatCode = 'EANTHLNDEX';

**********************************************************************************/
