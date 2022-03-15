USE [ULTIPRO_WPROSG]
GO
/****** Object:  StoredProcedure [dbo].[dsi_sp_BuildDriverTables_XXDCOMB834]    Script Date: 4/14/2021 9:27:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[dsi_sp_BuildDriverTables_XXDCOMB834]
    @systemid CHAR(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client: Rock Oak
 
Created By: Marco Lagrosa
Business Analyst: Cheryl Petitti
Create Date: 06/12/2020
Service Request Number: TekP-2020-04-21-0004
 
Purpose: Guardian 834 Export
 
Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/20XX     SR-20XX-000XXXXX   XXXXX
 
SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'XXDCOMB834';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'XXDCOMB834';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'XXDCOMB834';
SELECT * FROM dbo.AscExp WHERE expFormatCode = 'XXDCOMB834';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'XXDCOMB834' ORDER BY RunID DESC;
 
Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'XXDCOMB834', 'FULLFILE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'XXDCOMB834', 'CHANGES';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'XXDCOMB834', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'XXDCOMB834', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'XXDCOMB834', 'SCHEDULED';
 
EXEC dbo.dsi_BDM_sp_ErrorCheck 'XXDCOMB834';
 
EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'XXDCOMB834', @AllObjects = 'Y', @IsWeb = 'Y';
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
        ,@FileMinCovDate  = CAST('01/01/2020' as datetime)
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = 'XXDCOMB834';
 
    --==========================================
    -- Deduction Code List
    --==========================================
    DECLARE @DedList VARCHAR(MAX);
    --SET @DedList = 'SU313,SU316,DE317,DE312,BA630,BA651,SU283,SU288,SU293,SU298,LO502,V1782';
    SET @DedList = 'SU313,SU318,DE317,DE312,BA630,BA651,SU283,SU288,SU293,SU298,LO502,VI782';
 
    IF OBJECT_ID('U_XXDCOMB834_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_XXDCOMB834_DedList;
    SELECT DedCode = DedDedCode
        ,DedLongDesc
        ,DedType = DedDedType
    INTO dbo.U_XXDCOMB834_DedList
    FROM dbo.dsi_BDM_fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;
 
    --==========================================
    -- Clean EE List
    --==========================================
 
    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_XXDCOMB834_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCoID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_XXDCOMB834_EEList GROUP BY xEEID HAVING COUNT(1) > 1);
 
    -- Remove Employees that Do Not Have a Benefit Plan in Deduction Code List
    DELETE FROM dbo.U_XXDCOMB834_EEList
    WHERE NOT EXISTS (SELECT 1 FROM dbo.EmpDed JOIN dbo.U_XXDCOMB834_DedList ON DedCode = EedDeDCode WHERE EedEEID = xEEID);
 
    DELETE FROM  dbo.U_XXDCOMB834_EEList where xEEID IN (
        SELECT DISTINCT EecEEID FROM dbo.EmpComp WITH (NOLOCK) WHERE EecEeType IN ('TES')
    )
 
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
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS,S17,DP');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsChild','DPC,DEP,CHL,DIS,STC');
    -- I'm not sure this line is needed for this client, so I'm taking it out for now - JCB
    --INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'DependentBenefitAgeGradedRate','LIFEE,LIFEC,LIFES,CI');
 
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
 
    INSERT INTO dbo.U_dsi_bdm_XXDCOMB834 (BdmRecType,BdmCOID,BdmEEID,BdmDepRecID,BdmSystemID,BdmRunID,BdmDedRowStatus,BdmRelationship,BdmDateOfBirth,BdmDedCode,BdmDedType,BdmBenOption,BdmBenStatus,BdmBenStartDate,BdmBenStopDate,BdmBenStatusDate,BdmBenOptionDate,BdmChangeReason,BdmStartDate,BdmStopDate,BdmIsCobraCovered,BdmCobraReason,BdmDateOfCOBRAEvent,BdmIsPQB,BdmIsChildOldest,BdmUSGField1,BdmUSGField2,BdmUSGDate1,BdmUSGDate2,BdmTVStartDate,BdmSessionID,BdmEEAmt,BdmEECalcRateOrPct,BdmEEGoalAmt,BdmEEMemberOrCaseNo,BdmERAmt,BdmNumSpouses,BdmNumChildren,BdmNumDomPartners,BdmNumDPChildren)
    SELECT DISTINCT 'DEP', BdmCOID, BdmEEID, ConSystemId, BdmSystemId, BdmRunId, BdmDedRowStatus, ConRelationship, ConDateOfBirth, BdmDedCode, BdmDedType, BdmBenOption, BdmBenStatus, BdmBenStartDate, BdmBenStopDate, BdmBenStatusDate, BdmBenOptionDate, BdmChangeREason, BdmStartDate, BdmStopDate, BdmIsCobraCovered, BdmCobraReason, BdmDateOfCOBRAEvent, BdmIsPQB, BdmIsChildOldest, BdmUSGField1, BdmUSGField2, BdmUSGDate1, BdmUSGDate2, BdmTVStartDate, BdmSessionID, BdmEEAmt, BdmEECalcRateOrPct, BdmEEGoalAmt, BdmEEMemberOrCaseNo, BdmERAmt, BdmNumSpouses, BdmNumChildren, BdmNumDomPartners, BdmNumDPChildren
    FROM dbo.U_dsi_bdm_XXDCOMB834 WITH (NOLOCK)
    JOIN Contacts WITH (NOLOCK)
        ON BdmEEID = ConEEID
        --AND ConSystemId = BfpConRecID
    JOIN dbo.EmpDedFull WITH (NOLOCK)
        ON EedDepRecId = ConSystemId
        AND EedBenStatus = 'A'
        --AND  EedDedCode = 'SU298'
    JOIN dbo.U_XXDCOMB834_EELIST WITH (NOLOCK)
        ON xEEID = BdmEEID
    WHERE BdmDedCode = 'SU298'
        AND ConRelationship IN ('SPS','DP');
 
    /*
    INSERT INTO dbo.U_dsi_bdm_XXDCOMB834 (BdmRecType,BdmCOID,BdmEEID,BdmDepRecID,BdmSystemID,BdmRunID,BdmDedRowStatus,BdmRelationship,BdmDateOfBirth,BdmDedCode,BdmDedType,BdmBenOption,BdmBenStatus,BdmBenStartDate,BdmBenStopDate,BdmBenStatusDate,BdmBenOptionDate,BdmChangeReason,BdmStartDate,BdmStopDate,BdmIsCobraCovered,BdmCobraReason,BdmDateOfCOBRAEvent,BdmIsPQB,BdmIsChildOldest,BdmUSGField1,BdmUSGField2,BdmUSGDate1,BdmUSGDate2,BdmTVStartDate,BdmSessionID,BdmEEAmt,BdmEECalcRateOrPct,BdmEEGoalAmt,BdmEEMemberOrCaseNo,BdmERAmt,BdmNumSpouses,BdmNumChildren,BdmNumDomPartners,BdmNumDPChildren)
    SELECT 'DEP', BdmCOID, BdmEEID, BfpConRecID, BdmSystemId, BdmRunId, BdmDedRowStatus, ConRelationship, ConDateOfBirth, BdmDedCode, BdmDedType, BdmBenOption, BdmBenStatus, BdmBenStartDate, BdmBenStopDate, BdmBenStatusDate, BdmBenOptionDate, BdmChangeREason, BdmStartDate, BdmStopDate, BdmIsCobraCovered, BdmCobraReason, BdmDateOfCOBRAEvent, BdmIsPQB, BdmIsChildOldest, BdmUSGField1, BdmUSGField2, BdmUSGDate1, BdmUSGDate2, BdmTVStartDate, BdmSessionID, BdmEEAmt, BdmEECalcRateOrPct, BdmEEGoalAmt, BdmEEMemberOrCaseNo, BdmERAmt, BdmNumSpouses, BdmNumChildren, BdmNumDomPartners, BdmNumDPChildren
    FROM dbo.U_dsi_bdm_XXDCOMB834 WITH (NOLOCK)
    JOIN BnfBPLan WITH (NOLOCK)
        ON BdmEEID = BfpEEID
        AND BfpDedCode = BdmDedCode
        AND BfpStatus = 'A'
        AND BfpDedCode IN ('SU288','SU283')
    JOIN Contacts WITH (NOLOCK)
        ON BdmEEID = ConEEID
        AND ConSystemId = BfpConRecID
        ;
    */
 
    /*
    INSERT INTO dbo.U_dsi_bdm_XXDCOMB834 (BdmRecType,BdmCOID,BdmEEID,BdmDepRecID,BdmSystemID,BdmRunID,BdmDedRowStatus,BdmRelationship,BdmDateOfBirth,BdmDedCode,BdmDedType,BdmBenOption,BdmBenStatus,BdmBenStartDate,BdmBenStopDate,BdmBenStatusDate,BdmBenOptionDate,BdmChangeReason,BdmStartDate,BdmStopDate,BdmIsCobraCovered,BdmCobraReason,BdmDateOfCOBRAEvent,BdmIsPQB,BdmIsChildOldest,BdmUSGField1,BdmUSGField2,BdmUSGDate1,BdmUSGDate2,BdmTVStartDate,BdmSessionID,BdmEEAmt,BdmEECalcRateOrPct,BdmEEGoalAmt,BdmEEMemberOrCaseNo,BdmERAmt,BdmNumSpouses,BdmNumChildren,BdmNumDomPartners,BdmNumDPChildren)
    SELECT 'DEP', BdmCOID, BdmEEID, ConSystemId, BdmSystemId, BdmRunId, BdmDedRowStatus, ConRelationship, ConDateOfBirth, BdmDedCode, BdmDedType, BdmBenOption, BdmBenStatus, BdmBenStartDate, BdmBenStopDate, BdmBenStatusDate, BdmBenOptionDate, BdmChangeREason, BdmStartDate, BdmStopDate, BdmIsCobraCovered, BdmCobraReason, BdmDateOfCOBRAEvent, BdmIsPQB, BdmIsChildOldest, BdmUSGField1, BdmUSGField2, BdmUSGDate1, BdmUSGDate2, BdmTVStartDate, BdmSessionID, BdmEEAmt, BdmEECalcRateOrPct, BdmEEGoalAmt, BdmEEMemberOrCaseNo, BdmERAmt, BdmNumSpouses, BdmNumChildren, BdmNumDomPartners, BdmNumDPChildren
    FROM dbo.U_dsi_bdm_XXDCOMB834 WITH (NOLOCK)
    /*JOIN BnfBPLan WITH (NOLOCK)
        ON BdmEEID = BfpEEID
        AND BfpDedCode = BdmDedCode
        AND BfpStatus = 'A'
        AND BfpDedCode IN ('SU288','SU283')*/
    JOIN Contacts WITH (NOLOCK)
        ON BdmEEID = ConEEID
        --AND ConSystemId = BfpConRecID
    WHERE BdmDedCode IN ('SU293','SU298')
        AND ConRelationship IN ('SPS','DP')
        ;
    */
 
    --=========================================
    -- Update BdmChangeReason For Dependents
    --=========================================
    UPDATE D
        SET D.BdmChangeReason = E.BdmChangeReason
    FROM dbo.U_dsi_bdm_XXDCOMB834 D
    JOIN dbo.U_dsi_bdm_XXDCOMB834 E
        ON E.BdmEEID = D.BdmEEID
        AND E.BdmCOID = D.BdmCOID
        AND E.BdmDedCode = D.BdmDedCode
    WHERE D.BdmRecType = 'DEP' AND E.BdmRecType = 'EMP';
 
    --=====================================================
    -- Update BdmUSGField2 with EmpDedTVID for Employees
    --=====================================================
    UPDATE dbo.U_dsi_bdm_XXDCOMB834
        SET BdmUSGField2 = EedEmpDedTVID
    FROM dbo.U_dsi_bdm_XXDCOMB834
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = BdmEEID
        AND EedCOID = BdmCOID
        AND EedDedCode = BdmDedCode
    WHERE BdmRecType = 'EMP' AND EedFormatCode = @FormatCode AND EedValidForExport = 'Y';
 
    --=======================================================
    -- Update BdmUSGField2 with DepBPlanTVID for Dependents
    --=======================================================
    UPDATE dbo.U_dsi_bdm_XXDCOMB834
        SET BdmUSGField2 = DbnDepBPlanTVID
    FROM dbo.U_dsi_bdm_XXDCOMB834
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
        ON DbnEEID = BdmEEID
        AND DbnCOID = BdmCOID
        AND DbnDedCode = BdmDedCode
    WHERE BdmRecType = 'DEP' AND DbnFormatCode = @FormatCode AND DbnValidForExport = 'Y';
 
    --======================================================
    -- Update BdmUSGField1 with Benefit Amount (EedBenAmt)
    --======================================================
    UPDATE dbo.U_dsi_bdm_XXDCOMB834
        SET BdmUSGField1 = CONVERT(VARCHAR(20),EedBenAmt)
    FROM dbo.U_dsi_bdm_XXDCOMB834
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
 
    DECLARE @FedTaxId VARCHAR(9);
 
    SELECT TOP 1 @FedTaxId = CmmFedTaxId FROM dbo.CompMast WTH (NOLOCK);
 
    -------------------
    -- HEADER RECORD
    -------------------
    IF OBJECT_ID('U_XXDCOMB834_HdrTbl','U') IS NOT NULL
        DROP TABLE dbo.U_XXDCOMB834_HdrTbl;
    SELECT DISTINCT drvISA05_SenderIDQual = '30'
        ,drvISA06_SenderID = @FedTaxId
        ,drvISA07_ReceiverIDQual = '30'
        ,drvISA08_ReceiverID = '135123390'
        ,drvISA09_InterchangeDate = RIGHT(@RunDate,6)
        ,drvISA10_InterchangeTime = @RunTime
        ,drvISA15_UsageIndicator = CASE dbo.dsi_fnVariable(@FormatCode,'Testing') WHEN 'Y' THEN 'T' ELSE 'P' END
        ,drvGS02_SenderID = @FedTaxId
        ,drvGS03_ReceiverID = '135123390'
        ,drvGS04_Date = @RunDate
        ,drvGS05_Time = @RunTime
        ,drvBGN03_Date = @RunDate
        ,drvBGN04_Time = @RunTime
        ,drvBGN05_TimeCode = 'ES'
        ,drvBGN06_RefID = ''
        ,drvBGN07_TransTypeCode = ''
        ,drvBGN08_ActionCode = 'RX'
        ,drvREF01_RefNumberQual = '38'
        ,drvREF02_RefNumberQual = '00569179'
        ,drvDTP00_DateTime0 = 'DTP'
        ,drvDTP01_DateTimeQualifier0 = '007'
        ,drvDTP02_DateTimeFormatQual0 = 'D8'
        ,drvDTP03_DateTimePeriod0 = GETDATE()
        ,drvQTY01_QuantityQual1 = ''
        ,drvQTY02_Quantity1 = ''
        ,drvQTY01_QuantityQual2 = ''
        ,drvQTY02_Quantity2 = ''
        ,drvQTY01_QuantityQual3 = ''
        ,drvQTY02_Quantity3 = ''
        ,drvN101_EntityIDCodeSponsor1 = 'P5'
        ,drvN102_Name1 = 'ROCK OAK CAPITAL PARTNERS'
        ,drvN103_IDCodeQual1 = 'FI'
        ,drvN104_IDCode1 = @FedTaxId
        ,drvN101_EntityIDCodeSponsor2 = 'IN'
        ,drvN102_Name2 = 'Guardian'
        ,drvN103_IDCodeQual2 = 'FI'
        ,drvN104_IDCode2 = '135123390'
    INTO dbo.U_XXDCOMB834_HdrTbl
    FROM dbo.U_XXDCOMB834_EELIST WITH (NOLOCK)
    JOIN dbo.U_dsi_bdm_XXDCOMB834 WITH (NOLOCK)
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
    IF OBJECT_ID('U_XXDCOMB834_DrvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_XXDCOMB834_DrvTbl;
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
                                                CASE WHEN ConRelationship IN ('SPS','S17') THEN '01'
                                                    WHEN ConRelationship IN ('DP') THEN '53'
                                                     WHEN ConRelationship IN ('CHD','CHL','CHS','DCH','STC') THEN '19'
                                                     ELSE '19'
                                                END
                                     END
        ,drvINS03_MaintTypeCode = '030' --Audit or Compare
        ,drvINS04_MaintReasonCode = 'XN' --Notification Only
        ,drvINS05_BenefitStatusCode = 'A'
        ,drvINS0601_MEDICAREPLANCODE = 'E'
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
        ,drvINS17 = ''
        -- If drvREF01_RefNumberQual1 is Populated, then send REF Segment
        ,drvREF01_RefNumberQual1 = 'DX' -- '1L'
        ,drvREF02_RefNumberQual1 = LEFT(REPLACE(CASE WHEN LEFT(LocDesc, 3) = UPPER(LEFT(LocDesc, 3)) THEN LTRIM(RIGHT(LocDesc, LEN(LocDesc) -3)) ELSE LocDesc END, ' ', ''), 8)
        -- If drvREF01_RefNumberQual2 is Populated, then send REF Segment
        ,drvREF01_RefNumberQual2 = '3H'
        ,drvREF02_RefNumberQual2 =  CASE WHEN EecOrgLvl1 IN ('ROC385','SHA630') THEN '0000'
                                        WHEN EecOrgLvl1 IN ('ZCO420','ZKY560','ZMA455') THEN '0001'
                                        WHEN EecOrgLvl1 IN ('OUR885') THEN '0002'
                                        WHEN EecOrgLvl1 IN ('ZSC325') THEN '0003'
                                        WHEN EecOrgLvl1 IN ('ZAL565') THEN '0004'
                                    END
        ,drvREF01_RefNumberQual3 = 'ZZ'
        ,drvREF02_RefNumberQual3 = '0001'
        -- If drvDTP00_DateTime1 is Populated, then send DTP Segment
        ,drvDTP00_DateTime1 = CASE WHEN BdmRecType = 'EMP' THEN
                                CASE
                                   WHEN EEcEmplStatus = 'T' and eecTermReason = '202'  THEN 'DTP'
                                END
                              END
        ,drvDTP01_DateTimeQualifier1 = '286'
        ,drvDTP02_DateTimeFormatQual1 = 'D8'
        ,drvDTP03_DateTimePeriod1 = CASE
                                   WHEN EEcEmplStatus = 'T' and eecTermReason = '202'  THEN eecDateofTermination
                              END
        -- If drvDTP00_DateTime2 is Populated, then send DTP Segment
        ,drvDTP00_DateTime2 = CASE WHEN BdmRecType = 'EMP' and EecDateOfLastHire IS NOT null then 'DTP' END
        ,drvDTP01_DateTimeQualifier2 = '336'
        ,drvDTP02_DateTimeFormatQual2 = 'D8'
        ,drvDTP03_DateTimePeriod2 = EecDateOfLastHire
        -- If drvDTP00_DateTime3 is Populated, then send DTP Segment
        ,drvDTP00_DateTime3 = CASE WHEN BdmRecType = 'EMP' and eecDateofTermination IS NOT null then 'DTP' END
        ,drvDTP01_DateTimeQualifier3 = '337'
        ,drvDTP02_DateTimeFormatQual3 = 'D8'
        ,drvDTP03_DateTimePeriod3 = eecDateofTermination
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
        ,drvNM106_NamePrefix1 = '' --CASE WHEN BdmRecType = 'EMP' THEN EepNamePrefix END
        ,drvNM107_NameSuffix1 = '' /*CASE WHEN BdmRecType = 'EMP' THEN EepNameSuffix
                                     WHEN BdmRecType = 'DEP' THEN ConNameSuffix
                                END*/
        ,drvNM108_IDCodeQualifier1 = CASE WHEN BdmRecType = 'EMP' AND ISNULL(EepSSN, '') <> '' THEN '34'
                                          WHEN BdmRecType = 'DEP' AND ISNULL(ConSSN, '') <> '' AND ConSSN <> '123456789' AND LEFT(ConSSN, 3) <> '000' AND LEFT(ConSSN, 1) <> '9' THEN '34'
                                     END
        ,drvNM109_IDCode1 = CASE WHEN BdmRecType = 'EMP' AND ISNULL(EepSSN, '') <> '' THEN EepSSN
                                 WHEN BdmRecType = 'DEP' AND ISNULL(ConSSN, '') <> '' AND ConSSN <> '123456789' AND LEFT(ConSSN, 3) <> '000' AND LEFT(ConSSN, 1) <> '9' THEN ConSSN
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
        ,drvDMG04_MaritalStatusCode1 = CASE WHEN BdmRecType = 'EMP' THEN
                                                CASE WHEN EepMaritalStatus IN ('S','Z') THEN 'I'
                                                    WHEN ISNULL(EepMaritalStatus, '') <> '' THEN EepMaritalStatus
                                                     --WHEN EepMaritalStatus ='D' THEN 'D'
                                                     --WHEN EepMaritalStatus ='M' THEN 'M'
                                                     --WHEN EepMaritalStatus ='W' THEN 'W'  
                                                    ELSE 'R' END
                                       END
        --If drvICM01_FrequencyCode is Populated, then send ICM Segment
        ,drvICM01_FrequencyCode = CASE WHEN BdmRecType = 'EMP' THEN '7' END --'7'
        ,drvICM02_MonetaryAmount = CASE WHEN BdmRecType = 'EMP' THEN CONVERT(MONEY,EecAnnSalary) END
        ,drvICM03_Quantity = CASE WHEN BdmRecType = 'EMP' and eecpayperiod  = 'B' THEN CONVERT(MONEY,EecScheduledWorkHrs / 2) END
        ,drvICM04_LocationID = CASE WHEN BdmRecType = 'EMP' THEN
                                        /*CASE WHEN YEAR(EecDateOfLastHire) = YEAR(GETDATE()) THEN CONVERT(VARCHAR(8),dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(EecEEID, EecCOID, getdate(),EecDateOfLastHire) ,112)
                                            ELSE CONVERT(CHAR(4),YEAR(GETDATE())) + '0101'
                                        END
                                        */
                                        CONVERT(VARCHAR(8),dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(EecEEID, EecCOID, getdate(),EecDateOfLastHire) ,112)
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
        ,drvHLH00_SegmentID = 'HLH'
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
        ,drvSubSort = CONVERT(CHAR(9),RTRIM(EepSSN)) + CONVERT(CHAR(12),ISNULL(ConSystemID,'')) + ' YY'
    INTO dbo.U_XXDCOMB834_DrvTbl
    FROM dbo.U_XXDCOMB834_EELIST WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    JOIN dbo.U_dsi_bdm_XXDCOMB834 WITH (NOLOCK)
        ON BdmEEID = xEEID
        AND BdmCOID = xCOID
    LEFT JOIN dbo.TrmReasn WITH (NOLOCK)
        ON TchCode = EecTermReason
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID;
       
 
       
    INSERT INTO dbo.U_XXDCOMB834_DrvTbl
SELECT DISTINCT
        --=====================
        --LOOP 2000 RECORDS
        --=====================
        drvINS01_YesNoCond = 'N'
        ,drvINS02_RelationshipCode /*=
                                                CASE WHEN ConRelationship IN ('SPS') THEN '01'
                                                     WHEN ConRelationship IN ('CHL','DSC','STC') THEN '19'
                                                     ELSE '19'
                                                END*/
        ,drvINS03_MaintTypeCode
        ,drvINS04_MaintReasonCode
        ,drvINS05_BenefitStatusCode
        ,drvINS0601_MEDICAREPLANCODE
        ,drvINS0602_EligibilityRsnCode
        ,drvINS07_COBRAQualEventCode
        ,drvINS08_EmploymentStatusCode
                                        
        ,drvINS09_StudentStatusCode --= CASE WHEN ConIsStudent = 'Y' THEN 'F' END --Full-time
 
        ,drvINS10_ResponseCode /*=
                                        CASE WHEN ConIsDisabled = 'Y' THEN 'Y'
                                             ELSE 'N'
 
                                        END*/
 
        ,drvINS11_DateTimeFormatQual
        ,drvINS12_DateTimePeriod
        ,drvINS17 
        -- If drvREF01_RefNumberQual1 is Populated, then send REF Segment
        ,drvREF01_RefNumberQual1 = '1L' -- 'DX'
        ,drvREF02_RefNumberQual1 = '00569179' --LocDesc
        -- If drvREF01_RefNumberQual2 is Populated, then send REF Segment
        ,drvREF01_RefNumberQual2
        ,drvREF02_RefNumberQual2
        ,drvREF01_RefNumberQual3
        ,drvREF02_RefNumberQual3
        -- If drvDTP00_DateTime1 is Populated, then send DTP Segment
        ,drvDTP00_DateTime1 = ''
        ,drvDTP01_DateTimeQualifier1 = ''
        ,drvDTP02_DateTimeFormatQual1 = ''
        ,drvDTP03_DateTimePeriod1 = ''
        -- If drvDTP00_DateTime2 is Populated, then send DTP Segment
        ,drvDTP00_DateTime2 = ''
        ,drvDTP01_DateTimeQualifier2 = ''
        ,drvDTP02_DateTimeFormatQual2 = ''
        ,drvDTP03_DateTimePeriod2
        -- If drvDTP00_DateTime3 is Populated, then send DTP Segment
        ,drvDTP00_DateTime3 = ''
        ,drvDTP01_DateTimeQualifier3 = ''
        ,drvDTP02_DateTimeFormatQual3 = ''
        ,drvDTP03_DateTimePeriod3 = ''
        --=====================
        -- LOOP 2100A RECORDS
        --=====================
        ,drvNM103_NameLast1 --= dbo.dsi_fnRemoveChars('.,/-',  ConNameLast)
        ,drvNM104_NameFirst1 --= dbo.dsi_fnRemoveChars('.,/-',  ConNameFirst)
        ,drvNM105_NameMiddleInitial1 --= dbo.dsi_fnRemoveChars('.,/-',LEFT(ConNameMiddle,1))
        ,drvNM106_NamePrefix1 = ''
        ,drvNM107_NameSuffix1 --= ConNameSuffix
        ,drvNM108_IDCodeQualifier1 --= CASE WHEN   ISNULL(ConSSN, '') <> '' THEN '34' END
        ,drvNM109_IDCode1 --= CASE WHEN  ISNULL(ConSSN, '') <> '' THEN ConSSN
                            --END
        ,drvPER02_Name = ''
        ,drvPER03_CommNumberQualifier = ''
 
        ,drvPER04_CommunicationNumber = ''
 
        ,drvPER05_CommNumberQualifier = ''
 
        ,drvPER06_CommunicationNumber = ''
 
        ,drvPER07_CommNumberQualifier  = ''
        ,drvPER08_CommunicationNumber  = ''
        ,drvN301_AddressLine1
        ,drvN302_AddressLine2
        ,drvN401_City
        ,drvN402_State
        ,drvN403_Zip
        ,drvN404_CountryCode
        ,drvDMG02_DateTimePeriod1 --=CONVERT(VARCHAR(8),ConDateOfBirth,112)
        ,drvDMG03_GenderCode1 --= ConGender
        ,drvDMG04_MaritalStatusCode1 = ''
        --If drvICM01_FrequencyCode is Populated, then send ICM Segment
        ,drvICM01_FrequencyCode = ''
        ,drvICM02_MonetaryAmount =  ''
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
        ,drvHLH01_HealthRelatedCode /*= CASE WHEN  ConIsSmoker = 'Y' THEN 'T' --Tobacco Use
                                                     ELSE 'N' --None
                                                END*/
        ,drvHLH02_Height = ''
        ,drvHLH03_Weight1 = ''
        ,drvHLH04_Weight2 = ''
        ,drvHLH05_Description1 = ''
        ,drvHLH06_CurrentHealthConditionCode = ''
        ,drvHLH07_Description2 = ''
        ---------------------------------
        ,drvEEID
        ,drvCOID
        ,drvDepRecID --= ConSystemID
        ,drvSSN
        ,drvInitialSort
        ,drvSubSort = REPLACE(drvSubSort, ' YY', ' XX') --= CONVERT(CHAR(9),RTRIM(drvSSN)) + CONVERT(CHAR(12),ISNULL(ConSystemID,''))
    FROM dbo.U_XXDCOMB834_DrvTbl
    /*LEFT JOIN (
                           Select * from contacts where consystemid not in (
                           Select  drvdeprecid from U_XXDCOMB834_DrvTbl where drvdeprecid is not null)) as Contacts
        ON ConEEID = drveeid*/
       /*JOIN dbo.EmpComp WITH (NOLOCK)
              ON drvEEID = EecEEID
              AND drvCOID = EecCOID
       JOIN dbo.Location WITH (NOLOCK)
              ON EecLocation = LocCode*/
      
    /*WHERE coneeid   IN ( (Select distinct bdmeeid from U_dsi_bdm_XXDCOMB834 where bdmdedcode IN ('CI','LIFEC') and bdmRecType = 'EMP')    )
     and conrelationship  not in ('SPS','DP') and conIsDependent = 'Y'
     and NOT EXISTS (Select drvdeprecid from  U_XXDCOMB834_DrvTbl where drvdeprecid = consystemid)*/
   
    /*
   
INSERT INTO dbo.U_XXDCOMB834_DrvTbl
SELECT DISTINCT
        --=====================
        --LOOP 2000 RECORDS
        --=====================
        drvINS01_YesNoCond = 'N'
        ,drvINS02_RelationshipCode =
                                                CASE WHEN ConRelationship IN ('SPS') THEN '01'
                                                     WHEN ConRelationship IN ('CHL','DSC','STC') THEN '19'
                                                     ELSE '19'
                                                END
        ,drvINS03_MaintTypeCode
        ,drvINS04_MaintReasonCode
        ,drvINS05_BenefitStatusCode
        ,drvINS0601_MEDICAREPLANCODE
        ,drvINS0602_EligibilityRsnCode
        ,drvINS07_COBRAQualEventCode
        ,drvINS08_EmploymentStatusCode
                                        
        ,drvINS09_StudentStatusCode = CASE WHEN ConIsStudent = 'Y' THEN 'F' END --Full-time
 
        ,drvINS10_ResponseCode =
                                        CASE WHEN ConIsDisabled = 'Y' THEN 'Y'
                                             ELSE 'N'
 
                                        END
 
        ,drvINS11_DateTimeFormatQual
        ,drvINS12_DateTimePeriod
        ,drvINS17 
        -- If drvREF01_RefNumberQual1 is Populated, then send REF Segment
        ,drvREF01_RefNumberQual1
        ,drvREF02_RefNumberQual1
        -- If drvREF01_RefNumberQual2 is Populated, then send REF Segment
        ,drvREF01_RefNumberQual2
        ,drvREF02_RefNumberQual2
        ,drvREF01_RefNumberQual3
        ,drvREF02_RefNumberQual3
        -- If drvDTP00_DateTime1 is Populated, then send DTP Segment
        ,drvDTP00_DateTime1 = ''
        ,drvDTP01_DateTimeQualifier1 = ''
        ,drvDTP02_DateTimeFormatQual1 = ''
        ,drvDTP03_DateTimePeriod1 = ''
        -- If drvDTP00_DateTime2 is Populated, then send DTP Segment
        ,drvDTP00_DateTime2 = ''
        ,drvDTP01_DateTimeQualifier2 = ''
        ,drvDTP02_DateTimeFormatQual2 = ''
        ,drvDTP03_DateTimePeriod2
        -- If drvDTP00_DateTime3 is Populated, then send DTP Segment
        ,drvDTP00_DateTime3 = ''
        ,drvDTP01_DateTimeQualifier3 = ''
        ,drvDTP02_DateTimeFormatQual3 = ''
        ,drvDTP03_DateTimePeriod3 = ''
        --=====================
        -- LOOP 2100A RECORDS
        --=====================
        ,drvNM103_NameLast1 = dbo.dsi_fnRemoveChars('.,/-',  ConNameLast)
        ,drvNM104_NameFirst1 = dbo.dsi_fnRemoveChars('.,/-',  ConNameFirst)
        ,drvNM105_NameMiddleInitial1 = dbo.dsi_fnRemoveChars('.,/-',LEFT(ConNameMiddle,1))
        ,drvNM106_NamePrefix1 = ''
        ,drvNM107_NameSuffix1 = ConNameSuffix
        ,drvNM108_IDCodeQualifier1 = CASE WHEN   ISNULL(ConSSN, '') <> '' THEN '34' END
        ,drvNM109_IDCode1 = CASE WHEN  ISNULL(ConSSN, '') <> '' THEN ConSSN
                            END
        ,drvPER02_Name = ''
        ,drvPER03_CommNumberQualifier = ''
 
        ,drvPER04_CommunicationNumber = ''
 
       ,drvPER05_CommNumberQualifier = ''
 
        ,drvPER06_CommunicationNumber = ''
 
        ,drvPER07_CommNumberQualifier  = ''
        ,drvPER08_CommunicationNumber  = ''
        ,drvN301_AddressLine1
        ,drvN302_AddressLine2
        ,drvN401_City
        ,drvN402_State
        ,drvN403_Zip
        ,drvN404_CountryCode
        ,drvDMG02_DateTimePeriod1 =CONVERT(VARCHAR(8),ConDateOfBirth,112)
        ,drvDMG03_GenderCode1 = ConGender
        ,drvDMG04_MaritalStatusCode1 = ''
        --If drvICM01_FrequencyCode is Populated, then send ICM Segment
        ,drvICM01_FrequencyCode = ''
        ,drvICM02_MonetaryAmount =  ''
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
        ,drvHLH01_HealthRelatedCode = CASE WHEN  ConIsSmoker = 'Y' THEN 'T' --Tobacco Use
                                                     ELSE 'N' --None
                                                END
        ,drvHLH02_Height = ''
        ,drvHLH03_Weight1 = ''
        ,drvHLH04_Weight2 = ''
        ,drvHLH05_Description1 = ''
        ,drvHLH06_CurrentHealthConditionCode = ''
        ,drvHLH07_Description2 = ''
        ---------------------------------
        ,drvEEID
        ,drvCOID
        ,drvDepRecID = ConSystemID
        ,drvSSN
        ,drvInitialSort
        ,drvSubSort = CONVERT(CHAR(9),RTRIM(drvSSN)) + CONVERT(CHAR(12),ISNULL(ConSystemID,''))
    FROM dbo.U_XXDCOMB834_DrvTbl
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = drveeid
    WHERE coneeid   IN ( (Select distinct bdmeeid from U_dsi_bdm_XXDCOMB834 where bdmdedcode IN ('CIS','LIFES') and bdmRecType = 'EMP')    )
     and conrelationship  in ('SPS','DP') 
          and NOT EXISTS (Select drvdeprecid from  dbo.U_XXDCOMB834_DrvTbl where drvdeprecid = consystemid)
    and conIsDependent = 'Y'
  */ 
    
 
    /**************************************************************************************************************
        DETAIL RECORDS
            -- LOOP 2300 RECORDS - HD, DTP, AMT Segments
            -- Loop 2700 RECORDS - LX Segments
            -- Loop 2750 RECORDS - N1, REF Segments
    ***************************************************************************************************************/
 
    -------------------
    -- DETAIL RECORD
    -------------------
    IF OBJECT_ID('U_XXDCOMB834_DrvTbl_2300','U') IS NOT NULL
        DROP TABLE dbo.U_XXDCOMB834_DrvTbl_2300;
    SELECT DISTINCT
        -- If drvHD00_HealthCoverage Populated, then send HD Segment
        drvDedCode = bdmdedcode
        ,drvHD00_HealthCoverage = CASE WHEN BdmDedCode IN ('SU298','SU293','SU313','SU318') AND BdmRecType = 'EMP' THEN '' ELSE 'HD' END
        ,drvHD01_MaintTypeCode = '030' --Audit or Compare
        ,drvHD02_MaintReasonCode = CASE WHEN BdmDedType IN ('MED') THEN ''
                                           WHEN BdmDedType IN ('DEN') THEN ''
                                           WHEN BdmDedType IN ('VIS') THEN ''
                                     END
        ,drvHD03_InsuranceLineCode =    CASE WHEN BdmDedCode IN ('DE317','DE312') THEN 'DEN'
                                            WHEN BdmDedCode IN ('BA651') THEN 'AH'
                                            WHEN BdmDedCode IN ('BA630') THEN 'AJ'
                                            WHEN BdmDedCode IN ('SU288','SU298','SU318') THEN 'FAC'
                                            WHEN BdmDedCode IN ('SU283','SU293','SU313') THEN 'HLT'
                                            WHEN BdmDedCode IN ('LO502') THEN 'LTC'
                                            WHEN BdmDedCode IN ('VI782') THEN 'VIS'
                                        END
        ,drvHD04_PlanCoverageDesc =    CASE WHEN BdmRecType = 'EMP' AND BdmDedCode IN ('SU288','SU381','SU296','SU298','SU316','SU318','SU283','SU285','SU293','SU295','SU313','SU315') THEN BdmUSGField1
                                        WHEN BdmRecType = 'DEP' AND BdmDedCode IN ('SU293') THEN SU293Amt
                                        WHEN BdmRecType = 'DEP' AND BdmDedCode IN ('SU298') THEN SU298Amt
                                        WHEN BdmRecType = 'DEP' AND BdmDedCode IN ('SU313') THEN SU313Amt
                                        WHEN BdmRecType = 'DEP' AND BdmDedCode IN ('SU318') THEN SU318Amt
                                        WHEN BdmRecType = 'DEP' AND BdmDedCode IN ('SU288','SU381','SU296','SU316','SU283','SU285','SU295','SU315') THEN BdmUSGField1
                                                                    WHEN BdmDedCode = 'DE312' THEN 'BASE'
                                                                    WHEN BdmDedCode = 'DE317' THEN 'BUYUP'
                                    END
                                    -- spec said BdmBenAmt, but it didn't have any value, and this field matches Ulti
                                        /*CASE WHEN BdmDedCode in ('LIFEE','LIFEC','LIFES','CI','CIS') THEN (Select top 1 CAST(eedBenamt as varchar(12)) from dbo.U_dsi_bdm_EmpDeductions where eedFormatCode = @FormatCode and eedeeid = xeeid and eedcoid = xcoid and eeddedcode = bdmdedcode )
                                         WHEN BdmDedCode in ('HI1K') THEN 'PLAN1'
                                         WHEN BdmDedCode in ('HI2K') THEN 'PLAN2'
                                        
                                            END*/
                                    
        ,drvHD05_CoverageLevelCode =    CASE WHEN BdmRecType = 'EMP' AND BdmDedCode IN ('BA651') THEN 'EMP'
                                            WHEN BdmRecType = 'EMP' AND BdmDedCode IN ('BA630') THEN 'EMP'
                                            WHEN BdmRecType = 'EMP' AND BdmDedCode IN ('LO502') THEN 'EMP'
                                            WHEN BdmDedCode IN ('DE317','DE312','VI782') AND BdmBenOption IN ('EMA525','EMA535') THEN 'EMP'
                                            WHEN BdmDedCode IN ('DE317','DE312','VI782') AND BdmBenOption IN ('EMS665','EMS675') THEN 'ESP'
                                            WHEN BdmDedCode IN ('DE317','DE312','VI782') AND BdmBenOption IN ('EMC105','EMC106') THEN 'ECH'
                                            WHEN BdmDedCode IN ('DE317','DE312','VI782') AND BdmBenOption IN ('EMF210','EMF215') THEN 'FAM'
                                            WHEN BdmDedCode IN ('SU288','SU283') THEN 'EMP'
                                            WHEN BdmDedCode IN ('SU298','SU293') THEN 'SPO'
                                            WHEN BdmDedCode IN ('SU318','SU313') THEN 'CHD'
                                            --ELSE ISNULL(BdmDedCode, 'nope') + ' ' +  ISNULL(BdmBenOption, 'nope')
                                        END
                                        /*CASE WHEN BdmDedCode in ('GLIFE') THEN 'EMP'
                                          WHEN BdmDedCode in ('STD', 'LTD') THEN 'EMP' 
                                          WHEN BdmDedCode in ('DEN', 'HI1K', 'HI2K', 'AOFF')  and bdmrectype = 'EMP' THEN
                                                CASE WHEN BdmBEnOption in ('EE') THEN 'EMP'
                                                     WHEN BdmBEnOption in ('EES') THEN 'ESP'
                                                     WHEN BdmBEnOption in ('EEC') THEN 'ECH'
                                                     WHEN BdmBEnOption in ('EEF') THEN 'FAM'
                                                END
                                        WHEN BdmDedCode in ('LIFEE') and bdmRectype = 'EMP' THEN 'EMP'
                                        WHEN BdmDedCode in ('CI')  and bdmRectype = 'EMP'  THEN 'EMP'
                                        WHEN BdmDedCode in ('CIS')  and bdmRectype = 'DEP'  THEN 'SPO'
                                        WHEN BdmDedCode in ('LIFES')  and BdmREctype ='DEP' THEN 'SPO'
                                        WHEN BdmDedCode in ('LIFEC')  and BdmREctype ='DEP' THEN 'CHD'
                                        WHEN BdmDedCode in ('LIFES')  and BdmREctype ='EMP' THEN 'DEL'
                                        WHEN BdmDedCode in ('LIFEC')  and BdmREctype ='EMP' THEN 'DEL'
                                        ELSE ''
                                     END*/
 
                                     
 
        -- If drvDTP00_DateTime_348 Populated, then send DTP*348 Segment
        ,drvDTP00_DateTime_348 = CASE WHEN BdmDedType IN ('OT2' ,'DEN' ,'GTL','DRG' ,'OPC' ,'OPT','OPS','LTD','STD','ADD','VIS' ) THEN 'DTP' END
        ,drvDTP01_DateTimeQualifier_348 = CASE WHEN BdmDedType IN ('OT2' ,'DEN' ,'GTL','DRG' ,'OPC' ,'OPT','OPS','LTD','STD','ADD','VIS'  ) THEN '348' END
        ,drvDTP02_DateTimeFormatQual_348 = CASE WHEN BdmDedType IN ('OT2' ,'DEN' ,'GTL','DRG' ,'OPC' ,'OPT','OPS','LTD','STD','ADD','VIS'  ) THEN 'D8' END
        ,drvDTP03_DateTimePeriod_348 = CASE WHEN BdmDedType IN ('OT2' ,'DEN' ,'GTL','DRG' ,'OPC' ,'OPT','OPS','LTD','STD','ADD','VIS'  )THEN dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate) END
        -- If drvDTP00_DateTime_349 Populated, then send DTP*349 Segment
        ,drvDTP00_DateTime_349 = CASE WHEN BdmDedType IN ('OT2' ,'DEN' ,'GTL','DRG' ,'OPC' ,'OPT','OPS','LTD','STD','ADD'  ) AND BdmBenStopDate IS NOT NULL THEN 'DTP' END
        ,drvDTP01_DateTimeQualifier_349 = CASE WHEN BdmDedType IN ('OT2' ,'DEN' ,'GTL','DRG' ,'OPC' ,'OPT','OPS','LTD','STD','ADD'  ) AND BdmBenStopDate IS NOT NULL THEN '349' END
        ,drvDTP02_DateTimeFormatQual_349 = CASE WHEN BdmDedType IN ('OT2' ,'DEN' ,'GTL','DRG' ,'OPC' ,'OPT','OPS','LTD','STD','ADD'  ) AND BdmBenStopDate IS NOT NULL THEN 'D8' END
        ,drvDTP03_DateTimePeriod_349 = CASE WHEN BdmDedType IN ('OT2' ,'DEN' ,'GTL','DRG' ,'OPC' ,'OPT','OPS','LTD','STD','ADD'  ) THEN BdmBenStopDate END
        -- If drvDTP00_DateTime_303 = 'DTP', then Send DTP*303 Segment
        ,drvDTP00_DateTime_303 = CASE WHEN BdmDedType IN ('MED') THEN '' END
        ,drvDTP01_DateTimeQualifier_303 = CASE WHEN BdmDedType IN ('MED') THEN '303' END
        ,drvDTP02_DateTimeFormatQual_303 = CASE WHEN BdmDedType IN ('MED') THEN 'D8' END
        ,drvDTP03_DateTimePeriod_303 = CASE WHEN BdmDedType IN ('MED') THEN dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStatusDate, @FileMinCovDate) END
        -- If drvREF00_RefNumberQual1 is Populated, then send REF Segment
        ,drvREF00_RefNumberQual1 = 'REF'
        ,drvREF01_RefNumberQual1 = '1L'
        ,drvREF02_RefNumberQual1 = '00569179'
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
        ,drvSubSort =       CONVERT(CHAR(9),RTRIM(EepSSN)) + CONVERT(CHAR(12),ISNULL(ConSystemID,''))
                        + CASE WHEN BdmDedCode IN ('DE317','DE312') THEN '1'
                            WHEN BdmDedCode IN ('BA651') THEN '2'
                            WHEN BdmDedCode IN ('BA630') THEN '3'
                            WHEN BdmDedCode IN ('SU288','SU298','SU318') THEN '4'
                            WHEN BdmDedCode IN ('SU283','SU293','SU313') THEN '5'
                            WHEN BdmDedCode IN ('LO502') THEN '6'
                            WHEN BdmDedCode IN ('VI782') THEN '7'
                        END
                        + ' '
                        + CASE WHEN BdmRecType = 'EMP' AND BdmDedCode IN ('BA651') THEN '1'
                                            WHEN BdmRecType = 'EMP' AND BdmDedCode IN ('BA630') THEN '1'
                                            WHEN BdmRecType = 'EMP' AND BdmDedCode IN ('LO502') THEN '1'
                                            WHEN BdmDedCode IN ('DE317','DE312','VI782') AND BdmBenOption IN ('EMA525','EMA535') THEN '1'
                                            WHEN BdmDedCode IN ('DE317','DE312','VI782') AND BdmBenOption IN ('EMS665','EMS675') THEN '2'
                                           WHEN BdmDedCode IN ('DE317','DE312','VI782') AND BdmBenOption IN ('EMC105','EMC106') THEN '3'
                                            WHEN BdmDedCode IN ('DE317','DE312','VI782') AND BdmBenOption IN ('EMF210','EMF215') THEN '4'
                                            WHEN BdmDedCode IN ('SU288','SU283') THEN '1'
                                            WHEN BdmDedCode IN ('SU298','SU293') THEN '5'
                                            WHEN BdmDedCode IN ('SU318','SU313') THEN '6'
                                            --ELSE ISNULL(BdmDedCode, 'nope') + ' ' +  ISNULL(BdmBenOption, 'nope')
                                        END
                   /*   + CASE BdmDedType
                             WHEN 'ADD' THEN '1'
                             WHEN 'OT2' THEN '2'
                             WHEN 'DEN' THEN '3'
                             WHEN 'GTL' THEN '4'
                             WHEN 'DRG' THEN '5'
                             WHEN 'OPC' THEN '6'
                             WHEN 'OPT' THEN '7'
                             WHEN 'OPS' THEN '8'
                             WHEN 'LTD' THEN '9'
                             WHEN 'STD' THEN '10'
                             ELSE '11'
                      END*/
    INTO dbo.U_XXDCOMB834_DrvTbl_2300
    FROM dbo.U_XXDCOMB834_EELIST WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.U_dsi_bdm_XXDCOMB834  WITH (NOLOCK)
            ON BdmEEID = xEEID
        AND BdmCOID = xCOID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
       AND ConSystemID = BdmDepRecID
    LEFT JOIN (
                    SELECT BdmEEID AS SU293EEID, BdmCOID AS SU293COID, BdmUSGField1 as SU293Amt
                    FROM dbo.U_dsi_bdm_XXDCOMB834 WITH (NOLOCK)
                    WHERE BdmDedCode = 'SU293'
                    AND BdmRecType = 'EMP') SU293
        ON SU293EEID = xEEID
        AND SU293COID = xCOID
    LEFT JOIN (
                    SELECT BdmEEID AS SU298EEID, BdmCOID AS SU298COID, BdmUSGField1 as SU298Amt
                    FROM dbo.U_dsi_bdm_XXDCOMB834 WITH (NOLOCK)
                    WHERE BdmDedCode = 'SU298'
                    AND BdmRecType = 'EMP') SU298
        ON SU298EEID = xEEID
        AND SU298COID = xCOID
    LEFT JOIN (
                    SELECT BdmEEID AS SU313EEID, BdmCOID AS SU313COID, BdmUSGField1 as SU313Amt
                    FROM dbo.U_dsi_bdm_XXDCOMB834 WITH (NOLOCK)
                    WHERE BdmDedCode = 'SU313'
                    AND BdmRecType = 'EMP') SU313
        ON SU313EEID = xEEID
        AND SU313COID = xCOID
 
        LEFT JOIN (
                    SELECT BdmEEID AS SU318EEID, BdmCOID AS SU318COID, BdmUSGField1 as SU318Amt
                    FROM dbo.U_dsi_bdm_XXDCOMB834 WITH (NOLOCK)
                    WHERE BdmDedCode = 'SU318'
                    AND BdmRecType = 'EMP') SU318
        ON SU318EEID = xEEID
        AND SU318COID = xCOID
 
       ;
 
    /**************************************************************************************************
        TRAILER RECORDS
            - SE, GE, IEA Segments
    **************************************************************************************************/
    ---------------------
    -- TRAILER RECORD
    --------------------
    IF OBJECT_ID('U_XXDCOMB834_TrlTbl') IS NOT NULL
        DROP TABLE dbo.U_XXDCOMB834_TrlTbl;
    SELECT DISTINCT drvSE01_SegmentCount = '9999'
    INTO dbo.U_XXDCOMB834_TrlTbl;
 
    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable('XXDCOMB834','UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = 'RDSI_XXDCOMB834_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
        WHERE FormatCode = 'XXDCOMB834';
    END;
 
END;
/**********************************************************************************
 
--Alter the View
ALTER VIEW dbo.dsi_vwXXDCOMB834_Export AS
    SELECT TOP 20000000 DATA FROM dbo.U_XXDCOMB834_File (NOLOCK)
    ORDER BY CASE LEFT(Recordset,1) WHEN 'H' THEN 1 WHEN 'D' THEN 2 ELSE 3 END, InitialSort, SubSort, RIGHT(Recordset,2)
GO
 
--Check out AscDefF
SELECT * FROM dbo.AscDefFEEOnlyBenOpti
WHERE AdfHeaderSystemID LIKE 'XXDCOMB834%'
ORDER BY AdfSetNumber, AdfFieldNumber;
 
--Update Dates
UPDATE dbo.AscExp
    SET ExpLastStartPerControl = '201810011'
       ,ExpStartPerControl     = '201810011'
       ,ExpLastEndPerControl   = '201810019'
       ,ExpEndPerControl       = '201810019'
WHERE ExpFormatCode = 'XXDCOMB834';
 
**********************************************************************************/
 