USE [ULTIPRO_WPWADEN]
GO
/****** Object:  StoredProcedure [dbo].[dsi_sp_BuildDriverTables_ECIG3KWDEN]    Script Date: 1/18/2021 2:05:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	


/* 
delete from dbo.U_dsi_TOC
  where tocItem = 'dsi_sp_BuildDriverTables_ECIG3KWDEN'
insert into dbo.U_dsi_TOC(tocItem, tocLastUpdated, tocType, tocVersion)
  select 'dsi_sp_BuildDriverTables_ECIG3KWDEN','04/23/2012','P','V1.RKM'
*/

/*
--3 records
begin tran
insert into dbo.u_dsi_sqlclauses (formatcode,recordset,fromclause,whereclause)
select 'ECIG3KWDEN',recordset,replace(fromclause,'ECIGNA3KCI','ECIG3KWDEN'),whereclause
from dbo.u_dsi_sqlclauses
where formatcode = 'ECIGNA3KCI'
ROLLBACK
commit
*/



ALTER  PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECIG3KWDEN]
 @systemid varchar(12) = ''
AS
Begin


/*************************************************************************************************
DRIVER TABLE SP FOR:  CIGNA LADE (add, std,ltd,life) 3K full file
BUILT FOR: Washington Dental Services
ORIGINAL BUILD (V-1.0):04/23/2012 - Rachel Munnerlyn   - 731371

Updated: Grisell Jaffe   4/1/15    SF 05075035   Updated annual hours drvAccrualAnnHrs which was previously set to null
Sean Hawkins	02/13/2018	SR-2017-00177913	Updated to correct term date logic and adding supervisor email addresses
												Updated to move employee email address for 50 characters to field 130
												Only for ETEST session at this time, will move to make permanent when ready
				02/20/2018						Updates made permanent for SR-2017-177913	
Sean Hawkins	03/19/2018	SR-2017-00177913	Small update for item #25 and hardcode ulti email address for item #284 - ETEST only at this point
				03/19/2018						Updates now permanent
*************************************************************************************************/

-- Collect the @Start and @End Percontrol/PayDates upfront

	/***************************
	COLLECT DATE PARAMETERS
	****************************/
	DECLARE 
		@StartDate DATETIME,
		@EndDate DATETIME,
		@StartPerControl Char(9),
		@EndPerControl Char(9),
		@FormatCode Char(10),
		@ExportCode Char(10),
		@ExportFile char(200)
		
	--	Declare @Systemid char(12) 
	--	set @Systemid = '6DWPQL0000K0'

	SELECT 
		@StartDate = CONVERT(DATETIME, LEFT(StartPerControl, 8) ),
		@EndDate = CONVERT(DATETIME, LEFT(EndPerControl , 8)  ),
		@StartPerControl = startpercontrol,
		@EndPerControl  = endpercontrol,
		@FormatCode = rtrim(formatcode),
		@ExportCode = rtrim(Exportcode),
		@Exportfile = ExportFile
	FROM dbo.U_Dsi_Parameters 
	WHERE SystemID = @SystemID


-- dedcodes
 
declare @DedList varchar(200) 
select @DedList = 'x'

	IF OBJECT_ID('U_ECIG3KWDEN_DedList') IS NOT NULL
 	DROP TABLE dbo.U_ECIG3KWDEN_DedList

	select dccode = item, dctype = deddedtype
		into dbo.U_ECIG3KWDEN_DedList
	from dbo.fn_ListToTable(@DedList)
	join dedcode on deddedcode = item


		
-- change variables below as needed
declare @daysstopped int   
declare @useaudit char(1)
declare @includeoe char(1)

declare @showalldeds char(1)
declare @allcomp char(1)
declare @onerecperemp char(1)
declare @showstoppedoe  char(1)
declare @oetype char(1)
set @daysstopped = 31	-- set number of days if looking for only showing deds stopped within certain days
set @useaudit = 'N'    -- Y or N  indicates if this export uses audit to determine data to pull
set @includeoe = 'N'   -- Y or N  indicates if this export will include open enrollment
set @showalldeds = 'N' -- Y or N  indicates if this export shows stopped and active ded of same type
set @allcomp = 'Y'     -- Y or N  indicates if this export pull deds for all companies for an employee
set @onerecperemp = 'Y'  -- Y or N indicate if the export should show only one record per employee
set @showstoppedoe = 'N' -- Y or N  indicates if stopped open enrollment deductions should be shown
set @oetype = 'F'		-- P or F indicates if this export is for a passive or full(active) oe


