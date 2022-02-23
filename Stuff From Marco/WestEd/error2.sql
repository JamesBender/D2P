**********Start Switchbox**********
@ExportCode: ONDEMAND
@FormatCode: ESPAWED401
@AscFileName: \\us.saas\EZ\Public\USG1000\Exports\ESPAWED401_20190909.txt
@COID:      
@COIDAllCompanies:  
@StartPerControl: 201909091
@EndPerControl: 201909099
@SelectByField:                          
@SelectByList:                                                                                                                                                                                                                                                                
@SystemID: CVVDKC03L010
@TaxCalcGroupID:      
@COIDList: 
**********************************
Export is not locked, begin executing...
dsi_sp_SwitchBox_v2 ESPAWED401 Sep  9 2019  4:55PM           
@PathtoUse: OnDemandPath
@exportpath: 
  BuildDriverTables_v2 ESPAWED401
dsi_sp_BuildDriverTables_ESPAWED401 'CVVDKC03L010'
 
*** dsi_BDM_sp_PopulateDeductionsTable ***
 
Version:                             1.30
Table type:                          Employee & Dependent
Run type:                            Regular run
Dedcodes:                            MED,DEN,VIS
Dedtypes:                            
Term selection option:               Date benefit stop date is keyed into audit
Start date time:                     Sep  9 2019 12:00AM
End date time:                       Sep  9 2019 11:59PM
Exclude future start dates:          
Num days to show future start dates: 0
Exclude future stop dates:           
Num days to show future stop dates:  0
Benefits start date:                 EedBenStartDate
 
0 records inserted into dbo.U_dsi_BDM_EEList
 
 
0 employee records inserted into dbo.U_dsi_BDM_Audit
 
0 employee records inserted into dbo.U_dsi_BDM_Audit_Future
 
0 dependent records inserted into dbo.U_dsi_BDM_Audit
 
0 dependent records inserted into dbo.U_dsi_BDM_Audit_Future
 
17 valid employee deductions in dbo.U_dsi_BDM_EmpDeductions
7 valid dependent deductions in dbo.U_dsi_BDM_DepDeductions
 
Type       Reason invalidated                                                          Count
----       --------------------------------------------------------------------------- -----
Employee   Deduction start date = end date                                             22
Employee   Deduction termed                                                            11
Dependent  Deduction termed                                                            8
Dependent  Deduction waived                                                            2
 
Elapsed Time
------------
Days    = 0
Hours   = 0
Minutes = 0
Seconds = 0.527
 
  ESPAWED401_Collect
  ESPAWED401_CreateRecordSet_v2 D10
  ESPAWED401_DataDefinition_v2D10
