--Populate iascDefF for EFLORCOBQE
--For your reference, the adhSystemID is EFLORCOBQEZ0
--Loaded iascDefF Successfully

IF OBJECT_ID('dsi_sp_BuildDriverTables_EFLORCOBQE') IS NOT NULL
    DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EFLORCOBQE];
GO

CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EFLORCOBQE]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Community Housing

Created By: Andy Pineda
Business Analyst: Lea King
Create Date: 02/09/2022
Service Request Number: TekP-2021-11-10-0002

Purpose: Flores COBRA Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EFLORCOBQE';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EFLORCOBQE';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EFLORCOBQE';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EFLORCOBQE';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EFLORCOBQE' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFLORCOBQE', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFLORCOBQE', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFLORCOBQE', 'SCH_EFLORC';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EFLORCOBQE';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EFLORCOBQE', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@EndPerControl     VARCHAR(9);

    -- Set FormatCode
    SELECT @FormatCode = 'EFLORCOBQE';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EFLORCOBQE_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EFLORCOBQE_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    -- DECLARE @DedList VARCHAR(MAX)
    -- SET @DedList = 'MED1, MED2, MED, DEN, VIS';

    -- IF OBJECT_ID('U_EFLORCOBQE_DedList','U') IS NOT NULL
    --     DROP TABLE dbo.U_EFLORCOBQE_DedList;
    -- SELECT DISTINCT
    --      DedCode = DedDedCode
    --     ,DedType = DedDedType
    -- INTO dbo.U_EFLORCOBQE_DedList
    -- FROM dbo.fn_ListToTable(@DedList)
    -- JOIN dbo.DedCode WITH (NOLOCK)
    --     ON DedDedCode = Item;


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
   -- INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'AddToPreviousRun','Y');
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
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL, DPC, STC');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');

    -- Run BDM for QB
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Working Tables
    --==========================================

    -- Create count dependent table
   -- IF OBJECT_ID('U_EFLORCOBQE_coverage','U') IS NOT NULL 
   -- DROP TABLE dbo.U_EFLORCOBQE_coverage;

   -- SELECT e.bdmeeid as bdmeeid_count, e.bdmcoid as bdmcoid_count, s.bdmdateofbirth, count(distinct(s.bdmdateofbirth)) as spouse_count, '0' AS child_count--, count(distinct(c.bdmdateofbirth)) as child_count
   -- into dbo.U_EFLORCOBQE_coverage 
   -- FROM dbo.U_dsi_BDM_EFLORCOBQE e WITH(NOLOCK) 
   -- left JOIN dbo.U_dsi_BDM_EFLORCOBQE s WITH(NOLOCK) ON s.bdmeeid = e.bdmeeid  and s.bdmrelationship in ('sps', 'dp', 'dpn')
   -- --left join dbo.U_dsi_BDM_EFLORCOBQE c with(nolock) on c.bdmeeid = e.bdmeeid and c.bdmrelationship in ('chl', 'stc', 'dpc', 'ddp', 'grc')

   -- group by e.bdmeeid, e.bdmcoid, s.bdmdateofbirth

   -- UNION

   -- SELECT e.bdmeeid as bdmeeid_count, e.bdmcoid as bdmcoid_count, c.bdmdateofbirth, 0 as spouse_count /*count(distinct(s.bdmdateofbirth)) as spouse_count,*/ ,  count(distinct(c.bdmdateofbirth)) as child_count
   ---- into dbo.U_EFLORCOBQE_coverage 
   -- FROM dbo.U_dsi_BDM_EFLORCOBQE e WITH(NOLOCK) 
   -- --left JOIN dbo.U_dsi_BDM_EFLORCOBQE s WITH(NOLOCK) ON s.bdmeeid = e.bdmeeid  and s.bdmrelationship in ('sps', 'dp', 'dpn')
   -- left join dbo.U_dsi_BDM_EFLORCOBQE c with(nolock) on c.bdmeeid = e.bdmeeid and c.bdmrelationship in ('chl', 'stc', 'dpc', 'ddp', 'grc')

   -- group by e.bdmeeid, e.bdmcoid, c.bdmdateofbirth
    
   --order by e.bdmeeid, c.bdmdateofbirth

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EFLORCOBQE_drvInsured
    ---------------------------------
    IF OBJECT_ID('U_EFLORCOBQE_drvInsured','U') IS NOT NULL
        DROP TABLE dbo.U_EFLORCOBQE_drvInsured;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drv10InsuredIdent = '1'
        ,drv10EmpIdNum = EepSSN
        ,drv10LName = CASE WHEN BdmChangeReason IN ('204', 'LEVNT4', '201', 'LEVNT3', '210') OR EecTermReason = '203' then ConNameLast ELSE EepNameLast END
        ,drv10FName = CASE WHEN BdmChangeReason IN ('204', 'LEVNT4', '201', 'LEVNT3', '210') OR EecTermReason = '203' then ConNameFirst ELSE EepNameFirst END
        ,drv10Add1 = EepAddressLine1
        ,drv10Add2 = EepAddressLine2
        ,drv10City = EepAddressCity
        ,drv10State = EepAddressState
        ,drv10Zip = EepAddressZipCode
        ,drv10Phone = EepPhoneHomeNumber
        ,drv10Email = EepAddressEMail
        ,drv10DOB = CASE WHEN BdmChangeReason IN ('204', 'LEVNT4', '201', 'LEVNT3', '210') OR EecTermReason = '203' then ConDateOfBirth ELSE EepDateOfBirth END
        ,drv10StateOfEmploy = ''
        ,drv10TypeOfEvent = CASE WHEN BdmChangeReason IN ('204', 'LEVNT4') THEN '4'
                                WHEN EecEmplStatus = 'T' AND EecTermReason = '203' THEN '3'
                                WHEN BdmChangeReason = '205' THEN '6'
                                WHEN BdmChangeReason IN ('201', 'LEVNT3') THEN '5'
                                WHEN EecEmplStatus = 'T' AND EecTermType = 'V' THEN '1'
                                WHEN BdmChangeReason IN ('202', '203') THEN '2'
                                WHEN EecEmplStatus = 'T' AND EecTermReason <> '203' AND EecTermType = 'I' THEN '10' END
        ,drv10DtOfEvent = ISNULL(CONVERT(VARCHAR, BdmBenStopDate, 101), '')
        ,drv10DtPremPaidThrough = ''
        ,drv10Loc = ''
        ,drv10Gender = EepGender
        ,drvInitialSort = 1 + LTRIM(RTRIM(EepSSN))
        ,drvSubSort = '1'
    INTO dbo.U_EFLORCOBQE_drvInsured
    FROM dbo.U_EFLORCOBQE_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
	JOIN dbo.EmpComp WITH(NOLOCK)
		ON EecEEID = xEEID
		AND EecCOID = xCOID
    JOIN dbo.U_dsi_BDM_EFLORCOBQE WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
	LEFT JOIN dbo.Contacts WITH(NOLOCK)
		ON ConEEID = xEEID
		AND ConSystemId = BdmDepRecId
    WHERE BdmRunID = 'QB'
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EFLORCOBQE_drvDependent
    ---------------------------------
    IF OBJECT_ID('U_EFLORCOBQE_drvDependent','U') IS NOT NULL
        DROP TABLE dbo.U_EFLORCOBQE_drvDependent;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drv20DepIdent = '2'
        ,drv20EmpIdNumOfIns = EepSSN
        ,drv20DepNum = CASE WHEN BdmRecType = 'DEP' THEN ROW_NUMBER() OVER(PARTITION BY BdmEEID ORDER BY BdmRelationship, BdmDateOfBirth) END
        ,drv20DepFName = ConNameFirst
        ,drv20DepLName = ConNameLast
        ,drv20RelToIns = CASE WHEN BdmRelationship IN ('SPS', 'DP') THEN 'S'
                                WHEN BdmRelationship IN ('CHL', 'DCH', 'DPC', 'STC') THEN 'C' END 
        ,drv20DOB = ConDateOfBirth
        ,drv20Gender = ConGender
        ,drvInitialSort = 1 + LTRIM(RTRIM(EepSSN))
        ,drvSubSort = '2'
    INTO dbo.U_EFLORCOBQE_drvDependent
    FROM dbo.U_EFLORCOBQE_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EFLORCOBQE WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
	JOIN dbo.Contacts WITH(NOLOCK)
		ON ConEEID = xEEID
		AND ConSystemId = BdmDepRecId
    WHERE BdmRunID = 'QB'
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EFLORCOBQE_drvElection
    ---------------------------------
    IF OBJECT_ID('U_EFLORCOBQE_drvElection','U') IS NOT NULL
        DROP TABLE dbo.U_EFLORCOBQE_drvElection;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drv30ElectIdent = '3'
        ,drv30EmpIdNumOfIns = EepSSN
        ,drv30DepNum = CASE WHEN BdmRecType = 'DEP' THEN ROW_NUMBER() OVER(PARTITION BY BdmEEID ORDER BY BdmRelationship, BdmDateOfBirth) END
        ,drv30PlanCodeEnrolledIn = CASE WHEN BdmDedCode = 'MEDLO' THEN
                                        CASE WHEN BdmBenOption = 'EE' THEN '4010'
                                                WHEN BdmBenOption IN ('EES', 'EEDP', 'EEDOP') THEN '4011'
                                                WHEN BdmBenOption IN ('EEC', 'EECHD', 'EECN', 'EECHIL') THEN '4012'
                                                WHEN BdmBenOption IN ('EEF', 'EEDPF') THEN '4013'
                                            END
                                        WHEN BdmDedCode = 'HDHP' THEN
                                        CASE WHEN BdmBenOption = 'EE' THEN '7040'
                                                WHEN BdmBenOption IN ('EES', 'EEDP', 'EEDOP') THEN '7041'
                                                WHEN BdmBenOption IN ('EEC', 'EECHD', 'EECN', 'EECHIL') THEN '7042'
                                                WHEN BdmBenOption IN ('EEF', 'EEDPF') THEN '7043'
                                            END
                                        WHEN BdmDedCode = 'MEDHI' THEN
                                        CASE WHEN BdmBenOption = 'EE' THEN '9060'
                                                WHEN BdmBenOption IN ('EES', 'EEDP', 'EEDOP') THEN '9061'
                                                WHEN BdmBenOption IN ('EEC', 'EECHD', 'EECN', 'EECHIL') THEN '9062'
                                                WHEN BdmBenOption IN ('EEF', 'EEDPF') THEN '9063'
                                            END
                                        WHEN BdmDedCode = 'DENLO' THEN
                                        CASE WHEN BdmBenOption = 'EE' THEN '5020'
                                                WHEN BdmBenOption IN ('EES', 'EEDP', 'EEDOP') THEN '5021'
                                                WHEN BdmBenOption IN ('EEC', 'EECHD', 'EECN', 'EECHIL') THEN '5022'
                                                WHEN BdmBenOption IN ('EEF', 'EEDPF') THEN '5023'
                                            END
                                        WHEN BdmDedCode = 'DENHI' THEN
                                        CASE WHEN BdmBenOption = 'EE' THEN '6030'
                                                WHEN BdmBenOption IN ('EES', 'EEDP', 'EEDOP') THEN '6031'
                                                WHEN BdmBenOption IN ('EEC', 'EECHD', 'EECN', 'EECHIL') THEN '6032'
                                                WHEN BdmBenOption IN ('EEF', 'EEDPF') THEN '6033'
                                            END
                                        WHEN BdmDedCode = 'VISION' THEN
                                        CASE WHEN BdmBenOption = 'EE' THEN '8050'
                                                WHEN BdmBenOption IN ('EES', 'EEDP', 'EEDOP') THEN '8051'
                                                WHEN BdmBenOption IN ('EEC', 'EECHD', 'EECN', 'EECHIL') THEN '8052'
                                                WHEN BdmBenOption IN ('EEF', 'EEDPF') THEN '8053'
                                            END
                                    END
        ,drv30MonthlyPrem = ''
        ,drvInitialSort = 1 + LTRIM(RTRIM(EepSSN))
        ,drvSubSort = '3'
    INTO dbo.U_EFLORCOBQE_drvElection
    FROM dbo.U_EFLORCOBQE_EEList WITH (NOLOCK)
	JOIN dbo.EmpPers WITH(NOLOCK)
		ON xEEID = EepEEID
    JOIN dbo.U_dsi_BDM_EFLORCOBQE WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    WHERE BdmRunID = 'QB'
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'OE_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEFLORCOBQE_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EFLORCOBQE_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EFLORCOBQE%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202202021'
       ,expStartPerControl     = '202202021'
       ,expLastEndPerControl   = '202202099'
       ,expEndPerControl       = '202202099'
WHERE expFormatCode = 'EFLORCOBQE';

**********************************************************************************/