-- clean up EELIST if needed

-- clean up list if not using all companies
if @allcomp = 'N'
begin
			delete dbo.u_ECIG3KWDEN_EELIST
			from dbo.u_ECIG3KWDEN_EELIST
			join vw_int_EmpComp t with (nolock) on xeeid = eeceeid and xcoid = eeccoid
			where t.eecemplstatus = 'T'
			and exists(select 1 from vw_int_EmpComp a where a.eeceeid = t.eeceeid
				and a.eecemplstatus <> 'T')

end



--  remove old terms
	
--			delete dbo.u_ECIG3KWDEN_EELIST
--			from dbo.u_ECIG3KWDEN_EELIST
--			join vw_int_EmpComp t with (nolock) on xeeid = eeceeid and xcoid = eeccoid
--			where t.eecemplstatus = 'T'
----			and eecdateoftermination + @daysstopped < getdate()




--BDM

DELETE FROM U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode

INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'DedCodes','LTD,ELTD,STD,GLIFE,GADD,LIFEE,LIFES,LIFEC')
IF @ExportCode <> 'EGICOE' BEGIN
	INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'StartDateTime',@EndDate - @daysstopped)
	INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'EndDateTime',@EndDate)
END
IF @ExportCode = 'EGICOE' BEGIN
	INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'StartDateTime',@StartDate)
	INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'EndDateTime',@EndDate)
END

INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'TermSelectionOption', 'stopdate')	--'ActiveOnly')	--'stoptdate')	--'AuditDate')

IF @ExportCode = 'EGICOE' BEGIN
   INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'Passive')	--'Active')
END


EXEC dbo.dsi_bdm_sp_PopulateDeductionsTable @FormatCode


--select * from dbo.U_dsi_bdm_EmpDeductions where eedformatcode = 'ECIG3KWDEN'





-- Clean up eelist if needed to only include employees with deductions

			delete dbo.u_ECIG3KWDEN_eelist
			from dbo.u_ECIG3KWDEN_eelist a
			where not exists(select 1 from U_dsi_bdm_EmpDeductions 
				where a.xeeid = eedeeid	and a.xcoid = eedcoid
				and EedFormatCode = @FormatCode
				and eedvalidforexport = 'Y')


-- Clean up eelist if only one record per employee
if @onerecperemp = 'Y'
begin
			delete dbo.u_ECIG3KWDEN_EELIST
			from dbo.u_ECIG3KWDEN_EELIST
			join vw_int_EmpComp t with (nolock) on xeeid = eeceeid and xcoid = eeccoid
			where t.eecemplstatus = 'T'
			and exists(select 1 from vw_int_EmpComp a where a.eeceeid = t.eeceeid
				and a.eecemplstatus <> 'T')

			delete dbo.u_ECIG3KWDEN_eelist
			from dbo.u_ECIG3KWDEN_eelist a
			join emppers with (nolock) on xeeid = eepeeid
			where eephomecoid <> xcoid
			and exists(select 1 from dbo.u_ECIG3KWDEN_eelist b where a.xeeid = b.xeeid
			having count(*) > 1)
end

--last 12 month Earning History
if object_id('U_dsi_ECIG3KWDEN_EarnHist') is not null
  drop table dbo.U_dsi_ECIG3KWDEN_EarnHist

SELECT
	xEEID eeeid,
	xCOID ecoid,
--	pehearncode eearncode,
	SUM(ISNULL(pehCurAmt,0.00))*100 AS eamt,
	SUM(ISNULL(pehCurHrs,0.00)) AS ehrs  

	INTO dbo.U_dsi_ECIG3KWDEN_EarnHist
		from dbo.u_ECIG3KWDEN_EELIST 
	JOIN vw_int_PEarHist (nolock) ON xeeid = pehEEID and xCOID = PehCOID
		 and CONVERT(DATETIME, LEFT(pehPerControl , 8)  ) BETWEEN DATEADD(month, -12, @EndDate) and @EndDate
--		AND substring(pehPerControl,1,4) = substring(@EndPerControl,1,4)
	where PehEarnCode='REG'
	GROUP BY xEEID,xCOID--,pehearncode


