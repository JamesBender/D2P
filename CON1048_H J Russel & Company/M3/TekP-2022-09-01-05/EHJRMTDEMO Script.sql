USE [ULTIPRO_YOSHI]
GO
/****** Object:  StoredProcedure [dbo].[dsi_sp_BuildDriverTables_EHJRMTDEMO]    Script Date: 10/10/2022 3:44:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EHJRMTDEMO]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: H.J. Russell & Company

Created By: Roger Bynum
Business Analyst: Kim Ephram
Create Date: 10/07/2022
Service Request Number: TekP-2022-09-01-05

Purpose: M3 Demographics Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EHJRMTDEMO';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EHJRMTDEMO';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EHJRMTDEMO';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EHJRMTDEMO';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EHJRMTDEMO' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHJRMTDEMO', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHJRMTDEMO', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHJRMTDEMO', 'SCH_EHJRMT';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EHJRMTDEMO', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EHJRMTDEMO';

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
    DELETE FROM dbo.U_EHJRMTDEMO_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EHJRMTDEMO_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EHJRMTDEMO_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EHJRMTDEMO_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        ,PrgPeriodStartDate     = MIN(PrgPeriodStartDate)
        ,PrgPeriodEndDate       = MAX(PrgPeriodEndDate) 
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
    INTO dbo.U_EHJRMTDEMO_PEarHist
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
    -- DETAIL RECORD - U_EHJRMTDEMO_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EHJRMTDEMO_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EHJRMTDEMO_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvEmployeeCode = EecEmpNo
        ,drvHourlyPayRate = EecHourlyPayRate
        ,drvFirstName = EepNameFirst
        ,drvLastName = EepNameLast
        ,drvMiddleInitial = LEFT(EepNameMiddle,1)
        ,drvGender = CASE WHEN EepGender IN ('M','F') THEN EepGender ELSE 'U' END
        ,drvDateOfBirth = EepDateOfBirth
        ,drvClockNo = EecTimeclockID
        ,drvDateOfHire = CASE WHEN (EecDateOfLastHire <> EecDateOfOriginalHire AND EecJobChangeReason = '101') OR EecHireSource = 'REHIRE' 
									THEN EecDateOfLastHire
							  ELSE EecDateOfOriginalHire
						  END
        ,drvEffectiveDate = MIN(PrgPeriodStartDate)
        ,drvAddress = EepAddressLine1
        ,drvAddress2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvPostalCode = CASE WHEN LEN(EepAddressZipCode) > 5 THEN LEFT(EepAddressZipCode, 5) + '-' + RIGHT(EepAddressZipCode, 4) ELSE EepAddressZipCode END
        ,drvEmployeeStatus = EecEmplStatus
        ,drvEmployeeType = EecEEType
        ,drvFullorPartTime = EecFullTimePartTime
        ,drvHrlSlryNonExmptFluc = CASE WHEN EecSalaryOrHourly = 'H' THEN 'Hourly'
									   WHEN EecSalaryOrHourly = 'S' THEN 'Salaried'
									   WHEN EjhFLSACategory = 'NE' THEN 'Non-Exempt'
								  END
        ,drvSSN = eepSSN
        ,drvPayGroup = EecPayGroup
        ,drvPhoneNumber = (SELECT * FROM dbo.EmpMPhon WHERE EfoPhoneType = 'CEL' AND EfoEEID = xEEID)
        ,drvTerminationCode = CASE WHEN EecStatus = 'T' THEN 'T' END
        ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvNonExemptHours = CASE WHEN EjhFLSACategory = 'NE' THEN '40' END
        ,drvHomeDepartment = EecOrgLvl1
        ,drvHomeJob = EecJobCode
    INTO dbo.U_EHJRMTDEMO_drvTbl
    FROM dbo.U_EHJRMTDEMO_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
	JOIN dbo.U_EHJRMTDEMO_PEarHist
		ON PehEEID = xEEID
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
ALTER VIEW dbo.dsi_vwEHJRMTDEMO_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EHJRMTDEMO_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EHJRMTDEMO%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202209301'
       ,expStartPerControl     = '202209301'
       ,expLastEndPerControl   = '202210079'
       ,expEndPerControl       = '202210079'
WHERE expFormatCode = 'EHJRMTDEMO';

**********************************************************************************/

