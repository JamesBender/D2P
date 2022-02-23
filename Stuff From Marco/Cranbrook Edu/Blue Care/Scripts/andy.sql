USE [ULTIPRO_WPAICU]
GO
/****** Object:  StoredProcedure [dbo].[dsi_sp_BuildDriverTables_EPAYCOBRA]    Script Date: 4/3/2020 11:22:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EPAYCOBRA]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Advanced ICU Care

Created By: Andy Pineda
Business Analyst: Dian Turner
Create Date: 04/01/2020
Service Request Number: SR-2019-00260261

Purpose: Paylocity Benefits Cobra Export - Combined NPM/QB

Revision History
----------------
Update By            Date           Request Num        Desc
XXXX                 XX/XX/xxxx     SR-20XX-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EPAYCOBRA';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EPAYCOBRA';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EPAYCOBRA';
SELECT * FROM dbo.AscExp WHERE expFormatCode = 'EPAYCOBRA';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EPAYCOBRA' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPAYCOBRA', 'SCHEDULED';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPAYCOBRA', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPAYCOBRA', 'TEST';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EPAYCOBRA';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EPAYCOBRA', @AllObjects = 'Y', @IsWeb = 'Y';
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
    SET @FormatCode = 'EPAYCOBRA';

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
    DELETE FROM dbo.U_EPAYCOBRA_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCoID(xEEID)
      AND xEEID IN (SELECT xEEID FROM dbo.U_EPAYCOBRA_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


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
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','Y'); -- DedIsCobraCovered = 'Y'
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'NewEnrolleeType','2'); -- All new enrollees where no previous plan exists
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'TableType','EMP'); -- Only include employees on NPM file

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
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','CHD, CHL, DPC, STC');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');

    -- Run BDM for QB
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build driver tables
    --==========================================
    ------------------
    -- DETAIL RECORD - NPM Record
    ------------------
    IF OBJECT_ID('U_EPAYCOBRA_drvTbl_NPM') IS NOT NULL
        DROP TABLE dbo.U_EPAYCOBRA_drvTbl_NPM;
    SELECT DISTINCT
         drvEEID            = BdmEEID
        ,drvCoID            = BdmCoID
        ,drvSSN             = eepSSN
        ,drvEmpNo           = EecEmpNo
        ,drvClientName      = CONVERT(varchar(100),'Advanced ICU Care')
        ,drvClientDivName   = CONVERT(varchar(50),'Advanced ICU Care')
        ,drvNameFirst       = EepNameFirst
        ,drvNameMiddle      = LEFT(EepNameMiddle,1)
        ,drvNameLast        = EepNameLast
        ,drvAddressEMail    = eepAddressEMail
        ,drvPhoneHomeNumber = EepPhoneHomeNumber
        ,drvAddressLine1    = EepAddressLine1
        ,drvAddressLine2    = EepAddressLine2
        ,drvAddressCity     = EepAddressCity
        ,drvAddressState    = EepAddressState
        ,drvAddressZipCode  = EepAddressZipCode
        ,drvGender          = EepGender
        ,drvHireDate        = EecDateOfLastHire
        ,drvInitialSort     = '22'
        ,drvSubSort         = eepSSN
        ,drvSubSort2        = ''
        ,drvSubSort3        = ''
    INTO dbo.U_EPAYCOBRA_drvTbl_NPM
    FROM dbo.U_dsi_BDM_EPAYCOBRA WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = BdmEEID
       AND EecCoID = BdmCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = BdmEEID
    WHERE BdmRunID = 'NPM';

    ------------------
    -- QB DETAIL RECORD
    ------------------
    IF OBJECT_ID('U_EPAYCOBRA_drvTbl_QB') IS NOT NULL
        DROP TABLE dbo.U_EPAYCOBRA_drvTbl_QB;
    SELECT DISTINCT
         drvEEID           = BdmEEID
        ,drvCoID           = BdmCoID
        ,drvDepRecID       = ISNULL(BdmDepRecID,'')
        ,drvClientName     = CONVERT(varchar(100),'Advanced ICU Care')
        ,drvClientDivName  = CONVERT(varchar(50),'Advanced ICU Care')
        ,drvNameFirst      = CASE WHEN BdmRecType = 'EMP' THEN EepNameFirst
                                  ELSE ConNameFirst
                             END
        ,drvNameMiddle     = CASE WHEN BdmRecType = 'EMP' THEN LEFT(EepNameMiddle,1)
                                  ELSE LEFT(ConNameMiddle,1)
                             END
        ,drvNameLast       = CASE WHEN BdmRecType = 'EMP' THEN EepNameLast
                                  ELSE ConNameLast
                             END
        ,drvSSN            = CASE WHEN BdmRecType = 'EMP' THEN eepSSN
                                  ELSE ISNULL(ConSSN,'')
                             END
        ,drvEmpNo          = EecEmpNo
        ,drvAddressLine1   = CASE WHEN BdmRecType = 'EMP' THEN EepAddressLine1
                                  WHEN ConAddressLine1 IS NULL THEN EepAddressLine1
                                  ELSE ConAddressLine1
                             END
        ,drvAddressLine2   = CASE WHEN BdmRecType = 'EMP' THEN EepAddressLine2
                                  WHEN ConAddressLine1 IS NULL THEN EepAddressLine2
                                  ELSE ConAddressLine2
                             END
        ,drvAddressCity    = CASE WHEN BdmRecType = 'EMP' THEN EepAddressCity
                                  WHEN ConAddressLine1 IS NULL THEN EepAddressCity
                                  ELSE ConAddressCity
                             END
        ,drvAddressState   = CASE WHEN BdmRecType = 'EMP' THEN EepAddressState
                                  WHEN ConAddressLine1 IS NULL THEN EepAddressState
                                  ELSE ConAddressState
                             END
        ,drvAddressZipCode = CASE WHEN BdmRecType = 'EMP' THEN EepAddressZipCode
                                  WHEN ConAddressLine1 IS NULL THEN EepAddressZipCode
                                  ELSE ConAddressZipCode
                             END
        ,drvGender         = CASE WHEN BdmRecType = 'EMP' THEN EepGender
                                  ELSE ConGender
                             END
        ,drvDateOfBirth    = CASE WHEN BdmRecType = 'EMP' THEN EepDateOfBirth
                                  ELSE ConDateOfBirth
                             END
        ,drvInitialSort    = '21'
        ,drvSubSort        = CASE WHEN BdmRecType = 'EMP' THEN eepSSN
                                  ELSE ISNULL(NULLIF(ConSSN,''),eepSSN) + CONVERT(char(8),ConDateOfBirth,112)
                             END
        ,drvSubSort2       = '1'
        ,drvSubSort3       = CASE WHEN BdmRecType = 'EMP' THEN '2'
                                  ELSE CONVERT(char(8),ConDateOfBirth,112) + RTRIM(ConNameLast) + ConNameFirst
                             END
    INTO dbo.U_EPAYCOBRA_drvTbl_QB
    FROM dbo.U_dsi_BDM_EPAYCOBRA WITH (NOLOCK)
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
    IF OBJECT_ID('U_EPAYCOBRA_drvTbl_QBEVENT') IS NOT NULL
        DROP TABLE dbo.U_EPAYCOBRA_drvTbl_QBEVENT;
    SELECT DISTINCT
         drvEEID           = drvEEID
        ,drvCoID           = drvCoID
        ,drvDepRecID       = drvDepRecID
        ,drvEventType      = CASE WHEN EecTermReason = '202' THEN 'RETIREMENT'
                                  WHEN EecTermReason = '203' THEN 'DEATH'
                                  WHEN BdmCobraReason IN ('201','LEVNT3') THEN 'INELIGIBLEDEPENDENT'
                                  WHEN BdmCobraReason IN ('204','LEVNT4') THEN 'DIVORCELEGALSEPARATION'
                                  WHEN BdmCobraReason = '210' THEN 'DEATH'
                                  WHEN BdmCobraReason IN ('202','CHGRP') THEN 'LOSSOFELIGIBILITY'
                                  WHEN BdmCobraReason = '203' THEN 'REDUCTIONINHOURS-STATUSCHANGE'
                                  WHEN BdmCobraReason = '205' THEN 'MEDICARE'
                                  WHEN BdmCobraReason = '206' THEN 'REDUCTIONINHOURSENDOFLEAVE'
                                  WHEN BdmCobraReason = '207' THEN 'LOSSOFELIGIBILITY'
                                  WHEN BdmCobraReason = '208' THEN 'RETIREMENT'
                                  WHEN BdmCobraReason = '209' THEN 'TERMINATION'
                                  ELSE 'TERMINATION'
                             END
        ,drvEventDate      = BdmDateOfCOBRAEvent
        ,drvEnrollmentDate = BdmBenStartDate
        ,drvSSN            = eepSSN
        ,drvName           = CASE WHEN BdmRecType = 'DEP' THEN RTRIM(EepNameFirst) + ' ' + EepNameLast
                                  ELSE ''
                             END
        ,drvInitialSort    = '21'
        ,drvSubSort        = drvSubSort
        ,drvSubSort2       = '1'
        ,drvSubSort3       = drvSubSort3
    INTO dbo.U_EPAYCOBRA_drvTbl_QBEVENT
    FROM dbo.U_EPAYCOBRA_drvTbl_QB WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = drvEEID
       AND EecCoID = drvCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = drvEEID
    JOIN (SELECT
             BdmEEID
            ,BdmCoID
            ,BdmDepRecID
            ,BdmRecType
            ,BdmCobraReason = MAX(BdmCobraReason)
            ,BdmBenStartDate = MIN(BdmBenStartDate)
            ,BdmDateOfCOBRAEvent = MAX(BdmDateOfCOBRAEvent)
            ,BdmUSGDate1 = MAX(BdmUSGDate1)
          FROM dbo.U_dsi_BDM_EPAYCOBRA WITH (NOLOCK)
          WHERE BdmRunID = 'QB'
            AND BdmIsPQB = 'Y'
          GROUP BY BdmEEID, BdmCoID, BdmDepRecID, BdmRecType) BDM
        ON BdmEEID = drvEEID
       AND BdmCoID = drvCoID
       AND ISNULL(BdmDepRecID,'') = drvDepRecID;

    ------------------
    -- QBPLANINITIAL DETAIL RECORD
    ------------------
    IF OBJECT_ID('U_EPAYCOBRA_drvTbl_QBPLAN') IS NOT NULL
        DROP TABLE dbo.U_EPAYCOBRA_drvTbl_QBPLAN;
    SELECT DISTINCT
         drvEEID          = drvEEID
        ,drvCoID          = drvCoID
        ,drvDepRecID      = drvDepRecID
        ,drvDedCode       = BdmDedCode
        ,drvPlanName      = CONVERT(varchar(50), (CASE WHEN BdmDedCode = 'DEN' THEN 'Delta Dental PPO'
                                WHEN BdmDedCode = 'VIS' THEN 'EyeMed Insight Network Vision'
                                WHEN BdmDedCode IN ('FSAS', 'FSAH', 'FSADC', 'FSA') THEN 'Flexible Savings Account'
                                WHEN BdmDedCode = 'MED12' THEN 'United Healthcare QHDHP/HSA Medical'
                                WHEN BdmDedCode = 'MED13' THEN 'United Healthcare UHC PPO Low Medical'
                                WHEN BdmDedCode = 'MED11' THEN 'United Healthcare UHC PPO Medical w/HRA'
                                WHEN BdmDedCode = 'MED10' THEN 'United Healthcare UHC PPO STL Medical w/HRA'
                                WHEN BdmDedCode = 'MED4' THEN 'BCBS of HI MHSA MED4'
                            END))

        ,drvCoverageLevel = CASE WHEN BdmDedType = 'FSA' THEN 'EE'
                                 WHEN BdmRecType = 'EMP' THEN
                                      CASE WHEN BdmBenOption IN ('EE') THEN 'EE Only'
                                           WHEN BdmBenOption IN ('EEC, EEDPF') THEN 'EE+CHILDREN'
                                           WHEN BdmBenOption IN ('EES,EEDP, EE1') THEN 'EE+SPOUSE'
                                           WHEN BdmBenOption IN ('@EDPBenOpts') THEN 'EE+DOMESTICPARTNER'
                                           WHEN BdmBenOption IN ('EEF') THEN 'EE+FAMILY'
                                      END
                                 WHEN BdmRelationship IN ('SPS','DP') THEN
                                      CASE WHEN ISNULL(BdmNumChildren,0) = 1 THEN 'EE+1'
                                           WHEN ISNULL(BdmNumChildren,0) > 1 THEN 'EE+FAMILY'
                                           ELSE 'EE'
                                      END
                                 ELSE 'EE'
                            END
        ,drvInitialSort   = '21'
        ,drvSubSort       = drvSubSort
        ,drvSubSort2      = '1' + BdmDedCode
        ,drvSubSort3      = drvSubSort3
    INTO dbo.U_EPAYCOBRA_drvTbl_QBPLAN
    FROM dbo.U_EPAYCOBRA_drvTbl_QBEVENT WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EPAYCOBRA WITH (NOLOCK)
        ON BdmEEID = drvEEID
       AND BdmCoID = drvCoID
       AND ISNULL(BdmDepRecID,'') = drvDepRecID
    WHERE BdmRunID = 'QB'
      AND BdmIsPQB = 'Y';

    ------------------
    -- QBDEPENDENT DETAIL RECORD
    ------------------
    IF OBJECT_ID('U_EPAYCOBRA_drvTbl_QBDEP') IS NOT NULL
        DROP TABLE dbo.U_EPAYCOBRA_drvTbl_QBDEP;
    SELECT DISTINCT
         drvEEID           = BdmEEID
        ,drvCoID           = BdmCoID
        ,drvDepRecID       = BdmDepRecID
        ,drvSSN            = ISNULL(ConSSN,'')
        ,drvRelationship   = CASE WHEN BdmRelationship IN ('SPS') THEN 'SPOUSE'
                                  WHEN BdmRelationship IN ('DP') THEN 'DOMESTICPARTNER'
                                  ELSE 'CHILD'
                             END
        ,drvNameFirst      = ConNameFirst
        ,drvNameMiddle     = LEFT(ConNameMiddle,1)
        ,drvNameLast       = ConNameLast
        ,drvIsAddressSame  = CASE WHEN ConAddressIsDifferent = 'N' OR ConAddressLine1 IS NULL THEN 'TRUE'
                                  ELSE 'FALSE'
                             END
        ,drvAddressLine1   = ConAddressLine1
        ,drvAddressLine2   = ConAddressLine2
        ,drvAddressCity    = ConAddressCity
        ,drvAddressState   = ConAddressState
        ,drvAddressZipCode = ConAddressZipCode
        ,drvGender         = ConGender
        ,drvDateOfBirth    = ConDateOfBirth
        ,drvISQMCO         = 'True'
        ,drvInitialSort    = '21'
        ,drvSubSort        = drvSubSort
        ,drvSubSort2       = '2' + CASE WHEN BdmRelationship IN ('SPS','DP') THEN 'A'
                                        ELSE 'B' + ISNULL(ConSSN,ConNameFirst)
                                   END + CONVERT(char(8),ISNULL(ConDateOfBirth,''),112) + ConSystemID
        ,drvSubSort3       = drvSubSort3
    INTO dbo.U_EPAYCOBRA_drvTbl_QBDEP
    FROM dbo.U_EPAYCOBRA_drvTbl_QB WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EPAYCOBRA WITH (NOLOCK)
        ON BdmEEID = drvEEID
       AND BdmCoID = drvCoID
    JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = BdmEEID
       AND ConSystemID = BdmDepRecID
    WHERE BdmRunID = 'QB'
      AND BdmIsPQB = 'N';

    ------------------
    -- QBDEPENDENTPLANINITIAL DETAIL RECORD
    ------------------
    IF OBJECT_ID('U_EPAYCOBRA_drvTbl_QBDEPPLAN') IS NOT NULL
        DROP TABLE dbo.U_EPAYCOBRA_drvTbl_QBDEPPLAN;
    SELECT DISTINCT
         drvEEID        = BdmEEID
        ,drvCoID        = BdmCoID
        ,drvDepRecID    = BdmDepRecID
        ,drvDedCode     = BdmDedCode
        ,drvPlanName    = drvPlanName
        ,drvInitialSort = '21'
        ,drvSubSort     = drvSubSort
        ,drvSubSort2    = '2' + CASE WHEN BdmRelationship IN ('SPS','DP') THEN 'A'
                                     ELSE 'B' + RTRIM(ISNULL(ConSSN,ConNameFirst))
                                END + CONVERT(char(8),ISNULL(ConDateOfBirth,''),112) + ConSystemID + BdmDedCode
        ,drvSubSort3    = drvSubSort3
    INTO dbo.U_EPAYCOBRA_drvTbl_QBDEPPLAN
    FROM dbo.U_EPAYCOBRA_drvTbl_QBPLAN WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EPAYCOBRA WITH (NOLOCK)
        ON BdmEEID = drvEEID
       AND BdmCoID = drvCoID
       AND BdmDedCode = drvDedCode
    JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = BdmEEID
       AND ConSystemID = BdmDepRecID
    WHERE BdmRunID = 'QB'
      AND BdmIsPQB = 'N';

    ------------------
    -- QBPLANMEMBERSPECIFICRATEINITIAL DETAIL RECORD
    ------------------
    IF OBJECT_ID('U_EPAYCOBRA_drvTbl_QBMSRI') IS NOT NULL
        DROP TABLE dbo.U_EPAYCOBRA_drvTbl_QBMSRI;
    SELECT DISTINCT
         drvEEID        = drvEEID
        ,drvCoID        = drvCoID
        ,drvDepRecID    = drvDepRecID
        ,drvPlanName    = drvPlanName
        ,drvRate        = CASE WHEN EecPayPeriod = 'M' THEN BdmEEAmt
                               WHEN EecPayPeriod = 'S' THEN BdmEEAmt * 2
                               WHEN EecPayPeriod = 'B' THEN BdmEEAmt * 26/12
                               WHEN EecPayPeriod = 'W' THEN BdmEEAmt * 52/12
                          END
        ,drvInitialSort = '21'
        ,drvSubSort     = drvSubSort
        ,drvSubSort2    = '3'
        ,drvSubSort3    = drvSubSort3
    INTO dbo.U_EPAYCOBRA_drvTbl_QBMSRI
    FROM dbo.U_EPAYCOBRA_drvTbl_QBPLAN WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EPAYCOBRA WITH (NOLOCK)
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


    --==========================================
    -- Set filename
    --==========================================
    DECLARE @YYYYMMDD char(8);
    SET @YYYYMMDD = CONVERT(char(8),GETDATE(),112);

    SET @YYYYMMDD = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' OR LEFT(@ExportCode, 4) = 'TEST' THEN '_TEST_' + @YYYYMMDD
                         ELSE @YYYYMMDD
                    END;

    UPDATE dbo.U_dsi_Parameters
    SET ExportFile = @YYYYMMDD + '_Paylocity COBRA Export_COMBINED_ADV1020.txt'
    WHERE FormatCode = @FormatCode;
END;
/*
--Alter the View
ALTER VIEW dbo.dsi_vwEPAYCOBRA_Export AS
    SELECT TOP 2000000 Data
    FROM dbo.U_EPAYCOBRA_File WITH (NOLOCK)
    ORDER BY InitialSort, SubSort, SubSort2, SubSort3, RecordSet;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EPAYCOBRA%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
SET expLastStartPerControl = '201601251'
   ,expStartPerControl     = '201601251'
   ,expLastEndPerControl   = '201602039'
   ,expEndPerControl       = '201602039'
WHERE expFormatCode = 'EPAYCOBRA'
  AND expExportCode LIKE 'TEST%';
*/
SET NOCOUNT OFF;
