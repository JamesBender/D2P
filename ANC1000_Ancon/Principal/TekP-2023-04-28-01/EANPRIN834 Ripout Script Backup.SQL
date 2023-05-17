USE [ULTIPRO_WPANCON]
GO
/****** Object:  StoredProcedure [dbo].[dsi_sp_BuildDriverTables_EANPRIN834]    Script Date: 5/8/2023 11:23:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EANPRIN834]
    @systemid CHAR(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client: Ancon Marine

Created By: Marie Waters
Business Analyst: Cheryl Petitti
Create Date: 11/04/2022
Service Request Number: TekP-2022-08-10-01

Purpose: Principal Benefit Export

Revision History
----------------
Update By           Date			Request Num			Desc
Anthony Ramos		04/24/2023		SR 00410261			Added RELI6 dedcode
Marie Waters		05/01/2023		TekP-2023-04-28-01  Added code to Audit table to pull BenTerm date and stop future startdates populating for UNUM dedcode  


SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EANPRIN834';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EANPRIN834';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EANPRIN834';
SELECT * FROM dbo.AscExp WHERE expFormatCode = 'EANPRIN834';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EANPRIN834' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EANPRIN834', 'FULLFILE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EANPRIN834', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EANPRIN834', 'CHANGES';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EANPRIN834', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EANPRIN834', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EANPRIN834', 'SCHEDULED';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EANPRIN834';

EXEC dbo._dsi_usp_ExportRipOut_V7_4 @FormatCode = 'EANPRIN834', @AllObjects = 'Y', @IsWeb = 'Y';
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
        ,@FileMinCovDate  = '09/01/2022'
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = 'EANPRIN834';

    --==========================================
    -- Deduction Code List
    --==========================================
    DECLARE @DedList VARCHAR(MAX);
    SET @DedList = 'UNUM,RELI1,RELI3,RELI4,RELI5,ADEN2,AVIS,RELI6'; -- AR SR 00410261 Added RELI6

    IF OBJECT_ID('U_EANPRIN834_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EANPRIN834_DedList;
    SELECT DedCode = DedDedCode
        ,DedLongDesc
        ,DedType = DedDedType
    INTO dbo.U_EANPRIN834_DedList
    FROM dbo.dsi_BDM_fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

    --==========================================
    -- Clean EE List
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EANPRIN834_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCoID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EANPRIN834_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    IF @ExportCode LIKE 'OE%'
    BEGIN
        -- Remove Employees that Do Not Have a Benefit Plan in Deduction Code List
        DELETE FROM dbo.U_EANPRIN834_EEList
        WHERE NOT EXISTS (SELECT 1 FROM dbo.EmpDed JOIN dbo.U_EANPRIN834_DedList ON DedCode = EedDeDCode WHERE EedEEID = xEEID);
    END;



	----==========================================
    ---- Audit Section
    ----==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EANPRIN834_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EANPRIN834_AuditFields;
    CREATE TABLE dbo.U_EANPRIN834_AuditFields (aTableName varchar(30),aFieldName varchar(30));
	INSERT INTO dbo.U_EANPRIN834_AuditFields VALUES ('EmpComp','EecEmplStatus');
--	INSERT INTO dbo.U_EANPRIN834_AuditFields VALUES ('EmpDed','EedBenStoDate');
    INSERT INTO dbo.U_EANPRIN834_AuditFields VALUES ('EmpDed', 'EedBenStatus');
    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EANPRIN834_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EANPRIN834_Audit;
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
		,audBenTermed = CASE WHEN audTableName = 'EmpDed' AND audFieldName = 'EedBenStatus' AND ISNULL(audNewValue , '') = 'T' THEN 'Y' ELSE 'N' END
		,audTermed = CASE WHEN audTableName = 'EmpComp' AND audFieldName ='EecEmplStatus' AND ISNULL(audNewValue, '') =  'T' THEN 'Y' ELSE 'N' END
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    INTO dbo.U_EANPRIN834_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EANPRIN834_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EANPRIN834_Audit ON dbo.U_EANPRIN834_Audit (audEEID,audKey2);


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
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsChild','CHD, CHL, DPC, STC');
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

	INSERT INTO dbo.U_dsi_bdm_DepDeductions (dbnformatcode, dbncoid, dbneeid, dbndeprecid, dedeebenamt, dbnbenoption, dbnbenstatus, dbnbenstartdate, dbnbenstopdate, dbndedcode, dbnvalidforexport, deddedcode, deddedtype)
      (SELECT eedformatcode
			  , ee.eedcoid
			  , ee.eedeeid
			  , consystemid
			  , ee.eedbenamt
			  , ee.eedbenoption
			  , ee.eedbenstatus
			  , ee.eedbenstartdate
			  , ee.eedbenstopdate
			  , ee.eeddedcode
			  , ee.eedvalidforexport
			  , ee.eeddedcode
			  , ee.deddedtype
		 FROM dbo.empded ed WITH (nolock)
		 JOIN dbo.emppers WITH (nolock) ON eepeeid = ed.eedeeid
		 JOIN dbo.u_dsi_bdm_EmpDeductions ee WITH (nolock) 
			ON ee.eedeeid = ed.eedeeid 
			AND ee.eedcoid = ed.eedcoid
			AND eedFormatCode = 'EANPRIN834' AND eedValidForExport = 'Y'
			AND ee.eeddedcode = ed.eeddedcode
		 JOIN dbo.contacts WITH (nolock) 
			ON eedDepRecID = consystemid
			WHERE ee.eeddedcode IN ('RELI3')
		--AND NOT Exists (SELECT 1 FROM dbo.U_dsi_bdm_DepDeductions WHERE dbnformatcode = 'EANPRIN834' AND dbndeprecid = ed.eeddeprecid AND dbndedcode = ee.eeddedcode)
		AND ( (ee.eedeeid  not in  (SELECT dbneeid FROM dbo.U_dsi_bdm_DepDeductions WHERE dbnformatcode = 'EANPRIN834' AND dbndeprecid = ed.eeddeprecid AND dbndedcode In ('ADEN2','AVIS')))
		OR  consystemid  IN   (SELECT DbnDepRecID FROM dbo.U_dsi_bdm_DepDeductions WHERE dbnformatcode = 'EANPRIN834' and dbndedcode In ('ADEN2','AVIS') and dbnBenstopdate is not null 
				and  dbnRelationship IN ('SPS', 'DP'))))
		;
   
	--EXEC dbo.dsi_bdm_sp_BuildConsolidatedTable 'EANPRIN834', 'Standard';

	--	 INSERT INTO [dbo].[U_dsi_BDM_EANPRIN834]
 --       (    [BdmRecType]
 --          ,[BdmCOID]
 --          ,[BdmEEID]
 --          ,[BdmDepRecID]
 --          ,[BdmSystemID]
 --          ,[BdmRunID]          
 --          ,[BdmRelationship]
 --          ,[BdmDateOfBirth]
 --          ,[BdmDedCode]
 --          ,[BdmBenOption]
 --          ,[BdmBenStatus]
 --          ,[BdmBenStartDate]
 --          ,[BdmBenStopDate]
 --          ,[BdmBenStatusDate]       
 --       )
 --     SELECT 'EMP'	        
	--		  , ee.eedcoid
	--		  , ee.eedeeid
	--	      , ''
	--		  , ''
	--		  , ''
	--		  ,'EMP'			 
	--		  ,EepDateOfBirth
	--		  , ee.eeddedcode
	--		  , ee.eedbenoption
	--		  , ee.eedbenstatus
	--		  , ee.eedbenstartdate
	--		  , ee.eedbenstopdate
	--		  , ee.EedBenStatusDate			  
	--	 FROM dbo.empded ed WITH (nolock)
	--	 JOIN dbo.emppers WITH (nolock) ON eepeeid = ed.eedeeid
	--	 LEFT JOIN dbo.u_dsi_bdm_EmpDeductions ee WITH (nolock) 
	--		ON ee.eedeeid = ed.eedeeid 
	--		AND ee.eedcoid = ed.eedcoid
	--		AND eedFormatCode = 'EANPRIN834'
	--		AND ee.eeddedcode = ed.eeddedcode
	--	   --JOIn dbo.U_EANPRIN834_Audit With (NOLOCK) 
	--	   --ON audeeid = ee.eedeeid and audKey2 = ee.eedcoid
	--	WHERE ee.eeddedcode IN ('UNUM','RELI1','RELI3','RELI4','RELI5','ADEN2','AVIS','RELI6')
	--		 and ee.eedBenstatus Not in ('W', 'C')
	--		--and ee.eedeeid = 'EOW4B7000020'
	--		 and ee.EedBenStartDate > = @StartDate and ee.eedbenstopdate is not null			 
	--	--AND NOT Exists (SELECT 1 FROM dbo.U_dsi_bdm_DepDeductions WHERE dbnformatcode = 'EANPRIN834' AND dbndeprecid = ed.eeddeprecid AND dbndedcode = ee.eeddedcode)
	--	AND  ee.eedeeid  not in  (SELECT distinct  Bdmeeid FROM  dbo.U_dsi_bdm_EANPRIN834 )


    ----=========================================
    ---- Update BdmChangeReason For Dependents
    ----=========================================
    --UPDATE D
    --    SET D.BdmChangeReason = E.BdmChangeReason
    --FROM dbo.U_dsi_bdm_EANPRIN834 D
    --JOIN dbo.U_dsi_bdm_EANPRIN834 E
    --    ON E.BdmEEID = D.BdmEEID
    --    AND E.BdmCOID = D.BdmCOID
    --    AND E.BdmDedCode = D.BdmDedCode
    --WHERE D.BdmRecType = 'DEP' AND E.BdmRecType = 'EMP';

    ----=====================================================
    ---- Update BdmUSGField2 with EmpDedTVID for Employees
    ----=====================================================
    --UPDATE dbo.U_dsi_bdm_EANPRIN834
    --    SET BdmUSGField2 = EedEmpDedTVID
    --FROM dbo.U_dsi_bdm_EANPRIN834
    --JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
    --    ON EedEEID = BdmEEID
    --    AND EedCOID = BdmCOID
    --    AND EedDedCode = BdmDedCode
    --WHERE BdmRecType = 'EMP' AND EedFormatCode = @FormatCode AND EedValidForExport = 'Y';

    ----=======================================================
    ---- Update BdmUSGField2 with DepBPlanTVID for Dependents
    ----=======================================================
    --UPDATE dbo.U_dsi_bdm_EANPRIN834
    --    SET BdmUSGField2 = DbnDepBPlanTVID
    --FROM dbo.U_dsi_bdm_EANPRIN834
    --JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
    --    ON DbnEEID = BdmEEID
    --    AND DbnCOID = BdmCOID
    --    AND DbnDedCode = BdmDedCode
    --WHERE BdmRecType = 'DEP' AND DbnFormatCode = @FormatCode AND DbnValidForExport = 'Y';

    ----======================================================
    ---- Update BdmUSGField1 with Benefit Amount (BdmBenAmt)
    ----======================================================
    --UPDATE dbo.U_dsi_bdm_EANPRIN834
    --    SET BdmUSGField1 = CONVERT(VARCHAR(20),BdmEEAmt)
    --FROM dbo.U_dsi_bdm_EANPRIN834
    --JOIN dbo.EmpDedFull WITH (NOLOCK)
    --    ON EedEmpDedTVID = BdmUSGField2;

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
    IF OBJECT_ID('U_EANPRIN834_HdrTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EANPRIN834_HdrTbl;
    SELECT DISTINCT drvISA05_SenderIDQual = '30'
        ,drvISA06_SenderID = '330392593'
        ,drvISA07_ReceiverIDQual = '30'
        ,drvISA08_ReceiverID = '42-0127290'
        ,drvISA09_InterchangeDate = RIGHT(@RunDate,6)
        ,drvISA10_InterchangeTime = @RunTime
        ,drvISA15_UsageIndicator = CASE WHEN @ExportCode LIKE '%TEST%' THEN 'T' ELSE 'P' END
        ,drvISA16_ComponentSeprator = ':'
        ,drvGS02_SenderID = '330392593'
        ,drvGS03_ReceiverID = '42-0127290'
        ,drvGS04_Date = @RunDate
        ,drvGS05_Time = @RunTime
        ,drvBGN03_Date = @RunDate
        ,drvBGN04_Time = @RunTime
        ,drvBGN05_TimeCode = 'ET'
        ,drvBGN06_RefID = ''
        ,drvBGN07_TransTypeCode = ''
        ,drvBGN08_ActionCode = '4'
        ,drvREF01_RefNumberQual = '38'
        ,drvREF02_RefNumberQual = '1161386'
        ,drvDTP00_DateTime0 = 'DTP'
        ,drvDTP01_DateTimeQualifier0 = '007'
        ,drvDTP02_DateTimeFormatQual0 = 'D8'
        ,drvDTP03_DateTimePeriod0 = @RunDate
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
        ,drvN102_Name1 = 'Ancon Marine Inc'
        ,drvN103_IDCodeQual1 = 'FI'
        ,drvN104_IDCode1 = '330392593'
        ,drvN101_EntityIDCodeSponsor2 = 'IN'
        ,drvN102_Name2 = 'Principal Financial Group'
        ,drvN103_IDCodeQual2 = 'FI'
        ,drvN104_IDCode2 = '42-0127290'
    INTO dbo.U_EANPRIN834_HdrTbl
    FROM dbo.U_EANPRIN834_EELIST WITH (NOLOCK)
    JOIN dbo.U_dsi_bdm_EANPRIN834 WITH (NOLOCK)
        ON BdmEEID = xEEID
        AND BdmCOID = xCOID
		;

    /**************************************************************************************************************
        DETAIL RECORDS
            -- LOOP 2000 RECORDS - INS, REF, DTP Segments
            -- LOOP 2100A RECORDS - NM1, PER, N3, N4, DMG, ICM Segments
            -- LOOP 2100B RECORDS - NM1, DMG Segments
    ***************************************************************************************************************/

    -------------------
    -- DETAIL RECORD 
    -------------------
    IF OBJECT_ID('U_EANPRIN834_DrvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EANPRIN834_DrvTbl;
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
                                            WHEN ConRelationship IN (SELECT * FROM dbo.dsi_BDM_fn_ListToTable('DP')) THEN '53'
                                            WHEN ConRelationship IN (SELECT * FROM dbo.dsi_BDM_fn_ListToTable('CHD, CHL, DPC, STC')) THEN '19'
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
                                                     --WHEN EecFullTimeOrPartTime = 'P' THEN 'PT' --Part time active employee
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
        ,drvINS11_DateTimeFormatQual = CASE WHEN (ISNULL(EepDateDeceased, '') <> '' or Isnull(ConDeathDate, '') <> '') THEN 'D8' END
        ,drvINS12_DateTimePeriod = CASE WHEN ISNULL(EepDateDeceased, '') <> '' THEN CONVERT(VARCHAR(8),EepDateDeceased,112) 
                                        WHEN ISNULL(ConDeathDate, '') <> '' THEN CONVERT(VARCHAR(8),ConDeathDate,112) END
        -- If drvREF01_RefNumberQual1 is Populated, then send REF Segment
        ,drvREF01_RefNumberQual1 = ''
        ,drvREF02_RefNumberQual1 = eepssn
        -- If drvREF01_RefNumberQual2 is Populated, then send REF Segment
        ,drvREF01_RefNumberQual2 = '1L'
        ,drvREF02_RefNumberQual2 = '1161386'
        -- If drvREF01_RefNumberQual3 is Populated, then send REF Segment
        ,drvREF01_RefNumberQual3 = 'DX'
        ,drvREF02_RefNumberQual3 = CASE WHEN EecCoID IN ('49VMT','49VPF','BQLK7') THEN '00001'
                                        WHEN EecCoID IN ('49VSW')  THEN '00002' 
                                    END
		
        -- If drvREF01_RefNumberQual3 is Populated, then send REF Segment
        ,drvREF01_RefNumberQual4 = 'ZZ'
        ,drvREF02_RefNumberQual4 =   CASE  WHEN  EepAddressState = 'CA' THEN '00001'
                                           WHEN  EepAddressState <> 'CA'  THEN '00002'
                                        END
		
									--CASE When LocAddressState = 'CA' THEN '00001'
         --                                  When LocAddressState <> 'CA'  THEN '00002'
         --                               END

    -- If drvREF01_RefNumberQual4 is Populated, then send REF Segment

									
        ,drvREF01_RefNumberQual5 =  ''--CASE WHEN Reli3DedCod = 'RELI3'  THEN   '17' END
										
  
        ,drvREF02_RefNumberQual5 = ''--CASE WHEN Reli3DedCod = 'RELI3'   and  Ltrim(rtrim(LocAddressState)) IN ( 'CA')  THEN '00001'
                                     --       WHEN Reli3DedCod = 'RELI3' and  Ltrim(rtrim(LocAddressState)) NOT IN ( 'CA') THEN '00002'
                              		--END

      
               -- If drvDTP00_DateTime1 is Populated, then send DTP Segment
        ,drvDTP00_DateTime1 =  CASE WHEN (BdmRecType = 'DEP' and conrelationship = 'SPS' AND  bdmdedcode IN ('RELI3') and BdmDepRecID not in (SELECT d.BdmDepRecID  FROM dbo.U_dsi_bdm_EANPRIN834 d Where  d.bdmdedcode in ('ADEN2','AVIS') and d.bdmeeid = bdmeeid)) THEN '' ELSE 'DTP' END
        ,drvDTP01_DateTimeQualifier1 = CASE WHEN (BdmRecType = 'DEP' and conrelationship = 'SPS' AND  bdmdedcode IN ('RELI3') and BdmDepRecID not in (SELECT d.BdmDepRecID  FROM dbo.U_dsi_bdm_EANPRIN834 d Where  d.bdmdedcode in ('ADEN2','AVIS') and d.bdmeeid = bdmeeid))  THEN '' ELSE '300' END
        ,drvDTP02_DateTimeFormatQual1 = CASE WHEN (BdmRecType = 'DEP' and conrelationship = 'SPS' AND  bdmdedcode IN ('RELI3') and BdmDepRecID not in (SELECT d.BdmDepRecID  FROM dbo.U_dsi_bdm_EANPRIN834 d Where  d.bdmdedcode in ('ADEN2','AVIS') and d.bdmeeid = bdmeeid))  THEN '' ELSE 'D8' END
        ,drvDTP03_DateTimePeriod1 = CASE WHEN (BdmRecType = 'DEP' and conrelationship = 'SPS' AND  bdmdedcode IN ('RELI3') and BdmDepRecID not in (SELECT d.BdmDepRecID  FROM dbo.U_dsi_bdm_EANPRIN834 d Where  d.bdmdedcode in ('ADEN2','AVIS') and d.bdmeeid = bdmeeid))  THEN '' ELSE BenStartDate END
        -- If drvDTP00_DateTime2 is Populated, then send DTP Segment
        ,drvDTP00_DateTime2 = CASE WHEN (BdmRecType = 'DEP' and conrelationship = 'SPS' AND  bdmdedcode IN ('RELI3') and BdmDepRecID not in (SELECT d.BdmDepRecID  FROM dbo.U_dsi_bdm_EANPRIN834 d Where  d.bdmdedcode in ('ADEN2','AVIS') and d.bdmeeid = bdmeeid))  THEN '' ELSE 'DTP' END
        ,drvDTP01_DateTimeQualifier2 =  CASE WHEN (BdmRecType = 'DEP' and conrelationship = 'SPS' AND  bdmdedcode IN ('RELI3') and BdmDepRecID not in (SELECT d.BdmDepRecID  FROM dbo.U_dsi_bdm_EANPRIN834 d Where  d.bdmdedcode in ('ADEN2','AVIS') and d.bdmeeid = bdmeeid))  THEN '' ELSE '303' END
        ,drvDTP02_DateTimeFormatQual2 =  CASE WHEN (BdmRecType = 'DEP' and conrelationship = 'SPS' AND  bdmdedcode IN ('RELI3') and BdmDepRecID not in (SELECT d.BdmDepRecID  FROM dbo.U_dsi_bdm_EANPRIN834 d Where  d.bdmdedcode in ('ADEN2','AVIS') and d.bdmeeid = bdmeeid))  THEN '' ELSE 'D8' END
        ,drvDTP03_DateTimePeriod2 =  CASE WHEN (BdmRecType = 'DEP' and conrelationship = 'SPS' AND  bdmdedcode IN ('RELI3') and BdmDepRecID not in (SELECT d.BdmDepRecID  FROM dbo.U_dsi_bdm_EANPRIN834 d Where  d.bdmdedcode in ('ADEN2','AVIS') and d.bdmeeid = bdmeeid))  THEN ''  ELSE dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(xEEID, xCOID, GETDATE(), EecDateOfLastHire) END
        -- If drvDTP00_DateTime3 is Populated, then send DTP Segment
        ,drvDTP00_DateTime3 =  CASE WHEN (BdmRecType = 'DEP' and conrelationship = 'SPS' AND  bdmdedcode IN ('RELI3') and BdmDepRecID not in (SELECT d.BdmDepRecID  FROM dbo.U_dsi_bdm_EANPRIN834 d Where  d.bdmdedcode in ('ADEN2','AVIS') and d.bdmeeid = bdmeeid))  THEN '' ELSE 'DTP' END
        ,drvDTP01_DateTimeQualifier3 =  CASE WHEN (BdmRecType = 'DEP' and conrelationship = 'SPS' AND  bdmdedcode IN ('RELI3') and BdmDepRecID not in (SELECT d.BdmDepRecID  FROM dbo.U_dsi_bdm_EANPRIN834 d Where  d.bdmdedcode in ('ADEN2','AVIS') and d.bdmeeid = bdmeeid))  THEN '' ELSE '336' END
        ,drvDTP02_DateTimeFormatQual3 =  CASE WHEN (BdmRecType = 'DEP' and conrelationship = 'SPS' AND  bdmdedcode IN ('RELI3') and BdmDepRecID not in (SELECT d.BdmDepRecID  FROM dbo.U_dsi_bdm_EANPRIN834 d Where  d.bdmdedcode in ('ADEN2','AVIS') and d.bdmeeid = bdmeeid))  THEN '' ELSE 'D8' END
        ,drvDTP03_DateTimePeriod3 =  CASE WHEN (BdmRecType = 'DEP' and conrelationship = 'SPS' AND  bdmdedcode IN ('RELI3') and BdmDepRecID not in (SELECT d.BdmDepRecID  FROM dbo.U_dsi_bdm_EANPRIN834 d Where  d.bdmdedcode in ('ADEN2','AVIS') and d.bdmeeid = bdmeeid))  THEN '' ELSE EecDateOfLastHire END
       --If drvDTP00_DateTime4 is Populated, then send DTP Segment
        ,drvDTP00_DateTime4 = CASE WHEN EecEmplStatus = 'T'  THEN'DTP' END
        ,drvDTP01_DateTimeQualifier4 = CASE WHEN EecEmplStatus = 'T'  THEN '337' END
        ,drvDTP02_DateTimeFormatQual4 = CASE WHEN EecEmplStatus = 'T' THEN 'D8' END
        ,drvDTP03_DateTimePeriod4 = CASE WHEN EecEmplStatus = 'T' THEN EecDateofTermination  END --EecDateLastWorked
        -- If drvDTP00_DateTime5 is Populated, then send DTP Segment
        ,drvDTP00_DateTime5 = CASE WHEN (EecFullTimeOrPartTime = 'F' and(FT.Oldvalue = 'P' and FT.NewValue = 'F') ) THEN 'DTP' END
        ,drvDTP01_DateTimeQualifier5 = CASE WHEN  (EecFullTimeOrPartTime = 'F' and(FT.Oldvalue = 'P' and FT.NewValue = 'F') ) THEN '356' END
        ,drvDTP02_DateTimeFormatQual5 = CASE WHEN (EecFullTimeOrPartTime = 'F' and(FT.Oldvalue = 'P' and FT.NewValue = 'F') )  THEN 'D8' END
        ,drvDTP03_DateTimePeriod5 = CASE WHEN (EecFullTimeOrPartTime = 'F' and(FT.Oldvalue = 'P' and FT.NewValue = 'F') ) THEN CONVERT(VARCHAR(8), FT.EffDate,112) END
        --=====================
        --=====================
        -- LOOP 2100A RECORDS
        --=====================
          ,drvNM103_NameLast1 = REPLACE(REPLACE(Replace(dbo.dsi_fnRemoveChars('.,/-`',
                              CASE WHEN BdmRecType = 'EMP' THEN EepNameLast
                                   WHEN BdmRecType = 'DEP' THEN ConNameLast
                              END), 'í','i'), 'á', 'a'),'é','e')
        ,drvNM104_NameFirst1 =  REPLACE(REPLACE(Replace(dbo.dsi_fnRemoveChars('.,/-`',
                               CASE WHEN BdmRecType = 'EMP' THEN EepNameFirst
                                    WHEN BdmRecType = 'DEP' THEN ConNameFirst
                              END), 'í','i'), 'á', 'a'),'é','e')
        ,drvNM105_NameMiddleInitial1 =  dbo.dsi_fnRemoveChars('.,/-',
                                       CASE WHEN BdmRecType = 'EMP' AND LEFT(EepNameMiddle,1) <> 'Z' THEN LEFT(EepNameMiddle,1)
                                            WHEN BdmRecType = 'DEP' AND LEFT(ConNameMiddle,1) <> 'Z' THEN LEFT(ConNameMiddle,1)
                                       END)
        ,drvNM106_NamePrefix1 = '' -- CASE WHEN BdmRecType = 'EMP' THEN EepNamePrefix END
        ,drvNM107_NameSuffix1 = CASE WHEN BdmRecType = 'EMP' AND EepNameSuffix <> 'Z' THEN EepNameSuffix
                                     WHEN BdmRecType = 'DEP' AND ConNameSuffix <> 'Z' THEN ConNameSuffix
                                END
        ,drvNM108_IDCodeQualifier1 =    CASE WHEN BdmRecType = 'EMP' AND ISNULL(EepSSN, '') <> '' THEN '34'
                                            WHEN BdmRecType = 'DEP' AND NOT (ConSSN IN ('000000000','999999999', '111111111','888888888', '123456789') OR RIGHT(ConSSN, 3) IN ('111','000','999','998')) THEN '34'
                                        END        
        ,drvNM109_IDCode1 = CASE WHEN BdmRecType = 'EMP' AND ISNULL(EepSSN, '') <> '' THEN EepSSN
                                WHEN BdmRecType = 'DEP' AND NOT (ConSSN IN ('000000000','999999999', '111111111','888888888', '123456789') OR RIGHT(ConSSN, 3) IN ('111','000','999','998')) THEN ConSSN
                            END
        ,drvPER02_Name = ''
        ,drvPER03_CommNumberQualifier = CASE WHEN BdmRecType = 'EMP' AND ISNULL(EepPhoneHomeNumber, '') <> '' THEN 'HP'
                                            WHEN BdmRecType = 'EMP' AND ISNULL(eepAddressEMail, '') <> '' THEN 'EM'
                                        END
        ,drvPER04_CommunicationNumber = CASE WHEN BdmRecType = 'EMP' AND ISNULL(EepPhoneHomeNumber, '') <> '' THEN EepPhoneHomeNumber
                                            WHEN BdmRecType = 'EMP' AND ISNULL(eepAddressEMail, '') <> '' THEN eepAddressEMail
                                        END
        ,drvPER05_CommNumberQualifier =    CASE WHEN BdmRecType = 'EMP' AND ISNULL(EepPhoneHomeNumber, '') <> '' AND ISNULL(eepAddressEMail, '') <> '' THEN 'EM' END
        ,drvPER06_CommunicationNumber = CASE WHEN BdmRecType = 'EMP' AND ISNULL(EepPhoneHomeNumber, '') <> '' AND ISNULL(eepAddressEMail, '') <> '' THEN eepAddressEMail END
        ,drvPER07_CommNumberQualifier = '' 
        ,drvPER08_CommunicationNumber = '' 
        ,drvN301_AddressLine1 = dbo.dsi_fnRemoveChars('.,/-',EepAddressLine1)
        ,drvN302_AddressLine2 = dbo.dsi_fnRemoveChars('.,/-',EepAddressLine2)
        ,drvN401_City = dbo.dsi_fnRemoveChars('.,/-',EepAddressCity)
        ,drvN402_State = EepAddressState
        ,drvN403_Zip = left(EepAddressZipCode,5)
        ,drvN404_CountryCode = CASE WHEN EepAddressCountry NOT IN ('US','USA') THEN EepAddressCountry END
        ,drvDMG02_DateTimePeriod1 = CASE WHEN BdmRecType = 'EMP' THEN CONVERT(VARCHAR(8),EepDateOfBirth,112)
                                         WHEN BdmRecType = 'DEP' THEN CONVERT(VARCHAR(8),ConDateOfBirth,112)
                                    END
        ,drvDMG03_GenderCode1 = CASE WHEN BdmRecType = 'EMP' and EepGender in ('M', 'F') THEN EepGender 
                                     WHEN BdmRecType = 'DEP' and ConGender in ('M', 'F') THEN ConGender
                                    ELSE 'U'
                                END
        ,drvDMG04_MaritalStatusCode1 = CASE WHEN BdmRecType = 'EMP' THEN
                                                CASE EepMaritalStatus WHEN 'M' THEN 'M' ELSE 'I' END
											ELSE 
											   CASE WHEN BdmRecType = 'DEP' and conrelationship = 'SPS' THEN 'M' END
									   END
        --If drvICM01_FrequencyCode is Populated, then send ICM Segment
        ,drvICM01_FrequencyCode = CASE WHEN ICM01 IS NOT NULL AND BdmRecType = 'EMP' THEN '7' END
        ,drvICM02_MonetaryAmount = Round(CASE WHEN BdmRecType = 'EMP' THEN EecAnnSalary END,2)
        ,drvICM03_Quantity = Left (CASE WHEN BdmRecType = 'EMP' THEN 
										Case EecPayPeriod
											When 'W' then EecScheduledWorkHrs
											When 'B' then (EecScheduledWorkHrs / 2)
											When 'S' then ((EecScheduledWorkHrs * 24) / 52)
											When 'M' then ((EecScheduledWorkHrs * 12) / 52) 
										END
										END, 2)
        ,drvICM04_LocationID = ''        --CASE WHEN BdmRecType = 'EMP' THEN
         --                               CASE WHEN YEAR(EecDateOfLastHire) = YEAR(GETDATE()) THEN CONVERT(VARCHAR(8),EecDateOfLastHire,112)
         --                                   ELSE CONVERT(CHAR(4),YEAR(GETDATE())) + '0101'
         --                               END
         --                      END
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
        ,drvHLH01_HealthRelatedCode = ''--CASE WHEN BdmRecType = 'EMP' THEN
                                      --          CASE EepIsSmoker
                                      --               WHEN 'Y' THEN 'T' --Tobacco Use
                                      --               ELSE 'N' --None
                                      --          END
                                      --     WHEN BdmRecType = 'DEP' THEN
                                      --          CASE ConIsSmoker
                                      --               WHEN 'Y' THEN 'T' --Tobacco Use
                                      --               ELSE 'N' --None
                                      --          END
                                      --END
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

     INTO dbo.U_EANPRIN834_DrvTbl
     FROM dbo.U_EANPRIN834_EELIST WITH (NOLOCK)
   JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
   JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    Left JOIN dbo.U_dsi_bdm_EANPRIN834 WITH (NOLOCK)
        ON BdmEEID = xEEID
        AND BdmCOID = xCOID
		AND (BdmDedcode = 'Unum' and BdmBenStartDate < = @EndDate OR -- MW added the or statment to remove Unum with future StartDates
		 BdmDedCode IN ('RELI1','RELI3','RELI4','RELI5','ADEN2','AVIS','RELI6')) -- AR SR 00410261 Added RELI6
	LEFT JOIN (
            SELECT BdmEEID as BenStartEEID, BdmCOID AS BenStartCOID
                ,MAX(eedBenStartDate) AS BenStartDate
                ,MAX(CASE WHEN BdmRecType = 'EMP' AND (BdmDedcode = 'Unum' and BdmBenStartDate < = @EndDate OR  BdmDedCode IN ('RELI1','RELI3','RELI4','RELI5','ADEN2','AVIS','RELI6')) THEN BdmDedCode END) AS ICM01  -- AR SR 00410261 Added RELI6
            FROM dbo.U_dsi_bdm_EANPRIN834 WITH (NOLOCK) 
		      Join  dbo.EmpDed WITH(NOLOCK)
				on bdmeeid = eedeeid 
				and eeddedcode = bdmdedcode
            GROUP BY BdmEEID, BdmCOID) AS StartDate
        ON BenStartEEID = BdmEEID
        AND BenStartCOID = BdmCOID 
    LEFT JOIN dbo.TrmReasn WITH (NOLOCK)
        ON TchCode = EecTermReason
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
    JOIN dbo.Company WITH (NOLOCK)
        ON CmpCOID = xCOID
  Left   JOIN  (Select  BdmEEID AS ReliEEID, BdmCOID AS ReliCOID 
                         ,MAX(CASE WHEN BdmDedCode = 'RELI3' THEN BdmDedCode END) AS Reli3DedCod   
                         ,MAX(CASE WHEN EedDeDCode = 'RELI3' THEN EedBenAmt END) AS D2Amt
                     FROM  dbo.U_dsi_bdm_EANPRIN834 WITH (NOLOCK)
					 Join  dbo.EmpDed WITH(NOLOCK)
						on bdmeeid = eedeeid 
						and eeddedcode = bdmdedcode
						and BdmDedCode = 'RELI3'
						Where  EedBenStatus = 'A'
						and BdmRecType = 'EMP' 
					GROUP BY BdmEEID, BdmCOID
			) RELI3	
		ON ReliEEID = bdmeeid

   --Left  JOIN (  SELECT PTEEID 
			--		,PTCOID
			--		,PT
   --                 ,PTDATE
			--		,FT
			--		,FTDATE
			--		FROM	(SELECT PTEEID ,  PTCOID , PTSAL, PTDATE,  PT = 'PT' From ( Select  ejheeid AS PTEEID, EjhCoID AS PTCOID, EjhJobCode, EjhAnnSalary AS PTSAL, EjhIntegrationEffDate AS PTDATE,  RN = ROW_NUMBER() OVER (PARTITION BY ejheeid, Ejhemplstatus ORDER BY EjhIntegrationEffDate  DESC) 
			--		 FROM dbo.EmpHJob WITH (NOLOCK) WHERE Ejhemplstatus = 'A'  AND EjhFullTimeOrPartTime = 'P' 
			--		-- and ejheeid =  'DML0FZ000020' 
			--		 ) PT WHERE  rn = 1) PTHIRE

			--	LEFT JOIN ( SELECT FTEEID ,FTCOID ,FTDATE , FT='FT' From ( Select  ejheeid AS FTEEID, EjhCoID AS FTCOID,MIN(EjhIntegrationEffDate) AS FTDATE
			--		 FROM dbo.EmpHJob WITH (NOLOCK) WHERE Ejhemplstatus = 'A'  and EjhFullTimeOrPartTime = 'F'
			--		--and ejheeid = 'DML0FZ000020' 
			--		 Group by ejheeid, EjhCoID) FT )  FTHIRE ON FTEEID = PTEEID
			
			--		 Where ISNULL(PTDATE, '') < =  ISNULL(FTDATE ,'')
   --        ) FT
		
        --ON PTEEID = xEEID
        --AND PTCOID = xCOID
	JOIN dbo.dsi_fnlib_JobHistoryTable_v2('EjhFullTimeOrPartTime')FT
		  ON EEID = xEEID 
		  AND coid = XCOID
   JOIN dbo.PayGroup WITH (NOLOCK)
		  ON PgrPayGroup = EecPayGroup
   LEFT JOIN dbo.U_EANPRIN834_Audit WITH (NOLOCK)
		  ON  audeeid = Xeeid
	WHERE EecEEType <> 'TES'
		  AND CmpCompanyCode IN ('ANCON', 'CPS', 'HH', 'VOLT')
		 -- AND  (BdmBenStatus = 'A' or (BdmBenStatus = 'T' and EecEmplStatus = 'T'  and audDateTime Between @Startdate and @EndDate))
		  AND  ((BdmBenStatus = 'A' ) or (( EecEmplStatus <>  'T' and  Bdmbenstopdate  Between @Startdate and @EndDate) or ( EecEmplStatus = 'T'  and ( audBenTermed = 'Y' or AudTermed = 'Y' ))))
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
    IF OBJECT_ID('U_EANPRIN834_DrvTbl_2300','U') IS NOT NULL
        DROP TABLE dbo.U_EANPRIN834_DrvTbl_2300;
	   
  	 SELECT DISTINCT a.* 
   INTO dbo.U_EANPRIN834_DrvTbl_2300 
      FROM( 
             SELECT DISTINCT

        -- If drvHD00_HealthCoverage Populated, then send HD Segment
        drvHD00_HealthCoverage =  CASE WHEN CASE WHEN BdmRecType = 'EMP' AND EedDedCode = 'UNUM' THEN 'BLF'
                                         -- WHEN BdmRecType = 'EMP' AND  EedDedCode IN  ('UNUM') THEN 'ADD'
                                          WHEN BdmRecType = 'EMP' AND  EedDedCode IN  ('RELI1','RELI6') THEN 'EVL'  -- AR SR 00410261 Added RELI6
                                         -- WHEN BdmRecType = 'EMP' AND  EedDedCode IN  ('RELI1') THEN 'EVA'
                                          WHEN BdmRecType = 'EMP' AND  EedDedCode IN  ('RELI3') THEN 'SVL'
                                        --  WHEN BdmRecType = 'EMP' AND  EedDedCode IN  ('RELI3') THEN 'SVA'
                                          WHEN BdmRecType = 'EMP' AND  EedDedCode IN  ('RELI4') THEN 'CVL'
                                          WHEN BdmRecType = 'EMP' AND  EedDedCode IN  ('RELI5') THEN 'LTD'
                                          --WHEN BdmRecType = 'EMP' AND BdmDedCode IN  ('ADEN2') THEN 'DEN'
										  WHEN  BdmDedCode IN  ('ADEN2') THEN 'DEN'
                                         -- WHEN BdmRecType = 'EMP' and  BdmDedCode = 'AVIS' THEN 'VIS'
										  WHEN BdmDedCode = 'AVIS' THEN 'VIS'
                                         END IS not null then 'HD' END
        ,drvHD01_MaintTypeCode = CASE WHEN CASE WHEN BdmRecType = 'EMP' AND  EedDedCode = 'UNUM' THEN 'BLF'
                                         -- WHEN BdmRecType = 'EMP' AND  EedDedCode IN  ('UNUM') THEN 'ADD'
                                          WHEN BdmRecType = 'EMP' AND  EedDedCode IN  ('RELI1','RELI6') THEN 'EVL'  -- AR SR 00410261 Added RELI6
                                         -- WHEN BdmRecType = 'EMP' AND  EedDedCode IN  ('RELI1') THEN 'EVA'
                                          WHEN BdmRecType = 'EMP' AND  EedDedCode IN  ('RELI3') THEN 'SVL'
                                        --  WHEN BdmRecType = 'EMP' AND  EedDedCode IN  ('RELI3') THEN 'SVA'
                                          WHEN BdmRecType = 'EMP' AND  EedDedCode IN  ('RELI4') THEN 'CVL'
                                          WHEN BdmRecType = 'EMP' AND  EedDedCode IN  ('RELI5') THEN 'LTD'
                                          --WHEN BdmRecType = 'EMP' and  BdmDedCode IN  ('ADEN2') THEN 'DEN'
										  WHEN   BdmDedCode IN  ('ADEN2') THEN 'DEN'
                                         -- WHEN BdmRecType = 'EMP' and  BdmDedCode = 'AVIS' THEN 'VIS'
										  WHEN   BdmDedCode = 'AVIS' THEN 'VIS'
                                         END IS not null THEN  '030' END  --Audit or Compare
        ,drvHD02_MaintReasonCode = ''

        ,drvHD03_InsuranceLineCode = CASE WHEN BdmRecType = 'EMP' AND  EedDedCode = 'UNUM' THEN 'BLF'
                                         -- WHEN BdmRecType = 'EMP' AND  EedDedCode IN  ('UNUM') THEN 'ADD'
                                          WHEN BdmRecType = 'EMP' AND  EedDedCode IN  ('RELI1','RELI6') THEN 'EVL'  -- AR SR 00410261 Added RELI6
                                         -- WHEN BdmRecType = 'EMP' AND  EedDedCode IN  ('RELI1') THEN 'EVA'
                                          WHEN BdmRecType = 'EMP' AND  EedDedCode IN  ('RELI3') THEN 'SVL'
                                        --  WHEN BdmRecType = 'EMP' AND  EedDedCode IN  ('RELI3') THEN 'SVA'
                                          WHEN BdmRecType = 'EMP' AND  EedDedCode IN  ('RELI4') THEN 'CVL'
                                          WHEN BdmRecType = 'EMP' AND  EedDedCode IN  ('RELI5') THEN 'LTD'
                                          WHEN   BdmDedCode IN  ('ADEN2') THEN 'DEN'
										 -- WHEN BdmRecType = 'DEP'  and BdmDepRecID is not null and BdmDedCode IN  ('ADEN2') THEN 'DEN'
                                          WHEN   BdmDedCode = 'AVIS' THEN 'VIS'
										 -- WHEN BdmRecType = 'DEP'  and BdmDepRecID is not null and BdmDedCode = 'AVIS' THEN 'VIS'
                                          
                                     END
        ,drvHD04_PlanCoverageDesc = CASE WHEN BdmRecType = 'EMP' AND  EedDedCode = 'UNUM' THEN '1'
                                         WHEN BdmRecType = 'EMP' AND  EedDedCode IN  ('RELI1','RELI6') THEN '1'  -- AR SR 00410261 Added RELI6
                                         WHEN BdmRecType = 'EMP' AND  EedDedCode IN  ('RELI3') THEN '1'
                                         WHEN BdmRecType = 'EMP' AND  EedDedCode IN  ('RELI4') THEN '1'
                                         WHEN BdmRecType = 'EMP' AND  EedDedCode IN  ('RELI5') THEN '1'
										 WHEN BdmRecType = 'EMP' AND bdmDedCode IN  ('ADEN2') AND EepAddressState = 'CA' THEN '1'
                                         WHEN BdmRecType = 'EMP' AND bdmDedCode IN  ('ADEN2') AND EepAddressState <> 'CA' THEN '2'
										 WHEN BdmRecType = 'DEP' AND bdmDedCode IN  ('ADEN2') AND ConAddressState = 'CA' THEN '1'
                                         WHEN BdmRecType = 'DEP' AND bdmDedCode IN  ('ADEN2') AND ConAddressState <> 'CA' THEN '2'
                                        -- WHEN EedDedCode IN  ('ADEN2') AND LocAddressState = 'CA' THEN '1'
                                        -- WHEN EedDedCode IN  ('ADEN2') AND LocAddressState <> 'CA' THEN '2'
                                         WHEN EedDedCode IN  ('AVIS') THEN '1' 
                                        END


        ,drvHD05_CoverageLevelCode = ''
                                                --CASE WHEN BdmBenOption IN (SELECT * FROM dbo.dsi_BDM_fn_ListToTable('EE')) THEN 'EMP'
                                                --     WHEN BdmBenOption IN (SELECT * FROM dbo.dsi_BDM_fn_ListToTable('EES')) THEN 'ESP'
                                                --     WHEN BdmBenOption IN (SELECT * FROM dbo.dsi_BDM_fn_ListToTable('EEC')) THEN 'ECH'
                                                --     WHEN BdmBenOption IN (SELECT * FROM dbo.dsi_BDM_fn_ListToTable('FAM')) THEN 'FAM'
                                                --END
                                        
        -- If drvDTP00_DateTime_348 Populated, then send DTP*348 Segment
        ,drvDTP00_DateTime_348 = CASE WHEN (EedBenStopDate is null or EedBenStopDate > @FileMinCovDate)  THEN 'DTP'END
        ,drvDTP01_DateTimeQualifier_348 = CASE WHEN (EedBenStopDate is null or EedBenStopDate > @FileMinCovDate) THEN  '348' END
        ,drvDTP02_DateTimeFormatQual_348 =CASE WHEN (EedBenStopDate is null or EedBenStopDate > @FileMinCovDate) THEN  'D8' END
        ,drvDTP03_DateTimePeriod_348 = CASE WHEN (EedBenStopDate is null or EedBenStopDate > @FileMinCovDate) THEN  dbo.dsi_fnGetMinMaxDates('MAX',EEdBenStartDate, @FileMinCovDate) END
        -- If drvDTP00_DateTime_349 Populated, then send DTP*349 Segment
        ,drvDTP00_DateTime_349 = CASE WHEN eedBenStopDate IS NOT NULL and EedBenStopDate > @FileMinCovDate THEN 'DTP' END
        ,drvDTP01_DateTimeQualifier_349 = CASE WHEN eedBenStopDate IS NOT NULL and EedBenStopDate > @FileMinCovDate  THEN '349' END
        ,drvDTP02_DateTimeFormatQual_349 = CASE WHEN eedBenStopDate IS NOT NULL and EedBenStopDate > @FileMinCovDate THEN 'D8' END
        ,drvDTP03_DateTimePeriod_349 = CASE WHEN  bdmDedCode IN ('ADEN2','AVIS') THEN DATEADD(d, 1 ,EedBenStopDate) ELSE EedBenStopDate END
        -- If drvDTP00_DateTime_303 = 'DTP', then Send DTP*303 Segment
        ,drvDTP00_DateTime_303 = ''
        ,drvDTP01_DateTimeQualifier_303 = ''--'303'
        ,drvDTP02_DateTimeFormatQual_303 = ''--'D8'
        ,drvDTP03_DateTimePeriod_303 = ''--- dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStatusDate, @FileMinCovDate)
        -- If drvREF00_RefNumberQual1 is Populated, then send REF Segment
        ,drvREF00_RefNumberQual1 = ''
        ,drvREF01_RefNumberQual1 = ''
        ,drvREF02_RefNumberQual1 = ''
        -- If drvREF01_RefNumberQual2 is Populated, then send REF Segment
        ,drvREF00_RefNumberQual2 = ''
        ,drvREF01_RefNumberQual2 = ''
        ,drvREF02_RefNumberQual2 = ''
        -- If drvAMT00_AmountQualifierCode1 is Populated, then Send AMT Segment
         ,drvAMT00_AmountQualifierCode1 =  CASE  WHEN BdmRecType = 'EMP' AND  EedDedCode IN ('RELI1') AND ReliDedCode1 IN ('RELI1') AND EECUDFIELD14 is not null THEN 'AMT'
												WHEN BdmRecType = 'EMP' AND  EedDedCode IN ('RELI1') AND ReliDedCode1 IN ('RELI1') AND EECUDFIELD14 is null and  ReliBdmAmt1 >= 0.00 THEN 'AMT'
                                           WHEN BdmRecType = 'EMP' AND  EedDedCode IN ('RELI3') AND ReliDedCode3 IN ('RELI3') AND EECUDFIELD15 is not null THEN 'AMT'
												WHEN BdmRecType = 'EMP' AND  EedDedCode IN ('RELI3') AND ReliDedCode3 IN ('RELI3') AND EECUDFIELD15 is null  and  ReliBdmAmt3  >= 0.00 THEN 'AMT'
                                           WHEN BdmRecType = 'EMP' AND  EedDedCode IN ('RELI4') AND ReliDedCode4 IN ('RELI4') AND EECUDFIELD13 is not null THEN 'AMT'
												WHEN BdmRecType = 'EMP' AND  EedDedCode IN ('RELI4') AND ReliDedCode4 IN ('RELI4') AND EECUDFIELD13 is null and   ReliBdmAmt4 >= 0.00 THEN 'AMT'
												WHEN BdmRecType = 'EMP' AND  EedDedCode IN ('RELI6') AND ReliDedCode6 IN ('RELI6') AND ReliBdmAmt6 >= 0.00 THEN 'AMT' -- AR SR 00410261
										   When (bdmDedCode IN  ('ADEN2','AVIS', 'UNUM')) THEN Null
										END
        ,drvAMT01_AmountQualifierCode1 =   CASE  WHEN BdmRecType = 'EMP' AND  EedDedCode IN ('RELI1') AND ReliDedCode1 IN ('RELI1') AND EECUDFIELD14 is not null THEN 'L1'
												WHEN BdmRecType = 'EMP' AND  EedDedCode IN ('RELI1') AND ReliDedCode1 IN ('RELI1') AND EECUDFIELD14 is null and  ReliBdmAmt1  >= 0.00 THEN 'L1'
                                           WHEN BdmRecType = 'EMP' AND  EedDedCode IN ('RELI3') AND ReliDedCode3 IN ('RELI3') AND EECUDFIELD15 is not null THEN 'L1'
												WHEN BdmRecType = 'EMP' AND  EedDedCode IN ('RELI3') AND ReliDedCode3 IN ('RELI3') AND EECUDFIELD15 is null  and  ReliBdmAmt3  >= 0.00 THEN 'L1'
                                           WHEN BdmRecType = 'EMP' AND  EedDedCode IN ('RELI4') AND ReliDedCode4 IN ('RELI4') AND EECUDFIELD13 is not null THEN 'L1'
												WHEN BdmRecType = 'EMP' AND  EedDedCode IN ('RELI4') AND ReliDedCode4 IN ('RELI4') AND EECUDFIELD13 is null and   ReliBdmAmt4  >= 0.00 THEN 'L1'
												WHEN BdmRecType = 'EMP' AND  EedDedCode IN ('RELI6') AND ReliDedCode6 IN ('RELI6') AND ReliBdmAmt6 >= 0.00 THEN 'L1' -- AR SR 00410261
										   When  (bdmDedCode IN  ('ADEN2','AVIS', 'UNUM')) THEN Null
										END
											
        ,drvAMT02_MonetaryAmount1 =  REPLACE(CASE  WHEN BdmRecType = 'EMP' AND  EedDedCode IN ('RELI1') AND ReliDedCode1 IN ('RELI1') AND EECUDFIELD14 is not null THEN EECUDFIELD14
												WHEN BdmRecType = 'EMP' AND  EedDedCode IN ('RELI1') AND ReliDedCode1 IN ('RELI1') AND EECUDFIELD14 is null and   ReliBdmAmt1  >= 0.00 THEN ReliBdmAmt1 
                                           WHEN BdmRecType = 'EMP' AND  EedDedCode IN ('RELI3') AND ReliDedCode3 IN ('RELI3') AND EECUDFIELD15 is not null THEN EECUDFIELD15
												WHEN BdmRecType = 'EMP' AND  EedDedCode IN ('RELI3') AND ReliDedCode3 IN ('RELI3') AND EECUDFIELD15 is null  and  ReliBdmAmt3  >= 0.00 THEN ReliBdmAmt3
                                           WHEN BdmRecType = 'EMP' AND  EedDedCode IN ('RELI4') AND ReliDedCode4 IN ('RELI4') AND EECUDFIELD13 is not null THEN EECUDFIELD13
												WHEN BdmRecType = 'EMP' AND  EedDedCode IN ('RELI4') AND ReliDedCode4 IN ('RELI4') AND EECUDFIELD13 is null and   ReliBdmAmt4  >= 0.00 THEN ReliBdmAmt4
												WHEN BdmRecType = 'EMP' AND  EedDedCode IN ('RELI6') AND ReliDedCode6 IN ('RELI6') AND ReliBdmAmt6 >= 0.00 THEN ReliBdmAmt6 -- AR SR 00410261
										   When  (bdmDedCode IN  ('ADEN2','AVIS', 'UNUM'))THEN Null
                                         END, '.00' , '')
									--Replace(CASE  WHEN BdmRecType = 'EMP' AND  EedDedCode IN ('RELI1') AND ReliDedCode1  IN ('RELI1') THEN EECUDFIELD14 
         --                                  WHEN BdmRecType = 'EMP' AND  EedDedCode IN ('RELI3') AND ReliDedCode3  IN ('RELI3') THEN EECUDFIELD15
         --                                  WHEN BdmRecType = 'EMP' AND  EedDedCode IN ('RELI4') AND ReliDedCode4  IN ('RELI4') THEN EECUDFIELD13
         --                                  END, '.00' , '')
									
        -- If drvAMT00_AmountQualifierCode2 is Populated, then Send AMT Segment
        ,drvAMT00_AmountQualifierCode2 = CASE WHEN BdmRecType = 'EMP' AND  EedDedCode IN ('RELI1') and ReliBdmAmt1 >= 0.00  THEN 'AMT'
											  WHEN BdmRecType = 'EMP' AND  EedDedCode IN ('RELI3') and ReliBdmAmt3 >= 0.00  THEN  'AMT' 
											  WHEN BdmRecType = 'EMP' AND  EedDedCode IN ('RELI4') and ReliBdmAmt4 >= 0.00  THEN  'AMT'
											  WHEN BdmRecType = 'EMP' AND  EedDedCode IN ('RELI6') and ReliBdmAmt6 >= 0.00  THEN  'AMT' -- AR SR 00410261
											  END
        ,drvAMT01_AmountQualifierCode2 = CASE WHEN BdmRecType = 'EMP' AND  EedDedCode IN ('RELI1') and ReliBdmAmt1 >= 0.00  THEN 'A2'
											  WHEN BdmRecType = 'EMP' AND  EedDedCode IN ('RELI3') and ReliBdmAmt3 >= 0.00  THEN  'A2' 
											  WHEN BdmRecType = 'EMP' AND  EedDedCode IN ('RELI4') and ReliBdmAmt4 >= 0.00  THEN  'A2'
											  WHEN BdmRecType = 'EMP' AND  EedDedCode IN ('RELI6') and ReliBdmAmt6 >= 0.00  THEN  'A2' -- AR SR 00410261
											  END
        ,drvAMT02_MonetaryAmount2 =  REPLACE(CASE  WHEN   EedDedCode IN ('RELI1') AND ReliDedCode1 IN ('RELI1') AND ReliBdmAmt1 >= 0.00  THEN ReliBdmAmt1
                                           WHEN BdmRecType = 'EMP' AND  EedDedCode IN ('RELI3') AND ReliDedCode3 IN ('RELI3') AND ReliBdmAmt3 >= 0.00  THEN ReliBdmAmt3
                                           WHEN BdmRecType = 'EMP' AND  EedDedCode IN ('RELI4') AND ReliDedCode4 IN ('RELI4') AND ReliBdmAmt4 >= 0.00  THEN ReliBdmAmt4
										   WHEN BdmRecType = 'EMP' AND  EedDedCode IN ('RELI6') AND ReliDedCode6 IN ('RELI6') AND ReliBdmAmt6 >= 0.00  THEN ReliBdmAmt6 -- AR SR 00410261
										   When (bdmDedCode IN  ('ADEN2','AVIS', 'UNUM')) THEN Null
										   
                                         END, '.00' , '')





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
        ,drvREF02_RefNumberDesc = ''--CASE BdmDedType
                                  --     WHEN 'MED' THEN ''
                                  --     WHEN 'DEN' THEN ''
                                  --     WHEN 'VIS' THEN ''
                                  --END
        -- If drvLE01_LoopIDCode is Populated, then send LE Segment
        ,drvLE01_LoopIDCode = ''
        ---------------------------------
        ,drvEEID = xEEID
        ,drvCOID = xCOID
        ,drvDepRecID = ConSystemID
        ,drvSSN = EepSSN
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = CONVERT(CHAR(9),RTRIM(EepSSN)) + CONVERT(CHAR(12),ISNULL(ConSystemID,'')) 
                        + CASE  eeddedcode
                             WHEN 'UNUM' THEN '1'
                             WHEN 'RELI1' THEN '2'
                             WHEN 'RELI3' THEN '3'
                             WHEN 'RELI4' THEN '4'
                             WHEN 'RELI5' THEN '5'
                             WHEN 'ADEN2' THEN '6'
                             WHEN 'AVIS' THEN '7'
							 WHEN 'RELI6' THEN '8' -- AR SR 00410261
                            
                             END 
    --INTO dbo.U_EANPRIN834_DrvTbl_2300
    FROM dbo.U_EANPRIN834_EELIST WITH (NOLOCK)
     JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    JOIN dbo.U_dsi_bdm_EANPRIN834 WITH (NOLOCK)
        ON BdmEEID = xEEID
        AND BdmCOID = xCOID
		AND ((BdmDedcode = 'Unum' and dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate)< = @EndDate) OR 
		 BdmDedCode IN ('RELI1','RELI3','RELI4','RELI5','ADEN2','AVIS','RELI6')) 
	   --AND BdmDedCode IN ('UNUM','RELI1','RELI3','RELI4','RELI5','ADEN2','AVIS') 
		--and bdmBenstatus NOT In ( 'W', 'C')
	Left JOIN ( Select Distinct 
				  EedEEID
				 ,EedCoID
				 ,EedDedCode
				-- ,DedDedType 
				 ,EedBenOption
				 ,EEdBenStartDate
				 ,EedBenStatusDate
				 ,EEdBenStopDate 
				 ,eedBenstatus 
			FROM dbo.empded ed WITH (nolock)
		 --JOIN dbo.emppers WITH (nolock) ON eepeeid = eedeeid
		 --JOIN dbo.u_dsi_bdm_EmpDeductions ee WITH (nolock) 
			--ON ee.eedeeid = eedeeid 
			--AND ee.eedcoid = eedcoid
			--AND eedFormatCode = 'EANPRIN834' 
			--AND eedValidForExport = 'Y'
			--AND ee.eeddedcode = eeddedcode
			Where ((EedDedcode = 'Unum' and dbo.dsi_fnGetMinMaxDates('MAX',EedBenStartDate, @FileMinCovDate)< = @EndDate )OR  EedDedcode IN ('RELI1','RELI3','RELI4','RELI5','ADEN2','AVIS','RELI6'))  -- AR SR 00410261
				 and eedBenstatus Not in ('W', 'C')
				 and (eedbenstopdate is null or eedbenstopdate > @FileMinCovDate)
			) Ded
		 ON EedEEID = BDMEEId
		 AND EedCoID = BdmCOID
		 and eeddedcode = bdmdedcode
		--and DEedBenOption = BdmBenoption
	LEFT JOIN (Select BdmEEID AS ReliEEID, BdmCOID AS ReliCOID
						,MAX(CASE WHEN  EedDedCode IN ('RELI1' )THEN EedDedCode  END) AS ReliDedCode1
						,MAX(CASE WHEN  EedDedCode IN ('RELI3') THEN EedDedCode  END) AS ReliDedCode3
						,MAX(CASE WHEN  EedDedCode IN ('RELI4') THEN EedDedCode END) AS ReliDedCode4
						,MAX(CASE WHEN  EedDedCode IN ('RELI6') THEN EedDedCode END) AS ReliDedCode6 -- AR SR 00410261
						,MAX(CASE WHEN  EedDedCode IN ('RELI1') THEN EedBenAmt END) AS ReliBdmAmt1
						,MAX(CASE WHEN  EedDedCode IN ('RELI3') THEN EedBenAmt END) AS ReliBdmAmt3
						,MAX(CASE WHEN  EedDedCode IN ('RELI4') THEN EedBenAmt END) AS ReliBdmAmt4
						,MAX(CASE WHEN  EedDedCode IN ('RELI6') THEN EedBenAmt END) AS ReliBdmAmt6  -- AR SR 00410261
					    ,MAX(BdmBenStatusDate) AS ReliBenStatusDate
                        ,MAX(EEdBenStartDate) AS RelBenStartDate
				 FROM  dbo.U_dsi_bdm_EANPRIN834 WITH (NOLOCK)
     			 Join  dbo.EmpDed WITH(NOLOCK)
					on bdmeeid = eedeeid 
					and eeddedcode = bdmdedcode
				     AND BDMBenStatus NOT IN ('W', 'C')
				 WHERE EedDedCode IN  ('RELI1', 'RELI3','RELI4','RELI6') -- AR SR 00410261 Added RELI6
				GROUP BY BdmEEID, BdmCOID		
			) RELI 
        ON ReliEEID= BdmEEID
	    AND ReliCOID = BdmCoid
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
    JOIN dbo.COmpany
        ON CmpCoID = XCOID --AND CmpCompanyCode IN ('ANCON', 'CPS', 'HH', 'VOLT')
	 LEFT JOIN dbo.U_EANPRIN834_Audit WITH (NOLOCK)
		ON  audeeid = Xeeid
    WHERE EecEEType <> 'TES'   
         --AND  ((BdmBenStatus = 'A'  OR EedBenstatus = 'A' ) or ((EedBenStatus = 'T' or BdmBenStatus = 'T' and EecEmplStatus <>  'T') or ( EecEmplStatus = 'T'  and audDateTime Between @Startdate and @EndDate)))
		  AND  ((BdmBenStatus = 'A'  OR EedBenstatus = 'A' ) or (( EecEmplStatus <>  'T' and  eedbenstopdate  Between @Startdate and @EndDate) or ( EecEmplStatus = 'T'  and ( audBenTermed = 'Y' or AudTermed = 'Y' ))))

