USE [ULTIPRO_WPDIAHC]
GO
/****** Object:  StoredProcedure [dbo].[dsi_sp_BuildDriverTables_ELINFINEXP]    Script Date: 11/11/2019 4:49:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ELINFINEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Diamond Healthcare

Created By: James Bender
Business Analyst: Lea King
Create Date: 11/08/2019
Service Request Number: SR-2019-00245093

Purpose: Lincoln Financial Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2019     SR-2019-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ELINFINEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ELINFINEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ELINFINEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ELINFINEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ELINFINEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELINFINEXP', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELINFINEXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELINFINEXP', 'OEACTIVE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ELINFINEXP';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ELINFINEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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

	DECLARE @DedBenCodes table (Code varchar(4));
	Insert Into @DedBenCodes VALUES ('DEN1'), ('DEN2'), ('VIS'), ('VLIS'), ('VLIC')

	DECLARE @DepRelCodes table (Code varchar(3));
	INSERT INTO @DepRelCodes VALUES ('DIS'), ('CHL'), ('DPC'), ('STC'), ('SPS'), ('DP')

    -- Set FormatCode
    SELECT @FormatCode = 'ELINFINEXP';

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
    DELETE FROM dbo.U_ELINFINEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ELINFINEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'BLIFE, DEN1, DEN2, LTD, STD, VIS, VLIFC, VLIFE, VLIFS';

    IF OBJECT_ID('U_ELINFINEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ELINFINEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ELINFINEXP_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes', @DedList);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

    -- Non-Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');

    -- Required OE parameters
    IF @ExportCode LIKE '%PASSIVE'
    BEGIN
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'OEType','PASSIVE');
    END;

    IF @ExportCode LIKE '%ACTIVE'
    BEGIN
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'OEType','ACTIVE');
    END;


    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ELINFINEXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ELINFINEXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ELINFINEXP_drvTbl;
    SELECT DISTINCT
         drvEEID = ''
        ,drvCoID = ''
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvEmployeeID = EecEmpNo
        ,drvChangeDate = (select MAX(edhEffDate) from EmpHDed where edhBenStatus = 'A' and edhEEId = xEEID)  -- ???
        ,drvDepChangeDate = bdm_BenStartDate
        ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN eedBenStopDate END -- EecDateOfTermination END ???
        ,drvMbrFirstName = EepNameFirst
        ,drvMbrLastName = EepNameLast
        ,drvMbrMiddleInitial =ISNULL(LEFT(EepNameMiddle,1), '')
        ,drvMbrSSN = eepSSN
        ,drvMbrGender = EepGender
        ,drvMbrDateOfBirth = EepDateOfBirth
        ,drvAppSignDate = (select MIN(edhEffDate) from EmpHDed where edhBenStatus = 'A' and edhEEId = xEEID)  -- ???
        ,drvOccupation = eecJobTitle
        ,drvHourPerWeek = CASE WHEN PgrPayFrequency = 'B' THEN eecScheduledWorkHrs END
        ,drvSalaryAmt = eecAnnSalary
        ,drvSalaryCode = 'B'
        ,drvSalEffDate = '' -- ???
        ,drvMbrAddrOne = eepAddressLine1
        ,drvMbrAddrTwo = eepAddressLine2
        ,drvMbrCity = EepAddressCity
        ,drvMbrState = EepAddressState
        ,drvMbrZipCode = EepAddressZipCode
        ,drvMbrZipPlusFour = ''
        ,drvHomePhone = EepPhoneHomeNumber
        ,drvWorkPhone = ''
        ,drvWorkPhoneExt = ''
        ,drvEmailAddress = ''
        ,drvDateOfBenEligbility = eecDateOfOriginalHire
        ,drvSubsDateOfBen = CASE WHEN eecDateOfOriginalHire != eecDateOfLastHire THEN eecDateOfLastHire ELSE '' END
        ,drvReasonPriorLossBenElig = CASE WHEN EecDateOfOriginalHire != EecDateOfLastHire THEN 'TERMINATION' ELSE '' END
        ,drvPriBeneFirstName = ''
        ,drvPriBeneLastName = ''
        ,drvPriBeneMiddleInit = ''
        ,drvPriBeneRelationship = ''
        ,drvPriBeneAddressOne = ''
        ,drvPriBeneAddressTwo = ''
        ,drvPriBeneCity = ''
        ,drvPriBeneState = ''
        ,drvPriBeneZipCode = ''
        ,drvPriBeneZipPlusFour = ''
        ,drvProBeneSSN = '' -- ??? Typo in name
        ,drvCoBeneFirstName = ''
        ,drvCoBeneLastName = ''
        ,drvCoBeneMiddleInit = ''
        ,drvCoBeneRelationship = ''
        ,drvCoBeneAddressOne = ''
        ,drvCoBeneAddressTwo = ''
        ,drvCoBeneCity = ''
        ,drvCoBeneState = ''
        ,drvCoBeneZipCode = ''
        ,drvCoBeneZipPlusFour = ''
        ,drvCoBeneSSN = eepSSN
        ,drvBeneficiaryComments = ''
        ,drvAccidentPolicyNumber = ''
        ,drvAccidentBillLocACNumber = ''
        ,drvAccidentSortGroup = ''
        ,drvAccidentEffDate = ''
        ,drvAccidentPlanCode = ''
        ,drvAccidentClassCode = ''
        ,drvAccidentTierCode = ''
        ,drvHealthAssesTier = ''
        ,drvHospitalTier = ''
        ,drvAccidentDisabilityAmt = ''
        ,drvAccidentDiTier = ''
        ,drvAccidentDiBenefitPeriod = ''
        ,drvAccidentDiElimPeriod = ''
        ,drvAccidentSicknessDisaAmt = ''
        ,drvAccidentSickTier = ''
        ,drvAccidentSickDiBenePer = ''
        ,drvAccidentSickDiElimPer = ''
        ,drvAccidentTermDate = ''
        ,drvCritIllnessPolicyNum = ''
        ,drvCritIllnessBillLocAC = ''
        ,drvCritIllnessSortGrp = ''
        ,drvCritIllnessEffDate = ''
        ,drvCritIllnessPlanCode = ''
        ,drvCritIllnessClassCode = ''
        ,drvDritIllnessTErmDate = '' -- ??? typo in field name
        ,drvEePrincSumAmtApprove = ''
        ,drvEePrincSumAmtPend = ''
        ,drvSpPrincSumAmtApprove = ''
        ,drvSpPrincSumAmtPend = ''
        ,drvChPrincSumAmtApprove = ''
        ,drvChPrincSumAmtPend = ''
        ,drvEeHeartAmtApprove = ''
        ,drvEeHeartAmtPend = ''
        ,drvSpHeartAmtApprove = ''
        ,drvSpHeartAmtPend = ''
        ,drvChHeartAmtApprove = ''
        ,drvChHeartAmtPend = ''
        ,drvEeCancerAmtApprove = ''
        ,drvEeCancerAmtPend = ''
        ,drvSpCancerAmtApprove = ''
        ,drvSpCancerAmtPend = ''
        ,drvChCancerAmtApprove = ''
        ,drvChCancerAmtPend = ''
        ,drvEeOrganAmtApprove = ''
        ,drvEeOrganAmtPend = ''
        ,drvSpOrganAmtApprove = ''
        ,drvSpOrganAmtPend = ''
        ,drvChOrganAmtApprove = ''
        ,drvChOrganAmtPend = ''
        ,drvEeQualOfLifeAmtApprove = ''
        ,drvEeQualOfLifeAmtPend = ''
        ,drvSpQualOfLifeAmtApprove = ''
        ,drvSpQualOfLifeAmtPend = ''
        ,drvChQualOfLifeAmtApprove = ''
        ,drvChQualOfLifeAmtPend = ''
        ,drvChildCatAmtApprove = ''
        ,drvChildCatAmtPend = ''
        ,drvEeTreatmentCareYN = ''
        ,drvSpTreatmentCareYN = ''
        ,drvChTreatmentCareYN = ''
        ,drvEeDiYN = ''
        ,drvSpDiYN = ''
        ,drvEeAccidentYN = ''
        ,drvSpAccidentYN = ''
        ,drvChAccidentYN = ''
        ,drvEeOccHivYN = ''
        ,drvLifePolicyNumber = CASE WHEN BdmDedCode = 'BLIFE' THEN  '000010255392-00000' END -- ???
        ,drvLifeBillLocACNumber = CASE WHEN BdmDedCode = 'BLIFE' THEN  '1630544' END
        ,drvLifeSortGroup = ''
        ,drvLifeEffDate = CASE WHEN BdmDedCode = 'BLIFE' THEN  BdmBenStartDate END -- ??? right field?
        ,drvLifePlanCode = CASE WHEN BdmDedCode = 'BLIFE' THEN  '1' END
        ,drvLifeClassCode = CASE WHEN BdmDedCode = 'BLIFE' THEN  '1' END
        ,drvLiCvgs = CASE WHEN BdmDedCode = 'BLIFE' THEN  BdmEEAmt END -- ??? Is this the right Amount field?
        ,drvLiTerminationDate = CASE WHEN BdmStopDate = 'BLIFE' THEN  BdmBenStopDate END -- ??? right field?
        ,drvAdCvgs = CASE WHEN BdmDedCode = 'BLIFE' THEN  BdmEEAmt END -- ??? Is this the right Amount field?
        ,drvAdTerminationDate = CASE WHEN BdmStopDate = 'BLIFE' THEN  BdmBenStopDate END
        ,drvDliCvgs = ''
        ,drvDliTerminationDate = ''
        ,drvDadCvgs = ''
        ,drvDadTerminationDate = ''
        ,drvOliCvgs = ''
        ,drvOliTerminationDate = ''
        ,drvOadCvgs = ''
        ,drvOadTerminationDate = ''
        ,drvOdliCvgs = ''
        ,drvOdliTerminationDate = ''
        ,drvOdadCvgs = ''
        ,drvOdadTerminationDate = ''
        ,drvSliCvgs = ''
        ,drvSliTerminationDate = ''
        ,drvSadCvgs = ''
        ,drvSadTerminationDate = ''
        ,drvCliCvgs = ''
        ,drvCliTerminationDate = ''
        ,drvOsliCvgs = ''
        ,drvOsliTerminationDate = ''
        ,drvOsadCvgs = ''
        ,drvOsadTerminationDate = ''
        ,drvOcliCvgs = ''
        ,drvOcliTerminationDate = ''
        ,drvWiPolicyNumber = CASE WHEN BdmDedCode = 'STD' THEN  '000010255394-00000' END -- ???
        ,drvWiBillLocACNumber = CASE WHEN BdmDedCode = 'STD' THEN  '1630544' END
        ,drvWiSortGroup = ''
        ,drvWiEffDate = CASE WHEN BdmDedCode = 'STD' THEN  BdmBenStartDate END
        ,drvWiPlanCode = CASE WHEN BdmDedCode = 'STD' THEN  1 END
        ,drvWiClassCode = CASE WHEN BdmDedCode = 'STD' THEN  1 END
        ,drvWiCvgs =  CASE WHEN BdmDedCode = 'STD' THEN  BdmEEAmt END -- ??? Is this the right Amount field?
        ,drvWiTerminationDate = CASE WHEN BdmStopDate = 'STD' THEN  BdmBenStopDate END
        ,drvOwiCvgs = ''
        ,drvOwiTerminationDate = ''
        ,drvLtdPolicyNum = CASE WHEN BdmDedCode = 'LTD' THEN  '000010255393-00000' END -- ???
        ,drvLtdBillLocACNum = CASE WHEN BdmDedCode = 'LTD' THEN  '1630544' END
        ,drvLtdSortGroup = ''
        ,drvLtdEffDate = CASE WHEN BdmDedCode = 'LTD' THEN  BdmBenStartDate END
        ,drvLtdPlanCode = CASE WHEN BdmDedCode = 'LTD' THEN  1 END
        ,drvLtdClassCode = CASE WHEN BdmDedCode = 'LTD' THEN  1 END
        ,drvLtdCvgs = CASE WHEN BdmDedCode = 'LTD' THEN  BdmEEAmt END
        ,drvLtdTerminationDate = CASE WHEN BdmStopDate = 'LTD' THEN  BdmBenStopDate END
        ,drvOltdCvgs = ''
        ,drvOltdTerminationDate = ''
        ,drvCiCvgs = ''
        ,drvCiTerminationDate = ''
        ,drvDentPolicyNumber = CASE WHEN BdmDedCode IN ('DEN1', 'DEN2') THEN '00001D039852-00000' END
        ,drvDentBillLocACNBR = CASE WHEN BdmDedCode IN ('DEN1', 'DEN2') THEN '1630544' END
        ,drvDentSortGroup = ''
        ,drvDentEff = CASE WHEN BdmDedCode IN ('DEN1', 'DEN2') THEN BdmBenStartDate END
        ,drvDentPlanCode =	CASE BdmDedCode
								WHEN 'DEN1' THEN '1'
								WHEN 'DEN2' THEN '2'
							END
        ,drvDentClassCode = CASE WHEN BdmDedCode IN ('DEN1', 'DEN2') THEN '1' END
        ,drvDentCoverageCode =	CASE WHEN BdmDedCode IN ('DEN1', 'DEN2') THEN -- ??? This should be coverage tier
									CASE 
										WHEN BdmBenOption in ('EE', 'EEO') THEN 1
										WHEN BdmBenOption in ('EES', 'EEDP') THEN 2
										WHEN BdmBenOption in ('EEC', 'EEF', 'EEDPF') THEN 3
										ELSE 4
									END
								END
        ,drvDentOtherIns = 'U'
        ,drvDentTerminationDate = CASE WHEN BdmDedCode IN ('DEN1', 'DEN2') THEN BdmBenStopDate END
        ,drvDhmoPolicyNumber = ''
        ,drvDhmoBillLocACNumber = ''
        ,drvDhmoSortGroup = ''
        ,drvDhmoEffDate = ''
        ,drvDhmoPlanCode = ''
        ,drvDhmoClassCode = ''
        ,drvDhmoCoverageTier = ''
        ,drvDhmoPcp = ''
        ,drvDhmoTerminationDate = ''
        ,drvLvcPolicyNumber = ''
        ,drvLvcBillLocACNumber = ''
        ,drvLvcSortGroup = ''
        ,drvLvcEffDate = ''
        ,drvLvcPlanCode = ''
        ,drvLvcClassCode = ''
        ,drvLvcCoverageTier = ''
        ,drvLvcOtherIns = ''
        ,drvLvcTerminationDate = ''
        ,drvVlvcPolicyNumber = CASE WHEN BdmDedCode = 'VIS' THEN  '000400255395-00000' END -- ???
        ,drvVlvcBillLocACNumber = CASE WHEN BdmDedCode = 'VIS' THEN  '1630544' END
        ,drvVlvcSortGroup = ''
        ,drvVlvcEffDate = CASE WHEN BdmDedCode = 'VIS' THEN  BdmBenStartDate END
        ,drvVlvcPlanCode = CASE WHEN BdmDedCode = 'VIS' THEN  '1' END
        ,drvVlvcClassCode = CASE WHEN BdmDedCode = 'VIS' THEN  '1' END
        ,drvVlvcCoverageTier =	CASE WHEN BdmDedCode = 'VIS' THEN
									CASE 
										WHEN BdmBenOption in ('EE', 'EEO') THEN '1'
										WHEN BdmBenOption in ('EES', 'EEDP') THEN '2'
										WHEN BdmBenOption in ('EEC', 'EEF', 'EEDPF') THEN '3'
										ELSE '4'
									END
								END
        ,drvVlvcOtherIns = 'U'
        ,drvVlvcTerminationDate = CASE WHEN BdmDedCode = 'VIS' THEN BdmBenStopDate END
        ,drvVdnPolicyNumber = ''
        ,drvVdnCillLocationACNum = ''
        ,drvVdnSortGroup = ''
        ,drvVdnEffDate = ''
        ,drvVdnPlanCode = ''
        ,drvVdnClassCode = ''
        ,drvVdnCoverageTier = ''
        ,drvVdnOtherIns = ''
        ,drvVdnTerminationDate = ''
        ,drvVdhmoPolicyNumber = ''
        ,drvVdhmoBillLocationACNum = ''
        ,drvVdhmoSortGroup = ''
        ,drvVdhmoEffDate = ''
        ,drvVdhmoPlanCode = ''
        ,drvVdhmoClassCode = ''
        ,drvVdhmoCoverageTier = ''
        ,drvVdhmoPcp = ''
        ,drvVdhmoTerminationDate = ''
        ,drvVlifPolicyNumber = CASE WHEN BdmDedCode = 'VLIFE' THEN  '000400255395-00000' END -- ???
        ,drvVlifBillLocationACNum = CASE WHEN BdmDedCode = 'VLIFE' THEN  '1630544' END
        ,drvVlifSortGroup = ''
        ,drvVlifEffDate = CASE WHEN BdmDedCode = 'VLIFE' THEN  BdmBenStartDate END
        ,drvVlifPlanCode = CASE WHEN BdmDedCode = 'VLIFE' THEN  '1' END
        ,drvVlifClassCode = CASE WHEN BdmDedCode = 'VLIFE' THEN  '1' END
        ,drvVlifCvgs = CASE WHEN BdmDedCode = 'VLIFE' THEN  BdmEEAmt END
        ,drvVlifTerminationDate = CASE WHEN BdmDedCode = 'VLIFE' THEN BdmBenStopDate END
        ,drvVadCvgs = CASE WHEN BdmDedCode = 'VLIFE' THEN  BdmEEAmt END -- ??? typo, should be drvVsadCvgs
        ,drvVadTerminationDate = CASE WHEN BdmDedCode = 'VLIFE' THEN BdmBenStopDate END -- ??? typo, should be drvVsadCvgs
        ,drvVsliCvgs = CASE WHEN BdmDedCode = 'VLIFE' THEN  BdmEEAmt END
        ,drvVsliTerminationDate = CASE WHEN BdmDedCode = 'VLIFE' THEN BdmBenStopDate END
        ,drvVsadCvgs = CASE WHEN BdmDedCode = 'VLIFE' THEN  BdmEEAmt END
        ,drvVsadTerminationDate = CASE WHEN BdmDedCode = 'VLIFE' THEN BdmBenStopDate END
        ,drvVcliCvgs = CASE WHEN BdmDedCode = 'VLIFE' THEN  BdmEEAmt END
        ,drvVcliTerminationDate = CASE WHEN BdmDedCode = 'VLIFE' THEN BdmBenStopDate END
        ,drvVwiPolicyNumber = ''
        ,drvVwiBillLocationACNumber = ''
        ,drvVwiSortGroup = ''
        ,drvVwiEffDate = ''
        ,drvVwiPlanCode = ''
        ,drvVwiClassCode = ''
        ,drvVwiBenefitAmt = ''
        ,drvVwiElimPeriod = ''
        ,drvVwiBenefitDuration = ''
        ,drvVwiTerminationDate = ''
        ,drvVltdPolicyNumber = ''
        ,drvVltdBillLocationACNum = ''
        ,drvVltdSortGroup = ''
        ,drvVltdEffDate = ''
        ,drvVltdPlanCode = ''
        ,drvVltdClassCode = ''
        ,drvVltdBenefitAmt = ''
        ,drvVltdElimPeriod = ''
        ,drvVltdBenefitDuration = ''
        ,drvVltdBenefitPct = ''
        ,drvVltdTerminationDate = ''
        ,drvStadPolicyNumber = ''
        ,drvStadBillLocationACNum = ''
        ,drvStadSortGroup = ''
        ,drvStadEffDate = ''
        ,drvStadPlanCode = ''
        ,drvStadClassCode = ''
        ,drvStvadCvgs = ''
        ,drvStvadTerminationDate = ''
        ,drvStvsadCvgs = ''
        ,drvStvsadTerminationDate = ''
        ,drvStvcadCvgs = ''
        ,drvStvcadTerminationDate = ''
        ,drvQualifyingEventCode = ''
        ,drvQualifyingEventEffDate = ''
        ,drvMbrSmoker = EepIsSmoker
		-- Spouse
        ,drvMbrSpouseSmoker = CASE WHEN ConRelationship in ('SPS', 'DP') THEN ConIsSmoker END
        ,drvSpoudDateOfBirth = CASE WHEN ConRelationship in ('SPS', 'DP') THEN ConDateOfBirth END
		-- Dependants		
        ,drvDepFirstName1 = CASE WHEN BemDedCode in (Select Code from @DedBenCodes) THEN (SELECT ConNameFirst from Contacts JOIN EmpPers on ConEEID = eepEEID WHERE ConEEID = xEEID AND ConRelationship in (Select Code from @DepRelCodes) ORDER BY ConSSN OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY) END
        ,drvDepLastName1 = CASE WHEN BemDedCode in (Select Code from @DedBenCodes) THEN (SELECT ConNameLast from Contacts JOIN EmpPers on ConEEID = eepEEID WHERE ConEEID = xEEID AND ConRelationship in (Select Code from @DepRelCodes) ORDER BY ConSSN OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY) END
        ,drvDepMiddleInitial1 = CASE WHEN BemDedCode in (Select Code from @DedBenCodes) THEN (SELECT ISNULL(LEFT(ConNameMiddle, 1), '') from Contacts JOIN EmpPers on ConEEID = eepEEID WHERE ConEEID = xEEID AND ConRelationship in (Select Code from @DepRelCodes) ORDER BY ConSSN OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY) END
        ,drvDepGender1 = CASE WHEN BemDedCode in (Select Code from @DedBenCodes) THEN (SELECT ConGender from Contacts JOIN EmpPers on ConEEID = eepEEID WHERE ConEEID = xEEID AND ConRelationship in (Select Code from @DepRelCodes) ORDER BY ConSSN OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY) END
        ,drvDepDateOfBirth1 = CASE WHEN BemDedCode in (Select Code from @DedBenCodes) THEN (SELECT ConDateOfBirth from Contacts JOIN EmpPers on ConEEID = eepEEID WHERE ConEEID = xEEID AND ConRelationship in (Select Code from @DepRelCodes) ORDER BY ConSSN OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY) END
        ,drvDepRelationshipCode1 = CASE WHEN BemDedCode in (Select Code from @DedBenCodes) THEN (SELECT ConGender from Contacts JOIN EmpPers on ConEEID = eepEEID WHERE ConEEID = xEEID AND ConRelationship in (Select Code from @DepRelCodes) ORDER BY ConSSN OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY) END
        ,drvDepStudentCode1 = CASE WHEN BemDedCode in (Select Code from @DedBenCodes) THEN (SELECT 'N' from Contacts JOIN EmpPers on ConEEID = eepEEID WHERE ConEEID = xEEID AND ConRelationship in (Select Code from @DepRelCodes) ORDER BY ConSSN OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY) END
        ,drvDepDisabledYN1 = CASE WHEN BemDedCode in (Select Code from @DedBenCodes) THEN (SELECT ConIsDisabled from Contacts JOIN EmpPers on ConEEID = eepEEID WHERE ConEEID = xEEID AND ConRelationship in (Select Code from @DepRelCodes) ORDER BY ConSSN OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY) END
        ,drvDepCvgIndicator1 = '' --- ??? Need Maros help w/ spec
        ,drvDedDhmoPcp1 = ''
		-- 2
		,drvDepFirstName2 = CASE WHEN BemDedCode in (Select Code from @DedBenCodes) THEN (SELECT ConNameFirst from Contacts JOIN EmpPers on ConEEID = eepEEID WHERE ConEEID = xEEID AND ConRelationship in (Select Code from @DepRelCodes) ORDER BY ConSSN OFFSET 1 ROWS FETCH NEXT 1 ROWS ONLY) END
        ,drvDepLastName2 = ''
        ,drvDepMiddleInitial2 = ''
        ,drvDepGender2 = ''
        ,drvDepDateOfBirth2 = ''
        ,drvDepRelationshipCode2 = ''
        ,drvDepStudentCode2 = ''
        ,drvDepDisabledYN2 = ''
        ,drvDepCvgIndicator2 = ''
        ,drvDedDhmoPcp2 = ''
		
		,drvDepFirstName3 = CASE WHEN BemDedCode in (Select Code from @DedBenCodes) THEN (SELECT ConNameFirst from Contacts JOIN EmpPers on ConEEID = eepEEID WHERE ConEEID = xEEID AND ConRelationship in (Select Code from @DepRelCodes) ORDER BY ConSSN OFFSET 2 ROWS FETCH NEXT 1 ROWS ONLY) END
        ,drvDepLastName3 = ''
        ,drvDepMiddleInitial3 = ''
        ,drvDepGender3 = ''
        ,drvDepDateOfBirth3 = ''
        ,drvDepRelationshipCode3 = ''
        ,drvDepStudentCode3 = ''
        ,drvDepDisabledYN3 = ''
        ,drvDepCvgIndicator3 = ''
        ,drvDedDhmoPcp3 = ''
		
		,drvDepFirstName4 = CASE WHEN BemDedCode in (Select Code from @DedBenCodes) THEN (SELECT ConNameFirst from Contacts JOIN EmpPers on ConEEID = eepEEID WHERE ConEEID = xEEID AND ConRelationship in (Select Code from @DepRelCodes) ORDER BY ConSSN OFFSET 3 ROWS FETCH NEXT 1 ROWS ONLY) END
        ,drvDepLastName4 = ''
        ,drvDepMiddleInitial4 = ''
        ,drvDepGender4 = ''
        ,drvDepDateOfBirth4 = ''
        ,drvDepRelationshipCode4 = ''
        ,drvDepStudentCode4 = ''
        ,drvDepDisabledYN4 = ''
        ,drvDepCvgIndicator4 = ''
        ,drvDedDhmoPcp4 = ''
		
		,drvDepFirstName5 = CASE WHEN BemDedCode in (Select Code from @DedBenCodes) THEN (SELECT ConNameFirst from Contacts JOIN EmpPers on ConEEID = eepEEID WHERE ConEEID = xEEID AND ConRelationship in (Select Code from @DepRelCodes) ORDER BY ConSSN OFFSET 4 ROWS FETCH NEXT 1 ROWS ONLY) END
        ,drvDepLastName5 = ''
        ,drvDepMiddleInitial5 = ''
        ,drvDepGender5 = ''
        ,drvDepDateOfBirth5 = ''
        ,drvDepRelationshipCode5 = ''
        ,drvDepStudentCode5 = ''
        ,drvDepDisabledYN5 = ''
        ,drvDepCvgIndicator5 = ''
        ,drvDedDhmoPcp5 = ''
		
		,drvDepFirstName6 = CASE WHEN BemDedCode in (Select Code from @DedBenCodes) THEN (SELECT ConNameFirst from Contacts JOIN EmpPers on ConEEID = eepEEID WHERE ConEEID = xEEID AND ConRelationship in (Select Code from @DepRelCodes) ORDER BY ConSSN OFFSET 5 ROWS FETCH NEXT 1 ROWS ONLY) END
        ,drvDepLastName6 = ''
        ,drvDepMiddleInitial6 = ''
        ,drvDepGender6 = ''
        ,drvDepDateOfBirth6 = ''
        ,drvDepRelationshipCode6 = ''
        ,drvDepStudentCode6 = ''
        ,drvDepDisabledYN6 = ''
        ,drvDepCvgIndicator6 = ''
        ,drvDedDhmoPcp6 = ''
		
		,drvDepFirstName7 = CASE WHEN BemDedCode in (Select Code from @DedBenCodes) THEN (SELECT ConNameFirst from Contacts JOIN EmpPers on ConEEID = eepEEID WHERE ConEEID = xEEID AND ConRelationship in (Select Code from @DepRelCodes) ORDER BY ConSSN OFFSET 6 ROWS FETCH NEXT 1 ROWS ONLY) END
        ,drvDepLastName7 = ''
        ,drvDepMiddleInitial7 = ''
        ,drvDepGender7 = ''
        ,drvDepDateOfBirth7 = ''
        ,drvDepRelationshipCode7 = ''
        ,drvDepStudentCode7 = ''
        ,drvDepDisabledYN7 = ''
        ,drvDepCvgIndicator7 = ''
        ,drvDedDhmoPcp7 = ''
		
		,drvDepFirstName8 = CASE WHEN BemDedCode in (Select Code from @DedBenCodes) THEN (SELECT ConNameFirst from Contacts JOIN EmpPers on ConEEID = eepEEID WHERE ConEEID = xEEID AND ConRelationship in (Select Code from @DepRelCodes) ORDER BY ConSSN OFFSET 7 ROWS FETCH NEXT 1 ROWS ONLY) END
        ,drvDepLastName8 = ''
        ,drvDepMiddleInitial8 = ''
        ,drvDepGender8 = ''
        ,drvDepDateOfBirth8 = ''
        ,drvDepRelationshipCode8 = ''
        ,drvDepStudentCode8 = ''
        ,drvDepDisabledYN8 = ''
        ,drvDepCvgIndicator8 = ''
        ,drvDedDhmoPcp8 = ''
		
		,drvDepFirstName9 = CASE WHEN BemDedCode in (Select Code from @DedBenCodes) THEN (SELECT ConNameFirst from Contacts JOIN EmpPers on ConEEID = eepEEID WHERE ConEEID = xEEID AND ConRelationship in (Select Code from @DepRelCodes) ORDER BY ConSSN OFFSET 8 ROWS FETCH NEXT 1 ROWS ONLY) END
        ,drvDepLastName9 = ''
        ,drvDepMiddleInitial9 = ''
        ,drvDepGender9 = ''
        ,drvDepDateOfBirth9 = ''
        ,drvDepRelationshipCode9 = ''
        ,drvDepStudentCode9 = ''
        ,drvDepDisabledYN9 = ''
        ,drvDepCvgIndicator9 = ''
        ,drvDedDhmoPcp9 = ''
		
		,drvDepFirstName10 = CASE WHEN BemDedCode in (Select Code from @DedBenCodes) THEN (SELECT ConNameFirst from Contacts JOIN EmpPers on ConEEID = eepEEID WHERE ConEEID = xEEID AND ConRelationship in (Select Code from @DepRelCodes) ORDER BY ConSSN OFFSET 9 ROWS FETCH NEXT 1 ROWS ONLY) END
        ,drvDepLastName10 = ''
        ,drvDepMiddleInitial10 = ''
        ,drvDepGender10 = ''
        ,drvDepDateOfBirth10 = ''
        ,drvDepRelationshipCode10 = ''
        ,drvDepStudentCode10 = ''
        ,drvDepDisabledYN10 = ''
        ,drvDepCvgIndicator10 = ''
        ,drvDedDhmoPcp10 = ''
		
		,drvDepFirstName11 = CASE WHEN BemDedCode in (Select Code from @DedBenCodes) THEN (SELECT ConNameFirst from Contacts JOIN EmpPers on ConEEID = eepEEID WHERE ConEEID = xEEID AND ConRelationship in (Select Code from @DepRelCodes) ORDER BY ConSSN OFFSET 10 ROWS FETCH NEXT 1 ROWS ONLY) END
        ,drvDepLastName11 = ''
        ,drvDepMiddleInitial11 = ''
        ,drvDepGender11 = ''
        ,drvDepDateOfBirth11 = ''
        ,drvDepRelationshipCode11 = ''
        ,drvDepStudentCode11 = ''
        ,drvDepDisabledYN11 = ''
        ,drvDepCvgIndicator11 = ''
        ,drvDedDhmoPcp11 = ''
		
		,drvDepFirstName12 = CASE WHEN BemDedCode in (Select Code from @DedBenCodes) THEN (SELECT ConNameFirst from Contacts JOIN EmpPers on ConEEID = eepEEID WHERE ConEEID = xEEID AND ConRelationship in (Select Code from @DepRelCodes) ORDER BY ConSSN OFFSET 11 ROWS FETCH NEXT 1 ROWS ONLY) END
        ,drvDepLastName12 = ''
        ,drvDepMiddleInitial12 = ''
        ,drvDepGender12 = ''
        ,drvDepDateOfBirth12 = ''
        ,drvDepRelationshipCode12 = ''
        ,drvDepStudentCode12 = ''
        ,drvDepDisabledYN12 = ''
        ,drvDepCvgIndicator12 = ''
        ,drvDedDhmoPcp12 = ''
		
		,drvDepFirstName13 = CASE WHEN BemDedCode in (Select Code from @DedBenCodes) THEN (SELECT ConNameFirst from Contacts JOIN EmpPers on ConEEID = eepEEID WHERE ConEEID = xEEID AND ConRelationship in (Select Code from @DepRelCodes) ORDER BY ConSSN OFFSET 12 ROWS FETCH NEXT 1 ROWS ONLY) END
        ,drvDepLastName13 = ''
        ,drvDepMiddleInitial13 = ''
        ,drvDepGender13 = ''
        ,drvDepDateOfBirth13 = ''
        ,drvDepRelationshipCode13 = ''
        ,drvDepStudentCode13 = ''
        ,drvDepDisabledYN13 = ''
        ,drvDepCvgIndicator13 = ''
        ,drvDedDhmoPcp13 = ''
		
		,drvDepFirstName14 = CASE WHEN BemDedCode in (Select Code from @DedBenCodes) THEN (SELECT ConNameFirst from Contacts JOIN EmpPers on ConEEID = eepEEID WHERE ConEEID = xEEID AND ConRelationship in (Select Code from @DepRelCodes) ORDER BY ConSSN OFFSET 13 ROWS FETCH NEXT 1 ROWS ONLY) END
        ,drvDepLastName14 = ''
        ,drvDepMiddleInitial14 = ''
        ,drvDepGender14 = ''
        ,drvDepDateOfBirth14 = ''
        ,drvDepRelationshipCode14 = ''
        ,drvDepStudentCode14 = ''
        ,drvDepDisabledYN14 = ''
        ,drvDepCvgIndicator14 = ''
        ,drvDedDhmoPcp14 = ''
		
		,drvDepFirstName15 = CASE WHEN BemDedCode in (Select Code from @DedBenCodes) THEN (SELECT ConNameFirst from Contacts JOIN EmpPers on ConEEID = eepEEID WHERE ConEEID = xEEID AND ConRelationship in (Select Code from @DepRelCodes) ORDER BY ConSSN OFFSET 14 ROWS FETCH NEXT 1 ROWS ONLY) END
        ,drvDepLastName15 = ''
        ,drvDepMiddleInitial15 = ''
        ,drvDepGender15 = ''
        ,drvDepDateOfBirth15 = ''
        ,drvDepRelationshipCode15 = ''
        ,drvDepStudentCode15 = ''
        ,drvDepDisabledYN15 = ''
        ,drvDepCvgIndicator15 = ''
        ,drvDedDhmoPcp15 = ''
		
		,drvDepFirstName16 = CASE WHEN BemDedCode in (Select Code from @DedBenCodes) THEN (SELECT ConNameFirst from Contacts JOIN EmpPers on ConEEID = eepEEID WHERE ConEEID = xEEID AND ConRelationship in (Select Code from @DepRelCodes) ORDER BY ConSSN OFFSET 15 ROWS FETCH NEXT 1 ROWS ONLY) END
        ,drvDepLastName16 = ''
        ,drvDepMiddleInitial16 = ''
        ,drvDepGender16 = ''
        ,drvDepDateOfBirth16 = ''
        ,drvDepRelationshipCode16 = ''
        ,drvDepStudentCode16 = ''
        ,drvDepDisabledYN16 = ''
        ,drvDepCvgIndicator16 = ''
        ,drvDedDhmoPcp16 = ''
		
		,drvDepFirstName17 = CASE WHEN BemDedCode in (Select Code from @DedBenCodes) THEN (SELECT ConNameFirst from Contacts JOIN EmpPers on ConEEID = eepEEID WHERE ConEEID = xEEID AND ConRelationship in (Select Code from @DepRelCodes) ORDER BY ConSSN OFFSET 16 ROWS FETCH NEXT 1 ROWS ONLY) END
        ,drvDepLastName17 = ''
        ,drvDepMiddleInitial17 = ''
        ,drvDepGender17 = ''
        ,drvDepDateOfBirth17 = ''
        ,drvDepRelationshipCode17 = ''
        ,drvDepStudentCode17 = ''
        ,drvDepDisabledYN17 = ''
        ,drvDepCvgIndicator17 = ''
        ,drvDedDhmoPcp17 = ''
		
		,drvDepFirstName18 = CASE WHEN BemDedCode in (Select Code from @DedBenCodes) THEN (SELECT ConNameFirst from Contacts JOIN EmpPers on ConEEID = eepEEID WHERE ConEEID = xEEID AND ConRelationship in (Select Code from @DepRelCodes) ORDER BY ConSSN OFFSET 17 ROWS FETCH NEXT 1 ROWS ONLY) END
        ,drvDepLastName18 = ''
        ,drvDepMiddleInitial18 = ''
        ,drvDepGender18 = ''
        ,drvDepDateOfBirth18 = ''
        ,drvDepRelationshipCode18 = ''
        ,drvDepStudentCode18 = ''
        ,drvDepDisabledYN18 = ''
        ,drvDepCvgIndicator18 = ''
        ,drvDedDhmoPcp18 = ''
		
		,drvDepFirstName19 = CASE WHEN BemDedCode in (Select Code from @DedBenCodes) THEN (SELECT ConNameFirst from Contacts JOIN EmpPers on ConEEID = eepEEID WHERE ConEEID = xEEID AND ConRelationship in (Select Code from @DepRelCodes) ORDER BY ConSSN OFFSET 18 ROWS FETCH NEXT 1 ROWS ONLY) END
        ,drvDepLastName19 = ''
        ,drvDepMiddleInitial19 = ''
        ,drvDepGender19 = ''
        ,drvDepDateOfBirth19 = ''
        ,drvDepRelationshipCode19 = ''
        ,drvDepStudentCode19 = ''
        ,drvDepDisabledYN19 = ''
        ,drvDepCvgIndicator19 = ''
        ,drvDedDhmoPcp19 = ''
		
		,drvDepFirstName20 = CASE WHEN BemDedCode in (Select Code from @DedBenCodes) THEN (SELECT ConNameFirst from Contacts JOIN EmpPers on ConEEID = eepEEID WHERE ConEEID = xEEID AND ConRelationship in (Select Code from @DepRelCodes) ORDER BY ConSSN OFFSET 19 ROWS FETCH NEXT 1 ROWS ONLY) END
        ,drvDepLastName20 = ''
        ,drvDepMiddleInitial20 = ''
        ,drvDepGender20 = ''
        ,drvDepDateOfBirth20 = ''
        ,drvDepRelationshipCode20 = ''
        ,drvDepStudentCode20 = ''
        ,drvDepDisabledYN20 = ''
        ,drvDepCvgIndicator20 = ''
        ,drvDedDhmoPcp20 = ''
		
		,drvDepFirstName21 = CASE WHEN BemDedCode in (Select Code from @DedBenCodes) THEN (SELECT ConNameFirst from Contacts JOIN EmpPers on ConEEID = eepEEID WHERE ConEEID = xEEID AND ConRelationship in (Select Code from @DepRelCodes) ORDER BY ConSSN OFFSET 20 ROWS FETCH NEXT 1 ROWS ONLY) END
        ,drvDepLastName21 = ''
        ,drvDepMiddleInitial21 = ''
        ,drvDepGender21 = ''
        ,drvDepDateOfBirth21 = ''
        ,drvDepRelationshipCode21 = ''
        ,drvDepStudentCode21 = ''
        ,drvDepDisabledYN21 = ''
        ,drvDepCvgIndicator21 = ''
        ,drvDedDhmoPcp21 = ''
		
		,drvDepFirstName22 = CASE WHEN BemDedCode in (Select Code from @DedBenCodes) THEN (SELECT ConNameFirst from Contacts JOIN EmpPers on ConEEID = eepEEID WHERE ConEEID = xEEID AND ConRelationship in (Select Code from @DepRelCodes) ORDER BY ConSSN OFFSET 21 ROWS FETCH NEXT 1 ROWS ONLY) END
        ,drvDepLastName22 = ''
        ,drvDepMiddleInitial22 = ''
        ,drvDepGender22 = ''
        ,drvDepDateOfBirth22 = ''
        ,drvDepRelationshipCode22 = ''
        ,drvDepStudentCode22 = ''
        ,drvDepDisabledYN22 = ''
        ,drvDepCvgIndicator22 = ''
        ,drvDedDhmoPcp22 = ''
		
		,drvDepFirstName23 = CASE WHEN BemDedCode in (Select Code from @DedBenCodes) THEN (SELECT ConNameFirst from Contacts JOIN EmpPers on ConEEID = eepEEID WHERE ConEEID = xEEID AND ConRelationship in (Select Code from @DepRelCodes) ORDER BY ConSSN OFFSET 22 ROWS FETCH NEXT 1 ROWS ONLY) END
        ,drvDepLastName23 = ''
        ,drvDepMiddleInitial23 = ''
        ,drvDepGender23 = ''
        ,drvDepDateOfBirth23 = ''
        ,drvDepRelationshipCode23 = ''
        ,drvDepStudentCode23 = ''
        ,drvDepDisabledYN23 = ''
        ,drvDepCvgIndicator23 = ''
        ,drvDedDhmoPcp23 = ''
		
		,drvDepFirstName24 = CASE WHEN BemDedCode in (Select Code from @DedBenCodes) THEN (SELECT ConNameFirst from Contacts JOIN EmpPers on ConEEID = eepEEID WHERE ConEEID = xEEID AND ConRelationship in (Select Code from @DepRelCodes) ORDER BY ConSSN OFFSET 23 ROWS FETCH NEXT 1 ROWS ONLY) END
        ,drvDepLastName24 = ''
        ,drvDepMiddleInitial24 = ''
        ,drvDepGender24 = ''
        ,drvDepDateOfBirth24 = ''
        ,drvDepRelationshipCode24 = ''
        ,drvDepStudentCode24 = ''
        ,drvDepDisabledYN24 = ''
        ,drvDepCvgIndicator24 = ''
        ,drvDedDhmoPcp24 = ''
		
		,drvDepFirstName25 = CASE WHEN BemDedCode in (Select Code from @DedBenCodes) THEN (SELECT ConNameFirst from Contacts JOIN EmpPers on ConEEID = eepEEID WHERE ConEEID = xEEID AND ConRelationship in (Select Code from @DepRelCodes) ORDER BY ConSSN OFFSET 24 ROWS FETCH NEXT 1 ROWS ONLY) END
        ,drvDepLastName25 = ''
        ,drvDepMiddleInitial25 = ''
        ,drvDepGender25 = ''
        ,drvDepDateOfBirth25 = ''
        ,drvDepRelationshipCode25 = ''
        ,drvDepStudentCode25 = ''
        ,drvDepDisabledYN25 = ''
        ,drvDepCvgIndicator25 = ''
        ,drvDedDhmoPcp25 = ''
		
		,drvDepFirstName26 = CASE WHEN BemDedCode in (Select Code from @DedBenCodes) THEN (SELECT ConNameFirst from Contacts JOIN EmpPers on ConEEID = eepEEID WHERE ConEEID = xEEID AND ConRelationship in (Select Code from @DepRelCodes) ORDER BY ConSSN OFFSET 25 ROWS FETCH NEXT 1 ROWS ONLY) END
        ,drvDepLastName26 = ''
        ,drvDepMiddleInitial26 = ''
        ,drvDepGender26 = ''
        ,drvDepDateOfBirth26 = ''
        ,drvDepRelationshipCode26 = ''
        ,drvDepStudentCode26 = ''
        ,drvDepDisabledYN26 = ''
        ,drvDepCvgIndicator26 = ''
        ,drvDedDhmoPcp26 = ''
		
		,drvDepFirstName27 = CASE WHEN BemDedCode in (Select Code from @DedBenCodes) THEN (SELECT ConNameFirst from Contacts JOIN EmpPers on ConEEID = eepEEID WHERE ConEEID = xEEID AND ConRelationship in (Select Code from @DepRelCodes) ORDER BY ConSSN OFFSET 26 ROWS FETCH NEXT 1 ROWS ONLY) END
        ,drvDepLastName27 = ''
        ,drvDepMiddleInitial27 = ''
        ,drvDepGender27 = ''
        ,drvDepDateOfBirth27 = ''
        ,drvDepRelationshipCode27 = ''
        ,drvDepStudentCode27 = ''
        ,drvDepDisabledYN27 = ''
        ,drvDepCvgIndicator27 = ''
        ,drvDedDhmoPcp27 = ''
		
		,drvDepFirstName28 = CASE WHEN BemDedCode in (Select Code from @DedBenCodes) THEN (SELECT ConNameFirst from Contacts JOIN EmpPers on ConEEID = eepEEID WHERE ConEEID = xEEID AND ConRelationship in (Select Code from @DepRelCodes) ORDER BY ConSSN OFFSET 27 ROWS FETCH NEXT 1 ROWS ONLY) END
        ,drvDepLastName28 = ''
        ,drvDepMiddleInitial28 = ''
        ,drvDepGender28 = ''
        ,drvDepDateOfBirth28 = ''
        ,drvDepRelationshipCode28 = ''
        ,drvDepStudentCode28 = ''
        ,drvDepDisabledYN28 = ''
        ,drvDepCvgIndicator28 = ''
        ,drvDedDhmoPcp28 = ''
		
		,drvDepFirstName29 = CASE WHEN BemDedCode in (Select Code from @DedBenCodes) THEN (SELECT ConNameFirst from Contacts JOIN EmpPers on ConEEID = eepEEID WHERE ConEEID = xEEID AND ConRelationship in (Select Code from @DepRelCodes) ORDER BY ConSSN OFFSET 28 ROWS FETCH NEXT 1 ROWS ONLY) END
        ,drvDepLastName29 = ''
        ,drvDepMiddleInitial29 = ''
        ,drvDepGender29 = ''
        ,drvDepDateOfBirth29 = ''
        ,drvDepRelationshipCode29 = ''
        ,drvDepStudentCode29 = ''
        ,drvDepDisabledYN29 = ''
        ,drvDepCvgIndicator29 = ''
        ,drvDedDhmoPcp29 = ''
		
		,drvDepFirstName30 = CASE WHEN BemDedCode in (Select Code from @DedBenCodes) THEN (SELECT ConNameFirst from Contacts JOIN EmpPers on ConEEID = eepEEID WHERE ConEEID = xEEID AND ConRelationship in (Select Code from @DepRelCodes) ORDER BY ConSSN OFFSET 29 ROWS FETCH NEXT 1 ROWS ONLY) END
        ,drvDepLastName30 = ''
        ,drvDepMiddleInitial30 = ''
        ,drvDepGender30 = ''
        ,drvDepDateOfBirth30 = ''
        ,drvDepRelationshipCode30 = ''
        ,drvDepStudentCode30 = ''
        ,drvDepDisabledYN30 = ''
        ,drvDepCvgIndicator30 = ''
        ,drvDedDhmoPcp30 = ''
		
		,drvDepFirstName31 = CASE WHEN BemDedCode in (Select Code from @DedBenCodes) THEN (SELECT ConNameFirst from Contacts JOIN EmpPers on ConEEID = eepEEID WHERE ConEEID = xEEID AND ConRelationship in (Select Code from @DepRelCodes) ORDER BY ConSSN OFFSET 30 ROWS FETCH NEXT 1 ROWS ONLY) END
        ,drvDepLastName31 = ''
        ,drvDepMiddleInitial31 = ''
        ,drvDepGender31 = ''
        ,drvDepDateOfBirth31 = ''
        ,drvDepRelationshipCode31 = ''
        ,drvDepStudentCode31 = ''
        ,drvDepDisabledYN31 = ''
        ,drvDepCvgIndicator31 = ''
        ,drvDedDhmoPcp31 = ''
		
		,drvDepFirstName32 = CASE WHEN BemDedCode in (Select Code from @DedBenCodes) THEN (SELECT ConNameFirst from Contacts JOIN EmpPers on ConEEID = eepEEID WHERE ConEEID = xEEID AND ConRelationship in (Select Code from @DepRelCodes) ORDER BY ConSSN OFFSET 31 ROWS FETCH NEXT 1 ROWS ONLY) END
        ,drvDepLastName32 = ''
        ,drvDepMiddleInitial32 = ''
        ,drvDepGender32 = ''
        ,drvDepDateOfBirth32 = ''
        ,drvDepRelationshipCode32 = ''
        ,drvDepStudentCode32 = ''
        ,drvDepDisabledYN32 = ''
        ,drvDepCvgIndicator32 = ''
        ,drvDedDhmoPcp32 = ''
		
		,drvDepFirstName33 = CASE WHEN BemDedCode in (Select Code from @DedBenCodes) THEN (SELECT ConNameFirst from Contacts JOIN EmpPers on ConEEID = eepEEID WHERE ConEEID = xEEID AND ConRelationship in (Select Code from @DepRelCodes) ORDER BY ConSSN OFFSET 32 ROWS FETCH NEXT 1 ROWS ONLY) END
        ,drvDepLastName33 = ''
        ,drvDepMiddleInitial33 = ''
        ,drvDepGender33 = ''
        ,drvDepDateOfBirth33 = ''
        ,drvDepRelationshipCode33 = ''
        ,drvDepStudentCode33 = ''
        ,drvDepDisabledYN33 = ''
        ,drvDepCvgIndicator33 = ''
        ,drvDedDhmoPcp33 = ''
		
		,drvDepFirstName34 = CASE WHEN BemDedCode in (Select Code from @DedBenCodes) THEN (SELECT ConNameFirst from Contacts JOIN EmpPers on ConEEID = eepEEID WHERE ConEEID = xEEID AND ConRelationship in (Select Code from @DepRelCodes) ORDER BY ConSSN OFFSET 33 ROWS FETCH NEXT 1 ROWS ONLY) END
        ,drvDepLastName34 = ''
        ,drvDepMiddleInitial34 = ''
        ,drvDepGender34 = ''
        ,drvDepDateOfBirth34 = ''
        ,drvDepRelationshipCode34 = ''
        ,drvDepStudentCode34 = ''
        ,drvDepDisabledYN34 = ''
        ,drvDepCvgIndicator34 = ''
        ,drvDedDhmoPcp34 = ''
		
		,drvDepFirstName35 = CASE WHEN BemDedCode in (Select Code from @DedBenCodes) THEN (SELECT ConNameFirst from Contacts JOIN EmpPers on ConEEID = eepEEID WHERE ConEEID = xEEID AND ConRelationship in (Select Code from @DepRelCodes) ORDER BY ConSSN OFFSET 34 ROWS FETCH NEXT 1 ROWS ONLY) END
        ,drvDepLastName35 = ''
        ,drvDepMiddleInitial35 = ''
        ,drvDepGender35 = ''
        ,drvDepDateOfBirth35 = ''
        ,drvDepRelationshipCode35 = ''
        ,drvDepStudentCode35 = ''
        ,drvDepDisabledYN35 = ''
        ,drvDepCvgIndicator35 = ''
        ,drvDedDhmoPcp35 = ''
		
		,drvDepFirstName36 = CASE WHEN BemDedCode in (Select Code from @DedBenCodes) THEN (SELECT ConNameFirst from Contacts JOIN EmpPers on ConEEID = eepEEID WHERE ConEEID = xEEID AND ConRelationship in (Select Code from @DepRelCodes) ORDER BY ConSSN OFFSET 35 ROWS FETCH NEXT 1 ROWS ONLY) END
        ,drvDepLastName36 = ''
        ,drvDepMiddleInitial36 = ''
        ,drvDepGender36 = ''
        ,drvDepDateOfBirth36 = ''
        ,drvDepRelationshipCode36 = ''
        ,drvDepStudentCode36 = ''
        ,drvDepDisabledYN36 = ''
        ,drvDepCvgIndicator36 = ''
        ,drvDedDhmoPcp36 = ''
		
		,drvDepFirstName37 = CASE WHEN BemDedCode in (Select Code from @DedBenCodes) THEN (SELECT ConNameFirst from Contacts JOIN EmpPers on ConEEID = eepEEID WHERE ConEEID = xEEID AND ConRelationship in (Select Code from @DepRelCodes) ORDER BY ConSSN OFFSET 36 ROWS FETCH NEXT 1 ROWS ONLY) END
        ,drvDepLastName37 = ''
        ,drvDepMiddleInitial37 = ''
        ,drvDepGender37 = ''
        ,drvDepDateOfBirth37 = ''
        ,drvDepRelationshipCode37 = ''
        ,drvDepStudentCode37 = ''
        ,drvDepDisabledYN37 = ''
        ,drvDepCvgIndicator37 = ''
        ,drvDedDhmoPcp37 = ''
		
		,drvDepFirstName38 = CASE WHEN BemDedCode in (Select Code from @DedBenCodes) THEN (SELECT ConNameFirst from Contacts JOIN EmpPers on ConEEID = eepEEID WHERE ConEEID = xEEID AND ConRelationship in (Select Code from @DepRelCodes) ORDER BY ConSSN OFFSET 37 ROWS FETCH NEXT 1 ROWS ONLY) END
        ,drvDepLastName38 = ''
        ,drvDepMiddleInitial38 = ''
        ,drvDepGender38 = ''
        ,drvDepDateOfBirth38 = ''
        ,drvDepRelationshipCode38 = ''
        ,drvDepStudentCode38 = ''
        ,drvDepDisabledYN38 = ''
        ,drvDepCvgIndicator38 = ''
        ,drvDedDhmoPcp38 = ''
		
		,drvDepFirstName39 = CASE WHEN BemDedCode in (Select Code from @DedBenCodes) THEN (SELECT ConNameFirst from Contacts JOIN EmpPers on ConEEID = eepEEID WHERE ConEEID = xEEID AND ConRelationship in (Select Code from @DepRelCodes) ORDER BY ConSSN OFFSET 38 ROWS FETCH NEXT 1 ROWS ONLY) END
        ,drvDepLastName39 = ''
        ,drvDepMiddleInitial39 = ''
        ,drvDepGender39 = ''
        ,drvDepDateOfBirth39 = ''
        ,drvDepRelationshipCode39 = ''
        ,drvDepStudentCode39 = ''
        ,drvDepDisabledYN39 = ''
        ,drvDepCvgIndicator39 = ''
        ,drvDedDhmoPcp39 = ''
		
		,drvDepFirstName40 = CASE WHEN BemDedCode in (Select Code from @DedBenCodes) THEN (SELECT ConNameFirst from Contacts JOIN EmpPers on ConEEID = eepEEID WHERE ConEEID = xEEID AND ConRelationship in (Select Code from @DepRelCodes) ORDER BY ConSSN OFFSET 39 ROWS FETCH NEXT 1 ROWS ONLY) END
        ,drvDepLastName40 = ''
        ,drvDepMiddleInitial40 = ''
        ,drvDepGender40 = ''
        ,drvDepDateOfBirth40 = ''
        ,drvDepRelationshipCode40 = ''
        ,drvDepStudentCode40 = ''
        ,drvDepDisabledYN40 = ''
        ,drvDepCvgIndicator40 = ''
        ,drvDedDhmoPcp40 = ''
        INTO dbo.U_ELINFINEXP_drvTbl
    FROM dbo.U_ELINFINEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.Company WITH (NOLOCK)
        ON CmpCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ELINFINEX WITH (NOLOCK) -- ??? no table
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
	LEFT JOIN dbo.Contacts WITH (NOLOCK) -- ???
        ON ConEEID = xEEID
		AND ConRelationship in ('SPS', 'DP')
        AND ConSystemID = BdmDepRecID;
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
ALTER VIEW dbo.dsi_vwELINFINEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ELINFINEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ELINFINEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201911011'
       ,expStartPerControl     = '201911011'
       ,expLastEndPerControl   = '201911089'
       ,expEndPerControl       = '201911089'
WHERE expFormatCode = 'ELINFINEXP';

**********************************************************************************/