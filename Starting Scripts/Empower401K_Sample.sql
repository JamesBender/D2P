CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EEMP401ALI]  
    @SystemID char(12)  
AS  
/**********************************************************************************  
Client Name: Alixa Rx, LLC  
  
Created By: Vraj Parikh  
Business Analyst: Chad Reaves  
Create Date: 07/10/2018  
Service Request Number: ALI1001-2018-00196793  
  
  
Purpose: Empower 401K  
  
Revision History  
----------------  
Update By           Date           Request Num        Desc  
XXXX                XX/XX/2017     SR-2017-000XXXXX   XXXXX  
  
SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EEMP401ALI';  
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EEMP401ALI';  
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EEMP401ALI';  
SELECT * FROM dbo.AscExp WHERE expFormatCode = 'EEMP401ALI';  
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EEMP401ALI' ORDER BY RunID DESC;  
  
Execute Export  
--------------  
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEMP401ALI', 'EEMP401ALI';  
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEMP401ALI', 'TEST';  
  
EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EEMP401ALI', @AllObjects = 'Y', @IsWeb ='Y'  
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
            ,@PayDate           DATETIME;  
  
    -- Set FormatCode  
    SELECT @FormatCode = 'EEMP401ALI';  
  
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
    DELETE FROM dbo.U_EEMP401ALI_EEList  
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)  
    AND xEEID IN (SELECT xEEID FROM dbo.U_EEMP401ALI_EEList GROUP BY xEEID HAVING COUNT(1) > 1);  
  
    ----Delete Test Employees  
    DELETE dbo.U_EEMP401ALI_EEList  
    FROM dbo.U_EEMP401ALI_EEList  
    JOIN EmpPers t with (nolock) on xeeid = eepeeid   
    WHERE t.EepNameLast like 'Test%' OR t.EepNameFirst like 'Test%';  
  
    --==========================================  
    -- Create Deduction List  
    --==========================================  
    DECLARE @DedList VARCHAR(MAX)  
    SET @DedList = '403BF,403BP,403M,403BL';   
  
    IF OBJECT_ID('U_EEMP401ALI_DedList','U') IS NOT NULL  
        DROP TABLE dbo.U_EEMP401ALI_DedList;  
    SELECT DISTINCT  
         DedCode = DedDedCode  
        ,DedType = DedDedType  
    INTO dbo.U_EEMP401ALI_DedList  
    FROM dbo.fn_ListToTable(@DedList)  
    JOIN dbo.DedCode WITH (NOLOCK)  
        ON DedDedCode = Item;  
  
    --==========================================  
    -- Build Working Tables  
    --==========================================  
  
    -- Get pay dates  
  
    SELECT  
        @PayDate         = MAX(PgpPayDate)  
    FROM PgPayPer  
    WHERE PgpPayDate <= @EndDate  
  
    -----------------------------  
    -- Working Table - PDedHist  
    -----------------------------  
    IF OBJECT_ID('U_EEMP401ALI_PDedHist','U') IS NOT NULL  
        DROP TABLE dbo.U_EEMP401ALI_PDedHist;  
    SELECT DISTINCT  
         PdhEEID  
        ,PdhPerControl = LEFT(PdhPerControl,8)  
        -- Current Payroll Amounts  
        ,PdhEECurAmt      = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)  
        ,PdhERCurAmt      = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)  
        -- YTD Payroll Amounts  
        ,PdhEECurAmtYTD   = SUM(PdhEECurAmt)  
        ,PdhERCurAmtYTD   = SUM(PdhERCurAmt)  
        -- Categorize Payroll Amounts  
        ,PdhEECurAmt401K    = SUM(CASE WHEN PdhDedCode IN ('401F','401P','401CF','401CP') THEN PdhEECurAmt ELSE 0.00 END)  
        ,PdhEECurAmtROTH    = SUM(CASE WHEN PdhDedCode IN ('ROTH4') THEN PdhEECurAmt ELSE 0.00 END)    
        ,PdhEECurAmtMatch    = SUM(CASE WHEN PdhDedCode IN ('403M') THEN PdhERCurAmt ELSE 0.00 END)    
        ,PdhEECurAmtLoanAll = SUM(CASE WHEN PdhDedCode IN ('401L','401L2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)  
        ,PdhEECurAmtLoan1    = SUM(CASE WHEN PdhDedCode IN ('401L') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)  
        ,PdhEECurAmtLoan2    = SUM(CASE WHEN PdhDedCode IN ('401L2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)  
        ,PdhEECurAmtLoan3    = SUM(CASE WHEN PdhDedCode IN ('') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)  
        ,PdhEECurAmtLoan4    = SUM(CASE WHEN PdhDedCode IN ('') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)  
        ,PdhEECurAmtLoan5    = SUM(CASE WHEN PdhDedCode IN ('') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)  
        ,PdhEECurAmtLoan6    = SUM(CASE WHEN PdhDedCode IN ('') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)  
        ,PdhEECurAmtLoan11    = SUM(CASE WHEN PdhDedCode IN ('') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)  
    INTO dbo.U_EEMP401ALI_PDedHist  
    FROM dbo.U_EEMP401ALI_EEList WITH (NOLOCK)  
    JOIN dbo.PDedHist WITH (NOLOCK)  
        ON PdhEEID = xEEID  
    JOIN dbo.U_EEMP401ALI_DedList WITH (NOLOCK)  
        ON DedCode = PdhDedCode  
    WHERE PdhPerControl BETWEEN @StartPerControl AND @EndPerControl  
    GROUP BY PdhEEID, LEFT(PdhPerControl,8)  
    HAVING (SUM(PdhEECurAmt) <> 0.00  
        OR SUM(PdhERCurAmt) <> 0.00  
    );  
  
    -----------------------------  
    -- Working Table - PEarHist  
    -----------------------------  
    IF OBJECT_ID('U_EEMP401ALI_PEarHist','U') IS NOT NULL  
        DROP TABLE dbo.U_EEMP401ALI_PEarHist;  
    SELECT DISTINCT  
         PehEEID  
        ,PrgPayDate          = MAX(PrgPayDate)  
        -- Current Payroll Amount/Hours  
        ,PehCurAmt           = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)  
        ,PehCurHrs           = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)  
        -- YTD Payroll Amount/Hours  
        ,PehCurAmtYTD        = SUM(PehCurAmt)  
        ,PehCurHrsYTD        = SUM(PehCurHrs)  
        -- Include Deferred Comp Amount/Hours  
        ,PehInclInDefComp    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)  
        ,PehInclInDefCompHrs = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)  
    INTO dbo.U_EEMP401ALI_PEarHist  
    FROM dbo.U_EEMP401ALI_EEList WITH (NOLOCK)  
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
    -- DETAIL RECORD - U_EEMP401ALI_drvTbl  
    ---------------------------------  
    IF OBJECT_ID('U_EEMP401ALI_drvTbl','U') IS NOT NULL  
        DROP TABLE dbo.U_EEMP401ALI_drvTbl;  
    SELECT DISTINCT  
         drvEEID = xEEID  
        ,drvCoID = xCoID  
        -- standard fields above and additional driver fields below  
      ,drvPlanNumber                 = '504119-01'                          
        ,drvSSN                      = eepSSN  
        ,drvDivision                 = ''  
        ,drvLastname                 = EepNameLast  
        ,drvFirstName                 = EepNameFirst  
        ,drvMI                         = EepNameMiddle  
        ,drvNameSuffix                 = NULLIF(EepNameSuffix,'Z')  
        ,drvBirthDate                 = EepDateOfBirth  
        ,drvGender                     = EepGender  
        ,drvMaritalStatus             = CASE WHEN eepMaritalStatus = 'M' THEN 'M' ELSE 'S' END  
        ,drvAddressLine1             = dbo.dsi_fnRemoveChars(',',eepAddressLine1)  
        ,drvAddressLine2             = dbo.dsi_fnRemoveChars(',',eepAddressLine2)  
        ,drvCity                     = dbo.dsi_fnRemoveChars(',',eepAddressCity)  
        ,drvState                     = EepAddressState  
        ,drvZipCode                     = CASE WHEN len(eepAddressZipCode) > 5   
                                            THEN substring(eepAddressZipCode,1,5) + '-' + substring(eepAddressZipCode,6,4)   
                                            ELSE eepAddressZipCode   
                                            END  
        ,drvHomePhone                 = EepPhoneHomeNumber  
        ,drvWorkPhone                 = EecPhoneBusinessNumber  
        ,drvWorkPhoneExt             = EecPhoneBusinessNumber  
        ,drvCountry                     = EepAddressCountry  
        ,drvHireDate                 = EecDateOfLastHire  
        ,drvTerminationDate             = CASE WHEN EecEmplStatus = 'T' AND EecTermReason <> 'TRO'   
                                            THEN EecDateOfTermination   
                                            END  
        ,drvRehireDate                 = CASE WHEN eecDateOfOriginalHire <> eecDateOfLastHire AND CoXfer.reason <> 'TRI'  
                                            THEN eecDateOfLastHire   
                                            END  
        ,drvCheckDate                 = @PayDate  
        ,drvEmpBeforeTax             = dbo.dsi_fnpadzero((ISNULL(PdhEECurAmt401K,0)),10,2)  
        ,drvEmpMatch                 = dbo.dsi_fnpadzero(ISNULL(PdhEECurAmtMatch,0),10,2)  
        ,drvLoan                     = dbo.dsi_fnpadzero((ISNULL(PdhEECurAmtLoanAll,0)),10,2)   
        ,drvRoth                     = dbo.dsi_fnpadzero(ISNULL(PdhEECurAmtRoth,0),10,2)  
        ,drvConAmt5                     = ''  
        ,drvConAmt6                     = ''  
        ,drvConAmt7                     = ''  
        ,drvConAmt8                     = ''  
        ,drvHoursWorked                 = dbo.dsi_fnpadzero(cast(ISNULL(PehInclInDefCompHrs,0) as money),8,2)  
        ,drvYTDTotalComp             = dbo.dsi_fnpadzero(ISNULL(PehCurAmtYTD,0),11,2)  
        ,drvYTDPlanComp                 = CASE WHEN dbo.dsi_fnpadzero(ISNULL(PehInclInDefComp,0),11,2) > dbo.dsi_fnpadzero(ISNULL(PehCurAmtYTD,0),11,2) THEN dbo.dsi_fnpadzero(ISNULL(PehCurAmtYTD,0),11,2) ELSE  dbo.dsi_fnpadzero(ISNULL(PehInclInDefComp,0),
11,2) END -- dbo.dsi_fnpadzero(ISNULL(PehInclInDefComp,0),11,2) --make sure this is YTD  
        ,drvYTDPreEntryComp             = ''  
        ,drvHighlyComp                 = ''  
        ,drvPercentOwnership         = ''  
        ,drvOfficer                     = ''  
        ,drvParticipationDate         = @PayDate  
        ,drvEligCode                 = ''  
        ,drvBeforeTaxContributionPer = ''  
        ,drvBeforeTaxContributionAmt = ''  
        ,drvAfterTaxContributionPer     = ''  
        ,drvAfterTaxContributionAmt  = ''  
        ,drvEmail                     = EepAddressEMail  
        ,drvSalary                     = dbo.dsi_fnPadZero(ISNULL(eecAnnSalary,0),17,2)  
        ,drvSalaryAmtQualifier         = 'A'  
        ,drvTermReasonCode             = ''--CASE WHEN EecEmplStatus = 'T' THEN EecTermReason END  
        ,drvSBORIndex                 = ''  
        ,drvFederalExempt             = ''  
        ,drvEmpAssignedID        = ''  
        ,drvComplianceStatusCode     = ''  
    INTO dbo.U_EEMP401ALI_drvTbl  
    FROM dbo.U_EEMP401ALI_EEList WITH (NOLOCK)  
    JOIN dbo.EmpComp WITH (NOLOCK)  
        ON EecEEID = xEEID  
        AND EecCoID = xCoID  
    JOIN dbo.EmpPers WITH (NOLOCK)  
        ON EepEEID = xEEID  
    JOIN dbo.Company  
        ON eecCoid = cmpCoid  
    JOIN dbo.U_EEMP401ALI_PEarHist  
        ON PehEEID = xEEID  
    LEFT JOIN dbo.U_EEMP401ALI_PDedHist  
        ON PdhEEID = xEEID  
    LEFT JOIN (select distinct ejheeid eeid, ejhcoid coid, ejhreason reason, ejhJobEffDate jdate  
        FROM dbo.EmpHJob WITH (NOLOCK)  
        WHERE ejhreason = 'TRI') as CoXfer on CoXfer.eeid = xEEID and CoXfer.coid = xCoID  
    ;  
  
    --==========================================  
    -- Set FileName  
    --==========================================  
    --IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')  
    --BEGIN  
    --    UPDATE dbo.U_dsi_Parameters  
    --        SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_EMPACC_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'  
    --                              WHEN @ExportCode LIKE 'OE%' THEN 'OE_EMPACC_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'  
    --                              ELSE 'EMPACC_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'  
    --                         END  
    --    WHERE FormatCode = @FormatCode;  
    --END  
  
END;  
/**********************************************************************************  
  
--Alter the View  
ALTER VIEW dbo.dsi_vwEEMP401ALI_Export AS  
    SELECT TOP 20000000 Data  
    FROM dbo.U_EEMP401ALI_File (NOLOCK)  
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;  
  
--Check out AscDefF  
SELECT * FROM dbo.AscDefF  
WHERE AdfHeaderSystemID LIKE 'EEMP401ALI%'  
ORDER BY AdfSetNumber, AdfFieldNumber;  
  
--Update Dates  
UPDATE dbo.AscExp  
    SET expLastStartPerControl = '201705121'  
       ,expStartPerControl     = '201705121'  
       ,expLastEndPerControl   = '201705199'  
       ,expEndPerControl       = '201705199'  
WHERE expFormatCode = 'EEMP401ALI';  
  
**********************************************************************************/  