--select * from vw_int_PEarHist
--select * from U_dsi_ECIG3KWDEN_EarnHist

--List of key employees (top 10% by salary) client doesn't want to use Key employee field from Ultipro
if object_id('U_dsi_ECIG3KWDEN_KeyEmps') is not null
  drop table dbo.U_dsi_ECIG3KWDEN_KeyEmps

select TOP 10 percent with ties
eeceeid as keyeeid,
eeccoid as keycoid,
eecannsalary  as keysalary

INTO dbo.U_dsi_ECIG3KWDEN_KeyEmps
from dbo.u_ECIG3KWDEN_eelist
join vw_int_EmpComp on xeeid = eeceeid and xcoid = eeccoid
order by eecannsalary desc

-- Populate Source for Employees
if object_id('U_dsi_ECIG3KWDEN_drvTbl') is not null
  drop table dbo.U_dsi_ECIG3KWDEN_drvTbl

-- EE Detail

  select 
	drvEEID = xEEID, 
	drvcoid = xcoid,
	drvdepid = cast(null as varchar),
	drvrectype = 'E',
--	drvdedcode = dedcode,
-- standard fields above and additional driver fields below
	drvSSN = eepssn,
	drvEmpNo = eecempno,
	drvBillingLoc = '0000',
	drvCompanyNo = '000021603',
	drvGroupID = '000013449',
	drvClassCode = '001',
	drvClassChangeDate = null,
	drvNameLast = eepnamelast,
	drvNameFirst = eepnamefirst,
	drvNameMiddle = eepnamemiddle,
	drvNamePrefix = '',
	drvNameSuffix = eepnamesuffix,
	drvDOB = eepdateofbirth,
	drvGender = eepgender,
	drvMaritalStat = case when eepmaritalstatus = 'S' then 'I' 
						when eepmaritalstatus = 'Z' then 'K'
						when eepmaritalstatus is null then 'K'
					else eepmaritalstatus end,
	drvPinNo = '',
	drvSmoker = case eepissmoker
					when 'N' then 'N'
					when 'Y' then 'T'
					else 'U' end,
	drvEmail0 = '',--case when @exportcode = 'ETEST' then  '' else substring(eepaddressemail,1,34) end,--item 20
	drvEmail1 = '',		--'x@x.com',
	drvEmail1Type = case when supemail is not null then '1' else '' end,--case when @exportcode = 'ETEST' and supemail is not null then '1' else '' end,	--'2',--1 for supervisor if supervisor email is present
	drvEmail2 = '',		--'x@x.com',
	drvEmail2Type = '2',--case when @exportcode = 'ETEST' then '2' else '' end,--'',	--case when @exportcode = 'ETEST' then '2' else '' end,
	drvAdd1 = eepaddressline1,
	drvAdd2 = eepaddressline2,
	drvCity = eepaddresscity,
	drvState = eepaddressstate,
	drvZIP = eepaddresszipcode,
	drvCountry = '',
	drvCountryCode = 'US',
	drvResidenceState = eepaddressstate,
	drvProvince = '',
	drvTypeOfAddr = 'R',
	drvAddressDate = '',
	drvPhone = '',		--eepphonehomenumber,
	drvPhoneType = '',	--'R',
	drvEmpStatus = case eecemplstatus
					when 'A' then 'AC'
					when 'L' then 'L1'
					when 'T' then 'TE'
					else '' end,
	drvStatusDate = case when eecemplstatus = 'T' then eecdateoftermination else eecemplstatusstartdate end,--eecdateoftermination is status = 'T'
	drvEmpType = 'P',			--case when eeceetype = 'REG' then 'P' else '' end,
	drvHireDate = eecdateoflasthire,
	drvServiceDate = eecdateofseniority,
	drvWorkLoc = '',
	drvAnnSalary = eecannsalary * 100,
	drvDisEarningsMode = 'A',
	drvDisEarnings = eecannsalary * 100,
	drvEarningsChgDate = '',
	drvSalryInd = case when eecsalaryorhourly = 'S' then 'Y' else 'N' end,
	drvFT = case when eecfulltimeorparttime = 'F' then 'Y' else 'N' end,
	drvBonusInd = '',
	drvWFHInd = '',
	drvExempt = '',
	drvHrsWeek = convert(char(20),convert(numeric(12,2),eecScheduledAnnualHrs / 52) * 100),
	drvTaxState = eepaddressstate,	--'R',
	drvOccupationCode = '',
	drvJobDesc = '',	--jbcdesc,
	drvJobCode = '',	--eecjobcode,
	drvOrgName = '',	--'Washington Dental',
	drvOrgCode = '',
	drvLocCode = '',
	drvUnionNo = '',
	drvUnionName = '',
	drvUnionInd = '',	--'N',
	drvHealthPlanType = '',	--'U',
	drvHealthPlanDesc = '',
	drvAccruedSickTime = '',
	drvKeyEmp = case when isnull(keyeeid,'') = '' then 'N' else 'Y' end,--eeciskeyemployee,
	drvAccrualAnnHrs = ehrs,--ehrs,	 --GJaffe 4/1/15  added the annual hours	--don't have 12 months of data
