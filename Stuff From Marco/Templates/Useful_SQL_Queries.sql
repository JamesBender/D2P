
-- MASTER COMPANY ORG LEVELS
select 'COMPMAST' as 'TABLE', 
CmmCoID, CmmCompanyCode, 
CmmCompanyName, CmmCompanyDBAName, CmmFedtaxId, 
CmmEmpNoSize, CmmUniqueEmpnoRule, 
CmmOrgLvl1Label, CmmOrgLvl1LabelAbbr, CmmOrgLvl1Length,
CmmOrgLvl2Label, CmmOrgLvl2LabelAbbr, CmmOrgLvl2Length,
CmmOrgLvl3Label, CmmOrgLvl3LabelAbbr, CmmOrgLvl3Length,
CmmOrgLvl4Label, CmmOrgLvl4LabelAbbr, CmmOrgLvl4Length
from compmast (nolock)

-- COMPONENT COMPANIES

select 'COMPANY' as 'TABLE', 
cmpcoid, cmpcompanycode, 
cmpcompanyname, CmpFedTaxID
from company (nolock)

-- ORGANIZATION LEVELS
select 'ORGLVL'as 'TABLE', 
Orglvl, orgcode, Orgdesc, OrgStatus 
from orglevel (nolock)
order by 1, 2

-- BANK
select 'BANK' as 'TABLE',
bnkInstitution, bnkBankName, bnkCoBankID, bnkBankAcctNo, bnkBankRoutingNo
from bank (nolock)
order by bnkInstitution, bnkCoBankID

-- DEDUCTION BEN GROUPS
select 'DEDBENGRP' as 'TABLE',
CbpBenGroupCode, CbgBenGroupDesc, DedDedCode,DedDedType, DedLongDesc, DedCountryCode
from Benprog left join DedCode
on CbpDedCode = DedDedCode
left join bengrp
on CbpBenGroupCode = CbgBenGroupCode
order by CbpBenGroupCode, DedDedType, DedDedCode


-- DEDUCTIONS
select 'DEDDEDCODE'as 'TABLE',
deddedcode, dedlongdesc, 
deddedtype, dedtaxcategory, 
dedeecalcrule,coddesc, dedercalcrule, DedEEUseEERule,DedEEUseEERate,DedERUseEERule, DedERUseEERate, dedisbenefit,
DedBenPlanAdmin, DedBenPlanProvider, DedDedEffStopDate, DedIsCobraCovered,
dedIsHCE, DedIsPlanOfferMinVal, DedIsPlanFullyInsured, DedEESharePrem,
DedEEOfferedCov, DedSpouseOfferedCov, DedDepOfferedCov, DedCanBeOfferedUnderPPACA, DedABHealthCare
from dedcode (nolock)
join codes on dedeecalcrule=codcode
where codtable='DEDEECALCRULE'
order by 3,1

-- DEDUCTIONS WITH BENEFIT OPTIONS
select 'OPTRATETABLE'as 'TABLE', 
cordedcode, dedlongdesc, 
corbenoption, bnodescription, Corpayfreq
from optrate (nolock)
join dedcode on cordedcode = deddedcode
join benopt on corbenoption=bnocode
order by cordedcode, corbenoption, corpayfreq

-- BENEFIT DEDUCTION RATES
select  'AGERATEDTABLE' as 'TABLE', deddedcode, RatEERateNSFemale, 
RatEERateNSMale,RatEERateSMFemale,RatEERateSMMale, RatERRateNSFemale, RatERRateNSMale, RatERRateSMFemale, RatERRateSMMale, rateffdate, ratstopdate, RatMaxAge,RatMinAge,ratpayfreq
from  InsRate left join dedcode on dedDedCode = De
where rateffdate <= getdate() 
       and (ratstopdate is null 
       or   ratstopdate >= getdate()) 

-- BENEFIT OPTIONS
select 'BENOPT'as 'TABLE', * 
from benopt (nolock)

-- BENEFIT CHANGE REASONS
select 'BENCHRSN'as 'TABLE',
BchCode, BchDesc, 
BchIsCOBRAQualifiedEvent, BchSystem, BchUserHasChanged 
from benchrsn (nolock)
order by 1

