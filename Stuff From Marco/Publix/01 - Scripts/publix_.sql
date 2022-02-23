USE [ULTIPRO_WPPEFCU]
GO
/****** Object:  StoredProcedure [dbo].[dsi_sp_BuildDriverTables_EPRIPFC834]    Script Date: 10/10/2019 2:03:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EPRIPFC834] 
    @systemid CHAR(12) 
AS 
SET NOCOUNT ON; 
/********************************************************************************** 
Client: Publix Employees Federal Credit Union 
 
Created By: Marco Lagrosa 
Business Analyst: Lea King 
Create Date: 10/07/2019 
Service Request Number: TekP-2019-08-14-0002 
 
Purpose: Principal 834 Export 
 
Revision History 
---------------- 
Update By           Date           Request Num        Desc 
XXXX                XX/XX/20XX     SR-20XX-000XXXXX   XXXXX 
 
SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EPRIPFC834'; 
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EPRIPFC834'; 
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EPRIPFC834'; 
SELECT * FROM dbo.AscExp WHERE expFormatCode = 'EPRIPFC834'; 
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EPRIPFC834' ORDER BY RunID DESC; 
 
Execute Export 
-------------- 
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPRIPFC834', 'FULLFILE'; 
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPRIPFC834', 'CHANGES'; 
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPRIPFC834', 'OEPASSIVE'; 
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPRIPFC834', 'OEACTIVE'; 
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPRIPFC834', 'SCHEDULED'; 
 
EXEC dbo.dsi_BDM_sp_ErrorCheck 'EPRIPFC834'; 
 
EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EPRIPFC834', @AllObjects = 'Y', @IsWeb = 'Y'; 
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
        ,@FileMinCovDate  = CAST('12/01/2018' AS date) 
    FROM dbo.U_dsi_Parameters WITH (NOLOCK) 
    WHERE FormatCode = 'EPRIPFC834'; 
 
    --========================================== 
    -- Deduction Code List 
    --========================================== 
    DECLARE @DedList VARCHAR(MAX); 
    SET @DedList = 'GLIFE,LIFEE,LIFES,LIFEC,STD,LTD,DEN,DEN2,VIS'; 
 
    IF OBJECT_ID('U_EPRIPFC834_DedList','U') IS NOT NULL 
        DROP TABLE dbo.U_EPRIPFC834_DedList; 
    SELECT DedCode = DedDedCode 
        ,DedLongDesc 
        ,DedType = DedDedType 
    INTO dbo.U_EPRIPFC834_DedList 
    FROM dbo.dsi_BDM_fn_ListToTable(@DedList) 
    JOIN dbo.DedCode WITH (NOLOCK) 
        ON DedDedCode = Item; 
 
    --========================================== 
    -- Clean EE List 
    --========================================== 
 
    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company 
    DELETE FROM dbo.U_EPRIPFC834_EEList 
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCoID(xEEID) 
    AND xEEID IN (SELECT xEEID FROM dbo.U_EPRIPFC834_EEList GROUP BY xEEID HAVING COUNT(1) > 1); 
 
    -- Remove Employees that Do Not Have a Benefit Plan in Deduction Code List 
    DELETE FROM dbo.U_EPRIPFC834_EEList 
    WHERE NOT EXISTS (SELECT 1 FROM dbo.EmpDed JOIN dbo.U_EPRIPFC834_DedList ON DedCode = EedDeDCode WHERE EedEEID = xEEID); 
 
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
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS,DP'); 
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL,DPC,STC'); 
    --INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','@DomPartnerCSV'); 
 
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
    FROM dbo.U_dsi_bdm_EPRIPFC834 D 
    JOIN dbo.U_dsi_bdm_EPRIPFC834 E 
        ON E.BdmEEID = D.BdmEEID 
        AND E.BdmCOID = D.BdmCOID 
        AND E.BdmDedCode = D.BdmDedCode 
    WHERE D.BdmRecType = 'DEP' AND E.BdmRecType = 'EMP'; 
 
    --===================================================== 
    -- Update BdmUSGField2 with EmpDedTVID for Employees 
    --===================================================== 
    UPDATE dbo.U_dsi_bdm_EPRIPFC834 
        SET BdmUSGField2 = EedEmpDedTVID 
    FROM dbo.U_dsi_bdm_EPRIPFC834 
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK) 
        ON EedEEID = BdmEEID 
        AND EedCOID = BdmCOID 
        AND EedDedCode = BdmDedCode 
    WHERE BdmRecType = 'EMP' AND EedFormatCode = @FormatCode AND EedValidForExport = 'Y'; 
 
    --======================================================= 
    -- Update BdmUSGField2 with DepBPlanTVID for Dependents 
    --======================================================= 
    UPDATE dbo.U_dsi_bdm_EPRIPFC834 
        SET BdmUSGField2 = DbnDepBPlanTVID 
    FROM dbo.U_dsi_bdm_EPRIPFC834 
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK) 
        ON DbnEEID = BdmEEID 
        AND DbnCOID = BdmCOID 
        AND DbnDedCode = BdmDedCode 
    WHERE BdmRecType = 'DEP' AND DbnFormatCode = @FormatCode AND DbnValidForExport = 'Y'; 
 
    --====================================================== 
    -- Update BdmUSGField1 with Benefit Amount (EedBenAmt) 
    --====================================================== 
    UPDATE dbo.U_dsi_bdm_EPRIPFC834 
        SET BdmUSGField1 = CONVERT(VARCHAR(20),EedBenAmt) 
    FROM dbo.U_dsi_bdm_EPRIPFC834 
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
    IF OBJECT_ID('U_EPRIPFC834_HdrTbl','U') IS NOT NULL 
        DROP TABLE dbo.U_EPRIPFC834_HdrTbl; 
    SELECT DISTINCT drvISA05_SenderIDQual = '30' 
        ,drvISA06_SenderID = '590815534' 
        ,drvISA07_ReceiverIDQual = '30' 
        ,drvISA08_ReceiverID = '42-0127290' 
        ,drvISA09_InterchangeDate = RIGHT(@RunDate,6) 
        ,drvISA10_InterchangeTime = @RunTime 
        ,drvISA15_UsageIndicator = CASE dbo.dsi_fnVariable(@FormatCode,'Testing') WHEN 'Y' THEN 'T' ELSE 'P' END 
        ,drvGS02_SenderID = '590815534' 
        ,drvGS03_ReceiverID = '42-0127290' 
        ,drvGS04_Date = @RunDate 
        ,drvGS05_Time = @RunTime 
        ,drvBGN03_Date = @RunDate 
        ,drvBGN04_Time = @RunTime 
        ,drvBGN05_TimeCode = '' 
        ,drvBGN06_RefID = '' 
        ,drvBGN07_TransTypeCode = '' 
        ,drvBGN08_ActionCode = '4' 
        ,drvREF01_RefNumberQual = '38' 
        ,drvREF02_RefNumberQual = '1103198' 
        ,drvQTY01_QuantityQual1 = '' 
        ,drvQTY02_Quantity1 = '' 
        ,drvQTY01_QuantityQual2 = '' 
        ,drvQTY02_Quantity2 = '' 
        ,drvQTY01_QuantityQual3 = '' 
        ,drvQTY02_Quantity3 = '' 
        ,drvN101_EntityIDCodeSponsor1 = 'P5' 
        ,drvN102_Name1 = 'PUBLIX EMPLOYEES FEDERAL CREDIT UNION' 
        ,drvN103_IDCodeQual1 = 'FI' 
        ,drvN104_IDCode1 = '590815534' 
        ,drvN101_EntityIDCodeSponsor2 = 'IN' 
        ,drvN102_Name2 = 'Principal Financial Group' 
        ,drvN103_IDCodeQual2 = 'FI' 
        ,drvN104_IDCode2 = '42-0127290' 
    INTO dbo.U_EPRIPFC834_HdrTbl 
    FROM dbo.U_EPRIPFC834_EELIST WITH (NOLOCK) 
    JOIN dbo.U_dsi_bdm_EPRIPFC834 WITH (NOLOCK) 
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
    IF OBJECT_ID('U_EPRIPFC834_DrvTbl','U') IS NOT NULL 
        DROP TABLE dbo.U_EPRIPFC834_DrvTbl; 
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
                                                CASE WHEN ConRelationship IN ('SPS','DP') THEN '01' 
                                                     WHEN ConRelationship IN ('CHL','DPC','STC') THEN '19' 
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
                                                     WHEN EecFullTimeOrPartTime = 'F' THEN 'FT' --Full time active employee 
                                                     WHEN EecFullTimeOrPartTime = 'P' THEN 'PT' --Part time active employee 
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
        ,drvREF01_RefNumberQual1 = '1L' 
        ,drvREF02_RefNumberQual1 = '1103198' 
        -- If drvREF01_RefNumberQual2 is Populated, then send REF Segment 
        ,drvREF01_RefNumberQual2 = '' 
        ,drvREF02_RefNumberQual2 = '' 
        -- If drvDTP00_DateTime1 is Populated, then send DTP Segment 
        ,drvDTP00_DateTime1 = '' 
        ,drvDTP01_DateTimeQualifier1 = '' 
        ,drvDTP02_DateTimeFormatQual1 = '' 
        ,drvDTP03_DateTimePeriod1 = '' 
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
        ,drvNM107_NameSuffix1 = CASE WHEN BdmRecType = 'EMP' THEN EepNameSuffix 
                                     WHEN BdmRecType = 'DEP' THEN ConNameSuffix 
                                END 
        ,drvNM108_IDCodeQualifier1 = CASE WHEN BdmRecType = 'EMP' AND ISNULL(EepSSN, '') <> '' THEN '34' 
                                          WHEN BdmRecType = 'DEP' AND ISNULL(ConSSN, '') <> '' THEN '34' 
                                     END 
        ,drvNM109_IDCode1 = CASE WHEN BdmRecType = 'EMP' AND ISNULL(EepSSN, '') <> '' THEN EepSSN 
                                 WHEN BdmRecType = 'DEP' AND ISNULL(ConSSN, '') <> '' THEN ConSSN 
                            END 
        ,drvPER02_Name = '' 
        ,drvPER03_CommNumberQualifier = CASE WHEN BdmRecType = 'EMP' THEN '' END 
        ,drvPER04_CommunicationNumber = CASE WHEN BdmRecType = 'EMP' THEN ISNULL(EepPhoneHomeNumber,'') END 
        ,drvPER05_CommNumberQualifier = CASE WHEN BdmRecType = 'EMP' THEN '' END 
        ,drvPER06_CommunicationNumber = CASE WHEN BdmRecType = 'EMP' THEN ISNULL(EecPhoneBusinessNumber,'') END 
        ,drvPER07_CommNumberQualifier = CASE WHEN BdmRecType = 'EMP' THEN '' END 
        ,drvPER08_CommunicationNumber = CASE WHEN BdmRecType = 'EMP' THEN ISNULL(eepAddressEMail,'') END 
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
        ,drvDMG04_MaritalStatusCode1 = CASE WHEN BdmRecType = 'EMP' THEN 
                                                CASE EepMaritalStatus WHEN 'M' THEN 'M' ELSE 'I' END 
                                       END 
        --If drvICM01_FrequencyCode is Populated, then send ICM Segment 
        ,drvICM01_FrequencyCode = CASE WHEN BdmRecType = 'EMP' THEN '7' END --'7' 
        ,drvICM02_MonetaryAmount = CASE WHEN BdmRecType = 'EMP' THEN CONVERT(MONEY,EecAnnSalary) END 
        ,drvICM03_Quantity = CASE WHEN BdmRecType = 'EMP' THEN CONVERT(MONEY,EecScheduledWorkHrs) END 
        ,drvICM04_LocationID = CASE WHEN BdmRecType = 'EMP' THEN 
                                        CASE WHEN YEAR(EecDateOfLastHire) = YEAR(GETDATE()) THEN CONVERT(VARCHAR(8),EecDateOfLastHire,112) 
                                            ELSE CONVERT(CHAR(4),YEAR(GETDATE())) + '0101' 
                                        END 
                               END 
        -- If drvAMT00_AmountQualifierCode1 = 'AMT' is Populated, then Send AMT Segment 
        ,drvAMT00_SegmentID1 = '' 
        ,drvAMT01_AmountQualifierCode1 = CASE WHEN BdmDedCode in ('GLIFE','LIFEE','LIFES','LIFEC') THEN 'A2' END
        ,drvAMT02_MonetaryAmount1 = CASE WHEN BdmDedCode in ('GLIFE','LIFEE','LIFES','LIFEC') THEN 
						(select top 1 eedbenamt  from empded where eeddedcode in  (BdmDedCode) and eedeeid in (bdmeeid) and eedcoid in (bdmcoid))
				 END
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
    INTO dbo.U_EPRIPFC834_DrvTbl 
    FROM dbo.U_EPRIPFC834_EELIST WITH (NOLOCK) 
    JOIN dbo.EmpPers WITH (NOLOCK) 
        ON EepEEID = xEEID 
    JOIN dbo.EmpComp WITH (NOLOCK) 
        ON EecEEID = xEEID 
        AND EecCOID = xCOID 
    JOIN dbo.Location WITH (NOLOCK) 
        ON LocCode = EecLocation 
    JOIN dbo.U_dsi_bdm_EPRIPFC834 WITH (NOLOCK) 
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
    IF OBJECT_ID('U_EPRIPFC834_DrvTbl_2300','U') IS NOT NULL 
        DROP TABLE dbo.U_EPRIPFC834_DrvTbl_2300; 
    SELECT DISTINCT 
        -- If drvHD00_HealthCoverage Populated, then send HD Segment 
        drvHD00_HealthCoverage = CASE WHEN BdmDedCode IN ('DEN','DEN2','VIS','STD','LTD','GLIFE','LIFEE','LIFES','LIFEC') THEN 'HD'  END 
        ,drvHD01_MaintTypeCode = '030' --Audit or Compare 
        ,drvHD02_MaintReasonCode = CASE WHEN BdmDedType IN ('MED') THEN '' 
                                           WHEN BdmDedType IN ('DEN') THEN '' 
                                           WHEN BdmDedType IN ('VIS') THEN '' 
                                     END 
        ,drvHD03_InsuranceLineCode = CASE WHEN BdmDedCode  IN ('DEN','DEN2') THEN 'DEN' 
                                           WHEN BdmDedCode IN ('VIS') THEN 'VIS' 
                                           WHEN BdmDedCode IN ('STD') THEN 'STD' 
                                           WHEN BdmDedCode IN ('LTD') THEN 'LTD' 
                                           WHEN BdmDedCode IN ('GLIFE') THEN 'BLF' 
                                           WHEN BdmDedCode IN ('LIFEE') THEN 'EVL' 
                                           WHEN BdmDedCode IN ('LIFES') THEN 'SVL' 
                                           WHEN BdmDedCode IN ('LIFEC') THEN 'CVL' 
                                     END 
        ,drvHD04_PlanCoverageDesc = CASE WHEN BdmDedCode IN ('DEN') THEN '2' 
                                           WHEN BdmDedCode IN ('LTD') AND EecDedGroupCode IN ('FTSVP') THEN '2' 
                                           ELSE '1' 
                                     END 
        ,drvHD05_CoverageLevelCode = ''
				/*CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN 
                                                CASE WHEN BdmBenOption IN ('@EEBenOpts') THEN 'EMP' 
                                                     WHEN BdmBenOption IN ('@ESPBenOpts') THEN 'ESP' 
                                                     WHEN BdmBenOption IN ('@ECHBenOpts') THEN 'ECH' 
                                                     WHEN BdmBenOption IN ('@EEFAMBenOpts') THEN 'FAM' 
                                                END 
                                     END
				*/ 
        -- If drvDTP00_DateTime_348 Populated, then send DTP*348 Segment 
        ,drvDTP00_DateTime_348 =   CASE WHEN BdmDedCode IN ('DEN','DEN2','VIS','STD','LTD','GLIFE','LIFEE','LIFES','LIFEC') THEN 'DTP' END 
        ,drvDTP01_DateTimeQualifier_348 =  CASE WHEN BdmDedCode IN ('DEN','DEN2','VIS','STD','LTD','GLIFE','LIFEE','LIFES','LIFEC') THEN '348' END 
        ,drvDTP02_DateTimeFormatQual_348 =  CASE WHEN BdmDedCode IN ('DEN','DEN2','VIS','STD','LTD','GLIFE','LIFEE','LIFES','LIFEC') THEN 'D8' END 
        ,drvDTP03_DateTimePeriod_348 =  CASE WHEN BdmDedCode IN ('DEN','DEN2','VIS','STD','LTD','GLIFE','LIFEE','LIFES','LIFEC') THEN dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate) END 
        -- If drvDTP00_DateTime_349 Populated, then send DTP*349 Segment 
        ,drvDTP00_DateTime_349 =  CASE WHEN BdmDedCode IN ('DEN','DEN2','VIS','STD','LTD','GLIFE','LIFEE','LIFES','LIFEC') AND BdmBenStopDate IS NOT NULL THEN 'DTP' END 
        ,drvDTP01_DateTimeQualifier_349 =  CASE WHEN BdmDedCode IN ('DEN','DEN2','VIS','STD','LTD','GLIFE','LIFEE','LIFES','LIFEC') AND BdmBenStopDate IS NOT NULL THEN '349' END 
        ,drvDTP02_DateTimeFormatQual_349 =  CASE WHEN BdmDedCode IN ('DEN','DEN2','VIS','STD','LTD','GLIFE','LIFEE','LIFES','LIFEC') AND BdmBenStopDate IS NOT NULL THEN 'D8' END 
        ,drvDTP03_DateTimePeriod_349 =  CASE WHEN BdmDedCode IN ('DEN','DEN2','VIS','STD','LTD','GLIFE','LIFEE','LIFES','LIFEC') THEN BdmBenStopDate END 
        -- If drvDTP00_DateTime_303 = 'DTP', then Send DTP*303 Segment 
        ,drvDTP00_DateTime_303 = CASE WHEN BdmDedCode IN ('DEN','DEN2','VIS','STD','LTD','GLIFE','LIFEE','LIFES','LIFEC') THEN 'DTP' END
        ,drvDTP01_DateTimeQualifier_303 =CASE WHEN BdmDedCode IN ('DEN','DEN2','VIS','STD','LTD','GLIFE','LIFEE','LIFES','LIFEC')  THEN '303' END
        ,drvDTP02_DateTimeFormatQual_303 = CASE WHEN BdmDedCode IN ('DEN','DEN2','VIS','STD','LTD','GLIFE','LIFEE','LIFES','LIFEC')  THEN 'D8' END
        ,drvDTP03_DateTimePeriod_303 = CASE WHEN BdmDedCode IN ('DEN','DEN2','VIS','STD','LTD','GLIFE','LIFEE','LIFES','LIFEC')  THEN 
			(SELECT top 1 min(edheffdate) from EmpHDed WITH (NOLOCK)  where  edhdedcode in(BdmDedCode) and edheeid in (bdmeeid) and edhcoid in (bdmcoid))
		 END 
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
                             WHEN 'DEN' THEN '1' 
                             WHEN 'VIS' THEN '2' 
                             WHEN 'GTL' THEN '3' 
                             WHEN 'LTD' THEN '4' 
                             WHEN 'OPC' THEN '5' 
                             WHEN 'OPS' THEN '6' 
                             WHEN 'OPT' THEN '7' 
                             WHEN 'STD' THEN '8' 
                             ELSE '9' 
                      END 
    INTO dbo.U_EPRIPFC834_DrvTbl_2300 
    FROM dbo.U_EPRIPFC834_EELIST WITH (NOLOCK) 
    JOIN dbo.EmpPers WITH (NOLOCK) 
        ON EepEEID = xEEID 
    JOIN dbo.EmpComp WITH (NOLOCK) 
        ON EecEEID = xEEID 
        AND EecCOID = xCOID 
    JOIN dbo.U_dsi_bdm_EPRIPFC834 WITH (NOLOCK) 
        ON BdmEEID = xEEID 
        AND BdmCOID = xCOID 
    LEFT JOIN dbo.Contacts WITH (NOLOCK) 
        ON ConEEID = xEEID 
        AND ConSystemID = BdmDepRecID


	/*
	 Added logic to duplicate the 2300 Rows for BLF, EVL, SVL to add ADD,EVA and SVA HDO3 row
	

	INSERT INTO U_EPRIPFC834_DrvTbl_2300
 SELECT 
        drvHD00_HealthCoverage
        ,drvHD01_MaintTypeCode
        ,drvHD02_MaintReasonCode 
        ,drvHD03_InsuranceLineCode  = CASE WHEN drvHD03_InsuranceLineCode IN ('BLF') THEN 'ADD'
										  WHEN drvHD03_InsuranceLineCode IN ('EVL') THEN 'EVA'
										  WHEN drvHD03_InsuranceLineCode IN ('SVL') THEN 'SVA'
									  END
        ,drvHD04_PlanCoverageDesc
        ,drvHD05_CoverageLevelCode
        ,drvDTP00_DateTime_348 
        ,drvDTP01_DateTimeQualifier_348
        ,drvDTP02_DateTimeFormatQual_348
        ,drvDTP03_DateTimePeriod_348 
        ,drvDTP00_DateTime_349
        ,drvDTP01_DateTimeQualifier_349
        ,drvDTP02_DateTimeFormatQual_349
        ,drvDTP03_DateTimePeriod_349
        ,drvDTP00_DateTime_303
        ,drvDTP01_DateTimeQualifier_303 
        ,drvDTP02_DateTimeFormatQual_303 
        ,drvDTP03_DateTimePeriod_303 
        ,drvREF00_RefNumberQual1
        ,drvREF01_RefNumberQual1 
        ,drvREF02_RefNumberQual1
        ,drvREF00_RefNumberQual2  
        ,drvREF01_RefNumberQual2  
        ,drvREF02_RefNumberQual2  
        -- If drvAMT00_AmountQualifierCode1 is Populated, then Send AMT Segment 
        ,drvAMT00_AmountQualifierCode1  
        ,drvAMT01_AmountQualifierCode1 
        ,drvAMT02_MonetaryAmount1
        ,drvAMT00_AmountQualifierCode2
        ,drvAMT01_AmountQualifierCode2 
        ,drvAMT02_MonetaryAmount2 
        ,drvLS01_LoopIDCode 
        -- If drvLX01_AssignedNumer is Populated, then send LX Segment 
        ,drvLX01_AssignedNumber
        --===================== 
        -- Loop 2750 RECORDS 
        --===================== 
        -- If drvN101_EntityIDCodeSponsor is Populated, then send N1 Segment 
        ,drvN101_EntityIDCodeSponsor 
        ,drvN102_Name 
        -- If drvREF01_RefNumberQual is Populated, then send REF Segment 
        ,drvREF01_RefNumberQual 
        ,drvREF02_RefNumberDesc
        -- If drvLE01_LoopIDCode is Populated, then send LE Segment 
        ,drvLE01_LoopIDCode 
        --------------------------------- 
        ,drvEEID 
        ,drvCOID
        ,drvDepRecID
        ,drvSSN
        ,drvInitialSort
        ,drvSubSort = CONVERT(CHAR(9),RTRIM(drvSSN)) + CONVERT(CHAR(12),ISNULL(drvDepRecID,'')) 
                      + CASE drvHD03_InsuranceLineCode 
                             WHEN 'BLF' THEN '9' 
							 WHEN 'EVL' THEN '9' 
							 WHEN 'SVL' THEN 'X' 
                  
                      END 
		 FROM U_EPRIPFC834_DrvTbl_2300
		 where drvHD03_InsuranceLineCode in ('BLF','EVL','SVL')
		 */


 
    /************************************************************************************************** 
        TRAILER RECORDS 
            - SE, GE, IEA Segments 
    **************************************************************************************************/ 
    --------------------- 
    -- TRAILER RECORD 
    -------------------- 
    IF OBJECT_ID('U_EPRIPFC834_TrlTbl') IS NOT NULL 
        DROP TABLE dbo.U_EPRIPFC834_TrlTbl; 
    SELECT DISTINCT drvSE01_SegmentCount = '9999' 
    INTO dbo.U_EPRIPFC834_TrlTbl; 
 
    --========================================== 
    -- Set FileName 
    --========================================== 
    IF (dbo.dsi_fnVariable('EPRIPFC834','UseFileName') = 'N') 
    BEGIN 
        UPDATE dbo.U_dsi_Parameters 
            SET ExportFile = 'PEFCU_EPRIPFC834_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt' 
        WHERE FormatCode = 'EPRIPFC834'; 
    END; 
 
END; 
/********************************************************************************** 
 
--Alter the View 
ALTER VIEW dbo.dsi_vwEPRIPFC834_Export AS 
    SELECT TOP 20000000 DATA FROM dbo.U_EPRIPFC834_File (NOLOCK) 
    ORDER BY CASE LEFT(Recordset,1) WHEN 'H' THEN 1 WHEN 'D' THEN 2 ELSE 3 END, InitialSort, SubSort, RIGHT(Recordset,2) 
GO 
 
--Check out AscDefF 
SELECT * FROM dbo.AscDefFEEOnlyBenOpti 
WHERE AdfHeaderSystemID LIKE 'EPRIPFC834%' 
ORDER BY AdfSetNumber, AdfFieldNumber; 
 
--Update Dates 
UPDATE dbo.AscExp 
    SET ExpLastStartPerControl = '201810011' 
       ,ExpStartPerControl     = '201810011' 
       ,ExpLastEndPerControl   = '201810019' 
       ,ExpEndPerControl       = '201810019' 
WHERE ExpFormatCode = 'EPRIPFC834'; 
 
**********************************************************************************/ 