--	drvAccrualAnnHrs = SUM(isnull(PehCurHrs,0.00)) from
--where PehEEID='8YEY4U0011G0' and pehearncode='reg' and PehPayDate between '2014-04-01' and '2015-04-01' --pehcurhrs) BETWEEN DATEADD(month, -12, '2015-04-01') and '2015-04-01'
	
	drvWorkState = eecWCState,
	drvMaintReason = '',
	drvMaintDate = '',
	drvSpouseSSN = '',		--case when S.Slife = '1' then conssn else '' end,
	drvSNameLast = '',		--case when S.Slife = '1' then connamelast else '' end,
	drvSNameFirst = '',		--case when S.Slife = '1' then connamefirst else '' end,
	drvSNameMiddle = '',		--case when S.Slife = '1' then connamemiddle else '' end,
	drvSPrefix = '',
	drvSSuffix = '',
	drvSDOB = '',		--case when S.Slife = '1' then condateofbirth else null end,
	drvSGender = '',		--case when S.Slife = '1' then congender else '' end,
	drvSSmoker = '',		--case when S.Slife = '1' then
					--case when conissmoker = 'Y' then 'T' else 'N' end
				--else '' end,
--disability loops
--Start
	drvNumberofDisProducts = '03',
	drvDisCovCode1 = ltd.code,
	drvPolicySymbol1 = ltd.symbol,
	drvPolicyNumber1 = ltd.policy,
	drvProvEffDate1 = ltd.startd,
	drvBenPct1 = ltd.benpct,
	drvBenAmt1 = ltd.benamt,
	drvEmpContrPct1 = ltd.eepct,
	drvEffDate1 = '',
	drvPostTaxInd1 = ltd.post,
	drvBenDesc1 = '',
--
	drvDisCovCode2 = 'STD',--std.code,
	drvPolicySymbol2 = 'LK',--std.symbol,
	drvPolicyNumber2 = '0751124',--std.policy,
	drvProvEffDate2 = eecdateofbenefitseniority,--std.startd,
	drvBenPct2 = '06667',--std.benpct,
	drvBenAmt2 = '',--std.benamt,
	drvEmpContrPct2 = '00000',--std.eepct,
	drvEffDate2 = '',
	drvPostTaxInd2 = 'N',--std.post,
	drvBenDesc2 = '',
--
	drvDisCovCode3 = fmla.code,
	drvPolicySymbol3 = fmla.symbol,
	drvPolicyNumber3 = fmla.policy,
	drvProvEffDate3 = null,		--fmla.startd,
	drvBenPct3 = fmla.benpct,
	drvBenAmt3 = fmla.benamt,
	drvEmpContrPct3 = fmla.eepct,
	drvEffDate3 = '',
	drvPostTaxInd3 = fmla.post,
	drvBenDesc3 = '',
--End Remove : MML
--
	drvDisCovCode4 = '',
	drvPolicySymbol4 = '',
	drvPolicyNumber4 = '',
	drvProvEffDate4 = '',
	drvBenPct4 = '',
	drvBenAmt4 = '',
	drvEmpContrPct4 = '',
	drvEffDate4 = '',
	drvPostTaxInd4 = '',
	drvBenDesc4 = '',