-- RELATIONSHIP CODES
select codtable, codcode, coddesc
from codes (nolock)
where codtable='RELATION'

--Providers-Payees
select 'PAYEE'as 'TABLE',
ProProviderCode, ProCompanyName, ProIsPayee, 
ProContactName, ProAddressLine1, ProAddressLine2, 
ProAddressCity, ProAddressState, ProAddressZipCode
from provider (nolock)
where proispayee='Y'

--EARNINGS Groups
select 'EARNGRP'as 'TABLE',
CegEarnGroupCode, CegEarnGroupDesc
from earngrp

-- EARNINGS
select 'EARNCODE'as 'TABLE', ErnEarncode, ernlongdesc, 
erntaxcategory, erncalcrule, CodDesc, ErnInclInHealthCareHours, ErnIsProductiveTime, ErnInclInPensionAccum
from earncode (nolock)
join codes on erncalcrule=codcode
where codtable='earncalcrule'


    -- Update UD Fields in BDM Table with EOI Desired Amount and EOI Flag
    UPDATE BDM
        SET BDM.EedUSGField1 = CONVERT(MONEY,ED.EedEOIDesiredAmt)
            ,BDM.EedUSGField2 = 'Y'
    FROM dbo.U_dsi_BDM_EmpDeductions BDM
    JOIN dbo.EmpDedFull ED 
              ON ED.EedEmpDedTVID = BDM.EedEmpDedTVID
    WHERE ED.EedNeedEOI = 'Y'
              AND BDM.EedFormatCode = @FormatCode
              AND BDM.EedValidForExport = 'Y';


-- JOB CHANGE REASONS
select 'JOBCHRSN'as 'TABLE',
JchCode, JchDesc, 
JchSystem, JchUserHasChanged 
from jobchrsn (nolock)
order by 


-- TERMINATION REASONS
select 'TRMREASN'as 'TABLE',
tchcode, tchdesc, tchtype, tchsystem, tchuserhaschanged
from trmreasn (nolock)
order by 3, 1

--LOA REASONS
select 'LOAREASN'as 'TABLE', * 
from loareasn

-- LOCATIONS
select 'LOCATION'as 'TABLE',
loccode, locdesc, 
locaddressstate
from location (nolock)
order by 1

-- PAYGROUPS
select 'PAYGROUP'as 'TABLE', 
pgrpaygroup, PgrDesc, 
PgrPayFrequency, PgrSchedHrs, PgrStatus
from paygroup (nolock)

-- EMPTYPE
select codtable, codcode, coddesc, codsystem
from codes (nolock)
where codtable='EMPTYPE'

-- USER DEFINED FIELDS
select codtable, codcode, coddesc
from codes (nolock)
where codtable='EEUSERDEFINEDFIELDS'

-- JOBS
select 'JOBCODE'as 'TABLE',
JbcStatus, JbcJobCode, JbcDesc, 
JbcEEOCategory, JbcEEOGroup, JbcFLSAType, 
JbcIsSupervisor, JbcJobFamily, JbcSalaryOrHourly 
from jobcode (nolock)
order by 1 desc, 2

-- PROJECT
Select 'PROJECT' as 'TABLE', 
CodCode, CodDesc from Project


--TAX GROUP
select 'TAXGROUP'as 'TABLE', 
TgrTaxCalcGroupID,TgrTaxCalcGroupDesc,TgrTaxCalcGrpRptID, cmpcompanyname
from taxgroup (nolock)
join company on TgrTaxCalcGrpRptID=cmpcoid

--TAX Codes
select 'TAXCODE'as 'TABLE', 
ctccoid, cmpcompanycode, ctctaxcode, 
CtcTaxCodeDesc, CtcTypeOfTax, ctclocaltype
from taxcode
join company on cmpcoid=ctccoid
order by cmpcompanycode, CtcTypeOfTax, ctctaxcode

-- MARITAL STATUS
select 'MARITALSTATUS' as 'TABLE',
codtable, codcode, coddesc
from codes (nolock)
where codtable='maritalstatus'
