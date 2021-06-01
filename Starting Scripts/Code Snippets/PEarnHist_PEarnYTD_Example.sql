USE [ULTIPRO_YOSHI]
GO
/****** Object:  StoredProcedure [dbo].[dsi_sp_BuildDriverTables_ETRN401PHR]    Script Date: 4/21/2020 8:16:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ETRN401PHR]
    @SystemID char(12)
AS
/**********************************************************************************
Client Name: PRH Investments, LLC 
Vendor Name: Transamerica 401k Payroll - Fixed Width Format
Created By: Vraj Parikh
Business Analyst: Justin Holy
Create Date: 1/28/2018
Service Request Number: PRH1000-2017-00167780 (rebuild)

Purpose: TransAmerica Payroll

Changes:
MM/DD/YYYY    NAME HERE     SF 09999999              Comments Here

_dsi_usp_ExportRipout @FormatCode = 'ETRN401PHR', @AllObjects = 'Y', @IsWeb = 'Y'

select * from dbo.U_dsi_Configuration where FormatCode = 'ETRN401PHR' ORDER BY LEN(CfgName) DESC
select * from dbo.U_dsi_SQLClauses where FormatCode = 'ETRN401PHR'
select * from dbo.U_dsi_Parameters where FormatCode = 'ETRN401PHR'

select * from AscDefH where AdhFormatCode = 'ETRN401PHR'
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl, *
FROM dbo.AscExp WHERE expformatcode = 'ETRN401PHR';
select * from ascdeff JOIN AscDefH on adhSystemiD = AdfHeaderSystemID WHERE AdhFormatCode = 'ETRN401PHR' order by adfrectype, AdfSetNumber, AdfFieldNumber 

DSI_SP_TESTSWITCHBOX_V2 'ETRN401PHR', 'ETRN401PHR'
DSI_SP_TESTSWITCHBOX_V2 'ETRN401PHR', 'TEST'

To turn off/on TESTEDT header record: 
Update U_Dsi_Configuration set CfgValue = 'N' WHERE FormatCode = 'ETRN401PHR' AND CfgName = 'TESTING'

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
    SELECT @FormatCode = 'ETRN401PHR';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    PRINT 'Start Date: ' + CONVERT(VARCHAR(26),@StartDate,100);
    PRINT 'End Date:  ' + CONVERT(VARCHAR(26),@EndDate,100);

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_ETRN401PHR_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ETRN401PHR_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '401P,401F,401CP,401CF,401M,ROTHF,ROTHP,ROTHCF,ROTHCP,401L';

    IF OBJECT_ID('U_ETRN401PHR_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ETRN401PHR_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ETRN401PHR_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

    --==========================================
    -- Build Working Tables
    --==========================================
    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_ETRN401PHR_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ETRN401PHR_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt = CAST(SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END) AS NUMERIC(12,2))
        ,PdhERCurAmt = CAST(SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END) AS NUMERIC(12,2))
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhEECurAmt401K = CAST(SUM(CASE WHEN PdhDedCode IN ('401P','401F') THEN PdhEECurAmt ELSE 0.00 END) AS NUMERIC(12,2))
        ,PdhEECurAmtROTH = CAST(SUM(CASE WHEN PdhDedCode IN ('ROTHF','ROTHP') THEN PdhEECurAmt ELSE 0.00 END) AS NUMERIC(12,2))
        ,PdhEECurAmtMatch = CAST(SUM(CASE WHEN PdhDedCode IN ('401M') THEN PdhERCurAmt ELSE 0.00 END)   AS NUMERIC(12,2))      
        ,PdhEECurAmt401KCatchUp = CAST(SUM(CASE WHEN PdhDedCode IN ('401CP','401CF') THEN PdhEECurAmt ELSE 0.00 END) AS NUMERIC(12,2))
        ,PdhEECurAmtROTHCatchUp = CAST(SUM(CASE WHEN PdhDedCode IN ('ROTHCF','ROTHCP') THEN PdhEECurAmt ELSE 0.00 END) AS NUMERIC(12,2))
        ,PdhEECurAmtSAFEH = CAST(SUM(CASE WHEN PdhDedCode IN ('') THEN PdhEECurAmt ELSE 0.00 END) AS NUMERIC(12,2))
        ,PdhEECurAmtLoanTot = CAST(SUM(CASE WHEN PdhDedCode IN ('401L') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END) AS NUMERIC(12,2))
    INTO dbo.U_ETRN401PHR_PDedHist
    FROM dbo.U_ETRN401PHR_EEList WITH (NOLOCK)
    JOIN dbo.PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
    JOIN dbo.U_ETRN401PHR_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE PdhPerControl = @EndPerControl
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );

    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_ETRN401PHR_PHist','U') IS NOT NULL
        DROP TABLE dbo.U_ETRN401PHR_PHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate          = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt           = CAST(SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END) AS NUMERIC(12,2))
    INTO dbo.U_ETRN401PHR_PHist
    FROM dbo.U_ETRN401PHR_EEList WITH (NOLOCK)
    JOIN dbo.PayReg WITH (NOLOCK)
        ON PrgEEID = xEEID
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE PehPerControl = @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_ETRN401PHR_PEarHistYTD','U') IS NOT NULL
        DROP TABLE dbo.U_ETRN401PHR_PEarHistYTD;
    SELECT DISTINCT
         PehEEID
        --,PrgPayDate          = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt           = CAST(SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END) AS NUMERIC(12,2))
        ,PehCurHrs           = CAST(SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END) AS NUMERIC(12,2))
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD        = CAST(SUM(PehCurAmt) AS NUMERIC(12,2))
        ,PehCurHrsYTD        = CAST(SUM(PehCurHrs) AS NUMERIC(12,2))
        -- Include Deferred Comp Amount/Hours
        ,PehInclInDefComp    = CAST(SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END) AS NUMERIC(12,2))
        ,PehInclInDefCompHrs = CAST(SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END) AS NUMERIC(12,2))
    INTO dbo.U_ETRN401PHR_PEarHistYTD
    FROM dbo.U_ETRN401PHR_EEList WITH (NOLOCK)
    JOIN dbo.PayReg WITH (NOLOCK)
        ON PrgEEID = xEEID
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_dsi_ETRN401PHR_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_dsi_ETRN401PHR_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_dsi_ETRN401PHR_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvLocation = ''
        ,drvSubCompanyNumber = ''
        ,drvGroupCode = ''
        ,drvSSN = eepSSN
        ,drvNamePrefix = ''
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddleInit = LEFT(EepNameMiddle,1)
        ,drvNameLast = EepNameLast
        ,drvNameSuffix = ''
        ,drvEEPreTaxAmt = CAST(PdhEECurAmt401K AS VARCHAR)
        ,drvEEPreTaxCatchUpAmt = CAST(PdhEECurAmt401KCatchUp AS VARCHAR)
        ,drvEERothAmt = CAST(PdhEECurAmtROTH AS VARCHAR)
        ,drvEERothCatchUpAmt = CAST(PdhEECurAmtROTHCatchUp AS VARCHAR)
        ,drvEEPostTaxAmt = ''
        ,drvEEMandPostTaxAmt = ''
        ,drvERMatchAmt = CAST(PdhEECurAmtMatch AS VARCHAR)
        ,drvERNotMatchAmt = ''
        ,drvERSafeHarborMatchAmt = ''
        ,drvERSafeHarborNonMatchAmt = ''
        ,drvERMoneyPurchase = ''
        ,drvERFullyVestedMoneyPurchase = ''
        ,drvERPrevailingWage = ''
        ,drvQMAC = ''
        ,drvQNEC = ''
        ,drvLoanRepayAmt = CAST(PdhEECurAmtLoanTot AS VARCHAR)
        ,drvCompensationYTDAmt = CAST(PehCurAmtYTD AS VARCHAR)
        ,drvExcludedCompensationYTDAmt = CAST(PehInclInDefComp AS VARCHAR)
        ,drvHrsWorkedYTD = CAST(dbo.dsi_fnRemoveChars('.',dbo.dsi_fnPadZero(isnull(PehCurHrsYTD,0.00),4,0)) AS VARCHAR)--CAST(PehCurHrsYTD AS VARCHAR)
        ,drvIsUSAddress = ''
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvIntlAddressCityProvince = ''
        ,drvIntlAddressZipCode = ''
        ,drvIntlCountry = ''
        ,drvDateofBirth = CONVERT(CHAR(8),EepDateOfBirth,112)
        ,drvDateofHire = CONVERT(CHAR(8),EecDateofOriginalHire,112)
        ,drvDateofTermination = CONVERT(CHAR(8),EecDateOfTermination,112)
        ,drvDateofRehire = CONVERT(CHAR(8),EecDateOfLastHire,112)
        ,drvERQACANonElective = ''
        ,drvERQACAMatch = ''
        ,drvERALTMatch = ''
        ,drvERALTProfitSharing = ''
        ,drvERALTMoneyPurchase = ''

    INTO dbo.U_dsi_ETRN401PHR_drvTbl
    FROM dbo.U_ETRN401PHR_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_ETRN401PHR_PEarHistYTD WITH (NOLOCK)
        ON PehEEID = xEEID
    JOIN dbo.U_ETRN401PHR_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
    ;

    ---------------------------------
    -- HEADER RECORD - U_dsi_ETRN401PHR_hdrTbl
    ---------------------------------
    IF OBJECT_ID('U_dsi_ETRN401PHR_hdrTbl','U') IS NOT NULL
        DROP TABLE dbo.U_dsi_ETRN401PHR_hdrTbl;
    SELECT DISTINCT
        drvVendorName = 'TransAmerica'
        ,drvFileCreateDate = dbo.dsi_fnRemoveChars('-:.',REPLACE(CONVERT(VARCHAR(20),GETDATE(),121),' ',''))
        ,drvContractID = '512960'
        ,drvSubID = '00000'
        ,drvIsMEP = '0'
        ,drvCompanyName = 'PRH Investments, LLC'
        ,drvPayrollEndDate = CONVERT(CHAR(8),e.PrgPayDate,112)
        ,drvTotalPayrollAmt = CAST(d.amt AS VARCHAR)--e.amt
        ,drvDepositAmt = CAST(d.amt AS VARCHAR)
        ,drvDepositMethod = '0'
        ,drvACHNumber = ''
        ,drvMode = CASE WHEN @ExportCode IN ('TEST') THEN 'VALIDATE' ELSE '' END

    INTO dbo.U_dsi_ETRN401PHR_hdrTbl
    FROM (SELECT CAST(ISNULL(SUM(PdhEECurAmt401K),0) + ISNULL(SUM(PdhEECurAmtMatch),0) + ISNULL(SUM(PdhEECurAmt401KCatchUp),0) + ISNULL(SUM(PdhEECurAmtLoanTot),0) AS NUMERIC(12,2))amt
        FROM dbo.U_ETRN401PHR_PDedHist) d
    JOIN (SELECT PrgPayDate, SUM(PehCurAmt) amt
        FROM dbo.U_ETRN401PHR_PHist
        GROUP BY PrgPayDate) e ON 1=1;
    --==========================================
    -- Set FileName
    --==========================================
    --IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    --BEGIN
    --    UPDATE dbo.U_dsi_Parameters
    --        SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
    --                              WHEN @ExportCode LIKE 'OE%' THEN 'OE_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
    --                              ELSE 'Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
    --                         END
    --    WHERE FormatCode = @FormatCode;
    --END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwETRN401PHR_Export AS
    SELECT TOP 20000000 Data
    FROM dbo.U_ETRN401PHR_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ETRN401PHR%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201705031'
       ,expStartPerControl     = '201705031'
       ,expLastEndPerControl   = '201705109'
       ,expEndPerControl       = '201705109'
WHERE expFormatCode = 'ETRN401PHR';

**********************************************************************************/