Union 

 
 SELECT DISTINCT
        -- If drvHD00_HealthCoverage Populated, then send HD Segment
        drvHD00_HealthCoverage = CASE WHEN CASE --WHEN BdmRecType = 'EMP' AND   EedDedCode = 'UNUM'THEN 'BLF'
                                          WHEN BdmRecType = 'EMP' AND   EedDedCode = 'UNUM 'THEN 'ADD'
                                          --WHEN BdmRecType = 'EMP' AND   EedDedCode IN ('RELI1') THEN 'EVL'
                                          WHEN BdmRecType = 'EMP' AND   EedDedCode IN ('RELI1','RELI6') THEN 'EVA' -- AR SR 00410261 Added RELI6
                                         -- WHEN BdmRecType = 'EMP' AND   EedDedCode IN ('RELI3') THEN 'SVL'
                                          WHEN BdmRecType = 'EMP' AND   EedDedCode IN ('RELI3') THEN 'SVA'
                                          --WHEN BdmRecType = 'EMP' AND   EedDedCode IN ('RELI4') THEN 'CVL'
                                          --WHEN BdmRecType = 'EMP' AND   EedDedCode IN ('RELI5') THEN 'LTD'
                                          --WHEN BdmDedType IN ('ADEN2') THEN 'DEN'
                                          --WHEN BdmDedType IN ('AVIS') THEN 'VIS'
                                         
                                     END is not null then 'HD' END
        ,drvHD01_MaintTypeCode = CASE WHEN CASE --WHEN BdmRecType = 'EMP' AND   EedDedCode = 'UNUM'THEN 'BLF'
                                          WHEN BdmRecType = 'EMP' AND   EedDedCode = 'UNUM'THEN 'ADD'
                                          --WHEN BdmRecType = 'EMP' AND   EedDedCode IN ('RELI1') THEN 'EVL'
                                          WHEN BdmRecType = 'EMP' AND   EedDedCode IN ('RELI1','RELI6') THEN 'EVA' -- AR SR 00410261 Added RELI6
                                         -- WHEN BdmRecType = 'EMP' AND   EedDedCode IN ('RELI3') THEN 'SVL'
                                          WHEN BdmRecType = 'EMP' AND   EedDedCode IN ('RELI3') THEN 'SVA'
                                          --WHEN BdmRecType = 'EMP' AND   EedDedCode IN ('RELI4') THEN 'CVL'
                                          --WHEN BdmRecType = 'EMP' AND   EedDedCode IN ('RELI5') THEN 'LTD'
                                          --WHEN BdmDedType IN ('ADEN2') THEN 'DEN'
                                          --WHEN BdmDedType IN ('AVIS') THEN 'VIS'
                                         
                                     END is not null then '030' END --Audit or Compare
        ,drvHD02_MaintReasonCode = ''
        ,drvHD03_InsuranceLineCode = CASE --WHEN BdmRecType = 'EMP' AND   EedDedCode = 'UNUM'THEN 'BLF'
                                          WHEN BdmRecType = 'EMP' AND   EedDedCode IN ('UNUM') THEN 'ADD'
                                          --WHEN BdmRecType = 'EMP' AND   EedDedCode IN ('RELI1') THEN 'EVL'
                                          WHEN BdmRecType = 'EMP' AND   EedDedCode IN ('RELI1','RELI6') THEN 'EVA' -- AR SR 00410261 Added RELI6
                                         -- WHEN BdmRecType = 'EMP' AND   EedDedCode IN ('RELI3') THEN 'SVL'
                                          WHEN BdmRecType = 'EMP' AND   EedDedCode IN ('RELI3') THEN 'SVA'
                                          --WHEN BdmRecType = 'EMP' AND   EedDedCode IN ('RELI4') THEN 'CVL'
                                          --WHEN BdmRecType = 'EMP' AND   EedDedCode IN ('RELI5') THEN 'LTD'
                                          --WHEN BdmDedType IN ('ADEN2') THEN 'DEN'
                                          --WHEN BdmDedType IN ('AVIS') THEN 'VIS'
                                           ELSE ''
                                     END
        ,drvHD04_PlanCoverageDesc = CASE WHEN BdmRecType = 'EMP' AND   EedDedCode = 'UNUM' THEN '1'
                                         WHEN BdmRecType = 'EMP' AND   EedDedCode IN ('RELI1','RELI6') THEN '1' -- AR SR 00410261 Added RELI6
                                         WHEN BdmRecType = 'EMP' AND   EedDedCode IN ('RELI3') THEN '1'
                                        -- WHEN BdmRecType = 'EMP' AND   EedDedCode IN ('RELI4') THEN '1'
                                        -- WHEN BdmRecType = 'EMP' AND   EedDedCode IN ('RELI5') THEN '1'
                                        -- WHEN  EedDedCode IN ('ADEN2') AND LocAddressState = 'CA' THEN '1'
                                        -- WHEN  EedDedCode IN ('ADEN2') AND LocAddressState <> 'CA' THEN '2'
                                        -- WHEN  EedDedCode IN ('AVIS') THEN 'VIS' 
                                        END


        ,drvHD05_CoverageLevelCode = ''
                                                --CASE WHEN BdmBenOption IN (SELECT * FROM dbo.dsi_BDM_fn_ListToTable('EE')) THEN 'EMP'
                                                --     WHEN BdmBenOption IN (SELECT * FROM dbo.dsi_BDM_fn_ListToTable('EES')) THEN 'ESP'
                                                --     WHEN BdmBenOption IN (SELECT * FROM dbo.dsi_BDM_fn_ListToTable('EEC')) THEN 'ECH'
                                                --     WHEN BdmBenOption IN (SELECT * FROM dbo.dsi_BDM_fn_ListToTable('FAM')) THEN 'FAM'
                                                --END
                                    
        -- If drvDTP00_DateTime_348 Populated, then send DTP*348 Segment
        ,drvDTP00_DateTime_348 = 'DTP'
        ,drvDTP01_DateTimeQualifier_348 = '348'
        ,drvDTP02_DateTimeFormatQual_348 = 'D8'
        ,drvDTP03_DateTimePeriod_348 = dbo.dsi_fnGetMinMaxDates('MAX',EEdBenStartDate, @FileMinCovDate) 
        -- If drvDTP00_DateTime_349 Populated, then send DTP*349 Segment
        ,drvDTP00_DateTime_349 = CASE WHEN eedBenStopDate IS NOT NULL and EedBenStopDate > @FileMinCovDate THEN 'DTP' END
        ,drvDTP01_DateTimeQualifier_349 = CASE WHEN eedBenStopDate IS NOT NULL and EedBenStopDate > @FileMinCovDate THEN '349' END
        ,drvDTP02_DateTimeFormatQual_349 = CASE WHEN eedBenStopDate IS NOT NULL and EedBenStopDate > @FileMinCovDate THEN 'D8' END
        ,drvDTP03_DateTimePeriod_349 =  CASE WHEn eedBenStopDate IS NOT NULL and EedBenStopDate > @FileMinCovDate THEN eedBenStopDate END 
        -- If drvDTP00_DateTime_303 = 'DTP', then Send DTP*303 Segment
        ,drvDTP00_DateTime_303 = ''
        ,drvDTP01_DateTimeQualifier_303 = ''--'303'
        ,drvDTP02_DateTimeFormatQual_303 = ''--'D8'
        ,drvDTP03_DateTimePeriod_303 = ''--- dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStatusDate, @FileMinCovDate)
        -- If drvREF00_RefNumberQual1 is Populated, then send REF Segment
        ,drvREF00_RefNumberQual1 = ''
        ,drvREF01_RefNumberQual1 = ''
        ,drvREF02_RefNumberQual1 = ''
        -- If drvREF01_RefNumberQual2 is Populated, then send REF Segment
        ,drvREF00_RefNumberQual2 = ''
        ,drvREF01_RefNumberQual2 = ''
        ,drvREF02_RefNumberQual2 = ''
        -- If drvAMT00_AmountQualifierCode1 is Populated, then Send AMT Segment
        ,drvAMT00_AmountQualifierCode1 = NULL
        ,drvAMT01_AmountQualifierCode1 = Null
        ,drvAMT02_MonetaryAmount1 = Null
                                        
        -- If drvAMT00_AmountQualifierCode2 is Populated, then Send AMT Segment
        ,drvAMT00_AmountQualifierCode2 = NULL
        ,drvAMT01_AmountQualifierCode2 = Null
                
        ,drvAMT02_MonetaryAmount2 =  Null


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
        ,drvREF02_RefNumberDesc = ''--CASE BdmDedType
                                  --     WHEN 'MED' THEN ''
                                  --     WHEN 'DEN' THEN ''
                                  --     WHEN 'VIS' THEN ''
                                  --END
        -- If drvLE01_LoopIDCode is Populated, then send LE Segment
        ,drvLE01_LoopIDCode = ''
        ---------------------------------
        ,drvEEID = xEEID
        ,drvCOID = xCOID
        ,drvDepRecID = ConSystemID
        ,drvSSN = EepSSN
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = CONVERT(CHAR(9),RTRIM(EepSSN)) +  CONVERT(CHAR(12),ISNULL(ConSystemID,'')) 
						 + CASE EedDedcode
                             WHEN 'UNUM' THEN '1.1'
                             WHEN 'RELI1' THEN '2.2'
							 WHEN 'RELI6' THEN '2.2' -- AR SR 00410261
                             WHEN 'RELI3' THEN '3.3'
                             END 
               
   -- INTO dbo.U_EANPRIN834_DrvTbl_2300
    FROM dbo.U_EANPRIN834_EELIST WITH (NOLOCK)
     JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    LEFT JOIN dbo.U_dsi_bdm_EANPRIN834 WITH (NOLOCK)
        ON BdmEEID = xEEID
        AND BdmCOID = xCOID
	 	AND (BdmDedcode = 'UNUM' and dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate)< = @EndDate OR  BdmDedCode IN ('RELI1','RELI3','RELI6')) 
	LEft JOIN ( Select Distinct 
			  EedEEID
			 ,EedCoID
			 ,EedDedCode
			-- ,DedDedType 
			 ,EedBenOption
			 ,EEdBenStartDate
			 ,EedBenStatusDate
			 ,EEdBenStopDate 
			 ,EedBenstatus
			FROM dbo.empded ed WITH (nolock)
			Where (EedDedcode = 'UNUM' and dbo.dsi_fnGetMinMaxDates('MAX',EedBenStartDate, @FileMinCovDate)< = @EndDate OR  EedDedcode IN ('RELI1','RELI3','RELI4','RELI5','ADEN2','AVIS','RELI6'))  -- AR SR 00410261
				 and eedBenstatus Not in ('W', 'C')
				 and (eedbenstopdate is null or eedbenstopdate > @FileMinCovDate)
		 --JOIN dbo.u_dsi_bdm_EmpDeductions ee WITH (nolock) 
			--ON ee.eedeeid = eedeeid 
			--AND ee.eedcoid = eedcoid
			--AND eedFormatCode = 'EANPRIN834' 
			--AND eedValidForExport = 'Y'
			--AND ee.eeddedcode = eeddedcode
			) Ded
		 ON EedEEID = BDMEEId
		 AND EedCoID = BdmCOID
		-- and EedDedCode = BdmDedcode
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
    JOIN dbo.Company WITH (NOLOCK)
        ON CmpCOID = xCOID
      -- AND  CmpCompanyCode IN ('ANCON', 'CPS', 'HH', 'VOLT')
	 LEFT JOIN dbo.U_EANPRIN834_Audit WITH (NOLOCK)
		ON  audeeid = Xeeid
        WHERE EecEEType <> 'TES'  
          -- AND  ((BdmBenStatus = 'A'  OR EedBenstatus = 'A' ) or ((EedBenStatus = 'T' or BdmBenStatus = 'T' and EecEmplStatus <>  'T') or ( EecEmplStatus = 'T'  and audDateTime Between @Startdate and @EndDate)))
		   AND  ((BdmBenStatus = 'A'  OR EedBenstatus = 'A' ) or (( EecEmplStatus <>  'T' and  eedbenstopdate  Between @Startdate and @EndDate) or ( EecEmplStatus = 'T'  and ( audBenTermed = 'Y' or AudTermed = 'Y' ))))
	) a

	Where drvHD00_HealthCoverage is not null and drvHD04_PlanCoverageDesc is not null

	;

    /**************************************************************************************************
        TRAILER RECORDS
            - SE, GE, IEA Segments
    **************************************************************************************************/
    ---------------------
    -- TRAILER RECORD
    --------------------
    IF OBJECT_ID('U_EANPRIN834_TrlTbl') IS NOT NULL
        DROP TABLE dbo.U_EANPRIN834_TrlTbl;
    SELECT DISTINCT drvSE01_SegmentCount = '9999'
    INTO dbo.U_EANPRIN834_TrlTbl;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable('EANPRIN834','UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = 'ANCON_EANPRIN834_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
        WHERE FormatCode = 'EANPRIN834';
    END;

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEANPRIN834_Export AS
   	SELECT TOP 20000000 DATA FROM (
	SELECT DISTINCT * FROM dbo.U_EANPRIN834_File (NOLOCK)  )a
    ORDER BY CASE LEFT(Recordset,1) WHEN 'H' THEN 1 WHEN 'D' THEN 2 ELSE 3 END, InitialSort, SubSort, RIGHT(Recordset,2)
GO

--Check out iAscDefF
SELECT * FROM dbo.AscDef
WHERE AdfHeaderSystemID LIKE 'EANPRIN834%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET ExpLastStartPerControl = '201810011'
       ,ExpStartPerControl     = '201810011'
       ,ExpLastEndPerControl   = '201810019'
       ,ExpEndPerControl       = '201810019'
WHERE ExpFormatCode = 'EANPRIN834';


UPDATE dbo.AscExp
    SET ExpLastStartPerControl = '202303101'
       ,ExpStartPerControl     = '202303101'
       ,ExpLastEndPerControl   = '202303249'
       ,ExpEndPerControl       = '202303249'
WHERE ExpFormatCode = 'EANPRIN834' and expexportCode = 'TEST_XOE';

**********************************************************************************/
