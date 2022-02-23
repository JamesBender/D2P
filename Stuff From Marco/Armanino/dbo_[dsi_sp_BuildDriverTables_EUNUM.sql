USE [ULTIPRO_INTERN]
GO
/****** Object:  StoredProcedure [dbo].[dsi_sp_BuildDriverTables_EUNUM]    Script Date: 7/8/2020 7:59:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUNUM]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Armanino LLP

Created By: Luis Lugo
Business Analyst: Richard Vars
Create Date: 07/07/2020
Service Request Number: TekP-2019-05-29-0001

Purpose: UNUM Accident and Hospital Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EUNUM';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EUNUM';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EUNUM';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EUNUM';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EUNUM' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNUM', 'ONDEMAND';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EUNUM', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EUNUM';

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
    DELETE FROM dbo.U_EUNUM_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EUNUM_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EUNUM_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EUNUM_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EUNUM_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvpartnercaseID = 'ADP-002066'
        ,drvEnrlrLogonName = ''
        ,drvEnrollLogonType = ''
        ,drvEnrollState = EepAddressState
        ,drvProductID = CASE WHEN EedDedCode = 'ACC' THEN '815'
							 WHEN EedDedCode = 'HOSP' THEN '818' END
        ,drveeSSN = eepSSN
        ,drveeNumber = EecEmpNo
        ,drveeFirstName = EepNameFirst
        ,drveeLastName = EepNameLast
        ,drveeDOB = EepDateOfBirth
        ,drveeGender = EepGender
        ,drvEligibilityClass = ''
        ,drvLocation = ''
        ,drvAddress1 = EepAddressLine1
        ,drvAddress2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZip = Eepaddresszip
        ,drvDateOfHire = EecDateOfLastHire
        ,drvDateTimestamp = ''
        ,drvNumberOfPayPeriods = EecNumberOfPayments
        ,drvTotPayPeriodPremium = EedEEAmt
        ,drvSegment = ''
        ,drvSubdivision = ''
        ,drvCoverageEffectiveDate = CASE WHEN EedBenStartDate = (SELECT DATEFROMPARTS(YEAR(EedBenStartDate),MONTH(EedBenStartDate),1)) THEN EedBenStartDate
										 WHEN EedBenStartDate <> (SELECT DATEFROMPARTS(YEAR(EedBenStartDate),MONTH(EedBenStartDate),1)) THEN (SELECT DATEFROMPARTS(YEAR(EedBenStartDate),MONTH(EedBenStartDate),1))
										 END
        ,drvElectType = CASE WHEN EmpHDed = '200' THEN 'T'
							 WHEN EmpHDed = '100' THEN 'N'
							 WHEN EmpHDed = '402' THEN 'C' END
        ,drvTermDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvSPCoverage = CASE WHEN conrelationship = 'SPS' AND DbnDedCode = 'GACC' THEN 'Y'
		                      WHEN conrelationship = 'SPS' AND DbnDedCode = 'GHI' THEN 'Y'
							  ELSE 'N' END
        ,drvCHCoverage = CASE WHEN conrelationship = 'CHL' AND BfpDedCode = 'GACC' THEN 'Y'
		                      WHEN conrelationship = 'CHL' AND BfpDedCode = 'GHI' THEN 'Y'
							  ELSE 'N' END
        ,drveeSHCB = ''
        ,drveeRepModUNUMCover = ''
        ,drvSPFirstName = connamefirst
        ,drvSPLastName = connamelast
        ,drvSPDOB = condateofbirth
        ,drvSPGender = congender
        ,drvInsrdFirstPrimBenFirstName = ''
        ,drvInrsdFirstPrimBenLastName = ''
        ,drvInsrdFirstPrimBenRelationship = ''
        ,drvInsrdFirstPrimBenSplit = ''
        ,drvInsrdSecndPrimBenFirstName = ''
        ,drvInsrdSecndPrimBenLastName = ''
        ,drvInsrdSecndPrimBenRelationship = ''
        ,drvInsrdSecndPrimBenSplit = ''
        ,drvInsrdThirdPrimBenFirstName = ''
        ,drvInsrdThirdPrimBenLastName = ''
        ,drvInsrdThirdPrimBenRelationship = ''
        ,drvInsrdThirdPrimBenSplit = ''
        ,drvInsrdFourthPrimBenFirstName = ''
        ,drvInsrdFourthPrimBenLastName = ''
        ,drvInsrdFourthPrimBenRelationship = ''
        ,drvInsrdFourthPrimBenSplit = ''
    INTO dbo.U_EUNUM_drvTbl
    FROM dbo.U_EUNUM_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = xEEID 
        AND EedCoID = xCoID
        AND EedFormatCode = @FormatCode 
        AND EedValidForExport = 'Y'
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
ALTER VIEW dbo.dsi_vwEUNUM_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EUNUM_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EUNUM%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202006301'
       ,expStartPerControl     = '202006301'
       ,expLastEndPerControl   = '202007079'
       ,expEndPerControl       = '202007079'
WHERE expFormatCode = 'EUNUM';

**********************************************************************************/
