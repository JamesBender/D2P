USE [ULTIPRO_WPUPI]
GO
/****** Object:  StoredProcedure [dbo].[dsi_sp_BuildDriverTables_EUPGLINFF]    Script Date: 1/31/2022 10:25:26 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUPGLINFF]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: UPG Enterprises LLC

Created By: Marie Thomerson
Business Analyst: Lea King
Create Date: 01/03/2022
Service Request Number: UPG - TekP-2021-10-20-0003

Purpose: Lincoln FMLA, STD, LTD

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EUPGLINFF';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EUPGLINFF';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EUPGLINFF';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EUPGLINFF';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EUPGLINFF' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUPGLINFF', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUPGLINFF', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUPGLINFF', 'SCH_EUPGLI';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EUPGLINFF';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EUPGLINFF', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EUPGLINFF';

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
    DELETE FROM dbo.U_EUPGLINFF_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EUPGLINFF_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EUPGLINFF_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EUPGLINFF_AuditFields;
    CREATE TABLE dbo.U_EUPGLINFF_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_EUPGLINFF_AuditFields VALUES ('EmpComp','EecDateofTermination');
    INSERT INTO dbo.U_EUPGLINFF_AuditFields VALUES ('EmpComp','EecEmplStatus');
    INSERT INTO dbo.U_EUPGLINFF_AuditFields VALUES ('EmpComp','EecTermReason');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EUPGLINFF_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EUPGLINFF_Audit;
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
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    INTO dbo.U_EUPGLINFF_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EUPGLINFF_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN dateadd(D, -90, @StartDate) AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EUPGLINFF_Audit ON dbo.U_EUPGLINFF_Audit (audEEID,audKey2);

    --================
    -- Changes Only
    --================
    --DELETE FROM dbo.U_EUPGLINFF_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EUPGLINFF_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'DED1,DED2';

    IF OBJECT_ID('U_EUPGLINFF_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EUPGLINFF_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EUPGLINFF_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','NMSTD,LEX,CSUN,LTD');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

    -- Non-Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EUPGLINFF_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EUPGLINFF_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_EUPGLINFF_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EUPGLINFF_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EUPGLINFF_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EUPGLINFF_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvEmpNoSort = eepSSN
        -- standard fields above and additional driver fields below
        ,drviCAMAccIDNo = '000000'
        ,drviCAMAccVerifNo = '000000'
        ,drvDisSubCode = '0000'
        ,drvEmpID = EecEmpNo
        ,drvEmpState = EepAddressState
        ,drvDisLocCode = eeclocation
        ,drvOccDescr = JbcDesc
        ,drvFirstName = EepNameFirst
        ,drvLastName = EepNameLast
        ,drvMiddleInitial = LEFT(EepNameMiddle,1)
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvStateCode = EepAddressState
        ,drvPostalCode = LEFT(EepAddressZipCode,9)
        ,drvSSN = eepSSN
        ,drvSSNTypeCode = '1'
        ,drvGenderCode = eepgender
        ,drvBirthDate = EepDateOfBirth
        ,drvDependentQty = '0 '
        ,drvDepUnder18Qty = '0 '
        ,drvSalaryAmt = CASE WHEN EecSalaryOrHourly = 'S' THEN  CAST(EecAnnSalary as VARCHAR(10)) ELSE '0.0       ' END
        --RIGHT(SPACE(9) + FORMAT(EecScheduledAnnualHrs/52/5, '#0'), 9)
        --0.0 left justified; pad with spaces to complete 10 byte field size
        ,drvHourlyWage = CASE WHEN EecSalaryOrHourly = 'H' THEN CAST(EecHourlyPayRate as VARCHAR(10)) else '0.0       ' END
        --left justified; pad with spaces to complete 10 byte field size
        --FORMAT((SELECT COUNT(*) FROM dbo.U_EUPGLINFF_drvTbl), '0000000')
        ,drvSalaryEffDate = [dbo].[dsi_fnlib_GetAnnSalary_EffDate_WithStartDate] (EecEEID,EecCOID,'01/01/2021',EecDateOfLastHire)
        ,drvSalaryType = CASE WHEN EecSalaryOrHourly = 'S' THEN 'SL' WHEN EecSalaryOrHourly = 'H' THEN 'HR' ELSE '  ' END
        ,drvBonusAmt = '0.0       '
        ,drvCommissionAmt = '0.0       '
        ,drvSalaryMode = CASE WHEN EecSalaryOrHourly = 'S' THEN '6' WHEN EecSalaryOrHourly = 'H' THEN '1' ELSE ' ' END
        ,drvYTDWages = '0.0       '
        ,drvW4WithHldgAllow = '0 '
        ,drvEmployType = CASE WHEN EecFullTimeOrPartTime = 'F' THEN '1' ELSE '2' END
        ,drvServiceMths = '0   '
        ,drvOrigHireDate = EecDateOfLastHire
        ,drvEmplStatus = CASE WHEN EecEmplStatus = 'T' THEN 'T' ELSE 'A' END
        ,drvDateofTerm = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination ELSE '        ' END
        ,drvHrsLast12Mths = '0.0   '
        ,drvHrsWorkedPerWk = '0.0       '
        ,drvHrsWorkedPerDay = '0.0      '
        ,drvDaysWorkedperWkQty = '0.0     '
        ,drvP1ProdCode = CASE	WHEN BDMSTD.Bdmdedcode = 'NMSTD' THEN 'STD  ' 
								WHEN EecUnionLocal <> 'CSCIN142' THEN 'STD  ' 
								ELSE '     'END
        ,drvP1BenType = CASE WHEN EecDedGroupCode =  'LEX' THEN 'STD03'
                                WHEN EecDedGroupCode = 'CSUN' THEN 'STD04'
                                WHEN BDMSTD.Bdmdedcode = 'NMSTD' then 'STD02'
								WHEN EecUnionLocal <> 'CSCIN142' THEN 'STD02'
                                else 'STD01' 
                        END
        ,drvP1CovStatus = CASE	WHEN BDMSTD.Bdmdedcode = 'NMSTD' THEN 'A' 
								WHEN EecUnionLocal <> 'CSCIN142' THEN 'A' 
								ELSE ' ' END
        ,drvP1CovEffDate = CASE WHEN BDMSTD.Bdmdedcode = 'NMSTD' AND BDMSTD.Bdmbenstartdate < 2022-01-01 THEN 2022-01-01 
								WHEN EecUnionLocal <> 'CSCIN142' THEN EecDateofLastHire 
								else BDMSTD.Bdmbenstartdate END 
        --ELSE '        ' END   THEN CASE WHEN 
        ,drvP1EmpPremContr = CASE	WHEN BDMSTD.Bdmdedcode = 'NMSTD' THEN '000' 
									WHEN EecUnionLocal <> 'CSCIN142' THEN  '000' 
									ELSE '0  ' END
        ,drvP1BenefitLvl = CASE		WHEN BDMSTD.Bdmdedcode = 'NMSTD' THEN '060' 
									WHEN EecUnionLocal <> 'CSCIN142' THEN '060' 
									ELSE '0  ' END
        ,drvP2ProdCode = CASE	
		--WHEN BDMLTD.Bdmdedcode = 'LTD' THEN 'LTD  ' 
								WHEN EecUnionLocal <> 'CSCIN142' THEN 'LTD  '  
								WHEN EecUnionLocal <> 'LEXBIL' THEN 'LTD  '  
								ELSE '     ' END
        ,drvP2BenType = CASE 
								WHEN EecUnionLocal = 'CHISTL' THEN 'LTD03'  
								WHEN EecUnionLocal = 'NATLMETALWAR' THEN 'LTD02'  
								WHEN EecUnionLocal <> 'CSCIN142' THEN 'LTD01'  
								WHEN EecUnionLocal <> 'LEXBIL' THEN 'LTD01'  
		--WHEN BDMLTD.Bdmdedcode = 'LTD' THEN 'XXXX ' 
							ELSE '     ' END
        ,drvP2CovStatus = CASE 
								WHEN EecUnionLocal <> 'CSCIN142' THEN 'A'  
								WHEN EecUnionLocal <> 'LEXBIL' THEN 'A'  
		--WHEN BDMLTD.Bdmdedcode = 'LTD' THEN 'A' 
								ELSE ' ' END
        ,drvP2CovEffDate = CASE 
								WHEN EecUnionLocal <> 'CSCIN142' AND EecDateofLastHire > 2022-01-01 THEN EecDateofLastHire
								WHEN EecUnionLocal <> 'CSCIN142' AND EecDateofLastHire < 2022-01-01 THEN 2022-01-01
								WHEN EecUnionLocal <> 'LEXBIL' AND EecDateofLastHire > 2022-01-01 THEN EecDateofLastHire
								WHEN EecUnionLocal <> 'LEXBIL' AND EecDateofLastHire < 2022-01-01 THEN 2022-01-01
								END
		--WHEN BDMLTD.Bdmdedcode = 'LTD' AND BDMLTD.Bdmbenstartdate < 2022-01-01 THEN 2022-01-01 else BDMLTD.Bdmbenstartdate END 
        --ELSE '        ' END 
        ,drvP2EmpPremContrib = CASE 
									WHEN EecUnionLocal <> 'CSCIN142' THEN '000'  
									WHEN EecUnionLocal <> 'LEXBIL' THEN '000'  
		--WHEN BDMLTD.Bdmdedcode = 'LTD' THEN '000' 
									ELSE ' ' END
        ,drvP2BenefitLvl = CASE 
									WHEN EecUnionLocal <> 'CSCIN142' THEN '060'  
									WHEN EecUnionLocal <> 'LEXBIL' THEN '060'  
		--WHEN BDMLTD.Bdmdedcode = 'LTD' THEN '060' 
									ELSE '0  ' END
		,drvP3ProdCode = CASE WHEN EecEEType = 'REG' THEN 'LEAVE' ELSE '     ' END
		,drvP3BenType = CASE WHEN EecEEType = 'REG' THEN 'FMLA '  END
		,drvP3CovStatus = CASE WHEN EecEEType = 'REG' THEN 'A' ELSE ' ' END
        ,drvP3CovEffDate = CASE WHEN EecEEType = 'REG' THEN eecdateoflasthire END
        ,drvP3EmpPremContrib = CASE WHEN EecEEType = 'REG' THEN '000' END
        ,drvP4EmpPremContrib = CASE WHEN EecEEType = 'REG' THEN '000' END
        ,drvP4BenefitLvl = '0  '
        ,drvP5EmpPremContrib = '0  '
        ,drvP5BenefitLvl = '0  '
        ,drvP6EmpPremContrib = '0  '
        ,drvP6BenefitLvl = '0  '
        ,drvP7EmpPremContrib = '0  '
        ,drvP7BenefitLvl = '0  '
        ,drvP8EmpPremContrib = '0  '
        ,drvP8BenefitLvl = '0  '
        ,drvEligAmtMode = 'H'
        ,drvEligAmtDur = PehCurAmtYTD
        --SUM(PehCurHrs) where PehEarnCode in (XXX) for per controls for last 12 months
        ,drvEligibReviewPeriodDur = '012'
        ,drvServiceAmt = DateDiff(MM, eecdateoflasthire, GETDATE())
        --# of month from eecdateoflasthire to file run date
        ,drvHrsPerDayMonday = CASE WHEN EecFullTimeOrPartTime = 'F'  THEN '8.0      ' else '4.0      ' END
        ,drvHrsPerDayTuesday = CASE WHEN EecFullTimeOrPartTime = 'F'  THEN '8.0      ' else '4.0      ' END
        ,drvHrsPerDayWednesday = CASE WHEN EecFullTimeOrPartTime = 'F'  THEN '8.0      ' else '4.0      ' END
        ,drvHrsPerDayThursday = CASE WHEN EecFullTimeOrPartTime = 'F'  THEN '8.0      ' else '4.0      ' END
        ,drvHrsPerDayFriday = CASE WHEN EecFullTimeOrPartTime = 'F'  THEN '8.0      ' else '4.0      ' END
        ,drvHrsPerDaySaturday = '0.0      '
        ,drvHrsPerDaySunday =  '0.0      '
        ,drvLatestHireDate = EecDateOfLastHire
        ,drvUnionEmpIndicator = CASE WHEN EecUnionLocal IS NOT NULL or EecUnionNational is not NULL THEN 'Y' else 'N' END
        ,drvExemptEmpIndicator = CASE WHEN EjhFLSACategory in ( 'E','Z') THEN 'Y' ELSE 'N' END
        ,drvDateCreated = FORMAT(GETDATE(), 'yyymmdd')
        ,drvRecordDelimiter = ''
    INTO dbo.U_EUPGLINFF_drvTbl
    FROM dbo.U_EUPGLINFF_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
        AND EecEEType = 'REG'
                 And (eecemplstatus <> 'T' OR (eecemplstatus = 'T' and eectermreason <> 'TRO'
          and EXISTS (Select 1 from dbo.U_EUPGLINFF_Audit where audEEID = xEEID and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN dbo.U_EUPGLINFF_PEarHist WITH (NOLOCK)
        ON PehEEID = xEEID
    LEFT JOIN dbo.U_dsi_BDM_EUPGLINFF AS BDMLTD WITH (NOLOCK)
        ON BDMLTD.BdmEEID = xEEID 
        AND BDMLTD.BdmCoID = xCoID
        AND BDMLTD.Bdmdedcode = 'LTD' 
    LEFT JOIN dbo.U_dsi_BDM_EUPGLINFF AS BDMSTD WITH (NOLOCK)
        ON BDMSTD.BdmEEID = xEEID 
        AND BDMSTD.BdmCoID = xCoID
        AND BDMSTD.Bdmdedcode = 'NMSTD'
    LEFT JOIN dbo.U_dsi_BDM_EUPGLINFF AS BDMCSUN WITH (NOLOCK)
        ON BDMCSUN.BdmEEID = xEEID 
        AND BDMCSUN.BdmCoID = xCoID
        AND BDMCSUN.Bdmdedcode = 'CSUN'
    LEFT JOIN dbo.U_dsi_BDM_EUPGLINFF AS BDMLEX WITH (NOLOCK)
        ON BDMLEX.BdmEEID = xEEID 
        AND BDMLEX.BdmCoID = xCoID
        AND BDMLEX.Bdmdedcode = 'CSUN'
    LEFT JOIN JOBCODE
        ON JbcJobCode = EecJobCode
    JOIN EmpHJob WITH (NOLOCK)
        On EjhEEID = xEEID
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EUPGLINFF_H_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EUPGLINFF_H_drvTbl;
    SELECT DISTINCT
         drvRecordNo = '0000000'
        ,drvDATE = FORMAT(GETDATE(), 'yyyyMMdd')+'  '
        ,drvRecordLength = '3000   '
        ,drvRecDelim = ' '
    INTO dbo.U_EUPGLINFF_H_drvTbl
    FROM dbo.U_EUPGLINFF_EEList WITH (NOLOCK)
    --JOIN dbo.U_dsi_BDM_EUPGLINFF WITH (NOLOCK)
    --    ON BdmEEID = xEEID 
    --    AND BdmCoID = xCoID
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EUPGLINFF_T_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EUPGLINFF_T_drvTbl;
    SELECT DISTINCT
         drvRec = '9999999'
        ,drvDate = CONVERT(VARCHAR(8),GETDATE(),112)+''
        ,drvNoofDetailRecs = FORMAT((SELECT COUNT(*) FROM dbo.U_EUPGLINFF_drvTbl), '0000000')
        ,drvRecordDelimiter = ' '
    INTO dbo.U_EUPGLINFF_T_drvTbl
    FROM dbo.U_EUPGLINFF_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EUPGLINFF WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN '09LF0712.UPG.' + CONVERT(VARCHAR(8),GETDATE(),112) + '.elg.txt'
                                  ELSE '09LF0712.UPG.' + CONVERT(VARCHAR(8),GETDATE(),112) + '.elg.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEUPGLINFF_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EUPGLINFF_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EUPGLINFF%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202201031'
       ,expStartPerControl     = '202201031'
       ,expLastEndPerControl   = '202202109'
       ,expEndPerControl       = '202202109'
WHERE expFormatCode = 'EUPGLINFF';

**********************************************************************************/