--life loops
	drvNumberofLifeProds = '',--case when isnull(coalesce(vlif.code,vlifs.code,vlifc.code),'') ='' then '' else '01' end,
	drvLProdCode1 = '',--coalesce(vlif.symbol,vlifs.symbol,vlifc.symbol),	--lif.code,
	drvLPolicySymbol1 = '',--coalesce(vlif.code,vlifs.code,vlifc.code),	--lif.symbol,
	drvLPolicyNumber1 = '',--coalesce(vlif.policy,vlifs.policy,vlifc.policy),	--lif.policy,
	drvLAssignmentInd1 = '',
	drvEmpPrevAmt1 = '',
	drvEmpPrevSalMultiple1 = '',
	drvSpousePrevAmt1 = '',
	drvChildPrevAmt1 = '',
	drvEmpIssuedAmt1 = '',--cast(vlif.benamt as varchar), 
	drvEmpIssuedSalMult1 = '',	--lif.mult,
	drvSpouseIssuedAmt1 = '',--cast(vlifs.benamt as varchar),
	drvChildIssuedAmt1 = '',--cast(vlifc.benamt as varchar),
	drvEmpAppliedAmt1 = '',
	drvEmpAppliedSalMult1 = '',
	drvSpouseAppliedAmt1 = '',
	drvChildAppliedAmt1 = '',
	drvEmpPendingAmt1 = '',
	drvEmpPendingSalMult1 = '',
	drvSpousePendingAmt1 = '',
	drvChildPendingAmt1 = '',
	drvEmpMontlyCashAccumFundAmt1 = '',
	drvSpouseMoCashAccumFundAmt1 = '',
	drvEmpAIOInd1 = '',
	drvEmpADDADBInd1 = '',
	drvSpouseADDADBInd1 = '',
	drvEmpAPBInd1 = '',
	drvSpouseAPBInd1 = '',
	drvPAIPlanOpt1 = '',
--
	drvLProdCode2 = '',--vlif.symbol,
	drvLPolicySymbol2 = '',--vlif.code,
	drvLPolicyNumber2 = '',--vlif.policy,
	drvLAssignmentInd2 = '',
	drvEmpPrevAmt2 = '',
	drvEmpPrevSalMultiple2 = '',
	drvSpousePrevAmt2 = '',
	drvChildPrevAmt2 = '',
	drvEmpIssuedAmt2 = '',
	drvEmpIssuedSalMult2 = '',--vlif.mult,
	drvSpouseIssuedAmt2 = '',
	drvChildIssuedAmt2 = '',
	drvEmpAppliedAmt2 = '',
	drvEmpAppliedSalMult2 = '',
	drvSpouseAppliedAmt2 = '',
	drvChildAppliedAmt2 = '',
	drvEmpPendingAmt2 = '',
	drvEmpPendingSalMult2 = '',
	drvSpousePendingAmt2 = '',
	drvChildPendingAmt2 = '',
	drvEmpMontlyCashAccumFundAmt2 = '',
	drvSpouseMoCashAccumFundAmt2 = '',
	drvEmpAIOInd2 = '',
	drvEmpADDADBInd2 = '',
	drvSpouseADDADBInd2 = '',
	drvEmpAPBInd2 = '',
	drvSpouseAPBInd2 = '',
	drvPAIPlanOpt2 = '',
--
	drvLProdCode3 = '',	--dd.code,
	drvLPolicySymbol3 = '',	--dd.symbol,
	drvLPolicyNumber3 = '',	--dd.policy,
	drvLAssignmentInd3 = '',
	drvEmpPrevAmt3 = '',
	drvEmpPrevSalMultiple3 = '',
	drvSpousePrevAmt3 = '',
	drvChildPrevAmt3 = '',
	drvEmpIssuedAmt3 = '',
	drvEmpIssuedSalMult3 = '',
	drvSpouseIssuedAmt3 = '',
	drvChildIssuedAmt3 = '',
	drvEmpAppliedAmt3 = '',
	drvEmpAppliedSalMult3 = '',
	drvSpouseAppliedAmt3 = '',
	drvChildAppliedAmt3 = '',
	drvEmpPendingAmt3 = '',
	drvEmpPendingSalMult3 = '',
	drvSpousePendingAmt3 = '',
	drvChildPendingAmt3 = '',
	drvEmpMontlyCashAccumFundAmt3 = '',
	drvSpouseMoCashAccumFundAmt3 = '',
	drvEmpAIOInd3 = '',
	drvEmpADDADBInd3 = '',
	drvSpouseADDADBInd3 = '',
	drvEmpAPBInd3 = '',
	drvSpouseAPBInd3 = '',
	drvPAIPlanOpt3 = '',