INSERT into dbo.U_ESPAWED401_File (RecordSet, InitialSort, SubSort, Subsort2, Subsort3, Data) SELECT 'D10',ISNULL(ISNULL(drvInitialSort,''),''),ISNULL(2,''),ISNULL(2,''),ISNULL(2,''),''+
            RTRIM(LEFT(ISNULL(drvRecordId,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvEmployerName,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvEmployerEin,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvEmployerPlanId,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvSubPlanId,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvOrigVendorPlanId,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvOrigVendorSubPlanId,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvRecipientVendorPlanId,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvRecipientVendorSubPlanId,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvTypeOfAccount,''),50)) + '|'+
            RTRIM(LEFT(LTRIM(STR(ISNULL(drvPayrollFrequency,0),50,2)),50)) + ','+
            RTRIM(LEFT(LTRIM(STR(ISNULL(drvEmployeeSSN,0),50,2)),50)) + ','+
            RTRIM(LEFT(LTRIM(STR(ISNULL(drvEmployeeID,0),50,2)),50)) + ','+
            RTRIM(LEFT(LTRIM(STR(ISNULL(drvEmployeeTitile,0),50,2)),50)) + ','+
            RTRIM(LEFT(LTRIM(STR(ISNULL(drvEmpFirstName,0),50,2)),50)) + ','+
            RTRIM(LEFT(ISNULL(drvEmpMiddleName,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvEmpLastName,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvAddressLine1,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvAddressLine2,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvAddressLine3,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvCity,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvState,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvZip,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvCountryCode,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvResidenceCode,''),50)) + '|'+
            RTRIM(LEFT(CASE WHEN drvDateOfBirth IS NULL THEN SPACE(50) ELSE CONVERT(CHAR(50), drvDateOfBirth,112) end,50)) + '|'+
            RTRIM(LEFT(ISNULL(drvGender,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvMarialStatus,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvPhoneNumber1,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvPhoneNumberType1,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvPhoneExt1,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvPhoneNumber2,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvPhoneNumberType2,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvPhoneExt2,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvEmailAddress,''),50)) + '|'+
            RTRIM(LEFT(CASE WHEN drvPayrollDate IS NULL THEN SPACE(50) ELSE CONVERT(CHAR(50), drvPayrollDate,112) end,50)) + '|'+
            RTRIM(LEFT(ISNULL(drvContribSourceCode1,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvContribSourceAmt1,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvContribSourceCode2,''),50)) + '|'+
            RTRIM(LEFT(CASE WHEN drvContribSourceAmt2 IS NULL THEN SPACE(50) ELSE CONVERT(CHAR(50), drvContribSourceAmt2,101) end,50)) + ','+
            RTRIM(LEFT(ISNULL(drvContribSourceCode3,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvContribSourceAmt3,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvContribSourceCode4,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvContribSourceAmt4,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvContribSourceCode5,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvContribSourceAmt5,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvContribSourceCode6,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvContribSourceAmt6,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvContribSourceCode7,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvContribSourceAmt7,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvContribSourceCode8,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvContribSourceAmt8,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvLoanNumber1,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvLoanRepaymentAmt1,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvLoanNumber2,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvLoanRepaymentAmt2,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvLoanNumber3,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvLoanRepaymentAmt3,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvLoanNumber4,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvLoanRepaymentAmt4,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvLoanNumber5,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvLoanRepaymentAmt5,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvLocationCode,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvSubArea,''),50)) + '|'+
            RTRIM(LEFT(CASE WHEN drvDateOfHire IS NULL THEN SPACE(50) ELSE CONVERT(CHAR(50), drvDateOfHire,112) end,50)) + '|'+
            RTRIM(LEFT(CASE WHEN drvAdjDateOfHire IS NULL THEN SPACE(50) ELSE CONVERT(CHAR(50), drvAdjDateOfHire,112) end,50)) + '|'+
            RTRIM(LEFT(ISNULL(drvEmploymentStatus,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvEmploymentSubType,''),50)) + '|'+
            RTRIM(LEFT(CASE WHEN drvEmpoymentStatusDate IS NULL THEN SPACE(50) ELSE CONVERT(CHAR(50), drvEmpoymentStatusDate,112) end,50)) + '|'+
            RTRIM(LEFT(ISNULL(drvEmployeeType,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvPayrollMode,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvYearsOfService,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvAnnualSalary,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvExcludableCompensation,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvPerPayCompensation,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvPerHoursWorked,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvYTDType,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvYTDBaseCompensation,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvYTDTotalCompensation,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvYTDHoursWorked,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvHCEFlag,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvKeyEmployeeFlag,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvAeExclusionFlag,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvEmployePlanStatus,''),50)) + '|'+
            RTRIM(LEFT(CASE WHEN drvPlanEntryDate IS NULL THEN SPACE(50) ELSE CONVERT(CHAR(50), drvPlanEntryDate,112) end,50)) + '|'+
            RTRIM(LEFT(CASE WHEN drvPlanVestedDate IS NULL THEN SPACE(50) ELSE CONVERT(CHAR(50), drvPlanVestedDate,112) end,50)) + '|'+
            RTRIM(LEFT(CASE WHEN drvAdjustmentEndDate IS NULL THEN SPACE(50) ELSE CONVERT(CHAR(50), drvAdjustmentEndDate,112) end,50)) + '|'+
            RTRIM(LEFT(ISNULL(drvContribSourceCodeOne,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvDeferallPercentage1,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvPayperDefAmount1,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvContribSourceCodeTwo,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvDeferallPercentage2,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvPayperDefAmount2,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvContribSourceCodeThree,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvDeferallPercentage3,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvPayperDefAmount3,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvPlanAnnualSalary,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvContribEligSource1,''),50)) + '|'+
            RTRIM(LEFT(CASE WHEN drvContribEligDate1 IS NULL THEN SPACE(50) ELSE CONVERT(CHAR(50), drvContribEligDate1,112) end,50)) + '|'+
            RTRIM(LEFT(ISNULL(drvContribEligSource2,''),50)) + '|'+
            RTRIM(LEFT(CASE WHEN drvContribEligDate2 IS NULL THEN SPACE(50) ELSE CONVERT(CHAR(50), drvContribEligDate2,112) end,50)) + '|'+
            RTRIM(LEFT(ISNULL(drvAutoDefIncType,''),50)) + '|'+
            RTRIM(LEFT(CASE WHEN drvAutoDefIncElecDate IS NULL THEN SPACE(50) ELSE CONVERT(CHAR(50), drvAutoDefIncElecDate,112) end,50)) + '|'+
            RTRIM(LEFT(CASE WHEN drvAutoDefIncNextElecDate IS NULL THEN SPACE(50) ELSE CONVERT(CHAR(50), drvAutoDefInc
  FROM dbo.U_ESPAWED401_drvTbl
Msg 207, Level 16, State 1, Line 141
Invalid column name 'drvAutoDefIncFreq1'.
  ESPAWED401_CreateRecordSet_v2 H01
  ESPAWED401_DataDefinition_v2H01
INSERT into dbo.U_ESPAWED401_File (RecordSet, InitialSort, SubSort, Subsort2, Subsort3, Data) SELECT 'H01',ISNULL(1,''),ISNULL(1,''),ISNULL(1,''),ISNULL(1,''),''+
            RTRIM(LEFT(ISNULL(drvHeader,''),6)) + '|'+
            RTRIM(LEFT(ISNULL(drvDataTYpe,''),2)) + '|'+
            RTRIM(LEFT(ISNULL(drvDataSource,''),30)) + '|'+
            RTRIM(LEFT(ISNULL(drvCreationDateTime,''),15)) + '|'+
            RTRIM(LEFT(LTRIM(STR(ISNULL(drvContact,0),40,2)),40)) + ','+
            RTRIM(LEFT(LTRIM(STR(ISNULL(drvSender,0),40,2)),40)) + ','+
            RTRIM(LEFT(ISNULL(drvSparkVersion,''),4)) + '|'+
            RTRIM(LEFT(CASE WHEN drvAsOfDate IS NULL THEN SPACE(8) ELSE CONVERT(CHAR(8), drvAsOfDate,112) end,8)) + '|'+
            RTRIM(LEFT(CASE WHEN drvPlanStartDate IS NULL THEN SPACE(8) ELSE CONVERT(CHAR(8), drvPlanStartDate,112) end,8))
  FROM dbo.U_ESPAWED401_Header
  ESPAWED401_CreateRecordSet_v2 T90
  ESPAWED401_DataDefinition_v2T90
INSERT into dbo.U_ESPAWED401_File (RecordSet, InitialSort, SubSort, Subsort2, Subsort3, Data) SELECT 'T90',ISNULL(9999,''),ISNULL(9999,''),ISNULL(9999,''),ISNULL(9999,''),''+
            RTRIM(LEFT(ISNULL(drvTrailer,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvRecordCount,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvRemittanceAmount,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvLoanAmountTotal,''),50)) + '|'+
            RTRIM(LEFT(ISNULL(drvFiller,''),50))
  FROM dbo.U_ESPAWED401_Trailer
Export File Out
INSERT INTO dbo.U_dsi_Count_v2(cntFormatcode,cnt) SELECT cntFormatcode = 'ESPAWED401', cnt = count(*) FROM dbo.U_ESPAWED401_File WITH (NOLOCK) WHERE 1 = 1
bcp ULTIPRO_YOSHI.dbo.dsi_vwESPAWED401_Export out "\\us.saas\EZ\Public\USG1000\Exports\ESPAWED401_20190909.txt" -T -S"EZ2SUP4DB01" -c -t
Export Completed, Unlocking...
