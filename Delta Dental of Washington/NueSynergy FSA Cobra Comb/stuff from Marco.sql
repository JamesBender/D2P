select drveeid,drvEECiApprovedCoverageAmount, drvSPCiApprovedCoverageAmount,drvSpDateOfBirth,drvEEDateOfBirth,drvCoverageEffectiveDate,
	DateDiff(year,drvSpDateOfBirth,drvCoverageEffectiveDate) as SpsAge,
	DateDiff(year,drvEEDateOfBirth,drvCoverageEffectiveDate) as EmpAge,
	drvEmpSmoke,drvConSmoker,
	EmpPremAmount = (CASE WHEN drvEECiApprovedCoverageAmount IS NOT NULL THEN (
			CASE WHEN drvEmpSmoke = 'Y' and drvEEGender  = 'M' THEN ( 
                
Select Top 1 RatEERateSMMale from InsRate   where RatDedCode = 'CIEE' and  DateDiff(year,drvEEDateOfBirth,drvCoverageEffectiveDate) BETWEEN RatMinAge and RatMaxAge order by RatEffDate desc  )

				 WHEN drvEmpSmoke = 'Y' and drvEEGender  = 'F' THEN  ( Select Top 1 RatEERateSMFemale from InsRate   where RatDedCode = 'CIEE' and  DateDiff(year,drvEEDateOfBirth,drvCoverageEffectiveDate) BETWEEN RatMinAge and RatMaxAge order by RatEffDate desc  )
				 WHEN drvEmpSmoke = 'N' and drvEEGender  = 'M' THEN  ( Select Top 1 RatEERateNSMale from InsRate   where RatDedCode = 'CIEE' and  DateDiff(year,drvEEDateOfBirth,drvCoverageEffectiveDate) BETWEEN RatMinAge and RatMaxAge order by RatEffDate desc  )
				 WHEN drvEmpSmoke = 'N' and drvEEGender  = 'F' THEN  ( Select Top 1 RatEERateNSFemale from InsRate   where RatDedCode = 'CIEE' and  DateDiff(year,drvEEDateOfBirth,drvCoverageEffectiveDate) BETWEEN RatMinAge and RatMaxAge order by RatEffDate desc  )
			END
	* drvEECiApprovedCoverageAmount)
	END)
	,	SpsPremAmount = (CASE WHEN drvSPCiApprovedCoverageAmount IS NOT NULL THEN (
			CASE WHEN drvEmpSmoke = 'Y' and drvEEGender  = 'M' THEN ( Select Top 1 RatEERateSMMale from InsRate   where RatDedCode = 'CIEE' and  DateDiff(year,drvSpDateOfBirth,drvCoverageEffectiveDate) BETWEEN RatMinAge and RatMaxAge order by RatEffDate desc  )
				 WHEN drvEmpSmoke = 'Y' and drvEEGender  = 'F' THEN  ( Select Top 1 RatEERateSMFemale from InsRate   where RatDedCode = 'CIEE' and  DateDiff(year,drvSpDateOfBirth,drvCoverageEffectiveDate) BETWEEN RatMinAge and RatMaxAge order by RatEffDate desc  )
				 WHEN drvEmpSmoke = 'N' and drvEEGender  = 'M' THEN  ( Select Top 1 RatEERateNSMale from InsRate   where RatDedCode = 'CIEE' and  DateDiff(year,drvSpDateOfBirth,drvCoverageEffectiveDate) BETWEEN RatMinAge and RatMaxAge order by RatEffDate desc  )
				 WHEN drvEmpSmoke = 'N' and drvEEGender  = 'F' THEN  ( Select Top 1 RatEERateNSFemale from InsRate   where RatDedCode = 'CIEE' and  DateDiff(year,drvSpDateOfBirth,drvCoverageEffectiveDate) BETWEEN RatMinAge and RatMaxAge order by RatEffDate desc  )
			END
	* drvSPCiApprovedCoverageAmount)
	END)
 from U_EKECACHEXP_drvTbl where drvBenefitElected not IN('VAI','VHC')