--
	drvLProdCode4 = '',	--vadd.code,
	drvLPolicySymbol4 = '',	--vadd.symbol,
	drvLPolicyNumber4 = '',	--vadd.policy,
	drvLAssignmentInd4 = '',
	drvEmpPrevAmt4 = '',
	drvEmpPrevSalMultiple4 = '',
	drvSpousePrevAmt4 = '',
	drvChildPrevAmt4 = '',
	drvEmpIssuedAmt4 = '',
	drvEmpIssuedSalMult4 = '',
	drvSpouseIssuedAmt4 = '',
	drvChildIssuedAmt4 = '',
	drvEmpAppliedAmt4 = '',
	drvEmpAppliedSalMult4 = '',
	drvSpouseAppliedAmt14 = '',
	drvChildAppliedAmt4 = '',
	drvEmpPendingAmt4 = '',
	drvEmpPendingSalMult4 = '',
	drvSpousePendingAmt4 = '',
	drvChildPendingAmt4 = '',
	drvEmpMontlyCashAccumFundAmt4 = '',
	drvSpouseMoCashAccumFundAmt4 = '',
	drvEmpAIOInd4 = '',
	drvEmpADDADBInd4 = '',
	drvSpouseADDADBInd4 = '',
	drvEmpAPBInd4 = '',
	drvSpouseAPBInd4 = '',
	drvPAIPlanOpt4 = '',
--
	drvLProdCode5 = '',
	drvLPolicySymbol5 = '',
	drvLPolicyNumber5 = '',
	drvLAssignmentInd5 = '',
	drvEmpPrevAmt5 = '',
	drvEmpPrevSalMultiple5 = '',
	drvSpousePrevAmt5 = '',
	drvChildPrevAmt5 = '',
	drvEmpIssuedAmt5 = '',
	drvEmpIssuedSalMult5 = '',
	drvSpouseIssuedAmt5 = '',
	drvChildIssuedAmt5 = '',
	drvEmpAppliedAmt5 = '',
	drvEmpAppliedSalMult5 = '',
	drvSpouseAppliedAmt5 = '',
	drvChildAppliedAmt5 = '',
	drvEmpPendingAmt5 = '',
	drvEmpPendingSalMult5 = '',
	drvSpousePendingAmt5 = '',
	drvChildPendingAmt5 = '',
	drvEmpMontlyCashAccumFundAmt5 = '',
	drvSpouseMoCashAccumFundAmt5 = '',
	drvEmpAIOInd5 = '',
	drvEmpADDADBInd5 = '',
	drvSpouseADDADBInd5 = '',
	drvEmpAPBInd5 = '',
	drvSpouseAPBInd5 = '',
	drvPAIPlanOpt5 = '',
	drvExtendedEmail = substring(eepaddressemail,1,50),--case when @exportcode = 'ETEST' then substring(eepaddressemail,1,50) else '' end,		--substring(eepaddressemail,35,50),substring(eepaddressemail,1,34),--move to 130, 50 characters
	drvExtendedEmail2 = 'Ultipro@deltadentalwa.com',--case when @exportcode = 'ETEST' then 'Ultipro@deltadentalwa.com' else '' end,
	drvExtendedEmail1 = case when supemail is not null then substring(supemail,1,50) else '' end--@exportcode = 'ETEST' and supemail is not null then substring(supemail,1,50) else '' end--''

  into dbo.U_dsi_ECIG3KWDEN_drvTbl
  from dbo.u_ECIG3KWDEN_eelist with (nolock)
	join empPers with (nolock) on xEEID = eepEEID
	join vw_int_EmpComp with (nolock) on xEEID = eecEEid and xCOID = eecCOID
	join company on eeccoid = cmpcoid
	left join contacts on coneeid = xeeid and conrelationship = 'SPS'
	left join jobcode on eecjobcode = jbcjobcode
	left join dbo.U_dsi_ECIG3KWDEN_EarnHist on eeeid = xeeid and xcoid = ecoid
	left join dbo.U_dsi_ECIG3KWDEN_KeyEmps on keyeeid = xeeid and xcoid = keycoid
