CREATE PROCEDURE [dbo].[dsi_bdm_sp_CalculateBenefitAmounts] @FormatCode VARCHAR(10)  
AS  
SET NOCOUNT ON;  
  
/************************************************************  
  
dsi_bdm_sp_CalculateBenefitAmounts  
  
Created By: Vinny Kelly  
Create Date: 07/18/2013  
  
Purpose: Calculates benefit deduction amounts based on the parameters below.  
  
NOTE TO SUPPORT: this stored procedure is one of a standard set of DSI procedures. Please do not make any changes  
to this procedure without Going through the Data Services team. Any changes made to this procedure will be wiped out  
if/when the standard DSI code is reinstalled on this database.  
  
Revision History  
----------------  
Version   Update By         Date   Descr  
1.01      VKelly   2013/08/07  Fixed Calculation Rule error for Expression Calculation Rule  
1.02      VKelly   2014/04/30  Added Dependent Benefit Age Graded rate Option - to calculate off Dependents Date of Birth, instead of EE's Date of Birth  
1.03   VKelly   2014/07/10  Added Employee Elected Rate or Pct - to calculate off of Employee Deduction code, versus Deduction Code setup table  
1.04   VKelly   2014/12/22  Fixed Age Graded Rate to support Fixed plan date  
1.05   VKelly   2015/10/09  Added Option to Skip Age Graded Rate portion of Calculation, but retain other parts of the rule  
1.06   VKelly   2016/11/23  Added RunID to allow multiple sessions to execute from BDM, and retain the correct Benefit Amount if different between sessions.  
1.07   TLeonce   2017/07/07  Add Insurance Rate Calculations (dbo.InsRate) / Add BcaEEAmt and BcaERAmt Fields to table  
1.07b   VKelly   2017/07/10  Correct Insurance Rate Calculations (dbo.InsRate) for BcaEEAmt and BcaERAmt Fields to table  
1.07c   VKelly   2017/10/02  Fixed Bug related to Date of Birth used for Insurance Rate calculation (Date as of, for calcuation purposes)  
1.07d   VKelly   2017/10/03  Added feature to custom control Date for Insurance Rate calculation (Date as of, for calcuation purposes)  
1.08   VKelly   2017/10/20  Added feature to skip Rounding Rules after calculation has been performed.  
1.09   VKelly   2018/02/15  Expanded EE/ER Rate Calculation Rules to include (99, 30 & 20) - 99 = None, 30 = Benefit Amount * Rate, 20 = Flat Amount  
1.09b   VKelly   2018/06/11  Fixed EE/ER Rate Calculation Rules for Flat Amount (20)  
1.09c   VKelly   2018/06/13  Fixed EE/ER Rate Calculation Rules for Benefit Amount * Dependent Age Graded Rate Rule (32)  
1.09d   VKelly   2018/06/15  Fixed InsRate Calculation Rules to ensure only current rate rules apply in calculation  
1.09e   VKelly   2018/08/21  Fixed Age Calculation to correctly calculate EE/Dependents age, to get them in proper rate calc rule  
1.09f   VKelly   2018/09/05  Removed Requirement for ValidForExport results in BDM to use BCA (to include Waived coverage in some instances)  
************************************************************/  
BEGIN  
  
 --====================================================  
 -- Declare variables  
 --====================================================  
 DECLARE @DependentBenefitAgeGradedRate VARCHAR(1);  
 DECLARE @DependentAgeGradedDedCodes VARCHAR(8000);  
 DECLARE @EmployeeElectedRateorPct VARCHAR(1);  
 DECLARE @EmployeeElectedRateorPctDedCodes VARCHAR(8000);  
 DECLARE @SkipAgeGradedRateCalcRule VARCHAR(1);  
 DECLARE @SkipAgeGradedRateCalcRuleDedCodes VARCHAR(8000);  
 DECLARE @SkipRoundingRuleDedCodes VARCHAR(8000);  
 DECLARE @RateEffDate DATETIME;  
 DECLARE @InsRateAsOfDateDedCodes VARCHAR(8000);  
 DECLARE @InsRateAsOfDateDedCodes2 VARCHAR(8000);  
 DECLARE @InsRateAsOfDateDedCodes3 VARCHAR(8000);  
 DECLARE @InsRateAsOfDateDedCodes4 VARCHAR(8000);  
 DECLARE @InsRateAsOfDateDedCodes5 VARCHAR(8000);  
 DECLARE @InsRateAsOfDateValues TABLE(  
  InsRateDedCode CHAR(5),  
  InsRateAsOfDate DATETIME  
 );  
  
 SELECT @DependentAgeGradedDedCodes = CONVERT(VARCHAR(1024), ParmValue) FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'DependentBenefitAgeGradedRate';  
 SELECT @DependentBenefitAgeGradedRate = 'Y' WHERE EXISTS (SELECT 1 FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'DependentBenefitAgeGradedRate');  
 SELECT @EmployeeElectedRateorPctDedCodes = CONVERT(VARCHAR(1024), ParmValue) FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'EmployeeElectedRateorPct';  
 SELECT @EmployeeElectedRateorPct = 'Y' WHERE EXISTS (SELECT 1 FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'EmployeeElectedRateorPct');  
 SELECT @SkipAgeGradedRateCalcRuleDedCodes = CONVERT(VARCHAR(1024), ParmValue) FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'SkipAgeGradedRateCalcRule';  
 SELECT @SkipAgeGradedRateCalcRule = 'Y' WHERE EXISTS (SELECT 1 FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'SkipAgeGradedRateCalcRule');  
 SELECT @SkipRoundingRuleDedCodes = CONVERT(VARCHAR(1024), ParmValue) FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'SkipRoundingRule';  
 SELECT @InsRateAsOfDateDedCodes = CONVERT(VARCHAR(1024), ParmValue1) FROM dbo.U_dsi_BDM_BCAConfiguration WHERE FormatCode = @FormatCode AND ParmName = 'InsRateAsOfDate';  
 SELECT @InsRateAsOfDateDedCodes = CONVERT(VARCHAR(1024), ParmValue1) FROM dbo.U_dsi_BDM_BCAConfiguration WHERE FormatCode = @FormatCode AND ParmName = 'InsRateAsOfDate2';  
 SELECT @InsRateAsOfDateDedCodes = CONVERT(VARCHAR(1024), ParmValue1) FROM dbo.U_dsi_BDM_BCAConfiguration WHERE FormatCode = @FormatCode AND ParmName = 'InsRateAsOfDate3';  
 SELECT @InsRateAsOfDateDedCodes = CONVERT(VARCHAR(1024), ParmValue1) FROM dbo.U_dsi_BDM_BCAConfiguration WHERE FormatCode = @FormatCode AND ParmName = 'InsRateAsOfDate4';  
 SELECT @InsRateAsOfDateDedCodes = CONVERT(VARCHAR(1024), ParmValue1) FROM dbo.U_dsi_BDM_BCAConfiguration WHERE FormatCode = @FormatCode AND ParmName = 'InsRateAsOfDate5';  
   
 SET @RateEffDate = ISNULL((SELECT CONVERT(DATETIME,ParmValue) FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'RateEffDate'),GETDATE());  
   
 SET @DependentAgeGradedDedCodes = dbo.dsi_BDM_fn_Trim(@DependentAgeGradedDedCodes);  
 SET @EmployeeElectedRateorPctDedCodes = dbo.dsi_BDM_fn_Trim(@EmployeeElectedRateorPctDedCodes);  
 SET @SkipAgeGradedRateCalcRuleDedCodes = dbo.dsi_BDM_fn_Trim(@SkipAgeGradedRateCalcRuleDedCodes);  
 INSERT INTO @InsRateAsOfDateValues (InsRateDedCode, InsRateAsOfDate)   
  SELECT Item, (SELECT CONVERT(DATETIME, ParmValue2) FROM dbo.U_dsi_BDM_BCAConfiguration WHERE FormatCode = @FormatCode AND ParmName = 'InsRateAsOfDate')  
  FROM dbo.dsi_BDM_fn_ListToTable(@InsRateAsOfDateDedCodes);  
 INSERT INTO @InsRateAsOfDateValues (InsRateDedCode, InsRateAsOfDate)   
  SELECT Item, (SELECT CONVERT(DATETIME, ParmValue2) FROM dbo.U_dsi_BDM_BCAConfiguration WHERE FormatCode = @FormatCode AND ParmName = 'InsRateAsOfDate2')  
  FROM dbo.dsi_BDM_fn_ListToTable(@InsRateAsOfDateDedCodes);  
 INSERT INTO @InsRateAsOfDateValues (InsRateDedCode, InsRateAsOfDate)   
  SELECT Item, (SELECT CONVERT(DATETIME, ParmValue2) FROM dbo.U_dsi_BDM_BCAConfiguration WHERE FormatCode = @FormatCode AND ParmName = 'InsRateAsOfDate3')  
  FROM dbo.dsi_BDM_fn_ListToTable(@InsRateAsOfDateDedCodes);  
 INSERT INTO @InsRateAsOfDateValues (InsRateDedCode, InsRateAsOfDate)   
  SELECT Item, (SELECT CONVERT(DATETIME, ParmValue2) FROM dbo.U_dsi_BDM_BCAConfiguration WHERE FormatCode = @FormatCode AND ParmName = 'InsRateAsOfDate4')  
  FROM dbo.dsi_BDM_fn_ListToTable(@InsRateAsOfDateDedCodes);  
 INSERT INTO @InsRateAsOfDateValues (InsRateDedCode, InsRateAsOfDate)   
  SELECT Item, (SELECT CONVERT(DATETIME, ParmValue2) FROM dbo.U_dsi_BDM_BCAConfiguration WHERE FormatCode = @FormatCode AND ParmName = 'InsRateAsOfDate5')  
  FROM dbo.dsi_BDM_fn_ListToTable(@InsRateAsOfDateDedCodes);  
  
 --====================================================  
 -- Load Deduction Codes into BDM Deduction Tables  
 --====================================================  
 ---------------------------------------------------------------------------------------------------------------  
 --Insert Deduction Code into BDM Deduction Tables, for exclusive use as Dependent Benefit Age Graded Rate   
 ---------------------------------------------------------------------------------------------------------------  
 INSERT INTO dbo.U_dsi_BDM_DeductionCodes (UdcFormatCode,UdcDedTarget,UDcDedCode,UdcDedType,UdcIsDomPartnerDed)  
 SELECT UdcFormatCode = @FormatCode  
  ,UdcDedTarget = 'DAG'  
  ,UDcDedCode = DedDedCode  
  ,UdcDedType = DedDedType  
  ,UdcIsDomPartnerDed = 'N'  
 FROM dbo.Dedcode  
 LEFT JOIN dbo.dsi_BDM_fn_ListToTable(@DependentAgeGradedDedCodes) d  
  ON d.item = DedDedCode  
 WHERE (d.item IS NOT NULL)  
 GROUP BY DedDedCode,DedDedType;  
  
 ---------------------------------------------------------------------------------------------------------------  
 --Insert Deduction Code into BDM Deduction Tables, for exclusive use as Employee Elected Rate   
 ---------------------------------------------------------------------------------------------------------------  
 INSERT INTO dbo.U_dsi_BDM_DeductionCodes (UdcFormatCode,UdcDedTarget,UDcDedCode,UdcDedType,UdcIsDomPartnerDed)  
 SELECT UdcFormatCode = @FormatCode  
  ,UdcDedTarget = 'EER'  
  ,UDcDedCode = DedDedCode  
  ,UdcDedType = DedDedType  
  ,UdcIsDomPartnerDed = 'N'  
 FROM dbo.Dedcode  
 LEFT JOIN dbo.dsi_BDM_fn_ListToTable(@EmployeeElectedRateorPctDedCodes) d  
  ON d.item = DedDedCode  
 WHERE (d.item IS NOT NULL)  
 GROUP BY DedDedCode,DedDedType;  
  
 ---------------------------------------------------------------------------------------------------------------  
 --Insert Deduction Code into BDM Deduction Tables, to skip Age Graded Rate Reduction Rule  
 ---------------------------------------------------------------------------------------------------------------  
 INSERT INTO dbo.U_dsi_BDM_DeductionCodes (UdcFormatCode,UdcDedTarget,UDcDedCode,UdcDedType,UdcIsDomPartnerDed)  
 SELECT UdcFormatCode = @FormatCode  
  ,UdcDedTarget = 'AGR'  
  ,UDcDedCode = DedDedCode  
  ,UdcDedType = DedDedType  
  ,UdcIsDomPartnerDed = 'N'  
 FROM dbo.Dedcode  
 LEFT JOIN dbo.dsi_BDM_fn_ListToTable(@SkipAgeGradedRateCalcRuleDedCodes) d  
  ON d.item = DedDedCode  
 WHERE (d.item IS NOT NULL)  
 GROUP BY DedDedCode,DedDedType;  
 ---------------------------------------------------------------------------------------------------------------  
 --Insert Deduction Code into BDM Deduction Tables, to skip Roudning Rules  
 ---------------------------------------------------------------------------------------------------------------  
 INSERT INTO dbo.U_dsi_BDM_DeductionCodes (UdcFormatCode,UdcDedTarget,UDcDedCode,UdcDedType,UdcIsDomPartnerDed)  
 SELECT UdcFormatCode = @FormatCode  
  ,UdcDedTarget = 'SRR'  
  ,UDcDedCode = DedDedCode  
  ,UdcDedType = DedDedType  
  ,UdcIsDomPartnerDed = 'N'  
 FROM dbo.Dedcode  
 LEFT JOIN dbo.dsi_BDM_fn_ListToTable(@SkipRoundingRuleDedCodes) d  
  ON d.item = DedDedCode  
 WHERE (d.item IS NOT NULL)  
 GROUP BY DedDedCode,DedDedType;  
  
 --========================================================  
 -- Calculate Benefit Amounts based on Calculation Rules  
 --========================================================  
  
 -- Clear Calculation Amounts by Format Code  
 DELETE dbo.U_dsi_bdm_BenCalculationAmounts WHERE BcaFormatCode = @FormatCode;  
  
 INSERT INTO dbo.U_dsi_bdm_BenCalculationAmounts (BcaFormatCode,BcaCoID,BcaEEID,BcaRunID,BcaDedCode,BcaBenAmt,BcaBenOption)  
 SELECT EedFormatCode  
  ,EedCoid  
  ,EedEEID  
  ,EedRunID  
  ,EedDedCode  
  ,EedBenAmt  
  ,EedBenOption  
 FROM dbo.u_dsi_bdm_EmpDeductions  
 WHERE EedFormatCode = @FormatCode;  
  
 INSERT INTO dbo.U_dsi_bdm_BenCalculationAmounts (BcaFormatCode,BcaCoID,BcaEEID,BcaDepRecID,BcaRunID,BcaDedCode,BcaBenAmt,BcaBenOption)  
 SELECT DbnFormatCode  
  ,dbo.dsi_BDM_fn_GetCurrentCOID(DbnEEID)  
  ,DbnEEID  
  ,DbnDepRecID  
  ,DbnRunID  
  ,DbnDedCode  
  ,DedEEBenAmt  
  ,DbnBenOption  
 FROM dbo.u_dsi_bdm_DepDeductions  
 WHERE DbnFormatCode = @FormatCode;  
  
 -----------------------------------------------------------------------------------  
 --Update Benefit Calculations Table with Deduction Code Benefit Amount Rules:  
 -----------------------------------------------------------------------------------  
 UPDATE dbo.U_dsi_bdm_BenCalculationAmounts  
 SET BcaBenAmtCalcRule = DedBenAmtCalcRule  
  ,BcaBenAmtRateOrPct = DedBenAmtRateOrPct  
  ,BcaEEBenAmt = DedEEBenAmt  
  ,BcaBenAmtPer = DedBenAmtPer  
  ,BcaBenAmtMax = DedBenAmtMax  
  ,BcaBenAmtRoundingRule = DedBenAmtRoundingRule  
  ,BcaUseCurrentAge = DedUseCurrentAge  
  ,BcaAgeAsOfDate = DedAgeAsOfDate  
  ,BcaUseBenReducSched = DedUseBenReducSched  
  ,BcaBenReducUseCurrentAge = DedBenReducUseCurrentAge  
  ,BcaBenReducAgeAsOfDate = DedBenReducAgeAsOfDate  
  ,BcaDedEECalcRateOrPct = DedEECalcRateOrPct  
  ,BcaDedEECalcRule = DedEECalcRule  
  ,BcaDedERCalcRateOrPct = DedERCalcRateOrPct  
  ,BcaDedERCalcRule = DedERCalcRule  
  ,BcaEEAmt = CASE WHEN DedEECalcRule = '99' THEN 0.00 ELSE NULL END  
  ,BcaERAmt = CASE WHEN DedERCalcRule = '99' THEN 0.00 ELSE NULL END  
 FROM dbo.U_dsi_bdm_BenCalculationAmounts  
 INNER JOIN dbo.dedcode  
  ON BcaDedCode = DeddedCode  
 WHERE BcaFormatCode = @FormatCode;  
  
 -----------------------------------------------------------------------------------  
 --Update Benefit Calculations Table with Employee Elected Benefit Amount Rules:  
 -----------------------------------------------------------------------------------  
 UPDATE dbo.U_dsi_bdm_BenCalculationAmounts  
 SET BcaBenAmtRateOrPct = eedBenAmtRateorPct  
 FROM dbo.U_dsi_bdm_BenCalculationAmounts  
 INNER JOIN dbo.U_dsi_bdm_EmpDeductions  
  ON BcaEEID = EedEEID  
  AND BcaCoID = EedCoID  
  AND EedFormatCode = BcaFormatCode  
  AND BcaDedCode = EedDedCode  
  AND EedRunID = bcaRunID  
 WHERE BcaDedCode IN (SELECT Udcdedcode FROM dbo.U_dsi_BDM_DeductionCodes WHERE UdcFormatCode = @FormatCode AND UdcDedTarget = 'EER')   
  AND BcaFormatCode = @FormatCode;  
  
 --=================================================================================  
 --Update Calculated Benefit Amount for Calc Rules: '20','30','40','41','42','43'  
 --=================================================================================  
 UPDATE dbo.U_dsi_bdm_BenCalculationAmounts  
 SET BcaBenAmtCalc = CASE WHEN BcaBenAmtCalcRule = '20' THEN 0  
        WHEN BcaBenAmtCalcRule = '30' THEN  
        CASE WHEN BcaBenAmt = 0 THEN BcaEEBenAmt  
          ELSE BcaBenAmt  
        END  
        WHEN BcaBenAmtCalcRule = '40' THEN --'Period Pay * Pct'  
        CASE WHEN EecSalaryOrHourly = 'S' THEN  
          CASE WHEN EecPayPeriod = 'B' THEN eecAnnSalary / 26  
            WHEN EecPayPeriod = 'S' THEN eecAnnSalary / 24  
            WHEN EecPayPeriod = 'M' THEN eecAnnSalary / 12  
            WHEN EecPayPeriod = 'W' THEN eecAnnSalary / 52  
          END  
         WHEN EecSalaryOrHourly = 'H' THEN EecHourlyPayRate * EecScheduledWorkHrs  
        END * BcaBenAmtRateOrPct  
        WHEN BcaBenAmtCalcRule = '41' THEN --'Weekly Pay * Pct'  
        CASE WHEN EecSalaryOrHourly = 'S' THEN (eecAnnSalary / 52)  
          WHEN EecSalaryOrHourly = 'H' AND EecPayPeriod = 'B' THEN EecHourlyPayRate * EecScheduledWorkHrs / 2  
          WHEN EecSalaryOrHourly = 'H' AND EecPayPeriod = 'W' THEN EecHourlyPayRate * EecScheduledWorkHrs  
          WHEN EecSalaryOrHourly = 'H' AND EecPayPeriod = 'M' THEN EecHourlyPayRate * (EecScheduledWorkHrs * 12) / 52  
          WHEN EecSalaryOrHourly = 'H' AND EecPayPeriod = 'S' THEN EecHourlyPayRate * (EecScheduledWorkHrs * 24) / 52  
        END * BcaBenAmtRateOrPct  
        WHEN BcaBenAmtCalcRule = '42' THEN --'Monthly Pay * Pct'  
        CASE WHEN EecSalaryOrHourly = 'S' THEN (eecAnnSalary / 12)  
          WHEN EecSalaryOrHourly = 'H' AND EecPayPeriod = 'B' THEN (EecHourlyPayRate * EecScheduledWorkHrs * 26) / 12  
          WHEN EecSalaryOrHourly = 'H' AND EecPayPeriod = 'S' THEN (EecHourlyPayRate * EecScheduledWorkHrs * 24) / 12  
          WHEN EecSalaryOrHourly = 'H' AND EecPayPeriod = 'W' THEN (EecHourlyPayRate * EecScheduledWorkHrs * 52) / 12  
          WHEN EecSalaryOrHourly = 'H' AND EecPayPeriod = 'M' THEN (EecHourlyPayRate * EecScheduledWorkHrs)  
        END * BcaBenAmtRateOrPct  
        WHEN BcaBenAmtCalcRule = '43' THEN --'Ann Salary * Rate'  
        CASE WHEN EecSalaryOrHourly = 'S' THEN eecAnnSalary  
          WHEN EecSalaryOrHourly = 'H' AND EecPayPeriod = 'B' THEN EecHourlyPayRate * EecScheduledWorkHrs * 26  
          WHEN EecSalaryOrHourly = 'H' AND EecPayPeriod = 'S' THEN EecHourlyPayRate * EecScheduledWorkHrs * 24  
          WHEN EecSalaryOrHourly = 'H' AND EecPayPeriod = 'W' THEN EecHourlyPayRate * EecScheduledWorkHrs * 52  
          WHEN EecSalaryOrHourly = 'H' AND EecPayPeriod = 'M' THEN EecHourlyPayRate * EecScheduledWorkHrs * 12  
        END * BcaBenAmtRateOrPct  
      END  
  ,BcaCalcRowStatus = 'Normal Calculation Rules applied'  
 FROM dbo.U_dsi_bdm_BenCalculationAmounts  
 INNER JOIN dbo.empcomp WITH (NOLOCK)  
  ON EecEEID = bcaeeid  
  AND EecCOID = bcacoid  
 WHERE BcaBenAmtCalcRule IN ('20','30','40','41','42','43')   
  AND BcaFormatCode = @FormatCode;  
  
 -----------------------------------------------------------------------------------  
 --Update Calculated Amount to be no greater than DedBenAmtMax  
 -----------------------------------------------------------------------------------  
 UPDATE dbo.u_dsi_bdm_BenCalculationAmounts  
 SET BcaBenAmtCalc = BcaBenAmtMax  
  ,BcaCalcRowStatus = 'Elected Amount exceeds DedBenAmtMax reduction rule triggered'  
 FROM dbo.u_dsi_bdm_BenCalculationAmounts  
 WHERE BcaBenAmtCalc > BcaBenAmtMax   
  AND BcaFormatCode = @FormatCode  
  AND BcaBenAmtMax <> 0.00;  
  
 --=================================================================================  
 -- Updates for Age Graded Rates - Benefit Reduction Table: dbo.BenReduc  
 --=================================================================================  
 -----------------------------------------------------------------------------------  
 --Update Calculated Amount if Age Graded Rate Applies  
 -----------------------------------------------------------------------------------  
 UPDATE dbo.u_dsi_bdm_BenCalculationAmounts  
 SET BcaBenAmtCalc = BcaBenAmtCalc - (BcaBenAmtCalc * RedReductionPct)  
  ,BcaCalcRowStatus = 'Age Graded Rate Benefit Amount reduction rule triggered on EEs Age'  
 FROM dbo.u_dsi_bdm_BenCalculationAmounts  
 INNER JOIN dbo.emppers WITH (NOLOCK)  
  ON Bcaeeid = EepEEID  
 INNER JOIN dbo.empcomp WITH (NOLOCK)  
  ON Bcaeeid = EecEEID  
  AND Bcacoid = EecCOID  
 INNER JOIN dbo.BenReduc WITH (NOLOCK)  
  ON reddedcode = BcaDedCode  
  --AND ((FLOOR(DATEDIFF(DAY, EepDateOfBirth, ISNULL(BcaBenReducAgeAsOfDate, GETDATE())) / 365.242199) >= RedMinAge)  
  -- AND (FLOOR(DATEDIFF(DAY, EepDateOfBirth, ISNULL(BcaBenReducAgeAsOfDate, GETDATE())) / 365.242199) < RedMaxAge)  
  --)  
  AND ((DATEDIFF(hour,EepDateOfBirth,ISNULL(BcaBenReducAgeAsOfDate,GETDATE()))/8766 >= RedMinAge)  
   AND (DATEDIFF(hour,EepDateOfBirth,ISNULL(BcaBenReducAgeAsOfDate,GETDATE()))/8766 < RedMaxAge)  
  )  
 WHERE BcaDedCode NOT IN (SELECT udcdedcode FROM dbo.U_dsi_BDM_DeductionCodes WHERE UdcFormatCode = @FormatCode AND UdcDedTarget = 'DAG')  
  AND BcaDedCode NOT IN (SELECT udcdedcode FROM dbo.U_dsi_BDM_DeductionCodes WHERE UdcFormatCode = @FormatCode AND UdcDedTarget = 'AGR')  
  AND EXISTS (SELECT 1 FROM dbo.BenReduc WHERE reddedcode = BcaDedCode)   
  AND BcaFormatCode = @FormatCode;  
  
 -----------------------------------------------------------------------------------  
 --Update Calculated Amount if Age Graded Rate Applies -  Dependent Age Graded Rates  
 -----------------------------------------------------------------------------------  
 UPDATE dbo.u_dsi_bdm_BenCalculationAmounts  
 SET BcaBenAmtCalc = BcaBenAmtCalc - (BcaBenAmtCalc * RedReductionPct)  
  ,BcaCalcRowStatus = 'Age Graded Rate Benefit Amount reduction rule triggered on Dependents Age'  
 FROM dbo.u_dsi_bdm_BenCalculationAmounts  
 INNER JOIN dbo.emppers WITH (NOLOCK)  
  ON Bcaeeid = EepEEID  
 INNER JOIN dbo.empcomp WITH (NOLOCK)  
  ON Bcaeeid = EecEEID  
  AND Bcacoid = EecCOID  
 INNER JOIN dbo.Contacts WITH (NOLOCK)  
  ON BcaEEID = ConEEID  
  AND BcaDepRecID = ConSystemID  
 INNER JOIN dbo.BenReduc WITH (NOLOCK)  
  ON reddedcode = BcaDedCode  
  --AND ((FLOOR(DATEDIFF(DAY, conDateOfBirth, ISNULL(BcaBenReducAgeAsOfDate, GETDATE())) / 365.242199) >= RedMinAge)  
  -- AND (FLOOR(DATEDIFF(DAY, conDateOfBirth, ISNULL(BcaBenReducAgeAsOfDate, GETDATE())) / 365.242199) < RedMaxAge)  
  --)  
  AND ((DATEDIFF(hour,ConDateOfBirth,ISNULL(BcaBenReducAgeAsOfDate,GETDATE()))/8766 >= RedMinAge)  
   AND (DATEDIFF(hour,ConDateOfBirth,ISNULL(BcaBenReducAgeAsOfDate,GETDATE()))/8766 < RedMaxAge)  
  )  
 WHERE BcaDedCode IN (SELECT udcdedcode FROM dbo.U_dsi_BDM_DeductionCodes WHERE UdcFormatCode = @FormatCode AND UdcDedTarget = 'DAG')  
  AND BcaDedCode NOT IN (SELECT udcdedcode FROM dbo.U_dsi_BDM_DeductionCodes WHERE UdcFormatCode = @FormatCode AND UdcDedTarget = 'AGR')  
  AND EXISTS (SELECT 1 FROM dbo.BenReduc WHERE reddedcode = BcaDedCode)   
  AND BcaFormatCode = @FormatCode;  
  
 -----------------------------------------------------------------------------------  
 --Update EE Age Graded Rate Amount, based on Spouse Life Amount Age Calculation:  
 -----------------------------------------------------------------------------------  
 UPDATE dbo.U_dsi_bdm_BenCalculationAmounts  
 SET BcaBenAmtCalc = dep.BcaBenAmtCalc  
  ,BcaCalcRowStatus = 'Age Graded Rate Benefit Amount reduction rule triggered on Dependents Age'  
 FROM dbo.u_dsi_bdm_BenCalculationAmounts  
 INNER JOIN (  
  SELECT bcaeeid eeid  
   ,bcacoid coid  
   ,BcaDedCode dedcode  
   ,BcaBenAmtCalc  
  FROM dbo.u_dsi_bdm_BenCalculationAmounts  
  WHERE BcaDepRecID IS NOT NULL  
  AND BcaDedCode IN (SELECT udcdedcode FROM dbo.U_dsi_BDM_DeductionCodes WHERE UdcFormatCode = @FormatCode AND UdcDedTarget = 'DAG')  
 ) dep  
  ON dep.eeid = BcaEEID  
  AND dep.coid = bcacoid  
  AND dep.dedcode = BcaDedCode  
 WHERE BcaDepRecID IS NULL AND BcaFormatCode = @FormatCode  
 AND BcaDedCode IN (SELECT udcdedcode FROM dbo.U_dsi_BDM_DeductionCodes WHERE UdcFormatCode = @FormatCode AND UdcDedTarget = 'DAG')  
 AND BcaDedCode NOT IN (SELECT udcdedcode FROM dbo.U_dsi_BDM_DeductionCodes WHERE UdcFormatCode = @FormatCode AND UdcDedTarget = 'AGR')  
 AND EXISTS (SELECT 1 FROM dbo.BenReduc WHERE reddedcode = BcaDedCode);  
  
 --=================================================================================  
 --Update Calculated Amount if Rounding Rule Applies  
 --=================================================================================  
 UPDATE dbo.u_dsi_bdm_BenCalculationAmounts  
 SET BcaBenAmtCalc = CASE WHEN BcaBenAmtRoundingRule = '10' THEN ROUND(BcaBenAmtCalc, 0) --'Normal to Nearest dollar'  
        WHEN BcaBenAmtRoundingRule = '11' THEN ROUND(BcaBenAmtCalc, - 1) --'Normal to Nearest Ten'  
        WHEN BcaBenAmtRoundingRule = '12' THEN ROUND(BcaBenAmtCalc, - 2) --'Normal to Nearest Hundred'  
        WHEN BcaBenAmtRoundingRule = '13' THEN ROUND(BcaBenAmtCalc, - 3) --'Normal to Nearest Thousand'  
        WHEN BcaBenAmtRoundingRule = '20' THEN CEILING(BcaBenAmtCalc) --'Up to Next dollar'  
        WHEN BcaBenAmtRoundingRule = '21' THEN CEILING(BcaBenAmtCalc / 10) * 10 --'Up to Next Ten'  
        WHEN BcaBenAmtRoundingRule = '22' THEN CEILING(BcaBenAmtCalc / 100) * 100 --'Up to Next Hundred'  
        WHEN BcaBenAmtRoundingRule = '23' THEN CEILING(BcaBenAmtCalc / 1000) * 1000 --'Up to Next Hundred'  
      END  
  ,BcaCalcRowStatus = 'Benefit Amount Rounding Rule Applied'  
 FROM dbo.u_dsi_bdm_BenCalculationAmounts  
 WHERE BcaBenAmtRoundingRule <> 'Z' AND BcaFormatCode = @FormatCode  
 AND BcaDedCode NOT IN (SELECT udcdedcode FROM dbo.U_dsi_BDM_DeductionCodes WHERE UdcFormatCode = @FormatCode AND UdcDedTarget = 'SRR');  
  
 --=================================================================================  
 -- Updates for Employee and Employer Amounts - Insurance Rates: dbo.InsRate  
 --=================================================================================  
  
 -- Clear Calculation Amounts by Format Code  
 DELETE dbo.U_dsi_bdm_bcaInsRate WHERE BcaInsFormatCode = @FormatCode;  
  
 INSERT INTO dbo.U_dsi_bdm_bcaInsRate (BcaInsFormatCode,bcaInsDedcode,bcaInsMinAge,bcaInsMaxAge,bcaInsEERateNSFemale,bcaInsEERateSMFemale,bcaInsEERateNSMale,bcaInsEERateSMMale,bcaInsERRateNSFemale  
  ,bcaInsERRateSMFemale,bcaInsERRateNSMale,bcaInsERRateSMMale,bcaInsEffDate,bcaInsPayFreq,bcaInsRowNum)  
 SELECT @FormatCode  
  ,Ratdedcode  
  ,RatMinAge  
  ,RatMaxAge  
  ,RatEERateNSFemale  
  ,RatEERateSMFemale  
  ,RatEERateNSMale  
  ,RatEERateSMMale  
  ,RatERRateNSFemale  
  ,RatERRateSMFemale  
  ,RatERRateNSMale  
  ,RatERRateSMMale  
  ,RatEffDate  
  ,RatPayFreq  
  ,ROW_NUMBER() OVER (PARTITION BY Ratdedcode,RatMinAge,RatPayFreq ORDER BY RatEffDate DESC) --Removed ,RatMaxAge from calc order sequence, if Rate structure ages change  
 FROM dbo.InsRate  
 WHERE RatDedCode IN (SELECT DISTINCT udcdedcode FROM dbo.U_dsi_BDM_DeductionCodes WHERE UdcFormatCode = @FormatCode)  
 AND RatEffDate <= @RateEffDate  
 GROUP BY RatDedCode  
  ,RatMinAge  
  ,RatMaxAge  
  ,RatEERateNSFemale  
  ,RatEERateSMFemale  
  ,RatEERateNSMale  
  ,RatEERateSMMale  
  ,RatERRateNSFemale  
  ,RatERRateSMFemale  
  ,RatERRateNSMale  
  ,RatERRateSMMale  
  ,Rateffdate  
  ,RatPayFreq;  
  
 DELETE dbo.U_dsi_bdm_bcaInsRate  
 FROM dbo.U_dsi_bdm_bcaInsRate  
 WHERE bcaInsRowNum <> 1 AND BcaInsFormatCode = @FormatCode;  
  
 DELETE dbo.U_dsi_bdm_bcaInsRate  
 FROM dbo.U_dsi_bdm_bcaInsRate C  
 INNER JOIN (SELECT bcaInsDedcode, MAX(bcaInsEffDate) Dt   
    FROM dbo.U_dsi_bdm_bcaInsRate   
    GROUP BY bcaInsDedcode) O ON O.bcaInsDedcode = C.bcaInsDedcode AND O.Dt <> C.bcaInsEffDate  
 WHERE bcaInsFormatCode = @FormatCode;  
    
  
 -----------------------------------------------------------------------------------  
 --Update Calculated Amount if Age Graded Rate Applies for Insurance Rate  
 -----------------------------------------------------------------------------------  
 UPDATE dbo.u_dsi_bdm_BenCalculationAmounts  
 SET BcaEEAmt = (CASE WHEN EepGender = 'M' AND EepIsSmoker = 'N' THEN bcaInsEERateNSMale  
       WHEN EepGender = 'M' AND EepIsSmoker = 'Y' THEN bcaInsEERateSMMale  
       WHEN EepGender = 'F' AND EepIsSmoker = 'N' THEN bcaInsEERateNSFemale  
       WHEN EepGender = 'F' AND EepIsSmoker = 'Y' THEN bcaInsEERateSMFemale  
     END) * (BcaBenAmtCalc / 1000)  
  ,BcaERAmt = (CASE WHEN EepGender = 'M' AND EepIsSmoker = 'N' THEN bcaInsERRateNSMale  
        WHEN EepGender = 'M' AND EepIsSmoker = 'Y' THEN bcaInsERRateSMMale  
        WHEN EepGender = 'F' AND EepIsSmoker = 'N' THEN bcaInsERRateNSFemale  
        WHEN EepGender = 'F' AND EepIsSmoker = 'Y' THEN bcaInsERRateSMFemale  
     END) * (BcaBenAmtCalc / 1000)  
 FROM dbo.u_dsi_bdm_BenCalculationAmounts  
 INNER JOIN dbo.emppers WITH (NOLOCK)  
  ON Bcaeeid = EepEEID  
 INNER JOIN dbo.empcomp WITH (NOLOCK)  
  ON Bcaeeid = EecEEID  
  AND Bcacoid = EecCOID  
 LEFT JOIN @InsRateAsOfDateValues E ON InsRateDedCode = BcaDedCode  
 INNER JOIN dbo.U_dsi_bdm_bcaInsRate WITH (NOLOCK)  
  ON bcaInsDedCode = BcaDedCode  
  AND bcaInsPayFreq = EecPayPeriod  
  --AND ((FLOOR(DATEDIFF(DAY, EepDateOfBirth, ISNULL(InsRateAsOfDate,ISNULL(BcaAgeAsOfDate, GETDATE()))) / 365.242199) >= bcaInsMinAge)  
  -- AND (FLOOR(DATEDIFF(DAY, EepDateOfBirth, ISNULL(InsRateAsOfDate,ISNULL(BcaAgeAsOfDate, GETDATE()))) / 365.242199) < bcaInsMaxAge)  
  --)  
  AND ((DATEDIFF(hour,EepDateOfBirth,ISNULL(InsRateAsOfDate,ISNULL(BcaAgeAsOfDate, GETDATE())))/8766 >= bcaInsMinAge)  
   AND (DATEDIFF(hour,EepDateOfBirth,ISNULL(InsRateAsOfDate,ISNULL(BcaAgeAsOfDate, GETDATE())))/8766 < bcaInsMaxAge)  
  )  
 WHERE EXISTS (SELECT 1 FROM dbo.U_dsi_bdm_bcaInsRate WHERE bcaInsDedCode = BcaDedCode AND BcaInsFormatCode = @FormatCode)  
  AND BcaDedEECalcRule <> 32  
  AND bcaFormatCode = @FormatCode;  
  
 UPDATE dbo.u_dsi_bdm_BenCalculationAmounts  
 SET BcaEEAmt = (CASE WHEN ConGender = 'M' AND ConIsSmoker = 'N' THEN bcaInsEERateNSMale  
       WHEN ConGender = 'M' AND ConIsSmoker = 'Y' THEN bcaInsEERateSMMale  
       WHEN ConGender = 'F' AND ConIsSmoker = 'N' THEN bcaInsEERateNSFemale  
       WHEN ConGender = 'F' AND ConIsSmoker = 'Y' THEN bcaInsEERateSMFemale  
     END) * (BcaBenAmtCalc / 1000)  
  ,BcaERAmt = (CASE WHEN ConGender = 'M' AND ConIsSmoker = 'N' THEN bcaInsERRateNSMale  
        WHEN ConGender = 'M' AND ConIsSmoker = 'Y' THEN bcaInsERRateSMMale  
        WHEN ConGender = 'F' AND ConIsSmoker = 'N' THEN bcaInsERRateNSFemale  
        WHEN ConGender = 'F' AND ConIsSmoker = 'Y' THEN bcaInsERRateSMFemale  
     END) * (BcaBenAmtCalc / 1000)  
 FROM dbo.u_dsi_bdm_BenCalculationAmounts  
 INNER JOIN dbo.emppers WITH (NOLOCK)  
  ON Bcaeeid = EepEEID  
 INNER JOIN dbo.empcomp WITH (NOLOCK)  
  ON Bcaeeid = EecEEID  
  AND Bcacoid = EecCOID  
 INNER JOIN dbo.Contacts WITH (NOLOCK)  
  ON BcaEEID = ConEEID  
  AND BcaDepRecID = ConSystemID  
 LEFT JOIN @InsRateAsOfDateValues E ON InsRateDedCode = BcaDedCode  
 INNER JOIN dbo.U_dsi_bdm_bcaInsRate WITH (NOLOCK)  
  ON bcaInsDedCode = BcaDedCode  
  AND bcaInsPayFreq = EecPayPeriod  
  --AND ((FLOOR(DATEDIFF(DAY, ConDateOfBirth, ISNULL(InsRateAsOfDate,ISNULL(BcaAgeAsOfDate, GETDATE()))) / 365.242199) >= bcaInsMinAge)  
  -- AND (FLOOR(DATEDIFF(DAY, ConDateOfBirth, ISNULL(InsRateAsOfDate,ISNULL(BcaAgeAsOfDate, GETDATE()))) / 365.242199) < bcaInsMaxAge)  
  --)  
  AND ((DATEDIFF(hour,ConDateOfBirth,ISNULL(InsRateAsOfDate,ISNULL(BcaAgeAsOfDate, GETDATE())))/8766 >= bcaInsMinAge)  
   AND (DATEDIFF(hour,ConDateOfBirth,ISNULL(InsRateAsOfDate,ISNULL(BcaAgeAsOfDate, GETDATE())))/8766 < bcaInsMaxAge)  
  )  
 WHERE BcaDepRecID IS NOT NULL  
  AND EXISTS (SELECT 1 FROM dbo.U_dsi_bdm_bcaInsRate WHERE bcaInsDedCode = BcaDedCode AND BcaInsFormatCode = @FormatCode)  
  AND BcaDedEECalcRule = 32  
  AND bcaFormatCode = @FormatCode;  
  
 --Copy Dependent Calculated Premium Up to EE record:  
 UPDATE dbo.U_dsi_bdm_BenCalculationAmounts  
 SET BcaEEAmt = dp.BcaEEAmt,  
  BcaERAmt = dp.BcaERAmt  
 FROM dbo.U_dsi_bdm_BenCalculationAmounts  
 JOIN (SELECT BcaEEID eeid, BcaCOID coid, BcaDedCode dedcode, BcaEEAmt, BcaERAmt  
  FROM dbo.U_dsi_bdm_BenCalculationAmounts  
  WHERE BcaFormatCode = @FormatCode   
   AND BcaDepRecID IS NOT NULL  
   AND BcaDedEECalcRule = 32) dp on dp.eeid = bcaeeid AND dp.coid = BcaCoID AND dp.dedcode = BcaDedCode  
 WHERE BcaDepRecID IS NULL   
  AND BcaFormatCode = @FormatCode;  
  
 --=================================================================================  
 -- Updates for Employee and Employer Amounts - Insurance Rates: dbo.OptRate  
 --=================================================================================  
  
 -- Clear Calculation Amounts by Format Code  
 DELETE dbo.U_dsi_bdm_bcaOptRate WHERE BcaORFormatCode = @FormatCode;  
  
 INSERT INTO dbo.U_dsi_bdm_bcaOptRate (bcaORFormatCode,bcaORDedcode,bcaORBenOption,bcaOREERate,bcaORERRate,bcaORPayFreq,bcaORRowNum)  
 SELECT @FormatCode  
  ,Cordedcode  
  ,Corbenoption  
  ,CorEERate  
  ,CorERRate  
  ,CorPayFreq  
  ,ROW_NUMBER() OVER (PARTITION BY cordedcode,corbenoption,corpayfreq ORDER BY CorEffDate DESC)  
 FROM dbo.optrate  
 WHERE CorDedCode IN (SELECT DISTINCT udcdedcode FROM dbo.U_dsi_BDM_DeductionCodes WHERE UdcFormatCode = @FormatCode)  
 AND CorEffDate <= @RateEffDate  
 GROUP BY CorDedCode  
  ,CorBenOption  
  ,coreffdate  
  ,CorEERate  
  ,CorERRate  
  ,CorPayFreq;  
  
 DELETE dbo.U_dsi_bdm_bcaOptRate  
 FROM dbo.U_dsi_bdm_bcaOptRate  
 WHERE bcaORRowNum <> 1 AND bcaORFormatCode = @FormatCode;  
  
 UPDATE dbo.u_dsi_bdm_BenCalculationAmounts  
 SET BcaEEAmt = bcaOREERate  
  ,BcaERAmt = bcaORERRate  
 FROM dbo.u_dsi_bdm_BenCalculationAmounts  
 INNER JOIN dbo.emppers WITH (NOLOCK)  
  ON Bcaeeid = EepEEID  
 INNER JOIN dbo.empcomp WITH (NOLOCK)  
  ON Bcaeeid = EecEEID  
  AND Bcacoid = EecCOID  
 INNER JOIN dbo.U_dsi_bdm_bcaOptRate WITH (NOLOCK)  
  ON BcaORDedCode = BcaDedCode  
  AND BcaORPayFreq = EecPayPeriod  
  AND BcaORBenOption = BcaBenOption  
 WHERE EXISTS (SELECT 1 FROM dbo.U_dsi_bdm_bcaOptRate WHERE bcaORDedCode = BcaDedCode AND bcaORFormatCode = @FormatCode);  
   
 --=================================================================================  
 -- Updates for Employee and Employer Amounts - Calculation Rule = Benefit Amount * Rate  
 --=================================================================================  
 UPDATE dbo.u_dsi_bdm_BenCalculationAmounts  
 SET BcaEEAmt = ISNULL((bcaBenAmtCalc/1000) * BcaDedEECalcRateOrPct,0.00)  
 FROM dbo.u_dsi_bdm_BenCalculationAmounts  
 WHERE BcaDedEECalcRule = '30' AND bcaFormatCode = @FormatCode;  
  
 UPDATE dbo.u_dsi_bdm_BenCalculationAmounts  
 SET BcaERAmt = ISNULL((bcaBenAmtCalc/1000) * BcaDedERCalcRateOrPct,0.00)  
 FROM dbo.u_dsi_bdm_BenCalculationAmounts  
 WHERE BcaDedERCalcRule = '30' AND bcaFormatCode = @FormatCode;  
  
 --=================================================================================  
 -- Updates for Employee and Employer Amounts - Calculation Rule = Flat Amount  
 --=================================================================================  
 UPDATE dbo.u_dsi_bdm_BenCalculationAmounts  
 SET BcaEEAmt = CASE WHEN EecPayPeriod = 'B' THEN dedEEBiWeeklyAmt  
      WHEN EecPayPeriod = 'W' THEN dedEEWeeklyAmt  
      WHEN EecPayPeriod = 'M' THEN dedEEMonthlyAmt  
      WHEN EecPayPeriod = 'S' THEN dedEESemiMonthlyAmt  
       END  
 FROM dbo.u_dsi_bdm_BenCalculationAmounts  
 INNER JOIN dbo.EmpComp WITH (NOLOCK)  
  ON EecEEID = bcaeeid  
  AND EecCOID = bcacoid  
 INNER JOIN dbo.DedCode WITH (NOLOCK)  
  ON BcaDedCode = DedDedCode  
 WHERE BcaDedEECalcRule = '20' AND bcaFormatCode = @FormatCode;  
  
 UPDATE dbo.u_dsi_bdm_BenCalculationAmounts  
 SET BcaERAmt = CASE WHEN EecPayPeriod = 'B' THEN dedERBiWeeklyAmt  
      WHEN EecPayPeriod = 'W' THEN dedERWeeklyAmt  
      WHEN EecPayPeriod = 'M' THEN dedERMonthlyAmt  
      WHEN EecPayPeriod = 'S' THEN dedERSemiMonthlyAmt  
       END  
 FROM dbo.u_dsi_bdm_BenCalculationAmounts  
 INNER JOIN dbo.EmpComp WITH (NOLOCK)  
  ON EecEEID = bcaeeid  
  AND EecCOID = bcacoid  
 INNER JOIN dbo.DedCode WITH (NOLOCK)  
  ON BcaDedCode = DedDedCode  
 WHERE BcaDedERCalcRule = '20' AND bcaFormatCode = @FormatCode;  
  
END;