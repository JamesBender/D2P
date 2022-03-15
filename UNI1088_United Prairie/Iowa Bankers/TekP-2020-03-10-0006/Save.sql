USE [ULTIPRO_WPUPB]
GO
/****** Object:  StoredProcedure [dbo].[dsi_sp_BuildDriverTables_EIWABNKMED]    Script Date: 12/30/2020 9:42:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EIWABNKMED]
    @systemid CHAR(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client: United Prairie

Created By: James Bender
Business Analyst: Lea King
Create Date: 6/2/2020
Service Request Number: TekP-2020-03-10-0006

Purpose: Iowa Bankers Med 834 Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/20XX     SR-20XX-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EIWABNKMED';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EIWABNKMED';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EIWABNKMED';
SELECT * FROM dbo.AscExp WHERE expFormatCode = 'EIWABNKMED';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EIWABNKMED' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIWABNKMED', 'FULLFILE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIWABNKMED', 'TESTING';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIWABNKMED', 'CHANGES';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIWABNKMED', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIWABNKMED', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIWABNKMED', 'SCHEDULED';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EIWABNKMED';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EIWABNKMED', @AllObjects = 'Y', @IsWeb = 'Y';
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
    WHERE FormatCode = 'EIWABNKMED';

    --==========================================
    -- Deduction Code List
    --==========================================
    DECLARE @DedList VARCHAR(MAX);
    SET @DedList = '426,427,428,429,430,431';

    IF OBJECT_ID('U_EIWABNKMED_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EIWABNKMED_DedList;
    SELECT DedCode = DedDedCode
        ,DedLongDesc
        ,DedType = DedDedType
    INTO dbo.U_EIWABNKMED_DedList
    FROM dbo.dsi_BDM_fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

    --==========================================
    -- Clean EE List
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EIWABNKMED_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCoID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EIWABNKMED_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    -- Remove Employees that Do Not Have a Benefit Plan in Deduction Code List
    DELETE FROM dbo.U_EIWABNKMED_EEList
    WHERE NOT EXISTS (SELECT 1 FROM dbo.EmpDed JOIN dbo.U_EIWABNKMED_DedList ON DedCode = EedDeDCode WHERE EedEEID = xEEID);



    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EIWABNKMED_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EIWABNKMED_AuditFields;
    CREATE TABLE dbo.U_EIWABNKMED_AuditFields (aTableName varchar(30),aFieldName varchar(30));


    INSERT INTO dbo.U_EIWABNKMED_AuditFields VALUES ('EmpDed','EedBenStartDate');
    INSERT INTO dbo.U_EIWABNKMED_AuditFields VALUES ('EmpDed','EedBenStopDate');
    INSERT INTO dbo.U_EIWABNKMED_AuditFields VALUES ('EmpDed','EedBenStartDate');
    INSERT INTO dbo.U_EIWABNKMED_AuditFields VALUES ('EmpDed','EedBenOption');

    INSERT INTO dbo.U_EIWABNKMED_AuditFields VALUES ('EmpDed','EedDedCode');



	INSERT INTO dbo.U_EIWABNKMED_AuditFields VALUES ('EmpDedFull','EedBenStartDate');
    INSERT INTO dbo.U_EIWABNKMED_AuditFields VALUES ('EmpDedFull','EedBenStopDate');
    INSERT INTO dbo.U_EIWABNKMED_AuditFields VALUES ('EmpDedFull','EedBenStartDate');
    INSERT INTO dbo.U_EIWABNKMED_AuditFields VALUES ('EmpDedFull','EedBenOption');

    INSERT INTO dbo.U_EIWABNKMED_AuditFields VALUES ('EmpDedFull','EedDedCode');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EIWABNKMED_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EIWABNKMED_Audit;
    SELECT 
        audEEID  = audKey1Value
        ,audKey2 = audKey2Value
        ,audKey3 = audKey3Value    
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audTableName, audFieldName ORDER BY audDateTime DESC)
    INTO dbo.U_EIWABNKMED_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EIWABNKMED_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE --audDateTime BETWEEN @StartDate AND @EndDate
    --AND 
    audAction <> 'DELETE'
	AND AudNewValue NOT IN ('Z')
	;

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EIWABNKMED_Audit ON dbo.U_EIWABNKMED_Audit (audEEID,audKey2);






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
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL,DCH,DPC,STC');

    --INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','@DomPartnerCSV');

    --Set if OE
    IF @ExportCode LIKE '%PASSIVE' --OR @ExportCode = 'TESTING'
    BEGIN
        INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'AllowMultiDedType', 'Y')
         INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'PASSIVE');
    END;

    IF @ExportCode LIKE '%ACTIVE' 
    BEGIN
         INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'ACTIVE');
    END;

    EXEC dbo.dsi_bdm_sp_PopulateDeductionsTable @FormatCode;




	IF OBJECT_ID('U_EIWABNKMED_OldBenOptions','U') IS NOT NULL
		DROP TABLE dbo.U_EIWABNKMED_OldBenOptions;
	SELECT AudEEID AS ObEEID, AudKey2 AS ObCOID, AudKey3 AS ObDedCode, AudOldValue AS ObOldBenOption, AudNewValue AS ObNewBenOption, 'Audit' AS OBSource --, AudNewValue AS NewBenOption, audDateTime
	INTO dbo.U_EIWABNKMED_OldBenOptions
    FROM dbo.U_EIWABNKMED_Audit WITH (NOLOCK)
    WHERE audTableName = 'EmpDed'
        AND audFieldName = 'EedBenOption'
        AND audAction = 'Update'
        AND AudRowNo = 1
		AND  AudKey3 IN ('426','427','428','429','430','431') 
		AND AudOldValue <> 'Z'
		AND audDateTime BETWEEN @StartDate AND @EndDate
			

	IF @ExportCode LIKE '%PASSIVE' OR @ExportCode LIKE '%ACTIVE' --OR @ExportCode = 'TESTING'
	BEGIN
		INSERT INTO dbo.U_EIWABNKMED_OldBenOptions (ObEEID, ObCOID, ObDedCode, ObOldBenOption, ObNewBenOption, ObSource)
		SELECT EdhEEID, EdhCOID, EdhDedCode, EdhBenOption, BdmBenOption, 'HDed' --, EdhEffDate, RN
		FROM (
				SELECT EdhEEID, EdhCOID, EdhEffDate, EdhDedCode, EdhBenOption, BdmBenOption, ROW_NUMBER() OVER (PARTITION BY EdhEEID, EdhCOID, EdhDedCode ORDER BY EdhEffDate DESC) AS RN
				FROM dbo.EmpHDed WITH (NOLOCK)
				JOIN dbo.U_dsi_bdm_EIWABNKMED WITH (NOLOCK) 
					ON EdhEEID = BdmEEID
					AND EdhCOID = BdmCOID
					AND EdhDedCode = BdmDedCode
					AND EdhBenOption <> BdmBenOption
					AND EdhBenOption <> 'Z'
				WHERE EdhDedCode IN ('426','427','428','429','430','431') 
					AND EdhChangeReason = 'OE'		
					AND EdhEffDate< '1/1/2021'
					AND EdhEEID NOT IN (SELECT DISTINCT ObEEID FROM dbo.U_EIWABNKMED_OldBenOptions)
					--AND EdhEEID = 'COCIET043030' 
				) AS OldOEOpt
		WHERE RN = 1
		--AND EdhEEID = 'COCIET043030'	
	END


    --=========================================
    -- Update BdmChangeReason For Dependents
    --=========================================
    UPDATE D
        SET D.BdmChangeReason = E.BdmChangeReason
    FROM dbo.U_dsi_bdm_EIWABNKMED D
    JOIN dbo.U_dsi_bdm_EIWABNKMED E
        ON E.BdmEEID = D.BdmEEID
        AND E.BdmCOID = D.BdmCOID
        AND E.BdmDedCode = D.BdmDedCode
    WHERE D.BdmRecType = 'DEP' AND E.BdmRecType = 'EMP';

    --=====================================================
    -- Update BdmUSGField2 with EmpDedTVID for Employees
    --=====================================================
    UPDATE dbo.U_dsi_bdm_EIWABNKMED
        SET BdmUSGField2 = EedEmpDedTVID
    FROM dbo.U_dsi_bdm_EIWABNKMED
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = BdmEEID
        AND EedCOID = BdmCOID
        AND EedDedCode = BdmDedCode
    WHERE BdmRecType = 'EMP' AND EedFormatCode = @FormatCode AND EedValidForExport = 'Y';

    --=======================================================
    -- Update BdmUSGField2 with DepBPlanTVID for Dependents
    --=======================================================
    UPDATE dbo.U_dsi_bdm_EIWABNKMED
        SET BdmUSGField2 = DbnDepBPlanTVID
    FROM dbo.U_dsi_bdm_EIWABNKMED
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
        ON DbnEEID = BdmEEID
        AND DbnCOID = BdmCOID
        AND DbnDedCode = BdmDedCode
    WHERE BdmRecType = 'DEP' AND DbnFormatCode = @FormatCode AND DbnValidForExport = 'Y';

    --======================================================
    -- Update BdmUSGField1 with Benefit Amount (EedBenAmt)
    --======================================================
    UPDATE dbo.U_dsi_bdm_EIWABNKMED
        SET BdmUSGField1 = CONVERT(VARCHAR(20),EedBenAmt)
    FROM dbo.U_dsi_bdm_EIWABNKMED
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

    DECLARE @CmmFedTaxId VARCHAR(9);
    DECLARE @EmpCount INT;
    DECLARE @DepCount INT;

    SELECT @CmmFedTaxId = CmmFedTaxId from dbo.CompMast WITH (NOLOCK);
    SELECT DISTINCT @EmpCount = COUNT(DISTINCT BdmEEID) FROM dbo.U_dsi_bdm_EIWABNKMED WITH (NOLOCK) WHERE BdmRecType = 'EMP';
    SELECT DISTINCT @DepCount = COUNT(DISTINCT BdmDepRecId) FROM dbo.U_dsi_bdm_EIWABNKMED WITH (NOLOCK) WHERE BdmRecType = 'DEP';

    -------------------
    -- HEADER RECORD 
    -------------------
    IF OBJECT_ID('U_EIWABNKMED_HdrTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EIWABNKMED_HdrTbl;
    SELECT DISTINCT drvISA05_SenderIDQual = 'ZZ'
        ,drvISA06_SenderID = '410250740'
        ,drvISA07_ReceiverIDQual = 'ZZ'
        ,drvISA08_ReceiverID = 'IBIS'
        ,drvISA09_InterchangeDate = RIGHT(@RunDate,6)
        ,drvISA10_InterchangeTime = @RunTime
        ,drvISA15_UsageIndicator = CASE dbo.dsi_fnVariable(@FormatCode,'Testing') WHEN 'Y' THEN 'T' ELSE 'P' END
        ,drvGS02_SenderID = '410250740' -- @CmmFedTaxId
        ,drvGS03_ReceiverID = 'IBIS'
        ,drvGS04_Date = @RunDate
        ,drvGS05_Time = @RunTime
        ,drvBGN03_Date = @RunDate
        ,drvBGN04_Time = @RunTime
        ,drvBGN05_TimeCode = 'CT'
        ,drvBGN06_RefID = ''
        ,drvBGN07_TransTypeCode = ''
        ,drvBGN08_ActionCode = 'RX'
        ,drvREF01_RefNumberQual = ''
        ,drvREF02_RefNumberQual = ''
        ,drvDTP03_DateTimePeriod = GETDATE()
        ,drvQTY01_QuantityQual1 = 'ET'
        ,drvQTY02_Quantity1 = FORMAT(@EmpCount, '#')
        ,drvQTY01_QuantityQual2 = 'DT'
        ,drvQTY02_Quantity2 = FORMAT(@DepCount, '#')
        ,drvQTY01_QuantityQual3 = 'TO'
        ,drvQTY02_Quantity3 = FORMAT(@EmpCount + @DepCount, '#')
        ,drvN101_EntityIDCodeSponsor1 = 'P5'
        ,drvN102_Name1 = 'United Prairie Bank'
        ,drvN103_IDCodeQual1 = 'FI'
        ,drvN104_IDCode1 = '410250740' --@CmmFedTaxId
        ,drvN101_EntityIDCodeSponsor2 = 'IN'
        ,drvN102_Name2 = 'Iowa Bankers Insurance Services'
        ,drvN103_IDCodeQual2 = 'FI'
        ,drvN104_IDCode2 = 'IBIS'
    INTO dbo.U_EIWABNKMED_HdrTbl
    FROM dbo.U_EIWABNKMED_EELIST WITH (NOLOCK)
    JOIN dbo.U_dsi_bdm_EIWABNKMED WITH (NOLOCK)
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
    IF OBJECT_ID('U_EIWABNKMED_DrvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EIWABNKMED_DrvTbl;
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
                                                CASE WHEN ConRelationship IN ('SPS') THEN '01'
                                                    WHEN ConRelationship IN ('DP') THEN '53'
                                                     WHEN ConRelationship IN ('CHL','DCH','DPC','STC') THEN '19'
                                                     ELSE '19'
                                                END
                                     END
        ,drvINS03_MaintTypeCode =    /*CASE WHEN @ExportCode LIKE 'OE%' THEN

                                    ELSE
                                        CASE WHEN BdmBenStatus IN ('T','C') THEN '024' ELSE '030' END
                                    END*/
        
        CASE WHEN BdmRecType = 'EMP' THEN '030'
                                        ELSE 
                                            CASE WHEN (SELECT COUNT(DISTINCT BdmBenOption) FROM dbo.U_dsi_bdm_EIWABNKMED WITH (NOLOCK) WHERE BdmCOID = xCOID AND BdmEEID = xEEID AND BdmRecType = 'DEP') > 1 AND
                                                (SELECT COUNT(BdmBenStatus) FROM dbo.U_dsi_bdm_EIWABNKMED WITH (NOLOCK) WHERE BdmCOID = xCOID AND BdmEEID = xEEID AND BdmRecType = 'DEP' AND BdmBenStatus <> 'A') > 0 THEN '024' ELSE '030'
                                            END
                                            
                                            --BdmBenStatus IN ('T','C')  THEN '024' ELSE '030' END --Audit or Compare

                                        -- is there a benefit option chagne AAND status goes to T,C (dependent, not employ) then 024,   030
                                    END
                                    -- Hughes*Cynthia
                                    -- CoreSource - loop 2500.
        ,drvINS04_MaintReasonCode = '' --'XN' --Notification Only
        ,drvINS05_BenefitStatusCode = 'A'
        ,drvINS0601_MEDICAREPLANCODE = ''
        ,drvINS0602_EligibilityRsnCode = ''
        ,drvINS07_COBRAQualEventCode = ''
        ,drvINS08_EmploymentStatusCode = 'FT' /*CASE WHEN BdmRecType = 'EMP' THEN
                                                CASE WHEN EecEmplStatus = 'T' THEN 'TE' --Termination
                                                     WHEN EecFullTimeOrPartTime = 'F' THEN 'FT' --Full time active employee
                                                     WHEN EecFullTimeOrPartTime = 'P' THEN 'PT' --Part time active employee
                                                END
                                         END*/
        ,drvINS09_StudentStatusCode = '' /*CASE WHEN BdmRecType = 'DEP' THEN
                                                CASE WHEN ConIsStudent = 'Y' THEN 'F' END --Full-time
                                      END*/
        ,drvINS10_ResponseCode = CASE /*WHEN BdmRecType = 'EMP' THEN
                                        CASE WHEN EepIsDisabled = 'Y' THEN 'Y'
                                             ELSE 'N'
                                        END*/
                                      WHEN BdmRecType = 'DEP' THEN 
                                        CASE WHEN ConIsDisabled = 'Y' THEN 'Y'
                                             ELSE 'N'
                                        END
                                END
        ,drvINS11_DateTimeFormatQual = CASE WHEN ISNULL(EepDateDeceased, '') <> '' THEN 'D8' END
        ,drvINS12_DateTimePeriod = CASE WHEN ISNULL(EepDateDeceased, '') <> '' THEN CONVERT(VARCHAR(8),EepDateDeceased,112) END
        -- If drvREF01_RefNumberQual1 is Populated, then send REF Segment
        ,drvREF01_RefNumberQual1 = 'DX'
        ,drvREF02_RefNumberQual1 =    CASE REPLACE(EecLocation, ' ', '')
                                        WHEN '01' THEN '01-Mt Lake'
                                        WHEN '05' THEN '05-Worthington'
                                        WHEN '08' THEN '08-Jackson'
                                        WHEN '09' THEN '09-Spicer'
                                        WHEN '10' THEN '10-Madison'
                                        WHEN '11' THEN '11-New Ulm'
                                        WHEN '12' THEN '12-Owatonna' 
                                        WHEN '13' THEN '13-Waseca'
                                        WHEN '14' THEN '14-Mankato HT'
                                        WHEN '50' THEN '50-UPIA Springfield'
                                        WHEN '51' THEN '51-UPIA Mt Lake'
                                        WHEN '52' THEN '52-UPIA Lakefield' 
                                        WHEN '53' THEN '53-UPIA Slayton'
                                        WHEN '55' THEN '55-UPIA Worthington'
                                        WHEN '56' THEN '56-UPIA Wilmont'
                                        WHEN '58' THEN '58-UPIA Jackson'
                                        WHEN '59' THEN '59-UPIA Spicer'
                                        WHEN '60' THEN '60-UPIA Madison'
                                        WHEN '61' THEN '61-UPIA New Ulm'
                                        WHEN '62' THEN '62-UPIA Owatonna' 
                                        WHEN '64' THEN '64-UPIA Mkto HT'
                                        WHEN '65' THEN '65-UPIA Admin'
                                        WHEN '66' THEN '66-UPIA Benefits'
                                        WHEN '71' THEN '71-Finance/Ops/IT' 
                                        WHEN '72' THEN '72-HR/Training'
                                        WHEN '73' THEN '73-Loan Admin/Compliance'
                                        WHEN '74' THEN '74-Marketing'
                                        WHEN '83' THEN '83-Executive'
                                        WHEN '84' THEN '84-UPFN'
                                    END
        -- If drvREF01_RefNumberQual2 is Populated, then send REF Segment
        ,drvREF01_RefNumberQual2 = ''
        ,drvREF02_RefNumberQual2 = ''
        -- If drvDTP00_DateTime1 is Populated, then send DTP Segment
        ,drvDTP00_DateTime1 = CASE WHEN BdmRecType = 'EMP' THEN 'DTP' END
        ,drvDTP01_DateTimeQualifier1 = '336'
        ,drvDTP02_DateTimeFormatQual1 = 'D8'
        ,drvDTP03_DateTimePeriod1 = EecDateOfLastHire
        -- If drvDTP00_DateTime2 is Populated, then send DTP Segment
        ,drvDTP00_DateTime2 = CASE WHEN ISNULL(EecDateOfTermination, '') <> '' AND BdmRecType = 'EMP' THEN 'DTP' END
        ,drvDTP01_DateTimeQualifier2 = '337'
        ,drvDTP02_DateTimeFormatQual2 = 'D8'
        ,drvDTP03_DateTimePeriod2 = EecDateOfTermination
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
        ,drvNM107_NameSuffix1 = CASE WHEN BdmRecType = 'EMP' THEN 
                                        CASE WHEN EepNameSuffix = 'Z' THEN '' ELSE EepNameSuffix END
                                     WHEN BdmRecType = 'DEP' THEN 
                                        CASE WHEN ConNameSuffix = 'Z' THEN '' ELSE ConNameSuffix END
                                END
        ,drvNM108_IDCodeQualifier1 = CASE WHEN BdmRecType = 'EMP' AND (ISNULL(EepSSN, '') <> '' OR LEFT(EepSSN, 3) NOT IN ('000', '999')) THEN '34'
                                          WHEN BdmRecType = 'DEP' AND (ISNULL(ConSSN, '') <> '' OR LEFT(ConSSN, 3) NOT IN ('000', '999')) THEN '34'
                                     END
        ,drvNM109_IDCode1 = CASE WHEN BdmRecType = 'EMP' AND ISNULL(EepSSN, '') <> '' THEN EepSSN
                                 WHEN BdmRecType = 'DEP' AND ISNULL(ConSSN, '') <> '' THEN ConSSN
                            END
        ,drvPER02_Name = ''
        ,drvPER03_CommNumberQualifier = CASE WHEN BdmRecType = 'EMP' AND ISNULL(EepAddressEMail,'') <> '' THEN 'EM' END
        ,drvPER04_CommunicationNumber = CASE WHEN BdmRecType = 'EMP' THEN ISNULL(EepAddressEMail,'') END
        ,drvPER05_CommNumberQualifier = CASE WHEN BdmRecType = 'EMP' AND ISNULL(EepPhoneHomeNumber,'') <> '' THEN 'HP' END
        ,drvPER06_CommunicationNumber = CASE WHEN BdmRecType = 'EMP' THEN ISNULL(EepPhoneHomeNumber,'') END
        ,drvPER07_CommNumberQualifier = '' --CASE WHEN BdmRecType = 'EMP' THEN 'EM' END
        ,drvPER08_CommunicationNumber = '' --CASE WHEN BdmRecType = 'EMP' THEN ISNULL(eepAddressEMail,'') END
        ,drvN301_AddressLine1 = REPLACE(dbo.dsi_fnRemoveChars('.,/-',EepAddressLine1)  COLLATE Latin1_General_100_BIN2, N'½', N'1 Half')
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
                                                CASE WHEN EepMaritalStatus = 'S' THEN 'I' 
                                                    WHEN ISNULL(EepMaritalStatus, '') = '' OR EepMaritalStatus = 'Z' THEN 'U' 
                                                    ELSE EepMaritalStatus END
                                       END
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
    INTO dbo.U_EIWABNKMED_DrvTbl
    FROM dbo.U_EIWABNKMED_EELIST WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    JOIN dbo.U_dsi_bdm_EIWABNKMED WITH (NOLOCK)
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
    IF OBJECT_ID('U_EIWABNKMED_DrvTbl_2300','U') IS NOT NULL
        DROP TABLE dbo.U_EIWABNKMED_DrvTbl_2300;
    SELECT DISTINCT
        -- If drvHD00_HealthCoverage Populated, then send HD Segment
        drvHD00_HealthCoverage =    --CASE WHEN NOT (BdmRecType = 'DEP' AND ConRelationship IN ('SPS', 'DP') AND OldBenOption IS NOT NULL) THEN
                                    --CASE WHEN NOT ( OldBenOption IS NOT NULL) THEN
                                        CASE WHEN BdmDedType IN ('MED') THEN 'HD'
                                            WHEN BdmDedType IN ('DEN') THEN 'HD'
                                            WHEN BdmDedType IN ('VIS') THEN 'HD'
                                        END
                                    --END
        ,drvHD01_MaintTypeCode = '030' --Audit or Compare
        ,drvHD02_MaintReasonCode = CASE WHEN BdmDedType IN ('MED') THEN ''
                                           WHEN BdmDedType IN ('DEN') THEN ''
                                           WHEN BdmDedType IN ('VIS') THEN ''
                                     END
        ,drvHD03_InsuranceLineCode = CASE WHEN BdmDedType IN ('MED') THEN 'HLT'
                                           WHEN BdmDedType IN ('DEN') THEN 'DEN'
                                           WHEN BdmDedType IN ('VIS') THEN 'VIS'
                                     END
        ,drvHD04_PlanCoverageDesc =    CASE WHEN BdmDedCode IN ('427', '430') THEN 'HD20'
                                        WHEN BdmDedCode IN ('428', '431') THEN 'HD35'
                                        WHEN BdmDedCode IN ('426', '429') THEN 'HD55'
                                    END
                                                                    
        ,drvHD05_CoverageLevelCode = CASE WHEN ObOldBenOption IS NOT NULL AND BdmStopDate IS NULL THEN --'!!!!' -- take the vlaue from the audit table -- JCB
                                            CASE WHEN ObOldBenOption IN ('EE') THEN 'EMP'
                                                WHEN ObOldBenOption IN ('EEC') THEN 'ECH'
                                                WHEN ObOldBenOption IN ('EES', 'EEDP', 'EEF', 'EEDPF') THEN 'FAM'
                                            END
                                        ELSE
                                            CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN
                                                CASE WHEN BdmBenOption IN ('EE') THEN 'EMP'
                                                     WHEN BdmBenOption IN ('EEC') THEN 'ECH'
                                                    -- WHEN BdmBenOption IN ('@ECHBenOpts') THEN 'ECH'
                                                     WHEN BdmBenOption IN ('EES', 'EEDP', 'EEF', 'EEDPF') THEN 'FAM'
                                                END
                                            END
                                        END
        -- If drvDTP00_DateTime_348 Populated, then send DTP*348 Segment
        ,drvDTP00_DateTime_348 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN 'DTP' END
        ,drvDTP01_DateTimeQualifier_348 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '348' END
        ,drvDTP02_DateTimeFormatQual_348 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN 'D8' END
        ,drvDTP03_DateTimePeriod_348 =    CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN 
                                            CASE WHEN ObOldBenOption IS NOT NULL AND ObSource = 'Audit' THEN (SELECT TOP 1 audOldValue FROM dbo.U_EIWABNKMED_Audit WITH (NOLOCK) WHERE audTableName = 'EmpDed' AND audFieldName = 'EedBenStartDate' AND audAction = 'Update' AND AudRowNo = 1 AND AudOldValue NOT IN ('Z') AND AudNewValue NOT IN ('Z') AND AudEEID = xEEID)
											WHEN ObOldBenOption IS NOT NULL AND ObSource = 'HDed' THEN BdmBenStartDate --- '1/1/1900'
                                            ELSE dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate) 
                                            END
                                        END
        -- If drvDTP00_DateTime_349 Populated, then send DTP*349 Segment
        ,drvDTP00_DateTime_349 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') AND (BdmBenStopDate IS NOT NULL OR ObOldBenOption IS NOT NULL) THEN 'DTP' END
        ,drvDTP01_DateTimeQualifier_349 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') AND (BdmBenStopDate IS NOT NULL OR ObOldBenOption IS NOT NULL) THEN '349' END
        ,drvDTP02_DateTimeFormatQual_349 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') AND (BdmBenStopDate IS NOT NULL OR ObOldBenOption IS NOT NULL) THEN 'D8' END
        ,drvDTP03_DateTimePeriod_349 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN 
                                            CASE WHEN BdmBenStopDate IS NOT NULL THEN BdmBenStopDAte
                                                WHEN ObOldBenOption IS NOT NULL AND ObSource = 'Audit' THEN DATEADd(DAY, -1, BdmBenStartDate) 
												WHEN ObOldBenOption IS NOT NULL AND ObSource = 'HDed' THEN  '12/31/' + CAST(DATEPART(YEAR, GETDATE()) AS VARCHAR) --   '1/1/1900'
												ELSE BdmBenStartDate 
											END
                                           /* CASE WHEN BdmBenStopDate IS NOT NULL AND OldBenOption IS NULL THEN   BdmBenStopDate 
                                                WHEN OldBenOption IS NOT NULL THEN BdmBenStopDate --  DATEADD(DAY, -1, dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate)) -- (SELECT TOP 1 audOldValue FROM dbo.U_EIWABNKMED_Audit WITH (NOLOCK) WHERE audTableName = 'EmpDed' AND audFieldName = 'EedBenStartDate' AND audAction = 'Update' AND AudRowNo = 1 AND AudOldValue NOT IN ('Z') AND AudNewValue NOT IN ('Z') AND AudEEID = xEEID)
                                            END*/
                                        END 
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
                      + ' ' + BdmDedCode
                      + ' 1' 
                      --+ ' : ' + IsNull(OldBenOption, 'nope') + ' :: ' + IsNull(BdmBenStopDate, 'nope')
    INTO dbo.U_EIWABNKMED_DrvTbl_2300
    FROM dbo.U_EIWABNKMED_EELIST WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.U_dsi_bdm_EIWABNKMED WITH (NOLOCK)
        ON BdmEEID = xEEID
        AND BdmCOID = xCOID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
    LEFT JOIN dbo.U_EIWABNKMED_OldBenOptions WITH (NOLOCK)
		ON ObEEID = xEEID
		AND ObCOID = xCOID
		AND ObDedCode = BdmDedCode
    ;




    INSERT INTO dbo.U_EIWABNKMED_DrvTbl_2300
    SELECT DISTINCT
        drvHD00_HealthCoverage =   --CASE WHEN NOT (BdmRecType = 'DEP' AND ConRelationship IN ('SPS', 'DP') AND ObOldBenOption IS NOT NULL) THEN
									CASE WHEN ObOldBenOption IS NOT NULL THEN 
                                    --CASE WHEN NOT ( OldBenOption IS NOT NULL) THEN
                                        CASE WHEN BdmDedType IN ('MED') THEN 'HD'
                                            WHEN BdmDedType IN ('DEN') THEN 'HD'
                                            WHEN BdmDedType IN ('VIS') THEN 'HD'
                                        END
                            END
        ,drvHD01_MaintTypeCode = '030'
        ,drvHD02_MaintReasonCode =  CASE WHEN BdmDedType IN ('MED') THEN ''
                                           WHEN BdmDedType IN ('DEN') THEN ''
                                           WHEN BdmDedType IN ('VIS') THEN ''
                                     END
        ,drvHD03_InsuranceLineCode = CASE WHEN BdmDedType IN ('MED') THEN 'HLT'
                                           WHEN BdmDedType IN ('DEN') THEN 'DEN'
                                           WHEN BdmDedType IN ('VIS') THEN 'VIS'
                                     END
        ,drvHD04_PlanCoverageDesc =    CASE WHEN ObOldBenOption IS NOT NULL THEN
                                        CASE WHEN BdmDedCode IN ('427', '430') THEN 'HD20'
                                            WHEN BdmDedCode IN ('428', '431') THEN 'HD35'
                                            WHEN BdmDedCode IN ('426', '429') THEN 'HD55'
                                        END
                                    END
        ,drvHD05_CoverageLevelCode = 
                                            CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN
                                                CASE WHEN BdmBenOption IN ('EE') THEN 'EMP'
                                                     WHEN BdmBenOption IN ('EEC') THEN 'ECH'
                                                    -- WHEN BdmBenOption IN ('@ECHBenOpts') THEN 'ECH'
                                                     WHEN BdmBenOption IN ('EES', 'EEDP', 'EEF', 'EEDPF') THEN 'FAM'
                                                END
                                            END
                                        --END
        
        
        -- If drvDTP00_DateTime_348 Populated, then send DTP*348 Segment
        ,drvDTP00_DateTime_348 = CASE WHEN ObOldBenOption IS NOT NULL THEN 'DTP' END
        ,drvDTP01_DateTimeQualifier_348 
        ,drvDTP02_DateTimeFormatQual_348 
        ,drvDTP03_DateTimePeriod_348 = dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate)
        -- If drvDTP00_DateTime_349 Populated, then send DTP*349 Segment
        ,drvDTP00_DateTime_349 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') AND (BdmBenStopDate IS NOT NULL /*OR OldBenOption IS NOT NULL*/) THEN 'DTP' END -- JCB
        ,drvDTP01_DateTimeQualifier_349
        ,drvDTP02_DateTimeFormatQual_349 
        ,drvDTP03_DateTimePeriod_349 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN 
                                            CASE WHEN BdmBenStopDate IS NOT NULL AND ObOldBenOption IS NULL THEN BdmBenStopDate
                                                WHEN ObOldBenOption IS NOT NULL THEN DATEADD(DAY, -1, dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate)) -- (SELECT TOP 1 audOldValue FROM dbo.U_EIWABNKMED_Audit WITH (NOLOCK) WHERE audTableName = 'EmpDed' AND audFieldName = 'EedBenStartDate' AND audAction = 'Update' AND AudRowNo = 1 AND AudOldValue NOT IN ('Z') AND AudNewValue NOT IN ('Z') AND AudEEID = xEEID)
                                            END
                                        END 
        -- If drvDTP00_DateTime_303 = 'DTP', then Send DTP*303 Segment
        ,drvDTP00_DateTime_303
        ,drvDTP01_DateTimeQualifier_303 
        ,drvDTP02_DateTimeFormatQual_303 
        ,drvDTP03_DateTimePeriod_303 = ''
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
        --=====================
        -- Loop 2700 RECORDS
        --=====================
        -- If drvLS01_LoopIDCode is Populated, then send LS Segment
        ,drvLS01_LoopIDCode  
        -- If drvLX01_AssignedNumber is Populated, then send LX Segment
        ,drvLX01_AssignedNumber 
        --=====================
        -- Loop 2750 RECORDS
        --=====================
        -- If drvN101_EntityIDCodeSponsor is Populated, then send N1 Segment
        ,drvN101_EntityIDCodeSponsor = ''
        ,drvN102_Name 
        -- If drvREF01_RefNumberQual is Populated, then send REF Segment
        ,drvREF01_RefNumberQual = ''
        ,drvREF02_RefNumberDesc 
        -- If drvLE01_LoopIDCode is Populated, then send LE Segment
        ,drvLE01_LoopIDCode 
        ---------------------------------
        ,drvEEID 
        ,drvCOID 
        ,drvDepRecID = ConSystemID
        ,drvSSN 
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = CONVERT(CHAR(9),RTRIM(EepSSN)) + CONVERT(CHAR(12),ISNULL(ConSystemID,''))
                        + ' ' + BdmDedCode
                      
                       + ' 2'
    FROM  dbo.U_EIWABNKMED_DrvTbl_2300
    JOIN dbo.U_dsi_bdm_EIWABNKMED WITH (NOLOCK)
        ON BdmEEID = drvEEID
        AND BdmCOID = drvCOID
		AND BdmBenStatus = 'A'
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON drvEEID = EepEEID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = drvEEID
        AND ConSystemID = BdmDepRecID
	JOIN dbo.U_EIWABNKMED_OldBenOptions WITH (NOLOCK)
		ON ObEEID = drvEEID
		AND ObCOID = drvCOID
		AND ObDedCode = BdmDedCode
    ;
        

      









    /**************************************************************************************************
        TRAILER RECORDS
            - SE, GE, IEA Segments
    **************************************************************************************************/
    ---------------------
    -- TRAILER RECORD
    --------------------
    IF OBJECT_ID('U_EIWABNKMED_TrlTbl') IS NOT NULL
        DROP TABLE dbo.U_EIWABNKMED_TrlTbl;
    SELECT DISTINCT drvSE01_SegmentCount = '9999'
    INTO dbo.U_EIWABNKMED_TrlTbl;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable('EIWABNKMED','UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = 'UPB_EIWABNKMED_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
        WHERE FormatCode = 'EIWABNKMED';
    END;

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEIWABNKMED_Export AS
    SELECT TOP 20000000 DATA FROM dbo.U_EIWABNKMED_File (NOLOCK)
    ORDER BY CASE LEFT(Recordset,1) WHEN 'H' THEN 1 WHEN 'D' THEN 2 ELSE 3 END, InitialSort, SubSort, RIGHT(Recordset,2)
GO

--Check out AscDefF
SELECT * FROM dbo.AscDef
WHERE AdfHeaderSystemID LIKE 'EIWABNKMED%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET ExpLastStartPerControl = '202010011'
       ,ExpStartPerControl     = '202010011'
       ,ExpLastEndPerControl   = '202010319'
       ,ExpEndPerControl       = '202010319'
WHERE ExpFormatCode = 'EIWABNKMED';

**********************************************************************************/