--	left join (select eeceeid eeid, eeccoid coid, null depid, lchCode CovCode, lchCode PolicySymbol, '0750565' PolicyNo, '06667' BenPct,eecemplstatusstartdate StartDate,'000000000' BenAmt,'000000' EEAmt, 'N' PT
--		from vw_int_EmpComp
--		left join emphstat on esheeid = eeceeid and eshemplstatus = 'L'
--		join loareasn on lchcode = eshemplstatusreason and eshstatusstartdate = eecemplstatusstartdate	--and lchtype = 'MED'
--		where eecemplstatus = 'L') LOA on loa.eeid = xeeid and loa.coid = xcoid

    left join (select eedeeid eeid, eedcoid coid, 'LTD' code, 'LK' Symbol, '0963232' Policy, min(eedBenStartDate) StartD,min(eedBenStopDate) StopD, '06667' benpct, '' benamt, '06667' eepct, 'N' post
		from dbo.U_dsi_bdm_EmpDeductions
		where EedFormatCode = @FormatCode
		and EedValidForExport = 'Y'
		and eeddedcode in ('LTD','ELTD') group by eedeeid,eedcoid) LTD on ltd.eeid = xeeid and ltd.coid = xcoid

--    left join (select eedeeid eeid, eedcoid coid, 'STD' code, 'LK' Symbol, '0751124' Policy, min(eedBenStartDate) StartD,min(eedBenStopDate) StopD, '06667' benpct, '' benamt, '00000' eepct, 'N' post
--		from dbo.U_dsi_bdm_EmpDeductions
--		where EedFormatCode = @FormatCode
--		and EedValidForExport = 'Y'
--		and eeddedcode in ('STD')group by eedeeid,eedcoid) STD on std.eeid = xeeid and std.coid = xcoid

    left join (select eedeeid eeid, eedcoid coid, 'FMLA' code, 'FML' Symbol, '0751124' Policy, min(eedBenStartDate) StartD,min(eedBenStopDate) StopD, '00000' benpct, '' benamt, '00000' eepct, 'N' post
		from dbo.U_dsi_bdm_EmpDeductions
		where EedFormatCode = @FormatCode
		and EedValidForExport = 'Y'
		and eeddedcode in ('LTD','ELTD','STD')group by eedeeid,eedcoid) fmla on fmla.eeid = xeeid and fmla.coid = xcoid

    left join (select eedeeid eeid, eedcoid coid, 'xxxx' code, 'AF' Symbol, 'nnnnnn' Policy, min(eedBenStartDate) StartD,min(eedBenStopDate) StopD, '00000' benpct, '' benamt, '00000' eepct, 'N' post
		from dbo.U_dsi_bdm_EmpDeductions
		where EedFormatCode = @FormatCode
		and EedValidForExport = 'Y'
		and eeddedcode in ('GLIFE') group by eedeeid,eedcoid) lif on lif.eeid = xeeid and lif.coid = xcoid

    left join (select eedeeid eeid, eedcoid coid, 'FLX' code, 'AC' Symbol, '964596' Policy, min(eedBenStartDate) StartD,min(eedBenStopDate) StopD, '00000' benpct, eedbenamt benamt, '00000' eepct, 'N' post
		from dbo.U_dsi_bdm_EmpDeductions
		where EedFormatCode = @FormatCode
		and EedValidForExport = 'Y'
		and eeddedcode in ('LIFEE')group by eedeeid,eedcoid,eedbenamt) vlif on vlif.eeid = xeeid and vlif.coid = xcoid

	left join (select eedeeid eeid, eedcoid coid, 'FLX' code, 'AC' Symbol, '964596' Policy, min(eedBenStartDate) StartD,min(eedBenStopDate) StopD, '00000' benpct, eedbenamt benamt, '00000' eepct, 'N' post
		from dbo.U_dsi_bdm_EmpDeductions
		where EedFormatCode = @FormatCode
		and EedValidForExport = 'Y'
		and eeddedcode in ('LIFES')group by eedeeid,eedcoid,eedbenamt) vlifs on vlifs.eeid = xeeid and vlifs.coid = xcoid

	left join (select eedeeid eeid, eedcoid coid, 'FLX' code, 'AC' Symbol, '964596' Policy, min(eedBenStartDate) StartD,min(eedBenStopDate) StopD, '00000' benpct, eedbenamt benamt, '00000' eepct, 'N' post
		from dbo.U_dsi_bdm_EmpDeductions
		where EedFormatCode = @FormatCode
		and EedValidForExport = 'Y'
		and eeddedcode in ('LIFEC')group by eedeeid,eedcoid,eedbenamt) vlifc on vlifc.eeid = xeeid and vlifc.coid = xcoid

    left join (select eedeeid eeid, eedcoid coid, '' code, 'BAD' Symbol, 'nnnnnn' Policy, min(eedBenStartDate) StartD,min(eedBenStopDate) StopD, '00000' benpct, '' benamt, '00000' eepct, 'N' post
		from dbo.U_dsi_bdm_EmpDeductions
		where EedFormatCode = @FormatCode
		and EedValidForExport = 'Y'
		and eeddedcode in  ('GADD')group by eedeeid,eedcoid ) dd on dd.eeid = xeeid and dd.coid = xcoid

    left join (select eedeeid eeid, eedcoid coid, '' code, 'ADD' Symbol, 'nnnnnn' Policy, min(eedBenStartDate) StartD,min(eedBenStopDate) StopD, '00000' benpct, '' benamt, '00000' eepct, 'N' post
		from dbo.U_dsi_bdm_EmpDeductions
		where EedFormatCode = @FormatCode
		and EedValidForExport = 'Y'
		and eeddedcode in  ('VADD')group by eedeeid,eedcoid) vadd on vadd.eeid = xeeid and vadd.coid = xcoid

	left join (select eeceeid supeeid,  eeccoid supcoid, eepnamelast supnamelast, eepnamefirst supnamefirst, eecemplstatus supstatus, 
		eepaddressemail supemail
		from vw_int_EmpComp
		join emppers on eepeeid = eecsupervisorid
		and eecemplstatus <> 'T'
		) sup on supeeid = eeceeid



