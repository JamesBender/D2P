USE [ULTIPRO_WPPCRK]
GO
/****** Object:  StoredProcedure [dbo].[dsi_sp_BuildDriverTables_EDISPCRCOB]    Script Date: 11/8/2021 1:29:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EDISPCRCOB]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: PCRK Holding Company

Created By: Andy Pineda
Business Analyst: Cheryl Petitti
Create Date: 09/02/2021
Service Request Number: TekP-2021-07-22-0007

Purpose: PCRK Holding Company COBRA Export

Revision History
----------------
09/14/2021 by AP:
        - QB Record: Changed client division name.
        - QBPLANMEMBERSPECIFICREATEINITIAL Record: Updated rate logic.

10/05/2021 by AP:
        - Updated DEATH event insert into BDM for 203 for dependents.

10/14/2021 by AP:
        - Adjusted logic for DEATH once again and applied clean up to QBDEPENDENT QBDEPPLAN section.
        - Added DELETE statement to remove employees >= 26.

10/29/2021 by AP:
        - Fixed death scenario where both spouse and employee where showing as QB.
        - Fixed dependent at max age showing records for QBDEP and QBDEPPLAN.
        - Set UPDATE statement to clean up coverage level.
        - Cleaned up DELETE statement for INELIGIBLEDEPENDENTS >= 26.
        - Added DELETE statement to clean up BDM table for TEST employess.

11/05/2021 by AP:
		- Updated cobra reason for death to 210 in BDM output.
		- Removed 203 from QBPLAN.

11/08/2021 by AP:
		- Updated Coverage Level CASE STATEMENT order.

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EDISPCRCOB';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EDISPCRCOB';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EDISPCRCOB';
SELECT * FROM dbo.AscExp WHERE expFormatCode = 'EDISPCRCOB';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EDISPCRCOB' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISPCRCOB', 'SCH_PCRCOB';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISPCRCOB', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISPCRCOB', 'TEST';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EDISPCRCOB';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EDISPCRCOB', @AllObjects = 'Y', @IsWeb = 'Y';
**********************************************************************************/
BEGIN
    --==========================================
    -- Declare variables
    --==========================================
    DECLARE  @FormatCode varchar(10)
            ,@ExportCode varchar(10)
            ,@StartDate  datetime
            ,@EndDate    datetime;

    -- Initialize @FormatCode
    SET @FormatCode = 'EDISPCRCOB';

    -- Declare dates from Parameter file
    SELECT
         @ExportCode = ExportCode
        ,@StartDate  = LEFT(StartPerControl,8)
        ,@EndDate    = DATEADD(SS,-1,DATEADD(DD,1,LEFT(EndPerControl,8)))
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List
    --==========================================
    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EDISPCRCOB_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCoID(xEEID)
      AND xEEID IN (SELECT xEEID FROM dbo.U_EDISPCRCOB_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- BDM Section for NPM
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'TermSelectionOption','AuditDate');

    -- NPM parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RunID','NPM');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','X'); -- DedIsCobraCovered = 'Y'
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'NewEnrolleeType','4'); -- All new enrollees where no previous plan exists
   -- INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'TableType','EMP'); -- Only include employees on NPM file
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');

    -- Run BDM for NPM
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- BDM Section for QB
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'TermSelectionOption','AuditDate');

    -- COBRA parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RunID','QB');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'AddToPreviousRun','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','Y'); -- DedIsCobraCovered = 'Y'
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraType','4'); -- Eep/ConCobraReason first, then EdhChangeReason. Include CHGRP for elig. ben groups
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraDate','3'); -- EedBenStopDate and DbnBenStopDate, unless Eep/ConDateOfCOBRAEvent exists
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraPQBType','1'); -- If no EE or spouse, ALL children are PQB (not just oldest)
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraReasonsDepPQB','201,204,210,LEVNT3,LEVNT4'); -- Valid dependent PQB reasons
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidCobraReasonsEmp','201,204,210,LEVNT3,LEVNT4'); -- Invalidate employee when Cobra Reason is a dependent PQB reason
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidTermReasonsEmp','203'); -- Invalidate employee when Cobra Reason is "Death"
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'ConCobraReasonPCF','DependentCOBRAReason'); -- Valid dependent PQB reasons
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CountDependents','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS,SPX');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL, DPC, STC');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'rRelationshipsDomPartner','DMP, DP');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');

    -- Run BDM for QB
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    ---- 203 death insert employee
    --INSERT INTO [dbo].[U_dsi_BDM_EDISPCRCOB]
    --([BdmRecType]
    --,[BdmCOID]
    --,[BdmEEID]
    --,[BdmDepRecID]
    --,[BdmSystemID]
    --,[BdmRunID]
    --,[BdmDedRowStatus]
    --,[BdmRelationship]
    --,[BdmDateOfBirth]
    --,[BdmDedCode]
    --,[BdmBenOption]
    --,[BdmBenStartDate]
    --,[BdmBenStopDate]
    --,[BdmBenStatusDate]
    --,[BdmDateOFCobraEvent]
    --,[BdmChangeReason]
    --,[BdmCobraReason]
    --,[BdmStartDate]
    --,[BdmStopDate]
    --,[BdmIsPQB]
    --)
    --SELECT DISTINCT 'EMP'
    --,EecCOID
    --,EecEEID
    --,NULL
    --,NULL
    --,'QB'
    --,'Data inserted for 203 term reason'
    --,'Emp'
    --,EepDateOfBirth
    --,DedDedCode
    --,EedBenOption
    --,EedBenStartDate
    --,EedBenStopDate
    --,EedBenStatusDate
    --,EedBenStatusDate
    --,'203'
    --,'203'
    --,EedStartDate
    --,EedStopDate
    --,'Y'
    --FROM dbo.EmpComp WITH(NOLOCK)
    --JOIN dbo.u_dsi_bdm_EmpDeductions WITH(NOLOCK)
    --ON EecEEID = EedEEID
    --AND EecCOID = EedCOID
    --JOIN dbo.EmpPers WITH(NOLOCK)
    --ON EecEEID = EepEEID
    --WHERE EedValidForExport = 'N'
    --AND EedFormatCode = 'EDISPCRCOB'
    ----AND eeceeid = 'DTCQW5000040'
    --AND EecTermReason = '203'

    INSERT INTO [dbo].[U_dsi_BDM_EDISPCRCOB]
    ([BdmRecType]
    ,[BdmCOID]
    ,[BdmEEID]
    ,[BdmDepRecID]
    ,[BdmSystemID]
    ,[BdmRunID]
    ,[BdmDedRowStatus]
    ,[BdmRelationship]
    ,[BdmDateOfBirth]
    ,[BdmDedCode]
    ,[BdmBenOption]
    ,[BdmBenStartDate]
    ,[BdmBenStopDate]
    ,[BdmBenStatusDate]
    ,[BdmDateOFCobraEvent]
    ,[BdmChangeReason]
    ,[BdmCobraReason]
    ,[BdmStartDate]
    ,[BdmStopDate]
    ,[BdmIsPQB]
    )
    SELECT DISTINCT rectype = 'DEP'
    ,EdhCoid
    ,EdhEEID
    ,DbnDepRecID
    ,DbnDepRecID
    ,'QB'
    ,'Data Inserted for 204 Chg reason'
    ,DbnRelationship
    ,DbnDateOfBirth
    ,EdhDedCode
    ,DbnBenOption
    ,EdhBenStartDate
    ,EdhBenStopDate
    ,EdhBenStatusDate
    ,EdhBenStatusDate
    ,'204'
    ,'204'
    ,EdhStartDate
    ,EdhStopDate
    ,CASE WHEN DbnRelationShip = 'SPS' THEN 'Y' ELSE 'N' END
    FROM dbo.emphded WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_DepDeductions
    ON dbneeid = edheeid
    AND dbnformatcode = 'EDISPCRCOB'
    WHERE edhChangeReason in ('204')
    AND DbnBenStopDate BETWEEN @StartDate AND @EndDate
    AND dbnValidForExport = 'N'

    -- Dependent values for 201 event
    INSERT INTO [dbo].[U_dsi_BDM_EDISPCRCOB]
    ( [BdmRecType]
    ,[BdmCOID]
    ,[BdmEEID]
    ,[BdmDepRecID]
    ,[BdmSystemID]
    ,[BdmRunID]
    ,[BdmDedRowStatus]
    ,[BdmRelationship]
    ,[BdmDateOfBirth]
    ,[BdmDedCode]
    ,[BdmBenOption]
    ,[BdmBenStartDate]
    ,[BdmBenStopDate]
    ,[BdmBenStatusDate]
    ,[BdmDateOFCobraEvent]
    ,[BdmChangeReason]
    ,[BdmCobraReason]
    ,[BdmStartDate]
    ,[BdmStopDate]
    ,[BdmIsPQB]
    )
    SELECT DISTINCT rectype = 'DEP'
    ,EdhCoid
    ,EdhEEID
    ,DbnDepRecID
    ,DbnDepRecID
    ,'QB'
    ,'Data Inserted for 201 Chg reason'
    ,DbnRelationship
    ,DbnDateOfBirth
    ,EdhDedCode
    ,DbnBenOption
    ,EdhBenStartDate
    ,EdhBenStopDate
    ,EdhBenStatusDate
    ,EdhBenStatusDate
    ,'201'
    ,'201'
    ,EdhStartDate
    ,EdhStopDate
    ,'Y'
    FROM dbo.emphded WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
    ON dbneeid = edheeid
    AND dbnformatcode = 'EDISPCRCOB'
    WHERE edhChangeReason IN ('201')
    and DbnBenstopdate BETWEEN @startdate AND @enddate
    AND dbnValidForExport = 'N'

    INSERT INTO [dbo].[U_dsi_BDM_EDISPCRCOB]
    ( [BdmRecType]
    ,[BdmCOID]
    ,[BdmEEID]
    ,[BdmDepRecID]
    ,[BdmSystemID]
    ,[BdmRunID]
    ,[BdmDedRowStatus]
    ,[BdmRelationship]
    ,[BdmDateOfBirth]
    ,[BdmDedCode]
    ,[BdmBenOption]
    ,[BdmBenStartDate]
    ,[BdmBenStopDate]
    ,[BdmBenStatusDate]
    ,[BdmDateOFCobraEvent]
    ,[BdmChangeReason]
    ,[BdmCobraReason]
    ,[BdmStartDate]
    ,[BdmStopDate]
    ,[BdmIsPQB]
    )
    SELECT DISTINCT rectype = 'DEP'
    ,EdhCoid
    ,EdhEEID
    ,DbnDepRecID
    ,DbnDepRecID
    ,'QB'
    ,'Data Inserted for 203 Chg reason'
    ,DbnRelationship
    ,DbnDateOfBirth
    ,EdhDedCode
    ,'EE' -- Takes the place of the employeee.
    ,EdhBenStartDate
    ,EdhBenStopDate
    ,EdhBenStatusDate
    ,EdhBenStatusDate
    ,'210'
    ,'210'
    ,EdhStartDate
    ,EdhStopDate
    ,'Y'
    FROM dbo.emphded WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
    ON dbneeid = edheeid
    AND dbnformatcode = 'EDISPCRCOB'
    WHERE edhChangeReason IN ('210')
    and DbnBenstopdate BETWEEN @startdate AND @enddate
    AND dbnValidForExport = 'N'

    --DELETE FROM dbo.U_dsi_BDM_EDISPCRCOB WHERE BdmDedCode not in (SELECT DedCode FROM dbo.U_EDISPCRCOB_DedList)

    ---- SEE IF EMPLOYEE OF DEATH EVENT HAS A SPOUSE TO USE FURTHER DOWN IN THE CODE AS A FLAG ----

    IF OBJECT_ID('U_EDISPCRCOB_DeathEvent') IS NOT NULL
    DROP TABLE dbo.U_EDISPCRCOB_DeathEvent;

    SELECT DISTINCT EecEEID AS EeDeathId, MAX(CASE WHEN DbnRelationship IN ('SPS', 'SPX', 'DMP', 'DP')  THEN '1' ELSE '0' END) AS IsSpouse
    INTO dbo.U_EDISPCRCOB_DeathEvent
    FROM dbo.EmpComp WITH(NOLOCK)
    JOIN dbo.u_dsi_bdm_DepDeductions WITH(NOLOCK)
    ON EecEEID = dbnEEID
    AND EecCOID = dbnCOID
    WHERE DbnValidForExport = 'N'
    AND DbnFormatCode = 'EDISPCRCOB'
    --AND eeceeid = 'DNEAWV01IRX0'
    AND EecTermReason = '203'
    GROUP BY EecEEID

    -- 203 death insert dependent
    INSERT INTO [dbo].[U_dsi_BDM_EDISPCRCOB]
    ([BdmRecType]
    ,[BdmCOID]
    ,[BdmEEID]
    ,[BdmDepRecID]
    ,[BdmSystemID]
    ,[BdmRunID]
    ,[BdmDedRowStatus]
    ,[BdmRelationship]
    ,[BdmDateOfBirth]
    ,[BdmDedCode]
    ,[BdmBenOption]
    ,[BdmBenStartDate]
    ,[BdmBenStopDate]
    ,[BdmBenStatusDate]
    ,[BdmDateOFCobraEvent]
    ,[BdmChangeReason]
    ,[BdmCobraReason]
    ,[BdmStartDate]
    ,[BdmStopDate]
    ,[BdmIsPQB]
    )
    SELECT DISTINCT 'DEP'
    ,EecCOID
    ,EecEEID
    ,DbnDepRecID
    ,NULL
    ,'QB'
    ,'Data inserted for 203 term reason'
    , DbnRelationship
    ,EepDateOfBirth
    ,DedDedCode
    ,DbnBenOption
    ,DbnBenStartDate
    ,DbnBenStopDate 
    ,DbnBenStatusDate
    ,DbnBenStatusDate
    ,'210'
    ,'210'
    ,NULL
    ,NULL
    ,'Y'
    FROM dbo.EmpComp WITH(NOLOCK)
    JOIN dbo.u_dsi_bdm_DepDeductions WITH(NOLOCK)
    ON EecEEID = dbnEEID
    AND EecCOID = dbnCOID
    JOIN dbo.EmpPers WITH(NOLOCK)
    ON EepEEID = dbnEEID
    JOIN dbo.U_EDISPCRCOB_DeathEvent WITH(NOLOCK)
    ON EecEEID = EeDeathId
    AND IsSpouse = '1' -- SPOUSE FLAG
    WHERE DbnValidForExport = 'N'
    AND DbnFormatCode = 'EDISPCRCOB'
    --AND eeceeid = 'DTCQW5000040'
    AND EecTermReason = '203'
    AND DbnRelationship IN ('SPS', 'SPX', 'DMP', 'DP')

     -- 203 death insert dependent
    INSERT INTO [dbo].[U_dsi_BDM_EDISPCRCOB]
    ([BdmRecType]
    ,[BdmCOID]
    ,[BdmEEID]
    ,[BdmDepRecID]
    ,[BdmSystemID]
    ,[BdmRunID]
    ,[BdmDedRowStatus]
    ,[BdmRelationship]
    ,[BdmDateOfBirth]
    ,[BdmDedCode]
    ,[BdmBenOption]
    ,[BdmBenStartDate]
    ,[BdmBenStopDate]
    ,[BdmBenStatusDate]
    ,[BdmDateOFCobraEvent]
    ,[BdmChangeReason]
    ,[BdmCobraReason]
    ,[BdmStartDate]
    ,[BdmStopDate]
    ,[BdmIsPQB]
    )
    SELECT DISTINCT 'DEP'
    ,EecCOID
    ,EecEEID
    ,DbnDepRecID
    ,NULL
    ,'QB'
    ,'Data inserted for 203 term reason'
    , DbnRelationship
    ,EepDateOfBirth
    ,DedDedCode
    ,DbnBenOption
    ,DbnBenStartDate
    ,DbnBenStopDate 
    ,DbnBenStatusDate
    ,DbnBenStatusDate
    ,'210'
    ,'210'
    ,NULL
    ,NULL
    ,'N'
    FROM dbo.EmpComp WITH(NOLOCK)
    JOIN dbo.u_dsi_bdm_DepDeductions WITH(NOLOCK)
    ON EecEEID = dbnEEID
    AND EecCOID = dbnCOID
    JOIN dbo.EmpPers WITH(NOLOCK)
    ON EepEEID = dbnEEID
    JOIN dbo.U_EDISPCRCOB_DeathEvent WITH(NOLOCK)
    ON EecEEID = EeDeathId
    AND IsSpouse = '1' -- SPOUSE FLAG USED TO INSERT A 2ND RECORD FOR CHILD AS PQB = 'N'
    WHERE DbnValidForExport = 'N'
    AND DbnFormatCode = 'EDISPCRCOB'
    --AND eeceeid = 'DTCQW5000040'
    AND EecTermReason = '203'
    AND DbnRelationship IN ('CHL', 'DPC', 'STC')

    ---- DELETE TEST EMPLOYEES FROM BDM ----
    DELETE dbo.[U_dsi_BDM_EDISPCRCOB]
    WHERE EXISTS  (SELECT DISTINCT EepEEID
                        FROM dbo.EmpPers
                        WHERE dbo.[U_dsi_BDM_EDISPCRCOB].bdmeeid = eepeeid
                        and LEFT(EepSSN, 3) = '999')

     INSERT INTO [dbo].[U_dsi_BDM_EDISPCRCOB]
    ([BdmRecType]
    ,[BdmCOID]
    ,[BdmEEID]
    ,[BdmDepRecID]
    ,[BdmSystemID]
    ,[BdmRunID]
    ,[BdmDedRowStatus]
    ,[BdmRelationship]
    ,[BdmDateOfBirth]
    ,[BdmDedCode]
    ,[BdmBenOption]
    ,[BdmBenStartDate]
    ,[BdmBenStopDate]
    ,[BdmBenStatusDate]
    ,[BdmDateOFCobraEvent]
    ,[BdmChangeReason]
    ,[BdmCobraReason]
    ,[BdmStartDate]
    ,[BdmStopDate]
    ,[BdmIsPQB]
    )
    SELECT DISTINCT 'DEP'
    ,EecCOID
    ,EecEEID
    ,DbnDepRecID
    ,NULL
    ,'QB'
    ,'Data inserted for 203 term reason'
    , DbnRelationship
    ,EepDateOfBirth
    ,DedDedCode
    ,DbnBenOption
    ,DbnBenStartDate
    ,DbnBenStopDate 
    ,DbnBenStatusDate
    ,DbnBenStatusDate
    ,'210'
    ,'210'
    ,NULL
    ,NULL
    ,'Y'
    FROM dbo.EmpComp WITH(NOLOCK)
    JOIN dbo.u_dsi_bdm_DepDeductions WITH(NOLOCK)
    ON EecEEID = dbnEEID
    AND EecCOID = dbnCOID
    JOIN dbo.EmpPers WITH(NOLOCK)
    ON EepEEID = dbnEEID
    JOIN dbo.U_EDISPCRCOB_DeathEvent WITH(NOLOCK)
    ON EecEEID = EeDeathId
    AND IsSpouse = '0' -- IF NO SPOUSE EXISTS THEN CHILD IS PQB
    WHERE DbnValidForExport = 'N'
    AND DbnFormatCode = 'EDISPCRCOB'
    --AND eeceeid = 'DTCQW5000040'
    AND EecTermReason = '203'
    AND DbnRelationship IN ('CHL', 'DPC', 'STC')
    ORDER BY DbnRelationship DESC

      -- Dependents Count
        IF OBJECT_ID('U_EDISPCRCOB_DepCount','U') IS NOT NULL 
        DROP TABLE dbo.U_EDISPCRCOB_DepCount;

        SELECT e.bdmeeid as DCEEID, e.bdmcoid AS DCCOID, count(distinct(s.bdmdateofbirth)) as spouse_count, count(distinct(c.bdmdateofbirth)) as child_count
        into dbo.U_EDISPCRCOB_DepCount
        FROM dbo.U_dsi_BDM_EDISPCRCOB e WITH(NOLOCK) 
        left JOIN dbo.U_dsi_BDM_EDISPCRCOB s WITH(NOLOCK) ON e.bdmeeid = s.bdmeeid  and s.bdmrelationship in ('sps', 'spx', 'dmp', 'dp')
        left join dbo.U_dsi_BDM_EDISPCRCOB c with(nolock) on e.bdmeeid = c.bdmeeid and c.bdmrelationship in ('chl', 'dpc', 'stc')

        group by e.bdmeeid, e.bdmcoid

    --==========================================
    -- Build driver tables
    --==========================================
    ------------------
    -- DETAIL RECORD - NPM Record
    ------------------
    IF OBJECT_ID('U_EDISPCRCOB_drvTbl_NPM') IS NOT NULL
        DROP TABLE dbo.U_EDISPCRCOB_drvTbl_NPM;
    SELECT DISTINCT
         drvEEID            = BdmEEID
        ,drvCoID            = BdmCoID
        ,drvSSN             = eepSSN
        ,drvEmpNo           = ''
        ,drvClientName      = CONVERT(varchar(100),'PCRK Employee Leasing Company LLC 40641')
        ,drvClientDivName   = CONVERT(varchar(50),'PCRK Employee Leasing Company LLC')
        ,drvNameFirst       = EepNameFirst
        ,drvNameMiddle      = LEFT(EepNameMiddle,1)
        ,drvNameLast        = EepNameLast
        ,drvAddressEMail    = ''
        ,drvPhoneHomeNumber = ''
        ,drvAddressLine1    = REPLACE(EepAddressLine1, ',', '')
        ,drvAddressLine2    = REPLACE(EepAddressLine2, ',', '')
        ,drvAddressCity     = EepAddressCity
        ,drvAddressState    = EepAddressState
        ,drvAddressZipCode  = EepAddressZipCode
        ,drvGender          = CASE WHEN EepGender = 'M' THEN 'M'
                                    WHEN EepGender = 'F' THEN 'F' 
                                ELSE 'U' END
        ,drvHireDate        = EecDateOfLastHire
        --ISNULL(CONVERT(VARCHAR, (CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN EecDateOfLastHire END), 101), '')
        ,drvInitialSort     = '22'
        ,drvSubSort         = eepSSN
        ,drvSubSort2        = ''
        ,drvSubSort3        = ''
    INTO dbo.U_EDISPCRCOB_drvTbl_NPM
    FROM dbo.U_dsi_BDM_EDISPCRCOB WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = BdmEEID
       AND EecCoID = BdmCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = BdmEEID
    WHERE BdmRunID = 'NPM';

    ------------------
    -- QB DETAIL RECORD
    ------------------
    IF OBJECT_ID('U_EDISPCRCOB_drvTbl_QB') IS NOT NULL
        DROP TABLE dbo.U_EDISPCRCOB_drvTbl_QB;
    SELECT DISTINCT
         drvEEID           = BdmEEID
        ,drvCoID           = BdmCoID
        ,drvDepRecID       = ISNULL(BdmDepRecID,'')
        ,drvClientName     = CONVERT(varchar(100),'PCRK Employee Leasing Company LLC 40641')
        ,drvClientDivName  = CONVERT(varchar(50),'PCRK Employee Leasing Company LLC')
        ,drvNameFirst      = CASE WHEN BdmChangeReason IN ('201', 'LEVNT3', '204', '210', 'LEVNT4', '203') THEN ConNameFirst ELSE EepNameFirst END
        ,drvNameMiddle     = CASE WHEN BdmChangeReason IN ('201', 'LEVNT3', '204', '210', 'LEVNT4', '203') THEN LEFT(ConNameMiddle, 1) ELSE LEFT(EepNameMiddle, 1) END
        ,drvNameLast       = CASE WHEN BdmChangeReason IN ('201', 'LEVNT3', '204', '210', 'LEVNT4', '203') THEN ConNameLast ELSE EepNameLast END
        ,drvSSN            = CASE WHEN BdmChangeReason IN ('201', 'LEVNT3', '204', '210', 'LEVNT4', '203') THEN SUBSTRING(ConSSN, 1, 3)+'-'+
                                                                                                                    SUBSTRING(ConSSN, 4, 2)+'-'+
                                                                                                                    SUBSTRING(ConSSN, 6, 4)  ELSE SUBSTRING(EepSSN, 1, 3)+'-'+
                                                                                                                                                    SUBSTRING(EepSSN, 4, 2)+'-'+
                                                                                                                                                    SUBSTRING(EepSSN, 6, 4)  END
        ,drvEmpNo          = ''
        ,drvAddressLine1   = CASE WHEN BdmChangeReason IN ('201', 'LEVNT3', '204', '210', 'LEVNT4', '203') THEN REPLACE(ConAddressLine1, ',', '') ELSE REPLACE(EepAddressLine1, ',', '') END
        ,drvAddressLine2   = CASE WHEN BdmChangeReason IN ('201', 'LEVNT3', '204', '210', 'LEVNT4', '203') THEN REPLACE(ConAddressLine2, ',', '') ELSE REPLACE(EepAddressLine2, ',', '') END
        ,drvAddressCity    = CASE WHEN BdmChangeReason IN ('201', 'LEVNT3', '204', '210', 'LEVNT4', '203') THEN ConAddressCity ELSE EepAddressCity END
        ,drvAddressState   = CASE WHEN BdmChangeReason IN ('201', 'LEVNT3', '204', '210', 'LEVNT4', '203') THEN ConAddressState ELSE EepAddressState END
        ,drvAddressZipCode = CASE WHEN BdmChangeReason IN ('201', 'LEVNT3', '204', '210', 'LEVNT4', '203') THEN ConAddressZipCode ELSE EepAddressZipCode END
        ,drvGender         = CASE WHEN EepGender = 'M' OR ConGender = 'M' THEN 'M'
                                    WHEN EepGender = 'F' OR ConGender = 'F' THEN 'F' ELSE 'U' END
        ,drvDateOfBirth    = CASE WHEN BdmChangeReason IN ('201', 'LEVNT3', '204', '210', 'LEVNT4', '203') THEN ConDateOfBirth ELSE EepDateOfBirth END
        ,drvInitialSort    = '21'
        ,drvSubSort        = CASE WHEN BdmRecType = 'EMP' THEN eepSSN
                                  ELSE ISNULL(NULLIF(ConSSN,''),eepSSN) + CONVERT(char(8),ConDateOfBirth,112)
                             END
        ,drvSubSort2       = '1'
        ,drvSubSort3       = CASE WHEN BdmRecType = 'EMP' THEN '2'
                                  ELSE CONVERT(char(8),ConDateOfBirth,112) + RTRIM(ConNameLast) + ConNameFirst
                             END
    INTO dbo.U_EDISPCRCOB_drvTbl_QB
    FROM dbo.U_dsi_BDM_EDISPCRCOB WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = BdmEEID
       AND EecCoID = BdmCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = BdmEEID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = BdmEEID
       AND ConSystemID = BdmDepRecID
    WHERE BdmRunID = 'QB'
      AND BdmIsPQB = 'Y';

    ------------------
    -- QBEVENT DETAIL RECORD
    ------------------
    IF OBJECT_ID('U_EDISPCRCOB_drvTbl_QBEVENT') IS NOT NULL
        DROP TABLE dbo.U_EDISPCRCOB_drvTbl_QBEVENT;
    SELECT DISTINCT
         drvEEID           = drvEEID
        ,drvCoID           = drvCoID
        ,drvDepRecID       = drvDepRecID
        ,drvEventType      = CASE WHEN EecEmplStatus = 'T' AND EecTermReason NOT IN ('202', '203') AND EecTermType = 'V' THEN 'TERMINATION'
                                    WHEN EecEmplStatus = 'T' AND EecTermReason NOT IN ('202', '203') AND EecTermType = '' THEN 'TERMINATION'
                                    WHEN EecEmplStatus = 'T' AND EecTermReason = '203' THEN 'DEATH'
                                    WHEN EecEmplStatus = 'T' AND EecTermReason = '202' THEN 'RETIREMENT'
                                    WHEN EecEmplStatus = 'T' AND EecTermType = 'I' THEN 'INVOLUNTARYTERMINATION'
                                    WHEN Bdmcobrareason = '208' THEN 'RETIREMENT'
                                    WHEN Bdmcobrareason = '205' THEN 'MEDICARE'
                                    WHEN Bdmcobrareason IN ('204', 'LEVNT4') THEN 'DIVORCELEGALSEPARATION'
                                    WHEN bdmcobrareason IN ('201', 'LEVNT3') THEN 'INELIGIBLEDEPENDENT'
                                    WHEN bdmcobrareason IN ('203', '202') THEN 'REDUCTIONINHOURS-STATUSCHANGE'
                                    WHEN bdmcobrareason = '206' THEN 'REDUCTIONINHOURS-ENDOFLEAVE'
                                    ELSE 'TERMINATION'
                                END
        /*CASE WHEN EecTermReason = '202' THEN 'RETIREMENT'
                                  WHEN EecTermReason = '203' THEN 'DEATH'
                                  WHEN BdmCobraReason IN ('201','LEVNT3') THEN 'INELIGIBLEDEPENDENT'
                                  WHEN BdmCobraReason IN ('204','LEVNT4') THEN 'DIVORCELEGALSEPARATION'
                                  WHEN BdmCobraReason = '210' THEN 'DEATH'
                                  WHEN BdmCobraReason IN ('202','CHGRP') THEN 'LOSSOFELIGIBILITY'
                                  WHEN BdmCobraReason = '203' THEN 'REDUCTIONINHOURS-STATUSCHANGE'
                                  WHEN BdmCobraReason = '205' THEN 'MEDICARE'
                                  WHEN BdmCobraReason = '206' THEN 'REDUCTIONINHOURS-ENDOFLEAVE'
                                  WHEN BdmCobraReason = '207' THEN 'USERRA-REDUCTIONINHOURS'
                                  WHEN BdmCobraReason = '208' THEN 'RETIREMENT'
                                  WHEN BdmCobraReason = '209' THEN 'WORKSTOPPAGE'
                                  ELSE 'TERMINATION'
                             END */
        ,drvEventDate      = CASE WHEN EecEmplStatus = 'T' AND EecTermReason NOT IN ('202', '203') THEN EecDateOfTermination
                                    WHEN EecEmplStatus = 'T' AND EecTermReason IN ('202', '203') AND BdmDateOfCOBRAEvent = '' THEN EecDateOfTermination
                                    WHEN BdmChangeReason IN ('LEVNT3', 'LEVNT4', '204', '210', '201') THEN edh.EdhEffDate 
                                ELSE BdmDateOfCOBRAEvent END
        ,drvEnrollmentDate = (SELECT MAX(BdmBenStartDate) FROM dbo.U_dsi_BDM_EDISPCRCOB a WITH(NOLOCK) WHERE a.bdmeeid = bdm.bdmeeid and a.bdmcoid = bdm.bdmcoid)
        ,drvSSN            = SUBSTRING(EepSSN, 1, 3)+'-'+
                                SUBSTRING(EepSSN, 4, 2)+'-'+
                                SUBSTRING(EepSSN, 6, 4) 
        ,drvName           = RTRIM(EepNameFirst) + ' ' + RTRIM(EepNameLast)
                            /*CASE WHEN BdmRecType = 'DEP' THEN RTRIM(EepNameFirst) + ' ' + EepNameLast
                                  ELSE ''
                             END */
        ,drvInitialSort    = '21'
        ,drvSubSort        = drvSubSort
        ,drvSubSort2       = '1'
        ,drvSubSort3       = drvSubSort3
    INTO dbo.U_EDISPCRCOB_drvTbl_QBEVENT
    FROM dbo.U_EDISPCRCOB_drvTbl_QB WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = drvEEID
       AND EecCoID = drvCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = drvEEID
    JOIN (SELECT
             BdmEEID
            ,BdmCoID
            ,BdmDedCode
            ,BdmDepRecID
            ,BdmRecType
            ,BdmChangeReason
            ,BdmCobraReason = MAX(BdmCobraReason)
            ,BdmBenStartDate = MIN(BdmBenStartDate)
            ,BdmDateOfCOBRAEvent = MAX(BdmDateOfCOBRAEvent)
            ,BdmUSGDate1 = MAX(BdmUSGDate1)
          FROM dbo.U_dsi_BDM_EDISPCRCOB WITH (NOLOCK)
          WHERE BdmRunID = 'QB'
            AND BdmIsPQB = 'Y'
          GROUP BY BdmEEID, BdmCoID, BdmDedCode, BdmDepRecID, BdmRecType, BdmChangeReason) BDM
        ON BdmEEID = drvEEID
       AND BdmCoID = drvCoID
       AND ISNULL(BdmDepRecID,'') = drvDepRecID
    OUTER APPLY (SELECT TOP 1 EdhEffDate FROM dbo.EmpHDed WITH(NOLOCK) 
    WHERE BdmDedCode = EdhDedCode and BdmCOID = EdhCOID and BdmEEID = EdhEEID ORDER BY EdhDateTimeCreated DESC) edh;

    ------------------
    -- QBPLANINITIAL DETAIL RECORD
    ------------------
    IF OBJECT_ID('U_EDISPCRCOB_drvTbl_QBPLAN') IS NOT NULL
        DROP TABLE dbo.U_EDISPCRCOB_drvTbl_QBPLAN;
    SELECT DISTINCT
         drvEEID          = drvEEID
        ,drvCoID          = drvCoID
        ,drvDepRecID      = drvDepRecID
        ,drvDedCode       = BdmDedCode
        ,drvPlanName      = CASE BdmDedCode 
                                WHEN 'DENH' THEN 'MetLife Dental High DPPO'
                                WHEN 'DENL' THEN 'MetLife Dental Low DPPO'
                                WHEN 'VISH' THEN 'MetLife Vision High PPO'
                                WHEN 'VISL' THEN 'MetLife Vision Low PPO'
                                WHEN 'MEDU4' THEN 'UHC Medical Choice Plus PPO $1000'
                                WHEN 'MEDU3' THEN 'UHC Medical Choice Plus PPO $3000'
                                WHEN 'MEDU2' THEN 'UHC Medical Choice Plus PPO $6000'
                                WHEN 'MEDU1' THEN 'UHC Medical Choice Plus PPO $7150'
                                WHEN 'FSA' THEN 'WEX FSA' END
        /*CONVERT(varchar(50),'@PlanName')*/
        ,drvCoverageLevel = CASE WHEN BdmCobraReason IN ('204', 'LEVNT4', '201', 'LEVNT3', '210') AND BdmRelationship IN ('DMP', 'DP', 'SPS', 'SPX') AND child_count = 1
                                        THEN 'EE+CHILD'
                                WHEN BdmCobraReason IN ('204', 'LEVNT4', '201', 'LEVNT3', '210') AND BdmRelationship IN ('DMP', 'DP', 'SPS', 'SPX') AND child_count > 1
                                        THEN 'EE+CHILDREN'
                                WHEN BdmCobraReason IN ('204', 'LEVNT4', '201', 'LEVNT3', '210') AND BdmRelationship IN ('DMP', 'DP', 'SPS', 'SPX') AND child_count = 0
                                        THEN 'EE'
								WHEN BdmCobraReason NOT IN ('204', 'LEVNT4', '201', 'LEVNT3', '210') AND BdmDedCode IN ('DENH', 'DENL', 'VISH', 'VISL', 'MEDU4',
                                                    'MEDU3', 'MEDU2', 'MEDU1') AND BdmBenOption IN ('EEF', 'EEDPF') THEN 'EE+FAMILY'
                                WHEN BdmCobraReason NOT IN ('204', 'LEVNT4', '201', 'LEVNT3', '210') AND BdmDedCode IN ('DENH', 'DENL', 'VISH', 'VISL', 'MEDU4',
                                                    'MEDU3', 'MEDU2', 'MEDU1') AND child_count = 1 THEN 'EE+CHILD'
                                WHEN BdmCobraReason NOT IN ('204', 'LEVNT4', '201', 'LEVNT3', '210') AND BdmDedCode IN ('DENH', 'DENL', 'VISH', 'VISL', 'MEDU4',
                                                    'MEDU3', 'MEDU2', 'MEDU1') AND child_count > 1 THEN 'EE+CHILDREN'
                                WHEN BdmCobraReason NOT IN ('204', 'LEVNT4', '201', 'LEVNT3', '210') AND BdmDedCode IN ('DENH', 'DENL', 'VISH', 'VISL', 'MEDU4',
                                                    'MEDU3', 'MEDU2', 'MEDU1') AND BdmBenOption = 'EEDP' THEN 'EE+DOMESTICPARTNER'
                                WHEN BdmCobraReason NOT IN ('204', 'LEVNT4', '201', 'LEVNT3', '210') AND BdmDedCode IN ('DENH', 'DENL', 'VISH', 'VISL', 'MEDU4',
                                                    'MEDU3', 'MEDU2', 'MEDU1') AND BdmBenOption = 'EES' THEN 'EE+SPOUSE'
								WHEN BdmCobraReason NOT IN ('204', 'LEVNT4', '201', 'LEVNT3', '210') AND BdmDedCode IN ('DENH', 'DENL', 'VISH', 'VISL', 'MEDU4',
                                                    'MEDU3', 'MEDU2', 'MEDU1') AND BdmBenOption = 'EE' THEN 'EE'
                                WHEN BdmDedCode = 'FSA' THEN 'EE' 
                            END

                                
        -- CASE WHEN BdmDedCode IN ('MEDHD', 'MEDPP', 'DEN', 'VIS') THEN 
        --                         CASE WHEN BdmBenOption IN ('EE', 'EEP', 'EEMD') THEN 'EE'
        --                              WHEN BdmBenOption IN ('EEC1', 'EEC1MD', 'EEC1P') THEN 'EE+CHILD'
        --                              WHEN BdmBenOption IN ('EEC', 'EECP', 'EECMD') THEN 'EE+CHILDREN'
        --                              WHEN BdmBenOption IN ('EEDP', 'EEDPP', 'EEDMMD', 'EEDPNP') THEN 'EE+DOMESTICPARTNER'
        --                              WHEN BdmBenOption IN ('EEF', 'EEFP', 'EEFMD', 'EEF0', 'EEF0MD', 'EEF0P', 'EEDPFP', 'EEDPFN', 'EEDPNC', 'EEDFMD', 'EEDPN') THEN 'EE+FAMILY'
        --                              WHEN BdmBenOption IN ('EES', 'EESP', 'EESMD', 'EES0', 'EES0MD', 'EES0P') THEN 'EE+SPOUSE'
        --                         END
        --                     END
                /*CASE WHEN BdmDedType = 'FSA' THEN 'EE'
                                 WHEN BdmRecType = 'EMP' THEN
                                      CASE WHEN BdmBenOption IN ('@EEBenOpts') THEN 'EE'
                                           WHEN BdmBenOption IN ('@ECHBenOpts') THEN 'EE+CHILDREN'
                                           WHEN BdmBenOption IN ('@ESPBenOpts') THEN 'EE+SPOUSE'
                                           WHEN BdmBenOption IN ('@EDPBenOpts') THEN 'EE+DOMESTICPARTNER'
                                           WHEN BdmBenOption IN ('@EEFAMBenOpts') THEN 'EE+FAMILY'
                                      END
                                 WHEN BdmRelationship IN ('@SPSRelationships','@DPRelationships') THEN
                                      CASE WHEN ISNULL(BdmNumChildren,0) = 1 THEN 'EE+1'
                                           WHEN ISNULL(BdmNumChildren,0) > 1 THEN 'EE+FAMILY'
                                           ELSE 'EE'
                                      END
                                 ELSE 'EE'
                            END */
        ,drvInitialSort   = '21'
        ,drvSubSort       = drvSubSort
        ,drvSubSort2      = '1' + BdmDedCode
        ,drvSubSort3      = drvSubSort3
    INTO dbo.U_EDISPCRCOB_drvTbl_QBPLAN
    FROM dbo.U_EDISPCRCOB_drvTbl_QBEVENT WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EDISPCRCOB WITH (NOLOCK)
        ON BdmEEID = drvEEID
       AND BdmCoID = drvCoID
       AND ISNULL(BdmDepRecID,'') = drvDepRecID
    JOIN dbo.U_EDISPCRCOB_DepCount WITH(NOLOCK)
        ON DCEEID = BdmEEID
        AND DCCOID = BdmCOID
    WHERE BdmRunID = 'QB'
      AND BdmIsPQB = 'Y';

    ------------------
    -- QBDEPENDENT DETAIL RECORD
    ------------------
    IF OBJECT_ID('U_EDISPCRCOB_drvTbl_QBDEP') IS NOT NULL
        DROP TABLE dbo.U_EDISPCRCOB_drvTbl_QBDEP;
    SELECT DISTINCT
         drvEEID           = BdmEEID
        ,drvCoID           = BdmCoID
        ,drvDepRecID       = BdmDepRecID
        ,drvSSN            = SUBSTRING(ConSSN, 1, 3)+'-'+
                                SUBSTRING(ConSSN, 4, 2)+'-'+
                                SUBSTRING(ConSSN, 6, 4) 
        ,drvRelationship   = CASE WHEN BdmRelationship IN ('SPS', 'SPX') THEN 'SPOUSE'
                                  WHEN BdmRelationship IN ('DP', 'DMP') THEN 'DOMESTICPARTNER'
                                  ELSE 'CHILD'
                             END
        ,drvNameFirst      = ConNameFirst
        ,drvNameMiddle     = LEFT(ConNameMiddle,1)
        ,drvNameLast       = ConNameLast
        ,drvIsAddressSame  = CASE WHEN ConAddressIsDifferent = 'N' OR ConAddressLine1 IS NULL THEN 'TRUE'
                                  ELSE 'FALSE'
                             END
        ,drvAddressLine1   = ''
        ,drvAddressLine2   = ''
        ,drvAddressCity    = ''
        ,drvAddressState   = ''
        ,drvAddressZipCode = ''
        ,drvGender         = CASE WHEN ConGender = 'M' THEN 'M' 
                                    WHEN ConGender = 'F' THEN 'F'
                                    ELSE 'U' END
        ,drvDateOfBirth    = ConDateOfBirth
        ,drvISQMCO         = CASE WHEN BdmRelationship IN ('@QMCORelationships') THEN 'TRUE'
                                  ELSE 'FALSE'
                             END
        ,drvInitialSort    = '21'
        ,drvSubSort        = drvSubSort
        ,drvSubSort2       = '2' + CASE WHEN BdmRelationship IN ('SPS', 'SPX', 'DP', 'DMP') THEN 'A'
                                        ELSE 'B' + ISNULL(ConSSN,ConNameFirst)
                                   END + CONVERT(char(8),ISNULL(ConDateOfBirth,''),112) + ConSystemID
        ,drvSubSort3       = drvSubSort3
    INTO dbo.U_EDISPCRCOB_drvTbl_QBDEP
    FROM dbo.U_EDISPCRCOB_drvTbl_QB WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EDISPCRCOB WITH (NOLOCK)
        ON BdmEEID = drvEEID
       AND BdmCoID = drvCoID
    JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = BdmEEID
       AND ConSystemID = BdmDepRecID
    WHERE BdmRunID = 'QB'
    AND drvDepRecID <> ConSystemID
    --AND BdmIsPQB = 'N';

    ------------------
    -- QBDEPENDENTPLANINITIAL DETAIL RECORD
    ------------------
    IF OBJECT_ID('U_EDISPCRCOB_drvTbl_QBDEPPLAN') IS NOT NULL
        DROP TABLE dbo.U_EDISPCRCOB_drvTbl_QBDEPPLAN;
    SELECT DISTINCT
         drvEEID        = BdmEEID
        ,drvCoID        = BdmCoID
        ,drvDepRecID    = BdmDepRecID
        ,drvDedCode     = BdmDedCode
        ,drvPlanName    = CASE BdmDedCode 
                                WHEN 'DENH' THEN 'MetLife Dental High DPPO'
                                WHEN 'DENL' THEN 'MetLife Dental Low DPPO'
                                WHEN 'VISH' THEN 'MetLife Vision High PPO'
                                WHEN 'VISL' THEN 'MetLife Vision Low PPO'
                                WHEN 'MEDU4' THEN 'UHC Medical Choice Plus PPO $1000'
                                WHEN 'MEDU3' THEN 'UHC Medical Choice Plus PPO $3000'
                                WHEN 'MEDU2' THEN 'UHC Medical Choice Plus PPO $6000'
                                WHEN 'MEDU1' THEN 'UHC Medical Choice Plus PPO $7150'
                                WHEN 'FSA' THEN 'WEX FSA' END
        ,drvInitialSort = '21'
        ,drvSubSort     = drvSubSort
        ,drvSubSort2    = '2' + CASE WHEN BdmRelationship IN ('SPS', 'SPX', 'DP', 'DMP') THEN 'A'
                                     ELSE 'B' + RTRIM(ISNULL(ConSSN,ConNameFirst))
                                END + CONVERT(char(8),ISNULL(ConDateOfBirth,''),112) + ConSystemID + BdmDedCode
        ,drvSubSort3    = drvSubSort3
    INTO dbo.U_EDISPCRCOB_drvTbl_QBDEPPLAN
    FROM dbo.U_EDISPCRCOB_drvTbl_QBPLAN WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EDISPCRCOB WITH (NOLOCK)
        ON BdmEEID = drvEEID
       AND BdmCoID = drvCoID
       AND BdmDedCode = drvDedCode
    JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = BdmEEID
       AND ConSystemID = BdmDepRecID
    WHERE BdmRunID = 'QB'
    AND drvDepRecID <> ConSystemID
   --   AND BdmIsPQB = 'N';

     ------------------
    -- QBSTATEINSERTS DETAIL RECORD -- MN-CONTINSERT
    ------------------

    IF OBJECT_ID('U_EDISPCRCOB_drvTbl_QBSTATEINSERT') IS NOT NULL
        DROP TABLE dbo.U_EDISPCRCOB_drvTbl_QBSTATEINSERT;
    SELECT DISTINCT
         drvEEID        = drvEEID
        ,drvCoID        = drvCoID
        ,drvDepRecID    = drvDepRecID
        ,drvStateSpecDocName = CASE EepAddressState 
                                WHEN 'CA' THEN 'CA-SRINSERT'
                                WHEN 'CT' THEN 'CT-SRINSERT'
                                WHEN 'OR' THEN 'OR-SRINSERT'
                                WHEN 'TX' THEN 'TX-SRINSERT'
                                WHEN 'NY' THEN 'NY-SRINSERT'
                                WHEN 'IL' THEN 'IL-SRINSERT'
                                WHEN 'RI' THEN 'RI-SRINSERT'
                                WHEN 'GA' THEN 'GA-SRINSERT'
                                WHEN 'VA' THEN 'VA-SRINSERT'
                                WHEN 'MN' THEN 'MN-CONTINSERT' -- 2ND INSERT BELOW
                                END
        ,drvInitialSort = '21'
        ,drvSubSort     = drvSubSort
        ,drvSubSort2    = '4'
        ,drvSubSort3    = drvSubSort3
    INTO dbo.U_EDISPCRCOB_drvTbl_QBSTATEINSERT
    FROM dbo.U_EDISPCRCOB_drvTbl_QBPLAN WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EDISPCRCOB WITH (NOLOCK)
        ON BdmEEID = drvEEID
       AND BdmCoID = drvCoID
       AND ISNULL(BdmDepRecID,'') = drvDepRecID
       AND BdmDedCode = drvDedCode
    JOIN dbo.EmpPers WITH(NOLOCK)
    ON EepEEID = drvEEID 
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = BdmEEID
       AND EecCoID = BdmCoID
    WHERE BdmRunID = 'QB'
    AND EepAddressState IN ('CA', 'CT', 'OR', 'TX', 'NY', 'IL', 'RI', 'GA', 'VA', 'MN');

      ------------------
    -- QBSTATEINSERTS DETAIL RECORD -- MN-LIFEINSERT
    ------------------

    INSERT INTO dbo.U_EDISPCRCOB_drvTbl_QBSTATEINSERT
    SELECT DISTINCT
         drvEEID  
        ,drvCoID  
        ,drvDepRecID 
        ,drvStateSpecDocName = 'MN-LIFEINSERT'
        ,drvInitialSort 
        ,drvSubSort   
        ,drvSubSort2   
        ,drvSubSort3    
    --INTO dbo.U_EDISPCRCOB_drvTbl_QBSTATEINSERT
    FROM dbo.U_EDISPCRCOB_drvTbl_QBSTATEINSERT WITH (NOLOCK)
    JOIN dbo.EmpPers WITH(NOLOCK)
    ON EepEEID = drvEEID
    WHERE EepAddressState = 'MN'

    ------------------
    -- QBPLANMEMBERSPECIFICRATEINITIAL DETAIL RECORD
    ----------------
    IF OBJECT_ID('U_EDISPCRCOB_drvTbl_QBMSRI') IS NOT NULL
        DROP TABLE dbo.U_EDISPCRCOB_drvTbl_QBMSRI;
    SELECT DISTINCT
         drvEEID        = drvEEID
        ,drvCoID        = drvCoID
        ,drvDepRecID    = drvDepRecID
        ,drvPlanName    = drvPlanName
        ,drvRate        = BdmEEAmt
        --CASE WHEN EecPayPeriod = 'M' THEN BdmEEAmt
  --                             WHEN EecPayPeriod = 'S' THEN BdmEEAmt * 2
  --                             WHEN EecPayPeriod = 'B' THEN BdmEEAmt * 26/12
  --                             WHEN EecPayPeriod = 'W' THEN BdmEEAmt * 52/12
  --                        END
        ,drvInitialSort = '21'
        ,drvSubSort     = drvSubSort
        ,drvSubSort2    = '3'
        ,drvSubSort3    = drvSubSort3
    INTO dbo.U_EDISPCRCOB_drvTbl_QBMSRI
    FROM dbo.U_EDISPCRCOB_drvTbl_QBPLAN WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EDISPCRCOB WITH (NOLOCK)
        ON BdmEEID = drvEEID
       AND BdmCoID = drvCoID
       AND ISNULL(BdmDepRecID,'') = drvDepRecID
       AND BdmDedCode = drvDedCode
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = BdmEEID
       AND EecCoID = BdmCoID
    WHERE BdmRunID = 'QB'
      AND BdmIsPQB = 'Y'
      AND BdmDedType = 'FSA';

    ---- SET COVERAGE LEVEL = 'EE' FOR EMPLOYEES THAT HAVE INELIGIBLE DEPENDENT AS THE EVENT TYPE ----
    UPDATE dbo.U_EDISPCRCOB_drvTbl_QBPLAN
    SET drvCoverageLevel = 'EE'
    FROM dbo.U_EDISPCRCOB_drvTbl_QBEVENT a WITH(NOLOCK)
    WHERE a.drvEEID = dbo.U_EDISPCRCOB_drvTbl_QBPLAN.drvEEID
    AND a.drvCOID = dbo.U_EDISPCRCOB_drvTbl_QBPLAN.drvCOID
    AND a.drvEventType = 'INELIGIBLEDEPENDENT'
    AND dbo.U_EDISPCRCOB_drvTbl_QBPLAN.drvCoverageLevel IS NULL

    ---- REMOVE DEPENDENTS THAT ARE >= 26 FOR DEPENDENT TABLE ----
    DELETE dbo.U_EDISPCRCOB_drvTbl_QBDEP
    WHERE drvDepRecID = (SELECT DISTINCT BdmDepRecId
                            FROM dbo.U_EDISPCRCOB_drvTbl_QBEVENT a WITH(NOLOCK) JOIN dbo.u_dsi_bdm_EDISPCRCOB
                            ON a.drvEEID = bdmEEID
                            AND a.drvCOID = bdmCOID
                            JOIN dbo.Contacts b WITH(NOLOCK)
                            ON drvEEID = ConEEID
                            AND drvDepRecId = ConSystemId
                            WHERE a.drvEEID = drvEEID
                            AND a.drvCOID = drvCOID
                            AND DATEDIFF(year, ConDateOfBirth, drvEnrollmentDate ) >= 26 
                            AND  bdmrelationship in ('chl', 'dpc', 'stc')
                            AND a.drvEventType = 'INELIGIBLEDEPENDENT'
                            )

    ---- REMOVE DEPENDENTS THAT ARE >= 26 FOR DEPENDENT PLAN TABLE ----
    DELETE dbo.U_EDISPCRCOB_drvTbl_QBDEPPLAN
    WHERE drvDepRecID = (SELECT DISTINCT BdmDepRecId
                            FROM dbo.U_EDISPCRCOB_drvTbl_QBEVENT a WITH(NOLOCK) JOIN dbo.u_dsi_bdm_EDISPCRCOB
                            ON a.drvEEID = bdmEEID
                            AND a.drvCOID = bdmCOID
                            JOIN dbo.Contacts b WITH(NOLOCK)
                            ON drvEEID = ConEEID
                            AND drvDepRecId = ConSystemId
                            WHERE a.drvEEID = drvEEID
                            AND a.drvCOID = drvCOID
                            AND DATEDIFF(year, ConDateOfBirth, drvEnrollmentDate ) >= 26 
                            AND  bdmrelationship in ('chl', 'dpc', 'stc')
                            AND a.drvEventType = 'INELIGIBLEDEPENDENT'
                            )

    --DELETE u_dsi_bdm_EDISPCRCOB
    --WHERE BdmDepRecID = (SELECT DISTINCT CASE WHEN DATEDIFF(year, ConDateOfBirth, BdmBenStartDate ) >= 26 and bdmrelationship in ('chl', 'dpc', 'stc') then ConSystemID END
    --FROM dbo.Contacts WITH(NOLOCK)
    --WHERE    ConEEID = bdmEEID
    --AND ConSystemID = BdmDepRecID)
    ------------------------------------------


     --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'NWOS_EDISPCRCOB_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'NWOS_EDISPCRCOB_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'NWOS_EDISPCRCOB_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END
END;
/*
--Alter the View
ALTER VIEW dbo.dsi_vwEDISPCRCOB_Export AS
    SELECT TOP 2000000 Data
    FROM dbo.U_EDISPCRCOB_File WITH (NOLOCK)
    ORDER BY InitialSort, SubSort, SubSort2, SubSort3, RecordSet;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EDISPCRCOB%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
SET expLastStartPerControl = '201601251'
   ,expStartPerControl     = '201601251'
   ,expLastEndPerControl   = '201602039'
   ,expEndPerControl       = '201602039'
WHERE expFormatCode = 'EDISPCRCOB'
  AND expExportCode LIKE 'TEST%';
*/
SET NOCOUNT OFF;