--  where deddepid is null







-- delete deductions from employee when not used such in domestic partner codes

--delete from U_dsi_ECIG3KWDEN_drvTbl 
--where drvdepid is null and drvdedcode = 'YYYY'

	


      
-- Create Headers

if object_id('U_dsi_ECIG3KWDEN_hdrTbl') is not null
  drop table dbo.U_dsi_ECIG3KWDEN_hdrTbl

SELECT
	drvRecId = 'HD',
	drvDUNS = '075732446',
	drvProdOrTest = case when @exportcode like '%TEST%' then 'T' else 'P' end,
	drvDate = getdate(),
	drvCoName = 'Washington Dental Service',
	drvFileType = '2',
	drvLifeReason = '',
	drvDisReason = '2'

into dbo.U_dsi_ECIG3KWDEN_hdrTbl



-- Create Trailers

if object_id('U_dsi_ECIG3KWDEN_trlTbl') is not null
  drop table dbo.U_dsi_ECIG3KWDEN_trlTbl

SELECT
	drvTrlInd = 'TR',
	drvDUNSNoTrl = '075732446',
	drvRecCount = cnt.dtlcount		--+ 2	-- no header and trailer

into dbo.U_dsi_ECIG3KWDEN_trlTbl
from (select count(*) dtlcount from dbo.U_dsi_ECIG3KWDEN_drvTbl) cnt




-- Set FileName  
if (dbo.dsi_fnVariable('ECIG3KWDEN','UseFileName') = 'N')
  update dbo.U_dsi_Parameters
	set ExportFile =  'WashingtonDen_CIGNA_' + convert(char(8),getdate(),112) + '.txt'
	where FormatCode = 'ECIG3KWDEN'


-- Remember to alter view for correct sorting
/*
 ALTER  View dbo.dsi_vwECIG3KWDEN_Export as
        select top 2000000 Data from dbo.U_ECIG3KWDEN_File with (nolock)
         order by substring(Recordset,2,2), initialsort, subsort
*/



--Used for testing
--dbo.dsi_sp_TestSwitchbox_v2 'ECIG3KWDEN','ECIG3KWDEN'
--dbo.dsi_sp_TestSwitchbox_v2 'ECIG3KWDEN','ETEST'
--select * from U_dsi_parameters where formatcode =  'ECIG3KWDEN'
--dbo.dsi_sp_TestSwitchbox 'ECIG3KWDEN','zap'

END







